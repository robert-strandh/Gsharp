;;; Ranked flexichain
;;;
;;; Copyright (C) 2005  Robert Strandh (strandh@labri.fr)
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

;;; A ranked flexichain is a flexichain (or a cursorchain) in which
;;; the elements know their position.  To make that work, client code
;;; must use mix in the flexirank-mixin class into whatever flexichain
;;; class they are using, and mix in the element-rank-mixin class into
;;; elements of that chain.

;;; The element-rank-mixin supplies a method on the client-visible
;;; generic function rank.

(defgeneric rank (element))

(defclass element-rank-mixin ()
  ((index :accessor index)
   (chain :accessor chain)))  

(defmethod rank ((element element-rank-mixin))
  (index-position (chain element) (index element)))

;;; this class must be mixed into a flexichain that contains ranked elements
(defclass flexirank-mixin () ())

(defmethod move-elements :after ((chain flexirank-mixin) to from start1 start2 end2)
  (loop for old from start2 below end2
	for new from start1
	do (setf (index (aref from old)) new)))

(defmethod insert* :after ((chain flexirank-mixin) position (object element-rank-mixin))
  (setf (index object) (position-index chain position)
	(chain object) chain))

(defmethod (setf element*) :after ((object element-rank-mixin) (chain flexirank-mixin) position)
  (setf (index object) (position-index chain position)
	(chain object) chain))

(defmethod insert-vector* :after ((chain flexirank-mixin) position vector)
  (loop for elem across vector
	for pos from position
	do (setf (index elem) (position-index pos)
		 (chain elem) chain)))
