;;; Flexichain
;;; Flexicursor data structure definition
;;;
;;; Copyright (C) 2003-2004  Robert Strandh (strandh@labri.fr)
;;; Copyright (C) 2003-2004  Matthieu Villeneuve (matthieu.villeneuve@free.fr)
;;;
;;; This library is free software; you can redistribute it and/or
;;; modify it under the terms of the GNU Lesser General Public
;;; License as published by the Free Software Foundation; either
;;; version 2.1 of the License, or (at your option) any later version.
;;;
;;; This library is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; Lesser General Public License for more details.
;;;
;;; You should have received a copy of the GNU Lesser General Public
;;; License along with this library; if not, write to the Free Software
;;; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA


(in-package :flexichain)

(defclass cursorchain (flexichain)
  ()
  (:documentation "The protocol class for cursor chains."))

(defclass flexicursor ()
  ()
  (:documentation "The protocol class for flexicursors."))

(define-condition at-beginning-error (flexi-error)
  ((cursor :reader at-beginning-error-cursor
           :initarg :cursor :initform nil))
  (:report (lambda (condition stream)
             (let ((cursor (at-beginning-error-cursor condition)))
               (format stream "Cursor ~A already at the beginning of ~A"
                       cursor
                       (chain cursor))))))

(define-condition at-end-error (flexi-error)
  ((cursor :reader at-end-error-cursor
           :initarg :cursor :initform nil))
  (:report (lambda (condition stream)
             (let ((cursor (at-end-error-cursor condition)))
               (format stream "Cursor ~A already at the end of ~A"
                       cursor
                       (chain cursor))))))

