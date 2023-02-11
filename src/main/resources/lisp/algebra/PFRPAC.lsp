
(SDEFUN |PFRPAC;partialFraction;FSA;1|
        ((|rf| (|Fraction| (|Polynomial| R))) (|v| (|Symbol|)) ($ (|Any|)))
        (SPROG ((|df| (|Factored| (|Polynomial| R))))
               (SEQ
                (LETT |df|
                      (SPADCALL (SPADCALL |rf| (QREFELT $ 9)) (QREFELT $ 12)))
                (EXIT
                 (SPADCALL (SPADCALL |rf| (QREFELT $ 13)) |df| |v|
                           (QREFELT $ 16)))))) 

(SDEFUN |PFRPAC;makeSup|
        ((|p| (|Polynomial| R)) (|v| (|Symbol|))
         ($ (|SparseUnivariatePolynomial| (|Fraction| (|Polynomial| R)))))
        (SPROG ((|up| (|SparseUnivariatePolynomial| (|Polynomial| R))))
               (SEQ (LETT |up| (SPADCALL |p| |v| (QREFELT $ 19)))
                    (EXIT (SPADCALL (ELT $ 20) |up| (QREFELT $ 25)))))) 

(SDEFUN |PFRPAC;partialFraction;PFSA;3|
        ((|p| (|Polynomial| R)) (|facq| (|Factored| (|Polynomial| R)))
         (|v| (|Symbol|)) ($ (|Any|)))
        (SPROG
         ((|pfup| (|PartialFraction| |up|)) (|nflist| (|fup|)) (#1=#:G722 NIL)
          (#2=#:G721 (|fup|)) (#3=#:G723 (|fup|)) (#4=#:G731 NIL) (|u| NIL)
          (|fcont| (|up|))
          (|fup|
           (|Join| (|IntegralDomain|) (|DifferentialExtension| |up|)
                   (|Algebra| |up|) (|FullyEvalableOver| |up|)
                   (|FullyRetractableTo| |up|)
                   (CATEGORY |domain| (SIGNATURE |expand| (|up| $))
                    (SIGNATURE |makeFR|
                     ($ |up|
                      (|List|
                       (|Record|
                        (|:| |flag|
                             (|Union| #5="nil" #6="sqfr" #7="irred"
                                      #8="prime"))
                        (|:| |factor| |up|)
                        (|:| |exponent| (|NonNegativeInteger|))))))
                    (SIGNATURE |factorList|
                     ((|List|
                       (|Record| (|:| |flag| (|Union| #5# #6# #7# #8#))
                                 (|:| |factor| |up|)
                                 (|:| |exponent| (|NonNegativeInteger|))))
                      $))
                    (SIGNATURE |nilFactor| ($ |up| (|NonNegativeInteger|)))
                    (SIGNATURE |factors|
                     ((|List|
                       (|Record| (|:| |factor| |up|)
                                 (|:| |exponent| (|NonNegativeInteger|))))
                      $))
                    (SIGNATURE |irreducibleFactor|
                     ($ |up| (|NonNegativeInteger|)))
                    (SIGNATURE |numberOfFactors| ((|NonNegativeInteger|) $))
                    (SIGNATURE |primeFactor| ($ |up| (|NonNegativeInteger|)))
                    (SIGNATURE |sqfrFactor| ($ |up| (|NonNegativeInteger|)))
                    (SIGNATURE |flagFactor|
                     ($ |up| (|NonNegativeInteger|) (|Union| #5# #6# #7# #8#)))
                    (SIGNATURE |unit| (|up| $))
                    (SIGNATURE |unitNormalize| ($ $))
                    (SIGNATURE |map| ($ (|Mapping| |up| |up|) $))
                    (SIGNATURE |mergeFactors| ($ $ $))
                    (IF (|has| |up| (|GcdDomain|))
                        (ATTRIBUTE (|GcdDomain|))
                        |noBranch|)
                    (IF (|has| |up| (|RealConstant|))
                        (ATTRIBUTE (|RealConstant|))
                        |noBranch|)
                    (IF (|has| |up| (|UniqueFactorizationDomain|))
                        (ATTRIBUTE (|UniqueFactorizationDomain|))
                        |noBranch|)
                    (IF (|has| |up| (|ConvertibleTo| (|InputForm|)))
                        (ATTRIBUTE (|ConvertibleTo| (|InputForm|)))
                        |noBranch|)
                    (IF (|has| |up| (|IntegerNumberSystem|))
                        (PROGN
                         (SIGNATURE |rational?| ((|Boolean|) $))
                         (SIGNATURE |rational| ((|Fraction| (|Integer|)) $))
                         (SIGNATURE |rationalIfCan|
                          ((|Union| (|Fraction| (|Integer|)) "failed") $)))
                        |noBranch|)
                    (IF (|has| |up| (|Eltable| $ $))
                        (ATTRIBUTE (|Eltable| $ $))
                        |noBranch|)
                    (IF (|has| |up| (|Evalable| $))
                        (ATTRIBUTE (|Evalable| $))
                        |noBranch|)
                    (IF (|has| |up| (|InnerEvalable| (|Symbol|) $))
                        (ATTRIBUTE (|InnerEvalable| (|Symbol|) $))
                        |noBranch|))))
          (|up|
           (|Join|
            (|UnivariatePolynomialCategory| (|Fraction| (|Polynomial| R)))
            (CATEGORY |domain| (SIGNATURE |coerce| ($ (|Variable| |v|)))))))
         (SEQ
          (LETT |up|
                (|UnivariatePolynomial| |v|
                                        (|Fraction|
                                         (|Polynomial| (QREFELT $ 6)))))
          (LETT |fup| (|Factored| |up|))
          (LETT |fcont|
                (|PFRPAC;makeSup| (SPADCALL |facq| (QREFELT $ 26)) |v| $))
          (LETT |nflist|
                (SPADCALL |fcont|
                          (PROGN
                           (LETT #1# NIL)
                           (SEQ (LETT |u| NIL)
                                (LETT #4# (SPADCALL |facq| (QREFELT $ 30)))
                                G190
                                (COND
                                 ((OR (ATOM #4#)
                                      (PROGN (LETT |u| (CAR #4#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (PROGN
                                   (LETT #3#
                                         (SPADCALL
                                          (|PFRPAC;makeSup| (QVELT |u| 1) |v|
                                           $)
                                          (QVELT |u| 2)
                                          (|compiledLookupCheck| '|primeFactor|
                                                                 (LIST '$
                                                                       (|devaluate|
                                                                        |up|)
                                                                       (LIST
                                                                        '|NonNegativeInteger|))
                                                                 |fup|)))
                                   (COND
                                    (#1#
                                     (LETT #2#
                                           (SPADCALL #2# #3#
                                                     (|compiledLookupCheck| '*
                                                                            (LIST
                                                                             '$
                                                                             '$
                                                                             '$)
                                                                            |fup|))))
                                    ('T
                                     (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                                (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                           (COND (#1# #2#)
                                 ('T
                                  (SPADCALL
                                   (|compiledLookupCheck| '|One| (LIST '$)
                                                          |fup|)))))
                          (|compiledLookupCheck| '*
                                                 (LIST '$ (|devaluate| |up|)
                                                       '$)
                                                 |fup|)))
          (LETT |pfup|
                (SPADCALL (|PFRPAC;makeSup| |p| |v| $) |nflist|
                          (|compiledLookupCheck| '|partialFraction|
                                                 (LIST '$ (|devaluate| |up|)
                                                       (LIST '|Factored|
                                                             (|devaluate|
                                                              |up|)))
                                                 (|PartialFraction| |up|))))
          (EXIT
           (SPADCALL |pfup|
                     (|compiledLookupCheck| '|coerce|
                                            (LIST (LIST '|Any|)
                                                  (LIST '|PartialFraction|
                                                        (|devaluate| |up|)))
                                            (|AnyFunctions1|
                                             (|PartialFraction| |up|)))))))) 

(DECLAIM (NOTINLINE |PartialFractionPackage;|)) 

(DEFUN |PartialFractionPackage| (#1=#:G732)
  (SPROG NIL
         (PROG (#2=#:G733)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|PartialFractionPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|PartialFractionPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PartialFractionPackage|)))))))))) 

(DEFUN |PartialFractionPackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|PartialFractionPackage| DV$1))
          (LETT $ (GETREFV 31))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PartialFractionPackage| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PartialFractionPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Polynomial| 6)
              (|Fraction| 7) (0 . |denom|) (|Factored| 7)
              (|MultivariateFactorize| 15 (|IndexedExponents| 15) 6 7)
              (5 . |factor|) (10 . |numer|) (|Any|) (|Symbol|)
              |PFRPAC;partialFraction;PFSA;3| |PFRPAC;partialFraction;FSA;1|
              (|SparseUnivariatePolynomial| $) (15 . |univariate|)
              (21 . |coerce|) (|SparseUnivariatePolynomial| 8) (|Mapping| 8 7)
              (|SparseUnivariatePolynomial| 7)
              (|UnivariatePolynomialCategoryFunctions2| 7 23 8 21) (26 . |map|)
              (32 . |unit|) (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 27) (|:| |factor| 7)
                        (|:| |exponent| (|NonNegativeInteger|)))
              (|List| 28) (37 . |factorList|))
           '#(|partialFraction| 42) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|partialFraction|
                                 ((|Any|) (|Fraction| (|Polynomial| |#1|))
                                  (|Symbol|)))
                                T)
                              '((|partialFraction|
                                 ((|Any|) (|Polynomial| |#1|)
                                  (|Factored| (|Polynomial| |#1|)) (|Symbol|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 30
                                            '(1 8 7 0 9 1 11 10 7 12 1 8 7 0 13
                                              2 7 18 0 15 19 1 8 0 7 20 2 24 21
                                              22 23 25 1 10 7 0 26 1 10 29 0 30
                                              3 0 14 7 10 15 16 2 0 14 8 15
                                              17)))))
           '|lookupComplete|)) 
