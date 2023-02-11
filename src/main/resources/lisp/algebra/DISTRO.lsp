
(PUT '|DISTRO;rep| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |DISTRO;rep| ((|x| ($)) ($ (|Rep|))) |x|) 

(PUT '|DISTRO;per| '|SPADreplace| '(XLAM (|r|) |r|)) 

(SDEFUN |DISTRO;per| ((|r| (|Rep|)) ($ ($))) |r|) 

(SDEFUN |DISTRO;Zero;$;3| (($ ($)))
        (SPADCALL
         (SPADCALL (SPADCALL (LIST (|spadConstant| $ 8)) (QREFELT $ 11))
                   (QREFELT $ 13))
         (QREFELT $ 14))) 

(SDEFUN |DISTRO;distributionByMoments;S$;4| ((|mm| (|Sequence| R)) ($ ($)))
        (|DISTRO;per|
         (VECTOR |mm| (SPADCALL |mm| (QREFELT $ 17))
                 (SPADCALL |mm| (QREFELT $ 18)) (SPADCALL |mm| (QREFELT $ 19)))
         $)) 

(SDEFUN |DISTRO;distributionByMoments;S$;5| ((|mm| (|Stream| R)) ($ ($)))
        (SPADCALL (SPADCALL |mm| (QREFELT $ 13)) (QREFELT $ 14))) 

(SDEFUN |DISTRO;interlace|
        ((|x| (|Stream| R)) (|y| (|Stream| R)) ($ (|Stream| R)))
        (SPROG NIL
               (SPADCALL (CONS #'|DISTRO;interlace!0| (VECTOR |y| $ |x|))
                         (QREFELT $ 25)))) 

(SDEFUN |DISTRO;interlace!0| (($$ NIL))
        (PROG (|x| $ |y|)
          (LETT |x| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |y| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| (QREFELT $ 21))
                      (SPADCALL (SPADCALL |y| (QREFELT $ 21))
                                (|DISTRO;interlace|
                                 (SPADCALL |x| (QREFELT $ 22))
                                 (SPADCALL |y| (QREFELT $ 22)) $)
                                (QREFELT $ 23))
                      (QREFELT $ 23)))))) 

(SDEFUN |DISTRO;distributionByEvenMoments;S$;7| ((|mm| (|Sequence| R)) ($ ($)))
        (SPADCALL
         (SPADCALL
          (|DISTRO;interlace|
           (SPADCALL (LIST (|spadConstant| $ 8)) (QREFELT $ 11))
           (SPADCALL |mm| (QREFELT $ 26)) $)
          (QREFELT $ 13))
         (QREFELT $ 14))) 

(SDEFUN |DISTRO;distributionByEvenMoments;S$;8| ((|mm| (|Stream| R)) ($ ($)))
        (SPADCALL (SPADCALL |mm| (QREFELT $ 13)) (QREFELT $ 27))) 

(SDEFUN |DISTRO;distributionByClassicalCumulants;S$;9|
        ((|cc| (|Sequence| R)) ($ ($)))
        (SPROG ((|mm| (|Sequence| R)))
               (SEQ (LETT |mm| (SPADCALL |cc| (QREFELT $ 29)))
                    (EXIT
                     (|DISTRO;per|
                      (VECTOR |mm| |cc| (SPADCALL |mm| (QREFELT $ 18))
                              (SPADCALL |mm| (QREFELT $ 19)))
                      $))))) 

(SDEFUN |DISTRO;distributionByClassicalCumulants;S$;10|
        ((|mm| (|Stream| R)) ($ ($)))
        (SPADCALL (SPADCALL |mm| (QREFELT $ 13)) (QREFELT $ 30))) 

(SDEFUN |DISTRO;distributionByFreeCumulants;S$;11|
        ((|fc| (|Sequence| R)) ($ ($)))
        (SPROG ((|mm| (|Sequence| R)))
               (SEQ (LETT |mm| (SPADCALL |fc| (QREFELT $ 32)))
                    (EXIT
                     (|DISTRO;per|
                      (VECTOR |mm| (SPADCALL |mm| (QREFELT $ 17)) |fc|
                              (SPADCALL |mm| (QREFELT $ 19)))
                      $))))) 

(SDEFUN |DISTRO;distributionByFreeCumulants;S$;12|
        ((|mm| (|Stream| R)) ($ ($)))
        (SPADCALL (SPADCALL |mm| (QREFELT $ 13)) (QREFELT $ 33))) 

(SDEFUN |DISTRO;distributionByBooleanCumulants;S$;13|
        ((|bc| (|Sequence| R)) ($ ($)))
        (SPROG ((|mm| (|Sequence| R)))
               (SEQ (LETT |mm| (SPADCALL |bc| (QREFELT $ 35)))
                    (EXIT
                     (|DISTRO;per|
                      (VECTOR |mm| (SPADCALL |mm| (QREFELT $ 17))
                              (SPADCALL |mm| (QREFELT $ 18)) |bc|)
                      $))))) 

