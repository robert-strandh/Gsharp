(in-package :gsharp-play)

(defvar *tuning*)
(defvar *tempo*)

(defun midi-pitch (note)
  (round (+ (+ 6700 ; a above middle c, 440 Hz
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

(defun track-from-slice (slice channel durations)
  (cons (make-instance 'program-change-message
	  :time 0 :status  (+ #xc0 channel) :program 0)
	(let ((time 0))
	  (mapcan (lambda (bar duration)
		    (prog1 (events-from-bar bar time channel)
		      (incf time (* *tempo* duration))))
		  (bars slice) durations))))

(defun play-segment (segment)
  (let* ((slices (mapcar #'body (layers segment)))
	 (durations (measure-durations slices))
         (*tempo* (tempo segment))
         (*tuning* (gsharp-buffer:tuning segment))
	 (tracks (loop for slice in slices
		       for i from 0
		       collect (track-from-slice slice i durations)))
	 (midifile (make-instance 'midifile
		     :format 1
		     :division 25
		     :tracks tracks)))
    (write-midi-file midifile "/tmp/test.mid")
    #+cmu
    (ext:run-program "timidity" '("/tmp/test.mid"))
    #+sbcl
    (sb-ext:run-program "timidity" '("/tmp/test.mid") :search t)
    #-(or cmu sbcl)
    (error "write compatibility layer for RUN-PROGRAM")))

(defun play-layer (layer)
  (let* ((slice (body layer))
	 (durations (measure-durations (list slice)))
	 (tracks (list (track-from-slice slice 0 durations)))
	 (midifile (make-instance 'midifile
		     :format 1
		     :division 25
		     :tracks tracks)))
    (write-midi-file midifile "/tmp/test.mid")
    #+cmu
    (ext:run-program "timidity" '("/tmp/test.mid"))
    #+sbcl
    (sb-ext:run-program "timidity" '("/tmp/test.mid") :search t)
    #-(or cmu sbcl)
    (error "write compatibility layer for RUN-PROGRAM")))
