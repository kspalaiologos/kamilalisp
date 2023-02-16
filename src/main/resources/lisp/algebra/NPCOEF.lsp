
(SDEFUN |NPCOEF;npcoef;SupLLR;1|
        ((|u| (|SparseUnivariatePolynomial| P)) (|factlist| (|List| BP))
         (|leadlist| (|List| P))
         ($
          (|Record| (|:| |deter| (|List| (|SparseUnivariatePolynomial| P)))
                    (|:| |dterm|
                         (|List|
                          (|List|
                           (|Record| (|:| |expt| (|NonNegativeInteger|))
                                     (|:| |pcoef| P)))))
                    (|:| |nfacts| (|List| BP)) (|:| |nlead| (|List| P)))))
        (SPROG
         ((|detcoef|
           (|List|
            (|List|
             (|Record| (|:| |expt| (|NonNegativeInteger|)) (|:| |pcoef| P)))))
          (#1=#:G783 NIL) (|i| NIL)
          (|ltodel| #2=(|List| (|NonNegativeInteger|)))
          (|detufact| (|List| (|SparseUnivariatePolynomial| P)))
          (#3=#:G770 NIL)
          (|uu| (|Union| (|SparseUnivariatePolynomial| P) "failed"))
          (#4=#:G757 NIL) (#5=#:G756 #6=(|SparseUnivariatePolynomial| P))
          (#7=#:G758 #6#) (#8=#:G782 NIL) (|pol| NIL) (|ltochange| #2#)
          (|tablecoef|
           (|List|
            (|Record| (|:| |coefu| P)
                      (|:| |detfacts|
                           (|List|
                            (|List|
                             (|Record| (|:| |expt| (|NonNegativeInteger|))
                                       (|:| |pcoef| P))))))))
          (#9=#:G781 NIL) (|changed| (|Boolean|))
          (|ndet| (|NonNegativeInteger|)) (#10=#:G746 NIL)
          (|nterm|
           #11=(|Record| (|:| |expt| (|NonNegativeInteger|)) (|:| |pcoef| P)))
          (|vexp| #12=(|NonNegativeInteger|))
          (|vpos| #13=(|NonNegativeInteger|))
          (|celtf|
           (|Record| (|:| |valexp| (|NonNegativeInteger|)) (|:| |valcoef| P)
                     (|:| |posit| (|NonNegativeInteger|))))
          (|cf|
           (|Union|
            (|Record| (|:| |valexp| #12#) (|:| |valcoef| P) (|:| |posit| #13#))
            "failed" "reject"))
          (#14=#:G780 NIL) (|dt| (|NonNegativeInteger|))
          (|lexp| (|List| (|List| (|NonNegativeInteger|)))) (#15=#:G779 NIL)
          (|ep| NIL) (#16=#:G778 NIL) (|ldtcf| (|List| (|List| #11#)))
          (#17=#:G776 NIL) (#18=#:G777 NIL) (|lcu| NIL) (#19=#:G775 NIL)
          (|ulist| (|Vector| P)) (#20=#:G774 NIL) (#21=#:G773 NIL)
          (#22=#:G772 NIL) (|v| NIL) (#23=#:G771 NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |detcoef| NIL) (LETT |detufact| NIL)
                (LETT |lexp|
                      (PROGN
                       (LETT #23# NIL)
                       (SEQ (LETT |v| NIL) (LETT #22# |factlist|) G190
                            (COND
                             ((OR (ATOM #22#)
                                  (PROGN (LETT |v| (CAR #22#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #23#
                                    (CONS (|NPCOEF;listexp| |v| $) #23#))))
                            (LETT #22# (CDR #22#)) (GO G190) G191
                            (EXIT (NREVERSE #23#)))))
                (LETT |ulist|
                      (SPADCALL
                       (PROGN
                        (LETT #21# NIL)
                        (SEQ (LETT |i| 0)
                             (LETT #20# (SPADCALL |u| (QREFELT $ 13))) G190
                             (COND ((|greater_SI| |i| #20#) (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #21#
                                     (CONS (SPADCALL |u| |i| (QREFELT $ 14))
                                           #21#))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT (NREVERSE #21#))))
                       (QREFELT $ 17)))
                (LETT |tablecoef|
                      (|NPCOEF;buildtable| |ulist| |lexp| |leadlist| $))
                (LETT |detcoef|
                      (PROGN
                       (LETT #19# NIL)
                       (SEQ (LETT |lcu| NIL) (LETT #18# |leadlist|)
                            (LETT |ep| NIL) (LETT #17# |lexp|) G190
                            (COND
                             ((OR (ATOM #17#)
                                  (PROGN (LETT |ep| (CAR #17#)) NIL)
                                  (ATOM #18#)
                                  (PROGN (LETT |lcu| (CAR #18#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #19#
                                    (CONS
                                     (LIST (CONS (|SPADfirst| |ep|) |lcu|))
                                     #19#))))
                            (LETT #17#
                                  (PROG1 (CDR #17#) (LETT #18# (CDR #18#))))
                            (GO G190) G191 (EXIT (NREVERSE #19#)))))
                (LETT |ldtcf| |detcoef|)
                (LETT |lexp|
                      (PROGN
                       (LETT #16# NIL)
                       (SEQ (LETT |ep| NIL) (LETT #15# |lexp|) G190
                            (COND
                             ((OR (ATOM #15#)
                                  (PROGN (LETT |ep| (CAR #15#)) NIL))
                              (GO G191)))
                            (SEQ (EXIT (LETT #16# (CONS (CDR |ep|) #16#))))
                            (LETT #15# (CDR #15#)) (GO G190) G191
                            (EXIT (NREVERSE #16#)))))
                (LETT |ndet| (LENGTH |factlist|)) (LETT |changed| 'T)
                (LETT |ltochange| NIL) (LETT |ltodel| NIL)
                (SEQ G190
                     (COND
                      ((NULL
                        (COND (|changed| (SPADCALL |ndet| 1 (QREFELT $ 21)))
                              ('T NIL)))
                       (GO G191)))
                     (SEQ (LETT |changed| NIL) (LETT |dt| (LENGTH |tablecoef|))
                          (SEQ (LETT |i| 1) (LETT #14# |dt|) G190
                               (COND
                                ((OR (|greater_SI| |i| #14#)
                                     (NULL (NULL |changed|)))
                                 (GO G191)))
                               (SEQ
                                (LETT |cf|
                                      (|NPCOEF;check|
                                       (SPADCALL |tablecoef| |i|
                                                 (QREFELT $ 26))
                                       |ulist| $))
                                (EXIT
                                 (COND ((QEQCAR |cf| 1) "next i")
                                       ((QEQCAR |cf| 2)
                                        (PROGN
                                         (LETT #3#
                                               (VECTOR NIL NIL |factlist|
                                                       |leadlist|))
                                         (GO #24=#:G769)))
                                       ('T
                                        (SEQ
                                         (LETT |ltochange|
                                               (CONS |i| |ltochange|))
                                         (LETT |celtf| (QCDR |cf|))
                                         (LETT |tablecoef|
                                               (|NPCOEF;modify| |tablecoef|
                                                |celtf| $))
                                         (LETT |vpos| (QVELT |celtf| 2))
                                         (LETT |vexp| (QVELT |celtf| 0))
                                         (LETT |nterm|
                                               (CONS |vexp| (QVELT |celtf| 1)))
                                         (SPADCALL |detcoef| |vpos|
                                                   (CONS |nterm|
                                                         (SPADCALL |detcoef|
                                                                   |vpos|
                                                                   (QREFELT $
                                                                            29)))
                                                   (QREFELT $ 30))
                                         (SPADCALL |lexp| |vpos|
                                                   (SPADCALL
                                                    (SPADCALL |lexp| |vpos|
                                                              (QREFELT $ 33))
                                                    (SPADCALL |vexp|
                                                              (SPADCALL |lexp|
                                                                        |vpos|
                                                                        (QREFELT
                                                                         $ 33))
                                                              (QREFELT $ 34))
                                                    (QREFELT $ 35))
                                                   (QREFELT $ 36))
                                         (COND
                                          ((SPADCALL
                                            (SPADCALL |lexp| |vpos|
                                                      (QREFELT $ 33))
                                            NIL (QREFELT $ 37))
                                           (SEQ
                                            (LETT |ltodel|
                                                  (CONS |vpos| |ltodel|))
                                            (LETT |ndet|
                                                  (PROG1
                                                      (LETT #10# (- |ndet| 1))
                                                    (|check_subtype2|
                                                     (>= #10# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #10#)))
                                            (EXIT
                                             (LETT |detufact|
                                                   (CONS
                                                    (|NPCOEF;constructp|
                                                     (SPADCALL |detcoef| |vpos|
                                                               (QREFELT $ 29))
                                                     $)
                                                    |detufact|))))))
                                         (EXIT (LETT |changed| 'T)))))))
                               (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                               (EXIT NIL))
                          (SEQ (LETT |i| NIL) (LETT #9# |ltochange|) G190
                               (COND
                                ((OR (ATOM #9#)
                                     (PROGN (LETT |i| (CAR #9#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT |tablecoef|
                                       (SPADCALL |tablecoef| |i|
                                                 (QREFELT $ 38)))))
                               (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL))
                          (EXIT (LETT |ltochange| NIL)))
                     NIL (GO G190) G191 (EXIT NIL))
                (COND
                 ((EQL |ndet| 1)
                  (SEQ
                   (LETT |uu|
                         (SPADCALL |u|
                                   (PROGN
                                    (LETT #4# NIL)
                                    (SEQ (LETT |pol| NIL) (LETT #8# |detufact|)
                                         G190
                                         (COND
                                          ((OR (ATOM #8#)
                                               (PROGN
                                                (LETT |pol| (CAR #8#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (PROGN
                                            (LETT #7# |pol|)
                                            (COND
                                             (#4#
                                              (LETT #5#
                                                    (SPADCALL #5# #7#
                                                              (QREFELT $ 39))))
                                             ('T
                                              (PROGN
                                               (LETT #5# #7#)
                                               (LETT #4# 'T)))))))
                                         (LETT #8# (CDR #8#)) (GO G190) G191
                                         (EXIT NIL))
                                    (COND (#4# #5#)
                                          (#25='T (|spadConstant| $ 40))))
                                   (QREFELT $ 42)))
                   (EXIT
                    (COND
                     ((QEQCAR |uu| 1)
                      (PROGN
                       (LETT #3# (VECTOR NIL |ldtcf| |factlist| |leadlist|))
                       (GO #24#)))
                     (#25# (LETT |detufact| (CONS (QCDR |uu|) |detufact|)))))))
                 (#25#
                  (SEQ
                   (LETT |ltodel|
                         (SPADCALL (ELT $ 43) |ltodel| (QREFELT $ 45)))
                   (EXIT
                    (SEQ (LETT |i| NIL) (LETT #1# |ltodel|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (LETT |detcoef|
                                (SPADCALL |detcoef| |i| (QREFELT $ 46)))
                          (LETT |factlist|
                                (SPADCALL |factlist| |i| (QREFELT $ 48)))
                          (EXIT
                           (LETT |leadlist|
                                 (SPADCALL |leadlist| |i| (QREFELT $ 49)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))))))
                (EXIT (VECTOR |detufact| |detcoef| |factlist| |leadlist|))))
          #24# (EXIT #3#)))) 

(SDEFUN |NPCOEF;check|
        ((|tterm|
          (|Record| (|:| |coefu| P)
                    (|:| |detfacts|
                         #1=(|List|
                             (|List|
                              (|Record| (|:| |expt| (|NonNegativeInteger|))
                                        (|:| |pcoef| P)))))))
         (|ulist| (|Vector| P))
         ($
          (|Union|
           (|Record| (|:| |valexp| (|NonNegativeInteger|)) (|:| |valcoef| P)
                     (|:| |posit| (|NonNegativeInteger|)))
           "failed" "reject")))
        (SPROG
         ((|pp| (|Union| P "failed")) (|poselt| #2=(|NonNegativeInteger|))
          (#3=#:G799 NIL) (|doit| #2#) (|cfu| (P)) (|cu1| (P)) (#4=#:G808 NIL)
          (|elterm| NIL)
          (|vterm|
           (|List|
            (|Record| (|:| |expt| (|NonNegativeInteger|)) (|:| |pcoef| P))))
          (|termlist| #1#))
         (SEQ (LETT |cfu| (|spadConstant| $ 52)) (LETT |doit| 0)
              (LETT |poselt| 0) (LETT |termlist| (QCDR |tterm|))
              (LETT |vterm| NIL)
              (EXIT
               (COND
                ((EQL (LENGTH |termlist|) 1)
                 (SEQ (LETT |vterm| (|SPADfirst| |termlist|))
                      (SEQ (LETT |elterm| NIL) (LETT #4# |vterm|) G190
                           (COND
                            ((OR (ATOM #4#)
                                 (PROGN (LETT |elterm| (CAR #4#)) NIL)
                                 (NULL (< |doit| 2)))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL (LETT |cu1| (QCDR |elterm|))
                                         (|spadConstant| $ 53) (QREFELT $ 54))
                               (LETT |cfu|
                                     (SPADCALL |cu1| |cfu| (QREFELT $ 55))))
                              ('T
                               (SEQ (LETT |doit| (+ |doit| 1))
                                    (EXIT
                                     (LETT |poselt|
                                           (PROG1
                                               (LETT #3#
                                                     (SPADCALL |elterm| |vterm|
                                                               (QREFELT $ 56)))
                                             (|check_subtype2| (>= #3# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #3#)))))))))
                           (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (COND ((EQL |doit| 2) (CONS 1 "failed"))
                             ((EQL |doit| 0)
                              (COND
                               ((SPADCALL (QCAR |tterm|) |cfu| (QREFELT $ 59))
                                (CONS 1 "failed"))
                               (#5='T (CONS 2 "reject"))))
                             (#5#
                              (SEQ
                               (LETT |pp|
                                     (SPADCALL (QCAR |tterm|) |cfu|
                                               (QREFELT $ 60)))
                               (EXIT
                                (COND ((QEQCAR |pp| 1) (CONS 2 "reject"))
                                      (#5#
                                       (CONS 0
                                             (VECTOR
                                              (QCAR
                                               (SPADCALL |vterm| |poselt|
                                                         (QREFELT $ 61)))
                                              (QCDR |pp|) |poselt|)))))))))))
                (#5# (CONS 1 "failed"))))))) 

(SDEFUN |NPCOEF;buildvect|
        ((|lvterm|
          (|List|
           (|List|
            (|Record| (|:| |expt| (|NonNegativeInteger|)) (|:| |pcoef| P)))))
         (|n| (|NonNegativeInteger|))
         ($
          (|Vector|
           (|List|
            (|List|
             (|Record| (|:| |expt| (|NonNegativeInteger|))
                       (|:| |pcoef| P)))))))
        (SPROG
         ((#1=#:G831 NIL) (#2=#:G830 NIL) (#3=#:G829 NIL) (|i| NIL)
          (|nexp| (|NonNegativeInteger|)) (#4=#:G828 NIL) (|term| NIL)
          (|ntable|
           #5=(|Vector|
               (|List|
                (|List|
                 (|Record| (|:| |expt| (|NonNegativeInteger|))
                           (|:| |pcoef| P))))))
          (|vtable| #5#) (#6=#:G827 NIL))
         (SEQ (LETT |vtable| (MAKEARR1 |n| NIL))
              (EXIT
               (COND
                ((EQL (LENGTH |lvterm|) 1)
                 (SEQ
                  (SEQ (LETT |term| NIL) (LETT #6# (|SPADfirst| |lvterm|)) G190
                       (COND
                        ((OR (ATOM #6#) (PROGN (LETT |term| (CAR #6#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (SPADCALL |vtable| (+ (QCAR |term|) 1)
                                   (LIST (LIST |term|)) (QREFELT $ 63))))
                       (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))
                  (EXIT |vtable|)))
                ('T
                 (SEQ (LETT |vtable| (|NPCOEF;buildvect| (CDR |lvterm|) |n| $))
                      (LETT |ntable| (MAKEARR1 |n| NIL))
                      (SEQ (LETT |term| NIL) (LETT #4# (|SPADfirst| |lvterm|))
                           G190
                           (COND
                            ((OR (ATOM #4#)
                                 (PROGN (LETT |term| (CAR #4#)) NIL))
                             (GO G191)))
                           (SEQ (LETT |nexp| (QCAR |term|))
                                (EXIT
                                 (SEQ (LETT |i| 1) (LETT #3# |n|) G190
                                      (COND
                                       ((OR (|greater_SI| |i| #3#)
                                            (NULL
                                             (< (+ |nexp| |i|) (+ |n| 1))))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (SPADCALL |ntable| (+ |nexp| |i|)
                                                  (SPADCALL
                                                   (PROGN
                                                    (LETT #2# NIL)
                                                    (SEQ
                                                     (LETT #1#
                                                           (SPADCALL |vtable|
                                                                     |i|
                                                                     (QREFELT $
                                                                              64)))
                                                     G190
                                                     (COND
                                                      ((OR (ATOM #1#)
                                                           (PROGN
                                                            (LETT |lvterm|
                                                                  (CAR #1#))
                                                            NIL))
                                                       (GO G191)))
                                                     (SEQ
                                                      (EXIT
                                                       (LETT #2#
                                                             (CONS
                                                              (CONS |term|
                                                                    |lvterm|)
                                                              #2#))))
                                                     (LETT #1# (CDR #1#))
                                                     (GO G190) G191
                                                     (EXIT (NREVERSE #2#))))
                                                   (SPADCALL |ntable|
                                                             (+ |nexp| |i|)
                                                             (QREFELT $ 64))
                                                   (QREFELT $ 65))
                                                  (QREFELT $ 63))))
                                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                      (EXIT NIL))))
                           (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                      (EXIT |ntable|)))))))) 

(SDEFUN |NPCOEF;buildtable|
        ((|vu| (|Vector| P)) (|lvect| (|List| (|List| (|NonNegativeInteger|))))
         (|leadlist| (|List| P))
         ($
          (|List|
           (|Record| (|:| |coefu| P)
                     (|:| |detfacts|
                          (|List|
                           (|List|
                            (|Record| (|:| |expt| (|NonNegativeInteger|))
                                      (|:| |pcoef| P)))))))))
        (SPROG
         ((|table|
           (|List|
            (|Record| (|:| |coefu| P)
                      (|:| |detfacts|
                           (|List|
                            (|List|
                             (|Record| (|:| |expt| (|NonNegativeInteger|))
                                       (|:| |pcoef| P))))))))
          (#1=#:G850 NIL) (|i| NIL)
          (|partialv|
           (|Vector|
            (|List|
             (|List|
              (|Record| (|:| |expt| (|NonNegativeInteger|))
                        (|:| |pcoef| P))))))
          (#2=#:G849 NIL)
          (|prelim|
           (|List|
            (|List|
             (|Record| (|:| |expt| (|NonNegativeInteger|)) (|:| |pcoef| P)))))
          (#3=#:G848 NIL) (|e| NIL) (#4=#:G847 NIL) (#5=#:G846 NIL) (|lv| NIL)
          (#6=#:G845 NIL) (|degu| (|NonNegativeInteger|)) (#7=#:G833 NIL)
          (|nfact| (|NonNegativeInteger|)))
         (SEQ (LETT |nfact| (LENGTH |leadlist|)) (LETT |table| NIL)
              (LETT |degu|
                    (PROG1 (LETT #7# (- (QVSIZE |vu|) 1))
                      (|check_subtype2| (>= #7# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #7#)))
              (LETT |prelim|
                    (PROGN
                     (LETT #6# NIL)
                     (SEQ (LETT |lv| NIL) (LETT #5# |lvect|) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |lv| (CAR #5#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #6#
                                  (CONS
                                   (PROGN
                                    (LETT #4# NIL)
                                    (SEQ (LETT |e| NIL) (LETT #3# |lv|) G190
                                         (COND
                                          ((OR (ATOM #3#)
                                               (PROGN
                                                (LETT |e| (CAR #3#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #4#
                                                 (CONS
                                                  (CONS |e|
                                                        (|spadConstant| $ 53))
                                                  #4#))))
                                         (LETT #3# (CDR #3#)) (GO G190) G191
                                         (EXIT (NREVERSE #4#))))
                                   #6#))))
                          (LETT #5# (CDR #5#)) (GO G190) G191
                          (EXIT (NREVERSE #6#)))))
              (SEQ (LETT |i| 1) (LETT #2# |nfact|) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (PROGN
                      (RPLACD
                       (|SPADfirst| (SPADCALL |prelim| |i| (QREFELT $ 29)))
                       (SPADCALL |leadlist| |i| (QREFELT $ 66)))
                      (QCDR
                       (|SPADfirst| (SPADCALL |prelim| |i| (QREFELT $ 29)))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |partialv| (MAKEARR1 |nfact| NIL))
              (LETT |partialv| (|NPCOEF;buildvect| |prelim| |degu| $))
              (SEQ (LETT |i| 1) (LETT #1# |degu|) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((NULL (SPADCALL |partialv| |i| (QREFELT $ 64)))
                       "next i")
                      ('T
                       (LETT |table|
                             (CONS
                              (CONS (SPADCALL |vu| |i| (QREFELT $ 67))
                                    (SPADCALL |partialv| |i| (QREFELT $ 64)))
                              |table|))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |table|)))) 

(SDEFUN |NPCOEF;modify|
        ((|tablecoef|
          (|List|
           (|Record| (|:| |coefu| P)
                     (|:| |detfacts|
                          (|List|
                           (|List|
                            (|Record| (|:| |expt| (|NonNegativeInteger|))
                                      (|:| |pcoef| P))))))))
         (|cfter|
          (|Record| (|:| |valexp| (|NonNegativeInteger|)) (|:| |valcoef| P)
                    (|:| |posit| (|NonNegativeInteger|))))
         ($
          (|List|
           (|Record| (|:| |coefu| P)
                     (|:| |detfacts|
                          (|List|
                           (|List|
                            (|Record| (|:| |expt| (|NonNegativeInteger|))
                                      (|:| |pcoef| P)))))))))
        (SPROG
         ((|lterase| (|List| (|NonNegativeInteger|)))
          (|ctdet|
           (|List|
            (|List|
             (|Record| (|:| |expt| (|NonNegativeInteger|)) (|:| |pcoef| P)))))
          (#1=#:G915 NIL) (|i| NIL) (#2=#:G896 NIL) (#3=#:G895 (P))
          (#4=#:G897 (P)) (#5=#:G914 NIL) (|cc| NIL)
          (|k| (|NonNegativeInteger|)) (#6=#:G894 NIL) (#7=#:G882 NIL)
          (#8=#:G881 #9=(|Boolean|)) (#10=#:G883 #9#) (#11=#:G913 NIL)
          (#12=#:G912 NIL) (|celt| NIL) (#13=#:G878 NIL)
          (#14=#:G877 #15=(|NonNegativeInteger|)) (#16=#:G879 #15#)
          (#17=#:G911 NIL) (|term| NIL) (#18=#:G910 NIL) (|cterm| NIL)
          (|cfpos| (|NonNegativeInteger|)) (|cfcoef| (P))
          (|cfexp| (|NonNegativeInteger|)))
         (SEQ (LETT |cfexp| (QVELT |cfter| 0))
              (LETT |cfcoef| (QVELT |cfter| 1))
              (LETT |cfpos| (QVELT |cfter| 2)) (LETT |lterase| NIL)
              (SEQ (LETT |cterm| NIL) (LETT #18# |tablecoef|) G190
                   (COND
                    ((OR (ATOM #18#) (PROGN (LETT |cterm| (CAR #18#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((NULL (NULL (LETT |ctdet| (QCDR |cterm|))))
                       (COND
                        ((<
                          (PROGN
                           (LETT #13# NIL)
                           (SEQ (LETT |term| NIL)
                                (LETT #17# (|SPADfirst| |ctdet|)) G190
                                (COND
                                 ((OR (ATOM #17#)
                                      (PROGN (LETT |term| (CAR #17#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (PROGN
                                   (LETT #16# (QCAR |term|))
                                   (COND (#13# (LETT #14# (+ #14# #16#)))
                                         ('T
                                          (PROGN
                                           (LETT #14# #16#)
                                           (LETT #13# 'T)))))))
                                (LETT #17# (CDR #17#)) (GO G190) G191
                                (EXIT NIL))
                           (COND (#13# #14#) ('T 0)))
                          |cfexp|)
                         "next term")
                        ('T
                         (SEQ
                          (SEQ (LETT |celt| NIL) (LETT #12# |ctdet|) G190
                               (COND
                                ((OR (ATOM #12#)
                                     (PROGN (LETT |celt| (CAR #12#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((EQL
                                    (QCAR
                                     (SPADCALL |celt| |cfpos| (QREFELT $ 61)))
                                    |cfexp|)
                                   (SEQ
                                    (PROGN
                                     (RPLACD
                                      (SPADCALL |celt| |cfpos| (QREFELT $ 61))
                                      |cfcoef|)
                                     (QCDR
                                      (SPADCALL |celt| |cfpos|
                                                (QREFELT $ 61))))
                                    (EXIT
                                     (COND
                                      ((PROGN
                                        (LETT #7# NIL)
                                        (SEQ (LETT |cc| NIL) (LETT #11# |celt|)
                                             G190
                                             (COND
                                              ((OR (ATOM #11#)
                                                   (PROGN
                                                    (LETT |cc| (CAR #11#))
                                                    NIL))
                                               (GO G191)))
                                             (SEQ
                                              (EXIT
                                               (PROGN
                                                (LETT #10#
                                                      (SPADCALL (QCDR |cc|)
                                                                (|spadConstant|
                                                                 $ 53)
                                                                (QREFELT $
                                                                         54)))
                                                (COND
                                                 (#7#
                                                  (LETT #8#
                                                        (COND (#8# #10#)
                                                              ('T NIL))))
                                                 ('T
                                                  (PROGN
                                                   (LETT #8# #10#)
                                                   (LETT #7# 'T)))))))
                                             (LETT #11# (CDR #11#)) (GO G190)
                                             G191 (EXIT NIL))
                                        (COND (#7# #8#) ('T 'T)))
                                       (SEQ
                                        (LETT |k|
                                              (PROG1
                                                  (LETT #6#
                                                        (SPADCALL |celt|
                                                                  |ctdet|
                                                                  (QREFELT $
                                                                           68)))
                                                (|check_subtype2| (>= #6# 0)
                                                                  '(|NonNegativeInteger|)
                                                                  '(|Integer|)
                                                                  #6#)))
                                        (LETT |lterase| (CONS |k| |lterase|))
                                        (EXIT
                                         (PROGN
                                          (RPLACA |cterm|
                                                  (SPADCALL (QCAR |cterm|)
                                                            (PROGN
                                                             (LETT #2# NIL)
                                                             (SEQ
                                                              (LETT |cc| NIL)
                                                              (LETT #5# |celt|)
                                                              G190
                                                              (COND
                                                               ((OR (ATOM #5#)
                                                                    (PROGN
                                                                     (LETT |cc|
                                                                           (CAR
                                                                            #5#))
                                                                     NIL))
                                                                (GO G191)))
                                                              (SEQ
                                                               (EXIT
                                                                (PROGN
                                                                 (LETT #4#
                                                                       (QCDR
                                                                        |cc|))
                                                                 (COND
                                                                  (#2#
                                                                   (LETT #3#
                                                                         (SPADCALL
                                                                          #3#
                                                                          #4#
                                                                          (QREFELT
                                                                           $
                                                                           55))))
                                                                  ('T
                                                                   (PROGN
                                                                    (LETT #3#
                                                                          #4#)
                                                                    (LETT #2#
                                                                          'T)))))))
                                                              (LETT #5#
                                                                    (CDR #5#))
                                                              (GO G190) G191
                                                              (EXIT NIL))
                                                             (COND (#2# #3#)
                                                                   ('T
                                                                    (|spadConstant|
                                                                     $ 52))))
                                                            (QREFELT $ 69)))
                                          (QCAR |cterm|))))))))))))
                               (LETT #12# (CDR #12#)) (GO G190) G191
                               (EXIT NIL))
                          (EXIT
                           (COND
                            ((NULL (NULL |lterase|))
                             (SEQ
                              (LETT |lterase|
                                    (SPADCALL (ELT $ 43) |lterase|
                                              (QREFELT $ 45)))
                              (SEQ (LETT |i| NIL) (LETT #1# |lterase|) G190
                                   (COND
                                    ((OR (ATOM #1#)
                                         (PROGN (LETT |i| (CAR #1#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT |ctdet|
                                           (SPADCALL |ctdet| |i|
                                                     (QREFELT $ 46)))))
                                   (LETT #1# (CDR #1#)) (GO G190) G191
                                   (EXIT NIL))
                              (PROGN (RPLACD |cterm| |ctdet|) (QCDR |cterm|))
                              (EXIT (LETT |lterase| NIL)))))))))))))
                   (LETT #18# (CDR #18#)) (GO G190) G191 (EXIT NIL))
              (EXIT |tablecoef|)))) 

(SDEFUN |NPCOEF;listexp| ((|up| (BP)) ($ (|List| (|NonNegativeInteger|))))
        (COND ((EQL (SPADCALL |up| (QREFELT $ 70)) 0) (LIST 0))
              ('T
               (CONS (SPADCALL |up| (QREFELT $ 70))
                     (|NPCOEF;listexp| (SPADCALL |up| (QREFELT $ 71)) $))))) 

(SDEFUN |NPCOEF;constructp|
        ((|lterm|
          (|List|
           (|Record| (|:| |expt| (|NonNegativeInteger|)) (|:| |pcoef| P))))
         ($ (|SparseUnivariatePolynomial| P)))
        (SPROG
         ((#1=#:G919 NIL) (#2=#:G918 #3=(|SparseUnivariatePolynomial| P))
          (#4=#:G920 #3#) (#5=#:G922 NIL) (|term| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |term| NIL) (LETT #5# |lterm|) G190
                (COND
                 ((OR (ATOM #5#) (PROGN (LETT |term| (CAR #5#)) NIL))
                  (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #4#
                         (SPADCALL (QCDR |term|) (QCAR |term|) (QREFELT $ 72)))
                   (COND (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 73))))
                         ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 74))))))) 

(DECLAIM (NOTINLINE |NPCoef;|)) 

(DEFUN |NPCoef| (&REST #1=#:G923)
  (SPROG NIL
         (PROG (#2=#:G924)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|NPCoef|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |NPCoef;|) #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|NPCoef|)))))))))) 

(DEFUN |NPCoef;| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT |dv$| (LIST '|NPCoef| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 75))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|NPCoef| (LIST DV$1 DV$2 DV$3 DV$4 DV$5)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|NPCoef| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|)
              (|NonNegativeInteger|) (|SparseUnivariatePolynomial| 10)
              (0 . |degree|) (5 . |coefficient|) (|List| 10) (|Vector| 10)
              (11 . |vector|) (16 . |One|) (20 . |One|) (|Boolean|) (24 . ~=)
              (|Record| (|:| |expt| 11) (|:| |pcoef| 10))
              (|Record| (|:| |coefu| 10) (|:| |detfacts| 28)) (|Integer|)
              (|List| 23) (30 . |elt|) (|List| 22) (|List| 27) (36 . |elt|)
              (42 . |setelt!|) (|List| 11) (|List| 31) (49 . |elt|)
              (55 . |position|) (61 . |delete|) (67 . |setelt!|) (74 . =)
              (80 . |delete|) (86 . *) (92 . |One|) (|Union| $ '"failed")
              (96 . |exquo|) (102 . >) (|Mapping| 20 11 11) (108 . |sort|)
              (114 . |delete|) (|List| 6) (120 . |delete|) (126 . |delete|)
              (|Record| (|:| |deter| (|List| 12)) (|:| |dterm| 28)
                        (|:| |nfacts| 47) (|:| |nlead| 15))
              |NPCOEF;npcoef;SupLLR;1| (132 . |One|) (136 . |Zero|) (140 . ~=)
              (146 . *) (152 . |position|) (158 . |Zero|) (162 . |Zero|)
              (166 . =) (172 . |exquo|) (178 . |elt|) (|Vector| 28)
              (184 . |setelt!|) (191 . |elt|) (197 . |append|) (203 . |elt|)
              (209 . |elt|) (215 . |position|) (221 . -) (227 . |degree|)
              (232 . |reductum|) (237 . |monomial|) (243 . +) (249 . |Zero|))
           '#(|npcoef| 253) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|npcoef|
                                 ((|Record|
                                   (|:| |deter|
                                        (|List|
                                         (|SparseUnivariatePolynomial| |#5|)))
                                   (|:| |dterm|
                                        (|List|
                                         (|List|
                                          (|Record|
                                           (|:| |expt| (|NonNegativeInteger|))
                                           (|:| |pcoef| |#5|)))))
                                   (|:| |nfacts| (|List| |#1|))
                                   (|:| |nlead| (|List| |#5|)))
                                  (|SparseUnivariatePolynomial| |#5|)
                                  (|List| |#1|) (|List| |#5|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 74
                                            '(1 12 11 0 13 2 12 10 0 11 14 1 16
                                              0 15 17 0 6 0 18 0 9 0 19 2 11 20
                                              0 0 21 2 25 23 0 24 26 2 28 27 0
                                              24 29 3 28 27 0 24 27 30 2 32 31
                                              0 24 33 2 31 24 11 0 34 2 31 0 0
                                              24 35 3 32 31 0 24 31 36 2 31 20
                                              0 0 37 2 25 0 0 24 38 2 12 0 0 0
                                              39 0 12 0 40 2 12 41 0 0 42 2 11
                                              20 0 0 43 2 31 0 44 0 45 2 28 0 0
                                              24 46 2 47 0 0 24 48 2 15 0 0 24
                                              49 0 10 0 52 0 10 0 53 2 10 20 0
                                              0 54 2 10 0 0 0 55 2 27 24 22 0
                                              56 0 6 0 57 0 7 0 58 2 10 20 0 0
                                              59 2 10 41 0 0 60 2 27 22 0 24 61
                                              3 62 28 0 24 28 63 2 62 28 0 24
                                              64 2 28 0 0 0 65 2 15 10 0 24 66
                                              2 16 10 0 24 67 2 28 24 27 0 68 2
                                              10 0 0 0 69 1 6 11 0 70 1 6 0 0
                                              71 2 12 0 10 11 72 2 12 0 0 0 73
                                              0 12 0 74 3 0 50 12 47 15 51)))))
           '|lookupComplete|)) 
