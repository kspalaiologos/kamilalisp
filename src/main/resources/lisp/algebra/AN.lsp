
(SDEFUN |AN;reducedSystem;MM;1|
        ((|m| (|Matrix| $)) ($ (|Matrix| (|Fraction| (|Integer|)))))
        (SPROG ((|mz| (|Matrix| (|Integer|))))
               (SEQ (LETT |mz| (SPADCALL |m| (QREFELT $ 10)))
                    (EXIT (SPADCALL (ELT $ 13) |mz| (QREFELT $ 17)))))) 

(SDEFUN |AN;reducedSystem;MVR;2|
        ((|m| (|Matrix| $)) (|v| (|Vector| $))
         ($
          (|Record| (|:| |mat| (|Matrix| (|Fraction| (|Integer|))))
                    (|:| |vec| (|Vector| (|Fraction| (|Integer|)))))))
        (SPROG
         ((|vq| (|Vector| (|Fraction| (|Integer|))))
          (|mq| (|Matrix| (|Fraction| (|Integer|))))
          (|mzr|
           (|Record| (|:| |mat| (|Matrix| (|Integer|)))
                     (|:| |vec| (|Vector| (|Integer|))))))
         (SEQ (LETT |mzr| (SPADCALL |m| |v| (QREFELT $ 21)))
              (LETT |mq| (SPADCALL (ELT $ 13) (QCAR |mzr|) (QREFELT $ 17)))
              (LETT |vq| (SPADCALL (ELT $ 13) (QCDR |mzr|) (QREFELT $ 25)))
              (EXIT (CONS |mq| |vq|))))) 

(SDEFUN |AN;mainRatDenom| ((|f| ($)) ($ ($))) (SPADCALL |f| (QREFELT $ 29))) 