(SDEFUN |DISTRO;distributionByBooleanCumulants;S$;14|
        ((|mm| (|Stream| R)) ($ ($)))
        (SPADCALL (SPADCALL |mm| (QREFELT $ 13)) (QREFELT $ 36))) 

(SDEFUN |DISTRO;booleanCumulantFromJacobi;I2SR;15|
        ((|n| (|Integer|)) (|aa| (|Sequence| R)) (|bb| (|Sequence| R)) ($ (R)))
        (COND ((ZEROP |n|) (|spadConstant| $ 38))
              ((EQL |n| 1) (SPADCALL |aa| 1 (QREFELT $ 40)))
              ('T
               (SPADCALL (SPADCALL |bb| 1 (QREFELT $ 40))
                         (SPADCALL (- |n| 2) (SPADCALL |aa| (QREFELT $ 41))
                                   (SPADCALL |bb| (QREFELT $ 41))
                                   (QREFELT $ 42))
                         (QREFELT $ 43))))) 

(SDEFUN |DISTRO;distributionByJacobiParameters;2S$;16|
        ((|aa| (|Sequence| R)) (|bb| (|Sequence| R)) ($ ($)))
        (SPROG ((|mom| (|Stream| R)) (|rior| (|Stream| (|List| R))))
               (SEQ
                (LETT |rior|
                      (SPADCALL (SPADCALL |aa| (QREFELT $ 26))
                                (SPADCALL |bb| (QREFELT $ 26)) (QREFELT $ 46)))
                (LETT |mom|
                      (SPADCALL (SPADCALL |rior| (QREFELT $ 47))
                                (QREFELT $ 22)))
                (EXIT
                 (SPADCALL (SPADCALL |mom| (QREFELT $ 13)) (QREFELT $ 14)))))) 

(SDEFUN |DISTRO;distributionByJacobiParameters;2S$;17|
        ((|aa| (|Stream| R)) (|bb| (|Stream| R)) ($ ($)))
        (SPADCALL (SPADCALL |aa| (QREFELT $ 13)) (SPADCALL |bb| (QREFELT $ 13))
                  (QREFELT $ 48))) 

(SDEFUN |DISTRO;construct;4S$;18|
        ((|mom| (|Sequence| R)) (|ccum| (|Sequence| R)) (|fcum| (|Sequence| R))
         (|bcum| (|Sequence| R)) ($ ($)))
        (|DISTRO;per| (VECTOR |mom| |ccum| |fcum| |bcum|) $)) 

(SDEFUN |DISTRO;monotoneCumulants;$S;19| ((|x| ($)) ($ (|Sequence| R)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 51)) (QREFELT $ 52))) 

(SDEFUN |DISTRO;distributionByMonotoneCumulants;S$;20|
        ((|mc| (|Sequence| R)) ($ ($)))
        (SPROG ((|mm| (|Sequence| R)))
               (SEQ (LETT |mm| (SPADCALL |mc| (QREFELT $ 54)))
                    (EXIT
                     (|DISTRO;per|
                      (VECTOR |mm| (SPADCALL |mm| (QREFELT $ 17))
                              (SPADCALL |mm| (QREFELT $ 18))
                              (SPADCALL |mm| (QREFELT $ 19)))
                      $))))) 

(SDEFUN |DISTRO;distributionByMonotoneCumulants;S$;21|
        ((|mm| (|Stream| R)) ($ ($)))
        (SPADCALL (SPADCALL |mm| (QREFELT $ 13)) (QREFELT $ 55))) 

