
(SDEFUN |DECIMAL;decimal;F$;1| ((|r| (|Fraction| (|Integer|))) ($ ($)))
        (SPADCALL |r| (QREFELT $ 7))) 

(PUT '|DECIMAL;coerce;$Re;2| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |DECIMAL;coerce;$Re;2| ((|x| ($)) ($ (|RadixExpansion| 10))) |x|) 

(DECLAIM (NOTINLINE |DecimalExpansion;|)) 

(DEFUN |DecimalExpansion| ()
  (SPROG NIL
         (PROG (#1=#:G759)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|DecimalExpansion|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|DecimalExpansion|
                             (LIST (CONS NIL (CONS 1 (|DecimalExpansion;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|DecimalExpansion|)))))))))) 

(DEFUN |DecimalExpansion;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (#1=#:G757 NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|DecimalExpansion|))
          (LETT $ (GETREFV 55))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| (|Integer|)
                                                             '(|PolynomialFactorizationExplicit|))
                                              (|HasCategory| (|Integer|)
                                                             '(|RetractableTo|
                                                               (|Symbol|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|CharacteristicNonZero|))
                                              (|HasCategory| (|Integer|)
                                                             '(|CharacteristicZero|))
                                              (|HasCategory| (|Integer|)
                                                             '(|ConvertibleTo|
                                                               (|InputForm|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|RealConstant|))
                                              (|HasCategory| (|Integer|)
                                                             '(|OrderedIntegralDomain|))
                                              (|HasCategory| (|Integer|)
                                                             '(|OrderedSet|))
                                              (OR
                                               (|HasCategory| (|Integer|)
                                                              '(|OrderedIntegralDomain|))
                                               (|HasCategory| (|Integer|)
                                                              '(|OrderedSet|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|RetractableTo|
                                                               (|Integer|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|StepThrough|))
                                              (|HasCategory| (|Integer|)
                                                             '(|InnerEvalable|
                                                               (|Symbol|)
                                                               (|Integer|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|Evalable|
                                                               (|Integer|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|Eltable|
                                                               (|Integer|)
                                                               (|Integer|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|PartialDifferentialRing|
                                                               (|Symbol|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|DifferentialRing|))
                                              (|HasCategory| (|Integer|)
                                                             '(|ConvertibleTo|
                                                               (|Pattern|
                                                                (|Float|))))
                                              (|HasCategory| (|Integer|)
                                                             '(|ConvertibleTo|
                                                               (|Pattern|
                                                                (|Integer|))))
                                              (|HasCategory| (|Integer|)
                                                             '(|PatternMatchable|
                                                               (|Float|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|PatternMatchable|
                                                               (|Integer|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|LinearlyExplicitOver|
                                                               (|Integer|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|EuclideanDomain|))
                                              (|HasCategory| (|Integer|)
                                                             '(|IntegerNumberSystem|))
                                              (LETT #1#
                                                    (|HasCategory| (|Integer|)
                                                                   '(|Comparable|)))
                                              (OR #1#
                                                  (|HasCategory| (|Integer|)
                                                                 '(|OrderedIntegralDomain|))
                                                  (|HasCategory| (|Integer|)
                                                                 '(|OrderedSet|)))))))
          (|haddProp| |$ConstructorCache| '|DecimalExpansion| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (AND (|HasCategory| $ '(|CharacteristicNonZero|))
               (|HasCategory| (|Integer|) '(|PolynomialFactorizationExplicit|))
               (|augmentPredVector| $ 33554432))
          (AND
           (OR
            (AND (|HasCategory| $ '(|CharacteristicNonZero|))
                 (|HasCategory| (|Integer|)
                                '(|PolynomialFactorizationExplicit|)))
            (|HasCategory| (|Integer|) '(|CharacteristicNonZero|)))
           (|augmentPredVector| $ 67108864))
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|DecimalExpansion| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|RadixExpansion| '10) (|Fraction| 18)
              (0 . |coerce|) |DECIMAL;decimal;F$;1| |DECIMAL;coerce;$Re;2|
              (|Union| 25 '#1="failed") (|Matrix| $) (|Union| $ '"failed")
              (|Boolean|) (|InputForm|) (|Pattern| 35) (|Pattern| 18)
              (|NonNegativeInteger|) (|Integer|) (|List| 20) (|Equation| 18)
              (|List| 18) (|Symbol|) (|List| 22)
              (|Record| (|:| |mat| 26) (|:| |vec| (|Vector| 18))) (|Vector| $)
              (|Matrix| 18) (|List| 17) (|PatternMatchResult| 35 $)
              (|PatternMatchResult| 18 $) (|Factored| 31)
              (|SparseUnivariatePolynomial| $) (|Union| 33 '#1#) (|List| 31)
              (|DoubleFloat|) (|Float|) (|Union| 18 '#2="failed")
              (|Union| 6 '#2#) (|Union| 22 '#2#) (|Mapping| 18 18)
              (|Factored| $) (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 41 '#3="failed") (|Union| 44 '#3#) (|List| $)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef| 44) (|:| |generator| $))
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|PositiveInteger|) (|String|) (|SingleInteger|) (|HashState|)
              (|OutputForm|))
           '#(~= 5 |zero?| 11 |wholePart| 16 |unitNormal| 21 |unitCanonical| 26
              |unit?| 31 |subtractIfCan| 36 |squareFreePolynomial| 42
              |squareFreePart| 47 |squareFree| 52
              |solveLinearPolynomialEquation| 57 |smaller?| 63 |sizeLess?| 69
              |sign| 75 |sample| 80 |rightRecip| 84 |rightPower| 89
              |retractIfCan| 101 |retract| 121 |rem| 141 |reducedSystem| 147
              |recip| 169 |quo| 174 |principalIdeal| 180 |prime?| 185
              |positive?| 190 |patternMatch| 195 |opposite?| 209 |one?| 215
              |numerator| 220 |numer| 225 |nextItem| 230 |negative?| 235
              |multiEuclidean| 240 |min| 246 |max| 252 |map| 258 |leftRecip|
              264 |leftPower| 269 |lcmCoef| 281 |lcm| 287 |latex| 298 |inv| 303
              |init| 308 |hashUpdate!| 312 |hash| 318 |gcdPolynomial| 323 |gcd|
              329 |fractionPart| 340 |floor| 350 |factorSquareFreePolynomial|
              355 |factorPolynomial| 360 |factor| 365 |extendedEuclidean| 370
              |exquo| 383 |expressIdealMember| 389 |eval| 395 |euclideanSize|
              435 |elt| 440 |divide| 446 |differentiate| 452 |denominator| 502
              |denom| 507 |decimal| 512 |convert| 517 |conditionP| 542
              |commutator| 547 |coerce| 553 |charthRoot| 588 |characteristic|
              593 |ceiling| 597 |associator| 602 |associates?| 609
              |antiCommutator| 615 |annihilate?| 621 |abs| 627 ^ 632 |Zero| 650
              |One| 654 D 658 >= 708 > 714 = 720 <= 726 < 732 / 738 - 750 + 761
              * 767)
           'NIL
           (CONS
            (|makeByteWordVec2| 25
                                '(0 0 0 1 0 0 0 7 0 0 0 0 0 0 7 0 0 0 0 0 3 4
                                  15 16 0 0 0 0 0 0 0 0 0 0 0 7 0 0 0 0 0 0 0 7
                                  0 7 0 0 0 7 0 0 0 0 0 9 0 0 0 25 11 19 20 0 0
                                  0 0 2 6 10 13 0 0 0 0 0 0 0 0 0 2 5 6 6 8 10
                                  12 13 14 17 18))
            (CONS
             '#(|QuotientFieldCategory&| |Field&| |EuclideanDomain&|
                |PolynomialFactorizationExplicit&| NIL
                |UniqueFactorizationDomain&| |GcdDomain&| NIL NIL
                |FullyLinearlyExplicitOver&| |DifferentialExtension&|
                |DivisionRing&| NIL NIL |OrderedRing&| NIL |Algebra&|
                |Algebra&| |EntireRing&| |Algebra&| NIL NIL
                |PartialDifferentialRing&| |DifferentialRing&| NIL |Rng&| NIL
                |Module&| |Module&| |Module&| NIL NIL NIL NIL
                |NonAssociativeRing&| NIL NIL NIL NIL NIL NIL
                |NonAssociativeRng&| NIL NIL |AbelianGroup&| NIL NIL NIL NIL
                NIL NIL NIL |MagmaWithUnit&| |NonAssociativeSemiRng&|
                |AbelianMonoid&| |OrderedSet&| |FullyEvalableOver&| |Magma&|
                |AbelianSemiGroup&| NIL NIL NIL NIL NIL |RetractableTo&| NIL
                |SetCategory&| |RetractableTo&| NIL |RetractableTo&|
                |Evalable&| NIL NIL NIL NIL NIL NIL NIL |BasicType&| NIL NIL
                NIL NIL NIL |PartialOrder&| NIL |InnerEvalable&|
                |InnerEvalable&| NIL NIL NIL)
             (CONS
              '#((|QuotientFieldCategory| 18) (|Field|) (|EuclideanDomain|)
                 (|PolynomialFactorizationExplicit|) (|PrincipalIdealDomain|)
                 (|UniqueFactorizationDomain|) (|GcdDomain|)
                 (|OrderedIntegralDomain|) (|IntegralDomain|)
                 (|FullyLinearlyExplicitOver| 18) (|DifferentialExtension| 18)
                 (|DivisionRing|) (|CommutativeRing|) (|LeftOreRing|)
                 (|OrderedRing|) (|LinearlyExplicitOver| 18) (|Algebra| 18)
                 (|Algebra| 6) (|EntireRing|) (|Algebra| $$)
                 (|CharacteristicNonZero|) (|CharacteristicZero|)
                 (|PartialDifferentialRing| 22) (|DifferentialRing|) (|Ring|)
                 (|Rng|) (|SemiRing|) (|Module| 18) (|Module| 6) (|Module| $$)
                 (|SemiRng|) (|BiModule| 18 18) (|BiModule| 6 6)
                 (|BiModule| $$ $$) (|NonAssociativeRing|)
                 (|OrderedAbelianGroup|) (|RightModule| 18) (|LeftModule| 18)
                 (|RightModule| 6) (|LeftModule| 6) (|LeftModule| $$)
                 (|NonAssociativeRng|) (|RightModule| $$)
                 (|OrderedCancellationAbelianMonoid|) (|AbelianGroup|)
                 (|OrderedAbelianMonoid|) (|Monoid|) (|NonAssociativeSemiRing|)
                 (|CancellationAbelianMonoid|) (|OrderedAbelianSemiGroup|)
                 (|FullyPatternMatchable| 18) (|SemiGroup|) (|MagmaWithUnit|)
                 (|NonAssociativeSemiRng|) (|AbelianMonoid|) (|OrderedSet|)
                 (|FullyEvalableOver| 18) (|Magma|) (|AbelianSemiGroup|)
                 (|Comparable|) (|StepThrough|) (|PatternMatchable| 35)
                 (|PatternMatchable| 18) (|Patternable| 18)
                 (|RetractableTo| 18) (|CommutativeStar|) (|SetCategory|)
                 (|RetractableTo| 22) (|RealConstant|) (|RetractableTo| 6)
                 (|Evalable| 18) (|Type|) (|CoercibleFrom| 18)
                 (|canonicalsClosed|) (|canonicalUnitNormal|)
                 (|noZeroDivisors|) (|TwoSidedRecip|) (|unitsKnown|)
                 (|BasicType|) (|CoercibleTo| 54) (|CoercibleFrom| 22)
                 (|ConvertibleTo| 14) (|ConvertibleTo| 34) (|ConvertibleTo| 35)
                 (|PartialOrder|) (|CoercibleFrom| 6) (|InnerEvalable| 22 18)
                 (|InnerEvalable| 18 18) (|Eltable| 18 $$) (|ConvertibleTo| 15)
                 (|ConvertibleTo| 16))
              (|makeByteWordVec2| 54
                                  '(1 0 0 6 7 2 0 13 0 0 1 1 0 13 0 1 1 22 18 0
                                    1 1 0 49 0 1 1 0 0 0 1 1 0 13 0 1 2 0 12 0
                                    0 1 1 1 30 31 1 1 0 0 0 1 1 0 40 0 1 2 1 32
                                    33 31 1 2 24 13 0 0 1 2 0 13 0 0 1 1 7 18 0
                                    1 0 0 0 1 1 0 12 0 1 2 0 0 0 17 1 2 0 0 0
                                    50 1 1 10 36 0 1 1 10 37 0 1 1 2 38 0 1 1 0
                                    36 0 1 1 10 18 0 1 1 10 6 0 1 1 2 22 0 1 1
                                    0 18 0 1 2 0 0 0 0 1 2 21 24 11 25 1 1 21
                                    26 11 1 1 0 26 11 1 2 0 24 11 25 1 1 0 12 0
                                    1 2 0 0 0 0 1 1 0 47 44 1 1 0 13 0 1 1 7 13
                                    0 1 3 19 28 0 15 28 1 3 20 29 0 16 29 1 2 0
                                    13 0 0 1 1 0 13 0 1 1 0 0 0 1 1 0 18 0 1 1
                                    11 12 0 1 1 7 13 0 1 2 0 43 44 0 1 2 8 0 0
                                    0 1 2 8 0 0 0 1 2 0 0 39 0 1 1 0 12 0 1 2 0
                                    0 0 17 1 2 0 0 0 50 1 2 0 48 0 0 1 2 0 0 0
                                    0 1 1 0 0 44 1 1 0 51 0 1 1 0 0 0 1 0 11 0
                                    1 2 0 53 53 0 1 1 0 52 0 1 2 0 31 31 31 1 2
                                    0 0 0 0 1 1 0 0 44 1 1 22 0 0 1 1 0 6 0 1 1
                                    23 18 0 1 1 1 30 31 1 1 1 30 31 1 1 0 40 0
                                    1 3 0 42 0 0 0 1 2 0 45 0 0 1 2 0 12 0 0 1
                                    2 0 43 44 0 1 2 13 0 0 19 1 2 13 0 0 20 1 3
                                    13 0 0 21 21 1 3 13 0 0 18 18 1 3 12 0 0 22
                                    18 1 3 12 0 0 23 21 1 1 0 17 0 1 2 14 0 0
                                    18 1 2 0 46 0 0 1 2 16 0 0 17 1 1 16 0 0 1
                                    3 15 0 0 22 17 1 3 15 0 0 23 27 1 2 15 0 0
                                    23 1 2 15 0 0 22 1 2 0 0 0 39 1 3 0 0 0 39
                                    17 1 1 0 0 0 1 1 0 18 0 1 1 0 0 6 8 1 5 14
                                    0 1 1 17 15 0 1 1 18 16 0 1 1 6 34 0 1 1 6
                                    35 0 1 1 26 10 11 1 2 0 0 0 0 1 1 2 0 22 1
                                    1 0 6 0 1 1 0 5 0 9 1 0 0 18 1 1 0 0 6 7 1
                                    0 0 0 1 1 0 54 0 1 1 27 12 0 1 0 0 17 1 1
                                    23 18 0 1 3 0 0 0 0 0 1 2 0 13 0 0 1 2 0 0
                                    0 0 1 2 0 13 0 0 1 1 7 0 0 1 2 0 0 0 18 1 2
                                    0 0 0 17 1 2 0 0 0 50 1 0 0 0 1 0 0 0 1 2
                                    16 0 0 17 1 1 16 0 0 1 3 15 0 0 22 17 1 3
                                    15 0 0 23 27 1 2 15 0 0 22 1 2 15 0 0 23 1
                                    3 0 0 0 39 17 1 2 0 0 0 39 1 2 8 13 0 0 1 2
                                    8 13 0 0 1 2 0 13 0 0 1 2 8 13 0 0 1 2 8 13
                                    0 0 1 2 0 0 18 18 1 2 0 0 0 0 1 1 0 0 0 1 2
                                    0 0 0 0 1 2 0 0 0 0 1 2 0 0 0 18 1 2 0 0 18
                                    0 1 2 0 0 6 0 1 2 0 0 0 6 1 2 0 0 17 0 1 2
                                    0 0 0 0 1 2 0 0 50 0 1)))))
           '|lookupComplete|)) 

(MAKEPROP '|DecimalExpansion| 'NILADIC T) 
