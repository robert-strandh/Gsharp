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
                  :name "default staff" ]
            #2=[GSHARP-BUFFER:FIVELINE-STAFF
                  :clef [GSHARP-BUFFER:CLEF :lineno 2 :name :TREBLE ]
                  :keysig [GSHARP-BUFFER:KEY-SIGNATURE
                             :staff #2#
                             :alterations #(:NATURAL :NATURAL :NATURAL :NATURAL
                                            :NATURAL :NATURAL :NATURAL)
                             :xoffset 0 ]
                  :name "below" ])
   :segments ([GSHARP-BUFFER:SEGMENT
                 :layers ([GSHARP-BUFFER:MELODY-LAYER
                             :staves (#2# #1#)
                             :head [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]) ]
                             :body [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 33
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ])
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :xoffset 0 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ])
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :xoffset 0 ]) ]) ]
                             :tail [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]) ]
                             :name "default layer" ])
                 :tempo 128 ]) ]
