(in-package :gsharp)

(defun foo-buffer ()
  (let* ((staves (list (make-fiveline-staff)))
         (segment (make-instance 'segment :layers (list (make-layer staves :body (make-slice :bars nil)))))
         (segments (list segment)))
    (let ((staff (car staves)))
      (loop for j upto 2
           for bar = (make-melody-bar)
           do
           (add-bar bar (body (car (layers segment))) j)
           (loop for i upto 3
              for cluster = (make-cluster :notehead :filled)
              for note = (make-note (+ 28 j) staff)
              do (add-note cluster note)
                (add-element cluster bar i))))                
      (make-instance 'buffer :segments segments :staves staves)))
      