
(SDEFUN |FRAC;coerce;S$;1| ((|d| (S)) ($ ($))) (CONS |d| (|spadConstant| $ 9))) 

(SDEFUN |FRAC;zero?;$B;2| ((|x| ($)) ($ (|Boolean|)))
        (SPADCALL (QCAR |x|) (QREFELT $ 12))) 

(SDEFUN |FRAC;factorFraction;$F;3| ((|p| ($)) ($ (|Fraction| (|Factored| S))))
        (SPADCALL (SPADCALL (QCAR |p|) (QREFELT $ 15))
                  (SPADCALL (QCDR |p|) (QREFELT $ 15)) (QREFELT $ 18))) 

(SDEFUN |FRAC;=;2$B;4| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (QCAR |x|) (QCAR |y|) (QREFELT $ 20))
          (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 20)))
         ('T NIL))) 

(SDEFUN |FRAC;hashUpdate!;Hs$Hs;5| ((|s| #1=(|HashState|)) (|x| ($)) ($ #1#))
        (SEQ (LETT |s| (SPADCALL |s| (QCAR |x|) (QREFELT $ 23)))
             (EXIT (SPADCALL |s| (QCDR |x|) (QREFELT $ 23))))) 

(SDEFUN |FRAC;one?;$B;6| ((|x| ($)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (QCAR |x|) (|spadConstant| $ 9) (QREFELT $ 20))
          (SPADCALL (QCDR |x|) (|spadConstant| $ 9) (QREFELT $ 20)))
         ('T NIL))) 

(SDEFUN |FRAC;retract;$S;7| ((|x| ($)) ($ (S)))
        (COND
         ((SPADCALL (QCDR |x|) (|spadConstant| $ 9) (QREFELT $ 20)) (QCAR |x|))
         ('T (|error| "Denominator not equal to 1")))) 

(SDEFUN |FRAC;retractIfCan;$U;8| ((|x| ($)) ($ (|Union| S "failed")))
        (COND
         ((SPADCALL (QCDR |x|) (|spadConstant| $ 9) (QREFELT $ 20))
          (CONS 0 (QCAR |x|)))
         ('T (CONS 1 "failed")))) 

(SDEFUN |FRAC;retract;$S;9| ((|x| ($)) ($ (S)))
        (SPROG ((|a| (|Union| S "failed")))
               (SEQ (LETT |a| (SPADCALL (QCAR |x|) (QCDR |x|) (QREFELT $ 30)))
                    (EXIT
                     (COND
                      ((QEQCAR |a| 1) (|error| "Denominator not equal to 1"))
                      ('T (QCDR |a|))))))) 

(SDEFUN |FRAC;retractIfCan;$U;10| ((|x| ($)) ($ (|Union| S "failed")))
        (SPADCALL (QCAR |x|) (QCDR |x|) (QREFELT $ 30))) 

(SDEFUN |FRAC;retract;$S;11| ((|x| ($)) ($ (S)))
        (SPROG ((|a| (|Union| S "failed")))
               (SEQ (LETT |a| (SPADCALL (QCAR |x|) (QCDR |x|) (QREFELT $ 30)))
                    (EXIT
                     (COND
                      ((QEQCAR |a| 1) (|error| "Denominator not equal to 1"))
                      ('T (QCDR |a|))))))) 

(SDEFUN |FRAC;retractIfCan;$U;12| ((|x| ($)) ($ (|Union| S "failed")))
        (SPADCALL (QCAR |x|) (QCDR |x|) (QREFELT $ 30))) 

(SDEFUN |FRAC;wholePart;$S;13| ((|x| ($)) ($ (S)))
        (COND
         ((SPADCALL (QCDR |x|) (|spadConstant| $ 9) (QREFELT $ 20)) (QCAR |x|))
         ('T (SPADCALL (QCAR |x|) (QCDR |x|) (QREFELT $ 31))))) 

(SDEFUN |FRAC;floor;$S;14| ((|x| ($)) ($ (S)))
        (COND
         ((SPADCALL (QCDR |x|) (|spadConstant| $ 9) (QREFELT $ 20)) (QCAR |x|))
         ((SPADCALL |x| (|spadConstant| $ 33) (QREFELT $ 35))
          (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 36)) (QREFELT $ 37))
                    (QREFELT $ 38)))
         ('T (SPADCALL |x| (QREFELT $ 32))))) 

(SDEFUN |FRAC;ceiling;$S;15| ((|x| ($)) ($ (S)))
        (COND
         ((SPADCALL (QCDR |x|) (|spadConstant| $ 9) (QREFELT $ 20)) (QCAR |x|))
         ((SPADCALL |x| (|spadConstant| $ 33) (QREFELT $ 35))
          (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 36)) (QREFELT $ 39))
                    (QREFELT $ 38)))
         ('T
          (SPADCALL (|spadConstant| $ 9) (SPADCALL |x| (QREFELT $ 32))
                    (QREFELT $ 40))))) 

(SDEFUN |FRAC;writeOMFrac| ((|dev| (|OpenMathDevice|)) (|x| ($)) ($ (|Void|)))
        (SEQ (SPADCALL |dev| (QREFELT $ 43))
             (SPADCALL |dev| "nums1" "rational" (QREFELT $ 45))
             (SPADCALL |dev| (QCAR |x|) NIL (QREFELT $ 46))
             (SPADCALL |dev| (QCDR |x|) NIL (QREFELT $ 46))
             (EXIT (SPADCALL |dev| (QREFELT $ 47))))) 

(SDEFUN |FRAC;OMwrite;Omd$BV;17|
        ((|dev| (|OpenMathDevice|)) (|x| ($)) (|wholeObj| (|Boolean|))
         ($ (|Void|)))
        (SEQ (COND (|wholeObj| (SPADCALL |dev| (QREFELT $ 48))))
             (|FRAC;writeOMFrac| |dev| |x| $)
             (EXIT (COND (|wholeObj| (SPADCALL |dev| (QREFELT $ 49))))))) 

(SDEFUN |FRAC;normalize| ((|x| ($)) ($ ($)))
        (SPROG
         ((|uca|
           (|Record| (|:| |unit| S) (|:| |canonical| S) (|:| |associate| S))))
         (SEQ
          (COND ((SPADCALL (QCAR |x|) (QREFELT $ 12)) (|spadConstant| $ 33))
                ((SPADCALL (QCDR |x|) (|spadConstant| $ 9) (QREFELT $ 20)) |x|)
                (#1='T
                 (SEQ (LETT |uca| (SPADCALL (QCDR |x|) (QREFELT $ 52)))
                      (EXIT
                       (COND
                        ((SPADCALL
                          (PROGN (RPLACD |x| (QVELT |uca| 1)) (QCDR |x|))
                          (QREFELT $ 12))
                         (|error| "division by zero"))
                        (#1#
                         (SEQ
                          (PROGN
                           (RPLACA |x|
                                   (SPADCALL (QCAR |x|) (QVELT |uca| 2)
                                             (QREFELT $ 53)))
                           (QCAR |x|))
                          (EXIT |x|))))))))))) 

(SDEFUN |FRAC;recip;$U;19| ((|x| ($)) ($ (|Union| $ "failed")))
        (COND ((SPADCALL (QCAR |x|) (QREFELT $ 12)) (CONS 1 "failed"))
              ('T (CONS 0 (|FRAC;normalize| (CONS (QCDR |x|) (QCAR |x|)) $))))) 

(SDEFUN |FRAC;cancelGcd| ((|x| ($)) ($ (S)))
        (SPROG ((|xd| #1=(|Union| S "failed")) (|xn| #1#) (|d| (S)))
               (SEQ
                (COND
                 ((SPADCALL (QCDR |x|) (|spadConstant| $ 9) (QREFELT $ 20))
                  (QCDR |x|))
                 (#2='T
                  (SEQ
                   (LETT |d| (SPADCALL (QCAR |x|) (QCDR |x|) (QREFELT $ 55)))
                   (LETT |xn| (SPADCALL (QCAR |x|) |d| (QREFELT $ 30)))
                   (EXIT
                    (COND
                     ((QEQCAR |xn| 1)
                      (|error| "gcd not gcd in QF cancelGcd (numerator)"))
                     (#2#
                      (SEQ (LETT |xd| (SPADCALL (QCDR |x|) |d| (QREFELT $ 30)))
                           (EXIT
                            (COND
                             ((QEQCAR |xd| 1)
                              (|error|
                               "gcd not gcd in QF cancelGcd (denominator)"))
                             (#2#
                              (SEQ (PROGN (RPLACA |x| (QCDR |xn|)) (QCAR |x|))
                                   (PROGN (RPLACD |x| (QCDR |xd|)) (QCDR |x|))
                                   (EXIT |d|))))))))))))))) 

(SDEFUN |FRAC;/;2S$;21| ((|nn| (S)) (|dd| (S)) ($ ($)))
        (SPROG ((|z| ($)))
               (SEQ
                (COND
                 ((SPADCALL |dd| (QREFELT $ 12)) (|error| "division by zero"))
                 ('T
                  (SEQ (|FRAC;cancelGcd| (LETT |z| (CONS |nn| |dd|)) $)
                       (EXIT (|FRAC;normalize| |z| $)))))))) 

(SDEFUN |FRAC;+;3$;22| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((|g| ($)) (|d| (S)) (|z| ($)))
               (SEQ
                (COND ((SPADCALL |y| (QREFELT $ 13)) |x|)
                      ((SPADCALL |x| (QREFELT $ 13)) |y|)
                      ('T
                       (SEQ (LETT |z| (CONS (QCDR |x|) (QCDR |y|)))
                            (LETT |d| (|FRAC;cancelGcd| |z| $))
                            (LETT |g|
                                  (CONS
                                   (SPADCALL
                                    (SPADCALL (QCDR |z|) (QCAR |x|)
                                              (QREFELT $ 53))
                                    (SPADCALL (QCAR |z|) (QCAR |y|)
                                              (QREFELT $ 53))
                                    (QREFELT $ 40))
                                   |d|))
                            (|FRAC;cancelGcd| |g| $)
                            (PROGN
                             (RPLACD |g|
                                     (SPADCALL
                                      (SPADCALL (QCDR |g|) (QCAR |z|)
                                                (QREFELT $ 53))
                                      (QCDR |z|) (QREFELT $ 53)))
                             (QCDR |g|))
                            (EXIT (|FRAC;normalize| |g| $)))))))) 

(SDEFUN |FRAC;-;3$;23| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((|g| ($)) (|d| (S)) (|z| ($)))
               (SEQ
                (COND ((SPADCALL |y| (QREFELT $ 13)) |x|)
                      ('T
                       (SEQ (LETT |z| (CONS (QCDR |x|) (QCDR |y|)))
                            (LETT |d| (|FRAC;cancelGcd| |z| $))
                            (LETT |g|
                                  (CONS
                                   (SPADCALL
                                    (SPADCALL (QCDR |z|) (QCAR |x|)
                                              (QREFELT $ 53))
                                    (SPADCALL (QCAR |z|) (QCAR |y|)
                                              (QREFELT $ 53))
                                    (QREFELT $ 58))
                                   |d|))
                            (|FRAC;cancelGcd| |g| $)
                            (PROGN
                             (RPLACD |g|
                                     (SPADCALL
                                      (SPADCALL (QCDR |g|) (QCAR |z|)
                                                (QREFELT $ 53))
                                      (QCDR |z|) (QREFELT $ 53)))
                             (QCDR |g|))
                            (EXIT (|FRAC;normalize| |g| $)))))))) 

(SDEFUN |FRAC;*;3$;24| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((|#G37| ($)) (|#G36| ($)))
               (SEQ
                (COND
                 ((OR (SPADCALL |x| (QREFELT $ 13))
                      (SPADCALL |y| (QREFELT $ 13)))
                  (|spadConstant| $ 33))
                 ('T
                  (COND
                   ((SPADCALL |x| (|spadConstant| $ 8) (QREFELT $ 21)) |y|)
                   ((SPADCALL |y| (|spadConstant| $ 8) (QREFELT $ 21)) |x|)
                   ('T
                    (SEQ
                     (PROGN
                      (LETT |#G36| (CONS (QCAR |x|) (QCDR |y|)))
                      (LETT |#G37| (CONS (QCAR |y|) (QCDR |x|)))
                      (LETT |x| |#G36|)
                      (LETT |y| |#G37|))
                     (|FRAC;cancelGcd| |x| $) (|FRAC;cancelGcd| |y| $)
                     (EXIT
                      (|FRAC;normalize|
                       (CONS (SPADCALL (QCAR |x|) (QCAR |y|) (QREFELT $ 53))
                             (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 53)))
                       $)))))))))) 

(SDEFUN |FRAC;*;I2$;25| ((|n| (|Integer|)) (|x| ($)) ($ ($)))
        (SPROG ((|y| ($)))
               (SEQ (LETT |y| (CONS (SPADCALL |n| (QREFELT $ 62)) (QCDR |x|)))
                    (|FRAC;cancelGcd| |y| $)
                    (EXIT
                     (|FRAC;normalize|
                      (CONS (SPADCALL (QCAR |x|) (QCAR |y|) (QREFELT $ 53))
                            (QCDR |y|))
                      $))))) 

(SDEFUN |FRAC;*;S2$;26| ((|nn| (S)) (|x| ($)) ($ ($)))
        (SPROG ((|y| ($)))
               (SEQ (LETT |y| (CONS |nn| (QCDR |x|))) (|FRAC;cancelGcd| |y| $)
                    (EXIT
                     (|FRAC;normalize|
                      (CONS (SPADCALL (QCAR |x|) (QCAR |y|) (QREFELT $ 53))
                            (QCDR |y|))
                      $))))) 

(SDEFUN |FRAC;differentiate;$M$;27|
        ((|x| ($)) (|deriv| (|Mapping| S S)) ($ ($)))
        (SPROG ((|d| (S)) (|#G45| (S)) (|#G44| (S)) (|y| ($)))
               (SEQ (LETT |y| (CONS (SPADCALL (QCDR |x|) |deriv|) (QCDR |x|)))
                    (LETT |d| (|FRAC;cancelGcd| |y| $))
                    (PROGN
                     (RPLACA |y|
                             (SPADCALL
                              (SPADCALL (SPADCALL (QCAR |x|) |deriv|)
                                        (QCDR |y|) (QREFELT $ 53))
                              (SPADCALL (QCAR |x|) (QCAR |y|) (QREFELT $ 53))
                              (QREFELT $ 58)))
                     (QCAR |y|))
                    (PROGN
                     (LETT |#G44| (QCDR |y|))
                     (LETT |#G45| |d|)
                     (LETT |d| |#G44|)
                     (PROGN (RPLACD |y| |#G45|) (QCDR |y|)))
                    (|FRAC;cancelGcd| |y| $)
                    (PROGN
                     (RPLACD |y|
                             (SPADCALL (SPADCALL (QCDR |y|) |d| (QREFELT $ 53))
                                       |d| (QREFELT $ 53)))
                     (QCDR |y|))
                    (EXIT (|FRAC;normalize| |y| $))))) 

(SDEFUN |FRAC;/;2S$;28| ((|nn| (S)) (|dd| (S)) ($ ($)))
        (COND ((SPADCALL |dd| (QREFELT $ 12)) (|error| "division by zero"))
              ('T (CONS |nn| |dd|)))) 

(SDEFUN |FRAC;recip;$U;29| ((|x| ($)) ($ (|Union| $ "failed")))
        (COND ((SPADCALL (QCAR |x|) (QREFELT $ 12)) (CONS 1 "failed"))
              ('T (CONS 0 (CONS (QCDR |x|) (QCAR |x|)))))) 

(SDEFUN |FRAC;retract;$F;30| ((|x| ($)) ($ (|Fraction| (|Integer|))))
        (SPADCALL (SPADCALL |x| (QREFELT $ 26)) (QREFELT $ 68))) 

(SDEFUN |FRAC;retractIfCan;$U;31|
        ((|x| ($)) ($ (|Union| (|Fraction| (|Integer|)) "failed")))
        (SPROG ((|u| (|Union| S "failed")))
               (SEQ (LETT |u| (SPADCALL |x| (QREFELT $ 28)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                           ('T (SPADCALL (QCDR |u|) (QREFELT $ 71)))))))) 

(SDEFUN |FRAC;retract;$F;32| ((|x| ($)) ($ (|Fraction| (|Integer|))))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 73)) (QREFELT $ 74))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 75)) (QREFELT $ 74))
                  (QREFELT $ 76))) 

(SDEFUN |FRAC;retractIfCan;$U;33|
        ((|x| ($)) ($ (|Union| (|Fraction| (|Integer|)) "failed")))
        (SPROG ((|d| #1=(|Union| (|Integer|) "failed")) (|n| #1#))
               (SEQ
                (LETT |n|
                      (SPADCALL (SPADCALL |x| (QREFELT $ 73)) (QREFELT $ 78)))
                (EXIT
                 (COND ((QEQCAR |n| 1) (CONS 1 "failed"))
                       (#2='T
                        (SEQ
                         (LETT |d|
                               (SPADCALL (SPADCALL |x| (QREFELT $ 75))
                                         (QREFELT $ 78)))
                         (EXIT
                          (COND ((QEQCAR |d| 1) (CONS 1 "failed"))
                                (#2#
                                 (CONS 0
                                       (SPADCALL (QCDR |n|) (QCDR |d|)
                                                 (QREFELT $ 76))))))))))))) 

(SDEFUN |FRAC;gcdPolynomial;3Sup;34|
        ((|pp| #1=(|SparseUnivariatePolynomial| $)) (|qq| #1#) ($ #1#))
        (SPROG
         ((|lc| (S)) (|g| (|SparseUnivariatePolynomial| S))
          (|qqD| #2=(|SparseUnivariatePolynomial| S)) (|denqq| (S))
          (#3=#:G1426 NIL) (#4=#:G1425 (S)) (#5=#:G1427 (S)) (#6=#:G1436 NIL)
          (|u| NIL) (|ppD| #2#) (|denpp| (S)) (#7=#:G1422 NIL) (#8=#:G1421 (S))
          (#9=#:G1423 (S)) (#10=#:G1435 NIL))
         (SEQ
          (COND ((SPADCALL |pp| (QREFELT $ 80)) |qq|)
                ((SPADCALL |qq| (QREFELT $ 80)) |pp|)
                ((OR (ZEROP (SPADCALL |pp| (QREFELT $ 82)))
                     (ZEROP (SPADCALL |qq| (QREFELT $ 82))))
                 (|spadConstant| $ 83))
                ('T
                 (SEQ
                  (LETT |denpp|
                        (PROGN
                         (LETT #7# NIL)
                         (SEQ (LETT |u| NIL)
                              (LETT #10# (SPADCALL |pp| (QREFELT $ 85))) G190
                              (COND
                               ((OR (ATOM #10#)
                                    (PROGN (LETT |u| (CAR #10#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (PROGN
                                 (LETT #9# (SPADCALL |u| (QREFELT $ 75)))
                                 (COND
                                  (#7#
                                   (LETT #8#
                                         (SPADCALL #8# #9# (QREFELT $ 86))))
                                  ('T (PROGN (LETT #8# #9#) (LETT #7# 'T)))))))
                              (LETT #10# (CDR #10#)) (GO G190) G191 (EXIT NIL))
                         (COND (#7# #8#) (#11='T (|spadConstant| $ 9)))))
                  (LETT |ppD|
                        (SPADCALL
                         (CONS #'|FRAC;gcdPolynomial;3Sup;34!0|
                               (VECTOR $ |denpp|))
                         |pp| (QREFELT $ 91)))
                  (LETT |denqq|
                        (PROGN
                         (LETT #3# NIL)
                         (SEQ (LETT |u| NIL)
                              (LETT #6# (SPADCALL |qq| (QREFELT $ 85))) G190
                              (COND
                               ((OR (ATOM #6#)
                                    (PROGN (LETT |u| (CAR #6#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (PROGN
                                 (LETT #5# (SPADCALL |u| (QREFELT $ 75)))
                                 (COND
                                  (#3#
                                   (LETT #4#
                                         (SPADCALL #4# #5# (QREFELT $ 86))))
                                  ('T (PROGN (LETT #4# #5#) (LETT #3# 'T)))))))
                              (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
                         (COND (#3# #4#) (#11# (|spadConstant| $ 9)))))
                  (LETT |qqD|
                        (SPADCALL
                         (CONS #'|FRAC;gcdPolynomial;3Sup;34!1|
                               (VECTOR $ |denqq|))
                         |qq| (QREFELT $ 91)))
                  (LETT |g| (SPADCALL |ppD| |qqD| (QREFELT $ 93)))
                  (EXIT
                   (COND
                    ((ZEROP (SPADCALL |g| (QREFELT $ 94)))
                     (|spadConstant| $ 83))
                    (#11#
                     (SEQ (LETT |lc| (SPADCALL |g| (QREFELT $ 95)))
                          (EXIT
                           (COND
                            ((SPADCALL |lc| (|spadConstant| $ 9)
                                       (QREFELT $ 20))
                             (SPADCALL (ELT $ 10) |g| (QREFELT $ 98)))
                            (#11#
                             (SPADCALL
                              (CONS #'|FRAC;gcdPolynomial;3Sup;34!2|
                                    (VECTOR $ |lc|))
                              |g| (QREFELT $ 98))))))))))))))) 

(SDEFUN |FRAC;gcdPolynomial;3Sup;34!2| ((|x| NIL) ($$ NIL))
        (PROG (|lc| $)
          (LETT |lc| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |lc| (QREFELT $ 56)))))) 

(SDEFUN |FRAC;gcdPolynomial;3Sup;34!1| ((|x| NIL) ($$ NIL))
        (PROG (|denqq| $)
          (LETT |denqq| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| |denqq| (QREFELT $ 87)) (QREFELT $ 26)))))) 

(SDEFUN |FRAC;gcdPolynomial;3Sup;34!0| ((|x| NIL) ($$ NIL))
        (PROG (|denpp| $)
          (LETT |denpp| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| |denpp| (QREFELT $ 87)) (QREFELT $ 26)))))) 

(SDEFUN |FRAC;charthRoot;$U;35| ((|x| ($)) ($ (|Union| $ #1="failed")))
        (SPROG ((|d| #2=(|Union| S #1#)) (|n| #2#))
               (SEQ (LETT |n| (SPADCALL (QCAR |x|) (QREFELT $ 100)))
                    (EXIT
                     (COND ((QEQCAR |n| 1) (CONS 1 "failed"))
                           (#3='T
                            (SEQ
                             (LETT |d| (SPADCALL (QCDR |x|) (QREFELT $ 100)))
                             (EXIT
                              (COND ((QEQCAR |d| 1) (CONS 1 "failed"))
                                    (#3#
                                     (CONS 0
                                           (SPADCALL (QCDR |n|) (QCDR |d|)
                                                     (QREFELT $ 56))))))))))))) 

(SDEFUN |FRAC;charthRoot;$U;36| ((|x| ($)) ($ (|Union| $ #1="failed")))
        (SPROG ((|ans| (|Union| S #1#)) (#2=#:G1462 NIL))
               (SEQ
                (LETT |ans|
                      (SPADCALL
                       (SPADCALL (QCAR |x|)
                                 (SPADCALL (QCDR |x|)
                                           (PROG1
                                               (LETT #2#
                                                     (-
                                                      (SPADCALL
                                                       (QREFELT $ 102))
                                                      1))
                                             (|check_subtype2| (>= #2# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #2#))
                                           (QREFELT $ 103))
                                 (QREFELT $ 53))
                       (QREFELT $ 100)))
                (EXIT
                 (COND ((QEQCAR |ans| 1) (CONS 1 "failed"))
                       ('T
                        (CONS 0
                              (SPADCALL (QCDR |ans|) (QCDR |x|)
                                        (QREFELT $ 56))))))))) 

(SDEFUN |FRAC;charthRoot;$U;37| ((|x| ($)) ($ (|Union| $ #1="failed")))
        (SPROG ((|ans| (|Union| S #1#)) (#2=#:G1483 NIL))
               (SEQ
                (LETT |ans|
                      (SPADCALL
                       (SPADCALL (QCAR |x|)
                                 (SPADCALL (QCDR |x|)
                                           (PROG1
                                               (LETT #2#
                                                     (-
                                                      (SPADCALL
                                                       (QREFELT $ 102))
                                                      1))
                                             (|check_subtype2| (>= #2# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #2#))
                                           (QREFELT $ 103))
                                 (QREFELT $ 53))
                       (QREFELT $ 100)))
                (EXIT
                 (COND ((QEQCAR |ans| 1) (CONS 1 "failed"))
                       ('T
                        (CONS 0
                              (SPADCALL (QCDR |ans|) (QCDR |x|)
                                        (QREFELT $ 56))))))))) 

(SDEFUN |FRAC;clear| ((|l| (|List| $)) ($ (|List| S)))
        (SPROG
         ((#1=#:G1494 NIL) (#2=#:G1501 NIL) (|x| NIL) (#3=#:G1500 NIL)
          (|d| (S)) (#4=#:G1490 NIL) (#5=#:G1489 (S)) (#6=#:G1491 (S))
          (#7=#:G1499 NIL))
         (SEQ
          (LETT |d|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |x| NIL) (LETT #7# |l|) G190
                      (COND
                       ((OR (ATOM #7#) (PROGN (LETT |x| (CAR #7#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #6# (QCDR |x|))
                         (COND
                          (#4# (LETT #5# (SPADCALL #5# #6# (QREFELT $ 86))))
                          ('T (PROGN (LETT #5# #6#) (LETT #4# 'T)))))))
                      (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
                 (COND (#4# #5#) ('T (|spadConstant| $ 9)))))
          (EXIT
           (PROGN
            (LETT #3# NIL)
            (SEQ (LETT |x| NIL) (LETT #2# |l|) G190
                 (COND
                  ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL)) (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #3#
                         (CONS
                          (SPADCALL (QCAR |x|)
                                    (PROG2
                                        (LETT #1#
                                              (SPADCALL |d| (QCDR |x|)
                                                        (QREFELT $ 30)))
                                        (QCDR #1#)
                                      (|check_union2| (QEQCAR #1# 0)
                                                      (QREFELT $ 6)
                                                      (|Union| (QREFELT $ 6)
                                                               "failed")
                                                      #1#))
                                    (QREFELT $ 53))
                          #3#))))
                 (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT (NREVERSE #3#)))))))) 

(SDEFUN |FRAC;conditionP;MU;39|
        ((|mat| (|Matrix| $)) ($ (|Union| (|Vector| $) #1="failed")))
        (SPROG
         ((#2=#:G1522 NIL) (#3=#:G1524 NIL) (|i| NIL) (#4=#:G1523 NIL)
          (|ansDD| (|Vector| S)) (|ansD| (|Union| (|Vector| S) #1#))
          (|matD| (|Matrix| S)) (#5=#:G1521 NIL) (|l| NIL) (#6=#:G1520 NIL))
         (SEQ
          (LETT |matD|
                (SPADCALL
                 (PROGN
                  (LETT #6# NIL)
                  (SEQ (LETT |l| NIL)
                       (LETT #5# (SPADCALL |mat| (QREFELT $ 106))) G190
                       (COND
                        ((OR (ATOM #5#) (PROGN (LETT |l| (CAR #5#)) NIL))
                         (GO G191)))
                       (SEQ (EXIT (LETT #6# (CONS (|FRAC;clear| |l| $) #6#))))
                       (LETT #5# (CDR #5#)) (GO G190) G191
                       (EXIT (NREVERSE #6#))))
                 (QREFELT $ 109)))
          (LETT |ansD| (SPADCALL |matD| (QREFELT $ 112)))
          (EXIT
           (COND ((QEQCAR |ansD| 1) (CONS 1 "failed"))
                 ('T
                  (SEQ (LETT |ansDD| (QCDR |ansD|))
                       (EXIT
                        (CONS 0
                              (PROGN
                               (LETT #4# (GETREFV #7=(QVSIZE |ansDD|)))
                               (SEQ (LETT |i| 1) (LETT #3# #7#) (LETT #2# 0)
                                    G190
                                    (COND ((|greater_SI| |i| #3#) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (SETELT #4# #2#
                                              (SPADCALL
                                               (SPADCALL |ansDD| |i|
                                                         (QREFELT $ 114))
                                               (QREFELT $ 10)))))
                                    (LETT #2#
                                          (PROG1 (|inc_SI| #2#)
                                            (LETT |i| (|inc_SI| |i|))))
                                    (GO G190) G191 (EXIT NIL))
                               #4#)))))))))) 

(SDEFUN |FRAC;factorPolynomial;SupF;40|
        ((|pp| #1=(|SparseUnivariatePolynomial| $)) ($ (|Factored| #1#)))
        (SPROG
         ((|lfact|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| (|SparseUnivariatePolynomial| $))
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|den1| ($)) (|lc| ($)) (#2=#:G1548 NIL) (|w| NIL) (#3=#:G1547 NIL)
          (|ff| (|Factored| (|SparseUnivariatePolynomial| S)))
          (|ppD| (|SparseUnivariatePolynomial| S)) (|denpp| (S))
          (#4=#:G1526 NIL) (#5=#:G1525 (S)) (#6=#:G1527 (S)) (#7=#:G1546 NIL)
          (|u| NIL))
         (SEQ
          (COND ((SPADCALL |pp| (QREFELT $ 80)) (|spadConstant| $ 117))
                (#8='T
                 (SEQ
                  (LETT |denpp|
                        (PROGN
                         (LETT #4# NIL)
                         (SEQ (LETT |u| NIL)
                              (LETT #7# (SPADCALL |pp| (QREFELT $ 85))) G190
                              (COND
                               ((OR (ATOM #7#)
                                    (PROGN (LETT |u| (CAR #7#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (PROGN
                                 (LETT #6# (SPADCALL |u| (QREFELT $ 75)))
                                 (COND
                                  (#4#
                                   (LETT #5#
                                         (SPADCALL #5# #6# (QREFELT $ 86))))
                                  ('T (PROGN (LETT #5# #6#) (LETT #4# 'T)))))))
                              (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
                         (COND (#4# #5#) (#8# (|spadConstant| $ 9)))))
                  (LETT |ppD|
                        (SPADCALL
                         (CONS #'|FRAC;factorPolynomial;SupF;40!0|
                               (VECTOR $ |denpp|))
                         |pp| (QREFELT $ 91)))
                  (LETT |ff| (SPADCALL |ppD| (QREFELT $ 119)))
                  (LETT |den1| (SPADCALL |denpp| (QREFELT $ 10)))
                  (LETT |lfact|
                        (PROGN
                         (LETT #3# NIL)
                         (SEQ (LETT |w| NIL)
                              (LETT #2# (SPADCALL |ff| (QREFELT $ 124))) G190
                              (COND
                               ((OR (ATOM #2#)
                                    (PROGN (LETT |w| (CAR #2#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #3#
                                      (CONS
                                       (VECTOR (QVELT |w| 0)
                                               (COND
                                                ((SPADCALL
                                                  (SPADCALL (QVELT |w| 1)
                                                            (QREFELT $ 95))
                                                  (|spadConstant| $ 9)
                                                  (QREFELT $ 20))
                                                 (SPADCALL (ELT $ 10)
                                                           (QVELT |w| 1)
                                                           (QREFELT $ 98)))
                                                ('T
                                                 (SEQ
                                                  (LETT |lc|
                                                        (SPADCALL
                                                         (SPADCALL
                                                          (QVELT |w| 1)
                                                          (QREFELT $ 95))
                                                         (QREFELT $ 10)))
                                                  (LETT |den1|
                                                        (SPADCALL |den1|
                                                                  (SPADCALL
                                                                   |lc|
                                                                   (QVELT |w|
                                                                          2)
                                                                   (QREFELT $
                                                                            125))
                                                                  (QREFELT $
                                                                           126)))
                                                  (EXIT
                                                   (SPADCALL
                                                    (CONS
                                                     #'|FRAC;factorPolynomial;SupF;40!1|
                                                     (VECTOR |lc| $))
                                                    (QVELT |w| 1)
                                                    (QREFELT $ 98))))))
                                               (QVELT |w| 2))
                                       #3#))))
                              (LETT #2# (CDR #2#)) (GO G190) G191
                              (EXIT (NREVERSE #3#)))))
                  (EXIT
                   (SPADCALL
                    (SPADCALL
                     (CONS #'|FRAC;factorPolynomial;SupF;40!2|
                           (VECTOR |den1| $))
                     (SPADCALL |ff| (QREFELT $ 127)) (QREFELT $ 98))
                    |lfact| (QREFELT $ 130))))))))) 

(SDEFUN |FRAC;factorPolynomial;SupF;40!2| ((|x| NIL) ($$ NIL))
        (PROG ($ |den1|)
          (LETT $ (QREFELT $$ 1))
          (LETT |den1| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| (QREFELT $ 10)) |den1| (QREFELT $ 126)))))) 

(SDEFUN |FRAC;factorPolynomial;SupF;40!1| ((|x| NIL) ($$ NIL))
        (PROG ($ |lc|)
          (LETT $ (QREFELT $$ 1))
          (LETT |lc| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| (QREFELT $ 10)) |lc| (QREFELT $ 126)))))) 

(SDEFUN |FRAC;factorPolynomial;SupF;40!0| ((|x| NIL) ($$ NIL))
        (PROG (|denpp| $)
          (LETT |denpp| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| |denpp| (QREFELT $ 87)) (QREFELT $ 26)))))) 

(SDEFUN |FRAC;factorSquareFreePolynomial;SupF;41|
        ((|pp| #1=(|SparseUnivariatePolynomial| $)) ($ (|Factored| #1#)))
        (SPROG
         ((|lfact|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| (|SparseUnivariatePolynomial| $))
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|den1| ($)) (|lc| ($)) (#2=#:G1573 NIL) (|w| NIL) (#3=#:G1572 NIL)
          (|ff| (|Factored| (|SparseUnivariatePolynomial| S)))
          (|ppD| (|SparseUnivariatePolynomial| S)) (|denpp| (S))
          (#4=#:G1552 NIL) (#5=#:G1551 (S)) (#6=#:G1553 (S)) (#7=#:G1571 NIL)
          (|u| NIL) (|lcpp| ($)))
         (SEQ
          (COND ((SPADCALL |pp| (QREFELT $ 80)) (|spadConstant| $ 117))
                ((EQL (SPADCALL |pp| (QREFELT $ 82)) 0)
                 (SPADCALL |pp| NIL (QREFELT $ 130)))
                (#8='T
                 (SEQ (LETT |lcpp| (SPADCALL |pp| (QREFELT $ 132)))
                      (LETT |pp| (SPADCALL |pp| |lcpp| (QREFELT $ 133)))
                      (LETT |denpp|
                            (PROGN
                             (LETT #4# NIL)
                             (SEQ (LETT |u| NIL)
                                  (LETT #7# (SPADCALL |pp| (QREFELT $ 85)))
                                  G190
                                  (COND
                                   ((OR (ATOM #7#)
                                        (PROGN (LETT |u| (CAR #7#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (PROGN
                                     (LETT #6# (SPADCALL |u| (QREFELT $ 75)))
                                     (COND
                                      (#4#
                                       (LETT #5#
                                             (SPADCALL #5# #6#
                                                       (QREFELT $ 86))))
                                      ('T
                                       (PROGN
                                        (LETT #5# #6#)
                                        (LETT #4# 'T)))))))
                                  (LETT #7# (CDR #7#)) (GO G190) G191
                                  (EXIT NIL))
                             (COND (#4# #5#) (#8# (|spadConstant| $ 9)))))
                      (LETT |ppD|
                            (SPADCALL
                             (CONS
                              #'|FRAC;factorSquareFreePolynomial;SupF;41!0|
                              (VECTOR $ |denpp|))
                             |pp| (QREFELT $ 91)))
                      (LETT |ff| (SPADCALL |ppD| (QREFELT $ 134)))
                      (LETT |den1|
                            (SPADCALL (SPADCALL |denpp| (QREFELT $ 10)) |lcpp|
                                      (QREFELT $ 126)))
                      (LETT |lfact|
                            (PROGN
                             (LETT #3# NIL)
                             (SEQ (LETT |w| NIL)
                                  (LETT #2# (SPADCALL |ff| (QREFELT $ 124)))
                                  G190
                                  (COND
                                   ((OR (ATOM #2#)
                                        (PROGN (LETT |w| (CAR #2#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #3#
                                          (CONS
                                           (VECTOR (QVELT |w| 0)
                                                   (COND
                                                    ((SPADCALL
                                                      (SPADCALL (QVELT |w| 1)
                                                                (QREFELT $ 95))
                                                      (|spadConstant| $ 9)
                                                      (QREFELT $ 20))
                                                     (SPADCALL (ELT $ 10)
                                                               (QVELT |w| 1)
                                                               (QREFELT $ 98)))
                                                    ('T
                                                     (SEQ
                                                      (LETT |lc|
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QVELT |w| 1)
                                                              (QREFELT $ 95))
                                                             (QREFELT $ 10)))
                                                      (LETT |den1|
                                                            (SPADCALL |den1|
                                                                      (SPADCALL
                                                                       |lc|
                                                                       (QVELT
                                                                        |w| 2)
                                                                       (QREFELT
                                                                        $ 125))
                                                                      (QREFELT
                                                                       $ 126)))
                                                      (EXIT
                                                       (SPADCALL
                                                        (CONS
                                                         #'|FRAC;factorSquareFreePolynomial;SupF;41!1|
                                                         (VECTOR |lc| $))
                                                        (QVELT |w| 1)
                                                        (QREFELT $ 98))))))
                                                   (QVELT |w| 2))
                                           #3#))))
                                  (LETT #2# (CDR #2#)) (GO G190) G191
                                  (EXIT (NREVERSE #3#)))))
                      (EXIT
                       (SPADCALL
                        (SPADCALL
                         (CONS #'|FRAC;factorSquareFreePolynomial;SupF;41!2|
                               (VECTOR |den1| $))
                         (SPADCALL |ff| (QREFELT $ 127)) (QREFELT $ 98))
                        |lfact| (QREFELT $ 130))))))))) 

(SDEFUN |FRAC;factorSquareFreePolynomial;SupF;41!2| ((|x| NIL) ($$ NIL))
        (PROG ($ |den1|)
          (LETT $ (QREFELT $$ 1))
          (LETT |den1| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| (QREFELT $ 10)) |den1| (QREFELT $ 126)))))) 

(SDEFUN |FRAC;factorSquareFreePolynomial;SupF;41!1| ((|x| NIL) ($$ NIL))
        (PROG ($ |lc|)
          (LETT $ (QREFELT $$ 1))
          (LETT |lc| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| (QREFELT $ 10)) |lc| (QREFELT $ 126)))))) 

(SDEFUN |FRAC;factorSquareFreePolynomial;SupF;41!0| ((|x| NIL) ($$ NIL))
        (PROG (|denpp| $)
          (LETT |denpp| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| |denpp| (QREFELT $ 87)) (QREFELT $ 26)))))) 

(DECLAIM (NOTINLINE |Fraction;|)) 

(DEFUN |Fraction| (#1=#:G1598)
  (SPROG NIL
         (PROG (#2=#:G1599)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Fraction|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Fraction;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Fraction|)))))))))) 

(DEFUN |Fraction;| (|#1|)
  (SPROG
   ((|pv$| NIL) (#1=#:G1593 NIL) (#2=#:G1594 NIL) (#3=#:G1595 NIL)
    (#4=#:G1597 NIL) (#5=#:G1596 NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|Fraction| DV$1))
    (LETT $ (GETREFV 167))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1|
                                                       '(|PolynomialFactorizationExplicit|))
                                        (|HasCategory| |#1|
                                                       '(|RetractableTo|
                                                         (|Symbol|)))
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicNonZero|))
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicZero|))
                                        (|HasCategory| |#1| '(|RealConstant|))
                                        (|HasCategory| |#1|
                                                       '(|OrderedIntegralDomain|))
                                        (|HasCategory| |#1| '(|OrderedSet|))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|OrderedIntegralDomain|))
                                         (|HasCategory| |#1| '(|OrderedSet|)))
                                        (|HasCategory| |#1| '(|StepThrough|))
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
                                                       '(|PartialDifferentialRing|
                                                         (|Symbol|)))
                                        (|HasCategory| |#1|
                                                       '(|DifferentialRing|))
                                        (|HasCategory| |#1|
                                                       '(|LinearlyExplicitOver|
                                                         (|Integer|)))
                                        (|HasCategory| |#1|
                                                       '(|ConvertibleTo|
                                                         (|Pattern|
                                                          (|Float|))))
                                        (|HasCategory| |#1|
                                                       '(|PatternMatchable|
                                                         (|Float|)))
                                        (AND
                                         (|HasCategory| |#1| '(|Canonical|))
                                         (|HasCategory| |#1| '(|GcdDomain|))
                                         (|HasCategory| |#1|
                                                        '(|canonicalUnitNormal|)))
                                        (|HasCategory| |#1|
                                                       '(|ConvertibleTo|
                                                         (|Pattern|
                                                          (|Integer|))))
                                        (|HasCategory| |#1|
                                                       '(|PatternMatchable|
                                                         (|Integer|)))
                                        (|HasCategory| |#1|
                                                       '(|EuclideanDomain|))
                                        (LETT #5#
                                              (|HasCategory| |#1|
                                                             '(|IntegerNumberSystem|)))
                                        (LETT #4#
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|IntegerNumberSystem|))
                                               (|HasCategory| |#1|
                                                              '(|OpenMath|))))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|ConvertibleTo|
                                                          (|Pattern|
                                                           (|Integer|))))
                                         #4#)
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|PatternMatchable|
                                                          (|Integer|)))
                                         #4#)
                                        (LETT #3#
                                              (|HasCategory| |#1|
                                                             '(|ConvertibleTo|
                                                               (|InputForm|))))
                                        (OR #3# #4#)
                                        (LETT #2#
                                              (|HasCategory| |#1|
                                                             '(|Comparable|)))
                                        (OR #2#
                                            (|HasCategory| |#1|
                                                           '(|OrderedIntegralDomain|))
                                            (|HasCategory| |#1|
                                                           '(|OrderedSet|)))
                                        (LETT #1#
                                              (|HasCategory| |#1|
                                                             '(|RetractableTo|
                                                               (|Integer|))))
                                        (OR #1# #4#)
                                        (|HasCategory| |#1|
                                                       '(|UniqueFactorizationDomain|))))))
    (|haddProp| |$ConstructorCache| '|Fraction| (LIST DV$1) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (AND (|HasCategory| |#1| '(|PolynomialFactorizationExplicit|))
         (|HasCategory| $ '(|CharacteristicNonZero|))
         (|augmentPredVector| $ 4294967296))
    (AND
     (OR (|HasCategory| |#1| '(|CharacteristicNonZero|))
         (AND (|HasCategory| |#1| '(|PolynomialFactorizationExplicit|))
              (|HasCategory| $ '(|CharacteristicNonZero|))))
     (|augmentPredVector| $ 8589934592))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 7 (|Record| (|:| |num| |#1|) (|:| |den| |#1|)))
    (COND
     ((|testBitVector| |pv$| 32)
      (QSETREFV $ 19
                (CONS (|dispatchFunction| |FRAC;factorFraction;$F;3|) $))))
    (COND
     ((|HasCategory| |#1| '(|GcdDomain|))
      (COND
       ((|HasCategory| |#1| '(|canonicalUnitNormal|))
        (PROGN
         (QSETREFV $ 21 (CONS (|dispatchFunction| |FRAC;=;2$B;4|) $))
         (QSETREFV $ 24
                   (CONS (|dispatchFunction| |FRAC;hashUpdate!;Hs$Hs;5|) $))
         (QSETREFV $ 25 (CONS (|dispatchFunction| |FRAC;one?;$B;6|) $))
         (QSETREFV $ 26 (CONS (|dispatchFunction| |FRAC;retract;$S;7|) $))
         (QSETREFV $ 28
                   (CONS (|dispatchFunction| |FRAC;retractIfCan;$U;8|) $))))
       ('T
        (PROGN
         (QSETREFV $ 26 (CONS (|dispatchFunction| |FRAC;retract;$S;9|) $))
         (QSETREFV $ 28
                   (CONS (|dispatchFunction| |FRAC;retractIfCan;$U;10|) $))))))
     ('T
      (PROGN
       (QSETREFV $ 26 (CONS (|dispatchFunction| |FRAC;retract;$S;11|) $))
       (QSETREFV $ 28
                 (CONS (|dispatchFunction| |FRAC;retractIfCan;$U;12|) $)))))
    (COND
     ((|testBitVector| |pv$| 21)
      (QSETREFV $ 32 (CONS (|dispatchFunction| |FRAC;wholePart;$S;13|) $))))
    (COND
     ((|testBitVector| |pv$| 22)
      (PROGN
       (QSETREFV $ 39 (CONS (|dispatchFunction| |FRAC;floor;$S;14|) $))
       (QSETREFV $ 37 (CONS (|dispatchFunction| |FRAC;ceiling;$S;15|) $))
       (COND
        ((|HasCategory| |#1| '(|OpenMath|))
         (PROGN
          (QSETREFV $ 50
                    (CONS (|dispatchFunction| |FRAC;OMwrite;Omd$BV;17|)
                          $))))))))
    (COND
     ((|HasCategory| |#1| '(|GcdDomain|))
      (PROGN
       (QSETREFV $ 54 (CONS (|dispatchFunction| |FRAC;recip;$U;19|) $))
       (QSETREFV $ 56 (CONS (|dispatchFunction| |FRAC;/;2S$;21|) $))
       (QSETREFV $ 57 (CONS (|dispatchFunction| |FRAC;+;3$;22|) $))
       (QSETREFV $ 59 (CONS (|dispatchFunction| |FRAC;-;3$;23|) $))
       (QSETREFV $ 60 (CONS (|dispatchFunction| |FRAC;*;3$;24|) $))
       (QSETREFV $ 63 (CONS (|dispatchFunction| |FRAC;*;I2$;25|) $))
       (QSETREFV $ 64 (CONS (|dispatchFunction| |FRAC;*;S2$;26|) $))
       (QSETREFV $ 66
                 (CONS (|dispatchFunction| |FRAC;differentiate;$M$;27|) $))))
     ('T
      (PROGN
       (QSETREFV $ 56 (CONS (|dispatchFunction| |FRAC;/;2S$;28|) $))
       (QSETREFV $ 54 (CONS (|dispatchFunction| |FRAC;recip;$U;29|) $)))))
    (COND
     ((|HasCategory| |#1| '(|RetractableTo| (|Fraction| (|Integer|))))
      (PROGN
       (QSETREFV $ 69 (CONS (|dispatchFunction| |FRAC;retract;$F;30|) $))
       (QSETREFV $ 72
                 (CONS (|dispatchFunction| |FRAC;retractIfCan;$U;31|) $))))
     ((|testBitVector| |pv$| 30)
      (PROGN
       (QSETREFV $ 69 (CONS (|dispatchFunction| |FRAC;retract;$F;32|) $))
       (QSETREFV $ 72
                 (CONS (|dispatchFunction| |FRAC;retractIfCan;$U;33|) $)))))
    (COND
     ((|HasCategory| |#1| '(|GcdDomain|))
      (QSETREFV $ 99
                (CONS (|dispatchFunction| |FRAC;gcdPolynomial;3Sup;34|) $))))
    (COND
     ((|testBitVector| |pv$| 1)
      (PROGN
       (COND
        ((|testBitVector| |pv$| 3)
         (PROGN
          (COND
           ((|HasCategory| |#1| '(|canonicalUnitNormal|))
            (COND
             ((|HasCategory| |#1| '(|GcdDomain|))
              (QSETREFV $ 101
                        (CONS (|dispatchFunction| |FRAC;charthRoot;$U;35|) $)))
             ('T
              (QSETREFV $ 101
                        (CONS (|dispatchFunction| |FRAC;charthRoot;$U;36|)
                              $)))))
           ('T
            (QSETREFV $ 101
                      (CONS (|dispatchFunction| |FRAC;charthRoot;$U;37|) $))))
          NIL
          NIL
          (QSETREFV $ 115
                    (CONS (|dispatchFunction| |FRAC;conditionP;MU;39|) $)))))
       (QSETREFV $ 131
                 (CONS (|dispatchFunction| |FRAC;factorPolynomial;SupF;40|) $))
       (QSETREFV $ 135
                 (CONS
                  (|dispatchFunction|
                   |FRAC;factorSquareFreePolynomial;SupF;41|)
                  $)))))
    $))) 

(MAKEPROP '|Fraction| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|LocalAlgebra| 6 6) (|local| |#1|) '|Rep|
              (0 . |One|) (4 . |One|) |FRAC;coerce;S$;1| (|Boolean|)
              (8 . |zero?|) |FRAC;zero?;$B;2| (|Factored| $) (13 . |factor|)
              (|Factored| 6) (|Fraction| 16) (18 . /) (24 . |factorFraction|)
              (29 . =) (35 . =) (|HashState|) (41 . |hashUpdate!|)
              (47 . |hashUpdate!|) (53 . |one?|) (58 . |retract|)
              (|Union| 6 '"failed") (63 . |retractIfCan|) (|Union| $ '"failed")
              (68 . |exquo|) (74 . |quo|) (80 . |wholePart|) (85 . |Zero|)
              (89 . |Zero|) (93 . <) (99 . -) (104 . |ceiling|) (109 . -)
              (114 . |floor|) (119 . +) (|Void|) (|OpenMathDevice|)
              (125 . |OMputApp|) (|String|) (130 . |OMputSymbol|)
              (137 . |OMwrite|) (144 . |OMputEndApp|) (149 . |OMputObject|)
              (154 . |OMputEndObject|) (159 . |OMwrite|)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (166 . |unitNormal|) (171 . *) (177 . |recip|) (182 . |gcd|)
              (188 . /) (194 . +) (200 . -) (206 . -) (212 . *) (|Integer|)
              (218 . |coerce|) (223 . *) (229 . *) (|Mapping| 6 6)
              (235 . |differentiate|) (|Fraction| 61) (241 . |retract|)
              (246 . |retract|) (|Union| 67 '#1="failed")
              (251 . |retractIfCan|) (256 . |retractIfCan|) (261 . |numer|)
              (266 . |retract|) (271 . |denom|) (276 . /) (|Union| 61 '#1#)
              (282 . |retractIfCan|) (|SparseUnivariatePolynomial| $$)
              (287 . |zero?|) (|NonNegativeInteger|) (292 . |degree|)
              (297 . |One|) (|List| $$) (301 . |coefficients|) (306 . |lcm|)
              (312 . *) (|SparseUnivariatePolynomial| 6) (|Mapping| 6 $$)
              (|UnivariatePolynomialCategoryFunctions2| $$ 79 6 88)
              (318 . |map|) (|SparseUnivariatePolynomial| $)
              (324 . |gcdPolynomial|) (330 . |degree|)
              (335 . |leadingCoefficient|) (|Mapping| $$ 6)
              (|UnivariatePolynomialCategoryFunctions2| 6 88 $$ 79)
              (340 . |map|) (346 . |gcdPolynomial|) (352 . |charthRoot|)
              (357 . |charthRoot|) (362 . |characteristic|) (366 . ^)
              (|List| 84) (|Matrix| $$) (372 . |listOfLists|) (|List| 141)
              (|Matrix| 6) (377 . |matrix|) (|Union| 146 '#2="failed")
              (|Matrix| $) (382 . |conditionP|) (|Vector| 6) (387 . |elt|)
              (393 . |conditionP|) (|Factored| 79) (398 . |Zero|)
              (|Factored| 92) (402 . |factorPolynomial|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 120) (|:| |factor| 88) (|:| |exponent| 81))
              (|List| 121) (|Factored| 88) (407 . |factorList|) (412 . ^)
              (418 . /) (424 . |unit|)
              (|Record| (|:| |flag| 120) (|:| |factor| 79) (|:| |exponent| 81))
              (|List| 128) (429 . |makeFR|) (435 . |factorPolynomial|)
              (440 . |leadingCoefficient|) (445 . /)
              (451 . |factorSquareFreePolynomial|)
              (456 . |factorSquareFreePolynomial|) (|InputForm|)
              (|Pattern| 152) (|Pattern| 61) (|List| 140) (|Equation| 6)
              (|List| 6) (|List| 143) (|Symbol|) (|Matrix| 61)
              (|Record| (|:| |mat| 144) (|:| |vec| (|Vector| 61))) (|Vector| $)
              (|List| 81) (|PatternMatchResult| 152 $)
              (|PatternMatchResult| 61 $) (|Union| 151 '#2#) (|List| 92)
              (|Float|) (|DoubleFloat|) (|Union| 143 '#1#)
              (|Record| (|:| |mat| 108) (|:| |vec| 113))
              (|Union| 157 '#3="failed") (|List| $)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $)) (|Union| 159 '#3#)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef| 157) (|:| |generator| $))
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|PositiveInteger|) (|SingleInteger|) (|OutputForm|))
           '#(~= 461 |zero?| 467 |wholePart| 472 |unitNormal| 477
              |unitCanonical| 482 |unit?| 487 |subtractIfCan| 492
              |squareFreePolynomial| 498 |squareFreePart| 503 |squareFree| 508
              |solveLinearPolynomialEquation| 513 |smaller?| 519 |sizeLess?|
              525 |sign| 531 |sample| 536 |rightRecip| 540 |rightPower| 545
              |retractIfCan| 557 |retract| 577 |rem| 597 |reducedSystem| 603
              |recip| 625 |quo| 630 |principalIdeal| 636 |prime?| 641
              |positive?| 646 |patternMatch| 651 |opposite?| 665 |one?| 671
              |numerator| 676 |numer| 681 |nextItem| 686 |negative?| 691
              |multiEuclidean| 696 |min| 702 |max| 708 |map| 714 |leftRecip|
              720 |leftPower| 725 |lcmCoef| 737 |lcm| 743 |latex| 754 |inv| 759
              |init| 764 |hashUpdate!| 768 |hash| 774 |gcdPolynomial| 779 |gcd|
              785 |fractionPart| 796 |floor| 801 |factorSquareFreePolynomial|
              806 |factorPolynomial| 811 |factorFraction| 816 |factor| 821
              |extendedEuclidean| 826 |exquo| 839 |expressIdealMember| 845
              |eval| 851 |euclideanSize| 891 |elt| 896 |divide| 902
              |differentiate| 908 |denominator| 958 |denom| 963 |convert| 968
              |conditionP| 993 |commutator| 998 |coerce| 1004 |charthRoot| 1034
              |characteristic| 1039 |ceiling| 1043 |associator| 1048
              |associates?| 1055 |antiCommutator| 1061 |annihilate?| 1067 |abs|
              1073 ^ 1078 |Zero| 1096 |One| 1100 |OMwrite| 1104 D 1128 >= 1178
              > 1184 = 1190 <= 1196 < 1202 / 1208 - 1220 + 1231 * 1237)
           'NIL
           (CONS
            (|makeByteWordVec2| 31
                                '(0 0 0 1 0 0 0 6 0 0 0 0 0 0 6 0 0 0 0 0 3 4
                                  13 14 15 0 0 0 0 0 0 0 0 0 0 0 6 0 0 0 0 0 0
                                  0 6 0 6 0 0 0 6 0 0 0 0 0 8 0 0 0 29 9 17 25
                                  0 0 0 0 2 5 31 31 11 0 0 0 0 0 0 0 0 0 2 27 5
                                  5 7 31 31 10 11 12 16 24 18 23))
            (CONS
             '#(|QuotientFieldCategory&| |Field&| |EuclideanDomain&|
                |PolynomialFactorizationExplicit&| NIL
                |UniqueFactorizationDomain&| |GcdDomain&| NIL NIL
                |FullyLinearlyExplicitOver&| |DifferentialExtension&|
                |DivisionRing&| NIL NIL |OrderedRing&| NIL |Algebra&|
                |Algebra&| |EntireRing&| |Algebra&| NIL NIL
                |PartialDifferentialRing&| |DifferentialRing&| NIL NIL |Rng&|
                NIL |Module&| |Module&| |Module&| NIL NIL NIL NIL
                |NonAssociativeRing&| NIL NIL NIL NIL NIL NIL
                |NonAssociativeRng&| NIL NIL |AbelianGroup&| NIL NIL NIL NIL
                NIL NIL NIL |MagmaWithUnit&| |NonAssociativeSemiRng&|
                |AbelianMonoid&| |OrderedSet&| |FullyEvalableOver&| |Magma&|
                |AbelianSemiGroup&| NIL NIL NIL NIL NIL |RetractableTo&| NIL
                |SetCategory&| |RetractableTo&| NIL |RetractableTo&|
                |RetractableTo&| |Evalable&| NIL NIL NIL NIL NIL NIL NIL
                |BasicType&| NIL NIL NIL NIL NIL |PartialOrder&| NIL NIL
                |InnerEvalable&| |InnerEvalable&| NIL NIL NIL NIL |OpenMath&|)
             (CONS
              '#((|QuotientFieldCategory| 6) (|Field|) (|EuclideanDomain|)
                 (|PolynomialFactorizationExplicit|) (|PrincipalIdealDomain|)
                 (|UniqueFactorizationDomain|) (|GcdDomain|)
                 (|OrderedIntegralDomain|) (|IntegralDomain|)
                 (|FullyLinearlyExplicitOver| 6) (|DifferentialExtension| 6)
                 (|DivisionRing|) (|CommutativeRing|) (|LeftOreRing|)
                 (|OrderedRing|) (|LinearlyExplicitOver| 6) (|Algebra| 6)
                 (|Algebra| 67) (|EntireRing|) (|Algebra| $$)
                 (|CharacteristicNonZero|) (|CharacteristicZero|)
                 (|PartialDifferentialRing| 143) (|DifferentialRing|)
                 (|LinearlyExplicitOver| 61) (|Ring|) (|Rng|) (|SemiRing|)
                 (|Module| 6) (|Module| 67) (|Module| $$) (|SemiRng|)
                 (|BiModule| 6 6) (|BiModule| 67 67) (|BiModule| $$ $$)
                 (|NonAssociativeRing|) (|OrderedAbelianGroup|)
                 (|RightModule| 6) (|LeftModule| 6) (|RightModule| 67)
                 (|LeftModule| 67) (|LeftModule| $$) (|NonAssociativeRng|)
                 (|RightModule| $$) (|OrderedCancellationAbelianMonoid|)
                 (|AbelianGroup|) (|OrderedAbelianMonoid|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|OrderedAbelianSemiGroup|) (|FullyPatternMatchable| 6)
                 (|SemiGroup|) (|MagmaWithUnit|) (|NonAssociativeSemiRng|)
                 (|AbelianMonoid|) (|OrderedSet|) (|FullyEvalableOver| 6)
                 (|Magma|) (|AbelianSemiGroup|) (|Comparable|) (|StepThrough|)
                 (|PatternMatchable| 152) (|PatternMatchable| 61)
                 (|Patternable| 6) (|RetractableTo| 6) (|CommutativeStar|)
                 (|SetCategory|) (|RetractableTo| 143) (|RealConstant|)
                 (|RetractableTo| 67) (|RetractableTo| 61) (|Evalable| 6)
                 (|Type|) (|CoercibleFrom| 6) (|canonicalsClosed|)
                 (|canonicalUnitNormal|) (|noZeroDivisors|) (|TwoSidedRecip|)
                 (|unitsKnown|) (|BasicType|) (|CoercibleTo| 166)
                 (|CoercibleFrom| 143) (|ConvertibleTo| 136)
                 (|ConvertibleTo| 153) (|ConvertibleTo| 152) (|PartialOrder|)
                 (|CoercibleFrom| 67) (|CoercibleFrom| 61)
                 (|InnerEvalable| 143 6) (|InnerEvalable| 6 6) (|Eltable| 6 $$)
                 (|ConvertibleTo| 137) (|ConvertibleTo| 138) (|Canonical|)
                 (|OpenMath|))
              (|makeByteWordVec2| 166
                                  '(0 0 0 8 0 6 0 9 1 6 11 0 12 1 6 14 0 15 2
                                    17 0 16 16 18 1 0 17 0 19 2 6 11 0 0 20 2 0
                                    11 0 0 21 2 6 22 22 0 23 2 0 22 22 0 24 1 0
                                    11 0 25 1 0 6 0 26 1 0 27 0 28 2 6 29 0 0
                                    30 2 6 0 0 0 31 1 0 6 0 32 0 0 0 33 0 6 0
                                    34 2 0 11 0 0 35 1 0 0 0 36 1 0 6 0 37 1 6
                                    0 0 38 1 0 6 0 39 2 6 0 0 0 40 1 42 41 0 43
                                    3 42 41 0 44 44 45 3 6 41 42 0 11 46 1 42
                                    41 0 47 1 42 41 0 48 1 42 41 0 49 3 0 41 42
                                    0 11 50 1 6 51 0 52 2 6 0 0 0 53 1 0 29 0
                                    54 2 6 0 0 0 55 2 0 0 6 6 56 2 0 0 0 0 57 2
                                    6 0 0 0 58 2 0 0 0 0 59 2 0 0 0 0 60 1 6 0
                                    61 62 2 0 0 61 0 63 2 0 0 6 0 64 2 0 0 0 65
                                    66 1 6 67 0 68 1 0 67 0 69 1 6 70 0 71 1 0
                                    70 0 72 1 0 6 0 73 1 6 61 0 74 1 0 6 0 75 2
                                    67 0 61 61 76 1 6 77 0 78 1 79 11 0 80 1 79
                                    81 0 82 0 79 0 83 1 79 84 0 85 2 6 0 0 0 86
                                    2 0 0 0 6 87 2 90 88 89 79 91 2 6 92 92 92
                                    93 1 88 81 0 94 1 88 6 0 95 2 97 79 96 88
                                    98 2 0 92 92 92 99 1 6 29 0 100 1 0 29 0
                                    101 0 0 81 102 2 6 0 0 81 103 1 105 104 0
                                    106 1 108 0 107 109 1 6 110 111 112 2 113 6
                                    0 61 114 1 0 110 111 115 0 116 0 117 1 6
                                    118 92 119 1 123 122 0 124 2 0 0 0 81 125 2
                                    0 0 0 0 126 1 123 88 0 127 2 116 0 79 129
                                    130 1 0 118 92 131 1 79 2 0 132 2 79 0 0 2
                                    133 1 6 118 92 134 1 0 118 92 135 2 0 11 0
                                    0 1 1 0 11 0 13 1 21 6 0 32 1 0 51 0 1 1 0
                                    0 0 1 1 0 11 0 1 2 0 29 0 0 1 1 1 118 92 1
                                    1 0 0 0 1 1 0 14 0 1 2 1 150 151 92 1 2 28
                                    11 0 0 1 2 0 11 0 0 1 1 6 61 0 1 0 0 0 1 1
                                    0 29 0 1 2 0 0 0 81 1 2 0 0 0 164 1 1 30 77
                                    0 1 1 30 70 0 72 1 2 154 0 1 1 0 27 0 28 1
                                    30 61 0 1 1 30 67 0 69 1 2 143 0 1 1 0 6 0
                                    26 2 0 0 0 0 1 1 15 144 111 1 2 15 145 111
                                    146 1 2 0 155 111 146 1 1 0 108 111 1 1 0
                                    29 0 54 2 0 0 0 0 1 1 0 162 157 1 1 0 11 0
                                    1 1 6 11 0 1 3 17 148 0 137 148 1 3 20 149
                                    0 138 149 1 2 0 11 0 0 1 1 0 11 0 25 1 0 0
                                    0 1 1 0 6 0 73 1 9 29 0 1 1 6 11 0 1 2 0
                                    156 157 0 1 2 7 0 0 0 1 2 7 0 0 0 1 2 0 0
                                    65 0 1 1 0 29 0 1 2 0 0 0 81 1 2 0 0 0 164
                                    1 2 0 163 0 0 1 1 0 0 157 1 2 0 0 0 0 1 1 0
                                    44 0 1 1 0 0 0 1 0 9 0 1 2 0 22 22 0 24 1 0
                                    165 0 1 2 0 92 92 92 99 2 0 0 0 0 1 1 0 0
                                    157 1 1 21 0 0 1 1 22 6 0 39 1 1 118 92 135
                                    1 1 118 92 131 1 32 17 0 19 1 0 14 0 1 2 0
                                    158 0 0 1 3 0 160 0 0 0 1 2 0 29 0 0 1 2 0
                                    156 157 0 1 2 11 0 0 139 1 3 11 0 0 6 6 1 2
                                    11 0 0 140 1 3 11 0 0 141 141 1 3 10 0 0
                                    142 141 1 3 10 0 0 143 6 1 1 0 81 0 1 2 12
                                    0 0 6 1 2 0 161 0 0 1 2 14 0 0 81 1 1 14 0
                                    0 1 3 13 0 0 142 147 1 3 13 0 0 143 81 1 2
                                    13 0 0 143 1 2 13 0 0 142 1 2 0 0 0 65 66 3
                                    0 0 0 65 81 1 1 0 0 0 1 1 0 6 0 75 1 26 136
                                    0 1 1 16 137 0 1 1 19 138 0 1 1 5 152 0 1 1
                                    5 153 0 1 1 33 110 111 115 2 0 0 0 0 1 1 2
                                    0 143 1 1 0 0 6 10 1 0 0 67 1 1 0 0 0 1 1 0
                                    0 61 1 1 0 166 0 1 1 34 29 0 101 0 0 81 102
                                    1 22 6 0 37 3 0 0 0 0 0 1 2 0 11 0 0 1 2 0
                                    0 0 0 1 2 0 11 0 0 1 1 6 0 0 1 2 0 0 0 61 1
                                    2 0 0 0 81 125 2 0 0 0 164 1 0 0 0 33 0 0 0
                                    8 1 23 44 0 1 2 23 41 42 0 1 2 23 44 0 11 1
                                    3 23 41 42 0 11 50 2 14 0 0 81 1 1 14 0 0 1
                                    3 13 0 0 142 147 1 2 13 0 0 142 1 3 13 0 0
                                    143 81 1 2 13 0 0 143 1 2 0 0 0 65 1 3 0 0
                                    0 65 81 1 2 7 11 0 0 1 2 7 11 0 0 1 2 0 11
                                    0 0 21 2 7 11 0 0 1 2 7 11 0 0 35 2 0 0 6 6
                                    56 2 0 0 0 0 126 1 0 0 0 36 2 0 0 0 0 59 2
                                    0 0 0 0 57 2 0 0 6 0 64 2 0 0 0 6 87 2 0 0
                                    0 67 1 2 0 0 67 0 1 2 0 0 81 0 1 2 0 0 61 0
                                    63 2 0 0 0 0 60 2 0 0 164 0 1)))))
           '|lookupComplete|)) 
