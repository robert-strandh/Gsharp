;;; TeX GF file reading and writing program
;;; Copyright (c) 2003 by Robert Strandh (strandh@labri.fr)

(in-package :gf)

(defclass gf-char ()
  ((char-no :initarg :char-no :reader gf-char-no)
   (min-m :initarg :min-m :accessor gf-char-min-m)
   (max-m :initarg :max-m :accessor gf-char-max-m)
   (min-n :initarg :min-n :accessor gf-char-min-n)
   (max-n :initarg :max-n :accessor gf-char-max-n)
   (matrix :initarg :matrix :accessor gf-char-matrix)))

(defclass gf-font ()
  ((comment :initarg :comment :accessor gf-font-comment)
   (chars :initarg :chars :accessor gf-font-chars)
   (design-size :accessor gf-font-design-size)
   (checksum :accessor gf-font-checksum)
   (horizontal-ratio :accessor gf-font-horizontal-ratio)
   (vertical-ratio :accessor gf-font-vertical-ratio)
   (min-column :accessor gf-font-min-column)
   (max-column :accessor gf-font-max-column)
   (min-row :accessor gf-font-min-row)
   (max-row :accessor gf-font-max-row)))

(defparameter *current-column-number* 0)
(defparameter *current-row-number* 0)
(defparameter *paint-black* nil)
(defparameter *current-matrix* nil)
(defparameter *chars* '())
(defparameter *current-font* nil)
(defparameter *gf-stream* nil)

(defparameter *commands* (make-array 256 :initial-element nil))

(defun u1 ()
  (read-byte *gf-stream*))

(defun u2 ()
  (+ (ash (u1) 8) (u1)))

(defun u3 ()
  (+ (ash (u2) 8) (u1)))

(defun u4 ()
  (+ (ash (u3) 8) (u1)))

(defun s4 ()
  (let ((result (u4)))
    (if (>= result #.(ash 1 31))
	(- result #.(ash 1 32))
	result)))

(defmacro define-gf-command ((name code) args &body body)
  `(progn (defun ,name ()
	    (let ,(mapcar (lambda (argdesc)
			    `(,(car argdesc) (,(cadr argdesc))))
			  args)
	      ,@body))
	  (setf (aref *commands* ,code) #',name)))

(defun paint-command (howmany)
  (loop repeat howmany do
	(setf (aref *current-matrix*
		    *current-row-number*
		    *current-column-number*)
	      (if *paint-black* 1 0))
	(incf *current-column-number*))
  (setf *paint-black* (not *paint-black*)))

(define-gf-command (paint1 64) ((d u1))
  (paint-command d))

(define-gf-command (paint2 65) ((d u2))
  (paint-command d))

(define-gf-command (paint3 66) ((d u3))
  (paint-command d))

(defun boc-command (char-no prev-char min-m max-m min-n max-n)
  (push (make-instance 'gf-char
	  :char-no (if (= prev-char -1)
		       char-no
		       (+ 256 (gf-char-no (find char-no *chars* :key #'gf-char-no))))
	  :min-m min-m :max-m max-m :min-n min-n :max-n max-n)
	*chars*)
  (setf *current-matrix* (make-array `(,(1+ (- max-n min-n)) ,(1+ (- max-m min-m)))
				     :element-type 'bit
				     :initial-element 0))
  (setf *current-row-number* 0
	*current-column-number* 0)
  (setf *paint-black* nil))

(define-gf-command (beginning-of-char 67)
    ((char-no s4) (prev-char s4) (min-m s4) (max-m s4) (min-n s4) (max-n s4))
  (boc-command char-no prev-char min-m max-m min-n max-n))

(define-gf-command (beginning-of-char-1 68)
    ((char-no u1) (del-m u1) (max-m u1) (del-n u1) (max-n u1))
  (boc-command char-no -1 (- max-m del-m) max-m (- max-n del-n) max-n))

(define-gf-command (end-of-char 69) ()
  (setf (gf-char-matrix (car *chars*))
	*current-matrix*))

(defun skip-command (d)
  (incf *current-row-number* (1+ d))
  (setf *current-column-number* 0)
  (setf *paint-black* nil))

(define-gf-command (skip-0 70) ()
  (skip-command 0))

(define-gf-command (skip-1 71) ((d u1))
  (skip-command d))

(define-gf-command (skip-2 72) ((d u2))
  (skip-command d))

(define-gf-command (skip-3 73) ((d u3))
  (skip-command d))

(defun special-command (length)
  (loop repeat length do (u1)))

(define-gf-command (special-1 239) ((length u1))
  (special-command length))

(define-gf-command (special-2 240) ((length u2))
  (special-command length))

(define-gf-command (special-3 241) ((length u3))
  (special-command length))

(define-gf-command (special-4 242) ((length u4))
  (special-command length))

(define-gf-command (numspecial 243) ((value s4))
  (declare (ignore value))
  nil)

(define-gf-command (no-op 244) ()
  nil)

(defun char-loc-command (c dx dy w p)
  (declare (ignore c dx dy w p))
  nil)

(define-gf-command (char-loc 245)
    ((c u1) (dx s4) (dy s4) (w s4) (p s4))
  (char-loc-command c dx dy w p))

(define-gf-command (char-loc-0 246)
    ((c u1) (dm u1) (w s4) (p s4))
  (char-loc-command c (+ 65536 dm) 0 w p)) ; check the (+ 65536 dm) part

(define-gf-command (preamble 247) ((gf-id u1) (length u1))
  (declare (ignore gf-id))
  (let ((comment (make-string length)))
    (loop for i from 0 below length do
	  (setf (aref comment i) (code-char (u1))))
    (setf *current-font* (make-instance 'gf-font :comment comment))))

(define-gf-command (postamble-start 248)
    ((p u4) (ds u4) (cs u4) (hppp u4) (vppp u4)
     (min-m s4) (max-m s4) (min-n s4) (max-n s4))
  (declare (ignore p ds cs hppp vppp min-m max-m min-n max-n))
  (setf (gf-font-chars *current-font*) *chars*))	

(define-gf-command (postamble-end 249) ((q u4) (i u1))
  (declare (ignore q i))
  nil)

(defun new-row-command (howmany)
  (incf *current-row-number*)
  (setf *current-column-number* (- howmany 74))
  (setf *paint-black* t))

(defun parse-gf-stream (*gf-stream*)
  (let ((*current-font* nil)
	(*chars* '()))
    (loop for command-code = (u1) then (u1)
	  do (cond ((<= command-code 63) (paint-command command-code))
		   ((<= 74 command-code 238) (new-row-command command-code))
		   (t (funcall (aref *commands* command-code))))
	  until (= command-code 249)
	  finally (return *current-font*))))

(defun parse-gf-file (filename)
  (with-open-file (stream filename
			  :direction :input
			  :element-type '(unsigned-byte 8))
    (parse-gf-stream stream)))
