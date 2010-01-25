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
(define-command-table total-rhythmic-melody-table
    :inherit-from (melody-table rhythmic-table global-gsharp-table gsharp))
(define-command-table total-cluster-table
    :inherit-from (cluster-table melody-table global-gsharp-table gsharp))
(define-command-table total-lyrics-table
    :inherit-from (lyrics-table global-gsharp-table gsharp))

(defclass orchestra-view (score-pane:score-view)
  ((cursor :initarg :cursor :reader cursor)
   (buffer :initarg :buffer :reader buffer)))

;;; FIXME: we need to sort out Drei's definition of accept methods for
;;; the general VIEW type.
;;;
;;; FIXME: we should name our views so that they can be found by a
;;; string name, rather than the unreadable-object print.  There's a
;;; SUBSCRIPTABLE-NAME-MIXIN in ESA-UTILS that is used for this
;;; purpose in the analogous place in Climacs.
(define-presentation-method accept 
    ((type orchestra-view) stream (view textual-view)
     &key (default nil defaultp) (default-type type))
  (multiple-value-bind (object success string)
      (complete-input stream
		      (lambda (so-far action)
			(complete-from-possibilities
			 so-far (views *esa-instance*) '()
                         :action action
			 :name-key #'princ-to-string
			 :value-key #'identity))
		      :partial-completers '(#\Space))
    (cond
      (success (values object type))
      ((and defaultp (= (length string) 0)) (values default default-type))
      (t (input-not-of-required-type string type)))))

;;; exists for the sole purpose of a :before method that updates the
;;; measures of each modified buffer.
(defclass gsharp-pane-mixin () ())

(defclass gsharp-pane (score-pane:score-pane gsharp-pane-mixin)
  ((view :initarg :view :accessor view)))         

(defvar *info-bg-color* +gray85+)
(defvar *info-fg-color* +black+)

(defclass gsharp-info-pane (info-pane gsharp-pane-mixin)
  ()
  (:default-initargs
      :height 20 :max-height 20 :min-height 20
      :display-function 'display-info
      :incremental-redisplay t))

(defun display-info (frame pane)
  (declare (ignore frame))
  (let* ((master-pane (master-pane pane))
         (view (view master-pane))
         (buffer (buffer view)))
    (princ "   " pane)
    (princ (cond ((and (needs-saving buffer)
                       (read-only-p buffer)
                       "%*"))
                 ((needs-saving buffer) "**")
                 ((read-only-p buffer) "%%")
                 (t "--"))
           pane)
    (princ "  " pane)
    (with-text-face (pane :bold)
      (format pane "~25A" (name buffer)))
    (princ "  " pane)
    (format pane "[~a/~a]"
            (score-pane:current-page-number view)
            (score-pane:number-of-pages view))
    (princ "  " pane)
    (with-text-family (pane :sans-serif)
      (princ (if (recordingp *application-frame*)
                 "Def"
                 "")
             pane))))

(define-application-frame gsharp (esa-frame-mixin
                                  standard-application-frame)
  ((views :initarg :views :initform '() :accessor views)
   (input-state :initarg :input-state :accessor input-state))
  (:default-initargs :input-state (make-input-state))
  (:menu-bar menubar-command-table :height 25)
  (:pointer-documentation t)
  (:panes
   (score (let* ((win (make-pane 'gsharp-pane
                                 :width 400 :height 500
                                 :name "score"
                                 ;; :incremental-redisplay t
                                 :double-buffering t
                                 :display-function 'display-score
                                 :command-table 'total-melody-table))
                 (info (make-pane 'gsharp-info-pane
                                  :master-pane win
                                  :background *info-bg-color*
                                  :foreground *info-fg-color*)))
            (setf (windows *application-frame*) (list win))
            (setf (view win) (car (views *application-frame*)))
            (vertically () 
              (scrolling (:width 750 :height 500
                          :min-height 400 :max-height 20000)
                win)
              info)))
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
         score
         (vertically ()
                     (scrolling (:width 80 :height 200) state)
                     (scrolling (:width 80 :height 300
                                 :min-height 300 :max-height 20000)
                                element)))
       interactor)))
  (:top-level (esa-top-level)))

(defmethod buffers ((application-frame gsharp))
  (let (result)
    (dolist (window (windows application-frame) (nreverse result))
      (let ((view (view window)))
        (when view
          (pushnew (buffer view) result))))))

(defmethod esa-current-buffer ((application-frame gsharp))
  (buffer (view (car (windows application-frame)))))

(defun current-cursor ()
  (cursor (view (car (windows *application-frame*)))))

(defmethod execute-frame-command :around ((frame gsharp) command)
  (handler-case (call-next-method)
    (gsharp-condition (condition) (beep) (display-message "~a" condition))))

(defmethod display-state ((frame gsharp) pane)
  (let ((state (input-state *application-frame*)))
    (score-pane:with-score-pane pane
      (score-pane:with-staff-size 10
        (score-pane:with-vertical-score-position (pane 100)
          (let ((xpos 30))
            (score-pane:draw-notehead pane (notehead state) xpos 4)
            (when (not (member (notehead state) '(:whole :breve)))
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
                (score-pane:draw-left-stem pane xpos (- (score-pane:staff-step 4)) (- (score-pane:staff-step -4))))
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
                (score-pane:draw-right-stem pane xpos (- (score-pane:staff-step 4)) (- (score-pane:staff-step 12)))))
            (score-pane:with-notehead-right-offsets (right up)
              (declare (ignore up))
              (loop repeat (dots state)
                    for dx from (+ right 5) by 5 do
                    (score-pane:draw-dot pane (+ xpos dx) 4)))))))))

(defun update-page-numbers (frame)
  (loop for window in (windows frame)
        do (let ((page-number 0)
                 (view (view window)))
             (gsharp-measure::new-map-over-obseq-subsequences
              (lambda (all-measures)
                (incf page-number)
                (when (member-if (lambda (measure) (member (bar (cursor view))
                                                           (measure-bars measure)
                                                           :test #'eq))
                                 all-measures)
                  (setf (score-pane:current-page-number view) page-number)))
              (buffer view))
             (setf (score-pane:number-of-pages view) page-number))))

;;; I tried making this a :before method on redisplay-frame-panes,
;;; but it turns out that McCLIM calls redisplay-frame-pane from 
;;; places other than redisplay-frame-panes. 
(defmethod redisplay-frame-pane :before ((frame gsharp) (pane gsharp-pane-mixin) &key force-p)
  (declare (ignore pane force-p))
  (mapc #'recompute-measures (buffers frame))
  (update-page-numbers frame))

(defmethod display-score ((frame gsharp) pane)
  (let* ((buffer (buffer (view pane))))
    (score-pane:with-score-pane pane
      (draw-buffer pane buffer (current-cursor)
                   (left-margin buffer) 100)
      (draw-the-cursor pane (current-cursor) (cursor-element (current-cursor))
                       (last-note (input-state *application-frame*)))
      (multiple-value-bind (minx miny maxx maxy)
          (bounding-rectangle* (stream-output-history pane))
        (declare (ignore minx maxx))
        (change-space-requirements pane :height (+ maxy miny))))))

(defmethod window-clear ((pane score-pane:score-pane))
  (let ((output-history (stream-output-history pane)))
    (with-bounding-rectangle* (left top right bottom) output-history
      (medium-clear-area (sheet-medium pane) left top right bottom))
    (clear-output-record output-history))
  (window-erase-viewport pane))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Element pane

(defmethod note-position ((note note))
  (let ((clef (clef (staff note))))
    (- (pitch note)
       (bottom-line clef))))

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
                 (stem-direction (stem-direction cluster)))
            (declare (ignore stem-direction notehead lbeams rbeams dots))
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
 :menu '(("File" :menu esa-io-menu-table)
         ("Macros" :menu keyboard-macro-menu-table)
         ("Buffer" :menu buffer-command-table)
         ("Stuff" :menu segment-command-table)
         ("Segment" :menu segment-command-table)
         ("Layer" :menu layer-command-table)
         ("Slice" :menu slice-command-table)
         ("Measure" :menu measure-command-table)
         ("Modes" :menu modes-command-table)
         ("Staves" :menu staves-command-table)
         ("Play" :menu play-command-table)
         ("Help" :menu help-menu-table)))

(define-gsharp-command (com-new-buffer :name t) ()
  (let* ((buffer (make-instance 'buffer))
         (cursor (make-initial-cursor buffer))
         (staff (car (staves buffer)))
         (input-state (make-input-state))
         (view (make-instance 'orchestra-view 
                              :buffer buffer
                              :cursor cursor)))
    (push view (views *application-frame*))
    (setf (view (car (windows *application-frame*))) view)
    (setf (input-state *application-frame*) input-state
          (staves (car (layers (car (segments buffer))))) (list staff))))

(defmethod frame-find-file :around ((application-frame gsharp) filepath)
  (declare (ignore filepath))
  (let* ((buffer (call-next-method))
         (input-state (make-input-state))
         (cursor (make-initial-cursor buffer))
         (view (make-instance 'orchestra-view 
                              :buffer buffer
                              :cursor cursor)))
    (push view (views *application-frame*))
    (setf (view (car (windows *application-frame*))) view
          (input-state *application-frame*) input-state
          (filepath buffer) filepath)
    (select-layer cursor (car (layers (segment (current-cursor)))))))

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
  (forward-segment (current-cursor)))

(define-gsharp-command (com-backward-segment :name t) ()
  (backward-segment (current-cursor)))

(define-gsharp-command (com-delete-segment :name t) ()
  (delete-segment (current-cursor)))

(define-gsharp-command (com-insert-segment-before :name t) ()
  (let ((cursor (current-cursor)))
    (insert-segment-before (make-instance 'segment :staff (car (staves (current-buffer))))
                           cursor)
    (backward-segment cursor)))

(define-gsharp-command (com-insert-segment-after :name t) ()
  (let ((cursor (current-cursor)))
    (insert-segment-after (make-instance 'segment :staff (car (staves (current-buffer))))
                          cursor)
    (forward-segment cursor)))

(define-gsharp-command (com-set-segment-tempo :name t) ((tempo 'integer :prompt "Tempo"))
  (let ((segment (segment (current-cursor))))
    (setf (tempo segment) tempo)))

(define-gsharp-command (com-set-segment-tuning-regular-temperament :name t)
    ((octave-cents 'cl:number :prompt "Octave size in cents")
     (fifth-cents 'cl:number :prompt "Fifth size in cents")
     (quartertone-cents 'cl:number :prompt "Quartertone size in cents"))
  ;; TODO: prompt for sizes of various microtonal accidentals
  (let ((segment (segment (current-cursor))))
    (setf (tuning segment) (make-instance 'regular-temperament
                                          :octave-cents octave-cents
                                          :fifth-cents fifth-cents
                                          :quartertone-cents quartertone-cents))))

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
    (assert (not (member name (layers (segment (current-cursor)))
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
                                       (layers (segment (current-cursor)))
                                       '()
                                       :action mode
                                       :predicate (constantly t)
                                       :name-key #'name
                                       :value-key #'identity)))
        (simple-parse-error () (error 'no-such-layer)))
    (declare (ignore string))
    (if success layer (error 'no-such-layer))))

(defgeneric find-applicable-gsharp-command-table (layer element))

(defmethod find-applicable-gsharp-command-table ((layer melody-layer) element)
  (declare (ignore element))
  (find-command-table 'total-melody-table))

(defmethod find-applicable-gsharp-command-table ((layer melody-layer) (element rhythmic-element))
  (find-command-table 'total-rhythmic-melody-table))

(defmethod find-applicable-gsharp-command-table ((layer melody-layer) (element cluster))
  (find-command-table 'total-cluster-table))

(defmethod find-applicable-gsharp-command-table ((layer lyrics-layer) element)
  (declare (ignore element))
  (find-command-table 'total-lyrics-table))

(defmethod find-applicable-command-table ((frame gsharp))
  (let* ((cursor (current-cursor))
         (layer (layer cursor))
         (element (if (beginning-of-bar-p cursor) nil (current-element cursor))))
    (find-applicable-gsharp-command-table layer element)))

(define-gsharp-command (com-select-layer :name t) ()
  (let ((selected-layer (accept 'layer :prompt "Select layer")))
    (select-layer (current-cursor) selected-layer)))

(define-gsharp-command (com-rename-layer :name t) ()
  (setf (name (accept 'layer :prompt "Rename layer"))
        (acquire-unique-layer-name "New name of layer")))

(define-gsharp-command (com-add-layer :name t) ()
  (let* ((name (acquire-unique-layer-name "Name of new layer"))
         (staff (accept 'score-pane:staff :prompt "Initial staff of new layer"))
         (new-layer (make-layer (list staff) :name name)))
    (add-layer new-layer (segment (current-cursor)))
    (select-layer (current-cursor) new-layer)))
    
(define-gsharp-command (com-delete-layer :name t) ()
  (delete-layer (current-cursor)))

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
  (head-slice (current-cursor)))

(define-gsharp-command (com-body-slice :name t) ()
  (body-slice (current-cursor)))

(define-gsharp-command (com-tail-slice :name t) ()
  (tail-slice (current-cursor)))

(define-gsharp-command (com-forward-slice :name t) ()
  (forward-slice (current-cursor)))

(define-gsharp-command (com-backward-slice :name t) ()
  (backward-slice (current-cursor)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; bar menu

(make-command-table
 'measure-command-table
 :errorp nil
 :menu '(("Forward" :command (com-forward-measure 1))
         ("Backward" :command (com-backward-measure 1))))

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
  (let ((layer (layer (current-cursor))))
    (setf (staves layer)
          (append (cdr (staves layer)) (list (car (staves layer)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; play menu

(make-command-table
 'play-command-table
 :errorp nil
 :menu '(("Buffer" :command com-play-buffer)
         ("Segment" :command com-play-segment)
         ("Layer" :command com-play-layer)))

(define-gsharp-command (com-play-buffer :name t) ()
  (play-buffer (buffer (current-cursor))))

(define-gsharp-command (com-play-segment :name t) ()
  (play-segment (segment (current-cursor))))

(define-gsharp-command (com-play-layer :name t) ()
  (play-layer (layer (current-cursor))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; main entry points

(defun gsharp (&rest args &key new-process process-name width height)
  "Start a Gsharp session with a fresh empty buffer" 
  (declare (ignore new-process process-name width height))
  (apply #'gsharp-common '(com-new-buffer) args))

(defun edit-file (filename &rest args 
                  &key new-process process-name width height)
  "Start a Gsharp session editing a given file" 
  (declare (ignore new-process process-name width height))
  (apply #'gsharp-common `(esa-io::com-find-file ,filename) args))

(defun gsharp-common (command &key new-process (process-name "Gsharp") width height)
  (let* ((frame (make-application-frame 'gsharp :width width :height height))
         (*application-frame* frame)
         (*esa-instance* frame))
    (adopt-frame (find-frame-manager) *application-frame*)
    (execute-frame-command *application-frame* command)
    (flet ((run () (run-frame-top-level frame)))
      (if new-process
          (clim-sys:make-process #'run :name process-name)
          (run)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; development and debugging aids

;;; FIXME: you might expect that this was in an ESA component, but in
;;; fact it's not.  Maybe it should be?
(define-gsharp-command (com-eval-expression :name t)
    ((expression 'expression :prompt "Eval"))
  "Prompt for and evaluate a lisp expression.
Prints the results in the minibuffer."
  (let* ((*package* (find-package :gsharp))
         (values (multiple-value-list
                  (handler-case (eval expression)
                    (error (condition) 
                      (beep)
                      (display-message "~a" condition)
                      (return-from com-eval-expression nil)))))
         (result (format nil "~:[; No values~;~:*~{~S~^,~}~]" values)))
    (display-message result)))

(define-gsharp-command (com-zoom-in :name t) ()
  (incf (gsharp-buffer::rastral-size (buffer (current-cursor)))))
(define-gsharp-command (com-zoom-out :name t) ()
  (unless (<= (gsharp-buffer::rastral-size (buffer (current-cursor))) 6)
    (decf (gsharp-buffer::rastral-size (buffer (current-cursor))))))
(set-key 'com-zoom-in 'global-gsharp-table '(#\+))
(set-key 'com-zoom-out 'global-gsharp-table '(#\-))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; note insertion commands

(defun insert-cluster ()
  (let* ((state (input-state *application-frame*))
         (cursor (current-cursor))
         (cluster (make-cluster
                   :notehead (notehead state)
                   :lbeams (if (eq (notehead state) :filled) (lbeams state) 0)
                   :rbeams (if (eq (notehead state) :filled) (rbeams state) 0)
                   :dots (dots state)
                   :stem-direction (stem-direction state))))
    (insert-element cluster cursor)
    (forward-element cursor)
    cluster))

(defparameter *current-cluster* nil)
(defparameter *current-note* nil)

(defun insert-note (pitch cluster accidentals)
  (let* ((state (input-state *application-frame*))
         (staff (car (staves (layer (slice (bar cluster))))))
         (note (make-note pitch staff
                 :head (notehead state)
                 :accidentals accidentals
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
  (let* ((new-pitch (compute-and-adjust-note pitch))
	 (accidentals (aref (alterations (keysig (current-cursor))) (mod new-pitch 7))))
    (insert-note new-pitch (insert-cluster) accidentals)))

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
         (cursor (current-cursor))
         (rest (make-rest (car (staves (layer (current-cursor))))
                 :rbeams (if (eq (notehead state) :filled) (rbeams state) 0)
                 :lbeams (if (eq (notehead state) :filled) (lbeams state) 0)
                 :dots (dots state)
                 :notehead (notehead state))))
    (insert-element rest cursor)
    (forward-element cursor)
    rest))

(define-gsharp-command com-insert-empty-cluster ()
  (insert-cluster))  

(defun cur-cluster ()
  (current-cluster (current-cursor)))

(defun cur-element ()
  (current-element (current-cursor)))

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
  (let* ((new-pitch (compute-and-adjust-note pitch))
	 (accidentals (aref (alterations (keysig (current-cursor))) (mod new-pitch 7))))
    (insert-note new-pitch (cur-cluster) accidentals)))

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

(macrolet ((define-duration-altering-command (name &body body)
	       `(define-gsharp-command ,name ()
		 (let ((element (cur-element)))
		   ,@body
		   (gsharp-buffer::maybe-update-key-signatures
		    (bar (current-cursor)))))))
  (define-duration-altering-command com-more-dots ()
    (setf (dots element) (min (1+ (dots element)) 3)))
  (define-duration-altering-command com-fewer-dots ()
    (setf (dots element) (max (1- (dots element)) 0)))
  (define-duration-altering-command com-more-rbeams ()
    (setf (rbeams element) (min (1+ (rbeams element)) 3)))
  (define-duration-altering-command com-fewer-lbeams ()
    (setf (lbeams element) (max (1- (lbeams element)) 0)))
  (define-duration-altering-command com-more-lbeams ()
    (setf (lbeams element) (min (1+ (lbeams element)) 3)))
  (define-duration-altering-command com-fewer-rbeams ()
    (setf (rbeams element) (max (1- (rbeams element)) 0)))
  (define-duration-altering-command com-rotate-notehead ()
    (setf (notehead element)
          (ecase (notehead element)
            (:breve :long)
            (:whole :breve)
            (:half :whole)
            (:filled :half)
            (:long :filled)))))

(define-gsharp-command com-rotate-stem-direction ()
  (setf (stem-direction (cur-cluster))
        (ecase (stem-direction (cur-cluster))
          (:auto :up)
          (:up :down)
          (:down :auto))))

(define-gsharp-command com-toggle-staccato ()
  (let ((cluster (cur-cluster)))
    (if (member :staccato (annotations cluster))
	(setf (annotations cluster) (remove :staccato (annotations cluster)))
	(push :staccato (annotations cluster)))))

(define-gsharp-command com-toggle-tenuto ()
  (let ((cluster (cur-cluster)))
    (if (member :tenuto (annotations cluster))
	(setf (annotations cluster) (remove :tenuto (annotations cluster)))
	(push :tenuto (annotations cluster)))))

(define-gsharp-command com-down ()
  (let ((element (cur-element)))
    (if (typep element 'cluster)
        (let* ((note (cur-note))
               (new-note (make-note (1- (pitch note)) (staff note)
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
              (cursor (current-cursor)))
          (backward-element cursor)
          (delete-element cursor)
          (insert-element (make-rest staff
                            :staff-pos (- staff-pos 2)
                            :notehead notehead :dots dots
                            :rbeams rbeams :lbeams lbeams)
                          cursor)
          (forward-element cursor)))))
    
(define-gsharp-command com-up ()
  (let ((element (cur-element)))
    (if (typep element 'cluster)
        (let* ((note (cur-note))
               (new-note (make-note (1+ (pitch note)) (staff note)
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
              (cursor (current-cursor)))
          (backward-element cursor)
          (delete-element cursor)
          (insert-element (make-rest staff
                            :staff-pos (+ staff-pos 2)
                            :notehead notehead :dots dots
                            :rbeams rbeams :lbeams lbeams)
                          cursor)
          (forward-element cursor)))))

(define-gsharp-command com-octave-down ()
  (let ((element (cur-element)))
    (let* ((note (cur-note))
           (new-note (make-note (- (pitch note) 7) (staff note)
                        :head (head note)
                        :accidentals (accidentals note)
                        :dots (dots note))))
      (remove-note note)
      (add-note element new-note)
      (setf *current-note* new-note))))

(define-gsharp-command com-octave-up ()
  (let ((element (cur-element)))
    (let* ((note (cur-note))
           (new-note (make-note (+ (pitch note) 7) (staff note)
                        :head (head note)
                        :accidentals (accidentals note)
                        :dots (dots note))))
      (remove-note note)
      (add-note element new-note)
      (setf *current-note* new-note))))

(defmacro define-microtonal-accidentals (&rest microaccidentals)
  `(progn
    (setf (symbol-plist 'microsharpen)
          ',(loop for (a b) on microaccidentals
		  if b collect a and collect b
		  else collect a and collect a))
    (setf (symbol-plist 'microflatten)
          ',(loop for (a b) on (reverse microaccidentals)
		  if b collect a and collect b
		  else collect a and collect a))
    (deftype accidental () '(member ,@microaccidentals))
    (defun microsharpen (accidental)
      (or (getf (symbol-plist 'microsharpen) accidental)
	  (error 'type-error :datum accidental :expected-type 'microaccidental)))
    (defun microflatten (accidental)
      (or (getf (symbol-plist 'microflatten) accidental)
	  (error 'type-error :datum accidental :expected-type 'microaccidental)))))

(defmacro define-accidentals (&rest accidentals)
  `(progn
    (deftype accidental () '(member ,@accidentals))
    (defun sharpen (accidental)
      (do ((a (microsharpen accidental) (microsharpen a))
	   (olda accidental a))
	  ((or (eq a olda) (member a ',accidentals)) a)))
    (defun flatten (accidental)
      (do ((a (microflatten accidental) (microflatten a))
	   (olda accidental a))
	  ((or (eq a olda) (member a ',accidentals)) a)))))

(define-microtonal-accidentals :double-flat :sesquiflat :flat :semiflat
			       :natural 
			       :semisharp :sharp :sesquisharp :double-sharp)

(define-accidentals :double-flat :flat :natural :sharp :double-sharp)
    
(define-gsharp-command com-sharper ()
  (let* ((cluster (cur-cluster))
         (note (cur-note))
         (new-note (make-note (pitch note) (staff note)
                     :head (head note)
                     :accidentals (sharpen (accidentals note))
                     :dots (dots note))))
    (remove-note note)
    (add-note cluster new-note)
    (setf *current-note* new-note)))

(define-gsharp-command com-microsharper ()
  ;; FIXME: what are CUR-CLUSTER and CUR-NOTE and how do they relate
  ;; to CURRENT-CLUSTER &c?
  (let* ((cluster (cur-cluster))
         (note (cur-note))
         (new-note (make-note (pitch note) (staff note)
                     :head (head note)
                     :accidentals (microsharpen (accidentals note))
                     :dots (dots note))))
    (remove-note note)
    (add-note cluster new-note)
    (setf *current-note* new-note)))

(define-gsharp-command com-flatter ()
  (let* ((cluster (cur-cluster))
         (note (cur-note))
         (new-note (make-note (pitch note) (staff note)
                     :head (head note)
                     :accidentals (flatten (accidentals note))
                     :dots (dots note))))
    (remove-note note)
    (add-note cluster new-note)
    (setf *current-note* new-note)))

(define-gsharp-command com-microflatter ()
  (let* ((cluster (cur-cluster))
         (note (cur-note))
         (new-note (make-note (pitch note) (staff note)
                     :head (head note)
                     :accidentals (microflatten (accidentals note))
                     :dots (dots note))))
    (remove-note note)
    (add-note cluster new-note)
    (setf *current-note* new-note)))

(define-gsharp-command com-remove-current-note ()
  (let ((cluster (cur-cluster))
        (note (cur-note)))
    (when note
      (remove-note note)
      ;; try to set current-note to the highest note lower than the
      ;; removed note.  If that fails, to the lowest note higher than
      ;; it.
      (setf *current-note* (or (cluster-lower-bound cluster note)
                               (cluster-upper-bound cluster note)))
      (unless *current-note*
        (com-erase-element 1)))))

(defun insert-keysig ()
  (let* ((state (input-state *application-frame*))
         (cursor (current-cursor))
         (staff (car (staves (layer cursor))))
         (keysig (if (keysig cursor)
                     (make-key-signature 
                      staff :alterations (copy-seq (alterations (keysig cursor))))
                     (make-key-signature staff))))
    ;; FIXME: should only invalidate elements temporally after the
    ;; cursor.
    (gsharp-measure::invalidate-everything-using-staff (current-buffer) staff)
    (insert-element keysig cursor)
    (forward-element cursor)
    keysig))

(define-gsharp-command com-insert-keysig ()
  (insert-keysig))

(defun insert-timesig (numerator denominator)
  (let* ((cursor (current-cursor))
         (staff (car (staves (layer cursor))))
         (timesig (make-instance 'time-signature
                                 :staff staff
                                 :components
                                 (list (if denominator
                                           (cons numerator denominator)
                                           numerator)))))
    (insert-element timesig cursor)
    (forward-element cursor)
    timesig))

(define-gsharp-command (com-insert-timesig :name t) 
   ((numerator '(integer 1 8) :prompt "Numerator")
    (denominator '(integer 1 8) :prompt "Denominator"))
  (insert-timesig numerator denominator))

(defmethod remove-element :before ((element staffwise-element) (bar bar))
  (let ((staff (staff element)))
    (setf (staffwise-elements staff)
          (remove element (staffwise-elements staff)))
    (gsharp-measure::invalidate-everything-using-staff (current-buffer) staff)))

;;; FIXME: this isn't quite right (argh) for the case of two
;;; temporally coincident zero-duration elements on the same staff in
;;; different layers: essentially all bets are off.
(defun starts-before-p (thing bar element-or-nil)
  ;; does THING start before the temporal position denoted by BAR and
  ;; ELEMENT-OR-NIL?
  (assert (or (null element-or-nil) (eq (bar element-or-nil) bar)))
  (when (null (bar thing))
    ;; THING is probably the key signature at the start of the piece,
    ;; in which case it is definitely before whatever else happens.
    (assert (typep thing 'key-signature))
    (return-from starts-before-p t))
  (let ((barno (number bar)))
    (cond
      ((> (number (bar thing)) barno) nil)
      ((< (number (bar thing)) barno) t)
      (t (let ((thing-start-time (loop for e in (elements (bar thing))
				       if (eq e element-or-nil)
				       do (return-from starts-before-p nil)
				       until (eq e thing) sum (duration e)))
	       (element-start-time 
		;; this is actually the right answer for
		;; ELEMENT-OR-NIL = NIL, which means "end of bar"
		(loop for e in (elements bar)
		      if (eq e thing) do (return-from starts-before-p t)
		      until (eq e element-or-nil) sum (duration e))))
	   (or (> element-start-time thing-start-time)
	       (and (= element-start-time thing-start-time)
		    (or (null element-or-nil)
			(> (duration element-or-nil) 0)))))))))

(defun %keysig (staff key-signatures bar element-or-nil)
  (or (and key-signatures
	   (find-if (lambda (x) (starts-before-p x bar element-or-nil))
		    key-signatures :from-end t))
      (keysig staff)))

(defmethod keysig ((cursor gsharp-cursor))
  ;; FIXME: not just a cursor but _the_ cursor (i.e. in a given staff)
  ;; otherwise the operation for getting the staff [(CAR (STAVES
  ;; (LAYER CURSOR)))] need not return the staff that we're interested
  ;; in.
  (assert (eq cursor (current-cursor)))
  (let* ((staff (car (staves (layer cursor))))
         (key-signatures (key-signatures staff))
         (bar (bar cursor))
         (element-or-nil (cursor-element cursor)))
    (%keysig staff key-signatures bar element-or-nil)))

(defmethod keysig ((note note))
  (let* ((staff (staff note))
         (key-signatures (key-signatures staff))
         (bar (bar (cluster note)))
         (element-or-nil (cluster note)))
    (%keysig staff key-signatures bar element-or-nil)))

(defmethod keysig ((cluster cluster))
  (error "Called ~S (a staff-scope operation) on an element with no ~
          associated staff: ~S" 
         'keysig cluster))

(defmethod keysig ((element element))
  (let* ((staff (staff element))
         (key-signatures (key-signatures staff))
         (bar (bar element)))
    (%keysig staff key-signatures bar element)))

(define-gsharp-command com-tie-note-left ()
  (let ((note (cur-note)))
    (when note
      (setf (tie-left note) t))))

(define-gsharp-command com-untie-note-left ()
  (let ((note (cur-note)))
    (when note
      (setf (tie-left note) nil))))

(define-gsharp-command com-tie-note-right ()
  (let ((note (cur-note)))
    (when note
      (setf (tie-right note) t))))

(define-gsharp-command com-untie-note-right ()
  (let ((note (cur-note)))
    (when note
      (setf (tie-right note) nil))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; motion by element

(define-gsharp-command com-forward-element 
    ((count 'integer :prompt "Number of Elements" :default 1))
  "Move forward by element."
  (loop repeat count
        do (forward-element (current-cursor))))

(define-gsharp-command com-backward-element 
    ((count 'integer :prompt "Number of Elements" :default 1))
  "Move backward by element."
  (loop repeat count
        do (backward-element (current-cursor))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; motion by measure

(define-gsharp-command com-forward-measure 
    ((count 'integer :prompt "Number of Measures" :default 1))
  "Move forward by measure."
  (loop repeat count do (forward-bar (current-cursor))))

(define-gsharp-command com-backward-measure 
    ((count 'integer :prompt "Number of Measures" :default 1))
  "Move backward by measure."
  (loop repeat count do (backward-bar (current-cursor))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; motion by entire score

(define-gsharp-command com-end-of-score ()
  (loop until (last-segment-p (current-cursor))
        do (forward-segment (current-cursor)))
  (loop until (last-bar-p (current-cursor))
        do (forward-bar (current-cursor)))
  (loop until (end-of-bar-p (current-cursor))
        do (forward-element (current-cursor))))

(define-gsharp-command com-beginning-of-score ()
  (loop until (first-segment-p (current-cursor))
        do (backward-segment (current-cursor)))
  (loop until (first-bar-p (current-cursor))
        do (backward-bar (current-cursor)))
  (loop until (beginning-of-bar-p (current-cursor))
        do (backward-element (current-cursor))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; motion by layout (page or line)

;;; support routines, needed because we're not cacheing the page
;;; breaks (other than in the buffer Obseq) nor the linebreaks (at
;;; all)
(defun position-containing-current-bar (sequence)
  (let ((bar (bar (current-cursor))))
    (position-if (lambda (measure) (member bar (measure-bars measure)))
                 sequence)))
(defun get-page-lines (buffer page-measures)
  (score-pane:with-staff-size (gsharp-buffer::rastral-size buffer)
    (let* (;; all this untimely ripp'd from DRAW-BUFFER in
	   ;; drawing.lisp.  Needs to be kept in sync, otherwise the
	   ;; layout for motion will be different from the layout on
	   ;; the screen...
           (staves (staves buffer))
           (timesig-offset (gsharp-drawing::compute-timesig-offset staves page-measures))
           (method (let ((old-method (buffer-cost-method buffer)))
                     (make-measure-cost-method (min-width old-method)
                                               (spacing-style old-method)
                                               (- (line-width old-method) timesig-offset)
                                               (lines-per-page old-method))))
           (systems-per-page (max 1 (floor 12 (length staves)))))
      (gsharp-drawing::layout-page page-measures systems-per-page method))))

;;; FIXME: these routines should implement numeric-argument handling
(define-gsharp-command (com-forward-page :name t)
    ()
  (let ((cursor (current-cursor)))
    (gsharp-measure::new-map-over-obseq-subsequences
     (lambda (page-measures)
       (let ((position (position-containing-current-bar page-measures)))
         (when position
           (loop repeat (- (length page-measures) position)
                 if (last-bar-p cursor)
                 do (go-to-end-of-bar cursor) (return-from com-forward-page)
                 else do (forward-bar cursor)
                 finally (return-from com-forward-page)))))
     (current-buffer))))
(define-gsharp-command (com-backward-page :name t)
    ()
  (let ((cursor (current-cursor)))
    (gsharp-measure::new-map-over-obseq-subsequences
     (let ((last 0))
       (lambda (page-measures)
         (let ((position (position-containing-current-bar page-measures)))
           (when position
             (loop repeat (+ position last)
                   do (backward-bar cursor)
                   finally (progn
                             (go-to-beginning-of-bar cursor)
                             (return-from com-backward-page)))))
         (setf last (length page-measures))))
     (current-buffer))))

(define-gsharp-command (com-end-of-line :name t)
    ()    
  (let ((buffer (current-buffer))
        (cursor (current-cursor)))
    (gsharp-measure::new-map-over-obseq-subsequences
     (lambda (page-measures)
       (when (position-containing-current-bar page-measures)
         (let ((lines (get-page-lines buffer page-measures)))
           (dolist (line lines)
             (let ((position (position-containing-current-bar line)))
               (when position
                 (loop repeat (- (length line) position 1)
                       do (forward-bar cursor)
                       finally (progn
                                 (go-to-end-of-bar cursor)
                                 (return-from com-end-of-line)))))))))
     buffer)))
(define-gsharp-command (com-beginning-of-line :name t)
    ()    
  (let ((buffer (current-buffer))
        (cursor (current-cursor)))
    (gsharp-measure::new-map-over-obseq-subsequences
     (lambda (page-measures)
       (when (position-containing-current-bar page-measures)
         (let ((lines (get-page-lines buffer page-measures)))
           (dolist (line lines)
             (let ((position (position-containing-current-bar line)))
               (when position
                 (loop repeat position
                       do (backward-bar cursor)
                       finally (progn
                                 (go-to-beginning-of-bar cursor)
                                 (return-from com-beginning-of-line)))))))))
     buffer)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; selecting layers based on layout (next/previous staff)

;;; FIXME: numeric argument handling again
(define-gsharp-command (com-previous-staff :name t)
    ()
  (let ((staff (car (staves (layer (current-cursor))))))
    (loop for (prev curr) on (staves (current-buffer))
	  if (eq curr staff)
	  do (let ((layers (layers (segment (current-cursor)))))
	       (dolist (layer layers)
		 (when (member prev (staves layer))
		   (select-layer (current-cursor) layer)
		   (do ()
		       ((eq prev (car (staves layer))))
		     (com-rotate-staves))
		   (return-from com-previous-staff)))))))
(define-gsharp-command (com-next-staff :name t)
    ()
  (let ((staff (car (staves (layer (current-cursor))))))
    (loop for (curr next) on (staves (current-buffer))
	  if (eq curr staff)
	  do (let ((layers (layers (segment (current-cursor)))))
	       (dolist (layer layers)
		 (when (member next (staves layer))
		   (select-layer (current-cursor) layer)
		   (do ()
		       ((eq next (car (staves layer))))
		     (com-rotate-staves))
		   (return-from com-next-staff)))))))

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

(define-gsharp-command com-delete-element 
    ((count 'integer :prompt "Number of Elements" :default 1))
  "Delete element forwards."
  (let ((cursor (current-cursor)))
    (loop repeat count
          do (progn
               ;; this will signal a condition if in last bar and
               ;; interrupt the execution of the command
               (forward-element cursor)
               (backward-element cursor)
               (if (end-of-bar-p cursor)
                   (fuse-bar-with-next cursor)
                   (delete-element cursor))))))

(define-gsharp-command com-erase-element 
    ((count 'integer :prompt "Number of Elements" :default 1))
  "Delete element backwards."
  (let ((cursor (current-cursor)))
    (loop repeat count
          do (progn
               (backward-element cursor)
               (if (end-of-bar-p cursor)
                   (fuse-bar-with-next cursor)
                   (delete-element cursor))))))

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
          (:breve :long)
          (:whole :breve)
          (:half :whole)
          (:filled :half)
          (:long :filled))))            

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
    (setf (clef staff) (make-clef type :lineno line))))

(define-gsharp-command com-higher ()
  (incf (last-note (input-state *application-frame*)) 7))

(define-gsharp-command com-lower ()
  (decf (last-note (input-state *application-frame*)) 7))

(define-gsharp-command com-insert-barline ()
  (let ((cursor (current-cursor))
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
                                       (staves (current-buffer))
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
                                       (staves (current-buffer))
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
    (if success type (error 'no-such-staff-type))))

(define-presentation-type clef-type ())

(define-presentation-method accept
    ((type clef-type) stream (view textual-view) &key)
  (multiple-value-bind (type success string)
      (handler-case (complete-input stream
                                    (lambda (so-far mode)
                                      (complete-from-possibilities
                                       so-far
                                       '(:treble :treble8 :bass :c :percussion)
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
    (assert (not (member name (staves (current-buffer)) :test #'string= :key #'name))
            () `staff-name-not-unique)
    name))

(defun acquire-new-staff ()
  (let ((name (acquire-unique-staff-name "Name of new staff")))
    (ecase (accept 'staff-type :prompt "Type")
      (:fiveline (let* ((clef-name (accept 'clef-type :prompt "Clef type of new staff"))
                        (line (accept 'integer :prompt "Line of clef"))
                        (clef (make-clef clef-name :lineno line)))
                   (make-fiveline-staff :name name :clef clef)))
      (:lyrics (make-lyrics-staff :name name)))))

(define-gsharp-command (com-insert-staff-above :name t) ()
  (add-staff-before-staff (accept 'score-pane:staff :prompt "Insert staff above staff")
                          (acquire-new-staff)
                          (current-buffer)))

(define-gsharp-command (com-insert-staff-below :name t) ()
  (add-staff-after-staff (accept 'score-pane:staff :prompt "Insert staff below staff")
                         (acquire-new-staff)
                         (current-buffer)))

(define-gsharp-command (com-delete-staff :name t) ()
  (remove-staff-from-buffer (accept 'score-pane:staff :prompt "Staff")
                            (current-buffer)))

(define-gsharp-command (com-rename-staff :name t) ()
  (let* ((staff (accept 'score-pane:staff :prompt "Rename staff"))
         (name (acquire-unique-staff-name "New name of staff"))
         (buffer (current-buffer)))
    (rename-staff name staff buffer)))

(define-gsharp-command (com-add-staff-to-layer :name t) ()
  (let ((staff (accept 'score-pane:staff :prompt "Add staff to layer"))
        (layer (layer (current-cursor))))
    (add-staff-to-layer staff layer)))

;;; FIXME restrict to staves that are actually in the layer. 
(define-gsharp-command (com-delete-staff-from-layer :name t) ()
  (let ((staff (accept 'score-pane:staff :prompt "Delete staff from layer"))
        (layer (layer (current-cursor))))
    (remove-staff-from-layer staff layer)))

(define-gsharp-command com-more-sharps ()
  (more-sharps (keysig (current-cursor))))

(define-gsharp-command com-more-flats ()
  (more-flats (keysig (current-cursor))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Lyrics

(defun insert-lyrics-element ()
  (let* ((state (input-state *application-frame*))
         (cursor (current-cursor))
         (element (make-lyrics-element (car (staves (layer (current-cursor))))
                    :rbeams (if (eq (notehead state) :filled) (rbeams state) 0)
                    :lbeams (if (eq (notehead state) :filled) (lbeams state) 0)
                    :dots (dots state)
                    :notehead (notehead state))))
    (insert-element element cursor)
    (forward-element cursor)
    element))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; I/O

(defmethod frame-make-buffer-from-stream ((frame gsharp) stream)
  (read-buffer-from-stream stream))

(defmethod frame-make-new-buffer ((frame gsharp) &key &allow-other-keys)
  (make-instance 'buffer))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Buffer / View handling

;;; FIXME: these utility functions should live elsewhere.
(defun current-view ()
  (view (current-window)))

(defun not-current-view ()
  (find (current-view) (views *application-frame*) :test (complement #'eq)))

(defun not-current-view-or-first ()
  (or (not-current-view) (car (views *application-frame*))))

(defun next-or-new-buffer-view ()
  (or (not-current-view)
      (progn (com-new-buffer) 
	     (car (views *application-frame*)))))

(define-gsharp-command (com-switch-to-view :name t)
    ((view 'orchestra-view :default (not-current-view-or-first)))
  (setf (view (current-window)) view))

(define-gsharp-command (com-kill-view :name t)
    ((view 'orchestra-view :default (current-view)))
  (let ((views (views *application-frame*)))
    (setf (views *application-frame*) (remove view views))
    (when (eq view (current-view))
      (let ((next-view (next-or-new-buffer-view)))
	(setf (view (current-window)) next-view)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Printing

(defun print-buffer-filename ()
  (let* ((buffer (current-buffer))
         (filepath (filepath buffer))
         (name (name buffer))
         (defaults (or filepath (merge-pathnames (make-pathname :name name)
                                                 (user-homedir-pathname)))))
    (merge-pathnames (make-pathname :type "ps") defaults)))

(define-gsharp-command (com-print-buffer-to-file :name t)
    ((filepath 'pathname
               :prompt "Print To: " :prompt-mode :raw
               :default (print-buffer-filename) :default-type 'pathname
               :insert-default t))
  (with-open-file (ps filepath :direction :output :if-exists :supersede)
    (let* ((type (pathname-type filepath))
           (epsp (string-equal type "EPS")))
      (with-output-to-postscript-stream (s ps :device-type (when epsp :eps))
        (setf (stream-default-view s)
              ;; FIXME: should probably get the class of the view from
              ;; the current buffer or window or something.
              (make-instance 'orchestra-view :light-glyphs-ink +black+ 
                             :buffer (current-buffer) 
                             :cursor (current-cursor)))
        (setf (medium-transformation s)
              ;; FIXME: This scaling works for me (A4 paper, default
              ;; gsharp buffer sizes.
              (compose-scaling-with-transformation 
               (medium-transformation s) 0.8 0.8))
        (print-buffer s (current-buffer) (current-cursor) 
                      (left-margin (current-buffer)) 100)))))
