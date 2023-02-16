
(SDEFUN |IPF;twoPower| ((|x| ($)) ($ (|NonNegativeInteger|)))
        (SPROG ((|r| (|NonNegativeInteger|)) (|ord| (|NonNegativeInteger|)))
               (SEQ
                (COND
                 ((SPADCALL |x| (|spadConstant| $ 16) (QREFELT $ 18))
                  (|error| "twoPower: argument must not be 0."))
                 ('T
                  (SEQ (LETT |ord| (SPADCALL |x| (QREFELT $ 20))) (LETT |r| 0)
                       (SEQ G190
                            (COND ((NULL (EQL (REM |ord| 2) 0)) (GO G191)))
                            (SEQ (LETT |ord| (QUOTIENT2 |ord| 2))
                                 (EXIT (LETT |r| (+ |r| 1))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT |r|))))))) 

(SDEFUN |IPF;initializePrimitiveElement| (($ (|Void|)))
        (SEQ
         (SETELT $ 10
                 (SPADCALL (SPADCALL (QREFELT $ 9) (QREFELT $ 23))
                           (QREFELT $ 27)))
         (SETELT $ 8 (SPADCALL (SPADCALL (QREFELT $ 28)) (QREFELT $ 29)))
         (SETELT $ 7 NIL) (EXIT (SPADCALL (QREFELT $ 31))))) 

(SDEFUN |IPF;initializeLogarithmTable| (($ (|Void|)))
        (SPROG
         ((#1=#:G745 NIL) (|a| ($)) (#2=#:G751 NIL) (#3=#:G739 NIL) (|i| NIL)
          (|tbl| (|Table| (|PositiveInteger|) (|NonNegativeInteger|)))
          (|n| (|Integer|)) (|d| (|Integer|)) (|l| (|Integer|)) (|base| ($))
          (|primeDivisor| (|Integer|)) (#4=#:G750 NIL) (|rec| NIL)
          (|limit| (|Integer|)))
         (SEQ (COND ((QREFELT $ 7) (|IPF;initializePrimitiveElement| $)))
              (LETT |limit| 30)
              (SEQ (LETT |rec| NIL) (LETT #4# (QREFELT $ 10)) G190
                   (COND
                    ((OR (ATOM #4#) (PROGN (LETT |rec| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |primeDivisor| (QCAR |rec|))
                        (LETT |base|
                              (SPADCALL (SPADCALL (QREFELT $ 32))
                                        (QUOTIENT2 (QREFELT $ 9)
                                                   |primeDivisor|)
                                        (QREFELT $ 33)))
                        (LETT |l| (INTEGER-LENGTH |primeDivisor|))
                        (LETT |n|
                              (COND
                               ((ODDP |l|)
                                (LETT |n|
                                      (ASH |primeDivisor|
                                           (- (QUOTIENT2 |l| 2)))))
                               ('T (LETT |n| (ASH 1 (QUOTIENT2 |l| 2))))))
                        (COND
                         ((< |n| |limit|)
                          (SEQ
                           (LETT |d|
                                 (+ (QUOTIENT2 (- |primeDivisor| 1) |limit|)
                                    1))
                           (EXIT
                            (LETT |n|
                                  (+ (QUOTIENT2 (- |primeDivisor| 1) |d|)
                                     1))))))
                        (LETT |tbl| (SPADCALL (QREFELT $ 35)))
                        (LETT |a| (|spadConstant| $ 36))
                        (SEQ (LETT |i| 0)
                             (LETT #2#
                                   (PROG1 (LETT #3# (- |n| 1))
                                     (|check_subtype2| (>= #3# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #3#)))
                             G190 (COND ((|greater_SI| |i| #2#) (GO G191)))
                             (SEQ
                              (SPADCALL
                               (CONS (SPADCALL |a| (QREFELT $ 29)) |i|) |tbl|
                               (QREFELT $ 38))
                              (EXIT
                               (LETT |a|
                                     (SPADCALL |a| |base| (QREFELT $ 39)))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))
                        (EXIT
                         (SPADCALL
                          (CONS
                           (PROG1 (LETT #1# |primeDivisor|)
                             (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                               '(|Integer|) #1#))
                           (SPADCALL |tbl| (QREFELT $ 40)))
                          (QREFELT $ 14) (QREFELT $ 42))))
                   (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
              (SETELT $ 11 NIL) (EXIT (SPADCALL (QREFELT $ 31)))))) 

(SDEFUN |IPF;quadraticNonResidue;$;4| (($ ($)))
        (SPROG ((|found?| (|Boolean|)) (|q| (|Integer|)))
               (SEQ (LETT |found?| NIL) (LETT |q| 1)
                    (SEQ G190 (COND ((NULL (NULL |found?|)) (GO G191)))
                         (SEQ (LETT |q| (+ |q| 1))
                              (EXIT
                               (LETT |found?|
                                     (EQL
                                      (SPADCALL |q| (QREFELT $ 6)
                                                (QREFELT $ 44))
                                      -1))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (SPADCALL |q| (QREFELT $ 45)))))) 

(SDEFUN |IPF;sqrt;2$;5| ((|x| ($)) ($ ($)))
        (SPROG
         ((|y| ($)) (#1=#:G766 NIL) (#2=#:G773 NIL)
          (|lr| (|List| #3=(|NonNegativeInteger|))) (|r| #3#) (|z| ($))
          (#4=#:G761 NIL) (|u| (|NonNegativeInteger|)) (#5=#:G758 NIL)
          (|e| (|NonNegativeInteger|)) (|b| ($)))
         (SEQ
          (COND ((SPADCALL |x| (QREFELT $ 47)) |x|)
                ((EQL
                  (SPADCALL (SPADCALL |x| (QREFELT $ 48)) (QREFELT $ 6)
                            (QREFELT $ 44))
                  -1)
                 (|error|
                  "sqrt: argument does not have a square root by Jacobi symbol."))
                ((EQL 3 (REM (QREFELT $ 6) 4))
                 (SEQ
                  (LETT |y|
                        (SPADCALL |x| (QUOTIENT2 (+ (QREFELT $ 6) 1) 4)
                                  (QREFELT $ 50)))
                  (EXIT
                   (COND
                    ((< (SPADCALL |y| (QREFELT $ 48))
                        (SPADCALL (SPADCALL |y| (QREFELT $ 51))
                                  (QREFELT $ 48)))
                     |y|)
                    (#6='T (SPADCALL |y| (QREFELT $ 51)))))))
                (#6#
                 (SEQ (LETT |b| (SPADCALL (QREFELT $ 46)))
                      (LETT |e| (QREFELT $ 15))
                      (LETT |u|
                            (QUOTIENT2
                             (PROG1 (LETT #5# (- (QREFELT $ 6) 1))
                               (|check_subtype2| (>= #5# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #5#))
                             (EXPT 2 |e|)))
                      (LETT |z| |x|) (LETT |r| (|IPF;twoPower| |z| $))
                      (LETT |lr| (LIST |r|))
                      (SEQ G190 (COND ((NULL (> |r| 0)) (GO G191)))
                           (SEQ
                            (LETT |z|
                                  (SPADCALL |z|
                                            (SPADCALL |b|
                                                      (EXPT 2
                                                            (PROG1
                                                                (LETT #4#
                                                                      (- |e|
                                                                         |r|))
                                                              (|check_subtype2|
                                                               (>= #4# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #4#)))
                                                      (QREFELT $ 52))
                                            (QREFELT $ 39)))
                            (LETT |r| (|IPF;twoPower| |z| $))
                            (EXIT (LETT |lr| (CONS |r| |lr|))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (LETT |y|
                            (SPADCALL |z| (QUOTIENT2 (+ |u| 1) 2)
                                      (QREFELT $ 50)))
                      (SEQ (LETT #2# (CDR |lr|)) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |r| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT |y|
                                   (SPADCALL |y|
                                             (SPADCALL |b|
                                                       (EXPT 2
                                                             (PROG1
                                                                 (LETT #1#
                                                                       (-
                                                                        (- |e|
                                                                           |r|)
                                                                        1))
                                                               (|check_subtype2|
                                                                (>= #1# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #1#)))
                                                       (QREFELT $ 52))
                                             (QREFELT $ 53)))))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (COND
                        ((< (SPADCALL |y| (QREFELT $ 48))
                            (SPADCALL (SPADCALL |y| (QREFELT $ 51))
                                      (QREFELT $ 48)))
                         |y|)
                        (#6# (SPADCALL |y| (QREFELT $ 51))))))))))) 

(SDEFUN |IPF;generator;$;6| (($ ($))) (|spadConstant| $ 36)) 

(SDEFUN |IPF;^;$I$;7| ((|x| ($)) (|n| (|Integer|)) ($ ($)))
        (SPROG ((|r| (|NonNegativeInteger|)) (#1=#:G775 NIL))
               (SEQ
                (COND ((ZEROP |n|) (|spadConstant| $ 36))
                      ((SPADCALL |x| (QREFELT $ 47)) (|spadConstant| $ 16))
                      ('T
                       (SEQ
                        (LETT |r|
                              (PROG1
                                  (LETT #1#
                                        (SPADCALL |n| (- (QREFELT $ 6) 1)
                                                  (QREFELT $ 56)))
                                (|check_subtype2| (>= #1# 0)
                                                  '(|NonNegativeInteger|)
                                                  '(|Integer|) #1#)))
                        (EXIT (SPADCALL |x| |r| (QREFELT $ 57))))))))) 

(SDEFUN |IPF;recip;$U;8| ((|x| ($)) ($ (|Union| $ "failed")))
        (SPROG ((|y| (|SingleInteger|)))
               (COND
                ((|zero?_SI|
                  (LETT |y|
                        (SPADCALL (SPADCALL |x| (QREFELT $ 48))
                                  (QREFELT $ 60))))
                 (CONS 1 "failed"))
                ('T
                 (CONS 0
                       (SPADCALL (SPADCALL |y| (QREFELT $ 61) (QREFELT $ 62))
                                 (QREFELT $ 45))))))) 

(SDEFUN |IPF;recip;$U;9| ((|x| ($)) ($ (|Union| $ "failed")))
        (SPROG ((|y| (|Integer|)))
               (COND
                ((ZEROP (LETT |y| (SPADCALL |x| (QREFELT $ 48))))
                 (CONS 1 "failed"))
                ('T
                 (CONS 0
                       (SPADCALL (SPADCALL |y| (QREFELT $ 6) (QREFELT $ 65))
                                 (QREFELT $ 45))))))) 

(PUT '|IPF;convert;$I;10| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |IPF;convert;$I;10| ((|x| ($)) ($ (|Integer|))) |x|) 

(SDEFUN |IPF;normalElement;$;11| (($ ($))) (|spadConstant| $ 36)) 

(SDEFUN |IPF;createNormalElement;$;12| (($ ($))) (|spadConstant| $ 36)) 

(SDEFUN |IPF;characteristic;Nni;13| (($ (|NonNegativeInteger|))) (QREFELT $ 6)) 

(SDEFUN |IPF;factorsOfCyclicGroupSize;L;14|
        (($
          (|List|
           (|Record| (|:| |factor| (|Integer|))
                     (|:| |exponent| (|NonNegativeInteger|))))))
        (SEQ
         (COND ((EQL (QREFELT $ 6) 2) (QREFELT $ 10))
               ('T
                (SEQ
                 (COND
                  ((NULL (QREFELT $ 10)) (|IPF;initializePrimitiveElement| $)))
                 (EXIT (QREFELT $ 10))))))) 

(PUT '|IPF;representationType;U;15| '|SPADreplace| '(XLAM NIL (CONS 0 "prime"))) 

(SDEFUN |IPF;representationType;U;15|
        (($ (|Union| "prime" "polynomial" "normal" "cyclic"))) (CONS 0 "prime")) 

(SDEFUN |IPF;tableForDiscreteLogarithm;IT;16|
        ((|fac| (|Integer|))
         ($ (|Table| (|PositiveInteger|) (|NonNegativeInteger|))))
        (SPROG
         ((|tbl|
           (|Union| (|Table| (|PositiveInteger|) (|NonNegativeInteger|))
                    "failed"))
          (#1=#:G812 NIL))
         (SEQ (COND ((QREFELT $ 11) (|IPF;initializeLogarithmTable| $)))
              (LETT |tbl|
                    (SPADCALL
                     (PROG1 (LETT #1# |fac|)
                       (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                         '(|Integer|) #1#))
                     (QREFELT $ 14) (QREFELT $ 73)))
              (EXIT
               (COND
                ((QEQCAR |tbl| 1)
                 (|error|
                  "tableForDiscreteLogarithm: argument must be prime divisor of the order of the multiplicative group"))
                ('T (QCDR |tbl|))))))) 

(SDEFUN |IPF;primitiveElement;$;17| (($ ($)))
        (SEQ (COND ((QREFELT $ 7) (|IPF;initializePrimitiveElement| $)))
             (EXIT (SPADCALL (QREFELT $ 8) (QREFELT $ 75))))) 

(PUT '|IPF;degree;$Pi;18| '|SPADreplace| '(XLAM (|x|) 1)) 

(SDEFUN |IPF;degree;$Pi;18| ((|x| ($)) ($ (|PositiveInteger|))) 1) 

(PUT '|IPF;extensionDegree;Pi;19| '|SPADreplace| '(XLAM NIL 1)) 

(SDEFUN |IPF;extensionDegree;Pi;19| (($ (|PositiveInteger|))) 1) 

(PUT '|IPF;inGroundField?;$B;20| '|SPADreplace| '(XLAM (|x|) 'T)) 

(SDEFUN |IPF;inGroundField?;$B;20| ((|x| ($)) ($ (|Boolean|))) 'T) 

(SDEFUN |IPF;coordinates;$V;21| ((|x| ($)) ($ (|Vector| $)))
        (SPADCALL 1 |x| (QREFELT $ 80))) 

(SDEFUN |IPF;represents;V$;22| ((|v| (|Vector| $)) ($ ($)))
        (SPADCALL |v| 1 (QREFELT $ 83))) 

(PUT '|IPF;retract;2$;23| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |IPF;retract;2$;23| ((|x| ($)) ($ ($))) |x|) 

(PUT '|IPF;retractIfCan;$U;24| '|SPADreplace| '(XLAM (|x|) (CONS 0 |x|))) 

(SDEFUN |IPF;retractIfCan;$U;24| ((|x| ($)) ($ (|Union| $ "failed")))
        (CONS 0 |x|)) 

(SDEFUN |IPF;basis;V;25| (($ (|Vector| $)))
        (SPADCALL 1 (|spadConstant| $ 36) (QREFELT $ 80))) 

(SDEFUN |IPF;basis;PiV;26| ((|n| (|PositiveInteger|)) ($ (|Vector| $)))
        (COND ((EQL |n| 1) (SPADCALL (QREFELT $ 87)))
              ('T (|error| "basis: argument must divide extension degree")))) 

(SDEFUN |IPF;definingPolynomial;Sup;27| (($ (|SparseUnivariatePolynomial| $)))
        (SPADCALL (SPADCALL (|spadConstant| $ 36) 1 (QREFELT $ 90))
                  (SPADCALL (|spadConstant| $ 36) 0 (QREFELT $ 90))
                  (QREFELT $ 91))) 

(SDEFUN |IPF;minimalPolynomial;$Sup;28|
        ((|x| ($)) ($ (|SparseUnivariatePolynomial| $)))
        (SPADCALL (SPADCALL (|spadConstant| $ 36) 1 (QREFELT $ 90))
                  (SPADCALL |x| 0 (QREFELT $ 90)) (QREFELT $ 91))) 

(PUT '|IPF;charthRoot;2$;29| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |IPF;charthRoot;2$;29| ((|x| ($)) ($ ($))) |x|) 

(DECLAIM (NOTINLINE |InnerPrimeField;|)) 

(DEFUN |InnerPrimeField| (#1=#:G866)
  (SPROG NIL
         (PROG (#2=#:G867)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST #1#)
                                               (HGET |$ConstructorCache|
                                                     '|InnerPrimeField|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|InnerPrimeField;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|InnerPrimeField|)))))))))) 

(DEFUN |InnerPrimeField;| (|#1|)
  (SPROG ((|r| NIL) (|cGS| NIL) (|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (SEQ
          (PROGN
           (LETT DV$1 |#1|)
           (LETT |dv$| (LIST '|InnerPrimeField| DV$1))
           (LETT $ (GETREFV 118))
           (QSETREFV $ 0 |dv$|)
           (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
           (|haddProp| |$ConstructorCache| '|InnerPrimeField| (LIST DV$1)
                       (CONS 1 $))
           (|stuffDomainSlots| $)
           (QSETREFV $ 6 |#1|)
           (AND (|HasCategory| $ '(|CharacteristicNonZero|))
                (|augmentPredVector| $ 1))
           (AND (|HasCategory| $ '(|Field|)) (|augmentPredVector| $ 2))
           (AND (|HasCategory| $ '(|Finite|)) (|augmentPredVector| $ 4))
           (SETF |pv$| (QREFELT $ 3))
           (QSETREFV $ 7 'T)
           (QSETREFV $ 8 1)
           (QSETREFV $ 9 (- |#1| 1))
           (QSETREFV $ 10 NIL)
           (QSETREFV $ 11 'T)
           (QSETREFV $ 14 (SPADCALL (QREFELT $ 13)))
           (QSETREFV $ 15
                     (SEQ (LETT |cGS| (QREFELT $ 9)) (LETT |r| 0)
                          (SEQ G190
                               (COND ((NULL (EQL (REM |cGS| 2) 0)) (GO G191)))
                               (SEQ (LETT |cGS| (QUOTIENT2 |cGS| 2))
                                    (EXIT (LETT |r| (+ |r| 1))))
                               NIL (GO G190) G191 (EXIT NIL))
                          (EXIT |r|)))
           (QSETREFV $ 58 (<= |#1| MOST-POSITIVE-FIXNUM))
           (COND
            ((QREFELT $ 58)
             (PROGN
              (QSETREFV $ 61 (SPADCALL |#1| (QREFELT $ 60)))
              (QSETREFV $ 64 (CONS (|dispatchFunction| |IPF;recip;$U;8|) $))))
            ('T
             (QSETREFV $ 64 (CONS (|dispatchFunction| |IPF;recip;$U;9|) $))))
           $)))) 

(MAKEPROP '|InnerPrimeField| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|IntegerMod| (NRTEVAL (QREFELT $ 6)))
              (|local| |#1|) '|primitiveElementNotPresent?| '|primitiveElt|
              '|cyclicGroupSize| '|factorsOfCyclicGroupSize|
              '|logarithmTableNotPresent?| (|Table| 19 34) (0 . |table|)
              '|discLogTable| '|twoPowerOfCyclicGroupSize| (4 . |Zero|)
              (|Boolean|) (8 . =) (|PositiveInteger|) (14 . |order|)
              (|Factored| $) (|Integer|) (19 . |factor|)
              (|Record| (|:| |factor| 22) (|:| |exponent| 49)) (|List| 24)
              (|Factored| 22) (24 . |factors|) (29 . |createPrimitiveElement|)
              (33 . |lookup|) (|Void|) (38 . |void|)
              |IPF;primitiveElement;$;17| |IPF;^;$I$;7| (|Table| 19 49)
              (42 . |table|) (46 . |One|)
              (|Record| (|:| |key| 19) (|:| |entry| 49)) (50 . |insert!|)
              (56 . *) (62 . |copy|) (|Record| (|:| |key| 19) (|:| |entry| 34))
              (67 . |insert!|) (|IntegerNumberTheoryFunctions|) (73 . |jacobi|)
              (79 . |coerce|) |IPF;quadraticNonResidue;$;4| (84 . |zero?|)
              |IPF;convert;$I;10| (|NonNegativeInteger|) (89 . ^) (95 . -)
              (100 . ^) (106 . /) |IPF;sqrt;2$;5| |IPF;generator;$;6|
              (112 . |positiveRemainder|) (118 . ^) '#:G699 (|SingleInteger|)
              (124 . |coerce|) '|q| (129 . |invmod|) (|Union| $ '"failed")
              (135 . |recip|) (140 . |invmod|) |IPF;normalElement;$;11|
              |IPF;createNormalElement;$;12| |IPF;characteristic;Nni;13|
              |IPF;factorsOfCyclicGroupSize;L;14|
              (|Union| '"prime" '"polynomial" '"normal" '"cyclic")
              |IPF;representationType;U;15| (|Union| 34 '"failed")
              (146 . |search|) |IPF;tableForDiscreteLogarithm;IT;16|
              (152 . |index|) |IPF;degree;$Pi;18| |IPF;extensionDegree;Pi;19|
              |IPF;inGroundField?;$B;20| (|Vector| $$) (157 . |new|)
              (|Vector| $) |IPF;coordinates;$V;21| (163 . |elt|)
              |IPF;represents;V$;22| |IPF;retract;2$;23|
              |IPF;retractIfCan;$U;24| |IPF;basis;V;25| |IPF;basis;PiV;26|
              (|SparseUnivariatePolynomial| $$) (169 . |monomial|) (175 . -)
              (|SparseUnivariatePolynomial| $) |IPF;definingPolynomial;Sup;27|
              |IPF;minimalPolynomial;$Sup;28| |IPF;charthRoot;2$;29|
              (|Union| 81 '#1="failed") (|Matrix| $) (|Union| 92 '"failed")
              (|OnePointCompletion| 19) (|Factored| 92) (|Union| 102 '#1#)
              (|List| 92) (|InputForm|) (|List| $) (|Union| 49 '"failed")
              (|Fraction| 22) (|Union| 104 '#2="failed")
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $)) (|Union| 109 '#2#)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef| 104) (|:| |generator| $))
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|String|) (|HashState|) (|OutputForm|))
           '#(|zero?| 181 |tableForDiscreteLogarithm| 186 |sqrt| 191
              |retractIfCan| 196 |retract| 201 |represents| 206
              |representationType| 211 |recip| 215 |quadraticNonResidue| 220
              |primitiveElement| 224 |order| 228 |normalElement| 233
              |minimalPolynomial| 237 |lookup| 242 |index| 247 |inGroundField?|
              252 |generator| 257 |factorsOfCyclicGroupSize| 261
              |extensionDegree| 265 |degree| 269 |definingPolynomial| 274
              |createPrimitiveElement| 278 |createNormalElement| 282
              |coordinates| 286 |convert| 291 |coerce| 296 |charthRoot| 301
              |characteristic| 306 |basis| 310 ^ 319 |Zero| 337 |One| 341 = 345
              / 351 - 357 * 362)
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
                 (|GcdDomain|) (|FramedAlgebra| $$ 89) (|IntegralDomain|)
                 (|FiniteRankAlgebra| $$ 89) (|CommutativeRing|)
                 (|DivisionRing|) (|LeftOreRing|) (|Algebra| $$)
                 (|DifferentialRing|) (|CharacteristicNonZero|) (|Algebra| 106)
                 (|EntireRing|) (|Ring|) (|Rng|) (|SemiRing|) (|Module| 106)
                 (|Module| $$) (|SemiRng|) (|FramedModule| $$)
                 (|BiModule| 106 106) (|BiModule| $$ $$) (|NonAssociativeRing|)
                 (|RightModule| 106) (|LeftModule| 106) (|LeftModule| $$)
                 (|NonAssociativeRng|) (|RightModule| $$) (|AbelianGroup|)
                 (|Monoid|) (|NonAssociativeSemiRing|)
                 (|CancellationAbelianMonoid|) (|Finite|) (|SemiGroup|)
                 (|MagmaWithUnit|) (|NonAssociativeSemiRng|) (|AbelianMonoid|)
                 (|StepThrough|) (|Comparable|) (|Magma|) (|AbelianSemiGroup|)
                 (|RetractableTo| $$) (|CommutativeStar|) (|SetCategory|)
                 (|ConvertibleTo| 22) (|CoercibleFrom| $$)
                 (|ConvertibleTo| 103) (|canonicalsClosed|)
                 (|canonicalUnitNormal|) (|noZeroDivisors|) (|TwoSidedRecip|)
                 (|unitsKnown|) (|BasicType|) (|CoercibleTo| 117))
              (|makeByteWordVec2| 95
                                  '(0 12 0 13 0 0 0 16 2 0 17 0 0 18 1 0 19 0
                                    20 1 22 21 0 23 1 26 25 0 27 0 0 0 28 1 0
                                    19 0 29 0 30 0 31 0 34 0 35 0 0 0 36 2 34 0
                                    37 0 38 2 0 0 0 0 39 1 34 0 0 40 2 12 0 41
                                    0 42 2 43 22 22 22 44 1 0 0 22 45 1 0 17 0
                                    47 2 0 0 0 49 50 1 0 0 0 51 2 0 0 0 19 52 2
                                    0 0 0 0 53 2 22 0 0 0 56 2 5 0 0 49 57 1 59
                                    0 22 60 2 59 0 0 0 62 1 0 63 0 64 2 22 0 0
                                    0 65 2 12 72 19 0 73 1 0 0 19 75 2 79 0 49
                                    2 80 2 79 2 0 22 83 2 89 0 2 49 90 2 89 0 0
                                    0 91 1 0 17 0 47 1 0 34 22 74 1 0 0 0 54 1
                                    0 63 0 86 1 0 0 0 85 1 0 0 81 84 0 0 70 71
                                    1 0 63 0 64 0 0 0 46 0 0 0 32 1 0 19 0 20 0
                                    3 0 66 1 2 92 0 94 1 0 19 0 29 1 0 0 19 75
                                    1 0 17 0 78 0 3 0 55 0 0 25 69 0 0 19 77 1
                                    0 19 0 76 0 0 92 93 0 0 0 28 0 3 0 67 1 0
                                    81 0 82 1 0 22 0 48 1 0 0 22 45 1 0 0 0 95
                                    0 0 49 68 1 3 81 19 88 0 0 81 87 2 0 0 0 22
                                    33 2 0 0 0 49 50 2 0 0 0 19 52 0 0 0 16 0 0
                                    0 36 2 0 17 0 0 18 2 0 0 0 0 53 1 0 0 0 51
                                    2 0 0 0 0 39)))))
           '|lookupIncomplete|)) 
