(in-package :gsharp-cursor)

(defmacro defcclass (name base slots)
  `(progn 
     (define-stealth-mixin ,name () ,base
       ((cursors :initform '() :accessor cursors)
	,@slots))))

;;; For easy access, we hang the cursor in it bar (it is always in
;;; some bar), in the slice of the bar, in the layer of the slice, and
;;; in the segment of the layer.

(defclass gsharp-cursor ()
  ((bar :initarg :bar :accessor bar)
   (pos :initarg :pos :accessor pos)))

(defun make-cursor (bar pos)
  (let ((result (make-instance 'gsharp-cursor :bar bar :pos pos)))
    (set-cursor result bar pos)
    result))

;;; Set the cursor to the particular position in the bar.
;;; The cursor is assumed not to be inserted on any item above
;;; the bar, so it has to be inserted there.
(defgeneric set-cursor (cursor bar position))

;;; Remove the cursor from the list of cursors of all the items above
;;; the bar.
(defgeneric unset-cursor (cursor))

(defmethod set-cursor ((cursor gsharp-cursor) (bar bar) position)
  (let* ((slice (slice bar))
	 (layer (layer slice))
	 (segment (segment layer)))
    (setf (bar cursor) bar
	  (pos cursor) position)
    (push cursor (cursors bar))
    (push cursor (cursors slice))
    (push cursor (cursors layer))
    (push cursor (cursors segment))))

(defmethod unset-cursor ((cursor gsharp-cursor))
  (let* ((bar (bar cursor))
	 (slice (slice bar))
	 (layer (layer slice))
	 (segment (segment layer)))
    (setf (cursors bar) (delete cursor (cursors bar) :test #'eq)
	  (cursors slice) (delete cursor (cursors slice) :test #'eq)
	  (cursors layer) (delete cursor (cursors layer) :test #'eq)
	  (cursors segment) (delete cursor (cursors segment) :test #'eq)
	  (bar cursor) nil)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Element

(defgeneric end-of-bar-p (cursor))

(defgeneric beginning-of-bar-p (cursor))
  
(defgeneric forward-element (cursor))

(defgeneric backward-element (cursor))

(defmethod end-of-bar-p ((cursor gsharp-cursor))
  (= (pos cursor)
     (nb-elements (bar cursor))))

(defmethod beginning-of-bar-p ((cursor gsharp-cursor))
  (zerop (pos cursor)))

(defmethod forward-element ((cursor gsharp-cursor))
  (if (= (pos cursor) (nb-elements (bar cursor)))
      (forward-bar cursor)
      (incf (pos cursor))))

(defmethod backward-element ((cursor gsharp-cursor))
  (if (zerop (pos cursor))
      (backward-bar cursor)
      (decf (pos cursor))))

(defmethod cursor-element ((cursor gsharp-cursor))
  (with-accessors ((bar bar) (pos pos)) cursor	
    (when (< pos (nb-elements bar))
      (elementno bar pos))))

(define-condition not-on-a-cluster (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "No current cluster"))))

(defmethod current-cluster ((cursor gsharp-cursor))
  (assert (not (beginning-of-bar-p cursor)) () 'not-on-a-cluster)
  (with-accessors ((bar bar) (pos pos)) cursor
    (let ((element (elementno bar (1- pos))))
      (assert (and element (typep element 'cluster)) () 'not-on-a-cluster)
      element)))

(define-condition not-on-an-element (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "No current element"))))

(defmethod current-element ((cursor gsharp-cursor))
  (assert (not (beginning-of-bar-p cursor)) () 'not-on-an-element)
  (with-accessors ((bar bar) (pos pos)) cursor
    (let ((element (elementno bar (1- pos))))
      (assert (and element (typep element 'element)) () 'not-on-an-element)
      element)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Bar

(defgeneric last-bar-p (cursor))

(defgeneric first-bar-p (cursor))

(defgeneric forward-bar (cursor))

(defgeneric backward-bar (cursor))

(defgeneric insert-element (element cursor))

(defgeneric delete-element (cursor))

(defmethod last-bar-p ((cursor gsharp-cursor))
  (let ((bar (bar cursor)))
    (eq bar (car (last (bars (slice bar)))))))

(defmethod first-bar-p ((cursor gsharp-cursor))
  (let ((bar (bar cursor)))
    (eq bar (car (bars (slice bar))))))

(define-condition in-last-bar (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "In last bar"))))

(defmethod forward-bar ((cursor gsharp-cursor))
  (assert (not (last-bar-p cursor)) () 'in-last-bar)
  (let ((newbar (barno (slice (bar cursor)) (1+ (number (bar cursor))))))
    (unset-cursor cursor)
    (set-cursor cursor newbar 0)))

(define-condition in-first-bar (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "In first bar"))))

(defmethod backward-bar ((cursor gsharp-cursor))
  (assert (not (first-bar-p cursor)) () 'in-first-bar)
  (let ((newbar (barno (slice (bar cursor)) (1- (number (bar cursor))))))
    (unset-cursor cursor)
    (set-cursor cursor newbar (nb-elements newbar))))

(defcclass cbar bar
  ())

(defmethod add-element :after ((element element) (bar cbar) position)
  (loop for cursor in (cursors bar) do
	(when (> (pos cursor) position)
	  (incf (pos cursor)))))

(defmethod add-element :after ((element staffwise-element) bar position)
  (let ((staff (staff element)))
    (setf (staffwise-elements staff)
	  (merge 'list (list element) (staffwise-elements staff) 
		 (lambda (x y) (gsharp::starts-before-p x (bar y) y))))))

(defmethod remove-element :before ((element element) (bar cbar))
  (let ((elemno (number element)))
    (loop for cursor in (cursors bar) do
	  (when (> (pos cursor) elemno)
	    (decf (pos cursor))))))

(defmethod insert-element ((element element) (cursor gsharp-cursor))
  (add-element element (bar cursor) (pos cursor)))

(define-condition end-of-bar (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "End of bar"))))

(define-condition beginning-of-bar (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Beginning of bar"))))

(defmethod delete-element ((cursor gsharp-cursor))
  (assert (not (end-of-bar-p cursor)) () 'end-of-bar)
  (let ((bar (bar cursor)))
    (remove-element (elementno bar (pos cursor)) bar)))

(defmethod cursor-bar ((cursor gsharp-cursor))
  (bar cursor))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Slice

(defmethod slice ((cursor gsharp-cursor))
  (slice (bar cursor)))

(defgeneric first-slice-p (cursor))

(defgeneric last-slice-p (cursor))

(defgeneric forward-slice (cursor))

(defgeneric backward-slice (cursor))

(defgeneric head-slice (cursor))

(defgeneric body-slice (cursor))

(defgeneric tail-slice (cursor))

(defgeneric insert-bar-before (bar cursor))

(defgeneric insert-bar-after (bar cursor))

(defgeneric delete-bar (cursor))

(defmethod first-slice-p ((cursor gsharp-cursor))
  (let ((slice (slice (bar cursor))))
    (eq slice (head (layer slice)))))

(defmethod last-slice-p ((cursor gsharp-cursor))
  (let ((slice (slice (bar cursor))))
    (eq slice (tail (layer slice)))))

(define-condition in-last-slice (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Attempt to go forward from last slice"))))

(defmethod forward-slice ((cursor gsharp-cursor))
  (assert (not (last-slice-p cursor)) () 'in-last-slice)
  (let* ((oldslice (slice (bar cursor)))
	 (oldsliceno (number oldslice))
	 (newslice (sliceno (layer oldslice) (1+ oldsliceno)))
	 (newbar (barno newslice 0)))
    (unset-cursor cursor)
    (set-cursor cursor newbar 0)))

(define-condition in-first-slice (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Attempt to go backward from first slice"))))

(defmethod backward-slice ((cursor gsharp-cursor))
  (assert (not (first-slice-p cursor)) () 'in-first-slice)
  (let* ((oldslice (slice (bar cursor)))
	 (oldsliceno (number oldslice))
	 (newslice (sliceno (layer oldslice) (1- oldsliceno)))
	 (newbar (barno newslice (1- (nb-bars newslice))))
	 (newpos (nb-elements newbar)))
    (unset-cursor cursor)
    (set-cursor cursor newbar newpos)))

(defmethod head-slice ((cursor gsharp-cursor))
  (let* ((oldslice (slice (bar cursor)))
	 (newslice (head (layer oldslice)))
	 (newbar (barno newslice 0)))
    (unset-cursor cursor)
    (set-cursor cursor newbar 0)))

(defmethod body-slice ((cursor gsharp-cursor))
  (let* ((oldslice (slice (bar cursor)))
	 (newslice (body (layer oldslice)))
	 (newbar (barno newslice 0)))
    (unset-cursor cursor)
    (set-cursor cursor newbar 0)))

(defmethod tail-slice ((cursor gsharp-cursor))
  (let* ((oldslice (slice (bar cursor)))
	 (newslice (tail (layer oldslice)))
	 (newbar (barno newslice 0)))
    (unset-cursor cursor)
    (set-cursor cursor newbar 0)))

(defcclass cslice slice
  ())

(defmethod remove-bar :around ((bar cbar))
  (let* ((cursors (cursors bar))
	 (barno (number bar))
	 (slice (slice bar))
	 (nb-bars (nb-bars slice)))
    (call-next-method)
    (flet ((set-cursors (bar position)
	     (loop for cursor in cursors do
		   (setf (bar cursor) bar
			 (pos cursor) position))
	     (setf (cursors bar) (append cursors (cursors bar)))))
      (if (> nb-bars (1+ barno))
	  (set-cursors (barno slice barno) 0)
	  (let ((bar (barno slice (1- barno))))
	    (set-cursors bar (nb-elements bar)))))))	    

(defmethod insert-bar-before ((bar bar) (cursor gsharp-cursor))
  (let ((cursor-bar (bar cursor)))
    (add-bar bar (slice cursor-bar) (number cursor-bar))))
  
(defmethod insert-bar-after ((bar bar) (cursor gsharp-cursor))
  (let ((cursor-bar (bar cursor)))
    (add-bar bar (slice cursor-bar) (1+ (number cursor-bar)))))
  
(defmethod delete-bar ((cursor gsharp-cursor))
  (assert (not (last-bar-p cursor)) () 'in-last-bar)
  (remove-bar (bar cursor)))

(defmethod cursor-slice ((cursor gsharp-cursor))
  (slice (bar cursor)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Layer

(defmethod layer ((cursor gsharp-cursor))
  (layer (slice cursor)))

(defgeneric select-layer (cursor new-layer))

(defmethod select-layer ((cursor gsharp-cursor) (new-layer layer))
  (let* ((oldbar (bar cursor))
	 (oldbarno (number oldbar))
	 (oldslice (slice oldbar))
	 (oldsliceno (number oldslice))
	 (newslice (sliceno new-layer oldsliceno))
	 (newbarno (min (1- (nb-bars newslice)) oldbarno))
	 (newbar (barno newslice newbarno)))
    (unset-cursor cursor)
    (set-cursor cursor newbar (nb-elements newbar))))

(defcclass clayer layer
  ())

(defmethod cursor-layer ((cursor gsharp-cursor))
  (layer (cursor-slice cursor)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Segment

(defmethod segment ((cursor gsharp-cursor))
  (segment (layer cursor)))

(defgeneric delete-layer (cursor))

(defcclass csegment segment
  ())

(defmethod remove-layer :around ((layer clayer))
  (let* ((layerno (number layer))
	 (cursors (cursors layer))
	 (segment (segment layer))
	 (nb-layers (nb-layers segment))
	 (newlayer nil))
    (call-next-method)
    (flet ((set-cursor (cursor)
             (push cursor (cursors newlayer))
	     (let* ((slice (sliceno newlayer (number (slice (bar cursor)))))
		    (barno (min (1- (nb-bars slice)) (number (bar cursor))))
		    (bar (barno slice barno)))
	       (push cursor (cursors slice))
	       (push cursor (cursors bar))
	       (setf (bar cursor) bar)
	       (setf (pos cursor) 0))))
      (setf newlayer (layerno segment (if (> nb-layers (1+ layerno))
					  layerno
					  (1- layerno))))
      (mapc #'set-cursor cursors))))

(defmethod delete-layer ((cursor gsharp-cursor))
  (remove-layer (cursor-layer cursor)))

(defmethod cursor-segment ((cursor gsharp-cursor))
  (segment (cursor-layer cursor)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Buffer

(defmethod buffer ((cursor gsharp-cursor))
  (buffer (segment cursor)))

(defgeneric first-segment-p (cursor))

(defgeneric last-segment-p (cursor))

(defgeneric forward-segment (cursor))

(defgeneric backward-segment (cursor))

(defgeneric insert-segment-before (segment cursor))

(defgeneric insert-segment-after (segment cursor))

(defgeneric delete-segment (cursor))

(defmethod remove-segment :around ((segment csegment))
  (let* ((segno (number segment))
	 (cursors (cursors segment))
	 (buffer (buffer segment))
	 (nb-segments (nb-segments buffer)))
    (call-next-method)
    (flet ((set-cursors (segment layer slice bar position)
	     (loop for cursor in cursors do
		   (setf (bar cursor) bar
			 (pos cursor) position))
	     (setf (cursors segment) (append cursors (cursors segment))
		   (cursors layer) (append cursors (cursors layer))
		   (cursors slice) (append cursors (cursors slice))
		   (cursors bar) (append cursors (cursors bar)))))
      (if (or (> nb-segments (1+ segno)) (zerop segno))
	  (let* ((segment (segmentno buffer segno))
		 (layer (car (layers segment)))
		 (slice (body layer))
		 (bar (car (bars slice))))
	    (set-cursors segment layer slice bar 0))
	  (let* ((segment (segmentno buffer (1- segno)))
		 (layer (car (layers segment)))
		 (slice (body layer))
		 (bar (car (last (bars slice))))
		 (position (nb-elements bar)))
	    (set-cursors segment layer slice bar position))))))

(defmethod first-segment-p ((cursor gsharp-cursor))
  (let ((segment (cursor-segment cursor)))
    (eq segment (car (segments (buffer segment))))))

(defmethod last-segment-p ((cursor gsharp-cursor))
  (let ((segment (cursor-segment cursor)))
    (eq segment (car (last (segments (buffer segment)))))))

(define-condition in-last-segment (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Attempt to go forward from last segment"))))

(defmethod forward-segment ((cursor gsharp-cursor))
  (assert (not (last-segment-p cursor)) () 'in-last-segment)
  (let* ((oldsegment (segment (layer (slice (bar cursor)))))
	 (oldsegmentno (number oldsegment))
	 (buffer (buffer oldsegment))
	 (newsegmentno (1+ oldsegmentno))
	 (newsegment (segmentno buffer newsegmentno))
	 (newlayer (layerno newsegment 0))
	 (newslice (body newlayer))
	 (newbar (barno newslice 0)))
    (unset-cursor cursor)
    (set-cursor cursor newbar 0)))

(define-condition in-first-segment (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Attempt to go backward from first segment"))))

(defmethod backward-segment ((cursor gsharp-cursor))
  (assert (not (first-segment-p cursor)) () 'in-first-segment)
  (let* ((oldsegment (segment (layer (slice (bar cursor)))))
	 (oldsegmentno (number oldsegment))
	 (buffer (buffer oldsegment))
	 (newsegmentno (1- oldsegmentno))
	 (newsegment (segmentno buffer newsegmentno))
	 (newlayer (layerno newsegment 0))
	 (newslice (body newlayer))
	 (newbarno (1- (nb-bars newslice)))
	 (newbar (barno newslice newbarno))
	 (newpos (nb-elements newbar)))
    (unset-cursor cursor)
    (set-cursor cursor newbar newpos)))

(defmethod insert-segment-before ((segment segment) (cursor gsharp-cursor))
  (let ((cursor-seg (cursor-segment cursor)))
    (add-segment segment (buffer cursor-seg) (number cursor-seg))))

(defmethod insert-segment-after ((segment segment) (cursor gsharp-cursor))
  (let ((cursor-seg (cursor-segment cursor)))
    (add-segment segment (buffer cursor-seg) (1+ (number cursor-seg)))))

(defmethod delete-segment ((cursor gsharp-cursor))
  (remove-segment (cursor-segment cursor)))

(defmethod cursor-buffer ((cursor gsharp-cursor))
  (buffer (cursor-segment cursor)))
