
(DECLAIM (NOTINLINE |RegularChain;|)) 

(DEFUN |RegularChain| (&REST #1=#:G729)
  (SPROG NIL
         (PROG (#2=#:G730)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(T NIL))
                                               (HGET |$ConstructorCache|
                                                     '|RegularChain|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |RegularChain;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|RegularChain|)))))))))) 

(DEFUN |RegularChain;| (|#1| |#2|)
  (SPROG
   ((#1=#:G728 NIL) (|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 |#2|)
    (LETT |dv$| (LIST '|RegularChain| DV$1 DV$2))
    (LETT $ (GETREFV 43))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (AND
                                         (|HasCategory|
                                          (|NewSparseMultivariatePolynomial|
                                           |#1| (|OrderedVariableList| |#2|))
                                          (LIST '|Evalable|
                                                (LIST
                                                 '|NewSparseMultivariatePolynomial|
                                                 (|devaluate| |#1|)
                                                 (LIST '|OrderedVariableList|
                                                       (|devaluate| |#2|)))))
                                         (|HasCategory|
                                          (|NewSparseMultivariatePolynomial|
                                           |#1| (|OrderedVariableList| |#2|))
                                          '(|SetCategory|)))
                                        (|HasCategory|
                                         (|NewSparseMultivariatePolynomial|
                                          |#1| (|OrderedVariableList| |#2|))
                                         '(|ConvertibleTo| (|InputForm|)))
                                        (|HasCategory|
                                         (|NewSparseMultivariatePolynomial|
                                          |#1| (|OrderedVariableList| |#2|))
                                         '(|BasicType|))
                                        (|HasCategory|
                                         (|NewSparseMultivariatePolynomial|
                                          |#1| (|OrderedVariableList| |#2|))
                                         '(|OrderedSet|))
                                        (|HasCategory| |#1|
                                                       '(|IntegralDomain|))
                                        (|HasCategory|
                                         (|OrderedVariableList| |#2|)
                                         '(|Finite|))))))
    (|haddProp| |$ConstructorCache| '|RegularChain| (LIST DV$1 DV$2)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (AND (|HasCategory| $ '(|shallowlyMutable|)) (|augmentPredVector| $ 64))
    (AND (LETT #1# (|HasCategory| $ '(|finiteAggregate|)))
         (|augmentPredVector| $ 128))
    (AND #1#
         (|HasCategory|
          (|NewSparseMultivariatePolynomial| |#1| (|OrderedVariableList| |#2|))
          '(|BasicType|))
         (|augmentPredVector| $ 256))
    (AND #1#
         (|HasCategory|
          (|NewSparseMultivariatePolynomial| |#1| (|OrderedVariableList| |#2|))
          '(|OrderedSet|))
         (|augmentPredVector| $ 512))
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|RegularChain| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL
              (|RegularTriangularSet| 6 (|IndexedExponents| 29) 29 11)
              (|local| |#1|) (|local| |#2|) (|Equation| 11) (|List| 8)
              (|List| 11) (|NewSparseMultivariatePolynomial| 6 29) (|Boolean|)
              (|NonNegativeInteger|) (|Mapping| 11 11 11) (|InputForm|)
              (|Mapping| 12 11) (|Mapping| 12 11 11) (|Mapping| 11 11)
              (|Record| (|:| |num| 11) (|:| |den| 6))
              (|Record| (|:| |rnum| 6) (|:| |polnum| 11) (|:| |den| 6))
              (|List| $) (|Record| (|:| |val| 11) (|:| |tower| $)) (|List| 22)
              (|Union| 11 21) (|Union| 12 21)
              (|Record| (|:| |val| 12) (|:| |tower| $)) (|List| 26)
              (|Union| $ '#1="failed")
              (|OrderedVariableList| (NRTEVAL (QREFELT $ 7))) (|Union| 11 '#1#)
              (|List| 29) (|Record| (|:| |close| $) (|:| |open| 10))
              (|List| 32) (|Mapping| 12 11 10)
              (|Record| (|:| |close| 10) (|:| |open| 10))
              (|Record| (|:| |bas| $) (|:| |top| 10)) (|Union| 36 '#1#)
              (|Record| (|:| |under| $) (|:| |floor| $) (|:| |upper| $))
              (|HashState|) (|String|) (|OutputForm|) (|SingleInteger|))
           '#(~= 0 |zeroSetSplitIntoTriangularSystems| 6 |zeroSetSplit| 11
              |variables| 29 |trivialIdeal?| 34 |triangular?| 39
              |stronglyReduced?| 44 |stronglyReduce| 55 |squareFreePart| 61
              |sort| 67 |size?| 73 |select| 79 |sample| 91 |roughUnitIdeal?| 95
              |roughSubIdeal?| 100 |roughEqualIdeals?| 106 |roughBase?| 112
              |rewriteSetWithReduction| 117 |rewriteIdealWithRemainder| 125
              |rewriteIdealWithHeadRemainder| 131 |retractIfCan| 137 |retract|
              142 |rest| 147 |removeZero| 152 |removeDuplicates| 158 |remove|
              163 |remainder| 175 |reduced?| 181 |reduceByQuasiMonic| 188
              |reduce| 194 |quasiComponent| 223 |purelyTranscendental?| 228
              |purelyAlgebraicLeadingMonomial?| 234 |purelyAlgebraic?| 240
              |parts| 251 |normalized?| 256 |mvar| 267 |more?| 272 |min| 278
              |members| 283 |member?| 288 |max| 294 |map!| 305 |map| 311
              |mainVariables| 317 |mainVariable?| 322 |less?| 328 |latex| 334
              |lastSubResultantElseSplit| 339 |lastSubResultant| 346 |last| 353
              |invertibleSet| 358 |invertibleElseSplit?| 364 |invertible?| 370
              |intersect| 382 |internalAugment| 406 |initials| 418
              |initiallyReduced?| 423 |initiallyReduce| 434 |infRittWu?| 440
              |iexactQuo| 446 |headRemainder| 452 |headReduced?| 458
              |headReduce| 469 |hashUpdate!| 475 |hash| 481 |first| 486 |find|
              491 |extendIfCan| 497 |extend| 503 |every?| 533 |eval| 539 |eq?|
              565 |empty?| 571 |empty| 576 |degree| 580 |count| 585 |copy| 597
              |convert| 602 |construct| 607 |collectUpper| 612 |collectUnder|
              618 |collectQuasiMonic| 624 |collect| 629 |coerce| 635 |coHeight|
              645 |basicSet| 650 |autoReduced?| 663 |augment| 669 |any?| 693
              |algebraicVariables| 699 |algebraicCoefficients?| 704
              |algebraic?| 710 = 716 |#| 722)
           'NIL
           (CONS (|makeByteWordVec2| 2 '(0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 1 2))
                 (CONS
                  '#(|RegularTriangularSetCategory&| |TriangularSetCategory&|
                     |PolynomialSetCategory&| |Collection&|
                     |HomogeneousAggregate&| |SetCategory&| |RetractableFrom&|
                     |Aggregate&| |Evalable&| |BasicType&| NIL NIL NIL NIL NIL
                     |InnerEvalable&| NIL)
                  (CONS
                   '#((|RegularTriangularSetCategory| 6
                                                      (|IndexedExponents|
                                                       (|OrderedVariableList|
                                                        7))
                                                      (|OrderedVariableList| 7)
                                                      (|NewSparseMultivariatePolynomial|
                                                       6
                                                       (|OrderedVariableList|
                                                        7)))
                      (|TriangularSetCategory| 6
                                               (|IndexedExponents|
                                                (|OrderedVariableList| 7))
                                               (|OrderedVariableList| 7)
                                               (|NewSparseMultivariatePolynomial|
                                                6 (|OrderedVariableList| 7)))
                      (|PolynomialSetCategory| 6
                                               (|IndexedExponents|
                                                (|OrderedVariableList| 7))
                                               (|OrderedVariableList| 7)
                                               (|NewSparseMultivariatePolynomial|
                                                6 (|OrderedVariableList| 7)))
                      (|Collection|
                       (|NewSparseMultivariatePolynomial| 6
                                                          (|OrderedVariableList|
                                                           7)))
                      (|HomogeneousAggregate|
                       (|NewSparseMultivariatePolynomial| 6
                                                          (|OrderedVariableList|
                                                           7)))
                      (|SetCategory|)
                      (|RetractableFrom|
                       (|List|
                        (|NewSparseMultivariatePolynomial| 6
                                                           (|OrderedVariableList|
                                                            7))))
                      (|Aggregate|)
                      (|Evalable|
                       (|NewSparseMultivariatePolynomial| 6
                                                          (|OrderedVariableList|
                                                           7)))
                      (|BasicType|) (|shallowlyMutable|) (|finiteAggregate|)
                      (|CoercibleTo|
                       (|List|
                        (|NewSparseMultivariatePolynomial| 6
                                                           (|OrderedVariableList|
                                                            7))))
                      (|Type|) (|CoercibleTo| 41)
                      (|InnerEvalable|
                       (|NewSparseMultivariatePolynomial| 6
                                                          (|OrderedVariableList|
                                                           7))
                       (|NewSparseMultivariatePolynomial| 6
                                                          (|OrderedVariableList|
                                                           7)))
                      (|ConvertibleTo| 15))
                   (|makeByteWordVec2| 42
                                       '(2 0 12 0 0 1 1 0 33 10 1 3 0 21 10 12
                                         12 1 2 0 21 10 12 1 1 0 21 10 1 1 0 31
                                         0 1 1 0 12 0 1 1 5 12 0 1 1 0 12 0 1 2
                                         0 12 11 0 1 2 0 11 11 0 1 2 0 23 11 0
                                         1 2 0 38 0 29 1 2 0 12 0 13 1 2 8 0 16
                                         0 1 2 0 30 0 29 1 0 0 0 1 1 5 12 0 1 2
                                         5 12 0 0 1 2 5 12 0 0 1 1 5 12 0 1 4 0
                                         10 10 0 14 17 1 2 5 10 10 0 1 2 5 10
                                         10 0 1 1 0 28 10 1 1 0 0 10 1 1 0 28 0
                                         1 2 0 11 11 0 1 1 9 0 0 1 2 9 0 11 0 1
                                         2 8 0 16 0 1 2 5 20 11 0 1 3 0 12 11 0
                                         17 1 2 0 11 11 0 1 4 9 11 14 0 11 11 1
                                         3 8 11 14 0 11 1 2 8 11 14 0 1 4 0 11
                                         11 0 14 17 1 1 0 35 0 1 2 0 12 11 0 1
                                         2 0 12 11 0 1 1 0 12 0 1 2 0 12 11 0 1
                                         1 8 10 0 1 2 0 12 11 0 1 1 0 12 0 1 1
                                         0 29 0 1 2 0 12 0 13 1 1 10 11 0 1 1 8
                                         10 0 1 2 9 12 11 0 1 1 10 11 0 1 2 8
                                         11 17 0 1 2 7 0 18 0 1 2 0 0 18 0 1 1
                                         0 31 0 1 2 0 12 29 0 1 2 0 12 0 13 1 1
                                         0 40 0 1 3 0 24 11 11 0 1 3 0 23 11 11
                                         0 1 1 0 30 0 1 2 0 21 11 0 1 2 0 25 11
                                         0 1 2 0 12 11 0 1 2 0 27 11 0 1 2 0 21
                                         11 21 1 2 0 21 10 0 1 2 0 21 10 21 1 2
                                         0 21 11 0 1 2 0 0 10 0 1 2 0 0 11 0 1
                                         1 0 10 0 1 1 0 12 0 1 2 0 12 11 0 1 2
                                         0 11 11 0 1 2 0 12 0 0 1 2 5 6 6 6 1 2
                                         5 19 11 0 1 1 0 12 0 1 2 0 12 11 0 1 2
                                         0 11 11 0 1 2 0 39 39 0 1 1 0 42 0 1 1
                                         0 30 0 1 2 0 30 16 0 1 2 0 28 0 11 1 2
                                         0 21 10 21 1 2 0 21 11 21 1 2 0 21 10
                                         0 1 2 0 21 11 0 1 2 0 0 0 11 1 2 8 12
                                         16 0 1 2 1 0 0 8 1 2 1 0 0 9 1 3 1 0 0
                                         10 10 1 3 1 0 0 11 11 1 2 0 12 0 0 1 1
                                         0 12 0 1 0 0 0 1 1 0 13 0 1 2 9 13 11
                                         0 1 2 8 13 16 0 1 1 0 0 0 1 1 2 15 0 1
                                         1 0 0 10 1 2 0 0 0 29 1 2 0 0 0 29 1 1
                                         0 0 0 1 2 0 0 0 29 1 1 0 10 0 1 1 0 41
                                         0 1 1 6 13 0 1 3 0 37 10 16 17 1 2 0
                                         37 10 17 1 2 0 12 0 34 1 2 0 21 10 21
                                         1 2 0 21 11 21 1 2 0 21 10 0 1 2 0 21
                                         11 0 1 2 8 12 16 0 1 1 0 31 0 1 2 0 12
                                         11 0 1 2 0 12 29 0 1 2 0 12 0 0 1 1 8
                                         13 0 1)))))
           '|lookupComplete|)) 
