
(SDEFUN |ORESUP;^;$Pi$;1| ((|x| ($)) (|n| (|PositiveInteger|)) ($ ($)))
        (SPADCALL |x| |n| (QREFELT $ 11))) 

(SDEFUN |ORESUP;^;$Nni$;2| ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (COND ((ZEROP |n|) (|spadConstant| $ 13))
              ('T (SPADCALL |x| |n| (QREFELT $ 11))))) 

(SDEFUN |ORESUP;*;3$;3| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL |x| |y| (QREFELT $ 7) (QREFELT $ 8) (QREFELT $ 19))) 

(SDEFUN |ORESUP;*;$R$;4| ((|x| ($)) (|r| (R)) ($ ($)))
        (SPADCALL |x| (SPADCALL |r| (|spadConstant| $ 13) (QREFELT $ 22))
                  (QREFELT $ 7) (QREFELT $ 8) (QREFELT $ 19))) 

(SDEFUN |ORESUP;apply;$3R;5| ((|p| ($)) (|c| (R)) (|r| (R)) ($ (R)))
        (SPADCALL |p| |c| |r| (QREFELT $ 7) (QREFELT $ 8) (QREFELT $ 24))) 

(SDEFUN |ORESUP;monicLeftDivide;2$R;6|
        ((|a| ($)) (|b| ($))
         ($ (|Record| (|:| |quotient| $) (|:| |remainder| $))))
        (SPADCALL |a| |b| (QREFELT $ 7) (QREFELT $ 27))) 

(SDEFUN |ORESUP;monicRightDivide;2$R;7|
        ((|a| ($)) (|b| ($))
         ($ (|Record| (|:| |quotient| $) (|:| |remainder| $))))
        (SPADCALL |a| |b| (QREFELT $ 7) (QREFELT $ 30))) 

(SDEFUN |ORESUP;leftDivide;2$R;8|
        ((|a| ($)) (|b| ($))
         ($ (|Record| (|:| |quotient| $) (|:| |remainder| $))))
        (SPADCALL |a| |b| (QREFELT $ 7) (QREFELT $ 32))) 

(SDEFUN |ORESUP;rightDivide;2$R;9|
        ((|a| ($)) (|b| ($))
         ($ (|Record| (|:| |quotient| $) (|:| |remainder| $))))
        (SPADCALL |a| |b| (QREFELT $ 7) (QREFELT $ 34))) 

(DECLAIM (NOTINLINE |SparseUnivariateSkewPolynomial;|)) 

(DEFUN |SparseUnivariateSkewPolynomial| (&REST #1=#:G752)
  (SPROG NIL
         (PROG (#2=#:G753)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T NIL NIL))
                     (HGET |$ConstructorCache|
                           '|SparseUnivariateSkewPolynomial|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |SparseUnivariateSkewPolynomial;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|SparseUnivariateSkewPolynomial|)))))))))) 

(DEFUN |SparseUnivariateSkewPolynomial;| (|#1| |#2| |#3|)
  (SPROG
   ((|pv$| NIL) (#1=#:G751 NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 |#2|)
    (LETT DV$3 |#3|)
    (LETT |dv$| (LIST '|SparseUnivariateSkewPolynomial| DV$1 DV$2 DV$3))
    (LETT $ (GETREFV 66))
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
                                        (|HasCategory| |#1| '(|Field|))
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
                                         #1#)))))
    (|haddProp| |$ConstructorCache| '|SparseUnivariateSkewPolynomial|
                (LIST DV$1 DV$2 DV$3) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
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
    (COND
     ((|testBitVector| |pv$| 16)
      (PROGN
       (QSETREFV $ 29
                 (CONS (|dispatchFunction| |ORESUP;monicLeftDivide;2$R;6|) $))
       (QSETREFV $ 31
                 (CONS (|dispatchFunction| |ORESUP;monicRightDivide;2$R;7|)
                       $)))))
    (COND
     ((|testBitVector| |pv$| 20)
      (PROGN
       (QSETREFV $ 33 (CONS (|dispatchFunction| |ORESUP;leftDivide;2$R;8|) $))
       (QSETREFV $ 35
                 (CONS (|dispatchFunction| |ORESUP;rightDivide;2$R;9|) $)))))
    $))) 

(MAKEPROP '|SparseUnivariateSkewPolynomial| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|SparseUnivariatePolynomial| 6)
              (|local| |#1|) (|local| |#2|) (|local| |#3|) (|PositiveInteger|)
              (|RepeatedSquaring| $$) (0 . |expt|) |ORESUP;^;$Pi$;1|
              (6 . |One|) (|NonNegativeInteger|) |ORESUP;^;$Nni$;2|
              (|Automorphism| 6) (|Mapping| 6 6)
              (|UnivariateSkewPolynomialCategoryOps| 6 $$) (10 . |times|)
              |ORESUP;*;3$;3| (18 . |One|) (22 . *) |ORESUP;*;$R$;4|
              (28 . |apply|) |ORESUP;apply;$3R;5|
              (|Record| (|:| |quotient| $$) (|:| |remainder| $$))
              (37 . |monicLeftDivide|)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (44 . |monicLeftDivide|) (50 . |monicRightDivide|)
              (57 . |monicRightDivide|) (63 . |leftDivide|) (70 . |leftDivide|)
              (76 . |rightDivide|) (83 . |rightDivide|)
              (|Record| (|:| |mat| 39) (|:| |vec| (|Vector| 40))) (|Matrix| $)
              (|Vector| $) (|Matrix| 40) (|Integer|) (|Boolean|)
              (|Union| $ '"failed")
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Fraction| 40) (|Record| (|:| |k| 14) (|:| |c| 6)) (|List| 45)
              (|Mapping| 6 14)
              (|Record| (|:| |generator| $) (|:| |coef1| $) (|:| |coef2| $)
                        (|:| |coefu| $) (|:| |coefv| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Union| 44 '#1="failed") (|Union| 40 '#1#)
              (|Record| (|:| |mat| 53) (|:| |vec| (|Vector| 6))) (|Matrix| 6)
              (|List| $) (|OutputForm|) (|List| 59) (|List| 14)
              (|Union| 59 '"failed") (|SingletonAsOrderedSet|)
              (|Mapping| 14 14) (|Union| 6 '#1#) (|List| 6) (|HashState|)
              (|String|) (|SingleInteger|))
           '#(~= 89 |zero?| 95 |variables| 100 |unitNormal| 105 |unitCanonical|
              110 |unit?| 115 |totalDegreeSorted| 120 |totalDegree| 126
              |support| 137 |subtractIfCan| 142 |smaller?| 148 |sample| 154
              |right_ext_ext_GCD| 158 |rightRemainder| 164 |rightRecip| 170
              |rightQuotient| 175 |rightPower| 181 |rightLcm| 193 |rightGcd|
              199 |rightExtendedGcd| 205 |rightExactQuotient| 211 |rightDivide|
              217 |retractIfCan| 223 |retract| 238 |reductum| 253
              |reducedSystem| 258 |recip| 280 |primitivePart| 285
              |primitiveMonomials| 290 |pomopo!| 295 |outputForm| 303
              |opposite?| 309 |one?| 315 |numberOfMonomials| 320 |monomials|
              325 |monomial?| 330 |monomial| 335 |monicRightDivide| 355
              |monicLeftDivide| 361 |minimumDegree| 367 |mapExponents| 372
              |map| 378 |mainVariable| 384 |listOfTerms| 389 |linearExtend| 394
              |leftRemainder| 400 |leftRecip| 406 |leftQuotient| 411
              |leftPower| 417 |leftLcm| 429 |leftGcd| 435 |leftExtendedGcd| 441
              |leftExactQuotient| 447 |leftDivide| 453 |leadingTerm| 459
              |leadingSupport| 464 |leadingMonomial| 469 |leadingCoefficient|
              474 |latex| 479 |hashUpdate!| 484 |hash| 490 |ground?| 495
              |ground| 500 |fmecg| 505 |exquo| 513 |degree| 525 |content| 542
              |constructOrdered| 547 |construct| 552 |commutator| 557 |coerce|
              563 |coefficients| 588 |coefficient| 593 |charthRoot| 613
              |characteristic| 618 |binomThmExpt| 622 |associator| 629
              |associates?| 636 |apply| 642 |antiCommutator| 649 |annihilate?|
              655 ^ 661 |Zero| 673 |One| 677 = 681 / 687 - 693 + 704 * 710)
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
              '#((|UnivariateSkewPolynomialCategory| 6)
                 (|MaybeSkewPolynomialCategory| 6 14 59)
                 (|FiniteAbelianMonoidRing| 6 14) (|AbelianMonoidRing| 6 14)
                 (|FullyLinearlyExplicitOver| 6) (|Algebra| 44)
                 (|CharacteristicNonZero|) (|CharacteristicZero|)
                 (|EntireRing|) (|LinearlyExplicitOver| 6)
                 (|LinearlyExplicitOver| 40) (|Algebra| 6) (|Ring|)
                 (|FreeModuleCategory| 6 14) (|Rng|) (|SemiRing|) (|SemiRng|)
                 (|IndexedDirectProductCategory| 6 14) (|Module| 44)
                 (|Module| 6) (|IndexedProductCategory| 6 14) (|BiModule| 6 6)
                 (|BiModule| $$ $$) (|BiModule| 44 44) (|NonAssociativeRing|)
                 (|AbelianProductCategory| 6) (|LeftModule| 6)
                 (|RightModule| 6) (|RightModule| $$) (|LeftModule| $$)
                 (|LeftModule| 44) (|RightModule| 44) (|NonAssociativeRng|)
                 (|AbelianGroup|) (|CancellationAbelianMonoid|)
                 (|NonAssociativeSemiRing|) (|Monoid|)
                 (|NonAssociativeSemiRng|) (|SemiGroup|) (|AbelianMonoid|)
                 (|MagmaWithUnit|) (|FullyRetractableTo| 6) (|Magma|)
                 (|AbelianSemiGroup|) (|Comparable|) (|RetractableTo| 6)
                 (|SetCategory|) (|RetractableTo| 44) (|RetractableTo| 40)
                 (|CoercibleFrom| 6) (|BasicType|) (|CoercibleTo| 55)
                 (|noZeroDivisors|) (|CoercibleFrom| 44) (|CoercibleFrom| 40)
                 (|canonicalUnitNormal|) (|unitsKnown|))
              (|makeByteWordVec2| 65
                                  '(2 10 2 2 9 11 0 0 0 13 4 18 2 2 2 16 17 19
                                    0 16 0 21 2 0 0 6 0 22 5 18 6 2 6 6 16 17
                                    24 3 18 26 2 2 16 27 2 0 28 0 0 29 3 18 26
                                    2 2 16 30 2 0 28 0 0 31 3 18 26 2 2 16 32 2
                                    0 28 0 0 33 3 18 26 2 2 16 34 2 0 28 0 0 35
                                    2 0 41 0 0 1 1 31 41 0 1 1 0 56 0 1 1 27 43
                                    0 1 1 27 0 0 1 1 27 41 0 1 2 0 14 0 56 1 2
                                    0 14 0 56 1 1 0 14 0 1 1 0 57 0 1 2 32 42 0
                                    0 1 2 9 41 0 0 1 0 31 0 1 2 20 48 0 0 1 2
                                    20 0 0 0 1 1 29 42 0 1 2 20 0 0 0 1 2 29 0
                                    0 14 1 2 0 0 0 9 1 2 20 0 0 0 1 2 20 0 0 0
                                    1 2 20 49 0 0 1 2 20 42 0 0 1 2 20 28 0 0
                                    35 1 6 50 0 1 1 7 51 0 1 1 0 61 0 1 1 6 44
                                    0 1 1 7 40 0 1 1 0 6 0 1 1 15 0 0 1 2 19 36
                                    37 38 1 1 19 39 37 1 2 10 52 37 38 1 1 10
                                    53 37 1 1 29 42 0 1 1 18 0 0 1 1 14 54 0 1
                                    4 0 0 0 6 14 0 1 2 0 55 0 55 1 2 31 41 0 0
                                    1 1 29 41 0 1 1 0 14 0 1 1 0 54 0 1 1 0 41
                                    0 1 3 0 0 0 56 57 1 3 0 0 0 59 14 1 2 0 0 6
                                    14 1 2 16 28 0 0 31 2 16 28 0 0 29 1 0 14 0
                                    1 2 0 0 60 0 1 2 0 0 17 0 1 1 0 58 0 1 1 0
                                    46 0 1 2 5 6 47 0 1 2 20 0 0 0 1 1 29 42 0
                                    1 2 20 0 0 0 1 2 29 0 0 14 1 2 0 0 0 9 1 2
                                    20 0 0 0 1 2 20 0 0 0 1 2 20 49 0 0 1 2 20
                                    42 0 0 1 2 20 28 0 0 33 1 15 45 0 1 1 15 14
                                    0 1 1 15 0 0 1 1 15 6 0 1 1 0 64 0 1 2 0 63
                                    63 0 1 1 0 65 0 1 1 0 41 0 1 1 0 6 0 1 4 10
                                    0 0 14 6 0 1 2 27 42 0 0 1 2 4 42 0 6 1 2 0
                                    14 0 59 1 2 0 57 0 56 1 1 0 14 0 1 1 18 6 0
                                    1 1 15 0 46 1 1 0 0 46 1 2 30 0 0 0 1 1 28
                                    0 40 1 1 25 0 0 1 1 17 0 44 1 1 0 0 6 1 1 0
                                    55 0 1 1 0 62 0 1 3 0 0 0 59 14 1 3 0 0 0
                                    56 57 1 2 0 6 0 14 1 1 2 42 0 1 0 30 14 1 3
                                    26 0 0 0 14 1 3 30 0 0 0 0 1 2 27 41 0 0 1
                                    3 0 6 0 6 6 25 2 0 0 0 0 1 2 30 41 0 0 1 2
                                    29 0 0 14 15 2 0 0 0 9 12 0 31 0 1 0 29 0
                                    13 2 0 41 0 0 1 2 20 0 0 6 1 2 33 0 0 0 1 1
                                    33 0 0 1 2 0 0 0 0 1 2 33 0 40 0 1 2 31 0
                                    14 0 1 2 1 0 0 44 1 2 1 0 44 0 1 2 0 0 6 0
                                    22 2 0 0 0 6 23 2 0 0 0 0 20 2 0 0 9 0
                                    1)))))
           '|lookupComplete|)) 
