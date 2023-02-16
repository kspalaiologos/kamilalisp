
(SDEFUN |PFBR;gen_solv1|
        ((|fl| (|List| (|SparseUnivariatePolynomial| R)))
         ($
          (|Mapping|
           (|Union| (|List| (|SparseUnivariatePolynomial| R)) "failed")
           (|SparseUnivariatePolynomial| R))))
        (SPROG NIL (CONS #'|PFBR;gen_solv1!0| (VECTOR $ |fl|)))) 

(SDEFUN |PFBR;gen_solv1!0| ((|pr| NIL) ($$ NIL))
        (PROG (|fl| $)
          (LETT |fl| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |fl| |pr| (QREFELT $ 13)))))) 

(SDEFUN |PFBR;gen_solv|
        ((|fl| (|List| (|SparseUnivariatePolynomial| R)))
         ($
          (|Union|
           (|Mapping|
            (|Union| (|List| (|SparseUnivariatePolynomial| R)) "failed")
            (|SparseUnivariatePolynomial| R))
           "failed")))
        (CONS 0 (|PFBR;gen_solv1| |fl| $))) 

(SDEFUN |PFBR;randomR;IR;3| ((|n| (|Integer|)) ($ (R)))
        (SPADCALL (QREFELT $ 14))) 

(SDEFUN |PFBR;randomR;IR;4| ((|n| (|Integer|)) ($ (R)))
        (SPADCALL (- (RANDOM (+ (* 2 |n|) 1)) |n|) (QREFELT $ 17))) 

(SDEFUN |PFBR;bivariateSLPEBR;LSupVarSetU;5|
        ((|lpolys| (|List| (|SparseUnivariatePolynomial| S)))
         (|pp| (|SparseUnivariatePolynomial| S)) (|v| (|VarSet|))
         ($ (|Union| (|List| (|SparseUnivariatePolynomial| S)) "failed")))
        (SPROG
         ((#1=#:G751 NIL) (|w| NIL) (#2=#:G750 NIL)
          (|ans|
           (|Union|
            (|List|
             (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| R)))
            "failed"))
          (|ppR|
           (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| R)))
          (|lpolysR|
           (|List|
            (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| R))))
          (#3=#:G749 NIL) (|u| NIL) (#4=#:G748 NIL))
         (SEQ
          (LETT |lpolysR|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |u| NIL) (LETT #3# |lpolys|) G190
                      (COND
                       ((OR (ATOM #3#) (PROGN (LETT |u| (CAR #3#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #4#
                              (CONS (SPADCALL (ELT $ 19) |u| (QREFELT $ 24))
                                    #4#))))
                      (LETT #3# (CDR #3#)) (GO G190) G191
                      (EXIT (NREVERSE #4#)))))
          (LETT |ppR| (SPADCALL (ELT $ 19) |pp| (QREFELT $ 24)))
          (LETT |ans| (SPADCALL |lpolysR| |ppR| (QREFELT $ 25)))
          (EXIT
           (COND ((QEQCAR |ans| 1) (CONS 1 "failed"))
                 ('T
                  (CONS 0
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |w| NIL) (LETT #1# (QCDR |ans|)) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |w| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2#
                                      (CONS
                                       (SPADCALL
                                        (CONS
                                         #'|PFBR;bivariateSLPEBR;LSupVarSetU;5!0|
                                         (VECTOR $ |v|))
                                        |w| (QREFELT $ 30))
                                       #2#))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#))))))))))) 

(SDEFUN |PFBR;bivariateSLPEBR;LSupVarSetU;5!0| ((|z1| NIL) ($$ NIL))
        (PROG (|v| $)
          (LETT |v| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z1| |v| (QREFELT $ 27)))))) 

(SDEFUN |PFBR;bivariateSLPEBR;LSupVarSetU;6|
        ((|lpolys| (|List| (|SparseUnivariatePolynomial| S)))
         (|pp| (|SparseUnivariatePolynomial| S)) (|v| (|VarSet|))
         ($ (|Union| (|List| (|SparseUnivariatePolynomial| S)) "failed")))
        (SPADCALL |lpolys| |pp| (QREFELT $ 35))) 

(SDEFUN |PFBR;chooseFSQViableSubstitutions|
        ((|lvpp| (|List| |VarSet|)) (|pp| (|SparseUnivariatePolynomial| S))
         ($
          (|Record| (|:| |substnsField| (|List| R))
                    (|:| |ppRField| (|SparseUnivariatePolynomial| R)))))
        (SPROG
         ((#1=#:G766 NIL) (|ppR| (|SparseUnivariatePolynomial| R))
          (|substns| (|List| R)) (#2=#:G768 NIL) (|v| NIL) (#3=#:G767 NIL)
          (|n| (|Integer|)))
         (SEQ (LETT |n| 1)
              (SEQ
               (EXIT
                (SEQ G190 (COND ((NULL 'T) (GO G191)))
                     (SEQ (LETT |n| (+ (* 2 |n|) 1))
                          (LETT |substns|
                                (PROGN
                                 (LETT #3# NIL)
                                 (SEQ (LETT |v| NIL) (LETT #2# |lvpp|) G190
                                      (COND
                                       ((OR (ATOM #2#)
                                            (PROGN (LETT |v| (CAR #2#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #3#
                                              (CONS
                                               (SPADCALL |n| (QREFELT $ 16))
                                               #3#))))
                                      (LETT #2# (CDR #2#)) (GO G190) G191
                                      (EXIT (NREVERSE #3#)))))
                          (EXIT
                           (COND
                            ((SPADCALL
                              (SPADCALL (SPADCALL |pp| (QREFELT $ 36)) |lvpp|
                                        |substns| (QREFELT $ 39))
                              (QREFELT $ 41))
                             "next")
                            ('T
                             (SEQ
                              (LETT |ppR|
                                    (SPADCALL
                                     (CONS
                                      #'|PFBR;chooseFSQViableSubstitutions!0|
                                      (VECTOR $ |substns| |lvpp|))
                                     |pp| (QREFELT $ 45)))
                              (EXIT
                               (COND
                                ((>
                                  (SPADCALL
                                   (SPADCALL |ppR|
                                             (SPADCALL |ppR| (QREFELT $ 46))
                                             (QREFELT $ 47))
                                   (QREFELT $ 49))
                                  0)
                                 "next")
                                ('T
                                 (PROGN
                                  (LETT #1# |$NoValue|)
                                  (GO #4=#:G763))))))))))
                     NIL (GO G190) G191 (EXIT NIL)))
               #4# (EXIT #1#))
              (EXIT (CONS |substns| |ppR|))))) 

(SDEFUN |PFBR;chooseFSQViableSubstitutions!0| ((|z1| NIL) ($$ NIL))
        (PROG (|lvpp| |substns| $)
          (LETT |lvpp| (QREFELT $$ 2))
          (LETT |substns| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |z1| |lvpp| |substns| (QREFELT $ 39))
                      (QREFELT $ 42)))))) 

(SDEFUN |PFBR;chooseSLPEViableSubstitutions|
        ((|lvpolys| (|List| |VarSet|))
         (|lpolys| (|List| (|SparseUnivariatePolynomial| S)))
         (|pp| (|SparseUnivariatePolynomial| S))
         ($
          (|Record| (|:| |substnsField| (|List| R))
                    (|:| |lpolysRField|
                         (|List| (|SparseUnivariatePolynomial| R)))
                    (|:| |ppRField| (|SparseUnivariatePolynomial| R)))))
        (SPROG
         ((|ppR| (|SparseUnivariatePolynomial| R)) (#1=#:G795 NIL)
          (|uu| #2=(|List| (|SparseUnivariatePolynomial| R))) (#3=#:G794 NIL)
          (#4=#:G782 NIL) (#5=#:G781 #6=(|Boolean|)) (#7=#:G783 #6#)
          (#8=#:G801 NIL) (|v| NIL) (|lpolysR| #2#) (#9=#:G800 NIL) (|u| NIL)
          (#10=#:G799 NIL) (#11=#:G774 NIL) (#12=#:G773 #13=(|Boolean|))
          (#14=#:G775 #13#) (#15=#:G798 NIL) (|substns| (|List| R))
          (#16=#:G797 NIL) (#17=#:G796 NIL) (|n| (|Integer|)))
         (SEQ (LETT |n| 1)
              (SEQ
               (EXIT
                (SEQ G190 (COND ((NULL 'T) (GO G191)))
                     (SEQ (LETT |n| (+ (* 2 |n|) 1))
                          (LETT |substns|
                                (PROGN
                                 (LETT #17# NIL)
                                 (SEQ (LETT |v| NIL) (LETT #16# |lvpolys|) G190
                                      (COND
                                       ((OR (ATOM #16#)
                                            (PROGN (LETT |v| (CAR #16#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #17#
                                              (CONS
                                               (SPADCALL |n| (QREFELT $ 16))
                                               #17#))))
                                      (LETT #16# (CDR #16#)) (GO G190) G191
                                      (EXIT (NREVERSE #17#)))))
                          (EXIT
                           (COND
                            ((OR
                              (SPADCALL
                               (SPADCALL (SPADCALL |pp| (QREFELT $ 36))
                                         |lvpolys| |substns| (QREFELT $ 39))
                               (QREFELT $ 41))
                              (PROGN
                               (LETT #11# NIL)
                               (SEQ (LETT |u| NIL) (LETT #15# |lpolys|) G190
                                    (COND
                                     ((OR (ATOM #15#)
                                          (PROGN (LETT |u| (CAR #15#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (PROGN
                                       (LETT #14#
                                             (SPADCALL
                                              (SPADCALL
                                               (SPADCALL |u| (QREFELT $ 36))
                                               |lvpolys| |substns|
                                               (QREFELT $ 39))
                                              (QREFELT $ 41)))
                                       (COND
                                        (#11#
                                         (LETT #12#
                                               (COND (#12# 'T) ('T #14#))))
                                        ('T
                                         (PROGN
                                          (LETT #12# #14#)
                                          (LETT #11# 'T)))))))
                                    (LETT #15# (CDR #15#)) (GO G190) G191
                                    (EXIT NIL))
                               (COND (#11# #12#) ('T NIL))))
                             "next")
                            ('T
                             (SEQ
                              (LETT |lpolysR|
                                    (PROGN
                                     (LETT #10# NIL)
                                     (SEQ (LETT |u| NIL) (LETT #9# |lpolys|)
                                          G190
                                          (COND
                                           ((OR (ATOM #9#)
                                                (PROGN
                                                 (LETT |u| (CAR #9#))
                                                 NIL))
                                            (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (LETT #10#
                                                  (CONS
                                                   (SPADCALL
                                                    (CONS
                                                     #'|PFBR;chooseSLPEViableSubstitutions!0|
                                                     (VECTOR $ |substns|
                                                             |lvpolys|))
                                                    |u| (QREFELT $ 45))
                                                   #10#))))
                                          (LETT #9# (CDR #9#)) (GO G190) G191
                                          (EXIT (NREVERSE #10#)))))
                              (LETT |uu| |lpolysR|)
                              (SEQ
                               (EXIT
                                (SEQ G190
                                     (COND
                                      ((NULL (NULL (NULL |uu|))) (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (COND
                                        ((PROGN
                                          (LETT #4# NIL)
                                          (SEQ (LETT |v| NIL)
                                               (LETT #8# (CDR |uu|)) G190
                                               (COND
                                                ((OR (ATOM #8#)
                                                     (PROGN
                                                      (LETT |v| (CAR #8#))
                                                      NIL))
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (PROGN
                                                  (LETT #7#
                                                        (>
                                                         (SPADCALL
                                                          (SPADCALL
                                                           (|SPADfirst| |uu|)
                                                           |v| (QREFELT $ 47))
                                                          (QREFELT $ 49))
                                                         0))
                                                  (COND
                                                   (#4#
                                                    (LETT #5#
                                                          (COND (#5# 'T)
                                                                ('T #7#))))
                                                   ('T
                                                    (PROGN
                                                     (LETT #5# #7#)
                                                     (LETT #4# 'T)))))))
                                               (LETT #8# (CDR #8#)) (GO G190)
                                               G191 (EXIT NIL))
                                          (COND (#4# #5#) ('T NIL)))
                                         (PROGN (LETT #3# 1) (GO #18=#:G785)))
                                        ('T (LETT |uu| (CDR |uu|))))))
                                     NIL (GO G190) G191 (EXIT NIL)))
                               #18# (EXIT #3#))
                              (COND ((NULL (NULL |uu|)) (EXIT "next")))
                              (EXIT
                               (PROGN
                                (LETT #1# |$NoValue|)
                                (GO #19=#:G790))))))))
                     NIL (GO G190) G191 (EXIT NIL)))
               #19# (EXIT #1#))
              (LETT |ppR|
                    (SPADCALL
                     (CONS #'|PFBR;chooseSLPEViableSubstitutions!1|
                           (VECTOR $ |substns| |lvpolys|))
                     |pp| (QREFELT $ 45)))
              (EXIT (VECTOR |substns| |lpolysR| |ppR|))))) 

(SDEFUN |PFBR;chooseSLPEViableSubstitutions!1| ((|z1| NIL) ($$ NIL))
        (PROG (|lvpolys| |substns| $)
          (LETT |lvpolys| (QREFELT $$ 2))
          (LETT |substns| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |z1| |lvpolys| |substns| (QREFELT $ 39))
                      (QREFELT $ 42)))))) 

(SDEFUN |PFBR;chooseSLPEViableSubstitutions!0| ((|z1| NIL) ($$ NIL))
        (PROG (|lvpolys| |substns| $)
          (LETT |lvpolys| (QREFELT $$ 2))
          (LETT |substns| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |z1| |lvpolys| |substns| (QREFELT $ 39))
                      (QREFELT $ 42)))))) 

(SDEFUN |PFBR;raise|
        ((|supR| (|SparseUnivariatePolynomial| R))
         ($ (|SparseUnivariatePolynomial| S)))
        (SPADCALL (ELT $ 50) |supR| (QREFELT $ 53))) 

(SDEFUN |PFBR;lower|
        ((|pp| (|SparseUnivariatePolynomial| S))
         ($ (|SparseUnivariatePolynomial| R)))
        (SPADCALL (ELT $ 42) |pp| (QREFELT $ 45))) 

(SDEFUN |PFBR;SLPEBR|
        ((|lpolys| (|List| (|SparseUnivariatePolynomial| S)))
         (|lvpolys| #1=(|List| |VarSet|))
         (|pp| (|SparseUnivariatePolynomial| S)) (|lvpp| #1#)
         ($ #2=(|Union| (|List| (|SparseUnivariatePolynomial| S)) "failed")))
        (SPROG
         ((|ansR| (|Union| (|List| (|SparseUnivariatePolynomial| R)) "failed"))
          (|cVS|
           (|Record| (|:| |substnsField| (|List| R))
                     (|:| |lpolysRField|
                          (|List| (|SparseUnivariatePolynomial| R)))
                     (|:| |ppRField| (|SparseUnivariatePolynomial| R))))
          (#3=#:G850 NIL) (|uu| NIL) (#4=#:G849 NIL) (#5=#:G838 NIL)
          (|ppR| (|SparseUnivariatePolynomial| R))
          (|lpolysR| (|List| (|SparseUnivariatePolynomial| R))) (#6=#:G848 NIL)
          (|u| NIL) (#7=#:G847 NIL) (#8=#:G846 NIL) (#9=#:G845 NIL)
          (|ans|
           (|List|
            (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| S))))
          (#10=#:G843 NIL) (|a| NIL) (#11=#:G844 NIL) (|a1| NIL)
          (#12=#:G842 NIL) (|d| (|NonNegativeInteger|)) (|ans1| #2#)
          (#13=#:G841 NIL) (#14=#:G840 NIL) (#15=#:G839 NIL)
          (|pp1|
           (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| S)))
          (|v| (|VarSet|)) (|m| (|List| |VarSet|)))
         (SEQ
          (EXIT
           (COND
            ((NULL
              (NULL (LETT |m| (SPADCALL |lvpp| |lvpolys| (QREFELT $ 54)))))
             (SEQ (LETT |v| (|SPADfirst| |m|))
                  (LETT |lvpp| (SPADCALL |v| |lvpp| (QREFELT $ 55)))
                  (LETT |pp1|
                        (SPADCALL
                         (SPADCALL (CONS #'|PFBR;SLPEBR!0| (VECTOR $ |v|)) |pp|
                                   (QREFELT $ 60))
                         (QREFELT $ 62)))
                  (LETT |ans|
                        (PROGN
                         (LETT #15# NIL)
                         (SEQ (LETT |u| NIL) (LETT #14# |lpolys|) G190
                              (COND
                               ((OR (ATOM #14#)
                                    (PROGN (LETT |u| (CAR #14#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #15# (CONS (|spadConstant| $ 63) #15#))))
                              (LETT #14# (CDR #14#)) (GO G190) G191
                              (EXIT (NREVERSE #15#)))))
                  (SEQ (LETT #13# (NREVERSE (SPADCALL |pp1| (QREFELT $ 65))))
                       G190
                       (COND
                        ((OR (ATOM #13#) (PROGN (LETT |m| (CAR #13#)) NIL))
                         (GO G191)))
                       (SEQ
                        (LETT |ans1|
                              (|PFBR;SLPEBR| |lpolys| |lvpolys|
                               (SPADCALL |m| (QREFELT $ 66)) |lvpp| $))
                        (EXIT
                         (COND
                          ((QEQCAR |ans1| 1)
                           (PROGN
                            (LETT #5# (CONS 1 "failed"))
                            (GO #16=#:G837)))
                          ('T
                           (SEQ (LETT |d| (SPADCALL |m| (QREFELT $ 67)))
                                (EXIT
                                 (LETT |ans|
                                       (PROGN
                                        (LETT #12# NIL)
                                        (SEQ (LETT |a1| NIL)
                                             (LETT #11# (QCDR |ans1|))
                                             (LETT |a| NIL) (LETT #10# |ans|)
                                             G190
                                             (COND
                                              ((OR (ATOM #10#)
                                                   (PROGN
                                                    (LETT |a| (CAR #10#))
                                                    NIL)
                                                   (ATOM #11#)
                                                   (PROGN
                                                    (LETT |a1| (CAR #11#))
                                                    NIL))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (LETT #12#
                                                     (CONS
                                                      (SPADCALL
                                                       (SPADCALL |a1| |d|
                                                                 (QREFELT $
                                                                          68))
                                                       |a| (QREFELT $ 69))
                                                      #12#))))
                                             (LETT #10#
                                                   (PROG1 (CDR #10#)
                                                     (LETT #11# (CDR #11#))))
                                             (GO G190) G191
                                             (EXIT (NREVERSE #12#)))))))))))
                       (LETT #13# (CDR #13#)) (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (CONS 0
                         (PROGN
                          (LETT #9# NIL)
                          (SEQ (LETT #8# |ans|) G190
                               (COND
                                ((OR (ATOM #8#)
                                     (PROGN (LETT |pp1| (CAR #8#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #9#
                                       (CONS
                                        (SPADCALL
                                         (CONS #'|PFBR;SLPEBR!1|
                                               (VECTOR $ |v|))
                                         (SPADCALL |pp1| (QREFELT $ 62))
                                         (QREFELT $ 72))
                                        #9#))))
                               (LETT #8# (CDR #8#)) (GO G190) G191
                               (EXIT (NREVERSE #9#))))))))
            ('T
             (COND
              ((NULL |lvpolys|)
               (SEQ
                (LETT |lpolysR|
                      (PROGN
                       (LETT #7# NIL)
                       (SEQ (LETT |u| NIL) (LETT #6# |lpolys|) G190
                            (COND
                             ((OR (ATOM #6#) (PROGN (LETT |u| (CAR #6#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #7#
                                    (CONS
                                     (SPADCALL (ELT $ 42) |u| (QREFELT $ 45))
                                     #7#))))
                            (LETT #6# (CDR #6#)) (GO G190) G191
                            (EXIT (NREVERSE #7#)))))
                (LETT |ppR| (SPADCALL (ELT $ 42) |pp| (QREFELT $ 45)))
                (LETT |ansR| (SPADCALL |lpolysR| |ppR| (QREFELT $ 13)))
                (EXIT
                 (COND
                  ((QEQCAR |ansR| 1)
                   (PROGN (LETT #5# (CONS 1 "failed")) (GO #16#)))
                  (#17='T
                   (CONS 0
                         (PROGN
                          (LETT #4# NIL)
                          (SEQ (LETT |uu| NIL) (LETT #3# (QCDR |ansR|)) G190
                               (COND
                                ((OR (ATOM #3#)
                                     (PROGN (LETT |uu| (CAR #3#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #4#
                                       (CONS
                                        (SPADCALL (ELT $ 50) |uu|
                                                  (QREFELT $ 53))
                                        #4#))))
                               (LETT #3# (CDR #3#)) (GO G190) G191
                               (EXIT (NREVERSE #4#))))))))))
              (#17#
               (SEQ
                (LETT |cVS|
                      (|PFBR;chooseSLPEViableSubstitutions| |lvpolys| |lpolys|
                       |pp| $))
                (LETT |ansR|
                      (SPADCALL (QVELT |cVS| 1) (QVELT |cVS| 2)
                                (QREFELT $ 13)))
                (EXIT
                 (COND ((QEQCAR |ansR| 1) (CONS 1 "failed"))
                       ((EQL (LENGTH |lvpolys|) 1)
                        (SPADCALL |lpolys| |pp| (|SPADfirst| |lvpolys|)
                                  (QREFELT $ 33)))
                       (#17# (SPADCALL |lpolys| |pp| (QREFELT $ 35)))))))))))
          #16# (EXIT #5#)))) 

(SDEFUN |PFBR;SLPEBR!1| ((|z1| NIL) ($$ NIL))
        (PROG (|v| $)
          (LETT |v| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z1| |v| (QREFELT $ 26)))))) 

(SDEFUN |PFBR;SLPEBR!0| ((|z1| NIL) ($$ NIL))
        (PROG (|v| $)
          (LETT |v| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z1| |v| (QREFELT $ 56)))))) 

(SDEFUN |PFBR;solveLinearPolynomialEquationByRecursion;LSupU;12|
        ((|lpolys| (|List| (|SparseUnivariatePolynomial| S)))
         (|pp| (|SparseUnivariatePolynomial| S))
         ($ (|Union| (|List| (|SparseUnivariatePolynomial| S)) "failed")))
        (SPROG
         ((|lvpp| #1=(|List| |VarSet|)) (#2=#:G876 NIL) (|z| NIL)
          (#3=#:G875 NIL) (|lvpolys| #1#) (#4=#:G874 NIL) (#5=#:G873 NIL)
          (#6=#:G872 NIL) (|u| NIL) (#7=#:G871 NIL) (#8=#:G870 NIL)
          (#9=#:G869 NIL))
         (SEQ
          (COND
           ((SPADCALL |pp| (|spadConstant| $ 75) (QREFELT $ 76))
            (CONS 0
                  (PROGN
                   (LETT #9# NIL)
                   (SEQ (LETT |u| NIL) (LETT #8# |lpolys|) G190
                        (COND
                         ((OR (ATOM #8#) (PROGN (LETT |u| (CAR #8#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT (LETT #9# (CONS (|spadConstant| $ 75) #9#))))
                        (LETT #8# (CDR #8#)) (GO G190) G191
                        (EXIT (NREVERSE #9#))))))
           ('T
            (SEQ
             (LETT |lvpolys|
                   (SPADCALL
                    (SPADCALL
                     (PROGN
                      (LETT #7# NIL)
                      (SEQ (LETT |u| NIL) (LETT #6# |lpolys|) G190
                           (COND
                            ((OR (ATOM #6#) (PROGN (LETT |u| (CAR #6#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #7#
                                   (CONS
                                    (SPADCALL
                                     (PROGN
                                      (LETT #5# NIL)
                                      (SEQ (LETT |z| NIL)
                                           (LETT #4#
                                                 (SPADCALL |u| (QREFELT $ 78)))
                                           G190
                                           (COND
                                            ((OR (ATOM #4#)
                                                 (PROGN
                                                  (LETT |z| (CAR #4#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (LETT #5#
                                                   (CONS
                                                    (SPADCALL |z|
                                                              (QREFELT $ 79))
                                                    #5#))))
                                           (LETT #4# (CDR #4#)) (GO G190) G191
                                           (EXIT (NREVERSE #5#))))
                                     (QREFELT $ 80))
                                    #7#))))
                           (LETT #6# (CDR #6#)) (GO G190) G191
                           (EXIT (NREVERSE #7#))))
                     (QREFELT $ 80))
                    (QREFELT $ 81)))
             (LETT |lvpp|
                   (SPADCALL
                    (SPADCALL
                     (PROGN
                      (LETT #3# NIL)
                      (SEQ (LETT |z| NIL)
                           (LETT #2# (SPADCALL |pp| (QREFELT $ 78))) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |z| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #3#
                                   (CONS (SPADCALL |z| (QREFELT $ 79)) #3#))))
                           (LETT #2# (CDR #2#)) (GO G190) G191
                           (EXIT (NREVERSE #3#))))
                     (QREFELT $ 80))
                    (QREFELT $ 81)))
             (EXIT (|PFBR;SLPEBR| |lpolys| |lvpolys| |pp| |lvpp| $)))))))) 

(SDEFUN |PFBR;factorByRecursion;SupF;13|
        ((|pp| (|SparseUnivariatePolynomial| S))
         ($ (|Factored| (|SparseUnivariatePolynomial| S))))
        (SPROG
         ((#1=#:G891 NIL) (|c| (S)) (|lv| (|List| |VarSet|)) (#2=#:G899 NIL)
          (|z| NIL) (#3=#:G898 NIL))
         (SEQ
          (LETT |lv|
                (SPADCALL
                 (SPADCALL
                  (PROGN
                   (LETT #3# NIL)
                   (SEQ (LETT |z| NIL)
                        (LETT #2# (SPADCALL |pp| (QREFELT $ 78))) G190
                        (COND
                         ((OR (ATOM #2#) (PROGN (LETT |z| (CAR #2#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #3# (CONS (SPADCALL |z| (QREFELT $ 79)) #3#))))
                        (LETT #2# (CDR #2#)) (GO G190) G191
                        (EXIT (NREVERSE #3#))))
                  (QREFELT $ 80))
                 (QREFELT $ 81)))
          (EXIT
           (COND
            ((NULL |lv|)
             (SPADCALL (CONS (|function| |PFBR;raise|) $)
                       (SPADCALL (|PFBR;lower| |pp| $) (QREFELT $ 84))
                       (QREFELT $ 89)))
            (#4='T
             (SEQ (LETT |c| (SPADCALL |pp| (QREFELT $ 90)))
                  (EXIT
                   (COND
                    ((SPADCALL |c| (QREFELT $ 91))
                     (SPADCALL (SPADCALL |pp| (QREFELT $ 93)) (ELT $ 94)
                               (QREFELT $ 97)))
                    (#4#
                     (SEQ
                      (LETT |pp|
                            (PROG2
                                (LETT #1# (SPADCALL |pp| |c| (QREFELT $ 99)))
                                (QCDR #1#)
                              (|check_union2| (QEQCAR #1# 0)
                                              (|SparseUnivariatePolynomial|
                                               (QREFELT $ 9))
                                              (|Union|
                                               (|SparseUnivariatePolynomial|
                                                (QREFELT $ 9))
                                               "failed")
                                              #1#)))
                      (EXIT
                       (SPADCALL
                        (SPADCALL (SPADCALL |pp| (QREFELT $ 93)) (ELT $ 94)
                                  (QREFELT $ 97))
                        (SPADCALL (ELT $ 100) (SPADCALL |c| (QREFELT $ 101))
                                  (QREFELT $ 104))
                        (QREFELT $ 105)))))))))))))) 

(SDEFUN |PFBR;factorSquareFreeByRecursion;SupF;14|
        ((|pp| (|SparseUnivariatePolynomial| S))
         ($ (|Factored| (|SparseUnivariatePolynomial| S))))
        (SPROG
         ((#1=#:G949 NIL) (#2=#:G964 NIL) (|w| NIL) (#3=#:G963 NIL)
          (#4=#:G935 NIL) (|factors| (|List| (|SparseUnivariatePolynomial| S)))
          (#5=#:G909 NIL) (|lcppPow| (S)) (|lc| (S)) (#6=#:G962 NIL)
          (#7=#:G961 NIL)
          (|flu| (|Union| (|List| (|SparseUnivariatePolynomial| S)) "failed"))
          (|llc| (|List| S)) (#8=#:G960 NIL) (|f1| NIL) (#9=#:G959 NIL)
          (|ppAdjust| (|SparseUnivariatePolynomial| S))
          (|fl2| (|List| (|SparseUnivariatePolynomial| R))) (#10=#:G925 NIL)
          (#11=#:G958 NIL) (#12=#:G957 NIL) (|lcppR| (R))
          (|fl1| (|List| (|SparseUnivariatePolynomial| R))) (#13=#:G956 NIL)
          (|u| NIL) (#14=#:G955 NIL) (|nfact| (|NonNegativeInteger|))
          (|factorsR| (|Factored| (|SparseUnivariatePolynomial| R)))
          (|newppR| (|SparseUnivariatePolynomial| R))
          (|cVS|
           (|Record| (|:| |substnsField| (|List| R))
                     (|:| |ppRField| (|SparseUnivariatePolynomial| R))))
          (|oldnfact| (|NonNegativeInteger|)) (|lcpp| (S)) (|lcu| (S))
          (|v_degs| (|List| (|NonNegativeInteger|))) (#15=#:G904 NIL)
          (#16=#:G903 #17=(|NonNegativeInteger|)) (#18=#:G905 #17#)
          (#19=#:G954 NIL) (|z| NIL) (#20=#:G953 NIL) (|v| NIL)
          (#21=#:G952 NIL) (|lv| (|List| |VarSet|)) (#22=#:G951 NIL)
          (#23=#:G950 NIL) (|cpp| (|List| S)))
         (SEQ
          (EXIT
           (SEQ (LETT |cpp| (SPADCALL |pp| (QREFELT $ 78)))
                (LETT |lv|
                      (SPADCALL
                       (SPADCALL
                        (PROGN
                         (LETT #23# NIL)
                         (SEQ (LETT |z| NIL) (LETT #22# |cpp|) G190
                              (COND
                               ((OR (ATOM #22#)
                                    (PROGN (LETT |z| (CAR #22#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #23#
                                      (CONS (SPADCALL |z| (QREFELT $ 79))
                                            #23#))))
                              (LETT #22# (CDR #22#)) (GO G190) G191
                              (EXIT (NREVERSE #23#))))
                        (QREFELT $ 80))
                       (QREFELT $ 81)))
                (LETT |v_degs|
                      (PROGN
                       (LETT #21# NIL)
                       (SEQ (LETT |v| NIL) (LETT #20# |lv|) G190
                            (COND
                             ((OR (ATOM #20#)
                                  (PROGN (LETT |v| (CAR #20#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #21#
                                    (CONS
                                     (PROGN
                                      (LETT #15# NIL)
                                      (SEQ (LETT |z| NIL) (LETT #19# |cpp|)
                                           G190
                                           (COND
                                            ((OR (ATOM #19#)
                                                 (PROGN
                                                  (LETT |z| (CAR #19#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (PROGN
                                              (LETT #18#
                                                    (SPADCALL |z| |v|
                                                              (QREFELT $ 107)))
                                              (COND
                                               (#15#
                                                (LETT #16# (MAX #16# #18#)))
                                               ('T
                                                (PROGN
                                                 (LETT #16# #18#)
                                                 (LETT #15# 'T)))))))
                                           (LETT #19# (CDR #19#)) (GO G190)
                                           G191 (EXIT NIL))
                                      (COND (#15# #16#)
                                            ('T (|IdentityError| '|max|))))
                                     #21#))))
                            (LETT #20# (CDR #20#)) (GO G190) G191
                            (EXIT (NREVERSE #21#)))))
                (EXIT
                 (COND
                  ((NULL |lv|)
                   (SPADCALL (CONS (|function| |PFBR;raise|) $)
                             (SPADCALL (|PFBR;lower| |pp| $) (QREFELT $ 84))
                             (QREFELT $ 89)))
                  ('T
                   (SEQ (LETT |lcu| (|spadConstant| $ 108))
                        (COND
                         ((SPADCALL
                           (LETT |lcpp| (SPADCALL |pp| (QREFELT $ 36)))
                           (QREFELT $ 91))
                          (SEQ (LETT |lcu| |lcpp|)
                               (LETT |pp|
                                     (PROG2
                                         (LETT #5#
                                               (SPADCALL |pp| |lcu|
                                                         (QREFELT $ 99)))
                                         (QCDR #5#)
                                       (|check_union2| (QEQCAR #5# 0)
                                                       (|SparseUnivariatePolynomial|
                                                        (QREFELT $ 9))
                                                       (|Union|
                                                        (|SparseUnivariatePolynomial|
                                                         (QREFELT $ 9))
                                                        #24="failed")
                                                       #5#)))
                               (EXIT (LETT |lcpp| (|spadConstant| $ 108))))))
                        (LETT |oldnfact| (+ (SPADCALL |pp| (QREFELT $ 109)) 1))
                        (EXIT
                         (SEQ G190 (COND ((NULL 'T) (GO G191)))
                              (SEQ
                               (LETT |cVS|
                                     (|PFBR;chooseFSQViableSubstitutions| |lv|
                                      |pp| $))
                               (LETT |newppR|
                                     (SPADCALL (QCDR |cVS|) (QREFELT $ 110)))
                               (LETT |factorsR|
                                     (SPADCALL |newppR| (QREFELT $ 111)))
                               (LETT |nfact|
                                     (SPADCALL |factorsR| (QREFELT $ 112)))
                               (EXIT
                                (COND
                                 ((EQL |nfact| 1)
                                  (PROGN
                                   (LETT #1#
                                         (SPADCALL
                                          (SPADCALL |lcu| (QREFELT $ 100))
                                          (LIST
                                           (VECTOR (CONS 2 "irred") |pp| 1))
                                          (QREFELT $ 117)))
                                   (GO #25=#:G948)))
                                 ((> |nfact| |oldnfact|) "next")
                                 ('T
                                  (SEQ
                                   (LETT |fl1|
                                         (PROGN
                                          (LETT #14# NIL)
                                          (SEQ (LETT |u| NIL)
                                               (LETT #13#
                                                     (SPADCALL |factorsR|
                                                               (QREFELT $
                                                                        120)))
                                               G190
                                               (COND
                                                ((OR (ATOM #13#)
                                                     (PROGN
                                                      (LETT |u| (CAR #13#))
                                                      NIL))
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (LETT #14#
                                                       (CONS (QVELT |u| 1)
                                                             #14#))))
                                               (LETT #13# (CDR #13#)) (GO G190)
                                               G191 (EXIT (NREVERSE #14#)))))
                                   (LETT |lcppR|
                                         (SPADCALL (QCDR |cVS|)
                                                   (QREFELT $ 121)))
                                   (LETT |fl2|
                                         (PROGN
                                          (LETT #12# NIL)
                                          (SEQ (LETT |f1| NIL)
                                               (LETT #11# |fl1|) G190
                                               (COND
                                                ((OR (ATOM #11#)
                                                     (PROGN
                                                      (LETT |f1| (CAR #11#))
                                                      NIL))
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (LETT #12#
                                                       (CONS
                                                        (SPADCALL
                                                         (PROG2
                                                             (LETT #10#
                                                                   (SPADCALL
                                                                    |lcppR|
                                                                    (SPADCALL
                                                                     |f1|
                                                                     (QREFELT $
                                                                              121))
                                                                    (QREFELT $
                                                                             122)))
                                                             (QCDR #10#)
                                                           (|check_union2|
                                                            (QEQCAR #10# 0)
                                                            (QREFELT $ 6)
                                                            (|Union|
                                                             (QREFELT $ 6)
                                                             #26="failed")
                                                            #10#))
                                                         |f1| (QREFELT $ 123))
                                                        #12#))))
                                               (LETT #11# (CDR #11#)) (GO G190)
                                               G191 (EXIT (NREVERSE #12#)))))
                                   (LETT |ppAdjust|
                                         (SPADCALL
                                          (LETT |lcppPow|
                                                (SPADCALL |lcpp|
                                                          (LENGTH (CDR |fl2|))
                                                          (QREFELT $ 124)))
                                          |pp| (QREFELT $ 125)))
                                   (LETT |llc|
                                         (PROGN
                                          (LETT #9# NIL)
                                          (SEQ (LETT |f1| NIL) (LETT #8# |fl2|)
                                               G190
                                               (COND
                                                ((OR (ATOM #8#)
                                                     (PROGN
                                                      (LETT |f1| (CAR #8#))
                                                      NIL))
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (LETT #9# (CONS |lcpp| #9#))))
                                               (LETT #8# (CDR #8#)) (GO G190)
                                               G191 (EXIT (NREVERSE #9#)))))
                                   (LETT |flu|
                                         (SPADCALL |ppAdjust| |lv| |fl2|
                                                   (QCAR |cVS|) |llc| |v_degs|
                                                   (CONS
                                                    (|function|
                                                     |PFBR;gen_solv|)
                                                    $)
                                                   (QREFELT $ 133)))
                                   (EXIT
                                    (COND ((QEQCAR |flu| 1) "next")
                                          ('T
                                           (SEQ (LETT |factors| (QCDR |flu|))
                                                (LETT |factors|
                                                      (PROGN
                                                       (LETT #7# NIL)
                                                       (SEQ (LETT |w| NIL)
                                                            (LETT #6#
                                                                  |factors|)
                                                            G190
                                                            (COND
                                                             ((OR (ATOM #6#)
                                                                  (PROGN
                                                                   (LETT |w|
                                                                         (CAR
                                                                          #6#))
                                                                   NIL))
                                                              (GO G191)))
                                                            (SEQ
                                                             (EXIT
                                                              (LETT #7#
                                                                    (CONS
                                                                     (SEQ
                                                                      (LETT
                                                                       |lc|
                                                                       (SPADCALL
                                                                        |w|
                                                                        (QREFELT
                                                                         $
                                                                         90)))
                                                                      (LETT
                                                                       |lcppPow|
                                                                       (PROG2
                                                                           (LETT
                                                                            #4#
                                                                            (SPADCALL
                                                                             |lcppPow|
                                                                             |lc|
                                                                             (QREFELT
                                                                              $
                                                                              134)))
                                                                           (QCDR
                                                                            #4#)
                                                                         (|check_union2|
                                                                          (QEQCAR
                                                                           #4#
                                                                           0)
                                                                          (QREFELT
                                                                           $ 9)
                                                                          (|Union|
                                                                           (QREFELT
                                                                            $
                                                                            9)
                                                                           #26#)
                                                                          #4#)))
                                                                      (EXIT
                                                                       (PROG2
                                                                           (LETT
                                                                            #5#
                                                                            (SPADCALL
                                                                             |w|
                                                                             |lc|
                                                                             (QREFELT
                                                                              $
                                                                              99)))
                                                                           (QCDR
                                                                            #5#)
                                                                         (|check_union2|
                                                                          (QEQCAR
                                                                           #5#
                                                                           0)
                                                                          (|SparseUnivariatePolynomial|
                                                                           (QREFELT
                                                                            $
                                                                            9))
                                                                          (|Union|
                                                                           (|SparseUnivariatePolynomial|
                                                                            (QREFELT
                                                                             $
                                                                             9))
                                                                           #24#)
                                                                          #5#))))
                                                                     #7#))))
                                                            (LETT #6#
                                                                  (CDR #6#))
                                                            (GO G190) G191
                                                            (EXIT
                                                             (NREVERSE #7#)))))
                                                (COND
                                                 ((NULL
                                                   (SPADCALL |lcppPow|
                                                             (QREFELT $ 91)))
                                                  (EXIT
                                                   (|error|
                                                    "internal error in factorSquareFreeByRecursion"))))
                                                (EXIT
                                                 (PROGN
                                                  (LETT #1#
                                                        (SPADCALL
                                                         (SPADCALL |lcu|
                                                                   (SPADCALL
                                                                    (PROG2
                                                                        (LETT
                                                                         #4#
                                                                         (SPADCALL
                                                                          |lcppPow|
                                                                          (QREFELT
                                                                           $
                                                                           135)))
                                                                        (QCDR
                                                                         #4#)
                                                                      (|check_union2|
                                                                       (QEQCAR
                                                                        #4# 0)
                                                                       (QREFELT
                                                                        $ 9)
                                                                       (|Union|
                                                                        (QREFELT
                                                                         $ 9)
                                                                        #26#)
                                                                       #4#))
                                                                    (QREFELT $
                                                                             100))
                                                                   (QREFELT $
                                                                            125))
                                                         (PROGN
                                                          (LETT #3# NIL)
                                                          (SEQ (LETT |w| NIL)
                                                               (LETT #2#
                                                                     |factors|)
                                                               G190
                                                               (COND
                                                                ((OR (ATOM #2#)
                                                                     (PROGN
                                                                      (LETT |w|
                                                                            (CAR
                                                                             #2#))
                                                                      NIL))
                                                                 (GO G191)))
                                                               (SEQ
                                                                (EXIT
                                                                 (LETT #3#
                                                                       (CONS
                                                                        (VECTOR
                                                                         (CONS
                                                                          2
                                                                          "irred")
                                                                         |w| 1)
                                                                        #3#))))
                                                               (LETT #2#
                                                                     (CDR #2#))
                                                               (GO G190) G191
                                                               (EXIT
                                                                (NREVERSE
                                                                 #3#))))
                                                         (QREFELT $ 117)))
                                                  (GO #25#))))))))))))
                              NIL (GO G190) G191 (EXIT NIL)))))))))
          #25# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |PolynomialFactorizationByRecursion;|)) 

(DEFUN |PolynomialFactorizationByRecursion| (&REST #1=#:G965)
  (SPROG NIL
         (PROG (#2=#:G966)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PolynomialFactorizationByRecursion|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |PolynomialFactorizationByRecursion;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|PolynomialFactorizationByRecursion|)))))))))) 

(DEFUN |PolynomialFactorizationByRecursion;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$|
          (LIST '|PolynomialFactorizationByRecursion| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 136))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|PolynomialFactorizationByRecursion|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|HasCategory| |#1| '(|Finite|))
      (QSETREFV $ 16 (CONS (|dispatchFunction| |PFBR;randomR;IR;3|) $)))
     ('T (QSETREFV $ 16 (CONS (|dispatchFunction| |PFBR;randomR;IR;4|) $))))
    (COND
     ((|HasCategory| |#1| '(|FiniteFieldCategory|))
      (QSETREFV $ 33
                (CONS (|dispatchFunction| |PFBR;bivariateSLPEBR;LSupVarSetU;5|)
                      $)))
     ('T
      (QSETREFV $ 33
                (CONS (|dispatchFunction| |PFBR;bivariateSLPEBR;LSupVarSetU;6|)
                      $))))
    $))) 

(MAKEPROP '|PolynomialFactorizationByRecursion| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|Union| 11 '"failed") (|List| 12)
              (|SparseUnivariatePolynomial| $)
              (0 . |solveLinearPolynomialEquation|) (6 . |random|) (|Integer|)
              (10 . |randomR|) (15 . |coerce|) (|SparseUnivariatePolynomial| 6)
              (20 . |univariate|) (|SparseUnivariatePolynomial| 18)
              (|Mapping| 18 9) (|SparseUnivariatePolynomial| 9)
              (|UnivariatePolynomialCategoryFunctions2| 9 22 18 20)
              (25 . |map|) (31 . |solveLinearPolynomialEquation|)
              (37 . |multivariate|) (43 . |multivariate|) (|Mapping| 9 18)
              (|UnivariatePolynomialCategoryFunctions2| 18 20 9 22)
              (49 . |map|) (|Union| 32 '#1="failed") (|List| 22)
              (55 . |bivariateSLPEBR|)
              (|LinearPolynomialEquationByFractions| 9)
              (62 . |solveLinearPolynomialEquationByFractions|)
              (68 . |leadingCoefficient|) (|List| 8) (|List| 6) (73 . |eval|)
              (|Boolean|) (80 . |zero?|) (85 . |retract|) (|Mapping| 6 9)
              (|UnivariatePolynomialCategoryFunctions2| 9 22 6 18) (90 . |map|)
              (96 . |differentiate|) (101 . |gcd|) (|NonNegativeInteger|)
              (107 . |degree|) (112 . |coerce|) (|Mapping| 9 6)
              (|UnivariatePolynomialCategoryFunctions2| 6 18 9 22)
              (117 . |map|) (123 . |setDifference|) (129 . |remove|)
              (135 . |univariate|) (|SparseUnivariatePolynomial| 22)
              (|Mapping| 22 9)
              (|UnivariatePolynomialCategoryFunctions2| 9 22 22 57)
              (141 . |map|) (|CommuteUnivariatePolynomialCategory| 9 22 57)
              (147 . |swap|) (152 . |Zero|) (|List| $) (156 . |monomials|)
              (161 . |leadingCoefficient|) (166 . |degree|) (171 . |monomial|)
              (177 . +) (|Mapping| 9 22)
              (|UnivariatePolynomialCategoryFunctions2| 22 57 9 22)
              (183 . |map|) (189 . |Zero|) (193 . |Zero|) (197 . |Zero|)
              (201 . =) (|List| 9) (207 . |coefficients|) (212 . |variables|)
              (217 . |concat|) (222 . |removeDuplicates!|)
              |PFBR;solveLinearPolynomialEquationByRecursion;LSupU;12|
              (|Factored| 12) (227 . |factorPolynomial|) (|Factored| 22)
              (|Mapping| 22 18) (|Factored| 18) (|FactoredFunctions2| 18 22)
              (232 . |map|) (238 . |content|) (243 . |unit?|) (|Factored| $)
              (248 . |squareFree|) |PFBR;factorSquareFreeByRecursion;SupF;14|
              (|Mapping| 85 22) (|FactoredFunctionUtilities| 22)
              (253 . |refine|) (|Union| $ '"failed") (259 . |exquo|)
              (265 . |coerce|) (270 . |factor|) (|Factored| 9)
              (|FactoredFunctions2| 9 22) (275 . |map|) (281 . |mergeFactors|)
              |PFBR;factorByRecursion;SupF;13| (287 . |degree|) (293 . |One|)
              (297 . |degree|) (302 . |primitivePart|)
              (307 . |factorSquareFreePolynomial|) (312 . |numberOfFactors|)
              (317 . |One|) (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 114) (|:| |factor| 22) (|:| |exponent| 48))
              (|List| 115) (321 . |makeFR|)
              (|Record| (|:| |flag| 114) (|:| |factor| 18) (|:| |exponent| 48))
              (|List| 118) (327 . |factorList|) (332 . |leadingCoefficient|)
              (337 . |exquo|) (343 . *) (349 . ^) (355 . *) (|List| 18)
              (|List| 48) (|Union| 126 '"failed") (|Mapping| 128 18)
              (|Union| 129 '"failed") (|Mapping| 130 126)
              (|MultivariateLifting| 7 8 6 9) (361 . |lifting|) (372 . |exquo|)
              (378 . |recip|))
           '#(|solveLinearPolynomialEquationByRecursion| 383 |randomR| 389
              |factorSquareFreeByRecursion| 394 |factorByRecursion| 399
              |bivariateSLPEBR| 404)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|solveLinearPolynomialEquationByRecursion|
                                 ((|Union|
                                   (|List| (|SparseUnivariatePolynomial| |#4|))
                                   "failed")
                                  (|List| (|SparseUnivariatePolynomial| |#4|))
                                  (|SparseUnivariatePolynomial| |#4|)))
                                T)
                              '((|factorByRecursion|
                                 ((|Factored|
                                   (|SparseUnivariatePolynomial| |#4|))
                                  (|SparseUnivariatePolynomial| |#4|)))
                                T)
                              '((|factorSquareFreeByRecursion|
                                 ((|Factored|
                                   (|SparseUnivariatePolynomial| |#4|))
                                  (|SparseUnivariatePolynomial| |#4|)))
                                T)
                              '((|randomR| (|#1| (|Integer|))) T)
                              '((|bivariateSLPEBR|
                                 ((|Union|
                                   (|List| (|SparseUnivariatePolynomial| |#4|))
                                   #1#)
                                  (|List| (|SparseUnivariatePolynomial| |#4|))
                                  (|SparseUnivariatePolynomial| |#4|) |#3|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 135
                                            '(2 6 10 11 12 13 0 6 0 14 1 0 6 15
                                              16 1 6 0 15 17 1 9 18 0 19 2 23
                                              20 21 22 24 2 18 10 11 12 25 2 9
                                              0 12 8 26 2 9 0 18 8 27 2 29 22
                                              28 20 30 3 0 31 32 22 8 33 2 34
                                              31 32 22 35 1 22 9 0 36 3 9 0 0
                                              37 38 39 1 9 40 0 41 1 9 6 0 42 2
                                              44 18 43 22 45 1 18 0 0 46 2 18 0
                                              0 0 47 1 18 48 0 49 1 9 0 6 50 2
                                              52 22 51 18 53 2 37 0 0 0 54 2 37
                                              0 8 0 55 2 9 12 0 8 56 2 59 57 58
                                              22 60 1 61 57 57 62 0 57 0 63 1
                                              57 64 0 65 1 57 22 0 66 1 57 48 0
                                              67 2 57 0 22 48 68 2 57 0 0 0 69
                                              2 71 22 70 57 72 0 6 0 73 0 7 0
                                              74 0 22 0 75 2 22 40 0 0 76 1 22
                                              77 0 78 1 9 37 0 79 1 37 0 64 80
                                              1 37 0 0 81 1 6 83 12 84 2 88 85
                                              86 87 89 1 22 9 0 90 1 9 40 0 91
                                              1 22 92 0 93 2 96 85 85 95 97 2
                                              22 98 0 9 99 1 22 0 9 100 1 9 92
                                              0 101 2 103 85 58 102 104 2 85 0
                                              0 0 105 2 9 48 0 8 107 0 9 0 108
                                              1 22 48 0 109 1 18 0 0 110 1 6 83
                                              12 111 1 87 48 0 112 0 6 0 113 2
                                              85 0 22 116 117 1 87 119 0 120 1
                                              18 6 0 121 2 6 98 0 0 122 2 18 0
                                              6 0 123 2 9 0 0 48 124 2 22 0 9 0
                                              125 7 132 31 22 37 126 38 77 127
                                              131 133 2 9 98 0 0 134 1 9 98 0
                                              135 2 0 31 32 22 82 1 0 6 15 16 1
                                              0 85 22 94 1 0 85 22 106 3 0 31
                                              32 22 8 33)))))
           '|lookupComplete|)) 
