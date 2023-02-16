
(SDEFUN |RETSOL;PQ2P| ((|p| (|Polynomial| Q)) ($ (|Polynomial| R)))
        (SPADCALL (ELT $ 8) |p| (QREFELT $ 13))) 

(SDEFUN |RETSOL;FQ2F|
        ((|f| (|Fraction| (|Polynomial| Q))) ($ (|Fraction| (|Polynomial| R))))
        (SPADCALL (|RETSOL;PQ2P| (SPADCALL |f| (QREFELT $ 15)) $)
                  (|RETSOL;PQ2P| (SPADCALL |f| (QREFELT $ 16)) $)
                  (QREFELT $ 18))) 

(SDEFUN |RETSOL;LEQQ2F|
        ((|l| (|List| (|Equation| (|Fraction| (|Polynomial| Q)))))
         ($ (|List| (|Equation| (|Fraction| (|Polynomial| R))))))
        (SPROG ((#1=#:G706 NIL) (|eq| NIL) (#2=#:G705 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |eq| NIL) (LETT #1# |l|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |eq| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL
                                (|RETSOL;FQ2F| (SPADCALL |eq| (QREFELT $ 20))
                                 $)
                                (|RETSOL;FQ2F| (SPADCALL |eq| (QREFELT $ 21))
                                 $)
                                (QREFELT $ 23))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |RETSOL;solveRetract;LLL;4|
        ((|lp| (|List| (|Polynomial| R))) (|lv| (|List| (|Symbol|)))
         ($ (|List| (|List| (|Equation| (|Fraction| (|Polynomial| R)))))))
        (SPROG
         ((#1=#:G719 NIL) (|l| NIL) (#2=#:G718 NIL) (#3=#:G717 NIL) (|p| NIL)
          (#4=#:G716 NIL)
          (|u| (|Union| (|List| (|Fraction| (|Polynomial| Q))) "failed")))
         (SEQ (LETT |u| (|RETSOL;QIfCan| |lp| $))
              (EXIT
               (COND
                ((QEQCAR |u| 1)
                 (SPADCALL
                  (PROGN
                   (LETT #4# NIL)
                   (SEQ (LETT |p| NIL) (LETT #3# |lp|) G190
                        (COND
                         ((OR (ATOM #3#) (PROGN (LETT |p| (CAR #3#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #4# (CONS (SPADCALL |p| (QREFELT $ 24)) #4#))))
                        (LETT #3# (CDR #3#)) (GO G190) G191
                        (EXIT (NREVERSE #4#))))
                  |lv| (QREFELT $ 29)))
                ('T
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |l| NIL)
                       (LETT #1# (SPADCALL (QCDR |u|) |lv| (QREFELT $ 33)))
                       G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |l| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT (LETT #2# (CONS (|RETSOL;LEQQ2F| |l| $) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#)))))))))) 

(SDEFUN |RETSOL;QIfCan|
        ((|l| (|List| (|Polynomial| R)))
         ($ (|Union| (|List| (|Fraction| (|Polynomial| Q))) "failed")))
        (SPROG
         ((|ans| (|List| (|Fraction| (|Polynomial| Q)))) (#1=#:G734 NIL)
          (|u| (|Union| (|Fraction| (|Polynomial| Q)) "failed"))
          (#2=#:G735 NIL) (|p| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |ans| NIL)
                (SEQ (LETT |p| NIL) (LETT #2# |l|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |p| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ (LETT |u| (|RETSOL;PQIfCan| |p| $))
                          (EXIT
                           (COND
                            ((QEQCAR |u| 1)
                             (PROGN
                              (LETT #1# (CONS 1 "failed"))
                              (GO #3=#:G733)))
                            ('T (LETT |ans| (CONS (QCDR |u|) |ans|))))))
                     (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 |ans|))))
          #3# (EXIT #1#)))) 

(SDEFUN |RETSOL;PQIfCan|
        ((|p| (|Polynomial| R))
         ($ (|Union| (|Fraction| (|Polynomial| Q)) #1="failed")))
        (SPROG
         ((|up| (|SparseUnivariatePolynomial| (|Polynomial| R)))
          (|ans| (|Fraction| (|Polynomial| Q))) (#2=#:G755 NIL)
          (|v| (|Union| (|Fraction| (|Polynomial| Q)) #1#)) (|s| (|Symbol|))
          (|r| (|Union| Q "failed")) (|u| (|Union| (|Symbol|) "failed")))
         (SEQ
          (EXIT
           (SEQ (LETT |u| (SPADCALL |p| (QREFELT $ 37)))
                (EXIT
                 (COND
                  ((QEQCAR |u| 1)
                   (SEQ
                    (LETT |r|
                          (SPADCALL (SPADCALL |p| (QREFELT $ 38))
                                    (QREFELT $ 40)))
                    (EXIT
                     (COND
                      ((QEQCAR |r| 0)
                       (CONS 0
                             (SPADCALL (SPADCALL (QCDR |r|) (QREFELT $ 41))
                                       (QREFELT $ 42))))
                      (#3='T (CONS 1 "failed"))))))
                  (#3#
                   (SEQ
                    (LETT |up|
                          (SPADCALL |p| (LETT |s| (QCDR |u|)) (QREFELT $ 45)))
                    (LETT |ans| (|spadConstant| $ 46))
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL |up| (|spadConstant| $ 50)
                                      (QREFELT $ 52)))
                           (GO G191)))
                         (SEQ
                          (LETT |v|
                                (|RETSOL;PQIfCan|
                                 (SPADCALL |up| (QREFELT $ 53)) $))
                          (EXIT
                           (COND
                            ((QEQCAR |v| 1)
                             (PROGN
                              (LETT #2# (CONS 1 "failed"))
                              (GO #4=#:G754)))
                            ('T
                             (SEQ
                              (LETT |ans|
                                    (SPADCALL |ans|
                                              (SPADCALL
                                               (SPADCALL (|spadConstant| $ 58)
                                                         |s|
                                                         (SPADCALL |up|
                                                                   (QREFELT $
                                                                            57))
                                                         (QREFELT $ 59))
                                               (QCDR |v|) (QREFELT $ 60))
                                              (QREFELT $ 61)))
                              (EXIT
                               (LETT |up| (SPADCALL |up| (QREFELT $ 62)))))))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (CONS 0 |ans|))))))))
          #4# (EXIT #2#)))) 

(DECLAIM (NOTINLINE |RetractSolvePackage;|)) 

(DEFUN |RetractSolvePackage| (&REST #1=#:G756)
  (SPROG NIL
         (PROG (#2=#:G757)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|RetractSolvePackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |RetractSolvePackage;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|RetractSolvePackage|)))))))))) 

(DEFUN |RetractSolvePackage;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|RetractSolvePackage| DV$1 DV$2))
          (LETT $ (GETREFV 63))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RetractSolvePackage|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RetractSolvePackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (0 . |coerce|) (|Polynomial| 7) (|Mapping| 7 6) (|Polynomial| 6)
              (|PolynomialFunctions2| 6 7) (5 . |map|) (|Fraction| 11)
              (11 . |numer|) (16 . |denom|) (|Fraction| 9) (21 . /)
              (|Equation| 14) (27 . |lhs|) (32 . |rhs|) (|Equation| 17)
              (37 . |equation|) (43 . |coerce|) (|List| (|List| 22))
              (|List| 17) (|List| 44) (|SystemSolvePackage| 7) (48 . |solve|)
              (|List| (|List| 19)) (|List| 14) (|SystemSolvePackage| 6)
              (54 . |solve|) (|List| 9) |RETSOL;solveRetract;LLL;4|
              (|Union| 44 '"failed") (60 . |mainVariable|) (65 . |ground|)
              (|Union| 6 '"failed") (70 . |retractIfCan|) (75 . |coerce|)
              (80 . |coerce|) (|SparseUnivariatePolynomial| $) (|Symbol|)
              (85 . |univariate|) (91 . |Zero|) (95 . |Zero|) (99 . |Zero|)
              (|SparseUnivariatePolynomial| 9) (103 . |Zero|) (|Boolean|)
              (107 . ~=) (113 . |leadingCoefficient|) (118 . |One|)
              (122 . |One|) (|NonNegativeInteger|) (126 . |degree|)
              (131 . |One|) (135 . |monomial|) (142 . *) (148 . +)
              (154 . |reductum|))
           '#(|solveRetract| 159) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|solveRetract|
                                 ((|List|
                                   (|List|
                                    (|Equation|
                                     (|Fraction| (|Polynomial| |#2|)))))
                                  (|List| (|Polynomial| |#2|))
                                  (|List| (|Symbol|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 62
                                            '(1 7 0 6 8 2 12 9 10 11 13 1 14 11
                                              0 15 1 14 11 0 16 2 17 0 9 9 18 1
                                              19 14 0 20 1 19 14 0 21 2 22 0 17
                                              17 23 1 17 0 9 24 2 28 25 26 27
                                              29 2 32 30 31 27 33 1 9 36 0 37 1
                                              9 7 0 38 1 7 39 0 40 1 11 0 6 41
                                              1 14 0 11 42 2 9 43 0 44 45 0 14
                                              0 46 0 6 0 47 0 7 0 48 0 49 0 50
                                              2 49 51 0 0 52 1 49 9 0 53 0 6 0
                                              54 0 7 0 55 1 49 56 0 57 0 11 0
                                              58 3 11 0 0 44 56 59 2 14 0 11 0
                                              60 2 14 0 0 0 61 1 49 0 0 62 2 0
                                              25 34 27 35)))))
           '|lookupComplete|)) 
