
(SDEFUN |UTS2;map;MUTS1UTS2;1|
        ((|f| (|Mapping| |Coef2| |Coef1|)) (|uts| (UTS1)) ($ (UTS2)))
        (SPADCALL (SPADCALL |f| (SPADCALL |uts| (QREFELT $ 11)) (QREFELT $ 15))
                  (QREFELT $ 16))) 

(DECLAIM (NOTINLINE |UnivariateTaylorSeriesFunctions2;|)) 

(DEFUN |UnivariateTaylorSeriesFunctions2| (&REST #1=#:G691)
  (SPROG NIL
         (PROG (#2=#:G692)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|UnivariateTaylorSeriesFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |UnivariateTaylorSeriesFunctions2;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|UnivariateTaylorSeriesFunctions2|)))))))))) 

(DEFUN |UnivariateTaylorSeriesFunctions2;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|UnivariateTaylorSeriesFunctions2| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 18))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|UnivariateTaylorSeriesFunctions2|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|UnivariateTaylorSeriesFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|Stream| 6) (0 . |coefficients|)
              (|Stream| 7) (|Mapping| 7 6) (|StreamFunctions2| 6 7) (5 . |map|)
              (11 . |series|) |UTS2;map;MUTS1UTS2;1|)
           '#(|map| 16) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map| (|#4| (|Mapping| |#2| |#1|) |#3|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 17
                                            '(1 8 10 0 11 2 14 12 13 10 15 1 9
                                              0 12 16 2 0 9 13 8 17)))))
           '|lookupComplete|)) 
