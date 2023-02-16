
(SDEFUN |FPARFRAC;construct;L$;1|
        ((|l|
          (|List|
           (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |center| UP)
                     (|:| |num| UP))))
         ($ ($)))
        (CONS (|spadConstant| $ 13) |l|)) 

(SDEFUN |FPARFRAC;D;2$;2| ((|r| ($)) ($ ($))) (SPADCALL |r| (QREFELT $ 32))) 

(SDEFUN |FPARFRAC;D;$Nni$;3| ((|r| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPADCALL |r| |n| (QREFELT $ 34))) 

(PUT '|FPARFRAC;polyPart;$UP;4| '|SPADreplace| 'QCAR) 

(SDEFUN |FPARFRAC;polyPart;$UP;4| ((|f| ($)) ($ (UP))) (QCAR |f|)) 

(PUT '|FPARFRAC;fracPart;$L;5| '|SPADreplace| 'QCDR) 

(SDEFUN |FPARFRAC;fracPart;$L;5|
        ((|f| ($))
         ($
          (|List|
           (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |center| UP)
                     (|:| |num| UP)))))
        (QCDR |f|)) 

(SDEFUN |FPARFRAC;+;UP2$;6| ((|p| (UP)) (|f| ($)) ($ ($)))
        (CONS (SPADCALL |p| (SPADCALL |f| (QREFELT $ 36)) (QREFELT $ 38))
              (SPADCALL |f| (QREFELT $ 37)))) 

(SDEFUN |FPARFRAC;differentiate;2$;7| ((|f| ($)) ($ ($)))
        (SPROG ((#1=#:G732 NIL) (|rec| NIL) (#2=#:G731 NIL))
               (SEQ
                (SPADCALL
                 (SPADCALL (SPADCALL |f| (QREFELT $ 36)) (QREFELT $ 40))
                 (SPADCALL
                  (PROGN
                   (LETT #2# NIL)
                   (SEQ (LETT |rec| NIL)
                        (LETT #1# (SPADCALL |f| (QREFELT $ 37))) G190
                        (COND
                         ((OR (ATOM #1#) (PROGN (LETT |rec| (CAR #1#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #2# (CONS (|FPARFRAC;diffrec| |rec| $) #2#))))
                        (LETT #1# (CDR #1#)) (GO G190) G191
                        (EXIT (NREVERSE #2#))))
                  (QREFELT $ 31))
                 (QREFELT $ 39))))) 

(SDEFUN |FPARFRAC;differentiate;$Nni$;8|
        ((|r| ($)) (|n| (|NonNegativeInteger|)) ($ ($)))
        (SPROG ((#1=#:G737 NIL) (|i| NIL))
               (SEQ
                (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                     (COND ((|greater_SI| |i| #1#) (GO G191)))
                     (SEQ (EXIT (LETT |r| (SPADCALL |r| (QREFELT $ 32)))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT |r|)))) 

(SDEFUN |FPARFRAC;diffrec|
        ((|rec|
          (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |center| UP)
                    (|:| |num| UP)))
         ($
          (|Record| (|:| |exponent| #1=(|NonNegativeInteger|))
                    (|:| |center| UP) (|:| |num| UP))))
        (SPROG ((|e| #1#))
               (SEQ (LETT |e| (QVELT |rec| 0))
                    (EXIT
                     (VECTOR (+ |e| 1) (QVELT |rec| 1)
                             (SPADCALL
                              (SPADCALL |e| (QVELT |rec| 2) (QREFELT $ 41))
                              (QREFELT $ 42))))))) 

(SDEFUN |FPARFRAC;convert;$F;10| ((|f| ($)) ($ (|Fraction| UP)))
        (SPROG ((|ans| (|Fraction| UP)) (#1=#:G746 NIL) (|rec| NIL))
               (SEQ
                (LETT |ans|
                      (SPADCALL (SPADCALL |f| (QREFELT $ 36)) (QREFELT $ 44)))
                (SEQ (LETT |rec| NIL) (LETT #1# (SPADCALL |f| (QREFELT $ 37)))
                     G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |rec| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |ans|
                             (SPADCALL |ans|
                                       (|FPARFRAC;REC2RF| (QVELT |rec| 1)
                                        (QVELT |rec| 2) (QVELT |rec| 0) $)
                                       (QREFELT $ 45)))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT |ans|)))) 

(SDEFUN |FPARFRAC;UP2SUP|
        ((|p| (UP)) ($ (|SparseUnivariatePolynomial| (|Fraction| UP))))
        (SPADCALL (CONS #'|FPARFRAC;UP2SUP!0| $) |p| (QREFELT $ 51))) 

(SDEFUN |FPARFRAC;UP2SUP!0| ((|z1| NIL) ($ NIL))
        (SPADCALL (SPADCALL |z1| (QREFELT $ 47)) (QREFELT $ 44))) 

(SDEFUN |FPARFRAC;REC2RF|
        ((|d| (UP)) (|h| (UP)) (|n| (|NonNegativeInteger|))
         ($ (|Fraction| UP)))
        (SPROG
         ((|ans| (|Fraction| UP))
          (|t| #1=(|SparseUnivariatePolynomial| (|Fraction| UP)))
          (#2=#:G763 NIL) (|i| NIL)
          (|rec|
           (|Record| (|:| |coef1| #1#)
                     (|:| |coef2|
                          (|SparseUnivariatePolynomial| (|Fraction| UP)))))
          (#3=#:G755 NIL) (|p| (|SparseUnivariatePolynomial| (|Fraction| UP)))
          (|aa| (|SparseUnivariatePolynomial| (|Fraction| UP)))
          (|hh| #4=(|SparseUnivariatePolynomial| (|Fraction| UP))) (|dd| #4#)
          (|a| (F)) (|m| (|NonNegativeInteger|)))
         (SEQ (LETT |m| (SPADCALL |d| (QREFELT $ 52)))
              (EXIT
               (COND
                ((EQL |m| 1)
                 (SEQ
                  (LETT |a|
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL (SPADCALL |d| (QREFELT $ 53))
                                    (QREFELT $ 54))
                          (SPADCALL |d| (QREFELT $ 54)) (QREFELT $ 55))
                         (QREFELT $ 56)))
                  (EXIT
                   (SPADCALL
                    (SPADCALL (SPADCALL |h| |a| (QREFELT $ 57)) (QREFELT $ 47))
                    (SPADCALL
                     (SPADCALL (QREFELT $ 24) (SPADCALL |a| (QREFELT $ 47))
                               (QREFELT $ 58))
                     |n| (QREFELT $ 59))
                    (QREFELT $ 60)))))
                ('T
                 (SEQ (LETT |dd| (|FPARFRAC;UP2SUP| |d| $))
                      (LETT |hh| (|FPARFRAC;UP2SUP| |h| $))
                      (LETT |aa|
                            (SPADCALL (|spadConstant| $ 61) 1 (QREFELT $ 62)))
                      (LETT |p|
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL (QREFELT $ 24) (QREFELT $ 44))
                                (QREFELT $ 63))
                               |aa| (QREFELT $ 64))
                              |n| (QREFELT $ 65))
                             |dd| (QREFELT $ 66)))
                      (LETT |rec|
                            (PROG2
                                (LETT #3#
                                      (SPADCALL |p| |dd| |hh| (QREFELT $ 69)))
                                (QCDR #3#)
                              (|check_union2| (QEQCAR #3# 0)
                                              (|Record|
                                               (|:| |coef1|
                                                    (|SparseUnivariatePolynomial|
                                                     (|Fraction|
                                                      (QREFELT $ 7))))
                                               (|:| |coef2|
                                                    (|SparseUnivariatePolynomial|
                                                     (|Fraction|
                                                      (QREFELT $ 7)))))
                                              (|Union|
                                               (|Record|
                                                (|:| |coef1|
                                                     (|SparseUnivariatePolynomial|
                                                      (|Fraction|
                                                       (QREFELT $ 7))))
                                                (|:| |coef2|
                                                     (|SparseUnivariatePolynomial|
                                                      (|Fraction|
                                                       (QREFELT $ 7)))))
                                               "failed")
                                              #3#)))
                      (LETT |t| (QCAR |rec|))
                      (LETT |ans| (SPADCALL |t| 0 (QREFELT $ 70)))
                      (SEQ (LETT |i| 1)
                           (LETT #2# (- (SPADCALL |d| (QREFELT $ 52)) 1)) G190
                           (COND ((|greater_SI| |i| #2#) (GO G191)))
                           (SEQ
                            (LETT |t|
                                  (SPADCALL (SPADCALL |t| |aa| (QREFELT $ 71))
                                            |dd| (QREFELT $ 66)))
                            (EXIT
                             (LETT |ans|
                                   (SPADCALL |ans|
                                             (SPADCALL |t| |i| (QREFELT $ 70))
                                             (QREFELT $ 45)))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (EXIT |ans|)))))))) 

(SDEFUN |FPARFRAC;fullPartialFraction;F$;13| ((|f| (|Fraction| UP)) ($ ($)))
        (SPROG
         ((#1=#:G789 NIL) (|rec| NIL) (#2=#:G788 NIL)
          (|qr| (|Record| (|:| |quotient| UP) (|:| |remainder| UP)))
          (|d| (UP)))
         (SEQ
          (LETT |qr|
                (SPADCALL (SPADCALL |f| (QREFELT $ 72))
                          (LETT |d| (SPADCALL |f| (QREFELT $ 73)))
                          (QREFELT $ 75)))
          (EXIT
           (SPADCALL (QCAR |qr|)
                     (SPADCALL
                      (SPADCALL
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |rec| NIL)
                             (LETT #1#
                                   (SPADCALL
                                    (SPADCALL (SPADCALL |f| (QREFELT $ 73))
                                              (QREFELT $ 77))
                                    (QREFELT $ 82)))
                             G190
                             (COND
                              ((OR (ATOM #1#)
                                   (PROGN (LETT |rec| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #2#
                                     (CONS
                                      (|FPARFRAC;fullParFrac| (QCDR |qr|) |d|
                                       (QVELT |rec| 1) (QVELT |rec| 2) $)
                                      #2#))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))
                       (QREFELT $ 84))
                      (QREFELT $ 31))
                     (QREFELT $ 39)))))) 

(SDEFUN |FPARFRAC;fullParFrac|
        ((|a| (UP)) (|d| (UP)) (|q| (UP)) (|n| (|NonNegativeInteger|))
         ($
          (|List|
           (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |center| UP)
                     (|:| |num| UP)))))
        (SPROG
         ((|bm| (UP)) (|em| (UP)) (|um| (|OrderlyDifferentialPolynomial| UP))
          (|cm| (UP))
          (|ans|
           (|List|
            (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |center| UP)
                      (|:| |num| UP))))
          (#1=#:G803 NIL) (|qq| (UP)) (|lval| (|List| UP))
          (|lvar| (|List| (|OrderlyDifferentialVariable| (|Symbol|))))
          (|h| (|Fraction| (|OrderlyDifferentialPolynomial| UP))) (|pp| (UP))
          (|p| (|OrderlyDifferentialPolynomial| UP)) (#2=#:G809 NIL) (|m| NIL)
          (|cn| (UP)) (|c| (UP))
          (|rec| (|Record| (|:| |coef1| UP) (|:| |coef2| UP))) (#3=#:G793 NIL)
          (|q1| (UP)) (|q0| (UP)) (|un| (|OrderlyDifferentialPolynomial| UP))
          (|u1| (|OrderlyDifferentialPolynomial| UP)) (|b| (UP)) (|e| (UP)))
         (SEQ (LETT |ans| NIL)
              (LETT |em|
                    (LETT |e|
                          (SPADCALL |d| (SPADCALL |q| |n| (QREFELT $ 59))
                                    (QREFELT $ 86))))
              (LETT |rec|
                    (PROG2
                        (LETT #3#
                              (SPADCALL |e| |q| (|spadConstant| $ 22)
                                        (QREFELT $ 87)))
                        (QCDR #3#)
                      (|check_union2| (QEQCAR #3# 0)
                                      (|Record| (|:| |coef1| (QREFELT $ 7))
                                                (|:| |coef2| (QREFELT $ 7)))
                                      (|Union|
                                       (|Record| (|:| |coef1| (QREFELT $ 7))
                                                 (|:| |coef2| (QREFELT $ 7)))
                                       #4="failed")
                                      #3#)))
              (LETT |bm| (LETT |b| (QCAR |rec|)))
              (LETT |lvar| (LIST (QREFELT $ 17)))
              (LETT |um| (|spadConstant| $ 89))
              (LETT |un|
                    (SPADCALL
                     (LETT |u1| (SPADCALL (QREFELT $ 17) (QREFELT $ 90))) |n|
                     (QREFELT $ 91)))
              (LETT |lval|
                    (LIST
                     (LETT |q1|
                           (LETT |q|
                                 (SPADCALL (LETT |q0| |q|) (QREFELT $ 40))))))
              (LETT |h|
                    (SPADCALL (SPADCALL |a| (QREFELT $ 92))
                              (SPADCALL |e| |un| (QREFELT $ 93))
                              (QREFELT $ 95)))
              (LETT |rec|
                    (PROG2
                        (LETT #3#
                              (SPADCALL |q1| |q0| (|spadConstant| $ 22)
                                        (QREFELT $ 87)))
                        (QCDR #3#)
                      (|check_union2| (QEQCAR #3# 0)
                                      (|Record| (|:| |coef1| (QREFELT $ 7))
                                                (|:| |coef2| (QREFELT $ 7)))
                                      (|Union|
                                       (|Record| (|:| |coef1| (QREFELT $ 7))
                                                 (|:| |coef2| (QREFELT $ 7)))
                                       #4#)
                                      #3#)))
              (LETT |c| (QCAR |rec|)) (LETT |cm| (|spadConstant| $ 22))
              (LETT |cn|
                    (SPADCALL (SPADCALL |c| |n| (QREFELT $ 59)) |q0|
                              (QREFELT $ 96)))
              (SEQ (LETT |m| 1) (LETT #2# |n|) G190
                   (COND ((|greater_SI| |m| #2#) (GO G191)))
                   (SEQ
                    (LETT |p|
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (SPADCALL |em| |un| (QREFELT $ 93)) |um|
                                      (QREFELT $ 97))
                            |h| (QREFELT $ 98))
                           (QREFELT $ 99)))
                    (LETT |pp|
                          (SPADCALL
                           (SPADCALL |p| |lvar| |lval| (QREFELT $ 102))
                           (QREFELT $ 103)))
                    (LETT |h|
                          (SPADCALL
                           (SPADCALL (SPADCALL |m| (QREFELT $ 106))
                                     (QREFELT $ 107))
                           (SPADCALL |h| (QREFELT $ 108)) (QREFELT $ 109)))
                    (LETT |q| (SPADCALL |q| (QREFELT $ 40)))
                    (LETT |lvar|
                          (CONS (SPADCALL (QREFELT $ 11) |m| (QREFELT $ 16))
                                |lvar|))
                    (LETT |lval|
                          (CONS
                           (SPADCALL
                            (SPADCALL (SPADCALL (+ |m| 1) (QREFELT $ 110))
                                      (QREFELT $ 111))
                            |q| (QREFELT $ 112))
                           |lval|))
                    (LETT |qq|
                          (SPADCALL |q0| (SPADCALL |pp| |q0| (QREFELT $ 113))
                                    (QREFELT $ 86)))
                    (COND
                     ((> (SPADCALL |qq| (QREFELT $ 52)) 0)
                      (LETT |ans|
                            (CONS
                             (VECTOR
                              (PROG1 (LETT #1# (- (+ |n| 1) |m|))
                                (|check_subtype2| (>= #1# 0)
                                                  '(|NonNegativeInteger|)
                                                  '(|Integer|) #1#))
                              |qq|
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL (SPADCALL |pp| |bm| (QREFELT $ 114))
                                          |cn| (QREFELT $ 114))
                                |cm| (QREFELT $ 114))
                               |qq| (QREFELT $ 96)))
                             |ans|))))
                    (LETT |cm|
                          (SPADCALL (SPADCALL |c| |cm| (QREFELT $ 114)) |q0|
                                    (QREFELT $ 96)))
                    (LETT |um| (SPADCALL |u1| |um| (QREFELT $ 97)))
                    (LETT |em| (SPADCALL |e| |em| (QREFELT $ 114)))
                    (EXIT
                     (LETT |bm|
                           (SPADCALL (SPADCALL |b| |bm| (QREFELT $ 114)) |q0|
                                     (QREFELT $ 96)))))
                   (LETT |m| (|inc_SI| |m|)) (GO G190) G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |FPARFRAC;coerce;$Of;15| ((|f| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|p| (UP)) (|ans| (|OutputForm|))
          (|l|
           (|List|
            (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |center| UP)
                      (|:| |num| UP)))))
         (SEQ
          (LETT |ans|
                (|FPARFRAC;FP2O| (LETT |l| (SPADCALL |f| (QREFELT $ 37))) $))
          (EXIT
           (COND
            ((SPADCALL (LETT |p| (SPADCALL |f| (QREFELT $ 36)))
                       (QREFELT $ 116))
             (COND ((NULL |l|) (SPADCALL 0 (QREFELT $ 27))) (#1='T |ans|)))
            ((NULL |l|) (SPADCALL |p| (QREFELT $ 25)))
            (#1#
             (SPADCALL (SPADCALL |p| (QREFELT $ 25)) |ans|
                       (QREFELT $ 117)))))))) 

(SDEFUN |FPARFRAC;FP2O|
        ((|l|
          (|List|
           (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |center| UP)
                     (|:| |num| UP))))
         ($ (|OutputForm|)))
        (SPROG
         ((|ans| (|OutputForm|)) (#1=#:G821 NIL)
          (|rec|
           (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |center| UP)
                     (|:| |num| UP))))
         (SEQ
          (COND ((NULL |l|) (SPADCALL (QREFELT $ 119)))
                ('T
                 (SEQ (LETT |rec| (|SPADfirst| |l|))
                      (LETT |ans|
                            (|FPARFRAC;output| (QVELT |rec| 0) (QVELT |rec| 1)
                             (QVELT |rec| 2) $))
                      (SEQ (LETT #1# (CDR |l|)) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |rec| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT |ans|
                                   (SPADCALL |ans|
                                             (|FPARFRAC;output| (QVELT |rec| 0)
                                              (QVELT |rec| 1) (QVELT |rec| 2)
                                              $)
                                             (QREFELT $ 117)))))
                           (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                      (EXIT |ans|))))))) 

(SDEFUN |FPARFRAC;output|
        ((|n| (|NonNegativeInteger|)) (|d| (UP)) (|h| (UP)) ($ (|OutputForm|)))
        (SPROG ((|a| (F)))
               (SEQ
                (COND
                 ((EQL (SPADCALL |d| (QREFELT $ 52)) 1)
                  (SEQ
                   (LETT |a|
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL (SPADCALL |d| (QREFELT $ 53))
                                     (QREFELT $ 54))
                           (SPADCALL |d| (QREFELT $ 54)) (QREFELT $ 55))
                          (QREFELT $ 56)))
                   (EXIT
                    (SPADCALL
                     (SPADCALL (SPADCALL |h| |a| (QREFELT $ 57))
                               (QREFELT $ 120))
                     (|FPARFRAC;outputexp|
                      (SPADCALL
                       (SPADCALL (QREFELT $ 24) (SPADCALL |a| (QREFELT $ 47))
                                 (QREFELT $ 58))
                       (QREFELT $ 25))
                      |n| $)
                     (QREFELT $ 121)))))
                 ('T
                  (SPADCALL
                   (SPADCALL
                    (SPADCALL (SPADCALL |h| (QREFELT $ 123)) (QREFELT $ 20)
                              (QREFELT $ 124))
                    (|FPARFRAC;outputexp|
                     (SPADCALL (QREFELT $ 26) (QREFELT $ 20) (QREFELT $ 125))
                     |n| $)
                    (QREFELT $ 121))
                   (SPADCALL
                    (SPADCALL (SPADCALL |d| (QREFELT $ 123)) (QREFELT $ 20)
                              (QREFELT $ 124))
                    (QREFELT $ 28) (QREFELT $ 126))
                   (QREFELT $ 127))))))) 

(SDEFUN |FPARFRAC;outputexp|
        ((|f| (|OutputForm|)) (|n| (|NonNegativeInteger|)) ($ (|OutputForm|)))
        (COND ((EQL |n| 1) |f|)
              ('T
               (SPADCALL |f| (SPADCALL |n| (QREFELT $ 27)) (QREFELT $ 128))))) 

(DECLAIM (NOTINLINE |FullPartialFractionExpansion;|)) 

(DEFUN |FullPartialFractionExpansion| (&REST #1=#:G827)
  (SPROG NIL
         (PROG (#2=#:G828)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FullPartialFractionExpansion|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |FullPartialFractionExpansion;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|FullPartialFractionExpansion|)))))))))) 

(DEFUN |FullPartialFractionExpansion;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|FullPartialFractionExpansion| DV$1 DV$2))
          (LETT $ (GETREFV 132))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FullPartialFractionExpansion|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8
                    (|Record| (|:| |polyPart| |#2|)
                              (|:| |fracPart|
                                   (|List|
                                    (|Record|
                                     (|:| |exponent| (|NonNegativeInteger|))
                                     (|:| |center| |#2|) (|:| |num| |#2|))))))
          (QSETREFV $ 11 (SPADCALL (QREFELT $ 10)))
          (QSETREFV $ 17 (SPADCALL (QREFELT $ 11) 0 (QREFELT $ 16)))
          (QSETREFV $ 20 (SPADCALL (QREFELT $ 11) (QREFELT $ 19)))
          (QSETREFV $ 24 (SPADCALL (|spadConstant| $ 21) 1 (QREFELT $ 23)))
          (QSETREFV $ 26 (SPADCALL (QREFELT $ 24) (QREFELT $ 25)))
          (QSETREFV $ 28 (SPADCALL 0 (QREFELT $ 27)))
          $))) 

(MAKEPROP '|FullPartialFractionExpansion| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|Rep|
              (|Symbol|) (0 . |new|) '|u| (4 . |Zero|) (8 . |Zero|)
              (|NonNegativeInteger|) (|OrderlyDifferentialVariable| 9)
              (12 . |makeVariable|) '|u0| (|OutputForm|) (18 . |coerce|)
              '|alpha| (23 . |One|) (27 . |One|) (31 . |monomial|) '|x|
              (37 . |coerce|) '|xx| (42 . |coerce|) '|zr|
              (|Record| (|:| |exponent| 14) (|:| |center| 7) (|:| |num| 7))
              (|List| 29) |FPARFRAC;construct;L$;1|
              |FPARFRAC;differentiate;2$;7| |FPARFRAC;D;2$;2|
              |FPARFRAC;differentiate;$Nni$;8| |FPARFRAC;D;$Nni$;3|
              |FPARFRAC;polyPart;$UP;4| |FPARFRAC;fracPart;$L;5| (47 . +)
              |FPARFRAC;+;UP2$;6| (53 . |differentiate|) (58 . *) (64 . -)
              (|Fraction| 7) (69 . |coerce|) (74 . +) |FPARFRAC;convert;$F;10|
              (80 . |coerce|) (|SparseUnivariatePolynomial| 43)
              (|Mapping| 43 6)
              (|UnivariatePolynomialCategoryFunctions2| 6 7 43 48) (85 . |map|)
              (91 . |degree|) (96 . |reductum|) (101 . |leadingCoefficient|)
              (106 . /) (112 . -) (117 . |elt|) (123 . -) (129 . ^) (135 . /)
              (141 . |One|) (145 . |monomial|) (151 . |coerce|) (156 . -)
              (162 . ^) (168 . |rem|)
              (|Record| (|:| |coef1| $) (|:| |coef2| $)) (|Union| 67 '"failed")
              (174 . |extendedEuclidean|) (181 . |coefficient|) (187 . *)
              (193 . |numer|) (198 . |denom|)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (203 . |divide|) (|Factored| $) (209 . |squareFree|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 78) (|:| |factor| 7) (|:| |exponent| 14))
              (|List| 79) (|Factored| 7) (214 . |factorList|) (|List| $)
              (219 . |concat|) |FPARFRAC;fullPartialFraction;F$;13|
              (224 . |quo|) (230 . |extendedEuclidean|)
              (|OrderlyDifferentialPolynomial| 7) (237 . |One|)
              (241 . |coerce|) (246 . ^) (252 . |coerce|) (257 . *)
              (|Fraction| 88) (263 . /) (269 . |rem|) (275 . *) (281 . *)
              (287 . |retract|) (|List| 15) (|List| 7) (292 . |eval|)
              (299 . |retract|) (|Integer|) (|Fraction| 104) (304 . |coerce|)
              (309 . |inv|) (314 . |differentiate|) (319 . *) (325 . |coerce|)
              (330 . |inv|) (335 . *) (341 . |gcd|) (347 . *) (|Boolean|)
              (353 . |zero?|) (358 . +) |FPARFRAC;coerce;$Of;15|
              (364 . |empty|) (368 . |coerce|) (373 . /)
              (|SparseUnivariatePolynomial| 6) (379 . |makeSUP|)
              (384 . |outputForm|) (390 . -) (396 . =) (402 . |sum|) (408 . ^)
              (|HashState|) (|String|) (|SingleInteger|))
           '#(~= 414 |polyPart| 420 |latex| 425 |hashUpdate!| 430 |hash| 436
              |fullPartialFraction| 441 |fracPart| 446 |differentiate| 451
              |convert| 462 |construct| 467 |coerce| 472 D 477 = 488 + 494)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|)
                           (|ConvertibleTo| (|Fraction| 7)) (|CoercibleTo| 18))
                        (|makeByteWordVec2| 131
                                            '(0 9 0 10 0 6 0 12 0 7 0 13 2 15 0
                                              9 14 16 1 9 18 0 19 0 6 0 21 0 7
                                              0 22 2 7 0 6 14 23 1 7 18 0 25 1
                                              14 18 0 27 2 7 0 0 0 38 1 7 0 0
                                              40 2 7 0 14 0 41 1 7 0 0 42 1 43
                                              0 7 44 2 43 0 0 0 45 1 7 0 6 47 2
                                              50 48 49 7 51 1 7 14 0 52 1 7 0 0
                                              53 1 7 6 0 54 2 6 0 0 0 55 1 6 0
                                              0 56 2 7 6 0 6 57 2 7 0 0 0 58 2
                                              7 0 0 14 59 2 43 0 7 7 60 0 43 0
                                              61 2 48 0 43 14 62 1 48 0 43 63 2
                                              48 0 0 0 64 2 48 0 0 14 65 2 48 0
                                              0 0 66 3 48 68 0 0 0 69 2 48 43 0
                                              14 70 2 48 0 0 0 71 1 43 7 0 72 1
                                              43 7 0 73 2 7 74 0 0 75 1 7 76 0
                                              77 1 81 80 0 82 1 30 0 83 84 2 7
                                              0 0 0 86 3 7 68 0 0 0 87 0 88 0
                                              89 1 88 0 15 90 2 88 0 0 14 91 1
                                              88 0 7 92 2 88 0 7 0 93 2 94 0 88
                                              88 95 2 7 0 0 0 96 2 88 0 0 0 97
                                              2 94 0 88 0 98 1 94 88 0 99 3 88
                                              0 0 100 101 102 1 88 7 0 103 1
                                              105 0 104 106 1 105 0 0 107 1 94
                                              0 0 108 2 94 0 105 0 109 1 6 0
                                              104 110 1 6 0 0 111 2 7 0 6 0 112
                                              2 7 0 0 0 113 2 7 0 0 0 114 1 7
                                              115 0 116 2 18 0 0 0 117 0 18 0
                                              119 1 6 18 0 120 2 18 0 0 0 121 1
                                              7 122 0 123 2 122 18 0 18 124 2
                                              18 0 0 0 125 2 18 0 0 0 126 2 18
                                              0 0 0 127 2 18 0 0 0 128 2 0 115
                                              0 0 1 1 0 7 0 36 1 0 130 0 1 2 0
                                              129 129 0 1 1 0 131 0 1 1 0 0 43
                                              85 1 0 30 0 37 2 0 0 0 14 34 1 0
                                              0 0 32 1 0 43 0 46 1 0 0 30 31 1
                                              0 18 0 118 2 0 0 0 14 35 1 0 0 0
                                              33 2 0 115 0 0 1 2 0 0 7 0
                                              39)))))
           '|lookupComplete|)) 
