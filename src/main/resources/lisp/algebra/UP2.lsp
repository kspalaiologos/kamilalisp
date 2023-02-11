
(SDEFUN |UP2;map;MUpUp;1|
        ((|f| (|Mapping| S R)) (|p| (|UnivariatePolynomial| |x| R))
         ($ (|UnivariatePolynomial| |y| S)))
        (SPADCALL |f| |p| (QREFELT $ 14))) 

(DECLAIM (NOTINLINE |UnivariatePolynomialFunctions2;|)) 

(DEFUN |UnivariatePolynomialFunctions2| (&REST #1=#:G697)
  (SPROG NIL
         (PROG (#2=#:G698)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(NIL T NIL T))
                     (HGET |$ConstructorCache|
                           '|UnivariatePolynomialFunctions2|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |UnivariatePolynomialFunctions2;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|UnivariatePolynomialFunctions2|)))))))))) 

(DEFUN |UnivariatePolynomialFunctions2;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 |#1|)
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 |#3|)
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|UnivariatePolynomialFunctions2| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 16))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|UnivariatePolynomialFunctions2|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|UnivariatePolynomialFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|)
              (|UnivariatePolynomial| (NRTEVAL (QREFELT $ 8)) 9)
              (|Mapping| 9 7)
              (|UnivariatePolynomial| (NRTEVAL (QREFELT $ 6)) 7)
              (|UnivariatePolynomialCategoryFunctions2| 7 12 9 10) (0 . |map|)
              |UP2;map;MUpUp;1|)
           '#(|map| 6) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|UnivariatePolynomial| |#3| |#4|)
                                  (|Mapping| |#4| |#2|)
                                  (|UnivariatePolynomial| |#1| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 15
                                            '(2 13 10 11 12 14 2 0 10 11 12
                                              15)))))
           '|lookupComplete|)) 
