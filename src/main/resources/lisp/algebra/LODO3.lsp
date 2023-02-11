
(DECLAIM (NOTINLINE |LinearOrdinaryDifferentialOperator3;|)) 

(DEFUN |LinearOrdinaryDifferentialOperator3| (&REST #1=#:G737)
  (SPROG NIL
         (PROG (#2=#:G738)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|LinearOrdinaryDifferentialOperator3|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |LinearOrdinaryDifferentialOperator3;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|LinearOrdinaryDifferentialOperator3|)))))))))) 

(DEFUN |LinearOrdinaryDifferentialOperator3;| (|#1| |#2| |#3|)
  (SPROG
   ((|pv$| NIL) (#1=#:G736 NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT |dv$| (LIST '|LinearOrdinaryDifferentialOperator3| DV$1 DV$2 DV$3))
    (LETT $ (GETREFV 45))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#3|
                                                       '(|Algebra|
                                                         (|Fraction|
                                                          (|Integer|))))
                                        (|HasCategory| |#3|
                                                       '(|CharacteristicNonZero|))
                                        (|HasCategory| |#3|
                                                       '(|CharacteristicZero|))
                                        (|HasCategory| |#3| '(|EntireRing|))
                                        (|HasCategory| |#3|
                                                       '(|CommutativeRing|))
                                        (|HasCategory| |#3|
                                                       '(|RetractableTo|
                                                         (|Fraction|
                                                          (|Integer|))))
                                        (|HasCategory| |#3|
                                                       '(|RetractableTo|
                                                         (|Integer|)))
                                        (|HasCategory| |#3|
                                                       '(|canonicalUnitNormal|))
                                        (|HasCategory| |#3| '(|Comparable|))
                                        (|HasCategory| |#3| '(|Ring|))
                                        (|HasCategory| |#3|
                                                       '(|LinearlyExplicitOver|
                                                         (|Integer|)))
                                        (OR
                                         (|HasCategory| |#3|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasCategory| |#3|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#3|
                                                        '(|CharacteristicNonZero|))
                                         (|HasCategory| |#3|
                                                        '(|CharacteristicZero|))
                                         (|HasCategory| |#3|
                                                        '(|CommutativeRing|))
                                         (|HasCategory| |#3| '(|EntireRing|))
                                         (|HasCategory| |#3| '(|Ring|)))
                                        (|HasCategory| |#3| '(|AbelianGroup|))
                                        (|HasCategory| |#3| '(|SemiRing|))
                                        (|HasCategory| (|NonNegativeInteger|)
                                                       '(|Comparable|))
                                        (|HasCategory| |#3|
                                                       '(|IntegralDomain|))
                                        (OR
                                         (|HasCategory| |#3|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasCategory| |#3|
                                                        '(|RetractableTo|
                                                          (|Fraction|
                                                           (|Integer|)))))
                                        (|HasCategory| |#3| '(|GcdDomain|))
                                        (AND
                                         (|HasCategory| |#3|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#3| '(|Ring|)))
                                        (|HasCategory| |#3| '(|AbelianMonoid|))
                                        (LETT #1#
                                              (|HasCategory| |#3|
                                                             '(|CancellationAbelianMonoid|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#3|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory|
                                           (|Fraction| (|Integer|))
                                           '(|AbelianMonoid|)))
                                         (|HasCategory| |#3| '(|AbelianGroup|))
                                         (|HasCategory| |#3|
                                                        '(|AbelianMonoid|))
                                         #1#)
                                        (OR
                                         (|HasCategory| |#3| '(|AbelianGroup|))
                                         #1#)
                                        (|HasCategory| |#3| '(|Field|))))))
    (|haddProp| |$ConstructorCache| '|LinearOrdinaryDifferentialOperator3|
                (LIST DV$1 DV$2 DV$3) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (AND
     (OR
      (AND (|HasCategory| |#3| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND (|HasCategory| |#3| '(|IntegralDomain|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 16777216))
    (AND (|HasCategory| $ '(|CommutativeRing|))
         (|augmentPredVector| $ 33554432))
    (AND
     (OR (|HasCategory| |#3| '(|EntireRing|))
         (AND (|HasCategory| |#3| '(|IntegralDomain|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 67108864))
    (AND
     (OR (|HasCategory| |#3| '(|RetractableTo| (|Integer|)))
         (AND (|HasCategory| |#3| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND (|HasCategory| |#3| '(|IntegralDomain|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| |#3| '(|Ring|)))
     (|augmentPredVector| $ 134217728))
    (AND
     (OR
      (AND (|HasCategory| |#3| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND (|HasCategory| |#3| '(|IntegralDomain|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| |#3| '(|SemiRing|)))
     (|augmentPredVector| $ 268435456))
    (AND
     (OR
      (AND (|HasCategory| |#3| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND (|HasCategory| |#3| '(|IntegralDomain|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| |#3| '(|Ring|)))
     (|augmentPredVector| $ 536870912))
    (AND
     (OR (|HasCategory| |#3| '(|AbelianMonoid|))
         (AND (|HasCategory| |#3| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND (|HasCategory| |#3| '(|IntegralDomain|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianMonoid|)))
     (|augmentPredVector| $ 1073741824))
    (AND
     (OR
      (AND (|HasCategory| |#3| '(|AbelianGroup|))
           (|HasCategory| |#3| '(|CommutativeRing|)))
      #1#
      (AND (|HasCategory| |#3| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND (|HasCategory| |#3| '(|IntegralDomain|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| $ '(|AbelianGroup|)))
     (|augmentPredVector| $ 2147483648))
    (AND
     (OR (|HasCategory| |#3| '(|AbelianGroup|))
         (AND (|HasCategory| |#3| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND (|HasCategory| |#3| '(|IntegralDomain|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianGroup|)))
     (|augmentPredVector| $ 4294967296))
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|LinearOrdinaryDifferentialOperator3| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL
              (|LinearOrdinaryDifferentialOperator| 8 (NRTEVAL (ELT $ 10)))
              (|local| |#1|) (|local| |#2|) (|local| |#3|)
              (|LinearOrdinaryDifferentialOperator3Aux| 6 7 8)
              (0 . |delta_deriv|) (|Matrix| 15) (|Matrix| $)
              (|Record| (|:| |mat| 11) (|:| |vec| (|Vector| 15))) (|Vector| $)
              (|Integer|) (|Boolean|) (|NonNegativeInteger|)
              (|Union| $ '"failed")
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Fraction| 15) (|Record| (|:| |k| 17) (|:| |c| 8)) (|List| 21)
              (|Mapping| 8 17)
              (|Record| (|:| |generator| $) (|:| |coef1| $) (|:| |coef2| $)
                        (|:| |coefu| $) (|:| |coefv| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Union| 20 '#1="failed") (|Union| 15 '#1#)
              (|Record| (|:| |mat| 30) (|:| |vec| (|Vector| 8))) (|Matrix| 8)
              (|List| $) (|List| 33) (|SingletonAsOrderedSet|) (|List| 17)
              (|Union| 33 '"failed") (|Mapping| 17 17) (|Union| 8 '#1#)
              (|List| 8) (|Mapping| 8 8) (|PositiveInteger|) (|HashState|)
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
              '#((|LinearOrdinaryDifferentialOperatorCategory| 8)
                 (|UnivariateSkewPolynomialCategory| 8)
                 (|MaybeSkewPolynomialCategory| 8 17 33)
                 (|FiniteAbelianMonoidRing| 8 17) (|AbelianMonoidRing| 8 17)
                 (|FullyLinearlyExplicitOver| 8) (|Algebra| 20)
                 (|CharacteristicNonZero|) (|CharacteristicZero|)
                 (|EntireRing|) (|LinearlyExplicitOver| 8)
                 (|LinearlyExplicitOver| 15) (|Algebra| 8) (|Ring|)
                 (|FreeModuleCategory| 8 17) (|Rng|) (|SemiRing|) (|SemiRng|)
                 (|IndexedDirectProductCategory| 8 17) (|Module| 20)
                 (|Module| 8) (|IndexedProductCategory| 8 17) (|BiModule| 8 8)
                 (|BiModule| $$ $$) (|BiModule| 20 20) (|NonAssociativeRing|)
                 (|AbelianProductCategory| 8) (|LeftModule| 8)
                 (|RightModule| 8) (|RightModule| $$) (|LeftModule| $$)
                 (|LeftModule| 20) (|RightModule| 20) (|NonAssociativeRng|)
                 (|AbelianGroup|) (|CancellationAbelianMonoid|)
                 (|NonAssociativeSemiRing|) (|Monoid|)
                 (|NonAssociativeSemiRng|) (|SemiGroup|) (|AbelianMonoid|)
                 (|MagmaWithUnit|) (|FullyRetractableTo| 8) (|Magma|)
                 (|AbelianSemiGroup|) (|Comparable|) (|RetractableTo| 8)
                 (|SetCategory|) (|RetractableTo| 20) (|RetractableTo| 15)
                 (|Eltable| 8 8) (|CoercibleFrom| 8) (|BasicType|)
                 (|CoercibleTo| 43) (|noZeroDivisors|) (|CoercibleFrom| 20)
                 (|CoercibleFrom| 15) (|canonicalUnitNormal|) (|unitsKnown|))
              (|makeByteWordVec2| 10 '(1 9 8 8 10)))))
           '|lookupIncomplete|)) 
