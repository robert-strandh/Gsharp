(cl:in-package #:gsharp-play)

(defparameter *midi-temp-file* "/tmp/timidity.mid")
(defparameter *midi-player* "timidity")
(defparameter *midi-player-arguments* '())

(defvar *tuning*)
(defvar *tempo*)

(defun midi-pitch (note)
  (round (+ (+ 6900 ; a above middle c, 440 Hz
               (* 1200 (log (/ (master-pitch-freq *tuning*) 440) 2)))
            (- (note-cents note *tuning*)
               (note-cents (master-pitch-note *tuning*) *tuning*)))
         100))

(defun cents-adjustment (note)
  (nth-value 1 (midi-pitch note)))

(defun measure-durations (slices)
  (let ((durations (mapcar (lambda (slice)
                             (mapcar #'duration
                                     (bars slice)))
                           slices)))
    (loop while durations
       collect (reduce #'max durations :key #'car)
       do (setf durations (remove nil (mapcar #'cdr durations))))))

(defun average (list &key (key #'identity))
  (let ((sum 0)
        (count 0))
    (dolist (elem list)
      (incf count)
      (incf sum (funcall key elem)))
    (/ sum count)))

(defun events-from-element (element time channel)
  (when (typep element 'cluster)
    (append (list
             (make-instance 'pitch-bend-message
                            :time time
                            :status (+ #xE0 channel)
                            :value (+ 8192 ;; middle of pitch-bend controller
                                      (round
                                       (* 4096/100 ;; 4096 points per 100 cents
                                          ;; midi can only do per-channel pitch bend,
                                          ;; not per-note pitch bend, so as a sad
                                          ;; compromise we average the pitch bends
                                          ;; of all notes in the cluster
                                          (average (notes element)
                                           :key #'cents-adjustment))))))
            (mapcar (lambda (note)
                      (make-instance 'note-on-message
                                     :time time
                                     :status (+ #x90 channel)
                                     :key (midi-pitch note) :velocity 100))
                    (remove-if #'tie-left (notes element)))
            (mapcar (lambda (note)
                      (make-instance 'note-off-message
                                     :time (+ time (* *tempo* (duration element)))
                                     :status (+ #x80 channel)
                                     :key (midi-pitch note) :velocity 100))
                    (remove-if #'tie-right (notes element))))))

(defun events-from-bar (bar time channel)
  (mapcan (lambda (element)
            (prog1 (events-from-element element time channel)
              (incf time (* *tempo* (duration element)))))
          (elements bar)))

(defun track-from-slice (slice channel durations &key (start-time 0))
        (let ((time start-time))
    (cons (make-instance 'program-change-message
                         :time time :status  (+ #xc0 channel) :program 0)
          (mapcan (lambda (bar duration)
                    (prog1 (events-from-bar bar time channel)
                      (incf time (* *tempo* duration))))
                  (bars slice) durations))))

(define-condition midi-player-failed (gsharp-condition)
  ((midi-player :initarg :midi-player)
   (exit-code :initarg :exit-code))
  (:report
   (lambda (condition stream)
     (with-slots (midi-player exit-code) condition
     (format stream
             "Midi player ~S returned exit code ~S, indicating that an error occurred."
             midi-player exit-code)))))

(defun play-tracks (tracks)
  (let ((midifile (make-instance 'midifile
                     :format 1
                     :division 25
                     :tracks tracks)))
    (write-midi-file midifile *midi-temp-file*)
    (uiop/run-program:run-program
     (cons *midi-player*
           (append *midi-player-arguments*
                   (list *midi-temp-file*))))))

(defun play-layer (layer)
  (let* ((slice (body layer))
         (durations (measure-durations (list slice)))
         (*tempo* (tempo (segment layer)))
         (*tuning* (gsharp-buffer:tuning (segment layer)))
         (tracks (list (track-from-slice slice 0 durations))))
    (play-tracks tracks)))

(defun segment-tracks (segment &key (start-time 0))
  (let* ((slices (mapcar #'body (layers segment)))
         (durations (measure-durations slices))
         (*tempo* (tempo segment))
         (*tuning* (gsharp-buffer:tuning segment)))
    (values (loop
               for slice in slices
               for i from 0
               collect (track-from-slice slice i durations :start-time start-time))
            (reduce #'+ durations))))

(defun play-segment (segment)
  (play-tracks (segment-tracks segment)))

; TODO: There is a short pause between segments?
(defun play-buffer (buffer)
  (let* ((time 0)
         (num-tracks (loop :for segment :in (segments buffer)
                           :maximize (length (layers segment))))
         (tracks (loop :for i :from 0 :below num-tracks :collect nil)))

    ; Collect snippets from each segment that should go to different tracks
    (dolist (segment (segments buffer))
      (let ((*tempo* (tempo segment))
            (*tuning* (tuning segment)))
        (multiple-value-bind (track-addendums segment-duration)
            (segment-tracks segment :start-time time)
          (format t "~S" segment-duration)

          (incf time segment-duration)

          (loop :for track-addendum :in track-addendums
                :for tracks-tail :on tracks
                :do (push track-addendum (car tracks-tail))))))

    ; Concatenate each track's snippets
    (loop :for tracks-tail :on tracks
       :do (setf (car tracks-tail)
                 (reduce (lambda (result snippet)
                           (nconc snippet result))
                         (car tracks-tail)
                         :from-end t)))

    (play-tracks tracks)))
