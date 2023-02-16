
(SDEFUN |TRMANIP;expandTrigProducts;2F;1| ((|e| (F)) ($ (F)))
        (SPADCALL (LIST (QREFELT $ 29) (QREFELT $ 30) (QREFELT $ 31)) |e| 10
                  (QREFELT $ 35))) 

(SDEFUN |TRMANIP;logArgs| ((|l| (|List| F)) ($ (F)))
        (SPROG
         ((|sum| (F)) (|arg| (F))
          (|prod|
           (|Union|
            (|Record| (|:| |coef| (|Integer|)) (|:| |var| (|Kernel| F)))
            "failed"))
          (#1=#:G760 NIL) (|term| NIL))
         (SEQ (LETT |sum| (|spadConstant| $ 37))
              (LETT |arg| (|spadConstant| $ 38))
              (SEQ (LETT |term| NIL) (LETT #1# |l|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |term| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL |term| '|log| (QREFELT $ 40))
                       (LETT |arg|
                             (SPADCALL |arg|
                                       (SPADCALL
                                        (|SPADfirst|
                                         (SPADCALL
                                          (|SPADfirst|
                                           (SPADCALL |term| (QREFELT $ 42)))
                                          (QREFELT $ 45)))
                                        (QREFELT $ 46))
                                       (QREFELT $ 21))))
                      ('T
                       (SEQ (LETT |prod| (SPADCALL |term| (QREFELT $ 49)))
                            (COND
                             ((QEQCAR |prod| 0)
                              (COND
                               ((SPADCALL (QCDR (QCDR |prod|)) '|log|
                                          (QREFELT $ 50))
                                (EXIT
                                 (LETT |arg|
                                       (SPADCALL |arg|
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (|SPADfirst|
                                                    (SPADCALL
                                                     (QCDR (QCDR |prod|))
                                                     (QREFELT $ 45)))
                                                   (QCAR (QCDR |prod|))
                                                   (QREFELT $ 51))
                                                  (QREFELT $ 46))
                                                 (QREFELT $ 21))))))))
                            (EXIT
                             (LETT |sum|
                                   (SPADCALL |sum| |term|
                                             (QREFELT $ 22)))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL |sum| (SPADCALL |arg| (QREFELT $ 52))
                         (QREFELT $ 22)))))) 

(SDEFUN |TRMANIP;simplifyLog;2F;3| ((|e| (F)) ($ (F)))
        (SPADCALL (|TRMANIP;simplifyLog1| (SPADCALL |e| (QREFELT $ 53)) $)
                  (|TRMANIP;simplifyLog1| (SPADCALL |e| (QREFELT $ 54)) $)
                  (QREFELT $ 26))) 

(SDEFUN |TRMANIP;simplifyLog1| ((|e| (F)) ($ (F)))
        (SPROG
         ((#1=#:G808 NIL) (#2=#:G807 (F)) (#3=#:G809 (F)) (#4=#:G820 NIL)
          (#5=#:G690 NIL) (|terms| (|List| F)) (|foundLog| (|Boolean|))
          (#6=#:G800 NIL) (#7=#:G799 (F)) (#8=#:G801 (F)) (#9=#:G819 NIL)
          (#10=#:G689 NIL) (|args| (|List| F)) (|i| (|NonNegativeInteger|))
          (|nterms| (|List| F)) (|exprs| (|List| F)) (#11=#:G818 NIL)
          (|term| NIL) (#12=#:G817 NIL) (#13=#:G816 NIL) (#14=#:G815 NIL)
          (|u| NIL) (#15=#:G814 NIL) (|kers| (|List| (|Kernel| F)))
          (|expt|
           (|Union| (|Record| (|:| |val| F) (|:| |exponent| (|Integer|)))
                    #16="failed"))
          (|termList| (|Union| (|List| F) #16#))
          (|prod|
           (|Union|
            (|Record| (|:| |coef| (|Integer|)) (|:| |var| (|Kernel| F)))
            #16#)))
         (SEQ
          (COND ((SPADCALL |e| '|log| (QREFELT $ 55)) |e|)
                (#17='T
                 (SEQ (LETT |prod| (SPADCALL |e| (QREFELT $ 49)))
                      (COND
                       ((QEQCAR |prod| 0)
                        (COND
                         ((SPADCALL (QCDR (QCDR |prod|)) (QREFELT $ 14)
                                    (QREFELT $ 56))
                          (EXIT
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL
                              (|SPADfirst|
                               (SPADCALL (QCDR (QCDR |prod|)) (QREFELT $ 45)))
                              (QCAR (QCDR |prod|)) (QREFELT $ 51))
                             (QREFELT $ 46))
                            (QREFELT $ 52)))))))
                      (LETT |termList| (SPADCALL |e| (QREFELT $ 58)))
                      (EXIT
                       (COND
                        ((QEQCAR |termList| 1)
                         (SEQ (LETT |terms| (SPADCALL |e| (QREFELT $ 59)))
                              (EXIT
                               (COND
                                ((QEQCAR |terms| 1)
                                 (SEQ
                                  (LETT |expt| (SPADCALL |e| (QREFELT $ 62)))
                                  (COND
                                   ((QEQCAR |expt| 0)
                                    (COND
                                     ((NULL (EQL (QCDR (QCDR |expt|)) 1))
                                      (EXIT
                                       (SPADCALL
                                        (SPADCALL (QCAR (QCDR |expt|))
                                                  (QREFELT $ 46))
                                        (QCDR (QCDR |expt|))
                                        (QREFELT $ 51)))))))
                                  (LETT |kers| (SPADCALL |e| (QREFELT $ 42)))
                                  (COND
                                   ((NULL (EQL (LENGTH |kers|) 1)) (EXIT |e|)))
                                  (EXIT
                                   (SPADCALL
                                    (SPADCALL (|SPADfirst| |kers|)
                                              (QREFELT $ 63))
                                    (PROGN
                                     (LETT #15# NIL)
                                     (SEQ (LETT |u| NIL)
                                          (LETT #14#
                                                (SPADCALL (|SPADfirst| |kers|)
                                                          (QREFELT $ 45)))
                                          G190
                                          (COND
                                           ((OR (ATOM #14#)
                                                (PROGN
                                                 (LETT |u| (CAR #14#))
                                                 NIL))
                                            (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (LETT #15#
                                                  (CONS
                                                   (SPADCALL |u|
                                                             (QREFELT $ 46))
                                                   #15#))))
                                          (LETT #14# (CDR #14#)) (GO G190) G191
                                          (EXIT (NREVERSE #15#))))
                                    (QREFELT $ 65)))))
                                (#17# (|TRMANIP;logArgs| (QCDR |terms|) $))))))
                        (#17#
                         (SEQ
                          (LETT |terms|
                                (PROGN
                                 (LETT #13# NIL)
                                 (SEQ (LETT |term| NIL)
                                      (LETT #12# (QCDR |termList|)) G190
                                      (COND
                                       ((OR (ATOM #12#)
                                            (PROGN
                                             (LETT |term| (CAR #12#))
                                             NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #13#
                                              (CONS
                                               (SPADCALL |term| (QREFELT $ 46))
                                               #13#))))
                                      (LETT #12# (CDR #12#)) (GO G190) G191
                                      (EXIT (NREVERSE #13#)))))
                          (LETT |exprs| NIL) (LETT |nterms| NIL)
                          (SEQ (LETT |term| NIL) (LETT #11# |terms|) G190
                               (COND
                                ((OR (ATOM #11#)
                                     (PROGN (LETT |term| (CAR #11#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((QEQCAR (SPADCALL |term| (QREFELT $ 67)) 0)
                                   (LETT |exprs| (CONS |term| |exprs|)))
                                  ('T
                                   (LETT |nterms| (CONS |term| |nterms|))))))
                               (LETT #11# (CDR #11#)) (GO G190) G191
                               (EXIT NIL))
                          (LETT |terms| |nterms|)
                          (COND
                           ((NULL (NULL |exprs|))
                            (SEQ (LETT |foundLog| NIL) (LETT |i| 0)
                                 (SEQ G190
                                      (COND
                                       ((NULL
                                         (COND (|foundLog| NIL)
                                               ('T (< |i| (LENGTH |terms|)))))
                                        (GO G191)))
                                      (SEQ (LETT |i| (+ |i| 1))
                                           (EXIT
                                            (COND
                                             ((SPADCALL
                                               (SPADCALL |terms| |i|
                                                         (QREFELT $ 69))
                                               '|log| (QREFELT $ 40))
                                              (SEQ
                                               (LETT |args|
                                                     (SPADCALL
                                                      (SPADCALL
                                                       (SPADCALL |terms| |i|
                                                                 (QREFELT $
                                                                          69))
                                                       (QREFELT $ 71))
                                                      (QREFELT $ 45)))
                                               (SPADCALL |terms| |i|
                                                         (SPADCALL
                                                          (|TRMANIP;simplifyLog1|
                                                           (SPADCALL
                                                            (|SPADfirst|
                                                             |args|)
                                                            (PROGN
                                                             (LETT #6# NIL)
                                                             (SEQ
                                                              (LETT #10# NIL)
                                                              (LETT #9#
                                                                    |exprs|)
                                                              G190
                                                              (COND
                                                               ((OR (ATOM #9#)
                                                                    (PROGN
                                                                     (LETT #10#
                                                                           (CAR
                                                                            #9#))
                                                                     NIL))
                                                                (GO G191)))
                                                              (SEQ
                                                               (EXIT
                                                                (PROGN
                                                                 (LETT #8#
                                                                       #10#)
                                                                 (COND
                                                                  (#6#
                                                                   (LETT #7#
                                                                         (SPADCALL
                                                                          #7#
                                                                          #8#
                                                                          (QREFELT
                                                                           $
                                                                           21))))
                                                                  ('T
                                                                   (PROGN
                                                                    (LETT #7#
                                                                          #8#)
                                                                    (LETT #6#
                                                                          'T)))))))
                                                              (LETT #9#
                                                                    (CDR #9#))
                                                              (GO G190) G191
                                                              (EXIT NIL))
                                                             (COND (#6# #7#)
                                                                   ('T
                                                                    (|spadConstant|
                                                                     $ 38))))
                                                            (QREFELT $ 72))
                                                           $)
                                                          (QREFELT $ 52))
                                                         (QREFELT $ 73))
                                               (EXIT (LETT |foundLog| 'T)))))))
                                      NIL (GO G190) G191 (EXIT NIL))
                                 (EXIT
                                  (COND
                                   ((NULL |foundLog|)
                                    (LETT |terms|
                                          (SPADCALL |exprs| |terms|
                                                    (QREFELT $ 74)))))))))
                          (EXIT
                           (PROGN
                            (LETT #1# NIL)
                            (SEQ (LETT #5# NIL) (LETT #4# |terms|) G190
                                 (COND
                                  ((OR (ATOM #4#)
                                       (PROGN (LETT #5# (CAR #4#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (PROGN
                                    (LETT #3# #5#)
                                    (COND
                                     (#1#
                                      (LETT #2#
                                            (SPADCALL #2# #3# (QREFELT $ 21))))
                                     ('T
                                      (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                                 (LETT #4# (CDR #4#)) (GO G190) G191
                                 (EXIT NIL))
                            (COND (#1# #2#)
                                  (#17# (|spadConstant| $ 38))))))))))))))) 

(SDEFUN |TRMANIP;simplify;2F;5| ((|x| (F)) ($ (F)))
        (SPADCALL (|TRMANIP;simplify0| |x| $) (QREFELT $ 76))) 

(SDEFUN |TRMANIP;simplify;2F;6| ((|x| (F)) ($ (F))) (|TRMANIP;simplify0| |x| $)) 

(SDEFUN |TRMANIP;expandpow| ((|k| (|Kernel| F)) (|f| (|Mapping| F F)) ($ (F)))
        (SPROG ((|de| (F)) (|ne| (F)) (|b| (F)) (|a| (F)) (|arg| (|List| F)))
               (SEQ
                (LETT |a|
                      (SPADCALL
                       (|SPADfirst| (LETT |arg| (SPADCALL |k| (QREFELT $ 45))))
                       |f|))
                (LETT |b| (SPADCALL (SPADCALL |arg| (QREFELT $ 78)) |f|))
                (LETT |ne|
                      (COND
                       ((SPADCALL (SPADCALL |a| (QREFELT $ 80))
                                  (|spadConstant| $ 82) (QREFELT $ 83))
                        (|spadConstant| $ 38))
                       (#1='T
                        (SPADCALL
                         (SPADCALL (SPADCALL |a| (QREFELT $ 80))
                                   (QREFELT $ 84))
                         |b| (QREFELT $ 72)))))
                (LETT |de|
                      (COND
                       ((SPADCALL (SPADCALL |a| (QREFELT $ 85))
                                  (|spadConstant| $ 82) (QREFELT $ 83))
                        (|spadConstant| $ 38))
                       (#1#
                        (SPADCALL
                         (SPADCALL (SPADCALL |a| (QREFELT $ 85))
                                   (QREFELT $ 84))
                         (SPADCALL |b| (QREFELT $ 86)) (QREFELT $ 72)))))
                (EXIT (SPADCALL |ne| |de| (QREFELT $ 21)))))) 

(SDEFUN |TRMANIP;termexp|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| F))) ($ (F)))
        (SPROG
         ((|coef| (|SparseMultivariatePolynomial| R (|Kernel| F)))
          (#1=#:G851 NIL) (|u| NIL) (#2=#:G850 NIL) (|exponent| (F))
          (|d| (|NonNegativeInteger|)) (#3=#:G849 NIL) (|k| NIL)
          (|lpow| (|List| (|Kernel| F))) (|lk| (|List| (|Kernel| F))))
         (SEQ (LETT |lk| (SPADCALL |p| (QREFELT $ 88)))
              (EXIT
               (COND ((NULL |lk|) (SPADCALL |p| (QREFELT $ 84)))
                     ('T
                      (SEQ (LETT |exponent| (|spadConstant| $ 37))
                           (LETT |coef|
                                 (SPADCALL (SPADCALL |p| (QREFELT $ 89))
                                           (QREFELT $ 90)))
                           (LETT |lpow|
                                 (SPADCALL (CONS #'|TRMANIP;termexp!0| $) |lk|
                                           (QREFELT $ 92)))
                           (SEQ (LETT |k| NIL) (LETT #3# |lk|) G190
                                (COND
                                 ((OR (ATOM #3#)
                                      (PROGN (LETT |k| (CAR #3#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (LETT |d| (SPADCALL |p| |k| (QREFELT $ 94)))
                                 (EXIT
                                  (COND
                                   ((SPADCALL |k| (QREFELT $ 13)
                                              (QREFELT $ 56))
                                    (LETT |exponent|
                                          (SPADCALL |exponent|
                                                    (SPADCALL |d|
                                                              (|SPADfirst|
                                                               (SPADCALL |k|
                                                                         (QREFELT
                                                                          $
                                                                          45)))
                                                              (QREFELT $ 95))
                                                    (QREFELT $ 22))))
                                   ((NULL
                                     (SPADCALL |k| '|%power| (QREFELT $ 50)))
                                    (LETT |coef|
                                          (SPADCALL |coef|
                                                    (SPADCALL
                                                     (|spadConstant| $ 82)
                                                     (SPADCALL
                                                      (SPADCALL |k|
                                                                (QREFELT $ 63))
                                                      (PROGN
                                                       (LETT #2# NIL)
                                                       (SEQ (LETT |u| NIL)
                                                            (LETT #1#
                                                                  (SPADCALL |k|
                                                                            (QREFELT
                                                                             $
                                                                             45)))
                                                            G190
                                                            (COND
                                                             ((OR (ATOM #1#)
                                                                  (PROGN
                                                                   (LETT |u|
                                                                         (CAR
                                                                          #1#))
                                                                   NIL))
                                                              (GO G191)))
                                                            (SEQ
                                                             (EXIT
                                                              (LETT #2#
                                                                    (CONS
                                                                     (SPADCALL
                                                                      |u|
                                                                      (QREFELT
                                                                       $ 96))
                                                                     #2#))))
                                                            (LETT #1#
                                                                  (CDR #1#))
                                                            (GO G190) G191
                                                            (EXIT
                                                             (NREVERSE #2#))))
                                                      (SPADCALL |k|
                                                                (QREFELT $ 97))
                                                      (QREFELT $ 98))
                                                     |d| (QREFELT $ 99))
                                                    (QREFELT $ 100)))))))
                                (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                           (EXIT
                            (SPADCALL
                             (SPADCALL (SPADCALL |coef| (QREFELT $ 84))
                                       (SPADCALL
                                        (SPADCALL |exponent| (QREFELT $ 96))
                                        (QREFELT $ 101))
                                       (QREFELT $ 21))
                             (|TRMANIP;powersimp| |p| |lpow| $)
                             (QREFELT $ 21)))))))))) 

(SDEFUN |TRMANIP;termexp!0| ((|z1| NIL) ($ NIL))
        (SPADCALL |z1| '|%power| (QREFELT $ 50))) 

(SDEFUN |TRMANIP;expandPower;2F;9| ((|f| (F)) ($ (F)))
        (SPROG
         ((#1=#:G859 NIL) (|k| NIL) (#2=#:G858 NIL)
          (|l| (|List| (|Kernel| F))))
         (SEQ
          (LETT |l|
                (SPADCALL (CONS #'|TRMANIP;expandPower;2F;9!0| $)
                          (SPADCALL |f| (QREFELT $ 42)) (QREFELT $ 92)))
          (EXIT
           (SPADCALL |f| |l|
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |k| NIL) (LETT #1# |l|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #2#
                                   (CONS
                                    (|TRMANIP;expandpow| |k| (ELT $ 102) $)
                                    #2#))))
                           (LETT #1# (CDR #1#)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))
                     (QREFELT $ 103)))))) 

(SDEFUN |TRMANIP;expandPower;2F;9!0| ((|z1| NIL) ($ NIL))
        (SPADCALL |z1| '|%power| (QREFELT $ 50))) 

(SDEFUN |TRMANIP;powersimp|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| F)))
         (|l| (|List| (|Kernel| F))) ($ (F)))
        (SPROG
         ((|exponent| (F)) (#1=#:G868 NIL) (|k0| NIL)
          (|lk| (|List| (|Kernel| F))) (|a| (F)) (|arg| (|List| F))
          (|k| (|Kernel| F)))
         (SEQ
          (COND ((NULL |l|) (|spadConstant| $ 38))
                ('T
                 (SEQ (LETT |k| (|SPADfirst| |l|))
                      (LETT |a|
                            (|SPADfirst|
                             (LETT |arg| (SPADCALL |k| (QREFELT $ 45)))))
                      (LETT |exponent|
                            (SPADCALL (SPADCALL |p| |k| (QREFELT $ 94))
                                      (SPADCALL |arg| (QREFELT $ 78))
                                      (QREFELT $ 104)))
                      (LETT |lk|
                            (SPADCALL
                             (CONS #'|TRMANIP;powersimp!0| (VECTOR $ |a|))
                             (CDR |l|) (QREFELT $ 92)))
                      (SEQ (LETT |k0| NIL) (LETT #1# |lk|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |k0| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT |exponent|
                                   (SPADCALL |exponent|
                                             (SPADCALL
                                              (SPADCALL |p| |k0|
                                                        (QREFELT $ 94))
                                              (SPADCALL
                                               (SPADCALL |k0| (QREFELT $ 45))
                                               (QREFELT $ 78))
                                              (QREFELT $ 104))
                                             (QREFELT $ 22)))))
                           (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (SPADCALL
                        (SPADCALL |a| (SPADCALL |exponent| (QREFELT $ 96))
                                  (QREFELT $ 72))
                        (|TRMANIP;powersimp| |p|
                         (SPADCALL (CDR |l|) |lk| (QREFELT $ 107)) $)
                        (QREFELT $ 21))))))))) 

(SDEFUN |TRMANIP;powersimp!0| ((|z1| NIL) ($$ NIL))
        (PROG (|a| $)
          (LETT |a| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |a|
                      (SPADCALL (SPADCALL |z1| (QREFELT $ 45)) (QREFELT $ 105))
                      (QREFELT $ 106)))))) 

(SDEFUN |TRMANIP;t2t| ((|x| (F)) ($ (F)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 20)) (SPADCALL |x| (QREFELT $ 19))
                  (QREFELT $ 26))) 

(SDEFUN |TRMANIP;c2t| ((|x| (F)) ($ (F)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 19)) (SPADCALL |x| (QREFELT $ 20))
                  (QREFELT $ 26))) 

(SDEFUN |TRMANIP;c2s| ((|x| (F)) ($ (F)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 20)) (QREFELT $ 108))) 

(SDEFUN |TRMANIP;s2c| ((|x| (F)) ($ (F)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 19)) (QREFELT $ 108))) 

(SDEFUN |TRMANIP;s2c2| ((|x| (F)) ($ (F)))
        (SPADCALL (|spadConstant| $ 38)
                  (SPADCALL (SPADCALL |x| (QREFELT $ 19)) 2 (QREFELT $ 51))
                  (QREFELT $ 23))) 

(SDEFUN |TRMANIP;th2th| ((|x| (F)) ($ (F)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 109)) (SPADCALL |x| (QREFELT $ 110))
                  (QREFELT $ 26))) 

(SDEFUN |TRMANIP;ch2th| ((|x| (F)) ($ (F)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 110)) (SPADCALL |x| (QREFELT $ 109))
                  (QREFELT $ 26))) 

(SDEFUN |TRMANIP;ch2sh| ((|x| (F)) ($ (F)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 109)) (QREFELT $ 108))) 

(SDEFUN |TRMANIP;sh2ch| ((|x| (F)) ($ (F)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 110)) (QREFELT $ 108))) 

(SDEFUN |TRMANIP;sh2ch2| ((|x| (F)) ($ (F)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 110)) 2 (QREFELT $ 51))
                  (|spadConstant| $ 38) (QREFELT $ 23))) 

(SDEFUN |TRMANIP;ueval|
        ((|x| (F)) (|s| (|Symbol|)) (|f| (|Mapping| F F)) ($ (F)))
        (SPADCALL |x| |s| |f| (QREFELT $ 112))) 

(SDEFUN |TRMANIP;ueval2|
        ((|x| (F)) (|s| (|Symbol|)) (|f| (|Mapping| F F)) ($ (F)))
        (SPADCALL |x| |s| 2 |f| (QREFELT $ 113))) 

(SDEFUN |TRMANIP;cos2sec;2F;23| ((|x| (F)) ($ (F)))
        (|TRMANIP;ueval| |x| '|cos| (CONS #'|TRMANIP;cos2sec;2F;23!0| $) $)) 

(SDEFUN |TRMANIP;cos2sec;2F;23!0| ((|z1| NIL) ($ NIL))
        (SPADCALL (SPADCALL |z1| (QREFELT $ 114)) (QREFELT $ 108))) 

(SDEFUN |TRMANIP;sin2csc;2F;24| ((|x| (F)) ($ (F)))
        (|TRMANIP;ueval| |x| '|sin| (CONS #'|TRMANIP;sin2csc;2F;24!0| $) $)) 

(SDEFUN |TRMANIP;sin2csc;2F;24!0| ((|z1| NIL) ($ NIL))
        (SPADCALL (SPADCALL |z1| (QREFELT $ 116)) (QREFELT $ 108))) 

(SDEFUN |TRMANIP;csc2sin;2F;25| ((|x| (F)) ($ (F)))
        (|TRMANIP;ueval| |x| '|csc| (CONS (|function| |TRMANIP;c2s|) $) $)) 

(SDEFUN |TRMANIP;sec2cos;2F;26| ((|x| (F)) ($ (F)))
        (|TRMANIP;ueval| |x| '|sec| (CONS (|function| |TRMANIP;s2c|) $) $)) 

(SDEFUN |TRMANIP;tan2cot;2F;27| ((|x| (F)) ($ (F)))
        (|TRMANIP;ueval| |x| '|tan| (CONS #'|TRMANIP;tan2cot;2F;27!0| $) $)) 

(SDEFUN |TRMANIP;tan2cot;2F;27!0| ((|z1| NIL) ($ NIL))
        (SPADCALL (SPADCALL |z1| (QREFELT $ 120)) (QREFELT $ 108))) 

(SDEFUN |TRMANIP;cot2tan;2F;28| ((|x| (F)) ($ (F)))
        (|TRMANIP;ueval| |x| '|cot| (CONS #'|TRMANIP;cot2tan;2F;28!0| $) $)) 

(SDEFUN |TRMANIP;cot2tan;2F;28!0| ((|z1| NIL) ($ NIL))
        (SPADCALL (SPADCALL |z1| (QREFELT $ 122)) (QREFELT $ 108))) 

(SDEFUN |TRMANIP;tan2trig;2F;29| ((|x| (F)) ($ (F)))
        (|TRMANIP;ueval| |x| '|tan| (CONS (|function| |TRMANIP;t2t|) $) $)) 

(SDEFUN |TRMANIP;cot2trig;2F;30| ((|x| (F)) ($ (F)))
        (|TRMANIP;ueval| |x| '|cot| (CONS (|function| |TRMANIP;c2t|) $) $)) 

(SDEFUN |TRMANIP;cosh2sech;2F;31| ((|x| (F)) ($ (F)))
        (|TRMANIP;ueval| |x| '|cosh| (CONS #'|TRMANIP;cosh2sech;2F;31!0| $) $)) 

(SDEFUN |TRMANIP;cosh2sech;2F;31!0| ((|z1| NIL) ($ NIL))
        (SPADCALL (SPADCALL |z1| (QREFELT $ 126)) (QREFELT $ 108))) 

(SDEFUN |TRMANIP;sinh2csch;2F;32| ((|x| (F)) ($ (F)))
        (|TRMANIP;ueval| |x| '|sinh| (CONS #'|TRMANIP;sinh2csch;2F;32!0| $) $)) 

(SDEFUN |TRMANIP;sinh2csch;2F;32!0| ((|z1| NIL) ($ NIL))
        (SPADCALL (SPADCALL |z1| (QREFELT $ 128)) (QREFELT $ 108))) 

(SDEFUN |TRMANIP;csch2sinh;2F;33| ((|x| (F)) ($ (F)))
        (|TRMANIP;ueval| |x| '|csch| (CONS (|function| |TRMANIP;ch2sh|) $) $)) 

(SDEFUN |TRMANIP;sech2cosh;2F;34| ((|x| (F)) ($ (F)))
        (|TRMANIP;ueval| |x| '|sech| (CONS (|function| |TRMANIP;sh2ch|) $) $)) 

(SDEFUN |TRMANIP;tanh2coth;2F;35| ((|x| (F)) ($ (F)))
        (|TRMANIP;ueval| |x| '|tanh| (CONS #'|TRMANIP;tanh2coth;2F;35!0| $) $)) 

(SDEFUN |TRMANIP;tanh2coth;2F;35!0| ((|z1| NIL) ($ NIL))
        (SPADCALL (SPADCALL |z1| (QREFELT $ 132)) (QREFELT $ 108))) 

(SDEFUN |TRMANIP;coth2tanh;2F;36| ((|x| (F)) ($ (F)))
        (|TRMANIP;ueval| |x| '|coth| (CONS #'|TRMANIP;coth2tanh;2F;36!0| $) $)) 

(SDEFUN |TRMANIP;coth2tanh;2F;36!0| ((|z1| NIL) ($ NIL))
        (SPADCALL (SPADCALL |z1| (QREFELT $ 134)) (QREFELT $ 108))) 

(SDEFUN |TRMANIP;tanh2trigh;2F;37| ((|x| (F)) ($ (F)))
        (|TRMANIP;ueval| |x| '|tanh| (CONS (|function| |TRMANIP;th2th|) $) $)) 

(SDEFUN |TRMANIP;coth2trigh;2F;38| ((|x| (F)) ($ (F)))
        (|TRMANIP;ueval| |x| '|coth| (CONS (|function| |TRMANIP;ch2th|) $) $)) 

(SDEFUN |TRMANIP;removeCosSq;2F;39| ((|x| (F)) ($ (F)))
        (|TRMANIP;ueval2| |x| '|cos| (CONS #'|TRMANIP;removeCosSq;2F;39!0| $)
         $)) 

(SDEFUN |TRMANIP;removeCosSq;2F;39!0| ((|z1| NIL) ($ NIL))
        (SPADCALL (|spadConstant| $ 38)
                  (SPADCALL (SPADCALL |z1| (QREFELT $ 20)) 2 (QREFELT $ 51))
                  (QREFELT $ 23))) 

(SDEFUN |TRMANIP;removeSinSq;2F;40| ((|x| (F)) ($ (F)))
        (|TRMANIP;ueval2| |x| '|sin| (CONS (|function| |TRMANIP;s2c2|) $) $)) 

(SDEFUN |TRMANIP;removeCoshSq;2F;41| ((|x| (F)) ($ (F)))
        (|TRMANIP;ueval2| |x| '|cosh| (CONS #'|TRMANIP;removeCoshSq;2F;41!0| $)
         $)) 

(SDEFUN |TRMANIP;removeCoshSq;2F;41!0| ((|z1| NIL) ($ NIL))
        (SPADCALL (|spadConstant| $ 38)
                  (SPADCALL (SPADCALL |z1| (QREFELT $ 109)) 2 (QREFELT $ 51))
                  (QREFELT $ 22))) 

(SDEFUN |TRMANIP;removeSinhSq;2F;42| ((|x| (F)) ($ (F)))
        (|TRMANIP;ueval2| |x| '|sinh| (CONS (|function| |TRMANIP;sh2ch2|) $) $)) 

(SDEFUN |TRMANIP;expandLog;2F;43| ((|x| (F)) ($ (F)))
        (SPADCALL (|TRMANIP;smplog| (SPADCALL |x| (QREFELT $ 80)) $)
                  (|TRMANIP;smplog| (SPADCALL |x| (QREFELT $ 85)) $)
                  (QREFELT $ 26))) 

(SDEFUN |TRMANIP;expand;2F;44| ((|x| (F)) ($ (F)))
        (SPADCALL (|TRMANIP;smpexpand| (SPADCALL |x| (QREFELT $ 80)) $)
                  (|TRMANIP;smpexpand| (SPADCALL |x| (QREFELT $ 85)) $)
                  (QREFELT $ 26))) 

(SDEFUN |TRMANIP;smpexpand|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| F))) ($ (F)))
        (SPADCALL (CONS (|function| |TRMANIP;kerexpand|) $) (ELT $ 144) |p|
                  (QREFELT $ 148))) 

(SDEFUN |TRMANIP;smplog|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| F))) ($ (F)))
        (SPADCALL (CONS (|function| |TRMANIP;logexpand|) $) (ELT $ 144) |p|
                  (QREFELT $ 148))) 

(SDEFUN |TRMANIP;smp2htrigs|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| F))) ($ (F)))
        (SPADCALL (CONS #'|TRMANIP;smp2htrigs!0| $) (ELT $ 144) |p|
                  (QREFELT $ 148))) 

(SDEFUN |TRMANIP;smp2htrigs!0| ((|k1| NIL) ($ NIL))
        (SPADCALL (SPADCALL |k1| (QREFELT $ 149)) (QREFELT $ 150))) 

(SDEFUN |TRMANIP;simplifyExp;2F;48| ((|x| (F)) ($ (F)))
        (SPROG
         ((#1=#:G949 NIL) (|term| (F)) (#2=#:G953 NIL) (|k1| NIL)
          (#3=#:G950 NIL) (#4=#:G952 NIL) (|h| (|NonNegativeInteger|))
          (|args| (|List| F)) (|op| (|BasicOperator|)) (#5=#:G951 NIL)
          (|k2| NIL) (|lk2| #6=(|List| (|Kernel| F))) (|lk1| #6#)
          (|q1| #7=(|SparseMultivariatePolynomial| R (|Kernel| F))) (|p1| #7#)
          (|q| (F)) (|p| (F)))
         (SEQ (LETT |p| (|TRMANIP;smpexp| (SPADCALL |x| (QREFELT $ 80)) $))
              (LETT |q| (|TRMANIP;smpexp| (SPADCALL |x| (QREFELT $ 85)) $))
              (COND
               ((SPADCALL (LETT |p1| (SPADCALL |p| (QREFELT $ 80)))
                          (QREFELT $ 151))
                (COND
                 ((NULL
                   (SPADCALL (LETT |q1| (SPADCALL |q| (QREFELT $ 80)))
                             (QREFELT $ 151)))
                  (EXIT (SPADCALL |p| |q| (QREFELT $ 26))))))
               ('T (EXIT (SPADCALL |p| |q| (QREFELT $ 26)))))
              (LETT |lk1| (SPADCALL |p1| (QREFELT $ 88)))
              (LETT |lk2| (SPADCALL |q1| (QREFELT $ 88)))
              (LETT |term| (|spadConstant| $ 38))
              (SEQ (LETT |k2| NIL) (LETT #5# |lk2|) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |k2| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |op| (SPADCALL |k2| (QREFELT $ 63)))
                        (LETT |args| (SPADCALL |k2| (QREFELT $ 45)))
                        (LETT |h| (SPADCALL |k2| (QREFELT $ 97)))
                        (COND
                         ((SPADCALL |op| (QREFELT $ 13) (QREFELT $ 152))
                          (SEQ
                           (EXIT
                            (SEQ (LETT |k1| NIL) (LETT #4# |lk1|) G190
                                 (COND
                                  ((OR (ATOM #4#)
                                       (PROGN (LETT |k1| (CAR #4#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (COND
                                    ((SPADCALL |k1| (QREFELT $ 13)
                                               (QREFELT $ 56))
                                     (SEQ
                                      (LETT |term|
                                            (SPADCALL |term|
                                                      (SPADCALL
                                                       (SPADCALL |op|
                                                                 (LIST
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    |args| 1
                                                                    (QREFELT $
                                                                             69))
                                                                   (QREFELT $
                                                                            86)))
                                                                 |h|
                                                                 (QREFELT $
                                                                          98))
                                                       (QREFELT $ 149))
                                                      (QREFELT $ 21)))
                                      (EXIT
                                       (PROGN
                                        (LETT #3# 1)
                                        (GO #8=#:G939))))))))
                                 (LETT #4# (CDR #4#)) (GO G190) G191
                                 (EXIT NIL)))
                           #8# (EXIT #3#))))
                        (EXIT
                         (COND
                          ((SPADCALL |op| '|%power| (QREFELT $ 153))
                           (SEQ
                            (EXIT
                             (SEQ (LETT |k1| NIL) (LETT #2# |lk1|) G190
                                  (COND
                                   ((OR (ATOM #2#)
                                        (PROGN (LETT |k1| (CAR #2#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((SPADCALL |k1| '|%power| (QREFELT $ 50))
                                      (COND
                                       ((SPADCALL
                                         (SPADCALL |args| 1 (QREFELT $ 69))
                                         (|SPADfirst|
                                          (SPADCALL |k1| (QREFELT $ 45)))
                                         (QREFELT $ 106))
                                        (SEQ
                                         (LETT |term|
                                               (SPADCALL |term|
                                                         (SPADCALL
                                                          (SPADCALL |op|
                                                                    (LIST
                                                                     (SPADCALL
                                                                      |args| 1
                                                                      (QREFELT
                                                                       $ 69))
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       |args| 2
                                                                       (QREFELT
                                                                        $ 69))
                                                                      (QREFELT
                                                                       $ 86)))
                                                                    |h|
                                                                    (QREFELT $
                                                                             98))
                                                          (QREFELT $ 149))
                                                         (QREFELT $ 21)))
                                         (EXIT
                                          (PROGN
                                           (LETT #1# 1)
                                           (GO #9=#:G944))))))))))
                                  (LETT #2# (CDR #2#)) (GO G190) G191
                                  (EXIT NIL)))
                            #9# (EXIT #1#))))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL
                (|TRMANIP;termexp|
                 (SPADCALL (SPADCALL |p| |term| (QREFELT $ 21)) (QREFELT $ 80))
                 $)
                (|TRMANIP;termexp|
                 (SPADCALL (SPADCALL |q| |term| (QREFELT $ 21)) (QREFELT $ 80))
                 $)
                (QREFELT $ 26)))))) 

(SDEFUN |TRMANIP;htrigs;2F;49| ((|f| (F)) ($ (F)))
        (SPROG
         ((|g1| (F)) (|b| (|Integer|)) (|g2| (F)) (|a| (F))
          (|den|
           #1=(|SparseUnivariatePolynomial|
               (|SparseMultivariatePolynomial| R (|Kernel| F))))
          (|num| #1#) (|arg| (|List| F)) (#2=#:G965 NIL) (|x| NIL)
          (#3=#:G964 NIL) (|op| (|BasicOperator|)) (|k| (|Kernel| F))
          (|m| (|Union| (|Kernel| F) "failed")))
         (SEQ (LETT |m| (SPADCALL |f| (QREFELT $ 155)))
              (EXIT
               (COND ((QEQCAR |m| 1) |f|)
                     (#4='T
                      (SEQ
                       (LETT |op|
                             (SPADCALL (LETT |k| (QCDR |m|)) (QREFELT $ 63)))
                       (LETT |arg|
                             (PROGN
                              (LETT #3# NIL)
                              (SEQ (LETT |x| NIL)
                                   (LETT #2# (SPADCALL |k| (QREFELT $ 45)))
                                   G190
                                   (COND
                                    ((OR (ATOM #2#)
                                         (PROGN (LETT |x| (CAR #2#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #3#
                                           (CONS (SPADCALL |x| (QREFELT $ 150))
                                                 #3#))))
                                   (LETT #2# (CDR #2#)) (GO G190) G191
                                   (EXIT (NREVERSE #3#)))))
                       (LETT |num|
                             (SPADCALL (SPADCALL |f| (QREFELT $ 80)) |k|
                                       (QREFELT $ 157)))
                       (LETT |den|
                             (SPADCALL (SPADCALL |f| (QREFELT $ 85)) |k|
                                       (QREFELT $ 157)))
                       (EXIT
                        (COND
                         ((SPADCALL |op| (QREFELT $ 13) (QREFELT $ 152))
                          (SEQ
                           (LETT |g1|
                                 (SPADCALL
                                  (SPADCALL (LETT |a| (|SPADfirst| |arg|))
                                            (QREFELT $ 110))
                                  (SPADCALL |a| (QREFELT $ 109))
                                  (QREFELT $ 22)))
                           (LETT |g2|
                                 (SPADCALL (SPADCALL |a| (QREFELT $ 110))
                                           (SPADCALL |a| (QREFELT $ 109))
                                           (QREFELT $ 23)))
                           (EXIT
                            (SPADCALL
                             (|TRMANIP;supexp| |num| |g1| |g2|
                              (LETT |b|
                                    (QUOTIENT2 (SPADCALL |num| (QREFELT $ 159))
                                               2))
                              $)
                             (|TRMANIP;supexp| |den| |g1| |g2| |b| $)
                             (QREFELT $ 26)))))
                         (#4#
                          (SPADCALL
                           (|TRMANIP;sup2htrigs| |num|
                            (LETT |g1| (SPADCALL |op| |arg| (QREFELT $ 65))) $)
                           (|TRMANIP;sup2htrigs| |den| |g1| $)
                           (QREFELT $ 26)))))))))))) 

(SDEFUN |TRMANIP;supexp|
        ((|p|
          (|SparseUnivariatePolynomial|
           (|SparseMultivariatePolynomial| R (|Kernel| F))))
         (|f1| (F)) (|f2| (F)) (|bse| (|Integer|)) ($ (F)))
        (SPROG ((|ans| (F)) (|d| (|Integer|)) (|g| (F)))
               (SEQ (LETT |ans| (|spadConstant| $ 37))
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL |p| (|spadConstant| $ 161)
                                      (QREFELT $ 162)))
                           (GO G191)))
                         (SEQ
                          (LETT |g|
                                (SPADCALL
                                 (SPADCALL (SPADCALL |p| (QREFELT $ 163))
                                           (QREFELT $ 84))
                                 (QREFELT $ 150)))
                          (SEQ
                           (LETT |d| (- (SPADCALL |p| (QREFELT $ 159)) |bse|))
                           (EXIT
                            (COND
                             ((>= |d| 0)
                              (LETT |ans|
                                    (SPADCALL |ans|
                                              (SPADCALL |g|
                                                        (SPADCALL |f1| |d|
                                                                  (QREFELT $
                                                                           51))
                                                        (QREFELT $ 21))
                                              (QREFELT $ 22))))
                             ('T
                              (LETT |ans|
                                    (SPADCALL |ans|
                                              (SPADCALL |g|
                                                        (SPADCALL |f2| (- |d|)
                                                                  (QREFELT $
                                                                           51))
                                                        (QREFELT $ 21))
                                              (QREFELT $ 22)))))))
                          (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 164)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |ans|)))) 

(SDEFUN |TRMANIP;sup2htrigs|
        ((|p|
          (|SparseUnivariatePolynomial|
           (|SparseMultivariatePolynomial| R (|Kernel| F))))
         (|f| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL (CONS (|function| |TRMANIP;smp2htrigs|) $) |p|
                   (QREFELT $ 168))
         |f| (QREFELT $ 169))) 

(SDEFUN |TRMANIP;exlog|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| F))) ($ (F)))
        (SPROG
         ((#1=#:G986 NIL) (#2=#:G985 (F)) (#3=#:G987 (F)) (#4=#:G989 NIL)
          (|r| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |r| NIL)
                (LETT #4#
                      (SPADCALL (SPADCALL |p| (QREFELT $ 171))
                                (QREFELT $ 176)))
                G190
                (COND
                 ((OR (ATOM #4#) (PROGN (LETT |r| (CAR #4#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #3#
                         (SPADCALL (QCAR |r|)
                                   (SPADCALL
                                    (SPADCALL (QCDR |r|) (QREFELT $ 84))
                                    (QREFELT $ 52))
                                   (QREFELT $ 104)))
                   (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 22))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 37))))))) 

(SDEFUN |TRMANIP;logexpand| ((|k| (|Kernel| F)) ($ (F)))
        (SPROG
         ((#1=#:G996 NIL) (#2=#:G995 NIL) (|x| (F)) (|op| (|BasicOperator|)))
         (SEQ
          (COND
           ((SPADCALL (LETT |op| (SPADCALL |k| (QREFELT $ 63)))
                      (QREFELT $ 177))
            (SPADCALL |k| (QREFELT $ 149)))
           ((SPADCALL |op| '|log| (QREFELT $ 153))
            (SPADCALL
             (|TRMANIP;exlog|
              (SPADCALL
               (LETT |x|
                     (SPADCALL (|SPADfirst| (SPADCALL |k| (QREFELT $ 45)))
                               (QREFELT $ 142)))
               (QREFELT $ 80))
              $)
             (|TRMANIP;exlog| (SPADCALL |x| (QREFELT $ 85)) $) (QREFELT $ 23)))
           ('T
            (SPADCALL |op|
                      (PROGN
                       (LETT #2# NIL)
                       (SEQ (LETT #1# (SPADCALL |k| (QREFELT $ 45))) G190
                            (COND
                             ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #2#
                                    (CONS (SPADCALL |x| (QREFELT $ 142))
                                          #2#))))
                            (LETT #1# (CDR #1#)) (GO G190) G191
                            (EXIT (NREVERSE #2#))))
                      (QREFELT $ 65))))))) 

(SDEFUN |TRMANIP;kerexpand| ((|k| (|Kernel| F)) ($ (F)))
        (SPROG
         ((#1=#:G1019 NIL) (#2=#:G1018 NIL) (#3=#:G1017 NIL) (#4=#:G1016 NIL)
          (|ctb| (F)) (|cta| (F)) (|tb| (F)) (|ta| (F)) (|a| (F)) (|b| (F))
          (|den| (|SparseMultivariatePolynomial| R (|Kernel| F)))
          (|num| (|SparseMultivariatePolynomial| R (|Kernel| F))) (|x| (F))
          (|arg| (F)) (|op| (|BasicOperator|)))
         (SEQ
          (COND
           ((SPADCALL (LETT |op| (SPADCALL |k| (QREFELT $ 63)))
                      (QREFELT $ 177))
            (SPADCALL |k| (QREFELT $ 149)))
           ((SPADCALL |op| '|%power| (QREFELT $ 153))
            (|TRMANIP;expandpow| |k| (ELT $ 143) $))
           (#5='T
            (SEQ (LETT |arg| (|SPADfirst| (SPADCALL |k| (QREFELT $ 45))))
                 (EXIT
                  (COND
                   ((SPADCALL |op| '|sec| (QREFELT $ 153))
                    (SPADCALL
                     (SPADCALL (SPADCALL |arg| (QREFELT $ 19)) (QREFELT $ 143))
                     (QREFELT $ 108)))
                   ((SPADCALL |op| '|csc| (QREFELT $ 153))
                    (SPADCALL
                     (SPADCALL (SPADCALL |arg| (QREFELT $ 20)) (QREFELT $ 143))
                     (QREFELT $ 108)))
                   ((SPADCALL |op| '|log| (QREFELT $ 153))
                    (SPADCALL
                     (|TRMANIP;exlog|
                      (SPADCALL (LETT |x| (SPADCALL |arg| (QREFELT $ 143)))
                                (QREFELT $ 80))
                      $)
                     (|TRMANIP;exlog| (SPADCALL |x| (QREFELT $ 85)) $)
                     (QREFELT $ 23)))
                   (#5#
                    (SEQ (LETT |num| (SPADCALL |arg| (QREFELT $ 80)))
                         (LETT |den| (SPADCALL |arg| (QREFELT $ 85)))
                         (EXIT
                          (COND
                           ((SPADCALL
                             (LETT |b|
                                   (SPADCALL (SPADCALL |num| (QREFELT $ 178))
                                             |den| (QREFELT $ 179)))
                             (|spadConstant| $ 37) (QREFELT $ 180))
                            (SEQ
                             (LETT |a|
                                   (SPADCALL (SPADCALL |num| (QREFELT $ 181))
                                             |den| (QREFELT $ 179)))
                             (EXIT
                              (COND
                               ((SPADCALL |op| '|exp| (QREFELT $ 153))
                                (SPADCALL
                                 (SPADCALL (SPADCALL |a| (QREFELT $ 143))
                                           (QREFELT $ 101))
                                 (SPADCALL (SPADCALL |b| (QREFELT $ 101))
                                           (QREFELT $ 143))
                                 (QREFELT $ 21)))
                               ((SPADCALL |op| '|sin| (QREFELT $ 153))
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |a| (QREFELT $ 143))
                                            (QREFELT $ 20))
                                  (SPADCALL (SPADCALL |b| (QREFELT $ 19))
                                            (QREFELT $ 143))
                                  (QREFELT $ 21))
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |a| (QREFELT $ 143))
                                            (QREFELT $ 19))
                                  (SPADCALL (SPADCALL |b| (QREFELT $ 20))
                                            (QREFELT $ 143))
                                  (QREFELT $ 21))
                                 (QREFELT $ 22)))
                               ((SPADCALL |op| '|cos| (QREFELT $ 153))
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |a| (QREFELT $ 143))
                                            (QREFELT $ 19))
                                  (SPADCALL (SPADCALL |b| (QREFELT $ 19))
                                            (QREFELT $ 143))
                                  (QREFELT $ 21))
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |a| (QREFELT $ 143))
                                            (QREFELT $ 20))
                                  (SPADCALL (SPADCALL |b| (QREFELT $ 20))
                                            (QREFELT $ 143))
                                  (QREFELT $ 21))
                                 (QREFELT $ 23)))
                               ((SPADCALL |op| '|tan| (QREFELT $ 153))
                                (SEQ
                                 (LETT |ta|
                                       (SPADCALL (SPADCALL |a| (QREFELT $ 143))
                                                 (QREFELT $ 122)))
                                 (LETT |tb|
                                       (SPADCALL (SPADCALL |b| (QREFELT $ 122))
                                                 (QREFELT $ 143)))
                                 (EXIT
                                  (SPADCALL (SPADCALL |ta| |tb| (QREFELT $ 22))
                                            (SPADCALL (|spadConstant| $ 38)
                                                      (SPADCALL |ta| |tb|
                                                                (QREFELT $ 21))
                                                      (QREFELT $ 23))
                                            (QREFELT $ 26)))))
                               ((SPADCALL |op| '|cot| (QREFELT $ 153))
                                (SEQ
                                 (LETT |cta|
                                       (SPADCALL (SPADCALL |a| (QREFELT $ 143))
                                                 (QREFELT $ 120)))
                                 (LETT |ctb|
                                       (SPADCALL (SPADCALL |b| (QREFELT $ 120))
                                                 (QREFELT $ 143)))
                                 (EXIT
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL |cta| |ctb| (QREFELT $ 21))
                                    (|spadConstant| $ 38) (QREFELT $ 23))
                                   (SPADCALL |ctb| |cta| (QREFELT $ 22))
                                   (QREFELT $ 26)))))
                               (#5#
                                (SPADCALL |op|
                                          (PROGN
                                           (LETT #4# NIL)
                                           (SEQ
                                            (LETT #3#
                                                  (SPADCALL |k|
                                                            (QREFELT $ 45)))
                                            G190
                                            (COND
                                             ((OR (ATOM #3#)
                                                  (PROGN
                                                   (LETT |x| (CAR #3#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #4#
                                                    (CONS
                                                     (SPADCALL |x|
                                                               (QREFELT $ 143))
                                                     #4#))))
                                            (LETT #3# (CDR #3#)) (GO G190) G191
                                            (EXIT (NREVERSE #4#))))
                                          (QREFELT $ 65)))))))
                           (#5#
                            (SPADCALL |op|
                                      (PROGN
                                       (LETT #2# NIL)
                                       (SEQ
                                        (LETT #1#
                                              (SPADCALL |k| (QREFELT $ 45)))
                                        G190
                                        (COND
                                         ((OR (ATOM #1#)
                                              (PROGN (LETT |x| (CAR #1#)) NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #2#
                                                (CONS
                                                 (SPADCALL |x| (QREFELT $ 143))
                                                 #2#))))
                                        (LETT #1# (CDR #1#)) (GO G190) G191
                                        (EXIT (NREVERSE #2#))))
                                      (QREFELT $ 65))))))))))))))) 

(SDEFUN |TRMANIP;smpexp|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| F))) ($ (F)))
        (SPROG ((|ans| (F)))
               (SEQ (LETT |ans| (|spadConstant| $ 37))
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL |p| (|spadConstant| $ 182)
                                      (QREFELT $ 183)))
                           (GO G191)))
                         (SEQ
                          (LETT |ans|
                                (SPADCALL |ans|
                                          (|TRMANIP;termexp|
                                           (SPADCALL |p| (QREFELT $ 181)) $)
                                          (QREFELT $ 22)))
                          (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 178)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |ans|)))) 

(SDEFUN |TRMANIP;simplify0| ((|x| (F)) ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL |x|
                    (LIST '|tan| '|cot| '|sec| '|csc| '|tanh| '|coth| '|sech|
                          '|csch|)
                    (LIST (CONS (|function| |TRMANIP;t2t|) $)
                          (CONS (|function| |TRMANIP;c2t|) $)
                          (CONS (|function| |TRMANIP;s2c|) $)
                          (CONS (|function| |TRMANIP;c2s|) $)
                          (CONS (|function| |TRMANIP;th2th|) $)
                          (CONS (|function| |TRMANIP;ch2th|) $)
                          (CONS (|function| |TRMANIP;sh2ch|) $)
                          (CONS (|function| |TRMANIP;ch2sh|) $))
                    (QREFELT $ 186))
          (LIST '|sin| '|sinh|) (LIST 2 2)
          (LIST (CONS (|function| |TRMANIP;s2c2|) $)
                (CONS (|function| |TRMANIP;sh2ch2|) $))
          (QREFELT $ 188))
         (QREFELT $ 96))) 

(DECLAIM (NOTINLINE |TranscendentalManipulations;|)) 

(DEFUN |TranscendentalManipulations| (&REST #1=#:G1064)
  (SPROG NIL
         (PROG (#2=#:G1065)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|TranscendentalManipulations|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |TranscendentalManipulations;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|TranscendentalManipulations|)))))))))) 

(DEFUN |TranscendentalManipulations;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|TranscendentalManipulations| DV$1 DV$2))
          (LETT $ (GETREFV 189))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (AND
                                               (|HasCategory| |#1|
                                                              (LIST
                                                               '|ConvertibleTo|
                                                               (LIST '|Pattern|
                                                                     (|devaluate|
                                                                      |#1|))))
                                               (|HasCategory| |#1|
                                                              (LIST
                                                               '|PatternMatchable|
                                                               (|devaluate|
                                                                |#1|)))
                                               (|HasCategory| |#2|
                                                              (LIST
                                                               '|ConvertibleTo|
                                                               (LIST '|Pattern|
                                                                     (|devaluate|
                                                                      |#1|))))
                                               (|HasCategory| |#2|
                                                              (LIST
                                                               '|PatternMatchable|
                                                               (|devaluate|
                                                                |#1|))))))))
          (|haddProp| |$ConstructorCache| '|TranscendentalManipulations|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 13
                    (SPADCALL (SPADCALL '|exp| (QREFELT $ 11)) (QREFELT $ 12)))
          (QSETREFV $ 14
                    (SPADCALL (SPADCALL '|log| (QREFELT $ 11)) (QREFELT $ 12)))
          (COND
           ((|HasCategory| |#1| (LIST '|PatternMatchable| (|devaluate| |#1|)))
            (COND
             ((|HasCategory| |#1|
                             (LIST '|ConvertibleTo|
                                   (LIST '|Pattern| (|devaluate| |#1|))))
              (COND
               ((|HasCategory| |#2|
                               (LIST '|ConvertibleTo|
                                     (LIST '|Pattern| (|devaluate| |#1|))))
                (COND
                 ((|HasCategory| |#2|
                                 (LIST '|PatternMatchable| (|devaluate| |#1|)))
                  (PROGN
                   (QSETREFV $ 17
                             (SPADCALL (SPADCALL (QREFELT $ 15))
                                       (QREFELT $ 16)))
                   (QSETREFV $ 18
                             (SPADCALL (SPADCALL (QREFELT $ 15))
                                       (QREFELT $ 16)))
                   (QSETREFV $ 29
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL (QREFELT $ 17) (QREFELT $ 19))
                               (SPADCALL (QREFELT $ 18) (QREFELT $ 20))
                               (QREFELT $ 21))
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (QREFELT $ 17) (QREFELT $ 18)
                                           (QREFELT $ 22))
                                 (QREFELT $ 20))
                                (SPADCALL
                                 (SPADCALL (QREFELT $ 17) (QREFELT $ 18)
                                           (QREFELT $ 23))
                                 (QREFELT $ 20))
                                (QREFELT $ 23))
                               (SPADCALL 2 (QREFELT $ 25)) (QREFELT $ 26))
                              (QREFELT $ 28)))
                   (QSETREFV $ 30
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL (QREFELT $ 17) (QREFELT $ 20))
                               (SPADCALL (QREFELT $ 18) (QREFELT $ 20))
                               (QREFELT $ 21))
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (QREFELT $ 17) (QREFELT $ 18)
                                           (QREFELT $ 23))
                                 (QREFELT $ 19))
                                (SPADCALL
                                 (SPADCALL (QREFELT $ 17) (QREFELT $ 18)
                                           (QREFELT $ 22))
                                 (QREFELT $ 19))
                                (QREFELT $ 23))
                               (SPADCALL 2 (QREFELT $ 25)) (QREFELT $ 26))
                              (QREFELT $ 28)))
                   (QSETREFV $ 31
                             (SPADCALL
                              (SPADCALL
                               (SPADCALL (QREFELT $ 17) (QREFELT $ 19))
                               (SPADCALL (QREFELT $ 18) (QREFELT $ 19))
                               (QREFELT $ 21))
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (QREFELT $ 17) (QREFELT $ 18)
                                           (QREFELT $ 23))
                                 (QREFELT $ 19))
                                (SPADCALL
                                 (SPADCALL (QREFELT $ 17) (QREFELT $ 18)
                                           (QREFELT $ 22))
                                 (QREFELT $ 19))
                                (QREFELT $ 22))
                               (SPADCALL 2 (QREFELT $ 25)) (QREFELT $ 26))
                              (QREFELT $ 28)))
                   (QSETREFV $ 36
                             (CONS
                              (|dispatchFunction|
                               |TRMANIP;expandTrigProducts;2F;1|)
                              $)))))))))))
          (COND
           ((|HasCategory| |#1| '(|RetractableTo| (|Integer|)))
            (QSETREFV $ 77
                      (CONS (|dispatchFunction| |TRMANIP;simplify;2F;5|) $)))
           ('T
            (QSETREFV $ 77
                      (CONS (|dispatchFunction| |TRMANIP;simplify;2F;6|) $))))
          $))) 

(MAKEPROP '|TranscendentalManipulations| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|BasicOperator|) (|Symbol|) (|CommonOperators|) (0 . |operator|)
              (5 . |operator|) '|opexp| '|oplog| (10 . |new|) (14 . |coerce|)
              'XX 'YY (19 . |cos|) (24 . |sin|) (29 . *) (35 . +) (41 . -)
              (|Integer|) (47 . |coerce|) (52 . /) (|RewriteRule| 6 6 7)
              (58 . |rule|) '|sinCosRule| '|sinSinRule| '|cosCosRule|
              (|List| 27) (|PositiveInteger|) (|ApplyRules| 6 6 7)
              (64 . |applyRules|) (71 . |expandTrigProducts|) (76 . |Zero|)
              (80 . |One|) (|Boolean|) (84 . |is?|) (|List| 70)
              (90 . |kernels|) (|List| 7) (|Kernel| 7) (95 . |argument|)
              |TRMANIP;simplifyLog;2F;3|
              (|Record| (|:| |coef| 24) (|:| |var| 70))
              (|Union| 47 '#1="failed") (100 . |isMult|) (105 . |is?|)
              (111 . ^) (117 . |log|) (122 . |numerator|) (127 . |denominator|)
              (132 . |freeOf?|) (138 . |is?|) (|Union| 64 '#1#)
              (144 . |isTimes|) (149 . |isPlus|)
              (|Record| (|:| |val| $) (|:| |exponent| 24)) (|Union| 60 '#1#)
              (154 . |isPower|) (159 . |operator|) (|List| $) (164 . |elt|)
              (|Union| (|Fraction| (|Polynomial| 6)) '"failed")
              (170 . |retractIfCan|) (175 . |One|) (179 . |elt|) (|Kernel| $)
              (185 . |retract|) (190 . ^) (196 . |setelt!|) (203 . |append|)
              (|AlgebraicManipulations| 6 7) (209 . |rootProduct|)
              (214 . |simplify|) (219 . |second|)
              (|SparseMultivariatePolynomial| 6 70) (224 . |numer|)
              (|SparseMultivariatePolynomial| 6 44) (229 . |One|) (233 . =)
              (239 . |coerce|) (244 . |denom|) (249 . -) (|List| 44)
              (254 . |variables|) (259 . |leadingCoefficient|) (264 . |coerce|)
              (|Mapping| 39 44) (269 . |select|) (|NonNegativeInteger|)
              (275 . |degree|) (281 . *) |TRMANIP;simplifyExp;2F;48|
              (287 . |height|) (292 . |kernel|) (299 . |monomial|) (306 . *)
              (312 . |exp|) |TRMANIP;expandPower;2F;9| (317 . |eval|) (324 . *)
              (330 . |first|) (335 . =) (341 . |setDifference|) (347 . |inv|)
              (352 . |sinh|) (357 . |cosh|) (|Mapping| $ $) (362 . |eval|)
              (369 . |eval|) (377 . |sec|) |TRMANIP;cos2sec;2F;23|
              (382 . |csc|) |TRMANIP;sin2csc;2F;24| |TRMANIP;csc2sin;2F;25|
              |TRMANIP;sec2cos;2F;26| (387 . |cot|) |TRMANIP;tan2cot;2F;27|
              (392 . |tan|) |TRMANIP;cot2tan;2F;28| |TRMANIP;tan2trig;2F;29|
              |TRMANIP;cot2trig;2F;30| (397 . |sech|) |TRMANIP;cosh2sech;2F;31|
              (402 . |csch|) |TRMANIP;sinh2csch;2F;32|
              |TRMANIP;csch2sinh;2F;33| |TRMANIP;sech2cosh;2F;34|
              (407 . |coth|) |TRMANIP;tanh2coth;2F;35| (412 . |tanh|)
              |TRMANIP;coth2tanh;2F;36| |TRMANIP;tanh2trigh;2F;37|
              |TRMANIP;coth2trigh;2F;38| |TRMANIP;removeCosSq;2F;39|
              |TRMANIP;removeSinSq;2F;40| |TRMANIP;removeCoshSq;2F;41|
              |TRMANIP;removeSinhSq;2F;42| |TRMANIP;expandLog;2F;43|
              |TRMANIP;expand;2F;44| (417 . |coerce|) (|Mapping| 7 44)
              (|Mapping| 7 6)
              (|PolynomialCategoryLifting| (|IndexedExponents| 44) 44 6 81 7)
              (422 . |map|) (429 . |coerce|) |TRMANIP;htrigs;2F;49|
              (434 . |monomial?|) (439 . =) (445 . |is?|)
              (|Union| 70 '"failed") (451 . |mainKernel|)
              (|SparseUnivariatePolynomial| $) (456 . |univariate|)
              (|SparseUnivariatePolynomial| 81) (462 . |degree|) (467 . |Zero|)
              (471 . |Zero|) (475 . ~=) (481 . |leadingCoefficient|)
              (486 . |reductum|) (|SparseUnivariatePolynomial| 7)
              (|Mapping| 7 81) (|SparseUnivariatePolynomialFunctions2| 81 7)
              (491 . |map|) (497 . |elt|) (|Factored| $) (503 . |squareFree|)
              (|Record| (|:| |coef| 93) (|:| |logand| 81)) (|List| 172)
              (|Factored| 81) (|FactoredFunctions| 81) (508 . |log|)
              (513 . |nullary?|) (518 . |reductum|) (523 . /) (529 . ~=)
              (535 . |leadingMonomial|) (540 . |Zero|) (544 . ~=) (|List| 9)
              (|List| 111) (550 . |eval|) (|List| 93) (557 . |eval|))
           '#(|tanh2trigh| 565 |tanh2coth| 570 |tan2trig| 575 |tan2cot| 580
              |sinh2csch| 585 |sin2csc| 590 |simplifyLog| 595 |simplifyExp| 600
              |simplify| 605 |sech2cosh| 610 |sec2cos| 615 |removeSinhSq| 620
              |removeSinSq| 625 |removeCoshSq| 630 |removeCosSq| 635 |htrigs|
              640 |expandTrigProducts| 645 |expandPower| 650 |expandLog| 655
              |expand| 660 |csch2sinh| 665 |csc2sin| 670 |coth2trigh| 675
              |coth2tanh| 680 |cot2trig| 685 |cot2tan| 690 |cosh2sech| 695
              |cos2sec| 700)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|expand| (|#2| |#2|)) T)
                                   '((|simplify| (|#2| |#2|)) T)
                                   '((|htrigs| (|#2| |#2|)) T)
                                   '((|simplifyExp| (|#2| |#2|)) T)
                                   '((|simplifyLog| (|#2| |#2|)) T)
                                   '((|expandPower| (|#2| |#2|)) T)
                                   '((|expandLog| (|#2| |#2|)) T)
                                   '((|cos2sec| (|#2| |#2|)) T)
                                   '((|cosh2sech| (|#2| |#2|)) T)
                                   '((|cot2trig| (|#2| |#2|)) T)
                                   '((|coth2trigh| (|#2| |#2|)) T)
                                   '((|csc2sin| (|#2| |#2|)) T)
                                   '((|csch2sinh| (|#2| |#2|)) T)
                                   '((|sec2cos| (|#2| |#2|)) T)
                                   '((|sech2cosh| (|#2| |#2|)) T)
                                   '((|sin2csc| (|#2| |#2|)) T)
                                   '((|sinh2csch| (|#2| |#2|)) T)
                                   '((|tan2trig| (|#2| |#2|)) T)
                                   '((|tanh2trigh| (|#2| |#2|)) T)
                                   '((|tan2cot| (|#2| |#2|)) T)
                                   '((|tanh2coth| (|#2| |#2|)) T)
                                   '((|cot2tan| (|#2| |#2|)) T)
                                   '((|coth2tanh| (|#2| |#2|)) T)
                                   '((|removeCosSq| (|#2| |#2|)) T)
                                   '((|removeSinSq| (|#2| |#2|)) T)
                                   '((|removeCoshSq| (|#2| |#2|)) T)
                                   '((|removeSinhSq| (|#2| |#2|)) T)
                                   '((|expandTrigProducts| (|#2| |#2|))
                                     (AND (|has| 7 (|PatternMatchable| 6))
                                          (|has| 7
                                                 (|ConvertibleTo|
                                                  (|Pattern| 6)))
                                          (|has| 6
                                                 (|ConvertibleTo|
                                                  (|Pattern| 6)))
                                          (|has| 6 (|PatternMatchable| 6)))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 188
                                            '(1 10 8 9 11 1 7 8 8 12 0 9 0 15 1
                                              7 0 9 16 1 7 0 0 19 1 7 0 0 20 2
                                              7 0 0 0 21 2 7 0 0 0 22 2 7 0 0 0
                                              23 1 7 0 24 25 2 7 0 0 0 26 2 27
                                              0 7 7 28 3 34 7 32 7 33 35 1 0 7
                                              7 36 0 7 0 37 0 7 0 38 2 7 39 0 9
                                              40 1 7 41 0 42 1 44 43 0 45 1 7
                                              48 0 49 2 44 39 0 9 50 2 7 0 0 24
                                              51 1 7 0 0 52 1 7 0 0 53 1 7 0 0
                                              54 2 7 39 0 9 55 2 44 39 0 8 56 1
                                              7 57 0 58 1 7 57 0 59 1 7 61 0 62
                                              1 44 8 0 63 2 7 0 8 64 65 1 7 66
                                              0 67 0 6 0 68 2 43 7 0 24 69 1 7
                                              70 0 71 2 7 0 0 0 72 3 43 7 0 24
                                              7 73 2 43 0 0 0 74 1 75 7 7 76 1
                                              0 7 7 77 1 43 7 0 78 1 7 79 0 80
                                              0 81 0 82 2 81 39 0 0 83 1 7 0 79
                                              84 1 7 79 0 85 1 7 0 0 86 1 81 87
                                              0 88 1 81 6 0 89 1 81 0 6 90 2 87
                                              0 91 0 92 2 81 93 0 44 94 2 7 0
                                              93 0 95 1 44 93 0 97 3 44 0 8 43
                                              93 98 3 81 0 0 44 93 99 2 81 0 0
                                              0 100 1 7 0 0 101 3 7 0 0 41 64
                                              103 2 7 0 24 0 104 1 43 7 0 105 2
                                              7 39 0 0 106 2 87 0 0 0 107 1 7 0
                                              0 108 1 7 0 0 109 1 7 0 0 110 3 7
                                              0 0 9 111 112 4 7 0 0 9 93 111
                                              113 1 7 0 0 114 1 7 0 0 116 1 7 0
                                              0 120 1 7 0 0 122 1 7 0 0 126 1 7
                                              0 0 128 1 7 0 0 132 1 7 0 0 134 1
                                              7 0 6 144 3 147 7 145 146 81 148
                                              1 7 0 70 149 1 81 39 0 151 2 8 39
                                              0 0 152 2 8 39 0 9 153 1 7 154 0
                                              155 2 81 156 0 44 157 1 158 93 0
                                              159 0 6 0 160 0 158 0 161 2 158
                                              39 0 0 162 1 158 81 0 163 1 158 0
                                              0 164 2 167 165 166 158 168 2 165
                                              7 0 7 169 1 81 170 0 171 1 175
                                              173 174 176 1 8 39 0 177 1 81 0 0
                                              178 2 7 0 79 79 179 2 7 39 0 0
                                              180 1 81 0 0 181 0 81 0 182 2 81
                                              39 0 0 183 3 7 0 0 184 185 186 4
                                              7 0 0 184 187 185 188 1 0 7 7 136
                                              1 0 7 7 133 1 0 7 7 124 1 0 7 7
                                              121 1 0 7 7 129 1 0 7 7 117 1 0 7
                                              7 46 1 0 7 7 96 1 0 7 7 77 1 0 7
                                              7 131 1 0 7 7 119 1 0 7 7 141 1 0
                                              7 7 139 1 0 7 7 140 1 0 7 7 138 1
                                              0 7 7 150 1 1 7 7 36 1 0 7 7 102
                                              1 0 7 7 142 1 0 7 7 143 1 0 7 7
                                              130 1 0 7 7 118 1 0 7 7 137 1 0 7
                                              7 135 1 0 7 7 125 1 0 7 7 123 1 0
                                              7 7 127 1 0 7 7 115)))))
           '|lookupComplete|)) 
