(in-package :gsharp)

(defun transform-gesture (gesture)
  (list (car gesture) (apply #'make-modifier-state (cdr gesture))))

(defun add-keyseq (gestures command table)
  (setf (dico-object table (mapcar #'transform-gesture gestures))
	command))


;;; global mode table
(defparameter *global-mode-table* (make-sequence-dico :test #'equal))

(add-keyseq '((#\f :control)) 'com-forward-element *global-mode-table*)
(add-keyseq '((#\b :control)) 'com-backward-element *global-mode-table*)
(add-keyseq '((#\d :control)) 'com-delete-element *global-mode-table*)
(add-keyseq '((#\| :shift)) 'com-insert-measure-bar *global-mode-table*)
(add-keyseq '((#\.)) 'com-more-dots *global-mode-table*)
(add-keyseq '((#\[)) 'com-more-lbeams *global-mode-table*)
(add-keyseq '((#\])) 'com-more-rbeams *global-mode-table*)
(add-keyseq '((#\l :meta)) 'com-left *global-mode-table*)
(add-keyseq '((#\r :meta)) 'com-right *global-mode-table*)
(add-keyseq '((#\x :control) (#\( :shift)) 'com-start-kbd-macro *global-mode-table*)
(add-keyseq '((#\x :control) (#\()) 'com-start-kbd-macro *global-mode-table*)
(add-keyseq '((#\x :control) (#\) :shift)) 'com-end-kbd-macro *global-mode-table*)
(add-keyseq '((#\x :control) (#\))) 'com-end-kbd-macro *global-mode-table*)
(add-keyseq '((#\x :control) (#\e)) 'com-call-last-kbd-macro *global-mode-table*)
(add-keyseq '((#\r :control)) 'com-rotate-notehead *global-mode-table*)

;;; melody mode table
(defparameter *melody-layer-mode-table* (make-sequence-dico :test #'equal))

(add-keyseq '((#\L :shift)) 'com-lower *melody-layer-mode-table*)
(add-keyseq '((#\H :shift)) 'com-higher *melody-layer-mode-table*)
(add-keyseq '((#\c)) 'com-insert-note-c *melody-layer-mode-table*)
(add-keyseq '((#\d)) 'com-insert-note-d *melody-layer-mode-table*)
(add-keyseq '((#\e)) 'com-insert-note-e *melody-layer-mode-table*)
(add-keyseq '((#\f)) 'com-insert-note-f *melody-layer-mode-table*)
(add-keyseq '((#\g)) 'com-insert-note-g *melody-layer-mode-table*)
(add-keyseq '((#\a)) 'com-insert-note-a *melody-layer-mode-table*)
(add-keyseq '((#\b)) 'com-insert-note-b *melody-layer-mode-table*)
(add-keyseq '((#\,)) 'com-insert-rest *melody-layer-mode-table*)
(add-keyseq '((#\Space)) 'com-insert-empty-cluster *melody-layer-mode-table*)
(add-keyseq '((#\C :shift)) 'com-add-note-c *melody-layer-mode-table*)
(add-keyseq '((#\D :shift)) 'com-add-note-d *melody-layer-mode-table*)
(add-keyseq '((#\E :shift)) 'com-add-note-e *melody-layer-mode-table*)
(add-keyseq '((#\F :shift)) 'com-add-note-f *melody-layer-mode-table*)
(add-keyseq '((#\G :shift)) 'com-add-note-g *melody-layer-mode-table*)
(add-keyseq '((#\A :shift)) 'com-add-note-a *melody-layer-mode-table*)
(add-keyseq '((#\B :shift)) 'com-add-note-b *melody-layer-mode-table*)
(add-keyseq '((#\p)) 'com-current-increment *melody-layer-mode-table*)
(add-keyseq '((#\n)) 'com-current-decrement *Melody-Layer-mode-table*)
(add-keyseq '((#\i) (#\.)) 'com-istate-more-dots *melody-layer-mode-table*)
(add-keyseq '((#\i) (#\[)) 'com-istate-more-lbeams *melody-layer-mode-table*)
(add-keyseq '((#\i) (#\])) 'com-istate-more-rbeams *melody-layer-mode-table*)
(add-keyseq '((#\i) (#\h)) 'com-istate-rotate-notehead *melody-layer-mode-table*)
(add-keyseq '((#\i) (#\s)) 'com-istate-rotate-stem-direction *melody-layer-mode-table*)
(add-keyseq '((#\i) (#\x) (#\.)) 'com-istate-fewer-dots *melody-layer-mode-table*)
(add-keyseq '((#\i) (#\x) (#\[)) 'com-istate-fewer-lbeams *melody-layer-mode-table*)
(add-keyseq '((#\i) (#\x) (#\])) 'com-istate-fewer-rbeams *melody-layer-mode-table*)
(add-keyseq '((#\x) (#\.)) 'com-fewer-dots *melody-layer-mode-table*)
(add-keyseq '((#\x) (#\[)) 'com-fewer-lbeams *melody-layer-mode-table*)
(add-keyseq '((#\x) (#\])) 'com-fewer-rbeams *melody-layer-mode-table*)
(add-keyseq '((#\h :control)) 'com-erase-element *melody-layer-mode-table*)
(add-keyseq '((#\h :meta)) 'com-rotate-notehead *melody-layer-mode-table*)
(add-keyseq '((#\s :meta)) 'com-rotate-stem-direction *melody-layer-mode-table*)
(add-keyseq '((#\#)) 'com-sharper *melody-layer-mode-table*)
(add-keyseq '((#\# :shift)) 'com-sharper *melody-layer-mode-table*)
(add-keyseq '((#\@ :shift)) 'com-flatter *melody-layer-mode-table*)
(add-keyseq '((#\# :meta)) 'com-more-sharps *melody-layer-mode-table*)
(add-keyseq '((#\# :meta :shift)) 'com-more-sharps *melody-layer-mode-table*)
(add-keyseq '((#\@ :meta :shift)) 'com-more-flats *melody-layer-mode-table*)
(add-keyseq '((#\u :meta)) 'com-up *melody-layer-mode-table*)
(add-keyseq '((#\d :meta)) 'com-down *melody-layer-mode-table*)

;;; lyrics mode table

(defparameter *lyrics-layer-mode-table* (make-sequence-dico :test #'equal))

(add-keyseq '((#\h :control)) (lambda () (erase-char (cur-element)))
	    *lyrics-layer-mode-table*)
(add-keyseq '((#\h :meta)) 'com-erase-element *lyrics-layer-mode-table*)
(add-keyseq '((#\Space :control)) 'insert-lyrics-element *lyrics-layer-mode-table*)


(defun make-insert-fun (code)
  (lambda () (append-char (cur-element) code)))

(loop for c in '(#\A #\B #\C #\D #\E #\F #\G #\H #\I #\J #\K #\L #\M 
		 #\N #\O #\P #\Q #\R #\S #\T #\U #\V #\W #\X #\Y #\Z)
      for i from 65
      do (add-keyseq `((,c :shift)) (make-insert-fun i) *lyrics-layer-mode-table*))

(loop for c in '(#\a #\b #\c #\d #\e #\f #\g #\h #\i #\j #\k #\l #\m 
		 #\n #\o #\p #\q #\r #\s #\t #\u #\v #\w #\x #\y #\z)
      for i from 97
      do (add-keyseq `((,c)) (make-insert-fun i) *lyrics-layer-mode-table*))

;;; try some latin prefix mode for national characters 
(add-keyseq '((#\`) (#\A :shift)) (make-insert-fun 192) *lyrics-layer-mode-table*)
(add-keyseq '((#\') (#\A :shift)) (make-insert-fun 193) *lyrics-layer-mode-table*)
(add-keyseq '((#\^) (#\A :shift)) (make-insert-fun 194) *lyrics-layer-mode-table*)
(add-keyseq '((#\~) (#\A :shift)) (make-insert-fun 195) *lyrics-layer-mode-table*)
(add-keyseq '((#\") (#\A :shift)) (make-insert-fun 196) *lyrics-layer-mode-table*)
(add-keyseq '((#\/) (#\A :shift)) (make-insert-fun 197) *lyrics-layer-mode-table*)
(add-keyseq '((#\/) (#\E :shift)) (make-insert-fun 198) *lyrics-layer-mode-table*)
(add-keyseq '((#\/) (#\C :shift)) (make-insert-fun 199) *lyrics-layer-mode-table*)
(add-keyseq '((#\`) (#\E :shift)) (make-insert-fun 200) *lyrics-layer-mode-table*)
(add-keyseq '((#\') (#\E :shift)) (make-insert-fun 201) *lyrics-layer-mode-table*)
(add-keyseq '((#\^) (#\E :shift)) (make-insert-fun 202) *lyrics-layer-mode-table*)
(add-keyseq '((#\") (#\E :shift)) (make-insert-fun 203) *lyrics-layer-mode-table*)
(add-keyseq '((#\`) (#\I :shift)) (make-insert-fun 204) *lyrics-layer-mode-table*)
(add-keyseq '((#\') (#\I :shift)) (make-insert-fun 205) *lyrics-layer-mode-table*)
(add-keyseq '((#\^) (#\I :shift)) (make-insert-fun 206) *lyrics-layer-mode-table*)
(add-keyseq '((#\") (#\I :shift)) (make-insert-fun 207) *lyrics-layer-mode-table*)
(add-keyseq '((#\/) (#\D :shift)) (make-insert-fun 208) *lyrics-layer-mode-table*)
(add-keyseq '((#\~) (#\N :shift)) (make-insert-fun 209) *lyrics-layer-mode-table*)
(add-keyseq '((#\`) (#\O :shift)) (make-insert-fun 210) *lyrics-layer-mode-table*)
(add-keyseq '((#\') (#\O :shift)) (make-insert-fun 211) *lyrics-layer-mode-table*)
(add-keyseq '((#\^) (#\O :shift)) (make-insert-fun 212) *lyrics-layer-mode-table*)
(add-keyseq '((#\~) (#\O :shift)) (make-insert-fun 213) *lyrics-layer-mode-table*)
(add-keyseq '((#\") (#\O :shift)) (make-insert-fun 214) *lyrics-layer-mode-table*)

(add-keyseq '((#\/) (#\O :shift)) (make-insert-fun 216) *lyrics-layer-mode-table*)
(add-keyseq '((#\`) (#\U :shift)) (make-insert-fun 217) *lyrics-layer-mode-table*)
(add-keyseq '((#\') (#\U :shift)) (make-insert-fun 218) *lyrics-layer-mode-table*)
(add-keyseq '((#\^) (#\U :shift)) (make-insert-fun 219) *lyrics-layer-mode-table*)
(add-keyseq '((#\") (#\U :shift)) (make-insert-fun 220) *lyrics-layer-mode-table*)
(add-keyseq '((#\') (#\Y :shift)) (make-insert-fun 221) *lyrics-layer-mode-table*)


(add-keyseq '((#\`) (#\a)) (make-insert-fun 224) *lyrics-layer-mode-table*)
(add-keyseq '((#\') (#\a)) (make-insert-fun 225) *lyrics-layer-mode-table*)
(add-keyseq '((#\^) (#\a)) (make-insert-fun 226) *lyrics-layer-mode-table*)
(add-keyseq '((#\~) (#\a)) (make-insert-fun 227) *lyrics-layer-mode-table*)
(add-keyseq '((#\") (#\a)) (make-insert-fun 228) *lyrics-layer-mode-table*)
(add-keyseq '((#\/) (#\a)) (make-insert-fun 229) *lyrics-layer-mode-table*)
(add-keyseq '((#\/) (#\e)) (make-insert-fun 230) *lyrics-layer-mode-table*)
(add-keyseq '((#\~) (#\c)) (make-insert-fun 231) *lyrics-layer-mode-table*)
(add-keyseq '((#\`) (#\e)) (make-insert-fun 232) *lyrics-layer-mode-table*)
(add-keyseq '((#\') (#\e)) (make-insert-fun 233) *lyrics-layer-mode-table*)
(add-keyseq '((#\^) (#\e)) (make-insert-fun 234) *lyrics-layer-mode-table*)
(add-keyseq '((#\") (#\e)) (make-insert-fun 235) *lyrics-layer-mode-table*)
(add-keyseq '((#\`) (#\i)) (make-insert-fun 236) *lyrics-layer-mode-table*)
(add-keyseq '((#\') (#\i)) (make-insert-fun 237) *lyrics-layer-mode-table*)
(add-keyseq '((#\^) (#\i)) (make-insert-fun 238) *lyrics-layer-mode-table*)
(add-keyseq '((#\") (#\i)) (make-insert-fun 239) *lyrics-layer-mode-table*)


(add-keyseq '((#\`) (#\o)) (make-insert-fun 242) *lyrics-layer-mode-table*)
(add-keyseq '((#\') (#\o)) (make-insert-fun 243) *lyrics-layer-mode-table*)
(add-keyseq '((#\^) (#\o)) (make-insert-fun 244) *lyrics-layer-mode-table*)
(add-keyseq '((#\~) (#\o)) (make-insert-fun 245) *lyrics-layer-mode-table*)
(add-keyseq `((#\") (#\o)) (make-insert-fun 246) *lyrics-layer-mode-table*)

(add-keyseq '((#\/) (#\o)) (make-insert-fun 248) *lyrics-layer-mode-table*)
(add-keyseq '((#\`) (#\u)) (make-insert-fun 249) *lyrics-layer-mode-table*)
(add-keyseq '((#\') (#\u)) (make-insert-fun 250) *lyrics-layer-mode-table*)
(add-keyseq '((#\^) (#\u)) (make-insert-fun 251) *lyrics-layer-mode-table*)
(add-keyseq '((#\") (#\u)) (make-insert-fun 252) *lyrics-layer-mode-table*)
(add-keyseq '((#\') (#\y)) (make-insert-fun 253) *lyrics-layer-mode-table*)

(add-keyseq '((#\") (#\y)) (make-insert-fun 255) *lyrics-layer-mode-table*)


	     	     