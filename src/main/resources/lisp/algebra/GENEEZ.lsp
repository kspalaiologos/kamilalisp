
(SDEFUN |GENEEZ;compBound;BPLNni;1|
        ((|m| (BP)) (|listpolys| (|List| BP)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G726 NIL) (|normprod| #2=(|NonNegativeInteger|))
          (#3=#:G721 NIL) (#4=#:G720 #2#) (#5=#:G722 #2#) (#6=#:G724 NIL)
          (#7=#:G736 NIL) (|g| NIL) (#8=#:G737 NIL) (|df| NIL)
          (|nm| #9=(|NonNegativeInteger|)) (#10=#:G718 NIL) (#11=#:G717 #9#)
          (#12=#:G719 #9#) (#13=#:G735 NIL) (|u| NIL) (|normlist| (|List| #9#))
          (#14=#:G713 NIL) (#15=#:G712 #9#) (#16=#:G714 #9#) (#17=#:G734 NIL)
          (#18=#:G733 NIL) (|f| NIL) (#19=#:G732 NIL)
          (|n| #20=(|NonNegativeInteger|)) (#21=#:G709 NIL) (#22=#:G708 #20#)
          (#23=#:G710 #20#) (#24=#:G731 NIL) (|ldeg| (|List| #20#))
          (#25=#:G730 NIL) (#26=#:G729 NIL))
         (SEQ
          (LETT |ldeg|
                (PROGN
                 (LETT #26# NIL)
                 (SEQ (LETT |f| NIL) (LETT #25# |listpolys|) G190
                      (COND
                       ((OR (ATOM #25#) (PROGN (LETT |f| (CAR #25#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #26# (CONS (SPADCALL |f| (QREFELT $ 9)) #26#))))
                      (LETT #25# (CDR #25#)) (GO G190) G191
                      (EXIT (NREVERSE #26#)))))
          (LETT |n|
                (PROGN
                 (LETT #21# NIL)
                 (SEQ (LETT |df| NIL) (LETT #24# |ldeg|) G190
                      (COND
                       ((OR (ATOM #24#) (PROGN (LETT |df| (CAR #24#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #23# |df|)
                         (COND (#21# (LETT #22# (+ #22# #23#)))
                               ('T (PROGN (LETT #22# #23#) (LETT #21# 'T)))))))
                      (LETT #24# (CDR #24#)) (GO G190) G191 (EXIT NIL))
                 (COND (#21# #22#) (#27='T 0))))
          (LETT |normlist|
                (PROGN
                 (LETT #19# NIL)
                 (SEQ (LETT |f| NIL) (LETT #18# |listpolys|) G190
                      (COND
                       ((OR (ATOM #18#) (PROGN (LETT |f| (CAR #18#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #19#
                              (CONS
                               (PROGN
                                (LETT #14# NIL)
                                (SEQ (LETT |u| NIL)
                                     (LETT #17# (SPADCALL |f| (QREFELT $ 11)))
                                     G190
                                     (COND
                                      ((OR (ATOM #17#)
                                           (PROGN (LETT |u| (CAR #17#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (PROGN
                                        (LETT #16#
                                              (EXPT
                                               (SPADCALL |u| (QREFELT $ 12))
                                               2))
                                        (COND (#14# (LETT #15# (+ #15# #16#)))
                                              ('T
                                               (PROGN
                                                (LETT #15# #16#)
                                                (LETT #14# 'T)))))))
                                     (LETT #17# (CDR #17#)) (GO G190) G191
                                     (EXIT NIL))
                                (COND (#14# #15#) ('T 0)))
                               #19#))))
                      (LETT #18# (CDR #18#)) (GO G190) G191
                      (EXIT (NREVERSE #19#)))))
          (LETT |nm|
                (PROGN
                 (LETT #10# NIL)
                 (SEQ (LETT |u| NIL) (LETT #13# (SPADCALL |m| (QREFELT $ 11)))
                      G190
                      (COND
                       ((OR (ATOM #13#) (PROGN (LETT |u| (CAR #13#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #12# (EXPT (SPADCALL |u| (QREFELT $ 12)) 2))
                         (COND (#10# (LETT #11# (+ #11# #12#)))
                               ('T (PROGN (LETT #11# #12#) (LETT #10# 'T)))))))
                      (LETT #13# (CDR #13#)) (GO G190) G191 (EXIT NIL))
                 (COND (#10# #11#) (#27# 0))))
          (LETT |normprod|
                (PROGN
                 (LETT #3# NIL)
                 (SEQ (LETT |df| NIL) (LETT #8# |ldeg|) (LETT |g| NIL)
                      (LETT #7# |normlist|) G190
                      (COND
                       ((OR (ATOM #7#) (PROGN (LETT |g| (CAR #7#)) NIL)
                            (ATOM #8#) (PROGN (LETT |df| (CAR #8#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (PROGN
                         (LETT #5#
                               (EXPT |g|
                                     (PROG1 (LETT #6# (- |n| |df|))
                                       (|check_subtype2| (>= #6# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #6#))))
                         (COND (#3# (LETT #4# (* #4# #5#)))
                               ('T (PROGN (LETT #4# #5#) (LETT #3# 'T)))))))
                      (LETT #7# (PROG1 (CDR #7#) (LETT #8# (CDR #8#))))
                      (GO G190) G191 (EXIT NIL))
                 (COND (#3# #4#) (#27# 1))))
          (EXIT
           (* 2
              (PROG1 (LETT #1# (SPADCALL (* |normprod| |nm|) (QREFELT $ 15)))
                (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                  '(|Integer|) #1#))))))) 

(SDEFUN |GENEEZ;compBound;BPLNni;2|
        ((|m| (BP)) (|listpolys| (|List| BP)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G742 NIL) (#2=#:G741 #3=(|NonNegativeInteger|)) (#4=#:G743 #3#)
          (#5=#:G745 NIL) (#6=#:G744 #3#) (#7=#:G746 #3#) (#8=#:G750 NIL)
          (|u| NIL) (#9=#:G749 NIL) (|p| NIL) (#10=#:G739 NIL) (#11=#:G738 #3#)
          (#12=#:G740 #3#) (#13=#:G748 NIL))
         (SEQ
          (+
           (PROGN
            (LETT #10# NIL)
            (SEQ (LETT |u| NIL) (LETT #13# (SPADCALL |m| (QREFELT $ 11))) G190
                 (COND
                  ((OR (ATOM #13#) (PROGN (LETT |u| (CAR #13#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (PROGN
                    (LETT #12# (SPADCALL |u| (QREFELT $ 12)))
                    (COND (#10# (LETT #11# (MAX #11# #12#)))
                          ('T (PROGN (LETT #11# #12#) (LETT #10# 'T)))))))
                 (LETT #13# (CDR #13#)) (GO G190) G191 (EXIT NIL))
            (COND (#10# #11#) (#14='T (|IdentityError| '|max|))))
           (PROGN
            (LETT #1# NIL)
            (SEQ (LETT |p| NIL) (LETT #9# |listpolys|) G190
                 (COND
                  ((OR (ATOM #9#) (PROGN (LETT |p| (CAR #9#)) NIL)) (GO G191)))
                 (SEQ
                  (EXIT
                   (PROGN
                    (LETT #4#
                          (PROGN
                           (LETT #5# NIL)
                           (SEQ (LETT |u| NIL)
                                (LETT #8# (SPADCALL |p| (QREFELT $ 11))) G190
                                (COND
                                 ((OR (ATOM #8#)
                                      (PROGN (LETT |u| (CAR #8#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (PROGN
                                   (LETT #7# (SPADCALL |u| (QREFELT $ 12)))
                                   (COND (#5# (LETT #6# (MAX #6# #7#)))
                                         ('T
                                          (PROGN
                                           (LETT #6# #7#)
                                           (LETT #5# 'T)))))))
                                (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
                           (COND (#5# #6#) ('T (|IdentityError| '|max|)))))
                    (COND (#1# (LETT #2# (+ #2# #4#)))
                          ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                 (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL))
            (COND (#1# #2#) (#14# 0))))))) 

(PUT '|GENEEZ;compBound;BPLNni;3| '|SPADreplace|
     '(XLAM (|m| |listpolys|)
       (|error|
        "attempt to use compBound without a well-understood valuation"))) 

(SDEFUN |GENEEZ;compBound;BPLNni;3|
        ((|m| (BP)) (|listpolys| (|List| BP)) ($ (|NonNegativeInteger|)))
        (|error|
         "attempt to use compBound without a well-understood valuation")) 

(SDEFUN |GENEEZ;reduction;BPRBP;4| ((|u| (BP)) (|p| (R)) ($ (BP)))
        (SPROG NIL
               (COND ((SPADCALL |p| (|spadConstant| $ 18) (QREFELT $ 21)) |u|)
                     ('T
                      (SPADCALL
                       (CONS #'|GENEEZ;reduction;BPRBP;4!0| (VECTOR $ |p|)) |u|
                       (QREFELT $ 24)))))) 

(SDEFUN |GENEEZ;reduction;BPRBP;4!0| ((|x| NIL) ($$ NIL))
        (PROG (|p| $)
          (LETT |p| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |p| (QREFELT $ 22)))))) 

(SDEFUN |GENEEZ;reduction;BPRBP;5| ((|u| (BP)) (|p| (R)) ($ (BP)))
        (SPROG NIL
               (COND ((SPADCALL |p| (|spadConstant| $ 18) (QREFELT $ 21)) |u|)
                     ('T
                      (SPADCALL
                       (CONS #'|GENEEZ;reduction;BPRBP;5!0| (VECTOR $ |p|)) |u|
                       (QREFELT $ 24)))))) 

(SDEFUN |GENEEZ;reduction;BPRBP;5!0| ((|x| NIL) ($$ NIL))
        (PROG (|p| $)
          (LETT |p| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |p| (QREFELT $ 26)))))) 

(SDEFUN |GENEEZ;merge| ((|p| (R)) (|q| (R)) ($ (|Union| R "failed")))
        (COND ((SPADCALL |p| |q| (QREFELT $ 21)) (CONS 0 |p|))
              ((SPADCALL |p| (|spadConstant| $ 18) (QREFELT $ 21))
               (CONS 0 |q|))
              ((SPADCALL |q| (|spadConstant| $ 18) (QREFELT $ 21))
               (CONS 0 |p|))
              ('T (CONS 1 "failed")))) 

(SDEFUN |GENEEZ;modInverse| ((|c| (R)) (|p| (R)) ($ (R)))
        (SPROG ((#1=#:G762 NIL))
               (QCAR
                (PROG2
                    (LETT #1#
                          (SPADCALL |c| |p| (|spadConstant| $ 27)
                                    (QREFELT $ 31)))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0)
                                  (|Record| (|:| |coef1| (QREFELT $ 6))
                                            (|:| |coef2| (QREFELT $ 6)))
                                  (|Union|
                                   (|Record| (|:| |coef1| (QREFELT $ 6))
                                             (|:| |coef2| (QREFELT $ 6)))
                                   "failed")
                                  #1#))))) 

(SDEFUN |GENEEZ;exactquo|
        ((|u| (BP)) (|v| (BP)) (|p| (R)) ($ (|Union| BP "failed")))
        (SPROG
         ((|r| (|Record| (|:| |quotient| BP) (|:| |remainder| BP)))
          (|invlcv| (R)))
         (SEQ
          (LETT |invlcv|
                (|GENEEZ;modInverse| (SPADCALL |v| (QREFELT $ 32)) |p| $))
          (LETT |r|
                (SPADCALL |u|
                          (SPADCALL (SPADCALL |invlcv| |v| (QREFELT $ 33)) |p|
                                    (QREFELT $ 25))
                          (QREFELT $ 35)))
          (EXIT
           (COND
            ((SPADCALL (SPADCALL (QCDR |r|) |p| (QREFELT $ 25))
                       (|spadConstant| $ 19) (QREFELT $ 36))
             (CONS 1 "failed"))
            ('T
             (CONS 0
                   (SPADCALL (SPADCALL |invlcv| (QCAR |r|) (QREFELT $ 33)) |p|
                             (QREFELT $ 25))))))))) 

(SDEFUN |GENEEZ;reduceList| ((|lp| (|List| BP)) (|lmod| (R)) ($ (|List| FP)))
        (SPROG ((#1=#:G789 NIL) (|ff| NIL) (#2=#:G788 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |ff| NIL) (LETT #1# |lp|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |ff| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL |ff| |lmod| (QREFELT $ 38))
                                    #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |GENEEZ;coerceLFP| ((|lf| (|List| FP)) ($ (|List| BP)))
        (SPROG ((#1=#:G794 NIL) (|fm| NIL) (#2=#:G793 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |fm| NIL) (LETT #1# |lf|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |fm| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |fm| (QREFELT $ 39)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |GENEEZ;liftSol|
        ((|oldsol| (|List| BP)) (|err| (BP)) (|lmod| (R)) (|lmodk| (R))
         (|lpolys| (|List| BP)) (|ftab| (|Vector| (|List| FP))) (|m| (BP))
         (|bound| (|NonNegativeInteger|)) ($ (|Union| (|List| BP) "failed")))
        (SPROG
         ((#1=#:G766 NIL) (#2=#:G819 NIL) (|fs| (BP)) (#3=#:G812 NIL)
          (#4=#:G811 (BP)) (#5=#:G813 (BP)) (#6=#:G831 NIL) (|f| NIL)
          (#7=#:G832 NIL) (|g| NIL) (|nsol| (|List| BP)) (#8=#:G830 NIL)
          (|slp| NIL) (#9=#:G829 NIL) (#10=#:G827 NIL) (#11=#:G828 NIL)
          (#12=#:G826 NIL) (|sln| (|List| FP)) (#13=#:G824 NIL) (|pp| NIL)
          (#14=#:G825 NIL) (#15=#:G823 NIL) (|cc| (R)) (#16=#:G822 NIL)
          (|i| NIL) (#17=#:G821 NIL) (|xx| NIL) (#18=#:G820 NIL)
          (|d| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ G190 NIL
                (SEQ
                 (EXIT
                  (COND
                   ((> (SPADCALL |lmodk| (QREFELT $ 12)) |bound|)
                    (PROGN (LETT #2# (CONS 1 "failed")) (GO #19=#:G818)))
                   ('T
                    (SEQ (LETT |d| (SPADCALL |err| (QREFELT $ 9)))
                         (LETT |sln|
                               (PROGN
                                (LETT #18# NIL)
                                (SEQ (LETT |xx| NIL)
                                     (LETT #17#
                                           (SPADCALL |ftab| 1 (QREFELT $ 42)))
                                     G190
                                     (COND
                                      ((OR (ATOM #17#)
                                           (PROGN (LETT |xx| (CAR #17#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (LETT #18#
                                             (CONS (|spadConstant| $ 43)
                                                   #18#))))
                                     (LETT #17# (CDR #17#)) (GO G190) G191
                                     (EXIT (NREVERSE #18#)))))
                         (SEQ (LETT |i| 0) (LETT #16# |d|) G190
                              (COND ((|greater_SI| |i| #16#) (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL
                                   (LETT |cc|
                                         (SPADCALL |err| |i| (QREFELT $ 44)))
                                   (|spadConstant| $ 18) (QREFELT $ 45))
                                  (LETT |sln|
                                        (PROGN
                                         (LETT #15# NIL)
                                         (SEQ (LETT |slp| NIL)
                                              (LETT #14# |sln|) (LETT |pp| NIL)
                                              (LETT #13#
                                                    (SPADCALL |ftab| (+ |i| 1)
                                                              (QREFELT $ 42)))
                                              G190
                                              (COND
                                               ((OR (ATOM #13#)
                                                    (PROGN
                                                     (LETT |pp| (CAR #13#))
                                                     NIL)
                                                    (ATOM #14#)
                                                    (PROGN
                                                     (LETT |slp| (CAR #14#))
                                                     NIL))
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (LETT #15#
                                                      (CONS
                                                       (SPADCALL |slp|
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    |cc|
                                                                    (QREFELT $
                                                                             46))
                                                                   |lmod|
                                                                   (QREFELT $
                                                                            38))
                                                                  |pp|
                                                                  (QREFELT $
                                                                           47))
                                                                 (QREFELT $
                                                                          48))
                                                       #15#))))
                                              (LETT #13#
                                                    (PROG1 (CDR #13#)
                                                      (LETT #14# (CDR #14#))))
                                              (GO G190) G191
                                              (EXIT (NREVERSE #15#)))))))))
                              (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                              (EXIT NIL))
                         (LETT |nsol|
                               (PROGN
                                (LETT #12# NIL)
                                (SEQ (LETT |g| NIL) (LETT #11# |sln|)
                                     (LETT |f| NIL) (LETT #10# |oldsol|) G190
                                     (COND
                                      ((OR (ATOM #10#)
                                           (PROGN (LETT |f| (CAR #10#)) NIL)
                                           (ATOM #11#)
                                           (PROGN (LETT |g| (CAR #11#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (LETT #12#
                                             (CONS
                                              (SPADCALL |f|
                                                        (SPADCALL |lmodk|
                                                                  (SPADCALL
                                                                   (SPADCALL
                                                                    |g|
                                                                    (QREFELT $
                                                                             39))
                                                                   |lmod|
                                                                   (QREFELT $
                                                                            25))
                                                                  (QREFELT $
                                                                           33))
                                                        (QREFELT $ 49))
                                              #12#))))
                                     (LETT #10#
                                           (PROG1 (CDR #10#)
                                             (LETT #11# (CDR #11#))))
                                     (GO G190) G191 (EXIT (NREVERSE #12#)))))
                         (LETT |lmodk|
                               (SPADCALL |lmod| |lmodk| (QREFELT $ 50)))
                         (LETT |nsol|
                               (PROGN
                                (LETT #9# NIL)
                                (SEQ (LETT |slp| NIL) (LETT #8# |nsol|) G190
                                     (COND
                                      ((OR (ATOM #8#)
                                           (PROGN (LETT |slp| (CAR #8#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (LETT #9#
                                             (CONS
                                              (SPADCALL |slp| |lmodk|
                                                        (QREFELT $ 25))
                                              #9#))))
                                     (LETT #8# (CDR #8#)) (GO G190) G191
                                     (EXIT (NREVERSE #9#)))))
                         (LETT |fs|
                               (PROGN
                                (LETT #3# NIL)
                                (SEQ (LETT |g| NIL) (LETT #7# |nsol|)
                                     (LETT |f| NIL) (LETT #6# |lpolys|) G190
                                     (COND
                                      ((OR (ATOM #6#)
                                           (PROGN (LETT |f| (CAR #6#)) NIL)
                                           (ATOM #7#)
                                           (PROGN (LETT |g| (CAR #7#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (PROGN
                                        (LETT #5#
                                              (SPADCALL |f| |g|
                                                        (QREFELT $ 51)))
                                        (COND
                                         (#3#
                                          (LETT #4#
                                                (SPADCALL #4# #5#
                                                          (QREFELT $ 52))))
                                         ('T
                                          (PROGN
                                           (LETT #4# #5#)
                                           (LETT #3# 'T)))))))
                                     (LETT #6#
                                           (PROG1 (CDR #6#)
                                             (LETT #7# (CDR #7#))))
                                     (GO G190) G191 (EXIT NIL))
                                (COND (#3# #4#) ('T (|spadConstant| $ 19)))))
                         (EXIT
                          (COND
                           ((SPADCALL |fs| |m| (QREFELT $ 53))
                            (PROGN (LETT #2# (CONS 0 |nsol|)) (GO #19#)))
                           ('T
                            (SEQ
                             (LETT |err|
                                   (PROG2
                                       (LETT #1#
                                             (SPADCALL
                                              (SPADCALL |fs| |m|
                                                        (QREFELT $ 49))
                                              |lmodk| (QREFELT $ 55)))
                                       (QCDR #1#)
                                     (|check_union2| (QEQCAR #1# 0)
                                                     (QREFELT $ 7)
                                                     (|Union| (QREFELT $ 7)
                                                              "failed")
                                                     #1#)))
                             (EXIT (LETT |oldsol| |nsol|)))))))))))
                NIL (GO G190) G191 (EXIT NIL)))
          #19# (EXIT #2#)))) 

(SDEFUN |GENEEZ;makeProducts| ((|listPol| (|List| BP)) ($ (|List| BP)))
        (SPROG
         ((#1=#:G844 NIL) (|g| NIL) (#2=#:G843 NIL) (#3=#:G834 NIL)
          (#4=#:G833 (BP)) (#5=#:G835 (BP)) (#6=#:G842 NIL) (#7=#:G689 NIL)
          (|ll| (|List| BP)) (|f| (BP)))
         (SEQ
          (COND ((< (LENGTH |listPol|) 2) |listPol|)
                ((EQL (LENGTH |listPol|) 2) (REVERSE |listPol|))
                (#8='T
                 (SEQ (LETT |f| (|SPADfirst| |listPol|))
                      (LETT |ll| (CDR |listPol|))
                      (EXIT
                       (CONS
                        (PROGN
                         (LETT #3# NIL)
                         (SEQ (LETT #7# NIL) (LETT #6# |ll|) G190
                              (COND
                               ((OR (ATOM #6#)
                                    (PROGN (LETT #7# (CAR #6#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (PROGN
                                 (LETT #5# #7#)
                                 (COND
                                  (#3#
                                   (LETT #4#
                                         (SPADCALL #4# #5# (QREFELT $ 51))))
                                  ('T (PROGN (LETT #4# #5#) (LETT #3# 'T)))))))
                              (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
                         (COND (#3# #4#) (#8# (|spadConstant| $ 28))))
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |g| NIL)
                              (LETT #1# (|GENEEZ;makeProducts| |ll| $)) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |g| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2#
                                      (CONS (SPADCALL |f| |g| (QREFELT $ 51))
                                            #2#))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#)))))))))))) 

(SDEFUN |GENEEZ;testModulus;RLB;13|
        ((|pmod| (R)) (|listPol| (|List| BP)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G857 NIL) (#2=#:G859 NIL) (#3=#:G862 NIL) (|rpol2| NIL)
          (|redListPol| (|List| FP)) (|rpol| (FP)) (#4=#:G858 NIL)
          (#5=#:G860 NIL) (|pol| NIL) (#6=#:G861 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |redListPol| (|GENEEZ;reduceList| |listPol| |pmod| $))
                (SEQ
                 (EXIT
                  (SEQ (LETT #6# |redListPol|) (LETT |pol| NIL)
                       (LETT #5# |listPol|) G190
                       (COND
                        ((OR (ATOM #5#) (PROGN (LETT |pol| (CAR #5#)) NIL)
                             (ATOM #6#) (PROGN (LETT |rpol| (CAR #6#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL (SPADCALL |pol| (QREFELT $ 9))
                                     (SPADCALL (SPADCALL |rpol| (QREFELT $ 39))
                                               (QREFELT $ 9))
                                     (QREFELT $ 56))
                           (PROGN
                            (LETT #4# (PROGN (LETT #2# NIL) (GO #7=#:G856)))
                            (GO #8=#:G847))))))
                       (LETT #5# (PROG1 (CDR #5#) (LETT #6# (CDR #6#))))
                       (GO G190) G191 (EXIT NIL)))
                 #8# (EXIT #4#))
                (SEQ G190 (COND ((NULL (NULL (NULL |redListPol|))) (GO G191)))
                     (SEQ (LETT |rpol| (|SPADfirst| |redListPol|))
                          (LETT |redListPol| (CDR |redListPol|))
                          (EXIT
                           (SEQ
                            (EXIT
                             (SEQ (LETT |rpol2| NIL) (LETT #3# |redListPol|)
                                  G190
                                  (COND
                                   ((OR (ATOM #3#)
                                        (PROGN (LETT |rpol2| (CAR #3#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((SPADCALL
                                       (SPADCALL |rpol| |rpol2| (QREFELT $ 57))
                                       (|spadConstant| $ 58) (QREFELT $ 59))
                                      (PROGN
                                       (LETT #1#
                                             (PROGN (LETT #2# NIL) (GO #7#)))
                                       (GO #9=#:G852))))))
                                  (LETT #3# (CDR #3#)) (GO G190) G191
                                  (EXIT NIL)))
                            #9# (EXIT #1#))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT 'T)))
          #7# (EXIT #2#)))) 

(SDEFUN |GENEEZ;tablePow;NniRLU;14|
        ((|mdeg| (|NonNegativeInteger|)) (|pmod| (R)) (|listPol| (|List| BP))
         ($ (|Union| (|Vector| (|List| BP)) "failed")))
        (SPROG
         ((#1=#:G878 NIL) (|tpol| NIL) (#2=#:G879 NIL) (|fpol| NIL)
          (#3=#:G877 NIL) (#4=#:G876 NIL) (|i| NIL) (|x| (BP))
          (|ptable| (|Vector| (|List| BP)))
          (|multiE| (|Union| (|List| BP) "failed")))
         (SEQ
          (LETT |multiE|
                (SPADCALL |listPol| (|spadConstant| $ 28) (QREFELT $ 63)))
          (EXIT
           (COND ((QEQCAR |multiE| 1) (CONS 1 "failed"))
                 ('T
                  (SEQ (LETT |ptable| (MAKEARR1 (+ |mdeg| 1) NIL))
                       (SPADCALL |ptable| 1 (QCDR |multiE|) (QREFELT $ 65))
                       (LETT |x|
                             (SPADCALL (|spadConstant| $ 27) 1 (QREFELT $ 66)))
                       (SEQ (LETT |i| 2) (LETT #4# |mdeg|) G190
                            (COND ((|greater_SI| |i| #4#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SPADCALL |ptable| |i|
                                        (PROGN
                                         (LETT #3# NIL)
                                         (SEQ (LETT |fpol| NIL)
                                              (LETT #2# |listPol|)
                                              (LETT |tpol| NIL)
                                              (LETT #1#
                                                    (SPADCALL |ptable|
                                                              (- |i| 1)
                                                              (QREFELT $ 67)))
                                              G190
                                              (COND
                                               ((OR (ATOM #1#)
                                                    (PROGN
                                                     (LETT |tpol| (CAR #1#))
                                                     NIL)
                                                    (ATOM #2#)
                                                    (PROGN
                                                     (LETT |fpol| (CAR #2#))
                                                     NIL))
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (LETT #3#
                                                      (CONS
                                                       (SPADCALL
                                                        (SPADCALL |tpol| |x|
                                                                  (QREFELT $
                                                                           51))
                                                        |fpol| (QREFELT $ 68))
                                                       #3#))))
                                              (LETT #1#
                                                    (PROG1 (CDR #1#)
                                                      (LETT #2# (CDR #2#))))
                                              (GO G190) G191
                                              (EXIT (NREVERSE #3#))))
                                        (QREFELT $ 65))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL))
                       (SPADCALL |ptable| (+ |mdeg| 1)
                                 (|GENEEZ;makeProducts| |listPol| $)
                                 (QREFELT $ 65))
                       (EXIT (CONS 0 |ptable|))))))))) 

(SDEFUN |GENEEZ;solveid;BPRVU;15|
        ((|m| (BP)) (|pmod| (R)) (|table| (|Vector| (|List| BP)))
         ($ (|Union| (|List| BP) "failed")))
        (SPROG
         ((|sln| (|List| BP)) (#1=#:G895 NIL) (|pp| NIL) (#2=#:G896 NIL)
          (|slp| NIL) (#3=#:G894 NIL) (#4=#:G893 NIL) (|i| NIL) (#5=#:G892 NIL)
          (|xx| NIL) (#6=#:G891 NIL) (|d| (|NonNegativeInteger|)))
         (SEQ (LETT |d| (SPADCALL |m| (QREFELT $ 9)))
              (LETT |sln|
                    (PROGN
                     (LETT #6# NIL)
                     (SEQ (LETT |xx| NIL)
                          (LETT #5# (SPADCALL |table| 1 (QREFELT $ 67))) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |xx| (CAR #5#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT (LETT #6# (CONS (|spadConstant| $ 19) #6#))))
                          (LETT #5# (CDR #5#)) (GO G190) G191
                          (EXIT (NREVERSE #6#)))))
              (SEQ (LETT |i| 0) (LETT #4# |d|) G190
                   (COND ((|greater_SI| |i| #4#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |m| |i| (QREFELT $ 44))
                                 (|spadConstant| $ 18) (QREFELT $ 45))
                       (LETT |sln|
                             (PROGN
                              (LETT #3# NIL)
                              (SEQ (LETT |slp| NIL) (LETT #2# |sln|)
                                   (LETT |pp| NIL)
                                   (LETT #1#
                                         (SPADCALL |table| (+ |i| 1)
                                                   (QREFELT $ 67)))
                                   G190
                                   (COND
                                    ((OR (ATOM #1#)
                                         (PROGN (LETT |pp| (CAR #1#)) NIL)
                                         (ATOM #2#)
                                         (PROGN (LETT |slp| (CAR #2#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #3#
                                           (CONS
                                            (SPADCALL |slp|
                                                      (SPADCALL
                                                       (SPADCALL |m| |i|
                                                                 (QREFELT $
                                                                          44))
                                                       |pp| (QREFELT $ 33))
                                                      (QREFELT $ 52))
                                            #3#))))
                                   (LETT #1#
                                         (PROG1 (CDR #1#)
                                           (LETT #2# (CDR #2#))))
                                   (GO G190) G191 (EXIT (NREVERSE #3#)))))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS 0 |sln|))))) 

(SDEFUN |GENEEZ;tablePow;NniRLU;16|
        ((|mdeg| (|NonNegativeInteger|)) (|pmod| (R)) (|listPol| (|List| BP))
         ($ (|Union| (|Vector| (|List| BP)) "failed")))
        (SPROG
         ((|ptable| (|Vector| (|List| BP))) (#1=#:G923 NIL) (|tpol| NIL)
          (#2=#:G924 NIL) (|fpol| NIL) (#3=#:G922 NIL) (#4=#:G921 NIL)
          (|i| NIL) (|x| (FP)) (|fl| (|List| FP))
          (|ftable| (|Vector| (|List| FP)))
          (|multiE| (|Union| (|List| FP) "failed")) (#5=#:G916 NIL)
          (#6=#:G919 NIL) (|rpol| NIL) (#7=#:G920 NIL) (|pol| NIL)
          (|listP| (|List| FP)) (#8=#:G918 NIL) (#9=#:G917 NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |listP|
                  (PROGN
                   (LETT #9# NIL)
                   (SEQ (LETT |pol| NIL) (LETT #8# |listPol|) G190
                        (COND
                         ((OR (ATOM #8#) (PROGN (LETT |pol| (CAR #8#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #9#
                                (CONS (SPADCALL |pol| |pmod| (QREFELT $ 38))
                                      #9#))))
                        (LETT #8# (CDR #8#)) (GO G190) G191
                        (EXIT (NREVERSE #9#)))))
            (SEQ (LETT |pol| NIL) (LETT #7# |listPol|) (LETT |rpol| NIL)
                 (LETT #6# |listP|) G190
                 (COND
                  ((OR (ATOM #6#) (PROGN (LETT |rpol| (CAR #6#)) NIL)
                       (ATOM #7#) (PROGN (LETT |pol| (CAR #7#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (COND
                    ((<
                      (SPADCALL (SPADCALL |rpol| (QREFELT $ 39)) (QREFELT $ 9))
                      (SPADCALL |pol| (QREFELT $ 9)))
                     (PROGN (LETT #5# (CONS 1 "failed")) (GO #10=#:G915))))))
                 (LETT #6# (PROG1 (CDR #6#) (LETT #7# (CDR #7#)))) (GO G190)
                 G191 (EXIT NIL))
            (LETT |multiE|
                  (SPADCALL |listP| (|spadConstant| $ 58) (QREFELT $ 73)))
            (EXIT
             (COND ((QEQCAR |multiE| 1) (CONS 1 "failed"))
                   ('T
                    (SEQ (LETT |ftable| (MAKEARR1 (+ |mdeg| 1) NIL))
                         (LETT |fl| (QCDR |multiE|))
                         (SPADCALL |ftable| 1 |fl| (QREFELT $ 74))
                         (LETT |x|
                               (SPADCALL
                                (SPADCALL (|spadConstant| $ 27) 1
                                          (QREFELT $ 66))
                                |pmod| (QREFELT $ 38)))
                         (SEQ (LETT |i| 2) (LETT #4# |mdeg|) G190
                              (COND ((|greater_SI| |i| #4#) (GO G191)))
                              (SEQ
                               (EXIT
                                (SPADCALL |ftable| |i|
                                          (PROGN
                                           (LETT #3# NIL)
                                           (SEQ (LETT |fpol| NIL)
                                                (LETT #2# |listP|)
                                                (LETT |tpol| NIL)
                                                (LETT #1#
                                                      (SPADCALL |ftable|
                                                                (- |i| 1)
                                                                (QREFELT $
                                                                         42)))
                                                G190
                                                (COND
                                                 ((OR (ATOM #1#)
                                                      (PROGN
                                                       (LETT |tpol| (CAR #1#))
                                                       NIL)
                                                      (ATOM #2#)
                                                      (PROGN
                                                       (LETT |fpol| (CAR #2#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT #3#
                                                        (CONS
                                                         (SPADCALL
                                                          (SPADCALL |tpol| |x|
                                                                    (QREFELT $
                                                                             47))
                                                          |fpol|
                                                          (QREFELT $ 75))
                                                         #3#))))
                                                (LETT #1#
                                                      (PROG1 (CDR #1#)
                                                        (LETT #2# (CDR #2#))))
                                                (GO G190) G191
                                                (EXIT (NREVERSE #3#))))
                                          (QREFELT $ 74))))
                              (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                              (EXIT NIL))
                         (LETT |ptable|
                               (SPADCALL
                                (CONS (|function| |GENEEZ;coerceLFP|) $)
                                |ftable| (QREFELT $ 78)))
                         (SPADCALL |ptable| (+ |mdeg| 1)
                                   (|GENEEZ;makeProducts| |listPol| $)
                                   (QREFELT $ 65))
                         (EXIT (CONS 0 |ptable|))))))))
          #10# (EXIT #5#)))) 

(SDEFUN |GENEEZ;solveid;BPRVU;17|
        ((|m| (BP)) (|pmod| (R)) (|table| (|Vector| (|List| BP)))
         ($ (|Union| (|List| BP) "failed")))
        (SPROG
         ((|a| (BP)) (#1=#:G766 NIL) (|bound| (|NonNegativeInteger|))
          (|fs| (BP)) (#2=#:G935 NIL) (#3=#:G934 (BP)) (#4=#:G936 (BP))
          (#5=#:G948 NIL) (|f| NIL) (#6=#:G949 NIL) (|g| NIL)
          (|soln| (|List| BP)) (#7=#:G947 NIL) (|slp| NIL) (#8=#:G946 NIL)
          (|sln| (|List| FP)) (#9=#:G944 NIL) (|pp| NIL) (#10=#:G945 NIL)
          (#11=#:G943 NIL) (#12=#:G942 NIL) (|i| NIL) (#13=#:G941 NIL)
          (|xx| NIL) (#14=#:G940 NIL) (|lpolys| (|List| BP))
          (|ftab| (|Vector| (|List| FP))) (|d| (|NonNegativeInteger|)))
         (SEQ (LETT |d| (SPADCALL |m| (QREFELT $ 9)))
              (LETT |ftab|
                    (SPADCALL
                     (CONS #'|GENEEZ;solveid;BPRVU;17!0| (VECTOR $ |pmod|))
                     |table| (QREFELT $ 81)))
              (LETT |lpolys|
                    (SPADCALL |table| (QVSIZE |table|) (QREFELT $ 67)))
              (LETT |sln|
                    (PROGN
                     (LETT #14# NIL)
                     (SEQ (LETT |xx| NIL)
                          (LETT #13# (SPADCALL |ftab| 1 (QREFELT $ 42))) G190
                          (COND
                           ((OR (ATOM #13#) (PROGN (LETT |xx| (CAR #13#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #14# (CONS (|spadConstant| $ 43) #14#))))
                          (LETT #13# (CDR #13#)) (GO G190) G191
                          (EXIT (NREVERSE #14#)))))
              (SEQ (LETT |i| 0) (LETT #12# |d|) G190
                   (COND ((|greater_SI| |i| #12#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |m| |i| (QREFELT $ 44))
                                 (|spadConstant| $ 18) (QREFELT $ 45))
                       (LETT |sln|
                             (PROGN
                              (LETT #11# NIL)
                              (SEQ (LETT |slp| NIL) (LETT #10# |sln|)
                                   (LETT |pp| NIL)
                                   (LETT #9#
                                         (SPADCALL |ftab| (+ |i| 1)
                                                   (QREFELT $ 42)))
                                   G190
                                   (COND
                                    ((OR (ATOM #9#)
                                         (PROGN (LETT |pp| (CAR #9#)) NIL)
                                         (ATOM #10#)
                                         (PROGN (LETT |slp| (CAR #10#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #11#
                                           (CONS
                                            (SPADCALL |slp|
                                                      (SPADCALL
                                                       (SPADCALL
                                                        (SPADCALL
                                                         (SPADCALL |m| |i|
                                                                   (QREFELT $
                                                                            44))
                                                         (QREFELT $ 46))
                                                        |pmod| (QREFELT $ 38))
                                                       |pp| (QREFELT $ 47))
                                                      (QREFELT $ 48))
                                            #11#))))
                                   (LETT #9#
                                         (PROG1 (CDR #9#)
                                           (LETT #10# (CDR #10#))))
                                   (GO G190) G191 (EXIT (NREVERSE #11#)))))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |soln|
                    (PROGN
                     (LETT #8# NIL)
                     (SEQ (LETT |slp| NIL) (LETT #7# |sln|) G190
                          (COND
                           ((OR (ATOM #7#) (PROGN (LETT |slp| (CAR #7#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #8#
                                  (CONS (SPADCALL |slp| (QREFELT $ 39)) #8#))))
                          (LETT #7# (CDR #7#)) (GO G190) G191
                          (EXIT (NREVERSE #8#)))))
              (LETT |fs|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |g| NIL) (LETT #6# |soln|) (LETT |f| NIL)
                          (LETT #5# |lpolys|) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |f| (CAR #5#)) NIL)
                                (ATOM #6#) (PROGN (LETT |g| (CAR #6#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (PROGN
                             (LETT #4# (SPADCALL |f| |g| (QREFELT $ 51)))
                             (COND
                              (#2#
                               (LETT #3# (SPADCALL #3# #4# (QREFELT $ 52))))
                              ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                          (LETT #5# (PROG1 (CDR #5#) (LETT #6# (CDR #6#))))
                          (GO G190) G191 (EXIT NIL))
                     (COND (#2# #3#) (#15='T (|spadConstant| $ 19)))))
              (EXIT
               (COND ((SPADCALL |fs| |m| (QREFELT $ 53)) (CONS 0 |soln|))
                     (#15#
                      (SEQ
                       (LETT |bound| (SPADCALL |m| |lpolys| (QREFELT $ 17)))
                       (LETT |a|
                             (PROG2
                                 (LETT #1#
                                       (SPADCALL
                                        (SPADCALL |fs| |m| (QREFELT $ 49))
                                        |pmod| (QREFELT $ 55)))
                                 (QCDR #1#)
                               (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                               (|Union| (QREFELT $ 7) "failed")
                                               #1#)))
                       (EXIT
                        (|GENEEZ;liftSol| |soln| |a| |pmod| |pmod| |lpolys|
                         |ftab| |m| |bound| $))))))))) 

(SDEFUN |GENEEZ;solveid;BPRVU;17!0| ((|x| NIL) ($$ NIL))
        (PROG (|pmod| $)
          (LETT |pmod| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GENEEZ;reduceList| |x| |pmod| $))))) 

(DECLAIM (NOTINLINE |GenExEuclid;|)) 

(DEFUN |GenExEuclid| (&REST #1=#:G950)
  (SPROG NIL
         (PROG (#2=#:G951)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|GenExEuclid|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |GenExEuclid;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|GenExEuclid|)))))))))) 

(DEFUN |GenExEuclid;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|GenExEuclid| DV$1 DV$2))
          (LETT $ (GETREFV 82))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|GenExEuclid| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#1| '(|multiplicativeValuation|))
            (QSETREFV $ 17
                      (CONS (|dispatchFunction| |GENEEZ;compBound;BPLNni;1|)
                            $)))
           ((|HasCategory| |#1| '(|additiveValuation|))
            (QSETREFV $ 17
                      (CONS (|dispatchFunction| |GENEEZ;compBound;BPLNni;2|)
                            $)))
           ('T
            (QSETREFV $ 17
                      (CONS (|dispatchFunction| |GENEEZ;compBound;BPLNni;3|)
                            $))))
          (COND
           ((|HasCategory| |#1| '(|IntegerNumberSystem|))
            (QSETREFV $ 25
                      (CONS (|dispatchFunction| |GENEEZ;reduction;BPRBP;4|)
                            $)))
           ('T
            (QSETREFV $ 25
                      (CONS (|dispatchFunction| |GENEEZ;reduction;BPRBP;5|)
                            $))))
          (QSETREFV $ 37
                    (|EuclideanModularRing| |#1| |#2| |#1| (ELT $ 25)
                                            (CONS (|function| |GENEEZ;merge|)
                                                  $)
                                            (CONS
                                             (|function| |GENEEZ;exactquo|)
                                             $)))
          (COND
           ((|HasCategory| |#1| '(|Field|))
            (PROGN
             (QSETREFV $ 70
                       (CONS (|dispatchFunction| |GENEEZ;tablePow;NniRLU;14|)
                             $))
             (QSETREFV $ 72
                       (CONS (|dispatchFunction| |GENEEZ;solveid;BPRVU;15|)
                             $))))
           ('T
            (PROGN
             (QSETREFV $ 70
                       (CONS (|dispatchFunction| |GENEEZ;tablePow;NniRLU;16|)
                             $))
             (QSETREFV $ 72
                       (CONS (|dispatchFunction| |GENEEZ;solveid;BPRVU;17|)
                             $)))))
          $))) 

(MAKEPROP '|GenExEuclid| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|NonNegativeInteger|) (0 . |degree|) (|List| 6)
              (5 . |coefficients|) (10 . |euclideanSize|) (|Integer|)
              (|IntegerRoots| 13) (15 . |approxSqrt|) (|List| 7)
              (20 . |compBound|) (26 . |Zero|) (30 . |Zero|) (|Boolean|)
              (34 . =) (40 . |symmetricRemainder|) (|Mapping| 6 6) (46 . |map|)
              (52 . |reduction|) (58 . |rem|) (64 . |One|) (68 . |One|)
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 29 '#1="failed") (72 . |extendedEuclidean|)
              (79 . |leadingCoefficient|) (84 . *)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (90 . |monicDivide|) (96 . ~=) 'FP (102 . |reduce|)
              (108 . |coerce|) (|List| 37) (|Vector| 40) (113 . |elt|)
              (119 . |Zero|) (123 . |coefficient|) (129 . ~=) (135 . |coerce|)
              (140 . *) (146 . +) (152 . -) (158 . *) (164 . *) (170 . +)
              (176 . =) (|Union| $ '"failed") (182 . |exquo|) (188 . ~=)
              (194 . |gcd|) (200 . |One|) (204 . ~=)
              |GENEEZ;testModulus;RLB;13| (|Union| 62 '#1#) (|List| $)
              (210 . |multiEuclidean|) (|Vector| 16) (216 . |setelt!|)
              (223 . |monomial|) (229 . |elt|) (235 . |rem|)
              (|Union| 64 '#2="failed") (241 . |tablePow|)
              (|Union| 16 '"failed") (248 . |solveid|) (255 . |multiEuclidean|)
              (261 . |setelt!|) (268 . |rem|) (|Mapping| 16 40)
              (|VectorFunctions2| 40 16) (274 . |map|) (|Mapping| 40 16)
              (|VectorFunctions2| 16 40) (280 . |map|))
           '#(|testModulus| 286 |tablePow| 292 |solveid| 299 |reduction| 306
              |compBound| 312)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|reduction| (|#2| |#2| |#1|)) T)
                                   '((|compBound|
                                      ((|NonNegativeInteger|) |#2|
                                       (|List| |#2|)))
                                     T)
                                   '((|tablePow|
                                      ((|Union| (|Vector| (|List| |#2|)) #2#)
                                       (|NonNegativeInteger|) |#1|
                                       (|List| |#2|)))
                                     T)
                                   '((|solveid|
                                      ((|Union| (|List| |#2|) "failed") |#2|
                                       |#1| (|Vector| (|List| |#2|))))
                                     T)
                                   '((|testModulus|
                                      ((|Boolean|) |#1| (|List| |#2|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 81
                                            '(1 7 8 0 9 1 7 10 0 11 1 6 8 0 12
                                              1 14 13 13 15 2 0 8 7 16 17 0 6 0
                                              18 0 7 0 19 2 6 20 0 0 21 2 6 0 0
                                              0 22 2 7 0 23 0 24 2 0 7 7 6 25 2
                                              6 0 0 0 26 0 6 0 27 0 7 0 28 3 6
                                              30 0 0 0 31 1 7 6 0 32 2 7 0 6 0
                                              33 2 7 34 0 0 35 2 7 20 0 0 36 2
                                              37 0 7 6 38 1 37 7 0 39 2 41 40 0
                                              13 42 0 37 0 43 2 7 6 0 8 44 2 6
                                              20 0 0 45 1 7 0 6 46 2 37 0 0 0
                                              47 2 37 0 0 0 48 2 7 0 0 0 49 2 6
                                              0 0 0 50 2 7 0 0 0 51 2 7 0 0 0
                                              52 2 7 20 0 0 53 2 7 54 0 6 55 2
                                              8 20 0 0 56 2 37 0 0 0 57 0 37 0
                                              58 2 37 20 0 0 59 2 7 61 62 0 63
                                              3 64 16 0 13 16 65 2 7 0 6 8 66 2
                                              64 16 0 13 67 2 7 0 0 0 68 3 0 69
                                              8 6 16 70 3 0 71 7 6 64 72 2 37
                                              61 62 0 73 3 41 40 0 13 40 74 2
                                              37 0 0 0 75 2 77 64 76 41 78 2 80
                                              41 79 64 81 2 0 20 6 16 60 3 0 69
                                              8 6 16 70 3 0 71 7 6 64 72 2 0 7
                                              7 6 25 2 0 8 7 16 17)))))
           '|lookupComplete|)) 
