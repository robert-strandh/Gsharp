(in-package :gsharp-measure)

(defmacro defrclass (name base slots)
  `(progn 
     (define-added-mixin ,name () ,base
       ((modified-p :initform t :accessor modified-p)
	,@slots))))

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
    (when (or (modified-p element) (null duration))
      (setf duration (call-next-method))
      (setf (modified-p element) nil))
    duration))

(defmethod mark-modified ((element relement))
  (setf (modified-p element) t)
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

;;; A measure represents the set of simultaneous bars.
;;; Define a TIMELINE of a measure to be the set of all
;;; simultaneous elements of the bars of the measure.
;;; The DURATION of a timeline is either the distance to
;;; the next closest timeline following it, or, in case 
;;; it is the last timeline of the measure, the duration 
;;; of the longest element of the timeline. 

(defclass measure (obseq-elem)
  (;; the smallest temporal distance between either two adjacent
   ;; timelines in the measure or between the last timeline
   ;; and the end of the mesure.  The temporal distance between
   ;; the last timeline and the end of the measure is the same
   ;; as the duration of the longest element of the last timeline.
   (min-dist :initarg :min-dist :reader measure-min-dist)
   ;; the coefficient of a measure is the sum of 
   (coeff :initarg :coeff :reader measure-coeff)
   (start-times :initarg :start-times :reader measure-start-times)
   (seg-pos :initarg :seg-pos :reader measure-seg-pos)
   (bar-pos :initarg :bar-pos :reader measure-bar-pos)
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
      (obseq-first-undamaged-element buffer nil)
      (obseq-last-undamaged-element buffer nil))))

(defmethod measures :before ((segment rsegment))
  (when (modified-p segment)
    (compute-measures segment (spacing-style (buffer-cost-method (buffer segment))))
    (setf (modified-p segment) nil)))

(defmethod nb-measures ((segment rsegment))
  (length (measures segment)))

(defmethod measureno ((segment rsegment) position)
  (elt (measures segment) position))

;;; convert a list of durations to a list of start times
(defun rel-abs (list)
  (loop with acc = 0
	for elem in list
	collect (incf acc elem)))

;;; convert a list of start times to a list of durations
(defun abs-rel (list)
  (loop with prev = 0
	for elem in list
	collect (- elem prev)
	do (setf prev elem)))

(defun start-times (bar)
  (let ((elements (elements bar)))
    (if elements
	(rel-abs (mapcar #'duration elements))
	'(1))))

;;; treat the last start time (which is really the duration of the
;;; bar) specially and only keep the largest one
(defun combine-bars (bar1 bar2)
  (append (merge 'list (butlast bar1) (butlast bar2) #'<)
	  (list (max (car (last bar1)) (car (last bar2))))))

(defun compute-measure (bars spacing-style seg-pos bar-pos)
  (let* ((start-times (remove-duplicates
		       (reduce #'combine-bars
			       (mapcar #'start-times bars))))
	 (durations (abs-rel start-times))
	 (min-dist (reduce #'min durations))
	 (coeff (loop for duration in durations
		      sum (expt duration spacing-style))))
    (make-measure min-dist coeff start-times seg-pos bar-pos bars)))

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

(defmethod buffer-pos ((buffer rbuffer) seg-pos bar-pos)
  (if (or (<= seg-pos -1) (>= seg-pos (nb-segments buffer)))
      nil
      (measureno (segmentno buffer seg-pos) bar-pos)))

(defmethod obseq-next ((buf buffer) (measure measure))
  (let ((seg-pos (measure-seg-pos measure))
	(bar-pos (measure-bar-pos measure)))
    (cond ((< (1+ bar-pos) (nb-measures (segmentno buf seg-pos)))
	   (buffer-pos buf seg-pos (1+ bar-pos)))
	  ((< (1+ seg-pos) (nb-segments buf))
	   (buffer-pos buf (1+ seg-pos) 0))
	  (t nil))))

(defmethod obseq-next ((buf buffer) (measure (eql nil)))
  (measureno (segmentno buf 0) 0))

(defmethod obseq-prev ((buf buffer) (measure measure))
  (let ((seg-pos (measure-seg-pos measure))
	(bar-pos (measure-bar-pos measure)))
    (cond ((> bar-pos 0) (buffer-pos buf seg-pos (1- bar-pos)))
	  ((> seg-pos 0) (buffer-pos buf
				     (1- seg-pos)
				     (1- (nb-measures (segmentno buf (1- seg-pos))))))
	  (t nil))))

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
(defun new-map-over-obseq-subsequences (fun buf)
  (loop with m = (obseq-interval buf (buffer-pos buf 0 0))
	while m
	do (multiple-value-bind (left right)
	       (obseq-interval buf m)
	     (funcall fun (loop for mm = left then (obseq-next buf mm)
				collect mm
				until (eq mm right)))
	     (setf m (obseq-next buf right)))))

(defun buffer-cost-method (buffer)
  (obseq-cost-method buffer))

(defmethod recompute-measures ((buffer rbuffer))
  (when (modified-p buffer)
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
				 
(defclass measure-seq-cost (seq-cost)
  ((min-dist :initarg :min-dist :reader min-dist)
   (coeff :initarg :coeff :reader coeff)
   (nb-measures :initarg :nb-measures :reader nb-measures)))

(defclass measure-total-cost (total-cost)
  ((cost :initarg :cost :reader measure-total-cost)))

(defun make-measure-total-cost (cost)
  (make-instance 'measure-total-cost :cost cost))

(defmethod print-object ((obj measure-total-cost) stream)
  (print-unreadable-object (obj stream :identity t :type t)
    (format stream "~D" (measure-total-cost obj))))

(defmethod combine-cost ((method measure-cost-method)
				(seq-cost measure-seq-cost)
				(elem measure))
  (make-instance 'measure-seq-cost
    :coeff (+ (coeff seq-cost) (measure-coeff elem))
    :min-dist (min (min-dist seq-cost) (measure-min-dist elem))
    :nb-measures (1+ (nb-measures seq-cost))))

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


(defmethod combine-cost ((method measure-cost-method)
				(elem measure)
				(whatever (eql nil)))
  (make-instance 'measure-seq-cost
    :coeff (measure-coeff elem)
    :min-dist (measure-min-dist elem)
    :nb-measures 1))

(defmethod combine-cost ((method measure-cost-method)
				(whatever (eql nil))
				(elem measure))
  (combine-cost method elem nil))

(defmethod reduced-width ((method measure-cost-method)
			  (seq-cost measure-seq-cost))
  (if (zerop (min-dist seq-cost))
      0
      (* (coeff seq-cost) (min-width method)
	 (expt (/ (min-dist seq-cost)) (spacing-style method)))))

(defmethod natural-width ((method measure-cost-method)
			  (seq-cost measure-seq-cost))
  (+ (reduced-width method seq-cost)
     (* (nb-measures seq-cost) (min-width method))))

(defmethod compress-factor ((method measure-cost-method)
			    (seq-cost measure-seq-cost))
  (/ (natural-width method seq-cost) (line-width method)))

(defmethod measure-seq-cost ((method measure-cost-method)
			     (seq-cost measure-seq-cost))
  (let ((c (compress-factor method seq-cost)))
    (max c (/ c))))

(defmethod seq-cost-cannot-decrease ((method measure-cost-method)
					    (seq-cost measure-seq-cost))
  (>= (natural-width method seq-cost)
      (line-width method)))

(defmethod cost-less ((method measure-cost-method)
		      (c1 measure-seq-cost)
		      (c2 measure-seq-cost))
  (< (measure-seq-cost method c1) (measure-seq-cost method c2)))

(defmethod cost-less ((method measure-cost-method)
		      (c1 measure-total-cost)
		      (c2 measure-total-cost))
  (< (measure-total-cost c1) (measure-total-cost c2)))

(defmethod cost-less ((method measure-cost-method)
			     (c1 measure-seq-cost)
			     (c2 measure-seq-cost))
  (< (measure-seq-cost method c1) (measure-seq-cost method c2)))

(defmethod cost-less ((method measure-cost-method)
		      (c1 measure-total-cost)
		      (c2 measure-total-cost))
  (< (measure-total-cost c1) (measure-total-cost c2)))

