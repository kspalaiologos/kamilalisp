
(SDEFUN |MCMPLX;coerce;C$;1| ((|u| (|Complex| (|Float|))) ($ ($)))
        (SPADCALL (SPADCALL (SPADCALL |u| (QREFELT $ 8)) (QREFELT $ 10))
                  (SPADCALL (SPADCALL |u| (QREFELT $ 11)) (QREFELT $ 10))
                  (QREFELT $ 12))) 

(SDEFUN |MCMPLX;coerce;C$;2| ((|u| (|Complex| (|Integer|))) ($ ($)))
        (SPADCALL (SPADCALL (SPADCALL |u| (QREFELT $ 16)) (QREFELT $ 17))
                  (SPADCALL (SPADCALL |u| (QREFELT $ 18)) (QREFELT $ 17))
                  (QREFELT $ 12))) 

(SDEFUN |MCMPLX;coerce;C$;3| ((|u| (|Complex| (|MachineInteger|))) ($ ($)))
        (SPADCALL (SPADCALL (SPADCALL |u| (QREFELT $ 22)) (QREFELT $ 23))
                  (SPADCALL (SPADCALL |u| (QREFELT $ 24)) (QREFELT $ 23))
                  (QREFELT $ 12))) 

(SDEFUN |MCMPLX;coerce;C$;4| ((|u| (|Complex| (|MachineFloat|))) ($ ($)))
        (SPADCALL (SPADCALL |u| (QREFELT $ 26)) (SPADCALL |u| (QREFELT $ 27))
                  (QREFELT $ 12))) 

(SDEFUN |MCMPLX;coerce;$C;5| ((|u| ($)) ($ (|Complex| (|Float|))))
        (SPADCALL (SPADCALL (SPADCALL |u| (QREFELT $ 29)) (QREFELT $ 30))
                  (SPADCALL (SPADCALL |u| (QREFELT $ 31)) (QREFELT $ 30))
                  (QREFELT $ 32))) 

(DECLAIM (NOTINLINE |MachineComplex;|)) 

(DEFUN |MachineComplex| ()
  (SPROG NIL
         (PROG (#1=#:G783)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|MachineComplex|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|MachineComplex|
                             (LIST (CONS NIL (CONS 1 (|MachineComplex;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|MachineComplex|)))))))))) 

