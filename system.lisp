(in-package :common-lisp-user)

(defparameter *gsharp-directory* (directory-namestring *load-truename*))

(defsystem :gsharp
    :source-pathname *gsharp-directory*
    :source-extension "lisp"
    :components
    (:serial
     "packages"
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
     "gui"))
