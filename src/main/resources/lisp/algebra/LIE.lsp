
(SDEFUN |LIE;*;3$;1| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (SPADCALL |a| |b| (QREFELT $ 9))
                  (SPADCALL |b| |a| (QREFELT $ 9)) (QREFELT $ 10))) 

(PUT '|LIE;coerce;$A;2| '|SPADreplace| '(XLAM (|a|) |a|)) 

(SDEFUN |LIE;coerce;$A;2| ((|a| ($)) ($ (A))) |a|) 

(PUT '|LIE;coerce;A$;3| '|SPADreplace| '(XLAM (|a|) |a|)) 

(SDEFUN |LIE;coerce;A$;3| ((|a| (A)) ($ ($))) |a|) 

(SDEFUN |LIE;^;$Pi$;4| ((|a| ($)) (|n| (|PositiveInteger|)) ($ ($)))
        (COND ((EQL |n| 1) |a|) ('T (|spadConstant| $ 15)))) 

(DECLAIM (NOTINLINE |AssociatedLieAlgebra;|)) 

(DEFUN |AssociatedLieAlgebra| (&REST #1=#:G717)
  (SPROG NIL
         (PROG (#2=#:G718)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|AssociatedLieAlgebra|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |AssociatedLieAlgebra;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|AssociatedLieAlgebra|)))))))))) 

(DEFUN |AssociatedLieAlgebra;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|AssociatedLieAlgebra| DV$1 DV$2))
          (LETT $ (GETREFV 38))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             (LIST
                                                              '|FramedNonAssociativeAlgebra|
                                                              (|devaluate|
                                                               |#1|)))
                                              (AND
                                               (|HasCategory| |#1| '(|Finite|))
                                               (|HasCategory| |#2|
                                                              (LIST
                                                               '|FramedNonAssociativeAlgebra|
                                                               (|devaluate|
                                                                |#1|))))
                                              (|HasCategory| |#2|
                                                             (LIST
                                                              '|FiniteRankNonAssociativeAlgebra|
                                                              (|devaluate|
                                                               |#1|)))
                                              (OR
                                               (AND
                                                (|HasCategory| |#1|
                                                               '(|IntegralDomain|))
                                                (|HasCategory| |#2|
                                                               (LIST
                                                                '|FiniteRankNonAssociativeAlgebra|
                                                                (|devaluate|
                                                                 |#1|))))
                                               (AND
                                                (|HasCategory| |#1|
                                                               '(|IntegralDomain|))
                                                (|HasCategory| |#2|
                                                               (LIST
                                                                '|FramedNonAssociativeAlgebra|
                                                                (|devaluate|
                                                                 |#1|)))))
                                              (OR
                                               (|HasCategory| |#2|
                                                              (LIST
                                                               '|FiniteRankNonAssociativeAlgebra|
                                                               (|devaluate|
                                                                |#1|)))
                                               (|HasCategory| |#2|
                                                              (LIST
                                                               '|FramedNonAssociativeAlgebra|
                                                               (|devaluate|
                                                                |#1|))))
                                              (AND
                                               (|HasCategory| |#1| '(|Field|))
                                               (|HasCategory| |#2|
                                                              (LIST
                                                               '|FramedNonAssociativeAlgebra|
                                                               (|devaluate|
                                                                |#1|))))))))
          (|haddProp| |$ConstructorCache| '|AssociatedLieAlgebra|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 5 |#2|)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 |#2|)
          $))) 

(MAKEPROP '|AssociatedLieAlgebra| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|local| |#2|) (|local| |#1|) (|local| |#2|)
              '|Rep| (0 . *) (6 . -) |LIE;*;3$;1| |LIE;coerce;$A;2|
              |LIE;coerce;A$;3| (12 . |One|) (16 . |Zero|) (|PositiveInteger|)
              |LIE;^;$Pi$;4| (|SparseUnivariatePolynomial| (|Polynomial| 6))
              (|List| $) (|NonNegativeInteger|) (|Boolean|) (|InputForm|)
              (|Union| $ '#1="failed")
              (|Record| (|:| |particular| $) (|:| |basis| 19))
              (|Union| 24 '#1#) (|SparseUnivariatePolynomial| 6) (|List| 30)
              (|Matrix| 6) (|Vector| $) (|Vector| 6) (|Vector| 28)
              (|List| (|Polynomial| 6)) (|Integer|) (|HashState|) (|String|)
              (|OutputForm|) (|SingleInteger|))
           '#(~= 20 |zero?| 26 |unit| 31 |subtractIfCan| 35
              |structuralConstants| 41 |someBasis| 50 |smaller?| 54 |size| 60
              |sample| 64 |rightUnits| 68 |rightUnit| 72 |rightTraceMatrix| 76
              |rightTrace| 85 |rightRegularRepresentation| 90 |rightRecip| 101
              |rightRankPolynomial| 106 |rightPower| 110 |rightNorm| 116
              |rightMinimalPolynomial| 121 |rightDiscriminant| 126
              |rightCharacteristicPolynomial| 135 |rightAlternative?| 140
              |represents| 144 |recip| 155 |rank| 160 |random| 164
              |powerAssociative?| 168 |plenaryPower| 172 |opposite?| 178
              |noncommutativeJordanAlgebra?| 184 |lookup| 188 |lieAlgebra?| 193
              |lieAdmissible?| 197 |leftUnits| 201 |leftUnit| 205
              |leftTraceMatrix| 209 |leftTrace| 218 |leftRegularRepresentation|
              223 |leftRecip| 234 |leftRankPolynomial| 239 |leftPower| 243
              |leftNorm| 249 |leftMinimalPolynomial| 254 |leftDiscriminant| 259
              |leftCharacteristicPolynomial| 268 |leftAlternative?| 273 |latex|
              277 |jordanAlgebra?| 282 |jordanAdmissible?| 286
              |jacobiIdentity?| 290 |index| 294 |hashUpdate!| 299 |hash| 305
              |flexible?| 310 |enumerate| 314 |elt| 318 |coordinates| 324
              |convert| 346 |conditionsForIdempotents| 361 |commutator| 370
              |commutative?| 376 |coerce| 380 |basis| 395
              |associatorDependence| 399 |associator| 403 |associative?| 410
              |apply| 414 |antiCommutator| 420 |antiCommutative?| 426
              |antiAssociative?| 430 |alternative?| 434 ^ 438 |Zero| 444 = 448
              - 454 + 465 * 471)
           'NIL
           (CONS
            (|makeByteWordVec2| 5
                                '(1 5 0 0 0 1 0 0 0 0 0 0 0 2 0 0 2 0 0 0 0 4
                                  2))
            (CONS
             '#(|FramedNonAssociativeAlgebra&|
                |FiniteRankNonAssociativeAlgebra&| |NonAssociativeAlgebra&|
                |Module&| NIL |FramedModule&| |NonAssociativeRng&| NIL NIL
                |AbelianGroup&| NIL |NonAssociativeSemiRng&| |AbelianMonoid&|
                |Finite&| |AbelianSemiGroup&| |Magma&| NIL |SetCategory&| NIL
                |BasicType&| NIL NIL NIL)
             (CONS
              '#((|FramedNonAssociativeAlgebra| 6)
                 (|FiniteRankNonAssociativeAlgebra| 6)
                 (|NonAssociativeAlgebra| 6) (|Module| 6) (|BiModule| 6 6)
                 (|FramedModule| 6) (|NonAssociativeRng|) (|RightModule| 6)
                 (|LeftModule| 6) (|AbelianGroup|)
                 (|CancellationAbelianMonoid|) (|NonAssociativeSemiRng|)
                 (|AbelianMonoid|) (|Finite|) (|AbelianSemiGroup|) (|Magma|)
                 (|Comparable|) (|SetCategory|) (|CoercibleTo| 7) (|BasicType|)
                 (|CoercibleTo| 36) (|unitsKnown|) (|ConvertibleTo| 22))
              (|makeByteWordVec2| 37
                                  '(2 8 0 0 0 9 2 8 0 0 0 10 0 6 0 14 0 0 0 15
                                    2 0 21 0 0 1 1 0 21 0 1 0 4 23 1 2 0 23 0 0
                                    1 1 3 31 29 1 0 1 31 1 0 3 29 1 2 2 21 0 0
                                    1 0 2 20 1 0 0 0 1 0 4 25 1 0 4 23 1 1 3 28
                                    29 1 0 1 28 1 1 3 6 0 1 2 3 28 0 29 1 1 1
                                    28 0 1 1 4 23 0 1 0 6 18 1 2 0 0 0 16 1 1 3
                                    6 0 1 1 4 26 0 1 1 3 6 29 1 0 1 6 1 1 3 26
                                    0 1 0 3 21 1 2 3 0 30 29 1 1 1 0 30 1 1 4
                                    23 0 1 0 3 16 1 0 2 0 1 0 3 21 1 2 0 0 0 16
                                    1 2 0 21 0 0 1 0 3 21 1 1 2 16 0 1 0 3 21 1
                                    0 3 21 1 0 4 25 1 0 4 23 1 1 3 28 29 1 0 1
                                    28 1 1 3 6 0 1 2 3 28 0 29 1 1 1 28 0 1 1 4
                                    23 0 1 0 6 18 1 2 0 0 0 16 1 1 3 6 0 1 1 4
                                    26 0 1 1 3 6 29 1 0 1 6 1 1 3 26 0 1 0 3 21
                                    1 1 0 35 0 1 0 3 21 1 0 3 21 1 0 3 21 1 1 2
                                    0 16 1 2 0 34 34 0 1 1 0 37 0 1 0 3 21 1 0
                                    2 19 1 2 1 6 0 33 1 2 3 30 0 29 1 2 3 28 29
                                    29 1 1 1 30 0 1 1 1 28 29 1 1 2 22 0 1 1 1
                                    30 0 1 1 1 0 30 1 1 3 32 29 1 0 1 32 1 2 0
                                    0 0 0 1 0 3 21 1 1 0 0 5 13 1 0 5 0 12 1 0
                                    36 0 1 0 1 29 1 0 4 27 1 3 0 0 0 0 0 1 0 3
                                    21 1 2 1 0 28 0 1 2 0 0 0 0 1 0 3 21 1 0 3
                                    21 1 0 3 21 1 2 0 0 0 16 17 0 0 0 15 2 0 21
                                    0 0 1 1 0 0 0 1 2 0 0 0 0 1 2 0 0 0 0 1 2 0
                                    0 6 0 1 2 0 0 0 6 1 2 0 0 20 0 1 2 0 0 33 0
                                    1 2 0 0 0 0 11 2 0 0 16 0 1)))))
           '|lookupComplete|)) 
