
(SDEFUN |MEVAL2;degree;FpSNni;1|
        ((|p| (|FakePolynomial|)) (|s| (|Symbol|)) ($ (|NonNegativeInteger|)))
        (SPADCALL |p| |s| (QREFELT $ 9))) 

(SDEFUN |MEVAL2;ldegree;RSNni;2|
        ((|p|
          (|Record| (|:| |var| (|Symbol|))
                    (|:| |coef|
                         (|SparseUnivariatePolynomial|
                          (|Fraction| (|Polynomial| (|Integer|)))))))
         (|s| (|Symbol|)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|dp2| (|Polynomial| (|Integer|))) (|np2| (|Polynomial| (|Integer|)))
          (|p2| (|Fraction| (|Polynomial| (|Integer|))))
          (|p1|
           (|SparseUnivariatePolynomial|
            (|Fraction| (|Polynomial| (|Integer|))))))
         (SEQ
          (COND ((EQUAL |s| (QCAR |p|)) (|error| "ldegree: s = p.var"))
                (#1='T
                 (SEQ (LETT |p1| (QCDR |p|))
                      (EXIT
                       (COND
                        ((> (SPADCALL |p1| (QREFELT $ 12)) 0)
                         (|error| "ldegree: degree(p1) > 0"))
                        (#1#
                         (SEQ (LETT |p2| (SPADCALL |p1| (QREFELT $ 14)))
                              (LETT |np2| (SPADCALL |p2| (QREFELT $ 16)))
                              (LETT |dp2| (SPADCALL |p2| (QREFELT $ 17)))
                              (EXIT
                               (COND
                                ((> (SPADCALL |dp2| |s| (QREFELT $ 18)) 0)
                                 (|error| "ldegree: degree(dp2, s) > 0"))
                                (#1#
                                 (SPADCALL |np2| |s|
                                           (QREFELT $ 18))))))))))))))) 

