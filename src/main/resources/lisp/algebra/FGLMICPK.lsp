
(SDEFUN |FGLMICPK;zeroDim?|
        ((|lq2|
          (|List| (|HomogeneousDistributedMultivariatePolynomial| |ls| R)))
         ($ (|Boolean|)))
        (SPROG
         ((|lv| (|List| (|OrderedVariableList| |ls|)))
          (|x| (|OrderedVariableList| |ls|)) (#1=#:G707 NIL)
          (|m| (|HomogeneousDistributedMultivariatePolynomial| |ls| R))
          (#2=#:G721 NIL) (|q2| NIL) (#3=#:G720 NIL) (|s| NIL) (#4=#:G719 NIL))
         (SEQ (LETT |lq2| (SPADCALL |lq2| (QREFELT $ 10)))
              (EXIT
               (COND
                ((OR (NULL |lq2|) (< (LENGTH |lq2|) (LENGTH (QREFELT $ 7))))
                 NIL)
                ('T
                 (SEQ
                  (LETT |lv|
                        (PROGN
                         (LETT #4# NIL)
                         (SEQ (LETT |s| NIL) (LETT #3# (QREFELT $ 7)) G190
                              (COND
                               ((OR (ATOM #3#)
                                    (PROGN (LETT |s| (CAR #3#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #4#
                                      (CONS
                                       (PROG2
                                           (LETT #1#
                                                 (SPADCALL |s| (QREFELT $ 14)))
                                           (QCDR #1#)
                                         (|check_union2| (QEQCAR #1# 0)
                                                         (|OrderedVariableList|
                                                          (QREFELT $ 7))
                                                         (|Union|
                                                          (|OrderedVariableList|
                                                           (QREFELT $ 7))
                                                          #5="failed")
                                                         #1#))
                                       #4#))))
                              (LETT #3# (CDR #3#)) (GO G190) G191
                              (EXIT (NREVERSE #4#)))))
                  (SEQ (LETT |q2| NIL) (LETT #2# |lq2|) G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |q2| (CAR #2#)) NIL)
                             (NULL (NULL (NULL |lv|))))
                         (GO G191)))
                       (SEQ (LETT |m| (SPADCALL |q2| (QREFELT $ 16)))
                            (LETT |x|
                                  (PROG2
                                      (LETT #1# (SPADCALL |m| (QREFELT $ 18)))
                                      (QCDR #1#)
                                    (|check_union2| (QEQCAR #1# 0)
                                                    (|OrderedVariableList|
                                                     (QREFELT $ 7))
                                                    (|Union|
                                                     (|OrderedVariableList|
                                                      (QREFELT $ 7))
                                                     #5#)
                                                    #1#)))
                            (EXIT
                             (COND
                              ((SPADCALL
                                (SPADCALL (SPADCALL |m| |x| (QREFELT $ 20))
                                          (QREFELT $ 22))
                                (QREFELT $ 24))
                               (LETT |lv|
                                     (SPADCALL |x| |lv| (QREFELT $ 26)))))))
                       (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                  (EXIT (NULL |lv|))))))))) 

(SDEFUN |FGLMICPK;zeroDimensional?;LB;2|
        ((|lq1| (|List| (|Polynomial| R))) ($ (|Boolean|)))
        (SPROG
         ((|lq2|
           (|List| (|HomogeneousDistributedMultivariatePolynomial| |ls| R)))
          (#1=#:G730 NIL) (|q1| NIL) (#2=#:G729 NIL))
         (SEQ
          (LETT |lq2|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |q1| NIL) (LETT #1# |lq1|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |q1| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |q1| (QREFELT $ 29)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT (|FGLMICPK;zeroDim?| |lq2| $))))) 

(SDEFUN |FGLMICPK;fglmIfCan;LU;3|
        ((|lq1| (|List| (|Polynomial| R)))
         ($ (|Union| (|List| (|Polynomial| R)) "failed")))
        (SPROG
         ((#1=#:G748 NIL) (|q3| NIL) (#2=#:G747 NIL)
          (|lq3| (|List| (|DistributedMultivariatePolynomial| |ls| R)))
          (|lq2|
           (|List| (|HomogeneousDistributedMultivariatePolynomial| |ls| R)))
          (#3=#:G746 NIL) (|q1| NIL) (#4=#:G745 NIL))
         (SEQ
          (LETT |lq2|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |q1| NIL) (LETT #3# |lq1|) G190
                      (COND
                       ((OR (ATOM #3#) (PROGN (LETT |q1| (CAR #3#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #4# (CONS (SPADCALL |q1| (QREFELT $ 29)) #4#))))
                      (LETT #3# (CDR #3#)) (GO G190) G191
                      (EXIT (NREVERSE #4#)))))
          (LETT |lq2| (SPADCALL |lq2| (QREFELT $ 10)))
          (COND
           ((NULL (|FGLMICPK;zeroDim?| |lq2| $)) (EXIT (CONS 1 "failed"))))
          (LETT |lq3| (SPADCALL |lq2| (QREFELT $ 34)))
          (LETT |lq1|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |q3| NIL) (LETT #1# |lq3|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |q3| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |q3| (QREFELT $ 36)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT (CONS 0 |lq1|))))) 

(SDEFUN |FGLMICPK;groebner;2L;4|
        ((|lq1| (|List| (|Polynomial| R))) ($ (|List| (|Polynomial| R))))
        (SPROG
         ((#1=#:G769 NIL) (|q3| NIL) (#2=#:G768 NIL)
          (|lq3| (|List| (|DistributedMultivariatePolynomial| |ls| R)))
          (#3=#:G767 NIL) (#4=#:G766 NIL) (#5=#:G765 NIL) (|q1| NIL)
          (#6=#:G764 NIL)
          (|lq2|
           (|List| (|HomogeneousDistributedMultivariatePolynomial| |ls| R)))
          (#7=#:G763 NIL) (#8=#:G762 NIL))
         (SEQ
          (LETT |lq2|
                (PROGN
                 (LETT #8# NIL)
                 (SEQ (LETT |q1| NIL) (LETT #7# |lq1|) G190
                      (COND
                       ((OR (ATOM #7#) (PROGN (LETT |q1| (CAR #7#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #8# (CONS (SPADCALL |q1| (QREFELT $ 29)) #8#))))
                      (LETT #7# (CDR #7#)) (GO G190) G191
                      (EXIT (NREVERSE #8#)))))
          (LETT |lq2| (SPADCALL |lq2| (QREFELT $ 10)))
          (COND
           ((NULL (|FGLMICPK;zeroDim?| |lq2| $))
            (EXIT
             (SEQ
              (LETT |lq3|
                    (PROGN
                     (LETT #6# NIL)
                     (SEQ (LETT |q1| NIL) (LETT #5# |lq1|) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |q1| (CAR #5#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #6#
                                  (CONS (SPADCALL |q1| (QREFELT $ 39)) #6#))))
                          (LETT #5# (CDR #5#)) (GO G190) G191
                          (EXIT (NREVERSE #6#)))))
              (LETT |lq3| (SPADCALL |lq3| (QREFELT $ 41)))
              (EXIT
               (PROGN
                (LETT #4# NIL)
                (SEQ (LETT |q3| NIL) (LETT #3# |lq3|) G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |q3| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #4# (CONS (SPADCALL |q3| (QREFELT $ 36)) #4#))))
                     (LETT #3# (CDR #3#)) (GO G190) G191
                     (EXIT (NREVERSE #4#)))))))))
          (LETT |lq3| (SPADCALL |lq2| (QREFELT $ 34)))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |q3| NIL) (LETT #1# |lq3|) G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |q3| (CAR #1#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT (LETT #2# (CONS (SPADCALL |q3| (QREFELT $ 36)) #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(DECLAIM (NOTINLINE |FGLMIfCanPackage;|)) 

(DEFUN |FGLMIfCanPackage| (&REST #1=#:G770)
  (SPROG NIL
         (PROG (#2=#:G771)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(T NIL))
                                               (HGET |$ConstructorCache|
                                                     '|FGLMIfCanPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FGLMIfCanPackage;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FGLMIfCanPackage|)))))))))) 

(DEFUN |FGLMIfCanPackage;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 |#2|)
          (LETT |dv$| (LIST '|FGLMIfCanPackage| DV$1 DV$2))
          (LETT $ (GETREFV 43))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FGLMIfCanPackage| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FGLMIfCanPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|List| 15)
              (|GroebnerPackage| 6
                                 (|HomogeneousDirectProduct|
                                  (NRTEVAL (LENGTH (QREFELT $ 7)))
                                  (|NonNegativeInteger|))
                                 15)
              (0 . |groebner|) (|Union| $ '"failed") (|Symbol|)
              (|OrderedVariableList| (NRTEVAL (QREFELT $ 7))) (5 . |variable|)
              (|HomogeneousDistributedMultivariatePolynomial|
               (NRTEVAL (QREFELT $ 7)) 6)
              (10 . |leadingMonomial|) (|Union| 13 '"failed")
              (15 . |mainVariable|) (|SparseUnivariatePolynomial| $)
              (20 . |univariate|) (|SparseUnivariatePolynomial| 15)
              (26 . |leadingCoefficient|) (|Boolean|) (31 . |ground?|)
              (|List| 13) (36 . |remove|) (|Polynomial| 6)
              (|PolToPol| (NRTEVAL (QREFELT $ 7)) 6) (42 . |pToHdmp|)
              (|List| 27) |FGLMICPK;zeroDimensional?;LB;2| (|List| 35)
              (|LinGroebnerPackage| (NRTEVAL (QREFELT $ 7)) 6) (47 . |totolex|)
              (|DistributedMultivariatePolynomial| (NRTEVAL (QREFELT $ 7)) 6)
              (52 . |dmpToP|) (|Union| 30 '"failed") |FGLMICPK;fglmIfCan;LU;3|
              (57 . |pToDmp|)
              (|GroebnerPackage| 6
                                 (|DirectProduct|
                                  (NRTEVAL (LENGTH (QREFELT $ 7)))
                                  (|NonNegativeInteger|))
                                 35)
              (62 . |groebner|) |FGLMICPK;groebner;2L;4|)
           '#(|zeroDimensional?| 67 |groebner| 72 |fglmIfCan| 77) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|zeroDimensional?|
                                 ((|Boolean|) (|List| (|Polynomial| |#1|))))
                                T)
                              '((|fglmIfCan|
                                 ((|Union| (|List| (|Polynomial| |#1|))
                                           "failed")
                                  (|List| (|Polynomial| |#1|))))
                                T)
                              '((|groebner|
                                 ((|List| (|Polynomial| |#1|))
                                  (|List| (|Polynomial| |#1|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 42
                                            '(1 9 8 8 10 1 13 11 12 14 1 15 0 0
                                              16 1 15 17 0 18 2 15 19 0 13 20 1
                                              21 15 0 22 1 15 23 0 24 2 25 0 13
                                              0 26 1 28 15 27 29 1 33 32 8 34 1
                                              28 27 35 36 1 28 35 27 39 1 40 32
                                              32 41 1 0 23 30 31 1 0 30 30 42 1
                                              0 37 30 38)))))
           '|lookupComplete|)) 
