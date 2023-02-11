
(SDEFUN |COMPLEX;writeOMComplex|
        ((|dev| (|OpenMathDevice|)) (|x| ($)) ($ (|Void|)))
        (SEQ (SPADCALL |dev| (QREFELT $ 10))
             (SPADCALL |dev| "complex1" "complex_cartesian" (QREFELT $ 12))
             (SPADCALL |dev| (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 14))
             (SPADCALL |dev| (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 14))
             (EXIT (SPADCALL |dev| (QREFELT $ 16))))) 

(SDEFUN |COMPLEX;OMwrite;Omd$BV;2|
        ((|dev| (|OpenMathDevice|)) (|x| ($)) (|wholeObj| (|Boolean|))
         ($ (|Void|)))
        (SEQ (COND (|wholeObj| (SPADCALL |dev| (QREFELT $ 17))))
             (|COMPLEX;writeOMComplex| |dev| |x| $)
             (EXIT (COND (|wholeObj| (SPADCALL |dev| (QREFELT $ 18))))))) 

(SDEFUN |COMPLEX;Zero;$;3| (($ ($)))
        (CONS (|spadConstant| $ 22) (|spadConstant| $ 22))) 

(SDEFUN |COMPLEX;One;$;4| (($ ($)))
        (CONS (|spadConstant| $ 24) (|spadConstant| $ 22))) 

