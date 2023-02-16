
(SDEFUN |MMAP;rfmap|
        ((|f| (|Mapping| R2 R1)) (|q| (|Fraction| UP1)) ($ (|Fraction| UP2)))
        (SPADCALL (SPADCALL |f| (SPADCALL |q| (QREFELT $ 13)) (QREFELT $ 16))
                  (SPADCALL |f| (SPADCALL |q| (QREFELT $ 17)) (QREFELT $ 16))
                  (QREFELT $ 19))) 

(SDEFUN |MMAP;map;MUPUP1UPUP2;2|
        ((|f| (|Mapping| R2 R1)) (|p| (UPUP1)) ($ (UPUP2)))
        (SPROG NIL
               (SPADCALL (CONS #'|MMAP;map;MUPUP1UPUP2;2!0| (VECTOR $ |f|)) |p|
                         (QREFELT $ 22)))) 

(SDEFUN |MMAP;map;MUPUP1UPUP2;2!0| ((|x| NIL) ($$ NIL))
        (PROG (|f| $)
          (LETT |f| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|MMAP;rfmap| |f| |x| $))))) 

(DECLAIM (NOTINLINE |MultipleMap;|)) 

(DEFUN |MultipleMap| (&REST #1=#:G699)
  (SPROG NIL
         (PROG (#2=#:G700)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|MultipleMap|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |MultipleMap;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|MultipleMap|)))))))))) 

(DEFUN |MultipleMap;| (|#1| |#2| |#3| |#4| |#5| |#6|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$6 NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL)
    (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT DV$6 (|devaluate| |#6|))
    (LETT |dv$| (LIST '|MultipleMap| DV$1 DV$2 DV$3 DV$4 DV$5 DV$6))
    (LETT $ (GETREFV 24))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|MultipleMap|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5 DV$6) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (QSETREFV $ 11 |#6|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|MultipleMap| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (|local| |#6|)
              (|Fraction| 7) (0 . |numer|) (|Mapping| 9 6)
              (|UnivariatePolynomialCategoryFunctions2| 6 7 9 10) (5 . |map|)
              (11 . |denom|) (|Fraction| 10) (16 . /) (|Mapping| 18 12)
              (|UnivariatePolynomialCategoryFunctions2| 12 8 18 11)
              (22 . |map|) |MMAP;map;MUPUP1UPUP2;2|)
           '#(|map| 28) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map| (|#6| (|Mapping| |#4| |#1|) |#3|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 23
                                            '(1 12 7 0 13 2 15 10 14 7 16 1 12
                                              7 0 17 2 18 0 10 10 19 2 21 11 20
                                              8 22 2 0 11 14 8 23)))))
           '|lookupComplete|)) 
