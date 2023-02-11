
(SDEFUN |PEVALUT;eval1a;PIRI;1|
        ((|pol| (|Polynomial| (|Integer|))) (|pt| (|Integer|))
         (|pss|
          (|Record| (|:| |prime| (|Integer|))
                    (|:| |eval1coeffbuf| (|U32Vector|))
                    (|:| |eval1expbuf| (|SortedExponentVector|))))
         ($ (|Integer|)))
        (SPROG
         ((|res| (|Integer|)) (|pk| #1=(|SingleInteger|)) (|ptk| (|Integer|))
          (|ki| #2=(|SingleInteger|)) (|j| NIL) (|i| #1#)
          (|t1|
           (|Union| (|Integer|)
                    (|Record| (|:| |v| (|Symbol|))
                              (|:| |ts|
                                   (|List|
                                    (|Record| (|:| |k| (|NonNegativeInteger|))
                                              (|:| |c|
                                                   (|Polynomial|
                                                    (|Integer|)))))))))
          (|ns| #2#) (|n| (|NonNegativeInteger|))
          (|exps| (|SortedExponentVector|)) (|nexps| (|SortedExponentVector|))
          (|coeffs| (|U32Vector|)) (|ncoeffs| (|U32Vector|))
          (|nn| (|NonNegativeInteger|)) (#3=#:G725 NIL) (|t0| NIL)
          (|polu|
           #4=(|List|
               (|Record| (|:| |k| (|NonNegativeInteger|))
                         (|:| |c| (|Polynomial| (|Integer|))))))
          (#5=#:G724 NIL)
          (|polr|
           (|Union| (|Integer|)
                    (|Record| (|:| |v| (|Symbol|)) (|:| |ts| #4#))))
          (|p| (|Integer|)))
         (SEQ
          (EXIT
           (SEQ (LETT |p| (QVELT |pss| 0)) (LETT |polr| |pol|)
                (EXIT
                 (COND
                  ((QEQCAR |polr| 0)
                   (PROGN (LETT #5# (QCDR |polr|)) (GO #6=#:G723)))
                  ('T
                   (SEQ (LETT |polu| (QCDR (QCDR |polr|))) (LETT |i| 0)
                        (LETT |coeffs| (QVELT |pss| 1))
                        (LETT |exps| (QVELT |pss| 2))
                        (LETT |n| (QV_LEN_U32 |coeffs|)) (LETT |ns| |n|)
                        (SEQ (LETT |t0| NIL) (LETT #3# |polu|) G190
                             (COND
                              ((OR (ATOM #3#)
                                   (PROGN (LETT |t0| (CAR #3#)) NIL))
                               (GO G191)))
                             (SEQ
                              (COND
                               ((NULL (|less_SI| |i| |ns|))
                                (SEQ (LETT |nn| (* 2 |n|))
                                     (LETT |ncoeffs| (GETREFV_U32 |nn| 0))
                                     (SPADCALL |ncoeffs| |coeffs| |n|
                                               (QREFELT $ 12))
                                     (LETT |coeffs| |ncoeffs|)
                                     (QSETVELT |pss| 1 |coeffs|)
                                     (LETT |nexps| (GETREFV_U32 |nn| 0))
                                     (SPADCALL |nexps| |exps| |n|
                                               (QREFELT $ 12))
                                     (LETT |exps| |nexps|)
                                     (QSETVELT |pss| 2 |exps|) (LETT |n| |nn|)
                                     (EXIT (LETT |ns| |n|)))))
                              (LETT |t1| (QCDR |t0|))
                              (SETELT_U32 |exps| |i| (QCAR |t0|))
                              (COND
                               ((QEQCAR |t1| 0)
                                (SETELT_U32 |coeffs| |i| (QCDR |t1|)))
                               ('T
                                (|error| "More than one variable in eval1a")))
                              (EXIT (LETT |i| (|add_SI| |i| 1))))
                             (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                        (LETT |res| 0) (LETT |ptk| 1) (LETT |pk| 0)
                        (SEQ (LETT |j| (|sub_SI| |i| 1)) G190
                             (COND ((< |j| 0) (GO G191)))
                             (SEQ (LETT |ki| (ELT_U32 |exps| |j|))
                                  (SEQ G190
                                       (COND
                                        ((NULL (|less_SI| |pk| |ki|))
                                         (GO G191)))
                                       (SEQ
                                        (LETT |ptk|
                                              (QSMULMOD32 |ptk| |pt| |p|))
                                        (EXIT (LETT |pk| (|add_SI| |pk| 1))))
                                       NIL (GO G190) G191 (EXIT NIL))
                                  (EXIT
                                   (LETT |res|
                                         (QSMULADDMOD64_32 |ptk|
                                                           (ELT_U32 |coeffs|
                                                                    |j|)
                                                           |res| |p|))))
                             (LETT |j| (+ |j| -1)) (GO G190) G191 (EXIT NIL))
                        (EXIT |res|)))))))
          #6# (EXIT #5#)))) 

(SDEFUN |PEVALUT;eval1;PSIRP;2|
        ((|pol| (|Polynomial| (|Integer|))) (|vv| (|Symbol|))
         (|pt| (|Integer|))
         (|pss|
          (|Record| (|:| |prime| (|Integer|))
                    (|:| |eval1coeffbuf| (|U32Vector|))
                    (|:| |eval1expbuf| (|SortedExponentVector|))))
         ($ (|Polynomial| (|Integer|))))
        (SPROG
         ((|xr|
           (|Union| (|Integer|)
                    (|Record| (|:| |v| (|Symbol|))
                              (|:| |ts|
                                   (|List|
                                    (|Record| (|:| |k| (|NonNegativeInteger|))
                                              (|:| |c|
                                                   (|Polynomial|
                                                    (|Integer|)))))))))
          (|yu|
           (|List|
            (|Record| (|:| |k| (|NonNegativeInteger|))
                      (|:| |c| (|Polynomial| (|Integer|))))))
          (|c1| (|Polynomial| (|Integer|)))
          (|t1|
           (|Union| (|Integer|)
                    (|Record| (|:| |v| (|Symbol|))
                              (|:| |ts|
                                   (|List|
                                    (|Record| (|:| |k| (|NonNegativeInteger|))
                                              (|:| |c|
                                                   (|Polynomial|
                                                    (|Integer|)))))))))
          (#1=#:G751 NIL) (|t0| NIL)
          (|xu|
           #2=(|List|
               (|Record| (|:| |k| (|NonNegativeInteger|))
                         (|:| |c| (|Polynomial| (|Integer|))))))
          (#3=#:G750 NIL) (|vx| #4=(|Symbol|))
          (|polr|
           (|Union| (|Integer|) (|Record| (|:| |v| #4#) (|:| |ts| #2#)))))
         (SEQ
          (EXIT
           (SEQ (LETT |polr| |pol|)
                (EXIT
                 (COND
                  ((QEQCAR |polr| 0) (PROGN (LETT #3# |pol|) (GO #5=#:G749)))
                  (#6='T
                   (SEQ (LETT |vx| (QCAR (QCDR |polr|)))
                        (EXIT
                         (COND
                          ((EQUAL |vx| |vv|)
                           (PROGN
                            (LETT #3#
                                  (SPADCALL
                                   (SPADCALL |pol| |pt| |pss| (QREFELT $ 15))
                                   (QREFELT $ 16)))
                            (GO #5#)))
                          (#6#
                           (SEQ (LETT |xu| (QCDR (QCDR |polr|)))
                                (LETT |yu| NIL)
                                (SEQ (LETT |t0| NIL) (LETT #1# |xu|) G190
                                     (COND
                                      ((OR (ATOM #1#)
                                           (PROGN (LETT |t0| (CAR #1#)) NIL))
                                       (GO G191)))
                                     (SEQ (LETT |t1| (QCDR |t0|))
                                          (EXIT
                                           (COND
                                            ((QEQCAR |t1| 0)
                                             (LETT |yu|
                                                   (CONS
                                                    (CONS (QCAR |t0|)
                                                          (QCDR |t0|))
                                                    |yu|)))
                                            ('T
                                             (SEQ
                                              (LETT |c1|
                                                    (SPADCALL (QCDR |t0|) |vv|
                                                              |pt| |pss|
                                                              (QREFELT $ 18)))
                                              (EXIT
                                               (COND
                                                ((SPADCALL |c1|
                                                           (|spadConstant| $ 7)
                                                           (QREFELT $ 20))
                                                 (|spadConstant| $ 7))
                                                ('T
                                                 (LETT |yu|
                                                       (CONS
                                                        (CONS (QCAR |t0|) |c1|)
                                                        |yu|))))))))))
                                     (LETT #1# (CDR #1#)) (GO G190) G191
                                     (EXIT NIL))
                                (LETT |xr|
                                      (COND
                                       ((SPADCALL |yu| NIL (QREFELT $ 23))
                                        (CONS 0 0))
                                       (#6#
                                        (CONS 1 (CONS |vx| (NREVERSE |yu|))))))
                                (EXIT |xr|)))))))))))
          #5# (EXIT #3#)))) 

(SDEFUN |PEVALUT;eval1;RSIRU;3|
        ((|pol|
          (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                    (|:| |denom| (|Polynomial| (|Integer|)))))
         (|vv| (|Symbol|)) (|pt| (|Integer|))
         (|pss|
          (|Record| (|:| |prime| (|Integer|))
                    (|:| |eval1coeffbuf| (|U32Vector|))
                    (|:| |eval1expbuf| (|SortedExponentVector|))))
         ($
          (|Union|
           (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                     (|:| |denom| (|Polynomial| (|Integer|))))
           "failed")))
        (SPROG ((|d| (|Polynomial| (|Integer|))))
               (SEQ
                (LETT |d|
                      (SPADCALL (QCDR |pol|) |vv| |pt| |pss| (QREFELT $ 18)))
                (EXIT
                 (COND
                  ((SPADCALL |d| (|spadConstant| $ 7) (QREFELT $ 20))
                   (CONS 1 "failed"))
                  ('T
                   (CONS 0
                         (CONS
                          (SPADCALL (QCAR |pol|) |vv| |pt| |pss|
                                    (QREFELT $ 18))
                          |d|)))))))) 

(SDEFUN |PEVALUT;modpreduction;PIP;4|
        ((|x| (|Polynomial| (|Integer|))) (|p| (|Integer|))
         ($ (|Polynomial| (|Integer|))))
        (SPROG
         ((|xr|
           (|Union| (|Integer|)
                    (|Record| (|:| |v| (|Symbol|))
                              (|:| |ts|
                                   (|List|
                                    (|Record| (|:| |k| (|NonNegativeInteger|))
                                              (|:| |c|
                                                   (|Polynomial|
                                                    (|Integer|)))))))))
          (|yu|
           (|List|
            (|Record| (|:| |k| (|NonNegativeInteger|))
                      (|:| |c| (|Polynomial| (|Integer|))))))
          (|c1| (|Polynomial| (|Integer|))) (|c0| (|Integer|))
          (|t1|
           (|Union| (|Integer|)
                    (|Record| (|:| |v| (|Symbol|))
                              (|:| |ts|
                                   (|List|
                                    (|Record| (|:| |k| (|NonNegativeInteger|))
                                              (|:| |c|
                                                   (|Polynomial|
                                                    (|Integer|)))))))))
          (#1=#:G782 NIL) (|t0| NIL)
          (|xu|
           (|List|
            (|Record| (|:| |k| (|NonNegativeInteger|))
                      (|:| |c| (|Polynomial| (|Integer|))))))
          (|vx| (|Symbol|)))
         (SEQ (LETT |xr| |x|)
              (EXIT
               (COND
                ((QEQCAR |xr| 0)
                 (SEQ (LETT |c0| (SPADCALL (QCDR |xr|) |p| (QREFELT $ 27)))
                      (LETT |xr| (CONS 0 |c0|)) (EXIT |xr|)))
                (#2='T
                 (SEQ (LETT |vx| (QCAR (QCDR |xr|)))
                      (LETT |xu| (QCDR (QCDR |xr|))) (LETT |yu| NIL)
                      (SEQ (LETT |t0| NIL) (LETT #1# |xu|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |t0| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ (LETT |t1| (QCDR |t0|))
                                (EXIT
                                 (COND
                                  ((QEQCAR |t1| 0)
                                   (SEQ
                                    (LETT |c0|
                                          (SPADCALL (QCDR |t1|) |p|
                                                    (QREFELT $ 27)))
                                    (EXIT
                                     (COND ((EQL |c0| 0) (|spadConstant| $ 7))
                                           ('T
                                            (SEQ (LETT |xr| (CONS 0 |c0|))
                                                 (EXIT
                                                  (LETT |yu|
                                                        (CONS
                                                         (CONS (QCAR |t0|)
                                                               |xr|)
                                                         |yu|)))))))))
                                  ('T
                                   (SEQ
                                    (LETT |c1|
                                          (SPADCALL (QCDR |t0|) |p|
                                                    (QREFELT $ 28)))
                                    (EXIT
                                     (COND
                                      ((SPADCALL |c1| (|spadConstant| $ 7)
                                                 (QREFELT $ 20))
                                       (|spadConstant| $ 7))
                                      ('T
                                       (LETT |yu|
                                             (CONS (CONS (QCAR |t0|) |c1|)
                                                   |yu|))))))))))
                           (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                      (LETT |xr|
                            (COND
                             ((SPADCALL |yu| NIL (QREFELT $ 23)) (CONS 0 0))
                             (#2# (CONS 1 (CONS |vx| (NREVERSE |yu|))))))
                      (EXIT |xr|)))))))) 

(SDEFUN |PEVALUT;modpreduction;FIU;5|
        ((|x| (|Fraction| (|Polynomial| (|Integer|)))) (|p| (|Integer|))
         ($
          (|Union|
           (|Record| (|:| |numer| (|Polynomial| (|Integer|)))
                     (|:| |denom| (|Polynomial| (|Integer|))))
           "failed")))
        (SPROG ((|d| (|Polynomial| (|Integer|))))
               (SEQ
                (LETT |d|
                      (SPADCALL (SPADCALL |x| (QREFELT $ 30)) |p|
                                (QREFELT $ 28)))
                (EXIT
                 (COND
                  ((SPADCALL |d| (|spadConstant| $ 7) (QREFELT $ 20))
                   (CONS 1 "failed"))
                  ('T
                   (CONS 0
                         (CONS
                          (SPADCALL (SPADCALL |x| (QREFELT $ 32)) |p|
                                    (QREFELT $ 28))
                          |d|)))))))) 

(SDEFUN |PEVALUT;modpeval;PLL2I;6|
        ((|x| (|Polynomial| (|Integer|))) (|vars| (|List| (|Symbol|)))
         (|pts| (|List| (|Integer|))) (|p| (|Integer|)) ($ (|Integer|)))
        (SPROG
         ((|res| #1=(|Integer|)) (|c0| (|Integer|)) (|kk| #1#)
          (|ptk| (|Integer|)) (|kk1| (|NonNegativeInteger|))
          (|t1|
           (|Union| (|Integer|)
                    (|Record| (|:| |v| (|Symbol|))
                              (|:| |ts|
                                   (|List|
                                    (|Record| (|:| |k| (|NonNegativeInteger|))
                                              (|:| |c|
                                                   (|Polynomial|
                                                    (|Integer|)))))))))
          (#2=#:G810 NIL) (|t0| NIL)
          (|xu|
           (|List|
            (|Record| (|:| |k| (|NonNegativeInteger|))
                      (|:| |c| (|Polynomial| (|Integer|))))))
          (|vxval| (|Integer|)) (#3=#:G809 NIL) (|vx| (|Symbol|))
          (|xr|
           (|Union| (|Integer|)
                    (|Record| (|:| |v| (|Symbol|))
                              (|:| |ts|
                                   (|List|
                                    (|Record| (|:| |k| (|NonNegativeInteger|))
                                              (|:| |c|
                                                   (|Polynomial|
                                                    (|Integer|))))))))))
         (SEQ
          (EXIT
           (SEQ (LETT |xr| |x|)
                (EXIT
                 (COND
                  ((QEQCAR |xr| 0)
                   (PROGN
                    (LETT #3# (SPADCALL (QCDR |xr|) |p| (QREFELT $ 27)))
                    (GO #4=#:G808)))
                  (#5='T
                   (SEQ (LETT |vx| (QCAR (QCDR |xr|)))
                        (EXIT
                         (COND
                          ((SPADCALL |vx| (|SPADfirst| |vars|) (QREFELT $ 34))
                           (PROGN
                            (LETT #3#
                                  (SPADCALL |x| (CDR |vars|) (CDR |pts|) |p|
                                            (QREFELT $ 37)))
                            (GO #4#)))
                          (#5#
                           (SEQ (LETT |vxval| (|SPADfirst| |pts|))
                                (LETT |vars| (CDR |vars|))
                                (LETT |pts| (CDR |pts|))
                                (LETT |xu| (QCDR (QCDR |xr|))) (LETT |ptk| 1)
                                (LETT |kk| 0) (LETT |res| 0)
                                (LETT |xu| (REVERSE |xu|))
                                (SEQ (LETT |t0| NIL) (LETT #2# |xu|) G190
                                     (COND
                                      ((OR (ATOM #2#)
                                           (PROGN (LETT |t0| (CAR #2#)) NIL))
                                       (GO G191)))
                                     (SEQ (LETT |t1| (QCDR |t0|))
                                          (LETT |kk1| (QCAR |t0|))
                                          (SEQ G190
                                               (COND
                                                ((NULL (< |kk| |kk1|))
                                                 (GO G191)))
                                               (SEQ
                                                (LETT |ptk|
                                                      (QSMULMOD32 |vxval| |ptk|
                                                                  |p|))
                                                (EXIT (LETT |kk| (+ |kk| 1))))
                                               NIL (GO G190) G191 (EXIT NIL))
                                          (LETT |c0|
                                                (COND
                                                 ((QEQCAR |t1| 0)
                                                  (SPADCALL (QCDR |t1|) |p|
                                                            (QREFELT $ 27)))
                                                 ('T
                                                  (SPADCALL (QCDR |t0|) |vars|
                                                            |pts| |p|
                                                            (QREFELT $ 37)))))
                                          (EXIT
                                           (LETT |res|
                                                 (QSMULADDMOD64_32 |ptk| |c0|
                                                                   |res|
                                                                   |p|))))
                                     (LETT #2# (CDR #2#)) (GO G190) G191
                                     (EXIT NIL))
                                (EXIT |res|)))))))))))
          #4# (EXIT #3#)))) 

(DECLAIM (NOTINLINE |PolynomialEvaluationUtilities;|)) 

(DEFUN |PolynomialEvaluationUtilities| ()
  (SPROG NIL
         (PROG (#1=#:G812)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache|
                          '|PolynomialEvaluationUtilities|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache|
                             '|PolynomialEvaluationUtilities|
                             (LIST
                              (CONS NIL
                                    (CONS 1
                                          (|PolynomialEvaluationUtilities;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|PolynomialEvaluationUtilities|)))))))))) 

(DEFUN |PolynomialEvaluationUtilities;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|PolynomialEvaluationUtilities|))
          (LETT $ (GETREFV 38))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PolynomialEvaluationUtilities| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PolynomialEvaluationUtilities| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Polynomial| 10) (0 . |Zero|) (|Void|)
              (|U32Vector|) (|Integer|) (|U32VectorPolynomialOperations|)
              (4 . |copy_first|) (11 . |One|)
              (|Record| (|:| |prime| 10) (|:| |eval1coeffbuf| 9)
                        (|:| |eval1expbuf| (|SortedExponentVector|)))
              |PEVALUT;eval1a;PIRI;1| (15 . |coerce|) (|Symbol|)
              |PEVALUT;eval1;PSIRP;2| (|Boolean|) (20 . =)
              (|Record| (|:| |k| (|NonNegativeInteger|)) (|:| |c| 6))
              (|List| 21) (26 . =) (|Record| (|:| |numer| 6) (|:| |denom| 6))
              (|Union| 24 '"failed") |PEVALUT;eval1;RSIRU;3|
              (32 . |positiveRemainder|) |PEVALUT;modpreduction;PIP;4|
              (|Fraction| 6) (38 . |denom|) (43 . |Zero|) (47 . |numer|)
              |PEVALUT;modpreduction;FIU;5| (52 . ~=) (|List| 17) (|List| 10)
              |PEVALUT;modpeval;PLL2I;6|)
           '#(|modpreduction| 58 |modpeval| 70 |eval1a| 78 |eval1| 85) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|eval1a|
                                 ((|Integer|) (|Polynomial| (|Integer|))
                                  (|Integer|)
                                  (|Record| (|:| |prime| (|Integer|))
                                            (|:| |eval1coeffbuf| (|U32Vector|))
                                            (|:| |eval1expbuf|
                                                 (|SortedExponentVector|)))))
                                T)
                              '((|eval1|
                                 ((|Polynomial| (|Integer|))
                                  (|Polynomial| (|Integer|)) (|Symbol|)
                                  (|Integer|)
                                  (|Record| (|:| |prime| (|Integer|))
                                            (|:| |eval1coeffbuf| (|U32Vector|))
                                            (|:| |eval1expbuf|
                                                 (|SortedExponentVector|)))))
                                T)
                              '((|eval1|
                                 ((|Union|
                                   (|Record|
                                    (|:| |numer| (|Polynomial| (|Integer|)))
                                    (|:| |denom| (|Polynomial| (|Integer|))))
                                   "failed")
                                  (|Record|
                                   (|:| |numer| (|Polynomial| (|Integer|)))
                                   (|:| |denom| (|Polynomial| (|Integer|))))
                                  (|Symbol|) (|Integer|)
                                  (|Record| (|:| |prime| (|Integer|))
                                            (|:| |eval1coeffbuf| (|U32Vector|))
                                            (|:| |eval1expbuf|
                                                 (|SortedExponentVector|)))))
                                T)
                              '((|modpreduction|
                                 ((|Polynomial| (|Integer|))
                                  (|Polynomial| (|Integer|)) (|Integer|)))
                                T)
                              '((|modpreduction|
                                 ((|Union|
                                   (|Record|
                                    (|:| |numer| (|Polynomial| (|Integer|)))
                                    (|:| |denom| (|Polynomial| (|Integer|))))
                                   "failed")
                                  (|Fraction| (|Polynomial| (|Integer|)))
                                  (|Integer|)))
                                T)
                              '((|modpeval|
                                 ((|Integer|) (|Polynomial| (|Integer|))
                                  (|List| (|Symbol|)) (|List| (|Integer|))
                                  (|Integer|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 37
                                            '(0 6 0 7 3 11 8 9 9 10 12 0 6 0 13
                                              1 6 0 10 16 2 6 19 0 0 20 2 22 19
                                              0 0 23 2 10 0 0 0 27 1 29 6 0 30
                                              0 29 0 31 1 29 6 0 32 2 17 19 0 0
                                              34 2 0 6 6 10 28 2 0 25 29 10 33
                                              4 0 10 6 35 36 10 37 3 0 10 6 10
                                              14 15 4 0 25 24 17 10 14 26 4 0 6
                                              6 17 10 14 18)))))
           '|lookupComplete|)) 

(MAKEPROP '|PolynomialEvaluationUtilities| 'NILADIC T) 
