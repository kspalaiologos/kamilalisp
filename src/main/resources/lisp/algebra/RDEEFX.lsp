
(SDEFUN |RDEEFX;top_kernel|
        ((|f| (F)) (|g| (F)) (|x| (|Symbol|)) ($ (|Kernel| F)))
        (SPROG
         ((|extra_tk| (|Boolean|)) (|tk| (|Kernel| F))
          (|htk| #1=(|NonNegativeInteger|)) (|hk| #1#) (#2=#:G924 NIL)
          (|k| NIL) (|lk| (|List| (|Kernel| F))) (|lkf| (|List| (|Kernel| F))))
         (SEQ
          (LETT |lkf|
                (SPADCALL (SPADCALL |f| (QREFELT $ 11)) |x| (QREFELT $ 15)))
          (LETT |lk|
                (SPADCALL
                 (SPADCALL (SPADCALL |g| (QREFELT $ 11)) |x| (QREFELT $ 15))
                 |lkf| (QREFELT $ 16)))
          (LETT |tk| (|SPADfirst| |lk|))
          (LETT |htk| (SPADCALL |tk| (QREFELT $ 19)))
          (LETT |extra_tk| (NULL (SPADCALL |tk| |lkf| (QREFELT $ 21))))
          (SEQ (LETT |k| NIL) (LETT #2# (CDR |lk|)) G190
               (COND
                ((OR (ATOM #2#) (PROGN (LETT |k| (CAR #2#)) NIL)) (GO G191)))
               (SEQ (LETT |hk| (SPADCALL |k| (QREFELT $ 19)))
                    (EXIT
                     (COND
                      ((> |hk| |htk|)
                       (SEQ (LETT |tk| |k|) (LETT |htk| |hk|)
                            (EXIT
                             (LETT |extra_tk|
                                   (NULL
                                    (SPADCALL |tk| |lkf| (QREFELT $ 21)))))))
                      ((< |hk| |htk|) "iterate")
                      ('T
                       (SEQ
                        (COND
                         ((SPADCALL |tk| '|exp| (QREFELT $ 22))
                          (COND (|extra_tk| (EXIT "iterate")))))
                        (COND
                         ((SPADCALL |k| '|exp| (QREFELT $ 22))
                          (COND
                           ((NULL (SPADCALL |k| |lkf| (QREFELT $ 21)))
                            (EXIT
                             (SEQ (LETT |tk| |k|)
                                  (EXIT (LETT |extra_tk| 'T))))))))
                        (EXIT
                         (COND
                          ((SPADCALL |tk| '|exp| (QREFELT $ 22)) "iterate")
                          ((SPADCALL |k| '|exp| (QREFELT $ 22))
                           (SEQ (LETT |tk| |k|) (EXIT (LETT |extra_tk| NIL))))
                          ('T
                           (SEQ
                            (COND
                             ((SPADCALL |tk| '|log| (QREFELT $ 22))
                              (COND (|extra_tk| (EXIT "iterate")))))
                            (COND
                             ((SPADCALL |k| '|log| (QREFELT $ 22))
                              (COND
                               ((NULL (SPADCALL |k| |lkf| (QREFELT $ 21)))
                                (EXIT
                                 (SEQ (LETT |tk| |k|)
                                      (EXIT (LETT |extra_tk| 'T))))))))
                            (EXIT
                             (COND
                              ((SPADCALL |tk| '|log| (QREFELT $ 22)) "iterate")
                              ((SPADCALL |k| '|log| (QREFELT $ 22))
                               (SEQ (LETT |tk| |k|)
                                    (EXIT (LETT |extra_tk| NIL))))
                              ((SPADCALL (SPADCALL |tk| (QREFELT $ 24))
                                         (QREFELT $ 8) (QREFELT $ 25))
                               (COND
                                ((SPADCALL (SPADCALL |k| (QREFELT $ 24))
                                           (QREFELT $ 8) (QREFELT $ 25))
                                 (COND (|extra_tk| "iterate")
                                       ((NULL
                                         (SPADCALL |k| |lkf| (QREFELT $ 21)))
                                        (SEQ (LETT |tk| |k|)
                                             (EXIT (LETT |extra_tk| 'T))))))
                                ('T
                                 (SEQ (LETT |tk| |k|)
                                      (EXIT
                                       (LETT |extra_tk|
                                             (NULL
                                              (SPADCALL |k| |lkf|
                                                        (QREFELT $
                                                                 21))))))))))))))))))))
               (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
          (EXIT |tk|)))) 

(SDEFUN |RDEEFX;genus0_if_can|
        ((|k| (|Kernel| F)) (|kx| (|Kernel| F))
         ($
          (|Union|
           (|Record|
            (|:| |coef1| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |coef2| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |exponent| (|NonNegativeInteger|)))
           "failed")))
        (SPROG
         ((|c1| (|Fraction| (|SparseUnivariatePolynomial| F))) (|d| (F))
          (|c| (F)) (|b| (F)) (|a| (F))
          (|drf| (|SparseUnivariatePolynomial| F))
          (|nrf| (|SparseUnivariatePolynomial| F))
          (|r1rf| (|Fraction| (|SparseUnivariatePolynomial| F))) (|r1| (F))
          (|n| (|NonNegativeInteger|)) (#1=#:G939 NIL) (|args| (|List| F)))
         (SEQ
          (COND
           ((NULL (SPADCALL |k| '|nthRoot| (QREFELT $ 22))) (CONS 1 "failed"))
           ('T
            (SEQ (LETT |args| (SPADCALL |k| (QREFELT $ 27)))
                 (LETT |n|
                       (PROG1
                           (LETT #1#
                                 (SPADCALL (SPADCALL |args| 2 (QREFELT $ 29))
                                           (QREFELT $ 30)))
                         (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                           '(|Integer|) #1#)))
                 (LETT |r1| (SPADCALL |args| 1 (QREFELT $ 29)))
                 (LETT |r1rf| (SPADCALL |r1| |kx| (QREFELT $ 35)))
                 (LETT |nrf| (SPADCALL |r1rf| (QREFELT $ 38)))
                 (LETT |drf| (SPADCALL |r1rf| (QREFELT $ 39)))
                 (COND
                  ((OR (> (SPADCALL |nrf| (QREFELT $ 40)) 1)
                       (> (SPADCALL |drf| (QREFELT $ 40)) 1))
                   (EXIT (CONS 1 "failed"))))
                 (LETT |a| (SPADCALL |nrf| 1 (QREFELT $ 41)))
                 (LETT |b| (SPADCALL |nrf| 0 (QREFELT $ 41)))
                 (LETT |c| (SPADCALL |drf| 1 (QREFELT $ 41)))
                 (LETT |d| (SPADCALL |drf| 0 (QREFELT $ 41)))
                 (LETT |c1|
                       (SPADCALL
                        (SPADCALL
                         (SPADCALL (SPADCALL |d| |n| (QREFELT $ 44))
                                   (SPADCALL |b| (QREFELT $ 45))
                                   (QREFELT $ 46))
                         (QREFELT $ 47))
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL (SPADCALL |c| (QREFELT $ 48)) |n|
                                    (QREFELT $ 44))
                          (SPADCALL |a| (QREFELT $ 45)) (QREFELT $ 49))
                         (QREFELT $ 47))
                        (QREFELT $ 50)))
                 (EXIT (CONS 0 (VECTOR |c1| |r1rf| |n|))))))))) 

(SDEFUN |RDEEFX;ei_int_alg|
        ((|f| (F)) (|g| (F)) (|x| (|Symbol|)) (|k| (|Kernel| F))
         (|lk| (|List| (|Kernel| F)))
         ($
          (|Record| (|:| |ans| F) (|:| |right| F) (|:| |primpart| F)
                    (|:| |sol?| (|Boolean|)))))
        (SPROG
         ((|ansp| (F)) (|a1| (F)) (|r1| (F)) (|kf| (F))
          (|res1|
           (|Record| (|:| |ans| F) (|:| |right| F) (|:| |primpart| F)
                     (|:| |sol?| (|Boolean|))))
          (|nf| (F)) (|ng| (F)) (|dfx| (F)) (|fy| (F)) (|fx| (F))
          (|nxk| (|Kernel| F)) (|nx| (|Symbol|))
          (|cv|
           (|Record|
            (|:| |coef1| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |coef2| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |exponent| (|NonNegativeInteger|))))
          (|cvu|
           (|Union|
            (|Record|
             (|:| |coef1| (|Fraction| (|SparseUnivariatePolynomial| F)))
             (|:| |coef2| (|Fraction| (|SparseUnivariatePolynomial| F)))
             (|:| |exponent| (|NonNegativeInteger|)))
            "failed"))
          (|kx| (|Kernel| F)))
         (SEQ (LETT |kx| (SPADCALL |lk| (QREFELT $ 51)))
              (COND
               ((NULL (QEQCAR (SPADCALL |kx| (QREFELT $ 53)) 0))
                (EXIT (SPADCALL |f| |g| |x| (CONS |k| |lk|) (QREFELT $ 56)))))
              (LETT |cvu| (|RDEEFX;genus0_if_can| |k| |kx| $))
              (EXIT
               (COND
                ((QEQCAR |cvu| 1)
                 (SPADCALL |f| |g| |x| (CONS |k| |lk|) (QREFELT $ 56)))
                ('T
                 (SEQ (LETT |cv| (QCDR |cvu|))
                      (LETT |nx| (SPADCALL (QREFELT $ 57)))
                      (LETT |nxk| (SPADCALL |nx| (QREFELT $ 58)))
                      (LETT |fx|
                            (SPADCALL (QVELT |cv| 0) |nxk| (QREFELT $ 60)))
                      (LETT |fy| (SPADCALL |nxk| (QREFELT $ 61)))
                      (LETT |dfx| (SPADCALL |fx| |nx| (QREFELT $ 62)))
                      (LETT |ng|
                            (SPADCALL |dfx|
                                      (SPADCALL |g| (LIST |kx| |k|)
                                                (LIST |fx| |fy|)
                                                (QREFELT $ 64))
                                      (QREFELT $ 65)))
                      (LETT |nf|
                            (SPADCALL |f| (LIST |kx| |k|) (LIST |fx| |fy|)
                                      (QREFELT $ 64)))
                      (LETT |res1| (SPADCALL 1 |nf| |ng| |nx| (QREFELT $ 66)))
                      (LETT |kf| (SPADCALL |k| (QREFELT $ 61)))
                      (LETT |r1|
                            (SPADCALL
                             (SPADCALL (QVELT |res1| 1) |dfx| (QREFELT $ 67))
                             |nxk| |kf| (QREFELT $ 68)))
                      (LETT |a1|
                            (SPADCALL (QVELT |res1| 0) |nxk| |kf|
                                      (QREFELT $ 68)))
                      (LETT |ansp|
                            (SPADCALL (QVELT |res1| 2) |nxk| |kf|
                                      (QREFELT $ 68)))
                      (EXIT (VECTOR |a1| |r1| |ansp| (QVELT |res1| 3)))))))))) 

(SDEFUN |RDEEFX;UP_to_UPUP|
        ((|p| (|SparseUnivariatePolynomial| F))
         ($ (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F))))
        (SPADCALL (ELT $ 45) |p| (QREFELT $ 72))) 

(SDEFUN |RDEEFX;get_uv0|
        ((|tt| (F)) (|coeffs| (|List| (|Integer|))) (|vlst| (|List| F))
         (|ulst| (|List| F)) (|k| (|Kernel| F)) (|x| (|Symbol|))
         ($
          (|Record| (|:| |u_part| F) (|:| |v_part| F)
                    (|:| |exponent| (|Integer|)) (|:| |coeff| (|Integer|)))))
        (SPROG
         ((|kc| #1=(|Integer|)) (#2=#:G995 NIL) (|vi| NIL) (#3=#:G996 NIL)
          (|ki| NIL) (|kf| (F)) (|u| (F)) (#4=#:G993 NIL) (|ui| NIL)
          (#5=#:G994 NIL) (#6=#:G992 NIL) (|ku| #1#) (#7=#:G990 NIL)
          (#8=#:G991 NIL) (|v0| (F)) (#9=#:G988 NIL) (#10=#:G989 NIL)
          (#11=#:G987 NIL))
         (SEQ
          (LETT |v0|
                (SPADCALL |tt|
                          (SPADCALL (ELT $ 73)
                                    (PROGN
                                     (LETT #11# NIL)
                                     (SEQ (LETT |ki| NIL) (LETT #10# |coeffs|)
                                          (LETT |vi| NIL) (LETT #9# |vlst|)
                                          G190
                                          (COND
                                           ((OR (ATOM #9#)
                                                (PROGN
                                                 (LETT |vi| (CAR #9#))
                                                 NIL)
                                                (ATOM #10#)
                                                (PROGN
                                                 (LETT |ki| (CAR #10#))
                                                 NIL))
                                            (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (LETT #11#
                                                  (CONS
                                                   (SPADCALL
                                                    (SPADCALL |ki|
                                                              (QREFELT $ 74))
                                                    |vi| (QREFELT $ 65))
                                                   #11#))))
                                          (LETT #9#
                                                (PROG1 (CDR #9#)
                                                  (LETT #10# (CDR #10#))))
                                          (GO G190) G191
                                          (EXIT (NREVERSE #11#))))
                                    (|spadConstant| $ 43) (QREFELT $ 76))
                          (QREFELT $ 77)))
          (LETT |ku| 0) (LETT |u| (|spadConstant| $ 32))
          (COND
           ((SPADCALL |k| '|exp| (QREFELT $ 22))
            (SEQ (LETT |kf| (SPADCALL |k| (QREFELT $ 61)))
                 (EXIT
                  (SEQ (LETT |ki| NIL) (LETT #8# |coeffs|) (LETT |ui| NIL)
                       (LETT #7# |ulst|) G190
                       (COND
                        ((OR (ATOM #7#) (PROGN (LETT |ui| (CAR #7#)) NIL)
                             (ATOM #8#) (PROGN (LETT |ki| (CAR #8#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL |ui| |kf| (QREFELT $ 78))
                           (LETT |ku| |ki|))
                          ('T
                           (LETT |u|
                                 (SPADCALL |u|
                                           (SPADCALL |ui| |ki| (QREFELT $ 79))
                                           (QREFELT $ 65)))))))
                       (LETT #7# (PROG1 (CDR #7#) (LETT #8# (CDR #8#))))
                       (GO G190) G191 (EXIT NIL)))))
           ('T
            (LETT |u|
                  (SPADCALL (ELT $ 65)
                            (PROGN
                             (LETT #6# NIL)
                             (SEQ (LETT |ki| NIL) (LETT #5# |coeffs|)
                                  (LETT |ui| NIL) (LETT #4# |ulst|) G190
                                  (COND
                                   ((OR (ATOM #4#)
                                        (PROGN (LETT |ui| (CAR #4#)) NIL)
                                        (ATOM #5#)
                                        (PROGN (LETT |ki| (CAR #5#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #6#
                                          (CONS
                                           (SPADCALL |ui| |ki| (QREFELT $ 79))
                                           #6#))))
                                  (LETT #4#
                                        (PROG1 (CDR #4#) (LETT #5# (CDR #5#))))
                                  (GO G190) G191 (EXIT (NREVERSE #6#))))
                            (|spadConstant| $ 32) (QREFELT $ 76)))))
          (LETT |kc| 0)
          (COND
           ((SPADCALL |k| '|log| (QREFELT $ 22))
            (SEQ (LETT |kf| (SPADCALL |k| (QREFELT $ 61)))
                 (EXIT
                  (SEQ (LETT |ki| NIL) (LETT #3# |coeffs|) (LETT |vi| NIL)
                       (LETT #2# |vlst|) G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |vi| (CAR #2#)) NIL)
                             (ATOM #3#) (PROGN (LETT |ki| (CAR #3#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL |vi| |kf| (QREFELT $ 78))
                           (LETT |kc| |ki|)))))
                       (LETT #2# (PROG1 (CDR #2#) (LETT #3# (CDR #3#))))
                       (GO G190) G191 (EXIT NIL))))))
          (EXIT (VECTOR |u| |v0| |ku| |kc|))))) 

(SDEFUN |RDEEFX;get_uv|
        ((|tt| (F)) (|vlst| (|List| F)) (|ulst| (|List| F)) (|k| (|Kernel| F))
         (|x| (|Symbol|))
         ($
          (|Union|
           (|Record| (|:| |u_part| F) (|:| |v_part| F)
                     (|:| |exponent| (|Integer|)) (|:| |coeff| (|Integer|)))
           "failed")))
        (SPROG
         ((|d| #1=(|Integer|))
          (|cd| (|Record| (|:| |num| (|List| (|Integer|))) (|:| |den| #1#)))
          (|sv| (|Vector| (|Fraction| (|Integer|))))
          (|su| (|Union| (|Vector| (|Fraction| (|Integer|))) "failed"))
          (|dvvec| (|Vector| F)) (#2=#:G1012 NIL) (|vi| NIL) (#3=#:G1011 NIL))
         (SEQ
          (LETT |dvvec|
                (SPADCALL
                 (PROGN
                  (LETT #3# NIL)
                  (SEQ (LETT |vi| NIL) (LETT #2# |vlst|) G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |vi| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #3#
                               (CONS (SPADCALL |vi| |x| (QREFELT $ 62)) #3#))))
                       (LETT #2# (CDR #2#)) (GO G190) G191
                       (EXIT (NREVERSE #3#))))
                 (QREFELT $ 81)))
          (LETT |su|
                (SPADCALL |dvvec| (SPADCALL |tt| |x| (QREFELT $ 62))
                          (QREFELT $ 84)))
          (EXIT
           (COND ((QEQCAR |su| 1) (CONS 1 "failed"))
                 (#4='T
                  (SEQ (LETT |sv| (QCDR |su|))
                       (LETT |cd| (SPADCALL |sv| (QREFELT $ 88)))
                       (LETT |d| (QCDR |cd|))
                       (EXIT
                        (COND
                         ((SPADCALL |d| 1 (QREFELT $ 89)) (CONS 1 "failed"))
                         (#4#
                          (CONS 0
                                (|RDEEFX;get_uv0| |tt| (QCAR |cd|) |vlst|
                                 |ulst| |k| |x| $)))))))))))) 

(SDEFUN |RDEEFX;handle_factor|
        ((|gd| (|SparseUnivariatePolynomial| F))
         (|nf| (|SparseUnivariatePolynomial| F))
         (|denf| (|SparseUnivariatePolynomial| F))
         (|f1| (|SparseUnivariatePolynomial| F)) (|r0| (|Integer|)) (|u0| (F))
         (|vlst| (|List| F)) (|ulst| (|List| F)) (|k| (|Kernel| F))
         (|x| (|Symbol|)) (|known_dividing| (|Boolean|))
         ($
          (|Union|
           (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F))
           "failed")))
        (SPROG
         ((|ff1| #1=(|SparseUnivariatePolynomial| F)) (#2=#:G1033 NIL)
          (|ff3| (|SparseUnivariatePolynomial| F)) (#3=#:G1022 NIL) (|ff2| #1#)
          (|ff| #4=(|SparseUnivariatePolynomial| F))
          (|f2pp| #5=(|SparseUnivariatePolynomial| F)) (|tt1| #4#) (|u| (F))
          (|tt| (F)) (|v0| (F)) (|u_exp| (|Integer|))
          (|uv|
           (|Record| (|:| |u_part| F) (|:| |v_part| F)
                     (|:| |exponent| (|Integer|)) (|:| |coeff| (|Integer|))))
          (|uvu|
           (|Union|
            (|Record| (|:| |u_part| F) (|:| |v_part| F)
                      (|:| |exponent| (|Integer|)) (|:| |coeff| (|Integer|)))
            "failed"))
          (|f2| #5#) (|deg1| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |deg1| (SPADCALL |f1| (QREFELT $ 40)))
                (LETT |tt|
                      (SPADCALL
                       (SPADCALL (SPADCALL |f1| (- |deg1| 1) (QREFELT $ 41))
                                 (SPADCALL (SPADCALL |deg1| (QREFELT $ 74))
                                           (SPADCALL |f1| |deg1|
                                                     (QREFELT $ 41))
                                           (QREFELT $ 65))
                                 (QREFELT $ 67))
                       (QREFELT $ 48)))
                (LETT |f2|
                      (SPADCALL |f1| (QREFELT $ 92)
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 32) 1
                                           (QREFELT $ 44))
                                 (SPADCALL |tt| (QREFELT $ 45)) (QREFELT $ 49))
                                (QREFELT $ 93)))
                (COND
                 ((NULL
                   (SPADCALL (CONS #'|RDEEFX;handle_factor!0| (VECTOR $ |x|))
                             (SPADCALL |f2| (QREFELT $ 94)) (QREFELT $ 96)))
                  (EXIT (PROGN (LETT #2# (CONS 1 "failed")) (GO #6=#:G1032)))))
                (LETT |uvu| (|RDEEFX;get_uv| |tt| |vlst| |ulst| |k| |x| $))
                (EXIT
                 (COND
                  ((QEQCAR |uvu| 1)
                   (PROGN (LETT #2# (CONS 1 "failed")) (GO #6#)))
                  (#7='T
                   (SEQ (LETT |uv| (QCDR |uvu|)) (LETT |u| (QVELT |uv| 0))
                        (LETT |u_exp| (QVELT |uv| 2))
                        (LETT |v0| (QVELT |uv| 1))
                        (COND
                         ((EQL |r0| 0)
                          (SEQ (LETT |r0| (QVELT |uv| 3))
                               (EXIT
                                (LETT |tt|
                                      (SPADCALL |tt|
                                                (SPADCALL
                                                 (SPADCALL |r0| (QREFELT $ 74))
                                                 (SPADCALL |k| (QREFELT $ 61))
                                                 (QREFELT $ 65))
                                                (QREFELT $ 77))))))
                         (#7#
                          (LETT |u|
                                (SPADCALL (SPADCALL |u0| |r0| (QREFELT $ 79))
                                          |u| (QREFELT $ 65)))))
                        (LETT |tt1|
                              (SPADCALL
                               (SPADCALL (SPADCALL |r0| (QREFELT $ 74)) 1
                                         (QREFELT $ 44))
                               (SPADCALL |tt| (QREFELT $ 45)) (QREFELT $ 49)))
                        (LETT |ff|
                              (SPADCALL |nf|
                                        (SPADCALL |tt1| |denf| (QREFELT $ 97))
                                        (QREFELT $ 49)))
                        (COND
                         ((> |deg1| 1)
                          (LETT |ff|
                                (SPADCALL
                                 (SPADCALL (SPADCALL |denf| 1 (QREFELT $ 98))
                                           (SPADCALL |ff| (QREFELT $ 99))
                                           (QREFELT $ 100))
                                 (|RDEEFX;UP_to_UPUP| |f2| $)
                                 (QREFELT $ 101)))))
                        (LETT |f2pp|
                              (COND ((EQL |deg1| 1) (|spadConstant| $ 102))
                                    (#7# |f2|)))
                        (EXIT
                         (COND
                          (|known_dividing|
                           (SEQ
                            (LETT |ff|
                                  (SPADCALL |ff|
                                            (SPADCALL |ff| (QREFELT $ 103))
                                            (QREFELT $ 104)))
                            (EXIT
                             (CONS 0
                                   (VECTOR |ff| |r0| |tt| |f2pp| |u| |u_exp|
                                           |v0|)))))
                          (#7#
                           (SEQ
                            (LETT |ff2|
                                  (LETT |ff1|
                                        (SPADCALL |ff| |gd| (QREFELT $ 105))))
                            (LETT |ff3|
                                  (PROG2
                                      (LETT #3#
                                            (SPADCALL |ff| |ff1|
                                                      (QREFELT $ 107)))
                                      (QCDR #3#)
                                    (|check_union2| (QEQCAR #3# 0)
                                                    (|SparseUnivariatePolynomial|
                                                     (QREFELT $ 7))
                                                    (|Union|
                                                     (|SparseUnivariatePolynomial|
                                                      (QREFELT $ 7))
                                                     #8="failed")
                                                    #3#)))
                            (SEQ G190
                                 (COND
                                  ((NULL
                                    (SPADCALL
                                     (LETT |ff2|
                                           (SPADCALL |ff2| |ff3|
                                                     (QREFELT $ 105)))
                                     (|spadConstant| $ 108) (QREFELT $ 109)))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |ff3|
                                         (PROG2
                                             (LETT #3#
                                                   (SPADCALL |ff3| |ff2|
                                                             (QREFELT $ 107)))
                                             (QCDR #3#)
                                           (|check_union2| (QEQCAR #3# 0)
                                                           (|SparseUnivariatePolynomial|
                                                            (QREFELT $ 7))
                                                           (|Union|
                                                            (|SparseUnivariatePolynomial|
                                                             (QREFELT $ 7))
                                                            #8#)
                                                           #3#)))))
                                 NIL (GO G190) G191 (EXIT NIL))
                            (COND
                             ((NULL (EQL (SPADCALL |ff3| (QREFELT $ 40)) 0))
                              (COND
                               ((SPADCALL |k| '|exp| (QREFELT $ 22))
                                (COND
                                 ((NULL
                                   (SPADCALL (SPADCALL |ff3| (QREFELT $ 110))
                                             (|spadConstant| $ 102)
                                             (QREFELT $ 111)))
                                  (EXIT
                                   (PROGN
                                    (LETT #2# (CONS 1 #9="failed"))
                                    (GO #6#))))))
                               (#7#
                                (EXIT
                                 (PROGN (LETT #2# (CONS 1 #9#)) (GO #6#)))))))
                            (LETT |ff1|
                                  (SPADCALL |ff1|
                                            (SPADCALL |ff1| (QREFELT $ 103))
                                            (QREFELT $ 104)))
                            (EXIT
                             (CONS 0
                                   (VECTOR |ff1| |r0| |tt| |f2pp| |u| |u_exp|
                                           |v0|)))))))))))))
          #6# (EXIT #2#)))) 

(SDEFUN |RDEEFX;handle_factor!0| ((|c| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |c| |x| (QREFELT $ 62)) (|spadConstant| $ 43)
                      (QREFELT $ 78)))))) 

(SDEFUN |RDEEFX;z_basis|
        ((|a| (|Vector| (|Fraction| (|Integer|))))
         (|b| (|List| (|Vector| (|Fraction| (|Integer|)))))
         ($
          (|Union|
           (|Record| (|:| |particular| (|Vector| (|Integer|)))
                     (|:| |basis| (|List| (|Vector| (|Integer|)))))
           "failed")))
        (SPROG
         ((#1=#:G1042 NIL) (#2=#:G1062 NIL) (|i| NIL)
          (|av| #3=(|Vector| (|Integer|))) (|ki| (|Integer|))
          (|di| (|Integer|)) (|g| #4=(|Integer|)) (|c2| #5=(|Integer|))
          (|c1| #6=(|Integer|))
          (|#G54|
           (|Record| (|:| |coef1| #6#) (|:| |coef2| #5#)
                     (|:| |generator| #4#)))
          (|ki1| (|Integer|)) (|di2| (|Integer|)) (|di1| (|Integer|))
          (#7=#:G1059 NIL) (|bi| #8=(|Integer|)) (|ai| #8#) (#9=#:G1061 NIL)
          (#10=#:G1060 NIL) (|n| (|NonNegativeInteger|)) (|bv| #3#)
          (|gb| (|Integer|)) (|bl| #11=(|List| (|Integer|)))
          (|db| #12=(|Integer|))
          (|cd| (|Record| (|:| |num| #11#) (|:| |den| #12#)))
          (|bvp| (|Vector| (|Fraction| (|Integer|)))) (|da| #12#)
          (|nn| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |nn| (LENGTH |b|))
                (EXIT
                 (COND ((> |nn| 1) (|error| "#b > 1"))
                       (#13='T
                        (SEQ (LETT |cd| (SPADCALL |a| (QREFELT $ 88)))
                             (LETT |da| (QCDR |cd|))
                             (LETT |av| (SPADCALL (QCAR |cd|) (QREFELT $ 114)))
                             (EXIT
                              (COND
                               ((EQL |nn| 0)
                                (COND
                                 ((SPADCALL |da| 1 (QREFELT $ 89))
                                  (CONS 1 "failed"))
                                 (#13# (CONS 0 (CONS |av| NIL)))))
                               (#13#
                                (SEQ (LETT |bvp| (|SPADfirst| |b|))
                                     (LETT |cd|
                                           (SPADCALL |bvp| (QREFELT $ 88)))
                                     (LETT |db| (QCDR |cd|))
                                     (LETT |bl| (QCAR |cd|))
                                     (LETT |gb|
                                           (SPADCALL |bl| (QREFELT $ 115)))
                                     (LETT |bv|
                                           (SPADCALL |bl| (QREFELT $ 114)))
                                     (LETT |n| (QVSIZE |bv|))
                                     (SEQ (LETT |i| 1) (LETT #10# |n|) G190
                                          (COND
                                           ((|greater_SI| |i| #10#) (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (SPADCALL |bv| |i|
                                                      (PROG2
                                                          (LETT #1#
                                                                (SPADCALL
                                                                 (SPADCALL |bv|
                                                                           |i|
                                                                           (QREFELT
                                                                            $
                                                                            116))
                                                                 |gb|
                                                                 (QREFELT $
                                                                          117)))
                                                          (QCDR #1#)
                                                        (|check_union2|
                                                         (QEQCAR #1# 0)
                                                         (|Integer|)
                                                         (|Union| (|Integer|)
                                                                  #14="failed")
                                                         #1#))
                                                      (QREFELT $ 118))))
                                          (LETT |i| (|inc_SI| |i|)) (GO G190)
                                          G191 (EXIT NIL))
                                     (EXIT
                                      (COND
                                       ((EQL |da| 1)
                                        (CONS 0 (CONS |av| (LIST |bv|))))
                                       ((QEQCAR
                                         (SPADCALL |db| |da| (QREFELT $ 117))
                                         1)
                                        (CONS 1 "failed"))
                                       (#13#
                                        (SEQ (LETT |ki| 0) (LETT |di| 1)
                                             (SEQ (LETT |i| 1) (LETT #9# |n|)
                                                  G190
                                                  (COND
                                                   ((|greater_SI| |i| #9#)
                                                    (GO G191)))
                                                  (SEQ
                                                   (LETT |ai|
                                                         (SPADCALL |av| |i|
                                                                   (QREFELT $
                                                                            116)))
                                                   (LETT |bi|
                                                         (SPADCALL |bv| |i|
                                                                   (QREFELT $
                                                                            116)))
                                                   (EXIT
                                                    (COND
                                                     ((SPADCALL
                                                       (REM
                                                        (- |ai| (* |ki| |bi|))
                                                        |di|)
                                                       0 (QREFELT $ 89))
                                                      (PROGN
                                                       (LETT #7#
                                                             (CONS 1 "failed"))
                                                       (GO #15=#:G1058)))
                                                     ('T
                                                      (SEQ
                                                       (LETT |di1|
                                                             (PROG2
                                                                 (LETT #1#
                                                                       (SPADCALL
                                                                        |da|
                                                                        (GCD
                                                                         |bi|
                                                                         |da|)
                                                                        (QREFELT
                                                                         $
                                                                         117)))
                                                                 (QCDR #1#)
                                                               (|check_union2|
                                                                (QEQCAR #1# 0)
                                                                (|Integer|)
                                                                (|Union|
                                                                 (|Integer|)
                                                                 #14#)
                                                                #1#)))
                                                       (LETT |di2|
                                                             (PROG2
                                                                 (LETT #1#
                                                                       (SPADCALL
                                                                        |di1|
                                                                        (GCD
                                                                         |di1|
                                                                         |di|)
                                                                        (QREFELT
                                                                         $
                                                                         117)))
                                                                 (QCDR #1#)
                                                               (|check_union2|
                                                                (QEQCAR #1# 0)
                                                                (|Integer|)
                                                                (|Union|
                                                                 (|Integer|)
                                                                 #14#)
                                                                #1#)))
                                                       (EXIT
                                                        (COND
                                                         ((EQL |di2| 1)
                                                          "iterate")
                                                         ('T
                                                          (SEQ
                                                           (LETT |ki1|
                                                                 (SPADCALL |bi|
                                                                           |di2|
                                                                           (QREFELT
                                                                            $
                                                                            119)))
                                                           (PROGN
                                                            (LETT |#G54|
                                                                  (SPADCALL
                                                                   |di| |di2|
                                                                   (QREFELT $
                                                                            121)))
                                                            (LETT |c1|
                                                                  (QVELT |#G54|
                                                                         0))
                                                            (LETT |c2|
                                                                  (QVELT |#G54|
                                                                         1))
                                                            (LETT |g|
                                                                  (QVELT |#G54|
                                                                         2))
                                                            |#G54|)
                                                           (LETT |di|
                                                                 (* |di2|
                                                                    |di|))
                                                           (EXIT
                                                            (LETT |ki|
                                                                  (REM
                                                                   (+
                                                                    (* |ki1|
                                                                       |c1|)
                                                                    (* |ki|
                                                                       |c2|))
                                                                   |di|))))))))))))
                                                  (LETT |i| (|inc_SI| |i|))
                                                  (GO G190) G191 (EXIT NIL))
                                             (LETT |av|
                                                   (SPADCALL |av|
                                                             (SPADCALL |ki|
                                                                       |bv|
                                                                       (QREFELT
                                                                        $ 122))
                                                             (QREFELT $ 123)))
                                             (SEQ (LETT |i| 1) (LETT #2# |n|)
                                                  G190
                                                  (COND
                                                   ((|greater_SI| |i| #2#)
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (SPADCALL |av| |i|
                                                              (PROG2
                                                                  (LETT #1#
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          |av|
                                                                          |i|
                                                                          (QREFELT
                                                                           $
                                                                           116))
                                                                         |da|
                                                                         (QREFELT
                                                                          $
                                                                          117)))
                                                                  (QCDR #1#)
                                                                (|check_union2|
                                                                 (QEQCAR #1# 0)
                                                                 (|Integer|)
                                                                 (|Union|
                                                                  (|Integer|)
                                                                  #14#)
                                                                 #1#))
                                                              (QREFELT $
                                                                       118))))
                                                  (LETT |i| (|inc_SI| |i|))
                                                  (GO G190) G191 (EXIT NIL))
                                             (EXIT
                                              (CONS 0
                                                    (CONS |av|
                                                          (LIST
                                                           |bv|))))))))))))))))))
          #15# (EXIT #7#)))) 

(SDEFUN |RDEEFX;lin_args|
        ((|gd| (|SparseUnivariatePolynomial| F))
         (|nf| (|SparseUnivariatePolynomial| F)) (|k| (|Kernel| F))
         (|vlst| (|List| F)) (|ulst| (|List| F)) (|x| (|Symbol|))
         ($
          (|List|
           (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F) (|:| |has_part2?| (|Boolean|))
                     (|:| |ratpart2| (|Integer|)) (|:| |v_part2| F)
                     (|:| |u_part2| F) (|:| |shift_part2| F)))))
        (SPROG
         ((|res|
           (|List|
            (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                      (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                      (|:| |u_part| F) (|:| |exponent| (|Integer|))
                      (|:| |shift_part| F) (|:| |has_part2?| (|Boolean|))
                      (|:| |ratpart2| (|Integer|)) (|:| |v_part2| F)
                      (|:| |u_part2| F) (|:| |shift_part2| F))))
          (|v2| (F)) (|u2| (F))
          (|uv2|
           #1=(|Record| (|:| |u_part| F) (|:| |v_part| F)
                        (|:| |exponent| (|Integer|))
                        (|:| |coeff| (|Integer|))))
          (|r2| (|Integer|)) (|bv| (|Vector| (|Integer|))) (|v1| (F))
          (|u1| (F)) (|uv1| #1#) (|tt1| (F)) (|a1n| (F)) (|r0| (|Integer|))
          (|vec1| (|Vector| (|Integer|)))
          (|zb|
           (|Record| (|:| |particular| (|Vector| (|Integer|)))
                     (|:| |basis| (|List| (|Vector| (|Integer|))))))
          (|zbu|
           (|Union|
            (|Record| (|:| |particular| (|Vector| (|Integer|)))
                      (|:| |basis| (|List| (|Vector| (|Integer|)))))
            "failed"))
          (|psol| (|Vector| (|Fraction| (|Integer|))))
          (|psolu| #2=(|Union| (|Vector| (|Fraction| (|Integer|))) "failed"))
          (|sol_rec|
           (|Record| (|:| |particular| #2#)
                     (|:| |basis|
                          (|List| (|Vector| (|Fraction| (|Integer|)))))))
          (|vecf| (|Vector| F)) (|dv0| (F)) (|dvs| (|List| F)) (#3=#:G1110 NIL)
          (|v| NIL) (#4=#:G1109 NIL) (|dv1| (F)) (#5=#:G1105 NIL)
          (|no_sol| #6=(|Boolean|)) (|f2| (|SparseUnivariatePolynomial| F))
          (|r0u| (|Union| (|Integer|) "failed")) (|r0f| (F)) (|b0p| (F))
          (|b0| (F)) (|has_r0| #6#) (|a1p| (F)) (|tt| (F))
          (|f1| (|SparseUnivariatePolynomial| F))
          (|deg1| (|NonNegativeInteger|)) (#7=#:G1108 NIL) (|fac| NIL)
          (|ulst1| (|List| F)) (|vlst1| (|List| F)) (|u0| (F)) (#8=#:G1106 NIL)
          (#9=#:G1107 NIL) (|u| NIL) (|v0| (F)) (|a0| (F)) (|a1| (F))
          (|fgd| (|Factored| (|SparseUnivariatePolynomial| F))))
         (SEQ (LETT |fgd| (SPADCALL |gd| (QREFELT $ 126)))
              (EXIT
               (COND
                ((> (SPADCALL |nf| (QREFELT $ 40)) 1)
                 (|error| "lin_args only works for linear nf"))
                (#10='T
                 (SEQ
                  (LETT |a1|
                        (COND
                         ((EQL (SPADCALL |nf| (QREFELT $ 40)) 1)
                          (SPADCALL |nf| (QREFELT $ 103)))
                         (#10# (|spadConstant| $ 43))))
                  (LETT |a0| (SPADCALL |nf| 0 (QREFELT $ 41)))
                  (LETT |v0| (SPADCALL |k| (QREFELT $ 61))) (LETT |vlst1| NIL)
                  (LETT |ulst1| NIL)
                  (SEQ (LETT |u| NIL) (LETT #9# |ulst|) (LETT |v| NIL)
                       (LETT #8# |vlst|) G190
                       (COND
                        ((OR (ATOM #8#) (PROGN (LETT |v| (CAR #8#)) NIL)
                             (ATOM #9#) (PROGN (LETT |u| (CAR #9#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL |v| |v0| (QREFELT $ 78)) (LETT |u0| |u|))
                          ('T
                           (SEQ (LETT |vlst1| (CONS |v| |vlst1|))
                                (EXIT (LETT |ulst1| (CONS |u| |ulst1|))))))))
                       (LETT #8# (PROG1 (CDR #8#) (LETT #9# (CDR #9#))))
                       (GO G190) G191 (EXIT NIL))
                  (LETT |res| NIL)
                  (SEQ (LETT |fac| NIL)
                       (LETT #7# (SPADCALL |fgd| (QREFELT $ 130))) G190
                       (COND
                        ((OR (ATOM #7#) (PROGN (LETT |fac| (CAR #7#)) NIL))
                         (GO G191)))
                       (SEQ (LETT |f1| (QVELT |fac| 1))
                            (LETT |deg1| (SPADCALL |f1| (QREFELT $ 40)))
                            (EXIT
                             (COND ((EQL |deg1| 0) "iterate")
                                   ('T
                                    (SEQ
                                     (LETT |f1|
                                           (SPADCALL |f1|
                                                     (SPADCALL |f1|
                                                               (QREFELT $ 103))
                                                     (QREFELT $ 104)))
                                     (LETT |tt|
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL |f1| (- |deg1| 1)
                                                       (QREFELT $ 41))
                                             (SPADCALL |deg1| (QREFELT $ 74))
                                             (QREFELT $ 67))
                                            (QREFELT $ 48)))
                                     (LETT |no_sol| NIL) (LETT |has_r0| NIL)
                                     (LETT |f2| (|spadConstant| $ 102))
                                     (LETT |r0| 0)
                                     (LETT |r0f| (|spadConstant| $ 43))
                                     (COND
                                      ((> |deg1| 1)
                                       (SEQ
                                        (EXIT
                                         (SEQ
                                          (LETT |f2|
                                                (SPADCALL |f1| (QREFELT $ 92)
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (|spadConstant| $
                                                                            32)
                                                            1 (QREFELT $ 44))
                                                           (SPADCALL |tt|
                                                                     (QREFELT $
                                                                              45))
                                                           (QREFELT $ 49))
                                                          (QREFELT $ 93)))
                                          (LETT |f2|
                                                (SPADCALL |f2|
                                                          (SPADCALL |f2|
                                                                    (QREFELT $
                                                                             103))
                                                          (QREFELT $ 104)))
                                          (COND
                                           ((SPADCALL
                                             (LETT |a1p|
                                                   (SPADCALL |a1| |x|
                                                             (QREFELT $ 62)))
                                             (|spadConstant| $ 43)
                                             (QREFELT $ 131))
                                            (SEQ (LETT |has_r0| 'T)
                                                 (LETT |b0|
                                                       (SPADCALL |f2| 0
                                                                 (QREFELT $
                                                                          41)))
                                                 (LETT |b0p|
                                                       (SPADCALL |b0| |x|
                                                                 (QREFELT $
                                                                          62)))
                                                 (EXIT
                                                  (COND
                                                   ((SPADCALL |b0p|
                                                              (|spadConstant| $
                                                                              43)
                                                              (QREFELT $ 78))
                                                    (LETT |no_sol| 'T))
                                                   ('T
                                                    (SEQ
                                                     (LETT |r0f|
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (SPADCALL
                                                                (SPADCALL
                                                                 |deg1|
                                                                 (QREFELT $
                                                                          74))
                                                                |a1p|
                                                                (QREFELT $ 65))
                                                               |b0|
                                                               (QREFELT $ 65))
                                                              |b0p|
                                                              (QREFELT $ 67))
                                                             (QREFELT $ 48))
                                                            |a1|
                                                            (QREFELT $ 77)))
                                                     (LETT |r0u|
                                                           (SPADCALL |r0f|
                                                                     (QREFELT $
                                                                              133)))
                                                     (EXIT
                                                      (COND
                                                       ((QEQCAR |r0u| 1)
                                                        (LETT |no_sol| 'T))
                                                       ('T
                                                        (SEQ
                                                         (LETT |r0|
                                                               (QCDR |r0u|))
                                                         (EXIT
                                                          (LETT |f2|
                                                                (SPADCALL
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   |a1| |r0f|
                                                                   (QREFELT $
                                                                            73))
                                                                  |deg1|
                                                                  (QREFELT $
                                                                           79))
                                                                 (SPADCALL |f2|
                                                                           (QREFELT
                                                                            $
                                                                            92)
                                                                           (SPADCALL
                                                                            (SPADCALL
                                                                             (|spadConstant|
                                                                              $
                                                                              32)
                                                                             (SPADCALL
                                                                              |a1|
                                                                              |r0f|
                                                                              (QREFELT
                                                                               $
                                                                               73))
                                                                             (QREFELT
                                                                              $
                                                                              67))
                                                                            1
                                                                            (QREFELT
                                                                             $
                                                                             44))
                                                                           (QREFELT
                                                                            $
                                                                            93))
                                                                 (QREFELT $
                                                                          136)))))))))))))))
                                          (EXIT
                                           (COND
                                            ((NULL
                                              (SPADCALL
                                               (CONS #'|RDEEFX;lin_args!0|
                                                     (VECTOR $ |x|))
                                               (SPADCALL |f2| (QREFELT $ 94))
                                               (QREFELT $ 96)))
                                             (PROGN
                                              (LETT #5# (LETT |no_sol| 'T))
                                              (GO #11=#:G1087)))))))
                                        #11# (EXIT #5#))))
                                     (EXIT
                                      (COND (|no_sol| "iterate")
                                            ('T
                                             (SEQ
                                              (LETT |dv0|
                                                    (SPADCALL
                                                     (SPADCALL
                                                      (SPADCALL
                                                       (SPADCALL |a1| |tt|
                                                                 (QREFELT $
                                                                          65))
                                                       |a0| (QREFELT $ 73))
                                                      |x| (QREFELT $ 62))
                                                     (QREFELT $ 48)))
                                              (LETT |dv1|
                                                    (SPADCALL |tt| |x|
                                                              (QREFELT $ 62)))
                                              (LETT |dvs|
                                                    (PROGN
                                                     (LETT #4# NIL)
                                                     (SEQ (LETT |v| NIL)
                                                          (LETT #3# |vlst1|)
                                                          G190
                                                          (COND
                                                           ((OR (ATOM #3#)
                                                                (PROGN
                                                                 (LETT |v|
                                                                       (CAR
                                                                        #3#))
                                                                 NIL))
                                                            (GO G191)))
                                                          (SEQ
                                                           (EXIT
                                                            (LETT #4#
                                                                  (CONS
                                                                   (SPADCALL
                                                                    |v| |x|
                                                                    (QREFELT $
                                                                             62))
                                                                   #4#))))
                                                          (LETT #3# (CDR #3#))
                                                          (GO G190) G191
                                                          (EXIT
                                                           (NREVERSE #4#)))))
                                              (LETT |vecf|
                                                    (COND
                                                     (|has_r0|
                                                      (SEQ
                                                       (LETT |dv0|
                                                             (SPADCALL |dv0|
                                                                       (SPADCALL
                                                                        |r0f|
                                                                        |dv1|
                                                                        (QREFELT
                                                                         $ 65))
                                                                       (QREFELT
                                                                        $ 73)))
                                                       (EXIT
                                                        (SPADCALL |dvs|
                                                                  (QREFELT $
                                                                           81)))))
                                                     ('T
                                                      (SPADCALL
                                                       (CONS |dv1| |dvs|)
                                                       (QREFELT $ 81)))))
                                              (LETT |sol_rec|
                                                    (SPADCALL |vecf| |dv0|
                                                              (QREFELT $ 138)))
                                              (LETT |psolu| (QCAR |sol_rec|))
                                              (EXIT
                                               (COND
                                                ((QEQCAR |psolu| 1) "iterate")
                                                ('T
                                                 (SEQ
                                                  (LETT |psol| (QCDR |psolu|))
                                                  (COND
                                                   (|has_r0|
                                                    (LETT |psol|
                                                          (SPADCALL
                                                           (CONS
                                                            (SPADCALL |r0|
                                                                      (QREFELT
                                                                       $ 140))
                                                            (SPADCALL |psol|
                                                                      (QREFELT
                                                                       $ 142)))
                                                           (QREFELT $ 143)))))
                                                  (LETT |zbu|
                                                        (|RDEEFX;z_basis|
                                                         |psol|
                                                         (QCDR |sol_rec|) $))
                                                  (EXIT
                                                   (COND
                                                    ((QEQCAR |zbu| 1)
                                                     "iterate")
                                                    ('T
                                                     (SEQ
                                                      (LETT |zb| (QCDR |zbu|))
                                                      (LETT |vec1| (QCAR |zb|))
                                                      (LETT |r0|
                                                            (SPADCALL |vec1| 1
                                                                      (QREFELT
                                                                       $ 116)))
                                                      (LETT |a1n|
                                                            (SPADCALL |a1|
                                                                      (SPADCALL
                                                                       |r0|
                                                                       (QREFELT
                                                                        $ 74))
                                                                      (QREFELT
                                                                       $ 73)))
                                                      (LETT |tt1|
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (SPADCALL |a1n|
                                                                        |tt|
                                                                        (QREFELT
                                                                         $ 65))
                                                              (QREFELT $ 48))
                                                             |a0|
                                                             (QREFELT $ 77)))
                                                      (LETT |uv1|
                                                            (|RDEEFX;get_uv0|
                                                             |tt1|
                                                             (CDR
                                                              (SPADCALL |vec1|
                                                                        (QREFELT
                                                                         $
                                                                         144)))
                                                             |vlst1| |ulst1|
                                                             |k| |x| $))
                                                      (LETT |u1|
                                                            (SPADCALL
                                                             (QVELT |uv1| 0)
                                                             (SPADCALL |u0|
                                                                       |r0|
                                                                       (QREFELT
                                                                        $ 79))
                                                             (QREFELT $ 65)))
                                                      (LETT |v1|
                                                            (QVELT |uv1| 1))
                                                      (EXIT
                                                       (COND
                                                        ((NULL (QCDR |zb|))
                                                         (LETT |res|
                                                               (CONS
                                                                (VECTOR |f1|
                                                                        |r0|
                                                                        |tt1|
                                                                        |f2|
                                                                        |u1| 0
                                                                        |v1|
                                                                        NIL 0
                                                                        (|spadConstant|
                                                                         $ 43)
                                                                        (|spadConstant|
                                                                         $ 32)
                                                                        (|spadConstant|
                                                                         $ 43))
                                                                |res|)))
                                                        ('T
                                                         (SEQ
                                                          (LETT |bv|
                                                                (|SPADfirst|
                                                                 (QCDR |zb|)))
                                                          (LETT |r2|
                                                                (SPADCALL |bv|
                                                                          1
                                                                          (QREFELT
                                                                           $
                                                                           116)))
                                                          (LETT |uv2|
                                                                (|RDEEFX;get_uv0|
                                                                 (SPADCALL |tt|
                                                                           (QREFELT
                                                                            $
                                                                            48))
                                                                 (CDR
                                                                  (SPADCALL
                                                                   |bv|
                                                                   (QREFELT $
                                                                            144)))
                                                                 |vlst1|
                                                                 |ulst1| |k|
                                                                 |x| $))
                                                          (LETT |u2|
                                                                (SPADCALL
                                                                 (QVELT |uv2|
                                                                        0)
                                                                 (SPADCALL |u0|
                                                                           |r2|
                                                                           (QREFELT
                                                                            $
                                                                            79))
                                                                 (QREFELT $
                                                                          65)))
                                                          (LETT |v2|
                                                                (QVELT |uv2|
                                                                       1))
                                                          (EXIT
                                                           (LETT |res|
                                                                 (CONS
                                                                  (VECTOR |f1|
                                                                          |r0|
                                                                          |tt1|
                                                                          |f2|
                                                                          |u1|
                                                                          0
                                                                          |v1|
                                                                          'T
                                                                          |r2|
                                                                          (SPADCALL
                                                                           |tt|
                                                                           (QREFELT
                                                                            $
                                                                            48))
                                                                          |u2|
                                                                          |v2|)
                                                                  |res|))))))))))))))))))))))))
                       (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
                  (EXIT |res|)))))))) 

(SDEFUN |RDEEFX;lin_args!0| ((|c| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |c| |x| (QREFELT $ 62)) (|spadConstant| $ 43)
                      (QREFELT $ 78)))))) 

(SDEFUN |RDEEFX;get_rational_solutions|
        ((|eq1| (|Equation| (|Fraction| (|Polynomial| F)))) (|s1| (|Symbol|))
         (|s2| (|Symbol|)) ($ (|List| (|Fraction| (|Integer|)))))
        (SPROG
         ((|eq1f| (F)) (|k1| (|Kernel| F)) (|eq1p| (|Polynomial| F))
          (|ru2| (|Union| (|Fraction| (|Integer|)) "failed"))
          (|ru1| (|Union| F "failed"))
          (|ru0| (|Union| (|Polynomial| F) "failed"))
          (|rv| (|Fraction| (|Polynomial| F))))
         (SEQ
          (COND
           ((SPADCALL (LETT |rv| (SPADCALL |eq1| (QREFELT $ 147)))
                      (|spadConstant| $ 148) (QREFELT $ 149))
            (COND
             ((SPADCALL |s1|
                        (SPADCALL (SPADCALL |eq1| (QREFELT $ 150))
                                  (QREFELT $ 151))
                        (QREFELT $ 152))
              (|error| "wrong format of solution 1"))
             (#1='T
              (SEQ (LETT |ru0| (SPADCALL |rv| (QREFELT $ 154)))
                   (EXIT
                    (COND ((QEQCAR |ru0| 1) NIL)
                          (#1#
                           (SEQ
                            (LETT |ru1|
                                  (SPADCALL (QCDR |ru0|) (QREFELT $ 157)))
                            (EXIT
                             (COND ((QEQCAR |ru1| 1) NIL)
                                   (#1#
                                    (SEQ
                                     (LETT |ru2|
                                           (SPADCALL (QCDR |ru1|)
                                                     (QREFELT $ 159)))
                                     (EXIT
                                      (COND ((QEQCAR |ru2| 1) NIL)
                                            (#1#
                                             (LIST (QCDR |ru2|)))))))))))))))))
           (#1#
            (SEQ
             (LETT |eq1p|
                   (SPADCALL (SPADCALL |eq1| (QREFELT $ 150)) (QREFELT $ 160)))
             (EXIT
              (COND
               ((SPADCALL |s2| (SPADCALL |eq1p| (QREFELT $ 162))
                          (QREFELT $ 163))
                (|error| "wrong format of solution 2"))
               (#1#
                (SEQ (LETT |k1| (SPADCALL |s1| (QREFELT $ 58)))
                     (LETT |eq1f|
                           (SPADCALL
                            (SPADCALL |eq1p| |s1|
                                      (SPADCALL |k1| (QREFELT $ 61))
                                      (QREFELT $ 164))
                            (QREFELT $ 165)))
                     (EXIT (SPADCALL |eq1f| |k1| (QREFELT $ 167))))))))))))) 

(SDEFUN |RDEEFX;F_to_FP|
        ((|p| (F)) (|ls| (|List| (|Symbol|))) (|lk| (|List| (|Kernel| F)))
         ($ (|Polynomial| F)))
        (SPROG
         ((|pu1| (|SparseUnivariatePolynomial| (|Polynomial| F)))
          (|pu| (|SparseUnivariatePolynomial| F)) (|s1| (|Symbol|))
          (|k1| (|Kernel| F)))
         (SEQ
          (COND ((NULL |lk|) (SPADCALL |p| (QREFELT $ 168)))
                ('T
                 (SEQ (LETT |k1| (|SPADfirst| |lk|))
                      (LETT |s1| (|SPADfirst| |ls|))
                      (LETT |pu|
                            (SPADCALL (SPADCALL |p| |k1| (QREFELT $ 35))
                                      (QREFELT $ 38)))
                      (LETT |pu1|
                            (SPADCALL
                             (CONS #'|RDEEFX;F_to_FP!0| (VECTOR |lk| $ |ls|))
                             |pu| (QREFELT $ 174)))
                      (EXIT (SPADCALL |pu1| |s1| (QREFELT $ 176))))))))) 

(SDEFUN |RDEEFX;F_to_FP!0| ((|c| NIL) ($$ NIL))
        (PROG (|ls| $ |lk|)
          (LETT |ls| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |lk| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|RDEEFX;F_to_FP| |c| (SPADCALL |ls| (QREFELT $ 169))
             (SPADCALL |lk| (QREFELT $ 170)) $))))) 

(SDEFUN |RDEEFX;solve_poly_eqs|
        ((|eqs| (|List| F)) (|s1| (|Symbol|)) (|s2| (|Symbol|))
         ($
          (|List|
           (|Record| (|:| |ratpart| (|Fraction| (|Integer|)))
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))))))
        (SPROG
         ((|res|
           (|List|
            (|Record| (|:| |ratpart| (|Fraction| (|Integer|)))
                      (|:| |alg_part| (|SparseUnivariatePolynomial| F)))))
          (|val2alg| (|SparseUnivariatePolynomial| F))
          (|val2eq| (|Polynomial| F)) (#1=#:G1156 NIL) (|val1r| NIL)
          (|eq1| (|Equation| (|Fraction| (|Polynomial| F))))
          (|eq0p| (|Polynomial| F))
          (|eq0| (|Equation| (|Fraction| (|Polynomial| F)))) (#2=#:G1155 NIL)
          (|sol0| NIL)
          (|lsol0|
           (|List| (|List| (|Equation| (|Fraction| (|Polynomial| F))))))
          (#3=#:G1154 NIL) (|ci| NIL) (#4=#:G1153 NIL)
          (|eqs0| (|List| (|Polynomial| F))) (#5=#:G1152 NIL) (|eqi| NIL)
          (#6=#:G1151 NIL) (|k2| #7=(|Kernel| F)) (|k1| #7#))
         (SEQ (LETT |k1| (SPADCALL |s1| (QREFELT $ 58)))
              (LETT |k2| (SPADCALL |s2| (QREFELT $ 58)))
              (LETT |eqs0|
                    (PROGN
                     (LETT #6# NIL)
                     (SEQ (LETT |eqi| NIL) (LETT #5# |eqs|) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |eqi| (CAR #5#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #6#
                                  (CONS
                                   (|RDEEFX;F_to_FP|
                                    (SPADCALL (SPADCALL |eqi| (QREFELT $ 178))
                                              (QREFELT $ 179))
                                    (LIST |s1| |s2|) (LIST |k1| |k2|) $)
                                   #6#))))
                          (LETT #5# (CDR #5#)) (GO G190) G191
                          (EXIT (NREVERSE #6#)))))
              (LETT |lsol0|
                    (SPADCALL
                     (PROGN
                      (LETT #4# NIL)
                      (SEQ (LETT |ci| NIL) (LETT #3# |eqs0|) G190
                           (COND
                            ((OR (ATOM #3#) (PROGN (LETT |ci| (CAR #3#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #4#
                                   (CONS (SPADCALL |ci| (QREFELT $ 180))
                                         #4#))))
                           (LETT #3# (CDR #3#)) (GO G190) G191
                           (EXIT (NREVERSE #4#))))
                     (LIST |s2| |s1|) (QREFELT $ 184)))
              (LETT |res| NIL)
              (SEQ (LETT |sol0| NIL) (LETT #2# |lsol0|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |sol0| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (LENGTH |sol0|) 2 (QREFELT $ 89))
                       (|error| "wrong format of solution 0"))
                      ('T
                       (SEQ (LETT |eq0| (|SPADfirst| |sol0|))
                            (LETT |eq0p|
                                  (SPADCALL
                                   (SPADCALL (SPADCALL |eq0| (QREFELT $ 150))
                                             (SPADCALL |eq0| (QREFELT $ 147))
                                             (QREFELT $ 185))
                                   (QREFELT $ 160)))
                            (LETT |eq1| (SPADCALL |sol0| (QREFELT $ 187)))
                            (EXIT
                             (SEQ (LETT |val1r| NIL)
                                  (LETT #1#
                                        (|RDEEFX;get_rational_solutions| |eq1|
                                         |s1| |s2| $))
                                  G190
                                  (COND
                                   ((OR (ATOM #1#)
                                        (PROGN (LETT |val1r| (CAR #1#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (LETT |val2eq|
                                         (SPADCALL |eq0p| |s1|
                                                   (SPADCALL |val1r|
                                                             (QREFELT $ 188))
                                                   (QREFELT $ 164)))
                                   (LETT |val2alg|
                                         (SPADCALL |val2eq| (QREFELT $ 189)))
                                   (EXIT
                                    (LETT |res|
                                          (CONS (CONS |val1r| |val2alg|)
                                                |res|))))
                                  (LETT #1# (CDR #1#)) (GO G190) G191
                                  (EXIT NIL))))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |RDEEFX;ei_args0|
        ((|gd| (|SparseUnivariatePolynomial| F))
         (|nf| (|SparseUnivariatePolynomial| F))
         (|denf| (|SparseUnivariatePolynomial| F)) (|k| (|Kernel| F))
         (|vlst0| (|List| F)) (|ulst0| (|List| F)) (|x| (|Symbol|))
         ($
          (|List|
           (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F)))))
        (SPROG
         ((|res|
           (|List|
            (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                      (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                      (|:| |u_part| F) (|:| |exponent| (|Integer|))
                      (|:| |shift_part| F))))
          (|dega| (|Integer|)) (|fac| (|SparseUnivariatePolynomial| F))
          (|ap| (|SparseUnivariatePolynomial| F)) (#1=#:G1192 NIL)
          (|res1l|
           (|List|
            (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                      (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                      (|:| |u_part| F) (|:| |exponent| (|Integer|))
                      (|:| |shift_part| F))))
          (|nn| #2=(|SparseUnivariatePolynomial| F)) (|ri| (|Integer|))
          (|ru| (|Union| (|Integer|) "failed")) (#3=#:G1191 NIL) (|r0| NIL)
          (|degn1| (|NonNegativeInteger|)) (|degn| #4=(|NonNegativeInteger|))
          (|degd| #4#) (|ratl| (|List| (|Fraction| (|Integer|)))) (|eq1| (F))
          (|nnp| #2#)
          (|res1|
           (|Union|
            (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                      (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                      (|:| |u_part| F) (|:| |exponent| (|Integer|))
                      (|:| |shift_part| F))
            "failed"))
          (#5=#:G1190 NIL) (|sol| NIL) (|r_bad| (|Integer|))
          (|has_r_bad| (|Boolean|)) (|ccu| (|Union| (|Integer|) "failed"))
          (|cc| (F))
          (|lsol|
           (|List|
            (|Record| (|:| |ratpart| (|Fraction| (|Integer|)))
                      (|:| |alg_part| (|SparseUnivariatePolynomial| F)))))
          (|eqs0| (|List| F)) (#6=#:G1189 NIL) (|ci| NIL) (#7=#:G1188 NIL)
          (|qq| (|SparseUnivariatePolynomial| F)) (|b| #8=(|Kernel| F))
          (|bs| #9=(|Symbol|)) (|a| #8#) (|as| #9#) (|u0| (F))
          (|ulst| (|List| F)) (|vlst| (|List| F)) (#10=#:G1186 NIL) (|v| NIL)
          (#11=#:G1187 NIL) (|u| NIL) (|kf| (F)))
         (SEQ (LETT |vlst| NIL) (LETT |ulst| NIL)
              (LETT |kf| (SPADCALL |k| (QREFELT $ 61)))
              (SEQ (LETT |u| NIL) (LETT #11# |ulst0|) (LETT |v| NIL)
                   (LETT #10# |vlst0|) G190
                   (COND
                    ((OR (ATOM #10#) (PROGN (LETT |v| (CAR #10#)) NIL)
                         (ATOM #11#) (PROGN (LETT |u| (CAR #11#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL |v| |kf| (QREFELT $ 131))
                       (SEQ (LETT |vlst| (CONS |v| |vlst|))
                            (EXIT (LETT |ulst| (CONS |u| |ulst|)))))
                      ('T (LETT |u0| |u|)))))
                   (LETT #10# (PROG1 (CDR #10#) (LETT #11# (CDR #11#))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |as| (SPADCALL (QREFELT $ 57)))
              (LETT |a| (SPADCALL |as| (QREFELT $ 58)))
              (LETT |bs| (SPADCALL (QREFELT $ 57)))
              (LETT |b| (SPADCALL |bs| (QREFELT $ 58)))
              (LETT |nn|
                    (SPADCALL |nf|
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL (SPADCALL |a| (QREFELT $ 61)) 1
                                          (QREFELT $ 44))
                                (SPADCALL (SPADCALL |b| (QREFELT $ 61))
                                          (QREFELT $ 45))
                                (QREFELT $ 49))
                               |denf| (QREFELT $ 97))
                              (QREFELT $ 49)))
              (LETT |qq| (SPADCALL |gd| |nn| (QREFELT $ 190)))
              (LETT |eqs0|
                    (PROGN
                     (LETT #7# NIL)
                     (SEQ (LETT |ci| NIL)
                          (LETT #6# (SPADCALL |qq| (QREFELT $ 94))) G190
                          (COND
                           ((OR (ATOM #6#) (PROGN (LETT |ci| (CAR #6#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #7#
                                  (CONS
                                   (SPADCALL (SPADCALL |ci| (QREFELT $ 178))
                                             (QREFELT $ 179))
                                   #7#))))
                          (LETT #6# (CDR #6#)) (GO G190) G191
                          (EXIT (NREVERSE #7#)))))
              (LETT |lsol| (|RDEEFX;solve_poly_eqs| |eqs0| |as| |bs| $))
              (LETT |has_r_bad| NIL) (LETT |r_bad| 0)
              (COND
               ((>= (+ (SPADCALL |denf| (QREFELT $ 40)) 1)
                    (SPADCALL |nf| (QREFELT $ 40)))
                (COND
                 ((> (+ (SPADCALL |denf| (QREFELT $ 40)) 1)
                     (SPADCALL |nf| (QREFELT $ 40)))
                  (SEQ (LETT |has_r_bad| 'T) (EXIT (LETT |r_bad| 0))))
                 ('T
                  (SEQ
                   (LETT |cc|
                         (SPADCALL
                          (SPADCALL (SPADCALL |nf| (QREFELT $ 103))
                                    (SPADCALL |denf| (QREFELT $ 103))
                                    (QREFELT $ 67))
                          (QREFELT $ 48)))
                   (LETT |ccu| (SPADCALL |cc| (QREFELT $ 133)))
                   (EXIT
                    (COND
                     ((QEQCAR |ccu| 0)
                      (SEQ (LETT |has_r_bad| 'T)
                           (EXIT (LETT |r_bad| (QCDR |ccu|))))))))))))
              (LETT |res| NIL)
              (SEQ (LETT |sol| NIL) (LETT #5# |lsol|) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |sol| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |ru| (SPADCALL (QCAR |sol|) (QREFELT $ 191)))
                        (EXIT
                         (COND ((QEQCAR |ru| 1) "iterate")
                               ('T
                                (SEQ
                                 (COND
                                  (|has_r_bad|
                                   (COND
                                    ((EQL (QCDR |ru|) |r_bad|)
                                     (EXIT "iterate")))))
                                 (LETT |res1|
                                       (|RDEEFX;handle_factor| |gd| |nf| |denf|
                                        (QCDR |sol|) (QCDR |ru|) |u| |vlst|
                                        |ulst| |k| |x| 'T $))
                                 (EXIT
                                  (COND ((QEQCAR |res1| 1) "iterate")
                                        ('T
                                         (LETT |res|
                                               (CONS (QCDR |res1|)
                                                     |res|))))))))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (LETT |nnp|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL (SPADCALL |nf| (QREFELT $ 192)) |denf|
                                (QREFELT $ 97))
                      (SPADCALL (SPADCALL |denf| (QREFELT $ 192)) |nf|
                                (QREFELT $ 97))
                      (QREFELT $ 46))
                     (SPADCALL (SPADCALL |a| (QREFELT $ 61)) (QREFELT $ 45))
                     (QREFELT $ 49)))
              (LETT |eq1| (SPADCALL |nnp| |gd| (QREFELT $ 193)))
              (LETT |ratl| (SPADCALL |eq1| |a| (QREFELT $ 167)))
              (COND
               (|has_r_bad|
                (COND
                 ((NULL
                   (SPADCALL (SPADCALL |r_bad| (QREFELT $ 140)) |ratl|
                             (QREFELT $ 194)))
                  (LETT |ratl|
                        (CONS (SPADCALL |r_bad| (QREFELT $ 140)) |ratl|))))))
              (LETT |degd| (SPADCALL |denf| (QREFELT $ 40)))
              (LETT |degn| (SPADCALL |nf| (QREFELT $ 40)))
              (LETT |degn1| (MAX |degn| (+ |degd| 1)))
              (SEQ (LETT |r0| NIL) (LETT #3# |ratl|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |r0| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |ru| (SPADCALL |r0| (QREFELT $ 191)))
                        (EXIT
                         (COND ((QEQCAR |ru| 1) "iterate")
                               ('T
                                (SEQ (LETT |ri| (QCDR |ru|))
                                     (LETT |nn|
                                           (SPADCALL |nf|
                                                     (SPADCALL
                                                      (SPADCALL
                                                       (SPADCALL |ri|
                                                                 (QREFELT $
                                                                          74))
                                                       1 (QREFELT $ 44))
                                                      |denf| (QREFELT $ 97))
                                                     (QREFELT $ 49)))
                                     (LETT |res1l|
                                           (|RDEEFX;ei_args3| |gd| |nn| |denf|
                                            |k| |vlst| |ulst| |x| $))
                                     (EXIT
                                      (SEQ (LETT #1# |res1l|) G190
                                           (COND
                                            ((OR (ATOM #1#)
                                                 (PROGN
                                                  (LETT |res1| (CAR #1#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ (LETT |ap| (QVELT |res1| 3))
                                                (LETT |fac| (QVELT |res1| 0))
                                                (LETT |dega|
                                                      (COND
                                                       ((SPADCALL |ap|
                                                                  (|spadConstant|
                                                                   $ 102)
                                                                  (QREFELT $
                                                                           111))
                                                        1)
                                                       ('T
                                                        (SPADCALL |ap|
                                                                  (QREFELT $
                                                                           40)))))
                                                (EXIT
                                                 (COND
                                                  ((EQL
                                                    (SPADCALL |fac|
                                                              (QREFELT $ 40))
                                                    (* |degn1| |dega|))
                                                   "iterate")
                                                  ('T
                                                   (LETT |res|
                                                         (CONS
                                                          (VECTOR |fac| |ri|
                                                                  (QVELT |res1|
                                                                         2)
                                                                  |ap|
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    |u0| |ri|
                                                                    (QREFELT $
                                                                             79))
                                                                   (QVELT
                                                                    |res1| 4)
                                                                   (QREFELT $
                                                                            65))
                                                                  0
                                                                  (QVELT |res1|
                                                                         6))
                                                          |res|))))))
                                           (LETT #1# (CDR #1#)) (GO G190) G191
                                           (EXIT NIL))))))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |RDEEFX;ei_args1|
        ((|gd| (|SparseUnivariatePolynomial| F))
         (|nf| (|SparseUnivariatePolynomial| F))
         (|denf| (|SparseUnivariatePolynomial| F)) (|t| (|Kernel| F))
         ($ (|Factored| (|SparseUnivariatePolynomial| F))))
        (SPROG ((|r| (F)))
               (SEQ
                (LETT |r|
                      (SPADCALL
                       (SPADCALL |nf|
                                 (SPADCALL (SPADCALL |t| (QREFELT $ 61)) |denf|
                                           (QREFELT $ 136))
                                 (QREFELT $ 49))
                       |gd| (QREFELT $ 193)))
                (EXIT
                 (SPADCALL
                  (SPADCALL (SPADCALL |r| |t| (QREFELT $ 35)) (QREFELT $ 38))
                  (QREFELT $ 126)))))) 

(SDEFUN |RDEEFX;ei_args2|
        ((|gd| (|SparseUnivariatePolynomial| F))
         (|nf| (|SparseUnivariatePolynomial| F))
         (|denf| (|SparseUnivariatePolynomial| F))
         (|f_res| (|Factored| (|SparseUnivariatePolynomial| F)))
         (|k| (|Kernel| F)) (|vlst| (|List| F)) (|ulst| (|List| F))
         (|x| (|Symbol|))
         ($
          (|List|
           (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F)))))
        (SPROG
         ((|res|
           (|List|
            (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                      (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                      (|:| |u_part| F) (|:| |exponent| (|Integer|))
                      (|:| |shift_part| F))))
          (|resu|
           (|Union|
            (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                      (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                      (|:| |u_part| F) (|:| |exponent| (|Integer|))
                      (|:| |shift_part| F))
            "failed"))
          (|deg1| (|NonNegativeInteger|))
          (|f1| #1=(|SparseUnivariatePolynomial| F)) (#2=#:G1202 NIL)
          (|fac| NIL)
          (|rfac|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| #1#)
                      (|:| |exponent| (|NonNegativeInteger|))))))
         (SEQ (LETT |rfac| (SPADCALL |f_res| (QREFELT $ 130))) (LETT |res| NIL)
              (SEQ (LETT |fac| NIL) (LETT #2# |rfac|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |fac| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |f1| (QVELT |fac| 1))
                        (LETT |deg1| (SPADCALL |f1| (QREFELT $ 40)))
                        (EXIT
                         (COND ((EQL |deg1| 0) "iterate")
                               ('T
                                (SEQ
                                 (LETT |resu|
                                       (|RDEEFX;handle_factor| |gd| |nf| |denf|
                                        |f1| 0 (|spadConstant| $ 32) |vlst|
                                        |ulst| |k| |x| NIL $))
                                 (EXIT
                                  (COND
                                   ((QEQCAR |resu| 0)
                                    (LETT |res|
                                          (CONS (QCDR |resu|) |res|))))))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |RDEEFX;ei_args3|
        ((|gd| (|SparseUnivariatePolynomial| F))
         (|nf| (|SparseUnivariatePolynomial| F))
         (|denf| (|SparseUnivariatePolynomial| F)) (|k| (|Kernel| F))
         (|vlst| (|List| F)) (|ulst| (|List| F)) (|x| (|Symbol|))
         ($
          (|List|
           (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F)))))
        (SPROG
         ((|f_res| (|Factored| (|SparseUnivariatePolynomial| F)))
          (|t| (|Kernel| F)))
         (SEQ (LETT |t| (SPADCALL (SPADCALL (QREFELT $ 57)) (QREFELT $ 58)))
              (LETT |f_res| (|RDEEFX;ei_args1| |gd| |nf| |denf| |t| $))
              (EXIT
               (|RDEEFX;ei_args2| |gd| |nf| |denf| |f_res| |k| |vlst| |ulst|
                |x| $))))) 

(SDEFUN |RDEEFX;ei_args|
        ((|gd| (|SparseUnivariatePolynomial| F))
         (|nf| (|SparseUnivariatePolynomial| F))
         (|denf| (|SparseUnivariatePolynomial| F)) (|k| (|Kernel| F))
         (|vlst| (|List| F)) (|ulst| (|List| F)) (|x| (|Symbol|))
         ($
          (|List|
           (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F)))))
        (SPROG
         ((|res1|
           (|List|
            (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                      (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                      (|:| |u_part| F) (|:| |exponent| (|Integer|))
                      (|:| |shift_part| F)))))
         (SEQ
          (COND ((EQL (SPADCALL |gd| (QREFELT $ 40)) 0) NIL)
                (#1='T
                 (SEQ
                  (LETT |res1|
                        (COND
                         ((SPADCALL |k| '|log| (QREFELT $ 22))
                          (|RDEEFX;ei_args0| |gd| |nf| |denf| |k| |vlst| |ulst|
                           |x| $))
                         (#1#
                          (|RDEEFX;ei_args3| |gd| |nf| |denf| |k| |vlst| |ulst|
                           |x| $))))
                  (EXIT |res1|))))))) 

(SDEFUN |RDEEFX;my_exp|
        ((|p| (|SparseUnivariatePolynomial| F)) (|n| (|NonNegativeInteger|))
         ($ (|SparseUnivariatePolynomial| F)))
        (SPADCALL |p| |n| (QREFELT $ 195))) 

(SDEFUN |RDEEFX;ei_candidate|
        ((|nf| (|SparseUnivariatePolynomial| F))
         (|denf| (|SparseUnivariatePolynomial| F)) (|vlst| (|List| F))
         (|ulst| (|List| F)) (|k| (|Kernel| F)) (|x| (|Symbol|))
         (|a| (|Integer|)) (|tt| (F))
         (|res|
          (|List|
           (|Record| (|:| |degree| (|Integer|))
                     (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                     (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |new_f|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |radicand|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F) (|:| |a_val| F))))
         ($
          (|List|
           (|Record| (|:| |degree| (|Integer|))
                     (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                     (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |new_f|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |radicand|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F) (|:| |a_val| F)))))
        (SPROG
         ((|uv|
           (|Record| (|:| |u_part| F) (|:| |v_part| F)
                     (|:| |exponent| (|Integer|)) (|:| |coeff| (|Integer|))))
          (|uvu|
           (|Union|
            (|Record| (|:| |u_part| F) (|:| |v_part| F)
                      (|:| |exponent| (|Integer|)) (|:| |coeff| (|Integer|)))
            "failed"))
          (|nf1| (|SparseUnivariatePolynomial| F)))
         (SEQ (LETT |tt| (SPADCALL |tt| (QREFELT $ 48)))
              (LETT |nf1|
                    (SPADCALL |nf| (SPADCALL |tt| |denf| (QREFELT $ 136))
                              (QREFELT $ 49)))
              (EXIT
               (COND
                ((SPADCALL (SPADCALL |nf1| (QREFELT $ 110))
                           (|spadConstant| $ 102) (QREFELT $ 109))
                 |res|)
                (#1='T
                 (SEQ
                  (COND
                   ((> (SPADCALL |nf1| (QREFELT $ 40)) 0)
                    (COND
                     ((NULL (SPADCALL |k| '|exp| (QREFELT $ 22)))
                      (EXIT |res|)))))
                  (LETT |uvu| (|RDEEFX;get_uv| |tt| |vlst| |ulst| |k| |x| $))
                  (EXIT
                   (COND ((QEQCAR |uvu| 1) |res|)
                         (#1#
                          (SEQ (LETT |uv| (QCDR |uvu|))
                               (EXIT
                                (CONS
                                 (VECTOR 1 |nf1| (|spadConstant| $ 32) |a| |tt|
                                         (|spadConstant| $ 102)
                                         (SPADCALL |nf1| |denf|
                                                   (QREFELT $ 196))
                                         (|spadConstant| $ 197) (QVELT |uv| 0)
                                         (QVELT |uv| 2) (QVELT |uv| 1)
                                         (|spadConstant| $ 43))
                                 |res|))))))))))))) 

(SDEFUN |RDEEFX;special_ei_candidates|
        ((|nf| (|SparseUnivariatePolynomial| F))
         (|denf| (|SparseUnivariatePolynomial| F)) (|vlst| (|List| F))
         (|ulst| (|List| F)) (|k| (|Kernel| F)) (|x| (|Symbol|))
         ($
          (|List|
           (|Record| (|:| |degree| (|Integer|))
                     (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                     (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |new_f|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |radicand|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F) (|:| |a_val| F)))))
        (SPROG
         ((|tt| (F)) (|a| (|Integer|)) (#1=#:G1241 NIL)
          (|rcu| (|Union| (|Integer|) "failed")) (|lc| (F))
          (|res|
           (|List|
            (|Record| (|:| |degree| (|Integer|))
                      (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                      (|:| |v_part| F)
                      (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                      (|:| |new_f|
                           (|Fraction| (|SparseUnivariatePolynomial| F)))
                      (|:| |radicand|
                           (|Fraction| (|SparseUnivariatePolynomial| F)))
                      (|:| |u_part| F) (|:| |exponent| (|Integer|))
                      (|:| |shift_part| F) (|:| |a_val| F))))
          (|rdf| #2=(|SparseUnivariatePolynomial| F)) (|rnf| #2#)
          (|n2| #3=(|NonNegativeInteger|)) (|n1| #3#))
         (SEQ
          (EXIT
           (SEQ (LETT |tt| (|spadConstant| $ 43)) (LETT |a| 0)
                (EXIT
                 (COND
                  ((SPADCALL |k| '|exp| (QREFELT $ 22))
                   (SEQ (LETT |res| NIL)
                        (LETT |n1| (SPADCALL |nf| (QREFELT $ 40)))
                        (LETT |n2| (SPADCALL |denf| (QREFELT $ 40)))
                        (LETT |rnf| (SPADCALL |nf| (QREFELT $ 110)))
                        (LETT |rdf| (SPADCALL |denf| (QREFELT $ 110)))
                        (EXIT
                         (COND
                          ((EQL |n1| |n2|)
                           (SEQ (LETT |tt| (SPADCALL |nf| (QREFELT $ 103)))
                                (LETT |res|
                                      (|RDEEFX;ei_candidate| |nf| |denf| |vlst|
                                       |ulst| |k| |x| |a| |tt| |res| $))
                                (COND
                                 ((SPADCALL |rdf| (|spadConstant| $ 102)
                                            (QREFELT $ 109))
                                  (COND
                                   ((EQL (SPADCALL |rdf| (QREFELT $ 40))
                                         (SPADCALL |rnf| (QREFELT $ 40)))
                                    (EXIT
                                     (SEQ
                                      (LETT |tt|
                                            (SPADCALL
                                             (SPADCALL |rnf| (QREFELT $ 103))
                                             (SPADCALL |rdf| (QREFELT $ 103))
                                             (QREFELT $ 67)))
                                      (EXIT
                                       (|RDEEFX;ei_candidate| |nf| |denf|
                                        |vlst| |ulst| |k| |x| |a| |tt| |res|
                                        $))))))))
                                (EXIT |res|)))
                          (#4='T
                           (SEQ
                            (LETT |res|
                                  (|RDEEFX;ei_candidate| |nf| |denf| |vlst|
                                   |ulst| |k| |x| |a| (|spadConstant| $ 43)
                                   |res| $))
                            (COND
                             ((< |n1| |n2|)
                              (COND
                               ((SPADCALL |rdf| (|spadConstant| $ 102)
                                          (QREFELT $ 109))
                                (COND
                                 ((EQL (SPADCALL |rdf| (QREFELT $ 40)) |n1|)
                                  (EXIT
                                   (SEQ
                                    (LETT |tt|
                                          (SPADCALL
                                           (SPADCALL |nf| (QREFELT $ 103))
                                           (SPADCALL |rdf| (QREFELT $ 103))
                                           (QREFELT $ 67)))
                                    (EXIT
                                     (|RDEEFX;ei_candidate| |nf| |denf| |vlst|
                                      |ulst| |k| |x| |a| |tt| |res| $))))))))))
                            (COND
                             ((> |n1| |n2|)
                              (COND
                               ((SPADCALL |rnf| (|spadConstant| $ 102)
                                          (QREFELT $ 109))
                                (COND
                                 ((EQL (SPADCALL |rnf| (QREFELT $ 40)) |n2|)
                                  (EXIT
                                   (SEQ
                                    (LETT |tt|
                                          (SPADCALL |rnf| (QREFELT $ 103)))
                                    (EXIT
                                     (|RDEEFX;ei_candidate| |nf| |denf| |vlst|
                                      |ulst| |k| |x| |a| |tt| |res| $))))))))))
                            (EXIT |res|)))))))
                  ((> (SPADCALL |nf| (QREFELT $ 40))
                      (+ (SPADCALL |denf| (QREFELT $ 40)) 1))
                   NIL)
                  (#4#
                   (SEQ
                    (COND
                     ((SPADCALL |k| '|log| (QREFELT $ 22))
                      (COND
                       ((EQL (SPADCALL |nf| (QREFELT $ 40))
                             (+ (SPADCALL |denf| (QREFELT $ 40)) 1))
                        (SEQ (LETT |lc| (SPADCALL |nf| (QREFELT $ 103)))
                             (LETT |rcu| (SPADCALL |lc| (QREFELT $ 133)))
                             (EXIT
                              (COND
                               ((QEQCAR |rcu| 1)
                                (PROGN (LETT #1# NIL) (GO #5=#:G1240)))
                               (#4#
                                (SEQ (LETT |a| (- (QCDR |rcu|)))
                                     (EXIT
                                      (LETT |nf|
                                            (SPADCALL |nf|
                                                      (SPADCALL
                                                       (SPADCALL
                                                        (SPADCALL |a|
                                                                  (QREFELT $
                                                                           74))
                                                        1 (QREFELT $ 44))
                                                       |denf| (QREFELT $ 97))
                                                      (QREFELT $
                                                               49)))))))))))))
                    (COND
                     ((EQL (SPADCALL |nf| (QREFELT $ 40))
                           (SPADCALL |denf| (QREFELT $ 40)))
                      (LETT |tt| (SPADCALL |nf| (QREFELT $ 103)))))
                    (EXIT
                     (|RDEEFX;ei_candidate| |nf| |denf| |vlst| |ulst| |k| |x|
                      |a| |tt| NIL $))))))))
          #5# (EXIT #1#)))) 

(SDEFUN |RDEEFX;gamma_candidate|
        ((|fnf| (|Factored| (|SparseUnivariatePolynomial| F)))
         (|nf1| (|SparseUnivariatePolynomial| F))
         (|denf| (|SparseUnivariatePolynomial| F))
         (|gden1| (|SparseUnivariatePolynomial| F)) (|gexp| (|Integer|))
         (|a| (|Integer|)) (|tt| (F)) (|f2| (|SparseUnivariatePolynomial| F))
         (|vlst| (|List| F)) (|ulst| (|List| F)) (|k| (|Kernel| F))
         (|x| (|Symbol|))
         (|res|
          (|List|
           (|Record| (|:| |degree| (|Integer|))
                     (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                     (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |new_f|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |radicand|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F) (|:| |a_val| F))))
         ($
          (|List|
           (|Record| (|:| |degree| (|Integer|))
                     (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                     (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |new_f|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |radicand|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F) (|:| |a_val| F)))))
        (SPROG
         ((|unf| (F)) (|nf2| (|SparseUnivariatePolynomial| F))
          (|m1| (|Integer|)) (#1=#:G1266 NIL)
          (|mu| (|Union| (|Integer|) "failed"))
          (|ur|
           (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| F)
                     (|:| |radicand| F)))
          (#2=#:G1254 NIL)
          (|uv|
           (|Record| (|:| |u_part| F) (|:| |v_part| F)
                     (|:| |exponent| (|Integer|)) (|:| |coeff| (|Integer|))))
          (|uvu|
           (|Union|
            (|Record| (|:| |u_part| F) (|:| |v_part| F)
                      (|:| |exponent| (|Integer|)) (|:| |coeff| (|Integer|)))
            "failed"))
          (#3=#:G1252 NIL) (#4=#:G1272 NIL) (|e1| NIL) (#5=#:G1273 NIL)
          (|fac1| NIL) (#6=#:G1271 NIL)
          (|lexp1| (|List| (|NonNegativeInteger|))) (#7=#:G1246 NIL)
          (#8=#:G1270 NIL) (#9=#:G1269 NIL) (|l1| (|Integer|))
          (|lexp| (|List| (|Integer|))) (#10=#:G1268 NIL) (#11=#:G1267 NIL)
          (|nffacs|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |exponent| (|NonNegativeInteger|))))))
         (SEQ
          (EXIT
           (SEQ (LETT |nffacs| (SPADCALL |fnf| (QREFELT $ 130)))
                (LETT |lexp|
                      (PROGN
                       (LETT #11# NIL)
                       (SEQ (LETT |fac1| NIL) (LETT #10# |nffacs|) G190
                            (COND
                             ((OR (ATOM #10#)
                                  (PROGN (LETT |fac1| (CAR #10#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT (LETT #11# (CONS (QVELT |fac1| 2) #11#))))
                            (LETT #10# (CDR #10#)) (GO G190) G191
                            (EXIT (NREVERSE #11#)))))
                (LETT |l1| (GCD |gexp| (SPADCALL |lexp| (QREFELT $ 115))))
                (EXIT
                 (COND ((EQL |l1| 1) |res|)
                       (#12='T
                        (SEQ
                         (LETT |lexp1|
                               (PROGN
                                (LETT #9# NIL)
                                (SEQ (LETT |e1| NIL) (LETT #8# |lexp|) G190
                                     (COND
                                      ((OR (ATOM #8#)
                                           (PROGN (LETT |e1| (CAR #8#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (LETT #9#
                                             (CONS
                                              (PROG1
                                                  (LETT #7#
                                                        (QUOTIENT2 |e1| |l1|))
                                                (|check_subtype2| (>= #7# 0)
                                                                  '(|NonNegativeInteger|)
                                                                  '(|Integer|)
                                                                  #7#))
                                              #9#))))
                                     (LETT #8# (CDR #8#)) (GO G190) G191
                                     (EXIT (NREVERSE #9#)))))
                         (LETT |nf2|
                               (SPADCALL (ELT $ 97)
                                         (PROGN
                                          (LETT #6# NIL)
                                          (SEQ (LETT |fac1| NIL)
                                               (LETT #5# |nffacs|)
                                               (LETT |e1| NIL)
                                               (LETT #4# |lexp1|) G190
                                               (COND
                                                ((OR (ATOM #4#)
                                                     (PROGN
                                                      (LETT |e1| (CAR #4#))
                                                      NIL)
                                                     (ATOM #5#)
                                                     (PROGN
                                                      (LETT |fac1| (CAR #5#))
                                                      NIL))
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (LETT #6#
                                                       (CONS
                                                        (|RDEEFX;my_exp|
                                                         (QVELT |fac1| 1) |e1|
                                                         $)
                                                        #6#))))
                                               (LETT #4#
                                                     (PROG1 (CDR #4#)
                                                       (LETT #5# (CDR #5#))))
                                               (GO G190) G191
                                               (EXIT (NREVERSE #6#))))
                                         (|spadConstant| $ 108)
                                         (QREFELT $ 200)))
                         (LETT |gden1|
                               (COND ((EQL |gexp| 1) (|spadConstant| $ 108))
                                     (#12#
                                      (|RDEEFX;my_exp| |gden1|
                                       (PROG1
                                           (LETT #3# (QUOTIENT2 |gexp| |l1|))
                                         (|check_subtype2| (>= #3# 0)
                                                           '(|NonNegativeInteger|)
                                                           '(|Integer|) #3#))
                                       $))))
                         (LETT |uvu|
                               (|RDEEFX;get_uv| |tt| |vlst| |ulst| |k| |x| $))
                         (EXIT
                          (COND ((QEQCAR |uvu| 1) |res|)
                                (#12#
                                 (SEQ (LETT |uv| (QCDR |uvu|))
                                      (LETT |unf|
                                            (SPADCALL
                                             (SPADCALL |fnf| (QREFELT $ 201))
                                             (QREFELT $ 202)))
                                      (COND
                                       ((SPADCALL
                                         (SPADCALL |unf| |x| (QREFELT $ 62))
                                         (|spadConstant| $ 43) (QREFELT $ 131))
                                        (SEQ
                                         (LETT |ur|
                                               (SPADCALL |unf|
                                                         (PROG1 (LETT #2# |l1|)
                                                           (|check_subtype2|
                                                            (>= #2# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|) #2#))
                                                         (QREFELT $ 205)))
                                         (COND
                                          ((SPADCALL
                                            (SPADCALL (QVELT |ur| 2) |x|
                                                      (QREFELT $ 62))
                                            (|spadConstant| $ 43)
                                            (QREFELT $ 131))
                                           (PROGN
                                            (LETT #1# |res|)
                                            (GO #13=#:G1265))))
                                         (LETT |mu|
                                               (SPADCALL |l1| (QVELT |ur| 0)
                                                         (QREFELT $ 117)))
                                         (COND
                                          ((QEQCAR |mu| 1)
                                           (PROGN (LETT #1# |res|) (GO #13#))))
                                         (LETT |m1| (QCDR |mu|))
                                         (LETT |nf2|
                                               (SPADCALL |nf2| (QVELT |ur| 1)
                                                         (QREFELT $ 206)))
                                         (EXIT
                                          (LETT |unf|
                                                (SPADCALL (QVELT |ur| 2) |m1|
                                                          (QREFELT $ 79)))))))
                                      (EXIT
                                       (CONS
                                        (VECTOR |l1| |nf2| |unf| |a| |tt| |f2|
                                                (SPADCALL |nf1| |denf|
                                                          (QREFELT $ 196))
                                                (SPADCALL |nf2| |gden1|
                                                          (QREFELT $ 196))
                                                (QVELT |uv| 0) (QVELT |uv| 2)
                                                (QVELT |uv| 1)
                                                (|spadConstant| $ 43))
                                        |res|))))))))))))
          #13# (EXIT #1#)))) 

(SDEFUN |RDEEFX;solve_for_ratios| ((|lc| (|List| F)) ($ (|List| (|Integer|))))
        (SPROG
         ((|rl| (|List| (|Integer|))) (|li| (|Integer|))
          (|j| #1=(|NonNegativeInteger|)) (|jj| #1#) (|i| NIL)
          (|d| (|Integer|)) (#2=#:G1306 NIL) (#3=#:G1305 NIL)
          (|s1| (|Vector| (|Fraction| (|Integer|))))
          (|bl| #4=(|List| (|Vector| (|Fraction| (|Integer|)))))
          (|res|
           (|Record|
            (|:| |particular|
                 (|Union| (|Vector| (|Fraction| (|Integer|))) "failed"))
            (|:| |basis| #4#)))
          (|v0| (|Vector| F)) (#5=#:G1303 NIL) (#6=#:G1304 NIL) (|c| NIL)
          (|m| (|Matrix| F)) (|nn1| (|NonNegativeInteger|)) (#7=#:G1282 NIL)
          (|nlc| (|List| F)) (|c1| (F)) (#8=#:G1302 NIL) (#9=#:G1301 NIL)
          (|n1| #10=(|NonNegativeInteger|)) (#11=#:G1299 NIL) (#12=#:G1300 NIL)
          (|v| (|Vector| (|Integer|))) (|n| #10#))
         (SEQ (LETT |n| (LENGTH |lc|)) (LETT |nlc| NIL)
              (LETT |v| (MAKEARR1 |n| 1))
              (SEQ (LETT |c| NIL) (LETT #12# |lc|) (LETT |i| 1) (LETT #11# |n|)
                   G190
                   (COND
                    ((OR (|greater_SI| |i| #11#) (ATOM #12#)
                         (PROGN (LETT |c| (CAR #12#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((QEQCAR (SPADCALL |c| (QREFELT $ 159)) 0)
                       (SPADCALL |v| |i| 0 (QREFELT $ 118)))
                      ('T (LETT |nlc| (CONS |c| |nlc|))))))
                   (LETT |i| (PROG1 (|inc_SI| |i|) (LETT #12# (CDR #12#))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |n1| (LENGTH |nlc|))
              (EXIT
               (COND ((EQL |n1| 0) NIL)
                     ((EQL |n1| 1)
                      (PROGN
                       (LETT #9# NIL)
                       (SEQ (LETT |i| 1) (LETT #8# |n|) G190
                            (COND ((|greater_SI| |i| #8#) (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #9#
                                    (CONS (SPADCALL |v| 1 (QREFELT $ 116))
                                          #9#))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT (NREVERSE #9#)))))
                     (#13='T
                      (SEQ (LETT |c1| (|SPADfirst| |nlc|))
                           (LETT |nlc| (CDR |nlc|))
                           (LETT |nn1|
                                 (PROG1 (LETT #7# (- |n1| 1))
                                   (|check_subtype2| (>= #7# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #7#)))
                           (LETT |m|
                                 (SPADCALL |nn1| (+ (* 2 |nn1|) 1)
                                           (QREFELT $ 208)))
                           (SEQ (LETT |c| NIL) (LETT #6# |nlc|) (LETT |i| 1)
                                (LETT #5# |nn1|) G190
                                (COND
                                 ((OR (|greater_SI| |i| #5#) (ATOM #6#)
                                      (PROGN (LETT |c| (CAR #6#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (SPADCALL |m| |i| 1
                                           (SPADCALL |c| (QREFELT $ 48))
                                           (QREFELT $ 209))
                                 (SPADCALL |m| |i| (+ |i| 1) |c1|
                                           (QREFELT $ 209))
                                 (EXIT
                                  (SPADCALL |m| |i| (+ |i| |n1|)
                                            (|spadConstant| $ 32)
                                            (QREFELT $ 209))))
                                (LETT |i|
                                      (PROG1 (|inc_SI| |i|)
                                        (LETT #6# (CDR #6#))))
                                (GO G190) G191 (EXIT NIL))
                           (LETT |v0| (SPADCALL |nn1| (QREFELT $ 210)))
                           (LETT |res| (SPADCALL |m| |v0| (QREFELT $ 211)))
                           (LETT |bl| (QCDR |res|))
                           (EXIT
                            (COND ((NULL |bl|) NIL)
                                  (#13#
                                   (SEQ (LETT |s1| (|SPADfirst| |bl|))
                                        (LETT |d|
                                              (SPADCALL
                                               (PROGN
                                                (LETT #3# NIL)
                                                (SEQ (LETT |i| 1)
                                                     (LETT #2# (+ |nn1| 1))
                                                     G190
                                                     (COND
                                                      ((|greater_SI| |i| #2#)
                                                       (GO G191)))
                                                     (SEQ
                                                      (EXIT
                                                       (LETT #3#
                                                             (CONS
                                                              (SPADCALL
                                                               (SPADCALL |s1|
                                                                         |i|
                                                                         (QREFELT
                                                                          $
                                                                          212))
                                                               (QREFELT $ 213))
                                                              #3#))))
                                                     (LETT |i| (|inc_SI| |i|))
                                                     (GO G190) G191
                                                     (EXIT (NREVERSE #3#))))
                                               (QREFELT $ 115)))
                                        (LETT |j| 1) (LETT |rl| NIL)
                                        (SEQ (LETT |i| |n|) G190
                                             (COND ((< |i| 1) (GO G191)))
                                             (SEQ
                                              (LETT |li|
                                                    (COND
                                                     ((EQL
                                                       (SPADCALL |v| |i|
                                                                 (QREFELT $
                                                                          116))
                                                       0)
                                                      0)
                                                     ('T
                                                      (SEQ (LETT |jj| |j|)
                                                           (LETT |j| (+ |j| 1))
                                                           (EXIT
                                                            (SPADCALL
                                                             (SPADCALL |d|
                                                                       (SPADCALL
                                                                        |s1|
                                                                        |jj|
                                                                        (QREFELT
                                                                         $
                                                                         212))
                                                                       (QREFELT
                                                                        $ 214))
                                                             (QREFELT $
                                                                      215)))))))
                                              (EXIT
                                               (LETT |rl| (CONS |li| |rl|))))
                                             (LETT |i| (+ |i| -1)) (GO G190)
                                             G191 (EXIT NIL))
                                        (EXIT |rl|)))))))))))) 

(SDEFUN |RDEEFX;possible_sk|
        ((|w0| (F)) (|f| (F)) (|tk| (|Kernel| F)) (|x| (|Symbol|))
         ($ (|List| (|List| (|Fraction| (|Integer|))))))
        (SPROG
         ((|nwu| #1=(|SparseUnivariatePolynomial| F))
          (|dnw| #2=(|NonNegativeInteger|)) (|ss| (|Integer|)) (#3=#:G1338 NIL)
          (|s| (|Fraction| (|Integer|))) (|g| (|SparseUnivariatePolynomial| F))
          (|dnf| #2#) (|solq| (|Vector| (|Fraction| (|Integer|))))
          (#4=#:G1318 NIL)
          (|sol|
           (|Record|
            (|:| |particular|
                 (|Union| (|Vector| (|Fraction| (|Integer|))) #5="failed"))
            (|:| |basis| (|List| (|Vector| (|Fraction| (|Integer|)))))))
          (|nfu1| (|SparseUnivariatePolynomial| F))
          (|nwu1| (|SparseUnivariatePolynomial| F))
          (|res| (|List| (|List| (|Fraction| (|Integer|)))))
          (|mq| (|Matrix| (|Fraction| (|Integer|))))
          (|vq| (|Vector| (|Fraction| (|Integer|)))) (#6=#:G1308 NIL)
          (|mind| (|NonNegativeInteger|)) (|ddw| #2#)
          (|dwu| #7=(|SparseUnivariatePolynomial| F)) (|ddf| #2#) (|dfu| #7#)
          (|mindf| (|Integer|)) (|mindw| (|Integer|)) (|nfu| #1#)
          (|fu| #8=(|Fraction| (|SparseUnivariatePolynomial| F))) (|wu| #8#))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL (SPADCALL |tk| (QREFELT $ 24)) (QREFELT $ 8)
                       (QREFELT $ 25))
             NIL)
            (#9='T
             (SEQ (LETT |wu| (SPADCALL |w0| |tk| (QREFELT $ 35)))
                  (LETT |nwu| (SPADCALL |wu| (QREFELT $ 38)))
                  (LETT |dwu| (SPADCALL |wu| (QREFELT $ 39)))
                  (LETT |dnw| (SPADCALL |nwu| (QREFELT $ 40)))
                  (LETT |ddw| (SPADCALL |dwu| (QREFELT $ 40)))
                  (COND
                   ((EQL |dnw| 0)
                    (COND ((EQL |ddw| 0) (EXIT (|error| "impossible"))))))
                  (LETT |fu| (SPADCALL |f| |tk| (QREFELT $ 35)))
                  (LETT |nfu| (SPADCALL |fu| (QREFELT $ 38)))
                  (LETT |dfu| (SPADCALL |fu| (QREFELT $ 39)))
                  (LETT |dnf| (SPADCALL |nfu| (QREFELT $ 40)))
                  (LETT |ddf| (SPADCALL |dfu| (QREFELT $ 40))) (LETT |mindf| 0)
                  (LETT |mindw| 0)
                  (COND
                   ((SPADCALL |tk| '|exp| (QREFELT $ 22))
                    (SEQ (LETT |mindw| (SPADCALL |nwu| (QREFELT $ 216)))
                         (LETT |mindw|
                               (COND ((> |mindw| 0) |mindw|)
                                     (#9#
                                      (- (SPADCALL |dwu| (QREFELT $ 216))))))
                         (LETT |mind| (SPADCALL |dfu| (QREFELT $ 216)))
                         (LETT |mindf|
                               (COND ((> |mind| 0) (- |mind|))
                                     (#9# (SPADCALL |nfu| (QREFELT $ 216)))))
                         (EXIT
                          (COND
                           ((> |ddf| |mind|)
                            (SEQ
                             (LETT |dfu|
                                   (PROG2
                                       (LETT #6#
                                             (SPADCALL |dfu|
                                                       (SPADCALL
                                                        (|spadConstant| $ 32)
                                                        |mind| (QREFELT $ 44))
                                                       (QREFELT $ 107)))
                                       (QCDR #6#)
                                     (|check_union2| (QEQCAR #6# 0)
                                                     (|SparseUnivariatePolynomial|
                                                      (QREFELT $ 7))
                                                     (|Union|
                                                      (|SparseUnivariatePolynomial|
                                                       (QREFELT $ 7))
                                                      #10="failed")
                                                     #6#)))
                             (LETT |ddf| (- |ddf| |mind|))
                             (SEQ
                              (LETT |mind| (SPADCALL |dwu| (QREFELT $ 216)))
                              (EXIT
                               (COND
                                ((> |mind| 0)
                                 (SEQ
                                  (LETT |dwu|
                                        (PROG2
                                            (LETT #6#
                                                  (SPADCALL |dwu|
                                                            (SPADCALL
                                                             (|spadConstant| $
                                                                             32)
                                                             |mind|
                                                             (QREFELT $ 44))
                                                            (QREFELT $ 107)))
                                            (QCDR #6#)
                                          (|check_union2| (QEQCAR #6# 0)
                                                          (|SparseUnivariatePolynomial|
                                                           (QREFELT $ 7))
                                                          (|Union|
                                                           (|SparseUnivariatePolynomial|
                                                            (QREFELT $ 7))
                                                           #10#)
                                                          #6#)))
                                  (EXIT
                                   (LETT |ddw|
                                         (SPADCALL |dwu| (QREFELT $ 40)))))))))
                             (LETT |mind| (SPADCALL |nwu| (QREFELT $ 216)))
                             (EXIT
                              (COND
                               ((> |mind| 0)
                                (SEQ
                                 (LETT |nwu|
                                       (PROG2
                                           (LETT #6#
                                                 (SPADCALL |nwu|
                                                           (SPADCALL
                                                            (|spadConstant| $
                                                                            32)
                                                            |mind|
                                                            (QREFELT $ 44))
                                                           (QREFELT $ 107)))
                                           (QCDR #6#)
                                         (|check_union2| (QEQCAR #6# 0)
                                                         (|SparseUnivariatePolynomial|
                                                          (QREFELT $ 7))
                                                         (|Union|
                                                          (|SparseUnivariatePolynomial|
                                                           (QREFELT $ 7))
                                                          #10#)
                                                         #6#)))
                                 (EXIT
                                  (LETT |dnw|
                                        (SPADCALL |nwu| (QREFELT $ 40))))))))))
                           (#9#
                            (SEQ
                             (LETT |vq|
                                   (SPADCALL
                                    (LIST (SPADCALL |mindf| (QREFELT $ 140))
                                          (SPADCALL (- |dnf| |ddf|)
                                                    (QREFELT $ 140)))
                                    (QREFELT $ 143)))
                             (LETT |mq|
                                   (SPADCALL
                                    (LIST
                                     (LIST (SPADCALL |mindw| (QREFELT $ 140))
                                           (SPADCALL (- |dnw| |ddw|)
                                                     (QREFELT $ 140)))
                                     (LIST (|spadConstant| $ 217)
                                           (|spadConstant| $ 217)))
                                    (QREFELT $ 220)))
                             (LETT |sol| (SPADCALL |mq| |vq| (QREFELT $ 222)))
                             (LETT |res|
                                   (COND ((QEQCAR (QCAR |sol|) 1) NIL)
                                         (#9#
                                          (SEQ
                                           (LETT |solq|
                                                 (PROG2 (LETT #4# (QCAR |sol|))
                                                     (QCDR #4#)
                                                   (|check_union2|
                                                    (QEQCAR #4# 0)
                                                    (|Vector|
                                                     (|Fraction| (|Integer|)))
                                                    (|Union|
                                                     (|Vector|
                                                      (|Fraction| (|Integer|)))
                                                     #5#)
                                                    #4#)))
                                           (EXIT
                                            (LIST
                                             (SPADCALL |solq|
                                                       (QREFELT $ 223))))))))
                             (COND
                              ((< |mindf| 0)
                               (COND
                                ((> (- |dnf| |ddf|) 0)
                                 (EXIT
                                  (PROGN
                                   (LETT #3# |res|)
                                   (GO #11=#:G1337)))))))
                             (COND
                              ((EQL |mindf| 0)
                               (SEQ
                                (LETT |nwu1|
                                      (SPADCALL |nwu|
                                                (SPADCALL
                                                 (SPADCALL |nwu| 0
                                                           (QREFELT $ 41))
                                                 0 (QREFELT $ 44))
                                                (QREFELT $ 46)))
                                (EXIT
                                 (SPADCALL |vq| 1
                                           (SPADCALL
                                            (SPADCALL |nwu1| (QREFELT $ 216))
                                            (QREFELT $ 140))
                                           (QREFELT $ 224)))))
                              ((> |mindf| 0)
                               (SPADCALL |vq| 1 (|spadConstant| $ 225)
                                         (QREFELT $ 224)))
                              (#9#
                               (COND
                                ((< (- |dnf| |ddf|) 0)
                                 (SPADCALL |vq| 2 (|spadConstant| $ 225)
                                           (QREFELT $ 224)))
                                (#9#
                                 (SEQ
                                  (LETT |nfu1|
                                        (SPADCALL |nfu| (QREFELT $ 110)))
                                  (EXIT
                                   (SPADCALL |vq| 2
                                             (SPADCALL
                                              (-
                                               (SPADCALL |nfu1| (QREFELT $ 40))
                                               |ddf|)
                                              (QREFELT $ 140))
                                             (QREFELT $ 224))))))))
                             (LETT |sol| (SPADCALL |mq| |vq| (QREFELT $ 222)))
                             (EXIT
                              (COND
                               ((QEQCAR (QCAR |sol|) 1)
                                (PROGN (LETT #3# |res|) (GO #11#)))
                               (#9#
                                (SEQ
                                 (LETT |solq|
                                       (PROG2 (LETT #4# (QCAR |sol|))
                                           (QCDR #4#)
                                         (|check_union2| (QEQCAR #4# 0)
                                                         (|Vector|
                                                          (|Fraction|
                                                           (|Integer|)))
                                                         (|Union|
                                                          (|Vector|
                                                           (|Fraction|
                                                            (|Integer|)))
                                                          #5#)
                                                         #4#)))
                                 (EXIT
                                  (PROGN
                                   (LETT #3#
                                         (CONS
                                          (SPADCALL |solq| (QREFELT $ 223))
                                          |res|))
                                   (GO #11#))))))))))))))
                  (COND
                   ((EQL |dnf| 0)
                    (COND
                     ((EQL |ddf| 0)
                      (COND
                       ((SPADCALL |tk| '|log| (QREFELT $ 22)) (LETT |dnf| 1))
                       (#9# (PROGN (LETT #3# NIL) (GO #11#))))))))
                  (EXIT
                   (COND
                    ((> |ddf| 0)
                     (SEQ (LETT |g| (SPADCALL |dfu| |dwu| (QREFELT $ 105)))
                          (LETT |s|
                                (COND
                                 ((> (SPADCALL |g| (QREFELT $ 40)) 0)
                                  (SPADCALL |ddf| |ddw| (QREFELT $ 226)))
                                 (#9# (SPADCALL |ddf| |dnw| (QREFELT $ 226)))))
                          (EXIT
                           (LIST
                            (LIST |s|
                                  (SPADCALL (SPADCALL |mindf| (QREFELT $ 140))
                                            (SPADCALL |s| |mindw|
                                                      (QREFELT $ 227))
                                            (QREFELT $ 228)))))))
                    (#9#
                     (SEQ (LETT |ss| 1)
                          (COND
                           ((> |ddw| 0)
                            (COND
                             ((> |dnw| 0) (PROGN (LETT #3# NIL) (GO #11#)))
                             (#9#
                              (SEQ (LETT |ss| -1) (LETT |dnw| |ddw|)
                                   (EXIT (LETT |nwu| |dwu|)))))))
                          (EXIT
                           (LIST
                            (LIST
                             (SPADCALL (* |ss| |dnf|) |dnw| (QREFELT $ 226))
                             (|spadConstant| $ 225))))))))))))
          #11# (EXIT #3#)))) 

(SDEFUN |RDEEFX;possible_w|
        ((|f2| (F)) (|w1| (F)) (|x| (|Symbol|)) ($ (|List| F)))
        (SPROG
         ((|w2| (F)) (#1=#:G1356 NIL) (|lc_nw1| (F)) (|lc_nf2| (F))
          (|w2u2| (|Union| F "failed"))
          (|w2u| (|Union| (|SparseUnivariatePolynomial| F) "failed"))
          (|r2| #2=(|SparseUnivariatePolynomial| F)) (|r1| #2#)
          (|df2| #3=(|SparseUnivariatePolynomial| F))
          (|nf2| #4=(|SparseUnivariatePolynomial| F)) (|dw1| #3#) (|nw1| #4#)
          (|f2u| #5=(|Fraction| (|SparseUnivariatePolynomial| F))) (|w1u| #5#)
          (|tk| (|Kernel| F)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |tk| (|RDEEFX;top_kernel| (|spadConstant| $ 32) |w1| |x| $))
            (LETT |w1u| (SPADCALL |w1| |tk| (QREFELT $ 35)))
            (LETT |f2u| (SPADCALL |f2| |tk| (QREFELT $ 35)))
            (LETT |nw1| (SPADCALL |w1u| (QREFELT $ 38)))
            (LETT |dw1| (SPADCALL |w1u| (QREFELT $ 39)))
            (LETT |nf2| (SPADCALL |f2u| (QREFELT $ 38)))
            (LETT |df2| (SPADCALL |f2u| (QREFELT $ 39)))
            (EXIT
             (COND
              ((SPADCALL |df2| |dw1| (QREFELT $ 111))
               (SEQ
                (COND
                 ((> (SPADCALL |dw1| (QREFELT $ 40)) 0)
                  (SEQ (LETT |r1| (SPADCALL |nw1| |dw1| (QREFELT $ 190)))
                       (LETT |r2| (SPADCALL |nf2| |dw1| (QREFELT $ 190)))
                       (LETT |w2u| (SPADCALL |r2| |r1| (QREFELT $ 107)))
                       (EXIT
                        (COND
                         ((QEQCAR |w2u| 1)
                          (PROGN (LETT #1# NIL) (GO #6=#:G1355)))
                         (#7='T
                          (SEQ
                           (LETT |w2u2|
                                 (SPADCALL (QCDR |w2u|) (QREFELT $ 229)))
                           (EXIT
                            (COND
                             ((QEQCAR |w2u2| 1)
                              (PROGN (LETT #1# NIL) (GO #6#)))
                             (#7# (LETT |w2| (QCDR |w2u2|)))))))))))
                 (#7#
                  (SEQ (LETT |lc_nf2| (SPADCALL |nf2| (QREFELT $ 103)))
                       (LETT |lc_nw1| (SPADCALL |nw1| (QREFELT $ 103)))
                       (EXIT
                        (COND
                         ((OR (> (SPADCALL |nw1| (QREFELT $ 40)) 1)
                              (NULL (SPADCALL |tk| '|log| (QREFELT $ 22))))
                          (LETT |w2|
                                (SPADCALL |lc_nf2| |lc_nw1| (QREFELT $ 67))))
                         ('T
                          (SEQ
                           (COND
                            ((EQL (SPADCALL |nf2| (QREFELT $ 40)) 1)
                             (COND
                              ((SPADCALL (SPADCALL |lc_nf2| |x| (QREFELT $ 62))
                                         (|spadConstant| $ 43) (QREFELT $ 131))
                               (EXIT (PROGN (LETT #1# NIL) (GO #6#)))))))
                           (EXIT
                            (LETT |w2|
                                  (SPADCALL (|spadConstant| $ 32) |lc_nw1|
                                            (QREFELT $ 67)))))))))))
                (EXIT
                 (COND
                  ((SPADCALL |w2| (|spadConstant| $ 43) (QREFELT $ 78)) NIL)
                  (#7# (LIST |w2|))))))
              (#7# NIL)))))
          #6# (EXIT #1#)))) 

(SDEFUN |RDEEFX;gen_irr_log_cands|
        ((|a| (F)) (|f| (F)) (|f2| (F)) (|w1| (F)) (|vlst| (|List| F))
         (|ulst| (|List| F)) (|k| (|Kernel| F)) (|x| (|Symbol|))
         (|res|
          (|List|
           (|Record| (|:| |degree| (|Integer|))
                     (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                     (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |new_f|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |radicand|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F) (|:| |a_val| F))))
         ($
          (|List|
           (|Record| (|:| |degree| (|Integer|))
                     (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                     (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |new_f|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |radicand|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F) (|:| |a_val| F)))))
        (SPROG
         ((|uu| (F)) (|ai| (F)) (#1=#:G1395 NIL) (|i| NIL) (|tt| (F))
          (#2=#:G1392 NIL) (|li| NIL) (#3=#:G1393 NIL) (|vi| NIL)
          (#4=#:G1394 NIL) (|ui| NIL) (|uu1| (F)) (#5=#:G1390 NIL) (|ki| NIL)
          (#6=#:G1391 NIL) (|gl| (|Integer|)) (|vli| #7=(|List| (|Integer|)))
          (|d| #8=(|Integer|))
          (|cd| (|Record| (|:| |num| #7#) (|:| |den| #8#)))
          (|sv| (|Vector| (|Fraction| (|Integer|))))
          (|su| (|Union| (|Vector| (|Fraction| (|Integer|))) "failed"))
          (|w_cor| (F)) (#9=#:G1386 NIL) (#10=#:G1387 NIL) (|k2i| NIL)
          (#11=#:G1388 NIL) (#12=#:G1389 NIL) (|coeffs2| #7#)
          (|wu| (|Fraction| (|SparseUnivariatePolynomial| F))) (|w| (F))
          (|a1| (F)) (|coeffs| #7#) (|dvvec| (|Vector| F)) (#13=#:G1385 NIL)
          (#14=#:G1384 NIL) (|v'| (F)) (|lw2'| (F)) (|w2| (F))
          (|lw2| (|List| F)))
         (SEQ (LETT |lw2| (|RDEEFX;possible_w| |f2| |w1| |x| $))
              (EXIT
               (COND ((NULL |lw2|) |res|)
                     (#15='T
                      (SEQ (LETT |w2| (|SPADfirst| |lw2|))
                           (LETT |lw2'|
                                 (SPADCALL (SPADCALL |w2| |x| (QREFELT $ 62))
                                           |w2| (QREFELT $ 67)))
                           (LETT |v'|
                                 (SPADCALL |lw2'|
                                           (SPADCALL
                                            (SPADCALL |w1| |x| (QREFELT $ 62))
                                            |w1| (QREFELT $ 67))
                                           (QREFELT $ 73)))
                           (LETT |dvvec|
                                 (SPADCALL
                                  (PROGN
                                   (LETT #14# NIL)
                                   (SEQ (LETT |vi| NIL) (LETT #13# |vlst|) G190
                                        (COND
                                         ((OR (ATOM #13#)
                                              (PROGN
                                               (LETT |vi| (CAR #13#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #14#
                                                (CONS
                                                 (SPADCALL |vi| |x|
                                                           (QREFELT $ 62))
                                                 #14#))))
                                        (LETT #13# (CDR #13#)) (GO G190) G191
                                        (EXIT (NREVERSE #14#))))
                                  (QREFELT $ 81)))
                           (LETT |su| (SPADCALL |dvvec| |v'| (QREFELT $ 84)))
                           (EXIT
                            (COND ((QEQCAR |su| 1) |res|)
                                  (#15#
                                   (SEQ (LETT |sv| (QCDR |su|))
                                        (LETT |cd|
                                              (SPADCALL |sv| (QREFELT $ 88)))
                                        (LETT |d| (QCDR |cd|))
                                        (EXIT
                                         (COND
                                          ((SPADCALL |d| 1 (QREFELT $ 89))
                                           |res|)
                                          (#15#
                                           (SEQ (LETT |coeffs| (QCAR |cd|))
                                                (LETT |a1|
                                                      (SPADCALL |a|
                                                                (|spadConstant|
                                                                 $ 32)
                                                                (QREFELT $
                                                                         77)))
                                                (LETT |w|
                                                      (SPADCALL
                                                       (SPADCALL |w1| |w2|
                                                                 (QREFELT $
                                                                          65))
                                                       (QREFELT $ 48)))
                                                (LETT |tt|
                                                      (SPADCALL |f| |w|
                                                                (QREFELT $
                                                                         73)))
                                                (LETT |wu|
                                                      (SPADCALL |w| |k|
                                                                (QREFELT $
                                                                         35)))
                                                (LETT |su|
                                                      (SPADCALL |dvvec| |lw2'|
                                                                (QREFELT $
                                                                         84)))
                                                (EXIT
                                                 (COND
                                                  ((QEQCAR |su| 1)
                                                   (|error| "impossible"))
                                                  (#15#
                                                   (SEQ (LETT |sv| (QCDR |su|))
                                                        (LETT |cd|
                                                              (SPADCALL |sv|
                                                                        (QREFELT
                                                                         $
                                                                         88)))
                                                        (LETT |d| (QCDR |cd|))
                                                        (EXIT
                                                         (COND
                                                          ((SPADCALL |d| 1
                                                                     (QREFELT $
                                                                              89))
                                                           (|error|
                                                            "impossible"))
                                                          (#15#
                                                           (SEQ
                                                            (LETT |coeffs2|
                                                                  (QCAR |cd|))
                                                            (LETT |w_cor|
                                                                  (SPADCALL
                                                                   |w2|
                                                                   (QREFELT $
                                                                            48)))
                                                            (SEQ
                                                             (LETT |ui| NIL)
                                                             (LETT #12# |ulst|)
                                                             (LETT |vi| NIL)
                                                             (LETT #11# |vlst|)
                                                             (LETT |k2i| NIL)
                                                             (LETT #10#
                                                                   |coeffs2|)
                                                             (LETT |ki| NIL)
                                                             (LETT #9#
                                                                   |coeffs|)
                                                             G190
                                                             (COND
                                                              ((OR (ATOM #9#)
                                                                   (PROGN
                                                                    (LETT |ki|
                                                                          (CAR
                                                                           #9#))
                                                                    NIL)
                                                                   (ATOM #10#)
                                                                   (PROGN
                                                                    (LETT |k2i|
                                                                          (CAR
                                                                           #10#))
                                                                    NIL)
                                                                   (ATOM #11#)
                                                                   (PROGN
                                                                    (LETT |vi|
                                                                          (CAR
                                                                           #11#))
                                                                    NIL)
                                                                   (ATOM #12#)
                                                                   (PROGN
                                                                    (LETT |ui|
                                                                          (CAR
                                                                           #12#))
                                                                    NIL))
                                                               (GO G191)))
                                                             (SEQ
                                                              (LETT |tt|
                                                                    (SPADCALL
                                                                     |tt|
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        |ki|
                                                                        (QREFELT
                                                                         $ 74))
                                                                       |a1|
                                                                       (QREFELT
                                                                        $ 65))
                                                                      |vi|
                                                                      (QREFELT
                                                                       $ 65))
                                                                     (QREFELT $
                                                                              77)))
                                                              (EXIT
                                                               (LETT |w_cor|
                                                                     (SPADCALL
                                                                      |w_cor|
                                                                      (SPADCALL
                                                                       |ui|
                                                                       (-
                                                                        |k2i|)
                                                                       (QREFELT
                                                                        $ 79))
                                                                      (QREFELT
                                                                       $
                                                                       65)))))
                                                             (LETT #9#
                                                                   (PROG1
                                                                       (CDR
                                                                        #9#)
                                                                     (LETT #10#
                                                                           (PROG1
                                                                               (CDR
                                                                                #10#)
                                                                             (LETT
                                                                              #11#
                                                                              (PROG1
                                                                                  (CDR
                                                                                   #11#)
                                                                                (LETT
                                                                                 #12#
                                                                                 (CDR
                                                                                  #12#))))))))
                                                             (GO G190) G191
                                                             (EXIT NIL))
                                                            (EXIT
                                                             (COND
                                                              ((SPADCALL
                                                                (SPADCALL
                                                                 |w_cor| |x|
                                                                 (QREFELT $
                                                                          62))
                                                                (|spadConstant|
                                                                 $ 43)
                                                                (QREFELT $
                                                                         131))
                                                               (|error|
                                                                "impossible"))
                                                              (#15#
                                                               (SEQ
                                                                (LETT |su|
                                                                      (SPADCALL
                                                                       |dvvec|
                                                                       (SPADCALL
                                                                        |tt|
                                                                        |x|
                                                                        (QREFELT
                                                                         $ 62))
                                                                       (QREFELT
                                                                        $ 84)))
                                                                (EXIT
                                                                 (COND
                                                                  ((QEQCAR |su|
                                                                           1)
                                                                   |res|)
                                                                  (#15#
                                                                   (SEQ
                                                                    (LETT |sv|
                                                                          (QCDR
                                                                           |su|))
                                                                    (LETT |cd|
                                                                          (SPADCALL
                                                                           |sv|
                                                                           (QREFELT
                                                                            $
                                                                            88)))
                                                                    (LETT |d|
                                                                          (QCDR
                                                                           |cd|))
                                                                    (EXIT
                                                                     (COND
                                                                      ((SPADCALL
                                                                        |d| 1
                                                                        (QREFELT
                                                                         $ 89))
                                                                       |res|)
                                                                      (#15#
                                                                       (SEQ
                                                                        (LETT
                                                                         |vli|
                                                                         (QCAR
                                                                          |cd|))
                                                                        (LETT
                                                                         |uu|
                                                                         (SPADCALL
                                                                          (|spadConstant|
                                                                           $
                                                                           32)
                                                                          (QREFELT
                                                                           $
                                                                           48)))
                                                                        (LETT
                                                                         |uu1|
                                                                         (|spadConstant|
                                                                          $
                                                                          32))
                                                                        (LETT
                                                                         |gl|
                                                                         (SPADCALL
                                                                          |coeffs|
                                                                          (QREFELT
                                                                           $
                                                                           115)))
                                                                        (COND
                                                                         ((>
                                                                           |gl|
                                                                           1)
                                                                          (SEQ
                                                                           (LETT
                                                                            |ui|
                                                                            NIL)
                                                                           (LETT
                                                                            #6#
                                                                            |ulst|)
                                                                           (LETT
                                                                            |ki|
                                                                            NIL)
                                                                           (LETT
                                                                            #5#
                                                                            |coeffs|)
                                                                           G190
                                                                           (COND
                                                                            ((OR
                                                                              (ATOM
                                                                               #5#)
                                                                              (PROGN
                                                                               (LETT
                                                                                |ki|
                                                                                (CAR
                                                                                 #5#))
                                                                               NIL)
                                                                              (ATOM
                                                                               #6#)
                                                                              (PROGN
                                                                               (LETT
                                                                                |ui|
                                                                                (CAR
                                                                                 #6#))
                                                                               NIL))
                                                                             (GO
                                                                              G191)))
                                                                           (SEQ
                                                                            (EXIT
                                                                             (LETT
                                                                              |uu1|
                                                                              (SPADCALL
                                                                               (SPADCALL
                                                                                |ui|
                                                                                (QUOTIENT2
                                                                                 |ki|
                                                                                 |gl|)
                                                                                (QREFELT
                                                                                 $
                                                                                 79))
                                                                               |uu1|
                                                                               (QREFELT
                                                                                $
                                                                                65)))))
                                                                           (LETT
                                                                            #5#
                                                                            (PROG1
                                                                                (CDR
                                                                                 #5#)
                                                                              (LETT
                                                                               #6#
                                                                               (CDR
                                                                                #6#))))
                                                                           (GO
                                                                            G190)
                                                                           G191
                                                                           (EXIT
                                                                            NIL))))
                                                                        (SEQ
                                                                         (LETT
                                                                          |ui|
                                                                          NIL)
                                                                         (LETT
                                                                          #4#
                                                                          |ulst|)
                                                                         (LETT
                                                                          |vi|
                                                                          NIL)
                                                                         (LETT
                                                                          #3#
                                                                          |vlst|)
                                                                         (LETT
                                                                          |li|
                                                                          NIL)
                                                                         (LETT
                                                                          #2#
                                                                          |vli|)
                                                                         G190
                                                                         (COND
                                                                          ((OR
                                                                            (ATOM
                                                                             #2#)
                                                                            (PROGN
                                                                             (LETT
                                                                              |li|
                                                                              (CAR
                                                                               #2#))
                                                                             NIL)
                                                                            (ATOM
                                                                             #3#)
                                                                            (PROGN
                                                                             (LETT
                                                                              |vi|
                                                                              (CAR
                                                                               #3#))
                                                                             NIL)
                                                                            (ATOM
                                                                             #4#)
                                                                            (PROGN
                                                                             (LETT
                                                                              |ui|
                                                                              (CAR
                                                                               #4#))
                                                                             NIL))
                                                                           (GO
                                                                            G191)))
                                                                         (SEQ
                                                                          (LETT
                                                                           |tt|
                                                                           (SPADCALL
                                                                            |tt|
                                                                            (SPADCALL
                                                                             (SPADCALL
                                                                              |li|
                                                                              (QREFELT
                                                                               $
                                                                               74))
                                                                             |vi|
                                                                             (QREFELT
                                                                              $
                                                                              65))
                                                                            (QREFELT
                                                                             $
                                                                             77)))
                                                                          (EXIT
                                                                           (LETT
                                                                            |uu|
                                                                            (SPADCALL
                                                                             |uu|
                                                                             (SPADCALL
                                                                              |ui|
                                                                              (-
                                                                               |li|)
                                                                              (QREFELT
                                                                               $
                                                                               79))
                                                                             (QREFELT
                                                                              $
                                                                              65)))))
                                                                         (LETT
                                                                          #2#
                                                                          (PROG1
                                                                              (CDR
                                                                               #2#)
                                                                            (LETT
                                                                             #3#
                                                                             (PROG1
                                                                                 (CDR
                                                                                  #3#)
                                                                               (LETT
                                                                                #4#
                                                                                (CDR
                                                                                 #4#))))))
                                                                         (GO
                                                                          G190)
                                                                         G191
                                                                         (EXIT
                                                                          NIL))
                                                                        (SEQ
                                                                         (LETT
                                                                          |i|
                                                                          0)
                                                                         (LETT
                                                                          #1#
                                                                          (-
                                                                           |gl|
                                                                           1))
                                                                         G190
                                                                         (COND
                                                                          ((|greater_SI|
                                                                            |i|
                                                                            #1#)
                                                                           (GO
                                                                            G191)))
                                                                         (SEQ
                                                                          (LETT
                                                                           |ai|
                                                                           (SPADCALL
                                                                            |a|
                                                                            (SPADCALL
                                                                             (SPADCALL
                                                                              |i|
                                                                              (QREFELT
                                                                               $
                                                                               74))
                                                                             (SPADCALL
                                                                              |gl|
                                                                              (QREFELT
                                                                               $
                                                                               74))
                                                                             (QREFELT
                                                                              $
                                                                              67))
                                                                            (QREFELT
                                                                             $
                                                                             77)))
                                                                          (LETT
                                                                           |res|
                                                                           (CONS
                                                                            (VECTOR
                                                                             0
                                                                             (|spadConstant|
                                                                              $
                                                                              108)
                                                                             |w_cor|
                                                                             0
                                                                             (|spadConstant|
                                                                              $
                                                                              43)
                                                                             (|spadConstant|
                                                                              $
                                                                              102)
                                                                             |wu|
                                                                             (|spadConstant|
                                                                              $
                                                                              197)
                                                                             |uu|
                                                                             0
                                                                             (SPADCALL
                                                                              |tt|
                                                                              (QREFELT
                                                                               $
                                                                               48))
                                                                             |ai|)
                                                                            |res|))
                                                                          (EXIT
                                                                           (LETT
                                                                            |uu|
                                                                            (SPADCALL
                                                                             |uu|
                                                                             |uu1|
                                                                             (QREFELT
                                                                              $
                                                                              67)))))
                                                                         (LETT
                                                                          |i|
                                                                          (|inc_SI|
                                                                           |i|))
                                                                         (GO
                                                                          G190)
                                                                         G191
                                                                         (EXIT
                                                                          NIL))
                                                                        (EXIT
                                                                         |res|)))))))))))))))))))))))))))))))))))) 

(SDEFUN |RDEEFX;irrational_gamma_candidates|
        ((|nf| (|SparseUnivariatePolynomial| F))
         (|denf| (|SparseUnivariatePolynomial| F)) (|vlst| (|List| F))
         (|ulst| (|List| F)) (|k| (|Kernel| F)) (|x| (|Symbol|))
         (|res|
          (|List|
           (|Record| (|:| |degree| (|Integer|))
                     (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                     (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |new_f|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |radicand|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F) (|:| |a_val| F))))
         ($
          (|List|
           (|Record| (|:| |degree| (|Integer|))
                     (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                     (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |new_f|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |radicand|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F) (|:| |a_val| F)))))
        (SPROG
         ((|w1| (F)) (|a| (F)) (|km| #1=(|Integer|)) (|s| #1#) (|kmq| NIL)
          (|#G212| #2=(|List| (|Fraction| (|Integer|)))) (|sq| NIL)
          (|#G211| #2#) (#3=#:G1434 NIL) (|sk| NIL) (|lsk| (|List| #2#))
          (|tk| (|Kernel| F)) (|w0| (F)) (|ak| (F)) (#4=#:G1432 NIL) (|li| NIL)
          (#5=#:G1433 NIL) (|kk| NIL) (|rl| (|List| (|Integer|)))
          (|cl| (|List| F)) (#6=#:G1428 NIL) (|f2| (F)) (|ck| (F))
          (|nf1| (|SparseUnivariatePolynomial| F))
          (|nfr| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (#7=#:G1431 NIL) (|f| (F)) (|nlk| (|List| (|Kernel| F)))
          (#8=#:G1430 NIL) (#9=#:G1429 NIL) (|n1| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL |k| '|log| (QREFELT $ 22))
              (COND
               ((SPADCALL |denf| (|spadConstant| $ 108) (QREFELT $ 111))
                (COND
                 ((EQL (SPADCALL |nf| (QREFELT $ 40)) 1)
                  (EXIT
                   (SEQ (LETT |n1| (SPADCALL |k| (QREFELT $ 19)))
                        (LETT |nlk|
                              (PROGN
                               (LETT #9# NIL)
                               (SEQ (LETT |kk| NIL)
                                    (LETT #8#
                                          (SPADCALL
                                           (SPADCALL |nf| 0 (QREFELT $ 41))
                                           (QREFELT $ 11)))
                                    G190
                                    (COND
                                     ((OR (ATOM #8#)
                                          (PROGN (LETT |kk| (CAR #8#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((COND
                                         ((SPADCALL
                                           (SPADCALL
                                            (SPADCALL |kk| (QREFELT $ 61)) |x|
                                            (QREFELT $ 62))
                                           (|spadConstant| $ 43)
                                           (QREFELT $ 131))
                                          (EQL (SPADCALL |kk| (QREFELT $ 19))
                                               |n1|))
                                         (#10='T NIL))
                                        (LETT #9# (CONS |kk| #9#))))))
                                    (LETT #8# (CDR #8#)) (GO G190) G191
                                    (EXIT (NREVERSE #9#)))))
                        (LETT |nlk| (CONS |k| |nlk|))
                        (LETT |f|
                              (SPADCALL (SPADCALL |nf| |denf| (QREFELT $ 196))
                                        |k| (QREFELT $ 60)))
                        (LETT |f2| |f|) (LETT |cl| NIL)
                        (SEQ (LETT |kk| NIL) (LETT #7# |nlk|) G190
                             (COND
                              ((OR (ATOM #7#)
                                   (PROGN (LETT |kk| (CAR #7#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((NULL (SPADCALL |kk| '|log| (QREFELT $ 22)))
                                 (COND
                                  ((SPADCALL |kk| '|exp| (QREFELT $ 22))
                                   (|error| "unimplemented"))
                                  ('T
                                   (PROGN (LETT #6# |res|) (GO #11=#:G1427)))))
                                ('T
                                 (SEQ
                                  (LETT |nfr|
                                        (SPADCALL |f2| |kk| (QREFELT $ 35)))
                                  (EXIT
                                   (COND
                                    ((SPADCALL (SPADCALL |nfr| (QREFELT $ 39))
                                               (|spadConstant| $ 108)
                                               (QREFELT $ 109))
                                     (PROGN (LETT #6# |res|) (GO #11#)))
                                    ('T
                                     (SEQ
                                      (LETT |nf1|
                                            (SPADCALL |nfr| (QREFELT $ 38)))
                                      (EXIT
                                       (COND
                                        ((EQL (SPADCALL |nf1| (QREFELT $ 40))
                                              0)
                                         (|error| "impossible"))
                                        ((SPADCALL
                                          (SPADCALL |nf1| (QREFELT $ 40)) 1
                                          (QREFELT $ 230))
                                         (PROGN (LETT #6# |res|) (GO #11#)))
                                        ('T
                                         (SEQ
                                          (LETT |ck|
                                                (SPADCALL |nf1|
                                                          (QREFELT $ 103)))
                                          (LETT |f2|
                                                (SPADCALL |nf1| 0
                                                          (QREFELT $ 41)))
                                          (EXIT
                                           (COND
                                            ((SPADCALL
                                              (SPADCALL |ck| |x|
                                                        (QREFELT $ 62))
                                              (|spadConstant| $ 43)
                                              (QREFELT $ 131))
                                             (PROGN
                                              (LETT #6# |res|)
                                              (GO #11#)))
                                            ('T
                                             (LETT |cl|
                                                   (CONS |ck|
                                                         |cl|))))))))))))))))))
                             (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
                        (LETT |cl| (NREVERSE |cl|))
                        (LETT |rl| (|RDEEFX;solve_for_ratios| |cl| $))
                        (EXIT
                         (COND
                          ((SPADCALL (ELT $ 232) |rl| (QREFELT $ 234)) |res|)
                          (#10#
                           (SEQ (LETT |w0| (|spadConstant| $ 32))
                                (SEQ (LETT |kk| NIL) (LETT #5# |nlk|)
                                     (LETT |li| NIL) (LETT #4# |rl|) G190
                                     (COND
                                      ((OR (ATOM #4#)
                                           (PROGN (LETT |li| (CAR #4#)) NIL)
                                           (ATOM #5#)
                                           (PROGN (LETT |kk| (CAR #5#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (LETT |ak|
                                            (SPADCALL
                                             (SPADCALL |kk| (QREFELT $ 27)) 1
                                             (QREFELT $ 29)))
                                      (EXIT
                                       (LETT |w0|
                                             (SPADCALL |w0|
                                                       (SPADCALL |ak| |li|
                                                                 (QREFELT $
                                                                          79))
                                                       (QREFELT $ 65)))))
                                     (LETT #4#
                                           (PROG1 (CDR #4#)
                                             (LETT #5# (CDR #5#))))
                                     (GO G190) G191 (EXIT NIL))
                                (LETT |tk|
                                      (|RDEEFX;top_kernel|
                                       (|spadConstant| $ 32) |w0| |x| $))
                                (LETT |lsk|
                                      (|RDEEFX;possible_sk| |w0| |f2| |tk| |x|
                                       $))
                                (SEQ (LETT |sk| NIL) (LETT #3# |lsk|) G190
                                     (COND
                                      ((OR (ATOM #3#)
                                           (PROGN (LETT |sk| (CAR #3#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (PROGN
                                       (LETT |#G211| |sk|)
                                       (LETT |#G212| |#G211|)
                                       (LETT |sq| (|SPADfirst| |#G212|))
                                       (LETT |#G212| (CDR |#G212|))
                                       (LETT |kmq| (|SPADfirst| |#G212|))
                                       |#G211|)
                                      (EXIT
                                       (COND
                                        ((OR
                                          (SPADCALL |sq| (|spadConstant| $ 225)
                                                    (QREFELT $ 235))
                                          (OR
                                           (SPADCALL
                                            (SPADCALL |sq| (QREFELT $ 213)) 1
                                            (QREFELT $ 89))
                                           (SPADCALL
                                            (SPADCALL |kmq| (QREFELT $ 213)) 1
                                            (QREFELT $ 89))))
                                         "skip")
                                        ('T
                                         (SEQ
                                          (LETT |s|
                                                (SPADCALL |sq|
                                                          (QREFELT $ 236)))
                                          (LETT |km|
                                                (SPADCALL |kmq|
                                                          (QREFELT $ 236)))
                                          (LETT |a| (|SPADfirst| |cl|))
                                          (LETT |a|
                                                (SPADCALL
                                                 (SPADCALL |a|
                                                           (SPADCALL |s|
                                                                     (SPADCALL
                                                                      (|SPADfirst|
                                                                       |rl|)
                                                                      (QREFELT
                                                                       $ 74))
                                                                     (QREFELT $
                                                                              237))
                                                           (QREFELT $ 67))
                                                 (|spadConstant| $ 32)
                                                 (QREFELT $ 73)))
                                          (LETT |w1|
                                                (SPADCALL
                                                 (SPADCALL |w0| |s|
                                                           (QREFELT $ 79))
                                                 (SPADCALL
                                                  (SPADCALL |tk|
                                                            (QREFELT $ 61))
                                                  |km| (QREFELT $ 79))
                                                 (QREFELT $ 65)))
                                          (EXIT
                                           (LETT |res|
                                                 (|RDEEFX;gen_irr_log_cands|
                                                  |a| |f| |f2| |w1| |vlst|
                                                  |ulst| |k| |x| |res|
                                                  $))))))))
                                     (LETT #3# (CDR #3#)) (GO G190) G191
                                     (EXIT NIL))
                                (EXIT |res|)))))))))))))
            (EXIT |res|)))
          #11# (EXIT #6#)))) 

(SDEFUN |RDEEFX;gammas1|
        ((|nf| (|SparseUnivariatePolynomial| F)) (|a| (|Integer|))
         (|denf| (|SparseUnivariatePolynomial| F))
         (|denf1| (|SparseUnivariatePolynomial| F)) (|gexp| (|Integer|))
         (|n2| (|Integer|)) (|vlst| (|List| F)) (|ulst| (|List| F))
         (|k| (|Kernel| F)) (|x| (|Symbol|))
         (|res|
          (|List|
           (|Record| (|:| |degree| (|Integer|))
                     (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                     (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |new_f|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |radicand|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F) (|:| |a_val| F))))
         ($
          (|List|
           (|Record| (|:| |degree| (|Integer|))
                     (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                     (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |new_f|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |radicand|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F) (|:| |a_val| F)))))
        (SPROG
         ((|fnf| (|Factored| (|SparseUnivariatePolynomial| F)))
          (|nf1| (|SparseUnivariatePolynomial| F)) (|cfac| (F))
          (|f2| (|SparseUnivariatePolynomial| F)) (|tt| (F))
          (|deg1| (|NonNegativeInteger|))
          (|f1| #1=(|SparseUnivariatePolynomial| F)) (#2=#:G1452 NIL)
          (|fac| NIL) (|e_tt| (|List| F))
          (|rfacs|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| #1#)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|f_res| (|Factored| (|SparseUnivariatePolynomial| F))) (|r| (F))
          (|nfp1| (|SparseUnivariatePolynomial| F)) (|t| (|Kernel| F)))
         (SEQ (LETT |t| (SPADCALL (SPADCALL (QREFELT $ 57)) (QREFELT $ 58)))
              (LETT |nfp1|
                    (SPADCALL
                     (SPADCALL (SPADCALL |nf| (QREFELT $ 192)) |denf1|
                               (QREFELT $ 97))
                     (SPADCALL
                      (SPADCALL (SPADCALL |gexp| (QREFELT $ 74)) |nf|
                                (QREFELT $ 136))
                      (SPADCALL |denf1| (QREFELT $ 192)) (QREFELT $ 97))
                     (QREFELT $ 46)))
              (LETT |r|
                    (SPADCALL
                     (SPADCALL |nf|
                               (SPADCALL
                                (SPADCALL (SPADCALL |t| (QREFELT $ 61))
                                          (QREFELT $ 45))
                                |denf| (QREFELT $ 97))
                               (QREFELT $ 49))
                     |nfp1| (QREFELT $ 193)))
              (LETT |f_res|
                    (SPADCALL
                     (SPADCALL (SPADCALL |r| |t| (QREFELT $ 35))
                               (QREFELT $ 38))
                     (QREFELT $ 126)))
              (LETT |rfacs| (SPADCALL |f_res| (QREFELT $ 130)))
              (LETT |e_tt|
                    (COND
                     ((EQL (SPADCALL |nf| (QREFELT $ 40)) 0)
                      (LIST (|spadConstant| $ 43)))
                     ((EQL (SPADCALL |nf| (QREFELT $ 40))
                           (SPADCALL |denf| (QREFELT $ 40)))
                      (SEQ
                       (LETT |tt|
                             (SPADCALL
                              (SPADCALL (SPADCALL |nf| (QREFELT $ 103))
                                        (SPADCALL |denf| (QREFELT $ 103))
                                        (QREFELT $ 67))
                              (QREFELT $ 48)))
                       (LETT |nf1|
                             (SPADCALL |nf|
                                       (SPADCALL (SPADCALL |tt| (QREFELT $ 45))
                                                 |denf| (QREFELT $ 97))
                                       (QREFELT $ 49)))
                       (EXIT
                        (COND
                         ((EQL (SPADCALL |nf1| (QREFELT $ 40)) 0) (LIST |tt|))
                         (#3='T NIL)))))
                     (#3# NIL)))
              (COND
               ((NULL (NULL |e_tt|))
                (SEQ (LETT |tt| (|SPADfirst| |e_tt|))
                     (LETT |nf1|
                           (SPADCALL |nf|
                                     (SPADCALL (SPADCALL |tt| (QREFELT $ 45))
                                               |denf| (QREFELT $ 97))
                                     (QREFELT $ 49)))
                     (LETT |fnf| (SPADCALL |nf1| NIL (QREFELT $ 238)))
                     (EXIT
                      (LETT |res|
                            (|RDEEFX;gamma_candidate| |fnf| |nf1| |denf|
                             |denf1| |gexp| |a| |tt| (|spadConstant| $ 102)
                             |vlst| |ulst| |k| |x| |res| $))))))
              (SEQ (LETT |fac| NIL) (LETT #2# |rfacs|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |fac| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |f1| (QVELT |fac| 1))
                        (LETT |deg1| (SPADCALL |f1| (QREFELT $ 40)))
                        (EXIT
                         (COND
                          ((EQL |deg1| 1)
                           (SEQ
                            (LETT |tt|
                                  (SPADCALL
                                   (SPADCALL (SPADCALL |f1| 0 (QREFELT $ 41))
                                             (SPADCALL |f1| 1 (QREFELT $ 41))
                                             (QREFELT $ 67))
                                   (QREFELT $ 48)))
                            (LETT |nf1|
                                  (SPADCALL |nf|
                                            (SPADCALL
                                             (SPADCALL |tt| (QREFELT $ 45))
                                             |denf| (QREFELT $ 97))
                                            (QREFELT $ 49)))
                            (EXIT
                             (COND
                              ((< (* 2 (QVELT |fac| 2))
                                  (SPADCALL |nf1| (QREFELT $ 40)))
                               "iterate")
                              ('T
                               (SEQ
                                (LETT |fnf| (SPADCALL |nf1| (QREFELT $ 240)))
                                (EXIT
                                 (LETT |res|
                                       (|RDEEFX;gamma_candidate| |fnf| |nf1|
                                        |denf| |denf1| |gexp| |a| |tt|
                                        (|spadConstant| $ 102) |vlst| |ulst|
                                        |k| |x| |res| $)))))))))
                          ((< (QVELT |fac| 2) |n2|) "iterate")
                          ((EQL |deg1| 2)
                           (SEQ
                            (LETT |tt|
                                  (SPADCALL
                                   (SPADCALL (SPADCALL |f1| 1 (QREFELT $ 41))
                                             (SPADCALL
                                              (SPADCALL 2 (QREFELT $ 74))
                                              (SPADCALL |f1| (QREFELT $ 103))
                                              (QREFELT $ 65))
                                             (QREFELT $ 67))
                                   (QREFELT $ 48)))
                            (LETT |f2|
                                  (SPADCALL |f1| (QREFELT $ 92)
                                            (SPADCALL
                                             (SPADCALL (|spadConstant| $ 32) 1
                                                       (QREFELT $ 44))
                                             (SPADCALL |tt| (QREFELT $ 45))
                                             (QREFELT $ 49))
                                            (QREFELT $ 93)))
                            (COND
                             ((NULL
                               (SPADCALL
                                (CONS #'|RDEEFX;gammas1!0| (VECTOR $ |x|))
                                (SPADCALL |f2| (QREFELT $ 94)) (QREFELT $ 96)))
                              (EXIT "iterate")))
                            (LETT |cfac| (SPADCALL |f2| (QREFELT $ 241)))
                            (LETT |nf1|
                                  (SPADCALL |nf|
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL |tt| |cfac|
                                                        (QREFELT $ 73))
                                              (QREFELT $ 45))
                                             |denf| (QREFELT $ 97))
                                            (QREFELT $ 49)))
                            (LETT |fnf| (SPADCALL |nf1| (QREFELT $ 240)))
                            (EXIT
                             (LETT |res|
                                   (|RDEEFX;gamma_candidate| |fnf| |nf1| |denf|
                                    |denf1| |gexp| |a| |tt| |f2| |vlst| |ulst|
                                    |k| |x| |res| $))))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |RDEEFX;gammas1!0| ((|c| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |c| |x| (QREFELT $ 62)) (|spadConstant| $ 43)
                      (QREFELT $ 78)))))) 

(SDEFUN |RDEEFX;special_candidates|
        ((|nf| (|SparseUnivariatePolynomial| F))
         (|denf| (|SparseUnivariatePolynomial| F))
         (|denf1| (|SparseUnivariatePolynomial| F)) (|gexp| (|Integer|))
         (|vlst| (|List| F)) (|ulst| (|List| F)) (|k| (|Kernel| F))
         (|x| (|Symbol|))
         ($
          (|List|
           (|Record| (|:| |degree| (|Integer|))
                     (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                     (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |new_f|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |radicand|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F) (|:| |a_val| F)))))
        (SPROG
         ((|res1|
           (|List|
            (|Record| (|:| |degree| (|Integer|))
                      (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                      (|:| |v_part| F)
                      (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                      (|:| |new_f|
                           (|Fraction| (|SparseUnivariatePolynomial| F)))
                      (|:| |radicand|
                           (|Fraction| (|SparseUnivariatePolynomial| F)))
                      (|:| |u_part| F) (|:| |exponent| (|Integer|))
                      (|:| |shift_part| F) (|:| |a_val| F))))
          (|nn| #1=(|SparseUnivariatePolynomial| F)) (|ri| (|Integer|))
          (|ru| (|Union| (|Integer|) "failed")) (#2=#:G1478 NIL) (|sol| NIL)
          (|lsol|
           (|List|
            (|Record| (|:| |ratpart| (|Fraction| (|Integer|)))
                      (|:| |alg_part| (|SparseUnivariatePolynomial| F)))))
          (|f_res1| (F)) (|tx_plus_b| #1#) (|bk| #3=(|Kernel| F))
          (|bs| #4=(|Symbol|)) (#5=#:G1477 NIL) (|r0| NIL)
          (|ratl| (|List| (|Fraction| (|Integer|))))
          (|nnp2| (|SparseUnivariatePolynomial| F))
          (|t3| #6=(|SparseUnivariatePolynomial| F)) (|t2| #6#) (|ct1| (F))
          (|t1| #6#) (|denf2| (|SparseUnivariatePolynomial| F))
          (|denfp2| #7=(|SparseUnivariatePolynomial| F)) (|nfp2| #7#)
          (|nnp| #1#) (|denfp1| #7#) (|nfp1| #7#) (|t| #3#) (|ts| #4#)
          (|l| (|Integer|)) (|n3| (|NonNegativeInteger|))
          (|n1| #8=(|NonNegativeInteger|)) (|a| (|Integer|)) (#9=#:G1476 NIL)
          (|rcu| (|Union| (|Integer|) "failed")) (|lc| (F)) (|n2| #8#))
         (SEQ
          (EXIT
           (SEQ
            (LETT |res1|
                  (|RDEEFX;special_ei_candidates| |nf| |denf| |vlst| |ulst| |k|
                   |x| $))
            (LETT |res1|
                  (|RDEEFX;irrational_gamma_candidates| |nf| |denf| |vlst|
                   |ulst| |k| |x| |res1| $))
            (LETT |a| 0) (LETT |n1| (SPADCALL |nf| (QREFELT $ 40)))
            (LETT |n2| (SPADCALL |denf| (QREFELT $ 40)))
            (EXIT
             (COND ((EQL |n1| 1) |res1|)
                   (#10='T
                    (SEQ
                     (COND
                      ((EQL |n1| (+ |n2| 1))
                       (COND
                        ((NULL (SPADCALL |k| '|log| (QREFELT $ 22)))
                         (PROGN (LETT #9# |res1|) (GO #11=#:G1475)))
                        ('T
                         (SEQ (LETT |lc| (SPADCALL |nf| (QREFELT $ 103)))
                              (LETT |rcu| (SPADCALL |lc| (QREFELT $ 133)))
                              (EXIT
                               (COND
                                ((QEQCAR |rcu| 1)
                                 (PROGN (LETT #9# |res1|) (GO #11#)))
                                (#10#
                                 (SEQ (LETT |a| (QCDR |rcu|))
                                      (LETT |nf|
                                            (SPADCALL |nf|
                                                      (SPADCALL
                                                       (SPADCALL
                                                        (SPADCALL |a|
                                                                  (QREFELT $
                                                                           74))
                                                        1 (QREFELT $ 44))
                                                       |denf| (QREFELT $ 97))
                                                      (QREFELT $ 46)))
                                      (EXIT (LETT |n1| |n2|)))))))))))
                     (LETT |n3| (MAX |n1| |n2|)) (LETT |l| (GCD |gexp| |n3|))
                     (EXIT
                      (COND ((EQL |l| 1) |res1|)
                            (#10#
                             (SEQ (LETT |ts| (SPADCALL (QREFELT $ 57)))
                                  (LETT |t| (SPADCALL |ts| (QREFELT $ 58)))
                                  (LETT |nfp1| (SPADCALL |nf| (QREFELT $ 192)))
                                  (LETT |denfp1|
                                        (SPADCALL |denf1| (QREFELT $ 192)))
                                  (COND
                                   ((> |n1| |n2|)
                                    (COND
                                     ((SPADCALL |k| '|log| (QREFELT $ 22))
                                      (EXIT
                                       (SEQ
                                        (LETT |nnp|
                                              (SPADCALL
                                               (SPADCALL
                                                (SPADCALL |nfp1| |denf1|
                                                          (QREFELT $ 97))
                                                (SPADCALL
                                                 (SPADCALL
                                                  (SPADCALL |gexp|
                                                            (QREFELT $ 74))
                                                  |denfp1| (QREFELT $ 136))
                                                 |nf| (QREFELT $ 97))
                                                (QREFELT $ 46))
                                               (SPADCALL
                                                (SPADCALL
                                                 (SPADCALL
                                                  (SPADCALL |t| (QREFELT $ 61))
                                                  (QREFELT $ 45))
                                                 |denf| (QREFELT $ 97))
                                                |denf1| (QREFELT $ 97))
                                               (QREFELT $ 49)))
                                        (EXIT
                                         (COND
                                          ((ODDP |l|)
                                           (SEQ
                                            (LETT |nfp2|
                                                  (SPADCALL |nfp1|
                                                            (QREFELT $ 192)))
                                            (LETT |denfp2|
                                                  (SPADCALL |denfp1|
                                                            (QREFELT $ 192)))
                                            (LETT |denf2|
                                                  (SPADCALL |denf1| |denf1|
                                                            (QREFELT $ 97)))
                                            (LETT |t1|
                                                  (SPADCALL
                                                   (SPADCALL (* 2 |gexp|)
                                                             (QREFELT $ 74))
                                                   |denfp1| (QREFELT $ 136)))
                                            (LETT |t1|
                                                  (SPADCALL
                                                   (SPADCALL |t1| |nfp1|
                                                             (QREFELT $ 97))
                                                   |denf1| (QREFELT $ 97)))
                                            (LETT |ct1|
                                                  (SPADCALL
                                                   (* (+ |gexp| 1) |gexp|)
                                                   (QREFELT $ 74)))
                                            (LETT |t2|
                                                  (SPADCALL |ct1| |denfp1|
                                                            (QREFELT $ 136)))
                                            (LETT |t2|
                                                  (SPADCALL
                                                   (SPADCALL |t2| |denfp1|
                                                             (QREFELT $ 97))
                                                   |nf| (QREFELT $ 97)))
                                            (LETT |t3|
                                                  (SPADCALL
                                                   (SPADCALL |gexp|
                                                             (QREFELT $ 74))
                                                   |denfp2| (QREFELT $ 136)))
                                            (LETT |t3|
                                                  (SPADCALL
                                                   (SPADCALL |t3| |nf|
                                                             (QREFELT $ 97))
                                                   |denf1| (QREFELT $ 97)))
                                            (LETT |nnp2|
                                                  (SPADCALL
                                                   (SPADCALL
                                                    (SPADCALL
                                                     (SPADCALL |nfp2| |denf2|
                                                               (QREFELT $ 97))
                                                     |t1| (QREFELT $ 46))
                                                    |t2| (QREFELT $ 49))
                                                   |t3| (QREFELT $ 46)))
                                            (LETT |f_res1|
                                                  (SPADCALL |nnp| |nnp2|
                                                            (QREFELT $ 193)))
                                            (LETT |ratl|
                                                  (SPADCALL |f_res1| |t|
                                                            (QREFELT $ 167)))
                                            (SEQ (LETT |r0| NIL)
                                                 (LETT #5# |ratl|) G190
                                                 (COND
                                                  ((OR (ATOM #5#)
                                                       (PROGN
                                                        (LETT |r0| (CAR #5#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (LETT |ru|
                                                        (SPADCALL |r0|
                                                                  (QREFELT $
                                                                           191)))
                                                  (EXIT
                                                   (COND
                                                    ((QEQCAR |ru| 1) "iterate")
                                                    ('T
                                                     (SEQ
                                                      (LETT |ri| (QCDR |ru|))
                                                      (LETT |nn|
                                                            (SPADCALL |nf|
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         |ri|
                                                                         (QREFELT
                                                                          $
                                                                          74))
                                                                        1
                                                                        (QREFELT
                                                                         $ 44))
                                                                       |denf|
                                                                       (QREFELT
                                                                        $ 97))
                                                                      (QREFELT
                                                                       $ 49)))
                                                      (EXIT
                                                       (LETT |res1|
                                                             (|RDEEFX;gammas1|
                                                              |nn| |ri| |denf|
                                                              |denf1| |gexp|
                                                              |n2| |vlst|
                                                              |ulst| |k| |x|
                                                              |res1| $))))))))
                                                 (LETT #5# (CDR #5#)) (GO G190)
                                                 G191 (EXIT NIL))
                                            (EXIT |res1|)))
                                          (#10#
                                           (SEQ
                                            (LETT |bs|
                                                  (SPADCALL (QREFELT $ 57)))
                                            (LETT |bk|
                                                  (SPADCALL |bs|
                                                            (QREFELT $ 58)))
                                            (LETT |tx_plus_b|
                                                  (SPADCALL
                                                   (SPADCALL
                                                    (SPADCALL |t|
                                                              (QREFELT $ 61))
                                                    1 (QREFELT $ 44))
                                                   (SPADCALL
                                                    (SPADCALL |bk|
                                                              (QREFELT $ 61))
                                                    (QREFELT $ 45))
                                                   (QREFELT $ 49)))
                                            (LETT |f_res1|
                                                  (SPADCALL |nnp|
                                                            (SPADCALL |nf|
                                                                      (SPADCALL
                                                                       |tx_plus_b|
                                                                       |denf|
                                                                       (QREFELT
                                                                        $ 97))
                                                                      (QREFELT
                                                                       $ 49))
                                                            (QREFELT $ 193)))
                                            (LETT |lsol|
                                                  (|RDEEFX;solve_poly_eqs|
                                                   (LIST |f_res1|
                                                         (SPADCALL |f_res1|
                                                                   |bs|
                                                                   (QREFELT $
                                                                            62)))
                                                   |ts| |bs| $))
                                            (SEQ (LETT |sol| NIL)
                                                 (LETT #2# |lsol|) G190
                                                 (COND
                                                  ((OR (ATOM #2#)
                                                       (PROGN
                                                        (LETT |sol| (CAR #2#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (LETT |ru|
                                                        (SPADCALL (QCAR |sol|)
                                                                  (QREFELT $
                                                                           191)))
                                                  (EXIT
                                                   (COND
                                                    ((QEQCAR |ru| 1) "iterate")
                                                    ('T
                                                     (SEQ
                                                      (LETT |ri| (QCDR |ru|))
                                                      (LETT |nn|
                                                            (SPADCALL |nf|
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         |ri|
                                                                         (QREFELT
                                                                          $
                                                                          74))
                                                                        1
                                                                        (QREFELT
                                                                         $ 44))
                                                                       |denf|
                                                                       (QREFELT
                                                                        $ 97))
                                                                      (QREFELT
                                                                       $ 49)))
                                                      (EXIT
                                                       (LETT |res1|
                                                             (|RDEEFX;gammas1|
                                                              |nn| |ri| |denf|
                                                              |denf1| |gexp|
                                                              |n2| |vlst|
                                                              |ulst| |k| |x|
                                                              |res1| $))))))))
                                                 (LETT #2# (CDR #2#)) (GO G190)
                                                 G191 (EXIT NIL))
                                            (EXIT |res1|)))))))))))
                                  (EXIT
                                   (|RDEEFX;gammas1| |nf| |a| |denf| |denf1|
                                    |gexp| |n2| |vlst| |ulst| |k| |x| |res1|
                                    $))))))))))))
          #11# (EXIT #9#)))) 

(SDEFUN |RDEEFX;finish_special_integrate2|
        ((|rr1f| (F)) (|csol| (|Vector| F)) (|a1p| (F)) (|as| (|Vector| F))
         (|scands|
          (|List|
           (|Record| (|:| |degree| (|Integer|))
                     (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                     (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |new_f|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |radicand|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F) (|:| |a_val| F))))
         (|denf| (|SparseUnivariatePolynomial| F)) (|gexp| (|Integer|))
         (|k| (|Kernel| F))
         ($
          (|Record| (|:| |ans| F) (|:| |right| F) (|:| |primpart| F)
                    (|:| |sol?| (|Boolean|)))))
        (SPROG
         ((|cand_prims| (|List| F)) (|ansp| (F)) (#1=#:G1486 NIL) (|i| NIL))
         (SEQ (LETT |cand_prims| NIL) (LETT |ansp| (|spadConstant| $ 43))
              (SEQ (LETT |i| 1) (LETT #1# (QVSIZE |as|)) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (COND
                     ((NULL |cand_prims|)
                      (SEQ
                       (LETT |cand_prims|
                             (|RDEEFX;get_prims| (|SPADfirst| |scands|) |denf|
                              |denf| |gexp| |k| $))
                       (EXIT (LETT |scands| (CDR |scands|))))))
                    (LETT |a1p|
                          (SPADCALL |a1p|
                                    (SPADCALL
                                     (SPADCALL |csol| |i| (QREFELT $ 242))
                                     (SPADCALL |as| |i| (QREFELT $ 242))
                                     (QREFELT $ 65))
                                    (QREFELT $ 77)))
                    (LETT |ansp|
                          (SPADCALL |ansp|
                                    (SPADCALL
                                     (SPADCALL |csol| |i| (QREFELT $ 242))
                                     (|SPADfirst| |cand_prims|) (QREFELT $ 65))
                                    (QREFELT $ 73)))
                    (EXIT (LETT |cand_prims| (CDR |cand_prims|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (VECTOR |a1p| |rr1f| |ansp| 'T))))) 

(SDEFUN |RDEEFX;finish_special_integrate|
        ((|rr1f| (F)) (|a1p| (F)) (|vs| (|Vector| F)) (|as| (|Vector| F))
         (|scands|
          (|List|
           (|Record| (|:| |degree| (|Integer|))
                     (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                     (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |new_f|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |radicand|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F) (|:| |a_val| F))))
         (|denf| (|SparseUnivariatePolynomial| F)) (|gexp| (|Integer|))
         (|k| (|Kernel| F)) (|x| (|Symbol|))
         ($
          (|Record| (|:| |ans| F) (|:| |right| F) (|:| |primpart| F)
                    (|:| |sol?| (|Boolean|)))))
        (SPROG
         ((|csol| (|Vector| F)) (|csolu| (|Union| (|Vector| F) "failed")))
         (SEQ
          (LETT |csolu|
                (SPADCALL |vs| |rr1f|
                          (LIST
                           (CONS #'|RDEEFX;finish_special_integrate!0|
                                 (VECTOR $ |x|)))
                          (QREFELT $ 247)))
          (EXIT
           (COND
            ((QEQCAR |csolu| 1)
             (VECTOR (|spadConstant| $ 43) (|spadConstant| $ 43)
                     (|spadConstant| $ 43) NIL))
            ('T
             (SEQ (LETT |csol| (QCDR |csolu|))
                  (EXIT
                   (|RDEEFX;finish_special_integrate2| |rr1f| |csol| |a1p| |as|
                    |scands| |denf| |gexp| |k| $))))))))) 

(SDEFUN |RDEEFX;finish_special_integrate!0| ((|c| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |c| |x| (QREFELT $ 62)))))) 

(SDEFUN |RDEEFX;exp_lower_bound|
        ((|nfp| (|SparseUnivariatePolynomial| F)) (|eta| (F))
         (|rr1| (|Fraction| (|SparseUnivariatePolynomial| F)))
         (|scoeffs| (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
         (|x| (|Symbol|)) (|lk| (|List| (|Kernel| F))) ($ (|Integer|)))
        (SPROG
         ((|min_deg| (|Integer|)) (|max_deg| (|Integer|))
          (|c_degs| (|List| (|NonNegativeInteger|))) (#1=#:G1513 NIL)
          (|scoeff| NIL) (#2=#:G1512 NIL)
          (|b| (|LaurentPolynomial| F (|SparseUnivariatePolynomial| F)))
          (|logi|
           (|Mapping|
            (|Record| (|:| |logands| (|List| F))
                      (|:| |basis|
                           (|List| (|Vector| (|Fraction| (|Integer|))))))
            (|List| (|Kernel| F)) (|List| F))))
         (SEQ (LETT |logi| (CONS #'|RDEEFX;exp_lower_bound!0| (VECTOR $ |x|)))
              (LETT |b| (SPADCALL |nfp| (QREFELT $ 252)))
              (LETT |c_degs|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |scoeff| NIL) (LETT #1# |scoeffs|) G190
                          (COND
                           ((OR (ATOM #1#)
                                (PROGN (LETT |scoeff| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS
                                   (SPADCALL (SPADCALL |scoeff| (QREFELT $ 39))
                                             (QREFELT $ 40))
                                   #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (LETT |c_degs|
                    (CONS
                     (SPADCALL (SPADCALL |rr1| (QREFELT $ 39)) (QREFELT $ 40))
                     |c_degs|))
              (LETT |max_deg| (SPADCALL (ELT $ 254) |c_degs| (QREFELT $ 257)))
              (LETT |min_deg| (SPADCALL |nfp| (QREFELT $ 216)))
              (EXIT
               (SPADCALL (|spadConstant| $ 108) |b| |min_deg| (- |max_deg|)
                         |lk| |eta| |logi| (QREFELT $ 260)))))) 

(SDEFUN |RDEEFX;exp_lower_bound!0| ((|x2| NIL) (|x3| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |x2| |x3| (QREFELT $ 250)))))) 

(SDEFUN |RDEEFX;special_integrate2|
        ((|nfp| (|SparseUnivariatePolynomial| F))
         (|denfp| (|SparseUnivariatePolynomial| F))
         (|denf| (|SparseUnivariatePolynomial| F))
         (|ndenf| (|SparseUnivariatePolynomial| F)) (|f| (F))
         (|k| (|Kernel| F)) (|lk| (|List| (|Kernel| F))) (|x| (|Symbol|))
         (|rr1| (|Fraction| (|SparseUnivariatePolynomial| F))) (|a1| (F))
         (|r1| (F)) (|g| (F))
         (|scoeffs| (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
         (|scands|
          (|List|
           (|Record| (|:| |degree| (|Integer|))
                     (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                     (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |new_f|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |radicand|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F) (|:| |a_val| F))))
         (|gexp| (|Integer|))
         ($
          (|Record| (|:| |ans| F) (|:| |right| F) (|:| |primpart| F)
                    (|:| |sol?| (|Boolean|)))))
        (SPROG
         ((|as| (|Vector| F))
          (|part| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
          (|partu|
           (|Union| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))
                    "failed"))
          (|g1| (F)) (|lg1| (|List| F)) (#1=#:G1524 NIL) (|scoeff| NIL)
          (#2=#:G1523 NIL))
         (SEQ
          (LETT |lg1|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |scoeff| NIL) (LETT #1# |scoeffs|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |scoeff| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL |scoeff| |k| (QREFELT $ 60))
                                    #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (LETT |g1| (SPADCALL |rr1| |k| (QREFELT $ 60)))
          (LETT |partu|
                (SPADCALL |f| |g1| |lg1| |x| (CONS |k| |lk|) (QREFELT $ 263)))
          (EXIT
           (COND
            ((QEQCAR |partu| 1)
             (VECTOR (|spadConstant| $ 43) (|spadConstant| $ 43)
                     (|spadConstant| $ 43) NIL))
            ('T
             (SEQ (LETT |part| (QCDR |partu|))
                  (LETT |as|
                        (MAKEARR1 (LENGTH |scoeffs|) (|spadConstant| $ 43)))
                  (EXIT
                   (|RDEEFX;finish_special_integrate2| |g1| (QCDR |part|)
                    (QCAR |part|) |as| |scands| |denf| |gexp| |k| $))))))))) 

(SDEFUN |RDEEFX;do_spde1|
        ((|rr1| (|Fraction| (|SparseUnivariatePolynomial| F)))
         (|nfp| (|SparseUnivariatePolynomial| F)) (|k| (|Kernel| F))
         (|der|
          (|Mapping| (|SparseUnivariatePolynomial| F)
                     (|SparseUnivariatePolynomial| F)))
         ($
          (|Record| (|:| |ans| F) (|:| |defect| F) (|:| |sol?| (|Boolean|)))))
        (SPROG
         ((|def_f| (F)) (|af| (F)) (|r2| (|SparseUnivariatePolynomial| F))
          (|a1| #1=(|SparseUnivariatePolynomial| F))
          (|res1|
           (|Record| (|:| |ans| #1#)
                     (|:| |remainder| (|SparseUnivariatePolynomial| F))))
          (|spec1p| (|SparseUnivariatePolynomial| F))
          (|spec1u| (|Union| (|SparseUnivariatePolynomial| F) "failed")))
         (SEQ (LETT |spec1u| (SPADCALL |rr1| (QREFELT $ 265)))
              (EXIT
               (COND ((QEQCAR |spec1u| 1) (|error| "impossible 7"))
                     ('T
                      (SEQ (LETT |spec1p| (QCDR |spec1u|))
                           (LETT |res1|
                                 (SPADCALL |nfp| |spec1p| |der|
                                           (QREFELT $ 269)))
                           (LETT |a1| (QCAR |res1|))
                           (LETT |r2|
                                 (SPADCALL (SPADCALL |a1| |der|)
                                           (SPADCALL |nfp| |a1| (QREFELT $ 97))
                                           (QREFELT $ 49)))
                           (LETT |af|
                                 (SPADCALL (SPADCALL |a1| (QREFELT $ 47)) |k|
                                           (QREFELT $ 60)))
                           (LETT |def_f|
                                 (SPADCALL
                                  (SPADCALL |rr1|
                                            (SPADCALL |r2| (QREFELT $ 47))
                                            (QREFELT $ 270))
                                  |k| (QREFELT $ 60)))
                           (EXIT
                            (VECTOR |af| |def_f|
                                    (SPADCALL (QCDR |res1|)
                                              (|spadConstant| $ 102)
                                              (QREFELT $ 111))))))))))) 

(SDEFUN |RDEEFX;special_integrate1|
        ((|nfp| #1=(|SparseUnivariatePolynomial| F)) (|f| (F))
         (|k| (|Kernel| F)) (|lk| (|List| (|Kernel| F))) (|x| (|Symbol|))
         (|rr1| (|Fraction| (|SparseUnivariatePolynomial| F))) (|a1| (F))
         (|r1| (F)) (|g| (F)) (|ansp| (F))
         (|scoeffs| (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
         (|scands|
          (|List|
           (|Record| (|:| |degree| (|Integer|))
                     (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                     (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |new_f|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |radicand|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F) (|:| |a_val| F))))
         (|gexp| (|Integer|))
         (|derivation|
          (|Mapping| (|SparseUnivariatePolynomial| F)
                     (|SparseUnivariatePolynomial| F)))
         ($
          (|Record| (|:| |ans| F) (|:| |right| F) (|:| |primpart| F)
                    (|:| |sol?| (|Boolean|)))))
        (SPROG
         ((|res3|
           (|Record| (|:| |ans| F) (|:| |right| F) (|:| |primpart| F)
                     (|:| |sol?| (|Boolean|))))
          (|res2|
           (|Record| (|:| |ans| F) (|:| |defect| F) (|:| |sol?| (|Boolean|))))
          (#2=#:G1554 NIL) (|scoeff| NIL) (#3=#:G1555 NIL) (|i| NIL)
          (|as| #4=(|Vector| F)) (|vs| #4#) (|rr1f| (F)) (|a1p| (F))
          (|inv_den1| (F)) (|nfp1| #1#) (|ak| (F)) (#5=#:G1553 NIL)
          (#6=#:G1552 NIL) (|mm| (|SparseUnivariatePolynomial| F))
          (#7=#:G1539 NIL) (|neg_deg| (|Integer|)) (|eta| (F))
          (#8=#:G1535 NIL))
         (SEQ
          (LETT |neg_deg|
                (COND
                 ((SPADCALL |k| '|exp| (QREFELT $ 22))
                  (SEQ
                   (LETT |eta|
                         (SPADCALL
                          (PROG2
                              (LETT #8#
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL (|spadConstant| $ 32) 1
                                                (QREFELT $ 44))
                                      |derivation|)
                                     (SPADCALL (|spadConstant| $ 32) 1
                                               (QREFELT $ 44))
                                     (QREFELT $ 107)))
                              (QCDR #8#)
                            (|check_union2| (QEQCAR #8# 0)
                                            (|SparseUnivariatePolynomial|
                                             (QREFELT $ 7))
                                            (|Union|
                                             (|SparseUnivariatePolynomial|
                                              (QREFELT $ 7))
                                             "failed")
                                            #8#))
                          (QREFELT $ 202)))
                   (EXIT
                    (-
                     (|RDEEFX;exp_lower_bound| |nfp| |eta| |rr1| |scoeffs| |x|
                      |lk| $)))))
                 (#9='T 0)))
          (LETT |nfp1| |nfp|) (LETT |inv_den1| (|spadConstant| $ 32))
          (COND
           ((> |neg_deg| 0)
            (SEQ
             (LETT |mm|
                   (SPADCALL (|spadConstant| $ 32)
                             (PROG1 (LETT #7# |neg_deg|)
                               (|check_subtype2| (>= #7# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #7#))
                             (QREFELT $ 44)))
             (LETT |scoeffs|
                   (PROGN
                    (LETT #6# NIL)
                    (SEQ (LETT |scoeff| NIL) (LETT #5# |scoeffs|) G190
                         (COND
                          ((OR (ATOM #5#)
                               (PROGN (LETT |scoeff| (CAR #5#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT #6#
                                 (CONS (SPADCALL |mm| |scoeff| (QREFELT $ 271))
                                       #6#))))
                         (LETT #5# (CDR #5#)) (GO G190) G191
                         (EXIT (NREVERSE #6#)))))
             (LETT |rr1| (SPADCALL |mm| |rr1| (QREFELT $ 271)))
             (LETT |ak|
                   (SPADCALL (SPADCALL |k| (QREFELT $ 27)) 1 (QREFELT $ 29)))
             (LETT |nfp1|
                   (SPADCALL |nfp|
                             (SPADCALL
                              (SPADCALL (SPADCALL |neg_deg| (QREFELT $ 74))
                                        (SPADCALL |ak| |x| (QREFELT $ 62))
                                        (QREFELT $ 65))
                              (QREFELT $ 45))
                             (QREFELT $ 46)))
             (EXIT
              (LETT |inv_den1|
                    (SPADCALL
                     (SPADCALL (|spadConstant| $ 272)
                               (SPADCALL |mm| (QREFELT $ 47)) (QREFELT $ 50))
                     |k| (QREFELT $ 60)))))))
          (LETT |res2| (|RDEEFX;do_spde1| |rr1| |nfp1| |k| |derivation| $))
          (LETT |a1p| (SPADCALL |inv_den1| (QVELT |res2| 0) (QREFELT $ 65)))
          (EXIT
           (COND
            ((QVELT |res2| 2)
             (VECTOR (SPADCALL |a1| |a1p| (QREFELT $ 73)) |g| |ansp| 'T))
            (#9#
             (SEQ (LETT |rr1f| (QVELT |res2| 1))
                  (LETT |vs|
                        (MAKEARR1 (LENGTH |scoeffs|) (|spadConstant| $ 43)))
                  (LETT |as|
                        (MAKEARR1 (LENGTH |scoeffs|) (|spadConstant| $ 43)))
                  (SEQ (LETT |i| 1) (LETT #3# (LENGTH |scoeffs|))
                       (LETT |scoeff| NIL) (LETT #2# |scoeffs|) G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |scoeff| (CAR #2#)) NIL)
                             (|greater_SI| |i| #3#))
                         (GO G191)))
                       (SEQ
                        (LETT |res2|
                              (|RDEEFX;do_spde1| |scoeff| |nfp1| |k|
                               |derivation| $))
                        (SPADCALL |as| |i|
                                  (SPADCALL |inv_den1| (QVELT |res2| 0)
                                            (QREFELT $ 65))
                                  (QREFELT $ 273))
                        (EXIT
                         (SPADCALL |vs| |i| (QVELT |res2| 1) (QREFELT $ 273))))
                       (LETT #2# (PROG1 (CDR #2#) (LETT |i| (|inc_SI| |i|))))
                       (GO G190) G191 (EXIT NIL))
                  (LETT |res3|
                        (|RDEEFX;finish_special_integrate| |rr1f| |a1p| |vs|
                         |as| |scands| (|spadConstant| $ 108) |gexp| |k| |x|
                         $))
                  (COND
                   ((NULL (QVELT |res3| 3))
                    (EXIT
                     (COND ((> |neg_deg| 0) (VECTOR |a1| |r1| |ansp| NIL))
                           (#9#
                            (VECTOR (SPADCALL |a1| |a1p| (QREFELT $ 73))
                                    (SPADCALL |g| |rr1f| (QREFELT $ 77)) |ansp|
                                    NIL))))))
                  (EXIT
                   (VECTOR (SPADCALL |a1| (QVELT |res3| 0) (QREFELT $ 73)) |g|
                           (SPADCALL |ansp| (QVELT |res3| 2) (QREFELT $ 73))
                           'T))))))))) 

(SDEFUN |RDEEFX;mk_pow1| ((|u| (F)) (|i| (|Integer|)) ($ (F)))
        (SPADCALL |u| |i| (QREFELT $ 79))) 

(SDEFUN |RDEEFX;mk_pow|
        ((|uu| (F)) (|ulst| (|List| F)) (|v| (|Vector| (|Integer|))) ($ (F)))
        (SPROG
         ((|res2| (F)) (|lp| (|List| F)) (#1=#:G1578 NIL) (|ui| NIL) (|i| NIL)
          (#2=#:G1577 NIL) (|res| (F)))
         (SEQ
          (LETT |res|
                (|RDEEFX;mk_pow1| |uu| (SPADCALL |v| 1 (QREFELT $ 116)) $))
          (LETT |lp|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| 2) (LETT |ui| NIL) (LETT #1# |ulst|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |ui| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (|RDEEFX;mk_pow1| |ui|
                                (SPADCALL |v| |i| (QREFELT $ 116)) $)
                               #2#))))
                      (LETT #1# (PROG1 (CDR #1#) (LETT |i| (|inc_SI| |i|))))
                      (GO G190) G191 (EXIT (NREVERSE #2#)))))
          (LETT |res2|
                (SPADCALL (ELT $ 65) |lp| (|spadConstant| $ 32)
                          (QREFELT $ 76)))
          (EXIT (SPADCALL |res| |res2| (QREFELT $ 65)))))) 

(SDEFUN |RDEEFX;quadratic_log_erf_integrate|
        ((|nf| (|SparseUnivariatePolynomial| F))
         (|nfp| (|SparseUnivariatePolynomial| F))
         (|rr1| (|Fraction| (|SparseUnivariatePolynomial| F))) (|a1| (F))
         (|g| (F)) (|ansp| (F))
         (|derivation|
          (|Mapping| (|SparseUnivariatePolynomial| F)
                     (|SparseUnivariatePolynomial| F)))
         (|vlst| (|List| F)) (|ulst| (|List| F)) (|k| (|Kernel| F))
         (|lk| (|List| (|Kernel| F))) (|x| (|Symbol|))
         ($
          (|Record| (|:| |ans| F) (|:| |right| F) (|:| |primpart| F)
                    (|:| |sol?| (|Boolean|)))))
        (SPROG
         ((|as| (|Vector| F)) (|vc| #1=(|Vector| F)) (#2=#:G1719 NIL)
          (|ci| NIL) (#3=#:G1718 NIL)
          (|cndl|
           (|List|
            (|Record| (|:| |degree| (|Integer|))
                      (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                      (|:| |v_part| F)
                      (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                      (|:| |new_f|
                           (|Fraction| (|SparseUnivariatePolynomial| F)))
                      (|:| |radicand|
                           (|Fraction| (|SparseUnivariatePolynomial| F)))
                      (|:| |u_part| F) (|:| |exponent| (|Integer|))
                      (|:| |shift_part| F) (|:| |a_val| F))))
          (|rr| (|Integer|)) (|ii| (|Integer|)) (#4=#:G1717 NIL)
          (|cil| (|List| (|List| F)))
          (|cis| (|Union| (|List| (|List| F)) "failed")) (|u1| (F)) (|u0| (F))
          (|uu| (F)) (|solb1| (|Vector| (|Integer|))) (|f| (F))
          (|scoeffs| (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|derivation3|
           (|Mapping| (|Fraction| (|SparseUnivariatePolynomial| F))
                      (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|cands|
           (|List|
            (|Record| (|:| |degree| (|Integer|))
                      (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                      (|:| |v_part| F)
                      (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                      (|:| |new_f|
                           (|Fraction| (|SparseUnivariatePolynomial| F)))
                      (|:| |radicand|
                           (|Fraction| (|SparseUnivariatePolynomial| F)))
                      (|:| |u_part| F) (|:| |exponent| (|Integer|))
                      (|:| |shift_part| F) (|:| |a_val| F))))
          (|nn| (|SparseUnivariatePolynomial| F)) (|ri| (|Integer|))
          (|rcu| (|Union| (|Integer|) #5="failed")) (#6=#:G1704 NIL)
          (|sol0| (|Vector| (|Integer|))) (#7=#:G1669 NIL)
          (|sol_rec|
           (|Record|
            (|:| |particular| (|Union| (|Vector| (|Integer|)) #8="failed"))
            (|:| |basis| (|List| (|Vector| (|Integer|))))))
          (|v2| #9=(|Vector| (|Integer|))) (|m2| #10=(|Matrix| (|Integer|)))
          (|#G328| (|Record| (|:| |mat| #10#) (|:| |vec| #9#))) (|v1| #1#)
          (|m1| (|Matrix| F)) (#11=#:G1716 NIL) (|v| NIL) (#12=#:G1715 NIL)
          (|lv| (|List| F)) (|c2| (F)) (|c1| (F)) (|c0| (F)) (|r4| (F))
          (|ulst1| (|List| F)) (|vlst1| (|List| F)) (#13=#:G1713 NIL)
          (#14=#:G1714 NIL) (|u| NIL) (|phi| (F)) (|piv| (F)) (|kf| (F))
          (|unG| (R)) (G (F))
          (|G_num| #15=(|SparseMultivariatePolynomial| R (|Kernel| F)))
          (|G_den| #15#)
          (|fl2| (|List| #16=(|SparseMultivariatePolynomial| R (|Kernel| F))))
          (#17=#:G1712 NIL) (|fac| NIL) (#18=#:G1711 NIL) (|fl1| (|List| #16#))
          (#19=#:G1604 NIL) (#20=#:G1710 NIL) (#21=#:G1709 NIL)
          (|uv0|
           (|Record| (|:| |u_part| F) (|:| |v_part| F)
                     (|:| |exponent| (|Integer|)) (|:| |coeff| (|Integer|))))
          (|uvu0|
           (|Union|
            (|Record| (|:| |u_part| F) (|:| |v_part| F)
                      (|:| |exponent| (|Integer|)) (|:| |coeff| (|Integer|)))
            "failed"))
          (|l_pifp| (F)) (|pif| (F))
          (|pip| (|SparseMultivariatePolynomial| R (|Kernel| F)))
          (#22=#:G1708 NIL) (#23=#:G1707 NIL) (#24=#:G1706 NIL)
          (#25=#:G1705 NIL)
          (|f_numr|
           #26=(|Factored| (|SparseMultivariatePolynomial| R (|Kernel| F))))
          (|f_denr| #26#) (|t| (F)) (|s| (F)) (|r| (F)) (|r1| (F))
          (|spec1p| (|SparseUnivariatePolynomial| F))
          (|res2|
           (|Record| (|:| |ans| (|SparseUnivariatePolynomial| F))
                     (|:| |remainder| (|SparseUnivariatePolynomial| F))))
          (|spec1u| (|Union| (|SparseUnivariatePolynomial| F) #5#)))
         (SEQ
          (EXIT
           (SEQ (LETT |spec1u| (SPADCALL |rr1| (QREFELT $ 265)))
                (EXIT
                 (COND ((QEQCAR |spec1u| 1) (|error| "impossible 10"))
                       (#27='T
                        (SEQ (LETT |spec1p| (QCDR |spec1u|))
                             (LETT |res2|
                                   (SPADCALL |nfp| |spec1p| |derivation|
                                             (QREFELT $ 269)))
                             (LETT |a1|
                                   (SPADCALL |a1|
                                             (SPADCALL
                                              (SPADCALL (QCAR |res2|)
                                                        (QREFELT $ 47))
                                              |k| (QREFELT $ 60))
                                             (QREFELT $ 73)))
                             (LETT |spec1p| (QCDR |res2|))
                             (EXIT
                              (COND
                               ((SPADCALL |spec1p| (|spadConstant| $ 102)
                                          (QREFELT $ 111))
                                (PROGN
                                 (LETT #6# (VECTOR |a1| |g| |ansp| 'T))
                                 (GO #28=#:G1703)))
                               ((>= (SPADCALL |spec1p| (QREFELT $ 40))
                                    (SPADCALL |nfp| (QREFELT $ 40)))
                                (|error| "impossible 8"))
                               (#27#
                                (SEQ
                                 (LETT |r1|
                                       (SPADCALL |g|
                                                 (SPADCALL
                                                  (SPADCALL |spec1p|
                                                            (QREFELT $ 47))
                                                  |k| (QREFELT $ 60))
                                                 (QREFELT $ 77)))
                                 (LETT |r| (SPADCALL |nf| (QREFELT $ 103)))
                                 (LETT |s| (SPADCALL |nf| 1 (QREFELT $ 41)))
                                 (LETT |t| (SPADCALL |nf| 0 (QREFELT $ 41)))
                                 (LETT |f_denr|
                                       (SPADCALL (SPADCALL |r| (QREFELT $ 274))
                                                 (QREFELT $ 277)))
                                 (LETT |f_numr|
                                       (SPADCALL (SPADCALL |r| (QREFELT $ 178))
                                                 (QREFELT $ 277)))
                                 (LETT |fl1|
                                       (PROGN
                                        (LETT #25# NIL)
                                        (SEQ (LETT |fac| NIL)
                                             (LETT #24#
                                                   (SPADCALL |f_denr|
                                                             (QREFELT $ 280)))
                                             G190
                                             (COND
                                              ((OR (ATOM #24#)
                                                   (PROGN
                                                    (LETT |fac| (CAR #24#))
                                                    NIL))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (COND
                                                ((ODDP (QVELT |fac| 2))
                                                 (LETT #25#
                                                       (CONS (QVELT |fac| 1)
                                                             #25#))))))
                                             (LETT #24# (CDR #24#)) (GO G190)
                                             G191 (EXIT (NREVERSE #25#)))))
                                 (LETT |fl2|
                                       (PROGN
                                        (LETT #23# NIL)
                                        (SEQ (LETT |fac| NIL)
                                             (LETT #22#
                                                   (SPADCALL |f_numr|
                                                             (QREFELT $ 280)))
                                             G190
                                             (COND
                                              ((OR (ATOM #22#)
                                                   (PROGN
                                                    (LETT |fac| (CAR #22#))
                                                    NIL))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (COND
                                                ((ODDP (QVELT |fac| 2))
                                                 (LETT #23#
                                                       (CONS (QVELT |fac| 1)
                                                             #23#))))))
                                             (LETT #22# (CDR #22#)) (GO G190)
                                             G191 (EXIT (NREVERSE #23#)))))
                                 (LETT |pip|
                                       (SPADCALL
                                        (SPADCALL (ELT $ 282) |fl1|
                                                  (|spadConstant| $ 135)
                                                  (QREFELT $ 285))
                                        (SPADCALL (ELT $ 282) |fl2|
                                                  (|spadConstant| $ 135)
                                                  (QREFELT $ 285))
                                        (QREFELT $ 282)))
                                 (LETT |pif| (SPADCALL |pip| (QREFELT $ 179)))
                                 (LETT |l_pifp|
                                       (SPADCALL
                                        (SPADCALL |pif| |x| (QREFELT $ 62))
                                        |pif| (QREFELT $ 67)))
                                 (LETT |uvu0|
                                       (|RDEEFX;get_uv| |l_pifp| |vlst| |ulst|
                                        |k| |x| $))
                                 (EXIT
                                  (COND
                                   ((QEQCAR |uvu0| 1)
                                    (VECTOR |a1| |r1| |ansp| NIL))
                                   (#27#
                                    (SEQ (LETT |uv0| (QCDR |uvu0|))
                                         (LETT |fl1|
                                               (PROGN
                                                (LETT #21# NIL)
                                                (SEQ (LETT |fac| NIL)
                                                     (LETT #20#
                                                           (SPADCALL |f_denr|
                                                                     (QREFELT $
                                                                              280)))
                                                     G190
                                                     (COND
                                                      ((OR (ATOM #20#)
                                                           (PROGN
                                                            (LETT |fac|
                                                                  (CAR #20#))
                                                            NIL))
                                                       (GO G191)))
                                                     (SEQ
                                                      (EXIT
                                                       (LETT #21#
                                                             (CONS
                                                              (SPADCALL
                                                               (QVELT |fac| 1)
                                                               (PROG1
                                                                   (LETT #19#
                                                                         (QUOTIENT2
                                                                          (-
                                                                           (QVELT
                                                                            |fac|
                                                                            2)
                                                                           1)
                                                                          2))
                                                                 (|check_subtype2|
                                                                  (>= #19# 0)
                                                                  '(|NonNegativeInteger|)
                                                                  '(|Integer|)
                                                                  #19#))
                                                               (QREFELT $ 287))
                                                              #21#))))
                                                     (LETT #20# (CDR #20#))
                                                     (GO G190) G191
                                                     (EXIT (NREVERSE #21#)))))
                                         (LETT |fl2|
                                               (PROGN
                                                (LETT #18# NIL)
                                                (SEQ (LETT |fac| NIL)
                                                     (LETT #17#
                                                           (SPADCALL |f_numr|
                                                                     (QREFELT $
                                                                              280)))
                                                     G190
                                                     (COND
                                                      ((OR (ATOM #17#)
                                                           (PROGN
                                                            (LETT |fac|
                                                                  (CAR #17#))
                                                            NIL))
                                                       (GO G191)))
                                                     (SEQ
                                                      (EXIT
                                                       (LETT #18#
                                                             (CONS
                                                              (SPADCALL
                                                               (QVELT |fac| 1)
                                                               (QUOTIENT2
                                                                (+
                                                                 (QVELT |fac|
                                                                        2)
                                                                 1)
                                                                2)
                                                               (QREFELT $ 287))
                                                              #18#))))
                                                     (LETT #17# (CDR #17#))
                                                     (GO G190) G191
                                                     (EXIT (NREVERSE #18#)))))
                                         (LETT |G_den|
                                               (SPADCALL (ELT $ 282) |fl1|
                                                         (|spadConstant| $ 135)
                                                         (QREFELT $ 285)))
                                         (LETT |G_num|
                                               (SPADCALL (ELT $ 282) |fl2|
                                                         (|spadConstant| $ 135)
                                                         (QREFELT $ 285)))
                                         (LETT G
                                               (SPADCALL
                                                (SPADCALL |G_den|
                                                          (QREFELT $ 179))
                                                (SPADCALL |G_num|
                                                          (QREFELT $ 179))
                                                (QREFELT $ 67)))
                                         (LETT |unG|
                                               (SPADCALL
                                                (SPADCALL |f_numr|
                                                          (QREFELT $ 288))
                                                (QREFELT $ 289)))
                                         (LETT |kf|
                                               (SPADCALL |k| (QREFELT $ 61)))
                                         (LETT |phi|
                                               (COND
                                                ((SPADCALL
                                                  (SPADCALL |r| |x|
                                                            (QREFELT $ 62))
                                                  (|spadConstant| $ 43)
                                                  (QREFELT $ 131))
                                                 (SEQ
                                                  (LETT |piv|
                                                        (SPADCALL
                                                         (SPADCALL G |x|
                                                                   (QREFELT $
                                                                            62))
                                                         (SPADCALL
                                                          (SPADCALL G |l_pifp|
                                                                    (QREFELT $
                                                                             65))
                                                          (SPADCALL 2
                                                                    (QREFELT $
                                                                             74))
                                                          (QREFELT $ 67))
                                                         (QREFELT $ 77)))
                                                  (EXIT
                                                   (SPADCALL
                                                    (SPADCALL |spec1p| 1
                                                              (QREFELT $ 41))
                                                    |piv| (QREFELT $ 67)))))
                                                (#27#
                                                 (SEQ
                                                  (LETT |piv|
                                                        (SPADCALL
                                                         (SPADCALL G
                                                                   (SPADCALL
                                                                    |kf| |x|
                                                                    (QREFELT $
                                                                             62))
                                                                   (QREFELT $
                                                                            65))
                                                         (SPADCALL
                                                          (SPADCALL |unG|
                                                                    (SPADCALL
                                                                     |s| |x|
                                                                     (QREFELT $
                                                                              62))
                                                                    (QREFELT $
                                                                             290))
                                                          (SPADCALL
                                                           (SPADCALL 2
                                                                     (QREFELT $
                                                                              74))
                                                           G (QREFELT $ 65))
                                                          (QREFELT $ 67))
                                                         (QREFELT $ 73)))
                                                  (EXIT
                                                   (SPADCALL
                                                    (SPADCALL |spec1p| 0
                                                              (QREFELT $ 41))
                                                    |piv| (QREFELT $ 67)))))))
                                         (LETT |vlst1| NIL) (LETT |ulst1| NIL)
                                         (SEQ (LETT |u| NIL) (LETT #14# |ulst|)
                                              (LETT |v| NIL) (LETT #13# |vlst|)
                                              G190
                                              (COND
                                               ((OR (ATOM #13#)
                                                    (PROGN
                                                     (LETT |v| (CAR #13#))
                                                     NIL)
                                                    (ATOM #14#)
                                                    (PROGN
                                                     (LETT |u| (CAR #14#))
                                                     NIL))
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (COND
                                                 ((SPADCALL |v| |kf|
                                                            (QREFELT $ 131))
                                                  (SEQ
                                                   (LETT |vlst1|
                                                         (CONS |v| |vlst1|))
                                                   (EXIT
                                                    (LETT |ulst1|
                                                          (CONS |u|
                                                                |ulst1|))))))))
                                              (LETT #13#
                                                    (PROG1 (CDR #13#)
                                                      (LETT #14# (CDR #14#))))
                                              (GO G190) G191 (EXIT NIL))
                                         (LETT |r4|
                                               (SPADCALL
                                                (SPADCALL 4 (QREFELT $ 74)) |r|
                                                (QREFELT $ 65)))
                                         (LETT |c0|
                                               (SPADCALL
                                                (SPADCALL
                                                 (SPADCALL |s| 2
                                                           (QREFELT $ 292))
                                                 |r4| (QREFELT $ 67))
                                                |t| (QREFELT $ 77)))
                                         (LETT |c1|
                                               (SPADCALL |s| |r4|
                                                         (QREFELT $ 67)))
                                         (LETT |c2|
                                               (SPADCALL (|spadConstant| $ 32)
                                                         |r4| (QREFELT $ 67)))
                                         (LETT |lv|
                                               (COND
                                                ((SPADCALL
                                                  (SPADCALL |r| |x|
                                                            (QREFELT $ 62))
                                                  (|spadConstant| $ 43)
                                                  (QREFELT $ 131))
                                                 (SPADCALL
                                                  (LIST
                                                   (SPADCALL |c1|
                                                             (QREFELT $ 48))
                                                   (SPADCALL |c2|
                                                             (QREFELT $ 48)))
                                                  |vlst1| (QREFELT $ 293)))
                                                (#27#
                                                 (CONS
                                                  (SPADCALL |c1|
                                                            (QREFELT $ 48))
                                                  |vlst1|))))
                                         (LETT |m1|
                                               (SPADCALL
                                                (LIST
                                                 (PROGN
                                                  (LETT #12# NIL)
                                                  (SEQ (LETT |v| NIL)
                                                       (LETT #11# |lv|) G190
                                                       (COND
                                                        ((OR (ATOM #11#)
                                                             (PROGN
                                                              (LETT |v|
                                                                    (CAR #11#))
                                                              NIL))
                                                         (GO G191)))
                                                       (SEQ
                                                        (EXIT
                                                         (LETT #12#
                                                               (CONS
                                                                (SPADCALL |v|
                                                                          |x|
                                                                          (QREFELT
                                                                           $
                                                                           62))
                                                                #12#))))
                                                       (LETT #11# (CDR #11#))
                                                       (GO G190) G191
                                                       (EXIT
                                                        (NREVERSE #12#)))))
                                                (QREFELT $ 295)))
                                         (LETT |v1|
                                               (SPADCALL
                                                (LIST
                                                 (SPADCALL |c0| |x|
                                                           (QREFELT $ 62)))
                                                (QREFELT $ 81)))
                                         (PROGN
                                          (LETT |#G328|
                                                (SPADCALL |m1| |v1|
                                                          (QREFELT $ 299)))
                                          (LETT |m2| (QCAR |#G328|))
                                          (LETT |v2| (QCDR |#G328|))
                                          |#G328|)
                                         (LETT |sol_rec|
                                               (SPADCALL |m2| |v2|
                                                         (QREFELT $ 304)))
                                         (EXIT
                                          (COND
                                           ((QEQCAR (QCAR |sol_rec|) 1)
                                            (VECTOR |a1| |r1| |ansp| NIL))
                                           (#27#
                                            (SEQ
                                             (LETT |sol0|
                                                   (PROG2
                                                       (LETT #7#
                                                             (QCAR |sol_rec|))
                                                       (QCDR #7#)
                                                     (|check_union2|
                                                      (QEQCAR #7# 0)
                                                      (|Vector| (|Integer|))
                                                      (|Union|
                                                       (|Vector| (|Integer|))
                                                       #8#)
                                                      #7#)))
                                             (EXIT
                                              (COND
                                               ((NULL (QCDR |sol_rec|))
                                                (SEQ
                                                 (COND
                                                  ((SPADCALL
                                                    (SPADCALL |r| |x|
                                                              (QREFELT $ 62))
                                                    (|spadConstant| $ 43)
                                                    (QREFELT $ 131))
                                                   (COND
                                                    ((SPADCALL
                                                      (EXPT
                                                       (SPADCALL |sol0| 1
                                                                 (QREFELT $
                                                                          116))
                                                       2)
                                                      (SPADCALL |sol0| 2
                                                                (QREFELT $
                                                                         116))
                                                      (QREFELT $ 89))
                                                     (PROGN
                                                      (LETT #6#
                                                            (VECTOR |a1| |r1|
                                                                    |ansp|
                                                                    NIL))
                                                      (GO #28#))))))
                                                 (LETT |rcu|
                                                       (SPADCALL
                                                        (SPADCALL
                                                         (SPADCALL
                                                          (SPADCALL |sol0| 1
                                                                    (QREFELT $
                                                                             116))
                                                          (QREFELT $ 140))
                                                         (SPADCALL 2
                                                                   (QREFELT $
                                                                            140))
                                                         (QREFELT $ 305))
                                                        (QREFELT $ 191)))
                                                 (EXIT
                                                  (COND
                                                   ((QEQCAR |rcu| 1)
                                                    (VECTOR |a1| |r1| |ansp|
                                                            NIL))
                                                   (#27#
                                                    (SEQ
                                                     (LETT |ri| (QCDR |rcu|))
                                                     (LETT |nn|
                                                           (SPADCALL |nf|
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       |ri|
                                                                       (QREFELT
                                                                        $ 74))
                                                                      1
                                                                      (QREFELT
                                                                       $ 44))
                                                                     (QREFELT $
                                                                              49)))
                                                     (LETT |cands|
                                                           (|RDEEFX;gammas1|
                                                            |nn| (QCDR |rcu|)
                                                            (|spadConstant| $
                                                                            108)
                                                            (|spadConstant| $
                                                                            108)
                                                            0 1 |vlst| |ulst|
                                                            |k| |x| NIL $))
                                                     (LETT |derivation3|
                                                           (CONS
                                                            #'|RDEEFX;quadratic_log_erf_integrate!0|
                                                            (VECTOR
                                                             |derivation| $)))
                                                     (LETT |scoeffs|
                                                           (|RDEEFX;get_scoeffs|
                                                            |cands|
                                                            (|spadConstant| $
                                                                            108)
                                                            |k| |derivation3|
                                                            $))
                                                     (LETT |rr1|
                                                           (SPADCALL |spec1p|
                                                                     (QREFELT $
                                                                              47)))
                                                     (LETT |f|
                                                           (SPADCALL
                                                            (SPADCALL |nf|
                                                                      (QREFELT
                                                                       $ 47))
                                                            |k|
                                                            (QREFELT $ 60)))
                                                     (EXIT
                                                      (|RDEEFX;special_integrate1|
                                                       |nfp| |f| |k| |lk| |x|
                                                       |rr1| |a1| |r1| |g|
                                                       |ansp| |scoeffs| |cands|
                                                       0 |derivation| $))))))))
                                               (#27#
                                                (SEQ
                                                 (LETT |solb1|
                                                       (|SPADfirst|
                                                        (QCDR |sol_rec|)))
                                                 (EXIT
                                                  (COND
                                                   ((SPADCALL
                                                     (SPADCALL |r| |x|
                                                               (QREFELT $ 62))
                                                     (|spadConstant| $ 43)
                                                     (QREFELT $ 78))
                                                    (COND
                                                     ((>
                                                       (LENGTH
                                                        (QCDR |sol_rec|))
                                                       1)
                                                      (|error|
                                                       "impossible 11"))
                                                     (#27#
                                                      (SEQ
                                                       (LETT |uu|
                                                             (|SPADfirst|
                                                              (SPADCALL |k|
                                                                        (QREFELT
                                                                         $
                                                                         27))))
                                                       (LETT |u0|
                                                             (|RDEEFX;mk_pow|
                                                              |uu| |ulst1|
                                                              |sol0| $))
                                                       (LETT |u1|
                                                             (|RDEEFX;mk_pow|
                                                              |uu| |ulst1|
                                                              |solb1| $))
                                                       (LETT |cis|
                                                             (SPADCALL
                                                              (SPADCALL |phi|
                                                                        |u0|
                                                                        (QREFELT
                                                                         $ 67))
                                                              |u1| |x|
                                                              (QREFELT $ 308)))
                                                       (EXIT
                                                        (COND
                                                         ((QEQCAR |cis| 1)
                                                          (VECTOR |a1| |r1|
                                                                  |ansp| NIL))
                                                         (#27#
                                                          (SEQ
                                                           (LETT |cil|
                                                                 (QCDR |cis|))
                                                           (LETT |cndl| NIL)
                                                           (SEQ (LETT |ci| NIL)
                                                                (LETT #4#
                                                                      |cil|)
                                                                G190
                                                                (COND
                                                                 ((OR
                                                                   (ATOM #4#)
                                                                   (PROGN
                                                                    (LETT |ci|
                                                                          (CAR
                                                                           #4#))
                                                                    NIL))
                                                                  (GO G191)))
                                                                (SEQ
                                                                 (LETT |ii|
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         |ci|
                                                                         (QREFELT
                                                                          $
                                                                          309))
                                                                        (QREFELT
                                                                         $
                                                                         30)))
                                                                 (LETT |rr|
                                                                       (+
                                                                        (SPADCALL
                                                                         |sol0|
                                                                         1
                                                                         (QREFELT
                                                                          $
                                                                          116))
                                                                        (* |ii|
                                                                           (SPADCALL
                                                                            |solb1|
                                                                            1
                                                                            (QREFELT
                                                                             $
                                                                             116)))))
                                                                 (EXIT
                                                                  (LETT |cndl|
                                                                        (|RDEEFX;gammas1|
                                                                         (SPADCALL
                                                                          |nf|
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            |rr|
                                                                            (QREFELT
                                                                             $
                                                                             74))
                                                                           1
                                                                           (QREFELT
                                                                            $
                                                                            44))
                                                                          (QREFELT
                                                                           $
                                                                           49))
                                                                         |rr|
                                                                         (|spadConstant|
                                                                          $
                                                                          108)
                                                                         (|spadConstant|
                                                                          $
                                                                          108)
                                                                         0 0
                                                                         |vlst|
                                                                         |ulst|
                                                                         |k|
                                                                         |x|
                                                                         |cndl|
                                                                         $))))
                                                                (LETT #4#
                                                                      (CDR
                                                                       #4#))
                                                                (GO G190) G191
                                                                (EXIT NIL))
                                                           (LETT |cndl|
                                                                 (NREVERSE
                                                                  |cndl|))
                                                           (LETT |vc|
                                                                 (SPADCALL
                                                                  (PROGN
                                                                   (LETT #3#
                                                                         NIL)
                                                                   (SEQ
                                                                    (LETT |ci|
                                                                          NIL)
                                                                    (LETT #2#
                                                                          |cil|)
                                                                    G190
                                                                    (COND
                                                                     ((OR
                                                                       (ATOM
                                                                        #2#)
                                                                       (PROGN
                                                                        (LETT
                                                                         |ci|
                                                                         (CAR
                                                                          #2#))
                                                                        NIL))
                                                                      (GO
                                                                       G191)))
                                                                    (SEQ
                                                                     (EXIT
                                                                      (LETT #3#
                                                                            (CONS
                                                                             (|SPADfirst|
                                                                              |ci|)
                                                                             #3#))))
                                                                    (LETT #2#
                                                                          (CDR
                                                                           #2#))
                                                                    (GO G190)
                                                                    G191
                                                                    (EXIT
                                                                     (NREVERSE
                                                                      #3#))))
                                                                  (QREFELT $
                                                                           81)))
                                                           (LETT |as|
                                                                 (MAKEARR1
                                                                  (LENGTH
                                                                   |cil|)
                                                                  (|spadConstant|
                                                                   $ 43)))
                                                           (EXIT
                                                            (|RDEEFX;finish_special_integrate2|
                                                             |r1| |vc| |a1|
                                                             |as| |cndl|
                                                             (|spadConstant| $
                                                                             108)
                                                             0 |k| $))))))))))
                                                   ((OR
                                                     (EQL
                                                      (LENGTH (QCDR |sol_rec|))
                                                      1)
                                                     (NULL
                                                      (>
                                                       (LENGTH
                                                        (QCDR |sol_rec|))
                                                       2)))
                                                    (VECTOR |a1| |r1| |ansp|
                                                            NIL))
                                                   ('T
                                                    (|error|
                                                     "impossible 12"))))))))))))))))))))))))))
          #28# (EXIT #6#)))) 

(SDEFUN |RDEEFX;quadratic_log_erf_integrate!0| ((|z1| NIL) ($$ NIL))
        (PROG ($ |derivation|)
          (LETT $ (QREFELT $$ 1))
          (LETT |derivation| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL
              (SPADCALL (SPADCALL (SPADCALL |z1| (QREFELT $ 38)) |derivation|)
                        (SPADCALL |z1| (QREFELT $ 39)) (QREFELT $ 97))
              (SPADCALL (SPADCALL |z1| (QREFELT $ 38))
                        (SPADCALL (SPADCALL |z1| (QREFELT $ 39)) |derivation|)
                        (QREFELT $ 97))
              (QREFELT $ 46))
             (SPADCALL (SPADCALL |z1| (QREFELT $ 39))
                       (SPADCALL |z1| (QREFELT $ 39)) (QREFELT $ 97))
             (QREFELT $ 196)))))) 

(SDEFUN |RDEEFX;decompose1|
        ((|num| (|SparseUnivariatePolynomial| F))
         (|den| (|SparseUnivariatePolynomial| F))
         (|eidens| (|List| (|SparseUnivariatePolynomial| F)))
         ($ (|List| (|SparseUnivariatePolynomial| F))))
        (SPROG
         ((|res| (|List| (|SparseUnivariatePolynomial| F)))
          (|f1| (|SparseUnivariatePolynomial| F)) (#1=#:G1723 NIL))
         (SEQ
          (LETT |f1|
                (PROG2
                    (LETT #1#
                          (SPADCALL |den|
                                    (SPADCALL (ELT $ 97) |eidens|
                                              (QREFELT $ 310))
                                    (QREFELT $ 107)))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0)
                                  (|SparseUnivariatePolynomial| (QREFELT $ 7))
                                  (|Union|
                                   (|SparseUnivariatePolynomial| (QREFELT $ 7))
                                   "failed")
                                  #1#)))
          (COND
           ((SPADCALL |f1| (|spadConstant| $ 108) (QREFELT $ 109))
            (LETT |eidens| (CONS |f1| |eidens|))))
          (LETT |res| (SPADCALL |num| |eidens| (QREFELT $ 312)))
          (EXIT
           (COND
            ((SPADCALL |f1| (|spadConstant| $ 108) (QREFELT $ 109))
             (CDR |res|))
            ('T |res|)))))) 

(SDEFUN |RDEEFX;get_trace|
        ((|fu| (|Fraction| (|SparseUnivariatePolynomial| F)))
         (|k| (|Kernel| F)) (|rf1k| (|Kernel| F))
         (|cfac| (|SparseUnivariatePolynomial| F))
         ($ (|Fraction| (|SparseUnivariatePolynomial| F))))
        (SPROG
         ((|resd| (F)) (|fa| (|SparseUnivariatePolynomial| F)) (|f| (F))
          (|Sae|
           (|Join| (|MonogenicAlgebra| F (|SparseUnivariatePolynomial| F))
                   (CATEGORY |package|
                    (IF (|has| F (|Field|))
                        (IF (|has| F (|PolynomialFactorizationExplicit|))
                            (ATTRIBUTE (|PolynomialFactorizationExplicit|))
                            |noBranch|)
                        |noBranch|)))))
         (SEQ
          (LETT |Sae|
                (|SimpleAlgebraicExtension| (QREFELT $ 7)
                                            (|SparseUnivariatePolynomial|
                                             (QREFELT $ 7))
                                            |cfac|))
          (LETT |f| (SPADCALL |fu| |k| (QREFELT $ 60)))
          (LETT |fa| (SPADCALL |f| |rf1k| |cfac| (QREFELT $ 313)))
          (LETT |resd|
                (SPADCALL
                 (SPADCALL |fa|
                           (|compiledLookupCheck| '|reduce|
                                                  (LIST '$
                                                        (LIST
                                                         '|SparseUnivariatePolynomial|
                                                         (|devaluate|
                                                          (ELT $ 7))))
                                                  |Sae|))
                 (|compiledLookupCheck| '|trace|
                                        (LIST (|devaluate| (ELT $ 7)) '$)
                                        |Sae|)))
          (EXIT (SPADCALL |resd| |k| (QREFELT $ 35)))))) 

(SDEFUN |RDEEFX;solve_factor1|
        ((|nf| (|SparseUnivariatePolynomial| F))
         (|denf| (|SparseUnivariatePolynomial| F))
         (|nfp| (|SparseUnivariatePolynomial| F))
         (|denfp| (|SparseUnivariatePolynomial| F)) (|k| (|Kernel| F))
         (|x| (|Symbol|)) (|einum| (|SparseUnivariatePolynomial| F))
         (|bpol| (|SparseUnivariatePolynomial| F))
         (|er|
          (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                    (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                    (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                    (|:| |u_part| F) (|:| |exponent| (|Integer|))
                    (|:| |shift_part| F)))
         ($
          (|Record| (|:| |primpart| F)
                    (|:| |logpart|
                         (|Fraction| (|SparseUnivariatePolynomial| F)))
                    (|:| |polypart| (|SparseUnivariatePolynomial| F))
                    (|:| |specpart|
                         (|Fraction| (|SparseUnivariatePolynomial| F))))))
        (SPROG
         ((|poly_cor| (|SparseUnivariatePolynomial| F))
          (|poly_cor_rf| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (|sp_cor| #1=(|Fraction| (|SparseUnivariatePolynomial| F)))
          (|lp_cor| #1#) (|ansp| (F)) (#2=#:G1764 NIL) (|zz| NIL)
          (|zzl| (|List| F)) (|ansp1| (F)) (|c| (F))
          (|cu1| (|Union| F "failed")) (|cp| (|SparseUnivariatePolynomial| F))
          (|cu| (|Union| (|SparseUnivariatePolynomial| F) #3="failed"))
          (|ppu|
           (|Union|
            (|Record| (|:| |coef1| (|SparseUnivariatePolynomial| F))
                      (|:| |coef2| (|SparseUnivariatePolynomial| F)))
            "failed"))
          (|ddf| (|SparseUnivariatePolynomial| F))
          (|lnum1| #4=(|SparseUnivariatePolynomial| F))
          (|reml| (|List| (|SparseUnivariatePolynomial| F))) (|lnum0| #4#)
          (|coeff1_rs| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (|auxl| (|List| (|SparseUnivariatePolynomial| F)))
          (|denf1| (|SparseUnivariatePolynomial| F)) (#5=#:G1738 NIL)
          (|spec_den| (|SparseUnivariatePolynomial| F))
          (|min_deg| (|NonNegativeInteger|))
          (|dvr|
           (|Record| (|:| |quotient| (|SparseUnivariatePolynomial| F))
                     (|:| |remainder| #4#)))
          (|coeff1_r| #6=(|Fraction| (|SparseUnivariatePolynomial| F)))
          (|coeff1| (|SparseUnivariatePolynomial| F))
          (|numfp1| #7=(|SparseUnivariatePolynomial| F)) (|ei_arg| #6#)
          (|eiarg_num| #7#) (|rf1k| (|Kernel| F)) (|rfc| (F)) (|vshift| (F))
          (|u_exp| (|Integer|)) (|u0| (F))
          (|cfac| (|SparseUnivariatePolynomial| F)) (|v0| (F))
          (|r0| (|Integer|)) (|eiden| (|SparseUnivariatePolynomial| F)))
         (SEQ (LETT |eiden| (QVELT |er| 0)) (LETT |r0| (QVELT |er| 1))
              (LETT |v0| (QVELT |er| 2)) (LETT |cfac| (QVELT |er| 3))
              (LETT |u0| (QVELT |er| 4)) (LETT |u_exp| (QVELT |er| 5))
              (LETT |vshift| (QVELT |er| 6)) (LETT |rfc| (|spadConstant| $ 43))
              (COND
               ((SPADCALL |cfac| (|spadConstant| $ 102) (QREFELT $ 109))
                (SEQ (LETT |rfc| (SPADCALL |cfac| (QREFELT $ 241)))
                     (EXIT (LETT |rf1k| (SPADCALL |rfc| (QREFELT $ 314)))))))
              (LETT |eiarg_num|
                    (SPADCALL |nf|
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (SPADCALL |r0| (QREFELT $ 74)) 1
                                           (QREFELT $ 44))
                                 (SPADCALL |v0| (QREFELT $ 45)) (QREFELT $ 49))
                                (SPADCALL |rfc| (QREFELT $ 45)) (QREFELT $ 49))
                               |denf| (QREFELT $ 97))
                              (QREFELT $ 49)))
              (LETT |ei_arg|
                    (SPADCALL (SPADCALL |eiarg_num| (QREFELT $ 47))
                              (SPADCALL |denf| (QREFELT $ 47)) (QREFELT $ 50)))
              (LETT |numfp1|
                    (SPADCALL |nfp|
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL |v0|
                                          (SPADCALL
                                           (SPADCALL |r0| (QREFELT $ 74))
                                           (SPADCALL |k| (QREFELT $ 61))
                                           (QREFELT $ 65))
                                          (QREFELT $ 73))
                                |x| (QREFELT $ 62))
                               |denfp| (QREFELT $ 136))
                              (QREFELT $ 49)))
              (LETT |coeff1|
                    (SPADCALL (SPADCALL |numfp1| |denf| (QREFELT $ 97)) |u0|
                              (QREFELT $ 206)))
              (LETT |coeff1_r|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL (|spadConstant| $ 32) 1 (QREFELT $ 44))
                        (QREFELT $ 47))
                       |u_exp| (QREFELT $ 315))
                      (SPADCALL |coeff1| (QREFELT $ 47)) (QREFELT $ 316))
                     (SPADCALL |eiarg_num| (QREFELT $ 47)) (QREFELT $ 50)))
              (LETT |denf1| (SPADCALL |coeff1_r| (QREFELT $ 39)))
              (LETT |coeff1_rs| (|spadConstant| $ 197))
              (LETT |dvr|
                    (SPADCALL (SPADCALL |coeff1_r| (QREFELT $ 38)) |denf1|
                              (QREFELT $ 318)))
              (LETT |lnum1| (QCDR |dvr|))
              (COND
               ((SPADCALL |k| '|exp| (QREFELT $ 22))
                (SEQ (LETT |min_deg| (SPADCALL |denf1| (QREFELT $ 216)))
                     (EXIT
                      (COND
                       ((> |min_deg| 0)
                        (SEQ
                         (LETT |spec_den|
                               (SPADCALL (|spadConstant| $ 32) |min_deg|
                                         (QREFELT $ 44)))
                         (LETT |denf1|
                               (PROG2
                                   (LETT #5#
                                         (SPADCALL |denf1| |spec_den|
                                                   (QREFELT $ 107)))
                                   (QCDR #5#)
                                 (|check_union2| (QEQCAR #5# 0)
                                                 (|SparseUnivariatePolynomial|
                                                  (QREFELT $ 7))
                                                 (|Union|
                                                  (|SparseUnivariatePolynomial|
                                                   (QREFELT $ 7))
                                                  #3#)
                                                 #5#)))
                         (LETT |auxl|
                               (SPADCALL |lnum1| (LIST |denf1| |spec_den|)
                                         (QREFELT $ 312)))
                         (LETT |lnum1| (SPADCALL |auxl| 1 (QREFELT $ 319)))
                         (EXIT
                          (LETT |coeff1_rs|
                                (SPADCALL
                                 (SPADCALL (SPADCALL |auxl| 2 (QREFELT $ 319))
                                           (QREFELT $ 47))
                                 (SPADCALL |spec_den| (QREFELT $ 47))
                                 (QREFELT $ 50)))))))))))
              (LETT |lnum0| |lnum1|)
              (COND
               ((SPADCALL |bpol| |eiden| (QREFELT $ 109))
                (SEQ
                 (LETT |reml|
                       (|RDEEFX;decompose1| |lnum1| |denf1| (LIST |bpol|) $))
                 (EXIT (LETT |lnum1| (|SPADfirst| |reml|))))))
              (COND
               ((SPADCALL |cfac| (|spadConstant| $ 102) (QREFELT $ 109))
                (SEQ (LETT |einum| (SPADCALL |einum| |denf1| (QREFELT $ 190)))
                     (LETT |ddf|
                           (SPADCALL (SPADCALL |eiden| (QREFELT $ 192)) |denf1|
                                     (QREFELT $ 190)))
                     (LETT |ppu|
                           (SPADCALL |denf1| |ddf| |einum| (QREFELT $ 322)))
                     (EXIT
                      (COND ((QEQCAR |ppu| 1) (|error| "impossible 4"))
                            (#8='T
                             (SEQ (LETT |einum| (QCDR (QCDR |ppu|)))
                                  (EXIT
                                   (LETT |einum|
                                         (SPADCALL
                                          (SPADCALL |einum|
                                                    (SPADCALL |denf1|
                                                              (QREFELT $ 192))
                                                    (QREFELT $ 97))
                                          |denf1| (QREFELT $ 190)))))))))))
              (LETT |cu| (SPADCALL |einum| |lnum1| (QREFELT $ 107)))
              (EXIT
               (COND
                ((QEQCAR |cu| 1)
                 (VECTOR (|spadConstant| $ 43) (|spadConstant| $ 197)
                         (|spadConstant| $ 102) (|spadConstant| $ 197)))
                (#8#
                 (SEQ (LETT |cp| (QCDR |cu|))
                      (LETT |cu1| (SPADCALL |cp| (QREFELT $ 229)))
                      (EXIT
                       (COND
                        ((QEQCAR |cu1| 1)
                         (VECTOR (|spadConstant| $ 43) (|spadConstant| $ 197)
                                 (|spadConstant| $ 102)
                                 (|spadConstant| $ 197)))
                        (#8#
                         (SEQ (LETT |c| (QCDR |cu1|))
                              (EXIT
                               (COND
                                ((SPADCALL (SPADCALL |c| |x| (QREFELT $ 323))
                                           (|spadConstant| $ 43)
                                           (QREFELT $ 131))
                                 (VECTOR (|spadConstant| $ 43)
                                         (|spadConstant| $ 197)
                                         (|spadConstant| $ 102)
                                         (|spadConstant| $ 197)))
                                (#8#
                                 (SEQ
                                  (LETT |ansp1|
                                        (SPADCALL
                                         (SPADCALL |c|
                                                   (SPADCALL
                                                    (SPADCALL
                                                     (SPADCALL |vshift|
                                                               (QREFELT $ 48))
                                                     |rfc| (QREFELT $ 77))
                                                    (QREFELT $ 324))
                                                   (QREFELT $ 65))
                                         (SPADCALL
                                          (SPADCALL |ei_arg| |k|
                                                    (QREFELT $ 60))
                                          (QREFELT $ 325))
                                         (QREFELT $ 65)))
                                  (LETT |zzl|
                                        (COND
                                         ((SPADCALL |cfac|
                                                    (|spadConstant| $ 102)
                                                    (QREFELT $ 111))
                                          (LIST (|spadConstant| $ 43)))
                                         (#8#
                                          (SPADCALL |cfac| (QREFELT $ 326)))))
                                  (LETT |ansp| (|spadConstant| $ 43))
                                  (COND
                                   ((SPADCALL |cfac| (|spadConstant| $ 102)
                                              (QREFELT $ 111))
                                    (LETT |ansp| |ansp1|))
                                   (#8#
                                    (SEQ (LETT |zz| NIL) (LETT #2# |zzl|) G190
                                         (COND
                                          ((OR (ATOM #2#)
                                               (PROGN
                                                (LETT |zz| (CAR #2#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT |ansp|
                                                 (SPADCALL |ansp|
                                                           (SPADCALL |ansp1|
                                                                     |rf1k|
                                                                     |zz|
                                                                     (QREFELT $
                                                                              68))
                                                           (QREFELT $ 73)))))
                                         (LETT #2# (CDR #2#)) (GO G190) G191
                                         (EXIT NIL))))
                                  (LETT |lp_cor|
                                        (SPADCALL (SPADCALL |c| (QREFELT $ 45))
                                                  (SPADCALL
                                                   (SPADCALL |lnum0|
                                                             (QREFELT $ 47))
                                                   (SPADCALL |denf1|
                                                             (QREFELT $ 47))
                                                   (QREFELT $ 50))
                                                  (QREFELT $ 271)))
                                  (LETT |sp_cor|
                                        (SPADCALL (SPADCALL |c| (QREFELT $ 45))
                                                  |coeff1_rs| (QREFELT $ 271)))
                                  (LETT |poly_cor|
                                        (SPADCALL (SPADCALL |c| (QREFELT $ 45))
                                                  (QCAR |dvr|) (QREFELT $ 97)))
                                  (COND
                                   ((SPADCALL |cfac| (|spadConstant| $ 102)
                                              (QREFELT $ 109))
                                    (SEQ
                                     (LETT |lp_cor|
                                           (|RDEEFX;get_trace| |lp_cor| |k|
                                            |rf1k| |cfac| $))
                                     (LETT |sp_cor|
                                           (|RDEEFX;get_trace| |sp_cor| |k|
                                            |rf1k| |cfac| $))
                                     (LETT |poly_cor_rf|
                                           (|RDEEFX;get_trace|
                                            (SPADCALL |poly_cor|
                                                      (QREFELT $ 47))
                                            |k| |rf1k| |cfac| $))
                                     (EXIT
                                      (LETT |poly_cor|
                                            (SPADCALL |poly_cor_rf|
                                                      (QREFELT $ 327)))))))
                                  (EXIT
                                   (VECTOR |ansp| |lp_cor| |poly_cor|
                                           |sp_cor|))))))))))))))))) 

(SDEFUN |RDEEFX;p_power_in_q|
        ((|q| (|SparseUnivariatePolynomial| F))
         (|p| (|SparseUnivariatePolynomial| F)) ($ (|Integer|)))
        (SPROG
         ((|nn| (|Integer|)) (#1=#:G1774 NIL)
          (|nqu| (|Union| (|SparseUnivariatePolynomial| F) "failed")))
         (SEQ (LETT |nn| 0)
              (SEQ
               (EXIT
                (SEQ G190 NIL
                     (SEQ (LETT |nqu| (SPADCALL |q| |p| (QREFELT $ 107)))
                          (EXIT
                           (COND
                            ((QEQCAR |nqu| 1)
                             (PROGN (LETT #1# |$NoValue|) (GO #2=#:G1771)))
                            ('T
                             (SEQ (LETT |q| (QCDR |nqu|))
                                  (EXIT (LETT |nn| (+ |nn| 1))))))))
                     NIL (GO G190) G191 (EXIT NIL)))
               #2# (EXIT #1#))
              (EXIT |nn|)))) 

(SDEFUN |RDEEFX;solve_linear_factor|
        ((|nf| (|SparseUnivariatePolynomial| F))
         (|denf| (|SparseUnivariatePolynomial| F))
         (|nfp| (|SparseUnivariatePolynomial| F))
         (|denfp| (|SparseUnivariatePolynomial| F)) (|k| (|Kernel| F))
         (|x| (|Symbol|)) (|einum| (|SparseUnivariatePolynomial| F))
         (|er|
          (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                    (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                    (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                    (|:| |u_part| F) (|:| |exponent| (|Integer|))
                    (|:| |shift_part| F) (|:| |has_part2?| (|Boolean|))
                    (|:| |ratpart2| (|Integer|)) (|:| |v_part2| F)
                    (|:| |u_part2| F) (|:| |shift_part2| F)))
         ($
          (|Record| (|:| |primpart| F)
                    (|:| |logpart|
                         (|Fraction| (|SparseUnivariatePolynomial| F)))
                    (|:| |polypart| (|SparseUnivariatePolynomial| F))
                    (|:| |specpart|
                         (|Fraction| (|SparseUnivariatePolynomial| F))))))
        (SPROG
         ((|dvr2|
           #1=(|Record| (|:| |quotient| (|SparseUnivariatePolynomial| F))
                        (|:| |remainder| (|SparseUnivariatePolynomial| F))))
          (|ansp| (F)) (#2=#:G1807 NIL) (|zz| NIL)
          (|lp_cor| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (|eiargp| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (|coefi| (F)) (|ansp1| (F)) (|shifti| (F)) (|eiargi| (F))
          (|eiargi_r| #3=(|Fraction| (|SparseUnivariatePolynomial| F)))
          (|ci| (F)) (|nn| (|Integer|))
          (|einumi| (|SparseUnivariatePolynomial| F)) (|ki| (|Integer|))
          (|kif| (F)) (#4=#:G1806 NIL) (|ck| NIL) (|zzl| (|List| F))
          (|eiarg_inc| (|SparseUnivariatePolynomial| F))
          (|res1| (|List| (|List| F)))
          (|res1u| (|Union| (|List| (|List| F)) "failed")) (|u1| (F))
          (|einum1| (F)) (|lnum1| (F))
          (|reml| (|List| (|SparseUnivariatePolynomial| F)))
          (|ppu|
           (|Union|
            (|Record| (|:| |coef1| (|SparseUnivariatePolynomial| F))
                      (|:| |coef2| (|SparseUnivariatePolynomial| F)))
            "failed"))
          (|ddf| (|SparseUnivariatePolynomial| F)) (|dvr| #1#)
          (|denf1| (|SparseUnivariatePolynomial| F)) (|coeff1_r| #3#)
          (|coeff1| (|SparseUnivariatePolynomial| F))
          (|numfp1| #5=(|SparseUnivariatePolynomial| F)) (|nn0| (|Integer|))
          (|fac1| (|SparseUnivariatePolynomial| F)) (|eiarg_num| #5#)
          (|lc0| (F)) (|u0| (F)) (|v0| (F)) (|r0| (|Integer|))
          (|rf1k| (|Kernel| F)) (|rfc| (F))
          (|cfac| (|SparseUnivariatePolynomial| F)))
         (SEQ (LETT |cfac| (QVELT |er| 3)) (LETT |rfc| (|spadConstant| $ 43))
              (COND
               ((SPADCALL |cfac| (|spadConstant| $ 102) (QREFELT $ 109))
                (SEQ (LETT |rfc| (SPADCALL |cfac| (QREFELT $ 241)))
                     (EXIT (LETT |rf1k| (SPADCALL |rfc| (QREFELT $ 314)))))))
              (LETT |r0| (QVELT |er| 1)) (LETT |v0| (QVELT |er| 2))
              (LETT |u0| (QVELT |er| 4))
              (LETT |lc0|
                    (SPADCALL (SPADCALL |nf| (QREFELT $ 103))
                              (SPADCALL |r0| (QREFELT $ 74)) (QREFELT $ 73)))
              (COND
               ((OR (SPADCALL (SPADCALL |nf| (QREFELT $ 40)) 1 (QREFELT $ 89))
                    (SPADCALL |denf| (|spadConstant| $ 108) (QREFELT $ 109)))
                (COND
                 ((SPADCALL |cfac| (|spadConstant| $ 102) (QREFELT $ 109))
                  (EXIT (|error| "cfac ~= 0 in nonlinear case"))))))
              (LETT |eiarg_num|
                    (SPADCALL |nf|
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL (SPADCALL |r0| (QREFELT $ 74)) 1
                                          (QREFELT $ 44))
                                (SPADCALL
                                 (SPADCALL |v0|
                                           (SPADCALL |lc0| |rfc|
                                                     (QREFELT $ 65))
                                           (QREFELT $ 73))
                                 (QREFELT $ 45))
                                (QREFELT $ 49))
                               |denf| (QREFELT $ 97))
                              (QREFELT $ 49)))
              (LETT |fac1| (QVELT |er| 0))
              (LETT |nn0|
                    (COND
                     ((> (SPADCALL |eiarg_num| (QREFELT $ 40)) 1)
                      (|RDEEFX;p_power_in_q| |eiarg_num| |fac1| $))
                     (#6='T 1)))
              (EXIT
               (COND
                ((EQL |nn0| 0)
                 (|error|
                  "impossible, eiarg_num is not divisible by its factor"))
                (#6#
                 (SEQ
                  (LETT |numfp1|
                        (SPADCALL |nfp|
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL |v0|
                                              (SPADCALL
                                               (SPADCALL |r0| (QREFELT $ 74))
                                               (SPADCALL |k| (QREFELT $ 61))
                                               (QREFELT $ 65))
                                              (QREFELT $ 73))
                                    |x| (QREFELT $ 62))
                                   |denfp| (QREFELT $ 136))
                                  (QREFELT $ 49)))
                  (LETT |coeff1|
                        (SPADCALL (SPADCALL |numfp1| |denf| (QREFELT $ 97))
                                  |u0| (QREFELT $ 206)))
                  (LETT |coeff1_r|
                        (SPADCALL (SPADCALL |coeff1| (QREFELT $ 47))
                                  (SPADCALL |eiarg_num| (QREFELT $ 47))
                                  (QREFELT $ 50)))
                  (LETT |denf1| (SPADCALL |coeff1_r| (QREFELT $ 39)))
                  (LETT |dvr|
                        (SPADCALL (SPADCALL |coeff1_r| (QREFELT $ 38)) |denf1|
                                  (QREFELT $ 318)))
                  (COND
                   ((SPADCALL |cfac| (|spadConstant| $ 102) (QREFELT $ 109))
                    (SEQ
                     (LETT |einum| (SPADCALL |einum| |denf1| (QREFELT $ 190)))
                     (LETT |ddf|
                           (SPADCALL (SPADCALL (QVELT |er| 0) (QREFELT $ 192))
                                     |denf1| (QREFELT $ 190)))
                     (LETT |ppu|
                           (SPADCALL |denf1| |ddf| |einum| (QREFELT $ 322)))
                     (EXIT
                      (COND ((QEQCAR |ppu| 1) (|error| "impossible 4"))
                            (#6#
                             (SEQ (LETT |einum| (QCDR (QCDR |ppu|)))
                                  (EXIT
                                   (LETT |einum|
                                         (SPADCALL
                                          (SPADCALL |einum|
                                                    (SPADCALL |denf1|
                                                              (QREFELT $ 192))
                                                    (QREFELT $ 97))
                                          |denf1| (QREFELT $ 190)))))))))))
                  (LETT |lnum1|
                        (COND
                         ((> (SPADCALL |fac1| (QREFELT $ 40)) 1)
                          (SPADCALL (QCDR |dvr|) (QREFELT $ 202)))
                         (#6#
                          (SEQ
                           (LETT |reml|
                                 (|RDEEFX;decompose1| (QCDR |dvr|) |denf1|
                                  (LIST |fac1|) $))
                           (EXIT
                            (SPADCALL (|SPADfirst| |reml|)
                                      (QREFELT $ 202)))))))
                  (LETT |einum1| (SPADCALL |einum| (QREFELT $ 202)))
                  (LETT |u1| (QVELT |er| 10))
                  (LETT |res1u|
                        (SPADCALL (SPADCALL |einum1| |lnum1| (QREFELT $ 67))
                                  |u1| |x| (QREFELT $ 308)))
                  (EXIT
                   (COND
                    ((QEQCAR |res1u| 1)
                     (VECTOR (|spadConstant| $ 43) (|spadConstant| $ 197)
                             (|spadConstant| $ 102) (|spadConstant| $ 197)))
                    (#6#
                     (SEQ (LETT |res1| (QCDR |res1u|))
                          (LETT |ansp1| (|spadConstant| $ 43))
                          (LETT |lp_cor| (|spadConstant| $ 197))
                          (LETT |eiarg_inc|
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL
                                   (SPADCALL (QVELT |er| 8) (QREFELT $ 74)) 1
                                   (QREFELT $ 44))
                                  (SPADCALL (QVELT |er| 9) (QREFELT $ 45))
                                  (QREFELT $ 49))
                                 |denf| (QREFELT $ 97)))
                          (LETT |zzl|
                                (COND
                                 ((SPADCALL |cfac| (|spadConstant| $ 102)
                                            (QREFELT $ 111))
                                  (LIST (|spadConstant| $ 43)))
                                 (#6# (SPADCALL |cfac| (QREFELT $ 326)))))
                          (SEQ (LETT |ck| NIL) (LETT #4# |res1|) G190
                               (COND
                                ((OR (ATOM #4#)
                                     (PROGN (LETT |ck| (CAR #4#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (LETT |ci| (SPADCALL |ck| 1 (QREFELT $ 29)))
                                (LETT |kif| (SPADCALL |ck| 2 (QREFELT $ 29)))
                                (LETT |ki| (SPADCALL |kif| (QREFELT $ 30)))
                                (LETT |einumi|
                                      (COND
                                       ((SPADCALL |cfac| (|spadConstant| $ 102)
                                                  (QREFELT $ 111))
                                        (SPADCALL |eiarg_num|
                                                  (SPADCALL |kif| |eiarg_inc|
                                                            (QREFELT $ 136))
                                                  (QREFELT $ 49)))
                                       ('T
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |lc0| |kif| (QREFELT $ 73))
                                          |lc0| (QREFELT $ 67))
                                         |eiarg_num| (QREFELT $ 136)))))
                                (LETT |nn|
                                      (COND
                                       ((> (SPADCALL |einumi| (QREFELT $ 40))
                                           1)
                                        (|RDEEFX;p_power_in_q| |einumi| |fac1|
                                         $))
                                       ('T 1)))
                                (COND
                                 ((EQL |nn| 0)
                                  (|error|
                                   "impossible, einumi not divisible by its factor")))
                                (LETT |ci|
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL |nn0| (QREFELT $ 74)) |ci|
                                        (QREFELT $ 65))
                                       (SPADCALL |nn| (QREFELT $ 74))
                                       (QREFELT $ 67)))
                                (LETT |eiargi_r|
                                      (SPADCALL
                                       (SPADCALL |einumi| (QREFELT $ 47))
                                       (SPADCALL |denf| (QREFELT $ 47))
                                       (QREFELT $ 50)))
                                (LETT |eiargi|
                                      (SPADCALL |eiargi_r| |k| (QREFELT $ 60)))
                                (LETT |shifti|
                                      (COND
                                       ((SPADCALL |cfac| (|spadConstant| $ 102)
                                                  (QREFELT $ 111))
                                        (SPADCALL (QVELT |er| 6)
                                                  (SPADCALL |kif|
                                                            (QVELT |er| 11)
                                                            (QREFELT $ 65))
                                                  (QREFELT $ 73)))
                                       ('T
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |lc0| |kif| (QREFELT $ 73))
                                          |lc0| (QREFELT $ 67))
                                         (SPADCALL (QVELT |er| 6)
                                                   (SPADCALL |lc0| |rfc|
                                                             (QREFELT $ 65))
                                                   (QREFELT $ 73))
                                         (QREFELT $ 65)))))
                                (LETT |ansp1|
                                      (SPADCALL |ansp1|
                                                (SPADCALL
                                                 (SPADCALL |ci|
                                                           (SPADCALL
                                                            (SPADCALL |shifti|
                                                                      (QREFELT
                                                                       $ 48))
                                                            (QREFELT $ 324))
                                                           (QREFELT $ 65))
                                                 (SPADCALL |eiargi|
                                                           (QREFELT $ 325))
                                                 (QREFELT $ 65))
                                                (QREFELT $ 73)))
                                (LETT |coefi|
                                      (SPADCALL
                                       (SPADCALL |ci| |u0| (QREFELT $ 65))
                                       (SPADCALL |u1| |ki| (QREFELT $ 79))
                                       (QREFELT $ 65)))
                                (LETT |eiargp|
                                      (SPADCALL |denfp|
                                                (SPADCALL
                                                 (SPADCALL |eiargi| |x|
                                                           (QREFELT $ 62))
                                                 |k| (QREFELT $ 35))
                                                (QREFELT $ 271)))
                                (EXIT
                                 (LETT |lp_cor|
                                       (SPADCALL |lp_cor|
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (SPADCALL
                                                    (SPADCALL |coefi|
                                                              (QREFELT $ 45))
                                                    (QREFELT $ 47))
                                                   |eiargp| (QREFELT $ 316))
                                                  |eiargi_r| (QREFELT $ 50))
                                                 (QREFELT $ 328)))))
                               (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                          (LETT |ansp| (|spadConstant| $ 43))
                          (COND
                           ((SPADCALL |cfac| (|spadConstant| $ 102)
                                      (QREFELT $ 111))
                            (LETT |ansp| |ansp1|))
                           (#6#
                            (SEQ
                             (LETT |lp_cor|
                                   (|RDEEFX;get_trace| |lp_cor| |k| |rf1k|
                                    |cfac| $))
                             (EXIT
                              (SEQ (LETT |zz| NIL) (LETT #2# |zzl|) G190
                                   (COND
                                    ((OR (ATOM #2#)
                                         (PROGN (LETT |zz| (CAR #2#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT |ansp|
                                           (SPADCALL |ansp|
                                                     (SPADCALL |ansp1| |rf1k|
                                                               |zz|
                                                               (QREFELT $ 68))
                                                     (QREFELT $ 73)))))
                                   (LETT #2# (CDR #2#)) (GO G190) G191
                                   (EXIT NIL))))))
                          (LETT |dvr2|
                                (SPADCALL (SPADCALL |lp_cor| (QREFELT $ 38))
                                          (SPADCALL |lp_cor| (QREFELT $ 39))
                                          (QREFELT $ 318)))
                          (EXIT
                           (VECTOR |ansp|
                                   (SPADCALL
                                    (SPADCALL (QCDR |dvr2|) (QREFELT $ 47))
                                    (SPADCALL
                                     (SPADCALL |lp_cor| (QREFELT $ 39))
                                     (QREFELT $ 47))
                                    (QREFELT $ 50))
                                   (QCAR |dvr2|)
                                   (|spadConstant| $ 197)))))))))))))) 

(SDEFUN |RDEEFX;linear_log_case|
        ((|num| (|SparseUnivariatePolynomial| F))
         (|den| (|SparseUnivariatePolynomial| F))
         (|nf| (|SparseUnivariatePolynomial| F))
         (|nfp| (|SparseUnivariatePolynomial| F)) (|k| (|Kernel| F))
         (|vlst| (|List| F)) (|ulst| (|List| F)) (|x| (|Symbol|))
         ($
          (|Record| (|:| |primpart| F)
                    (|:| |logpart|
                         (|Fraction| (|SparseUnivariatePolynomial| F)))
                    (|:| |polypart| (|SparseUnivariatePolynomial| F))
                    (|:| |specpart|
                         (|Fraction| (|SparseUnivariatePolynomial| F))))))
        (SPROG
         ((|poly_cor| (|SparseUnivariatePolynomial| F))
          (|sp_cor| #1=(|Fraction| (|SparseUnivariatePolynomial| F)))
          (|lp_cor| #1#) (|ansp| (F))
          (|ar1|
           (|Record| (|:| |primpart| F)
                     (|:| |logpart|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |polypart| (|SparseUnivariatePolynomial| F))
                     (|:| |specpart|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))))
          (#2=#:G1819 NIL) (|einum| NIL) (#3=#:G1820 NIL) (|er| NIL)
          (|einums| (|List| (|SparseUnivariatePolynomial| F)))
          (|eidens| (|List| (|SparseUnivariatePolynomial| F))) (#4=#:G1818 NIL)
          (#5=#:G1817 NIL)
          (|al|
           (|List|
            (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                      (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                      (|:| |u_part| F) (|:| |exponent| (|Integer|))
                      (|:| |shift_part| F) (|:| |has_part2?| (|Boolean|))
                      (|:| |ratpart2| (|Integer|)) (|:| |v_part2| F)
                      (|:| |u_part2| F) (|:| |shift_part2| F)))))
         (SEQ
          (LETT |al| (|RDEEFX;lin_args| |den| |nf| |k| |vlst| |ulst| |x| $))
          (EXIT
           (COND
            ((NULL |al|)
             (VECTOR (|spadConstant| $ 43) (|spadConstant| $ 197)
                     (|spadConstant| $ 102) (|spadConstant| $ 197)))
            ('T
             (SEQ
              (LETT |eidens|
                    (PROGN
                     (LETT #5# NIL)
                     (SEQ (LETT |er| NIL) (LETT #4# |al|) G190
                          (COND
                           ((OR (ATOM #4#) (PROGN (LETT |er| (CAR #4#)) NIL))
                            (GO G191)))
                          (SEQ (EXIT (LETT #5# (CONS (QVELT |er| 0) #5#))))
                          (LETT #4# (CDR #4#)) (GO G190) G191
                          (EXIT (NREVERSE #5#)))))
              (LETT |einums| (|RDEEFX;decompose1| |num| |den| |eidens| $))
              (LETT |ansp| (|spadConstant| $ 43))
              (LETT |lp_cor| (|spadConstant| $ 197))
              (LETT |sp_cor| (|spadConstant| $ 197))
              (LETT |poly_cor| (|spadConstant| $ 102))
              (SEQ (LETT |er| NIL) (LETT #3# |al|) (LETT |einum| NIL)
                   (LETT #2# |einums|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |einum| (CAR #2#)) NIL)
                         (ATOM #3#) (PROGN (LETT |er| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |ar1|
                          (COND
                           ((QVELT |er| 7)
                            (|RDEEFX;solve_linear_factor| |nf|
                             (|spadConstant| $ 108) |nfp|
                             (|spadConstant| $ 108) |k| |x| |einum| |er| $))
                           ('T
                            (|RDEEFX;solve_factor1| |nf| (|spadConstant| $ 108)
                             |nfp| (|spadConstant| $ 108) |k| |x| |einum|
                             (QVELT |er| 0)
                             (VECTOR (QVELT |er| 0) (QVELT |er| 1)
                                     (QVELT |er| 2) (QVELT |er| 3)
                                     (QVELT |er| 4) (QVELT |er| 5)
                                     (QVELT |er| 6))
                             $))))
                    (LETT |ansp|
                          (SPADCALL |ansp| (QVELT |ar1| 0) (QREFELT $ 73)))
                    (LETT |lp_cor|
                          (SPADCALL |lp_cor| (QVELT |ar1| 1) (QREFELT $ 328)))
                    (LETT |sp_cor|
                          (SPADCALL |sp_cor| (QVELT |ar1| 3) (QREFELT $ 328)))
                    (EXIT
                     (LETT |poly_cor|
                           (SPADCALL |poly_cor| (QVELT |ar1| 2)
                                     (QREFELT $ 49)))))
                   (LETT #2# (PROG1 (CDR #2#) (LETT #3# (CDR #3#)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT (VECTOR |ansp| |lp_cor| |poly_cor| |sp_cor|))))))))) 

(SDEFUN |RDEEFX;handle_nonlinear_log|
        ((|num| (|SparseUnivariatePolynomial| F))
         (|den| (|SparseUnivariatePolynomial| F))
         (|nf| (|SparseUnivariatePolynomial| F))
         (|denf| (|SparseUnivariatePolynomial| F))
         (|nfp| (|SparseUnivariatePolynomial| F))
         (|denfp| (|SparseUnivariatePolynomial| F)) (|k| (|Kernel| F))
         (|x| (|Symbol|)) (|vlst| (|List| F)) (|ulst| (|List| F))
         (|lei|
          (|List|
           (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F))))
         (|dbasis| (|Vector| (|SparseUnivariatePolynomial| F)))
         (|dtrans| (|Matrix| (|Integer|)))
         ($
          (|Record| (|:| |primpart| F)
                    (|:| |logpart|
                         (|Fraction| (|SparseUnivariatePolynomial| F)))
                    (|:| |polypart| (|SparseUnivariatePolynomial| F))
                    (|:| |specpart|
                         (|Fraction| (|SparseUnivariatePolynomial| F))))))
        (SPROG
         ((|ar1|
           (|Record| (|:| |primpart| F)
                     (|:| |logpart|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |polypart| (|SparseUnivariatePolynomial| F))
                     (|:| |specpart|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))))
          (|einums| (|List| (|SparseUnivariatePolynomial| F)))
          (|er2|
           (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F) (|:| |has_part2?| (|Boolean|))
                     (|:| |ratpart2| (|Integer|)) (|:| |v_part2| F)
                     (|:| |u_part2| F) (|:| |shift_part2| F)))
          (|u1| (F))
          (|uv|
           (|Record| (|:| |u_part| F) (|:| |v_part| F)
                     (|:| |exponent| (|Integer|)) (|:| |coeff| (|Integer|))))
          (|uvu|
           (|Union|
            (|Record| (|:| |u_part| F) (|:| |v_part| F)
                      (|:| |exponent| (|Integer|)) (|:| |coeff| (|Integer|)))
            "failed"))
          (|v1| (F)) (|v0| (F)) (|r1| (|Integer|)) (|ril| (|List| (|Integer|)))
          (#1=#:G1854 NIL) (|er| NIL) (#2=#:G1853 NIL) (|r0| (|Integer|))
          (|er1|
           (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F)))
          (|lei1|
           (|List|
            (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                      (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                      (|:| |u_part| F) (|:| |exponent| (|Integer|))
                      (|:| |shift_part| F))))
          (#3=#:G1851 NIL) (|j| NIL) (#4=#:G1852 NIL)
          (|bpol| (|SparseUnivariatePolynomial| F))
          (|poly_cor| (|SparseUnivariatePolynomial| F))
          (|sp_cor| #5=(|Fraction| (|SparseUnivariatePolynomial| F)))
          (|lp_cor| #5#) (|ansp| (F)) (#6=#:G1848 NIL) (|einum| NIL)
          (#7=#:G1849 NIL) (#8=#:G1850 NIL)
          (|bpols| (|List| (|SparseUnivariatePolynomial| F)))
          (|j0| (|NonNegativeInteger|)) (#9=#:G1845 NIL) (|esum| (|Integer|))
          (#10=#:G1847 NIL) (#11=#:G1846 NIL) (|i| NIL)
          (|m| (|NonNegativeInteger|)) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (LENGTH |lei|)) (LETT |m| (QVSIZE |dbasis|))
              (LETT |bpols| NIL) (LETT |lei1| NIL)
              (SEQ (LETT |i| 1) (LETT #11# |m|) G190
                   (COND ((|greater_SI| |i| #11#) (GO G191)))
                   (SEQ (LETT |esum| 0)
                        (SEQ
                         (EXIT
                          (SEQ (LETT |j| 1) (LETT #10# |n|) G190
                               (COND ((|greater_SI| |j| #10#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((EQL
                                    (SPADCALL |dtrans| |i| |j| (QREFELT $ 329))
                                    1)
                                   (SEQ (LETT |esum| (+ |esum| 1))
                                        (EXIT
                                         (COND
                                          ((EQL |esum| 2)
                                           (PROGN
                                            (LETT #9# 1)
                                            (GO #12=#:G1826)))
                                          ('T (LETT |j0| |j|)))))))))
                               (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                               (EXIT NIL)))
                         #12# (EXIT #9#))
                        (EXIT
                         (COND
                          ((EQL |esum| 1)
                           (SEQ
                            (LETT |bpols|
                                  (CONS (SPADCALL |dbasis| |i| (QREFELT $ 331))
                                        |bpols|))
                            (EXIT
                             (LETT |lei1|
                                   (CONS (SPADCALL |lei| |j0| (QREFELT $ 334))
                                         |lei1|))))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |ansp| (|spadConstant| $ 43))
              (LETT |lp_cor| (|spadConstant| $ 197))
              (LETT |sp_cor| (|spadConstant| $ 197))
              (LETT |poly_cor| (|spadConstant| $ 102))
              (COND
               ((NULL (NULL |bpols|))
                (EXIT
                 (SEQ
                  (LETT |einums| (|RDEEFX;decompose1| |num| |den| |bpols| $))
                  (SEQ (LETT |er| NIL) (LETT #8# |lei1|) (LETT #7# |bpols|)
                       (LETT |einum| NIL) (LETT #6# |einums|) G190
                       (COND
                        ((OR (ATOM #6#) (PROGN (LETT |einum| (CAR #6#)) NIL)
                             (ATOM #7#) (PROGN (LETT |bpol| (CAR #7#)) NIL)
                             (ATOM #8#) (PROGN (LETT |er| (CAR #8#)) NIL))
                         (GO G191)))
                       (SEQ
                        (LETT |ar1|
                              (|RDEEFX;solve_factor1| |nf| |denf| |nfp| |denfp|
                               |k| |x| |einum| |bpol| |er| $))
                        (LETT |ansp|
                              (SPADCALL |ansp| (QVELT |ar1| 0) (QREFELT $ 73)))
                        (LETT |lp_cor|
                              (SPADCALL |lp_cor| (QVELT |ar1| 1)
                                        (QREFELT $ 328)))
                        (LETT |sp_cor|
                              (SPADCALL |sp_cor| (QVELT |ar1| 3)
                                        (QREFELT $ 328)))
                        (EXIT
                         (LETT |poly_cor|
                               (SPADCALL |poly_cor| (QVELT |ar1| 2)
                                         (QREFELT $ 49)))))
                       (LETT #6#
                             (PROG1 (CDR #6#)
                               (LETT #7#
                                     (PROG1 (CDR #7#) (LETT #8# (CDR #8#))))))
                       (GO G190) G191 (EXIT NIL))
                  (EXIT (VECTOR |ansp| |lp_cor| |poly_cor| |sp_cor|))))))
              (LETT |bpol| (SPADCALL |dbasis| 1 (QREFELT $ 331)))
              (EXIT
               (COND
                ((SPADCALL (SPADCALL |bpol| (QREFELT $ 40)) 1 (QREFELT $ 230))
                 (|error| "degree(bpol) ~= 1"))
                (#13='T
                 (SEQ
                  (SEQ (LETT |er| NIL) (LETT #4# |lei|) (LETT |j| 1)
                       (LETT #3# |n|) G190
                       (COND
                        ((OR (|greater_SI| |j| #3#) (ATOM #4#)
                             (PROGN (LETT |er| (CAR #4#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((EQL (SPADCALL |dtrans| 1 |j| (QREFELT $ 329)) 1)
                           (LETT |lei1| (CONS |er| |lei1|))))))
                       (LETT |j| (PROG1 (|inc_SI| |j|) (LETT #4# (CDR #4#))))
                       (GO G190) G191 (EXIT NIL))
                  (LETT |er1| (|SPADfirst| |lei1|)) (LETT |r0| (QVELT |er1| 1))
                  (LETT |lei| (CDR |lei1|))
                  (LETT |ril|
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |er| NIL) (LETT #1# |lei|) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |er| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2# (CONS (- (QVELT |er| 1) |r0|) #2#))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#)))))
                  (LETT |r1| (SPADCALL |ril| (QREFELT $ 115)))
                  (LETT |v0| (QVELT |er1| 2))
                  (LETT |v1|
                        (SPADCALL (QVELT (|SPADfirst| |lei|) 2) |v0|
                                  (QREFELT $ 77)))
                  (LETT |v1|
                        (SPADCALL
                         (SPADCALL (SPADCALL |r1| (QREFELT $ 74))
                                   (SPADCALL
                                    (- (QVELT (|SPADfirst| |lei|) 1) |r0|)
                                    (QREFELT $ 74))
                                   (QREFELT $ 67))
                         |v1| (QREFELT $ 65)))
                  (LETT |uvu| (|RDEEFX;get_uv| |v1| |vlst| |ulst| |k| |x| $))
                  (EXIT
                   (COND
                    ((QEQCAR |uvu| 1) (|error| "impossible, get_uv failed"))
                    (#13#
                     (SEQ (LETT |uv| (QCDR |uvu|))
                          (LETT |u1|
                                (SPADCALL (QVELT |uv| 0)
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |k| (QREFELT $ 27)) 1
                                            (QREFELT $ 29))
                                           |r1| (QREFELT $ 79))
                                          (QREFELT $ 65)))
                          (LETT |er2|
                                (VECTOR |bpol| |r0| |v0| (|spadConstant| $ 102)
                                        (QVELT |er1| 4) 0 (QVELT |er1| 6) 'T
                                        |r1| |v1| |u1| (QVELT |uv| 1)))
                          (LETT |einums|
                                (|RDEEFX;decompose1| |num| |den| (LIST |bpol|)
                                 $))
                          (LETT |ar1|
                                (|RDEEFX;solve_linear_factor| |nf| |denf| |nfp|
                                 |denfp| |k| |x| (|SPADfirst| |einums|) |er2|
                                 $))
                          (EXIT |ar1|)))))))))))) 

(SDEFUN |RDEEFX;handle_logpart|
        ((|num| (|SparseUnivariatePolynomial| F))
         (|den| (|SparseUnivariatePolynomial| F))
         (|nf| (|SparseUnivariatePolynomial| F))
         (|denf| (|SparseUnivariatePolynomial| F))
         (|nfp| (|SparseUnivariatePolynomial| F))
         (|denfp| (|SparseUnivariatePolynomial| F)) (|k| (|Kernel| F))
         (|vlst| (|List| F)) (|ulst| (|List| F)) (|x| (|Symbol|))
         ($
          (|Record| (|:| |primpart| F)
                    (|:| |logpart|
                         (|Fraction| (|SparseUnivariatePolynomial| F)))
                    (|:| |polypart| (|SparseUnivariatePolynomial| F))
                    (|:| |specpart|
                         (|Fraction| (|SparseUnivariatePolynomial| F))))))
        (SPROG
         ((|poly_cor| (|SparseUnivariatePolynomial| F))
          (|sp_cor| #1=(|Fraction| (|SparseUnivariatePolynomial| F)))
          (|lp_cor| #1#) (|ansp| (F))
          (|ar1|
           (|Record| (|:| |primpart| F)
                     (|:| |logpart|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |polypart| (|SparseUnivariatePolynomial| F))
                     (|:| |specpart|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))))
          (#2=#:G1895 NIL) (|einum| NIL) (#3=#:G1896 NIL) (|er| NIL)
          (|einums| (|List| (|SparseUnivariatePolynomial| F)))
          (|dtrans| #4=(|Matrix| (|Integer|)))
          (|dbasis| #5=(|Vector| (|SparseUnivariatePolynomial| F)))
          (|lei|
           (|List|
            (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                      (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                      (|:| |u_part| F) (|:| |exponent| (|Integer|))
                      (|:| |shift_part| F))))
          (|ninds| (|List| (|Integer|)))
          (|eidens| (|List| (|SparseUnivariatePolynomial| F)))
          (|lei1|
           (|List|
            (|Record| (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |ratpart| (|Integer|)) (|:| |v_part| F)
                      (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                      (|:| |u_part| F) (|:| |exponent| (|Integer|))
                      (|:| |shift_part| F))))
          (|neidens| (|List| (|SparseUnivariatePolynomial| F)))
          (#6=#:G1892 NIL) (|i| NIL) (#7=#:G1893 NIL) (|eiden| NIL)
          (#8=#:G1894 NIL) (|n| (|NonNegativeInteger|))
          (|nidbl| (|List| (|Integer|)))
          (|ndbl| (|List| (|SparseUnivariatePolynomial| F)))
          (|bi| (|SparseUnivariatePolynomial| F)) (#9=#:G1891 NIL)
          (|m| (|NonNegativeInteger|)) (#10=#:G1888 NIL)
          (|lp| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (|dr| (|Record| (|:| |basis| #5#) (|:| |transform| #4#)))
          (#11=#:G1890 NIL) (#12=#:G1889 NIL))
         (SEQ
          (COND
           ((SPADCALL |k| '|log| (QREFELT $ 22))
            (COND
             ((SPADCALL |denf| (|spadConstant| $ 108) (QREFELT $ 111))
              (COND
               ((<= (SPADCALL |nf| (QREFELT $ 40)) 1)
                (EXIT
                 (|RDEEFX;linear_log_case| |num| |den| |nf| |nfp| |k| |vlst|
                  |ulst| |x| $))))))))
          (COND
           ((SPADCALL |denf| (|spadConstant| $ 108) (QREFELT $ 111))
            (COND
             ((EQL (SPADCALL |nf| (QREFELT $ 40)) 0)
              (EXIT
               (VECTOR (|spadConstant| $ 43) (|spadConstant| $ 197)
                       (|spadConstant| $ 102) (|spadConstant| $ 197)))))))
          (LETT |lei|
                (|RDEEFX;ei_args| |den| |nf| |denf| |k| |vlst| |ulst| |x| $))
          (EXIT
           (COND
            ((NULL |lei|)
             (VECTOR (|spadConstant| $ 43) (|spadConstant| $ 197)
                     (|spadConstant| $ 102) (|spadConstant| $ 197)))
            (#13='T
             (SEQ
              (LETT |eidens|
                    (PROGN
                     (LETT #12# NIL)
                     (SEQ (LETT |er| NIL) (LETT #11# |lei|) G190
                          (COND
                           ((OR (ATOM #11#) (PROGN (LETT |er| (CAR #11#)) NIL))
                            (GO G191)))
                          (SEQ (EXIT (LETT #12# (CONS (QVELT |er| 0) #12#))))
                          (LETT #11# (CDR #11#)) (GO G190) G191
                          (EXIT (NREVERSE #12#)))))
              (LETT |ansp| (|spadConstant| $ 43))
              (LETT |lp_cor| (|spadConstant| $ 197))
              (LETT |sp_cor| (|spadConstant| $ 197))
              (LETT |poly_cor| (|spadConstant| $ 102))
              (EXIT
               (COND
                ((SPADCALL |k| '|log| (QREFELT $ 22))
                 (SEQ
                  (LETT |dr|
                        (SPADCALL (SPADCALL |eidens| (QREFELT $ 335))
                                  (QREFELT $ 338)))
                  (LETT |dbasis| (QCAR |dr|)) (LETT |dtrans| (QCDR |dr|))
                  (LETT |lp|
                        (SPADCALL (SPADCALL |num| (QREFELT $ 47))
                                  (SPADCALL |den| (QREFELT $ 47))
                                  (QREFELT $ 50)))
                  (SEQ
                   (EXIT
                    (SEQ G190 NIL
                         (SEQ
                          (LETT |ar1|
                                (|RDEEFX;handle_nonlinear_log| |num| |den| |nf|
                                 |denf| |nfp| |denfp| |k| |x| |vlst| |ulst|
                                 |lei| |dbasis| |dtrans| $))
                          (LETT |ansp|
                                (SPADCALL |ansp| (QVELT |ar1| 0)
                                          (QREFELT $ 73)))
                          (LETT |lp_cor|
                                (SPADCALL |lp_cor| (QVELT |ar1| 1)
                                          (QREFELT $ 328)))
                          (LETT |sp_cor|
                                (SPADCALL |sp_cor| (QVELT |ar1| 3)
                                          (QREFELT $ 328)))
                          (LETT |poly_cor|
                                (SPADCALL |poly_cor| (QVELT |ar1| 2)
                                          (QREFELT $ 49)))
                          (EXIT
                           (COND
                            ((SPADCALL (QVELT |ar1| 1) (|spadConstant| $ 197)
                                       (QREFELT $ 339))
                             (PROGN (LETT #10# 1) (GO #14=#:G1879)))
                            ('T
                             (SEQ
                              (LETT |lp|
                                    (SPADCALL |lp| (QVELT |ar1| 1)
                                              (QREFELT $ 270)))
                              (EXIT
                               (COND
                                ((SPADCALL |lp| (|spadConstant| $ 197)
                                           (QREFELT $ 339))
                                 (PROGN (LETT #10# 1) (GO #14#)))
                                ('T
                                 (SEQ
                                  (LETT |num| (SPADCALL |lp| (QREFELT $ 38)))
                                  (LETT |den| (SPADCALL |lp| (QREFELT $ 39)))
                                  (LETT |ndbl| NIL) (LETT |nidbl| NIL)
                                  (LETT |m| (QVSIZE |dbasis|))
                                  (SEQ (LETT |i| 1) (LETT #9# |m|) G190
                                       (COND
                                        ((|greater_SI| |i| #9#) (GO G191)))
                                       (SEQ
                                        (LETT |bi|
                                              (SPADCALL |dbasis| |i|
                                                        (QREFELT $ 331)))
                                        (EXIT
                                         (COND
                                          ((QEQCAR
                                            (SPADCALL |den| |bi|
                                                      (QREFELT $ 107))
                                            0)
                                           (SEQ
                                            (LETT |ndbl| (CONS |bi| |ndbl|))
                                            (EXIT
                                             (LETT |nidbl|
                                                   (CONS |i| |nidbl|))))))))
                                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                       (EXIT NIL))
                                  (EXIT
                                   (COND
                                    ((EQL (LENGTH |ndbl|) |m|)
                                     (|error|
                                      "no progress in handle_nonlinear_log"))
                                    ('T
                                     (SEQ (LETT |ndbl| (NREVERSE |ndbl|))
                                          (LETT |nidbl| (NREVERSE |nidbl|))
                                          (LETT |neidens| NIL)
                                          (LETT |ninds| NIL) (LETT |lei1| NIL)
                                          (LETT |n| (LENGTH |eidens|))
                                          (SEQ (LETT |er| NIL) (LETT #8# |lei|)
                                               (LETT |eiden| NIL)
                                               (LETT #7# |eidens|) (LETT |i| 1)
                                               (LETT #6# |n|) G190
                                               (COND
                                                ((OR (|greater_SI| |i| #6#)
                                                     (ATOM #7#)
                                                     (PROGN
                                                      (LETT |eiden| (CAR #7#))
                                                      NIL)
                                                     (ATOM #8#)
                                                     (PROGN
                                                      (LETT |er| (CAR #8#))
                                                      NIL))
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (COND
                                                  ((QEQCAR
                                                    (SPADCALL |den| |eiden|
                                                              (QREFELT $ 107))
                                                    0)
                                                   (SEQ
                                                    (LETT |neidens|
                                                          (CONS |eiden|
                                                                |neidens|))
                                                    (LETT |ninds|
                                                          (CONS |i| |ninds|))
                                                    (EXIT
                                                     (LETT |lei1|
                                                           (CONS |er|
                                                                 |lei1|))))))))
                                               (LETT |i|
                                                     (PROG1 (|inc_SI| |i|)
                                                       (LETT #7#
                                                             (PROG1 (CDR #7#)
                                                               (LETT #8#
                                                                     (CDR
                                                                      #8#))))))
                                               (GO G190) G191 (EXIT NIL))
                                          (LETT |eidens| (NREVERSE |neidens|))
                                          (LETT |ninds| (NREVERSE |ninds|))
                                          (LETT |lei| (NREVERSE |lei1|))
                                          (LETT |dbasis|
                                                (SPADCALL |ndbl|
                                                          (QREFELT $ 335)))
                                          (EXIT
                                           (LETT |dtrans|
                                                 (SPADCALL |dtrans| |nidbl|
                                                           |ninds|
                                                           (QREFELT $
                                                                    340)))))))))))))))))
                         NIL (GO G190) G191 (EXIT NIL)))
                   #14# (EXIT #10#))
                  (EXIT (VECTOR |ansp| |lp_cor| |poly_cor| |sp_cor|))))
                (#13#
                 (SEQ
                  (LETT |einums| (|RDEEFX;decompose1| |num| |den| |eidens| $))
                  (SEQ (LETT |er| NIL) (LETT #3# |lei|) (LETT |einum| NIL)
                       (LETT #2# |einums|) G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |einum| (CAR #2#)) NIL)
                             (ATOM #3#) (PROGN (LETT |er| (CAR #3#)) NIL))
                         (GO G191)))
                       (SEQ
                        (LETT |ar1|
                              (|RDEEFX;solve_factor1| |nf| |denf| |nfp| |denfp|
                               |k| |x| |einum| (QVELT |er| 0) |er| $))
                        (LETT |ansp|
                              (SPADCALL |ansp| (QVELT |ar1| 0) (QREFELT $ 73)))
                        (LETT |lp_cor|
                              (SPADCALL |lp_cor| (QVELT |ar1| 1)
                                        (QREFELT $ 328)))
                        (LETT |sp_cor|
                              (SPADCALL |sp_cor| (QVELT |ar1| 3)
                                        (QREFELT $ 328)))
                        (EXIT
                         (LETT |poly_cor|
                               (SPADCALL |poly_cor| (QVELT |ar1| 2)
                                         (QREFELT $ 49)))))
                       (LETT #2# (PROG1 (CDR #2#) (LETT #3# (CDR #3#))))
                       (GO G190) G191 (EXIT NIL))
                  (EXIT (VECTOR |ansp| |lp_cor| |poly_cor| |sp_cor|))))))))))))) 

(SDEFUN |RDEEFX;gamma_denominator|
        ((|denf| #1=(|SparseUnivariatePolynomial| F)) (|k| (|Kernel| F))
         ($
          (|Record| (|:| |radicand| (|SparseUnivariatePolynomial| F))
                    (|:| |exponent| (|Integer|)))))
        (SPROG
         ((|gden1| (|SparseUnivariatePolynomial| F)) (#2=#:G1930 NIL)
          (#3=#:G1926 NIL) (#4=#:G1938 NIL) (|fac1| NIL) (#5=#:G1937 NIL)
          (|l1| (|Integer|)) (|lexp| (|List| (|Integer|))) (#6=#:G1936 NIL)
          (#7=#:G1935 NIL)
          (|nffacs|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|fnf| (|Factored| (|SparseUnivariatePolynomial| F))) (|denf1| #1#)
          (#8=#:G1900 NIL) (#9=#:G1898 NIL) (|s_deg| (|Integer|)))
         (SEQ (LETT |s_deg| 0) (LETT |denf1| |denf|)
              (COND
               ((SPADCALL |k| '|exp| (QREFELT $ 22))
                (SEQ (LETT |s_deg| (SPADCALL |denf| (QREFELT $ 216)))
                     (EXIT
                      (LETT |denf1|
                            (PROG2
                                (LETT #8#
                                      (SPADCALL |denf|
                                                (SPADCALL (|spadConstant| $ 32)
                                                          (PROG1
                                                              (LETT #9#
                                                                    |s_deg|)
                                                            (|check_subtype2|
                                                             (>= #9# 0)
                                                             '(|NonNegativeInteger|)
                                                             '(|Integer|) #9#))
                                                          (QREFELT $ 44))
                                                (QREFELT $ 107)))
                                (QCDR #8#)
                              (|check_union2| (QEQCAR #8# 0)
                                              (|SparseUnivariatePolynomial|
                                               (QREFELT $ 7))
                                              (|Union|
                                               (|SparseUnivariatePolynomial|
                                                (QREFELT $ 7))
                                               "failed")
                                              #8#)))))))
              (EXIT
               (COND
                ((SPADCALL |denf1| (|spadConstant| $ 108) (QREFELT $ 111))
                 (COND ((EQL |s_deg| 0) (CONS (|spadConstant| $ 108) 0))
                       (#10='T
                        (CONS (SPADCALL (|spadConstant| $ 32) 1 (QREFELT $ 44))
                              |s_deg|))))
                (#10#
                 (SEQ (LETT |fnf| (SPADCALL |denf1| (QREFELT $ 240)))
                      (LETT |nffacs| (SPADCALL |fnf| (QREFELT $ 130)))
                      (LETT |lexp|
                            (PROGN
                             (LETT #7# NIL)
                             (SEQ (LETT |fac1| NIL) (LETT #6# |nffacs|) G190
                                  (COND
                                   ((OR (ATOM #6#)
                                        (PROGN (LETT |fac1| (CAR #6#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #7# (CONS (QVELT |fac1| 2) #7#))))
                                  (LETT #6# (CDR #6#)) (GO G190) G191
                                  (EXIT (NREVERSE #7#)))))
                      (LETT |l1|
                            (SPADCALL (CONS |s_deg| |lexp|) (QREFELT $ 115)))
                      (EXIT
                       (COND ((EQL |l1| 1) (CONS |denf| 1))
                             (#10#
                              (SEQ
                               (LETT |gden1|
                                     (SPADCALL (ELT $ 97)
                                               (PROGN
                                                (LETT #5# NIL)
                                                (SEQ (LETT |fac1| NIL)
                                                     (LETT #4# |nffacs|) G190
                                                     (COND
                                                      ((OR (ATOM #4#)
                                                           (PROGN
                                                            (LETT |fac1|
                                                                  (CAR #4#))
                                                            NIL))
                                                       (GO G191)))
                                                     (SEQ
                                                      (EXIT
                                                       (LETT #5#
                                                             (CONS
                                                              (|RDEEFX;my_exp|
                                                               (QVELT |fac1| 1)
                                                               (PROG1
                                                                   (LETT #3#
                                                                         (QUOTIENT2
                                                                          (QVELT
                                                                           |fac1|
                                                                           2)
                                                                          |l1|))
                                                                 (|check_subtype2|
                                                                  (>= #3# 0)
                                                                  '(|NonNegativeInteger|)
                                                                  '(|Integer|)
                                                                  #3#))
                                                               $)
                                                              #5#))))
                                                     (LETT #4# (CDR #4#))
                                                     (GO G190) G191
                                                     (EXIT (NREVERSE #5#))))
                                               (QREFELT $ 310)))
                               (COND
                                ((> |s_deg| 0)
                                 (LETT |gden1|
                                       (SPADCALL
                                        (SPADCALL (|spadConstant| $ 32)
                                                  (PROG1
                                                      (LETT #2#
                                                            (QUOTIENT2 |s_deg|
                                                                       |l1|))
                                                    (|check_subtype2|
                                                     (>= #2# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #2#))
                                                  (QREFELT $ 44))
                                        |gden1| (QREFELT $ 97)))))
                               (EXIT (CONS |gden1| |l1|))))))))))))) 

(SDEFUN |RDEEFX;special_Hermite|
        ((|r| (|Fraction| (|SparseUnivariatePolynomial| F)))
         (|nfp| (|SparseUnivariatePolynomial| F))
         (|ndenf| (|SparseUnivariatePolynomial| F))
         (|denfp| (|SparseUnivariatePolynomial| F))
         (|deriv|
          (|Mapping| (|SparseUnivariatePolynomial| F)
                     (|SparseUnivariatePolynomial| F)))
         ($
          (|Record|
           (|:| |answer| (|Fraction| (|SparseUnivariatePolynomial| F)))
           (|:| |specpart| (|Fraction| (|SparseUnivariatePolynomial| F))))))
        (SPROG
         ((|mult| (|SparseUnivariatePolynomial| F))
          (|denr| #1=(|SparseUnivariatePolynomial| F)) (#2=#:G1946 NIL)
          (|numr| (|SparseUnivariatePolynomial| F))
          (|nfp1| (|SparseUnivariatePolynomial| F))
          (|an| (|SparseUnivariatePolynomial| F))
          (|nn| (|SparseUnivariatePolynomial| F))
          (|ee|
           (|Record| (|:| |coef1| (|SparseUnivariatePolynomial| F))
                     (|:| |coef2| (|SparseUnivariatePolynomial| F))))
          (#3=#:G1943 NIL) (#4=#:G1953 NIL)
          (|hh1| (|SparseUnivariatePolynomial| F)) (|ad| #1#))
         (SEQ
          (EXIT
           (SEQ (LETT |ad| (LETT |denr| (SPADCALL |r| (QREFELT $ 39))))
                (LETT |numr| (SPADCALL |r| (QREFELT $ 38)))
                (LETT |an| (|spadConstant| $ 102))
                (LETT |mult| (|spadConstant| $ 108))
                (EXIT
                 (SEQ G190 NIL
                      (SEQ
                       (LETT |hh1| (SPADCALL |denr| |ndenf| (QREFELT $ 105)))
                       (EXIT
                        (COND
                         ((EQL (SPADCALL |hh1| (QREFELT $ 40)) 0)
                          (PROGN
                           (LETT #4#
                                 (CONS
                                  (SPADCALL
                                   (SPADCALL |denfp| |an| (QREFELT $ 97)) |ad|
                                   (QREFELT $ 196))
                                  (SPADCALL |numr| |denr| (QREFELT $ 196))))
                           (GO #5=#:G1952)))
                         ('T
                          (SEQ
                           (LETT |ee|
                                 (PROG2
                                     (LETT #3#
                                           (SPADCALL |nfp| |hh1| |numr|
                                                     (QREFELT $ 322)))
                                     (QCDR #3#)
                                   (|check_union2| (QEQCAR #3# 0)
                                                   (|Record|
                                                    (|:| |coef1|
                                                         (|SparseUnivariatePolynomial|
                                                          (QREFELT $ 7)))
                                                    (|:| |coef2|
                                                         (|SparseUnivariatePolynomial|
                                                          (QREFELT $ 7))))
                                                   (|Union|
                                                    (|Record|
                                                     (|:| |coef1|
                                                          (|SparseUnivariatePolynomial|
                                                           (QREFELT $ 7)))
                                                     (|:| |coef2|
                                                          (|SparseUnivariatePolynomial|
                                                           (QREFELT $ 7))))
                                                    "failed")
                                                   #3#)))
                           (LETT |nn|
                                 (SPADCALL (QCAR |ee|) |hh1| (QREFELT $ 190)))
                           (LETT |an|
                                 (SPADCALL |an|
                                           (SPADCALL |mult| |nn|
                                                     (QREFELT $ 97))
                                           (QREFELT $ 49)))
                           (LETT |nfp1|
                                 (SPADCALL |nfp|
                                           (PROG2
                                               (LETT #2#
                                                     (SPADCALL
                                                      (SPADCALL |denfp|
                                                                (SPADCALL
                                                                 |denr|
                                                                 |deriv|)
                                                                (QREFELT $ 97))
                                                      |denr| (QREFELT $ 107)))
                                               (QCDR #2#)
                                             (|check_union2| (QEQCAR #2# 0)
                                                             (|SparseUnivariatePolynomial|
                                                              (QREFELT $ 7))
                                                             (|Union|
                                                              (|SparseUnivariatePolynomial|
                                                               (QREFELT $ 7))
                                                              #6="failed")
                                                             #2#))
                                           (QREFELT $ 46)))
                           (LETT |numr|
                                 (SPADCALL
                                  (SPADCALL |numr|
                                            (SPADCALL |nfp1| |nn|
                                                      (QREFELT $ 97))
                                            (QREFELT $ 46))
                                  (SPADCALL
                                   (SPADCALL |denfp| |nn| (QREFELT $ 97))
                                   |deriv|)
                                  (QREFELT $ 46)))
                           (LETT |numr|
                                 (PROG2
                                     (LETT #2#
                                           (SPADCALL |numr| |hh1|
                                                     (QREFELT $ 107)))
                                     (QCDR #2#)
                                   (|check_union2| (QEQCAR #2# 0)
                                                   (|SparseUnivariatePolynomial|
                                                    (QREFELT $ 7))
                                                   (|Union|
                                                    (|SparseUnivariatePolynomial|
                                                     (QREFELT $ 7))
                                                    #6#)
                                                   #2#)))
                           (LETT |denr|
                                 (PROG2
                                     (LETT #2#
                                           (SPADCALL |denr| |hh1|
                                                     (QREFELT $ 107)))
                                     (QCDR #2#)
                                   (|check_union2| (QEQCAR #2# 0)
                                                   (|SparseUnivariatePolynomial|
                                                    (QREFELT $ 7))
                                                   (|Union|
                                                    (|SparseUnivariatePolynomial|
                                                     (QREFELT $ 7))
                                                    #6#)
                                                   #2#)))
                           (EXIT
                            (LETT |mult|
                                  (SPADCALL |mult| |hh1| (QREFELT $ 97)))))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #5# (EXIT #4#)))) 

(SDEFUN |RDEEFX;ei_int_log|
        ((|f| (F)) (|ng| (|SparseUnivariatePolynomial| F)) (|x| (|Symbol|))
         (|k| (|Kernel| F))
         ($
          (|Record| (|:| |ans| F) (|:| |right| F) (|:| |primpart| F)
                    (|:| |sol?| (|Boolean|)))))
        (SPROG
         ((|is_sol| (|Boolean|)) (|rh| (F)) (|r1| (F))
          (|res2|
           (|Record| (|:| |ans| F) (|:| |right| F) (|:| |primpart| F)
                     (|:| |sol?| (|Boolean|))))
          (|gm| (F)) (|kfm| (F)) (|am1| (F))
          (|res1|
           (|Record| (|:| |ans| F) (|:| |right| F) (|:| |primpart| F)
                     (|:| |sol?| (|Boolean|))))
          (|m| NIL) (|dk| (F)) (|kf| (F)) (|lk| (|List| (|Kernel| F)))
          (#1=#:G1964 NIL) (|k1| NIL) (#2=#:G1963 NIL) (|ngu| (F)))
         (SEQ
          (LETT |ngu|
                (SPADCALL (SPADCALL |ng| (QREFELT $ 47)) |k| (QREFELT $ 60)))
          (LETT |lk|
                (SPADCALL
                 (SPADCALL (SPADCALL |f| (QREFELT $ 341))
                           (SPADCALL |ngu| (QREFELT $ 341)) (QREFELT $ 16))
                 |x| (QREFELT $ 15)))
          (LETT |lk|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |k1| NIL) (LETT #1# |lk|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |k1| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL |k1| |k| (QREFELT $ 342))
                          (LETT #2# (CONS |k1| #2#))))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (LETT |kf| (SPADCALL |k| (QREFELT $ 61)))
          (LETT |dk| (SPADCALL |kf| |x| (QREFELT $ 62)))
          (LETT |r1| (|spadConstant| $ 43)) (LETT |is_sol| 'T)
          (LETT |rh| (|spadConstant| $ 43)) (LETT |am1| (|spadConstant| $ 43))
          (SEQ (LETT |m| (SPADCALL |ng| (QREFELT $ 40))) G190
               (COND ((< |m| 1) (GO G191)))
               (SEQ
                (LETT |gm|
                      (SPADCALL
                       (SPADCALL
                        (SPADCALL (SPADCALL (+ |m| 1) (QREFELT $ 74)) |dk|
                                  (QREFELT $ 65))
                        |am1| (QREFELT $ 65))
                       (QREFELT $ 48)))
                (COND
                 ((EQL |m| (SPADCALL |ng| (QREFELT $ 40)))
                  (SEQ
                   (LETT |gm|
                         (SPADCALL |gm| (SPADCALL |ng| (QREFELT $ 103))
                                   (QREFELT $ 73)))
                   (EXIT (LETT |ng| (SPADCALL |ng| (QREFELT $ 110)))))))
                (LETT |res1| (SPADCALL |f| |gm| |x| |lk| (QREFELT $ 56)))
                (LETT |is_sol| (COND (|is_sol| (QVELT |res1| 3)) ('T NIL)))
                (LETT |am1| (QVELT |res1| 0))
                (LETT |kfm| (SPADCALL |kf| |m| (QREFELT $ 343)))
                (LETT |r1|
                      (SPADCALL |r1| (SPADCALL |kfm| |am1| (QREFELT $ 65))
                                (QREFELT $ 73)))
                (EXIT
                 (LETT |rh|
                       (SPADCALL
                        (SPADCALL |rh|
                                  (SPADCALL |kfm| (QVELT |res1| 1)
                                            (QREFELT $ 65))
                                  (QREFELT $ 73))
                        (SPADCALL
                         (SPADCALL (SPADCALL |m| (QREFELT $ 74)) |dk|
                                   (QREFELT $ 65))
                         |am1| (QREFELT $ 65))
                        (QREFELT $ 73)))))
               (LETT |m| (+ |m| -1)) (GO G190) G191 (EXIT NIL))
          (LETT |gm|
                (SPADCALL (SPADCALL |ng| (QREFELT $ 202))
                          (SPADCALL |dk| |am1| (QREFELT $ 65)) (QREFELT $ 77)))
          (LETT |res2| (SPADCALL 1 |f| |gm| |x| (QREFELT $ 66)))
          (LETT |r1| (SPADCALL |r1| (QVELT |res2| 0) (QREFELT $ 73)))
          (LETT |rh| (SPADCALL |rh| (QVELT |res2| 1) (QREFELT $ 73)))
          (LETT |is_sol| (COND (|is_sol| (QVELT |res2| 3)) ('T NIL)))
          (EXIT (VECTOR |r1| |rh| (QVELT |res2| 2) |is_sol|))))) 

(SDEFUN |RDEEFX;ei_int_exp|
        ((|f| (F)) (|ng| (|SparseUnivariatePolynomial| F))
         (|degs| (|NonNegativeInteger|)) (|x| (|Symbol|)) (|k| (|Kernel| F))
         ($
          (|Record| (|:| |ans| F) (|:| |right| F) (|:| |primpart| F)
                    (|:| |sol?| (|Boolean|)))))
        (SPROG
         ((|is_sol| (|Boolean|)) (|rh| (F)) (|ansp| (F)) (|r1| (F)) (|kfm| (F))
          (|res1|
           (|Record| (|:| |ans| F) (|:| |right| F) (|:| |primpart| F)
                     (|:| |sol?| (|Boolean|))))
          (|f1| (F)) (|gm| (F)) (|m| (|Integer|)) (|kf| (F)) (|ak| (F)))
         (SEQ
          (LETT |ak| (SPADCALL (SPADCALL |k| (QREFELT $ 27)) 1 (QREFELT $ 29)))
          (LETT |kf| (SPADCALL |k| (QREFELT $ 61)))
          (LETT |r1| (|spadConstant| $ 43)) (LETT |ansp| (|spadConstant| $ 43))
          (LETT |is_sol| 'T) (LETT |rh| (|spadConstant| $ 43))
          (SEQ G190
               (COND
                ((NULL (SPADCALL |ng| (|spadConstant| $ 102) (QREFELT $ 109)))
                 (GO G191)))
               (SEQ (LETT |m| (- (SPADCALL |ng| (QREFELT $ 40)) |degs|))
                    (LETT |gm| (SPADCALL |ng| (QREFELT $ 103)))
                    (LETT |ng| (SPADCALL |ng| (QREFELT $ 110)))
                    (LETT |f1|
                          (SPADCALL |f|
                                    (SPADCALL (SPADCALL |m| (QREFELT $ 74))
                                              |ak| (QREFELT $ 65))
                                    (QREFELT $ 73)))
                    (LETT |res1| (SPADCALL 1 |f1| |gm| |x| (QREFELT $ 66)))
                    (LETT |kfm| (SPADCALL |kf| |m| (QREFELT $ 79)))
                    (LETT |r1|
                          (SPADCALL |r1|
                                    (SPADCALL |kfm| (QVELT |res1| 0)
                                              (QREFELT $ 65))
                                    (QREFELT $ 73)))
                    (LETT |ansp|
                          (SPADCALL |ansp| (QVELT |res1| 2) (QREFELT $ 73)))
                    (LETT |rh|
                          (SPADCALL |rh|
                                    (SPADCALL |kfm| (QVELT |res1| 1)
                                              (QREFELT $ 65))
                                    (QREFELT $ 73)))
                    (EXIT
                     (LETT |is_sol|
                           (COND (|is_sol| (QVELT |res1| 3)) ('T NIL)))))
               NIL (GO G190) G191 (EXIT NIL))
          (EXIT (VECTOR |r1| |rh| |ansp| |is_sol|))))) 

(SDEFUN |RDEEFX;get_scoeff|
        ((|scand|
          (|Record| (|:| |degree| (|Integer|))
                    (|:| |factor| (|SparseUnivariatePolynomial| F))
                    (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                    (|:| |v_part| F)
                    (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                    (|:| |new_f| (|Fraction| (|SparseUnivariatePolynomial| F)))
                    (|:| |radicand|
                         (|Fraction| (|SparseUnivariatePolynomial| F)))
                    (|:| |u_part| F) (|:| |exponent| (|Integer|))
                    (|:| |shift_part| F) (|:| |a_val| F)))
         (|denf| (|SparseUnivariatePolynomial| F)) (|k| (|Kernel| F))
         (|der|
          (|Mapping| #1=(|Fraction| (|SparseUnivariatePolynomial| F))
                     (|Fraction| (|SparseUnivariatePolynomial| F))))
         (|res| (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
         ($ (|List| (|Fraction| (|SparseUnivariatePolynomial| F)))))
        (SPROG
         ((|gt| #2=(|Fraction| (|SparseUnivariatePolynomial| F)))
          (|gt1| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (#3=#:G1985 NIL) (|i| NIL)
          (|nf2| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (|l1| (|NonNegativeInteger|)) (#4=#:G1978 NIL) (|rf1k| (|Kernel| F))
          (|rfc| (F)) (|coeff1_r| #2#)
          (|coeff1| (|Fraction| (|SparseUnivariatePolynomial| F))) (|nfp| #1#)
          (|d| (|Integer|)) (|u_exp| (|Integer|)) (|u0| (F)) (|ak| (F))
          (|nf1| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (|cfac| (|SparseUnivariatePolynomial| F)) (|r0| (|Integer|)))
         (SEQ (LETT |r0| (QVELT |scand| 3)) (LETT |cfac| (QVELT |scand| 5))
              (LETT |u0| (QVELT |scand| 8)) (LETT |nf1| (QVELT |scand| 6))
              (COND
               ((SPADCALL |r0| 0 (QREFELT $ 89))
                (SEQ
                 (LETT |ak|
                       (SPADCALL (SPADCALL |k| (QREFELT $ 27)) 1
                                 (QREFELT $ 29)))
                 (EXIT
                  (LETT |u0|
                        (SPADCALL |u0| (SPADCALL |ak| |r0| (QREFELT $ 79))
                                  (QREFELT $ 65)))))))
              (LETT |u_exp| (QVELT |scand| 9)) (LETT |d| (QVELT |scand| 0))
              (EXIT
               (COND
                ((EQL |d| 0)
                 (SEQ (LETT |nfp| (SPADCALL |nf1| |der|))
                      (LETT |coeff1|
                            (SPADCALL (SPADCALL |u0| (QREFELT $ 45)) |nfp|
                                      (QREFELT $ 271)))
                      (EXIT (CONS |coeff1| |res|))))
                ((EQL |d| 1)
                 (SEQ (LETT |nfp| (SPADCALL |nf1| |der|))
                      (COND
                       ((OR
                         (SPADCALL (QVELT |scand| 2) (|spadConstant| $ 32)
                                   (QREFELT $ 131))
                         (SPADCALL |cfac| (|spadConstant| $ 102)
                                   (QREFELT $ 109)))
                        (EXIT (|error| "impossible coeff"))))
                      (LETT |coeff1|
                            (SPADCALL
                             (SPADCALL (SPADCALL |u0| (QREFELT $ 45)) |nfp|
                                       (QREFELT $ 271))
                             |nf1| (QREFELT $ 50)))
                      (LETT |coeff1_r|
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL (|spadConstant| $ 32) 1
                                         (QREFELT $ 44))
                               (QREFELT $ 47))
                              |u_exp| (QREFELT $ 315))
                             |coeff1| (QREFELT $ 316)))
                      (EXIT (CONS |coeff1_r| |res|))))
                ((> |d| 1)
                 (SEQ
                  (COND
                   ((SPADCALL |cfac| (|spadConstant| $ 102) (QREFELT $ 109))
                    (SEQ (LETT |rfc| (SPADCALL |cfac| (QREFELT $ 241)))
                         (EXIT
                          (LETT |rf1k| (SPADCALL |rfc| (QREFELT $ 314)))))))
                  (LETT |l1|
                        (PROG1 (LETT #4# (- |d| 1))
                          (|check_subtype2| (>= #4# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #4#)))
                  (LETT |nf2| (QVELT |scand| 7))
                  (LETT |gt|
                        (SPADCALL
                         (SPADCALL (SPADCALL |nf2| |der|)
                                   (SPADCALL |u0| (QREFELT $ 45))
                                   (QREFELT $ 344))
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL (|spadConstant| $ 32) 1 (QREFELT $ 44))
                           (QREFELT $ 47))
                          |u_exp| (QREFELT $ 315))
                         (QREFELT $ 316)))
                  (SEQ (LETT |i| 1) (LETT #3# |l1|) G190
                       (COND ((|greater_SI| |i| #3#) (GO G191)))
                       (SEQ
                        (LETT |gt1|
                              (COND
                               ((SPADCALL |cfac| (|spadConstant| $ 102)
                                          (QREFELT $ 111))
                                |gt|)
                               ('T
                                (|RDEEFX;get_trace| |gt| |k| |rf1k| |cfac|
                                 $))))
                        (LETT |res| (CONS |gt1| |res|))
                        (EXIT
                         (LETT |gt| (SPADCALL |gt| |nf2| (QREFELT $ 316)))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT |res|)))
                ('T (|error| "unimplemented"))))))) 

(SDEFUN |RDEEFX;get_scoeffs|
        ((|scands|
          (|List|
           (|Record| (|:| |degree| (|Integer|))
                     (|:| |factor| (|SparseUnivariatePolynomial| F))
                     (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                     (|:| |v_part| F)
                     (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                     (|:| |new_f|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |radicand|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |u_part| F) (|:| |exponent| (|Integer|))
                     (|:| |shift_part| F) (|:| |a_val| F))))
         (|denf| (|SparseUnivariatePolynomial| F)) (|k| (|Kernel| F))
         (|der|
          (|Mapping| (|Fraction| (|SparseUnivariatePolynomial| F))
                     (|Fraction| (|SparseUnivariatePolynomial| F))))
         ($ (|List| (|Fraction| (|SparseUnivariatePolynomial| F)))))
        (SPROG
         ((|res| (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
          (#1=#:G1991 NIL) (|scand| NIL))
         (SEQ (LETT |res| NIL)
              (SEQ (LETT |scand| NIL) (LETT #1# |scands|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |scand| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |res|
                           (|RDEEFX;get_scoeff| |scand| |denf| |k| |der| |res|
                            $))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (NREVERSE |res|))))) 

(SDEFUN |RDEEFX;mk_erf1| ((|uc| (F)) (|ff| (F)) ($ (F)))
        (SPROG ((|uc1| (F)))
               (SEQ (LETT |uc1| (SPADCALL |uc| (QREFELT $ 345)))
                    (EXIT
                     (SPADCALL
                      (SPADCALL
                       (SPADCALL (SPADCALL (QREFELT $ 346)) (QREFELT $ 345))
                       (SPADCALL (SPADCALL |uc1| |ff| (QREFELT $ 65))
                                 (QREFELT $ 347))
                       (QREFELT $ 65))
                      |uc1| (QREFELT $ 67)))))) 

(SDEFUN |RDEEFX;is_imaginary?| ((|c| (F)) ($ (|Boolean|)))
        (SPROG
         ((|dl| (|List| (|Complex| (|Integer|))))
          (|nl| (|List| (|Complex| (|Integer|))))
          (|dc| (|SparseMultivariatePolynomial| R (|Kernel| F)))
          (|nc| (|SparseMultivariatePolynomial| R (|Kernel| F))))
         (SEQ (LETT |nc| (SPADCALL |c| (QREFELT $ 178)))
              (LETT |dc| (SPADCALL |c| (QREFELT $ 274)))
              (LETT |nl| (SPADCALL |nc| (QREFELT $ 349)))
              (LETT |dl| (SPADCALL |dc| (QREFELT $ 349)))
              (EXIT
               (COND
                ((SPADCALL (CONS #'|RDEEFX;is_imaginary?!0| $) |dl|
                           (QREFELT $ 356))
                 (SPADCALL (CONS #'|RDEEFX;is_imaginary?!1| $) |nl|
                           (QREFELT $ 356)))
                ('T NIL)))))) 

(SDEFUN |RDEEFX;is_imaginary?!1| ((|c1| NIL) ($ NIL))
        (SPADCALL (SPADCALL |c1| (QREFELT $ 357)) (|spadConstant| $ 352)
                  (QREFELT $ 353))) 

(SDEFUN |RDEEFX;is_imaginary?!0| ((|c1| NIL) ($ NIL))
        (SPADCALL (SPADCALL |c1| (QREFELT $ 351)) (|spadConstant| $ 352)
                  (QREFELT $ 353))) 

(SDEFUN |RDEEFX;mk_erf;3F;54| ((|uc| (F)) (|ff| (F)) ($ (F)))
        (SPROG ((|uc2| (F)) (|uc1| (F)) (|s| (F)) (|im| (F)))
               (SEQ
                (COND
                 ((NULL (|RDEEFX;is_imaginary?| |uc| $))
                  (|RDEEFX;mk_erf1| |uc| |ff| $))
                 ('T
                  (SEQ
                   (LETT |im|
                         (SPADCALL (SPADCALL 0 1 (QREFELT $ 358))
                                   (QREFELT $ 359)))
                   (LETT |uc1|
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL (SPADCALL 2 (QREFELT $ 74)) |im|
                                      (QREFELT $ 65))
                            |uc| (QREFELT $ 65))
                           (SPADCALL (QREFELT $ 346)) (QREFELT $ 67))
                          (QREFELT $ 48)))
                   (LETT |s| (|spadConstant| $ 32))
                   (COND
                    ((SPADCALL |uc1| (SPADCALL |uc1| (QREFELT $ 48))
                               (QREFELT $ 360))
                     (SEQ
                      (LETT |s|
                            (SPADCALL (|spadConstant| $ 32) (QREFELT $ 48)))
                      (EXIT (LETT |uc1| (SPADCALL |uc1| (QREFELT $ 48)))))))
                   (LETT |uc2| (SPADCALL |uc1| (QREFELT $ 345)))
                   (EXIT
                    (SPADCALL
                     (SPADCALL (SPADCALL 2 (QREFELT $ 74))
                               (SPADCALL
                                (SPADCALL (SPADCALL |uc2| |ff| (QREFELT $ 65))
                                          (QREFELT $ 361))
                                (SPADCALL (SPADCALL |im| |s| (QREFELT $ 65))
                                          (SPADCALL
                                           (SPADCALL |uc2| |ff| (QREFELT $ 65))
                                           (QREFELT $ 362))
                                          (QREFELT $ 65))
                                (QREFELT $ 77))
                               (QREFELT $ 65))
                     |uc2| (QREFELT $ 67))))))))) 

(SDEFUN |RDEEFX;mk_erf;3F;55| ((|uc| (F)) (|ff| (F)) ($ (F)))
        (|RDEEFX;mk_erf1| |uc| |ff| $)) 

(SDEFUN |RDEEFX;get_prims|
        ((|scand|
          (|Record| (|:| |degree| (|Integer|))
                    (|:| |factor| (|SparseUnivariatePolynomial| F))
                    (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                    (|:| |v_part| F)
                    (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                    (|:| |new_f| (|Fraction| (|SparseUnivariatePolynomial| F)))
                    (|:| |radicand|
                         (|Fraction| (|SparseUnivariatePolynomial| F)))
                    (|:| |u_part| F) (|:| |exponent| (|Integer|))
                    (|:| |shift_part| F) (|:| |a_val| F)))
         (|denf| (|SparseUnivariatePolynomial| F))
         (|denf1| (|SparseUnivariatePolynomial| F)) (|gexp| (|Integer|))
         (|k| (|Kernel| F)) ($ (|List| F)))
        (SPROG
         ((|res| (|List| F)) (|f1| (F)) (#1=#:G2066 NIL) (|zz| NIL) (|f11| (F))
          (|ff| (F)) (|c1s| (F)) (|j1| (F)) (#2=#:G2065 NIL) (|j| NIL)
          (|nf2| (|Fraction| (|SparseUnivariatePolynomial| F))) (|lf| (F))
          (|l1| (|NonNegativeInteger|)) (#3=#:G2052 NIL) (|zzl| (|List| F))
          (|rf1k| (|Kernel| F)) (|rfc| (F)) (|a| (F)) (|d| (|Integer|))
          (|f| (F)) (|nf| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (|uc| (F)) (|vshift| (F)) (|cfac| (|SparseUnivariatePolynomial| F)))
         (SEQ (LETT |cfac| (QVELT |scand| 5))
              (LETT |vshift| (QVELT |scand| 10)) (LETT |uc| (QVELT |scand| 2))
              (LETT |nf| (QVELT |scand| 6))
              (LETT |f| (SPADCALL |nf| |k| (QREFELT $ 60)))
              (LETT |d| (QVELT |scand| 0))
              (EXIT
               (COND
                ((EQL |d| 0)
                 (SEQ (LETT |a| (QVELT |scand| 11))
                      (EXIT
                       (LIST
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL (SPADCALL |vshift| (QREFELT $ 48))
                                    (SPADCALL
                                     (SPADCALL |a| (|spadConstant| $ 32)
                                               (QREFELT $ 77))
                                     (SPADCALL (QVELT |scand| 2)
                                               (QREFELT $ 364))
                                     (QREFELT $ 65))
                                    (QREFELT $ 77))
                          (QREFELT $ 324))
                         (SPADCALL |a| |f| (QREFELT $ 365)) (QREFELT $ 65))))))
                ((EQL |d| 1)
                 (LIST
                  (SPADCALL
                   (SPADCALL (SPADCALL |vshift| (QREFELT $ 48))
                             (QREFELT $ 324))
                   (SPADCALL |f| (QREFELT $ 325)) (QREFELT $ 65))))
                ((> |d| 1)
                 (SEQ (LETT |rfc| (|spadConstant| $ 43))
                      (COND
                       ((SPADCALL |cfac| (|spadConstant| $ 102)
                                  (QREFELT $ 109))
                        (SEQ (LETT |rfc| (SPADCALL |cfac| (QREFELT $ 241)))
                             (EXIT
                              (LETT |rf1k|
                                    (SPADCALL |rfc| (QREFELT $ 314)))))))
                      (LETT |zzl|
                            (COND
                             ((SPADCALL |cfac| (|spadConstant| $ 102)
                                        (QREFELT $ 111))
                              (LIST (|spadConstant| $ 43)))
                             (#4='T (SPADCALL |cfac| (QREFELT $ 326)))))
                      (LETT |l1|
                            (PROG1 (LETT #3# (- |d| 1))
                              (|check_subtype2| (>= #3# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #3#)))
                      (LETT |lf| (SPADCALL |d| (QREFELT $ 74)))
                      (LETT |res| NIL) (LETT |nf2| (QVELT |scand| 7))
                      (SEQ (LETT |j| 1) (LETT #2# |l1|) G190
                           (COND ((|greater_SI| |j| #2#) (GO G191)))
                           (SEQ
                            (LETT |j1|
                                  (SPADCALL (SPADCALL |j| (QREFELT $ 74)) |lf|
                                            (QREFELT $ 67)))
                            (LETT |c1s|
                                  (SPADCALL
                                   (SPADCALL (SPADCALL |vshift| (QREFELT $ 48))
                                             (QREFELT $ 324))
                                   |lf| (QREFELT $ 67)))
                            (LETT |f1|
                                  (COND
                                   ((EQL (* 2 |j|) |d|)
                                    (SEQ
                                     (LETT |ff|
                                           (SPADCALL |nf2| |k| (QREFELT $ 60)))
                                     (EXIT
                                      (SPADCALL |c1s|
                                                (SPADCALL
                                                 (SPADCALL |uc| (QREFELT $ 48))
                                                 (SPADCALL |ff| |j|
                                                           (QREFELT $ 343))
                                                 (QREFELT $ 363))
                                                (QREFELT $ 65)))))
                                   ('T
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL |c1s|
                                                (SPADCALL
                                                 (SPADCALL |uc| (QREFELT $ 48))
                                                 (SPADCALL |j1| (QREFELT $ 48))
                                                 (QREFELT $ 366))
                                                (QREFELT $ 65))
                                      (SPADCALL |j1|
                                                (SPADCALL |f| (QREFELT $ 48))
                                                (QREFELT $ 365))
                                      (QREFELT $ 65))
                                     (QREFELT $ 48)))))
                            (COND
                             ((SPADCALL |cfac| (|spadConstant| $ 102)
                                        (QREFELT $ 109))
                              (SEQ (LETT |f11| |f1|)
                                   (LETT |f1| (|spadConstant| $ 43))
                                   (EXIT
                                    (SEQ (LETT |zz| NIL) (LETT #1# |zzl|) G190
                                         (COND
                                          ((OR (ATOM #1#)
                                               (PROGN
                                                (LETT |zz| (CAR #1#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT |f1|
                                                 (SPADCALL |f1|
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL |zz|
                                                                       (QREFELT
                                                                        $ 48))
                                                             (QREFELT $ 324))
                                                            (SPADCALL |f11|
                                                                      |rf1k|
                                                                      |zz|
                                                                      (QREFELT
                                                                       $ 68))
                                                            (QREFELT $ 65))
                                                           (QREFELT $ 73)))))
                                         (LETT #1# (CDR #1#)) (GO G190) G191
                                         (EXIT NIL))))))
                            (EXIT (LETT |res| (CONS |f1| |res|))))
                           (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                      (EXIT (NREVERSE |res|))))
                (#4# (|error| "unimplemented"))))))) 

(SDEFUN |RDEEFX;ei_int_diff|
        ((|f| (F)) (|g| (F))
         (|gu| (|Fraction| (|SparseUnivariatePolynomial| F))) (|x| (|Symbol|))
         (|k| (|Kernel| F)) (|lk| (|List| (|Kernel| F)))
         ($
          (|Record| (|:| |ans| F) (|:| |right| F) (|:| |primpart| F)
                    (|:| |sol?| (|Boolean|)))))
        (SPROG
         ((|nres2|
           #1=(|Record| (|:| |ans| F) (|:| |right| F) (|:| |primpart| F)
                        (|:| |sol?| (|Boolean|))))
          (|g3u| #2=(|Fraction| (|SparseUnivariatePolynomial| F))) (|g3| (F))
          (|r1| (F)) (|dp1| (F)) (|p1| (F)) (|a1| (F)) (|k1f| (F))
          (|kdv| (|Kernel| F)) (|nres| #1#) (|g2| (F)) (|f2| (F)) (|dvf| (F))
          (|dv| (|Symbol|)) (|k1| (F)) (|args| (|List| F)) (|g1| (F))
          (|ngu| (|SparseUnivariatePolynomial| F)) (|fu| #2#))
         (SEQ (LETT |fu| (SPADCALL |f| |k| (QREFELT $ 35)))
              (LETT |ngu| (SPADCALL |gu| (QREFELT $ 38)))
              (COND
               ((OR
                 (SPADCALL (SPADCALL |gu| (QREFELT $ 39))
                           (|spadConstant| $ 108) (QREFELT $ 109))
                 (OR
                  (SPADCALL (SPADCALL |ngu| (QREFELT $ 40)) 1 (QREFELT $ 89))
                  (SPADCALL |fu|
                            (SPADCALL (SPADCALL |f| (QREFELT $ 45))
                                      (QREFELT $ 47))
                            (QREFELT $ 367))))
                (EXIT
                 (VECTOR (|spadConstant| $ 43) (|spadConstant| $ 43)
                         (|spadConstant| $ 43) NIL))))
              (LETT |g1| (SPADCALL |ngu| (QREFELT $ 103)))
              (LETT |args| (SPADCALL |k| (QREFELT $ 27)))
              (EXIT
               (COND
                ((SPADCALL (LENGTH |args|) 3 (QREFELT $ 89))
                 (|error| "internal error, k is not a diff"))
                (#3='T
                 (SEQ
                  (LETT |k1|
                        (SPADCALL (SPADCALL |args| 1 (QREFELT $ 29))
                                  (SPADCALL (SPADCALL |args| 2 (QREFELT $ 29))
                                            (QREFELT $ 314))
                                  (SPADCALL |args| 3 (QREFELT $ 29))
                                  (QREFELT $ 68)))
                  (LETT |dv| (SPADCALL (QREFELT $ 57)))
                  (LETT |dvf| (SPADCALL |dv| (QREFELT $ 368)))
                  (LETT |f2| (SPADCALL |f| |k1| |dvf| (QREFELT $ 369)))
                  (LETT |g2| (SPADCALL |g1| |k1| |dvf| (QREFELT $ 369)))
                  (LETT |nres| (SPADCALL 1 |f2| |g2| |dv| (QREFELT $ 66)))
                  (COND
                   ((NULL (QVELT |nres| 3))
                    (EXIT
                     (VECTOR (|spadConstant| $ 43) (|spadConstant| $ 43)
                             (|spadConstant| $ 43) NIL))))
                  (LETT |kdv| (SPADCALL |dv| (QREFELT $ 58))) (LETT |k1f| |k1|)
                  (LETT |a1|
                        (SPADCALL (QVELT |nres| 0) |kdv| |k1f| (QREFELT $ 68)))
                  (LETT |p1|
                        (SPADCALL (QVELT |nres| 2) |kdv| |k1f| (QREFELT $ 68)))
                  (LETT |dp1|
                        (COND
                         ((SPADCALL |p1| (|spadConstant| $ 43) (QREFELT $ 78))
                          (|spadConstant| $ 43))
                         (#3#
                          (SPADCALL (SPADCALL |p1| |x| (QREFELT $ 323))
                                    (SPADCALL |f| (QREFELT $ 324))
                                    (QREFELT $ 67)))))
                  (LETT |r1|
                        (SPADCALL
                         (SPADCALL (SPADCALL |a1| |x| (QREFELT $ 323))
                                   (SPADCALL |a1|
                                             (SPADCALL |f| |x| (QREFELT $ 323))
                                             (QREFELT $ 65))
                                   (QREFELT $ 73))
                         |dp1| (QREFELT $ 73)))
                  (LETT |g3| (SPADCALL |g| |r1| (QREFELT $ 77)))
                  (EXIT
                   (COND
                    ((SPADCALL |g3| (|spadConstant| $ 43) (QREFELT $ 78))
                     (VECTOR |a1| |g| |p1| 'T))
                    (#3#
                     (SEQ (LETT |g3u| (SPADCALL |g3| |k| (QREFELT $ 35)))
                          (EXIT
                           (COND
                            ((SPADCALL |g3u|
                                       (SPADCALL (SPADCALL |g3| (QREFELT $ 45))
                                                 (QREFELT $ 47))
                                       (QREFELT $ 367))
                             (SEQ
                              (SPADCALL
                               (SPADCALL
                                "Failed to differentiate nres in ei_int_diff"
                                (QREFELT $ 372))
                               (QREFELT $ 374))
                              (EXIT
                               (VECTOR (|spadConstant| $ 43)
                                       (|spadConstant| $ 43)
                                       (|spadConstant| $ 43) NIL))))
                            (#3#
                             (SEQ
                              (LETT |nres2|
                                    (SPADCALL 1 |f| |g3| |x| (QREFELT $ 66)))
                              (EXIT
                               (VECTOR
                                (SPADCALL (QVELT |nres2| 0) |a1|
                                          (QREFELT $ 73))
                                (SPADCALL (QVELT |nres2| 1) |r1|
                                          (QREFELT $ 73))
                                (SPADCALL (QVELT |nres2| 2) |p1|
                                          (QREFELT $ 73))
                                (QVELT |nres2| 3)))))))))))))))))) 

(SDEFUN |RDEEFX;ei_int;I2FSR;58|
        ((|n| (|Integer|)) (|f| (F)) (|g| (F)) (|x| (|Symbol|))
         ($
          (|Record| (|:| |ans| F) (|:| |right| F) (|:| |primpart| F)
                    (|:| |sol?| (|Boolean|)))))
        (SPROG
         ((|res3|
           (|Record| (|:| |ans| F) (|:| |right| F) (|:| |primpart| F)
                     (|:| |sol?| (|Boolean|))))
          (|res6|
           #1=(|Record| (|:| |ans| F) (|:| |right| F) (|:| |primpart| F)
                        (|:| |sol?| (|Boolean|))))
          (#2=#:G2162 NIL) (|r1| (F)) (|ansp| (F)) (|a1| (F))
          (|res4|
           (|Record| (|:| |ans| F) (|:| |right| F) (|:| |primpart| F)
                     (|:| |sol?| (|Boolean|))))
          (|f1| (F)) (|u| (F)) (|rc| (|Integer|))
          (|rcu2| (|Union| (|Integer|) #3="failed"))
          (|rcq| (|Fraction| (|Integer|)))
          (|rcu1| (|Union| (|Fraction| (|Integer|)) "failed")) (|lc| (F))
          (|rr1f| (F)) (#4=#:G2160 NIL) (|aa| (F)) (|res7| #1#)
          (#5=#:G2161 NIL) (|ff| (F))
          (|spec1p| (|SparseUnivariatePolynomial| F)) (|gj| (F)) (|j| NIL)
          (|dkf| (F)) (|kf| (F)) (|d| #6=(|NonNegativeInteger|))
          (|spec1u| #7=(|Union| (|SparseUnivariatePolynomial| F) #3#))
          (|log_recursion| (|Boolean|))
          (|scoeffs| (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|derivation3|
           (|Mapping| (|Fraction| (|SparseUnivariatePolynomial| F))
                      (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|scands|
           (|List|
            (|Record| (|:| |degree| (|Integer|))
                      (|:| |factor| (|SparseUnivariatePolynomial| F))
                      (|:| |coeff| F) (|:| |ratpart| (|Integer|))
                      (|:| |v_part| F)
                      (|:| |alg_part| (|SparseUnivariatePolynomial| F))
                      (|:| |new_f|
                           (|Fraction| (|SparseUnivariatePolynomial| F)))
                      (|:| |radicand|
                           (|Fraction| (|SparseUnivariatePolynomial| F)))
                      (|:| |u_part| F) (|:| |exponent| (|Integer|))
                      (|:| |shift_part| F) (|:| |a_val| F))))
          (|rr1| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (|her2|
           (|Record|
            (|:| |answer| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |specpart| (|Fraction| (|SparseUnivariatePolynomial| F)))))
          (|ndenf| #8=(|SparseUnivariatePolynomial| F))
          (|denf_split|
           (|Record| (|:| |normal| #8#)
                     (|:| |special| (|SparseUnivariatePolynomial| F))))
          (|derivation2|
           (|Mapping| (|SparseUnivariatePolynomial| F)
                      (|SparseUnivariatePolynomial| F)))
          (|gexp| (|Integer|)) (|gden1| (|SparseUnivariatePolynomial| F))
          (|#G482|
           (|Record| (|:| |radicand| (|SparseUnivariatePolynomial| F))
                     (|:| |exponent| (|Integer|))))
          (|res5|
           (|Record| (|:| |ans| F) (|:| |right| F) (|:| |primpart| F)
                     (|:| |sol?| (|Boolean|))))
          (|lp1u| #7#) (|lp| #9=(|Fraction| (|SparseUnivariatePolynomial| F)))
          (|ar1|
           (|Record| (|:| |primpart| F)
                     (|:| |logpart|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))
                     (|:| |polypart| (|SparseUnivariatePolynomial| F))
                     (|:| |specpart|
                          (|Fraction| (|SparseUnivariatePolynomial| F)))))
          (|ulst| (|List| F)) (#10=#:G2170 NIL) (|kk| NIL) (#11=#:G2169 NIL)
          (|vlst| (|List| F)) (#12=#:G2168 NIL) (#13=#:G2167 NIL)
          (|lk1| (|List| (|Kernel| F))) (#14=#:G2166 NIL) (#15=#:G2165 NIL)
          (|ng| (|SparseUnivariatePolynomial| F)) (|degs| #6#)
          (|ds| #16=(|SparseUnivariatePolynomial| F))
          (|nf| #17=(|SparseUnivariatePolynomial| F)) (|denf| #16#)
          (|fu| #18=(|Fraction| (|SparseUnivariatePolynomial| F)))
          (|lnum| #17#) (|lden| #16#)
          (|her|
           (|Record|
            (|:| |answer| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |logpart| #9#)
            (|:| |specpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |polypart| (|SparseUnivariatePolynomial| F))))
          (|derivation|
           (|Mapping| (|SparseUnivariatePolynomial| F)
                      (|SparseUnivariatePolynomial| F)))
          (|nfp| #17#) (|denfp| #16#) (|dk| #17#) (|dku| #18#) (|gu| #18#)
          (|fpu| #18#) (|lk| (|List| (|Kernel| F))) (#19=#:G2164 NIL)
          (#20=#:G2163 NIL) (|k| (|Kernel| F)) (|fp| (F)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |lk|
                  (SPADCALL
                   (SPADCALL
                    (SPADCALL (SPADCALL |f| (QREFELT $ 341))
                              (SPADCALL |g| (QREFELT $ 341)) (QREFELT $ 16))
                    |x| (QREFELT $ 15))
                   (LIST (SPADCALL |x| (QREFELT $ 58))) (QREFELT $ 16)))
            (LETT |f| (SPADCALL |n| |f| (QREFELT $ 237)))
            (LETT |fp| (SPADCALL |f| |x| (QREFELT $ 62)))
            (EXIT
             (COND
              ((SPADCALL |fp| (|spadConstant| $ 43) (QREFELT $ 78))
               (SPADCALL |f| |g| |x| |lk| (QREFELT $ 56)))
              (#21='T
               (SEQ (LETT |k| (|RDEEFX;top_kernel| |f| |g| |x| $))
                    (LETT |lk|
                          (PROGN
                           (LETT #20# NIL)
                           (SEQ (LETT |kk| NIL) (LETT #19# |lk|) G190
                                (COND
                                 ((OR (ATOM #19#)
                                      (PROGN (LETT |kk| (CAR #19#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (COND
                                   ((SPADCALL |kk| |k| (QREFELT $ 342))
                                    (LETT #20# (CONS |kk| #20#))))))
                                (LETT #19# (CDR #19#)) (GO G190) G191
                                (EXIT (NREVERSE #20#)))))
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |k| (QREFELT $ 24)) (QREFELT $ 8)
                                 (QREFELT $ 25))
                       (|RDEEFX;ei_int_alg| |f| |g| |x| |k| |lk| $))
                      (#21#
                       (SEQ (LETT |fpu| (SPADCALL |fp| |k| (QREFELT $ 35)))
                            (LETT |gu| (SPADCALL |g| |k| (QREFELT $ 35)))
                            (EXIT
                             (COND
                              ((SPADCALL |k| '|%diff| (QREFELT $ 22))
                               (|RDEEFX;ei_int_diff| |f| |g| |gu| |x| |k| |lk|
                                $))
                              (#21#
                               (SEQ
                                (LETT |dku|
                                      (SPADCALL
                                       (SPADCALL (SPADCALL |k| (QREFELT $ 61))
                                                 |x| (QREFELT $ 323))
                                       |k| (QREFELT $ 35)))
                                (EXIT
                                 (COND
                                  ((SPADCALL (SPADCALL |dku| (QREFELT $ 39))
                                             (|spadConstant| $ 108)
                                             (QREFELT $ 109))
                                   (VECTOR (|spadConstant| $ 43)
                                           (|spadConstant| $ 43)
                                           (|spadConstant| $ 43) NIL))
                                  (#21#
                                   (SEQ
                                    (LETT |dk| (SPADCALL |dku| (QREFELT $ 38)))
                                    (LETT |denfp|
                                          (SPADCALL |fpu| (QREFELT $ 39)))
                                    (LETT |nfp|
                                          (SPADCALL |fpu| (QREFELT $ 38)))
                                    (LETT |derivation|
                                          (CONS #'|RDEEFX;ei_int;I2FSR;58!1|
                                                (VECTOR |dk| |x| $ |denfp|)))
                                    (LETT |her|
                                          (SPADCALL
                                           (SPADCALL |denfp| |gu|
                                                     (QREFELT $ 271))
                                           |derivation| |nfp| (QREFELT $ 378)))
                                    (LETT |lp| (QVELT |her| 1))
                                    (LETT |a1|
                                          (SPADCALL (QVELT |her| 0) |k|
                                                    (QREFELT $ 60)))
                                    (LETT |rr1|
                                          (SPADCALL
                                           (SPADCALL |lp|
                                                     (SPADCALL (QVELT |her| 3)
                                                               (QREFELT $ 47))
                                                     (QREFELT $ 328))
                                           (QVELT |her| 2) (QREFELT $ 328)))
                                    (LETT |rr1|
                                          (SPADCALL |rr1|
                                                    (SPADCALL |denfp|
                                                              (QREFELT $ 47))
                                                    (QREFELT $ 50)))
                                    (LETT |r1|
                                          (SPADCALL |g|
                                                    (SPADCALL |rr1| |k|
                                                              (QREFELT $ 60))
                                                    (QREFELT $ 77)))
                                    (EXIT
                                     (COND
                                      ((SPADCALL |rr1| (|spadConstant| $ 197)
                                                 (QREFELT $ 339))
                                       (VECTOR |a1| |g| (|spadConstant| $ 43)
                                               'T))
                                      (#21#
                                       (SEQ
                                        (LETT |lden|
                                              (SPADCALL |lp| (QREFELT $ 39)))
                                        (LETT |lnum|
                                              (SPADCALL |lp| (QREFELT $ 38)))
                                        (LETT |fu|
                                              (SPADCALL |f| |k|
                                                        (QREFELT $ 35)))
                                        (LETT |denf|
                                              (SPADCALL |fu| (QREFELT $ 39)))
                                        (LETT |nf|
                                              (SPADCALL |fu| (QREFELT $ 38)))
                                        (COND
                                         ((SPADCALL |denf|
                                                    (|spadConstant| $ 108)
                                                    (QREFELT $ 111))
                                          (COND
                                           ((EQL (SPADCALL |nf| (QREFELT $ 40))
                                                 0)
                                            (COND
                                             ((SPADCALL |k| '|exp|
                                                        (QREFELT $ 22))
                                              (EXIT
                                               (COND
                                                ((SPADCALL |lp|
                                                           (|spadConstant| $
                                                                           197)
                                                           (QREFELT $ 367))
                                                 (VECTOR |a1| |r1|
                                                         (|spadConstant| $ 43)
                                                         NIL))
                                                (#21#
                                                 (SEQ
                                                  (LETT |ds|
                                                        (SPADCALL
                                                         (QVELT |her| 2)
                                                         (QREFELT $ 39)))
                                                  (COND
                                                   ((OR
                                                     (SPADCALL
                                                      (SPADCALL |ds|
                                                                (QREFELT $
                                                                         110))
                                                      (|spadConstant| $ 102)
                                                      (QREFELT $ 109))
                                                     (SPADCALL
                                                      (SPADCALL |ds|
                                                                (QREFELT $
                                                                         103))
                                                      (|spadConstant| $ 32)
                                                      (QREFELT $ 131)))
                                                    (EXIT
                                                     (|error|
                                                      "unexpected special part"))))
                                                  (LETT |degs|
                                                        (SPADCALL |ds|
                                                                  (QREFELT $
                                                                           40)))
                                                  (LETT |ng|
                                                        (SPADCALL
                                                         (SPADCALL
                                                          (SPADCALL
                                                           (|spadConstant| $
                                                                           32)
                                                           |degs|
                                                           (QREFELT $ 44))
                                                          (QVELT |her| 3)
                                                          (QREFELT $ 97))
                                                         (SPADCALL
                                                          (QVELT |her| 2)
                                                          (QREFELT $ 38))
                                                         (QREFELT $ 49)))
                                                  (LETT |res5|
                                                        (|RDEEFX;ei_int_exp|
                                                         |f| |ng| |degs| |x|
                                                         |k| $))
                                                  (LETT |a1|
                                                        (SPADCALL |a1|
                                                                  (QVELT |res5|
                                                                         0)
                                                                  (QREFELT $
                                                                           73)))
                                                  (LETT |r1|
                                                        (SPADCALL |r1|
                                                                  (QVELT |res5|
                                                                         1)
                                                                  (QREFELT $
                                                                           73)))
                                                  (EXIT
                                                   (VECTOR |a1| |r1|
                                                           (QVELT |res5| 2)
                                                           (QVELT |res5|
                                                                  3)))))))))))))
                                        (LETT |lk1|
                                              (PROGN
                                               (LETT #15# NIL)
                                               (SEQ (LETT |kk| NIL)
                                                    (LETT #14# (CONS |k| |lk|))
                                                    G190
                                                    (COND
                                                     ((OR (ATOM #14#)
                                                          (PROGN
                                                           (LETT |kk|
                                                                 (CAR #14#))
                                                           NIL))
                                                      (GO G191)))
                                                    (SEQ
                                                     (EXIT
                                                      (COND
                                                       ((COND
                                                         ((SPADCALL |kk| '|log|
                                                                    (QREFELT $
                                                                             22))
                                                          'T)
                                                         (#21#
                                                          (SPADCALL |kk| '|exp|
                                                                    (QREFELT $
                                                                             22))))
                                                        (LETT #15#
                                                              (CONS |kk|
                                                                    #15#))))))
                                                    (LETT #14# (CDR #14#))
                                                    (GO G190) G191
                                                    (EXIT (NREVERSE #15#)))))
                                        (LETT |vlst|
                                              (PROGN
                                               (LETT #13# NIL)
                                               (SEQ (LETT |kk| NIL)
                                                    (LETT #12# |lk1|) G190
                                                    (COND
                                                     ((OR (ATOM #12#)
                                                          (PROGN
                                                           (LETT |kk|
                                                                 (CAR #12#))
                                                           NIL))
                                                      (GO G191)))
                                                    (SEQ
                                                     (EXIT
                                                      (LETT #13#
                                                            (CONS
                                                             (COND
                                                              ((SPADCALL |kk|
                                                                         '|log|
                                                                         (QREFELT
                                                                          $
                                                                          22))
                                                               (SPADCALL |kk|
                                                                         (QREFELT
                                                                          $
                                                                          61)))
                                                              ('T
                                                               (SPADCALL
                                                                (SPADCALL |kk|
                                                                          (QREFELT
                                                                           $
                                                                           27))
                                                                1
                                                                (QREFELT $
                                                                         29))))
                                                             #13#))))
                                                    (LETT #12# (CDR #12#))
                                                    (GO G190) G191
                                                    (EXIT (NREVERSE #13#)))))
                                        (LETT |ulst|
                                              (PROGN
                                               (LETT #11# NIL)
                                               (SEQ (LETT |kk| NIL)
                                                    (LETT #10# |lk1|) G190
                                                    (COND
                                                     ((OR (ATOM #10#)
                                                          (PROGN
                                                           (LETT |kk|
                                                                 (CAR #10#))
                                                           NIL))
                                                      (GO G191)))
                                                    (SEQ
                                                     (EXIT
                                                      (LETT #11#
                                                            (CONS
                                                             (COND
                                                              ((SPADCALL |kk|
                                                                         '|log|
                                                                         (QREFELT
                                                                          $
                                                                          22))
                                                               (SPADCALL
                                                                (SPADCALL |kk|
                                                                          (QREFELT
                                                                           $
                                                                           27))
                                                                1
                                                                (QREFELT $
                                                                         29)))
                                                              ('T
                                                               (SPADCALL |kk|
                                                                         (QREFELT
                                                                          $
                                                                          61))))
                                                             #11#))))
                                                    (LETT #10# (CDR #10#))
                                                    (GO G190) G191
                                                    (EXIT (NREVERSE #11#)))))
                                        (LETT |ar1|
                                              (|RDEEFX;handle_logpart| |lnum|
                                               |lden| |nf| |denf| |nfp| |denfp|
                                               |k| |vlst| |ulst| |x| $))
                                        (LETT |ansp| (QVELT |ar1| 0))
                                        (LETT |lp|
                                              (SPADCALL |lp| (QVELT |ar1| 1)
                                                        (QREFELT $ 270)))
                                        (QSETVELT |her| 2
                                                  (SPADCALL (QVELT |her| 2)
                                                            (QVELT |ar1| 3)
                                                            (QREFELT $ 270)))
                                        (QSETVELT |her| 3
                                                  (SPADCALL (QVELT |her| 3)
                                                            (QVELT |ar1| 2)
                                                            (QREFELT $ 46)))
                                        (LETT |lp1u|
                                              (SPADCALL |lp| (QREFELT $ 265)))
                                        (EXIT
                                         (COND
                                          ((QEQCAR |lp1u| 1)
                                           (VECTOR |a1| |r1|
                                                   (|spadConstant| $ 43) NIL))
                                          (#21#
                                           (SEQ
                                            (QSETVELT |her| 3
                                                      (SPADCALL (QVELT |her| 3)
                                                                (QCDR |lp1u|)
                                                                (QREFELT $
                                                                         49)))
                                            (COND
                                             ((SPADCALL (QVELT |her| 3)
                                                        (|spadConstant| $ 102)
                                                        (QREFELT $ 111))
                                              (COND
                                               ((SPADCALL (QVELT |her| 2)
                                                          (|spadConstant| $
                                                                          197)
                                                          (QREFELT $ 339))
                                                (EXIT
                                                 (VECTOR |a1| |g| |ansp|
                                                         'T))))))
                                            (COND
                                             ((SPADCALL |denf|
                                                        (|spadConstant| $ 108)
                                                        (QREFELT $ 111))
                                              (COND
                                               ((EQL
                                                 (SPADCALL |nf| (QREFELT $ 40))
                                                 0)
                                                (COND
                                                 ((OR
                                                   (SPADCALL |k| '|log|
                                                             (QREFELT $ 22))
                                                   (SPADCALL
                                                    (SPADCALL |k|
                                                              (QREFELT $ 24))
                                                    (QREFELT $ 9)
                                                    (QREFELT $ 25)))
                                                  (EXIT
                                                   (COND
                                                    ((SPADCALL |lp|
                                                               (|spadConstant|
                                                                $ 197)
                                                               (QREFELT $ 367))
                                                     (VECTOR |a1| |r1|
                                                             (|spadConstant| $
                                                                             43)
                                                             NIL))
                                                    ((SPADCALL (QVELT |her| 2)
                                                               (|spadConstant|
                                                                $ 197)
                                                               (QREFELT $ 367))
                                                     (|error|
                                                      "unexpected special part"))
                                                    (#21#
                                                     (SEQ
                                                      (LETT |res5|
                                                            (|RDEEFX;ei_int_log|
                                                             |f|
                                                             (QVELT |her| 3)
                                                             |x| |k| $))
                                                      (LETT |a1|
                                                            (SPADCALL |a1|
                                                                      (QVELT
                                                                       |res5|
                                                                       0)
                                                                      (QREFELT
                                                                       $ 73)))
                                                      (LETT |r1|
                                                            (SPADCALL |r1|
                                                                      (QVELT
                                                                       |res5|
                                                                       1)
                                                                      (QREFELT
                                                                       $ 73)))
                                                      (EXIT
                                                       (VECTOR |a1| |r1|
                                                               (SPADCALL |ansp|
                                                                         (QVELT
                                                                          |res5|
                                                                          2)
                                                                         (QREFELT
                                                                          $
                                                                          73))
                                                               (QVELT |res5|
                                                                      3)))))))))))))
                                            (LETT |rr1|
                                                  (SPADCALL
                                                   (SPADCALL (QVELT |her| 3)
                                                             (QREFELT $ 47))
                                                   (QVELT |her| 2)
                                                   (QREFELT $ 328)))
                                            (LETT |rr1|
                                                  (SPADCALL |rr1|
                                                            (SPADCALL |denfp|
                                                                      (QREFELT
                                                                       $ 47))
                                                            (QREFELT $ 50)))
                                            (PROGN
                                             (LETT |#G482|
                                                   (|RDEEFX;gamma_denominator|
                                                    |denf| |k| $))
                                             (LETT |gden1| (QCAR |#G482|))
                                             (LETT |gexp| (QCDR |#G482|))
                                             |#G482|)
                                            (LETT |derivation2|
                                                  (CONS
                                                   #'|RDEEFX;ei_int;I2FSR;58!3|
                                                   (VECTOR |dk| |x| $)))
                                            (LETT |denf_split|
                                                  (SPADCALL |denf|
                                                            |derivation2|
                                                            (QREFELT $ 381)))
                                            (LETT |ndenf| (QCAR |denf_split|))
                                            (LETT |her2|
                                                  (|RDEEFX;special_Hermite|
                                                   |rr1| |nfp| |ndenf| |denfp|
                                                   |derivation2| $))
                                            (LETT |a1|
                                                  (SPADCALL |a1|
                                                            (SPADCALL
                                                             (QCAR |her2|) |k|
                                                             (QREFELT $ 60))
                                                            (QREFELT $ 73)))
                                            (LETT |rr1| (QCDR |her2|))
                                            (EXIT
                                             (COND
                                              ((SPADCALL |rr1|
                                                         (|spadConstant| $ 197)
                                                         (QREFELT $ 339))
                                               (VECTOR |a1| |g| |ansp| 'T))
                                              (#21#
                                               (SEQ
                                                (COND
                                                 ((SPADCALL |denf|
                                                            (|spadConstant| $
                                                                            108)
                                                            (QREFELT $ 111))
                                                  (COND
                                                   ((EQL
                                                     (SPADCALL |nf|
                                                               (QREFELT $ 40))
                                                     2)
                                                    (COND
                                                     ((SPADCALL |k| '|log|
                                                                (QREFELT $ 22))
                                                      (EXIT
                                                       (|RDEEFX;quadratic_log_erf_integrate|
                                                        |nf| |nfp| |rr1| |a1|
                                                        |g| |ansp| |derivation|
                                                        |vlst| |ulst| |k| |lk|
                                                        |x| $))))))))
                                                (LETT |scands|
                                                      (|RDEEFX;special_candidates|
                                                       |nf| |denf| |gden1|
                                                       |gexp| |vlst| |ulst| |k|
                                                       |x| $))
                                                (LETT |derivation3|
                                                      (CONS
                                                       #'|RDEEFX;ei_int;I2FSR;58!4|
                                                       (VECTOR |derivation2|
                                                               $)))
                                                (LETT |scoeffs|
                                                      (|RDEEFX;get_scoeffs|
                                                       |scands| |denf| |k|
                                                       |derivation3| $))
                                                (LETT |rr1f|
                                                      (SPADCALL |rr1| |k|
                                                                (QREFELT $
                                                                         60)))
                                                (LETT |r1|
                                                      (SPADCALL |g| |rr1f|
                                                                (QREFELT $
                                                                         77)))
                                                (LETT |log_recursion| NIL)
                                                (COND
                                                 ((SPADCALL |denf|
                                                            (|spadConstant| $
                                                                            108)
                                                            (QREFELT $ 111))
                                                  (COND
                                                   ((SPADCALL |k| '|log|
                                                              (QREFELT $ 22))
                                                    (COND
                                                     ((EQL
                                                       (SPADCALL |nf|
                                                                 (QREFELT $
                                                                          40))
                                                       1)
                                                      (SEQ
                                                       (LETT |lc|
                                                             (SPADCALL |nf|
                                                                       (QREFELT
                                                                        $
                                                                        103)))
                                                       (LETT |rcu1|
                                                             (SPADCALL |lc|
                                                                       (QREFELT
                                                                        $
                                                                        159)))
                                                       (EXIT
                                                        (LETT |log_recursion|
                                                              (QEQCAR |rcu1|
                                                                      0))))))))))
                                                (EXIT
                                                 (COND
                                                  (|log_recursion|
                                                   (SEQ
                                                    (COND
                                                     (|log_recursion|
                                                      (SEQ
                                                       (LETT |spec1u|
                                                             (SPADCALL |rr1|
                                                                       (QREFELT
                                                                        $
                                                                        265)))
                                                       (EXIT
                                                        (COND
                                                         ((QEQCAR |spec1u| 1)
                                                          (|error|
                                                           "impossible 9"))
                                                         (#21#
                                                          (SEQ
                                                           (LETT |spec1p|
                                                                 (QCDR
                                                                  |spec1u|))
                                                           (LETT |d|
                                                                 (SPADCALL
                                                                  |spec1p|
                                                                  (QREFELT $
                                                                           40)))
                                                           (LETT |aa|
                                                                 (|spadConstant|
                                                                  $ 43))
                                                           (LETT |kf|
                                                                 (SPADCALL |k|
                                                                           (QREFELT
                                                                            $
                                                                            61)))
                                                           (LETT |dkf|
                                                                 (SPADCALL |dk|
                                                                           (QREFELT
                                                                            $
                                                                            202)))
                                                           (SEQ
                                                            (EXIT
                                                             (SEQ
                                                              (LETT |j| |d|)
                                                              G190
                                                              (COND
                                                               ((< |j| 0)
                                                                (GO G191)))
                                                              (SEQ
                                                               (LETT |gj|
                                                                     (|spadConstant|
                                                                      $ 43))
                                                               (COND
                                                                ((EQL |j|
                                                                      (SPADCALL
                                                                       |spec1p|
                                                                       (QREFELT
                                                                        $ 40)))
                                                                 (SEQ
                                                                  (LETT |gj|
                                                                        (SPADCALL
                                                                         |spec1p|
                                                                         (QREFELT
                                                                          $
                                                                          103)))
                                                                  (EXIT
                                                                   (LETT
                                                                    |spec1p|
                                                                    (SPADCALL
                                                                     |spec1p|
                                                                     (QREFELT $
                                                                              110)))))))
                                                               (LETT |ff|
                                                                     (SPADCALL
                                                                      |gj|
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         (+ |j|
                                                                            1)
                                                                         (QREFELT
                                                                          $
                                                                          74))
                                                                        |dkf|
                                                                        (QREFELT
                                                                         $ 65))
                                                                       |aa|
                                                                       (QREFELT
                                                                        $ 65))
                                                                      (QREFELT
                                                                       $ 77)))
                                                               (EXIT
                                                                (COND
                                                                 ((EQL |j| 0)
                                                                  (PROGN
                                                                   (LETT #5#
                                                                         |$NoValue|)
                                                                   (GO
                                                                    #22=#:G2139)))
                                                                 ('T
                                                                  (SEQ
                                                                   (EXIT
                                                                    (SEQ
                                                                     (LETT
                                                                      |res7|
                                                                      (SPADCALL
                                                                       |f| |ff|
                                                                       |x|
                                                                       (CONS
                                                                        |k|
                                                                        |lk|)
                                                                       (QREFELT
                                                                        $ 56)))
                                                                     (LETT |aa|
                                                                           (QVELT
                                                                            |res7|
                                                                            0))
                                                                     (LETT |a1|
                                                                           (SPADCALL
                                                                            |a1|
                                                                            (SPADCALL
                                                                             |aa|
                                                                             (SPADCALL
                                                                              |kf|
                                                                              |j|
                                                                              (QREFELT
                                                                               $
                                                                               343))
                                                                             (QREFELT
                                                                              $
                                                                              65))
                                                                            (QREFELT
                                                                             $
                                                                             73)))
                                                                     (LETT |r1|
                                                                           (SPADCALL
                                                                            |r1|
                                                                            (SPADCALL
                                                                             (QVELT
                                                                              |res7|
                                                                              1)
                                                                             (SPADCALL
                                                                              |kf|
                                                                              |j|
                                                                              (QREFELT
                                                                               $
                                                                               343))
                                                                             (QREFELT
                                                                              $
                                                                              65))
                                                                            (QREFELT
                                                                             $
                                                                             73)))
                                                                     (EXIT
                                                                      (COND
                                                                       ((NULL
                                                                         (QVELT
                                                                          |res7|
                                                                          3))
                                                                        (PROGN
                                                                         (LETT
                                                                          #4#
                                                                          (PROGN
                                                                           (LETT
                                                                            #2#
                                                                            (VECTOR
                                                                             |a1|
                                                                             |r1|
                                                                             |ansp|
                                                                             (QVELT
                                                                              |res7|
                                                                              3)))
                                                                           (GO
                                                                            #23=#:G2159)))
                                                                         (GO
                                                                          #24=#:G2137)))))))
                                                                   #24#
                                                                   (EXIT
                                                                    #4#))))))
                                                              (LETT |j|
                                                                    (+ |j| -1))
                                                              (GO G190) G191
                                                              (EXIT NIL)))
                                                            #22# (EXIT #5#))
                                                           (EXIT
                                                            (COND
                                                             ((SPADCALL |ff|
                                                                        (|spadConstant|
                                                                         $ 43)
                                                                        (QREFELT
                                                                         $ 78))
                                                              (PROGN
                                                               (LETT #2#
                                                                     (VECTOR
                                                                      |a1| |r1|
                                                                      |ansp|
                                                                      'T))
                                                               (GO #23#)))
                                                             (#21#
                                                              (SEQ
                                                               (LETT |rr1f|
                                                                     |ff|)
                                                               (LETT |lc|
                                                                     (SPADCALL
                                                                      |nf|
                                                                      (QREFELT
                                                                       $ 103)))
                                                               (LETT |rcu1|
                                                                     (SPADCALL
                                                                      |lc|
                                                                      (QREFELT
                                                                       $ 159)))
                                                               (EXIT
                                                                (COND
                                                                 ((QEQCAR
                                                                   |rcu1| 1)
                                                                  "skip")
                                                                 (#21#
                                                                  (SEQ
                                                                   (LETT |rcq|
                                                                         (QCDR
                                                                          |rcu1|))
                                                                   (LETT |rcu2|
                                                                         (SPADCALL
                                                                          |rcq|
                                                                          (QREFELT
                                                                           $
                                                                           191)))
                                                                   (EXIT
                                                                    (COND
                                                                     ((QEQCAR
                                                                       |rcu2|
                                                                       1)
                                                                      "skip")
                                                                     (#21#
                                                                      (SEQ
                                                                       (LETT
                                                                        |rc|
                                                                        (QCDR
                                                                         |rcu2|))
                                                                       (LETT
                                                                        |u|
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          (SPADCALL
                                                                           |k|
                                                                           (QREFELT
                                                                            $
                                                                            27))
                                                                          1
                                                                          (QREFELT
                                                                           $
                                                                           29))
                                                                         |rc|
                                                                         (QREFELT
                                                                          $
                                                                          79)))
                                                                       (LETT
                                                                        |f1|
                                                                        (SPADCALL
                                                                         |nf| 0
                                                                         (QREFELT
                                                                          $
                                                                          41)))
                                                                       (LETT
                                                                        |res4|
                                                                        (SPADCALL
                                                                         1 |f1|
                                                                         (SPADCALL
                                                                          |rr1f|
                                                                          |u|
                                                                          (QREFELT
                                                                           $
                                                                           65))
                                                                         |x|
                                                                         (QREFELT
                                                                          $
                                                                          66)))
                                                                       (LETT
                                                                        |a1|
                                                                        (SPADCALL
                                                                         |a1|
                                                                         (SPADCALL
                                                                          (QVELT
                                                                           |res4|
                                                                           0)
                                                                          |u|
                                                                          (QREFELT
                                                                           $
                                                                           67))
                                                                         (QREFELT
                                                                          $
                                                                          73)))
                                                                       (LETT
                                                                        |ansp|
                                                                        (SPADCALL
                                                                         |ansp|
                                                                         (QVELT
                                                                          |res4|
                                                                          2)
                                                                         (QREFELT
                                                                          $
                                                                          73)))
                                                                       (LETT
                                                                        |r1|
                                                                        (SPADCALL
                                                                         |r1|
                                                                         (SPADCALL
                                                                          (QVELT
                                                                           |res4|
                                                                           1)
                                                                          |u|
                                                                          (QREFELT
                                                                           $
                                                                           67))
                                                                         (QREFELT
                                                                          $
                                                                          73)))
                                                                       (EXIT
                                                                        (PROGN
                                                                         (LETT
                                                                          #2#
                                                                          (VECTOR
                                                                           |a1|
                                                                           |r1|
                                                                           |ansp|
                                                                           (QVELT
                                                                            |res4|
                                                                            3)))
                                                                         (GO
                                                                          #23#))))))))))))))))))))))
                                                    (EXIT
                                                     (COND
                                                      ((SPADCALL |r1| |g|
                                                                 (QREFELT $
                                                                          78))
                                                       (VECTOR |a1| |g| |ansp|
                                                               'T))
                                                      (#21#
                                                       (SEQ
                                                        (LETT |res6|
                                                              (SPADCALL |f|
                                                                        |rr1f|
                                                                        |x|
                                                                        (CONS
                                                                         |k|
                                                                         |lk|)
                                                                        (QREFELT
                                                                         $
                                                                         56)))
                                                        (EXIT
                                                         (VECTOR
                                                          (SPADCALL |a1|
                                                                    (QVELT
                                                                     |res6| 0)
                                                                    (QREFELT $
                                                                             73))
                                                          (SPADCALL |r1|
                                                                    (QVELT
                                                                     |res6| 1)
                                                                    (QREFELT $
                                                                             73))
                                                          |ansp|
                                                          (QVELT |res6|
                                                                 3)))))))))
                                                  (#21#
                                                   (SEQ
                                                    (LETT |res3|
                                                          (|RDEEFX;special_integrate2|
                                                           |nfp| |denfp| |denf|
                                                           |ndenf| |f| |k| |lk|
                                                           |x| |rr1| |a1| |r1|
                                                           |g| |scoeffs|
                                                           |scands| |gexp| $))
                                                    (EXIT
                                                     (VECTOR
                                                      (SPADCALL |a1|
                                                                (QVELT |res3|
                                                                       0)
                                                                (QREFELT $ 73))
                                                      (SPADCALL |r1|
                                                                (QVELT |res3|
                                                                       1)
                                                                (QREFELT $ 73))
                                                      (SPADCALL |ansp|
                                                                (QVELT |res3|
                                                                       2)
                                                                (QREFELT $ 73))
                                                      (QVELT |res3|
                                                             3)))))))))))))))))))))))))))))))))))))
          #23# (EXIT #2#)))) 

(SDEFUN |RDEEFX;ei_int;I2FSR;58!4| ((|z1| NIL) ($$ NIL))
        (PROG ($ |derivation2|)
          (LETT $ (QREFELT $$ 1))
          (LETT |derivation2| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL
              (SPADCALL (SPADCALL (SPADCALL |z1| (QREFELT $ 38)) |derivation2|)
                        (SPADCALL |z1| (QREFELT $ 39)) (QREFELT $ 97))
              (SPADCALL (SPADCALL |z1| (QREFELT $ 38))
                        (SPADCALL (SPADCALL |z1| (QREFELT $ 39)) |derivation2|)
                        (QREFELT $ 97))
              (QREFELT $ 46))
             (SPADCALL (SPADCALL |z1| (QREFELT $ 39))
                       (SPADCALL |z1| (QREFELT $ 39)) (QREFELT $ 97))
             (QREFELT $ 196)))))) 

(SDEFUN |RDEEFX;ei_int;I2FSR;58!3| ((|z1| NIL) ($$ NIL))
        (PROG ($ |x| |dk|)
          (LETT $ (QREFELT $$ 2))
          (LETT |x| (QREFELT $$ 1))
          (LETT |dk| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL |z1|
                             (CONS #'|RDEEFX;ei_int;I2FSR;58!2| (VECTOR $ |x|))
                             |dk| (QREFELT $ 375))))))) 

(SDEFUN |RDEEFX;ei_int;I2FSR;58!2| ((|z2| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z2| |x| (QREFELT $ 323)))))) 

(SDEFUN |RDEEFX;ei_int;I2FSR;58!1| ((|z1| NIL) ($$ NIL))
        (PROG (|denfp| $ |x| |dk|)
          (LETT |denfp| (QREFELT $$ 3))
          (LETT $ (QREFELT $$ 2))
          (LETT |x| (QREFELT $$ 1))
          (LETT |dk| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL |denfp|
                             (SPADCALL |z1|
                                       (CONS #'|RDEEFX;ei_int;I2FSR;58!0|
                                             (VECTOR $ |x|))
                                       |dk| (QREFELT $ 375))
                             (QREFELT $ 97))))))) 

(SDEFUN |RDEEFX;ei_int;I2FSR;58!0| ((|z2| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z2| |x| (QREFELT $ 323)))))) 

(DECLAIM (NOTINLINE |ElementaryRischDEX;|)) 

(DEFUN |ElementaryRischDEX| (&REST #1=#:G2171)
  (SPROG NIL
         (PROG (#2=#:G2172)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ElementaryRischDEX|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ElementaryRischDEX;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|ElementaryRischDEX|)))))))))) 

(DEFUN |ElementaryRischDEX;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|ElementaryRischDEX| DV$1 DV$2))
          (LETT $ (GETREFV 382))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ElementaryRischDEX|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 '|%alg|)
          (QSETREFV $ 9 '|prim|)
          (QSETREFV $ 92 (SPADCALL (QREFELT $ 91)))
          (COND
           ((|domainEqual| |#1| (|Complex| (|Integer|)))
            (PROGN
             (QSETREFV $ 363
                       (CONS (|dispatchFunction| |RDEEFX;mk_erf;3F;54|) $))))
           ('T
            (QSETREFV $ 363
                      (CONS (|dispatchFunction| |RDEEFX;mk_erf;3F;55|) $))))
          $))) 

(MAKEPROP '|ElementaryRischDEX| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) 'ALGOP
              'PRIM (|List| 34) (0 . |kernels|) (|List| 18) (|Symbol|)
              (|IntegrationTools| 6 7) (5 . |varselect|) (11 . |union|)
              (|NonNegativeInteger|) (|Kernel| 7) (17 . |height|) (|Boolean|)
              (22 . |member?|) (28 . |is?|) (|BasicOperator|) (34 . |operator|)
              (39 . |has?|) (|List| 7) (45 . |argument|) (|Integer|)
              (50 . |elt|) (56 . |retract|) (61 . |One|) (65 . |One|)
              (|Fraction| 175) (|Kernel| $) (69 . |univariate|)
              (|SparseUnivariatePolynomial| 7) (|Fraction| 36) (75 . |numer|)
              (80 . |denom|) (85 . |degree|) (90 . |coefficient|) (96 . |Zero|)
              (100 . |Zero|) (104 . |monomial|) (110 . |coerce|) (115 . -)
              (121 . |coerce|) (126 . -) (131 . +) (137 . /) (143 . |kmax|)
              (|Union| 13 '"failed") (148 . |symbolIfCan|)
              (|Record| (|:| |ans| 7) (|:| |right| 7) (|:| |primpart| 7)
                        (|:| |sol?| 20))
              (|ElementaryRischDEX2| 6 7) (153 . |do_risch_DE|) (161 . |new|)
              (165 . |kernel|)
              (|PolynomialCategoryQuotientFunctions| (|IndexedExponents| 18) 18
                                                     6 134 7)
              (170 . |multivariate|) (176 . |coerce|) (181 . D) (|List| $)
              (187 . |eval|) (194 . *) |RDEEFX;ei_int;I2FSR;58| (200 . /)
              (206 . |eval|) (|SparseUnivariatePolynomial| 36) (|Mapping| 36 7)
              (|SparseUnivariatePolynomialFunctions2| 7 36) (213 . |map|)
              (219 . +) (225 . |coerce|) (|Mapping| 7 7 7) (230 . |reduce|)
              (237 . -) (243 . =) (249 . ^) (|Vector| 7) (255 . |vector|)
              (|Union| 86 '"failed") (|IntegerLinearDependence| 7)
              (260 . |particularSolutionOverQ|)
              (|Record| (|:| |num| 112) (|:| |den| 28)) (|Vector| 139)
              (|InnerCommonDenominator| 28 139 112 86)
              (266 . |splitDenominator|) (271 . ~=) (|SingletonAsOrderedSet|)
              (277 . |create|) '|dummy| (281 . |eval|) (288 . |coefficients|)
              (|Mapping| 20 7) (293 . |every?|) (299 . *) (305 . |monomial|)
              (311 . |coerce|) (316 . +) (322 . |resultant|) (328 . |Zero|)
              (332 . |leadingCoefficient|) (337 . /) (343 . |gcd|)
              (|Union| $ '"failed") (349 . |exquo|) (355 . |One|) (359 . ~=)
              (365 . |reductum|) (370 . =) (|List| 28) (|Vector| 28)
              (376 . |vector|) (381 . |gcd|) (386 . |elt|) (392 . |exquo|)
              (398 . |setelt!|) (405 . |invmod|)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (411 . |extendedEuclidean|) (417 . *) (423 . +) (|Factored| 36)
              (|ExpressionFactorPolynomial| 6 7) (429 . |factorPolynomial|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 127) (|:| |factor| 36) (|:| |exponent| 17))
              (|List| 128) (434 . |factorList|) (439 . ~=)
              (|Union| 28 '#1="failed") (445 . |retractIfCan|)
              (|SparseMultivariatePolynomial| 6 18) (450 . |One|) (454 . *)
              (|Record| (|:| |particular| 82) (|:| |basis| (|List| 86)))
              (460 . |solveLinearlyOverQ|) (|Fraction| 28) (466 . |coerce|)
              (|List| 139) (471 . |entries|) (476 . |vector|) (481 . |entries|)
              (|Fraction| 156) (|Equation| 145) (486 . |rhs|) (491 . |Zero|)
              (495 . ~=) (501 . |lhs|) (506 . |retract|) (511 . ~=)
              (|Union| 156 '#2="failed") (517 . |retractIfCan|)
              (|Union| 7 '"failed") (|Polynomial| 7) (522 . |retractIfCan|)
              (|Union| 139 '#1#) (527 . |retractIfCan|) (532 . |numer|)
              (|List| 13) (537 . |variables|) (542 . |member?|) (548 . |eval|)
              (555 . |retract|) (|FunctionSpaceRationalRoots| 6 7)
              (560 . |get_rational_roots|) (566 . |coerce|) (571 . |rest|)
              (576 . |rest|) (|SparseUnivariatePolynomial| 156)
              (|Mapping| 156 7) (|SparseUnivariatePolynomialFunctions2| 7 156)
              (581 . |map|) (|SparseUnivariatePolynomial| $)
              (587 . |multivariate|) (|SparseMultivariatePolynomial| 6 34)
              (593 . |numer|) (598 . |coerce|) (603 . |coerce|) (|List| 186)
              (|List| 145) (|SystemSolvePackage| 7) (608 . |solve|) (614 . -)
              (|List| 146) (620 . |last|) (625 . |coerce|) (630 . |univariate|)
              (635 . |rem|) (641 . |retractIfCan|) (646 . |differentiate|)
              (651 . |resultant|) (657 . |member?|) (663 . ^) (669 . /)
              (675 . |Zero|) (|Mapping| 36 36 36) (|List| 36) (679 . |reduce|)
              (686 . |unit|) (691 . |retract|)
              (|Record| (|:| |exponent| 17) (|:| |coef| 7) (|:| |radicand| 7))
              (|PolynomialRoots| (|IndexedExponents| 18) 18 6 134 7)
              (696 . |froot|) (702 . *) (|Matrix| 7) (708 . |zero|)
              (714 . |setelt!|) (722 . |zero|) (727 . |solveLinearlyOverQ|)
              (733 . |elt|) (739 . |denom|) (744 . *) (750 . |numer|)
              (755 . |minimumDegree|) (760 . |One|) (|List| 141) (|Matrix| 139)
              (764 . |matrix|) (|LinearSystemMatrixPackage| 139 86 86 219)
              (769 . |solve|) (775 . |parts|) (780 . |setelt!|) (787 . |Zero|)
              (791 . /) (797 . *) (803 . -) (809 . |retractIfCan|) (814 . ~=)
              (820 . |zero?|) (825 . |zero?|) (|Mapping| 20 28)
              (830 . |every?|) (836 . =) (842 . |retract|) (847 . *)
              (853 . |makeFR|) (|Factored| $) (859 . |squareFree|)
              (864 . |rootOf|) (869 . |elt|) (|Union| 80 '"failed")
              (|Mapping| 7 7) (|List| 244) (|ConstantLinearDependence| 6 7)
              (875 . |particularSolutionOverConstants|)
              (|Record| (|:| |logands| 26) (|:| |basis| (|List| 86)))
              (|ParametricIntegration| 6 7) (882 . |logextint|)
              (|LaurentPolynomial| 7 36) (889 . |coerce|) (894 . |max|)
              (900 . |max|) (|Mapping| 17 17 17) (|List| 17) (906 . |reduce|)
              (|Mapping| 248 12 26) (|ParametricRischDE| 6 7)
              (912 . |exp_lower_bound|)
              (|Record| (|:| |ratpart| 7) (|:| |coeffs| 80))
              (|Union| 261 '"failed") (923 . |do_param_RDE|) (|Union| 36 '#2#)
              (932 . |retractIfCan|)
              (|Record| (|:| |ans| 36) (|:| |remainder| 36)) (|Mapping| 36 36)
              (|RDEaux| 7) (937 . SPDE1) (944 . -) (950 . *) (956 . |One|)
              (960 . |setelt!|) (967 . |denom|) (|Factored| 134)
              (|MultivariateFactorize| 18 (|IndexedExponents| 18) 6 134)
              (972 . |factor|)
              (|Record| (|:| |flag| 127) (|:| |factor| 134)
                        (|:| |exponent| 17))
              (|List| 278) (977 . |factorList|) (982 . *) (988 . *)
              (|Mapping| 134 134 134) (|List| 134) (994 . |reduce|) (1001 . *)
              (1007 . ^) (1013 . |unit|) (1018 . |retract|) (1023 . *)
              (|PositiveInteger|) (1029 . ^) (1035 . |concat|) (|List| 26)
              (1041 . |matrix|) (|Record| (|:| |mat| 302) (|:| |vec| 113))
              (|Matrix| $) (|Vector| $) (1046 . |reducedSystem|)
              (|Union| 113 '"failed")
              (|Record| (|:| |particular| 300) (|:| |basis| (|List| 113)))
              (|Matrix| 28) (|SmithNormalForm| 28 113 113 302)
              (1052 . |diophantineSystem|) (1058 . /) (|Union| 294 '"failed")
              (|DenominatorIntegration| 6 7) (1064 . |solve_u|)
              (1071 . |second|) (1076 . |reduce|)
              (|PartialFractionUtilities| 7 36) (1082 . |decompose|)
              (1088 . |univariate|) (1095 . |retract|) (1100 . ^) (1106 . *)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (1112 . |divide|) (1118 . |elt|)
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 320 '"failed") (1124 . |extendedEuclidean|)
              (1131 . |differentiate|) (1137 . |exp|) (1142 . |Ei|)
              (1147 . |zerosOf|) (1152 . |retract|) (1157 . +) (1163 . |elt|)
              (|Vector| 36) (1170 . |elt|)
              (|Record| (|:| |factor| 36) (|:| |ratpart| 28) (|:| |v_part| 7)
                        (|:| |alg_part| 36) (|:| |u_part| 7)
                        (|:| |exponent| 28) (|:| |shift_part| 7))
              (|List| 332) (1176 . |elt|) (1182 . |vector|)
              (|Record| (|:| |basis| 330) (|:| |transform| 302))
              (|GcdBasis| 36) (1187 . |gcdDecomposition|) (1192 . =)
              (1198 . |elt|) (1205 . |tower|) (1210 . ~=) (1216 . ^) (1222 . *)
              (1228 . |sqrt|) (1233 . |pi|) (1237 . |erf|) (|List| 6)
              (1242 . |coefficients|) (|Complex| 28) (1247 . |imag|)
              (1252 . |Zero|) (1256 . =) (|Mapping| 20 350) (|List| 350)
              (1262 . |every?|) (1268 . |real|) (1273 . |complex|)
              (1279 . |coerce|) (1284 . |smaller?|) (1290 . |fresnelC|)
              (1295 . |fresnelS|) (1300 . |mk_erf|) (1306 . |log|)
              (1311 . |Gamma|) (1317 . ^) (1323 . ~=) (1329 . |coerce|)
              (1334 . |eval|) (|String|) (|OutputForm|) (1341 . |message|)
              (|Void|) (1346 . |print|) (1351 . |differentiate|)
              (|Record| (|:| |answer| 37) (|:| |logpart| 37)
                        (|:| |specpart| 37) (|:| |polypart| 36))
              (|TranscendentalHermiteIntegration| 7 36)
              (1358 . |HermiteIntegrate|)
              (|Record| (|:| |normal| 36) (|:| |special| 36))
              (|MonomialExtensionTools| 7 36) (1365 . |split|))
           '#(|mk_erf| 1371 |ei_int| 1377) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|ei_int|
                                 ((|Record| (|:| |ans| |#2|) (|:| |right| |#2|)
                                            (|:| |primpart| |#2|)
                                            (|:| |sol?| (|Boolean|)))
                                  (|Integer|) |#2| |#2| (|Symbol|)))
                                T)
                              '((|mk_erf| (|#2| |#2| |#2|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 381
                                            '(1 7 10 0 11 2 14 12 12 13 15 2 14
                                              12 12 12 16 1 18 17 0 19 2 12 20
                                              18 0 21 2 18 20 0 13 22 1 18 23 0
                                              24 2 23 20 0 13 25 1 18 26 0 27 2
                                              26 7 0 28 29 1 7 28 0 30 0 6 0 31
                                              0 7 0 32 2 7 33 0 34 35 1 37 36 0
                                              38 1 37 36 0 39 1 36 17 0 40 2 36
                                              7 0 17 41 0 6 0 42 0 7 0 43 2 36
                                              0 7 17 44 1 36 0 7 45 2 36 0 0 0
                                              46 1 37 0 36 47 1 7 0 0 48 2 36 0
                                              0 0 49 2 37 0 0 0 50 1 14 18 12
                                              51 1 18 52 0 53 4 55 54 7 7 13 12
                                              56 0 13 0 57 1 18 0 13 58 2 59 7
                                              37 18 60 1 7 0 34 61 2 7 0 0 13
                                              62 3 7 0 0 10 63 64 2 7 0 0 0 65
                                              2 7 0 0 0 67 3 7 0 0 34 0 68 2 71
                                              69 70 36 72 2 7 0 0 0 73 1 7 0 28
                                              74 3 26 7 75 0 7 76 2 7 0 0 0 77
                                              2 7 20 0 0 78 2 7 0 0 28 79 1 80
                                              0 26 81 2 83 82 80 7 84 1 87 85
                                              86 88 2 28 20 0 0 89 0 90 0 91 3
                                              36 0 0 90 0 93 1 36 26 0 94 2 26
                                              20 95 0 96 2 36 0 0 0 97 2 69 0
                                              36 17 98 1 69 0 36 99 2 69 0 0 0
                                              100 2 69 36 0 0 101 0 36 0 102 1
                                              36 7 0 103 2 36 0 0 7 104 2 36 0
                                              0 0 105 2 36 106 0 0 107 0 36 0
                                              108 2 36 20 0 0 109 1 36 0 0 110
                                              2 36 20 0 0 111 1 113 0 112 114 1
                                              28 0 63 115 2 113 28 0 28 116 2
                                              28 106 0 0 117 3 113 28 0 28 28
                                              118 2 28 0 0 0 119 2 28 120 0 0
                                              121 2 113 0 28 0 122 2 113 0 0 0
                                              123 1 125 124 36 126 1 124 129 0
                                              130 2 7 20 0 0 131 1 7 132 0 133
                                              0 134 0 135 2 36 0 7 0 136 2 83
                                              137 80 7 138 1 139 0 28 140 1 86
                                              141 0 142 1 86 0 141 143 1 113
                                              112 0 144 1 146 145 0 147 0 145 0
                                              148 2 145 20 0 0 149 1 146 145 0
                                              150 1 145 13 0 151 2 13 20 0 0
                                              152 1 145 153 0 154 1 156 155 0
                                              157 1 7 158 0 159 1 145 156 0 160
                                              1 156 161 0 162 2 161 20 13 0 163
                                              3 156 0 0 13 7 164 1 156 7 0 165
                                              2 166 141 7 18 167 1 156 0 7 168
                                              1 161 0 0 169 1 12 0 0 170 2 173
                                              171 172 36 174 2 156 0 175 13 176
                                              1 7 177 0 178 1 7 0 177 179 1 145
                                              0 156 180 2 183 181 182 161 184 2
                                              145 0 0 0 185 1 186 146 0 187 1 7
                                              0 139 188 1 156 36 0 189 2 36 0 0
                                              0 190 1 139 132 0 191 1 36 0 0
                                              192 2 36 7 0 0 193 2 141 20 139 0
                                              194 2 36 0 0 17 195 2 37 0 36 36
                                              196 0 37 0 197 3 199 36 198 0 36
                                              200 1 124 36 0 201 1 36 7 0 202 2
                                              204 203 7 17 205 2 36 0 0 7 206 2
                                              207 0 17 17 208 4 207 7 0 28 28 7
                                              209 1 80 0 17 210 2 83 137 207 80
                                              211 2 86 139 0 28 212 1 139 28 0
                                              213 2 139 0 28 0 214 1 139 28 0
                                              215 1 36 17 0 216 0 139 0 217 1
                                              219 0 218 220 2 221 137 219 86
                                              222 1 86 141 0 223 3 86 139 0 28
                                              139 224 0 139 0 225 2 139 0 28 28
                                              226 2 139 0 0 28 227 2 139 0 0 0
                                              228 1 36 155 0 229 2 17 20 0 0
                                              230 1 139 20 0 231 1 28 20 0 232
                                              2 112 20 233 0 234 2 139 20 0 0
                                              235 1 139 28 0 236 2 7 0 28 0 237
                                              2 124 0 36 129 238 1 36 239 0 240
                                              1 7 0 175 241 2 80 7 0 28 242 3
                                              246 243 80 7 245 247 3 249 248 13
                                              12 26 250 1 251 0 36 252 2 28 0 0
                                              0 253 2 17 0 0 0 254 2 256 17 255
                                              0 257 7 259 28 36 251 28 28 12 7
                                              258 260 5 55 262 7 7 26 13 12 263
                                              1 37 264 0 265 3 268 266 36 36
                                              267 269 2 37 0 0 0 270 2 37 0 36
                                              0 271 0 37 0 272 3 80 7 0 28 7
                                              273 1 7 177 0 274 1 276 275 134
                                              277 1 275 279 0 280 2 28 0 0 0
                                              281 2 134 0 0 0 282 3 284 134 283
                                              0 134 285 2 139 0 0 139 286 2 134
                                              0 0 17 287 1 275 134 0 288 1 134
                                              6 0 289 2 7 0 6 0 290 2 7 0 0 291
                                              292 2 26 0 0 0 293 1 207 0 294
                                              295 2 7 296 297 298 299 2 303 301
                                              302 113 304 2 139 0 0 0 305 3 307
                                              306 7 7 13 308 1 26 7 0 309 2 199
                                              36 198 0 310 2 311 199 36 199 312
                                              3 59 36 7 18 36 313 1 7 34 0 314
                                              2 37 0 0 28 315 2 37 0 0 0 316 2
                                              36 317 0 0 318 2 199 36 0 28 319
                                              3 36 321 0 0 0 322 2 7 0 0 13 323
                                              1 7 0 0 324 1 7 0 0 325 1 7 63
                                              175 326 1 37 36 0 327 2 37 0 0 0
                                              328 3 302 28 0 28 28 329 2 330 36
                                              0 28 331 2 333 332 0 28 334 1 330
                                              0 199 335 1 337 336 330 338 2 37
                                              20 0 0 339 3 302 0 0 112 112 340
                                              1 7 10 0 341 2 18 20 0 0 342 2 7
                                              0 0 17 343 2 37 0 0 36 344 1 7 0
                                              0 345 0 7 0 346 1 7 0 0 347 1 134
                                              348 0 349 1 350 28 0 351 0 28 0
                                              352 2 28 20 0 0 353 2 355 20 354
                                              0 356 1 350 28 0 357 2 350 0 28
                                              28 358 1 7 0 6 359 2 7 20 0 0 360
                                              1 7 0 0 361 1 7 0 0 362 2 0 7 7 7
                                              363 1 7 0 0 364 2 7 0 0 0 365 2 7
                                              0 0 0 366 2 37 20 0 0 367 1 7 0
                                              13 368 3 7 0 0 0 0 369 1 371 0
                                              370 372 1 371 373 0 374 3 36 0 0
                                              244 0 375 3 377 376 37 267 36 378
                                              2 380 379 36 267 381 2 0 7 7 7
                                              363 4 0 54 28 7 7 13 66)))))
           '|lookupComplete|)) 
