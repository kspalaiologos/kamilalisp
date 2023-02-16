
(SDEFUN |LPEFRAC;pullback|
        ((|pF| (|SparseUnivariatePolynomial| (|Fraction| R)))
         ($ #1=(|Union| (|SparseUnivariatePolynomial| R) "failed")))
        (SPROG ((|r| #1#) (|c| (|Union| R "failed")))
               (SEQ
                (COND
                 ((SPADCALL |pF| (|spadConstant| $ 11) (QREFELT $ 13))
                  (CONS 0 (|spadConstant| $ 9)))
                 (#2='T
                  (SEQ
                   (LETT |c|
                         (SPADCALL (SPADCALL |pF| (QREFELT $ 15))
                                   (QREFELT $ 17)))
                   (EXIT
                    (COND ((QEQCAR |c| 1) (CONS 1 "failed"))
                          (#2#
                           (SEQ
                            (LETT |r|
                                  (|LPEFRAC;pullback|
                                   (SPADCALL |pF| (QREFELT $ 18)) $))
                            (EXIT
                             (COND ((QEQCAR |r| 1) (CONS 1 "failed"))
                                   (#2#
                                    (CONS 0
                                          (SPADCALL
                                           (SPADCALL (QCDR |c|)
                                                     (SPADCALL |pF|
                                                               (QREFELT $ 20))
                                                     (QREFELT $ 21))
                                           (QCDR |r|)
                                           (QREFELT $ 22)))))))))))))))) 

(SDEFUN |LPEFRAC;solveLinearPolynomialEquationByFractions;LSupU;2|
        ((|lp| (|List| (|SparseUnivariatePolynomial| R)))
         (|pp| (|SparseUnivariatePolynomial| R))
         ($ (|Union| (|List| (|SparseUnivariatePolynomial| R)) "failed")))
        (SPROG
         ((#1=#:G727 NIL)
          (|vv| (|Union| (|SparseUnivariatePolynomial| R) "failed"))
          (#2=#:G731 NIL) (|v| NIL) (#3=#:G730 NIL)
          (|ans|
           (|Union| (|List| (|SparseUnivariatePolynomial| (|Fraction| R)))
                    "failed"))
          (|pF| (|SparseUnivariatePolynomial| (|Fraction| R)))
          (|lpF| (|List| (|SparseUnivariatePolynomial| (|Fraction| R))))
          (#4=#:G729 NIL) (|u| NIL) (#5=#:G728 NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |lpF|
                  (PROGN
                   (LETT #5# NIL)
                   (SEQ (LETT |u| NIL) (LETT #4# |lp|) G190
                        (COND
                         ((OR (ATOM #4#) (PROGN (LETT |u| (CAR #4#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #5#
                                (CONS (SPADCALL (ELT $ 23) |u| (QREFELT $ 26))
                                      #5#))))
                        (LETT #4# (CDR #4#)) (GO G190) G191
                        (EXIT (NREVERSE #5#)))))
            (LETT |pF| (SPADCALL (ELT $ 23) |pp| (QREFELT $ 26)))
            (LETT |ans| (SPADCALL |lpF| |pF| (QREFELT $ 30)))
            (EXIT
             (COND ((QEQCAR |ans| 1) (CONS 1 "failed"))
                   ('T
                    (CONS 0
                          (PROGN
                           (LETT #3# NIL)
                           (SEQ (LETT |v| NIL) (LETT #2# (QCDR |ans|)) G190
                                (COND
                                 ((OR (ATOM #2#)
                                      (PROGN (LETT |v| (CAR #2#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #3#
                                        (CONS
                                         (SEQ
                                          (LETT |vv|
                                                (|LPEFRAC;pullback| |v| $))
                                          (EXIT
                                           (COND
                                            ((QEQCAR |vv| 1)
                                             (PROGN
                                              (LETT #1# (CONS 1 "failed"))
                                              (GO #6=#:G726)))
                                            ('T (QCDR |vv|)))))
                                         #3#))))
                                (LETT #2# (CDR #2#)) (GO G190) G191
                                (EXIT (NREVERSE #3#))))))))))
          #6# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |LinearPolynomialEquationByFractions;|)) 

(DEFUN |LinearPolynomialEquationByFractions| (#1=#:G732)
  (SPROG NIL
         (PROG (#2=#:G733)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|LinearPolynomialEquationByFractions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|LinearPolynomialEquationByFractions;| #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|LinearPolynomialEquationByFractions|)))))))))) 

(DEFUN |LinearPolynomialEquationByFractions;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|LinearPolynomialEquationByFractions| DV$1))
          (LETT $ (GETREFV 34))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|LinearPolynomialEquationByFractions| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|LinearPolynomialEquationByFractions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |Zero|)
              (|SparseUnivariatePolynomial| 6) (4 . |Zero|)
              (|SparseUnivariatePolynomial| 14) (8 . |Zero|) (|Boolean|)
              (12 . =) (|Fraction| 6) (18 . |leadingCoefficient|)
              (|Union| 6 '"failed") (23 . |retractIfCan|) (28 . |reductum|)
              (|NonNegativeInteger|) (33 . |degree|) (38 . |monomial|) (44 . +)
              (50 . |coerce|) (|Mapping| 14 6)
              (|UnivariatePolynomialCategoryFunctions2| 6 8 14 10) (55 . |map|)
              (|Union| 28 '"failed") (|List| 29)
              (|SparseUnivariatePolynomial| $)
              (61 . |solveLinearPolynomialEquation|) (|Union| 32 '#1="failed")
              (|List| 8)
              |LPEFRAC;solveLinearPolynomialEquationByFractions;LSupU;2|)
           '#(|solveLinearPolynomialEquationByFractions| 67) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|solveLinearPolynomialEquationByFractions|
                                 ((|Union|
                                   (|List| (|SparseUnivariatePolynomial| |#1|))
                                   #1#)
                                  (|List| (|SparseUnivariatePolynomial| |#1|))
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 33
                                            '(0 6 0 7 0 8 0 9 0 10 0 11 2 10 12
                                              0 0 13 1 10 14 0 15 1 14 16 0 17
                                              1 10 0 0 18 1 10 19 0 20 2 8 0 6
                                              19 21 2 8 0 0 0 22 1 14 0 6 23 2
                                              25 10 24 8 26 2 14 27 28 29 30 2
                                              0 31 32 8 33)))))
           '|lookupComplete|)) 
