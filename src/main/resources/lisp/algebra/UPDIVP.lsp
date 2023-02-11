
(SDEFUN |UPDIVP;divideIfCan;2UPU;1|
        ((|p1| (UP)) (|p2| (UP))
         ($
          (|Union| (|Record| (|:| |quotient| UP) (|:| |remainder| UP))
                   "failed")))
        (SPROG
         ((|q| (UP)) (|ee| (|NonNegativeInteger|)) (#1=#:G700 NIL)
          (#2=#:G719 NIL) (|c| (|Union| R "failed"))
          (|e| (|Union| (|NonNegativeInteger|) #3="failed")) (|lc| (R)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |p2| (QREFELT $ 9))
             (|error| "divideIfCan: division by zero"))
            (#4='T
             (SEQ (LETT |lc| (SPADCALL |p2| (QREFELT $ 10)))
                  (EXIT
                   (COND
                    ((SPADCALL |lc| (|spadConstant| $ 11) (QREFELT $ 13))
                     (CONS 0 (SPADCALL |p1| |p2| (QREFELT $ 15))))
                    (#4#
                     (SEQ (LETT |q| (|spadConstant| $ 16))
                          (SEQ G190
                               (COND
                                ((NULL
                                  (SEQ
                                   (LETT |e|
                                         (SPADCALL
                                          (SPADCALL |p1| (QREFELT $ 18))
                                          (SPADCALL |p2| (QREFELT $ 18))
                                          (QREFELT $ 20)))
                                   (EXIT (NULL (QEQCAR |e| 1)))))
                                 (GO G191)))
                               (SEQ
                                (LETT |c|
                                      (SPADCALL (SPADCALL |p1| (QREFELT $ 10))
                                                |lc| (QREFELT $ 21)))
                                (EXIT
                                 (COND
                                  ((QEQCAR |c| 1)
                                   (PROGN
                                    (LETT #2# (CONS 1 "failed"))
                                    (GO #5=#:G718)))
                                  ('T
                                   (SEQ
                                    (LETT |ee|
                                          (PROG2 (LETT #1# |e|)
                                              (QCDR #1#)
                                            (|check_union2| (QEQCAR #1# 0)
                                                            (|NonNegativeInteger|)
                                                            (|Union|
                                                             (|NonNegativeInteger|)
                                                             #3#)
                                                            #1#)))
                                    (LETT |q|
                                          (SPADCALL |q|
                                                    (SPADCALL (QCDR |c|) |ee|
                                                              (QREFELT $ 22))
                                                    (QREFELT $ 23)))
                                    (EXIT
                                     (LETT |p1|
                                           (SPADCALL |p1|
                                                     (SPADCALL (QCDR |c|)
                                                               (SPADCALL
                                                                (CONS
                                                                 #'|UPDIVP;divideIfCan;2UPU;1!0|
                                                                 (VECTOR $
                                                                         |ee|))
                                                                |p2|
                                                                (QREFELT $ 26))
                                                               (QREFELT $ 27))
                                                     (QREFELT $ 28)))))))))
                               NIL (GO G190) G191 (EXIT NIL))
                          (EXIT (CONS 0 (CONS |q| |p1|)))))))))))
          #5# (EXIT #2#)))) 

(SDEFUN |UPDIVP;divideIfCan;2UPU;1!0| ((|x| NIL) ($$ NIL))
        (PROG (|ee| $)
          (LETT |ee| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |ee| (QREFELT $ 24)))))) 

(DECLAIM (NOTINLINE |UnivariatePolynomialDivisionPackage;|)) 

(DEFUN |UnivariatePolynomialDivisionPackage| (&REST #1=#:G720)
  (SPROG NIL
         (PROG (#2=#:G721)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|UnivariatePolynomialDivisionPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |UnivariatePolynomialDivisionPackage;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|UnivariatePolynomialDivisionPackage|)))))))))) 

(DEFUN |UnivariatePolynomialDivisionPackage;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|UnivariatePolynomialDivisionPackage| DV$1 DV$2))
          (LETT $ (GETREFV 32))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|UnivariatePolynomialDivisionPackage| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|UnivariatePolynomialDivisionPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Boolean|)
              (0 . |zero?|) (5 . |leadingCoefficient|) (10 . |One|)
              (14 . |One|) (18 . =)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (24 . |monicDivide|) (30 . |Zero|) (|NonNegativeInteger|)
              (34 . |degree|) (|Union| $ '"failed") (39 . |subtractIfCan|)
              (45 . |exquo|) (51 . |monomial|) (57 . +) (63 . +)
              (|Mapping| 17 17) (69 . |mapExponents|) (75 . *) (81 . -)
              (|Record| (|:| |quotient| 7) (|:| |remainder| 7))
              (|Union| 29 '"failed") |UPDIVP;divideIfCan;2UPU;1|)
           '#(|divideIfCan| 87) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|divideIfCan|
                                 ((|Union|
                                   (|Record| (|:| |quotient| |#2|)
                                             (|:| |remainder| |#2|))
                                   "failed")
                                  |#2| |#2|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 31
                                            '(1 7 8 0 9 1 7 6 0 10 0 6 0 11 0 7
                                              0 12 2 6 8 0 0 13 2 7 14 0 0 15 0
                                              7 0 16 1 7 17 0 18 2 17 19 0 0 20
                                              2 6 19 0 0 21 2 7 0 6 17 22 2 7 0
                                              0 0 23 2 17 0 0 0 24 2 7 0 25 0
                                              26 2 7 0 6 0 27 2 7 0 0 0 28 2 0
                                              30 7 7 31)))))
           '|lookupComplete|)) 
