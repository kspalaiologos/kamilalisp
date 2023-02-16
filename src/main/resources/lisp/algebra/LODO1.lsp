
(DECLAIM (NOTINLINE |LinearOrdinaryDifferentialOperator1;|)) 

(DEFUN |LinearOrdinaryDifferentialOperator1| (#1=#:G737)
  (SPROG NIL
         (PROG (#2=#:G738)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|LinearOrdinaryDifferentialOperator1|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|LinearOrdinaryDifferentialOperator1;| #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|LinearOrdinaryDifferentialOperator1|)))))))))) 

(DEFUN |LinearOrdinaryDifferentialOperator1;| (|#1|)
  (SPROG ((|pv$| NIL) (#1=#:G736 NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|LinearOrdinaryDifferentialOperator1| DV$1))
          (LETT $ (GETREFV 42))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|Algebra|
                                                               (|Fraction|
                                                                (|Integer|))))
                                              (|HasCategory| |#1|
                                                             '(|CharacteristicNonZero|))
                                              (|HasCategory| |#1|
                                                             '(|CharacteristicZero|))
                                              (|HasCategory| |#1|
                                                             '(|EntireRing|))
                                              (|HasCategory| |#1|
                                                             '(|CommutativeRing|))
                                              (|HasCategory| |#1|
                                                             '(|RetractableTo|
                                                               (|Fraction|
                                                                (|Integer|))))
                                              (|HasCategory| |#1|
                                                             '(|RetractableTo|
                                                               (|Integer|)))
                                              (|HasCategory| |#1|
                                                             '(|canonicalUnitNormal|))
                                              (|HasCategory| |#1|
                                                             '(|Comparable|))
                                              (|HasCategory| |#1| '(|Ring|))
                                              (|HasCategory| |#1|
                                                             '(|LinearlyExplicitOver|
                                                               (|Integer|)))
                                              (OR
                                               (|HasCategory| |#1|
                                                              '(|Algebra|
                                                                (|Fraction|
                                                                 (|Integer|))))
                                               (|HasCategory| |#1|
                                                              '(|LinearlyExplicitOver|
                                                                (|Integer|)))
                                               (|HasCategory| |#1|
                                                              '(|CharacteristicNonZero|))
                                               (|HasCategory| |#1|
                                                              '(|CharacteristicZero|))
                                               (|HasCategory| |#1|
                                                              '(|CommutativeRing|))
                                               (|HasCategory| |#1|
                                                              '(|EntireRing|))
                                               (|HasCategory| |#1| '(|Ring|)))
                                              (|HasCategory| |#1|
                                                             '(|AbelianGroup|))
                                              (|HasCategory| |#1|
                                                             '(|SemiRing|))
                                              (|HasCategory|
                                               (|NonNegativeInteger|)
                                               '(|Comparable|))
                                              (|HasCategory| |#1|
                                                             '(|IntegralDomain|))
                                              (OR
                                               (|HasCategory| |#1|
                                                              '(|Algebra|
                                                                (|Fraction|
                                                                 (|Integer|))))
                                               (|HasCategory| |#1|
                                                              '(|RetractableTo|
                                                                (|Fraction|
                                                                 (|Integer|)))))
                                              (|HasCategory| |#1|
                                                             '(|GcdDomain|))
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|LinearlyExplicitOver|
                                                                (|Integer|)))
                                               (|HasCategory| |#1| '(|Ring|)))
                                              (|HasCategory| |#1|
                                                             '(|AbelianMonoid|))
                                              (LETT #1#
                                                    (|HasCategory| |#1|
                                                                   '(|CancellationAbelianMonoid|)))
                                              (OR
                                               (AND
                                                (|HasCategory| |#1|
                                                               '(|Algebra|
                                                                 (|Fraction|
                                                                  (|Integer|))))
                                                (|HasCategory|
                                                 (|Fraction| (|Integer|))
                                                 '(|AbelianMonoid|)))
                                               (|HasCategory| |#1|
                                                              '(|AbelianGroup|))
                                               (|HasCategory| |#1|
                                                              '(|AbelianMonoid|))
                                               #1#)
                                              (OR
                                               (|HasCategory| |#1|
                                                              '(|AbelianGroup|))
                                               #1#)
                                              (|HasCategory| |#1|
                                                             '(|Field|))))))
          (|haddProp| |$ConstructorCache|
                      '|LinearOrdinaryDifferentialOperator1| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (AND
           (OR
            (AND (|HasCategory| |#1| '(|CommutativeRing|))
                 (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
            (AND (|HasCategory| |#1| '(|IntegralDomain|))
                 (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
           (|augmentPredVector| $ 16777216))
          (AND (|HasCategory| $ '(|CommutativeRing|))
               (|augmentPredVector| $ 33554432))
          (AND
           (OR (|HasCategory| |#1| '(|EntireRing|))
               (AND (|HasCategory| |#1| '(|IntegralDomain|))
                    (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
           (|augmentPredVector| $ 67108864))
          (AND
           (OR (|HasCategory| |#1| '(|RetractableTo| (|Integer|)))
               (AND (|HasCategory| |#1| '(|CommutativeRing|))
                    (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
               (AND (|HasCategory| |#1| '(|IntegralDomain|))
                    (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
               (|HasCategory| |#1| '(|Ring|)))
           (|augmentPredVector| $ 134217728))
          (AND
           (OR
            (AND (|HasCategory| |#1| '(|CommutativeRing|))
                 (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
            (AND (|HasCategory| |#1| '(|IntegralDomain|))
                 (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
            (|HasCategory| |#1| '(|SemiRing|)))
           (|augmentPredVector| $ 268435456))
          (AND
           (OR
            (AND (|HasCategory| |#1| '(|CommutativeRing|))
                 (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
            (AND (|HasCategory| |#1| '(|IntegralDomain|))
                 (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
            (|HasCategory| |#1| '(|Ring|)))
           (|augmentPredVector| $ 536870912))
          (AND
           (OR (|HasCategory| |#1| '(|AbelianMonoid|))
               (AND (|HasCategory| |#1| '(|CommutativeRing|))
                    (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
               (AND (|HasCategory| |#1| '(|IntegralDomain|))
                    (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
               (|HasCategory| $ '(|AbelianMonoid|)))
           (|augmentPredVector| $ 1073741824))
          (AND
           (OR
            (AND (|HasCategory| |#1| '(|AbelianGroup|))
                 (|HasCategory| |#1| '(|CommutativeRing|)))
            #1#
            (AND (|HasCategory| |#1| '(|CommutativeRing|))
                 (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
            (AND (|HasCategory| |#1| '(|IntegralDomain|))
                 (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
            (|HasCategory| $ '(|AbelianGroup|)))
           (|augmentPredVector| $ 2147483648))
          (AND
           (OR (|HasCategory| |#1| '(|AbelianGroup|))
               (AND (|HasCategory| |#1| '(|CommutativeRing|))
                    (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
               (AND (|HasCategory| |#1| '(|IntegralDomain|))
                    (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
               (|HasCategory| $ '(|AbelianGroup|)))
           (|augmentPredVector| $ 4294967296))
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|LinearOrdinaryDifferentialOperator1| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL
              (|LinearOrdinaryDifferentialOperator| 6 (NRTEVAL (ELT $ 7)))
              (|local| |#1|) (0 . |differentiate|) (|Matrix| 12) (|Matrix| $)
              (|Record| (|:| |mat| 8) (|:| |vec| (|Vector| 12))) (|Vector| $)
              (|Integer|) (|Boolean|) (|NonNegativeInteger|)
              (|Union| $ '"failed")
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Fraction| 12) (|Record| (|:| |k| 14) (|:| |c| 6)) (|List| 18)
              (|Mapping| 6 14)
              (|Record| (|:| |generator| $) (|:| |coef1| $) (|:| |coef2| $)
                        (|:| |coefu| $) (|:| |coefv| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Union| 17 '#1="failed") (|Union| 12 '#1#)
              (|Record| (|:| |mat| 27) (|:| |vec| (|Vector| 6))) (|Matrix| 6)
              (|List| $) (|List| 30) (|SingletonAsOrderedSet|) (|List| 14)
              (|Union| 30 '"failed") (|Mapping| 14 14) (|Union| 6 '#1#)
              (|List| 6) (|Mapping| 6 6) (|PositiveInteger|) (|HashState|)
              (|String|) (|OutputForm|) (|SingleInteger|))
           '#() 'NIL
           (CONS
            (|makeByteWordVec2| 23
                                '(0 0 0 0 0 10 1 2 3 4 10 11 5 12 0 12 14 0 0 1
                                  5 0 0 0 1 10 0 0 0 0 0 1 1 12 13 23 14 14 0 0
                                  22 14 0 0 0 9 0 0 6 7 0 0 0 0 4 6 7 8 10))
            (CONS
             '#(|LinearOrdinaryDifferentialOperatorCategory&|
                |UnivariateSkewPolynomialCategory&|
                |MaybeSkewPolynomialCategory&| |FiniteAbelianMonoidRing&|
                |AbelianMonoidRing&| |FullyLinearlyExplicitOver&| |Algebra&|
                NIL NIL |EntireRing&| NIL NIL |Algebra&| NIL
                |FreeModuleCategory&| |Rng&| NIL NIL NIL |Module&| |Module&|
                NIL NIL NIL NIL |NonAssociativeRing&| NIL NIL NIL NIL NIL NIL
                NIL |NonAssociativeRng&| |AbelianGroup&| NIL NIL NIL
                |NonAssociativeSemiRng&| NIL |AbelianMonoid&| |MagmaWithUnit&|
                |FullyRetractableTo&| |Magma&| |AbelianSemiGroup&| NIL
                |RetractableTo&| |SetCategory&| |RetractableTo&|
                |RetractableTo&| NIL NIL |BasicType&| NIL NIL NIL NIL NIL NIL)
             (CONS
              '#((|LinearOrdinaryDifferentialOperatorCategory| 6)
                 (|UnivariateSkewPolynomialCategory| 6)
                 (|MaybeSkewPolynomialCategory| 6 14 30)
                 (|FiniteAbelianMonoidRing| 6 14) (|AbelianMonoidRing| 6 14)
                 (|FullyLinearlyExplicitOver| 6) (|Algebra| 17)
                 (|CharacteristicNonZero|) (|CharacteristicZero|)
                 (|EntireRing|) (|LinearlyExplicitOver| 6)
                 (|LinearlyExplicitOver| 12) (|Algebra| 6) (|Ring|)
                 (|FreeModuleCategory| 6 14) (|Rng|) (|SemiRing|) (|SemiRng|)
                 (|IndexedDirectProductCategory| 6 14) (|Module| 17)
                 (|Module| 6) (|IndexedProductCategory| 6 14) (|BiModule| 6 6)
                 (|BiModule| $$ $$) (|BiModule| 17 17) (|NonAssociativeRing|)
                 (|AbelianProductCategory| 6) (|LeftModule| 6)
                 (|RightModule| 6) (|RightModule| $$) (|LeftModule| $$)
                 (|LeftModule| 17) (|RightModule| 17) (|NonAssociativeRng|)
                 (|AbelianGroup|) (|CancellationAbelianMonoid|)
                 (|NonAssociativeSemiRing|) (|Monoid|)
                 (|NonAssociativeSemiRng|) (|SemiGroup|) (|AbelianMonoid|)
                 (|MagmaWithUnit|) (|FullyRetractableTo| 6) (|Magma|)
                 (|AbelianSemiGroup|) (|Comparable|) (|RetractableTo| 6)
                 (|SetCategory|) (|RetractableTo| 17) (|RetractableTo| 12)
                 (|Eltable| 6 6) (|CoercibleFrom| 6) (|BasicType|)
                 (|CoercibleTo| 40) (|noZeroDivisors|) (|CoercibleFrom| 17)
                 (|CoercibleFrom| 12) (|canonicalUnitNormal|) (|unitsKnown|))
              (|makeByteWordVec2| 7 '(1 6 0 0 7)))))
           '|lookupIncomplete|)) 
