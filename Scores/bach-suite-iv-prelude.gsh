G#V4

[GSHARP-BUFFER:BUFFER
   :min-width 12
   :spacing-style 0.4
   :right-edge 700
   :left-offset 30
   :left-margin 20
   :staves (#1=[GSHARP-BUFFER:FIVELINE-STAFF
                  :name "treble"
                  :clef [GSHARP-BUFFER:CLEF :name :TREBLE :lineno 2 ]
                  :keysig [GSHARP-BUFFER:KEY-SIGNATURE
                             :xoffset 0
                             :staff #1#
                             :alterations #(:NATURAL :NATURAL :NATURAL :NATURAL
                                            :NATURAL :NATURAL :FLAT) ] ]
            #2=[GSHARP-BUFFER:FIVELINE-STAFF
                  :name "bass"
                  :clef [GSHARP-BUFFER:CLEF :name :BASS :lineno 6 ]
                  :keysig [GSHARP-BUFFER:KEY-SIGNATURE
                             :xoffset 0
                             :staff #2#
                             :alterations #(:NATURAL :NATURAL :NATURAL :NATURAL
                                            :NATURAL :NATURAL :FLAT) ] ])
   :segments ([GSHARP-BUFFER:SEGMENT
                 :layers ([GSHARP-BUFFER:MELODY-LAYER
                             :name "bass"
                             :staves (#2#)
                             :head [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]) ]
                             :body [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
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
                                                                         :pitch 31
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 31
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
                                                                         :pitch 31
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
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
                                                                         :pitch 30
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
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
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
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
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
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
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
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
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 20
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 19
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 18
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 19
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 17
                                                                         :staff #2#
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
                                                                         :pitch 18
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
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
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
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
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
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
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 20
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 14
                                                                         :staff #2#
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
                                                                         :pitch 17
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 17
                                                                         :staff #2#
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
                                                                         :pitch 14
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
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
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
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
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
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
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
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
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
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
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
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
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
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 20
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 19
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 20
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 18
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 19
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 20
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 19
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 20
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
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
                                                                         :pitch 15
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 20
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 19
                                                                         :staff #2#
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
                                                                         :pitch 20
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 18
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 14
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 17
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
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
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
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
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
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
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 17
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 19
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 18
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 17
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 18
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 20
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 18
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 20
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 20
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 18
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 20
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 16
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #2#
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
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 18
                                                                         :staff #2#
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
                                                                         :pitch 14
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
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]) ]
                             :tail [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]) ] ]
                          [GSHARP-BUFFER:MELODY-LAYER
                             :name "treble"
                             :staves (#1#)
                             :head [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]) ]
                             :body [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #1#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
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
                                                              :lbeams 1
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
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 1
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
                                                              :rbeams 1
                                                              :lbeams 2
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
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 1
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
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
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
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 38
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 40
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 1
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
                                                              :rbeams 1
                                                              :lbeams 1
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
                                                              :dots 1
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
                                                              :lbeams 2
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
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
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
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
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
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
                                                                         :pitch 42
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 42
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
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 42
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 3
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 42
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 3
                                                              :lbeams 3
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 41
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 3
                                                              :lbeams 3
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 42
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 3
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 40
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
                                                                         :pitch 41
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 40
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
                                                                         :pitch 40
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
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
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 40
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 40
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
                                                                         :pitch 40
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 3
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 3
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
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
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
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
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
                                                                         :pitch 38
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 38
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 40
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 40
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 41
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 42
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 41
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 40
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 42
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 41
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 42
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 40
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 41
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 40
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 38
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
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 40
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
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :DOWN
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
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
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
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
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
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
                                                                         :pitch 38
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 38
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
                                                                         :pitch 38
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
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
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
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
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 41
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 41
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
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
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 41
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 42
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
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 40
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
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
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 40
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
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 38
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 40
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
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
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 39
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
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 40
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
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
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
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
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
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 39
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
                                                                         :accidentals :FLAT
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
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 38
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
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 33
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
                                                              :rbeams 2
                                                              :lbeams 1
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
                                                              :lbeams 2
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
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
                                                              :lbeams 1
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
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #1#
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
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
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
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
                                                           [GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #1#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
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
                                                              :rbeams 1
                                                              :lbeams 2
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
                                                              :rbeams 1
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 38
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 38
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
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
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 3
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 3
                                                              :lbeams 3
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
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
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
                                                              :rbeams 1
                                                              :lbeams 1
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
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
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
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 40
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
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
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
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
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 40
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :FLAT
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 38
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
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
                                                              :rbeams 1
                                                              :lbeams 1
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
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 38
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
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
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
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 36
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
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 36
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
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 36
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
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
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
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
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
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 35
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
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 37
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
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 35
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
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 35
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
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 35
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
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]
                                                                      [GSHARP-BUFFER:NOTE
                                                                         :pitch 35
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
                                                              :dots 0
                                                              :stem-direction :DOWN
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
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
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
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
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
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
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
                                                                         :pitch 36
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
                                                              :dots 0
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
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
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
                                                                         :pitch 35
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
                                                                         :pitch 29
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
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
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
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
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
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                              :rbeams 2
                                                              :lbeams 2
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
                                                                         :pitch 30
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
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
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
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
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 1
                                                              :dots 0
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
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
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
                                                              :stem-direction :UP
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
                                                              :lbeams 1
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
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
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
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :UP
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
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :UP
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
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
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
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 38
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
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
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 38
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
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
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 41
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 40
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 38
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :SHARP
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 38
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :SHARP
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :UP
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
                                                              :dots 1
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
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
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 40
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
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 38
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
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
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 38
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 3
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
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
                                                              :dots 1
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
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
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 39
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 38
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 37
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 34
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 2
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
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
                                                              :stem-direction :UP
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
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :UP
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
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 1
                                                              :lbeams 2
                                                              :dots 0
                                                              :stem-direction :UP
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]) ]
                             :tail [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]) ] ])
                 :tempo 128 ]) ]
