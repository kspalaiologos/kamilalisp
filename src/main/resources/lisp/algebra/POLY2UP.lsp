
(SDEFUN |POLY2UP;univariate;PVUp;1|
        ((|p| (|Polynomial| R)) (|y| (|Variable| |x|))
         ($ (|UnivariatePolynomial| |x| (|Polynomial| R))))
        (SPROG ((|q| (|SparseUnivariatePolynomial| (|Polynomial| R))))
               (SEQ (LETT |q| (SPADCALL |p| (QREFELT $ 6) (QREFELT $ 11)))
                    (EXIT
                     (SPADCALL (LIST #'|POLY2UP;univariate;PVUp;1!0|) |q|
                               (QREFELT $ 16)))))) 

(SDEFUN |POLY2UP;univariate;PVUp;1!0| ((|x1| NIL) ($$ NIL)) |x1|) 

(DECLAIM (NOTINLINE |PolynomialToUnivariatePolynomial;|)) 

(DEFUN |PolynomialToUnivariatePolynomial| (&REST #1=#:G702)
  (SPROG NIL
         (PROG (#2=#:G703)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(NIL T))
                                               (HGET |$ConstructorCache|
                                                     '|PolynomialToUnivariatePolynomial|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |PolynomialToUnivariatePolynomial;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|PolynomialToUnivariatePolynomial|)))))))))) 

(DEFUN |PolynomialToUnivariatePolynomial;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|PolynomialToUnivariatePolynomial| DV$1 DV$2))
          (LETT $ (GETREFV 19))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PolynomialToUnivariatePolynomial|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PolynomialToUnivariatePolynomial| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|SparseUnivariatePolynomial| $) (|Symbol|) (|Polynomial| 7)
              (0 . |univariate|)
              (|UnivariatePolynomial| (NRTEVAL (QREFELT $ 6)) 10)
              (|Mapping| 10 10) (|SparseUnivariatePolynomial| 10)
              (|UnivariatePolynomialCategoryFunctions2| 10 14 10 12)
              (6 . |map|) (|Variable| (NRTEVAL (QREFELT $ 6)))
              |POLY2UP;univariate;PVUp;1|)
           '#(|univariate| 12) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|univariate|
                                 ((|UnivariatePolynomial| |#1|
                                                          (|Polynomial| |#2|))
                                  (|Polynomial| |#2|) (|Variable| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 18
                                            '(2 10 8 0 9 11 2 15 12 13 14 16 2
                                              0 12 10 17 18)))))
           '|lookupComplete|)) 
