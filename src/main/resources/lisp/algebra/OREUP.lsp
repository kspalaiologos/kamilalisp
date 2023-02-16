
(SDEFUN |OREUP;coerce;V$;1| ((|v| (|Variable| |x|)) ($ ($)))
        (SPADCALL (|spadConstant| $ 14) 1 (QREFELT $ 16))) 

(SDEFUN |OREUP;coerce;$Of;2| ((|p| ($)) ($ (|OutputForm|)))
        (SPADCALL |p| (SPADCALL (QREFELT $ 6) (QREFELT $ 21)) (QREFELT $ 22))) 

(DECLAIM (NOTINLINE |UnivariateSkewPolynomial;|)) 

(DEFUN |UnivariateSkewPolynomial| (&REST #1=#:G741)
  (SPROG NIL
         (PROG (#2=#:G742)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(NIL T NIL NIL))
                     (HGET |$ConstructorCache| '|UnivariateSkewPolynomial|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |UnivariateSkewPolynomial;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|UnivariateSkewPolynomial|)))))))))) 

(DEFUN |UnivariateSkewPolynomial;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) (#1=#:G740 NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL)
    (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 |#1|)
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 |#3|)
    (LETT DV$4 |#4|)
    (LETT |dv$| (LIST '|UnivariateSkewPolynomial| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 56))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#2|
                                                       '(|Algebra|
                                                         (|Fraction|
                                                          (|Integer|))))
                                        (|HasCategory| |#2|
                                                       '(|CharacteristicNonZero|))
                                        (|HasCategory| |#2|
                                                       '(|CharacteristicZero|))
                                        (|HasCategory| |#2| '(|EntireRing|))
                                        (|HasCategory| |#2|
                                                       '(|CommutativeRing|))
                                        (|HasCategory| |#2|
                                                       '(|RetractableTo|
                                                         (|Fraction|
                                                          (|Integer|))))
                                        (|HasCategory| |#2|
                                                       '(|RetractableTo|
                                                         (|Integer|)))
                                        (|HasCategory| |#2|
                                                       '(|canonicalUnitNormal|))
                                        (|HasCategory| |#2| '(|Comparable|))
                                        (|HasCategory| |#2| '(|Ring|))
                                        (|HasCategory| |#2|
                                                       '(|LinearlyExplicitOver|
                                                         (|Integer|)))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasCategory| |#2|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#2|
                                                        '(|CharacteristicNonZero|))
                                         (|HasCategory| |#2|
                                                        '(|CharacteristicZero|))
                                         (|HasCategory| |#2|
                                                        '(|CommutativeRing|))
                                         (|HasCategory| |#2| '(|EntireRing|))
                                         (|HasCategory| |#2| '(|Ring|)))
                                        (|HasCategory| |#2| '(|AbelianGroup|))
                                        (|HasCategory| |#2| '(|SemiRing|))
                                        (|HasCategory| (|NonNegativeInteger|)
                                                       '(|Comparable|))
                                        (|HasCategory| |#2|
                                                       '(|IntegralDomain|))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasCategory| |#2|
                                                        '(|RetractableTo|
                                                          (|Fraction|
                                                           (|Integer|)))))
                                        (|HasCategory| |#2| '(|GcdDomain|))
                                        (AND
                                         (|HasCategory| |#2|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#2| '(|Ring|)))
                                        (|HasCategory| |#2| '(|Field|))
                                        (|HasCategory| |#2| '(|AbelianMonoid|))
                                        (LETT #1#
                                              (|HasCategory| |#2|
                                                             '(|CancellationAbelianMonoid|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory|
                                           (|Fraction| (|Integer|))
                                           '(|AbelianMonoid|)))
                                         (|HasCategory| |#2| '(|AbelianGroup|))
                                         (|HasCategory| |#2|
                                                        '(|AbelianMonoid|))
                                         #1#)
                                        (OR
                                         (|HasCategory| |#2| '(|AbelianGroup|))
                                         #1#)))))
    (|haddProp| |$ConstructorCache| '|UnivariateSkewPolynomial|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (AND
     (OR
      (AND (|HasCategory| |#2| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND (|HasCategory| |#2| '(|IntegralDomain|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 16777216))
    (AND (|HasCategory| $ '(|CommutativeRing|))
         (|augmentPredVector| $ 33554432))
    (AND
     (OR (|HasCategory| |#2| '(|EntireRing|))
         (AND (|HasCategory| |#2| '(|IntegralDomain|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 67108864))
    (AND
     (OR (|HasCategory| |#2| '(|RetractableTo| (|Integer|)))
         (AND (|HasCategory| |#2| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND (|HasCategory| |#2| '(|IntegralDomain|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| |#2| '(|Ring|)))
     (|augmentPredVector| $ 134217728))
    (AND
     (OR
      (AND (|HasCategory| |#2| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND (|HasCategory| |#2| '(|IntegralDomain|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| |#2| '(|SemiRing|)))
     (|augmentPredVector| $ 268435456))
    (AND
     (OR
      (AND (|HasCategory| |#2| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND (|HasCategory| |#2| '(|IntegralDomain|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| |#2| '(|Ring|)))
     (|augmentPredVector| $ 536870912))
    (AND
     (OR (|HasCategory| |#2| '(|AbelianMonoid|))
         (AND (|HasCategory| |#2| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND (|HasCategory| |#2| '(|IntegralDomain|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianMonoid|)))
     (|augmentPredVector| $ 1073741824))
    (AND
     (OR
      (AND (|HasCategory| |#2| '(|AbelianGroup|))
           (|HasCategory| |#2| '(|CommutativeRing|)))
      #1#
      (AND (|HasCategory| |#2| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND (|HasCategory| |#2| '(|IntegralDomain|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| $ '(|AbelianGroup|)))
     (|augmentPredVector| $ 2147483648))
    (AND
     (OR (|HasCategory| |#2| '(|AbelianGroup|))
         (AND (|HasCategory| |#2| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND (|HasCategory| |#2| '(|IntegralDomain|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianGroup|)))
     (|augmentPredVector| $ 4294967296))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 10 (|SparseUnivariateSkewPolynomial| |#2| |#3| |#4|))
    $))) 

(MAKEPROP '|UnivariateSkewPolynomial| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL
              (|SparseUnivariateSkewPolynomial| 7 (NRTEVAL (QREFELT $ 8))
                                                (NRTEVAL (QREFELT $ 9)))
              (|local| |#1|) (|local| |#2|) (|local| |#3|) (|local| |#4|)
              '|Rep| (|Automorphism| 7) (0 . |One|) (4 . |One|) (8 . |One|)
              (|NonNegativeInteger|) (12 . |monomial|)
              (|Variable| (NRTEVAL (QREFELT $ 6))) |OREUP;coerce;V$;1|
              (|Symbol|) (|OutputForm|) (18 . |outputForm|) (23 . |outputForm|)
              |OREUP;coerce;$Of;2|
              (|Record| (|:| |mat| 27) (|:| |vec| (|Vector| 28))) (|Matrix| $)
              (|Vector| $) (|Matrix| 28) (|Integer|) (|Boolean|)
              (|Union| $ '"failed")
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Fraction| 28) (|Record| (|:| |k| 15) (|:| |c| 7)) (|List| 33)
              (|Mapping| 7 15)
              (|Record| (|:| |generator| $) (|:| |coef1| $) (|:| |coef2| $)
                        (|:| |coefu| $) (|:| |coefv| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Union| 32 '#1="failed") (|Union| 28 '#1#)
              (|Record| (|:| |mat| 42) (|:| |vec| (|Vector| 7))) (|Matrix| 7)
              (|List| $) (|List| 47) (|List| 15) (|Union| 47 '"failed")
              (|SingletonAsOrderedSet|) (|Mapping| 15 15) (|Union| 7 '#1#)
              (|List| 7) (|Mapping| 7 7) (|PositiveInteger|) (|HashState|)
              (|String|) (|SingleInteger|))
           '#(~= 29 |zero?| 35 |variables| 40 |unitNormal| 45 |unitCanonical|
              50 |unit?| 55 |totalDegreeSorted| 60 |totalDegree| 66 |support|
              77 |subtractIfCan| 82 |smaller?| 88 |sample| 94
              |right_ext_ext_GCD| 98 |rightRemainder| 104 |rightRecip| 110
              |rightQuotient| 115 |rightPower| 121 |rightLcm| 133 |rightGcd|
              139 |rightExtendedGcd| 145 |rightExactQuotient| 151 |rightDivide|
              157 |retractIfCan| 163 |retract| 178 |reductum| 193
              |reducedSystem| 198 |recip| 220 |primitivePart| 225
              |primitiveMonomials| 230 |pomopo!| 235 |opposite?| 243 |one?| 249
              |numberOfMonomials| 254 |monomials| 259 |monomial?| 264
              |monomial| 269 |monicRightDivide| 289 |monicLeftDivide| 295
              |minimumDegree| 301 |mapExponents| 306 |map| 312 |mainVariable|
              318 |listOfTerms| 323 |linearExtend| 328 |leftRemainder| 334
              |leftRecip| 340 |leftQuotient| 345 |leftPower| 351 |leftLcm| 363
              |leftGcd| 369 |leftExtendedGcd| 375 |leftExactQuotient| 381
              |leftDivide| 387 |leadingTerm| 393 |leadingSupport| 398
              |leadingMonomial| 403 |leadingCoefficient| 408 |latex| 413
              |hashUpdate!| 418 |hash| 424 |ground?| 429 |ground| 434 |fmecg|
              439 |exquo| 447 |degree| 459 |content| 476 |constructOrdered| 481
              |construct| 486 |commutator| 491 |coerce| 497 |coefficients| 527
              |coefficient| 532 |charthRoot| 552 |characteristic| 557
              |binomThmExpt| 561 |associator| 568 |associates?| 575 |apply| 581
              |antiCommutator| 588 |annihilate?| 594 ^ 600 |Zero| 612 |One| 616
              = 620 / 626 - 632 + 643 * 649)
           'NIL
           (CONS
            (|makeByteWordVec2| 24
                                '(0 0 0 0 10 1 2 3 4 10 11 5 12 0 12 14 0 0 1 5
                                  0 0 0 1 10 0 0 0 0 0 1 1 12 13 24 14 14 0 0
                                  23 14 0 0 0 9 0 0 6 7 0 0 0 4 6 7 8 10))
            (CONS
             '#(|UnivariateSkewPolynomialCategory&|
                |MaybeSkewPolynomialCategory&| |FiniteAbelianMonoidRing&|
                |AbelianMonoidRing&| |FullyLinearlyExplicitOver&| |Algebra&|
                NIL NIL |EntireRing&| NIL NIL |Algebra&| NIL
                |FreeModuleCategory&| |Rng&| NIL NIL NIL |Module&| |Module&|
                NIL NIL NIL NIL |NonAssociativeRing&| NIL NIL NIL NIL NIL NIL
                NIL |NonAssociativeRng&| |AbelianGroup&| NIL NIL NIL
                |NonAssociativeSemiRng&| NIL |AbelianMonoid&| |MagmaWithUnit&|
                |FullyRetractableTo&| |Magma&| |AbelianSemiGroup&| NIL
                |RetractableTo&| |SetCategory&| |RetractableTo&|
                |RetractableTo&| NIL |BasicType&| NIL NIL NIL NIL NIL NIL)
             (CONS
              '#((|UnivariateSkewPolynomialCategory| 7)
                 (|MaybeSkewPolynomialCategory| 7 15 47)
                 (|FiniteAbelianMonoidRing| 7 15) (|AbelianMonoidRing| 7 15)
                 (|FullyLinearlyExplicitOver| 7) (|Algebra| 32)
                 (|CharacteristicNonZero|) (|CharacteristicZero|)
                 (|EntireRing|) (|LinearlyExplicitOver| 7)
                 (|LinearlyExplicitOver| 28) (|Algebra| 7) (|Ring|)
                 (|FreeModuleCategory| 7 15) (|Rng|) (|SemiRing|) (|SemiRng|)
                 (|IndexedDirectProductCategory| 7 15) (|Module| 32)
                 (|Module| 7) (|IndexedProductCategory| 7 15) (|BiModule| 7 7)
                 (|BiModule| $$ $$) (|BiModule| 32 32) (|NonAssociativeRing|)
                 (|AbelianProductCategory| 7) (|LeftModule| 7)
                 (|RightModule| 7) (|RightModule| $$) (|LeftModule| $$)
                 (|LeftModule| 32) (|RightModule| 32) (|NonAssociativeRng|)
                 (|AbelianGroup|) (|CancellationAbelianMonoid|)
                 (|NonAssociativeSemiRing|) (|Monoid|)
                 (|NonAssociativeSemiRng|) (|SemiGroup|) (|AbelianMonoid|)
                 (|MagmaWithUnit|) (|FullyRetractableTo| 7) (|Magma|)
                 (|AbelianSemiGroup|) (|Comparable|) (|RetractableTo| 7)
                 (|SetCategory|) (|RetractableTo| 32) (|RetractableTo| 28)
                 (|CoercibleFrom| 7) (|BasicType|) (|CoercibleTo| 20)
                 (|noZeroDivisors|) (|CoercibleFrom| 32) (|CoercibleFrom| 28)
                 (|canonicalUnitNormal|) (|unitsKnown|))
              (|makeByteWordVec2| 55
                                  '(0 11 0 12 0 0 0 13 0 7 0 14 2 0 0 7 15 16 1
                                    20 0 19 21 2 10 20 0 20 22 2 0 29 0 0 1 1
                                    31 29 0 1 1 0 44 0 1 1 27 31 0 1 1 27 0 0 1
                                    1 27 29 0 1 2 0 15 0 44 1 2 0 15 0 44 1 1 0
                                    15 0 1 1 0 45 0 1 2 32 30 0 0 1 2 9 29 0 0
                                    1 0 31 0 1 2 20 36 0 0 1 2 20 0 0 0 1 1 29
                                    30 0 1 2 20 0 0 0 1 2 29 0 0 15 1 2 0 0 0
                                    52 1 2 20 0 0 0 1 2 20 0 0 0 1 2 20 37 0 0
                                    1 2 20 30 0 0 1 2 20 38 0 0 1 1 6 39 0 1 1
                                    7 40 0 1 1 0 49 0 1 1 6 32 0 1 1 7 28 0 1 1
                                    0 7 0 1 1 15 0 0 1 2 19 24 25 26 1 1 19 27
                                    25 1 2 10 41 25 26 1 1 10 42 25 1 1 29 30 0
                                    1 1 18 0 0 1 1 14 43 0 1 4 0 0 0 7 15 0 1 2
                                    31 29 0 0 1 1 29 29 0 1 1 0 15 0 1 1 0 43 0
                                    1 1 0 29 0 1 3 0 0 0 44 45 1 3 0 0 0 47 15
                                    1 2 0 0 7 15 16 2 16 38 0 0 1 2 16 38 0 0 1
                                    1 0 15 0 1 2 0 0 48 0 1 2 0 0 51 0 1 1 0 46
                                    0 1 1 0 34 0 1 2 5 7 35 0 1 2 20 0 0 0 1 1
                                    29 30 0 1 2 20 0 0 0 1 2 29 0 0 15 1 2 0 0
                                    0 52 1 2 20 0 0 0 1 2 20 0 0 0 1 2 20 37 0
                                    0 1 2 20 30 0 0 1 2 20 38 0 0 1 1 15 33 0 1
                                    1 15 15 0 1 1 15 0 0 1 1 15 7 0 1 1 0 54 0
                                    1 2 0 53 53 0 1 1 0 55 0 1 1 0 29 0 1 1 0 7
                                    0 1 4 10 0 0 15 7 0 1 2 27 30 0 0 1 2 4 30
                                    0 7 1 2 0 15 0 47 1 2 0 45 0 44 1 1 0 15 0
                                    1 1 18 7 0 1 1 15 0 34 1 1 0 0 34 1 2 30 0
                                    0 0 1 1 28 0 28 1 1 25 0 0 1 1 17 0 32 1 1
                                    0 0 17 18 1 0 0 7 1 1 0 20 0 23 1 0 50 0 1
                                    3 0 0 0 47 15 1 3 0 0 0 44 45 1 2 0 7 0 15
                                    1 1 2 30 0 1 0 30 15 1 3 26 0 0 0 15 1 3 30
                                    0 0 0 0 1 2 27 29 0 0 1 3 0 7 0 7 7 1 2 0 0
                                    0 0 1 2 30 29 0 0 1 2 29 0 0 15 1 2 0 0 0
                                    52 1 0 31 0 1 0 29 0 13 2 0 29 0 0 1 2 20 0
                                    0 7 1 2 33 0 0 0 1 1 33 0 0 1 2 0 0 0 0 1 2
                                    33 0 28 0 1 2 31 0 15 0 1 2 1 0 0 32 1 2 1
                                    0 32 0 1 2 0 0 7 0 1 2 0 0 0 7 1 2 0 0 0 0
                                    1 2 0 0 52 0 1)))))
           '|lookupComplete|)) 
