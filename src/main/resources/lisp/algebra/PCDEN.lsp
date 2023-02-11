
(SDEFUN |PCDEN;commonDenominator;PR;1| ((|p| (P)) ($ (R)))
        (SPADCALL (SPADCALL |p| (QREFELT $ 12)) (QREFELT $ 14))) 

(SDEFUN |PCDEN;clearDenominator;2P;2| ((|p| (P)) ($ (P)))
        (SPROG ((|d| (R)))
               (SEQ (LETT |d| (SPADCALL |p| (QREFELT $ 15)))
                    (EXIT
                     (SPADCALL
                      (CONS #'|PCDEN;clearDenominator;2P;2!0| (VECTOR $ |d|))
                      |p| (QREFELT $ 20)))))) 

(SDEFUN |PCDEN;clearDenominator;2P;2!0| ((|x| NIL) ($$ NIL))
        (PROG (|d| $)
          (LETT |d| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL (SPADCALL |d| |x| (QREFELT $ 16)) (QREFELT $ 17))
             (QREFELT $ 18)))))) 

(SDEFUN |PCDEN;splitDenominator;PR;3|
        ((|p| (P)) ($ (|Record| (|:| |num| P) (|:| |den| R))))
        (SPROG ((|d| (R)))
               (SEQ (LETT |d| (SPADCALL |p| (QREFELT $ 15)))
                    (EXIT
                     (CONS
                      (SPADCALL
                       (CONS #'|PCDEN;splitDenominator;PR;3!0| (VECTOR $ |d|))
                       |p| (QREFELT $ 20))
                      |d|))))) 

(SDEFUN |PCDEN;splitDenominator;PR;3!0| ((|x| NIL) ($$ NIL))
        (PROG (|d| $)
          (LETT |d| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL (SPADCALL |d| |x| (QREFELT $ 16)) (QREFELT $ 17))
             (QREFELT $ 18)))))) 

(DECLAIM (NOTINLINE |PolynomialCommonDenominator;|)) 

(DEFUN |PolynomialCommonDenominator| (&REST #1=#:G702)
  (SPROG NIL
         (PROG (#2=#:G703)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PolynomialCommonDenominator|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |PolynomialCommonDenominator;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|PolynomialCommonDenominator|)))))))))) 

(DEFUN |PolynomialCommonDenominator;| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT |dv$| (LIST '|PolynomialCommonDenominator| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 24))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|PolynomialCommonDenominator|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|PolynomialCommonDenominator| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (|List| 7)
              (0 . |coefficients|) (|CommonDenominator| 6 7 11)
              (5 . |commonDenominator|) |PCDEN;commonDenominator;PR;1| (10 . *)
              (16 . |numer|) (21 . |coerce|) (|Mapping| 7 7) (26 . |map|)
              |PCDEN;clearDenominator;2P;2|
              (|Record| (|:| |num| 10) (|:| |den| 6))
              |PCDEN;splitDenominator;PR;3|)
           '#(|splitDenominator| 32 |commonDenominator| 37 |clearDenominator|
              42)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|commonDenominator| (|#1| |#5|)) T)
                                   '((|clearDenominator| (|#5| |#5|)) T)
                                   '((|splitDenominator|
                                      ((|Record| (|:| |num| |#5|)
                                                 (|:| |den| |#1|))
                                       |#5|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 23
                                            '(1 10 11 0 12 1 13 6 11 14 2 7 0 6
                                              0 16 1 7 6 0 17 1 7 0 6 18 2 10 0
                                              19 0 20 1 0 22 10 23 1 0 6 10 15
                                              1 0 10 10 21)))))
           '|lookupComplete|)) 
