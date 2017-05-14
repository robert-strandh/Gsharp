(cl:in-package #:gsharp-utilities)

;;; Destructively insert the element in the list at the position
;;; indicated.  The position must be greater than or equal to zero and
;;; less than or equal to the length of the list.
(defun ninsert-element (element list position)
  (if (zerop position)
      (push element list)
      (push element (cdr (nthcdr (1- position) list))))
  list)

;;; The 'direct-superclasses' argument to ensure-class is a list of
;;; either classes or their names. Since we want to avoid duplicates,
;;; we need an appropriate equivalence predicate:

(defun class-equalp (c1 c2)
  (when (symbolp c1) (setf c1 (find-class c1)))
  (when (symbolp c2) (setf c2 (find-class c2)))
  (eq c1 c2))

;;; Unicode utilities

(defparameter *char-to-unicode-table* (make-hash-table))
(defparameter *unicode-to-char-table* (make-hash-table))

(defun char-to-unicode (char)
  (or (gethash char *char-to-unicode-table*) 0))

(defun unicode-to-char (unicode)
  (or (gethash unicode *unicode-to-char-table*) #\_))

(defun set-char-unicode-correspondance (char unicode)
  (setf (gethash char *char-to-unicode-table*) unicode
	(gethash unicode *unicode-to-char-table*) char))

(loop for char in '(#\A #\B #\C #\D #\E #\F #\G #\H #\I #\J #\K #\L #\M
		    #\N #\O #\P #\Q #\R #\S #\T #\U #\V #\W #\X #\Y #\Z)
      for code from 65
      do (set-char-unicode-correspondance char code))

(loop for char in '(#\a #\b #\c #\d #\e #\f #\g #\h #\i #\j #\k #\l #\m
		    #\n #\o #\p #\q #\r #\s #\t #\u #\v #\w #\x #\y #\z)
      for code from 97
      do (set-char-unicode-correspondance char code))

(loop for char in '(#\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9)
      for code from 48
      do (set-char-unicode-correspondance char code))
