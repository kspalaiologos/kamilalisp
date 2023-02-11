
(SDEFUN |EXPUPXS;exponential;Ups$;1|
        ((|f| (|UnivariatePuiseuxSeries| FE |var| |cen|)) ($ ($)))
        (SPADCALL |f| (QREFELT $ 10))) 

(PUT '|EXPUPXS;exponent;$Ups;2| '|SPADreplace| '(XLAM (|f|) |f|)) 

(SDEFUN |EXPUPXS;exponent;$Ups;2|
        ((|f| ($)) ($ (|UnivariatePuiseuxSeries| FE |var| |cen|))) |f|) 

(SDEFUN |EXPUPXS;exponentialOrder;$F;3|
        ((|f| ($)) ($ (|Fraction| (|Integer|))))
        (SPADCALL (SPADCALL |f| (QREFELT $ 12)) (|spadConstant| $ 14)
                  (QREFELT $ 15))) 

(SDEFUN |EXPUPXS;zero?;$B;4| ((|f| ($)) ($ (|Boolean|)))
        (NULL
         (SPADCALL (SPADCALL (SPADCALL |f| (QREFELT $ 19)) (QREFELT $ 20))
                   (QREFELT $ 22)))) 

(SDEFUN |EXPUPXS;=;2$B;5| ((|f| ($)) (|g| ($)) ($ (|Boolean|)))
        (SPADCALL
         (SPADCALL (SPADCALL (SPADCALL |f| (QREFELT $ 19)) (QREFELT $ 20))
                   (QREFELT $ 22))
         (SPADCALL (SPADCALL (SPADCALL |g| (QREFELT $ 19)) (QREFELT $ 20))
                   (QREFELT $ 22))
         (QREFELT $ 25))) 

(SDEFUN |EXPUPXS;<;2$B;6| ((|f| ($)) (|g| ($)) ($ (|Boolean|)))
        (SPROG
         ((|gCoef| (FE)) (|fCoef| (FE)) (|ordg| #1=(|Fraction| (|Integer|)))
          (|ordf| #1#))
         (SEQ
          (COND
           ((SPADCALL |f| (QREFELT $ 24)) (NULL (SPADCALL |g| (QREFELT $ 24))))
           ((SPADCALL |g| (QREFELT $ 24)) NIL)
           (#2='T
            (SEQ (LETT |ordf| (SPADCALL |f| (QREFELT $ 16)))
                 (LETT |ordg| (SPADCALL |g| (QREFELT $ 16)))
                 (EXIT
                  (COND ((SPADCALL |ordf| |ordg| (QREFELT $ 27)) 'T)
                        ((SPADCALL |ordf| |ordg| (QREFELT $ 28)) NIL)
                        (#2#
                         (SEQ
                          (LETT |fCoef| (SPADCALL |f| |ordf| (QREFELT $ 29)))
                          (LETT |gCoef| (SPADCALL |g| |ordg| (QREFELT $ 29)))
                          (EXIT
                           (COND
                            ((SPADCALL |fCoef| |gCoef| (QREFELT $ 30))
                             (SPADCALL (SPADCALL |f| (QREFELT $ 31))
                                       (SPADCALL |g| (QREFELT $ 31))
                                       (QREFELT $ 32)))
                            (#2#
                             (SPADCALL |fCoef| |gCoef|
                                       (QREFELT $ 33))))))))))))))) 

(SDEFUN |EXPUPXS;coerce;$Of;7| ((|f| ($)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL "%e" (QREFELT $ 36))
                  (SPADCALL (SPADCALL |f| (QREFELT $ 10)) (QREFELT $ 37))
                  (QREFELT $ 38))) 

(DECLAIM (NOTINLINE |ExponentialOfUnivariatePuiseuxSeries;|)) 

(DEFUN |ExponentialOfUnivariatePuiseuxSeries| (&REST #1=#:G759)
  (SPROG NIL
         (PROG (#2=#:G760)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T NIL NIL))
                     (HGET |$ConstructorCache|
                           '|ExponentialOfUnivariatePuiseuxSeries|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |ExponentialOfUnivariatePuiseuxSeries;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|ExponentialOfUnivariatePuiseuxSeries|)))))))))) 

(DEFUN |ExponentialOfUnivariatePuiseuxSeries;| (|#1| |#2| |#3|)
  (SPROG
   ((|pv$| NIL) (#1=#:G752 NIL) (#2=#:G753 NIL) (#3=#:G754 NIL) (#4=#:G755 NIL)
    (#5=#:G757 NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 |#2|)
    (LETT DV$3 |#3|)
    (LETT |dv$| (LIST '|ExponentialOfUnivariatePuiseuxSeries| DV$1 DV$2 DV$3))
    (LETT $ (GETREFV 62))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicNonZero|))
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicZero|))
                                        (|HasSignature| |#1|
                                                        (LIST '*
                                                              (LIST
                                                               (|devaluate|
                                                                |#1|)
                                                               '(|Fraction|
                                                                 (|Integer|))
                                                               (|devaluate|
                                                                |#1|))))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasSignature| |#1|
                                                         (LIST '*
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Fraction|
                                                                  (|Integer|))
                                                                (|devaluate|
                                                                 |#1|)))))
                                        (|HasCategory| (|Fraction| (|Integer|))
                                                       '(|SemiGroup|))
                                        (|HasCategory| |#1|
                                                       '(|Algebra|
                                                         (|Fraction|
                                                          (|Integer|))))
                                        (|HasCategory| |#1| '(|Field|))
                                        (|HasCategory| (|Fraction| (|Integer|))
                                                       '(|Comparable|))
                                        (LETT #5#
                                              (|HasCategory| |#1|
                                                             '(|CommutativeRing|)))
                                        (OR #5#
                                            (|HasCategory| |#1| '(|Field|)))
                                        (|HasSignature| |#1|
                                                        (LIST '^
                                                              (LIST
                                                               (|devaluate|
                                                                |#1|)
                                                               (|devaluate|
                                                                |#1|)
                                                               '(|Fraction|
                                                                 (|Integer|)))))
                                        (AND
                                         (|HasSignature| |#1|
                                                         (LIST '^
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Fraction|
                                                                  (|Integer|)))))
                                         (|HasSignature| |#1|
                                                         (LIST '|coerce|
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Symbol|)))))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasSignature| |#1|
                                                         (LIST '|integrate|
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Symbol|))))
                                         (|HasSignature| |#1|
                                                         (LIST '|variables|
                                                               (LIST
                                                                '(|List|
                                                                  (|Symbol|))
                                                                (|devaluate|
                                                                 |#1|)))))
                                        (LETT #4#
                                              (|HasCategory| |#1|
                                                             '(|IntegralDomain|)))
                                        (OR #5# (|HasCategory| |#1| '(|Field|))
                                            #4#)
                                        (OR (|HasCategory| |#1| '(|Field|))
                                            #4#)
                                        (LETT #3#
                                              (|HasCategory| |#1|
                                                             '(|SemiRing|)))
                                        (OR #3#
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|Fraction|
                                                                     (|Integer|))
                                                                   (|devaluate|
                                                                    |#1|)))))
                                        (LETT #2#
                                              (|HasCategory| |#1| '(|Ring|)))
                                        (OR #2#
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|Fraction|
                                                                     (|Integer|))
                                                                   (|devaluate|
                                                                    |#1|)))))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicNonZero|))
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicZero|))
                                         #5# (|HasCategory| |#1| '(|Field|))
                                         #4# #2#
                                         (|HasSignature| |#1|
                                                         (LIST '*
                                                               (LIST
                                                                (|devaluate|
                                                                 |#1|)
                                                                '(|Fraction|
                                                                  (|Integer|))
                                                                (|devaluate|
                                                                 |#1|)))))
                                        (|HasCategory| |#1|
                                                       '(|CancellationAbelianMonoid|))
                                        (LETT #1#
                                              (|HasCategory| |#1|
                                                             '(|AbelianGroup|)))
                                        (OR #1#
                                            (|HasCategory| |#1|
                                                           '(|CancellationAbelianMonoid|))
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|Fraction|
                                                                     (|Integer|))
                                                                   (|devaluate|
                                                                    |#1|)))))
                                        (OR #1#
                                            (|HasSignature| |#1|
                                                            (LIST '*
                                                                  (LIST
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   '(|Fraction|
                                                                     (|Integer|))
                                                                   (|devaluate|
                                                                    |#1|)))))))))
    (|haddProp| |$ConstructorCache| '|ExponentialOfUnivariatePuiseuxSeries|
                (LIST DV$1 DV$2 DV$3) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (AND #5# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))
         (|augmentPredVector| $ 33554432))
    (AND
     (OR (|HasCategory| |#1| '(|Field|))
         (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 67108864))
    (AND
     (OR (AND #5# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| |#1| '(|Field|))
         (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 134217728))
    (AND
     (OR (AND #5# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))) #3#
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|)
                                     '(|Fraction| (|Integer|))
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 268435456))
    (AND
     (OR (AND #5# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))) #2#
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|)
                                     '(|Fraction| (|Integer|))
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 536870912))
    (AND
     (OR (|HasCategory| |#1| '(|CancellationAbelianMonoid|))
         (AND #5# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianGroup|))
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|)
                                     '(|Fraction| (|Integer|))
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 1073741824))
    (AND
     (OR #1# (AND #5# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #4# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianGroup|))
         (|HasSignature| |#1|
                         (LIST '*
                               (LIST (|devaluate| |#1|)
                                     '(|Fraction| (|Integer|))
                                     (|devaluate| |#1|)))))
     (|augmentPredVector| $ 2147483648))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 9 (|UnivariatePuiseuxSeries| |#1| |#2| |#3|))
    $))) 

(MAKEPROP '|ExponentialOfUnivariatePuiseuxSeries| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL
              (|UnivariatePuiseuxSeries| 6 (NRTEVAL (QREFELT $ 7))
                                         (NRTEVAL (QREFELT $ 8)))
              (|local| |#1|) (|local| |#2|) (|local| |#3|) '|Rep|
              (0 . |complete|) |EXPUPXS;exponential;Ups$;1|
              |EXPUPXS;exponent;$Ups;2| (|Fraction| 44) (5 . |Zero|)
              (9 . |order|) |EXPUPXS;exponentialOrder;$F;3|
              (|Record| (|:| |k| 13) (|:| |c| 6)) (|Stream| 17) (15 . |terms|)
              (20 . |complete|) (|List| 17) (25 . |entries|) (|Boolean|)
              |EXPUPXS;zero?;$B;4| (30 . =) |EXPUPXS;=;2$B;5| (36 . >) (42 . <)
              (48 . |coefficient|) (54 . =) (60 . |reductum|) |EXPUPXS;<;2$B;6|
              (65 . |smaller?|) (|String|) (|OutputForm|) (71 . |message|)
              (76 . |coerce|) (81 . ^) |EXPUPXS;coerce;$Of;7| (|Symbol|)
              (|NonNegativeInteger|) (|List| 40) (|List| 41) (|Integer|)
              (|Union| $ '"failed")
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|List| $) (|Record| (|:| |coef| 48) (|:| |generator| $))
              (|SparseUnivariatePolynomial| $) (|Union| 48 '"failed")
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $)) (|Union| 53 '"failed")
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Factored| $) (|Stream| 6) (|PositiveInteger|) (|Mapping| 6 6)
              (|SingleInteger|) (|HashState|))
           '#(~= 87 |zero?| 93 |variable| 98 |unitNormal| 103 |unitCanonical|
              108 |unit?| 113 |truncate| 118 |terms| 131 |tanh| 136 |tan| 141
              |subtractIfCan| 146 |squareFreePart| 152 |squareFree| 157 |sqrt|
              162 |smaller?| 167 |sizeLess?| 173 |sinh| 179 |sin| 184 |series|
              189 |sech| 195 |sec| 200 |sample| 205 |rightRecip| 209
              |rightPower| 214 |rem| 226 |reductum| 232 |recip| 237 |quo| 242
              |principalIdeal| 248 |prime?| 253 |pole?| 258 |pi| 263 |order|
              267 |opposite?| 278 |one?| 284 |nthRoot| 289 |multiplyExponents|
              295 |multiEuclidean| 307 |monomial?| 313 |monomial| 318 |min| 324
              |max| 330 |map| 336 |log| 342 |leftRecip| 347 |leftPower| 352
              |leadingTerm| 364 |leadingSupport| 369 |leadingMonomial| 374
              |leadingCoefficient| 379 |lcmCoef| 384 |lcm| 390 |latex| 401
              |inv| 406 |integrate| 411 |hashUpdate!| 422 |hash| 428
              |gcdPolynomial| 433 |gcd| 439 |factor| 450 |extendedEuclidean|
              455 |extend| 468 |exquo| 474 |expressIdealMember| 480
              |exponentialOrder| 486 |exponential| 491 |exponent| 496 |exp| 501
              |eval| 506 |euclideanSize| 512 |elt| 517 |divide| 529
              |differentiate| 535 |degree| 572 |csch| 577 |csc| 582 |coth| 587
              |cot| 592 |cosh| 597 |cos| 602 |constructOrdered| 607 |construct|
              612 |complete| 617 |commutator| 622 |coerce| 628 |coefficient|
              653 |charthRoot| 659 |characteristic| 664 |center| 668 |atanh|
              673 |atan| 678 |associator| 683 |associates?| 690 |asinh| 696
              |asin| 701 |asech| 706 |asec| 711 |approximate| 716
              |antiCommutator| 722 |annihilate?| 728 |acsch| 734 |acsc| 739
              |acoth| 744 |acot| 749 |acosh| 754 |acos| 759 ^ 764 |Zero| 794
              |One| 798 D 802 >= 839 > 845 = 851 <= 857 < 863 / 869 - 881 + 892
              * 898)
           'NIL
           (CONS
            (|makeByteWordVec2| 25
                                '(0 0 7 0 7 0 7 7 0 7 16 7 15 7 1 2 10 4 3 15
                                  16 6 21 18 21 0 10 15 6 0 0 0 20 6 0 0 0 0 0
                                  21 6 6 0 25 0 24 18 18 0 0 0 0 18 0 0 0 0 6
                                  15 0 0 0 0 5 6 6 6 6 6 6 20 15 16 7 7))
            (CONS
             '#(NIL NIL |Field&| |UnivariatePowerSeriesCategory&|
                |EuclideanDomain&| |PowerSeriesCategory&| NIL
                |UniqueFactorizationDomain&| |AbelianMonoidRing&| |GcdDomain&|
                NIL NIL NIL |DivisionRing&| NIL NIL |Algebra&|
                |PartialDifferentialRing&| |DifferentialRing&| |Algebra&|
                |EntireRing&| |Algebra&| NIL NIL |Rng&| NIL |Module&| |Module&|
                |Module&| NIL NIL NIL |NonAssociativeRing&| NIL NIL NIL NIL NIL
                NIL |NonAssociativeRng&| NIL NIL NIL |AbelianGroup&| NIL NIL
                NIL NIL |NonAssociativeSemiRng&| |AbelianMonoid&| |OrderedSet&|
                NIL |MagmaWithUnit&| NIL |Magma&| |AbelianSemiGroup&|
                |SetCategory&| |TranscendentalFunctionCategory&| NIL
                |PartialOrder&| NIL |BasicType&| NIL NIL
                |TrigonometricFunctionCategory&|
                |ArcTrigonometricFunctionCategory&|
                |HyperbolicFunctionCategory&| NIL |ElementaryFunctionCategory&|
                |RadicalCategory&| NIL NIL NIL NIL NIL)
             (CONS
              '#((|UnivariatePuiseuxSeriesCategory| 6)
                 (|UnivariateSeriesWithRationalExponents| 6 13) (|Field|)
                 (|UnivariatePowerSeriesCategory| 6 13) (|EuclideanDomain|)
                 (|PowerSeriesCategory| 6 13 (|SingletonAsOrderedSet|))
                 (|PrincipalIdealDomain|) (|UniqueFactorizationDomain|)
                 (|AbelianMonoidRing| 6 13) (|GcdDomain|) (|IntegralDomain|)
                 (|LeftOreRing|) (|CommutativeRing|) (|DivisionRing|)
                 (|CharacteristicNonZero|) (|CharacteristicZero|) (|Algebra| 6)
                 (|PartialDifferentialRing| 40) (|DifferentialRing|)
                 (|Algebra| $$) (|EntireRing|) (|Algebra| 13) (|Ring|)
                 (|SemiRing|) (|Rng|) (|SemiRng|) (|Module| 6) (|Module| $$)
                 (|Module| 13) (|IndexedProductCategory| 6 13) (|BiModule| 6 6)
                 (|BiModule| $$ $$) (|NonAssociativeRing|) (|BiModule| 13 13)
                 (|AbelianProductCategory| 6) (|LeftModule| 6)
                 (|RightModule| 6) (|RightModule| $$) (|LeftModule| $$)
                 (|NonAssociativeRng|) (|LeftModule| 13) (|RightModule| 13)
                 (|OrderedAbelianMonoid|) (|AbelianGroup|)
                 (|OrderedAbelianSemiGroup|) (|CancellationAbelianMonoid|)
                 (|NonAssociativeSemiRing|) (|Monoid|)
                 (|NonAssociativeSemiRng|) (|AbelianMonoid|) (|OrderedSet|)
                 (|SemiGroup|) (|MagmaWithUnit|) (|Comparable|) (|Magma|)
                 (|AbelianSemiGroup|) (|SetCategory|)
                 (|TranscendentalFunctionCategory|) (|CommutativeStar|)
                 (|PartialOrder|) (|VariablesCommuteWithCoefficients|)
                 (|BasicType|) (|CoercibleTo| 35) (|Eltable| $$ $$)
                 (|TrigonometricFunctionCategory|)
                 (|ArcTrigonometricFunctionCategory|)
                 (|HyperbolicFunctionCategory|)
                 (|ArcHyperbolicFunctionCategory|)
                 (|ElementaryFunctionCategory|) (|RadicalCategory|)
                 (|unitsKnown|) (|TwoSidedRecip|) (|noZeroDivisors|)
                 (|canonicalUnitNormal|) (|canonicalsClosed|))
              (|makeByteWordVec2| 61
                                  '(1 0 0 0 10 0 13 0 14 2 0 13 0 13 15 1 0 18
                                    0 19 1 18 0 0 20 1 18 21 0 22 2 21 23 0 0
                                    25 2 13 23 0 0 27 2 13 23 0 0 28 2 0 6 0 13
                                    29 2 6 23 0 0 30 1 0 0 0 31 2 6 23 0 0 33 1
                                    35 0 34 36 1 9 35 0 37 2 35 0 0 0 38 2 0 23
                                    0 0 1 1 0 23 0 24 1 0 40 0 1 1 27 46 0 1 1
                                    27 0 0 1 1 27 23 0 1 2 0 0 0 13 1 3 0 0 0
                                    13 13 1 1 0 18 0 19 1 6 0 0 1 1 6 0 0 1 2
                                    31 45 0 0 1 1 7 0 0 1 1 7 56 0 1 1 6 0 0 1
                                    2 0 23 0 0 1 2 7 23 0 0 1 1 6 0 0 1 1 6 0 0
                                    1 2 0 0 41 18 1 1 6 0 0 1 1 6 0 0 1 0 0 0 1
                                    1 29 45 0 1 2 29 0 0 41 1 2 0 0 0 58 1 2 7
                                    0 0 0 1 1 8 0 0 31 1 29 45 0 1 2 7 0 0 0 1
                                    1 7 49 48 1 1 7 23 0 1 1 0 23 0 1 0 6 0 1 1
                                    0 13 0 1 2 0 13 0 13 15 2 0 23 0 0 1 1 29
                                    23 0 1 2 6 0 0 44 1 2 0 0 0 13 1 2 0 0 0 58
                                    1 2 7 51 48 0 1 1 0 23 0 1 2 0 0 6 13 1 2 0
                                    0 0 0 1 2 0 0 0 0 1 2 0 0 59 0 1 1 6 0 0 1
                                    1 29 45 0 1 2 29 0 0 41 1 2 0 0 0 58 1 1 8
                                    17 0 1 1 8 13 0 1 1 0 0 0 1 1 0 6 0 1 2 7
                                    47 0 0 1 1 7 0 48 1 2 7 0 0 0 1 1 0 34 0 1
                                    1 7 0 0 1 2 13 0 0 40 1 1 6 0 0 1 2 0 61 61
                                    0 1 1 0 60 0 1 2 7 50 50 50 1 1 7 0 48 1 2
                                    7 0 0 0 1 1 7 56 0 1 3 7 54 0 0 0 1 2 7 55
                                    0 0 1 2 0 0 0 13 1 2 27 45 0 0 1 2 7 51 48
                                    0 1 1 0 13 0 16 1 0 0 5 11 1 0 5 0 12 1 6 0
                                    0 1 2 11 57 0 6 1 1 7 41 0 1 2 5 0 0 0 1 2
                                    0 6 0 13 1 2 7 52 0 0 1 2 4 0 0 40 1 3 4 0
                                    0 40 41 1 2 4 0 0 42 1 3 4 0 0 42 43 1 1 3
                                    0 0 1 2 3 0 0 41 1 1 0 13 0 1 1 6 0 0 1 1 6
                                    0 0 1 1 6 0 0 1 1 6 0 0 1 1 6 0 0 1 1 6 0 0
                                    1 1 8 0 21 1 1 0 0 21 1 1 0 0 0 10 2 30 0 0
                                    0 1 1 26 0 6 1 1 28 0 0 1 1 30 0 44 1 1 6 0
                                    13 1 1 0 35 0 39 2 0 6 0 13 29 1 1 45 0 1 0
                                    30 41 1 1 0 6 0 1 1 6 0 0 1 1 6 0 0 1 3 30
                                    0 0 0 0 1 2 27 23 0 0 1 1 6 0 0 1 1 6 0 0 1
                                    1 6 0 0 1 1 6 0 0 1 2 12 6 0 13 1 2 0 0 0 0
                                    1 2 30 23 0 0 1 1 6 0 0 1 1 6 0 0 1 1 6 0 0
                                    1 1 6 0 0 1 1 6 0 0 1 1 6 0 0 1 2 29 0 0 41
                                    1 2 6 0 0 13 1 2 6 0 0 0 1 2 7 0 0 44 1 2 0
                                    0 0 58 1 0 0 0 1 0 29 0 1 2 4 0 0 40 1 2 4
                                    0 0 42 1 3 4 0 0 42 43 1 3 4 0 0 40 41 1 1
                                    3 0 0 1 2 3 0 0 41 1 2 0 23 0 0 1 2 0 23 0
                                    0 1 2 0 23 0 0 26 2 0 23 0 0 1 2 0 23 0 0
                                    32 2 7 0 0 0 1 2 7 0 0 6 1 2 32 0 0 0 1 1
                                    32 0 0 1 2 0 0 0 0 1 2 32 0 44 0 1 2 6 0 0
                                    13 1 2 6 0 13 0 1 2 0 0 41 0 1 2 0 0 0 6 1
                                    2 0 0 6 0 1 2 0 0 0 0 1 2 0 0 58 0 1)))))
           '|lookupComplete|)) 
