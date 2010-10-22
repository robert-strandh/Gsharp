(in-package :gsharp-buffer)

(defparameter *gsharp-readtable-v3* (copy-readtable))
(defparameter *gsharp-readtable-v4* (copy-readtable))

(defun read-gsharp-object-v4 (stream char)
  (declare (ignore char))
  (apply #'make-instance (read-delimited-list #\] stream t)))

(make-dispatch-macro-character #\[ nil *gsharp-readtable-v3*)
(set-macro-character #\[ #'read-gsharp-object-v4 nil *gsharp-readtable-v4*)
(set-syntax-from-char #\] #\) *gsharp-readtable-v3*)
(set-syntax-from-char #\] #\) *gsharp-readtable-v4*)

(defgeneric slots-to-be-saved (object)
  (:method-combination append :most-specific-last))

(defun save-object (object stream)
  (pprint-logical-block (stream nil :prefix "[" :suffix "]")
    (format stream "~s ~2i" (class-name (class-of object)))
    (loop for slot-name in (slots-to-be-saved object)
	  do (let ((slot (find slot-name (clim-mop:class-slots (class-of object))
			       :key #'clim-mop:slot-definition-name
			       :test #'eq)))
	       (format stream "~_~W ~W "
		       (car (clim-mop:slot-definition-initargs slot))
		       (slot-value object (clim-mop:slot-definition-name slot)))))))

(defclass gsharp-object () ())

(defmethod print-object ((obj gsharp-object) stream)
  (if *print-circle*
      (save-object obj stream)
      (print-unreadable-object (obj stream :type t :identity t))))

(define-condition gsharp-condition (error) ())

(defgeneric name (obj))

(defclass name-mixin ()
  ((name :initarg :name :accessor name)))

(defmethod slots-to-be-saved append ((obj name-mixin))
  '(name))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Staff

(defclass staff (gsharp-object name-mixin)
  ((buffer :initarg :buffer :accessor buffer))
  (:default-initargs :name "default staff"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Element

;;; Return the bar to which the element belongs, or nil of the element
;;; currently does not belong to any bar. 
(defgeneric bar (element))

(defclass element (gsharp-object)
  ((bar :initform nil :initarg :bar :accessor bar)
   (xoffset :initform 0 :initarg :xoffset :accessor xoffset)
   (right-pad :initform 0 :initarg :right-pad :accessor right-pad)
   (left-pad :initform 0 :initarg :left-pad :accessor left-pad)
   (annotations :initform nil :initarg :annotations :accessor annotations)))

(defmethod slots-to-be-saved append ((e element))
  '(xoffset annotations left-pad right-pad))

(defmethod duration ((element element)) 0)
(defmethod rbeams ((element element)) 0)
(defmethod lbeams ((element element)) 0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Rhythmic element

;;; Return the notehead of the element.  With setf, set the notehead
;;; of the element. 
(defgeneric notehead (rhythmic-element))
(defgeneric (setf notehead) (notehead rhythmic-element))

;;; Return the number of right beams of the element.  With setf, set
;;; the number of right beams of the element.
(defgeneric rbeams (rhythmic-element))
(defgeneric (setf rbeams) (rbeams rhythmic-element))

;;; Return the number of left beams of the element.  With setf, set
;;; the number of left beams of the element.
(defgeneric lbeams (rhythmic-element))
(defgeneric (setf lbeams) (lbeams rhythmic-element))

;;; Return the number of dots of the element.  With setf, set the
;;; number of dots of the element. 
(defgeneric dots (rhythmic-element))
(defgeneric (setf dots) (dots rhythmic-element))

(defclass rhythmic-element (element)
  ((notehead :initform :whole :initarg :notehead :accessor notehead)
   (rbeams :initform 0 :initarg :rbeams :accessor rbeams)
   (lbeams :initform 0 :initarg :lbeams :accessor lbeams)
   (dots :initform 0 :initarg :dots :accessor dots)))
   
(defmethod slots-to-be-saved append ((e rhythmic-element))
  '(notehead rbeams lbeams dots))

(defmethod undotted-duration ((element rhythmic-element))
  (ecase (notehead element)
    (:long 4)
    (:breve 2)
    (:whole 1)
    (:half 1/2)
    (:filled (/ (expt 2 (+ 2 (max (rbeams element)
                                  (lbeams element))))))))

(defmethod duration ((element rhythmic-element))
  (let ((duration (undotted-duration element)))
    (do ((dot-duration (/ duration 2) (/ dot-duration 2))
         (nb-dots (dots element) (1- nb-dots)))
        ((zerop nb-dots))
      (incf duration dot-duration))
    duration))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Bar

;;; It is recommended that the concept of a bar be hidden from the
;;; user, and that a measure bar, or a repeat sign be considered by
;;; the end-user as members of slices the way clusters are.

;;; Return the slice to which the bar belongs, or nil if the bar
;;; currently does not belong to any slice.
(defgeneric slice (bar))

;;; Return the elements of the bar.
(defgeneric elements (bar))

;;; Return the number of elements of the bar.
(defgeneric nb-elements (bar))

;;; Return the element at the position of the bar.
(defgeneric elementno (bar position))

;;; Add an element to the bar at the position indicated
(defgeneric add-element (element bar position))

;;; Delete an element from the bar to which it belongs. 
(defgeneric remove-element (element bar))

(defclass bar (gsharp-object)
  ((slice :initform nil :initarg :slice :accessor slice)
   (elements :initform '() :initarg :elements :accessor elements)))

(defmethod initialize-instance :after ((b bar) &rest args)
  (declare (ignore args))
  (loop for element in (elements b)
        do (setf (bar element) b)))

(defmethod slots-to-be-saved append ((b bar))
  '(elements))

;;; The duration of a bar is simply the sum of durations
;;; of its elements.  We might want to improve on the 
;;; implementation of this method so that it uses some 
;;; kind of cache, in order to avoid looping over each 
;;; element and computing the duration of each one each time.
(defmethod duration ((bar bar))
  (reduce #'+ (elements bar) :key #'duration))

(defgeneric make-bar-for-staff (staff &rest args &key elements))

(defmethod nb-elements ((bar bar))
  (length (elements bar)))

(defmethod elementno ((bar bar) position)
  (with-slots (elements) bar
    (elt elements position)))

(define-condition element-already-in-bar (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Attempt to add an element already in a bar"))))

(defmethod add-element ((element element) (b bar) position)
  (with-slots (bar) element
    (assert (not bar) () 'element-already-in-bar)
    (with-slots (elements) b
      (setf elements (ninsert-element element elements position)))
    (setf bar b)))

(defun sort-staffwise-elements (staff)
  (setf (staffwise-elements staff)
        (sort (staffwise-elements staff)
              (lambda (x y) (gsharp::starts-before-p x (bar y) y)))))

;;; fix this and move it to melody.lisp
(defun maybe-update-key-signatures (bar)
  (let* ((layer (layer (slice bar)))
	 (staves (staves layer)))
    (dolist (staff staves)
      ;; FIXME: this isn't the Right Thing: instead we should be using
      ;; something like maybe-update-key-signatures-using-staff.
      (when (typep staff 'fiveline-staff)
	(let ((key-signatures (key-signatures staff)))
	  (when (and key-signatures
		     (find (gsharp-numbering:number bar) key-signatures 
			   :key (lambda (x) (gsharp-numbering:number (bar x)))))
	    ;; we actually only need to invalidate everything in the
	    ;; current bar using the staff, not the entire staff, but...
	    (gsharp-measure::invalidate-everything-using-staff (buffer staff) staff)
	    ;; there might be more than one key signature in the bar,
	    ;; and they might have changed their relative order as a
	    ;; result of the edit.
        (sort-staffwise-elements staff)))))))
 
(defmethod add-element :after ((element element) (bar bar) position)
  (maybe-update-key-signatures bar))
 
(define-condition element-not-in-bar (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Attempt to delete an element not in a bar"))))

(defmethod remove-element ((element element) (b bar))
  (with-slots (bar) element
    (assert (and bar (eq b bar)) () 'element-not-in-bar)
    (with-slots (elements) bar
      (setf elements (delete element elements :test #'eq)))
    (setf bar nil)))

(defmethod remove-element :before ((element element) (bar bar))
  (maybe-update-key-signatures bar))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Slice

;;; Return the layer of the slice
(defgeneric layer (slice))

;;; Return the bars of the slisce
(defgeneric bars (slice))

;;; Return the number of bars of the slice
(defgeneric nb-bars (slice))

;;; Return the bar at the position
(defgeneric barno (slice position))

;;; Add a bar to the slice at the position indicates
(defgeneric add-bar (bar slice position))

;;; Delete a bar from the slice to which it belongs.
(defgeneric remove-bar (bar))

(defclass slice (gsharp-object)
  ((layer :initform nil :initarg :layer :accessor layer)
   (bars :initform '() :initarg :bars :accessor bars)))

(defmethod initialize-instance :after ((s slice) &rest args)
  (declare (ignore args))
  (loop for bar in (bars s)
        do (setf (slice bar) s)))

(defun make-slice (&rest args &key bars)
  (declare (type list bars)
           (ignore bars))
  (apply #'make-instance 'slice args))

(defmethod slots-to-be-saved append ((s slice))
  '(bars))

(defun read-slice-v3 (stream char n)
  (declare (ignore char n))
  (apply #'make-instance 'slice (read-delimited-list #\] stream t)))

(set-dispatch-macro-character #\[ #\/
  #'read-slice-v3
  *gsharp-readtable-v3*)

(defmethod nb-bars ((slice slice))
  (length (bars slice)))

(defmethod barno ((slice slice) position)
  (elt (bars slice) position))

(define-condition bar-already-in-slice (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Attempt to add a bar already in a slice"))))

(defmethod add-bar ((bar bar) (s slice) position)
  (with-slots (slice) bar
    (assert (not slice) () 'bar-already-in-slice)
    (with-slots (bars) s
      (setf bars (ninsert-element bar bars position)))
    (setf slice s)))

(define-condition bar-not-in-slice (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Attempt to delete a bar not in a slice"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Layer

;;; Return the segment to which the layer belongs.
(defgeneric segment (layer))

;;; Return a list of the (exactly three) slices of the layer.  This
;;; function may or may not return an object that reflects some
;;; internal structure of Gsharp.  Don't modify this object.  On the
;;; other hand, this function may also require some unnecessary
;;; consing.  For that reason, use the function slice whenever
;;; possible.
(defgeneric slices (layer))

;;; Return a slice of a layer.  The position argument is a
;;; non-negative integer which must be greater than or equal to zero
;;; and strictly less than three.
(defgeneric sliceno (layer position))

;;; Return the head slice of the layer
(defgeneric head (layer))

;;; Return the body slice of the layer
(defgeneric body (layer))

;;; Return the tail slice of the layer
(defgeneric tail (layer))

(defclass layer (gsharp-object name-mixin)
  ((segment :initform nil :initarg :segment :accessor segment)
   (staves :initarg :staves :accessor staves)
   (head :initarg :head :accessor head)
   (body :initarg :body :accessor body)
   (tail :initarg :tail :accessor tail))
  (:default-initargs :name "default layer"))

(defmethod initialize-instance :after ((l layer) &rest args &key head body tail)
  (declare (ignore args))
  (let ((staff (car (staves l))))
    (unless head
      (setf (head l) (make-slice :bars (list (make-bar-for-staff staff)))))
    (unless body 
      (setf (body l) (make-slice :bars (list (make-bar-for-staff staff)))))
    (unless tail
      (setf (tail l) (make-slice :bars (list (make-bar-for-staff staff))))))
  (setf (layer (head l)) l
        (layer (body l)) l
        (layer (tail l)) l))

(defmethod slots-to-be-saved append ((l layer))
  '(staves head body tail))

(defgeneric make-layer-for-staff (staff &rest args &key staves head body tail &allow-other-keys))

(defun make-layer (staves &rest args &key head body tail &allow-other-keys)
  (declare (type list staves)
           (type (or slice null) head body tail)
           (ignore head body tail))
  (apply #'make-layer-for-staff (car staves) :staves staves args))         

(defmethod slices ((layer layer))
  (with-slots (head body tail) layer
    (list head body tail)))

(defmethod sliceno ((layer layer) position)
  (ecase position
    (0 (head layer))
    (1 (body layer))
    (2 (tail layer))))

(define-condition staff-already-in-layer (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "That staff is already in the layer"))))

(define-condition staff-not-in-layer (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "That staff is not in the layer"))))

(define-condition only-staff-in-layer (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Only staff in the layer"))))

(defmethod add-staff-to-layer ((staff staff) (layer layer))
  (assert (not (member staff (staves layer) :test #'eq))
          () 'staff-already-in-layer)
  (push staff (staves layer)))

(defmethod remove-staff-from-layer ((staff staff) (layer layer))
  (assert (not (null (staves layer)))
          () 'only-staff-in-layer)
  (assert (member staff (staves layer) :test #'eq)
          () 'staff-not-in-layer)
  (setf (staves layer)
        (delete staff (staves layer) :test #'eq)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Segment

;;; Return the buffer to which the segment belongs, or nil if the
;;; segment is currently not inserted in any buffer. 
(defgeneric buffer (segment))

;;; Return a list of the layers of the segment.  This function may or
;;; may not return an object that reflects some internal structure of
;;; Gsharp.  Don't modify this object.  On the other hand, this
;;; function may also require some unnecessary consing.  For that
;;; reason, use the function segment-layer whenever possible.
(defgeneric layers (segment))

;;; Return the number of layers in the segment
(defgeneric nb-layers (segment))

;;; Return a layer of the segment.  The position argument is a
;;; non-negative integer which must be greater than or equal to zero
;;; and strictly less than the number of layers of the segment.
(defgeneric layerno (segment position))

;;; Add a layer to a segment.
(defgeneric add-layer (layer segment))

;;; Delete a layer from the segment to which it belongs
(defgeneric remove-layer (layer))

(defclass segment (gsharp-object)
  ((buffer :initform nil :initarg :buffer :accessor buffer)
   (layers :initform '() :initarg :layers :accessor layers)
   (tempo :initform 128 :initarg :tempo :accessor tempo)
   (tuning :initform (make-instance '12-edo)
           :initarg :tuning :accessor tuning)))

(defmethod initialize-instance :after ((s segment) &rest args &key staff)
  (declare (ignore args))
  (with-slots (layers) s
    (when (null layers)
      (assert (not (null staff)))
      (push (make-layer (list staff)) layers))
    (loop for layer in layers
          do (setf (segment layer) s))))

(defmethod slots-to-be-saved append ((s segment))
  '(layers tempo tuning))

(defun read-segment-v3 (stream char n)
  (declare (ignore char n))
  (apply #'make-instance 'segment (read-delimited-list #\] stream t)))

(set-dispatch-macro-character #\[ #\S
  #'read-segment-v3
  *gsharp-readtable-v3*)

(defmethod nb-layers ((segment segment))
  (length (layers segment)))

(defmethod layerno ((segment segment) position)
  (elt (layers segment) position))

(define-condition layer-already-in-a-segment (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Attempt to add a layer already in a segment"))))

(defmethod add-layer ((layer layer) (seg segment))
  (with-slots (segment) layer
    (assert (not segment) () 'layer-already-in-a-segment)
    (with-slots (layers) seg
       (push layer layers))
    (setf segment seg)))

(define-condition layer-not-in-segment (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Attempt to delete a layer which is not in a segment"))))

(defmethod remove-layer ((layer layer))
  (with-slots (segment) layer
    (assert segment () 'layer-not-in-segment)
    (with-slots (layers) segment
      (setf layers (delete layer layers :test #'eq))
      ;; make sure there is one layer left
      (unless layers
        (add-layer (make-layer (staves (buffer segment)))
                   segment)))
    (setf segment nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Buffer

;;; Return a list of all the segment (in the right order) of the
;;; buffer.  This function may or may not return an object that
;;; reflects some internal structure of Gsharp.  Don't modify this
;;; object.  On the other hand, this function may also require some
;;; unnecessary consing.  For that reason, use the function
;;; buffer-segment whenever possible.
(defgeneric segments (buffer))

;;; Return the number of segments of the buffer
(defgeneric nb-segments (buffer))

;;; Return the segment indicated by the integer position.  The value of
;;; segno must be greater than or equal to 0 and strictly less than
;;; the number of segments of the buffer.
(defgeneric segmentno (buffer position))

;;; Return the staves of the buffer
(defgeneric staves (buffer))

;;; Find a staff based on its name
(defgeneric find-staff (staff-name buffer &optional errorp))

;;; Add a segment to the buffer at the position given
(defgeneric add-segment (segment buffer position))

;;; Delete a segment from the buffer to which it belongs
(defgeneric remove-segment (segment))

(defvar *default-spacing-style* 0.4)
(defvar *default-min-width* 17)
(defvar *default-right-edge* 700)
(defvar *default-left-offset* 30)
(defvar *default-left-margin* 20)

(defclass buffer (gsharp-object esa-buffer-mixin)
  ((segments :initform '() :initarg :segments :accessor segments)
   (staves :initform (list (make-fiveline-staff))
           :initarg :staves :accessor staves)
   (rastral-size :initform 6 :initarg :r-size :accessor rastral-size)
   (zoom-level :initform 1 :initarg :zoom :accessor zoom-level)
   ;; the min width determines the preferred geographic distance after the
   ;; timeline with the shortest duration on a line.
   (min-width :initform *default-min-width* :initarg :min-width :accessor min-width)
   ;; the spacing style of the buffer determines the how geographic distance
   ;; between adjacent timelines is related to temporal distance.
   ;; a value of 0 means constant spacing, a value of 1 means proportional spacing
   (spacing-style :initform *default-spacing-style* :initarg :spacing-style :accessor spacing-style)
   (right-edge :initform *default-right-edge* :initarg :right-edge :accessor right-edge)
   (left-offset :initform *default-left-offset* :initarg :left-offset :accessor left-offset)
   (left-margin :initform *default-left-margin* :initarg :left-margin :accessor left-margin)))

(defmethod left-offset ((buffer buffer))
  (* (rastral-size buffer) 4))

(defun buffer-selection (buffer)
  (when (buffer-back-selection buffer)
    (car (buffer-back-selection buffer))))

(defun selection-browse-backward (buffer)
  (when (buffer-back-selection buffer)
    (push (car (buffer-back-selection buffer))
          (buffer-forward-selection buffer))
    (setf (buffer-back-selection buffer)
          (cdr (buffer-back-selection buffer)))))

(defun selection-browse-forward (buffer)
  (when (buffer-forward-selection buffer)
    (push (car (buffer-forward-selection buffer))
          (buffer-back-selection buffer))
    (setf (buffer-forward-selection buffer)
          (cdr (buffer-forward-selection buffer)))))

(defun add-new-selection (element-list buffer)
  (dolist (selection (buffer-forward-selection buffer)
           (push element-list (buffer-back-selection buffer)))
    (push selection (buffer-back-selection buffer))))

(defun set-buffer-of-staves (buffer)
  (loop for staff in (staves buffer)
        do (setf (buffer staff) buffer)))

(defmethod (setf staves) :after (staves (buffer buffer))
  (declare (ignore staves))
  (set-buffer-of-staves buffer))

(defmethod initialize-instance :after ((b buffer) &rest args)
  (declare (ignore args))
  (set-buffer-of-staves b)
  (with-slots (segments) b
    (when (null segments)
      (add-segment (make-instance 'segment :staff (car (staves b))) b 0))
    (loop for segment in segments
          do (setf (buffer segment) b))))

(defmethod slots-to-be-saved append ((b buffer))
  '(min-width spacing-style right-edge left-offset left-margin staves segments))

(defun read-buffer-v3 (stream char n)
  (declare (ignore char n))
  (apply #'make-instance 'buffer (read-delimited-list #\] stream t)))

(set-dispatch-macro-character #\[ #\B
  #'read-buffer-v3
  *gsharp-readtable-v3*)

(defmethod nb-segments ((buffer buffer))
  (length (segments buffer)))

(defmethod segmentno ((buffer buffer) position)
  (elt (segments buffer) position))

(define-condition segment-already-in-a-buffer (gsharp-condition)
  ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Attempt to add a segment already in some buffer"))))

(defmethod add-segment ((segment segment) (buf buffer) position)
  (with-slots (buffer) segment
    (assert (not buffer) () 'segment-already-in-a-buffer)
    (with-slots (segments) buf
      (setf segments (ninsert-element segment segments position)))
    (setf buffer buf)))

(define-condition segment-not-in-buffer (gsharp-condition)
  ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Attempt to delete a segment which is not in a buffer"))))

(defmethod remove-segment ((segment segment))
  (with-slots (buffer) segment
    (assert buffer () 'segment-not-in-buffer)
    (with-slots (segments) buffer
      (setf segments (delete segment segments :test #'eq))
      ;; make sure there is one segment left
      (unless segments
        (add-segment (make-instance 'segment :staff (car (staves buffer))) buffer 0)))
    (setf buffer nil)))

(define-condition staff-already-in-buffer (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "A staff with that name is already in the buffer"))))

(define-condition staff-not-in-buffer (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "No staff with that name in the buffer"))))

(defmethod find-staff (staff-name (buffer buffer) &optional (errorp t))
  (let ((staff (find staff-name (staves buffer) :key #'name :test #'string=)))
    (when errorp (assert staff () 'staff-not-in-buffer))
    staff))

(defun add-staff-before (newstaff staff staves)
  (assert (not (null staves)))
  (if (eq staff (car staves))
      (cons newstaff staves)
      (cons (car staves) (add-staff-before newstaff staff (cdr staves)))))

(defmethod add-staff-before-staff (staff newstaff (buffer buffer))
  (setf (staves buffer)
        (add-staff-before newstaff staff (staves buffer))))
  
(defun add-staff-after (newstaff staff staves)
  (assert (not (null staves)))  
  (if (eq staff (car staves))
      (push newstaff (cdr staves))
      (add-staff-after newstaff staff (cdr staves)))
  staves)

(defmethod add-staff-after-staff (staff newstaff (buffer buffer))
  (setf (staves buffer)
        (add-staff-after newstaff staff (staves buffer))))
  
(defmethod rename-staff (staff-name (staff staff) (buffer buffer))
  (assert (not (find-staff staff-name buffer nil)) () 'staff-already-in-buffer)
  (setf (name staff) staff-name))

(define-condition staff-in-use (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Staff in use"))))

(defmethod remove-staff-from-buffer (staff (buffer buffer))
  (assert (notany (lambda (segment)
                    (some (lambda (layer)
                            (member staff (staves layer)))
                          (layers segment)))
                  (segments buffer))
          () 'staff-in-use)
  (setf (staves buffer)
        (delete staff (staves buffer) :test #'eq)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Reading and writing files

(define-condition file-does-not-exist (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "File does not exist"))))

(define-condition unknown-file-version (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Unknown file version"))))

(defparameter *readtables*
  `(("G#V3" . ,*gsharp-readtable-v3*)
    ("G#V4" . ,*gsharp-readtable-v4*)))

(defun read-everything (filename)
  (assert (probe-file filename) () 'file-does-not-exist)
  (with-open-file (stream filename :direction :input)
    (let* ((version (read-line stream))
           (readtable (cdr (assoc version *readtables* :test #'string=))))
      (assert readtable () 'unknown-file-version)
      (let ((*read-eval* nil)
            (*readtable* readtable))
        (read stream)))))

(defun read-buffer-from-stream (stream)
  (let* ((version (read-line stream))
         (readtable (cdr (assoc version *readtables* :test #'string=))))
    (assert readtable () 'unknown-file-version)
    (let ((*read-eval* nil)
          (*readtable* readtable))
      (read stream))))

(defmethod frame-save-buffer-to-stream (application-frame (buffer buffer) stream)
  (let ((*print-circle* t)
        (*package* (find-package :keyword)))
    ;;    (format stream "G#V3~%")
    (format stream "G#V4~%")
    (pprint buffer stream)
    (terpri stream)
    (finish-output stream)))
