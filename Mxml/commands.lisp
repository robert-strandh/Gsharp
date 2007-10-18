(in-package :gsharp)

;;; like print-buffer-filename in gui.lisp
(defun export-buffer-filename ()
  (let* ((buffer (current-buffer))
         (filepath (filepath buffer))
         (name (name buffer))
         (defaults (or filepath (merge-pathnames (make-pathname :name name)
                                                 (user-homedir-pathname)))))
    (merge-pathnames (make-pathname :type "xml") defaults)))

;;; like directory-of-current-buffer in esa-io.lisp
(defun directory-of-current-buffer ()
  "Extract the directory part of the filepath to the file in the current buffer.
   If the current buffer does not have a filepath, the path to
   the user's home directory will be returned."
  (make-pathname
   :directory
   (pathname-directory
    (or (filepath (current-buffer))
        (user-homedir-pathname)))))

(define-gsharp-command (com-import-musicxml :name t)
    ((pathname 'pathname
               :prompt "Import From: " :prompt-mode :raw
               :default (directory-of-current-buffer) :default-type 'pathname
               :insert-default t))
  (let* ((buffer (gsharp-mxml::parse-mxml (gsharp-mxml::musicxml-document pathname)))
         (input-state (make-input-state))
         (cursor (make-initial-cursor buffer))
         (view (make-instance 'orchestra-view :buffer buffer :cursor cursor)))
    (setf (view (car (windows *application-frame*))) view
          (filepath buffer) (merge-pathnames (make-pathname :type "gsh") pathname)
          (name buffer) (file-namestring (filepath buffer))
          (input-state *application-frame*) input-state)
    (select-layer cursor (car (layers (segment (current-cursor)))))))
          
(define-gsharp-command (com-export-musicxml :name t)
    ((pathname 'pathname
               :prompt "Export To: " :prompt-mode :raw
               :default (export-buffer-filename) :default-type 'pathname
               :insert-default t))
  (let ((string (gsharp-mxml::write-mxml (current-buffer))))
    (with-open-file (s pathname :if-does-not-exist :create :if-exists :supersede :direction :output)
      (write-string string s))))
