(in-package :common-lisp-user)

(defparameter *gsharp-directory* (directory-namestring *load-truename*))

(defmacro gsharp-defsystem ((module &key depends-on) &rest components)
  `(progn
    #+mk-defsystem
    (mk:defsystem ,module
	:source-pathname *gsharp-directory*
	,@(and depends-on `(:depends-on ,depends-on))
	:components (:serial ,@components))
    #+asdf
    (asdf:defsystem ,module
	,@(and depends-on `(:depends-on ,depends-on))
	:serial t
	:components (,@(loop for c in components
			     for p = (merge-pathnames
				      (parse-namestring c)
				      (make-pathname :type "lisp"
						     :defaults *gsharp-directory*))
			     collect `(:file ,(pathname-name p) :pathname ,p))))))

(gsharp-defsystem (:gsharp :depends-on (:mcclim))
   "packages"
   "esa"
   "utilities"
   "gf"
   "sdl"
   "charmap"
   "buffer"
   "numbering"
   "Obseq/obseq"
   "measure"
   "postscript"
   "glyphs"
   "score-pane"
   "beaming"
   "drawing"
   "cursor"
   "input-state"
   "midi"
   "modes"
   "gui")
