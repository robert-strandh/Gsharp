(in-package :score-pane)

(defclass score-view (view) ())  

(defclass score-pane (esa-pane-mixin application-pane)
  ((darker-gray-progressions :initform (make-array 10 :initial-element nil :adjustable t)
			     :reader darker-gray-progressions)
   (lighter-gray-progressions :initform (make-array 10 :initial-element nil :adjustable t)
			      :reader lighter-gray-progressions)))

(defmethod initialize-instance :after ((pane score-pane) &rest args)
  (declare (ignore args))
  (setf (stream-default-view pane) (make-instance 'score-view)))

(defparameter *pane* nil)
(defparameter *light-glyph* nil)
(defparameter *font* nil)
(defparameter *fonts* (make-array 100 :initial-element nil))

;;; Map integer levels of white, represented by the number of white pixels in 
;;; a 4x4 pixel grid, to CLIM inks. 
(defparameter *gray-levels*
  (loop with result = (make-array '(17))
	for i from 0 to 16 do
	(setf (aref result i) (make-gray-color (/ i 16)))
	finally (return result)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; output recording

(defclass score-output-record (displayed-output-record)
  ((parent :initarg :parent :initform nil :accessor output-record-parent)
   (x :initarg :x1 :initarg :x-position)
   (y :initarg :y1 :initarg :y-position)
   (width)
   (height)
   (ink :initarg :ink :reader displayed-output-record-ink)))

(defmethod initialize-instance :after ((record score-output-record)
				       &key x2 y2 size)
  (declare (ignore size))
  (with-slots (x y width height) record
    (setf width (abs (- x2 x))
	  height (abs (- y2 y)))))

(defmethod bounding-rectangle* ((record score-output-record))
  (with-slots (x y width height) record
    (values x y (+ x width) (+ y height))))

(defmethod output-record-position ((record score-output-record))
  (with-slots (x y) record
    (values x y)))

(defmethod (setf output-record-position) (new-x new-y (record score-output-record))
  (with-slots (x y) record
    (setf x new-x y new-y)))

(defmethod output-record-start-cursor-position ((record score-output-record))
  (values nil nil))

(defmethod (setf output-record-start-cursor-position) (x y (record score-output-record))
  (declare (ignore x y))
  nil)

(defmethod output-record-end-cursor-position ((record score-output-record))
  (values nil nil))

(defmethod (setf output-record-end-cursor-position) (x y (record score-output-record))
  (declare (ignore x y))
  nil)

(defmethod output-record-hit-detection-rectangle* ((record score-output-record))
  (bounding-rectangle* record))

(defmethod output-record-refined-position-test  ((record score-output-record) x y)
  (declare (ignore x y))
  t)

;;; remove this when McCLIM is fixed
(defmethod region-intersects-region-p (region (record score-output-record))
  (with-bounding-rectangle* (x1 y1 x2 y2) record
    (region-intersects-region-p region (make-rectangle* x1 y1 x2 y2))))

;;;;;;;;;;;;;;;;;; pixmap drawing

(climi::def-grecording draw-pixmap (() pixmap pm-x pm-y) ()
  (climi::with-transformed-position ((medium-transformation medium) pm-x pm-y)
    (setf (slot-value climi::graphic 'pm-x) pm-x
	  (slot-value climi::graphic 'pm-y) pm-y)
    (values pm-x pm-y (+ pm-x (pixmap-width pixmap)) (+ pm-y (pixmap-height pixmap)))))

(climi::def-graphic-op draw-pixmap (pixmap pm-x pm-y))

(defmethod medium-draw-pixmap* ((medium clim:medium) pixmap pm-x pm-y)
  (copy-from-pixmap pixmap 0 0 (pixmap-width pixmap) (pixmap-height pixmap)
		    medium pm-x pm-y))

(climi::defmethod* (setf output-record-position) :around
    (nx ny (record draw-pixmap-output-record))
    (climi::with-standard-rectangle* (:x1 x1 :y1 y1)
	record
      (with-slots (pm-x pm-y)
	  record
	(let ((dx (- nx x1))
	      (dy (- ny y1)))
	  (multiple-value-prog1
	      (call-next-method)
	    (incf pm-x dx)
	    (incf pm-y dy))))))

(climi::defrecord-predicate draw-pixmap-output-record (pm-x pm-y)
  (and (climi::if-supplied (pm-x coordinate)
	 (climi::coordinate= (slot-value climi::record 'pm-x) pm-x))
       (climi::if-supplied (pm-y coordinate)
	 (climi::coordinate= (slot-value climi::record 'pm-y) pm-y))))

(defun draw-pixmap* (sheet pixmap x y
			   &rest args
			   &key clipping-region transformation)
  (declare (ignore clipping-region transformation))
  (climi::with-medium-options (sheet args)
    (medium-draw-pixmap* medium pixmap x y)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; drawing functions

;;; A staff step is half of the distance between two staff lines.
;;; Given a staff-step value, determine the corresponding number of
;;; pixels in the current font.  The sign of the value returned is 
;;; the same as that of the argument.
;;; But is that reasonable?  It seems more logical to have it return
;;; the opposite sign, so that the result from staff-step is always
;;; added to some y coordinate.
(defun staff-step (n)
  (* n (/ (staff-line-distance *font*) 2)))

;;;;;;;;;;;;;;;;;; notehead

(define-presentation-type notehead () :options (name x staff-step))

(defun draw-notehead (stream name x staff-step)
  (sdl::draw-shape stream *font* 
		   (ecase name
		     (:whole :whole-notehead)
		     (:half :half-notehead)
		     (:filled :filled-notehead))
		   x (staff-step (- staff-step))))

(define-presentation-method present
    (object (type notehead) stream (view score-view) &key)
  (with-output-as-presentation (stream object 'notehead)
    (draw-notehead stream name x staff-step)))

;;;;;;;;;;;;;;;;;; accidental

(defun draw-accidental (stream name x staff-step)
  (sdl::draw-shape stream *font* name x (staff-step (- staff-step))))

;;;;;;;;;;;;;;;;;; clef

(defun draw-clef (stream name x staff-step)
  (sdl::draw-shape stream *font* 
		   (ecase name
		     ;; FIXME: while using the same glyph for :TREBLE
		     ;; and :TREBLE8 is fine from a musical point of
		     ;; view, some differentiation (by putting an
		     ;; italic 8 underneath, for instance) would be
		     ;; good.
		     ((:treble :treble8) :g-clef)
		     (:bass :f-clef)
		     (:c :c-clef))
		   x (staff-step (- staff-step))))
		       
(define-presentation-type clef () :options (name x staff-step))

(define-presentation-method present
    (object (type clef) stream (view score-view) &key)
  (with-output-as-presentation (stream object 'clef)
    (draw-clef stream name x staff-step)))

;;;;;;;;;;;;;;;;;; rest

(defun draw-rest (stream duration x staff-step)
  (sdl::draw-shape stream *font*
                   (ecase duration
                     (1 :whole-rest)
                     (1/2 :half-rest)
                     (1/4 :quarter-rest)
                     (1/8 :8th-rest)
                     (1/16 :16th-rest)
                     (1/32 :32nd-rest)
                     (1/64 :64th-rest)
                     ;; FIXME 128th
                     )
                   x (staff-step (- staff-step))))

;;;;;;;;;;;;;;;;;; flags down

(defun draw-flags-down (stream nb x staff-step)
  (sdl::draw-shape stream *font*
                   (ecase nb
                     (1 :flags-down-1)
                     (2 :flags-down-2)
                     (3 :flags-down-3)
                     (4 :flags-down-4)
                     (5 :flags-down-5))
                   x (staff-step (- staff-step))))

;;;;;;;;;;;;;;;;;; flags up

(defun draw-flags-up (stream nb x staff-step)
  (sdl::draw-shape stream *font*
                   (ecase nb
                     (1 :flags-up-1)
                     (2 :flags-up-2)
                     (3 :flags-up-3)
                     (4 :flags-up-4)
                     (5 :flags-up-5))
                   x (staff-step (- staff-step))))

;;;;;;;;;;;;;;;;;; dot

(defun draw-dot (stream x staff-step)
  (sdl::draw-shape stream *font* :dot x (staff-step (- staff-step))))

;;;;;;;;;;;;;;;;;; staff line

(defun draw-staff-line (pane x1 staff-step x2)
  (multiple-value-bind (down up) (staff-line-offsets *font*)
    (let ((y1 (+ (- (staff-step staff-step)) up))
	  (y2 (+ (- (staff-step staff-step)) down)))
      (draw-rectangle* pane x1 y1 x2 y2))))

(defclass staff-output-record (output-record)
  ((parent :initarg :parent :initform nil :accessor output-record-parent)
   (x :initarg :x1 :initarg :x-position)
   (y :initarg :y1 :initarg :y-position)
   (width :initarg :width)
   (height :initarg height)
   (staff-lines :initform '() :reader output-record-children)))

(defmethod bounding-rectangle* ((record staff-output-record))
  (with-slots (x y width height) record
    (values x y (+ x width) (+ y height))))

(defmethod output-record-position ((record staff-output-record))
  (with-slots (x y) record
    (values x y)))

(defmethod (setf output-record-position) (new-x new-y (record staff-output-record))
  (with-slots (x y staff-lines) record
    (setf x new-x y new-y)
    (loop for staff-line in staff-lines
	  do (multiple-value-bind (xx yy) (output-record-position staff-line)
	       (setf (output-record-position staff-line)
		     (values (+ xx (- new-x x))
			     (+ yy (- new-y y))))))))  

(defmethod output-record-start-cursor-position ((record staff-output-record))
  (values nil nil))

(defmethod (setf output-record-start-cursor-position) (x y (record staff-output-record))
  (declare (ignore x y))
  nil)

(defmethod output-record-end-cursor-position ((record staff-output-record))
  (values nil nil))

(defmethod (setf output-record-end-cursor-position) (x y (record staff-output-record))
  (declare (ignore x y))
  nil)

(defmethod output-record-hit-detection-rectangle* ((record staff-output-record))
  (bounding-rectangle* record))

(defmethod output-record-refined-position-test  ((record staff-output-record) x y)
  (declare (ignore x y))
  t)

;;; remove this when McCLIM is fixed
(defmethod region-intersects-region-p (region (record staff-output-record))
  (with-bounding-rectangle* (x1 y1 x2 y2) record
    (region-intersects-region-p region (make-rectangle* x1 y1 x2 y2))))

(defmethod add-output-record (child (record staff-output-record))
  (push child (slot-value record 'children)))

(defmethod delete-output-record (child (record staff-output-record) &optional (errorp t))
  (with-slots (staff-lines) record
    (when (and errorp (not (member child staff-lines :test #'eq)))
      (error "not a child"))
    (setf staff-lines (delete child staff-lines :test #'eq))))

(defmethod clear-output-record ((record staff-output-record))
  (setf (slot-value record 'staff-lines) '()))

(defmethod output-record-count ((record staff-output-record))
  (length (slot-value record 'staff-lines)))

(defmethod replay-output-record ((record staff-output-record) stream
				 &optional (region +everywhere+)
				 (x-offset 0) (y-offset 0))
  (loop for staff-line in (slot-value record 'staff-lines)
	do (replay-output-record staff-line stream region x-offset y-offset)))

(define-presentation-type staff () :options (x1 x2))

(define-presentation-type fiveline-staff () :inherit-from 'staff :options (x1 x2))

(defun draw-fiveline-staff (pane x1 x2)
  (multiple-value-bind (left right) (bar-line-offsets *font*)
    (loop for staff-step from 0 by 2
	  repeat 5
	  do (draw-staff-line pane (+ x1 left) staff-step (+ x2 right)))))

(define-presentation-method present
    (object (type fiveline-staff) stream (view score-view) &key)
  (with-output-as-presentation (stream object 'fiveline-staff)
    (draw-fiveline-staff stream x1 x2)))

(define-presentation-type lyrics-staff () :inherit-from 'staff :options (x1 x2))

(defun draw-lyrics-staff (pane x1 x2)
  (declare (ignore x2))
  (multiple-value-bind (left right) (bar-line-offsets *font*)
    (declare (ignore right))
    (draw-text* pane "--" (+ x1 left) 0)))

(define-presentation-method present
    (object (type lyrics-staff) stream (view score-view) &key)
  (with-output-as-presentation (stream object 'lyrics-staff)
    (draw-lyrics-staff stream x1 x2)))

;;;;;;;;;;;;;;;;;; stem

(defun draw-stem (pane x y1 y2)
  (multiple-value-bind (left right) (stem-offsets *font*)
    (let ((x1 (+ x left))
	  (x2 (+ x right)))
      (draw-rectangle* pane x1 y1 x2 y2))))
			     
(defun draw-right-stem (pane x y1 y2)
  (multiple-value-bind (dx dy) (notehead-right-offsets *font*)
    (draw-stem pane (+ x dx) (- y1 dy) y2)))

(defun draw-left-stem (pane x y1 y2)
  (multiple-value-bind (dx dy) (notehead-left-offsets *font*)
    (draw-stem pane (+ x dx) (- y1 dy) y2)))

;;;;;;;;;;;;;;;;;; ledger line

(defun draw-ledger-line (pane x staff-step)
  (multiple-value-bind (down up) (ledger-line-y-offsets *font*)
    (multiple-value-bind (left right) (ledger-line-x-offsets *font*)
      (let ((x1 (+ x left))
	    (y1 (- (+ (staff-step staff-step) down)))
	    (x2 (+ x right))
	    (y2 (- (+ (staff-step staff-step) up))))
	(draw-rectangle* pane x1 y1 x2 y2)))))

			     
;;;;;;;;;;;;;;;;;; bar line

(defun draw-bar-line (pane x y1 y2)
  (multiple-value-bind (left right) (bar-line-offsets *font*)
    (let ((x1 (+ x left))
	  (x2 (+ x right)))
      (draw-rectangle* pane x1 y1 x2 y2))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; beam drawing

(defclass beam-output-record (score-output-record)
  ((light-glyph-p :initarg :light-glyph-p)
   (clipping-region :initarg :clipping-region)
   (thickness :initarg :thickness)))

;;; draw a horizontal beam around the vertical reference 
;;; point y.
(defun draw-horizontal-beam (medium x1 y x2)
  (multiple-value-bind (down up) (beam-offsets *font*)
    (draw-rectangle* medium x1 (+ y up) x2 (+ y down))))

(defvar *darker-gray-progressions*)
(defvar *lighter-gray-progressions*)

;;; don't delete this yet, since I don't know how the other one will work out. 
;; (defun ensure-gray-progressions (index)
;;   (unless (aref *darker-gray-progressions* index)
;;     (setf (aref *darker-gray-progressions* index)
;; 	  (with-output-to-pixmap (medium *pane* :height 1 :width index)
;; 	    (loop for i from 0 below index
;; 		  for gray-level from 16 by (- (/ 16 index)) do
;; 		  (draw-point* medium i 0 :ink (aref *gray-levels* (ceiling gray-level)))))))
;;   (unless (aref *lighter-gray-progressions* index)
;;     (setf (aref *lighter-gray-progressions* index)
;; 	  (with-output-to-pixmap (medium *pane* :height 1 :width index)
;; 	    (loop for i from 0 below index
;; 		  for gray-level from 0 by (/ 16 index) do
;; 		  (draw-point* medium i 0 :ink (aref *gray-levels* (floor gray-level))))))))

;;; this version should be faster for long beam segments. It is also
;;; more correct in its colors, but the visual impession is no better.
(defun ensure-gray-progressions (pane-medium index)
  (when (< (length *darker-gray-progressions*) (1+ index))
    (adjust-array *darker-gray-progressions* (1+ index) :initial-element nil))
  (unless (aref *darker-gray-progressions* index)
    (setf (aref *darker-gray-progressions* index)
	  (with-output-to-pixmap (medium (medium-sheet pane-medium) :height 1 :width index)
	    ;; start by filling it with black
	    (draw-rectangle* medium 0 0 index 1 :ink (aref *gray-levels* 0))
	    (loop for start = 0 then end
		  for end from (- (/ index 32) 1/2) by (/ index 16)
		  for gray-level from 16 above 0
		  do (unless (= start end)
		       (draw-rectangle* medium start 0 end 1
					:ink (aref *gray-levels* gray-level)))))))
  (when (< (length *lighter-gray-progressions*) (1+ index))
    (adjust-array *lighter-gray-progressions* (1+ index) :initial-element nil))
  (unless (aref *lighter-gray-progressions* index)
    (setf (aref *lighter-gray-progressions* index)
	  (with-output-to-pixmap (medium (medium-sheet pane-medium) :height 1 :width index)
	    ;; start by filling it with white
	    (draw-rectangle* medium 0 0 index 1 :ink (aref *gray-levels* 16))
	    (loop for start = 0 then end
		  for end from (- (/ index 32) 1/2) by (/ index 16)
		  for gray-level from 0 below 16
		  do (unless (= start end)
		       (draw-rectangle* medium start 0 end 1
					:ink (aref *gray-levels* gray-level))))))))

(defun draw-segment (medium x1 y x2 thickness progression1 progression2)
  ;; make it a bit thicker to cover either the upper or the lower pixmap
  (let ((extra (if *light-glyph* (- x2 x1) 0)))
    (medium-draw-rectangle* medium x1  y x2 (- y thickness) t)
    (ensure-gray-progressions medium (+ extra (- x2 x1)))
    (copy-from-pixmap (aref progression1 (+ extra (- x2 x1)))
		      (if (eq progression1 *lighter-gray-progressions*) extra 0)
		      0
		      (- x2 x1) 1
		      medium x1 y)
    (copy-from-pixmap (aref progression2 (+ extra (- x2 x1)))
		      (if (eq progression2 *lighter-gray-progressions*) extra 0)
		      0
		      (- x2 x1) 1
		      medium x1 (- y thickness))))

(defun draw-downward-beam-segment (medium x1 y x2 thickness)
  (draw-segment medium x1 (1+ y) x2 thickness
		*darker-gray-progressions* *lighter-gray-progressions*))

(defun draw-upward-beam-segment (medium x1 y x2 thickness)
  (draw-segment medium x1 y x2 thickness
		*lighter-gray-progressions* *darker-gray-progressions*))

(defun draw-downward-beam (medium x1 y1 y2 thickness inverse-slope)
  (loop for y from y1 below y2
	for x from x1 by inverse-slope do
	(draw-downward-beam-segment medium (round x) y
				  (round (+ x inverse-slope)) thickness)))

(defun draw-upward-beam (medium x1 y1 y2 thickness inverse-slope)
  (loop for y from y1 above y2
	for x from x1 by inverse-slope do
	(draw-upward-beam-segment medium (round x) y
				    (round (+ x inverse-slope)) thickness)))

(defclass downward-beam-output-record (beam-output-record)
  ())

(defun medium-draw-downward-beam* (medium x1 y1 x2 y2 thickness)
  (let ((inverse-slope (abs (/ (- x2 x1) (- y2 y1)))))
    (loop for y from y1 below y2
	  for x from x1 by inverse-slope do
	  (let ((upper (sdl::ensure-beam-segment-design :down :upper (- (round (+ x inverse-slope)) (round x))))
		(upper-tr (make-translation-transformation (round x) (1+ y))) ; don't know why the 1 is neccesary
		(lower (sdl::ensure-beam-segment-design :down :lower (- (round (+ x inverse-slope)) (round x))))
		(lower-tr (make-translation-transformation (round x) (+ y thickness 1)))) ; don't know why the 1 is neccesary
	    (climi::medium-draw-bezier-design* medium (transform-region upper-tr upper))
	    (climi::medium-draw-bezier-design* medium (transform-region lower-tr lower))
	    (medium-draw-rectangle* medium (round x) (1+ y) (round (+ x inverse-slope)) (+ y thickness) t)))))

(defun medium-draw-upward-beam* (medium x1 y1 x2 y2 thickness)
  (let ((inverse-slope (abs (/ (- x2 x1) (- y2 y1)))))
    (loop for y from y1 above y2
	  for x from x1 by inverse-slope do
	  (let ((upper (sdl::ensure-beam-segment-design :up :upper (- (round (+ x inverse-slope)) (round x))))
		(upper-tr (make-translation-transformation (round x) (1- y))) ; don't know why the -1 is necessary
		(lower (sdl::ensure-beam-segment-design :up :lower (- (round (+ x inverse-slope)) (round x))))
		(lower-tr (make-translation-transformation (round x) (+ y thickness)))) ; don't know why +1 is not neccesary
	    (climi::medium-draw-bezier-design* medium (transform-region upper-tr upper))
	    (climi::medium-draw-bezier-design* medium (transform-region lower-tr lower))
	    (medium-draw-rectangle* medium (round x) y (round (+ x inverse-slope)) (1- (+ y thickness)) t)))))

(defmethod replay-output-record ((record downward-beam-output-record) (stream score-pane)
				 &optional (region +everywhere+)
				 (x-offset 0) (y-offset 0))
  (declare (ignore x-offset y-offset region))
  (with-bounding-rectangle* (x1 y1 x2 y2) record
    (with-slots (thickness ink clipping-region) record
      (let ((medium (sheet-medium stream)))
	(with-drawing-options 
	    (medium :ink ink :clipping-region clipping-region)
	  (medium-draw-downward-beam* medium x1 y1 x2 (- y2 thickness) thickness))))))

(defclass upward-beam-output-record (beam-output-record)
  ())

(defmethod replay-output-record ((record upward-beam-output-record) (stream score-pane)
				 &optional (region +everywhere+)
				 (x-offset 0) (y-offset 0))
  (declare (ignore x-offset y-offset region))
  (with-bounding-rectangle* (x1 y1 x2 y2) record
    (with-slots (thickness ink clipping-region) record
      (let ((medium (sheet-medium stream)))
	(with-drawing-options 
	    (medium :ink ink :clipping-region clipping-region)
	  (medium-draw-upward-beam* medium x1 (- y2 thickness) x2 y1 thickness))))))

;;; draw a sloped beam.  The vertical reference points 
;;; of the two end points are indicated by y1 and y2. 
(defun draw-sloped-beam (medium x1 y1 x2 y2)
  (multiple-value-bind (down up) (beam-offsets *font*)
    (let ((transformation (medium-transformation *pane*))
	  (thickness (- down up)))
      (cond ((< y1 y2)
	     (when (stream-recording-p *pane*)
	       (multiple-value-bind (xx1 yy1)
		   (transform-position transformation x1 y1)
		 (multiple-value-bind (xx2 yy2)
		     (transform-position transformation x2 y2)
		   (stream-add-output-record
		    *pane* (make-instance 'downward-beam-output-record
					  :x1 xx1 :y1 (+ yy1 up) :x2 xx2 :y2 (+ yy2 down)
					  :thickness thickness :ink (medium-ink medium)
                                          :clipping-region (medium-clipping-region medium))))))
	     (when (stream-drawing-p *pane*)
	       (medium-draw-downward-beam* medium x1 (+ y1 up) x2 (+ y2 up) thickness)))
	    (t
	     (when (stream-recording-p *pane*)
	       (multiple-value-bind (xx1 yy1)
		   (transform-position transformation x1 y1)
		 (multiple-value-bind (xx2 yy2)
		     (transform-position transformation x2 y2)
		   (stream-add-output-record
		    *pane* (make-instance 'upward-beam-output-record
					  :x1 xx1 :y1 (+ yy2 up) :x2 xx2 :y2 (+ yy1 down)
					  :thickness thickness 
                                          :ink (medium-ink medium)
                                          :clipping-region (medium-clipping-region medium))))))
	     (when (stream-drawing-p *pane*)
	       (medium-draw-upward-beam* medium x1 (+ y1 up) x2 (+ y2 up) thickness)))))))

;;; an offset of -1 means hang, 0 means straddle and 1 means sit
(defun draw-beam (pane x1 staff-step-1 offset1 x2 staff-step-2 offset2)
  (if (> x1 x2)
      (draw-beam pane x2 staff-step-2 offset2 x1 staff-step-1 offset1)
      (multiple-value-bind (left right) (stem-offsets *font*)
	(let* ((xx1 (+ x1 left))
	       (xx2 (+ x2 right))
	       (offset (beam-hang-sit-offset *font*))
	       (y1 (- (+ (staff-step staff-step-1) (* offset1 offset))))
	       (y2 (- (+ (staff-step staff-step-2) (* offset2 offset))))
	       (medium (sheet-medium pane)))
	  (if (= y1 y2)
	      (draw-horizontal-beam pane xx1 y1 xx2)
	      (draw-sloped-beam medium xx1 y1 xx2 y2))))))

(defun draw-tie-up (pane x1 x2 staff-step)
  (let ((dist (/ (- x2 x1) (staff-step 4/3))))
    (if (> dist 19)
	(let ((xx1 (round (+ x1 (staff-step 10))))
	      (xx2 (round (- x2 (staff-step 10))))
	      (y1 (- (round (staff-step (+ staff-step 11/3)))))
	      (thickness (round (staff-step 2/3))))
          (sdl::draw-shape pane *font* :large-tie-up-left xx1 (staff-step (- staff-step)))
          (sdl::draw-shape pane *font* :large-tie-up-right xx2 (staff-step (- staff-step)))
	  (draw-rectangle* pane xx1 y1 xx2 (+ y1 thickness)))
	(let ((glyph-name (cond ((> dist 18) :large-tie-10-up)
                                ((> dist 17) :large-tie-9-up)
                                ((> dist 16) :large-tie-8-up)
                                ((> dist 15) :large-tie-7-up)
                                ((> dist 14) :large-tie-6-up)
                                ((> dist 13) :large-tie-5-up)
                                ((> dist 12) :large-tie-4-up)
                                ((> dist 11) :large-tie-3-up)
                                ((> dist 10) :large-tie-2-up)
                                ((> dist 9) :large-tie-1-up)
                                ((> dist 8) :small-tie-8-up)
                                ((> dist 7) :small-tie-7-up)
                                ((> dist 6) :small-tie-6-up)
                                ((> dist 5) :small-tie-5-up)
                                ((> dist 4) :small-tie-4-up)
                                ((> dist 3) :small-tie-3-up)
                                ((> dist 2) :small-tie-2-up)
                                (t :small-tie-1-up))))
	  (sdl::draw-shape pane *font* glyph-name 
                           (round (* 0.5 (+ x1 x2))) (staff-step (- staff-step)))))))

(defun draw-tie-down (pane x1 x2 staff-step)
  (let ((dist (/ (- x2 x1) (staff-step 4/3))))
    (if (> dist 19)
	(let ((xx1 (round (+ x1 (staff-step 10))))
	      (xx2 (round (- x2 (staff-step 10))))
	      (y1 (- (round (staff-step (- staff-step 8/3)))))
	      (thickness (round (staff-step 2/3))))
          (sdl::draw-shape pane *font* :large-tie-down-left xx1 (staff-step (- staff-step)))
          (sdl::draw-shape pane *font* :large-tie-down-right xx2 (staff-step (- staff-step)))
	  (draw-rectangle* pane xx1 y1 xx2 (+ y1 thickness)))
	(let ((glyph-name (cond ((> dist 18) :large-tie-10-down)
                                ((> dist 17) :large-tie-9-down)
                                ((> dist 16) :large-tie-8-down)
                                ((> dist 15) :large-tie-7-down)
                                ((> dist 14) :large-tie-6-down)
                                ((> dist 13) :large-tie-5-down)
                                ((> dist 12) :large-tie-4-down)
                                ((> dist 11) :large-tie-3-down)
                                ((> dist 10) :large-tie-2-down)
                                ((> dist 9) :large-tie-1-down)
                                ((> dist 8) :small-tie-8-down)
                                ((> dist 7) :small-tie-7-down)
                                ((> dist 6) :small-tie-6-down)
                                ((> dist 5) :small-tie-5-down)
                                ((> dist 4) :small-tie-4-down)
                                ((> dist 3) :small-tie-3-down)
                                ((> dist 2) :small-tie-2-down)
                                (t :small-tie-1-down))))
	  (sdl::draw-shape pane *font* glyph-name 
                           (round (* 0.5 (+ x1 x2))) (staff-step (- staff-step)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; convenience macros

(defmacro with-notehead-right-offsets ((right up) &body body)
  `(multiple-value-bind (,right ,up) (notehead-right-offsets *font*)
    ,@body))

(defmacro with-notehead-left-offsets ((left down) &body body)
  `(multiple-value-bind (,left ,down) (notehead-left-offsets *font*)
    ,@body))

(defmacro with-suspended-note-offset (offset &body body)
  `(let ((,offset (suspended-note-offset *font*)))
    ,@body))

(defmacro with-score-pane (pane &body body)
  `(let* ((*pane* ,pane)
	  (*lighter-gray-progressions* (lighter-gray-progressions pane))
	  (*darker-gray-progressions* (darker-gray-progressions pane)))
    (clear-output-record (stream-output-history *pane*))
    ,@body))

(defmacro with-vertical-score-position ((pane yref) &body body)
  `(with-translation (,pane 0 ,yref)
    ,@body))

(defmacro with-staff-size (size &body body)
  (let ((size-var (gensym)))
    `(let ((,size-var ,size))
      (unless (aref *fonts* ,size-var)
	(setf (aref *fonts* ,size-var)
	      (make-font ,size-var)))
      (let ((*font* (aref *fonts* ,size-var)))
	,@body))))  

(defmacro with-light-glyphs (pane &body body)
  `(let ((*light-glyph* t))
    (with-drawing-options (,pane :ink +gray50+)
      ,@body)))
