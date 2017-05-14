(cl:in-package #:gsharp-numbering)

(defmethod number ((element element))
  (position element (elements (bar element))))

(defmethod number ((bar bar))
  (position bar (bars (slice bar))))

(defmethod number ((slice slice))
  (let ((layer (layer slice)))
    (cond ((eq slice (head layer)) 0)
	  ((eq slice (body layer)) 1)
	  ((eq slice (tail layer)) 2))))

(defmethod number ((layer layer))
  (position layer (layers (segment layer))))

(defmethod number ((segment segment))
  (position segment (segments (buffer segment))))