(SDEFUN |AN;findDenominator|
        ((|z| #1=(|SparseUnivariatePolynomial| $))
         ($
          #2=(|Record| (|:| |num| (|SparseUnivariatePolynomial| $))
                       (|:| |den| $))))
        (SPROG ((#3=#:G730 NIL) (|rec| #2#) (|zz| #1#) (|dd| ($)))
               (SEQ
                (EXIT
                 (SEQ (LETT |zz| |z|)
                      (SEQ G190
                           (COND
                            ((NULL
                              (NULL
                               (SPADCALL |zz| (|spadConstant| $ 33)
                                         (QREFELT $ 35))))
                             (GO G191)))
                           (SEQ
                            (LETT |dd|
                                  (SPADCALL
                                   (SPADCALL (SPADCALL |zz| (QREFELT $ 36))
                                             (QREFELT $ 38))
                                   (QREFELT $ 39)))
                            (EXIT
                             (COND
                              ((SPADCALL |dd| (|spadConstant| $ 40)
                                         (QREFELT $ 42))
                               (LETT |zz| (SPADCALL |zz| (QREFELT $ 43))))
                              ('T
                               (SEQ
                                (LETT |rec|
                                      (|AN;findDenominator|
                                       (SPADCALL |dd| |z| (QREFELT $ 44)) $))
                                (EXIT
                                 (PROGN
                                  (LETT #3#
                                        (CONS (QCAR |rec|)
                                              (SPADCALL (QCDR |rec|) |dd|
                                                        (QREFELT $ 45))))
                                  (GO #4=#:G729))))))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (EXIT (CONS |z| (|spadConstant| $ 40)))))
                #4# (EXIT #3#)))) 

(SDEFUN |AN;makeUnivariate|
        ((|p| (|SparseMultivariatePolynomial| (|Integer|) (|Kernel| $)))
         (|k| (|Kernel| $)) ($ (|SparseUnivariatePolynomial| $)))
        (SPADCALL (ELT $ 39) (SPADCALL |p| |k| (QREFELT $ 49)) (QREFELT $ 53))) 

(SDEFUN |AN;differentiate;2$;6| ((|x| ($)) ($ ($))) (|spadConstant| $ 30)) 

(SDEFUN |AN;zero?;$B;7| ((|a| ($)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |a| (QREFELT $ 55)) (QREFELT $ 56))) 

(SDEFUN |AN;one?;$B;8| ((|a| ($)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (SPADCALL |a| (QREFELT $ 55)) (|spadConstant| $ 58)
                    (QREFELT $ 59))
          (SPADCALL (SPADCALL |a| (QREFELT $ 38)) (|spadConstant| $ 58)
                    (QREFELT $ 59)))
         ('T NIL))) 

(SDEFUN |AN;/;3$;9| ((|x| ($)) (|y| ($)) ($ ($)))
        (|AN;mainRatDenom| (SPADCALL |x| |y| (QREFELT $ 61)) $)) 

(SDEFUN |AN;^;$I$;10| ((|x| ($)) (|n| (|Integer|)) ($ ($)))
        (COND
         ((< |n| 0) (|AN;mainRatDenom| (SPADCALL |x| |n| (QREFELT $ 63)) $))
         ('T (SPADCALL |x| |n| (QREFELT $ 63))))) 

(SDEFUN |AN;trueEqual;2$B;11| ((|a| ($)) (|b| ($)) ($ (|Boolean|)))
        (SPROG
         ((|dg| (|NonNegativeInteger|))
          (|g| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
          (|sb| #1=(|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
          (|sa| #1#)
          (|nb| #2=(|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
          (|na| #2#) (|pb| #3=(|SparseUnivariatePolynomial| $)) (|pa| #3#)
          (|kb| #4=(|List| (|Kernel| $))) (|ka| #4#))
         (SEQ (LETT |ka| (REVERSE (SPADCALL |a| (QREFELT $ 66))))
              (LETT |kb| (REVERSE (SPADCALL |b| (QREFELT $ 66))))
              (COND
               ((NULL |ka|)
                (COND
                 ((NULL |kb|)
                  (EXIT
                   (SPADCALL (SPADCALL |a| (QREFELT $ 67))
                             (SPADCALL |b| (QREFELT $ 67)) (QREFELT $ 68)))))))
              (LETT |pa|
                    (SPADCALL (SPADCALL (|spadConstant| $ 40) 1 (QREFELT $ 70))
                              (SPADCALL |a| 0 (QREFELT $ 70)) (QREFELT $ 71)))
              (LETT |pb|
                    (SPADCALL (SPADCALL (|spadConstant| $ 40) 1 (QREFELT $ 70))
                              (SPADCALL |b| 0 (QREFELT $ 70)) (QREFELT $ 71)))
              (LETT |na|
                    (SPADCALL (ELT $ 67) (SPADCALL |pa| |ka| (QREFELT $ 72))
                              (QREFELT $ 76)))
              (LETT |nb|
                    (SPADCALL (ELT $ 67) (SPADCALL |pb| |kb| (QREFELT $ 72))
                              (QREFELT $ 76)))
              (LETT |sa| (SPADCALL |na| (QREFELT $ 77)))
              (LETT |sb| (SPADCALL |nb| (QREFELT $ 77)))
              (EXIT
               (COND ((SPADCALL |sa| |sb| (QREFELT $ 78)) 'T)
                     ('T
                      (SEQ (LETT |g| (SPADCALL |sa| |sb| (QREFELT $ 79)))
                           (LETT |dg| (SPADCALL |g| (QREFELT $ 80)))
                           (EXIT
                            (NULL
                             (OR (EQL |dg| 0)
                                 (NULL
                                  (OR (EQL |dg| (SPADCALL |sa| (QREFELT $ 80)))
                                      (EQL |dg|
                                           (SPADCALL |sb|
                                                     (QREFELT $
                                                              80))))))))))))))) 

(SDEFUN |AN;norm;$K$;12| ((|z| ($)) (|k| (|Kernel| $)) ($ ($)))
        (SPROG
         ((|d| #1=(|SparseUnivariatePolynomial| $)) (|n| #1#)
          (|p| (|SparseUnivariatePolynomial| $)))
         (SEQ (LETT |p| (SPADCALL |k| (QREFELT $ 83)))
              (LETT |n|
                    (|AN;makeUnivariate| (SPADCALL |z| (QREFELT $ 55)) |k| $))
              (LETT |d|
                    (|AN;makeUnivariate| (SPADCALL |z| (QREFELT $ 38)) |k| $))
              (EXIT
               (SPADCALL (SPADCALL |n| |p| (QREFELT $ 84))
                         (SPADCALL |d| |p| (QREFELT $ 84)) (QREFELT $ 62)))))) 

(SDEFUN |AN;norm;$L$;13| ((|z| ($)) (|l| (|List| (|Kernel| $))) ($ ($)))
        (SPROG ((#1=#:G758 NIL) (|k| NIL))
               (SEQ
                (SEQ (LETT |k| NIL) (LETT #1# |l|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ (EXIT (LETT |z| (SPADCALL |z| |k| (QREFELT $ 85)))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT |z|)))) 

(SDEFUN |AN;norm;SupKSup;14|
        ((|z| (|SparseUnivariatePolynomial| $)) (|k| (|Kernel| $))
         ($ (|SparseUnivariatePolynomial| $)))
        (SPROG
         ((|zz|
           #1=(|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| $)))
          (|f|
           (|Record| (|:| |num| (|SparseUnivariatePolynomial| $))
                     (|:| |den| $)))
          (|p| #1#))
         (SEQ
          (LETT |p|
                (SPADCALL (ELT $ 87) (SPADCALL |k| (QREFELT $ 83))
                          (QREFELT $ 91)))
          (LETT |f| (|AN;findDenominator| |z| $))
          (LETT |zz|
                (SPADCALL (CONS #'|AN;norm;SupKSup;14!0| (VECTOR |k| $))
                          (QCAR |f|) (QREFELT $ 91)))
          (LETT |zz| (SPADCALL |zz| (QREFELT $ 93)))
          (EXIT
           (SPADCALL (SPADCALL |p| |zz| (QREFELT $ 94))
                     (SPADCALL (QCDR |f|) |k| (QREFELT $ 85))
                     (QREFELT $ 95)))))) 

(SDEFUN |AN;norm;SupKSup;14!0| ((|x| NIL) ($$ NIL))
        (PROG ($ |k|)
          (LETT $ (QREFELT $$ 1))
          (LETT |k| (QREFELT $$ 0))
          (RETURN
           (PROGN (|AN;makeUnivariate| (SPADCALL |x| (QREFELT $ 55)) |k| $))))) 

(SDEFUN |AN;norm;SupLSup;15|
        ((|z| (|SparseUnivariatePolynomial| $)) (|l| (|List| (|Kernel| $)))
         ($ (|SparseUnivariatePolynomial| $)))
        (SPROG ((#1=#:G766 NIL) (|k| NIL))
               (SEQ
                (SEQ (LETT |k| NIL) (LETT #1# |l|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ (EXIT (LETT |z| (SPADCALL |z| |k| (QREFELT $ 96)))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT |z|)))) 

(SDEFUN |AN;belong?;BoB;16| ((|op| (|BasicOperator|)) ($ (|Boolean|)))
        (COND ((SPADCALL |op| (QREFELT $ 99)) 'T)
              ('T (SPADCALL |op| (QREFELT $ 7) (QREFELT $ 101))))) 

(SDEFUN |AN;convert;$If;17| ((|x| ($)) ($ (|InputForm|)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 104)) (QREFELT $ 106))) 

(SDEFUN |AN;convert;$F;18| ((|x| ($)) ($ (|Float|)))
        (SPADCALL (SPADCALL (ELT $ 109) |x| (QREFELT $ 113)) (QREFELT $ 114))) 

(SDEFUN |AN;convert;$Df;19| ((|x| ($)) ($ (|DoubleFloat|)))
        (SPADCALL (SPADCALL (ELT $ 117) |x| (QREFELT $ 121)) (QREFELT $ 122))) 

(SDEFUN |AN;convert;$C;20| ((|x| ($)) ($ (|Complex| (|Float|))))
        (SPADCALL (SPADCALL (ELT $ 125) |x| (QREFELT $ 129)) (QREFELT $ 130))) 

(DECLAIM (NOTINLINE |AlgebraicNumber;|)) 

(DEFUN |AlgebraicNumber| ()
  (SPROG NIL
         (PROG (#1=#:G826)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|AlgebraicNumber|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|AlgebraicNumber|
                             (LIST (CONS NIL (CONS 1 (|AlgebraicNumber;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|AlgebraicNumber|)))))))))) 

(DEFUN |AlgebraicNumber;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|AlgebraicNumber|))
          (LETT $ (GETREFV 164))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|AlgebraicNumber| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (AND (|HasCategory| $ '(|Ring|)) (|augmentPredVector| $ 1))
          (AND (|HasCategory| $ '(|RetractableTo| (|Integer|)))
               (|augmentPredVector| $ 2))
          (AND (|HasCategory| $ '(|CharacteristicNonZero|))
               (|augmentPredVector| $ 4))
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 (|Expression| (|Integer|)))
          (QSETREFV $ 7 '|%alg|)
          $))) 

(MAKEPROP '|AlgebraicNumber| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|Expression| 11) '|Rep| 'ALGOP (|Matrix| 11)
              (|Matrix| $) (0 . |reducedSystem|) (|Integer|) (|Fraction| 11)
              (5 . |coerce|) (|Matrix| 12) (|Mapping| 12 11)
              (|MatrixCategoryFunctions2| 11 23 23 8 12 22 22 14) (10 . |map|)
              |AN;reducedSystem;MM;1| (|Record| (|:| |mat| 8) (|:| |vec| 23))
              (|Vector| $) (16 . |reducedSystem|) (|Vector| 12) (|Vector| 11)
              (|VectorFunctions2| 11 12) (22 . |map|)
              (|Record| (|:| |mat| 14) (|:| |vec| 22)) |AN;reducedSystem;MVR;2|
              (|AlgebraicManipulations| 11 5) (28 . |ratDenom|) (33 . |Zero|)
              (37 . |Zero|) (|SparseUnivariatePolynomial| $$) (41 . |Zero|)
              (|Boolean|) (45 . =) (51 . |leadingCoefficient|)
              (|SparseMultivariatePolynomial| 11 82) (56 . |denom|)
              (61 . |coerce|) (66 . |One|) (70 . |One|) (74 . =)
              (80 . |reductum|) (85 . *) (91 . *)
              (|SparseUnivariatePolynomial| $) (|Kernel| $$)
              (|SparseMultivariatePolynomial| 11 47) (97 . |univariate|)
              (|Mapping| $$ 48) (|SparseUnivariatePolynomial| 48)
              (|SparseUnivariatePolynomialFunctions2| 48 $$) (103 . |map|)
              |AN;differentiate;2$;6| (109 . |numer|) (114 . |zero?|)
              |AN;zero?;$B;7| (119 . |One|) (123 . =) |AN;one?;$B;8| (129 . /)
              |AN;/;3$;9| (135 . ^) |AN;^;$I$;10| (|List| 82) (141 . |tower|)
              (146 . |retract|) (151 . =) (|NonNegativeInteger|)
              (157 . |monomial|) (163 . -) |AN;norm;SupLSup;15|
              (|SparseUnivariatePolynomial| 12) (|Mapping| 12 $$)
              (|SparseUnivariatePolynomialFunctions2| $$ 12) (169 . |map|)
              (175 . |squareFreePart|) (180 . =) (186 . |gcd|) (192 . |degree|)
              |AN;trueEqual;2$B;11| (|Kernel| $) (197 . |minPoly|)
              (202 . |resultant|) |AN;norm;$K$;12| |AN;norm;$L$;13|
              (208 . |coerce|) (|SparseUnivariatePolynomial| 32)
              (|Mapping| 32 $$) (|SparseUnivariatePolynomialFunctions2| $$ 32)
              (213 . |map|) (|CommuteUnivariatePolynomialCategory| $$ 32 88)
              (219 . |swap|) (224 . |resultant|) (230 . /) |AN;norm;SupKSup;14|
              (|BasicOperator|) (|ExpressionSpace&| $$) (236 . |belong?|)
              (|Symbol|) (241 . |has?|) |AN;belong?;BoB;16| (|InputForm|)
              (247 . |convert|) (|InputFormFunctions1| $$)
              (252 . |coerceToType|) |AN;convert;$If;17| (|Float|)
              (257 . |coerce|) (|Expression| 108) (|Mapping| 108 11)
              (|ExpressionFunctions2| 11 108) (262 . |map|) (268 . |retract|)
              |AN;convert;$F;18| (|DoubleFloat|) (273 . |coerce|)
              (|Expression| 116) (|Mapping| 116 11)
              (|ExpressionFunctions2| 11 116) (278 . |map|) (284 . |retract|)
              |AN;convert;$Df;19| (|Complex| 108) (289 . |coerce|)
              (|Expression| 124) (|Mapping| 124 11)
              (|ExpressionFunctions2| 11 124) (294 . |map|) (300 . |retract|)
              |AN;convert;$C;20| (|Union| $ '#1="failed") (|Union| 20 '#1#)
              (|Factored| 46) (|Union| 136 '#1#) (|List| 46)
              (|Union| 12 '#2="failed") (|Union| 11 '#2#) (|PositiveInteger|)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|List| $) (|Record| (|:| |coef| 142) (|:| |generator| $))
              (|Union| 142 '"failed")
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 146 '"failed")
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Factored| $) (|Polynomial| $) (|Mapping| $ $) (|Mapping| $ 142)
              (|List| 97) (|List| 151) (|List| 152) (|List| 100)
              (|Union| 82 '"failed") (|List| 159) (|Equation| $) (|String|)
              (|SingleInteger|) (|HashState|) (|OutputForm|))
           '#(~= 305 |zerosOf| 311 |zeroOf| 327 |zero?| 343 |unitNormal| 348
              |unitCanonical| 353 |unit?| 358 |trueEqual| 363 |tower| 369
              |subtractIfCan| 379 |subst| 385 |squareFreePolynomial| 404
              |squareFreePart| 409 |squareFree| 414 |sqrt| 419
              |solveLinearPolynomialEquation| 424 |smaller?| 430 |sizeLess?|
              436 |sample| 442 |rootsOf| 446 |rootOf| 462 |rightRecip| 478
              |rightPower| 483 |retractIfCan| 495 |retract| 510 |rem| 525
              |reducedSystem| 531 |reduce| 553 |recip| 558 |quo| 563
              |principalIdeal| 569 |prime?| 574 |paren| 579 |opposite?| 584
              |operators| 590 |operator| 595 |one?| 600 |odd?| 605 |numer| 610
              |nthRoot| 615 |norm| 621 |multiEuclidean| 645 |minPoly| 651 |map|
              656 |mainKernel| 662 |leftRecip| 667 |leftPower| 672 |lcmCoef|
              684 |lcm| 690 |latex| 701 |kernels| 706 |kernel| 716 |is?| 728
              |inv| 740 |height| 745 |hashUpdate!| 750 |hash| 756
              |gcdPolynomial| 761 |gcd| 767 |freeOf?| 778
              |factorSquareFreePolynomial| 790 |factorPolynomial| 795 |factor|
              800 |extendedEuclidean| 805 |exquo| 818 |expressIdealMember| 824
              |even?| 830 |eval| 835 |euclideanSize| 931 |elt| 936 |divide|
              1032 |distribute| 1038 |differentiate| 1049 |denom| 1060
              |definingPolynomial| 1065 |convert| 1070 |conditionP| 1090
              |commutator| 1095 |coerce| 1101 |charthRoot| 1131
              |characteristic| 1136 |box| 1140 |belong?| 1145 |associator| 1150
              |associates?| 1157 |antiCommutator| 1163 |annihilate?| 1169 ^
              1175 |Zero| 1199 |One| 1203 D 1207 = 1218 / 1224 - 1230 + 1241 *
              1247)
           'NIL
           (CONS
            (|makeByteWordVec2| 1
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
                                  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
            (CONS
             '#(|AlgebraicallyClosedField&| |Field&|
                |PolynomialFactorizationExplicit&| |EuclideanDomain&|
                |UniqueFactorizationDomain&| NIL |GcdDomain&| NIL
                |DivisionRing&| NIL NIL |DifferentialRing&| NIL NIL NIL
                |Algebra&| |EntireRing&| |Algebra&| NIL NIL |Rng&| |Module&|
                |Module&| NIL NIL NIL |NonAssociativeRing&| NIL NIL NIL NIL
                |NonAssociativeRng&| |AbelianGroup&| NIL NIL NIL
                |ExpressionSpace&| NIL |MagmaWithUnit&| |AbelianMonoid&|
                |NonAssociativeSemiRng&| NIL |Magma&| |AbelianSemiGroup&| NIL
                |RetractableTo&| |RetractableTo&| NIL |SetCategory&|
                |Evalable&| |RetractableTo&| NIL NIL NIL NIL NIL NIL
                |RadicalCategory&| NIL NIL NIL NIL NIL |BasicType&|
                |InnerEvalable&| |InnerEvalable&| NIL NIL)
             (CONS
              '#((|AlgebraicallyClosedField|) (|Field|)
                 (|PolynomialFactorizationExplicit|) (|EuclideanDomain|)
                 (|UniqueFactorizationDomain|) (|PrincipalIdealDomain|)
                 (|GcdDomain|) (|IntegralDomain|) (|DivisionRing|)
                 (|LeftOreRing|) (|CommutativeRing|) (|DifferentialRing|)
                 (|CharacteristicZero|) (|LinearlyExplicitOver| 12)
                 (|LinearlyExplicitOver| 11) (|Algebra| 12) (|EntireRing|)
                 (|Algebra| $$) (|Ring|) (|SemiRing|) (|Rng|) (|Module| 12)
                 (|Module| $$) (|SemiRng|) (|BiModule| 12 12)
                 (|BiModule| $$ $$) (|NonAssociativeRing|) (|RightModule| 12)
                 (|LeftModule| 12) (|LeftModule| $$) (|RightModule| $$)
                 (|NonAssociativeRng|) (|AbelianGroup|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|ExpressionSpace|) (|SemiGroup|) (|MagmaWithUnit|)
                 (|AbelianMonoid|) (|NonAssociativeSemiRng|) (|Comparable|)
                 (|Magma|) (|AbelianSemiGroup|) (|RealConstant|)
                 (|RetractableTo| 12) (|RetractableTo| 11) (|CommutativeStar|)
                 (|SetCategory|) (|Evalable| $$) (|RetractableTo| 47)
                 (|ConvertibleTo| 103) (|ConvertibleTo| 124)
                 (|ConvertibleTo| 108) (|ConvertibleTo| 116)
                 (|CoercibleFrom| 12) (|CoercibleFrom| 11) (|RadicalCategory|)
                 (|canonicalsClosed|) (|canonicalUnitNormal|)
                 (|noZeroDivisors|) (|TwoSidedRecip|) (|unitsKnown|)
                 (|BasicType|) (|InnerEvalable| $$ $$) (|InnerEvalable| 47 $$)
                 (|CoercibleFrom| 47) (|CoercibleTo| 163))
              (|makeByteWordVec2| 163
                                  '(1 6 8 9 10 1 12 0 11 13 2 16 14 15 8 17 2 6
                                    19 9 20 21 2 24 22 15 23 25 1 28 5 5 29 0 0
                                    0 30 0 6 0 31 0 32 0 33 2 32 34 0 0 35 1 32
                                    2 0 36 1 0 37 0 38 1 0 0 37 39 0 0 0 40 0 6
                                    0 41 2 0 34 0 0 42 1 32 0 0 43 2 32 0 2 0
                                    44 2 0 0 0 0 45 2 48 46 0 47 49 2 52 32 50
                                    51 53 1 0 37 0 55 1 48 34 0 56 0 48 0 58 2
                                    48 34 0 0 59 2 6 0 0 0 61 2 6 0 0 11 63 1 0
                                    65 0 66 1 0 12 0 67 2 12 34 0 0 68 2 32 0 2
                                    69 70 2 32 0 0 0 71 2 75 73 74 32 76 1 73 0
                                    0 77 2 73 34 0 0 78 2 73 0 0 0 79 1 73 69 0
                                    80 1 0 46 82 83 2 32 2 0 0 84 1 32 0 2 87 2
                                    90 88 89 32 91 1 92 88 88 93 2 88 32 0 0 94
                                    2 32 0 0 2 95 1 98 34 97 99 2 97 34 0 100
                                    101 1 6 103 0 104 1 105 103 103 106 1 108 0
                                    11 109 2 112 110 111 5 113 1 110 108 0 114
                                    1 116 0 11 117 2 120 118 119 5 121 1 118
                                    116 0 122 1 124 0 11 125 2 128 126 127 5
                                    129 1 126 124 0 130 2 0 34 0 0 1 1 0 142
                                    150 1 2 0 142 46 100 1 1 0 142 46 1 1 0 0
                                    150 1 1 0 0 46 1 2 0 0 46 100 1 1 0 34 0 57
                                    1 0 140 0 1 1 0 0 0 1 1 0 34 0 1 2 0 34 0 0
                                    81 1 0 65 0 66 1 0 65 142 1 2 0 132 0 0 1 2
                                    0 0 0 158 1 3 0 0 0 65 142 1 2 0 0 0 159 1
                                    1 0 134 46 1 1 0 0 0 1 1 0 149 0 1 1 0 0 0
                                    1 2 0 135 136 46 1 2 0 34 0 0 1 2 0 34 0 0
                                    1 0 0 0 1 1 0 142 150 1 1 0 142 46 1 2 0
                                    142 46 100 1 1 0 0 150 1 1 0 0 46 1 2 0 0
                                    46 100 1 1 0 132 0 1 2 0 0 0 139 1 2 0 0 0
                                    69 1 1 0 137 0 1 1 0 138 0 1 1 0 157 0 1 1
                                    0 12 0 67 1 0 11 0 1 1 0 82 0 1 2 0 0 0 0 1
                                    2 0 26 9 20 27 1 0 14 9 18 1 0 8 9 1 2 0 19
                                    9 20 1 1 0 0 0 1 1 0 132 0 1 2 0 0 0 0 1 1
                                    0 143 142 1 1 0 34 0 1 1 0 0 0 1 2 0 34 0 0
                                    1 1 0 153 0 1 1 0 97 97 1 1 0 34 0 60 1 2
                                    34 0 1 1 0 37 0 55 2 0 0 0 11 1 2 0 0 0 82
                                    85 2 0 0 0 65 86 2 0 46 46 65 72 2 0 46 46
                                    82 96 2 0 144 142 0 1 1 1 46 82 83 2 0 0
                                    151 82 1 1 0 157 0 1 1 0 132 0 1 2 0 0 0
                                    139 1 2 0 0 0 69 1 2 0 141 0 0 1 2 0 0 0 0
                                    1 1 0 0 142 1 1 0 160 0 1 1 0 65 0 1 1 0 65
                                    142 1 2 0 0 97 142 1 2 0 0 97 0 1 2 0 34 0
                                    97 1 2 0 34 0 100 1 1 0 0 0 1 1 0 69 0 1 2
                                    0 162 162 0 1 1 0 161 0 1 2 0 46 46 46 1 2
                                    0 0 0 0 1 1 0 0 142 1 2 0 34 0 100 1 2 0 34
                                    0 0 1 1 0 134 46 1 1 0 134 46 1 1 0 149 0 1
                                    3 0 147 0 0 0 1 2 0 148 0 0 1 2 0 132 0 0 1
                                    2 0 144 142 0 1 1 2 34 0 1 3 0 0 0 97 151 1
                                    3 0 0 0 97 152 1 3 0 0 0 153 154 1 3 0 0 0
                                    153 155 1 3 0 0 0 100 152 1 3 0 0 0 100 151
                                    1 3 0 0 0 156 155 1 3 0 0 0 156 154 1 3 0 0
                                    0 0 0 1 3 0 0 0 142 142 1 2 0 0 0 159 1 3 0
                                    0 0 65 142 1 2 0 0 0 158 1 3 0 0 0 82 0 1 1
                                    0 69 0 1 10 0 0 97 0 0 0 0 0 0 0 0 0 1 2 0
                                    0 97 142 1 9 0 0 97 0 0 0 0 0 0 0 0 1 7 0 0
                                    97 0 0 0 0 0 0 1 8 0 0 97 0 0 0 0 0 0 0 1 5
                                    0 0 97 0 0 0 0 1 6 0 0 97 0 0 0 0 0 1 4 0 0
                                    97 0 0 0 1 2 0 0 97 0 1 3 0 0 97 0 0 1 2 0
                                    145 0 0 1 2 0 0 0 0 1 1 0 0 0 1 1 0 0 0 54
                                    2 0 0 0 69 1 1 0 37 0 38 1 1 0 0 1 1 0 124
                                    0 131 1 0 103 0 107 1 0 116 0 123 1 0 108 0
                                    115 1 3 133 9 1 2 0 0 0 0 1 1 0 0 37 39 1 0
                                    0 11 1 1 0 0 0 1 1 0 0 12 1 1 0 0 82 1 1 0
                                    163 0 1 1 3 132 0 1 0 0 69 1 1 0 0 0 1 1 0
                                    34 97 102 3 0 0 0 0 0 1 2 0 34 0 0 1 2 0 0
                                    0 0 1 2 0 34 0 0 1 2 0 0 0 139 1 2 0 0 0 69
                                    1 2 0 0 0 11 64 2 0 0 0 12 1 0 0 0 30 0 0 0
                                    40 1 0 0 0 1 2 0 0 0 69 1 2 0 34 0 0 42 2 0
                                    0 0 0 62 2 0 0 0 0 1 1 0 0 0 1 2 0 0 0 0 1
                                    2 0 0 139 0 1 2 0 0 0 0 45 2 0 0 11 0 1 2 0
                                    0 69 0 1 2 0 0 0 12 1 2 0 0 12 0 1)))))
           '|lookupComplete|)) 

(MAKEPROP '|AlgebraicNumber| 'NILADIC T) 
