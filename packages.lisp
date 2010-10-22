(defpackage :gsharp-utilities
  (:shadow built-in-class)
  (:use :clim-lisp :clim-mop)
  (:export #:ninsert-element #:define-stealth-mixin
	   #:unicode-to-char #:char-to-unicode))

(defpackage :mf
  (:use :cl)
  (:export #:make-bezier-segment #:bezier-segment
	   #:make-open-path #:make-closed-path
	   #:closed-path #:concatenate-paths #:path-start
	   #:close-path
	   #:polygonalize
	   #:path-bounding-box
	   #:scan-lines
	   #:first-line #:nb-lines #:crossings
	   #:translate #:rotate #:scale #:slant #:reverse-path
	   #:draw-path #:with-pen
	   #:+razor+ #:+unit-square+
	   #:+quarter-circle+ #:+half-circle+ #:+full-circle+
	   #:superellipse
	   ;; mf-like stuff
	   #:paths #:mf #:paths #:control #:controls #:tension #:tensions
	   #:& #:-- #:--- #:curl #:direction #:cycle
	   #:left #:right #:up #:down))

(defpackage :sdl
  (:use :common-lisp :mf)
  (:export #:glyph #:staff-line-distance #:staff-line-offsets
	   #:stem-offsets #:bar-line-offsets
	   #:ledger-line-x-offsets #:ledger-line-y-offsets
	   #:notehead-right-offsets #:notehead-left-offsets
	   #:make-font #:glyph-offsets #:suspended-note-offset
	   #:beam-offsets #:beam-hang-sit-offset))

(defpackage :score-pane
  (:use :clim :clim-extensions :clim-lisp :sdl :esa)
  (:import-from :esa-io #:buffer)
  (:shadow #:rest)
  (:export #:draw-fiveline-staff #:draw-lyrics-staff
	   #:draw-stem #:draw-right-stem #:draw-left-stem 
	   #:draw-ledger-line #:draw-bar-line #:draw-beam #:staff-step
	   #:draw-notehead #:draw-accidental #:draw-clef #:draw-rest #:draw-dot
	   #:draw-time-signature-component
	   #:draw-flags-up #:draw-flags-down
	   #:draw-tie-up #:draw-tie-down
	   #:with-score-pane #:with-vertical-score-position
	   #:with-staff-size #:with-notehead-right-offsets
	   #:with-suspended-note-offset
	   #:with-notehead-left-offsets #:with-light-glyphs #:score-pane
	   #:clef #:staff #:fiveline-staff #:lyrics-staff #:notehead
	   #:score-view #:number-of-pages #:current-page-number))

(defpackage :gsharp-buffer
  (:use :common-lisp :gsharp-utilities :esa-buffer)
  (:shadow #:rest)
  (:export #:clef #:name #:lineno #:make-clef
	   #:staff #:fiveline-staff #:make-fiveline-staff
           #:key-signatures #:time-signatures
	   #:staffwise-elements #:clefs
	   #:lyrics-staff #:make-lyrics-staff
	   #:gsharp-condition
	   #:pitch #:accidentals #:dots #:note #:make-note
	   #:note-less #:note-equal #:bar
	   #:notehead #:rbeams #:lbeams #:dots #:element #:annotations
	   #:melody-element #:rhythmic-element #:notes
	   #:add-note #:find-note #:remove-note
           #:cluster-upper-bound #:cluster-lower-bound
	   #:cluster #:make-cluster
	   #:rest #:make-rest
	   #:lyrics-element #:make-lyrics-element
	   #:slice #:elements
	   #:nb-elements #:elementno #:add-element
	   #:remove-element #:bar #:make-bar
	   #:melody-bar #:make-melody-bar
	   #:lyrics-bar #:make-lyrics-bar
	   #:layer #:lyrics-layer #:melody-layer
	   #:bars #:nb-bars #:barno #:add-bar #:remove-bar
	   #:slice #:make-slice
	   #:segment #:tempo #:slices #:sliceno
	   #:make-layer-for-staff #:make-bar-for-staff
	   #:head #:body #:tail #:make-layer #:buffer
	   #:layers #:nb-layers #:layerno
	   #:add-layer #:remove-layer #:segment
	   #:segments #:nb-segments #:segmentno #:staves
	   #:find-staff #:add-segment #:remove-segment
	   #:add-staff-before-staff #:add-staff-after-staff
	   #:remove-staff-from-buffer
	   #:rename-staff
	   #:add-staff-to-layer
	   #:remove-staff-from-layer
	   #:stem-direction #:undotted-duration #:duration
	   #:f-position #:b-position #:bottom-line
           #:keysig #:staff-pos #:xoffset #:read-everything
	   #:read-buffer-from-stream
	   #:staffwise-element
	   #:key-signature #:make-key-signature
	   #:time-signature #:time-signature-components
           #:alterations #:more-sharps #:more-flats
	   #:line-width #:lines-per-page #:min-width #:spacing-style
	   #:right-edge #:left-offset
	   #:left-margin #:text #:append-char #:erase-char
	   #:tie-right #:tie-left
	   #:needs-saving
           #:tuning #:master-pitch-note #:master-pitch-freq
           #:note-cents #:12-edo #:regular-temperament
       #:x-offset #:left-pad #:right-pad
       #:rastral-size #:zoom-level))

(defpackage :gsharp-numbering
  (:use :gsharp-utilities :gsharp-buffer :clim-lisp)
  (:shadowing-import-from :gsharp-buffer #:rest)
  (:shadow #:number)
  (:export #:number))

(defpackage :obseq
  (:use :common-lisp)
  (:export #:obseq #:obseq-elem #:obseq-next #:obseq-prev
	   #:obseq-first-undamaged-element
	   #:obseq-last-undamaged-element
	   #:cost-method #:obseq-cost-method #:seq-cost
	   #:total-cost #:combine-cost #:seq-cost-cannot-decrease
	   #:cost-less #:obseq-solve #:obseq-interval))

(defpackage :gsharp-measure
  (:use :common-lisp :gsharp-numbering :gsharp-buffer :gsharp-utilities :obseq)
  (:shadowing-import-from :gsharp-numbering #:number)
  (:shadowing-import-from :gsharp-buffer #:rest)
  (:export #:mark-modified #:modified-p #:measure
	   #:measure-min-dist #:measure-coeff
	   #:measure-bar-pos #:measure-seg-pos #:measure-bars #:measures
	   #:nb-measures #:measureno
	   #:recompute-measures #:measure-cost-method #:make-measure-cost-method
	   #:buffer-cost-method
	   #:reduced-width #:natural-width #:compress-factor
	   #:measure-seq-cost
	   #:note-position #:non-empty-cluster-p
	   #:top-note #:bot-note #:top-note-pos #:bot-note-pos
	   #:beam-groups #:final-stem-direction
	   #:group-notes-by-staff #:final-relative-note-xoffset
	   #:final-accidental #:final-relative-accidental-xoffset
           #:final-relative-dot-xoffset #:final-absolute-dot-ypos
	   #:timeline #:timelines #:elasticity
	   #:smallest-gap #:elasticity-function))

(defpackage :gsharp-beaming
  (:use :common-lisp)
  (:export #:beaming-single #:beaming-double))

(defpackage :gsharp-cursor
  (:shadowing-import-from :gsharp-buffer #:rest)
  (:shadowing-import-from :gsharp-numbering #:number)
  (:use :gsharp-utilities :gsharp-buffer :gsharp-numbering :clim-lisp)
  (:export #:gsharp-cursor #:make-cursor #:end-of-bar-p #:beginning-of-bar-p
	   #:insert-element #:delete-element 
	   #:forward-element #:backward-element
	   #:last-bar-p #:first-bar-p #:forward-bar #:backward-bar
	   #:insert-bar-before #:insert-bar-after #:delete-bar
	   #:in-last-bar #:in-first-bar #:end-of-bar
	   #:first-slice-p #:last-slice-p
	   #:forward-slice #:backward-slice
	   #:head-slice #:body-slice #:tail-slice
	   #:in-last-slice #:in-first-slice
	   #:select-layer #:delete-layer
           #:first-segment-p #:last-segment-p
	   #:forward-segment #:backward-segment
	   #:insert-segment-before #:insert-segment-after
	   #:delete-segment
	   #:in-last-segment #:in-first-segment
	   #:cursor-element #:cursor-bar #:cursor-slice #:cursor-layer
	   #:cursor-segment #:cursor-buffer
	   #:current-cluster #:not-on-a-cluster
	   #:current-element #:not-on-an-element
	   ))

(defpackage :gsharp-drawing
  (:use :clim :clim-lisp :gsharp-buffer :gsharp-measure :gsharp-cursor
	:gsharp-utilities :sdl :gsharp-beaming :obseq)
  (:shadowing-import-from :gsharp-buffer #:rest)
  (:export #:draw-buffer #:draw-the-cursor #:print-buffer))

(defpackage :gsharp-play
  (:use :common-lisp :midi :gsharp-buffer)
  (:shadowing-import-from :gsharp-buffer #:rest)
  (:export #:play-layer
	   #:play-segment
	   #:play-buffer))

(defpackage :gsharp-mxml
  (:use :cl :gsharp-buffer :gsharp-measure)
  (:shadowing-import-from :gsharp-buffer #:rest))

(defpackage :gsharp
  (:use :clim :clim-lisp :gsharp-utilities :esa :esa-buffer :esa-io
	:gsharp-buffer :gsharp-cursor :gsharp-drawing :gsharp-numbering
	:gsharp-measure :sdl :midi
	:gsharp-play)
  (:shadowing-import-from :gsharp-numbering #:number)
  (:shadowing-import-from :gsharp-buffer #:rest #:buffer)
  (:export #:gsharp #:edit-file))

(in-package :gsharp-numbering)
(deftype number () 'cl:number)
(setf (find-class 'number) (find-class 'cl:number))

(in-package :gsharp-buffer)
(defun rest (list)
  (cl:rest list))
(define-compiler-macro rest (list)
  `(cl:rest ,list))
(define-setf-expander rest (list &environment env)
  (get-setf-expansion `(cl:rest ,list) env))
