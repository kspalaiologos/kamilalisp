
(SDEFUN |ICDEN;clearDenominator;BA;1| ((|l| (B)) ($ (A)))
        (SPROG ((|d| (R)))
               (SEQ (LETT |d| (SPADCALL |l| (QREFELT $ 10)))
                    (EXIT
                     (SPADCALL
                      (CONS #'|ICDEN;clearDenominator;BA;1!0| (VECTOR $ |d|))
                      |l| (QREFELT $ 16)))))) 

(SDEFUN |ICDEN;clearDenominator;BA;1!0| ((|x| NIL) ($$ NIL))
        (PROG (|d| $)
          (LETT |d| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |d| |x| (QREFELT $ 12)) (QREFELT $ 13)))))) 

(SDEFUN |ICDEN;splitDenominator;BR;2|
        ((|l| (B)) ($ (|Record| (|:| |num| A) (|:| |den| R))))
        (SPROG ((|d| (R)))
               (SEQ (LETT |d| (SPADCALL |l| (QREFELT $ 10)))
                    (EXIT
                     (CONS
                      (SPADCALL
                       (CONS #'|ICDEN;splitDenominator;BR;2!0| (VECTOR $ |d|))
                       |l| (QREFELT $ 16))
                      |d|))))) 

(SDEFUN |ICDEN;splitDenominator;BR;2!0| ((|x| NIL) ($$ NIL))
        (PROG (|d| $)
          (LETT |d| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |d| |x| (QREFELT $ 12)) (QREFELT $ 13)))))) 

(SDEFUN |ICDEN;commonDenominator;BR;3| ((|l| (B)) ($ (R)))
        (SPADCALL (ELT $ 20) (SPADCALL (ELT $ 21) |l| (QREFELT $ 16))
                  (|spadConstant| $ 22) (QREFELT $ 24))) 

(SDEFUN |ICDEN;commonDenominator;BR;4| ((|l| (B)) ($ (R)))
        (SPADCALL (ELT $ 11) (SPADCALL (ELT $ 21) |l| (QREFELT $ 16))
                  (|spadConstant| $ 22) (QREFELT $ 24))) 

(DECLAIM (NOTINLINE |InnerCommonDenominator;|)) 

(DEFUN |InnerCommonDenominator| (&REST #1=#:G716)
  (SPROG NIL
         (PROG (#2=#:G717)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|InnerCommonDenominator|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |InnerCommonDenominator;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|InnerCommonDenominator|)))))))))) 

(DEFUN |InnerCommonDenominator;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|InnerCommonDenominator| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 25))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|InnerCommonDenominator|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|HasCategory| |#1| '(|GcdDomain|))
      (QSETREFV $ 10
                (CONS (|dispatchFunction| |ICDEN;commonDenominator;BR;3|) $)))
     ('T
      (QSETREFV $ 10
                (CONS (|dispatchFunction| |ICDEN;commonDenominator;BR;4|) $))))
    $))) 

(MAKEPROP '|InnerCommonDenominator| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (0 . |commonDenominator|) (5 . *)
              (11 . *) (17 . |numer|) (|Mapping| 6 7)
              (|FiniteLinearAggregateFunctions2| 7 9 6 8) (22 . |map|)
              |ICDEN;clearDenominator;BA;1|
              (|Record| (|:| |num| 8) (|:| |den| 6))
              |ICDEN;splitDenominator;BR;2| (28 . |lcm|) (34 . |denom|)
              (39 . |One|) (|Mapping| 6 6 6) (43 . |reduce|))
           '#(|splitDenominator| 50 |commonDenominator| 55 |clearDenominator|
              60)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|commonDenominator| (|#1| |#4|)) T)
                                   '((|clearDenominator| (|#3| |#4|)) T)
                                   '((|splitDenominator|
                                      ((|Record| (|:| |num| |#3|)
                                                 (|:| |den| |#1|))
                                       |#4|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 24
                                            '(1 0 6 9 10 2 6 0 0 0 11 2 7 0 6 0
                                              12 1 7 6 0 13 2 15 8 14 9 16 2 6
                                              0 0 0 20 1 7 6 0 21 0 6 0 22 3 8
                                              6 23 0 6 24 1 0 18 9 19 1 0 6 9
                                              10 1 0 8 9 17)))))
           '|lookupComplete|)) 
