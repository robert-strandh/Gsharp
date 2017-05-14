(cl:in-package #:sequence-dico)

;;; Store an object associated with the sequence in the sequence dictionary.
;;; If a prefix of sequence already names an object in the dictionary
;;; the existing object is removed. 

(defgeneric (setf dico-object) (object sequence-dico sequence))

;;; Search for a sequence in a sequence dictionary.
;;; This function returns three values: The first value
;;; is the object associated with the sequence, or nil
;;; if no such object exists.  The second value is a boolean 
;;; which is t if the first value is the object associated with
;;; the sequence and nil otherwise.  The third value is t
;;; if the sequence is a (not necessarily proper) prefix of a sequence 
;;; that has an associated object and nil otherwise.

(defgeneric dico-object (sequence-dico sequence))

(defclass sequence-dico () ())

(defclass standard-sequence-dico (sequence-dico)
  ((table :initarg :table :reader table)))

(defun make-sequence-dico (&key (test #'eql))
  (make-instance 'standard-sequence-dico
		 :table (make-hash-table :test test)))

(defmethod (setf dico-object) (object (sequence-dico standard-sequence-dico) sequence)
  (assert (not (null sequence)))
  (loop for subseq on sequence
	for elem in sequence
	and table = (table sequence-dico) then (gethash elem table)
	do (unless (hash-table-p (gethash elem table))
	     (setf (gethash elem table)
		   (make-hash-table :test (hash-table-test (table sequence-dico)))))
	finally (setf (gethash elem table) object)))

(defmethod dico-object (sequence-dico sequence)
  (assert (not (null sequence)))
  (loop for subseq on sequence
	for elem in sequence
	for table-or-obj = (gethash elem (table sequence-dico))
	then (gethash elem table-or-obj)
	while (hash-table-p table-or-obj)
	finally (cond ((null table-or-obj) (return (values nil nil nil)))
		      ((hash-table-p table-or-obj) (return (values nil nil t)))
		      ((null (cdr subseq)) (return (values table-or-obj t t)))
		      (t (return (values nil nil nil))))))
