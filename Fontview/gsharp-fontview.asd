(cl:in-package #:asdf-user)

(defsystem :gsharp-fontview
  :depends-on (:gsharp)
  :serial t
  :components
  ((:file "packages")
   (:file "fontview")))
