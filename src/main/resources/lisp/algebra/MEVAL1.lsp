
(SDEFUN |MEVAL1;degree;PSNni;1|
        ((|p| (|Polynomial| (|Integer|))) (|s| (|Symbol|))
         ($ (|NonNegativeInteger|)))
        (SPADCALL |p| |s| (QREFELT $ 9))) 

(SDEFUN |MEVAL1;ldegree;PSNni;2|
        ((|p| (|Polynomial| (|Integer|))) (|s| (|Symbol|))
         ($ (|NonNegativeInteger|)))
        (SPADCALL |p| |s| (QREFELT $ 9))) 

(SDEFUN |MEVAL1;eval1;PSIRU;3|
        ((|p| #1=(|Polynomial| (|Integer|))) (|v| (|Symbol|))
         (|pt| #2=(|Integer|))
         (|s|
          (|Record| (|:| |prime| #2#) (|:| |eval1coeffbuf| (|U32Vector|))
                    (|:| |eval1expbuf| (|SortedExponentVector|))))
         ($ (|Union| #1# "failed")))
        (CONS 0 (SPADCALL |p| |v| |pt| |s| (QREFELT $ 15)))) 

(SDEFUN |MEVAL1;modpreduction;PIU;4|
        ((|p| #1=(|Polynomial| (|Integer|))) (|q| (|Integer|))
         ($ (|Union| #1# "failed")))
        (CONS 0 (SPADCALL |p| |q| (QREFELT $ 18)))) 

(SDEFUN |MEVAL1;subst_vars;P2LP;5|
        ((|p| (|Polynomial| (|Integer|))) (|ls1| #1=(|List| (|Symbol|)))
         (|ls2| #1#) ($ (|Polynomial| (|Integer|))))
        (SPROG
         ((|lm| (|List| (|Polynomial| (|Integer|)))) (#2=#:G719 NIL) (|v| NIL)
          (#3=#:G718 NIL))
         (SEQ
          (LETT |lm|
                (PROGN
                 (LETT #3# NIL)
                 (SEQ (LETT |v| NIL) (LETT #2# |ls2|) G190
                      (COND
                       ((OR (ATOM #2#) (PROGN (LETT |v| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #3#
                              (CONS
                               (SPADCALL (|spadConstant| $ 20) |v| 1
                                         (QREFELT $ 21))
                               #3#))))
                      (LETT #2# (CDR #2#)) (GO G190) G191
                      (EXIT (NREVERSE #3#)))))
          (EXIT (SPADCALL |p| |ls1| |lm| (QREFELT $ 24)))))) 

(SDEFUN |MEVAL1;trial_division;2PLSLB;6|
        ((|p| #1=(|Polynomial| (|Integer|))) (|g| (|Polynomial| (|Integer|)))
         (|lm| (|List| #1#)) (|v| #2=(|Symbol|)) (|ls| (|List| #2#))
         ($ (|Boolean|)))
        (SPROG ((#3=#:G727 NIL) (|m| NIL) (#4=#:G726 NIL))
               (SEQ
                (SPADCALL |p| |g|
                          (PROGN
                           (LETT #4# NIL)
                           (SEQ (LETT |m| NIL) (LETT #3# |lm|) G190
                                (COND
                                 ((OR (ATOM #3#)
                                      (PROGN (LETT |m| (CAR #3#)) NIL))
                                  (GO G191)))
                                (SEQ (EXIT (LETT #4# (CONS |m| #4#))))
                                (LETT #3# (CDR #3#)) (GO G190) G191
                                (EXIT (NREVERSE #4#))))
                          (LIST |v|) |ls| (QREFELT $ 30))))) 

(DECLAIM (NOTINLINE |ModularEvaluation1;|)) 

(DEFUN |ModularEvaluation1| ()
  (SPROG NIL
         (PROG (#1=#:G729)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|ModularEvaluation1|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|ModularEvaluation1|
                             (LIST
                              (CONS NIL (CONS 1 (|ModularEvaluation1;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|ModularEvaluation1|)))))))))) 

(DEFUN |ModularEvaluation1;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|ModularEvaluation1|))
          (LETT $ (GETREFV 33))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ModularEvaluation1| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ModularEvaluation1| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|NonNegativeInteger|) (|Symbol|)
              (|Polynomial| 12) (0 . |degree|) |MEVAL1;degree;PSNni;1|
              |MEVAL1;ldegree;PSNni;2| (|Integer|)
              (|Record| (|:| |prime| 12) (|:| |eval1coeffbuf| (|U32Vector|))
                        (|:| |eval1expbuf| (|SortedExponentVector|)))
              (|PolynomialEvaluationUtilities|) (6 . |eval1|)
              (|Union| 8 '"failed") |MEVAL1;eval1;PSIRU;3|
              (14 . |modpreduction|) |MEVAL1;modpreduction;PIU;4| (20 . |One|)
              (24 . |monomial|) (|List| 7) (|List| $) (31 . |eval|)
              |MEVAL1;subst_vars;P2LP;5| (|Boolean|)
              (|SparseMultivariatePolynomial| 12 7) (|List| 27) (|PrimGCD|)
              (38 . |alg_trial_division|) (|List| 8)
              |MEVAL1;trial_division;2PLSLB;6|)
           '#(|trial_division| 47 |subst_vars| 56 |modpreduction| 63 |ldegree|
              69 |eval1| 75 |degree| 83)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS '#((|ModularEvaluationCategory| 8 8))
                             (|makeByteWordVec2| 32
                                                 '(2 8 6 0 7 9 4 14 8 8 7 12 13
                                                   15 2 14 8 8 12 18 0 8 0 20 3
                                                   8 0 0 7 6 21 3 8 0 0 22 23
                                                   24 5 29 26 27 27 28 22 22 30
                                                   5 0 26 8 8 31 7 22 32 3 0 8
                                                   8 22 22 25 2 0 16 8 12 19 2
                                                   0 6 8 7 11 4 0 16 8 7 12 13
                                                   17 2 0 6 8 7 10)))))
           '|lookupComplete|)) 

(MAKEPROP '|ModularEvaluation1| 'NILADIC T) 
