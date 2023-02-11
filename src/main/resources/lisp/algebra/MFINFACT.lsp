
(SDEFUN |MFINFACT;convertPUP|
        ((|lfg|
          (|Record| (|:| |contp| (|SparseUnivariatePolynomial| F))
                    (|:| |factors|
                         (|List|
                          (|Record|
                           (|:| |irr|
                                (|SparseMultivariatePolynomial|
                                 (|SparseUnivariatePolynomial| F) OV))
                           (|:| |pow| (|NonNegativeInteger|)))))))
         ($
          (|Record| (|:| |contp| (|SparseUnivariatePolynomial| F))
                    (|:| |factors|
                         (|List|
                          (|Record|
                           (|:| |irr|
                                (|SparseUnivariatePolynomial|
                                 (|SparseMultivariatePolynomial|
                                  (|SparseUnivariatePolynomial| F) OV)))
                           (|:| |pow| (|NonNegativeInteger|))))))))
        (SPROG ((#1=#:G751 NIL) (|lff| NIL) (#2=#:G750 NIL))
               (SEQ
                (CONS (QCAR |lfg|)
                      (PROGN
                       (LETT #2# NIL)
                       (SEQ (LETT |lff| NIL) (LETT #1# (QCDR |lfg|)) G190
                            (COND
                             ((OR (ATOM #1#)
                                  (PROGN (LETT |lff| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #2#
                                    (CONS
                                     (CONS
                                      (SPADCALL (QCAR |lff|) (QREFELT $ 12))
                                      (QCDR |lff|))
                                     #2#))))
                            (LETT #1# (CDR #1#)) (GO G190) G191
                            (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |MFINFACT;supFactor|
        ((|um|
          (|SparseUnivariatePolynomial|
           (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                           OV)))
         (|var| (OV)) (|dx| (|Integer|))
         ($
          (|Record| (|:| |contp| (|SparseUnivariatePolynomial| F))
                    (|:| |factors|
                         (|List|
                          (|Record|
                           (|:| |irr|
                                (|SparseUnivariatePolynomial|
                                 (|SparseMultivariatePolynomial|
                                  (|SparseUnivariatePolynomial| F) OV)))
                           (|:| |pow| (|NonNegativeInteger|))))))))
        (SPROG
         ((#1=#:G811 NIL) (|lcfacs| #2=(|SparseUnivariatePolynomial| F))
          (#3=#:G808 NIL) (#4=#:G807 #2#) (#5=#:G809 #2#) (#6=#:G826 NIL)
          (|f| NIL)
          (|factorlist|
           (|List|
            (|Record|
             (|:| |irr|
                  (|SparseUnivariatePolynomial|
                   (|SparseMultivariatePolynomial|
                    (|SparseUnivariatePolynomial| F) OV)))
             (|:| |pow| (|NonNegativeInteger|)))))
          (|auxfl|
           (|List|
            #7=(|Record|
                (|:| |irr|
                     #8=(|SparseUnivariatePolynomial|
                         (|SparseMultivariatePolynomial|
                          (|SparseUnivariatePolynomial| F) OV)))
                (|:| |pow| #9=(|NonNegativeInteger|)))))
          (#10=#:G825 NIL) (|lfp| NIL) (#11=#:G824 NIL)
          (|lf|
           (|List|
            (|SparseUnivariatePolynomial|
             (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                             OV))))
          (|ldeg| (|List| #12=(|NonNegativeInteger|))) (#13=#:G799 NIL)
          (#14=#:G798 #12#) (#15=#:G800 #12#) (#16=#:G823 NIL) (|fc| NIL)
          (#17=#:G822 NIL) (|xx| NIL) (#18=#:G821 NIL)
          (|coefs|
           (|List|
            (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                            OV)))
          (|ffexp| #9#) (|ffactor| #8#) (#19=#:G820 NIL) (|fact| NIL)
          (|sqqfact| (|List| #7#)) (#20=#:G819 NIL) (|ff| NIL) (#21=#:G818 NIL)
          (|flead|
           (|Record| (|:| |contp| (|SparseUnivariatePolynomial| F))
                     (|:| |factors| (|List| #7#))))
          (|lcont|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                            OV)))
          (|sqfacs| (|Factored| (|SparseUnivariatePolynomial| PG)))
          (|om| (|SparseUnivariatePolynomial| PG)) (#22=#:G816 NIL)
          (|lfg|
           (|Record| (|:| |contp| (|SparseUnivariatePolynomial| F))
                     (|:| |factors|
                          (|List|
                           (|Record|
                            (|:| |irr|
                                 (|SparseUnivariatePolynomial|
                                  (|SparseMultivariatePolynomial|
                                   (|SparseUnivariatePolynomial| F) OV)))
                            (|:| |pow| (|NonNegativeInteger|)))))))
          (#23=#:G758 NIL)
          (|f1|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                            OV)))
          (|mdeg| (|NonNegativeInteger|)) (|lvar| #24=(|List| OV))
          (#25=#:G754 NIL) (#26=#:G753 #24#) (#27=#:G755 #24#) (#28=#:G817 NIL)
          (|cf| NIL))
         (SEQ
          (EXIT
           (COND
            ((EQL (SPADCALL |um| (QREFELT $ 14)) 0)
             (|MFINFACT;convertPUP|
              (|MFINFACT;mFactor| (SPADCALL |um| (QREFELT $ 15)) |var| |dx| $)
              $))
            (#29='T
             (SEQ
              (LETT |lvar|
                    (PROGN
                     (LETT #25# NIL)
                     (SEQ (LETT |cf| NIL)
                          (LETT #28# (SPADCALL |um| (QREFELT $ 17))) G190
                          (COND
                           ((OR (ATOM #28#) (PROGN (LETT |cf| (CAR #28#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (PROGN
                             (LETT #27# (SPADCALL |cf| (QREFELT $ 19)))
                             (COND
                              (#25#
                               (LETT #26# (SPADCALL #26# #27# (QREFELT $ 20))))
                              ('T (PROGN (LETT #26# #27#) (LETT #25# 'T)))))))
                          (LETT #28# (CDR #28#)) (GO G190) G191 (EXIT NIL))
                     (COND (#25# #26#) (#29# (|IdentityError| '|setUnion|)))))
              (LETT |flead| (CONS (|spadConstant| $ 24) NIL))
              (LETT |factorlist| NIL)
              (LETT |mdeg| (SPADCALL |um| (QREFELT $ 25)))
              (COND
               ((> |mdeg| 0)
                (SEQ
                 (LETT |f1|
                       (SPADCALL (|spadConstant| $ 28) |mdeg| (QREFELT $ 29)))
                 (LETT |um|
                       (PROG2 (LETT #23# (SPADCALL |um| |f1| (QREFELT $ 31)))
                           (QCDR #23#)
                         (|check_union2| (QEQCAR #23# 0)
                                         (|SparseUnivariatePolynomial|
                                          (|SparseMultivariatePolynomial|
                                           (|SparseUnivariatePolynomial|
                                            (QREFELT $ 8))
                                           (QREFELT $ 6)))
                                         (|Union|
                                          (|SparseUnivariatePolynomial|
                                           (|SparseMultivariatePolynomial|
                                            (|SparseUnivariatePolynomial|
                                             (QREFELT $ 8))
                                            (QREFELT $ 6)))
                                          #30="failed")
                                         #23#)))
                 (LETT |factorlist|
                       (CONS
                        (CONS (SPADCALL (|spadConstant| $ 28) 1 (QREFELT $ 29))
                              |mdeg|)
                        |factorlist|))
                 (EXIT
                  (COND
                   ((EQL (SPADCALL |um| (QREFELT $ 14)) 0)
                    (PROGN
                     (LETT #22#
                           (SEQ
                            (LETT |lfg|
                                  (|MFINFACT;convertPUP|
                                   (|MFINFACT;mFactor|
                                    (SPADCALL |um| (QREFELT $ 15)) |var| |dx|
                                    $)
                                   $))
                            (EXIT
                             (CONS (QCAR |lfg|)
                                   (SPADCALL |factorlist| (QCDR |lfg|)
                                             (QREFELT $ 34))))))
                     (GO #31=#:G815))))))))
              (LETT |om|
                    (SPADCALL (CONS #'|MFINFACT;supFactor!0| (VECTOR $ |var|))
                              |um| (QREFELT $ 38)))
              (LETT |sqfacs| (SPADCALL |om| (QREFELT $ 40)))
              (LETT |lcont|
                    (SPADCALL (CONS #'|MFINFACT;supFactor!1| (VECTOR $ |var|))
                              (SPADCALL |sqfacs| (QREFELT $ 42))
                              (QREFELT $ 45)))
              (COND
               ((SPADCALL |lcont| (QREFELT $ 47))
                (LETT |flead|
                      (|MFINFACT;convertPUP|
                       (|MFINFACT;constantCase|
                        (SPADCALL |lcont| (QREFELT $ 15)) NIL $)
                       $)))
               (#29#
                (LETT |flead| (|MFINFACT;supFactor| |lcont| |var| |dx| $))))
              (LETT |factorlist| (QCDR |flead|))
              (LETT |sqqfact|
                    (PROGN
                     (LETT #21# NIL)
                     (SEQ (LETT |ff| NIL)
                          (LETT #20# (SPADCALL |sqfacs| (QREFELT $ 51))) G190
                          (COND
                           ((OR (ATOM #20#) (PROGN (LETT |ff| (CAR #20#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #21#
                                  (CONS
                                   (CONS
                                    (SPADCALL
                                     (CONS #'|MFINFACT;supFactor!2|
                                           (VECTOR $ |var|))
                                     (QVELT |ff| 1) (QREFELT $ 45))
                                    (QVELT |ff| 2))
                                   #21#))))
                          (LETT #20# (CDR #20#)) (GO G190) G191
                          (EXIT (NREVERSE #21#)))))
              (SEQ (LETT |fact| NIL) (LETT #19# |sqqfact|) G190
                   (COND
                    ((OR (ATOM #19#) (PROGN (LETT |fact| (CAR #19#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |ffactor| (QCAR |fact|))
                        (LETT |ffexp| (QCDR |fact|))
                        (LETT |coefs| (SPADCALL |ffactor| (QREFELT $ 17)))
                        (LETT |ldeg|
                              (PROGN
                               (LETT #18# NIL)
                               (SEQ (LETT |xx| NIL) (LETT #17# |lvar|) G190
                                    (COND
                                     ((OR (ATOM #17#)
                                          (PROGN (LETT |xx| (CAR #17#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #18#
                                            (CONS
                                             (PROGN
                                              (LETT #13# NIL)
                                              (SEQ (LETT |fc| NIL)
                                                   (LETT #16# |coefs|) G190
                                                   (COND
                                                    ((OR (ATOM #16#)
                                                         (PROGN
                                                          (LETT |fc|
                                                                (CAR #16#))
                                                          NIL))
                                                     (GO G191)))
                                                   (SEQ
                                                    (EXIT
                                                     (PROGN
                                                      (LETT #15#
                                                            (SPADCALL |fc| |xx|
                                                                      (QREFELT
                                                                       $ 52)))
                                                      (COND
                                                       (#13#
                                                        (LETT #14#
                                                              (MAX #14# #15#)))
                                                       ('T
                                                        (PROGN
                                                         (LETT #14# #15#)
                                                         (LETT #13# 'T)))))))
                                                   (LETT #16# (CDR #16#))
                                                   (GO G190) G191 (EXIT NIL))
                                              (COND (#13# #14#)
                                                    ('T
                                                     (|IdentityError|
                                                      '|max|))))
                                             #18#))))
                                    (LETT #17# (CDR #17#)) (GO G190) G191
                                    (EXIT (NREVERSE #18#)))))
                        (COND
                         ((SPADCALL (SPADCALL |ffactor| (QREFELT $ 53))
                                    (QREFELT $ 54))
                          (LETT |lf|
                                (|MFINFACT;mfconst| |ffactor| |dx| |lvar|
                                 |ldeg| $)))
                         ('T
                          (LETT |lf|
                                (|MFINFACT;mfpol| |ffactor| |var| |dx| |lvar|
                                 |ldeg| $))))
                        (LETT |auxfl|
                              (PROGN
                               (LETT #11# NIL)
                               (SEQ (LETT |lfp| NIL) (LETT #10# |lf|) G190
                                    (COND
                                     ((OR (ATOM #10#)
                                          (PROGN (LETT |lfp| (CAR #10#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #11#
                                            (CONS (CONS |lfp| |ffexp|) #11#))))
                                    (LETT #10# (CDR #10#)) (GO G190) G191
                                    (EXIT (NREVERSE #11#)))))
                        (EXIT
                         (LETT |factorlist|
                               (SPADCALL |auxfl| |factorlist|
                                         (QREFELT $ 55)))))
                   (LETT #19# (CDR #19#)) (GO G190) G191 (EXIT NIL))
              (LETT |lcfacs|
                    (PROGN
                     (LETT #3# NIL)
                     (SEQ (LETT |f| NIL) (LETT #6# |factorlist|) G190
                          (COND
                           ((OR (ATOM #6#) (PROGN (LETT |f| (CAR #6#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (PROGN
                             (LETT #5#
                                   (SPADCALL
                                    (SPADCALL
                                     (SPADCALL (QCAR |f|) (QREFELT $ 53))
                                     (QREFELT $ 56))
                                    (QCDR |f|) (QREFELT $ 57)))
                             (COND
                              (#3#
                               (LETT #4# (SPADCALL #4# #5# (QREFELT $ 58))))
                              ('T (PROGN (LETT #4# #5#) (LETT #3# 'T)))))))
                          (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
                     (COND (#3# #4#) (#29# (|spadConstant| $ 59)))))
              (EXIT
               (CONS
                (PROG2
                    (LETT #1#
                          (SPADCALL
                           (SPADCALL (SPADCALL |um| (QREFELT $ 53))
                                     (QREFELT $ 56))
                           |lcfacs| (QREFELT $ 60)))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0)
                                  (|SparseUnivariatePolynomial| (QREFELT $ 8))
                                  (|Union|
                                   (|SparseUnivariatePolynomial| (QREFELT $ 8))
                                   #30#)
                                  #1#))
                |factorlist|))))))
          #31# (EXIT #22#)))) 

(SDEFUN |MFINFACT;supFactor!2| ((|p1| NIL) ($$ NIL))
        (PROG (|var| $)
          (LETT |var| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|MFINFACT;pushdown| |p1| |var| $))))) 

(SDEFUN |MFINFACT;supFactor!1| ((|p1| NIL) ($$ NIL))
        (PROG (|var| $)
          (LETT |var| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|MFINFACT;pushdown| |p1| |var| $))))) 

(SDEFUN |MFINFACT;supFactor!0| ((|p1| NIL) ($$ NIL))
        (PROG (|var| $)
          (LETT |var| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|MFINFACT;pushup| |p1| |var| $))))) 

(SDEFUN |MFINFACT;factor_sup|
        ((|m| (|SparseUnivariatePolynomial| F))
         ($ (|Factored| (|SparseUnivariatePolynomial| PG))))
        (SPROG
         ((|fr1| #1=(|Factored| (|SparseUnivariatePolynomial| PG)))
          (#2=#:G830 NIL) (#3=#:G829 #1#) (#4=#:G831 #1#) (#5=#:G835 NIL)
          (|p| NIL)
          (|fm|
           (|Record| (|:| |cont| F)
                     (|:| |factors|
                          (|List|
                           (|Record|
                            (|:| |irr| (|SparseUnivariatePolynomial| F))
                            (|:| |pow| (|NonNegativeInteger|))))))))
         (SEQ (LETT |fm| (SPADCALL |m| NIL (QREFELT $ 64)))
              (LETT |fr1|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |p| NIL) (LETT #5# (QCDR |fm|)) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |p| (CAR #5#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (PROGN
                             (LETT #4#
                                   (SPADCALL
                                    (SPADCALL (ELT $ 65) (QCAR |p|)
                                              (QREFELT $ 68))
                                    (QCDR |p|) (QREFELT $ 69)))
                             (COND
                              (#2#
                               (LETT #3# (SPADCALL #3# #4# (QREFELT $ 70))))
                              ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                          (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                     (COND (#2# #3#) ('T (|spadConstant| $ 71)))))
              (EXIT
               (SPADCALL
                (SPADCALL
                 (SPADCALL (SPADCALL (QCAR |fm|) (QREFELT $ 65))
                           (QREFELT $ 72))
                 NIL (QREFELT $ 73))
                |fr1| (QREFELT $ 70)))))) 

(SDEFUN |MFINFACT;factor;SupF;4|
        ((|um| (|SparseUnivariatePolynomial| PG))
         ($ (|Factored| (|SparseUnivariatePolynomial| PG))))
        (SPROG
         ((#1=#:G850 NIL)
          (#2=#:G849 #3=(|Factored| (|SparseUnivariatePolynomial| PG)))
          (#4=#:G851 #3#) (#5=#:G857 NIL) (|u| NIL)
          (|flist|
           (|Record| (|:| |contp| (|SparseUnivariatePolynomial| F))
                     (|:| |factors|
                          (|List|
                           (|Record|
                            (|:| |irr|
                                 (|SparseUnivariatePolynomial|
                                  (|SparseMultivariatePolynomial|
                                   (|SparseUnivariatePolynomial| F) OV)))
                            (|:| |pow| (|NonNegativeInteger|)))))))
          (|cm|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                            OV)))
          (|var| (OV)) (|dx| #6=(|NonNegativeInteger|)) (#7=#:G837 NIL)
          (#8=#:G836 #6#) (#9=#:G838 #6#) (#10=#:G856 NIL) (#11=#:G689 NIL)
          (|ld| (|List| #6#)) (|lv| (|List| OV)))
         (SEQ (LETT |lv| (SPADCALL |um| (QREFELT $ 75)))
              (EXIT
               (COND
                ((NULL |lv|)
                 (|MFINFACT;factor_sup|
                  (SPADCALL (ELT $ 76) |um| (QREFELT $ 79)) $))
                (#12='T
                 (SEQ (LETT |ld| (SPADCALL |um| |lv| (QREFELT $ 81)))
                      (LETT |dx|
                            (PROGN
                             (LETT #7# NIL)
                             (SEQ (LETT #11# NIL) (LETT #10# |ld|) G190
                                  (COND
                                   ((OR (ATOM #10#)
                                        (PROGN (LETT #11# (CAR #10#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (PROGN
                                     (LETT #9# #11#)
                                     (COND (#7# (LETT #8# (MIN #8# #9#)))
                                           ('T
                                            (PROGN
                                             (LETT #8# #9#)
                                             (LETT #7# 'T)))))))
                                  (LETT #10# (CDR #10#)) (GO G190) G191
                                  (EXIT NIL))
                             (COND (#7# #8#) (#12# (|IdentityError| '|min|)))))
                      (LETT |var|
                            (SPADCALL |lv| (SPADCALL |dx| |ld| (QREFELT $ 83))
                                      (QREFELT $ 84)))
                      (LETT |cm|
                            (SPADCALL
                             (CONS #'|MFINFACT;factor;SupF;4!0|
                                   (VECTOR $ |var|))
                             |um| (QREFELT $ 45)))
                      (LETT |flist| (|MFINFACT;supFactor| |cm| |var| |dx| $))
                      (EXIT
                       (SPADCALL
                        (SPADCALL
                         (|MFINFACT;pushupconst| (QCAR |flist|) |var| $)
                         (QREFELT $ 72))
                        (PROGN
                         (LETT #1# NIL)
                         (SEQ (LETT |u| NIL) (LETT #5# (QCDR |flist|)) G190
                              (COND
                               ((OR (ATOM #5#)
                                    (PROGN (LETT |u| (CAR #5#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (PROGN
                                 (LETT #4#
                                       (SPADCALL
                                        (SPADCALL
                                         (CONS #'|MFINFACT;factor;SupF;4!1|
                                               (VECTOR $ |var|))
                                         (QCAR |u|) (QREFELT $ 38))
                                        (QCDR |u|) (QREFELT $ 69)))
                                 (COND
                                  (#1#
                                   (LETT #2#
                                         (SPADCALL #2# #4# (QREFELT $ 70))))
                                  ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                              (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                         (COND (#1# #2#) (#12# (|spadConstant| $ 71))))
                        (QREFELT $ 85)))))))))) 

(SDEFUN |MFINFACT;factor;SupF;4!1| ((|p1| NIL) ($$ NIL))
        (PROG (|var| $)
          (LETT |var| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|MFINFACT;pushup| |p1| |var| $))))) 

(SDEFUN |MFINFACT;factor;SupF;4!0| ((|p1| NIL) ($$ NIL))
        (PROG (|var| $)
          (LETT |var| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|MFINFACT;pushdown| |p1| |var| $))))) 

(SDEFUN |MFINFACT;mFactor|
        ((|m|
          (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F) OV))
         (|var| (OV)) (|dx| (|Integer|))
         ($
          (|Record| (|:| |contp| (|SparseUnivariatePolynomial| F))
                    (|:| |factors|
                         (|List|
                          (|Record|
                           (|:| |irr|
                                (|SparseMultivariatePolynomial|
                                 (|SparseUnivariatePolynomial| F) OV))
                           (|:| |pow| (|NonNegativeInteger|))))))))
        (SPROG
         ((|factorlist|
           (|List|
            (|Record|
             (|:| |irr|
                  (|SparseMultivariatePolynomial|
                   (|SparseUnivariatePolynomial| F) OV))
             (|:| |pow| (|NonNegativeInteger|)))))
          (|auxfl|
           (|List|
            (|Record|
             (|:| |irr|
                  (|SparseMultivariatePolynomial|
                   (|SparseUnivariatePolynomial| F) OV))
             (|:| |pow| (|NonNegativeInteger|)))))
          (#1=#:G917 NIL) (|lfp| NIL) (#2=#:G916 NIL)
          (|lf|
           (|List|
            (|SparseUnivariatePolynomial|
             (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                             OV))))
          (|um|
           #3=(|SparseUnivariatePolynomial|
               (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                               OV)))
          (|lcum| (F)) (|ldeg| (|List| (|NonNegativeInteger|))) (#4=#:G915 NIL)
          (|lcterm| NIL)
          (|ffactor|
           #5=(|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                              OV))
          (#6=#:G883 NIL)
          (|pc|
           (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                           OV))
          (|lvar| (|List| OV)) (|x| (OV))
          (|varch|
           (|Record| (|:| |npol| #3#) (|:| |nvar| (|List| OV))
                     (|:| |newdeg| (|List| (|NonNegativeInteger|)))))
          (#7=#:G914 NIL) (#8=#:G876 NIL)
          (|lcont|
           (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                           OV))
          (#9=#:G913 NIL) (|lterm| NIL) (|ffexp| #10=(|NonNegativeInteger|))
          (#11=#:G912 NIL) (|fact| NIL)
          (|sqqfact|
           (|List| (|Record| (|:| |factor| #5#) (|:| |exponent| #10#))))
          (#12=#:G911 NIL) (|ff| NIL) (#13=#:G910 NIL)
          (|flead|
           (|Record| (|:| |contp| (|SparseUnivariatePolynomial| F))
                     (|:| |factors|
                          (|List|
                           (|Record|
                            (|:| |irr|
                                 (|SparseMultivariatePolynomial|
                                  (|SparseUnivariatePolynomial| F) OV))
                            (|:| |pow| (|NonNegativeInteger|)))))))
          (|sqfacs| (|Factored| PG)) (|om| (PG)) (#14=#:G861 NIL)
          (#15=#:G860 #16=(|Boolean|)) (#17=#:G862 #16#) (#18=#:G909 NIL)
          (|n| NIL) (|lmdeg| (|List| (|NonNegativeInteger|))))
         (SEQ
          (COND
           ((SPADCALL |m| (QREFELT $ 54)) (|MFINFACT;constantCase| |m| NIL $))
           (#19='T
            (SEQ (LETT |lvar| (SPADCALL |m| (QREFELT $ 19)))
                 (LETT |flead| (CONS (|spadConstant| $ 59) NIL))
                 (LETT |factorlist| NIL)
                 (LETT |lmdeg| (SPADCALL |m| |lvar| (QREFELT $ 87)))
                 (EXIT
                  (COND
                   ((PROGN
                     (LETT #14# NIL)
                     (SEQ (LETT |n| NIL) (LETT #18# |lmdeg|) G190
                          (COND
                           ((OR (ATOM #18#) (PROGN (LETT |n| (CAR #18#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (PROGN
                             (LETT #17# (> |n| 0))
                             (COND
                              (#14# (LETT #15# (COND (#15# 'T) ('T #17#))))
                              ('T (PROGN (LETT #15# #17#) (LETT #14# 'T)))))))
                          (LETT #18# (CDR #18#)) (GO G190) G191 (EXIT NIL))
                     (COND (#14# #15#) (#19# NIL)))
                    (|MFINFACT;simplify| |m| |var| |dx| |lvar| |lmdeg| $))
                   (#19#
                    (SEQ (LETT |om| (|MFINFACT;pushup| |m| |var| $))
                         (LETT |sqfacs| (SPADCALL |om| (QREFELT $ 88)))
                         (LETT |lcont|
                               (|MFINFACT;pushdown|
                                (SPADCALL |sqfacs| (QREFELT $ 90)) |var| $))
                         (COND
                          ((SPADCALL |lcont| (QREFELT $ 54))
                           (LETT |flead|
                                 (|MFINFACT;constantCase| |lcont| NIL $)))
                          (#19#
                           (LETT |flead|
                                 (|MFINFACT;mFactor| |lcont| |var| |dx| $))))
                         (LETT |factorlist| (QCDR |flead|))
                         (LETT |sqqfact|
                               (PROGN
                                (LETT #13# NIL)
                                (SEQ (LETT |ff| NIL)
                                     (LETT #12#
                                           (SPADCALL |sqfacs| (QREFELT $ 93)))
                                     G190
                                     (COND
                                      ((OR (ATOM #12#)
                                           (PROGN (LETT |ff| (CAR #12#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (LETT #13#
                                             (CONS
                                              (CONS
                                               (|MFINFACT;pushdown|
                                                (QVELT |ff| 1) |var| $)
                                               (QVELT |ff| 2))
                                              #13#))))
                                     (LETT #12# (CDR #12#)) (GO G190) G191
                                     (EXIT (NREVERSE #13#)))))
                         (SEQ (LETT |fact| NIL) (LETT #11# |sqqfact|) G190
                              (COND
                               ((OR (ATOM #11#)
                                    (PROGN (LETT |fact| (CAR #11#)) NIL))
                                (GO G191)))
                              (SEQ (LETT |ffactor| (QCAR |fact|))
                                   (LETT |ffexp| (QCDR |fact|))
                                   (EXIT
                                    (COND
                                     ((SPADCALL |ffactor| (QREFELT $ 54))
                                      (SEQ (LETT |lterm| NIL)
                                           (LETT #9#
                                                 (QCDR
                                                  (|MFINFACT;constantCase|
                                                   |ffactor| NIL $)))
                                           G190
                                           (COND
                                            ((OR (ATOM #9#)
                                                 (PROGN
                                                  (LETT |lterm| (CAR #9#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (LETT |factorlist|
                                                   (CONS
                                                    (CONS (QCAR |lterm|)
                                                          (* (QCDR |lterm|)
                                                             |ffexp|))
                                                    |factorlist|))))
                                           (LETT #9# (CDR #9#)) (GO G190) G191
                                           (EXIT NIL)))
                                     ('T
                                      (SEQ
                                       (LETT |lvar|
                                             (SPADCALL |ffactor|
                                                       (QREFELT $ 19)))
                                       (LETT |x|
                                             (SPADCALL |lvar| 1
                                                       (QREFELT $ 84)))
                                       (LETT |ldeg|
                                             (SPADCALL |ffactor| |lvar|
                                                       (QREFELT $ 94)))
                                       (EXIT
                                        (COND
                                         ((SPADCALL 1 |ldeg| (QREFELT $ 96))
                                          (SEQ
                                           (LETT |x|
                                                 (SPADCALL |lvar|
                                                           (SPADCALL 1 |ldeg|
                                                                     (QREFELT $
                                                                              83))
                                                           (QREFELT $ 84)))
                                           (LETT |lcont|
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (SPADCALL |ffactor| |x|
                                                             (QREFELT $ 98))
                                                   (QREFELT $ 17))
                                                  (QREFELT $ 100)))
                                           (LETT |ffactor|
                                                 (PROG2
                                                     (LETT #8#
                                                           (SPADCALL |ffactor|
                                                                     |lcont|
                                                                     (QREFELT $
                                                                              101)))
                                                     (QCDR #8#)
                                                   (|check_union2|
                                                    (QEQCAR #8# 0)
                                                    (|SparseMultivariatePolynomial|
                                                     (|SparseUnivariatePolynomial|
                                                      (QREFELT $ 8))
                                                     (QREFELT $ 6))
                                                    (|Union|
                                                     (|SparseMultivariatePolynomial|
                                                      (|SparseUnivariatePolynomial|
                                                       (QREFELT $ 8))
                                                      (QREFELT $ 6))
                                                     "failed")
                                                    #8#)))
                                           (LETT |factorlist|
                                                 (CONS (CONS |ffactor| |ffexp|)
                                                       |factorlist|))
                                           (EXIT
                                            (SEQ (LETT |lcterm| NIL)
                                                 (LETT #7#
                                                       (QCDR
                                                        (|MFINFACT;mFactor|
                                                         |lcont| |var| |dx|
                                                         $)))
                                                 G190
                                                 (COND
                                                  ((OR (ATOM #7#)
                                                       (PROGN
                                                        (LETT |lcterm|
                                                              (CAR #7#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT |factorlist|
                                                         (CONS
                                                          (CONS (QCAR |lcterm|)
                                                                (*
                                                                 (QCDR
                                                                  |lcterm|)
                                                                 |ffexp|))
                                                          |factorlist|))))
                                                 (LETT #7# (CDR #7#)) (GO G190)
                                                 G191 (EXIT NIL)))))
                                         ('T
                                          (SEQ
                                           (LETT |varch|
                                                 (|MFINFACT;varChoose|
                                                  |ffactor| |lvar| |ldeg| $))
                                           (LETT |um| (QVELT |varch| 0))
                                           (LETT |ldeg| (CDR |ldeg|))
                                           (LETT |lvar| (CDR |lvar|))
                                           (COND
                                            ((SPADCALL
                                              (SPADCALL (QVELT |varch| 1) 1
                                                        (QREFELT $ 84))
                                              |x| (QREFELT $ 102))
                                             (SEQ
                                              (LETT |lvar| (QVELT |varch| 1))
                                              (LETT |x|
                                                    (SPADCALL |lvar| 1
                                                              (QREFELT $ 84)))
                                              (LETT |lvar| (CDR |lvar|))
                                              (LETT |pc|
                                                    (SPADCALL
                                                     (SPADCALL |um|
                                                               (QREFELT $ 17))
                                                     (QREFELT $ 100)))
                                              (COND
                                               ((SPADCALL |pc|
                                                          (|spadConstant| $ 28)
                                                          (QREFELT $ 103))
                                                (SEQ
                                                 (LETT |um|
                                                       (PROG2
                                                           (LETT #6#
                                                                 (SPADCALL |um|
                                                                           |pc|
                                                                           (QREFELT
                                                                            $
                                                                            104)))
                                                           (QCDR #6#)
                                                         (|check_union2|
                                                          (QEQCAR #6# 0)
                                                          (|SparseUnivariatePolynomial|
                                                           (|SparseMultivariatePolynomial|
                                                            (|SparseUnivariatePolynomial|
                                                             (QREFELT $ 8))
                                                            (QREFELT $ 6)))
                                                          (|Union|
                                                           (|SparseUnivariatePolynomial|
                                                            (|SparseMultivariatePolynomial|
                                                             (|SparseUnivariatePolynomial|
                                                              (QREFELT $ 8))
                                                             (QREFELT $ 6)))
                                                           "failed")
                                                          #6#)))
                                                 (LETT |ffactor|
                                                       (SPADCALL |um| |x|
                                                                 (QREFELT $
                                                                          105)))
                                                 (EXIT
                                                  (SEQ (LETT |lcterm| NIL)
                                                       (LETT #4#
                                                             (QCDR
                                                              (|MFINFACT;mFactor|
                                                               |pc| |var| |dx|
                                                               $)))
                                                       G190
                                                       (COND
                                                        ((OR (ATOM #4#)
                                                             (PROGN
                                                              (LETT |lcterm|
                                                                    (CAR #4#))
                                                              NIL))
                                                         (GO G191)))
                                                       (SEQ
                                                        (EXIT
                                                         (LETT |factorlist|
                                                               (CONS
                                                                (CONS
                                                                 (QCAR
                                                                  |lcterm|)
                                                                 (*
                                                                  (QCDR
                                                                   |lcterm|)
                                                                  |ffexp|))
                                                                |factorlist|))))
                                                       (LETT #4# (CDR #4#))
                                                       (GO G190) G191
                                                       (EXIT NIL))))))
                                              (EXIT
                                               (LETT |ldeg|
                                                     (SPADCALL |ffactor| |lvar|
                                                               (QREFELT $
                                                                        94)))))))
                                           (LETT |lcum|
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (SPADCALL |um|
                                                             (QREFELT $ 53))
                                                   (QREFELT $ 56))
                                                  (QREFELT $ 106)))
                                           (COND
                                            ((SPADCALL |lcum|
                                                       (|spadConstant| $ 26)
                                                       (QREFELT $ 107))
                                             (SEQ
                                              (LETT |um|
                                                    (SPADCALL
                                                     (SPADCALL
                                                      (SPADCALL
                                                       (SPADCALL |lcum|
                                                                 (QREFELT $
                                                                          108))
                                                       (QREFELT $ 109))
                                                      (QREFELT $ 110))
                                                     |um| (QREFELT $ 111)))
                                              (EXIT
                                               (PROGN
                                                (RPLACA |flead|
                                                        (SPADCALL
                                                         (SPADCALL |lcum|
                                                                   (QREFELT $
                                                                            109))
                                                         (QCAR |flead|)
                                                         (QREFELT $ 58)))
                                                (QCAR |flead|))))))
                                           (COND
                                            ((SPADCALL
                                              (SPADCALL |um| (QREFELT $ 53))
                                              (QREFELT $ 54))
                                             (LETT |lf|
                                                   (|MFINFACT;mfconst| |um|
                                                    |dx| |lvar| |ldeg| $)))
                                            ('T
                                             (LETT |lf|
                                                   (|MFINFACT;mfpol| |um| |var|
                                                    |dx| |lvar| |ldeg| $))))
                                           (LETT |auxfl|
                                                 (PROGN
                                                  (LETT #2# NIL)
                                                  (SEQ (LETT |lfp| NIL)
                                                       (LETT #1# |lf|) G190
                                                       (COND
                                                        ((OR (ATOM #1#)
                                                             (PROGN
                                                              (LETT |lfp|
                                                                    (CAR #1#))
                                                              NIL))
                                                         (GO G191)))
                                                       (SEQ
                                                        (EXIT
                                                         (LETT #2#
                                                               (CONS
                                                                (CONS
                                                                 (SPADCALL
                                                                  |lfp| |x|
                                                                  (QREFELT $
                                                                           105))
                                                                 |ffexp|)
                                                                #2#))))
                                                       (LETT #1# (CDR #1#))
                                                       (GO G190) G191
                                                       (EXIT (NREVERSE #2#)))))
                                           (EXIT
                                            (LETT |factorlist|
                                                  (SPADCALL |factorlist|
                                                            |auxfl|
                                                            (QREFELT $
                                                                     114)))))))))))))
                              (LETT #11# (CDR #11#)) (GO G190) G191 (EXIT NIL))
                         (PROGN (RPLACD |flead| |factorlist|) (QCDR |flead|))
                         (EXIT |flead|))))))))))) 

(SDEFUN |MFINFACT;pM|
        ((|lum|
          (|List|
           (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F))))
         ($ (|SparseUnivariatePolynomial| F)))
        (SPROG
         ((#1=#:G944 NIL) (|p| (|SparseUnivariatePolynomial| F))
          (#2=#:G934 NIL)
          (|q| (|Union| (|SparseUnivariatePolynomial| F) #3="failed"))
          (#4=#:G931 NIL) (|e| NIL) (#5=#:G943 NIL) (#6=#:G926 NIL)
          (#7=#:G945 NIL) (|i| NIL) (|x| (|SparseUnivariatePolynomial| F)))
         (SEQ
          (EXIT
           (SEQ (LETT |x| (SPADCALL (|spadConstant| $ 26) 1 (QREFELT $ 115)))
                (SEQ (LETT |i| 1) (LETT #7# (SPADCALL (QREFELT $ 116))) G190
                     (COND ((|greater_SI| |i| #7#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ
                        (LETT |p|
                              (SPADCALL |x|
                                        (SPADCALL
                                         (SPADCALL
                                          (PROG1 (LETT #6# |i|)
                                            (|check_subtype2| (> #6# 0)
                                                              '(|PositiveInteger|)
                                                              '(|NonNegativeInteger|)
                                                              #6#))
                                          (QREFELT $ 118))
                                         (QREFELT $ 109))
                                        (QREFELT $ 119)))
                        (EXIT
                         (COND
                          ((SPADCALL |p| |lum| (QREFELT $ 122))
                           (PROGN
                            (LETT #5# (PROGN (LETT #1# |p|) (GO #8=#:G942)))
                            (GO #9=#:G927)))))))
                      #9# (EXIT #5#))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT
                 (SEQ (LETT |e| 2) G190 NIL
                      (SEQ
                       (LETT |p|
                             (SPADCALL
                              (PROG1 (LETT #4# |e|)
                                (|check_subtype2| (> #4# 0)
                                                  '(|PositiveInteger|)
                                                  '(|NonNegativeInteger|) #4#))
                              (QREFELT $ 124)))
                       (EXIT
                        (COND
                         ((SPADCALL |p| |lum| (QREFELT $ 122))
                          (PROGN (LETT #1# |p|) (GO #8#)))
                         ('T
                          (SEQ G190
                               (COND
                                ((NULL
                                  (SEQ
                                   (LETT |q| (SPADCALL |p| (QREFELT $ 126)))
                                   (EXIT (NULL (QEQCAR |q| 1)))))
                                 (GO G191)))
                               (SEQ
                                (LETT |p|
                                      (PROG2 (LETT #2# |q|)
                                          (QCDR #2#)
                                        (|check_union2| (QEQCAR #2# 0)
                                                        (|SparseUnivariatePolynomial|
                                                         (QREFELT $ 8))
                                                        (|Union|
                                                         (|SparseUnivariatePolynomial|
                                                          (QREFELT $ 8))
                                                         #3#)
                                                        #2#)))
                                (EXIT
                                 (COND
                                  ((SPADCALL |p| |lum| (QREFELT $ 122))
                                   (PROGN (LETT #1# |p|) (GO #8#))))))
                               NIL (GO G190) G191 (EXIT NIL))))))
                      (LETT |e| (|inc_SI| |e|)) (GO G190) G191 (EXIT NIL)))))
          #8# (EXIT #1#)))) 

(SDEFUN |MFINFACT;pushdcoef|
        ((|t| (PG))
         ($
          (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                          OV)))
        (SPADCALL (ELT $ 109) |t| (QREFELT $ 129))) 

(SDEFUN |MFINFACT;intfact|
        ((|um|
          (|SparseUnivariatePolynomial|
           (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                           OV)))
         (|lvar| (|List| OV)) (|ldeg| (|List| (|NonNegativeInteger|)))
         (|tleadpol|
          (|Record| (|:| |contp| (|SparseUnivariatePolynomial| F))
                    (|:| |factors|
                         (|List|
                          (|Record|
                           (|:| |irr|
                                (|SparseMultivariatePolynomial|
                                 (|SparseUnivariatePolynomial| F) OV))
                           (|:| |pow| (|NonNegativeInteger|)))))))
         (|ltry| (|List| (|List| (|SparseUnivariatePolynomial| F))))
         ($
          (|List|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                            OV)))))
        (SPROG
         ((|factfin|
           (|List|
            (|SparseUnivariatePolynomial|
             (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                             OV))))
          (#1=#:G993 NIL) (|ff| NIL) (#2=#:G992 NIL)
          (|ffin|
           (|Union|
            (|List|
             (|SparseUnivariatePolynomial|
              (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                              OV)))
            "failed"))
          (#3=#:G970 NIL)
          (|unifact|
           (|List|
            (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F))))
          (#4=#:G991 NIL) (|i| NIL) (#5=#:G990 NIL)
          (|dd| (|SparseUnivariatePolynomial| F))
          (|lpol|
           (|List|
            (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                            OV)))
          (|dist|
           (|Record|
            (|:| |polfac|
                 (|List|
                  (|SparseMultivariatePolynomial|
                   (|SparseUnivariatePolynomial| F) OV)))
            (|:| |correct| (|SparseUnivariatePolynomial| F))
            (|:| |corrfact|
                 (|List|
                  (|SparseUnivariatePolynomial|
                   (|SparseUnivariatePolynomial| F))))))
          (#6=#:G987 NIL)
          (|distf|
           (|Union|
            (|Record|
             (|:| |polfac|
                  (|List|
                   (|SparseMultivariatePolynomial|
                    (|SparseUnivariatePolynomial| F) OV)))
             (|:| |correct| (|SparseUnivariatePolynomial| F))
             (|:| |corrfact|
                  (|List|
                   (|SparseUnivariatePolynomial|
                    (|SparseUnivariatePolynomial| F)))))
            "failed"))
          (|leadval| (|List| (|SparseUnivariatePolynomial| F)))
          (|lval| (|List| (|SparseUnivariatePolynomial| F)))
          (|nfact| (|NonNegativeInteger|))
          (|vfchoo|
           (|Record|
            (|:| |inval| (|List| (|List| (|SparseUnivariatePolynomial| F))))
            (|:| |unvfact|
                 (|List|
                  (|SparseUnivariatePolynomial|
                   (|SparseUnivariatePolynomial| F))))
            (|:| |lu| (|SparseUnivariatePolynomial| F))
            (|:| |complead| (|List| (|SparseUnivariatePolynomial| F)))))
          (|leadpol|
           (|List|
            (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                            OV)))
          (#7=#:G989 NIL) (#8=#:G988 NIL) (|polcase| (|Boolean|)))
         (SEQ
          (EXIT
           (SEQ (LETT |polcase| (NULL (NULL (QCDR |tleadpol|))))
                (LETT |vfchoo|
                      (COND
                       (|polcase|
                        (SEQ
                         (LETT |leadpol|
                               (PROGN
                                (LETT #8# NIL)
                                (SEQ (LETT |ff| NIL)
                                     (LETT #7# (QCDR |tleadpol|)) G190
                                     (COND
                                      ((OR (ATOM #7#)
                                           (PROGN (LETT |ff| (CAR #7#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT (LETT #8# (CONS (QCAR |ff|) #8#))))
                                     (LETT #7# (CDR #7#)) (GO G190) G191
                                     (EXIT (NREVERSE #8#)))))
                         (EXIT
                          (|MFINFACT;intChoose| |um| |lvar| (QCAR |tleadpol|)
                           |leadpol| |ltry| $))))
                       (#9='T
                        (|MFINFACT;intChoose| |um| |lvar| (|spadConstant| $ 59)
                         NIL NIL $))))
                (LETT |unifact| (QVELT |vfchoo| 1))
                (LETT |nfact| (LENGTH |unifact|))
                (EXIT
                 (COND ((EQL |nfact| 1) (LIST |um|))
                       (#9#
                        (SEQ (LETT |ltry| (QVELT |vfchoo| 0))
                             (LETT |lval| (|SPADfirst| |ltry|))
                             (LETT |dd| (QVELT |vfchoo| 2)) (LETT |lpol| NIL)
                             (LETT |leadval| NIL)
                             (COND
                              (|polcase|
                               (SEQ (LETT |leadval| (QVELT |vfchoo| 3))
                                    (LETT |distf|
                                          (SPADCALL (QVELT |vfchoo| 2)
                                                    |unifact| |tleadpol|
                                                    |leadval| |lvar| |lval|
                                                    (QREFELT $ 135)))
                                    (EXIT
                                     (COND
                                      ((QEQCAR |distf| 1)
                                       (PROGN
                                        (LETT #6#
                                              (|MFINFACT;intfact| |um| |lvar|
                                               |ldeg| |tleadpol| |ltry| $))
                                        (GO #10=#:G986)))
                                      (#9#
                                       (SEQ (LETT |dist| (QCDR |distf|))
                                            (LETT |lpol| (QVELT |dist| 0))
                                            (LETT |dd| (QVELT |dist| 1))
                                            (EXIT
                                             (LETT |unifact|
                                                   (QVELT |dist| 2))))))))))
                             (COND
                              ((SPADCALL |dd| (|spadConstant| $ 59)
                                         (QREFELT $ 136))
                               (SEQ
                                (LETT |unifact|
                                      (PROGN
                                       (LETT #5# NIL)
                                       (SEQ (LETT |i| 1) (LETT #4# |nfact|)
                                            G190
                                            (COND
                                             ((|greater_SI| |i| #4#)
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #5#
                                                    (CONS
                                                     (SPADCALL |dd|
                                                               (SPADCALL
                                                                |unifact| |i|
                                                                (QREFELT $
                                                                         138))
                                                               (QREFELT $ 139))
                                                     #5#))))
                                            (LETT |i| (|inc_SI| |i|)) (GO G190)
                                            G191 (EXIT (NREVERSE #5#)))))
                                (EXIT
                                 (LETT |um|
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL |dd|
                                                   (PROG1
                                                       (LETT #3# (- |nfact| 1))
                                                     (|check_subtype2|
                                                      (>= #3# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #3#))
                                                   (QREFELT $ 57))
                                         (QREFELT $ 110))
                                        |um| (QREFELT $ 111)))))))
                             (LETT |ffin|
                                   (SPADCALL |um| |lvar| |unifact| |lval|
                                             |lpol| |ldeg|
                                             (|MFINFACT;pM| |unifact| $)
                                             (QREFELT $ 142)))
                             (EXIT
                              (COND
                               ((QEQCAR |ffin| 1)
                                (|MFINFACT;intfact| |um| |lvar| |ldeg|
                                 |tleadpol| |ltry| $))
                               (#9#
                                (SEQ (LETT |factfin| (QCDR |ffin|))
                                     (COND
                                      ((SPADCALL |dd| (|spadConstant| $ 59)
                                                 (QREFELT $ 136))
                                       (LETT |factfin|
                                             (PROGN
                                              (LETT #2# NIL)
                                              (SEQ (LETT |ff| NIL)
                                                   (LETT #1# |factfin|) G190
                                                   (COND
                                                    ((OR (ATOM #1#)
                                                         (PROGN
                                                          (LETT |ff| (CAR #1#))
                                                          NIL))
                                                     (GO G191)))
                                                   (SEQ
                                                    (EXIT
                                                     (LETT #2#
                                                           (CONS
                                                            (SPADCALL |ff|
                                                                      (QREFELT
                                                                       $ 143))
                                                            #2#))))
                                                   (LETT #1# (CDR #1#))
                                                   (GO G190) G191
                                                   (EXIT (NREVERSE #2#)))))))
                                     (EXIT |factfin|)))))))))))
          #10# (EXIT #6#)))) 

(SDEFUN |MFINFACT;pushup|
        ((|f|
          (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F) OV))
         (|x| (OV)) ($ (PG)))
        (SPROG
         ((|rr| (PG)) (|lvf| (|List| OV)) (|cf| (PG))
          (|lf|
           (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                           OV)))
         (SEQ
          (COND
           ((SPADCALL |f| (QREFELT $ 54))
            (|MFINFACT;pushupconst| (SPADCALL |f| (QREFELT $ 144)) |x| $))
           ('T
            (SEQ (LETT |rr| (|spadConstant| $ 145))
                 (SEQ G190
                      (COND
                       ((NULL
                         (SPADCALL |f| (|spadConstant| $ 146) (QREFELT $ 103)))
                        (GO G191)))
                      (SEQ (LETT |lf| (SPADCALL |f| (QREFELT $ 147)))
                           (LETT |cf|
                                 (|MFINFACT;pushupconst|
                                  (SPADCALL |f| (QREFELT $ 56)) |x| $))
                           (LETT |lvf| (SPADCALL |lf| (QREFELT $ 19)))
                           (LETT |rr|
                                 (SPADCALL |rr|
                                           (SPADCALL |cf| |lvf|
                                                     (SPADCALL |lf| |lvf|
                                                               (QREFELT $ 94))
                                                     (QREFELT $ 148))
                                           (QREFELT $ 149)))
                           (EXIT (LETT |f| (SPADCALL |f| (QREFELT $ 150)))))
                      NIL (GO G190) G191 (EXIT NIL))
                 (EXIT |rr|))))))) 

(SDEFUN |MFINFACT;pushdown|
        ((|g| (PG)) (|x| (OV))
         ($
          (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                          OV)))
        (SPROG
         ((|ug| (|SparseUnivariatePolynomial| PG))
          (|rf|
           (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                           OV))
          (|cf| (|SparseUnivariatePolynomial| F)))
         (SEQ
          (COND
           ((SPADCALL |g| (QREFELT $ 151))
            (SPADCALL (SPADCALL (SPADCALL |g| (QREFELT $ 152)) (QREFELT $ 109))
                      (QREFELT $ 110)))
           ('T
            (SEQ (LETT |rf| (|spadConstant| $ 146))
                 (LETT |ug| (SPADCALL |g| |x| (QREFELT $ 153)))
                 (SEQ G190
                      (COND
                       ((NULL
                         (SPADCALL |ug| (|spadConstant| $ 154)
                                   (QREFELT $ 155)))
                        (GO G191)))
                      (SEQ
                       (LETT |cf|
                             (SPADCALL (|spadConstant| $ 26)
                                       (SPADCALL |ug| (QREFELT $ 156))
                                       (QREFELT $ 115)))
                       (LETT |rf|
                             (SPADCALL |rf|
                                       (SPADCALL |cf|
                                                 (|MFINFACT;pushdcoef|
                                                  (SPADCALL |ug|
                                                            (QREFELT $ 157))
                                                  $)
                                                 (QREFELT $ 158))
                                       (QREFELT $ 159)))
                       (EXIT (LETT |ug| (SPADCALL |ug| (QREFELT $ 160)))))
                      NIL (GO G190) G191 (EXIT NIL))
                 (EXIT |rf|))))))) 

(SDEFUN |MFINFACT;pushupconst|
        ((|r| (|SparseUnivariatePolynomial| F)) (|x| (OV)) ($ (PG)))
        (SPROG ((|rr| (PG)))
               (SEQ
                (COND
                 ((SPADCALL |r| (QREFELT $ 161))
                  (SPADCALL (SPADCALL |r| (QREFELT $ 162)) (QREFELT $ 65)))
                 ('T
                  (SEQ (LETT |rr| (|spadConstant| $ 145))
                       (SEQ G190
                            (COND
                             ((NULL
                               (SPADCALL |r| (|spadConstant| $ 24)
                                         (QREFELT $ 136)))
                              (GO G191)))
                            (SEQ
                             (LETT |rr|
                                   (SPADCALL |rr|
                                             (SPADCALL
                                              (SPADCALL
                                               (SPADCALL |r| (QREFELT $ 106))
                                               (QREFELT $ 65))
                                              |x|
                                              (SPADCALL |r| (QREFELT $ 163))
                                              (QREFELT $ 164))
                                             (QREFELT $ 149)))
                             (EXIT (LETT |r| (SPADCALL |r| (QREFELT $ 165)))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT |rr|))))))) 

(SDEFUN |MFINFACT;ran|
        ((|k1| (|Integer|)) ($ (|SparseUnivariatePolynomial| F)))
        (SPROG
         ((#1=#:G1013 NIL) (#2=#:G1012 #3=(|SparseUnivariatePolynomial| F))
          (#4=#:G1014 #3#) (#5=#:G1016 NIL) (|i| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |i| 0) (LETT #5# |k1|) G190
                (COND ((|greater_SI| |i| #5#) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #4#
                         (SPADCALL (SPADCALL (QREFELT $ 166)) |i|
                                   (QREFELT $ 115)))
                   (COND (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 119))))
                         ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 24))))))) 

(SDEFUN |MFINFACT;varChoose|
        ((|m|
          (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F) OV))
         (|lvar| (|List| OV)) (|ldeg| (|List| #1=(|NonNegativeInteger|)))
         ($
          (|Record|
           (|:| |npol|
                (|SparseUnivariatePolynomial|
                 (|SparseMultivariatePolynomial|
                  (|SparseUnivariatePolynomial| F) OV)))
           (|:| |nvar| (|List| OV))
           (|:| |newdeg| (|List| (|NonNegativeInteger|))))))
        (SPROG
         ((|x| (OV)) (|i| (|Integer|)) (|k| #1#) (#2=#:G1019 NIL)
          (#3=#:G1018 #1#) (#4=#:G1020 #1#) (#5=#:G1024 NIL) (#6=#:G690 NIL))
         (SEQ
          (LETT |k|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT #6# NIL) (LETT #5# |ldeg|) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT #6# (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #4# #6#)
                         (COND (#2# (LETT #3# (MIN #3# #4#)))
                               ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                      (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                 (COND (#2# #3#) (#7='T (|IdentityError| '|min|)))))
          (EXIT
           (COND
            ((EQL |k| (SPADCALL |m| (|SPADfirst| |lvar|) (QREFELT $ 52)))
             (VECTOR (SPADCALL |m| (|SPADfirst| |lvar|) (QREFELT $ 98)) |lvar|
                     |ldeg|))
            (#7#
             (SEQ (LETT |i| (SPADCALL |k| |ldeg| (QREFELT $ 83)))
                  (LETT |x| (SPADCALL |lvar| |i| (QREFELT $ 84)))
                  (LETT |ldeg|
                        (CONS |k| (SPADCALL |ldeg| |i| (QREFELT $ 167))))
                  (LETT |lvar|
                        (CONS |x| (SPADCALL |lvar| |i| (QREFELT $ 168))))
                  (EXIT
                   (VECTOR (SPADCALL |m| |x| (QREFELT $ 98)) |lvar|
                           |ldeg|))))))))) 

(SDEFUN |MFINFACT;norm|
        ((|lum|
          (|List|
           (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F))))
         ($ #1=(|Integer|)))
        (SPROG
         ((#2=#:G1026 NIL) (#3=#:G1025 #1#) (#4=#:G1027 #1#) (#5=#:G1029 NIL)
          (|lup| NIL))
         (SEQ
          (PROGN
           (LETT #2# NIL)
           (SEQ (LETT |lup| NIL) (LETT #5# |lum|) G190
                (COND
                 ((OR (ATOM #5#) (PROGN (LETT |lup| (CAR #5#)) NIL))
                  (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #4# (SPADCALL |lup| (QREFELT $ 169)))
                   (COND (#2# (LETT #3# (MAX #3# #4#)))
                         ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
           (COND (#2# #3#) ('T (|IdentityError| '|max|))))))) 

(SDEFUN |MFINFACT;intChoose|
        ((|um|
          (|SparseUnivariatePolynomial|
           (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                           OV)))
         (|lvar| (|List| OV)) (|clc| (|SparseUnivariatePolynomial| F))
         (|plist|
          (|List|
           (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                           OV)))
         (|ltry| (|List| (|List| (|SparseUnivariatePolynomial| F))))
         ($
          (|Record|
           (|:| |inval| (|List| (|List| (|SparseUnivariatePolynomial| F))))
           (|:| |unvfact|
                (|List|
                 (|SparseUnivariatePolynomial|
                  (|SparseUnivariatePolynomial| F))))
           (|:| |lu| (|SparseUnivariatePolynomial| F))
           (|:| |complead| (|List| (|SparseUnivariatePolynomial| F))))))
        (SPROG
         ((|nfatt| (|NonNegativeInteger|))
          (|int| #1=(|List| (|SparseUnivariatePolynomial| F))) (|leadcomp| #1#)
          (|lffc| #2=(|SparseUnivariatePolynomial| F))
          (|unifact|
           (|List|
            (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F))))
          (#3=#:G1117 NIL) (|uf| NIL) (#4=#:G1116 NIL)
          (|leadtest| #5=(|Boolean|)) (#6=#:G1115 NIL) (#7=#:G1114 NIL)
          (#8=#:G1100 NIL) (#9=#:G1113 NIL) (#10=#:G1112 NIL) (#11=#:G1111 NIL)
          (#12=#:G1110 NIL) (#13=#:G1109 NIL) (|ff| NIL) (#14=#:G1108 NIL)
          (#15=#:G1107 NIL) (#16=#:G1106 NIL) (|lffc1| #2#)
          (|nf| (|NonNegativeInteger|))
          (|lunivf|
           #17=(|List|
                (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                          (|:| |factor|
                               (|SparseUnivariatePolynomial|
                                (|SparseUnivariatePolynomial| F)))
                          (|:| |exponent| (|NonNegativeInteger|)))))
          (|skip| (|Boolean|)) (|base_success| (|Integer|))
          (|luniv|
           (|Factored|
            (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F))))
          (|base_failure| (|Integer|)) (|nfl| #17#)
          (|newm|
           (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))
          (|lcnm| (F)) (|range| (|NonNegativeInteger|))
          (|D2newm|
           (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))
          (|Dnewm|
           (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F)))
          (#18=#:G1043 NIL) (#19=#:G1037 NIL) (#20=#:G1036 #21=(|Boolean|))
          (#22=#:G1038 #21#) (#23=#:G1105 NIL) (|epl| NIL) (|leadcomp1| #1#)
          (#24=#:G1104 NIL) (|pol| NIL) (#25=#:G1103 NIL)
          (|lval| (|List| (|SparseUnivariatePolynomial| F))) (#26=#:G1102 NIL)
          (|i| NIL) (#27=#:G1101 NIL) (|testp| #5#)
          (|nvar1| (|NonNegativeInteger|)) (|degum| (|NonNegativeInteger|)))
         (SEQ (LETT |degum| (SPADCALL |um| (QREFELT $ 14)))
              (LETT |nvar1| (LENGTH |lvar|)) (LETT |range| 0)
              (LETT |testp| (NULL (SPADCALL |plist| NIL (QREFELT $ 170))))
              (LETT |leadcomp| (LETT |leadcomp1| NIL))
              (LETT |nfatt| (+ |degum| 1)) (LETT |lffc| (|spadConstant| $ 59))
              (LETT |lffc1| |lffc|) (LETT |leadtest| 'T) (LETT |int| NIL)
              (LETT |base_success| 0) (LETT |base_failure| 0)
              (SEQ
               (EXIT
                (SEQ G190 (COND ((NULL 'T) (GO G191)))
                     (SEQ
                      (LETT |lval|
                            (PROGN
                             (LETT #27# NIL)
                             (SEQ (LETT |i| 1) (LETT #26# |nvar1|) G190
                                  (COND ((|greater_SI| |i| #26#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #27#
                                          (CONS (|MFINFACT;ran| |range| $)
                                                #27#))))
                                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                  (EXIT (NREVERSE #27#)))))
                      (EXIT
                       (COND
                        ((SPADCALL |lval| |ltry| (QREFELT $ 172))
                         (LETT |range| (+ 1 |range|)))
                        ('T
                         (SEQ (LETT |ltry| (CONS |lval| |ltry|))
                              (LETT |leadcomp1|
                                    (PROGN
                                     (LETT #25# NIL)
                                     (SEQ (LETT |pol| NIL) (LETT #24# |plist|)
                                          G190
                                          (COND
                                           ((OR (ATOM #24#)
                                                (PROGN
                                                 (LETT |pol| (CAR #24#))
                                                 NIL))
                                            (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (LETT #25#
                                                  (CONS
                                                   (SPADCALL
                                                    (SPADCALL |pol| |lvar|
                                                              |lval|
                                                              (QREFELT $ 173))
                                                    (QREFELT $ 144))
                                                   #25#))))
                                          (LETT #24# (CDR #24#)) (GO G190) G191
                                          (EXIT (NREVERSE #25#)))))
                              (COND
                               (|testp|
                                (COND
                                 ((PROGN
                                   (LETT #19# NIL)
                                   (SEQ (LETT |epl| NIL)
                                        (LETT #23# |leadcomp1|) G190
                                        (COND
                                         ((OR (ATOM #23#)
                                              (PROGN
                                               (LETT |epl| (CAR #23#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (PROGN
                                           (LETT #22#
                                                 (SPADCALL |epl|
                                                           (QREFELT $ 174)))
                                           (COND
                                            (#19#
                                             (LETT #20#
                                                   (COND (#20# 'T) ('T #22#))))
                                            ('T
                                             (PROGN
                                              (LETT #20# #22#)
                                              (LETT #19# 'T)))))))
                                        (LETT #23# (CDR #23#)) (GO G190) G191
                                        (EXIT NIL))
                                   (COND (#19# #20#) ('T NIL)))
                                  (EXIT (LETT |range| (+ |range| 1)))))))
                              (LETT |newm|
                                    (SPADCALL |um| |lvar| |lval|
                                              (QREFELT $ 176)))
                              (COND
                               ((OR
                                 (SPADCALL |degum|
                                           (SPADCALL |newm| (QREFELT $ 169))
                                           (QREFELT $ 177))
                                 (SPADCALL (SPADCALL |newm| (QREFELT $ 178)) 0
                                           (QREFELT $ 177)))
                                (EXIT (LETT |range| (+ |range| 1)))))
                              (LETT |lffc1| (SPADCALL |newm| (QREFELT $ 179)))
                              (LETT |newm|
                                    (PROG2
                                        (LETT #18#
                                              (SPADCALL |newm| |lffc1|
                                                        (QREFELT $ 180)))
                                        (QCDR #18#)
                                      (|check_union2| (QEQCAR #18# 0)
                                                      (|SparseUnivariatePolynomial|
                                                       (|SparseUnivariatePolynomial|
                                                        (QREFELT $ 8)))
                                                      (|Union|
                                                       (|SparseUnivariatePolynomial|
                                                        (|SparseUnivariatePolynomial|
                                                         (QREFELT $ 8)))
                                                       "failed")
                                                      #18#)))
                              (COND
                               (|testp|
                                (COND
                                 (|leadtest|
                                  (COND
                                   ((NULL
                                     (SPADCALL
                                      (SPADCALL |lffc1| |clc| (QREFELT $ 58))
                                      (LENGTH |plist|) |leadcomp1|
                                      (QREFELT $ 181)))
                                    (EXIT (LETT |range| (+ |range| 1)))))))))
                              (LETT |Dnewm| (SPADCALL |newm| (QREFELT $ 182)))
                              (LETT |D2newm|
                                    (SPADCALL (ELT $ 185) |newm|
                                              (QREFELT $ 188)))
                              (EXIT
                               (COND
                                ((SPADCALL
                                  (SPADCALL
                                   (SPADCALL (LIST |newm| |Dnewm| |D2newm|)
                                             (QREFELT $ 189))
                                   (QREFELT $ 169))
                                  0 (QREFELT $ 177))
                                 (LETT |range| (+ |range| 1)))
                                ('T
                                 (SEQ (LETT |lcnm| (|spadConstant| $ 26))
                                      (COND
                                       ((SPADCALL
                                         (LETT |lcnm|
                                               (SPADCALL
                                                (SPADCALL |newm|
                                                          (QREFELT $ 190))
                                                (QREFELT $ 106)))
                                         (|spadConstant| $ 26) (QREFELT $ 107))
                                        (LETT |newm|
                                              (SPADCALL
                                               (SPADCALL
                                                (SPADCALL |lcnm|
                                                          (QREFELT $ 108))
                                                (QREFELT $ 109))
                                               |newm| (QREFELT $ 139)))))
                                      (LETT |luniv|
                                            (SPADCALL |newm| (QREFELT $ 193)))
                                      (LETT |nfl|
                                            (SPADCALL |luniv| (QREFELT $ 196)))
                                      (LETT |nf| (LENGTH |nfl|))
                                      (COND
                                       ((OR (EQL |nf| 0) (> |nf| |nfatt|))
                                        (EXIT "next values")))
                                      (COND
                                       ((EQL |nf| 1)
                                        (COND
                                         ((QEQCAR
                                           (QVELT
                                            (SPADCALL |nfl| 1 (QREFELT $ 197))
                                            0)
                                           0)
                                          (SEQ
                                           (LETT |base_failure|
                                                 (+ |base_failure| 1))
                                           (LETT |skip|
                                                 (< |base_failure|
                                                    (+ (* 3 |base_success|)
                                                       3)))
                                           (EXIT
                                            (LETT |luniv|
                                                  (COND (|skip| |luniv|)
                                                        ('T
                                                         (SPADCALL |newm|
                                                                   (QREFELT $
                                                                            198))))))))
                                         ('T
                                          (SEQ
                                           (LETT |base_success|
                                                 (+ |base_success| 1))
                                           (EXIT (LETT |skip| NIL))))))
                                       ('T
                                        (SEQ
                                         (LETT |base_success|
                                               (+ |base_success| 1))
                                         (EXIT (LETT |skip| NIL)))))
                                      (EXIT
                                       (COND (|skip| "iterate")
                                             ('T
                                              (SEQ
                                               (LETT |lunivf|
                                                     (SPADCALL |luniv|
                                                               (QREFELT $
                                                                        196)))
                                               (LETT |nf| (LENGTH |lunivf|))
                                               (COND
                                                ((OR (EQL |nf| 0)
                                                     (> |nf| |nfatt|))
                                                 (EXIT "next values")))
                                               (COND
                                                ((EQL |nf| 1)
                                                 (SEQ
                                                  (LETT |unifact|
                                                        (LIST |newm|))
                                                  (EXIT
                                                   (PROGN
                                                    (LETT #8# |$NoValue|)
                                                    (GO #28=#:G1097))))))
                                               (LETT |lffc1|
                                                     (SPADCALL
                                                      (SPADCALL |lcnm|
                                                                (SPADCALL
                                                                 (SPADCALL
                                                                  |luniv|
                                                                  (QREFELT $
                                                                           199))
                                                                 (QREFELT $
                                                                          200))
                                                                (QREFELT $
                                                                         201))
                                                      |lffc1| (QREFELT $ 58)))
                                               (EXIT
                                                (COND
                                                 ((EQL |nfatt| |nf|)
                                                  (SEQ
                                                   (COND
                                                    (|leadtest|
                                                     (SEQ
                                                      (LETT |unifact|
                                                            (PROGN
                                                             (LETT #16# NIL)
                                                             (SEQ
                                                              (LETT |uf| NIL)
                                                              (LETT #15#
                                                                    |lunivf|)
                                                              G190
                                                              (COND
                                                               ((OR (ATOM #15#)
                                                                    (PROGN
                                                                     (LETT |uf|
                                                                           (CAR
                                                                            #15#))
                                                                     NIL))
                                                                (GO G191)))
                                                              (SEQ
                                                               (EXIT
                                                                (LETT #16#
                                                                      (CONS
                                                                       (QVELT
                                                                        |uf| 1)
                                                                       #16#))))
                                                              (LETT #15#
                                                                    (CDR #15#))
                                                              (GO G190) G191
                                                              (EXIT
                                                               (NREVERSE
                                                                #16#)))))
                                                      (LETT |int| |lval|)
                                                      (LETT |lffc| |lffc1|)
                                                      (EXIT
                                                       (COND
                                                        (|testp|
                                                         (LETT |leadcomp|
                                                               |leadcomp1|))))))
                                                    ((>
                                                      (|MFINFACT;norm|
                                                       |unifact| $)
                                                      (|MFINFACT;norm|
                                                       (PROGN
                                                        (LETT #14# NIL)
                                                        (SEQ (LETT |ff| NIL)
                                                             (LETT #13#
                                                                   |lunivf|)
                                                             G190
                                                             (COND
                                                              ((OR (ATOM #13#)
                                                                   (PROGN
                                                                    (LETT |ff|
                                                                          (CAR
                                                                           #13#))
                                                                    NIL))
                                                               (GO G191)))
                                                             (SEQ
                                                              (EXIT
                                                               (LETT #14#
                                                                     (CONS
                                                                      (QVELT
                                                                       |ff| 1)
                                                                      #14#))))
                                                             (LETT #13#
                                                                   (CDR #13#))
                                                             (GO G190) G191
                                                             (EXIT
                                                              (NREVERSE
                                                               #14#))))
                                                       $))
                                                     (COND
                                                      (|testp|
                                                       (COND
                                                        ((SPADCALL
                                                          (SPADCALL |lffc1|
                                                                    |clc|
                                                                    (QREFELT $
                                                                             58))
                                                          (LENGTH |plist|)
                                                          |leadcomp1|
                                                          (QREFELT $ 181))
                                                         (SEQ
                                                          (LETT |unifact|
                                                                (PROGN
                                                                 (LETT #12#
                                                                       NIL)
                                                                 (SEQ
                                                                  (LETT |uf|
                                                                        NIL)
                                                                  (LETT #11#
                                                                        |lunivf|)
                                                                  G190
                                                                  (COND
                                                                   ((OR
                                                                     (ATOM
                                                                      #11#)
                                                                     (PROGN
                                                                      (LETT
                                                                       |uf|
                                                                       (CAR
                                                                        #11#))
                                                                      NIL))
                                                                    (GO G191)))
                                                                  (SEQ
                                                                   (EXIT
                                                                    (LETT #12#
                                                                          (CONS
                                                                           (QVELT
                                                                            |uf|
                                                                            1)
                                                                           #12#))))
                                                                  (LETT #11#
                                                                        (CDR
                                                                         #11#))
                                                                  (GO G190)
                                                                  G191
                                                                  (EXIT
                                                                   (NREVERSE
                                                                    #12#)))))
                                                          (LETT |int| |lval|)
                                                          (LETT |lffc| |lffc1|)
                                                          (EXIT
                                                           (COND
                                                            (|testp|
                                                             (LETT |leadcomp|
                                                                   |leadcomp1|))))))))
                                                      ('T
                                                       (SEQ
                                                        (LETT |unifact|
                                                              (PROGN
                                                               (LETT #10# NIL)
                                                               (SEQ
                                                                (LETT |uf| NIL)
                                                                (LETT #9#
                                                                      |lunivf|)
                                                                G190
                                                                (COND
                                                                 ((OR
                                                                   (ATOM #9#)
                                                                   (PROGN
                                                                    (LETT |uf|
                                                                          (CAR
                                                                           #9#))
                                                                    NIL))
                                                                  (GO G191)))
                                                                (SEQ
                                                                 (EXIT
                                                                  (LETT #10#
                                                                        (CONS
                                                                         (QVELT
                                                                          |uf|
                                                                          1)
                                                                         #10#))))
                                                                (LETT #9#
                                                                      (CDR
                                                                       #9#))
                                                                (GO G190) G191
                                                                (EXIT
                                                                 (NREVERSE
                                                                  #10#)))))
                                                        (LETT |int| |lval|)
                                                        (LETT |lffc| |lffc1|)
                                                        (EXIT
                                                         (COND
                                                          (|testp|
                                                           (LETT |leadcomp|
                                                                 |leadcomp1|)))))))))
                                                   (EXIT
                                                    (PROGN
                                                     (LETT #8# |$NoValue|)
                                                     (GO #28#)))))
                                                 ((> |nfatt| |degum|)
                                                  (SEQ
                                                   (LETT |unifact|
                                                         (PROGN
                                                          (LETT #7# NIL)
                                                          (SEQ (LETT |uf| NIL)
                                                               (LETT #6#
                                                                     |lunivf|)
                                                               G190
                                                               (COND
                                                                ((OR (ATOM #6#)
                                                                     (PROGN
                                                                      (LETT
                                                                       |uf|
                                                                       (CAR
                                                                        #6#))
                                                                      NIL))
                                                                 (GO G191)))
                                                               (SEQ
                                                                (EXIT
                                                                 (LETT #7#
                                                                       (CONS
                                                                        (QVELT
                                                                         |uf|
                                                                         1)
                                                                        #7#))))
                                                               (LETT #6#
                                                                     (CDR #6#))
                                                               (GO G190) G191
                                                               (EXIT
                                                                (NREVERSE
                                                                 #7#)))))
                                                   (LETT |lffc| |lffc1|)
                                                   (COND
                                                    (|testp|
                                                     (LETT |leadcomp|
                                                           |leadcomp1|)))
                                                   (LETT |int| |lval|)
                                                   (LETT |leadtest| NIL)
                                                   (EXIT (LETT |nfatt| |nf|))))
                                                 ((> |nfatt| |nf|)
                                                  (SEQ
                                                   (COND
                                                    (|testp|
                                                     (LETT |leadtest|
                                                           (NULL
                                                            (SPADCALL
                                                             (SPADCALL |lffc|
                                                                       |clc|
                                                                       (QREFELT
                                                                        $ 58))
                                                             (LENGTH |plist|)
                                                             |leadcomp|
                                                             (QREFELT $
                                                                      181)))))
                                                    ('T (LETT |leadtest| NIL)))
                                                   (COND
                                                    ((NULL |leadtest|)
                                                     (SEQ
                                                      (LETT |unifact|
                                                            (PROGN
                                                             (LETT #4# NIL)
                                                             (SEQ
                                                              (LETT |uf| NIL)
                                                              (LETT #3#
                                                                    |lunivf|)
                                                              G190
                                                              (COND
                                                               ((OR (ATOM #3#)
                                                                    (PROGN
                                                                     (LETT |uf|
                                                                           (CAR
                                                                            #3#))
                                                                     NIL))
                                                                (GO G191)))
                                                              (SEQ
                                                               (EXIT
                                                                (LETT #4#
                                                                      (CONS
                                                                       (QVELT
                                                                        |uf| 1)
                                                                       #4#))))
                                                              (LETT #3#
                                                                    (CDR #3#))
                                                              (GO G190) G191
                                                              (EXIT
                                                               (NREVERSE
                                                                #4#)))))
                                                      (LETT |lffc| |lffc1|)
                                                      (COND
                                                       (|testp|
                                                        (LETT |leadcomp|
                                                              |leadcomp1|)))
                                                      (EXIT
                                                       (LETT |int| |lval|)))))
                                                   (EXIT
                                                    (LETT |nfatt|
                                                          |nf|)))))))))))))))))))
                     NIL (GO G190) G191 (EXIT NIL)))
               #28# (EXIT #8#))
              (EXIT (VECTOR (CONS |int| |ltry|) |unifact| |lffc| |leadcomp|))))) 

(SDEFUN |MFINFACT;constantCase|
        ((|m|
          (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F) OV))
         (|factorlist|
          (|List|
           (|Record|
            (|:| |irr|
                 (|SparseMultivariatePolynomial|
                  (|SparseUnivariatePolynomial| F) OV))
            (|:| |pow| (|NonNegativeInteger|)))))
         ($
          (|Record| (|:| |contp| (|SparseUnivariatePolynomial| F))
                    (|:| |factors|
                         (|List|
                          (|Record|
                           (|:| |irr|
                                (|SparseMultivariatePolynomial|
                                 (|SparseUnivariatePolynomial| F) OV))
                           (|:| |pow| (|NonNegativeInteger|))))))))
        (SPROG
         ((#1=#:G1126 NIL) (|pp| NIL) (#2=#:G1125 NIL)
          (|lunm|
           (|Record| (|:| |cont| F)
                     (|:| |factors|
                          (|List|
                           (|Record|
                            (|:| |irr| (|SparseUnivariatePolynomial| F))
                            (|:| |pow| (|NonNegativeInteger|))))))))
         (SEQ
          (LETT |lunm|
                (SPADCALL (SPADCALL |m| (QREFELT $ 144)) NIL (QREFELT $ 64)))
          (EXIT
           (CONS (SPADCALL (QCAR |lunm|) (QREFELT $ 109))
                 (SPADCALL |factorlist|
                           (PROGN
                            (LETT #2# NIL)
                            (SEQ (LETT |pp| NIL) (LETT #1# (QCDR |lunm|)) G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |pp| (CAR #1#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #2#
                                         (CONS
                                          (CONS
                                           (SPADCALL (QCAR |pp|)
                                                     (QREFELT $ 110))
                                           (QCDR |pp|))
                                          #2#))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT (NREVERSE #2#))))
                           (QREFELT $ 114))))))) 

(SDEFUN |MFINFACT;simplify|
        ((|m|
          (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F) OV))
         (|var| (OV)) (|dm| (|Integer|)) (|lvar| (|List| OV))
         (|lmdeg| (|List| (|NonNegativeInteger|)))
         ($
          (|Record| (|:| |contp| (|SparseUnivariatePolynomial| F))
                    (|:| |factors|
                         (|List|
                          (|Record|
                           (|:| |irr|
                                (|SparseMultivariatePolynomial|
                                 (|SparseUnivariatePolynomial| F) OV))
                           (|:| |pow| (|NonNegativeInteger|))))))))
        (SPROG
         ((|flead|
           (|Record| (|:| |contp| (|SparseUnivariatePolynomial| F))
                     (|:| |factors|
                          (|List|
                           (|Record|
                            (|:| |irr|
                                 (|SparseMultivariatePolynomial|
                                  (|SparseUnivariatePolynomial| F) OV))
                            (|:| |pow| (|NonNegativeInteger|)))))))
          (#1=#:G1133 NIL)
          (|factorlist|
           (|List|
            (|Record|
             (|:| |irr|
                  (|SparseMultivariatePolynomial|
                   (|SparseUnivariatePolynomial| F) OV))
             (|:| |pow| (|NonNegativeInteger|)))))
          (|pol1|
           (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                           OV))
          (|i| (|NonNegativeInteger|)) (#2=#:G1138 NIL) (|x| NIL))
         (SEQ (LETT |factorlist| NIL) (LETT |pol1| (|spadConstant| $ 28))
              (SEQ (LETT |x| NIL) (LETT #2# |lvar|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |i|
                          (SPADCALL |lmdeg|
                                    (SPADCALL |x| |lvar| (QREFELT $ 202))
                                    (QREFELT $ 203)))
                    (EXIT
                     (COND ((EQL |i| 0) "next value")
                           ('T
                            (SEQ
                             (LETT |pol1|
                                   (SPADCALL |pol1|
                                             (SPADCALL (|spadConstant| $ 28)
                                                       |x| |i| (QREFELT $ 204))
                                             (QREFELT $ 205)))
                             (EXIT
                              (LETT |factorlist|
                                    (CONS
                                     (CONS (SPADCALL |x| (QREFELT $ 206)) |i|)
                                     |factorlist|))))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (LETT |m|
                    (PROG2 (LETT #1# (SPADCALL |m| |pol1| (QREFELT $ 101)))
                        (QCDR #1#)
                      (|check_union2| (QEQCAR #1# 0)
                                      (|SparseMultivariatePolynomial|
                                       (|SparseUnivariatePolynomial|
                                        (QREFELT $ 8))
                                       (QREFELT $ 6))
                                      (|Union|
                                       (|SparseMultivariatePolynomial|
                                        (|SparseUnivariatePolynomial|
                                         (QREFELT $ 8))
                                        (QREFELT $ 6))
                                       "failed")
                                      #1#)))
              (EXIT
               (COND
                ((SPADCALL |m| (QREFELT $ 54))
                 (|MFINFACT;constantCase| |m| |factorlist| $))
                ('T
                 (SEQ (LETT |flead| (|MFINFACT;mFactor| |m| |var| |dm| $))
                      (PROGN
                       (RPLACD |flead|
                               (SPADCALL |factorlist| (QCDR |flead|)
                                         (QREFELT $ 114)))
                       (QCDR |flead|))
                      (EXIT |flead|)))))))) 

(SDEFUN |MFINFACT;mfconst|
        ((|um|
          (|SparseUnivariatePolynomial|
           (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                           OV)))
         (|dm| (|Integer|)) (|lvar| (|List| OV))
         (|ldeg| (|List| (|NonNegativeInteger|)))
         ($
          (|List|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                            OV)))))
        (SPROG
         ((#1=#:G1149 NIL) (|lumf| NIL) (#2=#:G1148 NIL)
          (|lum|
           (|Factored|
            (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F))))
          (|um1|
           (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| F))))
         (SEQ
          (COND
           ((NULL |lvar|)
            (SEQ (LETT |um1| (SPADCALL (ELT $ 207) |um| (QREFELT $ 210)))
                 (LETT |lum| (SPADCALL |um1| (QREFELT $ 198)))
                 (EXIT
                  (PROGN
                   (LETT #2# NIL)
                   (SEQ (LETT |lumf| NIL)
                        (LETT #1# (SPADCALL |lum| (QREFELT $ 196))) G190
                        (COND
                         ((OR (ATOM #1#) (PROGN (LETT |lumf| (CAR #1#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #2#
                                (CONS
                                 (SPADCALL (ELT $ 110) (QVELT |lumf| 1)
                                           (QREFELT $ 213))
                                 #2#))))
                        (LETT #1# (CDR #1#)) (GO G190) G191
                        (EXIT (NREVERSE #2#)))))))
           ('T
            (|MFINFACT;intfact| |um| |lvar| |ldeg|
             (CONS (|spadConstant| $ 24) NIL) NIL $)))))) 

(SDEFUN |MFINFACT;mfpol|
        ((|um|
          (|SparseUnivariatePolynomial|
           (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                           OV)))
         (|var| (OV)) (|dm| (|Integer|)) (|lvar| (|List| OV))
         (|ldeg| (|List| (|NonNegativeInteger|)))
         ($
          (|List|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                            OV)))))
        (SPROG
         ((|tleadpol|
           (|Record| (|:| |contp| (|SparseUnivariatePolynomial| F))
                     (|:| |factors|
                          (|List|
                           (|Record|
                            (|:| |irr|
                                 (|SparseMultivariatePolynomial|
                                  (|SparseUnivariatePolynomial| F) OV))
                            (|:| |pow| (|NonNegativeInteger|))))))))
         (SEQ
          (LETT |tleadpol|
                (|MFINFACT;mFactor| (SPADCALL |um| (QREFELT $ 53)) |var| |dm|
                 $))
          (EXIT (|MFINFACT;intfact| |um| |lvar| |ldeg| |tleadpol| NIL $))))) 

(SDEFUN |MFINFACT;factor;PGF;20| ((|m| (PG)) ($ (|Factored| PG)))
        (SPROG
         ((#1=#:G1161 NIL) (#2=#:G1160 #3=(|Factored| PG)) (#4=#:G1162 #3#)
          (#5=#:G1169 NIL) (|u| NIL)
          (|flist|
           (|Record| (|:| |contp| (|SparseUnivariatePolynomial| F))
                     (|:| |factors|
                          (|List|
                           (|Record|
                            (|:| |irr|
                                 (|SparseMultivariatePolynomial|
                                  (|SparseUnivariatePolynomial| F) OV))
                            (|:| |pow| (|NonNegativeInteger|)))))))
          (|cm|
           (|SparseMultivariatePolynomial| (|SparseUnivariatePolynomial| F)
                                           OV))
          (|var| (OV)) (|dx| #6=(|NonNegativeInteger|)) (#7=#:G1157 NIL)
          (#8=#:G1156 #6#) (#9=#:G1158 #6#) (#10=#:G1168 NIL) (#11=#:G691 NIL)
          (|ld| (|List| #6#)) (#12=#:G1167 NIL) (|x| NIL) (#13=#:G1166 NIL)
          (|lv| (|List| OV)))
         (SEQ (LETT |lv| (SPADCALL |m| (QREFELT $ 214)))
              (EXIT
               (COND
                ((SPADCALL |lv| NIL (QREFELT $ 215))
                 (SPADCALL |m| NIL (QREFELT $ 216)))
                (#14='T
                 (SEQ
                  (LETT |ld|
                        (PROGN
                         (LETT #13# NIL)
                         (SEQ (LETT |x| NIL) (LETT #12# |lv|) G190
                              (COND
                               ((OR (ATOM #12#)
                                    (PROGN (LETT |x| (CAR #12#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #13#
                                      (CONS (SPADCALL |m| |x| (QREFELT $ 217))
                                            #13#))))
                              (LETT #12# (CDR #12#)) (GO G190) G191
                              (EXIT (NREVERSE #13#)))))
                  (LETT |dx|
                        (PROGN
                         (LETT #7# NIL)
                         (SEQ (LETT #11# NIL) (LETT #10# |ld|) G190
                              (COND
                               ((OR (ATOM #10#)
                                    (PROGN (LETT #11# (CAR #10#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (PROGN
                                 (LETT #9# #11#)
                                 (COND (#7# (LETT #8# (MIN #8# #9#)))
                                       ('T
                                        (PROGN
                                         (LETT #8# #9#)
                                         (LETT #7# 'T)))))))
                              (LETT #10# (CDR #10#)) (GO G190) G191 (EXIT NIL))
                         (COND (#7# #8#) (#14# (|IdentityError| '|min|)))))
                  (LETT |var|
                        (SPADCALL |lv| (SPADCALL |dx| |ld| (QREFELT $ 83))
                                  (QREFELT $ 84)))
                  (LETT |cm| (|MFINFACT;pushdown| |m| |var| $))
                  (LETT |flist| (|MFINFACT;mFactor| |cm| |var| |dx| $))
                  (EXIT
                   (SPADCALL (|MFINFACT;pushupconst| (QCAR |flist|) |var| $)
                             (PROGN
                              (LETT #1# NIL)
                              (SEQ (LETT |u| NIL) (LETT #5# (QCDR |flist|))
                                   G190
                                   (COND
                                    ((OR (ATOM #5#)
                                         (PROGN (LETT |u| (CAR #5#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (PROGN
                                      (LETT #4#
                                            (SPADCALL
                                             (|MFINFACT;pushup| (QCAR |u|)
                                              |var| $)
                                             (QCDR |u|) (QREFELT $ 218)))
                                      (COND
                                       (#1#
                                        (LETT #2#
                                              (SPADCALL #2# #4#
                                                        (QREFELT $ 219))))
                                       ('T
                                        (PROGN
                                         (LETT #2# #4#)
                                         (LETT #1# 'T)))))))
                                   (LETT #5# (CDR #5#)) (GO G190) G191
                                   (EXIT NIL))
                              (COND (#1# #2#) (#14# (|spadConstant| $ 220))))
                             (QREFELT $ 221)))))))))) 

(DECLAIM (NOTINLINE |MultFiniteFactorize;|)) 

(DEFUN |MultFiniteFactorize| (&REST #1=#:G1170)
  (SPROG NIL
         (PROG (#2=#:G1171)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|MultFiniteFactorize|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |MultFiniteFactorize;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|MultFiniteFactorize|)))))))))) 

(DEFUN |MultFiniteFactorize;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|MultFiniteFactorize| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 223))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|MultFiniteFactorize|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|MultFiniteFactorize| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|)
              (|SparseMultivariatePolynomial| 23 6)
              (|SparseUnivariatePolynomial| 10) (0 . |coerce|)
              (|NonNegativeInteger|) (5 . |degree|) (10 . |ground|) (|List| 10)
              (15 . |coefficients|) (|List| 6) (20 . |variables|)
              (25 . |setUnion|) (31 . |Zero|) (35 . |Zero|)
              (|SparseUnivariatePolynomial| 8) (39 . |Zero|)
              (43 . |minimumDegree|) (48 . |One|) (52 . |One|) (56 . |One|)
              (60 . |monomial|) (|Union| $ '"failed") (66 . |exquo|)
              (|Record| (|:| |irr| 11) (|:| |pow| 13)) (|List| 32)
              (72 . |append|) (|SparseUnivariatePolynomial| 9) (|Mapping| 9 10)
              (|UnivariatePolynomialCategoryFunctions2| 10 11 9 35)
              (78 . |map|) (|Factored| $) (84 . |squareFree|) (|Factored| 35)
              (89 . |unit|) (|Mapping| 10 9)
              (|UnivariatePolynomialCategoryFunctions2| 9 35 10 11)
              (94 . |map|) (|Boolean|) (100 . |ground?|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 48) (|:| |factor| 35) (|:| |exponent| 13))
              (|List| 49) (105 . |factorList|) (110 . |degree|)
              (116 . |leadingCoefficient|) (121 . |ground?|) (126 . |concat!|)
              (132 . |leadingCoefficient|) (137 . ^) (143 . *) (149 . |One|)
              (153 . |exquo|) (|Record| (|:| |irr| 23) (|:| |pow| 13))
              (|Record| (|:| |cont| 8) (|:| |factors| (|List| 61)))
              (|DistinctDegreeFactorize| 8 23) (159 . |distdfact|)
              (165 . |coerce|) (|Mapping| 9 8)
              (|UnivariatePolynomialCategoryFunctions2| 8 23 9 35)
              (170 . |map|) (176 . |primeFactor|) (182 . *) (188 . |One|)
              (192 . |coerce|) (197 . |makeFR|) (|FactoringUtilities| 7 6 8 9)
              (203 . |variables|) (208 . |ground|) (|Mapping| 8 9)
              (|UnivariatePolynomialCategoryFunctions2| 9 35 8 23)
              (213 . |map|) (|List| 13) (219 . |degree|) (|Integer|)
              (225 . |position|) (231 . |elt|) (237 . *)
              |MFINFACT;factor;SupF;4| (243 . |minimumDegree|)
              (249 . |squareFree|) (|Factored| 9) (254 . |unit|)
              (|Record| (|:| |flag| 48) (|:| |factor| 9) (|:| |exponent| 13))
              (|List| 91) (259 . |factorList|) (264 . |degree|) (270 . |One|)
              (274 . |member?|) (|SparseUnivariatePolynomial| $)
              (280 . |univariate|) (|List| $) (286 . |gcd|) (291 . |exquo|)
              (297 . ~=) (303 . ~=) (309 . |exquo|) (315 . |multivariate|)
              (321 . |leadingCoefficient|) (326 . ~=) (332 . |inv|)
              (337 . |coerce|) (342 . |coerce|) (347 . *)
              (|Record| (|:| |irr| 10) (|:| |pow| 13)) (|List| 112)
              (353 . |append|) (359 . |monomial|) (365 . |size|)
              (|PositiveInteger|) (369 . |index|) (374 . +) (|List| 137)
              (|GenExEuclid| 23 137) (380 . |testModulus|)
              (|FiniteFieldPolynomialPackage| 8)
              (386 . |createIrreduciblePoly|) (|Union| 23 '"failed")
              (391 . |nextIrreduciblePoly|) (|Mapping| 23 8)
              (|MPolyCatFunctions2| 6 7 (|IndexedExponents| 6) 8 23 9 10)
              (396 . |map|)
              (|Record| (|:| |polfac| 16) (|:| |correct| 23)
                        (|:| |corrfact| 120))
              (|Union| 130 '"failed")
              (|Record| (|:| |contp| 23) (|:| |factors| 113)) (|List| 23)
              (|LeadingCoefDetermination| 6 (|IndexedExponents| 6) 23 10)
              (402 . |distFact|) (412 . ~=) (|SparseUnivariatePolynomial| 23)
              (418 . |elt|) (424 . *) (|Union| (|List| 11) '"failed")
              (|MultivariateLifting| (|IndexedExponents| 6) 6 23 10)
              (430 . |lifting|) (441 . |primitivePart|) (446 . |retract|)
              (451 . |Zero|) (455 . |Zero|) (459 . |leadingMonomial|)
              (464 . |monomial|) (471 . +) (477 . |reductum|) (482 . |ground?|)
              (487 . |retract|) (492 . |univariate|) (498 . |Zero|) (502 . ~=)
              (508 . |degree|) (513 . |leadingCoefficient|) (518 . *) (524 . +)
              (530 . |reductum|) (535 . |ground?|) (540 . |retract|)
              (545 . |degree|) (550 . |monomial|) (557 . |reductum|)
              (562 . |random|) (566 . |delete|) (572 . |delete|)
              (578 . |degree|) (583 . =) (|List| 133) (589 . |member?|)
              (595 . |eval|) (602 . |unit?|)
              (|FactoringUtilities| (|IndexedExponents| 6) 6 23 10)
              (607 . |completeEval|) (614 . ~=) (620 . |minimumDegree|)
              (625 . |content|) (630 . |exquo|) (636 . |polCase|)
              (643 . |differentiate|) (648 . |differentiate|)
              (653 . |differentiate|) (658 . |differentiate|)
              (663 . |differentiate|) (|Mapping| 23 23) (668 . |map|)
              (674 . |gcd|) (679 . |leadingCoefficient|) (|Factored| 137)
              (|TwoFactorize| 8) (684 . |tryTwoFactor|)
              (|Record| (|:| |flag| 48) (|:| |factor| 137) (|:| |exponent| 13))
              (|List| 194) (689 . |factorList|) (694 . |elt|)
              (700 . |generalTwoFactor|) (705 . |unit|) (710 . |retract|)
              (715 . *) (721 . |position|) (727 . |elt|) (733 . |monomial|)
              (740 . *) (746 . |coerce|) (751 . |ground|) (|Mapping| 23 10)
              (|UnivariatePolynomialCategoryFunctions2| 10 11 23 137)
              (756 . |map|) (|Mapping| 10 23)
              (|UnivariatePolynomialCategoryFunctions2| 23 137 10 11)
              (762 . |map|) (768 . |variables|) (773 . =) (779 . |makeFR|)
              (785 . |degree|) (791 . |primeFactor|) (797 . *) (803 . |One|)
              (807 . *) |MFINFACT;factor;PGF;20|)
           '#(|factor| 813) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|factor| ((|Factored| |#4|) |#4|)) T)
                                   '((|factor|
                                      ((|Factored|
                                        (|SparseUnivariatePolynomial| |#4|))
                                       (|SparseUnivariatePolynomial| |#4|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 222
                                            '(1 11 0 10 12 1 11 13 0 14 1 11 10
                                              0 15 1 11 16 0 17 1 10 18 0 19 2
                                              18 0 0 0 20 0 7 0 21 0 8 0 22 0
                                              23 0 24 1 11 13 0 25 0 8 0 26 0 9
                                              0 27 0 10 0 28 2 11 0 10 13 29 2
                                              11 30 0 0 31 2 33 0 0 0 34 2 37
                                              35 36 11 38 1 35 39 0 40 1 41 35
                                              0 42 2 44 11 43 35 45 1 11 46 0
                                              47 1 41 50 0 51 2 10 13 0 6 52 1
                                              11 10 0 53 1 10 46 0 54 2 33 0 0
                                              0 55 1 10 23 0 56 2 23 0 0 13 57
                                              2 23 0 0 0 58 0 23 0 59 2 23 30 0
                                              0 60 2 63 62 23 46 64 1 9 0 8 65
                                              2 67 35 66 23 68 2 41 0 35 13 69
                                              2 41 0 0 0 70 0 41 0 71 1 35 0 9
                                              72 2 41 0 35 50 73 1 74 18 35 75
                                              1 9 8 0 76 2 78 23 77 35 79 2 74
                                              80 35 18 81 2 80 82 13 0 83 2 18
                                              6 0 82 84 2 41 0 35 0 85 2 10 80
                                              0 18 87 1 9 39 0 88 1 89 9 0 90 1
                                              89 92 0 93 2 10 80 0 18 94 0 11 0
                                              95 2 80 46 13 0 96 2 10 97 0 6 98
                                              1 10 0 99 100 2 10 30 0 0 101 2 6
                                              46 0 0 102 2 10 46 0 0 103 2 11
                                              30 0 10 104 2 10 0 97 6 105 1 23
                                              8 0 106 2 8 46 0 0 107 1 8 0 0
                                              108 1 23 0 8 109 1 10 0 23 110 2
                                              11 0 10 0 111 2 113 0 0 0 114 2
                                              23 0 8 13 115 0 8 13 116 1 8 0
                                              117 118 2 23 0 0 0 119 2 121 46
                                              23 120 122 1 123 23 117 124 1 123
                                              125 23 126 2 128 10 127 9 129 6
                                              134 131 23 120 132 133 18 133 135
                                              2 23 46 0 0 136 2 120 137 0 82
                                              138 2 137 0 23 0 139 7 141 140 11
                                              18 120 133 16 80 23 142 1 11 0 0
                                              143 1 10 23 0 144 0 9 0 145 0 10
                                              0 146 1 10 0 0 147 3 9 0 0 18 80
                                              148 2 9 0 0 0 149 1 10 0 0 150 1
                                              9 46 0 151 1 9 8 0 152 2 9 97 0 6
                                              153 0 35 0 154 2 35 46 0 0 155 1
                                              35 13 0 156 1 35 9 0 157 2 10 0
                                              23 0 158 2 10 0 0 0 159 1 35 0 0
                                              160 1 23 46 0 161 1 23 8 0 162 1
                                              23 13 0 163 3 9 0 0 6 13 164 1 23
                                              0 0 165 0 8 0 166 2 80 0 0 82 167
                                              2 18 0 0 82 168 1 137 13 0 169 2
                                              16 46 0 0 170 2 171 46 133 0 172
                                              3 10 0 0 18 133 173 1 23 46 0 174
                                              3 175 137 11 18 133 176 2 13 46 0
                                              0 177 1 137 13 0 178 1 137 23 0
                                              179 2 137 30 0 23 180 3 134 46 23
                                              13 133 181 1 137 0 0 182 1 8 0 0
                                              183 1 35 0 0 184 1 23 0 0 185 1
                                              11 0 0 186 2 137 0 187 0 188 1
                                              137 0 99 189 1 137 23 0 190 1 192
                                              191 137 193 1 191 195 0 196 2 195
                                              194 0 82 197 1 192 191 137 198 1
                                              191 137 0 199 1 137 23 0 200 2 23
                                              0 8 0 201 2 18 82 6 0 202 2 80 13
                                              0 82 203 3 10 0 0 6 13 204 2 10 0
                                              0 0 205 1 10 0 6 206 1 10 23 0
                                              207 2 209 137 208 11 210 2 212 11
                                              211 137 213 1 9 18 0 214 2 18 46
                                              0 0 215 2 89 0 9 92 216 2 9 13 0
                                              6 217 2 89 0 9 13 218 2 89 0 0 0
                                              219 0 89 0 220 2 89 0 9 0 221 1 0
                                              41 35 86 1 0 89 9 222)))))
           '|lookupComplete|)) 
