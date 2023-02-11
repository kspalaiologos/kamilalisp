
(SDEFUN |NREP;characteristicPolynomial;MP;1|
        ((|m| (|Matrix| (|Fraction| (|Integer|))))
         ($ (|Polynomial| (|Fraction| (|Integer|)))))
        (SPROG ((|x| (|Symbol|)))
               (SEQ (LETT |x| (SPADCALL (QREFELT $ 8)))
                    (EXIT
                     (SPADCALL (SPADCALL |m| (QREFELT $ 12)) |x|
                               (QREFELT $ 14)))))) 

(SDEFUN |NREP;characteristicPolynomial;MSP;2|
        ((A (|Matrix| (|Fraction| (|Integer|)))) (|x| (|Symbol|))
         ($ (|Polynomial| (|Fraction| (|Integer|)))))
        (SPADCALL (SPADCALL A (QREFELT $ 12)) |x| (QREFELT $ 14))) 

(SDEFUN |NREP;realEigenvalues;MParL;3|
        ((|m| (|Matrix| (|Fraction| (|Integer|)))) (|eps| (|Par|))
         ($ (|List| |Par|)))
        (SPADCALL (SPADCALL |m| (QREFELT $ 12)) |eps| (QREFELT $ 18))) 

(SDEFUN |NREP;realEigenvectors;MParL;4|
        ((|m| (|Matrix| (|Fraction| (|Integer|)))) (|eps| (|Par|))
         ($
          (|List|
           (|Record| (|:| |outval| |Par|) (|:| |outmult| (|Integer|))
                     (|:| |outvect| (|List| (|Matrix| |Par|)))))))
        (SPADCALL |m| |eps| (ELT $ 23) (QREFELT $ 27))) 

(DECLAIM (NOTINLINE |NumericRealEigenPackage;|)) 

(DEFUN |NumericRealEigenPackage| (#1=#:G728)
  (SPROG NIL
         (PROG (#2=#:G729)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|NumericRealEigenPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|NumericRealEigenPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|NumericRealEigenPackage|)))))))))) 

(DEFUN |NumericRealEigenPackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|NumericRealEigenPackage| DV$1))
          (LETT $ (GETREFV 29))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|NumericRealEigenPackage|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|NumericRealEigenPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Symbol|) (0 . |new|)
              (|SparseUnivariatePolynomial| 22) (|Matrix| 22)
              (|InnerNumericEigenPackage| 22 6 6) (4 . |charpol|)
              (|Polynomial| 22) (9 . |multivariate|)
              |NREP;characteristicPolynomial;MP;1|
              |NREP;characteristicPolynomial;MSP;2| (|List| 6) (15 . |solve1|)
              |NREP;realEigenvalues;MParL;3| (|Factored| 21)
              (|SparseUnivariatePolynomial| $) (|Fraction| (|Integer|))
              (21 . |factorPolynomial|)
              (|Record| (|:| |outval| 6) (|:| |outmult| (|Integer|))
                        (|:| |outvect| (|List| (|Matrix| 6))))
              (|List| 24) (|Mapping| (|Factored| 9) 9)
              (26 . |innerEigenvectors|) |NREP;realEigenvectors;MParL;4|)
           '#(|realEigenvectors| 33 |realEigenvalues| 39
              |characteristicPolynomial| 45)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|characteristicPolynomial|
                                 ((|Polynomial| (|Fraction| (|Integer|)))
                                  (|Matrix| (|Fraction| (|Integer|)))))
                                T)
                              '((|characteristicPolynomial|
                                 ((|Polynomial| (|Fraction| (|Integer|)))
                                  (|Matrix| (|Fraction| (|Integer|)))
                                  (|Symbol|)))
                                T)
                              '((|realEigenvalues|
                                 ((|List| |#1|)
                                  (|Matrix| (|Fraction| (|Integer|))) |#1|))
                                T)
                              '((|realEigenvectors|
                                 ((|List|
                                   (|Record| (|:| |outval| |#1|)
                                             (|:| |outmult| (|Integer|))
                                             (|:| |outvect|
                                                  (|List| (|Matrix| |#1|)))))
                                  (|Matrix| (|Fraction| (|Integer|))) |#1|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 28
                                            '(0 7 0 8 1 11 9 10 12 2 13 0 9 7
                                              14 2 11 17 9 6 18 1 22 20 21 23 3
                                              11 25 10 6 26 27 2 0 25 10 6 28 2
                                              0 17 10 6 19 2 0 13 10 7 16 1 0
                                              13 10 15)))))
           '|lookupComplete|)) 
