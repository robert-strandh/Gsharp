(in-package :score-pane)

(defclass score-pane (application-pane)
  ((pixmaps :initform (make-hash-table :test #'eq) :reader pane-pixmaps)
   (darker-gray-progressions :initform (make-array 10 :initial-element nil :adjustable t)
			     :reader darker-gray-progressions)
   (lighter-gray-progressions :initform (make-array 10 :initial-element nil :adjustable t)
			      :reader lighter-gray-progressions)))

(defmethod dispatch-event :before ((pane score-pane) (event pointer-enter-event))
  (let ((port (port pane)))
    (setf (port-keyboard-input-focus port) pane)))

(defmethod dispatch-event :after ((pane score-pane) (event pointer-exit-event))
  (let ((port (port pane)))
    (setf (port-keyboard-input-focus port)
	  (frame-standard-input (pane-frame pane)))))

(defparameter *pane* nil)
(defparameter *light-glyph* nil)
(defparameter *font* nil)
(defparameter *fonts* (make-array 100 :initial-element nil))

(defparameter *gray-levels*
  (loop with result = (make-array '(17))
	for i from 0 to 16 do
	(setf (aref result i) (make-gray-color (/ i 16)))
	finally (return result)))

(defun pane-pixmap (pane matrix)
  (or (gethash matrix (pane-pixmaps pane))
      (let* ((dimensions (array-dimensions matrix))
	     (height (car dimensions))
	     (width (cadr dimensions))
	     (pixmap (with-output-to-pixmap (medium pane :height height :width width)
		       (loop for r from 0 below height do
			     (loop for c from 0 below width do
				   (draw-point* medium c r
						:ink (aref *gray-levels*
							   (aref matrix r c))))))))
	(setf (gethash matrix (pane-pixmaps pane)) pixmap))))

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

;;;;;;;;;;;;;;;;;; rectangle output record

(defclass rectangle-output-record (score-output-record)
   ())

(defmethod replay-output-record ((record rectangle-output-record) stream
				 &optional (region +everywhere+)
				 (x-offset 0) (y-offset 0))
  (declare (ignore x-offset y-offset region))
  (with-bounding-rectangle* (x1 y1 x2 y2) record
    (with-slots (ink) record
      (let ((medium (sheet-medium stream)))
	(with-drawing-options (medium :ink ink)
	  (medium-draw-rectangle* medium x1 y1 x2 y2 t))))))

(defun make-rectangle-record (class medium x1 y1 x2 y2)
  (multiple-value-bind (x1 y1)
      (transform-position (medium-transformation medium) x1 y1)
    (multiple-value-bind (x2 y2)
	(transform-position (medium-transformation medium) x2 y2)
      (make-instance class
	:x1 (min x1 x2) :x2 (max x1 x2)
	:y1 (min y1 y2) :y2 (max y1 y2)
	:ink (medium-ink medium)))))

(defun add-new-rectangle-record (class stream x1 y1 x2 y2)
  (stream-add-output-record
   stream (make-rectangle-record class (sheet-medium stream)
				 x1 y1 x2 y2)))

;;;;;;;;;;;;;;;;;; pixmap output record

(defclass pixmap-output-record (score-output-record)
  ((pixmap :initarg :pixmap)))

(defmethod replay-output-record ((record pixmap-output-record) stream
				 &optional (region +everywhere+)
				 (x-offset 0) (y-offset 0))
  (declare (ignore x-offset y-offset region))
  (multiple-value-bind (x y) (output-record-position record)
    (with-slots (pixmap) record
      (let ((medium (sheet-medium stream)))
	(copy-from-pixmap pixmap 0 0 (pixmap-width pixmap) (pixmap-height pixmap)
			  medium x y)))))

(defun make-pixmap-record (class medium x1 y1 x2 y2 pixmap)
  (multiple-value-bind (x1 y1)
      (transform-position (medium-transformation medium) x1 y1)
    (multiple-value-bind (x2 y2)
	(transform-position (medium-transformation medium) x2 y2)
      (make-instance class :x1 x1 :x2 x2 :y1 y1 :y2 y2 :pixmap pixmap))))

(defun add-new-pixmap-record (class stream pixmap x y)
  (let ((width (pixmap-width pixmap))
	(height (pixmap-height pixmap)))
    (stream-add-output-record
     stream (make-pixmap-record class (sheet-medium stream)
				x y (+ x width) (+ y height) pixmap))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; drawing functions

(defun staff-step (n)
  (* n (/ (staff-line-distance *font*) 2)))

(defun draw-antialiased-glyph (pane glyph-no x staff-step)
  (let* ((extra (if *light-glyph* 1 0))
	 (matrix (glyph *font* (+ glyph-no extra)))
	 (pixmap (pane-pixmap pane matrix))
	 (width (pixmap-width pixmap))
	 (height (pixmap-height pixmap)))
    (multiple-value-bind (dx dy) (glyph-offsets *font* (+ glyph-no extra))
      (let ((x1 (+ x dx))
	    (y1 (+ (staff-step staff-step) dy)))
	(when (stream-recording-p pane)
	  (add-new-pixmap-record 'pixmap-output-record pane pixmap x1 y1))
	(when (stream-drawing-p pane)
	  (copy-from-pixmap pixmap 0 0 width height pane x1 y1))))))

(defun draw-stack (pane glyph-lower glyph-upper glyph-two x staff-step how-many)
  (draw-antialiased-glyph pane glyph-lower x staff-step)
  (loop for ss from staff-step by 2
	repeat (1- how-many) do
	(draw-antialiased-glyph pane glyph-two x ss))
  (draw-antialiased-glyph pane glyph-upper x (+ staff-step (* 2 (1- how-many)))))
  
(defun draw-whole-stack (pane x staff-step how-many)
  (draw-stack pane +glyph-whole-lower+ +glyph-whole-upper+ +glyph-whole-two+
	      x staff-step how-many))

(defun draw-half-stack (pane x staff-step how-many)
  (draw-stack pane +glyph-half-lower+ +glyph-half-upper+ +glyph-half-two+
	      x staff-step how-many))

(defun draw-filled-stack (pane x staff-step how-many)
  (draw-stack pane +glyph-filled-lower+ +glyph-filled-upper+ +glyph-filled-two+
	      x staff-step how-many))

;;;;;;;;;;;;;;;;;; helper macro

(defmacro define-pixmap-recording ((record-name medium-draw-name draw-name args) &body body)
  `(progn
    (defclass ,record-name (pixmap-output-record) ())
    
    (defgeneric ,medium-draw-name (medium pixmap x y))

    (defmethod ,medium-draw-name ((medium medium) pixmap x y)
      (copy-from-pixmap pixmap 0 0 (pixmap-width pixmap) (pixmap-height pixmap)
			medium x y))

    (defmethod ,medium-draw-name ((sheet sheet) pixmap x y)
      (,medium-draw-name (sheet-medium sheet) pixmap x y))

    (defmethod ,medium-draw-name :around ((pane score-pane) pixmap x y)
      (when (stream-recording-p pane)
	(add-new-pixmap-record ',record-name pane pixmap x y))
      (when (stream-drawing-p pane)
	(,medium-draw-name (sheet-medium pane) pixmap x y)))
  
    (defun ,draw-name (pane ,@args x staff-step)
      (let* ((extra (if *light-glyph* 1 0))
	     (glyph-no ,@body)
	     (matrix (glyph *font* (+ glyph-no extra)))
	     (pixmap (pane-pixmap pane matrix)))
	(multiple-value-bind (dx dy) (glyph-offsets *font* (+ glyph-no extra))
	  (,medium-draw-name pane pixmap (+ x dx) (+ (staff-step staff-step) dy)))))))

;;;;;;;;;;;;;;;;;; notehead

(define-pixmap-recording (notehead-output-record medium-draw-notehead draw-notehead (name))
    (ecase name
      (:whole +glyph-whole+)
      (:half +glyph-half+)
      (:filled +glyph-filled+)))

;;;;;;;;;;;;;;;;;; accidental

(define-pixmap-recording (accidental-output-record medium-draw-accidental draw-accidental (name))
    (ecase name
      (:natural +glyph-natural+)
      (:flat +glyph-flat+)
      (:double-flat +glyph-double-flat+)
      (:sharp +glyph-sharp+)
      (:double-sharp +glyph-double-sharp+)))

;;;;;;;;;;;;;;;;;; clef

(define-pixmap-recording (clef-output-record medium-draw-clef draw-clef (name))
    (ecase name
      (:treble +glyph-g-clef+)
      (:bass +glyph-f-clef+)
      (:c +glyph-f-clef+)))

;;;;;;;;;;;;;;;;;; rest

(define-pixmap-recording (rest-output-record medium-draw-rest draw-rest (duration))
    (ecase duration
      (1 +glyph-whole-rest+)
      (1/2 +glyph-half-rest+)
      (1/4 +glyph-quarter-rest+)
      (1/8 +glyph-eighth-rest+)
      (1/16 +glyph-sixteenth-rest+)
      (1/32 +glyph-thirtysecondth-rest+)
      (1/64 +glyph-sixtyfourth-rest+)
      (1/128 +glyph-onehundredandtwentyeigth-rest+)))

;;;;;;;;;;;;;;;;;; flags down

(define-pixmap-recording (flags-down-output-record medium-draw-flags-down draw-flags-down (nb))
    (ecase nb
      (1 +glyph-flags-down-one+)
      (2 +glyph-flags-down-two+)
      (3 +glyph-flags-down-three+)
      (4 +glyph-flags-down-four+)
      (5 +glyph-flags-down-five+)))

;;;;;;;;;;;;;;;;;; flags up

(define-pixmap-recording (flags-up-output-record medium-draw-flags-up draw-flags-up (nb))
    (ecase nb
      (1 +glyph-flags-up-one+)
      (2 +glyph-flags-up-two+)
      (3 +glyph-flags-up-three+)
      (4 +glyph-flags-up-four+)
      (5 +glyph-flags-up-five+)))

;;;;;;;;;;;;;;;;;; dot

(define-pixmap-recording (dot-output-record medium-draw-dot draw-dot ())
    +glyph-dot+)

;;;;;;;;;;;;;;;;;; helper macro

(defmacro define-rectangle-recording ((record-name medium-draw-name draw-name args) &body body)
  `(progn
    (defclass ,record-name (rectangle-output-record) ())
    
    (defgeneric ,medium-draw-name (medium x1 y1 x2 y2))

    (defmethod ,medium-draw-name ((medium medium) x1 y1 x2 y2)
      (medium-draw-rectangle* medium x1 y1 x2 y2 t))

    (defmethod ,medium-draw-name ((sheet sheet) x1 y1 x2 y2)
      (,medium-draw-name (sheet-medium sheet) x1 y1 x2 y2))

    (defmethod ,medium-draw-name :around ((pane score-pane) x1 y1 x2 y2)
      (when (stream-recording-p pane)
	(add-new-rectangle-record ',record-name pane x1 y1 x2 y2))
      (when (stream-drawing-p pane)
	(,medium-draw-name (sheet-medium pane) x1 y1 x2 y2)))
  
    (defun ,draw-name (pane ,@args)
      ,@body)))

;;;;;;;;;;;;;;;;;; staff line

(define-rectangle-recording (staff-line-output-record
			     medium-draw-staff-line
			     draw-staff-line
			     (x1 staff-step x2))
    (multiple-value-bind (down up) (staff-line-offsets *font*)
      (let ((y1 (+ (staff-step staff-step) down))
	    (y2 (+ (staff-step staff-step) up)))
	(medium-draw-staff-line pane x1 y1 x2 y2))))
			     
(defclass staff-line ()
  ((x1 :initarg :x1)
   (staff-step :initarg :staff-step)
   (x2 :initarg :x2)))

(define-presentation-type staff-line ())

(define-presentation-method present (line (type staff-line) stream view &key)
  (declare (ignore view))
  (with-slots (x1 staff-step x2) line
    (draw-staff-line stream x1 staff-step x2)))

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

(defun draw-staff (pane x1 x2)
  (multiple-value-bind (left right) (bar-line-offsets *font*)
    (loop for staff-step from 0 by 2
	  repeat 5 do
	  (present (make-instance 'staff-line :x1 (+ x1 left) :staff-step staff-step :x2 (+ x2 right))
		   'staff-line :stream pane))))
;;;	(draw-staff-line pane (+ x1 left) staff-step (+ x2 right))))

;;;;;;;;;;;;;;;;;; stem

(define-rectangle-recording (stem-output-record
			     medium-draw-stem
			     draw-stem
			     (x y1 y2))
    (multiple-value-bind (left right) (stem-offsets *font*)
      (let ((x1 (+ x left))
	    (x2 (+ x right)))
	(medium-draw-stem pane x1 y1 x2 y2))))
			     
(defun draw-right-stem (pane x y1 y2)
  (multiple-value-bind (dx dy) (notehead-right-offsets *font*)
    (declare (ignore dy))
    (draw-stem pane (+ x dx) y1 y2)))

(defun draw-left-stem (pane x y1 y2)
  (multiple-value-bind (dx dy) (notehead-left-offsets *font*)
    (declare (ignore dy))
    (draw-stem pane (+ x dx) y1 y2)))

;;;;;;;;;;;;;;;;;; ledger line

(define-rectangle-recording (ledger-line-output-record
			     medium-draw-ledger-line
			     draw-ledger-line
			     (x staff-step))
    (multiple-value-bind (down up) (ledger-line-y-offsets *font*)
      (multiple-value-bind (left right) (ledger-line-x-offsets *font*)
	(let ((x1 (+ x left))
	      (y1 (+ (staff-step staff-step) down))
	      (x2 (+ x right))
	      (y2 (+ (staff-step staff-step) up)))
	  (medium-draw-ledger-line pane x1 y1 x2 y2)))))
			     
;;;;;;;;;;;;;;;;;; bar line

(define-rectangle-recording (bar-line-output-record
			     medium-draw-bar-line
			     draw-bar-line
			     (x y1 y2))
    (multiple-value-bind (left right) (bar-line-offsets *font*)
      (let ((x1 (+ x left))
	    (x2 (+ x right)))
	(medium-draw-bar-line pane x1 y1 x2 y2))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; beam drawing

(defclass beam-output-record (score-output-record)
  ((thickness :initarg :thickness)))

(defclass horizontal-beam-output-record (beam-output-record rectangle-output-record)
  ())

(defun draw-horizontal-beam (medium x1 y1 x2 thickness)
  (let ((y2 (- y1 thickness)))
    (when (stream-recording-p *pane*)
      (add-new-rectangle-record 'horizontal-beam-output-record *pane* x1 y1 x2 y2))
    (when (stream-drawing-p *pane*)
      (medium-draw-rectangle* medium x1 y1 x2 y2 t))))

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

(defun draw-upward-beam-segment (medium x1 y x2 thickness)
  (draw-segment medium x1 (1+ y) x2 thickness
		*darker-gray-progressions* *lighter-gray-progressions*))

(defun draw-downward-beam-segment (medium x1 y x2 thickness)
  (draw-segment medium x1 y x2 thickness
		*lighter-gray-progressions* *darker-gray-progressions*))

(defun draw-upward-beam (medium x1 y1 y2 thickness inverse-slope)
  (loop for y from y1 below y2
	for x from x1 by inverse-slope do
	(draw-upward-beam-segment medium (round x) y
				  (round (+ x inverse-slope)) thickness)))

(defun draw-downward-beam (medium x1 y1 y2 thickness inverse-slope)
  (loop for y from y1 above y2
	for x from x1 by inverse-slope do
	(draw-downward-beam-segment medium (round x) y
				    (round (+ x inverse-slope)) thickness)))

(defclass upward-beam-output-record (beam-output-record)
  ())

(defmethod replay-output-record ((record upward-beam-output-record) (stream score-pane)
				 &optional (region +everywhere+)
				 (x-offset 0) (y-offset 0))
  (declare (ignore x-offset y-offset region))
  (with-bounding-rectangle* (x1 y1 x2 y2) record
    (with-slots (thickness ink) record
      (let ((medium (sheet-medium stream)))
	(let ((*light-glyph* (not (eq ink +black+))))
	  (with-drawing-options (medium :ink ink)
	    (let ((*lighter-gray-progressions* (lighter-gray-progressions stream))
		  (*darker-gray-progressions* (darker-gray-progressions stream)))
	      ;; we replay with the identity tranformation, so
	      ;; we have to draw the other way
	      (draw-downward-beam medium x1 (1- y2) (1- (+ y1 thickness)) thickness
				  (/ (- x2 x1) (- y2 y1 thickness))))))))))

(defclass downward-beam-output-record (beam-output-record)
  ())

(defmethod replay-output-record ((record downward-beam-output-record) (stream score-pane)
				 &optional (region +everywhere+)
				 (x-offset 0) (y-offset 0))
  (declare (ignore x-offset y-offset region))
  (with-bounding-rectangle* (x1 y1 x2 y2) record
    (with-slots (thickness ink) record
      (let ((medium (sheet-medium stream)))
	(let ((*light-glyph* (not (eq ink +black+))))
	  (with-drawing-options (medium :ink ink)
	    (let ((*lighter-gray-progressions* (lighter-gray-progressions stream))
		  (*darker-gray-progressions* (darker-gray-progressions stream)))
	      ;; we replay with the identity tranformation, so
	      ;; we have to draw the other way
	      (draw-upward-beam medium x1 (1- (+ y1 thickness)) (1- y2) thickness
				(/ (- x2 x1) (- y2 y1 thickness))))))))))

(defun draw-sloped-beam (medium x1 y1 x2 y2 thickness inverse-slope)
  (let ((transformation (medium-transformation *pane*)))
    (cond ((< y1 y2)
	   (when (stream-recording-p *pane*)
	     (multiple-value-bind (xx1 yy1)
		 (transform-position transformation x1 (- y1 thickness))
	       (multiple-value-bind (xx2 yy2)
		   (transform-position transformation x2 y2)
		 (stream-add-output-record
		  *pane* (make-instance 'upward-beam-output-record
			   :x1 xx1 :y1 yy2 :x2 xx2 :y2 yy1
			   :thickness thickness :ink (medium-ink medium))))))
	   (when (stream-drawing-p *pane*)
	     (draw-upward-beam medium x1 y1 y2 thickness inverse-slope)))
	  (t
	   (when (stream-recording-p *pane*)
	     (multiple-value-bind (xx1 yy1)
		 (transform-position transformation x1 y1)
	       (multiple-value-bind (xx2 yy2)
		   (transform-position transformation x2 (- y2 thickness))
		 (stream-add-output-record
		  *pane* (make-instance 'downward-beam-output-record
			   :x1 xx1 :y1 yy1 :x2 xx2 :y2 yy2
			   :thickness thickness :ink (medium-ink medium))))))
	   (when (stream-drawing-p *pane*)
	     (draw-downward-beam medium x1 y1 y2 thickness inverse-slope))))))

;;; an offset of -1 means hang, 0 means straddle and 1 means sit
(defun draw-beam (pane x1 staff-step-1 offset1 x2 staff-step-2 offset2)
  (if (> x1 x2)
      (draw-beam pane x2 staff-step-2 offset2 x1 staff-step-1 offset1)
      (multiple-value-bind (left right) (stem-offsets *font*)
	(let* ((xx1 (+ x1 left))
	       (xx2 (+ x2 right))
	       (y1 (floor (staff-step (+ staff-step-1 1/2 (* 1/2 offset1)))))
	       (y2 (floor (staff-step (+ staff-step-2 1/2 (* 1/2 offset2)))))
	       (slope (abs (/ (- y2 y1) (- xx2 xx1))))
	       (thickness (/ (staff-line-distance *font*) 2))
	       (medium (sheet-medium pane)))
	  (assert (< slope 1))
	  (if (= y1 y2)
	      (draw-horizontal-beam medium xx1 y1 xx2 thickness)
	      (draw-sloped-beam medium xx1 y1 xx2 y2 thickness (/ slope)))))))

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
  (let ((pixmap (gensym))
	(mirror (gensym)))
    `(let* ((*pane* ,pane)
	    (*lighter-gray-progressions* (lighter-gray-progressions pane))
	    (*darker-gray-progressions* (darker-gray-progressions pane))
	    (,pixmap (allocate-pixmap *pane* 800 900))
	    (,mirror (sheet-direct-mirror *pane*)))
      (draw-rectangle* ,pixmap 0 0 800 900 :filled t :ink +white+)
      (setf (sheet-direct-mirror *pane*) (climi::pixmap-mirror ,pixmap))
      (clear-output-record (stream-output-history *pane*))
      (with-translation (pane 0 900)
	(with-scaling (pane 1 -1)
	  ,@body))
      (setf (sheet-direct-mirror *pane*) ,mirror)
      (copy-from-pixmap ,pixmap 0 0 800 900 *pane* 0 0)
      (deallocate-pixmap ,pixmap))))      

(defmacro with-vertical-score-position ((pane yref) &body body)
  `(with-translation (,pane 0 ,yref)
    ,@body))

(defmacro with-staff-size (size &body body)
  (let ((size-var (gensym)))
    `(let ((,size-var ,size))
      (unless (aref *fonts* ,size-var)
	(setf (aref *fonts* ,size-var)
	      (load-font ,size-var)))
      (let ((*font* (aref *fonts* ,size-var)))
	,@body))))  

(defmacro with-light-glyphs (pane &body body)
  `(let ((*light-glyph* t))
    (with-drawing-options (,pane :ink +gray50+)
      ,@body)))
