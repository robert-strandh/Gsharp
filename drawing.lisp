(in-package :gsharp-drawing)

(defclass x-y-width-mixin ()
  (;; indicates the absolute y position of the system to which the 
   ;; object belongs
   (system-y-position :accessor system-y-position)
   ;; the absolute x position of the object
   (final-absolute-measure-xoffset :accessor final-absolute-measure-xoffset)
   (final-width :accessor final-width)))

(define-stealth-mixin dbar (x-y-width-mixin) bar
  ())

(define-stealth-mixin dmeasure (x-y-width-mixin) measure
  (;; an elasticity function that describes how the space right after
   ;; the initial barline of the measure behaves as a function of the
   ;; force that is applied to it.
   (prefix-elasticity-function :accessor prefix-elasticity-function)))

(define-stealth-mixin dstaff () staff
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

(defun clef-for-staff (staff measures)
  (let ((clefs (clefs staff))
	(barno (gsharp-numbering:number (car (measure-bars (car measures))))))
    (or (and clefs
             (find barno clefs :from-end t :test #'> 
                   :key (lambda (x) (gsharp-numbering:number (bar x)))))
        (clef staff))))

(defun key-signature-for-staff (staff measures)
  (let ((key-signatures (key-signatures staff))
	(barno (gsharp-numbering:number (car (measure-bars (car measures))))))
    (or (and key-signatures
	     (find barno key-signatures :from-end t :test #'> 
		   :key (lambda (x) (gsharp-numbering:number (bar x)))))
	(keysig staff))))

(defmethod draw-staff-and-clef (pane (staff fiveline-staff) measures x1 x2)
  (let ((clef (clef-for-staff staff measures)))
    (when clef
      (present clef
               `((score-pane:clef)
                 :name ,(name clef)
                 :x ,(+ x1 10)
                 :staff-step ,(lineno clef))
               :stream pane)
      (let ((keysig (key-signature-for-staff staff measures)))
        (let ((yoffset (b-position clef)))
          (loop for pitch in '(6 2 5 1 4 0 3)
             for line in '(0 3 -1 2 -2 1 -3)
             for x from (+ x1 10 (score-pane:staff-step 8)) by (score-pane:staff-step 2)
             while (eq (aref (alterations keysig) pitch) :flat)
             do (score-pane:draw-accidental pane :flat x (+ line yoffset))))
        (let ((yoffset (f-position clef)))
          (loop for pitch in '(3 0 4 1 5 2 6)
             for line in '(0 -3 1 -2 -5 -1 -4)
             for x from (+ x1 10 (score-pane:staff-step 8)) by (score-pane:staff-step 2.5)
             while (eq (aref (alterations keysig) pitch) :sharp)
             do (score-pane:draw-accidental pane :sharp x (+ line yoffset)))))
      (present staff
               `((score-pane:fiveline-staff)
                 :x1 ,x1 :x2 ,x2)
               :stream pane))))

(defmethod draw-staff-and-clef (pane (staff lyrics-staff) measures x1 x2)
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

(defun final-absolute-dot-xoffset (cluster)
  (+ (final-absolute-element-xoffset cluster) (score-pane:staff-step (final-relative-dot-xoffset cluster))))

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

(defmethod left-bulge :around ((element element) pane)
  (+ (gsharp-buffer::left-pad element) (call-next-method)))
(defmethod right-bulge :around ((element element) pane)
  (+ (gsharp-buffer::right-pad element) (call-next-method)))

(defmethod left-bulge ((element clef) pane)
  (score-pane:staff-step 2))

(defmethod right-bulge ((element clef) pane)
  (score-pane:staff-step 10))

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

(defmethod right-bulge ((timesig time-signature) pane)
  ;; FIXME: this is probably wrong; it should either compute the bulge
  ;; properly, or else approximate using (length - 0.5) *
  ;; typical-width-of-component
  (* (length (time-signature-components timesig))
     (score-pane:staff-step 5)))

(defmethod right-bulge ((keysig key-signature) pane)
  ;; FIXME: shares much code with DRAW-ELEMENT (KEY-SIGNATURE).
  (let ((old-keysig (keysig keysig)))
    (let ((bulge 0))
      (loop with advance = 0
            for pitch in '(6 2 5 1 4 0 3)
            when (and (eq (aref (alterations old-keysig) pitch) :flat)
                      (not (eq (aref (alterations keysig) pitch) 
                               :flat)))
            do (incf advance (score-pane:staff-step 2))
            finally (incf bulge (if (= advance 0) 0 (+ advance (score-pane:staff-step 2)))))
      (loop with advance = 0
            for pitch in '(3 0 4 1 5 2 6)
            when (and (eq (aref (alterations old-keysig) pitch) :sharp)
                      (not (eq (aref (alterations keysig) pitch) :sharp)))
            do (incf advance (score-pane:staff-step 2))
            finally (incf bulge (if (= advance 0) 0 (+ advance (score-pane:staff-step 2)))))
      (loop for pitch in '(6 2 5 1 4 0 3)
            while (eq (aref (alterations keysig) pitch) :flat)
            do (incf bulge (score-pane:staff-step 2)))
      (loop for pitch in '(3 0 4 1 5 2 6)
            while (eq (aref (alterations keysig) pitch) :sharp)
            do (incf bulge (score-pane:staff-step 2.5)))
      bulge)))

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

(defun single-whole-rest-in-bar-p (element)
  (let* ((bar (bar element))
         (elements (elements bar)))
    (and (null (cdr elements))
         (typep element 'rest)
         (member (notehead element) '(:long :breve :whole)))))

(defun compute-measure-coordinates (measure x y force)
  (loop with timelines = (timelines measure)
	for i from 0 below (flexichain:nb-elements timelines)
	for timeline = (flexichain:element* timelines i)
	and xx = (+ x (size-at-force (prefix-elasticity-function measure) force))
                 then (+ xx (max (smallest-gap timeline)
				 (* force (elasticity timeline))))
        do (loop for element in (elements timeline)
		 do (setf (final-absolute-element-xoffset element)
                          (if (single-whole-rest-in-bar-p element)
                              (round (+ x (/ (size-at-force (elasticity-function measure) force) 2)))
                              (round (+ xx (score-pane:staff-step (xoffset element))))))))
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

(defun draw-tie (pane bars n1 n2)
  ;; FIXME: we'll want to draw ties between (nothing) and n2 eventually
  (declare (type note n1) (type (or note null) n2))
  (let ((x1 (+ (final-absolute-note-xoffset n1) (score-pane:staff-step 1.5)))
	(x2 (if (typep n2 'note)
		(- (final-absolute-note-xoffset n2) (score-pane:staff-step 1.5))
		(+ (final-absolute-note-xoffset n1) (score-pane:staff-step 4.5))))
	(pos (note-position n1)))
    (if (eq (final-stem-direction (cluster n1)) :up)
	(score-pane:with-vertical-score-position (pane (staff-yoffset (staff n1)))
	  (if (gsharp-cursor::cursors (slice (car bars)))
	      (score-pane:draw-tie-down pane x1 x2 (if (oddp pos) (1- pos) pos))
	      (score-pane:with-light-glyphs pane
		(score-pane:draw-tie-down pane x1 x2 (if (oddp pos) (1- pos) pos)))))
	(score-pane:with-vertical-score-position (pane (staff-yoffset (staff n1)))
	  (if (gsharp-cursor::cursors (slice (car bars)))
	      (score-pane:draw-tie-up pane x1 x2 (if (oddp pos) (1+ pos) pos))
	      (score-pane:with-light-glyphs pane
		(score-pane:draw-tie-up pane x1 x2 (if (oddp pos) (1+ pos) pos))))))))

(defun notes-tieable (n1 n2)
  (and (= (pitch n1) (pitch n2))
       (eq (staff n1) (staff n2))
       (eq (accidentals n1) (accidentals n2))))

;;; draw the ties in BARS starting at BAR and at most LENGTH bars
(defun draw-ties (pane bars bar length)
  (loop until (eq bar (car bars))
	do (pop bars))
  (score-pane:with-vertical-score-position
      (pane (system-y-position (car bars)))
    (loop with elements = (mapcan (lambda (bar) (copy-seq (elements bar)))
				  (loop for bar in bars
					repeat length
					collect bar))
	  for (e1 e2) on elements
	  do (when (typep e1 'cluster)
	       (loop for n1 in (notes e1)
		     do (when (tie-right n1)
			  (loop for n2 in (and (typep e2 'cluster) (notes e2))
				do (when (and (tie-left n2)
					      (notes-tieable n1 n2))
				     (draw-tie pane bars n1 n2)
				     (return))
				finally (draw-tie pane bars n1 nil))))))))

(defun draw-system (pane measures)
  (with-new-output-record (pane)
    (loop with length = (length measures)
	  for bar in (measure-bars (car measures))
	  do (draw-ties pane (bars (slice bar)) bar length))
    (loop for measure in measures do
	  (draw-measure pane measure))))

(defun draw-staves (pane staves measures x y right-edge)
  (loop for staff in staves do
	(score-pane:with-vertical-score-position
	    (pane (+ y (staff-yoffset staff)))
	  (if (member staff (staves (layer (slice (bar *cursor*)))))
	      (draw-staff-and-clef pane staff measures x right-edge)
	      (score-pane:with-light-glyphs pane
		(draw-staff-and-clef pane staff measures x right-edge))))))  

(defun compute-and-draw-system (pane buffer staves measures method x y timesig-offset right-edge)
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
				(+ x (left-offset buffer) timesig-offset) y
				force))
  (draw-system pane measures)
  (score-pane:draw-bar-line pane x
			    (+ y (- (score-pane:staff-step 8)))
			    (+ y (staff-yoffset (car (last staves)))))
  (draw-staves pane staves measures x y right-edge))

(defun compute-timesig-offset (staves measures)
  (max (* (score-pane:staff-step 2)
	  (loop for staff in staves
		maximize
		(if (typep staff 'fiveline-staff)
		    (count :flat (alterations (key-signature-for-staff staff measures)))
		    0)))
       (* (score-pane:staff-step 2.5)
	  (loop for staff in staves
		maximize
		(if (typep staff 'fiveline-staff)
		    (count :sharp (alterations (key-signature-for-staff staff measures)))
		    0)))))

(defun split (sequence n method)
  (labels ((sequence-size (start end)
	     (natural-width method
			    (reduce (lambda (seq-cost element)
				      (combine-cost method seq-cost element))
				    sequence :start start :end end
				    :initial-value nil)))
	   (split-aux (sequence start end n)
	     (if (= n 1)
		 (let ((width (sequence-size start end)))
		   (values (list (subseq sequence start end)) width width))
		 (let* ((nn (floor n 2))
			(m (floor (* (- end start) nn) n)))
		   (multiple-value-bind (best-left minl maxl)
		       (split-aux sequence start (+ start m) nn)
		     (multiple-value-bind (best-right minr maxr)
			 (split-aux sequence (+ start m) end (- n nn))
		       (let* ((best-min (min minl minr))
			      (best-max (max maxl maxr))
			      (best-cost (/ (- best-max best-min) 2))
			      (best-splits (append best-left best-right)))
			 (cond ((and (< minl minr)
				     (< maxl maxr))
				(loop do (incf m)
				      while (and (< minl minr)
						 (< maxl maxr)
						 (>= (- end start m) (- n nn)))
				      do (multiple-value-bind (left new-minl new-maxl)
					     (split-aux sequence start (+ start m) nn)
					   (multiple-value-bind (right new-minr new-maxr)
					       (split-aux sequence (+ start m) end (- n nn))
					     (setf minl new-minl
						   maxl new-maxl
						   minr new-minr
						   maxr new-maxr)
					     (let ((cost (/ (- (max maxl maxr) (min minl minr)) 2)))
					       (when (< cost best-cost)
						 (setf best-min (min minl minr)
						       best-max (max maxl maxr)
						       best-cost cost
						       best-splits (append left right))))))))
			       ((and (> minl minr)
				     (> maxl maxr))
				(loop do (decf m)
				      while (and (> minl minr)
						 (> maxl maxr)
						 (>= m nn))
				      do (multiple-value-bind (left new-minl new-maxl)
					     (split-aux sequence start (+ start m) nn)
					   (multiple-value-bind (right new-minr new-maxr)
					       (split-aux sequence (+ start m) end (- n nn))
					     (setf minl new-minl
						   maxl new-maxl
						   minr new-minr
						   maxr new-maxr)
					     (let ((cost (/ (- (max maxl maxr) (min minl minr)) 2)))
					       (when (< cost best-cost)
						 (setf best-min (min minl minr)
						       best-max (max maxl maxr)
						       best-cost cost
						       best-splits (append left right)))))))))
			 (values best-splits best-min best-max))))))))
    (split-aux sequence 0 (length sequence) n)))
		     
(defun layout-page (measures n method)
  (if (<= (length measures) n)
      (mapcar #'list measures)
      (split measures n method)))

(defmacro dopages ((measures buffer) &body body)
  `(gsharp-measure::new-map-over-obseq-subsequences
    (lambda (,measures) ,@body)
    ,buffer))

(defun cursor-in-measures-p (cursor measures)
  (member-if (lambda (measure) (member (bar cursor) (measure-bars measure)
				       :test #'eq))
	     measures))

(defun method-for-timesig (method timesig-offset)
  (make-measure-cost-method (min-width method) (spacing-style method)
			    (- (line-width method) timesig-offset)
			    (lines-per-page method)))

(defun draw-page (pane buffer x y staves maxmethod page-measures)
  (let* ((systems-per-page (gsharp-measure::systems-per-page buffer))
         (measure-seqs (layout-page page-measures systems-per-page maxmethod)))
    (dolist (measures measure-seqs)
      (let* ((toffset (compute-timesig-offset staves measures))
             (method (method-for-timesig (buffer-cost-method buffer) toffset)))
        (compute-and-draw-system pane buffer staves measures method
                                 x y toffset (right-edge buffer))
        (incf y (+ 20 (* 70 (length staves))))))))

(defmethod draw-buffer (pane (buffer buffer) *cursor* x y)
  (score-pane:with-staff-size (gsharp-buffer::rastral-size buffer)
    (let* ((staves (staves buffer))
	   (max-timesig-offset (* (score-pane:staff-step 2.5) 7))
	   (method (method-for-timesig 
                    (buffer-cost-method buffer) max-timesig-offset)))
      (loop for staff in staves
	    for offset from 0 by 70 do
	    (setf (staff-yoffset staff) offset))
      (dopages (page-measures buffer)
        (when (cursor-in-measures-p *cursor* page-measures)
          (draw-page pane buffer x y staves method page-measures))))))

(defmethod print-buffer (pane (buffer buffer) *cursor* x y)
  (score-pane:with-staff-size (gsharp-buffer::rastral-size buffer)
    (let* ((staves (staves buffer))
	   (max-timesig-offset (* (score-pane:staff-step 2.5) 7))
	   (method (method-for-timesig 
                    (buffer-cost-method buffer) max-timesig-offset)))
      (loop for staff in staves
	    for offset from 0 by 70 do
	    (setf (staff-yoffset staff) offset))
      (let ((first t))
        (dopages (page-measures buffer)
          (unless first
            (new-page pane))
          (draw-page pane buffer x y staves method page-measures)
          (setq first nil))))))

(define-stealth-mixin xelement () element
  ((final-absolute-xoffset :accessor final-absolute-element-xoffset)))

(define-stealth-mixin velement () melody-element
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
   (bot-note-staff-yoffset :accessor bot-note-staff-yoffset)))

(define-stealth-mixin welement () lyrics-element
  ())

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

(defun cluster-p (element)
  (typep element 'cluster))

(defun map-over-cluster-pairs (fun list)
  (loop for sublist on list
	do (when (cluster-p (car sublist))
	     (let ((second (find-if #'cluster-p (cdr sublist))))
	       (when second
		 (funcall fun (car sublist) second))))))

(defun draw-beam-group (pane elements)
  (let ((e (car elements)))
    (when (typep e 'gsharp-buffer::staffwise-element)
      (assert (null (cdr elements)))
      (return-from draw-beam-group
        (draw-element pane e (final-absolute-element-xoffset e)))))
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
			  do (map-over-cluster-pairs
			      (lambda (e1 e2)
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
				      (t nil)))
			      elements)
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
			  do (map-over-cluster-pairs
			      (lambda (e1 e2)
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
				      (t nil)))
			      elements)
			     (with-drawing-options (pane :clipping-region region)
			       (score-pane:draw-beam pane
						     (+ (final-absolute-element-xoffset (car elements)) left) (+ ss1 ss) (- offset1 offset)
						     (+ (final-absolute-element-xoffset (car (last elements))) left) (+ ss2 ss) (- offset2 offset))))))))
	  (loop for element in elements do
		(draw-element pane element nil))))))

(defun draw-the-cursor (pane cursor cursor-element last-note)
  (let* ((staff (car (staves (layer cursor))))
	 (bar (bar cursor))
	 (sy (system-y-position bar))
	 (yoffset (- (gsharp-drawing::staff-yoffset staff))))
    (let ((region (pane-viewport-region pane)))
      (when region
	;; FIXME: adjusting the viewport at this point leads to ugly
	;; jumps in the display when going across pages, as the page
	;; is first laid out and drawn, then the viewport is moved.
	;; If we instead cleared the pane, laid out the page, adjusted
	;; the viewport, and finally drew the page (and cursor) then
	;; that jump would probably go away.
	;;
	;; FIXME: this calculation only takes account of the centre of
	;; the cursor.  Refactor this whole DRAW-THE-CURSOR function
	;; so that it's easy to take account of the vertical extent of
	;; the cursor.
	(unless (< (bounding-rectangle-min-y region)
		   (- sy yoffset)
		   (bounding-rectangle-max-y region))
	  (let ((maxy (- (bounding-rectangle-max-y pane) (bounding-rectangle-height region))))
	    (scroll-extent pane 0 (max 0 (min maxy
					      (- sy (floor (bounding-rectangle-height region) 2)))))))))
				       
    (flet ((draw-cursor (x)
	     (if (typep staff 'fiveline-staff)
		 (let* ((clef (clef cursor))
			(bottom-line (bottom-line clef))
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
				    :ink +red+)))))
      (score-pane:with-staff-size (gsharp-buffer::rastral-size (buffer cursor))
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

(defmethod draw-element :around (pane element &optional flags)
  (call-next-method)
  (dolist (annotation (annotations element))
    (draw-element-annotation pane element annotation)))

(defgeneric draw-element-annotation (pane element annotation)
  (:method (pane element annotation) 
    (warn "unknown annotation ~S for ~S" annotation element)))

;;; FIXME: these methods work and have the right vertical behaviour;
;;; the horizontal centering of the dot and the tenuto mark are all
;;; wrong, sadly.
(defmethod draw-element-annotation
    (pane (element cluster) (annotation (eql :staccato)))
  (let ((direction (final-stem-direction element))
	(x (final-absolute-element-xoffset element)))
    (if (eq direction :up)
	(score-pane:with-vertical-score-position (pane (bot-note-staff-yoffset element))
	  (score-pane:with-notehead-right-offsets (dx dy)
	    (score-pane:with-notehead-left-offsets (ddx ddy)
	      (let ((pos (- (bot-note-pos element) 2)))
		(when (and (<= 0 pos) (evenp pos))
		  (setq pos (1- pos)))
		(score-pane:draw-dot pane (+ x (/ (+ dx ddx) 2)) pos)))))
	(score-pane:with-vertical-score-position (pane (top-note-staff-yoffset element))
	  (score-pane:with-notehead-right-offsets (dx dy)
	    (score-pane:with-notehead-left-offsets (ddx ddy)
	      (let ((pos (+ (top-note-pos element) 2)))
		(when (and (<= pos 8) (evenp pos))
		  (setq pos (1+ pos)))
		(score-pane:draw-dot pane (+ x (/ (+ dx ddx) 2)) pos))))))))

(defmethod draw-element-annotation 
    (pane (element cluster) (annotation (eql :tenuto)))
  (let ((direction (final-stem-direction element))
	(x (final-absolute-element-xoffset element)))
    (if (eq direction :up)
	(score-pane:with-vertical-score-position (pane (bot-note-staff-yoffset element))
	  (score-pane:with-notehead-right-offsets (dx dy)
	    (score-pane:with-notehead-left-offsets (ddx ddy)
	      (let ((pos (- (bot-note-pos element) 2)))
		(when (and (<= 0 pos) (evenp pos))
		  (setq pos (1- pos)))
		(draw-rectangle* pane (+ x ddx) (1- (score-pane:staff-step (- pos)))
				 (+ x dx) (1+ (score-pane:staff-step (- pos))))))))
	(score-pane:with-vertical-score-position (pane (top-note-staff-yoffset element))
	  (score-pane:with-notehead-right-offsets (dx dy)
	    (score-pane:with-notehead-left-offsets (ddx ddy)
	      (let ((pos (+ (bot-note-pos element) 2)))
		(when (and (<= pos 8) (evenp pos))
		  (setq pos (1+ pos)))
		(draw-rectangle* pane (+ x ddx) (1- (score-pane:staff-step (- pos)))
				 (+ x dx) (1+ (score-pane:staff-step (- pos)))))))))))
					       
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

(defun flags-drawn-p (element)
  (let ((nb (max (rbeams element) (lbeams element))))
    (and (> nb 0) (eq (notehead element) :filled) nb)))

(defun draw-flags (pane element x direction pos)
  (let ((nb (flags-drawn-p element)))
    (when nb
      (if (eq direction :up)
	  (score-pane:with-notehead-right-offsets (right up)
	    (declare (ignore up))
	    (score-pane:draw-flags-down pane nb (+ x right) pos))
	  (score-pane:with-notehead-left-offsets (left down)
	    (declare (ignore down))
	    (score-pane:draw-flags-up pane nb (+ x left) pos))))))
  
(defun draw-dots (pane nb-dots x dot-xoffset dot-pos)
  (when dot-pos
    (let ((staff-step (score-pane:staff-step 1)))
      (loop repeat nb-dots
            for xx from dot-xoffset by staff-step do
            (score-pane:draw-dot pane xx dot-pos)))))

(defun draw-note (pane note notehead nb-dots x pos dot-xoffset dot-pos)
  (score-pane:with-vertical-score-position (pane (staff-yoffset (staff note)))
    (score-pane:draw-notehead pane notehead x pos)
    (when (final-accidental note)
      (score-pane:draw-accidental pane (final-accidental note) (final-absolute-accidental-xoffset note) pos))
    (draw-dots pane nb-dots x dot-xoffset dot-pos)))

(defparameter *main-selected-note-colour* +blue-violet+)
(defun draw-notes (pane notes dots notehead dot-xoffset)
  (loop for note in notes 
     do
       (with-drawing-options (pane :ink (if (and (gsharp::cur-notep)
                                                 (eq note (gsharp::cur-note))
                                                 (not (typep pane 'clim-postscript::postscript-stream)))
                                            *main-selected-note-colour* +black+))
         (draw-note pane note notehead dots (final-absolute-note-xoffset note) (note-position note) dot-xoffset (final-absolute-dot-ypos note)))))

(defun element-has-suspended-notes (element)
  (not (apply #'= (mapcar #'final-relative-note-xoffset (notes element)))))

;;; draw a cluster.  The stem direction and the stem position have
;;; already been computed.  
;;; 1. Group notes by staff.
;;; 2. Draw the notes in each group
;;; 3. If necessary, draw ledger lines for notes in a group
;;; 4. Draw the stem, if any
(defmethod draw-element (pane (element cluster) &optional (flags t))
  (with-new-output-record (pane)
    (unless (null (notes element))
      (with-output-as-presentation (pane element 'cluster)
        (let* ((direction (final-stem-direction element))
               (stem-pos (final-stem-position element))
               (stem-yoffset (final-stem-yoffset element))
               (groups (group-notes-by-staff (notes element)))
               (x (final-absolute-element-xoffset element))
               (dot-xoffset 
                (let ((basic-xoffset (+ (score-pane:staff-step 2)
                                        (reduce #'max (mapcar #'final-absolute-note-xoffset (notes element))))))
                  (if (and flags (eq direction :up) (flags-drawn-p element))
                      (max basic-xoffset (+ (score-pane:staff-step 4) x))
                      basic-xoffset))))
          (when flags
            (score-pane:with-vertical-score-position (pane stem-yoffset)
              (draw-flags pane element x direction stem-pos)))
          (loop for group in groups do 
                (draw-notes pane group (dots element) (notehead element) dot-xoffset)
                (draw-ledger-lines pane x group))
          (unless (member (notehead element) '(:whole :breve))
            (if (eq direction :up)
                (score-pane:draw-right-stem
                 pane x
                 (- (bot-note-staff-yoffset element) (score-pane:staff-step (bot-note-pos element)))
                 (- stem-yoffset (score-pane:staff-step stem-pos)))
  	        (score-pane:draw-left-stem
                 pane x
                 (- (top-note-staff-yoffset element) (score-pane:staff-step (top-note-pos element)))
                 (- stem-yoffset (score-pane:staff-step stem-pos))))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Rest

(defmethod draw-element (pane (element rest) &optional (flags t))
  (declare (ignore flags))
  (let ((x (final-absolute-element-xoffset element)))
    (with-output-as-presentation (pane element 'rest)
      (score-pane:with-vertical-score-position (pane (staff-yoffset (staff element)))
        (score-pane:draw-rest pane (undotted-duration element) x (staff-pos element))
        (draw-dots pane (dots element) x (+ x (score-pane:staff-step 2)) (1+ (staff-pos element)))))))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Key signature element

(defmethod draw-element (pane (keysig key-signature) &optional flags)
  (declare (ignore flags))
  (let ((staff (staff keysig))
        (old-keysig (keysig keysig))
        (x (final-absolute-element-xoffset keysig)))
    (score-pane:with-vertical-score-position (pane (staff-yoffset staff))
      (let ((yoffset (b-position (clef keysig))))
        (loop with advance = 0
              for pitch in '(6 2 5 1 4 0 3)
              for line in '(0 3 -1 2 -2 1 -3)
              when (and (eq (aref (alterations old-keysig) pitch) :flat)
                        (not (eq (aref (alterations keysig) pitch) 
                                 :flat)))
              do (score-pane:draw-accidental 
                  pane :natural (+ x advance) (+ line yoffset))
              and do (incf advance (score-pane:staff-step 2))
              finally (incf x (if (= advance 0) 0 (+ advance (score-pane:staff-step 2))))))
      (let ((yoffset (f-position (clef keysig))))
        (loop with advance = 0
              for pitch in '(3 0 4 1 5 2 6)
              for line in '(0 -3 1 -2 -5 -1 -4)
              when (and (eq (aref (alterations old-keysig) pitch) :sharp)
                        (not (eq (aref (alterations keysig) pitch) :sharp)))
              do (score-pane:draw-accidental pane :natural (+ x advance) (+ line yoffset))
              and do (incf advance (score-pane:staff-step 2))
              finally (incf x (if (= advance 0) 0 (+ advance (score-pane:staff-step 2))))))

      (let ((yoffset (b-position (clef keysig))))
        (loop for pitch in '(6 2 5 1 4 0 3)
              for line in '(0 3 -1 2 -2 1 -3)
              for x from x by (score-pane:staff-step 2)
              while (eq (aref (alterations keysig) pitch) :flat)
              do (score-pane:draw-accidental pane :flat x (+ line yoffset))))
      (let ((yoffset (f-position (clef keysig))))
        (loop for pitch in '(3 0 4 1 5 2 6)
              for line in '(0 -3 1 -2 -5 -1 -4)
              for x from x by (score-pane:staff-step 2.5)
              while (eq (aref (alterations keysig) pitch) :sharp)
              do (score-pane:draw-accidental pane :sharp x (+ line yoffset)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Time signature element

(defmethod draw-element (pane (timesig time-signature) &optional (flags t))
  (declare (ignore flags))
  (let ((staff (staff timesig))	
        (x (final-absolute-element-xoffset timesig)))    
    (score-pane:with-vertical-score-position (pane (staff-yoffset staff))
      (dolist (component (time-signature-components timesig))
        (score-pane:draw-time-signature-component pane component x)))))

(defmethod draw-element (pane (clef clef) &optional (flags t))
  (declare (ignore flags))
  (let ((x (final-absolute-element-xoffset clef)))
    (score-pane:draw-clef pane (name clef) x (lineno clef))))
