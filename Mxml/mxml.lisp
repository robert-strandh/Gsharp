(in-package :gsharp-mxml)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Utility functions, macros
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro test-make-xml (obj id)
  `(cxml:with-xml-output (cxml:make-rod-sink :indentation 2 :canonical nil)
    (make-xml ,obj ,id)))
(defun write-buffer-to-xml-file (buffer filename)
  (with-open-file (s filename :direction :output)
    (write-string (write-mxml buffer) s)))

(defun pcdata (thing)
  (string-trim '(#\Space #\Tab #\Newline) 
               (dom:node-value (dom:first-child thing))))
(defun named-pcdata (node tag-name)
  (if (has-element-type node tag-name)
      (pcdata (elt (dom:get-elements-by-tag-name node tag-name) 0))
      nil))
(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun expander-for-stringcase (keyform cases exhaustivep)
    (let ((nkey (gensym "KEY")))
      (flet ((expand-case (case)
               (destructuring-bind (keys &rest forms) case
                 (cond
                   ((member keys '(t otherwise))
                    (when exhaustivep
                      (warn "~S found in ~S" keys 'estringcase))
                    `(t ,@forms))
                   ((stringp keys)
                    `((string= ,keys ,nkey) ,@forms))
                   ((and (consp keys) (every #'stringp keys))
                    `((or ,@(loop for k in keys collect `(string= ,k ,nkey)))
                      ,@forms))
                   (t
                    (warn "Unrecognized keys: ~S" keys))))))
        `(let ((,nkey ,keyform))
          (cond
            ,@(loop for case in cases collect (expand-case case))
            ,@(when exhaustivep
                `((t (error "~S failed to match any key in ~S"
                      ,nkey 'estringcase))))))))))

(defmacro stringcase (keyform &body cases)
  (expander-for-stringcase keyform cases nil))
(defmacro estringcase (keyform &body cases)
  (expander-for-stringcase keyform cases t))

(defun has-element-type (node type-name)
  (> (length (dom:get-elements-by-tag-name node type-name)) 0))

(defmacro for-named-elements ((name varname node) &body body)
  (let ((elements (gensym)))
    `(let ((,elements (dom:get-elements-by-tag-name ,node ,name)))
      (sequence:dosequence (,varname ,elements)
        ,@body))))
(defmacro for-children ((varname node) &body body)
  (let ((children (gensym)))
    `(let ((,children (dom:child-nodes ,node)))
      (sequence:dosequence (,varname ,children)
        ,@body))))

(defun map-all-lists-maximally (fn id-base &rest all-lists)
  (loop with lists = (copy-list all-lists)
     for i from id-base
     until (every #'null lists)
     collecting (apply fn i (mapcar #'car lists))
     do (map-into lists #'cdr lists)))

(defun split-if (predicate list)
  (loop for x in list
     if (funcall predicate x)
       collect x into a
     else
       collect x into b
     end
     finally (return (values a b))))

(defun find-if-nthcdr (predicate n sequence)
  "Finds the nth element that satisfies the predicate, and returns the
cdr with that element as the head"
  (let ((i 0))
    (do ((e sequence (cdr sequence)))
        ((= i n) e)
      (when (funcall predicate (car e))
        (incf i)))))

;; perhaps these should go in utilities.lisp
(defun unicode-to-string (unicode)
    (map 'string #'gsharp-utilities:unicode-to-char unicode))
(defun string-to-unicode (string)
    (map 'vector #'gsharp-utilities:char-to-unicode string))


;;;;;;;;;;;;;;;
;; Notes on mapping
;;
;; gsh maps to mxml pretty well:
;; staff == staff
;; voice == layer
;; cluster == chord
;;
;; Gsharp allows staffs to be in more than one layer, which isn't
;; explicit in mxml but is there: a note has to be in one staff, but
;; the notes in a chord can be in different ones while in the same
;; voice.
;;
;; the mapping seems to break down in that while mxml allows notes in
;; the same chord to be in different voices (though i'm not sure what
;; that would mean), a cluster in gsharp belongs to one layer. this
;; isn't a problem though, because the mapping of chord to cluster is
;; not really one-to-one.
;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;
;; Import
;;;;;;;;;;;;

(defun parse-mxml-note-duration (note-element)
  "Given a MusicXML note element, return the appropriate Gsharp
notehead, dots and beams values."
  ;; valid types: 256th, 128th, 64th, 32nd, 16th,
  ;; eighth, quarter, half, whole, breve, and long
  (let ((notehead
         (if (has-element-type note-element "type")
             (estringcase (named-pcdata note-element "type")
               (("256th" "128th" "64th" "32nd" "16th" "eighth" "quarter")
                :filled)
               ("half" :half)
               ("whole" :whole)
               (("breve" "full") :breve)
               ("long" :long))
             :filled))
        (beams
         (if (has-element-type note-element "type")
             (estringcase (named-pcdata note-element "type")
               ("256th" 6)
               ("128th" 5)
               ("64th" 4)
               ("32nd" 3)
               ("16th" 2)
               ("eighth" 1)
               (("quarter" "half" "whole" "breve" "full" "long") 0))
             0))
        (dots (length (dom:get-elements-by-tag-name note-element "dot"))))
    (values notehead beams dots)))

(defparameter *step-to-basenote* '((#\C . 0)
                                   (#\D . 1)
                                   (#\E . 2)
                                   (#\F . 3)
                                   (#\G . 4)
                                   (#\A . 5)
                                   (#\B . 6)))

(defun xmlnote-to-gsh (step octave)
  ;; C4 is middle C is 28
  (let ((basenum (cdr (assoc (char-upcase (character step)) *step-to-basenote*))))
    (+ basenum (* 7 octave))))

(defun parse-mxml-accidental (note)
  ;; TODO this should support microtones. also, i wrote it fairly
  ;; early on and it doesn't use things like has-element which it
  ;; should.
  (let ((alters (dom:get-elements-by-tag-name note "alter")))
    (if (= 0 (length alters))
        :natural
        (let ((alter (pcdata (elt alters 0))))
          (stringcase alter
            ("1" :sharp)
            ("0" :natural)
            ("-1" :flat)
            ("2" :double-sharp)
            ("1.5" :sesquisharp)
            ("0.5" :semisharp)
            ("-0.5" :semiflat)
            ("-1.5" :sesquiflat)
            ("-2" :double-flat)
            (t :natural))))))

(defun parse-mxml-note-staff-number (note)
  (if (has-element-type note "staff")
      (1- (parse-integer
           (named-pcdata note "staff")))
      0))

(defun parse-mxml-note-staff (note staves)
"Given an xml note element and a list of all the staff objects, return
the staff object the note is supposed to be assigned to. If none is
specified, returns the first (hopefully default) staff."
(let ((melody-staves
       (remove-if #'(lambda (s) (not (typep s 'fiveline-staff))) staves)))
  (elt melody-staves (parse-mxml-note-staff-number note))))

(defun parse-mxml-pitched-note (note staves)
  (let* ((staff (parse-mxml-note-staff note staves))
         (step (named-pcdata note "step"))
         (octave (parse-integer (named-pcdata note "octave")))
         (pitch (xmlnote-to-gsh step octave))
         (accidentals (parse-mxml-accidental note))
         (tie-left nil)
         (tie-right nil))
    (for-named-elements ("tied" tie note)
      (estringcase (dom:get-attribute tie "type")
        ("start" (setf tie-right t))
        ("stop" (setf tie-left t))))
    (make-instance 'note :pitch pitch :staff staff :accidentals accidentals
                   :tie-left tie-left :tie-right tie-right)))

(defvar *parsing-duration-gmeasure-position*)
(defvar *parsing-in-cluster*)
(defvar *mxml-divisions*)
(defun parse-mxml-note (xnote bars staves lyrics-layer-hash)
  ;; TODO: There is nothing in MusicXML that stops you from having
  ;; multiple notes in a chord that have different durations, types,
  ;; and dots, something which Gsharp does not support in any way.
  ;; However, this is not something often run into: if 2 notes struck
  ;; simultaneously have different rhythmic properties, they are
  ;; almost always to be notated in separate voices. Supporting the
  ;; rare case here is quite complicated, as it requires the
  ;; spontaneous creation of another layer to accommodate it, so for
  ;; now, this code will assume that all notes in a chord have the
  ;; same type and dots as the first one mentioned in the MusicXML
  ;; file. Suggested revision: throw a condition asking the user if
  ;; they want to omit the note or make it the same duration as the
  ;; others.

  ;; Also, this breaks if you have a rest in a chord, which you can
  ;; have in MusicXML, but I'm not really sure what that would be.
  (let ((bar (elt bars (if (has-element-type xnote "voice")
                           (1- (parse-integer (named-pcdata xnote "voice")))
                           0)))
        (advance 0))
    (multiple-value-bind (notehead beams dots)
        (parse-mxml-note-duration xnote)
    
      (when (has-element-type xnote "lyric")
        (let* ((xlyric (elt (dom:get-elements-by-tag-name xnote "lyric") 0))
               (lyrics-staff
                (cadr (find-if-nthcdr #'(lambda (s) (not (typep s 'lyrics-staff)))
                                      (parse-mxml-note-staff-number xnote)
                                      staves)))
               (lyrics-layer (gethash lyrics-staff lyrics-layer-hash))
               (lyrics-bar (car (last (bars (body lyrics-layer)))))
               (lyrics-element (make-lyrics-element lyrics-staff
                                                    :notehead notehead
                                                    :lbeams beams
                                                    :rbeams beams
                                                    :dots dots)))
          ;; TODO there can be multiple lyrics on a given xml-note,
          ;; presumably for verses or something. Right now this just
          ;; ignores all but the first one, but this should be addressed.
          (loop for c across (string-to-unicode (named-pcdata xlyric "text"))
             do (append-char lyrics-element c)) 
          (add-element-at-duration lyrics-element
                                   lyrics-bar
                                   *parsing-duration-gmeasure-position*)))
    
      (when (has-element-type xnote "rest")
        (let ((new-rest (make-rest (parse-mxml-note-staff xnote staves)
                                   :notehead notehead
                                   :lbeams beams
                                   :rbeams beams
                                   :dots dots)))
          (add-element-at-duration new-rest
                                   bar
                                   *parsing-duration-gmeasure-position*)
          (setf advance (duration new-rest))))
    
      (when (has-element-type xnote "pitch")
        (progn
          (unless (has-element-type xnote "chord")
            (multiple-value-bind (notehead beams dots)
                (parse-mxml-note-duration xnote)
              (setf *parsing-in-cluster* (make-cluster :notehead notehead
                                                       :lbeams beams
                                                       :rbeams beams
                                                       :dots dots)))
            (add-element-at-duration *parsing-in-cluster* bar *parsing-duration-gmeasure-position*)
            (setf advance (duration *parsing-in-cluster*)))
          (add-note *parsing-in-cluster* (parse-mxml-pitched-note xnote staves))))
    
      (incf *parsing-duration-gmeasure-position* advance))))

(defun add-element-at-duration (element bar duration-position)
  ;; go through the bar, adding up the 'duration' value of each element.
  ;; if the total is less than the desired duration-position,
  ;;   add an empty cluster of the appropriate length, and then add the new element.
  ;; when the sum is greater than the duration where the element should be placed, look at what the last element was
  ;; if it's not an empty element
  ;;   throw some kind of error
  ;; else
  ;;   concatenate empty elements together
  ;;   if there's not enough room, (this is a fairly complicated calculation), error
  ;;   else split up the empty cluster and insert the new element  
  (loop for ecdr = (elements bar) then (cdr ecdr)
     for e = (car ecdr)
     for position from 0
     until (null ecdr)
     for edur = (duration e)
     summing edur into total-duration
     until (> total-duration duration-position)
     finally
       (if (<= total-duration duration-position) ;;(this is going at the end of the bar)
           (progn
             (dolist (empty-cluster
                       (generate-empty-clusters (- duration-position total-duration)))
               (add-element empty-cluster bar position)
               (incf position))
             (add-element element bar position))
           (if (is-empty e)
               (let ((empty-duration
                      (loop for ee in ecdr
                         until (not (is-empty ee))
                         summing (duration ee))))
                 ;; make sure there is enough empty space
                 (if (> (duration element) empty-duration)
                     (error "There is not enough empty space to put this element")
                     (progn
                       ;; remove all the empty space
                       (loop for ee in ecdr
                          until (not (is-empty ee))
                          do (remove-element ee bar))
                       
                       ;; add back the needed empty preceding space
                       (dolist (empty-cluster
                                 (generate-empty-clusters (- duration-position (- total-duration edur))))
                         (add-element empty-cluster bar position)
                         (incf position))
                       
                       ;; add the element
                       (add-element element bar position)
                       (incf position)
                        
                       ;; add the trailing empty space
                       (dolist (empty-cluster
                                 (generate-empty-clusters
                                  (- empty-duration (- duration-position (- total-duration edur)) (duration element))))
                         (add-element empty-cluster bar position)
                         (incf position)))))
               ;; FIXME: this restart isn't actually good enough; it
               ;; is legitimate to have a new element at the same
               ;; offset from the start of the bar as a previous
               ;; element, as long as that previous element had zero
               ;; duration (e.g. key signature)
               (restart-case 
                   (error "There is already a non-empty element here")
                 (add-anyway ()
                   (add-element element bar position)
                   (incf position)))))))

(defgeneric is-empty (element))
(defmethod is-empty ((element element))
  nil)
(defmethod is-empty ((lyrics-element lyrics-element))
  (= 0 (length (text lyrics-element))))
(defmethod is-empty ((cluster cluster))
  (null (notes cluster)))
  
  
(defun generate-empty-clusters (duration)
  (let ((whole-divisions 1)
        (half-divisions 1/2)
        (quarter-divisions 1/4))
    (nconc
     (loop until (> whole-divisions duration)
        do (decf duration whole-divisions)
        collect (make-cluster :notehead :whole))
     (loop until (> half-divisions duration)
        do (decf duration half-divisions)
        collect (make-cluster :notehead :half))
     (loop until (> quarter-divisions duration)
        do (decf duration quarter-divisions)
        collect (make-cluster :notehead :filled))
     (loop for beams from 1
        for divisions = (/ quarter-divisions 2) then (/ divisions 2)
        nconc
        (loop until (> divisions duration)
           do (decf duration divisions)
           collect (make-cluster :notehead :filled :lbeams beams :rbeams beams))
        until (= duration 0)))))

(defun parse-mxml-key (key staves)
  "Takes a dom element 'key' and returns a key-signature object"

  (let ((alterations (fill (make-array 7) :natural))
        (fifths-element (dom:get-elements-by-tag-name key "fifths"))

        (staff (nth (if (dom:has-attribute key "number")
                        (1- (parse-integer (dom:get-attribute key "number")))
                        ;; TODO: this next line is wrong... it's
                        ;; supposed to apply to all staves if the
                        ;; staff isn't specified
                        0)
                    (remove-if #'(lambda (s) (typep s 'lyrics-staff)) staves))))
    (if (eql 1 (length fifths-element))
        (let ((fifths (parse-integer (pcdata (elt fifths-element 0))))
              (order-of-sharps #(3 0 4 1 5 2 6))
              (order-of-flats #(6 2 5 1 4 0 3))
              (key-signature (gsharp-buffer::make-key-signature staff)))
          ;; deal with the basic fifths
          (if (< fifths 0)
              ;; well, this would have been a nice way to do it, but
              ;; it doesn't work:
              ;; (more-flats key-signature (abs fifths))
              ;; (more-sharps key-signature fifths))

              (dotimes (index (abs fifths))
                (setf (elt alterations (elt order-of-flats index)) :flat))
              (dotimes (index fifths)
                (setf (elt alterations (elt order-of-sharps index)) :sharp)))
          key-signature)
        
        ;; Deal with weird key signatures
        ;; The DTD specifies that it goes step, alter, step, alter. If
        ;; it doesn't, the parser should have barfed when the file was
        ;; loaded, so I'm not checking it here.
        (let ((steps (dom:get-elements-by-tag-name key "key-step"))
              (alters (dom:get-elements-by-tag-name key "key-alter")))
          (loop for step across steps
                for alter across (map 'vector #'pcdata alters)
                do
                (let ((index
                       (cdr (assoc
                             (char-upcase (character (pcdata step)))
                             *step-to-basenote*))))
                  (setf (elt alterations index)
                        (stringcase alter
                          ("1" :sharp)
                          ("0" :natural)
                          ("-1" :flat)
                          ("2" :double-sharp)
                          ("-2" :double-flat)
                          (t :natural)))))))
    (gsharp-buffer::make-key-signature staff :alterations alterations)))

(defun xmlstaff-has-lyrics (part staff-number)
  "Given a MusicXML part and a staff number, determine if any of the
note elements in that staff have associated lyrics."
  (for-named-elements ("note" note part)
    (let ((staff (if (has-element-type note "staff")
                     (parse-integer (named-pcdata note "staff"))
                     1)))
      (when (eql staff staff-number)
        (when (has-element-type note "lyric")
          (return-from xmlstaff-has-lyrics t)))))
  nil)

(defun copy-keysignature (ks)
  (gsharp-buffer::make-key-signature
   (staff ks) :alterations (copy-seq (alterations ks))))

(defun gduration-from-xduration (xduration)
  (/ xduration (* 4 *mxml-divisions*)))

(defun parse-mxml-part (part)
  (let ((staves nil)
        (layers nil)
        (lyrics-layer-hash (make-hash-table))
        ;; TODO this could pull the part-name from the partlist at the
        ;; top of the file
        (part-name (dom:get-attribute part "id")))

    ;; Create all of the staves, along with their initial
    ;; keysignatures and clefs.
    ;; TODO change this to do look in the current part, not the
    ;; current doc

    ;; handling lyric staves: for every new stave i make, look to see
    ;; if any of the note elements assigned to this staff have a
    ;; lyrics element. if such a beast exists, create a new lyric
    ;; staff and a new layer, which should come immediately after the
    ;; melody staff in question in the staves list.
    
    (let* ((number-of-staves
            (max 1
                 (loop for x across
                      (dom:get-elements-by-tag-name part "staves")
                      maximizing (parse-integer (pcdata x)))))
           (clefs (make-array number-of-staves))
           (first-measure
            (elt (dom:get-elements-by-tag-name part "measure") 0))
           (attributes (dom:first-child first-measure)))

      ;; Special Case: if the first thing in the first measure is an
      ;; attribute, and that attribute has a key signature, write it
      ;; to the staff. Also get the clef.
      (when (string= (dom:tag-name attributes) "attributes")

        ;; clefs need to be made before i make the staves, keysigs
        ;; after. don't ask.

        ;; clefs
        (for-named-elements ("clef" clef attributes)
          (let ((name (stringcase (named-pcdata clef "sign")
                        ("G" (if (string= (named-pcdata clef "clef-octave-change")
                                          "-1")
                                 :treble8
                                 :treble))
                        ("F" :bass)
                        ("C" :c)
                        ("percussion" :percussion)
                        ;; "TAB" and "none" are the other, unsupported choices
                        (t  :c)))
                (lineno (if (has-element-type clef "line")
                            (* 2 (1- (parse-integer (named-pcdata clef "line"))))
                            nil))
                (staff-number (if (dom:has-attribute clef "number")
                                  (1- (parse-integer (dom:get-attribute clef "number")))
                                  0)))
            (setf (elt clefs staff-number) (make-clef name :lineno lineno))))
        ;; every fiveline staff must have a clef, even if the xml file did not specify one
        (loop for clef across clefs
           for i from 0
           do (when (eql 0 clef)
                (setf (elt clefs i) (make-clef :treble))))

        ;; staves
        ;; remember that the order of the staves matters, and the
        ;; order that they are put in here is the order they will be
        ;; in when added to the buffer.
        (setf staves
              (loop for i below number-of-staves
                 for melody-staff = (make-fiveline-staff :name (format nil "~A staff ~D" part-name (1+ i))
                                                         :clef (elt clefs i))
                 for lyric-staff = (if (xmlstaff-has-lyrics part (1+ i))
                                       (list (make-lyrics-staff :name (format nil "~A lyricstaff ~D" part-name (1+ i))))
                                       nil)
                 nconc (cons melody-staff lyric-staff)))

        ;; keysignatures
        (for-named-elements ("key" key attributes)
          (let ((keysig (parse-mxml-key key staves)))
            (setf (keysig (staff keysig)) keysig)))))

    ;; make the layers
    (multiple-value-bind (lyrics-staves fiveline-staves)
        (split-if #'(lambda (s) (typep s 'lyrics-staff)) staves)
      ;; first figure out which staves go in each layer
      (let ((staves-for-layers (make-array
                                (max 1
                                     (loop for x across
                                          (dom:get-elements-by-tag-name part "voice")
                                          maximizing (parse-integer (pcdata x))))
                                :initial-element nil)))
        (for-named-elements ("note" note part)
          (let ((staff-number (if (has-element-type note "staff")
                                  (1- (parse-integer (named-pcdata note "staff")))
                                  0))
                (voice-number (if (has-element-type note "voice")
                                  (1- (parse-integer (named-pcdata note "voice")))
                                  0)))
            (pushnew (nth staff-number fiveline-staves) (elt staves-for-layers voice-number))))
        
        (setf layers (nconc
                      (loop for staves across staves-for-layers
                         for i from 1
                         collect (make-layer staves
                                             :body (make-slice :bars nil)
                                             :name (format nil "~A layer ~D" part-name i)))
                      (loop for lyrics-staff in lyrics-staves
                         for i from 1
                         for new-layer = (make-layer (list lyrics-staff)
                                                     :body (make-slice :bars nil)
                                                     :name (format nil "~A lyrics-layer ~D" part-name i))
                         do (setf (gethash lyrics-staff lyrics-layer-hash) new-layer)
                         collecting new-layer)))))
    
    ;; return the layers and the staves
    (values layers
            staves
            lyrics-layer-hash)))

(defun parse-make-segment (part layers staves lyrics-layer-hash)
  ;;look at each element
  (loop for measure across (dom:get-elements-by-tag-name part "measure")
     for measure-position from 0
     do
     (let ((bars (loop for layer in layers
                    for new-bar = (if (typep layer 'melody-layer)
                                      (make-melody-bar)
                                      (make-lyrics-bar))
                    do (add-bar new-bar (body layer) measure-position)
                    collect new-bar))
           (*parsing-duration-gmeasure-position* 0)
           (*parsing-in-cluster* nil))
         
       (for-children (child measure)
         (let ((element-type (dom:tag-name child)))
           (stringcase element-type
             ("note"
              (parse-mxml-note child bars staves lyrics-layer-hash))
                     
             ("attributes"
              ;; Divisions:
              (when (has-element-type child "divisions")
                (setf *mxml-divisions* (parse-integer (named-pcdata child "divisions"))))
                      
              ;; Keysigs:
                
              ;; if we haven't written anything yet, this
              ;; keysignature got added to the staff itself
              (unless (eql 0 *parsing-duration-gmeasure-position*)
                (let ((new-keysignature (parse-mxml-key
                                         (elt (dom:get-elements-by-tag-name child "key") 0)
                                         staves)))
                  (loop for bar in bars
                     do (when (find (staff new-keysignature) (staves (layer (slice bar))))
                          (add-element-at-duration
                           (copy-keysignature new-keysignature)
                           bar *parsing-duration-gmeasure-position*))))))
                     
             ("backup" (decf *parsing-duration-gmeasure-position*
                             (gduration-from-xduration
                              (parse-integer (named-pcdata child "duration")))))
             ("forward" (incf *parsing-duration-gmeasure-position*
                              (gduration-from-xduration
                               (parse-integer (named-pcdata child "duration")))))))))))

(defun parse-mxml (document)
  (let ((layerss nil)
        (lyrics-layer-hashes nil)
        (stavess nil)
        (parts (dom:get-elements-by-tag-name document "part")))
    
    (sequence:dosequence (part parts)
      (multiple-value-bind (layers staves lyrics-layer-hash)
          (parse-mxml-part part)
        (setf layerss
              (append layerss (list layers)))
        (setf lyrics-layer-hashes
              (append lyrics-layer-hashes (list lyrics-layer-hash)))
        (setf stavess (append stavess (list staves)))))

    ;; And finally make the buffer and start parsing notes.
    (let* ((segment (make-instance 'segment
                                   :layers (apply #'concatenate 'list layerss)))
           (buffer (make-instance 'buffer
                                  :segments (list segment)
                                  :staves (apply #'concatenate 'list stavess))))
      (loop for part across parts
         for lyrics-layer-hash in lyrics-layer-hashes
         for layers in layerss
         for staves in stavess
         with *mxml-divisions* = nil
         do (parse-make-segment part layers staves lyrics-layer-hash))
      buffer)))

(defvar *mxml-dtds-dir*
  (merge-pathnames "mxml-dtds/"
                   (make-pathname
                    :directory (pathname-directory
                                (load-time-value *load-pathname*)))))
(defun musicxml-document (pathname)
  (flet ((resolver (pubid sysid)
           (declare (ignore pubid))
           (when (equal (puri:uri-host sysid) "www.musicxml.org")
             (open (merge-pathnames
                    (file-namestring (puri:uri-path sysid))
                    *mxml-dtds-dir*)
                   :element-type '(unsigned-byte 8)))))
    (cxml:parse-file pathname (cxml:make-whitespace-normalizer
                               (cxml-dom:make-dom-builder))
                     :entity-resolver #'resolver :validate t)))

(defun musicxml-document-from-string (string)
  (flet ((resolver (pubid sysid)
           (declare (ignore pubid))
           (when (equal (puri:uri-host sysid) "www.musicxml.org")
             (open (merge-pathnames
                    (file-namestring (puri:uri-path sysid))
                    *mxml-dtds-dir*)
                   :element-type '(unsigned-byte 8)))))
    (cxml:parse-rod string (cxml:make-whitespace-normalizer
                               (cxml-dom:make-dom-builder))
                     :entity-resolver #'resolver :validate t)))

;;;;;;;;;;;
;; Export
;;;;;;;;;;;
(defvar *staff-hash*)

(defun write-mxml (buffer)
  (let ((sink (cxml:make-rod-sink :indentation 2 :canonical nil)))
    (cxml:with-xml-output sink
      (sax:start-dtd sink                                                         
                     "score-partwise"                                             
                     "-//Recordare//DTD MusicXML 1.1 Partwise//EN"                
                     "http://www.musicxml.org/dtds/partwise.dtd")                 
      (sax:end-dtd sink)
      (cxml:with-element "score-partwise"
        (cxml:attribute "version" "1.1")
        (make-xml-partlist)
        (cxml:with-element "part"
          (cxml:attribute "id" "P1")
          (loop for segment in (segments buffer)
             with measure-number = 1
             do
               (make-xml-segment segment measure-number)
               (setf measure-number
                     (+ measure-number
                        (loop for layer in (layers segment)
                           maximizing (length (bars (body layer))))))))))))

(defun make-xml-partlist ()
  (cxml:with-element "part-list"
    (let ((partid "P1"))
      (cxml:with-element "score-part"
        (cxml:attribute "id" partid)
        (cxml:with-element "part-name" (cxml:text partid))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dealing with durations
;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun extract-all-elements (segment)
  (loop for layer in (layers segment)
     append (loop for bar in (bars (body layer))
                appending (elements bar))))

(defun calculate-required-divisions (element)
  "Determines what fraction of a quarter note is required to represent
the duration of this note. For example, passing a quarter-note will
return 1. Passing a double-dotted half-note will return 2. Passing a
dotted 16th note will return 8."
  (when (not (typep element 'rhythmic-element))
    (return-from calculate-required-divisions 1))
  ;; so gsharp allows you to have half- and whole- notes w/
  ;; flags/beams. i'm just gonna pretend that said flags/beams make
  ;; any note half of it's normal value.
  (let ((base-value
         (ecase (notehead element)
           (:filled 1)
           (:whole 1/4)
           (:half 1/2)
           (:breve 1/8)
           (:long 1/16)))
        (dots (dots element))
        (beams (max (rbeams element) (lbeams element))))
    (ceiling (* base-value (expt 2 (+ beams dots))))))

(defun calculate-duration (element)
  ;; If not all of these calculations result in integers, then
  ;; calculate-required-divisions did not work properly.
  (let ((base-value
         (ecase (notehead element)
           (:filled 1)
           (:long 16)
           (:breve 8)
           (:whole 4)
           (:half 2)))
        (dots (dots element))
        (beams (max (rbeams element) (lbeams element))))
    (let ((b (* *mxml-divisions* base-value (expt 2 (* -1 beams)))))
      (loop for i upto dots
           summing (* b (expt 2 (* -1 i)))))))

;;;;;;;;;;;;;;;;;;;;;;
;; Back to exporting
;;;;;;;;;;;;;;;;;;;;;;

(defun make-xml-segment (segment first-bar-number)

  ;; Evaluate the appropriate mxml divisions.
  ;; i think the beginning of a segment is a good place to do this. i
  ;; have no real reason for doing it at this level, it just seems
  ;; right.
  (let ((*mxml-divisions*
         (loop for element in (extract-all-elements segment)
            maximizing (calculate-required-divisions element)))
        (*staff-hash*
         (make-staff-hash
          (remove-duplicates (apply #'concatenate 'list
                                    (mapcar #'staves (layers segment)))))))
  
    (let ((lists-of-bars (mapcar #'(lambda (l) (bars (body l)))
                                 (layers segment))))
      (apply #'map-all-lists-maximally
             #'make-xml-bars first-bar-number lists-of-bars))))

;;(defun make-xml-layer (layer)
;;  (let ((body (body layer)))
;;    (loop for bar in (bars body)
;;          for measurenum from 1
;;          do (make-xml-bar bar measurenum))))

(defun make-staff-hash (staves)
  (let ((new-staff-hash (make-hash-table :size (length staves))))
    (loop for staff in staves
       and i from 1
       do
         (multiple-value-bind (v p) (gethash staff new-staff-hash)
           (declare (ignore v))
           (unless p
             (setf (gethash staff new-staff-hash) i))))
    new-staff-hash))

(defun make-xml-bars (id &rest bars)
  (cxml:with-element "measure"
    (cxml:attribute "number" (write-to-string id))

    ;; There are some things that can change mid-measure, mid-segment,
    ;; whatever, in mxml that can't change in gsharp (number of
    ;; staves, clef). Other things don't really have any meaning in
    ;; gsharp and so can't change: notably "divisions" and
    ;; "beats". These things will get written in the first measure of
    ;; the layer. Keysignatures CAN change in gsharp, but each staff
    ;; also has a keysignature assigned to it, so that will also go
    ;; into the first measure.
    ;;
    ;; This is sort of an abuse of the measure number, since it is
    ;; really intended for printed measure numbers that would get
    ;; printed on a score, and are intended to be arbitrary rather
    ;; than purely sequential, starting with 1. But since gsharp
    ;; doesn't really have measure numbers of this sort, the numbers
    ;; resulting from an export operation will always be sequential
    ;; and start from one.
    (if (eql 1 id)
        (cxml:with-element "attributes"
          (cxml:with-element "divisions"
            (cxml:text (write-to-string *mxml-divisions*)))

          (let* ((layers
                  (remove-duplicates
                   (mapcar #'(lambda (bar) (layer (slice bar))) bars)))
                 (staves
                  (remove-duplicates
                    (apply #'concatenate 'list (mapcar #'staves layers))))
                 (melody-staves
                  (remove-if
                   #'(lambda (staff) (typep staff 'lyrics-staff)) staves))
                 (staves-length (length staves)))
            
            ;; what i would consider a bug in musicxml 1.1: only one
            ;; key allowed per attribute element, despite the fact
            ;; that you can specify which staff the key goes on. This
            ;; is fixed in MusicXML 2.0.
            ;; TODO: put a bunch more attribute elements after this
            ;; one if the other staves have different key signatures.
            (let ((staff (car melody-staves)))
              (cxml:with-element "key"
                (alterations-to-fifths
                 (alterations (keysig staff)))))
                   
            (when (> staves-length 1)
              (cxml:with-element "staves"
                (cxml:text (write-to-string staves-length))))
            (loop for staff in melody-staves
               for clef = (clef staff)
               ;; possibilities for MusicXML:
               ;; G, F, C, percussion, TAB, and none
               for clef-sign = (case (name clef)
                                 (:treble "G")
                                 (:treble8 "G")
                                 (:bass "F")
                                 (:c "C")
                                 (:percussion "percussion"))
               for clef-line = (1+ (/ (lineno clef) 2))
               for staff-num = (gethash staff *staff-hash*)
               do
                 (cxml:with-element "clef"
                   (when (> staves-length 1)
                     (cxml:attribute "number" (write-to-string staff-num)))
                   (cxml:with-element "sign"
                     (cxml:text clef-sign))
                   (cxml:with-element "line"
                     (cxml:text (write-to-string clef-line)))
                   (when (eq (name clef) :treble8)
                     (cxml:with-element "clef-octave-change"                    
                       (cxml:text "-1"))))))))

    ;; process each bar, backing up only if there's a "next" bar
    (loop for voice from 1
       and bar in bars
       do (unless (null bar)
            (make-xml-bar bar (unless (= voice 1) voice))
         (unless (= voice (length bars))
           ;; TODO: if spaces are the first thing in the next bar,
           ;; don't output backwards followed by a forwards.
           (cxml:with-element "backup"
             (cxml:with-element "duration"
                  (cxml:text (write-to-string (bar-duration bar))))))))))

(defun bar-duration (bar)
  (loop for element in (elements bar)
        when (typep element 'rhythmic-element)
        sum (calculate-duration element)))

(defun make-xml-bar (bar voice)
  ;; and now do whatever elements are in there
  (loop for element in (elements bar)
     do (make-xml-element element voice)))

(defgeneric make-xml-element (gharp-element voice))

(defmethod make-xml-element ((rest rest) voice)
  (let ((duration (calculate-duration rest))
        (type (ecase (notehead rest)
                (:long "long")
                (:breve "breve")
                (:whole "whole")
                (:half "half")
                (:filled
                 (ecase (max (rbeams rest) (lbeams rest))
                   (0 "quarter")
                   (1 "eighth")
                   (2 "16th")
                   (3 "32nd")
                   (4 "64th")
                   (5 "128th")
                   (6 "256th")))))
        (dots (dots rest)))
    (cxml:with-element "note"
      (cxml:with-element "rest")
      (cxml:with-element "duration" (cxml:text (write-to-string duration)))
      (unless (null voice)
        (cxml:with-element "voice" (cxml:text (write-to-string voice))))
      (cxml:with-element "type" (cxml:text type))
      (loop repeat dots
         do (cxml:with-element "dot"))
      (if (> (hash-table-count *staff-hash*) 1)
          (cxml:with-element "staff"
            (cxml:text (write-to-string (gethash (staff rest) *staff-hash*))))))))

(defmethod make-xml-element ((cluster cluster) voice)
  ;; this maybe should get called earlier. or later. i don't know.
  (gsharp-measure::compute-final-accidentals (notes cluster))
  (let ((duration (calculate-duration cluster))
        (type (ecase (notehead cluster)
                (:long "long")
                (:breve "breve")
                (:whole "whole")
                (:half "half")
                (:filled
                 (ecase (max (rbeams cluster) (lbeams cluster))
                   (0 "quarter")
                   (1 "eighth")
                   (2 "16th")
                   (3 "32nd")
                   (4 "64th")
                   (5 "128th")
                   (6 "256th")))))
        (dots (dots cluster)))

    (loop for note in (notes cluster)
       for x from 0
       do (make-xml-note note (> x 0) type dots duration voice))

    (when (null (notes cluster))
        ;; it's an empty cluster, a "space"
      (cxml:with-element "forward"
        (cxml:text (write-to-string duration))))))

(defmethod make-xml-element ((lyric lyrics-element) voice)
  (let ((duration (calculate-duration lyric))
        (syllabic "single")
        (text (unicode-to-string (text lyric))))
    (cxml:with-element "note"
      (cxml:with-element "unpitched")
      (cxml:with-element "duration" (cxml:text (write-to-string duration)))
      (unless (null voice)
        (cxml:with-element "voice" (cxml:text (write-to-string voice))))
      ;; TODO: make this use the first melody staff above the lyrics staff
      (if (> (hash-table-count *staff-hash*) 1)
          (cxml:with-element "staff"
            (cxml:text (write-to-string (gethash (staff lyric) *staff-hash*)))))
      (cxml:with-element "lyric"
        (cxml:with-element "syllabic" (cxml:text syllabic))
        (cxml:with-element "text" (cxml:text text))))))
  

(defmethod make-xml-element ((key-signature key-signature) voice)
  ;; TODO: right now this only does "normal" keysignatures, which is
  ;; fine because that's the only kind a user can create in gsharp.
  ;; also, i'm not sure how to deal w/ canceling.
  (declare (ignore voice))
  (cxml:with-element "attributes"
    (cxml:with-element "key"
      (alterations-to-fifths (alterations key-signature)))))

(defun alterations-to-fifths (alterations)
  (cxml:with-element "fifths"
    (let ((fifths 0))
      ;; the magic list on the next line is the order of fifths,
      ;; where C is 0, D is 1, etc.
      (dolist (index '(3 0 4 1 5 2 6))
        (let ((fifth (elt alterations index)))
          (case fifth
            (:sharp (incf fifths))
            (:flat (decf fifths)))))
      (cxml:text (write-to-string fifths)))))

(defun gshnote-to-xml (pitch)
  (let ((step (mod pitch 7)))
    (list (car (rassoc step *step-to-basenote*)) (/ (- pitch step) 7))))

(defun make-xml-note (note in-chord type dots duration &optional voice)
  (let ((pitch (gshnote-to-xml (pitch note)))
        (accidental (ecase (final-accidental note)
                      ((nil))
                      (:sharp "sharp")
                      (:natural "natural")
                      (:flat "flat")
                      (:double-sharp "double-sharp")
                      (:sesquisharp "three-quarters-sharp")
                      (:semisharp "quarter-sharp")
                      (:semiflat "quarter-flat")
                      (:sesquiflat "three-quarters-flat")
                      (:double-flat "flat-flat")))
        (alter (ecase (accidentals note)
                 (:sharp "1")
                 (:natural nil)
                 (:flat "-1")
                 (:double-sharp "2")
                 (:sesquisharp "1.5")
                 (:semisharp "0.5")
                 (:semiflat "-0.5")
                 (:sesquiflat "-1.5")
                 (:double-flat "-2"))))
    (cxml:with-element "note"
      (if in-chord
          (cxml:with-element "chord"))
      (cxml:with-element "pitch"
        (cxml:with-element "step" (cxml:text (car pitch)))
        (if alter (cxml:with-element "alter" (cxml:text alter)))
        (cxml:with-element "octave" (cxml:text (write-to-string (cadr pitch)))))
      (cxml:with-element "duration" (cxml:text (write-to-string duration)))
      (unless (null voice)
        (cxml:with-element "voice" (cxml:text (write-to-string voice))))
      (cxml:with-element "type" (cxml:text type))
      (loop repeat dots
           do (cxml:with-element "dot"))
      (if accidental (cxml:with-element "accidental"
                       (cxml:text accidental)))
      (if (> (hash-table-count *staff-hash*) 1)
          (cxml:with-element "staff"
            (cxml:text (write-to-string (gethash (staff note) *staff-hash*)))))

      ;; Small temptation here to put the if clause on the attribute,
      ;; but remember that a note can have ties in both directions.
      (when (or (tie-left note) (tie-right note))
        (cxml:with-element "notations"
          (when (tie-left note)
            (cxml:with-element "tied" (cxml:attribute "type" "stop")))
          (when (tie-right note)
            (cxml:with-element "tied" (cxml:attribute "type" "start"))))))))
