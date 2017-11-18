(cl:in-package #:asdf-user)

(defsystem :gsharp-fontview
  :description "Tool for viewing fonts created using the MF system."
  :author "Robert Strandh <robert.strandh@gmail.com>"
  :depends-on (:gsharp)
  :serial t
  :components
  ((:file "packages")
   (:file "fontview")))
