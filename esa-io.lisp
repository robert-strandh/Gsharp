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

(in-package :esa-io)

(defgeneric buffers (application-frame)
  (:documentation "Return a list of all the buffers of the application"))

(defgeneric current-buffer (application-frame)
  (:documentation "Return the current buffer of APPLICATION-FRAME"))

(defgeneric find-file (file-path application-frame))
(defgeneric find-file-read-only (file-path application-frame))
(defgeneric set-visited-filename (filepath buffer application-frame))
(defgeneric save-buffer (buffer application-frame))
(defgeneric write-buffer (buffer filepath application-frame))

(make-command-table 'esa-io-table :errorp nil)

(defgeneric find-file (file-path application-frame)
  (:documentation "if a buffer with the file-path already exists, return it,
else if a file with the right name exists, return a fresh buffer created from 
the file, else return a new empty buffer having the associated file name."))

(defun filename-completer (so-far mode)
  (flet ((remove-trail (s)
	   (subseq s 0 (let ((pos (position #\/ s :from-end t)))
			 (if pos (1+ pos) 0)))))
    (let* ((directory-prefix
	    (if (and (plusp (length so-far)) (eql (aref so-far 0) #\/))
		""
		(namestring #+sbcl *default-pathname-defaults*
                            #+cmu (ext:default-directory)
                            #-(or sbcl cmu) *default-pathname-defaults*)))
	   (full-so-far (concatenate 'string directory-prefix so-far))
	   (pathnames
	    (loop with length = (length full-so-far)
		  and wildcard = (concatenate 'string (remove-trail so-far) "*.*")
		  for path in
		  #+(or sbcl cmu lispworks) (directory wildcard)
		  #+openmcl (directory wildcard :directories t)
		  #+allegro (directory wildcard :directories-are-files nil)
		  #+cormanlisp (nconc (directory wildcard)
				      (cl::directory-subdirs dirname))
		  #-(or sbcl cmu lispworks openmcl allegro cormanlisp)
		    (directory wildcard)
		  when (let ((mismatch (mismatch (namestring path) full-so-far)))
			 (or (null mismatch) (= mismatch length)))
		    collect path))
	   (strings (mapcar #'namestring pathnames))
	   (first-string (car strings))
	   (length-common-prefix nil)
	   (completed-string nil)
	   (full-completed-string nil))
      (unless (null pathnames)
	(setf length-common-prefix
	      (loop with length = (length first-string)
		    for string in (cdr strings)
		    do (setf length (min length (or (mismatch string first-string) length)))
		    finally (return length))))
      (unless (null pathnames)
	(setf completed-string
	      (subseq first-string (length directory-prefix)
		      (if (null (cdr pathnames)) nil length-common-prefix)))
	(setf full-completed-string
	      (concatenate 'string directory-prefix completed-string)))
      (case mode
	((:complete-limited :complete-maximal)
	 (cond ((null pathnames)
		(values so-far nil nil 0 nil))
	       ((null (cdr pathnames))
		(values completed-string t (car pathnames) 1 nil))
	       (t
		(values completed-string nil nil (length pathnames) nil))))
	(:complete
	 (cond ((null pathnames)
		(values so-far t so-far 1 nil))
	       ((null (cdr pathnames))
		(values completed-string t (car pathnames) 1 nil))
	       ((find full-completed-string strings :test #'string-equal)
		(let ((pos (position full-completed-string strings :test #'string-equal)))
		  (values completed-string
			  t (elt pathnames pos) (length pathnames) nil)))
	       (t
		(values completed-string nil nil (length pathnames) nil))))
	(:possibilities
	 (values nil nil nil (length pathnames)
		 (loop with length = (length directory-prefix)
		       for name in pathnames
		       collect (list (subseq (namestring name) length nil)
				     name))))))))

(define-presentation-method present (object (type pathname)
                                            stream (view textual-view) &key)
  (princ (namestring object) stream))

(define-presentation-method accept ((type pathname) stream (view textual-view)
                                    &key (default nil defaultp) (default-type type))
  (multiple-value-bind (pathname success string)
      (complete-input stream
		      #'filename-completer
		      :allow-any-input t)
    (cond (success
	   (values pathname type))
	  ((and (zerop (length string))
		defaultp)
	   (values default default-type))
	  (t (values string 'string)))))

;;; Adapted from cl-fad/PCL
(defun directory-pathname-p (pathspec)
  "Returns NIL if PATHSPEC does not designate a directory."
  (let ((name (pathname-name pathspec))
	(type (pathname-type pathspec)))
    (and (or (null name) (eql name :unspecific))
	 (or (null type) (eql type :unspecific)))))

(defun filepath-filename (pathname)
  (if (null (pathname-type pathname))
      (pathname-name pathname)
      (concatenate 'string (pathname-name pathname)
		   "." (pathname-type pathname))))

(defmethod find-file (filepath application-frame)
  (cond ((null filepath)
	 (display-message "No file name given.")
	 (beep))
	((directory-pathname-p filepath)
	 (display-message "~A is a directory name." filepath)
	 (beep))
	(t
	 (or (find filepath (buffers *application-frame*)
		   :key #'filepath :test #'equal)
	     (let ((buffer (if (probe-file filepath)
			       (with-open-file (stream filepath :direction :input)
				 (make-buffer-from-stream stream *application-frame*))
			       (make-new-buffer *application-frame*))))
	       (setf (filepath buffer) filepath
		     (name buffer) (filepath-filename filepath)
		     (needs-saving buffer) nil)
	       buffer)))))

(define-command (com-find-file :name t :command-table esa-io-table) ()
  (let* ((filepath (accept 'pathname :prompt "Find File")))
    (find-file filepath *application-frame*)))

(set-key 'com-find-file 'esa-io-table '((#\x :control) (#\f :control)))

(defmethod find-file-read-only (filepath application-frame)
  (cond ((null filepath)
	 (display-message "No file name given.")
	 (beep))
	((directory-pathname-p filepath)
	 (display-message "~A is a directory name." filepath)
	 (beep))
	(t
	 (or (find filepath (buffers *application-frame*)
		   :key #'filepath :test #'equal)
	     (if (probe-file filepath)
		 (with-open-file (stream filepath :direction :input)
		   (let ((buffer (make-buffer-from-stream stream *application-frame*)))
		     (setf (filepath buffer) filepath
			   (name buffer) (filepath-filename filepath)
			   (read-only-p buffer) t
			   (needs-saving buffer) nil)))
		 (progn
		   (display-message "No such file: ~A" filepath)
		   (beep)
		   nil))))))

(define-command (com-find-file-read-only :name t :command-table esa-io-table) ()
  (let ((filepath (accept 'pathname :Prompt "Find file read only")))
    (find-file-read-only filepath *application-frame*)))

(set-key 'com-find-file-read-only 'esa-io-table '((#\x :control) (#\r :control)))

(define-command (com-read-only :name t :command-table esa-io-table) ()
  (let ((buffer (current-buffer *application-frame*)))
    (setf (read-only-p buffer) (not (read-only-p buffer)))))

(set-key 'com-read-only 'esa-io-table '((#\x :control) (#\q :control)))

(defmethod set-visited-file-name (filename buffer application-frame)
  (setf (filepath buffer) filename
	(name buffer) (filepath-filename filename)
	(needs-saving buffer) t))

(define-command (com-set-visited-file-name :name t :command-table esa-io-table) ()
  (let ((filename (accept 'pathname :prompt "New file name")))
    (set-visited-file-name filename (current-buffer *application-frame*) *application-frame*)))

(defmethod save-buffer (buffer application-frame)
  (let ((filepath (or (filepath buffer)
		      (accept 'pathname :prompt "Save Buffer to File"))))
    (cond
      ((directory-pathname-p filepath)
       (display-message "~A is a directory." filepath)
       (beep))
      (t
       (when (probe-file filepath)
	 (let ((backup-name (pathname-name filepath))
	       (backup-type (concatenate 'string (pathname-type filepath) "~")))
	   (rename-file filepath (make-pathname :name backup-name
						:type backup-type))))
       (with-open-file (stream filepath :direction :output :if-exists :supersede)
	 (save-buffer-to-stream buffer stream))
       (setf (filepath buffer) filepath
	     (name buffer) (filepath-filename filepath))
       (display-message "Wrote: ~a" (filepath buffer))
       (setf (needs-saving buffer) nil)))))

(define-command (com-save-buffer :name t :command-table esa-io-table) ()
  (let ((buffer (current-buffer *application-frame*)))
    (if (or (null (filepath buffer))
	    (needs-saving buffer))
	(save-buffer buffer *application-frame*)
	(display-message "No changes need to be saved from ~a" (name buffer)))))

(set-key 'com-save-buffer 'esa-io-table '((#\x :control) (#\s :control)))

(defmethod write-buffer (buffer filepath application-frame)
  (cond
    ((directory-pathname-p filepath)
     (display-message "~A is a directory name." filepath))
    (t
     (with-open-file (stream filepath :direction :output :if-exists :supersede)
       (save-buffer-to-stream buffer stream))
     (setf (filepath buffer) filepath
	   (name buffer) (filepath-filename filepath)
	   (needs-saving buffer) nil)
     (display-message "Wrote: ~a" (filepath buffer)))))

(define-command (com-write-buffer :name t :command-table esa-io-table) ()
  (let ((filepath (accept 'pathname :prompt "Write Buffer to File"))
	(buffer (current-buffer *application-frame*)))
    (write-buffer buffer filepath *application-frame*)))

(set-key 'com-write-buffer 'esa-io-table '((#\x :control) (#\w :control)))

