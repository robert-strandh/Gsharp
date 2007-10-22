(in-package :gsharp-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; staff

(defclass lyrics-staff (staff) ())

(defun make-lyrics-staff (&rest args &key name)
  (declare (ignore name))
  (apply #'make-instance 'lyrics-staff args))

(defun read-lyrics-staff-v3 (stream char n)
  (declare (ignore char n))
  (apply #'make-instance 'lyrics-staff (read-delimited-list #\] stream t)))

(set-dispatch-macro-character #\[ #\L
  #'read-lyrics-staff-v3
  *gsharp-readtable-v3*)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Lyrics element

(defclass lyrics-element (rhythmic-element)
  ((staff :initarg :staff :reader staff)
   (text :initarg :text
         :initform (make-array 5 :adjustable t :element-type 'fixnum :fill-pointer 0)
         :reader text)
   (%tie-right :initform nil :initarg :tie-right :accessor tie-right)
   (%tie-left :initform nil :initarg :tie-left :accessor tie-left)))

(defmethod initialize-instance :after ((elem lyrics-element) &rest args)
  (declare (ignore args))
  (with-slots (text) elem
     (unless (adjustable-array-p text)
       (let ((length (length text)))
         (setf text (make-array length :adjustable t :element-type 'fixnum
                                :fill-pointer length :initial-contents text))))))

(defun make-lyrics-element (staff &rest args
                            &key (notehead :filled) (lbeams 0) (rbeams 0)
                            (dots 0) (xoffset 0))
  (declare (type staff staff)
           (type (member :long :breve :whole :half :filled) notehead)
           (type (integer 0 5) lbeams)
           (type (integer 0 5) rbeams)
           (type (integer 0 3) dots)
           (type number xoffset)
           (ignore notehead lbeams rbeams dots xoffset))
  (apply #'make-instance 'lyrics-element
         :staff staff args))

(defmethod slots-to-be-saved append ((elem lyrics-element))
  '(staff text))

(defun read-lyrics-element-v3 (stream char n)
  (declare (ignore char n))
  (apply #'make-instance 'lyrics-element (read-delimited-list #\] stream t)))

(set-dispatch-macro-character #\[ #\A
  #'read-lyrics-element-v3
  *gsharp-readtable-v3*)

(defmethod append-char ((elem lyrics-element) char)
  (vector-push-extend char (text elem)))

(defmethod erase-char ((elem lyrics-element))
  (unless (zerop (fill-pointer (text elem)))
    (decf (fill-pointer (text elem)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Lyrics bar

(defclass lyrics-bar (bar) ())

(defun make-lyrics-bar (&rest args &key elements)
  (declare (type list elements)
           (ignore elements))
  (apply #'make-instance 'lyrics-bar args))

(defmethod make-bar-for-staff ((staff lyrics-staff) &rest args &key elements)
  (declare (ignore elements))
  (apply #'make-instance 'lyrics-bar args))

(defun read-lyrics-bar-v3 (stream char n)
  (declare (ignore char n))
  (apply #'make-instance 'lyrics-bar (read-delimited-list #\] stream t)))

(set-dispatch-macro-character #\[ #\C
  #'read-lyrics-bar-v3
  *gsharp-readtable-v3*)

(defmethod remove-bar ((bar lyrics-bar))
  (with-slots (slice) bar
    (assert slice () 'bar-not-in-slice)
    (with-slots (bars) slice
      (setf bars (delete bar bars :test #'eq))
      (unless bars
        ;; make sure there is one bar left
        (add-bar (make-lyrics-bar) slice 0)))
    (setf slice nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Lyrics layer

(defclass lyrics-layer (layer) ())

(defun read-lyrics-layer-v3 (stream char n)
  (declare (ignore char n))
  (apply #'make-instance 'lyrics-layer (read-delimited-list #\] stream t)))

(set-dispatch-macro-character #\[ #\M
  #'read-lyrics-layer-v3
  *gsharp-readtable-v3*)

(defmethod make-layer-for-staff ((staff lyrics-staff) &rest args &key staves head body tail &allow-other-keys)
  (declare (ignore staves head body tail))
  (apply #'make-instance 'lyrics-layer args))

