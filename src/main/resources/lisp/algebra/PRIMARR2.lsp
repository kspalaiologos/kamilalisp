
(SDEFUN |PRIMARR2;map;MPaPa;1|
        ((|f| (|Mapping| B A)) (|v| (|PrimitiveArray| A))
         ($ (|PrimitiveArray| B)))
        (SPADCALL |f| |v| (QREFELT $ 12))) 

(SDEFUN |PRIMARR2;scan;MPaBPa;2|
        ((|f| (|Mapping| B A B)) (|v| (|PrimitiveArray| A)) (|b| (B))
         ($ (|PrimitiveArray| B)))
        (SPADCALL |f| |v| |b| (QREFELT $ 15))) 

(SDEFUN |PRIMARR2;reduce;MPa2B;3|
        ((|f| (|Mapping| B A B)) (|v| (|PrimitiveArray| A)) (|b| (B)) ($ (B)))
        (SPADCALL |f| |v| |b| (QREFELT $ 17))) 

(DECLAIM (NOTINLINE |PrimitiveArrayFunctions2;|)) 

(DEFUN |PrimitiveArrayFunctions2| (&REST #1=#:G697)
  (SPROG NIL
         (PROG (#2=#:G698)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PrimitiveArrayFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PrimitiveArrayFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|PrimitiveArrayFunctions2|)))))))))) 

(DEFUN |PrimitiveArrayFunctions2;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|PrimitiveArrayFunctions2| DV$1 DV$2))
          (LETT $ (GETREFV 19))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PrimitiveArrayFunctions2|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PrimitiveArrayFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|PrimitiveArray| 7) (|Mapping| 7 6) (|PrimitiveArray| 6)
              (|FiniteLinearAggregateFunctions2| 6 10 7 8) (0 . |map|)
              |PRIMARR2;map;MPaPa;1| (|Mapping| 7 6 7) (6 . |scan|)
              |PRIMARR2;scan;MPaBPa;2| (13 . |reduce|)
              |PRIMARR2;reduce;MPa2B;3|)
           '#(|scan| 20 |reduce| 27 |map| 34) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|scan|
                                 ((|PrimitiveArray| |#2|)
                                  (|Mapping| |#2| |#1| |#2|)
                                  (|PrimitiveArray| |#1|) |#2|))
                                T)
                              '((|reduce|
                                 (|#2| (|Mapping| |#2| |#1| |#2|)
                                  (|PrimitiveArray| |#1|) |#2|))
                                T)
                              '((|map|
                                 ((|PrimitiveArray| |#2|) (|Mapping| |#2| |#1|)
                                  (|PrimitiveArray| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 18
                                            '(2 11 8 9 10 12 3 11 8 14 10 7 15
                                              3 11 7 14 10 7 17 3 0 8 14 10 7
                                              16 3 0 7 14 10 7 18 2 0 8 9 10
                                              13)))))
           '|lookupComplete|)) 
