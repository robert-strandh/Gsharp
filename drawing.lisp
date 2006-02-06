(in-package :gsharp-drawing)

(defclass x-y-width-mixin ()
  (;; indicates the absolute y position of the system to which the 
   ;; object belongs
   (system-y-position :accessor system-y-position)
   ;; the absolute x position of the object
   (final-absolute-measure-xoffset :accessor final-absolute-measure-xoffset)
   (final-width :accessor final-width)))

(define-added-mixin dbar (x-y-width-mixin) bar
  ())

(define-added-mixin dmeasure (x-y-width-mixin) measure
  (;; an elasticity function that describes how the space right after
   ;; the initial barline of the measure behaves as a function of the
   ;; force that is applied to it.
   (prefix-elasticity-function :accessor prefix-elasticity-function)))

(define-added-mixin dstaff () staff
  ((yoffset :initform 0 :accessor staff-yoffset)))

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
		     (:c (- (lineno (clef staff)) 1)))))
      (loop for pitch in '(6 2 5 1 4 0 3)
	    for line in '(0 3 -1 2 -2 1 -3)
	    for x from (+ x1 10 (score-pane:staff-step 8)) by (score-pane:staff-step 2)
	    while (eq (aref (keysig staff) pitch) :flat)
	    do (score-pane:draw-accidental pane :flat x (+ line yoffset))))
    (let ((yoffset (ecase (name (clef staff))
		     (:bass (lineno (clef staff)))
		     (:treble (+ (lineno (clef staff)) 6))
		     (:c (+ (lineno (clef staff)) 3)))))
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
  (+ (final-absolute-element-xoffset (cluster note)) (final-relative-note-xoffset note)))

;;; Return the final absolute x offset of the accidental of a note.
;;; This value is computed from the x offset of the cluster of the
;;; note and the relative x offset of the accidental of the note with
;;; respect to the cluster.
(defun final-absolute-accidental-xoffset (note)
  (+ (final-absolute-element-xoffset (cluster note)) (final-relative-accidental-xoffset note)))

(defvar *cursor* nil)

;;; Compute the elasticity of each timeline in each measure of the
;;; measures of a system (line) by taking its duration to the power of
;;; the spaceing style.  This metric is arbitrarily normalized to the
;;; duration of a whole note, which means that the force to apply to a
;;; line is not comparable between two different lines.  All we know
;;; is that timelines with the same elasticity will grow and shrink in
;;; parallel, and that proportions between two timelines of different
;;; durations will be preserved. 
(defun compute-elasticities (measures method)
  (loop for measure in measures
	do (loop with timelines = (timelines measure)
		 for i from 0 below (flexichain:nb-elements timelines)
		 for timeline = (flexichain:element* timelines i)
		 do (setf (elasticity timeline)
			  (max (expt (duration timeline) (spacing-style method)) 0.0001)))))