(defgeneric clone-cursor (cursor)
  (:documentation "Creates a cursor that is initially at the same location
as the one given as argument."))

(defgeneric cursor-pos (cursor)
  (:documentation "Returns the position of the cursor."))

(defgeneric (setf cursor-pos) (posistion cursor)
  (:documentation "Set the position of the cursor."))

(defgeneric at-beginning-p (cursor)
  (:documentation "Returns true if the cursor is at the beginning
of the chain."))

(defgeneric at-end-p (cursor)
  (:documentation "Returns true if the cursor is at the beginning
of the chain."))

(defgeneric move> (cursor &optional n)
  (:documentation "Moves the cursor forward N positions."))

(defgeneric move< (cursor &optional n)
  (:documentation "Moves the cursor backward N positions."))

(defgeneric insert (cursor object)
  (:documentation "Inserts an object at the cursor."))

(defgeneric insert-sequence (cursor sequence)
  (:documentation "The effect is the same as if each element of the
sequence was inserted using INSERT."))

(defgeneric delete< (cursor &optional n)
  (:documentation "Deletes N objects before the cursor."))

(defgeneric delete> (cursor &optional n)
  (:documentation "Deletes N objects after the cursor."))

(defgeneric element< (cursor)
  (:documentation "Returns the element immediately before the cursor."))

(defgeneric (setf element<) (object cursor)
  (:documentation "Replaces the element immediately before the cursor."))

(defgeneric element> (cursor)
  (:documentation "Returns the element immediately after the cursor."))

(defgeneric (setf element>) (object cursor)
  (:documentation "Replaces the element immediately after the cursor."))

(defclass standard-cursorchain (cursorchain standard-flexichain)
  ((cursors :initform (make-instance 'skiplist) :accessor cursorchain-cursors))
  (:documentation "The standard instantiable subclass of CURSORCHAIN"))

(defun make-wp (value)
  #+sbcl (sb-ext:make-weak-pointer value)
  #+cmu  (ext:make-weak-pointer value))

(defun wp-value (wp)
  #+sbcl (sb-ext:weak-pointer-value wp)
  #+cmu  (ext:weak-pointer-value wp))

(defmethod move-elements :after ((cc standard-cursorchain) to from start1 start2 end2)
  (declare (ignore to from))
  (let ((addfun (lambda (key wp-cursors)
		  (let ((increment (- start1 start2)))
		    (loop for wp in wp-cursors
			  as cursor = (wp-value wp)
			  unless (null cursor)
			    do (incf (flexicursor-index cursor) increment))
		    (+ key increment)))))
    (with-slots (cursors gap-start gap-end) cc
       (cond ((= start1 start2) nil)
	     ((= gap-start gap-end)
	      (skiplist-slide-keys cursors start2 (1- end2) addfun))
	     ((< gap-end gap-start)
	      (cond ((and (= end2 gap-start) (> start1 start2))
		     (skiplist-slide-keys cursors start2 (1- end2) addfun))
		    ((= end2 gap-start)
		     (skiplist-rotate-suffix cursors start2 addfun))
		    (t (skiplist-rotate-prefix cursors (1- end2) addfun))))
	     ((plusp gap-start)
	      (skiplist-slide-keys cursors start2 (1- end2) addfun))
	     ((= start2 gap-end)
	      (skiplist-slide-keys cursors start2 (1- end2) addfun))
	     (t
	      (skiplist-rotate-suffix cursors start2 addfun))))))

(defclass standard-flexicursor (flexicursor)
  ((chain :reader chain :initarg :chain)
   (index :accessor flexicursor-index))
  (:documentation "The standard instantiable subclass of FLEXICURSOR"))

(defclass left-sticky-flexicursor (standard-flexicursor) ())

(defclass right-sticky-flexicursor (standard-flexicursor) ())

(defmethod initialize-instance :after ((cursor left-sticky-flexicursor)
				       &rest initargs)
  (declare (ignore initargs))
  (with-slots (index chain) cursor
     (setf index (slot-value chain 'data-start))
     (with-slots (cursors) chain
	(push (make-wp cursor) (skiplist-find cursors index)))))

(defmethod initialize-instance :after ((cursor right-sticky-flexicursor)
				       &rest initargs)
  (declare (ignore initargs))
  (with-slots (index chain) cursor
     (setf index (position-index chain 0))
     (with-slots (cursors) chain
	(push (make-wp cursor) (skiplist-find cursors index)))))

(defmethod clone-cursor ((cursor standard-flexicursor))
  (with-slots (index) cursor
     (let ((result (make-instance (class-of cursor)
		      :chain (chain cursor))))
       (setf (slot-value result 'index) index)
       (with-slots (cursors) (chain cursor)
	  (push (make-wp result) (skiplist-find cursors index)))
       result)))

(defmethod cursor-pos ((cursor left-sticky-flexicursor))
  (1+ (index-position (chain cursor) (slot-value cursor 'index))))

(defmethod (setf cursor-pos) (position (cursor left-sticky-flexicursor))
  (assert (<= 0 position (nb-elements (chain cursor))) ()
	  'flexi-position-error :chain (chain cursor) :position position)
  (with-slots (chain index) cursor
     (setf index (position-index chain (1- position)))))

(defmethod cursor-pos ((cursor right-sticky-flexicursor))
  (index-position (chain cursor) (slot-value cursor 'index)))

(defmethod (setf cursor-pos) (position (cursor right-sticky-flexicursor))
  (assert (<= 0 position (nb-elements (chain cursor))) ()
	  'flexi-position-error :chain (chain cursor) :position position)
  (with-slots (chain index) cursor
     (setf index (position-index chain position))))

(defmethod at-beginning-p ((cursor standard-flexicursor))
  (zerop (cursor-pos cursor)))

(defmethod at-end-p ((cursor standard-flexicursor))
  (= (cursor-pos cursor) (nb-elements (chain cursor))))

(defmethod move> ((cursor standard-flexicursor) &optional (n 1))
  (cond ((minusp n) (move< cursor (- n)))
	((zerop n) nil)
	(t (let ((cursor-pos (cursor-pos cursor)))
	     (assert (<= (+ n cursor-pos) (nb-elements (chain cursor))) ()
		     'at-end-error :cursor cursor)
	     (with-slots (cursors) (chain cursor)
		(with-slots (index) cursor
		   (setf (skiplist-find cursors index)
			 (delete index (skiplist-find cursors index)
				 :key #'wp-value :test #'eq))
		   (setf (cursor-pos cursor) (+ cursor-pos n))
		   (push (make-wp cursor) (skiplist-find cursors index))))))))

(defmethod move< ((cursor standard-flexicursor) &optional (n 1))
  (cond ((minusp n) (move> cursor (- n)))
	((zerop n) nil)
	(t (let ((cursor-pos (cursor-pos cursor)))
	     (assert (>= cursor-pos n) ()
		     'at-beginning-error :cursor cursor)
	     (with-slots (cursors) (chain cursor)
		(with-slots (index) cursor
		   (setf (skiplist-find cursors index)
			 (delete index (skiplist-find cursors index)
				 :key #'wp-value :test #'eq))
		   (setf (cursor-pos cursor) (- cursor-pos n))
		   (push (make-wp cursor) (skiplist-find cursors index))))))))

(defmethod insert ((cursor standard-flexicursor) object)
  (insert* (chain cursor) (cursor-pos cursor) object))

(defmethod insert-sequence ((cursor standard-flexicursor) sequence)
  (map nil
       (lambda (object)
	 (insert cursor object))
       sequence))

(defmethod delete* :around ((chain standard-cursorchain) position)
  (with-slots (cursors) chain
     (let* ((old-index (position-index chain position))
	    (cursors-to-adjust (skiplist-find cursors old-index)))
       (when cursors-to-adjust
	 (skiplist-delete cursors old-index))
       (call-next-method)
       (loop for cursor-wp in cursors-to-adjust
	     as cursor = (wp-value cursor-wp)
	     when cursor
	       do (setf (cursor-pos cursor) position)
	       and do  (push cursor-wp (skiplist-find cursors (flexicursor-index cursor)))))))

(defmethod delete> ((cursor standard-flexicursor) &optional (n 1))
  (let ((chain (chain cursor))
        (position (cursor-pos cursor)))
    (assert (plusp n) ()
	    'flexi-position-error :chain chain :position n)
    (loop repeat n
          do (delete* chain position))))

(defmethod delete< ((cursor standard-flexicursor) &optional (n 1))
  (let ((chain (chain cursor))
	(position (cursor-pos cursor)))
    (assert (plusp n) ()
	    'flexi-position-error :chain chain :position n)
    (loop repeat n
	  do (delete* chain (- position n)))))

(defmethod element> ((cursor standard-flexicursor))
  (assert (not (at-end-p cursor)) ()
          'at-end-error :cursor cursor)
  (element* (chain cursor) (cursor-pos cursor)))

(defmethod (setf element>) (object (cursor standard-flexicursor))
  (assert (not (at-end-p cursor)) ()
          'at-end-error :cursor cursor)
  (setf (element* (chain cursor) (cursor-pos cursor))
        object))

(defmethod element< ((cursor standard-flexicursor))
  (assert (not (at-beginning-p cursor)) ()
          'at-beginning-error :cursor cursor)
  (element* (chain cursor) (1- (cursor-pos cursor))))

(defmethod (setf element>) (object (cursor standard-flexicursor))
  (assert (not (at-beginning-p cursor)) ()
          'at-beginning-error :cursor cursor)
  (setf (element* (chain cursor) (1- (cursor-pos cursor)))
        object))

