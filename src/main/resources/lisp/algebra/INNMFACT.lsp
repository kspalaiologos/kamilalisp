
(SDEFUN |INNMFACT;convertPUP|
        ((|lfg|
          (|Record| (|:| |contp| R)
                    (|:| |factors|
                         (|List|
                          (|Record| (|:| |irr| P)
                                    (|:| |pow| (|NonNegativeInteger|)))))))
         ($
          (|Record| (|:| |contp| R)
                    (|:| |factors|
                         (|List|
                          (|Record|
                           (|:| |irr| (|SparseUnivariatePolynomial| P))
                           (|:| |pow| (|NonNegativeInteger|))))))))
        (SPROG ((#1=#:G738 NIL) (|lff| NIL) (#2=#:G737 NIL))
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

(SDEFUN |INNMFACT;supFactor|
        ((|um| (|SparseUnivariatePolynomial| P))
         (|ufactor|
          (|Mapping| #1=(|Factored| (|SparseUnivariatePolynomial| R))
                     (|SparseUnivariatePolynomial| R)))
         ($
          (|Record| (|:| |contp| R)
                    (|:| |factors|
                         (|List|
                          (|Record|
                           (|:| |irr| (|SparseUnivariatePolynomial| P))
                           (|:| |pow| (|NonNegativeInteger|))))))))
        (SPROG
         ((#2=#:G798 NIL) (|uum1| (R)) (|lcfacs| (R)) (#3=#:G795 NIL)
          (#4=#:G794 (R)) (#5=#:G796 (R)) (#6=#:G816 NIL) (|f| NIL)
          (|factorlist|
           (|List|
            (|Record| (|:| |irr| (|SparseUnivariatePolynomial| P))
                      (|:| |pow| (|NonNegativeInteger|)))))
          (|auxfl|
           (|List|
            #7=(|Record| (|:| |irr| (|SparseUnivariatePolynomial| P))
                         (|:| |pow| (|NonNegativeInteger|)))))
          (#8=#:G815 NIL) (|lfp| NIL) (#9=#:G814 NIL)
          (|lf| (|List| (|SparseUnivariatePolynomial| P)))
          (|ldeg| (|List| #10=(|NonNegativeInteger|))) (#11=#:G783 NIL)
          (#12=#:G782 #10#) (#13=#:G784 #10#) (#14=#:G813 NIL) (|fc| NIL)
          (#15=#:G812 NIL) (|xx| NIL) (#16=#:G811 NIL) (|coefs| (|List| P))
          (#17=#:G810 NIL) (|lff| NIL) (#18=#:G809 NIL) (|lcont| (P))
          (|lfg|
           (|Record| (|:| |contp| R)
                     (|:| |factors|
                          (|List|
                           (|Record| (|:| |irr| P)
                                     (|:| |pow| (|NonNegativeInteger|)))))))
          (|ffexp| #19=(|NonNegativeInteger|))
          (|ffactor| #20=(|SparseUnivariatePolynomial| P)) (#21=#:G808 NIL)
          (|fact| NIL)
          (|sqqfact|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| #20#) (|:| |exponent| #19#))))
          (|flead| (|Record| (|:| |contp| R) (|:| |factors| (|List| #7#))))
          (|sqfacs| (|Factored| (|SparseUnivariatePolynomial| P)))
          (|uum|
           (|Record| (|:| |unit| (|SparseUnivariatePolynomial| P))
                     (|:| |canonical| (|SparseUnivariatePolynomial| P))
                     (|:| |associate| (|SparseUnivariatePolynomial| P))))
          (#22=#:G804 NIL) (#23=#:G761 NIL)
          (|f1| (|SparseUnivariatePolynomial| P))
          (|mdeg| (|NonNegativeInteger|)) (#24=#:G807 NIL) (|ff| NIL)
          (#25=#:G806 NIL) (|lfact| #1#)
          (|umv| (|SparseUnivariatePolynomial| R)) (|lvar| #26=(|List| OV))
          (#27=#:G751 NIL) (#28=#:G750 #26#) (#29=#:G752 #26#) (#30=#:G805 NIL)
          (|cf| NIL))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |um| (QREFELT $ 14))
             (|INNMFACT;convertPUP|
              (|INNMFACT;mFactor| (SPADCALL |um| (QREFELT $ 15)) |ufactor| $)
              $))
            (#31='T
             (SEQ
              (LETT |lvar|
                    (PROGN
                     (LETT #27# NIL)
                     (SEQ (LETT |cf| NIL)
                          (LETT #30# (SPADCALL |um| (QREFELT $ 17))) G190
                          (COND
                           ((OR (ATOM #30#) (PROGN (LETT |cf| (CAR #30#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (PROGN
                             (LETT #29# (SPADCALL |cf| (QREFELT $ 19)))
                             (COND
                              (#27#
                               (LETT #28# (SPADCALL #28# #29# (QREFELT $ 20))))
                              ('T (PROGN (LETT #28# #29#) (LETT #27# 'T)))))))
                          (LETT #30# (CDR #30#)) (GO G190) G191 (EXIT NIL))
                     (COND (#27# #28#) (#31# (|IdentityError| '|setUnion|)))))
              (EXIT
               (COND
                ((NULL |lvar|)
                 (SEQ (LETT |umv| (SPADCALL (ELT $ 21) |um| (QREFELT $ 25)))
                      (LETT |lfact| (SPADCALL |umv| |ufactor|))
                      (EXIT
                       (CONS
                        (SPADCALL (SPADCALL |lfact| (QREFELT $ 27))
                                  (QREFELT $ 28))
                        (PROGN
                         (LETT #25# NIL)
                         (SEQ (LETT |ff| NIL)
                              (LETT #24# (SPADCALL |lfact| (QREFELT $ 32)))
                              G190
                              (COND
                               ((OR (ATOM #24#)
                                    (PROGN (LETT |ff| (CAR #24#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #25#
                                      (CONS
                                       (CONS
                                        (SPADCALL (ELT $ 33) (QVELT |ff| 1)
                                                  (QREFELT $ 36))
                                        (QVELT |ff| 2))
                                       #25#))))
                              (LETT #24# (CDR #24#)) (GO G190) G191
                              (EXIT (NREVERSE #25#))))))))
                (#31#
                 (SEQ (LETT |flead| (CONS (|spadConstant| $ 38) NIL))
                      (LETT |factorlist| NIL)
                      (LETT |mdeg| (SPADCALL |um| (QREFELT $ 40)))
                      (COND
                       ((> |mdeg| 0)
                        (SEQ
                         (LETT |f1|
                               (SPADCALL (|spadConstant| $ 42) |mdeg|
                                         (QREFELT $ 43)))
                         (LETT |um|
                               (PROG2
                                   (LETT #23#
                                         (SPADCALL |um| |f1| (QREFELT $ 45)))
                                   (QCDR #23#)
                                 (|check_union2| (QEQCAR #23# 0)
                                                 (|SparseUnivariatePolynomial|
                                                  (QREFELT $ 9))
                                                 (|Union|
                                                  (|SparseUnivariatePolynomial|
                                                   (QREFELT $ 9))
                                                  "failed")
                                                 #23#)))
                         (LETT |factorlist|
                               (CONS
                                (CONS
                                 (SPADCALL (|spadConstant| $ 42) 1
                                           (QREFELT $ 43))
                                 |mdeg|)
                                |factorlist|))
                         (EXIT
                          (COND
                           ((EQL (SPADCALL |um| (QREFELT $ 46)) 0)
                            (PROGN
                             (LETT #22#
                                   (SEQ
                                    (LETT |lfg|
                                          (|INNMFACT;convertPUP|
                                           (|INNMFACT;mFactor|
                                            (SPADCALL |um| (QREFELT $ 15))
                                            |ufactor| $)
                                           $))
                                    (EXIT
                                     (CONS (QCAR |lfg|)
                                           (SPADCALL |factorlist| (QCDR |lfg|)
                                                     (QREFELT $ 49))))))
                             (GO #32=#:G803))))))))
                      (LETT |uum| (SPADCALL |um| (QREFELT $ 51)))
                      (LETT |um| (QVELT |uum| 1))
                      (LETT |sqfacs| (SPADCALL |um| (QREFELT $ 54)))
                      (LETT |lcont|
                            (SPADCALL
                             (SPADCALL (QVELT |uum| 0)
                                       (SPADCALL |sqfacs| (QREFELT $ 55))
                                       (QREFELT $ 56))
                             (QREFELT $ 15)))
                      (LETT |flead|
                            (|INNMFACT;convertPUP|
                             (|INNMFACT;mFactor| |lcont| |ufactor| $) $))
                      (LETT |factorlist|
                            (SPADCALL (QCDR |flead|) |factorlist|
                                      (QREFELT $ 49)))
                      (LETT |sqqfact| (SPADCALL |sqfacs| (QREFELT $ 59)))
                      (SEQ (LETT |fact| NIL) (LETT #21# |sqqfact|) G190
                           (COND
                            ((OR (ATOM #21#)
                                 (PROGN (LETT |fact| (CAR #21#)) NIL))
                             (GO G191)))
                           (SEQ (LETT |ffactor| (QVELT |fact| 1))
                                (LETT |ffexp| (QVELT |fact| 2))
                                (EXIT
                                 (COND
                                  ((ZEROP (SPADCALL |ffactor| (QREFELT $ 46)))
                                   (SEQ
                                    (LETT |lfg|
                                          (|INNMFACT;mFactor|
                                           (SPADCALL |ffactor| (QREFELT $ 15))
                                           |ufactor| $))
                                    (LETT |lcont|
                                          (SPADCALL (QCAR |lfg|) |lcont|
                                                    (QREFELT $ 60)))
                                    (EXIT
                                     (LETT |factorlist|
                                           (SPADCALL |factorlist|
                                                     (PROGN
                                                      (LETT #18# NIL)
                                                      (SEQ (LETT |lff| NIL)
                                                           (LETT #17#
                                                                 (QCDR |lfg|))
                                                           G190
                                                           (COND
                                                            ((OR (ATOM #17#)
                                                                 (PROGN
                                                                  (LETT |lff|
                                                                        (CAR
                                                                         #17#))
                                                                  NIL))
                                                             (GO G191)))
                                                           (SEQ
                                                            (EXIT
                                                             (LETT #18#
                                                                   (CONS
                                                                    (CONS
                                                                     (SPADCALL
                                                                      (QCAR
                                                                       |lff|)
                                                                      (QREFELT
                                                                       $ 12))
                                                                     (*
                                                                      (QCDR
                                                                       |lff|)
                                                                      |ffexp|))
                                                                    #18#))))
                                                           (LETT #17#
                                                                 (CDR #17#))
                                                           (GO G190) G191
                                                           (EXIT
                                                            (NREVERSE #18#))))
                                                     (QREFELT $ 49))))))
                                  ('T
                                   (SEQ
                                    (LETT |coefs|
                                          (SPADCALL |ffactor| (QREFELT $ 17)))
                                    (LETT |ldeg|
                                          (PROGN
                                           (LETT #16# NIL)
                                           (SEQ (LETT |xx| NIL)
                                                (LETT #15# |lvar|) G190
                                                (COND
                                                 ((OR (ATOM #15#)
                                                      (PROGN
                                                       (LETT |xx| (CAR #15#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT #16#
                                                        (CONS
                                                         (PROGN
                                                          (LETT #11# NIL)
                                                          (SEQ (LETT |fc| NIL)
                                                               (LETT #14#
                                                                     |coefs|)
                                                               G190
                                                               (COND
                                                                ((OR
                                                                  (ATOM #14#)
                                                                  (PROGN
                                                                   (LETT |fc|
                                                                         (CAR
                                                                          #14#))
                                                                   NIL))
                                                                 (GO G191)))
                                                               (SEQ
                                                                (EXIT
                                                                 (PROGN
                                                                  (LETT #13#
                                                                        (SPADCALL
                                                                         |fc|
                                                                         |xx|
                                                                         (QREFELT
                                                                          $
                                                                          61)))
                                                                  (COND
                                                                   (#11#
                                                                    (LETT #12#
                                                                          (MAX
                                                                           #12#
                                                                           #13#)))
                                                                   ('T
                                                                    (PROGN
                                                                     (LETT #12#
                                                                           #13#)
                                                                     (LETT #11#
                                                                           'T)))))))
                                                               (LETT #14#
                                                                     (CDR
                                                                      #14#))
                                                               (GO G190) G191
                                                               (EXIT NIL))
                                                          (COND (#11# #12#)
                                                                ('T
                                                                 (|IdentityError|
                                                                  '|max|))))
                                                         #16#))))
                                                (LETT #15# (CDR #15#))
                                                (GO G190) G191
                                                (EXIT (NREVERSE #16#)))))
                                    (LETT |lf|
                                          (COND
                                           ((SPADCALL
                                             (SPADCALL |ffactor|
                                                       (QREFELT $ 62))
                                             (QREFELT $ 63))
                                            (|INNMFACT;mfconst| |ffactor|
                                             |lvar| |ldeg| |ufactor| $))
                                           ('T
                                            (|INNMFACT;mfpol| |ffactor| |lvar|
                                             |ldeg| |ufactor| $))))
                                    (LETT |auxfl|
                                          (PROGN
                                           (LETT #9# NIL)
                                           (SEQ (LETT |lfp| NIL)
                                                (LETT #8# |lf|) G190
                                                (COND
                                                 ((OR (ATOM #8#)
                                                      (PROGN
                                                       (LETT |lfp| (CAR #8#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT #9#
                                                        (CONS
                                                         (CONS |lfp| |ffexp|)
                                                         #9#))))
                                                (LETT #8# (CDR #8#)) (GO G190)
                                                G191 (EXIT (NREVERSE #9#)))))
                                    (EXIT
                                     (LETT |factorlist|
                                           (SPADCALL |factorlist| |auxfl|
                                                     (QREFELT $ 49)))))))))
                           (LETT #21# (CDR #21#)) (GO G190) G191 (EXIT NIL))
                      (LETT |lcfacs|
                            (PROGN
                             (LETT #3# NIL)
                             (SEQ (LETT |f| NIL) (LETT #6# |factorlist|) G190
                                  (COND
                                   ((OR (ATOM #6#)
                                        (PROGN (LETT |f| (CAR #6#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (PROGN
                                     (LETT #5#
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL (QCAR |f|)
                                                       (QREFELT $ 62))
                                             (QREFELT $ 64))
                                            (QCDR |f|) (QREFELT $ 65)))
                                     (COND
                                      (#3#
                                       (LETT #4#
                                             (SPADCALL #4# #5#
                                                       (QREFELT $ 66))))
                                      ('T
                                       (PROGN
                                        (LETT #4# #5#)
                                        (LETT #3# 'T)))))))
                                  (LETT #6# (CDR #6#)) (GO G190) G191
                                  (EXIT NIL))
                             (COND (#3# #4#) (#31# (|spadConstant| $ 41)))))
                      (LETT |uum1|
                            (SPADCALL (SPADCALL (QVELT |uum| 0) (QREFELT $ 67))
                                      (QREFELT $ 68)))
                      (EXIT
                       (CONS
                        (SPADCALL |uum1|
                                  (PROG2
                                      (LETT #2#
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL |um| (QREFELT $ 62))
                                              (QREFELT $ 64))
                                             |lcfacs| (QREFELT $ 69)))
                                      (QCDR #2#)
                                    (|check_union2| (QEQCAR #2# 0)
                                                    (QREFELT $ 8)
                                                    (|Union| (QREFELT $ 8)
                                                             "failed")
                                                    #2#))
                                  (QREFELT $ 66))
                        |factorlist|))))))))))
          #32# (EXIT #22#)))) 

(SDEFUN |INNMFACT;factor;SupMF;3|
        ((|um| (|SparseUnivariatePolynomial| P))
         (|ufactor|
          (|Mapping| (|Factored| (|SparseUnivariatePolynomial| R))
                     (|SparseUnivariatePolynomial| R)))
         ($ (|Factored| (|SparseUnivariatePolynomial| P))))
        (SPROG
         ((#1=#:G820 NIL)
          (#2=#:G819 #3=(|Factored| (|SparseUnivariatePolynomial| P)))
          (#4=#:G821 #3#) (#5=#:G825 NIL) (|u| NIL)
          (|flist|
           (|Record| (|:| |contp| R)
                     (|:| |factors|
                          (|List|
                           (|Record|
                            (|:| |irr| (|SparseUnivariatePolynomial| P))
                            (|:| |pow| (|NonNegativeInteger|))))))))
         (SEQ (LETT |flist| (|INNMFACT;supFactor| |um| |ufactor| $))
              (EXIT
               (SPADCALL
                (SPADCALL (SPADCALL (QCAR |flist|) (QREFELT $ 33))
                          (QREFELT $ 12))
                (PROGN
                 (LETT #1# NIL)
                 (SEQ (LETT |u| NIL) (LETT #5# (QCDR |flist|)) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |u| (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #4#
                               (SPADCALL (QCAR |u|) (QCDR |u|) (QREFELT $ 70)))
                         (COND
                          (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 71))))
                          ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                      (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                 (COND (#1# #2#) ('T (|spadConstant| $ 72))))
                (QREFELT $ 73)))))) 

(SDEFUN |INNMFACT;varChoose|
        ((|m| (P)) (|lvar| (|List| OV))
         (|ldeg| (|List| #1=(|NonNegativeInteger|)))
         ($
          (|Record| (|:| |npol| (|SparseUnivariatePolynomial| P))
                    (|:| |nvar| (|List| OV))
                    (|:| |newdeg| (|List| (|NonNegativeInteger|))))))
        (SPROG
         ((|x| (OV)) (|i| (|Integer|)) (|k| #1#) (#2=#:G828 NIL)
          (#3=#:G827 #1#) (#4=#:G829 #1#) (#5=#:G841 NIL) (|d| NIL))
         (SEQ
          (LETT |k|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |d| NIL) (LETT #5# |ldeg|) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |d| (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #4# |d|)
                         (COND (#2# (LETT #3# (MIN #3# #4#)))
                               ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                      (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                 (COND (#2# #3#) (#6='T (|IdentityError| '|min|)))))
          (EXIT
           (COND
            ((EQL |k| (SPADCALL |m| (|SPADfirst| |lvar|) (QREFELT $ 61)))
             (VECTOR (SPADCALL |m| (|SPADfirst| |lvar|) (QREFELT $ 77)) |lvar|
                     |ldeg|))
            (#6#
             (SEQ (LETT |i| (SPADCALL |k| |ldeg| (QREFELT $ 80)))
                  (LETT |x| (SPADCALL |lvar| |i| (QREFELT $ 81)))
                  (LETT |ldeg| (CONS |k| (SPADCALL |ldeg| |i| (QREFELT $ 82))))
                  (LETT |lvar| (CONS |x| (SPADCALL |lvar| |i| (QREFELT $ 83))))
                  (EXIT
                   (VECTOR (SPADCALL |m| |x| (QREFELT $ 77)) |lvar|
                           |ldeg|))))))))) 

(SDEFUN |INNMFACT;localNorm|
        ((|lum| (|List| (|SparseUnivariatePolynomial| R))) ($ #1=(|Integer|)))
        (SPROG
         ((#2=#:G847 NIL) (#3=#:G846 #1#) (#4=#:G848 #1#) (#5=#:G852 NIL)
          (#6=#:G851 #1#) (#7=#:G853 #1#) (|cc| (R)) (#8=#:G857 NIL) (|i| NIL)
          (#9=#:G856 NIL) (|ff| NIL) (#10=#:G844 NIL) (#11=#:G843 #1#)
          (#12=#:G845 #1#) (#13=#:G855 NIL))
         (SEQ
          (COND
           ((|domainEqual| (QREFELT $ 8) (|AlgebraicNumber|))
            (PROGN
             (LETT #10# NIL)
             (SEQ (LETT |ff| NIL) (LETT #13# |lum|) G190
                  (COND
                   ((OR (ATOM #13#) (PROGN (LETT |ff| (CAR #13#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (PROGN
                     (LETT #12# (SPADCALL |ff| (QREFELT $ 84)))
                     (COND (#10# (LETT #11# (MAX #11# #12#)))
                           ('T (PROGN (LETT #11# #12#) (LETT #10# 'T)))))))
                  (LETT #13# (CDR #13#)) (GO G190) G191 (EXIT NIL))
             (COND (#10# #11#) (#14='T (|IdentityError| '|max|)))))
           (#14#
            (PROGN
             (LETT #2# NIL)
             (SEQ (LETT |ff| NIL) (LETT #9# |lum|) G190
                  (COND
                   ((OR (ATOM #9#) (PROGN (LETT |ff| (CAR #9#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (PROGN
                     (LETT #4#
                           (PROGN
                            (LETT #5# NIL)
                            (SEQ (LETT |i| 0)
                                 (LETT #8# (SPADCALL |ff| (QREFELT $ 85))) G190
                                 (COND ((|greater_SI| |i| #8#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (COND
                                    ((SPADCALL
                                      (LETT |cc|
                                            (SPADCALL |ff| |i| (QREFELT $ 86)))
                                      (|spadConstant| $ 38) (QREFELT $ 87))
                                     (PROGN
                                      (LETT #7# (SPADCALL |cc| (QREFELT $ 88)))
                                      (COND (#5# (LETT #6# (+ #6# #7#)))
                                            ('T
                                             (PROGN
                                              (LETT #6# #7#)
                                              (LETT #5# 'T)))))))))
                                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                 (EXIT NIL))
                            (COND (#5# #6#) ('T 0))))
                     (COND (#2# (LETT #3# (MAX #3# #4#)))
                           ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                  (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL))
             (COND (#2# #3#) (#14# (|IdentityError| '|max|))))))))) 

(SDEFUN |INNMFACT;intChoose|
        ((|um| (|SparseUnivariatePolynomial| P)) (|lvar| (|List| OV))
         (|clc| (R)) (|plist| (|List| P)) (|ltry| (|List| (|List| R)))
         (|ufactor|
          (|Mapping| #1=(|Factored| (|SparseUnivariatePolynomial| R))
                     (|SparseUnivariatePolynomial| R)))
         ($
          (|Union|
           (|Record| (|:| |inval| (|List| (|List| R)))
                     (|:| |unvfact| (|List| (|SparseUnivariatePolynomial| R)))
                     (|:| |lu| R) (|:| |complead| (|List| R)))
           "failed")))
        (SPROG
         ((|nfatt| (|NonNegativeInteger|)) (|int| #2=(|List| R))
          (|leadcomp| #2#) (|lffc| (R))
          (|unifact| (|List| (|SparseUnivariatePolynomial| R))) (#3=#:G928 NIL)
          (|uf| NIL) (#4=#:G927 NIL) (|leadtest| (|Boolean|)) (#5=#:G926 NIL)
          (#6=#:G925 NIL) (#7=#:G910 NIL) (#8=#:G924 NIL) (#9=#:G923 NIL)
          (#10=#:G922 NIL) (#11=#:G921 NIL) (#12=#:G920 NIL) (|ff| NIL)
          (#13=#:G919 NIL) (#14=#:G918 NIL) (#15=#:G917 NIL)
          (|nf| (|NonNegativeInteger|)) (|lffc1| (R))
          (|lunivf|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| (|SparseUnivariatePolynomial| R))
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|luniv| #1#) (|range| (|NonNegativeInteger|))
          (|newm| (|SparseUnivariatePolynomial| R)) (#16=#:G876 NIL)
          (#17=#:G870 NIL) (#18=#:G869 #19=(|Boolean|)) (#20=#:G871 #19#)
          (#21=#:G916 NIL) (|epl| NIL) (|leadcomp1| #2#) (#22=#:G915 NIL)
          (|pol| NIL) (#23=#:G914 NIL) (|lval| (|List| R)) (#24=#:G913 NIL)
          (|i| NIL) (#25=#:G912 NIL) (#26=#:G911 NIL) (|testp| (|Boolean|))
          (|nvar1| (|NonNegativeInteger|)) (|degum| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |degum| (SPADCALL |um| (QREFELT $ 46)))
                (LETT |nvar1| (LENGTH |lvar|)) (LETT |range| 5)
                (LETT |testp| (NULL (NULL |plist|)))
                (LETT |leadcomp| (LETT |leadcomp1| NIL))
                (LETT |nfatt| (+ |degum| 1))
                (LETT |lffc| (|spadConstant| $ 41)) (LETT |lffc1| |lffc|)
                (LETT |leadtest| 'T) (LETT |int| NIL)
                (SEQ
                 (EXIT
                  (SEQ G190 (COND ((NULL 'T) (GO G191)))
                       (SEQ
                        (COND
                         (|testp|
                          (COND
                           ((> (LENGTH |ltry|) 10)
                            (EXIT
                             (PROGN
                              (LETT #26# (CONS 1 "failed"))
                              (GO #27=#:G909)))))))
                        (LETT |lval|
                              (PROGN
                               (LETT #25# NIL)
                               (SEQ (LETT |i| 1) (LETT #24# |nvar1|) G190
                                    (COND ((|greater_SI| |i| #24#) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #25#
                                            (CONS
                                             (SPADCALL |range| (QREFELT $ 90))
                                             #25#))))
                                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                    (EXIT (NREVERSE #25#)))))
                        (EXIT
                         (COND
                          ((SPADCALL |lval| |ltry| (QREFELT $ 93))
                           (LETT |range| (* 2 |range|)))
                          ('T
                           (SEQ (LETT |ltry| (CONS |lval| |ltry|))
                                (LETT |leadcomp1|
                                      (PROGN
                                       (LETT #23# NIL)
                                       (SEQ (LETT |pol| NIL)
                                            (LETT #22# |plist|) G190
                                            (COND
                                             ((OR (ATOM #22#)
                                                  (PROGN
                                                   (LETT |pol| (CAR #22#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #23#
                                                    (CONS
                                                     (SPADCALL
                                                      (SPADCALL |pol| |lvar|
                                                                |lval|
                                                                (QREFELT $ 94))
                                                      (QREFELT $ 68))
                                                     #23#))))
                                            (LETT #22# (CDR #22#)) (GO G190)
                                            G191 (EXIT (NREVERSE #23#)))))
                                (COND
                                 (|testp|
                                  (COND
                                   ((PROGN
                                     (LETT #17# NIL)
                                     (SEQ (LETT |epl| NIL)
                                          (LETT #21# |leadcomp1|) G190
                                          (COND
                                           ((OR (ATOM #21#)
                                                (PROGN
                                                 (LETT |epl| (CAR #21#))
                                                 NIL))
                                            (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (PROGN
                                             (LETT #20#
                                                   (SPADCALL |epl|
                                                             (QREFELT $ 95)))
                                             (COND
                                              (#17#
                                               (LETT #18#
                                                     (COND (#18# 'T)
                                                           ('T #20#))))
                                              ('T
                                               (PROGN
                                                (LETT #18# #20#)
                                                (LETT #17# 'T)))))))
                                          (LETT #21# (CDR #21#)) (GO G190) G191
                                          (EXIT NIL))
                                     (COND (#17# #18#) ('T NIL)))
                                    (EXIT (LETT |range| (* 2 |range|)))))))
                                (LETT |newm|
                                      (SPADCALL |um| |lvar| |lval|
                                                (QREFELT $ 96)))
                                (COND
                                 ((OR
                                   (SPADCALL |degum|
                                             (SPADCALL |newm| (QREFELT $ 85))
                                             (QREFELT $ 97))
                                   (SPADCALL (SPADCALL |newm| (QREFELT $ 98)) 0
                                             (QREFELT $ 97)))
                                  (EXIT (LETT |range| (* 2 |range|)))))
                                (LETT |lffc1| (SPADCALL |newm| (QREFELT $ 99)))
                                (LETT |newm|
                                      (PROG2
                                          (LETT #16#
                                                (SPADCALL |newm| |lffc1|
                                                          (QREFELT $ 100)))
                                          (QCDR #16#)
                                        (|check_union2| (QEQCAR #16# 0)
                                                        (|SparseUnivariatePolynomial|
                                                         (QREFELT $ 8))
                                                        (|Union|
                                                         (|SparseUnivariatePolynomial|
                                                          (QREFELT $ 8))
                                                         "failed")
                                                        #16#)))
                                (COND
                                 (|testp|
                                  (COND
                                   (|leadtest|
                                    (COND
                                     ((NULL
                                       (SPADCALL
                                        (SPADCALL |lffc1| |clc| (QREFELT $ 66))
                                        (LENGTH |plist|) |leadcomp1|
                                        (QREFELT $ 102)))
                                      (EXIT (LETT |range| (* 2 |range|)))))))))
                                (EXIT
                                 (COND
                                  ((SPADCALL
                                    (SPADCALL
                                     (SPADCALL
                                      (LIST |newm|
                                            (SPADCALL |newm| (QREFELT $ 103)))
                                      (QREFELT $ 105))
                                     (QREFELT $ 85))
                                    0 (QREFELT $ 97))
                                   (LETT |range| (* 2 |range|)))
                                  ('T
                                   (SEQ
                                    (LETT |luniv| (SPADCALL |newm| |ufactor|))
                                    (LETT |lunivf|
                                          (SPADCALL |luniv| (QREFELT $ 32)))
                                    (LETT |lffc1|
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |luniv| (QREFELT $ 27))
                                            (QREFELT $ 28))
                                           |lffc1| (QREFELT $ 66)))
                                    (LETT |nf| (LENGTH |lunivf|))
                                    (COND
                                     ((OR (EQL |nf| 0) (> |nf| |nfatt|))
                                      (EXIT "next values")))
                                    (COND
                                     ((EQL |nf| 1)
                                      (SEQ (LETT |unifact| (LIST |newm|))
                                           (EXIT
                                            (PROGN
                                             (LETT #7# |$NoValue|)
                                             (GO #28=#:G907))))))
                                    (EXIT
                                     (COND
                                      ((EQL |nfatt| |nf|)
                                       (SEQ
                                        (COND
                                         (|leadtest|
                                          (SEQ
                                           (LETT |unifact|
                                                 (PROGN
                                                  (LETT #15# NIL)
                                                  (SEQ (LETT |uf| NIL)
                                                       (LETT #14# |lunivf|)
                                                       G190
                                                       (COND
                                                        ((OR (ATOM #14#)
                                                             (PROGN
                                                              (LETT |uf|
                                                                    (CAR #14#))
                                                              NIL))
                                                         (GO G191)))
                                                       (SEQ
                                                        (EXIT
                                                         (LETT #15#
                                                               (CONS
                                                                (QVELT |uf| 1)
                                                                #15#))))
                                                       (LETT #14# (CDR #14#))
                                                       (GO G190) G191
                                                       (EXIT
                                                        (NREVERSE #15#)))))
                                           (LETT |int| |lval|)
                                           (LETT |lffc| |lffc1|)
                                           (EXIT
                                            (COND
                                             (|testp|
                                              (LETT |leadcomp|
                                                    |leadcomp1|))))))
                                         ((> (|INNMFACT;localNorm| |unifact| $)
                                             (|INNMFACT;localNorm|
                                              (PROGN
                                               (LETT #13# NIL)
                                               (SEQ (LETT |ff| NIL)
                                                    (LETT #12# |lunivf|) G190
                                                    (COND
                                                     ((OR (ATOM #12#)
                                                          (PROGN
                                                           (LETT |ff|
                                                                 (CAR #12#))
                                                           NIL))
                                                      (GO G191)))
                                                    (SEQ
                                                     (EXIT
                                                      (LETT #13#
                                                            (CONS
                                                             (QVELT |ff| 1)
                                                             #13#))))
                                                    (LETT #12# (CDR #12#))
                                                    (GO G190) G191
                                                    (EXIT (NREVERSE #13#))))
                                              $))
                                          (COND
                                           (|testp|
                                            (COND
                                             ((SPADCALL
                                               (SPADCALL |lffc1| |clc|
                                                         (QREFELT $ 66))
                                               (LENGTH |plist|) |leadcomp1|
                                               (QREFELT $ 102))
                                              (SEQ
                                               (LETT |unifact|
                                                     (PROGN
                                                      (LETT #11# NIL)
                                                      (SEQ (LETT |uf| NIL)
                                                           (LETT #10# |lunivf|)
                                                           G190
                                                           (COND
                                                            ((OR (ATOM #10#)
                                                                 (PROGN
                                                                  (LETT |uf|
                                                                        (CAR
                                                                         #10#))
                                                                  NIL))
                                                             (GO G191)))
                                                           (SEQ
                                                            (EXIT
                                                             (LETT #11#
                                                                   (CONS
                                                                    (QVELT |uf|
                                                                           1)
                                                                    #11#))))
                                                           (LETT #10#
                                                                 (CDR #10#))
                                                           (GO G190) G191
                                                           (EXIT
                                                            (NREVERSE #11#)))))
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
                                                    (LETT #9# NIL)
                                                    (SEQ (LETT |uf| NIL)
                                                         (LETT #8# |lunivf|)
                                                         G190
                                                         (COND
                                                          ((OR (ATOM #8#)
                                                               (PROGN
                                                                (LETT |uf|
                                                                      (CAR
                                                                       #8#))
                                                                NIL))
                                                           (GO G191)))
                                                         (SEQ
                                                          (EXIT
                                                           (LETT #9#
                                                                 (CONS
                                                                  (QVELT |uf|
                                                                         1)
                                                                  #9#))))
                                                         (LETT #8# (CDR #8#))
                                                         (GO G190) G191
                                                         (EXIT
                                                          (NREVERSE #9#)))))
                                             (LETT |int| |lval|)
                                             (LETT |lffc| |lffc1|)
                                             (EXIT
                                              (COND
                                               (|testp|
                                                (LETT |leadcomp|
                                                      |leadcomp1|)))))))))
                                        (EXIT
                                         (PROGN
                                          (LETT #7# |$NoValue|)
                                          (GO #28#)))))
                                      ((> |nfatt| |degum|)
                                       (SEQ
                                        (LETT |unifact|
                                              (PROGN
                                               (LETT #6# NIL)
                                               (SEQ (LETT |uf| NIL)
                                                    (LETT #5# |lunivf|) G190
                                                    (COND
                                                     ((OR (ATOM #5#)
                                                          (PROGN
                                                           (LETT |uf|
                                                                 (CAR #5#))
                                                           NIL))
                                                      (GO G191)))
                                                    (SEQ
                                                     (EXIT
                                                      (LETT #6#
                                                            (CONS
                                                             (QVELT |uf| 1)
                                                             #6#))))
                                                    (LETT #5# (CDR #5#))
                                                    (GO G190) G191
                                                    (EXIT (NREVERSE #6#)))))
                                        (LETT |lffc| |lffc1|)
                                        (COND
                                         (|testp|
                                          (LETT |leadcomp| |leadcomp1|)))
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
                                                  (SPADCALL |lffc| |clc|
                                                            (QREFELT $ 66))
                                                  (LENGTH |plist|) |leadcomp|
                                                  (QREFELT $ 102)))))
                                         ('T (LETT |leadtest| NIL)))
                                        (COND
                                         ((NULL |leadtest|)
                                          (SEQ
                                           (LETT |unifact|
                                                 (PROGN
                                                  (LETT #4# NIL)
                                                  (SEQ (LETT |uf| NIL)
                                                       (LETT #3# |lunivf|) G190
                                                       (COND
                                                        ((OR (ATOM #3#)
                                                             (PROGN
                                                              (LETT |uf|
                                                                    (CAR #3#))
                                                              NIL))
                                                         (GO G191)))
                                                       (SEQ
                                                        (EXIT
                                                         (LETT #4#
                                                               (CONS
                                                                (QVELT |uf| 1)
                                                                #4#))))
                                                       (LETT #3# (CDR #3#))
                                                       (GO G190) G191
                                                       (EXIT (NREVERSE #4#)))))
                                           (LETT |lffc| |lffc1|)
                                           (COND
                                            (|testp|
                                             (LETT |leadcomp| |leadcomp1|)))
                                           (EXIT (LETT |int| |lval|)))))
                                        (EXIT (LETT |nfatt| |nf|)))))))))))))))
                       NIL (GO G190) G191 (EXIT NIL)))
                 #28# (EXIT #7#))
                (EXIT
                 (CONS 0
                       (VECTOR (CONS |int| |ltry|) |unifact| |lffc|
                               |leadcomp|)))))
          #27# (EXIT #26#)))) 

(SDEFUN |INNMFACT;simplify|
        ((|m| (P)) (|lvar| (|List| OV))
         (|lmdeg| (|List| (|NonNegativeInteger|)))
         (|ufactor|
          (|Mapping| (|Factored| (|SparseUnivariatePolynomial| R))
                     (|SparseUnivariatePolynomial| R)))
         ($
          (|Record| (|:| |contp| R)
                    (|:| |factors|
                         (|List|
                          (|Record| (|:| |irr| P)
                                    (|:| |pow| (|NonNegativeInteger|))))))))
        (SPROG
         ((|flead|
           (|Record| (|:| |contp| R)
                     (|:| |factors|
                          (|List|
                           (|Record| (|:| |irr| P)
                                     (|:| |pow| (|NonNegativeInteger|)))))))
          (#1=#:G936 NIL)
          (|factorlist|
           (|List|
            (|Record| (|:| |irr| P) (|:| |pow| (|NonNegativeInteger|)))))
          (|pol1| (P)) (|i| (|NonNegativeInteger|)) (#2=#:G943 NIL) (|x| NIL))
         (SEQ (LETT |factorlist| NIL) (LETT |pol1| (|spadConstant| $ 42))
              (SEQ (LETT |x| NIL) (LETT #2# |lvar|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |i|
                          (SPADCALL |lmdeg|
                                    (SPADCALL |x| |lvar| (QREFELT $ 106))
                                    (QREFELT $ 107)))
                    (EXIT
                     (COND ((EQL |i| 0) "next value")
                           ('T
                            (SEQ
                             (LETT |pol1|
                                   (SPADCALL |pol1|
                                             (SPADCALL (|spadConstant| $ 42)
                                                       |x| |i| (QREFELT $ 108))
                                             (QREFELT $ 109)))
                             (EXIT
                              (LETT |factorlist|
                                    (CONS
                                     (CONS (SPADCALL |x| (QREFELT $ 110)) |i|)
                                     |factorlist|))))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (LETT |m|
                    (PROG2 (LETT #1# (SPADCALL |m| |pol1| (QREFELT $ 111)))
                        (QCDR #1#)
                      (|check_union2| (QEQCAR #1# 0) (QREFELT $ 9)
                                      (|Union| (QREFELT $ 9) "failed") #1#)))
              (EXIT
               (COND
                ((SPADCALL |m| (QREFELT $ 63))
                 (CONS (SPADCALL |m| (QREFELT $ 68)) |factorlist|))
                ('T
                 (SEQ (LETT |flead| (|INNMFACT;mFactor| |m| |ufactor| $))
                      (PROGN
                       (RPLACD |flead|
                               (SPADCALL |factorlist| (QCDR |flead|)
                                         (QREFELT $ 114)))
                       (QCDR |flead|))
                      (EXIT |flead|)))))))) 

(SDEFUN |INNMFACT;next_mod| ((|m| (|Integer|)) ($ (|Integer|)))
        (SPROG ((#1=#:G948 NIL))
               (SEQ
                (EXIT
                 (SEQ G190 NIL
                      (SEQ (LETT |m| (SPADCALL |m| (QREFELT $ 116)))
                           (EXIT
                            (COND
                             ((EQL (REM (- |m| 3) 4) 0)
                              (PROGN (LETT #1# |m|) (GO #2=#:G947))))))
                      NIL (GO G190) G191 (EXIT NIL)))
                #2# (EXIT #1#)))) 

(SDEFUN |INNMFACT;intfact1|
        ((|um| (|SparseUnivariatePolynomial| P)) (|lvar| (|List| OV))
         (|ldeg| (|List| (|NonNegativeInteger|)))
         (|tleadpol|
          (|Record| (|:| |contp| R)
                    (|:| |factors|
                         (|List|
                          (|Record| (|:| |irr| P)
                                    (|:| |pow| (|NonNegativeInteger|)))))))
         (|ltry| (|List| (|List| R)))
         (|ufactor|
          (|Mapping| (|Factored| (|SparseUnivariatePolynomial| R))
                     (|SparseUnivariatePolynomial| R)))
         (|npmod| (|Integer|)) ($ (|List| (|SparseUnivariatePolynomial| P))))
        (SPROG
         ((|factfin| (|List| (|SparseUnivariatePolynomial| P)))
          (#1=#:G1100 NIL) (|ff| NIL) (#2=#:G1099 NIL)
          (|ffin| (|Union| (|List| (|SparseUnivariatePolynomial| P)) "failed"))
          (|umd| (|SparseUnivariatePolynomial| P)) (#3=#:G1080 NIL)
          (|unifact| (|List| (|SparseUnivariatePolynomial| R)))
          (#4=#:G1098 NIL) (|unif| NIL) (#5=#:G1097 NIL) (|dd| (R))
          (|lpol| (|List| P))
          (|dist|
           (|Record| (|:| |polfac| (|List| P)) (|:| |correct| R)
                     (|:| |corrfact|
                          (|List| (|SparseUnivariatePolynomial| R)))))
          (#6=#:G1094 NIL)
          (|distf|
           (|Union|
            (|Record| (|:| |polfac| (|List| P)) (|:| |correct| R)
                      (|:| |corrfact|
                           (|List| (|SparseUnivariatePolynomial| R))))
            "failed"))
          (|leadval| (|List| R)) (|lval| (|List| R))
          (|nfact| (|NonNegativeInteger|))
          (|vfchoo|
           (|Record| (|:| |inval| (|List| (|List| R)))
                     (|:| |unvfact| (|List| (|SparseUnivariatePolynomial| R)))
                     (|:| |lu| R) (|:| |complead| (|List| R))))
          (#7=#:G860 NIL)
          (|check|
           (|Union|
            (|Record| (|:| |inval| (|List| (|List| R)))
                      (|:| |unvfact| (|List| (|SparseUnivariatePolynomial| R)))
                      (|:| |lu| R) (|:| |complead| (|List| R)))
            #8="failed"))
          (|leadpol| (|List| P)) (#9=#:G1096 NIL) (#10=#:G1095 NIL)
          (|polcase| (|Boolean|)))
         (SEQ
          (EXIT
           (SEQ (LETT |polcase| (NULL (NULL (QCDR |tleadpol|))))
                (LETT |vfchoo|
                      (COND
                       (|polcase|
                        (SEQ
                         (LETT |leadpol|
                               (PROGN
                                (LETT #10# NIL)
                                (SEQ (LETT |ff| NIL)
                                     (LETT #9# (QCDR |tleadpol|)) G190
                                     (COND
                                      ((OR (ATOM #9#)
                                           (PROGN (LETT |ff| (CAR #9#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (LETT #10# (CONS (QCAR |ff|) #10#))))
                                     (LETT #9# (CDR #9#)) (GO G190) G191
                                     (EXIT (NREVERSE #10#)))))
                         (LETT |check|
                               (|INNMFACT;intChoose| |um| |lvar|
                                (QCAR |tleadpol|) |leadpol| |ltry| |ufactor|
                                $))
                         (EXIT
                          (COND
                           ((QEQCAR |check| 1)
                            (PROGN
                             (LETT #6#
                                   (|INNMFACT;monicMfpol| |um| |lvar| |ldeg|
                                    |ufactor| $))
                             (GO #11=#:G1093)))
                           (#12='T (QCDR |check|))))))
                       (#12#
                        (PROG2
                            (LETT #7#
                                  (|INNMFACT;intChoose| |um| |lvar|
                                   (|spadConstant| $ 41) NIL NIL |ufactor| $))
                            (QCDR #7#)
                          (|check_union2| (QEQCAR #7# 0)
                                          (|Record|
                                           (|:| |inval|
                                                (|List|
                                                 (|List| (QREFELT $ 8))))
                                           (|:| |unvfact|
                                                (|List|
                                                 (|SparseUnivariatePolynomial|
                                                  (QREFELT $ 8))))
                                           (|:| |lu| (QREFELT $ 8))
                                           (|:| |complead|
                                                (|List| (QREFELT $ 8))))
                                          (|Union|
                                           (|Record|
                                            (|:| |inval|
                                                 (|List|
                                                  (|List| (QREFELT $ 8))))
                                            (|:| |unvfact|
                                                 (|List|
                                                  (|SparseUnivariatePolynomial|
                                                   (QREFELT $ 8))))
                                            (|:| |lu| (QREFELT $ 8))
                                            (|:| |complead|
                                                 (|List| (QREFELT $ 8))))
                                           #8#)
                                          #7#)))))
                (LETT |unifact| (QVELT |vfchoo| 1))
                (LETT |nfact| (LENGTH |unifact|))
                (EXIT
                 (COND ((EQL |nfact| 1) (LIST |um|))
                       (#12#
                        (SEQ (LETT |ltry| (QVELT |vfchoo| 0))
                             (LETT |lval| (|SPADfirst| |ltry|))
                             (LETT |dd| (QVELT |vfchoo| 2))
                             (LETT |leadval| NIL) (LETT |lpol| NIL)
                             (COND
                              (|polcase|
                               (SEQ (LETT |leadval| (QVELT |vfchoo| 3))
                                    (LETT |distf|
                                          (SPADCALL (QVELT |vfchoo| 2)
                                                    |unifact| |tleadpol|
                                                    |leadval| |lvar| |lval|
                                                    (QREFELT $ 121)))
                                    (EXIT
                                     (COND
                                      ((QEQCAR |distf| 1)
                                       (PROGN
                                        (LETT #6#
                                              (|INNMFACT;intfact1| |um| |lvar|
                                               |ldeg| |tleadpol| |ltry|
                                               |ufactor|
                                               (|INNMFACT;next_mod|
                                                (QREFELT $ 10) $)
                                               $))
                                        (GO #11#)))
                                      (#12#
                                       (SEQ (LETT |dist| (QCDR |distf|))
                                            (LETT |lpol| (QVELT |dist| 0))
                                            (LETT |dd| (QVELT |dist| 1))
                                            (EXIT
                                             (LETT |unifact|
                                                   (QVELT |dist| 2))))))))))
                             (COND
                              ((SPADCALL |dd| (|spadConstant| $ 41)
                                         (QREFELT $ 87))
                               (SEQ
                                (LETT |unifact|
                                      (PROGN
                                       (LETT #5# NIL)
                                       (SEQ (LETT |unif| NIL)
                                            (LETT #4# |unifact|) G190
                                            (COND
                                             ((OR (ATOM #4#)
                                                  (PROGN
                                                   (LETT |unif| (CAR #4#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #5#
                                                    (CONS
                                                     (SPADCALL |dd| |unif|
                                                               (QREFELT $ 122))
                                                     #5#))))
                                            (LETT #4# (CDR #4#)) (GO G190) G191
                                            (EXIT (NREVERSE #5#)))))
                                (EXIT
                                 (LETT |umd|
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL |dd|
                                                   (PROG1
                                                       (LETT #3# (- |nfact| 1))
                                                     (|check_subtype2|
                                                      (>= #3# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #3#))
                                                   (QREFELT $ 65))
                                         (QREFELT $ 33))
                                        |um| (QREFELT $ 123))))))
                              (#12# (LETT |umd| |um|)))
                             (LETT |ffin|
                                   (SPADCALL |umd| |lvar| |unifact| |lval|
                                             |lpol| |ldeg|
                                             (SPADCALL |npmod| (QREFELT $ 124))
                                             (QREFELT $ 127)))
                             (EXIT
                              (COND
                               ((QEQCAR |ffin| 1)
                                (|INNMFACT;intfact1| |um| |lvar| |ldeg|
                                 |tleadpol| |ltry| |ufactor|
                                 (|INNMFACT;next_mod| (QREFELT $ 10) $) $))
                               (#12#
                                (SEQ (LETT |factfin| (QCDR |ffin|))
                                     (COND
                                      ((SPADCALL |dd| (|spadConstant| $ 41)
                                                 (QREFELT $ 87))
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
                                                                       $ 128))
                                                            #2#))))
                                                   (LETT #1# (CDR #1#))
                                                   (GO G190) G191
                                                   (EXIT (NREVERSE #2#)))))))
                                     (EXIT |factfin|)))))))))))
          #11# (EXIT #6#)))) 

(SDEFUN |INNMFACT;intfact|
        ((|um| (|SparseUnivariatePolynomial| P)) (|lvar| (|List| OV))
         (|ldeg| (|List| (|NonNegativeInteger|)))
         (|tleadpol|
          (|Record| (|:| |contp| R)
                    (|:| |factors|
                         (|List|
                          (|Record| (|:| |irr| P)
                                    (|:| |pow| (|NonNegativeInteger|)))))))
         (|ltry| (|List| (|List| R)))
         (|ufactor|
          (|Mapping| (|Factored| (|SparseUnivariatePolynomial| R))
                     (|SparseUnivariatePolynomial| R)))
         ($ (|List| (|SparseUnivariatePolynomial| P))))
        (|INNMFACT;intfact1| |um| |lvar| |ldeg| |tleadpol| |ltry| |ufactor|
         (QREFELT $ 10) $)) 

(SDEFUN |INNMFACT;mfconst|
        ((|um| (|SparseUnivariatePolynomial| P)) (|lvar| (|List| OV))
         (|ldeg| (|List| (|NonNegativeInteger|)))
         (|ufactor|
          (|Mapping| (|Factored| (|SparseUnivariatePolynomial| R))
                     (|SparseUnivariatePolynomial| R)))
         ($ (|List| (|SparseUnivariatePolynomial| P))))
        (SPROG
         ((#1=#:G1115 NIL) (|uf| NIL) (#2=#:G1114 NIL)
          (|lum|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| (|SparseUnivariatePolynomial| R))
                      (|:| |exponent| (|NonNegativeInteger|))))))
         (SEQ
          (COND
           ((NULL |lvar|)
            (SEQ
             (LETT |lum|
                   (SPADCALL
                    (SPADCALL (SPADCALL (ELT $ 21) |um| (QREFELT $ 25))
                              |ufactor|)
                    (QREFELT $ 32)))
             (EXIT
              (PROGN
               (LETT #2# NIL)
               (SEQ (LETT |uf| NIL) (LETT #1# |lum|) G190
                    (COND
                     ((OR (ATOM #1#) (PROGN (LETT |uf| (CAR #1#)) NIL))
                      (GO G191)))
                    (SEQ
                     (EXIT
                      (LETT #2#
                            (CONS
                             (SPADCALL (ELT $ 33) (QVELT |uf| 1)
                                       (QREFELT $ 36))
                             #2#))))
                    (LETT #1# (CDR #1#)) (GO G190) G191
                    (EXIT (NREVERSE #2#)))))))
           ('T
            (|INNMFACT;intfact| |um| |lvar| |ldeg|
             (CONS (|spadConstant| $ 38) NIL) NIL |ufactor| $)))))) 

(SDEFUN |INNMFACT;monicize|
        ((|um| (|SparseUnivariatePolynomial| P)) (|c| (P))
         ($ (|SparseUnivariatePolynomial| P)))
        (SPROG
         ((|ans| (|SparseUnivariatePolynomial| P)) (|prod| (P))
          (#1=#:G1119 NIL) (|n| #2=(|NonNegativeInteger|)) (|lc| (P)) (|i| #2#)
          (#3=#:G1116 NIL))
         (SEQ (LETT |n| (SPADCALL |um| (QREFELT $ 46)))
              (LETT |ans| (SPADCALL (|spadConstant| $ 42) |n| (QREFELT $ 43)))
              (LETT |n|
                    (PROG1 (LETT #3# (- |n| 1))
                      (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #3#)))
              (LETT |prod| (|spadConstant| $ 42))
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL (LETT |um| (SPADCALL |um| (QREFELT $ 129)))
                                (|spadConstant| $ 130) (QREFELT $ 131)))
                     (GO G191)))
                   (SEQ (LETT |i| (SPADCALL |um| (QREFELT $ 46)))
                        (LETT |lc| (SPADCALL |um| (QREFELT $ 62)))
                        (LETT |prod|
                              (SPADCALL |prod|
                                        (SPADCALL |c|
                                                  (PROG1
                                                      (LETT #1#
                                                            (- |n|
                                                               (LETT |n| |i|)))
                                                    (|check_subtype2|
                                                     (>= #1# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #1#))
                                                  (QREFELT $ 132))
                                        (QREFELT $ 109)))
                        (EXIT
                         (LETT |ans|
                               (SPADCALL |ans|
                                         (SPADCALL
                                          (SPADCALL |prod| |lc|
                                                    (QREFELT $ 109))
                                          |i| (QREFELT $ 43))
                                         (QREFELT $ 133)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |INNMFACT;unmonicize|
        ((|m| (|SparseUnivariatePolynomial| P)) (|c| (P))
         ($ (|SparseUnivariatePolynomial| P)))
        (SPADCALL
         (SPADCALL |m| (SPADCALL |c| 1 (QREFELT $ 43)) (QREFELT $ 134))
         (QREFELT $ 128))) 

(SDEFUN |INNMFACT;monicMfpol|
        ((|um| (|SparseUnivariatePolynomial| P)) (|lvar| (|List| OV))
         (|ldeg| (|List| (|NonNegativeInteger|)))
         (|ufactor|
          (|Mapping| (|Factored| (|SparseUnivariatePolynomial| R))
                     (|SparseUnivariatePolynomial| R)))
         ($ (|List| (|SparseUnivariatePolynomial| P))))
        (SPROG
         ((|nldeg| (|List| (|NonNegativeInteger|)))
          (|monpol| (|SparseUnivariatePolynomial| P)) (|l| (P)))
         (SEQ (LETT |l| (SPADCALL |um| (QREFELT $ 62)))
              (LETT |monpol| (|INNMFACT;monicize| |um| |l| $))
              (LETT |nldeg| (SPADCALL |monpol| |lvar| (QREFELT $ 135)))
              (EXIT
               (SPADCALL (CONS #'|INNMFACT;monicMfpol!0| (VECTOR $ |l|))
                         (|INNMFACT;mfconst| |monpol| |lvar| |nldeg| |ufactor|
                          $)
                         (QREFELT $ 138)))))) 

(SDEFUN |INNMFACT;monicMfpol!0| ((|z1| NIL) ($$ NIL))
        (PROG (|l| $)
          (LETT |l| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|INNMFACT;unmonicize| |z1| |l| $))))) 

(SDEFUN |INNMFACT;mfpol|
        ((|um| (|SparseUnivariatePolynomial| P)) (|lvar| (|List| OV))
         (|ldeg| (|List| (|NonNegativeInteger|)))
         (|ufactor|
          (|Mapping| (|Factored| (|SparseUnivariatePolynomial| R))
                     (|SparseUnivariatePolynomial| R)))
         ($ (|List| (|SparseUnivariatePolynomial| P))))
        (SPROG
         ((|tleadpol|
           (|Record| (|:| |contp| R)
                     (|:| |factors|
                          (|List|
                           (|Record| (|:| |irr| P)
                                     (|:| |pow| (|NonNegativeInteger|))))))))
         (SEQ
          (COND
           ((|HasCategory| (QREFELT $ 8) '(|Field|))
            (|INNMFACT;monicMfpol| |um| |lvar| |ldeg| |ufactor| $))
           ('T
            (SEQ
             (LETT |tleadpol|
                   (|INNMFACT;mFactor| (SPADCALL |um| (QREFELT $ 62)) |ufactor|
                    $))
             (EXIT
              (|INNMFACT;intfact| |um| |lvar| |ldeg| |tleadpol| NIL |ufactor|
               $)))))))) 

(SDEFUN |INNMFACT;mFactor|
        ((|m| (P))
         (|ufactor|
          (|Mapping| (|Factored| (|SparseUnivariatePolynomial| R))
                     (|SparseUnivariatePolynomial| R)))
         ($
          (|Record| (|:| |contp| R)
                    (|:| |factors|
                         (|List|
                          (|Record| (|:| |irr| P)
                                    (|:| |pow| (|NonNegativeInteger|))))))))
        (SPROG
         ((#1=#:G1184 NIL) (|lcfacs| (R)) (#2=#:G1181 NIL) (#3=#:G1180 (R))
          (#4=#:G1182 (R)) (#5=#:G1196 NIL) (|f| NIL)
          (|factorlist|
           (|List|
            (|Record| (|:| |irr| P) (|:| |pow| (|NonNegativeInteger|)))))
          (|auxfl|
           (|List|
            #6=(|Record| (|:| |irr| P) (|:| |pow| (|NonNegativeInteger|)))))
          (#7=#:G1195 NIL) (|lfp| NIL) (#8=#:G1194 NIL)
          (|lf| (|List| (|SparseUnivariatePolynomial| P)))
          (|um| (|SparseUnivariatePolynomial| P))
          (|ldeg| (|List| (|NonNegativeInteger|))) (#9=#:G1193 NIL)
          (|lcterm| NIL) (|ffactor| (P)) (#10=#:G1161 NIL) (|pc| (P))
          (|lvar| (|List| OV)) (|x| (OV))
          (|varch|
           (|Record| (|:| |npol| (|SparseUnivariatePolynomial| P))
                     (|:| |nvar| (|List| OV))
                     (|:| |newdeg| (|List| (|NonNegativeInteger|)))))
          (#11=#:G1192 NIL) (#12=#:G1148 NIL) (|lcont| (P))
          (|ffexp| #13=(|NonNegativeInteger|)) (#14=#:G1191 NIL) (|fact| NIL)
          (|sqqfact|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| P) (|:| |exponent| #13#))))
          (|flead| (|Record| (|:| |contp| R) (|:| |factors| (|List| #6#))))
          (|sqfacs| (|Factored| P)) (#15=#:G1136 NIL)
          (#16=#:G1135 #17=(|Boolean|)) (#18=#:G1137 #17#) (#19=#:G1190 NIL)
          (|n| NIL) (|lmdeg| (|List| (|NonNegativeInteger|))))
         (SEQ
          (COND
           ((SPADCALL |m| (QREFELT $ 63))
            (CONS (SPADCALL |m| (QREFELT $ 68)) NIL))
           (#20='T
            (SEQ (LETT |lvar| (SPADCALL |m| (QREFELT $ 19)))
                 (LETT |flead| (CONS (|spadConstant| $ 38) NIL))
                 (LETT |factorlist| NIL)
                 (LETT |lmdeg| (SPADCALL |m| |lvar| (QREFELT $ 139)))
                 (EXIT
                  (COND
                   ((PROGN
                     (LETT #15# NIL)
                     (SEQ (LETT |n| NIL) (LETT #19# |lmdeg|) G190
                          (COND
                           ((OR (ATOM #19#) (PROGN (LETT |n| (CAR #19#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (PROGN
                             (LETT #18# (> |n| 0))
                             (COND
                              (#15# (LETT #16# (COND (#16# 'T) ('T #18#))))
                              ('T (PROGN (LETT #16# #18#) (LETT #15# 'T)))))))
                          (LETT #19# (CDR #19#)) (GO G190) G191 (EXIT NIL))
                     (COND (#15# #16#) (#20# NIL)))
                    (|INNMFACT;simplify| |m| |lvar| |lmdeg| |ufactor| $))
                   (#20#
                    (SEQ (LETT |sqfacs| (SPADCALL |m| (QREFELT $ 141)))
                         (LETT |lcont| (SPADCALL |sqfacs| (QREFELT $ 143)))
                         (COND
                          ((SPADCALL |lcont| (QREFELT $ 63))
                           (PROGN
                            (RPLACA |flead| (SPADCALL |lcont| (QREFELT $ 68)))
                            (QCAR |flead|)))
                          (#20#
                           (LETT |flead|
                                 (|INNMFACT;mFactor| |lcont| |ufactor| $))))
                         (LETT |factorlist| (QCDR |flead|))
                         (LETT |sqqfact| (SPADCALL |sqfacs| (QREFELT $ 146)))
                         (SEQ (LETT |fact| NIL) (LETT #14# |sqqfact|) G190
                              (COND
                               ((OR (ATOM #14#)
                                    (PROGN (LETT |fact| (CAR #14#)) NIL))
                                (GO G191)))
                              (SEQ (LETT |ffactor| (QVELT |fact| 1))
                                   (LETT |ffexp| (QVELT |fact| 2))
                                   (LETT |lvar|
                                         (SPADCALL |ffactor| (QREFELT $ 19)))
                                   (LETT |x| (|SPADfirst| |lvar|))
                                   (LETT |ldeg|
                                         (SPADCALL |ffactor| |lvar|
                                                   (QREFELT $ 147)))
                                   (EXIT
                                    (COND
                                     ((SPADCALL 1 |ldeg| (QREFELT $ 149))
                                      (SEQ
                                       (LETT |x|
                                             (SPADCALL |lvar|
                                                       (SPADCALL 1 |ldeg|
                                                                 (QREFELT $
                                                                          80))
                                                       (QREFELT $ 81)))
                                       (LETT |lcont|
                                             (SPADCALL
                                              (SPADCALL
                                               (SPADCALL |ffactor| |x|
                                                         (QREFELT $ 77))
                                               (QREFELT $ 17))
                                              (QREFELT $ 150)))
                                       (LETT |ffactor|
                                             (PROG2
                                                 (LETT #12#
                                                       (SPADCALL |ffactor|
                                                                 |lcont|
                                                                 (QREFELT $
                                                                          111)))
                                                 (QCDR #12#)
                                               (|check_union2| (QEQCAR #12# 0)
                                                               (QREFELT $ 9)
                                                               (|Union|
                                                                (QREFELT $ 9)
                                                                #21="failed")
                                                               #12#)))
                                       (LETT |factorlist|
                                             (CONS (CONS |ffactor| |ffexp|)
                                                   |factorlist|))
                                       (EXIT
                                        (SEQ (LETT |lcterm| NIL)
                                             (LETT #11#
                                                   (QCDR
                                                    (|INNMFACT;mFactor| |lcont|
                                                     |ufactor| $)))
                                             G190
                                             (COND
                                              ((OR (ATOM #11#)
                                                   (PROGN
                                                    (LETT |lcterm| (CAR #11#))
                                                    NIL))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (LETT |factorlist|
                                                     (CONS
                                                      (CONS (QCAR |lcterm|)
                                                            (* (QCDR |lcterm|)
                                                               |ffexp|))
                                                      |factorlist|))))
                                             (LETT #11# (CDR #11#)) (GO G190)
                                             G191 (EXIT NIL)))))
                                     ('T
                                      (SEQ
                                       (LETT |varch|
                                             (|INNMFACT;varChoose| |ffactor|
                                              |lvar| |ldeg| $))
                                       (LETT |um| (QVELT |varch| 0))
                                       (LETT |x| (|SPADfirst| |lvar|))
                                       (LETT |ldeg| (CDR |ldeg|))
                                       (LETT |lvar| (CDR |lvar|))
                                       (COND
                                        ((SPADCALL
                                          (|SPADfirst| (QVELT |varch| 1)) |x|
                                          (QREFELT $ 151))
                                         (SEQ (LETT |lvar| (QVELT |varch| 1))
                                              (LETT |x| (|SPADfirst| |lvar|))
                                              (EXIT
                                               (LETT |lvar| (CDR |lvar|))))))
                                       (LETT |pc|
                                             (SPADCALL
                                              (SPADCALL |um| (QREFELT $ 17))
                                              (QREFELT $ 150)))
                                       (COND
                                        ((SPADCALL |pc| (|spadConstant| $ 42)
                                                   (QREFELT $ 152))
                                         (SEQ
                                          (LETT |um|
                                                (PROG2
                                                    (LETT #10#
                                                          (SPADCALL |um| |pc|
                                                                    (QREFELT $
                                                                             153)))
                                                    (QCDR #10#)
                                                  (|check_union2|
                                                   (QEQCAR #10# 0)
                                                   (|SparseUnivariatePolynomial|
                                                    (QREFELT $ 9))
                                                   (|Union|
                                                    (|SparseUnivariatePolynomial|
                                                     (QREFELT $ 9))
                                                    "failed")
                                                   #10#)))
                                          (LETT |ffactor|
                                                (SPADCALL |um| |x|
                                                          (QREFELT $ 154)))
                                          (EXIT
                                           (SEQ (LETT |lcterm| NIL)
                                                (LETT #9#
                                                      (QCDR
                                                       (|INNMFACT;mFactor| |pc|
                                                        |ufactor| $)))
                                                G190
                                                (COND
                                                 ((OR (ATOM #9#)
                                                      (PROGN
                                                       (LETT |lcterm|
                                                             (CAR #9#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT |factorlist|
                                                        (CONS
                                                         (CONS (QCAR |lcterm|)
                                                               (*
                                                                (QCDR |lcterm|)
                                                                |ffexp|))
                                                         |factorlist|))))
                                                (LETT #9# (CDR #9#)) (GO G190)
                                                G191 (EXIT NIL))))))
                                       (LETT |ldeg|
                                             (SPADCALL |ffactor| |lvar|
                                                       (QREFELT $ 147)))
                                       (LETT |um|
                                             (SPADCALL |um| (QREFELT $ 155)))
                                       (COND
                                        ((SPADCALL
                                          (SPADCALL |um| (QREFELT $ 62))
                                          (QREFELT $ 63))
                                         (LETT |lf|
                                               (|INNMFACT;mfconst| |um| |lvar|
                                                |ldeg| |ufactor| $)))
                                        ('T
                                         (LETT |lf|
                                               (|INNMFACT;mfpol| |um| |lvar|
                                                |ldeg| |ufactor| $))))
                                       (LETT |auxfl|
                                             (PROGN
                                              (LETT #8# NIL)
                                              (SEQ (LETT |lfp| NIL)
                                                   (LETT #7# |lf|) G190
                                                   (COND
                                                    ((OR (ATOM #7#)
                                                         (PROGN
                                                          (LETT |lfp|
                                                                (CAR #7#))
                                                          NIL))
                                                     (GO G191)))
                                                   (SEQ
                                                    (EXIT
                                                     (LETT #8#
                                                           (CONS
                                                            (CONS
                                                             (SPADCALL
                                                              (SPADCALL |lfp|
                                                                        |x|
                                                                        (QREFELT
                                                                         $
                                                                         154))
                                                              (QREFELT $ 156))
                                                             |ffexp|)
                                                            #8#))))
                                                   (LETT #7# (CDR #7#))
                                                   (GO G190) G191
                                                   (EXIT (NREVERSE #8#)))))
                                       (EXIT
                                        (LETT |factorlist|
                                              (SPADCALL |factorlist| |auxfl|
                                                        (QREFELT $ 114)))))))))
                              (LETT #14# (CDR #14#)) (GO G190) G191 (EXIT NIL))
                         (LETT |lcfacs|
                               (PROGN
                                (LETT #2# NIL)
                                (SEQ (LETT |f| NIL) (LETT #5# |factorlist|)
                                     G190
                                     (COND
                                      ((OR (ATOM #5#)
                                           (PROGN (LETT |f| (CAR #5#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (PROGN
                                        (LETT #4#
                                              (SPADCALL
                                               (SPADCALL (QCAR |f|)
                                                         (QREFELT $ 64))
                                               (QCDR |f|) (QREFELT $ 65)))
                                        (COND
                                         (#2#
                                          (LETT #3#
                                                (SPADCALL #3# #4#
                                                          (QREFELT $ 66))))
                                         ('T
                                          (PROGN
                                           (LETT #3# #4#)
                                           (LETT #2# 'T)))))))
                                     (LETT #5# (CDR #5#)) (GO G190) G191
                                     (EXIT NIL))
                                (COND (#2# #3#) (#20# (|spadConstant| $ 41)))))
                         (EXIT
                          (CONS
                           (PROG2
                               (LETT #1#
                                     (SPADCALL (SPADCALL |m| (QREFELT $ 64))
                                               |lcfacs| (QREFELT $ 69)))
                               (QCDR #1#)
                             (|check_union2| (QEQCAR #1# 0) (QREFELT $ 8)
                                             (|Union| (QREFELT $ 8) #21#) #1#))
                           |factorlist|)))))))))))) 

(SDEFUN |INNMFACT;factor;PMF;17|
        ((|m| (P))
         (|ufactor|
          (|Mapping| (|Factored| (|SparseUnivariatePolynomial| R))
                     (|SparseUnivariatePolynomial| R)))
         ($ (|Factored| P)))
        (SPROG
         ((#1=#:G1200 NIL) (#2=#:G1199 #3=(|Factored| P)) (#4=#:G1201 #3#)
          (#5=#:G1204 NIL) (|u| NIL)
          (|flist|
           (|Record| (|:| |contp| R)
                     (|:| |factors|
                          (|List|
                           (|Record| (|:| |irr| P)
                                     (|:| |pow| (|NonNegativeInteger|))))))))
         (SEQ (LETT |flist| (|INNMFACT;mFactor| |m| |ufactor| $))
              (EXIT
               (SPADCALL (SPADCALL (QCAR |flist|) (QREFELT $ 33))
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
                                        (SPADCALL (QCAR |u|) (QCDR |u|)
                                                  (QREFELT $ 157)))
                                  (COND
                                   (#1#
                                    (LETT #2#
                                          (SPADCALL #2# #4# (QREFELT $ 158))))
                                   ('T
                                    (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                               (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                          (COND (#1# #2#) ('T (|spadConstant| $ 159))))
                         (QREFELT $ 160)))))) 

(DECLAIM (NOTINLINE |InnerMultFact;|)) 

(DEFUN |InnerMultFact| (&REST #1=#:G1205)
  (SPROG NIL
         (PROG (#2=#:G1206)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|InnerMultFact|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |InnerMultFact;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|InnerMultFact|)))))))))) 

(DEFUN |InnerMultFact;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|InnerMultFact| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 162))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|InnerMultFact| (LIST DV$1 DV$2 DV$3 DV$4)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 10 8388619)
    $))) 

(MAKEPROP '|InnerMultFact| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) '|pmod|
              (|SparseUnivariatePolynomial| 9) (0 . |coerce|) (|Boolean|)
              (5 . |ground?|) (10 . |ground|) (|List| 9) (15 . |coefficients|)
              (|List| 6) (20 . |variables|) (25 . |setUnion|) (31 . |ground|)
              (|SparseUnivariatePolynomial| 8) (|Mapping| 8 9)
              (|UnivariatePolynomialCategoryFunctions2| 9 11 8 22) (36 . |map|)
              (|Factored| 22) (42 . |unit|) (47 . |retract|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 29) (|:| |factor| 22) (|:| |exponent| 39))
              (|List| 30) (52 . |factorList|) (57 . |coerce|) (|Mapping| 9 8)
              (|UnivariatePolynomialCategoryFunctions2| 8 22 9 11) (62 . |map|)
              (68 . |Zero|) (72 . |Zero|) (|NonNegativeInteger|)
              (76 . |minimumDegree|) (81 . |One|) (85 . |One|)
              (89 . |monomial|) (|Union| $ '"failed") (95 . |exquo|)
              (101 . |degree|) (|Record| (|:| |irr| 11) (|:| |pow| 39))
              (|List| 47) (106 . |append|)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (112 . |unitNormal|) (|Factored| 11)
              (|MultivariateSquareFree| 7 6 8 9) (117 . |squareFree|)
              (122 . |unit|) (127 . *)
              (|Record| (|:| |flag| 29) (|:| |factor| 11) (|:| |exponent| 39))
              (|List| 57) (133 . |factorList|) (138 . *) (144 . |degree|)
              (150 . |leadingCoefficient|) (155 . |ground?|)
              (160 . |leadingCoefficient|) (165 . ^) (171 . *)
              (177 . |retract|) (182 . |retract|) (187 . |exquo|)
              (193 . |primeFactor|) (199 . *) (205 . |One|) (209 . *)
              (|Mapping| 26 22) |INNMFACT;factor;SupMF;3|
              (|SparseUnivariatePolynomial| $) (215 . |univariate|) (|Integer|)
              (|List| 39) (221 . |position|) (227 . |elt|) (233 . |delete|)
              (239 . |delete|) (245 . |numberOfMonomials|) (250 . |degree|)
              (255 . |coefficient|) (261 . ~=) (267 . |euclideanSize|)
              (|FactoringUtilities| 7 6 8 9) (272 . |ran|) (|List| 8)
              (|List| 91) (277 . |member?|) (283 . |eval|) (290 . |unit?|)
              (295 . |completeEval|) (302 . ~=) (308 . |minimumDegree|)
              (313 . |content|) (318 . |exquo|)
              (|LeadingCoefDetermination| 6 7 8 9) (324 . |polCase|)
              (331 . |differentiate|) (|List| $) (336 . |gcd|)
              (341 . |position|) (347 . |elt|) (353 . |monomial|) (360 . *)
              (366 . |coerce|) (371 . |exquo|)
              (|Record| (|:| |irr| 9) (|:| |pow| 39)) (|List| 112)
              (377 . |append|) (|IntegerPrimesPackage| 78) (383 . |nextPrime|)
              (|Record| (|:| |polfac| 16) (|:| |correct| 8)
                        (|:| |corrfact| 119))
              (|Union| 117 '"failed") (|List| 22)
              (|Record| (|:| |contp| 8) (|:| |factors| 113)) (388 . |distFact|)
              (398 . *) (404 . *) (410 . |coerce|) (|Union| 137 '"failed")
              (|MultivariateLifting| 7 6 8 9) (415 . |lifting|)
              (426 . |primitivePart|) (431 . |reductum|) (436 . |Zero|)
              (440 . ~=) (446 . ^) (452 . +) (458 . |elt|) (464 . |degree|)
              (|Mapping| 11 11) (|List| 11) (470 . |map|)
              (476 . |minimumDegree|) (|Factored| $) (482 . |squareFree|)
              (|Factored| 9) (487 . |unit|)
              (|Record| (|:| |flag| 29) (|:| |factor| 9) (|:| |exponent| 39))
              (|List| 144) (492 . |factorList|) (497 . |degree|) (503 . |One|)
              (507 . |member?|) (513 . |gcd|) (518 . ~=) (524 . ~=)
              (530 . |exquo|) (536 . |multivariate|) (542 . |unitCanonical|)
              (547 . |unitCanonical|) (552 . |primeFactor|) (558 . *)
              (564 . |One|) (568 . *) |INNMFACT;factor;PMF;17|)
           '#(|factor| 574) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|factor|
                                 ((|Factored| |#4|) |#4|
                                  (|Mapping|
                                   (|Factored|
                                    (|SparseUnivariatePolynomial| |#3|))
                                   (|SparseUnivariatePolynomial| |#3|))))
                                T)
                              '((|factor|
                                 ((|Factored|
                                   (|SparseUnivariatePolynomial| |#4|))
                                  (|SparseUnivariatePolynomial| |#4|)
                                  (|Mapping|
                                   (|Factored|
                                    (|SparseUnivariatePolynomial| |#3|))
                                   (|SparseUnivariatePolynomial| |#3|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 161
                                            '(1 11 0 9 12 1 11 13 0 14 1 11 9 0
                                              15 1 11 16 0 17 1 9 18 0 19 2 18
                                              0 0 0 20 1 9 8 0 21 2 24 22 23 11
                                              25 1 26 22 0 27 1 22 8 0 28 1 26
                                              31 0 32 1 9 0 8 33 2 35 11 34 22
                                              36 0 7 0 37 0 8 0 38 1 11 39 0 40
                                              0 8 0 41 0 9 0 42 2 11 0 9 39 43
                                              2 11 44 0 0 45 1 11 39 0 46 2 48
                                              0 0 0 49 1 11 50 0 51 1 53 52 11
                                              54 1 52 11 0 55 2 11 0 0 0 56 1
                                              52 58 0 59 2 9 0 8 0 60 2 9 39 0
                                              6 61 1 11 9 0 62 1 9 13 0 63 1 9
                                              8 0 64 2 8 0 0 39 65 2 8 0 0 0 66
                                              1 11 9 0 67 1 9 8 0 68 2 8 44 0 0
                                              69 2 52 0 11 39 70 2 52 0 0 0 71
                                              0 52 0 72 2 52 0 11 0 73 2 9 76 0
                                              6 77 2 79 78 39 0 80 2 18 6 0 78
                                              81 2 79 0 0 78 82 2 18 0 0 78 83
                                              1 22 39 0 84 1 22 39 0 85 2 22 8
                                              0 39 86 2 8 13 0 0 87 1 8 39 0 88
                                              1 89 8 78 90 2 92 13 91 0 93 3 9
                                              0 0 18 91 94 1 8 13 0 95 3 89 22
                                              11 18 91 96 2 39 13 0 0 97 1 22
                                              39 0 98 1 22 8 0 99 2 22 44 0 8
                                              100 3 101 13 8 39 91 102 1 22 0 0
                                              103 1 22 0 104 105 2 18 78 6 0
                                              106 2 79 39 0 78 107 3 9 0 0 6 39
                                              108 2 9 0 0 0 109 1 9 0 6 110 2 9
                                              44 0 0 111 2 113 0 0 0 114 1 115
                                              78 78 116 6 101 118 8 119 120 91
                                              18 91 121 2 22 0 8 0 122 2 11 0 9
                                              0 123 1 8 0 78 124 7 126 125 11
                                              18 119 91 16 79 8 127 1 11 0 0
                                              128 1 11 0 0 129 0 11 0 130 2 11
                                              13 0 0 131 2 9 0 0 39 132 2 11 0
                                              0 0 133 2 11 0 0 0 134 2 89 79 11
                                              18 135 2 137 0 136 0 138 2 9 79 0
                                              18 139 1 9 140 0 141 1 142 9 0
                                              143 1 142 145 0 146 2 9 79 0 18
                                              147 0 11 0 148 2 79 13 39 0 149 1
                                              9 0 104 150 2 6 13 0 0 151 2 9 13
                                              0 0 152 2 11 44 0 9 153 2 9 0 76
                                              6 154 1 11 0 0 155 1 9 0 0 156 2
                                              142 0 9 39 157 2 142 0 0 0 158 0
                                              142 0 159 2 142 0 9 0 160 2 0 52
                                              11 74 75 2 0 142 9 74 161)))))
           '|lookupComplete|)) 
