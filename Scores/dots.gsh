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
                                            :NATURAL :NATURAL :NATURAL) ] ]
            #2=[GSHARP-BUFFER:FIVELINE-STAFF
                  :name "foo"
                  :clef [GSHARP-BUFFER:CLEF :name :BASS :lineno 4 ]
                  :keysig [GSHARP-BUFFER:KEY-SIGNATURE
                             :xoffset 0
                             :staff #2#
                             :alterations #(:NATURAL :NATURAL :NATURAL :NATURAL
                                            :NATURAL :NATURAL :NATURAL) ] ])
   :segments ([GSHARP-BUFFER:SEGMENT
                 :layers ([GSHARP-BUFFER:MELODY-LAYER
                             :name "default layer"
                             :staves (#1# #2#)
                             :head [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]) ]
                             :body [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :staff #1#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 38
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 1
                                                              :staff #1#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :staff #1#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 33
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 38
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 33
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:KEY-SIGNATURE
                                                              :xoffset 0
                                                              :staff #1#
                                                              :alterations #(:NATURAL
                                                                             :NATURAL
                                                                             :NATURAL
                                                                             :NATURAL
                                                                             :NATURAL
                                                                             :NATURAL
                                                                             :NATURAL) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 33
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 33
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 3
                                                              :staff #1#
                                                              :staff-pos 4 ]) ]) ]
                             :tail [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]) ] ])
                 :tempo 128 ]) ]
