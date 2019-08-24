(cl:in-package #:obseq)

;;; ************************************************
;;; ****************** test case *******************
;;; ************************************************

;;; the class for elements of the obseq
(defclass numseq-elem (obseq-elem)
  ((value :initarg :value :reader elem-value)
   (index :initarg :index :reader elem-index)))

(defmethod print-object ((object numseq-elem) stream)
  (with-accessors ((value elem-value)
                   (index elem-index)
                   (number-left number-left)
                   (number-right number-right)
                   (best-tcost-left best-tcost-left)
                   (best-cut-left best-cut-left)
                   (best-tcost-right best-tcost-right)
                   (best-cut-right best-cut-right))
      object
    (format stream
            "[I: ~a V: ~a {L: N: ~a BT: ~a BC: ~a} {R: N: ~a BT: ~a BC: ~a}]"
            index value
            number-left
            best-tcost-left (if (null best-cut-left) "-" (number-left best-cut-left))
            number-right
            best-tcost-right (if (null best-cut-right) "-" (number-right best-cut-right)))))

;;; the class for the obseq itself
(defclass numseq (obseq)
  ((data :initarg :data :accessor numseq-data)))

(defmethod print-object ((object numseq) stream)
  (loop for elem = (obseq-head object) then (elem-prev object elem)
        do (print elem stream)
        until (left-sentinel-p object elem))
  (princ "****" stream)
  (loop for elem = (obseq-tail object) then (elem-next object elem)
        do (print elem stream)
        until (right-sentinel-p object elem)))

;;; how to get from one element to the other
(defmethod obseq-next ((ns numseq) (elem (eql nil)))
  (aref (numseq-data ns) 0))

(defmethod obseq-next ((ns numseq) (elem numseq-elem))
  (and (< (elem-index elem) (1- (length (numseq-data ns))))
       (aref (numseq-data ns) (1+ (elem-index elem)))))

(defmethod obseq-prev ((ns numseq) (elem (eql nil)))
  (aref (numseq-data ns) (1- (length (numseq-data ns)))))

(defmethod obseq-prev ((ns numseq) (elem numseq-elem))
  (and (> (elem-index elem) 0)
       (aref (numseq-data ns) (1- (elem-index elem)))))

;;; the class for the cost method
(defclass numseq-method (cost-method)
  ((best-sum :initarg :best-sum :accessor cost-best-sum)))

;;; the class for the seq-cost
(defclass numseq-seq-cost (seq-cost)
  ((sum :initarg :sum :reader cost-sum)))

(defmethod print-object ((object numseq-seq-cost) stream)
  (format stream "[SC: ~a]" (cost-sum object)))

;;; the class for the total-cost
(defclass numseq-total-cost (total-cost)
  ((maxcost :initarg :maxcost :reader maxcost)))

(defmethod print-object ((object numseq-total-cost) stream)
  (format stream "[TC: ~a]" (maxcost object)))

(defmethod combine-cost ((method numseq-method)
                         (seq-cost numseq-seq-cost)
                         (elem numseq-elem))
  (make-instance 'numseq-seq-cost :sum (+ (cost-sum seq-cost) (elem-value elem))))

(defmethod combine-cost ((method numseq-method)
                         (total-cost numseq-total-cost)
                         (seq-cost numseq-seq-cost))
  (make-instance 'numseq-total-cost
    :maxcost (max (maxcost total-cost)
                  (abs (- (cost-sum seq-cost) (cost-best-sum method))))))

(defmethod combine-cost ((method numseq-method)
                         (seq-cost numseq-seq-cost)
                         (empty (eql nil)))
  (make-instance 'numseq-total-cost
    :maxcost (abs (- (cost-sum seq-cost) (cost-best-sum method)))))

(defmethod combine-cost ((method numseq-method) (elem numseq-elem) (empty (eql nil)))
  (make-instance 'numseq-seq-cost :sum (elem-value elem)))

;;; cost comparisons
(defmethod cost-less ((method numseq-method)
                      (c1 numseq-seq-cost)
                      (c2 numseq-seq-cost))
  (< (abs (- (cost-best-sum method)
             (cost-sum c1)))
     (abs (- (cost-best-sum method)
             (cost-sum c2)))))

(defmethod cost-less ((method numseq-method)
                      (c1 numseq-total-cost)
                      (c2 numseq-total-cost))
  (< (maxcost c1) (maxcost c2)))

;;; tell it how to stop adding cost
(defmethod seq-cost-cannot-decrease ((method numseq-method)
                                     (seq-cost numseq-seq-cost))
  (>= (cost-sum seq-cost)
      (cost-best-sum method)))

;;; instantiate the problem
(defparameter *ns*
  (make-instance 'numseq
    :data (coerce (loop for val in '(5 8 6 9 4 7 6 6 3 2 4 7 3 4
                                     5 4 7 7 6 3 4 9 2 3 4 3 5
                                     7 7 8 9 5 9 4 9 3 9 2 8 6 6
                                     6 7 7 8 9 5 9 4 9 3 9 2 8)
                        for i from 0
                        collect (make-instance 'numseq-elem :index i :value val))
                  'vector)
    :cost-method (make-instance 'numseq-method :best-sum 30)))
