(cl:in-package #:common-lisp-user)

(defpackage :obseq
  (:use :common-lisp)
  (:export #:obseq #:obseq-elem #:obseq-next #:obseq-prev
	   #:obseq-first-undamaged-element
	   #:obseq-last-undamaged-element
	   #:cost-method #:obseq-cost-method #:seq-cost
	   #:total-cost #:combine-cost #:seq-cost-cannot-decrease
	   #:cost-less #:obseq-solve #:obseq-interval))
