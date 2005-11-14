(in-package :sdl)

(defvar *fonts-directory*
  (merge-pathnames (make-pathname :directory '(:relative "Fonts"))
		   (make-pathname :directory (pathname-directory *load-truename*))))

(defgeneric glyph (font glyph-no))
(defgeneric glyph-offsets (font glyph-no)
  (:documentation "Return two values, DX and DY to be added to the reference point of
a glyph in order to obtain its upper-left corner.  If (as is usually the case) 
the reference point is somewhere inside the bounding box of the glyph, this
means that both the values returned are negative"))

(defgeneric staff-line-distance (font))
(defgeneric staff-line-offsets (font))
(defgeneric stem-offsets (font))
(defgeneric ledger-line-x-offsets (font))
(defgeneric ledger-line-y-offsets (font))
(defgeneric notehead-right-offsets (font))
(defgeneric notehead-left-offsets (font))
(defgeneric bar-line-offsets (font))
(defgeneric suspended-note-offset (font)
  (:documentation "the x offset of a suspended note compared to that
of a normal note.  This function always returns a positive value"))

(defclass font ()
  ((gf-font :initarg :gf-font :reader gf-font)
   (staff-line-distance :initarg :staff-line-distance :reader staff-line-distance)
   (staff-line-offset-down)
   (staff-line-offset-up)
   (ledger-line-offset-down)
   (ledger-line-offset-up)
   (ledger-line-offset-left)
   (ledger-line-offset-right)
   (stem-offset-left)
   (stem-offset-right)
   (bar-line-offset-left)
   (bar-line-offset-right)
   (notehead-right-x-offset)
   (notehead-right-y-offset)
   (notehead-left-x-offset)
   (notehead-left-y-offset)
   (glyphs :initarg :glyphs :reader glyphs)))
  
(defmethod initialize-instance :after ((font font) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (with-slots (staff-line-distance
	       staff-line-offset-down
	       staff-line-offset-up
	       ledger-line-offset-down
	       ledger-line-offset-up
	       ledger-line-offset-left
	       ledger-line-offset-right
	       stem-offset-left
	       stem-offset-right
	       bar-line-offset-left
	       bar-line-offset-right
	       notehead-right-x-offset
	       notehead-right-y-offset
	       notehead-left-x-offset
	       notehead-left-y-offset) font
    (let ((staff-line-thickness (round (/ (staff-line-distance font) 10))))
      (setf staff-line-offset-down
	    (floor (/ staff-line-thickness 2))
	    staff-line-offset-up
	    (- staff-line-offset-down staff-line-thickness)))
    (let ((stem-thickness (round (/ staff-line-distance 11.9))))
      (setf stem-offset-left
	    (- (floor (/ stem-thickness 2)))
	    stem-offset-right
	    (+ stem-thickness stem-offset-left)))
    (let ((bar-line-thickness (round (/ (staff-line-distance font) 8))))
      (setf bar-line-offset-left
	    (- (floor (/ bar-line-thickness 2)))
	    bar-line-offset-right
	    (+ bar-line-thickness bar-line-offset-left)))
    (let ((ledger-line-thickness (round (/ (staff-line-distance font) 10))))
      (setf ledger-line-offset-down
	    (- (floor (/ ledger-line-thickness 2)))
	    ledger-line-offset-up
	    (+ ledger-line-thickness ledger-line-offset-down)))
    (let ((ledger-line-width (* 5/2 staff-line-distance)))
      (setf ledger-line-offset-left
	    (- (floor (/ ledger-line-width 2)))
	    ledger-line-offset-right
	    (ceiling (/ ledger-line-width 2))))
    (let* ((notehead-width (* 3/2 staff-line-distance))
	   (staff-line-thickness (round (/ (staff-line-distance font) 10)))
	   (yoffset (if (oddp staff-line-thickness) 0.5 0)))
      (setf notehead-right-x-offset
	    (- (ceiling (/ notehead-width 2)) stem-offset-right))
      (setf notehead-left-x-offset
	    (- (+ (floor (/ notehead-width 2)) stem-offset-left)))
      (setf notehead-right-y-offset
	    (round (+ (* 0.25 staff-line-distance) yoffset)))
      (setf notehead-left-y-offset
	    (- (round (- (* 0.25 staff-line-distance) yoffset)))))))

(defgeneric gf-char (glyph))
(defgeneric pixmap (glyph))
(defgeneric (setf pixmap) (glyph pixmap))

(defclass glyph ()
  ((gf-char :initarg :gf-char :reader gf-char)
   (x-offset)
   (y-offset)
   (pixmap :initform nil :initarg :pixmap :accessor pixmap)))

(defmethod initialize-instance :after ((glyph glyph) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (with-slots (gf-char x-offset y-offset) glyph
    (setf x-offset (floor (gf-char-min-m gf-char) 4)
	  y-offset (- (ceiling (1+ (gf-char-max-n gf-char)) 4)))))

(defmethod glyph ((font font) glyph-no)
  (with-slots (gf-char pixmap) (aref (glyphs font) glyph-no)
    (let ((left (floor (gf-char-min-m gf-char) 4))
	  (right (ceiling (1+ (gf-char-max-m gf-char)) 4))
	  (down (floor (gf-char-min-n gf-char) 4))
	  (up (ceiling (1+ (gf-char-max-n gf-char)) 4))
	  (matrix (gf-char-matrix gf-char)))
      (unless pixmap
	(setf pixmap (make-array (list (- up down) (- right left))
					:element-type '(unsigned-byte 8)
					:initial-element 16))
	(loop for r from 0 below (car (array-dimensions matrix))
	      for y downfrom (gf-char-max-n gf-char) by 1 do
	      (loop for c from 0 below (cadr (array-dimensions matrix))
		    for x from (gf-char-min-m gf-char) do
		    (decf (aref pixmap
				(- up (ceiling (1+ y) 4))
				(- (floor x 4) left))
			  (aref matrix r c))))))
    pixmap))

(defmethod glyph-offsets ((font font) glyph-no)
  (with-slots (x-offset y-offset) (aref (glyphs font) glyph-no)
    (values x-offset y-offset)))

;;; the DOWN staff line offset is a nonnegative integer, and the UP
;;; staff line offset is a negative integer.  This way, both of them
;;; should be ADDED to a reference y value to obtain the lower and
;;; upper y coordinates of the staff line.  If the staff line has a
;;; thickness which is an even number of pixels, then the two values
;;; returned have the same magnitude (but opposite signs).  Otherwise
;;; the first value (DOWN) has a magnitude which is one smaller than
;;; that of the second value (UP).  This implies that the y-value of the
;;; reference point for a staff line is either in the middle of the
;;; staff line (if the thickness is even) or half a pixel BELOW the
;;; middle (if the thickness is odd).
(defmethod staff-line-offsets ((font font))
  (with-slots (staff-line-offset-down staff-line-offset-up) font
    (values staff-line-offset-down staff-line-offset-up)))

(defmethod stem-offsets ((font font))
  (with-slots (stem-offset-left stem-offset-right) font
    (values stem-offset-left stem-offset-right)))
  
(defmethod ledger-line-x-offsets ((font font))
  (with-slots (ledger-line-offset-left ledger-line-offset-right) font
    (values ledger-line-offset-left ledger-line-offset-right)))

(defmethod bar-line-offsets ((font font))
  (with-slots (bar-line-offset-left bar-line-offset-right) font
    (values bar-line-offset-left bar-line-offset-right)))

(defmethod ledger-line-y-offsets ((font font))
  (with-slots (ledger-line-offset-down ledger-line-offset-up) font
    (values ledger-line-offset-down ledger-line-offset-up)))

(defmethod notehead-right-offsets ((font font))
  (with-slots (notehead-right-x-offset notehead-right-y-offset) font
    (values notehead-right-x-offset notehead-right-y-offset)))

(defmethod notehead-left-offsets ((font font))
  (with-slots (notehead-left-x-offset notehead-left-y-offset) font
    (values notehead-left-x-offset notehead-left-y-offset)))

(defmethod suspended-note-offset ((font font))
  (with-slots (notehead-left-x-offset notehead-right-x-offset) font
    (- notehead-right-x-offset notehead-left-x-offset)))

(defun load-font (staff-line-distance)
  (let* ((gf-font (parse-gf-file (merge-pathnames
				  (format nil "sdl~a.gf" staff-line-distance)
				  *fonts-directory*)))
	 (maxchar (reduce #'max (gf-font-chars gf-font) :key #'gf-char-no))
	 (glyphs (make-array (list (1+ maxchar)) :initial-element nil)))
    (loop for char in (gf-font-chars gf-font)
	  do (setf (aref glyphs (gf-char-no char))
		   (make-instance 'glyph :gf-char char)))
    (make-instance 'font
      :staff-line-distance staff-line-distance
      :gf-font gf-font
      :glyphs glyphs)))

  