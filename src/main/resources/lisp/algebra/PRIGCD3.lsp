
(SDEFUN |PRIGCD3;lcx0;SmpLR;1|
        ((|p| (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))
         (|xvars| (|List| (|Symbol|)))
         ($
          (|Record|
           (|:| |lcx0lc|
                (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))
           (|:| |lcx0m|
                (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|))))))
        (SPROG
         ((#1=#:G733 NIL)
          (|pr|
           (|Record|
            (|:| |lcx0lc|
                 (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))
            (|:| |lcx0m|
                 (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))))
          (|t0|
           (|Record| (|:| |k| (|NonNegativeInteger|))
                     (|:| |c|
                          (|SparseMultivariatePolynomial| (|Integer|)
                                                          (|Symbol|)))))
          (|vx| (|Symbol|))
          (|xr|
           (|Union| (|Integer|)
                    (|Record| (|:| |v| (|Symbol|))
                              (|:| |ts|
                                   (|List|
                                    (|Record| (|:| |k| (|NonNegativeInteger|))
                                              (|:| |c|
                                                   (|SparseMultivariatePolynomial|
                                                    (|Integer|)
                                                    (|Symbol|))))))))))
         (SEQ
          (EXIT
           (COND ((NULL |xvars|) (CONS |p| (|spadConstant| $ 7)))
                 (#2='T
                  (SEQ (LETT |xr| |p|)
                       (EXIT
                        (COND ((QEQCAR |xr| 0) (CONS |p| (|spadConstant| $ 7)))
                              (#2#
                               (SEQ (LETT |vx| (QCAR (QCDR |xr|)))
                                    (SEQ G190
                                         (COND
                                          ((NULL (NULL (NULL |xvars|)))
                                           (GO G191)))
                                         (SEQ
                                          (EXIT
                                           (COND
                                            ((EQUAL |vx| (|SPADfirst| |xvars|))
                                             (SEQ
                                              (LETT |t0|
                                                    (|SPADfirst|
                                                     (QCDR (QCDR |xr|))))
                                              (LETT |pr|
                                                    (SPADCALL (QCDR |t0|)
                                                              (CDR |xvars|)
                                                              (QREFELT $ 10)))
                                              (EXIT
                                               (PROGN
                                                (LETT #1#
                                                      (CONS (QCAR |pr|)
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (|spadConstant| $
                                                                              7)
                                                              |vx| (QCAR |t0|)
                                                              (QREFELT $ 13))
                                                             (QCDR |pr|)
                                                             (QREFELT $ 14))))
                                                (GO #3=#:G732)))))
                                            ('T
                                             (LETT |xvars| (CDR |xvars|))))))
                                         NIL (GO G190) G191 (EXIT NIL))
                                    (EXIT
                                     (CONS |p| (|spadConstant| $ 7)))))))))))
          #3# (EXIT #1#)))) 

(SDEFUN |PRIGCD3;lcz;SmpSR;2|
        ((|p| (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))
         (|z| (|Symbol|))
         ($
          (|Record|
           (|:| |lczlc|
                (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))
           (|:| |k| (|Integer|)))))
        (SPROG
         ((|xr|
           (|Union| (|Integer|)
                    (|Record| (|:| |v| (|Symbol|))
                              (|:| |ts|
                                   (|List|
                                    (|Record| (|:| |k| (|NonNegativeInteger|))
                                              (|:| |c|
                                                   (|SparseMultivariatePolynomial|
                                                    (|Integer|)
                                                    (|Symbol|)))))))))
          (|yu|
           (|List|
            (|Record| (|:| |k| (|NonNegativeInteger|))
                      (|:| |c|
                           (|SparseMultivariatePolynomial| (|Integer|)
                                                           (|Symbol|))))))
          (|zdeg| (|Integer|))
          (|pr|
           (|Record|
            (|:| |lczlc|
                 (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))
            (|:| |k| (|Integer|))))
          (#1=#:G752 NIL)
          (|t0|
           (|Record| (|:| |k| (|NonNegativeInteger|))
                     (|:| |c|
                          (|SparseMultivariatePolynomial| (|Integer|)
                                                          (|Symbol|)))))
          (|xu|
           (|List|
            (|Record| (|:| |k| (|NonNegativeInteger|))
                      (|:| |c|
                           (|SparseMultivariatePolynomial| (|Integer|)
                                                           (|Symbol|))))))
          (|vx| (|Symbol|)))
         (SEQ (LETT |xr| |p|)
              (EXIT
               (COND ((QEQCAR |xr| 0) (CONS |p| 0))
                     (#2='T
                      (SEQ (LETT |vx| (QCAR (QCDR |xr|)))
                           (LETT |xu| (QCDR (QCDR |xr|)))
                           (EXIT
                            (COND
                             ((EQUAL |vx| |z|)
                              (SEQ (LETT |t0| (|SPADfirst| |xu|))
                                   (EXIT (CONS (QCDR |t0|) (QCAR |t0|)))))
                             (#2#
                              (SEQ (LETT |zdeg| 0) (LETT |yu| NIL)
                                   (SEQ (LETT #1# |xu|) G190
                                        (COND
                                         ((OR (ATOM #1#)
                                              (PROGN
                                               (LETT |t0| (CAR #1#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (LETT |pr|
                                               (SPADCALL (QCDR |t0|) |z|
                                                         (QREFELT $ 17)))
                                         (EXIT
                                          (COND
                                           ((> |zdeg| (QCDR |pr|)) "iterate")
                                           ('T
                                            (SEQ
                                             (COND
                                              ((< |zdeg| (QCDR |pr|))
                                               (SEQ (LETT |yu| NIL)
                                                    (EXIT
                                                     (LETT |zdeg|
                                                           (QCDR |pr|))))))
                                             (EXIT
                                              (LETT |yu|
                                                    (CONS
                                                     (CONS (QCAR |t0|)
                                                           (QCAR |pr|))
                                                     |yu|))))))))
                                        (LETT #1# (CDR #1#)) (GO G190) G191
                                        (EXIT NIL))
                                   (LETT |xr|
                                         (CONS 1 (CONS |vx| (REVERSE |yu|))))
                                   (EXIT (CONS |xr| |zdeg|))))))))))))) 

(SDEFUN |PRIGCD3;coeffs0;SmpL2L;3|
        ((|p| (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))
         (|xvars| (|List| (|Symbol|)))
         (|acc|
          (|List| (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|))))
         ($ (|List| (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))))
        (SPROG
         ((#1=#:G768 NIL) (#2=#:G769 NIL) (|t0| NIL)
          (|lp|
           (|List|
            (|Record| (|:| |k| (|NonNegativeInteger|))
                      (|:| |c|
                           (|SparseMultivariatePolynomial| (|Integer|)
                                                           (|Symbol|))))))
          (|vx| (|Symbol|))
          (|xr|
           (|Union| (|Integer|)
                    (|Record| (|:| |v| (|Symbol|))
                              (|:| |ts|
                                   (|List|
                                    (|Record| (|:| |k| (|NonNegativeInteger|))
                                              (|:| |c|
                                                   (|SparseMultivariatePolynomial|
                                                    (|Integer|)
                                                    (|Symbol|))))))))))
         (SEQ
          (EXIT
           (SEQ (LETT |xr| |p|)
                (EXIT
                 (COND ((QEQCAR |xr| 0) (CONS |p| |acc|))
                       ('T
                        (SEQ (LETT |vx| (QCAR (QCDR |xr|)))
                             (SEQ G190
                                  (COND
                                   ((NULL (NULL (NULL |xvars|))) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((EQUAL |vx| (|SPADfirst| |xvars|))
                                      (SEQ (LETT |lp| (QCDR (QCDR |xr|)))
                                           (SEQ (LETT |t0| NIL) (LETT #2# |lp|)
                                                G190
                                                (COND
                                                 ((OR (ATOM #2#)
                                                      (PROGN
                                                       (LETT |t0| (CAR #2#))
                                                       NIL))
                                                  (GO G191)))
                                                (SEQ
                                                 (EXIT
                                                  (LETT |acc|
                                                        (SPADCALL (QCDR |t0|)
                                                                  (CDR |xvars|)
                                                                  |acc|
                                                                  (QREFELT $
                                                                           19)))))
                                                (LETT #2# (CDR #2#)) (GO G190)
                                                G191 (EXIT NIL))
                                           (EXIT
                                            (PROGN
                                             (LETT #1# |acc|)
                                             (GO #3=#:G767)))))
                                     ('T (LETT |xvars| (CDR |xvars|))))))
                                  NIL (GO G190) G191 (EXIT NIL))
                             (EXIT (CONS |p| |acc|))))))))
          #3# (EXIT #1#)))) 

(SDEFUN |PRIGCD3;coeffs1;SmpLL;4|
        ((|p| (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))
         (|xvars| (|List| (|Symbol|)))
         ($ (|List| (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))))
        (SPADCALL |p| |xvars| NIL (QREFELT $ 19))) 

(SDEFUN |PRIGCD3;alg_reduce0;2SmpLSSmp;5|
        ((|p| (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))
         (|m| (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))
         (|xvars| (|List| (|Symbol|))) (|z| (|Symbol|))
         ($ (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|))))
        (SPROG
         ((#1=#:G788 NIL)
          (|mlc1| (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))
          (#2=#:G774 NIL)
          (|alc| #3=(|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))
          (|g| (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))
          (#4=#:G794 NIL) (|degp| #5=(|Integer|))
          (|plcr| #6=(|Record| (|:| |lczlc| #3#) (|:| |k| #5#))) (|mlc| #3#)
          (|degm| #5#) (|mlcr| #6#))
         (SEQ
          (EXIT
           (SEQ (LETT |mlcr| (SPADCALL |m| |z| (QREFELT $ 17)))
                (LETT |degm| (QCDR |mlcr|)) (LETT |mlc| (QCAR |mlcr|))
                (EXIT
                 (SEQ G190 NIL
                      (SEQ (LETT |plcr| (SPADCALL |p| |z| (QREFELT $ 17)))
                           (LETT |degp| (QCDR |plcr|))
                           (EXIT
                            (COND
                             ((< |degp| |degm|)
                              (PROGN (LETT #4# |p|) (GO #7=#:G793)))
                             ('T
                              (SEQ (LETT |alc| (QCAR |plcr|))
                                   (LETT |g|
                                         (SPADCALL
                                          (CONS |mlc|
                                                (SPADCALL |alc| |xvars|
                                                          (QREFELT $ 20)))
                                          (QREFELT $ 22)))
                                   (LETT |alc|
                                         (PROG2
                                             (LETT #2#
                                                   (SPADCALL |alc| |g|
                                                             (QREFELT $ 24)))
                                             (QCDR #2#)
                                           (|check_union2| (QEQCAR #2# 0)
                                                           (|SparseMultivariatePolynomial|
                                                            (|Integer|)
                                                            (|Symbol|))
                                                           (|Union|
                                                            (|SparseMultivariatePolynomial|
                                                             (|Integer|)
                                                             (|Symbol|))
                                                            #8="failed")
                                                           #2#)))
                                   (LETT |mlc1|
                                         (PROG2
                                             (LETT #2#
                                                   (SPADCALL |mlc| |g|
                                                             (QREFELT $ 24)))
                                             (QCDR #2#)
                                           (|check_union2| (QEQCAR #2# 0)
                                                           (|SparseMultivariatePolynomial|
                                                            (|Integer|)
                                                            (|Symbol|))
                                                           (|Union|
                                                            (|SparseMultivariatePolynomial|
                                                             (|Integer|)
                                                             (|Symbol|))
                                                            #8#)
                                                           #2#)))
                                   (EXIT
                                    (LETT |p|
                                          (SPADCALL
                                           (SPADCALL |mlc1| |p| (QREFELT $ 14))
                                           (SPADCALL
                                            (SPADCALL |alc|
                                                      (SPADCALL
                                                       (|spadConstant| $ 7) |z|
                                                       (PROG1
                                                           (LETT #1#
                                                                 (- |degp|
                                                                    |degm|))
                                                         (|check_subtype2|
                                                          (>= #1# 0)
                                                          '(|NonNegativeInteger|)
                                                          '(|Integer|) #1#))
                                                       (QREFELT $ 13))
                                                      (QREFELT $ 14))
                                            |m| (QREFELT $ 14))
                                           (QREFELT $ 25)))))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #7# (EXIT #4#)))) 

(SDEFUN |PRIGCD3;alg_reduce;SmpL2LSmp;6|
        ((|p| (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))
         (|lm|
          (|List| (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|))))
         (|xvars| (|List| (|Symbol|))) (|zvars| (|List| (|Symbol|)))
         ($ (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|))))
        (SPROG ((#1=#:G799 NIL) (|m| NIL) (#2=#:G800 NIL) (|z| NIL))
               (SEQ
                (SEQ (LETT |z| NIL) (LETT #2# |zvars|) (LETT |m| NIL)
                     (LETT #1# |lm|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |m| (CAR #1#)) NIL)
                           (ATOM #2#) (PROGN (LETT |z| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |p|
                             (SPADCALL |p| |m| |xvars| |z| (QREFELT $ 26)))))
                     (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                     (GO G190) G191 (EXIT NIL))
                (EXIT |p|)))) 

(SDEFUN |PRIGCD3;alg_trial_division;2SmpL2LB;7|
        ((|a| (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))
         (|b| (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))
         (|lm|
          (|List| (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|))))
         (|xvars| (|List| (|Symbol|))) (|zvars| (|List| (|Symbol|)))
         ($ (|Boolean|)))
        (SPROG
         ((|s| (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))
          (#1=#:G804 NIL)
          (|alc| #2=(|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))
          (|g| (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))
          (#3=#:G811 NIL)
          (|mquo|
           (|Union| (|SparseMultivariatePolynomial| (|Integer|) (|Symbol|))
                    #4="failed"))
          (|alm| #5=(|SparseMultivariatePolynomial| (|Integer|) (|Symbol|)))
          (|alcr| #6=(|Record| (|:| |lcx0lc| #2#) (|:| |lcx0m| #5#)))
          (|blm| #5#) (|blc| #2#) (|blcr| #6#))
         (SEQ
          (EXIT
           (SEQ (LETT |blcr| (SPADCALL |b| |xvars| (QREFELT $ 10)))
                (LETT |blc| (QCAR |blcr|)) (LETT |blm| (QCDR |blcr|))
                (EXIT
                 (SEQ G190 NIL
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL |a| (|spadConstant| $ 15) (QREFELT $ 29))
                          (PROGN (LETT #3# 'T) (GO #7=#:G810)))
                         ('T
                          (SEQ
                           (LETT |alcr| (SPADCALL |a| |xvars| (QREFELT $ 10)))
                           (LETT |alc| (QCAR |alcr|))
                           (LETT |alm| (QCDR |alcr|))
                           (LETT |mquo| (SPADCALL |alm| |blm| (QREFELT $ 24)))
                           (EXIT
                            (COND
                             ((QEQCAR |mquo| 1)
                              (PROGN (LETT #3# NIL) (GO #7#)))
                             ('T
                              (SEQ
                               (LETT |g|
                                     (SPADCALL
                                      (CONS |blc|
                                            (SPADCALL |alc| |zvars|
                                                      (QREFELT $ 20)))
                                      (QREFELT $ 22)))
                               (LETT |alc|
                                     (PROG2
                                         (LETT #1#
                                               (SPADCALL |alc| |g|
                                                         (QREFELT $ 24)))
                                         (QCDR #1#)
                                       (|check_union2| (QEQCAR #1# 0)
                                                       (|SparseMultivariatePolynomial|
                                                        (|Integer|) (|Symbol|))
                                                       (|Union|
                                                        (|SparseMultivariatePolynomial|
                                                         (|Integer|)
                                                         (|Symbol|))
                                                        #4#)
                                                       #1#)))
                               (LETT |s|
                                     (PROG2
                                         (LETT #1#
                                               (SPADCALL |blc| |g|
                                                         (QREFELT $ 24)))
                                         (QCDR #1#)
                                       (|check_union2| (QEQCAR #1# 0)
                                                       (|SparseMultivariatePolynomial|
                                                        (|Integer|) (|Symbol|))
                                                       (|Union|
                                                        (|SparseMultivariatePolynomial|
                                                         (|Integer|)
                                                         (|Symbol|))
                                                        #4#)
                                                       #1#)))
                               (EXIT
                                (LETT |a|
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL |s| |a| (QREFELT $ 14))
                                        (SPADCALL
                                         (SPADCALL |alc| (QCDR |mquo|)
                                                   (QREFELT $ 14))
                                         |b| (QREFELT $ 14))
                                        (QREFELT $ 25))
                                       |lm| |xvars| |zvars|
                                       (QREFELT $ 27)))))))))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #7# (EXIT #3#)))) 

(DECLAIM (NOTINLINE |PrimGCD;|)) 

(DEFUN |PrimGCD| ()
  (SPROG NIL
         (PROG (#1=#:G813)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|PrimGCD|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|PrimGCD|
                             (LIST (CONS NIL (CONS 1 (|PrimGCD;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|PrimGCD|)))))))))) 

(DEFUN |PrimGCD;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|PrimGCD|))
          (LETT $ (GETREFV 31))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PrimGCD| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PrimGCD| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL
              (|SparseMultivariatePolynomial| (|Integer|) 11) (0 . |One|)
              (|Record| (|:| |lcx0lc| 6) (|:| |lcx0m| 6)) (|List| 11)
              |PRIGCD3;lcx0;SmpLR;1| (|Symbol|) (|NonNegativeInteger|)
              (4 . |monomial|) (11 . *) (17 . |Zero|)
              (|Record| (|:| |lczlc| 6) (|:| |k| (|Integer|)))
              |PRIGCD3;lcz;SmpSR;2| (|List| 6) |PRIGCD3;coeffs0;SmpL2L;3|
              |PRIGCD3;coeffs1;SmpLL;4| (|List| $) (21 . |gcd|)
              (|Union| $ '"failed") (26 . |exquo|) (32 . -)
              |PRIGCD3;alg_reduce0;2SmpLSSmp;5|
              |PRIGCD3;alg_reduce;SmpL2LSmp;6| (|Boolean|) (38 . =)
              |PRIGCD3;alg_trial_division;2SmpL2LB;7|)
           '#(|lcz| 44 |lcx0| 50 |coeffs1| 56 |coeffs0| 62 |alg_trial_division|
              69 |alg_reduce0| 78 |alg_reduce| 86)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|lcx0|
                                 ((|Record|
                                   (|:| |lcx0lc|
                                        (|SparseMultivariatePolynomial|
                                         (|Integer|) (|Symbol|)))
                                   (|:| |lcx0m|
                                        (|SparseMultivariatePolynomial|
                                         (|Integer|) (|Symbol|))))
                                  (|SparseMultivariatePolynomial| (|Integer|)
                                                                  (|Symbol|))
                                  (|List| (|Symbol|))))
                                T)
                              '((|lcz|
                                 ((|Record|
                                   (|:| |lczlc|
                                        (|SparseMultivariatePolynomial|
                                         (|Integer|) (|Symbol|)))
                                   (|:| |k| (|Integer|)))
                                  (|SparseMultivariatePolynomial| (|Integer|)
                                                                  (|Symbol|))
                                  (|Symbol|)))
                                T)
                              '((|coeffs0|
                                 ((|List|
                                   (|SparseMultivariatePolynomial| (|Integer|)
                                                                   (|Symbol|)))
                                  (|SparseMultivariatePolynomial| (|Integer|)
                                                                  (|Symbol|))
                                  (|List| (|Symbol|))
                                  (|List|
                                   (|SparseMultivariatePolynomial| (|Integer|)
                                                                   (|Symbol|)))))
                                T)
                              '((|coeffs1|
                                 ((|List|
                                   (|SparseMultivariatePolynomial| (|Integer|)
                                                                   (|Symbol|)))
                                  (|SparseMultivariatePolynomial| (|Integer|)
                                                                  (|Symbol|))
                                  (|List| (|Symbol|))))
                                T)
                              '((|alg_reduce0|
                                 ((|SparseMultivariatePolynomial| (|Integer|)
                                                                  (|Symbol|))
                                  (|SparseMultivariatePolynomial| (|Integer|)
                                                                  (|Symbol|))
                                  (|SparseMultivariatePolynomial| (|Integer|)
                                                                  (|Symbol|))
                                  (|List| (|Symbol|)) (|Symbol|)))
                                T)
                              '((|alg_reduce|
                                 ((|SparseMultivariatePolynomial| (|Integer|)
                                                                  (|Symbol|))
                                  (|SparseMultivariatePolynomial| (|Integer|)
                                                                  (|Symbol|))
                                  (|List|
                                   (|SparseMultivariatePolynomial| (|Integer|)
                                                                   (|Symbol|)))
                                  (|List| (|Symbol|)) (|List| (|Symbol|))))
                                T)
                              '((|alg_trial_division|
                                 ((|Boolean|)
                                  (|SparseMultivariatePolynomial| (|Integer|)
                                                                  (|Symbol|))
                                  (|SparseMultivariatePolynomial| (|Integer|)
                                                                  (|Symbol|))
                                  (|List|
                                   (|SparseMultivariatePolynomial| (|Integer|)
                                                                   (|Symbol|)))
                                  (|List| (|Symbol|)) (|List| (|Symbol|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 30
                                            '(0 6 0 7 3 6 0 0 11 12 13 2 6 0 0
                                              0 14 0 6 0 15 1 6 0 21 22 2 6 23
                                              0 0 24 2 6 0 0 0 25 2 6 28 0 0 29
                                              2 0 16 6 11 17 2 0 8 6 9 10 2 0
                                              18 6 9 20 3 0 18 6 9 18 19 5 0 28
                                              6 6 18 9 9 30 4 0 6 6 6 9 11 26 4
                                              0 6 6 18 9 9 27)))))
           '|lookupComplete|)) 

(MAKEPROP '|PrimGCD| 'NILADIC T) 
