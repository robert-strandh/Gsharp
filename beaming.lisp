(in-package :gsharp-beaming)

;;; The beaming function takes a list of the form:
;;; ((p1 x1) (p2 x2) ... (pn xn))
;;; where p1 through pn are staff positions (bottom line is 0, 
;;; increas upwards by 1 for each half staff step) and x1 through xn
;;; are x positions for the clusters given in the same unit as the
;;; positions, i.e., half staff steps

;;; The result of the computation is a VALID BEAMING.  Such a beaming
;;; is represented as a list of two elements representing the left and
;;; the right end of the beam, respectively.  Each element is a cons
;;; of two integers, the fist representing the staff line where the
;;; lower line is numbered 0, and so on in steps of two so that the
;;; upper one is numbered 8.  The second of the two integers
;;; represents the position of the beam with respect to the staff
;;; line, where 0 means straddle, 1 means sit and -1 means hang.  This
;;; representation makes it easy to transform the constellation by
;;; reflection.

;;; Take two notes and compute the beam slant and beam position for the
;;; beam connecting them. A position of zero means the bottom of the
;;; staff. Positive integers count up 1/2 space so that C on a staff
;;; with a G-clef gets to have number -2.  Negative numbers go the other
;;; way. This procedure assumes that pos2 >= pos1.
(defun beaming-single-stemsup-rising-twonotes (pos1 pos2)
  (let ((d (- pos2 pos1))
	(s1 (+ pos2 1))
	(s2 (+ pos2 2))
	(s3 (+ pos2 3))
	(s4 (+ pos2 4))
	(s5 (+ pos2 5))
	(s6 (+ pos2 6)))
    (cond ((<= pos2 -3) (case d
			  (0 `((4 . -1) (4 . -1)))
			  (1 `((4 . -1) (4 .  0)))
			  (t `((4 . -1) (4 .  1)))))
	  ((= pos2 -2) (case d
			 (0 `((4 .  0) (4 . 0)))
			 (1 `((4 . -1) (4 . 0)))
			 (t `((4 . -1) (4 . 1)))))
	  ((= pos2 -1) (case d
			 (0 `((6 . -1) (6 . -1)))
			 (1 `((4 .  0) (4 .  1)))
			 (t `((4 . -1) (4 .  1)))))
	  ((<= pos2 8) (if (evenp pos2)
			   (list (case d
				   (0 `(,s6 .  0))
				   (1 `(,s6 . -1))
				   (2 `(,s4 .  0))
				   (t `(,s4 . -1)))
				 `(,s6 . 0))
			   (list (case d
				   (0 `(,s5 .  1))
				   (1 `(,s5 .  0))
				   (2 `(,s5 . -1))
				   (t `(,s3 .  0)))
				 `(,s5 . 1))))
	  ((evenp pos2) (list (case d
				(0 `(,s4 .  1))
				(1 `(,s4 .  0))
				(2 `(,s4 . -1))
				((3 4 5) `(,s2 . 0))
				(t `(,s2 . -1)))
			      `(,s4 . 1)))
	  (t (list (case d
		     (0 `(,s5 .  0))
		     (1 `(,s5 . -1))
		     (2 `(,s3 .  0))
		     ((3 4 5 6) `(,s3 . -1))
		     (t `(,s1 . 0)))
		   `(,s5 . 0))))))

(defun beaming-double-stemsup-rising-twonotes (pos1 pos2)
  (let ((d (- pos2 pos1))
	(s4 (+ pos2 4))
	(s5 (+ pos2 5))
	(s6 (+ pos2 6))
	(s7 (+ pos2 7)))
    (cond ((<= pos2 -3) (case d
			  (0 `((4 . -1) (4 . -1)))
			  (t `((4 . -1) (4 .  0)))))
	  ((= pos2 -2) (case d
			 (0 `((4 .  0) (4 . 0)))
			 (t `((4 . -1) (4 . 0)))))
	  ((evenp pos2) (list (case d
				(0 `(,s6 .  0))
				(1 `(,s6 . -1))
				(2 `(,s4 .  0))
				(t `(,s4 . -1)))
			      `(,s6 . 0)))
	  (t (case d
	       (0 `((,s7 . -1) (,s7 . -1)))
	       (1 `((,s7 . -1) (,s7 .  0)))
	       (2 `((,s5 . -1) (,s7 . -1)))
	       (t `((,s5 . -1) (,s7 .  0))))))))

(defun reflect-pos (pos)
  (list (- 8 (car pos)) (cadr pos)))

(defun reflect-bpos (pos)
  (cons (- 8 (car pos)) (- (cdr pos))))

(defun beaming-two-points (p1 p2 fun)
  (let* ((beaming (funcall fun (car p1) (car p2)))
	 (left (car beaming))
	 (right (cadr beaming))
	 (x1 (cadr p1))
	 (x2 (cadr p2))
	 (y1 (+ (car left) (* 0.5 (cdr left))))
	 (y2 (+ (car right) (* 0.5 (cdr right))))
	 (slant (/ (- y2 y1) (abs (- x2 x1)))))
    (if (> slant #.(tan (/ (* 18 pi) 180)))
	(progn (incf (car p1)) (beaming-two-points p1 p2 fun))
	beaming)))

;;; main entry

(defun beaming-general (positions stem-direction fun)
  (let* ((first (car positions))
	 (last (car (last positions)))
	 (x1 (cadr first))
	 (x2 (cadr last)))
  (cond ((> (car first) (car last))
	 (reverse (beaming-general (reverse positions) stem-direction fun)))
	((eq stem-direction :down)
	 (mapcar #'reflect-bpos (beaming-general (mapcar #'reflect-pos positions) :up fun)))
	(t (let* ((beaming (beaming-two-points first last fun))
		  (left (car beaming))
		  (right (cadr beaming))
		  (y1 (+ (car left) (* 0.5 (cdr left))))
		  (y2 (+ (car right) (* 0.5 (cdr right))))
		  (minstem (reduce #'min positions
				   :key (lambda (pos)
					  (- (+ y1 (* (- (cadr pos) x1)
						      (/ (- y2 y1)
							 (- x2 x1))))
					     (car pos)))))
		  (increment (* 2 (ceiling (/ (max 0 (- 5 minstem)) 2)))))
	     `((,(+ (car left) increment) . ,(cdr left))
	       (,(+ (car right) increment) . ,(cdr right))))))))

(defun beaming-single (positions stem-direction)
  (beaming-general positions stem-direction #'beaming-single-stemsup-rising-twonotes))

(defun beaming-double (positions stem-direction)
  (beaming-general positions stem-direction #'beaming-double-stemsup-rising-twonotes))
