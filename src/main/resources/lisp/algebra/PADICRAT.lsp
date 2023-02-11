
(DECLAIM (NOTINLINE |PAdicRational;|)) 

(DEFUN |PAdicRational| (#1=#:G760)
  (SPROG NIL
         (PROG (#2=#:G761)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PAdicRational|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|PAdicRational;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|PAdicRational|)))))))))) 

(DEFUN |PAdicRational;| (|#1|)
  (SPROG ((|pv$| NIL) (#1=#:G759 NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT |dv$| (LIST '|PAdicRational| DV$1))
          (LETT $ (GETREFV 58))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               '(|PolynomialFactorizationExplicit|))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               '(|RetractableTo| (|Symbol|)))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               '(|CharacteristicNonZero|))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               '(|CharacteristicZero|))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               '(|ConvertibleTo|
                                                 (|InputForm|)))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               '(|RealConstant|))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               '(|OrderedIntegralDomain|))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               '(|OrderedSet|))
                                              (OR
                                               (|HasCategory|
                                                (|PAdicInteger| |#1|)
                                                '(|OrderedIntegralDomain|))
                                               (|HasCategory|
                                                (|PAdicInteger| |#1|)
                                                '(|OrderedSet|)))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               '(|RetractableTo| (|Integer|)))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               '(|StepThrough|))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               (LIST '|InnerEvalable|
                                                     '(|Symbol|)
                                                     (LIST '|PAdicInteger|
                                                           (|devaluate|
                                                            |#1|))))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               (LIST '|Evalable|
                                                     (LIST '|PAdicInteger|
                                                           (|devaluate|
                                                            |#1|))))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               (LIST '|Eltable|
                                                     (LIST '|PAdicInteger|
                                                           (|devaluate| |#1|))
                                                     (LIST '|PAdicInteger|
                                                           (|devaluate|
                                                            |#1|))))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               '(|PartialDifferentialRing|
                                                 (|Symbol|)))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               '(|DifferentialRing|))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               '(|LinearlyExplicitOver|
                                                 (|Integer|)))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               '(|ConvertibleTo|
                                                 (|Pattern| (|Float|))))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               '(|ConvertibleTo|
                                                 (|Pattern| (|Integer|))))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               '(|PatternMatchable| (|Float|)))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               '(|PatternMatchable|
                                                 (|Integer|)))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               '(|EuclideanDomain|))
                                              (|HasCategory|
                                               (|PAdicInteger| |#1|)
                                               '(|IntegerNumberSystem|))
                                              (LETT #1#
                                                    (|HasCategory|
                                                     (|PAdicInteger| |#1|)
                                                     '(|Comparable|)))
                                              (OR #1#
                                                  (|HasCategory|
                                                   (|PAdicInteger| |#1|)
                                                   '(|OrderedIntegralDomain|))
                                                  (|HasCategory|
                                                   (|PAdicInteger| |#1|)
                                                   '(|OrderedSet|)))))))
          (|haddProp| |$ConstructorCache| '|PAdicRational| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (AND (|HasCategory| $ '(|CharacteristicNonZero|))
               (|HasCategory| (|PAdicInteger| |#1|)
                              '(|PolynomialFactorizationExplicit|))
               (|augmentPredVector| $ 33554432))
          (AND
           (OR
            (AND (|HasCategory| $ '(|CharacteristicNonZero|))
                 (|HasCategory| (|PAdicInteger| |#1|)
                                '(|PolynomialFactorizationExplicit|)))
            (|HasCategory| (|PAdicInteger| |#1|) '(|CharacteristicNonZero|)))
           (|augmentPredVector| $ 67108864))
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PAdicRational| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL
              (|PAdicRationalConstructor| (NRTEVAL (QREFELT $ 6)) 15)
              (|local| |#1|) (|Union| 22 '#1="failed") (|Matrix| $)
              (|Union| $ '"failed") (|Boolean|) (|InputForm|) (|Pattern| 33)
              (|Pattern| 24) (|NonNegativeInteger|)
              (|PAdicInteger| (NRTEVAL (QREFELT $ 6))) (|List| 17)
              (|Equation| 15) (|List| 15) (|Symbol|) (|List| 19)
              (|Record| (|:| |mat| 23) (|:| |vec| (|Vector| 24))) (|Vector| $)
              (|Matrix| 24) (|Integer|) (|List| 14) (|PatternMatchResult| 33 $)
              (|PatternMatchResult| 24 $) (|Factored| 29)
              (|SparseUnivariatePolynomial| $) (|Union| 31 '#1#) (|List| 29)
              (|DoubleFloat|) (|Float|) (|Union| 24 '#2="failed")
              (|Union| 36 '#2#) (|Fraction| 24) (|Union| 19 '#2#)
              (|ContinuedFraction| 36) (|Matrix| 15)
              (|Record| (|:| |mat| 39) (|:| |vec| (|Vector| 15)))
              (|Mapping| 15 15) (|Union| 15 '#2#) (|Factored| $)
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 44 '#3="failed") (|Union| 47 '#3#) (|List| $)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef| 47) (|:| |generator| $))
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|PositiveInteger|) (|String|) (|SingleInteger|) (|HashState|)
              (|OutputForm|))
           '#() 'NIL
           (CONS
            (|makeByteWordVec2| 25
                                '(0 0 0 1 0 0 0 7 0 0 0 0 0 0 7 0 0 0 0 0 3 4
                                  15 16 17 0 0 0 0 0 0 0 0 0 0 0 7 0 0 0 0 0 0
                                  0 7 0 7 0 0 0 7 0 0 0 0 0 9 0 0 0 25 11 20 21
                                  0 0 0 0 2 6 10 10 13 0 0 0 0 0 0 0 0 0 2 5 6
                                  6 8 10 10 12 13 14 18 19))
            (CONS
             '#(|QuotientFieldCategory&| |Field&| |EuclideanDomain&|
                |PolynomialFactorizationExplicit&| NIL
                |UniqueFactorizationDomain&| |GcdDomain&| NIL NIL
                |FullyLinearlyExplicitOver&| |DifferentialExtension&|
                |DivisionRing&| NIL NIL |OrderedRing&| NIL |Algebra&|
                |Algebra&| |EntireRing&| |Algebra&| NIL NIL
                |PartialDifferentialRing&| |DifferentialRing&| NIL NIL |Rng&|
                NIL |Module&| |Module&| |Module&| NIL NIL NIL NIL
                |NonAssociativeRing&| NIL NIL NIL NIL NIL NIL
                |NonAssociativeRng&| NIL NIL |AbelianGroup&| NIL NIL NIL NIL
                NIL NIL NIL |MagmaWithUnit&| |NonAssociativeSemiRng&|
                |AbelianMonoid&| |OrderedSet&| |FullyEvalableOver&| |Magma&|
                |AbelianSemiGroup&| NIL NIL NIL NIL NIL |RetractableTo&| NIL
                |SetCategory&| |RetractableTo&| NIL |RetractableTo&|
                |RetractableTo&| |Evalable&| NIL NIL NIL NIL NIL NIL NIL
                |BasicType&| NIL NIL NIL NIL NIL |PartialOrder&| NIL NIL
                |InnerEvalable&| |InnerEvalable&| NIL NIL NIL)
             (CONS
              '#((|QuotientFieldCategory| (|PAdicInteger| 6)) (|Field|)
                 (|EuclideanDomain|) (|PolynomialFactorizationExplicit|)
                 (|PrincipalIdealDomain|) (|UniqueFactorizationDomain|)
                 (|GcdDomain|) (|OrderedIntegralDomain|) (|IntegralDomain|)
                 (|FullyLinearlyExplicitOver| (|PAdicInteger| 6))
                 (|DifferentialExtension| (|PAdicInteger| 6)) (|DivisionRing|)
                 (|CommutativeRing|) (|LeftOreRing|) (|OrderedRing|)
                 (|LinearlyExplicitOver| (|PAdicInteger| 6))
                 (|Algebra| (|PAdicInteger| 6)) (|Algebra| 36) (|EntireRing|)
                 (|Algebra| $$) (|CharacteristicNonZero|)
                 (|CharacteristicZero|) (|PartialDifferentialRing| 19)
                 (|DifferentialRing|) (|LinearlyExplicitOver| 24) (|Ring|)
                 (|Rng|) (|SemiRing|) (|Module| (|PAdicInteger| 6))
                 (|Module| 36) (|Module| $$) (|SemiRng|)
                 (|BiModule| (|PAdicInteger| 6) (|PAdicInteger| 6))
                 (|BiModule| 36 36) (|BiModule| $$ $$) (|NonAssociativeRing|)
                 (|OrderedAbelianGroup|) (|RightModule| (|PAdicInteger| 6))
                 (|LeftModule| (|PAdicInteger| 6)) (|RightModule| 36)
                 (|LeftModule| 36) (|LeftModule| $$) (|NonAssociativeRng|)
                 (|RightModule| $$) (|OrderedCancellationAbelianMonoid|)
                 (|AbelianGroup|) (|OrderedAbelianMonoid|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|OrderedAbelianSemiGroup|)
                 (|FullyPatternMatchable| (|PAdicInteger| 6)) (|SemiGroup|)
                 (|MagmaWithUnit|) (|NonAssociativeSemiRng|) (|AbelianMonoid|)
                 (|OrderedSet|) (|FullyEvalableOver| (|PAdicInteger| 6))
                 (|Magma|) (|AbelianSemiGroup|) (|Comparable|) (|StepThrough|)
                 (|PatternMatchable| 33) (|PatternMatchable| 24)
                 (|Patternable| (|PAdicInteger| 6))
                 (|RetractableTo| (|PAdicInteger| 6)) (|CommutativeStar|)
                 (|SetCategory|) (|RetractableTo| 19) (|RealConstant|)
                 (|RetractableTo| 36) (|RetractableTo| 24)
                 (|Evalable| (|PAdicInteger| 6)) (|Type|)
                 (|CoercibleFrom| (|PAdicInteger| 6)) (|canonicalsClosed|)
                 (|canonicalUnitNormal|) (|noZeroDivisors|) (|TwoSidedRecip|)
                 (|unitsKnown|) (|BasicType|) (|CoercibleTo| 57)
                 (|CoercibleFrom| 19) (|ConvertibleTo| 11) (|ConvertibleTo| 32)
                 (|ConvertibleTo| 33) (|PartialOrder|) (|CoercibleFrom| 36)
                 (|CoercibleFrom| 24) (|InnerEvalable| 19 (|PAdicInteger| 6))
                 (|InnerEvalable| (|PAdicInteger| 6) (|PAdicInteger| 6))
                 (|Eltable| (|PAdicInteger| 6) $$) (|ConvertibleTo| 12)
                 (|ConvertibleTo| 13))
              (|makeByteWordVec2| -999999 'NIL))))
           '|lookupIncomplete|)) 
