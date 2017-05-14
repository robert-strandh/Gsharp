(cl:in-package #:asdf-user)

(defsystem :gsharp-fontview
  :depends-on (:gsharp)
  :components
  ((:file "packages")
   (:file "fontview")))
