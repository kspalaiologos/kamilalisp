
(SDEFUN |FFCAT2;map;MF1F2;1| ((|f| (|Mapping| R2 R1)) (|f1| (F1)) ($ (F2)))
        (SPADCALL (SPADCALL |f| (SPADCALL |f1| (QREFELT $ 14)) (QREFELT $ 17))
                  (QREFELT $ 18))) 

(DECLAIM (NOTINLINE |FunctionFieldCategoryFunctions2;|)) 

(DEFUN |FunctionFieldCategoryFunctions2| (&REST #1=#:G691)
  (SPROG NIL
         (PROG (#2=#:G692)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FunctionFieldCategoryFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |FunctionFieldCategoryFunctions2;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|FunctionFieldCategoryFunctions2|)))))))))) 

(DEFUN |FunctionFieldCategoryFunctions2;|
       (|#1| |#2| |#3| |#4| |#5| |#6| |#7| |#8|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$8 NIL) (DV$7 NIL) (DV$6 NIL) (DV$5 NIL)
    (DV$4 NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT DV$6 (|devaluate| |#6|))
    (LETT DV$7 (|devaluate| |#7|))
    (LETT DV$8 (|devaluate| |#8|))
    (LETT |dv$|
          (LIST '|FunctionFieldCategoryFunctions2| DV$1 DV$2 DV$3 DV$4 DV$5
                DV$6 DV$7 DV$8))
    (LETT $ (GETREFV 20))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|FunctionFieldCategoryFunctions2|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5 DV$6 DV$7 DV$8) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (QSETREFV $ 11 |#6|)
    (QSETREFV $ 12 |#7|)
    (QSETREFV $ 13 |#8|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|FunctionFieldCategoryFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (|local| |#6|)
              (|local| |#7|) (|local| |#8|) (0 . |lift|) (|Mapping| 10 6)
              (|MultipleMap| 6 7 8 10 11 12) (5 . |map|) (11 . |reduce|)
              |FFCAT2;map;MF1F2;1|)
           '#(|map| 16) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map| (|#8| (|Mapping| |#5| |#1|) |#4|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 19
                                            '(1 9 8 0 14 2 16 12 15 8 17 1 13 0
                                              12 18 2 0 13 15 9 19)))))
           '|lookupComplete|)) 