;;; FIXME: there should be an :around method that adds the value
;;; return by the main method to the explicit horizontal offset that
;;; the user wants to impose on an element, and the existence of this 
;;; around method should be documented.
;;; FIXME: we should probably also allow for the user to introduce
;;; explicit (positive or negative) bulges that will be added in by
;;; the :around method, thus allowing the user to explicitly move two
;;; adjacent elements further apart, or to bring them closer together. 
(defgeneric left-bulge (element pane)
  (:documentation "The amount by which an element sticks out to the
left of the center of its timeline"))

;;; FIXME: there should be an :around method that adds the value
;;; return by the main method to the explicit horizontal offset that
;;; the user wants to impose on an element, and the existence of this
;;; around method should be documented.  
;;; FIXME: we should probably also allow for the user to introduce
;;; explicit (positive or negative) bulges that will be added in by
;;; the :around method, thus allowing the user to explicitly move two
;;; adjacent elements further apart, or to bring them closer together. 
(defgeneric right-bulge (element pane)
  (:documentation "The amount by which an element sticks out to the
right of the center of its timeline"))

(defmethod left-bulge ((element element) pane)
  (score-pane:staff-step 1))

(defmethod left-bulge ((element lyrics-element) pane)
  (+ (score-pane:staff-step 0.5)
     (/ (text-size pane (map 'string 'code-char (text element))) 2)))

(defmethod left-bulge ((element cluster) pane)
  (+ (max (- (loop for note in (notes element)
		   when (final-accidental note)
		   minimize (final-relative-accidental-xoffset note)))
	  (if (and (non-empty-cluster-p element)
		   (eq (final-stem-direction element) :down)
		   (element-has-suspended-notes element))
	      (score-pane:staff-step 3)
	      (score-pane:staff-step 0)))
     (score-pane:staff-step 2)))

(defmethod right-bulge ((element element) pane)
  (score-pane:staff-step 1))

(defmethod right-bulge ((element lyrics-element) pane)
  (+ (score-pane:staff-step 0.5)
     (/ (text-size pane (map 'string 'code-char (text element))) 2)))

(defmethod right-bulge ((element cluster) pane)
  (if (and (non-empty-cluster-p element)
	   (eq (final-stem-direction element) :up)
	   (element-has-suspended-notes element))
      (score-pane:staff-step 5)
      (score-pane:staff-step 2)))

;;; As it turns out, the spacing algorithm would be very complicated
;;; if we were to take into account exactly how elements with
;;; arbitrarily many timelines between them might influence the
;;; overall layout.  Instead we apprixmate by obtaining a closest gap
;;; only between adjacent timelines as follows: first, we consider
;;; adjacent elements whose timelines are also adjacent (and there is
;;; a special case for the last element of a layer), and set the
;;; smallest gap between the timelines to the closest possible
;;; distance between the two elements...
(defun compute-gaps-adjacent-timelines (bars method pane)
  (declare (ignore method))
  (loop for bar in bars
	do (loop for (e1 e2) on (elements bar)
		 for t1 = (timeline e1)
		 do (cond ((null e2)
			   (when (flexichain:flexi-last-p t1)
			     (setf (smallest-gap t1)
				   (max (smallest-gap t1)
					(right-bulge e1 pane)))))
			  ((eq (flexichain:flexi-next t1)
			       (timeline e2))
			   (setf (smallest-gap t1)
				 (max (smallest-gap t1)
				      (+ (right-bulge e1 pane)
					 (left-bulge e2 pane)))))))))

;;; ... Then we consider adjacent elements whose timelines are
;;; separated by at least one other timeline.  If the sum of the
;;; distances between individual timelines is greater than or equal to
;;; the closest distance between the adjacent elements (which is
;;; likely if we are talking melody), then there is nothing to do,
;;; since the individual distances are more restrictive than that
;;; imposed by the adjacent elements.  If not, we try to distribute
;;; the closest distance between the two adjacent elements over the
;;; individual timelines proportionally to the elasticity of the
;;; timlines.  If in doing so, we find that some timeline already has
;;; a smallest gap that is larger than the fraction of the closest
;;; distance between adjacent elements that we attribute to it, then
;;; that smallest gap is subtracted from the distance we need to
;;; distribute, the timeline is removed from consideration, and we
;;; start over.  This process must terminate (or else, the sum of the
;;; closest gaps must have been larger than the distance to distribute
;;; in the first place) with at least one timeline to distribute over.
;;; There is a special case here, which occurs when all the
;;; elasticites of the timelines to be considered is zero.  In this
;;; case, instead of distributing proportionally to the elasticities
;;; of individual timelies, we distribute evenly between the timelines.
(defun compute-gaps-separated-timelines (bars method pane)
  (declare (ignore method))
  (flet ((handle-timelines (timelines element-gap)
	   (let ((sum-gap (reduce #'+ timelines :key #'smallest-gap))
		 (sum-elasticity (reduce #'+ timelines :key #'elasticity)))
	     (unless (> sum-gap element-gap)
	       (if (zerop sum-elasticity)
		   (loop for timeline = (find (/ element-gap (length timelines))
					      timelines
					      :key #'smallest-gap
					      :test #'<)
			 until (null timeline)
			 do (decf element-gap (smallest-gap timeline))
			 do (setf timelines (remove timeline timelines :test #'eq))
			 finally (let ((gap (/ element-gap (length timelines))))
				   (loop for timeline in timelines
					 do (setf (smallest-gap timeline) gap))))
		   (loop for timeline = (let ((gap/elasticity (/ element-gap sum-elasticity)))
					  (find-if (lambda (timeline)
						     (> (smallest-gap timeline)
							(* (elasticity timeline) gap/elasticity)))
						   timelines))
			 until (null timeline)
			 do (decf element-gap (smallest-gap timeline))
			 do (decf sum-elasticity (elasticity timeline))
			 do (setf timelines (remove timeline timelines :test #'eq))
			 finally (let ((gap/elasticity (/ element-gap sum-elasticity)))
				   (loop for timeline in timelines
					 do (setf (smallest-gap timeline)
						  (* (elasticity timeline) gap/elasticity))))))))))
    (loop for bar in bars
	  do (loop for (e1 e2) on (elements bar)
		   for t1 = (timeline e1)
		   do (cond ((null e2)
			     (unless (flexichain:flexi-last-p t1)
			       (let ((timelines (loop for tl = t1 then (flexichain:flexi-next tl)
						      collect tl
						      until (flexichain:flexi-last-p tl))))
				 (handle-timelines timelines (right-bulge e1 pane)))))
			    ((not (eq (flexichain:flexi-next t1)
				      (timeline e2)))
			     (let ((timelines (loop for tl = t1 then (flexichain:flexi-next tl)
						    until (eq tl (timeline e2))
						    collect tl)))
			       (handle-timelines timelines (+ (right-bulge e1 pane)
							      (left-bulge e2 pane))))))))))

(defun compute-gaps (measures method pane)
  (loop for measure in measures
	;; initially, look only at adjacent elements whose
	;; corrsponding timelines are also adjacent, and at the last
	;; element of a bar, provided that its timeline is also the
	;; last one in the measure
	do (compute-gaps-adjacent-timelines (measure-bars measure) method pane)
	
	;; then look at adjacent elements whose corresponding
	;; timelines are NOT adjacent, or the last element of a bar
	;; whose corresponding timeline is not the last one in the meaure
	do (compute-gaps-separated-timelines (measure-bars measure) method pane)))

;;; When this function is called, each timeline has an elasticity and
;;; a smallest gap to the next adjacent timline (or to the end of the
;;; measure).  These values, together with an elasticity function at
;;; the beginning of a measure, are used to compute the total
;;; elasticity function of a measure.
(defun compute-elasticity-functions (measures method pane)
  (loop for measure in measures
	do (setf (prefix-elasticity-function measure)
		 (let ((prefix-width
			(max (min-width method)
			     (if (zerop (flexichain:nb-elements (timelines measure)))
				 0
				 (loop for element in (elements (flexichain:element* (timelines measure) 0))
				       maximize (left-bulge element pane))))))
		   (make-elementary-elasticity prefix-width 0.0001)))
	do (loop with result = (prefix-elasticity-function measure)
		 with timelines = (timelines measure)
		 for i from 0 below (flexichain:nb-elements timelines)
		 for timeline = (flexichain:element* timelines i)
		 do (setf result
			  (add-elasticities
			   result
			   (make-elementary-elasticity (smallest-gap timeline) (elasticity timeline))))
		 finally (setf (elasticity-function measure) result)))
  (reduce #'add-elasticities measures :key #'elasticity-function))

(defun compute-measure-coordinates (measure x y force)
  (loop with timelines = (timelines measure)
	for i from 0 below (flexichain:nb-elements timelines)
	for timeline = (flexichain:element* timelines i)
	and xx = (+ x (size-at-force (prefix-elasticity-function measure) force))
                 then (+ xx (max (smallest-gap timeline)
				 (* force (elasticity timeline))))
        do (loop for element in (elements timeline)
		 do (setf (final-absolute-element-xoffset element) xx)))
  (loop for bar in (measure-bars measure)
	do (compute-bar-coordinates bar x y (size-at-force (elasticity-function measure) force))))

(defun draw-measure (pane measure)
  (loop for bar in (measure-bars measure) do
	(if (gsharp-cursor::cursors (slice bar))
	    (draw-bar pane bar)
	    (score-pane:with-light-glyphs pane (draw-bar pane bar))))
  (let ((first-bar (car (measure-bars measure))))
    (let ((x (final-absolute-measure-xoffset first-bar))
	  (y (system-y-position first-bar))
	  (width (final-width first-bar))
	  (staves (staves (buffer (segment (layer (slice first-bar)))))))
      (score-pane:draw-bar-line pane (+ x width)
				(+ y (- (score-pane:staff-step 8)))
				(+ y (staff-yoffset (car (last staves))))))))

(defun compute-system-coordinates (measures x y force)
  (loop for measure in measures
	do (compute-measure-coordinates measure x y force)
	do (incf x (size-at-force (elasticity-function measure) force))))

(defun draw-system (pane measures)
  (loop for measure in measures do
	(draw-measure pane measure)))

(defmethod draw-buffer (pane (buffer buffer) *cursor* x y)
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
	    (setf (staff-yoffset staff) offset))
      (let ((yy y))
	(gsharp-measure::new-map-over-obseq-subsequences
	 (lambda (measures)
	   (compute-elasticities measures method)
	   (compute-gaps measures method pane)
	   (let* ((e-fun (compute-elasticity-functions measures method pane))
		  ;; FIXME:  it would be much better to compress the system
		  ;; proportionally, so that every smallest gap gets shrunk
		  ;; by the same percentage
		  (force (if (> (zero-force-size e-fun) (line-width method))
			     0 
			     (force-at-size e-fun (line-width method)))))
	     (compute-system-coordinates measures
					 (+ x (left-offset buffer) timesig-offset) yy
					 force))
	   (draw-system pane measures)
	   (score-pane:draw-bar-line pane x
				     (+ yy (- (score-pane:staff-step 8)))
				     (+ yy (staff-yoffset (car (last staves)))))
	   (loop for staff in staves do
		 (score-pane:with-vertical-score-position (pane yy)
		    (if (member staff (staves (layer (slice (bar *cursor*)))))
			(draw-staff-and-clef pane staff x right-edge)
			(score-pane:with-light-glyphs pane
			  (draw-staff-and-clef pane staff x right-edge))))
		 (incf yy 90)))
	 buffer)))))

(define-added-mixin velement () melody-element
  (;; the position, in staff steps, of the end of the stem
   ;; that is not attached to a note, independent of the
   ;; staff on which it is located
   (final-stem-position :accessor final-stem-position)
   ;; the yoffset of the staff relative to which the end of the
   ;; stem is located
   (final-stem-yoffset :initform 0 :accessor final-stem-yoffset)
   ;; the yoffset of the staff that contains the top note of
   ;; the element
   (top-note-staff-yoffset :accessor top-note-staff-yoffset)
   ;; the yoffset of the staff that contains the bottom note of
   ;; the element
   (bot-note-staff-yoffset :accessor bot-note-staff-yoffset)
   (final-absolute-xoffset :accessor final-absolute-element-xoffset)))

(define-added-mixin welement () lyrics-element
  ((final-absolute-xoffset :accessor final-absolute-element-xoffset)))

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
  (let ((start-time 0))
    (mapc (lambda (element)
	    (setf (final-absolute-element-xoffset element)
		  (round (+ x
			    (score-pane:staff-step (xoffset element))
			    (cdr (assoc start-time time-alist)))))
	    (incf start-time (duration element)))
	  (elements bar))))

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

(defun draw-beam-group (pane elements)
  (mapc #'compute-top-bot-yoffset elements)
  (if (null (cdr elements))
      (let ((element (car elements)))
	(when (or (typep element 'rest) (notes element))
	  (when (non-empty-cluster-p element)
	    (compute-stem-length element))
	  (draw-element pane element)))
      (let* ((stem-direction (final-stem-direction (car elements)))
	     (dominating-notes
	      (loop for element in elements
		    when (non-empty-cluster-p element)
		    collect (dominating-note (notes element) stem-direction)))
	     (dominating-staff
	      (staff (dominating-note dominating-notes stem-direction)))
	     (positions (mapcar (lambda (n)
				  (if (eq (staff n) dominating-staff)
				      (note-position n)
				      (if (eq stem-direction :up) -1000 1000)))
				dominating-notes))
	     (x-positions (mapcar (lambda (element)
				    (/ (final-absolute-element-xoffset element) (score-pane:staff-step 1)))
				  elements))
	     (nb-beams (mapcar (lambda (element)
				 (max (lbeams element) (rbeams element)))
			       elements))
	     (beaming (beaming-single (mapcar #'list positions x-positions nb-beams) stem-direction))
	     (max-nb-beams (reduce #'max nb-beams))
	     (min-nb-beams (reduce #'min nb-beams)))
	(destructuring-bind ((ss1 . offset1) (ss2 . offset2)) beaming
	  (let* ((y1 (+ ss1 (* 1/2 offset1)))
		 (y2 (+ ss2 (* 1/2 offset2)))
		 (x1 (final-absolute-element-xoffset (car elements)))
		 (x2 (final-absolute-element-xoffset (car (last elements))))
		 (slope (/ (- y2 y1) (- x2 x1))))
	    (if (eq stem-direction :up)
		(loop for element in elements do
		      (setf (final-stem-position element)
			    (+ y1 (* slope (- (final-absolute-element-xoffset element) x1))))
		      (setf (final-stem-yoffset element)
			    (staff-yoffset dominating-staff)))
		(loop for element in elements do
		      (setf (final-stem-position element)
			    (+ y1 (* slope (- (final-absolute-element-xoffset element) x1))))
		      (setf (final-stem-yoffset element)
			    (staff-yoffset dominating-staff)))))
	  (score-pane:with-vertical-score-position (pane (staff-yoffset dominating-staff))
	    (if (eq stem-direction :up)
		(score-pane:with-notehead-right-offsets (right up)
		  (declare (ignore up))
		  (loop repeat min-nb-beams
			for ss from 0 by 2
			for offset from 0
			do (score-pane:draw-beam pane
						 (+ (final-absolute-element-xoffset (car elements)) right) (- ss1 ss) (+ offset1 offset)
						 (+ (final-absolute-element-xoffset (car (last elements))) right) (- ss2 ss) (+ offset2 offset)))
		  (let ((region +nowhere+))
		    (loop for beams from (1+ min-nb-beams) to max-nb-beams
			  for ss from (* 2 min-nb-beams) by 2
			  for offset from min-nb-beams
			  do (loop for (e1 e2) on elements
				   do (when (not (null e2))
					(cond ((and (>= (rbeams e1) beams) (>= (lbeams e2) beams))
					       (setf region 
						     (region-union region
								   (make-rectangle* (+ (final-absolute-element-xoffset e1) right) -10000
										    (+ (final-absolute-element-xoffset e2) right) 10000))))
					      ((>= (rbeams e1) beams)
					       (setf region
						     (region-union region 
								   (make-rectangle* (+ (final-absolute-element-xoffset e1) right) -10000
										    (+ (final-absolute-element-xoffset e1) right (score-pane:staff-step 2)) 10000))))
					      ((>= (lbeams e2) beams)
					       (setf region
						     (region-union region 
								   (make-rectangle* (+ (final-absolute-element-xoffset e2) right (score-pane:staff-step -2)) -10000
										    (+ (final-absolute-element-xoffset e2) right) 10000))))
					      (t nil))))
			     (with-drawing-options (pane :clipping-region region)
			       (score-pane:draw-beam pane
						     (+ (final-absolute-element-xoffset (car elements)) right) (- ss1 ss) (+ offset1 offset)
						     (+ (final-absolute-element-xoffset (car (last elements))) right) (- ss2 ss) (+ offset2 offset))))))
		(score-pane:with-notehead-left-offsets (left down)
		  (declare (ignore down))
		  (loop repeat min-nb-beams
			for ss from 0 by 2
			for offset from 0
			do (score-pane:draw-beam pane
						 (+ (final-absolute-element-xoffset (car elements)) left) (+ ss1 ss) (- offset1 offset)
						 (+ (final-absolute-element-xoffset (car (last elements))) left) (+ ss2 ss) (- offset2 offset)))
		  (let ((region +nowhere+))
		    (loop for beams from (1+ min-nb-beams) to max-nb-beams
			  for ss from (* 2 min-nb-beams) by 2
			  for offset from min-nb-beams
			  do (loop for (e1 e2) on elements
				   do (when (not (null e2))
					(cond ((and (>= (rbeams e1) beams) (>= (lbeams e2) beams))
					       (setf region 
						     (region-union region
								   (make-rectangle* (+ (final-absolute-element-xoffset e1) left) -10000
										    (+ (final-absolute-element-xoffset e2) left) 10000))))
					      ((>= (rbeams e1) beams)
					       (setf region
						     (region-union region 
								   (make-rectangle* (+ (final-absolute-element-xoffset e1) left) -10000
										    (+ (final-absolute-element-xoffset e1) left (score-pane:staff-step 2)) 10000))))
					      ((>= (lbeams e2) beams)
					       (setf region
						     (region-union region 
								   (make-rectangle* (+ (final-absolute-element-xoffset e2) left (score-pane:staff-step -2)) -10000
										    (+ (final-absolute-element-xoffset e2) left) 10000))))
					      (t nil))))
			     (with-drawing-options (pane :clipping-region region)
			       (score-pane:draw-beam pane
						     (+ (final-absolute-element-xoffset (car elements)) left) (+ ss1 ss) (- offset1 offset)
						     (+ (final-absolute-element-xoffset (car (last elements))) left) (+ ss2 ss) (- offset2 offset))))))))
	  (loop for element in elements do
		(draw-element pane element nil))))))

(defun draw-the-cursor (pane cursor cursor-element last-note)
  (let* ((staff (car (staves (layer cursor))))
	 (bar (bar cursor)))
    (flet ((draw-cursor (x)
	     (let* ((sy (system-y-position bar))
		    ;; Why (- STAFF-YOFFSET)?  dunno.  -- CSR, 2005-10-28
		    (yoffset (- (gsharp-drawing::staff-yoffset staff))))
	       (if (typep staff 'fiveline-staff)
		   (let* ((clef (clef staff))
			  (bottom-line (- (ecase (name clef) (:treble 32) (:bass 24) (:c 28))
					  (lineno clef)))
			  (lnote-offset (score-pane:staff-step (- last-note bottom-line))))
		     (draw-line* pane
				 x (+ sy (- (+ (score-pane:staff-step 12) yoffset)))
				 x (+ sy (- (+ (score-pane:staff-step -4) yoffset)))
				 :ink +yellow+)
		     (draw-line* pane
				 (- x 1) (+ sy (- (+ (score-pane:staff-step -3.4) yoffset lnote-offset)))
				 (- x 1) (+ sy (- (+ (score-pane:staff-step 3.6) yoffset lnote-offset)))
				 :ink +red+)
		     (draw-line* pane
				 (+ x 1) (+ sy (- (+ (score-pane:staff-step -3.4) yoffset lnote-offset)))
				 (+ x 1) (+ sy (- (+ (score-pane:staff-step 3.6) yoffset lnote-offset)))
				 :ink +red+))
		   (progn (draw-line* pane
				      (+ x 1) (+ sy (- (+ (score-pane:staff-step 2) yoffset)))
				      (+ x 1) (+ sy (- (+ (score-pane:staff-step -2) yoffset)))
				      :ink +red+)
			  (draw-line* pane
				      (- x 1) (+ sy (- (+ (score-pane:staff-step 2) yoffset)))
				      (- x 1) (+ sy (- (+ (score-pane:staff-step -2) yoffset)))
				      :ink +red+))))))
      (score-pane:with-staff-size 6
	(let* ((x (final-absolute-measure-xoffset bar))
	       (width (final-width bar))
	       (elements (elements bar)))
	  (if (null cursor-element)
	      (draw-cursor (/ (+ (if (null elements)
				     x
				     (final-absolute-element-xoffset (car (last elements))))
				 x width) 2))
	      (loop for element in elements
		    and xx = x then (final-absolute-element-xoffset element) do
		    (when (eq element cursor-element)
		      (draw-cursor (/ (+ xx (final-absolute-element-xoffset element)) 2))))))))))

(defun compute-bar-coordinates (bar x y width)
  (setf (system-y-position bar) y
	(final-absolute-measure-xoffset bar) x
	(final-width bar) width))

(defmethod draw-bar (pane (bar melody-bar))
  (score-pane:with-vertical-score-position
      (pane (system-y-position bar))
    (loop for group in (beam-groups (elements bar))
	  do (draw-beam-group pane group))))

(defmethod draw-bar (pane (bar lyrics-bar))
  (score-pane:with-vertical-score-position
      (pane (system-y-position bar))
    (let ((elements (elements bar)))
      (loop for element in elements
	    do (draw-element pane element)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Cluster

(defgeneric draw-element (pane element &optional flags))

(defmethod note-difference ((note1 note) (note2 note))
  (- (pitch note1) (pitch note2)))

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

(defun element-has-suspended-notes (element)
  (not (apply #'= (mapcar #'final-relative-note-xoffset (notes element)))))

;;; draw a cluster.  The stem direction and the stem position have
;;; already been computed.  
;;; 1. Group notes by staff.
;;; 2. Draw the notes in each group
;;; 3. If necessary, draw ledger lines for notes in a group
;;; 4. Draw the stem, if any
(defmethod draw-element (pane (element cluster) &optional (flags t))
  (unless (null (notes element))
    (let ((direction (final-stem-direction element))
	  (stem-pos (final-stem-position element))
	  (stem-yoffset (final-stem-yoffset element))
	  (groups (group-notes-by-staff (notes element)))
	  (x (final-absolute-element-xoffset element)))
      (when flags
	(score-pane:with-vertical-score-position (pane stem-yoffset)
	  (draw-flags pane element x direction stem-pos)))
      (loop for group in groups do 
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

(defmethod draw-element (pane (element rest) &optional (flags t))
  (declare (ignore flags))
  (let ((x (final-absolute-element-xoffset element)))
    (score-pane:with-vertical-score-position (pane (staff-yoffset (staff element)))
      (score-pane:draw-rest pane (undotted-duration element) x (staff-pos element))
      (draw-dots pane (dots element) x (1+ (staff-pos element))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Lyrics element

(defmethod draw-element (pane (element lyrics-element) &optional (flags t))
  (declare (ignore flags))
  (let ((x (final-absolute-element-xoffset element)))
    (score-pane:with-vertical-score-position (pane (staff-yoffset (staff element)))
      (with-text-family (pane :serif)
	(draw-text* pane (map 'string 'code-char (text element))
		    x 0 :align-x :center)))))
