(cl:in-package #:asdf-user)

(defsystem :gsharp
  :depends-on (:mcclim
               :clim-listener
               :stealth-mixin
               :flexichain
               :midi
               :puri
               :cxml)
  :serial t
  :components
  ((:file "packages")
   (:file "utilities")
   (:file "bezier-extra")
   (:file "mf")
   (:file "sdl")
   (:file "score-pane")
   (:file "buffer")
   (:file "melody")
   (:file "lyrics")
   (:file "numbering")
   (:file "Obseq/obseq")
   (:file "measure")
   (:file "beaming")
   (:file "elasticity")
   (:file "drawing")
   (:file "cursor")
   (:file "input-state")
   (:file "modes")
   (:file "play")
   (:file "clim-utils")
   (:file "gui")
   (:file "undo")
   #+sbcl (:file "Mxml/mxml")
   #+sbcl (:file "Mxml/commands")))