(SDEFUN |COMPLEX;zero?;$B;5| ((|x| ($)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (QCAR |x|) (QREFELT $ 25))
          (SPADCALL (QCDR |x|) (QREFELT $ 25)))
         ('T NIL))) 

(SDEFUN |COMPLEX;one?;$B;6| ((|x| ($)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (QCAR |x|) (|spadConstant| $ 24) (QREFELT $ 27))
          (SPADCALL (QCDR |x|) (QREFELT $ 25)))
         ('T NIL))) 

(SDEFUN |COMPLEX;coerce;R$;7| ((|r| (R)) ($ ($)))
        (CONS |r| (|spadConstant| $ 22))) 

(PUT '|COMPLEX;complex;2R$;8| '|SPADreplace| 'CONS) 

(SDEFUN |COMPLEX;complex;2R$;8| ((|r| (R)) (|i| (R)) ($ ($))) (CONS |r| |i|)) 

(PUT '|COMPLEX;real;$R;9| '|SPADreplace| 'QCAR) 

(SDEFUN |COMPLEX;real;$R;9| ((|x| ($)) ($ (R))) (QCAR |x|)) 

(PUT '|COMPLEX;imag;$R;10| '|SPADreplace| 'QCDR) 

(SDEFUN |COMPLEX;imag;$R;10| ((|x| ($)) ($ (R))) (QCDR |x|)) 

(SDEFUN |COMPLEX;+;3$;11| ((|x| ($)) (|y| ($)) ($ ($)))
        (CONS (|add_DF| (QCAR |x|) (QCAR |y|))
              (|add_DF| (QCDR |x|) (QCDR |y|)))) 

(SDEFUN |COMPLEX;-;3$;12| ((|x| ($)) (|y| ($)) ($ ($)))
        (CONS (|sub_DF| (QCAR |x|) (QCAR |y|))
              (|sub_DF| (QCDR |x|) (QCDR |y|)))) 

(SDEFUN |COMPLEX;*;3$;13| ((|x| ($)) (|y| ($)) ($ ($)))
        (CONS
         (|sub_DF| (|mul_DF| (QCAR |x|) (QCAR |y|))
                   (|mul_DF| (QCDR |x|) (QCDR |y|)))
         (|add_DF| (|mul_DF| (QCDR |x|) (QCAR |y|))
                   (|mul_DF| (QCDR |y|) (QCAR |x|))))) 

(SDEFUN |COMPLEX;+;3$;14| ((|x| ($)) (|y| ($)) ($ ($)))
        (CONS (SPADCALL (QCAR |x|) (QCAR |y|) (QREFELT $ 34))
              (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 34)))) 

(SDEFUN |COMPLEX;-;3$;15| ((|x| ($)) (|y| ($)) ($ ($)))
        (CONS (SPADCALL (QCAR |x|) (QCAR |y|) (QREFELT $ 35))
              (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 35)))) 

(SDEFUN |COMPLEX;*;3$;16| ((|x| ($)) (|y| ($)) ($ ($)))
        (CONS
         (SPADCALL (SPADCALL (QCAR |x|) (QCAR |y|) (QREFELT $ 36))
                   (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 36))
                   (QREFELT $ 35))
         (SPADCALL (SPADCALL (QCDR |x|) (QCAR |y|) (QREFELT $ 36))
                   (SPADCALL (QCDR |y|) (QCAR |x|) (QREFELT $ 36))
                   (QREFELT $ 34)))) 

(SDEFUN |COMPLEX;exquo;2$U;17| ((|x| ($)) (|y| ($)) ($ (|Union| $ "failed")))
        (COND
         ((SPADCALL (QCDR |y|) (QREFELT $ 25))
          (SPADCALL |x| (QCAR |y|) (QREFELT $ 38)))
         ('T
          (SPADCALL (SPADCALL |x| (SPADCALL |y| (QREFELT $ 39)) (QREFELT $ 33))
                    (SPADCALL |y| (QREFELT $ 40)) (QREFELT $ 38))))) 

(DECLAIM (NOTINLINE |Complex;|)) 

(DEFUN |Complex| (#1=#:G3607)
  (SPROG NIL
         (PROG (#2=#:G3608)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Complex|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Complex;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Complex|)))))))))) 

(DEFUN |Complex;| (|#1|)
  (SPROG
   ((|pv$| NIL) (#1=#:G3603 NIL) (#2=#:G3604 NIL) (#3=#:G3605 NIL)
    (#4=#:G3606 NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|Complex| DV$1))
    (LETT $ (GETREFV 97))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicZero|))
                                        (|HasCategory| |#1|
                                                       '(|FiniteFieldCategory|))
                                        (LETT #4#
                                              (|HasCategory| |#1| '(|Field|)))
                                        (OR #4#
                                            (|HasCategory| |#1|
                                                           '(|FiniteFieldCategory|)))
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicNonZero|))
                                        (|HasCategory| |#1| '(|Finite|))
                                        (|HasCategory| |#1|
                                                       '(|RetractableTo|
                                                         (|Fraction|
                                                          (|Integer|))))
                                        (|HasCategory| |#1|
                                                       '(|RetractableTo|
                                                         (|Integer|)))
                                        (|HasCategory| |#1|
                                                       '(|LinearlyExplicitOver|
                                                         (|Integer|)))
                                        (|HasCategory| |#1|
                                                       '(|IntegralDomain|))
                                        (LETT #3#
                                              (|HasCategory| |#1|
                                                             '(|TranscendentalFunctionCategory|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|RadicalCategory|))
                                         #3#)
                                        (|HasCategory| |#1|
                                                       '(|arbitraryPrecision|))
                                        (|HasCategory| |#1| '(|RealConstant|))
                                        (|HasCategory| |#1|
                                                       '(|ConvertibleTo|
                                                         (|InputForm|)))
                                        (LETT #2#
                                              (|HasCategory| |#1|
                                                             '(|IntegerNumberSystem|)))
                                        (OR #4#
                                            (|HasCategory| |#1|
                                                           '(|FiniteFieldCategory|))
                                            #2#)
                                        (|HasCategory| |#1| '(|Comparable|))
                                        (|HasCategory| |#1|
                                                       '(|PartialDifferentialRing|
                                                         (|Symbol|)))
                                        (|HasCategory| |#1|
                                                       '(|DifferentialRing|))
                                        (|HasCategory| |#1|
                                                       (LIST '|InnerEvalable|
                                                             '(|Symbol|)
                                                             (|devaluate|
                                                              |#1|)))
                                        (|HasCategory| |#1|
                                                       (LIST '|Evalable|
                                                             (|devaluate|
                                                              |#1|)))
                                        (|HasCategory| |#1|
                                                       (LIST '|Eltable|
                                                             (|devaluate| |#1|)
                                                             (|devaluate|
                                                              |#1|)))
                                        (|HasCategory| |#1|
                                                       '(|PatternMatchable|
                                                         (|Float|)))
                                        (|HasCategory| |#1|
                                                       '(|PatternMatchable|
                                                         (|Integer|)))
                                        (|HasCategory| |#1|
                                                       '(|ConvertibleTo|
                                                         (|Pattern|
                                                          (|Float|))))
                                        (|HasCategory| |#1|
                                                       '(|ConvertibleTo|
                                                         (|Pattern|
                                                          (|Integer|))))
                                        (|HasCategory| |#1| '(|OpenMath|))
                                        (|HasCategory| |#1|
                                                       '(|RealNumberSystem|))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|RealNumberSystem|))
                                         #3#)
                                        (|HasCategory| |#1|
                                                       '(|EuclideanDomain|))
                                        (LETT #1#
                                              (|HasCategory| |#1|
                                                             '(|PolynomialFactorizationExplicit|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|EuclideanDomain|))
                                          #1#)
                                         (|HasCategory| |#1|
                                                        '(|FiniteFieldCategory|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|EuclideanDomain|))
                                          #1#)
                                         #4#
                                         (|HasCategory| |#1|
                                                        '(|FiniteFieldCategory|))
                                         #2#)
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|EuclideanDomain|))
                                          #1#)
                                         #4# #2#)
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|EuclideanDomain|))
                                          #1#)
                                         #4#
                                         (|HasCategory| |#1|
                                                        '(|FiniteFieldCategory|))
                                         #2#
                                         (|HasCategory| |#1|
                                                        '(|IntegralDomain|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|EuclideanDomain|))
                                          #1#)
                                         #4# #2#
                                         (|HasCategory| |#1|
                                                        '(|IntegralDomain|)))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|RetractableTo|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         #4#)
                                        (OR #4# #2#)
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|EuclideanDomain|))
                                          #1#)
                                         (|HasCategory| |#1|
                                                        '(|IntegralDomain|)))))))
    (|haddProp| |$ConstructorCache| '|Complex| (LIST DV$1) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (AND
     (OR
      (AND (|HasCategory| |#1| '(|EuclideanDomain|)) #1#
           (|HasCategory| $ '(|CharacteristicNonZero|)))
      (AND (|HasCategory| |#1| '(|FiniteFieldCategory|))
           (|HasCategory| $ '(|CharacteristicNonZero|))))
     (|augmentPredVector| $ 1099511627776))
    (AND
     (OR (|HasCategory| |#1| '(|CharacteristicNonZero|))
         (AND (|HasCategory| |#1| '(|EuclideanDomain|)) #1#
              (|HasCategory| $ '(|CharacteristicNonZero|))))
     (|augmentPredVector| $ 2199023255552))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 7 (|Record| (|:| |real| |#1|) (|:| |imag| |#1|)))
    (COND
     ((|testBitVector| |pv$| 28)
      (PROGN
       (QSETREFV $ 20
                 (CONS (|dispatchFunction| |COMPLEX;OMwrite;Omd$BV;2|) $)))))
    (COND
     ((|domainEqual| |#1| (|DoubleFloat|))
      (PROGN
       (QSETREFV $ 31 (CONS (|dispatchFunction| |COMPLEX;+;3$;11|) $))
       (QSETREFV $ 32 (CONS (|dispatchFunction| |COMPLEX;-;3$;12|) $))
       (QSETREFV $ 33 (CONS (|dispatchFunction| |COMPLEX;*;3$;13|) $))))
     ('T
      (PROGN
       (QSETREFV $ 31 (CONS (|dispatchFunction| |COMPLEX;+;3$;14|) $))
       (QSETREFV $ 32 (CONS (|dispatchFunction| |COMPLEX;-;3$;15|) $))
       (QSETREFV $ 33 (CONS (|dispatchFunction| |COMPLEX;*;3$;16|) $)))))
    (COND
     ((|testBitVector| |pv$| 10)
      (QSETREFV $ 41 (CONS (|dispatchFunction| |COMPLEX;exquo;2$U;17|) $))))
    $))) 

(MAKEPROP '|Complex| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|Void|)
              (|OpenMathDevice|) (0 . |OMputApp|) (|String|)
              (5 . |OMputSymbol|) |COMPLEX;real;$R;9| (12 . |OMwrite|)
              |COMPLEX;imag;$R;10| (18 . |OMputEndApp|) (23 . |OMputObject|)
              (28 . |OMputEndObject|) (|Boolean|) (33 . |OMwrite|)
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |COMPLEX;Zero;$;3|) $))
              (40 . |Zero|)
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |COMPLEX;One;$;4|) $))
              (44 . |One|) (48 . |zero?|) |COMPLEX;zero?;$B;5| (53 . =)
              |COMPLEX;one?;$B;6| |COMPLEX;coerce;R$;7| |COMPLEX;complex;2R$;8|
              (59 . +) (65 . -) (71 . *) (77 . +) (83 . -) (89 . *)
              (|Union| $ '#1="failed") (95 . |exquo|) (101 . |conjugate|)
              (106 . |norm|) (111 . |exquo|) (|Fraction| 43) (|Integer|)
              (|Record| (|:| |r| 6) (|:| |phi| 6)) (|Union| 70 '#2="failed")
              (|Matrix| $)
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|List| $) (|SparseUnivariatePolynomial| $) (|Factored| $)
              (|Factored| 49) (|Union| 53 '#2#) (|List| 49)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Record| (|:| |coef| 48) (|:| |generator| $))
              (|Union| 48 '"failed") (|NonNegativeInteger|)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $)) (|Union| 60 '"failed")
              (|InputForm|) (|Pattern| (|Float|)) (|Pattern| 43) (|Equation| 6)
              (|List| 65) (|List| 6) (|Fraction| 72) (|Matrix| 6) (|Vector| $)
              (|Mapping| 6 6) (|SparseUnivariatePolynomial| 6)
              (|PositiveInteger|) (|OnePointCompletion| 73)
              (|Union| 57 '"failed") (|Table| 73 57)
              (|Record| (|:| |factor| 43) (|:| |exponent| 57)) (|List| 77)
              (|Union| '"prime" '"polynomial" '"normal" '"cyclic") (|List| 81)
              (|Symbol|) (|Union| 42 '#1#)
              (|Record| (|:| |mat| 84) (|:| |vec| (|Vector| 43))) (|Matrix| 43)
              (|List| 57) (|PatternMatchResult| (|Float|) $)
              (|PatternMatchResult| 43 $) (|Complex| (|Float|))
              (|Complex| (|DoubleFloat|)) (|Union| 43 '#3="failed")
              (|Record| (|:| |mat| 69) (|:| |vec| 93)) (|Union| 6 '#3#)
              (|Vector| 6) (|HashState|) (|OutputForm|) (|SingleInteger|))
           '#(~= 117 |zero?| 123 |unitNormal| 128 |unitCanonical| 133 |unit?|
              138 |traceMatrix| 143 |trace| 152 |tanh| 157 |tan| 162
              |tableForDiscreteLogarithm| 167 |subtractIfCan| 172
              |squareFreePolynomial| 178 |squareFreePart| 183 |squareFree| 188
              |sqrt| 193 |solveLinearPolynomialEquation| 198 |smaller?| 204
              |sizeLess?| 210 |size| 216 |sinh| 220 |sin| 225 |sech| 230 |sec|
              235 |sample| 240 |rightRecip| 244 |rightPower| 249 |retractIfCan|
              261 |retract| 276 |represents| 291 |representationType| 302 |rem|
              306 |regularRepresentation| 312 |reducedSystem| 323 |reduce| 345
              |recip| 355 |real| 360 |rationalIfCan| 365 |rational?| 370
              |rational| 375 |rank| 380 |random| 384 |quo| 388 |principalIdeal|
              394 |primitiveElement| 399 |primitive?| 403 |primeFrobenius| 408
              |prime?| 419 |polarCoordinates| 424 |pi| 429 |patternMatch| 433
              |order| 447 |opposite?| 457 |one?| 463 |nthRoot| 468 |norm| 474
              |nextItem| 479 |multiEuclidean| 484 |minimalPolynomial| 490 |map|
              495 |lookup| 501 |log| 506 |lift| 511 |leftRecip| 516 |leftPower|
              521 |lcmCoef| 533 |lcm| 539 |latex| 550 |inv| 555 |init| 560
              |index| 564 |imaginary| 569 |imag| 573 |hashUpdate!| 578 |hash|
              584 |generator| 589 |gcdPolynomial| 593 |gcd| 599
              |factorsOfCyclicGroupSize| 610 |factorSquareFreePolynomial| 614
              |factorPolynomial| 619 |factor| 624 |extendedEuclidean| 629
              |exquo| 642 |expressIdealMember| 654 |exp| 660 |eval| 665
              |euclideanSize| 705 |enumerate| 710 |elt| 714 |divide| 720
              |discriminant| 726 |discreteLog| 735 |differentiate| 746
              |derivationCoordinates| 796 |definingPolynomial| 802 |csch| 806
              |csc| 811 |createPrimitiveElement| 816 |coth| 820 |cot| 825
              |cosh| 830 |cos| 835 |coordinates| 840 |convert| 862 |conjugate|
              907 |conditionP| 912 |complex| 917 |commutator| 923 |coerce| 929
              |charthRoot| 954 |characteristicPolynomial| 964 |characteristic|
              969 |basis| 973 |atanh| 977 |atan| 982 |associator| 987
              |associates?| 994 |asinh| 1000 |asin| 1005 |asech| 1010 |asec|
              1015 |argument| 1020 |antiCommutator| 1025 |annihilate?| 1031
              |acsch| 1037 |acsc| 1042 |acoth| 1047 |acot| 1052 |acosh| 1057
              |acos| 1062 |abs| 1067 ^ 1072 |Zero| 1102 |One| 1106 |OMwrite|
              1110 D 1134 = 1184 / 1190 - 1196 + 1207 * 1213)
           'NIL
           (CONS
            (|makeByteWordVec2| 37
                                '(0 0 2 2 4 33 17 34 17 34 0 36 0 0 0 0 3 35 0
                                  0 0 1 3 5 9 37 19 20 0 0 0 0 0 0 3 0 0 0 0 3
                                  0 0 0 0 0 3 3 0 0 0 0 0 0 0 0 0 6 0 0 0 0 2
                                  18 24 25 0 0 0 0 7 8 11 22 0 0 0 0 0 0 0 3 3
                                  7 8 10 12 11 11 11 11 11 13 14 14 15 16 21 22
                                  23 26 27 28))
            (CONS
             '#(|ComplexCategory&| |MonogenicAlgebra&| |FiniteFieldCategory&|
                |FieldOfPrimeCharacteristic&| |Field&|
                |PolynomialFactorizationExplicit&| |EuclideanDomain&|
                |UniqueFactorizationDomain&| NIL |GcdDomain&| |FramedAlgebra&|
                NIL |FiniteRankAlgebra&| |DifferentialExtension&|
                |FullyLinearlyExplicitOver&| NIL |DivisionRing&| NIL |Algebra&|
                NIL |Algebra&| NIL |Algebra&| NIL NIL |EntireRing&|
                |PartialDifferentialRing&| |DifferentialRing&| NIL |Rng&| NIL
                |Module&| |Module&| NIL |Module&| NIL |FramedModule&| NIL
                |NonAssociativeRing&| NIL NIL NIL NIL |NonAssociativeRng&| NIL
                NIL NIL |AbelianGroup&| NIL NIL NIL NIL NIL |MagmaWithUnit&|
                |NonAssociativeSemiRng&| |AbelianMonoid&| |Finite&|
                |FullyEvalableOver&| |FullyRetractableTo&| |Magma&|
                |AbelianSemiGroup&| NIL NIL NIL NIL NIL |RetractableTo&| NIL
                |SetCategory&| |RetractableTo&| |RetractableTo&|
                |TranscendentalFunctionCategory&| |Evalable&| NIL NIL NIL NIL
                NIL |BasicType&| NIL NIL NIL NIL NIL NIL |RadicalCategory&|
                |TrigonometricFunctionCategory&|
                |ArcTrigonometricFunctionCategory&|
                |HyperbolicFunctionCategory&| NIL |ElementaryFunctionCategory&|
                NIL NIL NIL NIL NIL |InnerEvalable&| |InnerEvalable&| NIL NIL
                NIL |OpenMath&|)
             (CONS
              '#((|ComplexCategory| 6)
                 (|MonogenicAlgebra| 6 (|SparseUnivariatePolynomial| 6))
                 (|FiniteFieldCategory|) (|FieldOfPrimeCharacteristic|)
                 (|Field|) (|PolynomialFactorizationExplicit|)
                 (|EuclideanDomain|) (|UniqueFactorizationDomain|)
                 (|PrincipalIdealDomain|) (|GcdDomain|)
                 (|FramedAlgebra| 6 (|SparseUnivariatePolynomial| 6))
                 (|IntegralDomain|)
                 (|FiniteRankAlgebra| 6 (|SparseUnivariatePolynomial| 6))
                 (|DifferentialExtension| 6) (|FullyLinearlyExplicitOver| 6)
                 (|CommutativeRing|) (|DivisionRing|) (|LeftOreRing|)
                 (|Algebra| 6) (|LinearlyExplicitOver| 6) (|Algebra| $$)
                 (|CharacteristicZero|) (|Algebra| 42)
                 (|CharacteristicNonZero|) (|LinearlyExplicitOver| 43)
                 (|EntireRing|) (|PartialDifferentialRing| 81)
                 (|DifferentialRing|) (|Ring|) (|Rng|) (|SemiRing|)
                 (|Module| $$) (|Module| 6) (|SemiRng|) (|Module| 42)
                 (|BiModule| $$ $$) (|FramedModule| 6) (|BiModule| 6 6)
                 (|NonAssociativeRing|) (|BiModule| 42 42) (|LeftModule| $$)
                 (|RightModule| 6) (|LeftModule| 6) (|NonAssociativeRng|)
                 (|RightModule| $$) (|LeftModule| 42) (|RightModule| 42)
                 (|AbelianGroup|) (|Monoid|) (|NonAssociativeSemiRing|)
                 (|CancellationAbelianMonoid|) (|FullyPatternMatchable| 6)
                 (|SemiGroup|) (|MagmaWithUnit|) (|NonAssociativeSemiRng|)
                 (|AbelianMonoid|) (|Finite|) (|FullyEvalableOver| 6)
                 (|FullyRetractableTo| 6) (|Magma|) (|AbelianSemiGroup|)
                 (|StepThrough|) (|Comparable|) (|PatternMatchable| (|Float|))
                 (|PatternMatchable| 43) (|Patternable| 6) (|RetractableTo| 6)
                 (|CommutativeStar|) (|SetCategory|) (|RetractableTo| 42)
                 (|RetractableTo| 43) (|TranscendentalFunctionCategory|)
                 (|Evalable| 6) (|Type|) (|CoercibleFrom| 6)
                 (|ConvertibleTo| (|SparseUnivariatePolynomial| 6))
                 (|TwoSidedRecip|) (|unitsKnown|) (|BasicType|)
                 (|CoercibleTo| 95) (|canonicalUnitNormal|)
                 (|canonicalsClosed|) (|CoercibleFrom| 42) (|CoercibleFrom| 43)
                 (|noZeroDivisors|) (|RadicalCategory|)
                 (|TrigonometricFunctionCategory|)
                 (|ArcTrigonometricFunctionCategory|)
                 (|HyperbolicFunctionCategory|)
                 (|ArcHyperbolicFunctionCategory|)
                 (|ElementaryFunctionCategory|) (|arbitraryPrecision|)
                 (|ConvertibleTo| 88) (|ConvertibleTo| 89) (|ConvertibleTo| 62)
                 (|multiplicativeValuation|) (|InnerEvalable| 81 6)
                 (|InnerEvalable| 6 6) (|Eltable| 6 $$) (|ConvertibleTo| 63)
                 (|ConvertibleTo| 64) (|OpenMath|))
              (|makeByteWordVec2| 96
                                  '(1 9 8 0 10 3 9 8 0 11 11 12 2 6 8 9 0 14 1
                                    9 8 0 16 1 9 8 0 17 1 9 8 0 18 3 0 8 9 0 19
                                    20 0 6 0 22 0 6 0 24 1 6 19 0 25 2 6 19 0 0
                                    27 2 0 0 0 0 31 2 0 0 0 0 32 2 0 0 0 0 33 2
                                    6 0 0 0 34 2 6 0 0 0 35 2 6 0 0 0 36 2 0 37
                                    0 6 38 1 0 0 0 39 1 0 6 0 40 2 0 37 0 0 41
                                    2 0 19 0 0 1 1 0 19 0 26 1 40 54 0 1 1 40 0
                                    0 1 1 40 19 0 1 0 0 69 1 1 0 69 70 1 1 0 6
                                    0 1 1 11 0 0 1 1 11 0 0 1 1 2 76 43 1 2 0
                                    37 0 0 1 1 33 51 49 1 1 35 0 0 1 1 35 50 0
                                    1 1 12 0 0 1 2 33 52 53 49 1 2 18 19 0 0 1
                                    2 39 19 0 0 1 0 6 57 1 1 11 0 0 1 1 11 0 0
                                    1 1 11 0 0 1 1 11 0 0 1 0 0 0 1 1 0 37 0 1
                                    2 0 0 0 57 1 2 0 0 0 73 1 1 7 82 0 1 1 8 90
                                    0 1 1 0 92 0 1 1 7 42 0 1 1 8 43 0 1 1 0 6
                                    0 1 1 0 0 93 1 2 0 0 93 70 1 0 2 79 1 2 39
                                    0 0 0 1 1 0 69 0 1 2 0 69 0 70 1 2 9 83 46
                                    70 1 1 9 84 46 1 2 0 91 46 70 1 1 0 69 46 1
                                    1 3 37 68 1 1 0 0 72 1 1 0 37 0 1 1 0 6 0
                                    13 1 16 82 0 1 1 16 19 0 1 1 16 42 0 1 0 0
                                    73 1 0 6 0 1 2 39 0 0 0 1 1 39 55 48 1 0 2
                                    0 1 1 2 19 0 1 1 2 0 0 1 2 2 0 0 57 1 1 35
                                    19 0 1 1 30 44 0 1 0 11 0 1 3 24 86 0 63 86
                                    1 3 25 87 0 64 87 1 1 2 74 0 1 1 2 73 0 1 2
                                    0 19 0 0 1 1 0 19 0 28 2 12 0 0 43 1 1 0 6
                                    0 40 1 2 37 0 1 2 39 56 48 0 1 1 3 72 0 1 2
                                    0 0 71 0 1 1 6 73 0 1 1 11 0 0 1 1 0 72 0 1
                                    1 0 37 0 1 2 0 0 0 57 1 2 0 0 0 73 1 2 35
                                    47 0 0 1 2 35 0 0 0 1 1 35 0 48 1 1 0 11 0
                                    1 1 3 0 0 1 0 2 0 1 1 6 0 73 1 0 0 0 1 1 0
                                    6 0 15 2 0 94 94 0 1 1 0 96 0 1 0 0 0 1 2
                                    35 49 49 49 1 1 35 0 48 1 2 35 0 0 0 1 0 2
                                    78 1 1 33 51 49 1 1 33 51 49 1 1 35 50 0 1
                                    2 39 59 0 0 1 3 39 61 0 0 0 1 2 40 37 0 0
                                    41 2 10 37 0 6 38 2 39 56 48 0 1 1 11 0 0 1
                                    2 22 0 0 65 1 2 22 0 0 66 1 3 22 0 0 6 6 1
                                    3 22 0 0 67 67 1 3 21 0 0 80 67 1 3 21 0 0
                                    81 6 1 1 39 57 0 1 0 6 48 1 2 23 0 0 6 1 2
                                    39 58 0 0 1 0 0 6 1 1 0 6 70 1 2 2 75 0 0 1
                                    1 2 57 0 1 2 20 0 0 57 1 1 20 0 0 1 3 19 0
                                    0 80 85 1 2 19 0 0 80 1 3 19 0 0 81 57 1 2
                                    19 0 0 81 1 3 0 0 0 71 57 1 2 0 0 0 71 1 2
                                    3 69 70 71 1 0 0 72 1 1 11 0 0 1 1 11 0 0 1
                                    0 2 0 1 1 11 0 0 1 1 11 0 0 1 1 11 0 0 1 1
                                    11 0 0 1 1 0 93 0 1 1 0 69 70 1 2 0 69 70
                                    70 1 2 0 93 0 70 1 1 15 62 0 1 1 26 63 0 1
                                    1 27 64 0 1 1 14 88 0 1 1 14 89 0 1 1 0 0
                                    72 1 1 0 72 0 1 1 0 93 0 1 1 0 0 93 1 1 0 0
                                    0 39 1 41 45 46 1 2 0 0 6 6 30 2 0 0 0 0 1
                                    1 38 0 42 1 1 0 0 0 1 1 0 0 6 29 1 0 0 43 1
                                    1 0 95 0 1 1 42 37 0 1 1 2 0 0 1 1 0 72 0 1
                                    0 0 57 1 0 0 70 1 1 11 0 0 1 1 11 0 0 1 3 0
                                    0 0 0 0 1 2 40 19 0 0 1 1 11 0 0 1 1 11 0 0
                                    1 1 11 0 0 1 1 11 0 0 1 1 11 6 0 1 2 0 0 0
                                    0 1 2 0 19 0 0 1 1 11 0 0 1 1 11 0 0 1 1 11
                                    0 0 1 1 11 0 0 1 1 11 0 0 1 1 11 0 0 1 1 29
                                    0 0 1 2 12 0 0 42 1 2 3 0 0 43 1 2 11 0 0 0
                                    1 2 0 0 0 57 1 2 0 0 0 73 1 0 0 0 21 0 0 0
                                    23 1 28 11 0 1 2 28 8 9 0 1 2 28 11 0 19 1
                                    3 28 8 9 0 19 20 2 20 0 0 57 1 1 20 0 0 1 3
                                    19 0 0 80 85 1 2 19 0 0 80 1 3 19 0 0 81 57
                                    1 2 19 0 0 81 1 3 0 0 0 71 57 1 2 0 0 0 71
                                    1 2 0 19 0 0 1 2 3 0 0 0 1 2 0 0 0 0 32 1 0
                                    0 0 1 2 0 0 0 0 31 2 3 0 42 0 1 2 3 0 0 42
                                    1 2 0 0 6 0 1 2 0 0 0 6 1 2 0 0 57 0 1 2 0
                                    0 43 0 1 2 0 0 0 0 33 2 0 0 73 0 1)))))
           '|lookupComplete|)) 