(SDEFUN |DISTRO;distributionBySTransform;2FS$;22|
        ((|puiseux| (|Fraction| (|Integer|)))
         (|laurent| (|Fraction| (|Integer|))) (|coef| (|Sequence| R)) ($ ($)))
        (SPROG
         ((|psi| #1=(|Stream| R)) (|psi2| #1#) (|chi2| #2=(|Stream| R))
          (|z1z| #2#) (S2 (|Sequence| R)) (#3=#:G750 NIL) (|chi| (|Stream| R)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |puiseux| (|spadConstant| $ 58) (QREFELT $ 60))
             (SEQ
              (LETT |z1z|
                    (SPADCALL (|spadConstant| $ 8)
                              (SPADCALL
                               (LIST (|spadConstant| $ 38)
                                     (SPADCALL (|spadConstant| $ 38)
                                               (QREFELT $ 61)))
                               (QREFELT $ 11))
                              (QREFELT $ 23)))
              (LETT |chi|
                    (SPADCALL (SPADCALL |coef| (QREFELT $ 26)) |z1z|
                              (QREFELT $ 63)))
              (LETT |psi| (SPADCALL |chi| (QREFELT $ 64)))
              (EXIT
               (PROGN
                (LETT #3#
                      (SPADCALL
                       (SPADCALL (SPADCALL |psi| (QREFELT $ 22))
                                 (QREFELT $ 13))
                       (QREFELT $ 14)))
                (GO #4=#:G749)))))
            ((SPADCALL |puiseux| (SPADCALL 1 2 (QREFELT $ 65)) (QREFELT $ 60))
             (COND
              ((SPADCALL |laurent|
                         (SPADCALL (|spadConstant| $ 58) (QREFELT $ 66))
                         (QREFELT $ 60))
               (SEQ (LETT S2 |coef|)
                    (LETT |chi2|
                          (SPADCALL (|spadConstant| $ 8)
                                    (SPADCALL S2 (QREFELT $ 26))
                                    (QREFELT $ 23)))
                    (LETT |z1z|
                          (SPADCALL
                           (LIST (|spadConstant| $ 38) (|spadConstant| $ 8)
                                 (SPADCALL (|spadConstant| $ 38)
                                           (QREFELT $ 61))
                                 (|spadConstant| $ 8))
                           (QREFELT $ 11)))
                    (LETT |chi2| (SPADCALL |chi2| |z1z| (QREFELT $ 63)))
                    (LETT |psi2| (SPADCALL |chi2| (QREFELT $ 64)))
                    (LETT |psi|
                          (SPADCALL (SPADCALL 2 (QREFELT $ 67)) |psi2|
                                    (QREFELT $ 68)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (SPADCALL |psi| (QREFELT $ 22)) (QREFELT $ 13))
                      (QREFELT $ 14)))))
              (#5='T (|error| "Not an S-transform"))))
            (#5# (|error| "Not an S-transform"))))
          #4# (EXIT #3#)))) 

(SDEFUN |DISTRO;distributionBySTransform;R$;23|
        ((S
          (|Record| (|:| |puiseux| (|Fraction| (|Integer|)))
                    (|:| |laurent| (|Fraction| (|Integer|)))
                    (|:| |coef| (|Sequence| R))))
         ($ ($)))
        (SPADCALL (QVELT S 0) (QVELT S 1) (QVELT S 2) (QREFELT $ 69))) 

(SDEFUN |DISTRO;freeMultiplicativeConvolution;3$;24|
        ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG
         ((|Sxyc| (|Stream| R)) (#1=#:G765 NIL) (|Syc| #2=(|Stream| R))
          (|Sxc| #2#)
          (|Sy|
           #3=(|Record| (|:| |puiseux| (|Fraction| (|Integer|)))
                        (|:| |laurent| (|Fraction| (|Integer|)))
                        (|:| |coef| (|Sequence| R))))
          (|Sx| #3#))
         (SEQ
          (EXIT
           (SEQ
            (LETT |Sx| (SPADCALL (SPADCALL |x| (QREFELT $ 51)) (QREFELT $ 72)))
            (LETT |Sy| (SPADCALL (SPADCALL |y| (QREFELT $ 51)) (QREFELT $ 72)))
            (COND
             ((SPADCALL (QVELT |Sx| 0) (SPADCALL 1 2 (QREFELT $ 65))
                        (QREFELT $ 60))
              (COND
               ((SPADCALL (QVELT |Sy| 0) (SPADCALL 1 2 (QREFELT $ 65))
                          (QREFELT $ 60))
                (EXIT (|spadConstant| $ 15))))))
            (LETT |Sxc| (SPADCALL (QVELT |Sx| 2) (QREFELT $ 26)))
            (LETT |Syc| (SPADCALL (QVELT |Sy| 2) (QREFELT $ 26)))
            (COND
             ((SPADCALL (QVELT |Sx| 0) (|spadConstant| $ 58) (QREFELT $ 60))
              (COND
               ((SPADCALL (QVELT |Sy| 0) (|spadConstant| $ 58) (QREFELT $ 60))
                (SEQ (LETT |Sxyc| (SPADCALL |Sxc| |Syc| (QREFELT $ 63)))
                     (EXIT
                      (PROGN
                       (LETT #1#
                             (SPADCALL (|spadConstant| $ 58)
                                       (|spadConstant| $ 73)
                                       (SPADCALL |Sxyc| (QREFELT $ 13))
                                       (QREFELT $ 69)))
                       (GO #4=#:G764)))))
               ((SPADCALL (QVELT |Sx| 0) (SPADCALL 1 2 (QREFELT $ 65))
                          (QREFELT $ 60))
                (LETT |Sxyc|
                      (SPADCALL |Sxc| (SPADCALL 2 0 |Syc| (QREFELT $ 74))
                                (QREFELT $ 63))))
               (#5='T
                (LETT |Sxyc|
                      (SPADCALL (SPADCALL 2 0 |Sxc| (QREFELT $ 74)) |Syc|
                                (QREFELT $ 63))))))
             ((SPADCALL (QVELT |Sx| 0) (SPADCALL 1 2 (QREFELT $ 65))
                        (QREFELT $ 60))
              (LETT |Sxyc|
                    (SPADCALL |Sxc| (SPADCALL 2 0 |Syc| (QREFELT $ 74))
                              (QREFELT $ 63))))
             (#5#
              (LETT |Sxyc|
                    (SPADCALL (SPADCALL 2 0 |Sxc| (QREFELT $ 74)) |Syc|
                              (QREFELT $ 63)))))
            (EXIT
             (SPADCALL (SPADCALL 1 2 (QREFELT $ 65))
                       (SPADCALL (|spadConstant| $ 58) (QREFELT $ 66))
                       (SPADCALL |Sxyc| (QREFELT $ 13)) (QREFELT $ 69)))))
          #4# (EXIT #1#)))) 

(SDEFUN |DISTRO;coerce;$Of;25| ((|x| ($)) ($ (|OutputForm|)))
        (SPADCALL (QVELT (|DISTRO;rep| |x| $) 0) (QREFELT $ 77))) 

(SDEFUN |DISTRO;moment;$NniR;26|
        ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ (R)))
        (SPROG ((|mm| (|Sequence| R)))
               (SEQ
                (COND ((ZEROP |n|) (|spadConstant| $ 38))
                      ('T
                       (SEQ (LETT |mm| (QVELT (|DISTRO;rep| |x| $) 0))
                            (EXIT (SPADCALL |mm| |n| (QREFELT $ 40))))))))) 

(SDEFUN |DISTRO;classicalCumulant;$PiR;27|
        ((|x| ($)) (|n| (|PositiveInteger|)) ($ (R)))
        (SPROG ((|cc| (|Sequence| R)))
               (SEQ (LETT |cc| (QVELT (|DISTRO;rep| |x| $) 1))
                    (EXIT (SPADCALL |cc| |n| (QREFELT $ 40)))))) 

(SDEFUN |DISTRO;freeCumulant;$PiR;28|
        ((|x| ($)) (|n| (|PositiveInteger|)) ($ (R)))
        (SPROG ((|fc| (|Sequence| R)))
               (SEQ (LETT |fc| (QVELT (|DISTRO;rep| |x| $) 2))
                    (EXIT (SPADCALL |fc| |n| (QREFELT $ 40)))))) 

(SDEFUN |DISTRO;booleanCumulant;$PiR;29|
        ((|x| ($)) (|n| (|PositiveInteger|)) ($ (R)))
        (SPROG ((|fc| (|Sequence| R)))
               (SEQ (LETT |fc| (QVELT (|DISTRO;rep| |x| $) 3))
                    (EXIT (SPADCALL |fc| |n| (QREFELT $ 40)))))) 

(SDEFUN |DISTRO;moments;$S;30| ((|x| ($)) ($ (|Sequence| R)))
        (QVELT (|DISTRO;rep| |x| $) 0)) 

(SDEFUN |DISTRO;classicalCumulants;$S;31| ((|x| ($)) ($ (|Sequence| R)))
        (QVELT (|DISTRO;rep| |x| $) 1)) 

(SDEFUN |DISTRO;freeCumulants;$S;32| ((|x| ($)) ($ (|Sequence| R)))
        (QVELT (|DISTRO;rep| |x| $) 2)) 

(SDEFUN |DISTRO;booleanCumulants;$S;33| ((|x| ($)) ($ (|Sequence| R)))
        (QVELT (|DISTRO;rep| |x| $) 3)) 

(SDEFUN |DISTRO;hankelDeterminants1|
        ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ (|Stream| R)))
        (SPROG NIL
               (SPADCALL
                (CONS #'|DISTRO;hankelDeterminants1!0| (VECTOR |n| $ |x|))
                (QREFELT $ 25)))) 

(SDEFUN |DISTRO;hankelDeterminants1!0| (($$ NIL))
        (PROG (|x| $ |n|)
          (LETT |x| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |n| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL (SPADCALL |x| (QREFELT $ 51)) |n| (QREFELT $ 88))
             (|DISTRO;hankelDeterminants1| |x|
              (SPADCALL |n| (|spadConstant| $ 89) (QREFELT $ 90)) $)
             (QREFELT $ 23)))))) 

(SDEFUN |DISTRO;hankelDeterminants;$S;35| ((|x| ($)) ($ (|Stream| R)))
        (|DISTRO;hankelDeterminants1| |x| 1 $)) 

(SDEFUN |DISTRO;jacobiParameters;$R;36|
        ((|x| ($))
         ($ (|Record| (|:| |an| (|Stream| R)) (|:| |bn| (|Stream| R)))))
        (SPADCALL (SPADCALL |x| (QREFELT $ 51)) (QREFELT $ 93))) 

(SDEFUN |DISTRO;orthogonalPolynomials;$S;37|
        ((|x| ($)) ($ (|Stream| (|SparseUnivariatePolynomial| R))))
        (SPROG
         ((|jac| (|Record| (|:| |an| (|Stream| R)) (|:| |bn| (|Stream| R)))))
         (SEQ (LETT |jac| (SPADCALL |x| (QREFELT $ 94)))
              (EXIT (SPADCALL (QCAR |jac|) (QCDR |jac|) (QREFELT $ 96)))))) 

(SDEFUN |DISTRO;jacobiParameters;$R;38|
        ((|x| ($))
         ($
          (|Record| (|:| |an| (|Stream| (|Fraction| R)))
                    (|:| |bn| (|Stream| (|Fraction| R))))))
        (SPROG ((|mm| (|Stream| (|Fraction| R))) (|mm1| (|Stream| R)))
               (SEQ
                (LETT |mm1|
                      (SPADCALL (SPADCALL |x| (QREFELT $ 51)) (QREFELT $ 26)))
                (LETT |mm| (SPADCALL (ELT $ 99) |mm1| (QREFELT $ 103)))
                (EXIT
                 (SPADCALL (SPADCALL |mm| (QREFELT $ 105)) (QREFELT $ 108)))))) 

(SDEFUN |DISTRO;orthogonalPolynomials;$S;39|
        ((|x| ($))
         ($ (|Stream| (|SparseUnivariatePolynomial| (|Fraction| R)))))
        (SPROG
         ((|jac|
           (|Record| (|:| |an| (|Stream| (|Fraction| R)))
                     (|:| |bn| (|Stream| (|Fraction| R))))))
         (SEQ (LETT |jac| (SPADCALL |x| (QREFELT $ 109)))
              (EXIT (SPADCALL (QCAR |jac|) (QCDR |jac|) (QREFELT $ 111)))))) 

(SDEFUN |DISTRO;classicalConvolution;3$;40| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL
         (SPADCALL (SPADCALL |x| (QREFELT $ 85)) (SPADCALL |y| (QREFELT $ 85))
                   (QREFELT $ 113))
         (QREFELT $ 30))) 

(SDEFUN |DISTRO;freeConvolution;3$;41| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL
         (SPADCALL (SPADCALL |x| (QREFELT $ 86)) (SPADCALL |y| (QREFELT $ 86))
                   (QREFELT $ 113))
         (QREFELT $ 33))) 

(SDEFUN |DISTRO;booleanConvolution;3$;42| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL
         (SPADCALL (SPADCALL |x| (QREFELT $ 87)) (SPADCALL |y| (QREFELT $ 87))
                   (QREFELT $ 113))
         (QREFELT $ 36))) 

(SDEFUN |DISTRO;monotoneConvolution;3$;43| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPADCALL
         (SPADCALL
          (SPADCALL
           (SPADCALL
            (SPADCALL
             (SPADCALL (|spadConstant| $ 8)
                       (SPADCALL (|spadConstant| $ 38)
                                 (SPADCALL (SPADCALL |x| (QREFELT $ 51))
                                           (QREFELT $ 26))
                                 (QREFELT $ 23))
                       (QREFELT $ 23))
             (SPADCALL (|spadConstant| $ 8)
                       (SPADCALL (|spadConstant| $ 38)
                                 (SPADCALL (SPADCALL |y| (QREFELT $ 51))
                                           (QREFELT $ 26))
                                 (QREFELT $ 23))
                       (QREFELT $ 23))
             (QREFELT $ 117))
            (QREFELT $ 22))
           (QREFELT $ 22))
          (QREFELT $ 13))
         (QREFELT $ 14))) 

(SDEFUN |DISTRO;nth|
        ((|s| (|Stream| R)) (|n| (|PositiveInteger|)) ($ (|Stream| R)))
        (SPROG NIL
               (SEQ
                (SPADCALL (CONS #'|DISTRO;nth!0| (VECTOR $ |n| |s|))
                          (QREFELT $ 25))))) 

(SDEFUN |DISTRO;nth!0| (($$ NIL))
        (PROG (|s| |n| $)
          (LETT |s| (QREFELT $$ 2))
          (LETT |n| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|k| NIL) (#1=#:G819 NIL) (|res| NIL))
                   (SEQ (LETT |res| |s|)
                        (SEQ (LETT |k| 2) (LETT #1# |n|) G190
                             (COND ((|greater_SI| |k| #1#) (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT |res| (SPADCALL |res| (QREFELT $ 22)))))
                             (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                             (EXIT NIL))
                        (EXIT
                         (SPADCALL (SPADCALL |res| (QREFELT $ 21))
                                   (|DISTRO;nth|
                                    (SPADCALL |res| (QREFELT $ 22)) |n| $)
                                   (QREFELT $ 23))))))))) 

(SDEFUN |DISTRO;^;$Pi$;45| ((|x| ($)) (|n| (|PositiveInteger|)) ($ ($)))
        (SPROG ((|momn| (|Stream| R)))
               (SEQ
                (LETT |momn|
                      (|DISTRO;nth|
                       (SPADCALL (SPADCALL |x| (QREFELT $ 51)) (QREFELT $ 26))
                       |n| $))
                (EXIT
                 (SPADCALL (SPADCALL |momn| (QREFELT $ 13)) (QREFELT $ 14)))))) 

(SDEFUN |DISTRO;orthogonalConvolution;3$;46| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((|Bxy| (|Stream| R)) (|zMy| (|Stream| R)) (|Bx| (|Stream| R)))
               (SEQ
                (LETT |Bx|
                      (SPADCALL (SPADCALL |x| (QREFELT $ 87)) (QREFELT $ 26)))
                (LETT |zMy|
                      (SPADCALL (|spadConstant| $ 8)
                                (SPADCALL (|spadConstant| $ 38)
                                          (SPADCALL
                                           (SPADCALL |y| (QREFELT $ 51))
                                           (QREFELT $ 26))
                                          (QREFELT $ 23))
                                (QREFELT $ 23)))
                (LETT |Bxy| (SPADCALL |Bx| |zMy| (QREFELT $ 117)))
                (EXIT (SPADCALL |Bxy| (QREFELT $ 37)))))) 

(SDEFUN |DISTRO;subordinationConvolution;3$;47| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG ((|Rxy| (|Stream| R)) (|zMy| (|Stream| R)) (|Rx| (|Stream| R)))
               (SEQ
                (LETT |Rx|
                      (SPADCALL (SPADCALL |x| (QREFELT $ 86)) (QREFELT $ 26)))
                (LETT |zMy|
                      (SPADCALL (|spadConstant| $ 8)
                                (SPADCALL (|spadConstant| $ 38)
                                          (SPADCALL
                                           (SPADCALL |y| (QREFELT $ 51))
                                           (QREFELT $ 26))
                                          (QREFELT $ 23))
                                (QREFELT $ 23)))
                (LETT |Rxy| (SPADCALL |Rx| |zMy| (QREFELT $ 117)))
                (EXIT (SPADCALL |Rxy| (QREFELT $ 34)))))) 

(DECLAIM (NOTINLINE |Distribution;|)) 

(DEFUN |Distribution| (#1=#:G827)
  (SPROG NIL
         (PROG (#2=#:G828)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Distribution|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Distribution;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|Distribution|)))))))))) 

(DEFUN |Distribution;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|Distribution| DV$1))
          (LETT $ (GETREFV 125))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1| '(|Field|))
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|IntegralDomain|))
                                               (|not|
                                                (|HasCategory| |#1|
                                                               '(|Field|))))
                                              (|HasCategory| |#1|
                                                             '(|Algebra|
                                                               (|Fraction|
                                                                (|Integer|))))))))
          (|haddProp| |$ConstructorCache| '|Distribution| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record| (|:| |moments| (|Sequence| |#1|))
                              (|:| |ccumulants| (|Sequence| |#1|))
                              (|:| |fcumulants| (|Sequence| |#1|))
                              (|:| |bcumulants| (|Sequence| |#1|))))
          (COND
           ((|testBitVector| |pv$| 3)
            (PROGN
             (QSETREFV $ 53
                       (CONS
                        (|dispatchFunction| |DISTRO;monotoneCumulants;$S;19|)
                        $))
             (QSETREFV $ 55
                       (CONS
                        (|dispatchFunction|
                         |DISTRO;distributionByMonotoneCumulants;S$;20|)
                        $))
             (QSETREFV $ 56
                       (CONS
                        (|dispatchFunction|
                         |DISTRO;distributionByMonotoneCumulants;S$;21|)
                        $))
             (QSETREFV $ 69
                       (CONS
                        (|dispatchFunction|
                         |DISTRO;distributionBySTransform;2FS$;22|)
                        $))
             (QSETREFV $ 71
                       (CONS
                        (|dispatchFunction|
                         |DISTRO;distributionBySTransform;R$;23|)
                        $))
             (QSETREFV $ 75
                       (CONS
                        (|dispatchFunction|
                         |DISTRO;freeMultiplicativeConvolution;3$;24|)
                        $)))))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 94
                       (CONS
                        (|dispatchFunction| |DISTRO;jacobiParameters;$R;36|)
                        $))
             (QSETREFV $ 97
                       (CONS
                        (|dispatchFunction|
                         |DISTRO;orthogonalPolynomials;$S;37|)
                        $))))
           ((|HasCategory| |#1| '(|IntegralDomain|))
            (PROGN
             (QSETREFV $ 109
                       (CONS
                        (|dispatchFunction| |DISTRO;jacobiParameters;$R;38|)
                        $))
             (QSETREFV $ 112
                       (CONS
                        (|dispatchFunction|
                         |DISTRO;orthogonalPolynomials;$S;39|)
                        $)))))
          $))) 

(MAKEPROP '|Distribution| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (0 . |Zero|)
              (|List| 6) (|Stream| 6) (4 . |repeating|) (|Sequence| 6)
              (9 . |sequence|) |DISTRO;distributionByMoments;S$;4|
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |DISTRO;Zero;$;3|) $))
              (|MomentPackage| 6) (14 . |moment2cumulant|)
              (19 . |moment2freeCumulant|) (24 . |moment2booleanCumulant|)
              |DISTRO;distributionByMoments;S$;5| (29 . |first|) (34 . |rest|)
              (39 . |cons|) (|Mapping| $) (45 . |delay|) (50 . |stream|)
              |DISTRO;distributionByEvenMoments;S$;7|
              |DISTRO;distributionByEvenMoments;S$;8| (55 . |cumulant2moment|)
              |DISTRO;distributionByClassicalCumulants;S$;9|
              |DISTRO;distributionByClassicalCumulants;S$;10|
              (60 . |freeCumulant2moment|)
              |DISTRO;distributionByFreeCumulants;S$;11|
              |DISTRO;distributionByFreeCumulants;S$;12|
              (65 . |booleanCumulant2moment|)
              |DISTRO;distributionByBooleanCumulants;S$;13|
              |DISTRO;distributionByBooleanCumulants;S$;14| (70 . |One|)
              (|Integer|) (74 . |elt|) (80 . |rest|)
              |DISTRO;booleanCumulantFromJacobi;I2SR;15| (85 . *) (|Stream| 9)
              (|PathArrayPackage| 6) (91 . |jacobiPathArray|) (97 . |bottom|)
              |DISTRO;distributionByJacobiParameters;2S$;16|
              |DISTRO;distributionByJacobiParameters;2S$;17|
              |DISTRO;construct;4S$;18| |DISTRO;moments;$S;30|
              (102 . |moment2monotoneCumulant|) (107 . |monotoneCumulants|)
              (112 . |monotoneCumulant2moment|)
              (117 . |distributionByMonotoneCumulants|)
              (122 . |distributionByMonotoneCumulants|) (|Fraction| 39)
              (127 . |One|) (|Boolean|) (131 . =) (137 . -)
              (|StreamTaylorSeriesOperations| 6) (142 . *) (148 . |revert|)
              (153 . /) (159 . -) (164 . |coerce|) (169 . |powern|)
              (175 . |distributionBySTransform|)
              (|Record| (|:| |puiseux| 57) (|:| |laurent| 57) (|:| |coef| 12))
              (182 . |distributionBySTransform|) (187 . |moment2Stransform|)
              (192 . |Zero|) (196 . |invmultisect|)
              (203 . |freeMultiplicativeConvolution|) (|OutputForm|)
              (209 . |coerce|) |DISTRO;coerce;$Of;25| (|NonNegativeInteger|)
              |DISTRO;moment;$NniR;26| (|PositiveInteger|)
              |DISTRO;classicalCumulant;$PiR;27| |DISTRO;freeCumulant;$PiR;28|
              |DISTRO;booleanCumulant;$PiR;29|
              |DISTRO;classicalCumulants;$S;31| |DISTRO;freeCumulants;$S;32|
              |DISTRO;booleanCumulants;$S;33| (214 . |hankelDeterminant|)
              (220 . |One|) (224 . +) |DISTRO;hankelDeterminants;$S;35|
              (|Record| (|:| |an| 10) (|:| |bn| 10)) (230 . |moment2jacobi|)
              (235 . |jacobiParameters|)
              (|Stream| (|SparseUnivariatePolynomial| 6)) (240 . |jacobi2poly|)
              (246 . |orthogonalPolynomials|) (|Fraction| 6) (251 . |coerce|)
              (|Stream| 98) (|Mapping| 98 6) (|StreamFunctions2| 6 98)
              (256 . |map|) (|Sequence| 98) (262 . |sequence|)
              (|Record| (|:| |an| 100) (|:| |bn| 100)) (|MomentPackage| 98)
              (267 . |moment2jacobi|) (272 . |jacobiParameters|)
              (|Stream| (|SparseUnivariatePolynomial| 98))
              (277 . |jacobi2poly|) (283 . |orthogonalPolynomials|) (288 . +)
              |DISTRO;classicalConvolution;3$;40|
              |DISTRO;freeConvolution;3$;41| |DISTRO;booleanConvolution;3$;42|
              (294 . |compose|) |DISTRO;monotoneConvolution;3$;43|
              |DISTRO;^;$Pi$;45| |DISTRO;orthogonalConvolution;3$;46|
              |DISTRO;subordinationConvolution;3$;47| (|String|)
              (|SingleInteger|) (|HashState|))
           '#(~= 300 |subordinationConvolution| 306 |orthogonalPolynomials| 312
              |orthogonalConvolution| 322 |monotoneCumulants| 328
              |monotoneConvolution| 333 |moments| 339 |moment| 344 |latex| 350
              |jacobiParameters| 355 |hashUpdate!| 365 |hash| 371
              |hankelDeterminants| 376 |freeMultiplicativeConvolution| 381
              |freeCumulants| 387 |freeCumulant| 392 |freeConvolution| 398
              |distributionBySTransform| 404 |distributionByMonotoneCumulants|
              416 |distributionByMoments| 426 |distributionByJacobiParameters|
              436 |distributionByFreeCumulants| 448 |distributionByEvenMoments|
              458 |distributionByClassicalCumulants| 468
              |distributionByBooleanCumulants| 478 |construct| 488 |coerce| 496
              |classicalCumulants| 501 |classicalCumulant| 506
              |classicalConvolution| 512 |booleanCumulants| 518
              |booleanCumulantFromJacobi| 523 |booleanCumulant| 530
              |booleanConvolution| 536 ^ 542 |Zero| 548 = 552)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0))
                 (CONS '#(NIL |SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|DistributionCategory| 6) (|SetCategory|)
                           (|BasicType|) (|CoercibleTo| 76))
                        (|makeByteWordVec2| 124
                                            '(0 6 0 8 1 10 0 9 11 1 12 0 10 13
                                              1 16 12 12 17 1 16 12 12 18 1 16
                                              12 12 19 1 10 6 0 21 1 10 0 0 22
                                              2 10 0 6 0 23 1 10 0 24 25 1 12
                                              10 0 26 1 16 12 12 29 1 16 12 12
                                              32 1 16 12 12 35 0 6 0 38 2 12 6
                                              0 39 40 1 12 0 0 41 2 6 0 0 0 43
                                              2 45 44 10 10 46 1 45 10 44 47 1
                                              16 12 12 52 1 0 12 0 53 1 16 12
                                              12 54 1 0 0 12 55 1 0 0 10 56 0
                                              57 0 58 2 57 59 0 0 60 1 6 0 0 61
                                              2 62 10 10 10 63 1 62 10 10 64 2
                                              57 0 39 39 65 1 57 0 0 66 1 57 0
                                              39 67 2 62 10 57 10 68 3 0 0 57
                                              57 12 69 1 0 0 70 71 1 16 70 12
                                              72 0 57 0 73 3 62 10 39 39 10 74
                                              2 0 0 0 0 75 1 12 76 0 77 2 16 6
                                              12 79 88 0 79 0 89 2 79 0 0 0 90
                                              1 16 92 12 93 1 0 92 0 94 2 16 95
                                              10 10 96 1 0 95 0 97 1 98 0 6 99
                                              2 102 100 101 10 103 1 104 0 100
                                              105 1 107 106 104 108 1 0 106 0
                                              109 2 107 110 100 100 111 1 0 110
                                              0 112 2 12 0 0 0 113 2 62 10 10
                                              10 117 2 0 59 0 0 1 2 0 0 0 0 121
                                              1 2 110 0 112 1 1 95 0 97 2 0 0 0
                                              0 120 1 3 12 0 53 2 0 0 0 0 118 1
                                              0 12 0 51 2 0 6 0 79 80 1 0 122 0
                                              1 1 2 106 0 109 1 1 92 0 94 2 0
                                              124 124 0 1 1 0 123 0 1 1 0 10 0
                                              91 2 3 0 0 0 75 1 0 12 0 86 2 0 6
                                              0 81 83 2 0 0 0 0 115 3 3 0 57 57
                                              12 69 1 3 0 70 71 1 3 0 12 55 1 3
                                              0 10 56 1 0 0 10 20 1 0 0 12 14 2
                                              0 0 10 10 49 2 0 0 12 12 48 1 0 0
                                              10 34 1 0 0 12 33 1 0 0 12 27 1 0
                                              0 10 28 1 0 0 10 31 1 0 0 12 30 1
                                              0 0 12 36 1 0 0 10 37 4 0 0 12 12
                                              12 12 50 1 0 76 0 78 1 0 12 0 85
                                              2 0 6 0 81 82 2 0 0 0 0 114 1 0
                                              12 0 87 3 0 6 39 12 12 42 2 0 6 0
                                              81 84 2 0 0 0 0 116 2 0 0 0 81
                                              119 0 0 0 15 2 0 59 0 0 1)))))
           '|lookupComplete|)) 
