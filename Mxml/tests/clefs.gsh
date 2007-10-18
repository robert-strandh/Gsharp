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
            #2=[GSHARP-BUFFER:FIVELINE-STAFF
                  :clef [GSHARP-BUFFER:CLEF :lineno 6 :name :BASS ]
                  :keysig [GSHARP-BUFFER:KEY-SIGNATURE
                             :staff #2#
                             :alterations #(:NATURAL :NATURAL :NATURAL :NATURAL
                                            :NATURAL :NATURAL :NATURAL)
                             :xoffset 0 ]
                  :name "staff 2" ]
            #3=[GSHARP-BUFFER:FIVELINE-STAFF
                  :clef [GSHARP-BUFFER:CLEF :lineno 4 :name :C ]
                  :keysig [GSHARP-BUFFER:KEY-SIGNATURE
                             :staff #3#
                             :alterations #(:SHARP :NATURAL :NATURAL :SHARP
                                            :SHARP :NATURAL :NATURAL)
                             :xoffset 0 ]
                  :name "staff 3" ]
            #4=[GSHARP-BUFFER:FIVELINE-STAFF
                  :clef [GSHARP-BUFFER:CLEF :lineno 6 :name :C ]
                  :keysig [GSHARP-BUFFER:KEY-SIGNATURE
                             :staff #4#
                             :alterations #(:NATURAL :NATURAL :NATURAL :NATURAL
                                            :NATURAL :NATURAL :NATURAL)
                             :xoffset 0 ]
                  :name "staff 4" ])
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
                                                                         :pitch 28
                                                                         :staff #1#
                                                                         :head COMMON-LISP:NIL
                                                                         :accidentals :NATURAL
                                                                         :dots COMMON-LISP:NIL ])
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :xoffset 0 ]) ]) ]
                             :tail [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]) ]
                             :name "default layer" ])
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
