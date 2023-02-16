
(SDEFUN |LSQM;convert;Sm$;1| ((|x| (|SquareMatrix| |n| R)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 11))) 

(SDEFUN |LSQM;conv| ((|v| (|DirectProduct| |n2| R)) ($ (|SquareMatrix| |n| R)))
        (SPROG
         ((|z| (|Integer|)) (#1=#:G713 NIL) (|j| NIL) (#2=#:G712 NIL) (|i| NIL)
          (|cond| (|Matrix| R)))
         (SEQ
          (LETT |cond|
                (MAKE_MATRIX1 (QREFELT $ 6) (QREFELT $ 6)
                              (|spadConstant| $ 13)))
          (LETT |z| 0)
          (SEQ (LETT |i| 1) (LETT #2# (QREFELT $ 6)) G190
               (COND ((|greater_SI| |i| #2#) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |j| 1) (LETT #1# (QREFELT $ 6)) G190
                      (COND ((|greater_SI| |j| #1#) (GO G191)))
                      (SEQ (LETT |z| (+ |z| 1))
                           (EXIT
                            (SPADCALL |cond| |i| |j|
                                      (SPADCALL |v| |z| (QREFELT $ 16))
                                      (QREFELT $ 18))))
                      (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT (SPADCALL |cond| (QREFELT $ 19)))))) 

(SDEFUN |LSQM;canonical_coordinates| ((|a| ($)) ($ (|Vector| R)))
        (SPROG
         ((|z| (|Integer|)) (#1=#:G722 NIL) (|j| NIL) (#2=#:G721 NIL) (|i| NIL)
          (|as| (|SquareMatrix| |n| R)) (|res| (|Vector| R)))
         (SEQ (LETT |res| (MAKEARR1 (QREFELT $ 9) (|spadConstant| $ 13)))
              (LETT |z| 0) (LETT |as| |a|)
              (SEQ (LETT |i| 1) (LETT #2# (QREFELT $ 6)) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #1# (QREFELT $ 6)) G190
                          (COND ((|greater_SI| |j| #1#) (GO G191)))
                          (SEQ (LETT |z| (+ |z| 1))
                               (EXIT
                                (SPADCALL |res| |z|
                                          (SPADCALL |as| |i| |j|
                                                    (QREFELT $ 20))
                                          (QREFELT $ 22))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |LSQM;coordinates;$VV;4|
        ((|a| ($)) (|b| (|Vector| $)) ($ (|Vector| R)))
        (SPROG
         ((|canonical| (|Boolean|)) (#1=#:G731 NIL) (|j| NIL)
          (|bv| (|Vector| R)) (#2=#:G730 NIL) (|i| NIL))
         (SEQ (LETT |canonical| 'T)
              (SEQ (LETT |i| 1) (LETT #2# (QREFELT $ 9)) G190
                   (COND
                    ((OR (|greater_SI| |i| #2#) (NULL |canonical|)) (GO G191)))
                   (SEQ
                    (LETT |bv|
                          (|LSQM;canonical_coordinates|
                           (SPADCALL |b| |i| (QREFELT $ 24)) $))
                    (LETT |canonical|
                          (COND
                           (|canonical|
                            (SPADCALL (SPADCALL |bv| |i| (QREFELT $ 25))
                                      (|spadConstant| $ 26) (QREFELT $ 28)))
                           ('T NIL)))
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #1# (QREFELT $ 9)) G190
                          (COND
                           ((OR (|greater_SI| |j| #1#) (NULL |canonical|))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (COND ((EQL |j| |i|) "iterate")
                                  ('T
                                   (LETT |canonical|
                                         (COND
                                          (|canonical|
                                           (SPADCALL
                                            (SPADCALL |bv| |j| (QREFELT $ 25))
                                            (|spadConstant| $ 13)
                                            (QREFELT $ 28)))
                                          ('T NIL)))))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND (|canonical| (|LSQM;canonical_coordinates| |a| $))
                     ('T
                      (|error|
                       "coordinates works only in canonical basis"))))))) 

(SDEFUN |LSQM;convDM| ((|v| (|DirectProduct| |n2| R)) ($ ($)))
        (SPROG ((|sq| (|SquareMatrix| |n| R)))
               (SEQ (LETT |sq| (|LSQM;conv| |v| $))
                    (EXIT (SPADCALL |sq| (QREFELT $ 11)))))) 

(SDEFUN |LSQM;basis;V;6| (($ (|Vector| $)))
        (SPROG
         ((|res| (|Vector| $)) (|ldp| (|List| (|DirectProduct| |n2| R)))
          (#1=#:G736 NIL) (#2=#:G742 NIL) (|i| NIL) (#3=#:G741 NIL))
         (SEQ (SETELT $ 9 (* (QREFELT $ 6) (QREFELT $ 6)))
              (LETT |ldp|
                    (PROGN
                     (LETT #3# NIL)
                     (SEQ (LETT |i| 1) (LETT #2# (QREFELT $ 9)) G190
                          (COND ((|greater_SI| |i| #2#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #3#
                                  (CONS
                                   (SPADCALL
                                    (PROG1 (LETT #1# |i|)
                                      (|check_subtype2| (> #1# 0)
                                                        '(|PositiveInteger|)
                                                        '(|NonNegativeInteger|)
                                                        #1#))
                                    (QREFELT $ 32))
                                   #3#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #3#)))))
              (EXIT
               (LETT |res|
                     (SPADCALL
                      (SPADCALL (CONS (|function| |LSQM;convDM|) $) |ldp|
                                (QREFELT $ 37))
                      (QREFELT $ 38))))))) 

(SDEFUN |LSQM;someBasis;V;7| (($ (|Vector| $))) (SPADCALL (QREFELT $ 39))) 

(SDEFUN |LSQM;rank;Pi;8| (($ (|PositiveInteger|))) (QREFELT $ 9)) 

(DECLAIM (NOTINLINE |LieSquareMatrix;|)) 

(DEFUN |LieSquareMatrix| (&REST #1=#:G756)
  (SPROG NIL
         (PROG (#2=#:G757)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(NIL T))
                                               (HGET |$ConstructorCache|
                                                     '|LieSquareMatrix|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |LieSquareMatrix;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|LieSquareMatrix|)))))))))) 

(DEFUN |LieSquareMatrix;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|LieSquareMatrix| DV$1 DV$2))
          (LETT $ (GETREFV 57))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|IntegralDomain|))
                                              (|HasCategory| |#2| '(|Finite|))
                                              (|HasCategory| |#2|
                                                             '(|Field|))))))
          (|haddProp| |$ConstructorCache| '|LieSquareMatrix| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8
                    (|AssociatedLieAlgebra| |#2| (|SquareMatrix| |#1| |#2|)))
          (QSETREFV $ 9 (* |#1| |#1|))
          $))) 

(MAKEPROP '|LieSquareMatrix| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|AssociatedLieAlgebra| 7 10) (|local| |#1|)
              (|local| |#2|) '|Rep| '|n2|
              (|SquareMatrix| (NRTEVAL (QREFELT $ 6)) 7) (0 . |coerce|)
              |LSQM;convert;Sm$;1| (5 . |Zero|) (|Integer|)
              (|DirectProduct| (NRTEVAL (QREFELT $ 9)) 7) (9 . |elt|)
              (|Matrix| 7) (15 . |setelt!|) (23 . |squareMatrix|) (28 . |qelt|)
              (|Vector| 7) (35 . |setelt!|) (|Vector| $$) (42 . |elt|)
              (48 . |elt|) (54 . |One|) (|Boolean|) (58 . =) (|Vector| $)
              |LSQM;coordinates;$VV;4| (|PositiveInteger|) (64 . |unitVector|)
              (|List| $$) (|Mapping| $$ 15) (|List| 15)
              (|ListFunctions2| 15 $$) (69 . |map|) (75 . |vector|)
              |LSQM;basis;V;6| |LSQM;someBasis;V;7| |LSQM;rank;Pi;8|
              (|SparseUnivariatePolynomial| (|Polynomial| 7)) (|InputForm|)
              (|NonNegativeInteger|) (|List| $) (|Union| $ '#1="failed")
              (|SparseUnivariatePolynomial| 7) (|List| 21)
              (|Record| (|:| |particular| $) (|:| |basis| 45))
              (|Union| 49 '#1#) (|OutputForm|) (|HashState|) (|SingleInteger|)
              (|String|) (|List| (|Polynomial| 7)) (|Vector| 17))
           '#(~= 80 |zero?| 86 |unit| 91 |subtractIfCan| 95
              |structuralConstants| 101 |someBasis| 110 |smaller?| 114 |size|
              120 |sample| 124 |rightUnits| 128 |rightUnit| 132
              |rightTraceMatrix| 136 |rightTrace| 145
              |rightRegularRepresentation| 150 |rightRecip| 161
              |rightRankPolynomial| 166 |rightPower| 170 |rightNorm| 176
              |rightMinimalPolynomial| 181 |rightDiscriminant| 186
              |rightCharacteristicPolynomial| 195 |rightAlternative?| 200
              |represents| 204 |recip| 215 |rank| 220 |random| 224
              |powerAssociative?| 228 |plenaryPower| 232 |opposite?| 238
              |noncommutativeJordanAlgebra?| 244 |lookup| 248 |lieAlgebra?| 253
              |lieAdmissible?| 257 |leftUnits| 261 |leftUnit| 265
              |leftTraceMatrix| 269 |leftTrace| 278 |leftRegularRepresentation|
              283 |leftRecip| 294 |leftRankPolynomial| 299 |leftPower| 303
              |leftNorm| 309 |leftMinimalPolynomial| 314 |leftDiscriminant| 319
              |leftCharacteristicPolynomial| 328 |leftAlternative?| 333 |latex|
              337 |jordanAlgebra?| 342 |jordanAdmissible?| 346
              |jacobiIdentity?| 350 |index| 354 |hashUpdate!| 359 |hash| 365
              |flexible?| 370 |enumerate| 374 |elt| 378 |coordinates| 384
              |convert| 406 |conditionsForIdempotents| 426 |commutator| 435
              |commutative?| 441 |coerce| 445 |basis| 455
              |associatorDependence| 459 |associator| 463 |associative?| 470
              |apply| 474 |antiCommutator| 480 |antiCommutative?| 486
              |antiAssociative?| 490 |alternative?| 494 ^ 498 |Zero| 504 = 508
              - 514 + 525 * 531)
           'NIL
           (CONS
            (|makeByteWordVec2| 2
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 2 0 0 2 0 0 0 0 1
                                  2))
            (CONS
             '#(|FramedNonAssociativeAlgebra&|
                |FiniteRankNonAssociativeAlgebra&| |NonAssociativeAlgebra&|
                |Module&| |FramedModule&| NIL NIL NIL |NonAssociativeRng&|
                |AbelianGroup&| NIL |AbelianMonoid&| |NonAssociativeSemiRng&|
                |Finite&| |Magma&| |AbelianSemiGroup&| NIL |SetCategory&| NIL
                NIL |BasicType&| NIL NIL)
             (CONS
              '#((|FramedNonAssociativeAlgebra| 7)
                 (|FiniteRankNonAssociativeAlgebra| 7)
                 (|NonAssociativeAlgebra| 7) (|Module| 7) (|FramedModule| 7)
                 (|BiModule| 7 7) (|RightModule| 7) (|LeftModule| 7)
                 (|NonAssociativeRng|) (|AbelianGroup|)
                 (|CancellationAbelianMonoid|) (|AbelianMonoid|)
                 (|NonAssociativeSemiRng|) (|Finite|) (|Magma|)
                 (|AbelianSemiGroup|) (|Comparable|) (|SetCategory|)
                 (|CoercibleTo| (|SquareMatrix| 6 7)) (|CoercibleTo| 51)
                 (|BasicType|) (|unitsKnown|) (|ConvertibleTo| 43))
              (|makeByteWordVec2| 56
                                  '(1 8 0 10 11 0 7 0 13 2 15 7 0 14 16 4 17 7
                                    0 14 14 7 18 1 10 0 17 19 3 10 7 0 14 14 20
                                    3 21 7 0 14 7 22 2 23 2 0 14 24 2 21 7 0 14
                                    25 0 7 0 26 2 7 27 0 0 28 1 15 0 31 32 2 36
                                    33 34 35 37 1 23 0 33 38 2 0 27 0 0 1 1 0
                                    27 0 1 0 1 46 1 2 0 46 0 0 1 1 0 56 29 1 0
                                    0 56 1 0 0 29 40 2 2 27 0 0 1 0 2 44 1 0 0
                                    0 1 0 1 50 1 0 1 46 1 1 0 17 29 1 0 0 17 1
                                    1 0 7 0 1 2 0 17 0 29 1 1 0 17 0 1 1 1 46 0
                                    1 0 3 42 1 2 0 0 0 31 1 1 0 7 0 1 1 1 47 0
                                    1 1 0 7 29 1 0 0 7 1 1 0 47 0 1 0 0 27 1 2
                                    0 0 21 29 1 1 0 0 21 1 1 1 46 0 1 0 0 31 41
                                    0 2 0 1 0 0 27 1 2 0 0 0 31 1 2 0 27 0 0 1
                                    0 0 27 1 1 2 31 0 1 0 0 27 1 0 0 27 1 0 1
                                    50 1 0 1 46 1 1 0 17 29 1 0 0 17 1 1 0 7 0
                                    1 2 0 17 0 29 1 1 0 17 0 1 1 1 46 0 1 0 3
                                    42 1 2 0 0 0 31 1 1 0 7 0 1 1 1 47 0 1 1 0
                                    7 29 1 0 0 7 1 1 0 47 0 1 0 0 27 1 1 0 54 0
                                    1 0 0 27 1 0 0 27 1 0 0 27 1 1 2 0 31 1 2 0
                                    52 52 0 1 1 0 53 0 1 0 0 27 1 0 2 45 1 2 0
                                    7 0 14 1 2 0 21 0 29 30 2 0 17 29 29 1 1 0
                                    17 29 1 1 0 21 0 1 1 2 43 0 1 1 0 0 10 12 1
                                    0 0 21 1 1 0 21 0 1 1 0 55 29 1 0 0 55 1 2
                                    0 0 0 0 1 0 0 27 1 1 0 51 0 1 1 0 10 0 1 0
                                    0 29 39 0 1 48 1 3 0 0 0 0 0 1 0 0 27 1 2 0
                                    0 17 0 1 2 0 0 0 0 1 0 0 27 1 0 0 27 1 0 0
                                    27 1 2 0 0 0 31 1 0 0 0 1 2 0 27 0 0 1 2 0
                                    0 0 0 1 1 0 0 0 1 2 0 0 0 0 1 2 0 0 31 0 1
                                    2 0 0 0 0 1 2 0 0 14 0 1 2 0 0 44 0 1 2 0 0
                                    7 0 1 2 0 0 0 7 1)))))
           '|lookupComplete|)) 
