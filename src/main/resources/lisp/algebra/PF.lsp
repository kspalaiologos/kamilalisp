
(DECLAIM (NOTINLINE |PrimeField;|)) 

(DEFUN |PrimeField| (#1=#:G754)
  (SPROG NIL
         (PROG (#2=#:G755)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PrimeField|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|PrimeField;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|PrimeField|)))))))))) 

(DEFUN |PrimeField;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT |dv$| (LIST '|PrimeField| DV$1))
          (LETT $ (GETREFV 45))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PrimeField| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (AND (|HasCategory| $ '(|CharacteristicNonZero|))
               (|augmentPredVector| $ 1))
          (AND (|HasCategory| $ '(|Field|)) (|augmentPredVector| $ 2))
          (AND (|HasCategory| $ '(|Finite|)) (|augmentPredVector| $ 4))
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 11 (SPADCALL |#1| (QREFELT $ 10)))
          (COND ((QREFELT $ 11))
                ('T (|error| "Argument to prime field must be a prime")))
          $))) 

(MAKEPROP '|PrimeField| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|InnerPrimeField| (NRTEVAL (QREFELT $ 6)))
              (|local| |#1|) (|Boolean|) (|Integer|) (|IntegerPrimesPackage| 8)
              (0 . |prime?|) '#:G689 (|Union| 16 '#1="failed") (|Matrix| $)
              (|SparseUnivariatePolynomial| $) (|NonNegativeInteger|)
              (|Vector| $) (|PositiveInteger|) (|Union| 14 '"failed")
              (|Union| $ '"failed") (|OnePointCompletion| 17)
              (|Union| '"prime" '"polynomial" '"normal" '"cyclic")
              (|Record| (|:| |factor| 8) (|:| |exponent| 15)) (|List| 22)
              (|Table| 17 15) (|Factored| 14) (|Union| 27 '#1#) (|List| 14)
              (|InputForm|) (|List| $) (|Union| 15 '"failed") (|Fraction| 8)
              (|Factored| $) (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 33 '#2="failed") (|Union| 29 '#2#)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef| 29) (|:| |generator| $))
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|String|) (|SingleInteger|) (|HashState|) (|OutputForm|))
           '#(~= 5 |zero?| 11 |unitNormal| 16 |unitCanonical| 21 |unit?| 26
              |transcendent?| 31 |transcendenceDegree| 36 |traceMatrix| 40
              |trace| 49 |tableForDiscreteLogarithm| 60 |subtractIfCan| 65
              |squareFreePolynomial| 71 |squareFreePart| 76 |squareFree| 81
              |sqrt| 86 |solveLinearPolynomialEquation| 91 |smaller?| 97
              |sizeLess?| 103 |size| 109 |sample| 113 |rightRecip| 117
              |rightPower| 122 |retractIfCan| 134 |retract| 139 |represents|
              144 |representationType| 155 |rem| 159 |regularRepresentation|
              165 |recip| 176 |rank| 181 |random| 185 |quo| 189
              |principalIdeal| 195 |primitiveElement| 200 |primitive?| 204
              |primeFrobenius| 209 |prime?| 220 |order| 225 |opposite?| 235
              |one?| 241 |normalElement| 246 |normal?| 250 |norm| 255
              |nextItem| 266 |multiEuclidean| 271 |minimalPolynomial| 277
              |lookup| 288 |linearAssociatedOrder| 293 |linearAssociatedLog|
              298 |linearAssociatedExp| 309 |leftRecip| 315 |leftPower| 320
              |lcmCoef| 332 |lcm| 338 |latex| 349 |inv| 354 |init| 359 |index|
              363 |inGroundField?| 368 |hashUpdate!| 373 |hash| 379 |generator|
              384 |gcdPolynomial| 388 |gcd| 394 |factorsOfCyclicGroupSize| 405
              |factorSquareFreePolynomial| 409 |factorPolynomial| 414 |factor|
              419 |extensionDegree| 424 |extendedEuclidean| 432 |exquo| 445
              |expressIdealMember| 451 |euclideanSize| 457 |enumerate| 462
              |divide| 466 |discriminant| 472 |discreteLog| 481 |differentiate|
              492 |degree| 503 |definingPolynomial| 513
              |createPrimitiveElement| 517 |createNormalElement| 521
              |coordinates| 525 |convert| 547 |conditionP| 567 |commutator| 572
              |coerce| 578 |charthRoot| 598 |characteristicPolynomial| 608
              |characteristic| 613 |basis| 617 |associator| 626 |associates?|
              633 |antiCommutator| 639 |annihilate?| 645 |algebraic?| 651 ^ 656
              |Zero| 674 |One| 678 |Frobenius| 682 D 693 = 704 / 710 - 716 +
              727 * 733)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
            (CONS
             '#(|FiniteAlgebraicExtensionField&| |FiniteFieldCategory&|
                |ExtensionField&| |FieldOfPrimeCharacteristic&| |Field&|
                |EuclideanDomain&| |PolynomialFactorizationExplicit&| NIL
                |UniqueFactorizationDomain&| |GcdDomain&| |FramedAlgebra&| NIL
                |FiniteRankAlgebra&| NIL |DivisionRing&| NIL |Algebra&|
                |DifferentialRing&| NIL |Algebra&| |EntireRing&| NIL |Rng&| NIL
                |Module&| |Module&| NIL |FramedModule&| NIL NIL
                |NonAssociativeRing&| NIL NIL NIL |NonAssociativeRng&| NIL
                |AbelianGroup&| NIL NIL NIL |Finite&| NIL |MagmaWithUnit&|
                |NonAssociativeSemiRng&| |AbelianMonoid&| NIL NIL |Magma&|
                |AbelianSemiGroup&| |RetractableTo&| NIL |SetCategory&| NIL NIL
                NIL NIL NIL NIL NIL NIL |BasicType&| NIL)
             (CONS
              '#((|FiniteAlgebraicExtensionField| $$) (|FiniteFieldCategory|)
                 (|ExtensionField| $$) (|FieldOfPrimeCharacteristic|) (|Field|)
                 (|EuclideanDomain|) (|PolynomialFactorizationExplicit|)
                 (|PrincipalIdealDomain|) (|UniqueFactorizationDomain|)
                 (|GcdDomain|)
                 (|FramedAlgebra| $$ (|SparseUnivariatePolynomial| $$))
                 (|IntegralDomain|)
                 (|FiniteRankAlgebra| $$ (|SparseUnivariatePolynomial| $$))
                 (|CommutativeRing|) (|DivisionRing|) (|LeftOreRing|)
                 (|Algebra| $$) (|DifferentialRing|) (|CharacteristicNonZero|)
                 (|Algebra| 31) (|EntireRing|) (|Ring|) (|Rng|) (|SemiRing|)
                 (|Module| 31) (|Module| $$) (|SemiRng|) (|FramedModule| $$)
                 (|BiModule| 31 31) (|BiModule| $$ $$) (|NonAssociativeRing|)
                 (|RightModule| 31) (|LeftModule| 31) (|LeftModule| $$)
                 (|NonAssociativeRng|) (|RightModule| $$) (|AbelianGroup|)
                 (|Monoid|) (|NonAssociativeSemiRing|)
                 (|CancellationAbelianMonoid|) (|Finite|) (|SemiGroup|)
                 (|MagmaWithUnit|) (|NonAssociativeSemiRng|) (|AbelianMonoid|)
                 (|StepThrough|) (|Comparable|) (|Magma|) (|AbelianSemiGroup|)
                 (|RetractableTo| $$) (|CommutativeStar|) (|SetCategory|)
                 (|ConvertibleTo| 8) (|CoercibleFrom| $$) (|ConvertibleTo| 28)
                 (|canonicalsClosed|) (|canonicalUnitNormal|)
                 (|noZeroDivisors|) (|TwoSidedRecip|) (|unitsKnown|)
                 (|BasicType|) (|CoercibleTo| 44))
              (|makeByteWordVec2| 44
                                  '(1 9 7 8 10 2 0 7 0 0 1 1 0 7 0 1 1 0 40 0 1
                                    1 0 0 0 1 1 0 7 0 1 1 0 7 0 1 0 0 15 1 0 0
                                    13 1 1 0 13 16 1 2 3 0 0 17 1 1 0 0 0 1 1 0
                                    24 8 1 2 0 19 0 0 1 1 0 25 14 1 1 0 0 0 1 1
                                    0 32 0 1 1 0 0 0 1 2 0 26 27 14 1 2 0 7 0 0
                                    1 2 0 7 0 0 1 0 0 15 1 0 0 0 1 1 0 19 0 1 2
                                    0 0 0 15 1 2 0 0 0 17 1 1 0 19 0 1 1 0 0 0
                                    1 1 0 0 16 1 2 0 0 16 16 1 0 0 21 1 2 0 0 0
                                    0 1 1 0 13 0 1 2 0 13 0 16 1 1 0 19 0 1 0 0
                                    17 1 0 0 0 1 2 0 0 0 0 1 1 0 38 29 1 0 0 0
                                    1 1 0 7 0 1 2 0 0 0 15 1 1 0 0 0 1 1 0 7 0
                                    1 1 0 17 0 1 1 0 20 0 1 2 0 7 0 0 1 1 0 7 0
                                    1 0 3 0 1 1 3 7 0 1 2 3 0 0 17 1 1 0 0 0 1
                                    1 0 19 0 1 2 0 35 29 0 1 1 2 14 0 1 2 3 14
                                    0 17 1 1 0 17 0 1 1 3 14 0 1 2 3 18 0 0 1 1
                                    3 14 0 1 2 3 0 0 14 1 1 0 19 0 1 2 0 0 0 15
                                    1 2 0 0 0 17 1 2 0 39 0 0 1 2 0 0 0 0 1 1 0
                                    0 29 1 1 0 41 0 1 1 0 0 0 1 0 0 0 1 1 0 0
                                    17 1 1 0 7 0 1 2 0 43 43 0 1 1 0 42 0 1 0 3
                                    0 1 2 0 14 14 14 1 2 0 0 0 0 1 1 0 0 29 1 0
                                    0 23 1 1 0 25 14 1 1 0 25 14 1 1 0 32 0 1 0
                                    0 20 1 0 0 17 1 3 0 34 0 0 0 1 2 0 36 0 0 1
                                    2 0 19 0 0 1 2 0 35 29 0 1 1 0 15 0 1 0 0
                                    29 1 2 0 37 0 0 1 0 0 0 1 1 0 0 16 1 1 0 15
                                    0 1 2 0 30 0 0 1 1 0 0 0 1 2 0 0 0 15 1 1 0
                                    20 0 1 1 0 17 0 1 0 0 14 1 0 0 0 1 0 3 0 1
                                    1 0 13 16 1 1 0 16 0 1 2 0 13 16 16 1 2 0
                                    16 0 16 1 1 0 8 0 1 1 0 16 0 1 1 0 0 16 1 1
                                    0 28 0 1 1 1 12 13 1 2 0 0 0 0 1 1 0 0 31 1
                                    1 0 0 0 1 1 0 0 8 1 1 0 44 0 1 1 0 0 0 1 1
                                    0 19 0 1 1 0 14 0 1 0 0 15 1 1 3 16 17 1 0
                                    0 16 1 3 0 0 0 0 0 1 2 0 7 0 0 1 2 0 0 0 0
                                    1 2 0 7 0 0 1 1 0 7 0 1 2 0 0 0 8 1 2 0 0 0
                                    15 1 2 0 0 0 17 1 0 0 0 1 0 0 0 1 1 3 0 0 1
                                    2 3 0 0 15 1 1 0 0 0 1 2 0 0 0 15 1 2 0 7 0
                                    0 1 2 0 0 0 0 1 1 0 0 0 1 2 0 0 0 0 1 2 0 0
                                    0 0 1 2 0 0 31 0 1 2 0 0 0 31 1 2 0 0 15 0
                                    1 2 0 0 8 0 1 2 0 0 0 0 1 2 0 0 17 0 1)))))
           '|lookupComplete|)) 
