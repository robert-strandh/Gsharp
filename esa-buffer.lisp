;;; -*- Mode: Lisp; Package: ESA-IO -*-

;;;  (c) copyright 2006 by
;;;           Robert Strandh (strandh@labri.fr)

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

(in-package :esa-buffer)

(defgeneric make-buffer-from-stream (stream application-frame)
  (:documentation "Create a fresh buffer by reading the external
representation from STREAM"))

(defgeneric make-new-buffer (application-frame)
  (:documentation "Create a empty buffer for the application frame"))

(defgeneric save-buffer-to-stream (buffer stream)
  (:documentation "Save the entire BUFFER to STREAM in the appropriate
external representation"))

(defgeneric filepath (buffer))
(defgeneric (setf filepath) (filepath buffer))
(defgeneric name (buffer))
(defgeneric (setf name) (name buffer))
(defgeneric needs-saving (buffer))
(defgeneric (setf needs-saving) (needs-saving buffer))

(defclass esa-buffer-mixin ()
  ((%filepath :initform nil :accessor filepath)
   (%name :initarg :name :initform "*scratch*" :accessor name)
   (%needs-saving :initform nil :accessor needs-saving)
   (%read-only-p :initform nil :accessor read-only-p)))

