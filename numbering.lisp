(in-package :gsharp-numbering)

(defmacro defnclass (name base slots)
  `(progn 
     (define-added-mixin ,name ,() ,base
       ((number :accessor number)
	,@slots))))

(defun number-elements (list)
  (loop for elem in list
	and i from 0
	do (setf (number elem) i)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Element

(defnclass nelement element
  ())

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Bar

(defnclass nbar bar
  ())

(defmethod add-element :after ((element nelement) (bar bar) position)
  (declare (ignore position))
  (number-elements (elements bar)))

(defmethod remove-element :around ((element nelement))
  (let ((bar (bar element)))
    (call-next-method)
    (number-elements (elements bar))))

(defmethod number-all ((bar bar))
  (number-elements (elements bar)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Slice

(defnclass nslice slice
  ())

(defmethod add-bar :after ((bar nbar) (slice slice) position)
  (declare (ignore position))
  (number-elements (bars slice)))

(defmethod remove-bar :around ((bar nbar))
  (let ((slice (slice bar)))
    (call-next-method)
    (number-elements (bars slice))))

(defmethod number-all ((slice slice))
  (number-elements (bars slice))
  (mapc #'number-all (bars slice)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Layer

(defnclass nlayer layer
  ())

(defmethod initialize-instance :after ((layer layer) &rest args)
  (declare (ignore args))
  (setf (number (head layer)) 0
	(number (body layer)) 1
	(number (tail layer)) 2))

(defmethod number-all ((layer layer))
  (number-all (head layer))
  (number-all (body layer))
  (number-all (tail layer)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Segment

(defnclass nsegment segment
  ())

(defmethod add-layer :after ((layer nlayer) (segment segment))
  (number-elements (layers segment)))

(defmethod remove-layer :around ((layer nlayer))
  (let ((segment (segment layer)))
    (call-next-method)
    (number-elements (layers segment))))

(defmethod number-all ((segment segment))
  (number-elements (layers segment))
  (mapc #'number-all (layers segment)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Buffer

(defmethod add-segment :after ((segment nsegment) (buffer buffer) position)
  (declare (ignore position))
  (number-elements (segments buffer)))

(defmethod remove-segment :around ((segment nsegment))
  (let ((buffer (buffer segment)))
    (call-next-method)
    (number-elements (segments buffer))))

(defmethod number-all ((buffer buffer))
  (number-elements (segments buffer))
  (mapc #'number-all (segments buffer)))
