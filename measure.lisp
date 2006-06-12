(in-package :gsharp-measure)

(defmacro defrclass (name base slots)
  `(progn 
     (define-added-mixin ,name () ,base
       ((modified-p :initform t :accessor modified-p)
	,@slots))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Key signature

(defmethod more-sharps :after ((sig key-signature) &optional n)
  (declare (ignore n))
  (let ((staff (staff sig)))
    (invalidate-everything-using-staff (buffer staff) staff)))

(defmethod more-flats :after ((sig key-signature) &optional n)
  (declare (ignore n))
  (let ((staff (staff sig)))
    (invalidate-everything-using-staff (buffer staff) staff)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Staff

(define-added-mixin rstaff () staff
  ((rank :accessor staff-rank)))

(defun invalidate-slice-using-staff (slice staff)
  (declare (ignore staff)) ; maybe use this later
  (loop for bar in (bars slice)
	do (loop for element in (elements bar)
		 do (mark-modified element))))

(defun invalidate-everything-using-staff (buffer staff)
  (loop for segment in (segments buffer)
	do (loop for layer in (layers segment)
		 do (when (member staff (staves layer))
		      (invalidate-slice-using-staff (head layer) staff)
		      (invalidate-slice-using-staff (body layer) staff)
		      (invalidate-slice-using-staff (tail layer) staff)))))
		      
(defmethod (setf clef) :before (clef (staff staff))
  (invalidate-everything-using-staff (buffer staff) staff))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Note

(defrclass rnote note
  (;; The relative x offset of the accidental of the note with respect
   ;; to the cluster.  A value of nil indicates that accidental has
   ;; not been placed yet
   (final-relative-accidental-xoffset :initform nil
				      :accessor final-relative-accidental-xoffset)
   (final-accidental :initform nil :accessor final-accidental)
   ;; the relative x offset of the note with respect to the cluster
   (final-relative-note-xoffset :accessor final-relative-note-xoffset)))

;;; given a list of notes, group them so that every note in the group
;;; is displayed on the same staff.  Return the list of groups. 
(defun group-notes-by-staff (notes)
  (let ((groups '()))
    (loop while notes do
	  (push (remove (staff (car notes)) notes :test-not #'eq :key #'staff) groups)
	  (setf notes (remove (staff (car notes)) notes :test #'eq :key #'staff)))
    groups))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Element

;;; The relement class mixes into the element class.  It adds
;;; a `duration' slot that contains the duration of the element. 
;;; It also makes sure that whenever the duration of an element
;;; is being asked for, the new value is computed should any 
;;; modification to the element have taken place in the meantime. 

(defrclass relement element
  ((duration :initform nil)
   (timeline :accessor timeline)))   

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

(defmethod (setf stem-direction) :after (direction (element relement))
  (declare (ignore direction))
  (mark-modified element))

(defmethod append-char :after ((element lyrics-element) char)
  (declare (ignore char))
  (mark-modified element))

(defmethod note-position ((note note))
  (let ((clef (clef (staff note))))
    (- (pitch note)
       (bottom-line clef))))

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

(define-added-mixin rcluster () cluster
  ((final-stem-direction :accessor final-stem-direction)
   ;; the position, in staff steps, of the top not in the element.
   (top-note-pos :accessor top-note-pos)
   ;; the position, in staff steps, of the bottom note in the element.
   (bot-note-pos :accessor bot-note-pos)))

;;; Return true if and only if the element is a non-empty cluster
(defun non-empty-cluster-p (element)
  (and (typep element 'cluster)
       (not (null (notes element)))))

;;; Compute and store some important information about a non-empty
;;; cluster:
;;;  * the position, in staff steps of the top note.
;;;  * the position, in staff steps of the bottom note.
(defun compute-top-bot-pos (cluster)
  (assert (non-empty-cluster-p cluster))
  (setf (top-note-pos cluster) (note-position (top-note (notes cluster)))
	(bot-note-pos cluster) (note-position (bot-note (notes cluster)))))

(defmethod add-note :after ((element relement) (note note))
  (mark-modified element))

(defmethod remove-note :before ((note rnote))
  (when (cluster note)
    (mark-modified (cluster note))))

;;; Given a non-empty cluster that is not beamed together with any
;;; other clusters, compute and store its final stem direction.
(defun compute-final-stem-direction (cluster)
  (assert (non-empty-cluster-p cluster))
  (setf (final-stem-direction cluster)
	(if (or (eq (stem-direction cluster) :up) (eq (stem-direction cluster) :down))
	    (stem-direction cluster)
	    (let ((top-note-pos (top-note-pos cluster))
		  (bot-note-pos (bot-note-pos cluster)))
	      (if (>= (- top-note-pos 4)
		      (- 4 bot-note-pos))
		  :down
		  :up)))))

;;; Given a beam group containing at least two nonempty clusters,
;;; compute and store the final stem directions of all the non-empty
;;; clusters in the group
(defun compute-final-stem-directions (elements)
  (let ((stem-direction (if (not (eq (stem-direction (car elements)) :auto))
			    (stem-direction (car elements))
			    (let ((top-note-pos
				   (loop for element in elements
					 when (non-empty-cluster-p element)
					 maximize (top-note-pos element)))
				  (bot-note-pos
				   (loop for element in elements
					 when (non-empty-cluster-p element)
					 minimize (top-note-pos element))))
			      (if (>= (- top-note-pos 4) (- 4 bot-note-pos)) :down :up)))))
    (loop for element in elements
	  when (non-empty-cluster-p element)
	  do (setf (final-stem-direction element) stem-direction))))

;;; Given a list of notes to be displayed on the same staff line, for
;;; each note, compute the accidental to be displayed as a function of
;;; the accidentals of the note and the key signature of the staff.
(defun compute-final-accidentals (group)
  (loop for note in group do
	(setf (final-accidental note)
	      (if (eq (accidentals note)
		      (aref (alterations (keysig (staff note))) (mod (pitch note) 7)))
		  nil
		  (accidentals note)))))

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
(defun compute-final-relative-accidental-xoffset (notes final-stem-direction)
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
	     (find 0 notes-with-accidentals :test #'/= :key #'final-relative-note-xoffset)))
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
;;; Timeline

;;; A timeline of a measure is the set of all simultaneous elements of
;;; the bars of the meausure.  The duration of a timeline is either
;;; the temporal distance between it and the next closest timeline
;;; following it, or, in case it is the last timeline of the measure,
;;; the duration of the longest element of the timeline.

(defclass timeline (flexichain:element-rank-mixin)
  ((start-time :initarg :start-time :reader start-time)
   (elements :initform '() :accessor elements)
   (duration :initarg :duration :accessor duration)
   (elasticity :accessor elasticity)
   ;; the minimum x offset from this timeline to the next, or, if this
   ;; is the last timeline, from this one to the end of the measure
   (smallest-gap :initform 0 :accessor smallest-gap)))

(defclass ranked-flexichain (flexichain:standard-flexichain flexichain:flexirank-mixin)
  ())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Measure

;;; A measure represents the set of simultaneous bars.
(defclass measure (obseq-elem)
  (;; the smallest duration of any timeline in the measure
   (min-dist :initarg :min-dist :accessor measure-min-dist)
   ;; the coefficient of a measure is the sum of d_i^k where d_i
   ;; is the duration of the i:th timeline, and k is the spacing style
   (coeff :initarg :coeff :accessor measure-coeff)
   ;; the position of a measure in the sequence of measures
   ;; of a buffer is indicated by two numbers, the position
   ;; of the segment to which the measure belongs within the
   ;; sequence of segments of the buffer, and the position of
   ;; the bars within that segment. 
   (seg-pos :initarg :seg-pos :reader measure-seg-pos)
   (bar-pos :initarg :bar-pos :reader measure-bar-pos)
   ;; a list of the bars that make up this measure
   (bars :initarg :bars :reader measure-bars)
   ;; a ranked flexichain of timelines
   (timelines :initform (make-instance 'ranked-flexichain) :reader timelines)
   ;; a convex piecewise-linear function that determines the
   ;; horizontal size of the measure as a function of the "force" that
   ;; is applied to it
   (elasticity-function :accessor elasticity-function)))

(defun make-measure (seg-pos bar-pos bars)
  (make-instance 'measure :seg-pos seg-pos :bar-pos bar-pos :bars bars))

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
    (let ((spacing-style (spacing-style (buffer-cost-method (buffer segment)))))
      (compute-measures segment)
      ;; avoid an infinite computation by using slot-value here
      (loop for measure in (slot-value segment 'measures)
	    do (compute-timelines measure spacing-style)))
    (setf (modified-p segment) nil)))

(defmethod nb-measures ((segment rsegment))
  (length (measures segment)))

;;; Given a segment and a position, return the measure in that 
;;; position in the sequence of measures in the segment. 
(defmethod measureno ((segment rsegment) position)
  (elt (measures segment) position))

;;; Given a group of notes (i.e. a list of notes, all displayed on the
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

(defun compute-staff-group-parameters (staff-group stem-direction)
  (compute-final-relative-note-xoffsets staff-group stem-direction)
  (compute-final-accidentals staff-group)
  (compute-final-relative-accidental-xoffset staff-group stem-direction))

;;; compute some important parameters of an element
(defgeneric compute-element-parameters (element))

(defmethod compute-element-parameters (element)
  nil)

(defmethod compute-element-parameters ((element cluster))
  (when (non-empty-cluster-p element)
    (compute-top-bot-pos element)
    (loop for staff-group in (group-notes-by-staff (notes element))
	  do (compute-staff-group-parameters staff-group (final-stem-direction element)))))

(defun compute-beam-group-parameters (elements)
  (let ((any-element-modified nil))
    (loop for element in elements
	  do (when (modified-p element)
	       (when (non-empty-cluster-p element)
		 (compute-top-bot-pos element))
	       (setf any-element-modified t)))
    (when any-element-modified
      (if (null (cdr elements))
	  (when (non-empty-cluster-p (car elements))
	    (compute-final-stem-direction (car elements)))
	  (compute-final-stem-directions elements)))
    (loop for element in elements
	  do (when (modified-p element)
	       (compute-element-parameters element)
	       (setf (modified-p element) nil)))))

;;; Given a list of the elements of a bar, return a list of beam
;;; groups.  A beam group is defined to be either a singleton list or
;;; a list with more than one element.  In the case of a singleton,
;;; the element is either a non-cluster, an empty cluster, a cluster
;;; that does not beam to the right, or a cluster that does beam to
;;; the right, but either it is the last cluster in the bar, or the
;;; first following cluster in the bar does not beam to the left.  In
;;; the case of a list with more than one element, the first element
;;; is a cluster that beams to the right, the last element is a
;;; cluster that beams to the left, and all other clusters in the list
;;; beam both to the left and to the right.  Notice that in the last
;;; case, elements other than the first and the last can be
;;; non-clusters, or empty clusters.
(defun beam-groups (elements)
  (let ((group '()))
    (loop until (null elements) do
	  (setf group (list (car elements))
		elements (cdr elements))
	  (when (and (non-empty-cluster-p (car group))
		     (plusp (rbeams (car group))))
	    (loop while (and (not (null elements))
			     (or (not (typep (car elements) 'cluster))
				 (null (notes (car elements)))
				 (plusp (lbeams (car elements)))))
		  do (push (pop elements) group)
		  until (and (non-empty-cluster-p (car group))
			     (zerop (rbeams (car group)))))
	    ;; pop off trailing unbeamable objects
	    (loop until (non-empty-cluster-p (car group))
		  do (push (pop group) elements)))
	  collect (nreverse group))))

;;; compute some important parameters of a bar
(defgeneric compute-bar-parameters (bar))

(defmethod compute-bar-parameters (bar)
  nil)

(defmethod compute-bar-parameters ((bar melody-bar))
  (loop for group in (beam-groups (elements bar))
	do (compute-beam-group-parameters group)))	

;;; From a list of simultaneous bars (and some other stuff), create a
;;; measure.  The `other stuff' is the spacing style, which is needed
;;; in order to compute the coefficient of the measure, the position
;;; of the segment to which the bars belong in the sequence of
;;; segments of the buffer, and the position of the bars in the
;;; sequence of bars within that segment.  The last two items are used
;;; to indicate the position of the measure in the sequence of all
;;; measures of the buffer.
(defun compute-measure (bars seg-pos bar-pos)
  (score-pane:with-staff-size 6
    (loop for bar in bars
	  do (when (modified-p bar)
	       (compute-bar-parameters bar)
	       (setf (modified-p bar) nil)))
    (make-measure seg-pos bar-pos bars)))

(defun compute-timelines (measure spacing-style)
  (let ((timelines (timelines measure)))
    (flet ((compute-bar-timelines (bar)
	      (loop with timeline-index = 0
		    for element in (elements bar)
		    and start-time = 0 then (+ start-time (duration element))
		    do (loop until (= timeline-index (flexichain:nb-elements timelines))
			     for timeline = (flexichain:element* timelines timeline-index)
			     until (or (> (start-time timeline) start-time)
				       (and (= (start-time timeline) start-time)
					    (or (zerop (duration element))
						;; either none or every element of a timline
						;; has zero duration, so we only have to test
						;; the first one. 
						(not (zerop (duration (car (elements timeline))))))))
			     do (incf timeline-index))
		    do (when (or (= timeline-index (flexichain:nb-elements timelines))
				 (let ((timeline (flexichain:element* timelines timeline-index)))
				   (or (> (start-time timeline) start-time)
				       (and (zerop (duration element))
					    (not (zerop (duration (car (elements timeline)))))))))
			 (let ((timeline (make-instance 'timeline
							:start-time start-time)))
			   (flexichain:insert* timelines timeline-index timeline)))
		    do (let ((timeline (flexichain:element* timelines timeline-index)))
			 (push element (elements timeline))
			 (setf (timeline element) timeline)
			 (incf timeline-index)))))
      (loop for bar in (measure-bars measure)
	    do (compute-bar-timelines bar)))
    ;; compute the duration of each timeline except the last one
    (loop for i from 0 below (1- (flexichain:nb-elements timelines))
	  do (setf (duration (flexichain:element* timelines i))
		   (- (start-time (flexichain:element* timelines (1+ i)))
		      (start-time (flexichain:element* timelines i)))))
    ;; compute the duration of the last timeline, if any
    (unless (zerop (flexichain:nb-elements timelines))
      (let ((measure-duration (reduce #'max (measure-bars measure) :key #'duration))
	    (last-timeline (flexichain:element* timelines (1- (flexichain:nb-elements timelines)))))
	(setf (duration last-timeline) (- measure-duration (start-time last-timeline)))))
    ;; set the coefficient and the min-dist of the measure
    (loop with min-dist = 10000 
	  for timeline-index from 0 below (flexichain:nb-elements timelines)
	  for duration = (duration (flexichain:element* timelines timeline-index))
	  sum (expt duration spacing-style) into coeff
	  do (when (plusp duration) (setf min-dist (min min-dist duration)))
	  ;; timelines with zero duration do not intervene in the calculation
	  ;; of the min-dist
	  finally (setf (measure-coeff measure) coeff
			(measure-min-dist measure) min-dist))))

;;; Compute all the measures of a segment by stepping through all the
;;; bars in parallel as long as there is at least one simultaneous bar.
(defun compute-measures (segment)
  (setf (slot-value segment 'measures)
	(loop for all-bars on (mapcar (lambda (layer) (bars (body layer)))
				      (layers segment))
	      by (lambda (bars) (mapcar #'cdr bars))
	      as bar-pos from 0 by 1
	      while (notevery #'null all-bars)
	      collect (compute-measure
		       (remove nil (mapcar #'car all-bars))
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
  (setf (modified-p buffer) t)
  (setf (needs-saving buffer) t))

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
	   (- (right-edge buffer) (left-margin buffer) (left-offset buffer))
	   (floor 12 (length (staves buffer)))))
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
   (line-width :initarg :line-width :reader line-width)
   ;; number of lines that will fit on a page
   (lines-per-page :initarg :lines-per-page :reader lines-per-page)))

(defun make-measure-cost-method (min-width spacing-style line-width lines-per-page)
  (make-instance 'measure-cost-method
		 :min-width min-width
		 :spacing-style spacing-style
		 :line-width line-width
		 :lines-per-page lines-per-page))
				 
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
;;; measures must be compressed in order to fit the width at our
;;; disposal.  Values > 1 indicate that the sequence of mesures must
;;; be stretched instead of compressed.
(defmethod compress-factor ((method measure-cost-method)
			    (seq-cost measure-seq-cost))
  (/ (natural-width method seq-cost)
     (* (line-width method) (lines-per-page method))))

;;; As far as Gsharp is concerned, we define the cost of a sequence of
;;; measures as the max of the compress factor and its inverse.  In
;;; other words, we consider it as bad to have to stretch a sequence by x%
;;; as it is to have to compress it by x%, and the more we have to
;;; compress or expand it, the worse it is.  This way of doing it is
;;; not great.  At some point, we need to severely penalize compressed
;;; sequences that become too short to display without overlaps, unless
;;; the sequence contains a single measure, of course.
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
