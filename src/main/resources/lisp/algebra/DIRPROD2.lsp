
(SDEFUN |DIRPROD2;map;MDpDp;1|
        ((|f| (|Mapping| B A)) (|v| (|DirectProduct| |dim| A))
         ($ (|DirectProduct| |dim| B)))
        (SPADCALL (SPADCALL |f| (SPADCALL |v| (QREFELT $ 11)) (QREFELT $ 15))
                  (QREFELT $ 17))) 

(SDEFUN |DIRPROD2;scan;MDpBDp;2|
        ((|f| (|Mapping| B A B)) (|v| (|DirectProduct| |dim| A)) (|b| (B))
         ($ (|DirectProduct| |dim| B)))
        (SPADCALL
         (SPADCALL |f| (SPADCALL |v| (QREFELT $ 11)) |b| (QREFELT $ 20))
         (QREFELT $ 17))) 

(SDEFUN |DIRPROD2;reduce;MDp2B;3|
        ((|f| (|Mapping| B A B)) (|v| (|DirectProduct| |dim| A)) (|b| (B))
         ($ (B)))
        (SPADCALL |f| (SPADCALL |v| (QREFELT $ 11)) |b| (QREFELT $ 22))) 

(DECLAIM (NOTINLINE |DirectProductFunctions2;|)) 

(DEFUN |DirectProductFunctions2| (&REST #1=#:G702)
  (SPROG NIL
         (PROG (#2=#:G703)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(NIL T T))
                                               (HGET |$ConstructorCache|
                                                     '|DirectProductFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |DirectProductFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|DirectProductFunctions2|)))))))))) 

(DEFUN |DirectProductFunctions2;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|DirectProductFunctions2| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 24))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|DirectProductFunctions2|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|DirectProductFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Vector| 7)
              (|DirectProduct| (NRTEVAL (QREFELT $ 6)) 7) (0 . |coerce|)
              (|Vector| 8) (|Mapping| 8 7)
              (|FiniteLinearAggregateFunctions2| 7 9 8 12) (5 . |map|)
              (|DirectProduct| (NRTEVAL (QREFELT $ 6)) 8)
              (11 . |directProduct|) |DIRPROD2;map;MDpDp;1| (|Mapping| 8 7 8)
              (16 . |scan|) |DIRPROD2;scan;MDpBDp;2| (23 . |reduce|)
              |DIRPROD2;reduce;MDp2B;3|)
           '#(|scan| 30 |reduce| 37 |map| 44) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|scan|
                                 ((|DirectProduct| |#1| |#3|)
                                  (|Mapping| |#3| |#2| |#3|)
                                  (|DirectProduct| |#1| |#2|) |#3|))
                                T)
                              '((|reduce|
                                 (|#3| (|Mapping| |#3| |#2| |#3|)
                                  (|DirectProduct| |#1| |#2|) |#3|))
                                T)
                              '((|map|
                                 ((|DirectProduct| |#1| |#3|)
                                  (|Mapping| |#3| |#2|)
                                  (|DirectProduct| |#1| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 23
                                            '(1 10 9 0 11 2 14 12 13 9 15 1 16
                                              0 12 17 3 14 12 19 9 8 20 3 14 8
                                              19 9 8 22 3 0 16 19 10 8 21 3 0 8
                                              19 10 8 23 2 0 16 13 10 18)))))
           '|lookupComplete|)) 
