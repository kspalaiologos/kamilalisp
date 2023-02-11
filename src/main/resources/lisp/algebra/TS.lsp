
(SDEFUN |TS;polynomial;$NniP;1|
        ((|s| ($)) (|n| (|NonNegativeInteger|)) ($ (|Polynomial| |Coef|)))
        (SPROG ((|sum| (|Polynomial| |Coef|)) (#1=#:G705 NIL) (|i| NIL))
               (SEQ (LETT |sum| (|spadConstant| $ 9))
                    (SEQ (LETT |i| 0) (LETT #1# |n|) G190
                         (COND
                          ((OR (|greater_SI| |i| #1#)
                               (NULL (NULL (SPADCALL |s| (QREFELT $ 11)))))
                           (GO G191)))
                         (SEQ
                          (LETT |sum|
                                (SPADCALL |sum| (SPADCALL |s| (QREFELT $ 12))
                                          (QREFELT $ 13)))
                          (EXIT (LETT |s| (SPADCALL |s| (QREFELT $ 14)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |sum|)))) 

(DECLAIM (NOTINLINE |TaylorSeries;|)) 

(DEFUN |TaylorSeries| (#1=#:G727)
  (SPROG NIL
         (PROG (#2=#:G728)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|TaylorSeries|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|TaylorSeries;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|TaylorSeries|)))))))))) 

(DEFUN |TaylorSeries;| (|#1|)
  (SPROG
   ((#1=#:G726 NIL) (|pv$| NIL) (#2=#:G725 NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|TaylorSeries| DV$1))
    (LETT $ (GETREFV 37))
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
                                                       '(|IntegralDomain|))
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicNonZero|))
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicZero|))
                                        (LETT #2#
                                              (|HasCategory| |#1|
                                                             '(|CommutativeRing|)))
                                        (OR #2#
                                            (|HasCategory| |#1|
                                                           '(|IntegralDomain|)))
                                        (|HasCategory| |#1| '(|Field|))
                                        (|HasCategory|
                                         (|IndexedExponents| (|Symbol|))
                                         '(|Comparable|))))))
    (|haddProp| |$ConstructorCache| '|TaylorSeries| (LIST DV$1) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (AND #2# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))
         (|augmentPredVector| $ 256))
    (AND
     (LETT #1#
           (AND (|HasCategory| |#1| '(|IntegralDomain|))
                (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 512))
    (AND
     (OR (AND #2# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))) #1#)
     (|augmentPredVector| $ 1024))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 7 (|Stream| (|Polynomial| |#1|)))
    $))) 

(MAKEPROP '|TaylorSeries| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|SparseMultivariateTaylorSeries| 6 23 8)
              (|local| |#1|) '|Rep| (|Polynomial| 6) (0 . |Zero|) (|Boolean|)
              (4 . |empty?|) (9 . |frst|) (14 . +) (20 . |rst|)
              (|NonNegativeInteger|) |TS;polynomial;$NniP;1|
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Union| $ '"failed") (|Record| (|:| |k| 21) (|:| |c| 6))
              (|List| 19) (|IndexedExponents| 23) (|Mapping| $) (|Symbol|)
              (|Integer|) (|Fraction| 24) (|List| 23) (|List| 15) (|List| $)
              (|Equation| $) (|List| 29) (|Mapping| 6 6) (|PositiveInteger|)
              (|HashState|) (|String|) (|OutputForm|) (|SingleInteger|))
           '#(~= 25 |zero?| 31 |unitNormal| 36 |unitCanonical| 41 |unit?| 46
              |tanh| 51 |tan| 56 |subtractIfCan| 61 |sqrt| 67 |sinh| 72 |sin|
              77 |sech| 82 |sec| 87 |sample| 92 |rightRecip| 96 |rightPower|
              101 |reductum| 113 |recip| 118 |polynomial| 123 |pole?| 136 |pi|
              141 |order| 145 |opposite?| 158 |one?| 164 |nthRoot| 169
              |monomial?| 175 |monomial| 180 |map| 200 |log| 206 |leftRecip|
              211 |leftPower| 216 |leadingTerm| 228 |leadingSupport| 233
              |leadingMonomial| 238 |leadingCoefficient| 243 |latex| 248
              |integrate| 253 |hashUpdate!| 266 |hash| 272 |fintegrate| 277
              |extend| 284 |exquo| 290 |exp| 296 |eval| 301 |differentiate| 341
              |degree| 367 |csch| 372 |csc| 377 |coth| 382 |cot| 387 |cosh| 392
              |cos| 397 |constructOrdered| 402 |construct| 407 |complete| 412
              |commutator| 417 |coerce| 423 |coefficient| 458 |charthRoot| 484
              |characteristic| 489 |atanh| 493 |atan| 498 |associator| 503
              |associates?| 510 |asinh| 516 |asin| 521 |asech| 526 |asec| 531
              |antiCommutator| 536 |annihilate?| 542 |acsch| 548 |acsc| 553
              |acoth| 558 |acot| 563 |acosh| 568 |acos| 573 ^ 578 |Zero| 602
              |One| 606 D 610 = 636 / 642 - 648 + 659 * 665)
           'NIL
           (CONS
            (|makeByteWordVec2| 6
                                '(0 0 0 2 6 0 1 6 2 3 4 5 0 0 0 0 1 6 5 0 0 0 0
                                  1 0 0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 0 1 6
                                  0 0 0 0 0 0 1 1 1 1 1 1 6 2))
            (CONS
             '#(|MultivariateTaylorSeriesCategory&| |PowerSeriesCategory&|
                |AbelianMonoidRing&| NIL NIL |PartialDifferentialRing&|
                |Algebra&| |Algebra&| |EntireRing&| NIL NIL |Algebra&| NIL
                |Rng&| NIL NIL |Module&| |Module&| |Module&| NIL NIL
                |NonAssociativeRing&| NIL NIL NIL NIL NIL |NonAssociativeRng&|
                NIL NIL NIL NIL |AbelianGroup&| NIL NIL NIL NIL
                |MagmaWithUnit&| |NonAssociativeSemiRng&| |AbelianMonoid&|
                |Magma&| |AbelianSemiGroup&| |Evalable&| |SetCategory&|
                |TranscendentalFunctionCategory&| NIL |InnerEvalable&|
                |InnerEvalable&| NIL NIL |BasicType&| NIL
                |TrigonometricFunctionCategory&|
                |ArcTrigonometricFunctionCategory&|
                |HyperbolicFunctionCategory&| NIL |ElementaryFunctionCategory&|
                |RadicalCategory&| NIL NIL)
             (CONS
              '#((|MultivariateTaylorSeriesCategory| 6 23)
                 (|PowerSeriesCategory| 6 21 23) (|AbelianMonoidRing| 6 21)
                 (|IntegralDomain|) (|CommutativeRing|)
                 (|PartialDifferentialRing| 23) (|Algebra| 25) (|Algebra| $$)
                 (|EntireRing|) (|CharacteristicNonZero|)
                 (|CharacteristicZero|) (|Algebra| 6) (|Ring|) (|Rng|)
                 (|SemiRing|) (|SemiRng|) (|Module| 25) (|Module| $$)
                 (|Module| 6) (|IndexedProductCategory| 6 21) (|BiModule| 6 6)
                 (|NonAssociativeRing|) (|BiModule| $$ $$) (|BiModule| 25 25)
                 (|AbelianProductCategory| 6) (|LeftModule| 6)
                 (|RightModule| 6) (|NonAssociativeRng|) (|RightModule| $$)
                 (|LeftModule| $$) (|LeftModule| 25) (|RightModule| 25)
                 (|AbelianGroup|) (|Monoid|) (|NonAssociativeSemiRing|)
                 (|CancellationAbelianMonoid|) (|SemiGroup|) (|MagmaWithUnit|)
                 (|NonAssociativeSemiRng|) (|AbelianMonoid|) (|Magma|)
                 (|AbelianSemiGroup|) (|Evalable| $$) (|SetCategory|)
                 (|TranscendentalFunctionCategory|) (|CommutativeStar|)
                 (|InnerEvalable| $$ $$) (|InnerEvalable| 23 $$)
                 (|VariablesCommuteWithCoefficients|) (|unitsKnown|)
                 (|BasicType|) (|CoercibleTo| 35)
                 (|TrigonometricFunctionCategory|)
                 (|ArcTrigonometricFunctionCategory|)
                 (|HyperbolicFunctionCategory|)
                 (|ArcHyperbolicFunctionCategory|)
                 (|ElementaryFunctionCategory|) (|RadicalCategory|)
                 (|TwoSidedRecip|) (|noZeroDivisors|))
              (|makeByteWordVec2| 36
                                  '(0 8 0 9 1 7 10 0 11 1 7 8 0 12 2 8 0 0 0 13
                                    1 7 0 0 14 2 0 10 0 0 1 1 0 10 0 1 1 10 17
                                    0 1 1 10 0 0 1 1 10 10 0 1 1 1 0 0 1 1 1 0
                                    0 1 2 0 18 0 0 1 1 1 0 0 1 1 1 0 0 1 1 1 0
                                    0 1 1 1 0 0 1 1 1 0 0 1 0 0 0 1 1 0 18 0 1
                                    2 0 0 0 15 1 2 0 0 0 32 1 1 8 0 0 1 1 0 18
                                    0 1 2 0 8 0 15 16 3 0 8 0 15 15 1 1 0 10 0
                                    1 0 1 0 1 2 0 15 0 23 1 3 0 15 0 23 15 1 2
                                    0 10 0 0 1 1 0 10 0 1 2 1 0 0 24 1 1 0 10 0
                                    1 3 0 0 0 23 15 1 3 0 0 0 26 27 1 2 0 0 6
                                    21 1 2 0 0 31 0 1 1 1 0 0 1 1 0 18 0 1 2 0
                                    0 0 15 1 2 0 0 0 32 1 1 8 19 0 1 1 8 21 0 1
                                    1 0 0 0 1 1 0 6 0 1 1 0 34 0 1 3 1 0 0 23 6
                                    1 2 1 0 0 23 1 2 0 33 33 0 1 1 0 36 0 1 3 1
                                    0 22 23 6 1 2 0 0 0 15 1 2 10 18 0 0 1 1 1
                                    0 0 1 3 0 0 0 28 28 1 2 0 0 0 29 1 3 0 0 0
                                    0 0 1 3 0 0 0 26 28 1 2 0 0 0 30 1 3 0 0 0
                                    23 0 1 3 0 0 0 23 15 1 3 0 0 0 26 27 1 2 0
                                    0 0 23 1 2 0 0 0 26 1 1 0 21 0 1 1 1 0 0 1
                                    1 1 0 0 1 1 1 0 0 1 1 1 0 0 1 1 1 0 0 1 1 1
                                    0 0 1 1 8 0 20 1 1 0 0 20 1 1 0 0 0 1 2 0 0
                                    0 0 1 1 9 0 6 1 1 11 0 0 1 1 1 0 25 1 1 0 0
                                    8 1 1 0 0 23 1 1 0 0 24 1 1 0 35 0 1 2 0 8
                                    0 15 1 3 0 0 0 26 27 1 3 0 0 0 23 15 1 2 0
                                    6 0 21 1 1 3 18 0 1 0 0 15 1 1 1 0 0 1 1 1
                                    0 0 1 3 0 0 0 0 0 1 2 10 10 0 0 1 1 1 0 0 1
                                    1 1 0 0 1 1 1 0 0 1 1 1 0 0 1 2 0 0 0 0 1 2
                                    0 10 0 0 1 1 1 0 0 1 1 1 0 0 1 1 1 0 0 1 1
                                    1 0 0 1 1 1 0 0 1 1 1 0 0 1 2 1 0 0 25 1 2
                                    1 0 0 0 1 2 0 0 0 15 1 2 0 0 0 32 1 0 0 0 1
                                    0 0 0 1 3 0 0 0 23 15 1 3 0 0 0 26 27 1 2 0
                                    0 0 23 1 2 0 0 0 26 1 2 0 10 0 0 1 2 7 0 0
                                    6 1 2 0 0 0 0 1 1 0 0 0 1 2 0 0 0 0 1 2 1 0
                                    0 25 1 2 1 0 25 0 1 2 0 0 0 6 1 2 0 0 6 0 1
                                    2 0 0 15 0 1 2 0 0 24 0 1 2 0 0 0 0 1 2 0 0
                                    32 0 1)))))
           '|lookupComplete|)) 
