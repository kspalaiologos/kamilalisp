
(SDEFUN |GUESS;guessExpRat;LL;1| ((|list| (|List| F)) ($ (|List| EXPRR)))
        (SPADCALL |list| NIL (QREFELT $ 15))) 

(SDEFUN |GUESS;guessExpRat;LLL;2|
        ((|list| (|List| F)) (|options| (|List| (|GuessOption|)))
         ($ (|List| EXPRR)))
        (SPADCALL |list| |options| (QREFELT $ 15))) 

(SDEFUN |GUESS;guessBinRat;LL;3| ((|list| (|List| F)) ($ (|List| EXPRR)))
        (SPADCALL |list| NIL (QREFELT $ 18))) 

(SDEFUN |GUESS;guessBinRat;LLL;4|
        ((|list| (|List| F)) (|options| (|List| (|GuessOption|)))
         ($ (|List| EXPRR)))
        (SPADCALL |list| |options| (QREFELT $ 18))) 

(SDEFUN |GUESS;guessExpRat;SM;5|
        ((|q| (|Symbol|))
         ($ (|Mapping| (|List| EXPRR) (|List| F) (|List| (|GuessOption|)))))
        (SPADCALL |q| (QREFELT $ 23))) 

(SDEFUN |GUESS;guessBinRat;SM;6|
        ((|q| (|Symbol|))
         ($ (|Mapping| (|List| EXPRR) (|List| F) (|List| (|GuessOption|)))))
        (SPADCALL |q| (QREFELT $ 25))) 

