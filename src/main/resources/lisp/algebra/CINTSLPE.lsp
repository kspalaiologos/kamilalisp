
(SDEFUN |CINTSLPE;solveLinearPolynomialEquation;LSupU;1|
        ((|lp| (|List| (|SparseUnivariatePolynomial| CR)))
         (|p| (|SparseUnivariatePolynomial| CR))
         ($ (|Union| (|List| (|SparseUnivariatePolynomial| CR)) "failed")))
        (SPROG
         ((|answer|
           (|Union| (|List| (|SparseUnivariatePolynomial| CR)) "failed"))
          (#1=#:G708 NIL)
          (|ans|
           (|Union| (|Vector| (|List| (|SparseUnivariatePolynomial| CR)))
                    #2="failed"))
          (|deg| #3=(|NonNegativeInteger|)) (#4=#:G705 NIL) (#5=#:G704 #3#)
          (#6=#:G706 #3#) (#7=#:G721 NIL) (|u| NIL))
         (SEQ
          (COND
           ((SPADCALL (QREFELT $ 8) |lp| (QREFELT $ 15))
            (SEQ
             (LETT |deg|
                   (PROGN
                    (LETT #4# NIL)
                    (SEQ (LETT |u| NIL) (LETT #7# |lp|) G190
                         (COND
                          ((OR (ATOM #7#) (PROGN (LETT |u| (CAR #7#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (PROGN
                            (LETT #6# (SPADCALL |u| (QREFELT $ 18)))
                            (COND (#4# (LETT #5# (+ #5# #6#)))
                                  ('T (PROGN (LETT #5# #6#) (LETT #4# 'T)))))))
                         (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
                    (COND (#4# #5#) ('T 0))))
             (LETT |ans| (CONS 1 "failed"))
             (SETELT $ 11 (SPADCALL 67108859 (QREFELT $ 10)))
             (SEQ G190 (COND ((NULL (QEQCAR |ans| 1)) (GO G191)))
                  (SEQ
                   (LETT |ans|
                         (SPADCALL |deg|
                                   (SPADCALL (QREFELT $ 11)
                                             (|spadConstant| $ 19)
                                             (QREFELT $ 21))
                                   |lp| (QREFELT $ 24)))
                   (EXIT
                    (COND
                     ((QEQCAR |ans| 1)
                      (SEQ
                       (SETELT $ 11
                               (SPADCALL (QREFELT $ 11)
                                         (SPADCALL 4 (QREFELT $ 10))
                                         (QREFELT $ 25)))
                       (EXIT
                        (SEQ G190
                             (COND
                              ((NULL
                                (NULL
                                 (SPADCALL (QREFELT $ 11) (QREFELT $ 27))))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (SETELT $ 11
                                       (SPADCALL (QREFELT $ 11)
                                                 (SPADCALL 4 (QREFELT $ 10))
                                                 (QREFELT $ 25)))))
                             NIL (GO G190) G191 (EXIT NIL))))))))
                  NIL (GO G190) G191 (EXIT NIL))
             (EXIT
              (SETELT $ 12
                      (PROG2 (LETT #1# |ans|)
                          (QCDR #1#)
                        (|check_union2| (QEQCAR #1# 0)
                                        (|Vector|
                                         (|List|
                                          (|SparseUnivariatePolynomial|
                                           (QREFELT $ 7))))
                                        (|Union|
                                         (|Vector|
                                          (|List|
                                           (|SparseUnivariatePolynomial|
                                            (QREFELT $ 7))))
                                         #2#)
                                        #1#)))))))
          (LETT |answer|
                (SPADCALL |p|
                          (SPADCALL (QREFELT $ 11) (|spadConstant| $ 19)
                                    (QREFELT $ 21))
                          (QREFELT $ 12) (QREFELT $ 30)))
          (EXIT |answer|)))) 

(DECLAIM (NOTINLINE |ComplexIntegerSolveLinearPolynomialEquation;|)) 

(DEFUN |ComplexIntegerSolveLinearPolynomialEquation| (&REST #1=#:G722)
  (SPROG NIL
         (PROG (#2=#:G723)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ComplexIntegerSolveLinearPolynomialEquation|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function|
                        |ComplexIntegerSolveLinearPolynomialEquation;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|ComplexIntegerSolveLinearPolynomialEquation|)))))))))) 

(DEFUN |ComplexIntegerSolveLinearPolynomialEquation;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$|
                (LIST '|ComplexIntegerSolveLinearPolynomialEquation| DV$1
                      DV$2))
          (LETT $ (GETREFV 32))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|ComplexIntegerSolveLinearPolynomialEquation|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 NIL)
          (QSETREFV $ 11 (SPADCALL 2 (QREFELT $ 10)))
          (QSETREFV $ 12 (MAKE-ARRAY 0))
          $))) 

(MAKEPROP '|ComplexIntegerSolveLinearPolynomialEquation| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|oldlp|
              (|Integer|) (0 . |coerce|) '|slpePrime| '|oldtable| (|Boolean|)
              (|List| 17) (5 . ~=) (|NonNegativeInteger|)
              (|SparseUnivariatePolynomial| 7) (11 . |degree|) (16 . |Zero|)
              (20 . |Zero|) (24 . |complex|) (|Union| 29 '"failed")
              (|GenExEuclid| 7 17) (30 . |tablePow|) (37 . -)
              (|IntegerPrimesPackage| 6) (43 . |prime?|) (|Union| 14 '"failed")
              (|Vector| 14) (48 . |solveid|)
              |CINTSLPE;solveLinearPolynomialEquation;LSupU;1|)
           '#(|solveLinearPolynomialEquation| 55) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|solveLinearPolynomialEquation|
                                 ((|Union|
                                   (|List| (|SparseUnivariatePolynomial| |#2|))
                                   "failed")
                                  (|List| (|SparseUnivariatePolynomial| |#2|))
                                  (|SparseUnivariatePolynomial| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 31
                                            '(1 6 0 9 10 2 14 13 0 0 15 1 17 16
                                              0 18 0 6 0 19 0 7 0 20 2 7 0 6 6
                                              21 3 23 22 16 7 14 24 2 6 0 0 0
                                              25 1 26 13 6 27 3 23 28 17 7 29
                                              30 2 0 28 14 17 31)))))
           '|lookupComplete|)) 
