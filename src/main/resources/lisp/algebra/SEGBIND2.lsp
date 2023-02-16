
(SDEFUN |SEGBIND2;map;MSbSb;1|
        ((|f| (|Mapping| S R)) (|b| (|SegmentBinding| R))
         ($ (|SegmentBinding| S)))
        (SPADCALL (SPADCALL |b| (QREFELT $ 10))
                  (SPADCALL |f| (SPADCALL |b| (QREFELT $ 12)) (QREFELT $ 16))
                  (QREFELT $ 18))) 

(DECLAIM (NOTINLINE |SegmentBindingFunctions2;|)) 

(DEFUN |SegmentBindingFunctions2| (&REST #1=#:G691)
  (SPROG NIL
         (PROG (#2=#:G692)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|SegmentBindingFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |SegmentBindingFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|SegmentBindingFunctions2|)))))))))) 

(DEFUN |SegmentBindingFunctions2;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|SegmentBindingFunctions2| DV$1 DV$2))
          (LETT $ (GETREFV 20))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|SegmentBindingFunctions2|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|SegmentBindingFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Symbol|)
              (|SegmentBinding| 6) (0 . |variable|) (|Segment| 6)
              (5 . |segment|) (|Segment| 7) (|Mapping| 7 6)
              (|SegmentFunctions2| 6 7) (10 . |map|) (|SegmentBinding| 7)
              (16 . |equation|) |SEGBIND2;map;MSbSb;1|)
           '#(|map| 22) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|SegmentBinding| |#2|) (|Mapping| |#2| |#1|)
                                  (|SegmentBinding| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 19
                                            '(1 9 8 0 10 1 9 11 0 12 2 15 13 14
                                              11 16 2 17 0 8 13 18 2 0 17 14 9
                                              19)))))
           '|lookupComplete|)) 
