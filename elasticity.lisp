;;; Author: Robert Strandh
;;; Copyright (c) 2005 by Robert Strandh (strandh@labri.fr)

;;; This library is free software; you can redistribute it and/or
;;; modify it under the terms of the GNU Library General Public
;;; License as published by the Free Software Foundation; either
;;; version 2 of the License, or (at your option) any later version.
;;;
;;; This library is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;;; Library General Public License for more details.
;;;
;;; You should have received a copy of the GNU Library General Public
;;; License along with this library; if not, write to the
;;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;;; Boston, MA  02111-1307  USA.

;;; An elasticity function determines the physical size of a sequence
;;; of objects as a function of the force that is applied to it.  In
;;; our case, the force is always greater than or equal to zero, and
;;; in the direction of stretching the objects.  For large force
;;; values, the size of the sequence is always the force value times
;;; the sum of the individual elasticities of each object in the
;;; sequence.  However, individual objects may have stoppers that
;;; require them to be larger or equal to a particular value.  For an
;;; object to acquire a size larger than its stopper value, the force
;;; must therefor be larger than the stopper value divide by the
;;; elasticity.

;;; For a sequence of such objects, we thus get an elasticity function
;;; that is convex and piecewise linear, constant for small values of
;;; the force, and then a piecewise increasing slope for increasing
;;; values of the force.

;;; We represent such a function by a number and a list.  The number
;;; is the constant value for small values of the force.  The elements
;;; of the list (which might be empty) are pairs of the form (x . s)
;;; where x is the value of the force at which the slope changes, and
;;; s is the slope after than point.

(in-package :gsharp-drawing)

(defgeneric add-elasticities (e1 e2)
  (:documentation "add two elasticity functions"))

(defgeneric zero-force-size (elasticity)
  (:documentation "return the size of an elasticity at zero force"))

(defgeneric force-at-size (elasticity size)
  (:documentation "for a given size, return the force that is 
required to obtain that size.  The size must be larger than the 
size at zero force, as reported by zero-force-size"))

(defclass elasticity ()
  ((zero-force-size :initarg :zero-force-size :reader zero-force-size)
   (elements :initform '() :initarg :elements :reader elements)))

(defun make-zero-elasticity (size)
  "create an elasticity function that is constant for all
values of the force"
  (make-instance 'elasticity :zero-force-size size))

(defun make-elementary-elasticity (zero-force-size slope)
  "create an elasticity function that gives a size which is the 
product of the force and slope given, except that it will never 
have a size smaller than the zero-force-size given"
  (make-instance 'elasticity
    :zero-force-size zero-force-size
    :elements `(,(/ zero-force-size slope) . ,slope)))

(defmethod add-elasticities ((e1 elasticity) (e2 elasticity))
  (let ((l1 (elements e1))
	(l2 (elements e2))
	(s1 0)
	(s2 0)
	(result (list (+ (zero-force-size e1) (zero-force-size e2)))))
    (loop until (and (null l1) (null l2))
	  do (cond ((null l1)
		    (setf s2 (cdar l2))
		    (push (cons (caar l2) (+ s1 s2)) result)
		    (pop l2))
		   ((null l2)
		    (setf s1 (cdar l1))
		    (push (cons (caar l1) (+ s1 s2)) result)
		    (pop l1))
		   ((< 0.99999 (/ (caar l1) (caar l2)) 1.00001)
		    (setf s1 (cdar l1)
			  s2 (cdar l2))
		    (push (cons (/ (+ (caar l1) (caar l2)) 2) (+ s1 s2)) result)
		    (pop l1)
		    (pop l2))
		   ((< (caar l1) (caar l2))
		    (setf s1 (cdar l1))
		    (push (cons (caar l1) (+ s1 s2)) result)
		    (pop l1))
		   (t
		    (setf s2 (cdar l2))
		    (push (cons (caar l2) (+ s1 s2)) result)
		    (pop l2))))
    (make-instance 'elasticity :elements (nreverse result))))

(defmethod force-at-size ((e elasticity) size)
  (let ((l (elements e))
	(current-size (zero-force-size e)))
    (assert (not (null l)))
    (assert (>= size current-size))
    (let ((current-force 0)
	  (current-slope 0))
      (loop until (or (null l)
		      (>= (+ current-size (* current-slope (- (caar l) current-force)))
			  size))
	    do (incf current-size (* current-slope (- (caar l) current-force)))
	    do (setf current-force (caar l)
		     current-slope (cdar l))
	    do (pop l))
      (+ current-force (/ (- size current-size) current-slope)))))



	    
	    
    
    
    
