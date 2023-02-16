
(SDEFUN |ELINSOL;lin_coeff|
        ((|x| (|SparseMultivariatePolynomial| R (|Kernel| F)))
         (|v| (|Kernel| F)) ($ (F)))
        (SPROG
         ((|d| (|NonNegativeInteger|))
          (|ux|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| R (|Kernel| F)))))
         (SEQ (LETT |ux| (SPADCALL |x| |v| (QREFELT $ 11)))
              (LETT |d| (SPADCALL |ux| (QREFELT $ 14)))
              (EXIT
               (COND ((< |d| 1) (|spadConstant| $ 17))
                     ((> |d| 1) (|error| "lin_coeff: x is nonlinear"))
                     ('T
                      (SPADCALL (SPADCALL |ux| (QREFELT $ 18))
                                (QREFELT $ 20)))))))) 

(SDEFUN |ELINSOL;F_to_LF|
        ((|x| (F)) (|vl| (|List| (|Kernel| F))) ($ (|List| F)))
        (SPROG
         ((#1=#:G736 NIL) (|v| NIL) (#2=#:G735 NIL)
          (|nx0| (|SparseMultivariatePolynomial| R (|Kernel| F)))
          (|nx1| (|SparseMultivariatePolynomial| R (|Kernel| F)))
          (|ml| (|List| (|SparseMultivariatePolynomial| R (|Kernel| F))))
          (#3=#:G733 NIL) (#4=#:G734 NIL) (|c| NIL) (#5=#:G732 NIL)
          (|res0| (|List| F)) (#6=#:G731 NIL) (#7=#:G730 NIL)
          (|nx| (|SparseMultivariatePolynomial| R (|Kernel| F))))
         (SEQ (LETT |nx| (SPADCALL |x| (QREFELT $ 21)))
              (LETT |res0|
                    (PROGN
                     (LETT #7# NIL)
                     (SEQ (LETT |v| NIL) (LETT #6# |vl|) G190
                          (COND
                           ((OR (ATOM #6#) (PROGN (LETT |v| (CAR #6#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #7#
                                  (CONS (|ELINSOL;lin_coeff| |nx| |v| $)
                                        #7#))))
                          (LETT #6# (CDR #6#)) (GO G190) G191
                          (EXIT (NREVERSE #7#)))))
              (LETT |ml|
                    (PROGN
                     (LETT #5# NIL)
                     (SEQ (LETT |c| NIL) (LETT #4# |res0|) (LETT |v| NIL)
                          (LETT #3# |vl|) G190
                          (COND
                           ((OR (ATOM #3#) (PROGN (LETT |v| (CAR #3#)) NIL)
                                (ATOM #4#) (PROGN (LETT |c| (CAR #4#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #5#
                                  (CONS
                                   (SPADCALL (SPADCALL |c| (QREFELT $ 21))
                                             (SPADCALL (|spadConstant| $ 22)
                                                       |v| 1 (QREFELT $ 23))
                                             (QREFELT $ 24))
                                   #5#))))
                          (LETT #3# (PROG1 (CDR #3#) (LETT #4# (CDR #4#))))
                          (GO G190) G191 (EXIT (NREVERSE #5#)))))
              (LETT |nx1|
                    (SPADCALL (ELT $ 26) |ml| (|spadConstant| $ 27)
                              (QREFELT $ 30)))
              (LETT |nx0| (SPADCALL |nx| |nx1| (QREFELT $ 31)))
              (EXIT
               (COND
                ((>
                  (SPADCALL (ELT $ 35)
                            (PROGN
                             (LETT #2# NIL)
                             (SEQ (LETT |v| NIL) (LETT #1# |vl|) G190
                                  (COND
                                   ((OR (ATOM #1#)
                                        (PROGN (LETT |v| (CAR #1#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #2#
                                          (CONS
                                           (SPADCALL |nx0| |v| (QREFELT $ 33))
                                           #2#))))
                                  (LETT #1# (CDR #1#)) (GO G190) G191
                                  (EXIT (NREVERSE #2#))))
                            (QREFELT $ 38))
                  0)
                 (|error| "x is nonlinear in vl"))
                ('T (CONS (SPADCALL |nx0| (QREFELT $ 20)) |res0|))))))) 

(SDEFUN |ELINSOL;lin_sol;LLU;3|
        ((|eql| (|List| F)) (|vl| (|List| (|Symbol|)))
         ($ (|Union| (|List| F) "failed")))
        (SPROG
         ((#1=#:G753 NIL)
          (|ss|
           (|Record| (|:| |particular| (|Union| (|Vector| F) #2="failed"))
                     (|:| |basis| (|List| (|Vector| F)))))
          (|eqm| (|Matrix| F)) (#3=#:G767 NIL) (|ll| NIL) (#4=#:G766 NIL)
          (|rh| (|Vector| F)) (#5=#:G765 NIL) (#6=#:G764 NIL)
          (|eqll| (|List| (|List| F))) (#7=#:G763 NIL) (|p| NIL)
          (#8=#:G762 NIL) (|coefk| (|List| (|Kernel| F))) (#9=#:G761 NIL)
          (|c| NIL) (#10=#:G760 NIL))
         (SEQ
          (LETT |coefk|
                (PROGN
                 (LETT #10# NIL)
                 (SEQ (LETT |c| NIL) (LETT #9# |vl|) G190
                      (COND
                       ((OR (ATOM #9#) (PROGN (LETT |c| (CAR #9#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #10#
                              (CONS
                               (SPADCALL (SPADCALL |c| (QREFELT $ 40))
                                         (QREFELT $ 42))
                               #10#))))
                      (LETT #9# (CDR #9#)) (GO G190) G191
                      (EXIT (NREVERSE #10#)))))
          (LETT |eqll|
                (PROGN
                 (LETT #8# NIL)
                 (SEQ (LETT |p| NIL) (LETT #7# |eql|) G190
                      (COND
                       ((OR (ATOM #7#) (PROGN (LETT |p| (CAR #7#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #8#
                              (CONS (|ELINSOL;F_to_LF| |p| |coefk| $) #8#))))
                      (LETT #7# (CDR #7#)) (GO G190) G191
                      (EXIT (NREVERSE #8#)))))
          (LETT |rh|
                (SPADCALL
                 (SPADCALL
                  (PROGN
                   (LETT #6# NIL)
                   (SEQ (LETT |ll| NIL) (LETT #5# |eqll|) G190
                        (COND
                         ((OR (ATOM #5#) (PROGN (LETT |ll| (CAR #5#)) NIL))
                          (GO G191)))
                        (SEQ (EXIT (LETT #6# (CONS (|SPADfirst| |ll|) #6#))))
                        (LETT #5# (CDR #5#)) (GO G190) G191
                        (EXIT (NREVERSE #6#))))
                  (QREFELT $ 45))
                 (QREFELT $ 46)))
          (LETT |eqm|
                (SPADCALL
                 (PROGN
                  (LETT #4# NIL)
                  (SEQ (LETT |ll| NIL) (LETT #3# |eqll|) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |ll| (CAR #3#)) NIL))
                         (GO G191)))
                       (SEQ (EXIT (LETT #4# (CONS (CDR |ll|) #4#))))
                       (LETT #3# (CDR #3#)) (GO G190) G191
                       (EXIT (NREVERSE #4#))))
                 (QREFELT $ 49)))
          (LETT |ss| (SPADCALL |eqm| |rh| (QREFELT $ 53)))
          (EXIT
           (COND ((QEQCAR (QCAR |ss|) 1) (CONS 1 "failed"))
                 ('T
                  (CONS 0
                        (SPADCALL
                         (PROG2 (LETT #1# (QCAR |ss|))
                             (QCDR #1#)
                           (|check_union2| (QEQCAR #1# 0)
                                           (|Vector| (QREFELT $ 7))
                                           (|Union| (|Vector| (QREFELT $ 7))
                                                    #2#)
                                           #1#))
                         (QREFELT $ 54))))))))) 

(DECLAIM (NOTINLINE |ExpressionLinearSolve;|)) 

(DEFUN |ExpressionLinearSolve| (&REST #1=#:G768)
  (SPROG NIL
         (PROG (#2=#:G769)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ExpressionLinearSolve|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ExpressionLinearSolve;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|ExpressionLinearSolve|)))))))))) 

(DEFUN |ExpressionLinearSolve;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|ExpressionLinearSolve| DV$1 DV$2))
          (LETT $ (GETREFV 58))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ExpressionLinearSolve|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ExpressionLinearSolve| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|SparseUnivariatePolynomial| $) (|Kernel| 7)
              (|SparseMultivariatePolynomial| 6 9) (0 . |univariate|)
              (|NonNegativeInteger|) (|SparseUnivariatePolynomial| 10)
              (6 . |degree|) (11 . |One|) (15 . |One|) (19 . |Zero|)
              (23 . |leadingCoefficient|) (|SparseMultivariatePolynomial| 6 41)
              (28 . |coerce|) (33 . |numer|) (38 . |One|) (42 . |monomial|)
              (49 . *) (55 . +) (61 . +) (67 . |Zero|) (|Mapping| 10 10 10)
              (|List| 10) (71 . |reduce|) (78 . -) (84 . |max|) (90 . |degree|)
              (|Integer|) (96 . |max|) (|Mapping| 34 34 34) (|List| 34)
              (102 . |reduce|) (|Symbol|) (108 . |coerce|) (|Kernel| $)
              (113 . |retract|) (|List| 7) (|Vector| 7) (118 . |vector|)
              (123 . -) (|List| 43) (|Matrix| 7) (128 . |matrix|)
              (|Union| 44 '"failed")
              (|Record| (|:| |particular| 50) (|:| |basis| (|List| 44)))
              (|LinearSystemMatrixPackage1| 7) (133 . |solve|) (139 . |parts|)
              (|Union| 43 '"failed") (|List| 39) |ELINSOL;lin_sol;LLU;3|)
           '#(|lin_sol| 144) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|lin_sol|
                                 ((|Union| (|List| |#2|) "failed")
                                  (|List| |#2|) (|List| (|Symbol|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 57
                                            '(2 10 8 0 9 11 1 13 12 0 14 0 6 0
                                              15 0 7 0 16 0 7 0 17 1 13 10 0 18
                                              1 7 0 19 20 1 7 19 0 21 0 10 0 22
                                              3 10 0 0 9 12 23 2 10 0 0 0 24 2
                                              7 0 0 0 25 2 10 0 0 0 26 0 10 0
                                              27 3 29 10 28 0 10 30 2 10 0 0 0
                                              31 2 9 0 0 0 32 2 10 12 0 9 33 2
                                              34 0 0 0 35 2 37 34 36 0 38 1 7 0
                                              39 40 1 7 41 0 42 1 44 0 43 45 1
                                              44 0 0 46 1 48 0 47 49 2 52 51 48
                                              44 53 1 44 43 0 54 2 0 55 43 56
                                              57)))))
           '|lookupComplete|)) 
