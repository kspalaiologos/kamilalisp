
(SDEFUN |MCDEN;clearDenominator;MM;1| ((|m| (|Matrix| Q)) ($ (|Matrix| R)))
        (SPROG ((|d| (R)))
               (SEQ (LETT |d| (SPADCALL |m| (QREFELT $ 9)))
                    (EXIT
                     (SPADCALL
                      (CONS #'|MCDEN;clearDenominator;MM;1!0| (VECTOR $ |d|))
                      |m| (QREFELT $ 15)))))) 

(SDEFUN |MCDEN;clearDenominator;MM;1!0| ((|x| NIL) ($$ NIL))
        (PROG (|d| $)
          (LETT |d| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |d| |x| (QREFELT $ 10)) (QREFELT $ 11)))))) 

(SDEFUN |MCDEN;splitDenominator;MR;2|
        ((|m| (|Matrix| Q))
         ($ (|Record| (|:| |num| (|Matrix| R)) (|:| |den| R))))
        (SPROG ((|d| (R)))
               (SEQ (LETT |d| (SPADCALL |m| (QREFELT $ 9)))
                    (EXIT
                     (CONS
                      (SPADCALL
                       (CONS #'|MCDEN;splitDenominator;MR;2!0| (VECTOR $ |d|))
                       |m| (QREFELT $ 15))
                      |d|))))) 

(SDEFUN |MCDEN;splitDenominator;MR;2!0| ((|x| NIL) ($$ NIL))
        (PROG (|d| $)
          (LETT |d| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |d| |x| (QREFELT $ 10)) (QREFELT $ 11)))))) 

(SDEFUN |MCDEN;commonDenominator;MR;3| ((|m| (|Matrix| Q)) ($ (R)))
        (SPADCALL
         (SPADCALL (ELT $ 19) (SPADCALL |m| (QREFELT $ 21)) (QREFELT $ 24))
         (QREFELT $ 26))) 

(SDEFUN |MCDEN;commonDenominator;MR;4| ((|m| (|Matrix| Q)) ($ (R)))
        (SPADCALL (ELT $ 27)
                  (SPADCALL (ELT $ 19) (SPADCALL |m| (QREFELT $ 21))
                            (QREFELT $ 24))
                  (|spadConstant| $ 28) (QREFELT $ 30))) 

(DECLAIM (NOTINLINE |MatrixCommonDenominator;|)) 

(DEFUN |MatrixCommonDenominator| (&REST #1=#:G711)
  (SPROG NIL
         (PROG (#2=#:G712)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|MatrixCommonDenominator|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |MatrixCommonDenominator;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|MatrixCommonDenominator|)))))))))) 

(DEFUN |MatrixCommonDenominator;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|MatrixCommonDenominator| DV$1 DV$2))
          (LETT $ (GETREFV 31))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|MatrixCommonDenominator|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#1| '(|GcdDomain|))
            (QSETREFV $ 9
                      (CONS (|dispatchFunction| |MCDEN;commonDenominator;MR;3|)
                            $)))
           ('T
            (QSETREFV $ 9
                      (CONS (|dispatchFunction| |MCDEN;commonDenominator;MR;4|)
                            $))))
          $))) 

(MAKEPROP '|MatrixCommonDenominator| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Matrix| 7) (0 . |commonDenominator|) (5 . *) (11 . |numer|)
              (|Matrix| 6) (|Mapping| 6 7)
              (|MatrixCategoryFunctions2| 7 (|Vector| 7) (|Vector| 7) 8 6
                                          (|Vector| 6) (|Vector| 6) 12)
              (16 . |map|) |MCDEN;clearDenominator;MM;1|
              (|Record| (|:| |num| 12) (|:| |den| 6))
              |MCDEN;splitDenominator;MR;2| (22 . |denom|) (|List| 7)
              (27 . |parts|) (|List| 6) (|ListFunctions2| 7 6) (32 . |map|)
              (|List| $) (38 . |lcm|) (43 . *) (49 . |One|) (|Mapping| 6 6 6)
              (53 . |reduce|))
           '#(|splitDenominator| 60 |commonDenominator| 65 |clearDenominator|
              70)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|commonDenominator| (|#1| (|Matrix| |#2|))) T)
                              '((|clearDenominator|
                                 ((|Matrix| |#1|) (|Matrix| |#2|)))
                                T)
                              '((|splitDenominator|
                                 ((|Record| (|:| |num| (|Matrix| |#1|))
                                            (|:| |den| |#1|))
                                  (|Matrix| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 30
                                            '(1 0 6 8 9 2 7 0 6 0 10 1 7 6 0 11
                                              2 14 12 13 8 15 1 7 6 0 19 1 8 20
                                              0 21 2 23 22 13 20 24 1 6 0 25 26
                                              2 6 0 0 0 27 0 6 0 28 3 22 6 29 0
                                              6 30 1 0 17 8 18 1 0 6 8 9 1 0 12
                                              8 16)))))
           '|lookupComplete|)) 
