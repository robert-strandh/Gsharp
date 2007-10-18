G#V4

[GSHARP-BUFFER:BUFFER
   :min-width 17
   :spacing-style 0.4
   :right-edge 700
   :left-offset 30
   :left-margin 20
   :staves (#1=[GSHARP-BUFFER:FIVELINE-STAFF
                  :clef [GSHARP-BUFFER:CLEF :lineno 2 :name :TREBLE ]
                  :keysig [GSHARP-BUFFER:KEY-SIGNATURE
                             :staff #1#
                             :alterations #(:NATURAL :NATURAL :NATURAL :NATURAL
                                            :NATURAL :NATURAL :NATURAL)
                             :xoffset 0 ]
                  :name "staff 1" ]
            #2=[GSHARP-BUFFER:LYRICS-STAFF :name "lyricstaff 1" ]
            #3=[GSHARP-BUFFER:FIVELINE-STAFF
                  :clef [GSHARP-BUFFER:CLEF :lineno 2 :name :TREBLE ]
                  :keysig [GSHARP-BUFFER:KEY-SIGNATURE
                             :staff #3#
                             :alterations #(:NATURAL :NATURAL :NATURAL :NATURAL
                                            :NATURAL :NATURAL :NATURAL)
                             :xoffset 0 ]
                  :name "staff 2" ])
   :segments ([GSHARP-BUFFER:SEGMENT
                 :layers ([GSHARP-BUFFER:MELODY-LAYER
                             :staves (#1#)
                             :head [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]) ]
                             :body [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #2#
                                                                         :head COMMON-LISP:NIL
                                                                         :accidentals :NATURAL
                                                                         :dots COMMON-LISP:NIL ])
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :xoffset 0 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #2#
                                                                         :head COMMON-LISP:NIL
                                                                         :accidentals :NATURAL
                                                                         :dots COMMON-LISP:NIL ])
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :xoffset 0 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 33
                                                                         :staff #2#
                                                                         :head COMMON-LISP:NIL
                                                                         :accidentals :NATURAL
                                                                         :dots COMMON-LISP:NIL ])
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :xoffset 0 ]) ]) ]
                             :tail [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]) ]
                             :name #4="default layer" ]
                          [GSHARP-BUFFER:LYRICS-LAYER
                             :staves (#2#)
                             :head [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:LYRICS-BAR
                                                :elements COMMON-LISP:NIL ]) ]
                             :body [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:LYRICS-BAR
                                                :elements ([GSHARP-BUFFER:LYRICS-ELEMENT
                                                              :staff #2#
                                                              :text #(97)
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :xoffset 0 ]
                                                           [GSHARP-BUFFER:LYRICS-ELEMENT
                                                              :staff #2#
                                                              :text #(98)
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :xoffset 0 ]
                                                           [GSHARP-BUFFER:LYRICS-ELEMENT
                                                              :staff #2#
                                                              :text #(99)
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :xoffset 0 ]
                                                           [GSHARP-BUFFER:LYRICS-ELEMENT
                                                              :staff #2#
                                                              :text #(100)
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :xoffset 0 ]) ]) ]
                             :tail [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:LYRICS-BAR
                                                :elements COMMON-LISP:NIL ]) ]
                             :name #4# ])
                 :tempo 128
                 :tuning [GSHARP-BUFFER:12-EDO
                            :master-pitch-note [GSHARP-BUFFER:NOTE
                                                  :pitch 33
                                                  :staff [GSHARP-BUFFER:STAFF
                                                            :name "default staff" ]
                                                  :head COMMON-LISP:NIL
                                                  :accidentals :NATURAL
                                                  :dots COMMON-LISP:NIL ]
                            :master-pitch-freq 440 ] ]) ]
