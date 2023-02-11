
(SDEFUN |PFECAT-;charthRoot;SU;1| ((|f| (S)) ($ (|Union| S "failed")))
        (SPROG ((|ans| (|Union| (|Vector| S) "failed")) (|m| (|Matrix| S)))
               (SEQ
                (COND
                 ((SPADCALL |f| (QREFELT $ 8)) (CONS 0 (|spadConstant| $ 9)))
                 (#1='T
                  (SEQ
                   (LETT |m|
                         (SPADCALL
                          (LIST
                           (LIST (|spadConstant| $ 10)
                                 (SPADCALL |f| (QREFELT $ 11))))
                          (QREFELT $ 14)))
                   (LETT |ans| (SPADCALL |m| (QREFELT $ 17)))
                   (EXIT
                    (COND ((QEQCAR |ans| 1) (CONS 1 "failed"))
                          (#1#
                           (SPADCALL (SPADCALL (QCDR |ans|) 1 (QREFELT $ 20))
                                     (SPADCALL (QCDR |ans|) 2 (QREFELT $ 20))
                                     (QREFELT $ 22))))))))))) 

(SDEFUN |PFECAT-;solveLinearPolynomialEquation;LSupU;2|
        ((|lf| (|List| (|SparseUnivariatePolynomial| S)))
         (|g| (|SparseUnivariatePolynomial| S))
         ($ (|Union| (|List| (|SparseUnivariatePolynomial| S)) "failed")))
        (SPADCALL |lf| |g| (QREFELT $ 27))) 

(SDEFUN |PFECAT-;solveLinearPolynomialEquation;LSupU;3|
        ((|lf| (|List| (|SparseUnivariatePolynomial| S)))
         (|g| (|SparseUnivariatePolynomial| S))
         ($ (|Union| (|List| (|SparseUnivariatePolynomial| S)) "failed")))
        (SPADCALL |lf| |g| (QREFELT $ 35))) 

(DECLAIM (NOTINLINE |PolynomialFactorizationExplicit&;|)) 

(DEFUN |PolynomialFactorizationExplicit&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|PolynomialFactorizationExplicit&| DV$1))
          (LETT $ (GETREFV 36))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|CharacteristicNonZero|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 1)
            (QSETREFV $ 23
                      (CONS (|dispatchFunction| |PFECAT-;charthRoot;SU;1|)
                            $))))
          (COND
           ((|HasCategory| |#1| '(|Field|))
            (QSETREFV $ 31
                      (CONS
                       (|dispatchFunction|
                        |PFECAT-;solveLinearPolynomialEquation;LSupU;2|)
                       $)))
           ('T
            (QSETREFV $ 31
                      (CONS
                       (|dispatchFunction|
                        |PFECAT-;solveLinearPolynomialEquation;LSupU;3|)
                       $))))
          $))) 

(MAKEPROP '|PolynomialFactorizationExplicit&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Boolean|) (0 . |zero?|)
              (5 . |Zero|) (9 . |One|) (13 . -) (|List| (|List| 6))
              (|Matrix| 6) (18 . |matrix|) (|Union| (|Vector| $) '"failed")
              (|Matrix| $) (23 . |conditionP|) (|Integer|) (|Vector| 6)
              (28 . |elt|) (|Union| $ '"failed") (34 . |exquo|)
              (40 . |charthRoot|) (|Union| 25 '"failed") (|List| $)
              (|SparseUnivariatePolynomial| 6) (45 . |multiEuclidean|)
              (|Union| 29 '#1="failed") (|List| 30)
              (|SparseUnivariatePolynomial| $)
              (51 . |solveLinearPolynomialEquation|) (|Union| 33 '"failed")
              (|List| 26) (|LinearPolynomialEquationByFractions| 6)
              (57 . |solveLinearPolynomialEquationByFractions|))
           '#(|solveLinearPolynomialEquation| 63 |charthRoot| 69) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|charthRoot| ((|Union| |#1| "failed") |#1|))
                                T)
                              '((|solveLinearPolynomialEquation|
                                 ((|Union|
                                   (|List| (|SparseUnivariatePolynomial| |#1|))
                                   #1#)
                                  (|List| (|SparseUnivariatePolynomial| |#1|))
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 35
                                            '(1 6 7 0 8 0 6 0 9 0 6 0 10 1 6 0
                                              0 11 1 13 0 12 14 1 6 15 16 17 2
                                              19 6 0 18 20 2 6 21 0 0 22 1 0 21
                                              0 23 2 26 24 25 0 27 2 0 28 29 30
                                              31 2 34 32 33 26 35 2 0 28 29 30
                                              31 1 0 21 0 23)))))
           '|lookupComplete|)) 
