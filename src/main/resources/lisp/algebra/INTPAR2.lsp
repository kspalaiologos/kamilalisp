
(SDEFUN |INTPAR2;prim?| ((|k| (|Kernel| F)) (|x| (|Symbol|)) ($ (|Boolean|)))
        (COND ((SPADCALL |k| '|log| (QREFELT $ 13)) 'T)
              ('T
               (SPADCALL (SPADCALL |k| (QREFELT $ 15)) (QREFELT $ 8)
                         (QREFELT $ 16))))) 

(SDEFUN |INTPAR2;csolve2|
        ((|m| (|Matrix| F)) ($ (|List| (|Vector| (|Fraction| (|Integer|))))))
        (SPROG ((|v| (|Vector| F)) (|n| (|NonNegativeInteger|)))
               (SEQ (LETT |n| (ANROWS |m|))
                    (LETT |v| (MAKEARR1 |n| (|spadConstant| $ 18)))
                    (EXIT (QCDR (SPADCALL |m| |v| (QREFELT $ 24))))))) 

(SDEFUN |INTPAR2;primlogextint|
        ((|x| (|Symbol|)) (|k| (|Kernel| F)) (|l| (|List| (|Kernel| F)))
         (|lg| (|List| F))
         ($
          (|Record| (|:| |logands| (|List| F))
                    (|:| |basis|
                         (|List| (|Vector| (|Fraction| (|Integer|))))))))
        (SPROG
         ((#1=#:G784 NIL) (|le| NIL) (#2=#:G783 NIL)
          (|bl| #3=(|List| (|Vector| (|Fraction| (|Integer|)))))
          (|ll| #4=(|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|#G11|
           (|Record|
            (|:| |logands|
                 (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
            (|:| |basis| (|List| (|Vector| (|Fraction| (|Integer|)))))))
          (#5=#:G782 NIL) (|g| NIL) (#6=#:G781 NIL)
          (|uf|
           (|Mapping| (|Factored| (|SparseUnivariatePolynomial| F))
                      (|SparseUnivariatePolynomial| F)))
          (|der|
           (|Mapping| (|SparseUnivariatePolynomial| F)
                      (|SparseUnivariatePolynomial| F)))
          (|d1| (|Mapping| F F))
          (|rec|
           (|Mapping| (|Record| (|:| |logands| #4#) (|:| |basis| #3#))
                      (|List| (|SparseUnivariatePolynomial| F))))
          (|rec1|
           (|Mapping|
            (|Record| (|:| |logands| (|List| F))
                      (|:| |basis|
                           (|List| (|Vector| (|Fraction| (|Integer|))))))
            (|List| F))))
         (SEQ
          (LETT |rec1| (CONS #'|INTPAR2;primlogextint!0| (VECTOR $ |l| |x|)))
          (LETT |rec| (CONS #'|INTPAR2;primlogextint!1| (VECTOR |rec1| $)))
          (LETT |d1| (CONS #'|INTPAR2;primlogextint!2| (VECTOR $ |x|)))
          (LETT |der|
                (CONS #'|INTPAR2;primlogextint!3| (VECTOR |x| $ |k| |d1|)))
          (LETT |uf| (ELT $ 44))
          (PROGN
           (LETT |#G11|
                 (SPADCALL |der| |uf| (CONS (|function| |INTPAR2;csolve2|) $)
                           |rec|
                           (PROGN
                            (LETT #6# NIL)
                            (SEQ (LETT |g| NIL) (LETT #5# |lg|) G190
                                 (COND
                                  ((OR (ATOM #5#)
                                       (PROGN (LETT |g| (CAR #5#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #6#
                                         (CONS
                                          (SPADCALL |g| |k| (QREFELT $ 46))
                                          #6#))))
                                 (LETT #5# (CDR #5#)) (GO G190) G191
                                 (EXIT (NREVERSE #6#))))
                           (QREFELT $ 51)))
           (LETT |ll| (QCAR |#G11|))
           (LETT |bl| (QCDR |#G11|))
           |#G11|)
          (EXIT
           (CONS
            (PROGN
             (LETT #2# NIL)
             (SEQ (LETT |le| NIL) (LETT #1# |ll|) G190
                  (COND
                   ((OR (ATOM #1#) (PROGN (LETT |le| (CAR #1#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (LETT #2# (CONS (SPADCALL |le| |k| (QREFELT $ 54)) #2#))))
                  (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#))))
            |bl|))))) 

(SDEFUN |INTPAR2;primlogextint!3| ((|x1| NIL) ($$ NIL))
        (PROG (|d1| |k| $ |x|)
          (LETT |d1| (QREFELT $$ 3))
          (LETT |k| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |x| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |x1| |d1|
                      (SPADCALL
                       (SPADCALL (SPADCALL |k| (QREFELT $ 37)) |x|
                                 (QREFELT $ 35))
                       (QREFELT $ 39))
                      (QREFELT $ 41)))))) 

(SDEFUN |INTPAR2;primlogextint!2| ((|x1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |x| (QREFELT $ 35)))))) 

(SDEFUN |INTPAR2;primlogextint!1| ((|lg2| NIL) ($$ NIL))
        (PROG ($ |rec1|)
          (LETT $ (QREFELT $$ 1))
          (LETT |rec1| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |lg2| (CONS (|function| |INTPAR2;csolve2|) $) |rec1|
                      (QREFELT $ 34)))))) 

(SDEFUN |INTPAR2;primlogextint!0| ((|lg1| NIL) ($$ NIL))
        (PROG (|x| |l| $)
          (LETT |x| (QREFELT $$ 2))
          (LETT |l| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |l| |lg1| (QREFELT $ 28)))))) 

(SDEFUN |INTPAR2;explogextint1|
        ((|lg| (|List| (|SparseUnivariatePolynomial| F))) (|eta| (F))
         (|rec1|
          (|Mapping|
           (|Record| (|:| |logands| (|List| F))
                     (|:| |basis|
                          (|List| (|Vector| (|Fraction| (|Integer|))))))
           (|List| F)))
         ($
          (|Record|
           (|:| |logands|
                (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
           (|:| |basis| (|List| (|Vector| (|Fraction| (|Integer|))))))))
        (SPROG
         ((|ll1| (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|bl| (|List| (|Vector| (|Fraction| (|Integer|)))))
          (|ll| (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|#G17|
           (|Record|
            (|:| |logands|
                 (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
            (|:| |basis| (|List| (|Vector| (|Fraction| (|Integer|)))))))
          (|lg1| (|List| (|SparseUnivariatePolynomial| F))))
         (SEQ
          (LETT |lg1|
                (SPADCALL |lg| (SPADCALL |eta| (QREFELT $ 39)) (QREFELT $ 55)))
          (PROGN
           (LETT |#G17|
                 (SPADCALL |lg1| (CONS (|function| |INTPAR2;csolve2|) $) |rec1|
                           (QREFELT $ 34)))
           (LETT |ll| (QCAR |#G17|))
           (LETT |bl| (QCDR |#G17|))
           |#G17|)
          (LETT |ll1|
                (CONS
                 (SPADCALL (SPADCALL (|spadConstant| $ 57) 1 (QREFELT $ 59))
                           (QREFELT $ 60))
                 |ll|))
          (EXIT (CONS |ll1| |bl|))))) 

(SDEFUN |INTPAR2;explogextint|
        ((|x| (|Symbol|)) (|k| (|Kernel| F)) (|l| (|List| (|Kernel| F)))
         (|lg| (|List| F))
         ($
          (|Record| (|:| |logands| (|List| F))
                    (|:| |basis|
                         (|List| (|Vector| (|Fraction| (|Integer|))))))))
        (SPROG
         ((#1=#:G819 NIL) (|le| NIL) (#2=#:G818 NIL)
          (|bl| (|List| (|Vector| (|Fraction| (|Integer|)))))
          (|ll| (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|#G22|
           (|Record|
            (|:| |logands|
                 (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
            (|:| |basis| (|List| (|Vector| (|Fraction| (|Integer|)))))))
          (#3=#:G817 NIL) (|g| NIL) (#4=#:G816 NIL)
          (|uf|
           (|Mapping| (|Factored| (|SparseUnivariatePolynomial| F))
                      (|SparseUnivariatePolynomial| F)))
          (|rec|
           (|Mapping|
            (|Record|
             (|:| |logands|
                  (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
             (|:| |basis| (|List| (|Vector| (|Fraction| (|Integer|))))))
            (|List| (|SparseUnivariatePolynomial| F))))
          (|rec1|
           (|Mapping|
            (|Record| (|:| |logands| (|List| F))
                      (|:| |basis|
                           (|List| (|Vector| (|Fraction| (|Integer|))))))
            (|List| F)))
          (|der|
           (|Mapping| (|SparseUnivariatePolynomial| F)
                      (|SparseUnivariatePolynomial| F)))
          (|d1| (|Mapping| F F)) (|eta| (F)))
         (SEQ
          (LETT |eta|
                (SPADCALL (|SPADfirst| (SPADCALL |k| (QREFELT $ 61))) |x|
                          (QREFELT $ 35)))
          (LETT |d1| (CONS #'|INTPAR2;explogextint!0| (VECTOR $ |x|)))
          (LETT |der| (CONS #'|INTPAR2;explogextint!1| (VECTOR $ |eta| |d1|)))
          (LETT |rec1| (CONS #'|INTPAR2;explogextint!2| (VECTOR $ |l| |x|)))
          (LETT |rec|
                (CONS #'|INTPAR2;explogextint!3| (VECTOR $ |rec1| |eta|)))
          (LETT |uf| (ELT $ 44))
          (PROGN
           (LETT |#G22|
                 (SPADCALL |der| |uf| (CONS (|function| |INTPAR2;csolve2|) $)
                           |rec|
                           (PROGN
                            (LETT #4# NIL)
                            (SEQ (LETT |g| NIL) (LETT #3# |lg|) G190
                                 (COND
                                  ((OR (ATOM #3#)
                                       (PROGN (LETT |g| (CAR #3#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #4#
                                         (CONS
                                          (SPADCALL |g| |k| (QREFELT $ 46))
                                          #4#))))
                                 (LETT #3# (CDR #3#)) (GO G190) G191
                                 (EXIT (NREVERSE #4#))))
                           (QREFELT $ 51)))
           (LETT |ll| (QCAR |#G22|))
           (LETT |bl| (QCDR |#G22|))
           |#G22|)
          (EXIT
           (CONS
            (PROGN
             (LETT #2# NIL)
             (SEQ (LETT |le| NIL) (LETT #1# |ll|) G190
                  (COND
                   ((OR (ATOM #1#) (PROGN (LETT |le| (CAR #1#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (LETT #2# (CONS (SPADCALL |le| |k| (QREFELT $ 54)) #2#))))
                  (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#))))
            |bl|))))) 

(SDEFUN |INTPAR2;explogextint!3| ((|lg2| NIL) ($$ NIL))
        (PROG (|eta| |rec1| $)
          (LETT |eta| (QREFELT $$ 2))
          (LETT |rec1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|INTPAR2;explogextint1| |lg2| |eta| |rec1| $))))) 

(SDEFUN |INTPAR2;explogextint!2| ((|lg1| NIL) ($$ NIL))
        (PROG (|x| |l| $)
          (LETT |x| (QREFELT $$ 2))
          (LETT |l| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |l| |lg1| (QREFELT $ 28)))))) 

(SDEFUN |INTPAR2;explogextint!1| ((|x1| NIL) ($$ NIL))
        (PROG (|d1| |eta| $)
          (LETT |d1| (QREFELT $$ 2))
          (LETT |eta| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |x1| |d1|
                      (SPADCALL |eta| (|spadConstant| $ 62) (QREFELT $ 59))
                      (QREFELT $ 41)))))) 

(SDEFUN |INTPAR2;explogextint!0| ((|x1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |x| (QREFELT $ 35)))))) 

(SDEFUN |INTPAR2;alglogextint|
        ((|x| (|Symbol|)) (|k| (|Kernel| F)) (|l| (|List| (|Kernel| F)))
         (|lg| (|List| F))
         ($
          (|Record| (|:| |logands| (|List| F))
                    (|:| |basis|
                         (|List| (|Vector| (|Fraction| (|Integer|))))))))
        (SPROG NIL
               (COND
                ((SPADCALL (CONS #'|INTPAR2;alglogextint!0| (VECTOR $ |k|))
                           |lg| (QREFELT $ 67))
                 (SPADCALL |x| |l| |lg| (QREFELT $ 28)))
                ('T (|error| "alglogextint: unimplemented"))))) 

(SDEFUN |INTPAR2;alglogextint!0| ((|g| NIL) ($$ NIL))
        (PROG (|k| $)
          (LETT |k| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (NULL
             (SPADCALL |k| (SPADCALL |g| (QREFELT $ 64)) (QREFELT $ 65))))))) 

(SDEFUN |INTPAR2;logextint;SLLR;7|
        ((|x| (|Symbol|)) (|l| (|List| (|Kernel| F))) (|lg| (|List| F))
         ($
          (|Record| (|:| |logands| (|List| F))
                    (|:| |basis|
                         (|List| (|Vector| (|Fraction| (|Integer|))))))))
        (SPROG
         ((#1=#:G849 NIL) (|k1| NIL) (#2=#:G848 NIL) (|k| (|Kernel| F))
          (|cb| (|List| (|Vector| (|Fraction| (|Integer|))))))
         (SEQ
          (COND
           ((NULL |l|)
            (SEQ
             (LETT |cb|
                   (|INTPAR2;csolve2| (SPADCALL (LIST |lg|) (QREFELT $ 69)) $))
             (EXIT (CONS NIL |cb|))))
           (#3='T
            (SEQ (LETT |k| (SPADCALL |l| (QREFELT $ 71)))
                 (LETT |l|
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |k1| NIL) (LETT #1# |l|) G190
                             (COND
                              ((OR (ATOM #1#)
                                   (PROGN (LETT |k1| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((SPADCALL |k1| |k| (QREFELT $ 72))
                                 (LETT #2# (CONS |k1| #2#))))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT (NREVERSE #2#)))))
                 (COND
                  ((OR (QEQCAR (SPADCALL |k| (QREFELT $ 74)) 0)
                       (|INTPAR2;prim?| |k| |x| $))
                   (EXIT (|INTPAR2;primlogextint| |x| |k| |l| |lg| $))))
                 (EXIT
                  (COND
                   ((SPADCALL |k| '|exp| (QREFELT $ 13))
                    (|INTPAR2;explogextint| |x| |k| |l| |lg| $))
                   ((SPADCALL (SPADCALL |k| (QREFELT $ 15)) (QREFELT $ 9)
                              (QREFELT $ 16))
                    (|INTPAR2;alglogextint| |x| |k| |l| |lg| $))
                   (#3# (|error| "logextint: unhandled kernel")))))))))) 

(SDEFUN |INTPAR2;extendedint;FSLR;8|
        ((|f| (F)) (|x| (|Symbol|)) (|lg| (|List| F))
         ($
          (|Record|
           (|:| |particular|
                (|Union|
                 (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))
                 "failed"))
           (|:| |basis|
                (|List|
                 (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))))
        (SPROG ((|l| (|List| (|Kernel| F))))
               (SEQ
                (LETT |l|
                      (SPADCALL
                       (SPADCALL
                        (CONS (SPADCALL |x| (QREFELT $ 75)) (CONS |f| |lg|))
                        (QREFELT $ 77))
                       |x| (QREFELT $ 78)))
                (EXIT (SPADCALL |f| |x| |l| |lg| (QREFELT $ 82)))))) 

(SDEFUN |INTPAR2;extendedint;SLLL;9|
        ((|x| (|Symbol|)) (|l| (|List| (|Kernel| F))) (|lg| (|List| F))
         ($ (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G873 NIL) (|k1| NIL) (#2=#:G872 NIL) (|k| (|Kernel| F))
          (#3=#:G871 NIL) (|kv| NIL) (#4=#:G870 NIL)
          (|cb| (|List| (|Vector| F))))
         (SEQ
          (COND
           ((NULL |l|)
            (SEQ
             (LETT |cb|
                   (SPADCALL (SPADCALL (LIST |lg|) (QREFELT $ 69))
                             (QREFELT $ 85)))
             (EXIT
              (PROGN
               (LETT #4# NIL)
               (SEQ (LETT |kv| NIL) (LETT #3# |cb|) G190
                    (COND
                     ((OR (ATOM #3#) (PROGN (LETT |kv| (CAR #3#)) NIL))
                      (GO G191)))
                    (SEQ
                     (EXIT
                      (LETT #4# (CONS (CONS (|spadConstant| $ 18) |kv|) #4#))))
                    (LETT #3# (CDR #3#)) (GO G190) G191
                    (EXIT (NREVERSE #4#)))))))
           (#5='T
            (SEQ (LETT |k| (SPADCALL |l| (QREFELT $ 71)))
                 (LETT |l|
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |k1| NIL) (LETT #1# |l|) G190
                             (COND
                              ((OR (ATOM #1#)
                                   (PROGN (LETT |k1| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((SPADCALL |k1| |k| (QREFELT $ 72))
                                 (LETT #2# (CONS |k1| #2#))))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT (NREVERSE #2#)))))
                 (COND
                  ((OR (QEQCAR (SPADCALL |k| (QREFELT $ 74)) 0)
                       (|INTPAR2;prim?| |k| |x| $))
                   (EXIT (|INTPAR2;primextint| |x| |k| |l| |lg| $))))
                 (EXIT
                  (COND
                   ((SPADCALL |k| '|exp| (QREFELT $ 13))
                    (|INTPAR2;expextint| |x| |k| |l| |lg| $))
                   ((SPADCALL (SPADCALL |k| (QREFELT $ 15)) (QREFELT $ 9)
                              (QREFELT $ 16))
                    (|INTPAR2;algextint| |x| |k| |l| |lg| $))
                   ((SPADCALL |k| '|%diff| (QREFELT $ 13))
                    (|INTPAR2;diffextint| |x| |k| |l| |lg| $))
                   (#5# (|INTPAR2;unkextint| |x| |k| |l| |lg| $)))))))))) 

(SDEFUN |INTPAR2;extendedint;FSLLR;10|
        ((|f| (F)) (|x| (|Symbol|)) (|l| (|List| (|Kernel| F)))
         (|lg| (|List| F))
         ($
          (|Record|
           (|:| |particular|
                (|Union|
                 (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))
                 "failed"))
           (|:| |basis|
                (|List|
                 (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))))
        (SPADCALL
         (SPADCALL |x| |l| (CONS (SPADCALL |f| (QREFELT $ 88)) |lg|)
                   (QREFELT $ 87))
         (QREFELT $ 90))) 

(SDEFUN |INTPAR2;extendedint0|
        ((|f| (F)) (|x| (|Symbol|)) (|l| (|List| (|Kernel| F))) (|g| (F))
         ($
          (|Union| (|Record| (|:| |ratpart| F) (|:| |coeff| F) (|:| |prim| F))
                   "failed")))
        (SPROG
         ((|rf| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
          (|r1|
           (|Union| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))
                    "failed")))
         (SEQ
          (LETT |r1| (QCAR (SPADCALL |f| |x| |l| (LIST |g|) (QREFELT $ 82))))
          (EXIT
           (COND ((QEQCAR |r1| 1) (CONS 1 "failed"))
                 ('T
                  (SEQ (LETT |rf| (QCDR |r1|))
                       (EXIT
                        (CONS 0
                              (VECTOR (QCAR |rf|)
                                      (SPADCALL (QCDR |rf|) 1 (QREFELT $ 92))
                                      (|spadConstant| $ 18))))))))))) 

(SDEFUN |INTPAR2;hermite_integrate|
        ((|lf| (|List| F)) (|x| (|Symbol|)) (|k| (|Kernel| F))
         ($ (|List| (|Record| (|:| |answer| F) (|:| |rest| F)))))
        (SPROG
         ((#1=#:G922 NIL) (|h1| NIL) (#2=#:G921 NIL)
          (|lher|
           (|List|
            (|Record|
             (|:| |answer| (|Fraction| (|SparseUnivariatePolynomial| F)))
             (|:| |logpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
             (|:| |specpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
             (|:| |polypart| (|SparseUnivariatePolynomial| F)))))
          (#3=#:G920 NIL) (|fu| NIL) (#4=#:G919 NIL)
          (|der|
           (|Mapping| (|SparseUnivariatePolynomial| F)
                      (|SparseUnivariatePolynomial| F)))
          (|eta| (F)) (|d1| (|Mapping| F F))
          (|lfu| (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
          (#5=#:G918 NIL) (|f| NIL) (#6=#:G917 NIL))
         (SEQ
          (LETT |lfu|
                (PROGN
                 (LETT #6# NIL)
                 (SEQ (LETT |f| NIL) (LETT #5# |lf|) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |f| (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #6#
                              (CONS (SPADCALL |f| |k| (QREFELT $ 46)) #6#))))
                      (LETT #5# (CDR #5#)) (GO G190) G191
                      (EXIT (NREVERSE #6#)))))
          (LETT |d1| (CONS #'|INTPAR2;hermite_integrate!0| (VECTOR $ |x|)))
          (LETT |der|
                (COND
                 ((OR (QEQCAR (SPADCALL |k| (QREFELT $ 74)) 0)
                      (|INTPAR2;prim?| |k| |x| $))
                  (CONS #'|INTPAR2;hermite_integrate!1|
                        (VECTOR |x| $ |k| |d1|)))
                 ('T
                  (SEQ
                   (LETT |eta|
                         (SPADCALL (SPADCALL |k| (QREFELT $ 61))
                                   (QREFELT $ 93)))
                   (EXIT
                    (CONS #'|INTPAR2;hermite_integrate!2|
                          (VECTOR $ |x| |eta| |d1|)))))))
          (LETT |lher|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |fu| NIL) (LETT #3# |lfu|) G190
                      (COND
                       ((OR (ATOM #3#) (PROGN (LETT |fu| (CAR #3#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #4#
                              (CONS (SPADCALL |fu| |der| (QREFELT $ 96))
                                    #4#))))
                      (LETT #3# (CDR #3#)) (GO G190) G191
                      (EXIT (NREVERSE #4#)))))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |h1| NIL) (LETT #1# |lher|) G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |h1| (CAR #1#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #2#
                         (CONS
                          (CONS (SPADCALL (QVELT |h1| 0) |k| (QREFELT $ 54))
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (QVELT |h1| 1) (QVELT |h1| 2)
                                            (QREFELT $ 97))
                                  (SPADCALL (QVELT |h1| 3) (QREFELT $ 60))
                                  (QREFELT $ 97))
                                 |k| (QREFELT $ 54)))
                          #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |INTPAR2;hermite_integrate!2| ((|x1| NIL) ($$ NIL))
        (PROG (|d1| |eta| |x| $)
          (LETT |d1| (QREFELT $$ 3))
          (LETT |eta| (QREFELT $$ 2))
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |x1| |d1|
                      (SPADCALL (SPADCALL |eta| |x| (QREFELT $ 35))
                                (|spadConstant| $ 62) (QREFELT $ 59))
                      (QREFELT $ 41)))))) 

(SDEFUN |INTPAR2;hermite_integrate!1| ((|x1| NIL) ($$ NIL))
        (PROG (|d1| |k| $ |x|)
          (LETT |d1| (QREFELT $$ 3))
          (LETT |k| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |x| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |x1| |d1|
                      (SPADCALL
                       (SPADCALL (SPADCALL |k| (QREFELT $ 37)) |x|
                                 (QREFELT $ 35))
                       (QREFELT $ 39))
                      (QREFELT $ 41)))))) 

(SDEFUN |INTPAR2;hermite_integrate!0| ((|x1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |x| (QREFELT $ 35)))))) 

(SDEFUN |INTPAR2;gen_polylog|
        ((|d| (|NonNegativeInteger|)) (|v| (F)) (|k| (F)) ($ (F)))
        (SPROG
         ((|nn| (|Fraction| (|Integer|))) (|s| (F)) (#1=#:G930 NIL) (|j| NIL)
          (|lv| (F)) (|res| (F)))
         (SEQ
          (COND
           ((EQL |d| 1)
            (SPADCALL (SPADCALL 2 (QREFELT $ 98))
                      (SPADCALL (|spadConstant| $ 57) |v| (QREFELT $ 99))
                      (QREFELT $ 100)))
           ('T
            (SEQ
             (LETT |res|
                   (SPADCALL (SPADCALL (+ |d| 1) (QREFELT $ 98)) |v|
                             (QREFELT $ 100)))
             (LETT |lv| |k|)
             (LETT |s|
                   (SPADCALL
                    (SPADCALL |lv|
                              (SPADCALL
                               (SPADCALL (|spadConstant| $ 57) |v|
                                         (QREFELT $ 99))
                               (QREFELT $ 101))
                              (QREFELT $ 102))
                    (QREFELT $ 88)))
             (SEQ (LETT |j| 2) (LETT #1# |d|) G190
                  (COND ((|greater_SI| |j| #1#) (GO G191)))
                  (SEQ
                   (EXIT
                    (LETT |s|
                          (SPADCALL |lv|
                                    (SPADCALL
                                     (SPADCALL (SPADCALL |j| (QREFELT $ 98))
                                               |v| (QREFELT $ 100))
                                     (SPADCALL |s|
                                               (SPADCALL (+ (- |d| |j|) 2)
                                                         (QREFELT $ 98))
                                               (QREFELT $ 103))
                                     (QREFELT $ 99))
                                    (QREFELT $ 102)))))
                  (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
             (LETT |nn|
                   (SPADCALL
                    (SPADCALL (SPADCALL (|spadConstant| $ 109) (QREFELT $ 110))
                              |d| (QREFELT $ 111))
                    (SPADCALL |d| (QREFELT $ 113)) (QREFELT $ 114)))
             (EXIT
              (SPADCALL (SPADCALL |nn| (QREFELT $ 115))
                        (SPADCALL |res| |s| (QREFELT $ 99))
                        (QREFELT $ 102))))))))) 

(SDEFUN |INTPAR2;polylog_int;FSKNniLFU;14|
        ((|f| (F)) (|x| (|Symbol|)) (|k0| (|Kernel| F))
         (|d| (|NonNegativeInteger|)) (|l| (|List| (|Kernel| F))) (|g| (F))
         ($
          (|Union| (|Record| (|:| |ratpart| F) (|:| |coeff| F) (|:| |prim| F))
                   #1="failed")))
        (SPROG
         ((|res2|
           (|Union| (|Record| (|:| |ratpart| F) (|:| |coeff| F) (|:| |prim| F))
                    #1#))
          (#2=#:G949 NIL) (|res| (F)) (|c0| (F)) (|v1| (F)) (|dv| (F))
          (|v| (F)) (|ans1| (F))
          (|res1| (|Record| (|:| |answer| F) (|:| |rest| F)))
          (|k| (|Kernel| F)))
         (SEQ
          (EXIT
           (SEQ (LETT |ans1| (|spadConstant| $ 18))
                (COND
                 ((> |d| 0)
                  (COND
                   ((SPADCALL |k0| '|log| (QREFELT $ 13))
                    (SEQ (LETT |k| (SPADCALL |l| (QREFELT $ 71)))
                         (LETT |ans1| (|spadConstant| $ 18))
                         (COND
                          ((OR (QEQCAR (SPADCALL |k| (QREFELT $ 74)) 0)
                               (OR (|INTPAR2;prim?| |k| |x| $)
                                   (SPADCALL |k| '|exp| (QREFELT $ 13))))
                           (SEQ
                            (LETT |res1|
                                  (|SPADfirst|
                                   (|INTPAR2;hermite_integrate| (LIST |f|) |x|
                                    |k| $)))
                            (LETT |f| (QCDR |res1|))
                            (EXIT (LETT |ans1| (QCAR |res1|))))))
                         (LETT |v|
                               (|SPADfirst| (SPADCALL |k0| (QREFELT $ 61))))
                         (LETT |dv| (SPADCALL |v| |x| (QREFELT $ 35)))
                         (LETT |v1|
                               (SPADCALL (|spadConstant| $ 57) |v|
                                         (QREFELT $ 99)))
                         (LETT |c0|
                               (SPADCALL (SPADCALL |f| |v1| (QREFELT $ 102))
                                         |dv| (QREFELT $ 103)))
                         (EXIT
                          (COND
                           ((SPADCALL (SPADCALL |c0| |x| (QREFELT $ 35))
                                      (|spadConstant| $ 18) (QREFELT $ 116))
                            (SEQ
                             (LETT |res|
                                   (SPADCALL |c0|
                                             (|INTPAR2;gen_polylog| |d| |v|
                                              (SPADCALL |k0| (QREFELT $ 37)) $)
                                             (QREFELT $ 102)))
                             (EXIT
                              (PROGN
                               (LETT #2#
                                     (CONS 0
                                           (VECTOR |ans1| (|spadConstant| $ 18)
                                                   |res|)))
                               (GO #3=#:G948))))))))))))
                (LETT |res2| (|INTPAR2;extendedint0| |f| |x| |l| |g| $))
                (EXIT
                 (COND ((QEQCAR |res2| 1) (CONS 1 "failed"))
                       ('T
                        (CONS 0
                              (VECTOR
                               (SPADCALL |ans1| (QVELT (QCDR |res2|) 0)
                                         (QREFELT $ 117))
                               (QVELT (QCDR |res2|) 1)
                               (QVELT (QCDR |res2|) 2))))))))
          #3# (EXIT #2#)))) 

(SDEFUN |INTPAR2;polylog_int;FSKNniLFU;15|
        ((|f| (F)) (|x| (|Symbol|)) (|k0| (|Kernel| F))
         (|d| (|NonNegativeInteger|)) (|l| (|List| (|Kernel| F))) (|g| (F))
         ($
          (|Union| (|Record| (|:| |ratpart| F) (|:| |coeff| F) (|:| |prim| F))
                   "failed")))
        (|INTPAR2;extendedint0| |f| |x| |l| |g| $)) 

(SDEFUN |INTPAR2;csolve1|
        ((|m| (|Matrix| F)) (|d1| (|Mapping| F F)) ($ (|List| (|Vector| F))))
        (SPADCALL |m| (LIST |d1|) (QREFELT $ 123))) 

(SDEFUN |INTPAR2;wrapfn|
        ((|fn|
          (|Mapping|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
           (|List| F)))
         (|k| (|Kernel| F))
         ($
          (|Mapping|
           (|List|
            (|Record|
             (|:| |ratpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
             (|:| |coeffs| (|Vector| F))))
           (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))))
        (SPROG NIL (SEQ (CONS #'|INTPAR2;wrapfn!0| (VECTOR |fn| $ |k|))))) 

(SDEFUN |INTPAR2;wrapfn!0| ((|lrf| NIL) ($$ NIL))
        (PROG (|k| $ |fn|)
          (LETT |k| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |fn| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((#1=#:G970 NIL) (|a| NIL) (#2=#:G971 NIL) (|be| NIL)
              (#3=#:G969 NIL) (|la| NIL) (#4=#:G968 NIL) (#5=#:G967 NIL)
              (|r1| NIL) (|lf| NIL) (#6=#:G966 NIL) (|rf| NIL) (#7=#:G965 NIL))
             (SEQ
              (LETT |lf|
                    (PROGN
                     (LETT #7# NIL)
                     (SEQ (LETT |rf| NIL) (LETT #6# |lrf|) G190
                          (COND
                           ((OR (ATOM #6#) (PROGN (LETT |rf| (CAR #6#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #7#
                                  (CONS (SPADCALL |rf| |k| (QREFELT $ 54))
                                        #7#))))
                          (LETT #6# (CDR #6#)) (GO G190) G191
                          (EXIT (NREVERSE #7#)))))
              (LETT |r1| (SPADCALL |lf| |fn|))
              (LETT |la|
                    (PROGN
                     (LETT #5# NIL)
                     (SEQ (LETT |be| NIL) (LETT #4# |r1|) G190
                          (COND
                           ((OR (ATOM #4#) (PROGN (LETT |be| (CAR #4#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #5#
                                  (CONS
                                   (SPADCALL (QCAR |be|) |k| (QREFELT $ 46))
                                   #5#))))
                          (LETT #4# (CDR #4#)) (GO G190) G191
                          (EXIT (NREVERSE #5#)))))
              (EXIT
               (PROGN
                (LETT #3# NIL)
                (SEQ (LETT |be| NIL) (LETT #2# |r1|) (LETT |a| NIL)
                     (LETT #1# |la|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |a| (CAR #1#)) NIL)
                           (ATOM #2#) (PROGN (LETT |be| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ (EXIT (LETT #3# (CONS (CONS |a| (QCDR |be|)) #3#))))
                     (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                     (GO G190) G191 (EXIT (NREVERSE #3#))))))))))) 

(SDEFUN |INTPAR2;algextint|
        ((|x| (|Symbol|)) (|k| (|Kernel| F)) (|l| (|List| (|Kernel| F)))
         (|lg| (|List| F))
         ($ (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G1131 NIL) (|be| NIL) (#2=#:G1130 NIL)
          (|res1|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))))
          (|lg1| (|List| F)) (#3=#:G1129 NIL) (|g| NIL) (#4=#:G1128 NIL)
          (|nk| (F)) (|nk1| (F)) (|yk| #5=(|Kernel| F)) (|y| (F))
          (|rec|
           (|Record| (|:| |primelt| F)
                     (|:| |pol1| (|SparseUnivariatePolynomial| F))
                     (|:| |pol2| (|SparseUnivariatePolynomial| F))
                     (|:| |prim| (|SparseUnivariatePolynomial| F))))
          (#6=#:G1126 NIL) (|a1| NIL) (#7=#:G1127 NIL) (|bv| NIL)
          (#8=#:G1125 NIL) (|cb| (|List| (|Vector| F)))
          (|ncb| (|List| (|Vector| F))) (#9=#:G1124 NIL) (#10=#:G1123 NIL)
          (|ca| (|List| F)) (|nca| (|List| F)) (#11=#:G1121 NIL)
          (#12=#:G1122 NIL) (#13=#:G1120 NIL) (|na1| (|List| F))
          (#14=#:G1119 NIL) (#15=#:G1118 NIL) (#16=#:G1117 NIL)
          (#17=#:G1116 NIL) (|oroot| (F)) (|nrr| #5#) (#18=#:G1115 NIL)
          (#19=#:G1114 NIL) (#20=#:G1113 NIL) (#21=#:G1111 NIL) (|i| NIL)
          (#22=#:G1112 NIL) (#23=#:G1110 NIL) (#24=#:G1109 NIL)
          (#25=#:G1108 NIL) (#26=#:G1107 NIL) (|n| (|NonNegativeInteger|))
          (|al|
           (|List|
            (|Record| (|:| |funs| (|List| F)) (|:| |nroot| F)
                      (|:| |npow1| (|Integer|)) (|:| |npow2| (|Integer|)))))
          (#27=#:G1106 NIL) (|k2| NIL) (#28=#:G1105 NIL)
          (|rde2|
           (|Mapping|
            (|List|
             (|Record|
              (|:| |ratpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
              (|:| |coeffs| (|Vector| F))))
            (|Fraction| (|SparseUnivariatePolynomial| F))
            (|List| (|Fraction| (|SparseUnivariatePolynomial| F)))))
          (|rde1|
           (|Mapping|
            (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))) F
            (|List| F)))
          (|logi|
           (|Mapping|
            (|Record| (|:| |logands| (|List| F))
                      (|:| |basis|
                           (|List| (|Vector| (|Fraction| (|Integer|))))))
            (|List| (|Kernel| F)) (|List| F)))
          (|ext2|
           (|Mapping|
            (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
            (|List| (|Kernel| F)) (|List| F)))
          (|ext1|
           (|Mapping|
            (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
            (|List| F)))
          (|der1|
           (|Mapping| (|SparseUnivariatePolynomial| F)
                      (|SparseUnivariatePolynomial| F)))
          (|dk| (|SparseUnivariatePolynomial| F))
          (|cs1| (|Mapping| (|List| (|Vector| F)) (|Matrix| F)))
          (|d1| (|Mapping| F F)) (#29=#:G1104 NIL) (#30=#:G1103 NIL)
          (|k1| (|Kernel| F)))
         (SEQ (LETT |k1| (SPADCALL |l| (QREFELT $ 71)))
              (LETT |l|
                    (PROGN
                     (LETT #30# NIL)
                     (SEQ (LETT |k2| NIL) (LETT #29# |l|) G190
                          (COND
                           ((OR (ATOM #29#) (PROGN (LETT |k2| (CAR #29#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((SPADCALL |k2| |k1| (QREFELT $ 72))
                              (LETT #30# (CONS |k2| #30#))))))
                          (LETT #29# (CDR #29#)) (GO G190) G191
                          (EXIT (NREVERSE #30#)))))
              (COND
               ((OR (QEQCAR (SPADCALL |k1| (QREFELT $ 74)) 0)
                    (OR (|INTPAR2;prim?| |k1| |x| $)
                        (SPADCALL |k1| '|exp| (QREFELT $ 13))))
                (EXIT
                 (SEQ (LETT |d1| (CONS #'|INTPAR2;algextint!0| (VECTOR $ |x|)))
                      (LETT |cs1|
                            (CONS #'|INTPAR2;algextint!1| (VECTOR $ |d1|)))
                      (LETT |dk|
                            (COND
                             ((SPADCALL |k1| '|exp| (QREFELT $ 13))
                              (SPADCALL
                               (SPADCALL
                                (|SPADfirst| (SPADCALL |k1| (QREFELT $ 61)))
                                |x| (QREFELT $ 35))
                               1 (QREFELT $ 59)))
                             (#31='T
                              (SPADCALL
                               (SPADCALL (SPADCALL |k1| (QREFELT $ 37)) |x|
                                         (QREFELT $ 35))
                               (QREFELT $ 39)))))
                      (LETT |der1|
                            (CONS #'|INTPAR2;algextint!2|
                                  (VECTOR $ |dk| |d1|)))
                      (EXIT
                       (COND
                        ((QEQCAR (SPADCALL |k1| (QREFELT $ 74)) 0)
                         (SPADCALL |k1| |k| |der1| |cs1| |lg| (QREFELT $ 126)))
                        (#31#
                         (SEQ
                          (LETT |ext1|
                                (CONS #'|INTPAR2;algextint!3|
                                      (VECTOR $ |l| |k1| |x|)))
                          (LETT |ext2|
                                (CONS #'|INTPAR2;algextint!4| (VECTOR $ |x|)))
                          (LETT |logi|
                                (CONS #'|INTPAR2;algextint!5| (VECTOR $ |x|)))
                          (LETT |rde1|
                                (CONS #'|INTPAR2;algextint!6|
                                      (VECTOR |logi| |ext2| $ |l| |k1| |x|)))
                          (LETT |rde2|
                                (CONS #'|INTPAR2;algextint!8|
                                      (VECTOR |k1| $ |rde1|)))
                          (EXIT
                           (SPADCALL |k1| |k| |der1|
                                     (|INTPAR2;wrapfn| |ext1| |k1| $) |rde2|
                                     |cs1| |lg| (QREFELT $ 135)))))))))))
              (EXIT
               (COND
                ((SPADCALL (SPADCALL |k1| (QREFELT $ 15)) (QREFELT $ 9)
                           (QREFELT $ 16))
                 (SEQ
                  (COND
                   ((SPADCALL (SPADCALL |k| (QREFELT $ 15)) '|nthRoot|
                              (QREFELT $ 136))
                    (COND
                     ((SPADCALL (SPADCALL |k1| (QREFELT $ 15)) '|nthRoot|
                                (QREFELT $ 136))
                      (COND
                       ((NULL
                         (SPADCALL |k1|
                                   (SPADCALL (SPADCALL |k| (QREFELT $ 37))
                                             (QREFELT $ 137))
                                   (QREFELT $ 65)))
                        (EXIT
                         (SEQ
                          (LETT |l|
                                (PROGN
                                 (LETT #28# NIL)
                                 (SEQ (LETT |k2| NIL) (LETT #27# |l|) G190
                                      (COND
                                       ((OR (ATOM #27#)
                                            (PROGN (LETT |k2| (CAR #27#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (COND
                                         ((SPADCALL |k2| |k1| (QREFELT $ 72))
                                          (LETT #28# (CONS |k2| #28#))))))
                                      (LETT #27# (CDR #27#)) (GO G190) G191
                                      (EXIT (NREVERSE #28#)))))
                          (LETT |al| (SPADCALL |lg| |k| |k1| (QREFELT $ 141)))
                          (LETT |n| (LENGTH |lg|))
                          (LETT |ca|
                                (PROGN
                                 (LETT #26# NIL)
                                 (SEQ (LETT |i| 1) (LETT #25# |n|) G190
                                      (COND
                                       ((|greater_SI| |i| #25#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #26#
                                              (CONS (|spadConstant| $ 18)
                                                    #26#))))
                                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                      (EXIT (NREVERSE #26#)))))
                          (LETT |cb|
                                (PROGN
                                 (LETT #24# NIL)
                                 (SEQ (LETT |i| 1) (LETT #23# |n|) G190
                                      (COND
                                       ((|greater_SI| |i| #23#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #24#
                                              (CONS
                                               (MAKEARR1 |n|
                                                         (|spadConstant| $ 18))
                                               #24#))))
                                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                      (EXIT (NREVERSE #24#)))))
                          (SEQ (LETT |bv| NIL) (LETT #22# |cb|) (LETT |i| 1)
                               (LETT #21# |n|) G190
                               (COND
                                ((OR (|greater_SI| |i| #21#) (ATOM #22#)
                                     (PROGN (LETT |bv| (CAR #22#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (SPADCALL |bv| |i| (|spadConstant| $ 57)
                                           (QREFELT $ 142))))
                               (LETT |i|
                                     (PROG1 (|inc_SI| |i|)
                                       (LETT #22# (CDR #22#))))
                               (GO G190) G191 (EXIT NIL))
                          (SEQ (LETT #20# |al|) G190
                               (COND
                                ((OR (ATOM #20#)
                                     (PROGN (LETT |rec| (CAR #20#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (LETT |lg1|
                                      (PROGN
                                       (LETT #19# NIL)
                                       (SEQ (LETT |bv| NIL) (LETT #18# |cb|)
                                            G190
                                            (COND
                                             ((OR (ATOM #18#)
                                                  (PROGN
                                                   (LETT |bv| (CAR #18#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #19#
                                                    (CONS
                                                     (SPADCALL |bv|
                                                               (QVELT |rec| 0)
                                                               (QREFELT $ 143))
                                                     #19#))))
                                            (LETT #18# (CDR #18#)) (GO G190)
                                            G191 (EXIT (NREVERSE #19#)))))
                                (COND
                                 ((> (+ (QVELT |rec| 2) (QVELT |rec| 3)) 0)
                                  (SEQ
                                   (LETT |nrr|
                                         (SPADCALL (QVELT |rec| 1)
                                                   (QREFELT $ 144)))
                                   (LETT |res1|
                                         (SPADCALL |x| (CONS |nrr| |l|) |lg1|
                                                   (QREFELT $ 87)))
                                   (LETT |oroot|
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL |k| (QREFELT $ 37))
                                           (QVELT |rec| 2) (QREFELT $ 112))
                                          (SPADCALL
                                           (SPADCALL |k1| (QREFELT $ 37))
                                           (QVELT |rec| 3) (QREFELT $ 112))
                                          (QREFELT $ 102)))
                                   (EXIT
                                    (LETT |na1|
                                          (PROGN
                                           (LETT #17# NIL)
                                           (SEQ (LETT |be| NIL)
                                                (LETT #16# |res1|) G190
                                                (COND
                                                 ((OR (ATOM #16#)
                                                      (PROGN
                                                       (LETT |be| (CAR #16#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT #17#
                                                        (CONS
                                                         (SPADCALL (QCAR |be|)
                                                                   |nrr|
                                                                   |oroot|
                                                                   (QREFELT $
                                                                            145))
                                                         #17#))))
                                                (LETT #16# (CDR #16#))
                                                (GO G190) G191
                                                (EXIT (NREVERSE #17#))))))))
                                 ('T
                                  (SEQ
                                   (LETT |res1|
                                         (SPADCALL |x| |l| |lg1|
                                                   (QREFELT $ 87)))
                                   (EXIT
                                    (LETT |na1|
                                          (PROGN
                                           (LETT #15# NIL)
                                           (SEQ (LETT |be| NIL)
                                                (LETT #14# |res1|) G190
                                                (COND
                                                 ((OR (ATOM #14#)
                                                      (PROGN
                                                       (LETT |be| (CAR #14#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT #15#
                                                        (CONS (QCAR |be|)
                                                              #15#))))
                                                (LETT #14# (CDR #14#))
                                                (GO G190) G191
                                                (EXIT (NREVERSE #15#)))))))))
                                (LETT |nca|
                                      (PROGN
                                       (LETT #13# NIL)
                                       (SEQ (LETT |a1| NIL) (LETT #12# |na1|)
                                            (LETT |be| NIL) (LETT #11# |res1|)
                                            G190
                                            (COND
                                             ((OR (ATOM #11#)
                                                  (PROGN
                                                   (LETT |be| (CAR #11#))
                                                   NIL)
                                                  (ATOM #12#)
                                                  (PROGN
                                                   (LETT |a1| (CAR #12#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #13#
                                                    (CONS
                                                     (SPADCALL
                                                      (SPADCALL (QCDR |be|)
                                                                |ca|
                                                                (QREFELT $
                                                                         143))
                                                      |a1| (QREFELT $ 117))
                                                     #13#))))
                                            (LETT #11#
                                                  (PROG1 (CDR #11#)
                                                    (LETT #12# (CDR #12#))))
                                            (GO G190) G191
                                            (EXIT (NREVERSE #13#)))))
                                (LETT |ca| |nca|)
                                (LETT |ncb|
                                      (PROGN
                                       (LETT #10# NIL)
                                       (SEQ (LETT |be| NIL) (LETT #9# |res1|)
                                            G190
                                            (COND
                                             ((OR (ATOM #9#)
                                                  (PROGN
                                                   (LETT |be| (CAR #9#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #10#
                                                    (CONS
                                                     (SPADCALL (QCDR |be|) |cb|
                                                               (QREFELT $ 146))
                                                     #10#))))
                                            (LETT #9# (CDR #9#)) (GO G190) G191
                                            (EXIT (NREVERSE #10#)))))
                                (EXIT (LETT |cb| |ncb|)))
                               (LETT #20# (CDR #20#)) (GO G190) G191
                               (EXIT NIL))
                          (EXIT
                           (PROGN
                            (LETT #8# NIL)
                            (SEQ (LETT |bv| NIL) (LETT #7# |cb|)
                                 (LETT |a1| NIL) (LETT #6# |ca|) G190
                                 (COND
                                  ((OR (ATOM #6#)
                                       (PROGN (LETT |a1| (CAR #6#)) NIL)
                                       (ATOM #7#)
                                       (PROGN (LETT |bv| (CAR #7#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #8# (CONS (CONS |a1| |bv|) #8#))))
                                 (LETT #6#
                                       (PROG1 (CDR #6#) (LETT #7# (CDR #7#))))
                                 (GO G190) G191
                                 (EXIT (NREVERSE #8#)))))))))))))
                  (LETT |rec|
                        (SPADCALL (SPADCALL |k1| (QREFELT $ 37))
                                  (SPADCALL |k| (QREFELT $ 37))
                                  (QREFELT $ 149)))
                  (LETT |y| (SPADCALL (QVELT |rec| 3) (QREFELT $ 151)))
                  (LETT |yk| (SPADCALL |y| (QREFELT $ 144)))
                  (LETT |nk1| (SPADCALL (QVELT |rec| 1) |y| (QREFELT $ 152)))
                  (LETT |nk| (SPADCALL (QVELT |rec| 2) |y| (QREFELT $ 152)))
                  (LETT |lg1|
                        (PROGN
                         (LETT #4# NIL)
                         (SEQ (LETT |g| NIL) (LETT #3# |lg|) G190
                              (COND
                               ((OR (ATOM #3#)
                                    (PROGN (LETT |g| (CAR #3#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #4#
                                      (CONS
                                       (SPADCALL |g| (LIST |k1| |k|)
                                                 (LIST |nk1| |nk|)
                                                 (QREFELT $ 153))
                                       #4#))))
                              (LETT #3# (CDR #3#)) (GO G190) G191
                              (EXIT (NREVERSE #4#)))))
                  (LETT |res1| (|INTPAR2;algextint| |x| |yk| |l| |lg1| $))
                  (EXIT
                   (PROGN
                    (LETT #2# NIL)
                    (SEQ (LETT |be| NIL) (LETT #1# |res1|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |be| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT #2#
                                 (CONS
                                  (CONS
                                   (SPADCALL (QCAR |be|) |yk| (QVELT |rec| 0)
                                             (QREFELT $ 145))
                                   (QCDR |be|))
                                  #2#))))
                         (LETT #1# (CDR #1#)) (GO G190) G191
                         (EXIT (NREVERSE #2#)))))))
                (#31# (|error| "algextint unimplemented kernel"))))))) 

(SDEFUN |INTPAR2;algextint!8| ((|x5| NIL) (|x4| NIL) ($$ NIL))
        (PROG (|rde1| $ |k1|)
          (LETT |rde1| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |k1| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL |x4|
                             (|INTPAR2;wrapfn|
                              (CONS #'|INTPAR2;algextint!7|
                                    (VECTOR |rde1| $ |k1| |x5|))
                              |k1| $))))))) 

(SDEFUN |INTPAR2;algextint!7| ((|x3| NIL) ($$ NIL))
        (PROG (|x5| |k1| $ |rde1|)
          (LETT |x5| (QREFELT $$ 3))
          (LETT |k1| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |rde1| (QREFELT $$ 0))
          (RETURN
           (PROGN (SPADCALL (SPADCALL |x5| |k1| (QREFELT $ 54)) |x3| |rde1|))))) 

(SDEFUN |INTPAR2;algextint!6| ((|x6| NIL) (|x3| NIL) ($$ NIL))
        (PROG (|x| |k1| |l| $ |ext2| |logi|)
          (LETT |x| (QREFELT $$ 5))
          (LETT |k1| (QREFELT $$ 4))
          (LETT |l| (QREFELT $$ 3))
          (LETT $ (QREFELT $$ 2))
          (LETT |ext2| (QREFELT $$ 1))
          (LETT |logi| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |x6| |x3| |x| (SPADCALL |k1| |l| (QREFELT $ 127)) |ext2|
                      |logi| (QREFELT $ 131)))))) 

(SDEFUN |INTPAR2;algextint!5| ((|x2| NIL) (|x3| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |x2| |x3| (QREFELT $ 28)))))) 

(SDEFUN |INTPAR2;algextint!4| ((|x4| NIL) (|x3| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |x4| |x3| (QREFELT $ 87)))))) 

(SDEFUN |INTPAR2;algextint!3| ((|x3| NIL) ($$ NIL))
        (PROG (|x| |k1| |l| $)
          (LETT |x| (QREFELT $$ 3))
          (LETT |k1| (QREFELT $$ 2))
          (LETT |l| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |x| (SPADCALL |k1| |l| (QREFELT $ 127)) |x3|
                      (QREFELT $ 87)))))) 

(SDEFUN |INTPAR2;algextint!2| ((|x1| NIL) ($$ NIL))
        (PROG (|d1| |dk| $)
          (LETT |d1| (QREFELT $$ 2))
          (LETT |dk| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |d1| |dk| (QREFELT $ 41)))))) 

(SDEFUN |INTPAR2;algextint!1| ((|x2| NIL) ($$ NIL))
        (PROG (|d1| $)
          (LETT |d1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|INTPAR2;csolve1| |x2| |d1| $))))) 

(SDEFUN |INTPAR2;algextint!0| ((|x1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |x| (QREFELT $ 35)))))) 

(SDEFUN |INTPAR2;primextint|
        ((|x| (|Symbol|)) (|k| (|Kernel| F)) (|l| (|List| (|Kernel| F)))
         (|lu| (|List| F))
         ($ (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G1153 NIL) (|si| NIL) (#2=#:G1152 NIL)
          (|res1|
           (|List|
            (|Record|
             (|:| |ratpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
             (|:| |coeffs| (|Vector| F)))))
          (#3=#:G1151 NIL) (|u| NIL) (#4=#:G1150 NIL)
          (|cs1| (|Mapping| (|List| (|Vector| F)) (|Matrix| F)))
          (|ext|
           (|Mapping|
            (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
            (|List| F)))
          (|der|
           (|Mapping| (|SparseUnivariatePolynomial| F)
                      (|SparseUnivariatePolynomial| F)))
          (|d1| (|Mapping| F F)))
         (SEQ (LETT |d1| (CONS #'|INTPAR2;primextint!0| (VECTOR $ |x|)))
              (LETT |der|
                    (CONS #'|INTPAR2;primextint!1| (VECTOR |x| $ |k| |d1|)))
              (LETT |ext| (CONS #'|INTPAR2;primextint!2| (VECTOR $ |l| |x|)))
              (LETT |cs1| (CONS #'|INTPAR2;primextint!3| (VECTOR $ |d1|)))
              (LETT |res1|
                    (SPADCALL |der| |ext| |cs1|
                              (PROGN
                               (LETT #4# NIL)
                               (SEQ (LETT |u| NIL) (LETT #3# |lu|) G190
                                    (COND
                                     ((OR (ATOM #3#)
                                          (PROGN (LETT |u| (CAR #3#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #4#
                                            (CONS
                                             (SPADCALL |u| |k| (QREFELT $ 46))
                                             #4#))))
                                    (LETT #3# (CDR #3#)) (GO G190) G191
                                    (EXIT (NREVERSE #4#))))
                              (QREFELT $ 156)))
              (EXIT
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |si| NIL) (LETT #1# |res1|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |si| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #2#
                             (CONS
                              (CONS (SPADCALL (QCAR |si|) |k| (QREFELT $ 54))
                                    (QCDR |si|))
                              #2#))))
                     (LETT #1# (CDR #1#)) (GO G190) G191
                     (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |INTPAR2;primextint!3| ((|x4| NIL) ($$ NIL))
        (PROG (|d1| $)
          (LETT |d1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|INTPAR2;csolve1| |x4| |d1| $))))) 

(SDEFUN |INTPAR2;primextint!2| ((|x3| NIL) ($$ NIL))
        (PROG (|x| |l| $)
          (LETT |x| (QREFELT $$ 2))
          (LETT |l| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |l| |x3| (QREFELT $ 87)))))) 

(SDEFUN |INTPAR2;primextint!1| ((|x1| NIL) ($$ NIL))
        (PROG (|d1| |k| $ |x|)
          (LETT |d1| (QREFELT $$ 3))
          (LETT |k| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |x| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |x1| |d1|
                      (SPADCALL
                       (SPADCALL (SPADCALL |k| (QREFELT $ 37)) |x|
                                 (QREFELT $ 35))
                       (QREFELT $ 39))
                      (QREFELT $ 41)))))) 

(SDEFUN |INTPAR2;primextint!0| ((|x1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |x| (QREFELT $ 35)))))) 

(SDEFUN |INTPAR2;expextint|
        ((|x| (|Symbol|)) (|k| (|Kernel| F)) (|l| (|List| (|Kernel| F)))
         (|lu| (|List| F))
         ($ (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G1182 NIL) (|si| NIL) (#2=#:G1181 NIL)
          (|res1|
           (|List|
            (|Record|
             (|:| |ratpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
             (|:| |coeffs| (|Vector| F)))))
          (#3=#:G1180 NIL) (|u| NIL) (#4=#:G1179 NIL)
          (|cs1| (|Mapping| (|List| (|Vector| F)) (|Matrix| F)))
          (|rde|
           (|Mapping|
            (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
            (|Integer|) (|List| F)))
          (|logi|
           (|Mapping|
            (|Record| (|:| |logands| (|List| F))
                      (|:| |basis|
                           (|List| (|Vector| (|Fraction| (|Integer|))))))
            (|List| (|Kernel| F)) (|List| F)))
          (|ext|
           (|Mapping|
            (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
            (|List| (|Kernel| F)) (|List| F)))
          (|der|
           (|Mapping| (|SparseUnivariatePolynomial| F)
                      (|SparseUnivariatePolynomial| F)))
          (|d1| (|Mapping| F F)) (|eta| (F)))
         (SEQ (LETT |eta| (|SPADfirst| (SPADCALL |k| (QREFELT $ 61))))
              (LETT |d1| (CONS #'|INTPAR2;expextint!0| (VECTOR $ |x|)))
              (LETT |der|
                    (CONS #'|INTPAR2;expextint!1| (VECTOR $ |x| |eta| |d1|)))
              (LETT |ext| (CONS #'|INTPAR2;expextint!2| (VECTOR $ |x|)))
              (LETT |logi| (CONS #'|INTPAR2;expextint!3| (VECTOR $ |x|)))
              (LETT |rde|
                    (CONS #'|INTPAR2;expextint!4|
                          (VECTOR $ |logi| |ext| |l| |x| |eta|)))
              (LETT |cs1| (CONS #'|INTPAR2;expextint!5| (VECTOR $ |d1|)))
              (LETT |res1|
                    (SPADCALL |der| |rde| |cs1|
                              (PROGN
                               (LETT #4# NIL)
                               (SEQ (LETT |u| NIL) (LETT #3# |lu|) G190
                                    (COND
                                     ((OR (ATOM #3#)
                                          (PROGN (LETT |u| (CAR #3#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #4#
                                            (CONS
                                             (SPADCALL |u| |k| (QREFELT $ 46))
                                             #4#))))
                                    (LETT #3# (CDR #3#)) (GO G190) G191
                                    (EXIT (NREVERSE #4#))))
                              (QREFELT $ 159)))
              (EXIT
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |si| NIL) (LETT #1# |res1|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |si| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #2#
                             (CONS
                              (CONS (SPADCALL (QCAR |si|) |k| (QREFELT $ 54))
                                    (QCDR |si|))
                              #2#))))
                     (LETT #1# (CDR #1#)) (GO G190) G191
                     (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |INTPAR2;expextint!5| ((|x4| NIL) ($$ NIL))
        (PROG (|d1| $)
          (LETT |d1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|INTPAR2;csolve1| |x4| |d1| $))))) 

(SDEFUN |INTPAR2;expextint!4| ((|x1| NIL) (|x3| NIL) ($$ NIL))
        (PROG (|eta| |x| |l| |ext| |logi| $)
          (LETT |eta| (QREFELT $$ 5))
          (LETT |x| (QREFELT $$ 4))
          (LETT |l| (QREFELT $$ 3))
          (LETT |ext| (QREFELT $$ 2))
          (LETT |logi| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |x1| |eta| |x3| |x| |l| |ext| |logi| (QREFELT $ 157)))))) 

(SDEFUN |INTPAR2;expextint!3| ((|x2| NIL) (|x3| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |x2| |x3| (QREFELT $ 28)))))) 

(SDEFUN |INTPAR2;expextint!2| ((|x2| NIL) (|x3| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |x2| |x3| (QREFELT $ 87)))))) 

(SDEFUN |INTPAR2;expextint!1| ((|x1| NIL) ($$ NIL))
        (PROG (|d1| |eta| |x| $)
          (LETT |d1| (QREFELT $$ 3))
          (LETT |eta| (QREFELT $$ 2))
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |x1| |d1|
                      (SPADCALL (SPADCALL |eta| |x| (QREFELT $ 35))
                                (|spadConstant| $ 62) (QREFELT $ 59))
                      (QREFELT $ 41)))))) 

(SDEFUN |INTPAR2;expextint!0| ((|x1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |x| (QREFELT $ 35)))))) 

(SDEFUN |INTPAR2;diffextint1|
        ((|lup| (|List| (|SparseUnivariatePolynomial| F))) (|x| (|Symbol|))
         (|k| (|Kernel| F)) (|lk| (|List| (|Kernel| F)))
         (|csolve| (|Mapping| (|List| (|Vector| F)) (|Matrix| F)))
         ($ (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G1268 NIL) (|ba| NIL) (#2=#:G1269 NIL) (|bv| NIL)
          (#3=#:G1267 NIL) (|nlca| (|List| F)) (#4=#:G1265 NIL)
          (#5=#:G1266 NIL) (|be| NIL) (#6=#:G1264 NIL)
          (|ncb| (|List| (|Vector| F))) (#7=#:G1263 NIL) (#8=#:G1262 NIL)
          (#9=#:G1261 NIL) (#10=#:G1260 NIL) (|cb1| (|List| #11=(|Vector| F)))
          (#12=#:G1259 NIL) (#13=#:G1258 NIL)
          (|res2|
           #14=(|List|
                (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))))
          (|nlg| (|List| F)) (|ng| (F)) (#15=#:G1236 NIL)
          (|nu| (|SparseUnivariatePolynomial| F))
          (|du| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (#16=#:G1255 NIL) (|ca| NIL) (#17=#:G1256 NIL) (|g1| NIL)
          (#18=#:G1257 NIL) (|g0| NIL) (|lca| (|List| F)) (|nlg0| (|List| F))
          (#19=#:G1254 NIL) (#20=#:G1253 NIL) (|lg3| (|List| F))
          (#21=#:G1252 NIL) (#22=#:G1251 NIL) (|v3| (|Vector| F))
          (|v2| (|Vector| F)) (#23=#:G1250 NIL) (#24=#:G1249 NIL)
          (|cb| #25=(|List| (|Vector| F))) (|m2| #26=(|Matrix| F))
          (|#G130| (|Record| (|:| |transform| #26#) (|:| |basis| #25#)))
          (|d1| (|Mapping| F F)) (|cb0| (|List| #11#)) (#27=#:G1248 NIL)
          (#28=#:G1247 NIL) (|res1| #14#) (|lk1| (|List| (|Kernel| F)))
          (|lek| (|List| F)) (#29=#:G1246 NIL) (|ki| NIL) (#30=#:G1245 NIL)
          (|lg2| (|List| F)) (#31=#:G1244 NIL) (|g| NIL) (#32=#:G1243 NIL)
          (|dvf| (F)) (|dv| (|Symbol|)) (|k1| (F)) (|lg1| (|List| F))
          (#33=#:G1242 NIL) (|up| NIL) (#34=#:G1241 NIL) (|lg0| (|List| F))
          (#35=#:G1240 NIL) (#36=#:G1239 NIL) (#37=#:G1238 NIL)
          (#38=#:G1237 NIL) (|b0| (|List| (|Vector| F))) (|da3| (F))
          (|arg3| (F)) (|args| (|List| F)))
         (SEQ
          (EXIT
           (SEQ (LETT |args| (SPADCALL |k| (QREFELT $ 61)))
                (EXIT
                 (COND
                  ((SPADCALL (LENGTH |args|) 3 (QREFELT $ 160))
                   (|error| "internal error, k is not a diff"))
                  (#39='T
                   (SEQ (LETT |arg3| (SPADCALL |args| 3 (QREFELT $ 161)))
                        (LETT |da3| (SPADCALL |arg3| |x| (QREFELT $ 35)))
                        (EXIT
                         (COND
                          ((SPADCALL |da3| (|spadConstant| $ 18)
                                     (QREFELT $ 116))
                           (SEQ
                            (LETT |b0|
                                  (SPADCALL |csolve| |lup| (QREFELT $ 163)))
                            (EXIT
                             (PROGN
                              (LETT #38# NIL)
                              (SEQ (LETT |bv| NIL) (LETT #37# |b0|) G190
                                   (COND
                                    ((OR (ATOM #37#)
                                         (PROGN (LETT |bv| (CAR #37#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #38#
                                           (CONS
                                            (CONS (|spadConstant| $ 18) |bv|)
                                            #38#))))
                                   (LETT #37# (CDR #37#)) (GO G190) G191
                                   (EXIT (NREVERSE #38#)))))))
                          (#39#
                           (SEQ
                            (LETT |lg0|
                                  (PROGN
                                   (LETT #36# NIL)
                                   (SEQ (LETT |up| NIL) (LETT #35# |lup|) G190
                                        (COND
                                         ((OR (ATOM #35#)
                                              (PROGN
                                               (LETT |up| (CAR #35#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #36#
                                                (CONS
                                                 (SPADCALL |up| 0
                                                           (QREFELT $ 164))
                                                 #36#))))
                                        (LETT #35# (CDR #35#)) (GO G190) G191
                                        (EXIT (NREVERSE #36#)))))
                            (LETT |lg1|
                                  (PROGN
                                   (LETT #34# NIL)
                                   (SEQ (LETT |up| NIL) (LETT #33# |lup|) G190
                                        (COND
                                         ((OR (ATOM #33#)
                                              (PROGN
                                               (LETT |up| (CAR #33#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #34#
                                                (CONS
                                                 (SPADCALL |up| 1
                                                           (QREFELT $ 164))
                                                 #34#))))
                                        (LETT #33# (CDR #33#)) (GO G190) G191
                                        (EXIT (NREVERSE #34#)))))
                            (LETT |k1|
                                  (SPADCALL (SPADCALL |args| 1 (QREFELT $ 161))
                                            (SPADCALL
                                             (SPADCALL |args| 2
                                                       (QREFELT $ 161))
                                             (QREFELT $ 144))
                                            |arg3| (QREFELT $ 145)))
                            (LETT |dv| (SPADCALL (QREFELT $ 165)))
                            (LETT |dvf| (SPADCALL |dv| (QREFELT $ 75)))
                            (LETT |lg2|
                                  (PROGN
                                   (LETT #32# NIL)
                                   (SEQ (LETT |g| NIL) (LETT #31# |lg1|) G190
                                        (COND
                                         ((OR (ATOM #31#)
                                              (PROGN
                                               (LETT |g| (CAR #31#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #32#
                                                (CONS
                                                 (SPADCALL
                                                  (SPADCALL |g| |da3|
                                                            (QREFELT $ 103))
                                                  |k1| |dvf| (QREFELT $ 166))
                                                 #32#))))
                                        (LETT #31# (CDR #31#)) (GO G190) G191
                                        (EXIT (NREVERSE #32#)))))
                            (LETT |lek|
                                  (PROGN
                                   (LETT #30# NIL)
                                   (SEQ (LETT |ki| NIL) (LETT #29# |lk|) G190
                                        (COND
                                         ((OR (ATOM #29#)
                                              (PROGN
                                               (LETT |ki| (CAR #29#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #30#
                                                (CONS
                                                 (SPADCALL
                                                  (SPADCALL |ki|
                                                            (QREFELT $ 37))
                                                  |k1| |dvf| (QREFELT $ 166))
                                                 #30#))))
                                        (LETT #29# (CDR #29#)) (GO G190) G191
                                        (EXIT (NREVERSE #30#)))))
                            (LETT |lk1|
                                  (SPADCALL
                                   (SPADCALL
                                    (CONS |dvf|
                                          (SPADCALL |lg2| |lek|
                                                    (QREFELT $ 167)))
                                    (QREFELT $ 77))
                                   |dv| (QREFELT $ 78)))
                            (LETT |res1|
                                  (SPADCALL |dv| |lk1| |lg2| (QREFELT $ 87)))
                            (EXIT
                             (COND ((NULL |res1|) NIL)
                                   (#39#
                                    (SEQ
                                     (LETT |cb0|
                                           (PROGN
                                            (LETT #28# NIL)
                                            (SEQ (LETT |be| NIL)
                                                 (LETT #27# |res1|) G190
                                                 (COND
                                                  ((OR (ATOM #27#)
                                                       (PROGN
                                                        (LETT |be| (CAR #27#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT #28#
                                                         (CONS (QCDR |be|)
                                                               #28#))))
                                                 (LETT #27# (CDR #27#))
                                                 (GO G190) G191
                                                 (EXIT (NREVERSE #28#)))))
                                     (LETT |d1|
                                           (CONS #'|INTPAR2;diffextint1!0|
                                                 (VECTOR $ |x|)))
                                     (PROGN
                                      (LETT |#G130|
                                            (SPADCALL |cb0| (LIST |d1|)
                                                      (QREFELT $ 169)))
                                      (LETT |m2| (QCAR |#G130|))
                                      (LETT |cb| (QCDR |#G130|))
                                      |#G130|)
                                     (EXIT
                                      (COND ((NULL |cb|) NIL)
                                            (#39#
                                             (SEQ
                                              (LETT |v2|
                                                    (SPADCALL
                                                     (PROGN
                                                      (LETT #24# NIL)
                                                      (SEQ (LETT |be| NIL)
                                                           (LETT #23# |res1|)
                                                           G190
                                                           (COND
                                                            ((OR (ATOM #23#)
                                                                 (PROGN
                                                                  (LETT |be|
                                                                        (CAR
                                                                         #23#))
                                                                  NIL))
                                                             (GO G191)))
                                                           (SEQ
                                                            (EXIT
                                                             (LETT #24#
                                                                   (CONS
                                                                    (QCAR |be|)
                                                                    #24#))))
                                                           (LETT #23#
                                                                 (CDR #23#))
                                                           (GO G190) G191
                                                           (EXIT
                                                            (NREVERSE #24#))))
                                                     (QREFELT $ 170)))
                                              (LETT |v3|
                                                    (SPADCALL |m2| |v2|
                                                              (QREFELT $ 171)))
                                              (LETT |lca|
                                                    (SPADCALL |v3|
                                                              (QREFELT $ 172)))
                                              (LETT |lg3|
                                                    (PROGN
                                                     (LETT #22# NIL)
                                                     (SEQ (LETT |bv| NIL)
                                                          (LETT #21# |cb|) G190
                                                          (COND
                                                           ((OR (ATOM #21#)
                                                                (PROGN
                                                                 (LETT |bv|
                                                                       (CAR
                                                                        #21#))
                                                                 NIL))
                                                            (GO G191)))
                                                          (SEQ
                                                           (EXIT
                                                            (LETT #22#
                                                                  (CONS
                                                                   (SPADCALL
                                                                    |bv| |lg1|
                                                                    (QREFELT $
                                                                             143))
                                                                   #22#))))
                                                          (LETT #21#
                                                                (CDR #21#))
                                                          (GO G190) G191
                                                          (EXIT
                                                           (NREVERSE #22#)))))
                                              (LETT |nlg0|
                                                    (PROGN
                                                     (LETT #20# NIL)
                                                     (SEQ (LETT |bv| NIL)
                                                          (LETT #19# |cb|) G190
                                                          (COND
                                                           ((OR (ATOM #19#)
                                                                (PROGN
                                                                 (LETT |bv|
                                                                       (CAR
                                                                        #19#))
                                                                 NIL))
                                                            (GO G191)))
                                                          (SEQ
                                                           (EXIT
                                                            (LETT #20#
                                                                  (CONS
                                                                   (SPADCALL
                                                                    |bv| |lg0|
                                                                    (QREFELT $
                                                                             143))
                                                                   #20#))))
                                                          (LETT #19#
                                                                (CDR #19#))
                                                          (GO G190) G191
                                                          (EXIT
                                                           (NREVERSE #20#)))))
                                              (LETT |lca|
                                                    (SPADCALL
                                                     (CONS
                                                      #'|INTPAR2;diffextint1!1|
                                                      (VECTOR |k1| $ |dv|))
                                                     |lca| (QREFELT $ 174)))
                                              (LETT |nlg| NIL)
                                              (SEQ (LETT |g0| NIL)
                                                   (LETT #18# |nlg0|)
                                                   (LETT |g1| NIL)
                                                   (LETT #17# |lg3|)
                                                   (LETT |ca| NIL)
                                                   (LETT #16# |lca|) G190
                                                   (COND
                                                    ((OR (ATOM #16#)
                                                         (PROGN
                                                          (LETT |ca|
                                                                (CAR #16#))
                                                          NIL)
                                                         (ATOM #17#)
                                                         (PROGN
                                                          (LETT |g1|
                                                                (CAR #17#))
                                                          NIL)
                                                         (ATOM #18#)
                                                         (PROGN
                                                          (LETT |g0|
                                                                (CAR #18#))
                                                          NIL))
                                                     (GO G191)))
                                                   (SEQ
                                                    (LETT |du|
                                                          (SPADCALL
                                                           (SPADCALL |ca| |x|
                                                                     (QREFELT $
                                                                              35))
                                                           |k| (QREFELT $ 46)))
                                                    (LETT |nu|
                                                          (SPADCALL |du|
                                                                    (QREFELT $
                                                                             175)))
                                                    (COND
                                                     ((OR
                                                       (SPADCALL
                                                        (SPADCALL |du|
                                                                  (QREFELT $
                                                                           176))
                                                        (|spadConstant| $ 177)
                                                        (QREFELT $ 178))
                                                       (>
                                                        (SPADCALL |nu|
                                                                  (QREFELT $
                                                                           179))
                                                        1))
                                                      (EXIT
                                                       (PROGN
                                                        (LETT #15# NIL)
                                                        (GO #40=#:G1235)))))
                                                    (EXIT
                                                     (COND
                                                      ((SPADCALL
                                                        (SPADCALL |g1|
                                                                  (SPADCALL
                                                                   |nu| 1
                                                                   (QREFELT $
                                                                            164))
                                                                  (QREFELT $
                                                                           117))
                                                        (|spadConstant| $ 18)
                                                        (QREFELT $ 180))
                                                       (PROGN
                                                        (LETT #15# NIL)
                                                        (GO #40#)))
                                                      ('T
                                                       (SEQ
                                                        (LETT |ng|
                                                              (SPADCALL |g0|
                                                                        (SPADCALL
                                                                         |nu| 0
                                                                         (QREFELT
                                                                          $
                                                                          164))
                                                                        (QREFELT
                                                                         $
                                                                         117)))
                                                        (EXIT
                                                         (LETT |nlg|
                                                               (CONS |ng|
                                                                     |nlg|))))))))
                                                   (LETT #16#
                                                         (PROG1 (CDR #16#)
                                                           (LETT #17#
                                                                 (PROG1
                                                                     (CDR #17#)
                                                                   (LETT #18#
                                                                         (CDR
                                                                          #18#))))))
                                                   (GO G190) G191 (EXIT NIL))
                                              (LETT |nlg| (NREVERSE |nlg|))
                                              (LETT |res2|
                                                    (SPADCALL |x| |lk| |nlg|
                                                              (QREFELT $ 87)))
                                              (EXIT
                                               (COND ((NULL |res2|) NIL)
                                                     (#39#
                                                      (SEQ
                                                       (LETT |cb1|
                                                             (PROGN
                                                              (LETT #13# NIL)
                                                              (SEQ
                                                               (LETT |be| NIL)
                                                               (LETT #12#
                                                                     |res2|)
                                                               G190
                                                               (COND
                                                                ((OR
                                                                  (ATOM #12#)
                                                                  (PROGN
                                                                   (LETT |be|
                                                                         (CAR
                                                                          #12#))
                                                                   NIL))
                                                                 (GO G191)))
                                                               (SEQ
                                                                (EXIT
                                                                 (LETT #13#
                                                                       (CONS
                                                                        (QCDR
                                                                         |be|)
                                                                        #13#))))
                                                               (LETT #12#
                                                                     (CDR
                                                                      #12#))
                                                               (GO G190) G191
                                                               (EXIT
                                                                (NREVERSE
                                                                 #13#)))))
                                                       (LETT |nlca|
                                                             (PROGN
                                                              (LETT #10# NIL)
                                                              (SEQ
                                                               (LETT |be| NIL)
                                                               (LETT #9#
                                                                     |res2|)
                                                               G190
                                                               (COND
                                                                ((OR (ATOM #9#)
                                                                     (PROGN
                                                                      (LETT
                                                                       |be|
                                                                       (CAR
                                                                        #9#))
                                                                      NIL))
                                                                 (GO G191)))
                                                               (SEQ
                                                                (EXIT
                                                                 (LETT #10#
                                                                       (CONS
                                                                        (QCAR
                                                                         |be|)
                                                                        #10#))))
                                                               (LETT #9#
                                                                     (CDR #9#))
                                                               (GO G190) G191
                                                               (EXIT
                                                                (NREVERSE
                                                                 #10#)))))
                                                       (LETT |ncb|
                                                             (PROGN
                                                              (LETT #8# NIL)
                                                              (SEQ
                                                               (LETT |bv| NIL)
                                                               (LETT #7# |cb1|)
                                                               G190
                                                               (COND
                                                                ((OR (ATOM #7#)
                                                                     (PROGN
                                                                      (LETT
                                                                       |bv|
                                                                       (CAR
                                                                        #7#))
                                                                      NIL))
                                                                 (GO G191)))
                                                               (SEQ
                                                                (EXIT
                                                                 (LETT #8#
                                                                       (CONS
                                                                        (SPADCALL
                                                                         |bv|
                                                                         |cb|
                                                                         (QREFELT
                                                                          $
                                                                          146))
                                                                        #8#))))
                                                               (LETT #7#
                                                                     (CDR #7#))
                                                               (GO G190) G191
                                                               (EXIT
                                                                (NREVERSE
                                                                 #8#)))))
                                                       (LETT |nlca|
                                                             (PROGN
                                                              (LETT #6# NIL)
                                                              (SEQ
                                                               (LETT |be| NIL)
                                                               (LETT #5#
                                                                     |res2|)
                                                               (LETT |bv| NIL)
                                                               (LETT #4# |cb1|)
                                                               G190
                                                               (COND
                                                                ((OR (ATOM #4#)
                                                                     (PROGN
                                                                      (LETT
                                                                       |bv|
                                                                       (CAR
                                                                        #4#))
                                                                      NIL)
                                                                     (ATOM #5#)
                                                                     (PROGN
                                                                      (LETT
                                                                       |be|
                                                                       (CAR
                                                                        #5#))
                                                                      NIL))
                                                                 (GO G191)))
                                                               (SEQ
                                                                (EXIT
                                                                 (LETT #6#
                                                                       (CONS
                                                                        (SPADCALL
                                                                         (QCAR
                                                                          |be|)
                                                                         (SPADCALL
                                                                          |bv|
                                                                          |lca|
                                                                          (QREFELT
                                                                           $
                                                                           143))
                                                                         (QREFELT
                                                                          $
                                                                          117))
                                                                        #6#))))
                                                               (LETT #4#
                                                                     (PROG1
                                                                         (CDR
                                                                          #4#)
                                                                       (LETT
                                                                        #5#
                                                                        (CDR
                                                                         #5#))))
                                                               (GO G190) G191
                                                               (EXIT
                                                                (NREVERSE
                                                                 #6#)))))
                                                       (EXIT
                                                        (PROGN
                                                         (LETT #3# NIL)
                                                         (SEQ (LETT |bv| NIL)
                                                              (LETT #2# |ncb|)
                                                              (LETT |ba| NIL)
                                                              (LETT #1# |nlca|)
                                                              G190
                                                              (COND
                                                               ((OR (ATOM #1#)
                                                                    (PROGN
                                                                     (LETT |ba|
                                                                           (CAR
                                                                            #1#))
                                                                     NIL)
                                                                    (ATOM #2#)
                                                                    (PROGN
                                                                     (LETT |bv|
                                                                           (CAR
                                                                            #2#))
                                                                     NIL))
                                                                (GO G191)))
                                                              (SEQ
                                                               (EXIT
                                                                (LETT #3#
                                                                      (CONS
                                                                       (CONS
                                                                        |ba|
                                                                        |bv|)
                                                                       #3#))))
                                                              (LETT #1#
                                                                    (PROG1
                                                                        (CDR
                                                                         #1#)
                                                                      (LETT #2#
                                                                            (CDR
                                                                             #2#))))
                                                              (GO G190) G191
                                                              (EXIT
                                                               (NREVERSE
                                                                #3#)))))))))))))))))))))))))))
          #40# (EXIT #15#)))) 

(SDEFUN |INTPAR2;diffextint1!1| ((|x1| NIL) ($$ NIL))
        (PROG (|dv| $ |k1|)
          (LETT |dv| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |k1| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |x1| (SPADCALL |dv| (QREFELT $ 173)) |k1|
                      (QREFELT $ 145)))))) 

(SDEFUN |INTPAR2;diffextint1!0| ((|x1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |x| (QREFELT $ 35)))))) 

(SDEFUN |INTPAR2;diffextint|
        ((|x| (|Symbol|)) (|k| (|Kernel| F)) (|l| (|List| (|Kernel| F)))
         (|lg| (|List| F))
         ($ (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G1282 NIL) (|u| NIL) (#2=#:G1281 NIL)
          (|diffi1|
           (|Mapping|
            (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
            (|List| (|SparseUnivariatePolynomial| F))))
          (|cs1| (|Mapping| (|List| (|Vector| F)) (|Matrix| F)))
          (|d1| (|Mapping| F F)))
         (SEQ (LETT |d1| (CONS #'|INTPAR2;diffextint!0| (VECTOR $ |x|)))
              (LETT |cs1| (CONS #'|INTPAR2;diffextint!1| (VECTOR $ |d1|)))
              (LETT |diffi1|
                    (CONS #'|INTPAR2;diffextint!2|
                          (VECTOR $ |cs1| |l| |k| |x|)))
              (EXIT
               (SPADCALL |diffi1| |cs1|
                         (PROGN
                          (LETT #2# NIL)
                          (SEQ (LETT |u| NIL) (LETT #1# |lg|) G190
                               (COND
                                ((OR (ATOM #1#)
                                     (PROGN (LETT |u| (CAR #1#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #2#
                                       (CONS (SPADCALL |u| |k| (QREFELT $ 46))
                                             #2#))))
                               (LETT #1# (CDR #1#)) (GO G190) G191
                               (EXIT (NREVERSE #2#))))
                         (QREFELT $ 182)))))) 

(SDEFUN |INTPAR2;diffextint!2| ((|x1| NIL) ($$ NIL))
        (PROG (|x| |k| |l| |cs1| $)
          (LETT |x| (QREFELT $$ 4))
          (LETT |k| (QREFELT $$ 3))
          (LETT |l| (QREFELT $$ 2))
          (LETT |cs1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|INTPAR2;diffextint1| |x1| |x| |k| |l| |cs1| $))))) 

(SDEFUN |INTPAR2;diffextint!1| ((|x4| NIL) ($$ NIL))
        (PROG (|d1| $)
          (LETT |d1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|INTPAR2;csolve1| |x4| |d1| $))))) 

(SDEFUN |INTPAR2;diffextint!0| ((|x1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |x| (QREFELT $ 35)))))) 

(SDEFUN |INTPAR2;unkextint|
        ((|x| (|Symbol|)) (|k| (|Kernel| F)) (|l| (|List| (|Kernel| F)))
         (|lg| (|List| F))
         ($ (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G1294 NIL) (|u| NIL) (#2=#:G1293 NIL)
          (|ext|
           (|Mapping|
            (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
            (|List| F)))
          (|cs1| (|Mapping| (|List| (|Vector| F)) (|Matrix| F)))
          (|d1| (|Mapping| F F)))
         (SEQ (LETT |d1| (CONS #'|INTPAR2;unkextint!0| (VECTOR $ |x|)))
              (LETT |cs1| (CONS #'|INTPAR2;unkextint!1| (VECTOR $ |d1|)))
              (LETT |ext| (CONS #'|INTPAR2;unkextint!2| (VECTOR $ |l| |x|)))
              (EXIT
               (SPADCALL |ext| |cs1|
                         (PROGN
                          (LETT #2# NIL)
                          (SEQ (LETT |u| NIL) (LETT #1# |lg|) G190
                               (COND
                                ((OR (ATOM #1#)
                                     (PROGN (LETT |u| (CAR #1#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #2#
                                       (CONS (SPADCALL |u| |k| (QREFELT $ 46))
                                             #2#))))
                               (LETT #1# (CDR #1#)) (GO G190) G191
                               (EXIT (NREVERSE #2#))))
                         (QREFELT $ 183)))))) 

(SDEFUN |INTPAR2;unkextint!2| ((|x3| NIL) ($$ NIL))
        (PROG (|x| |l| $)
          (LETT |x| (QREFELT $$ 2))
          (LETT |l| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |l| |x3| (QREFELT $ 87)))))) 

(SDEFUN |INTPAR2;unkextint!1| ((|x4| NIL) ($$ NIL))
        (PROG (|d1| $)
          (LETT |d1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|INTPAR2;csolve1| |x4| |d1| $))))) 

(SDEFUN |INTPAR2;unkextint!0| ((|x1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |x| (QREFELT $ 35)))))) 

(DECLAIM (NOTINLINE |ParametricIntegration;|)) 

(DEFUN |ParametricIntegration| (&REST #1=#:G1295)
  (SPROG NIL
         (PROG (#2=#:G1296)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ParametricIntegration|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ParametricIntegration;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|ParametricIntegration|)))))))))) 

(DEFUN |ParametricIntegration;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|ParametricIntegration| DV$1 DV$2))
          (LETT $ (GETREFV 184))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ParametricIntegration|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 '|prim|)
          (QSETREFV $ 9 '|%alg|)
          (COND
           ((|HasCategory| |#2| '(|SpecialFunctionCategory|))
            (PROGN
             (QSETREFV $ 120
                       (CONS
                        (|dispatchFunction| |INTPAR2;polylog_int;FSKNniLFU;14|)
                        $))))
           ('T
            (QSETREFV $ 120
                      (CONS
                       (|dispatchFunction| |INTPAR2;polylog_int;FSKNniLFU;15|)
                       $))))
          $))) 

(MAKEPROP '|ParametricIntegration| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) 'PRIM
              'ALGOP (|Boolean|) (|Symbol|) (|Kernel| 7) (0 . |is?|)
              (|BasicOperator|) (6 . |operator|) (11 . |has?|) (17 . |Zero|)
              (21 . |Zero|) (|Union| (|Vector| 108) '"failed")
              (|Record| (|:| |particular| 19)
                        (|:| |basis| (|List| (|Vector| 108))))
              (|Matrix| 7) (|Vector| 7) (|IntegerLinearDependence| 7)
              (25 . |solveLinearlyOverQ|)
              (|Record| (|:| |logands| 27)
                        (|:| |basis| (|List| (|Vector| 108))))
              (|List| 12) (|List| 7) |INTPAR2;logextint;SLLR;7|
              (|Record| (|:| |logands| 50)
                        (|:| |basis| (|List| (|Vector| 108))))
              (|List| 38) (|Mapping| (|List| (|Vector| 108)) 21)
              (|Mapping| 25 27) (|ParametricTranscendentalIntegration| 7 38)
              (31 . |monologextint|) (38 . |differentiate|) (|Kernel| $)
              (44 . |coerce|) (|SparseUnivariatePolynomial| 7) (49 . |coerce|)
              (|Mapping| 7 7) (54 . |differentiate|) (|Factored| 38)
              (|ExpressionFactorPolynomial| 6 7) (61 . |factorPolynomial|)
              (|Fraction| 150) (66 . |univariate|) (|Mapping| 38 38)
              (|Mapping| 42 38) (|Mapping| 29 30) (|List| 52)
              (72 . |logextint|) (|Fraction| 38)
              (|PolynomialCategoryQuotientFunctions| (|IndexedExponents| 12) 12
                                                     6
                                                     (|SparseMultivariatePolynomial|
                                                      6 12)
                                                     7)
              (81 . |multivariate|) (87 . |concat|) (93 . |One|) (97 . |One|)
              (|NonNegativeInteger|) (101 . |monomial|) (107 . |coerce|)
              (112 . |argument|) (117 . |One|) (|List| 36) (121 . |kernels|)
              (126 . |member?|) (|Mapping| 10 7) (132 . |every?|) (|List| 27)
              (138 . |matrix|) (|IntegrationTools| 6 7) (143 . |kmax|)
              (148 . ~=) (|Union| 11 '"failed") (154 . |symbolIfCan|)
              (159 . |coerce|) (|List| $) (164 . |tower|) (169 . |varselect|)
              (|Record| (|:| |ratpart| 7) (|:| |coeffs| 22))
              (|Union| 79 '#1="failed")
              (|Record| (|:| |particular| 80) (|:| |basis| 86))
              |INTPAR2;extendedint;FSLLR;10| |INTPAR2;extendedint;FSLR;8|
              (|List| 22) (175 . |nullSpace|) (|List| 79)
              |INTPAR2;extendedint;SLLL;9| (180 . -)
              (|LinearCombinationUtilities| 7 38) (185 . |dehomogenize|)
              (|Integer|) (190 . |elt|) (196 . |first|)
              (|Record| (|:| |answer| 52) (|:| |logpart| 52)
                        (|:| |specpart| 52) (|:| |polypart| 38))
              (|TranscendentalHermiteIntegration| 7 38)
              (201 . |HermiteIntegrate|) (207 . +) (213 . |coerce|) (218 . -)
              (224 . |polylog|) (230 . |log|) (235 . *) (241 . /) (247 . -)
              (252 . ^) (|SingleInteger|) (258 . ^) (|Fraction| 91)
              (264 . |One|) (268 . -) (273 . ^) (279 . ^) (285 . |factorial|)
              (290 . *) (296 . |coerce|) (301 . =) (307 . +)
              (|Record| (|:| |ratpart| 7) (|:| |coeff| 7) (|:| |prim| 7))
              (|Union| 118 '#2="failed") (313 . |polylog_int|) (|List| 40)
              (|ConstantLinearDependence| 6 7) (323 . |nullSpaceOverConstants|)
              (|Mapping| 84 21) (|AlgebraicIntegration| 6 7)
              (329 . |algextint_base|) (338 . |cons|) (|Mapping| 86 26 27)
              (|Mapping| 25 26 27) (|ParametricRischDE| 6 7)
              (344 . |param_rde2|)
              (|Record| (|:| |ratpart| 52) (|:| |coeffs| 22))
              (|Mapping| 154 50) (|Mapping| 154 52 50) (354 . |algextint|)
              (365 . |is?|) (371 . |tower|)
              (|Record| (|:| |funs| 27) (|:| |nroot| 7) (|:| |npow1| 91)
                        (|:| |npow2| 91))
              (|List| 138) (|RootFSSplit| 6 7) (376 . |alg_split_roots|)
              (383 . |setelt!|) (390 . |lin_comb|) (396 . |retract|)
              (401 . |eval|) (408 . |lin_comb|)
              (|Record| (|:| |primelt| 7) (|:| |pol1| 38) (|:| |pol2| 38)
                        (|:| |prim| 38))
              (|FunctionSpacePrimitiveElement| 6 7) (414 . |primitiveElement|)
              (|SparseUnivariatePolynomial| $) (420 . |rootOf|) (425 . |elt|)
              (431 . |eval|) (|List| 132) (|Mapping| 86 27)
              (438 . |primextint|) (446 . |param_rde|) (|Mapping| 86 91 27)
              (457 . |expextint|) (465 . ~=) (471 . |elt|)
              (|LiftLinearDependence| 7 7 38) (477 . |csolve_pol|)
              (483 . |coefficient|) (489 . |new|) (493 . |eval|)
              (500 . |append|) (|Record| (|:| |transform| 21) (|:| |basis| 84))
              (506 . |constant_subspace|) (512 . |vector|) (517 . *)
              (523 . |entries|) (528 . |kernel|) (533 . |map|) (539 . |numer|)
              (544 . |denom|) (549 . |One|) (553 . ~=) (559 . |degree|)
              (564 . ~=) (|Mapping| 86 30) (570 . |diffextint|)
              (577 . |unkextint|))
           '#(|polylog_int| 584 |logextint| 594 |extendedint| 601) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|extendedint|
                                 ((|List|
                                   (|Record| (|:| |ratpart| |#2|)
                                             (|:| |coeffs| (|Vector| |#2|))))
                                  (|Symbol|) (|List| (|Kernel| |#2|))
                                  (|List| |#2|)))
                                T)
                              '((|extendedint|
                                 ((|Record|
                                   (|:| |particular|
                                        (|Union|
                                         (|Record| (|:| |ratpart| |#2|)
                                                   (|:| |coeffs|
                                                        (|Vector| |#2|)))
                                         #1#))
                                   (|:| |basis|
                                        (|List|
                                         (|Record| (|:| |ratpart| |#2|)
                                                   (|:| |coeffs|
                                                        (|Vector| |#2|))))))
                                  |#2| (|Symbol|) (|List| (|Kernel| |#2|))
                                  (|List| |#2|)))
                                T)
                              '((|polylog_int|
                                 ((|Union|
                                   (|Record| (|:| |ratpart| |#2|)
                                             (|:| |coeff| |#2|)
                                             (|:| |prim| |#2|))
                                   #2#)
                                  |#2| (|Symbol|) (|Kernel| |#2|)
                                  (|NonNegativeInteger|)
                                  (|List| (|Kernel| |#2|)) |#2|))
                                T)
                              '((|extendedint|
                                 ((|Record|
                                   (|:| |particular|
                                        (|Union|
                                         (|Record| (|:| |ratpart| |#2|)
                                                   (|:| |coeffs|
                                                        (|Vector| |#2|)))
                                         #1#))
                                   (|:| |basis|
                                        (|List|
                                         (|Record| (|:| |ratpart| |#2|)
                                                   (|:| |coeffs|
                                                        (|Vector| |#2|))))))
                                  |#2| (|Symbol|) (|List| |#2|)))
                                T)
                              '((|logextint|
                                 ((|Record| (|:| |logands| (|List| |#2|))
                                            (|:| |basis|
                                                 (|List|
                                                  (|Vector|
                                                   (|Fraction| (|Integer|))))))
                                  (|Symbol|) (|List| (|Kernel| |#2|))
                                  (|List| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 183
                                            '(2 12 10 0 11 13 1 12 14 0 15 2 14
                                              10 0 11 16 0 6 0 17 0 7 0 18 2 23
                                              20 21 22 24 3 33 29 30 31 32 34 2
                                              7 0 0 11 35 1 7 0 36 37 1 38 0 7
                                              39 3 38 0 0 40 0 41 1 43 42 38 44
                                              2 7 45 0 36 46 5 33 29 47 48 31
                                              49 50 51 2 53 7 52 12 54 2 30 0 0
                                              38 55 0 6 0 56 0 7 0 57 2 38 0 7
                                              58 59 1 52 0 38 60 1 12 27 0 61 0
                                              58 0 62 1 7 63 0 64 2 26 10 12 0
                                              65 2 27 10 66 0 67 1 21 0 68 69 1
                                              70 12 26 71 2 12 10 0 0 72 1 12
                                              73 0 74 1 7 0 11 75 1 7 63 76 77
                                              2 70 26 26 11 78 1 21 84 0 85 1 7
                                              0 0 88 1 89 81 86 90 2 22 7 0 91
                                              92 1 27 7 0 93 2 95 94 52 47 96 2
                                              52 0 0 0 97 1 7 0 91 98 2 7 0 0 0
                                              99 2 7 0 0 0 100 1 7 0 0 101 2 7
                                              0 0 0 102 2 7 0 0 0 103 1 6 0 0
                                              104 2 6 0 0 58 105 2 106 0 0 58
                                              107 0 108 0 109 1 108 0 0 110 2
                                              108 0 0 91 111 2 7 0 0 91 112 1
                                              91 0 0 113 2 108 0 0 91 114 1 7 0
                                              108 115 2 7 10 0 0 116 2 7 0 0 0
                                              117 6 0 119 7 11 12 58 26 7 120 2
                                              122 84 21 121 123 5 125 86 12 12
                                              47 124 27 126 2 26 0 12 0 127 6
                                              130 86 7 27 11 26 128 129 131 7
                                              125 86 12 12 47 133 134 124 27
                                              135 2 14 10 0 11 136 1 7 63 0 137
                                              3 140 139 27 12 12 141 3 22 7 0
                                              91 7 142 2 89 7 22 27 143 1 7 36
                                              0 144 3 7 0 0 36 0 145 2 89 22 22
                                              84 146 2 148 147 7 7 149 1 7 0
                                              150 151 2 38 7 0 7 152 3 7 0 0 63
                                              76 153 4 33 154 47 155 124 50 156
                                              7 130 86 91 7 27 11 26 128 129
                                              157 4 33 154 47 158 124 50 159 2
                                              58 10 0 0 160 2 27 7 0 91 161 2
                                              162 84 124 30 163 2 38 7 0 58 164
                                              0 11 0 165 3 7 0 0 0 0 166 2 27 0
                                              0 0 167 2 122 168 84 121 169 1 22
                                              0 27 170 2 21 22 0 22 171 1 22 27
                                              0 172 1 12 0 11 173 2 27 0 40 0
                                              174 1 52 38 0 175 1 52 38 0 176 0
                                              38 0 177 2 38 10 0 0 178 1 38 58
                                              0 179 2 7 10 0 0 180 3 33 86 181
                                              124 50 182 3 33 86 155 124 50 183
                                              6 0 119 7 11 12 58 26 7 120 3 0
                                              25 11 26 27 28 4 0 81 7 11 26 27
                                              82 3 0 86 11 26 27 87 3 0 81 7 11
                                              27 83)))))
           '|lookupComplete|)) 
