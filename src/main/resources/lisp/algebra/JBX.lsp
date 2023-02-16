
(SDEFUN |JBX;coerce;JB$;1| ((|jv| (JB)) ($ ($)))
        (COND
         ((SPADCALL (SPADCALL |jv| (QREFELT $ 9)) '|Indep| (QREFELT $ 11))
          (|error| "Only functions of independent variables allowed"))
         ('T (SPADCALL |jv| (QREFELT $ 12))))) 

(SDEFUN |JBX;retractIfCan;JbeU;2|
        ((|p| (|JetBundleExpression| JB)) ($ (|Union| $ "failed")))
        (SPROG ((#1=#:G726 NIL) (|jv| NIL) (#2=#:G725 NIL))
               (SEQ
                (COND
                 ((SPADCALL (ELT $ 16)
                            (PROGN
                             (LETT #2# NIL)
                             (SEQ (LETT |jv| NIL)
                                  (LETT #1# (SPADCALL |p| (QREFELT $ 15))) G190
                                  (COND
                                   ((OR (ATOM #1#)
                                        (PROGN (LETT |jv| (CAR #1#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #2#
                                          (CONS
                                           (EQUAL (SPADCALL |jv| (QREFELT $ 9))
                                                  '|Indep|)
                                           #2#))))
                                  (LETT #1# (CDR #1#)) (GO G190) G191
                                  (EXIT (NREVERSE #2#))))
                            'T (QREFELT $ 19))
                  (CONS 0 |p|))
                 ('T (CONS 1 "failed")))))) 

(SDEFUN |JBX;retract;Jbe$;3| ((|p| (|JetBundleExpression| JB)) ($ ($)))
        (SPROG ((|px| (|Union| $ "failed")))
               (SEQ (LETT |px| (SPADCALL |p| (QREFELT $ 21)))
                    (EXIT
                     (COND
                      ((QEQCAR |px| 1)
                       (|error|
                        "Only functions of independent variables allowed"))
                      ('T (QCDR |px|))))))) 

(DECLAIM (NOTINLINE |JetBundleXExpression;|)) 

(DEFUN |JetBundleXExpression| (#1=#:G819)
  (SPROG NIL
         (PROG (#2=#:G820)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|JetBundleXExpression|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|JetBundleXExpression;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|JetBundleXExpression|)))))))))) 

(DEFUN |JetBundleXExpression;| (|#1|)
  (SPROG ((|pv$| NIL) (#1=#:G818 NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|JetBundleXExpression| DV$1))
          (LETT $ (GETREFV 94))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| (|Integer|)
                                                             '(|IntegralDomain|))
                                              (|HasCategory| (|Integer|)
                                                             '(|CommutativeRing|))
                                              (|HasCategory| (|Integer|)
                                                             '(|CharacteristicNonZero|))
                                              (|HasCategory| (|Integer|)
                                                             '(|CharacteristicZero|))
                                              (|HasCategory| (|Integer|)
                                                             '(|Ring|))
                                              (|HasCategory| (|Integer|)
                                                             '(|Group|))
                                              (|HasCategory| (|Integer|)
                                                             '(|ConvertibleTo|
                                                               (|InputForm|)))
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
                                              (LETT #1#
                                                    (|HasCategory| (|Integer|)
                                                                   '(|RetractableTo|
                                                                     (|Integer|))))
                                              (OR
                                               (|HasCategory| (|Integer|)
                                                              '(|RetractableTo|
                                                                (|Fraction|
                                                                 (|Integer|))))
                                               (AND #1#
                                                    (|HasCategory| (|Integer|)
                                                                   '(|IntegralDomain|))))
                                              (OR
                                               (AND
                                                (|HasCategory| (|Integer|)
                                                               '(|ConvertibleTo|
                                                                 (|Pattern|
                                                                  (|Float|))))
                                                (|HasCategory| (|Integer|)
                                                               '(|LinearlyExplicitOver|
                                                                 (|Integer|))))
                                               (AND
                                                (|HasCategory| (|Integer|)
                                                               '(|ConvertibleTo|
                                                                 (|Pattern|
                                                                  (|Integer|))))
                                                (|HasCategory| (|Integer|)
                                                               '(|LinearlyExplicitOver|
                                                                 (|Integer|))))
                                               (AND
                                                (|HasCategory| (|Integer|)
                                                               '(|ConvertibleTo|
                                                                 (|InputForm|)))
                                                (|HasCategory| (|Integer|)
                                                               '(|LinearlyExplicitOver|
                                                                 (|Integer|))))
                                               (AND
                                                (|HasCategory| (|Integer|)
                                                               '(|LinearlyExplicitOver|
                                                                 (|Integer|)))
                                                (|HasCategory| (|Integer|)
                                                               '(|PatternMatchable|
                                                                 (|Float|))))
                                               (AND
                                                (|HasCategory| (|Integer|)
                                                               '(|LinearlyExplicitOver|
                                                                 (|Integer|)))
                                                (|HasCategory| (|Integer|)
                                                               '(|PatternMatchable|
                                                                 (|Integer|))))
                                               (AND
                                                (|HasCategory| (|Integer|)
                                                               '(|LinearlyExplicitOver|
                                                                 (|Integer|)))
                                                (|HasCategory| (|Integer|)
                                                               '(|RetractableTo|
                                                                 (|Fraction|
                                                                  (|Integer|)))))
                                               (AND
                                                (|HasCategory| (|Integer|)
                                                               '(|LinearlyExplicitOver|
                                                                 (|Integer|)))
                                                #1#)
                                               (AND
                                                (|HasCategory| (|Integer|)
                                                               '(|LinearlyExplicitOver|
                                                                 (|Integer|)))
                                                (|HasCategory| (|Integer|)
                                                               '(|Group|)))
                                               (|HasCategory| (|Integer|)
                                                              '(|Ring|)))
                                              (|HasCategory| (|Integer|)
                                                             '(|AbelianSemiGroup|))
                                              (|HasCategory| (|Integer|)
                                                             '(|SemiGroup|))))))
          (|haddProp| |$ConstructorCache| '|JetBundleXExpression| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (AND (|HasCategory| $ '(|Ring|)) (|augmentPredVector| $ 65536))
          (AND (|HasCategory| $ '(|RetractableTo| (|Integer|)))
               (|augmentPredVector| $ 131072))
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 (|JetBundleExpression| |#1|))
          $))) 

(MAKEPROP '|JetBundleXExpression| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|JetBundleExpression| 6) (|local| |#1|)
              '|Rep| (|Symbol|) (0 . |type|) (|Boolean|) (5 . ~=)
              (11 . |coerce|) |JBX;coerce;JB$;1| (|List| 6)
              (16 . |jetVariables|) (21 . |and|) (|Mapping| 10 10 10)
              (|List| 10) (27 . |reduce|) (|Union| $ '"failed")
              |JBX;retractIfCan;JbeU;2| |JBX;retract;Jbe$;3| (|Fraction| 28)
              (|Union| 23 '#1="failed")
              (|Record| (|:| |coef| 28) (|:| |var| 41))
              (|Union| 25 '#2="failed") (|Union| 31 '#2#) (|Integer|)
              (|BasicOperator|) (|List| 29) (|List| $) (|InputForm|)
              (|Pattern| (|Float|)) (|Pattern| 28) (|List| 41) (|Factored| $)
              (|SparseMultivariatePolynomial| 28 41) (|Polynomial| 23)
              (|Fraction| 38) (|Fraction| 65) (|Kernel| $) (|Union| 43 '#1#)
              (|Fraction| 63) (|PatternMatchResult| (|Float|) $)
              (|PatternMatchResult| 28 $) (|AlgebraicNumber|) (|Union| 46 '#1#)
              (|Record| (|:| |mat| 51) (|:| |vec| (|Vector| 28))) (|Matrix| $)
              (|Vector| $) (|Matrix| 28)
              (|Record| (|:| |var| 41) (|:| |exponent| 28)) (|Union| 52 '#2#)
              (|List| 8) (|List| 62) (|Mapping| $ $) (|List| 56)
              (|Record| (|:| |val| $) (|:| |exponent| 28)) (|Union| 58 '#2#)
              (|Mapping| $ 31) (|List| 60) (|NonNegativeInteger|)
              (|Polynomial| 28) (|Union| 63 '#1#)
              (|SparseUnivariatePolynomial| $) (|Expression| 28)
              (|SegmentBinding| $)
              (|Record| (|:| |coef| 31) (|:| |generator| $))
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $)) (|Union| 70 '"failed")
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Polynomial| $) (|Union| 41 '#1#) (|List| 76) (|Equation| $)
              (|Union| 8 '#1#) (|Union| 28 '#1#)
              (|Union| '"failed" (|List| 55))
              (|Record| (|:| |Sys| 31) (|:| JM 81) (|:| |Depend| 79))
              (|SparseEchelonMatrix| 6 $)
              (|Record| (|:| |DSys| 31) (|:| |JVars| 85)) (|PositiveInteger|)
              (|Record| (|:| |DPhi| $) (|:| |JVars| 14)) (|List| 14) (|Void|)
              (|Union| 6 '#1#)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|String|) (|SingleInteger|) (|HashState|) (|OutputForm|))
           '#(~= 34 |zerosOf| 40 |zeroOf| 67 |zero?| 94 |whittakerW| 99
              |whittakerM| 106 |weierstrassZeta| 113 |weierstrassSigma| 120
              |weierstrassPPrime| 127 |weierstrassPInverse| 134 |weierstrassP|
              141 |weberE| 148 |variables| 154 |univariate| 164 |unitNormal|
              170 |unitCanonical| 175 |unit?| 180 |tower| 185 |tanh| 195 |tan|
              200 |symbol| 205 |summation| 210 |subtractIfCan| 222 |subst| 228
              |struveL| 254 |struveH| 260 |squareFreePart| 266 |squareFree| 271
              |sqrt| 276 |sortLD| 281 |solveFor| 286 |smaller?| 292 |sizeLess?|
              298 |sinh| 304 |sin| 309 |simplify| 314 |simpOne| 320 |simpMod|
              325 |setNotation| 338 |sech| 343 |sec| 348 |sample| 353 |rootsOf|
              357 |rootSum| 384 |rootOf| 391 |rightRecip| 418 |rightPower| 423
              |riemannZeta| 435 |retractIfCan| 440 |retract| 485 |rem| 530
              |reducedSystem| 536 |reduceMod| 547 |reduce| 553 |recip| 558
              |quo| 563 |product| 569 |principalIdeal| 581 |prime?| 586
              |polylog| 591 |polygamma| 597 |pi| 603 |permutation| 607
              |patternMatch| 613 |paren| 627 |orderDim| 632 |order| 639
              |opposite?| 644 |operators| 650 |operator| 655 |one?| 660 |odd?|
              665 |numerator| 670 |numer| 675 |numIndVar| 680 |numDepVar| 684
              |nthRoot| 688 |multiEuclidean| 694 |minPoly| 700 |meixnerM| 705
              |meijerG| 713 |map| 722 |mainKernel| 728 |lommelS2| 733
              |lommelS1| 740 |log| 747 |li| 752 |lerchPhi| 757 |legendreQ| 764
              |legendreP| 771 |leftRecip| 778 |leftPower| 783 |leadingDer| 795
              |lcmCoef| 800 |lcm| 806 |latex| 817 |lambertW| 822 |laguerreL|
              827 |kummerU| 834 |kummerM| 841 |kernels| 848 |kernel| 858
              |kelvinKer| 870 |kelvinKei| 876 |kelvinBer| 882 |kelvinBei| 888
              |jetVariables| 894 |jacobiZeta| 899 |jacobiTheta| 905 |jacobiSn|
              911 |jacobiP| 917 |jacobiMatrix| 925 |jacobiDn| 936 |jacobiCn|
              942 |isTimes| 948 |isPower| 953 |isPlus| 958 |isMult| 963
              |isExpt| 968 |is?| 985 |inv| 997 |integral| 1002
              |hypergeometricF| 1014 |hermiteH| 1021 |height| 1027
              |hashUpdate!| 1032 |hash| 1038 |hankelH2| 1043 |hankelH1| 1049
              |ground?| 1055 |ground| 1060 |getNotation| 1065 |gcdPolynomial|
              1069 |gcd| 1075 |function| 1086 |fresnelS| 1092 |fresnelC| 1097
              |freeOf?| 1102 |formalDiff2| 1120 |formalDiff| 1134 |factorials|
              1152 |factorial| 1163 |factor| 1168 |extractSymbol| 1173
              |extendedEuclidean| 1178 |exquo| 1191 |expressIdealMember| 1197
              |exp| 1203 |even?| 1208 |eval| 1213 |euclideanSize| 1357 |erfi|
              1362 |erf| 1367 |elt| 1372 |ellipticPi| 1468 |ellipticK| 1475
              |ellipticF| 1480 |ellipticE| 1486 |divide| 1497 |distribute| 1503
              |dimension| 1514 |dilog| 1521 |digamma| 1526 |differentiate| 1531
              |denominator| 1563 |denom| 1568 |definingPolynomial| 1573
              |dSubst| 1578 |csch| 1585 |csc| 1590 |coth| 1595 |cot| 1600
              |cosh| 1605 |cos| 1610 |convert| 1615 |const?| 1635 |conjugate|
              1640 |commutator| 1651 |coerce| 1657 |class| 1732 |charthRoot|
              1737 |charlierC| 1742 |characteristic| 1749 |box| 1753 |binomial|
              1758 |besselY| 1764 |besselK| 1770 |besselJ| 1776 |besselI| 1782
              |belong?| 1788 |autoReduce| 1793 |atanh| 1798 |atan| 1803
              |associator| 1808 |associates?| 1815 |asinh| 1821 |asin| 1826
              |asech| 1831 |asec| 1836 |applyQuote| 1841 |antiCommutator| 1877
              |annihilate?| 1883 |angerJ| 1889 |algtower| 1895 |airyBiPrime|
              1905 |airyBi| 1910 |airyAiPrime| 1915 |airyAi| 1920 |acsch| 1925
              |acsc| 1930 |acoth| 1935 |acot| 1940 |acosh| 1945 |acos| 1950
              |abs| 1955 ^ 1960 |Zero| 1990 X 1994 U 2003 |Si| 2012 |Shi| 2017
              P 2022 |One| 2044 |Gamma| 2048 |Ei| 2059 D 2064 |Ci| 2090 |Chi|
              2095 |Beta| 2100 = 2106 / 2112 - 2124 + 2135 * 2141)
           'NIL
           (CONS
            (|makeByteWordVec2| 14
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 5 0 0 0 0 2 3 4
                                  14 0 0 0 0 0 0 2 0 0 0 2 0 0 0 0 0 2 2 0 6 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 10 11 0 0 0 0 0 0 0
                                  0 0 0 13 1 5 12 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 13 1 5 7 8 9 12))
            (CONS
             '#(|AlgebraicallyClosedFunctionSpace&| |AlgebraicallyClosedField&|
                |FunctionSpace&| |Field&| |EuclideanDomain&|
                |JetBundleBaseFunctionCategory&| NIL
                |UniqueFactorizationDomain&| |JetBundleFunctionCategory&|
                |GcdDomain&| NIL |DivisionRing&| NIL NIL
                |FullyLinearlyExplicitOver&| |Algebra&|
                |PartialDifferentialRing&| |EntireRing&| |Algebra&| |Algebra&|
                NIL NIL NIL NIL |Rng&| NIL |Module&| |Module&| NIL |Module&|
                NIL NIL |NonAssociativeRing&| NIL NIL NIL NIL
                |NonAssociativeRng&| NIL NIL NIL |AbelianGroup&| |Group&| NIL
                NIL NIL NIL |ExpressionSpace&| NIL |MagmaWithUnit&|
                |NonAssociativeSemiRng&| |AbelianMonoid&| NIL
                |FullyRetractableTo&| NIL |Magma&| |AbelianSemiGroup&| NIL NIL
                NIL |TranscendentalFunctionCategory&| |RetractableTo&| NIL
                |RetractableTo&| |Evalable&| |RetractableTo&| |RetractableTo&|
                NIL |SetCategory&| |RetractableTo&| |RetractableTo&|
                |RetractableTo&| |RetractableTo&| NIL NIL NIL
                |ElementaryFunctionCategory&| NIL |HyperbolicFunctionCategory&|
                |ArcTrigonometricFunctionCategory&|
                |TrigonometricFunctionCategory&| |RadicalCategory&| NIL NIL NIL
                NIL NIL |InnerEvalable&| |InnerEvalable&| NIL NIL NIL NIL NIL
                |BasicType&| NIL NIL NIL NIL NIL NIL NIL NIL)
             (CONS
              '#((|AlgebraicallyClosedFunctionSpace| 28)
                 (|AlgebraicallyClosedField|) (|FunctionSpace| 28) (|Field|)
                 (|EuclideanDomain|) (|JetBundleBaseFunctionCategory| 6)
                 (|PrincipalIdealDomain|) (|UniqueFactorizationDomain|)
                 (|JetBundleFunctionCategory| 6) (|GcdDomain|)
                 (|IntegralDomain|) (|DivisionRing|) (|CommutativeRing|)
                 (|LeftOreRing|) (|FullyLinearlyExplicitOver| 28)
                 (|Algebra| 23) (|PartialDifferentialRing| 8) (|EntireRing|)
                 (|Algebra| $$) (|Algebra| 28) (|CharacteristicNonZero|)
                 (|CharacteristicZero|) (|LinearlyExplicitOver| 28) (|Ring|)
                 (|Rng|) (|SemiRing|) (|Module| 23) (|Module| $$) (|SemiRng|)
                 (|Module| 28) (|BiModule| 23 23) (|BiModule| $$ $$)
                 (|NonAssociativeRing|) (|BiModule| 28 28) (|RightModule| 23)
                 (|LeftModule| 23) (|LeftModule| $$) (|NonAssociativeRng|)
                 (|RightModule| $$) (|LeftModule| 28) (|RightModule| 28)
                 (|AbelianGroup|) (|Group|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|FullyPatternMatchable| 28) (|ExpressionSpace|) (|SemiGroup|)
                 (|MagmaWithUnit|) (|NonAssociativeSemiRng|) (|AbelianMonoid|)
                 (|LiouvillianFunctionCategory|) (|FullyRetractableTo| 28)
                 (|Comparable|) (|Magma|) (|AbelianSemiGroup|)
                 (|PatternMatchable| (|Float|)) (|PatternMatchable| 28)
                 (|CombinatorialOpsCategory|)
                 (|TranscendentalFunctionCategory|) (|RetractableTo| 28)
                 (|Patternable| 28) (|RetractableTo| 8) (|Evalable| $$)
                 (|RetractableTo| (|Kernel| $$)) (|RetractableTo| 6)
                 (|CommutativeStar|) (|SetCategory|) (|RetractableTo| 23)
                 (|RetractableTo| 43) (|RetractableTo| 63) (|RetractableTo| 46)
                 (|SpecialFunctionCategory|) (|PrimitiveFunctionCategory|)
                 (|CombinatorialFunctionCategory|)
                 (|ElementaryFunctionCategory|)
                 (|ArcHyperbolicFunctionCategory|)
                 (|HyperbolicFunctionCategory|)
                 (|ArcTrigonometricFunctionCategory|)
                 (|TrigonometricFunctionCategory|) (|RadicalCategory|)
                 (|CoercibleFrom| 28) (|Type|) (|CoercibleFrom| 8)
                 (|canonicalsClosed|) (|canonicalUnitNormal|)
                 (|InnerEvalable| $$ $$) (|InnerEvalable| (|Kernel| $$) $$)
                 (|CoercibleFrom| (|Kernel| $$)) (|CoercibleFrom| 6)
                 (|noZeroDivisors|) (|TwoSidedRecip|) (|unitsKnown|)
                 (|BasicType|) (|CoercibleTo| 93) (|CoercibleFrom| 23)
                 (|CoercibleFrom| 43) (|CoercibleFrom| 63) (|ConvertibleTo| 32)
                 (|ConvertibleTo| 33) (|ConvertibleTo| 34)
                 (|CoercibleFrom| 46))
              (|makeByteWordVec2| 93
                                  '(1 6 8 0 9 2 8 10 0 0 11 1 5 0 6 12 1 0 14 0
                                    15 2 10 0 0 0 16 3 18 10 17 0 10 19 2 0 10
                                    0 0 1 1 0 31 73 1 2 0 31 65 8 1 1 0 31 65 1
                                    1 0 31 0 1 2 0 31 0 8 1 1 0 0 73 1 2 0 0 65
                                    8 1 1 0 0 65 1 1 0 0 0 1 2 0 0 0 8 1 1 0 10
                                    0 1 3 0 0 0 0 0 1 3 0 0 0 0 0 1 3 0 0 0 0 0
                                    1 3 0 0 0 0 0 1 3 0 0 0 0 0 1 3 0 0 0 0 0 1
                                    3 0 0 0 0 0 1 2 0 0 0 0 1 1 0 54 31 1 1 0
                                    54 0 1 2 1 40 0 41 1 1 0 88 0 1 1 0 0 0 1 1
                                    0 10 0 1 1 0 35 31 1 1 0 35 0 1 1 0 0 0 1 1
                                    0 0 0 1 1 0 81 31 1 2 0 0 0 8 1 2 0 0 0 67
                                    1 2 0 20 0 0 1 2 0 0 0 75 1 2 0 0 0 76 1 3
                                    0 0 0 35 31 1 3 0 0 0 6 0 1 2 0 0 0 0 1 2 0
                                    0 0 0 1 1 0 0 0 1 1 0 36 0 1 1 0 0 0 1 1 0
                                    31 31 1 2 0 20 0 6 1 2 0 10 0 0 1 2 0 10 0
                                    0 1 1 0 0 0 1 1 0 0 0 1 2 0 80 31 81 1 1 0
                                    0 0 1 2 0 31 31 31 1 3 0 80 31 81 31 1 1 0
                                    86 8 1 1 0 0 0 1 1 0 0 0 1 0 0 0 1 1 0 31
                                    73 1 2 0 31 65 8 1 1 0 31 65 1 1 0 31 0 1 2
                                    0 31 0 8 1 3 0 0 0 65 8 1 1 0 0 73 1 2 0 0
                                    65 8 1 1 0 0 65 1 1 0 0 0 1 2 0 0 0 8 1 1 0
                                    20 0 1 2 0 0 0 62 1 2 0 0 0 83 1 1 0 0 0 1
                                    1 13 24 0 1 1 1 42 0 1 1 12 47 0 1 1 5 64 0
                                    1 1 0 20 5 21 1 0 74 0 1 1 0 77 0 1 1 0 78
                                    0 1 1 0 87 0 1 1 13 23 0 1 1 1 43 0 1 1 12
                                    46 0 1 1 5 63 0 1 1 0 0 5 22 1 0 41 0 1 1 0
                                    8 0 1 1 0 28 0 1 1 0 6 0 1 2 0 0 0 0 1 2 5
                                    48 49 50 1 1 5 51 49 1 2 0 31 31 31 1 1 0 0
                                    0 1 1 0 20 0 1 2 0 0 0 0 1 2 0 0 0 67 1 2 0
                                    0 0 8 1 1 0 68 31 1 1 0 10 0 1 2 0 0 0 0 1
                                    2 0 0 0 0 1 0 0 0 1 2 0 0 0 0 1 3 10 44 0
                                    33 44 1 3 11 45 0 34 45 1 1 0 0 0 1 3 0 62
                                    31 81 62 1 1 0 62 0 1 2 0 10 0 0 1 1 0 30 0
                                    1 1 0 29 29 1 1 0 10 0 1 1 18 10 0 1 1 0 0
                                    0 1 1 5 37 0 1 0 0 83 1 0 0 83 1 2 0 0 0 28
                                    1 2 0 27 31 0 1 1 17 65 41 1 4 0 0 0 0 0 0
                                    1 5 18 0 31 31 31 31 0 1 2 0 0 56 41 1 1 0
                                    74 0 1 3 0 0 0 0 0 1 3 0 0 0 0 0 1 1 0 0 0
                                    1 1 0 0 0 1 3 0 0 0 0 0 1 3 0 0 0 0 0 1 3 0
                                    0 0 0 0 1 1 0 20 0 1 2 0 0 0 62 1 2 0 0 0
                                    83 1 1 0 6 0 1 2 0 89 0 0 1 2 0 0 0 0 1 1 0
                                    0 31 1 1 0 90 0 1 1 0 0 0 1 3 0 0 0 0 0 1 3
                                    0 0 0 0 0 1 3 0 0 0 0 0 1 1 0 35 0 1 1 0 35
                                    31 1 2 0 0 29 0 1 2 0 0 29 31 1 2 0 0 0 0 1
                                    2 0 0 0 0 1 2 0 0 0 0 1 2 0 0 0 0 1 1 0 14
                                    0 15 2 0 0 0 0 1 2 0 0 0 0 1 2 0 0 0 0 1 4
                                    0 0 0 0 0 0 1 1 0 81 31 1 2 0 81 31 85 1 2
                                    0 0 0 0 1 2 0 0 0 0 1 1 16 27 0 1 1 5 59 0
                                    1 1 15 27 0 1 1 15 26 0 1 2 5 53 0 29 1 2 5
                                    53 0 8 1 1 16 53 0 1 2 0 10 0 29 1 2 0 10 0
                                    8 1 1 0 0 0 1 2 0 0 0 67 1 2 0 0 0 8 1 3 18
                                    0 31 31 0 1 2 0 0 0 0 1 1 0 62 0 1 2 0 92
                                    92 0 1 1 0 91 0 1 2 0 0 0 0 1 2 0 0 0 0 1 1
                                    0 10 0 1 1 0 28 0 1 0 0 8 1 2 0 65 65 65 1
                                    2 0 0 0 0 1 1 0 0 31 1 2 0 0 8 31 1 1 0 0 0
                                    1 1 0 0 0 1 2 0 10 0 0 1 2 0 10 0 8 1 2 0
                                    10 0 6 1 3 0 82 31 83 81 1 3 0 84 0 83 81 1
                                    2 0 0 0 55 1 2 0 31 31 83 1 2 0 0 0 83 1 1
                                    0 0 0 1 2 0 0 0 8 1 1 0 0 0 1 1 0 36 0 1 1
                                    0 81 81 1 3 0 71 0 0 0 1 2 0 72 0 0 1 2 0
                                    20 0 0 1 2 0 27 31 0 1 1 0 0 0 1 1 18 10 0
                                    1 4 7 0 0 29 0 8 1 4 7 0 0 30 31 8 1 4 5 0
                                    0 54 55 57 1 4 5 0 0 54 55 61 1 4 5 0 0 8
                                    62 56 1 4 5 0 0 8 62 60 1 3 0 0 0 41 0 1 2
                                    0 0 0 75 1 3 0 0 0 35 31 1 2 0 0 0 76 1 3 0
                                    0 0 31 31 1 3 0 0 0 0 0 1 3 0 0 0 54 61 1 3
                                    0 0 0 54 57 1 3 0 0 0 8 56 1 3 0 0 0 8 60 1
                                    3 0 0 0 30 57 1 3 0 0 0 29 60 1 3 0 0 0 30
                                    61 1 3 0 0 0 29 56 1 1 0 62 0 1 1 0 0 0 1 1
                                    0 0 0 1 2 0 0 29 0 1 4 0 0 29 0 0 0 1 3 0 0
                                    29 0 0 1 5 0 0 29 0 0 0 0 1 7 0 0 29 0 0 0
                                    0 0 0 1 6 0 0 29 0 0 0 0 0 1 8 0 0 29 0 0 0
                                    0 0 0 0 1 10 0 0 29 0 0 0 0 0 0 0 0 0 1 9 0
                                    0 29 0 0 0 0 0 0 0 0 1 2 0 0 29 31 1 3 0 0
                                    0 0 0 1 1 0 0 0 1 2 0 0 0 0 1 2 0 0 0 0 1 1
                                    0 0 0 1 2 0 69 0 0 1 2 0 0 0 0 1 1 0 0 0 1
                                    3 0 62 31 81 62 1 1 0 0 0 1 1 0 0 0 1 2 0 0
                                    0 6 1 3 0 0 0 54 55 1 2 0 0 0 54 1 3 0 0 0
                                    8 62 1 2 0 0 0 8 1 1 0 0 0 1 1 1 37 0 1 1
                                    17 0 0 1 3 0 0 0 6 0 1 1 0 0 0 1 1 0 0 0 1
                                    1 0 0 0 1 1 0 0 0 1 1 0 0 0 1 1 0 0 0 1 1 7
                                    32 0 1 1 8 33 0 1 1 9 34 0 1 1 1 0 36 1 1 0
                                    10 0 1 2 6 0 0 0 1 1 0 0 0 1 2 0 0 0 0 1 1
                                    1 0 38 1 1 1 0 39 1 1 1 0 43 1 1 12 0 46 1
                                    1 5 0 37 1 1 5 0 63 1 1 0 66 0 1 1 0 0 66 1
                                    1 0 0 23 1 1 0 0 41 1 1 0 0 8 1 1 0 0 6 13
                                    1 0 0 0 1 1 0 0 28 1 1 0 93 0 1 1 0 62 0 1
                                    1 3 20 0 1 3 0 0 0 0 0 1 0 0 62 1 1 0 0 0 1
                                    2 0 0 0 0 1 2 0 0 0 0 1 2 0 0 0 0 1 2 0 0 0
                                    0 1 2 0 0 0 0 1 1 0 10 29 1 1 0 31 31 1 1 0
                                    0 0 1 1 0 0 0 1 3 0 0 0 0 0 1 2 0 10 0 0 1
                                    1 0 0 0 1 1 0 0 0 1 1 0 0 0 1 1 0 0 0 1 3 0
                                    0 8 0 0 1 2 0 0 8 0 1 4 0 0 8 0 0 0 1 2 0 0
                                    8 31 1 5 0 0 8 0 0 0 0 1 2 0 0 0 0 1 2 0 10
                                    0 0 1 2 0 0 0 0 1 1 1 35 0 1 1 1 35 31 1 1
                                    0 0 0 1 1 0 0 0 1 1 0 0 0 1 1 0 0 0 1 1 0 0
                                    0 1 1 0 0 0 1 1 0 0 0 1 1 0 0 0 1 1 0 0 0 1
                                    1 0 0 0 1 1 0 0 0 1 2 0 0 0 0 1 2 0 0 0 28
                                    1 2 0 0 0 23 1 2 0 0 0 62 1 2 0 0 0 83 1 0
                                    0 0 1 0 0 0 1 1 0 0 83 1 0 0 0 1 1 0 0 83 1
                                    1 0 0 0 1 1 0 0 0 1 1 0 0 62 1 2 0 0 83 62
                                    1 1 0 0 55 1 2 0 0 83 55 1 0 0 0 1 2 0 0 0
                                    0 1 1 0 0 0 1 1 0 0 0 1 3 0 0 0 54 55 1 3 0
                                    0 0 8 62 1 2 0 0 0 8 1 2 0 0 0 54 1 1 0 0 0
                                    1 1 0 0 0 1 2 0 0 0 0 1 2 0 10 0 0 1 2 1 0
                                    37 37 1 2 0 0 0 0 1 1 0 0 0 1 2 0 0 0 0 1 2
                                    0 0 0 0 1 2 2 0 0 28 1 2 0 0 23 0 1 2 0 0 0
                                    23 1 2 0 0 62 0 1 2 0 0 28 0 1 2 0 0 0 0 1
                                    2 0 0 83 0 1)))))
           '|lookupComplete|)) 
