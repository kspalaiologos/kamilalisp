
(SDEFUN |NCEP;characteristicPolynomial;MP;1|
        ((|m| (|Matrix| (|Complex| (|Fraction| (|Integer|)))))
         ($ (|Polynomial| (|Complex| (|Fraction| (|Integer|))))))
        (SPROG ((|x| (|Symbol|)))
               (SEQ (LETT |x| (SPADCALL (QREFELT $ 8)))
                    (EXIT
                     (SPADCALL (SPADCALL |m| (QREFELT $ 12)) |x|
                               (QREFELT $ 14)))))) 

(SDEFUN |NCEP;characteristicPolynomial;MSP;2|
        ((A (|Matrix| (|Complex| (|Fraction| (|Integer|))))) (|x| (|Symbol|))
         ($ (|Polynomial| (|Complex| (|Fraction| (|Integer|))))))
        (SPADCALL (SPADCALL A (QREFELT $ 12)) |x| (QREFELT $ 14))) 

(SDEFUN |NCEP;complexEigenvalues;MParL;3|
        ((|m| (|Matrix| (|Complex| (|Fraction| (|Integer|))))) (|eps| (|Par|))
         ($ (|List| (|Complex| |Par|))))
        (SPADCALL (SPADCALL |m| (QREFELT $ 12)) |eps| (QREFELT $ 18))) 

(SDEFUN |NCEP;complexEigenvectors;MParL;4|
        ((|m| (|Matrix| (|Complex| (|Fraction| (|Integer|))))) (|eps| (|Par|))
         ($
          (|List|
           (|Record| (|:| |outval| (|Complex| |Par|))
                     (|:| |outmult| (|Integer|))
                     (|:| |outvect| (|List| (|Matrix| (|Complex| |Par|))))))))
        (SPADCALL |m| |eps| (ELT $ 23) (QREFELT $ 27))) 

(DECLAIM (NOTINLINE |NumericComplexEigenPackage;|)) 

(DEFUN |NumericComplexEigenPackage| (#1=#:G733)
  (SPROG NIL
         (PROG (#2=#:G734)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|NumericComplexEigenPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|NumericComplexEigenPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|NumericComplexEigenPackage|)))))))))) 

(DEFUN |NumericComplexEigenPackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|NumericComplexEigenPackage| DV$1))
          (LETT $ (GETREFV 29))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|NumericComplexEigenPackage|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|NumericComplexEigenPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Symbol|) (0 . |new|)
              (|SparseUnivariatePolynomial| 22) (|Matrix| 22)
              (|InnerNumericEigenPackage| 22 (|Complex| 6) 6) (4 . |charpol|)
              (|Polynomial| 22) (9 . |multivariate|)
              |NCEP;characteristicPolynomial;MP;1|
              |NCEP;characteristicPolynomial;MSP;2| (|List| (|Complex| 6))
              (15 . |solve1|) |NCEP;complexEigenvalues;MParL;3| (|Factored| 21)
              (|SparseUnivariatePolynomial| $)
              (|Complex| (|Fraction| (|Integer|))) (21 . |factorPolynomial|)
              (|Record| (|:| |outval| (|Complex| 6))
                        (|:| |outmult| (|Integer|))
                        (|:| |outvect| (|List| (|Matrix| (|Complex| 6)))))
              (|List| 24) (|Mapping| (|Factored| 9) 9)
              (26 . |innerEigenvectors|) |NCEP;complexEigenvectors;MParL;4|)
           '#(|complexEigenvectors| 33 |complexEigenvalues| 39
              |characteristicPolynomial| 45)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|characteristicPolynomial|
                                 ((|Polynomial|
                                   (|Complex| (|Fraction| (|Integer|))))
                                  (|Matrix|
                                   (|Complex| (|Fraction| (|Integer|))))))
                                T)
                              '((|characteristicPolynomial|
                                 ((|Polynomial|
                                   (|Complex| (|Fraction| (|Integer|))))
                                  (|Matrix|
                                   (|Complex| (|Fraction| (|Integer|))))
                                  (|Symbol|)))
                                T)
                              '((|complexEigenvalues|
                                 ((|List| (|Complex| |#1|))
                                  (|Matrix|
                                   (|Complex| (|Fraction| (|Integer|))))
                                  |#1|))
                                T)
                              '((|complexEigenvectors|
                                 ((|List|
                                   (|Record| (|:| |outval| (|Complex| |#1|))
                                             (|:| |outmult| (|Integer|))
                                             (|:| |outvect|
                                                  (|List|
                                                   (|Matrix|
                                                    (|Complex| |#1|))))))
                                  (|Matrix|
                                   (|Complex| (|Fraction| (|Integer|))))
                                  |#1|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 28
                                            '(0 7 0 8 1 11 9 10 12 2 13 0 9 7
                                              14 2 11 17 9 6 18 1 22 20 21 23 3
                                              11 25 10 6 26 27 2 0 25 10 6 28 2
                                              0 17 10 6 19 2 0 13 10 7 16 1 0
                                              13 10 15)))))
           '|lookupComplete|)) 
