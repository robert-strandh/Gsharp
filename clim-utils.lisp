;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; New button types

(cl:in-package #:clim-internals)

;;; These are specialised PUSH-BUTTON implementations. PUSH-BUTTON
;;; deals with behaviour and with drawing and animating the button. In
;;; the CLIM specs, it also has a label string which it prints. The
;;; label is used at two points: space calculation and drawing.
;;
;;; Spacing -- COMPOSE-SPACE: slightly worrying because I don't really
;;; understand how layout works, but seems generally ok
;;
;;; Drawing is handled by two functions -- DRAW-LABEL*, which is a
;;; generic function, specialised here easily enouth, and
;;; DRAW-ENGRAVED-LABEL*, which handles pressed buttons by calling
;;; DRAW-LABEL* twice, with different settings positions and
;;; inks. This isn't a generic, so I can't do anything about it. Since
;;; my DRAW-LABEL* ignores ink, the 3d effect is lost.

;;; ICON-PUSH-BUTTON

;;; Push button that shows an icon *instead* of text. Perhaps this
;;; should be optionally with text. The icon must be in XPM format,
;;; but not for any readily apparent reason (more readers are in
;;; /Extensions)

(defclass icon-push-button (push-button)
  ((icon-path :initarg :icon-path :accessor icon-path)
   (icon :initarg :icon :initform nil)))

(defgeneric icon (button))

(defmethod icon ((button icon-push-button))
  ;; Once an icon file has been imported once, just return the
  ;; object. Perhaps it'd be better to do this when the object is
  ;; initialised.
  (unless (and (slot-boundp button 'icon)
               (slot-value button 'icon))
    (when (probe-file (icon-path button))
      (setf (slot-value button 'icon)
            (make-pattern-from-bitmap-file
             (icon-path button)
             :format :xpm :port nil))))
  (slot-value button 'icon))
(defclass icon-push-button-pane (icon-push-button push-button-pane)
  ())

(define-abstract-pane-mapping 'icon-push-button 'icon-push-button-pane)

(defmethod compose-space ((gadget icon-push-button-pane) &key width height)
  ;; FIXME: I don't really know what these values should be
  (let* ((pw (pattern-width (icon gadget)))
         (ph (pattern-height (icon gadget)))
         (w (+ pw
               (* 2 (+ *3d-border-thickness*
                       (or (pane-x-spacing gadget)
                           0)))))
         (h (+ ph (* 2 (+ *3d-border-thickness*
                          (or (pane-y-spacing gadget)
                              0))))))
    (make-space-requirement
     :width (or width w)
     :min-width w
     :height (or height h)
     :min-height h)))
(defmethod draw-label* ((pane icon-push-button) x1 y1 x2 y2
                        &key ink)
  (declare (ignore ink))
  (draw-pattern* pane (icon pane) x1 y1))

;;; DRAWN-PUSH-BUTTON
;;; A push button whose image is created using DRAWING-FUNCTION (which
;;; takes (STREAM X Y). I'm presetting width and height, because I
;;; don't understand CLIM layout functionality. Alternatives include
;;; storing a funcall to use in COMPOSE-SPACE or just making the
;;; drawing function work with whatever size it's given. I'm also
;;; making it a full CLIM-STREAM-PANE, because it works. Is it
;;; necessary?

(defclass drawn-push-button (push-button)
  ((drawing-function :initarg :drawing-function :accessor button-drawing-function)
   (drawing-width :initarg :drawing-width :accessor drawing-width)
   (height :initarg :drawing-height :accessor drawing-height)))

(defclass drawn-push-button-pane (drawn-push-button push-button-pane clim-stream-pane)
  ())

(define-abstract-pane-mapping 'drawn-push-button 'drawn-push-button-pane)

(defmethod compose-space ((gadget drawn-push-button-pane) &key width height)
  (let* ((dw (drawing-width  gadget))
         (dh (drawing-height gadget))
         (w (+ dw (* 2 (+ *3d-border-thickness*
                          (or (pane-x-spacing gadget)
                              0)))))
         (h (+ dh (* 2 (+ *3d-border-thickness*
                          (or (pane-y-spacing gadget)
                              0))))))
    (make-space-requirement
     :width (or width w)
     :min-width w
     :height (or height h)
     :min-height h)))

(defmethod draw-label* ((pane drawn-push-button) x1 y1 x2 y2
                        &key ink)
  (declare (ignore ink))
  (funcall (button-drawing-function pane) pane x1 y1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; File dialogue stuff
;;;
;;; Dialogue box for file browing operations. Takes an object and puts
;;; the resulting pathname into it (for now, this means we can only
;;; handle single files). User can optionally provide acceptable file
;;; extensions, which will disallow clicking on other files (the user
;;; can override this by ctrl-clicking).
;;;
;;; This really ought to go somewhere in CLIM, but it uses code from
;;; CLIM-LISTENER, so would probably need a package that doesn't exist
;;; or for some of the listener functionality to be moved somewhere
;;; useful.

(cl:in-package #:gsharp)

(defparameter *file-text-style*
  (make-text-style :sans-serif :roman :small))

;;; Transport for holding pathname info between application frame and
;;; caller
(defstruct filespec (pathname))

;;; FIXME: way to pass initargs to application gadget
(defparameter *init-info* "")

(define-command-table path-input)
;; (defclass file-browser-pane (esa-pane-mixin application-pane) ())

(define-gesture-name :adjust :pointer-button (:left :control))

(define-gesture-name :hidden :keyboard (#\h :control))

(defun read-text-path (gadget)
  (let ((new-path (pathname (gadget-value gadget))))
    (if (clim-listener::directoryp new-path)
        (setf (current-path *application-frame*)
              new-path)
        (setf (current-path *application-frame*)
              (make-pathname :directory (pathname-directory new-path))))
    (redraw-file-browser-windows *application-frame*)))

(define-application-frame file-browser (standard-application-frame)
  ((current-path :initarg :path :accessor current-path)
   (extensions :initarg :extensions :accessor extensions :initform nil)
   (show-hidden :initarg :hidden :accessor show-hidden :initform nil)
   (sort-predicate :initarg :sort :accessor sort-predicate :initform
                   #'directory-alpha-sort)
   (final-file :initarg :file :accessor final-file
               :initform (make-filespec :pathname "")))
  (:menu-bar nil)
  (:panes
   (path-input :text-field :text-style *file-text-style*
               :command-table 'file-browser
               :value (get-gadget-value :path-input)
               :activate-callback #'read-text-path)
   (browser (make-pane 'application-pane
                       :width 800
                       :height 300
                       :text-style *file-text-style*
                       :command-table 'file-browser
                       :display-function 'display-folder))
   (ok-button
    :push-button :label "Ok"
    :activate-callback
    #'(lambda (gadget)
        (declare (ignore gadget))
        (setf (filespec-pathname (final-file *application-frame*))
              (pathname
               (gadget-value (find-pane-named *application-frame*
                                              'path-input))))
        (frame-exit *application-frame*)))
   (cancel-button
    :push-button :label "Cancel"
    :activate-callback
    #'(lambda (gadget)
        (declare (ignore gadget))
        (setf (filespec-pathname (final-file *application-frame*)) "")
        (frame-exit *application-frame*))))
  (:layouts
   (default
       (vertically ()
         path-input
         (scrolling () browser)
         (horizontally () ok-button cancel-button +fill+)))))

(defun redraw-file-browser-windows (frame)
  (redisplay-frame-pane frame
                        (find-pane-named frame 'browser)
                        :force-p t)
  (redisplay-frame-pane frame
                        (find-pane-named frame 'path-input)
                        :force-p t))

(defmethod display-folder (frame pane)
  (let* ((main-path (current-path frame))
         (path (if (clim-listener::directoryp main-path)
                   (clim-listener::show-directory-pathnames main-path)
                   (clim-listener::show-directory-pathnames (directory-name main-path)))))
    (browser-show-directory
     pane
     ;;   (clim-listener::show-directory-pathnames (current-path frame))
     path
     :show-hidden (show-hidden frame)
     :sort-predicate (sort-predicate frame))))

(defun dir-parent (path)
  (merge-pathnames (make-pathname :directory '(:relative :back))
                   path))

(defun parent-dir (path)
  (let ((dirs (pathname-directory path)))
    (make-pathname :directory (subseq dirs 0 (1- (length dirs))))))

(defun hiddenp (path)
  (char= (elt (if (clim-listener::directoryp path)
                  (directory-name path)
                  (pathname-name path))
              0)
         #\.))

(defun directory-name (path)
  (car (last (pathname-directory path))))

(defun directory-alpha-sort (p1 p2)
  (let ((d1 (clim-listener::directoryp p1))
        (d2 (clim-listener::directoryp p2)))
    (if d1
        (if d2
            (string-lessp (directory-name p1) (directory-name p2))
            t)
        (if d2
            nil
            (or (string-lessp (pathname-name p1) (pathname-name p2))
                (and (string-equal (pathname-name p1) (pathname-name p2))
                     (string-lessp (pathname-type p1) (pathname-type p2))))))))

(defun file-filter (path frame)
  (when (pathname-type path)
    (if (extensions frame)
        (member (pathname-type path) (extensions frame)
                :test #'string-equal)
        t)))

(defun browser-show-directory (pane path
                               &key (show-hidden nil)
                               (sort-predicate #'directory-alpha-sort))
  (let* ((dir (coerce (directory path) 'simple-vector))
         (parent (parent-dir path)))
    (unless show-hidden
      (setf dir (sort (remove-if #'hiddenp dir) sort-predicate)))
    (formatting-table (pane)
      (dotimes (i (ceiling (/ (length dir) 3)))
        (formatting-row (pane)
          (dotimes (j 3)
            (unless (> (+ (* 3 i) j) (length dir))
              (formatting-cell (pane)
                (if (= i 0 j)
                    ;; fixme: root dir
                    (with-output-as-presentation
                        (pane parent 'clim:pathname :single-box t)
                      (clim-listener::draw-icon
                       pane
                       (clim-listener::standard-icon "up-folder.xpm")
                       :extra-spacing 3)
                      (princ "Parent directory" pane))
                    (with-drawing-options
                        (pane :ink
                              (if (or (clim-listener::directoryp (aref dir (+ (* 3 i) j -1)))
                                      (file-filter (aref dir (+ (* 3 i) j -1))
                                                   *application-frame*))
                                  +black+
                                  +gray+))
                      (clim-listener::pretty-pretty-pathname
                       (aref dir (+ (* 3 i) j -1)) pane path)))))))))))

(define-file-browser-command (com-change-to-directory :name t :menu t)
    ((pathname 'clim:pathname :prompt "pathname"))
  (change-to-directory pathname *application-frame*))

(defun change-to-directory (pathname frame)
  (setf (current-path frame) pathname
        (gadget-value (find-pane-named frame 'path-input))
        (princ-to-string pathname))
  (redraw-file-browser-windows frame))

(define-file-browser-command (com-toggle-hidden :name t :menu t
                                               :keystroke :hidden)
    ()
  (setf (show-hidden *application-frame*) (not (show-hidden *application-frame*)))
  (redraw-file-browser-windows *application-frame*))

(define-presentation-to-command-translator select-file
    (clim-listener::pathname com-select-file file-browser
                             :documentation "select file"
                             :tester ((object)
                                      (file-filter object *application-frame*)))
    (object)
  (list object))

(define-presentation-to-command-translator force-select-file
    (clim-listener::pathname com-select-file file-browser
                             :gesture :adjust
                             :documentation "select file"
                             :tester ((object)
                                      (not (clim-listener::directoryp object))))
    (object)
  (list object))

(define-file-browser-command (com-select-file :name t :menu t)
    ((pathname 'clim:pathname :prompt "pathname"))
  (let ((path (find-pane-named *application-frame* 'path-input)))
    (if (string= (gadget-value path) (princ-to-string pathname))
        (progn (setf (filespec-pathname (final-file *application-frame*)) pathname)
               (frame-exit *application-frame*))
        (progn (setf (gadget-value path) (princ-to-string pathname))
               (redraw-file-browser-windows *application-frame*)))))

(define-file-browser-command (com-load-file :name t :menu t)
    ((pathname 'clim:pathname :prompt "pathname"))
  (if (equal (filespec-pathname (final-file *application-frame*)) pathname)
      (frame-exit *application-frame*)
      (progn
        (setf (filespec-pathname (final-file *application-frame*)) pathname
              (gadget-value (find-pane-named *application-frame* 'path-input))
              (princ-to-string pathname))
        (redraw-file-browser-windows *application-frame*))))

(define-presentation-to-command-translator change-to-directory
    (clim-listener::pathname com-change-to-directory file-browser
                   :documentation  "change-to-directory"
                   :tester ((object) (clim-listener::directoryp object)))
    (object)
  (list object))

(defparameter *gadget-init-hash* (make-hash-table))

(defun get-gadget-value (keyword)
  (gethash keyword *gadget-init-hash*))

(defun set-gadget-defaults (gadget-pairs)
  (setf *gadget-init-hash* (make-hash-table))
  (do* ((gadget-pairs gadget-pairs (cddr gadget-pairs))
        (key (first gadget-pairs) (first gadget-pairs))
        (val (second gadget-pairs) (second gadget-pairs)))
       ((null gadget-pairs))
    (setf (gethash key *gadget-init-hash*) val)))

(defun make-application-frame-with-gadgets (type &key gadget-vars frame-vars)
  (set-gadget-defaults gadget-vars)
  (apply #'make-application-frame type frame-vars))

(defun gui-get-pathname (&key initial-path extensions)
  ;; clunky way of getting default values into gadgets
  (unless initial-path
    (setf initial-path (directory-of-current-buffer)))
  (let* ((filespec (make-filespec :pathname ""))
         (frame (make-application-frame-with-gadgets
                 'file-browser
                 :gadget-vars (list :path-input (princ-to-string initial-path))
                 :frame-vars (list :width 600 :path initial-path
                                   :file filespec
                                   :extensions extensions))))
    (run-frame-top-level frame)
    (filespec-pathname filespec)))
