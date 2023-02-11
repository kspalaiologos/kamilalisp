
(SDEFUN |PWFFINTB;reducedDiscriminant;UPR;1| ((|f| (UP)) ($ (R)))
        (SPROG
         ((|ans| (|Union| R "failed")) (|gg| (R)) (|denom| (R))
          (|cden| (|Record| (|:| |num| (|List| (|Fraction| R))) (|:| |den| R)))
          (|cc| (|List| (|Fraction| R)))
          (|ee|
           (|Record|
            (|:| |coef1| (|SparseUnivariatePolynomial| (|Fraction| R)))
            (|:| |coef2| (|SparseUnivariatePolynomial| (|Fraction| R)))
            (|:| |generator| (|SparseUnivariatePolynomial| (|Fraction| R)))))
          (|ff| (|SparseUnivariatePolynomial| (|Fraction| R))))
         (SEQ (LETT |ff| (SPADCALL (ELT $ 11) |f| (QREFELT $ 15)))
              (LETT |ee|
                    (SPADCALL |ff| (SPADCALL |ff| (QREFELT $ 16))
                              (QREFELT $ 18)))
              (LETT |cc|
                    (SPADCALL (SPADCALL (QVELT |ee| 0) (QREFELT $ 20))
                              (SPADCALL (QVELT |ee| 1) (QREFELT $ 20))
                              (QREFELT $ 21)))
              (LETT |cden| (SPADCALL |cc| (QREFELT $ 24)))
              (LETT |denom| (QCDR |cden|))
              (LETT |gg|
                    (SPADCALL
                     (SPADCALL (ELT $ 25) (QCAR |cden|) (QREFELT $ 29))
                     (QREFELT $ 31)))
              (LETT |ans| (SPADCALL |denom| |gg| (QREFELT $ 33)))
              (EXIT
               (COND
                ((QEQCAR |ans| 1)
                 (|error|
                  "PWFFINTB: error in reduced discriminant computation"))
                ('T (QCDR |ans|))))))) 

(SDEFUN |PWFFINTB;compLocalBasis|
        ((|poly| (UP)) (|prime| (R))
         ($
          (|Record| (|:| |basis| (|Matrix| R)) (|:| |basisDen| R)
                    (|:| |basisInv| (|Matrix| R)))))
        (SPROG
         ((|sae|
           (|Join| (|MonogenicAlgebra| R UP)
                   (CATEGORY |package|
                    (IF (|has| R (|Field|))
                        (IF (|has| R (|PolynomialFactorizationExplicit|))
                            (ATTRIBUTE (|PolynomialFactorizationExplicit|))
                            |noBranch|)
                        |noBranch|)))))
         (SEQ
          (LETT |sae|
                (|SimpleAlgebraicExtension| (QREFELT $ 7) (QREFELT $ 8)
                                            |poly|))
          (EXIT
           (SPADCALL |prime|
                     (|compiledLookupCheck| '|localIntegralBasis|
                                            (LIST
                                             (LIST '|Record|
                                                   (LIST '|:| '|basis|
                                                         (LIST '|Matrix|
                                                               (|devaluate|
                                                                (ELT $ 7))))
                                                   (LIST '|:| '|basisDen|
                                                         (|devaluate|
                                                          (ELT $ 7)))
                                                   (LIST '|:| '|basisInv|
                                                         (LIST '|Matrix|
                                                               (|devaluate|
                                                                (ELT $ 7)))))
                                             (|devaluate| (ELT $ 7)))
                                            (|WildFunctionFieldIntegralBasis|
                                             (ELT $ 6) (ELT $ 7) (ELT $ 8)
                                             |sae|))))))) 

(SDEFUN |PWFFINTB;compLocalBasisOverExt|
        ((|poly0| (UP)) (|prime0| (R)) (|irrPoly0| (UP))
         (|k| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |basis| (|Matrix| R)) (|:| |basisDen| R)
                    (|:| |basisInv| (|Matrix| R)))))
        (SPROG
         ((|bDen| (R)) (|p| (|Union| R #1="failed")) (|bInv| (|Matrix| R))
          (|bas| (|Union| (|Matrix| R) #2="failed")) (|b| (|Matrix| R))
          (|ib|
           (|Record| (|:| |basis| (|Matrix| (|SparseUnivariatePolynomial| E)))
                     (|:| |basisDen| (|SparseUnivariatePolynomial| E))
                     (|:| |basisInv|
                          (|Matrix| (|SparseUnivariatePolynomial| E)))))
          (|bs|
           (|List|
            (|Record| (|:| |basis| (|Matrix| (|SparseUnivariatePolynomial| E)))
                      (|:| |basisDen| (|SparseUnivariatePolynomial| E))
                      (|:| |basisInv|
                           (|Matrix| (|SparseUnivariatePolynomial| E))))))
          (|factorIb|
           (|Record| (|:| |basis| (|Matrix| (|SparseUnivariatePolynomial| E)))
                     (|:| |basisDen| (|SparseUnivariatePolynomial| E))
                     (|:| |basisInv|
                          (|Matrix| (|SparseUnivariatePolynomial| E)))))
          (FF
           (|Join|
            (|MonogenicAlgebra| #3=(|SparseUnivariatePolynomial| E)
                                (|SparseUnivariatePolynomial|
                                 (|SparseUnivariatePolynomial| E)))
            (CATEGORY |package|
             (IF (|has| #3# . #4=((|Field|)))
                 (IF (|has| #3# . #5=((|PolynomialFactorizationExplicit|)))
                     . #6=((ATTRIBUTE (|PolynomialFactorizationExplicit|))
                           |noBranch|))
                 . #7=(|noBranch|)))))
          (|psi1|
           (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| E)))
          (|henselFactors|
           #8=(|List|
               (|SparseUnivariatePolynomial|
                (|SparseUnivariatePolynomial| E))))
          (|henselInfo|
           (|Record| (|:| |plist| #8#)
                     (|:| |modulo| (|SparseUnivariatePolynomial| E))))
          (|deg| (|PositiveInteger|)) (#9=#:G755 NIL)
          (|primaries|
           (|List|
            (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| E))))
          (#10=#:G776 NIL) (|ff| NIL) (#11=#:G775 NIL)
          (|redFactors| (|List| (|SparseUnivariatePolynomial| |sae|)))
          (#12=#:G774 NIL) (|f| NIL) (#13=#:G773 NIL)
          (|factorListSAE|
           (|List|
            (|Record|
             (|:| |flag|
                  (|Union| #14="nil" #15="sqfr" #16="irred" #17="prime"))
             (|:| |factor| (|SparseUnivariatePolynomial| |sae|))
             (|:| |exponent| (|NonNegativeInteger|)))))
          (|redIrrPoly| (|SparseUnivariatePolynomial| |sae|))
          (|pp|
           #18=(|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| E)))
          (|sae|
           (|Join| (|MonogenicAlgebra| E (|SparseUnivariatePolynomial| E))
                   (CATEGORY |package|
                    (IF (|has| E . #4#)
                        (IF (|has| E . #5#)
                            . #6#)
                        . #7#))))
          (|prime| #19=(|SparseUnivariatePolynomial| E)) (|redDisc| #19#)
          (|redDisc0| (R)) (|poly| #18#)
          (E
           (|Join| (|MonogenicAlgebra| K (|SparseUnivariatePolynomial| K))
                   (CATEGORY |package|
                    (IF (|has| K . #4#)
                        (IF (|has| K . #5#)
                            . #6#)
                        . #7#))))
          (|irrPoly| (|SparseUnivariatePolynomial| K)) (#20=#:G736 NIL)
          (|r| #21=(|NonNegativeInteger|)) (|disc0| (R)) (|n| #21#))
         (SEQ (LETT |n| (SPADCALL |poly0| (QREFELT $ 36)))
              (LETT |disc0| (SPADCALL |poly0| (QREFELT $ 37)))
              (EXIT
               (COND
                ((QEQCAR (SPADCALL |disc0| |prime0| (QREFELT $ 33)) 1)
                 (VECTOR (SPADCALL |n| (|spadConstant| $ 39) (QREFELT $ 41))
                         (|spadConstant| $ 39)
                         (SPADCALL |n| (|spadConstant| $ 39) (QREFELT $ 41))))
                (#22='T
                 (SEQ (LETT |r| (SPADCALL |irrPoly0| (QREFELT $ 36)))
                      (LETT |irrPoly|
                            (SPADCALL
                             (PROG1 (LETT #20# |r|)
                               (|check_subtype2| (> #20# 0)
                                                 '(|PositiveInteger|)
                                                 '(|NonNegativeInteger|) #20#))
                             (QREFELT $ 45)))
                      (LETT E
                            (|SimpleAlgebraicExtension| (QREFELT $ 6)
                                                        (|SparseUnivariatePolynomial|
                                                         (QREFELT $ 6))
                                                        |irrPoly|))
                      (LETT |poly|
                            (SPADCALL
                             (|compiledLookupCheck| '|coerce|
                                                    (LIST '$
                                                          (|devaluate|
                                                           (ELT $ 6)))
                                                    E)
                             |poly0|
                             (|compiledLookupCheck| '|mapBivariate|
                                                    (LIST
                                                     (LIST
                                                      '|SparseUnivariatePolynomial|
                                                      (LIST
                                                       '|SparseUnivariatePolynomial|
                                                       (|devaluate| E)))
                                                     (LIST '|Mapping|
                                                           (|devaluate| E)
                                                           (|devaluate|
                                                            (ELT $ 6)))
                                                     (|devaluate| (ELT $ 8)))
                                                    (|IntegralBasisPolynomialTools|
                                                     (ELT $ 6) (ELT $ 7)
                                                     (ELT $ 8) E))))
                      (LETT |redDisc0| (SPADCALL |poly0| (QREFELT $ 34)))
                      (LETT |redDisc|
                            (SPADCALL
                             (|compiledLookupCheck| '|coerce|
                                                    (LIST '$
                                                          (|devaluate|
                                                           (ELT $ 6)))
                                                    E)
                             |redDisc0|
                             (|compiledLookupCheck| '|mapUnivariate|
                                                    (LIST
                                                     (LIST
                                                      '|SparseUnivariatePolynomial|
                                                      (|devaluate| E))
                                                     (LIST '|Mapping|
                                                           (|devaluate| E)
                                                           (|devaluate|
                                                            (ELT $ 6)))
                                                     (|devaluate| (ELT $ 7)))
                                                    (|IntegralBasisPolynomialTools|
                                                     (ELT $ 6) (ELT $ 7)
                                                     (ELT $ 8) E))))
                      (LETT |prime|
                            (SPADCALL
                             (|compiledLookupCheck| '|coerce|
                                                    (LIST '$
                                                          (|devaluate|
                                                           (ELT $ 6)))
                                                    E)
                             |prime0|
                             (|compiledLookupCheck| '|mapUnivariate|
                                                    (LIST
                                                     (LIST
                                                      '|SparseUnivariatePolynomial|
                                                      (|devaluate| E))
                                                     (LIST '|Mapping|
                                                           (|devaluate| E)
                                                           (|devaluate|
                                                            (ELT $ 6)))
                                                     (|devaluate| (ELT $ 7)))
                                                    (|IntegralBasisPolynomialTools|
                                                     (ELT $ 6) (ELT $ 7)
                                                     (ELT $ 8) E))))
                      (LETT |sae|
                            (|SimpleAlgebraicExtension| E
                                                        (|SparseUnivariatePolynomial|
                                                         E)
                                                        |prime|))
                      (LETT |redIrrPoly|
                            (SEQ
                             (LETT |pp|
                                   (SPADCALL
                                    (|compiledLookupCheck| '|coerce|
                                                           (LIST '$
                                                                 (|devaluate|
                                                                  (ELT $ 6)))
                                                           E)
                                    |irrPoly0|
                                    (|compiledLookupCheck| '|mapBivariate|
                                                           (LIST
                                                            (LIST
                                                             '|SparseUnivariatePolynomial|
                                                             (LIST
                                                              '|SparseUnivariatePolynomial|
                                                              (|devaluate| E)))
                                                            (LIST '|Mapping|
                                                                  (|devaluate|
                                                                   E)
                                                                  (|devaluate|
                                                                   (ELT $ 6)))
                                                            (|devaluate|
                                                             (ELT $ 8)))
                                                           (|IntegralBasisPolynomialTools|
                                                            (ELT $ 6) (ELT $ 7)
                                                            (ELT $ 8) E))))
                             (EXIT
                              (SPADCALL
                               (|compiledLookupCheck| '|reduce|
                                                      (LIST '$
                                                            (LIST
                                                             '|SparseUnivariatePolynomial|
                                                             (|devaluate| E)))
                                                      |sae|)
                               |pp|
                               (|compiledLookupCheck| '|mapUnivariate|
                                                      (LIST
                                                       (LIST
                                                        '|SparseUnivariatePolynomial|
                                                        (|devaluate| |sae|))
                                                       (LIST '|Mapping|
                                                             (|devaluate|
                                                              |sae|)
                                                             (LIST
                                                              '|SparseUnivariatePolynomial|
                                                              (|devaluate| E)))
                                                       (LIST
                                                        '|SparseUnivariatePolynomial|
                                                        (LIST
                                                         '|SparseUnivariatePolynomial|
                                                         (|devaluate| E))))
                                                      (|IntegralBasisPolynomialTools|
                                                       (|SparseUnivariatePolynomial|
                                                        E)
                                                       (|SparseUnivariatePolynomial|
                                                        (|SparseUnivariatePolynomial|
                                                         E))
                                                       (|SparseUnivariatePolynomial|
                                                        (|SparseUnivariatePolynomial|
                                                         (|SparseUnivariatePolynomial|
                                                          E)))
                                                       |sae|))))))
                      (LETT |factorListSAE|
                            (SPADCALL
                             (SPADCALL |redIrrPoly|
                                       (|compiledLookupCheck| '|factor|
                                                              (LIST
                                                               (LIST
                                                                '|Factored|
                                                                (LIST
                                                                 '|SparseUnivariatePolynomial|
                                                                 (|devaluate|
                                                                  |sae|)))
                                                               (LIST
                                                                '|SparseUnivariatePolynomial|
                                                                (|devaluate|
                                                                 |sae|)))
                                                              (|DistinctDegreeFactorize|
                                                               |sae|
                                                               (|SparseUnivariatePolynomial|
                                                                |sae|))))
                             (|compiledLookupCheck| '|factorList|
                                                    (LIST
                                                     (LIST '|List|
                                                           (LIST '|Record|
                                                                 (LIST '|:|
                                                                       '|flag|
                                                                       (LIST
                                                                        '|Union|
                                                                        '#14#
                                                                        '#15#
                                                                        '#16#
                                                                        '#17#))
                                                                 (LIST '|:|
                                                                       '|factor|
                                                                       (LIST
                                                                        '|SparseUnivariatePolynomial|
                                                                        (|devaluate|
                                                                         |sae|)))
                                                                 (LIST '|:|
                                                                       '|exponent|
                                                                       (LIST
                                                                        '|NonNegativeInteger|))))
                                                     '$)
                                                    (|Factored|
                                                     (|SparseUnivariatePolynomial|
                                                      |sae|)))))
                      (LETT |redFactors|
                            (PROGN
                             (LETT #13# NIL)
                             (SEQ (LETT |f| NIL) (LETT #12# |factorListSAE|)
                                  G190
                                  (COND
                                   ((OR (ATOM #12#)
                                        (PROGN (LETT |f| (CAR #12#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #13#
                                          (CONS
                                           (SPADCALL (QVELT |f| 1) |k|
                                                     (|compiledLookupCheck| '^
                                                                            (LIST
                                                                             '$
                                                                             '$
                                                                             (LIST
                                                                              '|NonNegativeInteger|))
                                                                            (|SparseUnivariatePolynomial|
                                                                             |sae|)))
                                           #13#))))
                                  (LETT #12# (CDR #12#)) (GO G190) G191
                                  (EXIT (NREVERSE #13#)))))
                      (LETT |primaries|
                            (PROGN
                             (LETT #11# NIL)
                             (SEQ (LETT |ff| NIL) (LETT #10# |redFactors|) G190
                                  (COND
                                   ((OR (ATOM #10#)
                                        (PROGN (LETT |ff| (CAR #10#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #11#
                                          (CONS
                                           (SPADCALL
                                            (|compiledLookupCheck| '|lift|
                                                                   (LIST
                                                                    (LIST
                                                                     '|SparseUnivariatePolynomial|
                                                                     (|devaluate|
                                                                      E))
                                                                    '$)
                                                                   |sae|)
                                            |ff|
                                            (|compiledLookupCheck|
                                             '|mapUnivariate|
                                             (LIST
                                              (LIST
                                               '|SparseUnivariatePolynomial|
                                               (LIST
                                                '|SparseUnivariatePolynomial|
                                                (|devaluate| E)))
                                              (LIST '|Mapping|
                                                    (LIST
                                                     '|SparseUnivariatePolynomial|
                                                     (|devaluate| E))
                                                    (|devaluate| |sae|))
                                              (LIST
                                               '|SparseUnivariatePolynomial|
                                               (|devaluate| |sae|)))
                                             (|IntegralBasisPolynomialTools|
                                              (|SparseUnivariatePolynomial| E)
                                              (|SparseUnivariatePolynomial|
                                               (|SparseUnivariatePolynomial|
                                                E))
                                              (|SparseUnivariatePolynomial|
                                               (|SparseUnivariatePolynomial|
                                                (|SparseUnivariatePolynomial|
                                                 E)))
                                              |sae|)))
                                           #11#))))
                                  (LETT #10# (CDR #10#)) (GO G190) G191
                                  (EXIT (NREVERSE #11#)))))
                      (LETT |deg|
                            (PROG1
                                (LETT #9#
                                      (+ 1
                                         (*
                                          (SPADCALL |redDisc| |prime|
                                                    (|compiledLookupCheck|
                                                     '|order|
                                                     (LIST
                                                      (LIST
                                                       '|NonNegativeInteger|)
                                                      '$ '$)
                                                     (|SparseUnivariatePolynomial|
                                                      E)))
                                          (SPADCALL |prime|
                                                    (|compiledLookupCheck|
                                                     '|degree|
                                                     (LIST
                                                      (LIST
                                                       '|NonNegativeInteger|)
                                                      '$)
                                                     (|SparseUnivariatePolynomial|
                                                      E))))))
                              (|check_subtype2| (> #9# 0) '(|PositiveInteger|)
                                                '(|NonNegativeInteger|) #9#)))
                      (LETT |henselInfo|
                            (SPADCALL |poly| |primaries| |prime| |deg|
                                      (|compiledLookupCheck| '|HenselLift|
                                                             (LIST
                                                              (LIST '|Record|
                                                                    (LIST '|:|
                                                                          '|plist|
                                                                          (LIST
                                                                           '|List|
                                                                           (LIST
                                                                            '|SparseUnivariatePolynomial|
                                                                            (LIST
                                                                             '|SparseUnivariatePolynomial|
                                                                             (|devaluate|
                                                                              E)))))
                                                                    (LIST '|:|
                                                                          '|modulo|
                                                                          (LIST
                                                                           '|SparseUnivariatePolynomial|
                                                                           (|devaluate|
                                                                            E))))
                                                              (LIST
                                                               '|SparseUnivariatePolynomial|
                                                               (LIST
                                                                '|SparseUnivariatePolynomial|
                                                                (|devaluate|
                                                                 E)))
                                                              (LIST '|List|
                                                                    (LIST
                                                                     '|SparseUnivariatePolynomial|
                                                                     (LIST
                                                                      '|SparseUnivariatePolynomial|
                                                                      (|devaluate|
                                                                       E))))
                                                              (LIST
                                                               '|SparseUnivariatePolynomial|
                                                               (|devaluate| E))
                                                              (LIST
                                                               '|PositiveInteger|))
                                                             (|GeneralHenselPackage|
                                                              (|SparseUnivariatePolynomial|
                                                               E)
                                                              (|SparseUnivariatePolynomial|
                                                               (|SparseUnivariatePolynomial|
                                                                E))))))
                      (LETT |henselFactors| (QCAR |henselInfo|))
                      (LETT |psi1| (|SPADfirst| |henselFactors|))
                      (LETT FF
                            (|SimpleAlgebraicExtension|
                             (|SparseUnivariatePolynomial| E)
                             (|SparseUnivariatePolynomial|
                              (|SparseUnivariatePolynomial| E))
                             |psi1|))
                      (LETT |factorIb|
                            (SPADCALL |prime|
                                      (|compiledLookupCheck|
                                       '|localIntegralBasis|
                                       (LIST
                                        (LIST '|Record|
                                              (LIST '|:| '|basis|
                                                    (LIST '|Matrix|
                                                          (LIST
                                                           '|SparseUnivariatePolynomial|
                                                           (|devaluate| E))))
                                              (LIST '|:| '|basisDen|
                                                    (LIST
                                                     '|SparseUnivariatePolynomial|
                                                     (|devaluate| E)))
                                              (LIST '|:| '|basisInv|
                                                    (LIST '|Matrix|
                                                          (LIST
                                                           '|SparseUnivariatePolynomial|
                                                           (|devaluate| E)))))
                                        (LIST '|SparseUnivariatePolynomial|
                                              (|devaluate| E)))
                                       (|WildFunctionFieldIntegralBasis| E
                                                                         (|SparseUnivariatePolynomial|
                                                                          E)
                                                                         (|SparseUnivariatePolynomial|
                                                                          (|SparseUnivariatePolynomial|
                                                                           E))
                                                                         FF))))
                      (LETT |bs|
                            (SPADCALL |factorIb| (SPADCALL (QREFELT $ 48)) |r|
                                      (|compiledLookupCheck|
                                       '|listConjugateBases|
                                       (LIST
                                        (LIST '|List|
                                              (LIST '|Record|
                                                    (LIST '|:| '|basis|
                                                          (LIST '|Matrix|
                                                                (LIST
                                                                 '|SparseUnivariatePolynomial|
                                                                 (|devaluate|
                                                                  E))))
                                                    (LIST '|:| '|basisDen|
                                                          (LIST
                                                           '|SparseUnivariatePolynomial|
                                                           (|devaluate| E)))
                                                    (LIST '|:| '|basisInv|
                                                          (LIST '|Matrix|
                                                                (LIST
                                                                 '|SparseUnivariatePolynomial|
                                                                 (|devaluate|
                                                                  E))))))
                                        (LIST '|Record|
                                              (LIST '|:| '|basis|
                                                    (LIST '|Matrix|
                                                          (LIST
                                                           '|SparseUnivariatePolynomial|
                                                           (|devaluate| E))))
                                              (LIST '|:| '|basisDen|
                                                    (LIST
                                                     '|SparseUnivariatePolynomial|
                                                     (|devaluate| E)))
                                              (LIST '|:| '|basisInv|
                                                    (LIST '|Matrix|
                                                          (LIST
                                                           '|SparseUnivariatePolynomial|
                                                           (|devaluate| E)))))
                                        (LIST '|NonNegativeInteger|)
                                        (LIST '|NonNegativeInteger|))
                                       (|ChineseRemainderToolsForIntegralBases|
                                        E (|SparseUnivariatePolynomial| E)
                                        (|SparseUnivariatePolynomial|
                                         (|SparseUnivariatePolynomial| E))))))
                      (LETT |ib|
                            (SPADCALL |henselFactors| |bs| |n|
                                      (|compiledLookupCheck|
                                       '|chineseRemainder|
                                       (LIST
                                        (LIST '|Record|
                                              (LIST '|:| '|basis|
                                                    (LIST '|Matrix|
                                                          (LIST
                                                           '|SparseUnivariatePolynomial|
                                                           (|devaluate| E))))
                                              (LIST '|:| '|basisDen|
                                                    (LIST
                                                     '|SparseUnivariatePolynomial|
                                                     (|devaluate| E)))
                                              (LIST '|:| '|basisInv|
                                                    (LIST '|Matrix|
                                                          (LIST
                                                           '|SparseUnivariatePolynomial|
                                                           (|devaluate| E)))))
                                        (LIST '|List|
                                              (LIST
                                               '|SparseUnivariatePolynomial|
                                               (LIST
                                                '|SparseUnivariatePolynomial|
                                                (|devaluate| E))))
                                        (LIST '|List|
                                              (LIST '|Record|
                                                    (LIST '|:| '|basis|
                                                          (LIST '|Matrix|
                                                                (LIST
                                                                 '|SparseUnivariatePolynomial|
                                                                 (|devaluate|
                                                                  E))))
                                                    (LIST '|:| '|basisDen|
                                                          (LIST
                                                           '|SparseUnivariatePolynomial|
                                                           (|devaluate| E)))
                                                    (LIST '|:| '|basisInv|
                                                          (LIST '|Matrix|
                                                                (LIST
                                                                 '|SparseUnivariatePolynomial|
                                                                 (|devaluate|
                                                                  E))))))
                                        (LIST '|NonNegativeInteger|))
                                       (|ChineseRemainderToolsForIntegralBases|
                                        E (|SparseUnivariatePolynomial| E)
                                        (|SparseUnivariatePolynomial|
                                         (|SparseUnivariatePolynomial| E))))))
                      (LETT |b|
                            (SEQ
                             (LETT |bas|
                                   (SPADCALL
                                    (|compiledLookupCheck| '|retractIfCan|
                                                           (LIST
                                                            (LIST '|Union|
                                                                  (|devaluate|
                                                                   (ELT $ 6))
                                                                  '#23="failed")
                                                            '$)
                                                           E)
                                    (QVELT |ib| 0)
                                    (|compiledLookupCheck| '|mapMatrixIfCan|
                                                           (LIST
                                                            (LIST '|Union|
                                                                  (LIST
                                                                   '|Matrix|
                                                                   (|devaluate|
                                                                    (ELT $ 7)))
                                                                  '#2#)
                                                            (LIST '|Mapping|
                                                                  (LIST
                                                                   '|Union|
                                                                   (|devaluate|
                                                                    (ELT $ 6))
                                                                   '#24="failed")
                                                                  (|devaluate|
                                                                   E))
                                                            (LIST '|Matrix|
                                                                  (LIST
                                                                   '|SparseUnivariatePolynomial|
                                                                   (|devaluate|
                                                                    E))))
                                                           (|IntegralBasisPolynomialTools|
                                                            (ELT $ 6) (ELT $ 7)
                                                            (ELT $ 8) E))))
                             (EXIT
                              (COND
                               ((QEQCAR |bas| 1)
                                (|error| "retraction of basis failed"))
                               (#22# (QCDR |bas|))))))
                      (LETT |bInv|
                            (SEQ
                             (LETT |bas|
                                   (SPADCALL
                                    (|compiledLookupCheck| '|retractIfCan|
                                                           (LIST
                                                            (LIST '|Union|
                                                                  (|devaluate|
                                                                   (ELT $ 6))
                                                                  '#23#)
                                                            '$)
                                                           E)
                                    (QVELT |ib| 2)
                                    (|compiledLookupCheck| '|mapMatrixIfCan|
                                                           (LIST
                                                            (LIST '|Union|
                                                                  (LIST
                                                                   '|Matrix|
                                                                   (|devaluate|
                                                                    (ELT $ 7)))
                                                                  '#2#)
                                                            (LIST '|Mapping|
                                                                  (LIST
                                                                   '|Union|
                                                                   (|devaluate|
                                                                    (ELT $ 6))
                                                                   '#24#)
                                                                  (|devaluate|
                                                                   E))
                                                            (LIST '|Matrix|
                                                                  (LIST
                                                                   '|SparseUnivariatePolynomial|
                                                                   (|devaluate|
                                                                    E))))
                                                           (|IntegralBasisPolynomialTools|
                                                            (ELT $ 6) (ELT $ 7)
                                                            (ELT $ 8) E))))
                             (EXIT
                              (COND
                               ((QEQCAR |bas| 1)
                                (|error| "retraction of basis inverse failed"))
                               (#22# (QCDR |bas|))))))
                      (LETT |bDen|
                            (SEQ
                             (LETT |p|
                                   (SPADCALL
                                    (|compiledLookupCheck| '|retractIfCan|
                                                           (LIST
                                                            (LIST '|Union|
                                                                  (|devaluate|
                                                                   (ELT $ 6))
                                                                  '#23#)
                                                            '$)
                                                           E)
                                    (QVELT |ib| 1)
                                    (|compiledLookupCheck|
                                     '|mapUnivariateIfCan|
                                     (LIST
                                      (LIST '|Union| (|devaluate| (ELT $ 7))
                                            '#1#)
                                      (LIST '|Mapping|
                                            (LIST '|Union|
                                                  (|devaluate| (ELT $ 6))
                                                  '"failed")
                                            (|devaluate| E))
                                      (LIST '|SparseUnivariatePolynomial|
                                            (|devaluate| E)))
                                     (|IntegralBasisPolynomialTools| (ELT $ 6)
                                                                     (ELT $ 7)
                                                                     (ELT $ 8)
                                                                     E))))
                             (EXIT
                              (COND
                               ((QEQCAR |p| 1)
                                (|error|
                                 "retraction of basis denominator failed"))
                               (#22# (QCDR |p|))))))
                      (EXIT (VECTOR |b| |bDen| |bInv|))))))))) 

(SDEFUN |PWFFINTB;padicLocalIntegralBasis|
        ((|p| (UP)) (|disc| (R)) (|redDisc| (R)) (|prime| (R))
         ($
          (|Record| (|:| |basis| (|Matrix| R)) (|:| |basisDen| R)
                    (|:| |basisInv| (|Matrix| R)) (|:| |discr| R))))
        (SPROG
         ((|index| (R))
          (|ib|
           (|Record| (|:| |basis| (|Matrix| R)) (|:| |basisDen| R)
                     (|:| |basisInv| (|Matrix| R))))
          (|factorBases|
           (|List|
            (|Record| (|:| |basis| (|Matrix| R)) (|:| |basisDen| R)
                      (|:| |basisInv| (|Matrix| R)))))
          (|base|
           (|Record| (|:| |basis| (|Matrix| R)) (|:| |basisDen| R)
                     (|:| |basisInv| (|Matrix| R))))
          (|degPp| (|NonNegativeInteger|)) (#1=#:G819 NIL) (|pp| NIL)
          (#2=#:G820 NIL) (|k| NIL) (#3=#:G821 NIL) (|qq| NIL)
          (|degPrime| (|NonNegativeInteger|)) (|henselFactors| #4=(|List| UP))
          (|henselInfo| (|Record| (|:| |plist| #4#) (|:| |modulo| R)))
          (|deg| (|PositiveInteger|)) (#5=#:G797 NIL) (|primaries| (|List| UP))
          (#6=#:G818 NIL) (|ff| NIL) (#7=#:G817 NIL)
          (|redPrimaries| (|List| (|SparseUnivariatePolynomial| |sae|)))
          (#8=#:G816 NIL) (|f| NIL) (#9=#:G815 NIL)
          (|expons| (|List| (|NonNegativeInteger|))) (#10=#:G814 NIL)
          (#11=#:G813 NIL) (|primes| (|List| UP)) (#12=#:G812 NIL)
          (#13=#:G811 NIL)
          (|redPrimes| (|List| (|SparseUnivariatePolynomial| |sae|)))
          (#14=#:G810 NIL) (#15=#:G809 NIL)
          (|factorListSAE|
           (|List|
            (|Record|
             (|:| |flag|
                  (|Union| #16="nil" #17="sqfr" #18="irred" #19="prime"))
             (|:| |factor| (|SparseUnivariatePolynomial| |sae|))
             (|:| |exponent| (|NonNegativeInteger|)))))
          (|reducedP| (|SparseUnivariatePolynomial| |sae|))
          (|sae|
           (|Join| (|MonogenicAlgebra| K R)
                   (CATEGORY |package|
                    (IF (|has| K (|Field|))
                        (IF (|has| K (|PolynomialFactorizationExplicit|))
                            (ATTRIBUTE (|PolynomialFactorizationExplicit|))
                            |noBranch|)
                        |noBranch|)))))
         (SEQ
          (LETT |sae|
                (|SimpleAlgebraicExtension| (QREFELT $ 6) (QREFELT $ 7)
                                            |prime|))
          (LETT |reducedP|
                (SPADCALL
                 (|compiledLookupCheck| '|reduce|
                                        (LIST '$ (|devaluate| (ELT $ 7)))
                                        |sae|)
                 |p|
                 (|compiledLookupCheck| '|mapUnivariate|
                                        (LIST
                                         (LIST '|SparseUnivariatePolynomial|
                                               (|devaluate| |sae|))
                                         (LIST '|Mapping| (|devaluate| |sae|)
                                               (|devaluate| (ELT $ 7)))
                                         (|devaluate| (ELT $ 8)))
                                        (|IntegralBasisPolynomialTools|
                                         (ELT $ 7) (ELT $ 8)
                                         (|SparseUnivariatePolynomial|
                                          (ELT $ 8))
                                         |sae|))))
          (LETT |factorListSAE|
                (SPADCALL
                 (SPADCALL |reducedP|
                           (|compiledLookupCheck| '|factor|
                                                  (LIST
                                                   (LIST '|Factored|
                                                         (LIST
                                                          '|SparseUnivariatePolynomial|
                                                          (|devaluate| |sae|)))
                                                   (LIST
                                                    '|SparseUnivariatePolynomial|
                                                    (|devaluate| |sae|)))
                                                  (|DistinctDegreeFactorize|
                                                   |sae|
                                                   (|SparseUnivariatePolynomial|
                                                    |sae|))))
                 (|compiledLookupCheck| '|factorList|
                                        (LIST
                                         (LIST '|List|
                                               (LIST '|Record|
                                                     (LIST '|:| '|flag|
                                                           (LIST '|Union| '#16#
                                                                 '#17# '#18#
                                                                 '#19#))
                                                     (LIST '|:| '|factor|
                                                           (LIST
                                                            '|SparseUnivariatePolynomial|
                                                            (|devaluate|
                                                             |sae|)))
                                                     (LIST '|:| '|exponent|
                                                           (LIST
                                                            '|NonNegativeInteger|))))
                                         '$)
                                        (|Factored|
                                         (|SparseUnivariatePolynomial|
                                          |sae|)))))
          (EXIT
           (COND
            ((EQL (LENGTH |factorListSAE|) 1)
             (SEQ (LETT |ib| (SPADCALL |prime| (QREFELT $ 53)))
                  (LETT |index| (SPADCALL (QVELT |ib| 2) (QREFELT $ 55)))
                  (EXIT
                   (VECTOR (QVELT |ib| 0) (QVELT |ib| 1) (QVELT |ib| 2)
                           (SPADCALL |disc|
                                     (SPADCALL |index| |index| (QREFELT $ 56))
                                     (QREFELT $ 57))))))
            ('T
             (SEQ
              (LETT |redPrimes|
                    (PROGN
                     (LETT #15# NIL)
                     (SEQ (LETT |f| NIL) (LETT #14# |factorListSAE|) G190
                          (COND
                           ((OR (ATOM #14#) (PROGN (LETT |f| (CAR #14#)) NIL))
                            (GO G191)))
                          (SEQ (EXIT (LETT #15# (CONS (QVELT |f| 1) #15#))))
                          (LETT #14# (CDR #14#)) (GO G190) G191
                          (EXIT (NREVERSE #15#)))))
              (LETT |primes|
                    (PROGN
                     (LETT #13# NIL)
                     (SEQ (LETT |ff| NIL) (LETT #12# |redPrimes|) G190
                          (COND
                           ((OR (ATOM #12#) (PROGN (LETT |ff| (CAR #12#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #13#
                                  (CONS
                                   (SPADCALL
                                    (|compiledLookupCheck| '|lift|
                                                           (LIST
                                                            (|devaluate|
                                                             (ELT $ 7))
                                                            '$)
                                                           |sae|)
                                    |ff|
                                    (|compiledLookupCheck| '|mapUnivariate|
                                                           (LIST
                                                            (|devaluate|
                                                             (ELT $ 8))
                                                            (LIST '|Mapping|
                                                                  (|devaluate|
                                                                   (ELT $ 7))
                                                                  (|devaluate|
                                                                   |sae|))
                                                            (LIST
                                                             '|SparseUnivariatePolynomial|
                                                             (|devaluate|
                                                              |sae|)))
                                                           (|IntegralBasisPolynomialTools|
                                                            (ELT $ 7) (ELT $ 8)
                                                            (|SparseUnivariatePolynomial|
                                                             (ELT $ 8))
                                                            |sae|)))
                                   #13#))))
                          (LETT #12# (CDR #12#)) (GO G190) G191
                          (EXIT (NREVERSE #13#)))))
              (LETT |expons|
                    (PROGN
                     (LETT #11# NIL)
                     (SEQ (LETT |f| NIL) (LETT #10# |factorListSAE|) G190
                          (COND
                           ((OR (ATOM #10#) (PROGN (LETT |f| (CAR #10#)) NIL))
                            (GO G191)))
                          (SEQ (EXIT (LETT #11# (CONS (QVELT |f| 2) #11#))))
                          (LETT #10# (CDR #10#)) (GO G190) G191
                          (EXIT (NREVERSE #11#)))))
              (LETT |redPrimaries|
                    (PROGN
                     (LETT #9# NIL)
                     (SEQ (LETT |f| NIL) (LETT #8# |factorListSAE|) G190
                          (COND
                           ((OR (ATOM #8#) (PROGN (LETT |f| (CAR #8#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #9#
                                  (CONS
                                   (SPADCALL (QVELT |f| 1) (QVELT |f| 2)
                                             (|compiledLookupCheck| '^
                                                                    (LIST '$ '$
                                                                          (LIST
                                                                           '|NonNegativeInteger|))
                                                                    (|SparseUnivariatePolynomial|
                                                                     |sae|)))
                                   #9#))))
                          (LETT #8# (CDR #8#)) (GO G190) G191
                          (EXIT (NREVERSE #9#)))))
              (LETT |primaries|
                    (PROGN
                     (LETT #7# NIL)
                     (SEQ (LETT |ff| NIL) (LETT #6# |redPrimaries|) G190
                          (COND
                           ((OR (ATOM #6#) (PROGN (LETT |ff| (CAR #6#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #7#
                                  (CONS
                                   (SPADCALL
                                    (|compiledLookupCheck| '|lift|
                                                           (LIST
                                                            (|devaluate|
                                                             (ELT $ 7))
                                                            '$)
                                                           |sae|)
                                    |ff|
                                    (|compiledLookupCheck| '|mapUnivariate|
                                                           (LIST
                                                            (|devaluate|
                                                             (ELT $ 8))
                                                            (LIST '|Mapping|
                                                                  (|devaluate|
                                                                   (ELT $ 7))
                                                                  (|devaluate|
                                                                   |sae|))
                                                            (LIST
                                                             '|SparseUnivariatePolynomial|
                                                             (|devaluate|
                                                              |sae|)))
                                                           (|IntegralBasisPolynomialTools|
                                                            (ELT $ 7) (ELT $ 8)
                                                            (|SparseUnivariatePolynomial|
                                                             (ELT $ 8))
                                                            |sae|)))
                                   #7#))))
                          (LETT #6# (CDR #6#)) (GO G190) G191
                          (EXIT (NREVERSE #7#)))))
              (LETT |deg|
                    (PROG1
                        (LETT #5#
                              (+ 1
                                 (* (SPADCALL |redDisc| |prime| (QREFELT $ 58))
                                    (SPADCALL |prime| (QREFELT $ 59)))))
                      (|check_subtype2| (> #5# 0) '(|PositiveInteger|)
                                        '(|NonNegativeInteger|) #5#)))
              (LETT |henselInfo|
                    (SPADCALL |p| |primaries| |prime| |deg| (QREFELT $ 63)))
              (LETT |henselFactors| (QCAR |henselInfo|))
              (LETT |factorBases| NIL)
              (LETT |degPrime| (SPADCALL |prime| (QREFELT $ 59)))
              (SEQ (LETT |qq| NIL) (LETT #3# |henselFactors|) (LETT |k| NIL)
                   (LETT #2# |expons|) (LETT |pp| NIL) (LETT #1# |primes|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |pp| (CAR #1#)) NIL)
                         (ATOM #2#) (PROGN (LETT |k| (CAR #2#)) NIL) (ATOM #3#)
                         (PROGN (LETT |qq| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |base|
                          (SEQ (LETT |degPp| (SPADCALL |pp| (QREFELT $ 36)))
                               (COND
                                ((> |degPp| 1)
                                 (COND
                                  ((EQL (GCD |degPp| |degPrime|) 1)
                                   (EXIT
                                    (|PWFFINTB;compLocalBasisOverExt| |qq|
                                     |prime| |pp| |k| $))))))
                               (EXIT
                                (|PWFFINTB;compLocalBasis| |qq| |prime| $))))
                    (EXIT (LETT |factorBases| (CONS |base| |factorBases|))))
                   (LETT #1#
                         (PROG1 (CDR #1#)
                           (LETT #2# (PROG1 (CDR #2#) (LETT #3# (CDR #3#))))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |factorBases| (NREVERSE |factorBases|))
              (LETT |ib|
                    (SPADCALL |henselFactors| |factorBases|
                              (SPADCALL (QREFELT $ 64)) (QREFELT $ 67)))
              (LETT |index| (SPADCALL (QVELT |ib| 2) (QREFELT $ 55)))
              (EXIT
               (VECTOR (QVELT |ib| 0) (QVELT |ib| 1) (QVELT |ib| 2)
                       (SPADCALL |disc|
                                 (SPADCALL |index| |index| (QREFELT $ 56))
                                 (QREFELT $ 57))))))))))) 

(SDEFUN |PWFFINTB;localIntegralBasis;RR;5|
        ((|prime| (R))
         ($
          (|Record| (|:| |basis| (|Matrix| R)) (|:| |basisDen| R)
                    (|:| |basisInv| (|Matrix| R)))))
        (SPROG
         ((|ib|
           (|Record| (|:| |basis| (|Matrix| R)) (|:| |basisDen| R)
                     (|:| |basisInv| (|Matrix| R)) (|:| |discr| R)))
          (|redDisc| (R)) (|disc| (R)) (|p| (UP)))
         (SEQ (LETT |p| (SPADCALL (QREFELT $ 68)))
              (LETT |disc| (SPADCALL |p| (QREFELT $ 37)))
              (LETT |redDisc| (SPADCALL |p| (QREFELT $ 34)))
              (LETT |ib|
                    (|PWFFINTB;padicLocalIntegralBasis| |p| |disc| |redDisc|
                     |prime| $))
              (EXIT (VECTOR (QVELT |ib| 0) (QVELT |ib| 1) (QVELT |ib| 2)))))) 

(SDEFUN |PWFFINTB;listSquaredFactors| ((|px| (R)) ($ (|List| R)))
        (SPROG
         ((|ans| (|List| R)) (#1=#:G832 NIL) (|f| NIL)
          (|factored| (|Factored| R)))
         (SEQ (LETT |ans| NIL) (LETT |factored| (SPADCALL |px| (QREFELT $ 72)))
              (SEQ (LETT |f| NIL)
                   (LETT #1# (SPADCALL |factored| (QREFELT $ 76))) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((> (QVELT |f| 2) 1)
                       (LETT |ans| (CONS (QVELT |f| 1) |ans|))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |PWFFINTB;integralBasis;R;7|
        (($
          (|Record| (|:| |basis| (|Matrix| R)) (|:| |basisDen| R)
                    (|:| |basisInv| (|Matrix| R)))))
        (SPROG
         ((|runningRbinv| #1=(|Matrix| R)) (|runningRb| #1#)
          (|runningRbden| (R)) (|mat| (|Matrix| R)) (|disc| (R)) (|rbden| (R))
          (|rb| #2=(|Matrix| R))
          (|lb|
           (|Record| (|:| |basis| #2#) (|:| |basisDen| R)
                     (|:| |basisInv| (|Matrix| R)) (|:| |discr| R)))
          (#3=#:G841 NIL) (|prime| NIL) (|redDisc| (R)) (|singList| (|List| R))
          (|n| (|PositiveInteger|)) (|p| (UP)))
         (SEQ (LETT |p| (SPADCALL (QREFELT $ 68)))
              (LETT |disc| (SPADCALL |p| (QREFELT $ 37)))
              (LETT |n| (SPADCALL (QREFELT $ 64)))
              (LETT |singList| (|PWFFINTB;listSquaredFactors| |disc| $))
              (LETT |redDisc| (SPADCALL |p| (QREFELT $ 34)))
              (LETT |runningRb|
                    (LETT |runningRbinv|
                          (SPADCALL |n| (|spadConstant| $ 39) (QREFELT $ 41))))
              (LETT |runningRbden| (|spadConstant| $ 39))
              (EXIT
               (COND
                ((NULL |singList|)
                 (VECTOR |runningRb| |runningRbden| |runningRbinv|))
                ('T
                 (SEQ
                  (SEQ (LETT |prime| NIL) (LETT #3# |singList|) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |prime| (CAR #3#)) NIL))
                         (GO G191)))
                       (SEQ
                        (LETT |lb|
                              (|PWFFINTB;padicLocalIntegralBasis| |p| |disc|
                               |redDisc| |prime| $))
                        (LETT |rb| (QVELT |lb| 0))
                        (LETT |rbden| (QVELT |lb| 1))
                        (LETT |disc| (QVELT |lb| 3))
                        (LETT |mat|
                              (SPADCALL
                               (SPADCALL |rbden| |runningRb| (QREFELT $ 77))
                               (SPADCALL |runningRbden| |rb| (QREFELT $ 77))
                               (QREFELT $ 78)))
                        (LETT |runningRbden|
                              (SPADCALL |runningRbden| |rbden| (QREFELT $ 56)))
                        (LETT |runningRb|
                              (SPADCALL
                               (SPADCALL |mat| |runningRbden| (QREFELT $ 80))
                               (QREFELT $ 81)))
                        (EXIT
                         (LETT |runningRbinv|
                               (SPADCALL |runningRb| |runningRbden|
                                         (QREFELT $ 83)))))
                       (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (VECTOR |runningRb| |runningRbden| |runningRbinv|))))))))) 

(DECLAIM (NOTINLINE |PAdicWildFunctionFieldIntegralBasis;|)) 

(DEFUN |PAdicWildFunctionFieldIntegralBasis| (&REST #1=#:G842)
  (SPROG NIL
         (PROG (#2=#:G843)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PAdicWildFunctionFieldIntegralBasis|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |PAdicWildFunctionFieldIntegralBasis;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|PAdicWildFunctionFieldIntegralBasis|)))))))))) 

(DEFUN |PAdicWildFunctionFieldIntegralBasis;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$|
          (LIST '|PAdicWildFunctionFieldIntegralBasis| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 85))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|PAdicWildFunctionFieldIntegralBasis|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|PAdicWildFunctionFieldIntegralBasis| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|Fraction| 7) (0 . |coerce|)
              (|SparseUnivariatePolynomial| 10) (|Mapping| 10 7)
              (|IntegralBasisPolynomialTools| 7 8
                                              (|SparseUnivariatePolynomial| 8)
                                              10)
              (5 . |mapUnivariate|) (11 . |differentiate|)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (16 . |extendedEuclidean|) (|List| 10) (22 . |coefficients|)
              (27 . |concat|) (|Record| (|:| |num| 19) (|:| |den| 7))
              (|CommonDenominator| 7 10 19) (33 . |splitDenominator|)
              (38 . |numer|) (|List| 7) (|Mapping| 7 10)
              (|ListFunctions2| 10 7) (43 . |map|) (|List| $) (49 . |gcd|)
              (|Union| $ '"failed") (54 . |exquo|)
              |PWFFINTB;reducedDiscriminant;UPR;1| (|NonNegativeInteger|)
              (60 . |degree|) (65 . |discriminant|) (70 . |One|) (74 . |One|)
              (|Matrix| 7) (78 . |scalarMatrix|)
              (|SparseUnivariatePolynomial| 6) (|PositiveInteger|)
              (|FiniteFieldPolynomialPackage| 6) (84 . |createIrreduciblePoly|)
              (89 . |One|) (93 . |One|) (97 . |size|) (|Vector| $)
              (101 . |basis|)
              (|Record| (|:| |basis| 40) (|:| |basisDen| 7)
                        (|:| |basisInv| 40))
              (|WildFunctionFieldIntegralBasis| 6 7 8 9)
              (105 . |localIntegralBasis|) (|IntegralBasisTools| 7 8 9)
              (110 . |diagonalProduct|) (115 . *) (121 . |quo|) (127 . |order|)
              (133 . |degree|) (|Record| (|:| |plist| 61) (|:| |modulo| 7))
              (|List| 8) (|GeneralHenselPackage| 7 8) (138 . |HenselLift|)
              (146 . |rank|) (|List| 51)
              (|ChineseRemainderToolsForIntegralBases| 6 7 8)
              (150 . |chineseRemainder|) (157 . |definingPolynomial|)
              |PWFFINTB;localIntegralBasis;RR;5| (|Factored| 7)
              (|DistinctDegreeFactorize| 6 7) (161 . |factor|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 73) (|:| |factor| 7) (|:| |exponent| 35))
              (|List| 74) (166 . |factorList|) (171 . *) (177 . |vertConcat|)
              (|ModularHermitianRowReduction| 7) (183 . |rowEchelon|)
              (189 . |squareTop|)
              (|TriangularMatrixOperations| 7 (|Vector| 7) (|Vector| 7) 40)
              (194 . |UpTriBddDenomInv|) |PWFFINTB;integralBasis;R;7|)
           '#(|reducedDiscriminant| 200 |localIntegralBasis| 205
              |integralBasis| 210)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|integralBasis|
                                 ((|Record| (|:| |basis| (|Matrix| |#2|))
                                            (|:| |basisDen| |#2|)
                                            (|:| |basisInv| (|Matrix| |#2|)))))
                                T)
                              '((|localIntegralBasis|
                                 ((|Record| (|:| |basis| (|Matrix| |#2|))
                                            (|:| |basisDen| |#2|)
                                            (|:| |basisInv| (|Matrix| |#2|)))
                                  |#2|))
                                T)
                              '((|reducedDiscriminant| (|#2| |#3|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 84
                                            '(1 10 0 7 11 2 14 12 13 8 15 1 12
                                              0 0 16 2 12 17 0 0 18 1 12 19 0
                                              20 2 19 0 0 0 21 1 23 22 19 24 1
                                              10 7 0 25 2 28 26 27 19 29 1 7 0
                                              30 31 2 7 32 0 0 33 1 8 35 0 36 1
                                              8 7 0 37 0 6 0 38 0 7 0 39 2 40 0
                                              35 7 41 1 44 42 43 45 0 8 0 46 0
                                              9 0 47 0 6 35 48 0 9 49 50 1 52
                                              51 7 53 1 54 7 40 55 2 7 0 0 0 56
                                              2 7 0 0 0 57 2 7 35 0 0 58 1 7 35
                                              0 59 4 62 60 8 61 7 43 63 0 9 43
                                              64 3 66 51 61 65 35 67 0 9 8 68 1
                                              71 70 7 72 1 70 75 0 76 2 40 0 7
                                              0 77 2 40 0 0 0 78 2 79 40 40 7
                                              80 1 40 0 0 81 2 82 40 40 7 83 1
                                              0 7 8 34 1 0 51 7 69 0 0 51
                                              84)))))
           '|lookupComplete|)) 
