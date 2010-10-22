(in-package :gsharp-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Clef

;;; The line number on which the clef is located on the staff. 
;;; The bottom line of the staff is number 1. 
(defgeneric lineno (clef))

;;; for key signature drawing calcluations.  FIXME: in fact the layout
;;; of key signatures isn't the same across all clefs.
(defgeneric b-position (clef))
(defgeneric f-position (clef))

;;; the note number of the bottom line of this clef.
(defgeneric bottom-line (clef))

(defclass clef (staffwise-element gsharp-object name-mixin)
  ((lineno :reader lineno :initarg :lineno
           :type (or (integer 0 8) null))))

(defun make-clef (name &key lineno)
  (declare (type (member :treble :treble8 :bass :c :percussion) name)
           (type (or (integer 0 8) null) lineno))
  (when (null lineno)
    (setf lineno
          (ecase name
            ((:treble :treble8) 2)
            (:bass 6)
            (:c 4)
            (:percussion 3))))
  (make-instance 'clef :name name :lineno lineno))

(defmethod slots-to-be-saved append ((c clef))
  '(lineno))

(defun read-clef-v3 (stream char n)
  (declare (ignore char n))
  (apply #'make-instance 'clef (read-delimited-list #\] stream t)))

(set-dispatch-macro-character #\[ #\K
  #'read-clef-v3
  *gsharp-readtable-v3*)

;;; given a clef, return the staff step of the B that should have
;;; the first flat sign in key signatures with flats
(defmethod b-position ((clef clef))
  (ecase (name clef)
    (:bass (- (lineno clef) 4))
    ((:treble :treble8) (+ (lineno clef) 2))
    (:c (- (lineno clef) 1))))


;;; given a clef, return the staff step of the F that should have
;;; the first sharp sign in key signatures with sharps
(defmethod f-position ((clef clef))
  (ecase (name clef)
    (:bass (lineno clef))
    ((:treble :treble8) (+ (lineno clef) 6))
    (:c (+ (lineno clef) 3))))

(defmethod bottom-line ((clef clef))
  (- (ecase (name clef)
       (:treble 32)
       (:bass 24)
       (:c 28)
       (:treble8 25))
     (lineno clef)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Fiveline staff

(defgeneric clef (fiveline-staff))

(defclass fiveline-staff (staff)
  ((clef :accessor clef :initarg :clef :initform (make-clef :treble))
   (%keysig :accessor keysig :initarg :keysig
            :initform (make-array 7 :initial-element :natural))
   (staffwise-elements :accessor staffwise-elements :initform nil)))
       
(defgeneric key-signatures (staff)
  (:method ((s fiveline-staff))
    (remove-if #'(lambda (x) (not (typep x 'key-signature)))
	       (staffwise-elements s))))
(defgeneric time-signatures (staff)
  (:method ((s fiveline-staff))
    (remove-if #'(lambda (x) (not (typep x 'time-signature)))
	       (staffwise-elements s))))
	   
(defmethod initialize-instance :after ((obj fiveline-staff) &rest args)
  (declare (ignore args))
  (with-slots (%keysig) obj
    (when (vectorp %keysig)
      (setf %keysig
            (make-instance 'key-signature :staff obj :alterations %keysig)))))

(defun make-fiveline-staff (&rest args &key name clef keysig)
  (declare (ignore name clef keysig))
  (apply #'make-instance 'fiveline-staff args))

(defmethod slots-to-be-saved append ((s fiveline-staff))
  '(clef %keysig))

(defun read-fiveline-staff-v3 (stream char n)
  (declare (ignore char n))
  (apply #'make-instance 'fiveline-staff (read-delimited-list #\] stream t)))

(set-dispatch-macro-character #\[ #\=
  #'read-fiveline-staff-v3
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

;;; The pitch is a number from 0 to 128
;;; 
;;; The staff is a staff object. 
;;; 
;;; Head can be :long, :breve, :whole, :half, :filled, or nil.  A
;;; value of nil means that the notehead is determined by that of the
;;; cluster to which the note belongs.
;;; 
;;; Accidentals can be :natural :flat :double-flat :sharp or :double-sharp.
;;; The default is :natural.  Whether a note is actually displayed
;;; preceded by one of the corresponding signs is a matter of context and
;;; display style. 
;;; 
;;; The number of dots can be an integer or nil, meaning that the number
;;; of dots is taken from the cluster.  The default value is nil.
;;; 
;;; The actual duration of the note is computed from the note head, the
;;; number of beams of the cluster to which the note belongs, and the
;;; number of dots in the usual way. 

(defclass note (gsharp-object)
  ((cluster :initform nil :initarg :cluster :accessor cluster)
   (pitch :initarg :pitch :reader pitch :type (integer 0 127))
   (staff :initarg :staff :reader staff :type staff)
   (head :initform nil :initarg :head :reader head
         :type (or (member :long :breve :whole :half :filled) null))
   (accidentals :initform :natural :initarg :accidentals :reader accidentals
		;; FIXME: we want :TYPE ACCIDENTAL here but need to
		;; sort out order of definition for that to be useful.
		#+nil #+nil 
                :type (member :natural :flat :double-flat :sharp :double-sharp))
   (dots :initform nil :initarg :dots :reader dots
         :type (or (integer 0 3) null))
   (%tie-right :initform nil :initarg :tie-right :accessor tie-right)
   (%tie-left :initform nil :initarg :tie-left :accessor tie-left)))

(defun make-note (pitch staff &rest args &key head (accidentals :natural) dots)
  (declare (type (integer 0 127) pitch)
           (type staff staff)
           (type (or (member :long :breve :whole :half :filled) null) head)
	   ;; FIXME: :TYPE ACCIDENTAL
	   #+nil #+nil
           (type (member :natural :flat :double-flat :sharp :double-sharp)
                 accidentals)
           (type (or (integer 0 3) null) dots)
           (ignore head accidentals dots))
  (apply #'make-instance 'note :pitch pitch :staff staff args))

(defmethod slots-to-be-saved append ((n note))
  '(pitch staff head accidentals dots %tie-right %tie-left))

(defun read-note-v3 (stream char n)
  (declare (ignore char n))
  (apply #'make-instance 'note (read-delimited-list #\] stream t)))

(set-dispatch-macro-character #\[ #\N
  #'read-note-v3
  *gsharp-readtable-v3*)

;;; Return true if note1 is considered less than note2.
(defun note-less (note1 note2)
  (< (pitch note1) (pitch note2)))

;;; Return true if note1 is considered equal to note2.
(defun note-equal (note1 note2)
  (= (pitch note1) (pitch note2)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Tuning (support for microtonal and historical tunings/temperaments)

;;; FIXME: add name-mixin also?
(defclass tuning (gsharp-object)
  ((master-pitch-note :initform (make-instance 'note :pitch 33 ; a above middle c
                                                     :staff (make-instance 'staff))
                      :initarg :master-pitch-note
                      :type note
                      :accessor master-pitch-note)
   (master-pitch-freq :initform 440
                      :initarg :master-pitch-freq
                      :accessor master-pitch-freq)))

(defmethod slots-to-be-saved append ((tuning tuning))
  '(master-pitch-note master-pitch-freq))

;;; Returns how a note should be tuned in a given tuning
;;; in terms of a cent value.
(defgeneric note-cents (note tuning))

;;; 12-edo is provided for efficiency only. It is a 
;;; special case of a regular temperament. Perhaps it
;;; should be removed?
(defclass 12-edo (tuning)
  ())

(defmethod slots-to-be-saved append ((tuning 12-edo))
  '())

(defmethod note-cents ((note note) (tuning 12-edo))
  (multiple-value-bind (octave pitch) (floor (pitch note) 7)
    (+ (* 1200 (1+ octave))
       (ecase pitch (0 0) (1 200) (2 400) (3 500) (4 700) (5 900) (6 1100))
       (ecase (accidentals note)
         (:double-flat -200)
	 (:sesquiflat -150)
         (:flat -100)
	 (:semiflat -50)
         (:natural 0)
	 (:semisharp 50)
         (:sharp 100)
	 (:sesquisharp 150)
         (:double-sharp 200)))))

;;; regular temperaments are temperaments that
;;; retain their interval sizes regardless of modulation, as opposed to
;;; irregular temperaments.
(defclass regular-temperament (tuning)
  ((octave-cents :initform 1200 :initarg :octave-cents :accessor octave-cents)
   (fifth-cents :initform 700 :initarg :fifth-cents :accessor fifth-cents)
   (quartertone-cents :initform 50 :initarg :quartertone-cents :accessor quartertone-cents)
   ;; TODO: Add cent sizes of various microtonal accidentals, perhaps in an alist?
   ))

(defmethod slots-to-be-saved append ((tuning regular-temperament))
  '(octave-cents fifth-cents))

(defmethod note-cents ((note note) (tuning regular-temperament))
  (let ((octaves 1)
        (fifths 0)
        (sharps 0) ;; short for 7 fifths up and 4 octaves down
        (quartertones 0))
    (incf octaves (floor (pitch note) 7))
    (ecase (mod (pitch note) 7)
      (0 (progn))
      (1 (progn (incf octaves -1) (incf fifths 2)))
      (2 (progn (incf octaves -2) (incf fifths 4)))
      (3 (progn (incf octaves 1) (incf fifths -1)))
      (4 (progn (incf fifths 1)))
      (5 (progn (incf octaves -1) (incf fifths 3)))
      (6 (progn (incf octaves -2) (incf fifths 5))))
    (ecase (accidentals note)
      (:double-flat (incf sharps -2))
      (:sesquiflat (incf sharps -1) (incf quartertones -1))
      (:flat (incf sharps -1))
      (:semiflat (incf quartertones -1))
      (:natural)
      (:semisharp (incf quartertones 1))
      (:sharp (incf sharps 1))
      (:sesquisharp (incf sharps 1) (incf quartertones 1))
      (:double-sharp (incf sharps 2)))
    (incf octaves (* -4 sharps))
    (incf fifths (* 7 sharps))
    (+ (* octaves (octave-cents tuning))
       (* fifths (fifth-cents tuning))
       (* quartertones (quartertone-cents tuning)))))
 
;;; TODO: (defclass irregular-temperament ...)
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Melody element

(defclass melody-element (rhythmic-element) ())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Key signature

(defgeneric alterations (key-signature)
  (:documentation "return the alterations in the form of a 
7-element array where each element is either :natural,
:sharp, or :flat according to how each staff position 
should be altered"))

(defgeneric more-sharps (key-signature &optional n)
  (:documentation "make the key signature N alterations
sharper by removing some flats and/or adding some sharps"))

(defgeneric more-flats (key-signature &optional n)
  (:documentation "make the key signature N alterations
flatter by removing some sharps and/or adding some flats"))

(defclass staffwise-element (element)
  ((%staff :initarg :staff :reader staff)))
(defmethod slots-to-be-saved append ((s-e staffwise-element))
  '(%staff))

(defclass key-signature (staffwise-element)
  ((%alterations :initform (make-array 7 :initial-element :natural) 
                 :initarg :alterations :reader alterations)))

(defun make-key-signature (staff &rest args &key alterations)
  (declare (type (or null (simple-vector 7)) alterations)
           (ignore alterations))
  (apply #'make-instance 'key-signature :staff staff args))

(defmethod slots-to-be-saved append ((k key-signature))
  '(%alterations))

(defmethod more-sharps ((sig key-signature) &optional (n 1))
  (let ((alt (alterations sig)))
    (loop repeat n
          do (cond ((eq (aref alt 3) :flat) (setf (aref alt 3) :natural))
                   ((eq (aref alt 0) :flat) (setf (aref alt 0) :natural))
                   ((eq (aref alt 4) :flat) (setf (aref alt 4) :natural))
                   ((eq (aref alt 1) :flat) (setf (aref alt 1) :natural))
                   ((eq (aref alt 5) :flat) (setf (aref alt 5) :natural))
                   ((eq (aref alt 2) :flat) (setf (aref alt 2) :natural))
                   ((eq (aref alt 6) :flat) (setf (aref alt 6) :natural))
                   ((eq (aref alt 3) :natural) (setf (aref alt 3) :sharp))
                   ((eq (aref alt 0) :natural) (setf (aref alt 0) :sharp))
                   ((eq (aref alt 4) :natural) (setf (aref alt 4) :sharp))
                   ((eq (aref alt 1) :natural) (setf (aref alt 1) :sharp))
                   ((eq (aref alt 5) :natural) (setf (aref alt 5) :sharp))
                   ((eq (aref alt 2) :natural) (setf (aref alt 2) :sharp))
                   ((eq (aref alt 6) :natural) (setf (aref alt 6) :sharp))))))

(defmethod more-flats ((sig key-signature) &optional (n 1))
  (let ((alt (alterations sig)))
    (loop repeat n
          do (cond ((eq (aref alt 6) :sharp) (setf (aref alt 6) :natural))
                   ((eq (aref alt 2) :sharp) (setf (aref alt 2) :natural))
                   ((eq (aref alt 5) :sharp) (setf (aref alt 5) :natural))
                   ((eq (aref alt 1) :sharp) (setf (aref alt 1) :natural))
                   ((eq (aref alt 4) :sharp) (setf (aref alt 4) :natural))
                   ((eq (aref alt 0) :sharp) (setf (aref alt 0) :natural))
                   ((eq (aref alt 3) :sharp) (setf (aref alt 3) :natural))
                   ((eq (aref alt 6) :natural) (setf (aref alt 6) :flat))
                   ((eq (aref alt 2) :natural) (setf (aref alt 2) :flat))
                   ((eq (aref alt 5) :natural) (setf (aref alt 5) :flat))
                   ((eq (aref alt 1) :natural) (setf (aref alt 1) :flat))
                   ((eq (aref alt 4) :natural) (setf (aref alt 4) :flat))
                   ((eq (aref alt 0) :natural) (setf (aref alt 0) :flat))
                   ((eq (aref alt 3) :natural) (setf (aref alt 3) :flat))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Time signature
;; * no make function (no type checking)
;; * slots-to-be-saved only 'cos it's there
;; * What accessors do we need (if any)?
;; * Should I copy the (keysig) functionality from gui.lisp?

(defclass time-signature (staffwise-element)
  ((%components :initarg :components :reader time-signature-components
                :initform nil)))
(defmethod slots-to-be-saved append ((t-s time-signature))
  '(%components))
                                                                              
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

(defclass cluster (melody-element)
  ((notes :initform '() :initarg :notes :accessor notes)
   (stem-direction :initform :auto :initarg :stem-direction :accessor stem-direction)))

(defmethod initialize-instance :after ((c cluster) &rest args)
  (declare (ignore args))
  (loop for note in (notes c)
        do (setf (cluster note) c)))

(defun make-cluster (&rest args
                     &key (notehead :filled) (lbeams 0) (rbeams 0) (dots 0)
                     (xoffset 0) notes (stem-direction :auto))
  (declare (type (member :long :breve :whole :half :filled) notehead)
           (type (integer 0 5) lbeams)
           (type (integer 0 5) rbeams)
           (type (integer 0 3) dots)
           (type number xoffset)
           (type list notes)
           (type (member :up :down :auto) stem-direction)
           (ignore notehead lbeams rbeams dots xoffset notes stem-direction))
  (apply #'make-instance 'cluster args))

(defmethod slots-to-be-saved append ((c cluster))
  '(stem-direction notes))

(defun read-cluster-v3 (stream char n)
  (declare (ignore char n))
  (apply #'make-instance 'cluster (read-delimited-list #\] stream t)))

(set-dispatch-macro-character #\[ #\%
  #'read-cluster-v3
  *gsharp-readtable-v3*)

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

(defun lower-bound (bound list &key (test #'<))
  "Return the `largest' element in the sorted list LIST such that
\(TEST element BOUND) is true."
  (let ((last nil))
    (dolist (item list)
      (unless (funcall test item bound)
        (return-from lower-bound last))
      (setf last item))
    last))

(defmethod cluster-lower-bound ((cluster cluster) (bound note))
  (with-slots (notes) cluster
    (lower-bound bound notes :test #'note-less)))

(defmethod cluster-upper-bound ((cluster cluster) (bound note))
  (with-slots (notes) cluster
    (lower-bound bound (reverse notes) :test (complement #'note-less))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Rest

(defclass rest (melody-element)
  ((staff :initarg :staff :reader staff)
   (staff-pos :initarg :staff-pos :initform 4 :reader staff-pos)))

(defun make-rest (staff &rest args
                  &key (staff-pos 4) (notehead :filled) (lbeams 0) (rbeams 0)
                  (dots 0) (xoffset 0))
  (declare (type staff staff)
           (type integer staff-pos)
           (type (member :long :breve :whole :half :filled) notehead)
           (type (integer 0 5) lbeams)
           (type (integer 0 5) rbeams)
           (type (integer 0 3) dots)
           (type number xoffset)
           (ignore staff-pos notehead lbeams rbeams dots xoffset))
  (apply #'make-instance 'rest
         :staff staff args))

(defmethod slots-to-be-saved append ((s rest))
  '(staff staff-pos))

(defun read-rest-v3 (stream char n)
  (declare (ignore char n))
  (apply #'make-instance 'rest (read-delimited-list #\] stream t)))

(set-dispatch-macro-character #\[ #\-
  #'read-rest-v3
  *gsharp-readtable-v3*)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Melody bar

(defclass melody-bar (bar) ())

(defun make-melody-bar (&rest args &key elements)
  (declare (type list elements)
           (ignore elements))
  (apply #'make-instance 'melody-bar args))

(defmethod make-bar-for-staff ((staff fiveline-staff) &rest args &key elements)
  (declare (ignore elements))
  (apply #'make-instance 'melody-bar args))

(defun read-melody-bar-v3 (stream char n)
  (declare (ignore char n))
  (apply #'make-instance 'melody-bar (read-delimited-list #\] stream t)))

(set-dispatch-macro-character #\[ #\|
  #'read-melody-bar-v3
  *gsharp-readtable-v3*)

(defmethod remove-bar ((bar melody-bar))
  (with-slots (slice) bar
    (assert slice () 'bar-not-in-slice)
    (with-slots (bars) slice
      (setf bars (delete bar bars :test #'eq))
      (unless bars
        ;; make sure there is one bar left
        (add-bar (make-melody-bar) slice 0)))
    (setf slice nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Melody layer

(defclass melody-layer (layer) ())

(defun read-melody-layer-v3 (stream char n)
  (declare (ignore char n))
  (apply #'make-instance 'melody-layer (read-delimited-list #\] stream t)))

(set-dispatch-macro-character #\[ #\_
  #'read-melody-layer-v3
  *gsharp-readtable-v3*)

(defmethod make-layer-for-staff ((staff fiveline-staff) &rest args &key staves head body tail &allow-other-keys)
  (declare (ignore staves head body tail))
  (apply #'make-instance 'melody-layer args))

(defgeneric clefs (staff)
  (:method ((s t)) nil)
  (:method ((s fiveline-staff))
    (remove-if #'(lambda (x) (not (typep x 'clef)))
               (staffwise-elements s))))
