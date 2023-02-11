
(SDEFUN |PATRES2;map;MPmrPmr;1|
        ((|f| (|Mapping| B A)) (|r| (|PatternMatchResult| R A))
         ($ (|PatternMatchResult| R B)))
        (SPROG ((#1=#:G702 NIL) (|rec| NIL) (#2=#:G701 NIL))
               (SEQ
                (COND ((SPADCALL |r| (QREFELT $ 11)) (SPADCALL (QREFELT $ 13)))
                      ('T
                       (SPADCALL
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |rec| NIL)
                              (LETT #1# (SPADCALL |r| (QREFELT $ 16))) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |rec| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2#
                                      (CONS
                                       (CONS (QCAR |rec|)
                                             (SPADCALL (QCDR |rec|) |f|))
                                       #2#))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#))))
                        (QREFELT $ 19))))))) 

(DECLAIM (NOTINLINE |PatternMatchResultFunctions2;|)) 

(DEFUN |PatternMatchResultFunctions2| (&REST #1=#:G703)
  (SPROG NIL
         (PROG (#2=#:G704)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PatternMatchResultFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |PatternMatchResultFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|PatternMatchResultFunctions2|)))))))))) 

(DEFUN |PatternMatchResultFunctions2;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|PatternMatchResultFunctions2| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 22))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PatternMatchResultFunctions2|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PatternMatchResultFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Boolean|) (|PatternMatchResult| 6 7)
              (0 . |failed?|) (|PatternMatchResult| 6 8) (5 . |failed|)
              (|Record| (|:| |key| (|Symbol|)) (|:| |entry| 7)) (|List| 14)
              (9 . |destruct|)
              (|Record| (|:| |key| (|Symbol|)) (|:| |entry| 8)) (|List| 17)
              (14 . |construct|) (|Mapping| 8 7) |PATRES2;map;MPmrPmr;1|)
           '#(|map| 19) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|PatternMatchResult| |#1| |#3|)
                                  (|Mapping| |#3| |#2|)
                                  (|PatternMatchResult| |#1| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 21
                                            '(1 10 9 0 11 0 12 0 13 1 10 15 0
                                              16 1 12 0 18 19 2 0 12 20 10
                                              21)))))
           '|lookupComplete|)) 