(SDEFUN |MEVAL2;eval1;FpSIRU;3|
        ((|p| #1=(|FakePolynomial|)) (|v| (|Symbol|)) (|pt| #2=(|Integer|))
         (|s|
          (|Record| (|:| |prime| #2#) (|:| |eval1coeffbuf| (|U32Vector|))
                    (|:| |eval1expbuf| (|SortedExponentVector|))))
         ($ (|Union| #1# "failed")))
        (SPROG NIL
               (SPADCALL
                (CONS #'|MEVAL2;eval1;FpSIRU;3!0| (VECTOR $ |s| |pt| |v|)) |p|
                (QREFELT $ 27)))) 

(SDEFUN |MEVAL2;eval1;FpSIRU;3!0| ((|c| NIL) ($$ NIL))
        (PROG (|v| |pt| |s| $)
          (LETT |v| (QREFELT $$ 3))
          (LETT |pt| (QREFELT $$ 2))
          (LETT |s| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |c| |v| |pt| |s| (QREFELT $ 24)))))) 

(SDEFUN |MEVAL2;modpreduction;FpIU;4|
        ((|p| #1=(|FakePolynomial|)) (|q| (|Integer|))
         ($ (|Union| #1# "failed")))
        (SPROG NIL
               (SPADCALL
                (CONS #'|MEVAL2;modpreduction;FpIU;4!0| (VECTOR $ |q|)) |p|
                (QREFELT $ 27)))) 

(SDEFUN |MEVAL2;modpreduction;FpIU;4!0| ((|c| NIL) ($$ NIL))
        (PROG (|q| $)
          (LETT |q| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |c| |q| (QREFELT $ 30)))))) 

(SDEFUN |MEVAL2;subst_vars;R2LFp;5|
        ((|p|
          (|Record| (|:| |var| (|Symbol|))
                    (|:| |coef|
                         (|SparseUnivariatePolynomial|
                          (|Fraction| (|Polynomial| (|Integer|)))))))
         (|ls1| #1=(|List| (|Symbol|))) (|ls2| #1#) ($ (|FakePolynomial|)))
        (SPROG
         ((|res1| (|FakePolynomial|))
          (|lm| (|List| (|Polynomial| (|Integer|)))) (#2=#:G755 NIL) (|v| NIL)
          (#3=#:G754 NIL))
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
                               (SPADCALL (|spadConstant| $ 32) |v| 1
                                         (QREFELT $ 33))
                               #3#))))
                      (LETT #2# (CDR #2#)) (GO G190) G191
                      (EXIT (NREVERSE #3#)))))
          (LETT |res1|
                (SPADCALL
                 (CONS #'|MEVAL2;subst_vars;R2LFp;5!0| (VECTOR $ |lm| |ls1|))
                 |p| (QREFELT $ 37)))
          (EXIT (SPADCALL |res1| |ls1| |ls2| (QREFELT $ 38)))))) 

(SDEFUN |MEVAL2;subst_vars;R2LFp;5!0| ((|c| NIL) ($$ NIL))
        (PROG (|ls1| |lm| $)
          (LETT |ls1| (QREFELT $$ 2))
          (LETT |lm| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |c| |ls1| |lm| (QREFELT $ 36)))))) 

(SDEFUN |MEVAL2;m_reduc|
        ((|x1| (|Fraction| (|Polynomial| (|Integer|))))
         (|lmu|
          (|List|
           (|SparseUnivariatePolynomial|
            (|Fraction| (|Polynomial| (|Integer|))))))
         (|ls| (|List| (|Symbol|)))
         ($ (|Fraction| (|Polynomial| (|Integer|)))))
        (SPROG
         ((|q|
           (|SparseUnivariatePolynomial|
            (|Fraction| (|Polynomial| (|Integer|)))))
          (#1=#:G761 NIL) (|s| NIL) (#2=#:G762 NIL) (|m| NIL))
         (SEQ
          (SEQ (LETT |m| NIL) (LETT #2# |lmu|) (LETT |s| NIL) (LETT #1# |ls|)
               G190
               (COND
                ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL) (ATOM #2#)
                     (PROGN (LETT |m| (CAR #2#)) NIL))
                 (GO G191)))
               (SEQ (LETT |q| (SPADCALL |x1| |s| |m| (QREFELT $ 44)))
                    (EXIT
                     (LETT |x1|
                           (SPADCALL
                            (SPADCALL |q| (QREFELT $ 42)
                                      (SPADCALL
                                       (SPADCALL (SPADCALL |s| (QREFELT $ 45))
                                                 (QREFELT $ 46))
                                       (QREFELT $ 47))
                                      (QREFELT $ 48))
                            (QREFELT $ 49)))))
               (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#)))) (GO G190) G191
               (EXIT NIL))
          (EXIT |x1|)))) 

(SDEFUN |MEVAL2;trial_division;FpPLSLB;7|
        ((|p| #1=(|FakePolynomial|)) (|g| (|Polynomial| (|Integer|)))
         (|lm| (|List| #1#)) (|v| #2=(|Symbol|)) (|ls| (|List| #2#))
         ($ (|Boolean|)))
        (SPROG
         ((#3=#:G781 NIL)
          (|pu|
           (|SparseUnivariatePolynomial|
            (|Fraction| (|Polynomial| (|Integer|)))))
          (|c1| (|Fraction| (|Polynomial| (|Integer|))))
          (|lcp| #4=(|Fraction| (|Polynomial| (|Integer|)))) (#5=#:G773 NIL)
          (|dp| #6=(|NonNegativeInteger|))
          (|lmu|
           (|List|
            (|SparseUnivariatePolynomial|
             (|Fraction| (|Polynomial| (|Integer|))))))
          (#7=#:G783 NIL) (|m| NIL) (#8=#:G784 NIL) (|s| NIL) (#9=#:G782 NIL)
          (|rgu|
           (|SparseUnivariatePolynomial|
            (|Fraction| (|Polynomial| (|Integer|)))))
          (|dg| #6#) (|lcg| #4#)
          (|gu|
           (|SparseUnivariatePolynomial|
            (|Fraction| (|Polynomial| (|Integer|)))))
          (|gu1| (|SparseUnivariatePolynomial| (|Polynomial| (|Integer|)))))
         (SEQ
          (EXIT
           (SEQ (LETT |gu1| (SPADCALL |g| |v| (QREFELT $ 51)))
                (LETT |gu| (SPADCALL (ELT $ 46) |gu1| (QREFELT $ 55)))
                (LETT |pu| (SPADCALL |p| (QREFELT $ 56)))
                (LETT |lcg| (SPADCALL |gu| (QREFELT $ 57)))
                (LETT |dg| (SPADCALL |gu| (QREFELT $ 12)))
                (LETT |rgu| (SPADCALL |gu| (QREFELT $ 58)))
                (LETT |lmu|
                      (PROGN
                       (LETT #9# NIL)
                       (SEQ (LETT |s| NIL) (LETT #8# |ls|) (LETT |m| NIL)
                            (LETT #7# |lm|) G190
                            (COND
                             ((OR (ATOM #7#) (PROGN (LETT |m| (CAR #7#)) NIL)
                                  (ATOM #8#) (PROGN (LETT |s| (CAR #8#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #9#
                                    (CONS
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL (SPADCALL |m| (QREFELT $ 56))
                                                 (QREFELT $ 14))
                                       |s| (QREFELT $ 60))
                                      (QREFELT $ 61))
                                     #9#))))
                            (LETT #7# (PROG1 (CDR #7#) (LETT #8# (CDR #8#))))
                            (GO G190) G191 (EXIT (NREVERSE #9#)))))
                (SEQ G190
                     (COND
                      ((NULL
                        (SEQ (LETT |dp| (SPADCALL |pu| (QREFELT $ 12)))
                             (EXIT
                              (NULL
                               (OR (< |dp| |dg|)
                                   (SPADCALL |pu| (|spadConstant| $ 64)
                                             (QREFELT $ 66)))))))
                       (GO G191)))
                     (SEQ (LETT |lcp| (SPADCALL |pu| (QREFELT $ 57)))
                          (LETT |c1|
                                (|MEVAL2;m_reduc|
                                 (SPADCALL |lcp| |lcg| (QREFELT $ 67)) |lmu|
                                 |ls| $))
                          (EXIT
                           (LETT |pu|
                                 (SPADCALL (SPADCALL |pu| (QREFELT $ 58))
                                           (SPADCALL
                                            (SPADCALL |c1|
                                                      (PROG1
                                                          (LETT #5#
                                                                (- |dp| |dg|))
                                                        (|check_subtype2|
                                                         (>= #5# 0)
                                                         '(|NonNegativeInteger|)
                                                         '(|Integer|) #5#))
                                                      (QREFELT $ 68))
                                            |rgu| (QREFELT $ 69))
                                           (QREFELT $ 70)))))
                     NIL (GO G190) G191 (EXIT NIL))
                (SEQ G190
                     (COND
                      ((NULL
                        (NULL
                         (SPADCALL |pu| (|spadConstant| $ 64) (QREFELT $ 66))))
                       (GO G191)))
                     (SEQ (LETT |lcp| (SPADCALL |pu| (QREFELT $ 57)))
                          (LETT |c1| (|MEVAL2;m_reduc| |lcp| |lmu| |ls| $))
                          (EXIT
                           (COND
                            ((SPADCALL |c1| (|spadConstant| $ 62)
                                       (QREFELT $ 71))
                             (LETT |pu| (SPADCALL |pu| (QREFELT $ 58))))
                            ('T (PROGN (LETT #3# NIL) (GO #10=#:G780))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT 'T)))
          #10# (EXIT #3#)))) 

(DECLAIM (NOTINLINE |ModularEvaluation2;|)) 

(DEFUN |ModularEvaluation2| ()
  (SPROG NIL
         (PROG (#1=#:G788)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|ModularEvaluation2|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|ModularEvaluation2|
                             (LIST
                              (CONS NIL (CONS 1 (|ModularEvaluation2;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|ModularEvaluation2|)))))))))) 

(DEFUN |ModularEvaluation2;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|ModularEvaluation2|))
          (LETT $ (GETREFV 74))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ModularEvaluation2| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 42 (SPADCALL (QREFELT $ 41)))
          $))) 

(MAKEPROP '|ModularEvaluation2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|NonNegativeInteger|) (|Symbol|)
              (|FakePolynomial|) (0 . |degree|) |MEVAL2;degree;FpSNni;1|
              (|SparseUnivariatePolynomial| 13) (6 . |degree|) (|Fraction| 15)
              (11 . |ground|) (|Polynomial| 21) (16 . |numer|) (21 . |denom|)
              (26 . |degree|) (|Record| (|:| |var| 7) (|:| |coef| 11))
              |MEVAL2;ldegree;RSNni;2| (|Integer|)
              (|Record| (|:| |prime| 21) (|:| |eval1coeffbuf| (|U32Vector|))
                        (|:| |eval1expbuf| (|SortedExponentVector|)))
              (|PolynomialEvaluationUtilities|) (32 . |eval1|)
              (|Union| $ '"failed") (|Mapping| 15 15) (40 . |map|)
              (|Union| 8 '"failed") |MEVAL2;eval1;FpSIRU;3|
              (46 . |modpreduction|) |MEVAL2;modpreduction;FpIU;4| (52 . |One|)
              (56 . |monomial|) (|List| 7) (|List| $) (63 . |eval|)
              (70 . |map|) (76 . |subst_var|) |MEVAL2;subst_vars;R2LFp;5|
              (|SingletonAsOrderedSet|) (83 . |create|) '|sas|
              (|PolynomialCategoryQuotientFunctions| (|IndexedExponents| 7) 7
                                                     21 15 13)
              (87 . |univariate|) (94 . |coerce|) (99 . |coerce|)
              (104 . |coerce|) (109 . |eval|) (116 . |retract|)
              (|SparseUnivariatePolynomial| $) (121 . |univariate|)
              (|Mapping| 13 15) (|SparseUnivariatePolynomial| 15)
              (|SparseUnivariatePolynomialFunctions2| 15 13) (127 . |map|)
              (133 . |to_UP|) (138 . |leadingCoefficient|) (143 . |reductum|)
              (|Fraction| 11) (148 . |univariate|) (154 . |numer|)
              (159 . |Zero|) (163 . |Zero|) (167 . |Zero|) (|Boolean|)
              (171 . =) (177 . /) (183 . |monomial|) (189 . *) (195 . -)
              (201 . =) (|List| 8) |MEVAL2;trial_division;FpPLSLB;7|)
           '#(|trial_division| 207 |subst_vars| 216 |modpreduction| 223
              |ldegree| 229 |eval1| 235 |degree| 243)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS '#((|ModularEvaluationCategory| 19 8))
                             (|makeByteWordVec2| 73
                                                 '(2 8 6 0 7 9 1 11 6 0 12 1 11
                                                   13 0 14 1 13 15 0 16 1 13 15
                                                   0 17 2 15 6 0 7 18 4 23 15
                                                   15 7 21 22 24 2 8 25 26 0 27
                                                   2 23 15 15 21 30 0 15 0 32 3
                                                   15 0 0 7 6 33 3 15 0 0 34 35
                                                   36 2 8 0 26 19 37 3 8 0 0 34
                                                   34 38 0 40 0 41 3 43 11 13 7
                                                   11 44 1 15 0 7 45 1 13 0 15
                                                   46 1 11 0 13 47 3 11 0 0 40
                                                   0 48 1 11 13 0 49 2 15 50 0
                                                   7 51 2 54 11 52 53 55 1 8 11
                                                   0 56 1 11 13 0 57 1 11 0 0
                                                   58 2 43 59 13 7 60 1 59 11 0
                                                   61 0 13 0 62 0 15 0 63 0 11
                                                   0 64 2 11 65 0 0 66 2 13 0 0
                                                   0 67 2 11 0 13 6 68 2 11 0 0
                                                   0 69 2 11 0 0 0 70 2 13 65 0
                                                   0 71 5 0 65 8 15 72 7 34 73
                                                   3 0 8 19 34 34 39 2 0 28 8
                                                   21 31 2 0 6 19 7 20 4 0 28 8
                                                   7 21 22 29 2 0 6 8 7 10)))))
           '|lookupComplete|)) 

(MAKEPROP '|ModularEvaluation2| 'NILADIC T) 
