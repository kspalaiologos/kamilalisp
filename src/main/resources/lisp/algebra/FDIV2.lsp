
(SDEFUN |FDIV2;map;MFdFd;1|
        ((|f| (|Mapping| R2 R1)) (|d| (|FiniteDivisor| R1 UP1 UPUP1 F1))
         ($ (|FiniteDivisor| R2 UP2 UPUP2 F2)))
        (SPROG
         ((|rec|
           (|Record|
            (|:| |id| (|FractionalIdeal| UP1 (|Fraction| UP1) UPUP1 F1))
            (|:| |principalPart| F1))))
         (SEQ (LETT |rec| (SPADCALL |d| (QREFELT $ 16)))
              (EXIT
               (SPADCALL
                (SPADCALL (SPADCALL |f| (QCDR |rec|) (QREFELT $ 19))
                          (QREFELT $ 21))
                (SPADCALL
                 (SPADCALL (CONS #'|FDIV2;map;MFdFd;1!0| (VECTOR $ |f|))
                           (QCAR |rec|) (QREFELT $ 28))
                 (QREFELT $ 29))
                (QREFELT $ 30)))))) 

(SDEFUN |FDIV2;map;MFdFd;1!0| ((|s| NIL) ($$ NIL))
        (PROG (|f| $)
          (LETT |f| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |f| |s| (QREFELT $ 23)))))) 

(DECLAIM (NOTINLINE |FiniteDivisorFunctions2;|)) 

(DEFUN |FiniteDivisorFunctions2| (&REST #1=#:G728)
  (SPROG NIL
         (PROG (#2=#:G729)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FiniteDivisorFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FiniteDivisorFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FiniteDivisorFunctions2|)))))))))) 

(DEFUN |FiniteDivisorFunctions2;| (|#1| |#2| |#3| |#4| |#5| |#6| |#7| |#8|)
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
          (LIST '|FiniteDivisorFunctions2| DV$1 DV$2 DV$3 DV$4 DV$5 DV$6 DV$7
                DV$8))
    (LETT $ (GETREFV 32))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|FiniteDivisorFunctions2|
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

(MAKEPROP '|FiniteDivisorFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (|local| |#6|)
              (|local| |#7|) (|local| |#8|)
              (|Record| (|:| |id| 26) (|:| |principalPart| 9))
              (|FiniteDivisor| 6 7 8 9) (0 . |decompose|) (|Mapping| 10 6)
              (|FunctionFieldCategoryFunctions2| 6 7 8 9 10 11 12 13)
              (5 . |map|) (|FiniteDivisor| 10 11 12 13) (11 . |divisor|)
              (|UnivariatePolynomialCategoryFunctions2| 6 7 10 11) (16 . |map|)
              (|FractionalIdeal| 11 (|Fraction| 11) 12 13) (|Mapping| 11 7)
              (|FractionalIdeal| 7 (|Fraction| 7) 8 9)
              (|FractionalIdealFunctions2| 7 (|Fraction| 7) 8 9 11
                                           (|Fraction| 11) 12 13)
              (22 . |map|) (28 . |divisor|) (33 . +) |FDIV2;map;MFdFd;1|)
           '#(|map| 39) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|FiniteDivisor| |#5| |#6| |#7| |#8|)
                                  (|Mapping| |#5| |#1|)
                                  (|FiniteDivisor| |#1| |#2| |#3| |#4|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 31
                                            '(1 15 14 0 16 2 18 13 17 9 19 1 20
                                              0 13 21 2 22 11 17 7 23 2 27 24
                                              25 26 28 1 20 0 24 29 2 20 0 0 0
                                              30 2 0 20 17 15 31)))))
           '|lookupComplete|)) 
