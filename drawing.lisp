(in-package :gsharp-drawing)

(define-added-mixin dstaff () staff
  ((yoffset :initform 0 :accessor staff-yoffset)))

(define-added-mixin dnote () note
  ((final-xposition :accessor final-xposition)
   (final-accidental :initform nil :accessor final-accidental)
   ;; nil indicates that accidental has not been placed yet
   (accidental-position :initform nil :accessor accidental-position)))

(define-presentation-method present
    (object (type score-pane:clef) stream (view textual-view) &key)
  (format stream "[~a clef on staff step ~a]" (name object) (lineno object)))

(define-presentation-method present
    (object (type score-pane:staff) stream (view textual-view) &key)
   (format stream "[staff ~a]" (name object)))

(defmethod draw-staff-and-clef (pane (staff staff) x1 x2)
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
	   `((score-pane:staff)
	     :x1 ,x1 :x2 ,x2)
	   :stream pane))

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
					 (score-pane:staff-step 8)
					 (staff-yoffset (car (last staves)))))))

(defmethod draw-buffer (pane (buffer buffer) *cursor* x y draw-cursor)
  (score-pane:with-staff-size 6
    (let* ((staves (staves buffer))
	   (timesig-offset (max (* (score-pane:staff-step 2)
				   (loop for staff in staves
					 maximize (count :flat (keysig staff))))
				(* (score-pane:staff-step 2.5)
				   (loop for staff in staves
					 maximize (count :sharp (keysig staff))))))
	   (method (let ((old-method (buffer-cost-method buffer)))
		     (make-measure-cost-method (min-width old-method)
					       (spacing-style old-method)
					       (- (line-width old-method) timesig-offset))))
	   (right-edge (right-edge buffer)))
      (loop for staff in staves
	    for offset downfrom 0 by 90 do
	    (setf (staff-yoffset staff) offset))
      (let ((yy y))
	(gsharp-measure::new-map-over-obseq-subsequences
	 (lambda (measures)
	   (let ((widths (compute-widths measures method)))
	     (score-pane:with-vertical-score-position (pane yy)
	       (draw-system pane measures (+ x (left-offset buffer) timesig-offset)
			    widths method staves draw-cursor)
	       (score-pane:draw-bar-line pane x
					 (score-pane:staff-step 8)
					 (staff-yoffset (car (last staves)))))
	     (loop for staff in staves do
		   (score-pane:with-vertical-score-position (pane yy)
		     (if (member staff (staves (layer (slice (bar *cursor*)))))
			 (draw-staff-and-clef pane staff x right-edge)
			 (score-pane:with-light-glyphs pane
			   (draw-staff-and-clef pane staff x right-edge))))
		   (decf yy 90))))
	 buffer)))))

(define-added-mixin velement () element
  ((final-stem-direction :accessor final-stem-direction)
   (final-stem-position :accessor final-stem-position)
   (final-stem-yoffset :initform 0 :accessor final-stem-yoffset)
   (minpos :accessor element-minpos)
   (min-yoffset :accessor element-min-yoffset)
   (maxpos :accessor element-maxpos)
   (max-yoffset :accessor element-max-yoffset)
   (xpos :accessor element-xpos)))

(defun compute-maxpos-minpos (element)
  (if (and (typep element 'cluster) (notes element))
      (let ((max-note (reduce (lambda (n1 n2)
				(cond ((> (staff-yoffset (staff n1))
					  (staff-yoffset (staff n2)))
				       n1)
				      ((< (staff-yoffset (staff n1))
					  (staff-yoffset (staff n2)))
				       n2)
				      ((> (note-position n1)
					  (note-position n2))
				       n1)
				      (t n2)))
			      (notes element)))
	    (min-note (reduce (lambda (n1 n2)
				(cond ((< (staff-yoffset (staff n1))
					  (staff-yoffset (staff n2)))
				       n1)
				      ((> (staff-yoffset (staff n1))
					  (staff-yoffset (staff n2)))
				       n2)
				      ((< (note-position n1)
					  (note-position n2))
				       n1)
				      (t n2)))
			      (notes element))))
	(setf (element-maxpos element) (note-position max-note)
	      (element-minpos element) (note-position min-note)
	      (element-max-yoffset element) (staff-yoffset (staff max-note))
	      (element-min-yoffset element) (staff-yoffset (staff min-note))))
      (setf (element-maxpos element) 4
	    (element-minpos element) 4
	    ;; clearly wrong.  should be taken from element or layer.
	    (element-min-yoffset element) 0
	    (element-max-yoffset element) 0)))

(defun compute-stem-direction (element)
  (setf (final-stem-direction element)
	(if (or (eq (stem-direction element) :up) (eq (stem-direction element) :down))
	    (stem-direction element)
	    (let ((max-pos (element-maxpos element))
		  (min-pos (element-minpos element)))
	      (if (>= (- max-pos 4)
		      (- 4 min-pos))
		  :down
		  :up)))))

(defun compute-stem-length (element)
  (let* ((max-pos (element-maxpos element))
	 (min-pos (element-minpos element))
	 (max-note (reduce (lambda (n1 n2)
			     (cond ((> (staff-yoffset (staff n1))
				       (staff-yoffset (staff n2)))
				    n1)
				   ((< (staff-yoffset (staff n1))
				       (staff-yoffset (staff n2)))
				    n2)
				   ((> (note-position n1)
				       (note-position n2))
				    n1)
				   (t n2)))
			   (notes element)))
	 (min-note (reduce (lambda (n1 n2)
			     (cond ((< (staff-yoffset (staff n1))
				       (staff-yoffset (staff n2)))
				    n1)
				   ((> (staff-yoffset (staff n1))
				       (staff-yoffset (staff n2)))
				    n2)
				   ((< (note-position n1)
				       (note-position n2))
				    n1)
				   (t n2)))
			   (notes element)))
	 (length (if (eq (final-stem-direction element) :up)
		     (cond ((<= max-pos -3) (- 4 max-pos))
			   ((<= max-pos 3) 7)
			   ((= max-pos 4) 6)
			   (t 5))
		     (cond ((>= min-pos 11) (- min-pos 4))
			   ((>= min-pos 4) 7)
			   ((= min-pos 3) 6)
			   (t 5))))
	 (nb-flags (max (rbeams element) (lbeams element))))
    (when (> nb-flags 0)
      (setf length (max length
			(+ (if (eq (final-stem-direction element) :up) 6 7)
			   (* 2 (max 0 (- nb-flags 2)))))))
    (setf (final-stem-yoffset element)
	  (staff-yoffset (staff (if (eq (final-stem-direction element) :up)
				    max-note min-note))))
    (setf (final-stem-position element)
	  (if (eq (final-stem-direction element) :up)
	      (+ max-pos length)
	      (- min-pos length)))))

(defun compute-appearance (element)
  (when (typep element 'cluster)
    (compute-stem-direction element)
    (compute-stem-length element)))

(defun compute-element-x-positions (bar x time-alist)
  (let (;;(time-alist (time-alist bar))
	(start-time 0))
    (mapc (lambda (element)
	    (setf (element-xpos element)
		  (+ x
		     (score-pane:staff-step (xoffset element))
		     (cdr (assoc start-time time-alist))))
	    (incf start-time (duration element)))
	  (elements bar))))

(defun compute-stem-directions (elements)
  (if (not (eq (stem-direction (car elements)) :auto))
      (stem-direction (car elements))
      (let ((max-pos (reduce #'max elements :key #'element-maxpos))
	    (min-pos (reduce #'min elements :key #'element-minpos)))
	(if (>= (- max-pos 4) (- 4 min-pos)) :down :up))))

(defun dominating-note (notes stem-direction)
  (reduce (lambda (n1 n2)
	    (let ((yoff1 (staff-yoffset (staff n1)))
		  (yoff2 (staff-yoffset (staff n2))))
	      (if (eq stem-direction :up)
		  (if (> yoff1 yoff2)
		      n1 
		      (if (< yoff1 yoff2)
			  n2
			  (if (> (pitch n1) (pitch n2)) n1 n2)))
		  (if (< yoff1 yoff2)
		      n1
		      (if (> yoff1 yoff2)
			  n2
			  (if (< (pitch n1) (pitch n2)) n1 n2))))))
	  notes))

(defun draw-beam-group (pane elements)
  (mapc #'compute-maxpos-minpos elements)
  (if (null (cdr elements))
      (when (or (typep (car elements) 'rest) (notes (car elements)))
	(compute-appearance (car elements))
	(draw-element pane (car elements) (element-xpos (car elements))))
      (let* ((stem-direction (compute-stem-directions elements))
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
	(loop for element in elements do
	      (setf (final-stem-direction element) stem-direction))
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
  (draw-line* pane x (score-pane:staff-step -4) x (score-pane:staff-step 12) :ink +red+))

(defmethod draw-bar (pane (bar bar) x width time-alist draw-cursor)
  (compute-element-x-positions bar x time-alist)
  (let ((elements (elements bar))
	(group '()))
    (loop while (not (null elements)) do
	  (setf group '())
	  (push (pop elements) group)
	  (loop while (and (not (null elements))
			   (> (rbeams (car group)) 0)
			   (> (lbeams (car elements)) 0))
		do (push (pop elements) group))
	  (draw-beam-group pane (nreverse group))))
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
	   (max-pos (reduce #'max positions))
	   (min-pos (reduce #'min positions)))
      (loop for pos from 10 to max-pos by 2
	    do (score-pane:draw-ledger-line pane x pos))
      (loop for pos from -2 downto min-pos by 2
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
      (score-pane:draw-accidental pane (final-accidental note) (accidental-position note) pos))
    (draw-dots pane nb-dots x pos)))

(defun draw-notes (pane notes dots notehead)
  (loop for note in notes do
	(draw-note pane note notehead dots (final-xposition note) (note-position note))))

(defun compute-final-xpositions (group x direction)
  (setf group (sort (copy-list group)
		    (if (eq direction :up)
			(lambda (x y) (< (note-position x) (note-position y)))
			(lambda (x y) (> (note-position x) (note-position y))))))
  (score-pane:with-suspended-note-offset offset
    (setf (final-xposition (car group)) x)
    (when (eq direction :down) (setf offset (- offset)))
    (loop for note in (cdr group)
	  and old-note = (car group) then note
	  do (let* ((pos (note-position note))
		    (old-pos (note-position old-note))
		    (dx (if (= (abs (- pos old-pos)) 1) offset 0))) 
	       (setf (final-xposition note) (+ x dx))
	       ;; go back to ordinary offset
	       (when (= (abs (- pos old-pos)) 1)
		 (setf note old-note))))))

(defun compute-final-accidentals (group)
  (loop for note in group do
	(setf (final-accidental note)
	      (if (eq (accidentals note)
		      (aref (keysig (staff note)) (mod (pitch note) 7)))
		  nil
		  (accidentals note)))))

(defun element-has-suspended-notes (element)
  (not (apply #'= (mapcar #'final-xposition (notes element)))))

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

(defun accidental-xpos (note1 note2 staff-step)
  (let* ((acc1 (final-accidental note1))
	 (pos1 (note-position note1))
	 (acc2 (if (and (final-accidental note2)
			(accidental-position note2))
		   (final-accidental note2)
		   :notehead))
	 (pos2 (note-position note2))
	 (xpos2 (or (accidental-position note2)
		    (final-xposition note2))))
    (- xpos2 (* staff-step (accidental-distance acc1 pos1 acc2 pos2)))))

(defun accidental-min-xpos (note1 notes staff-step)
  (reduce #'min notes :key (lambda (note) (accidental-xpos note1 note staff-step))))

(defun best-accidental (notes-with-accidentals notes staff-step)
  (reduce (lambda (note1 note2) (if (>= (accidental-min-xpos note1 notes staff-step)
					(accidental-min-xpos note2 notes staff-step))
				    note1
				    note2))
	  notes-with-accidentals))  

(defun compute-final-accidental-positions (notes x final-stem-direction)
  (let* ((staff-step (score-pane:staff-step 1))
	 (notes (sort (copy-list notes)
		      (lambda (x y) (> (note-position x) (note-position y)))))
	 (notes-with-accidentals (remove-if-not #'final-accidental notes)))
    ;; initially, no accidental has been placed
    (loop for note in notes do (setf (accidental-position note) nil))
    (when (eq final-stem-direction :up)
      (let ((first-suspended-note
	     (find x notes-with-accidentals :test #'/= :key #'final-xposition)))
	(when first-suspended-note
	  (setf notes-with-accidentals
		(remove first-suspended-note notes-with-accidentals))
	  (setf (accidental-position first-suspended-note)
		(accidental-min-xpos first-suspended-note notes staff-step)))))
    ;; place remaining accidentals
    (loop while notes-with-accidentals
	  do (let ((choice (best-accidental notes-with-accidentals notes staff-step)))
	       (setf notes-with-accidentals
		     (remove choice notes-with-accidentals))
	       (setf (accidental-position choice)
		     (accidental-min-xpos choice notes staff-step))))))

(defun group-notes-by-staff (notes)
  (let ((groups '()))
    (loop while notes do
	  (push (remove (staff (car notes)) notes :test-not #'eq :key #'staff) groups)
	  (setf notes (remove (staff (car notes)) notes :test #'eq :key #'staff)))
    groups))

(defmethod draw-element (pane (element cluster) x &optional (flags t))
  (when (notes element)
    (let ((max-pos (element-maxpos element))
	  (min-pos (element-minpos element))
	  (max-yoffset (element-max-yoffset element))
	  (min-yoffset (element-min-yoffset element))
	  (direction (final-stem-direction element))
	  (stem-pos (final-stem-position element))
	  (stem-yoffset (final-stem-yoffset element))
	  (groups (group-notes-by-staff (notes element))))
      (when flags
	(score-pane:with-vertical-score-position (pane stem-yoffset)
	  (draw-flags pane element x direction stem-pos)))
      (loop for group in groups do 
	    (compute-final-xpositions group x direction)
	    (compute-final-accidentals group)
	    (compute-final-accidental-positions group x direction)
	    (draw-notes pane group (dots element) (notehead element))
	    (draw-ledger-lines pane x group))
      (unless (eq (notehead element) :whole)
	(if (eq direction :up)
	    (score-pane:draw-right-stem pane x
					(+ (score-pane:staff-step min-pos) min-yoffset)
					(+ (score-pane:staff-step stem-pos) stem-yoffset))
	    (score-pane:draw-left-stem pane x
				       (+ (score-pane:staff-step max-pos) max-yoffset)
				       (+ (score-pane:staff-step stem-pos) stem-yoffset)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Rest

(defmethod draw-element (pane (element rest) x &optional (flags t))
  (declare (ignore flags))
  (score-pane:with-vertical-score-position (pane (staff-yoffset (staff element)))
    (score-pane:draw-rest pane (notehead-duration element) x (staff-pos element))
    (draw-dots pane (dots element) x (1+ (staff-pos element)))))

