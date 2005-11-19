(in-package :gsharp-measure)

(defmacro defrclass (name base slots)
  `(progn 
     (define-added-mixin ,name () ,base
       ((modified-p :initform t :accessor modified-p)
	,@slots))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Staff

(define-added-mixin rstaff () staff
  ((rank :accessor staff-rank)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Note

(defrclass rnote note
  ())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Element

;;; The relement class mixes into the element class.  It adds
;;; a `duration' slot that contains the duration of the element. 
;;; It also makes sure that whenever the duration of an element
;;; is being asked for, the new value is computed should any 
;;; modification to the element have taken place in the meantime. 

(defrclass relement element
  ((duration :initform nil)))

(defmethod duration :around ((element relement))
  (with-slots (duration) element
    (when (null duration)
      (setf duration (call-next-method)))
    duration))

(defmethod mark-modified ((element relement))
  (setf (modified-p element) t
	(slot-value element 'duration) nil)
  (when (bar element)
    (mark-modified (bar element))))

(defmethod (setf notehead) :after (notehead (element relement))
  (declare (ignore notehead))
  (mark-modified element))

(defmethod (setf rbeams) :after (rbeams (element relement))
  (declare (ignore rbeams))
  (mark-modified element))

(defmethod (setf lbeams) :after (lbeams (element relement))
  (declare (ignore lbeams))
  (mark-modified element))

(defmethod (setf dots) :after (dots (element relement))
  (declare (ignore dots))
  (mark-modified element))

(defmethod note-position ((note note))
  (let ((clef (clef (staff note))))
    (+ (- (pitch note)
	  (ecase (name clef) (:treble 32) (:bass 24) (:c 35)))
       (lineno clef))))

;;; given a list of notes, return the one that is at the top
(defun top-note (notes)
  (reduce (lambda (n1 n2)
	    (cond ((< (staff-rank (staff n1))
		      (staff-rank (staff n2)))
		   n1)
		  ((> (staff-rank (staff n1))
		      (staff-rank (staff n2)))
		   n2)
		  ((> (note-position n1)
		      (note-position n2))
		   n1)
		  (t n2)))
	  notes))

;;; given a list of notes, return the one that is at the bottom
(defun bot-note (notes)
  (reduce  (lambda (n1 n2)
	     (cond ((> (staff-rank (staff n1))
		       (staff-rank (staff n2)))
		    n1)
		   ((< (staff-rank (staff n1))
		       (staff-rank (staff n2)))
		    n2)
		   ((< (note-position n1)
		       (note-position n2))
		    n1)
		   (t n2)))
	   notes))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Cluster

(defmethod add-note :after ((element relement) (note note))
  (mark-modified element))

(defmethod remove-note :before ((note rnote))
  (when (cluster note)
    (mark-modified (cluster note))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Rest

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Bar

(defrclass rbar bar
  ())

(defmethod add-element :after ((element element) (bar rbar) position)
  (declare (ignore position))
  (mark-modified bar))

(defmethod remove-element :before ((element relement))
  (when (bar element)
    (mark-modified (bar element))))

(defmethod mark-modified ((bar rbar))
  (setf (modified-p bar) t)
  (when (slice bar)
    (mark-modified (slice bar))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Slice

(defrclass rslice slice
  ())

(defmethod mark-modified ((slice rslice))
  (setf (modified-p slice) t)
  (when (layer slice)
    (mark-modified (layer slice))))

(defmethod add-bar :after ((bar bar) (slice rslice) position)
  (declare (ignore position))
  (mark-modified slice))

(defmethod remove-bar :before ((bar rbar))
  (when (slice bar)
    (mark-modified (slice bar))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Layer

(defrclass rlayer layer
  ())

(defmethod mark-modified ((layer rlayer))
  (setf (modified-p layer) t)
  (when (segment layer)
    (mark-modified (segment layer))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Measure

;;; A measure represents the set of simultaneous bars.  Define a
;;; TIMELINE of a measure to be the set of all simultaneous elements
;;; of the bars of the measure.  The DURATION of a timeline is either
;;; the temporal distance to the next closest timeline following it,
;;; or, in case it is the last timeline of the measure, the duration
;;; of the longest element of the timeline.

(defclass measure (obseq-elem)
  (;; the smallest duration of any timeline in the measure
   (min-dist :initarg :min-dist :reader measure-min-dist)
   ;; the coefficient of a measure is the sum of d_i^k where d_i
   ;; is the duration of the i:th timeline, and k is the spacing style
   (coeff :initarg :coeff :reader measure-coeff)
   ;; a list of unique rational numbers, sorted by increasing numeric value,
   ;; of the start time of the time lines of the measure
   (start-times :initarg :start-times :reader measure-start-times)
   ;; the position of a measure in the sequence of measures
   ;; of a buffer is indicated by two numbers, the position
   ;; of the segment to which the measure belongs within the
   ;; sequence of segments of the buffer, and the position of
   ;; the bars within that segment. 
   (seg-pos :initarg :seg-pos :reader measure-seg-pos)
   (bar-pos :initarg :bar-pos :reader measure-bar-pos)
   ;; a list of the bars that make up this measure
   (bars :initarg :bars :reader measure-bars)))

(defun make-measure (min-dist coeff start-times seg-pos bar-pos bars)
  (make-instance 'measure :min-dist min-dist :coeff coeff
		 :start-times start-times
		 :seg-pos seg-pos :bar-pos bar-pos :bars bars))

(defmethod print-object ((obj measure) stream)
  (with-slots (min-dist coeff seg-pos bar-pos) obj
    (print-unreadable-object (obj stream :identity t :type t)
      (format stream "(~D, ~D) @ ~D-~D" min-dist coeff seg-pos bar-pos))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Segment

(defrclass rsegment segment
  ((measures :initform '() :reader measures)))

(defmethod mark-modified ((segment rsegment))
  (setf (modified-p segment) t)
  (when (buffer segment)
    (mark-modified (buffer segment))))

(defmethod add-layer :after ((layer layer) (segment rsegment))
  (mark-modified segment))

(defmethod remove-layer :before ((layer rlayer))
  (when (segment layer)
    (mark-modified (segment layer))))

(defun adjust-lowpos-highpos (segment)
  (when (modified-p segment)
    (let ((buffer (buffer segment)))
      ;; Do this better.  Now, we essentially tell the obseq library
      ;; that every measure in the entire buffer has been damaged.
      (obseq-first-undamaged-element buffer nil)
      (obseq-last-undamaged-element buffer nil))))

(defmethod measures :before ((segment rsegment))
  (when (modified-p segment)
    (compute-measures segment (spacing-style (buffer-cost-method (buffer segment))))
    (setf (modified-p segment) nil)))

(defmethod nb-measures ((segment rsegment))
  (length (measures segment)))

;;; Given a segment and a position, return the measure in that 
;;; position in the sequence of measures in the segment. 
(defmethod measureno ((segment rsegment) position)
  (elt (measures segment) position))

;;; Convert a list of durations to a list of start times
;;; by accumulating values starting at zero.
;;; The list returned has the same length as the one passed 
;;; as argument, which we obtain by treating the first element
;;; as the initial start time.  Doing so makes it possible to compute
;;; the inverse of this transformation.
(defun rel-abs (list)
  (loop with acc = 0
	for elem in list
	collect (incf acc elem)))

;;; Convert a list of start times to a list of durations
;;; by computing the differences beteen adjacent elements.
;;; The list returned has the same length as the one passed
;;; as argument, which we obtain by including the first 
;;; element unchanged.  Doing so makes it possible to compute
;;; the inverse of this transformation.
(defun abs-rel (list)
  (loop with prev = 0
	for elem in list
	collect (- elem prev)
	do (setf prev elem)))

;;; Compute the start times of the elements of the bar.  The last
;;; element is the "start time" of the end of the bar.  Currently, we
;;; do not handle zero-duration bars very well.  For that reason, when
;;; there are no elements in the bar, we return the list of a single
;;; number 1.  This is clearly wrong, so we need to figure out a
;;; better way of doing that.
(defun start-times (bar)
  (let ((elements (elements bar)))
    (if elements
	(rel-abs (mapcar #'duration elements))
	'(1))))

;;; Combine the list of start times of two bars into a single list
;;; of start times.  Don't worry about duplicated elements which will 
;;; be removed ultimately. 
;;; Treat the last start time (which is really the duration of the
;;; bar) specially and only keep the largest one
(defun combine-bars (bar1 bar2)
  (append (merge 'list (butlast bar1) (butlast bar2) #'<)
	  (list (max (car (last bar1)) (car (last bar2))))))

;;; From a list of simultaneous bars (and some other stuff), create a
;;; measure.  The `other stuff' is the spacing style, which is neded
;;; in order to compute the coefficient of the measure, the position
;;; of the segment to which the bars belong in the sequence of
;;; segments of the buffer, and the position of the bars in the
;;; sequence of bars within that segment.  The last two items are used
;;; to indicate the position of the measure in the sequence of all
;;; measures of the buffer.
(defun compute-measure (bars spacing-style seg-pos bar-pos)
  (let* ((start-times (remove-duplicates
		       (reduce #'combine-bars
			       (mapcar #'start-times bars))))
	 (durations (abs-rel start-times))
	 (min-dist (reduce #'min durations))
	 (coeff (loop for duration in durations
		      sum (expt duration spacing-style))))
    (make-measure min-dist coeff start-times seg-pos bar-pos bars)))

;;; Compute all the measures of a segment by stepping through all the
;;; bars in parallel as long as there is at least one simultaneous bar.
(defun compute-measures (segment spacing-style)
  (setf (slot-value segment 'measures)
	(loop for all-bars on (mapcar (lambda (layer) (bars (body layer)))
				      (layers segment))
	      by (lambda (bars) (mapcar #'cdr bars))
	      as bar-pos from 0 by 1
	      while (notevery #'null all-bars)
	      collect (compute-measure
		       (remove nil (mapcar #'car all-bars)) spacing-style
		       (number segment) bar-pos))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Buffer

(define-added-mixin rbuffer (obseq) buffer
  ((modified-p :initform t :accessor modified-p)))

;;; Given a buffer, a position of a segment in the sequence of
;;; segments of the buffer, and a position of a measure within that
;;; segment, return the corresponding measure.
(defmethod buffer-pos ((buffer rbuffer) seg-pos bar-pos)
  (if (or (<= seg-pos -1) (>= seg-pos (nb-segments buffer)))
      nil
      (measureno (segmentno buffer seg-pos) bar-pos)))

;;; as required by the obseq library, we supply a method on this
;;; generic function.  When we are given a measure other than the last
;;; one in the segment, return the next one in the segment.  When we
;;; are given the last measure in a segment which is not the last one,
;;; return the first measure in the following segment.  When we are
;;; given the last measure of the last segment, return nil as required
;;; by the obseq library.
(defmethod obseq-next ((buf buffer) (measure measure))
  (let ((seg-pos (measure-seg-pos measure))
	(bar-pos (measure-bar-pos measure)))
    (cond ((< (1+ bar-pos) (nb-measures (segmentno buf seg-pos)))
	   (buffer-pos buf seg-pos (1+ bar-pos)))
	  ((< (1+ seg-pos) (nb-segments buf))
	   (buffer-pos buf (1+ seg-pos) 0))
	  (t nil))))

;;; as required by the obseq library, we supply a method on this
;;; generic function specialized on NIL, for which the first measure
;;; of the first segment is returned.
(defmethod obseq-next ((buf buffer) (measure (eql nil)))
  (measureno (segmentno buf 0) 0))

;;; as required by the obseq library, we supply a method on this
;;; generic function.  When we are given a measure other than the first
;;; one in the segment, return the previous one in the segment.  When we
;;; are given the first measure in a segment which is not the first one,
;;; return the last measure in the preceding segment.  When we are
;;; given the first measure of the first segment, return nil as required
;;; by the obseq library.
(defmethod obseq-prev ((buf buffer) (measure measure))
  (let ((seg-pos (measure-seg-pos measure))
	(bar-pos (measure-bar-pos measure)))
    (cond ((> bar-pos 0) (buffer-pos buf seg-pos (1- bar-pos)))
	  ((> seg-pos 0) (buffer-pos buf
				     (1- seg-pos)
				     (1- (nb-measures (segmentno buf (1- seg-pos))))))
	  (t nil))))

;;; as required by the obseq library, we supply a method on this
;;; generic function specialized on NIL, for which the last measure
;;; of the last segment is returned.
(defmethod obseq-prev ((buf buffer) (measure (eql nil)))
  (buffer-pos buf
	      (1- (nb-segments buf))
	      (1- (nb-measures (segmentno buf (1- (nb-segments buf)))))))

(defmethod mark-modified ((buffer rbuffer))
  (setf (modified-p buffer) t))

(defmethod add-segment :after ((segment segment) (buffer rbuffer) position)
  (declare (ignore position))
  (mark-modified buffer))

(defmethod remove-segment :before ((segment rsegment))
  (when (buffer segment)
    (mark-modified (buffer segment))))

;;; temporary stuff
;;; call fun on every list of measures (which make up a line)
;;; in the buffer
(defun new-map-over-obseq-subsequences (fun buf)
  (loop with m = (obseq-interval buf (buffer-pos buf 0 0))
	while m
	do (multiple-value-bind (left right)
	       ;; find the end points of the interval that contains m
	       (obseq-interval buf m)
	     (funcall fun (loop for mm = left then (obseq-next buf mm)
				collect mm
				until (eq mm right)))
	     ;; move to the next measure after the rightmost one
	     ;; in the current line
	     (setf m (obseq-next buf right)))))

(defun buffer-cost-method (buffer)
  (obseq-cost-method buffer))

(defmethod recompute-measures ((buffer rbuffer))
  (when (modified-p buffer)
    ;; number the staves
    (loop for staff in (staves buffer)
	  for i from 0
	  do (setf (staff-rank staff) i))
    ;; for now, invalidate everything
    (mapc #'adjust-lowpos-highpos (segments buffer))
    ;; initialize cost method from buffer-specific style parameters
    (setf (obseq-cost-method buffer)
	  (make-measure-cost-method
	   (min-width buffer) (spacing-style buffer)
	   (- (right-edge buffer) (left-margin buffer) (left-offset buffer))))
    (obseq-solve buffer)
    (setf (modified-p buffer) nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Cost functions

;;; As required by the obseq library, define a cost method
;;; that is passed to the cost-comparison methods.
(defclass measure-cost-method (cost-method)
  (;; the min width is taken from the min width of the buffer
   (min-width :initarg :min-width :reader min-width)
   ;; the spaceing style is taken from the spacing style of the buffer
   (spacing-style :initarg :spacing-style :reader spacing-style)
   ;; the amount of horizontal space available to music material
   (line-width :initarg :line-width :reader line-width)))

(defun make-measure-cost-method (min-width spacing-style line-width)
  (make-instance 'measure-cost-method
		 :min-width min-width
		 :spacing-style spacing-style
		 :line-width line-width))
				 
;;; As required by the obseq library, define a sequence cost, i.e., in
;;; this case the cost of a sequece of measures.
(defclass measure-seq-cost (seq-cost)
  ((min-dist :initarg :min-dist :reader min-dist)
   (coeff :initarg :coeff :reader coeff)
   (nb-measures :initarg :nb-measures :reader nb-measures)))

;;; As required by the obseq library, define a total cost, i.e., in
;;; this case the cost of a sequece of sequences of measures.
(defclass measure-total-cost (total-cost)
  ((cost :initarg :cost :reader measure-total-cost)))

(defun make-measure-total-cost (cost)
  (make-instance 'measure-total-cost :cost cost))

(defmethod print-object ((obj measure-total-cost) stream)
  (print-unreadable-object (obj stream :identity t :type t)
    (format stream "~D" (measure-total-cost obj))))

;;; As required by the obseq library, this method computes the
;;; combined cost of a sequence of measures by taking the existing
;;; cost of all but the last measures and combining it with the
;;; characteristics of the last measure.  The result is a sequence
;;; cost that has the sum of the coefficients of each measure in the
;;; sequence, the min of the min-dists of each measure in the
;;; sequence, and the total number of measures in the sequence.
;;; As far as Gsharp is concerned, this cost computation is 
;;; commutable, so rely on Obseq to supply the symmetric method. 
(defmethod combine-cost ((method measure-cost-method)
				(seq-cost measure-seq-cost)
				(elem measure))
  (make-instance 'measure-seq-cost
    :coeff (+ (coeff seq-cost) (measure-coeff elem))
    :min-dist (min (min-dist seq-cost) (measure-min-dist elem))
    :nb-measures (1+ (nb-measures seq-cost))))

;;; As required by the obseq library, this method computes the
;;; combined cost of a sequence of sequences of measures by taking the
;;; existing cost of all but the last sequences of measures and
;;; combining it with the sequence cost of the last sequence of
;;; measures.  The result is a total cost that has the max of the cost
;;; of each individual sequence of measures.  The reason for using the
;;; max is that we do not want for a good line to be able to
;;; compensate for the badness of another.  We thus compute the score
;;; that minimizes the maximum of the badness of each line.  As far as
;;; Gsharp is concerned, this cost computation is commutable, so rely
;;; on Obseq to supply the symmetric method.
(defmethod combine-cost ((method measure-cost-method)
				(tcost measure-total-cost)
				(seq-cost measure-seq-cost))
  (make-instance 'measure-total-cost
    :cost (max (measure-total-cost tcost)
	       (measure-seq-cost method seq-cost))))

(defmethod combine-cost ((method measure-cost-method)
				(seq-cost measure-seq-cost)
				(elem (eql nil)))
  (make-instance 'measure-total-cost
    :cost (measure-seq-cost method seq-cost)))


;;; As required by the obseq library, this method computes the
;;; sequence cost of a singleton sequence.  
(defmethod combine-cost ((method measure-cost-method)
				(elem measure)
				(whatever (eql nil)))
  (make-instance 'measure-seq-cost
    :coeff (measure-coeff elem)
    :min-dist (measure-min-dist elem)
    :nb-measures 1))

;;; As required by the obseq library, this method computes the
;;; sequence cost of a singleton sequence.  
(defmethod combine-cost ((method measure-cost-method)
				(whatever (eql nil))
				(elem measure))
  (combine-cost method elem nil))

;;; The reduced width of a sequence of measures is the sum of the
;;; widths of the measures in the sequence, but ignoring the space
;;; before first timeline.  If the min-dist is 0 (which I think is the
;;; case if each measure has no timelines), then the reduced width is
;;; 0, otherwise we obtain the reduced width by multiplying the sum of
;;; the coefficients of each mesure in the sequence, the min-width to
;;; use for the display, and (1/d_min)^k, where d_min is the duration
;;; of the shortest timeline, and k is the spacing style.
(defmethod reduced-width ((method measure-cost-method)
			  (seq-cost measure-seq-cost))
  (if (zerop (min-dist seq-cost))
      0
      (* (coeff seq-cost) (min-width method)
	 (expt (/ (min-dist seq-cost)) (spacing-style method)))))

;;; The natural width of a sequence of mesures is like the reduced
;;; width, except that we do not ignore the space before the first
;;; timeline in each measure.  That space might be necessary to
;;; parameterize one day, but for now we just use the w_min.
(defmethod natural-width ((method measure-cost-method)
			  (seq-cost measure-seq-cost))
  (+ (reduced-width method seq-cost)
     (* (nb-measures seq-cost) (min-width method))))

;;; The compress factor indicates how by how much a sequence of
;;; measures must be compressed in order to fit the line width at our
;;; disposal.  Values > 1 indicate that the sequence of mesures must
;;; be stretched instead of compressed.
(defmethod compress-factor ((method measure-cost-method)
			    (seq-cost measure-seq-cost))
  (/ (natural-width method seq-cost) (line-width method)))

;;; As far as Gsharp is concerned, we define the cost of a sequence of
;;; measures as the max of the compress factor and its inverse.  In
;;; other words, we consider it as bad to have to stretch a line by x%
;;; as it is to have to compress it by x%, and the more we have to
;;; compress or expand it, the worse it is.  This way of doing it is
;;; not great.  At some point, we need to severely penalize compressed
;;; lines that become too short to display without overlaps, unless
;;; the line contains a single measure, of course.
(defmethod measure-seq-cost ((method measure-cost-method)
			     (seq-cost measure-seq-cost))
  (let ((c (compress-factor method seq-cost)))
    (max c (/ c))))

;;; As required by the obseq library, we define a method that
;;; determines whether we can prove that adding another measure to an
;;; existing sequence is guaranteed to make the cost of the sequence
;;; higher.  The obseq library uses this to radically diminish the
;;; complexity of the computation. 
(defmethod seq-cost-cannot-decrease ((method measure-cost-method)
					    (seq-cost measure-seq-cost))
  (>= (natural-width method seq-cost)
      (line-width method)))

;;; Compare the cost of two sequences of measures
(defmethod cost-less ((method measure-cost-method)
		      (c1 measure-seq-cost)
		      (c2 measure-seq-cost))
  (< (measure-seq-cost method c1) (measure-seq-cost method c2)))

;;; Compare the cost of two sequences of sequences of measures
(defmethod cost-less ((method measure-cost-method)
		      (c1 measure-total-cost)
		      (c2 measure-total-cost))
  (< (measure-total-cost c1) (measure-total-cost c2)))
