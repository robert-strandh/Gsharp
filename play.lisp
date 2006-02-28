(in-package :gsharp-play)

(defun midi-pitch (note)
  (+ (* 12 (+ (floor (pitch note) 7) 1))
     (ecase (mod (pitch note) 7) (0 0) (1 2) (2 4) (3 5) (4 7) (5 9) (6 11))
     (ecase (accidentals note)
       (:double-flat -2) (:flat -1) (:natural 0) (:sharp 1) (:double-sharp 2))))

(defun measure-durations (slices)
  (let ((durations (mapcar (lambda (slice)
			     (mapcar (lambda (bar)
				       (reduce #'+ (elements bar)
					       :key #'duration))
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
		    (remove-if #'tie-left (notes element)))
	    (mapcar (lambda (note)
		      (make-instance 'note-off-message
				     :time (+ time (* 128 (duration element)))
				     :status (+ #x80 channel)
				     :key (midi-pitch note) :velocity 100))
		    (remove-if #'tie-right (notes element))))))

(defun events-from-bar (bar time channel)
  (mapcan (lambda (element)
	    (prog1 (events-from-element element time channel)
	      (incf time (* 128 (duration element)))))
	  (elements bar)))

(defun track-from-slice (slice channel durations)
  (cons (make-instance 'program-change-message
	  :time 0 :status  (+ #xc0 channel) :program 0)
	(let ((time 0))
	  (mapcan (lambda (bar duration)
		    (prog1 (events-from-bar bar time channel)
		      (incf time (* 128 duration))))
		  (bars slice) durations))))

(defun play-segment (segment)
  (let* ((slices (mapcar #'body (layers segment)))
	 (durations (measure-durations slices))
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
    (write-midi-file midifile "test.mid")
    #+cmu
    (ext:run-program "timidity" '("test.mid"))
    #+sbcl
    (sb-ext:run-program "timidity" '("test.mid") :search t)
    #-(or cmu sbcl)
    (error "write compatibility layer for RUN-PROGRAM")))

