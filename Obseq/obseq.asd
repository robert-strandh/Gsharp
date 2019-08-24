(cl:in-package #:asdf-user)

(defsystem #:obseq
  :serial t
  :components
  ((:file "packages")
   (:file "obseq")))
