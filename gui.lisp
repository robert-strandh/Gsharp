(in-package :gsharp)

(defun make-initial-cursor (buffer)
  (let* ((segment (segmentno buffer 0))
	 (layer (layerno segment 0))
	 (slice (body layer))
	 (bar (barno slice 0)))
  (make-cursor bar 0)))

(defclass gsharp-minibuffer-pane (minibuffer-pane)
  ()
  (:default-initargs
      :height 20 :max-height 20 :min-height 20))

(define-command-table total-melody-table
    :inherit-from (melody-table global-gsharp-table gsharp))
(define-command-table total-lyrics-table
    :inherit-from (lyrics-table global-gsharp-table gsharp))

(define-application-frame gsharp (standard-application-frame
				  esa-frame-mixin)
  ((buffer :initarg :buffer :accessor buffer)
   (cursor :initarg :cursor :accessor cursor)
   (input-state :initarg :input-state :accessor input-state))
  (:menu-bar menubar-command-table :height 25)
  (:pointer-documentation t)
  (:panes
   (score (let ((win (make-pane 'score-pane:score-pane
				:width 400 :height 500
				:name "score"
				;; :incremental-redisplay t
				:double-buffering t
				:display-function 'display-score
				:command-table 'total-melody-table)))
	    (setf (windows *application-frame*) (list win))
	    win))
   (state (make-pane 'score-pane:score-pane
		     :width 50 :height 200
		     :name "state"
		     :display-function 'display-state))
   (element (make-pane 'score-pane:score-pane
		       :width 50 :height 300
		       :min-height 100 :max-height 20000
		       :name "element"
		       :display-function 'display-element))
   (interactor (make-pane 'gsharp-minibuffer-pane :width 900)))
  (:layouts
   (default
     (vertically ()
       (horizontally ()
	 (scrolling (:width 750 :height 500
		     :min-height 400 :max-height 20000)
		    score)
	 (vertically ()
		     (scrolling (:width 80 :height 200) state)
		     (scrolling (:width 80 :height 300
				 :min-height 300 :max-height 20000)
				element)))
       interactor)))
  (:top-level (esa-top-level)))

(defmethod execute-frame-command :around ((frame gsharp) command)
  (handler-case (call-next-method)
    (gsharp-condition (condition) (beep) (display-message "~a" condition))))

(defmethod display-state ((frame gsharp) pane)
  (let ((state (input-state *application-frame*)))
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
  (let* ((state (input-state *application-frame*))
	 (staff (car (staves (layer (cursor *application-frame*)))))
         ;; Why (- STAFF-YOFFSET)?  dunno.  -- CSR, 2005-10-28
	 (yoffset (- (gsharp-drawing::staff-yoffset staff))))
    (if (typep staff 'fiveline-staff)
	(let* ((clef (clef staff))
	       (bottom-line (- (ecase (name clef) (:treble 32) (:bass 24) (:c 35))
			       (lineno clef)))
	       (lnote-offset (score-pane:staff-step (- (last-note state) bottom-line))))
	  (draw-line* pane
		      x (- (+ (score-pane:staff-step 12) yoffset))
		      x (- (+ (score-pane:staff-step -4) yoffset))
		      :ink +yellow+)
	  (draw-line* pane
		      (- x 1) (- (+ (score-pane:staff-step -3.4) yoffset lnote-offset))
		      (- x 1) (- (+ (score-pane:staff-step 3.6) yoffset lnote-offset))
		      :ink +red+)
	  (draw-line* pane
		      (+ x 1) (- (+ (score-pane:staff-step -3.4) yoffset lnote-offset))
		      (+ x 1) (- (+ (score-pane:staff-step 3.6) yoffset lnote-offset))
		      :ink +red+))
	(progn (draw-line* pane
			   (+ x 1) (- (+ (score-pane:staff-step 2) yoffset))
			   (+ x 1) (- (+ (score-pane:staff-step -2) yoffset))
			   :ink +red+)
	       (draw-line* pane
			   (- x 1) (- (+ (score-pane:staff-step 2) yoffset))
			   (- x 1) (- (+ (score-pane:staff-step -2) yoffset))
			   :ink +red+)))))

(defmethod display-score ((frame gsharp) pane)
  (let* ((buffer (buffer frame)))
    (recompute-measures buffer)
    (score-pane:with-score-pane pane
      (flet ((draw-cursor (x) (draw-the-cursor pane x)))
	(draw-buffer pane buffer (cursor *application-frame*)
		     (left-margin buffer) 100 #'draw-cursor)))))

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
	 ("Staves" :menu staves-command-table)
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
	 (input-state (make-input-state)))
    (setf (buffer *application-frame*) buffer
	  (cursor *application-frame*) cursor
	  (input-state *application-frame*) input-state
	  (staves (car (layers (car (segments buffer))))) (list staff))))

(define-presentation-type completable-pathname ()
  :inherit-from 'pathname)

(define-condition file-not-found (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "File nont found"))))

(defun filename-completer (so-far mode)
  (flet ((remove-trail (s)
	   (subseq s 0 (let ((pos (position #\/ s :from-end t)))
			 (if pos (1+ pos) 0)))))
    (let* ((directory-prefix
	    (if (and (plusp (length so-far)) (eql (aref so-far 0) #\/))
		""
		(namestring #+sbcl (car (directory ".")) #+cmu (ext:default-directory))))
	   (full-so-far (concatenate 'string directory-prefix so-far))
	   (pathnames
	    (loop with length = (length full-so-far)
		  for path in (directory (concatenate 'string
						       (remove-trail so-far)
						      "*.*"))
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
		(values so-far nil nil 0 nil))
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


(define-presentation-method accept
    ((type completable-pathname) stream (view textual-view) &key)
  (multiple-value-bind (pathname success string)
      (complete-input stream
		      #'filename-completer
		      :partial-completers '(#\Space)
		      :allow-any-input t)
    (declare (ignore success))
    (or pathname string)))

(define-gsharp-command (com-load-file :name t) ()
  (let* ((stream (frame-standard-input *application-frame*))
	 (filename (handler-case (accept 'completable-pathname :stream stream
					 :prompt "File Name")
		     (simple-parse-error () (error 'file-not-found))))
	 (buffer (read-everything filename))
	 (input-state (make-input-state))
	 (cursor (make-initial-cursor buffer)))
    (setf (buffer *application-frame*) buffer
	  (input-state *application-frame*) input-state
	  (cursor *application-frame*) cursor)
    (number-all (buffer *application-frame*))
    (select-layer cursor (car (layers (segment (cursor *application-frame*)))))))

(define-gsharp-command (com-save-buffer-as :name t) ()
  (let* ((stream (frame-standard-input *application-frame*))
	 (filename (handler-case (accept 'completable-pathname :stream stream
					 :prompt "File Name")
		     (simple-parse-error () (error 'file-not-found)))))
    (with-open-file (stream filename :direction :output)
      (save-buffer-to-stream (buffer *application-frame*) stream)
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
  (forward-segment (cursor *application-frame*)))

(define-gsharp-command (com-backward-segment :name t) ()
  (backward-segment (cursor *application-frame*)))

(define-gsharp-command (com-delete-segment :name t) ()
  (delete-segment (cursor *application-frame*)))

(define-gsharp-command (com-insert-segment-before :name t) ()
  (let ((cursor (cursor *application-frame*)))
    (insert-segment-before (make-instance 'segment :staff (car (staves (buffer *application-frame*))))
			   cursor)
    (backward-segment cursor)))

(define-gsharp-command (com-insert-segment-after :name t) ()
  (let ((cursor (cursor *application-frame*)))
    (insert-segment-after (make-instance 'segment :staff (car (staves (buffer *application-frame*))))
			  cursor)
    (forward-segment cursor)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; layer menu

(make-command-table
 'layer-command-table
 :errorp nil
 :menu '(("Select" :command com-select-layer)
	 ("Rename" :command com-rename-layer)
	 ("New"    :command com-add-layer)
	 ("Delete" :command com-delete-layer)))

(define-condition layer-name-not-unique (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "Layer name already exists"))))

(defun acquire-unique-layer-name (prompt)
  (let ((name (accept 'string :prompt prompt)))
    (assert (not (member name (layers (segment (cursor *application-frame*)))
			 :test #'string= :key #'name))
	    () `layer-name-not-unique)
    name))

(define-condition no-such-layer (gsharp-condition) ()
  (:report
   (lambda (condition stream)
     (declare (ignore condition))
     (format stream "No such layer"))))

(define-presentation-method accept
    ((type layer) stream (view textual-view) &key)
  (multiple-value-bind (layer success string)
      (handler-case (complete-input stream
				    (lambda (so-far mode)
				      (complete-from-possibilities
				       so-far
				       (layers (segment (cursor *application-frame*)))
				       '()
				       :action mode
				       :predicate (constantly t)
				       :name-key #'name
				       :value-key #'identity)))
	(simple-parse-error () (error 'no-such-layer)))
    (declare (ignore string))
    (if success layer (error 'no-such-layer))))

(defmethod select-layer :after (cursor (layer layer))
  (typecase layer
    (lyrics-layer (setf (command-table (first (windows *application-frame*)))
                        (find-command-table 'total-lyrics-table)))
    (melody-layer (setf (command-table (first (windows *application-frame*)))
                        (find-command-table 'total-melody-table)))))

(define-gsharp-command (com-select-layer :name t) ()
  (let ((selected-layer (accept 'layer :prompt "Select layer")))
    (select-layer (cursor *application-frame*) selected-layer)))

(define-gsharp-command (com-rename-layer :name t) ()
  (setf (name (accept 'layer :prompt "Rename layer"))
	(acquire-unique-layer-name "New name of layer")))

(define-gsharp-command (com-add-layer :name t) ()
  (let* ((name (acquire-unique-layer-name "Name of new layer"))
	 (staff (accept 'score-pane:staff :prompt "Initial staff of new layer"))
	 (new-layer (make-layer name staff)))
    (add-layer new-layer (segment (cursor *application-frame*)))
    (select-layer (cursor *application-frame*) new-layer)))
    
(define-gsharp-command (com-delete-layer :name t) ()
  (delete-layer (cursor *application-frame*)))

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
  (head-slice (cursor *application-frame*)))

(define-gsharp-command (com-body-slice :name t) ()
  (body-slice (cursor *application-frame*)))

(define-gsharp-command (com-tail-slice :name t) ()
  (tail-slice (cursor *application-frame*)))

(define-gsharp-command (com-forward-slice :name t) ()
  (forward-slice (cursor *application-frame*)))

(define-gsharp-command (com-backward-slice :name t) ()
  (backward-slice (cursor *application-frame*)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; bar menu

(make-command-table
 'measure-command-table
 :errorp nil
 :menu '(("Forward" :command com-forward-measure)
	 ("Backward" :command com-backward-measure)))

(define-gsharp-command (com-forward-measure :name t) ()
  (forward-bar (cursor *application-frame*)))

(define-gsharp-command (com-backward-measure :name t) ()
  (backward-bar (cursor *application-frame*)))

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
;;; staves menu

(make-command-table
 'staves-command-table
 :errorp nil
 :menu '(("Rotate" :command com-rotate-staves)))

(define-gsharp-command (com-rotate-staves :name t) ()
  (let ((layer (layer (cursor *application-frame*))))
    (setf (staves layer)
	  (append (cdr (staves layer)) (list (car (staves layer)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; play menu

(make-command-table
 'play-command-table
 :errorp nil
 :menu '(("Buffer" :command com-play-buffer)
	 ("Segment" :command com-play-segment)))

(define-gsharp-command (com-play-segment :name t) ()
  (play-segment (segment (cursor *application-frame*))))

(define-gsharp-command (com-play-layer :name t) ()
  (play-layer (layer (cursor *application-frame*))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; main entry point

(defun gsharp (&key new-process (process-name "Gsharp")
	       (width 900) (height 600))
  "Start a Gsharp session" 
  (let* ((buffer (make-initialized-buffer))
	 (staff (car (staves buffer)))
	 (input-state (make-input-state))
	 (cursor (make-initial-cursor buffer)))
    (let ((frame (make-application-frame 'gsharp
					 :buffer buffer
					 :input-state input-state
					 :cursor cursor
					 :width width :height height)))
      (flet ((run ()
	       (run-frame-top-level frame)))
	(setf (staves (car (layers (car (segments buffer))))) (list staff))
	(if new-process
	    (clim-sys:make-process #'run :name process-name)
	    (run))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; note insertion commands

(defun insert-cluster ()
  (let* ((state (input-state *application-frame*))
	 (cursor (cursor *application-frame*))
	 (cluster (make-instance 'cluster
		    :rbeams (if (eq (notehead state) :filled) (rbeams state) 0)
		    :lbeams (if (eq (notehead state) :filled) (lbeams state) 0)
		    :dots (dots state)
		    :notehead (notehead state)
		    :stem-direction (stem-direction state))))
    (insert-element cluster cursor)
    (forward-element cursor)
    cluster))

(defparameter *current-cluster* nil)
(defparameter *current-note* nil)

(defun insert-note (pitch cluster)
  (let* ((state (input-state *application-frame*))
	 (staff (car (staves (layer (slice (bar cluster))))))
	 (note (make-instance 'note
		 :pitch pitch
		 :staff staff
		 :head (notehead state)
		 :accidentals (aref (keysig staff) (mod pitch 7))
		 :dots (dots state))))
    (setf *current-cluster* cluster
	  *current-note* note)
    (add-note cluster note)))

(defun compute-and-adjust-note (pitch)
  (let* ((state (input-state *application-frame*))
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
  (let* ((state (input-state *application-frame*))
	 (cursor (cursor *application-frame*))
	 (rest (make-instance 'rest
		 :rbeams (if (eq (notehead state) :filled) (rbeams state) 0)
		 :lbeams (if (eq (notehead state) :filled) (lbeams state) 0)
		 :dots (dots state)
		 :notehead (notehead state)
		 :staff (car (staves (layer (cursor *application-frame*)))))))
    (insert-element rest cursor)
    (forward-element cursor)
    rest))

(define-gsharp-command com-insert-empty-cluster ()
  (insert-cluster))  

(defun cur-cluster ()
  (current-cluster (cursor *application-frame*)))

(defun cur-element ()
  (current-element (cursor *application-frame*)))

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
	       (new-note (make-instance 'note
			   :pitch (1- (pitch note))
			   :staff (staff note)
			   :head (head note)
			   :accidentals (accidentals note)
			   :dots (dots note))))
	  (remove-note note)
	  (add-note element new-note)
	  (setf *current-note* new-note))
	(let ((rbeams (rbeams element))
	      (lbeams (lbeams element))
	      (dots (dots element))
	      (notehead (notehead element))
	      (staff-pos (staff-pos element))
	      (staff (staff element))
	      (cursor (cursor *application-frame*)))
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
	       (new-note (make-instance 'note
			   :pitch (1+ (pitch note))
			   :staff (staff note)
			   :head (head note)
			   :accidentals (accidentals note)
			   :dots (dots note))))
	  (remove-note note)
	  (add-note element new-note)
	  (setf *current-note* new-note))
	(let ((rbeams (rbeams element))
	      (lbeams (lbeams element))
	      (dots (dots element))
	      (notehead (notehead element))
	      (staff-pos (staff-pos element))
	      (staff (staff element))
	      (cursor (cursor *application-frame*)))
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
	 (new-note (make-instance 'note
		     :pitch (pitch note)
		     :staff (staff note)
		     :head (head note)
		     :accidentals (ecase (accidentals note)
				    (:double-sharp :double-sharp)
				    (:sharp :double-sharp)
				    (:natural :sharp)
				    (:flat :natural)
				    (:double-flat :flat))
		     :dots (dots note))))
    (remove-note note)
    (add-note cluster new-note)
    (setf *current-note* new-note)))

(define-gsharp-command com-flatter ()
  (let* ((cluster (cur-cluster))
	 (note (cur-note))
	 (new-note (make-instance 'note
		     :pitch (pitch note)
		     :staff (staff note)
		     :head (head note)
		     :accidentals (ecase (accidentals note)
				    (:double-sharp :sharp)
				    (:sharp :natural)
				    (:natural :flat)
				    (:flat :double-flat)
				    (:double-flat :double-flat))
		     :dots (dots note))))
    (remove-note note)
    (add-note cluster new-note)
    (setf *current-note* new-note)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; motion by element

(define-gsharp-command com-forward-element ((count 'integer :prompt "Number of Elements"))
  (loop repeat count
	do (forward-element (cursor *application-frame*))))

(define-gsharp-command com-backward-element ((count 'integer :prompt "Number of Elements"))
  (backward-element (cursor *application-frame*)))

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

(define-gsharp-command com-delete-element ((count 'integer :prompt "Number of Elements"))
  (let ((cursor (cursor *application-frame*)))
    (loop repeat count
	  do (progn
	       ;; this will signal a condition if in last bar and
	       ;; interrupt the execution of the command
	       (forward-element cursor)
	       (backward-element cursor)
	       (if (end-of-bar-p cursor)
		   (fuse-bar-with-next cursor)
		   (delete-element cursor))))))

(define-gsharp-command com-erase-element ()
  (let ((cursor (cursor *application-frame*)))
    (backward-element cursor)
    (if (end-of-bar-p cursor)
	(fuse-bar-with-next cursor)
	(delete-element cursor))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Input State Settings

(define-gsharp-command com-istate-more-dots ()
  (setf (dots (input-state *application-frame*))
	(min (1+ (dots (input-state *application-frame*))) 3)))

(define-gsharp-command com-istate-fewer-dots ()
  (setf (dots (input-state *application-frame*))
	(max (1- (dots (input-state *application-frame*))) 0)))

(define-gsharp-command com-istate-more-rbeams ()
  (setf (rbeams (input-state *application-frame*))
	(min (1+ (rbeams (input-state *application-frame*))) 3)))
  
(define-gsharp-command com-istate-fewer-lbeams ()
  (setf (lbeams (input-state *application-frame*))
	(max (1- (lbeams (input-state *application-frame*))) 0)))

(define-gsharp-command com-istate-more-lbeams ()
  (setf (lbeams (input-state *application-frame*))
	(min (1+ (lbeams (input-state *application-frame*))) 3)))
  
(define-gsharp-command com-istate-fewer-rbeams ()
  (setf (rbeams (input-state *application-frame*))
	(max (1- (rbeams (input-state *application-frame*))) 0)))

(define-gsharp-command com-istate-rotate-notehead ()
  (setf (notehead (input-state *application-frame*))
	(ecase (notehead (input-state *application-frame*))
	  (:whole :half)
	  (:half :filled)
	  (:filled :whole))))		 

(define-gsharp-command com-istate-rotate-stem-direction ()
  (setf (stem-direction (input-state *application-frame*))
	(ecase (stem-direction (input-state *application-frame*))
	  (:auto :up)
	  (:up :down)
	  (:down :auto))))

(define-gsharp-command (com-set-clef :name t) ()
  (let ((staff (accept 'score-pane:fiveline-staff :prompt "Set clef of staff"))
	(type (accept 'clef-type :prompt "Type of clef"))
	(line (accept 'integer :prompt "Line of clef")))
    (setf (clef staff) (make-instance 'clef :name type :lineno line))))

(define-gsharp-command com-higher ()
  (incf (last-note (input-state *application-frame*)) 7))

(define-gsharp-command com-lower ()
  (decf (last-note (input-state *application-frame*)) 7))

(define-gsharp-command com-insert-measure-bar ()
  (let ((cursor (cursor *application-frame*))
	(elements '()))
    (loop until (end-of-bar-p cursor)
	  do (push (cursor-element cursor) elements)
	  do (delete-element cursor))
    (insert-bar-after (make-instance (class-of (bar cursor))) cursor)
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
				       (staves (buffer *application-frame*))
				       '()
				       :action mode
				       :predicate (constantly t)
				       :name-key #'name
				       :value-key #'identity)))
	(simple-parse-error () (error 'no-such-staff)))
    (declare (ignore string))
    (if success staff (error 'no-such-staff))))

(define-presentation-method accept
    ((type score-pane:fiveline-staff) stream (view textual-view) &key)
  (multiple-value-bind (staff success string)
      (handler-case (complete-input stream
				    (lambda (so-far mode)
				      (complete-from-possibilities
				       so-far
				       (staves (buffer *application-frame*))
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
				       '(:fiveline :lyrics)
				       '()
				       :action mode
				       :predicate (constantly t)
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
				       :predicate (constantly t)
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

(defun acquire-unique-staff-name (prompt)
  (let ((name (accept 'string :prompt prompt)))
    (assert (not (member name (staves (buffer *application-frame*)) :test #'string= :key #'name))
	    () `staff-name-not-unique)
    name))

(defun acquire-new-staff ()
  (let ((name (acquire-unique-staff-name "Name of new staff")))
    (ecase (accept 'staff-type :prompt "Type")
      (:fiveline (let* ((clef-name (accept 'clef-type :prompt "Clef type of new staff"))
			(line (accept 'integer :prompt "Line of clef"))
			(clef (make-instance 'clef :name clef-name :lineno line)))
		   (make-instance 'fiveline-staff :name name :clef clef)))
      (:lyrics (make-instance 'lyrics-staff :name name)))))

(define-gsharp-command (com-insert-staff-before :name t) ()
  (add-staff-before-staff (accept 'score-pane:staff :prompt "Insert staff before staff")
			  (acquire-new-staff)
			  (buffer *application-frame*)))

(define-gsharp-command (com-insert-staff-after :name t) ()
  (add-staff-after-staff (accept 'score-pane:staff :prompt "Insert staff after staff")
			 (acquire-new-staff)
			 (buffer *application-frame*)))

(define-gsharp-command (com-delete-staff :name t) ()
  (remove-staff-from-buffer (accept 'score-pane:staff :prompt "Staff")
			    (buffer *application-frame*)))

(define-gsharp-command (com-rename-staff :name t) ()
  (let* ((staff (accept 'score-pane:staff :prompt "Rename staff"))
	 (name (acquire-unique-staff-name "New name of staff"))
	 (buffer (buffer *application-frame*)))
    (rename-staff name staff buffer)))

(define-gsharp-command (com-add-staff-to-layer :name t) ()
  (let ((staff (accept 'score-pane:staff :prompt "Add staff to layer"))
	(layer (layer (cursor *application-frame*))))
    (add-staff-to-layer staff layer)))

;;; FIXME restrict to staves that are actually in the layer. 
(define-gsharp-command (com-delete-staff-from-layer :name t) ()
  (let ((staff (accept 'score-pane:staff :prompt "Add staff to layer"))
	(layer (layer (cursor *application-frame*))))
    (remove-staff-from-layer staff layer)))

(define-gsharp-command com-more-sharps ()
  (let ((keysig (keysig (car (staves (layer (cursor *application-frame*)))))))
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
  (let ((keysig (keysig (car (staves (layer (cursor *application-frame*)))))))
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Lyrics

(defun insert-lyrics-element ()
  (let* ((state (input-state *application-frame*))
	 (cursor (cursor *application-frame*))
	 (element (make-instance 'lyrics-element
		    :rbeams (if (eq (notehead state) :filled) (rbeams state) 0)
		    :lbeams (if (eq (notehead state) :filled) (lbeams state) 0)
		    :dots (dots state)
		    :notehead (notehead state)
		    :staff (car (staves (layer (cursor *application-frame*)))))))
    (insert-element element cursor)
    (forward-element cursor)
    element))
