(in-package :gsharp-buffer)

(defparameter *gsharp-readtable-v2* (copy-readtable))
(defparameter *gsharp-readtable-v3* (copy-readtable))

(make-dispatch-macro-character #\[ nil *gsharp-readtable-v2*)
(make-dispatch-macro-character #\[ nil *gsharp-readtable-v3*)

(defun skip-until-close-bracket (stream)
  (loop until (eql (read-char stream) #\])))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Clef

;;; The name of a clef is one of :TREBLE, :BASS, 
;;; :C, and :PERCUSSION
(defgeneric name (clef))

;;; The line number on which the clef is located on the staff. 
;;; The bottom line of the staff is number 1. 
(defgeneric lineno (clef))

(defclass clef ()
  ((name :reader name :initarg :name :initform nil)
   (lineno :reader lineno :initarg :lineno :initform nil)))

(defmethod print-object ((c clef) stream)
  (with-slots (name lineno) c
    (format stream "[K :name ~W :lineno ~W ] " name lineno)))

(defun make-clef (name &optional lineno)
  (declare (type (member :treble :bass :c :percussion) name)
	   (type (or (integer 2 6) null) lineno))
  (make-instance 'clef
		 :name name
		 :lineno (or lineno
			     (ecase name
			       (:treble 2)
			       (:bass 6)
			       (:c 4)
			       (:percussion 3)))))

(defun read-clef-v2 (stream char n)
  (declare (ignore char n))
  (let ((name (read stream nil nil t))
	(lineno (read stream nil nil t)))
    (skip-until-close-bracket stream)
    (make-instance 'clef :name name :lineno lineno)))

(set-dispatch-macro-character #\[ #\K
  #'read-clef-v2
  *gsharp-readtable-v2*)

(defun read-clef-v3 (stream char n)
  (declare (ignore char n))
  (apply #'make-instance 'clef (read-delimited-list #\] stream t)))

(set-dispatch-macro-character #\[ #\K
  #'read-clef-v3
  *gsharp-readtable-v3*)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Staff

(defgeneric clef (staff))

(defclass staff ()
  ((name :accessor name :initarg :name :initform "default")
   (clef :accessor clef :initarg :clef :initform nil)
   (keysig :accessor keysig :initarg :keysig
	   :initform (make-array 7 :initial-element :natural))))
	   

(defmethod print-object ((s staff) stream)
  (with-slots (name clef keysig) s
    (format stream "[= :name ~W :clef ~W :keysig ~W ] " name clef keysig)))

(defun make-staff (&optional (clef (make-clef :treble)))
  (make-instance 'staff :clef clef))

(defun read-staff-v2 (stream char n)
  (declare (ignore char n))
  (let ((clef (read stream nil nil t))
	(keysig (read stream nil nil t)))
    (skip-until-close-bracket stream)
    (make-instance 'staff :clef clef :keysig keysig)))

(set-dispatch-macro-character #\[ #\=
  #'read-staff-v2
  *gsharp-readtable-v2*)

(defun read-staff-v3 (stream char n)
  (declare (ignore char n))
  (apply #'make-instance 'staff (read-delimited-list #\] stream t)))

(set-dispatch-macro-character #\[ #\=
  #'read-staff-v3
  *gsharp-readtable-v3*)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Note

;;; Notes are immutable objets.  If you want to alter (say) the staff
;;; or the pitch of a note, you have to delete it and add a new note
;;; with the right characteristics.

;;; Return the pitch of the note. 
(defgeneric pitch (note))

;;; Return the accidentals of the note.  The value returned is one of
;;; :natural :flat :double-flat :sharp or :double-sharp.
(defgeneric accidentals (note))

;;; Return a non-negative integer indicating the number of dots of the
;;; note.  The value nil is returned whenever the note takes its
;;; number of dots from the cluster to which it belongs.
(defgeneric dots (note))

;;; Returns the cluster to which the note belongs, or nil if the note
;;; currently does not belong to any cluster. 
(defgeneric cluster (note))

(defclass note ()
  ((cluster :initform nil :initarg :cluster :accessor cluster)
   (pitch :initarg :pitch :reader pitch)
   (staff :initarg :staff :reader staff)
   (head :initarg :head :reader head)
   (accidentals :initarg :accidentals :reader accidentals)
   (dots :initarg :dots :reader dots)))

(defmethod print-object ((n note) stream)
  (with-slots (pitch staff head accidentals dots) n
    (format stream
	    "[N :pitch ~W :staff ~W :head ~W :accidentals ~W :dots ~W ] "
	    pitch staff head accidentals dots)))

;;; Make a note with the pitch and staff given.  
;;; 
;;; The pitch is a number from 0 to 128
;;; 
;;; The staff is a staff object. 
;;; 
;;; Head can be :whole, :half, :filled, or nil.  A value of nil means
;;; that the note head is determined by that of the cluster to which the
;;; note belongs. 
;;; 
;;; Accidentals can be :natural :flat :double-flat :sharp or :double-sharp.
;;; The default is :natural.  Whether a note is actually displayed
;;; preceded by one of the corresponding signs is a matter of context and
;;; display style. 
;;; 
;;; The number of dots can be an integer or nil, meaning that the number
;;; of dots is taken from the cluster. 
;;; 
;;; The actual duration of the note is computed from the note head, the
;;; number of beams of the cluster to which the note belongs, and the
;;; number of dots in the usual way. 
(defun make-note (pitch &optional staff
		  (head nil) (accidentals :natural) (dots nil))
  (declare (type (integer 0 128) pitch)
	   (type (or staff null) staff)
	   (type (or (member :whole :half :filled) null) head)
	   (type (member :natural :flat :double-flat :sharp :double-sharp) accidentals)
	   (type (or integer null) dots))
    (make-instance 'note
      :pitch pitch :staff staff
      :head head :accidentals accidentals :dots dots))
		 
(defun read-note-v2 (stream char n)
  (declare (ignore char n))
  (apply #'make-instance 'note (read-delimited-list #\] stream t)))

(set-dispatch-macro-character #\[ #\N
  #'read-note-v2
  *gsharp-readtable-v2*)

(set-dispatch-macro-character #\[ #\N
  #'read-note-v2
  *gsharp-readtable-v3*)

;;; Return true if note1 is considered less than note2.
(defun note-less (note1 note2)
  (< (pitch note1) (pitch note2)))

;;; Return true if note1 is considered equal to note2.
(defun note-equal (note1 note2)
  (= (pitch note1) (pitch note2)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Element

;;; Return the bar to which the element belongs, or nil of the element
;;; currently does not belong to any bar. 
(defgeneric bar (element))

;;; Return the notehead of the element.  With setf, set the notehead
;;; of the element. 
(defgeneric notehead (element))
(defgeneric (setf notehead) (notehead element))

;;; Return the number of right beams of the element.  With setf, set
;;; the number of right beams of the element.
(defgeneric rbeams (element))
(defgeneric (setf rbeams) (rbeams element))

;;; Return the number of left beams of the element.  With setf, set
;;; the number of left beams of the element.
(defgeneric lbeams (element))
(defgeneric (setf lbeams) (lbeams element))

;;; Return the number of dots of the element.  With setf, set the
;;; number of dots of the element. 
(defgeneric dots (element))
(defgeneric (setf dots) (dots element))

(defclass element ()
  ((bar :initform nil :initarg :bar :reader bar)
   (notehead :initarg :notehead :accessor notehead)
   (rbeams :initarg :rbeams :accessor rbeams)
   (lbeams :initarg :lbeams :accessor lbeams)
   (dots :initarg :dots :accessor dots)
   (xoffset :initform 0 :initarg :xoffset :accessor xoffset)))
   
(defmethod notehead-duration ((element element))
  (ecase (notehead element)
    (:whole 1)
    (:half 1/2)
    (:filled (/ (expt 2 (+ 2 (max (rbeams element)
				  (lbeams element))))))))

(defmethod element-duration ((element element))
  (let ((duration (notehead-duration element)))
    (do ((dot-duration (/ duration 2) (/ dot-duration 2))
	 (nb-dots (dots element) (1- nb-dots)))
	((zerop nb-dots))
      (incf duration dot-duration))
    duration))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Cluster

;;; Return a list of the notes of the cluster
(defgeneric notes (cluster))

;;; Add a note to the cluster.  It is an error if there is already a
;;; note in the cluster with the same staff and the same pitch.
(defgeneric add-note (cluster note))

;;; Find a note in a cluster.  The comparison is made using only the 
;;; pitch of the supplied note.  If the note does not exist nil is returned.
(defgeneric find-note (cluster note))

;;; Delete a note from the cluster to which it belongs.  It is an
;;; error to call this function if the note currently does not belong
;;; to any cluster. 
(defgeneric remove-note (note))

(defclass cluster (element)
  ((notes :initform '() :initarg :notes :accessor notes)
   (stem-direction :initarg :stem-direction :accessor stem-direction)
   (stem-length :initform nil :initarg :stem-length :accessor stem-length)))

(defmethod print-object ((c cluster) stream)
  (with-slots (notehead rbeams lbeams dots xoffset stem-direction notes) c
    (format stream
	    "[% :notehead ~W :rbeams ~W :lbeams ~W :dots ~W :xoffset ~W :stem-direction ~W :notes ~W ] "
	    notehead rbeams lbeams dots xoffset stem-direction notes)))

(defun make-cluster (rbeams lbeams dots notehead stem-direction)
  (make-instance 'cluster
		 :rbeams rbeams :lbeams lbeams :dots dots
		 :notehead notehead :stem-direction stem-direction))

(defun read-cluster-v2 (stream char n)
  (declare (ignore char n))
  (let ((cluster (apply #'make-instance 'cluster (read-delimited-list #\] stream t))))
    (loop for note in (notes cluster) do
	  (setf (slot-value note 'cluster) cluster))
    cluster))

(set-dispatch-macro-character #\[ #\%
  #'read-cluster-v2
  *gsharp-readtable-v2*)

(set-dispatch-macro-character #\[ #\%
  #'read-cluster-v2
  *gsharp-readtable-v3*)

(define-condition gsharp-condition (error) ())

(define-condition note-already-in-cluster (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Attempt to add a note already in a cluster"))))

(defmethod add-note ((cluster cluster) (note note))
  (with-slots (notes) cluster
    (assert (not (find note notes :test #'note-equal))
	    ()
	    'note-already-in-cluster)
    (setf notes (merge 'list notes (list note) #'note-less)
	  (cluster note) cluster)))

(defmethod find-note ((cluster cluster) (note note))
  (with-slots (notes) cluster
    (car (member (pitch note) notes :key #'pitch))))

(define-condition note-not-in-cluster (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Attempt to delete a note not in a cluster"))))

(defmethod remove-note ((note note))
  (with-slots (cluster) note
    (assert cluster () 'note-not-in-cluster)
    (with-slots (notes) cluster
      (setf notes (delete note notes :test #'eq)))
    (setf cluster nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Rest

(defclass rest (element)
  ((staff :initarg :staff :reader staff)
   (staff-pos :initarg :staff-pos :initform 4 :reader staff-pos)))

(defmethod print-object ((s rest) stream)
  (with-slots (notehead rbeams lbeams dots xoffset staff staff-pos) s
    (format stream
	    "[- :notehead ~W :rbeams ~W :lbeams ~W :dots ~W :xoffset ~W :staff ~W :staff-pos ~W ] "
	    notehead rbeams lbeams dots xoffset staff staff-pos)))

(defun make-rest (rbeams lbeams dots notehead staff)
  (make-instance 'rest
		 :rbeams rbeams :lbeams lbeams :dots dots
		 :notehead notehead :staff staff))

(defun read-rest-v2 (stream char n)
  (declare (ignore char n))
  (let ((notehead (read stream nil nil t))
	(rbeams (read stream nil nil t))
	(lbeams (read stream nil nil t))
	(dots (read stream nil nil t))
	(staff (read stream nil nil t))
	(staff-pos (read stream nil nil t)))
    (skip-until-close-bracket stream)
    (make-instance 'rest
      :rbeams rbeams :lbeams lbeams
      :dots dots :notehead  notehead
      :staff staff :staff-pos staff-pos)))

(set-dispatch-macro-character #\[ #\-
  #'read-rest-v2
  *gsharp-readtable-v2*)

(defun read-rest-v3 (stream char n)
  (declare (ignore char n))
  (apply #'make-instance 'rest (read-delimited-list #\] stream t)))

(set-dispatch-macro-character #\[ #\-
  #'read-rest-v3
  *gsharp-readtable-v3*)

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
(defgeneric remove-element (element))

(defclass bar ()
  ((slice :initform nil :initarg :slice :reader slice)
   (elements :initform '() :initarg :elements :reader elements)))

(defmethod print-object ((b bar) stream)
  (format stream "[| :elements ~W ] " (elements b)))

(defun make-bar ()
  (make-instance 'bar))

(defun read-bar-v2 (stream char n)
  (declare (ignore char n))
  (let* ((elements (read stream nil nil t))
	 (bar (make-instance 'bar :elements elements)))
    (loop for element in elements do
	  (setf (slot-value element 'bar) bar))
    (skip-until-close-bracket stream)
    bar))

(set-dispatch-macro-character #\[ #\|
  #'read-bar-v2
  *gsharp-readtable-v2*)

(defun read-bar-v3 (stream char n)
  (declare (ignore char n))
  (let* ((rest (read-delimited-list #\] stream t))
	 (bar (apply #'make-instance 'bar rest)))
    (loop for element in (elements bar) do
	  (setf (slot-value element 'bar) bar))
    bar))

(set-dispatch-macro-character #\[ #\|
  #'read-bar-v3
  *gsharp-readtable-v3*)

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
  
(define-condition element-not-in-bar (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Attempt to delete an element not in a bar"))))

(defmethod remove-element ((element element))
  (with-slots (bar) element
    (assert bar () 'element-not-in-bar)
    (with-slots (elements) bar
      (setf elements (delete element elements :test #'eq)))
    (setf bar nil)))

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

(defclass slice ()
  ((layer :initform nil :initarg :layer :reader layer)
   (bars :initform '() :initarg :bars :reader bars)))

(defmethod print-object ((s slice) stream)
  (format stream "[/ :bars ~W ] " (bars s)))

(defun make-empty-slice ()
  (make-instance 'slice))

(defun make-initialized-slice ()
  (let ((slice (make-empty-slice)))
    (add-bar (make-bar) slice 0)
    slice))

(defun read-slice-v2 (stream char n)
  (declare (ignore char n))
  (let* ((bars (read stream nil nil t))
	 (slice (make-instance 'slice :bars bars)))
    (loop for bar in bars do
	  (setf (slot-value bar 'slice) slice))
    (skip-until-close-bracket stream)
    slice))

(set-dispatch-macro-character #\[ #\/
  #'read-slice-v2
  *gsharp-readtable-v2*)

(defun read-slice-v3 (stream char n)
  (declare (ignore char n))
  (let* ((rest (read-delimited-list #\] stream t))
	 (slice (apply #'make-instance 'slice rest)))
    (loop for bar in (bars slice) do
	  (setf (slot-value bar 'slice) slice))
    slice))

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

(defmethod remove-bar ((bar bar))
  (with-slots (slice) bar
    (assert slice () 'bar-not-in-slice)
    (with-slots (bars) slice
      (setf bars (delete bar bars :test #'eq))
      (unless bars
	;; make sure there is one bar left
	(add-bar (make-bar) slice 0)))
    (setf slice nil)))

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

(defclass layer ()
  ((segment :initform nil :initarg :segment :reader segment)
   (staves :initform '() :initarg :staves :accessor staves)
   (head :initarg :head :accessor head)
   (body :initarg :body :accessor body)
   (tail :initarg :tail :accessor tail)))

(defmethod print-object ((l layer) stream)
  (with-slots (head body tail staves) l
    (format stream "[_ :staves ~W :head ~W :body ~W :tail ~W ] "
	    staves head body tail)))

(defun make-initialized-layer ()
  (let* ((head (make-initialized-slice))
	 (body (make-initialized-slice))
	 (tail (make-initialized-slice))
	 (result (make-instance 'layer :head head :body body :tail tail)))
    (setf (slot-value head 'layer) result
	  (slot-value body 'layer) result
	  (slot-value tail 'layer) result)
    result))

(defun read-layer-v2 (stream char n)
  (declare (ignore char n))
  (let* ((staves (read stream nil nil t))
	 (head (read stream nil nil t))
	 (body (read stream nil nil t))
	 (tail (read stream nil nil t))
	 (layer (make-instance 'layer :staves staves :head head :body body :tail tail)))
    (setf (slot-value head 'layer) layer
	  (slot-value body 'layer) layer
	  (slot-value tail 'layer) layer)
    (skip-until-close-bracket stream)
    layer))

(set-dispatch-macro-character #\[ #\_
  #'read-layer-v2
  *gsharp-readtable-v2*)

(defun read-layer-v3 (stream char n)
  (declare (ignore char n))
  (let* ((rest (read-delimited-list #\] stream t))
	 (layer (apply #'make-instance 'layer rest)))
    (setf (slot-value (head layer) 'layer) layer
	  (slot-value (body layer) 'layer) layer
	  (slot-value (tail layer) 'layer) layer)
    layer))

(set-dispatch-macro-character #\[ #\_
  #'read-layer-v3
  *gsharp-readtable-v3*)

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
     (format stream "That staff already in the layer"))))

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
  (setf (staves layer)
	(append (staves layer) (list staff))))

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

;;; Add a layer to a segment.  The new layer will be inserted before
;;; the element in the position indicated.  Values of position must be
;;; greater than or equal to zero and less than or equal to the
;;; current number of segments of the layer.
(defgeneric add-layer (layer segment position))

;;; Delete a layer from the segment to which it belongs
(defgeneric remove-layer (layer))

(defclass segment ()
  ((buffer :initform nil :initarg :buffer :reader buffer)
   (layers :initform '() :initarg :layers :reader layers)))

(defmethod print-object ((s segment) stream)
  (format stream "[S :layers ~W ] " (layers s)))

(defun make-empty-segment ()
  (make-instance 'segment))

(defun make-initialized-segment ()
  (let ((segment (make-empty-segment)))
    (add-layer (make-initialized-layer) segment 0)
    segment))

(defun read-segment-v2 (stream char n)
  (declare (ignore char n))
  (let* ((layers (read stream nil nil t))
	 (segment (make-instance 'segment :layers layers)))
    (loop for layer in layers do
	  (setf (slot-value layer 'segment) segment))
    (skip-until-close-bracket stream)
    segment))

(set-dispatch-macro-character #\[ #\S
  #'read-segment-v2
  *gsharp-readtable-v2*)

(defun read-segment-v3 (stream char n)
  (declare (ignore char n))
  (let* ((rest (read-delimited-list #\] stream t))
	 (segment (apply #'make-instance 'segment rest)))
    (loop for layer in (layers segment) do
	  (setf (slot-value layer 'segment) segment))
    segment))

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

(defmethod add-layer ((layer layer) (seg segment) position)
  (with-slots (segment) layer
    (assert (not segment) () 'layer-already-in-a-segment)
    (with-slots (layers) seg
      (setf layers (ninsert-element layer layers position)))
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
	(add-layer (make-initialized-layer) segment 0)))
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

(defclass buffer ()
  ((segments :initform '() :initarg :segments :accessor segments)
   (staves :initform (list (make-staff)) :initarg :staves :accessor staves)
   (min-width :initform *default-min-width* :initarg :min-width :accessor min-width)
   (spacing-style :initform *default-spacing-style* :initarg :spacing-style :accessor spacing-style)
   (right-edge :initform *default-right-edge* :initarg :right-edge :accessor right-edge)
   (left-offset :initform *default-left-offset* :initarg :left-offset :accessor left-offset)
   (left-margin :initform *default-left-margin* :initarg :left-margin :accessor left-margin)))

(defmethod print-object ((b buffer) stream)
  (with-slots (staves segments min-width spacing-style right-edge left-offset left-margin) b
    (format stream "[B :staves ~W :segments ~W :min-width ~W :spacing-style ~W :right-edge ~W :left-offset ~W :left-margin ~W ] "
	    staves segments min-width spacing-style right-edge left-offset left-margin)))

(defun make-empty-buffer ()
  (make-instance 'buffer))

(defun make-initialized-buffer ()
  (let ((buffer (make-empty-buffer)))
    (add-segment (make-initialized-segment) buffer 0)
    buffer))

(defun read-buffer-v2 (stream char n)
  (declare (ignore char n))
  (let* ((staves (read stream nil nil t))
	 (segments (read stream nil nil t))
	 (buffer (make-instance 'buffer :staves staves :segments segments)))
    (loop for segment in segments do
	  (setf (slot-value segment 'buffer) buffer))
    (skip-until-close-bracket stream)
    buffer))

(set-dispatch-macro-character #\[ #\B
  #'read-buffer-v2
  *gsharp-readtable-v2*)

(defun read-buffer-v3 (stream char n)
  (declare (ignore char n))
  (let* ((rest (read-delimited-list #\] stream t))
	 (buffer (apply #'make-instance 'buffer rest)))
    (loop for segment in (segments buffer) do
	  (setf (slot-value segment 'buffer) buffer))
    buffer))

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
	(add-segment (make-initialized-segment) buffer 0)))
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

(defmethod add-new-staff-to-buffer (staff-name (buffer buffer))
  (assert (not (find-staff staff-name buffer nil)) () 'staff-already-in-buffer)
  (setf (staves buffer)
	(append (staves buffer) (list (make-instance 'staff
					:clef (make-clef :treble)
					:name staff-name)))))

(defmethod rename-staff (staff-name (staff staff) (buffer buffer))
  (assert (not (find-staff staff-name buffer nil)) () 'staff-already-in-buffer)
  (setf (name staff) staff-name))

(define-condition staff-in-use (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Staff in use"))))

(defmethod remove-staff-from-buffer (staff-name (buffer buffer))
  (let ((staff (find-staff staff-name buffer)))
    (assert (notany (lambda (segment)
		      (some (lambda (layer)
			      (member staff (staves layer)))
			    (layers segment)))
		    (segments buffer))
	    () 'staff-in-use)
    (setf (staves buffer)
	  (delete staff (staves buffer) :test #'eq))))

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
  `(("G#V2" . ,*gsharp-readtable-v2*)
    ("G#V3" . ,*gsharp-readtable-v3*)))

(defun read-everything (filename)
  (assert (probe-file filename) () 'file-does-not-exist)
  (with-open-file (stream filename :direction :input)
    (let* ((version (read-line stream))
	   (readtable (cdr (assoc version *readtables* :test #'string=))))
      (assert readtable () 'unknown-file-version)
      (let ((*read-eval* nil)
	    (*readtable* readtable))
	(read stream)))))

(defun save-buffer-to-stream (buffer stream)
  (let ((*print-circle* t))
    (format stream "G#V3~%")
    (print buffer stream)
    (terpri stream)
    (finish-output stream)))
