(in-package :gsharp)

(defclass input-state ()
  ((lbeams :initform 0 :accessor lbeams)
   (rbeams :initform 0 :accessor rbeams)
   (dots :initform 0 :accessor dots)
   (notehead :initform :filled :accessor notehead)
   (stem-direction :initform :auto :accessor stem-direction)
   (last-note :initform 34 :accessor last-note) ; a B in the fourth octave
   (accidentals :initform :natural :accessor accidentals)))

(defun make-input-state ()
  (make-instance 'input-state))
