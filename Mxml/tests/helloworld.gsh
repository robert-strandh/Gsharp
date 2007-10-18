G#V4

[GSHARP-BUFFER:BUFFER
   :min-width 17
   :spacing-style 0.4
   :right-edge 700
   :left-offset 30
   :left-margin 20
   :staves (#1=[GSHARP-BUFFER:FIVELINE-STAFF
                :name "default staff"
                  :clef [GSHARP-BUFFER:CLEF :name :TREBLE :lineno 2 ]
                  :keysig [GSHARP-BUFFER:KEY-SIGNATURE
                             :xoffset 0
                             :staff #1#
                             :alterations #(:NATURAL :NATURAL :NATURAL :NATURAL
                                            :NATURAL :NATURAL :NATURAL) ] ])
   :segments ([GSHARP-BUFFER:SEGMENT
                 :layers ([GSHARP-BUFFER:MELODY-LAYER
                           :name "default layer"
                             :staves (#1#)
                             :head [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]) ]
                             :body [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]) ]
                             :tail [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]) ] ])
                 :tempo 128 ]) ]
