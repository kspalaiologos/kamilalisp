
(SDEFUN |GENMFACT;factor;PF;1| ((|p| (P)) ($ (|Factored| P)))
        (SEQ
         (COND
          ((|HasCategory| (QREFELT $ 9) '(|FiniteFieldCategory|))
           (SPADCALL |p| (QREFELT $ 13)))
          (#1='T
           (SEQ
            (COND
             ((|domainEqual| (QREFELT $ 9) (|Polynomial| (QREFELT $ 8)))
              (COND
               ((|HasCategory| (QREFELT $ 8) '(|EuclideanDomain|))
                (EXIT (SPADCALL |p| (QREFELT $ 15)))))))
            (COND
             ((|domainEqual| (QREFELT $ 9) (|Fraction| (QREFELT $ 8)))
              (COND
               ((|HasCategory| (QREFELT $ 8) '(|CharacteristicZero|))
                (COND
                 ((|HasCategory| (QREFELT $ 8) '(|EuclideanDomain|))
                  (COND
                   ((|HasCategory| (QREFELT $ 8)
                                   '(|PolynomialFactorizationExplicit|))
                    (EXIT (SPADCALL |p| (QREFELT $ 17)))))))))))
            (EXIT
             (COND
              ((|domainEqual| (QREFELT $ 9)
                              (|Fraction| (|Polynomial| (QREFELT $ 8))))
               (SPADCALL |p| (QREFELT $ 19)))
              (#1#
               (SEQ
                (COND
                 ((|HasCategory| (QREFELT $ 9) '(|CharacteristicZero|))
                  (COND
                   ((|HasCategory| (QREFELT $ 9) '(|EuclideanDomain|))
                    (COND
                     ((|HasCategory| (QREFELT $ 9)
                                     '(|PolynomialFactorizationExplicit|))
                      (EXIT (SPADCALL |p| (QREFELT $ 21)))))))))
                (EXIT
                 (|error| "factor for this domain is unimplemented"))))))))))) 

(DECLAIM (NOTINLINE |GeneralizedMultivariateFactorize;|)) 

(DEFUN |GeneralizedMultivariateFactorize| (&REST #1=#:G708)
  (SPROG NIL
         (PROG (#2=#:G709)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|GeneralizedMultivariateFactorize|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |GeneralizedMultivariateFactorize;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|GeneralizedMultivariateFactorize|)))))))))) 

(DEFUN |GeneralizedMultivariateFactorize;| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT |dv$|
          (LIST '|GeneralizedMultivariateFactorize| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 23))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|GeneralizedMultivariateFactorize|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|GeneralizedMultivariateFactorize| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (|Factored| 10)
              (|MultFiniteFactorize| 6 7 9 10) (0 . |factor|)
              (|MPolyCatPolyFactorizer| 7 6 8 10) (5 . |factor|)
              (|MRationalFactorize| 7 6 8 10) (10 . |factor|)
              (|MPolyCatRationalFunctionFactorizer| 7 6 8 10) (15 . |factor|)
              (|MultivariateFactorize| 6 7 9 10) (20 . |factor|)
              |GENMFACT;factor;PF;1|)
           '#(|factor| 25) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|factor| ((|Factored| |#5|) |#5|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 22
                                            '(1 12 11 10 13 1 14 11 10 15 1 16
                                              11 10 17 1 18 11 10 19 1 20 11 10
                                              21 1 0 11 10 22)))))
           '|lookupComplete|)) 