(SDEFUN |GUESS;getVariables| ((|lF| (|List| F)) ($ (|List| EXPRR)))
        (SPROG
         ((|lvar| (|List| (|Symbol|))) (|ll| (|List| (|List| (|Symbol|)))))
         (SEQ (LETT |lvar| NIL)
              (COND
               ((|HasSignature| (QREFELT $ 7)
                                (LIST '|variables|
                                      (LIST (LIST '|List| '(|Symbol|))
                                            (|devaluate| (QREFELT $ 7)))))
                (SEQ
                 (COND
                  ((|domainEqual| (QREFELT $ 6) (QREFELT $ 7))
                   (LETT |ll| (SPADCALL (ELT $ 28) |lF| (QREFELT $ 33))))
                  ((|domainEqual| (QREFELT $ 6) (|Fraction| (QREFELT $ 7)))
                   (LETT |ll|
                         (SPADCALL (CONS #'|GUESS;getVariables!0| $) |lF|
                                   (QREFELT $ 40))))
                  (#1='T
                   (|error|
                    (SPADCALL "Guess: type parameter F should be either"
                              " equal to S or equal to Fraction S"
                              (QREFELT $ 42)))))
                 (EXIT
                  (LETT |lvar| (SPADCALL (ELT $ 37) |ll| (QREFELT $ 44))))))
               (#1# (LETT |lvar| NIL)))
              (EXIT (SPADCALL (ELT $ 45) |lvar| (QREFELT $ 48)))))) 

(SDEFUN |GUESS;getVariables!0| ((|g| NIL) ($ NIL))
        (SPADCALL (SPADCALL (SPADCALL |g| (QREFELT $ 35)) (QREFELT $ 28))
                  (SPADCALL (SPADCALL |g| (QREFELT $ 36)) (QREFELT $ 28))
                  (QREFELT $ 37))) 

(SDEFUN |GUESS;SUPS2SUPF|
        ((|p| (|SparseUnivariatePolynomial| S))
         ($ (|SparseUnivariatePolynomial| F)))
        (COND ((|domainEqual| (QREFELT $ 6) (QREFELT $ 7)) |p|)
              ((|domainEqual| (QREFELT $ 6) (|Fraction| (QREFELT $ 7)))
               (SPADCALL (ELT $ 49) |p| (QREFELT $ 54)))
              ('T
               (|error|
                (SPADCALL "Guess: type parameter F should be either"
                          " equal to S or equal to Fraction S"
                          (QREFELT $ 42)))))) 

(SDEFUN |GUESS;FilteredPartitionStream|
        ((|options| (|List| (|GuessOption|)))
         ($ (|Stream| (|List| (|Integer|)))))
        (SPROG
         ((|s| (|Stream| (|List| (|Integer|))))
          (|s3| (|Stream| (|List| (|Integer|))))
          (|s2| (|Stream| (|Stream| (|List| (|Integer|)))))
          (|s1| (|Stream| (|Integer|)))
          (|maxD| (|Union| (|NonNegativeInteger|) "arbitrary"))
          (|Somo| (|Union| (|PositiveInteger|) (|Boolean|)))
          (|maxP| (|Union| (|PositiveInteger|) "arbitrary"))
          (|homo| (|Union| (|PositiveInteger|) (|Boolean|))))
         (SEQ (LETT |maxP| (SPADCALL |options| (QREFELT $ 57)))
              (LETT |homo| (SPADCALL |options| (QREFELT $ 59)))
              (COND
               ((QEQCAR |homo| 1)
                (COND
                 ((QCDR |homo|)
                  (EXIT
                   (|error|
                    (SPADCALL "Guess: internal error - homogeneous should not"
                              " be true in FilteredPartitionStream"
                              (QREFELT $ 42)))))))
               (#1='T (LETT |maxP| (CONS 0 (QCDR |homo|)))))
              (LETT |maxD| (SPADCALL |options| (QREFELT $ 61)))
              (LETT |Somo| (SPADCALL |options| (QREFELT $ 62)))
              (COND
               ((QEQCAR |Somo| 1)
                (COND
                 ((QCDR |Somo|)
                  (EXIT
                   (|error|
                    (SPADCALL "Guess: internal error - Somos should not be"
                              " true in FilteredPartitionStream"
                              (QREFELT $ 42)))))))
               ((QEQCAR |maxD| 0)
                (LETT |maxD| (CONS 0 (MIN (QCDR |maxD|) (QCDR |Somo|)))))
               (#1# (LETT |maxD| (CONS 0 (QCDR |Somo|)))))
              (COND
               ((QEQCAR |maxD| 0)
                (COND
                 ((QEQCAR |maxP| 0)
                  (LETT |s|
                        (SPADCALL (+ (QCDR |maxD|) 1) (QCDR |maxP|)
                                  (QREFELT $ 66))))
                 (#1#
                  (SEQ (LETT |s1| (SPADCALL (ELT $ 67) 1 (QREFELT $ 70)))
                       (LETT |s2|
                             (COND
                              ((QEQCAR |maxD| 0)
                               (SPADCALL
                                (CONS #'|GUESS;FilteredPartitionStream!0|
                                      (VECTOR $ |maxD|))
                                |s1| (QREFELT $ 81)))
                              ((QEQCAR |maxP| 0)
                               (SPADCALL
                                (CONS #'|GUESS;FilteredPartitionStream!1|
                                      (VECTOR $ |maxP|))
                                |s1| (QREFELT $ 81)))
                              (#1# (SPADCALL (ELT $ 82) |s1| (QREFELT $ 81)))))
                       (LETT |s3| (SPADCALL |s2| (QREFELT $ 84)))
                       (EXIT (LETT |s| (SPADCALL NIL |s3| (QREFELT $ 86))))))))
               (#1#
                (SEQ (LETT |s1| (SPADCALL (ELT $ 67) 1 (QREFELT $ 70)))
                     (LETT |s2|
                           (COND
                            ((QEQCAR |maxD| 0)
                             (SPADCALL
                              (CONS #'|GUESS;FilteredPartitionStream!2|
                                    (VECTOR $ |maxD|))
                              |s1| (QREFELT $ 81)))
                            ((QEQCAR |maxP| 0)
                             (SPADCALL
                              (CONS #'|GUESS;FilteredPartitionStream!3|
                                    (VECTOR $ |maxP|))
                              |s1| (QREFELT $ 81)))
                            (#1# (SPADCALL (ELT $ 82) |s1| (QREFELT $ 81)))))
                     (LETT |s3| (SPADCALL |s2| (QREFELT $ 84)))
                     (EXIT (LETT |s| (SPADCALL NIL |s3| (QREFELT $ 86)))))))
              (LETT |s| (SPADCALL |s| (QREFELT $ 87)))
              (COND
               ((QEQCAR |homo| 0)
                (LETT |s|
                      (SPADCALL
                       (CONS #'|GUESS;FilteredPartitionStream!4|
                             (VECTOR |maxP| $))
                       |s| (QREFELT $ 92)))))
              (COND
               ((QEQCAR |Somo| 0)
                (LETT |s|
                      (SPADCALL
                       (CONS #'|GUESS;FilteredPartitionStream!5|
                             (VECTOR |Somo| $))
                       |s| (QREFELT $ 92)))))
              (EXIT |s|)))) 

(SDEFUN |GUESS;FilteredPartitionStream!5| ((|z1| NIL) ($$ NIL))
        (PROG ($ |Somo|)
          (LETT $ (QREFELT $$ 1))
          (LETT |Somo| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL (ELT $ 94) |z1| (|spadConstant| $ 95) (QREFELT $ 97))
             (SPADCALL (QCDR |Somo|) (SPADCALL |z1| (QREFELT $ 88))
                       (QREFELT $ 76))
             (QREFELT $ 98)))))) 

(SDEFUN |GUESS;FilteredPartitionStream!4| ((|z1| NIL) ($$ NIL))
        (PROG ($ |maxP|)
          (LETT $ (QREFELT $$ 1))
          (LETT |maxP| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G846 NIL))
                   (SPADCALL (SPADCALL |z1| (QREFELT $ 88))
                             (PROG2 (LETT #1# |maxP|)
                                 (QCDR #1#)
                               (|check_union2| (QEQCAR #1# 0)
                                               (|PositiveInteger|)
                                               (|Union| (|PositiveInteger|)
                                                        "arbitrary")
                                               #1#))
                             (QREFELT $ 90))))))) 

(SDEFUN |GUESS;FilteredPartitionStream!3| ((|z1| NIL) ($$ NIL))
        (PROG (|maxP| $)
          (LETT |maxP| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z1| (QCDR |maxP|) |z1| (QREFELT $ 77)))))) 

(SDEFUN |GUESS;FilteredPartitionStream!2| ((|z1| NIL) ($$ NIL))
        (PROG (|maxD| $)
          (LETT |maxD| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL (QCDR |maxD|) (|spadConstant| $ 74) (QREFELT $ 76)) |z1|
             |z1| (QREFELT $ 77)))))) 

(SDEFUN |GUESS;FilteredPartitionStream!1| ((|z1| NIL) ($$ NIL))
        (PROG (|maxP| $)
          (LETT |maxP| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z1| (QCDR |maxP|) |z1| (QREFELT $ 77)))))) 

(SDEFUN |GUESS;FilteredPartitionStream!0| ((|z1| NIL) ($$ NIL))
        (PROG (|maxD| $)
          (LETT |maxD| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL (QCDR |maxD|) (|spadConstant| $ 74) (QREFELT $ 76)) |z1|
             |z1| (QREFELT $ 77)))))) 

(SDEFUN |GUESS;termAsEXPRR|
        ((|f| (EXPRR)) (|xx| (|Symbol|)) (|partition| (|List| (|Integer|)))
         (DX (|Mapping| EXPRR EXPRR (|Symbol|) (|NonNegativeInteger|)))
         (D1X (|Mapping| EXPRR (|Symbol|))) ($ (EXPRR)))
        (SPROG
         ((|fl| (|List| EXPRR)) (#1=#:G887 NIL) (#2=#:G886 NIL) (#3=#:G895 NIL)
          (|part| NIL) (#4=#:G894 NIL) (|ll| (|List| (|List| (|Integer|)))))
         (SEQ
          (COND ((NULL |partition|) (SPADCALL |xx| D1X))
                ('T
                 (SEQ (LETT |ll| (SPADCALL |partition| (QREFELT $ 101)))
                      (LETT |fl|
                            (PROGN
                             (LETT #4# NIL)
                             (SEQ (LETT |part| NIL) (LETT #3# |ll|) G190
                                  (COND
                                   ((OR (ATOM #3#)
                                        (PROGN (LETT |part| (CAR #3#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #4#
                                          (CONS
                                           (SPADCALL
                                            (SPADCALL |f| |xx|
                                                      (PROG1
                                                          (LETT #2#
                                                                (-
                                                                 (|SPADfirst|
                                                                  |part|)
                                                                 1))
                                                        (|check_subtype2|
                                                         (>= #2# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #2#))
                                                      DX)
                                            (PROG1
                                                (LETT #1#
                                                      (SPADCALL |part|
                                                                (QREFELT $
                                                                         102)))
                                              (|check_subtype2| (>= #1# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #1#))
                                            (QREFELT $ 103))
                                           #4#))))
                                  (LETT #3# (CDR #3#)) (GO G190) G191
                                  (EXIT (NREVERSE #4#)))))
                      (EXIT (SPADCALL (ELT $ 104) |fl| (QREFELT $ 106))))))))) 

(SDEFUN |GUESS;termAsU32VectorDiff|
        ((|f| (|U32Vector|)) (|partition| (|List| (|Integer|)))
         (|prime| (|Integer|)) (|degreeLoss| (|NonNegativeInteger|))
         ($ (|U32Vector|)))
        (SPROG
         ((|fl| (|List| (|U32Vector|))) (#1=#:G901 NIL) (#2=#:G900 NIL)
          (#3=#:G910 NIL) (|part| NIL) (#4=#:G909 NIL)
          (|ll| (|List| (|List| (|Integer|)))) (|d| (|NonNegativeInteger|))
          (#5=#:G898 NIL) (#6=#:G908 NIL) (|i| NIL) (#7=#:G907 NIL))
         (SEQ
          (COND
           ((NULL |partition|)
            (SPADCALL
             (CONS 1
                   (PROGN
                    (LETT #7# NIL)
                    (SEQ (LETT |i| (+ |degreeLoss| 2))
                         (LETT #6# (QV_LEN_U32 |f|)) G190
                         (COND ((> |i| #6#) (GO G191)))
                         (SEQ (EXIT (LETT #7# (CONS 0 #7#))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191
                         (EXIT (NREVERSE #7#)))))
             (QREFELT $ 108)))
           ('T
            (SEQ
             (LETT |d|
                   (PROG1 (LETT #5# (- (- (QV_LEN_U32 |f|) |degreeLoss|) 1))
                     (|check_subtype2| (>= #5# 0) '(|NonNegativeInteger|)
                                       '(|Integer|) #5#)))
             (LETT |ll| (SPADCALL |partition| (QREFELT $ 101)))
             (LETT |fl|
                   (PROGN
                    (LETT #4# NIL)
                    (SEQ (LETT |part| NIL) (LETT #3# |ll|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |part| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT #4#
                                 (CONS
                                  (SPADCALL
                                   (SPADCALL |f|
                                             (PROG1
                                                 (LETT #2#
                                                       (- (|SPADfirst| |part|)
                                                          1))
                                               (|check_subtype2| (>= #2# 0)
                                                                 '(|NonNegativeInteger|)
                                                                 '(|Integer|)
                                                                 #2#))
                                             |prime| (QREFELT $ 110))
                                   (PROG1
                                       (LETT #1#
                                             (SPADCALL |part| (QREFELT $ 102)))
                                     (|check_subtype2| (> #1# 0)
                                                       '(|PositiveInteger|)
                                                       '(|Integer|) #1#))
                                   |d| |prime| (QREFELT $ 111))
                                  #4#))))
                         (LETT #3# (CDR #3#)) (GO G190) G191
                         (EXIT (NREVERSE #4#)))))
             (EXIT
              (SPADCALL
               (CONS #'|GUESS;termAsU32VectorDiff!0| (VECTOR $ |prime| |d|))
               |fl| (QREFELT $ 115))))))))) 

(SDEFUN |GUESS;termAsU32VectorDiff!0| ((|f1| NIL) (|f2| NIL) ($$ NIL))
        (PROG (|d| |prime| $)
          (LETT |d| (QREFELT $$ 2))
          (LETT |prime| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |f1| |f2| |d| |prime| (QREFELT $ 112)))))) 

(SDEFUN |GUESS;termAsU32VectorShift|
        ((|f| (|U32Vector|)) (|partition| (|List| (|Integer|)))
         (|prime| (|Integer|)) (|degreeLoss| (|NonNegativeInteger|))
         ($ (|U32Vector|)))
        (SPROG
         ((#1=#:G933 NIL) (|e| NIL) (#2=#:G932 NIL) (|i| NIL)
          (|r| (|U32Vector|)) (|fl| (|List| (|U32Vector|))) (#3=#:G916 NIL)
          (#4=#:G931 NIL) (|j| NIL) (#5=#:G930 NIL) (#6=#:G929 NIL)
          (|part| NIL) (#7=#:G928 NIL) (|ll| (|List| (|List| (|Integer|))))
          (|d| (|NonNegativeInteger|)) (#8=#:G913 NIL) (#9=#:G927 NIL)
          (#10=#:G926 NIL))
         (SEQ
          (COND
           ((NULL |partition|)
            (SPADCALL
             (PROGN
              (LETT #10# NIL)
              (SEQ (LETT |i| (+ |degreeLoss| 1)) (LETT #9# (QV_LEN_U32 |f|))
                   G190 (COND ((> |i| #9#) (GO G191)))
                   (SEQ (EXIT (LETT #10# (CONS 1 #10#)))) (LETT |i| (+ |i| 1))
                   (GO G190) G191 (EXIT (NREVERSE #10#))))
             (QREFELT $ 108)))
           ('T
            (SEQ
             (LETT |d|
                   (PROG1 (LETT #8# (- (- (QV_LEN_U32 |f|) |degreeLoss|) 1))
                     (|check_subtype2| (>= #8# 0) '(|NonNegativeInteger|)
                                       '(|Integer|) #8#)))
             (LETT |ll| (SPADCALL |partition| (QREFELT $ 101)))
             (LETT |fl|
                   (PROGN
                    (LETT #7# NIL)
                    (SEQ (LETT |part| NIL) (LETT #6# |ll|) G190
                         (COND
                          ((OR (ATOM #6#) (PROGN (LETT |part| (CAR #6#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT #7#
                                 (CONS
                                  (SPADCALL
                                   (PROGN
                                    (LETT #5# NIL)
                                    (SEQ (LETT |j| (- (|SPADfirst| |part|) 1))
                                         (LETT #4#
                                               (+ (- (|SPADfirst| |part|) 1)
                                                  |d|))
                                         G190 (COND ((> |j| #4#) (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (LETT #5#
                                                 (CONS
                                                  (REM
                                                   (EXPT (ELT_U32 |f| |j|)
                                                         (PROG1
                                                             (LETT #3#
                                                                   (SPADCALL
                                                                    |part|
                                                                    (QREFELT $
                                                                             102)))
                                                           (|check_subtype2|
                                                            (> #3# 0)
                                                            '(|PositiveInteger|)
                                                            '(|Integer|) #3#)))
                                                   |prime|)
                                                  #5#))))
                                         (LETT |j| (+ |j| 1)) (GO G190) G191
                                         (EXIT (NREVERSE #5#))))
                                   (QREFELT $ 108))
                                  #7#))))
                         (LETT #6# (CDR #6#)) (GO G190) G191
                         (EXIT (NREVERSE #7#)))))
             (LETT |r| (GETREFV_U32 (+ |d| 1) 0))
             (SPADCALL |r| (|SPADfirst| |fl|) (+ |d| 1) (QREFELT $ 117))
             (SEQ (LETT |i| 0) (LETT #2# |d|) G190
                  (COND ((|greater_SI| |i| #2#) (GO G191)))
                  (SEQ
                   (EXIT
                    (SEQ (LETT |e| NIL) (LETT #1# (CDR |fl|)) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |e| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (SETELT_U32 |r| |i|
                                       (QSMULMOD32 (ELT_U32 |r| |i|)
                                                   (ELT_U32 |e| |i|)
                                                   |prime|))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))))
                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
             (EXIT |r|))))))) 

(SDEFUN |GUESS;termAsUFPSF|
        ((|f| (|UnivariateFormalPowerSeries| F))
         (|partition| (|List| (|Integer|)))
         (DS
          (|Mapping| (|UnivariateFormalPowerSeries| F)
                     (|UnivariateFormalPowerSeries| F) (|NonNegativeInteger|)))
         (D1 (|UnivariateFormalPowerSeries| F))
         ($ (|UnivariateFormalPowerSeries| F)))
        (SPROG
         ((|fl| (|List| (|UnivariateFormalPowerSeries| F))) (#1=#:G944 NIL)
          (#2=#:G943 NIL) (#3=#:G952 NIL) (|part| NIL) (#4=#:G951 NIL)
          (|ll| (|List| (|List| (|Integer|)))))
         (SEQ
          (COND ((NULL |partition|) D1)
                ('T
                 (SEQ (LETT |ll| (SPADCALL |partition| (QREFELT $ 101)))
                      (LETT |fl|
                            (PROGN
                             (LETT #4# NIL)
                             (SEQ (LETT |part| NIL) (LETT #3# |ll|) G190
                                  (COND
                                   ((OR (ATOM #3#)
                                        (PROGN (LETT |part| (CAR #3#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #4#
                                          (CONS
                                           (SPADCALL
                                            (SPADCALL |f|
                                                      (PROG1
                                                          (LETT #2#
                                                                (-
                                                                 (|SPADfirst|
                                                                  |part|)
                                                                 1))
                                                        (|check_subtype2|
                                                         (>= #2# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #2#))
                                                      DS)
                                            (PROG1
                                                (LETT #1#
                                                      (SPADCALL |part|
                                                                (QREFELT $
                                                                         102)))
                                              (|check_subtype2| (>= #1# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #1#))
                                            (QREFELT $ 119))
                                           #4#))))
                                  (LETT #3# (CDR #3#)) (GO G190) G191
                                  (EXIT (NREVERSE #4#)))))
                      (EXIT (SPADCALL (ELT $ 120) |fl| (QREFELT $ 123))))))))) 

(SDEFUN |GUESS;termAsUFPSF2|
        ((|f| (|UnivariateFormalPowerSeries| F))
         (|partition| (|List| (|Integer|)))
         (DS
          (|Mapping| (|UnivariateFormalPowerSeries| F)
                     (|UnivariateFormalPowerSeries| F) (|NonNegativeInteger|)))
         (D1 (|UnivariateFormalPowerSeries| F))
         ($ (|UnivariateFormalPowerSeries| F)))
        (SPROG
         ((|fl| (|List| (|UnivariateFormalPowerSeries| F))) (#1=#:G957 NIL)
          (#2=#:G965 NIL) (|part| NIL) (#3=#:G964 NIL)
          (|ll| (|List| (|List| (|Integer|)))))
         (SEQ
          (COND ((NULL |partition|) D1)
                ('T
                 (SEQ (LETT |ll| (SPADCALL |partition| (QREFELT $ 101)))
                      (LETT |fl|
                            (PROGN
                             (LETT #3# NIL)
                             (SEQ (LETT |part| NIL) (LETT #2# |ll|) G190
                                  (COND
                                   ((OR (ATOM #2#)
                                        (PROGN (LETT |part| (CAR #2#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #3#
                                          (CONS
                                           (SPADCALL
                                            (CONS #'|GUESS;termAsUFPSF2!0|
                                                  (VECTOR $ |part|))
                                            (SPADCALL |f|
                                                      (PROG1
                                                          (LETT #1#
                                                                (-
                                                                 (|SPADfirst|
                                                                  |part|)
                                                                 1))
                                                        (|check_subtype2|
                                                         (>= #1# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #1#))
                                                      DS)
                                            (QREFELT $ 126))
                                           #3#))))
                                  (LETT #2# (CDR #2#)) (GO G190) G191
                                  (EXIT (NREVERSE #3#)))))
                      (EXIT (SPADCALL (ELT $ 128) |fl| (QREFELT $ 123))))))))) 

(SDEFUN |GUESS;termAsUFPSF2!0| ((|z1| NIL) ($$ NIL))
        (PROG (|part| $)
          (LETT |part| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G955 NIL))
                   (SPADCALL |z1|
                             (PROG1
                                 (LETT #1# (SPADCALL |part| (QREFELT $ 102)))
                               (|check_subtype2| (>= #1# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #1#))
                             (QREFELT $ 124))))))) 

(SDEFUN |GUESS;termAsUFPSSUPF2|
        ((|f|
          (|UnivariateFormalPowerSeries|
           (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
         (|partition| (|List| (|Integer|)))
         (DSF
          (|Mapping|
           (|UnivariateFormalPowerSeries|
            (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))
           (|UnivariateFormalPowerSeries|
            (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))
           (|NonNegativeInteger|)))
         (D1F
          (|UnivariateFormalPowerSeries|
           (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
         ($
          (|UnivariateFormalPowerSeries|
           (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))))
        (SPROG
         ((|fl|
           (|List|
            (|UnivariateFormalPowerSeries|
             (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))))
          (#1=#:G972 NIL) (#2=#:G980 NIL) (|part| NIL) (#3=#:G979 NIL)
          (|ll| (|List| (|List| (|Integer|)))))
         (SEQ
          (COND ((NULL |partition|) D1F)
                ('T
                 (SEQ (LETT |ll| (SPADCALL |partition| (QREFELT $ 101)))
                      (LETT |fl|
                            (PROGN
                             (LETT #3# NIL)
                             (SEQ (LETT |part| NIL) (LETT #2# |ll|) G190
                                  (COND
                                   ((OR (ATOM #2#)
                                        (PROGN (LETT |part| (CAR #2#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #3#
                                          (CONS
                                           (SPADCALL
                                            (CONS #'|GUESS;termAsUFPSSUPF2!0|
                                                  (VECTOR $ |part|))
                                            (SPADCALL |f|
                                                      (PROG1
                                                          (LETT #1#
                                                                (-
                                                                 (|SPADfirst|
                                                                  |part|)
                                                                 1))
                                                        (|check_subtype2|
                                                         (>= #1# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #1#))
                                                      DSF)
                                            (QREFELT $ 133))
                                           #3#))))
                                  (LETT #2# (CDR #2#)) (GO G190) G191
                                  (EXIT (NREVERSE #3#)))))
                      (EXIT (SPADCALL (ELT $ 135) |fl| (QREFELT $ 138))))))))) 

(SDEFUN |GUESS;termAsUFPSSUPF2!0| ((|z1| NIL) ($$ NIL))
        (PROG (|part| $)
          (LETT |part| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G970 NIL))
                   (SPADCALL |z1|
                             (PROG1
                                 (LETT #1# (SPADCALL |part| (QREFELT $ 102)))
                               (|check_subtype2| (>= #1# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #1#))
                             (QREFELT $ 130))))))) 

(SDEFUN |GUESS;ADEguessStream|
        ((|f| (|UnivariateFormalPowerSeries| F))
         (|partitions| (|Stream| (|List| (|Integer|))))
         (DS
          (|Mapping| (|UnivariateFormalPowerSeries| F)
                     (|UnivariateFormalPowerSeries| F) (|NonNegativeInteger|)))
         (D1 (|UnivariateFormalPowerSeries| F))
         ($ (|Stream| (|UnivariateFormalPowerSeries| F))))
        (SPROG NIL
               (SPADCALL (CONS #'|GUESS;ADEguessStream!0| (VECTOR $ D1 DS |f|))
                         |partitions| (QREFELT $ 142)))) 

(SDEFUN |GUESS;ADEguessStream!0| ((|z1| NIL) ($$ NIL))
        (PROG (|f| DS D1 $)
          (LETT |f| (QREFELT $$ 3))
          (LETT DS (QREFELT $$ 2))
          (LETT D1 (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GUESS;termAsUFPSF| |f| |z1| DS D1 $))))) 

(SDEFUN |GUESS;ADEguessStream2|
        ((|f| (|UnivariateFormalPowerSeries| F))
         (|partitions| (|Stream| (|List| (|Integer|))))
         (DS
          (|Mapping| (|UnivariateFormalPowerSeries| F)
                     (|UnivariateFormalPowerSeries| F) (|NonNegativeInteger|)))
         (D1 (|UnivariateFormalPowerSeries| F))
         ($ (|Stream| (|UnivariateFormalPowerSeries| F))))
        (SPROG NIL
               (SPADCALL
                (CONS #'|GUESS;ADEguessStream2!0| (VECTOR $ D1 DS |f|))
                |partitions| (QREFELT $ 142)))) 

(SDEFUN |GUESS;ADEguessStream2!0| ((|z1| NIL) ($$ NIL))
        (PROG (|f| DS D1 $)
          (LETT |f| (QREFELT $$ 3))
          (LETT DS (QREFELT $$ 2))
          (LETT D1 (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GUESS;termAsUFPSF2| |f| |z1| DS D1 $))))) 

(SDEFUN |GUESS;guessModGenCached|
        ((|cache| (|PrimitiveArray| (|U32Vector|)))
         (|np| (|NonNegativeInteger|)) (|sigma| (|Integer|))
         (|addOne| (|Boolean|)) (|maxD| (|NonNegativeInteger|))
         (|prodl| (|List| (|List| (|Integer|)))) (|terml| (|List| (|Integer|)))
         (|prime| (|Integer|)) ($ (|Vector| (|U32Vector|))))
        (SPROG
         ((#1=#:G1005 NIL) (|i| NIL) (#2=#:G1006 NIL) (|r| NIL)
          (|res| (|Vector| (|U32Vector|))) (#3=#:G1003 NIL) (#4=#:G1004 NIL)
          (|res1| (|U32Vector|)) (#5=#:G992 NIL) (|nt| (|NonNegativeInteger|))
          (#6=#:G1001 NIL) (#7=#:G1002 NIL) (|pp| NIL))
         (SEQ
          (SEQ (LETT |pp| NIL) (LETT #7# |prodl|) (LETT |i| (+ |maxD| 1))
               (LETT #6# (+ |maxD| |np|)) G190
               (COND
                ((OR (> |i| #6#) (ATOM #7#) (PROGN (LETT |pp| (CAR #7#)) NIL))
                 (GO G191)))
               (SEQ
                (EXIT
                 (QSETAREF1 |cache| |i|
                            (SPADCALL (QAREF1 |cache| (|SPADfirst| |pp|))
                                      (QAREF1 |cache|
                                              (SPADCALL |pp| (QREFELT $ 102)))
                                      (- |sigma| 1) |prime| (QREFELT $ 112)))))
               (LETT |i| (PROG1 (+ |i| 1) (LETT #7# (CDR #7#)))) (GO G190) G191
               (EXIT NIL))
          (LETT |nt| (LENGTH |terml|))
          (COND
           (|addOne|
            (SEQ (LETT |res| (MAKEARR1 (+ |nt| 1) (GETREFV_U32 0 0)))
                 (LETT |res1|
                       (GETREFV_U32
                        (PROG1 (LETT #5# |sigma|)
                          (|check_subtype2| (>= #5# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #5#))
                        0))
                 (SETELT_U32 |res1| 0 1)
                 (SPADCALL |res| 1 |res1| (QREFELT $ 146))
                 (EXIT
                  (SEQ (LETT |r| NIL) (LETT #4# |terml|) (LETT |i| 2)
                       (LETT #3# (+ |nt| 1)) G190
                       (COND
                        ((OR (|greater_SI| |i| #3#) (ATOM #4#)
                             (PROGN (LETT |r| (CAR #4#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (SPADCALL |res| |i| (QAREF1 |cache| |r|)
                                   (QREFELT $ 146))))
                       (LETT |i| (PROG1 (|inc_SI| |i|) (LETT #4# (CDR #4#))))
                       (GO G190) G191 (EXIT NIL)))))
           ('T
            (SEQ (LETT |res| (MAKEARR1 |nt| (GETREFV_U32 0 0)))
                 (EXIT
                  (SEQ (LETT |r| NIL) (LETT #2# |terml|) (LETT |i| 1)
                       (LETT #1# |nt|) G190
                       (COND
                        ((OR (|greater_SI| |i| #1#) (ATOM #2#)
                             (PROGN (LETT |r| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (SPADCALL |res| |i| (QAREF1 |cache| |r|)
                                   (QREFELT $ 146))))
                       (LETT |i| (PROG1 (|inc_SI| |i|) (LETT #2# (CDR #2#))))
                       (GO G190) G191 (EXIT NIL))))))
          (EXIT |res|)))) 

(SDEFUN |GUESS;DEPguessModGenCached|
        ((|fl| (|List| (|U32Vector|))) (|addOne| (|Boolean|))
         (|maxD| (|NonNegativeInteger|))
         (|prodl| (|List| (|List| (|Integer|)))) (|terml| (|List| (|Integer|)))
         (|prime| (|Integer|)) ($ (|Vector| (|U32Vector|))))
        (SPROG
         ((#1=#:G1012 NIL) (|i| NIL) (#2=#:G1013 NIL)
          (|cache| (|PrimitiveArray| (|U32Vector|)))
          (|np| (|NonNegativeInteger|)) (|sigma| (|NonNegativeInteger|))
          (|f| (|U32Vector|)))
         (SEQ
          (COND
           ((< (LENGTH |fl|) (+ |maxD| 1))
            (|error| "DEPguessModGenCached: #fl < maxD + 1"))
           ('T
            (SEQ (LETT |f| (|SPADfirst| |fl|)) (LETT |sigma| (QV_LEN_U32 |f|))
                 (LETT |np| (LENGTH |prodl|))
                 (LETT |cache|
                       (MAKEARR1 (+ (+ |maxD| 1) |np|) (GETREFV_U32 0 0)))
                 (SEQ (LETT #2# |fl|) (LETT |i| 0) (LETT #1# |maxD|) G190
                      (COND
                       ((OR (|greater_SI| |i| #1#) (ATOM #2#)
                            (PROGN (LETT |f| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (QSETAREF1 |cache| |i| |f|)))
                      (LETT |i| (PROG1 (|inc_SI| |i|) (LETT #2# (CDR #2#))))
                      (GO G190) G191 (EXIT NIL))
                 (EXIT
                  (|GUESS;guessModGenCached| |cache| |np| |sigma| |addOne|
                   |maxD| |prodl| |terml| |prime| $)))))))) 

(SDEFUN |GUESS;ADEguessModGenCached|
        ((|fl| (|List| (|U32Vector|))) (|addOne| (|Boolean|))
         (|maxD| (|NonNegativeInteger|))
         (|prodl| (|List| (|List| (|Integer|)))) (|terml| (|List| (|Integer|)))
         (|prime| (|Integer|)) ($ (|Vector| (|U32Vector|))))
        (SPROG
         ((#1=#:G1019 NIL) (|i| NIL) (|cache| (|PrimitiveArray| (|U32Vector|)))
          (|np| (|NonNegativeInteger|)) (|sigma| (|Integer|))
          (|f| (|U32Vector|)))
         (SEQ
          (COND
           ((SPADCALL (LENGTH |fl|) 1 (QREFELT $ 147))
            (|error| "ADEguessModGenCached: #fl ~= 1"))
           ('T
            (SEQ (LETT |f| (|SPADfirst| |fl|))
                 (LETT |sigma| (- (QV_LEN_U32 |f|) |maxD|))
                 (LETT |np| (LENGTH |prodl|))
                 (LETT |cache|
                       (MAKEARR1 (+ (+ |maxD| 1) |np|) (GETREFV_U32 0 0)))
                 (QSETAREF1 |cache| 0 |f|)
                 (SEQ (LETT |i| 1) (LETT #1# |maxD|) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (QSETAREF1 |cache| |i|
                                   (SPADCALL (QAREF1 |cache| (- |i| 1)) |prime|
                                             (QREFELT $ 148)))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                 (EXIT
                  (|GUESS;guessModGenCached| |cache| |np| |sigma| |addOne|
                   |maxD| |prodl| |terml| |prime| $)))))))) 

(SDEFUN |GUESS;ADEtestGenCached|
        ((|f|
          (|UnivariateFormalPowerSeries|
           (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
         (|addOne| (|Boolean|)) (|maxD| (|NonNegativeInteger|))
         (|prodl| (|List| (|List| (|Integer|)))) (|terml| (|List| (|Integer|)))
         (DSF
          (|Mapping|
           (|UnivariateFormalPowerSeries|
            (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))
           (|UnivariateFormalPowerSeries|
            (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))
           (|NonNegativeInteger|)))
         (D1F
          (|UnivariateFormalPowerSeries|
           (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
         ($
          (|Vector|
           (|UnivariateFormalPowerSeries|
            (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))))
        (SPROG
         ((#1=#:G1037 NIL) (|i| NIL) (#2=#:G1038 NIL) (|r| NIL)
          (|res|
           (|Vector|
            (|UnivariateFormalPowerSeries|
             (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))))
          (#3=#:G1035 NIL) (#4=#:G1036 NIL) (|nt| (|NonNegativeInteger|))
          (#5=#:G1033 NIL) (#6=#:G1034 NIL) (|pp| NIL) (#7=#:G1032 NIL)
          (|cache|
           (|PrimitiveArray|
            (|UnivariateFormalPowerSeries|
             (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))))
          (|np| (|NonNegativeInteger|)))
         (SEQ (LETT |np| (LENGTH |prodl|))
              (LETT |cache|
                    (MAKEARR1 (+ (+ |maxD| 1) |np|) (|spadConstant| $ 149)))
              (QSETAREF1 |cache| 0 |f|)
              (SEQ (LETT |i| 1) (LETT #7# |maxD|) G190
                   (COND ((|greater_SI| |i| #7#) (GO G191)))
                   (SEQ
                    (EXIT
                     (QSETAREF1 |cache| |i|
                                (SPADCALL (QAREF1 |cache| 0) |i| DSF))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (SEQ (LETT |pp| NIL) (LETT #6# |prodl|) (LETT |i| (+ |maxD| 1))
                   (LETT #5# (+ |maxD| |np|)) G190
                   (COND
                    ((OR (> |i| #5#) (ATOM #6#)
                         (PROGN (LETT |pp| (CAR #6#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (QSETAREF1 |cache| |i|
                                (SPADCALL (QAREF1 |cache| (|SPADfirst| |pp|))
                                          (QAREF1 |cache|
                                                  (SPADCALL |pp|
                                                            (QREFELT $ 102)))
                                          (QREFELT $ 150)))))
                   (LETT |i| (PROG1 (+ |i| 1) (LETT #6# (CDR #6#)))) (GO G190)
                   G191 (EXIT NIL))
              (LETT |nt| (LENGTH |terml|))
              (COND
               (|addOne|
                (SEQ (LETT |res| (MAKEARR1 (+ |nt| 1) (|spadConstant| $ 149)))
                     (SPADCALL |res| 1 D1F (QREFELT $ 152))
                     (EXIT
                      (SEQ (LETT |r| NIL) (LETT #4# |terml|) (LETT |i| 2)
                           (LETT #3# (+ |nt| 1)) G190
                           (COND
                            ((OR (|greater_SI| |i| #3#) (ATOM #4#)
                                 (PROGN (LETT |r| (CAR #4#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (SPADCALL |res| |i| (QAREF1 |cache| |r|)
                                       (QREFELT $ 152))))
                           (LETT |i|
                                 (PROG1 (|inc_SI| |i|) (LETT #4# (CDR #4#))))
                           (GO G190) G191 (EXIT NIL)))))
               ('T
                (SEQ (LETT |res| (MAKEARR1 |nt| (|spadConstant| $ 149)))
                     (EXIT
                      (SEQ (LETT |r| NIL) (LETT #2# |terml|) (LETT |i| 1)
                           (LETT #1# |nt|) G190
                           (COND
                            ((OR (|greater_SI| |i| #1#) (ATOM #2#)
                                 (PROGN (LETT |r| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (SPADCALL |res| |i| (QAREF1 |cache| |r|)
                                       (QREFELT $ 152))))
                           (LETT |i|
                                 (PROG1 (|inc_SI| |i|) (LETT #2# (CDR #2#))))
                           (GO G190) G191 (EXIT NIL))))))
              (EXIT |res|)))) 

(SDEFUN |GUESS;multiplyExponents|
        ((|f| (|U32Vector|)) (|n| (|NonNegativeInteger|)) ($ (|U32Vector|)))
        (SPROG
         ((#1=#:G1043 NIL) (|i| NIL) (|deg| (|Integer|)) (|f0| (|U32Vector|))
          (|nn| (|NonNegativeInteger|)))
         (SEQ (LETT |nn| (QV_LEN_U32 |f|)) (LETT |f0| (GETREFV_U32 |nn| 0))
              (LETT |deg| (- |nn| 1))
              (SEQ (LETT |i| 0) (LETT #1# |deg|) G190
                   (COND
                    ((OR (|greater_SI| |i| #1#) (NULL (<= (* |n| |i|) |deg|)))
                     (GO G191)))
                   (SEQ (EXIT (SETELT_U32 |f0| (* |n| |i|) (ELT_U32 |f| |i|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |f0|)))) 

(SDEFUN |GUESS;FEguessModGenCached|
        ((|fl| (|List| (|U32Vector|))) (|addOne| (|Boolean|))
         (|maxD| (|NonNegativeInteger|))
         (|prodl| (|List| (|List| (|Integer|)))) (|terml| (|List| (|Integer|)))
         (|prime| (|Integer|)) ($ (|Vector| (|U32Vector|))))
        (SPROG
         ((#1=#:G1049 NIL) (|i| NIL) (|cache| (|PrimitiveArray| (|U32Vector|)))
          (|np| (|NonNegativeInteger|)) (|sigma| (|NonNegativeInteger|))
          (|f| (|U32Vector|)))
         (SEQ
          (COND
           ((SPADCALL (LENGTH |fl|) 1 (QREFELT $ 147))
            (|error| "FEguessModGenCached: #fl ~= 1"))
           ('T
            (SEQ (LETT |f| (|SPADfirst| |fl|)) (LETT |sigma| (QV_LEN_U32 |f|))
                 (LETT |np| (LENGTH |prodl|))
                 (LETT |cache|
                       (MAKEARR1 (+ (+ |maxD| 1) |np|) (GETREFV_U32 0 0)))
                 (QSETAREF1 |cache| 0 |f|)
                 (SEQ (LETT |i| 1) (LETT #1# |maxD|) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (QSETAREF1 |cache| |i|
                                   (|GUESS;multiplyExponents|
                                    (QAREF1 |cache| 0) (+ |i| 1) $))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                 (EXIT
                  (|GUESS;guessModGenCached| |cache| |np| |sigma| |addOne|
                   |maxD| |prodl| |terml| |prime| $)))))))) 

(SDEFUN |GUESS;optimiseFactor|
        ((|partition| (|Partition|)) (|partitions| (|List| (|Partition|)))
         ($ (|Union| (|List| (|Integer|)) "failed")))
        (SPROG
         ((#1=#:G1070 NIL) (|j| (|Integer|))
          (|r| (|Union| (|Partition|) "failed")) (#2=#:G1071 NIL) (|p| NIL)
          (#3=#:G1072 NIL) (|i| NIL) (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (LENGTH |partitions|))
                (SEQ (LETT |i| 1) (LETT #3# |n|) (LETT |p| NIL)
                     (LETT #2# |partitions|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |p| (CAR #2#)) NIL)
                           (|greater_SI| |i| #3#))
                       (GO G191)))
                     (SEQ (LETT |r| (SPADCALL |partition| |p| (QREFELT $ 154)))
                          (EXIT
                           (COND
                            ((QEQCAR |r| 0)
                             (SEQ
                              (LETT |j|
                                    (SPADCALL (QCDR |r|) |partitions|
                                              (QREFELT $ 156)))
                              (EXIT
                               (COND
                                ((> |j| 0)
                                 (PROGN
                                  (LETT #1# (CONS 0 (LIST |i| |j|)))
                                  (GO #4=#:G1069))))))))))
                     (LETT #2# (PROG1 (CDR #2#) (LETT |i| (|inc_SI| |i|))))
                     (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 1 "failed"))))
          #4# (EXIT #1#)))) 

(SDEFUN |GUESS;optimiseProducts1|
        ((|p| (|Partition|))
         (|prods0| (|Reference| (|List| (|List| (|Integer|)))))
         (|parts0| (|Reference| (|List| (|Partition|)))) ($ (|Void|)))
        (SPROG
         ((|lp0| (|NonNegativeInteger|))
          (|r| (|Union| (|List| (|Integer|)) "failed")))
         (SEQ
          (SEQ
           (LETT |r|
                 (|GUESS;optimiseFactor| |p|
                  (SPADCALL |parts0| (QREFELT $ 158)) $))
           (EXIT
            (COND
             ((QEQCAR |r| 1)
              (SEQ
               (|GUESS;optimiseProducts1|
                (SPADCALL (CDR (SPADCALL |p| (QREFELT $ 159))) (QREFELT $ 160))
                |prods0| |parts0| $)
               (EXIT
                (LETT |r|
                      (|GUESS;optimiseFactor| |p|
                       (SPADCALL |parts0| (QREFELT $ 158)) $))))))))
          (EXIT
           (COND
            ((QEQCAR |r| 1)
             (|error| "Internal error: failed adding intermediate partition"))
            ('T
             (SEQ (LETT |lp0| (LENGTH (SPADCALL |parts0| (QREFELT $ 158))))
                  (SPADCALL |prods0|
                            (CONS
                             (LIST (- |lp0| (|SPADfirst| (QCDR |r|)))
                                   (- |lp0|
                                      (SPADCALL (QCDR |r|) (QREFELT $ 102))))
                             (SPADCALL |prods0| (QREFELT $ 162)))
                            (QREFELT $ 163))
                  (EXIT
                   (SPADCALL |parts0|
                             (CONS |p| (SPADCALL |parts0| (QREFELT $ 158)))
                             (QREFELT $ 164)))))))))) 

(SDEFUN |GUESS;optimiseProducts|
        ((|partitions| (|List| (|List| (|Integer|))))
         ($
          (|Record| (|:| |addOne| (|Boolean|))
                    (|:| |maxDiff| (|NonNegativeInteger|))
                    (|:| |prods| (|List| (|List| (|Integer|))))
                    (|:| |terms| (|List| (|Integer|))))))
        (SPROG
         ((#1=#:G1090 NIL) (|terms0| (|List| (|Integer|))) (#2=#:G1095 NIL)
          (|p| NIL) (|parts0| (|Reference| (|List| (|Partition|)))) (|i| NIL)
          (#3=#:G1094 NIL)
          (|prods0| (|Reference| (|List| (|List| (|Integer|)))))
          (|maxD0| (|Integer|)) (#4=#:G1093 NIL) (|addOne0| (|Boolean|)))
         (SEQ
          (EXIT
           (SEQ (LETT |addOne0| (NULL (|SPADfirst| |partitions|)))
                (COND
                 (|addOne0|
                  (SEQ (LETT |partitions| (CDR |partitions|))
                       (EXIT
                        (COND
                         ((NULL |partitions|)
                          (PROGN
                           (LETT #4# (VECTOR |addOne0| 0 NIL NIL))
                           (GO #5=#:G1092))))))))
                (LETT |maxD0|
                      (SPADCALL (ELT $ 165)
                                (SPADCALL (ELT $ 166) |partitions|
                                          (QREFELT $ 169))
                                (QREFELT $ 170)))
                (LETT |prods0| (SPADCALL NIL (QREFELT $ 171)))
                (LETT |terms0| NIL)
                (LETT |parts0|
                      (SPADCALL
                       (PROGN
                        (LETT #3# NIL)
                        (SEQ (LETT |i| |maxD0|) G190
                             (COND ((< |i| 1) (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #3#
                                     (CONS
                                      (SPADCALL (LIST |i|) (QREFELT $ 160))
                                      #3#))))
                             (LETT |i| (+ |i| -1)) (GO G190) G191
                             (EXIT (NREVERSE #3#))))
                       (QREFELT $ 172)))
                (SEQ (LETT |p| NIL) (LETT #2# |partitions|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |p| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((EQL (LENGTH |p|) 1)
                         (LETT |terms0|
                               (CONS (- (|SPADfirst| |p|) 1) |terms0|)))
                        ('T
                         (SEQ
                          (|GUESS;optimiseProducts1|
                           (SPADCALL |p| (QREFELT $ 160)) |prods0| |parts0| $)
                          (EXIT
                           (LETT |terms0|
                                 (CONS
                                  (-
                                   (LENGTH (SPADCALL |parts0| (QREFELT $ 158)))
                                   1)
                                  |terms0|))))))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT
                 (VECTOR |addOne0|
                         (PROG1 (LETT #1# (- |maxD0| 1))
                           (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                             '(|Integer|) #1#))
                         (NREVERSE (SPADCALL |prods0| (QREFELT $ 162)))
                         (NREVERSE |terms0|)))))
          #5# (EXIT #4#)))) 

(SDEFUN |GUESS;ADEguessModOptimisedGen|
        ((|partitions| (|List| (|List| (|Integer|))))
         ($
          (|Mapping| (|Vector| (|U32Vector|)) (|List| (|U32Vector|))
                     (|Integer|) (|Integer|))))
        (SPROG
         ((|r|
           (|Record| (|:| |addOne| (|Boolean|))
                     (|:| |maxDiff| (|NonNegativeInteger|))
                     (|:| |prods| (|List| (|List| (|Integer|))))
                     (|:| |terms| (|List| (|Integer|))))))
         (SEQ (LETT |r| (|GUESS;optimiseProducts| |partitions| $))
              (EXIT
               (CONS #'|GUESS;ADEguessModOptimisedGen!0| (VECTOR $ |r|)))))) 

(SDEFUN |GUESS;ADEguessModOptimisedGen!0|
        ((|fl| NIL) (|prime| NIL) (|q| NIL) ($$ NIL))
        (PROG (|r| $)
          (LETT |r| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;ADEguessModGenCached| |fl| (QVELT |r| 0) (QVELT |r| 1)
             (QVELT |r| 2) (QVELT |r| 3) |prime| $))))) 

(SDEFUN |GUESS;FEguessModOptimisedGen|
        ((|partitions| (|List| (|List| (|Integer|))))
         ($
          (|Mapping| (|Vector| (|U32Vector|)) (|List| (|U32Vector|))
                     (|Integer|) (|Integer|))))
        (SPROG
         ((|r|
           (|Record| (|:| |addOne| (|Boolean|))
                     (|:| |maxDiff| (|NonNegativeInteger|))
                     (|:| |prods| (|List| (|List| (|Integer|))))
                     (|:| |terms| (|List| (|Integer|))))))
         (SEQ (LETT |r| (|GUESS;optimiseProducts| |partitions| $))
              (EXIT (CONS #'|GUESS;FEguessModOptimisedGen!0| (VECTOR $ |r|)))))) 

(SDEFUN |GUESS;FEguessModOptimisedGen!0|
        ((|fl| NIL) (|prime| NIL) (|q| NIL) ($$ NIL))
        (PROG (|r| $)
          (LETT |r| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;FEguessModGenCached| |fl| (QVELT |r| 0) (QVELT |r| 1)
             (QVELT |r| 2) (QVELT |r| 3) |prime| $))))) 

(SDEFUN |GUESS;DEPguessModOptimisedGen|
        ((|partitions| (|List| (|List| (|Integer|))))
         ($
          (|Mapping| (|Vector| (|U32Vector|)) (|List| (|U32Vector|))
                     (|Integer|) (|Integer|))))
        (SPROG
         ((|r|
           (|Record| (|:| |addOne| (|Boolean|))
                     (|:| |maxDiff| (|NonNegativeInteger|))
                     (|:| |prods| (|List| (|List| (|Integer|))))
                     (|:| |terms| (|List| (|Integer|))))))
         (SEQ (LETT |r| (|GUESS;optimiseProducts| |partitions| $))
              (EXIT
               (CONS #'|GUESS;DEPguessModOptimisedGen!0| (VECTOR $ |r|)))))) 

(SDEFUN |GUESS;DEPguessModOptimisedGen!0|
        ((|fl| NIL) (|prime| NIL) (|q| NIL) ($$ NIL))
        (PROG (|r| $)
          (LETT |r| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;DEPguessModGenCached| |fl| (QVELT |r| 0) (QVELT |r| 1)
             (QVELT |r| 2) (QVELT |r| 3) |prime| $))))) 

(SDEFUN |GUESS;ADEguessModGen2|
        ((|partitions| (|List| (|List| (|Integer|))))
         (|d| (|NonNegativeInteger|))
         ($
          (|Mapping| (|Vector| (|U32Vector|)) (|List| (|U32Vector|))
                     (|Integer|) (|Integer|))))
        (SPROG NIL
               (SEQ
                (CONS #'|GUESS;ADEguessModGen2!0|
                      (VECTOR |d| |partitions| $))))) 

(SDEFUN |GUESS;ADEguessModGen2!0| ((|fl| NIL) (|prime| NIL) (|q| NIL) ($$ NIL))
        (PROG ($ |partitions| |d|)
          (LETT $ (QREFELT $$ 2))
          (LETT |partitions| (QREFELT $$ 1))
          (LETT |d| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G1120 NIL) (|p| NIL) (#2=#:G1119 NIL) (|f| NIL))
                   (SEQ
                    (COND
                     ((SPADCALL (SPADCALL |fl| (QREFELT $ 173))
                                (|spadConstant| $ 174) (QREFELT $ 147))
                      (|error| "ADEguessModGen2, lambda: #fl ~= 1"))
                     ('T
                      (SEQ (LETT |f| (SPADCALL |fl| (QREFELT $ 175)))
                           (EXIT
                            (SPADCALL
                             (PROGN
                              (LETT #2# NIL)
                              (SEQ (LETT |p| NIL) (LETT #1# |partitions|) G190
                                   (COND
                                    ((OR (ATOM #1#)
                                         (PROGN (LETT |p| (CAR #1#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #2#
                                           (CONS
                                            (|GUESS;termAsU32VectorShift| |f|
                                             |p| |prime| |d| $)
                                            #2#))))
                                   (LETT #1# (CDR #1#)) (GO G190) G191
                                   (EXIT (NREVERSE #2#))))
                             (QREFELT $ 176)))))))))))) 

(SDEFUN |GUESS;ADEtestOptimisedGen|
        ((|partitions| (|List| (|List| (|Integer|))))
         (DSF
          (|Mapping|
           (|UnivariateFormalPowerSeries|
            (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))
           (|UnivariateFormalPowerSeries|
            (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))
           (|NonNegativeInteger|)))
         (D1F
          (|UnivariateFormalPowerSeries|
           (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
         ($
          (|Mapping|
           (|Vector|
            (|UnivariateFormalPowerSeries|
             (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
           (|UnivariateFormalPowerSeries|
            (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))))
        (SPROG
         ((|r|
           (|Record| (|:| |addOne| (|Boolean|))
                     (|:| |maxDiff| (|NonNegativeInteger|))
                     (|:| |prods| (|List| (|List| (|Integer|))))
                     (|:| |terms| (|List| (|Integer|))))))
         (SEQ (LETT |r| (|GUESS;optimiseProducts| |partitions| $))
              (EXIT
               (CONS #'|GUESS;ADEtestOptimisedGen!0| (VECTOR $ D1F DSF |r|)))))) 

(SDEFUN |GUESS;ADEtestOptimisedGen!0| ((|f| NIL) ($$ NIL))
        (PROG (|r| DSF D1F $)
          (LETT |r| (QREFELT $$ 3))
          (LETT DSF (QREFELT $$ 2))
          (LETT D1F (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;ADEtestGenCached| |f| (QVELT |r| 0) (QVELT |r| 1)
             (QVELT |r| 2) (QVELT |r| 3) DSF D1F $))))) 

(SDEFUN |GUESS;ADEtestGen2|
        ((|partitions| (|List| (|List| (|Integer|))))
         (DSF
          (|Mapping|
           (|UnivariateFormalPowerSeries|
            (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))
           (|UnivariateFormalPowerSeries|
            (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))
           (|NonNegativeInteger|)))
         (D1F
          (|UnivariateFormalPowerSeries|
           (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
         ($
          (|Mapping|
           (|Vector|
            (|UnivariateFormalPowerSeries|
             (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
           (|UnivariateFormalPowerSeries|
            (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))))
        (SPROG NIL
               (SEQ
                (CONS #'|GUESS;ADEtestGen2!0|
                      (VECTOR $ D1F DSF |partitions|))))) 

(SDEFUN |GUESS;ADEtestGen2!0| ((|f| NIL) ($$ NIL))
        (PROG (|partitions| DSF D1F $)
          (LETT |partitions| (QREFELT $$ 3))
          (LETT DSF (QREFELT $$ 2))
          (LETT D1F (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G1134 NIL) (|p| NIL) (#2=#:G1133 NIL))
                   (SEQ
                    (SPADCALL
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |p| NIL) (LETT #1# |partitions|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #2#
                                   (CONS
                                    (|GUESS;termAsUFPSSUPF2| |f| |p| DSF D1F $)
                                    #2#))))
                           (LETT #1# (CDR #1#)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))
                     (QREFELT $ 177)))))))) 

(SDEFUN |GUESS;ADEEXPRRStream|
        ((|f| (EXPRR)) (|xx| (|Symbol|))
         (|partitions| (|Stream| (|List| (|Integer|))))
         (DX (|Mapping| EXPRR EXPRR (|Symbol|) (|NonNegativeInteger|)))
         (D1X (|Mapping| EXPRR (|Symbol|))) ($ (|Stream| EXPRR)))
        (SPROG NIL
               (SPADCALL
                (CONS #'|GUESS;ADEEXPRRStream!0| (VECTOR $ D1X DX |xx| |f|))
                |partitions| (QREFELT $ 181)))) 

(SDEFUN |GUESS;ADEEXPRRStream!0| ((|z1| NIL) ($$ NIL))
        (PROG (|f| |xx| DX D1X $)
          (LETT |f| (QREFELT $$ 4))
          (LETT |xx| (QREFELT $$ 3))
          (LETT DX (QREFELT $$ 2))
          (LETT D1X (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GUESS;termAsEXPRR| |f| |xx| |z1| DX D1X $))))) 

(SDEFUN |GUESS;ADEdegreeStream|
        ((|partitions| (|Stream| (|List| (|Integer|))))
         ($ (|Stream| (|NonNegativeInteger|))))
        (SPADCALL 0 (CONS #'|GUESS;ADEdegreeStream!0| $) |partitions|
                  (QREFELT $ 188))) 

(SDEFUN |GUESS;ADEdegreeStream!0| ((|z1| NIL) (|z2| NIL) ($ NIL))
        (SPROG ((#1=#:G1142 NIL))
               (SPADCALL
                (COND ((SPADCALL |z1| (QREFELT $ 182)) (|spadConstant| $ 95))
                      ('T
                       (PROG1
                           (LETT #1#
                                 (SPADCALL (SPADCALL |z1| (QREFELT $ 166))
                                           (|spadConstant| $ 174)
                                           (QREFELT $ 183)))
                         (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                           '(|Integer|) #1#))))
                |z2| (QREFELT $ 184)))) 

(SDEFUN |GUESS;diffDX|
        ((|expr| (EXPRR)) (|x| (|Symbol|)) (|n| (|NonNegativeInteger|))
         ($ (EXPRR)))
        (SPADCALL |expr| |x| |n| (QREFELT $ 189))) 

(SDEFUN |GUESS;diffDS|
        ((|s| (|UnivariateFormalPowerSeries| F)) (|n| (|NonNegativeInteger|))
         ($ (|UnivariateFormalPowerSeries| F)))
        (SPADCALL |s| |n| (QREFELT $ 190))) 

(SDEFUN |GUESS;diffDSF|
        ((|s|
          (|UnivariateFormalPowerSeries|
           (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
         (|n| (|NonNegativeInteger|))
         ($
          (|UnivariateFormalPowerSeries|
           (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))))
        (COND
         ((|HasSignature|
           (|SparseMultivariatePolynomial| (QREFELT $ 6)
                                           (|NonNegativeInteger|))
           (LIST '*
                 (LIST
                  (LIST '|SparseMultivariatePolynomial|
                        (|devaluate| (QREFELT $ 6)) '(|NonNegativeInteger|))
                  '(|NonNegativeInteger|)
                  (LIST '|SparseMultivariatePolynomial|
                        (|devaluate| (QREFELT $ 6)) '(|NonNegativeInteger|)))))
          (SPADCALL |s| |n| (QREFELT $ 191))))) 

(SDEFUN |GUESS;diffAX|
        ((|l| (|NonNegativeInteger|)) (|x| (|Symbol|)) (|f| (EXPRR))
         ($ (EXPRR)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 45)) |l| (QREFELT $ 103))
                  |f| (QREFELT $ 104))) 

(SDEFUN |GUESS;diffA|
        ((|k| (|NonNegativeInteger|)) (|l| (|NonNegativeInteger|))
         (|f| (|SparseUnivariatePolynomial| S)) ($ (S)))
        (SPADCALL |k| |l| |f| (QREFELT $ 193))) 

(SDEFUN |GUESS;diffAF|
        ((|k| (|NonNegativeInteger|)) (|l| (|NonNegativeInteger|))
         (|f|
          (|UnivariateFormalPowerSeries|
           (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
         ($ (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
        (SPADCALL |k| |l| |f| (QREFELT $ 195))) 

(SDEFUN |GUESS;diffC| ((|total| (|NonNegativeInteger|)) ($ (|List| S)))
        (SPADCALL |total| (QREFELT $ 196))) 

(SDEFUN |GUESS;diff1X| ((|x| (|Symbol|)) ($ (EXPRR))) (|spadConstant| $ 197)) 

(SDEFUN |GUESS;diffHP;LR;43|
        ((|options| (|List| (|GuessOption|)))
         ($
          (|Record| (|:| |degreeStream| (|Stream| (|NonNegativeInteger|)))
                    (|:| |guessStream|
                         (|Mapping|
                          (|Stream| (|UnivariateFormalPowerSeries| F))
                          (|UnivariateFormalPowerSeries| F)))
                    (|:| |guessModGen|
                         (|Mapping|
                          (|Mapping| (|Vector| (|U32Vector|))
                                     (|List| (|U32Vector|)) (|Integer|)
                                     (|Integer|))
                          (|NonNegativeInteger|)))
                    (|:| |testGen|
                         (|Mapping|
                          (|Mapping|
                           (|Vector|
                            (|UnivariateFormalPowerSeries|
                             (|SparseMultivariatePolynomial| F
                                                             (|NonNegativeInteger|))))
                           (|UnivariateFormalPowerSeries|
                            (|SparseMultivariatePolynomial| F
                                                            (|NonNegativeInteger|))))
                          (|List| (|PositiveInteger|))))
                    (|:| |exprStream|
                         (|Mapping| (|Stream| EXPRR) EXPRR (|Symbol|)))
                    (|:| |kind| (|Symbol|)) (|:| |qvar| (|Symbol|))
                    (|:| A
                         (|Mapping| S (|NonNegativeInteger|)
                                    (|NonNegativeInteger|)
                                    (|SparseUnivariatePolynomial| S)))
                    (|:| AF
                         (|Mapping|
                          (|SparseMultivariatePolynomial| F
                                                          (|NonNegativeInteger|))
                          (|NonNegativeInteger|) (|NonNegativeInteger|)
                          (|UnivariateFormalPowerSeries|
                           (|SparseMultivariatePolynomial| F
                                                           (|NonNegativeInteger|)))))
                    (|:| AX
                         (|Mapping| EXPRR (|NonNegativeInteger|) (|Symbol|)
                                    EXPRR))
                    (|:| C (|Mapping| (|List| S) (|NonNegativeInteger|))))))
        (SPROG
         ((|degrees| (|Stream| (|NonNegativeInteger|)))
          (|partitions| (|Stream| (|List| (|Integer|)))) (|dk| (|Symbol|)))
         (SEQ
          (COND
           ((NULL (ZEROP (SPADCALL |options| (QREFELT $ 198))))
            (|error|
             (SPADCALL "Guess: no support for mixed shifts in differential"
                       " equations" (QREFELT $ 42)))))
          (LETT |dk| (SPADCALL |options| (QREFELT $ 199)))
          (EXIT
           (COND
            ((EQUAL |dk| '|displayAsGF|)
             (SEQ
              (LETT |partitions| (|GUESS;FilteredPartitionStream| |options| $))
              (LETT |degrees| (|GUESS;ADEdegreeStream| |partitions| $))
              (EXIT
               (VECTOR |degrees|
                       (CONS #'|GUESS;diffHP;LR;43!0| (VECTOR $ |partitions|))
                       (CONS #'|GUESS;diffHP;LR;43!1| (VECTOR $ |partitions|))
                       (CONS #'|GUESS;diffHP;LR;43!2| (VECTOR $ |partitions|))
                       (CONS #'|GUESS;diffHP;LR;43!3| (VECTOR $ |partitions|))
                       '|diffHP| '|dummy| (CONS (|function| |GUESS;diffA|) $)
                       (CONS (|function| |GUESS;diffAF|) $)
                       (CONS (|function| |GUESS;diffAX|) $)
                       (CONS (|function| |GUESS;diffC|) $)))))
            ('T (|error| "Guess: guessADE supports only displayAsGF"))))))) 

(SDEFUN |GUESS;diffHP;LR;43!3| ((|z1| NIL) (|z2| NIL) ($$ NIL))
        (PROG (|partitions| $)
          (LETT |partitions| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;ADEEXPRRStream| |z1| |z2| |partitions|
             (CONS (|function| |GUESS;diffDX|) $)
             (CONS (|function| |GUESS;diff1X|) $) $))))) 

(SDEFUN |GUESS;diffHP;LR;43!2| ((|l| NIL) ($$ NIL))
        (PROG (|partitions| $)
          (LETT |partitions| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G1175 NIL) (|i| NIL) (#2=#:G1174 NIL))
                   (SEQ
                    (|GUESS;ADEtestOptimisedGen|
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |i| NIL) (LETT #1# |l|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #2#
                                   (CONS
                                    (SPADCALL |partitions| |i| (QREFELT $ 204))
                                    #2#))))
                           (LETT #1# (CDR #1#)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))
                     (CONS (|function| |GUESS;diffDSF|) $)
                     (|spadConstant| $ 205) $))))))) 

(SDEFUN |GUESS;diffHP;LR;43!1| ((|o| NIL) ($$ NIL))
        (PROG (|partitions| $)
          (LETT |partitions| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;ADEguessModOptimisedGen|
             (SPADCALL
              (SPADCALL (SPADCALL |partitions| |o| (QREFELT $ 201))
                        (QREFELT $ 202))
              (QREFELT $ 203))
             $))))) 

(SDEFUN |GUESS;diffHP;LR;43!0| ((|z1| NIL) ($$ NIL))
        (PROG (|partitions| $)
          (LETT |partitions| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;ADEguessStream| |z1| |partitions|
             (CONS (|function| |GUESS;diffDS|) $) (|spadConstant| $ 200) $))))) 

(SDEFUN |GUESS;monomialAsEXPRR|
        ((|fl0| (|List| EXPRR)) (|partition| (|List| (|Integer|))) ($ (EXPRR)))
        (SPROG
         ((|fl| (|List| EXPRR)) (#1=#:G1220 NIL) (#2=#:G1219 NIL)
          (#3=#:G1228 NIL) (|part| NIL) (#4=#:G1227 NIL)
          (|ll| (|List| (|List| (|Integer|)))))
         (SEQ
          (COND ((NULL |partition|) (|spadConstant| $ 197))
                ('T
                 (SEQ (LETT |ll| (SPADCALL |partition| (QREFELT $ 101)))
                      (LETT |fl|
                            (PROGN
                             (LETT #4# NIL)
                             (SEQ (LETT |part| NIL) (LETT #3# |ll|) G190
                                  (COND
                                   ((OR (ATOM #3#)
                                        (PROGN (LETT |part| (CAR #3#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #4#
                                          (CONS
                                           (SPADCALL
                                            (SPADCALL |fl0|
                                                      (PROG1
                                                          (LETT #2#
                                                                (|SPADfirst|
                                                                 |part|))
                                                        (|check_subtype2|
                                                         (> #2# 0)
                                                         '(|PositiveInteger|)
                                                         '(|Integer|) #2#))
                                                      (QREFELT $ 218))
                                            (PROG1
                                                (LETT #1#
                                                      (SPADCALL |part|
                                                                (QREFELT $
                                                                         102)))
                                              (|check_subtype2| (>= #1# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #1#))
                                            (QREFELT $ 103))
                                           #4#))))
                                  (LETT #3# (CDR #3#)) (GO G190) G191
                                  (EXIT (NREVERSE #4#)))))
                      (EXIT (SPADCALL (ELT $ 104) |fl| (QREFELT $ 106))))))))) 

(SDEFUN |GUESS;DEPEXPRRStream|
        ((|fl| (|List| EXPRR)) (|partitions| (|Stream| (|List| (|Integer|))))
         ($ (|Stream| EXPRR)))
        (SPROG NIL
               (SPADCALL (CONS #'|GUESS;DEPEXPRRStream!0| (VECTOR $ |fl|))
                         |partitions| (QREFELT $ 181)))) 

(SDEFUN |GUESS;DEPEXPRRStream!0| ((|z1| NIL) ($$ NIL))
        (PROG (|fl| $)
          (LETT |fl| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GUESS;monomialAsEXPRR| |fl| |z1| $))))) 

(SDEFUN |GUESS;get_fnames|
        ((|n| (|Integer|)) (|options| (|List| (|GuessOption|)))
         ($ (|List| EXPRR)))
        (SPROG
         ((#1=#:G1246 NIL) (|sym| NIL) (#2=#:G1245 NIL)
          (|syms| (|List| (|Symbol|))) (#3=#:G1244 NIL) (|i| NIL)
          (#4=#:G1243 NIL) (|snums| (|List| (|String|))) (#5=#:G1242 NIL)
          (|q| NIL) (#6=#:G1241 NIL) (|n1| (|NonNegativeInteger|)))
         (SEQ (LETT |syms| (SPADCALL |options| (QREFELT $ 219)))
              (LETT |n1| (LENGTH |syms|))
              (COND
               ((> |n1| 0)
                (COND
                 ((SPADCALL |n1| |n| (QREFELT $ 220))
                  (EXIT
                   (|error|
                    "numbers of sequences and names are different"))))))
              (COND
               ((EQL |n1| 0)
                (SEQ
                 (LETT |snums|
                       (PROGN
                        (LETT #6# NIL)
                        (SEQ (LETT |q| 1) (LETT #5# |n|) G190
                             (COND ((|greater_SI| |q| #5#) (GO G191)))
                             (SEQ
                              (EXIT (LETT #6# (CONS (STRINGIMAGE |q|) #6#))))
                             (LETT |q| (|inc_SI| |q|)) (GO G190) G191
                             (EXIT (NREVERSE #6#)))))
                 (EXIT
                  (LETT |syms|
                        (PROGN
                         (LETT #4# NIL)
                         (SEQ (LETT |i| NIL) (LETT #3# |snums|) G190
                              (COND
                               ((OR (ATOM #3#)
                                    (PROGN (LETT |i| (CAR #3#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #4#
                                      (CONS
                                       (SPADCALL
                                        (STRCONC "%" (STRCONC "f" |i|))
                                        (QREFELT $ 221))
                                       #4#))))
                              (LETT #3# (CDR #3#)) (GO G190) G191
                              (EXIT (NREVERSE #4#)))))))))
              (EXIT
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |sym| NIL) (LETT #1# |syms|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |sym| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #2# (CONS (SPADCALL |sym| (QREFELT $ 45)) #2#))))
                     (LETT #1# (CDR #1#)) (GO G190) G191
                     (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |GUESS;algDepHP;LLR;47|
        ((|lists| (|List| (|List| F))) (|options| (|List| (|GuessOption|)))
         ($
          (|Record| (|:| |degreeStream| (|Stream| (|NonNegativeInteger|)))
                    (|:| |guessStream|
                         (|Mapping|
                          (|Stream| (|UnivariateFormalPowerSeries| F))
                          (|UnivariateFormalPowerSeries| F)))
                    (|:| |guessModGen|
                         (|Mapping|
                          (|Mapping| (|Vector| (|U32Vector|))
                                     (|List| (|U32Vector|)) (|Integer|)
                                     (|Integer|))
                          (|NonNegativeInteger|)))
                    (|:| |testGen|
                         (|Mapping|
                          (|Mapping|
                           (|Vector|
                            (|UnivariateFormalPowerSeries|
                             (|SparseMultivariatePolynomial| F
                                                             (|NonNegativeInteger|))))
                           (|UnivariateFormalPowerSeries|
                            (|SparseMultivariatePolynomial| F
                                                            (|NonNegativeInteger|))))
                          (|List| (|PositiveInteger|))))
                    (|:| |exprStream|
                         (|Mapping| (|Stream| EXPRR) EXPRR (|Symbol|)))
                    (|:| |kind| (|Symbol|)) (|:| |qvar| (|Symbol|))
                    (|:| A
                         (|Mapping| S (|NonNegativeInteger|)
                                    (|NonNegativeInteger|)
                                    (|SparseUnivariatePolynomial| S)))
                    (|:| AF
                         (|Mapping|
                          (|SparseMultivariatePolynomial| F
                                                          (|NonNegativeInteger|))
                          (|NonNegativeInteger|) (|NonNegativeInteger|)
                          (|UnivariateFormalPowerSeries|
                           (|SparseMultivariatePolynomial| F
                                                           (|NonNegativeInteger|)))))
                    (|:| AX
                         (|Mapping| EXPRR (|NonNegativeInteger|) (|Symbol|)
                                    EXPRR))
                    (|:| C (|Mapping| (|List| S) (|NonNegativeInteger|))))))
        (SPROG
         ((|fakeDSF|
           (|Mapping|
            (|UnivariateFormalPowerSeries|
             (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))
            (|UnivariateFormalPowerSeries|
             (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))
            (|NonNegativeInteger|)))
          (|fakeDS|
           (|Mapping| (|UnivariateFormalPowerSeries| F)
                      (|UnivariateFormalPowerSeries| F)
                      (|NonNegativeInteger|)))
          (|fl| (|List| EXPRR)) (|partitions| (|Stream| (|List| (|Integer|))))
          (|dk| (|Symbol|)))
         (SEQ
          (COND
           ((NULL (ZEROP (SPADCALL |options| (QREFELT $ 198))))
            (|error|
             (SPADCALL "Guess: no support for mixed shifts in algebraic"
                       " dependencies" (QREFELT $ 42)))))
          (LETT |dk| (SPADCALL |options| (QREFELT $ 199)))
          (EXIT
           (COND
            ((SPADCALL |dk| '|displayAsEQ| (QREFELT $ 222))
             (|error| "Guess: guessAlgDep supports only displayAsEQ"))
            ('T
             (SEQ
              (LETT |partitions| (|GUESS;FilteredPartitionStream| |options| $))
              (LETT |fl| (|GUESS;get_fnames| (LENGTH |lists|) |options| $))
              (LETT |fakeDS|
                    (CONS #'|GUESS;algDepHP;LLR;47!0| (VECTOR $ |lists|)))
              (LETT |fakeDSF|
                    (CONS #'|GUESS;algDepHP;LLR;47!1| (VECTOR $ |lists|)))
              (EXIT
               (VECTOR
                (SPADCALL (CONS #'|GUESS;algDepHP;LLR;47!2| $) |partitions|
                          (QREFELT $ 226))
                (CONS #'|GUESS;algDepHP;LLR;47!3|
                      (VECTOR $ |fakeDS| |partitions|))
                (CONS #'|GUESS;algDepHP;LLR;47!4| (VECTOR $ |partitions|))
                (CONS #'|GUESS;algDepHP;LLR;47!5|
                      (VECTOR |fakeDSF| $ |partitions|))
                (CONS #'|GUESS;algDepHP;LLR;47!6| (VECTOR $ |partitions| |fl|))
                '|diffHP| '|dummy| (CONS (|function| |GUESS;diffA|) $)
                (CONS (|function| |GUESS;diffAF|) $)
                (CONS (|function| |GUESS;diffAX|) $)
                (CONS (|function| |GUESS;diffC|) $)))))))))) 

(SDEFUN |GUESS;algDepHP;LLR;47!6| ((|z1| NIL) (|z2| NIL) ($$ NIL))
        (PROG (|fl| |partitions| $)
          (LETT |fl| (QREFELT $$ 2))
          (LETT |partitions| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GUESS;DEPEXPRRStream| |fl| |partitions| $))))) 

(SDEFUN |GUESS;algDepHP;LLR;47!5| ((|l| NIL) ($$ NIL))
        (PROG (|partitions| $ |fakeDSF|)
          (LETT |partitions| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |fakeDSF| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G1266 NIL) (|i| NIL) (#2=#:G1265 NIL))
                   (SEQ
                    (|GUESS;ADEtestOptimisedGen|
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |i| NIL) (LETT #1# |l|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #2#
                                   (CONS
                                    (SPADCALL |partitions| |i| (QREFELT $ 204))
                                    #2#))))
                           (LETT #1# (CDR #1#)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))
                     |fakeDSF| (|spadConstant| $ 205) $))))))) 

(SDEFUN |GUESS;algDepHP;LLR;47!4| ((|o| NIL) ($$ NIL))
        (PROG (|partitions| $)
          (LETT |partitions| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;DEPguessModOptimisedGen|
             (SPADCALL
              (SPADCALL (SPADCALL |partitions| |o| (QREFELT $ 201))
                        (QREFELT $ 202))
              (QREFELT $ 203))
             $))))) 

(SDEFUN |GUESS;algDepHP;LLR;47!3| ((|z1| NIL) ($$ NIL))
        (PROG (|partitions| |fakeDS| $)
          (LETT |partitions| (QREFELT $$ 2))
          (LETT |fakeDS| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;ADEguessStream| |z1| |partitions| |fakeDS|
             (|spadConstant| $ 200) $))))) 

(SDEFUN |GUESS;algDepHP;LLR;47!2| ((|c| NIL) ($ NIL)) (|spadConstant| $ 95)) 

(SDEFUN |GUESS;algDepHP;LLR;47!1| ((|w1| NIL) (|w2| NIL) ($$ NIL))
        (PROG (|lists| $)
          (LETT |lists| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;list2UFPSSUPF|
             (SPADCALL |lists|
                       (SPADCALL |w2| (|spadConstant| $ 174) (QREFELT $ 76))
                       (QREFELT $ 224))
             $))))) 

(SDEFUN |GUESS;algDepHP;LLR;47!0| ((|w1| NIL) (|w2| NIL) ($$ NIL))
        (PROG (|lists| $)
          (LETT |lists| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;list2UFPSF|
             (SPADCALL |lists|
                       (SPADCALL |w2| (|spadConstant| $ 174) (QREFELT $ 76))
                       (QREFELT $ 224))
             $))))) 

(SDEFUN |GUESS;substDX|
        ((|expr| (EXPRR)) (|x| (|Symbol|)) (|n| (|NonNegativeInteger|))
         ($ (EXPRR)))
        (SPADCALL |expr| (SPADCALL |x| (QREFELT $ 45))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 45)) (+ |n| 1)
                            (QREFELT $ 103))
                  (QREFELT $ 228))) 

(SDEFUN |GUESS;substDS|
        ((|s| (|UnivariateFormalPowerSeries| F)) (|n| (|NonNegativeInteger|))
         ($ (|UnivariateFormalPowerSeries| F)))
        (SPROG ((#1=#:G1282 NIL))
               (SPADCALL |s|
                         (PROG1 (LETT #1# (+ |n| 1))
                           (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                             '(|NonNegativeInteger|) #1#))
                         (QREFELT $ 229)))) 

(SDEFUN |GUESS;substDSF|
        ((|s|
          (|UnivariateFormalPowerSeries|
           (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
         (|n| (|NonNegativeInteger|))
         ($
          (|UnivariateFormalPowerSeries|
           (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))))
        (SPROG ((#1=#:G1284 NIL))
               (SPADCALL |s|
                         (PROG1 (LETT #1# (+ |n| 1))
                           (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                             '(|NonNegativeInteger|) #1#))
                         (QREFELT $ 230)))) 

(SDEFUN |GUESS;substHP;LR;51|
        ((|options| (|List| (|GuessOption|)))
         ($
          (|Record| (|:| |degreeStream| (|Stream| (|NonNegativeInteger|)))
                    (|:| |guessStream|
                         (|Mapping|
                          (|Stream| (|UnivariateFormalPowerSeries| F))
                          (|UnivariateFormalPowerSeries| F)))
                    (|:| |guessModGen|
                         (|Mapping|
                          (|Mapping| (|Vector| (|U32Vector|))
                                     (|List| (|U32Vector|)) (|Integer|)
                                     (|Integer|))
                          (|NonNegativeInteger|)))
                    (|:| |testGen|
                         (|Mapping|
                          (|Mapping|
                           (|Vector|
                            (|UnivariateFormalPowerSeries|
                             (|SparseMultivariatePolynomial| F
                                                             (|NonNegativeInteger|))))
                           (|UnivariateFormalPowerSeries|
                            (|SparseMultivariatePolynomial| F
                                                            (|NonNegativeInteger|))))
                          (|List| (|PositiveInteger|))))
                    (|:| |exprStream|
                         (|Mapping| (|Stream| EXPRR) EXPRR (|Symbol|)))
                    (|:| |kind| (|Symbol|)) (|:| |qvar| (|Symbol|))
                    (|:| A
                         (|Mapping| S (|NonNegativeInteger|)
                                    (|NonNegativeInteger|)
                                    (|SparseUnivariatePolynomial| S)))
                    (|:| AF
                         (|Mapping|
                          (|SparseMultivariatePolynomial| F
                                                          (|NonNegativeInteger|))
                          (|NonNegativeInteger|) (|NonNegativeInteger|)
                          (|UnivariateFormalPowerSeries|
                           (|SparseMultivariatePolynomial| F
                                                           (|NonNegativeInteger|)))))
                    (|:| AX
                         (|Mapping| EXPRR (|NonNegativeInteger|) (|Symbol|)
                                    EXPRR))
                    (|:| C (|Mapping| (|List| S) (|NonNegativeInteger|))))))
        (SPROG
         ((|partitions| (|Stream| (|List| (|Integer|)))) (|dk| (|Symbol|)))
         (SEQ
          (COND
           ((NULL (ZEROP (SPADCALL |options| (QREFELT $ 198))))
            (|error|
             "Guess: no support for mixed shifts in functional equations")))
          (LETT |dk| (SPADCALL |options| (QREFELT $ 199)))
          (EXIT
           (COND
            ((EQUAL |dk| '|displayAsGF|)
             (SEQ
              (LETT |partitions| (|GUESS;FilteredPartitionStream| |options| $))
              (EXIT
               (VECTOR
                (SPADCALL (CONS #'|GUESS;substHP;LR;51!0| $) |partitions|
                          (QREFELT $ 226))
                (CONS #'|GUESS;substHP;LR;51!1| (VECTOR $ |partitions|))
                (CONS #'|GUESS;substHP;LR;51!2| (VECTOR $ |partitions|))
                (CONS #'|GUESS;substHP;LR;51!3| (VECTOR $ |partitions|))
                (CONS #'|GUESS;substHP;LR;51!4| (VECTOR $ |partitions|))
                '|diffHP| '|dummy| (CONS (|function| |GUESS;diffA|) $)
                (CONS (|function| |GUESS;diffAF|) $)
                (CONS (|function| |GUESS;diffAX|) $)
                (CONS (|function| |GUESS;diffC|) $)))))
            ('T (|error| "Guess: guessSubst supports only displayAsGF"))))))) 

(SDEFUN |GUESS;substHP;LR;51!4| ((|z1| NIL) (|z2| NIL) ($$ NIL))
        (PROG (|partitions| $)
          (LETT |partitions| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;ADEEXPRRStream| |z1| |z2| |partitions|
             (CONS (|function| |GUESS;substDX|) $)
             (CONS (|function| |GUESS;diff1X|) $) $))))) 

(SDEFUN |GUESS;substHP;LR;51!3| ((|l| NIL) ($$ NIL))
        (PROG (|partitions| $)
          (LETT |partitions| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G1303 NIL) (|i| NIL) (#2=#:G1302 NIL))
                   (SEQ
                    (|GUESS;ADEtestOptimisedGen|
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |i| NIL) (LETT #1# |l|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #2#
                                   (CONS
                                    (SPADCALL |partitions| |i| (QREFELT $ 204))
                                    #2#))))
                           (LETT #1# (CDR #1#)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))
                     (CONS (|function| |GUESS;substDSF|) $)
                     (|spadConstant| $ 205) $))))))) 

(SDEFUN |GUESS;substHP;LR;51!2| ((|o| NIL) ($$ NIL))
        (PROG (|partitions| $)
          (LETT |partitions| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;FEguessModOptimisedGen|
             (SPADCALL
              (SPADCALL (SPADCALL |partitions| |o| (QREFELT $ 201))
                        (QREFELT $ 202))
              (QREFELT $ 203))
             $))))) 

(SDEFUN |GUESS;substHP;LR;51!1| ((|z1| NIL) ($$ NIL))
        (PROG (|partitions| $)
          (LETT |partitions| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;ADEguessStream| |z1| |partitions|
             (CONS (|function| |GUESS;substDS|) $) (|spadConstant| $ 200) $))))) 

(SDEFUN |GUESS;substHP;LR;51!0| ((|c| NIL) ($ NIL)) (|spadConstant| $ 95)) 

(SDEFUN |GUESS;qDiffDX|
        ((|q| (|Symbol|)) (|expr| (EXPRR)) (|x| (|Symbol|))
         (|n| (|NonNegativeInteger|)) ($ (EXPRR)))
        (SPADCALL |expr| (SPADCALL |x| (QREFELT $ 45))
                  (SPADCALL
                   (SPADCALL (SPADCALL |q| (QREFELT $ 45)) |n| (QREFELT $ 103))
                   (SPADCALL |x| (QREFELT $ 45)) (QREFELT $ 104))
                  (QREFELT $ 228))) 

(SDEFUN |GUESS;qDiffDS|
        ((|q| (|Symbol|)) (|s| (|UnivariateFormalPowerSeries| F))
         (|n| (|NonNegativeInteger|)) ($ (|UnivariateFormalPowerSeries| F)))
        (SPROG NIL
               (SPADCALL (CONS #'|GUESS;qDiffDS!0| (VECTOR |n| $ |q|)) |s|
                         (QREFELT $ 235)))) 

(SDEFUN |GUESS;qDiffDS!0| ((|z1| NIL) ($$ NIL))
        (PROG (|q| $ |n|)
          (LETT |q| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |n| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G1324 NIL))
                   (SPADCALL (SPADCALL |q| (QREFELT $ 232))
                             (PROG1
                                 (LETT #1# (SPADCALL |n| |z1| (QREFELT $ 233)))
                               (|check_subtype2| (>= #1# 0)
                                                 '(|NonNegativeInteger|)
                                                 '(|Integer|) #1#))
                             (QREFELT $ 124))))))) 

(SDEFUN |GUESS;qDiffDSV|
        ((|f| (|U32Vector|)) (|n| (|NonNegativeInteger|)) (|prime| (|Integer|))
         (|q| (|Integer|)) ($ (|U32Vector|)))
        (SPROG
         ((Q (|Integer|)) (#1=#:G1336 NIL) (|i| NIL) (|qn| (|Integer|))
          (|r| (|U32Vector|)) (#2=#:G1328 NIL) (|d| (|Integer|)))
         (SEQ
          (COND ((ZEROP |n|) |f|)
                ('T
                 (SEQ (LETT |d| (- (QV_LEN_U32 |f|) 1))
                      (LETT |r|
                            (GETREFV_U32
                             (+
                              (PROG1 (LETT #2# |d|)
                                (|check_subtype2| (>= #2# 0)
                                                  '(|NonNegativeInteger|)
                                                  '(|Integer|) #2#))
                              1)
                             0))
                      (SETELT_U32 |r| 0 (ELT_U32 |f| 0))
                      (COND
                       ((> |d| 0)
                        (SEQ (LETT Q 1)
                             (LETT |qn| (REM (EXPT |q| |n|) |prime|))
                             (EXIT
                              (SEQ (LETT |i| 1) (LETT #1# |d|) G190
                                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                                   (SEQ (LETT Q (QSMULMOD32 |qn| Q |prime|))
                                        (EXIT
                                         (SETELT_U32 |r| |i|
                                                     (QSMULMOD32
                                                      (ELT_U32 |f| |i|) Q
                                                      |prime|))))
                                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                   (EXIT NIL))))))
                      (EXIT |r|))))))) 

(SDEFUN |GUESS;qDiffDSF|
        ((|q| (|Symbol|))
         (|s|
          (|UnivariateFormalPowerSeries|
           (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
         (|n| (|NonNegativeInteger|))
         ($
          (|UnivariateFormalPowerSeries|
           (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))))
        (SPROG NIL
               (SPADCALL (CONS #'|GUESS;qDiffDSF!0| (VECTOR |n| $ |q|)) |s|
                         (QREFELT $ 238)))) 

(SDEFUN |GUESS;qDiffDSF!0| ((|z1| NIL) ($$ NIL))
        (PROG (|q| $ |n|)
          (LETT |q| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |n| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G1337 NIL))
                   (SPADCALL
                    (SPADCALL (SPADCALL |q| (QREFELT $ 232)) (QREFELT $ 236))
                    (PROG1 (LETT #1# (SPADCALL |n| |z1| (QREFELT $ 233)))
                      (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #1#))
                    (QREFELT $ 130))))))) 

(SDEFUN |GUESS;termAsU32VectorqDiff|
        ((|f| (|U32Vector|)) (|partition| (|List| (|Integer|)))
         (|prime| (|Integer|)) (|q| (|Integer|)) (|dl| (|NonNegativeInteger|))
         ($ (|U32Vector|)))
        (SPROG
         ((|fl| (|List| (|U32Vector|))) (#1=#:G1345 NIL) (#2=#:G1344 NIL)
          (#3=#:G1355 NIL) (|part| NIL) (#4=#:G1354 NIL)
          (|ll| (|List| (|List| (|Integer|)))) (|d| (|NonNegativeInteger|))
          (#5=#:G1342 NIL) (#6=#:G1353 NIL) (|i| NIL) (#7=#:G1352 NIL))
         (SEQ
          (COND
           ((NULL |partition|)
            (SPADCALL
             (CONS 1
                   (PROGN
                    (LETT #7# NIL)
                    (SEQ (LETT |i| (+ |dl| 2)) (LETT #6# (QV_LEN_U32 |f|)) G190
                         (COND ((> |i| #6#) (GO G191)))
                         (SEQ (EXIT (LETT #7# (CONS 0 #7#))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191
                         (EXIT (NREVERSE #7#)))))
             (QREFELT $ 108)))
           ('T
            (SEQ
             (LETT |d|
                   (PROG1 (LETT #5# (- (- (QV_LEN_U32 |f|) |dl|) 1))
                     (|check_subtype2| (>= #5# 0) '(|NonNegativeInteger|)
                                       '(|Integer|) #5#)))
             (LETT |ll| (SPADCALL |partition| (QREFELT $ 101)))
             (LETT |fl|
                   (PROGN
                    (LETT #4# NIL)
                    (SEQ (LETT |part| NIL) (LETT #3# |ll|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |part| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT #4#
                                 (CONS
                                  (SPADCALL
                                   (|GUESS;qDiffDSV| |f|
                                    (PROG1
                                        (LETT #2# (- (|SPADfirst| |part|) 1))
                                      (|check_subtype2| (>= #2# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #2#))
                                    |prime| |q| $)
                                   (PROG1
                                       (LETT #1#
                                             (SPADCALL |part| (QREFELT $ 102)))
                                     (|check_subtype2| (> #1# 0)
                                                       '(|PositiveInteger|)
                                                       '(|Integer|) #1#))
                                   |d| |prime| (QREFELT $ 111))
                                  #4#))))
                         (LETT #3# (CDR #3#)) (GO G190) G191
                         (EXIT (NREVERSE #4#)))))
             (EXIT
              (SPADCALL
               (CONS #'|GUESS;termAsU32VectorqDiff!0| (VECTOR $ |prime| |d|))
               |fl| (QREFELT $ 115))))))))) 

(SDEFUN |GUESS;termAsU32VectorqDiff!0| ((|f1| NIL) (|f2| NIL) ($$ NIL))
        (PROG (|d| |prime| $)
          (LETT |d| (QREFELT $$ 2))
          (LETT |prime| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |f1| |f2| |d| |prime| (QREFELT $ 112)))))) 

(SDEFUN |GUESS;ADEguessModGenq|
        ((|partitions| (|List| (|List| (|Integer|))))
         (|d| (|NonNegativeInteger|))
         ($
          (|Mapping| (|Vector| (|U32Vector|)) (|List| (|U32Vector|))
                     (|Integer|) (|Integer|))))
        (SPROG NIL
               (SEQ
                (CONS #'|GUESS;ADEguessModGenq!0|
                      (VECTOR |d| |partitions| $))))) 

(SDEFUN |GUESS;ADEguessModGenq!0| ((|fl| NIL) (|prime| NIL) (|q| NIL) ($$ NIL))
        (PROG ($ |partitions| |d|)
          (LETT $ (QREFELT $$ 2))
          (LETT |partitions| (QREFELT $$ 1))
          (LETT |d| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G1362 NIL) (|p| NIL) (#2=#:G1361 NIL) (|f| NIL))
                   (SEQ
                    (COND
                     ((SPADCALL (SPADCALL |fl| (QREFELT $ 173))
                                (|spadConstant| $ 174) (QREFELT $ 147))
                      (|error| "ADEguessModGenq, lambda: #fl ~= 1"))
                     ('T
                      (SEQ (LETT |f| (SPADCALL |fl| (QREFELT $ 175)))
                           (EXIT
                            (SPADCALL
                             (PROGN
                              (LETT #2# NIL)
                              (SEQ (LETT |p| NIL) (LETT #1# |partitions|) G190
                                   (COND
                                    ((OR (ATOM #1#)
                                         (PROGN (LETT |p| (CAR #1#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #2#
                                           (CONS
                                            (|GUESS;termAsU32VectorqDiff| |f|
                                             |p| |prime| |q| |d| $)
                                            #2#))))
                                   (LETT #1# (CDR #1#)) (GO G190) G191
                                   (EXIT (NREVERSE #2#))))
                             (QREFELT $ 176)))))))))))) 

(SDEFUN |GUESS;diffHP;SM;58|
        ((|q| (|Symbol|))
         ($
          (|Mapping|
           (|Record| (|:| |degreeStream| (|Stream| (|NonNegativeInteger|)))
                     (|:| |guessStream|
                          (|Mapping|
                           (|Stream| (|UnivariateFormalPowerSeries| F))
                           (|UnivariateFormalPowerSeries| F)))
                     (|:| |guessModGen|
                          (|Mapping|
                           (|Mapping| (|Vector| (|U32Vector|))
                                      (|List| (|U32Vector|)) (|Integer|)
                                      (|Integer|))
                           (|NonNegativeInteger|)))
                     (|:| |testGen|
                          (|Mapping|
                           (|Mapping|
                            (|Vector|
                             (|UnivariateFormalPowerSeries|
                              (|SparseMultivariatePolynomial| F
                                                              (|NonNegativeInteger|))))
                            (|UnivariateFormalPowerSeries|
                             (|SparseMultivariatePolynomial| F
                                                             (|NonNegativeInteger|))))
                           (|List| (|PositiveInteger|))))
                     (|:| |exprStream|
                          (|Mapping| (|Stream| EXPRR) EXPRR (|Symbol|)))
                     (|:| |kind| (|Symbol|)) (|:| |qvar| (|Symbol|))
                     (|:| A
                          (|Mapping| S (|NonNegativeInteger|)
                                     (|NonNegativeInteger|)
                                     (|SparseUnivariatePolynomial| S)))
                     (|:| AF
                          (|Mapping|
                           (|SparseMultivariatePolynomial| F
                                                           (|NonNegativeInteger|))
                           (|NonNegativeInteger|) (|NonNegativeInteger|)
                           (|UnivariateFormalPowerSeries|
                            (|SparseMultivariatePolynomial| F
                                                            (|NonNegativeInteger|)))))
                     (|:| AX
                          (|Mapping| EXPRR (|NonNegativeInteger|) (|Symbol|)
                                     EXPRR))
                     (|:| C (|Mapping| (|List| S) (|NonNegativeInteger|))))
           (|List| (|GuessOption|)))))
        (SPROG NIL (SEQ (CONS #'|GUESS;diffHP;SM;58!8| (VECTOR |q| $))))) 

(SDEFUN |GUESS;diffHP;SM;58!8| ((|l1| NIL) ($$ NIL))
        (PROG ($ |q|)
          (LETT $ (QREFELT $$ 1))
          (LETT |q| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|partitions| NIL))
                   (SEQ
                    (COND
                     ((NULL
                       (SPADCALL (SPADCALL |l1| (QREFELT $ 198))
                                 (QREFELT $ 239)))
                      (|error|
                       (SPADCALL "Guess: no support for mixed shifts in"
                                 " differential equations" (QREFELT $ 42)))))
                    (EXIT
                     (COND
                      ((SPADCALL (SPADCALL |l1| (QREFELT $ 199)) '|displayAsGF|
                                 (QREFELT $ 240))
                       (SEQ
                        (LETT |partitions|
                              (|GUESS;FilteredPartitionStream| |l1| $))
                        (EXIT
                         (VECTOR
                          (SPADCALL (CONS #'|GUESS;diffHP;SM;58!0| $)
                                    |partitions| (QREFELT $ 226))
                          (CONS #'|GUESS;diffHP;SM;58!2|
                                (VECTOR |q| $ |partitions|))
                          (CONS #'|GUESS;diffHP;SM;58!3|
                                (VECTOR $ |partitions|))
                          (CONS #'|GUESS;diffHP;SM;58!5|
                                (VECTOR |q| $ |partitions|))
                          (CONS #'|GUESS;diffHP;SM;58!7|
                                (VECTOR |q| $ |partitions|))
                          '|qdiffHP| |q| (CONS (|function| |GUESS;diffA|) $)
                          (CONS (|function| |GUESS;diffAF|) $)
                          (CONS (|function| |GUESS;diffAX|) $)
                          (CONS (|function| |GUESS;diffC|) $)))))
                      ('T
                       (|error|
                        "Guess: guessADE supports only displayAsGF")))))))))) 

(SDEFUN |GUESS;diffHP;SM;58!7| ((|z1| NIL) (|z2| NIL) ($$ NIL))
        (PROG (|partitions| $ |q|)
          (LETT |partitions| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |q| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (|GUESS;ADEEXPRRStream| |z1| |z2| |partitions|
                    (CONS #'|GUESS;diffHP;SM;58!6| (VECTOR $ |q|))
                    (CONS (|function| |GUESS;diff1X|) $) $)))))) 

(SDEFUN |GUESS;diffHP;SM;58!6| ((|w1| NIL) (|w2| NIL) (|w3| NIL) ($$ NIL))
        (PROG (|q| $)
          (LETT |q| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GUESS;qDiffDX| |q| |w1| |w2| |w3| $))))) 

(SDEFUN |GUESS;diffHP;SM;58!5| ((|l| NIL) ($$ NIL))
        (PROG (|partitions| $ |q|)
          (LETT |partitions| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |q| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G1379 NIL) (|i| NIL) (#2=#:G1378 NIL))
                   (SEQ
                    (|GUESS;ADEtestOptimisedGen|
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |i| NIL) (LETT #1# |l|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #2#
                                   (CONS
                                    (SPADCALL |partitions| |i| (QREFELT $ 204))
                                    #2#))))
                           (LETT #1# (CDR #1#)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))
                     (CONS #'|GUESS;diffHP;SM;58!4| (VECTOR $ |q|))
                     (|spadConstant| $ 205) $))))))) 

(SDEFUN |GUESS;diffHP;SM;58!4| ((|w1| NIL) (|w2| NIL) ($$ NIL))
        (PROG (|q| $)
          (LETT |q| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GUESS;qDiffDSF| |q| |w1| |w2| $))))) 

(SDEFUN |GUESS;diffHP;SM;58!3| ((|o| NIL) ($$ NIL))
        (PROG (|partitions| $)
          (LETT |partitions| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;ADEguessModGenq|
             (SPADCALL
              (SPADCALL (SPADCALL |partitions| |o| (QREFELT $ 201))
                        (QREFELT $ 202))
              (QREFELT $ 203))
             (|spadConstant| $ 95) $))))) 

(SDEFUN |GUESS;diffHP;SM;58!2| ((|z1| NIL) ($$ NIL))
        (PROG (|partitions| $ |q|)
          (LETT |partitions| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |q| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (|GUESS;ADEguessStream| |z1| |partitions|
                    (CONS #'|GUESS;diffHP;SM;58!1| (VECTOR $ |q|))
                    (|spadConstant| $ 200) $)))))) 

(SDEFUN |GUESS;diffHP;SM;58!1| ((|w1| NIL) (|w2| NIL) ($$ NIL))
        (PROG (|q| $)
          (LETT |q| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GUESS;qDiffDS| |q| |w1| |w2| $))))) 

(SDEFUN |GUESS;diffHP;SM;58!0| ((|c| NIL) ($ NIL)) (|spadConstant| $ 95)) 

(SDEFUN |GUESS;ShiftSX|
        ((|expr| (EXPRR)) (|x| (|Symbol|)) (|n| (|NonNegativeInteger|))
         ($ (EXPRR)))
        (SPADCALL |expr| (SPADCALL |x| (QREFELT $ 45))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 45))
                            (SPADCALL |n| (QREFELT $ 243)) (QREFELT $ 93))
                  (QREFELT $ 228))) 

(SDEFUN |GUESS;ShiftSXGF|
        ((|expr| (EXPRR)) (|x| (|Symbol|)) (|n| (|NonNegativeInteger|))
         ($ (EXPRR)))
        (SPROG
         ((|l| (|List| EXPRR)) (#1=#:G1407 NIL) (|i| NIL) (#2=#:G1406 NIL))
         (SEQ
          (COND ((ZEROP |n|) |expr|)
                ('T
                 (SEQ
                  (LETT |l|
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |i| 0) (LETT #1# (- |n| 1)) G190
                              (COND ((|greater_SI| |i| #1#) (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2#
                                      (CONS
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |expr| |x| |i|
                                                    (QREFELT $ 189))
                                          (SPADCALL
                                           (SPADCALL |i| (QREFELT $ 244))
                                           (QREFELT $ 243))
                                          (QREFELT $ 245))
                                         (SPADCALL |x| (QREFELT $ 45))
                                         (|spadConstant| $ 246)
                                         (QREFELT $ 228))
                                        (SPADCALL (SPADCALL |x| (QREFELT $ 45))
                                                  |i| (QREFELT $ 103))
                                        (QREFELT $ 104))
                                       #2#))))
                              (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                              (EXIT (NREVERSE #2#)))))
                  (EXIT
                   (SPADCALL
                    (SPADCALL |expr| (SPADCALL (ELT $ 93) |l| (QREFELT $ 106))
                              (QREFELT $ 247))
                    (SPADCALL (SPADCALL |x| (QREFELT $ 45)) |n|
                              (QREFELT $ 103))
                    (QREFELT $ 245))))))))) 

(SDEFUN |GUESS;ShiftSS|
        ((|s| (|UnivariateFormalPowerSeries| F)) (|n| (|NonNegativeInteger|))
         ($ (|UnivariateFormalPowerSeries| F)))
        (SPADCALL |s| (SPADCALL (ELT $ 248) |n| (QREFELT $ 251)))) 

(SDEFUN |GUESS;ShiftSF|
        ((|s|
          (|UnivariateFormalPowerSeries|
           (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
         (|n| (|NonNegativeInteger|))
         ($
          (|UnivariateFormalPowerSeries|
           (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))))
        (SPADCALL |s| (SPADCALL (ELT $ 252) |n| (QREFELT $ 255)))) 

(SDEFUN |GUESS;ShiftAX|
        ((|l| (|NonNegativeInteger|)) (|n| (|Symbol|)) (|f| (EXPRR))
         ($ (EXPRR)))
        (SPADCALL (SPADCALL (SPADCALL |n| (QREFELT $ 45)) |l| (QREFELT $ 103))
                  |f| (QREFELT $ 104))) 

(SDEFUN |GUESS;ShiftAXGF|
        ((|l| (|NonNegativeInteger|)) (|x| (|Symbol|)) (|f| (EXPRR))
         ($ (EXPRR)))
        (SPROG
         ((|s| (|List| EXPRR)) (#1=#:G1419 NIL) (|i| NIL) (#2=#:G1418 NIL))
         (SEQ
          (COND ((ZEROP |l|) |f|)
                ('T
                 (SEQ
                  (LETT |s|
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |i| 1) (LETT #1# |l|) G190
                              (COND ((|greater_SI| |i| #1#) (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2#
                                      (CONS
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |l| |i| (QREFELT $ 257))
                                          (QREFELT $ 243))
                                         (SPADCALL
                                          (SPADCALL |x| (QREFELT $ 45)) |i|
                                          (QREFELT $ 103))
                                         (QREFELT $ 104))
                                        (SPADCALL |f| |x| |i| (QREFELT $ 189))
                                        (QREFELT $ 104))
                                       #2#))))
                              (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                              (EXIT (NREVERSE #2#)))))
                  (EXIT (SPADCALL (ELT $ 93) |s| (QREFELT $ 106))))))))) 

(SDEFUN |GUESS;ShiftA|
        ((|k| (|NonNegativeInteger|)) (|l| (|NonNegativeInteger|))
         (|f| (|SparseUnivariatePolynomial| S)) ($ (S)))
        (SPADCALL |k| |l| |f| (QREFELT $ 258))) 

(SDEFUN |GUESS;ShiftAF|
        ((|k| (|NonNegativeInteger|)) (|l| (|NonNegativeInteger|))
         (|f|
          (|UnivariateFormalPowerSeries|
           (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
         ($ (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
        (SPADCALL |k| |l| |f| (QREFELT $ 259))) 

(SDEFUN |GUESS;ShiftC| ((|total| (|NonNegativeInteger|)) ($ (|List| S)))
        (SPADCALL |total| (QREFELT $ 260))) 

(SDEFUN |GUESS;shiftHP;LR;68|
        ((|options| (|List| (|GuessOption|)))
         ($
          (|Record| (|:| |degreeStream| (|Stream| (|NonNegativeInteger|)))
                    (|:| |guessStream|
                         (|Mapping|
                          (|Stream| (|UnivariateFormalPowerSeries| F))
                          (|UnivariateFormalPowerSeries| F)))
                    (|:| |guessModGen|
                         (|Mapping|
                          (|Mapping| (|Vector| (|U32Vector|))
                                     (|List| (|U32Vector|)) (|Integer|)
                                     (|Integer|))
                          (|NonNegativeInteger|)))
                    (|:| |testGen|
                         (|Mapping|
                          (|Mapping|
                           (|Vector|
                            (|UnivariateFormalPowerSeries|
                             (|SparseMultivariatePolynomial| F
                                                             (|NonNegativeInteger|))))
                           (|UnivariateFormalPowerSeries|
                            (|SparseMultivariatePolynomial| F
                                                            (|NonNegativeInteger|))))
                          (|List| (|PositiveInteger|))))
                    (|:| |exprStream|
                         (|Mapping| (|Stream| EXPRR) EXPRR (|Symbol|)))
                    (|:| |kind| (|Symbol|)) (|:| |qvar| (|Symbol|))
                    (|:| A
                         (|Mapping| S (|NonNegativeInteger|)
                                    (|NonNegativeInteger|)
                                    (|SparseUnivariatePolynomial| S)))
                    (|:| AF
                         (|Mapping|
                          (|SparseMultivariatePolynomial| F
                                                          (|NonNegativeInteger|))
                          (|NonNegativeInteger|) (|NonNegativeInteger|)
                          (|UnivariateFormalPowerSeries|
                           (|SparseMultivariatePolynomial| F
                                                           (|NonNegativeInteger|)))))
                    (|:| AX
                         (|Mapping| EXPRR (|NonNegativeInteger|) (|Symbol|)
                                    EXPRR))
                    (|:| C (|Mapping| (|List| S) (|NonNegativeInteger|))))))
        (SPROG
         ((|degrees| (|Stream| (|NonNegativeInteger|))) (|dk| (|Symbol|))
          (|partitions| (|Stream| (|List| (|Integer|)))))
         (SEQ
          (COND
           ((NULL (ZEROP (SPADCALL |options| (QREFELT $ 198))))
            (|error| "Guess: need a symbol for mixed Shifting")))
          (LETT |partitions| (|GUESS;FilteredPartitionStream| |options| $))
          (LETT |dk| (SPADCALL |options| (QREFELT $ 199)))
          (EXIT
           (COND
            ((SPADCALL |dk| '|displayAsRec| (QREFELT $ 222))
             (|error|
              "Guess: no support for the Shift operator with displayAsGF"))
            ('T
             (SEQ (LETT |degrees| (|GUESS;ADEdegreeStream| |partitions| $))
                  (EXIT
                   (VECTOR |degrees|
                           (CONS #'|GUESS;shiftHP;LR;68!0|
                                 (VECTOR $ |partitions|))
                           (CONS #'|GUESS;shiftHP;LR;68!1|
                                 (VECTOR |degrees| $ |partitions|))
                           (CONS #'|GUESS;shiftHP;LR;68!2|
                                 (VECTOR $ |partitions|))
                           (CONS #'|GUESS;shiftHP;LR;68!3|
                                 (VECTOR $ |partitions|))
                           '|shiftHP| '|dummy|
                           (CONS (|function| |GUESS;ShiftA|) $)
                           (CONS (|function| |GUESS;ShiftAF|) $)
                           (CONS (|function| |GUESS;ShiftAX|) $)
                           (CONS (|function| |GUESS;ShiftC|) $)))))))))) 

(SDEFUN |GUESS;shiftHP;LR;68!3| ((|z1| NIL) (|z2| NIL) ($$ NIL))
        (PROG (|partitions| $)
          (LETT |partitions| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;ADEEXPRRStream| |z1| |z2| |partitions|
             (CONS (|function| |GUESS;ShiftSX|) $)
             (CONS (|function| |GUESS;diff1X|) $) $))))) 

(SDEFUN |GUESS;shiftHP;LR;68!2| ((|l| NIL) ($$ NIL))
        (PROG (|partitions| $)
          (LETT |partitions| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G1439 NIL) (|i| NIL) (#2=#:G1438 NIL))
                   (SEQ
                    (|GUESS;ADEtestGen2|
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |i| NIL) (LETT #1# |l|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #2#
                                   (CONS
                                    (SPADCALL |partitions| |i| (QREFELT $ 204))
                                    #2#))))
                           (LETT #1# (CDR #1#)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))
                     (CONS (|function| |GUESS;ShiftSF|) $)
                     (SPADCALL
                      (SPADCALL (|spadConstant| $ 205)
                                (SPADCALL (|spadConstant| $ 266)
                                          (|spadConstant| $ 74)
                                          (QREFELT $ 267))
                                (QREFELT $ 268))
                      (SPADCALL (|spadConstant| $ 271) (QREFELT $ 272))
                      (QREFELT $ 273))
                     $))))))) 

(SDEFUN |GUESS;shiftHP;LR;68!1| ((|o| NIL) ($$ NIL))
        (PROG (|partitions| $ |degrees|)
          (LETT |partitions| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |degrees| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;ADEguessModGen2|
             (SPADCALL
              (SPADCALL (SPADCALL |partitions| |o| (QREFELT $ 201))
                        (QREFELT $ 202))
              (QREFELT $ 203))
             (SPADCALL |degrees| |o| (QREFELT $ 265)) $))))) 

(SDEFUN |GUESS;shiftHP;LR;68!0| ((|z1| NIL) ($$ NIL))
        (PROG (|partitions| $)
          (LETT |partitions| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;ADEguessStream2| |z1| |partitions|
             (CONS (|function| |GUESS;ShiftSS|) $)
             (SPADCALL
              (SPADCALL (|spadConstant| $ 200)
                        (SPADCALL (|spadConstant| $ 71) (|spadConstant| $ 174)
                                  (QREFELT $ 261))
                        (QREFELT $ 262))
              (SPADCALL (|spadConstant| $ 71) (QREFELT $ 263)) (QREFELT $ 264))
             $))))) 

(SDEFUN |GUESS;qShiftAX|
        ((|q| (|Symbol|)) (|l| (|NonNegativeInteger|)) (|n| (|Symbol|))
         (|f| (EXPRR)) ($ (EXPRR)))
        (SPADCALL
         (SPADCALL (SPADCALL |q| (QREFELT $ 45))
                   (SPADCALL |l| (SPADCALL |n| (QREFELT $ 45)) (QREFELT $ 275))
                   (QREFELT $ 276))
         |f| (QREFELT $ 104))) 

(SDEFUN |GUESS;qShiftA|
        ((|q| (|Symbol|)) (|k| (|NonNegativeInteger|))
         (|l| (|NonNegativeInteger|)) (|f| (|SparseUnivariatePolynomial| S))
         ($ (S)))
        (SPADCALL (SPADCALL |q| (QREFELT $ 277)) |k| |l| |f| (QREFELT $ 278))) 

(SDEFUN |GUESS;qShiftAF|
        ((|q| (|Symbol|)) (|k| (|NonNegativeInteger|))
         (|l| (|NonNegativeInteger|))
         (|f|
          (|UnivariateFormalPowerSeries|
           (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
         ($ (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
        (SPADCALL (SPADCALL (SPADCALL |q| (QREFELT $ 232)) (QREFELT $ 236)) |k|
                  |l| |f| (QREFELT $ 279))) 

(SDEFUN |GUESS;qShiftC|
        ((|q| (|Symbol|)) (|total| (|NonNegativeInteger|)) ($ (|List| S)))
        (SPADCALL (SPADCALL |q| (QREFELT $ 277)) |total| (QREFELT $ 280))) 

(SDEFUN |GUESS;qSubstUFPSF|
        ((|q| (|Symbol|)) (|s| (|UnivariateFormalPowerSeries| F))
         (|maxMD| (|NonNegativeInteger|))
         ($ (|List| (|UnivariateFormalPowerSeries| F))))
        (SPROG ((#1=#:G1466 NIL) (|i| NIL) (#2=#:G1465 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| 0) (LETT #1# |maxMD|) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL |s|
                                         (SPADCALL
                                          (SPADCALL
                                           (SPADCALL |q| (QREFELT $ 232)) |i|
                                           (QREFELT $ 124))
                                          (SPADCALL (|spadConstant| $ 71) 1
                                                    (QREFELT $ 261))
                                          (QREFELT $ 281))
                                         (QREFELT $ 282))
                               #2#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |GUESS;qSubstEXPRR|
        ((|q| (|Symbol|)) (|xx| (|Symbol|)) (|s| (EXPRR))
         (|maxMD| (|NonNegativeInteger|)) ($ (|List| EXPRR)))
        (SPROG ((#1=#:G1471 NIL) (|i| NIL) (#2=#:G1470 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| 0) (LETT #1# |maxMD|) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL
                                (SPADCALL (SPADCALL |q| (QREFELT $ 45))
                                          (SPADCALL |i|
                                                    (SPADCALL |xx|
                                                              (QREFELT $ 45))
                                                    (QREFELT $ 275))
                                          (QREFELT $ 276))
                                |s| (QREFELT $ 104))
                               #2#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |GUESS;ADEguessStreamMixShift|
        ((|q| (|Symbol|)) (|f| (|UnivariateFormalPowerSeries| F))
         (|partitions| (|Stream| (|List| (|Integer|))))
         (|maxMD| (|NonNegativeInteger|))
         ($ (|Stream| (|UnivariateFormalPowerSeries| F))))
        (SPROG ((|s| (|Stream| (|UnivariateFormalPowerSeries| F))))
               (SEQ
                (LETT |s|
                      (|GUESS;ADEguessStream2| |f| |partitions|
                       (CONS (|function| |GUESS;ShiftSS|) $)
                       (SPADCALL
                        (SPADCALL (|spadConstant| $ 200)
                                  (SPADCALL (|spadConstant| $ 71) 1
                                            (QREFELT $ 261))
                                  (QREFELT $ 262))
                        (SPADCALL (|spadConstant| $ 71) (QREFELT $ 263))
                        (QREFELT $ 264))
                       $))
                (EXIT
                 (SPADCALL |s|
                           (CONS #'|GUESS;ADEguessStreamMixShift!0|
                                 (VECTOR $ |maxMD| |q|))
                           (QREFELT $ 285)))))) 

(SDEFUN |GUESS;ADEguessStreamMixShift!0| ((|z1| NIL) ($$ NIL))
        (PROG (|q| |maxMD| $)
          (LETT |q| (QREFELT $$ 2))
          (LETT |maxMD| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GUESS;qSubstUFPSF| |q| |z1| |maxMD| $))))) 

(SDEFUN |GUESS;ADEguessModGen2Mixed|
        ((|partitions| (|Stream| (|List| (|Integer|))))
         (|dl| (|NonNegativeInteger|)) (|maxMD| (|NonNegativeInteger|))
         (|o| (|NonNegativeInteger|))
         ($
          (|Mapping| (|Vector| (|U32Vector|)) (|List| (|U32Vector|))
                     (|Integer|) (|Integer|))))
        (SPROG NIL
               (SEQ
                (CONS #'|GUESS;ADEguessModGen2Mixed!0|
                      (VECTOR |partitions| |maxMD| |o| |dl| $))))) 

(SDEFUN |GUESS;ADEguessModGen2Mixed!0|
        ((|fl| NIL) (|prime| NIL) (|q| NIL) ($$ NIL))
        (PROG ($ |dl| |o| |maxMD| |partitions|)
          (LETT $ (QREFELT $$ 4))
          (LETT |dl| (QREFELT $$ 3))
          (LETT |o| (QREFELT $$ 2))
          (LETT |maxMD| (QREFELT $$ 1))
          (LETT |partitions| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|l| NIL) (|vv| NIL) (#1=#:G1508 NIL) (|e| NIL) (|vn| NIL)
              (#2=#:G1507 NIL) (|i| NIL) (|r| NIL) (#3=#:G1506 NIL)
              (#4=#:G1505 NIL) (|lastv| NIL) (#5=#:G1503 NIL) (|v| NIL)
              (#6=#:G1504 NIL) (|w| NIL) (|vv1| NIL) (#7=#:G1502 NIL) (|p| NIL)
              (#8=#:G1501 NIL) (O NIL) (#9=#:G1480 NIL) (#10=#:G1500 NIL)
              (|qv| NIL) (|d| NIL) (#11=#:G1477 NIL) (|f| NIL))
             (SEQ
              (COND
               ((SPADCALL (SPADCALL |fl| (QREFELT $ 173))
                          (|spadConstant| $ 174) (QREFELT $ 147))
                (|error| "ADEguessModGen2Mixed: #fl ~= 1"))
               ('T
                (SEQ (LETT |f| (SPADCALL |fl| (QREFELT $ 175)))
                     (LETT |d|
                           (PROG1
                               (LETT #11#
                                     (SPADCALL
                                      (SPADCALL (SPADCALL |f| (QREFELT $ 286))
                                                |dl| (QREFELT $ 183))
                                      (|spadConstant| $ 174) (QREFELT $ 183)))
                             (|check_subtype2| (>= #11# 0)
                                               '(|NonNegativeInteger|)
                                               '(|Integer|) #11#)))
                     (LETT |qv|
                           (SPADCALL
                            (SPADCALL |d| (|spadConstant| $ 174)
                                      (QREFELT $ 76))
                            (|spadConstant| $ 174) (QREFELT $ 287)))
                     (SEQ (LETT |i| (|spadConstant| $ 174)) (LETT #10# |d|)
                          G190 (COND ((> |i| #10#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SPADCALL |qv| |i|
                                      (SPADCALL
                                       (SPADCALL |q| |i| (QREFELT $ 290))
                                       |prime| (QREFELT $ 291))
                                      (QREFELT $ 292))))
                          (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                     (LETT O
                           (PROG1
                               (LETT #9#
                                     (SPADCALL
                                      (SPADCALL |o|
                                                (SPADCALL |maxMD|
                                                          (|spadConstant| $
                                                                          174)
                                                          (QREFELT $ 76))
                                                (QREFELT $ 293))
                                      (QREFELT $ 294)))
                             (|check_subtype2| (>= #9# 0)
                                               '(|NonNegativeInteger|)
                                               '(|Integer|) #9#)))
                     (LETT |vv1|
                           (PROGN
                            (LETT #8# NIL)
                            (SEQ (LETT |p| NIL)
                                 (LETT #7#
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL |partitions| O
                                                   (QREFELT $ 201))
                                         (QREFELT $ 202))
                                        (QREFELT $ 203)))
                                 G190
                                 (COND
                                  ((OR (ATOM #7#)
                                       (PROGN (LETT |p| (CAR #7#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #8#
                                         (CONS
                                          (|GUESS;termAsU32VectorShift| |f| |p|
                                           |prime| |dl| $)
                                          #8#))))
                                 (LETT #7# (CDR #7#)) (GO G190) G191
                                 (EXIT (NREVERSE #8#)))))
                     (LETT |l| NIL)
                     (LETT |lastv| (SPADCALL |vv1| (QREFELT $ 175)))
                     (SEQ (LETT |w| NIL)
                          (LETT #6# (SPADCALL |vv1| (QREFELT $ 295)))
                          (LETT |v| NIL) (LETT #5# |vv1|) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |v| (CAR #5#)) NIL)
                                (ATOM #6#) (PROGN (LETT |w| (CAR #6#)) NIL))
                            (GO G191)))
                          (SEQ (LETT |lastv| |w|) (LETT |vv| (LIST |v|))
                               (LETT |vn| |v|)
                               (SEQ (LETT |i| (|spadConstant| $ 174))
                                    (LETT #4# |maxMD|) G190
                                    (COND ((> |i| #4#) (GO G191)))
                                    (SEQ
                                     (LETT |vn|
                                           (SPADCALL |vn| (QREFELT $ 296)))
                                     (SEQ (LETT |e| (|spadConstant| $ 174))
                                          (LETT #3# |d|) G190
                                          (COND ((> |e| #3#) (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (SPADCALL |vn| |e|
                                                      (QSMULMOD32
                                                       (SPADCALL |vn| |e|
                                                                 (QREFELT $
                                                                          297))
                                                       (SPADCALL |qv| |e|
                                                                 (QREFELT $
                                                                          297))
                                                       |prime|)
                                                      (QREFELT $ 292))))
                                          (LETT |e| (+ |e| 1)) (GO G190) G191
                                          (EXIT NIL))
                                     (EXIT
                                      (LETT |vv|
                                            (SPADCALL |vn| |vv|
                                                      (QREFELT $ 298)))))
                                    (LETT |i| (+ |i| 1)) (GO G190) G191
                                    (EXIT NIL))
                               (EXIT
                                (LETT |l|
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL |vv| (QREFELT $ 299))
                                        (QREFELT $ 176))
                                       |l| (QREFELT $ 301)))))
                          (LETT #5# (PROG1 (CDR #5#) (LETT #6# (CDR #6#))))
                          (GO G190) G191 (EXIT NIL))
                     (LETT |vv| (LIST |lastv|)) (LETT |vn| |lastv|)
                     (LETT |r|
                           (SPADCALL
                            (SPADCALL |o|
                                      (SPADCALL |maxMD| (|spadConstant| $ 174)
                                                (QREFELT $ 76))
                                      (QREFELT $ 302))
                            (|spadConstant| $ 174) (QREFELT $ 183)))
                     (COND
                      ((SPADCALL |r|
                                 (SPADCALL (|spadConstant| $ 289)
                                           (QREFELT $ 303))
                                 (QREFELT $ 98))
                       (LETT |r| |maxMD|)))
                     (SEQ (LETT |i| (|spadConstant| $ 174)) (LETT #2# |r|) G190
                          (COND ((> |i| #2#) (GO G191)))
                          (SEQ (LETT |vn| (SPADCALL |vn| (QREFELT $ 296)))
                               (SEQ (LETT |e| (|spadConstant| $ 174))
                                    (LETT #1# |d|) G190
                                    (COND ((> |e| #1#) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (SPADCALL |vn| |e|
                                                (QSMULMOD32
                                                 (SPADCALL |vn| |e|
                                                           (QREFELT $ 297))
                                                 (SPADCALL |qv| |e|
                                                           (QREFELT $ 297))
                                                 |prime|)
                                                (QREFELT $ 292))))
                                    (LETT |e| (+ |e| 1)) (GO G190) G191
                                    (EXIT NIL))
                               (EXIT
                                (LETT |vv|
                                      (SPADCALL |vn| |vv| (QREFELT $ 298)))))
                          (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                     (LETT |l|
                           (SPADCALL
                            (SPADCALL (SPADCALL |vv| (QREFELT $ 299))
                                      (QREFELT $ 176))
                            |l| (QREFELT $ 301)))
                     (EXIT
                      (SPADCALL (SPADCALL |l| (QREFELT $ 304))
                                (QREFELT $ 306)))))))))))) 

(SDEFUN |GUESS;ADEdegreeStreamMixShift|
        ((|partitions| (|Stream| (|List| (|Integer|))))
         (|maxMD| (|NonNegativeInteger|))
         ($ (|Stream| (|NonNegativeInteger|))))
        (SPROG ((|s| (|Stream| (|NonNegativeInteger|))))
               (SEQ (LETT |s| (|GUESS;ADEdegreeStream| |partitions| $))
                    (EXIT
                     (SPADCALL |s|
                               (CONS #'|GUESS;ADEdegreeStreamMixShift!0|
                                     (VECTOR |maxMD| $))
                               (QREFELT $ 310)))))) 

(SDEFUN |GUESS;ADEdegreeStreamMixShift!0| ((|z1| NIL) ($$ NIL))
        (PROG ($ |maxMD|)
          (LETT $ (QREFELT $$ 1))
          (LETT |maxMD| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G1514 NIL) (|i| NIL) (#2=#:G1513 NIL))
                   (SEQ
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |i| (|spadConstant| $ 95)) (LETT #1# |maxMD|)
                          G190 (COND ((> |i| #1#) (GO G191)))
                          (SEQ (EXIT (LETT #2# (CONS |z1| #2#))))
                          (LETT |i| (+ |i| 1)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))))))) 

(SDEFUN |GUESS;ADEtestMixShiftGen|
        ((|q| (|Symbol|)) (|partitions| (|Stream| (|List| (|Integer|))))
         (|maxMD| (|NonNegativeInteger|)) (|l| (|List| (|PositiveInteger|)))
         ($
          (|Mapping|
           (|Vector|
            (|UnivariateFormalPowerSeries|
             (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
           (|UnivariateFormalPowerSeries|
            (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))))
        (SPROG NIL
               (SEQ
                (CONS #'|GUESS;ADEtestMixShiftGen!0|
                      (VECTOR |q| |partitions| |maxMD| $ |l|))))) 

(SDEFUN |GUESS;ADEtestMixShiftGen!0| ((|f| NIL) ($$ NIL))
        (PROG (|l| $ |maxMD| |partitions| |q|)
          (LETT |l| (QREFELT $$ 4))
          (LETT $ (QREFELT $$ 3))
          (LETT |maxMD| (QREFELT $$ 2))
          (LETT |partitions| (QREFELT $$ 1))
          (LETT |q| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|res| NIL) (#1=#:G1544 NIL) (|i| NIL) (#2=#:G1543 NIL)
              (|f0| NIL) (|exponents| NIL) (#3=#:G1528 NIL)
              (|oldPartition| NIL) (#4=#:G1542 NIL) (#5=#:G1541 NIL)
              (|newPartition| NIL) (#6=#:G1519 NIL) (#7=#:G1540 NIL) (|p| NIL)
              (#8=#:G1517 NIL))
             (SEQ (LETT |res| NIL) (LETT |exponents| NIL)
                  (LETT |oldPartition|
                        (PROG1
                            (LETT #8#
                                  (SPADCALL
                                   (SPADCALL (SPADCALL |l| (QREFELT $ 312))
                                             (SPADCALL |maxMD|
                                                       (|spadConstant| $ 74)
                                                       (QREFELT $ 76))
                                             (QREFELT $ 293))
                                   (QREFELT $ 294)))
                          (|check_subtype2| (> #8# 0) '(|PositiveInteger|)
                                            '(|Integer|) #8#)))
                  (SEQ (LETT |p| NIL) (LETT #7# |l|) G190
                       (COND
                        ((OR (ATOM #7#) (PROGN (LETT |p| (CAR #7#)) NIL))
                         (GO G191)))
                       (SEQ
                        (LETT |newPartition|
                              (PROG1
                                  (LETT #6#
                                        (SPADCALL
                                         (SPADCALL |p|
                                                   (SPADCALL |maxMD|
                                                             (|spadConstant| $
                                                                             74)
                                                             (QREFELT $ 76))
                                                   (QREFELT $ 293))
                                         (QREFELT $ 294)))
                                (|check_subtype2| (> #6# 0)
                                                  '(|PositiveInteger|)
                                                  '(|Integer|) #6#)))
                        (COND
                         ((SPADCALL |newPartition| |oldPartition|
                                    (QREFELT $ 313))
                          (SEQ
                           (LETT |f0|
                                 (|GUESS;termAsUFPSSUPF2| |f|
                                  (SPADCALL |partitions| |oldPartition|
                                            (QREFELT $ 204))
                                  (CONS (|function| |GUESS;ShiftSF|) $)
                                  (SPADCALL
                                   (SPADCALL (|spadConstant| $ 205)
                                             (SPADCALL (|spadConstant| $ 266)
                                                       (|spadConstant| $ 74)
                                                       (QREFELT $ 267))
                                             (QREFELT $ 268))
                                   (SPADCALL (|spadConstant| $ 271)
                                             (QREFELT $ 272))
                                   (QREFELT $ 273))
                                  $))
                           (LETT |res|
                                 (SPADCALL
                                  (PROGN
                                   (LETT #5# NIL)
                                   (SEQ (LETT |i| NIL) (LETT #4# |exponents|)
                                        G190
                                        (COND
                                         ((OR (ATOM #4#)
                                              (PROGN (LETT |i| (CAR #4#)) NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #5#
                                                (CONS
                                                 (SPADCALL |f0|
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (SPADCALL |q|
                                                                        (QREFELT
                                                                         $
                                                                         232))
                                                              |i|
                                                              (QREFELT $ 124))
                                                             (QREFELT $ 236))
                                                            (SPADCALL
                                                             (|spadConstant| $
                                                                             266)
                                                             (|spadConstant| $
                                                                             74)
                                                             (QREFELT $ 267))
                                                            (QREFELT $ 314))
                                                           (QREFELT $ 315))
                                                 #5#))))
                                        (LETT #4# (CDR #4#)) (GO G190) G191
                                        (EXIT (NREVERSE #5#))))
                                  |res| (QREFELT $ 316)))
                           (LETT |exponents| NIL)
                           (EXIT (LETT |oldPartition| |newPartition|)))))
                        (EXIT
                         (LETT |exponents|
                               (SPADCALL
                                (PROG1
                                    (LETT #3#
                                          (SPADCALL
                                           (SPADCALL |p| (|spadConstant| $ 74)
                                                     (QREFELT $ 183))
                                           (SPADCALL |maxMD|
                                                     (|spadConstant| $ 74)
                                                     (QREFELT $ 76))
                                           (QREFELT $ 291)))
                                  (|check_subtype2| (>= #3# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #3#))
                                |exponents| (QREFELT $ 318)))))
                       (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
                  (LETT |f0|
                        (|GUESS;termAsUFPSSUPF2| |f|
                         (SPADCALL |partitions| |oldPartition| (QREFELT $ 204))
                         (CONS (|function| |GUESS;ShiftSF|) $)
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 205)
                                    (SPADCALL (|spadConstant| $ 266)
                                              (|spadConstant| $ 74)
                                              (QREFELT $ 267))
                                    (QREFELT $ 268))
                          (SPADCALL (|spadConstant| $ 271) (QREFELT $ 272))
                          (QREFELT $ 273))
                         $))
                  (LETT |res|
                        (SPADCALL
                         (PROGN
                          (LETT #2# NIL)
                          (SEQ (LETT |i| NIL) (LETT #1# |exponents|) G190
                               (COND
                                ((OR (ATOM #1#)
                                     (PROGN (LETT |i| (CAR #1#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #2#
                                       (CONS
                                        (SPADCALL |f0|
                                                  (SPADCALL
                                                   (SPADCALL
                                                    (SPADCALL
                                                     (SPADCALL |q|
                                                               (QREFELT $ 232))
                                                     |i| (QREFELT $ 124))
                                                    (QREFELT $ 236))
                                                   (SPADCALL
                                                    (|spadConstant| $ 266)
                                                    (|spadConstant| $ 74)
                                                    (QREFELT $ 267))
                                                   (QREFELT $ 314))
                                                  (QREFELT $ 315))
                                        #2#))))
                               (LETT #1# (CDR #1#)) (GO G190) G191
                               (EXIT (NREVERSE #2#))))
                         |res| (QREFELT $ 316)))
                  (EXIT
                   (SPADCALL (SPADCALL |res| (QREFELT $ 319))
                             (QREFELT $ 177))))))))) 

(SDEFUN |GUESS;ADEEXPRRStreamMixShift|
        ((|q| (|Symbol|)) (|f| (EXPRR)) (|xx| (|Symbol|))
         (|partitions| (|Stream| (|List| (|Integer|))))
         (|maxMD| (|NonNegativeInteger|)) ($ (|Stream| EXPRR)))
        (SPROG ((|s| (|Stream| EXPRR)))
               (SEQ
                (LETT |s|
                      (|GUESS;ADEEXPRRStream| |f| |xx| |partitions|
                       (CONS (|function| |GUESS;ShiftSX|) $)
                       (CONS (|function| |GUESS;diff1X|) $) $))
                (EXIT
                 (SPADCALL |s|
                           (CONS #'|GUESS;ADEEXPRRStreamMixShift!0|
                                 (VECTOR $ |maxMD| |xx| |q|))
                           (QREFELT $ 322)))))) 

(SDEFUN |GUESS;ADEEXPRRStreamMixShift!0| ((|z1| NIL) ($$ NIL))
        (PROG (|q| |xx| |maxMD| $)
          (LETT |q| (QREFELT $$ 3))
          (LETT |xx| (QREFELT $$ 2))
          (LETT |maxMD| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GUESS;qSubstEXPRR| |q| |xx| |z1| |maxMD| $))))) 

(SDEFUN |GUESS;shift_hp_aux|
        ((|q| (|Symbol|)) (|l1| (|List| (|GuessOption|)))
         ($
          (|Record| (|:| |degreeStream| (|Stream| (|NonNegativeInteger|)))
                    (|:| |guessStream|
                         (|Mapping|
                          (|Stream| (|UnivariateFormalPowerSeries| F))
                          (|UnivariateFormalPowerSeries| F)))
                    (|:| |guessModGen|
                         (|Mapping|
                          (|Mapping| (|Vector| (|U32Vector|))
                                     (|List| (|U32Vector|)) (|Integer|)
                                     (|Integer|))
                          (|NonNegativeInteger|)))
                    (|:| |testGen|
                         (|Mapping|
                          (|Mapping|
                           (|Vector|
                            (|UnivariateFormalPowerSeries|
                             (|SparseMultivariatePolynomial| F
                                                             (|NonNegativeInteger|))))
                           (|UnivariateFormalPowerSeries|
                            (|SparseMultivariatePolynomial| F
                                                            (|NonNegativeInteger|))))
                          (|List| (|PositiveInteger|))))
                    (|:| |exprStream|
                         (|Mapping| (|Stream| EXPRR) EXPRR (|Symbol|)))
                    (|:| |kind| (|Symbol|)) (|:| |qvar| (|Symbol|))
                    (|:| A
                         (|Mapping| S (|NonNegativeInteger|)
                                    (|NonNegativeInteger|)
                                    (|SparseUnivariatePolynomial| S)))
                    (|:| AF
                         (|Mapping|
                          (|SparseMultivariatePolynomial| F
                                                          (|NonNegativeInteger|))
                          (|NonNegativeInteger|) (|NonNegativeInteger|)
                          (|UnivariateFormalPowerSeries|
                           (|SparseMultivariatePolynomial| F
                                                           (|NonNegativeInteger|)))))
                    (|:| AX
                         (|Mapping| EXPRR (|NonNegativeInteger|) (|Symbol|)
                                    EXPRR))
                    (|:| C (|Mapping| (|List| S) (|NonNegativeInteger|))))))
        (SPROG
         ((|degrees| (|Stream| (|NonNegativeInteger|)))
          (|maxMD| (|NonNegativeInteger|))
          (|partitions| (|Stream| (|List| (|Integer|)))))
         (SEQ
          (COND
           ((SPADCALL (SPADCALL |l1| (QREFELT $ 199)) '|displayAsRec|
                      (QREFELT $ 222))
            (|error|
             (SPADCALL "Guess: no support for the qShift operator"
                       " with displayAsGF" (QREFELT $ 42))))
           (#1='T
            (SEQ (LETT |partitions| (|GUESS;FilteredPartitionStream| |l1| $))
                 (LETT |maxMD| (SPADCALL |l1| (QREFELT $ 198)))
                 (EXIT
                  (COND
                   ((ZEROP |maxMD|)
                    (SEQ
                     (LETT |degrees| (|GUESS;ADEdegreeStream| |partitions| $))
                     (EXIT
                      (VECTOR |degrees|
                              (CONS #'|GUESS;shift_hp_aux!0|
                                    (VECTOR $ |partitions|))
                              (CONS #'|GUESS;shift_hp_aux!1|
                                    (VECTOR |degrees| $ |partitions|))
                              (CONS #'|GUESS;shift_hp_aux!2|
                                    (VECTOR $ |partitions|))
                              (CONS #'|GUESS;shift_hp_aux!3|
                                    (VECTOR $ |partitions|))
                              '|qshiftHP| |q|
                              (CONS #'|GUESS;shift_hp_aux!4| (VECTOR $ |q|))
                              (CONS #'|GUESS;shift_hp_aux!5| (VECTOR $ |q|))
                              (CONS #'|GUESS;shift_hp_aux!6| (VECTOR $ |q|))
                              (CONS #'|GUESS;shift_hp_aux!7|
                                    (VECTOR $ |q|))))))
                   (#1#
                    (SEQ
                     (LETT |degrees|
                           (|GUESS;ADEdegreeStreamMixShift| |partitions|
                            |maxMD| $))
                     (EXIT
                      (VECTOR |degrees|
                              (CONS #'|GUESS;shift_hp_aux!8|
                                    (VECTOR $ |maxMD| |partitions| |q|))
                              (CONS #'|GUESS;shift_hp_aux!9|
                                    (VECTOR |maxMD| $ |degrees| |partitions|))
                              (CONS #'|GUESS;shift_hp_aux!10|
                                    (VECTOR $ |maxMD| |partitions| |q|))
                              (CONS #'|GUESS;shift_hp_aux!11|
                                    (VECTOR $ |maxMD| |partitions| |q|))
                              '|qmixed| |q|
                              (CONS (|function| |GUESS;ShiftA|) $)
                              (CONS (|function| |GUESS;ShiftAF|) $)
                              (CONS (|function| |GUESS;ShiftAX|) $)
                              (CONS (|function| |GUESS;ShiftC|) $))))))))))))) 

(SDEFUN |GUESS;shift_hp_aux!11| ((|z1| NIL) (|z2| NIL) ($$ NIL))
        (PROG (|q| |partitions| |maxMD| $)
          (LETT |q| (QREFELT $$ 3))
          (LETT |partitions| (QREFELT $$ 2))
          (LETT |maxMD| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;ADEEXPRRStreamMixShift| |q| |z1| |z2| |partitions| |maxMD|
             $))))) 

(SDEFUN |GUESS;shift_hp_aux!10| ((|l| NIL) ($$ NIL))
        (PROG (|q| |partitions| |maxMD| $)
          (LETT |q| (QREFELT $$ 3))
          (LETT |partitions| (QREFELT $$ 2))
          (LETT |maxMD| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;ADEtestMixShiftGen| |q| |partitions| |maxMD| |l| $))))) 

(SDEFUN |GUESS;shift_hp_aux!9| ((|o| NIL) ($$ NIL))
        (PROG (|partitions| |degrees| $ |maxMD|)
          (LETT |partitions| (QREFELT $$ 3))
          (LETT |degrees| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |maxMD| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;ADEguessModGen2Mixed| |partitions|
             (SPADCALL |degrees| |o| (QREFELT $ 265)) |maxMD| |o| $))))) 

(SDEFUN |GUESS;shift_hp_aux!8| ((|z1| NIL) ($$ NIL))
        (PROG (|q| |partitions| |maxMD| $)
          (LETT |q| (QREFELT $$ 3))
          (LETT |partitions| (QREFELT $$ 2))
          (LETT |maxMD| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;ADEguessStreamMixShift| |q| |z1| |partitions| |maxMD| $))))) 

(SDEFUN |GUESS;shift_hp_aux!7| ((|z1| NIL) ($$ NIL))
        (PROG (|q| $)
          (LETT |q| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GUESS;qShiftC| |q| |z1| $))))) 

(SDEFUN |GUESS;shift_hp_aux!6| ((|z1| NIL) (|z2| NIL) (|z3| NIL) ($$ NIL))
        (PROG (|q| $)
          (LETT |q| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GUESS;qShiftAX| |q| |z1| |z2| |z3| $))))) 

(SDEFUN |GUESS;shift_hp_aux!5| ((|z1| NIL) (|z2| NIL) (|z3| NIL) ($$ NIL))
        (PROG (|q| $)
          (LETT |q| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GUESS;qShiftAF| |q| |z1| |z2| |z3| $))))) 

(SDEFUN |GUESS;shift_hp_aux!4| ((|z1| NIL) (|z2| NIL) (|z3| NIL) ($$ NIL))
        (PROG (|q| $)
          (LETT |q| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GUESS;qShiftA| |q| |z1| |z2| |z3| $))))) 

(SDEFUN |GUESS;shift_hp_aux!3| ((|z1| NIL) (|z2| NIL) ($$ NIL))
        (PROG (|partitions| $)
          (LETT |partitions| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;ADEEXPRRStream| |z1| |z2| |partitions|
             (CONS (|function| |GUESS;ShiftSX|) $)
             (CONS (|function| |GUESS;diff1X|) $) $))))) 

(SDEFUN |GUESS;shift_hp_aux!2| ((|l| NIL) ($$ NIL))
        (PROG (|partitions| $)
          (LETT |partitions| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G1568 NIL) (|i| NIL) (#2=#:G1567 NIL))
                   (SEQ
                    (|GUESS;ADEtestGen2|
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |i| NIL) (LETT #1# |l|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #2#
                                   (CONS
                                    (SPADCALL |partitions| |i| (QREFELT $ 204))
                                    #2#))))
                           (LETT #1# (CDR #1#)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))
                     (CONS (|function| |GUESS;ShiftSF|) $)
                     (SPADCALL
                      (SPADCALL (|spadConstant| $ 205)
                                (SPADCALL (|spadConstant| $ 266)
                                          (|spadConstant| $ 74)
                                          (QREFELT $ 267))
                                (QREFELT $ 268))
                      (SPADCALL (|spadConstant| $ 271) (QREFELT $ 272))
                      (QREFELT $ 273))
                     $))))))) 

(SDEFUN |GUESS;shift_hp_aux!1| ((|o| NIL) ($$ NIL))
        (PROG (|partitions| $ |degrees|)
          (LETT |partitions| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |degrees| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;ADEguessModGen2|
             (SPADCALL
              (SPADCALL (SPADCALL |partitions| |o| (QREFELT $ 201))
                        (QREFELT $ 202))
              (QREFELT $ 203))
             (SPADCALL |degrees| |o| (QREFELT $ 265)) $))))) 

(SDEFUN |GUESS;shift_hp_aux!0| ((|z1| NIL) ($$ NIL))
        (PROG (|partitions| $)
          (LETT |partitions| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;ADEguessStream2| |z1| |partitions|
             (CONS (|function| |GUESS;ShiftSS|) $)
             (SPADCALL
              (SPADCALL (|spadConstant| $ 200)
                        (SPADCALL (|spadConstant| $ 71) (|spadConstant| $ 174)
                                  (QREFELT $ 261))
                        (QREFELT $ 262))
              (SPADCALL (|spadConstant| $ 71) (QREFELT $ 263)) (QREFELT $ 264))
             $))))) 

(SDEFUN |GUESS;shiftHP;SM;81|
        ((|q| (|Symbol|))
         ($
          (|Mapping|
           (|Record| (|:| |degreeStream| (|Stream| (|NonNegativeInteger|)))
                     (|:| |guessStream|
                          (|Mapping|
                           (|Stream| (|UnivariateFormalPowerSeries| F))
                           (|UnivariateFormalPowerSeries| F)))
                     (|:| |guessModGen|
                          (|Mapping|
                           (|Mapping| (|Vector| (|U32Vector|))
                                      (|List| (|U32Vector|)) (|Integer|)
                                      (|Integer|))
                           (|NonNegativeInteger|)))
                     (|:| |testGen|
                          (|Mapping|
                           (|Mapping|
                            (|Vector|
                             (|UnivariateFormalPowerSeries|
                              (|SparseMultivariatePolynomial| F
                                                              (|NonNegativeInteger|))))
                            (|UnivariateFormalPowerSeries|
                             (|SparseMultivariatePolynomial| F
                                                             (|NonNegativeInteger|))))
                           (|List| (|PositiveInteger|))))
                     (|:| |exprStream|
                          (|Mapping| (|Stream| EXPRR) EXPRR (|Symbol|)))
                     (|:| |kind| (|Symbol|)) (|:| |qvar| (|Symbol|))
                     (|:| A
                          (|Mapping| S (|NonNegativeInteger|)
                                     (|NonNegativeInteger|)
                                     (|SparseUnivariatePolynomial| S)))
                     (|:| AF
                          (|Mapping|
                           (|SparseMultivariatePolynomial| F
                                                           (|NonNegativeInteger|))
                           (|NonNegativeInteger|) (|NonNegativeInteger|)
                           (|UnivariateFormalPowerSeries|
                            (|SparseMultivariatePolynomial| F
                                                            (|NonNegativeInteger|)))))
                     (|:| AX
                          (|Mapping| EXPRR (|NonNegativeInteger|) (|Symbol|)
                                     EXPRR))
                     (|:| C (|Mapping| (|List| S) (|NonNegativeInteger|))))
           (|List| (|GuessOption|)))))
        (SPROG NIL (CONS #'|GUESS;shiftHP;SM;81!0| (VECTOR $ |q|)))) 

(SDEFUN |GUESS;shiftHP;SM;81!0| ((|l1| NIL) ($$ NIL))
        (PROG (|q| $)
          (LETT |q| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GUESS;shift_hp_aux| |q| |l1| $))))) 

(SDEFUN |GUESS;makeEXPRR|
        ((DAX (|Mapping| EXPRR (|NonNegativeInteger|) (|Symbol|) EXPRR))
         (|x| (|Symbol|)) (|p| (|SparseUnivariatePolynomial| F))
         (|expr| (EXPRR)) ($ (EXPRR)))
        (COND ((SPADCALL |p| (QREFELT $ 324)) (|spadConstant| $ 246))
              ('T
               (SPADCALL
                (SPADCALL
                 (SPADCALL (SPADCALL |p| (QREFELT $ 325)) (QREFELT $ 10))
                 (SPADCALL (SPADCALL |p| (QREFELT $ 326)) |x| |expr| DAX)
                 (QREFELT $ 104))
                (|GUESS;makeEXPRR| DAX |x| (SPADCALL |p| (QREFELT $ 327))
                 |expr| $)
                (QREFELT $ 93))))) 

(SDEFUN |GUESS;list2UFPSF|
        ((|list| (|List| F)) ($ (|UnivariateFormalPowerSeries| F)))
        (SPADCALL (SPADCALL |list| (QREFELT $ 329)) (QREFELT $ 330))) 

(SDEFUN |GUESS;list2UFPSSUPF|
        ((|list| (|List| F))
         ($
          (|UnivariateFormalPowerSeries|
           (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))))
        (SPROG
         ((|l2|
           (|Stream|
            (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
          (|s1| (|Stream| (|Integer|)))
          (|l1|
           (|Stream|
            (|SparseMultivariatePolynomial| F (|NonNegativeInteger|))))
          (#1=#:G1618 NIL) (|e| NIL) (#2=#:G1617 NIL))
         (SEQ
          (LETT |l1|
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |e| NIL) (LETT #1# |list|) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |e| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2# (CONS (SPADCALL |e| (QREFELT $ 236)) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 333)))
          (LETT |s1| (SPADCALL (ELT $ 67) 0 (QREFELT $ 70)))
          (LETT |l2|
                (SPADCALL (CONS #'|GUESS;list2UFPSSUPF!0| $) |s1|
                          (QREFELT $ 338)))
          (EXIT
           (SPADCALL (SPADCALL |l1| |l2| (QREFELT $ 339)) (QREFELT $ 340)))))) 

(SDEFUN |GUESS;list2UFPSSUPF!0| ((|i| NIL) ($ NIL))
        (SPROG ((#1=#:G1613 NIL))
               (SPADCALL (|spadConstant| $ 71)
                         (SPADCALL (|spadConstant| $ 174)
                                   (PROG1 (LETT #1# |i|)
                                     (|check_subtype2| (>= #1# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #1#))
                                   (QREFELT $ 335))
                         (QREFELT $ 336)))) 

(SDEFUN |GUESS;SUPF2SUPSUPF|
        ((|p| (|SparseUnivariatePolynomial| F))
         ($
          (|SparseUnivariatePolynomial|
           (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))))
        (SPADCALL (ELT $ 236) |p| (QREFELT $ 344))) 

(SDEFUN |GUESS;UFPSF2SUPF|
        ((|f| (|UnivariateFormalPowerSeries| F)) (|deg| (|NonNegativeInteger|))
         ($ (|SparseUnivariatePolynomial| F)))
        (SPADCALL (SPADCALL |f| |deg| (QREFELT $ 346)) (QREFELT $ 347))) 

(SDEFUN |GUESS;getListSUPF|
        ((|s| (|List| (|UnivariateFormalPowerSeries| F)))
         (|deg| (|NonNegativeInteger|))
         ($ (|List| (|SparseUnivariatePolynomial| F))))
        (SPROG NIL
               (SPADCALL (CONS #'|GUESS;getListSUPF!0| (VECTOR $ |deg|)) |s|
                         (QREFELT $ 351)))) 

(SDEFUN |GUESS;getListSUPF!0| ((|z1| NIL) ($$ NIL))
        (PROG (|deg| $)
          (LETT |deg| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|GUESS;UFPSF2SUPF| |z1| |deg| $))))) 

(SDEFUN |GUESS;guessInterpolateModular|
        ((|lists| (|List| (|List| F))) (|degs| (|List| (|Integer|)))
         (|o| (|NonNegativeInteger|)) (|degreeLoss| (|Integer|))
         (|guessDegree| (|NonNegativeInteger|))
         (D
          (|Record| (|:| |degreeStream| (|Stream| (|NonNegativeInteger|)))
                    (|:| |guessStream|
                         (|Mapping|
                          (|Stream| (|UnivariateFormalPowerSeries| F))
                          (|UnivariateFormalPowerSeries| F)))
                    (|:| |guessModGen|
                         (|Mapping|
                          (|Mapping| (|Vector| (|U32Vector|))
                                     (|List| (|U32Vector|)) (|Integer|)
                                     (|Integer|))
                          (|NonNegativeInteger|)))
                    (|:| |testGen|
                         (|Mapping|
                          (|Mapping|
                           (|Vector|
                            (|UnivariateFormalPowerSeries|
                             (|SparseMultivariatePolynomial| F
                                                             (|NonNegativeInteger|))))
                           (|UnivariateFormalPowerSeries|
                            (|SparseMultivariatePolynomial| F
                                                            (|NonNegativeInteger|))))
                          (|List| (|PositiveInteger|))))
                    (|:| |exprStream|
                         (|Mapping| (|Stream| EXPRR) EXPRR (|Symbol|)))
                    (|:| |kind| (|Symbol|)) (|:| |qvar| (|Symbol|))
                    (|:| A
                         (|Mapping| S (|NonNegativeInteger|)
                                    (|NonNegativeInteger|)
                                    (|SparseUnivariatePolynomial| S)))
                    (|:| AF
                         (|Mapping|
                          (|SparseMultivariatePolynomial| F
                                                          (|NonNegativeInteger|))
                          (|NonNegativeInteger|) (|NonNegativeInteger|)
                          (|UnivariateFormalPowerSeries|
                           (|SparseMultivariatePolynomial| F
                                                           (|NonNegativeInteger|)))))
                    (|:| AX
                         (|Mapping| EXPRR (|NonNegativeInteger|) (|Symbol|)
                                    EXPRR))
                    (|:| C (|Mapping| (|List| S) (|NonNegativeInteger|)))))
         (|options| (|List| (|GuessOption|)))
         ($ (|Union| (|Matrix| (|SparseUnivariatePolynomial| S)) (|Boolean|))))
        (SPROG
         ((|check|
           (|Mapping| (|Union| "good" "reject" "no_solution")
                      (|List| (|SparseUnivariatePolynomial| S))))
          (#1=#:G1696 NIL) (|i| NIL) (#2=#:G1695 NIL)
          (|deg|
           (|Record| (|:| |quotient| (|NonNegativeInteger|))
                     (|:| |remainder| (|NonNegativeInteger|))))
          (#3=#:G1694 NIL) (#4=#:G1693 NIL) (#5=#:G1692 NIL) (#6=#:G1691 NIL)
          (|maxD| (|Union| (|NonNegativeInteger|) "arbitrary"))
          (#7=#:G1644 NIL) (#8=#:G1689 NIL) (|del| (|Integer|))
          (|leadingZeros| (|Integer|)) (#9=#:G1690 NIL) (|el| NIL)
          (|sigma| (|NonNegativeInteger|)) (#10=#:G1641 NIL)
          (|list| (|List| F)))
         (SEQ
          (EXIT
           (SEQ (LETT |list| (|SPADfirst| |lists|))
                (LETT |sigma|
                      (PROG1 (LETT #10# (- (LENGTH |list|) |degreeLoss|))
                        (|check_subtype2| (>= #10# 0) '(|NonNegativeInteger|)
                                          '(|Integer|) #10#)))
                (LETT |leadingZeros| 0)
                (SEQ (LETT |el| NIL) (LETT #9# |list|) G190
                     (COND
                      ((OR (ATOM #9#) (PROGN (LETT |el| (CAR #9#)) NIL)
                           (NULL (SPADCALL |el| (QREFELT $ 352))))
                       (GO G191)))
                     (SEQ (EXIT (LETT |leadingZeros| (+ |leadingZeros| 1))))
                     (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL))
                (COND
                 ((> |leadingZeros| |degreeLoss|)
                  (SEQ (LETT |del| (- |leadingZeros| |degreeLoss|))
                       (EXIT
                        (COND
                         ((> |del| |guessDegree|)
                          (PROGN (LETT #8# (CONS 1 NIL)) (GO #11=#:G1688)))
                         (#12='T
                          (LETT |guessDegree|
                                (PROG1 (LETT #7# (- |guessDegree| |del|))
                                  (|check_subtype2| (>= #7# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #7#)))))))))
                (COND
                 ((NULL (SPADCALL |options| (QREFELT $ 353)))
                  (SEQ (LETT |maxD| (SPADCALL |options| (QREFELT $ 354)))
                       (EXIT
                        (COND
                         ((QEQCAR |maxD| 0)
                          (COND
                           ((< (* (QCDR |maxD|) |o|) |guessDegree|)
                            (LETT |degs|
                                  (PROGN
                                   (LETT #6# NIL)
                                   (SEQ (LETT |i| 1) (LETT #5# |o|) G190
                                        (COND
                                         ((|greater_SI| |i| #5#) (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #6# (CONS (QCDR |maxD|) #6#))))
                                        (LETT |i| (|inc_SI| |i|)) (GO G190)
                                        G191 (EXIT (NREVERSE #6#))))))
                           (#12#
                            (SEQ (LETT |deg| (DIVIDE2 |guessDegree| |o|))
                                 (EXIT
                                  (LETT |degs|
                                        (PROGN
                                         (LETT #4# NIL)
                                         (SEQ (LETT |i| 1) (LETT #3# |o|) G190
                                              (COND
                                               ((|greater_SI| |i| #3#)
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (LETT #4#
                                                      (CONS
                                                       (COND
                                                        ((<= |i| (QCDR |deg|))
                                                         (+ (QCAR |deg|) 1))
                                                        ('T (QCAR |deg|)))
                                                       #4#))))
                                              (LETT |i| (|inc_SI| |i|))
                                              (GO G190) G191
                                              (EXIT (NREVERSE #4#))))))))))
                         (#12#
                          (SEQ (LETT |deg| (DIVIDE2 |guessDegree| |o|))
                               (EXIT
                                (LETT |degs|
                                      (PROGN
                                       (LETT #2# NIL)
                                       (SEQ (LETT |i| 1) (LETT #1# |o|) G190
                                            (COND
                                             ((|greater_SI| |i| #1#)
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #2#
                                                    (CONS
                                                     (COND
                                                      ((<= |i| (QCDR |deg|))
                                                       (+ (QCAR |deg|) 1))
                                                      ('T (QCAR |deg|)))
                                                     #2#))))
                                            (LETT |i| (|inc_SI| |i|)) (GO G190)
                                            G191
                                            (EXIT (NREVERSE #2#)))))))))))))
                (LETT |check|
                      (CONS #'|GUESS;guessInterpolateModular!0|
                            (VECTOR $ |sigma| |options| D |o| |list|)))
                (COND
                 ((QEQCAR (SPADCALL |options| (QREFELT $ 356)) 1)
                  (LETT |check|
                        (SPADCALL |check| |lists| (QVELT D 5) (QVELT D 6)
                                  |sigma| (SPADCALL |o| (QVELT D 2))
                                  (QREFELT $ 360))))
                 ((QEQCAR (SPADCALL |options| (QREFELT $ 356)) 0)
                  (SEQ
                   (COND
                    ((SPADCALL |options| (QREFELT $ 361))
                     (SPADCALL "Guess: skipping checks" (QREFELT $ 363))))
                   (EXIT
                    (LETT |check|
                          (LIST #'|GUESS;guessInterpolateModular!1|)))))
                 (#12#
                  (LETT |check|
                        (CONS #'|GUESS;guessInterpolateModular!2|
                              (VECTOR $ |sigma| |options| D |o| |list|)))))
                (EXIT
                 (SPADCALL |lists| |degs| (QVELT D 5) (QVELT D 6) |sigma|
                           (SPADCALL |o| (QVELT D 2)) |check|
                           (QREFELT $ 365)))))
          #11# (EXIT #8#)))) 

(SDEFUN |GUESS;guessInterpolateModular!2| ((|x| NIL) ($$ NIL))
        (PROG (|list| |o| D |options| |sigma| $)
          (LETT |list| (QREFELT $$ 5))
          (LETT |o| (QREFELT $$ 4))
          (LETT D (QREFELT $$ 3))
          (LETT |options| (QREFELT $$ 2))
          (LETT |sigma| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;checkInterpolant| |list| |o| |x| D |options| |sigma| $))))) 

(SDEFUN |GUESS;guessInterpolateModular!1| ((|x| NIL) ($$ NIL)) (CONS 0 "good")) 

(SDEFUN |GUESS;guessInterpolateModular!0| ((|x| NIL) ($$ NIL))
        (PROG (|list| |o| D |options| |sigma| $)
          (LETT |list| (QREFELT $$ 5))
          (LETT |o| (QREFELT $$ 4))
          (LETT D (QREFELT $$ 3))
          (LETT |options| (QREFELT $$ 2))
          (LETT |sigma| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|GUESS;checkInterpolant| |list| |o| |x| D |options| |sigma| $))))) 

(SDEFUN |GUESS;guessInterpolateFFFG|
        ((|lists| (|List| (|List| F))) (|degs| (|List| (|Integer|)))
         (|o| (|NonNegativeInteger|)) (|guessDegree| (|NonNegativeInteger|))
         (D
          (|Record| (|:| |degreeStream| (|Stream| (|NonNegativeInteger|)))
                    (|:| |guessStream|
                         (|Mapping|
                          #1=(|Stream| (|UnivariateFormalPowerSeries| F))
                          (|UnivariateFormalPowerSeries| F)))
                    (|:| |guessModGen|
                         (|Mapping|
                          (|Mapping| (|Vector| (|U32Vector|))
                                     (|List| (|U32Vector|)) (|Integer|)
                                     (|Integer|))
                          (|NonNegativeInteger|)))
                    (|:| |testGen|
                         (|Mapping|
                          (|Mapping|
                           (|Vector|
                            (|UnivariateFormalPowerSeries|
                             (|SparseMultivariatePolynomial| F
                                                             (|NonNegativeInteger|))))
                           (|UnivariateFormalPowerSeries|
                            (|SparseMultivariatePolynomial| F
                                                            (|NonNegativeInteger|))))
                          (|List| (|PositiveInteger|))))
                    (|:| |exprStream|
                         (|Mapping| (|Stream| EXPRR) EXPRR (|Symbol|)))
                    (|:| |kind| (|Symbol|)) (|:| |qvar| (|Symbol|))
                    (|:| A
                         (|Mapping| S (|NonNegativeInteger|)
                                    (|NonNegativeInteger|)
                                    (|SparseUnivariatePolynomial| S)))
                    (|:| AF
                         (|Mapping|
                          (|SparseMultivariatePolynomial| F
                                                          (|NonNegativeInteger|))
                          (|NonNegativeInteger|) (|NonNegativeInteger|)
                          (|UnivariateFormalPowerSeries|
                           (|SparseMultivariatePolynomial| F
                                                           (|NonNegativeInteger|)))))
                    (|:| AX
                         (|Mapping| EXPRR (|NonNegativeInteger|) (|Symbol|)
                                    EXPRR))
                    (|:| C (|Mapping| (|List| S) (|NonNegativeInteger|)))))
         (|options| (|List| (|GuessOption|)))
         ($ (|Matrix| (|SparseUnivariatePolynomial| S))))
        (SPROG
         ((#2=#:G1789 NIL) (#3=#:G1811 NIL) (|j| NIL) (|c| (S))
          (|cl| (|List| S)) (#4=#:G1810 NIL) (#5=#:G1809 NIL) (#6=#:G1808 NIL)
          (#7=#:G1806 NIL) (|i1| NIL) (#8=#:G1807 NIL) (|i2| NIL)
          (|Mr| (|Matrix| (|SparseUnivariatePolynomial| S)))
          (|m| (|NonNegativeInteger|)) (|rl| (|List| (|Integer|)))
          (#9=#:G1805 NIL) (|i| NIL)
          (M (|Matrix| (|SparseUnivariatePolynomial| S)))
          (|vguessListF| (|Vector| (|SparseUnivariatePolynomial| F)))
          (|vguessList| (|Vector| (|SparseUnivariatePolynomial| S)))
          (|guessPolys| (|List| (|SparseUnivariatePolynomial| F)))
          (#10=#:G1764 NIL)
          (|guessList| (|List| (|UnivariateFormalPowerSeries| F)))
          (|guessS| #1#) (|sumEta| (|NonNegativeInteger|))
          (|eta| (|List| (|NonNegativeInteger|))) (#11=#:G1804 NIL)
          (#12=#:G1803 NIL)
          (|deg|
           (|Record| (|:| |quotient| (|NonNegativeInteger|))
                     (|:| |remainder| (|NonNegativeInteger|))))
          (#13=#:G1725 NIL) (#14=#:G1802 NIL) (#15=#:G1801 NIL)
          (#16=#:G1713 NIL) (#17=#:G1800 NIL) (#18=#:G1799 NIL)
          (|maxD| (|Union| (|NonNegativeInteger|) "arbitrary"))
          (#19=#:G1700 NIL) (#20=#:G1798 NIL) (|d| NIL) (#21=#:G1797 NIL)
          (|list| (|List| F)))
         (SEQ (LETT |list| (|SPADfirst| |lists|))
              (COND
               ((SPADCALL |options| (QREFELT $ 361))
                (SPADCALL "Guess: using FFFG" (QREFELT $ 363))))
              (COND
               ((SPADCALL |options| (QREFELT $ 353))
                (SEQ
                 (LETT |eta|
                       (PROGN
                        (LETT #21# NIL)
                        (SEQ (LETT |d| NIL) (LETT #20# |degs|) G190
                             (COND
                              ((OR (ATOM #20#)
                                   (PROGN (LETT |d| (CAR #20#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #21#
                                     (CONS
                                      (PROG1 (LETT #19# |d|)
                                        (|check_subtype2| (>= #19# 0)
                                                          '(|NonNegativeInteger|)
                                                          '(|Integer|) #19#))
                                      #21#))))
                             (LETT #20# (CDR #20#)) (GO G190) G191
                             (EXIT (NREVERSE #21#)))))
                 (EXIT
                  (SPADCALL |eta| 1 (+ (SPADCALL |eta| 1 (QREFELT $ 366)) 1)
                            (QREFELT $ 367)))))
               (#22='T
                (SEQ (LETT |maxD| (SPADCALL |options| (QREFELT $ 354)))
                     (EXIT
                      (COND
                       ((QEQCAR |maxD| 0)
                        (COND
                         ((< (* (QCDR |maxD|) |o|) |guessDegree|)
                          (LETT |eta|
                                (PROGN
                                 (LETT #18# NIL)
                                 (SEQ (LETT |i| 1) (LETT #17# |o|) G190
                                      (COND
                                       ((|greater_SI| |i| #17#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #18#
                                              (CONS
                                               (COND
                                                ((< |i| |o|)
                                                 (+ (QCDR |maxD|) 1))
                                                ('T (QCDR |maxD|)))
                                               #18#))))
                                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                      (EXIT (NREVERSE #18#))))))
                         (#22#
                          (SEQ
                           (LETT |deg|
                                 (DIVIDE2
                                  (PROG1
                                      (LETT #16# (- (+ |guessDegree| |o|) 1))
                                    (|check_subtype2| (>= #16# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #16#))
                                  |o|))
                           (EXIT
                            (LETT |eta|
                                  (PROGN
                                   (LETT #15# NIL)
                                   (SEQ (LETT |i| 1) (LETT #14# |o|) G190
                                        (COND
                                         ((|greater_SI| |i| #14#) (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #15#
                                                (CONS
                                                 (COND
                                                  ((<= |i| (QCDR |deg|))
                                                   (+ (QCAR |deg|) 1))
                                                  ('T (QCAR |deg|)))
                                                 #15#))))
                                        (LETT |i| (|inc_SI| |i|)) (GO G190)
                                        G191 (EXIT (NREVERSE #15#))))))))))
                       (#22#
                        (SEQ
                         (LETT |deg|
                               (DIVIDE2
                                (PROG1 (LETT #13# (- (+ |guessDegree| |o|) 1))
                                  (|check_subtype2| (>= #13# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #13#))
                                |o|))
                         (EXIT
                          (LETT |eta|
                                (PROGN
                                 (LETT #12# NIL)
                                 (SEQ (LETT |i| 1) (LETT #11# |o|) G190
                                      (COND
                                       ((|greater_SI| |i| #11#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #12#
                                              (CONS
                                               (COND
                                                ((<= |i| (QCDR |deg|))
                                                 (+ (QCAR |deg|) 1))
                                                ('T (QCAR |deg|)))
                                               #12#))))
                                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                      (EXIT (NREVERSE #12#)))))))))))))
              (LETT |sumEta| (SPADCALL (ELT $ 76) |eta| (QREFELT $ 374)))
              (LETT |guessS|
                    (SPADCALL (|GUESS;list2UFPSF| |list| $) (QVELT D 1)))
              (LETT |guessList|
                    (SPADCALL
                     (SPADCALL (SPADCALL |guessS| |o| (QREFELT $ 375))
                               (QREFELT $ 376))
                     (QREFELT $ 377)))
              (LETT |guessPolys|
                    (|GUESS;getListSUPF| |guessList|
                     (PROG1 (LETT #10# (- |sumEta| 1))
                       (|check_subtype2| (>= #10# 0) '(|NonNegativeInteger|)
                                         '(|Integer|) #10#))
                     $))
              (COND
               ((|domainEqual| (QREFELT $ 6) (QREFELT $ 7))
                (SEQ
                 (LETT |vguessList| (SPADCALL |guessPolys| (QREFELT $ 380)))
                 (EXIT
                  (LETT M
                        (SPADCALL (SPADCALL |sumEta| (QVELT D 10)) (QVELT D 7)
                                  |vguessList| |eta| (QREFELT $ 382))))))
               ((|domainEqual| (QREFELT $ 6) (|Fraction| (QREFELT $ 7)))
                (SEQ
                 (LETT |vguessListF| (SPADCALL |guessPolys| (QREFELT $ 384)))
                 (EXIT
                  (LETT M
                        (SPADCALL (SPADCALL |sumEta| (QVELT D 10)) (QVELT D 7)
                                  |vguessListF| |eta| (QREFELT $ 386))))))
               (#22#
                (|error|
                 (SPADCALL "Guess: type parameter F should be either equal to"
                           " S or equal to Fraction S" (QREFELT $ 42)))))
              (LETT |rl| NIL)
              (SEQ (LETT |i| 1) (LETT #9# (ANCOLS M)) G190
                   (COND ((|greater_SI| |i| #9#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((QEQCAR
                        (|GUESS;checkInterpolant| |list| |o|
                         (SPADCALL (SPADCALL M |i| (QREFELT $ 387))
                                   (QREFELT $ 388))
                         D |options| |guessDegree| $)
                        0)
                       (LETT |rl| (CONS |i| |rl|))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND ((NULL |rl|) (MAKE_MATRIX 0 0))
                     (#22#
                      (SEQ (LETT |rl| (NREVERSE |rl|)) (LETT |m| (ANROWS M))
                           (LETT |Mr|
                                 (MAKE_MATRIX1 |m| (LENGTH |rl|)
                                               (|spadConstant| $ 389)))
                           (SEQ (LETT |i2| NIL) (LETT #8# |rl|) (LETT |i1| 1)
                                (LETT #7# (LENGTH |rl|)) G190
                                (COND
                                 ((OR (|greater_SI| |i1| #7#) (ATOM #8#)
                                      (PROGN (LETT |i2| (CAR #8#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (COND
                                  ((|HasCategory| (QREFELT $ 7) '(|Field|))
                                   (SEQ (LETT |c| (|spadConstant| $ 144))
                                        (EXIT
                                         (SEQ (LETT |j| 1) (LETT #6# |m|) G190
                                              (COND
                                               ((OR (|greater_SI| |j| #6#)
                                                    (NULL
                                                     (SPADCALL |c|
                                                               (QREFELT $
                                                                        390))))
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (LETT |c|
                                                      (SPADCALL
                                                       (SPADCALL M |j| |i2|
                                                                 (QREFELT $
                                                                          391))
                                                       (QREFELT $ 392)))))
                                              (LETT |j| (|inc_SI| |j|))
                                              (GO G190) G191 (EXIT NIL)))))
                                  ('T
                                   (SEQ
                                    (LETT |cl|
                                          (PROGN
                                           (LETT #5# NIL)
                                           (SEQ (LETT |j| 1) (LETT #4# |m|)
                                                G190
                                                (COND
                                                 ((|greater_SI| |j| #4#)
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT #5#
                                                        (CONS
                                                         (SPADCALL
                                                          (SPADCALL M |j| |i2|
                                                                    (QREFELT $
                                                                             391))
                                                          (QREFELT $ 393))
                                                         #5#))))
                                                (LETT |j| (|inc_SI| |j|))
                                                (GO G190) G191
                                                (EXIT (NREVERSE #5#)))))
                                    (EXIT
                                     (LETT |c|
                                           (SPADCALL |cl| (QREFELT $ 394)))))))
                                 (EXIT
                                  (SEQ (LETT |j| 1) (LETT #3# |m|) G190
                                       (COND
                                        ((|greater_SI| |j| #3#) (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (SPADCALL |Mr| |j| |i1|
                                                   (PROG2
                                                       (LETT #2#
                                                             (SPADCALL
                                                              (SPADCALL M |j|
                                                                        |i2|
                                                                        (QREFELT
                                                                         $
                                                                         391))
                                                              |c|
                                                              (QREFELT $ 395)))
                                                       (QCDR #2#)
                                                     (|check_union2|
                                                      (QEQCAR #2# 0)
                                                      (|SparseUnivariatePolynomial|
                                                       (QREFELT $ 7))
                                                      (|Union|
                                                       (|SparseUnivariatePolynomial|
                                                        (QREFELT $ 7))
                                                       "failed")
                                                      #2#))
                                                   (QREFELT $ 396))))
                                       (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                       (EXIT NIL))))
                                (LETT |i1|
                                      (PROG1 (|inc_SI| |i1|)
                                        (LETT #8# (CDR #8#))))
                                (GO G190) G191 (EXIT NIL))
                           (EXIT |Mr|)))))))) 

(SDEFUN |GUESS;guessInterpolate3|
        ((|lists| (|List| (|List| F))) (|o| (|NonNegativeInteger|))
         (|degreeLoss| (|Integer|)) (|guessDegree| (|NonNegativeInteger|))
         (D
          (|Record| (|:| |degreeStream| (|Stream| (|NonNegativeInteger|)))
                    (|:| |guessStream|
                         (|Mapping|
                          (|Stream| (|UnivariateFormalPowerSeries| F))
                          (|UnivariateFormalPowerSeries| F)))
                    (|:| |guessModGen|
                         (|Mapping|
                          (|Mapping| (|Vector| (|U32Vector|))
                                     (|List| (|U32Vector|)) (|Integer|)
                                     (|Integer|))
                          (|NonNegativeInteger|)))
                    (|:| |testGen|
                         (|Mapping|
                          (|Mapping|
                           (|Vector|
                            (|UnivariateFormalPowerSeries|
                             (|SparseMultivariatePolynomial| F
                                                             (|NonNegativeInteger|))))
                           (|UnivariateFormalPowerSeries|
                            (|SparseMultivariatePolynomial| F
                                                            (|NonNegativeInteger|))))
                          (|List| (|PositiveInteger|))))
                    (|:| |exprStream|
                         (|Mapping| (|Stream| EXPRR) EXPRR (|Symbol|)))
                    (|:| |kind| (|Symbol|)) (|:| |qvar| (|Symbol|))
                    (|:| A
                         (|Mapping| S (|NonNegativeInteger|)
                                    (|NonNegativeInteger|)
                                    (|SparseUnivariatePolynomial| S)))
                    (|:| AF
                         (|Mapping|
                          (|SparseMultivariatePolynomial| F
                                                          (|NonNegativeInteger|))
                          (|NonNegativeInteger|) (|NonNegativeInteger|)
                          (|UnivariateFormalPowerSeries|
                           (|SparseMultivariatePolynomial| F
                                                           (|NonNegativeInteger|)))))
                    (|:| AX
                         (|Mapping| EXPRR (|NonNegativeInteger|) (|Symbol|)
                                    EXPRR))
                    (|:| C (|Mapping| (|List| S) (|NonNegativeInteger|)))))
         (|options| (|List| (|GuessOption|)))
         (|vs| (|Stream| (|List| (|Integer|))))
         ($ (|Stream| (|Matrix| (|SparseUnivariatePolynomial| S)))))
        (SPROG NIL
               (SEQ
                (SPADCALL
                 (CONS #'|GUESS;guessInterpolate3!1|
                       (VECTOR |options| D |guessDegree| |degreeLoss| |o|
                               |lists| $ |vs|))
                 (QREFELT $ 408))))) 

(SDEFUN |GUESS;guessInterpolate3!1| (($$ NIL))
        (PROG (|vs| $ |lists| |o| |degreeLoss| |guessDegree| D |options|)
          (LETT |vs| (QREFELT $$ 7))
          (LETT $ (QREFELT $$ 6))
          (LETT |lists| (QREFELT $$ 5))
          (LETT |o| (QREFELT $$ 4))
          (LETT |degreeLoss| (QREFELT $$ 3))
          (LETT |guessDegree| (QREFELT $$ 2))
          (LETT D (QREFELT $$ 1))
          (LETT |options| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|degs| NIL) (M0 NIL) (#1=#:G1830 NIL) (M NIL))
                   (SEQ
                    (EXIT
                     (COND
                      ((OR (SPADCALL |vs| (QREFELT $ 397))
                           (SPADCALL |vs| (QREFELT $ 400)))
                       (SPADCALL (QREFELT $ 399)))
                      ('T
                       (SEQ (LETT |degs| (SPADCALL |vs| (QREFELT $ 401)))
                            (LETT M0
                                  (|GUESS;guessInterpolateModular| |lists|
                                   |degs| |o| |degreeLoss| |guessDegree| D
                                   |options| $))
                            (LETT M
                                  (COND
                                   ((QEQCAR M0 1)
                                    (SEQ
                                     (COND
                                      ((QCDR M0)
                                       (COND
                                        ((SPADCALL
                                          (CONS #'|GUESS;guessInterpolate3!0|
                                                $)
                                          |degs| (QREFELT $ 404))
                                         (EXIT
                                          (|GUESS;guessInterpolateFFFG| |lists|
                                           |degs| |o| |guessDegree| D |options|
                                           $))))))
                                     (EXIT
                                      (PROGN
                                       (LETT #1#
                                             (|GUESS;guessInterpolate3| |lists|
                                              |o| |degreeLoss| |guessDegree| D
                                              |options|
                                              (SPADCALL |vs| (QREFELT $ 405))
                                              $))
                                       (GO #2=#:G1829)))))
                                   ('T (QCDR M0))))
                            (EXIT
                             (SPADCALL M
                                       (|GUESS;guessInterpolate3| |lists| |o|
                                        |degreeLoss| |guessDegree| D |options|
                                        (SPADCALL |vs| (QREFELT $ 405)) $)
                                       (QREFELT $ 406)))))))
                    #2# (EXIT #1#))))))) 

(SDEFUN |GUESS;guessInterpolate3!0| ((|x| NIL) ($ NIL))
        (SPADCALL |x| (|spadConstant| $ 95) (QREFELT $ 402))) 

(SDEFUN |GUESS;listDecr|
        ((|l| (|List| (|NonNegativeInteger|))) ($ (|List| (|Integer|))))
        (SPADCALL (CONS #'|GUESS;listDecr!0| $) |l| (QREFELT $ 411))) 

(SDEFUN |GUESS;listDecr!0| ((|x| NIL) ($ NIL))
        (SPADCALL |x| (|spadConstant| $ 174) (QREFELT $ 183))) 

(SDEFUN |GUESS;guessInterpolate2|
        ((|lists| (|List| (|List| F))) (|o| (|NonNegativeInteger|))
         (|degreeLoss| (|Integer|)) (|guessDegree| (|NonNegativeInteger|))
         (D
          (|Record| (|:| |degreeStream| (|Stream| (|NonNegativeInteger|)))
                    (|:| |guessStream|
                         (|Mapping|
                          (|Stream| (|UnivariateFormalPowerSeries| F))
                          (|UnivariateFormalPowerSeries| F)))
                    (|:| |guessModGen|
                         (|Mapping|
                          (|Mapping| (|Vector| (|U32Vector|))
                                     (|List| (|U32Vector|)) (|Integer|)
                                     (|Integer|))
                          (|NonNegativeInteger|)))
                    (|:| |testGen|
                         (|Mapping|
                          (|Mapping|
                           (|Vector|
                            (|UnivariateFormalPowerSeries|
                             (|SparseMultivariatePolynomial| F
                                                             (|NonNegativeInteger|))))
                           (|UnivariateFormalPowerSeries|
                            (|SparseMultivariatePolynomial| F
                                                            (|NonNegativeInteger|))))
                          (|List| (|PositiveInteger|))))
                    (|:| |exprStream|
                         (|Mapping| (|Stream| EXPRR) EXPRR (|Symbol|)))
                    (|:| |kind| (|Symbol|)) (|:| |qvar| (|Symbol|))
                    (|:| A
                         (|Mapping| S (|NonNegativeInteger|)
                                    (|NonNegativeInteger|)
                                    (|SparseUnivariatePolynomial| S)))
                    (|:| AF
                         (|Mapping|
                          (|SparseMultivariatePolynomial| F
                                                          (|NonNegativeInteger|))
                          (|NonNegativeInteger|) (|NonNegativeInteger|)
                          (|UnivariateFormalPowerSeries|
                           (|SparseMultivariatePolynomial| F
                                                           (|NonNegativeInteger|)))))
                    (|:| AX
                         (|Mapping| EXPRR (|NonNegativeInteger|) (|Symbol|)
                                    EXPRR))
                    (|:| C (|Mapping| (|List| S) (|NonNegativeInteger|)))))
         (|options| (|List| (|GuessOption|)))
         ($ (|Stream| (|Matrix| (|SparseUnivariatePolynomial| S)))))
        (SPROG
         ((|vs| (|Stream| (|List| (|Integer|))))
          (|vs0| (|Stream| (|List| (|NonNegativeInteger|))))
          (|maxD| (|NonNegativeInteger|))
          (|maxD0| (|Union| (|NonNegativeInteger|) "arbitrary")))
         (SEQ
          (LETT |vs|
                (COND
                 ((SPADCALL |options| (QREFELT $ 353))
                  (SEQ (LETT |maxD0| (SPADCALL |options| (QREFELT $ 354)))
                       (LETT |maxD|
                             (COND ((QEQCAR |maxD0| 0) (QCDR |maxD0|))
                                   (#1='T (- (+ |guessDegree| |o|) 2))))
                       (LETT |vs0|
                             (SPADCALL (+ |guessDegree| |o|) (+ |maxD| 1) |o|
                                       (QREFELT $ 413)))
                       (EXIT
                        (SPADCALL (CONS (|function| |GUESS;listDecr|) $) |vs0|
                                  (QREFELT $ 416)))))
                 (#1#
                  (SPADCALL NIL (SPADCALL (QREFELT $ 417)) (QREFELT $ 418)))))
          (EXIT
           (|GUESS;guessInterpolate3| |lists| |o| |degreeLoss| |guessDegree| D
            |options| |vs| $))))) 

(SDEFUN |GUESS;precCheck|
        ((|list| (|List| F)) (|resi| (|List| (|SparseUnivariatePolynomial| S)))
         (|options| (|List| (|GuessOption|))) (|sigma| (|Integer|))
         (|bad| (|Boolean|)) ($ (|Union| "good" "reject" "no_solution")))
        (SPROG
         ((#1=#:G1898 NIL) (#2=#:G1896 NIL) (|res2| (S)) (|p2val| (S))
          (|p2| (|SparseUnivariatePolynomial| S)) (#3=#:G1908 NIL) (|j| NIL)
          (#4=#:G1895 NIL) (#5=#:G1907 NIL) (|si| (S)) (#6=#:G1906 NIL)
          (|i| NIL) (#7=#:G1897 NIL) (|res1| (S)) (#8=#:G1905 NIL)
          (#9=#:G1904 NIL) (|gl| (|Vector| S)) (#10=#:G1893 NIL)
          (#11=#:G1903 NIL) (#12=#:G1892 NIL) (#13=#:G1902 NIL)
          (#14=#:G1901 NIL) (#15=#:G1894 NIL) (|cden| (S)) (|c2| (S))
          (#16=#:G1854 NIL) (|c1| (S)) (|pp| (S)) (|vd| (S)) (|vi| (F))
          (#17=#:G1900 NIL) (#18=#:G1899 NIL) (|j0| (|Integer|))
          (|svar| (|SingletonAsOrderedSet|)) (|max_ind| #19=(|Integer|))
          (|degree_loss| #19#) (|gl0| (|Vector| F))
          (|m| (|NonNegativeInteger|))
          (|resv| (|Vector| (|SparseUnivariatePolynomial| S)))
          (|homo| (|Boolean|))
          (|homp| (|Union| (|PositiveInteger|) (|Boolean|))))
         (SEQ
          (EXIT
           (SEQ (LETT |homp| (SPADCALL |options| (QREFELT $ 59)))
                (LETT |homo|
                      (COND ((QEQCAR |homp| 1) (QCDR |homp|)) (#20='T 'T)))
                (LETT |resv| (SPADCALL |resi| (QREFELT $ 380)))
                (LETT |m| (QVSIZE |resv|))
                (LETT |gl0| (SPADCALL |list| (QREFELT $ 420)))
                (LETT |degree_loss| (COND (|homo| (- |m| 1)) (#20# (- |m| 2))))
                (COND
                 ((SPADCALL |options| (QREFELT $ 421))
                  (LETT |max_ind| (- (- (QVSIZE |gl0|) |degree_loss|) 1)))
                 (#20# (LETT |max_ind| (- |sigma| 1))))
                (LETT |svar| (SPADCALL (QREFELT $ 423)))
                (LETT |j0| (COND (|homo| 1) (#20# 2)))
                (EXIT
                 (COND
                  ((|domainEqual| (QREFELT $ 6) (|Fraction| (QREFELT $ 7)))
                   (SEQ (LETT |gl| |gl0|)
                        (SEQ (LETT |i| 0) (LETT #18# |max_ind|) G190
                             (COND ((|greater_SI| |i| #18#) (GO G191)))
                             (SEQ
                              (EXIT
                               (SEQ (LETT |res1| (|spadConstant| $ 144))
                                    (LETT |cden| (|spadConstant| $ 72))
                                    (LETT |si| (SPADCALL |i| (QREFELT $ 424)))
                                    (COND
                                     ((NULL |homo|)
                                      (LETT |res1|
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL |resv| 1
                                                        (QREFELT $ 425))
                                              |svar| |si| (QREFELT $ 426))
                                             (QREFELT $ 427)))))
                                    (SEQ (LETT |j| |j0|) (LETT #17# |m|) G190
                                         (COND ((> |j| #17#) (GO G191)))
                                         (SEQ
                                          (LETT |p2|
                                                (SPADCALL |resv| |j|
                                                          (QREFELT $ 425)))
                                          (LETT |p2val|
                                                (SPADCALL
                                                 (SPADCALL |p2| |svar| |si|
                                                           (QREFELT $ 426))
                                                 (QREFELT $ 427)))
                                          (LETT |vi|
                                                (SPADCALL |gl|
                                                          (+
                                                           (- (+ |i| |j|) |j0|)
                                                           1)
                                                          (QREFELT $ 428)))
                                          (LETT |vd|
                                                (SPADCALL |vi| (QREFELT $ 36)))
                                          (LETT |pp|
                                                (SPADCALL |cden| |vd|
                                                          (QREFELT $ 429)))
                                          (LETT |c1|
                                                (PROG2
                                                    (LETT #16#
                                                          (SPADCALL |cden| |pp|
                                                                    (QREFELT $
                                                                             430)))
                                                    (QCDR #16#)
                                                  (|check_union2|
                                                   (QEQCAR #16# 0)
                                                   (QREFELT $ 7)
                                                   (|Union| (QREFELT $ 7)
                                                            #21="failed")
                                                   #16#)))
                                          (LETT |c2|
                                                (PROG2
                                                    (LETT #16#
                                                          (SPADCALL |vd| |pp|
                                                                    (QREFELT $
                                                                             430)))
                                                    (QCDR #16#)
                                                  (|check_union2|
                                                   (QEQCAR #16# 0)
                                                   (QREFELT $ 7)
                                                   (|Union| (QREFELT $ 7) #21#)
                                                   #16#)))
                                          (LETT |res1|
                                                (SPADCALL
                                                 (SPADCALL |c2| |res1|
                                                           (QREFELT $ 431))
                                                 (SPADCALL
                                                  (SPADCALL |p2val| |c1|
                                                            (QREFELT $ 431))
                                                  (SPADCALL |vi|
                                                            (QREFELT $ 35))
                                                  (QREFELT $ 431))
                                                 (QREFELT $ 370)))
                                          (EXIT
                                           (LETT |cden|
                                                 (SPADCALL |cden| |c2|
                                                           (QREFELT $ 431)))))
                                         (LETT |j| (+ |j| 1)) (GO G190) G191
                                         (EXIT NIL))
                                    (EXIT
                                     (COND
                                      ((SPADCALL |res1| (|spadConstant| $ 144)
                                                 (QREFELT $ 432))
                                       (PROGN
                                        (LETT #15#
                                              (COND
                                               ((< |i| |sigma|)
                                                (PROGN
                                                 (LETT #1#
                                                       (CONS 2 "no_solution"))
                                                 (GO #22=#:G1891)))
                                               ('T
                                                (PROGN
                                                 (LETT #1# (CONS 1 "reject"))
                                                 (GO #22#)))))
                                        (GO #23=#:G1858)))))))
                              #23# (EXIT #15#))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))
                        (COND
                         ((NULL (SPADCALL |options| (QREFELT $ 421)))
                          (PROGN (LETT #1# (CONS 0 "good")) (GO #22#))))
                        (EXIT
                         (COND
                          (|bad|
                           (PROGN (LETT #1# (CONS 1 "reject")) (GO #22#)))
                          (#20#
                           (SEQ
                            (SEQ (LETT |i| 1) (LETT #14# |degree_loss|) G190
                                 (COND ((|greater_SI| |i| #14#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (SEQ
                                    (LETT |si|
                                          (SPADCALL (+ |i| |max_ind|)
                                                    (QREFELT $ 424)))
                                    (SEQ (LETT |j| (- |m| |i|)) (LETT #13# |m|)
                                         G190 (COND ((> |j| #13#) (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (SEQ
                                            (LETT |p2|
                                                  (SPADCALL |resv| |j|
                                                            (QREFELT $ 425)))
                                            (LETT |p2val|
                                                  (SPADCALL
                                                   (SPADCALL |p2| |svar| |si|
                                                             (QREFELT $ 426))
                                                   (QREFELT $ 427)))
                                            (EXIT
                                             (COND
                                              ((SPADCALL |p2val|
                                                         (|spadConstant| $ 144)
                                                         (QREFELT $ 432))
                                               (PROGN
                                                (LETT #12#
                                                      (PROGN
                                                       (LETT #1#
                                                             (CONS 0 "good"))
                                                       (GO #22#)))
                                                (GO #24=#:G1863)))))))
                                          #24# (EXIT #12#))
                                         (LETT |j| (+ |j| 1)) (GO G190) G191
                                         (EXIT NIL))
                                    (LETT |res2| (|spadConstant| $ 143))
                                    (COND
                                     (|homo|
                                      (LETT |res2|
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL
                                               (SPADCALL |resv| 1
                                                         (QREFELT $ 425))
                                               |svar| |si| (QREFELT $ 426))
                                              (QREFELT $ 427))
                                             (QREFELT $ 49)))))
                                    (SEQ (LETT |j| |j0|)
                                         (LETT #11# (- |m| |i|)) G190
                                         (COND ((> |j| #11#) (GO G191)))
                                         (SEQ
                                          (LETT |p2|
                                                (SPADCALL |resv| |j|
                                                          (QREFELT $ 425)))
                                          (LETT |p2val|
                                                (SPADCALL
                                                 (SPADCALL |p2| |svar| |si|
                                                           (QREFELT $ 426))
                                                 (QREFELT $ 427)))
                                          (EXIT
                                           (LETT |res2|
                                                 (SPADCALL |res2|
                                                           (SPADCALL |p2val|
                                                                     (SPADCALL
                                                                      |gl|
                                                                      (+
                                                                       (-
                                                                        (+
                                                                         (+ |i|
                                                                            |max_ind|)
                                                                         |j|)
                                                                        |j0|)
                                                                       1)
                                                                      (QREFELT
                                                                       $ 428))
                                                                     (QREFELT $
                                                                              433))
                                                           (QREFELT $ 434)))))
                                         (LETT |j| (+ |j| 1)) (GO G190) G191
                                         (EXIT NIL))
                                    (EXIT
                                     (COND
                                      ((SPADCALL |res2| (|spadConstant| $ 143)
                                                 (QREFELT $ 435))
                                       (PROGN
                                        (LETT #10#
                                              (PROGN
                                               (LETT #1# (CONS 1 "reject"))
                                               (GO #22#)))
                                        (GO #25=#:G1868)))))))
                                  #25# (EXIT #10#))
                                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT
                             (PROGN
                              (LETT #1# (CONS 0 "good"))
                              (GO #22#)))))))))
                  ((|domainEqual| (QREFELT $ 6) (QREFELT $ 7))
                   (SEQ (LETT |gl| |gl0|)
                        (SEQ (LETT |i| 0) (LETT #9# |max_ind|) G190
                             (COND ((|greater_SI| |i| #9#) (GO G191)))
                             (SEQ
                              (EXIT
                               (SEQ (LETT |res1| (|spadConstant| $ 144))
                                    (LETT |si| (SPADCALL |i| (QREFELT $ 424)))
                                    (COND
                                     ((NULL |homo|)
                                      (LETT |res1|
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL |resv| 1
                                                        (QREFELT $ 425))
                                              |svar| |si| (QREFELT $ 426))
                                             (QREFELT $ 427)))))
                                    (SEQ (LETT |j| |j0|) (LETT #8# |m|) G190
                                         (COND ((> |j| #8#) (GO G191)))
                                         (SEQ
                                          (LETT |p2|
                                                (SPADCALL |resv| |j|
                                                          (QREFELT $ 425)))
                                          (LETT |p2val|
                                                (SPADCALL
                                                 (SPADCALL |p2| |svar| |si|
                                                           (QREFELT $ 426))
                                                 (QREFELT $ 427)))
                                          (EXIT
                                           (LETT |res1|
                                                 (SPADCALL |res1|
                                                           (SPADCALL |p2val|
                                                                     (SPADCALL
                                                                      |gl|
                                                                      (+
                                                                       (-
                                                                        (+ |i|
                                                                           |j|)
                                                                        |j0|)
                                                                       1)
                                                                      (QREFELT
                                                                       $ 437))
                                                                     (QREFELT $
                                                                              431))
                                                           (QREFELT $ 370)))))
                                         (LETT |j| (+ |j| 1)) (GO G190) G191
                                         (EXIT NIL))
                                    (EXIT
                                     (COND
                                      ((SPADCALL |res1| (|spadConstant| $ 144)
                                                 (QREFELT $ 432))
                                       (PROGN
                                        (LETT #7#
                                              (COND
                                               ((< |i| |sigma|)
                                                (PROGN
                                                 (LETT #1#
                                                       (CONS 2 "no_solution"))
                                                 (GO #22#)))
                                               ('T
                                                (PROGN
                                                 (LETT #1# (CONS 1 "reject"))
                                                 (GO #22#)))))
                                        (GO #26=#:G1876)))))))
                              #26# (EXIT #7#))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))
                        (COND
                         ((NULL (SPADCALL |options| (QREFELT $ 421)))
                          (PROGN (LETT #1# (CONS 0 "good")) (GO #22#))))
                        (EXIT
                         (COND
                          (|bad|
                           (PROGN (LETT #1# (CONS 1 "reject")) (GO #22#)))
                          (#20#
                           (SEQ
                            (SEQ (LETT |i| 1) (LETT #6# |degree_loss|) G190
                                 (COND ((|greater_SI| |i| #6#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (SEQ
                                    (LETT |si|
                                          (SPADCALL (+ |i| |max_ind|)
                                                    (QREFELT $ 424)))
                                    (SEQ (LETT |j| (- |m| |i|)) (LETT #5# |m|)
                                         G190 (COND ((> |j| #5#) (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (SEQ
                                            (LETT |p2|
                                                  (SPADCALL |resv| |j|
                                                            (QREFELT $ 425)))
                                            (LETT |p2val|
                                                  (SPADCALL
                                                   (SPADCALL |p2| |svar| |si|
                                                             (QREFELT $ 426))
                                                   (QREFELT $ 427)))
                                            (EXIT
                                             (COND
                                              ((SPADCALL |p2val|
                                                         (|spadConstant| $ 144)
                                                         (QREFELT $ 432))
                                               (PROGN
                                                (LETT #4#
                                                      (PROGN
                                                       (LETT #1#
                                                             (CONS 0 "good"))
                                                       (GO #22#)))
                                                (GO #27=#:G1881)))))))
                                          #27# (EXIT #4#))
                                         (LETT |j| (+ |j| 1)) (GO G190) G191
                                         (EXIT NIL))
                                    (LETT |res2| (|spadConstant| $ 144))
                                    (COND
                                     (|homo|
                                      (LETT |res2|
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL |resv| 1
                                                        (QREFELT $ 425))
                                              |svar| |si| (QREFELT $ 426))
                                             (QREFELT $ 427)))))
                                    (SEQ (LETT |j| |j0|) (LETT #3# (- |m| |i|))
                                         G190 (COND ((> |j| #3#) (GO G191)))
                                         (SEQ
                                          (LETT |p2|
                                                (SPADCALL |resv| |j|
                                                          (QREFELT $ 425)))
                                          (LETT |p2val|
                                                (SPADCALL
                                                 (SPADCALL |p2| |svar| |si|
                                                           (QREFELT $ 426))
                                                 (QREFELT $ 427)))
                                          (EXIT
                                           (LETT |res2|
                                                 (SPADCALL |res2|
                                                           (SPADCALL |p2val|
                                                                     (SPADCALL
                                                                      |gl|
                                                                      (+
                                                                       (-
                                                                        (+
                                                                         (+ |i|
                                                                            |max_ind|)
                                                                         |j|)
                                                                        |j0|)
                                                                       1)
                                                                      (QREFELT
                                                                       $ 437))
                                                                     (QREFELT $
                                                                              431))
                                                           (QREFELT $ 370)))))
                                         (LETT |j| (+ |j| 1)) (GO G190) G191
                                         (EXIT NIL))
                                    (EXIT
                                     (COND
                                      ((SPADCALL |res2| (|spadConstant| $ 144)
                                                 (QREFELT $ 432))
                                       (PROGN
                                        (LETT #2#
                                              (PROGN
                                               (LETT #1# (CONS 1 "reject"))
                                               (GO #22#)))
                                        (GO #28=#:G1886)))))))
                                  #28# (EXIT #2#))
                                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT
                             (PROGN
                              (LETT #1# (CONS 0 "good"))
                              (GO #22#)))))))))
                  (#20# (|error| "F must be S or Fraction(S)"))))))
          #22# (EXIT #1#)))) 

(SDEFUN |GUESS;checkInterpolant|
        ((|list| (|List| F)) (|o| (|NonNegativeInteger|))
         (|resi| (|List| (|SparseUnivariatePolynomial| S)))
         (D
          (|Record| (|:| |degreeStream| (|Stream| (|NonNegativeInteger|)))
                    (|:| |guessStream|
                         (|Mapping|
                          (|Stream| (|UnivariateFormalPowerSeries| F))
                          (|UnivariateFormalPowerSeries| F)))
                    (|:| |guessModGen|
                         (|Mapping|
                          (|Mapping| (|Vector| (|U32Vector|))
                                     (|List| (|U32Vector|)) (|Integer|)
                                     (|Integer|))
                          (|NonNegativeInteger|)))
                    (|:| |testGen|
                         (|Mapping|
                          (|Mapping|
                           #1=(|Vector|
                               (|UnivariateFormalPowerSeries|
                                (|SparseMultivariatePolynomial| F
                                                                (|NonNegativeInteger|))))
                           (|UnivariateFormalPowerSeries|
                            (|SparseMultivariatePolynomial| F
                                                            (|NonNegativeInteger|))))
                          (|List| (|PositiveInteger|))))
                    (|:| |exprStream|
                         (|Mapping| (|Stream| EXPRR) EXPRR (|Symbol|)))
                    (|:| |kind| (|Symbol|)) (|:| |qvar| (|Symbol|))
                    (|:| A
                         (|Mapping| S (|NonNegativeInteger|)
                                    (|NonNegativeInteger|)
                                    (|SparseUnivariatePolynomial| S)))
                    (|:| AF
                         (|Mapping|
                          (|SparseMultivariatePolynomial| F
                                                          (|NonNegativeInteger|))
                          (|NonNegativeInteger|) (|NonNegativeInteger|)
                          (|UnivariateFormalPowerSeries|
                           (|SparseMultivariatePolynomial| F
                                                           (|NonNegativeInteger|)))))
                    (|:| AX
                         (|Mapping| EXPRR (|NonNegativeInteger|) (|Symbol|)
                                    EXPRR))
                    (|:| C (|Mapping| (|List| S) (|NonNegativeInteger|)))))
         (|options| (|List| (|GuessOption|))) (|sigma| (|Integer|))
         ($ (|Union| "good" "reject" "no_solution")))
        (SPROG
         ((#2=#:G1965 NIL) (#3=#:G1963 NIL) (|order| (|Integer|))
          (|c| (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))
          (|d| NIL) (|dmax| (|NonNegativeInteger|))
          (|resiSUPF|
           (|List|
            (|SparseUnivariatePolynomial|
             (|SparseMultivariatePolynomial| F (|NonNegativeInteger|)))))
          (#4=#:G1970 NIL) (|i| NIL) (#5=#:G1969 NIL) (|testList| #1#)
          (|flist| (|List| (|PositiveInteger|))) (#6=#:G1942 NIL)
          (#7=#:G1968 NIL) (#8=#:G1967 NIL) (|maxPow| (|Integer|))
          (|maxP| (|Union| (|PositiveInteger|) "arbitrary"))
          (|len| (|NonNegativeInteger|)) (|reject_one_term| (|Boolean|))
          (#9=#:G1964 NIL)
          (|nonZeroCoefficients| (|Union| "one" "several" "none"))
          (#10=#:G1966 NIL))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((SPADCALL |options| (QREFELT $ 361))
              (SPADCALL "Guess: checking solution" (QREFELT $ 363))))
            (LETT |nonZeroCoefficients| (CONS 2 "none"))
            (LETT |reject_one_term| NIL)
            (SEQ
             (EXIT
              (SEQ (LETT |i| 1) (LETT #10# (LENGTH |resi|)) G190
                   (COND ((|greater_SI| |i| #10#) (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((NULL
                        (SPADCALL (SPADCALL |resi| |i| (QREFELT $ 438))
                                  (QREFELT $ 439)))
                       (COND
                        ((QEQCAR |nonZeroCoefficients| 2)
                         (LETT |nonZeroCoefficients| (CONS 0 "one")))
                        ('T
                         (SEQ (LETT |nonZeroCoefficients| (CONS 1 "several"))
                              (EXIT
                               (PROGN
                                (LETT #9# |$NoValue|)
                                (GO #11=#:G1918))))))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL)))
             #11# (EXIT #9#))
            (COND
             ((NULL (QEQCAR |nonZeroCoefficients| 1))
              (COND
               ((NULL (SPADCALL (ELT $ 352) |list| (QREFELT $ 446)))
                (SEQ (LETT |reject_one_term| 'T)
                     (EXIT
                      (COND
                       ((SPADCALL |options| (QREFELT $ 361))
                        (SPADCALL "Guess: encountered single-term solution"
                                  (QREFELT $ 363))))))))))
            (LETT |len| (LENGTH |list|))
            (LETT |maxP| (SPADCALL |options| (QREFELT $ 57)))
            (COND ((QEQCAR |maxP| 0) (LETT |maxPow| (QCDR |maxP|)))
                  (#12='T (LETT |maxPow| (+ |len| 2))))
            (COND
             ((EQL |maxPow| 1)
              (COND
               ((EQUAL (QVELT D 5) '|shiftHP|)
                (EXIT
                 (|GUESS;precCheck| |list| |resi| |options| |sigma|
                  |reject_one_term| $))))))
            (LETT |flist|
                  (PROGN
                   (LETT #8# NIL)
                   (SEQ (LETT |i| 1) (LETT #7# |o|) G190
                        (COND ((|greater_SI| |i| #7#) (GO G191)))
                        (SEQ
                         (EXIT
                          (COND
                           ((NULL
                             (SPADCALL (SPADCALL |resi| |i| (QREFELT $ 438))
                                       (QREFELT $ 439)))
                            (LETT #8#
                                  (CONS
                                   (PROG1 (LETT #6# |i|)
                                     (|check_subtype2| (> #6# 0)
                                                       '(|PositiveInteger|)
                                                       '(|NonNegativeInteger|)
                                                       #6#))
                                   #8#))))))
                        (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                        (EXIT (NREVERSE #8#)))))
            (LETT |testList|
                  (SPADCALL (|GUESS;list2UFPSSUPF| |list| $)
                            (SPADCALL |flist| (QVELT D 3))))
            (LETT |resiSUPF|
                  (PROGN
                   (LETT #5# NIL)
                   (SEQ (LETT |i| NIL) (LETT #4# |flist|) G190
                        (COND
                         ((OR (ATOM #4#) (PROGN (LETT |i| (CAR #4#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #5#
                                (CONS
                                 (|GUESS;SUPF2SUPSUPF|
                                  (|GUESS;SUPS2SUPF|
                                   (SPADCALL |resi| |i| (QREFELT $ 438)) $)
                                  $)
                                 #5#))))
                        (LETT #4# (CDR #4#)) (GO G190) G191
                        (EXIT (NREVERSE #5#)))))
            (LETT |order| 0) (LETT |dmax| (* 10 (LENGTH |list|)))
            (SEQ
             (EXIT
              (SEQ (LETT |d| 0) G190 NIL
                   (SEQ
                    (COND
                     ((NULL (SPADCALL |options| (QREFELT $ 421)))
                      (COND
                       ((EQL |d| |sigma|)
                        (PROGN (LETT #2# (CONS 0 "good")) (GO #13=#:G1962))))))
                    (COND
                     (|reject_one_term|
                      (COND
                       ((EQL |d| |sigma|)
                        (PROGN (LETT #2# (CONS 1 "reject")) (GO #13#))))))
                    (LETT |c|
                          (SPADCALL (QVELT D 8) |testList| |d|
                                    (SPADCALL |resiSUPF| (QREFELT $ 449))
                                    (QREFELT $ 450)))
                    (COND
                     ((NULL (SPADCALL |c| (QREFELT $ 451)))
                      (SEQ (LETT |order| |d|)
                           (EXIT
                            (PROGN (LETT #3# |$NoValue|) (GO #14=#:G1955))))))
                    (EXIT
                     (COND
                      ((> |d| |dmax|)
                       (SEQ
                        (SPADCALL
                         (SPADCALL "bailing out from checkInterpolant"
                                   (QREFELT $ 453))
                         (QREFELT $ 454))
                        (SPADCALL
                         (SPADCALL
                          (SPADCALL "please report the input to "
                                    "fricas-devel@googlegroups.com"
                                    (QREFELT $ 42))
                          (QREFELT $ 453))
                         (QREFELT $ 454))
                        (LETT |order| |d|)
                        (EXIT (PROGN (LETT #3# |$NoValue|) (GO #14#))))))))
                   (LETT |d| (|inc_SI| |d|)) (GO G190) G191 (EXIT NIL)))
             #14# (EXIT #3#))
            (EXIT
             (COND
              ((< |order| |sigma|)
               (SEQ
                (SPADCALL
                 (SPADCALL (SPADCALL "Order too low: " (QREFELT $ 453))
                           (SPADCALL |order| (QREFELT $ 455)) (QREFELT $ 456))
                 (QREFELT $ 454))
                (SPADCALL
                 (SPADCALL (SPADCALL "sigma: " (QREFELT $ 453))
                           (SPADCALL |sigma| (QREFELT $ 455)) (QREFELT $ 456))
                 (QREFELT $ 454))
                (EXIT (PROGN (LETT #2# (CONS 2 "no_solution")) (GO #13#)))))
              ((SPADCALL |c| (QREFELT $ 457))
               (SEQ
                (COND
                 ((SPADCALL |options| (QREFELT $ 361))
                  (SEQ
                   (SPADCALL
                    (SPADCALL
                     (SPADCALL "Proposed solution does not fit coefficient "
                               (QREFELT $ 453))
                     (SPADCALL |order| (QREFELT $ 455)) (QREFELT $ 456))
                    (QREFELT $ 454))
                   (EXIT
                    (SPADCALL
                     (SPADCALL (SPADCALL "sigma: " (QREFELT $ 453))
                               (SPADCALL |sigma| (QREFELT $ 455))
                               (QREFELT $ 456))
                     (QREFELT $ 454))))))
                (EXIT (PROGN (LETT #2# (CONS 1 "reject")) (GO #13#)))))
              (#12# (CONS 0 "good"))))))
          #13# (EXIT #2#)))) 

(SDEFUN |GUESS;wrapInterpolant|
        ((|resi| (|List| (|SparseUnivariatePolynomial| S)))
         (|exprList| (|List| EXPRR)) (|initials| (|List| F))
         (D
          (|Record| (|:| |degreeStream| (|Stream| (|NonNegativeInteger|)))
                    (|:| |guessStream|
                         (|Mapping|
                          (|Stream| (|UnivariateFormalPowerSeries| F))
                          (|UnivariateFormalPowerSeries| F)))
                    (|:| |guessModGen|
                         (|Mapping|
                          (|Mapping| (|Vector| (|U32Vector|))
                                     (|List| (|U32Vector|)) (|Integer|)
                                     (|Integer|))
                          (|NonNegativeInteger|)))
                    (|:| |testGen|
                         (|Mapping|
                          (|Mapping|
                           (|Vector|
                            (|UnivariateFormalPowerSeries|
                             (|SparseMultivariatePolynomial| F
                                                             (|NonNegativeInteger|))))
                           (|UnivariateFormalPowerSeries|
                            (|SparseMultivariatePolynomial| F
                                                            (|NonNegativeInteger|))))
                          (|List| (|PositiveInteger|))))
                    (|:| |exprStream|
                         (|Mapping| (|Stream| EXPRR) EXPRR (|Symbol|)))
                    (|:| |kind| (|Symbol|)) (|:| |qvar| (|Symbol|))
                    (|:| A
                         (|Mapping| S (|NonNegativeInteger|)
                                    (|NonNegativeInteger|)
                                    (|SparseUnivariatePolynomial| S)))
                    (|:| AF
                         (|Mapping|
                          (|SparseMultivariatePolynomial| F
                                                          (|NonNegativeInteger|))
                          (|NonNegativeInteger|) (|NonNegativeInteger|)
                          (|UnivariateFormalPowerSeries|
                           (|SparseMultivariatePolynomial| F
                                                           (|NonNegativeInteger|)))))
                    (|:| AX
                         (|Mapping| EXPRR (|NonNegativeInteger|) (|Symbol|)
                                    EXPRR))
                    (|:| C (|Mapping| (|List| S) (|NonNegativeInteger|)))))
         (|op| (|BasicOperator|)) (|options| (|List| (|GuessOption|)))
         ($ (EXPRR)))
        (SPROG
         ((|ex| (|List| EXPRR)) (#1=#:G2004 NIL) (|p| NIL) (#2=#:G2005 NIL)
          (|e| NIL) (#3=#:G2003 NIL) (|eq| (EXPRR)) (#4=#:G2001 NIL)
          (#5=#:G2002 NIL) (#6=#:G2000 NIL) (|dk| (|Symbol|)))
         (SEQ (LETT |dk| (SPADCALL |options| (QREFELT $ 199)))
              (COND
               ((OR (EQUAL |dk| '|displayAsGF|) (EQUAL |dk| '|displayAsEQ|))
                (EXIT
                 (SEQ
                  (LETT |ex|
                        (PROGN
                         (LETT #6# NIL)
                         (SEQ (LETT |e| NIL) (LETT #5# |exprList|)
                              (LETT |p| NIL) (LETT #4# |resi|) G190
                              (COND
                               ((OR (ATOM #4#) (PROGN (LETT |p| (CAR #4#)) NIL)
                                    (ATOM #5#)
                                    (PROGN (LETT |e| (CAR #5#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #6#
                                      (CONS
                                       (|GUESS;makeEXPRR| (QVELT D 9)
                                        (SPADCALL |options| (QREFELT $ 458))
                                        (|GUESS;SUPS2SUPF| |p| $) |e| $)
                                       #6#))))
                              (LETT #4# (PROG1 (CDR #4#) (LETT #5# (CDR #5#))))
                              (GO G190) G191 (EXIT (NREVERSE #6#)))))
                  (LETT |eq|
                        (SPADCALL (SPADCALL (ELT $ 93) |ex| (QREFELT $ 106))
                                  (QREFELT $ 459)))
                  (EXIT
                   (COND ((EQUAL |dk| '|displayAsEQ|) |eq|)
                         (#7='T
                          (SPADCALL |op| (SPADCALL |options| (QREFELT $ 458))
                                    (SPADCALL |options| (QREFELT $ 460)) |eq|
                                    (|GUESS;getVariables| |initials| $)
                                    (SPADCALL (QREFELT $ 10)
                                              (SPADCALL |initials|
                                                        (QREFELT $ 329))
                                              (QREFELT $ 463))
                                    (QREFELT $ 466)))))))))
              (EXIT
               (COND
                ((EQUAL |dk| '|displayAsRec|)
                 (SEQ
                  (LETT |ex|
                        (PROGN
                         (LETT #3# NIL)
                         (SEQ (LETT |e| NIL) (LETT #2# |exprList|)
                              (LETT |p| NIL) (LETT #1# |resi|) G190
                              (COND
                               ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL)
                                    (ATOM #2#)
                                    (PROGN (LETT |e| (CAR #2#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #3#
                                      (CONS
                                       (|GUESS;makeEXPRR| (QVELT D 9)
                                        (SPADCALL |options| (QREFELT $ 460))
                                        (|GUESS;SUPS2SUPF| |p| $) |e| $)
                                       #3#))))
                              (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                              (GO G190) G191 (EXIT (NREVERSE #3#)))))
                  (EXIT
                   (SPADCALL |op| (SPADCALL |options| (QREFELT $ 460))
                             (SPADCALL
                              (SPADCALL (ELT $ 93) |ex| (QREFELT $ 106))
                              (QREFELT $ 459))
                             (|GUESS;getVariables| |initials| $)
                             (SPADCALL (QREFELT $ 10)
                                       (SPADCALL |initials| (QREFELT $ 329))
                                       (QREFELT $ 463))
                             (QREFELT $ 467)))))
                (#7# (|error| "wrapInterpolant: unsupported display kind"))))))) 

(SDEFUN |GUESS;guessHPaux|
        ((|lists| (|List| (|List| F)))
         (D
          (|Record| (|:| |degreeStream| #1=(|Stream| (|NonNegativeInteger|)))
                    (|:| |guessStream|
                         (|Mapping|
                          (|Stream| (|UnivariateFormalPowerSeries| F))
                          (|UnivariateFormalPowerSeries| F)))
                    (|:| |guessModGen|
                         (|Mapping|
                          (|Mapping| (|Vector| (|U32Vector|))
                                     (|List| (|U32Vector|)) (|Integer|)
                                     (|Integer|))
                          (|NonNegativeInteger|)))
                    (|:| |testGen|
                         (|Mapping|
                          (|Mapping|
                           (|Vector|
                            (|UnivariateFormalPowerSeries|
                             (|SparseMultivariatePolynomial| F
                                                             (|NonNegativeInteger|))))
                           (|UnivariateFormalPowerSeries|
                            (|SparseMultivariatePolynomial| F
                                                            (|NonNegativeInteger|))))
                          (|List| (|PositiveInteger|))))
                    (|:| |exprStream|
                         (|Mapping| #2=(|Stream| EXPRR) EXPRR (|Symbol|)))
                    (|:| |kind| (|Symbol|)) (|:| |qvar| (|Symbol|))
                    (|:| A
                         (|Mapping| S (|NonNegativeInteger|)
                                    (|NonNegativeInteger|)
                                    (|SparseUnivariatePolynomial| S)))
                    (|:| AF
                         (|Mapping|
                          (|SparseMultivariatePolynomial| F
                                                          (|NonNegativeInteger|))
                          (|NonNegativeInteger|) (|NonNegativeInteger|)
                          (|UnivariateFormalPowerSeries|
                           (|SparseMultivariatePolynomial| F
                                                           (|NonNegativeInteger|)))))
                    (|:| AX
                         (|Mapping| EXPRR (|NonNegativeInteger|) (|Symbol|)
                                    EXPRR))
                    (|:| C (|Mapping| (|List| S) (|NonNegativeInteger|)))))
         (|options| (|List| (|GuessOption|))) ($ (|List| EXPRR)))
        (SPROG
         ((#3=#:G2085 NIL) (|reslist| (|List| EXPRR)) (|res| (EXPRR))
          (#4=#:G2087 NIL) (|i| NIL) (|exprList| (|List| EXPRR))
          (MS (|Stream| (|Matrix| (|SparseUnivariatePolynomial| S))))
          (M (|Matrix| (|SparseUnivariatePolynomial| S))) (#5=#:G2083 NIL)
          (#6=#:G2063 NIL) (#7=#:G2086 NIL) (#8=#:G2080 NIL) (#9=#:G2020 NIL)
          (|maxD| (|Union| (|NonNegativeInteger|) "arbitrary"))
          (|guessDegree| #10=(|Integer|)) (|degreeLoss| (|Integer|))
          (#11=#:G2084 NIL) (#12=#:G2011 NIL) (|o| NIL) (|exprS| #2#)
          (#13=#:G2079 NIL) (|dk| (|Symbol|)) (|degreeS| #1#)
          (|op| (|BasicOperator|)) (|listDegree| #10#) (|list| (|List| F)))
         (SEQ
          (EXIT
           (SEQ (LETT |reslist| NIL) (LETT |list| (|SPADfirst| |lists|))
                (LETT |listDegree|
                      (- (- (LENGTH |list|) 1)
                         (SPADCALL |options| (QREFELT $ 468))))
                (COND
                 ((< |listDegree| 0)
                  (PROGN (LETT #3# |reslist|) (GO #14=#:G2078))))
                (LETT |op|
                      (SPADCALL (SPADCALL |options| (QREFELT $ 469))
                                (QREFELT $ 470)))
                (LETT |degreeS| (QVELT D 0))
                (LETT |dk| (SPADCALL |options| (QREFELT $ 199)))
                (LETT |exprS|
                      (SEQ
                       (EXIT
                        (COND
                         ((OR (EQUAL |dk| '|displayAsGF|)
                              (EQUAL |dk| '|displayAsEQ|))
                          (SPADCALL
                           (SPADCALL |op|
                                     (SPADCALL
                                      (SPADCALL |options| (QREFELT $ 458))
                                      (QREFELT $ 45))
                                     (QREFELT $ 471))
                           (SPADCALL |options| (QREFELT $ 458)) (QVELT D 4)))
                         ((EQUAL |dk| '|displayAsRec|)
                          (PROGN
                           (LETT #13#
                                 (SPADCALL
                                  (SPADCALL |op|
                                            (SPADCALL
                                             (SPADCALL |options|
                                                       (QREFELT $ 460))
                                             (QREFELT $ 45))
                                            (QREFELT $ 471))
                                  (SPADCALL |options| (QREFELT $ 460))
                                  (QVELT D 4)))
                           (GO #15=#:G2009)))))
                       #15# (EXIT #13#)))
                (SEQ
                 (EXIT
                  (SEQ (LETT |o| 2) G190 NIL
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL
                            (SPADCALL |degreeS|
                                      (PROG1 (LETT #12# (- |o| 1))
                                        (|check_subtype2| (>= #12# 0)
                                                          '(|NonNegativeInteger|)
                                                          '(|Integer|) #12#))
                                      (QREFELT $ 472))
                            (QREFELT $ 473))
                           (PROGN (LETT #11# 1) (GO #16=#:G2076)))
                          ('T
                           (SEQ
                            (LETT |degreeLoss|
                                  (SPADCALL |degreeS| |o| (QREFELT $ 265)))
                            (LETT |guessDegree|
                                  (- (- (+ |listDegree| 2) |degreeLoss|) |o|))
                            (COND
                             ((< |guessDegree| 0)
                              (SEQ
                               (COND
                                ((SPADCALL |options| (QREFELT $ 361))
                                 (SPADCALL
                                  "Guess: not enough values for guessing"
                                  (QREFELT $ 363))))
                               (EXIT (PROGN (LETT #3# |reslist|) (GO #14#))))))
                            (COND
                             ((SPADCALL |options| (QREFELT $ 361))
                              (SPADCALL
                               (SPADCALL
                                (LIST
                                 (SPADCALL "Guess: trying order "
                                           (QREFELT $ 453))
                                 (SPADCALL |o| (QREFELT $ 474))
                                 (SPADCALL ", guessDegree is " (QREFELT $ 453))
                                 (SPADCALL |guessDegree| (QREFELT $ 455)))
                                (QREFELT $ 475))
                               (QREFELT $ 476))))
                            (LETT |maxD| (SPADCALL |options| (QREFELT $ 354)))
                            (EXIT
                             (COND
                              ((QEQCAR |maxD| 0)
                               (COND
                                ((OR
                                  (OR
                                   (SPADCALL
                                    (SPADCALL |degreeS| |o| (QREFELT $ 472))
                                    (QREFELT $ 473))
                                   (NULL
                                    (< (* (QCDR |maxD|) |o|) |guessDegree|)))
                                  (NULL
                                   (<= (* (QCDR |maxD|) (+ |o| 1))
                                       (-
                                        (- (+ |listDegree| 2)
                                           (SPADCALL |degreeS| (+ |o| 1)
                                                     (QREFELT $ 265)))
                                        (+ |o| 1)))))
                                 (SEQ (LETT |exprList| NIL)
                                      (COND
                                       ((SPADCALL |options| (QREFELT $ 361))
                                        (SEQ
                                         (LETT |exprList|
                                               (SPADCALL
                                                (SPADCALL
                                                 (SPADCALL |exprS| |o|
                                                           (QREFELT $ 477))
                                                 (QREFELT $ 478))
                                                (QREFELT $ 479)))
                                         (SPADCALL
                                          #17="Guess: The list of expressions is"
                                          (QREFELT $ 363))
                                         (EXIT
                                          (SPADCALL
                                           (SPADCALL |exprList|
                                                     (QREFELT $ 480))
                                           (QREFELT $ 476))))))
                                      (LETT MS
                                            (|GUESS;guessInterpolate2| |lists|
                                             |o| |degreeLoss|
                                             (PROG1 (LETT #9# |guessDegree|)
                                               (|check_subtype2| (>= #9# 0)
                                                                 '(|NonNegativeInteger|)
                                                                 '(|Integer|)
                                                                 #9#))
                                             D |options| $))
                                      (EXIT
                                       (SEQ
                                        (EXIT
                                         (SEQ G190 NIL
                                              (SEQ
                                               (EXIT
                                                (COND
                                                 ((SPADCALL MS (QREFELT $ 481))
                                                  (PROGN
                                                   (LETT #8# 1)
                                                   (GO #18=#:G2029)))
                                                 ('T
                                                  (SEQ
                                                   (LETT M
                                                         (SPADCALL MS
                                                                   (QREFELT $
                                                                            482)))
                                                   (LETT MS
                                                         (SPADCALL MS
                                                                   (QREFELT $
                                                                            483)))
                                                   (COND
                                                    ((NULL |exprList|)
                                                     (LETT |exprList|
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL |exprS|
                                                                       |o|
                                                                       (QREFELT
                                                                        $ 477))
                                                             (QREFELT $ 478))
                                                            (QREFELT $ 479)))))
                                                   (SEQ (LETT |i| 1)
                                                        (LETT #7# (ANCOLS M))
                                                        G190
                                                        (COND
                                                         ((|greater_SI| |i|
                                                                        #7#)
                                                          (GO G191)))
                                                        (SEQ
                                                         (LETT |res|
                                                               (|GUESS;wrapInterpolant|
                                                                (SPADCALL
                                                                 (SPADCALL M
                                                                           |i|
                                                                           (QREFELT
                                                                            $
                                                                            387))
                                                                 (QREFELT $
                                                                          388))
                                                                |exprList|
                                                                |list| D |op|
                                                                |options| $))
                                                         (EXIT
                                                          (COND
                                                           ((NULL
                                                             (SPADCALL |res|
                                                                       |reslist|
                                                                       (QREFELT
                                                                        $
                                                                        484)))
                                                            (LETT |reslist|
                                                                  (CONS |res|
                                                                        |reslist|))))))
                                                        (LETT |i|
                                                              (|inc_SI| |i|))
                                                        (GO G190) G191
                                                        (EXIT NIL))
                                                   (EXIT
                                                    (COND
                                                     ((NULL (NULL |reslist|))
                                                      (COND
                                                       ((SPADCALL |options|
                                                                  (QREFELT $
                                                                           485))
                                                        (PROGN
                                                         (LETT #3# |reslist|)
                                                         (GO #14#))))))))))))
                                              NIL (GO G190) G191 (EXIT NIL)))
                                        #18# (EXIT #8#)))))
                                ((SPADCALL |options| (QREFELT $ 361))
                                 (SPADCALL "Guess: iterating"
                                           (QREFELT $ 363)))))
                              ('T
                               (SEQ (LETT |exprList| NIL)
                                    (COND
                                     ((SPADCALL |options| (QREFELT $ 361))
                                      (SEQ
                                       (LETT |exprList|
                                             (SPADCALL
                                              (SPADCALL
                                               (SPADCALL |exprS| |o|
                                                         (QREFELT $ 477))
                                               (QREFELT $ 478))
                                              (QREFELT $ 479)))
                                       (SPADCALL #17# (QREFELT $ 363))
                                       (EXIT
                                        (SPADCALL
                                         (SPADCALL |exprList| (QREFELT $ 480))
                                         (QREFELT $ 476))))))
                                    (LETT MS
                                          (|GUESS;guessInterpolate2| |lists|
                                           |o| |degreeLoss|
                                           (PROG1 (LETT #6# |guessDegree|)
                                             (|check_subtype2| (>= #6# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #6#))
                                           D |options| $))
                                    (EXIT
                                     (SEQ
                                      (EXIT
                                       (SEQ G190 NIL
                                            (SEQ
                                             (EXIT
                                              (COND
                                               ((SPADCALL MS (QREFELT $ 481))
                                                (PROGN
                                                 (LETT #5# 1)
                                                 (GO #19=#:G2072)))
                                               ('T
                                                (SEQ
                                                 (LETT M
                                                       (SPADCALL MS
                                                                 (QREFELT $
                                                                          482)))
                                                 (LETT MS
                                                       (SPADCALL MS
                                                                 (QREFELT $
                                                                          483)))
                                                 (COND
                                                  ((NULL |exprList|)
                                                   (LETT |exprList|
                                                         (SPADCALL
                                                          (SPADCALL
                                                           (SPADCALL |exprS|
                                                                     |o|
                                                                     (QREFELT $
                                                                              477))
                                                           (QREFELT $ 478))
                                                          (QREFELT $ 479)))))
                                                 (SEQ (LETT |i| 1)
                                                      (LETT #4# (ANCOLS M))
                                                      G190
                                                      (COND
                                                       ((|greater_SI| |i| #4#)
                                                        (GO G191)))
                                                      (SEQ
                                                       (LETT |res|
                                                             (|GUESS;wrapInterpolant|
                                                              (SPADCALL
                                                               (SPADCALL M |i|
                                                                         (QREFELT
                                                                          $
                                                                          387))
                                                               (QREFELT $ 388))
                                                              |exprList| |list|
                                                              D |op| |options|
                                                              $))
                                                       (EXIT
                                                        (COND
                                                         ((NULL
                                                           (SPADCALL |res|
                                                                     |reslist|
                                                                     (QREFELT $
                                                                              484)))
                                                          (LETT |reslist|
                                                                (CONS |res|
                                                                      |reslist|))))))
                                                      (LETT |i| (|inc_SI| |i|))
                                                      (GO G190) G191
                                                      (EXIT NIL))
                                                 (EXIT
                                                  (COND
                                                   ((NULL (NULL |reslist|))
                                                    (COND
                                                     ((SPADCALL |options|
                                                                (QREFELT $
                                                                         485))
                                                      (PROGN
                                                       (LETT #3# |reslist|)
                                                       (GO #14#))))))))))))
                                            NIL (GO G190) G191 (EXIT NIL)))
                                      #19# (EXIT #5#))))))))))))
                       (LETT |o| (|inc_SI| |o|)) (GO G190) G191 (EXIT NIL)))
                 #16# (EXIT #11#))
                (EXIT |reslist|)))
          #14# (EXIT #3#)))) 

(SDEFUN |GUESS;processOptions|
        ((|options| (|List| (|GuessOption|)))
         ($ (|List| (|List| (|GuessOption|)))))
        (SPROG
         ((#1=#:G2139 NIL) (#2=#:G2133 NIL) (#3=#:G2131 NIL) (#4=#:G2143 NIL)
          (#5=#:G2095 NIL) (|i| NIL) (#6=#:G2142 NIL)
          (|minP| (|PositiveInteger|))
          (|hom?| (|Union| (|PositiveInteger|) (|Boolean|))) (#7=#:G2105 NIL)
          (#8=#:G2141 NIL) (#9=#:G2140 NIL) (|maxSomos| (|PositiveInteger|))
          (#10=#:G2089 NIL) (#11=#:G2100 NIL) (#12=#:G2098 NIL)
          (|maxD| (|NonNegativeInteger|)) (#13=#:G2092 NIL)
          (|Som?| (|Union| (|PositiveInteger|) (|Boolean|))))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |Som?| (SPADCALL |options| (QREFELT $ 62)))
                 (EXIT
                  (COND
                   ((QEQCAR |Som?| 1)
                    (COND
                     ((QCDR |Som?|)
                      (SEQ
                       (LETT |maxD|
                             (PROG2
                                 (LETT #13#
                                       (SPADCALL |options| (QREFELT $ 61)))
                                 (QCDR #13#)
                               (|check_union2| (QEQCAR #13# 0)
                                               (|NonNegativeInteger|)
                                               (|Union| (|NonNegativeInteger|)
                                                        "arbitrary")
                                               #13#)))
                       (COND
                        ((QEQCAR (SPADCALL |options| (QREFELT $ 57)) 0)
                         (LETT |maxSomos|
                               (*
                                (PROG1 (LETT #12# |maxD|)
                                  (|check_subtype2| (> #12# 0)
                                                    '(|PositiveInteger|)
                                                    '(|NonNegativeInteger|)
                                                    #12#))
                                (PROG2
                                    (LETT #5#
                                          (SPADCALL |options| (QREFELT $ 57)))
                                    (QCDR #5#)
                                  (|check_union2| (QEQCAR #5# 0)
                                                  (|PositiveInteger|)
                                                  (|Union| (|PositiveInteger|)
                                                           #14="arbitrary")
                                                  #5#)))))
                        ((QEQCAR (SPADCALL |options| (QREFELT $ 59)) 0)
                         (LETT |maxSomos|
                               (*
                                (PROG1 (LETT #11# |maxD|)
                                  (|check_subtype2| (> #11# 0)
                                                    '(|PositiveInteger|)
                                                    '(|NonNegativeInteger|)
                                                    #11#))
                                (PROG2
                                    (LETT #10#
                                          (SPADCALL |options| (QREFELT $ 59)))
                                    (QCDR #10#)
                                  (|check_union2| (QEQCAR #10# 0)
                                                  (|PositiveInteger|)
                                                  (|Union| (|PositiveInteger|)
                                                           (|Boolean|))
                                                  #10#)))))
                        (#15='T
                         (|error|
                          "Guess: internal error - inconsistent options")))
                       (EXIT
                        (PROGN
                         (LETT #1#
                               (SPADCALL
                                (PROGN
                                 (LETT #9# NIL)
                                 (SEQ (LETT |i| 2) (LETT #8# |maxSomos|) G190
                                      (COND ((|greater_SI| |i| #8#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #9#
                                              (CONS
                                               (|GUESS;processOptions|
                                                (CONS
                                                 (SPADCALL
                                                  (CONS 0
                                                        (PROG1 (LETT #7# |i|)
                                                          (|check_subtype2|
                                                           (> #7# 0)
                                                           '(|PositiveInteger|)
                                                           '(|NonNegativeInteger|)
                                                           #7#)))
                                                  (QREFELT $ 487))
                                                 |options|)
                                                $)
                                               #9#))))
                                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                      (EXIT (NREVERSE #9#))))
                                (QREFELT $ 489)))
                         (GO #16=#:G2138))))))))))
            (SEQ (LETT |hom?| (SPADCALL |options| (QREFELT $ 59)))
                 (EXIT
                  (COND
                   ((QEQCAR |hom?| 1)
                    (COND
                     ((QCDR |hom?|)
                      (SEQ
                       (COND
                        ((QEQCAR (SPADCALL |options| (QREFELT $ 62)) 0)
                         (LETT |minP| 2))
                        (#15# (LETT |minP| 1)))
                       (EXIT
                        (PROGN
                         (LETT #1#
                               (PROGN
                                (LETT #6# NIL)
                                (SEQ (LETT |i| |minP|)
                                     (LETT #4#
                                           (PROG2
                                               (LETT #5#
                                                     (SPADCALL |options|
                                                               (QREFELT $ 57)))
                                               (QCDR #5#)
                                             (|check_union2| (QEQCAR #5# 0)
                                                             (|PositiveInteger|)
                                                             (|Union|
                                                              (|PositiveInteger|)
                                                              #14#)
                                                             #5#)))
                                     G190 (COND ((> |i| #4#) (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (LETT #6#
                                             (CONS
                                              (SPADCALL
                                               (LIST
                                                (SPADCALL
                                                 (CONS 0
                                                       (PROG1 (LETT #3# |i|)
                                                         (|check_subtype2|
                                                          (> #3# 0)
                                                          '(|PositiveInteger|)
                                                          '(|NonNegativeInteger|)
                                                          #3#)))
                                                 (QREFELT $ 490))
                                                (SPADCALL
                                                 (CONS 0
                                                       (PROG1 (LETT #2# |i|)
                                                         (|check_subtype2|
                                                          (> #2# 0)
                                                          '(|PositiveInteger|)
                                                          '(|NonNegativeInteger|)
                                                          #2#)))
                                                 (QREFELT $ 491)))
                                               |options| (QREFELT $ 492))
                                              #6#))))
                                     (LETT |i| (+ |i| 1)) (GO G190) G191
                                     (EXIT (NREVERSE #6#)))))
                         (GO #16#))))))))))
            (EXIT (LIST |options|))))
          #16# (EXIT #1#)))) 

(SDEFUN |GUESS;guessAlgDep;LLL;98|
        ((|lists| (|List| (|List| F))) (|options| (|List| (|GuessOption|)))
         ($ (|List| EXPRR)))
        (SPROG
         ((|lres| (|List| EXPRR)) (#1=#:G2161 NIL) (|res| (|List| EXPRR))
          (#2=#:G2163 NIL) (|opts| NIL)
          (|lopts| (|List| (|List| (|GuessOption|)))) (#3=#:G2150 NIL)
          (#4=#:G2160 NIL) (#5=#:G2162 NIL) (|li| NIL)
          (|nn| (|NonNegativeInteger|)) (|rl| (|List| (|List| F)))
          (|l| (|List| F)))
         (SEQ
          (EXIT
           (SEQ (SPADCALL |options| (QREFELT $ 493))
                (EXIT
                 (COND
                  ((NULL |lists|)
                   (|error| "guessAlgDep: need at least one list"))
                  ('T
                   (SEQ (LETT |l| (|SPADfirst| |lists|))
                        (LETT |rl| (CDR |lists|)) (LETT |nn| (LENGTH |l|))
                        (SEQ
                         (EXIT
                          (SEQ (LETT |li| NIL) (LETT #5# |rl|) G190
                               (COND
                                ((OR (ATOM #5#)
                                     (PROGN (LETT |li| (CAR #5#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((SPADCALL (LENGTH |li|) |nn|
                                             (QREFELT $ 147))
                                   (PROGN
                                    (LETT #4#
                                          (|error|
                                           "guessAlgDep: lists must have equal length"))
                                    (GO #6=#:G2146))))))
                               (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL)))
                         #6# (EXIT #4#))
                        (LETT |lopts|
                              (|GUESS;processOptions|
                               (SPADCALL
                                (LIST (SPADCALL '|displayAsEQ| (QREFELT $ 494))
                                      (SPADCALL
                                       (CONS 0
                                             (PROG1 (LETT #3# (LENGTH |lists|))
                                               (|check_subtype2| (> #3# 0)
                                                                 '(|PositiveInteger|)
                                                                 '(|NonNegativeInteger|)
                                                                 #3#)))
                                       (QREFELT $ 495)))
                                |options| (QREFELT $ 496))
                               $))
                        (LETT |lres| NIL) (LETT |res| NIL)
                        (SEQ (LETT |opts| NIL) (LETT #2# |lopts|) G190
                             (COND
                              ((OR (ATOM #2#)
                                   (PROGN (LETT |opts| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ
                              (LETT |res|
                                    (|GUESS;guessHPaux| |lists|
                                     (SPADCALL |lists| |opts| (QREFELT $ 227))
                                     |opts| $))
                              (COND
                               ((NULL (NULL |res|))
                                (COND
                                 ((SPADCALL |options| (QREFELT $ 485))
                                  (PROGN (LETT #1# |res|) (GO #7=#:G2159))))))
                              (EXIT
                               (LETT |lres|
                                     (SPADCALL |res| |lres| (QREFELT $ 497)))))
                             (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                        (EXIT (NREVERSE |lres|))))))))
          #7# (EXIT #1#)))) 

(SDEFUN |GUESS;guessAlgDep;LL;99|
        ((|lists| (|List| (|List| F))) ($ (|List| EXPRR)))
        (SPADCALL |lists| NIL (QREFELT $ 498))) 

(SDEFUN |GUESS;guessADE;LLL;100|
        ((|list| (|List| F)) (|options| (|List| (|GuessOption|)))
         ($ (|List| EXPRR)))
        (SPROG
         ((|lres| (|List| EXPRR)) (#1=#:G2173 NIL) (|res| (|List| EXPRR))
          (#2=#:G2174 NIL) (|opts| NIL)
          (|lopts| (|List| (|List| (|GuessOption|)))))
         (SEQ
          (EXIT
           (SEQ (SPADCALL |options| (QREFELT $ 493))
                (LETT |lopts|
                      (|GUESS;processOptions|
                       (CONS (SPADCALL '|displayAsGF| (QREFELT $ 494))
                             |options|)
                       $))
                (LETT |lres| NIL) (LETT |res| NIL)
                (SEQ (LETT |opts| NIL) (LETT #2# |lopts|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |opts| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (LETT |res|
                            (|GUESS;guessHPaux| (LIST |list|)
                             (SPADCALL |opts| (QREFELT $ 217)) |opts| $))
                      (COND
                       ((NULL (NULL |res|))
                        (COND
                         ((SPADCALL |options| (QREFELT $ 485))
                          (PROGN (LETT #1# |res|) (GO #3=#:G2172))))))
                      (EXIT
                       (LETT |lres| (SPADCALL |res| |lres| (QREFELT $ 497)))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT (NREVERSE |lres|))))
          #3# (EXIT #1#)))) 

(SDEFUN |GUESS;guessADE;LL;101| ((|list| (|List| F)) ($ (|List| EXPRR)))
        (SPADCALL |list| NIL (QREFELT $ 500))) 

(SDEFUN |GUESS;guessAlg;LLL;102|
        ((|list| (|List| F)) (|options| (|List| (|GuessOption|)))
         ($ (|List| EXPRR)))
        (SPADCALL |list| (CONS (SPADCALL (CONS 0 0) (QREFELT $ 502)) |options|)
                  (QREFELT $ 500))) 

(SDEFUN |GUESS;guessAlg;LL;103| ((|list| (|List| F)) ($ (|List| EXPRR)))
        (SPADCALL |list| NIL (QREFELT $ 503))) 

(SDEFUN |GUESS;guessHolo;LLL;104|
        ((|list| (|List| F)) (|options| (|List| (|GuessOption|)))
         ($ (|List| EXPRR)))
        (SPADCALL |list| (CONS (SPADCALL (CONS 0 1) (QREFELT $ 491)) |options|)
                  (QREFELT $ 500))) 

(SDEFUN |GUESS;guessHolo;LL;105| ((|list| (|List| F)) ($ (|List| EXPRR)))
        (SPADCALL |list| NIL (QREFELT $ 505))) 

(SDEFUN |GUESS;guessPade;LLL;106|
        ((|list| (|List| F)) (|options| (|List| (|GuessOption|)))
         ($ (|List| EXPRR)))
        (SPROG ((|opts| (|List| (|GuessOption|))))
               (SEQ
                (LETT |opts|
                      (SPADCALL
                       (LIST
                        (LIST (SPADCALL (CONS 0 0) (QREFELT $ 502))
                              (SPADCALL (CONS 0 1) (QREFELT $ 491)))
                        |options| (LIST (SPADCALL 'T (QREFELT $ 507))))
                       (QREFELT $ 508)))
                (EXIT (SPADCALL |list| |opts| (QREFELT $ 500)))))) 

(SDEFUN |GUESS;guessPade;LL;107| ((|list| (|List| F)) ($ (|List| EXPRR)))
        (SPADCALL |list| NIL (QREFELT $ 509))) 

(SDEFUN |GUESS;guessFE;LLL;108|
        ((|list| (|List| F)) (|options| (|List| (|GuessOption|)))
         ($ (|List| EXPRR)))
        (SPROG
         ((|lres| (|List| EXPRR)) (#1=#:G2203 NIL) (|res| (|List| EXPRR))
          (#2=#:G2204 NIL) (|opts| NIL)
          (|lopts| (|List| (|List| (|GuessOption|)))))
         (SEQ
          (EXIT
           (SEQ (SPADCALL |options| (QREFELT $ 493))
                (LETT |lopts|
                      (|GUESS;processOptions|
                       (CONS (SPADCALL '|displayAsGF| (QREFELT $ 494))
                             |options|)
                       $))
                (LETT |lres| NIL) (LETT |res| NIL)
                (SEQ (LETT |opts| NIL) (LETT #2# |lopts|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |opts| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (LETT |res|
                            (|GUESS;guessHPaux| (LIST |list|)
                             (SPADCALL |opts| (QREFELT $ 231)) |opts| $))
                      (COND
                       ((NULL (NULL |res|))
                        (COND
                         ((SPADCALL |options| (QREFELT $ 485))
                          (PROGN (LETT #1# |res|) (GO #3=#:G2202))))))
                      (EXIT
                       (LETT |lres| (SPADCALL |res| |lres| (QREFELT $ 497)))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT (NREVERSE |lres|))))
          #3# (EXIT #1#)))) 

(SDEFUN |GUESS;guessFE;LL;109| ((|list| (|List| F)) ($ (|List| EXPRR)))
        (SPADCALL |list| NIL (QREFELT $ 511))) 

(SDEFUN |GUESS;guessADE;SM;110|
        ((|q| (|Symbol|))
         ($ (|Mapping| (|List| EXPRR) (|List| F) (|List| (|GuessOption|)))))
        (SPROG NIL (SEQ (CONS #'|GUESS;guessADE;SM;110!0| (VECTOR |q| $))))) 

(SDEFUN |GUESS;guessADE;SM;110!0| ((|list| NIL) (|options| NIL) ($$ NIL))
        (PROG ($ |q|)
          (LETT $ (QREFELT $$ 1))
          (LETT |q| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|lres| NIL) (#1=#:G2214 NIL) (|res| NIL) (#2=#:G2215 NIL)
              (|opts| NIL) (|lopts| NIL))
             (SEQ
              (EXIT
               (SEQ (SPADCALL |options| (QREFELT $ 493))
                    (LETT |lopts|
                          (|GUESS;processOptions|
                           (SPADCALL (SPADCALL '|displayAsGF| (QREFELT $ 494))
                                     |options| (QREFELT $ 513))
                           $))
                    (LETT |lres| NIL) (LETT |res| NIL)
                    (SEQ (LETT |opts| NIL) (LETT #2# |lopts|) G190
                         (COND
                          ((OR (ATOM #2#) (PROGN (LETT |opts| (CAR #2#)) NIL))
                           (GO G191)))
                         (SEQ
                          (LETT |res|
                                (|GUESS;guessHPaux| (LIST |list|)
                                 (SPADCALL |opts|
                                           (SPADCALL |q| (QREFELT $ 242)))
                                 |opts| $))
                          (COND
                           ((NULL (SPADCALL |res| (QREFELT $ 514)))
                            (COND
                             ((SPADCALL |options| (QREFELT $ 485))
                              (PROGN (LETT #1# |res|) (GO #3=#:G2213))))))
                          (EXIT
                           (LETT |lres|
                                 (SPADCALL |res| |lres| (QREFELT $ 497)))))
                         (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                    (EXIT (SPADCALL |lres| (QREFELT $ 515)))))
              #3# (EXIT #1#))))))) 

(SDEFUN |GUESS;guessHolo;SM;111|
        ((|q| (|Symbol|))
         ($ (|Mapping| (|List| EXPRR) (|List| F) (|List| (|GuessOption|)))))
        (SPROG NIL (CONS #'|GUESS;guessHolo;SM;111!0| (VECTOR |q| $)))) 

(SDEFUN |GUESS;guessHolo;SM;111!0| ((|z1| NIL) (|z2| NIL) ($$ NIL))
        (PROG ($ |q|)
          (LETT $ (QREFELT $$ 1))
          (LETT |q| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |z1|
                      (SPADCALL
                       (SPADCALL (CONS 0 (|spadConstant| $ 74))
                                 (QREFELT $ 491))
                       |z2| (QREFELT $ 513))
                      (SPADCALL |q| (QREFELT $ 516))))))) 

(SDEFUN |GUESS;guessRec;LLL;112|
        ((|list| (|List| F)) (|options| (|List| (|GuessOption|)))
         ($ (|List| EXPRR)))
        (SPROG
         ((|lres| (|List| EXPRR)) (#1=#:G2230 NIL) (|res| (|List| EXPRR))
          (#2=#:G2231 NIL) (|opts| NIL)
          (|lopts| (|List| (|List| (|GuessOption|)))))
         (SEQ
          (EXIT
           (SEQ (SPADCALL |options| (QREFELT $ 493))
                (LETT |lopts|
                      (|GUESS;processOptions|
                       (CONS (SPADCALL '|displayAsRec| (QREFELT $ 494))
                             |options|)
                       $))
                (LETT |lres| NIL) (LETT |res| NIL)
                (SEQ (LETT |opts| NIL) (LETT #2# |lopts|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |opts| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (LETT |res|
                            (|GUESS;guessHPaux| (LIST |list|)
                             (SPADCALL |opts| (QREFELT $ 274)) |opts| $))
                      (COND
                       ((NULL (NULL |res|))
                        (COND
                         ((SPADCALL |options| (QREFELT $ 485))
                          (PROGN (LETT #1# |res|) (GO #3=#:G2229))))))
                      (EXIT
                       (LETT |lres| (SPADCALL |res| |lres| (QREFELT $ 497)))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT (NREVERSE |lres|))))
          #3# (EXIT #1#)))) 

(SDEFUN |GUESS;guessRec;LL;113| ((|list| (|List| F)) ($ (|List| EXPRR)))
        (SPADCALL |list| NIL (QREFELT $ 518))) 

(SDEFUN |GUESS;guessPRec;LLL;114|
        ((|list| (|List| F)) (|options| (|List| (|GuessOption|)))
         ($ (|List| EXPRR)))
        (SPADCALL |list| (CONS (SPADCALL (CONS 0 1) (QREFELT $ 491)) |options|)
                  (QREFELT $ 518))) 

(SDEFUN |GUESS;guessPRec;LL;115| ((|list| (|List| F)) ($ (|List| EXPRR)))
        (SPADCALL |list| NIL (QREFELT $ 520))) 

(SDEFUN |GUESS;guessRat;LLL;116|
        ((|list| (|List| F)) (|options| (|List| (|GuessOption|)))
         ($ (|List| EXPRR)))
        (SPROG ((|opts| (|List| (|GuessOption|))))
               (SEQ
                (LETT |opts|
                      (SPADCALL
                       (LIST
                        (LIST (SPADCALL (CONS 0 0) (QREFELT $ 522))
                              (SPADCALL (CONS 0 1) (QREFELT $ 491)))
                        |options| (LIST (SPADCALL 'T (QREFELT $ 507))))
                       (QREFELT $ 508)))
                (EXIT (SPADCALL |list| |opts| (QREFELT $ 518)))))) 

(SDEFUN |GUESS;guessRat;LL;117| ((|list| (|List| F)) ($ (|List| EXPRR)))
        (SPADCALL |list| NIL (QREFELT $ 523))) 

(SDEFUN |GUESS;guessRec;SM;118|
        ((|q| (|Symbol|))
         ($ (|Mapping| (|List| EXPRR) (|List| F) (|List| (|GuessOption|)))))
        (SPROG NIL (SEQ (CONS #'|GUESS;guessRec;SM;118!0| (VECTOR |q| $))))) 

(SDEFUN |GUESS;guessRec;SM;118!0| ((|list| NIL) (|options| NIL) ($$ NIL))
        (PROG ($ |q|)
          (LETT $ (QREFELT $$ 1))
          (LETT |q| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|lres| NIL) (#1=#:G2255 NIL) (|res| NIL) (#2=#:G2256 NIL)
              (|opts| NIL) (|lopts| NIL))
             (SEQ
              (EXIT
               (SEQ (SPADCALL |options| (QREFELT $ 493))
                    (LETT |lopts|
                          (|GUESS;processOptions|
                           (SPADCALL (SPADCALL '|displayAsRec| (QREFELT $ 494))
                                     |options| (QREFELT $ 513))
                           $))
                    (LETT |lres| NIL) (LETT |res| NIL)
                    (SEQ (LETT |opts| NIL) (LETT #2# |lopts|) G190
                         (COND
                          ((OR (ATOM #2#) (PROGN (LETT |opts| (CAR #2#)) NIL))
                           (GO G191)))
                         (SEQ
                          (LETT |res|
                                (|GUESS;guessHPaux| (LIST |list|)
                                 (SPADCALL |opts|
                                           (SPADCALL |q| (QREFELT $ 323)))
                                 |opts| $))
                          (COND
                           ((NULL (SPADCALL |res| (QREFELT $ 514)))
                            (COND
                             ((SPADCALL |options| (QREFELT $ 485))
                              (PROGN (LETT #1# |res|) (GO #3=#:G2254))))))
                          (EXIT
                           (LETT |lres|
                                 (SPADCALL |res| |lres| (QREFELT $ 497)))))
                         (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                    (EXIT (SPADCALL |lres| (QREFELT $ 515)))))
              #3# (EXIT #1#))))))) 

(SDEFUN |GUESS;guessPRec;SM;119|
        ((|q| (|Symbol|))
         ($ (|Mapping| (|List| EXPRR) (|List| F) (|List| (|GuessOption|)))))
        (SPROG NIL (CONS #'|GUESS;guessPRec;SM;119!0| (VECTOR |q| $)))) 

(SDEFUN |GUESS;guessPRec;SM;119!0| ((|z1| NIL) (|z2| NIL) ($$ NIL))
        (PROG ($ |q|)
          (LETT $ (QREFELT $$ 1))
          (LETT |q| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |z1|
                      (SPADCALL
                       (SPADCALL (CONS 0 (|spadConstant| $ 74))
                                 (QREFELT $ 491))
                       |z2| (QREFELT $ 513))
                      (SPADCALL |q| (QREFELT $ 525))))))) 

(SDEFUN |GUESS;guessRat;SM;120|
        ((|q| (|Symbol|))
         ($ (|Mapping| (|List| EXPRR) (|List| F) (|List| (|GuessOption|)))))
        (SPROG NIL (CONS #'|GUESS;guessRat;SM;120!0| (VECTOR |q| $)))) 

(SDEFUN |GUESS;guessRat;SM;120!0| ((|z1| NIL) (|z2| NIL) ($$ NIL))
        (PROG ($ |q|)
          (LETT $ (QREFELT $$ 1))
          (LETT |q| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |z1|
                      (SPADCALL
                       (LIST
                        (LIST
                         (SPADCALL (CONS 0 (|spadConstant| $ 95))
                                   (QREFELT $ 522))
                         (SPADCALL (CONS 0 (|spadConstant| $ 74))
                                   (QREFELT $ 491)))
                        |z2| (LIST (SPADCALL 'T (QREFELT $ 507))))
                       (QREFELT $ 508))
                      (SPADCALL |q| (QREFELT $ 525))))))) 

(SDEFUN |GUESS;guess;LLLLL;121|
        ((|list| (|List| F))
         (|guessers|
          (|List|
           (|Mapping| (|List| EXPRR) (|List| F) (|List| (|GuessOption|)))))
         (|ops| (|List| (|Symbol|))) (|options| (|List| (|GuessOption|)))
         ($ (|List| EXPRR)))
        (SPROG
         ((|res| (|List| EXPRR)) (#1=#:G2370 NIL) (|guess| NIL)
          (|sumGuess| (|List| EXPRR)) (|summ| (EXPRR)) (|init| (EXPRR))
          (#2=#:G2369 NIL) (|var| (|Symbol|)) (|sumList| (|List| F))
          (#3=#:G2368 NIL) (|i| NIL) (#4=#:G2367 NIL) (#5=#:G2361 NIL)
          (#6=#:G2366 NIL) (|prodGuess| (|List| EXPRR)) (|prod| (EXPRR))
          (#7=#:G2365 NIL) (|prodList| (|List| F)) (#8=#:G2364 NIL)
          (#9=#:G2363 NIL)
          (|newMaxLevel| (|Union| (|NonNegativeInteger|) "arbitrary"))
          (#10=#:G2280 NIL) (#11=#:G2362 NIL) (|guesser| NIL)
          (|len| (|PositiveInteger|)) (#12=#:G2275 NIL) (|xx| (EXPRR)))
         (SEQ
          (EXIT
           (SEQ (LETT |newMaxLevel| (SPADCALL |options| (QREFELT $ 528)))
                (LETT |xx|
                      (SPADCALL (SPADCALL |options| (QREFELT $ 460))
                                (QREFELT $ 45)))
                (COND
                 ((SPADCALL |options| (QREFELT $ 361))
                  (COND
                   ((QEQCAR |newMaxLevel| 0)
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL "Guess: guessing level " (QREFELT $ 453))
                      (SPADCALL |newMaxLevel| (QREFELT $ 529)) (QREFELT $ 456))
                     (QREFELT $ 476))))))
                (LETT |res| NIL)
                (LETT |len|
                      (PROG1 (LETT #12# (LENGTH |list|))
                        (|check_subtype2| (> #12# 0) '(|PositiveInteger|)
                                          '(|NonNegativeInteger|) #12#)))
                (COND ((<= |len| 1) (PROGN (LETT #5# |res|) (GO #13=#:G2360))))
                (SEQ (LETT |guesser| NIL) (LETT #11# |guessers|) G190
                     (COND
                      ((OR (ATOM #11#) (PROGN (LETT |guesser| (CAR #11#)) NIL))
                       (GO G191)))
                     (SEQ
                      (LETT |res|
                            (SPADCALL (SPADCALL |list| |options| |guesser|)
                                      |res| (QREFELT $ 497)))
                      (EXIT
                       (COND
                        ((SPADCALL |options| (QREFELT $ 485))
                         (COND
                          ((NULL (NULL |res|))
                           (PROGN (LETT #5# |res|) (GO #13#))))))))
                     (LETT #11# (CDR #11#)) (GO G190) G191 (EXIT NIL))
                (COND
                 ((QEQCAR |newMaxLevel| 0)
                  (COND
                   ((ZEROP (QCDR |newMaxLevel|))
                    (PROGN (LETT #5# |res|) (GO #13#)))
                   (#14='T
                    (LETT |newMaxLevel|
                          (CONS 0
                                (PROG1 (LETT #10# (- (QCDR |newMaxLevel|) 1))
                                  (|check_subtype2| (>= #10# 0)
                                                    '(|NonNegativeInteger|)
                                                    '(|Integer|) #10#))))))))
                (COND
                 ((SPADCALL '|guessProduct| |ops| (QREFELT $ 530))
                  (COND
                   ((SPADCALL (|spadConstant| $ 143) |list| (QREFELT $ 531))
                    (SEQ (|spadConstant| $ 143)
                         (EXIT
                          (COND
                           ((SPADCALL |options| (QREFELT $ 361))
                            (SPADCALL
                             "Guess: cannot use guessProduct because of zeros"
                             (QREFELT $ 363)))))))
                   (#14#
                    (SEQ
                     (LETT |prodList|
                           (PROGN
                            (LETT #9# NIL)
                            (SEQ (LETT |i| 1) (LETT #8# (- |len| 1)) G190
                                 (COND ((|greater_SI| |i| #8#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #9#
                                         (CONS
                                          (SPADCALL
                                           (SPADCALL |list| (+ |i| 1)
                                                     (QREFELT $ 532))
                                           (SPADCALL |list| |i|
                                                     (QREFELT $ 532))
                                           (QREFELT $ 533))
                                          #9#))))
                                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                 (EXIT (NREVERSE #9#)))))
                     (EXIT
                      (COND
                       ((NULL
                         (SPADCALL (ELT $ 542) |prodList| (QREFELT $ 446)))
                        (SEQ
                         (LETT |var|
                               (SPADCALL '|p|
                                         (LIST
                                          (SPADCALL |len| (QREFELT $ 543)))
                                         (QREFELT $ 545)))
                         (LETT |prodGuess| NIL)
                         (SEQ (LETT |guess| NIL)
                              (LETT #7#
                                    (SPADCALL |prodList| |guessers| |ops|
                                              (SPADCALL
                                               (LIST
                                                (SPADCALL |var|
                                                          (QREFELT $ 546))
                                                (SPADCALL |newMaxLevel|
                                                          (QREFELT $ 547)))
                                               |options| (QREFELT $ 496))
                                              (QREFELT $ 549)))
                              G190
                              (COND
                               ((OR (ATOM #7#)
                                    (PROGN (LETT |guess| (CAR #7#)) NIL))
                                (GO G191)))
                              (SEQ
                               (LETT |init|
                                     (SPADCALL
                                      (SPADCALL |list| 1 (QREFELT $ 532))
                                      (QREFELT $ 10)))
                               (LETT |prod|
                                     (SPADCALL |guess|
                                               (SPADCALL |var|
                                                         (SPADCALL
                                                          (|spadConstant| $
                                                                          246)
                                                          (SPADCALL |xx|
                                                                    (|spadConstant|
                                                                     $ 197)
                                                                    (QREFELT $
                                                                             247))
                                                          (QREFELT $ 551))
                                                         (QREFELT $ 553))
                                               (QREFELT $ 555)))
                               (EXIT
                                (LETT |prodGuess|
                                      (CONS
                                       (SPADCALL |init| |prod| (QREFELT $ 104))
                                       |prodGuess|))))
                              (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
                         (EXIT
                          (SEQ (LETT |guess| NIL) (LETT #6# |prodGuess|) G190
                               (COND
                                ((OR (ATOM #6#)
                                     (PROGN (LETT |guess| (CAR #6#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((NULL
                                    (SPADCALL |guess| |res| (QREFELT $ 484)))
                                   (LETT |res| (CONS |guess| |res|))))))
                               (LETT #6# (CDR #6#)) (GO G190) G191
                               (EXIT NIL))))))))))))
                (COND
                 ((SPADCALL |options| (QREFELT $ 485))
                  (COND
                   ((NULL (NULL |res|)) (PROGN (LETT #5# |res|) (GO #13#))))))
                (COND
                 ((SPADCALL '|guessSum| |ops| (QREFELT $ 530))
                  (SEQ
                   (LETT |sumList|
                         (PROGN
                          (LETT #4# NIL)
                          (SEQ (LETT |i| 1) (LETT #3# (- |len| 1)) G190
                               (COND ((|greater_SI| |i| #3#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #4#
                                       (CONS
                                        (SPADCALL
                                         (SPADCALL |list| (+ |i| 1)
                                                   (QREFELT $ 532))
                                         (SPADCALL |list| |i| (QREFELT $ 532))
                                         (QREFELT $ 556))
                                        #4#))))
                               (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                               (EXIT (NREVERSE #4#)))))
                   (EXIT
                    (COND
                     ((NULL
                       (SPADCALL
                        (CONS #'|GUESS;guess;LLLLL;121!0| (VECTOR $ |sumList|))
                        |sumList| (QREFELT $ 446)))
                      (SEQ
                       (LETT |var|
                             (SPADCALL '|s|
                                       (LIST (SPADCALL |len| (QREFELT $ 543)))
                                       (QREFELT $ 545)))
                       (LETT |sumGuess| NIL)
                       (SEQ (LETT |guess| NIL)
                            (LETT #2#
                                  (SPADCALL |sumList| |guessers| |ops|
                                            (SPADCALL
                                             (LIST
                                              (SPADCALL |var| (QREFELT $ 546))
                                              (SPADCALL |newMaxLevel|
                                                        (QREFELT $ 547)))
                                             |options| (QREFELT $ 496))
                                            (QREFELT $ 549)))
                            G190
                            (COND
                             ((OR (ATOM #2#)
                                  (PROGN (LETT |guess| (CAR #2#)) NIL))
                              (GO G191)))
                            (SEQ
                             (LETT |init|
                                   (SPADCALL
                                    (SPADCALL |list| 1 (QREFELT $ 532))
                                    (QREFELT $ 10)))
                             (LETT |summ|
                                   (SPADCALL |guess|
                                             (SPADCALL |var|
                                                       (SPADCALL
                                                        (|spadConstant| $ 246)
                                                        (SPADCALL |xx|
                                                                  (|spadConstant|
                                                                   $ 197)
                                                                  (QREFELT $
                                                                           247))
                                                        (QREFELT $ 551))
                                                       (QREFELT $ 553))
                                             (QREFELT $ 558)))
                             (EXIT
                              (LETT |sumGuess|
                                    (CONS
                                     (SPADCALL |init| |summ| (QREFELT $ 93))
                                     |sumGuess|))))
                            (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                       (EXIT
                        (SEQ (LETT |guess| NIL) (LETT #1# |sumGuess|) G190
                             (COND
                              ((OR (ATOM #1#)
                                   (PROGN (LETT |guess| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((NULL
                                  (SPADCALL |guess| |res| (QREFELT $ 484)))
                                 (LETT |res| (CONS |guess| |res|))))))
                             (LETT #1# (CDR #1#)) (GO G190) G191
                             (EXIT NIL))))))))))
                (EXIT |res|)))
          #13# (EXIT #5#)))) 

(SDEFUN |GUESS;guess;LLLLL;121!0| ((|z1| NIL) ($$ NIL))
        (PROG (|sumList| $)
          (LETT |sumList| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |z1|
                      (SPADCALL |sumList| (|spadConstant| $ 74)
                                (QREFELT $ 532))
                      (QREFELT $ 557)))))) 

(SDEFUN |GUESS;guess;LL;122| ((|list| (|List| F)) ($ (|List| EXPRR)))
        (SPADCALL |list| (LIST (ELT $ 523)) (LIST '|guessProduct| '|guessSum|)
                  NIL (QREFELT $ 549))) 

(SDEFUN |GUESS;guess;LLL;123|
        ((|list| (|List| F)) (|options| (|List| (|GuessOption|)))
         ($ (|List| EXPRR)))
        (SPADCALL |list| (LIST (ELT $ 523)) (LIST '|guessProduct| '|guessSum|)
                  |options| (QREFELT $ 549))) 

(SDEFUN |GUESS;guess;LLLL;124|
        ((|list| (|List| F))
         (|guessers|
          (|List|
           (|Mapping| (|List| EXPRR) (|List| F) (|List| (|GuessOption|)))))
         (|ops| (|List| (|Symbol|))) ($ (|List| EXPRR)))
        (SPADCALL |list| |guessers| |ops| NIL (QREFELT $ 549))) 

(DECLAIM (NOTINLINE |Guess;|)) 

(DEFUN |Guess| (&REST #1=#:G2378)
  (SPROG NIL
         (PROG (#2=#:G2379)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T T T NIL NIL))
                     (HGET |$ConstructorCache| '|Guess|) '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |Guess;|) #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Guess|)))))))))) 

(DEFUN |Guess;| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 |#4|)
    (LETT DV$5 |#5|)
    (LETT |dv$| (LIST '|Guess| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 562))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|RetractableTo|
                                                          (|Symbol|)))
                                         (|HasCategory| |#2|
                                                        '(|RetractableTo|
                                                          (|Symbol|))))))))
    (|haddProp| |$ConstructorCache| '|Guess| (LIST DV$1 DV$2 DV$3 DV$4 DV$5)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|HasCategory| |#1| '(|RetractableTo| (|Symbol|)))
      (COND
       ((|HasCategory| |#2| '(|RetractableTo| (|Symbol|)))
        (PROGN
         (QSETREFV $ 24 (CONS (|dispatchFunction| |GUESS;guessExpRat;SM;5|) $))
         (QSETREFV $ 26
                   (CONS (|dispatchFunction| |GUESS;guessBinRat;SM;6|) $)))))))
    (COND
     ((|HasCategory| |#1| '(|RetractableTo| (|Symbol|)))
      (COND
       ((|HasCategory| |#2| '(|RetractableTo| (|Symbol|)))
        (PROGN
         (QSETREFV $ 242
                   (CONS (|dispatchFunction| |GUESS;diffHP;SM;58|) $)))))))
    (COND
     ((|HasCategory| |#1| '(|RetractableTo| (|Symbol|)))
      (COND
       ((|HasCategory| |#2| '(|RetractableTo| (|Symbol|)))
        (PROGN
         (QSETREFV $ 323
                   (CONS (|dispatchFunction| |GUESS;shiftHP;SM;81|) $)))))))
    (COND
     ((|HasCategory| |#1| '(|RetractableTo| (|Symbol|)))
      (COND
       ((|HasCategory| |#2| '(|RetractableTo| (|Symbol|)))
        (PROGN
         (QSETREFV $ 516 (CONS (|dispatchFunction| |GUESS;guessADE;SM;110|) $))
         (QSETREFV $ 517
                   (CONS (|dispatchFunction| |GUESS;guessHolo;SM;111|) $)))))))
    (COND
     ((|HasCategory| |#1| '(|RetractableTo| (|Symbol|)))
      (COND
       ((|HasCategory| |#2| '(|RetractableTo| (|Symbol|)))
        (PROGN
         (QSETREFV $ 525 (CONS (|dispatchFunction| |GUESS;guessRec;SM;118|) $))
         (QSETREFV $ 526
                   (CONS (|dispatchFunction| |GUESS;guessPRec;SM;119|) $))
         (QSETREFV $ 527
                   (CONS (|dispatchFunction| |GUESS;guessRat;SM;120|) $)))))))
    $))) 

(MAKEPROP '|Guess| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (|List| 8)
              (|List| 6) (|List| 486)
              (|GuessExpBin| 6 7 8 (NRTEVAL (QREFELT $ 9))
                             (NRTEVAL (QREFELT $ 10)))
              (0 . |guessExpRat|) |GUESS;guessExpRat;LL;1|
              |GUESS;guessExpRat;LLL;2| (6 . |guessBinRat|)
              |GUESS;guessBinRat;LL;3| |GUESS;guessBinRat;LLL;4|
              (|Mapping| 11 12 13) (|Symbol|) (12 . |guessExpRat|)
              (17 . |guessExpRat|) (22 . |guessBinRat|) (27 . |guessBinRat|)
              (|List| 22) (32 . |variables|) (|List| 27) (|Mapping| 27 7)
              (|List| 7) (|ListFunctions2| 7 27) (37 . |map|) (|Fraction| 7)
              (43 . |numer|) (48 . |denom|) (53 . |setUnion|) (|Mapping| 27 6)
              (|ListFunctions2| 6 27) (59 . |map|) (|String|) (65 . |elt|)
              (|Mapping| 27 27 27) (71 . |reduce|) (77 . |coerce|)
              (|Mapping| 8 22) (|ListFunctions2| 22 8) (82 . |map|)
              (88 . |coerce|) (|SparseUnivariatePolynomial| 6) (|Mapping| 6 7)
              (|SparseUnivariatePolynomial| 7)
              (|SparseUnivariatePolynomialFunctions2| 7 6) (93 . |map|)
              (|Union| 73 '"arbitrary") (|GuessOptionFunctions0|)
              (99 . |maxPower|) (|Union| 73 89) (104 . |homogeneous|)
              (|Union| 75 '"arbitrary") (109 . |maxDerivative|) (114 . |Somos|)
              (|Stream| 85) (|Integer|) (|PartitionsAndPermutations|)
              (119 . |partitions|) (125 . |inc|) (|Mapping| 64 64)
              (|Stream| 64) (130 . |stream|) (136 . |One|) (140 . |One|)
              (|PositiveInteger|) (144 . |One|) (|NonNegativeInteger|)
              (148 . +) (154 . |partitions|) (|Stream| 63) (|Mapping| 63 64)
              (|StreamFunctions2| 64 63) (161 . |map|) (167 . |partitions|)
              (|StreamFunctions1| 85) (172 . |concat|) (|List| 64)
              (177 . |cons|) (183 . |conjugates|) (188 . |#|) (|Boolean|)
              (193 . =) (|Mapping| 89 85) (199 . |select|) (205 . +) (211 . +)
              (217 . |Zero|) (|Mapping| 64 64 64) (221 . |reduce|) (228 . =)
              (|List| 85) (|Partition|) (234 . |powers|) (239 . |second|)
              (244 . ^) (250 . *) (|Mapping| 8 8 8) (256 . |reduce|)
              (|U32Vector|) (262 . |construct|)
              (|U32VectorPolynomialOperations|) (267 . |differentiate|)
              (274 . |pow|) (282 . |truncated_multiplication|)
              (|Mapping| 107 107 107) (|List| 107) (290 . |reduce|) (|Void|)
              (296 . |copy_first|) (|UnivariateFormalPowerSeries| 6) (303 . ^)
              (309 . *) (|Mapping| 118 118 118) (|List| 118) (315 . |reduce|)
              (321 . ^) (|Mapping| 6 6) (327 . |map|)
              (|UnivariateFormalPowerSeriesFunctions| 6) (333 . |hadamard|)
              (|SparseMultivariatePolynomial| 6 75) (339 . ^)
              (|Mapping| 129 129) (|UnivariateFormalPowerSeries| 129)
              (345 . |map|) (|UnivariateFormalPowerSeriesFunctions| 129)
              (351 . |hadamard|) (|Mapping| 132 132 132) (|List| 132)
              (357 . |reduce|) (|Stream| 118) (|Mapping| 118 85)
              (|StreamFunctions2| 85 118) (363 . |map|) (369 . |Zero|)
              (373 . |Zero|) (|Vector| 107) (377 . |setelt!|) (384 . ~=)
              (390 . |differentiate|) (396 . |Zero|) (400 . *) (|Vector| 132)
              (406 . |setelt!|) (|Union| $ '"failed") (413 . |subtractIfCan|)
              (|List| 100) (419 . |position|) (|Reference| 155) (425 . |deref|)
              (430 . |coerce|) (435 . |partition|) (|Reference| 99)
              (440 . |deref|) (445 . |setref|) (451 . |setref|) (457 . |max|)
              (463 . |first|) (|Mapping| 64 85) (|ListFunctions2| 85 64)
              (468 . |map|) (474 . |reduce|) (480 . |ref|) (485 . |ref|)
              (490 . |#|) (495 . |One|) (499 . |first|) (504 . |vector|)
              (509 . |vector|) (|Stream| 8) (|Mapping| 8 85)
              (|StreamFunctions2| 85 8) (514 . |map|) (520 . |empty?|)
              (525 . -) (531 . |max|) (|Stream| 75) (|Mapping| 75 85 75)
              (|StreamFunctions2| 85 75) (537 . |scan|) (544 . D) (551 . D)
              (557 . D) (|FractionFreeFastGaussian| 7 52) (563 . |DiffAction|)
              (|FractionFreeFastGaussian| 129 132) (570 . |DiffAction|)
              (577 . |DiffC|) (582 . |One|) (586 . |maxMixedDegree|)
              (591 . |displayKind|) (596 . |One|) (600 . |first|)
              (606 . |complete|) (611 . |entries|) (616 . |elt|) (622 . |One|)
              (|Mapping| 139 118) (|Mapping| 145 114 64 64) (|Mapping| 207 75)
              (|Mapping| 151 132) (|Mapping| 209 311) (|Mapping| 178 8 22)
              (|Mapping| 7 75 75 52) (|Mapping| 129 75 75 132)
              (|Mapping| 8 75 22 8) (|Mapping| 31 75)
              (|Record| (|:| |degreeStream| 185) (|:| |guessStream| 206)
                        (|:| |guessModGen| 208) (|:| |testGen| 210)
                        (|:| |exprStream| 211) (|:| |kind| 22) (|:| |qvar| 22)
                        (|:| A 212) (|:| AF 213) (|:| AX 214) (|:| C 215))
              |GUESS;diffHP;LR;43| (626 . |elt|) (632 . |functionNames|)
              (637 . ~=) (643 . |coerce|) (648 . ~=) (|List| 12) (654 . |elt|)
              (|Mapping| 75 85) (660 . |map|) |GUESS;algDepHP;LLR;47|
              (666 . |eval|) (673 . |multiplyExponents|)
              (679 . |multiplyExponents|) |GUESS;substHP;LR;51|
              (685 . |coerce|) (690 . *) (|Mapping| 6 64)
              (696 . |multiplyCoefficients|) (702 . |coerce|)
              (|Mapping| 129 64) (707 . |multiplyCoefficients|) (713 . |zero?|)
              (718 . =) (|Mapping| 216 13) (724 . |diffHP|) (729 . |coerce|)
              (734 . |factorial|) (739 . /) (745 . |Zero|) (749 . -)
              (755 . |quoByVar|) (|Mapping| 118 118) (|MappingPackage1| 118)
              (760 . ^) (766 . |quoByVar|) (|Mapping| 132 132)
              (|MappingPackage1| 132) (771 . ^)
              (|IntegerCombinatoricFunctions| 64) (777 . |stirling2|)
              (783 . |ShiftAction|) (790 . |ShiftAction|) (797 . |ShiftC|)
              (802 . |monomial|) (808 . -) (814 . -) (819 . ^) (825 . |elt|)
              (831 . |One|) (835 . |monomial|) (841 . -) (847 . -)
              (|Fraction| 64) (852 . |One|) (856 . -) (861 . ^)
              |GUESS;shiftHP;LR;68| (867 . *) (873 . ^) (879 . |coerce|)
              (884 . |qShiftAction|) (892 . |qShiftAction|) (900 . |qShiftC|)
              (906 . *) (912 . |elt|) (|Mapping| 122 118) (|StreamTensor| 118)
              (918 . |tensorMap|) (924 . |#|) (929 . |new|) (|SingleInteger|)
              (935 . |One|) (939 . ^) (945 . |rem|) (951 . |setelt!|) (958 . /)
              (964 . |ceiling|) (969 . |rest|) (974 . |copy|) (979 . |elt|)
              (985 . |cons|) (991 . |reverse!|) (|List| 145) (996 . |cons|)
              (1002 . |rem|) (1008 . -) (1013 . |reverse!|) (|List| $)
              (1018 . |concat|) (1023 . |Zero|) (|Mapping| 317 75)
              (|StreamTensor| 75) (1027 . |tensorMap|) (|List| 73)
              (1033 . |first|) (1038 . >) (1044 . *) (1050 . |elt|)
              (1056 . |concat|) (|List| 75) (1062 . |cons|) (1068 . |reverse!|)
              (|Mapping| 11 8) (|StreamTensor| 8) (1073 . |tensorMap|)
              (1079 . |shiftHP|) (1084 . |zero?|) (1089 . |leadingCoefficient|)
              (1094 . |degree|) (1099 . |reductum|) (|Stream| 6)
              (1104 . |coerce|) (1109 . |series|) (|List| 129) (|Stream| 129)
              (1114 . |coerce|) (|IndexedExponents| 75) (1119 . |monomial|)
              (1125 . |monomial|) (|StreamFunctions2| 64 129) (1131 . |map|)
              (1137 . |concat|) (1143 . |series|)
              (|SparseUnivariatePolynomial| 129) (|Mapping| 129 6)
              (|SparseUnivariatePolynomialFunctions2| 6 129) (1148 . |map|)
              (|UnivariatePolynomial| (NRTEVAL '|x|) 6)
              (1154 . |univariatePolynomial|) (1160 . |makeSUP|) (|List| 50)
              (|Mapping| 50 118) (|ListFunctions2| 118 50) (1165 . |map|)
              (1171 . |zero?|) (1176 . |allDegrees|) (1181 . |maxDegree|)
              (|Union| '"skip" '"MonteCarlo" '"deterministic") (1186 . |check|)
              (|Union| '"good" '"reject" '"no_solution") (|Mapping| 357 378)
              (|ModularHermitePadeSolver| 6 7) (1191 . |gen_Monte_Carlo_check|)
              (1201 . |debug|) (|OutputPackage|) (1206 . |output|)
              (|Union| 381 89) (1211 . |HP_solve|) (1222 . |elt|)
              (1228 . |setelt!|) (1235 . +) (1241 . +) (1247 . +) (1253 . +)
              (1259 . +) (|Mapping| 75 75 75) (1265 . |reduce|)
              (1271 . |first|) (1277 . |complete|) (1282 . |entries|)
              (|List| 52) (|Vector| 52) (1287 . |vector|) (|Matrix| 52)
              (1292 . |generalInterpolation|) (|Vector| 50) (1300 . |vector|)
              (|FractionFreeFastGaussianFractions| 7 52 50)
              (1305 . |generalInterpolation|) (1313 . |column|)
              (1319 . |entries|) (1324 . |Zero|) (1328 . |zero?|)
              (1333 . |elt|) (1340 . |leadingCoefficient|) (1345 . |content|)
              (1350 . |gcd|) (1355 . |exquo|) (1361 . |setelt!|)
              (1369 . |explicitlyEmpty?|) (|Stream| 381) (1374 . |empty|)
              (1378 . |empty?|) (1383 . |frst|) (1388 . >=) (|Mapping| 89 64)
              (1394 . |every?|) (1400 . |rst|) (1405 . |concat|) (|Mapping| $)
              (1411 . |delay|) (|Mapping| 64 75) (|ListFunctions2| 75 64)
              (1416 . |map|) (|Stream| 317) (1422 . |genVectorStream|)
              (|Mapping| 85 317) (|StreamFunctions2| 317 85) (1429 . |map|)
              (1435 . |empty|) (1439 . |concat|) (|Vector| 6) (1445 . |vector|)
              (1450 . |checkExtraValues|) (|SingletonAsOrderedSet|)
              (1455 . |create|) (1459 . |coerce|) (1464 . |elt|)
              (1470 . |eval|) (1477 . |retract|) (1482 . |elt|) (1488 . |gcd|)
              (1494 . |exquo|) (1500 . *) (1506 . ~=) (1512 . *) (1518 . +)
              (1524 . ~=) (|Vector| 7) (1530 . |elt|) (1536 . |elt|)
              (1542 . |zero?|) (1547 . |zero?|) (1552 . |zero?|)
              (1557 . |zero?|) (1562 . |zero?|) (1567 . |zero?|)
              (|Mapping| 89 6) (1572 . |every?|) (|List| 341) (|Vector| 341)
              (1578 . |vector|) (1583 . |generalCoefficient|) (1591 . |zero?|)
              (|OutputForm|) (1596 . |message|) (1601 . |print|)
              (1606 . |coerce|) (1611 . |hconcat|) (1617 . |ground?|)
              (1622 . |variableName|) (1627 . |numerator|) (1632 . |indexName|)
              (|Mapping| 8 6) (|StreamFunctions2| 6 8) (1637 . |map|)
              (|BasicOperator|) (|RecurrenceOperator| 64 8) (1643 . |makeFEq|)
              (1653 . |makeRec|) (1662 . |safety|) (1667 . |functionName|)
              (1672 . |operator|) (1677 . |elt|) (1683 . |rest|)
              (1689 . |empty?|) (1694 . |coerce|) (1699 . |hconcat|)
              (1704 . |output|) (1709 . |first|) (1715 . |complete|)
              (1720 . |entries|) (1725 . |coerce|) (1730 . |empty?|)
              (1735 . |first|) (1740 . |rst|) (1745 . |member?|) (1751 . |one|)
              (|GuessOption|) (1756 . |Somos|) (|List| 13) (1761 . |concat|)
              (1766 . |homogeneous|) (1771 . |maxPower|) (1776 . |concat|)
              (1782 . |checkOptions|) (1787 . |displayKind|)
              (1792 . |maxSubst|) (1797 . |append|) (1803 . |append|)
              |GUESS;guessAlgDep;LLL;98| |GUESS;guessAlgDep;LL;99|
              |GUESS;guessADE;LLL;100| |GUESS;guessADE;LL;101|
              (1809 . |maxDerivative|) |GUESS;guessAlg;LLL;102|
              |GUESS;guessAlg;LL;103| |GUESS;guessHolo;LLL;104|
              |GUESS;guessHolo;LL;105| (1814 . |allDegrees|) (1819 . |concat|)
              |GUESS;guessPade;LLL;106| |GUESS;guessPade;LL;107|
              |GUESS;guessFE;LLL;108| |GUESS;guessFE;LL;109| (1824 . |cons|)
              (1830 . |empty?|) (1835 . |reverse!|) (1840 . |guessADE|)
              (1845 . |guessHolo|) |GUESS;guessRec;LLL;112|
              |GUESS;guessRec;LL;113| |GUESS;guessPRec;LLL;114|
              |GUESS;guessPRec;LL;115| (1850 . |maxShift|)
              |GUESS;guessRat;LLL;116| |GUESS;guessRat;LL;117|
              (1855 . |guessRec|) (1860 . |guessPRec|) (1865 . |guessRat|)
              (1870 . |maxLevel|) (1875 . |coerce|) (1880 . |member?|)
              (1886 . |member?|) (1892 . |elt|) (1898 . /) (1904 . |one?|)
              (1909 . |one?|) (1914 . |one?|) (1919 . |one?|) (1924 . |one?|)
              (1929 . |one?|) (1934 . |one?|) (1939 . |one?|) (1944 . |one?|)
              (1949 . |coerce|) (|List| 452) (1954 . |subscript|)
              (1960 . |indexName|) (1965 . |maxLevel|) (|List| 21)
              |GUESS;guess;LLLLL;121| (|Segment| 8) (1970 . SEGMENT)
              (|SegmentBinding| 8) (1976 . |equation|) (|SegmentBinding| $)
              (1982 . |product|) (1988 . -) (1994 . =) (2000 . |summation|)
              |GUESS;guess;LL;122| |GUESS;guess;LLL;123|
              |GUESS;guess;LLLL;124|)
           '#(|substHP| 2006 |shiftHP| 2011 |guessRec| 2021 |guessRat| 2037
              |guessPade| 2053 |guessPRec| 2064 |guessHolo| 2080 |guessFE| 2096
              |guessExpRat| 2107 |guessBinRat| 2123 |guessAlgDep| 2139
              |guessAlg| 2150 |guessADE| 2161 |guess| 2177 |diffHP| 2203
              |algDepHP| 2213)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|guess| ((|List| |#3|) (|List| |#1|))) T)
                                   '((|guess|
                                      ((|List| |#3|) (|List| |#1|)
                                       (|List| (|GuessOption|))))
                                     T)
                                   '((|guess|
                                      ((|List| |#3|) (|List| |#1|)
                                       (|List|
                                        (|Mapping| (|List| |#3|) (|List| |#1|)
                                                   (|List| (|GuessOption|))))
                                       (|List| (|Symbol|))))
                                     T)
                                   '((|guess|
                                      ((|List| |#3|) (|List| |#1|)
                                       (|List|
                                        (|Mapping| (|List| |#3|) (|List| |#1|)
                                                   (|List| (|GuessOption|))))
                                       (|List| (|Symbol|))
                                       (|List| (|GuessOption|))))
                                     T)
                                   '((|guessExpRat|
                                      ((|List| |#3|) (|List| |#1|)))
                                     T)
                                   '((|guessExpRat|
                                      ((|List| |#3|) (|List| |#1|)
                                       (|List| (|GuessOption|))))
                                     T)
                                   '((|guessBinRat|
                                      ((|List| |#3|) (|List| |#1|)))
                                     T)
                                   '((|guessBinRat|
                                      ((|List| |#3|) (|List| |#1|)
                                       (|List| (|GuessOption|))))
                                     T)
                                   '((|guessExpRat|
                                      ((|Mapping| (|List| |#3|) (|List| |#1|)
                                                  (|List| (|GuessOption|)))
                                       (|Symbol|)))
                                     (AND (|has| 7 (|RetractableTo| 22))
                                          (|has| 6 (|RetractableTo| 22))))
                                   '((|guessBinRat|
                                      ((|Mapping| (|List| |#3|) (|List| |#1|)
                                                  (|List| (|GuessOption|)))
                                       (|Symbol|)))
                                     (AND (|has| 7 (|RetractableTo| 22))
                                          (|has| 6 (|RetractableTo| 22))))
                                   '((|guessAlgDep|
                                      ((|List| |#3|) (|List| (|List| |#1|))))
                                     T)
                                   '((|guessAlgDep|
                                      ((|List| |#3|) (|List| (|List| |#1|))
                                       (|List| (|GuessOption|))))
                                     T)
                                   '((|guessADE| ((|List| |#3|) (|List| |#1|)))
                                     T)
                                   '((|guessADE|
                                      ((|List| |#3|) (|List| |#1|)
                                       (|List| (|GuessOption|))))
                                     T)
                                   '((|guessFE| ((|List| |#3|) (|List| |#1|)))
                                     T)
                                   '((|guessFE|
                                      ((|List| |#3|) (|List| |#1|)
                                       (|List| (|GuessOption|))))
                                     T)
                                   '((|guessAlg| ((|List| |#3|) (|List| |#1|)))
                                     T)
                                   '((|guessAlg|
                                      ((|List| |#3|) (|List| |#1|)
                                       (|List| (|GuessOption|))))
                                     T)
                                   '((|guessHolo|
                                      ((|List| |#3|) (|List| |#1|)))
                                     T)
                                   '((|guessHolo|
                                      ((|List| |#3|) (|List| |#1|)
                                       (|List| (|GuessOption|))))
                                     T)
                                   '((|guessPade|
                                      ((|List| |#3|) (|List| |#1|)
                                       (|List| (|GuessOption|))))
                                     T)
                                   '((|guessPade|
                                      ((|List| |#3|) (|List| |#1|)))
                                     T)
                                   '((|guessRec| ((|List| |#3|) (|List| |#1|)))
                                     T)
                                   '((|guessRec|
                                      ((|List| |#3|) (|List| |#1|)
                                       (|List| (|GuessOption|))))
                                     T)
                                   '((|guessPRec|
                                      ((|List| |#3|) (|List| |#1|)
                                       (|List| (|GuessOption|))))
                                     T)
                                   '((|guessPRec|
                                      ((|List| |#3|) (|List| |#1|)))
                                     T)
                                   '((|guessRat|
                                      ((|List| |#3|) (|List| |#1|)
                                       (|List| (|GuessOption|))))
                                     T)
                                   '((|guessRat| ((|List| |#3|) (|List| |#1|)))
                                     T)
                                   '((|algDepHP|
                                      ((|Record|
                                        (|:| |degreeStream|
                                             (|Stream| (|NonNegativeInteger|)))
                                        (|:| |guessStream|
                                             (|Mapping|
                                              (|Stream|
                                               (|UnivariateFormalPowerSeries|
                                                |#1|))
                                              (|UnivariateFormalPowerSeries|
                                               |#1|)))
                                        (|:| |guessModGen|
                                             (|Mapping|
                                              (|Mapping|
                                               (|Vector| (|U32Vector|))
                                               (|List| (|U32Vector|))
                                               (|Integer|) (|Integer|))
                                              (|NonNegativeInteger|)))
                                        (|:| |testGen|
                                             (|Mapping|
                                              (|Mapping|
                                               (|Vector|
                                                (|UnivariateFormalPowerSeries|
                                                 (|SparseMultivariatePolynomial|
                                                  |#1|
                                                  (|NonNegativeInteger|))))
                                               (|UnivariateFormalPowerSeries|
                                                (|SparseMultivariatePolynomial|
                                                 |#1| (|NonNegativeInteger|))))
                                              (|List| (|PositiveInteger|))))
                                        (|:| |exprStream|
                                             (|Mapping| (|Stream| |#3|) |#3|
                                                        (|Symbol|)))
                                        (|:| |kind| (|Symbol|))
                                        (|:| |qvar| (|Symbol|))
                                        (|:| A
                                             (|Mapping| |#2|
                                                        (|NonNegativeInteger|)
                                                        (|NonNegativeInteger|)
                                                        (|SparseUnivariatePolynomial|
                                                         |#2|)))
                                        (|:| AF
                                             (|Mapping|
                                              (|SparseMultivariatePolynomial|
                                               |#1| (|NonNegativeInteger|))
                                              (|NonNegativeInteger|)
                                              (|NonNegativeInteger|)
                                              (|UnivariateFormalPowerSeries|
                                               (|SparseMultivariatePolynomial|
                                                |#1| (|NonNegativeInteger|)))))
                                        (|:| AX
                                             (|Mapping| |#3|
                                                        (|NonNegativeInteger|)
                                                        (|Symbol|) |#3|))
                                        (|:| C
                                             (|Mapping| (|List| |#2|)
                                                        (|NonNegativeInteger|))))
                                       (|List| (|List| |#1|))
                                       (|List| (|GuessOption|))))
                                     T)
                                   '((|diffHP|
                                      ((|Record|
                                        (|:| |degreeStream|
                                             (|Stream| (|NonNegativeInteger|)))
                                        (|:| |guessStream|
                                             (|Mapping|
                                              (|Stream|
                                               (|UnivariateFormalPowerSeries|
                                                |#1|))
                                              (|UnivariateFormalPowerSeries|
                                               |#1|)))
                                        (|:| |guessModGen|
                                             (|Mapping|
                                              (|Mapping|
                                               (|Vector| (|U32Vector|))
                                               (|List| (|U32Vector|))
                                               (|Integer|) (|Integer|))
                                              (|NonNegativeInteger|)))
                                        (|:| |testGen|
                                             (|Mapping|
                                              (|Mapping|
                                               (|Vector|
                                                (|UnivariateFormalPowerSeries|
                                                 (|SparseMultivariatePolynomial|
                                                  |#1|
                                                  (|NonNegativeInteger|))))
                                               (|UnivariateFormalPowerSeries|
                                                (|SparseMultivariatePolynomial|
                                                 |#1| (|NonNegativeInteger|))))
                                              (|List| (|PositiveInteger|))))
                                        (|:| |exprStream|
                                             (|Mapping| (|Stream| |#3|) |#3|
                                                        (|Symbol|)))
                                        (|:| |kind| (|Symbol|))
                                        (|:| |qvar| (|Symbol|))
                                        (|:| A
                                             (|Mapping| |#2|
                                                        (|NonNegativeInteger|)
                                                        (|NonNegativeInteger|)
                                                        (|SparseUnivariatePolynomial|
                                                         |#2|)))
                                        (|:| AF
                                             (|Mapping|
                                              (|SparseMultivariatePolynomial|
                                               |#1| (|NonNegativeInteger|))
                                              (|NonNegativeInteger|)
                                              (|NonNegativeInteger|)
                                              (|UnivariateFormalPowerSeries|
                                               (|SparseMultivariatePolynomial|
                                                |#1| (|NonNegativeInteger|)))))
                                        (|:| AX
                                             (|Mapping| |#3|
                                                        (|NonNegativeInteger|)
                                                        (|Symbol|) |#3|))
                                        (|:| C
                                             (|Mapping| (|List| |#2|)
                                                        (|NonNegativeInteger|))))
                                       (|List| (|GuessOption|))))
                                     T)
                                   '((|substHP|
                                      ((|Record|
                                        (|:| |degreeStream|
                                             (|Stream| (|NonNegativeInteger|)))
                                        (|:| |guessStream|
                                             (|Mapping|
                                              (|Stream|
                                               (|UnivariateFormalPowerSeries|
                                                |#1|))
                                              (|UnivariateFormalPowerSeries|
                                               |#1|)))
                                        (|:| |guessModGen|
                                             (|Mapping|
                                              (|Mapping|
                                               (|Vector| (|U32Vector|))
                                               (|List| (|U32Vector|))
                                               (|Integer|) (|Integer|))
                                              (|NonNegativeInteger|)))
                                        (|:| |testGen|
                                             (|Mapping|
                                              (|Mapping|
                                               (|Vector|
                                                (|UnivariateFormalPowerSeries|
                                                 (|SparseMultivariatePolynomial|
                                                  |#1|
                                                  (|NonNegativeInteger|))))
                                               (|UnivariateFormalPowerSeries|
                                                (|SparseMultivariatePolynomial|
                                                 |#1| (|NonNegativeInteger|))))
                                              (|List| (|PositiveInteger|))))
                                        (|:| |exprStream|
                                             (|Mapping| (|Stream| |#3|) |#3|
                                                        (|Symbol|)))
                                        (|:| |kind| (|Symbol|))
                                        (|:| |qvar| (|Symbol|))
                                        (|:| A
                                             (|Mapping| |#2|
                                                        (|NonNegativeInteger|)
                                                        (|NonNegativeInteger|)
                                                        (|SparseUnivariatePolynomial|
                                                         |#2|)))
                                        (|:| AF
                                             (|Mapping|
                                              (|SparseMultivariatePolynomial|
                                               |#1| (|NonNegativeInteger|))
                                              (|NonNegativeInteger|)
                                              (|NonNegativeInteger|)
                                              (|UnivariateFormalPowerSeries|
                                               (|SparseMultivariatePolynomial|
                                                |#1| (|NonNegativeInteger|)))))
                                        (|:| AX
                                             (|Mapping| |#3|
                                                        (|NonNegativeInteger|)
                                                        (|Symbol|) |#3|))
                                        (|:| C
                                             (|Mapping| (|List| |#2|)
                                                        (|NonNegativeInteger|))))
                                       (|List| (|GuessOption|))))
                                     T)
                                   '((|shiftHP|
                                      ((|Record|
                                        (|:| |degreeStream|
                                             (|Stream| (|NonNegativeInteger|)))
                                        (|:| |guessStream|
                                             (|Mapping|
                                              (|Stream|
                                               (|UnivariateFormalPowerSeries|
                                                |#1|))
                                              (|UnivariateFormalPowerSeries|
                                               |#1|)))
                                        (|:| |guessModGen|
                                             (|Mapping|
                                              (|Mapping|
                                               (|Vector| (|U32Vector|))
                                               (|List| (|U32Vector|))
                                               (|Integer|) (|Integer|))
                                              (|NonNegativeInteger|)))
                                        (|:| |testGen|
                                             (|Mapping|
                                              (|Mapping|
                                               (|Vector|
                                                (|UnivariateFormalPowerSeries|
                                                 (|SparseMultivariatePolynomial|
                                                  |#1|
                                                  (|NonNegativeInteger|))))
                                               (|UnivariateFormalPowerSeries|
                                                (|SparseMultivariatePolynomial|
                                                 |#1| (|NonNegativeInteger|))))
                                              (|List| (|PositiveInteger|))))
                                        (|:| |exprStream|
                                             (|Mapping| (|Stream| |#3|) |#3|
                                                        (|Symbol|)))
                                        (|:| |kind| (|Symbol|))
                                        (|:| |qvar| (|Symbol|))
                                        (|:| A
                                             (|Mapping| |#2|
                                                        (|NonNegativeInteger|)
                                                        (|NonNegativeInteger|)
                                                        (|SparseUnivariatePolynomial|
                                                         |#2|)))
                                        (|:| AF
                                             (|Mapping|
                                              (|SparseMultivariatePolynomial|
                                               |#1| (|NonNegativeInteger|))
                                              (|NonNegativeInteger|)
                                              (|NonNegativeInteger|)
                                              (|UnivariateFormalPowerSeries|
                                               (|SparseMultivariatePolynomial|
                                                |#1| (|NonNegativeInteger|)))))
                                        (|:| AX
                                             (|Mapping| |#3|
                                                        (|NonNegativeInteger|)
                                                        (|Symbol|) |#3|))
                                        (|:| C
                                             (|Mapping| (|List| |#2|)
                                                        (|NonNegativeInteger|))))
                                       (|List| (|GuessOption|))))
                                     T)
                                   '((|shiftHP|
                                      ((|Mapping|
                                        (|Record|
                                         (|:| |degreeStream|
                                              (|Stream|
                                               (|NonNegativeInteger|)))
                                         (|:| |guessStream|
                                              (|Mapping|
                                               (|Stream|
                                                (|UnivariateFormalPowerSeries|
                                                 |#1|))
                                               (|UnivariateFormalPowerSeries|
                                                |#1|)))
                                         (|:| |guessModGen|
                                              (|Mapping|
                                               (|Mapping|
                                                (|Vector| (|U32Vector|))
                                                (|List| (|U32Vector|))
                                                (|Integer|) (|Integer|))
                                               (|NonNegativeInteger|)))
                                         (|:| |testGen|
                                              (|Mapping|
                                               (|Mapping|
                                                (|Vector|
                                                 (|UnivariateFormalPowerSeries|
                                                  (|SparseMultivariatePolynomial|
                                                   |#1|
                                                   (|NonNegativeInteger|))))
                                                (|UnivariateFormalPowerSeries|
                                                 (|SparseMultivariatePolynomial|
                                                  |#1|
                                                  (|NonNegativeInteger|))))
                                               (|List| (|PositiveInteger|))))
                                         (|:| |exprStream|
                                              (|Mapping| (|Stream| |#3|) |#3|
                                                         (|Symbol|)))
                                         (|:| |kind| (|Symbol|))
                                         (|:| |qvar| (|Symbol|))
                                         (|:| A
                                              (|Mapping| |#2|
                                                         (|NonNegativeInteger|)
                                                         (|NonNegativeInteger|)
                                                         (|SparseUnivariatePolynomial|
                                                          |#2|)))
                                         (|:| AF
                                              (|Mapping|
                                               (|SparseMultivariatePolynomial|
                                                |#1| (|NonNegativeInteger|))
                                               (|NonNegativeInteger|)
                                               (|NonNegativeInteger|)
                                               (|UnivariateFormalPowerSeries|
                                                (|SparseMultivariatePolynomial|
                                                 |#1|
                                                 (|NonNegativeInteger|)))))
                                         (|:| AX
                                              (|Mapping| |#3|
                                                         (|NonNegativeInteger|)
                                                         (|Symbol|) |#3|))
                                         (|:| C
                                              (|Mapping| (|List| |#2|)
                                                         (|NonNegativeInteger|))))
                                        (|List| (|GuessOption|)))
                                       (|Symbol|)))
                                     (AND (|has| 7 (|RetractableTo| 22))
                                          (|has| 6 (|RetractableTo| 22))))
                                   '((|diffHP|
                                      ((|Mapping|
                                        (|Record|
                                         (|:| |degreeStream|
                                              (|Stream|
                                               (|NonNegativeInteger|)))
                                         (|:| |guessStream|
                                              (|Mapping|
                                               (|Stream|
                                                (|UnivariateFormalPowerSeries|
                                                 |#1|))
                                               (|UnivariateFormalPowerSeries|
                                                |#1|)))
                                         (|:| |guessModGen|
                                              (|Mapping|
                                               (|Mapping|
                                                (|Vector| (|U32Vector|))
                                                (|List| (|U32Vector|))
                                                (|Integer|) (|Integer|))
                                               (|NonNegativeInteger|)))
                                         (|:| |testGen|
                                              (|Mapping|
                                               (|Mapping|
                                                (|Vector|
                                                 (|UnivariateFormalPowerSeries|
                                                  (|SparseMultivariatePolynomial|
                                                   |#1|
                                                   (|NonNegativeInteger|))))
                                                (|UnivariateFormalPowerSeries|
                                                 (|SparseMultivariatePolynomial|
                                                  |#1|
                                                  (|NonNegativeInteger|))))
                                               (|List| (|PositiveInteger|))))
                                         (|:| |exprStream|
                                              (|Mapping| (|Stream| |#3|) |#3|
                                                         (|Symbol|)))
                                         (|:| |kind| (|Symbol|))
                                         (|:| |qvar| (|Symbol|))
                                         (|:| A
                                              (|Mapping| |#2|
                                                         (|NonNegativeInteger|)
                                                         (|NonNegativeInteger|)
                                                         (|SparseUnivariatePolynomial|
                                                          |#2|)))
                                         (|:| AF
                                              (|Mapping|
                                               (|SparseMultivariatePolynomial|
                                                |#1| (|NonNegativeInteger|))
                                               (|NonNegativeInteger|)
                                               (|NonNegativeInteger|)
                                               (|UnivariateFormalPowerSeries|
                                                (|SparseMultivariatePolynomial|
                                                 |#1|
                                                 (|NonNegativeInteger|)))))
                                         (|:| AX
                                              (|Mapping| |#3|
                                                         (|NonNegativeInteger|)
                                                         (|Symbol|) |#3|))
                                         (|:| C
                                              (|Mapping| (|List| |#2|)
                                                         (|NonNegativeInteger|))))
                                        (|List| (|GuessOption|)))
                                       (|Symbol|)))
                                     (AND (|has| 7 (|RetractableTo| 22))
                                          (|has| 6 (|RetractableTo| 22))))
                                   '((|guessRec|
                                      ((|Mapping| (|List| |#3|) (|List| |#1|)
                                                  (|List| (|GuessOption|)))
                                       (|Symbol|)))
                                     (AND (|has| 7 (|RetractableTo| 22))
                                          (|has| 6 (|RetractableTo| 22))))
                                   '((|guessPRec|
                                      ((|Mapping| (|List| |#3|) (|List| |#1|)
                                                  (|List| (|GuessOption|)))
                                       (|Symbol|)))
                                     (AND (|has| 7 (|RetractableTo| 22))
                                          (|has| 6 (|RetractableTo| 22))))
                                   '((|guessRat|
                                      ((|Mapping| (|List| |#3|) (|List| |#1|)
                                                  (|List| (|GuessOption|)))
                                       (|Symbol|)))
                                     (AND (|has| 7 (|RetractableTo| 22))
                                          (|has| 6 (|RetractableTo| 22))))
                                   '((|guessADE|
                                      ((|Mapping| (|List| |#3|) (|List| |#1|)
                                                  (|List| (|GuessOption|)))
                                       (|Symbol|)))
                                     (AND (|has| 7 (|RetractableTo| 22))
                                          (|has| 6 (|RetractableTo| 22))))
                                   '((|guessHolo|
                                      ((|Mapping| (|List| |#3|) (|List| |#1|)
                                                  (|List| (|GuessOption|)))
                                       (|Symbol|)))
                                     (AND (|has| 7 (|RetractableTo| 22))
                                          (|has| 6 (|RetractableTo| 22)))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 561
                                            '(2 14 11 12 13 15 2 14 11 12 13 18
                                              1 14 21 22 23 1 0 21 22 24 1 14
                                              21 22 25 1 0 21 22 26 1 7 27 0 28
                                              2 32 29 30 31 33 1 34 7 0 35 1 34
                                              7 0 36 2 27 0 0 0 37 2 39 29 38
                                              12 40 2 41 0 0 0 42 2 29 27 43 0
                                              44 1 8 0 22 45 2 47 11 46 27 48 1
                                              34 0 7 49 2 53 50 51 52 54 1 56
                                              55 13 57 1 56 58 13 59 1 56 60 13
                                              61 1 56 58 13 62 2 65 63 64 64 66
                                              1 64 0 0 67 2 69 0 68 64 70 0 6 0
                                              71 0 7 0 72 0 73 0 74 2 75 0 0 0
                                              76 3 65 63 64 64 64 77 2 80 78 79
                                              69 81 1 65 63 64 82 1 83 63 78 84
                                              2 63 0 85 0 86 1 65 63 63 87 1 85
                                              75 0 88 2 75 89 0 0 90 2 63 0 91
                                              0 92 2 8 0 0 0 93 2 64 0 0 0 94 0
                                              75 0 95 3 85 64 96 0 64 97 2 64
                                              89 0 0 98 1 100 99 85 101 1 85 64
                                              0 102 2 8 0 0 75 103 2 8 0 0 0
                                              104 2 11 8 105 0 106 1 107 0 85
                                              108 3 109 107 107 75 64 110 4 109
                                              107 107 73 75 64 111 4 109 107
                                              107 107 64 64 112 2 114 107 113 0
                                              115 3 109 116 107 107 64 117 2
                                              118 0 0 75 119 2 118 0 0 0 120 2
                                              122 118 121 0 123 2 6 0 0 75 124
                                              2 118 0 125 0 126 2 127 118 118
                                              118 128 2 129 0 0 75 130 2 132 0
                                              131 0 133 2 134 132 132 132 135 2
                                              137 132 136 0 138 2 141 139 140
                                              63 142 0 6 0 143 0 7 0 144 3 145
                                              107 0 64 107 146 2 75 89 0 0 147
                                              2 109 107 107 64 148 0 132 0 149
                                              2 132 0 0 0 150 3 151 132 0 64
                                              132 152 2 100 153 0 0 154 2 155
                                              64 100 0 156 1 157 155 0 158 1
                                              100 85 0 159 1 100 0 85 160 1 161
                                              99 0 162 2 161 99 0 99 163 2 157
                                              155 0 155 164 2 64 0 0 0 165 1 85
                                              64 0 166 2 168 85 167 99 169 2 85
                                              64 96 0 170 1 161 0 99 171 1 157
                                              0 155 172 1 114 75 0 173 0 75 0
                                              174 1 114 107 0 175 1 145 0 114
                                              176 1 151 0 137 177 2 180 178 179
                                              63 181 1 85 89 0 182 2 64 0 0 0
                                              183 2 75 0 0 0 184 3 187 185 75
                                              186 63 188 3 8 0 0 22 75 189 2
                                              118 0 0 75 190 2 132 0 0 75 191 3
                                              192 7 75 75 52 193 3 194 129 75
                                              75 132 195 1 192 31 75 196 0 8 0
                                              197 1 56 75 13 198 1 56 22 13 199
                                              0 118 0 200 2 63 0 0 75 201 1 63
                                              0 0 202 1 63 99 0 203 2 63 85 0
                                              64 204 0 132 0 205 2 11 8 0 64
                                              218 1 56 27 13 219 2 64 89 0 0
                                              220 1 22 0 41 221 2 22 89 0 0 222
                                              2 223 12 0 64 224 2 187 185 225
                                              63 226 3 8 0 0 0 0 228 2 118 0 0
                                              73 229 2 132 0 0 73 230 1 6 0 22
                                              232 2 64 0 75 0 233 2 118 0 234 0
                                              235 1 129 0 6 236 2 132 0 237 0
                                              238 1 64 89 0 239 2 22 89 0 0 240
                                              1 0 241 22 242 1 8 0 64 243 1 64
                                              0 0 244 2 8 0 0 0 245 0 8 0 246 2
                                              8 0 0 0 247 1 118 0 0 248 2 250
                                              249 249 75 251 1 132 0 0 252 2
                                              254 253 253 75 255 2 256 64 64 64
                                              257 3 192 7 75 75 52 258 3 194
                                              129 75 75 132 259 1 192 31 75 260
                                              2 118 0 6 75 261 2 118 0 0 0 262
                                              1 6 0 0 263 2 118 0 0 6 264 2 185
                                              75 0 64 265 0 129 0 266 2 132 0
                                              129 75 267 2 132 0 0 0 268 1 129
                                              0 0 269 0 270 0 271 1 270 0 0 272
                                              2 132 0 0 270 273 2 8 0 75 0 275
                                              2 8 0 0 0 276 1 7 0 22 277 4 192
                                              7 7 75 75 52 278 4 194 129 129 75
                                              75 132 279 2 192 31 7 75 280 2
                                              118 0 6 0 281 2 118 0 0 0 282 2
                                              284 139 139 283 285 1 107 75 0
                                              286 2 107 0 75 64 287 0 288 0 289
                                              2 64 0 0 75 290 2 64 0 0 0 291 3
                                              107 64 0 64 64 292 2 270 0 64 64
                                              293 1 270 64 0 294 1 114 0 0 295
                                              1 107 0 0 296 2 107 64 0 64 297 2
                                              114 0 107 0 298 1 114 0 0 299 2
                                              300 0 145 0 301 2 75 0 0 0 302 1
                                              288 0 0 303 1 300 0 0 304 1 145 0
                                              305 306 0 288 0 307 2 309 185 185
                                              308 310 1 311 73 0 312 2 73 89 0
                                              0 313 2 132 0 129 0 314 2 132 0 0
                                              0 315 2 137 0 0 0 316 2 317 0 75
                                              0 318 1 137 0 0 319 2 321 178 178
                                              320 322 1 0 241 22 323 1 50 89 0
                                              324 1 50 6 0 325 1 50 75 0 326 1
                                              50 0 0 327 1 328 0 12 329 1 118 0
                                              328 330 1 332 0 331 333 2 334 0
                                              75 75 335 2 129 0 6 334 336 2 337
                                              332 237 69 338 2 332 0 0 0 339 1
                                              132 0 332 340 2 343 341 342 50
                                              344 2 118 345 0 75 346 1 345 50 0
                                              347 2 350 348 349 122 351 1 6 89
                                              0 352 1 56 89 13 353 1 56 60 13
                                              354 1 56 355 13 356 6 359 358 358
                                              223 22 22 75 207 360 1 56 89 13
                                              361 1 362 116 41 363 7 359 364
                                              223 85 22 22 75 207 358 365 2 317
                                              75 0 64 366 3 317 75 0 64 75 367
                                              2 118 0 0 0 368 2 132 0 0 0 369 2
                                              7 0 0 0 370 2 50 0 0 0 371 2 6 0
                                              0 0 372 2 317 75 373 0 374 2 139
                                              0 0 75 375 1 139 0 0 376 1 139
                                              122 0 377 1 379 0 378 380 4 192
                                              381 31 212 379 317 382 1 383 0
                                              348 384 4 385 381 31 212 383 317
                                              386 2 381 379 0 64 387 1 379 378
                                              0 388 0 52 0 389 1 7 89 0 390 3
                                              381 52 0 64 64 391 1 52 7 0 392 1
                                              52 7 0 393 1 7 0 305 394 2 52 153
                                              0 7 395 4 381 52 0 64 64 52 396 1
                                              63 89 0 397 0 398 0 399 1 63 89 0
                                              400 1 63 85 0 401 2 64 89 0 0 402
                                              2 85 89 403 0 404 1 63 0 0 405 2
                                              398 0 381 0 406 1 398 0 407 408 2
                                              410 85 409 317 411 3 192 412 75
                                              75 75 413 2 415 63 414 412 416 0
                                              63 0 417 2 63 0 85 0 418 1 419 0
                                              12 420 1 56 89 13 421 0 422 0 423
                                              1 7 0 64 424 2 379 52 0 64 425 3
                                              52 0 0 422 7 426 1 52 7 0 427 2
                                              419 6 0 64 428 2 7 0 0 0 429 2 7
                                              153 0 0 430 2 7 0 0 0 431 2 7 89
                                              0 0 432 2 34 0 7 0 433 2 34 0 0 0
                                              434 2 34 89 0 0 435 2 436 7 0 64
                                              437 2 378 52 0 64 438 1 52 89 0
                                              439 1 8 89 0 440 1 118 89 0 441 1
                                              132 89 0 442 1 75 89 0 443 1 381
                                              89 0 444 2 12 89 445 0 446 1 448
                                              0 447 449 4 194 129 213 151 75
                                              448 450 1 129 89 0 451 1 452 0 41
                                              453 1 452 116 0 454 1 64 452 0
                                              455 2 452 0 0 0 456 1 129 89 0
                                              457 1 56 22 13 458 1 8 0 0 459 1
                                              56 22 13 460 2 462 178 461 328
                                              463 6 465 8 464 22 22 8 11 178
                                              466 5 465 8 464 22 8 11 178 467 1
                                              56 75 13 468 1 56 22 13 469 1 464
                                              0 22 470 2 8 0 464 0 471 2 185 0
                                              0 75 472 1 185 89 0 473 1 75 452
                                              0 474 1 452 0 305 475 1 362 116
                                              452 476 2 178 0 0 75 477 1 178 0
                                              0 478 1 178 11 0 479 1 11 452 0
                                              480 1 398 89 0 481 1 398 381 0
                                              482 1 398 0 0 483 2 11 89 8 0 484
                                              1 56 89 13 485 1 486 0 58 487 1
                                              488 0 305 489 1 486 0 58 490 1
                                              486 0 55 491 2 13 0 0 0 492 1 56
                                              116 13 493 1 486 0 22 494 1 486 0
                                              55 495 2 13 0 0 0 496 2 11 0 0 0
                                              497 1 486 0 60 502 1 486 0 89 507
                                              1 13 0 305 508 2 13 0 486 0 513 1
                                              11 89 0 514 1 11 0 0 515 1 0 21
                                              22 516 1 0 21 22 517 1 486 0 60
                                              522 1 0 21 22 525 1 0 21 22 526 1
                                              0 21 22 527 1 56 60 13 528 1 60
                                              452 0 529 2 27 89 22 0 530 2 12
                                              89 6 0 531 2 12 6 0 64 532 2 6 0
                                              0 0 533 1 8 89 0 534 1 118 89 0
                                              535 1 64 89 0 536 1 132 89 0 537
                                              1 75 89 0 538 1 7 89 0 539 1 50
                                              89 0 540 1 52 89 0 541 1 6 89 0
                                              542 1 73 452 0 543 2 22 0 0 544
                                              545 1 486 0 22 546 1 486 0 60 547
                                              2 550 0 8 8 551 2 552 0 22 550
                                              553 2 8 0 0 554 555 2 6 0 0 0 556
                                              2 6 89 0 0 557 2 8 0 0 554 558 1
                                              0 216 13 231 1 1 241 22 323 1 0
                                              216 13 274 1 1 21 22 525 2 0 11
                                              12 13 518 1 0 11 12 519 1 1 21 22
                                              527 2 0 11 12 13 523 1 0 11 12
                                              524 2 0 11 12 13 509 1 0 11 12
                                              510 1 1 21 22 526 1 0 11 12 521 2
                                              0 11 12 13 520 1 1 21 22 517 1 0
                                              11 12 506 2 0 11 12 13 505 2 0 11
                                              12 13 511 1 0 11 12 512 1 1 21 22
                                              24 2 0 11 12 13 17 1 0 11 12 16 1
                                              1 21 22 26 1 0 11 12 19 2 0 11 12
                                              13 20 1 0 11 223 499 2 0 11 223
                                              13 498 1 0 11 12 504 2 0 11 12 13
                                              503 1 1 21 22 516 2 0 11 12 13
                                              500 1 0 11 12 501 2 0 11 12 13
                                              560 1 0 11 12 559 4 0 11 12 548
                                              27 13 549 3 0 11 12 548 27 561 1
                                              1 241 22 242 1 0 216 13 217 2 0
                                              216 223 13 227)))))
           '|lookupComplete|)) 
