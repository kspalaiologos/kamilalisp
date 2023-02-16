
(SDEFUN |ITRIGMNP;GR2F| ((|g| (|Complex| R)) ($ (F)))
        (SPADCALL (SPADCALL (SPADCALL |g| (QREFELT $ 11)) (QREFELT $ 12))
                  (SPADCALL
                   (SPADCALL (SPADCALL (|spadConstant| $ 13) (QREFELT $ 14))
                             (QREFELT $ 15))
                   (SPADCALL (SPADCALL |g| (QREFELT $ 16)) (QREFELT $ 12))
                   (QREFELT $ 17))
                  (QREFELT $ 18))) 

(SDEFUN |ITRIGMNP;FG2F;FGF;2| ((|f| (FG)) ($ (F)))
        (SPADCALL (|ITRIGMNP;PG2F| (SPADCALL |f| (QREFELT $ 20)) $)
                  (|ITRIGMNP;PG2F| (SPADCALL |f| (QREFELT $ 21)) $)
                  (QREFELT $ 22))) 

(SDEFUN |ITRIGMNP;F2FG;FFG;3| ((|f| (F)) ($ (FG)))
        (SPADCALL (|ITRIGMNP;PF2FG| (SPADCALL |f| (QREFELT $ 25)) $)
                  (|ITRIGMNP;PF2FG| (SPADCALL |f| (QREFELT $ 26)) $)
                  (QREFELT $ 27))) 

(SDEFUN |ITRIGMNP;GF2FG;CFG;4| ((|f| (|Complex| F)) ($ (FG)))
        (SPADCALL (SPADCALL (SPADCALL |f| (QREFELT $ 30)) (QREFELT $ 28))
                  (SPADCALL
                   (SPADCALL
                    (SPADCALL (|spadConstant| $ 31) (|spadConstant| $ 33)
                              (QREFELT $ 34))
                    (QREFELT $ 35))
                   (SPADCALL (SPADCALL |f| (QREFELT $ 36)) (QREFELT $ 28))
                   (QREFELT $ 37))
                  (QREFELT $ 38))) 

(SDEFUN |ITRIGMNP;GR2GF| ((|gr| (|Complex| R)) ($ (|Complex| F)))
        (SPADCALL (SPADCALL (SPADCALL |gr| (QREFELT $ 11)) (QREFELT $ 12))
                  (SPADCALL (SPADCALL |gr| (QREFELT $ 16)) (QREFELT $ 12))
                  (QREFELT $ 40))) 

