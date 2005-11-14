(in-package :common-lisp-user)

(defpackage "VIEWER"
  (:use :clim :clim-extensions :clim-lisp :gf))

(in-package "VIEWER")

(define-application-frame gf-viewer ()
  ((font :initform nil :accessor viewer-font)
   (chars :initform nil :accessor viewer-chars)
   (pixmaps :initform nil :accessor viewer-pixmaps)
   (index :initform 0 :accessor viewer-index)
   (grid :initform nil :accessor viewer-grid)
   (zoom :initform 1 :accessor viewer-zoom))
  (:pointer-documentation t)
  (:panes
   (viewer :application :width 800 :height 900 :display-function 'display-char)
   (interactor :interactor :width 800 :height 100))
  (:layouts
   (default
       (vertically () viewer interactor))))

(defparameter *gray-levels*
  (loop with result = (make-array '(17))
	for i from 0 to 16 do
	(setf (aref result i) (make-gray-color (/ i 16)))
	finally (return result)))

(defun possibly-allocate-pixmap (vector pane index char)
  (let* ((matrix (gf-char-matrix char))
	 (dimensions (array-dimensions matrix))
	 (left (floor (gf-char-min-m char) 4))
	 (right (ceiling (1+ (gf-char-max-m char)) 4))
	 (down (floor (gf-char-min-n char) 4))
	 (up (ceiling (1+ (gf-char-max-n char)) 4))
	 (height (car dimensions))
	 (width (cadr dimensions))
	 (glyph (make-array (list (- up down) (- right left))
			    :initial-element 16 :element-type '(unsigned-byte 8))))
    (unless (aref vector index)
      (loop for r from 0 below height
	    for y downfrom (gf-char-max-n char) by 1 do
	    (loop for c from 0 below width
		  for x from (gf-char-min-m char) do
		  (decf (aref glyph
			      (- up (ceiling (1+ y) 4))
			      (- (floor x 4) left))
			(aref matrix r c))))
      (setf (aref vector index)
	    (with-output-to-pixmap (medium pane :width (- right left) :height (- up down))
	      (loop for r from 0 below (- up down) do
		    (loop for c from 0 below (- right left) do
			  (draw-point* medium c r
				       :ink (aref *gray-levels* (aref glyph r c))))))))))

(defmethod display-char ((frame gf-viewer) pane)
  (draw-text* pane (format nil "index ~a of [0..~a]"
			   (viewer-index frame) (1- (length (viewer-chars frame))))
	      10 20)
  (when (viewer-font frame)
    (let* ((chars (viewer-chars frame))
	   (pixmaps (viewer-pixmaps frame))
	   (index (viewer-index frame))
	   (char (aref chars index))
	   (matrix (gf-char-matrix char))
	   (dimensions (array-dimensions matrix))
	   (min-m (gf-char-min-m char))
	   (max-m (gf-char-max-m char))
	   (min-n (gf-char-min-n char))
	   (max-n (gf-char-max-n char))
	   (height (car dimensions))
	   (width (cadr dimensions))
	   (zoom (viewer-zoom frame)))
      (possibly-allocate-pixmap pixmaps pane index char)
      (let ((pm (aref pixmaps index)))
	(copy-from-pixmap pm 0 0 (pixmap-width pm) (pixmap-height pm)
			  pane 0 100))
      (draw-text* pane (format nil "charno: ~a min-m: ~a max-m ~a min-n ~a max-n ~a"
			       (gf-char-no char)
			       (gf-char-min-m char) (gf-char-max-m char)
			       (gf-char-min-n char) (gf-char-max-n char))
		  200 20)
      (loop for r from 0 below height
	    for y from (max 0 (- (1+ max-n))) do
	    (loop with start = nil
		  for c from 0 below width
		  for x from (max 0 min-m) do
		  (cond ((and start (zerop (aref matrix r c)))
			 (draw-rectangle* pane
					  (+ (* start zoom) 40)
					  (+ (* y zoom) 40)
					  (+ (* x zoom) 40)
					  (+ (* y zoom) 40 zoom))
			 (setf start nil))
			((and (not start) (= (aref matrix r c) 1))
			 (setf start x))
			(t nil))))
      ;; possible draw a grid
      (when (and (viewer-grid frame) (> zoom 2))
	(loop for r from (max 0 (1+ max-n)) downto (min 0 min-n)
	      for y from 0 do
	      (draw-line* pane
			  30
			  (+ 40 (* y zoom))
			  (+ 50 (* (- (max 0 (1+ max-m)) (min 0 min-m)) zoom))
			  (+ 40 (* y zoom))
			  :ink (cond ((zerop r) +red+)
				     ((zerop (mod r 4)) +blue+)
				     (t +black+))))
	(loop for c from (min 0 min-m) to (max 0 (1+ max-m))
	      for x from 0 do
	      (draw-line* pane
			  (+ 40 (* x zoom))
			  30
			  (+ 40 (* x zoom))
			  (+ 50 (* (- (max 0 (1+ max-n)) (min 0 min-n)) zoom))
			  :ink (cond ((zerop c) +red+)
				     ((zerop (mod c 4)) +blue+)
				     (t +black+))))))))

(defun viewer ()
  (loop for port in climi::*all-ports*
      do (destroy-port port))
  (setq climi::*all-ports* nil)
  (let ((frame (make-application-frame 'gf-viewer)))
    (run-frame-top-level frame)))  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Commands

(define-gf-viewer-command (com-load-file :name t) ((filename 'string))
  (let ((frame *application-frame*))
    (setf (viewer-font frame) (parse-gf-file filename))
    (setf (viewer-chars frame)
	  (coerce (reverse (gf-font-chars (viewer-font frame)))
		  'vector))
    (setf (viewer-pixmaps frame)
	  (make-array (list (length (viewer-chars frame))) :initial-element nil))
    (setf (viewer-index frame)
	  (min (1- (length (viewer-chars frame)))
	       (viewer-index frame)))))

(define-gf-viewer-command (com-quit :name t) ()
  (frame-exit *application-frame*))

(define-gf-viewer-command (com-next-char :name t) ()
  (setf (viewer-index *application-frame*)
	(min (1- (length (viewer-chars *application-frame*)))
	     (1+ (viewer-index *application-frame*)))))

(define-gf-viewer-command (com-prev-char :name t) ()
  (setf (viewer-index *application-frame*)
	(max 0 (1- (viewer-index *application-frame*)))))

(define-gf-viewer-command (com-goto-char :name t) ((i 'integer))
  (setf (viewer-index *application-frame*) i))

(define-gf-viewer-command (com-zoom-in :name t) ()
  (incf (viewer-zoom *application-frame*)))

(define-gf-viewer-command (com-zoom-out :name t) ()
  (setf (viewer-zoom *application-frame*)
	(max (1- (viewer-zoom *application-frame*)) 1)))

(define-gf-viewer-command (com-zoom-to :name t) ((i 'integer))
  (setf (viewer-zoom *application-frame*)
	(max i 1)))

(define-gf-viewer-command (com-grid-on :name t :keystroke (#\n :control)) ()
  (setf (viewer-grid *application-frame*) t))

(define-gesture-name :stuff :keyboard (#\o :control))

(define-presentation-action stuff
    (blank-area nil gf-viewer
		:documentation "Stuff stuff"
		:menu nil
		:gesture :stuff)
  ()
  (format t "hi there~%"))

(define-gf-viewer-command (com-grid-off :name t :keystroke (#\f :control)) ()
  (setf (viewer-grid *application-frame*) nil))

