(defpackage :gsharp-utilities
  (:shadow built-in-class)
  (:use :clim-lisp :clim-mop)
  (:export #:ninsert-element #:define-added-mixin
	   #:unicode-to-char #:char-to-unicode))

(defpackage :gf
  (:use :common-lisp)
  (:export #:parse-gf-file #:gf-font-comment #:gf-font-chars #:gf-font-design-size
	   #:gf-font-checksum #:gf-font-horizontal-ratio #:gf-font-vertical-ratio
	   #:gf-font-min-column #:gf-font-max-column 
	   #:gf-font-min-row #:gf-font-max-row 
	   #:gf-char-no #:gf-char-min-m #:gf-char-max-m
	   #:gf-char-min-n #:gf-char-max-n #:gf-char-matrix))
	   
(defpackage :sdl
  (:use :common-lisp :gf)
  (:export #:glyph #:staff-line-distance #:staff-line-offsets
	   #:stem-offsets #:bar-line-offsets
	   #:ledger-line-x-offsets #:ledger-line-y-offsets
	   #:notehead-right-offsets #:notehead-left-offsets
	   #:load-font #:glyph-offsets #:suspended-note-offset
	   #:+glyph-whole+ #:+glyph-whole-upper+ #:+glyph-whole-lower+ #:+glyph-whole-two+
	   #:+glyph-half+ #:+glyph-half-upper+ #:+glyph-half-lower+ #:+glyph-half-two+
	   #:+glyph-filled+ #:+glyph-filled-upper+ #:+glyph-filled-lower+ #:+glyph-filled-two+
	   #:+glyph-sharp+ #:+glyph-natural+ #:+glyph-flat+ #:+glyph-double-sharp+
	   #:+glyph-double-flat+ #:+glyph-g-clef+ #:+glyph-f-clef+ #:+glyph-c-clef+
	   #:+glyph-dot+ #:+glyph-whole-rest+ #:+glyph-half-rest+ #:+glyph-quarter-rest+
	   #:+glyph-eighth-rest+ #:+glyph-sixteenth-rest+ #:+glyph-thirtysecondth-rest+
	   #:+glyph-sixtyfourth-rest+ #:+glyph-onehundredandtwentyeigth-rest+
	   #:+glyph-flags-down-one+ #:+glyph-flags-down-two+ #:+glyph-flags-down-three+
	   #:+glyph-flags-down-four+ #:+glyph-flags-down-five+ #:+glyph-flags-up-one+
	   #:+glyph-flags-up-two+ #:+glyph-flags-up-three+ #:+glyph-flags-up-four+
	   #:+glyph-flags-up-five+))

(defpackage :gsharp-buffer
  (:use :common-lisp :gsharp-utilities)
  (:shadow #:rest)
  (:export #:clef #:name #:lineno #:make-clef
	   #:staff #:fiveline-staff #:make-fiveline-staff
	   #:lyrics-staff #:make-lyrics-staff
	   #:gsharp-condition
	   #:pitch #:accidentals #:dots #:note #:make-note
	   #:note-less #:note-equal #:bar
	   #:notehead #:rbeams #:lbeams #:dots #:element
	   #:melody-element #:notes
	   #:add-note #:find-note #:remove-note
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
	   #:segment #:slices #:sliceno
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
	   #:clef #:keysig #:staff-pos #:xoffset #:read-everything #:save-buffer-to-stream
	   #:line-width #:min-width #:spacing-style #:right-edge #:left-offset
	   #:left-margin #:text #:append-char #:erase-char
	   ))

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
	   #:measure-min-dist #:measure-coeff #:measure-start-times
	   #:measure-bar-pos #:measure-seg-pos #:measure-bars #:measures
	   #:nb-measures #:measureno
	   #:recompute-measures #:measure-cost-method #:make-measure-cost-method
	   #:buffer-cost-method
	   #:reduced-width #:natural-width #:compress-factor
	   #:measure-seq-cost))

(defpackage :gsharp-postscript
  (:use :clim :clim-lisp)
  (:export #:postscript-path #:make-postscript-path
	   #:draw-design #:medium-draw-design
	   #:newpath #:lineto #:curveto #:moveto
	   #:rlineto #:circle))

(defpackage :gsharp-glyphs
  (:use :clim :clim-lisp :gsharp-postscript)
  (:export #:treble-clef #:percussion-clef #:c-clef #:bass-clef #:turn
	   #:mordent #:double-mordent #:trill-section #:trill-sections
	   #:arpeggio #:arpeggios #:tr #:accent #:tnecca #:breath-mark
	   #:caesura #:fermata #:upside-down-fermata #:repeat-sign
	   #:upper-bracket #:lower-bracket #:segno #:coda #:pedal-off
	   #:ped #:left-paren #:right-paren #:wedge #:down-bow #:up-bow
	   #:zero #:one #:two #:three #:four #:five #:six #:seven
	   #:eight #:nine #:common-time #:cut-time #:plus #:sharp #:flat
	   #:double-sharp #:natural #:double-flat #:f #:p #:lig-p #:m
	   #:n #:niente #:subito #:z #:s #:r #:double-whole-note
	   #:whole-note #:half-note #:quarter-note #:diamond #:diamond-1
	   #:filled-diamond-1 #:rhythmx #:circled-x #:slash #:mslash
	   #:triangle #:square #:8th-flag-up #:extend-flag-up
	   #:8th-flag-down #:extend-flag-down #:whole-rest #:half-rest
	   #:quarter-rest #:8th-rest #:16th-rest #:32nd-rest #:64th-rest
	   #:128th-rest #:measure-rest #:double-whole-rest))

(defpackage :esa
  (:use :clim-lisp :clim)
  (:export #:minibuffer-pane #:display-message
	   #:esa-pane-mixin #:previous-command
	   #:info-pane #:master-pane
	   #:esa-frame-mixin #:windows #:recordingp #:executingp
	   #:*numeric-argument-p* #:*current-gesture*
	   #:esa-top-level #:simple-command-loop
	   #:global-esa-table #:keyboard-macro-table
           #:help-table
	   #:set-key
           #:find-applicable-command-table))

(defpackage :score-pane
  (:use :clim :clim-extensions :clim-lisp :sdl :esa)
  (:shadow #:rest)
  (:export #:draw-fiveline-staff #:draw-lyrics-staff
	   #:draw-stem #:draw-right-stem #:draw-left-stem 
	   #:draw-ledger-line #:draw-bar-line #:draw-beam #:staff-step
	   #:draw-notehead #:draw-accidental #:draw-clef #:draw-rest #:draw-dot
	   #:draw-flags-up #:draw-flags-down
	   #:with-score-pane #:with-vertical-score-position
	   #:with-staff-size #:with-notehead-right-offsets
	   #:with-suspended-note-offset
	   #:with-notehead-left-offsets #:with-light-glyphs #:score-pane
	   #:clef #:staff #:fiveline-staff #:lyrics-staff #:notehead))

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
  (:export #:draw-buffer))

(defpackage :midi
  (:use :common-lisp)
  (:export #:read-midi-file #:write-midi-file
	   #:midifile
	   #:midifile-format #:midifile-tracks #:midifile-division
	   #:message #:note-off-message #:note-on-message #:tempo-message
	   #:program-change-message
	   #:key-signature-message #:time-signature-message
	   #:smpte-offset-message
	   #:message-channel #:message-key #:message-time
	   #:message-velocity #:message-numerator #:message-denominator
	   #:message-sf #:message-mi #:message-tempo
	   #:header #:header-type
	   #:unknown-event #:status #:data-byte))

(defpackage :gsharp-play
  (:use :common-lisp :midi :gsharp-buffer)
  (:shadowing-import-from :gsharp-buffer #:rest)
  (:export #:play-layer
	   #:play-segment
	   #:play-buffer))

(defpackage :gsharp
  (:use :clim :clim-lisp :gsharp-utilities :esa
	:gsharp-buffer :gsharp-cursor :gsharp-drawing :gsharp-numbering
	:gsharp-measure :sdl :midi
	:gsharp-play)
  (:shadowing-import-from :gsharp-numbering #:number)
  (:shadowing-import-from :gsharp-buffer #:rest)
  (:export #:gsharp))

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
