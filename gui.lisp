(in-package :gsharp)

(defun make-initial-cursor (buffer)
  (let* ((segment (segmentno buffer 0))
	 (layer (layerno segment 0))
	 (slice (body layer))
	 (bar (barno slice 0)))
  (make-cursor bar 0)))

(defparameter *global-command-table* (make-hash-table :test #'equal))
(defparameter *x-command-table* (make-hash-table :test #'equal))
(defparameter *i-command-table* (make-hash-table :test #'equal))
(defparameter *ix-command-table* (make-hash-table :test #'equal))
(defparameter *c-x-command-table* (make-hash-table :test #'equal))
(defparameter *commands* *global-command-table*)

(defun add-command (gesture command table)
  (setf (gethash (list (car gesture) (apply #'make-modifier-state (cdr gesture)))
		 table)
	command))	

;;; global command table

(add-command '(#\L :shift) 'com-lower *global-command-table*)
(add-command '(#\H :shift) 'com-higher *global-command-table*)
(add-command '(#\f :control) 'com-forward-element *global-command-table*)
(add-command '(#\b :control) 'com-backward-element *global-command-table*)
(add-command '(#\d :control) 'com-delete-element *global-command-table*)
(add-command '(#\h :control) 'com-erase-element *global-command-table*)
(add-command '(#\c) 'com-insert-note-c *global-command-table*)
(add-command '(#\d) 'com-insert-note-d *global-command-table*)
(add-command '(#\e) 'com-insert-note-e *global-command-table*)
(add-command '(#\f) 'com-insert-note-f *global-command-table*)
(add-command '(#\g) 'com-insert-note-g *global-command-table*)
(add-command '(#\a) 'com-insert-note-a *global-command-table*)
(add-command '(#\b) 'com-insert-note-b *global-command-table*)
(add-command '(#\,) 'com-insert-rest *global-command-table*)
(add-command '(#\Space) 'com-insert-empty-cluster *global-command-table*)
(add-command '(#\C :shift) 'com-add-note-c *global-command-table*)
(add-command '(#\D :shift) 'com-add-note-d *global-command-table*)
(add-command '(#\E :shift) 'com-add-note-e *global-command-table*)
(add-command '(#\F :shift) 'com-add-note-f *global-command-table*)
(add-command '(#\G :shift) 'com-add-note-g *global-command-table*)
(add-command '(#\A :shift) 'com-add-note-a *global-command-table*)
(add-command '(#\B :shift) 'com-add-note-b *global-command-table*)
(add-command '(#\h :meta) 'com-rotate-notehead *global-command-table*)
(add-command '(#\s :meta) 'com-rotate-stem-direction *global-command-table*)
(add-command '(#\p) 'com-current-increment *global-command-table*)
(add-command '(#\n) 'com-current-decrement *Global-command-table*)
(add-command '(#\| :shift) 'com-insert-measure-bar *global-command-table*)
(add-command '(#\.) 'com-more-dots *global-command-table*)
(add-command '(#\[) 'com-more-lbeams *global-command-table*)
(add-command '(#\]) 'com-more-rbeams *global-command-table*)
(add-command '(#\#) 'com-sharper *global-command-table*)
(add-command '(#\# :shift) 'com-sharper *global-command-table*)
(add-command '(#\@ :shift) 'com-flatter *global-command-table*)
(add-command '(#\# :meta) 'com-more-sharps *global-command-table*)
(add-command '(#\# :meta :shift) 'com-more-sharps *global-command-table*)
(add-command '(#\@ :meta :shift) 'com-more-flats *global-command-table*)
(add-command '(#\u :meta) 'com-up *global-command-table*)
(add-command '(#\d :meta) 'com-down *global-command-table*)
(add-command '(#\l :meta) 'com-left *global-command-table*)
(add-command '(#\r :meta) 'com-right *global-command-table*)
(add-command '(#\p :meta) 'com-previous-layer *global-command-table*)
(add-command '(#\n :meta) 'com-next-layer *global-command-table*)
(add-command '(#\x) *x-command-table* *global-command-table*)
(add-command '(#\i) *i-command-table* *global-command-table*)
(add-command '(#\x :control) *c-x-command-table* *global-command-table*)

;;; i command table
(add-command '(#\.) 'com-istate-more-dots *i-command-table*)
(add-command '(#\[) 'com-istate-more-lbeams *i-command-table*)
(add-command '(#\]) 'com-istate-more-rbeams *i-command-table*)
(add-command '(#\h) 'com-istate-rotate-notehead *i-command-table*)
(add-command '(#\s) 'com-istate-rotate-stem-direction *i-command-table*)
(add-command '(#\x) *ix-command-table* *i-command-table*)

;;; ix command table
(add-command '(#\.) 'com-istate-fewer-dots *ix-command-table*)
(add-command '(#\[) 'com-istate-fewer-lbeams *ix-command-table*)
(add-command '(#\]) 'com-istate-fewer-rbeams *ix-command-table*)

;;; x-command-table
(add-command '(#\.) 'com-fewer-dots *x-command-table*)
(add-command '(#\[) 'com-fewer-lbeams *x-command-table*)
(add-command '(#\]) 'com-fewer-rbeams *x-command-table*)

;;; c-x-command-table
(add-command '(#\( :shift) 'com-start-kbd-macro *c-x-command-table*)
(add-command '(#\() 'com-start-kbd-macro *c-x-command-table*)
(add-command '(#\) :shift) 'com-end-kbd-macro *c-x-command-table*)
(add-command '(#\)) 'com-end-kbd-macro *c-x-command-table*)
(add-command '(#\e) 'com-call-last-kbd-macro *c-x-command-table*)

(defmethod redisplay-gsharp-panes (frame &key force-p)
  (loop for pane in (frame-current-panes frame)
	do (when (typep pane 'score-pane:score-pane)
	     (redisplay-frame-pane frame pane :force-p force-p))))

(defvar *gsharp-frame*)

(defparameter *kbd-macro-recording-p* nil)
(defparameter *kbd-macro-funs* '())

(defmethod dispatch-event :around ((pane score-pane:score-pane) (event key-press-event))
  (when (keyboard-event-character event)
    (let* ((key (list (keyboard-event-character event)
		      (event-modifier-state event)))
	   (command (gethash key *commands*)))
      (cond ((hash-table-p command) (setf *commands* command))
	    ((fboundp command)
	     (when *kbd-macro-recording-p* (push command *kbd-macro-funs*))
	     (handler-case (funcall command)
	       (gsharp-condition (condition) (format *error-output* "~a~%" condition)))
	     (setf *commands* *global-command-table*))
	    (t (format *error-output* "no command for ~a~%" key)
	       (setf *commands* *global-command-table*)
	       (when *kbd-macro-recording-p* (setf *kbd-macro-funs* '()
						   *kbd-macro-recording-p* nil))))
      (redisplay-frame-panes *gsharp-frame*))))
	    
(define-application-frame gsharp ()
  ((buffer :initarg :buffer :accessor buffer)
   (cursor :initarg :cursor :accessor cursor)
   (input-state :initarg :input-state :accessor input-state))
  (:menu-bar menubar-command-table :height 25)
  (:pointer-documentation t)
  (:panes
   (score (make-pane 'score-pane:score-pane
		     :width 700 :height 900
		     :name "score"
		     :display-time :no-clear
		     :display-function 'display-score))
   (state (make-pane 'score-pane:score-pane
		     :width 50 :height 200
		     :name "state"
		     :display-function 'display-state))
   (element (make-pane 'score-pane:score-pane
		       :width 50 :height 700
		       :min-height 100 :max-height 20000
		       :name "element"
		       :display-function 'display-element))
   (interactor :interactor :height 100 :min-height 50 :max-height 200))
  (:layouts
   (default
     (vertically ()
       (horizontally ()
	 (scrolling (:width 750 :height 900
		     :min-height 400 :max-height 20000)
		    score)
	 (vertically ()
		     (scrolling (:width 80 :height 200) state)
		     (scrolling (:width 80 :height 700
				 :min-height 400 :max-height 20000)
				element)))
       interactor))))

(defmethod execute-frame-command :around ((frame gsharp) command)
  (handler-case (call-next-method)
    (gsharp-condition (condition) (message "~a~%" condition))))

(defmethod display-state ((frame gsharp) pane)
  (let ((state (input-state *gsharp-frame*)))
    (score-pane:with-score-pane pane
      (score-pane:with-staff-size 10
	(score-pane:with-vertical-score-position (pane 800)
	  (let ((xpos 30))
	    (score-pane:draw-notehead pane (notehead state) xpos 4)
	    (when (not (eq (notehead state) :whole))
	      (when (or (eq (stem-direction state) :auto)
			(eq (stem-direction state) :down))
		(when (eq (notehead state) :filled)
		  (score-pane:with-notehead-left-offsets (left down)
		    (declare (ignore down))
		    (let ((x (+ xpos left)))
		      (loop repeat (rbeams state)
			    for staff-step from -4 by 2 do
			    (score-pane:draw-beam pane x staff-step 0 (+ x 10) staff-step 0))
		      (loop repeat (lbeams state)
			    for staff-step from -4 by 2 do
			    (score-pane:draw-beam pane (- x 10) staff-step 0 x staff-step 0)))))
		(score-pane:draw-left-stem pane xpos (score-pane:staff-step 4) (score-pane:staff-step -4)))
	      (when (or (eq (stem-direction state) :auto)
			(eq (stem-direction state) :up))
		(when (eq (notehead state) :filled)
		  (score-pane:with-notehead-right-offsets (right up)
		    (declare (ignore up))
		    (let ((x (+ xpos right)))
		      (loop repeat (rbeams state)
			    for staff-step downfrom 12 by 2 do
			    (score-pane:draw-beam pane x staff-step 0 (+ x 10) staff-step 0))
		      (loop repeat (lbeams state)
			    for staff-step downfrom 12 by 2 do
			    (score-pane:draw-beam pane (- x 10) staff-step 0 x staff-step 0)))))
		(score-pane:draw-right-stem pane xpos (score-pane:staff-step 4) (score-pane:staff-step 12))))
	    (score-pane:with-notehead-right-offsets (right up)
	      (declare (ignore up))
	      (loop repeat (dots state)
		    for dx from (+ right 5) by 5 do
		    (score-pane:draw-dot pane (+ xpos dx) 4)))))))))

(defun draw-the-cursor (pane x)
  (let* ((state (input-state *gsharp-frame*))
	 (staff (staff state))
	 (yoffset (gsharp-drawing::staff-yoffset staff))
	 (clef (clef staff))
	 (bottom-line (- (ecase (name clef) (:treble 32) (:bass 24) (:c 35))
			 (lineno clef)))
	 (lnote-offset (score-pane:staff-step (- (last-note state) bottom-line))))
    (draw-line* pane
		x (+ (score-pane:staff-step 12) yoffset)
		x (+ (score-pane:staff-step -4) yoffset)
		:ink +yellow+)
    (draw-line* pane
		(- x 1) (+ (score-pane:staff-step -3.4) yoffset lnote-offset)
		(- x 1) (+ (score-pane:staff-step 3.6) yoffset lnote-offset)
		:ink +red+)
    (draw-line* pane
		(+ x 1) (+ (score-pane:staff-step -3.4) yoffset lnote-offset)
		(+ x 1) (+ (score-pane:staff-step 3.6) yoffset lnote-offset)
		:ink +red+)))

(defmethod display-score ((frame gsharp) pane)
  (let* ((buffer (buffer frame)))
    (recompute-measures buffer)
    (score-pane:with-score-pane pane
      (flet ((draw-cursor (x) (draw-the-cursor pane x)))
	(draw-buffer pane buffer (cursor *gsharp-frame*)
		     (left-margin buffer) 800 #'draw-cursor)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Element pane

(defmethod note-position ((note note))
  (let ((clef (clef (staff note))))
    (+ (- (pitch note)
	  (ecase (name clef) (:treble 32) (:bass 24) (:c 35)))
       (lineno clef))))

(defmethod display-element ((frame gsharp) pane)
  (when (handler-case (cur-cluster)
	  (gsharp-condition () nil))
    (score-pane:with-score-pane pane
      (score-pane:with-staff-size 10
	(score-pane:with-vertical-score-position (pane 500)
	  (let* ((xpos 30)
		 (cluster (cur-cluster))
		 (notehead (notehead cluster))
		 (rbeams (rbeams cluster))
		 (lbeams (lbeams cluster))
		 (dots (dots cluster))
		 (notes (notes cluster))
		 (stem-direction (stem-direction cluster))
		 (stem-length (stem-length cluster)))
	    (declare (ignore stem-direction stem-length notehead lbeams rbeams dots))
	    (loop for note in notes do
		  (draw-ellipse* pane xpos (* 15 (note-position note)) 7 0 0 7)
		  (score-pane:draw-accidental pane (accidentals note)
						   (- xpos (if (oddp (note-position note)) 15 25))
						   (* 3 (note-position note))))
	    (when notes
	      (draw-ellipse* pane xpos (* 15 (note-position (cur-note)))
			     7 0 0 7 :ink +red+))
	    (loop for s from 0 by 30
		  repeat 5 do
		  (draw-line* pane (- xpos 25) s (+ xpos 25) s))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; messages to the user

;;; FIXME: do this better
(defun message (format-string &rest format-args)
  (apply #'format *error-output* format-string format-args))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; menu bar

(make-command-table
 'menubar-command-table
 :errorp nil
 :menu '(("File" :menu file-command-table)
	 ("Buffer" :menu buffer-command-table)
	 ("Segment" :menu segment-command-table)
	 ("Layer" :menu layer-command-table)
	 ("Slice" :menu slice-command-table)
	 ("Measure" :menu measure-command-table)
	 ("Modes" :menu modes-command-table)
	 ("Play" :menu play-command-table)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; file menu

(make-command-table
 'file-command-table
 :errorp nil
 :menu '(("Load" :command com-load-file)
	 ("Save" :command com-save-buffer)
	 ("Save as" :command com-save-buffer-as)
	 ("Quit" :command com-quit)))

(define-gsharp-command (com-new-buffer :name t) ()
  (let* ((buffer (make-initialized-buffer))
	 (cursor (make-initial-cursor buffer))
	 (staff (car (staves buffer)))
	 (input-state (make-input-state staff)))
    (setf (buffer *gsharp-frame*) buffer
	  (cursor *gsharp-frame*) cursor
	  (input-state *gsharp-frame*) input-state
	  (staves (car (layers (car (segments buffer))))) (list staff))))

(define-presentation-type completable-pathname ()
  :inherit-from 'pathname)

(define-condition file-not-found (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "File nont found"))))

(define-presentation-method accept
    ((type completable-pathname) stream (view textual-view) &key)
  (multiple-value-bind (pathname success string)
      (complete-input stream
		      (lambda (so-far mode)
			(complete-from-possibilities
			 so-far
			 #+cmu (ext:ambiguous-files so-far) #-cmu '()
			 '()
			 :action mode
			 :predicate (lambda (obj) (declare (ignore obj)) t)
			 :name-key #'namestring
			 :value-key #'identity))
		      :allow-any-input t)
    (declare (ignore success))
    (or pathname string)))

(define-gsharp-command (com-load-file :name t) ()
  (let* ((stream (frame-standard-input *gsharp-frame*))
	 (filename (handler-case (accept 'completable-pathname :stream stream
					 :prompt "File Name")
		     (simple-parse-error () (error 'file-not-found))))
	 (buffer (read-everything filename))
	 (staff (car (staves buffer)))
	 (input-state (make-input-state staff))
	 (cursor (make-initial-cursor buffer)))
    (setf (buffer *gsharp-frame*) buffer
	  (input-state *gsharp-frame*) input-state
	  (cursor *gsharp-frame*) cursor)
    (number-all (buffer *gsharp-frame*))))

(define-gsharp-command (com-save-buffer-as :name t) ()
  (let* ((stream (frame-standard-input *gsharp-frame*))
	 (filename (handler-case (accept 'completable-pathname :stream stream
					 :prompt "File Name")
		     (simple-parse-error () (error 'file-not-found)))))
    (with-open-file (stream filename :direction :output)
      (save-buffer-to-stream (buffer *gsharp-frame*) stream)
      (message "Saved buffer to ~A~%" filename))))

(define-gsharp-command (com-quit :name t) ()
  (frame-exit *application-frame*))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; buffer menu

(make-command-table
 'buffer-command-table
 :errorp nil
 :menu '(("Play" :command com-play-buffer)
	 ("Delete Current" :command com-delete-buffer)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; segment menu

(make-command-table
 'segment-command-table
 :errorp nil
 :menu '(("Forward" :command com-forward-segment)
	 ("Backward" :command com-backward-segment)
	 ("Delete Current" :command com-delete-segment)
	 ("Insert After Current" :command com-insert-segment-after)
	 ("Insert Before Current" :command com-insert-segment-before)))

(define-gsharp-command (com-forward-segment :name t) ()
  (forward-segment (cursor *gsharp-frame*)))

(define-gsharp-command (com-backward-segment :name t) ()
  (backward-segment (cursor *gsharp-frame*)))

(define-gsharp-command (com-delete-segment :name t) ()
  (delete-segment (cursor *gsharp-frame*)))

(define-gsharp-command (com-insert-segment-before :name t) ()
  (let ((cursor (cursor *gsharp-frame*)))
    (insert-segment-before (make-initialized-segment) cursor)
    (backward-segment cursor)))

(define-gsharp-command (com-insert-segment-after :name t) ()
  (let ((cursor (cursor *gsharp-frame*)))
    (insert-segment-after (make-initialized-segment) cursor)
    (forward-segment cursor)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; layer menu

(make-command-table
 'layer-command-table
 :errorp nil
 :menu '(("Next" :command com-next-layer)
	 ("Previous" :command com-previous-layer)
	 ("Delete Current" :command com-delete-layer)
	 ("Insert After Current" :command com-insert-layer-after)
	 ("Insert Before Current" :command com-insert-layer-before)))

(define-gsharp-command (com-next-layer :name t) ()
  (next-layer (cursor *gsharp-frame*))
  (setf (staff (input-state *gsharp-frame*))
	(car (staves (layer (slice (bar (cursor *gsharp-frame*))))))))

(define-gsharp-command (com-previous-layer :name t) ()
  (previous-layer (cursor *gsharp-frame*))
  (setf (staff (input-state *gsharp-frame*))
	(car (staves (layer (slice (bar (cursor *gsharp-frame*))))))))


(define-gsharp-command (com-delete-layer :name t) ()
  (delete-layer (cursor *gsharp-frame*)))

(define-gsharp-command (com-insert-layer-before :name t) ((staff-name 'string :prompt "Staff"))
  (let ((cursor (cursor *gsharp-frame*))
	(staff (find-staff staff-name (buffer *gsharp-frame*))))
    (if (not staff)
	(message "No such staff in buffer~%")
	(progn (insert-layer-before (make-initialized-layer) cursor)
	       (previous-layer cursor)
	       (let ((layer (layer (slice (bar (cursor *gsharp-frame*))))))
		 (add-staff-to-layer staff layer)
		 (setf (staff (input-state *gsharp-frame*))
		       staff))))))

(define-gsharp-command (com-insert-layer-after :name t) ()
  (let ((cursor (cursor *gsharp-frame*))
	(staff (accept 'score-pane:staff :prompt "Staff")))
;;;	(staff (find-staff staff-name (buffer *gsharp-frame*))))
    (if (not staff)
	(message "No such staff in buffer~%")
	(progn (insert-layer-after (make-initialized-layer) cursor)
	       (next-layer cursor)
	       (let ((layer (layer (slice (bar (cursor *gsharp-frame*))))))
		 (add-staff-to-layer staff layer)
		 (setf (staff (input-state *gsharp-frame*))
		       staff))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; slice menu

(make-command-table
 'slice-command-table
 :errorp nil
 :menu '(("Head" :command com-head-slice)
	 ("Body" :command com-body-slice)
	 ("Tail" :command com-tail-slisce)))

(define-gsharp-command (com-head-slice :name t) ()
  (head-slice (cursor *gsharp-frame*)))

(define-gsharp-command (com-body-slice :name t) ()
  (body-slice (cursor *gsharp-frame*)))

(define-gsharp-command (com-tail-slice :name t) ()
  (tail-slice (cursor *gsharp-frame*)))

(define-gsharp-command (com-forward-slice :name t) ()
  (forward-slice (cursor *gsharp-frame*)))

(define-gsharp-command (com-backward-slice :name t) ()
  (backward-slice (cursor *gsharp-frame*)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; bar menu

(make-command-table
 'measure-command-table
 :errorp nil
 :menu '(("Forward" :command com-forward-measure)
	 ("Backward" :command com-backward-measure)))

(define-gsharp-command (com-forward-measure :name t) ()
  (forward-bar (cursor *gsharp-frame*)))

(define-gsharp-command (com-backward-measure :name t) ()
  (backward-bar (cursor *gsharp-frame*)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; modes menu

(make-command-table
 'modes-command-table
 :errorp nil
 :menu '(("Fundamental" :command com-fundamental)))

(define-gsharp-command (com-fundamental :name t) ()
  nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; play menu

(make-command-table
 'play-command-table
 :errorp nil
 :menu '(("Buffer" :command com-play-buffer)
	 ("Segment" :command com-play-segment)))

(defun midi-pitch (note)
  (+ (* 12 (+ (floor (pitch note) 7) 1))
     (ecase (mod (pitch note) 7) (0 0) (1 2) (2 4) (3 5) (4 7) (5 9) (6 11))
     (ecase (accidentals note)
       (:double-flat -2) (:flat -1) (:natural 0) (:sharp 1) (:double-sharp 2))))

(defun measure-durations (slices)
  (let ((durations (mapcar (lambda (slice)
			     (mapcar (lambda (bar)
				       (reduce #'+ (elements bar)
					       :key #'element-duration))
				     (bars slice)))
			   slices)))
    (loop while durations
	  collect (reduce #'max (mapcar #'car durations))
	  do (setf durations (remove nil (mapcar #'cdr durations))))))

(defun events-from-element (element time channel)
  (when (typep element 'cluster)
    (append (mapcar (lambda (note)
		      (make-instance 'note-on-message
				     :time time
				     :status (+ #x90 channel)
				     :key (midi-pitch note) :velocity 100))
		    (notes element))
	    (mapcar (lambda (note)
		      (make-instance 'note-off-message
				     :time (+ time (* 128 (element-duration element)))
				     :status (+ #x80 channel)
				     :key (midi-pitch note) :velocity 100))
		    (notes element)))))

(defun events-from-bar (bar time channel)
  (mapcan (lambda (element)
	    (prog1 (events-from-element element time channel)
	      (incf time (* 128 (element-duration element)))))
	  (elements bar)))

(defun track-from-slice (slice channel durations)
  (cons (make-instance 'program-change-message
	  :time 0 :status  (+ #xc0 channel) :program 0)
	(let ((time 0))
	  (mapcan (lambda (bar duration)
		    (prog1 (events-from-bar bar time channel)
		      (incf time (* 128 duration))))
		  (bars slice) durations))))

(define-gsharp-command (com-play-segment :name t) ()
  (let* ((slices (mapcar #'body (layers (car (segments (buffer *gsharp-frame*))))))
	 (durations (measure-durations slices))
	 (tracks (loop for slice in slices
		       for i from 0
		       collect (track-from-slice slice i durations)))
	 (midifile (make-instance 'midifile
		     :format 1
		     :division 25
		     :tracks tracks)))
    (write-midi-file midifile "test.mid")
    #+cmu
    (ext:run-program "timidity" '("test.mid"))
    #+sbcl
    (sb-ext:run-program "timidity" '("test.mid") :search t)
    #-(or cmu sbcl)
    (error "write compatibility layer for RUN-PROGRAM")))

(define-gsharp-command (com-play-layer :name t) ()
  (let* ((slice (body (layer (slice (bar (cursor *gsharp-frame*))))))
	 (durations (measure-durations (list slice)))
	 (tracks (list (track-from-slice slice 0 durations)))
	 (midifile (make-instance 'midifile
		     :format 1
		     :division 25
		     :tracks tracks)))
    (write-midi-file midifile "test.mid")
    #+cmu
    (ext:run-program "timidity" '("test.mid"))
    #+sbcl
    (sb-ext:run-program "timidity" '("test.mid") :search t)
    #-(or cmu sbcl)
    (error "write compatibility layer for RUN-PROGRAM")))

(defun run-gsharp ()
  (loop for port in climi::*all-ports*
	do (destroy-port port))
  (setq climi::*all-ports* nil)
  (let* ((buffer (make-initialized-buffer))
	 (staff (car (staves buffer)))
	 (input-state (make-input-state staff))
	 (cursor (make-initial-cursor buffer)))
    (setf *gsharp-frame* (make-application-frame 'gsharp
						 :buffer buffer
						 :input-state input-state
						 :cursor cursor)
	  (staves (car (layers (car (segments buffer))))) (list staff)))
  (run-frame-top-level *gsharp-frame*))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; note insertion commands

(defun insert-cluster ()
  (let* ((state (input-state *gsharp-frame*))
	 (cursor (cursor *gsharp-frame*))
	 (cluster (make-cluster (if (eq (notehead state) :filled) (rbeams state) 0)
				(if (eq (notehead state) :filled) (lbeams state) 0)
				(dots state)
				(notehead state)
				(stem-direction state))))
    (insert-element cluster cursor)
    (forward-element cursor)
    cluster))

(defparameter *current-cluster* nil)
(defparameter *current-note* nil)

(defun insert-note (pitch cluster)
  (let* ((state (input-state *gsharp-frame*))
	 (note (make-note pitch
			  (staff state)
			  (notehead state)
			  (aref (keysig (staff state)) (mod pitch 7))
;;;			  (accidentals state)
			  (dots state))))
    (setf *current-cluster* cluster
	  *current-note* note)
    (add-note cluster note)))

(defun compute-and-adjust-note (pitch)
  (let* ((state (input-state *gsharp-frame*))
	 (old-pitch (mod (last-note state) 7))
	 (diff (- pitch old-pitch)))
    (incf (last-note state)
	  (cond ((> diff 3) (- diff 7))
		((< diff -3) (+ diff 7))
		(t diff)))))

(defun insert-numbered-note-new-cluster (pitch)
  (let ((new-pitch (compute-and-adjust-note pitch)))
    (insert-note new-pitch (insert-cluster))))

(define-gsharp-command (com-insert-note-a :keystroke #\a) ()
  (insert-numbered-note-new-cluster 5))

(define-gsharp-command (com-insert-note-b :keystroke #\b) ()
  (insert-numbered-note-new-cluster 6))

(define-gsharp-command (com-insert-note-c :keystroke #\c) ()
  (insert-numbered-note-new-cluster 0))

(define-gsharp-command (com-insert-note-d :keystroke #\d) ()
  (insert-numbered-note-new-cluster 1))

(define-gsharp-command (com-insert-note-e :keystroke #\e) ()
  (insert-numbered-note-new-cluster 2))

(define-gsharp-command (com-insert-note-f :keystroke #\f) ()
  (insert-numbered-note-new-cluster 3))

(define-gsharp-command (com-insert-note-g :keystroke #\g) ()
  (insert-numbered-note-new-cluster 4))

(define-gsharp-command com-insert-rest ()
  (let* ((state (input-state *gsharp-frame*))
	 (cursor (cursor *gsharp-frame*))
	 (rest (make-rest (if (eq (notehead state) :filled) (rbeams state) 0)
			  (if (eq (notehead state) :filled) (lbeams state) 0)
			  (dots state)
			  (notehead state)
			  (staff (input-state *gsharp-frame*)))))
    (insert-element rest cursor)
    (forward-element cursor)
    rest))

(define-gsharp-command com-insert-empty-cluster ()
  (insert-cluster))  

(defun cur-cluster ()
  (current-cluster (cursor *gsharp-frame*)))

(defun cur-element ()
  (current-element (cursor *gsharp-frame*)))

(defun cur-note ()
  (let ((cluster (cur-cluster)))
    (if (eq *current-cluster* cluster) ; it has not moved since last time
	(or (car (member *current-note* (notes cluster) :test #'eq))
	    (setf *current-note* (car (notes cluster))))
	(setf *current-cluster* cluster
	      *current-note* (car (notes cluster))))))
		  
(define-gsharp-command com-current-increment ()
  (let* ((cluster (cur-cluster))
	 (notes (notes cluster))
	 (rest (member (cur-note) notes :test #'eq)))
    (unless (null (cdr rest))
      (setf *current-note* (cadr rest)))))
	     
(define-gsharp-command com-current-decrement ()
  (let* ((cluster (cur-cluster))
	 (notes (notes cluster))
	 (pos (position (cur-note) notes :test #'eq)))
    (unless (zerop pos)
      (setf *current-note* (nth (1- pos) notes)))))
  
(defun insert-numbered-note-current-cluster (pitch)
  (let ((new-pitch (compute-and-adjust-note pitch)))
    (insert-note new-pitch (cur-cluster))))

(define-gsharp-command com-add-note-a ()
  (insert-numbered-note-current-cluster 5))

(define-gsharp-command com-add-note-b ()
  (insert-numbered-note-current-cluster 6))

(define-gsharp-command com-add-note-c ()
  (insert-numbered-note-current-cluster 0))

(define-gsharp-command com-add-note-d ()
  (insert-numbered-note-current-cluster 1))

(define-gsharp-command com-add-note-e ()
  (insert-numbered-note-current-cluster 2))

(define-gsharp-command com-add-note-f ()
  (insert-numbered-note-current-cluster 3))

(define-gsharp-command com-add-note-g ()
  (insert-numbered-note-current-cluster 4))

(define-gsharp-command com-more-dots ()
  (setf (dots (cur-element))
	(min (1+ (dots (cur-element))) 3)))

(define-gsharp-command com-fewer-dots ()
  (setf (dots (cur-element))
	(max (1- (dots (cur-element))) 0)))

(define-gsharp-command com-more-rbeams ()
  (setf (rbeams (cur-element))
	(min (1+ (rbeams (cur-element))) 3)))
  
(define-gsharp-command com-fewer-lbeams ()
  (setf (lbeams (cur-element))
	(max (1- (lbeams (cur-element))) 0)))

(define-gsharp-command com-more-lbeams ()
  (setf (lbeams (cur-element))
	(min (1+ (lbeams (cur-element))) 3)))
  
(define-gsharp-command com-fewer-rbeams ()
  (setf (rbeams (cur-element))
	(max (1- (rbeams (cur-element))) 0)))

(define-gsharp-command com-rotate-notehead ()
  (setf (notehead (cur-element))
	(ecase (notehead (cur-element))
	  (:whole :half)
	  (:half :filled)
	  (:filled :whole))))

(define-gsharp-command com-rotate-stem-direction ()
  (setf (stem-direction (cur-cluster))
	(ecase (stem-direction (cur-cluster))
	  (:auto :up)
	  (:up :down)
	  (:down :auto))))

(define-gsharp-command com-down ()
  (let ((element (cur-element)))
    (if (typep element 'cluster)
	(let* ((note (cur-note))
	       (new-note (make-note (1- (pitch note))
				    (staff note)
				    (head note)
				    (accidentals note)
				    (dots note))))
	  (remove-note note)
	  (add-note element new-note)
	  (setf *current-note* new-note))
	(let ((rbeams (rbeams element))
	      (lbeams (lbeams element))
	      (dots (dots element))
	      (notehead (notehead element))
	      (staff-pos (staff-pos element))
	      (staff (staff element))
	      (cursor (cursor *gsharp-frame*)))
	  (backward-element cursor)
	  (delete-element cursor)
	  (insert-element (make-instance 'rest
			    :notehead notehead :dots dots
			    :rbeams rbeams :lbeams lbeams
			    :staff staff :staff-pos (- staff-pos 2))
			  cursor)
	  (forward-element cursor)))))
    
(define-gsharp-command com-up ()
  (let ((element (cur-element)))
    (if (typep element 'cluster)
	(let* ((note (cur-note))
	       (new-note (make-note (1+ (pitch note))
				    (staff note)
				    (head note)
				    (accidentals note)
				    (dots note))))
	  (remove-note note)
	  (add-note element new-note)
	  (setf *current-note* new-note))
	(let ((rbeams (rbeams element))
	      (lbeams (lbeams element))
	      (dots (dots element))
	      (notehead (notehead element))
	      (staff-pos (staff-pos element))
	      (staff (staff element))
	      (cursor (cursor *gsharp-frame*)))
	  (backward-element cursor)
	  (delete-element cursor)
	  (insert-element (make-instance 'rest
			    :notehead notehead :dots dots
			    :rbeams rbeams :lbeams lbeams
			    :staff staff :staff-pos (+ staff-pos 2))
			  cursor)
	  (forward-element cursor)))))

(define-gsharp-command com-sharper ()
  (let* ((cluster (cur-cluster))
	 (note (cur-note))
	 (new-note (make-note (pitch note)
			      (staff note)
			      (head note)
			      (ecase (accidentals note)
				(:double-sharp :double-sharp)
				(:sharp :double-sharp)
				(:natural :sharp)
				(:flat :natural)
				(:double-flat :flat))
			      (dots note))))
    (remove-note note)
    (add-note cluster new-note)
    (setf *current-note* new-note)))

(define-gsharp-command com-flatter ()
  (let* ((cluster (cur-cluster))
	 (note (cur-note))
	 (new-note (make-note (pitch note)
			      (staff note)
			      (head note)
			      (ecase (accidentals note)
				(:double-sharp :sharp)
				(:sharp :natural)
				(:natural :flat)
				(:flat :double-flat)
				(:double-flat :double-flat))
			      (dots note))))
    (remove-note note)
    (add-note cluster new-note)
    (setf *current-note* new-note)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; motion by element

(define-gsharp-command com-forward-element ()
  (forward-element (cursor *gsharp-frame*)))

(define-gsharp-command com-backward-element ()
  (backward-element (cursor *gsharp-frame*)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; delete commands

(defun go-to-beginning-of-bar (cursor)
  (loop until (beginning-of-bar-p cursor)
	do (backward-element cursor)))

(defun go-to-end-of-bar (cursor)
  (loop until (end-of-bar-p cursor)
	do (forward-element cursor)))

;;; assume cursor is at the end of the bar
(defun fuse-bar-with-next (cursor)
  (go-to-beginning-of-bar cursor)
  (let ((elements '()))
    (loop until (end-of-bar-p cursor) do
	  (push (cursor-element cursor) elements)
	  (delete-element cursor))
    (delete-bar cursor)
    (loop for element in (nreverse elements) do
	  (insert-element element cursor)
	  (forward-element cursor))))

(define-gsharp-command com-delete-element ()
  (let ((cursor (cursor *gsharp-frame*)))
    ;;; this will signal a condition if in last bar and
    ;;; interrupt the execution of the command
    (forward-element cursor)
    (backward-element cursor)
    (if (end-of-bar-p cursor)
	(fuse-bar-with-next cursor)
	(delete-element cursor))))

(define-gsharp-command com-erase-element ()
  (let ((cursor (cursor *gsharp-frame*)))
    (backward-element cursor)
    (if (end-of-bar-p cursor)
	(fuse-bar-with-next cursor)
	(delete-element cursor))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Input State Settings

(define-gsharp-command com-istate-more-dots ()
  (setf (dots (input-state *gsharp-frame*))
	(min (1+ (dots (input-state *gsharp-frame*))) 3)))

(define-gsharp-command com-istate-fewer-dots ()
  (setf (dots (input-state *gsharp-frame*))
	(max (1- (dots (input-state *gsharp-frame*))) 0)))

(define-gsharp-command com-istate-more-rbeams ()
  (setf (rbeams (input-state *gsharp-frame*))
	(min (1+ (rbeams (input-state *gsharp-frame*))) 3)))
  
(define-gsharp-command com-istate-fewer-lbeams ()
  (setf (lbeams (input-state *gsharp-frame*))
	(max (1- (lbeams (input-state *gsharp-frame*))) 0)))

(define-gsharp-command com-istate-more-lbeams ()
  (setf (lbeams (input-state *gsharp-frame*))
	(min (1+ (lbeams (input-state *gsharp-frame*))) 3)))
  
(define-gsharp-command com-istate-fewer-rbeams ()
  (setf (rbeams (input-state *gsharp-frame*))
	(max (1- (rbeams (input-state *gsharp-frame*))) 0)))

(define-gsharp-command com-istate-rotate-notehead ()
  (setf (notehead (input-state *gsharp-frame*))
	(ecase (notehead (input-state *gsharp-frame*))
	  (:whole :half)
	  (:half :filled)
	  (:filled :whole))))		 

(define-gsharp-command com-istate-rotate-stem-direction ()
  (setf (stem-direction (input-state *gsharp-frame*))
	(ecase (stem-direction (input-state *gsharp-frame*))
	  (:auto :up)
	  (:up :down)
	  (:down :auto))))

(define-gsharp-command (com-set-clef :name t) ((name '(member :treble :bass :c))
				     (line '(or integer null) :prompt "Line"))
  (setf (clef (staff (input-state *gsharp-frame*)))
	(make-clef name line)))

(define-gsharp-command com-higher ()
  (incf (last-note (input-state *gsharp-frame*)) 7))

(define-gsharp-command com-lower ()
  (decf (last-note (input-state *gsharp-frame*)) 7))

(define-gsharp-command com-insert-measure-bar ()
  (let ((cursor (cursor *gsharp-frame*))
	(elements '()))
    (loop until (end-of-bar-p cursor)
	  do (push (cursor-element cursor) elements)
	  do (delete-element cursor))
    (insert-bar-after (make-bar) cursor)
    (forward-bar cursor)
    (loop for element in elements
	  do (insert-element element cursor))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Adding, deleting, and modifying staves

(define-condition no-such-staff (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "No such staff"))))

(define-presentation-method accept
    ((type score-pane:staff) stream (view textual-view) &key)
  (multiple-value-bind (staff success string)
      (handler-case (complete-input stream
				    (lambda (so-far mode)
				      (complete-from-possibilities
				       so-far
				       (staves (buffer *gsharp-frame*))
				       '()
				       :action mode
				       :predicate (lambda (obj) (declare (ignore obj)) t)
				       :name-key #'name
				       :value-key #'identity)))
	(simple-parse-error () (error 'no-such-staff)))
    (declare (ignore string))
    (if success staff (error 'no-such-staff))))

(define-presentation-method accept
    ((type fiveline-staff) stream (view textual-view) &key)
  (multiple-value-bind (staff success string)
      (handler-case (complete-input stream
				    (lambda (so-far mode)
				      (complete-from-possibilities
				       so-far
				       (staves (buffer *gsharp-frame*))
				       '()
				       :action mode
				       :predicate (lambda (obj) (typep obj 'fiveline-staff))
				       :name-key #'name
				       :value-key #'identity)))
	(simple-parse-error () (error 'no-such-staff)))
    (declare (ignore string))
    (if success staff (error 'no-such-staff))))

(defun symbol-name-lowcase (symbol)
  (string-downcase (symbol-name symbol)))

(define-presentation-type staff-type ())

(define-condition no-such-staff-type (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "No such staff type"))))

(define-presentation-method accept
    ((type staff-type) stream (view textual-view) &key)
  (multiple-value-bind (type success string)
      (handler-case (complete-input stream
				    (lambda (so-far mode)
				      (complete-from-possibilities
				       so-far
				       '(:fiveline)
				       '()
				       :action mode
				       :predicate (lambda (obj) (declare (ignore obj)) t)
				       :name-key #'symbol-name-lowcase
				       :value-key #'identity)))
	(simple-completion-error () (error 'no-such-staff-type)))
    (declare (ignore string))
    (if success	type (error 'no-such-staff-type))))

(define-presentation-type clef-type ())

(define-presentation-method accept
    ((type clef-type) stream (view textual-view) &key)
  (multiple-value-bind (type success string)
      (handler-case (complete-input stream
				    (lambda (so-far mode)
				      (complete-from-possibilities
				       so-far
				       '(:treble :bass :c :percussion)
				       '()
				       :action mode
				       :predicate (lambda (obj) (declare (ignore obj)) t)
				       :name-key #'symbol-name-lowcase
				       :value-key #'identity)))
	(simple-completion-error () (error 'no-such-staff-type)))
    (declare (ignore string))
    (if success
	type
	(error "no such staff type"))))

(define-condition staff-name-not-unique (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Staff name already exists"))))

(defun acquire-unique-staff-name ()
  (let ((name (accept 'string :prompt "Staff name")))
    (assert (not (member name (staves (buffer *gsharp-frame*)) :test #'string= :key #'name))
	    () `staff-name-not-unique)
    name))

(defun acquire-new-staff ()
  (let ((name (acquire-unique-staff-name)))
    (ecase (accept 'staff-type :prompt "Type")
      (:fiveline (let ((clef (accept 'clef-type :prompt "Clef"))
		       (line (accept 'integer :prompt "Line")))
		   (make-fiveline-staff name (make-clef clef line)))))))

(define-gsharp-command (com-add-staff-before :name t) ()
  (add-staff-before-staff (accept 'score-pane:staff :prompt "Before staff")
			  (acquire-new-staff)
			  (buffer *gsharp-frame*)))

(define-gsharp-command (com-add-staff-after :name t) ()
  (add-staff-after-staff (accept 'score-pane:staff :prompt "After staff")
			 (acquire-new-staff)
			 (buffer *gsharp-frame*)))

(define-gsharp-command (com-delete-staff :name t) ()
  (remove-staff-from-buffer (accept 'score-pane:staff :prompt "Staff")
			    (buffer *gsharp-frame*)))

(define-gsharp-command (com-rename-staff :name t) ()
  (let* ((staff (accept 'score-pane:staff :prompt "Staff"))
	 (name (acquire-unique-staff-name))
	 (buffer (buffer *gsharp-frame*)))
    (rename-staff name staff buffer)))

(define-gsharp-command (com-add-layer-staff :name t) ()
  (let ((staff (accept 'score-pane:staff :prompt "Staff"))
	(layer (layer (slice (bar (cursor *gsharp-frame*))))))
    (add-staff-to-layer staff layer)))

(define-gsharp-command (com-delete-layer-staff :name t) ((name 'string))
  (let ((staff (find-staff name (buffer *gsharp-frame*)))
	(layer (layer (slice (bar (cursor *gsharp-frame*))))))
    (remove-staff-from-layer staff layer)))

(define-gsharp-command com-more-sharps ()
  (let ((keysig (keysig (staff (input-state *gsharp-frame*)))))
    (cond ((eq (aref keysig 3) :flat) (setf (aref keysig 3) :natural))
	  ((eq (aref keysig 0) :flat) (setf (aref keysig 0) :natural))
	  ((eq (aref keysig 4) :flat) (setf (aref keysig 4) :natural))
	  ((eq (aref keysig 1) :flat) (setf (aref keysig 1) :natural))
	  ((eq (aref keysig 5) :flat) (setf (aref keysig 5) :natural))
	  ((eq (aref keysig 2) :flat) (setf (aref keysig 2) :natural))
	  ((eq (aref keysig 6) :flat) (setf (aref keysig 6) :natural))
	  ((eq (aref keysig 3) :natural) (setf (aref keysig 3) :sharp))
	  ((eq (aref keysig 0) :natural) (setf (aref keysig 0) :sharp))
	  ((eq (aref keysig 4) :natural) (setf (aref keysig 4) :sharp))
	  ((eq (aref keysig 1) :natural) (setf (aref keysig 1) :sharp))
	  ((eq (aref keysig 5) :natural) (setf (aref keysig 5) :sharp))
	  ((eq (aref keysig 2) :natural) (setf (aref keysig 2) :sharp))
	  ((eq (aref keysig 6) :natural) (setf (aref keysig 6) :sharp)))))

(define-gsharp-command com-more-flats ()
  (let ((keysig (keysig (staff (input-state *gsharp-frame*)))))
    (cond ((eq (aref keysig 6) :sharp) (setf (aref keysig 6) :natural))
	  ((eq (aref keysig 2) :sharp) (setf (aref keysig 2) :natural))
	  ((eq (aref keysig 5) :sharp) (setf (aref keysig 5) :natural))
	  ((eq (aref keysig 1) :sharp) (setf (aref keysig 1) :natural))
	  ((eq (aref keysig 4) :sharp) (setf (aref keysig 4) :natural))
	  ((eq (aref keysig 0) :sharp) (setf (aref keysig 0) :natural))
	  ((eq (aref keysig 3) :sharp) (setf (aref keysig 3) :natural))
	  ((eq (aref keysig 6) :natural) (setf (aref keysig 6) :flat))
	  ((eq (aref keysig 2) :natural) (setf (aref keysig 2) :flat))
	  ((eq (aref keysig 5) :natural) (setf (aref keysig 5) :flat))
	  ((eq (aref keysig 1) :natural) (setf (aref keysig 1) :flat))
	  ((eq (aref keysig 4) :natural) (setf (aref keysig 4) :flat))
	  ((eq (aref keysig 0) :natural) (setf (aref keysig 0) :flat))
	  ((eq (aref keysig 3) :natural) (setf (aref keysig 3) :flat)))))

;;; macro processing
(define-gsharp-command com-start-kbd-macro ()
  (message "defining keyboad macro~%")
  (setf *kbd-macro-recording-p* t
	*kbd-macro-funs* '()))  

(define-gsharp-command com-end-kbd-macro ()
  (message "keyboad macro defined~%")
  (setf *kbd-macro-recording-p* nil
	*kbd-macro-funs* (nreverse (cdr *kbd-macro-funs*))))

(define-gsharp-command com-call-last-kbd-macro ()
  (handler-case (mapc #'funcall *kbd-macro-funs*)
    (gsharp-condition (condition) (format *error-output* "~a~%" condition))))
