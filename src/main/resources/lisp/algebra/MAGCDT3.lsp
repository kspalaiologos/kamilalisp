
(SDEFUN |MAGCDT3;pack_modulus1|
        ((|lm| (|List| (|Polynomial| (|Integer|)))) (|lvz| (|List| (|Symbol|)))
         (|p| (|Integer|))
         ($ #1=(|Union| (|List| (|Polynomial| (|Integer|))) "failed")))
        (SPROG
         ((|res1u| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
          (|ic0| (|Polynomial| (|Integer|)))
          (|ic0u| (|Union| (|Polynomial| (|Integer|)) "failed"))
          (|c0| (|Polynomial| (|Integer|)))
          (|m1u| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
          (|lm1| (|List| (|Polynomial| (|Integer|)))) (|lm1u| #1#)
          (|lv1| (|List| (|Symbol|)))
          (|resu| (|SparseUnivariatePolynomial| (|Integer|)))
          (|icc| (|Integer|)) (|cc| (|Integer|))
          (|mm| (|SparseUnivariatePolynomial| (|Integer|)))
          (|m1| (|Polynomial| (|Integer|))) (|v1| (|Symbol|)))
         (SEQ (LETT |v1| (|SPADfirst| |lvz|)) (LETT |m1| (|SPADfirst| |lm|))
              (EXIT
               (COND
                ((EQL (LENGTH |lm|) 1)
                 (SEQ (LETT |mm| (SPADCALL |m1| (QREFELT $ 8)))
                      (LETT |cc| (SPADCALL |mm| (QREFELT $ 10)))
                      (EXIT
                       (COND ((EQL |cc| 0) (CONS 1 "failed"))
                             (#2='T
                              (SEQ
                               (LETT |icc| (SPADCALL |cc| |p| (QREFELT $ 12)))
                               (LETT |resu|
                                     (SPADCALL
                                      (CONS #'|MAGCDT3;pack_modulus1!0|
                                            (VECTOR $ |p|))
                                      (SPADCALL |icc| |mm| (QREFELT $ 14))
                                      (QREFELT $ 16)))
                               (EXIT
                                (CONS 0
                                      (LIST
                                       (SPADCALL |resu| |v1|
                                                 (QREFELT $ 18)))))))))))
                (#2#
                 (SEQ (LETT |lv1| (CDR |lvz|))
                      (LETT |lm1u|
                            (|MAGCDT3;pack_modulus1| (CDR |lm|) |lv1| |p| $))
                      (EXIT
                       (COND ((QEQCAR |lm1u| 1) (CONS 1 "failed"))
                             (#2#
                              (SEQ (LETT |lm1| (QCDR |lm1u|))
                                   (LETT |m1u|
                                         (SPADCALL (|SPADfirst| |lm|) |v1|
                                                   (QREFELT $ 20)))
                                   (LETT |c0| (SPADCALL |m1u| (QREFELT $ 22)))
                                   (LETT |ic0u|
                                         (SPADCALL |c0| |lm1| |lv1| |p|
                                                   (QREFELT $ 26)))
                                   (EXIT
                                    (COND ((QEQCAR |ic0u| 1) (CONS 1 "failed"))
                                          (#2#
                                           (SEQ (LETT |ic0| (QCDR |ic0u|))
                                                (LETT |res1u|
                                                      (SPADCALL
                                                       (CONS
                                                        #'|MAGCDT3;pack_modulus1!1|
                                                        (VECTOR $ |p| |lv1|
                                                                |lm1|))
                                                       (SPADCALL |ic0| |m1u|
                                                                 (QREFELT $
                                                                          27))
                                                       (QREFELT $ 29)))
                                                (EXIT
                                                 (CONS 0
                                                       (CONS
                                                        (SPADCALL |res1u| |v1|
                                                                  (QREFELT $
                                                                           30))
                                                        |lm1|)))))))))))))))))) 

(SDEFUN |MAGCDT3;pack_modulus1!1| ((|c| NIL) ($$ NIL))
        (PROG (|lm1| |lv1| |p| $)
          (LETT |lm1| (QREFELT $$ 3))
          (LETT |lv1| (QREFELT $$ 2))
          (LETT |p| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|MAGCDT3;mreduction1| |c| |lm1| |lv1| |p| $))))) 

(SDEFUN |MAGCDT3;pack_modulus1!0| ((|c| NIL) ($$ NIL))
        (PROG (|p| $)
          (LETT |p| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |c| |p| (QREFELT $ 13)))))) 

(SDEFUN |MAGCDT3;pack_modulus;LLIU;2|
        ((|lm| (|List| (|Polynomial| (|Integer|)))) (|lvz| (|List| (|Symbol|)))
         (|p| (|Integer|))
         ($
          (|Union|
           (|Record| (|:| |svz| (|List| (|Symbol|)))
                     (|:| |sm| (|List| (|Polynomial| (|Integer|))))
                     (|:| |msizes| (|List| (|Integer|)))
                     (|:| |sp| (|Integer|)))
           "failed")))
        (SPROG
         ((|sizes| (|List| (|Integer|))) (|msize| (|Integer|)) (#1=#:G764 NIL)
          (|deg| NIL) (|ldeg| (|List| (|NonNegativeInteger|))) (#2=#:G762 NIL)
          (|m| NIL) (#3=#:G763 NIL) (|v| NIL) (#4=#:G761 NIL)
          (|nlmu| (|Union| (|List| (|Polynomial| (|Integer|))) "failed")))
         (SEQ
          (COND
           ((SPADCALL (LENGTH |lvz|) (LENGTH |lm|) (QREFELT $ 32))
            (|error| "pack_modulus: #lvz ~= #lm"))
           (#5='T
            (SEQ (LETT |nlmu| (|MAGCDT3;pack_modulus1| |lm| |lvz| |p| $))
                 (EXIT
                  (COND ((QEQCAR |nlmu| 1) (CONS 1 "failed"))
                        (#5#
                         (SEQ
                          (LETT |ldeg|
                                (PROGN
                                 (LETT #4# NIL)
                                 (SEQ (LETT |v| NIL) (LETT #3# |lvz|)
                                      (LETT |m| NIL) (LETT #2# |lm|) G190
                                      (COND
                                       ((OR (ATOM #2#)
                                            (PROGN (LETT |m| (CAR #2#)) NIL)
                                            (ATOM #3#)
                                            (PROGN (LETT |v| (CAR #3#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #4#
                                              (CONS
                                               (SPADCALL |m| |v|
                                                         (QREFELT $ 34))
                                               #4#))))
                                      (LETT #2#
                                            (PROG1 (CDR #2#)
                                              (LETT #3# (CDR #3#))))
                                      (GO G190) G191 (EXIT (NREVERSE #4#)))))
                          (LETT |sizes| NIL) (LETT |msize| 1)
                          (SEQ (LETT |deg| NIL) (LETT #1# (REVERSE |ldeg|))
                               G190
                               (COND
                                ((OR (ATOM #1#)
                                     (PROGN (LETT |deg| (CAR #1#)) NIL))
                                 (GO G191)))
                               (SEQ (LETT |msize| (* |deg| |msize|))
                                    (EXIT
                                     (LETT |sizes| (CONS |msize| |sizes|))))
                               (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                          (EXIT
                           (CONS 0
                                 (VECTOR |lvz| (QCDR |nlmu|) |sizes|
                                         |p|))))))))))))) 

(SDEFUN |MAGCDT3;pack_exps0;SevL2IV;3|
        ((|exps| (|SortedExponentVector|)) (|sizes| (|List| (|Integer|)))
         (|ns| (|Integer|)) (|start| (|Integer|)) ($ (|Void|)))
        (SPROG
         ((#1=#:G776 NIL) (|j| NIL) (|nstart| (|Integer|)) (#2=#:G775 NIL)
          (|i| NIL) (|deg| (|Integer|)) (|msize| (|Integer|))
          (|size1| (|Integer|)) (|do_rec| (|Boolean|))
          (|rsiz| (|List| (|Integer|))))
         (SEQ (LETT |rsiz| (CDR |sizes|)) (LETT |do_rec| (NULL (NULL |rsiz|)))
              (LETT |size1| (|SPADfirst| |sizes|))
              (LETT |msize| (COND (|do_rec| (|SPADfirst| |rsiz|)) ('T 1)))
              (LETT |deg| (QUOTIENT2 |size1| |msize|))
              (EXIT
               (SEQ (LETT |i| 0) (LETT #2# (- |deg| 1)) G190
                    (COND ((|greater_SI| |i| #2#) (GO G191)))
                    (SEQ (LETT |nstart| (+ |start| (* (* |ns| |i|) |msize|)))
                         (SEQ (LETT |j| 0) (LETT #1# (- |msize| 1)) G190
                              (COND ((|greater_SI| |j| #1#) (GO G191)))
                              (SEQ
                               (EXIT
                                (SETELT_U32 |exps| (+ |nstart| (* |j| |ns|))
                                            |i|)))
                              (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                              (EXIT NIL))
                         (EXIT
                          (COND
                           (|do_rec|
                            (SPADCALL |exps| |rsiz| |ns| (+ |nstart| 1)
                                      (QREFELT $ 42))))))
                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL)))))) 

(SDEFUN |MAGCDT3;pack_exps;2IRSev;4|
        ((|dg| #1=(|Integer|)) (|msize| #1#)
         (|mu|
          (|Record| (|:| |svz| (|List| (|Symbol|)))
                    (|:| |sm| (|List| (|Polynomial| (|Integer|))))
                    (|:| |msizes| (|List| (|Integer|)))
                    (|:| |sp| (|Integer|))))
         ($ (|SortedExponentVector|)))
        (SPROG
         ((|exps| (|SortedExponentVector|)) (|nsize| (|NonNegativeInteger|))
          (|ns| (|NonNegativeInteger|)) (|size0| (|Integer|))
          (|sizes| (|List| (|Integer|))))
         (SEQ (LETT |sizes| (QVELT |mu| 2))
              (LETT |msize| (|SPADfirst| |sizes|))
              (LETT |size0| (* (+ |dg| 1) |msize|))
              (LETT |ns| (+ (LENGTH |sizes|) 1))
              (LETT |nsize| (* |ns| |size0|))
              (LETT |exps| (GETREFV_U32 |nsize| 0))
              (SPADCALL |exps| (CONS |size0| |sizes|) |ns| 0 (QREFELT $ 42))
              (EXIT |exps|)))) 

(SDEFUN |MAGCDT3;repack0|
        ((|res0| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
         (|coeffs| (|U32Vector|)) (|start| (|Integer|))
         (|lv| (|List| (|Symbol|))) (|sizes| (|List| (|Integer|)))
         ($ (|Void|)))
        (SPROG
         ((|j| (|Integer|)) (|nsizes| (|List| (|Integer|)))
          (|msize| (|Integer|)) (|nlv| (|List| (|Symbol|))) (|v1| (|Symbol|))
          (|cc| (|Integer|)))
         (SEQ
          (COND
           ((NULL |lv|)
            (SEQ
             (SEQ G190
                  (COND
                   ((NULL
                     (NULL
                      (SPADCALL |res0| (|spadConstant| $ 44) (QREFELT $ 45))))
                    (GO G191)))
                  (SEQ (LETT |j| (SPADCALL |res0| (QREFELT $ 46)))
                       (LETT |cc|
                             (SPADCALL (SPADCALL |res0| (QREFELT $ 22))
                                       (QREFELT $ 47)))
                       (SETELT_U32 |coeffs| (+ |start| |j|) |cc|)
                       (EXIT (LETT |res0| (SPADCALL |res0| (QREFELT $ 48)))))
                  NIL (GO G190) G191 (EXIT NIL))
             (EXIT (SPADCALL (QREFELT $ 49)))))
           ('T
            (SEQ (LETT |v1| (|SPADfirst| |lv|)) (LETT |nlv| (CDR |lv|))
                 (LETT |msize| (|SPADfirst| |sizes|))
                 (LETT |nsizes| (CDR |sizes|))
                 (EXIT
                  (SEQ G190
                       (COND
                        ((NULL
                          (NULL
                           (SPADCALL |res0| (|spadConstant| $ 44)
                                     (QREFELT $ 45))))
                         (GO G191)))
                       (SEQ (LETT |j| (SPADCALL |res0| (QREFELT $ 46)))
                            (|MAGCDT3;repack0|
                             (SPADCALL (SPADCALL |res0| (QREFELT $ 22)) |v1|
                                       (QREFELT $ 20))
                             |coeffs| (+ |start| (* |j| |msize|)) |nlv|
                             |nsizes| $)
                            (EXIT
                             (LETT |res0| (SPADCALL |res0| (QREFELT $ 48)))))
                       NIL (GO G190) G191 (EXIT NIL))))))))) 

(SDEFUN |MAGCDT3;repack1;SupUvIRV;6|
        ((|res00| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
         (|coeffs| (|U32Vector|)) (|dg| (|Integer|))
         (|mu|
          (|Record| (|:| |svz| (|List| (|Symbol|)))
                    (|:| |sm| (|List| (|Polynomial| (|Integer|))))
                    (|:| |msizes| (|List| (|Integer|)))
                    (|:| |sp| (|Integer|))))
         ($ (|Void|)))
        (SPROG
         ((#1=#:G795 NIL) (|i| NIL) (|msize| (|Integer|))
          (|sizes| (|List| (|Integer|))) (|lv| (|List| (|Symbol|))))
         (SEQ (LETT |lv| (QVELT |mu| 0)) (LETT |sizes| (QVELT |mu| 2))
              (LETT |msize| (|SPADfirst| |sizes|))
              (SEQ (LETT |i| 0) (LETT #1# (- (* (+ |dg| 1) |msize|) 1)) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ (EXIT (SETELT_U32 |coeffs| |i| 0)))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (|MAGCDT3;repack0| |res00| |coeffs| 0 |lv| |sizes| $))))) 

(SDEFUN |MAGCDT3;MPtoMPT;PSLRU;7|
        ((|x| (|Polynomial| (|Integer|))) (|ivx| #1=(|Symbol|))
         (|ivz| (|List| #1#))
         (|mu|
          (|Record| (|:| |svz| (|List| (|Symbol|)))
                    (|:| |sm| (|List| (|Polynomial| (|Integer|))))
                    (|:| |msizes| (|List| (|Integer|)))
                    (|:| |sp| (|Integer|))))
         ($
          (|Union| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|)))
                   "failed")))
        (CONS 0 (SPADCALL |x| |ivx| (QREFELT $ 20)))) 

(SDEFUN |MAGCDT3;zero?;SupB;8|
        ((|x| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
         ($ (|Boolean|)))
        (SPADCALL |x| (|spadConstant| $ 44) (QREFELT $ 45))) 

(SDEFUN |MAGCDT3;degree;SupI;9|
        ((|x| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
         ($ (|Integer|)))
        (SPADCALL |x| (QREFELT $ 56))) 

(SDEFUN |MAGCDT3;mreduction1|
        ((|x| (|Polynomial| (|Integer|)))
         (|lm| (|List| (|Polynomial| (|Integer|)))) (|lv| (|List| (|Symbol|)))
         (|p| (|Integer|)) ($ (|Polynomial| (|Integer|))))
        (SPROG
         ((|ux| #1=(|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
          (|c| (|Polynomial| (|Integer|))) (|dx| #2=(|Integer|)) (|dm1| #2#)
          (|rm| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
          (|um1| #1#) (|v1| (|Symbol|)) (|m1| (|Polynomial| (|Integer|)))
          (|cc| (|Integer|)))
         (SEQ
          (COND
           ((NULL |lm|)
            (SEQ (LETT |cc| (SPADCALL |x| (QREFELT $ 47)))
                 (EXIT
                  (SPADCALL (SPADCALL |cc| |p| (QREFELT $ 13))
                            (QREFELT $ 57)))))
           ('T
            (SEQ (LETT |m1| (|SPADfirst| |lm|)) (LETT |v1| (|SPADfirst| |lv|))
                 (LETT |um1| (SPADCALL |m1| |v1| (QREFELT $ 20)))
                 (LETT |rm| (SPADCALL |um1| (QREFELT $ 48)))
                 (LETT |dm1| (SPADCALL |um1| (QREFELT $ 46)))
                 (LETT |ux| (SPADCALL |x| |v1| (QREFELT $ 20)))
                 (SEQ G190
                      (COND
                       ((NULL
                         (SEQ (LETT |dx| (SPADCALL |ux| (QREFELT $ 46)))
                              (EXIT (NULL (< |dx| |dm1|)))))
                        (GO G191)))
                      (SEQ (LETT |c| (SPADCALL |ux| (QREFELT $ 22)))
                           (LETT |c|
                                 (|MAGCDT3;mreduction1| |c| (CDR |lm|)
                                  (CDR |lv|) |p| $))
                           (EXIT
                            (LETT |ux|
                                  (SPADCALL (SPADCALL |ux| (QREFELT $ 48))
                                            (SPADCALL
                                             (SPADCALL |c| (- |dx| |dm1|)
                                                       (QREFELT $ 58))
                                             |rm| (QREFELT $ 59))
                                            (QREFELT $ 60)))))
                      NIL (GO G190) G191 (EXIT NIL))
                 (LETT |ux|
                       (SPADCALL
                        (CONS #'|MAGCDT3;mreduction1!0|
                              (VECTOR |p| |lv| $ |lm|))
                        |ux| (QREFELT $ 29)))
                 (EXIT (SPADCALL |ux| |v1| (QREFELT $ 30))))))))) 

(SDEFUN |MAGCDT3;mreduction1!0| ((|c| NIL) ($$ NIL))
        (PROG (|lm| $ |lv| |p|)
          (LETT |lm| (QREFELT $$ 3))
          (LETT $ (QREFELT $$ 2))
          (LETT |lv| (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|MAGCDT3;mreduction1| |c| (SPADCALL |lm| (QREFELT $ 61))
             (SPADCALL |lv| (QREFELT $ 62)) |p| $))))) 

(SDEFUN |MAGCDT3;mreduction|
        ((|x| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
         (|mu|
          (|Record| (|:| |svz| #1=(|List| (|Symbol|)))
                    (|:| |sm| #2=(|List| (|Polynomial| (|Integer|))))
                    (|:| |msizes| (|List| (|Integer|)))
                    (|:| |sp| #3=(|Integer|))))
         ($ (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|)))))
        (SPROG ((|p| #3#) (|lv| #1#) (|lm| #2#))
               (SEQ (LETT |lm| (QVELT |mu| 1)) (LETT |lv| (QVELT |mu| 0))
                    (LETT |p| (QVELT |mu| 3))
                    (EXIT
                     (SPADCALL
                      (CONS #'|MAGCDT3;mreduction!0| (VECTOR $ |p| |lv| |lm|))
                      |x| (QREFELT $ 29)))))) 

(SDEFUN |MAGCDT3;mreduction!0| ((|c| NIL) ($$ NIL))
        (PROG (|lm| |lv| |p| $)
          (LETT |lm| (QREFELT $$ 3))
          (LETT |lv| (QREFELT $$ 2))
          (LETT |p| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|MAGCDT3;mreduction1| |c| |lm| |lv| |p| $))))) 

(SDEFUN |MAGCDT3;extended_gcd|
        ((|x| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
         (|y| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
         (|lm| (|List| (|Polynomial| (|Integer|)))) (|lv| (|List| (|Symbol|)))
         (|p| (|Integer|))
         ($
          (|List| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))))
        (SPROG
         ((#1=#:G838 NIL)
          (|t1| #2=(|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
          (|t0| #3=(|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
          (|#G53| #4=(|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
          (|#G52| #2#) (|s1| #3#) (|s0| #2#) (|#G51| #4#) (|#G50| #3#)
          (|r1| #4#) (|r0| #4#) (|#G49| #4#) (|#G48| #4#)
          (|cm| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
          (|c0| #5=(|Polynomial| (|Integer|))) (|dr0| #6=(|Integer|))
          (|c1| #5#) (|dr1| #6#))
         (SEQ
          (EXIT
           (SEQ
            (LETT |r0|
                  (SPADCALL
                   (CONS #'|MAGCDT3;extended_gcd!0| (VECTOR $ |p| |lv| |lm|))
                   |x| (QREFELT $ 29)))
            (LETT |s0| (|spadConstant| $ 50)) (LETT |t0| (|spadConstant| $ 44))
            (LETT |r1|
                  (SPADCALL
                   (CONS #'|MAGCDT3;extended_gcd!1| (VECTOR $ |p| |lv| |lm|))
                   |y| (QREFELT $ 29)))
            (LETT |s1| (|spadConstant| $ 44)) (LETT |t1| (|spadConstant| $ 50))
            (SEQ G190
                 (COND
                  ((NULL (> (LETT |dr1| (SPADCALL |r1| (QREFELT $ 46))) 0))
                   (GO G191)))
                 (SEQ (LETT |c1| (SPADCALL |r1| (QREFELT $ 22)))
                      (SEQ G190
                           (COND
                            ((NULL
                              (>= (LETT |dr0| (SPADCALL |r0| (QREFELT $ 46)))
                                  |dr1|))
                             (GO G191)))
                           (SEQ (LETT |c0| (SPADCALL |r0| (QREFELT $ 22)))
                                (LETT |c0|
                                      (|MAGCDT3;mreduction1| |c0| |lm| |lv| |p|
                                       $))
                                (LETT |cm|
                                      (SPADCALL |c0| (- |dr0| |dr1|)
                                                (QREFELT $ 58)))
                                (LETT |r0|
                                      (SPADCALL
                                       (SPADCALL |c1|
                                                 (SPADCALL |r0| (QREFELT $ 48))
                                                 (QREFELT $ 27))
                                       (SPADCALL |cm|
                                                 (SPADCALL |r1| (QREFELT $ 48))
                                                 (QREFELT $ 59))
                                       (QREFELT $ 60)))
                                (LETT |s0|
                                      (SPADCALL
                                       (SPADCALL |c1| |s0| (QREFELT $ 27))
                                       (SPADCALL |cm| |s1| (QREFELT $ 59))
                                       (QREFELT $ 60)))
                                (EXIT
                                 (LETT |t0|
                                       (SPADCALL
                                        (SPADCALL |c1| |t0| (QREFELT $ 27))
                                        (SPADCALL |cm| |t1| (QREFELT $ 59))
                                        (QREFELT $ 60)))))
                           NIL (GO G190) G191 (EXIT NIL))
                      (LETT |r0|
                            (SPADCALL
                             (CONS #'|MAGCDT3;extended_gcd!2|
                                   (VECTOR $ |p| |lv| |lm|))
                             |r0| (QREFELT $ 29)))
                      (LETT |s0|
                            (SPADCALL
                             (CONS #'|MAGCDT3;extended_gcd!3|
                                   (VECTOR $ |p| |lv| |lm|))
                             |s0| (QREFELT $ 29)))
                      (LETT |t0|
                            (SPADCALL
                             (CONS #'|MAGCDT3;extended_gcd!4|
                                   (VECTOR $ |p| |lv| |lm|))
                             |r0| (QREFELT $ 29)))
                      (PROGN
                       (LETT |#G48| |r1|)
                       (LETT |#G49| |r0|)
                       (LETT |r0| |#G48|)
                       (LETT |r1| |#G49|))
                      (PROGN
                       (LETT |#G50| |s1|)
                       (LETT |#G51| |s0|)
                       (LETT |s0| |#G50|)
                       (LETT |s1| |#G51|))
                      (EXIT
                       (PROGN
                        (LETT |#G52| |t1|)
                        (LETT |#G53| |t0|)
                        (LETT |t0| |#G52|)
                        (LETT |t1| |#G53|))))
                 NIL (GO G190) G191 (EXIT NIL))
            (EXIT
             (COND
              ((SPADCALL |r1| (|spadConstant| $ 44) (QREFELT $ 45))
               (PROGN (LETT #1# (LIST |r0| |s0| |t0|)) (GO #7=#:G837)))
              ('T (PROGN (LETT #1# (LIST |r1| |s1| |t1|)) (GO #7#)))))))
          #7# (EXIT #1#)))) 

(SDEFUN |MAGCDT3;extended_gcd!4| ((|c| NIL) ($$ NIL))
        (PROG (|lm| |lv| |p| $)
          (LETT |lm| (QREFELT $$ 3))
          (LETT |lv| (QREFELT $$ 2))
          (LETT |p| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|MAGCDT3;mreduction1| |c| |lm| |lv| |p| $))))) 

(SDEFUN |MAGCDT3;extended_gcd!3| ((|c| NIL) ($$ NIL))
        (PROG (|lm| |lv| |p| $)
          (LETT |lm| (QREFELT $$ 3))
          (LETT |lv| (QREFELT $$ 2))
          (LETT |p| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|MAGCDT3;mreduction1| |c| |lm| |lv| |p| $))))) 

(SDEFUN |MAGCDT3;extended_gcd!2| ((|c| NIL) ($$ NIL))
        (PROG (|lm| |lv| |p| $)
          (LETT |lm| (QREFELT $$ 3))
          (LETT |lv| (QREFELT $$ 2))
          (LETT |p| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|MAGCDT3;mreduction1| |c| |lm| |lv| |p| $))))) 

(SDEFUN |MAGCDT3;extended_gcd!1| ((|c| NIL) ($$ NIL))
        (PROG (|lm| |lv| |p| $)
          (LETT |lm| (QREFELT $$ 3))
          (LETT |lv| (QREFELT $$ 2))
          (LETT |p| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|MAGCDT3;mreduction1| |c| |lm| |lv| |p| $))))) 

(SDEFUN |MAGCDT3;extended_gcd!0| ((|c| NIL) ($$ NIL))
        (PROG (|lm| |lv| |p| $)
          (LETT |lm| (QREFELT $$ 3))
          (LETT |lv| (QREFELT $$ 2))
          (LETT |p| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|MAGCDT3;mreduction1| |c| |lm| |lv| |p| $))))) 

(SDEFUN |MAGCDT3;m_inverse;PLLIU;13|
        ((|x| (|Polynomial| (|Integer|)))
         (|lm| (|List| (|Polynomial| (|Integer|)))) (|lv| (|List| (|Symbol|)))
         (|p| (|Integer|)) ($ (|Union| (|Polynomial| (|Integer|)) "failed")))
        (SPROG
         ((|res1| (|Polynomial| (|Integer|)))
          (|ic0| (|Polynomial| (|Integer|)))
          (|ic0u| (|Union| (|Polynomial| (|Integer|)) "failed"))
          (|c0| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
          (|ee|
           (|List| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|)))))
          (|ux| #1=(|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
          (|um1| #1#) (|lv1| (|List| (|Symbol|)))
          (|lm1| (|List| (|Polynomial| (|Integer|)))) (|v1| (|Symbol|))
          (|m1| (|Polynomial| (|Integer|))) (|cc| (|Integer|)))
         (SEQ
          (COND
           ((NULL |lm|)
            (SEQ (LETT |cc| (SPADCALL |x| (QREFELT $ 47)))
                 (EXIT
                  (COND ((EQL |cc| 0) (CONS 1 "failed"))
                        (#2='T
                         (CONS 0
                               (SPADCALL (SPADCALL |cc| |p| (QREFELT $ 12))
                                         (QREFELT $ 57))))))))
           (#2#
            (SEQ (LETT |m1| (|SPADfirst| |lm|)) (LETT |v1| (|SPADfirst| |lv|))
                 (LETT |lm1| (CDR |lm|)) (LETT |lv1| (CDR |lv|))
                 (LETT |um1| (SPADCALL |m1| |v1| (QREFELT $ 20)))
                 (LETT |ux| (SPADCALL |x| |v1| (QREFELT $ 20)))
                 (LETT |ee|
                       (|MAGCDT3;extended_gcd| |ux| |um1| |lm1| |lv1| |p| $))
                 (LETT |c0| (SPADCALL |ee| 1 (QREFELT $ 64)))
                 (EXIT
                  (COND
                   ((> (SPADCALL |c0| (QREFELT $ 46)) 0) (CONS 1 "failed"))
                   (#2#
                    (SEQ
                     (LETT |ic0u|
                           (SPADCALL (SPADCALL |c0| (QREFELT $ 65)) |lm1| |lv1|
                                     |p| (QREFELT $ 26)))
                     (EXIT
                      (COND ((QEQCAR |ic0u| 1) (CONS 1 "failed"))
                            (#2#
                             (SEQ (LETT |ic0| (QCDR |ic0u|))
                                  (LETT |res1|
                                        (SPADCALL
                                         (SPADCALL |ic0|
                                                   (SPADCALL |ee| 2
                                                             (QREFELT $ 64))
                                                   (QREFELT $ 27))
                                         |v1| (QREFELT $ 30)))
                                  (EXIT
                                   (CONS 0
                                         (|MAGCDT3;mreduction1| |res1| |lm|
                                          |lv| |p| $))))))))))))))))) 

(SDEFUN |MAGCDT3;canonicalIfCan;SupRU;14|
        ((|x| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
         (|mu|
          (|Record| (|:| |svz| (|List| (|Symbol|)))
                    (|:| |sm| (|List| (|Polynomial| (|Integer|))))
                    (|:| |msizes| (|List| (|Integer|)))
                    (|:| |sp| (|Integer|))))
         ($
          (|Union| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|)))
                   "failed")))
        (SPROG
         ((|rr| (|Union| (|Polynomial| (|Integer|)) "failed"))
          (|cl| (|Polynomial| (|Integer|))) (|p| (|Integer|))
          (|lv| (|List| (|Symbol|)))
          (|lm| (|List| (|Polynomial| (|Integer|)))))
         (SEQ (LETT |lm| (QVELT |mu| 1)) (LETT |lv| (QVELT |mu| 0))
              (LETT |p| (QVELT |mu| 3))
              (LETT |cl| (SPADCALL |x| (QREFELT $ 22)))
              (LETT |rr| (SPADCALL |cl| |lm| |lv| |p| (QREFELT $ 26)))
              (EXIT
               (COND ((QEQCAR |rr| 1) (CONS 1 "failed"))
                     ('T
                      (CONS 0
                            (|MAGCDT3;mreduction|
                             (SPADCALL (QCDR |rr|) |x| (QREFELT $ 27)) |mu|
                             $)))))))) 

(SDEFUN |MAGCDT3;pseudoRem;2SupRSup;15|
        ((|x| #1=(|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
         (|y| #1#)
         (|mu|
          (|Record| (|:| |svz| (|List| (|Symbol|)))
                    (|:| |sm| (|List| (|Polynomial| (|Integer|))))
                    (|:| |msizes| (|List| (|Integer|)))
                    (|:| |sp| (|Integer|))))
         ($ (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|)))))
        (SPROG
         ((|cy| #2=(|Polynomial| (|Integer|)))
          (|cm| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
          (|c2| (|Polynomial| (|Integer|))) (|ccy| #2#)
          (|cmm| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|))))
          (|ccx| #2#) (|c| #2#) (|j| #3=(|Integer|)) (|i| #3#))
         (SEQ (LETT |i| (SPADCALL |x| (QREFELT $ 46)))
              (LETT |j| (SPADCALL |y| (QREFELT $ 46)))
              (EXIT
               (COND ((EQL |j| 0) (|spadConstant| $ 44)) ((< |i| |j|) |x|)
                     ('T
                      (SEQ (LETT |cy| (SPADCALL |y| (QREFELT $ 22)))
                           (LETT |c| (SPADCALL |x| (QREFELT $ 22)))
                           (LETT |cm|
                                 (SPADCALL |c|
                                           (SPADCALL (|spadConstant| $ 38)
                                                     (- |i| |j|)
                                                     (QREFELT $ 58))
                                           (QREFELT $ 27)))
                           (COND
                            ((> |i| |j|)
                             (SEQ
                              (LETT |ccx|
                                    (SPADCALL (SPADCALL |x| (QREFELT $ 48))
                                              (QREFELT $ 22)))
                              (LETT |cmm|
                                    (SPADCALL (|spadConstant| $ 38)
                                              (- (- |i| |j|) 1)
                                              (QREFELT $ 58)))
                              (LETT |ccy|
                                    (SPADCALL (SPADCALL |y| (QREFELT $ 48))
                                              (QREFELT $ 22)))
                              (LETT |c2|
                                    (SPADCALL
                                     (SPADCALL |cy| |ccx| (QREFELT $ 67))
                                     (SPADCALL |c| |ccy| (QREFELT $ 67))
                                     (QREFELT $ 68)))
                              (LETT |cm|
                                    (|MAGCDT3;mreduction|
                                     (SPADCALL
                                      (SPADCALL |cy| |cm| (QREFELT $ 27))
                                      (SPADCALL |c2| |cmm| (QREFELT $ 27))
                                      (QREFELT $ 69))
                                     |mu| $))
                              (EXIT
                               (LETT |cy|
                                     (|MAGCDT3;mreduction1|
                                      (SPADCALL |cy| |cy| (QREFELT $ 67))
                                      (QVELT |mu| 1) (QVELT |mu| 0)
                                      (QVELT |mu| 3) $))))))
                           (LETT |x|
                                 (SPADCALL (SPADCALL |cy| |x| (QREFELT $ 27))
                                           (SPADCALL |cm| |y| (QREFELT $ 59))
                                           (QREFELT $ 60)))
                           (EXIT (|MAGCDT3;mreduction| |x| |mu| $))))))))) 

(DECLAIM (NOTINLINE |ModularAlgebraicGcdTools3;|)) 

(DEFUN |ModularAlgebraicGcdTools3| ()
  (SPROG NIL
         (PROG (#1=#:G875)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache| '|ModularAlgebraicGcdTools3|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|ModularAlgebraicGcdTools3|
                             (LIST
                              (CONS NIL
                                    (CONS 1 (|ModularAlgebraicGcdTools3;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|ModularAlgebraicGcdTools3|)))))))))) 

(DEFUN |ModularAlgebraicGcdTools3;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|ModularAlgebraicGcdTools3|))
          (LETT $ (GETREFV 71))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ModularAlgebraicGcdTools3| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ModularAlgebraicGcdTools3| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|SparseUnivariatePolynomial| 9)
              (|Polynomial| 9) (0 . |univariate|) (|Integer|)
              (5 . |leadingCoefficient|) (10 . |Zero|) (14 . |invmod|)
              (20 . |positiveRemainder|) (26 . *) (|Mapping| 9 9) (32 . |map|)
              (|Symbol|) (38 . |multivariate|) (|SparseUnivariatePolynomial| $)
              (44 . |univariate|) (|SparseUnivariatePolynomial| 7)
              (50 . |leadingCoefficient|) (|Union| 7 '"failed") (|List| 7)
              (|List| 17) |MAGCDT3;m_inverse;PLLIU;13| (55 . *) (|Mapping| 7 7)
              (61 . |map|) (67 . |multivariate|) (|Boolean|) (73 . ~=)
              (|NonNegativeInteger|) (79 . |degree|)
              (|Record| (|:| |svz| 25) (|:| |sm| 24) (|:| |msizes| 41)
                        (|:| |sp| 9))
              (|Union| 35 '"failed") |MAGCDT3;pack_modulus;LLIU;2| (85 . |One|)
              (|Void|) (|SortedExponentVector|) (|List| 9)
              |MAGCDT3;pack_exps0;SevL2IV;3| |MAGCDT3;pack_exps;2IRSev;4|
              (89 . |Zero|) (93 . =) |MAGCDT3;degree;SupI;9| (99 . |ground|)
              (104 . |reductum|) (109 . |void|) (113 . |One|) (|U32Vector|)
              |MAGCDT3;repack1;SupUvIRV;6| (|Union| 21 '"failed")
              |MAGCDT3;MPtoMPT;PSLRU;7| |MAGCDT3;zero?;SupB;8| (117 . |degree|)
              (122 . |coerce|) (127 . |monomial|) (133 . *) (139 . -)
              (145 . |rest|) (150 . |rest|) (|List| 21) (155 . |elt|)
              (161 . |ground|) |MAGCDT3;canonicalIfCan;SupRU;14| (166 . *)
              (172 . -) (178 . +) |MAGCDT3;pseudoRem;2SupRSup;15|)
           '#(|zero?| 184 |repack1| 189 |pseudoRem| 197 |pack_modulus| 204
              |pack_exps0| 211 |pack_exps| 219 |m_inverse| 226 |degree| 234
              |canonicalIfCan| 239 |MPtoMPT| 245)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS '#((|ModularAlgebraicGcdOperations| 7 21 35))
                             (|makeByteWordVec2| 70
                                                 '(1 7 6 0 8 1 6 9 0 10 0 7 0
                                                   11 2 9 0 0 0 12 2 9 0 0 0 13
                                                   2 6 0 9 0 14 2 6 0 15 0 16 2
                                                   7 0 6 17 18 2 7 19 0 17 20 1
                                                   21 7 0 22 2 21 0 7 0 27 2 21
                                                   0 28 0 29 2 7 0 19 17 30 2 9
                                                   31 0 0 32 2 7 33 0 17 34 0 7
                                                   0 38 0 21 0 44 2 21 31 0 0
                                                   45 1 7 9 0 47 1 21 0 0 48 0
                                                   39 0 49 0 21 0 50 1 21 33 0
                                                   56 1 7 0 9 57 2 21 0 7 33 58
                                                   2 21 0 0 0 59 2 21 0 0 0 60
                                                   1 24 0 0 61 1 25 0 0 62 2 63
                                                   21 0 9 64 1 21 7 0 65 2 7 0
                                                   0 0 67 2 7 0 0 0 68 2 21 0 0
                                                   0 69 1 0 31 21 55 4 0 39 21
                                                   51 9 35 52 3 0 21 21 21 35
                                                   70 3 0 36 24 25 9 37 4 0 39
                                                   40 41 9 9 42 3 0 40 9 9 35
                                                   43 4 0 23 7 24 25 9 26 1 0 9
                                                   21 46 2 0 53 21 35 66 4 0 53
                                                   7 17 25 35 54)))))
           '|lookupComplete|)) 

(MAKEPROP '|ModularAlgebraicGcdTools3| 'NILADIC T) 
