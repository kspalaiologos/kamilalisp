
(SDEFUN |LODO2;elt;$2M;1| ((|p| ($)) (|m| (M)) ($ (M)))
        (SPADCALL |p| (ELT $ 9) |m| (QREFELT $ 12))) 

(DECLAIM (NOTINLINE |LinearOrdinaryDifferentialOperator2;|)) 

(DEFUN |LinearOrdinaryDifferentialOperator2| (&REST #1=#:G739)
  (SPROG NIL
         (PROG (#2=#:G740)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|LinearOrdinaryDifferentialOperator2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |LinearOrdinaryDifferentialOperator2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|LinearOrdinaryDifferentialOperator2|)))))))))) 

(DEFUN |LinearOrdinaryDifferentialOperator2;| (|#1| |#2|)
  (SPROG
   ((|pv$| NIL) (#1=#:G738 NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT |dv$| (LIST '|LinearOrdinaryDifferentialOperator2| DV$1 DV$2))
    (LETT $ (GETREFV 48))
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
                                        (|HasCategory| |#1| '(|EntireRing|))
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
                                        (|HasCategory| |#1| '(|Comparable|))
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
                                         (|HasCategory| |#1| '(|EntireRing|))
                                         (|HasCategory| |#1| '(|Ring|)))
                                        (|HasCategory| |#1| '(|AbelianGroup|))
                                        (|HasCategory| |#1| '(|SemiRing|))
                                        (|HasCategory| (|NonNegativeInteger|)
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
                                        (|HasCategory| |#1| '(|GcdDomain|))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#1| '(|Ring|)))
                                        (|HasCategory| |#1| '(|AbelianMonoid|))
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
                                         (|HasCategory| |#1| '(|AbelianGroup|))
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         #1#)
                                        (OR
                                         (|HasCategory| |#1| '(|AbelianGroup|))
                                         #1#)
                                        (|HasCategory| |#1| '(|Field|))))))
    (|haddProp| |$ConstructorCache| '|LinearOrdinaryDifferentialOperator2|
                (LIST DV$1 DV$2) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
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

(MAKEPROP '|LinearOrdinaryDifferentialOperator2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL
              (|LinearOrdinaryDifferentialOperator| 6 (NRTEVAL (ELT $ 8)))
              (|local| |#1|) (|local| |#2|) (0 . |differentiate|)
              (5 . |differentiate|) (|Mapping| 7 7)
              (|ApplyUnivariateSkewPolynomial| 6 7 $$) (10 . |apply|)
              |LODO2;elt;$2M;1| (|Matrix| 18) (|Matrix| $)
              (|Record| (|:| |mat| 14) (|:| |vec| (|Vector| 18))) (|Vector| $)
              (|Integer|) (|Boolean|) (|NonNegativeInteger|)
              (|Union| $ '"failed")
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Fraction| 18) (|Record| (|:| |k| 20) (|:| |c| 6)) (|List| 24)
              (|Mapping| 6 20)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |generator| $) (|:| |coef1| $) (|:| |coef2| $)
                        (|:| |coefu| $) (|:| |coefv| $))
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Union| 23 '#1="failed") (|Union| 18 '#1#)
              (|Record| (|:| |mat| 33) (|:| |vec| (|Vector| 6))) (|Matrix| 6)
              (|List| $) (|List| 36) (|SingletonAsOrderedSet|) (|List| 20)
              (|Union| 36 '"failed") (|Mapping| 20 20) (|Union| 6 '#1#)
              (|List| 6) (|Mapping| 6 6) (|PositiveInteger|) (|HashState|)
              (|String|) (|OutputForm|) (|SingleInteger|))
           '#(|elt| 17) 'NIL
           (CONS
            (|makeByteWordVec2| 23
                                '(0 0 0 0 0 10 1 2 3 4 10 11 5 12 0 12 14 0 0 1
                                  5 0 0 0 1 10 0 0 0 0 0 1 1 12 13 23 14 14 0 0
                                  22 14 0 0 0 9 0 0 6 7 0 0 0 0 0 4 6 7 8 10))
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
                |RetractableTo&| NIL NIL NIL |BasicType&| NIL NIL NIL NIL NIL
                NIL)
             (CONS
              '#((|LinearOrdinaryDifferentialOperatorCategory| 6)
                 (|UnivariateSkewPolynomialCategory| 6)
                 (|MaybeSkewPolynomialCategory| 6 20 36)
                 (|FiniteAbelianMonoidRing| 6 20) (|AbelianMonoidRing| 6 20)
                 (|FullyLinearlyExplicitOver| 6) (|Algebra| 23)
                 (|CharacteristicNonZero|) (|CharacteristicZero|)
                 (|EntireRing|) (|LinearlyExplicitOver| 6)
                 (|LinearlyExplicitOver| 18) (|Algebra| 6) (|Ring|)
                 (|FreeModuleCategory| 6 20) (|Rng|) (|SemiRing|) (|SemiRng|)
                 (|IndexedDirectProductCategory| 6 20) (|Module| 23)
                 (|Module| 6) (|IndexedProductCategory| 6 20) (|BiModule| 6 6)
                 (|BiModule| $$ $$) (|BiModule| 23 23) (|NonAssociativeRing|)
                 (|AbelianProductCategory| 6) (|LeftModule| 6)
                 (|RightModule| 6) (|RightModule| $$) (|LeftModule| $$)
                 (|LeftModule| 23) (|RightModule| 23) (|NonAssociativeRng|)
                 (|AbelianGroup|) (|CancellationAbelianMonoid|)
                 (|NonAssociativeSemiRing|) (|Monoid|)
                 (|NonAssociativeSemiRng|) (|SemiGroup|) (|AbelianMonoid|)
                 (|MagmaWithUnit|) (|FullyRetractableTo| 6) (|Magma|)
                 (|AbelianSemiGroup|) (|Comparable|) (|RetractableTo| 6)
                 (|SetCategory|) (|RetractableTo| 23) (|RetractableTo| 18)
                 (|Eltable| 7 7) (|Eltable| 6 6) (|CoercibleFrom| 6)
                 (|BasicType|) (|CoercibleTo| 46) (|noZeroDivisors|)
                 (|CoercibleFrom| 23) (|CoercibleFrom| 18)
                 (|canonicalUnitNormal|) (|unitsKnown|))
              (|makeByteWordVec2| 13
                                  '(1 6 0 0 8 1 7 0 0 9 3 11 7 2 10 7 12 2 0 7
                                    0 7 13)))))
           '|lookupIncomplete|)) 
