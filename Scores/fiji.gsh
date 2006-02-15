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
            #2=[GSHARP-BUFFER:LYRICS-STAFF :name "lyrics" ]
            #3=[GSHARP-BUFFER:FIVELINE-STAFF
                  :name "lower"
                  :clef [GSHARP-BUFFER:CLEF :name :BASS :lineno 6 ]
                  :keysig [GSHARP-BUFFER:KEY-SIGNATURE
                             :xoffset 0
                             :staff #3#
                             :alterations #(:NATURAL :NATURAL :NATURAL :NATURAL
                                            :NATURAL :NATURAL :NATURAL) ] ])
   :segments ([GSHARP-BUFFER:SEGMENT
                 :layers ([GSHARP-BUFFER:LYRICS-LAYER
                             :name "lyrics"
                             :staves (#2#)
                             :head [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:LYRICS-BAR
                                                :elements COMMON-LISP:NIL ]) ]
                             :body [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:LYRICS-BAR
                                                :elements ([GSHARP-BUFFER:LYRICS-ELEMENT
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :text #() ]
                                                           [GSHARP-BUFFER:LYRICS-ELEMENT
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :text #(116 104
                                                                      97
                                                                      116) ]) ]
                                             [GSHARP-BUFFER:LYRICS-BAR
                                                :elements ([GSHARP-BUFFER:LYRICS-ELEMENT
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :text #(102
                                                                      105) ]
                                                           [GSHARP-BUFFER:LYRICS-ELEMENT
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :text #(106
                                                                      105) ]
                                                           [GSHARP-BUFFER:LYRICS-ELEMENT
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :text #(104
                                                                      111) ]
                                                           [GSHARP-BUFFER:LYRICS-ELEMENT
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :text #(108
                                                                      105) ]
                                                           [GSHARP-BUFFER:LYRICS-ELEMENT
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :text #(100 97
                                                                      121) ]) ]
                                             [GSHARP-BUFFER:LYRICS-BAR
                                                :elements ([GSHARP-BUFFER:LYRICS-ELEMENT
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :text #(102 101
                                                                      101) ]
                                                           [GSHARP-BUFFER:LYRICS-ELEMENT
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :text #(108 105
                                                                      110
                                                                      103) ]) ]) ]
                             :tail [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:LYRICS-BAR
                                                :elements COMMON-LISP:NIL ]) ] ]
                          [GSHARP-BUFFER:MELODY-LAYER
                             :name "bass"
                             :staves (#3#)
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
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes COMMON-LISP:NIL ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes COMMON-LISP:NIL ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 17
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 19
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 20
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 18
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 17
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 19
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 20
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :SHARP
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 18
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 19
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 20
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 17
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 19
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 20
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 17
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]) ]
                             :tail [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]) ] ]
                          [GSHARP-BUFFER:MELODY-LAYER
                             :name "default layer"
                             :staves (#1#)
                             :head [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]) ]
                             :body [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
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
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
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
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
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
                                                              :dots 0
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
                                                              :dots 0
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
                                                              :dots 0
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
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
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
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #1#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
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
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
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
                                                              :dots 0
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
                                                              :dots 0
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
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #1#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #1#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
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
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
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
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
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
                                                              :dots 0
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
                                                              :dots 0
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
                                                              :dots 0
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
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
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
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #1#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
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
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
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
                                                              :dots 0
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
                                                              :dots 0
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
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 33
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #1#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
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
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
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
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
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
                                                              :dots 0
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
                                                              :dots 0
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
                                                              :dots 0
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
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
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
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #1#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 38
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 38
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
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
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #1#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]) ]
                             :tail [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]) ] ]) ]) ]