(SDEFUN |ITRIGMNP;KG2F| ((|k| (|Kernel| FG)) ($ (F)))
        (SPROG ((#1=#:G767 NIL) (|a| NIL) (#2=#:G766 NIL))
               (SEQ
                (SPADCALL
                 (SPADCALL (SPADCALL |k| (QREFELT $ 44)) (QREFELT $ 45))
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |a| NIL) (LETT #1# (SPADCALL |k| (QREFELT $ 47)))
                       G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |a| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2# (CONS (SPADCALL |a| (QREFELT $ 23)) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 49))))) 

(SDEFUN |ITRIGMNP;KF2FG| ((|k| (|Kernel| F)) ($ (FG)))
        (SPROG
         ((#1=#:G786 NIL) (|a| NIL) (#2=#:G785 NIL) (|op| (|BasicOperator|))
          (|akl| (|List| F)))
         (SEQ (LETT |akl| (SPADCALL |k| (QREFELT $ 52)))
              (LETT |op| (SPADCALL |k| (QREFELT $ 53)))
              (COND
               ((SPADCALL |op| '|nthRoot| (QREFELT $ 56))
                (COND
                 ((SPADCALL (SPADCALL |akl| 1 (QREFELT $ 58))
                            (SPADCALL (|spadConstant| $ 13) (QREFELT $ 14))
                            (QREFELT $ 59))
                  (COND
                   ((SPADCALL (SPADCALL |akl| 2 (QREFELT $ 58))
                              (SPADCALL 2 (QREFELT $ 60)) (QREFELT $ 59))
                    (EXIT (QREFELT $ 41))))))))
              (EXIT
               (SPADCALL (SPADCALL |op| (QREFELT $ 61))
                         (PROGN
                          (LETT #2# NIL)
                          (SEQ (LETT |a| NIL) (LETT #1# |akl|) G190
                               (COND
                                ((OR (ATOM #1#)
                                     (PROGN (LETT |a| (CAR #1#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #2#
                                       (CONS (SPADCALL |a| (QREFELT $ 28))
                                             #2#))))
                               (LETT #1# (CDR #1#)) (GO G190) G191
                               (EXIT (NREVERSE #2#))))
                         (QREFELT $ 62)))))) 

(SDEFUN |ITRIGMNP;ker2explogs|
        ((|k| (|Kernel| FG)) (|l| (|List| (|Kernel| FG))) ($ (FG)))
        (SPROG
         ((|e| (FG)) (|z| (FG)) (|args| (|List| FG)) (#1=#:G804 NIL) (|a| NIL)
          (#2=#:G803 NIL) (|kf| (FG)))
         (SEQ (LETT |kf| (SPADCALL |k| (QREFELT $ 64)))
              (EXIT
               (COND
                ((NULL
                  (LETT |args|
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |a| NIL)
                              (LETT #1# (SPADCALL |k| (QREFELT $ 47))) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |a| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2#
                                      (CONS (SPADCALL |a| |l| (QREFELT $ 66))
                                            #2#))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#))))))
                 |kf|)
                (#3='T
                 (SEQ (LETT |z| (|SPADfirst| |args|))
                      (EXIT
                       (COND
                        ((SPADCALL |k| '|tan| (QREFELT $ 67))
                         (SEQ
                          (LETT |e|
                                (COND
                                 ((SPADCALL |k| |l| (QREFELT $ 68))
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL (QREFELT $ 41) |z|
                                              (QREFELT $ 37))
                                    (QREFELT $ 69))
                                   2 (QREFELT $ 70)))
                                 (#3#
                                  (SPADCALL
                                   (SPADCALL
                                    (SPADCALL 2 (QREFELT $ 41) (QREFELT $ 72))
                                    |z| (QREFELT $ 37))
                                   (QREFELT $ 69)))))
                          (EXIT
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL (QREFELT $ 41)
                                       (SPADCALL |e| (|spadConstant| $ 73)
                                                 (QREFELT $ 74))
                                       (QREFELT $ 37))
                             (SPADCALL |e| (|spadConstant| $ 73)
                                       (QREFELT $ 38))
                             (QREFELT $ 27))
                            (QREFELT $ 75)))))
                        ((SPADCALL |k| '|atan| (QREFELT $ 67))
                         (SPADCALL
                          (SPADCALL (QREFELT $ 41)
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL (|spadConstant| $ 73)
                                                (SPADCALL (QREFELT $ 41) |z|
                                                          (QREFELT $ 37))
                                                (QREFELT $ 74))
                                      (SPADCALL (|spadConstant| $ 73)
                                                (SPADCALL (QREFELT $ 41) |z|
                                                          (QREFELT $ 37))
                                                (QREFELT $ 38))
                                      (QREFELT $ 27))
                                     (QREFELT $ 76))
                                    (QREFELT $ 37))
                          (SPADCALL 2 (QREFELT $ 77)) (QREFELT $ 27)))
                        (#3#
                         (SPADCALL (SPADCALL |k| (QREFELT $ 44)) |args|
                                   (QREFELT $ 62)))))))))))) 

(SDEFUN |ITRIGMNP;trigs2explogs;FGLFG;9|
        ((|f| (FG)) (|l| (|List| (|Kernel| FG))) ($ (FG)))
        (SPADCALL (|ITRIGMNP;smp2explogs| (SPADCALL |f| (QREFELT $ 20)) |l| $)
                  (|ITRIGMNP;smp2explogs| (SPADCALL |f| (QREFELT $ 21)) |l| $)
                  (QREFELT $ 27))) 

(SDEFUN |ITRIGMNP;ker2trigs_error|
        ((|op| (|BasicOperator|)) (|arg| (|List| (|Complex| F)))
         ($ (|Complex| F)))
        (SEQ (SPADCALL (SPADCALL |op| (QREFELT $ 79)) (QREFELT $ 81))
             (SPADCALL (SPADCALL |arg| (QREFELT $ 83)) (QREFELT $ 81))
             (EXIT
              (|error|
               "ker2trigs: cannot convert kernel to gaussian function")))) 

(SDEFUN |ITRIGMNP;do_liou;BoLC;11|
        ((|op| (|BasicOperator|)) (|arg| (|List| (|Complex| F)))
         ($ (|Complex| F)))
        (SPROG ((|a1| (F)) (|a| (|Complex| F)))
               (SEQ (LETT |a| (|SPADfirst| |arg|))
                    (COND
                     ((SPADCALL |op| '|Ei| (QREFELT $ 56))
                      (COND
                       ((SPADCALL (SPADCALL |a| (QREFELT $ 30))
                                  (|spadConstant| $ 32) (QREFELT $ 59))
                        (EXIT
                         (SPADCALL
                          (SPADCALL (SPADCALL |a| (QREFELT $ 36))
                                    (QREFELT $ 84))
                          (SPADCALL (SPADCALL |a| (QREFELT $ 36))
                                    (QREFELT $ 85))
                          (QREFELT $ 40)))))))
                    (COND
                     ((SPADCALL |op| '|erf| (QREFELT $ 56))
                      (COND
                       ((SPADCALL (SPADCALL |a| (QREFELT $ 30))
                                  (|spadConstant| $ 32) (QREFELT $ 59))
                        (EXIT
                         (SPADCALL (|spadConstant| $ 32)
                                   (SPADCALL (SPADCALL |a| (QREFELT $ 36))
                                             (QREFELT $ 86))
                                   (QREFELT $ 40)))))))
                    (COND
                     ((SPADCALL |op| '|erf| (QREFELT $ 56))
                      (COND
                       ((SPADCALL (SPADCALL |a| (QREFELT $ 30))
                                  (SPADCALL |a| (QREFELT $ 36)) (QREFELT $ 59))
                        (EXIT
                         (SEQ
                          (LETT |a1|
                                (SPADCALL
                                 (SPADCALL 2 (SPADCALL |a| (QREFELT $ 30))
                                           (QREFELT $ 87))
                                 (SPADCALL (SPADCALL (QREFELT $ 88))
                                           (QREFELT $ 15))
                                 (QREFELT $ 22)))
                          (EXIT
                           (SPADCALL
                            (SPADCALL (|spadConstant| $ 13)
                                      (|spadConstant| $ 13) (QREFELT $ 40))
                            (SPADCALL (SPADCALL |a1| (QREFELT $ 89))
                                      (SPADCALL (SPADCALL |a1| (QREFELT $ 90))
                                                (QREFELT $ 14))
                                      (QREFELT $ 40))
                            (QREFELT $ 91)))))))))
                    (COND
                     ((SPADCALL |op| '|erf| (QREFELT $ 56))
                      (COND
                       ((SPADCALL (SPADCALL |a| (QREFELT $ 30))
                                  (SPADCALL (SPADCALL |a| (QREFELT $ 36))
                                            (QREFELT $ 14))
                                  (QREFELT $ 59))
                        (EXIT
                         (SEQ
                          (LETT |a1|
                                (SPADCALL
                                 (SPADCALL 2 (SPADCALL |a| (QREFELT $ 30))
                                           (QREFELT $ 87))
                                 (SPADCALL (SPADCALL (QREFELT $ 88))
                                           (QREFELT $ 15))
                                 (QREFELT $ 22)))
                          (EXIT
                           (SPADCALL
                            (SPADCALL (|spadConstant| $ 13)
                                      (SPADCALL (|spadConstant| $ 13)
                                                (QREFELT $ 14))
                                      (QREFELT $ 40))
                            (SPADCALL (SPADCALL |a1| (QREFELT $ 89))
                                      (SPADCALL |a1| (QREFELT $ 90))
                                      (QREFELT $ 40))
                            (QREFELT $ 91)))))))))
                    (EXIT (|ITRIGMNP;ker2trigs_error| |op| |arg| $))))) 

(SDEFUN |ITRIGMNP;do_liou;BoLC;12|
        ((|op| (|BasicOperator|)) (|args| (|List| (|Complex| F)))
         ($ (|Complex| F)))
        (|ITRIGMNP;ker2trigs_error| |op| |args| $)) 

(SDEFUN |ITRIGMNP;ker2trigs|
        ((|op| (|BasicOperator|)) (|arg| (|List| (|Complex| F)))
         ($ (|Complex| F)))
        (SPROG
         ((#1=#:G869 NIL) (|x| NIL) (#2=#:G868 NIL) (#3=#:G867 NIL)
          (#4=#:G866 NIL) (|a| (|Complex| F)) (#5=#:G865 NIL) (#6=#:G864 NIL)
          (#7=#:G822 NIL) (#8=#:G821 #9=(|Boolean|)) (#10=#:G823 #9#)
          (#11=#:G863 NIL))
         (SEQ
          (COND
           ((PROGN
             (LETT #7# NIL)
             (SEQ (LETT |x| NIL) (LETT #11# |arg|) G190
                  (COND
                   ((OR (ATOM #11#) (PROGN (LETT |x| (CAR #11#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (PROGN
                     (LETT #10#
                           (SPADCALL (SPADCALL |x| (QREFELT $ 36))
                                     (QREFELT $ 93)))
                     (COND (#7# (LETT #8# (COND (#8# #10#) ('T NIL))))
                           ('T (PROGN (LETT #8# #10#) (LETT #7# 'T)))))))
                  (LETT #11# (CDR #11#)) (GO G190) G191 (EXIT NIL))
             (COND (#7# #8#) (#12='T 'T)))
            (SPADCALL
             (SPADCALL |op|
                       (PROGN
                        (LETT #6# NIL)
                        (SEQ (LETT |x| NIL) (LETT #5# |arg|) G190
                             (COND
                              ((OR (ATOM #5#) (PROGN (LETT |x| (CAR #5#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #6#
                                     (CONS (SPADCALL |x| (QREFELT $ 30))
                                           #6#))))
                             (LETT #5# (CDR #5#)) (GO G190) G191
                             (EXIT (NREVERSE #6#))))
                       (QREFELT $ 94))
             (|spadConstant| $ 32) (QREFELT $ 40)))
           (#12#
            (SEQ (LETT |a| (|SPADfirst| |arg|))
                 (EXIT
                  (COND
                   ((SPADCALL |op| '|exp| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 95)))
                   ((SPADCALL |op| '|log| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 96)))
                   ((SPADCALL |op| '|sin| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 97)))
                   ((SPADCALL |op| '|cos| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 98)))
                   ((SPADCALL |op| '|tan| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 99)))
                   ((SPADCALL |op| '|cot| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 100)))
                   ((SPADCALL |op| '|sec| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 101)))
                   ((SPADCALL |op| '|csc| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 102)))
                   ((SPADCALL |op| '|asin| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 103)))
                   ((SPADCALL |op| '|acos| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 104)))
                   ((SPADCALL |op| '|atan| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 105)))
                   ((SPADCALL |op| '|acot| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 106)))
                   ((SPADCALL |op| '|asec| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 107)))
                   ((SPADCALL |op| '|acsc| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 108)))
                   ((SPADCALL |op| '|sinh| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 109)))
                   ((SPADCALL |op| '|cosh| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 110)))
                   ((SPADCALL |op| '|tanh| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 111)))
                   ((SPADCALL |op| '|coth| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 112)))
                   ((SPADCALL |op| '|sech| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 113)))
                   ((SPADCALL |op| '|csch| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 114)))
                   ((SPADCALL |op| '|asinh| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 115)))
                   ((SPADCALL |op| '|acosh| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 116)))
                   ((SPADCALL |op| '|atanh| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 117)))
                   ((SPADCALL |op| '|acoth| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 118)))
                   ((SPADCALL |op| '|asech| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 119)))
                   ((SPADCALL |op| '|acsch| (QREFELT $ 56))
                    (SPADCALL |a| (QREFELT $ 120)))
                   ((SPADCALL |op| '|abs| (QREFELT $ 56))
                    (SPADCALL
                     (SPADCALL (SPADCALL |a| (QREFELT $ 121)) (QREFELT $ 15))
                     (QREFELT $ 122)))
                   (#12#
                    (SEQ
                     (COND
                      ((QREFELT $ 9)
                       (COND
                        ((SPADCALL |op| '|nthRoot| (QREFELT $ 56))
                         (EXIT
                          (SPADCALL |a|
                                    (SPADCALL (SPADCALL |arg| (QREFELT $ 123))
                                              (QREFELT $ 124))
                                    (QREFELT $ 125)))))))
                     (EXIT
                      (COND
                       ((SPADCALL |op| '|%iint| (QREFELT $ 56))
                        (SPADCALL
                         (SPADCALL |op|
                                   (PROGN
                                    (LETT #4# NIL)
                                    (SEQ (LETT |x| NIL) (LETT #3# |arg|) G190
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
                                                  (SPADCALL |x| (QREFELT $ 30))
                                                  #4#))))
                                         (LETT #3# (CDR #3#)) (GO G190) G191
                                         (EXIT (NREVERSE #4#))))
                                   (QREFELT $ 94))
                         (SPADCALL |op|
                                   (PROGN
                                    (LETT #2# NIL)
                                    (SEQ (LETT |x| NIL) (LETT #1# |arg|) G190
                                         (COND
                                          ((OR (ATOM #1#)
                                               (PROGN
                                                (LETT |x| (CAR #1#))
                                                NIL))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #2#
                                                 (CONS
                                                  (SPADCALL |x| (QREFELT $ 36))
                                                  #2#))))
                                         (LETT #1# (CDR #1#)) (GO G190) G191
                                         (EXIT (NREVERSE #2#))))
                                   (QREFELT $ 94))
                         (QREFELT $ 40)))
                       (#12# (SPADCALL |op| |arg| (QREFELT $ 92))))))))))))))) 

(SDEFUN |ITRIGMNP;sup2trigs|
        ((|p|
          (|SparseUnivariatePolynomial|
           (|SparseMultivariatePolynomial| (|Complex| R) (|Kernel| FG))))
         (|f| (|Complex| F)) ($ (|Complex| F)))
        (SPADCALL
         (SPADCALL (CONS (|function| |ITRIGMNP;smp2trigs|) $) |p|
                   (QREFELT $ 130))
         |f| (QREFELT $ 131))) 

(SDEFUN |ITRIGMNP;smp2trigs|
        ((|p| (|SparseMultivariatePolynomial| (|Complex| R) (|Kernel| FG)))
         ($ (|Complex| F)))
        (SPADCALL (CONS #'|ITRIGMNP;smp2trigs!0| $)
                  (CONS (|function| |ITRIGMNP;GR2GF|) $) |p| (QREFELT $ 137))) 

(SDEFUN |ITRIGMNP;smp2trigs!0| ((|x| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x| (QREFELT $ 64)) (QREFELT $ 132))) 

(SDEFUN |ITRIGMNP;explogs2trigs;FGC;16| ((|f| (FG)) ($ (|Complex| F)))
        (SPROG
         ((|g| #1=(|Complex| F)) (|b| (|Integer|)) (|gi| #1#) (|y| (F))
          (|e| (F))
          (|den|
           #2=(|SparseUnivariatePolynomial|
               (|SparseMultivariatePolynomial| (|Complex| R) (|Kernel| FG))))
          (|num| #2#) (|arg| (|List| (|Complex| F))) (#3=#:G887 NIL) (|x| NIL)
          (#4=#:G886 NIL) (|op| (|BasicOperator|)) (|k| (|Kernel| FG))
          (|m| (|Union| (|Kernel| FG) "failed"))
          (|df| (|SparseMultivariatePolynomial| (|Complex| R) (|Kernel| FG)))
          (|nf| (|SparseMultivariatePolynomial| (|Complex| R) (|Kernel| FG))))
         (SEQ (LETT |nf| (SPADCALL |f| (QREFELT $ 20)))
              (LETT |df| (SPADCALL |f| (QREFELT $ 21)))
              (LETT |m| (SPADCALL |f| (QREFELT $ 139)))
              (EXIT
               (COND
                ((QEQCAR |m| 1)
                 (SPADCALL (|ITRIGMNP;GR2GF| (SPADCALL |nf| (QREFELT $ 140)) $)
                           (|ITRIGMNP;GR2GF| (SPADCALL |df| (QREFELT $ 140)) $)
                           (QREFELT $ 141)))
                (#5='T
                 (SEQ
                  (LETT |op|
                        (SPADCALL
                         (SPADCALL (LETT |k| (QCDR |m|)) (QREFELT $ 44))
                         (QREFELT $ 45)))
                  (LETT |arg|
                        (PROGN
                         (LETT #4# NIL)
                         (SEQ (LETT |x| NIL)
                              (LETT #3# (SPADCALL |k| (QREFELT $ 47))) G190
                              (COND
                               ((OR (ATOM #3#)
                                    (PROGN (LETT |x| (CAR #3#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #4#
                                      (CONS (SPADCALL |x| (QREFELT $ 132))
                                            #4#))))
                              (LETT #3# (CDR #3#)) (GO G190) G191
                              (EXIT (NREVERSE #4#)))))
                  (LETT |num| (SPADCALL |nf| |k| (QREFELT $ 143)))
                  (LETT |den| (SPADCALL |df| |k| (QREFELT $ 143)))
                  (EXIT
                   (COND
                    ((SPADCALL |op| '|exp| (QREFELT $ 56))
                     (SEQ
                      (LETT |e|
                            (SPADCALL
                             (SPADCALL (|SPADfirst| |arg|) (QREFELT $ 30))
                             (QREFELT $ 144)))
                      (LETT |y| (SPADCALL (|SPADfirst| |arg|) (QREFELT $ 36)))
                      (LETT |g|
                            (SPADCALL
                             (SPADCALL |e| (SPADCALL |y| (QREFELT $ 145))
                                       (QREFELT $ 17))
                             (SPADCALL |e| (SPADCALL |y| (QREFELT $ 146))
                                       (QREFELT $ 17))
                             (QREFELT $ 40)))
                      (LETT |gi|
                            (SPADCALL
                             (SPADCALL (SPADCALL |y| (QREFELT $ 145)) |e|
                                       (QREFELT $ 22))
                             (SPADCALL
                              (SPADCALL (SPADCALL |y| (QREFELT $ 146)) |e|
                                        (QREFELT $ 22))
                              (QREFELT $ 14))
                             (QREFELT $ 40)))
                      (EXIT
                       (SPADCALL
                        (|ITRIGMNP;supexp| |num| |g| |gi|
                         (LETT |b|
                               (QUOTIENT2 (SPADCALL |num| (QREFELT $ 148)) 2))
                         $)
                        (|ITRIGMNP;supexp| |den| |g| |gi| |b| $)
                        (QREFELT $ 141)))))
                    (#5#
                     (SPADCALL
                      (|ITRIGMNP;sup2trigs| |num|
                       (LETT |g| (|ITRIGMNP;ker2trigs| |op| |arg| $)) $)
                      (|ITRIGMNP;sup2trigs| |den| |g| $)
                      (QREFELT $ 141)))))))))))) 

(SDEFUN |ITRIGMNP;supexp|
        ((|p|
          (|SparseUnivariatePolynomial|
           (|SparseMultivariatePolynomial| (|Complex| R) (|Kernel| FG))))
         (|f1| (|Complex| F)) (|f2| (|Complex| F)) (|bse| (|Integer|))
         ($ (|Complex| F)))
        (SPROG ((|ans| (|Complex| F)) (|d| (|Integer|)) (|g| (|Complex| F)))
               (SEQ (LETT |ans| (|spadConstant| $ 149))
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL |p| (|spadConstant| $ 150)
                                      (QREFELT $ 151)))
                           (GO G191)))
                         (SEQ
                          (LETT |g|
                                (SPADCALL
                                 (SPADCALL (SPADCALL |p| (QREFELT $ 152))
                                           (QREFELT $ 153))
                                 (QREFELT $ 132)))
                          (SEQ
                           (LETT |d| (- (SPADCALL |p| (QREFELT $ 148)) |bse|))
                           (EXIT
                            (COND
                             ((>= |d| 0)
                              (LETT |ans|
                                    (SPADCALL |ans|
                                              (SPADCALL |g|
                                                        (SPADCALL |f1| |d|
                                                                  (QREFELT $
                                                                           154))
                                                        (QREFELT $ 91))
                                              (QREFELT $ 155))))
                             ('T
                              (LETT |ans|
                                    (SPADCALL |ans|
                                              (SPADCALL |g|
                                                        (SPADCALL |f2| (- |d|)
                                                                  (QREFELT $
                                                                           154))
                                                        (QREFELT $ 91))
                                              (QREFELT $ 155)))))))
                          (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 156)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |ans|)))) 

(SDEFUN |ITRIGMNP;PG2F|
        ((|p| (|SparseMultivariatePolynomial| (|Complex| R) (|Kernel| FG)))
         ($ (F)))
        (SPADCALL (CONS (|function| |ITRIGMNP;KG2F|) $)
                  (CONS (|function| |ITRIGMNP;GR2F|) $) |p| (QREFELT $ 160))) 

(SDEFUN |ITRIGMNP;PF2FG|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| F))) ($ (FG)))
        (SPADCALL (CONS (|function| |ITRIGMNP;KF2FG|) $)
                  (CONS #'|ITRIGMNP;PF2FG!0| $) |p| (QREFELT $ 166))) 

(SDEFUN |ITRIGMNP;PF2FG!0| ((|x| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x| (QREFELT $ 161)) (QREFELT $ 35))) 

(SDEFUN |ITRIGMNP;smp2explogs|
        ((|p| (|SparseMultivariatePolynomial| (|Complex| R) (|Kernel| FG)))
         (|l| (|List| (|Kernel| FG))) ($ (FG)))
        (SPROG NIL
               (SPADCALL (CONS #'|ITRIGMNP;smp2explogs!0| (VECTOR $ |l|))
                         (ELT $ 35) |p| (QREFELT $ 170)))) 

(SDEFUN |ITRIGMNP;smp2explogs!0| ((|x| NIL) ($$ NIL))
        (PROG (|l| $)
          (LETT |l| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|ITRIGMNP;ker2explogs| |x| |l| $))))) 

(DECLAIM (NOTINLINE |InnerTrigonometricManipulations;|)) 

(DEFUN |InnerTrigonometricManipulations| (&REST #1=#:G902)
  (SPROG NIL
         (PROG (#2=#:G903)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|InnerTrigonometricManipulations|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |InnerTrigonometricManipulations;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|InnerTrigonometricManipulations|)))))))))) 

(DEFUN |InnerTrigonometricManipulations;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|InnerTrigonometricManipulations| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 171))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|InnerTrigonometricManipulations|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9
                    (COND
                     ((|HasCategory| |#1| '(|RetractableTo| (|Integer|)))
                      (|HasCategory| |#2| '(|RadicalCategory|)))
                     ('T NIL)))
          (QSETREFV $ 41
                    (SPADCALL
                     (SPADCALL (|spadConstant| $ 31) (|spadConstant| $ 33)
                               (QREFELT $ 34))
                     (QREFELT $ 35)))
          (COND
           ((|HasCategory| |#2| '(|LiouvillianFunctionCategory|))
            (QSETREFV $ 92
                      (CONS (|dispatchFunction| |ITRIGMNP;do_liou;BoLC;11|)
                            $)))
           ('T
            (QSETREFV $ 92
                      (CONS (|dispatchFunction| |ITRIGMNP;do_liou;BoLC;12|)
                            $))))
          $))) 

(MAKEPROP '|InnerTrigonometricManipulations| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) '|nth| (|Complex| 6) (0 . |real|) (5 . |coerce|)
              (10 . |One|) (14 . -) (19 . |sqrt|) (24 . |imag|) (29 . *)
              (35 . +) (|SparseMultivariatePolynomial| 10 63) (41 . |numer|)
              (46 . |denom|) (51 . /) |ITRIGMNP;FG2F;FGF;2|
              (|SparseMultivariatePolynomial| 6 63) (57 . |numer|)
              (62 . |denom|) (67 . /) |ITRIGMNP;F2FG;FFG;3| (|Complex| 7)
              (73 . |real|) (78 . |Zero|) (82 . |Zero|) (86 . |One|)
              (90 . |complex|) (96 . |coerce|) (101 . |imag|) (106 . *)
              (112 . +) |ITRIGMNP;GF2FG;CFG;4| (118 . |complex|) '|im|
              (|BasicOperator|) (|Kernel| 8) (124 . |operator|)
              (129 . |operator|) (|List| 8) (134 . |argument|) (|List| $)
              (139 . |kernel|) (|List| 7) (|Kernel| 7) (145 . |argument|)
              (150 . |operator|) (|Boolean|) (|Symbol|) (155 . |is?|)
              (|Integer|) (161 . |elt|) (167 . =) (173 . |coerce|)
              (178 . |operator|) (183 . |kernel|) (|Kernel| $) (189 . |coerce|)
              (|List| 43) |ITRIGMNP;trigs2explogs;FGLFG;9| (194 . |is?|)
              (200 . |member?|) (206 . |exp|) (211 . ^) (|PositiveInteger|)
              (217 . *) (223 . |One|) (227 . -) (233 . -) (238 . |log|)
              (243 . |coerce|) (|OutputForm|) (248 . |coerce|) (|Void|)
              (253 . |print|) (|List| 29) (258 . |coerce|) (263 . |Ci|)
              (268 . |Si|) (273 . |erfi|) (278 . *) (284 . |pi|)
              (288 . |fresnelC|) (293 . |fresnelS|) (298 . *) (304 . |do_liou|)
              (310 . |zero?|) (315 . |elt|) (321 . |exp|) (326 . |log|)
              (331 . |sin|) (336 . |cos|) (341 . |tan|) (346 . |cot|)
              (351 . |sec|) (356 . |csc|) (361 . |asin|) (366 . |acos|)
              (371 . |atan|) (376 . |acot|) (381 . |asec|) (386 . |acsc|)
              (391 . |sinh|) (396 . |cosh|) (401 . |tanh|) (406 . |coth|)
              (411 . |sech|) (416 . |csch|) (421 . |asinh|) (426 . |acosh|)
              (431 . |atanh|) (436 . |acoth|) (441 . |asech|) (446 . |acsch|)
              (451 . |norm|) (456 . |coerce|) (461 . |second|)
              (466 . |retract|) (471 . |nthRoot|)
              (|SparseUnivariatePolynomial| 29) (|Mapping| 29 135)
              (|SparseUnivariatePolynomial| 135)
              (|SparseUnivariatePolynomialFunctions2| 135 29) (477 . |map|)
              (483 . |elt|) |ITRIGMNP;explogs2trigs;FGC;16| (|Mapping| 29 43)
              (|Mapping| 29 10) (|SparseMultivariatePolynomial| 10 43)
              (|PolynomialCategoryLifting| (|IndexedExponents| 43) 43 10 135
                                           29)
              (489 . |map|) (|Union| 63 '"failed") (496 . |mainKernel|)
              (501 . |retract|) (506 . /) (|SparseUnivariatePolynomial| $)
              (512 . |univariate|) (518 . |exp|) (523 . |cos|) (528 . |sin|)
              (|NonNegativeInteger|) (533 . |degree|) (538 . |Zero|)
              (542 . |Zero|) (546 . ~=) (552 . |leadingCoefficient|)
              (557 . |coerce|) (562 . ^) (568 . +) (574 . |reductum|)
              (|Mapping| 7 43) (|Mapping| 7 10)
              (|PolynomialCategoryLifting| (|IndexedExponents| 43) 43 10 135 7)
              (579 . |map|) (586 . |coerce|) (|Mapping| 8 51) (|Mapping| 8 6)
              (|SparseMultivariatePolynomial| 6 51)
              (|PolynomialCategoryLifting| (|IndexedExponents| 51) 51 6 164 8)
              (591 . |map|) (|Mapping| 8 43) (|Mapping| 8 10)
              (|PolynomialCategoryLifting| (|IndexedExponents| 43) 43 10 135 8)
              (598 . |map|))
           '#(|trigs2explogs| 605 |explogs2trigs| 611 |do_liou| 616 GF2FG 622
              FG2F 627 F2FG 632)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((GF2FG (|#3| (|Complex| |#2|))) T)
                                   '((FG2F (|#2| |#3|)) T)
                                   '((F2FG (|#3| |#2|)) T)
                                   '((|explogs2trigs| ((|Complex| |#2|) |#3|))
                                     T)
                                   '((|trigs2explogs|
                                      (|#3| |#3| (|List| (|Kernel| |#3|))))
                                     T)
                                   '((|do_liou|
                                      ((|Complex| |#2|) (|BasicOperator|)
                                       (|List| (|Complex| |#2|))))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 170
                                            '(1 10 6 0 11 1 7 0 6 12 0 7 0 13 1
                                              7 0 0 14 1 7 0 0 15 1 10 6 0 16 2
                                              7 0 0 0 17 2 7 0 0 0 18 1 8 19 0
                                              20 1 8 19 0 21 2 7 0 0 0 22 1 7
                                              24 0 25 1 7 24 0 26 2 8 0 0 0 27
                                              1 29 7 0 30 0 6 0 31 0 7 0 32 0 6
                                              0 33 2 10 0 6 6 34 1 8 0 10 35 1
                                              29 7 0 36 2 8 0 0 0 37 2 8 0 0 0
                                              38 2 29 0 7 7 40 1 43 42 0 44 1 7
                                              42 42 45 1 43 46 0 47 2 7 0 42 48
                                              49 1 51 50 0 52 1 51 42 0 53 2 42
                                              54 0 55 56 2 50 7 0 57 58 2 7 54
                                              0 0 59 1 7 0 57 60 1 8 42 42 61 2
                                              8 0 42 48 62 1 8 0 63 64 2 43 54
                                              0 55 67 2 65 54 43 0 68 1 8 0 0
                                              69 2 8 0 0 57 70 2 8 0 71 0 72 0
                                              8 0 73 2 8 0 0 0 74 1 8 0 0 75 1
                                              8 0 0 76 1 8 0 57 77 1 42 78 0 79
                                              1 78 80 0 81 1 82 78 0 83 1 7 0 0
                                              84 1 7 0 0 85 1 7 0 0 86 2 7 0 71
                                              0 87 0 7 0 88 1 7 0 0 89 1 7 0 0
                                              90 2 29 0 0 0 91 2 0 29 42 82 92
                                              1 7 54 0 93 2 7 0 42 48 94 1 29 0
                                              0 95 1 29 0 0 96 1 29 0 0 97 1 29
                                              0 0 98 1 29 0 0 99 1 29 0 0 100 1
                                              29 0 0 101 1 29 0 0 102 1 29 0 0
                                              103 1 29 0 0 104 1 29 0 0 105 1
                                              29 0 0 106 1 29 0 0 107 1 29 0 0
                                              108 1 29 0 0 109 1 29 0 0 110 1
                                              29 0 0 111 1 29 0 0 112 1 29 0 0
                                              113 1 29 0 0 114 1 29 0 0 115 1
                                              29 0 0 116 1 29 0 0 117 1 29 0 0
                                              118 1 29 0 0 119 1 29 0 0 120 1
                                              29 7 0 121 1 29 0 7 122 1 82 29 0
                                              123 1 29 57 0 124 2 29 0 0 57 125
                                              2 129 126 127 128 130 2 126 29 0
                                              29 131 3 136 29 133 134 135 137 1
                                              8 138 0 139 1 135 10 0 140 2 29 0
                                              0 0 141 2 135 142 0 43 143 1 7 0
                                              0 144 1 7 0 0 145 1 7 0 0 146 1
                                              128 147 0 148 0 29 0 149 0 128 0
                                              150 2 128 54 0 0 151 1 128 135 0
                                              152 1 8 0 19 153 2 29 0 0 57 154
                                              2 29 0 0 0 155 1 128 0 0 156 3
                                              159 7 157 158 135 160 1 10 0 6
                                              161 3 165 8 162 163 164 166 3 169
                                              8 167 168 135 170 2 0 8 8 65 66 1
                                              0 29 8 132 2 0 29 42 82 92 1 0 8
                                              29 39 1 0 7 8 23 1 0 8 7 28)))))
           '|lookupComplete|)) 
