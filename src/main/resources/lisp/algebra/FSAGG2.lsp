
(SDEFUN |FSAGG2;map;MAB;1| ((|fn| (|Mapping| R S)) (|a| (A)) ($ (B)))
        (SPADCALL (SPADCALL |fn| (SPADCALL |a| (QREFELT $ 11)) (QREFELT $ 15))
                  (QREFELT $ 16))) 

(SDEFUN |FSAGG2;reduce;MA2R;2|
        ((|fn| (|Mapping| R S R)) (|a| (A)) (|ident| (R)) ($ (R)))
        (SPADCALL |fn| (SPADCALL |a| (QREFELT $ 11)) |ident| (QREFELT $ 19))) 

(SDEFUN |FSAGG2;scan;MARB;3|
        ((|fn| (|Mapping| R S R)) (|a| (A)) (|ident| (R)) ($ (B)))
        (SPADCALL
         (SPADCALL |fn| (SPADCALL |a| (QREFELT $ 11)) |ident| (QREFELT $ 21))
         (QREFELT $ 16))) 

(DECLAIM (NOTINLINE |FiniteSetAggregateFunctions2;|)) 

(DEFUN |FiniteSetAggregateFunctions2| (&REST #1=#:G701)
  (SPROG NIL
         (PROG (#2=#:G702)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FiniteSetAggregateFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |FiniteSetAggregateFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|FiniteSetAggregateFunctions2|)))))))))) 

(DEFUN |FiniteSetAggregateFunctions2;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|FiniteSetAggregateFunctions2| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 23))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|FiniteSetAggregateFunctions2|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|FiniteSetAggregateFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|List| 6) (0 . |parts|) (|List| 8)
              (|Mapping| 8 6) (|ListFunctions2| 6 8) (5 . |map|) (11 . |set|)
              |FSAGG2;map;MAB;1| (|Mapping| 8 6 8) (16 . |reduce|)
              |FSAGG2;reduce;MA2R;2| (23 . |scan|) |FSAGG2;scan;MARB;3|)
           '#(|scan| 30 |reduce| 37 |map| 44) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map| (|#4| (|Mapping| |#3| |#1|) |#2|)) T)
                              '((|reduce|
                                 (|#3| (|Mapping| |#3| |#1| |#3|) |#2| |#3|))
                                T)
                              '((|scan|
                                 (|#4| (|Mapping| |#3| |#1| |#3|) |#2| |#3|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 22
                                            '(1 7 10 0 11 2 14 12 13 10 15 1 9
                                              0 12 16 3 14 8 18 10 8 19 3 14 12
                                              18 10 8 21 3 0 9 18 7 8 22 3 0 8
                                              18 7 8 20 2 0 9 13 7 17)))))
           '|lookupComplete|)) 
