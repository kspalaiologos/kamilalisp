
(SDEFUN |MLIFT;corrPoly;SupLLLLMU;1|
        ((|m| (|SparseUnivariatePolynomial| P)) (|lvar| (|List| OV))
         (|fval| (|List| R)) (|ld| (|List| (|NonNegativeInteger|)))
         (|flist| (|List| (|SparseUnivariatePolynomial| P)))
         (|bsolv|
          (|Mapping|
           (|Union| (|List| (|SparseUnivariatePolynomial| R)) #1="failed")
           (|SparseUnivariatePolynomial| R)))
         ($ (|Union| (|List| (|SparseUnivariatePolynomial| P)) "failed")))
        (SPROG
         ((|diff| (|SparseUnivariatePolynomial| P)) (#2=#:G775 NIL)
          (#3=#:G774 #4=(|SparseUnivariatePolynomial| P)) (#5=#:G776 #4#)
          (#6=#:G795 NIL) (|i| NIL)
          (|lcoef| (|List| (|SparseUnivariatePolynomial| P))) (#7=#:G794 NIL)
          (#8=#:G793 NIL) (|beta| (|List| (|SparseUnivariatePolynomial| P)))
          (#9=#:G783 NIL)
          (|fbeta|
           #10=(|Union| (|List| (|SparseUnivariatePolynomial| P)) "failed"))
          (|ddiff| #11=(|SparseUnivariatePolynomial| P))
          (|pol| (|SparseUnivariatePolynomial| P)) (#12=#:G792 NIL) (|l| NIL)
          (#13=#:G741 NIL) (#14=#:G740 #4#) (#15=#:G742 #4#) (#16=#:G791 NIL)
          (|polc| (|SparseUnivariatePolynomial| P))
          (|listcong| (|List| (|SparseUnivariatePolynomial| P)))
          (#17=#:G729 NIL) (#18=#:G728 #19=(|SparseUnivariatePolynomial| P))
          (#20=#:G730 #19#) (#21=#:G790 NIL) (#22=#:G789 NIL) (#23=#:G788 NIL)
          (|flcoef| #10#) (|um| #11#)
          (|listpolv| (|List| (|SparseUnivariatePolynomial| P)))
          (#24=#:G787 NIL) (|f1| NIL) (#25=#:G786 NIL) (|y| (OV)) (|a| (P))
          (|np| (|NonNegativeInteger|)) (|deg1| (|NonNegativeInteger|))
          (#26=#:G785 NIL) (|mp| NIL) (#27=#:G784 NIL)
          (|lp| (|Union| (|List| (|SparseUnivariatePolynomial| R)) #1#)))
         (SEQ
          (EXIT
           (COND
            ((EQL (LENGTH |lvar|) 0)
             (SEQ
              (LETT |lp|
                    (SPADCALL (SPADCALL (ELT $ 10) |m| (QREFELT $ 15))
                              |bsolv|))
              (COND
               ((QEQCAR |lp| 1)
                (PROGN (LETT #9# (CONS 1 "failed")) (GO #28=#:G782))))
              (EXIT
               (LETT |lcoef|
                     (CONS 0
                           (PROGN
                            (LETT #27# NIL)
                            (SEQ (LETT |mp| NIL) (LETT #26# (QCDR |lp|)) G190
                                 (COND
                                  ((OR (ATOM #26#)
                                       (PROGN (LETT |mp| (CAR #26#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #27#
                                         (CONS
                                          (SPADCALL (ELT $ 16) |mp|
                                                    (QREFELT $ 19))
                                          #27#))))
                                 (LETT #26# (CDR #26#)) (GO G190) G191
                                 (EXIT (NREVERSE #27#)))))))))
            (#29='T
             (SEQ (LETT |deg1| (|SPADfirst| |ld|)) (LETT |np| (LENGTH |flist|))
                  (LETT |a| (SPADCALL (|SPADfirst| |fval|) (QREFELT $ 16)))
                  (LETT |y| (|SPADfirst| |lvar|)) (LETT |lvar| (CDR |lvar|))
                  (LETT |listpolv|
                        (PROGN
                         (LETT #25# NIL)
                         (SEQ (LETT |f1| NIL) (LETT #24# |flist|) G190
                              (COND
                               ((OR (ATOM #24#)
                                    (PROGN (LETT |f1| (CAR #24#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #25#
                                      (CONS
                                       (SPADCALL
                                        (CONS #'|MLIFT;corrPoly;SupLLLLMU;1!0|
                                              (VECTOR $ |a| |y|))
                                        |f1| (QREFELT $ 22))
                                       #25#))))
                              (LETT #24# (CDR #24#)) (GO G190) G191
                              (EXIT (NREVERSE #25#)))))
                  (LETT |um|
                        (SPADCALL
                         (CONS #'|MLIFT;corrPoly;SupLLLLMU;1!1|
                               (VECTOR $ |a| |y|))
                         |m| (QREFELT $ 22)))
                  (LETT |flcoef|
                        (SPADCALL |um| |lvar| (CDR |fval|) (CDR |ld|)
                                  |listpolv| |bsolv| (QREFELT $ 30)))
                  (COND
                   ((QEQCAR |flcoef| 1)
                    (PROGN (LETT #9# (CONS 1 "failed")) (GO #28#)))
                   (#29# (LETT |lcoef| (QCDR |flcoef|))))
                  (LETT |listcong|
                        (PROGN
                         (LETT #23# NIL)
                         (SEQ (LETT |l| 1) (LETT #22# |np|) G190
                              (COND ((|greater_SI| |l| #22#) (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #23#
                                      (CONS
                                       (PROGN
                                        (LETT #17# NIL)
                                        (SEQ (LETT |i| 1) (LETT #21# |np|) G190
                                             (COND
                                              ((|greater_SI| |i| #21#)
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (COND
                                                ((SPADCALL |i| |l|
                                                           (QREFELT $ 33))
                                                 (PROGN
                                                  (LETT #20#
                                                        (SPADCALL |flist| |i|
                                                                  (QREFELT $
                                                                           35)))
                                                  (COND
                                                   (#17#
                                                    (LETT #18#
                                                          (SPADCALL #18# #20#
                                                                    (QREFELT $
                                                                             36))))
                                                   ('T
                                                    (PROGN
                                                     (LETT #18# #20#)
                                                     (LETT #17# 'T)))))))))
                                             (LETT |i| (|inc_SI| |i|))
                                             (GO G190) G191 (EXIT NIL))
                                        (COND (#17# #18#)
                                              ('T (|spadConstant| $ 37))))
                                       #23#))))
                              (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                              (EXIT (NREVERSE #23#)))))
                  (LETT |polc|
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 39) |y| 1 (QREFELT $ 40))
                          |a| (QREFELT $ 41))
                         (QREFELT $ 42)))
                  (LETT |pol| (|spadConstant| $ 37))
                  (LETT |diff|
                        (SPADCALL |m|
                                  (PROGN
                                   (LETT #13# NIL)
                                   (SEQ (LETT |i| 1) (LETT #16# |np|) G190
                                        (COND
                                         ((|greater_SI| |i| #16#) (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (PROGN
                                           (LETT #15#
                                                 (SPADCALL
                                                  (SPADCALL |lcoef| |i|
                                                            (QREFELT $ 35))
                                                  (SPADCALL |listcong| |i|
                                                            (QREFELT $ 35))
                                                  (QREFELT $ 36)))
                                           (COND
                                            (#13#
                                             (LETT #14#
                                                   (SPADCALL #14# #15#
                                                             (QREFELT $ 43))))
                                            ('T
                                             (PROGN
                                              (LETT #14# #15#)
                                              (LETT #13# 'T)))))))
                                        (LETT |i| (|inc_SI| |i|)) (GO G190)
                                        G191 (EXIT NIL))
                                   (COND (#13# #14#)
                                         (#29# (|spadConstant| $ 44))))
                                  (QREFELT $ 45)))
                  (SEQ (LETT |l| 1) (LETT #12# |deg1|) G190
                       (COND ((|greater_SI| |l| #12#) (GO G191)))
                       (SEQ
                        (COND
                         ((SPADCALL |diff| (|spadConstant| $ 44)
                                    (QREFELT $ 48))
                          (PROGN (LETT #9# (CONS 0 |lcoef|)) (GO #28#))))
                        (LETT |pol| (SPADCALL |pol| |polc| (QREFELT $ 36)))
                        (LETT |ddiff|
                              (SPADCALL
                               (CONS #'|MLIFT;corrPoly;SupLLLLMU;1!2|
                                     (VECTOR |a| $ |y| |l|))
                               |diff| (QREFELT $ 22)))
                        (EXIT
                         (COND
                          ((SPADCALL |ddiff| (|spadConstant| $ 44)
                                     (QREFELT $ 48))
                           "next l")
                          ('T
                           (SEQ
                            (LETT |fbeta|
                                  (SPADCALL |ddiff| |lvar| (CDR |fval|)
                                            (CDR |ld|) |listpolv| |bsolv|
                                            (QREFELT $ 30)))
                            (COND
                             ((QEQCAR |fbeta| 1)
                              (PROGN (LETT #9# (CONS 1 "failed")) (GO #28#)))
                             ('T (LETT |beta| (QCDR |fbeta|))))
                            (LETT |lcoef|
                                  (PROGN
                                   (LETT #8# NIL)
                                   (SEQ (LETT |i| 1) (LETT #7# |np|) G190
                                        (COND
                                         ((|greater_SI| |i| #7#) (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #8#
                                                (CONS
                                                 (SPADCALL
                                                  (SPADCALL |lcoef| |i|
                                                            (QREFELT $ 35))
                                                  (SPADCALL
                                                   (SPADCALL |beta| |i|
                                                             (QREFELT $ 35))
                                                   |pol| (QREFELT $ 36))
                                                  (QREFELT $ 43))
                                                 #8#))))
                                        (LETT |i| (|inc_SI| |i|)) (GO G190)
                                        G191 (EXIT (NREVERSE #8#)))))
                            (EXIT
                             (LETT |diff|
                                   (SPADCALL |diff|
                                             (SPADCALL
                                              (PROGN
                                               (LETT #2# NIL)
                                               (SEQ (LETT |i| 1)
                                                    (LETT #6# |np|) G190
                                                    (COND
                                                     ((|greater_SI| |i| #6#)
                                                      (GO G191)))
                                                    (SEQ
                                                     (EXIT
                                                      (PROGN
                                                       (LETT #5#
                                                             (SPADCALL
                                                              (SPADCALL
                                                               |listcong| |i|
                                                               (QREFELT $ 35))
                                                              (SPADCALL |beta|
                                                                        |i|
                                                                        (QREFELT
                                                                         $ 35))
                                                              (QREFELT $ 36)))
                                                       (COND
                                                        (#2#
                                                         (LETT #3#
                                                               (SPADCALL #3#
                                                                         #5#
                                                                         (QREFELT
                                                                          $
                                                                          43))))
                                                        ('T
                                                         (PROGN
                                                          (LETT #3# #5#)
                                                          (LETT #2# 'T)))))))
                                                    (LETT |i| (|inc_SI| |i|))
                                                    (GO G190) G191 (EXIT NIL))
                                               (COND (#2# #3#)
                                                     ('T
                                                      (|spadConstant| $ 44))))
                                              |pol| (QREFELT $ 36))
                                             (QREFELT $ 45)))))))))
                       (LETT |l| (|inc_SI| |l|)) (GO G190) G191 (EXIT NIL))
                  (EXIT (CONS 0 |lcoef|))))))
          #28# (EXIT #9#)))) 

(SDEFUN |MLIFT;corrPoly;SupLLLLMU;1!2| ((|p1| NIL) ($$ NIL))
        (PROG (|l| |y| $ |a|)
          (LETT |l| (QREFELT $$ 3))
          (LETT |y| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |a| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (|MLIFT;normalDerivM| |p1| |l| |y| $) |y| |a|
                      (QREFELT $ 20)))))) 

(SDEFUN |MLIFT;corrPoly;SupLLLLMU;1!1| ((|p1| NIL) ($$ NIL))
        (PROG (|y| |a| $)
          (LETT |y| (QREFELT $$ 2))
          (LETT |a| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |p1| |y| |a| (QREFELT $ 20)))))) 

(SDEFUN |MLIFT;corrPoly;SupLLLLMU;1!0| ((|p1| NIL) ($$ NIL))
        (PROG (|y| |a| $)
          (LETT |y| (QREFELT $$ 2))
          (LETT |a| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |p1| |y| |a| (QREFELT $ 20)))))) 

(SDEFUN |MLIFT;lifting1|
        ((|m| (|SparseUnivariatePolynomial| P)) (|lvar| #1=(|List| OV))
         (|plist| (|List| #2=(|SparseUnivariatePolynomial| P)))
         (|vlist| (|List| R)) (|tlist| #3=(|List| P))
         (|coeflist|
          #4=(|List|
              (|List|
               (|Record| (|:| |expt| (|NonNegativeInteger|))
                         (|:| |pcoef| P)))))
         (|listdeg| (|List| (|NonNegativeInteger|)))
         (|bsolv|
          (|Mapping|
           (|Union| (|List| (|SparseUnivariatePolynomial| R)) "failed")
           (|SparseUnivariatePolynomial| R)))
         ($ (|Union| (|List| (|SparseUnivariatePolynomial| P)) "failed")))
        (SPROG
         ((#5=#:G837 NIL) (|idegj| (|Integer|)) (#6=#:G856 NIL) (|term| NIL)
          (#7=#:G854 NIL) (#8=#:G855 NIL) (|alpha| NIL) (#9=#:G853 NIL)
          (|lalpha| #10=(|List| (|SparseUnivariatePolynomial| P)))
          (|flalpha|
           (|Union| (|List| (|SparseUnivariatePolynomial| P)) "failed"))
          (|mc| (|SparseUnivariatePolynomial| P)) (#11=#:G836 NIL)
          (#12=#:G817 NIL) (#13=#:G816 #2#) (#14=#:G818 #2#) (#15=#:G852 NIL)
          (|pol| (P)) (#16=#:G851 NIL) (|k| NIL) (|polc| (P))
          (|mj| (|SparseUnivariatePolynomial| P)) (#17=#:G849 NIL) (|tpol| NIL)
          (#18=#:G850 NIL) (|clist| NIL) (#19=#:G848 NIL) (#20=#:G846 NIL)
          (|p| NIL) (#21=#:G847 NIL) (|lcp| NIL) (#22=#:G845 NIL)
          (|clv|
           (|List|
            (|List|
             (|Record| (|:| |expt| (|NonNegativeInteger|)) (|:| |pcoef| P)))))
          (|tlv| (|List| P)) (|#G41| #4#) (|#G40| #3#) (#23=#:G844 NIL)
          (#24=#:G843 NIL) (#25=#:G842 NIL) (#26=#:G841 NIL) (#27=#:G840 NIL)
          (#28=#:G839 NIL) (|subsval| (|List| R)) (|subsvar| (|List| OV))
          (|ldeg| (|List| (|NonNegativeInteger|)))
          (|degj| (|NonNegativeInteger|)) (|v| (R)) (|conglist| #10#)
          (|li| #1#) (|x| (OV)) (#29=#:G838 NIL) (|j| NIL)
          (|testp| (|Boolean|)) (|nvar| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |conglist| NIL) (LETT |nvar| (LENGTH |lvar|))
                (LETT |testp| (NULL (NULL |tlist|))) (LETT |lalpha| NIL)
                (LETT |tlv| NIL) (LETT |subsvar| NIL) (LETT |subsval| NIL)
                (LETT |li| |lvar|) (LETT |ldeg| NIL) (LETT |clv| NIL)
                (SEQ (LETT |j| 1) (LETT #29# |nvar|) G190
                     (COND ((|greater_SI| |j| #29#) (GO G191)))
                     (SEQ (LETT |x| (|SPADfirst| |li|)) (LETT |li| (CDR |li|))
                          (LETT |conglist| |plist|)
                          (LETT |v| (|SPADfirst| |vlist|))
                          (LETT |vlist| (CDR |vlist|))
                          (LETT |degj| (SPADCALL |listdeg| |j| (QREFELT $ 49)))
                          (LETT |ldeg| (CONS |degj| |ldeg|))
                          (LETT |subsvar| (CONS |x| |subsvar|))
                          (LETT |subsval| (CONS |v| |subsval|))
                          (COND
                           (|testp|
                            (SEQ
                             (COND
                              ((< |j| |nvar|)
                               (SEQ
                                (LETT |tlv|
                                      (PROGN
                                       (LETT #28# NIL)
                                       (SEQ (LETT |p| NIL) (LETT #27# |tlist|)
                                            G190
                                            (COND
                                             ((OR (ATOM #27#)
                                                  (PROGN
                                                   (LETT |p| (CAR #27#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #28#
                                                    (CONS
                                                     (SPADCALL |p| |li| |vlist|
                                                               (QREFELT $ 50))
                                                     #28#))))
                                            (LETT #27# (CDR #27#)) (GO G190)
                                            G191 (EXIT (NREVERSE #28#)))))
                                (EXIT
                                 (LETT |clv|
                                       (PROGN
                                        (LETT #26# NIL)
                                        (SEQ (LETT |clist| NIL)
                                             (LETT #25# |coeflist|) G190
                                             (COND
                                              ((OR (ATOM #25#)
                                                   (PROGN
                                                    (LETT |clist| (CAR #25#))
                                                    NIL))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (LETT #26#
                                                     (CONS
                                                      (PROGN
                                                       (LETT #24# NIL)
                                                       (SEQ (LETT |term| NIL)
                                                            (LETT #23# |clist|)
                                                            G190
                                                            (COND
                                                             ((OR (ATOM #23#)
                                                                  (PROGN
                                                                   (LETT |term|
                                                                         (CAR
                                                                          #23#))
                                                                   NIL))
                                                              (GO G191)))
                                                            (SEQ
                                                             (EXIT
                                                              (LETT #24#
                                                                    (CONS
                                                                     (CONS
                                                                      (QCAR
                                                                       |term|)
                                                                      (SPADCALL
                                                                       (QCDR
                                                                        |term|)
                                                                       |li|
                                                                       |vlist|
                                                                       (QREFELT
                                                                        $ 50)))
                                                                     #24#))))
                                                            (LETT #23#
                                                                  (CDR #23#))
                                                            (GO G190) G191
                                                            (EXIT
                                                             (NREVERSE #24#))))
                                                      #26#))))
                                             (LETT #25# (CDR #25#)) (GO G190)
                                             G191 (EXIT (NREVERSE #26#))))))))
                              ('T
                               (PROGN
                                (LETT |#G40| |tlist|)
                                (LETT |#G41| |coeflist|)
                                (LETT |tlv| |#G40|)
                                (LETT |clv| |#G41|))))
                             (LETT |plist|
                                   (PROGN
                                    (LETT #22# NIL)
                                    (SEQ (LETT |lcp| NIL) (LETT #21# |tlv|)
                                         (LETT |p| NIL) (LETT #20# |plist|)
                                         G190
                                         (COND
                                          ((OR (ATOM #20#)
                                               (PROGN
                                                (LETT |p| (CAR #20#))
                                                NIL)
                                               (ATOM #21#)
                                               (PROGN
                                                (LETT |lcp| (CAR #21#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #22#
                                                 (CONS
                                                  (|MLIFT;subslead| |p| |lcp|
                                                   $)
                                                  #22#))))
                                         (LETT #20#
                                               (PROG1 (CDR #20#)
                                                 (LETT #21# (CDR #21#))))
                                         (GO G190) G191
                                         (EXIT (NREVERSE #22#)))))
                             (EXIT
                              (COND
                               ((NULL (NULL |coeflist|))
                                (LETT |plist|
                                      (PROGN
                                       (LETT #19# NIL)
                                       (SEQ (LETT |clist| NIL)
                                            (LETT #18# |clv|) (LETT |tpol| NIL)
                                            (LETT #17# |plist|) G190
                                            (COND
                                             ((OR (ATOM #17#)
                                                  (PROGN
                                                   (LETT |tpol| (CAR #17#))
                                                   NIL)
                                                  (ATOM #18#)
                                                  (PROGN
                                                   (LETT |clist| (CAR #18#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #19#
                                                    (CONS
                                                     (|MLIFT;subscoef| |tpol|
                                                      |clist| $)
                                                     #19#))))
                                            (LETT #17#
                                                  (PROG1 (CDR #17#)
                                                    (LETT #18# (CDR #18#))))
                                            (GO G190) G191
                                            (EXIT (NREVERSE #19#)))))))))))
                          (LETT |mj|
                                (SPADCALL
                                 (CONS #'|MLIFT;lifting1!0|
                                       (VECTOR $ |vlist| |li|))
                                 |m| (QREFELT $ 22)))
                          (LETT |polc|
                                (SPADCALL (SPADCALL |x| (QREFELT $ 51))
                                          (SPADCALL |v| (QREFELT $ 16))
                                          (QREFELT $ 41)))
                          (LETT |pol| (|spadConstant| $ 39))
                          (SEQ
                           (EXIT
                            (SEQ (LETT |k| 1) (LETT #16# |degj|) G190
                                 (COND ((|greater_SI| |k| #16#) (GO G191)))
                                 (SEQ
                                  (LETT |pol|
                                        (SPADCALL |pol| |polc| (QREFELT $ 52)))
                                  (LETT |mc|
                                        (SPADCALL
                                         (PROGN
                                          (LETT #12# NIL)
                                          (SEQ (LETT |term| NIL)
                                               (LETT #15# |plist|) G190
                                               (COND
                                                ((OR (ATOM #15#)
                                                     (PROGN
                                                      (LETT |term| (CAR #15#))
                                                      NIL))
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (PROGN
                                                  (LETT #14# |term|)
                                                  (COND
                                                   (#12#
                                                    (LETT #13#
                                                          (SPADCALL #13# #14#
                                                                    (QREFELT $
                                                                             36))))
                                                   ('T
                                                    (PROGN
                                                     (LETT #13# #14#)
                                                     (LETT #12# 'T)))))))
                                               (LETT #15# (CDR #15#)) (GO G190)
                                               G191 (EXIT NIL))
                                          (COND (#12# #13#)
                                                ('T (|spadConstant| $ 37))))
                                         |mj| (QREFELT $ 45)))
                                  (COND
                                   ((SPADCALL |mc| (|spadConstant| $ 44)
                                              (QREFELT $ 48))
                                    (PROGN
                                     (LETT #11# |$NoValue|)
                                     (GO #30=#:G829))))
                                  (LETT |mc|
                                        (SPADCALL
                                         (CONS #'|MLIFT;lifting1!1|
                                               (VECTOR $ |x| |k|))
                                         |mc| (QREFELT $ 22)))
                                  (LETT |mc|
                                        (SPADCALL
                                         (CONS #'|MLIFT;lifting1!2|
                                               (VECTOR $ |v| |x|))
                                         |mc| (QREFELT $ 22)))
                                  (EXIT
                                   (COND
                                    ((SPADCALL |mc| (|spadConstant| $ 44)
                                               (QREFELT $ 48))
                                     "next k")
                                    ('T
                                     (SEQ
                                      (LETT |flalpha|
                                            (SPADCALL |mc| (CDR |subsvar|)
                                                      (CDR |subsval|)
                                                      (CDR |ldeg|) |conglist|
                                                      |bsolv| (QREFELT $ 30)))
                                      (COND
                                       ((QEQCAR |flalpha| 1)
                                        (PROGN
                                         (LETT #5# (CONS 1 "failed"))
                                         (GO #31=#:G835)))
                                       ('T (LETT |lalpha| (QCDR |flalpha|))))
                                      (EXIT
                                       (LETT |plist|
                                             (PROGN
                                              (LETT #9# NIL)
                                              (SEQ (LETT |alpha| NIL)
                                                   (LETT #8# |lalpha|)
                                                   (LETT |term| NIL)
                                                   (LETT #7# |plist|) G190
                                                   (COND
                                                    ((OR (ATOM #7#)
                                                         (PROGN
                                                          (LETT |term|
                                                                (CAR #7#))
                                                          NIL)
                                                         (ATOM #8#)
                                                         (PROGN
                                                          (LETT |alpha|
                                                                (CAR #8#))
                                                          NIL))
                                                     (GO G191)))
                                                   (SEQ
                                                    (EXIT
                                                     (LETT #9#
                                                           (CONS
                                                            (SPADCALL |term|
                                                                      (SPADCALL
                                                                       |alpha|
                                                                       |pol|
                                                                       (QREFELT
                                                                        $ 53))
                                                                      (QREFELT
                                                                       $ 45))
                                                            #9#))))
                                                   (LETT #7#
                                                         (PROG1 (CDR #7#)
                                                           (LETT #8#
                                                                 (CDR #8#))))
                                                   (GO G190) G191
                                                   (EXIT
                                                    (NREVERSE #9#)))))))))))
                                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                 (EXIT NIL)))
                           #30# (EXIT #11#))
                          (LETT |idegj| (|MLIFT;maxDegree| |m| |x| $))
                          (SEQ (LETT |term| NIL) (LETT #6# |plist|) G190
                               (COND
                                ((OR (ATOM #6#)
                                     (PROGN (LETT |term| (CAR #6#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT |idegj|
                                       (- |idegj|
                                          (|MLIFT;maxDegree| |term| |x| $)))))
                               (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
                          (EXIT
                           (COND
                            ((< |idegj| 0)
                             (PROGN (LETT #5# (CONS 1 "failed")) (GO #31#))))))
                     (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 |plist|))))
          #31# (EXIT #5#)))) 

(SDEFUN |MLIFT;lifting1!2| ((|p1| NIL) ($$ NIL))
        (PROG (|x| |v| $)
          (LETT |x| (QREFELT $$ 2))
          (LETT |v| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN (SPADCALL |p1| (LIST |x|) (LIST |v|) (QREFELT $ 50)))))) 

(SDEFUN |MLIFT;lifting1!1| ((|p1| NIL) ($$ NIL))
        (PROG (|k| |x| $)
          (LETT |k| (QREFELT $$ 2))
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|MLIFT;normalDerivM| |p1| |k| |x| $))))) 

(SDEFUN |MLIFT;lifting1!0| ((|p1| NIL) ($$ NIL))
        (PROG (|li| |vlist| $)
          (LETT |li| (QREFELT $$ 2))
          (LETT |vlist| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |p1| |li| |vlist| (QREFELT $ 50)))))) 

(SDEFUN |MLIFT;maxDegree|
        ((|um| (|SparseUnivariatePolynomial| P)) (|x| (OV))
         ($ (|NonNegativeInteger|)))
        (SPROG ((|ans| (|NonNegativeInteger|)))
               (SEQ (LETT |ans| 0)
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL |um| (|spadConstant| $ 44)
                                      (QREFELT $ 54)))
                           (GO G191)))
                         (SEQ
                          (LETT |ans|
                                (MAX |ans|
                                     (SPADCALL (SPADCALL |um| (QREFELT $ 55))
                                               |x| (QREFELT $ 56))))
                          (EXIT (LETT |um| (SPADCALL |um| (QREFELT $ 57)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |ans|)))) 

(SDEFUN |MLIFT;lifting;SupLLLLLMU;4|
        ((|um| (|SparseUnivariatePolynomial| P)) (|lvar| (|List| OV))
         (|plist| (|List| (|SparseUnivariatePolynomial| R)))
         (|vlist| (|List| R)) (|tlist| (|List| P))
         (|listdeg| (|List| (|NonNegativeInteger|)))
         (|gen_solv|
          (|Mapping|
           (|Union|
            (|Mapping|
             (|Union| (|List| (|SparseUnivariatePolynomial| R)) #1="failed")
             (|SparseUnivariatePolynomial| R))
            #2="failed")
           (|List| (|SparseUnivariatePolynomial| R))))
         ($ (|Union| (|List| (|SparseUnivariatePolynomial| P)) "failed")))
        (SPROG
         ((#3=#:G898 NIL)
          (|ffl| (|Union| (|List| (|SparseUnivariatePolynomial| P)) "failed"))
          (|sfu|
           (|Union|
            (|Mapping| (|Union| (|List| (|SparseUnivariatePolynomial| R)) #1#)
                       (|SparseUnivariatePolynomial| R))
            #2#))
          (|coeflist|
           (|List|
            (|List|
             (|Record| (|:| |expt| (|NonNegativeInteger|)) (|:| |pcoef| P)))))
          (#4=#:G878 NIL) (#5=#:G875 NIL)
          (#6=#:G874 #7=(|SparseUnivariatePolynomial| P)) (#8=#:G876 #7#)
          (#9=#:G903 NIL) (|pol| NIL)
          (|nplist| (|List| (|SparseUnivariatePolynomial| P))) (#10=#:G902 NIL)
          (|pp| NIL) (#11=#:G901 NIL)
          (|listdet| (|List| (|SparseUnivariatePolynomial| P)))
          (|ldcoef|
           (|Record| (|:| |deter| (|List| (|SparseUnivariatePolynomial| P)))
                     (|:| |dterm|
                          (|List|
                           (|List|
                            (|Record| (|:| |expt| (|NonNegativeInteger|))
                                      (|:| |pcoef| P)))))
                     (|:| |nfacts| (|List| (|SparseUnivariatePolynomial| R)))
                     (|:| |nlead| (|List| P))))
          (#12=#:G900 NIL) (#13=#:G899 NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |nplist|
                  (PROGN
                   (LETT #13# NIL)
                   (SEQ (LETT |pp| NIL) (LETT #12# |plist|) G190
                        (COND
                         ((OR (ATOM #12#) (PROGN (LETT |pp| (CAR #12#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #13#
                                (CONS (SPADCALL (ELT $ 16) |pp| (QREFELT $ 19))
                                      #13#))))
                        (LETT #12# (CDR #12#)) (GO G190) G191
                        (EXIT (NREVERSE #13#)))))
            (LETT |listdet| NIL) (LETT |coeflist| NIL)
            (COND
             ((NULL (NULL |tlist|))
              (SEQ
               (LETT |ldcoef| (SPADCALL |um| |plist| |tlist| (QREFELT $ 63)))
               (EXIT
                (COND
                 ((NULL (NULL (LETT |listdet| (QVELT |ldcoef| 0))))
                  (SEQ
                   (COND
                    ((EQL (LENGTH |listdet|) (LENGTH |plist|))
                     (PROGN (LETT #3# (CONS 0 |listdet|)) (GO #14=#:G897))))
                   (LETT |plist| (QVELT |ldcoef| 2))
                   (LETT |nplist|
                         (PROGN
                          (LETT #11# NIL)
                          (SEQ (LETT |pp| NIL) (LETT #10# |plist|) G190
                               (COND
                                ((OR (ATOM #10#)
                                     (PROGN (LETT |pp| (CAR #10#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #11#
                                       (CONS
                                        (SPADCALL (ELT $ 16) |pp|
                                                  (QREFELT $ 19))
                                        #11#))))
                               (LETT #10# (CDR #10#)) (GO G190) G191
                               (EXIT (NREVERSE #11#)))))
                   (LETT |um|
                         (PROG2
                             (LETT #4#
                                   (SPADCALL |um|
                                             (PROGN
                                              (LETT #5# NIL)
                                              (SEQ (LETT |pol| NIL)
                                                   (LETT #9# |listdet|) G190
                                                   (COND
                                                    ((OR (ATOM #9#)
                                                         (PROGN
                                                          (LETT |pol|
                                                                (CAR #9#))
                                                          NIL))
                                                     (GO G191)))
                                                   (SEQ
                                                    (EXIT
                                                     (PROGN
                                                      (LETT #8# |pol|)
                                                      (COND
                                                       (#5#
                                                        (LETT #6#
                                                              (SPADCALL #6# #8#
                                                                        (QREFELT
                                                                         $
                                                                         36))))
                                                       ('T
                                                        (PROGN
                                                         (LETT #6# #8#)
                                                         (LETT #5# 'T)))))))
                                                   (LETT #9# (CDR #9#))
                                                   (GO G190) G191 (EXIT NIL))
                                              (COND (#5# #6#)
                                                    (#15='T
                                                     (|spadConstant| $ 37))))
                                             (QREFELT $ 65)))
                             (QCDR #4#)
                           (|check_union2| (QEQCAR #4# 0)
                                           (|SparseUnivariatePolynomial|
                                            (QREFELT $ 9))
                                           (|Union|
                                            (|SparseUnivariatePolynomial|
                                             (QREFELT $ 9))
                                            "failed")
                                           #4#)))
                   (LETT |tlist| (QVELT |ldcoef| 3))
                   (EXIT (LETT |coeflist| (QVELT |ldcoef| 1))))))))))
            (LETT |sfu| (SPADCALL |plist| |gen_solv|))
            (EXIT
             (COND ((QEQCAR |sfu| 1) (CONS 1 "failed"))
                   (#15#
                    (SEQ
                     (LETT |ffl|
                           (|MLIFT;lifting1| |um| |lvar| |nplist| |vlist|
                            |tlist| |coeflist| |listdeg| (QCDR |sfu|) $))
                     (COND
                      ((QEQCAR |ffl| 1)
                       (PROGN (LETT #3# (CONS 1 "failed")) (GO #14#))))
                     (EXIT
                      (CONS 0
                            (SPADCALL |listdet| (QCDR |ffl|)
                                      (QREFELT $ 66))))))))))
          #14# (EXIT #3#)))) 

(SDEFUN |MLIFT;gen_solv|
        ((|plist| (|List| (|SparseUnivariatePolynomial| R))) (|pmod| (R))
         ($
          (|Union|
           (|Mapping|
            (|Union| (|List| (|SparseUnivariatePolynomial| R)) "failed")
            (|SparseUnivariatePolynomial| R))
           "failed")))
        (SPROG
         ((|table| (|Vector| (|List| (|SparseUnivariatePolynomial| R))))
          (|tab|
           (|Union| (|Vector| (|List| (|SparseUnivariatePolynomial| R)))
                    "failed"))
          (|du| (|NonNegativeInteger|))
          (|ldeg| (|List| (|NonNegativeInteger|))) (#1=#:G926 NIL) (|p| NIL)
          (#2=#:G925 NIL))
         (SEQ
          (LETT |ldeg|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |p| NIL) (LETT #1# |plist|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |p| (QREFELT $ 70)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (LETT |du| (SPADCALL (ELT $ 72) |ldeg| (QREFELT $ 74)))
          (LETT |tab| (SPADCALL |du| |pmod| |plist| (QREFELT $ 77)))
          (EXIT
           (COND ((QEQCAR |tab| 1) (CONS 1 "failed"))
                 ('T
                  (SEQ (LETT |table| (QCDR |tab|))
                       (EXIT
                        (CONS 0
                              (CONS #'|MLIFT;gen_solv!0|
                                    (VECTOR $ |table| |pmod|))))))))))) 

(SDEFUN |MLIFT;gen_solv!0| ((|b| NIL) ($$ NIL))
        (PROG (|pmod| |table| $)
          (LETT |pmod| (QREFELT $$ 2))
          (LETT |table| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |b| |pmod| |table| (QREFELT $ 79)))))) 

(SDEFUN |MLIFT;lifting;SupLLLLLRU;6|
        ((|um| (|SparseUnivariatePolynomial| P)) (|lvar| (|List| OV))
         (|plist| (|List| (|SparseUnivariatePolynomial| R)))
         (|vlist| (|List| R)) (|tlist| (|List| P))
         (|listdeg| (|List| (|NonNegativeInteger|))) (|pmod| (R))
         ($ (|Union| (|List| (|SparseUnivariatePolynomial| P)) "failed")))
        (SPROG NIL
               (SPADCALL |um| |lvar| |plist| |vlist| |tlist| |listdeg|
                         (CONS #'|MLIFT;lifting;SupLLLLLRU;6!0|
                               (VECTOR $ |pmod|))
                         (QREFELT $ 69)))) 

(SDEFUN |MLIFT;lifting;SupLLLLLRU;6!0| ((|lb| NIL) ($$ NIL))
        (PROG (|pmod| $)
          (LETT |pmod| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|MLIFT;gen_solv| |lb| |pmod| $))))) 

(SDEFUN |MLIFT;normalDerivM| ((|g| (P)) (|m| (|Integer|)) (|x| (OV)) ($ (P)))
        (SPADCALL (|MLIFT;normalDeriv| (SPADCALL |g| |x| (QREFELT $ 82)) |m| $)
                  |x| (QREFELT $ 83))) 

(SDEFUN |MLIFT;normalDeriv|
        ((|f| (|SparseUnivariatePolynomial| P)) (|m| (|Integer|))
         ($ (|SparseUnivariatePolynomial| P)))
        (SPROG
         ((|n| #1=(|Integer|)) (|ris| (|SparseUnivariatePolynomial| P))
          (#2=#:G936 NIL) (|n1| #1#) (|k| (|Integer|))
          (|#G1| (|NonNegativeInteger|)))
         (SEQ (LETT |#G1| (SPADCALL |f| (QREFELT $ 84))) (LETT |n1| |#G1|)
              (EXIT
               (COND ((< |#G1| |m|) (|spadConstant| $ 44))
                     ((EQL |n1| |m|)
                      (SPADCALL (SPADCALL |f| (QREFELT $ 55)) (QREFELT $ 42)))
                     ('T
                      (SEQ (LETT |k| (SPADCALL |n1| |m| (QREFELT $ 86)))
                           (LETT |ris| (|spadConstant| $ 44)) (LETT |n| |n1|)
                           (SEQ G190 (COND ((NULL (>= |n| |m|)) (GO G191)))
                                (SEQ
                                 (SEQ G190
                                      (COND ((NULL (> |n1| |n|)) (GO G191)))
                                      (SEQ
                                       (LETT |k|
                                             (QUOTIENT2 (* |k| (- |n1| |m|))
                                                        |n1|))
                                       (EXIT (LETT |n1| (- |n1| 1))))
                                      NIL (GO G190) G191 (EXIT NIL))
                                 (LETT |ris|
                                       (SPADCALL |ris|
                                                 (SPADCALL
                                                  (SPADCALL |k|
                                                            (SPADCALL |f|
                                                                      (QREFELT
                                                                       $ 55))
                                                            (QREFELT $ 87))
                                                  (PROG1 (LETT #2# (- |n| |m|))
                                                    (|check_subtype2|
                                                     (>= #2# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #2#))
                                                  (QREFELT $ 88))
                                                 (QREFELT $ 43)))
                                 (LETT |f| (SPADCALL |f| (QREFELT $ 57)))
                                 (EXIT
                                  (LETT |n| (SPADCALL |f| (QREFELT $ 84)))))
                                NIL (GO G190) G191 (EXIT NIL))
                           (EXIT |ris|)))))))) 

(SDEFUN |MLIFT;subslead|
        ((|m| (|SparseUnivariatePolynomial| P)) (|pol| (P))
         ($ (|SparseUnivariatePolynomial| P)))
        (SPROG ((|dm| (|NonNegativeInteger|)))
               (SEQ (LETT |dm| (SPADCALL |m| (QREFELT $ 84)))
                    (EXIT
                     (SPADCALL (SPADCALL |pol| |dm| (QREFELT $ 88))
                               (SPADCALL |m| (QREFELT $ 57)) (QREFELT $ 43)))))) 

(SDEFUN |MLIFT;subscoef|
        ((|um| (|SparseUnivariatePolynomial| P))
         (|lterm|
          (|List|
           (|Record| (|:| |expt| (|NonNegativeInteger|)) (|:| |pcoef| P))))
         ($ (|SparseUnivariatePolynomial| P)))
        (SPROG
         ((|new| (|SparseUnivariatePolynomial| P)) (|i| (|NonNegativeInteger|))
          (#1=#:G946 NIL) (|k| NIL) (|dm| (|NonNegativeInteger|)))
         (SEQ (LETT |dm| (SPADCALL |um| (QREFELT $ 84)))
              (LETT |new|
                    (SPADCALL (SPADCALL |um| (QREFELT $ 55)) |dm|
                              (QREFELT $ 88)))
              (SEQ (LETT |k| (- |dm| 1)) G190 (COND ((< |k| 0) (GO G191)))
                   (SEQ
                    (LETT |i|
                          (PROG1 (LETT #1# |k|)
                            (|check_subtype2| (>= #1# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #1#)))
                    (COND
                     ((OR (NULL |lterm|)
                          (SPADCALL (QCAR (|SPADfirst| |lterm|)) |i|
                                    (QREFELT $ 33)))
                      (EXIT
                       (LETT |new|
                             (SPADCALL |new|
                                       (SPADCALL
                                        (SPADCALL |um| |i| (QREFELT $ 89)) |i|
                                        (QREFELT $ 88))
                                       (QREFELT $ 43))))))
                    (LETT |new|
                          (SPADCALL |new|
                                    (SPADCALL (QCDR (|SPADfirst| |lterm|)) |i|
                                              (QREFELT $ 88))
                                    (QREFELT $ 43)))
                    (EXIT (LETT |lterm| (CDR |lterm|))))
                   (LETT |k| (+ |k| -1)) (GO G190) G191 (EXIT NIL))
              (EXIT |new|)))) 

(DECLAIM (NOTINLINE |MultivariateLifting;|)) 

(DEFUN |MultivariateLifting| (&REST #1=#:G953)
  (SPROG NIL
         (PROG (#2=#:G954)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|MultivariateLifting|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |MultivariateLifting;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|MultivariateLifting|)))))))))) 

(DEFUN |MultivariateLifting;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|MultivariateLifting| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 90))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#3|
                                                       '(|EuclideanDomain|))))))
    (|haddProp| |$ConstructorCache| '|MultivariateLifting|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|testBitVector| |pv$| 1)
      (PROGN
       (QSETREFV $ 80
                 (CONS (|dispatchFunction| |MLIFT;lifting;SupLLLLLRU;6|) $)))))
    $))) 

(MAKEPROP '|MultivariateLifting| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (0 . |ground|)
              (|SparseUnivariatePolynomial| 8) (|Mapping| 8 9)
              (|SparseUnivariatePolynomial| 9)
              (|SparseUnivariatePolynomialFunctions2| 9 8) (5 . |map|)
              (11 . |coerce|) (|Mapping| 9 8)
              (|SparseUnivariatePolynomialFunctions2| 8 9) (16 . |map|)
              (22 . |eval|) (|Mapping| 9 9) (29 . |map|)
              (|Union| 27 '#1="failed") (|List| 7) (|List| 8) (|List| 32)
              (|List| 13) (|Union| 60 '#2="failed") (|Mapping| 28 11)
              |MLIFT;corrPoly;SupLLLLMU;1| (|Boolean|) (|NonNegativeInteger|)
              (35 . ~=) (|Integer|) (41 . |elt|) (47 . *) (53 . |One|)
              (57 . |One|) (61 . |One|) (65 . |monomial|) (72 . -)
              (78 . |coerce|) (83 . +) (89 . |Zero|) (93 . -) (99 . |Zero|)
              (103 . |Zero|) (107 . =) (113 . |elt|) (119 . |eval|)
              (126 . |coerce|) (131 . *) (137 . *) (143 . ~=)
              (149 . |leadingCoefficient|) (154 . |degree|) (160 . |reductum|)
              (|Record| (|:| |expt| 32) (|:| |pcoef| 9))
              (|Record| (|:| |deter| 27) (|:| |dterm| (|List| (|List| 58)))
                        (|:| |nfacts| 60) (|:| |nlead| 61))
              (|List| 11) (|List| 9) (|NPCoef| 11 6 7 8 9) (165 . |npcoef|)
              (|Union| $ '"failed") (172 . |exquo|) (178 . |append|)
              (|Union| 29 '#3="failed") (|Mapping| 67 60)
              |MLIFT;lifting;SupLLLLLMU;4| (184 . |degree|) (189 . +) (195 . +)
              (|Mapping| 32 32 32) (201 . |reduce|) (|Union| 78 '"failed")
              (|GenExEuclid| 8 11) (207 . |tablePow|) (|Vector| 60)
              (214 . |solveid|) (221 . |lifting|)
              (|SparseUnivariatePolynomial| $) (232 . |univariate|)
              (238 . |multivariate|) (244 . |degree|)
              (|IntegerCombinatoricFunctions| 34) (249 . |binomial|) (255 . *)
              (261 . |monomial|) (267 . |coefficient|))
           '#(|lifting| 273 |corrPoly| 295) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|corrPoly|
                                 ((|Union|
                                   (|List| (|SparseUnivariatePolynomial| |#4|))
                                   #1#)
                                  (|SparseUnivariatePolynomial| |#4|)
                                  (|List| |#2|) (|List| |#3|)
                                  (|List| (|NonNegativeInteger|))
                                  (|List| (|SparseUnivariatePolynomial| |#4|))
                                  (|Mapping|
                                   (|Union|
                                    (|List|
                                     (|SparseUnivariatePolynomial| |#3|))
                                    #2#)
                                   (|SparseUnivariatePolynomial| |#3|))))
                                T)
                              '((|lifting|
                                 ((|Union|
                                   (|List| (|SparseUnivariatePolynomial| |#4|))
                                   "failed")
                                  (|SparseUnivariatePolynomial| |#4|)
                                  (|List| |#2|)
                                  (|List| (|SparseUnivariatePolynomial| |#3|))
                                  (|List| |#3|) (|List| |#4|)
                                  (|List| (|NonNegativeInteger|))
                                  (|Mapping|
                                   (|Union|
                                    (|Mapping|
                                     (|Union|
                                      (|List|
                                       (|SparseUnivariatePolynomial| |#3|))
                                      #2#)
                                     (|SparseUnivariatePolynomial| |#3|))
                                    #3#)
                                   (|List|
                                    (|SparseUnivariatePolynomial| |#3|)))))
                                T)
                              '((|lifting|
                                 ((|Union|
                                   (|List| (|SparseUnivariatePolynomial| |#4|))
                                   "failed")
                                  (|SparseUnivariatePolynomial| |#4|)
                                  (|List| |#2|)
                                  (|List| (|SparseUnivariatePolynomial| |#3|))
                                  (|List| |#3|) (|List| |#4|)
                                  (|List| (|NonNegativeInteger|)) |#3|))
                                (|has| 8 (|EuclideanDomain|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 89
                                            '(1 9 8 0 10 2 14 11 12 13 15 1 9 0
                                              8 16 2 18 13 17 11 19 3 9 0 0 7 0
                                              20 2 13 0 21 0 22 2 32 31 0 0 33
                                              2 27 13 0 34 35 2 13 0 0 0 36 0
                                              13 0 37 0 8 0 38 0 9 0 39 3 9 0 0
                                              7 32 40 2 9 0 0 0 41 1 13 0 9 42
                                              2 13 0 0 0 43 0 13 0 44 2 13 0 0
                                              0 45 0 6 0 46 0 8 0 47 2 13 31 0
                                              0 48 2 26 32 0 34 49 3 9 0 0 24
                                              25 50 1 9 0 7 51 2 9 0 0 0 52 2
                                              13 0 0 9 53 2 13 31 0 0 54 1 13 9
                                              0 55 2 9 32 0 7 56 1 13 0 0 57 3
                                              62 59 13 60 61 63 2 13 64 0 0 65
                                              2 27 0 0 0 66 1 11 32 0 70 2 11 0
                                              0 0 71 2 32 0 0 0 72 2 26 32 73 0
                                              74 3 76 75 32 8 60 77 3 76 28 11
                                              8 78 79 7 0 23 13 24 60 25 61 26
                                              8 80 2 9 81 0 7 82 2 9 0 81 7 83
                                              1 13 32 0 84 2 85 34 34 34 86 2 9
                                              0 34 0 87 2 13 0 9 32 88 2 13 9 0
                                              32 89 7 1 23 13 24 60 25 61 26 8
                                              80 7 0 23 13 24 60 25 61 26 68 69
                                              6 0 23 13 24 25 26 27 29 30)))))
           '|lookupComplete|)) 
