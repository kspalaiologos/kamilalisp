
(SDEFUN |FS-;ground?;SB;1| ((|x| (S)) ($ (|Boolean|)))
        (QEQCAR (SPADCALL |x| (QREFELT $ 18)) 0)) 

(SDEFUN |FS-;ground;SR;2| ((|x| (S)) ($ (R))) (SPADCALL |x| (QREFELT $ 21))) 

(SDEFUN |FS-;coerce;SS;3| ((|x| (|Symbol|)) ($ (S)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 24)) (QREFELT $ 26))) 

(SDEFUN |FS-;retract;SS;4| ((|x| (S)) ($ (|Symbol|)))
        (SPROG ((#1=#:G760 NIL))
               (PROG2
                   (LETT #1#
                         (SPADCALL (SPADCALL |x| (QREFELT $ 28))
                                   (QREFELT $ 30)))
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 0) (|Symbol|)
                                 (|Union| (|Symbol|) "failed") #1#)))) 

(SDEFUN |FS-;applyQuote;S2S;5| ((|s| (|Symbol|)) (|x| (S)) ($ (S)))
        (SPADCALL |s| (LIST |x|) (QREFELT $ 33))) 

(SDEFUN |FS-;applyQuote;S3S;6| ((|s| (|Symbol|)) (|x| (S)) (|y| (S)) ($ (S)))
        (SPADCALL |s| (LIST |x| |y|) (QREFELT $ 33))) 

(SDEFUN |FS-;applyQuote;S4S;7|
        ((|s| (|Symbol|)) (|x| (S)) (|y| (S)) (|z| (S)) ($ (S)))
        (SPADCALL |s| (LIST |x| |y| |z|) (QREFELT $ 33))) 

(SDEFUN |FS-;applyQuote;S5S;8|
        ((|s| (|Symbol|)) (|x| (S)) (|y| (S)) (|z| (S)) (|t| (S)) ($ (S)))
        (SPADCALL |s| (LIST |x| |y| |z| |t|) (QREFELT $ 33))) 

(SDEFUN |FS-;applyQuote;SLS;9| ((|s| (|Symbol|)) (|l| (|List| S)) ($ (S)))
        (SPADCALL (QREFELT $ 16) (CONS (SPADCALL |s| (QREFELT $ 38)) |l|)
                  (QREFELT $ 39))) 

(SDEFUN |FS-;belong?;BoB;10| ((|op| (|BasicOperator|)) ($ (|Boolean|)))
        (COND
         ((SPADCALL |op| '|any| (QREFELT $ 41))
          (COND ((SPADCALL |op| '|%diff| (QREFELT $ 42)) 'T)
                (#1='T (SPADCALL |op| '|%quote| (QREFELT $ 42)))))
         (#1# NIL))) 

(SDEFUN |FS-;subs| ((|fn| (|Mapping| S S)) (|k| (|Kernel| S)) ($ (S)))
        (SPROG ((#1=#:G775 NIL) (|x| NIL) (#2=#:G774 NIL))
               (SEQ
                (SPADCALL (SPADCALL |k| (QREFELT $ 44))
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |x| NIL)
                                (LETT #1# (SPADCALL |k| (QREFELT $ 46))) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |x| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2# (CONS (SPADCALL |x| |fn|) #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (QREFELT $ 47))))) 

(SDEFUN |FS-;operator;2Bo;12| ((|op| (|BasicOperator|)) ($ (|BasicOperator|)))
        (COND ((SPADCALL |op| '|%diff| (QREFELT $ 42)) (QREFELT $ 15))
              ((SPADCALL |op| '|%quote| (QREFELT $ 42)) (QREFELT $ 16))
              ('T
               (|error|
                (STRCONC "Unknown operator 4: "
                         (SPADCALL (SPADCALL |op| (QREFELT $ 48))
                                   (QREFELT $ 50))))))) 

(SDEFUN |FS-;pint| ((|l| (|List| (|InputForm|))) ($ (|InputForm|)))
        (SPADCALL (CONS (SPADCALL 'D (QREFELT $ 53)) |l|) (QREFELT $ 54))) 

(SDEFUN |FS-;indiff| ((|l| (|List| S)) ($ (|InputForm|)))
        (SPROG
         ((|d1| (|InputForm|)) (|si| (|InputForm|)) (|do_eval| (|Boolean|))
          (|ne| (S)) (|s| (|Symbol|)) (|ne1| (S))
          (|su| (|Union| (|Symbol|) "failed")) (|a3| (S)))
         (SEQ (LETT |a3| (SPADCALL |l| (QREFELT $ 55))) (LETT |do_eval| NIL)
              (LETT |s|
                    (SEQ (LETT |su| (SPADCALL |a3| (QREFELT $ 56)))
                         (EXIT
                          (COND ((QEQCAR |su| 0) (QCDR |su|))
                                (#1='T
                                 (SEQ (LETT |do_eval| 'T)
                                      (EXIT (SPADCALL (QREFELT $ 57)))))))))
              (LETT |ne|
                    (SPADCALL (|SPADfirst| |l|)
                              (SPADCALL (SPADCALL |l| (QREFELT $ 58))
                                        (QREFELT $ 28))
                              (COND (|do_eval| (SPADCALL |s| (QREFELT $ 38)))
                                    (#1# |a3|))
                              (QREFELT $ 59)))
              (COND
               ((NULL |do_eval|)
                (SEQ
                 (LETT |ne1|
                       (SPADCALL |ne| (SPADCALL |a3| (QREFELT $ 28))
                                 (SPADCALL |l| (QREFELT $ 58)) (QREFELT $ 59)))
                 (EXIT
                  (COND
                   ((NULL (SPADCALL (|SPADfirst| |l|) |ne1| (QREFELT $ 60)))
                    (SEQ (LETT |s| (SPADCALL (QREFELT $ 57)))
                         (LETT |ne|
                               (SPADCALL (|SPADfirst| |l|)
                                         (SPADCALL
                                          (SPADCALL |l| (QREFELT $ 58))
                                          (QREFELT $ 28))
                                         (SPADCALL |s| (QREFELT $ 38))
                                         (QREFELT $ 59)))
                         (EXIT (LETT |do_eval| 'T)))))))))
              (LETT |si|
                    (SPADCALL
                     (LIST (SPADCALL '|::| (QREFELT $ 53))
                           (SPADCALL |s| (QREFELT $ 53))
                           (SPADCALL '|Symbol| (QREFELT $ 53)))
                     (QREFELT $ 54)))
              (LETT |d1|
                    (|FS-;pint| (LIST (SPADCALL |ne| (QREFELT $ 61)) |si|) $))
              (EXIT
               (COND
                (|do_eval|
                 (SPADCALL
                  (LIST (SPADCALL '|eval| (QREFELT $ 53)) |d1| |si|
                        (SPADCALL (SPADCALL |l| (QREFELT $ 55))
                                  (QREFELT $ 61)))
                  (QREFELT $ 54)))
                (#1# |d1|)))))) 

(SDEFUN |FS-;eval;SBoSSS;15|
        ((|f| (S)) (|s| (|BasicOperator|)) (|g| (S)) (|x| (|Symbol|)) ($ (S)))
        (SPADCALL |f| (LIST |s|) (LIST |g|) |x| (QREFELT $ 63))) 

(SDEFUN |FS-;eval;SLLSS;16|
        ((|f| (S)) (|ls| (|List| (|BasicOperator|))) (|lg| (|List| S))
         (|x| (|Symbol|)) ($ (S)))
        (SPROG ((#1=#:G807 NIL) (|g| NIL) (#2=#:G806 NIL))
               (SEQ
                (SPADCALL |f| |ls|
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |g| NIL) (LETT #1# |lg|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |g| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS (SPADCALL |g| |x| (QREFELT $ 67))
                                              #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (QREFELT $ 70))))) 

(SDEFUN |FS-;variables;LL;17| ((|lx| (|List| S)) ($ (|List| (|Symbol|))))
        (SPROG
         ((|l| (|List| (|Symbol|))) (|s| (|Union| (|Symbol|) "failed"))
          (#1=#:G818 NIL) (|k| NIL))
         (SEQ (LETT |l| NIL)
              (SEQ (LETT |k| NIL) (LETT #1# (SPADCALL |lx| (QREFELT $ 75)))
                   G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |s| (SPADCALL |k| (QREFELT $ 30)))
                        (EXIT
                         (COND
                          ((QEQCAR |s| 0) (LETT |l| (CONS (QCDR |s|) |l|))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (NREVERSE |l|))))) 

(SDEFUN |FS-;variables;SL;18| ((|x| (S)) ($ (|List| (|Symbol|))))
        (SPADCALL (LIST |x|) (QREFELT $ 78))) 

(SDEFUN |FS-;retractIfCan;SU;19| ((|x| (S)) ($ (|Union| (|Symbol|) "failed")))
        (SPROG ((|k| (|Union| (|Kernel| S) "failed")))
               (SEQ (LETT |k| (SPADCALL |x| (QREFELT $ 81)))
                    (EXIT
                     (COND ((QEQCAR |k| 1) (CONS 1 "failed"))
                           ('T (SPADCALL (QCDR |k|) (QREFELT $ 30)))))))) 

(SDEFUN |FS-;characteristic;Nni;20| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 85))) 

(SDEFUN |FS-;coerce;KS;21| ((|k| (|Kernel| S)) ($ (S)))
        (SPADCALL (SPADCALL |k| (QREFELT $ 88)) (QREFELT $ 90))) 

(SDEFUN |FS-;symsub| ((|sy| (|Symbol|)) (|i| (|Integer|)) ($ (|Symbol|)))
        (SPADCALL (QREFELT $ 57))) 

(SDEFUN |FS-;numerator;2S;23| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 92)) (QREFELT $ 90))) 

(SDEFUN |FS-;eval;SSNniMS;24|
        ((|x| (S)) (|s| (|Symbol|)) (|n| (|NonNegativeInteger|))
         (|f| (|Mapping| S S)) ($ (S)))
        (SPROG NIL
               (SPADCALL |x| (LIST |s|) (LIST |n|)
                         (LIST (CONS #'|FS-;eval;SSNniMS;24!0| (VECTOR |f| $)))
                         (QREFELT $ 98)))) 

(SDEFUN |FS-;eval;SSNniMS;24!0| ((|y| NIL) ($$ NIL))
        (PROG ($ |f|)
          (LETT $ (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL (SPADCALL |y| (QREFELT $ 94)) |f|))))) 

(SDEFUN |FS-;eval;SSNniMS;25|
        ((|x| (S)) (|s| (|Symbol|)) (|n| (|NonNegativeInteger|))
         (|f| (|Mapping| S (|List| S))) ($ (S)))
        (SPADCALL |x| (LIST |s|) (LIST |n|) (LIST |f|) (QREFELT $ 98))) 

(SDEFUN |FS-;eval;SLLS;26|
        ((|x| (S)) (|l| (|List| (|Symbol|)))
         (|f| (|List| (|Mapping| S (|List| S)))) ($ (S)))
        (SPADCALL |x| |l| (SPADCALL (LENGTH |l|) 1 (QREFELT $ 101)) |f|
                  (QREFELT $ 98))) 

(SDEFUN |FS-;elt;BoLS;27|
        ((|op| (|BasicOperator|)) (|args| (|List| S)) ($ (S)))
        (SPROG ((#1=#:G867 NIL) (|x| (S)) (|od?| (|Boolean|)))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |op| (QREFELT $ 103))
                    (SEQ
                     (LETT |od?| (SPADCALL |op| (QREFELT $ 8) (QREFELT $ 41)))
                     (EXIT
                      (COND
                       ((OR |od?| (SPADCALL |op| (QREFELT $ 9) (QREFELT $ 41)))
                        (COND
                         ((SPADCALL
                           (SPADCALL
                            (SPADCALL (|SPADfirst| |args|) (QREFELT $ 92))
                            (QREFELT $ 104))
                           (|spadConstant| $ 105) (QREFELT $ 106))
                          (PROGN
                           (LETT #1#
                                 (SEQ
                                  (LETT |x|
                                        (SPADCALL |op|
                                                  (SPADCALL
                                                   (|SPADfirst| |args|)
                                                   (QREFELT $ 107))
                                                  (QREFELT $ 108)))
                                  (EXIT
                                   (COND (|od?| (SPADCALL |x| (QREFELT $ 107)))
                                         ('T |x|)))))
                           (GO #2=#:G865))))))))))
                  (EXIT (SPADCALL |op| |args| (QREFELT $ 110)))))
                #2# (EXIT #1#)))) 

(SDEFUN |FS-;eval;SLLLS;28|
        ((|x| (S)) (|s| (|List| (|Symbol|)))
         (|n| (|List| (|NonNegativeInteger|))) (|l| (|List| (|Mapping| S S)))
         ($ (S)))
        (SPROG ((#1=#:G873 NIL) (|f| NIL) (#2=#:G872 NIL))
               (SEQ
                (SPADCALL |x| |s| |n|
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |f| NIL) (LETT #1# |l|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |f| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS
                                         (CONS #'|FS-;eval;SLLLS;28!0|
                                               (VECTOR |f| $))
                                         #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (QREFELT $ 98))))) 

(SDEFUN |FS-;eval;SLLLS;28!0| ((|y| NIL) ($$ NIL))
        (PROG ($ |f|)
          (LETT $ (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL (SPADCALL |y| (QREFELT $ 94)) |f|))))) 

(SDEFUN |FS-;smprep|
        ((|lop| (|List| (|Symbol|))) (|lexp| (|List| (|NonNegativeInteger|)))
         (|lfunc| (|List| (|Mapping| S (|List| S))))
         (|p| (|SparseMultivariatePolynomial| R (|Kernel| S))) ($ (S)))
        (SPROG
         ((|q| (|SparseUnivariatePolynomial| S)) (|a| (S)) (|t2| (S))
          (|t1| (S))
          (|qr|
           (|Record| (|:| |quotient| (|NonNegativeInteger|))
                     (|:| |remainder| (|NonNegativeInteger|))))
          (|m| (|NonNegativeInteger|)) (|e| (|NonNegativeInteger|)) (|f| (S))
          (|n| (|Integer|)) (|g| (S)) (|arg| (|List| S)) (#1=#:G919 NIL)
          (#2=#:G918 NIL) (|op| (|BasicOperator|)) (|k| (|Kernel| S))
          (|v| (|Union| (|Kernel| S) "failed")))
         (SEQ (LETT |v| (SPADCALL |p| (QREFELT $ 114)))
              (EXIT
               (COND ((QEQCAR |v| 1) (SPADCALL |p| (QREFELT $ 90)))
                     (#3='T
                      (SEQ (LETT |k| (QCDR |v|))
                           (LETT |g|
                                 (SPADCALL
                                  (LETT |op| (SPADCALL |k| (QREFELT $ 44)))
                                  (LETT |arg|
                                        (PROGN
                                         (LETT #2# NIL)
                                         (SEQ
                                          (LETT #1#
                                                (SPADCALL |k| (QREFELT $ 46)))
                                          G190
                                          (COND
                                           ((OR (ATOM #1#)
                                                (PROGN
                                                 (LETT |a| (CAR #1#))
                                                 NIL))
                                            (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (LETT #2#
                                                  (CONS
                                                   (SPADCALL |a| |lop| |lexp|
                                                             |lfunc|
                                                             (QREFELT $ 98))
                                                   #2#))))
                                          (LETT #1# (CDR #1#)) (GO G190) G191
                                          (EXIT (NREVERSE #2#)))))
                                  (QREFELT $ 39)))
                           (LETT |q|
                                 (SPADCALL
                                  (CONS #'|FS-;smprep!0|
                                        (VECTOR |lfunc| |lexp| |lop| $))
                                  (SPADCALL |p| |k| (QREFELT $ 116))
                                  (QREFELT $ 121)))
                           (EXIT
                            (COND
                             ((<
                               (LETT |n|
                                     (SPADCALL (SPADCALL |op| (QREFELT $ 48))
                                               |lop| (QREFELT $ 123)))
                               (PROGN |lop| 1))
                              (SPADCALL |q| |g| (QREFELT $ 124)))
                             (#3#
                              (SEQ (LETT |a| (|spadConstant| $ 125))
                                   (LETT |f|
                                         (SPADCALL
                                          (SPADCALL |arg|
                                                    (SPADCALL |lfunc| |n|
                                                              (QREFELT $ 128)))
                                          |lop| |lexp| |lfunc| (QREFELT $ 98)))
                                   (LETT |e|
                                         (SPADCALL |lexp| |n| (QREFELT $ 129)))
                                   (SEQ G190
                                        (COND
                                         ((NULL
                                           (SPADCALL |q| (|spadConstant| $ 130)
                                                     (QREFELT $ 131)))
                                          (GO G191)))
                                        (SEQ
                                         (LETT |m|
                                               (SPADCALL |q| (QREFELT $ 132)))
                                         (LETT |qr| (DIVIDE2 |m| |e|))
                                         (LETT |t1|
                                               (SPADCALL |f| (QCAR |qr|)
                                                         (QREFELT $ 133)))
                                         (LETT |t2|
                                               (SPADCALL |g| (QCDR |qr|)
                                                         (QREFELT $ 133)))
                                         (LETT |a|
                                               (SPADCALL |a|
                                                         (SPADCALL
                                                          (SPADCALL
                                                           (SPADCALL |q|
                                                                     (QREFELT $
                                                                              134))
                                                           |t1|
                                                           (QREFELT $ 135))
                                                          |t2| (QREFELT $ 135))
                                                         (QREFELT $ 136)))
                                         (EXIT
                                          (LETT |q|
                                                (SPADCALL |q|
                                                          (QREFELT $ 137)))))
                                        NIL (GO G190) G191 (EXIT NIL))
                                   (EXIT |a|)))))))))))) 

(SDEFUN |FS-;smprep!0| ((|y| NIL) ($$ NIL))
        (PROG ($ |lop| |lexp| |lfunc|)
          (LETT $ (QREFELT $$ 3))
          (LETT |lop| (QREFELT $$ 2))
          (LETT |lexp| (QREFELT $$ 1))
          (LETT |lfunc| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |y| (QREFELT $ 90)) |lop| |lexp| |lfunc|
                      (QREFELT $ 98)))))) 

(SDEFUN |FS-;dispdiff|
        ((|l| (|List| S))
         ($
          (|Record| (|:| |name| (|OutputForm|)) (|:| |sub| (|OutputForm|))
                    (|:| |arg| (|List| (|OutputForm|)))
                    (|:| |orig_op| (|BasicOperator|))
                    (|:| |level| (|NonNegativeInteger|)))))
        (SPROG
         ((|d_name| (|OutputForm|)) (|dnu| (|Union| (|None|) "failed"))
          (|m| (|List| (|OutputForm|))) (#1=#:G937 NIL) (|x| NIL)
          (#2=#:G936 NIL) (|i| (|Integer|))
          (|rec|
           (|Record| (|:| |name| (|OutputForm|)) (|:| |sub| (|OutputForm|))
                     (|:| |arg| (|List| (|OutputForm|)))
                     (|:| |orig_op| (|BasicOperator|))
                     (|:| |level| (|NonNegativeInteger|))))
          (|a| (|List| S)) (|k| (|Kernel| S)) (|t| (|OutputForm|))
          (|s| (|OutputForm|)))
         (SEQ
          (LETT |s| (SPADCALL (SPADCALL |l| (QREFELT $ 58)) (QREFELT $ 139)))
          (LETT |t| (SPADCALL (SPADCALL |l| (QREFELT $ 55)) (QREFELT $ 139)))
          (LETT |a|
                (SPADCALL
                 (LETT |k| (SPADCALL (|SPADfirst| |l|) (QREFELT $ 28)))
                 (QREFELT $ 46)))
          (EXIT
           (COND
            ((SPADCALL |k| (QREFELT $ 15) (QREFELT $ 140))
             (SEQ (LETT |rec| (|FS-;dispdiff| |a| $))
                  (LETT |i| (SPADCALL |s| (QVELT |rec| 2) (QREFELT $ 142)))
                  (SPADCALL (QVELT |rec| 2) |i| |t| (QREFELT $ 143))
                  (EXIT
                   (VECTOR (QVELT |rec| 0)
                           (SPADCALL (QVELT |rec| 1)
                                     (SPADCALL (SPADCALL '|,| (QREFELT $ 144))
                                               (SPADCALL
                                                (- (+ |i| 1) (PROGN |a| 1))
                                                (QREFELT $ 146))
                                               (QREFELT $ 147))
                                     (QREFELT $ 147))
                           (QVELT |rec| 2) (QVELT |rec| 3)
                           (COND ((ZEROP (QVELT |rec| 4)) 0)
                                 (#3='T (+ (QVELT |rec| 4) 1)))))))
            (#3#
             (SEQ
              (LETT |i|
                    (SPADCALL (SPADCALL |l| (QREFELT $ 58)) |a|
                              (QREFELT $ 148)))
              (LETT |m|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |x| NIL) (LETT #1# |a|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS (SPADCALL |x| (QREFELT $ 139)) #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (SPADCALL |m| |i| |t| (QREFELT $ 143))
              (LETT |d_name|
                    (SEQ
                     (LETT |dnu|
                           (SPADCALL (SPADCALL |k| (QREFELT $ 44)) '|disp_name|
                                     (QREFELT $ 150)))
                     (EXIT
                      (COND ((QEQCAR |dnu| 0) (QCDR |dnu|))
                            (#3#
                             (SPADCALL
                              (SPADCALL (SPADCALL |k| (QREFELT $ 44))
                                        (QREFELT $ 48))
                              (QREFELT $ 144)))))))
              (EXIT
               (VECTOR |d_name|
                       (SPADCALL (SPADCALL '|,| (QREFELT $ 144))
                                 (SPADCALL (- (+ |i| 1) (PROGN |a| 1))
                                           (QREFELT $ 146))
                                 (QREFELT $ 147))
                       |m| (SPADCALL |k| (QREFELT $ 44))
                       (COND ((NULL (CDR |a|)) 1) (#3# 0))))))))))) 

(SDEFUN |FS-;ddiff| ((|l| (|List| S)) ($ (|OutputForm|)))
        (SPROG
         ((|f| (|Union| (|None|) "failed")) (|opname| (|OutputForm|))
          (|rec|
           (|Record| (|:| |name| (|OutputForm|)) (|:| |sub| (|OutputForm|))
                     (|:| |arg| (|List| (|OutputForm|)))
                     (|:| |orig_op| (|BasicOperator|))
                     (|:| |level| (|NonNegativeInteger|)))))
         (SEQ (LETT |rec| (|FS-;dispdiff| |l| $))
              (LETT |opname|
                    (COND
                     ((ZEROP (QVELT |rec| 4))
                      (SPADCALL (QVELT |rec| 0) (QVELT |rec| 1)
                                (QREFELT $ 151)))
                     (#1='T
                      (SPADCALL (QVELT |rec| 0) (QVELT |rec| 4)
                                (QREFELT $ 152)))))
              (LETT |f|
                    (SPADCALL (QVELT |rec| 3) '|%diffDisp| (QREFELT $ 150)))
              (EXIT
               (COND
                ((QEQCAR |f| 0)
                 (SPADCALL (CONS |opname| (QVELT |rec| 2)) (QCDR |f|)))
                (#1# (SPADCALL |opname| (QVELT |rec| 2) (QREFELT $ 153)))))))) 

(SDEFUN |FS-;encode_diff|
        ((|ker| (|Kernel| S)) (|nsub| (|List| (|Integer|))) (|args| (|List| S))
         (|nd| (|List| S)) ($ (S)))
        (SPROG
         ((|res| (S)) (#1=#:G967 NIL) (|kk| NIL) (#2=#:G963 NIL)
          (#3=#:G964 NIL) (#4=#:G965 NIL) (|pt| NIL) (#5=#:G966 NIL) (|dm| NIL)
          (|pts| (|List| S)) (#6=#:G961 NIL) (#7=#:G962 NIL)
          (|nargs| (|List| S)) (|li| (|List| (|Integer|)))
          (|lk| (|List| (|Integer|))) (|k| (|Integer|)) (|i| #8=(|Integer|))
          (|ii| #8#))
         (SEQ (LETT |li| NIL) (LETT |lk| NIL) (LETT |i| (|SPADfirst| |nsub|))
              (LETT |k| 1) (LETT |nsub| (CDR |nsub|))
              (SEQ G190 (COND ((NULL (NULL (NULL |nsub|))) (GO G191)))
                   (SEQ (LETT |ii| (|SPADfirst| |nsub|))
                        (LETT |nsub| (CDR |nsub|))
                        (EXIT
                         (COND ((EQL |ii| |i|) (LETT |k| (+ |k| 1)))
                               ('T
                                (SEQ (LETT |lk| (CONS |k| |lk|))
                                     (LETT |li| (CONS |i| |li|))
                                     (LETT |i| |ii|) (EXIT (LETT |k| 1)))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |lk| (CONS |k| |lk|)) (LETT |li| (CONS |i| |li|))
              (LETT |nargs| (SPADCALL |args| (QREFELT $ 154))) (LETT |pts| NIL)
              (SEQ (LETT |dm| NIL) (LETT #7# |nd|) (LETT #6# (REVERSE |li|))
                   G190
                   (COND
                    ((OR (ATOM #6#) (PROGN (LETT |i| (CAR #6#)) NIL) (ATOM #7#)
                         (PROGN (LETT |dm| (CAR #7#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |pts|
                          (CONS (SPADCALL |nargs| |i| (QREFELT $ 155)) |pts|))
                    (EXIT (SPADCALL |nargs| |i| |dm| (QREFELT $ 156))))
                   (LETT #6# (PROG1 (CDR #6#) (LETT #7# (CDR #7#)))) (GO G190)
                   G191 (EXIT NIL))
              (LETT |res|
                    (SPADCALL (SPADCALL |ker| (QREFELT $ 44)) |nargs|
                              (QREFELT $ 47)))
              (SEQ (LETT |dm| NIL) (LETT #5# (REVERSE |nd|)) (LETT |pt| NIL)
                   (LETT #4# |pts|) (LETT #3# |lk|) (LETT #2# |li|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |i| (CAR #2#)) NIL) (ATOM #3#)
                         (PROGN (LETT |k| (CAR #3#)) NIL) (ATOM #4#)
                         (PROGN (LETT |pt| (CAR #4#)) NIL) (ATOM #5#)
                         (PROGN (LETT |dm| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ
                    (SEQ (LETT |kk| 2) (LETT #1# |k|) G190
                         (COND ((|greater_SI| |kk| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |res|
                                 (SPADCALL (QREFELT $ 15)
                                           (LIST |res| |dm| |dm|)
                                           (QREFELT $ 47)))))
                         (LETT |kk| (|inc_SI| |kk|)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (LETT |res|
                           (SPADCALL (QREFELT $ 15) (LIST |res| |dm| |pt|)
                                     (QREFELT $ 47)))))
                   (LETT #2#
                         (PROG1 (CDR #2#)
                           (LETT #3#
                                 (PROG1 (CDR #3#)
                                   (LETT #4#
                                         (PROG1 (CDR #4#)
                                           (LETT #5# (CDR #5#))))))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |FS-;insert_sub|
        ((|lsub| (|List| (|Integer|))) (|j| (|Integer|))
         ($ (|List| (|Integer|))))
        (SPROG
         ((|nsub| (|List| (|Integer|))) (|to_insert| (|Boolean|))
          (#1=#:G974 NIL) (|i| NIL))
         (SEQ (LETT |nsub| NIL) (LETT |to_insert| 'T)
              (SEQ (LETT |i| NIL) (LETT #1# |lsub|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (COND
                     (|to_insert|
                      (COND
                       ((NULL (> |i| |j|))
                        (SEQ (LETT |nsub| (CONS |j| |nsub|))
                             (EXIT (LETT |to_insert| NIL)))))))
                    (EXIT (LETT |nsub| (CONS |i| |nsub|))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (COND (|to_insert| (LETT |nsub| (CONS |j| |nsub|))))
              (EXIT (NREVERSE |nsub|))))) 

(SDEFUN |FS-;pos_diff|
        ((|l| (|List| S))
         (|r1|
          (|Record| (|:| |orig_k| (|Kernel| S))
                    (|:| |sub| (|List| (|Integer|))) (|:| |oarg| (|List| S))
                    (|:| |arg| (|List| S)) (|:| |dummies| #1=(|List| S))))
         (|i| (|Integer|)) ($ (S)))
        (SPROG
         ((|nd| #1#) (|dm| (S)) (|nd2| (|List| S)) (|nd1| (|List| S))
          (|k| (|NonNegativeInteger|)) (#2=#:G982 NIL) (#3=#:G983 NIL)
          (|j| NIL) (|ii| (|Integer|)) (|nsub| (|List| (|Integer|))))
         (SEQ (LETT |nsub| (|FS-;insert_sub| (QVELT |r1| 1) |i| $))
              (LETT |nd| (QVELT |r1| 4))
              (COND
               ((NULL (SPADCALL |i| (QVELT |r1| 1) (QREFELT $ 158)))
                (SEQ (LETT |k| 0) (LETT |ii| (|SPADfirst| |nsub|))
                     (SEQ
                      (EXIT
                       (SEQ (LETT |j| NIL) (LETT #3# |nsub|) G190
                            (COND
                             ((OR (ATOM #3#) (PROGN (LETT |j| (CAR #3#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (COND
                               ((EQL |i| |j|)
                                (PROGN (LETT #2# |$NoValue|) (GO #4=#:G977)))
                               ((NULL (EQL |ii| |j|)) (LETT |k| (+ |k| 1))))))
                            (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                      #4# (EXIT #2#))
                     (LETT |nd1| (SPADCALL |nd| |k| (QREFELT $ 159)))
                     (LETT |nd2| (SPADCALL |nd| |k| (QREFELT $ 160)))
                     (LETT |dm|
                           (SPADCALL (SPADCALL (QREFELT $ 57)) (QREFELT $ 38)))
                     (EXIT
                      (LETT |nd|
                            (SPADCALL |nd1| (CONS |dm| |nd2|)
                                      (QREFELT $ 161)))))))
              (EXIT
               (|FS-;encode_diff| (QVELT |r1| 0) |nsub| (QVELT |r1| 3) |nd|
                $))))) 

(SDEFUN |FS-;diffdiff| ((|l| (|List| S)) (|x| (|Symbol|)) ($ (S)))
        (SPROG
         ((|res| (S)) (|db| (S)) (#1=#:G990 NIL) (|i| NIL) (#2=#:G991 NIL)
          (|b| NIL) (|args| #3=(|List| S))
          (|r1|
           (|Record| (|:| |orig_k| (|Kernel| S))
                     (|:| |sub| (|List| (|Integer|))) (|:| |oarg| (|List| S))
                     (|:| |arg| #3#) (|:| |dummies| (|List| S)))))
         (SEQ (LETT |r1| (|FS-;decode_diff| |l| $))
              (LETT |args| (QVELT |r1| 3)) (LETT |res| (|spadConstant| $ 125))
              (SEQ (LETT |b| NIL) (LETT #2# |args|) (LETT |i| (PROGN |args| 1))
                   (LETT #1# (LENGTH |args|)) G190
                   (COND
                    ((OR (> |i| #1#) (ATOM #2#)
                         (PROGN (LETT |b| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |db| (SPADCALL |b| |x| (QREFELT $ 162)))
                        (EXIT
                         (COND
                          ((SPADCALL |db| (|spadConstant| $ 125)
                                     (QREFELT $ 60))
                           "iterate")
                          ('T
                           (LETT |res|
                                 (SPADCALL |res|
                                           (SPADCALL |db|
                                                     (|FS-;pos_diff| |l| |r1|
                                                      |i| $)
                                                     (QREFELT $ 135))
                                           (QREFELT $ 136)))))))
                   (LETT |i| (PROG1 (+ |i| 1) (LETT #2# (CDR #2#)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |FS-;dfeval| ((|l| (|List| S)) (|g| (|Kernel| S)) ($ (S)))
        (SPROG ((#1=#:G993 NIL))
               (SPADCALL
                (SPADCALL (|SPADfirst| |l|)
                          (PROG2 (LETT #1# (SPADCALL |g| (QREFELT $ 30)))
                              (QCDR #1#)
                            (|check_union2| (QEQCAR #1# 0) (|Symbol|)
                                            (|Union| (|Symbol|) "failed") #1#))
                          (QREFELT $ 162))
                |g| (SPADCALL |l| (QREFELT $ 55)) (QREFELT $ 59)))) 

(SDEFUN |FS-;diffEval| ((|l| (|List| S)) ($ (S)))
        (SPROG
         ((|d| (|List| (|Mapping| S (|List| S)))) (|n| (|Integer|))
          (|nl| (|List| S)) (|ss| (S)) (|dumm| (S))
          (|ud| (|Union| (|List| (|Mapping| S (|List| S))) "failed"))
          (|op| (|BasicOperator|)) (#1=#:G1026 NIL) (|k| (|Kernel| S))
          (|u| (|Union| (|Kernel| S) "failed")) (|g| (|Kernel| S)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |g| (SPADCALL (SPADCALL |l| (QREFELT $ 58)) (QREFELT $ 28)))
            (SEQ (LETT |u| (SPADCALL (|SPADfirst| |l|) (QREFELT $ 81)))
                 (EXIT
                  (COND
                   ((QEQCAR |u| 1)
                    (PROGN
                     (LETT #1# (|FS-;dfeval| |l| |g| $))
                     (GO #2=#:G1024)))
                   ((QEQCAR |u| 0)
                    (COND
                     ((QEQCAR (SPADCALL (LETT |k| (QCDR |u|)) (QREFELT $ 30))
                              0)
                      (PROGN
                       (LETT #1# (|FS-;dfeval| |l| |g| $))
                       (GO #2#))))))))
            (LETT |op| (SPADCALL |k| (QREFELT $ 44)))
            (LETT |ud| (SPADCALL |op| (QREFELT $ 165)))
            (EXIT
             (COND
              ((QEQCAR |ud| 1)
               (SEQ
                (LETT |dumm|
                      (SPADCALL (|FS-;symsub| (QREFELT $ 83) 1 $)
                                (QREFELT $ 38)))
                (LETT |ss|
                      (SPADCALL (SPADCALL |l| 1 (QREFELT $ 155))
                                (SPADCALL (SPADCALL |l| 2 (QREFELT $ 155))
                                          |dumm| (QREFELT $ 167))
                                (QREFELT $ 169)))
                (LETT |nl| (LIST |ss| |dumm| (SPADCALL |l| 3 (QREFELT $ 155))))
                (EXIT (SPADCALL (QREFELT $ 15) |nl| (QREFELT $ 47)))))
              ((<
                (LETT |n|
                      (SPADCALL (SPADCALL |l| (QREFELT $ 58))
                                (SPADCALL |k| (QREFELT $ 46)) (QREFELT $ 148)))
                (PROGN |l| 1))
               (|FS-;dfeval| |l| |g| $))
              ('T
               (SEQ (LETT |d| (QCDR |ud|))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (SPADCALL |k| (QREFELT $ 46))
                                (SPADCALL |d| |n| (QREFELT $ 128)))
                      |g| (SPADCALL |l| (QREFELT $ 55)) (QREFELT $ 59)))))))))
          #2# (EXIT #1#)))) 

(SDEFUN |FS-;diffArg|
        ((|l| (|List| S)) (|op| (|BasicOperator|)) (|i| (|NonNegativeInteger|))
         ($ (|List| S)))
        (SPROG ((|g| (S)) (|z| (|List| S)) (|n| (|Integer|)))
               (SEQ (LETT |n| (+ (- |i| 1) (PROGN |l| 1)))
                    (LETT |z| (SPADCALL |l| (QREFELT $ 154)))
                    (SPADCALL |z| |n|
                              (LETT |g|
                                    (SPADCALL
                                     (|FS-;symsub| (QREFELT $ 83) |n| $)
                                     (QREFELT $ 38)))
                              (QREFELT $ 156))
                    (EXIT
                     (LIST (SPADCALL |op| |z| (QREFELT $ 47)) |g|
                           (SPADCALL |l| |n| (QREFELT $ 155))))))) 

(SDEFUN |FS-;opderiv|
        ((|op| (|BasicOperator|)) (|n| (|NonNegativeInteger|))
         ($ (|List| (|Mapping| S (|List| S)))))
        (SPROG ((#1=#:G1038 NIL) (|i| NIL) (#2=#:G1037 NIL) (|g| (S)))
               (SEQ
                (COND
                 ((EQL |n| 1)
                  (SEQ
                   (LETT |g|
                         (SPADCALL (|FS-;symsub| (QREFELT $ 83) |n| $)
                                   (QREFELT $ 38)))
                   (EXIT
                    (LIST
                     (CONS #'|FS-;opderiv!0|
                           (VECTOR $ |g| |op| (QREFELT $ 15)))))))
                 ('T
                  (PROGN
                   (LETT #2# NIL)
                   (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                        (COND ((|greater_SI| |i| #1#) (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #2#
                                (CONS
                                 (CONS #'|FS-;opderiv!1|
                                       (VECTOR $ |i| |op| (QREFELT $ 15)))
                                 #2#))))
                        (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                        (EXIT (NREVERSE #2#))))))))) 

(SDEFUN |FS-;opderiv!1| ((|x| NIL) ($$ NIL))
        (PROG (|opdiff| |op| |i| $)
          (LETT |opdiff| (QREFELT $$ 3))
          (LETT |op| (QREFELT $$ 2))
          (LETT |i| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |opdiff| (|FS-;diffArg| |x| |op| |i| $)
                      (QREFELT $ 47)))))) 

(SDEFUN |FS-;opderiv!0| ((|x| NIL) ($$ NIL))
        (PROG (|opdiff| |op| |g| $)
          (LETT |opdiff| (QREFELT $$ 3))
          (LETT |op| (QREFELT $$ 2))
          (LETT |g| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |opdiff|
                      (LIST (SPADCALL |op| |g| (QREFELT $ 170)) |g|
                            (SPADCALL |x| (QREFELT $ 94)))
                      (QREFELT $ 47)))))) 

(SDEFUN |FS-;kgrad| ((|k| (|Kernel| S)) ($ (|List| (|Mapping| S (|List| S)))))
        (SPROG
         ((|grad| (|List| (|Mapping| S (|List| S))))
          (|u| (|Union| (|List| (|Mapping| S (|List| S))) "failed"))
          (|op| (|BasicOperator|)) (|n| (|NonNegativeInteger|))
          (|args| (|List| S)))
         (SEQ
          (COND
           ((ZEROP
             (LETT |n| (LENGTH (LETT |args| (SPADCALL |k| (QREFELT $ 46))))))
            NIL)
           (#1='T
            (SEQ (LETT |op| (SPADCALL |k| (QREFELT $ 44)))
                 (LETT |grad|
                       (SEQ (LETT |u| (SPADCALL |op| (QREFELT $ 165)))
                            (EXIT
                             (COND ((QEQCAR |u| 1) (|FS-;opderiv| |op| |n| $))
                                   (#1# (QCDR |u|))))))
                 (EXIT
                  (COND
                   ((SPADCALL (LENGTH |grad|) |n| (QREFELT $ 171))
                    (|FS-;opderiv| |op| |n| $))
                   (#1# |grad|))))))))) 

(SDEFUN |FS-;kerderiv| ((|k| (|Kernel| S)) (|x| (|Symbol|)) ($ (S)))
        (SPROG
         ((#1=#:G1057 NIL) (#2=#:G1056 (S)) (#3=#:G1058 (S)) (|dyx| (S))
          (#4=#:G1062 NIL) (|g| NIL) (#5=#:G1063 NIL) (|y| NIL)
          (|fn| (|Union| (|None|) "failed")) (|ak| (|List| S))
          (|v| (|Union| (|Symbol|) "failed")))
         (SEQ (LETT |v| (SPADCALL |k| (QREFELT $ 30)))
              (EXIT
               (COND
                ((QEQCAR |v| 0)
                 (COND ((EQUAL (QCDR |v|) |x|) (|spadConstant| $ 145))
                       (#6='T (|spadConstant| $ 125))))
                (#6#
                 (SEQ (LETT |ak| (SPADCALL |k| (QREFELT $ 46)))
                      (LETT |fn|
                            (SPADCALL (SPADCALL |k| (QREFELT $ 44))
                                      (QREFELT $ 10) (QREFELT $ 150)))
                      (EXIT
                       (COND ((QEQCAR |fn| 0) (SPADCALL |ak| |x| (QCDR |fn|)))
                             (#6#
                              (PROGN
                               (LETT #1# NIL)
                               (SEQ (LETT |y| NIL) (LETT #5# |ak|)
                                    (LETT |g| NIL)
                                    (LETT #4# (|FS-;kgrad| |k| $)) G190
                                    (COND
                                     ((OR (ATOM #4#)
                                          (PROGN (LETT |g| (CAR #4#)) NIL)
                                          (ATOM #5#)
                                          (PROGN (LETT |y| (CAR #5#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((SPADCALL
                                         (LETT |dyx|
                                               (SPADCALL |y| |x|
                                                         (QREFELT $ 162)))
                                         (|spadConstant| $ 125)
                                         (QREFELT $ 172))
                                        (PROGN
                                         (LETT #3#
                                               (SPADCALL (SPADCALL |ak| |g|)
                                                         |dyx|
                                                         (QREFELT $ 135)))
                                         (COND
                                          (#1#
                                           (LETT #2#
                                                 (SPADCALL #2# #3#
                                                           (QREFELT $ 136))))
                                          ('T
                                           (PROGN
                                            (LETT #2# #3#)
                                            (LETT #1# 'T)))))))))
                                    (LETT #4#
                                          (PROG1 (CDR #4#)
                                            (LETT #5# (CDR #5#))))
                                    (GO G190) G191 (EXIT NIL))
                               (COND (#1# #2#)
                                     (#6# (|spadConstant| $ 125)))))))))))))) 

(SDEFUN |FS-;smpderiv|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| S))) (|x| (|Symbol|))
         ($ (S)))
        (SPROG
         ((#1=#:G1093 NIL) (#2=#:G1092 (S)) (#3=#:G1094 (S)) (#4=#:G1096 NIL)
          (|k| NIL))
         (SEQ
          (SPADCALL
           (SPADCALL
            (SPADCALL (CONS #'|FS-;smpderiv!0| (VECTOR |x| $)) |p|
                      (QREFELT $ 178))
            (QREFELT $ 90))
           (PROGN
            (LETT #1# NIL)
            (SEQ (LETT |k| NIL) (LETT #4# (SPADCALL |p| (QREFELT $ 180))) G190
                 (COND
                  ((OR (ATOM #4#) (PROGN (LETT |k| (CAR #4#)) NIL)) (GO G191)))
                 (SEQ
                  (EXIT
                   (PROGN
                    (LETT #3#
                          (SPADCALL
                           (SPADCALL (SPADCALL |p| |k| (QREFELT $ 181))
                                     (QREFELT $ 90))
                           (|FS-;kerderiv| |k| |x| $) (QREFELT $ 135)))
                    (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 136))))
                          ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                 (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
            (COND (#1# #2#) ('T (|spadConstant| $ 125))))
           (QREFELT $ 136))))) 

(SDEFUN |FS-;smpderiv!0| ((|s| NIL) ($$ NIL))
        (PROG ($ |x|)
          (LETT $ (QREFELT $$ 1))
          (LETT |x| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL (SPADCALL |s| (QREFELT $ 174)) |x| (QREFELT $ 175))
             (QREFELT $ 176)))))) 

(SDEFUN |FS-;coerce;PS;43| ((|p| (|Polynomial| R)) ($ (S)))
        (SPADCALL (ELT $ 38) (ELT $ 182) |p| (QREFELT $ 186))) 

(SDEFUN |FS-;worse?| ((|k1| (|Kernel| S)) (|k2| (|Kernel| S)) ($ (|Boolean|)))
        (SPROG ((|u| (|Union| (|Boolean|) "failed")))
               (SEQ
                (LETT |u|
                      (SPADCALL
                       (SPADCALL (SPADCALL |k1| (QREFELT $ 44)) (QREFELT $ 48))
                       (SPADCALL (SPADCALL |k2| (QREFELT $ 44)) (QREFELT $ 48))
                       (QREFELT $ 190)))
                (EXIT
                 (COND ((QEQCAR |u| 1) (SPADCALL |k1| |k2| (QREFELT $ 191)))
                       ('T (QCDR |u|))))))) 

(SDEFUN |FS-;bestKernel| ((|l| (|List| (|Kernel| S))) ($ (|Kernel| S)))
        (SPROG ((|a| (|Kernel| S)))
               (SEQ
                (COND ((NULL (CDR |l|)) (|SPADfirst| |l|))
                      (#1='T
                       (SEQ (LETT |a| (|FS-;bestKernel| (CDR |l|) $))
                            (EXIT
                             (COND ((|FS-;worse?| (|SPADfirst| |l|) |a| $) |a|)
                                   (#1# (|SPADfirst| |l|)))))))))) 

(SDEFUN |FS-;smp2O|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| S)))
         ($ (|OutputForm|)))
        (SPROG ((|a| (|Kernel| S)) (#1=#:G1110 NIL) (|r| (|Union| R "failed")))
               (SEQ (LETT |r| (SPADCALL |p| (QREFELT $ 192)))
                    (EXIT
                     (COND
                      ((QEQCAR |r| 0) (SPADCALL (QCDR |r|) (QREFELT $ 193)))
                      (#2='T
                       (SEQ
                        (LETT |a|
                              (COND
                               ((SPADCALL (QREFELT $ 194))
                                (|FS-;bestKernel|
                                 (SPADCALL |p| (QREFELT $ 180)) $))
                               (#2#
                                (PROG2
                                    (LETT #1# (SPADCALL |p| (QREFELT $ 114)))
                                    (QCDR #1#)
                                  (|check_union2| (QEQCAR #1# 0)
                                                  (|Kernel| (QREFELT $ 6))
                                                  (|Union|
                                                   (|Kernel| (QREFELT $ 6))
                                                   "failed")
                                                  #1#)))))
                        (EXIT
                         (SPADCALL
                          (SPADCALL (ELT $ 90)
                                    (SPADCALL |p| |a| (QREFELT $ 116))
                                    (QREFELT $ 121))
                          (SPADCALL |a| (QREFELT $ 195))
                          (QREFELT $ 196)))))))))) 

(SDEFUN |FS-;smpsubst|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| S)))
         (|lk| (|List| (|Kernel| S))) (|lv| (|List| S)) ($ (S)))
        (SPROG NIL
               (SPADCALL (CONS #'|FS-;smpsubst!2| (VECTOR $ |lv| |lk|))
                         (ELT $ 182) |p| (QREFELT $ 202)))) 

(SDEFUN |FS-;smpsubst!2| ((|x| NIL) ($$ NIL))
        (PROG (|lk| |lv| $)
          (LETT |lk| (QREFELT $$ 2))
          (LETT |lv| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL |lk| |lv| |x|
                             (|FS-;notfound|
                              (CONS #'|FS-;smpsubst!1| (VECTOR |lk| |lv| $))
                              |lk| $)
                             (QREFELT $ 200))))))) 

(SDEFUN |FS-;smpsubst!1| ((|z| NIL) ($$ NIL))
        (PROG ($ |lv| |lk|)
          (LETT $ (QREFELT $$ 2))
          (LETT |lv| (QREFELT $$ 1))
          (LETT |lk| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (|FS-;subs| (CONS #'|FS-;smpsubst!0| (VECTOR $ |lv| |lk|))
                    |z| $)))))) 

(SDEFUN |FS-;smpsubst!0| ((|s| NIL) ($$ NIL))
        (PROG (|lk| |lv| $)
          (LETT |lk| (QREFELT $$ 2))
          (LETT |lv| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |s| |lk| |lv| (QREFELT $ 197)))))) 

(SDEFUN |FS-;smpeval|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| S)))
         (|lk| (|List| (|Kernel| S))) (|lv| (|List| S)) ($ (S)))
        (SPROG NIL
               (SPADCALL (CONS #'|FS-;smpeval!2| (VECTOR $ |lv| |lk|))
                         (ELT $ 182) |p| (QREFELT $ 202)))) 

(SDEFUN |FS-;smpeval!2| ((|x| NIL) ($$ NIL))
        (PROG (|lk| |lv| $)
          (LETT |lk| (QREFELT $$ 2))
          (LETT |lv| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL |lk| |lv| |x|
                             (|FS-;notfound|
                              (CONS #'|FS-;smpeval!1| (VECTOR |lk| |lv| $))
                              |lk| $)
                             (QREFELT $ 200))))))) 

(SDEFUN |FS-;smpeval!1| ((|z| NIL) ($$ NIL))
        (PROG ($ |lv| |lk|)
          (LETT $ (QREFELT $$ 2))
          (LETT |lv| (QREFELT $$ 1))
          (LETT |lk| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL (CONS #'|FS-;smpeval!0| (VECTOR $ |lv| |lk|)) |z|
                             (QREFELT $ 204))))))) 

(SDEFUN |FS-;smpeval!0| ((|s| NIL) ($$ NIL))
        (PROG (|lk| |lv| $)
          (LETT |lk| (QREFELT $$ 2))
          (LETT |lv| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |s| |lk| |lv| (QREFELT $ 203)))))) 

(SDEFUN |FS-;notfound|
        ((|fn| (|Mapping| S (|Kernel| S))) (|lk| (|List| (|Kernel| S)))
         ($ (|Mapping| S (|Kernel| S))))
        (SPROG NIL (CONS #'|FS-;notfound!0| (VECTOR |fn| |lk| $)))) 

(SDEFUN |FS-;notfound!0| ((|k| NIL) ($$ NIL))
        (PROG ($ |lk| |fn|)
          (LETT $ (QREFELT $$ 2))
          (LETT |lk| (QREFELT $$ 1))
          (LETT |fn| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|f| NIL))
                   (COND
                    ((SPADCALL
                      (SPADCALL
                       (SPADCALL (LETT |f| (SPADCALL |k| (QREFELT $ 26)))
                                 (QREFELT $ 205))
                       |lk| (QREFELT $ 206))
                      (QREFELT $ 207))
                     |f|)
                    ('T (SPADCALL |k| |fn|)))))))) 

(SDEFUN |FS-;smpret|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| S)))
         ($ (|Union| (|Polynomial| R) "failed")))
        (SPROG
         ((#1=#:G1164 NIL) (#2=#:G1163 #3=(|Boolean|)) (#4=#:G1165 #3#)
          (#5=#:G1172 NIL) (|k| NIL))
         (SEQ
          (COND
           ((PROGN
             (LETT #1# NIL)
             (SEQ (LETT |k| NIL) (LETT #5# (SPADCALL |p| (QREFELT $ 180))) G190
                  (COND
                   ((OR (ATOM #5#) (PROGN (LETT |k| (CAR #5#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (PROGN
                     (LETT #4# (QEQCAR (SPADCALL |k| (QREFELT $ 30)) 1))
                     (COND (#1# (LETT #2# (COND (#2# 'T) ('T #4#))))
                           ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                  (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
             (COND (#1# #2#) (#6='T NIL)))
            (CONS 1 "failed"))
           (#6#
            (CONS 0
                  (SPADCALL (CONS #'|FS-;smpret!0| $) (ELT $ 174) |p|
                            (QREFELT $ 212)))))))) 

(SDEFUN |FS-;smpret!0| ((|x| NIL) ($ NIL))
        (SPROG ((#1=#:G1167 NIL))
               (SPADCALL
                (PROG2 (LETT #1# (SPADCALL |x| (QREFELT $ 30)))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0) (|Symbol|)
                                  (|Union| (|Symbol|) "failed") #1#))
                (QREFELT $ 208)))) 

(SDEFUN |FS-;isExpt;SBoU;51|
        ((|x| (S)) (|op| (|BasicOperator|))
         ($
          (|Union|
           (|Record| (|:| |var| #1=(|Kernel| S)) (|:| |exponent| (|Integer|)))
           "failed")))
        (SPROG
         ((|v| #1#)
          (|u|
           (|Union|
            (|Record| (|:| |var| (|Kernel| S)) (|:| |exponent| (|Integer|)))
            "failed")))
         (SEQ (LETT |u| (SPADCALL |x| (QREFELT $ 215)))
              (EXIT
               (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                     ('T
                      (SEQ (LETT |v| (QCAR (QCDR |u|)))
                           (COND
                            ((SPADCALL |v| |op| (QREFELT $ 140))
                             (COND
                              ((EQL (LENGTH (SPADCALL |v| (QREFELT $ 46))) 1)
                               (EXIT |u|)))))
                           (EXIT (CONS 1 "failed"))))))))) 

(SDEFUN |FS-;isExpt;SSU;52|
        ((|x| (S)) (|sy| (|Symbol|))
         ($
          (|Union|
           (|Record| (|:| |var| #1=(|Kernel| S)) (|:| |exponent| (|Integer|)))
           "failed")))
        (SPROG
         ((|v| #1#)
          (|u|
           (|Union|
            (|Record| (|:| |var| (|Kernel| S)) (|:| |exponent| (|Integer|)))
            "failed")))
         (SEQ (LETT |u| (SPADCALL |x| (QREFELT $ 215)))
              (EXIT
               (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                     ('T
                      (SEQ (LETT |v| (QCAR (QCDR |u|)))
                           (COND
                            ((SPADCALL |v| |sy| (QREFELT $ 217))
                             (COND
                              ((EQL (LENGTH (SPADCALL |v| (QREFELT $ 46))) 1)
                               (EXIT |u|)))))
                           (EXIT (CONS 1 "failed"))))))))) 

(SDEFUN |FS-;smpIsMult|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| S)))
         ($
          (|Union| (|Record| (|:| |coef| (|Integer|)) (|:| |var| (|Kernel| S)))
                   "failed")))
        (SPROG
         ((#1=#:G1211 NIL) (|n| (|Union| (|Integer|) "failed"))
          (|r| (|Union| R "failed"))
          (|q|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| R (|Kernel| S))))
          (|u| (|Union| (|Kernel| S) "failed")))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |u| (SPADCALL |p| (QREFELT $ 114)))
                 (EXIT
                  (COND
                   ((QEQCAR |u| 0)
                    (COND
                     ((EQL
                       (SPADCALL
                        (LETT |q| (SPADCALL |p| (QCDR |u|) (QREFELT $ 116)))
                        (QREFELT $ 219))
                       1)
                      (COND
                       ((SPADCALL
                         (SPADCALL (SPADCALL |q| (QREFELT $ 220))
                                   (QREFELT $ 221))
                         (QREFELT $ 222))
                        (SEQ
                         (LETT |r|
                               (SPADCALL (SPADCALL |q| (QREFELT $ 221))
                                         (QREFELT $ 192)))
                         (EXIT
                          (COND
                           ((QEQCAR |r| 0)
                            (SEQ
                             (LETT |n| (SPADCALL (QCDR |r|) (QREFELT $ 224)))
                             (EXIT
                              (COND
                               ((QEQCAR |n| 0)
                                (PROGN
                                 (LETT #1#
                                       (CONS 0 (CONS (QCDR |n|) (QCDR |u|))))
                                 (GO #2=#:G1209))))))))))))))))))
            (EXIT (CONS 1 "failed"))))
          #2# (EXIT #1#)))) 

(PUT '|FS-;debugA| '|SPADreplace| '(XLAM (|a1| |a2| |t|) |t|)) 

(SDEFUN |FS-;debugA|
        ((|a1| (|List| S)) (|a2| (|List| S)) (|t| (|Boolean|)) ($ (|Boolean|)))
        |t|) 

(SDEFUN |FS-;decode_diff|
        ((|l| (|List| S))
         ($
          #1=(|Record| (|:| |orig_k| (|Kernel| S))
                       (|:| |sub| (|List| (|Integer|))) (|:| |oarg| (|List| S))
                       (|:| |arg| (|List| S)) (|:| |dummies| #2=(|List| S)))))
        (SPROG
         ((|a1| (|List| S)) (|i| (|Integer|)) (|nd| #2#) (|rec| #1#)
          (|a| (|List| S)) (|k| (|Kernel| S)) (|pt| (S)) (|da| (S)))
         (SEQ (LETT |da| (SPADCALL |l| (QREFELT $ 58)))
              (LETT |pt| (SPADCALL |l| (QREFELT $ 55)))
              (LETT |a|
                    (SPADCALL
                     (LETT |k| (SPADCALL (|SPADfirst| |l|) (QREFELT $ 28)))
                     (QREFELT $ 46)))
              (EXIT
               (COND
                ((SPADCALL |k| (QREFELT $ 15) (QREFELT $ 140))
                 (SEQ (LETT |rec| (|FS-;decode_diff| |a| $))
                      (LETT |i|
                            (SPADCALL |da| (QVELT |rec| 3) (QREFELT $ 148)))
                      (SPADCALL (QVELT |rec| 3) |i| |pt| (QREFELT $ 156))
                      (LETT |nd| (QVELT |rec| 4))
                      (COND
                       ((NULL (SPADCALL |i| (QVELT |rec| 1) (QREFELT $ 158)))
                        (LETT |nd| (CONS |da| |nd|))))
                      (EXIT
                       (VECTOR (QVELT |rec| 0) (CONS |i| (QVELT |rec| 1))
                               (QVELT |rec| 2) (QVELT |rec| 3) |nd|))))
                ('T
                 (SEQ (LETT |i| (SPADCALL |da| |a| (QREFELT $ 148)))
                      (LETT |a1| (SPADCALL |a| (QREFELT $ 154)))
                      (SPADCALL |a1| |i| |pt| (QREFELT $ 156))
                      (EXIT (VECTOR |k| (LIST |i|) |a| |a1| (LIST |da|)))))))))) 

(SDEFUN |FS-;equaldiff|
        ((|k1| (|Kernel| S)) (|k2| (|Kernel| S)) ($ (|Boolean|)))
        (SPROG
         ((|sk1| (S)) (|ok1| (S)) (|od| (|List| (|Kernel| S))) (#1=#:G1232 NIL)
          (|dk| NIL) (#2=#:G1231 NIL)
          (|r2|
           #3=(|Record| (|:| |orig_k| (|Kernel| S))
                        (|:| |sub| (|List| (|Integer|)))
                        (|:| |oarg| (|List| S)) (|:| |arg| (|List| S))
                        (|:| |dummies| (|List| S))))
          (|r1| #3#) (|res| (|Boolean|)) (|a2| #4=(|List| S)) (|a1| #4#))
         (SEQ (LETT |a1| (SPADCALL |k1| (QREFELT $ 46)))
              (LETT |a2| (SPADCALL |k2| (QREFELT $ 46)))
              (LETT |res|
                    (SPADCALL (SPADCALL |k1| (QREFELT $ 44))
                              (SPADCALL |k2| (QREFELT $ 44)) (QREFELT $ 226)))
              (EXIT
               (COND
                (|res|
                 (SEQ
                  (LETT |res|
                        (SPADCALL (SPADCALL |a1| 3 (QREFELT $ 155))
                                  (SPADCALL |a2| 3 (QREFELT $ 155))
                                  (QREFELT $ 60)))
                  (EXIT
                   (COND
                    (|res|
                     (COND
                      ((SPADCALL (SPADCALL |a1| 2 (QREFELT $ 155))
                                 (SPADCALL |a2| 2 (QREFELT $ 155))
                                 (QREFELT $ 60))
                       (SPADCALL (SPADCALL |a1| 1 (QREFELT $ 155))
                                 (SPADCALL |a2| 1 (QREFELT $ 155))
                                 (QREFELT $ 60)))
                      (#5='T
                       (SEQ (LETT |r1| (|FS-;decode_diff| |a1| $))
                            (LETT |r2| (|FS-;decode_diff| |a2| $))
                            (COND
                             ((NULL
                               (SPADCALL
                                (SPADCALL (QVELT |r1| 0) (QREFELT $ 44))
                                (SPADCALL (QVELT |r2| 0) (QREFELT $ 44))
                                (QREFELT $ 226)))
                              (EXIT NIL)))
                            (COND
                             ((NULL
                               (SPADCALL (QVELT |r1| 1) (QVELT |r2| 1)
                                         (QREFELT $ 227)))
                              (EXIT NIL)))
                            (COND
                             ((NULL
                               (SPADCALL (QVELT |r1| 3) (QVELT |r2| 3)
                                         (QREFELT $ 228)))
                              (EXIT NIL)))
                            (LETT |od|
                                  (PROGN
                                   (LETT #2# NIL)
                                   (SEQ (LETT |dk| NIL)
                                        (LETT #1# (QVELT |r1| 4)) G190
                                        (COND
                                         ((OR (ATOM #1#)
                                              (PROGN
                                               (LETT |dk| (CAR #1#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #2#
                                                (CONS
                                                 (SPADCALL |dk| (QREFELT $ 28))
                                                 #2#))))
                                        (LETT #1# (CDR #1#)) (GO G190) G191
                                        (EXIT (NREVERSE #2#)))))
                            (LETT |ok1|
                                  (SPADCALL (QVELT |r1| 0) (QREFELT $ 26)))
                            (LETT |sk1|
                                  (SPADCALL |ok1| |od| (QVELT |r2| 4)
                                            (QREFELT $ 197)))
                            (EXIT
                             (SPADCALL |sk1|
                                       (SPADCALL (QVELT |r2| 0) (QREFELT $ 26))
                                       (QREFELT $ 60)))))))
                    (#5# (|FS-;debugA| |a1| |a2| |res| $))))))
                (#5# (|FS-;debugA| |a1| |a2| |res| $))))))) 

(SDEFUN |FS-;mainKernel;SU;57| ((|x| (S)) ($ (|Union| (|Kernel| S) "failed")))
        (SPADCALL (SPADCALL |x| (QREFELT $ 92)) (QREFELT $ 114))) 

(SDEFUN |FS-;kernels;SL;58| ((|x| (S)) ($ (|List| (|Kernel| S))))
        (SPADCALL (SPADCALL |x| (QREFELT $ 92)) (QREFELT $ 180))) 

(SDEFUN |FS-;retract;SR;59| ((|x| (S)) ($ (R)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 92)) (QREFELT $ 231))) 

(SDEFUN |FS-;retract;SP;60| ((|x| (S)) ($ (|Polynomial| R)))
        (SPROG ((#1=#:G1250 NIL))
               (PROG2 (LETT #1# (|FS-;smpret| (SPADCALL |x| (QREFELT $ 92)) $))
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 0) (|Polynomial| (QREFELT $ 7))
                                 (|Union| (|Polynomial| (QREFELT $ 7))
                                          "failed")
                                 #1#)))) 

(SDEFUN |FS-;retractIfCan;SU;61| ((|x| (S)) ($ (|Union| R "failed")))
        (CONS 0 (SPADCALL (SPADCALL |x| (QREFELT $ 92)) (QREFELT $ 231)))) 

(SDEFUN |FS-;retractIfCan;SU;62|
        ((|x| (S)) ($ (|Union| (|Polynomial| R) "failed")))
        (|FS-;smpret| (SPADCALL |x| (QREFELT $ 92)) $)) 

(SDEFUN |FS-;eval;SLLS;63|
        ((|x| (S)) (|lk| (|List| (|Kernel| S))) (|lv| (|List| S)) ($ (S)))
        (|FS-;smpeval| (SPADCALL |x| (QREFELT $ 92)) |lk| |lv| $)) 

(SDEFUN |FS-;subst;SLLS;64|
        ((|x| (S)) (|lk| (|List| (|Kernel| S))) (|lv| (|List| S)) ($ (S)))
        (|FS-;smpsubst| (SPADCALL |x| (QREFELT $ 92)) |lk| |lv| $)) 

(SDEFUN |FS-;differentiate;SSS;65| ((|x| (S)) (|s| (|Symbol|)) ($ (S)))
        (|FS-;smpderiv| (SPADCALL |x| (QREFELT $ 92)) |s| $)) 

(SDEFUN |FS-;coerce;SOf;66| ((|x| (S)) ($ (|OutputForm|)))
        (|FS-;smp2O| (SPADCALL |x| (QREFELT $ 92)) $)) 

(SDEFUN |FS-;eval;SLLLS;67|
        ((|x| (S)) (|s| (|List| (|Symbol|)))
         (|n| (|List| (|NonNegativeInteger|)))
         (|f| (|List| (|Mapping| S (|List| S)))) ($ (S)))
        (|FS-;smprep| |s| |n| |f| (SPADCALL |x| (QREFELT $ 92)) $)) 

(SDEFUN |FS-;isPlus;SU;68| ((|x| (S)) ($ (|Union| (|List| S) "failed")))
        (SPROG
         ((#1=#:G1280 NIL) (|p| NIL) (#2=#:G1279 NIL)
          (|u|
           (|Union| (|List| (|SparseMultivariatePolynomial| R (|Kernel| S)))
                    "failed")))
         (SEQ
          (LETT |u| (SPADCALL (SPADCALL |x| (QREFELT $ 92)) (QREFELT $ 243)))
          (EXIT
           (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                 ('T
                  (CONS 0
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |p| NIL) (LETT #1# (QCDR |u|)) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |p| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2#
                                      (CONS (SPADCALL |p| (QREFELT $ 90))
                                            #2#))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#))))))))))) 

(SDEFUN |FS-;isTimes;SU;69| ((|x| (S)) ($ (|Union| (|List| S) "failed")))
        (SPROG
         ((#1=#:G1292 NIL) (|p| NIL) (#2=#:G1291 NIL)
          (|u|
           (|Union| (|List| (|SparseMultivariatePolynomial| R (|Kernel| S)))
                    "failed")))
         (SEQ
          (LETT |u| (SPADCALL (SPADCALL |x| (QREFELT $ 92)) (QREFELT $ 245)))
          (EXIT
           (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                 ('T
                  (CONS 0
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |p| NIL) (LETT #1# (QCDR |u|)) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |p| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2#
                                      (CONS (SPADCALL |p| (QREFELT $ 90))
                                            #2#))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#))))))))))) 

(SDEFUN |FS-;isExpt;SU;70|
        ((|x| (S))
         ($
          (|Union|
           (|Record| (|:| |var| (|Kernel| S)) (|:| |exponent| (|Integer|)))
           "failed")))
        (SPROG
         ((|r|
           (|Record| (|:| |var| (|Kernel| S))
                     (|:| |exponent| (|NonNegativeInteger|))))
          (|u|
           (|Union|
            (|Record| (|:| |var| (|Kernel| S))
                      (|:| |exponent| (|NonNegativeInteger|)))
            "failed")))
         (SEQ
          (LETT |u| (SPADCALL (SPADCALL |x| (QREFELT $ 92)) (QREFELT $ 249)))
          (EXIT
           (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                 ('T
                  (SEQ (LETT |r| (QCDR |u|))
                       (EXIT (CONS 0 (CONS (QCAR |r|) (QCDR |r|))))))))))) 

(SDEFUN |FS-;isPower;SU;71|
        ((|x| (S))
         ($
          (|Union| (|Record| (|:| |val| S) (|:| |exponent| (|Integer|)))
                   "failed")))
        (SPROG
         ((|r|
           (|Record| (|:| |var| (|Kernel| S))
                     (|:| |exponent| (|NonNegativeInteger|))))
          (|u|
           (|Union|
            (|Record| (|:| |var| (|Kernel| S))
                      (|:| |exponent| (|NonNegativeInteger|)))
            "failed")))
         (SEQ
          (LETT |u| (SPADCALL (SPADCALL |x| (QREFELT $ 92)) (QREFELT $ 249)))
          (EXIT
           (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                 ('T
                  (SEQ (LETT |r| (QCDR |u|))
                       (EXIT
                        (CONS 0
                              (CONS (SPADCALL (QCAR |r|) (QREFELT $ 26))
                                    (QCDR |r|))))))))))) 

(SDEFUN |FS-;convert;SP;72| ((|x| (S)) ($ (|Pattern| (|Integer|))))
        (SPADCALL (SPADCALL |x| (QREFELT $ 92)) (QREFELT $ 255))) 

(SDEFUN |FS-;convert;SP;73| ((|x| (S)) ($ (|Pattern| (|Float|))))
        (SPADCALL (SPADCALL |x| (QREFELT $ 92)) (QREFELT $ 258))) 

(SDEFUN |FS-;isMult;SU;74|
        ((|x| (S))
         ($
          (|Union| (|Record| (|:| |coef| (|Integer|)) (|:| |var| (|Kernel| S)))
                   "failed")))
        (|FS-;smpIsMult| (SPADCALL |x| (QREFELT $ 92)) $)) 

(SDEFUN |FS-;*;R2S;75| ((|r| (R)) (|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |r| (QREFELT $ 263)) (QREFELT $ 90)) |x|
                  (QREFELT $ 135))) 

(SDEFUN |FS-;mainKernel;SU;76| ((|x| (S)) ($ (|Union| (|Kernel| S) "failed")))
        (SPADCALL |x| (QREFELT $ 266))) 

(SDEFUN |FS-;kernels;SL;77| ((|x| (S)) ($ (|List| (|Kernel| S))))
        (SPADCALL |x| (QREFELT $ 267))) 

(SDEFUN |FS-;univariate;SKF;78|
        ((|x| (S)) (|k| (|Kernel| S))
         ($ (|Fraction| (|SparseUnivariatePolynomial| S))))
        (SPADCALL |x| |k| (QREFELT $ 269))) 

(SDEFUN |FS-;isPlus;SU;79| ((|x| (S)) ($ (|Union| (|List| S) "failed")))
        (SPADCALL |x| (QREFELT $ 273))) 

(SDEFUN |FS-;isTimes;SU;80| ((|x| (S)) ($ (|Union| (|List| S) "failed")))
        (SPADCALL |x| (QREFELT $ 274))) 

(SDEFUN |FS-;isExpt;SU;81|
        ((|x| (S))
         ($
          (|Union|
           (|Record| (|:| |var| (|Kernel| S)) (|:| |exponent| (|Integer|)))
           "failed")))
        (SPADCALL |x| (QREFELT $ 277))) 

(SDEFUN |FS-;isPower;SU;82|
        ((|x| (S))
         ($
          (|Union| (|Record| (|:| |val| S) (|:| |exponent| (|Integer|)))
                   "failed")))
        (SPADCALL |x| (QREFELT $ 280))) 

(SDEFUN |FS-;denominator;2S;83| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 281)) (QREFELT $ 90))) 

(SDEFUN |FS-;coerce;FS;84| ((|q| (|Fraction| R)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |q| (QREFELT $ 284)) (QREFELT $ 263))
                  (SPADCALL (SPADCALL |q| (QREFELT $ 285)) (QREFELT $ 263))
                  (QREFELT $ 286))) 

(SDEFUN |FS-;coerce;FS;85| ((|q| (|Fraction| (|Polynomial| R))) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |q| (QREFELT $ 289)) (QREFELT $ 290))
                  (SPADCALL (SPADCALL |q| (QREFELT $ 291)) (QREFELT $ 290))
                  (QREFELT $ 292))) 

(SDEFUN |FS-;coerce;FS;86|
        ((|q| (|Fraction| (|Polynomial| (|Fraction| R)))) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |q| (QREFELT $ 296)) (QREFELT $ 297))
                  (SPADCALL (SPADCALL |q| (QREFELT $ 298)) (QREFELT $ 297))
                  (QREFELT $ 292))) 

(SDEFUN |FS-;retract;SP;87| ((|x| (S)) ($ (|Polynomial| R)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 300)) (QREFELT $ 301))) 

(SDEFUN |FS-;retract;SF;88| ((|x| (S)) ($ (|Fraction| (|Polynomial| R))))
        (SPROG ((#1=#:G1362 NIL))
               (SPADCALL
                (PROG2
                    (LETT #1# (|FS-;smpret| (SPADCALL |x| (QREFELT $ 92)) $))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0) (|Polynomial| (QREFELT $ 7))
                                  (|Union| (|Polynomial| (QREFELT $ 7))
                                           #2="failed")
                                  #1#))
                (PROG2
                    (LETT #1# (|FS-;smpret| (SPADCALL |x| (QREFELT $ 281)) $))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0) (|Polynomial| (QREFELT $ 7))
                                  (|Union| (|Polynomial| (QREFELT $ 7)) #2#)
                                  #1#))
                (QREFELT $ 302)))) 

(SDEFUN |FS-;retract;SR;89| ((|x| (S)) ($ (R)))
        (SPROG ((#1=#:G1366 NIL))
               (PROG2
                   (LETT #1#
                         (SPADCALL
                          (SPADCALL (SPADCALL |x| (QREFELT $ 92))
                                    (QREFELT $ 231))
                          (SPADCALL (SPADCALL |x| (QREFELT $ 281))
                                    (QREFELT $ 231))
                          (QREFELT $ 305)))
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                 (|Union| (QREFELT $ 7) "failed") #1#)))) 

(SDEFUN |FS-;alg_ker_set| ((|lx| (|List| S)) ($ (|List| (|Kernel| S))))
        (SPROG
         ((|ak1| (|List| #1=(|Kernel| S))) (#2=#:G1400 NIL) (|k1| NIL)
          (|arg| (|List| S)) (|resl| (|List| (|Kernel| S)))
          (|needed| (|Boolean|)) (#3=#:G1399 NIL) (#4=#:G1398 NIL)
          (#5=#:G1397 NIL) (|k| NIL) (|ak| (|List| #1#)) (#6=#:G1396 NIL)
          (#7=#:G1395 NIL) (|x| NIL))
         (SEQ (LETT |resl| NIL) (LETT |ak1| NIL)
              (SEQ (LETT |x| NIL) (LETT #7# |lx|) G190
                   (COND
                    ((OR (ATOM #7#) (PROGN (LETT |x| (CAR #7#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |k| NIL)
                          (LETT #6# (SPADCALL |x| (QREFELT $ 306))) G190
                          (COND
                           ((OR (ATOM #6#) (PROGN (LETT |k| (CAR #6#)) NIL))
                            (GO G191)))
                          (SEQ
                           (COND
                            ((NULL (SPADCALL |k| '|nthRoot| (QREFELT $ 217)))
                             (COND
                              ((NULL (SPADCALL |k| '|rootOf| (QREFELT $ 217)))
                               (EXIT "iterate")))))
                           (EXIT (LETT |ak1| (CONS |k| |ak1|))))
                          (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL))))
                   (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
              (SEQ G190 (COND ((NULL (NULL (NULL |ak1|))) (GO G191)))
                   (SEQ (LETT |ak| |ak1|) (LETT |ak1| NIL)
                        (EXIT
                         (SEQ (LETT |k| NIL) (LETT #5# |ak|) G190
                              (COND
                               ((OR (ATOM #5#)
                                    (PROGN (LETT |k| (CAR #5#)) NIL))
                                (GO G191)))
                              (SEQ (LETT |needed| 'T)
                                   (SEQ (LETT |k1| NIL) (LETT #4# |resl|) G190
                                        (COND
                                         ((OR (ATOM #4#)
                                              (PROGN (LETT |k1| (CAR #4#)) NIL)
                                              (NULL |needed|))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (COND
                                           ((EQ |k1| |k|)
                                            (LETT |needed| NIL)))))
                                        (LETT #4# (CDR #4#)) (GO G190) G191
                                        (EXIT NIL))
                                   (SEQ (LETT |k1| NIL) (LETT #3# |resl|) G190
                                        (COND
                                         ((OR (ATOM #3#)
                                              (PROGN (LETT |k1| (CAR #3#)) NIL)
                                              (NULL |needed|))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (COND
                                           ((SPADCALL |k1| |k| (QREFELT $ 307))
                                            (LETT |needed| NIL)))))
                                        (LETT #3# (CDR #3#)) (GO G190) G191
                                        (EXIT NIL))
                                   (EXIT
                                    (COND
                                     (|needed|
                                      (SEQ (LETT |resl| (CONS |k| |resl|))
                                           (LETT |arg|
                                                 (SPADCALL |k| (QREFELT $ 46)))
                                           (EXIT
                                            (SEQ (LETT |k1| NIL)
                                                 (LETT #2#
                                                       (SPADCALL
                                                        (SPADCALL |arg| 1
                                                                  (QREFELT $
                                                                           155))
                                                        (QREFELT $ 306)))
                                                 G190
                                                 (COND
                                                  ((OR (ATOM #2#)
                                                       (PROGN
                                                        (LETT |k1| (CAR #2#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (COND
                                                    ((OR
                                                      (SPADCALL |k1| '|nthRoot|
                                                                (QREFELT $
                                                                         217))
                                                      (SPADCALL |k1| '|rootOf|
                                                                (QREFELT $
                                                                         217)))
                                                     (LETT |ak1|
                                                           (CONS |k1|
                                                                 |ak1|))))))
                                                 (LETT #2# (CDR #2#)) (GO G190)
                                                 G191 (EXIT NIL)))))
                                     ('T "iterate"))))
                              (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |resl|)))) 

(SDEFUN |FS-;algtower;LL;91| ((|lx| (|List| S)) ($ (|List| (|Kernel| S))))
        (NREVERSE (SPADCALL (|FS-;alg_ker_set| |lx| $) (QREFELT $ 308)))) 

(SDEFUN |FS-;algtower;SL;92| ((|x| (S)) ($ (|List| (|Kernel| S))))
        (SPADCALL (LIST |x|) (QREFELT $ 310))) 

(SDEFUN |FS-;coerce;SOf;93| ((|x| (S)) ($ (|OutputForm|)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 281)) (|spadConstant| $ 312)
                    (QREFELT $ 313))
          (|FS-;smp2O| (SPADCALL |x| (QREFELT $ 92)) $))
         ('T
          (SPADCALL (|FS-;smp2O| (SPADCALL |x| (QREFELT $ 92)) $)
                    (|FS-;smp2O| (SPADCALL |x| (QREFELT $ 281)) $)
                    (QREFELT $ 314))))) 

(SDEFUN |FS-;retractIfCan;SU;94| ((|x| (S)) ($ (|Union| R "failed")))
        (SPROG
         ((#1=#:G1413 NIL) (|r| (|Union| R "failed"))
          (|d| #2=(|Union| R "failed")) (|n| #2#))
         (SEQ
          (EXIT
           (SEQ
            (SEQ
             (LETT |n|
                   (SPADCALL (SPADCALL |x| (QREFELT $ 92)) (QREFELT $ 192)))
             (EXIT
              (COND
               ((QEQCAR |n| 1)
                (PROGN (LETT #1# (CONS 1 #3="failed")) (GO #4=#:G1411)))
               (#5='T
                (SEQ
                 (LETT |d|
                       (SPADCALL (SPADCALL |x| (QREFELT $ 281))
                                 (QREFELT $ 192)))
                 (EXIT
                  (COND
                   ((QEQCAR |d| 1) (PROGN (LETT #1# (CONS 1 #3#)) (GO #4#)))
                   (#5#
                    (SEQ
                     (LETT |r|
                           (SPADCALL (QCDR |n|) (QCDR |d|) (QREFELT $ 305)))
                     (EXIT
                      (COND
                       ((QEQCAR |r| 1)
                        (PROGN (LETT #1# (CONS 1 #3#)) (GO #4#))))))))))))))
            (EXIT (CONS 0 (QCDR |r|)))))
          #4# (EXIT #1#)))) 

(SDEFUN |FS-;eval;SLLLS;95|
        ((|x| (S)) (|s| (|List| (|Symbol|)))
         (|n| (|List| (|NonNegativeInteger|)))
         (|f| (|List| (|Mapping| S (|List| S)))) ($ (S)))
        (SPADCALL (|FS-;smprep| |s| |n| |f| (SPADCALL |x| (QREFELT $ 92)) $)
                  (|FS-;smprep| |s| |n| |f| (SPADCALL |x| (QREFELT $ 281)) $)
                  (QREFELT $ 292))) 

(SDEFUN |FS-;differentiate;SSS;96| ((|f| (S)) (|x| (|Symbol|)) ($ (S)))
        (SPADCALL
         (SPADCALL
          (SPADCALL (|FS-;smpderiv| (SPADCALL |f| (QREFELT $ 92)) |x| $)
                    (SPADCALL (SPADCALL |f| (QREFELT $ 281)) (QREFELT $ 90))
                    (QREFELT $ 135))
          (SPADCALL (SPADCALL (SPADCALL |f| (QREFELT $ 92)) (QREFELT $ 90))
                    (|FS-;smpderiv| (SPADCALL |f| (QREFELT $ 281)) |x| $)
                    (QREFELT $ 135))
          (QREFELT $ 315))
         (SPADCALL (SPADCALL (SPADCALL |f| (QREFELT $ 281)) (QREFELT $ 90)) 2
                   (QREFELT $ 316))
         (QREFELT $ 292))) 

(SDEFUN |FS-;eval;SLLS;97|
        ((|x| (S)) (|lk| (|List| (|Kernel| S))) (|lv| (|List| S)) ($ (S)))
        (SPADCALL (|FS-;smpeval| (SPADCALL |x| (QREFELT $ 92)) |lk| |lv| $)
                  (|FS-;smpeval| (SPADCALL |x| (QREFELT $ 281)) |lk| |lv| $)
                  (QREFELT $ 292))) 

(SDEFUN |FS-;subst;SLLS;98|
        ((|x| (S)) (|lk| (|List| (|Kernel| S))) (|lv| (|List| S)) ($ (S)))
        (SPADCALL (|FS-;smpsubst| (SPADCALL |x| (QREFELT $ 92)) |lk| |lv| $)
                  (|FS-;smpsubst| (SPADCALL |x| (QREFELT $ 281)) |lk| |lv| $)
                  (QREFELT $ 292))) 

(SDEFUN |FS-;par| ((|x| (S)) ($ (S)))
        (SPROG ((|r| (|Union| R "failed")))
               (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 18)))
                    (EXIT
                     (COND ((QEQCAR |r| 0) |x|)
                           ('T (SPADCALL |x| (QREFELT $ 317)))))))) 

(SDEFUN |FS-;convert;FS;100| ((|x| (|Factored| S)) ($ (S)))
        (SPROG
         ((#1=#:G1443 NIL) (#2=#:G1442 (S)) (#3=#:G1444 (S)) (#4=#:G1446 NIL)
          (|f| NIL))
         (SEQ
          (SPADCALL (|FS-;par| (SPADCALL |x| (QREFELT $ 319)) $)
                    (PROGN
                     (LETT #1# NIL)
                     (SEQ (LETT |f| NIL)
                          (LETT #4# (SPADCALL |x| (QREFELT $ 323))) G190
                          (COND
                           ((OR (ATOM #4#) (PROGN (LETT |f| (CAR #4#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (PROGN
                             (LETT #3#
                                   (SPADCALL (|FS-;par| (QVELT |f| 1) $)
                                             (QVELT |f| 2) (QREFELT $ 316)))
                             (COND
                              (#1#
                               (LETT #2# (SPADCALL #2# #3# (QREFELT $ 135))))
                              ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                          (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                     (COND (#1# #2#) ('T (|spadConstant| $ 145))))
                    (QREFELT $ 135))))) 

(SDEFUN |FS-;retractIfCan;SU;101|
        ((|x| (S)) ($ (|Union| (|Polynomial| R) "failed")))
        (SPROG ((|u| (|Union| (|Fraction| (|Polynomial| R)) "failed")))
               (SEQ (LETT |u| (SPADCALL |x| (QREFELT $ 327)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                           ('T (SPADCALL (QCDR |u|) (QREFELT $ 328)))))))) 

(SDEFUN |FS-;retractIfCan;SU;102|
        ((|x| (S)) ($ (|Union| (|Fraction| (|Polynomial| R)) "failed")))
        (SPROG ((|d| #1=(|Union| (|Polynomial| R) "failed")) (|n| #1#))
               (SEQ (LETT |n| (|FS-;smpret| (SPADCALL |x| (QREFELT $ 92)) $))
                    (EXIT
                     (COND ((QEQCAR |n| 1) (CONS 1 "failed"))
                           (#2='T
                            (SEQ
                             (LETT |d|
                                   (|FS-;smpret| (SPADCALL |x| (QREFELT $ 281))
                                    $))
                             (EXIT
                              (COND ((QEQCAR |d| 1) (CONS 1 "failed"))
                                    (#2#
                                     (CONS 0
                                           (SPADCALL (QCDR |n|) (QCDR |d|)
                                                     (QREFELT $ 302))))))))))))) 

(SDEFUN |FS-;coerce;PS;103| ((|p| (|Polynomial| (|Fraction| R))) ($ (S)))
        (SPADCALL (ELT $ 38) (ELT $ 330) |p| (QREFELT $ 333))) 

(SDEFUN |FS-;coerce;FS;104| ((|x| (|Fraction| (|Integer|))) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 336)) (QREFELT $ 337))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 338)) (QREFELT $ 337))
                  (QREFELT $ 286))) 

(SDEFUN |FS-;isMult;SU;105|
        ((|x| (S))
         ($
          (|Union| (|Record| (|:| |coef| (|Integer|)) (|:| |var| (|Kernel| S)))
                   "failed")))
        (SPROG
         ((|q| (|Union| (|Integer|) "failed"))
          (|r| (|Record| (|:| |coef| (|Integer|)) (|:| |var| (|Kernel| S))))
          (#1=#:G1481 NIL) (|w| (|Union| (|Integer|) "failed"))
          (|v| (|Union| R "failed"))
          (|u|
           (|Union|
            (|Record| (|:| |coef| (|Integer|)) (|:| |var| (|Kernel| S)))
            "failed")))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |u| (|FS-;smpIsMult| (SPADCALL |x| (QREFELT $ 92)) $))
                 (EXIT
                  (COND
                   ((QEQCAR |u| 1)
                    (PROGN (LETT #1# (CONS 1 #2="failed")) (GO #3=#:G1479)))
                   (#4='T
                    (SEQ
                     (LETT |v|
                           (SPADCALL (SPADCALL |x| (QREFELT $ 281))
                                     (QREFELT $ 192)))
                     (EXIT
                      (COND
                       ((QEQCAR |v| 1)
                        (PROGN (LETT #1# (CONS 1 #2#)) (GO #3#)))
                       (#4#
                        (SEQ (LETT |w| (SPADCALL (QCDR |v|) (QREFELT $ 224)))
                             (EXIT
                              (COND
                               ((QEQCAR |w| 1)
                                (PROGN
                                 (LETT #1# (CONS 1 #2#))
                                 (GO #3#))))))))))))))
            (LETT |r| (QCDR |u|))
            (LETT |q| (SPADCALL (QCAR |r|) (QCDR |w|) (QREFELT $ 340)))
            (EXIT
             (COND ((QEQCAR |q| 1) (CONS 1 "failed"))
                   (#4# (CONS 0 (CONS (QCDR |q|) (QCDR |r|))))))))
          #3# (EXIT #1#)))) 

(SDEFUN |FS-;convert;SP;106| ((|x| (S)) ($ (|Pattern| (|Integer|))))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 92)) (QREFELT $ 255))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 281)) (QREFELT $ 255))
                  (QREFELT $ 341))) 

(SDEFUN |FS-;convert;SP;107| ((|x| (S)) ($ (|Pattern| (|Float|))))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 92)) (QREFELT $ 258))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 281)) (QREFELT $ 258))
                  (QREFELT $ 342))) 

(DECLAIM (NOTINLINE |FunctionSpace&;|)) 

(DEFUN |FunctionSpace&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|FunctionSpace&| DV$1 DV$2))
          (LETT $ (GETREFV 346))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|RetractableTo|
                                                               (|Integer|)))
                                              (|HasCategory| |#2|
                                                             '(|IntegralDomain|))
                                              (|HasCategory| |#2|
                                                             '(|CommutativeRing|))
                                              (|HasCategory| |#2|
                                                             '(|CharacteristicNonZero|))
                                              (|HasCategory| |#2|
                                                             '(|CharacteristicZero|))
                                              (|HasCategory| |#2| '(|Ring|))
                                              (|HasCategory| |#2|
                                                             '(|AbelianGroup|))
                                              (|HasCategory| |#2|
                                                             '(|AbelianSemiGroup|))
                                              (|HasCategory| |#2| '(|Group|))
                                              (|HasCategory| |#2|
                                                             '(|SemiGroup|))
                                              (|HasCategory| |#2|
                                                             '(|ConvertibleTo|
                                                               (|InputForm|)))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 '|odd|)
          (QSETREFV $ 9 '|even|)
          (QSETREFV $ 10 '|%specialDiff|)
          (QSETREFV $ 15 (SPADCALL '|%diff| (QREFELT $ 14)))
          (QSETREFV $ 16 (SPADCALL '|%quote| (QREFELT $ 14)))
          (COND
           ((|testBitVector| |pv$| 11)
            (PROGN
             (QSETREFV $ 64 (CONS (|dispatchFunction| |FS-;eval;SBoSSS;15|) $))
             (QSETREFV $ 71 (CONS (|dispatchFunction| |FS-;eval;SLLSS;16|) $))
             (SPADCALL (QREFELT $ 15) '|%specialInput|
                       (CONS (|function| |FS-;indiff|) $) (QREFELT $ 73)))))
          (COND
           ((|testBitVector| |pv$| 6)
            (PROGN
             (QSETREFV $ 83 '%%0)
             (QSETREFV $ 86
                       (CONS (|dispatchFunction| |FS-;characteristic;Nni;20|)
                             $))
             (QSETREFV $ 91 (CONS (|dispatchFunction| |FS-;coerce;KS;21|) $))
             (QSETREFV $ 93
                       (CONS (|dispatchFunction| |FS-;numerator;2S;23|) $))
             (QSETREFV $ 99
                       (CONS (|dispatchFunction| |FS-;eval;SSNniMS;24|) $))
             (QSETREFV $ 100
                       (CONS (|dispatchFunction| |FS-;eval;SSNniMS;25|) $))
             (QSETREFV $ 102 (CONS (|dispatchFunction| |FS-;eval;SLLS;26|) $))
             (QSETREFV $ 111 (CONS (|dispatchFunction| |FS-;elt;BoLS;27|) $))
             (QSETREFV $ 112 (CONS (|dispatchFunction| |FS-;eval;SLLLS;28|) $))
             NIL
             (QSETREFV $ 187 (CONS (|dispatchFunction| |FS-;coerce;PS;43|) $))
             (QSETREFV $ 216
                       (CONS (|dispatchFunction| |FS-;isExpt;SBoU;51|) $))
             (QSETREFV $ 218 (CONS (|dispatchFunction| |FS-;isExpt;SSU;52|) $))
             (COND ((|testBitVector| |pv$| 1)))
             (SPADCALL (QREFELT $ 15) (CONS (|function| |FS-;diffEval|) $)
                       (QREFELT $ 225))
             (SPADCALL (QREFELT $ 15) '|%specialEqual|
                       (CONS (|function| |FS-;equaldiff|) $) (QREFELT $ 73))
             (SPADCALL (QREFELT $ 15) (QREFELT $ 10)
                       (CONS (|function| |FS-;diffdiff|) $) (QREFELT $ 73))
             (SPADCALL (QREFELT $ 15) '|%specialDisp|
                       (CONS (|function| |FS-;ddiff|) $) (QREFELT $ 73))
             (COND ((|testBitVector| |pv$| 2))
                   ('T
                    (PROGN
                     (QSETREFV $ 229
                               (CONS
                                (|dispatchFunction| |FS-;mainKernel;SU;57|) $))
                     (QSETREFV $ 230
                               (CONS (|dispatchFunction| |FS-;kernels;SL;58|)
                                     $))
                     (QSETREFV $ 232
                               (CONS (|dispatchFunction| |FS-;retract;SR;59|)
                                     $))
                     (QSETREFV $ 233
                               (CONS (|dispatchFunction| |FS-;retract;SP;60|)
                                     $))
                     (QSETREFV $ 234
                               (CONS
                                (|dispatchFunction| |FS-;retractIfCan;SU;61|)
                                $))
                     (QSETREFV $ 236
                               (CONS
                                (|dispatchFunction| |FS-;retractIfCan;SU;62|)
                                $))
                     (QSETREFV $ 237
                               (CONS (|dispatchFunction| |FS-;eval;SLLS;63|)
                                     $))
                     (QSETREFV $ 238
                               (CONS (|dispatchFunction| |FS-;subst;SLLS;64|)
                                     $))
                     (QSETREFV $ 239
                               (CONS
                                (|dispatchFunction| |FS-;differentiate;SSS;65|)
                                $))
                     (QSETREFV $ 240
                               (CONS (|dispatchFunction| |FS-;coerce;SOf;66|)
                                     $))
                     (QSETREFV $ 241
                               (CONS (|dispatchFunction| |FS-;eval;SLLLS;67|)
                                     $))
                     (QSETREFV $ 244
                               (CONS (|dispatchFunction| |FS-;isPlus;SU;68|)
                                     $))
                     (QSETREFV $ 246
                               (CONS (|dispatchFunction| |FS-;isTimes;SU;69|)
                                     $))
                     (QSETREFV $ 250
                               (CONS (|dispatchFunction| |FS-;isExpt;SU;70|)
                                     $))
                     (QSETREFV $ 253
                               (CONS (|dispatchFunction| |FS-;isPower;SU;71|)
                                     $))
                     (COND
                      ((|HasCategory|
                        (|SparseMultivariatePolynomial| |#2| (|Kernel| |#1|))
                        '(|ConvertibleTo| (|Pattern| (|Integer|))))
                       (QSETREFV $ 256
                                 (CONS (|dispatchFunction| |FS-;convert;SP;72|)
                                       $))))
                     (COND
                      ((|HasCategory|
                        (|SparseMultivariatePolynomial| |#2| (|Kernel| |#1|))
                        '(|ConvertibleTo| (|Pattern| (|Float|))))
                       (QSETREFV $ 259
                                 (CONS (|dispatchFunction| |FS-;convert;SP;73|)
                                       $))))
                     (COND
                      ((|testBitVector| |pv$| 1)
                       (QSETREFV $ 262
                                 (CONS (|dispatchFunction| |FS-;isMult;SU;74|)
                                       $))))))))))
          (COND
           ((|testBitVector| |pv$| 3)
            (QSETREFV $ 264 (CONS (|dispatchFunction| |FS-;*;R2S;75|) $))))
          (COND
           ((|testBitVector| |pv$| 2)
            (PROGN
             (QSETREFV $ 229
                       (CONS (|dispatchFunction| |FS-;mainKernel;SU;76|) $))
             (QSETREFV $ 230 (CONS (|dispatchFunction| |FS-;kernels;SL;77|) $))
             (QSETREFV $ 271
                       (CONS (|dispatchFunction| |FS-;univariate;SKF;78|) $))
             (QSETREFV $ 244 (CONS (|dispatchFunction| |FS-;isPlus;SU;79|) $))
             (QSETREFV $ 246 (CONS (|dispatchFunction| |FS-;isTimes;SU;80|) $))
             (QSETREFV $ 250 (CONS (|dispatchFunction| |FS-;isExpt;SU;81|) $))
             (QSETREFV $ 253 (CONS (|dispatchFunction| |FS-;isPower;SU;82|) $))
             (QSETREFV $ 282
                       (CONS (|dispatchFunction| |FS-;denominator;2S;83|) $))
             (QSETREFV $ 287 (CONS (|dispatchFunction| |FS-;coerce;FS;84|) $))
             (QSETREFV $ 293 (CONS (|dispatchFunction| |FS-;coerce;FS;85|) $))
             (QSETREFV $ 299 (CONS (|dispatchFunction| |FS-;coerce;FS;86|) $))
             (QSETREFV $ 233 (CONS (|dispatchFunction| |FS-;retract;SP;87|) $))
             (QSETREFV $ 303 (CONS (|dispatchFunction| |FS-;retract;SF;88|) $))
             (QSETREFV $ 232 (CONS (|dispatchFunction| |FS-;retract;SR;89|) $))
             (QSETREFV $ 309
                       (CONS (|dispatchFunction| |FS-;algtower;LL;91|) $))
             (QSETREFV $ 311
                       (CONS (|dispatchFunction| |FS-;algtower;SL;92|) $))
             (QSETREFV $ 240 (CONS (|dispatchFunction| |FS-;coerce;SOf;93|) $))
             (QSETREFV $ 234
                       (CONS (|dispatchFunction| |FS-;retractIfCan;SU;94|) $))
             (COND
              ((|testBitVector| |pv$| 11)
               (QSETREFV $ 241
                         (CONS (|dispatchFunction| |FS-;eval;SLLLS;95|) $))))
             (QSETREFV $ 239
                       (CONS (|dispatchFunction| |FS-;differentiate;SSS;96|)
                             $))
             (QSETREFV $ 237 (CONS (|dispatchFunction| |FS-;eval;SLLS;97|) $))
             (QSETREFV $ 238 (CONS (|dispatchFunction| |FS-;subst;SLLS;98|) $))
             (QSETREFV $ 325
                       (CONS (|dispatchFunction| |FS-;convert;FS;100|) $))
             (QSETREFV $ 236
                       (CONS (|dispatchFunction| |FS-;retractIfCan;SU;101|) $))
             (QSETREFV $ 329
                       (CONS (|dispatchFunction| |FS-;retractIfCan;SU;102|) $))
             (QSETREFV $ 334 (CONS (|dispatchFunction| |FS-;coerce;PS;103|) $))
             (COND
              ((|testBitVector| |pv$| 1)
               (PROGN
                (QSETREFV $ 339
                          (CONS (|dispatchFunction| |FS-;coerce;FS;104|) $))
                (QSETREFV $ 262
                          (CONS (|dispatchFunction| |FS-;isMult;SU;105|) $)))))
             (COND
              ((|HasCategory|
                (|SparseMultivariatePolynomial| |#2| (|Kernel| |#1|))
                '(|ConvertibleTo| (|Pattern| (|Integer|))))
               (QSETREFV $ 256
                         (CONS (|dispatchFunction| |FS-;convert;SP;106|) $))))
             (COND
              ((|HasCategory|
                (|SparseMultivariatePolynomial| |#2| (|Kernel| |#1|))
                '(|ConvertibleTo| (|Pattern| (|Float|))))
               (QSETREFV $ 259
                         (CONS (|dispatchFunction| |FS-;convert;SP;107|)
                               $)))))))
          $))) 

(MAKEPROP '|FunctionSpace&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) 'ODD 'EVEN
              'SPECIALDIFF (|BasicOperator|) (|Symbol|) (|CommonOperators|)
              (0 . |operator|) '|opdiff| '|opquote| (|Union| 7 '#1="failed")
              (5 . |retractIfCan|) (|Boolean|) |FS-;ground?;SB;1|
              (10 . |retract|) |FS-;ground;SR;2| (|Kernel| 6) (15 . |kernel|)
              (|Kernel| $) (20 . |coerce|) |FS-;coerce;SS;3| (25 . |retract|)
              (|Union| 12 '"failed") (30 . |symbolIfCan|) |FS-;retract;SS;4|
              (|List| $) (35 . |applyQuote|) |FS-;applyQuote;S2S;5|
              |FS-;applyQuote;S3S;6| |FS-;applyQuote;S4S;7|
              |FS-;applyQuote;S5S;8| (41 . |coerce|) (46 . |elt|)
              |FS-;applyQuote;SLS;9| (52 . |has?|) (58 . |is?|)
              |FS-;belong?;BoB;10| (64 . |operator|) (|List| 6)
              (69 . |argument|) (74 . |kernel|) (80 . |name|) (|String|)
              (85 . |string|) |FS-;operator;2Bo;12| (|InputForm|)
              (90 . |convert|) (95 . |convert|) (100 . |third|)
              (105 . |retractIfCan|) (110 . |new|) (114 . |second|)
              (119 . |eval|) (126 . =) (132 . |convert|) (|List| 11)
              (137 . |eval|) (145 . |eval|) (|Mapping| 6 6)
              (|MakeUnaryCompiledFunction| 6 6 6) (153 . |compiledFunction|)
              (|Mapping| $ $) (|List| 68) (159 . |eval|) (166 . |eval|)
              (|None|) (174 . |setProperty|) (|List| 25) (181 . |tower|)
              (|List| 12) |FS-;variables;LL;17| (186 . |variables|)
              |FS-;variables;SL;18| (|Union| 25 '#1#) (191 . |retractIfCan|)
              |FS-;retractIfCan;SU;19| '|gendiff| (|NonNegativeInteger|)
              (196 . |characteristic|) (200 . |characteristic|)
              (|SparseMultivariatePolynomial| 7 23) (204 . |coerce|)
              (|SparseMultivariatePolynomial| 7 25) (209 . |coerce|)
              (214 . |coerce|) (219 . |numer|) (224 . |numerator|)
              (229 . |first|) (|List| 84) (|Mapping| $ 32) (|List| 96)
              (234 . |eval|) (242 . |eval|) (250 . |eval|) (258 . |new|)
              (264 . |eval|) (271 . |unary?|) (276 . |leadingCoefficient|)
              (281 . |Zero|) (285 . |smaller?|) (291 . -) (296 . |elt|)
              (|ExpressionSpace&| 6) (302 . |elt|) (308 . |elt|) (314 . |eval|)
              (|Union| 23 '"failed") (322 . |mainVariable|)
              (|SparseUnivariatePolynomial| $) (327 . |univariate|)
              (|SparseUnivariatePolynomial| 6) (|Mapping| 6 87)
              (|SparseUnivariatePolynomial| 87)
              (|SparseUnivariatePolynomialFunctions2| 87 6) (333 . |map|)
              (|Integer|) (339 . |position|) (345 . |elt|) (351 . |Zero|)
              (|Mapping| 6 45) (|List| 126) (355 . |elt|) (361 . |elt|)
              (367 . |Zero|) (371 . ~=) (377 . |degree|) (382 . ^)
              (388 . |leadingCoefficient|) (393 . *) (399 . +)
              (405 . |reductum|) (|OutputForm|) (410 . |coerce|) (415 . |is?|)
              (|List| 138) (421 . |position|) (427 . |setelt!|)
              (434 . |coerce|) (439 . |One|) (443 . |coerce|) (448 . |hconcat|)
              (454 . |position|) (|Union| 72 '"failed") (460 . |property|)
              (466 . |sub|) (472 . |differentiate|) (478 . |prefix|)
              (484 . |copy|) (489 . |elt|) (495 . |setelt!|) (|List| 122)
              (502 . |member?|) (508 . |first|) (514 . |rest|) (520 . |concat|)
              (526 . |differentiate|) (|Union| 127 '"failed")
              (|BasicOperatorFunctions1| 6) (532 . |derivative|) (|Equation| 6)
              (537 . =) (|Equation| $) (543 . |subst|) (549 . |kernel|)
              (555 . ~=) (561 . ~=) (|Polynomial| 7) (567 . |coerce|)
              (572 . |differentiate|) (578 . |retract|) (|Mapping| 7 7)
              (583 . |map|) (|List| 23) (589 . |variables|)
              (594 . |differentiate|) (600 . |coerce|) (|Mapping| 6 12)
              (|Mapping| 6 7)
              (|PolynomialCategoryLifting| (|IndexedExponents| 12) 12 7 173 6)
              (605 . |map|) (612 . |coerce|) (|Union| 19 '"failed")
              (|UserDefinedPartialOrdering| 12) (617 . |less?|) (623 . <)
              (629 . |retractIfCan|) (634 . |coerce|) (639 . |userOrdered?|)
              (643 . |coerce|) (648 . |outputForm|) (654 . |subst|)
              (|Mapping| 6 23) (|ListToMap| 23 6) (661 . |match|)
              (|PolynomialCategoryLifting| (|IndexedExponents| 23) 23 7 87 6)
              (669 . |map|) (676 . |eval|) (683 . |map|) (689 . |tower|)
              (694 . |setIntersection|) (700 . |empty?|) (705 . |coerce|)
              (|Mapping| 173 23) (|Mapping| 173 7)
              (|PolynomialCategoryLifting| (|IndexedExponents| 23) 23 7 87 173)
              (710 . |map|) (|Record| (|:| |var| 25) (|:| |exponent| 122))
              (|Union| 213 '#2="failed") (717 . |isExpt|) (722 . |isExpt|)
              (728 . |is?|) (734 . |isExpt|) (740 . |degree|)
              (745 . |reductum|) (750 . |leadingCoefficient|) (755 . |zero?|)
              (|Union| 122 '#1#) (760 . |retractIfCan|) (765 . |evaluate|)
              (771 . =) (777 . =) (783 . =) (789 . |mainKernel|)
              (794 . |kernels|) (799 . |retract|) (804 . |retract|)
              (809 . |retract|) (814 . |retractIfCan|) (|Union| 173 '"failed")
              (819 . |retractIfCan|) (824 . |eval|) (831 . |subst|)
              (838 . |differentiate|) (844 . |coerce|) (849 . |eval|)
              (|Union| 32 '#3="failed") (857 . |isPlus|) (862 . |isPlus|)
              (867 . |isTimes|) (872 . |isTimes|)
              (|Record| (|:| |var| 23) (|:| |exponent| 84)) (|Union| 247 '#3#)
              (877 . |isExpt|) (882 . |isExpt|)
              (|Record| (|:| |val| $) (|:| |exponent| 122))
              (|Union| 251 '#4="failed") (887 . |isPower|) (|Pattern| 122)
              (892 . |convert|) (897 . |convert|) (|Pattern| (|Float|))
              (902 . |convert|) (907 . |convert|)
              (|Record| (|:| |coef| 122) (|:| |var| 25))
              (|Union| 260 '#5="failed") (912 . |isMult|) (917 . |coerce|)
              (922 . *)
              (|PolynomialCategoryQuotientFunctions| (|IndexedExponents| 23) 23
                                                     7 87 6)
              (928 . |mainVariable|) (933 . |variables|) (|Fraction| 117)
              (938 . |univariate|) (|Fraction| 115) (944 . |univariate|)
              (|Union| 45 '"failed") (950 . |isPlus|) (955 . |isTimes|)
              (|Record| (|:| |var| 23) (|:| |exponent| 122))
              (|Union| 275 '"failed") (960 . |isExpt|)
              (|Record| (|:| |val| 6) (|:| |exponent| 122))
              (|Union| 278 '"failed") (965 . |isPower|) (970 . |denom|)
              (975 . |denominator|) (|Fraction| 7) (980 . |numer|)
              (985 . |denom|) (990 . /) (996 . |coerce|) (|Fraction| 173)
              (1001 . |numer|) (1006 . |coerce|) (1011 . |denom|) (1016 . /)
              (1022 . |coerce|) (|Polynomial| 283) (|Fraction| 294)
              (1027 . |numer|) (1032 . |coerce|) (1037 . |denom|)
              (1042 . |coerce|) (1047 . |retract|) (1052 . |retract|)
              (1057 . /) (1063 . |retract|) (|Union| $ '"failed")
              (1068 . |exquo|) (1074 . |kernels|) (1079 . =) (1085 . |sort!|)
              (1090 . |algtower|) (1095 . |algtower|) (1100 . |algtower|)
              (1105 . |One|) (1109 . =) (1115 . /) (1121 . -) (1127 . ^)
              (1133 . |paren|) (|Factored| 6) (1138 . |unit|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 320) (|:| |factor| 6) (|:| |exponent| 84))
              (|List| 321) (1143 . |factorList|) (|Factored| $)
              (1148 . |convert|) (|Union| 288 '#1#) (1153 . |retractIfCan|)
              (1158 . |retractIfCan|) (1163 . |retractIfCan|) (1168 . |coerce|)
              (|Mapping| 6 283)
              (|PolynomialCategoryLifting| (|IndexedExponents| 12) 12 283 294
                                           6)
              (1173 . |map|) (1180 . |coerce|) (|Fraction| 122)
              (1185 . |numer|) (1190 . |coerce|) (1195 . |denom|)
              (1200 . |coerce|) (1205 . |exquo|) (1211 . /) (1217 . /)
              (|PositiveInteger|) (|Union| 335 '#1#) (|List| 168))
           '#(|variables| 1223 |univariate| 1233 |subst| 1239 |retractIfCan|
              1246 |retract| 1266 |operator| 1286 |numerator| 1291 |mainKernel|
              1296 |kernels| 1301 |isTimes| 1306 |isPower| 1311 |isPlus| 1316
              |isMult| 1321 |isExpt| 1326 |ground?| 1343 |ground| 1348 |eval|
              1353 |elt| 1415 |differentiate| 1421 |denominator| 1427 |convert|
              1432 |coerce| 1447 |characteristic| 1492 |belong?| 1496
              |applyQuote| 1501 |algtower| 1537 * 1547)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|convert| ((|InputForm|) |#1|)) T)
                                   '((* (|#1| |#1| |#1|)) T)
                                   '((* (|#1| (|PositiveInteger|) |#1|)) T)
                                   '((* (|#1| (|NonNegativeInteger|) |#1|)) T)
                                   '((* (|#1| (|Integer|) |#1|)) T)
                                   '((|coerce| (|#1| (|Integer|))) T)
                                   '((|coerce| (|#1| (|Polynomial| |#2|))) T)
                                   '((|retractIfCan|
                                      ((|Union| (|Polynomial| |#2|) #1#) |#1|))
                                     T)
                                   '((|retract| ((|Polynomial| |#2|) |#1|)) T)
                                   '((|differentiate| (|#1| |#1| (|Symbol|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|List| (|Symbol|))))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|Symbol|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|List| (|Symbol|))
                                       (|List| (|NonNegativeInteger|))))
                                     T)
                                   '((|characteristic|
                                      ((|NonNegativeInteger|)))
                                     T)
                                   '((* (|#1| |#1| |#2|)) T)
                                   '((* (|#1| |#2| |#1|)) T)
                                   '((|coerce| (|#1| |#1|)) T)
                                   '((* (|#1| |#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((* (|#1| (|Fraction| (|Integer|)) |#1|))
                                     T)
                                   '((|coerce| (|#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((|coerce|
                                      (|#1| (|Fraction| (|Polynomial| |#2|))))
                                     T)
                                   '((|retractIfCan|
                                      ((|Union|
                                        (|Fraction| (|Polynomial| |#2|)) #1#)
                                       |#1|))
                                     T)
                                   '((|retract|
                                      ((|Fraction| (|Polynomial| |#2|)) |#1|))
                                     T)
                                   '((|retractIfCan|
                                      ((|Union| (|Fraction| (|Integer|)) #1#)
                                       |#1|))
                                     T)
                                   '((|retract|
                                      ((|Fraction| (|Integer|)) |#1|))
                                     T)
                                   '((|univariate|
                                      ((|Fraction|
                                        (|SparseUnivariatePolynomial| |#1|))
                                       |#1| (|Kernel| |#1|)))
                                     T)
                                   '((|coerce|
                                      (|#1|
                                       (|Fraction|
                                        (|Polynomial| (|Fraction| |#2|)))))
                                     T)
                                   '((|coerce|
                                      (|#1| (|Polynomial| (|Fraction| |#2|))))
                                     T)
                                   '((|coerce| (|#1| (|Fraction| |#2|))) T)
                                   '((|denominator| (|#1| |#1|)) T)
                                   '((|convert| (|#1| (|Factored| |#1|))) T)
                                   '((|algtower|
                                      ((|List| (|Kernel| |#1|)) (|List| |#1|)))
                                     T)
                                   '((|algtower|
                                      ((|List| (|Kernel| |#1|)) |#1|))
                                     T)
                                   '((|eval|
                                      (|#1| |#1| (|Symbol|)
                                       (|NonNegativeInteger|)
                                       (|Mapping| |#1| |#1|)))
                                     T)
                                   '((|eval|
                                      (|#1| |#1| (|Symbol|)
                                       (|NonNegativeInteger|)
                                       (|Mapping| |#1| (|List| |#1|))))
                                     T)
                                   '((|eval|
                                      (|#1| |#1| (|List| (|Symbol|))
                                       (|List| (|NonNegativeInteger|))
                                       (|List|
                                        (|Mapping| |#1| (|List| |#1|)))))
                                     T)
                                   '((|eval|
                                      (|#1| |#1| (|List| (|Symbol|))
                                       (|List| (|NonNegativeInteger|))
                                       (|List| (|Mapping| |#1| |#1|))))
                                     T)
                                   '((|isPower|
                                      ((|Union|
                                        (|Record| (|:| |val| |#1|)
                                                  (|:| |exponent| (|Integer|)))
                                        #4#)
                                       |#1|))
                                     T)
                                   '((|isExpt|
                                      ((|Union|
                                        (|Record| (|:| |var| (|Kernel| |#1|))
                                                  (|:| |exponent| (|Integer|)))
                                        "failed")
                                       |#1| (|Symbol|)))
                                     T)
                                   '((|isExpt|
                                      ((|Union|
                                        (|Record| (|:| |var| (|Kernel| |#1|))
                                                  (|:| |exponent| (|Integer|)))
                                        "failed")
                                       |#1| (|BasicOperator|)))
                                     T)
                                   '((|numerator| (|#1| |#1|)) T)
                                   '((|coerce|
                                      (|#1|
                                       (|SparseMultivariatePolynomial| |#2|
                                                                       (|Kernel|
                                                                        |#1|))))
                                     T)
                                   '((|isMult|
                                      ((|Union|
                                        (|Record| (|:| |coef| (|Integer|))
                                                  (|:| |var| (|Kernel| |#1|)))
                                        #5#)
                                       |#1|))
                                     T)
                                   '((|isPlus|
                                      ((|Union| (|List| |#1|) "failed") |#1|))
                                     T)
                                   '((|isExpt|
                                      ((|Union|
                                        (|Record| (|:| |var| (|Kernel| |#1|))
                                                  (|:| |exponent| (|Integer|)))
                                        #2#)
                                       |#1|))
                                     T)
                                   '((|isTimes|
                                      ((|Union| (|List| |#1|) "failed") |#1|))
                                     T)
                                   '((|eval|
                                      (|#1| |#1| (|List| (|BasicOperator|))
                                       (|List| |#1|) (|Symbol|)))
                                     T)
                                   '((|eval|
                                      (|#1| |#1| (|BasicOperator|) |#1|
                                       (|Symbol|)))
                                     T)
                                   '((|applyQuote|
                                      (|#1| (|Symbol|) (|List| |#1|)))
                                     T)
                                   '((|applyQuote|
                                      (|#1| (|Symbol|) |#1| |#1| |#1| |#1|))
                                     T)
                                   '((|applyQuote|
                                      (|#1| (|Symbol|) |#1| |#1| |#1|))
                                     T)
                                   '((|applyQuote| (|#1| (|Symbol|) |#1| |#1|))
                                     T)
                                   '((|applyQuote| (|#1| (|Symbol|) |#1|)) T)
                                   '((|variables|
                                      ((|List| (|Symbol|)) (|List| |#1|)))
                                     T)
                                   '((|variables| ((|List| (|Symbol|)) |#1|))
                                     T)
                                   '((|ground| (|#2| |#1|)) T)
                                   '((|ground?| ((|Boolean|) |#1|)) T)
                                   '((|coerce| (|#1| |#2|)) T)
                                   '((|retractIfCan| ((|Union| |#2| #1#) |#1|))
                                     T)
                                   '((|retract| (|#2| |#1|)) T)
                                   '((|retract| ((|Integer|) |#1|)) T)
                                   '((|retractIfCan|
                                      ((|Union| (|Integer|) #1#) |#1|))
                                     T)
                                   '((|convert| ((|Pattern| (|Float|)) |#1|))
                                     T)
                                   '((|convert| ((|Pattern| (|Integer|)) |#1|))
                                     T)
                                   '((|coerce| (|#1| (|Symbol|))) T)
                                   '((|retractIfCan|
                                      ((|Union| (|Symbol|) #1#) |#1|))
                                     T)
                                   '((|retract| ((|Symbol|) |#1|)) T)
                                   '((|eval|
                                      (|#1| |#1| (|BasicOperator|)
                                       (|Mapping| |#1| |#1|)))
                                     T)
                                   '((|eval|
                                      (|#1| |#1| (|BasicOperator|)
                                       (|Mapping| |#1| (|List| |#1|))))
                                     T)
                                   '((|eval|
                                      (|#1| |#1| (|List| (|BasicOperator|))
                                       (|List|
                                        (|Mapping| |#1| (|List| |#1|)))))
                                     T)
                                   '((|eval|
                                      (|#1| |#1| (|List| (|BasicOperator|))
                                       (|List| (|Mapping| |#1| |#1|))))
                                     T)
                                   '((|eval|
                                      (|#1| |#1| (|Symbol|)
                                       (|Mapping| |#1| |#1|)))
                                     T)
                                   '((|eval|
                                      (|#1| |#1| (|Symbol|)
                                       (|Mapping| |#1| (|List| |#1|))))
                                     T)
                                   '((|eval|
                                      (|#1| |#1| (|List| (|Symbol|))
                                       (|List|
                                        (|Mapping| |#1| (|List| |#1|)))))
                                     T)
                                   '((|eval|
                                      (|#1| |#1| (|List| (|Symbol|))
                                       (|List| (|Mapping| |#1| |#1|))))
                                     T)
                                   '((|belong?|
                                      ((|Boolean|) (|BasicOperator|)))
                                     T)
                                   '((|operator|
                                      ((|BasicOperator|) (|BasicOperator|)))
                                     T)
                                   '((|kernels|
                                      ((|List| (|Kernel| |#1|)) (|List| |#1|)))
                                     T)
                                   '((|kernels|
                                      ((|List| (|Kernel| |#1|)) |#1|))
                                     T)
                                   '((|mainKernel|
                                      ((|Union| (|Kernel| |#1|) "failed")
                                       |#1|))
                                     T)
                                   '((|subst|
                                      (|#1| |#1| (|List| (|Kernel| |#1|))
                                       (|List| |#1|)))
                                     T)
                                   '((|subst|
                                      (|#1| |#1| (|List| (|Equation| |#1|))))
                                     T)
                                   '((|subst| (|#1| |#1| (|Equation| |#1|))) T)
                                   '((|elt|
                                      (|#1| (|BasicOperator|) (|List| |#1|)))
                                     T)
                                   '((|elt|
                                      (|#1| (|BasicOperator|) |#1| |#1| |#1|
                                       |#1| |#1| |#1| |#1| |#1| |#1|))
                                     T)
                                   '((|elt|
                                      (|#1| (|BasicOperator|) |#1| |#1| |#1|
                                       |#1| |#1| |#1| |#1| |#1|))
                                     T)
                                   '((|elt|
                                      (|#1| (|BasicOperator|) |#1| |#1| |#1|
                                       |#1| |#1| |#1| |#1|))
                                     T)
                                   '((|elt|
                                      (|#1| (|BasicOperator|) |#1| |#1| |#1|
                                       |#1| |#1| |#1|))
                                     T)
                                   '((|elt|
                                      (|#1| (|BasicOperator|) |#1| |#1| |#1|
                                       |#1| |#1|))
                                     T)
                                   '((|elt|
                                      (|#1| (|BasicOperator|) |#1| |#1| |#1|
                                       |#1|))
                                     T)
                                   '((|elt|
                                      (|#1| (|BasicOperator|) |#1| |#1| |#1|))
                                     T)
                                   '((|elt| (|#1| (|BasicOperator|) |#1| |#1|))
                                     T)
                                   '((|elt| (|#1| (|BasicOperator|) |#1|)) T)
                                   '((|eval|
                                      (|#1| |#1| (|List| |#1|) (|List| |#1|)))
                                     T)
                                   '((|eval| (|#1| |#1| |#1| |#1|)) T)
                                   '((|eval| (|#1| |#1| (|Equation| |#1|))) T)
                                   '((|eval|
                                      (|#1| |#1| (|List| (|Equation| |#1|))))
                                     T)
                                   '((|eval|
                                      (|#1| |#1| (|List| (|Kernel| |#1|))
                                       (|List| |#1|)))
                                     T)
                                   '((|eval| (|#1| |#1| (|Kernel| |#1|) |#1|))
                                     T)
                                   '((|coerce| (|#1| (|Kernel| |#1|))) T)
                                   '((|retractIfCan|
                                      ((|Union| (|Kernel| |#1|) #1#) |#1|))
                                     T)
                                   '((|retract| ((|Kernel| |#1|) |#1|)) T)
                                   '((|coerce| ((|OutputForm|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 342
                                            '(1 13 11 12 14 1 6 17 0 18 1 6 7 0
                                              21 1 23 0 12 24 1 6 0 25 26 1 6
                                              25 0 28 1 23 29 0 30 2 6 0 12 32
                                              33 1 6 0 12 38 2 6 0 11 32 39 2
                                              11 19 0 12 41 2 11 19 0 12 42 1
                                              23 11 0 44 1 23 45 0 46 2 6 0 11
                                              32 47 1 11 12 0 48 1 12 49 0 50 1
                                              12 52 0 53 1 52 0 32 54 1 45 6 0
                                              55 1 6 29 0 56 0 12 0 57 1 45 6 0
                                              58 3 6 0 0 25 0 59 2 6 19 0 0 60
                                              1 6 52 0 61 4 6 0 0 62 32 12 63 4
                                              0 0 0 11 0 12 64 2 66 65 6 12 67
                                              3 6 0 0 62 69 70 4 0 0 0 62 32 12
                                              71 3 11 0 0 12 72 73 1 6 74 32 75
                                              1 6 76 32 78 1 6 80 0 81 0 7 84
                                              85 0 0 84 86 1 87 0 23 88 1 6 0
                                              89 90 1 0 0 25 91 1 6 89 0 92 1 0
                                              0 0 93 1 45 6 0 94 4 6 0 0 76 95
                                              97 98 4 0 0 0 12 84 68 99 4 0 0 0
                                              12 84 96 100 2 95 0 84 84 101 3 0
                                              0 0 76 97 102 1 11 19 0 103 1 87
                                              7 0 104 0 7 0 105 2 7 19 0 0 106
                                              1 6 0 0 107 2 6 0 11 0 108 2 109
                                              0 11 32 110 2 0 0 11 32 111 4 0 0
                                              0 76 95 69 112 1 87 113 0 114 2
                                              87 115 0 23 116 2 120 117 118 119
                                              121 2 76 122 12 0 123 2 117 6 0 6
                                              124 0 6 0 125 2 127 126 0 122 128
                                              2 95 84 0 122 129 0 117 0 130 2
                                              117 19 0 0 131 1 117 84 0 132 2 6
                                              0 0 84 133 1 117 6 0 134 2 6 0 0
                                              0 135 2 6 0 0 0 136 1 117 0 0 137
                                              1 6 138 0 139 2 23 19 0 11 140 2
                                              141 122 138 0 142 3 141 138 0 122
                                              138 143 1 12 138 0 144 0 6 0 145
                                              1 122 138 0 146 2 138 0 0 0 147 2
                                              45 122 6 0 148 2 11 149 0 12 150
                                              2 138 0 0 0 151 2 138 0 0 84 152
                                              2 138 0 0 32 153 1 45 0 0 154 2
                                              45 6 0 122 155 3 45 6 0 122 6 156
                                              2 157 19 122 0 158 2 45 0 0 84
                                              159 2 45 0 0 84 160 2 45 0 0 0
                                              161 2 6 0 0 12 162 1 164 163 11
                                              165 2 166 0 6 6 167 2 6 0 0 168
                                              169 2 6 0 11 0 170 2 84 19 0 0
                                              171 2 6 19 0 0 172 1 173 0 7 174
                                              2 173 0 0 12 175 1 173 7 0 176 2
                                              87 0 177 0 178 1 87 179 0 180 2
                                              87 0 0 23 181 1 6 0 7 182 3 185 6
                                              183 184 173 186 1 0 0 173 187 2
                                              189 188 12 12 190 2 23 19 0 0 191
                                              1 87 17 0 192 1 7 138 0 193 0 189
                                              19 194 1 23 138 0 195 2 117 138 0
                                              138 196 3 6 0 0 74 32 197 4 199 6
                                              179 45 23 198 200 3 201 6 198 184
                                              87 202 3 6 0 0 74 32 203 2 6 0 68
                                              25 204 1 6 74 0 205 2 179 0 0 0
                                              206 1 179 19 0 207 1 173 0 12 208
                                              3 211 173 209 210 87 212 1 6 214
                                              0 215 2 0 214 0 11 216 2 23 19 0
                                              12 217 2 0 214 0 12 218 1 119 84
                                              0 219 1 119 0 0 220 1 119 87 0
                                              221 1 87 19 0 222 1 7 223 0 224 2
                                              164 11 11 126 225 2 11 19 0 0 226
                                              2 157 19 0 0 227 2 45 19 0 0 228
                                              1 0 80 0 229 1 0 74 0 230 1 87 7
                                              0 231 1 0 7 0 232 1 0 173 0 233 1
                                              0 17 0 234 1 0 235 0 236 3 0 0 0
                                              74 32 237 3 0 0 0 74 32 238 2 0 0
                                              0 12 239 1 0 138 0 240 4 0 0 0 76
                                              95 97 241 1 87 242 0 243 1 0 242
                                              0 244 1 87 242 0 245 1 0 242 0
                                              246 1 87 248 0 249 1 0 214 0 250
                                              1 0 252 0 253 1 87 254 0 255 1 0
                                              254 0 256 1 87 257 0 258 1 0 257
                                              0 259 1 0 261 0 262 1 87 0 7 263
                                              2 0 0 7 0 264 1 265 113 6 266 1
                                              265 179 6 267 2 265 268 6 23 269
                                              2 0 270 0 25 271 1 265 272 6 273
                                              1 265 272 6 274 1 265 276 6 277 1
                                              265 279 6 280 1 6 89 0 281 1 0 0
                                              0 282 1 283 7 0 284 1 283 7 0 285
                                              2 6 0 89 89 286 1 0 0 283 287 1
                                              288 173 0 289 1 6 0 173 290 1 288
                                              173 0 291 2 6 0 0 0 292 1 0 0 288
                                              293 1 295 294 0 296 1 6 0 294 297
                                              1 295 294 0 298 1 0 0 295 299 1 6
                                              288 0 300 1 288 173 0 301 2 288 0
                                              173 173 302 1 0 288 0 303 2 7 304
                                              0 0 305 1 6 74 0 306 2 23 19 0 0
                                              307 1 179 0 0 308 1 0 74 32 309 1
                                              6 74 32 310 1 0 74 0 311 0 87 0
                                              312 2 87 19 0 0 313 2 138 0 0 0
                                              314 2 6 0 0 0 315 2 6 0 0 122 316
                                              1 6 0 0 317 1 318 6 0 319 1 318
                                              322 0 323 1 0 0 324 325 1 6 326 0
                                              327 1 288 235 0 328 1 0 326 0 329
                                              1 6 0 283 330 3 332 6 183 331 294
                                              333 1 0 0 294 334 1 335 122 0 336
                                              1 87 0 122 337 1 335 122 0 338 1
                                              0 0 335 339 2 122 304 0 0 340 2
                                              254 0 0 0 341 2 257 0 0 0 342 1 0
                                              76 32 77 1 0 76 0 79 2 0 270 0 25
                                              271 3 0 0 0 74 32 238 1 0 235 0
                                              236 1 0 326 0 329 1 0 17 0 234 1
                                              0 29 0 82 1 0 173 0 233 1 0 288 0
                                              303 1 0 7 0 232 1 0 12 0 31 1 0
                                              11 11 51 1 0 0 0 93 1 0 80 0 229
                                              1 0 74 0 230 1 0 242 0 246 1 0
                                              252 0 253 1 0 242 0 244 1 0 261 0
                                              262 2 0 214 0 12 218 2 0 214 0 11
                                              216 1 0 214 0 250 1 0 19 0 20 1 0
                                              7 0 22 4 0 0 0 12 84 68 99 4 0 0
                                              0 76 95 97 241 4 0 0 0 12 84 96
                                              100 4 0 0 0 76 95 69 112 4 0 0 0
                                              62 32 12 71 4 0 0 0 11 0 12 64 3
                                              0 0 0 76 97 102 3 0 0 0 74 32 237
                                              2 0 0 11 32 111 2 0 0 0 12 239 1
                                              0 0 0 282 1 0 0 324 325 1 0 254 0
                                              256 1 0 257 0 259 1 0 0 173 187 1
                                              0 0 288 293 1 0 0 335 339 1 0 0
                                              294 334 1 0 0 295 299 1 0 0 283
                                              287 1 0 0 12 27 1 0 0 25 91 1 0
                                              138 0 240 0 0 84 86 1 0 19 11 43
                                              2 0 0 12 32 40 4 0 0 12 0 0 0 36
                                              5 0 0 12 0 0 0 0 37 3 0 0 12 0 0
                                              35 2 0 0 12 0 34 1 0 74 32 309 1
                                              0 74 0 311 2 0 0 7 0 264)))))
           '|lookupComplete|)) 
