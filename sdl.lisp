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
(defgeneric beam-offsets (font)
  (:documentation "return two values, both to be added to the 
		   vertical reference point in order to obtain the 
		   bottom and top of the beam (in that order)"))
(defgeneric beam-hang-sit-offset (font)
  (:documentation "return a positive value to be added to (hang) or 
		   subtracted from (sit) the vertical reference point
		   of a staff line, in order to obtain the reference 
		   point of a hanging or sitting beam respectively"))

(defclass font ()
  ((gf-font :initarg :gf-font :reader gf-font)
   ;; The distance in pixels between the upper edge of two 
   ;; adjacent staff lines. 
   (staff-line-distance :initarg :staff-line-distance :reader staff-line-distance)
   ;; An integer value indicating how many non-white pixels are 
   ;; used to draw a staff line.
   (staff-line-thickness)
   ;; An integer value indicating how many non-white pixels are
   ;; used to draw a stem
   (stem-thickness)
   ;; The width of filled and half-note noteheads is always 1.5 times the
   ;; staff line distance.  Since the staff line distance is an even
   ;; number, this width is always an integer.  This is important, because
   ;; we need to position stems very precisely with respect to noteheads.
   ;; and we want the left and right edges of noteheads to fall on integer
   ;; pixel borders. Moreover, by having a fixed proportion, these
   ;; noteheads will have the same proportional width no matter what the
   ;; staff line distance is, which makes the characters look similar at
   ;; different sizes.  However, this means that we cannot make the
   ;; heights of these characters integers.  That is OK, though, since we
   ;; count on anti-aliasing to give the impression of proportional
   ;; sizes.
   (notehead-width)
   ;; While the rule above guarantees that the width of noteheads is an
   ;; integer, it sometimes creates an even integer and sometimes an odd
   ;; integer.  When the width is even, the x-coordinate of the middle of
   ;; the character is between two pixels, which is fine because that is
   ;; how the MetaFont coordinate system works.  When it is odd, however,
   ;; the middle of the character is in the middle of a pixel.  If we were
   ;; to leave it like that, the left and right edges of the character
   ;; would be in the middle of a pixel, which defeats the purpose.  For
   ;; that reason, when the width is odd, we put the reference point of
   ;; the character one half pixel to the left of its middle.
   ;;
   ;; A similar rule holds for vertical reference points.  For instance,
   ;; the reference point of a staff line is the middle of the line if its
   ;; thickness is even and one half pixel below that if it is odd. 
   ;;  
   ;; We do this consistently for stems, staff lines, etc.  Thus, the
   ;; client program can pretend that the reference point is always in the
   ;; middle of the object.  When the object has an odd size the effect is
   ;; simply that everything appears to be off by half a pixel.  We just
   ;; have to watch out with attach points between stems and noteheads.
   ;; In fact, in general, the noteheads may have a different distance
   ;; from the reference point to the left attach point from the distance
   ;; from the reference point to the right attach point.  

   ;; Characters are positioned vertically in multiples of half a staff
   ;; line distance.  An even multiple indicates that the symbol will be
   ;; placed ON A STAFF LINE, and an odd multiple a symbol BETWEEN TWO
   ;; STAFF LINES.  The bottom staff line of a staff has a multiple of
   ;; zero, and the multiple is positive towards the upper edge of the
   ;; page and negative towards the lower edge of the page. 
   ;;
   ;; When the staff line thickness is even, the reference point for
   ;; placing characters is the middle of the staff line or half way
   ;; between two adjacent middles of staff lines.  When the staff line
   ;; thickness is odd, the reference point is located half a pixel lower
   ;; down.  

   ;; A certain number of characters are rotationally symmetric.  But the
   ;; center of the character is usually not the reference point.  Since
   ;; the reference point is (0, 0), we must draw these characters at an
   ;; offset.
   (xoffset)
   ;; The vertical offset from the reference point to the middle of the
   ;; staff line.  This is zero for even staff line thicknesses and 0.5
   ;; otherwise.
   (yoffset)
   (dot-diameter)
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
   (beam-offset-down)
   (beam-offset-up)
   (beam-hang-sit-offset :reader beam-hang-sit-offset)
   (designs :initform (make-hash-table :test #'eq))
   (glyphs :initarg :glyphs :reader glyphs)))
  
(defmethod initialize-instance :after ((font font) &rest initargs &key &allow-other-keys)
  (declare (ignore initargs))
  (with-slots (staff-line-distance
	       staff-line-thickness
	       stem-thickness
	       notehead-width
	       xoffset
	       yoffset
	       dot-diameter
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
	       notehead-left-y-offset
               beam-offset-down
	       beam-offset-up
	       beam-hang-sit-offset) font
    (setf staff-line-thickness (round (/ (staff-line-distance font) 10)))
    (setf xoffset
	  (if (oddp (round (* 1.5 staff-line-distance))) 0.5 0))
    (setf yoffset
	  (if (oddp staff-line-thickness) 0.5 0))
    (setf dot-diameter
	  (min (- staff-line-distance staff-line-thickness 2)
	       (round (/ staff-line-distance 3))))
    (setf staff-line-offset-down
	  (floor (/ staff-line-thickness 2))
	  staff-line-offset-up
	  (- staff-line-offset-down staff-line-thickness))
    ;; we can't use 12 here, because Lisp rounds 0.5 to 0 which
    ;; happens for the smallest staff-line-distance = 6
    (setf stem-thickness (round (/ staff-line-distance 11.999)))
    (setf stem-offset-left
	  (- (floor (/ stem-thickness 2)))
	  stem-offset-right
	  (+ stem-thickness stem-offset-left))
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
    (setf notehead-width (* 3/2 staff-line-distance))
    (setf notehead-right-x-offset
	  (- (ceiling (/ notehead-width 2)) stem-offset-right))
    (setf notehead-left-x-offset
	  (- (+ (floor (/ notehead-width 2)) stem-offset-left)))
    (setf notehead-right-y-offset
	  (round (+ (* 0.25 staff-line-distance) yoffset)))
    (setf notehead-left-y-offset
	  (- (round (- (* 0.25 staff-line-distance) yoffset))))
    (setf beam-offset-down
	  (floor (/ staff-line-distance 2) 2))
    (setf beam-offset-up
	  (- (ceiling (/ staff-line-distance 2) 2)))
    (setf beam-hang-sit-offset
	  (let ((beam-thickness (- beam-offset-down beam-offset-up)))
	    (/ (- beam-thickness staff-line-thickness) 2)))))

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
	  ;; adding 1 to gv-char-max-n is necessary because
	  ;; of a discrepancy between the GF documentation
	  ;; and the GF file format
	  y-offset (- (ceiling (1+ (gf-char-max-n gf-char)) 4)))))

(defmethod glyph ((font font) glyph-no)
  (with-slots (gf-char pixmap) (aref (glyphs font) glyph-no)
    (let ((left (floor (gf-char-min-m gf-char) 4))
	  (right (ceiling (1+ (gf-char-max-m gf-char)) 4))
	  (down (floor (gf-char-min-n gf-char) 4))
	  ;; adding 1 to gv-char-max-n is necessary because
	  ;; of a discrepancy between the GF documentation
	  ;; and the GF file format
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

(defmethod beam-offsets ((font font))
  (with-slots (beam-offset-down beam-offset-up) font
    (values beam-offset-down beam-offset-up)))

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

(defgeneric xyscale (thing kx ky))

(defmethod xyscale ((point number) kx ky)
  (complex (* (realpart point) kx)
	   (* (imagpart point) ky)))

(defmethod xyscale ((region clim:region) kx ky)
  (let ((tr (clim:make-scaling-transformation kx ky)))
    (clim:transform-region tr region)))

(defun scale (thing k)
  (xyscale thing k k))

(defun xscale (thing k)
  (xyscale thing k 1.0))

(defun yscale (thing k)
  (xyscale thing 1.0 k))

(defgeneric translate (thing z))

(defmethod translate ((region clim:region) z)
  (let ((tr (clim:make-translation-transformation (realpart z) (imagpart z))))
    (clim:transform-region tr region)))

(defgeneric rotate (thing angle))

(defmethod rotate ((region clim:region) angle)
  (let ((tr (clim:make-rotation-transformation angle)))
    (clim:transform-region tr region)))

(defgeneric slant (thing slant))

(defmethod slant ((region clim:region) slant)
  (let ((tr (climi::make-slanting-transformation slant)))
    (clim:transform-region tr region)))

(defgeneric compute-design (font shape))

(defun ensure-design (font shape)
  (or (gethash shape (slot-value font 'designs))
      (setf (gethash shape (slot-value font 'designs))
	    (yscale (compute-design font shape) -1))))

(defgeneric draw-shape (sheet font shape x y))

(defmethod draw-shape (sheet (font font) shape x y)
  (let ((design (ensure-design font shape))
	(tr (clim:make-translation-transformation  x y)))
    (clim:draw-design sheet (clim:transform-region tr design))))

;;; default method
(defmethod compute-design ((font font) shape)
  (with-slots (staff-line-distance) font
    (scale +unit-square+ staff-line-distance)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Clefs

;;;                                 w
;;;                                 |
;;;                                 **
;;;                                ****
;;;                               ***** 
;;;                              ** | **
;;;                              ** h **
;;;                             **     **
;;;                            **    g-**
;;;                         v-**-i     **
;;;                           **       ***
;;;                           *        ***
;;;                           *        ***-x
;;;                           *       ****
;;;                            *      ****
;;;                            *      ****
;;;*************************************************************************
;;;                            *    ******
;;;                            *   ******
;;;                             * ******
;;;                             ******
;;;                           ******
;;;                     ee\ ******/dd
;;;*************************************************************************
;;;                       ********
;;;                      *******  *
;;;                     *******   *
;;;                    *******    *
;;;                   *******     *
;;;                   ******   ff\*/gg/c
;;;*************************************************************************
;;;                  ******     ************
;;;                 *****     ****************
;;;              f *****     ******************
;;;               \*****    *****  *  |      ***
;;;                ****  b-****    *  bb      **
;;;        (0, 0)\ ****/y  ***/cc  *       aa\**/d
;;;*************************************************************************
;;;                ****     **      *         **
;;;                 ***      *      *        **
;;;                  **      |      *       **
;;;                   **     a  z ) *      **
;;;                    ***      |    *   **
;;;                       ***************
;;;*************************************************************************
;;;                             |e   *
;;;                         o        *
;;;                         |         *
;;;                        ***        *
;;;                      *******      *
;;;                     *********     *
;;;                   n-*********-p   *
;;;                      ******     s-*-l
;;;                       ****-q r   *
;;;                        **** /  **
;;;                          *******
;;;                             |
;;;                             m
;;;
;;;

(defmethod compute-design ((font font) (shape (eql :g-clef)))
  (with-slots ((sld staff-line-distance) staff-line-thickness
	       stem-thickness yoffset) font
    (let* ((xf 0.0) (yf (* 0.5 sld))
	   (xy (max 2.0 (round (* 0.4 sld)))) (yy (* 0.2 sld))
	   (xb (+ xy (max 2.0 (round (* 0.4 sld))))) (yb (* 0.3 sld))
	   (xcc (+ xb (max 2.0 (round (* 0.4 sld))))) (ycc 0)
	   (xa (+ xcc (max 1.0 (* 0.2 sld)))) (ya (* -0.4 sld))
	   (xc (+ xb (round (* 0.7 sld)))) (yc (+ sld (max 1.0 (* 0.15 sld))))
	   (xd (+ xc sld)) (yd 0.0)
	   (xe (* 1.5 sld)) (ye (+ (- sld) (- (* 0.5 staff-line-thickness))))
	   (xg (round (* 1.8 sld))) (yg (* 3.8 sld))
	   (xw (- xg (* 2.0 staff-line-thickness))) (yw (round (* 5.0 sld)))
	   (xh xw) (yh (- yw (max 2.0 (round (* 0.4 sld)))))
	   (xv (round (* 1.0 sld))) (yv (* 3.5 sld))
	   (xi (+ xv (max 2.0 (* 0.2 sld)))) (yi yv)
	   (xx (+ xg (max 2.0 (round (* 0.3 sld))))) (yx (* 3.5 sld))
	   (bigdot-diameter sld)
	   (yo (- (+ sld (round (* 0.5 sld)))))
	   (xn (round (* 0.5 sld))) (yn (- yo (* 0.5 bigdot-diameter)))
	   (xo (+ xn (* 0.5 bigdot-diameter)))
	   (xp (+ xn bigdot-diameter)) (yp yn)
	   (xq xo) (yq (- yo bigdot-diameter))
	   (xs (+ xp (max 1 (floor (* 0.4 sld))))) (ys yp)
	   (xl (+ xs stem-thickness)) (yl ys)
	   (xm (- xp (* 1 staff-line-thickness))) (ym (round (* -2.75 sld)))
	   (xr xm) (yr (+ ym staff-line-thickness))
	   (xz xe)
	   ;; yz should be slightly above the upper edge of the staff line
	   (yz (+ (- sld) (* 0.7 staff-line-thickness)))
	   (xaa (- xd (max 1 (round (* 0.3 sld))))) (yaa yd)
	   (xbb xc) (ybb (- sld staff-line-thickness (max 2 (* 0.3 sld))))
	   (xdd xp) (ydd (* 2 sld))
	   (xee xn) (yee ydd)
	   (xff (floor (* 1.4 sld))) (yff sld)
	   (xgg (+ xff stem-thickness)) (ygg yff))
      (flet ((c (x y) (complex x y)))
	(translate (mf (c xa ya) ++ (c xb yb) up ++ (c xc yc) right ++
		       (c xd yd) down ++ (c xe ye) left ++ (c xf yf) up ++
		       (c xee yee) ++
		       (c xg yg) up
		       (tensions 1 1.8)
		       (c xh yh)
		       (tensions 1.8 1)
		       (c xi yi)
		       (tensions 1.8 1)
		       (c xgg ygg) (direction #c(1 -4))
		       (tensions 1 20)
		       (c xl yl) down ++
		       (c xm ym) left ++
		       (c xn yn) up ++ (c xo yo) right ++ (c xp yp) down ++
		       (c xq yq) &
		       (c xq yq) ++ (c xr yr) right ++
		       (c xs ys) up
		       (tensions 20 1)
		       (c xff yff) (direction #c(-1 4))
		       (tensions 1 1.8)
		       (c xv yv) up
		       (tensions 1 1.8)
		       (c xw yw) right
		       (tensions 1.8 1)
		       (c xx yx) down ++
		       (c xdd ydd) ++
		       (c xy yy) down ++ (c xz yz) right ++
		       (c xaa yaa) up ++ (c xbb ybb) left ++
		       (c xcc ycc) down ++ (c (+ xa 1) ya) &
		       (c (+ xa 1) ya) ++ cycle)
		   (complex 0 yoffset)))))) ; replace ++ by -- one day

;;;
;;;                    xa  xb             
;;;                      ||
;;;                      ||  xc         xf
;;;                      ||  |          |
;;;    (0, top) *********  **        ****************
;;;             *********  **      ********************
;;;             *********  **     ****     |   **********
;;;             *********  **    ***       |      ********
;;;             *********  **    ***      (xg,yg)   *******
;;;             *********  **    *****              ********
;;;             *********  **    *******            ********
;;;             *********  **    ********           ********
;;;             *********  **    ********           ********
;;;             *********  **   | ******            ********
;;;             *********  **   |   **___yd         ********
;;;             *********  **   xd                  ********
;;;             *********  **            (xj,yj)--  ********
;;;             *********  **                       ********
;;;             *********  **        (xe,ye)        ********
;;;             *********  **         |             ********--(xk,yk)
;;;             *********  **         **            ********
;;;             *********  **        ****           ********
;;;             *********  **        ****   (xh,yh) ********
;;;             *********  **       ******    |    *******
;;;             *********  **       *******   |   ******
;;;             *********  **      ***** *************
;;;             *********  **      **** |_____       
;;;             *********  **   ******        (xl,yl)
;;;      (0, 0) *********  ***********--xi
;;;             *********  ***********  
;;;             *********  **   *******   
;;;             *********  **      ****   
;;;             *********  **      ***** *************
;;;             *********  **       *******       ******
;;;             *********  **       ******         *******
;;;             *********  **        ****           ********
;;;             *********  **        ****           ********
;;;             *********  **         **            ********
;;;             *********  **                       ********
;;;             *********  **                       ********
;;;             *********  **                       ********
;;;             *********  **                       ********
;;;             *********  **       **              ********
;;;             *********  **     ******            ********
;;;             *********  **    ********           ********
;;;             *********  **    ********           ********
;;;             *********  **    *******            ********
;;;             *********  **    *****              ********
;;;             *********  **    ***                *******
;;;             *********  **    ***              ********
;;;             *********  **     ****         **********
;;;             *********  **      ********************
;;;             *********  **        ****************


;;; The x coordinate of the reference point is always on the left edge 
;;; of the character.  The y coordinate of the reference point is the 
;;; top edge of the staff line on which the character sits.

;;; since the character is symmetric around the staff line, we only 
;;; have to define the upper curve, then we draw it both unmodified and
;;; reflected + shifted the thickness of the staff line.

(defmethod compute-design ((font font) (shape (eql :c-clef)))
  (with-slots ((sld staff-line-distance) staff-line-thickness) font
    (flet ((c (x y) (complex x y)))
      (let* ( ;; define some x coordinates
	     (xa (ceiling (* 0.5 sld)))
	     (xb (+ xa (max 2 (round (* 0.25 sld)))))
	     (xc (+ xb (max 1 (round (* 0.20 sld)))))
	     (xd (+ xc (max 2 (round (* 0.25 sld)))))
	     (dot-width (floor (* 0.5 sld)))
	     (xe (+ xd (round (* 0.5 dot-width))))
	     (xf (+ xd dot-width))
	     (xg (+ xd (* 1.5 dot-width)))
	     (xj (+ xd sld))
	     (xh (* 0.5 (+ xe xj)))
	     (xi xe)
	     (xk (+ xj (ceiling (* 0.5 sld))))
	     (xl (+ xe (round staff-line-thickness)))
	     ;; define some y coordinates
	     (top (* 2 sld))
	     (yd (+ sld (max 1 (round (* 0.1 sld)))))
	     (ye sld)
	     (yg (- top (* 2 staff-line-thickness)))
	     (yh (round (* 0.4 sld)))
	     (yj ye)
	     (yk yj)
	     (yl yh)
	     (p (mf (c xc 0) (direction #c(2 1)) ++
		    (direction #c(1 2)) (c xe ye) &
		    (c xe ye) -- (c (1+ xe) ye) &
		    (c (1+ xe) ye) (direction #c(1 -2)) ++
		    (c xh yh) right ++ (c xj yj) up ++
		    (c xg yg) left ++
		    (direction #c(-1 -2)) (c (+ xd (* 0.5 dot-width)) (+ yd dot-width)) &
		    (c (+ xd (* 0.5 dot-width)) (+ yd dot-width)) right ++
		    (c (+ xd dot-width) (+ yd (* 0.5 dot-width))) down ++
		    (c (+ xd (* 0.5 dot-width)) yd) left ++
		    (c xd (+ yd (* 0.5 dot-width))) up ++ (c xf top) right ++
		    (c xk yk) down ++ (c xh (- yh staff-line-thickness)) ++
		    (c xl yl) & (c xl yl) ++ down (c xi 0)))
	     (q (translate (yscale p -1) (c 0 (- staff-line-thickness))))
	     (r (climi::close-path
		 (reduce #'clim:region-union
			 (list p
			       (mf (c xi 0) -- (c xi (- staff-line-thickness)))
			       (climi::reverse-path q)
			       (mf (c xc (- staff-line-thickness)) -- (c xc 0)))))))
	(clim:region-union
	 (climi::close-path (mf (c 0 top) -- (c xa top) --
				(c xa (- top)) --
				(c 0 (- top)) -- (c 0 top)))
	 (clim:region-union
	  (climi::close-path (mf (c xb top) -- (c xc top) --
				 (c xc (- top)) --
				 (c xb (- top)) -- (c xb top)))
	  (translate r (c 0 staff-line-thickness))))))))

;;;                                                                       
;;;                                                                       
;;;                  i                                                    
;;;                  |                                                    
;;;***********************************************************************
;;;             *********                 |xj                             
;;;           **  |      **              ***                              
;;;          **   e       ***           *****_yj                          
;;;         **             ***          *****                             
;;;        *** |d           ***          ***                              
;;;  (0,0)\** ***            ***                                          
;;;***********************************************************************
;;;        *********          ***                                         
;;;      a-*********-c        ****       ***                              
;;;        *********          ****      *****_yk                         
;;;         *******         f-****-h    *****                            
;;;           ***             ****       ***                             
;;;            |b             ****                                        
;;;***********************************************************************
;;;                           ****                                        
;;;                          ****                                         
;;;                         ****                                          
;;;                        ****                                           
;;;                       ***                                             
;;;                     ***                                               
;;;***********************************************************************
;;;                  ***                                                  
;;;                ***                                                    
;;;              ***                                                      
;;;           ***                                                         
;;;      g-***                                                            
;;;        |                                                              
;;;         g + (0, -1)                                                   
;;;***********************************************************************
;;;                                                                       
;;;                                                                       
;;;                                                                       

(defmethod compute-design ((font font) (shape (eql :f-clef)))
  (with-slots ((sld staff-line-distance) staff-line-thickness dot-diameter) font
    (flet ((c (x y) (complex x y)))
      (let* ((bigdot-diameter sld)
	     (yd (round (* 0.2 sld)))
	     (xa 0.0) (ya (- yd (* 0.5 bigdot-diameter)))
	     (xb (+ xa (* 0.5 bigdot-diameter))) (yb (- yd bigdot-diameter))
	     (xc (+ xa bigdot-diameter)) (yc ya)
	     (xd xb)
	     (xe (* 0.85 sld)) (ye (- sld (* 2.0 staff-line-thickness)))
	     (xf (round (* 1.5 sld))) (yf (- 0.3 sld))
	     (xg 0.0) (yg (* -2.5 sld))
	     (xh (+ xf (round (* 0.5 sld)))) (yh yf)
	     (xi sld) (yi sld)
	     (xj (+ xh (max 1.0 (round (* 0.2 sld))) (* 0.5 dot-diameter)))
	     (yj (round (* 0.5 (- sld staff-line-thickness))))
	     (yk (- (- staff-line-thickness) yj))
	     (p (mf (c xa ya) down ++
		    (c xb yb) right ++
		    (c xc yc) up ++
		    left (c xd yd) &
		    (c xd yd) ++
		    (c xe ye) right ++
		    (c xf yf) (direction #c(-0.2 -1)) ++ (curl 3) 
		    (c xg yg) &
		    (c xg yg) --
		    (c xg (1- yg)) &
		    (c xg (1- yg)) (curl 3) ++
		    (c xh yh) (direction #c(0.2 1)) ++
		    (c xi yi) left ++ cycle)))
	(clim:region-union
	 (translate p (c 0 staff-line-thickness))
	 (clim:region-union
	  (translate (scale +full-circle+ dot-diameter)
		     (c xj (+ yj staff-line-thickness)))
	  (translate (scale +full-circle+ dot-diameter)
		     (c xj (+ yk staff-line-thickness)))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Noteheads

(defparameter *filled-path*
  (mf #c(-0.75 -0.25) up ++ #c(0.33 0.58) right ++
      #c(0.75 0.25) down ++ #c(-0.33 -0.58) left ++ cycle))

(defparameter *half-path*
  (mf #c(-0.75 -0.25) up (tension 0.8) #c(0.33 0.58) right ++
      #c(0.75 0.25) down (tension 0.8) #c(-0.33 -0.58) left ++ cycle))

(defmethod compute-design ((font font) (shape (eql :filled-notehead)))
  (with-slots (xoffset yoffset staff-line-distance) font
    (translate (scale *filled-path* staff-line-distance)
	       (complex xoffset yoffset))))

(defmethod compute-design ((font font) (shape (eql :whole-notehead)))
  (with-slots (xoffset yoffset (sld staff-line-distance)) font
    (let ((op (scale (superellipse #c(0.75 0.0) #c(0.0 0.58)
				   #c(-0.75 0.0) #c(0.0 -0.58) 0.7)
		     sld))
	  (ip (scale (slant (superellipse #c(0.3 0.0) #c(0.0 0.35)
				   #c(-0.3 0.0) #c(0.0 -0.35) 0.8)
			    -0.3)
		     sld)))
      (translate (clim:region-difference op (climi::reverse-path ip))
		 (complex xoffset yoffset)))))

(defmethod compute-design ((font font) (shape (eql :half-notehead)))
  (with-slots (xoffset yoffset (sld staff-line-distance)) font
    (clim:region-difference
     (translate (scale *half-path* sld) (complex xoffset yoffset))
     (translate
      (scale
       (rotate
	(superellipse #c(0.6 0) #c(0 0.2) #c(-0.6 0) #c(0 -0.2) 0.707)
	(/ pi 6))
       sld)
      (complex xoffset yoffset)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Dot

;;; The dot is complicated, because there are several contradicting
;;; constraints that it must satisfy.  For one thing, it is rotationally
;;; symmetric.  For that reason, we cannot use a different xoffset and
;;; yoffset for the dot.  Also, the dot is used for several different
;;; purposes.  When used in a dotted note, it is aligned in the middle
;;; of the space between two staff lines, and must thus be aligned
;;; vertically the same way as a notehead is.  But it is also used as a
;;; staccato dot, in which case it must be horizontally aligned the same
;;; way as the noteheads are.  This restriction is more important the
;;; lower the resolution is.  

;;; Let us see how this works.  For a staff line distance of 6 (the
;;; smallest), vertical and horizontal alignments are the same: the
;;; space between staff lines is 5 pixels and the note is 9 pixels wide;
;;; both odd values.  For a staff line distance of 8, it does not work.
;;; The space is 7 pixels, so odd, but noteheads are 12 pixels wide so
;;; even.  We think it is more important that the dot be aligned
;;; vertically, and that half a pixel of horizontal offset is not a
;;; problem for the staccato dot.  We thus use yoffset for the alignment
;;; both vertically and horizontally. 

;;; Ross says the dot should be roughly a third of the staff line
;;; distance, but in his examples, it is closer to half a staff line
;;; distance.  Compromise by using 0.4.  We count on anti aliasing to
;;; save us from too ugly a result when the edges do not fall on pixel
;;; boundaries.

(defmethod compute-design ((font font) (shape (eql :dot)))
  (with-slots (yoffset staff-line-distance) font
    (let ((diameter (* 0.4 staff-line-distance)))
      (translate (scale +full-circle+ diameter)
		 (complex yoffset yoffset)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Ties

(defun small-tie-up (sld slt width)
  (let* ((thickness (round (* 0.33 sld)))
	 (height (* 0.5 sld))
	 (top (* 0.5 (+ sld slt height))))
    (flet ((c (x y) (complex x y)))
      (mf (c 0 top) right ++
	  (c width (- top height)) --
	  (c (- width 1.0) (- top height)) ++
	  (c (* 0.5 width) (- top thickness)) ++
	  (c 0.0 (- top thickness)) ++
	  (c (* -0.5 width) (- top thickness)) ++
	  (c (- (- width 1)) (- top height)) --
	  (c (- width) (- top height)) ++ cycle))))

(defmethod compute-design ((font font) (shape (eql :small-tie-1-up)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (small-tie-up sld slt (round (* 0.33 sld)))))

(defmethod compute-design ((font font) (shape (eql :small-tie-2-up)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (small-tie-up sld slt (round (* 0.67 sld)))))

(defmethod compute-design ((font font) (shape (eql :small-tie-3-up)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (small-tie-up sld slt (round (* 1.0 sld)))))

(defmethod compute-design ((font font) (shape (eql :small-tie-4-up)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (small-tie-up sld slt (round (* 1.33 sld)))))

(defmethod compute-design ((font font) (shape (eql :small-tie-5-up)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (small-tie-up sld slt (round (* 1.67 sld)))))

(defmethod compute-design ((font font) (shape (eql :small-tie-6-up)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (small-tie-up sld slt (round (* 2.0 sld)))))

(defmethod compute-design ((font font) (shape (eql :small-tie-7-up)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (small-tie-up sld slt (round (* 2.33 sld)))))

(defmethod compute-design ((font font) (shape (eql :small-tie-8-up)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (small-tie-up sld slt (round (* 2.67 sld)))))


(defun small-tie-down (sld slt width)
  (let* ((thickness (round (* 0.33 sld)))
	 (height (* 0.5 sld))
	 (bot (* 0.5 (+ (- sld slt) height))))
    (flet ((c (x y) (complex x y)))
      (mf (c 0 (- bot)) right ++
	  (c width (- height bot)) --
	  (c (- width 1) (- height bot)) ++
	  (c (* 0.5 width) (- thickness bot)) ++
	  (c 0 (- thickness bot)) ++
	  (c (* -0.5 width) (- thickness bot)) ++
	  (c (- (- width 1.0)) (- height bot)) --
	  (c (- width) (- height bot)) ++ cycle))))

(defmethod compute-design ((font font) (shape (eql :small-tie-1-down)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (small-tie-down sld slt (round (* 0.33 sld)))))

(defmethod compute-design ((font font) (shape (eql :small-tie-2-down)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (small-tie-down sld slt (round (* 0.67 sld)))))

(defmethod compute-design ((font font) (shape (eql :small-tie-3-down)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (small-tie-down sld slt (round (* 1.0 sld)))))

(defmethod compute-design ((font font) (shape (eql :small-tie-4-down)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (small-tie-down sld slt (round (* 1.33 sld)))))

(defmethod compute-design ((font font) (shape (eql :small-tie-5-down)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (small-tie-down sld slt (round (* 1.67 sld)))))

(defmethod compute-design ((font font) (shape (eql :small-tie-6-down)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (small-tie-down sld slt (round (* 2.0 sld)))))

(defmethod compute-design ((font font) (shape (eql :small-tie-7-down)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (small-tie-down sld slt (round (* 2.33 sld)))))

(defmethod compute-design ((font font) (shape (eql :small-tie-8-down)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (small-tie-down sld slt (round (* 2.67 sld)))))

(defun large-tie-up (sld slt width-multiplier)
  (declare (ignore slt))
  (let* ((thickness (round (* 0.33 sld)))
	 (height (round (* 1.0 sld)))
	 (top (round (* 11/6 sld)))
	 (width (* width-multiplier sld)))
    (flet ((c (x y) (complex x y)))
      (mf (c 0.0 top) right ++
	  (c width (- top height)) --
	  (c (- width 1.0) (- top height)) ++
	  (c (* 0.3 width) (- top thickness)) ++
	  (c 0.0 (- top thickness)) ++
	  (c (* -0.3 width) (- top thickness)) ++
	  (c (- (- width 1.0)) (- top height)) --
	  (c (- width) (- top height)) ++ cycle))))

(defun large-tie-up-left (sld slt width-multiplier)
  (declare (ignore slt))
  (let* ((thickness (round (* 0.33 sld)))
	 (height (round (* 1.0 sld)))
	 (top (round (* 11/6 sld)))
	 (width (* width-multiplier sld)))
    (flet ((c (x y) (complex x y)))
      (climi::close-path
       (mf (c 0.0 top) left ++
           (c (- width) (- top height)) --
           (c (- (- width 1.0)) (- top height)) ++
           (c (* -0.3 width) (- top thickness)) ++
           (c 0.0 (- top thickness)) &
           (c 0.0 (- top thickness)) -- (c 0.0 top))))))

(defun large-tie-up-right (sld slt width-multiplier)
  (declare (ignore slt))
  (let* ((thickness (round (* 0.33 sld)))
	 (height (round (* 1.0 sld)))
	 (top (round (* 11/6 sld)))
	 (width (* width-multiplier sld)))
    (flet ((c (x y) (complex x y)))
      (climi::close-path
       (mf (c 0.0 top) right ++
           (c width (- top height)) --
           (c (- width 1.0) (- top height)) ++
           (c (* 0.3 width) (- top thickness)) ++
           (c 0.0 (- top thickness)) &
           (c 0.0 (- top thickness)) -- (c 0.0 top))))))

(defmethod compute-design ((font font) (shape (eql :large-tie-1-up)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-up sld slt 2.0)))

(defmethod compute-design ((font font) (shape (eql :large-tie-2-up)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-up sld slt 2.33)))

(defmethod compute-design ((font font) (shape (eql :large-tie-3-up)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-up sld slt 2.67)))

(defmethod compute-design ((font font) (shape (eql :large-tie-4-up)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-up sld slt 3.0)))

(defmethod compute-design ((font font) (shape (eql :large-tie-5-up)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-up sld slt 3.33)))

(defmethod compute-design ((font font) (shape (eql :large-tie-6-up)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-up sld slt 3.67)))

(defmethod compute-design ((font font) (shape (eql :large-tie-7-up)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-up sld slt 4.0)))

(defmethod compute-design ((font font) (shape (eql :large-tie-8-up)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-up sld slt 4.33)))

(defmethod compute-design ((font font) (shape (eql :large-tie-9-up)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-up sld slt 4.67)))

(defmethod compute-design ((font font) (shape (eql :large-tie-10-up)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-up sld slt 5.0)))

(defmethod compute-design ((font font) (shape (eql :large-tie-up-left)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-up-left sld slt 5.0)))

(defmethod compute-design ((font font) (shape (eql :large-tie-up-right)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-up-right sld slt 5.0)))

(defun large-tie-down (sld slt width-multiplier)
  (let* ((thickness (round (* 0.33 sld)))
	 (height (round (* 1.0 sld)))
	 (bot (- (round(* 11/6 sld)) slt))
	 (width (* width-multiplier sld)))
    (flet ((c (x y) (complex x y)))
      (mf (c 0.0 (- bot)) right ++
	  (c width (- height bot)) --
	  (c (- width 1.0) (- height bot)) ++
	  (c (* 0.3 width) (- thickness bot)) ++
	  (c 0.0 (- thickness bot)) ++
	  (c (* -0.3 width) (- thickness bot)) ++
	  (c (- (- width 1.0)) (- height bot)) --
	  (c (- width) (- height bot)) ++ cycle))))

(defun large-tie-down-left (sld slt width-multiplier)
  (let* ((thickness (round (* 0.33 sld)))
	 (height (round (* 1.0 sld)))
	 (bot (- (round(* 11/6 sld)) slt))
	 (width (* width-multiplier sld)))
    (flet ((c (x y) (complex x y)))
      (climi::close-path
       (mf (c 0.0 (- bot)) left ++
           (c (- width) (- height bot)) --
           (c (- (- width 1.0)) (- height bot)) ++
           (c (* -0.3 width) (- thickness bot)) ++
           (c 0.0 (- thickness bot)) &
           (c 0.0 (- thickness bot)) -- (c 0.0 (- bot)))))))

(defun large-tie-down-right (sld slt width-multiplier)
  (let* ((thickness (round (* 0.33 sld)))
	 (height (round (* 1.0 sld)))
	 (bot (- (round(* 11/6 sld)) slt))
	 (width (* width-multiplier sld)))
    (flet ((c (x y) (complex x y)))
      (climi::close-path
       (mf (c 0.0 (- bot)) right ++
           (c width (- height bot)) --
           (c (- width 1.0) (- height bot)) ++
           (c (* 0.3 width) (- thickness bot)) ++
           (c 0.0 (- thickness bot)) &
           (c 0.0 (- thickness bot)) -- (c 0.0 (- bot)))))))

(defmethod compute-design ((font font) (shape (eql :large-tie-1-down)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-down sld slt 2.0)))

(defmethod compute-design ((font font) (shape (eql :large-tie-2-down)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-down sld slt 2.33)))

(defmethod compute-design ((font font) (shape (eql :large-tie-3-down)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-down sld slt 2.67)))

(defmethod compute-design ((font font) (shape (eql :large-tie-4-down)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-down sld slt 3.0)))

(defmethod compute-design ((font font) (shape (eql :large-tie-5-down)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-down sld slt 3.33)))

(defmethod compute-design ((font font) (shape (eql :large-tie-6-down)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-down sld slt 3.67)))

(defmethod compute-design ((font font) (shape (eql :large-tie-7-down)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-down sld slt 4.0)))

(defmethod compute-design ((font font) (shape (eql :large-tie-8-down)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-down sld slt 4.33)))

(defmethod compute-design ((font font) (shape (eql :large-tie-9-down)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-down sld slt 4.67)))

(defmethod compute-design ((font font) (shape (eql :large-tie-10-down)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-down sld slt 5.0)))

(defmethod compute-design ((font font) (shape (eql :large-tie-down-left)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-down-left sld slt 5.0)))

(defmethod compute-design ((font font) (shape (eql :large-tie-down-right)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)) font
    (large-tie-down-right sld slt 5.0)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Accidentals

(defmethod compute-design ((font font) (shape (eql :sharp)))
  (with-slots ((sld staff-line-distance)
	       (slt staff-line-thickness)
	       stem-thickness
	       yoffset) font
    (let* (;; A factor that determines the space between the vertical
	   ;; bars and the outer edge of the character as a fraction of
	   ;; the staff line distance
	   (edge-distance-multiplier 0.2)
	   ;; A factor that determines the height of the thin part as a
	   ;; fraction of the staff line distance
	   (height-multiplier 2.5)
	   ;; A factor that determines the width of the hole as a fraction of the
	   ;; staff line distance.
	   (hole-width-multiplier 0.33)
	   (hole-width (round (* hole-width-multiplier sld)))
	   ;; Hope that half a pixel will not be visible and will not influence 
	   ;; the required distance to the noteheads.
	   (xoffset (if (oddp hole-width) 0.5 0))
	   (edge-distance (* edge-distance-multiplier sld))
	   (width (+ hole-width (* 2 stem-thickness) (* 2 edge-distance)))
	   (xleft (* -0.5 width))
	   (xright (- xleft))
	   (yleft (* -0.15 width))
	   (yright (- yleft))
	   ;; The path for the thick part symmetric around (0, 0)
	   (thickpart (mf (complex xleft yleft) -- (complex xright yright)))
	   ;; Determine the y coordinate of the previous path at the
	   ;; cross point of the thin part.  Use congruent triangles.
	   (ythin (/ (* (- xright edge-distance) yright) xright))
	   (height (* height-multiplier sld))
	   ;; The path for the thin part symmetric around (0, 0)
	   (thinpart (mf (complex 0 (* 0.5 height)) -- (complex 0 (* -0.5 height)))))
      (clim:region-union
       (with-pen (rotate (scale +razor+ (* 0.4 sld)) (/ pi 2))
	 (clim:region-union (draw-path (translate thickpart
						  (complex xoffset (+ yoffset (* 0.5 sld)))))
			    (draw-path (translate thickpart
						  (complex xoffset (+ yoffset (* -0.5 sld)))))))
       (with-pen (scale +razor+ stem-thickness)
	 (clim:region-union (draw-path (translate thinpart
						  (complex (- xoffset
							      (* 0.5 hole-width)
							      (* 0.5 stem-thickness))
							   (- yoffset ythin))))
			    (draw-path (translate thinpart
						  (complex (+ xoffset
							      (* 0.5 hole-width)
							      (* 0.5 stem-thickness))
							   (+ yoffset ythin))))))))))

(defmethod compute-design ((font font) (shape (eql :double-sharp)))
  (with-slots ((sld staff-line-distance) xoffset yoffset) font
    (flet ((c (x y) (complex x y)))
      (let* ((offset (ceiling (* 0.1 sld)))
	     (leg (climi::close-path (mf (c 0 0) -- (c offset 0) (direction #c(1 1)) ++
					 right (c (* 0.5 sld) offset) --
					 (* 0.55 sld (c 1 1)) --
					 (c offset (* 0.5 sld)) down ++
					 (direction #c(-1 -1)) (c 0 offset) -- (c 0 0)))))
	(reduce #'clim:region-union
		(list (translate leg (c xoffset yoffset))
		      (translate (rotate leg (* pi 0.5)) (c xoffset yoffset))
		      (translate (rotate leg (* pi 1.0)) (c xoffset yoffset))
		      (translate (rotate leg (* pi 1.5)) (c xoffset yoffset))))))))

(defmethod compute-design ((font font) (shape (eql :flat)))
  (with-slots ((sld staff-line-distance) stem-thickness) font
    (flet ((c (x y) (complex x y)))
      (let* ((outer (xyscale (translate +half-circle+ #c(-0.5 0))
			     sld (* 1.2 sld)))
	     (inner (scale (translate +half-circle+ #c(-0.6 0))
			   (* 0.8 sld)))
	     (middle (mf (climi::path-end outer) -- (climi::path-end inner)))
	     (finish (mf (climi::path-start inner) -- (climi::path-start outer)))
	     (combined (climi::close-path
			(reduce #'clim:region-union
				(list outer middle (climi::reverse-path inner) finish)))))
	(clim:region-union (translate (rotate (slant combined -0.6) (- (/ pi 2)))
				      (c (round (* -0.2 sld)) (* -0.5 sld)))
			   (with-pen (scale +razor+ stem-thickness)
			     (draw-path (mf (c (- (round (* -0.2 sld)) (* 0.5 stem-thickness))
					       (* 1.5 sld))
					    --
					    (c (- (round (* -0.2 sld)) (* 0.5 stem-thickness))
					       (* -0.5 sld))))))))))

(defmethod compute-design ((font font) (shape (eql :double-flat)))
  (with-slots ((sld staff-line-distance) stem-thickness) font
    (flet ((c (x y) (complex x y)))
      (let* ((outer (xyscale (translate +half-circle+ #c(-0.5 0))
			   sld (* 1.2 sld)))
	     (inner (scale (translate +half-circle+ #c(-0.6 0))
			   (* 0.8 sld)))
	     (middle (mf (climi::path-end outer) -- (climi::path-end inner)))
	     (finish (mf (climi::path-start inner) -- (climi::path-start outer)))
	     (combined (climi::close-path
			(reduce #'clim:region-union
				(list outer middle (climi::reverse-path inner) finish)))))
	(clim:region-union
	 (clim:region-union (translate (rotate (slant combined -0.6) (- (/ pi 2)))
				       (c (round (* -0.2 sld)) (* -0.5 sld)))
			    (translate (rotate (slant combined -0.6) (- (/ pi 2)))
				       (c (round (* -0.85 sld)) (* -0.5 sld))))
	 (clim:region-union (with-pen (scale +razor+ stem-thickness)
			      (draw-path (mf (c (- (round (* -0.2 sld)) (* 0.5 stem-thickness))
						(* 1.5 sld))
					     --
					     (c (- (round (* -0.2 sld)) (* 0.5 stem-thickness))
						(* -0.5 sld)))))
			    (with-pen (scale +razor+ stem-thickness)
			      (draw-path (mf (c (- (round (* -0.85 sld)) (* 0.5 stem-thickness))
						(* 1.5 sld))
					     --
					     (c (- (round (* -0.85 sld)) (* 0.5 stem-thickness))
						(* -0.5 sld)))))))))))
;;; The width of a natural sign is slightly less than 2/3s of the 
;;; staff line distance of that font.
(defmethod compute-design ((font font) (shape (eql :natural)))
  (with-slots ((sld staff-line-distance)
	       (slt staff-line-thickness)
	       stem-thickness
	       yoffset) font
    (flet ((c (x y) (complex x y)))
      (let* (;; A factor that determines the width of the hole as a fraction of the
	     ;; staff line distance.
	     (hole-width-multiplier 0.33)
	     (hole-width (round (* hole-width-multiplier sld)))
	     ;; Hope that half a pixel will not be visible and will not influence 
	     ;; the required distance to the noteheads.
	     (xoffset (if (oddp hole-width) 0.5 0))
	     (width (+ hole-width (* 2 stem-thickness)))
	     (xleft (* -0.5 width))
	     (xright (- xleft))
	     ;; The left part of the character is right in the middle of the 
	     ;; staff line and the lower edge of the right part touches the upper
	     ;; edge of the staff line
	     (yleft (* -0.5 slt))
	     (yright (- yleft))
	     ;; The path for the thick part
	     (thickpart (mf (c xleft yleft) -- (c xright yright))))
	(clim:region-union
	 (clim:region-union
	  (with-pen (rotate (scale +razor+ (* 0.4 sld)) (/ pi 2))
	    (draw-path (translate thickpart
				  (c xoffset (+ yoffset (* 0.5 sld))))))
	  (with-pen (rotate (scale +razor+ (* 0.4 sld)) (/ pi 2))
	    (draw-path (translate thickpart
				  (c xoffset (- yoffset (* 0.5 sld)))))))
	  (clim:region-union
	   (with-pen (scale +razor+ stem-thickness)
	     (draw-path (translate (mf (c (+ xleft (* 0.5 stem-thickness))
					  (* 1.5 sld))
				       --
				       (c (+ xleft (* 0.5 stem-thickness))
					  (* -0.5 sld)))
				   (c xoffset yoffset))))
	   (with-pen (scale +razor+ stem-thickness)
	     (draw-path (translate (mf (c (- xright (* 0.5 stem-thickness))
					  (* -1.5 sld))
				       --
				       (c (- xright (* 0.5 stem-thickness))
					  (* 0.5 sld)))
				   (c xoffset yoffset))))))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Rests

(defmethod compute-design ((font font) (shape (eql :whole-rest)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)
	       notehead-width xoffset yoffset) font
    (flet ((c (x y) (complex x y)))
      (translate (xyscale +unit-square+
			  notehead-width (* 0.5 sld))
		 (c xoffset (+ yoffset sld (- (* 0.25 sld)) (- (* 0.5 slt))))))))

(defmethod compute-design ((font font) (shape (eql :half-rest)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)
	       notehead-width xoffset yoffset) font
    (flet ((c (x y) (complex x y)))
      (translate (xyscale +unit-square+
			  notehead-width (* 0.5 sld))
		 (c xoffset (+ yoffset (* 0.25 sld) (* 0.5 slt)))))))

(defmethod compute-design ((font font) (shape (eql :quarter-rest)))
  (with-slots ((sld staff-line-distance) stem-thickness) font
    (let ((pen (rotate (xyscale +full-circle+ (* 0.4 sld) stem-thickness) (* -50 (/ pi 180)))))
      (multiple-value-bind (pen-left pen-bot pen-right pen-top)
	  (clim:bounding-rectangle* pen)
	(let ((upper (+ (* #c(0 1.5) sld)
			(complex (- pen-left) (- pen-top))))
	      (second (+ (* #c(0.5 0.9) sld)
			 (complex (- pen-right) (- pen-bot))))
	      (third (* #c(0.0 0.0) sld))
	      (fourth (+ (* #c(0.5 -1) sld)
			 (complex (- pen-right) (- pen-bot))))
	      (fifth (* #c(-0.1 -0.8) sld))
	      (sixth (+ (* #c(-0.1 -1.3) sld)
			(complex (- pen-right) (- pen-bot)))))
	  (with-pen pen
	    (draw-path (mf upper -- second -- third -- fourth ++ fifth ++ sixth))))))))

(defun rest-part (font pos)
  (with-slots ((sld staff-line-distance) stem-thickness yoffset) font
    (flet ((c (x y) (complex x y)))
      (let* ((hoffset (round (* 0.4 sld)))
	     (dot-diameter (round (* 0.5 sld)))
	     (dot (scale +full-circle+ dot-diameter))
	     (hook (mf (c (+ (- sld) (* 0.5 dot-diameter))
			  (+ (* -0.5 dot-diameter) (* 0.5 stem-thickness)))
		       right ++ (direction #c(1 1)) #c(0.0 0.0)))
	     (leg (mf #c(0.0 0.0) -- (c (* -1.5 hoffset) (* -1.5 sld)))))
	(clim:region-union
	 (translate dot (+ pos (- sld) (* 0.5 dot-diameter) (c 0 yoffset)))
	 (with-pen (scale +full-circle+ stem-thickness)
	   (clim:region-union (draw-path (translate hook (+ pos (c 0 yoffset))))
			      (draw-path (translate leg (+ pos (c 0 yoffset)))))))))))

(defmethod compute-design ((font font) (shape (eql :8th-rest)))
  (with-slots ((sld staff-line-distance)) font
    (rest-part font (complex (* 0.5 sld) (* 0.5 sld)))))

(defmethod compute-design ((font font) (shape (eql :16th-rest)))
  (with-slots ((sld staff-line-distance)) font
    (let ((hoffset (round (* 0.4 sld))))
      (reduce #'clim:region-union
	      (list (rest-part font (complex (* 0.5 sld) (* 0.5 sld)))
		    (rest-part font (- (complex (* 0.5 sld) (* 0.5 sld))
				       (complex hoffset sld))))))))

(defmethod compute-design ((font font) (shape (eql :32nd-rest)))
  (with-slots ((sld staff-line-distance)) font
    (let ((hoffset (round (* 0.4 sld))))
      (reduce #'clim:region-union
	      (list (rest-part font (complex (* 0.5 sld) (* 0.5 sld)))
		    (rest-part font (- (complex (* 0.5 sld) (* 0.5 sld))
				       (complex hoffset sld)))
		    (rest-part font (+ (complex (* 0.5 sld) (* 0.5 sld))
				       (complex hoffset sld))))))))
  
(defmethod compute-design ((font font) (shape (eql :64th-rest)))
  (with-slots ((sld staff-line-distance)) font
    (let ((hoffset (round (* 0.4 sld))))
      (reduce #'clim:region-union
	      (list (rest-part font (complex (* 0.5 sld) (* 0.5 sld)))
		    (rest-part font (- (complex (* 0.5 sld) (* 0.5 sld))
				       (complex hoffset sld)))
		    (rest-part font (+ (complex (* 0.5 sld) (* 0.5 sld))
				       (complex hoffset sld)))
		    (rest-part font (- (complex (* 0.5 sld) (* 0.5 sld))
				       (* 2 (complex hoffset sld)))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Flags

(defun first-flag (sld st extreme-point)
  (flet ((c (x y) (complex x y)))
    (climi::close-path (mf (c 0 0) ++
			   (c (* 0.2 sld) (* -0.8 sld)) ++
			   (c (round (* 0.88 sld)) (* -2.5 sld)) down ++
			   extreme-point &
			   extreme-point ++
			   (c (- (round (* 0.88 sld)) st) (* -2.5 sld)) up ++
			   (c (* 0.75 sld) (* -2.5 sld)) up ++
			   (c 0 (* -1.3 sld)) &
			   (c 0 (* -1.3 sld)) -- (c 0 0)))))

(defun second-flag (sld st extreme-point)
  (flet ((c (x y) (complex x y)))
    (climi::close-path (mf (c 0 (* -1.4 sld)) (direction #c(1 -2)) ++
			   (c (round (* 0.88 sld)) (* -2.6 sld)) down ++
			   extreme-point &
			   extreme-point ++
			   (c (- (round (* 0.88 sld)) st) (* -2.5 sld)) up ++
			   (c (* 0.75 sld) (* -2.6 sld)) up ++
			   (direction #c(-1 2)) (c 0 (* (- -1.3 0.625) sld)) &
			   (c 0 (* (- -1.3 0.625) sld)) -- 
			   (c 0 (* -1.4 sld))))))

(defmethod compute-design ((font font) (shape (eql :flags-down-1)))
  (with-slots ((sld staff-line-distance) stem-thickness) font
    (let ((xoffset (ceiling (* 0.5 stem-thickness)))
	  (extreme-point-1 (complex (* 0.5 sld) (* -3.5 sld))))
      (translate (first-flag sld stem-thickness extreme-point-1) xoffset))))
      
(defmethod compute-design ((font font) (shape (eql :flags-down-2)))
  (with-slots ((sld staff-line-distance) (st stem-thickness)) font
    (let ((xoffset (ceiling (* 0.5 st)))
	  (extreme-point-1 (complex (* 0.5 sld) (* -3.5 sld)))
	  (extreme-point-2 (complex (* 0.75 sld) (* -3.0 sld))))
      (clim:region-union
       (translate (first-flag sld st extreme-point-1) xoffset)
       (translate (second-flag sld st extreme-point-2) xoffset)))))

(defmethod compute-design ((font font) (shape (eql :flags-down-3)))
  (with-slots ((sld staff-line-distance) (st stem-thickness)) font
    (let ((xoffset (ceiling (* 0.5 st)))
	  (extreme-point-1 (complex (* 0.5 sld) (* -3.5 sld)))
	  (extreme-point-2 (complex (* 0.75 sld) (* -3.0 sld))))
      (reduce #'clim:region-union
	      (list (translate (first-flag sld st extreme-point-2) xoffset)
		    (translate (second-flag sld st extreme-point-2) xoffset)
		    (translate (second-flag sld st extreme-point-1)
			       (complex xoffset (* -0.626 sld))))))))

(defmethod compute-design ((font font) (shape (eql :flags-down-4)))
  (with-slots ((sld staff-line-distance) (st stem-thickness)) font
    (let ((xoffset (ceiling (* 0.5 st)))
	  (extreme-point-1 (complex (* 0.5 sld) (* -3.5 sld)))
	  (extreme-point-2 (complex (* 0.75 sld) (* -3.0 sld))))
      (reduce #'clim:region-union
	      (list (translate (first-flag sld st extreme-point-2) xoffset)
		    (translate (second-flag sld st extreme-point-2) xoffset)
		    (translate (second-flag sld st extreme-point-2)
			     (complex xoffset (* -0.626 sld)))
		    (translate (second-flag sld st extreme-point-1)
			       (complex xoffset (* -1.25 sld))))))))

(defmethod compute-design ((font font) (shape (eql :flags-down-5)))
  (with-slots ((sld staff-line-distance) (st stem-thickness)) font
    (let ((xoffset (ceiling (* 0.5 st)))
	  (extreme-point-1 (complex (* 0.5 sld) (* -3.5 sld)))
	  (extreme-point-2 (complex (* 0.75 sld) (* -3.0 sld))))
      (reduce #'clim:region-union
	      (list (translate (first-flag sld st extreme-point-2) xoffset)
		    (translate (second-flag sld st extreme-point-2) xoffset)
		    (translate (second-flag sld st extreme-point-2)
			       (complex xoffset (* -0.626 sld)))
		    (translate (second-flag sld st extreme-point-2)
			       (complex xoffset (* -1.25 sld)))
		    (translate (second-flag sld st extreme-point-1)
			       (complex xoffset (* -1.875 sld))))))))

(defmethod compute-design ((font font) (shape (eql :flags-up-1)))
  (with-slots ((sld staff-line-distance) stem-thickness) font
    (let ((xoffset (ceiling (* 0.5 stem-thickness)))
	  (extreme-point-1 (complex (* 0.5 sld) (* -3.5 sld))))
      (translate (yscale (first-flag sld stem-thickness extreme-point-1) -1) xoffset))))
      
(defmethod compute-design ((font font) (shape (eql :flags-up-2)))
  (with-slots ((sld staff-line-distance) (st stem-thickness)) font
    (let ((xoffset (ceiling (* 0.5 st)))
	  (extreme-point-1 (complex (* 0.5 sld) (* -3.5 sld)))
	  (extreme-point-2 (complex (* 0.75 sld) (* -3.0 sld))))
      (clim:region-union
       (translate (yscale (first-flag sld st extreme-point-1) -1) xoffset)
       (translate (yscale (second-flag sld st extreme-point-2) -1) xoffset)))))

(defmethod compute-design ((font font) (shape (eql :flags-up-3)))
  (with-slots ((sld staff-line-distance) (st stem-thickness)) font
    (let ((xoffset (ceiling (* 0.5 st)))
	  (extreme-point-1 (complex (* 0.5 sld) (* -3.5 sld)))
	  (extreme-point-2 (complex (* 0.75 sld) (* -3.0 sld))))
      (reduce #'clim:region-union
	      (list (translate (yscale (first-flag sld st extreme-point-2) -1) xoffset)
		    (translate (yscale (second-flag sld st extreme-point-2) -1) xoffset)
		    (translate (yscale (translate (second-flag sld st extreme-point-1)
						  (complex 0 (* -0.625 sld)))
				       -1)
			       xoffset))))))

(defmethod compute-design ((font font) (shape (eql :flags-up-4)))
  (with-slots ((sld staff-line-distance) (st stem-thickness)) font
    (let ((xoffset (ceiling (* 0.5 st)))
	  (extreme-point-1 (complex (* 0.5 sld) (* -3.5 sld)))
	  (extreme-point-2 (complex (* 0.75 sld) (* -3.0 sld))))
      (reduce #'clim:region-union
	      (list (translate (yscale (first-flag sld st extreme-point-2) -1) xoffset)
		    (translate (yscale (second-flag sld st extreme-point-2) -1) xoffset)
		    (translate (yscale (translate (second-flag sld st extreme-point-2)
						  (complex 0 (* -0.626 sld)))
				       -1)
			       xoffset)
		    (translate (yscale (translate (second-flag sld st extreme-point-1)
						  (complex 0 (* -1.25 sld)))
				       -1)
			       xoffset))))))

(defmethod compute-design ((font font) (shape (eql :flags-up-5)))
  (with-slots ((sld staff-line-distance) (st stem-thickness)) font
    (let ((xoffset (ceiling (* 0.5 st)))
	  (extreme-point-1 (complex (* 0.5 sld) (* -3.5 sld)))
	  (extreme-point-2 (complex (* 0.75 sld) (* -3.0 sld))))
      (reduce #'clim:region-union
	      (list (translate (yscale (first-flag sld st extreme-point-2) -1) xoffset)
		    (translate (yscale (second-flag sld st extreme-point-2) -1) xoffset)
		    (translate (yscale (translate (second-flag sld st extreme-point-2)
						  (complex 0 (* -0.626 sld)))
				       -1)
			       xoffset)
		    (translate (yscale (translate (second-flag sld st extreme-point-2)
						  (complex 0 (* -1.25 sld)))
				       -1)
			       xoffset)
		    (translate (yscale (translate (second-flag sld st extreme-point-1)
						  (complex 0 (* -1.875 sld)))
				       -1)
			       xoffset))))))

