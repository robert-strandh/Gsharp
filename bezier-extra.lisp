(cl:in-package #:mcclim-bezier)

(defmethod print-object ((object bezier-segment) stream)
  (with-slots (p0 p1 p2 p3)
      object
    (print-unreadable-object (object stream)
      (format stream "[~s] [~s] [~s] [~s]" p0 p1 p2 p3))))

(defmethod print-object ((object bezier-curve) stream)
  (print-unreadable-object (object stream)
    (loop for segment in (%segments object)
          do (format stream "{~s} " segment))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Appending two paths

(defgeneric append-paths (path1 path2))

(defmethod append-paths ((path1 bezier-curve) (path2 bezier-curve))
  (make-instance 'bezier-curve
    :segments (append (%segments path1) (%segments path2))))

(defmethod close-path ((path bezier-curve))
  (let ((segments (%segments path)))
    (make-instance 'bezier-area :segments segments)))
