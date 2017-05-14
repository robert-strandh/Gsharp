(cl:in-package #:sdl)

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
  (;; The distance in pixels between the upper edge of two 
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
   (designs :initform (make-hash-table :test #'eq))))
  

(defparameter *beam-designs* (make-hash-table :test #'equal))

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
	  (- (+ beam-offset-down staff-line-thickness)))
    (setf beam-hang-sit-offset
	  (let ((beam-thickness (- beam-offset-down beam-offset-up)))
	    (/ (- beam-thickness staff-line-thickness) 2)))))

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

(defun make-font (staff-line-distance)
  (make-instance 'font :staff-line-distance staff-line-distance))

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
;;; Beams

(defun ensure-beam-segment-design (direction position width)
  (let* ((key (list direction position width)))
    (or (gethash key *beam-designs*)
	(setf (gethash key *beam-designs*)
	      (climi::close-path 
	       (if (eq direction :down)
		   (if (eq position :upper)
		       (mf #c(0 0) -- (complex width 1) -- (complex 0 1) -- #c(0 0))
		       (mf #c(0 0) -- (complex width 0) -- (complex width 1) -- #c(0 0)))
		   (if (eq position :upper)
		       (mf #c(0 0) -- (complex width -1) -- (complex width 0) -- #c(0 0))
		       (mf #c(0 0) -- (complex width 0) -- (complex 0 1) -- #c(0 0)))))))))

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
  (with-slots ((sld staff-line-distance) staff-line-thickness yoffset) font
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
	     (ystart (* 0.5 staff-line-thickness))
	     (top (+ (* 2 sld) (* 0.5 staff-line-thickness)))
	     (yd (+ sld (max 1 (round (* 0.1 sld)))))
	     (ye sld)
	     (yg (- top (* 2 staff-line-thickness)))
	     (yh (round (* 0.4 sld)))
	     (yj ye)
	     (yk yj)
	     (yl yh)
	     (p (mf (c xc ystart) (direction #c(2 1)) ++
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
	     (q (yscale p -1))
	     (r (climi::close-path
		 (reduce #'clim:region-union
			 (list p
			       (climi::reverse-path q)
			       (mf (c xc (- ystart)) -- (c xc ystart)))))))
	(translate
	 (clim:region-union
	  (climi::close-path (mf (c 0 top) -- (c xa top) --
				 (c xa (- top)) --
				 (c 0 (- top)) -- (c 0 top)))
	  (clim:region-union
	   (climi::close-path (mf (c xb top) -- (c xc top) --
				  (c xc (- top)) --
				  (c xb (- top)) -- (c xb top)))
	   r))
	 (c 0 yoffset))))))

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
  (mf #c(-0.75 -0.25) up ++ #c(0.33 0.53) right ++
      #c(0.75 0.25) down ++ #c(-0.33 -0.53) left ++ cycle))

(defparameter *half-path*
  (mf #c(-0.75 -0.25) up (tension 0.8) #c(0.33 0.53) right ++
      #c(0.75 0.25) down (tension 0.8) #c(-0.33 -0.53) left ++ cycle))

(defmethod compute-design ((font font) (shape (eql :filled-notehead)))
  (with-slots (xoffset yoffset staff-line-distance) font
    (translate (scale *filled-path* staff-line-distance)
	       (complex xoffset yoffset))))

(defmethod compute-design ((font font) (shape (eql :breve-notehead)))
  (with-slots (xoffset yoffset (sld staff-line-distance) stem-thickness) font
    (let ((top (translate (xyscale (translate +unit-square+ #c(0 0.5))
                                   (* sld 1.5) (* sld (- 0.53 0.25)))
                          (* sld #c(0 0.25))))
          (bot (translate (xyscale (translate +unit-square+ #c(0 -0.5))
                                   (* sld 1.5) (* sld (- 0.53 0.25)))
                          (* sld #c(0 -0.25))))
          (left (translate (xyscale +unit-square+ stem-thickness (* 1.3 sld))
                           (+ (* sld #c(-0.75 0)) (/ stem-thickness 2))))
          (right (translate (xyscale +unit-square+ stem-thickness (* 1.3 sld))
                            (- (* sld #c(0.75 0)) (/ stem-thickness 2)))))
      (translate
       (reduce #'clim:region-union
               (list top bot left right))
       (complex xoffset yoffset)))))

(defmethod compute-design ((font font) (shape (eql :whole-notehead)))
  (with-slots (xoffset yoffset (sld staff-line-distance)) font
    (let ((op (scale (superellipse #c(0.75 0.0) #c(0.0 0.53)
				   #c(-0.75 0.0) #c(0.0 -0.53) 0.7)
		     sld))
	  (ip (scale (slant (superellipse #c(0.3 0.0) #c(0.0 0.32)
				   #c(-0.3 0.0) #c(0.0 -0.32) 0.8)
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
		 (complex (+ yoffset (/ diameter 2)) yoffset)))))

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

(defmethod compute-design ((font font) (shape (eql :semisharp)))
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
	   ;;
	   ;; FIXME: this is the only real difference between the
	   ;; :semisharp and :sesquisharp glyph calculations, and the
	   ;; :sharp glyph.  Find a way to unify the glyph
	   ;; computations in a proper metafonty way.
	   (xoffset (if (oddp hole-width) 0.5 0.5))
	   (edge-distance (* edge-distance-multiplier sld))
	   (width (+ hole-width (* 2 stem-thickness) (* 2 edge-distance)))
	   ;; FIXME: this leads to a blurry glyph at most sizes:
	   ;; choose a coordinate which lies on a pixel boundary in
	   ;; preference.
	   (xleft (* -0.25 width))
	   (xright (- xleft))
	   (yleft (* -0.15 width))
	   (yright (- yleft))
	   ;; The path for the thick part symmetric around (0, 0)
	   (thickpart (mf (complex xleft yleft) -- (complex xright yright)))
	   ;; Determine the y coordinate of the previous path at the
	   ;; cross point of the thin part.  Use congruent triangles.
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
	 (draw-path (translate thinpart (complex xoffset yoffset))))))))

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

(defmethod compute-design ((font font) (shape (eql :sesquisharp)))
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
	   ;; Hope that half a pixel will not be visible and will not
	   ;; influence the required distance to the noteheads.
	   ;;
	   ;; FIXME: see note in :semisharp glyph at this point
	   (xoffset (if (oddp hole-width) 0.5 0.5))
	   (edge-distance (* edge-distance-multiplier sld))
	   (width (+ hole-width (* 2 stem-thickness) (* 2 edge-distance)))
	   (xleft (* -0.75 width))
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
	 (clim:region-union 
	  (clim:region-union
	   (draw-path (translate thinpart
				 (complex (- xoffset hole-width (* 1 stem-thickness))
					  (- yoffset ythin))))
	   (draw-path (translate thinpart (complex (- xoffset (* 0 stem-thickness)) yoffset))))
	  (draw-path (translate thinpart
				(complex (+ xoffset hole-width (* 1 stem-thickness))
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

(defmethod compute-design ((font font) (shape (eql :semiflat)))
  (with-slots ((sld staff-line-distance) stem-thickness) font
    (flet ((c (x y) (complex x y)))
      (let* ((outer (xyscale (translate (rotate +half-circle+ pi) #c(-0.5 0))
			     (* 1 sld) (* 1 sld)))
	     ;; FIXME: 1.2 here (and in the :sesquiflat glyph, below)
	     ;; represents the difference in width between the
	     ;; :semiflat bulge and the regular :flat bulge.  Find a
	     ;; way to share code between the glyphs.
	     (inner (xyscale (translate (rotate +half-circle+ pi) #c(-0.6 0))
			     (* 0.75 sld) (* (/ 0.75 1.2) sld)))
	     (middle (mf (climi::path-end outer) -- (climi::path-end inner)))
	     (finish (mf (climi::path-start inner) -- (climi::path-start outer)))
	     (combined (climi::close-path
			(reduce #'clim:region-union
				(list outer middle (climi::reverse-path inner) finish)))))
	(clim:region-union (translate (rotate (slant combined 0.6) (- (/ pi 2)))
				      (c (round (- (* -0.2 sld) stem-thickness)) (* -0.5 sld)))
			   (with-pen (scale +razor+ stem-thickness)
			     (draw-path (mf (c (- (round (* -0.2 sld)) (* 0.5 stem-thickness))
					       (* 1.5 sld))
					    --
					    (c (- (round (* -0.2 sld)) (* 0.5 stem-thickness))
					       (* -0.5 sld))))))))))

(defmethod compute-design ((font font) (shape (eql :flat)))
  (with-slots ((sld staff-line-distance) stem-thickness) font
    (flet ((c (x y) (complex x y)))
      (let* ((outer (xyscale (translate +half-circle+ #c(-0.5 0))
			     sld (* 1.2 sld)))
	     (inner (scale (translate +half-circle+ #c(-0.6 0))
			   (* 0.75 sld)))
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

(defmethod compute-design ((font font) (shape (eql :sesquiflat)))
  (with-slots ((sld staff-line-distance) stem-thickness) font
    (flet ((c (x y) (complex x y)))
      (let* ((outer (xyscale (translate (rotate +half-circle+ pi) #c(-0.5 0))
			     (* 1 sld) (* 1 sld)))
	     (inner (xyscale (translate (rotate +half-circle+ pi) #c(-0.6 0))
			     (* 0.75 sld) (* (/ 0.75 1.2) sld)))
	     (middle (mf (climi::path-end outer) -- (climi::path-end inner)))
	     (finish (mf (climi::path-start inner) -- (climi::path-start outer)))
	     (combined (climi::close-path
			(reduce #'clim:region-union
				(list outer middle (climi::reverse-path inner) finish))))
	     (outer1 (xyscale (translate +half-circle+ #c(-0.5 0))
			     sld (* 1.2 sld)))
	     (inner1 (scale (translate +half-circle+ #c(-0.6 0))
			   (* 0.75 sld)))
	     (middle1 (mf (climi::path-end outer1) -- (climi::path-end inner1)))
	     (finish1 (mf (climi::path-start inner1) -- (climi::path-start outer1)))
	     (combined1 (climi::close-path
			 (reduce #'clim:region-union
				 (list outer1 middle1 (climi::reverse-path inner1) finish1)))))
	(clim:region-union (clim:region-union (translate (rotate (slant combined (* 0.6 1.2)) (- (/ pi 2)))
							 (c (round (- (* -0.2 sld) stem-thickness)) (* -0.5 sld)))
					      (translate (rotate (slant combined1 -0.6) (- (/ pi 2)))
							 (c (round (* -0.2 sld)) (* -0.5 sld))))
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

(defmethod compute-design ((font font) (shape (eql :long-rest)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)
               notehead-width xoffset yoffset) font
    (translate (xyscale +unit-square+ (/ notehead-width 2) (* 2 sld))
               (complex xoffset (+ yoffset (- (* 0.5 slt)))))))

(defmethod compute-design ((font font) (shape (eql :breve-rest)))
  (with-slots ((sld staff-line-distance) (slt staff-line-thickness)
               notehead-width xoffset yoffset) font
    (translate (xyscale +unit-square+ (/ notehead-width 2) sld)
               (complex xoffset (+ yoffset (+ (* 0.5 sld)) (- (* 0.5 slt)))))))

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
			   (c 0 (* -1.3 sld)) &
			   (c 0 (* -1.3 sld)) -- (c 0 0)))))

(defun second-flag (sld st extreme-point)
  (flet ((c (x y) (complex x y)))
    (climi::close-path (mf (c 0 (* -1.4 sld)) (direction #c(1 -2)) ++
			   (c (round (* 0.88 sld)) (* -2.6 sld)) down ++
			   extreme-point &
			   extreme-point ++
			   (c (- (round (* 0.88 sld)) st) (* -2.5 sld)) up ++
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

(defmethod compute-design ((font font) (shape (eql :beam-down-upper)))
  (climi::close-path
   (mf #c(0 0) -- (complex 16 -1) -- (complex 0 -1) -- #c(0 0))))

(defmethod compute-design ((font font) (shape (eql :beam-down-lower)))
  (climi::close-path
   (mf #c(0 0) -- (complex 16 0) -- (complex 16 -1) -- #c(0 0))))

(defmethod compute-design ((font font) (shape (eql :beam-up-upper)))
  (climi::close-path
   (mf #c(0 0) -- (complex 16 1) -- (complex 16 0) -- #c(0 0))))

(defmethod compute-design ((font font) (shape (eql :beam-up-lower)))
  (climi::close-path
   (mf #c(0 0) -- (complex 16 0) -- (complex 0 -1) -- #c(0 0))))

;;;           w3
;;;       ___________
;;;      |           |
;;;
;;;             9 *** 10 ** -11			      - 
;;;              ********** -12			       |
;;;             ***********			       |
;;;         8- ************			       |
;;;           *************			       |
;;;          **************			       |
;;;         ***************			       |
;;;        ***6/ **********			       |
;;;       **   / **********			       |
;;;      7    5  **********			       |
;;;              **********			       |  h2
;;;              **********			       |
;;;              **********			       |
;;;              **********			       |
;;;              **********			       |
;;;              **********			       |
;;;              **********			       |
;;;           4 -**********- 13             	       |
;;;        3     **********     14          -	       |
;;;         \ **************** /             |	       |
;;;     2 -**********************- 15        | h1      |
;;;        **********************           _|        _|
;;;          |       |        |
;;;          1       0        16
;;;
;;;
;;;              |___|
;;;                w1
;;;
;;;        |_________|
;;;            w2

(defmethod compute-design ((font font) (shape (eql :time-signature-1)))
  (with-slots ((sld staff-line-distance)
	       (slt staff-line-thickness)
	       yoffset)
    font
    (flet ((c (x y) (complex x y)))
      (let* (;; This symbol should sit on top of a staff line
	     (y0 (+ (/ slt 2) yoffset))
	     (p0 (c 0 y0))
	     ;; if the little notch is to be visible, the top
	     ;; of this character should hang below the upper staff line.
	     (h2 (- (* 2 sld) slt))
	     ;; w1 and w2 should be integers in to avoid fuzziness
	     (w1 (round (* 0.14 h2)))
	     (w2 (round (* 0.25 h2)))
	     (h1 (* 0.5 w2))
	     (p1 (- p0 (* 0.9 w2)))
	     (p2 (c (- w2) (+ y0 (* h1 0.25))))
	     (p3 (+ p1 (c 0 (+ y0 (* h1 0.5)))))
	     (p4 (c (- w1) (+ y0 (* h1 1.2))))
	     (p5 (c (- w1) (+ y0 (* h2 0.62))))
	     (p6 (c (- (* w1 1.09)) (+ y0 (* h2 0.65))))
	     (p7 (c (- (* w2 1.3)) (+ y0 (* h2 0.52))))
	     (p8 (c (- (* w1 1.23)) (+ y0 (* h2 0.85))))
	     (p9 (c (- (* w1 0.91)) (+ y0 h2)))
	     (p10 (c (* w1 0.18) (+ y0 (* h2 0.97))))
	     (p11 (c w1 (+ y0 (* h2 0.98))))
	     (p12 (c w1 (+ y0 (* h2 0.96))))
	     (p13 (c w1 (imagpart p4)))
	     (p14 (c (- (realpart p3)) (imagpart p3)))
	     (p15 (c w2 (imagpart p2)))
	     (p16 (c (- (realpart p1)) (imagpart p1))))
	(mf p0 -- p1 left ++ p2 up ++ p3 ++ up p4 -- p5 up ++
	    p6 (tensions 2 3) p7 (tensions 4 1) 
	    p8 (tensions 1 2)
	    p9 (tensions 2 2) p10 ++ p11 ++ down p12 -- p13 down ++
	    p14 ++ p15 down ++ left p16 -- cycle)))))

	
;;;           
;;;                          w2
;;;                      __________
;;;                     |          |
;;;                                10
;;;                                |                     _
;;;                            *********                  |
;;;                         **************                |
;;;                       ******************              |
;;;                      ****-6  | **********             |
;;;                   9 -******  5  **********            |
;;;                     *******-7  4-*********-11         |
;;;                      ******      *********            |
;;;                        ***      *********             |
;;;                         |      ********               |
;;;                         8    *******                  |
;;;                            *****          14          |
;;;                          *****            |           |  h1
;;;                         *****-12    13    *           |
;;;                        *******       |   **    _      |
;;;                      **********************     |     |
;;;                     ***********************     |     |
;;;              _     ***********************      |     |
;;;             |     ****  |   *************       | h2  |
;;;             |  3 -***   1    ***********        |     |
;;;          h3 |     **           ********         |     |
;;;             |_     \            *****          _|    _| 
;;;                     2             |
;;;                                   0
;;;
;;;
;;;
;;;                   |__________| 
;;;                        w1
;;;           

(defmethod compute-design ((font font) (shape (eql :time-signature-2)))
  (with-slots ((sld staff-line-distance)
	       (slt staff-line-thickness)
	       yoffset)
    font
    (flet ((c (x y) (complex x y)))
      (let* (;; This symbol should sit have its lowest point
	     ;; at the bottom of the staff line
	     (y0 (+ (- (/ slt 2)) yoffset))
	     ;; it should have its top at the lower edge of the staff line
	     (h1 (* 2 sld))
	     (h2 (round (* 0.20 h1)))
	     (h3 (* 0.14 h1))
	     (h4 (* 0.65 h1))
	     (w1 (round (* 0.38 h1)))
	     (w2 (round (* 0.33 h1)))
	     (w3 (round (* 0.6 w2)))
	     (p0 (c (* 0.1 w1) y0))
	     (p1 (c (- (* 0.5 w1)) (+ y0 h3)))
	     (p2 (c (- (* 0.9 w1)) (+ y0 slt)))
	     (p3 (c (- w1) (+ y0 (* 0.5 h3))))
	     (p4 (c (round (* 0.2 w1)) (+ y0 h4)))
	     (p5 (c (- (* 0.1 w1)) (+ y0 (round (* 0.88 h1)))))
	     (p6 (c (- w3) (+ y0 (* 0.78 h1))))
	     (p7 (c (- (* 0.2 w1)) (+ y0 h4)))
	     (p8 (c (- w3) (+ y0 (round (* 0.53 h1)))))
	     (p9 (c (- w2) (+ y0 (* 0.7 h1))))
	     (p10 (c 0 (+ y0 h1)))
	     (p11 (c w2 h4))
	     (p12 (c (- (* 0.01 w1)) (* 0.3 h1)))
	     (p13 (c (* 0.5 w1) h2))
	     (p14 (c w1 (* 0.3 h1))))
	(mf p0 left ++ p1 left ++ p2 left ++ p3 up ++ p4 up (tensions 3 1)
	    p5 left ++ p6 down (tensions 3 1) p7 down ++ p8 left ++ p9 up ++
	    p10 right ++ p11 down (tensions 1 3) p12 down (tensions 3 1) p13 right (tensions 1 3)
	    p14 (tensions 3 1) cycle)))))

;;;                  
;;;                                w2
;;;                            _________
;;;                           |         |
;;;                                     q                  _
;;;                                 **********		    |
;;;                               **************	    |
;;;                             *****m l ********	    |
;;;                            *******     *******	    |
;;;                          p*********n  k********r	    |
;;;                            *******     ******** 	    |
;;;                              ***  j   *******	    |
;;;                               o   | ********	    |
;;;                          ii-*************s		    |
;;;                             *************		    | h1
;;;                              c    | ********	    |
;;;                             ***   h    *******	    |
;;;                           *******      ********	    |
;;;                          *********     *********	    |
;;;                     b - ***********d  g********* t	    |
;;;                          ********* f    ********	    |
;;;                           ******- e|   ********	    |
;;;                             ****************	    |
;;;                               ************		   _|
;;;                                   |
;;;                                   a
;;;                  
;;;                         |___________|
;;;                              w1
;;;                  
;;;                  
;;;                  

(defmethod compute-design ((font font) (shape (eql :time-signature-3)))
  (with-slots ((sld staff-line-distance)
	       (slt staff-line-thickness)
	       yoffset)
    font
    (flet ((c (x y) (complex x y)))
      (let* (;; This symbol should have its lowest point
	     ;; at the bottom of the staff line
	     (ya (+ (- (/ slt 2)) yoffset))
	     ;; it should have its top at the lower edge of the staff line
	     (h1 (* 2 sld))
	     (h2 (* 0.25 h1))
	     (h3 (* 0.75 h1))
	     (w1 (round (* 0.38 h1)))
	     (w2 (round (* 0.33 h1)))
	     (pa (c (* -0.1 w1) ya))
	     (pb (c (- w1) (+ ya h2)))
	     (pc (c (* -0.6 w1) (+ ya (min (1- sld) (round (* 0.4 h1))))))
	     (pd (c (round (* -0.2 w1)) (+ ya h2)))
	     (pe (c (* -0.5 w1) (+ ya (* 2.1 slt))))
	     (pf (c (* -0.1 w1) (+ ya slt)))
	     (pg (c (* 0.2 w1) (+ ya h2)))
	     (ph (c (* -0.1 w1) (+ ya sld)))
	     (pii (c (* -0.7 w1) (+ ya sld (* 0.5 slt))))
	     (pj (+ ph (c 0 slt)))
	     (pk (c (* 0.18 w1) (+ ya h3)))
	     (pl (c (* -0.1 w1) (+ ya (round (* 0.88 h1)))))
	     (pm (c (* -0.3 w1) (+ ya (round (* 0.85 h1)))))
	     (pn (c (round (* -0.2 w1)) (+ ya h3)))
	     (po (c (* -0.55 w1) (+ ya (max (1+ sld) (* 0.6 h1)))))
	     (pp (c (- w2) (+ ya h3)))
	     (pq (c 0 (+ ya h1)))
	     (pr (c w2 h3))
	     (ps (c (* 0.5 w1) (+ ya sld (* 0.5 slt))))
	     (pt (c w1 (+ ya h2))))
	(mf pa left ++ pb up ++ pc right ++ pd down ++ pe down ++
	    pf right ++ pg up ++ ph left (tensions 1 5) pii up (tensions 5 1)
	    pj right ++ pk up ++ pl left ++ pm down ++ pn down ++
	    po left ++ pp up ++ pq right ++ pr down (tensions 0.75 10)
	    ps down (tensions 10 0.75) pt down ++ cycle)))))

;;;                      
;;;                  
;;;                  
;;;                           k        l
;;;                         *************                         - 
;;;                       j*************m                          |
;;;                       *************                            |
;;;                      *************                             |
;;;                     ************                               |
;;;                    ************                                |
;;;                   ***********   ***                            |
;;;                  **********n  t****v                           |
;;;                 *********    ******                            |
;;;                ********    ********                            |
;;;              i*******   s**********                            |  h2
;;;              ******      **********                            |
;;;             *****        **********                            |
;;;            *****        r**********w                           |
;;;           ******o  p     **********                            |
;;;          ******************************                        |
;;;        h*********************************x                     |
;;;          ******************************             -          |
;;;            g         f  e**********y                 |         |
;;;                      d****************               |         |
;;;                 c -**********************z           | h1      |
;;;                    **********************           _|        _|
;;;                      b       a        aa
;;;                                       
;;;                          |_ _|
;;;                           w2
;;;                    |_________|
;;;                        w1
;;;                 

(defmethod compute-design ((font font) (shape (eql :time-signature-4)))
  (with-slots ((sld staff-line-distance)
	       (slt staff-line-thickness)
	       yoffset)
    font
    (flet ((c (x y) (complex x y)))
      (let* (;; This symbol should sit on top of a staff line
	     (ya (+ (/ slt 2) yoffset))
	     ;; Its top should hang under the staff line
	     (h2 (- (* 2 sld) slt))
	     (xa (round (* 0.02 h2)))
	     (h1 (round (* 0.15 h2)))
	     (w1 (round (* 0.25 h2)))
	     (w2 (round (* 0.14 h2)))
	     (pa (c xa ya))
	     (pb (c (- xa (* 0.90 w1)) ya))
	     (pc (c (- xa w1) (+ ya (* 0.25 h1))))
	     (pd (+ pb (c 0 (* 1/2 h1))))
	     (pe (c (- xa w2) (+ ya (* 0.75 h1))))
	     (pf (+ pd (c 0 (* 1/2 h1))))
	     (pg (c (* -0.45 h2) (+ ya h1)))
	     (ph (c (* -0.47 h2) (+ ya (* 1.1 h1))))
	     (ppi (c (* -0.38 h2) (+ ya (* 0.5 h2))))
	     (pj (c (* -0.20 h2) (+ ya (* 0.95 h2))))
	     (pk (c (* -0.12 h2) (+ ya h2)))
	     (pl (c (* 0.17 h2) (+ ya h2)))
	     (pm (c (* 0.17 h2) (+ ya (* 0.9 h2))))
	     (pn (c (* -0.1 h2) (+ ya (* 0.55 h2))))
	     (po (c (* -0.35 h2) (+ ya (* 1.75 h1))))
	     (pp (c (* -0.3 h2) (+ ya (* 1.5 h1))))
	     (pr (c (- xa w2) (+ ya (* 2.2 h1))))
	     (ps (c (- xa w2) (+ ya (* 2.5 h1))))
	     (pt (c (+ xa (* 0.70 w2)) (+ ya (* 0.65 h2))))
	     (pv (c (+ xa w2) (+ ya (* 0.65 h2))))
	     (pw (c (+ xa w2) (+ ya (* 2.0 h1))))
	     (px (c (+ xa w1) (+ ya (* 1.1 h1))))
	     (py (c (+ xa w2) (+ ya (* 0.75 h1))))
	     (pz (c (+ xa w1) (+ ya (* 0.25 h1))))
	     (paa (c (+ xa (* 0.90 w1)) ya)))
	(mf pa -- pb left ++ pc up ++ pd right ++ pe up ++ left pf --
	    pg left ++ ph ++ ppi (tensions 1 3) pj ++ right pk -- pl right ++ pm ++
	    pn (tensions 1 5) po down ++ pp right ++ pr up ++ up ps -- pt
	    (direction (- pt ps)) ++ down pv -- pw down ++ px down ++
	    py down ++ pz down ++ left paa -- cycle)))))

;;;          
;;;                    w2
;;;                  _______
;;;                 |       |
;;;                  
;;;                    l                n                     _
;;;                   *******    m   *****o                    |
;;;                 k********************                      |
;;;                  *******************                       |
;;;                  ******************                        |
;;;                  *****q**********                          |
;;;                  ****    **p**                             |
;;;                  ****r                                     |
;;;                  **** s **t**                   -          |
;;;                  ***************                 |         |
;;;                  ******************              |         | h1
;;;                 j****   h   **********           |         |
;;;                    i          *********          |         |
;;;                    c           *********         |         |
;;;          -       *****        g*********u        |         |
;;;         |      *********       *********         | h2      |
;;;         |     ***********      *********         |         |
;;;     -   |    b************d   *********          |         |
;;;    |  h4|      **********    *********           |         |
;;; h3|     |        ******e f *********             |         |
;;;    |    |          **************                |         |
;;;    |_   |_            ********                  _|        _|
;;;                          a
;;;                  
;;;              |___________|
;;;                    w1
;;;          
;;;          

(defmethod compute-design ((font font) (shape (eql :time-signature-5)))
  (with-slots ((sld staff-line-distance)
	       (slt staff-line-thickness)
	       yoffset)
    font
    (flet ((c (x y) (complex x y)))
      (let* (;; This symbol should have its lowest point
	     ;; at the bottom of the staff line
	     (ya (+ (- (/ slt 2)) yoffset))
	     ;; it should have its top at the lower edge of the staff line
	     (h1 (* 2 sld))
	     (h2 (round (* 0.62 h1)))
	     (h3 (* 0.30 h1))
	     (h4 (round (* 0.44 h1)))
	     (yi (+ ya h4 (max 1 (round (* 0.04 h1)))))
	     (yp (+ ya h2 (max 1 (round (* 0.08 h1)))))
	     (ym (+ ya (round (* 0.95 h1))))
	     (yn (+ ya (round (* 0.975 h1))))
	     (yg (+ ya (* 0.35 h1)))
	     (yh (+ ya (- h2 (max 1 (round (* 0.07 h1))))))
	     (w1 (round (* 0.4 h1)))
	     (w2 (round (* 0.3 h1)))
	     (xd 0)
	     (xc (* 0.5 (- xd w1)))
	     (xe (- xd (* 0.09 h1)))
	     (xg (round (* 0.10 h1)))
	     (xr (- (round (* 0.13 h1)) w2))
	     (ys (- h2 (* 0.03 h1)))
	     (yq (+ yp (* 0.03 h1)))
	     (pa (c 0 ya))
	     (pb (c (- w1) (+ ya h3)))
	     (pc (c xc (+ ya h4)))
	     (pd (c xd (+ ya h3)))
	     (pe (c xe (+ ya (* 0.13 h1))))
	     (pf (c (* -0.2 w1) (+ ya slt)))
	     (pg (c xg (+ ya yg)))
	     (ph (c (* -0.05 h1) yh))
	     (ppi (c (- (* 0.05 h1) w2) yi))
	     (pj (c (- w2) (+ yi (* 0.05 h1))))
	     (pk (c (- w2) (+ ya (- h1 (* 0.10 h1)))))
	     (pl (c (- (* 0.07 h1) w2) (+ ya h1)))
	     (pm (c (* 0.18 h1) ym))
	     (pn (c (- w2 (* 0.03 h1)) yn))
	     (po (c (round (* 1.1 w2)) (+ ya (- h1 (* 0.03 h1)))))
	     (pp (c (* 0.05 h1) yp))
	     (pq (c (+ xr (* 0.03 h1)) yq))
	     (pr (c xr (+ (* 0.7 ys) (* 0.3 yq))))
	     (ps (c (+ xr (* 0.03 h1)) ys))
	     (pt (c (* 0.1 h1) (+ ya h2)))
	     (pu (c w1 (+ ya yg))))
	(mf pa left ++ pb up ++ pc right ++ pd down ++ pe (tensions 20 1)
	    pf right ++ pg up ++ ph left ++ ppi left ++ pj up ++ pk up ++
	    pl right ++ pm right ++ pn right ++ po down ++ pp left ++
	    pq left ++ pr down ++ ps right ++ pt right ++ pu down ++ cycle)))))

;;;                    
;;;                                      w2
;;;                                  __________
;;;                                 |          |                  
;;;                                   c			   _
;;;                                  ****		    |
;;;                              ******g*****		    |
;;;                           *****    ********		    |
;;;                         ******    **********d	    |
;;;                        ******    f**********	    |
;;;                       *******h     ********		    |
;;;                      ********        **e*		    |
;;;                     **********        j 		    |
;;;                    ************i**********		    |
;;;                    *************************	    |
;;;                    ************* n **********	    | h1
;;;                   b***********      **********	    |
;;;                    **********       **********	    |
;;;                    **********       **********k	    |
;;;                    **********m     o**********	    |
;;;                    **********       **********	    |
;;;                     *********       *********	    |
;;;                      *********  l  ********		    |
;;;                       ********************		    |
;;;                         ****************		    |
;;;                             *********                  _|
;;;                                 a
;;;                    
;;;                    
;;;                    |____________|
;;;                         w1
;;;                    
;;;                    

(defmethod compute-design ((font font) (shape (eql :time-signature-6)))
  (with-slots ((sld staff-line-distance)
	       (slt staff-line-thickness)
	       yoffset)
    font
    (flet ((c (x y) (complex x y)))
      (let* (;; This symbol should have its lowest point
	     ;; at the bottom of the staff line
	     (ya (+ (- (/ slt 2)) yoffset))
	     ;; it should have its top at the lower edge of the staff line
	     (h1 (* 2 sld))
	     (w1 (round (* 0.4 h1)))
	     (w2 (round (* 0.35 h1)))
	     (xc (* 0.1 w2))
	     (xf (round (* 0.05 h1)))
	     (yf (+ ya (* 0.8 h1)))
	     (xe (* 0.5 (+ w2 xf)))
	     (ye (+ ya (* 0.68 h1)))
	     (xg (+ xf (* 0.02 h1)))
	     (yg (+ ya (- h1 slt)))
	     (xh (* -0.12 h1))
	     (yh (+ ya (* 0.7 h1)))
	     (xj (* 0.12 h1))
	     (yj (- ye slt))
	     (xi (* -0.09 h1))
	     (yi (- yj (* 0.5 slt)))
	     (yn (- yj (* 2 slt)))
	     (pa (c 0 0))
	     (pb (c (- w1) (+ ya (* 0.45 h1))))
	     (pc (c xc (+ ya h1)))
	     (pd (c w2 yf))
	     (pe (c xe ye))
	     (pf (c xf yf))
	     (pg (c xg yg))
	     (ph (c xh yh))
	     (ppi (c xi yi))
	     (pj (c xj yj))
	     (pk (c w1 (+ ya (* 0.35 h1))))
	     (pl (+ pa (c 0 slt)))
	     (pm (c (* -0.13 h1) (+ ya (* 0.32 h1))))
	     (pn (c 0 yn))
	     (po (c (* 0.13 h1) (+ ya (* 0.32 h1)))))
	(clim:region-difference
	 (mf pa left ++ pb up ++ pc right ++ pd down ++ pe left ++
	     pf up (tensions 1 20) pg (tensions 20 1) ph down ++ ppi
	     (tensions 5 1) pj right ++ pk down ++ cycle)
	 (mf pl left ++ pm up ++ pn right ++ po down ++ cycle))))))

;;;                           
;;;                           
;;;                        w1       
;;;                    __________
;;;                   |          |
;;;
;;;
;;;                    k        m               o          _
;;;                   *  l  ************       *            |
;;;                  j*******************     *             |
;;;                   ********************n **              |
;;;                   ***********************               |
;;;                   *** g ************e***                |
;;;                   **      *********  **                 |
;;;                  i*           f     d**                 |
;;;                   h                ***                  |
;;;                                   ****                  |
;;;                                 ****                    |
;;;                                *****                    |
;;;                               *****                     | h1
;;;                              ******                     |
;;;                             ******                      |
;;;                            *******                      |
;;;                           *******                       |
;;;                           *******                       |
;;;                          *******                        |
;;;                          *******                        |
;;;                         ********p                       |
;;;                         ********                        |
;;;                        *********                        |
;;;                      c ****a****q                       |
;;;                       ***    ***                       _|
;;;                       b       r
;;;                           
;;;                           
;;;                           
;;;                           
;;;                           
;;;                           
;;;                           
;;;                           

(defmethod compute-design ((font font) (shape (eql :time-signature-7)))
  (with-slots ((sld staff-line-distance)
	       (slt staff-line-thickness)
	       yoffset)
    font
    (flet ((c (x y) (complex x y)))
      (let* (;; This symbol should sit on top of a staff line
	     (yb (+ (/ slt 2) yoffset))
	     ;; if the little notch is to be visible, the top
	     ;; of this character should hang below the upper staff line.
	     (h1 (- (* 2 sld) slt))
	     (yl (+ yb (- h1 slt)))
	     (w1 (round (* 0.37 h1)))
	     (yn (+ yb (- h1 (* 2 slt))))
	     (yf (+ yb (round (* 0.65 h1))))
	     (ya (+ yb slt))
	     (pc (c (round (* -0.20 h1)) (+ yb (* 0.03 h1))))
	     (pb (c (+ (realpart pc) (* 0.03 h1)) yb))
	     (pd (c (round (* 0.18 h1)) yf))
	     (pe (c (realpart pd) (+ (imagpart pd) (* 0.03 h1))))
	     (pf (c (* 0.06 h1) yf))
	     (pg (c (* -0.21 h1) (+ yf (round (* 0.8 slt)))))
	     (ph (c (- (* 0.03 h1) w1) (+ yb (* 0.55 h1))))
	     (ppi (c (- w1) (+ (imagpart ph) (* 0.03 h1))))
	     (pj (c (- w1) (+ yb (- h1 (* 0.03 h1)))))
	     (pk (c (+ (realpart pj) (* 0.03 h1)) (+ yb h1)))
	     (pl (c (- (* 0.11 h1) w1) yl))
	     (pm (c (* -0.05 h1) (+ yb h1)))
	     (pn (c (* 0.23 h1) yn))
	     (po (c (round (* 0.9 w1)) (+ yb h1)))
	     (pp (c (round (* 0.15 h1)) (+ yb (* 0.13 h1))))
	     (pq (c (realpart pp) (+ yb (* 0.03 h1))))
	     (pr (c (- (realpart pp) (* 0.03 h1)) yb))
	     (pa (c (* 0.00 h1) ya)))
	(mf pa left ++ pb left ++ pc up (tensions 1 5) pd up ++ pe left ++
	    pf left ++ pg left ++ ph left ++ ppi up ++
	    pj up ++ pk right ++ pl right ++ pm right ++
	    pn right (tensions 1 3) po (tensions 3 1)
	    pp down ++ pq down ++ pr left ++ cycle)))))
	    
;;;                              
;;;                              
;;;                              
;;;                               w2
;;;                           __________   
;;;                          |          |
;;;                          e                             _
;;;                        ******                           |
;;;                     ************                        |
;;;                  ****    i    ****                      |
;;;                ****             ****                    |
;;;               *****              ****                   |
;;;              ******l            j****f                  |
;;;             d******             ****                    |
;;;              *******           ****                     |
;;;              **********     k ****                      |
;;;               *******************                       |
;;;                ******************g                      | h1
;;;                c******************                      |
;;;                ********************                     |
;;;               ***** o       ********                    |
;;;              *****              *****                   |
;;;             ****               p*****h    -             |
;;;       -    b****n               *****      |            |
;;;      |      ****               *****       |            |
;;;      |       ****             *****        | h3         |
;;;   h2 |        ****       m  ******         |            |
;;;      |          ****************           |            |
;;;      |_             *********             _|           _|
;;;                          a    
;;;                              
;;;                          |___________|    
;;;                                w1
;;;                 |________|             
;;;                     w3
;;;                              
;;;                    |_____|
;;;                       w4       

(defmethod compute-design ((font font) (shape (eql :time-signature-8)))
  (with-slots ((sld staff-line-distance)
	       (slt staff-line-thickness)
	       yoffset)
    font
    (flet ((c (x y) (complex x y)))
      (let* (;; This symbol should have its lowest point
	     ;; at the bottom of the staff line
	     (ya (+ (- (/ slt 2)) yoffset))
	     ;; it should have its top at the lower edge of the staff line
	     (h1 (* 2 sld))
	     (h2 (* 0.23 h1))
	     (h3 (* 0.27 h1))
	     (w1 (round (* 0.38 h1)))
	     (w2 (round (* 0.35 h1)))
	     (w3 (round (* 0.26 h1)))
	     (w4 (* 0.07 h1))
	     (pa (c 0 ya))
	     (pb (c (- w1) (+ ya h2)))
	     (pc (c (- w3) (+ ya (* 0.48 h1))))
	     (pd (c (- w2) (+ ya (- h1 h3))))
	     (pe (c 0 (+ ya h1)))
	     (pf (c w2 (+ ya (- h1 h2))))
	     (pg (c w3 (+ ya (* 0.52 h1))))
	     (ph (c w1 (+ ya h3)))
	     (pm (+ pa (c 0 (round (* 0.28 sld)))))
	     (pn (+ pb (round (* 0.33 sld))))
	     (po (c (- w4) (+ ya (* 0.43 h1))))
	     (pp (- ph (round (* 0.40 sld))))
	     (ppi (- pe (c 0 (round (* 0.28 sld)))))
	     (pj (- pf (round (* 0.33 sld))))
	     (pk (c w4 (+ ya (* 0.57 h1))))
	     (pl (+ pd (round (* 0.40 sld)))))
	(clim:region-difference
	 (mf pa left ++ pb up (tensions 1 5)  pc up (tensions 5 1) pd up ++
	     right pe -- ppi left ++ pl down (tensions 1 20) pk right
	     (tensions 3 1) pj up ++ left ppi -- pe right ++ pf down
	     (tensions 1 5) pg down (tensions 5 1) ph down ++ cycle)
	 (mf pm left ++ pn up (tensions 1 3) po right (tensions 20 1)
	     pp down ++ cycle))))))
