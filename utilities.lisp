(in-package :gsharp-utilities)

;;; Destructively insert the element in the list at the position
;;; indicated.  The position must be greater than or equal to zero and
;;; less than or equal to the length of the list.
(defun ninsert-element (element list position)
  (if (zerop position)
      (push element list)
      (push element (cdr (nthcdr (1- position) list))))
  list)

;;; The following hack is due to Gilbert Baumann.  It allows us to
;;; dynamically mix in classes into a class without the latter being
;;; aware of it.  

;; First of all we need to keep track of added mixins, we use a hash
;; table here. Better would be to stick this information to the victim
;; class itself.

(defvar *stealth-mixins* (make-hash-table))

(defmacro class-stealth-mixins (class)
  `(gethash ,class *stealth-mixins*))

(defmacro define-added-mixin (name super-classes victim-class
                              &rest for-defclass)
  "Like DEFCLASS but adds the newly defined class to the super classes
of 'victim-class'."
  `(progn
    ;; First define the class we talk about
    (defclass ,name ,super-classes ,@for-defclass)

    ;; Add the class to the mixins of the victim
    (clim-mop:ensure-class
     ',victim-class
     :direct-superclasses (adjoin ',name
                                  (and (find-class ',victim-class nil)
                                       (class-direct-superclasses
					(find-class ',victim-class)))
                                  :test #'class-equalp))

    ;; Register it as a new mixin for the victim class
    (pushnew ',name (class-stealth-mixins ',victim-class))

    ;; When one wants to [re]define the victim class the new mixin
    ;; should be present too. We do this by 'patching' ensure-class:
    (defmethod clim-mop:ensure-class-using-class :around
      ((name (eql ',victim-class)) class ;AMOP has these swaped ...
       &rest arguments
       &key (direct-superclasses nil direct-superclasses-p)
       &allow-other-keys)
      (cond (direct-superclasses-p
             ;; Silently modify the super classes to include our new
             ;; mixin.
             (dolist (k (class-stealth-mixins name))
               (pushnew k direct-superclasses
                        :test #'class-equalp))
             (apply #'call-next-method name class 
                    :direct-superclasses direct-superclasses
                    arguments))
            (t
             (call-next-method))))
    ;;
    ',name))

;; The 'direct-superclasses' argument to ensure-class is a list of
;; either classes or their names. Since we want to avoid duplicates,
;; we need an appropriate equivalence predicate:

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


