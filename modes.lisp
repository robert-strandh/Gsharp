(cl:in-package #:gsharp)

(define-command-table global-gsharp-table
    :inherit-from (global-esa-table esa-io-table keyboard-macro-table help-table))

(set-key `(com-forward-element ,*numeric-argument-marker*) 'global-gsharp-table '((#\f :control)))
(set-key `(com-backward-element ,*numeric-argument-marker*) 'global-gsharp-table '((#\b :control)))
(set-key `(com-forward-measure ,*numeric-argument-marker*) 'global-gsharp-table '((#\f :control :meta)))
(set-key `(com-backward-measure ,*numeric-argument-marker*) 'global-gsharp-table '((#\b :control :meta)))
(set-key `(com-delete-element ,*numeric-argument-marker*) 'global-gsharp-table '((#\d :control)))
(set-key `(com-delete-element ,*numeric-argument-marker*) 'global-gsharp-table '((#\Rubout)))
(set-key `(com-erase-element ,*numeric-argument-marker*) 'global-gsharp-table '((#\Backspace)))

(set-key `(com-switch-to-view ,*unsupplied-argument-marker*) 'global-gsharp-table '((#\x :control) #\b))
(set-key `(com-kill-view ,*unsupplied-argument-marker*) 'global-gsharp-table '((#\x :control) #\k))

;;; FIXME: implement numeric arg handling
(set-key 'com-forward-page 'global-gsharp-table '((#\x :control) #\]))
(set-key 'com-backward-page 'global-gsharp-table '((#\x :control) #\[))
(set-key 'com-end-of-line 'global-gsharp-table '((#\e :control)))
(set-key 'com-beginning-of-line 'global-gsharp-table '((#\a :control)))

;;; FIXME: implement numeric arg handling
(set-key 'com-previous-staff 'global-gsharp-table '((:up :control)))
(set-key 'com-next-staff 'global-gsharp-table '((:down :control)))

(set-key 'com-insert-barline 'global-gsharp-table '(#\|))

(set-key 'com-end-of-score 'global-gsharp-table '((#\> :meta)))
(set-key 'com-beginning-of-score 'global-gsharp-table '((#\< :meta)))

;;; FIXME where are the corresponding commands?
(set-key 'com-left 'global-gsharp-table '((#\l :meta)))
(set-key 'com-right 'global-gsharp-table '((#\r :meta)))

;; Post MS file-io keystrokes
(set-key 'com-load-score-file 'global-gsharp-table '((#\o :meta)))
(set-key 'com-save-score-file-as 'global-gsharp-table '((#\S :meta)))
(set-key 'com-save-buffer 'global-gsharp-table '((#\s :meta)))


(set-key 'com-istate-more-dots 'global-gsharp-table '((#\i) (#\.)))
(set-key 'com-istate-more-lbeams 'global-gsharp-table '((#\i) (#\[)))
(set-key 'com-istate-more-rbeams 'global-gsharp-table '((#\i) (#\])))
(set-key 'com-istate-rotate-notehead 'global-gsharp-table '((#\i) (#\h)))
(set-key 'com-istate-rotate-notehead-downwards 'global-gsharp-table '((#\i) (#\g)))
(set-key 'com-istate-rotate-stem-direction 'global-gsharp-table '((#\i) (#\s)))
(set-key 'com-istate-fewer-dots 'global-gsharp-table '((#\i) (#\x) (#\.)))
(set-key 'com-istate-fewer-lbeams 'global-gsharp-table '((#\i) (#\x) (#\[)))
(set-key 'com-istate-fewer-rbeams 'global-gsharp-table '((#\i) (#\x) (#\])))

(set-key 'com-zoom-in 'global-gsharp-table '(#\+))
(set-key 'com-zoom-out 'global-gsharp-table '(#\-))

(set-key `(com-eval-expression ,*unsupplied-argument-marker*) 
         'global-gsharp-table '((#\: :meta)))

;;; the melody table contains commands that are specific to the 
;;; melody layer

(define-command-table melody-table)

(set-key 'com-lower 'melody-table '(#\L))
(set-key 'com-higher 'melody-table '(#\H))
(set-key 'com-insert-note-a 'melody-table '(#\a))
(set-key 'com-insert-note-b 'melody-table '(#\b))
(set-key 'com-insert-note-c 'melody-table '(#\c))
(set-key 'com-insert-note-d 'melody-table '(#\d))
(set-key 'com-insert-note-e 'melody-table '(#\e))
(set-key 'com-insert-note-f 'melody-table '(#\f))
(set-key 'com-insert-note-g 'melody-table '(#\g))
(set-key 'com-insert-rest 'melody-table '((#\,)))
(set-key 'com-insert-empty-cluster 'melody-table '((#\Space)))
(set-key 'com-insert-keysig 'melody-table '(#\K))

(set-key 'com-more-sharps 'melody-table '((#\# :meta)))
(set-key 'com-more-flats 'melody-table '((#\@ :meta)))

;;; the rhythmic table contains command that are specific 
;;; to rhythmic elements
(define-command-table rhythmic-table)

(set-key 'com-more-dots 'rhythmic-table '((#\.)))
(set-key 'com-more-lbeams 'rhythmic-table '((#\[)))
(set-key 'com-more-rbeams 'rhythmic-table '((#\])))
(set-key 'com-fewer-dots 'rhythmic-table '((#\x) (#\.)))
(set-key 'com-fewer-lbeams 'rhythmic-table '((#\x) (#\[)))
(set-key 'com-fewer-rbeams 'rhythmic-table '((#\x) (#\])))
(set-key 'com-rotate-notehead 'rhythmic-table '((#\h :meta)))
(set-key 'com-rotate-notehead 'rhythmic-table '((#\r :control))) ; why this one too?
(set-key 'com-up 'rhythmic-table '((#\u :meta)))
(set-key 'com-down 'rhythmic-table '((#\d :meta)))

;;; the cluster table contains commands that are specific to 
;;; clusters

(define-command-table cluster-table
    :inherit-from (rhythmic-table))

(set-key 'com-sharper 'cluster-table '((#\#)))
(set-key 'com-flatter 'cluster-table '(#\@))
(set-key 'com-microsharper 'cluster-table '((#\# :control)))
(set-key 'com-microsharper 'cluster-table '((#\# :control)))
(set-key 'com-microflatter 'cluster-table '((#\@ :control)))
(set-key 'com-microflatter 'cluster-table '((#\@ :control)))
(set-key 'com-add-note-c 'cluster-table '(#\C))
(set-key 'com-add-note-d 'cluster-table '(#\D))
(set-key 'com-add-note-e 'cluster-table '(#\E))
(set-key 'com-add-note-f 'cluster-table '(#\F))
(set-key 'com-add-note-g 'cluster-table '(#\G))
(set-key 'com-add-note-a 'cluster-table '(#\A))
(set-key 'com-add-note-b 'cluster-table '(#\B))
(set-key 'com-tie-note-left 'cluster-table '((#\{)))
(set-key 'com-tie-note-right 'cluster-table '((#\})))
(set-key 'com-untie-note-left 'cluster-table '((#\x) (#\{)))
(set-key 'com-untie-note-right 'cluster-table '((#\x) (#\})))
(set-key 'com-rotate-stem-direction 'cluster-table '((#\s :meta)))
(set-key 'com-toggle-staccato 'cluster-table '(#\s))
(set-key 'com-toggle-tenuto 'cluster-table '(#\t))
(set-key 'com-current-increment 'cluster-table '((#\p)))
(set-key 'com-current-decrement 'cluster-table '((#\n)))
(set-key 'com-octave-up 'cluster-table '((#\U :meta)))
(set-key 'com-octave-down 'cluster-table '((#\D :meta)))

;;; lyrics mode table

(define-command-table lyrics-table
    :inherit-from (rhythmic-table))

(set-key (lambda () (erase-char (cur-element))) 'lyrics-table '((#\h :control)))
(set-key `(com-erase-element *numeric-argument-marker*) 'lyrics-table '((#\h :meta)))
(set-key 'insert-lyrics-element 'lyrics-table '((#\Space :control)))


(defun make-insert-fun (code)
  (lambda () (append-char (cur-element) code)))

(loop for c in '(#\A #\B #\C #\D #\E #\F #\G #\H #\I #\J #\K #\L #\M 
                 #\N #\O #\P #\Q #\R #\S #\T #\U #\V #\W #\X #\Y #\Z)
      for i from 65
      do (set-key (make-insert-fun i) 'lyrics-table `((,c))))

(loop for c in '(#\a #\b #\c #\d #\e #\f #\g #\h #\i #\j #\k #\l #\m 
                 #\n #\o #\p #\q #\r #\s #\t #\u #\v #\w #\x #\y #\z)
      for i from 97
      do (set-key (make-insert-fun i) 'lyrics-table`((,c))))

;;; try some latin prefix mode for national characters 
(set-key (make-insert-fun 192) 'lyrics-table '((:dead--grave) (#\A)))
(set-key (make-insert-fun 193) 'lyrics-table '((:dead--acute) (#\A)))
(set-key (make-insert-fun 194) 'lyrics-table '((:dead--circumflex) (#\A)))
(set-key (make-insert-fun 195) 'lyrics-table '((:dead--tilde) (#\A)))
(set-key (make-insert-fun 196) 'lyrics-table '((:dead--diaeresis) (#\A)))
(set-key (make-insert-fun 197) 'lyrics-table '((:dead-above-ring) (#\A)))
(set-key (make-insert-fun 198) 'lyrics-table '((:dead-above-ring) (#\E)))
(set-key (make-insert-fun 199) 'lyrics-table '((:dead-above-ring) (#\C)))
(set-key (make-insert-fun 200) 'lyrics-table '((:dead--grave) (#\E)))
(set-key (make-insert-fun 201) 'lyrics-table '((:dead--acute) (#\E)))
(set-key (make-insert-fun 202) 'lyrics-table '((:dead--circumflex) (#\E)))
(set-key (make-insert-fun 203) 'lyrics-table '((:dead--diaeresis) (#\E)))
(set-key (make-insert-fun 204) 'lyrics-table '((:dead--grave) (#\I)))
(set-key (make-insert-fun 205) 'lyrics-table '((:dead--acute) (#\I)))
(set-key (make-insert-fun 206) 'lyrics-table '((:dead--circumflex) (#\I)))
(set-key (make-insert-fun 207) 'lyrics-table '((:dead--diaeresis) (#\I)))
(set-key (make-insert-fun 208) 'lyrics-table '((:dead-above-ring) (#\D)))
(set-key (make-insert-fun 209) 'lyrics-table '((:dead--tilde) (#\N)))
(set-key (make-insert-fun 210) 'lyrics-table '((:dead--grave) (#\O)))
(set-key (make-insert-fun 211) 'lyrics-table '((:dead--acute) (#\O)))
(set-key (make-insert-fun 212) 'lyrics-table '((:dead--circumflex) (#\O)))
(set-key (make-insert-fun 213) 'lyrics-table '((:dead--tilde) (#\O)))
(set-key (make-insert-fun 214) 'lyrics-table '((:dead--diaeresis) (#\O)))

(set-key (make-insert-fun 216) 'lyrics-table '((:dead-above-ring) (#\O)))
(set-key (make-insert-fun 217) 'lyrics-table '((:dead--grave) (#\U)))
(set-key (make-insert-fun 218) 'lyrics-table '((:dead--acute) (#\U)))
(set-key (make-insert-fun 219) 'lyrics-table '((:dead--circumflex) (#\U)))
(set-key (make-insert-fun 220) 'lyrics-table '((:dead--diaeresis) (#\U)))
(set-key (make-insert-fun 221) 'lyrics-table '((:dead--acute) (#\Y)))


(set-key (make-insert-fun 224) 'lyrics-table '((:dead--grave) (#\a)))
(set-key (make-insert-fun 225) 'lyrics-table '((:dead--acute) (#\a)))
(set-key (make-insert-fun 226) 'lyrics-table '((:dead--circumflex) (#\a)))
(set-key (make-insert-fun 227) 'lyrics-table '((:dead--tilde) (#\a)))
(set-key (make-insert-fun 228) 'lyrics-table '((:dead--diaeresis) (#\a)))
(set-key (make-insert-fun 229) 'lyrics-table '((:dead-above-ring) (#\a)))
(set-key (make-insert-fun 230) 'lyrics-table '((:dead-above-ring) (#\e)))
(set-key (make-insert-fun 231) 'lyrics-table '((:dead--tilde) (#\c)))
(set-key (make-insert-fun 232) 'lyrics-table '((:dead--grave) (#\e)))
(set-key (make-insert-fun 233) 'lyrics-table '((:dead--acute) (#\e)))
(set-key (make-insert-fun 234) 'lyrics-table '((:dead--circumflex) (#\e)))
(set-key (make-insert-fun 235) 'lyrics-table '((:dead--diaeresis) (#\e)))
(set-key (make-insert-fun 236) 'lyrics-table '((:dead--grave) (#\i)))
(set-key (make-insert-fun 237) 'lyrics-table '((:dead--acute) (#\i)))
(set-key (make-insert-fun 238) 'lyrics-table '((:dead--circumflex) (#\i)))
(set-key (make-insert-fun 239) 'lyrics-table '((:dead--diaeresis) (#\i)))


(set-key (make-insert-fun 242) 'lyrics-table '((:dead--grave) (#\o)))
(set-key (make-insert-fun 243) 'lyrics-table '((:dead--acute) (#\o)))
(set-key (make-insert-fun 244) 'lyrics-table '((:dead--circumflex) (#\o)))
(set-key (make-insert-fun 245) 'lyrics-table '((:dead--tilde) (#\o)))
(set-key (make-insert-fun 246) 'lyrics-table `((:dead--diaeresis) (#\o)))

(set-key (make-insert-fun 248) 'lyrics-table '((:dead-above-ring) (#\o)))
(set-key (make-insert-fun 249) 'lyrics-table '((:dead--grave) (#\u)))
(set-key (make-insert-fun 250) 'lyrics-table '((:dead--acute) (#\u)))
(set-key (make-insert-fun 251) 'lyrics-table '((:dead--circumflex) (#\u)))
(set-key (make-insert-fun 252) 'lyrics-table '((:dead--diaeresis) (#\u)))
(set-key (make-insert-fun 253) 'lyrics-table '((:dead--acute) (#\y)))

(set-key (make-insert-fun 255) 'lyrics-table '((:dead--diaeresis) (#\y)))
