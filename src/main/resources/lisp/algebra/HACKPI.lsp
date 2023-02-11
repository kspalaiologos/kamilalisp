
(SDEFUN |HACKPI;pi;$;1| (($ ($)))
        (SPADCALL (SPADCALL 1 1 (QREFELT $ 13)) (QREFELT $ 14))) 

(PUT '|HACKPI;convert;$F;2| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |HACKPI;convert;$F;2|
        ((|x| ($)) ($ (|Fraction| (|SparseUnivariatePolynomial| (|Integer|)))))
        |x|) 

(SDEFUN |HACKPI;convert;$F;3| ((|x| ($)) ($ (|Float|)))
        (SPADCALL |x| (QREFELT $ 18))) 

(SDEFUN |HACKPI;convert;$Df;4| ((|x| ($)) ($ (|DoubleFloat|)))
        (SPADCALL |x| (QREFELT $ 21))) 

(SDEFUN |HACKPI;coerce;$Df;5| ((|x| ($)) ($ (|DoubleFloat|)))
        (|div_DF| (|HACKPI;p2sf| (SPADCALL |x| (QREFELT $ 23)) $)
                  (|HACKPI;p2sf| (SPADCALL |x| (QREFELT $ 24)) $))) 

(SDEFUN |HACKPI;coerce;$F;6| ((|x| ($)) ($ (|Float|)))
        (SPADCALL (|HACKPI;p2f| (SPADCALL |x| (QREFELT $ 23)) $)
                  (|HACKPI;p2f| (SPADCALL |x| (QREFELT $ 24)) $)
                  (QREFELT $ 25))) 

(SDEFUN |HACKPI;p2o|
        ((|p| (|SparseUnivariatePolynomial| (|Integer|))) ($ (|OutputForm|)))
        (SPADCALL |p| (SPADCALL (QREFELT $ 7) (QREFELT $ 28)) (QREFELT $ 29))) 

(SDEFUN |HACKPI;p2i|
        ((|p| (|SparseUnivariatePolynomial| (|Integer|))) ($ (|InputForm|)))
        (SPADCALL (|HACKPI;p2p| |p| $) (QREFELT $ 32))) 

(SDEFUN |HACKPI;p2p|
        ((|p| (|SparseUnivariatePolynomial| (|Integer|)))
         ($ (|Polynomial| (|Integer|))))
        (SPROG ((|ans| (|Polynomial| (|Integer|))))
               (SEQ (LETT |ans| (|spadConstant| $ 33))
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL |p| (|spadConstant| $ 36)
                                      (QREFELT $ 38)))
                           (GO G191)))
                         (SEQ
                          (LETT |ans|
                                (SPADCALL |ans|
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |p| (QREFELT $ 39))
                                            (QREFELT $ 40))
                                           (QREFELT $ 7)
                                           (SPADCALL |p| (QREFELT $ 41))
                                           (QREFELT $ 42))
                                          (QREFELT $ 43)))
                          (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 44)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |ans|)))) 

(SDEFUN |HACKPI;coerce;$Of;10| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|r| (|Union| (|SparseUnivariatePolynomial| (|Integer|)) "failed")))
         (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 46)))
              (EXIT
               (COND ((QEQCAR |r| 0) (|HACKPI;p2o| (QCDR |r|) $))
                     ('T
                      (SPADCALL (|HACKPI;p2o| (SPADCALL |x| (QREFELT $ 23)) $)
                                (|HACKPI;p2o| (SPADCALL |x| (QREFELT $ 24)) $)
                                (QREFELT $ 47)))))))) 

(SDEFUN |HACKPI;convert;$If;11| ((|x| ($)) ($ (|InputForm|)))
        (SPROG
         ((|r| (|Union| (|SparseUnivariatePolynomial| (|Integer|)) "failed")))
         (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 46)))
              (EXIT
               (COND ((QEQCAR |r| 0) (|HACKPI;p2i| (QCDR |r|) $))
                     ('T
                      (SPADCALL (|HACKPI;p2i| (SPADCALL |x| (QREFELT $ 23)) $)
                                (|HACKPI;p2i| (SPADCALL |x| (QREFELT $ 24)) $)
                                (QREFELT $ 49)))))))) 

(SDEFUN |HACKPI;p2sf|
        ((|p| (|SparseUnivariatePolynomial| (|Integer|))) ($ (|DoubleFloat|)))
        (SPADCALL (SPADCALL (ELT $ 51) |p| (QREFELT $ 55))
                  (FLOAT PI MOST-POSITIVE-DOUBLE-FLOAT) (QREFELT $ 56))) 

(SDEFUN |HACKPI;p2f|
        ((|p| (|SparseUnivariatePolynomial| (|Integer|))) ($ (|Float|)))
        (SPADCALL (SPADCALL (ELT $ 57) |p| (QREFELT $ 61))
                  (SPADCALL (QREFELT $ 62)) (QREFELT $ 63))) 

