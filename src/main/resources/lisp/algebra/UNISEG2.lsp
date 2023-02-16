
(SDEFUN |UNISEG2;map;MUsUs;1|
        ((|f| (|Mapping| S R)) (|u| (|UniversalSegment| R))
         ($ (|UniversalSegment| S)))
        (SPROG ((|s| (S)))
               (SEQ (LETT |s| (SPADCALL (SPADCALL |u| (QREFELT $ 9)) |f|))
                    (EXIT
                     (COND
                      ((SPADCALL |u| (QREFELT $ 11))
                       (SPADCALL |s|
                                 (SPADCALL (SPADCALL |u| (QREFELT $ 12)) |f|)
                                 (QREFELT $ 14)))
                      ('T (SPADCALL |s| (QREFELT $ 15)))))))) 

(SDEFUN |UNISEG2;map;MUsS;2|
        ((|f| (|Mapping| S R)) (|u| (|UniversalSegment| R)) ($ (|Stream| S)))
        (SPADCALL |f| (SPADCALL |u| (QREFELT $ 19)) (QREFELT $ 22))) 

(DECLAIM (NOTINLINE |UniversalSegmentFunctions2;|)) 

(DEFUN |UniversalSegmentFunctions2| (&REST #1=#:G695)
  (SPROG NIL
         (PROG (#2=#:G696)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|UniversalSegmentFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |UniversalSegmentFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|UniversalSegmentFunctions2|)))))))))) 

(DEFUN |UniversalSegmentFunctions2;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|UniversalSegmentFunctions2| DV$1 DV$2))
          (LETT $ (GETREFV 24))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|OrderedRing|))))))
          (|haddProp| |$ConstructorCache| '|UniversalSegmentFunctions2|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 1)
            (QSETREFV $ 23
                      (CONS (|dispatchFunction| |UNISEG2;map;MUsS;2|) $))))
          $))) 

(MAKEPROP '|UniversalSegmentFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|UniversalSegment| 6) (0 . |low|) (|Boolean|) (5 . |hasHi|)
              (10 . |high|) (|UniversalSegment| 7) (15 . |segment|)
              (21 . |segment|) (|Mapping| 7 6) |UNISEG2;map;MUsUs;1|
              (|Stream| 6) (26 . |expand|) (|Stream| 7)
              (|StreamFunctions2| 6 7) (31 . |map|) (37 . |map|))
           '#(|map| 43) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|UniversalSegment| |#2|)
                                  (|Mapping| |#2| |#1|)
                                  (|UniversalSegment| |#1|)))
                                T)
                              '((|map|
                                 ((|Stream| |#2|) (|Mapping| |#2| |#1|)
                                  (|UniversalSegment| |#1|)))
                                (|has| 6 (|OrderedRing|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 23
                                            '(1 8 6 0 9 1 8 10 0 11 1 8 6 0 12
                                              2 13 0 7 7 14 1 13 0 7 15 1 8 18
                                              0 19 2 21 20 16 18 22 2 0 20 16 8
                                              23 2 1 20 16 8 23 2 0 13 16 8
                                              17)))))
           '|lookupComplete|)) 
