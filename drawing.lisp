(in-package :gsharp-drawing)

(define-added-mixin dstaff () staff
  ((yoffset :initform 0 :accessor staff-yoffset)))

(define-added-mixin dnote () note
  (;; the relative x offset of the note with respect to the cluster
   (final-relative-note-xoffset :accessor final-relative-note-xoffset)
   (final-accidental :initform nil :accessor final-accidental)
   ;; The relative x offset of the accidental of the note with respect
   ;; to the cluster.  A value of nil indicates that accidental has
   ;; not been placed yet
   (final-relative-accidental-xoffset :initform nil
				      :accessor final-relative-accidental-xoffset)))

(define-presentation-method present
    (object (type score-pane:clef) stream (view textual-view) &key)
  (format stream "[~a clef on staff step ~a]" (name object) (lineno object)))

(define-presentation-method present
    (object (type score-pane:fiveline-staff) stream (view textual-view) &key)
   (format stream "[fiveline staff ~a]" (name object)))

(define-presentation-method present
    (object (type score-pane:lyrics-staff) stream (view textual-view) &key)
   (format stream "[lyrics staff ~a]" (name object)))

(defmethod draw-staff-and-clef (pane (staff fiveline-staff) x1 x2)
  (when (clef staff)
    (present (clef staff)
	     `((score-pane:clef)
	       :name ,(name (clef staff))
	       :x ,(+ x1 10)
	       :staff-step ,(lineno (clef staff)))
	     :stream pane)
    (let ((yoffset (ecase (name (clef staff))
		     (:bass (- (lineno (clef staff)) 4))
		     (:treble (+ (lineno (clef staff)) 2))
		     (:c (- (lineno (clef staff))) 1))))
      (loop for pitch in '(6 2 5 1 4 0 3)
	    for line in '(0 3 -1 2 -2 1 -3)
	    for x from (+ x1 10 (score-pane:staff-step 8)) by (score-pane:staff-step 2)
	    while (eq (aref (keysig staff) pitch) :flat)
	    do (score-pane:draw-accidental pane :flat x (+ line yoffset))))
    (let ((yoffset (ecase (name (clef staff))
		     (:bass (lineno (clef staff)))
		     (:treble (+ (lineno (clef staff)) 6))
		     (:c (+ (lineno (clef staff))) 3))))
      (loop for pitch in '(3 0 4 1 5 2 6)
	    for line in '(0 -3 1 -2 -5 -1 -4)
	    for x from (+ x1 10 (score-pane:staff-step 8)) by (score-pane:staff-step 2.5)
	    while (eq (aref (keysig staff) pitch) :sharp)
	    do (score-pane:draw-accidental pane :sharp x (+ line yoffset)))))
  (present staff
	   `((score-pane:fiveline-staff)
	     :x1 ,x1 :x2 ,x2)
	   :stream pane))

(defmethod draw-staff-and-clef (pane (staff lyrics-staff) x1 x2)
  (present staff
	   `((score-pane:lyrics-staff)
	     :x1 ,x1 :x2 ,x2)
	   :stream pane))

;;; Return the final absolute x offset of a note.  This value is
;;; computed from the x offset of the cluster of the note and the
;;; relative x offset of the note with respect to the cluster.
(defun final-absolute-note-xoffset (note)
  (+ (element-xpos (cluster note)) (final-relative-note-xoffset note)))

;;; Return the final absolute x offset of the accidental of a note.
;;; This value is computed from the x offset of the cluster of the
;;; note and the relative x offset of the accidental of the note with
;;; respect to the cluster.
(defun final-absolute-accidental-xoffset (note)
  (+ (element-xpos (cluster note)) (final-relative-accidental-xoffset note)))

(defun line-cost (measures method)
  (reduce (lambda (x y) (combine-cost method x y)) measures :initial-value nil))

(defun compute-compress-factor (measures method)
  (compress-factor method (line-cost measures method)))

(defun red-width (method coeff min-dist)
  (* coeff (min-width method) (expt (/ min-dist) (spacing-style method))))

(defun compute-reduced-width (method coeff min-dist)
  (if (zerop min-dist) 0 (red-width method coeff min-dist)))

(defun nat-width (method coeff min-dist)
  (+ (red-width method coeff min-dist) (min-width method)))

(defvar *cursor* nil)

(defun compute-min-dist (measures)
  (let ((min-dists (mapcar (lambda (measure)
			     (reduce #'min (gsharp-measure::abs-rel
					    (measure-start-times measure))))
			   measures)))
    (reduce #'min min-dists)))  

(defun compute-widths (measures method)
  (let ((compress (compute-compress-factor measures method))
	(min-dist (compute-min-dist measures)))
    (loop for measure in measures
	  collect (/ (nat-width method (measure-coeff measure) min-dist)
		     compress))))

(defun draw-measure (pane measure min-dist compress x method draw-cursor)
  (let* ((width (/ (nat-width method (measure-coeff measure) min-dist)
		   compress))
	 (time-alist (cons (cons 0 (/ (min-width method) compress))
			   (loop for start-time in (measure-start-times measure)
				 and old-start-time = 0 then start-time
				 with coeff = 0
				 do (incf coeff (expt (- start-time old-start-time)
						      (spacing-style method)))
				 collect (cons start-time
					       (/ (+ (min-width method)
						     (compute-reduced-width
						      method
						      coeff min-dist))
						  compress))))))
    (loop for bar in (measure-bars measure) do
	  (if (gsharp-cursor::cursors (slice bar))
	      (draw-bar pane bar x width time-alist draw-cursor)
	      (score-pane:with-light-glyphs pane (draw-bar pane bar x width time-alist draw-cursor))))))

(defun draw-system (pane measures x widths method staves draw-cursor)
  (let ((compress (compute-compress-factor measures method))
	(min-dist (compute-min-dist measures)))
    (loop for measure in measures
	  for width in widths do
	  (draw-measure pane measure min-dist compress x method draw-cursor)
	  (incf x width)
	  (score-pane:draw-bar-line pane x
					 (- (score-pane:staff-step 8))
					 (staff-yoffset (car (last staves)))))))

(defmethod draw-buffer (pane (buffer buffer) *cursor* x y draw-cursor)
  (score-pane:with-staff-size 6
    (let* ((staves (staves buffer))
	   (timesig-offset (max (* (score-pane:staff-step 2)
				   (loop for staff in staves
					 maximize
					 (if (typep staff 'fiveline-staff)
					     (count :flat (keysig staff))
					     0)))
				(* (score-pane:staff-step 2.5)
				   (loop for staff in staves
					 maximize
					 (if (typep staff 'fiveline-staff)
					     (count :sharp (keysig staff))
					     0)))))
	   (method (let ((old-method (buffer-cost-method buffer)))
		     (make-measure-cost-method (min-width old-method)
					       (spacing-style old-method)
					       (- (line-width old-method) timesig-offset))))
	   (right-edge (right-edge buffer)))
      (loop for staff in staves
	    for offset from 0 by 90 do
;;	    for offset downfrom 0 by 90 do
	    (setf (staff-yoffset staff) offset))
      (let ((yy y))
	(gsharp-measure::new-map-over-obseq-subsequences
	 (lambda (measures)
	   (let ((widths (compute-widths measures method)))
	     (score-pane:with-vertical-score-position (pane yy)
	       (draw-system pane measures (+ x (left-offset buffer) timesig-offset)
			    widths method staves draw-cursor)
	       (score-pane:draw-bar-line pane x
					 (- (score-pane:staff-step 8))
					 (staff-yoffset (car (last staves)))))
	     (loop for staff in staves do
		   (score-pane:with-vertical-score-position (pane yy)
		     (if (member staff (staves (layer (slice (bar *cursor*)))))
			 (draw-staff-and-clef pane staff x right-edge)
			 (score-pane:with-light-glyphs pane
			   (draw-staff-and-clef pane staff x right-edge))))
		   (incf yy 90))))
	 buffer)))))

(define-added-mixin velement () melody-element
  ((final-stem-direction :accessor final-stem-direction)
   ;; the position, in staff steps, of the end of the stem
   ;; that is not attached to a note, independent of the
   ;; staff on which it is located
   (final-stem-position :accessor final-stem-position)
   ;; the yoffset of the staff relative to which the end of the
   ;; stem is located
   (final-stem-yoffset :initform 0 :accessor final-stem-yoffset)
   ;; the position, in staff steps, of the bottom note in the element.
   (bot-note-pos :accessor bot-note-pos)
   ;; the yoffset of the staff that contains the top note of
   ;; the element
   (top-note-staff-yoffset :accessor top-note-staff-yoffset)
   ;; the position, in staff steps, of the top not in the element.
   (top-note-pos :accessor top-note-pos)
   ;; the yoffset of the staff that contains the bottom note of
   ;; the element
   (bot-note-staff-yoffset :accessor bot-note-staff-yoffset)
   (xpos :accessor element-xpos)))

(define-added-mixin welement () lyrics-element
  ((xpos :accessor element-xpos)))

;;; given a list of notes, return the one that is at the top
(defun top-note (notes)
  (reduce (lambda (n1 n2)
	    (cond ((< (staff-yoffset (staff n1))
		      (staff-yoffset (staff n2)))
		   n1)
		  ((> (staff-yoffset (staff n1))
		      (staff-yoffset (staff n2)))
		   n2)
		  ((> (note-position n1)
		      (note-position n2))
		   n1)
		  (t n2)))
	  notes))

;;; given a list of notes, return the one that is at the bottom
(defun bot-note (notes)
  (reduce  (lambda (n1 n2)
	     (cond ((> (staff-yoffset (staff n1))
		       (staff-yoffset (staff n2)))
		    n1)
		   ((< (staff-yoffset (staff n1))
		       (staff-yoffset (staff n2)))
		    n2)
		   ((< (note-position n1)
		       (note-position n2))
		    n1)
		   (t n2)))
	   notes))

;;; Compute and store several important pieces of information
;;; about an element:
;;;  * the position, in staff steps of the top note.
;;;  * the position, in staff steps of the bottom note.
(defun compute-top-bot-pos (element)
  (if (and (typep element 'cluster) (notes element))
      (let ((top-note (top-note (notes element)))
	    (bot-note (bot-note (notes element))))
	(setf (top-note-pos element) (note-position top-note)
	      (bot-note-pos element) (note-position bot-note)))
      (setf (top-note-pos element) 4
	    (bot-note-pos element) 4)))

;;; Compute and store several important pieces of information
;;; about an element:
;;;  * the y-offset of the staff containing the top note.
;;;  * the y-offset of the staff containing the bottom note.
(defun compute-top-bot-yoffset (element)
  (if (and (typep element 'cluster) (notes element))
      (let ((top-note (top-note (notes element)))
	    (bot-note (bot-note (notes element))))
	(setf (bot-note-staff-yoffset element) (staff-yoffset (staff bot-note))
	      (top-note-staff-yoffset element) (staff-yoffset (staff top-note))))
      (setf ;; clearly wrong.  should be taken from element or layer.
	    (top-note-staff-yoffset element) 0
	    (bot-note-staff-yoffset element) 0)))

;;; Compute and store the final stem direction of an element that is
;;; not beamed together with any other elements.
(defun compute-stem-direction (element)
  (setf (final-stem-direction element)
	(if (or (eq (stem-direction element) :up) (eq (stem-direction element) :down))
	    (stem-direction element)
	    (let ((top-note-pos (top-note-pos element))
		  (bot-note-pos (bot-note-pos element)))
	      (if (>= (- top-note-pos 4)
		      (- 4 bot-note-pos))
		  :down
		  :up)))))

(defun compute-stem-length (element)
  (let* ((top-note-pos (top-note-pos element))
	 (bot-note-pos (bot-note-pos element))
	 (top-note (reduce (lambda (n1 n2)
			     (cond ((< (staff-yoffset (staff n1))
				       (staff-yoffset (staff n2)))
				    n1)
				   ((> (staff-yoffset (staff n1))
				       (staff-yoffset (staff n2)))
				    n2)
				   ((> (note-position n1)
				       (note-position n2))
				    n1)
				   (t n2)))
			   (notes element)))
	 (bot-note (reduce (lambda (n1 n2)
			     (cond ((> (staff-yoffset (staff n1))
				       (staff-yoffset (staff n2)))
				    n1)
				   ((< (staff-yoffset (staff n1))
				       (staff-yoffset (staff n2)))
				    n2)
				   ((< (note-position n1)
				       (note-position n2))
				    n1)
				   (t n2)))
			   (notes element)))
	 (length (if (eq (final-stem-direction element) :up)
		     (cond ((<= top-note-pos -3) (- 4 top-note-pos))
			   ((<= top-note-pos 3) 7)
			   ((= top-note-pos 4) 6)
			   (t 5))
		     (cond ((>= bot-note-pos 11) (- bot-note-pos 4))
			   ((>= bot-note-pos 4) 7)
			   ((= bot-note-pos 3) 6)
			   (t 5))))
	 (nb-flags (max (rbeams element) (lbeams element))))
    (when (> nb-flags 0)
      (setf length (max length
			(+ (if (eq (final-stem-direction element) :up) 6 7)
			   (* 2 (max 0 (- nb-flags 2)))))))
    (setf (final-stem-yoffset element)
	  (staff-yoffset (staff (if (eq (final-stem-direction element) :up)
				    top-note bot-note))))
    (setf (final-stem-position element)
	  (if (eq (final-stem-direction element) :up)
	      (+ top-note-pos length)
	      (- bot-note-pos length)))))

(defun compute-element-x-positions (bar x time-alist)
  (let (;;(time-alist (time-alist bar))
	(start-time 0))
    (mapc (lambda (element)
	    (setf (element-xpos element)
		  (round (+ x
			    (score-pane:staff-step (xoffset element))
			    (cdr (assoc start-time time-alist)))))
	    (incf start-time (duration element)))
	  (elements bar))))

;;; Compute and store the final stem directions of all the elements of
;;; a beam group with at least two elements in it.
(defun compute-stem-directions (elements)
  (let ((stem-direction (if (not (eq (stem-direction (car elements)) :auto))
			    (stem-direction (car elements))
			    (let ((top-note-pos (reduce #'max elements :key #'top-note-pos))
				  (bot-note-pos (reduce #'min elements :key #'bot-note-pos)))
			      (if (>= (- top-note-pos 4) (- 4 bot-note-pos)) :down :up)))))
    (loop for element in elements
	  do (setf (final-stem-direction element) stem-direction))))

;;; the dominating note among a bunch of notes is the 
;;; one that is closest to the beam, i.e. the one 
;;; the one that is closest to the end of the stem that
;;; is not attached to a notehead. 
(defun dominating-note (notes stem-direction)
  (reduce (lambda (n1 n2)
	    (let ((yoff1 (staff-yoffset (staff n1)))
		  (yoff2 (staff-yoffset (staff n2))))
	      (if (eq stem-direction :up)
		  (if (< yoff1 yoff2)
		      n1 
		      (if (> yoff1 yoff2)
			  n2
			  (if (> (pitch n1) (pitch n2)) n1 n2)))
		  (if (> yoff1 yoff2)
		      n1
		      (if (< yoff1 yoff2)
			  n2
			  (if (< (pitch n1) (pitch n2)) n1 n2))))))
	  notes))

;;; Given a list of elements to be beamed together, for each element,
;;; compute the top and bottom note position, and the final stem
;;; direction. 
(defun compute-positions-and-stem-direction (elements)
  (mapc #'compute-top-bot-pos elements)
  (if (null (cdr elements))
      (let ((element (car elements)))
	(when (or (typep element 'rest) (notes element))
	  (when (typep element 'cluster)
	    (compute-stem-direction element))))
      (compute-stem-directions elements)))

(defun draw-beam-group (pane elements)
  (mapc #'compute-top-bot-yoffset elements)
  (if (null (cdr elements))
      (let ((element (car elements)))
	(when (or (typep element 'rest) (notes element))
	  (when (typep element 'cluster)
	    (compute-stem-direction element)
	    (compute-stem-length element))
	  (draw-element pane element (element-xpos element))))
      (let* ((stem-direction (final-stem-direction (car elements)))
	     (dominating-notes
	      (mapcar (lambda (e) (dominating-note (notes e) stem-direction))
		      elements))
	     (dominating-staff
	      (staff (dominating-note dominating-notes stem-direction)))
	     (positions (mapcar (lambda (n)
				  (if (eq (staff n) dominating-staff)
				      (note-position n)
				      (if (eq stem-direction :up) -1000 1000)))
				dominating-notes))
	     (x-positions (mapcar (lambda (element)
				    (/ (element-xpos element) (score-pane:staff-step 1)))
				  elements))
	     (beaming (beaming-single (mapcar #'list positions x-positions) stem-direction)))
	(destructuring-bind ((ss1 . offset1) (ss2 . offset2)) beaming
	  (let* ((y1 (+ ss1 (* 1/2 offset1)))
		 (y2 (+ ss2 (* 1/2 offset2)))
		 (x1 (element-xpos (car elements)))
		 (x2 (element-xpos (car (last elements))))
		 (slope (/ (- y2 y1) (- x2 x1))))
	    (if (eq stem-direction :up)
		(loop for element in elements do
		      (setf (final-stem-position element)
			    (+ y1 (* slope (- (element-xpos element) x1))))
		      (setf (final-stem-yoffset element)
			    (staff-yoffset dominating-staff)))
		(loop for element in elements do
		      (setf (final-stem-position element)
			    (+ y1 (* slope (- (element-xpos element) x1))))
		      (setf (final-stem-yoffset element)
			    (staff-yoffset dominating-staff)))))
	  (score-pane:with-vertical-score-position (pane (staff-yoffset dominating-staff))
	    (if (eq stem-direction :up)
		(score-pane:with-notehead-right-offsets (right up)
		  (declare (ignore up))
		  (score-pane:draw-beam pane
					(+ (element-xpos (car elements)) right) ss1 offset1
					(+ (element-xpos (car (last elements))) right) ss2 offset2))
		(score-pane:with-notehead-left-offsets (left down)
		  (declare (ignore down))
		  (score-pane:draw-beam pane
					(+ (element-xpos (car elements)) left) ss1 offset1
					(+ (element-xpos (car (last elements))) left) ss2 offset2))))
	  (loop for element in elements do
		(draw-element pane element (element-xpos element) nil))))))

(defun draw-cursor (pane x)
  (draw-line* pane x (- (score-pane:staff-step -4)) x (- (score-pane:staff-step 12)) :ink +red+))

;;; Given a list of the elements of a bar, return a list of beam
;;; groups, where each beam group is a list of elements that are
;;; beamed together
(defun beam-groups (elements)
  (let ((group '()))
    (loop while (not (null elements)) do
	  (setf group '())
	  (push (pop elements) group)
	  (loop while (and (not (null elements))
			   (> (rbeams (car group)) 0)
			   (> (lbeams (car elements)) 0))
		do (push (pop elements) group))
	  collect (nreverse group))))

(defmethod draw-bar (pane (bar melody-bar) x width time-alist draw-cursor)
  (compute-element-x-positions bar x time-alist)
  (loop for group in (beam-groups (elements bar))
	do (compute-positions-and-stem-direction group)
  	   (draw-beam-group pane group))
  (when (eq (cursor-bar *cursor*) bar)
    (let ((elements (elements bar)))
      (if (null (cursor-element *cursor*))
	  (funcall draw-cursor (/ (+ (if (null elements)
					 x
					 (element-xpos (car (last elements))))
				     x width) 2))
	  (loop for element in elements
		and xx = x then (element-xpos element) do
		(when (eq (cursor-element *cursor*) element)
		  (funcall draw-cursor (/ (+ xx (element-xpos element)) 2))))))))

(defmethod draw-bar (pane (bar lyrics-bar) x width time-alist draw-cursor)
  (compute-element-x-positions bar x time-alist)
  (let ((elements (elements bar)))
    (loop for element in elements
	  do (draw-element pane element (element-xpos element)))
    (when (eq (cursor-bar *cursor*) bar)
      (if (null (cursor-element *cursor*))
	  (funcall draw-cursor (/ (+ (if (null elements)
					 x
					 (element-xpos (car (last elements))))
				     x width) 2))
	  (loop for element in elements
		and xx = x then (element-xpos element) do
		(when (eq (cursor-element *cursor*) element)
		  (funcall draw-cursor (/ (+ xx (element-xpos element)) 2))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Cluster

(defgeneric draw-element (pane element x &optional flags))

(defmethod note-difference ((note1 note) (note2 note))
  (- (pitch note1) (pitch note2)))

(defmethod note-position ((note note))
  (let ((clef (clef (staff note))))
    (+ (- (pitch note)
	  (ecase (name clef) (:treble 32) (:bass 24) (:c 35)))
       (lineno clef))))

(defun draw-ledger-lines (pane x notes)
  (score-pane:with-vertical-score-position (pane (staff-yoffset (staff (car notes))))
    (let* ((positions (mapcar #'note-position notes))
	   (top-note-pos (reduce #'max positions))
	   (bot-note-pos (reduce #'min positions)))
      (loop for pos from 10 to top-note-pos by 2
	    do (score-pane:draw-ledger-line pane x pos))
      (loop for pos from -2 downto bot-note-pos by 2
	    do (score-pane:draw-ledger-line pane x pos)))))

(defun draw-flags (pane element x direction pos)
  (let ((nb (max (rbeams element) (lbeams element))))
    (when (and (> nb 0) (eq (notehead element) :filled))
      (if (eq direction :up)
	  (score-pane:with-notehead-right-offsets (right up)
	    (declare (ignore up))
	    (score-pane:draw-flags-down pane nb (+ x right) pos))
	  (score-pane:with-notehead-left-offsets (left down)
	    (declare (ignore down))
	    (score-pane:draw-flags-up pane nb (+ x left) pos))))))
  
(defun draw-dots (pane nb-dots x pos)
  (let ((staff-step (score-pane:staff-step 1)))
    (loop with dotpos = (if (evenp pos) (1+ pos) pos)
	  repeat nb-dots
	  for xx from (+ x (* 2 staff-step)) by staff-step do
	  (score-pane:draw-dot pane xx dotpos))))

(defun draw-note (pane note notehead nb-dots x pos)
  (score-pane:with-vertical-score-position (pane (staff-yoffset (staff note)))
    (score-pane:draw-notehead pane notehead x pos)
    (when (final-accidental note)
      (score-pane:draw-accidental pane (final-accidental note) (final-absolute-accidental-xoffset note) pos))
    (draw-dots pane nb-dots x pos)))

(defun draw-notes (pane notes dots notehead)
  (loop for note in notes do
	(draw-note pane note notehead dots (final-absolute-note-xoffset note) (note-position note))))

;;; given a group of notes (i.e. a list of notes, all displayed on the
;;; same staff, compute their final x offsets.  This is a question of
;;; determining whether the note goes to the right or to the left of
;;; the stem.  The head-note of the stem goes to the left of an
;;; up-stem and to the right of a down-stem.  The x offset of a cluster
;;; gives the x position of the head-note. 
(defun compute-final-relative-note-xoffsets (group direction)
  (setf group (sort (copy-list group)
		    (if (eq direction :up)
			(lambda (x y) (< (note-position x) (note-position y)))
			(lambda (x y) (> (note-position x) (note-position y))))))
  (score-pane:with-suspended-note-offset offset
    ;; the first element of the group is the head-note
    (setf (final-relative-note-xoffset (car group)) 0)
    ;; OFFSET is a positive quantity that determines the 
    ;; absolute difference between the x offset of a suspended
    ;; note and that of a normally positioned note. 
    (when (eq direction :down) (setf offset (- offset)))
    (loop for note in (cdr group)
	  and old-note = (car group) then note
	  do (let* ((pos (note-position note))
		    (old-pos (note-position old-note))
		    ;; if adjacent notes are just one staff step apart, 
		    ;; then one must be suspended. 
		    (dx (if (= (abs (- pos old-pos)) 1) offset 0))) 
	       (setf (final-relative-note-xoffset note) dx)
	       ;; go back to ordinary offset
	       (when (= (abs (- pos old-pos)) 1)
		 (setf note old-note))))))

;;; Given a list of notes to be displayed on the same staff line, for
;;; each note, compute the accidental to be displayed as a function of
;;; the accidentals of the note and the key signature of the staff.
(defun compute-final-accidentals (group)
  (loop for note in group do
	(setf (final-accidental note)
	      (if (eq (accidentals note)
		      (aref (keysig (staff note)) (mod (pitch note) 7)))
		  nil
		  (accidentals note)))))

(defun element-has-suspended-notes (element)
  (not (apply #'= (mapcar #'final-relative-note-xoffset (notes element)))))

;;; table of x offsets (in staff steps) of accendentals.
;;; The first index represents a notehead or a type of accidental.
;;; The second index represents a type of accidentsl.
;;; The third index is a vertical distance, measured in difference
;;; in staff steps between the two. 
;;; The table entry gives how much the accidental represented by
;;; the second parameter must be positioned to the left of the 
;;; first one. 
;;; Entries in the table are offset by 5 in the last dimension
;;; so that vertical distances between -5 and 5 can be represented
(defparameter *accidental-offset*
  ;;;     -5  -4  -3  -2  -1   0   1   2   3   4   5
  #3A(((   0   0   0 3.5 3.5 3.5 3.5 3.5 3.5   1   0)    ; notehead - dbl flat
       (   0   0   0 3.5 3.5 3.5 3.5 3.5 3.5   1   0)    ; notehead - flat
       (   0 3.5 3.5 3.5 3.5 3.5 3.5 3.5   1   1   0)    ; notehead - natural
       (   0 3.5 3.5 3.5 3.5 3.5 3.5 3.5   1   1   0)    ; notehead - sharp
       (   0   0   0 3.5 3.5 3.5 3.5 3.5   0   0   0))   ; notehead - dbl sharp
      (( 3.8 3.8 3.8 3.8 3.8 3.8 3.8 3.8   3   3   0)    ; dbl flat - dbl flat
       ( 3.8 3.8 3.8 3.8 3.8 3.8 3.8 3.8   3   3   0)    ; dbl flat - flat
       ( 3.8 3.8 3.8 3.8 3.8 3.8 3.8 3.8   3   3   0)    ; dbl flat - natural
       (   4   4   4   4   4   4   4   4   4 3.5   0)    ; dbl flat - sharp
       ( 3.8 3.8 3.8 3.8 3.8 3.8 3.8 3.8   0   0   0))   ; dbl flat - dbl sharp
      ((   2   2   2   2   2   2   2   2 1.5   1   0)    ; flat - dbl flat
       (   2   2   2   2   2   2   2   2 1.5   1   0)    ; flat - flat
       (   2   2   2   2   2   2   2   2 1.5   1   0)    ; flat - natural
       ( 2.4 2.4 2.4 2.4 2.4 2.4 2.4 2.4 2.4 1.5   0)    ; flat - sharp
       ( 2.4 2.4 2.4 2.4 2.4 2.4 2.4 2.4   0   0   0))   ; flat - dbl sharp
      ((   2   2   2   2   2   2   2   2   2 1.5 1.5)    ; natural - dbl flat
       (   2   2   2   2   2   2   2   2   2 1.5 1.5)    ; natural - flat
       (   2   2   2   2   2   2   2   2   2 1.5 1.5)    ; natural - natural
       (   2   2   2   2   2   2   2   2   2   2   2)    ; natural - sharp
       (   2   2   2   2   2   2   2   2   1   1   1))   ; natural - dbl sharp
      ((   0 2.4 2.4 2.4 2.4 2.4 2.4 2.4 2.0 1.5 1.0)    ; sharp - dbl flat
       (   0 2.4 2.4 2.4 2.4 2.4 2.4 2.4 2.0 1.5 1.0)    ; sharp - flat
       ( 2.4 2.4 2.4 2.4 2.4 2.4 2.4 2.4 2.0 1.5 1.0)    ; sharp - natural
       ( 2.4 2.4 2.4 2.4 2.4 2.4 2.4 2.4 2.4 2.0 2.0)    ; sharp - sharp
       (   0 2.4 2.4 2.4 2.4 2.4 2.4 2.4 2.4   0   0))   ; sharp - dbl sharp
      ((   0   0 2.4 2.4 2.4 2.4 2.4 2.4   2   1   0)    ; dbl sharp - dbl flat
       (   0   0 2.4 2.4 2.4 2.4 2.4 2.4   2   1   0)    ; dbl sharp - flat
       (   0   0 2.4 2.4 2.4 2.4 2.4 2.4   2   1   0)    ; dbl sharp - natural
       (   0 2.8 2.8 2.8 2.8 2.8 2.8 2.8 2.8 2.8   0)    ; dbl sharp - sharp
       (   0   0   0 2.8 2.8 2.8 2.8 2.8   0   0   0)))) ; dbl sharp - dbl sharp

;;; given 1) a type of accidental 2) its position (in staff steps) 3)
;;; a type of accidental or a type of notehead, and 4) its position,
;;; return the x offset of the first accidental, i.e., how many staff
;;; steps to the left that it must be moved in order to avoid overlap
;;; with the second one.
(defun accidental-distance (acc1 pos1 acc2 pos2)
  (let ((dist (- pos2 pos1)))
    (if (> (abs dist) 5)
	0
	(aref *accidental-offset*
	      (ecase acc2
		(:notehead 0)
		(:double-flat 1)
		(:flat 2)
		(:natural 3)
		(:sharp 4)
		(:double-sharp 5))
	      (ecase acc1
		(:double-flat 0)
		(:flat 1)
		(:natural 2)
		(:sharp 3)
		(:double-sharp 4))
	      (+ dist 5)))))		

;;; given two notes (where the first one has an accidental, and the
;;; second one may or may not have an accidental) and the conversion
;;; factor between staff steps and x positions, compute the x offset
;;; of the accidental of the first note.  If the second note has 
;;; an accidental, but that has not been given a final x offset, then 
;;; use the x offset of the notehead instead.
(defun accidental-relative-xoffset (note1 note2 staff-step)
  (let* ((acc1 (final-accidental note1))
	 (pos1 (note-position note1))
	 (acc2 (if (and (final-accidental note2)
			(final-relative-accidental-xoffset note2))
		   (final-accidental note2)
		   :notehead))
	 (pos2 (note-position note2))
	 (xpos2 (or (final-relative-accidental-xoffset note2)
		    (final-relative-note-xoffset note2))))
    (- xpos2 (* staff-step (accidental-distance acc1 pos1 acc2 pos2)))))

;;; given a note and a list of notes, compute x offset of the accidental
;;; of the note as required by each of the notes in the list.  In order
;;; for the accidental of the note not to overlap any of the others, 
;;; we must use the minimum of all the x offsets thus computed. 
(defun accidental-min-xoffset (note1 notes staff-step)
  (reduce #'min notes :key (lambda (note) (accidental-relative-xoffset note1 note staff-step))))

;;; given a list of notes that have accidentals to place, and a list of 
;;; notes that either have no accidentals or with already-placed accidentals, 
;;; compute the note in the first list that can be placed as far to the right 
;;; as possible.
(defun best-accidental (notes-with-accidentals notes staff-step)
  (reduce (lambda (note1 note2) (if (>= (accidental-min-xoffset note1 notes staff-step)
					(accidental-min-xoffset note2 notes staff-step))
				    note1
				    note2))
	  notes-with-accidentals))  

;;; for each note in a list of notes, if it has an accidental, compute
;;; the final relative x offset of that accidental and store it in the note. 
(defun compute-final-relative-accidental-xoffset (notes x final-stem-direction)
  (let* ((staff-step (score-pane:staff-step 1))
	 ;; sort the notes from top to bottom
	 (notes (sort (copy-list notes)
		      (lambda (x y) (> (note-position x) (note-position y)))))
	 (notes-with-accidentals (remove-if-not #'final-accidental notes)))
    ;; initially, no accidental has been placed
    (loop for note in notes do (setf (final-relative-accidental-xoffset note) nil))
    (when (eq final-stem-direction :up)
      ;; when the stem direction is :up and there is a suspended note
      ;; i.e., one to the right of the stem, then the accidental of the topmost
      ;; suspended note is placed first. 
      (let ((first-suspended-note
	     (find x notes-with-accidentals :test #'/= :key #'final-relative-note-xoffset)))
	(when first-suspended-note
	  (setf notes-with-accidentals
		(remove first-suspended-note notes-with-accidentals))
	  (setf (final-relative-accidental-xoffset first-suspended-note)
		(accidental-min-xoffset first-suspended-note notes staff-step)))))
    ;; place remaining accidentals
    (loop while notes-with-accidentals
	  do (let ((choice (best-accidental notes-with-accidentals notes staff-step)))
	       (setf notes-with-accidentals
		     (remove choice notes-with-accidentals))
	       (setf (final-relative-accidental-xoffset choice)
		     (accidental-min-xoffset choice notes staff-step))))))

;;; given a list of notes, group them so that every note in the group
;;; is displayed on the same staff.  Return the list of groups. 
(defun group-notes-by-staff (notes)
  (let ((groups '()))
    (loop while notes do
	  (push (remove (staff (car notes)) notes :test-not #'eq :key #'staff) groups)
	  (setf notes (remove (staff (car notes)) notes :test #'eq :key #'staff)))
    groups))

;;; draw a cluster.  The stem direction and the stem position have
;;; already been computed.  
;;; 1. Group notes by staff.
;;; 2. Determine which notes in each group go to the left and which notes
;;;    go to the right of the stem.  
;;; 3. Determine which notes in each group should be displayed with an accidental.  
;;; 4. Compute the x offset of each accidental to be displayed. 
;;; 5. Draw the notes in each group
;;; 6. If necessary, draw ledger lines for notes in a group
;;; 7. Draw the stem, if any
(defmethod draw-element (pane (element cluster) x &optional (flags t))
  (when (notes element)
    (let ((direction (final-stem-direction element))
	  (stem-pos (final-stem-position element))
	  (stem-yoffset (final-stem-yoffset element))
	  (groups (group-notes-by-staff (notes element))))
      (when flags
	(score-pane:with-vertical-score-position (pane stem-yoffset)
	  (draw-flags pane element x direction stem-pos)))
      (loop for group in groups do 
	    (compute-final-relative-note-xoffsets group direction)
	    (compute-final-accidentals group)
	    (compute-final-relative-accidental-xoffset group x direction)
	    (draw-notes pane group (dots element) (notehead element))
	    (draw-ledger-lines pane x group))
      (unless (eq (notehead element) :whole)
	(if (eq direction :up)
	    (score-pane:draw-right-stem
	     pane x
	     (- (bot-note-staff-yoffset element) (score-pane:staff-step (bot-note-pos element)))
	     (- stem-yoffset (score-pane:staff-step stem-pos)))
	    (score-pane:draw-left-stem
	     pane x
	     (- (top-note-staff-yoffset element) (score-pane:staff-step (top-note-pos element)))
	     (- stem-yoffset (score-pane:staff-step stem-pos))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Rest

(defmethod draw-element (pane (element rest) x &optional (flags t))
  (declare (ignore flags))
  (score-pane:with-vertical-score-position (pane (staff-yoffset (staff element)))
    (score-pane:draw-rest pane (undotted-duration element) x (staff-pos element))
    (draw-dots pane (dots element) x (1+ (staff-pos element)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Lyrics element

(defmethod draw-element (pane (element lyrics-element) x &optional (flags t))
  (declare (ignore flags))
  (score-pane:with-vertical-score-position (pane (staff-yoffset (staff element)))
    (with-text-family (pane :serif)
      (draw-text* pane (map 'string 'code-char (text element))
                  x 0 :align-x :center))))
