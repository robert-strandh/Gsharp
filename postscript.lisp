(in-package :gsharp)

(defclass postscript-pane-mixin  ()
  ((transformation-stack :initform '())
   (subpaths :initform nil)))

(in-package :gsharp-postscript)

(defun needs-decomposition (tr x1 y1 x2 y2 x3 y3 x4 y4)
  (climi::with-transformed-position (tr x1 y1)
    (climi::with-transformed-position (tr x2 y2)
      (climi::with-transformed-position (tr x3 y3)
        (climi::with-transformed-position (tr x4 y4)
          (let ((dx12 (- x2 x1))
		(dy12 (- y2 y1))
		(dx23 (- x3 x2))
		(dy23 (- y3 y2))
		(dx34 (- x4 x3))
		(dy34 (- y4 y3))
		(dx14 (- x4 x1))
		(dy14 (- y4 y1)))
	    (> (- (+ (sqrt (+ (* dx12 dx12)
			      (* dy12 dy12)))
		     (sqrt (+ (* dx23 dx23)
			      (* dy23 dy23)))
		     (sqrt (+ (* dx34 dx34)
			      (* dy34 dy34))))
		  (sqrt (+ (* dx14 dx14)
			   (* dy14 dy14))))
	       1)))))))

(defun bezier-to-polyline (tr x1 y1 x2 y2 x3 y3 x4 y4 coord-seq)
  (if (needs-decomposition tr x1 y1 x2 y2 x3 y3 x4 y4)
      (let ((x12 (* 0.5 (+ x1 x2)))
	    (y12 (* 0.5 (+ y1 y2)))
	    (x23 (* 0.5 (+ x2 x3)))
	    (y23 (* 0.5 (+ y2 y3)))
	    (x34 (* 0.5 (+ x3 x4)))
	    (y34 (* 0.5 (+ y3 y4))))
	(let ((x123 (* 0.5 (+ x12 x23)))
	      (y123 (* 0.5 (+ y12 y23)))
	      (x234 (* 0.5 (+ x23 x34)))
	      (y234 (* 0.5 (+ y23 y34))))
	  (let ((x1234 (* 0.5 (+ x123 x234)))
		(y1234 (* 0.5 (+ y123 y234))))
	    (bezier-to-polyline
	     tr x1 y1 x12 y12 x123 y123 x1234 y1234
	     (bezier-to-polyline
	      tr x1234 y1234 x234 y234 x34 y34 x4 y4 coord-seq)))))
      (climi::with-transformed-position (tr x4 y4)
        (cons x4 (cons y4 coord-seq)))))

(defclass ps-segment ()
  ())

(defclass line-segment (ps-segment)
  ((x :initarg :x :reader end-x)
   (y :initarg :y :reader end-y)))

(defun make-line-segment (x y)
  (make-instance 'line-segment :x x :y y))

(defmethod convert-segment (tr (segment line-segment) coord-seq x0 y0)
  (declare (ignore x0 y0))
  (with-slots (x y) segment
    (multiple-value-bind (x y) (transform-position tr x y)
      (cons x (cons y coord-seq)))))

(defclass bezier-segment (ps-segment)
  ((x1 :initarg :x1)
   (y1 :initarg :y1)
   (x2 :initarg :x2)
   (y2 :initarg :y2)
   (x3 :initarg :x3 :reader end-x)
   (y3 :initarg :y3 :reader end-y)))

(defun make-bezier-segment (x1 y1 x2 y2 x3 y3)
  (make-instance 'bezier-segment
		 :x1 x1 :y1 y1 :x2 x2 :y2 y2 :x3 x3 :y3 y3))

(defmethod convert-segment (tr (segment bezier-segment) coord-seq x0 y0)
  (with-slots (x1 y1 x2 y2 x3 y3) segment
    (bezier-to-polyline tr x0 y0 x1 y1 x2 y2 x3 y3 coord-seq)))

;;; A subpath defined as the concatenation of segments
(defclass postscript-subpath ()
  ((origin-x :initarg :x)
   (origin-y :initarg :y)
   (elements :initform '())))

(defun make-postscript-subpath (x y)
  (make-instance 'postscript-subpath :x x :y y))

;;; check whether a subpath is closed
(defun closed-p (subpath)
  (with-slots (origin-x origin-y elements) subpath
    (and elements
	 (eql (end-x (car elements)) origin-x)
	 (eql (end-y (car elements)) origin-y))))

;;; check whether a subpath is empty
(defun empty-p (subpath)
  (null (slot-value subpath 'elements)))

;;; close a subpath unless it is already closed
;;; the subpath must not be empty
(defun close-path (subpath)
  (assert (not (empty-p subpath)))
  (unless (closed-p subpath)
    (with-slots (origin-x origin-y) subpath
      (add-seg (make-line-segment origin-x origin-y) subpath))))

(defun add-seg (seg subpath)
  (push seg (slot-value subpath 'elements)))

(defun ps-path-to-polyline (transformation ps-path)
  (with-slots (subpaths) ps-path
    ;; if entire path is empty, do nothing
    (unless (null subpaths)
      ;; last subpath may be empty.  If so, remove it
      (when (empty-p (car subpaths))
	(pop subpaths))
      ;; if entire path is empty, do nothing
      (unless (null subpaths)
	;; close each subpath in conformance with the PS spec
	(mapc #'close-path subpaths)
	;; make a giant polygon of the entire path
	;; first make sure polygon ends where it started
	(let ((coord-seq '()))
	  (loop for subpath in (cdr subpaths) do
		(with-slots (origin-x origin-y) subpath
		  (climi::with-transformed-position (transformation origin-x origin-y)
		    (push origin-x coord-seq)
		    (push origin-y coord-seq))))
	  (setf coord-seq (nreverse coord-seq))
	  ;; convert each subpath to a sequence of line segments
	  (loop for subpath in subpaths do
		(with-slots (origin-x origin-y elements) subpath
		  ;; no subpath is empty now
		  (loop for sublist on elements do
			(setf coord-seq 
			      (if (null (cdr sublist))
				  (convert-segment transformation (car sublist)
						   coord-seq
						   origin-x
						   origin-y)
				  (convert-segment transformation (car sublist)
						   coord-seq
						   (end-x (cadr sublist))
						   (end-y (cadr sublist))))))
		  (climi::with-transformed-position (transformation origin-x origin-y)
		    (push origin-y coord-seq)
		    (push origin-x coord-seq))))
	  coord-seq)))))

(defclass postscript-path (area)
  ((transformation-stack :initform '())
   (subpaths :initform nil)))

(defun make-postscript-path ()
  (make-instance 'postscript-path))

(defmethod draw-design (sheet (design postscript-path)
			&rest drawing-options
			&key ink clipping-region transformation
			line-style line-thickness line-unit line-dashes
			line-joint-shape line-cap-shape
			text-style text-family text-face text-size) 
  (declare (ignore ink clipping-region transformation
		   line-style line-thickness line-unit line-dashes
		   line-joint-shape line-cap-shape
		   text-style text-family text-face text-size))
  (climi::with-medium-options (sheet drawing-options)
    (medium-draw-design medium design)))

(defmethod medium-draw-design ((sheet sheet) (design postscript-path))
  (with-sheet-medium (medium sheet)
    (medium-draw-design medium design)))

(defmethod medium-draw-design ((medium clim-clx::clx-medium) (design postscript-path))
  (let* ((tr (sheet-device-transformation (medium-sheet medium)))
	 (coord-seq (mapcar #'clim-clx::round-coordinate
			    (ps-path-to-polyline tr design))))
    (clim-clx::with-CLX-graphics (medium)
      (xlib:draw-lines clim-clx::mirror clim-clx::gc coord-seq :fill-p t))))

(defun newpath (design)
  (setf (slot-value design 'subpaths) nil))

(defun lineto (design x y)
  (let ((subpath (car (slot-value design 'subpaths))))
    (add-seg (make-line-segment x y) subpath)))

(defun curveto (design x1 y1 x2 y2 x3 y3)
  (let ((subpath (car (slot-value design 'subpaths))))
    (add-seg (make-bezier-segment x1 y1 x2 y2 x3 y3) subpath)))
  
(defun moveto (design x y)
  (with-slots (subpaths) design
    (if (and subpaths (null (slot-value (car subpaths) 'elements)))
	(with-slots (origin-x origin-y) (car subpaths)
	  (setf origin-x x origin-y y))
	(push (make-postscript-subpath x y)
	      (slot-value design 'subpaths)))))

(defun rlineto (design x y)
  (let ((subpath (car (slot-value design 'subpaths))))
    (with-slots (origin-x origin-y elements) subpath
      (let* ((element (car elements))
	     (x0 (if element (end-x element) origin-x))
	     (y0 (if element (end-y element) origin-y)))
	(add-seg (make-line-segment (+ x0 x) (+ y0 y)) subpath)))))

;;; Drawing a circle with Bezier curves:
;;; http://www.whizkidtech.net/bezier/circle/
;;; http://instruct1.cit.cornell.edu/research/graff/files/bezhowto.html

(defun circle (design x y r)
  (let ((k (* 0.5522847498 r)))
    (moveto design (- x r) y)
    (curveto design (- x r) (+ y k) (- x k) (+ y r) x (+ y r))
    (curveto design (+ x k) (+ y r) (+ x r) (+ y k) (+ x r) y)
    (curveto design (+ x r) (- y k) (+ x k) (- y r) x (- y r))
    (curveto design (- x k) (- y r) (- x r) (- y k) (- x r) y)))
