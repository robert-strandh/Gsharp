(cl:in-package #:common-lisp-user)

(defpackage :fontview
  (:use :clim :clim-extensions :clim-lisp :sdl))

(cl:in-package #:fontview)

(define-application-frame fontview ()
  ((font :initform (make-instance 'sdl::font :staff-line-distance 6))
   (shape :initarg :shape :initform :g-clef)
   (grid :initform t)
   (staff :initform t)
   (staff-offset :initform 0)
   (view :initform :antialiased)
   (zoom :initform 1)
   (hoffset :initform 300)
   (voffset :initform 300))
  (:pointer-documentation t)
  (:panes
   (fontview :application :width 800 :height 600 :display-function 'display-entry)
   (interactor :interactor :width 800 :height 100))
  (:layouts
   (default
       (vertically () fontview interactor))))

(defun display-antialiased-view (frame pane)
  (with-slots (font shape staff staff-offset hoffset voffset) frame
    (with-translation (pane hoffset voffset)
      (sdl::draw-shape pane font shape 0 0)
      (when staff
	(with-slots ((slt sdl::staff-line-thickness)
		     (sld sdl::staff-line-distance)
		     (yoff sdl::yoffset))
	    font
	  (let ((up (round (+ (* 0.5 slt) yoff)))
		(down (round (- (* 0.5 slt) yoff))))
	    (loop repeat 5
		  for y from (* (+ -2 (* 1/2 staff-offset)) sld) by sld
		  do (draw-rectangle* pane
				      (* -10 sld) (- y up)
				      (* 10 sld) (+ y down)))))))))

(defun display-pixel-view (frame pane)
  (with-slots (font shape grid zoom hoffset voffset) frame
    (with-translation (pane hoffset voffset)
      (let ((design (sdl::ensure-design font shape)))
	(multiple-value-bind (min-x min-y max-x max-y) (bounding-rectangle* design)
	  (setf min-x (* 4 (floor min-x))
		min-y (* 4 (floor min-y))
		max-x (* 4 (ceiling max-x))
		max-y (* 4 (ceiling max-y)))
	  (let ((array (climi::render-to-array design)))
	    (loop for y from min-y below max-y
		  for y-index from 0
		  do (loop with x0 = nil
			   for x from min-x below max-x
			   for x-index from 0
			   do (if (zerop (aref array y-index x-index))
				  (when (null x0)
				    (setf x0 x))
				  (unless (null x0)
				    (draw-rectangle* pane (* x0 zoom) (* y zoom) (* x zoom) (* (1+ y) zoom))
				    (setf x0 nil)))
			   finally (unless (null x0)
				     (draw-rectangle* pane (* x0 zoom) (* y zoom) (* x zoom) (* (1+ y) zoom)))))
	    (when grid
	      (loop for y downfrom 0 above -300 by (* 4 zoom)
		    do (draw-rectangle* pane -300 y 300 (1+ y) :ink +blue+))
	      (loop for y from 0 below 300 by (* 4 zoom)
		    do (draw-rectangle* pane -300 y 300 (1+ y) :ink +blue+))
	      (loop for x downfrom 0 above -300 by (* 4 zoom)
		    do (draw-rectangle* pane x -300 (1+ x) 300 :ink +blue+))
	      (loop for x from 0 below 300 by (* 4 zoom)
		    do (draw-rectangle* pane x -300 (1+ x) 300 :ink +blue+))
	      ;; draw the bounding rectangle
	      (draw-rectangle* pane
			       (* zoom min-x) (* zoom min-y)
			       (* zoom max-x) (1+ (* zoom min-y))
			       :ink +red+)
	      (draw-rectangle* pane
			       (* zoom min-x) (* zoom max-y)
			       (* zoom max-x) (1+ (* zoom max-y))
			       :ink +red+)
	      (draw-rectangle* pane
			       (* zoom min-x) (* zoom min-y)
			       (1+ (* zoom min-x)) (* zoom max-y)
			       :ink +red+)
	      (draw-rectangle* pane
			       (* zoom max-x) (* zoom min-y)
			       (1+ (* zoom max-x)) (* zoom max-y)
			       :ink +red+)
	      ;; draw the reference point
	      (draw-rectangle* pane -300 0 300 1 :ink +red+)
	      (draw-rectangle* pane 0 -300 1 300 :ink +red+))))))))

(defun display-entry (frame pane)
  (with-slots (view) frame
    (if (eq view :antialiased)
	(display-antialiased-view frame pane)
	(display-pixel-view frame pane))))

(defun fontview (&optional (shape :g-clef))
  (let ((frame (make-application-frame 'fontview :shape shape)))
    (run-frame-top-level frame)))  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Commands

(define-fontview-command (com-quit :name t) ()
  (frame-exit *application-frame*))

(define-fontview-command (com-show :name t) ((symbol 'symbol))
  (with-slots (shape) *application-frame*
    (setf shape symbol)))

(define-fontview-command (com-zoom-in :name t :keystroke (#\i :control)) ()
  (with-slots (zoom) *application-frame*
    (when (< zoom 10) (incf zoom))))

(define-fontview-command (com-zoom-out :name t :keystroke (#\i :control)) ()
  (with-slots (zoom) *application-frame*
    (when (> zoom 1) (decf zoom))))

(define-fontview-command (com-zoom-to :name t) ((i 'integer))
  (with-slots (zoom) *application-frame*
    (setf zoom (min (max i 1) 10))))

(define-fontview-command (com-size :name t) ((i 'integer))
  (with-slots (font) *application-frame*
    (when (oddp i) (incf i))
    (setf font (make-instance 'sdl::font :staff-line-distance (min (max i 6) 20)))))

(define-fontview-command (com-grid-on :name t) ()
  (with-slots (grid) *application-frame*
    (setf grid t)))

(define-fontview-command (com-grid-off :name t) ()
  (with-slots (grid) *application-frame*
    (setf grid nil)))

(define-fontview-command (com-staff-on :name t) ()
  (with-slots (staff) *application-frame*
    (setf staff t)))

(define-fontview-command (com-staff-off :name t) ()
  (with-slots (staff) *application-frame*
    (setf staff nil)))

(define-fontview-command (com-staff-up :name t) ()
  (with-slots (staff-offset) *application-frame*
    (when (> staff-offset -4)
      (decf staff-offset))))

(define-fontview-command (com-staff-down :name t) ()
  (with-slots (staff-offset) *application-frame*
    (when (< staff-offset 4)
      (incf staff-offset))))

(define-fontview-command (com-staff-middle :name t) ()
  (with-slots (staff-offset) *application-frame*
    (setf staff-offset 0)))

(define-fontview-command (com-pixel-view :name t) ()
  (with-slots (view) *application-frame*
    (setf view :pixel)))

(define-fontview-command (com-antialiased-view :name t) ()
  (with-slots (view) *application-frame*
    (setf view :antialiased)))