(DEFUN |MachineComplex;| ()
  (SPROG
   ((|dv$| NIL) ($ NIL) (#1=#:G781 NIL) (#2=#:G780 NIL) (#3=#:G779 NIL)
    (#4=#:G778 NIL) (#5=#:G777 NIL) (|pv$| NIL))
   (PROGN
    (LETT |dv$| '(|MachineComplex|))
    (LETT $ (GETREFV 90))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| (|MachineFloat|)
                                                       '(|CharacteristicZero|))
                                        (|HasCategory| (|MachineFloat|)
                                                       '(|FiniteFieldCategory|))
                                        (LETT #1#
                                              (|HasCategory| (|MachineFloat|)
                                                             '(|Field|)))
                                        (OR #1#
                                            (|HasCategory| (|MachineFloat|)
                                                           '(|FiniteFieldCategory|)))
                                        (|HasCategory| (|MachineFloat|)
                                                       '(|CharacteristicNonZero|))
                                        (|HasCategory| (|MachineFloat|)
                                                       '(|Finite|))
                                        (|HasCategory| (|MachineFloat|)
                                                       '(|RetractableTo|
                                                         (|Fraction|
                                                          (|Integer|))))
                                        (|HasCategory| (|MachineFloat|)
                                                       '(|LinearlyExplicitOver|
                                                         (|Integer|)))
                                        (LETT #2#
                                              (|HasCategory| (|MachineFloat|)
                                                             '(|TranscendentalFunctionCategory|)))
                                        (AND
                                         (|HasCategory| (|MachineFloat|)
                                                        '(|RadicalCategory|))
                                         #2#)
                                        (|HasCategory| (|MachineFloat|)
                                                       '(|arbitraryPrecision|))
                                        (|HasCategory| (|MachineFloat|)
                                                       '(|RealConstant|))
                                        (|HasCategory| (|MachineFloat|)
                                                       '(|ConvertibleTo|
                                                         (|InputForm|)))
                                        (LETT #3#
                                              (|HasCategory| (|MachineFloat|)
                                                             '(|IntegerNumberSystem|)))
                                        (OR #1#
                                            (|HasCategory| (|MachineFloat|)
                                                           '(|FiniteFieldCategory|))
                                            #3#)
                                        (|HasCategory| (|MachineFloat|)
                                                       '(|PartialDifferentialRing|
                                                         (|Symbol|)))
                                        (|HasCategory| (|MachineFloat|)
                                                       '(|DifferentialRing|))
                                        (|HasCategory| (|MachineFloat|)
                                                       '(|InnerEvalable|
                                                         (|Symbol|)
                                                         (|MachineFloat|)))
                                        (|HasCategory| (|MachineFloat|)
                                                       '(|Evalable|
                                                         (|MachineFloat|)))
                                        (|HasCategory| (|MachineFloat|)
                                                       '(|Eltable|
                                                         (|MachineFloat|)
                                                         (|MachineFloat|)))
                                        (|HasCategory| (|MachineFloat|)
                                                       '(|PatternMatchable|
                                                         (|Float|)))
                                        (|HasCategory| (|MachineFloat|)
                                                       '(|PatternMatchable|
                                                         (|Integer|)))
                                        (|HasCategory| (|MachineFloat|)
                                                       '(|ConvertibleTo|
                                                         (|Pattern|
                                                          (|Float|))))
                                        (|HasCategory| (|MachineFloat|)
                                                       '(|ConvertibleTo|
                                                         (|Pattern|
                                                          (|Integer|))))
                                        (OR #1# #3#)
                                        (OR
                                         (|HasCategory| (|MachineFloat|)
                                                        '(|RetractableTo|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         #1#)
                                        (|HasCategory| (|MachineFloat|)
                                                       '(|EuclideanDomain|))
                                        (LETT #4#
                                              (|HasCategory| (|MachineFloat|)
                                                             '(|PolynomialFactorizationExplicit|)))
                                        (OR
                                         (AND
                                          (|HasCategory| (|MachineFloat|)
                                                         '(|EuclideanDomain|))
                                          #4#)
                                         (|HasCategory| (|MachineFloat|)
                                                        '(|FiniteFieldCategory|)))
                                        (OR
                                         (AND
                                          (|HasCategory| (|MachineFloat|)
                                                         '(|EuclideanDomain|))
                                          #4#)
                                         #1#
                                         (|HasCategory| (|MachineFloat|)
                                                        '(|FiniteFieldCategory|))
                                         #3#)
                                        (OR
                                         (AND
                                          (|HasCategory| (|MachineFloat|)
                                                         '(|EuclideanDomain|))
                                          #4#)
                                         #1# #3#)
                                        (LETT #5#
                                              (|HasCategory| (|MachineFloat|)
                                                             '(|RealNumberSystem|)))
                                        (AND #5# #2#)
                                        (|HasCategory| (|MachineFloat|)
                                                       '(|IntegralDomain|))))))
    (|haddProp| |$ConstructorCache| '|MachineComplex| NIL (CONS 1 $))
    (|stuffDomainSlots| $)
    (AND
     (OR
      (AND (|HasCategory| $ '(|CharacteristicNonZero|))
           (|HasCategory| (|MachineFloat|) '(|EuclideanDomain|)) #4#)
      (|HasCategory| (|MachineFloat|) '(|CharacteristicNonZero|)))
     (|augmentPredVector| $ 17179869184))
    (AND
     (OR
      (AND (|HasCategory| $ '(|CharacteristicNonZero|))
           (|HasCategory| (|MachineFloat|) '(|EuclideanDomain|)) #4#)
      (AND (|HasCategory| $ '(|CharacteristicNonZero|))
           (|HasCategory| (|MachineFloat|) '(|FiniteFieldCategory|))))
     (|augmentPredVector| $ 34359738368))
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|MachineComplex| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|Complex| 9) (|Float|) (|Complex| 6)
              (0 . |real|) (|MachineFloat|) (5 . |coerce|) (10 . |imag|)
              (15 . |complex|) |MCMPLX;coerce;C$;1| (|Integer|) (|Complex| 14)
              (21 . |real|) (26 . |coerce|) (31 . |imag|) |MCMPLX;coerce;C$;2|
              (|MachineInteger|) (|Complex| 20) (36 . |real|) (41 . |coerce|)
              (46 . |imag|) |MCMPLX;coerce;C$;3| (51 . |real|) (56 . |imag|)
              |MCMPLX;coerce;C$;4| (61 . |real|) (66 . |coerce|) (71 . |imag|)
              (76 . |complex|) |MCMPLX;coerce;$C;5| (|Fraction| 14)
              (|Record| (|:| |r| 9) (|:| |phi| 9)) (|Boolean|) (|Factored| $)
              (|SparseUnivariatePolynomial| $) (|List| $)
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|Union| 42 '#1="failed") (|List| 38) (|Factored| 38)
              (|Union| 62 '#1#) (|Matrix| $) (|Union| $ '"failed")
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 47 '#2="failed") (|Union| 39 '#2#)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|NonNegativeInteger|)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef| 39) (|:| |generator| $)) (|InputForm|)
              (|Pattern| 6) (|Pattern| 14) (|List| 9) (|Equation| 9)
              (|List| 58) (|SparseUnivariatePolynomial| 9) (|Matrix| 9)
              (|Vector| $) (|Mapping| 9 9) (|Fraction| 60) (|PositiveInteger|)
              (|Union| '"prime" '"polynomial" '"normal" '"cyclic")
              (|Table| 65 51) (|Record| (|:| |factor| 14) (|:| |exponent| 51))
              (|List| 68) (|OnePointCompletion| 65) (|Union| 51 '"failed")
              (|Symbol|) (|List| 72) (|Union| 34 '"failed") (|Matrix| 14)
              (|Record| (|:| |mat| 75) (|:| |vec| (|Vector| 14))) (|List| 51)
              (|PatternMatchResult| 6 $) (|PatternMatchResult| 14 $)
              (|Complex| (|DoubleFloat|)) (|Vector| 9) (|Union| 9 '#3="failed")
              (|Record| (|:| |mat| 61) (|:| |vec| 81)) (|Union| 14 '#3#)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|HashState|) (|String|) (|OutputForm|) (|SingleInteger|))
           '#(~= 82 |zero?| 88 |unitNormal| 93 |unitCanonical| 98 |unit?| 103
              |traceMatrix| 108 |trace| 117 |tanh| 122 |tan| 127
              |tableForDiscreteLogarithm| 132 |subtractIfCan| 137
              |squareFreePolynomial| 143 |squareFreePart| 148 |squareFree| 153
              |sqrt| 158 |solveLinearPolynomialEquation| 163 |smaller?| 169
              |sizeLess?| 175 |size| 181 |sinh| 185 |sin| 190 |sech| 195 |sec|
              200 |sample| 205 |rightRecip| 209 |rightPower| 214 |retractIfCan|
              226 |retract| 241 |represents| 256 |representationType| 267 |rem|
              271 |regularRepresentation| 277 |reducedSystem| 288 |reduce| 310
              |recip| 320 |real| 325 |rationalIfCan| 330 |rational?| 335
              |rational| 340 |rank| 345 |random| 349 |quo| 353 |principalIdeal|
              359 |primitiveElement| 364 |primitive?| 368 |primeFrobenius| 373
              |prime?| 384 |polarCoordinates| 389 |pi| 394 |patternMatch| 398
              |order| 412 |opposite?| 422 |one?| 428 |nthRoot| 433 |norm| 439
              |nextItem| 444 |multiEuclidean| 449 |minimalPolynomial| 455 |min|
              460 |max| 466 |map| 472 |lookup| 478 |log| 483 |lift| 488
              |leftRecip| 493 |leftPower| 498 |lcmCoef| 510 |lcm| 516 |latex|
              527 |inv| 532 |init| 537 |index| 541 |imaginary| 546 |imag| 550
              |hashUpdate!| 555 |hash| 561 |generator| 566 |gcdPolynomial| 570
              |gcd| 576 |factorsOfCyclicGroupSize| 587
              |factorSquareFreePolynomial| 591 |factorPolynomial| 596 |factor|
              601 |extendedEuclidean| 606 |exquo| 619 |expressIdealMember| 631
              |exp| 637 |eval| 642 |euclideanSize| 682 |enumerate| 687 |elt|
              691 |divide| 697 |discriminant| 703 |discreteLog| 712
              |differentiate| 723 |derivationCoordinates| 773
              |definingPolynomial| 779 |csch| 783 |csc| 788
              |createPrimitiveElement| 793 |coth| 797 |cot| 802 |cosh| 807
              |cos| 812 |coordinates| 817 |convert| 839 |conjugate| 884
              |conditionP| 889 |complex| 894 |commutator| 900 |coerce| 906
              |charthRoot| 956 |characteristicPolynomial| 966 |characteristic|
              971 |basis| 975 |atanh| 979 |atan| 984 |associator| 989
              |associates?| 996 |asinh| 1002 |asin| 1007 |asech| 1012 |asec|
              1017 |argument| 1022 |antiCommutator| 1027 |annihilate?| 1033
              |acsch| 1039 |acsc| 1044 |acoth| 1049 |acot| 1054 |acosh| 1059
              |acos| 1064 |abs| 1069 ^ 1074 |Zero| 1104 |One| 1108 D 1112 >=
              1162 > 1168 = 1174 <= 1180 < 1186 / 1192 - 1198 + 1209 * 1215)
           'NIL
           (CONS
            (|makeByteWordVec2| 31
                                '(0 0 2 2 4 29 15 30 15 0 30 0 0 0 0 0 0 3 31 0
                                  0 0 0 1 3 5 8 16 17 0 0 0 0 0 0 3 0 0 0 0 3 0
                                  0 0 0 0 3 3 0 0 0 0 0 0 0 0 0 0 6 0 0 0 0 0 2
                                  21 22 0 0 0 0 0 7 9 19 0 0 0 0 0 0 0 0 0 0 3
                                  3 7 10 9 9 9 9 9 11 12 12 13 14 18 19 20 23
                                  24))
            (CONS
             '#(|ComplexCategory&| |MonogenicAlgebra&| |FiniteFieldCategory&|
                |FieldOfPrimeCharacteristic&| |Field&|
                |PolynomialFactorizationExplicit&| |EuclideanDomain&|
                |UniqueFactorizationDomain&| NIL NIL |GcdDomain&| NIL
                |FramedAlgebra&| NIL |DifferentialExtension&|
                |FullyLinearlyExplicitOver&| |FiniteRankAlgebra&|
                |DivisionRing&| NIL NIL |Algebra&| |EntireRing&| |Algebra&| NIL
                |Algebra&| NIL NIL |PartialDifferentialRing&|
                |DifferentialRing&| NIL |Rng&| NIL |Module&| |Module&| NIL
                |Module&| |FramedModule&| NIL NIL |NonAssociativeRing&| NIL NIL
                NIL NIL |NonAssociativeRng&| NIL NIL NIL |AbelianGroup&| NIL
                NIL NIL NIL |OrderedSet&| NIL |MagmaWithUnit&|
                |NonAssociativeSemiRng&| |AbelianMonoid&| |Finite&|
                |FullyEvalableOver&| |FullyRetractableTo&| NIL |Magma&|
                |AbelianSemiGroup&| NIL NIL NIL NIL |RetractableTo&|
                |RetractableTo&| NIL |SetCategory&| |RetractableTo&|
                |TranscendentalFunctionCategory&| |Evalable&| NIL NIL NIL NIL
                |PartialOrder&| NIL NIL NIL |BasicType&| NIL NIL NIL NIL
                |RadicalCategory&| |TrigonometricFunctionCategory&|
                |ArcTrigonometricFunctionCategory&|
                |HyperbolicFunctionCategory&| NIL |ElementaryFunctionCategory&|
                NIL NIL NIL NIL NIL |InnerEvalable&| |InnerEvalable&| NIL NIL
                NIL)
             (CONS
              '#((|ComplexCategory| 9) (|MonogenicAlgebra| 9 60)
                 (|FiniteFieldCategory|) (|FieldOfPrimeCharacteristic|)
                 (|Field|) (|PolynomialFactorizationExplicit|)
                 (|EuclideanDomain|) (|UniqueFactorizationDomain|)
                 (|PrincipalIdealDomain|) (|FortranMachineTypeCategory|)
                 (|GcdDomain|) (|IntegralDomain|) (|FramedAlgebra| 9 60)
                 (|CommutativeRing|) (|DifferentialExtension| 9)
                 (|FullyLinearlyExplicitOver| 9) (|FiniteRankAlgebra| 9 60)
                 (|DivisionRing|) (|LeftOreRing|) (|LinearlyExplicitOver| 9)
                 (|Algebra| 9) (|EntireRing|) (|Algebra| $$)
                 (|CharacteristicZero|) (|Algebra| 34)
                 (|CharacteristicNonZero|) (|LinearlyExplicitOver| 14)
                 (|PartialDifferentialRing| 72) (|DifferentialRing|) (|Ring|)
                 (|Rng|) (|SemiRing|) (|Module| 9) (|Module| $$) (|SemiRng|)
                 (|Module| 34) (|FramedModule| 9) (|BiModule| 9 9)
                 (|BiModule| $$ $$) (|NonAssociativeRing|) (|BiModule| 34 34)
                 (|RightModule| 9) (|LeftModule| 9) (|LeftModule| $$)
                 (|NonAssociativeRng|) (|RightModule| $$) (|LeftModule| 34)
                 (|RightModule| 34) (|AbelianGroup|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|FullyPatternMatchable| 9) (|OrderedSet|) (|SemiGroup|)
                 (|MagmaWithUnit|) (|NonAssociativeSemiRng|) (|AbelianMonoid|)
                 (|Finite|) (|FullyEvalableOver| 9) (|FullyRetractableTo| 9)
                 (|Comparable|) (|Magma|) (|AbelianSemiGroup|) (|StepThrough|)
                 (|PatternMatchable| 6) (|PatternMatchable| 14)
                 (|Patternable| 9) (|RetractableTo| 9) (|RetractableTo| 14)
                 (|CommutativeStar|) (|SetCategory|) (|RetractableTo| 34)
                 (|TranscendentalFunctionCategory|) (|Evalable| 9) (|Type|)
                 (|CoercibleFrom| 9) (|ConvertibleTo| 60) (|CoercibleFrom| 14)
                 (|PartialOrder|) (|noZeroDivisors|) (|TwoSidedRecip|)
                 (|unitsKnown|) (|BasicType|) (|CoercibleTo| 88)
                 (|canonicalUnitNormal|) (|canonicalsClosed|)
                 (|CoercibleFrom| 34) (|RadicalCategory|)
                 (|TrigonometricFunctionCategory|)
                 (|ArcTrigonometricFunctionCategory|)
                 (|HyperbolicFunctionCategory|)
                 (|ArcHyperbolicFunctionCategory|)
                 (|ElementaryFunctionCategory|) (|arbitraryPrecision|)
                 (|ConvertibleTo| 7) (|ConvertibleTo| 80) (|ConvertibleTo| 54)
                 (|multiplicativeValuation|) (|InnerEvalable| 72 9)
                 (|InnerEvalable| 9 9) (|Eltable| 9 $$) (|ConvertibleTo| 55)
                 (|ConvertibleTo| 56))
              (|makeByteWordVec2| 89
                                  '(1 7 6 0 8 1 9 0 6 10 1 7 6 0 11 2 0 0 9 9
                                    12 1 15 14 0 16 1 9 0 14 17 1 15 14 0 18 1
                                    21 20 0 22 1 9 0 20 23 1 21 20 0 24 1 5 9 0
                                    26 1 5 9 0 27 1 0 9 0 29 1 9 6 0 30 1 0 9 0
                                    31 2 7 0 6 6 32 2 0 36 0 0 1 1 0 36 0 1 1 0
                                    85 0 1 1 0 0 0 1 1 0 36 0 1 1 0 61 62 1 0 0
                                    61 1 1 0 9 0 1 1 9 0 0 1 1 9 0 0 1 1 2 67
                                    14 1 2 0 46 0 0 1 1 29 43 38 1 1 31 0 0 1 1
                                    31 37 0 1 1 10 0 0 1 2 29 41 42 38 1 2 0 36
                                    0 0 1 2 25 36 0 0 1 0 6 51 1 1 9 0 0 1 1 9
                                    0 0 1 1 9 0 0 1 1 9 0 0 1 0 0 0 1 1 0 46 0
                                    1 2 0 0 0 51 1 2 0 0 0 65 1 1 7 74 0 1 1 0
                                    82 0 1 1 0 84 0 1 1 7 34 0 1 1 0 9 0 1 1 0
                                    14 0 1 2 0 0 81 62 1 1 0 0 81 1 0 2 66 1 2
                                    25 0 0 0 1 2 0 61 0 62 1 1 0 61 0 1 1 8 75
                                    45 1 2 8 76 45 62 1 1 0 61 45 1 2 0 83 45
                                    62 1 1 3 46 64 1 1 0 0 60 1 1 0 46 0 1 1 0
                                    9 0 29 1 14 74 0 1 1 14 36 0 1 1 14 34 0 1
                                    0 0 65 1 0 6 0 1 2 25 0 0 0 1 1 25 53 39 1
                                    0 2 0 1 1 2 36 0 1 2 2 0 0 51 1 1 2 0 0 1 1
                                    31 36 0 1 1 33 35 0 1 0 9 0 1 3 21 78 0 55
                                    78 1 3 22 79 0 56 79 1 1 2 65 0 1 1 2 70 0
                                    1 2 0 36 0 0 1 1 0 36 0 1 2 10 0 0 14 1 1 0
                                    9 0 1 1 2 46 0 1 2 25 49 39 0 1 1 3 60 0 1
                                    2 0 0 0 0 1 2 0 0 0 0 1 2 0 0 63 0 1 1 6 65
                                    0 1 1 9 0 0 1 1 0 60 0 1 1 0 46 0 1 2 0 0 0
                                    51 1 2 0 0 0 65 1 2 31 40 0 0 1 1 31 0 39 1
                                    2 31 0 0 0 1 1 0 87 0 1 1 3 0 0 1 0 2 0 1 1
                                    6 0 65 1 0 0 0 1 1 0 9 0 31 2 0 86 86 0 1 1
                                    0 89 0 1 0 0 0 1 2 31 38 38 38 1 1 31 0 39
                                    1 2 31 0 0 0 1 0 2 69 1 1 29 43 38 1 1 29
                                    43 38 1 1 31 37 0 1 3 25 48 0 0 0 1 2 25 50
                                    0 0 1 2 34 46 0 9 1 2 0 46 0 0 1 2 25 49 39
                                    0 1 1 9 0 0 1 3 19 0 0 57 57 1 2 19 0 0 58
                                    1 3 19 0 0 9 9 1 2 19 0 0 59 1 3 18 0 0 72
                                    9 1 3 18 0 0 73 57 1 1 25 51 0 1 0 6 39 1 2
                                    20 0 0 9 1 2 25 52 0 0 1 1 0 9 62 1 0 0 9 1
                                    1 2 51 0 1 2 2 71 0 0 1 1 17 0 0 1 2 17 0 0
                                    51 1 2 16 0 0 73 1 2 16 0 0 72 1 3 16 0 0
                                    72 51 1 3 16 0 0 73 77 1 2 0 0 0 63 1 3 0 0
                                    0 63 51 1 2 3 61 62 63 1 0 0 60 1 1 9 0 0 1
                                    1 9 0 0 1 0 2 0 1 1 9 0 0 1 1 9 0 0 1 1 9 0
                                    0 1 1 9 0 0 1 2 0 81 0 62 1 2 0 61 62 62 1
                                    1 0 61 62 1 1 0 81 0 1 1 13 54 0 1 1 23 55
                                    0 1 1 24 56 0 1 1 12 80 0 1 1 12 7 0 1 1 0
                                    0 81 1 1 0 81 0 1 1 0 60 0 1 1 0 0 60 1 1 0
                                    0 0 1 1 36 44 45 1 2 0 0 9 9 12 2 0 0 0 0 1
                                    1 26 0 34 1 1 0 7 0 33 1 0 0 5 28 1 0 0 21
                                    25 1 0 0 15 19 1 0 0 7 13 1 0 0 9 1 1 0 0
                                    14 1 1 0 0 0 1 1 0 88 0 1 1 35 46 0 1 1 2 0
                                    0 1 1 0 60 0 1 0 0 51 1 0 0 62 1 1 9 0 0 1
                                    1 9 0 0 1 3 0 0 0 0 0 1 2 0 36 0 0 1 1 9 0
                                    0 1 1 9 0 0 1 1 9 0 0 1 1 9 0 0 1 1 9 9 0 1
                                    2 0 0 0 0 1 2 0 36 0 0 1 1 9 0 0 1 1 9 0 0
                                    1 1 9 0 0 1 1 9 0 0 1 1 9 0 0 1 1 9 0 0 1 1
                                    32 0 0 1 2 10 0 0 34 1 2 3 0 0 14 1 2 9 0 0
                                    0 1 2 0 0 0 51 1 2 0 0 0 65 1 0 0 0 1 0 0 0
                                    1 1 17 0 0 1 2 17 0 0 51 1 2 16 0 0 72 1 3
                                    16 0 0 72 51 1 2 16 0 0 73 1 3 16 0 0 73 77
                                    1 3 0 0 0 63 51 1 2 0 0 0 63 1 2 0 36 0 0 1
                                    2 0 36 0 0 1 2 0 36 0 0 1 2 0 36 0 0 1 2 0
                                    36 0 0 1 2 3 0 0 0 1 2 0 0 0 0 1 1 0 0 0 1
                                    2 0 0 0 0 1 2 3 0 34 0 1 2 3 0 0 34 1 2 0 0
                                    0 9 1 2 0 0 9 0 1 2 0 0 51 0 1 2 0 0 14 0 1
                                    2 0 0 0 0 1 2 0 0 65 0 1)))))
           '|lookupComplete|)) 

(MAKEPROP '|MachineComplex| 'NILADIC T) 
