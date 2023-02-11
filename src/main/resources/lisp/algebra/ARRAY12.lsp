
(SDEFUN |ARRAY12;map;MOdaOda;1|
        ((|f| (|Mapping| B A)) (|v| (|OneDimensionalArray| A))
         ($ (|OneDimensionalArray| B)))
        (SPADCALL |f| |v| (QREFELT $ 12))) 

(SDEFUN |ARRAY12;scan;MOdaBOda;2|
        ((|f| (|Mapping| B A B)) (|v| (|OneDimensionalArray| A)) (|b| (B))
         ($ (|OneDimensionalArray| B)))
        (SPADCALL |f| |v| |b| (QREFELT $ 15))) 

(SDEFUN |ARRAY12;reduce;MOda2B;3|
        ((|f| (|Mapping| B A B)) (|v| (|OneDimensionalArray| A)) (|b| (B))
         ($ (B)))
        (SPADCALL |f| |v| |b| (QREFELT $ 17))) 

(DECLAIM (NOTINLINE |OneDimensionalArrayFunctions2;|)) 

(DEFUN |OneDimensionalArrayFunctions2| (&REST #1=#:G697)
  (SPROG NIL
         (PROG (#2=#:G698)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|OneDimensionalArrayFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |OneDimensionalArrayFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|OneDimensionalArrayFunctions2|)))))))))) 

(DEFUN |OneDimensionalArrayFunctions2;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|OneDimensionalArrayFunctions2| DV$1 DV$2))
          (LETT $ (GETREFV 19))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OneDimensionalArrayFunctions2|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|OneDimensionalArrayFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|OneDimensionalArray| 7) (|Mapping| 7 6)
              (|OneDimensionalArray| 6)
              (|FiniteLinearAggregateFunctions2| 6 10 7 8) (0 . |map|)
              |ARRAY12;map;MOdaOda;1| (|Mapping| 7 6 7) (6 . |scan|)
              |ARRAY12;scan;MOdaBOda;2| (13 . |reduce|)
              |ARRAY12;reduce;MOda2B;3|)
           '#(|scan| 20 |reduce| 27 |map| 34) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|scan|
                                 ((|OneDimensionalArray| |#2|)
                                  (|Mapping| |#2| |#1| |#2|)
                                  (|OneDimensionalArray| |#1|) |#2|))
                                T)
                              '((|reduce|
                                 (|#2| (|Mapping| |#2| |#1| |#2|)
                                  (|OneDimensionalArray| |#1|) |#2|))
                                T)
                              '((|map|
                                 ((|OneDimensionalArray| |#2|)
                                  (|Mapping| |#2| |#1|)
                                  (|OneDimensionalArray| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 18
                                            '(2 11 8 9 10 12 3 11 8 14 10 7 15
                                              3 11 7 14 10 7 17 3 0 8 14 10 7
                                              16 3 0 7 14 10 7 18 2 0 8 9 10
                                              13)))))
           '|lookupComplete|)) 
