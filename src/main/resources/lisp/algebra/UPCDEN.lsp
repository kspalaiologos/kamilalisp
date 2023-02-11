
(DECLAIM (NOTINLINE |UnivariatePolynomialCommonDenominator;|)) 

(DEFUN |UnivariatePolynomialCommonDenominator| (&REST #1=#:G691)
  (SPROG NIL
         (PROG (#2=#:G692)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|UnivariatePolynomialCommonDenominator|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |UnivariatePolynomialCommonDenominator;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|UnivariatePolynomialCommonDenominator|)))))))))) 

(DEFUN |UnivariatePolynomialCommonDenominator;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$|
                (LIST '|UnivariatePolynomialCommonDenominator| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 10))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|UnivariatePolynomialCommonDenominator|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|UnivariatePolynomialCommonDenominator| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL
              (|PolynomialCommonDenominator| 6 7 (|NonNegativeInteger|)
                                             (|SingletonAsOrderedSet|) 8)
              (|local| |#1|) (|local| |#2|) (|local| |#3|)
              (|Record| (|:| |num| 8) (|:| |den| 6)))
           '#() 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|commonDenominator| (|#1| |#3|)) T)
                                   '((|clearDenominator| (|#3| |#3|)) T)
                                   '((|splitDenominator|
                                      ((|Record| (|:| |num| |#3|)
                                                 (|:| |den| |#1|))
                                       |#3|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| -999999 'NIL))))
           '|lookupIncomplete|)) 
