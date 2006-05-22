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
                  :name "alt"
                  :clef [GSHARP-BUFFER:CLEF :name :TREBLE8 :lineno 2 ]
                  :keysig [GSHARP-BUFFER:KEY-SIGNATURE
                             :xoffset 0
                             :staff #2#
                             :alterations #(:NATURAL :NATURAL :NATURAL :NATURAL
                                            :NATURAL :NATURAL :NATURAL) ] ]
            #3=[GSHARP-BUFFER:FIVELINE-STAFF
                  :name "ten"
                  :clef [GSHARP-BUFFER:CLEF :name :TREBLE8 :lineno 2 ]
                  :keysig [GSHARP-BUFFER:KEY-SIGNATURE
                             :xoffset 0
                             :staff #3#
                             :alterations #(:NATURAL :NATURAL :NATURAL :NATURAL
                                            :NATURAL :NATURAL :NATURAL) ] ]
            #4=[GSHARP-BUFFER:FIVELINE-STAFF
                  :name "bass"
                  :clef [GSHARP-BUFFER:CLEF :name :BASS :lineno 6 ]
                  :keysig [GSHARP-BUFFER:KEY-SIGNATURE
                             :xoffset 0
                             :staff #4#
                             :alterations #(:NATURAL :NATURAL :NATURAL :NATURAL
                                            :NATURAL :NATURAL :NATURAL) ] ])
   :segments ([GSHARP-BUFFER:SEGMENT
                 :layers ([GSHARP-BUFFER:MELODY-LAYER
                             :name "bass"
                             :staves (#4#)
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
                                                                         :pitch 21
                                                                         :staff #4#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #4#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #4#
                                                                         :head :WHOLE
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
                                                                         :pitch 25
                                                                         :staff #4#
                                                                         :head :WHOLE
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
                                                                         :pitch 24
                                                                         :staff #4#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #4#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #4#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #4#
                                                                         :head :WHOLE
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
                                                                         :pitch 22
                                                                         :staff #4#
                                                                         :head :WHOLE
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
                                                                         :pitch 22
                                                                         :staff #4#
                                                                         :head :WHOLE
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
                                                                         :pitch 24
                                                                         :staff #4#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #4#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #4#
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
                                                                         :staff #4#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #4#
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
                                                                         :staff #4#
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
                                                                         :pitch 23
                                                                         :staff #4#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #4#
                                                                         :head :HALF
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
                                                                         :pitch 23
                                                                         :staff #4#
                                                                         :head :HALF
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
                                                                         :pitch 22
                                                                         :staff #4#
                                                                         :head :HALF
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
                                                                         :pitch 25
                                                                         :staff #4#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #4#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #4#
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
                                                                         :staff #4#
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
                                                                         :pitch 22
                                                                         :staff #4#
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
                                                                         :pitch 21
                                                                         :staff #4#
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
                                                                         :staff #4#
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
                                                                         :staff #4#
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
                                                                         :pitch 24
                                                                         :staff #4#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #4#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #4#
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
                                                                         :staff #4#
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
                                                                         :pitch 21
                                                                         :staff #4#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #4#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #4#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #4#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #4#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #4#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #4#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #4#
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
                                                                         :pitch 19
                                                                         :staff #4#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #4#
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
                                                                         :staff #4#
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
                                                                         :staff #4#
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
                                                                         :pitch 21
                                                                         :staff #4#
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
                                                                         :staff #4#
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
                                                                         :pitch 23
                                                                         :staff #4#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #4#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #4#
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
                                                                         :pitch 21
                                                                         :staff #4#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #4#
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
                                                                         :staff #4#
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
                                                                         :pitch 24
                                                                         :staff #4#
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
                                                                         :staff #4#
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
                                                                         :staff #4#
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
                                                                         :pitch 23
                                                                         :staff #4#
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
                                                                         :pitch 22
                                                                         :staff #4#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #4#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #4#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #4#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #4#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #4#
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
                                                                         :pitch 24
                                                                         :staff #4#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #4#
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
                                                                         :pitch 24
                                                                         :staff #4#
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
                                                                         :pitch 23
                                                                         :staff #4#
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
                                                                         :pitch 21
                                                                         :staff #4#
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
                                                                         :staff #4#
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
                                                                         :pitch 23
                                                                         :staff #4#
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
                                                                         :staff #4#
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
                                                                         :staff #4#
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
                                                                         :pitch 24
                                                                         :staff #4#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #4#
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
                                                                         :staff #4#
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
                                                                         :pitch 24
                                                                         :staff #4#
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
                                                                         :staff #4#
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
                                                                         :staff #4#
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
                                                                         :pitch 21
                                                                         :staff #4#
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
                                                                         :pitch 22
                                                                         :staff #4#
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
                                                                         :pitch 21
                                                                         :staff #4#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #4#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #4#
                                                                         :head :WHOLE
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
                                                                         :pitch 23
                                                                         :staff #4#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #4#
                                                                         :head :HALF
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
                                                                         :pitch 22
                                                                         :staff #4#
                                                                         :head :WHOLE
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
                                                                         :pitch 21
                                                                         :staff #4#
                                                                         :head :WHOLE
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
                                                                         :staff #4#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #4#
                                                                         :head :HALF
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
                                                                         :pitch 22
                                                                         :staff #4#
                                                                         :head :HALF
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
                                                                         :pitch 18
                                                                         :staff #4#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 18
                                                                         :staff #4#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #4#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #4#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #4#
                                                                         :head :WHOLE
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
                                                                         :pitch 21
                                                                         :staff #4#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #4#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 23
                                                                         :staff #4#
                                                                         :head :WHOLE
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
                                                                         :staff #4#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
                                                                         :staff #4#
                                                                         :head :HALF
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
                                                                         :pitch 23
                                                                         :staff #4#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 22
                                                                         :staff #4#
                                                                         :head :HALF
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
                                                                         :pitch 21
                                                                         :staff #4#
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
                                                                         :pitch 22
                                                                         :staff #4#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 18
                                                                         :staff #4#
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
                                                                         :staff #4#
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
                                                                         :pitch 20
                                                                         :staff #4#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #4#
                                                                         :head :HALF
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
                                                                         :pitch 20
                                                                         :staff #4#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 21
                                                                         :staff #4#
                                                                         :head :HALF
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
                                                                         :pitch 18
                                                                         :staff #4#
                                                                         :head :HALF
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
                                                                         :pitch 21
                                                                         :staff #4#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]) ]
                             :tail [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]) ] ]
                          [GSHARP-BUFFER:MELODY-LAYER
                             :name "ten"
                             :staves (#3#)
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
                                                                         :pitch 25
                                                                         :staff #3#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #3#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #3#
                                                                         :head :WHOLE
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
                                                                         :pitch 27
                                                                         :staff #3#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #3#
                                                                         :head :WHOLE
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
                                                                         :pitch 25
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
                                                                         :pitch 26
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
                                                                         :pitch 27
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
                                                                         :pitch 28
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
                                                                         :pitch 29
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
                                                                         :pitch 30
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
                                                                         :pitch 29
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
                                                                         :pitch 28
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
                                                                         :pitch 27
                                                                         :staff #3#
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
                                                                         :pitch 26
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #3#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #3#
                                                                         :head :WHOLE
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
                                                                         :pitch 26
                                                                         :staff #3#
                                                                         :head :WHOLE
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
                                                                         :pitch 26
                                                                         :staff #3#
                                                                         :head :WHOLE
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
                                                                         :pitch 28
                                                                         :staff #3#
                                                                         :head :WHOLE
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
                                                                         :pitch 27
                                                                         :staff #3#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #3#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #3#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #3#
                                                                         :head :HALF
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
                                                                         :pitch 26
                                                                         :staff #3#
                                                                         :head :HALF
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
                                                                         :pitch 27
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
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
                                                                         :pitch 25
                                                                         :staff #3#
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
                                                                         :pitch 26
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #3#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #3#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #3#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #3#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #3#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #3#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #3#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
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
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
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
                                                                         :pitch 24
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
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 24
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
                                                                         :pitch 25
                                                                         :staff #3#
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
                                                                         :pitch 26
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
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
                                                                         :pitch 24
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
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
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
                                                                         :pitch 26
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
                                                                         :pitch 27
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
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
                                                                         :pitch 27
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #3#
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
                                                                         :pitch 29
                                                                         :staff #3#
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
                                                              :staff #3#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
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
                                                                         :pitch 28
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
                                                                         :pitch 29
                                                                         :staff #3#
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
                                                                         :pitch 30
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #3#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #3#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
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
                                                                         :pitch 28
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #3#
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
                                                                         :pitch 28
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
                                                                         :pitch 27
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
                                                                         :pitch 25
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
                                                                         :pitch 26
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
                                                                         :pitch 27
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
                                                                         :pitch 26
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
                                                                         :pitch 27
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
                                                                         :pitch 28
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
                                                                         :pitch 29
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
                                                                         :pitch 28
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
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
                                                                         :pitch 28
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #3#
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
                                                                         :pitch 25
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #3#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #3#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #3#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
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
                                                                         :pitch 27
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #3#
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
                                                                         :pitch 26
                                                                         :staff #3#
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
                                                                         :pitch 25
                                                                         :staff #3#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #3#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #3#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #3#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #3#
                                                                         :head :WHOLE
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
                                                                         :pitch 25
                                                                         :staff #3#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #3#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #3#
                                                                         :head :WHOLE
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
                                                                         :pitch 26
                                                                         :staff #3#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #3#
                                                                         :head :WHOLE
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
                                                                         :pitch 26
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
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
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
                                                                         :pitch 28
                                                                         :staff #3#
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
                                                                         :pitch 26
                                                                         :staff #3#
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
                                                                         :pitch 25
                                                                         :staff #3#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #3#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #3#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #3#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #3#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]) ]
                             :tail [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]) ] ]
                          [GSHARP-BUFFER:MELODY-LAYER
                             :name "alt"
                             :staves (#2#)
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
                                                                         :staff #2#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #2#
                                                                         :head :WHOLE
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
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #2#
                                                                         :head :WHOLE
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
                                                                         :staff #2#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :WHOLE
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
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :WHOLE
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
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :WHOLE
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
                                                                         :pitch 31
                                                                         :staff #2#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #2#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
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
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
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
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
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
                                                              :rbeams 0
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
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
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
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
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
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
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
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
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
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
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
                                                              :rbeams 0
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
                                                              :rbeams 0
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
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
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
                                                                         :pitch 30
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
                                                              :rbeams 0
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
                                                              :rbeams 0
                                                              :lbeams 0
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
                                                              :notehead :HALF
                                                              :rbeams 0
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
                                                              :rbeams 0
                                                              :lbeams 0
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
                                                              :notehead :HALF
                                                              :rbeams 0
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
                                                              :rbeams 0
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
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
                                                                         :pitch 30
                                                                         :staff #2#
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
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
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
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
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
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
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
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
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
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
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
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :staff-pos 4 ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
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
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
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
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
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
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
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
                                                              :rbeams 0
                                                              :lbeams 0
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
                                                              :notehead :HALF
                                                              :rbeams 0
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
                                                              :rbeams 0
                                                              :lbeams 1
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
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
                                                                         :pitch 26
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
                                                                         :pitch 27
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
                                                                         :pitch 28
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
                                                                         :pitch 29
                                                                         :staff #2#
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
                                                                         :pitch 30
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
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
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #2#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
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
                                                              :notehead :HALF
                                                              :rbeams 0
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
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
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
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
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
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 25
                                                                         :staff #2#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :HALF
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
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #2#
                                                                         :head :HALF
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
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :HALF
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
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :HALF
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
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :WHOLE
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
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :WHOLE
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
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 26
                                                                         :staff #2#
                                                                         :head :HALF
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
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :HALF
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
                                                                         :staff #2#
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
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 1
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
                                                              :rbeams 0
                                                              :lbeams 0
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
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #2#
                                                                         :head :HALF
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
                                                                         :pitch 29
                                                                         :staff #2#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 27
                                                                         :staff #2#
                                                                         :head :HALF
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
                                                                         :pitch 28
                                                                         :staff #2#
                                                                         :head :HALF
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
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :WHOLE
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
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :WHOLE
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
                                                                         :pitch 33
                                                                         :staff #1#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 33
                                                                         :staff #1#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #1#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 33
                                                                         :staff #1#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 33
                                                                         :staff #1#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 33
                                                                         :staff #1#
                                                                         :head :WHOLE
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
                                                                         :pitch 33
                                                                         :staff #1#
                                                                         :head :WHOLE
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
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 35
                                                                         :staff #1#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
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
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :HALF
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
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :HALF
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
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :HALF
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
                                                              :notehead :HALF
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
                                                              :notehead :HALF
                                                              :rbeams 0
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
                                                              :notehead :HALF
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
                                                                         :pitch 33
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 33
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
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
                                                                         :pitch 31
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
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
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
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 33
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 33
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 36
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
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
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
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
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :FILLED
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
                                                                         :pitch 33
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 33
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #1#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #1#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #1#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #1#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #1#
                                                              :staff-pos 4 ]) ]
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
                                                              :notehead :HALF
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
                                                              :notehead :HALF
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
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
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
                                                                         :pitch 31
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
                                                                         :pitch 30
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
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
                                                              :lbeams 1
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
                                                              :notehead :HALF
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
                                                                         :pitch 33
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
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #1#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:REST
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :staff #1#
                                                              :staff-pos 4 ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
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
                                                              :notehead :HALF
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
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
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
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 29
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
                                                                         :pitch 28
                                                                         :staff #1#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :HALF
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
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #1#
                                                                         :head :HALF
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
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :HALF
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
                                                                         :pitch 30
                                                                         :staff #1#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 33
                                                                         :staff #1#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
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
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
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
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
                                                           [GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :HALF
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
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :WHOLE
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
                                                                         :pitch 30
                                                                         :staff #1#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #1#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :WHOLE
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 30
                                                                         :staff #1#
                                                                         :head :WHOLE
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
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :WHOLE
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
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :WHOLE
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :HALF
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
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
                                                                         :accidentals :SHARP
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
                                                                         :pitch 31
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :SHARP
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
                                                                         :pitch 32
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
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-right COMMON-LISP:T ]) ]) ]
                                             [GSHARP-BUFFER:MELODY-BAR
                                                :elements ([GSHARP-BUFFER:CLUSTER
                                                              :xoffset 0
                                                              :notehead :HALF
                                                              :rbeams 0
                                                              :lbeams 0
                                                              :dots 0
                                                              :stem-direction :AUTO
                                                              :notes ([GSHARP-BUFFER:NOTE
                                                                         :pitch 32
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0
                                                                         :tie-left COMMON-LISP:T ]) ]
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
                                                                         :pitch 30
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
                                                                         :pitch 29
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
                                                                         :pitch 30
                                                                         :staff #1#
                                                                         :head :FILLED
                                                                         :accidentals :NATURAL
                                                                         :dots 0 ]) ]) ]) ]
                             :tail [GSHARP-BUFFER:SLICE
                                      :bars ([GSHARP-BUFFER:MELODY-BAR
                                                :elements COMMON-LISP:NIL ]) ] ])
                 :tempo 32 ]) ]