(DECLAIM (NOTINLINE |Pi;|)) 

(DEFUN |Pi| ()
  (SPROG NIL
         (PROG (#1=#:G773)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|Pi|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|Pi|
                             (LIST (CONS NIL (CONS 1 (|Pi;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|Pi|)))))))))) 

(DEFUN |Pi;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|Pi|))
          (LETT $ (GETREFV 83))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Pi| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Fraction| (|SparseUnivariatePolynomial| (|Integer|))))
          (QSETREFV $ 7 '|%pi|)
          $))) 

(MAKEPROP '|Pi| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|Fraction| 12) '|Rep| '|sympi| (0 . |One|)
              (4 . |One|) (|Integer|) (|NonNegativeInteger|)
              (|SparseUnivariatePolynomial| 10) (8 . |monomial|)
              (14 . |coerce|) |HACKPI;pi;$;1| |HACKPI;convert;$F;2| (|Float|)
              |HACKPI;coerce;$F;6| |HACKPI;convert;$F;3| (|DoubleFloat|)
              |HACKPI;coerce;$Df;5| |HACKPI;convert;$Df;4| (19 . |numer|)
              (24 . |denom|) (29 . /) (|OutputForm|) (|Symbol|) (35 . |coerce|)
              (40 . |outputForm|) (|InputForm|) (|Polynomial| 10)
              (46 . |convert|) (51 . |Zero|) (55 . |Zero|) (59 . |Zero|)
              (63 . |Zero|) (|Boolean|) (67 . ~=) (73 . |leadingCoefficient|)
              (78 . |coerce|) (83 . |degree|) (88 . |monomial|) (95 . +)
              (101 . |reductum|) (|Union| 12 '"failed") (106 . |retractIfCan|)
              (111 . /) |HACKPI;coerce;$Of;10| (117 . /)
              |HACKPI;convert;$If;11| (123 . |coerce|)
              (|SparseUnivariatePolynomial| 20) (|Mapping| 20 10)
              (|SparseUnivariatePolynomialFunctions2| 10 20) (128 . |map|)
              (134 . |elt|) (140 . |coerce|) (|SparseUnivariatePolynomial| 17)
              (|Mapping| 17 10) (|SparseUnivariatePolynomialFunctions2| 10 17)
              (145 . |map|) (151 . |pi|) (155 . |elt|) (|Fraction| 10)
              (|Union| 64 '#1="failed") (|Union| 10 '#1#) (|Factored| $)
              (|Union| 69 '#2="failed") (|List| $)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $)) (|Union| 71 '#2#)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef| 69) (|:| |generator| $))
              (|SparseUnivariatePolynomial| $)
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Union| $ '"failed") (|PositiveInteger|) (|String|)
              (|SingleInteger|) (|HashState|))
           '#(~= 161 |zero?| 167 |unitNormal| 172 |unitCanonical| 177 |unit?|
              182 |subtractIfCan| 187 |squareFreePart| 193 |squareFree| 198
              |sizeLess?| 203 |sample| 209 |rightRecip| 213 |rightPower| 218
              |retractIfCan| 230 |retract| 240 |rem| 250 |recip| 256 |quo| 261
              |principalIdeal| 267 |prime?| 272 |pi| 277 |opposite?| 281 |one?|
              287 |multiEuclidean| 292 |leftRecip| 298 |leftPower| 303
              |lcmCoef| 315 |lcm| 321 |latex| 332 |inv| 337 |hashUpdate!| 342
              |hash| 348 |gcdPolynomial| 353 |gcd| 359 |factor| 370
              |extendedEuclidean| 375 |exquo| 388 |expressIdealMember| 394
              |euclideanSize| 400 |divide| 405 |convert| 411 |commutator| 431
              |coerce| 437 |characteristic| 467 |associator| 471 |associates?|
              478 |antiCommutator| 484 |annihilate?| 490 ^ 496 |Zero| 514 |One|
              518 = 522 / 528 - 534 + 545 * 551)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0))
            (CONS
             '#(|Field&| |EuclideanDomain&| NIL |UniqueFactorizationDomain&|
                |GcdDomain&| NIL |DivisionRing&| NIL NIL NIL |Algebra&|
                |EntireRing&| |Algebra&| NIL |Rng&| NIL |Module&| |Module&| NIL
                NIL NIL |NonAssociativeRing&| NIL NIL NIL |NonAssociativeRng&|
                NIL |AbelianGroup&| NIL NIL NIL NIL |MagmaWithUnit&|
                |NonAssociativeSemiRng&| |AbelianMonoid&| |Magma&|
                |AbelianSemiGroup&| NIL |RetractableTo&| |RetractableTo&| NIL
                |SetCategory&| NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                NIL |BasicType&| NIL)
             (CONS
              '#((|Field|) (|EuclideanDomain|) (|PrincipalIdealDomain|)
                 (|UniqueFactorizationDomain|) (|GcdDomain|) (|IntegralDomain|)
                 (|DivisionRing|) (|CommutativeRing|) (|LeftOreRing|)
                 (|CharacteristicZero|) (|Algebra| 64) (|EntireRing|)
                 (|Algebra| $$) (|Ring|) (|Rng|) (|SemiRing|) (|Module| 64)
                 (|Module| $$) (|SemiRng|) (|BiModule| 64 64)
                 (|BiModule| $$ $$) (|NonAssociativeRing|) (|RightModule| 64)
                 (|LeftModule| 64) (|LeftModule| $$) (|NonAssociativeRng|)
                 (|RightModule| $$) (|AbelianGroup|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|SemiGroup|) (|MagmaWithUnit|) (|NonAssociativeSemiRng|)
                 (|AbelianMonoid|) (|Magma|) (|AbelianSemiGroup|)
                 (|RealConstant|) (|RetractableTo| 64) (|RetractableTo| 10)
                 (|CommutativeStar|) (|SetCategory|) (|ConvertibleTo| 30)
                 (|ConvertibleTo| 5) (|CoercibleTo| 17) (|CoercibleTo| 20)
                 (|ConvertibleTo| 17) (|ConvertibleTo| 20) (|CoercibleFrom| 64)
                 (|CoercibleFrom| 10) (|canonicalsClosed|)
                 (|canonicalUnitNormal|) (|noZeroDivisors|) (|TwoSidedRecip|)
                 (|unitsKnown|) (|BasicType|) (|CoercibleTo| 26))
              (|makeByteWordVec2| 82
                                  '(0 0 0 8 0 6 0 9 2 12 0 10 11 13 1 5 0 12 14
                                    1 6 12 0 23 1 6 12 0 24 2 17 0 0 0 25 1 27
                                    26 0 28 2 12 26 0 26 29 1 31 30 0 32 0 31 0
                                    33 0 0 0 34 0 6 0 35 0 12 0 36 2 12 37 0 0
                                    38 1 12 10 0 39 1 31 0 10 40 1 12 11 0 41 3
                                    31 0 0 27 11 42 2 31 0 0 0 43 1 12 0 0 44 1
                                    6 45 0 46 2 26 0 0 0 47 2 30 0 0 0 49 1 20
                                    0 10 51 2 54 52 53 12 55 2 52 20 0 20 56 1
                                    17 0 10 57 2 60 58 59 12 61 0 17 0 62 2 58
                                    17 0 17 63 2 0 37 0 0 1 1 0 37 0 1 1 0 77 0
                                    1 1 0 0 0 1 1 0 37 0 1 2 0 78 0 0 1 1 0 0 0
                                    1 1 0 67 0 1 2 0 37 0 0 1 0 0 0 1 1 0 78 0
                                    1 2 0 0 0 11 1 2 0 0 0 79 1 1 0 65 0 1 1 0
                                    66 0 1 1 0 64 0 1 1 0 10 0 1 2 0 0 0 0 1 1
                                    0 78 0 1 2 0 0 0 0 1 1 0 74 69 1 1 0 37 0 1
                                    0 0 0 15 2 0 37 0 0 1 1 0 37 0 1 2 0 68 69
                                    0 1 1 0 78 0 1 2 0 0 0 11 1 2 0 0 0 79 1 2
                                    0 76 0 0 1 2 0 0 0 0 1 1 0 0 69 1 1 0 80 0
                                    1 1 0 0 0 1 2 0 82 82 0 1 1 0 81 0 1 2 0 75
                                    75 75 1 2 0 0 0 0 1 1 0 0 69 1 1 0 67 0 1 2
                                    0 70 0 0 1 3 0 72 0 0 0 1 2 0 78 0 0 1 2 0
                                    68 69 0 1 1 0 11 0 1 2 0 73 0 0 1 1 0 30 0
                                    50 1 0 5 0 16 1 0 20 0 22 1 0 17 0 19 2 0 0
                                    0 0 1 1 0 17 0 18 1 0 20 0 21 1 0 0 64 1 1
                                    0 0 0 1 1 0 0 10 1 1 0 26 0 48 0 0 11 1 3 0
                                    0 0 0 0 1 2 0 37 0 0 1 2 0 0 0 0 1 2 0 37 0
                                    0 1 2 0 0 0 10 1 2 0 0 0 11 1 2 0 0 0 79 1
                                    0 0 0 34 0 0 0 8 2 0 37 0 0 1 2 0 0 0 0 1 1
                                    0 0 0 1 2 0 0 0 0 1 2 0 0 0 0 1 2 0 0 64 0
                                    1 2 0 0 0 64 1 2 0 0 11 0 1 2 0 0 10 0 1 2
                                    0 0 0 0 1 2 0 0 79 0 1)))))
           '|lookupComplete|)) 

(MAKEPROP '|Pi| 'NILADIC T) 
