;;; Flexichain
;;; Utility functions
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

(defun square (x)
  "Returns the square of the number X."
  (* x x))

(defun find-if-2 (predicate sequence)
  "Searches the sequence for an element that satisfies PREDICATE.
Returns the element found or NIL of none was found, and a boolean
indicating whether an element was found or not."
  (let ((position (position-if predicate sequence)))
    (if (null position)
        (values nil nil)
        (values (elt sequence position) t))))

;;; CMUCL and SBCL have direct support for weak pointers. In OpenMCL weak
;;; references are only supported via weak hash tables. This class provides
;;; the means for other classes to manage their weak references.
;;;
;;; TODO: check other CL implementations behavior wrt. return values
(defclass weak-pointer-container-mixin ()
  (#+openmcl
   (weak-hash :initform (make-hash-table :test #'eq :weak :value)))
  (:documentation "Support for weak references, if needed"))

(defgeneric make-weak-pointer (object container))

#+(or sbcl cmu)
(defmethod make-weak-pointer (object container)
  (declare (ignore container))
    #+cmu (extensions:make-weak-pointer object)
    #+sbcl (sb-ext:make-weak-pointer object))

#+openmcl
(defmethod make-weak-pointer (object (container weak-pointer-container-mixin))
  (let ((key (cons nil nil)))
    (setf (gethash key (slot-value container 'weak-hash)) object)
    key))

(defgeneric weak-pointer-value (weak-pointer container))

#+(or sbcl cmu)
(defmethod weak-pointer-value (weak-pointer container)
  (declare (ignore container))
  #+cmu (extensions:weak-pointer-value weak-pointer)
  #+sbcl (sb-ext:weak-pointer-value weak-pointer))

#+openmcl
(defmethod weak-pointer-value
    (weak-pointer (container weak-pointer-container-mixin))
  (gethash weak-pointer (slot-value container 'weak-hash) nil))

#-(or sbcl cmu openmcl)
(progn
  (eval-when (:evaluate :compile-toplevel :load-toplevel)
    (warning "No support for weak pointers in this implementation. Things may
get big and slow")
    )
  (defmethod make-weak-pointer (object container)
    (declare (ignore container))
    object)
  (defmethod weak-pointer-value (weak-pointer container)
    (declare (ignore container))
    weak-pointer))
