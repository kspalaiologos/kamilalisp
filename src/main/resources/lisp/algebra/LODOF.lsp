
(SDEFUN |LODOF;factor;LodoML;1|
        ((|l| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         (|zeros| (|Mapping| (|List| F) UP))
         ($ (|List| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))))
        (|LODOF;innerFactor| |l| |zeros| (ELT $ 12) 'T $)) 

(SDEFUN |LODOF;expsol|
        ((|l| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         (|zeros| (|Mapping| (|List| F) UP))
         (|ezfactor| (|Mapping| (|Factored| UP) UP))
         ($ (|Union| (|Fraction| UP) "failed")))
        (SPROG ((|sol| (|List| (|Fraction| UP))))
               (COND
                ((NULL
                  (LETT |sol| (|LODOF;expsols| |l| |zeros| |ezfactor| NIL $)))
                 (CONS 1 "failed"))
                ('T (CONS 0 (|SPADfirst| |sol|)))))) 

(SDEFUN |LODOF;expsols|
        ((|l| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         (|zeros| (|Mapping| (|List| F) UP))
         (|ezfactor| (|Mapping| (|Factored| UP) UP)) (|all?| (|Boolean|))
         ($ (|List| (|Fraction| UP))))
        (SPROG
         ((|sol| (|List| (|Fraction| UP))) (#1=#:G749 NIL) (|f| NIL)
          (#2=#:G748 NIL))
         (SEQ
          (LETT |sol|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |f| NIL)
                      (LETT #1#
                            (QCDR
                             (SPADCALL |l| (|spadConstant| $ 19)
                                       (QREFELT $ 23))))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL |f| (|spadConstant| $ 19) (QREFELT $ 25))
                          (LETT #2#
                                (CONS
                                 (SPADCALL (SPADCALL |f| (QREFELT $ 26)) |f|
                                           (QREFELT $ 27))
                                 #2#))))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (COND ((NULL |all?|) (COND ((NULL (NULL |sol|)) (EXIT |sol|)))))
          (EXIT
           (SPADCALL |sol| (SPADCALL |l| |zeros| |ezfactor| (QREFELT $ 31))
                     (QREFELT $ 32)))))) 

(SDEFUN |LODOF;opeval|
        ((|l1| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         (|l2| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         ($ (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP))))
        (SPROG
         ((|l2n| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
          (|ans| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
          (#1=#:G758 NIL) (|i| NIL))
         (SEQ (LETT |ans| (|spadConstant| $ 33))
              (LETT |l2n| (|spadConstant| $ 34))
              (SEQ (LETT |i| 0) (LETT #1# (SPADCALL |l1| (QREFELT $ 36))) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (LETT |ans|
                          (SPADCALL |ans|
                                    (SPADCALL
                                     (SPADCALL |l1| |i| (QREFELT $ 37)) |l2n|
                                     (QREFELT $ 38))
                                    (QREFELT $ 39)))
                    (EXIT (LETT |l2n| (SPADCALL |l2| |l2n| (QREFELT $ 40)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |LODOF;recurfactor|
        ((|l| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         (|r| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         (|zeros| (|Mapping| (|List| F) UP))
         (|ezfactor| (|Mapping| (|Factored| UP) UP)) (|adj?| (|Boolean|))
         ($ (|List| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))))
        (SPROG
         ((|q| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
          (#1=#:G760 NIL))
         (SEQ
          (LETT |q|
                (PROG2 (LETT #1# (SPADCALL |l| |r| (QREFELT $ 42)))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0)
                                  (|LinearOrdinaryDifferentialOperator1|
                                   (|Fraction| (QREFELT $ 7)))
                                  (|Union|
                                   (|LinearOrdinaryDifferentialOperator1|
                                    (|Fraction| (QREFELT $ 7)))
                                   "failed")
                                  #1#)))
          (EXIT (|LODOF;innerFactor| |q| |zeros| |ezfactor| 'T $))))) 

(SDEFUN |LODOF;rfactor|
        ((|op| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         (|r| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         (|zeros| (|Mapping| (|List| F) UP))
         (|ezfactor| (|Mapping| (|Factored| UP) UP)) (|adj?| (|Boolean|))
         ($ (|List| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))))
        (SPROG
         ((|op1| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP))))
         (SEQ
          (COND
           ((OR (> (SPADCALL |r| (QREFELT $ 36)) 1)
                (NULL
                 (SPADCALL (SPADCALL |r| (QREFELT $ 44)) (|spadConstant| $ 45)
                           (QREFELT $ 46))))
            (|LODOF;recurfactor| |op| |r| |zeros| |ezfactor| |adj?| $))
           ('T
            (SEQ
             (LETT |op1|
                   (|LODOF;opeval| |op|
                    (SPADCALL (QREFELT $ 10)
                              (SPADCALL (SPADCALL |r| 0 (QREFELT $ 37))
                                        (QREFELT $ 47))
                              (QREFELT $ 48))
                    $))
             (EXIT
              (SPADCALL (CONS #'|LODOF;rfactor!0| (VECTOR $ |r|))
                        (|LODOF;recurfactor| |op1| (QREFELT $ 10) |zeros|
                         |ezfactor| |adj?| $)
                        (QREFELT $ 50))))))))) 

(SDEFUN |LODOF;rfactor!0| ((|z1| NIL) ($$ NIL))
        (PROG (|r| $)
          (LETT |r| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|LODOF;opeval| |z1| |r| $))))) 

(SDEFUN |LODOF;innerFactor|
        ((|l| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         (|zeros| (|Mapping| (|List| F) UP))
         (|ezfactor| (|Mapping| (|Factored| UP) UP)) (|r1?| (|Boolean|))
         ($ (|List| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))))
        (SPROG
         ((#1=#:G803 NIL) (#2=#:G804 NIL)
          (|u|
           (|Union| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP))
                    "failed"))
          (#3=#:G805 NIL) (|i| NIL)
          (|ll| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (SPADCALL |l| (QREFELT $ 36)))
                (EXIT
                 (COND ((<= |n| 1) (LIST |l|))
                       ('T
                        (SEQ (LETT |ll| (SPADCALL |l| (QREFELT $ 52)))
                             (SEQ (LETT |i| 1) (LETT #3# (QUOTIENT2 |n| 2))
                                  G190
                                  (COND ((|greater_SI| |i| #3#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (SEQ
                                     (COND
                                      ((OR |r1?| (> |i| 1))
                                       (SEQ
                                        (LETT |u|
                                              (|LODOF;rightFactor| |l| |i|
                                               |zeros| |ezfactor| $))
                                        (EXIT
                                         (COND
                                          ((QEQCAR |u| 0)
                                           (PROGN
                                            (LETT #1#
                                                  (PROGN
                                                   (LETT #2#
                                                         (SPADCALL
                                                          (|LODOF;rfactor| |l|
                                                           (QCDR |u|) |zeros|
                                                           |ezfactor| NIL $)
                                                          (QCDR |u|)
                                                          (QREFELT $ 53)))
                                                   (GO #4=#:G802)))
                                            (GO #5=#:G798))))))))
                                     (EXIT
                                      (COND
                                       ((< (* 2 |i|) |n|)
                                        (SEQ
                                         (LETT |u|
                                               (|LODOF;rightFactor| |ll| |i|
                                                |zeros| |ezfactor| $))
                                         (EXIT
                                          (COND
                                           ((QEQCAR |u| 0)
                                            (PROGN
                                             (LETT #1#
                                                   (PROGN
                                                    (LETT #2#
                                                          (CONS
                                                           (SPADCALL (QCDR |u|)
                                                                     (QREFELT $
                                                                              52))
                                                           (SPADCALL (ELT $ 52)
                                                                     (NREVERSE
                                                                      (|LODOF;rfactor|
                                                                       |ll|
                                                                       (QCDR
                                                                        |u|)
                                                                       |zeros|
                                                                       |ezfactor|
                                                                       'T $))
                                                                     (QREFELT $
                                                                              50))))
                                                    (GO #4#)))
                                             (GO #5#)))))))))))
                                   #5# (EXIT #1#))
                                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                  (EXIT NIL))
                             (EXIT (LIST |l|))))))))
          #4# (EXIT #2#)))) 

(SDEFUN |LODOF;rightFactor|
        ((|l| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         (|n| (|NonNegativeInteger|)) (|zeros| (|Mapping| (|List| F) UP))
         (|ezfactor| (|Mapping| (|Factored| UP) UP))
         ($
          (|Union| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP))
                   "failed")))
        (SPROG ((|u| (|Union| (|Fraction| UP) "failed")))
               (SEQ
                (COND
                 ((EQL |n| 1)
                  (SEQ (LETT |u| (|LODOF;expsol| |l| |zeros| |ezfactor| $))
                       (EXIT
                        (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                              (#1='T
                               (CONS 0
                                     (SPADCALL (SPADCALL (QREFELT $ 9))
                                               (SPADCALL (QCDR |u|)
                                                         (QREFELT $ 47))
                                               (QREFELT $ 48))))))))
                 (#1# (CONS 1 "failed")))))) 

(SDEFUN |LODOF;zro|
        ((|p| (UP)) (|ezfactor| (|Mapping| (|Factored| UP) UP)) ($ (|List| F)))
        (SPROG ((#1=#:G821 NIL) (|r| NIL) (#2=#:G820 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |r| NIL)
                       (LETT #1#
                             (SPADCALL (SPADCALL |p| |ezfactor|)
                                       (QREFELT $ 57)))
                       G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |r| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2# (CONS (|LODOF;zro1| (QCAR |r|) $) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 60))))) 

(SDEFUN |LODOF;zro1| ((|p| (UP)) ($ (|List| F)))
        (LIST
         (SPADCALL (SPADCALL (LIST #'|LODOF;zro1!0|) |p| (QREFELT $ 64))
                   (QREFELT $ 66)))) 

(SDEFUN |LODOF;zro1!0| ((|z1| NIL) ($$ NIL)) |z1|) 

(SDEFUN |LODOF;factor;LodoL;11|
        ((|l| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         ($ (|List| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))))
        (|LODOF;innerFactor| |l| (CONS #'|LODOF;factor;LodoL;11!0| $)
         (ELT $ 67) 'T $)) 

(SDEFUN |LODOF;factor;LodoL;11!0| ((|p1| NIL) ($ NIL))
        (|LODOF;zro| |p1| (ELT $ 67) $)) 

(SDEFUN |LODOF;factor1;LodoL;12|
        ((|l| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         ($ (|List| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))))
        (|LODOF;innerFactor| |l| (CONS #'|LODOF;factor1;LodoL;12!0| $)
         (ELT $ 67) NIL $)) 

(SDEFUN |LODOF;factor1;LodoL;12!0| ((|p1| NIL) ($ NIL))
        (|LODOF;zro| |p1| (ELT $ 67) $)) 

(SDEFUN |LODOF;factor;LodoL;13|
        ((|l| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         ($ (|List| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))))
        (|LODOF;innerFactor| |l| (CONS #'|LODOF;factor;LodoL;13!0| $)
         (ELT $ 12) 'T $)) 

(SDEFUN |LODOF;factor;LodoL;13!0| ((|p1| NIL) ($ NIL))
        (|LODOF;zro| |p1| (ELT $ 12) $)) 

(SDEFUN |LODOF;factor1;LodoL;14|
        ((|l| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         ($ (|List| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))))
        (|LODOF;innerFactor| |l| (CONS #'|LODOF;factor1;LodoL;14!0| $)
         (ELT $ 12) NIL $)) 

(SDEFUN |LODOF;factor1;LodoL;14!0| ((|p1| NIL) ($ NIL))
        (|LODOF;zro| |p1| (ELT $ 12) $)) 

(DECLAIM (NOTINLINE |LinearOrdinaryDifferentialOperatorFactorizer;|)) 

(DEFUN |LinearOrdinaryDifferentialOperatorFactorizer| (&REST #1=#:G846)
  (SPROG NIL
         (PROG (#2=#:G847)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|LinearOrdinaryDifferentialOperatorFactorizer|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function|
                        |LinearOrdinaryDifferentialOperatorFactorizer;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|LinearOrdinaryDifferentialOperatorFactorizer|)))))))))) 

(DEFUN |LinearOrdinaryDifferentialOperatorFactorizer;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$|
                (LIST '|LinearOrdinaryDifferentialOperatorFactorizer| DV$1
                      DV$2))
          (LETT $ (GETREFV 70))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|AlgebraicallyClosedField|))))))
          (|haddProp| |$ConstructorCache|
                      '|LinearOrdinaryDifferentialOperatorFactorizer|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 10 (SPADCALL (QREFELT $ 9)))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (COND
              ((|domainEqual| |#1| (|AlgebraicNumber|))
               (PROGN
                (QSETREFV $ 68
                          (CONS (|dispatchFunction| |LODOF;factor;LodoL;11|)
                                $))
                (QSETREFV $ 69
                          (CONS (|dispatchFunction| |LODOF;factor1;LodoL;12|)
                                $))))
              ('T
               (PROGN
                (QSETREFV $ 68
                          (CONS (|dispatchFunction| |LODOF;factor;LodoL;13|)
                                $))
                (QSETREFV $ 69
                          (CONS (|dispatchFunction| |LODOF;factor1;LodoL;14|)
                                $))))))))
          $))) 

(MAKEPROP '|LinearOrdinaryDifferentialOperatorFactorizer| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|LinearOrdinaryDifferentialOperator1| 18) (0 . D) '|dd|
              (|Factored| $) (4 . |squareFree|) (|List| 8) (|Mapping| 59 7)
              |LODOF;factor;LodoML;1| (9 . |Zero|) (13 . |Zero|) (|Fraction| 7)
              (17 . |Zero|) (|Union| 18 '"failed")
              (|Record| (|:| |particular| 20) (|:| |basis| 28))
              (|RationalLODE| 6 7) (21 . |ratDsolve|) (|Boolean|) (27 . ~=)
              (33 . |differentiate|) (38 . /) (|List| 18) (|Mapping| 56 7)
              (|RationalRicDE| 6 7) (44 . |ricDsolve|) (51 . |concat|)
              (57 . |Zero|) (61 . |One|) (|NonNegativeInteger|) (65 . |degree|)
              (70 . |coefficient|) (76 . *) (82 . +) (88 . *)
              (|Union| $ '"failed") (94 . |rightExactQuotient|) (100 . |One|)
              (104 . |leadingCoefficient|) (109 . |One|) (113 . =)
              (119 . |coerce|) (124 . -) (|Mapping| 8 8) (130 . |map!|)
              (136 . |One|) (140 . |adjoint|) (145 . |concat!|)
              (|Record| (|:| |factor| 7) (|:| |exponent| 35)) (|List| 54)
              (|Factored| 7) (151 . |factors|) (|List| $) (|List| 6)
              (156 . |concat|) (|SparseUnivariatePolynomial| 6) (|Mapping| 6 6)
              (|UnivariatePolynomialCategoryFunctions2| 6 7 6 61) (161 . |map|)
              (|SparseUnivariatePolynomial| $) (167 . |zeroOf|)
              (172 . |factor|) (177 . |factor|) (182 . |factor1|))
           '#(|factor1| 187 |factor| 192) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|factor|
                                 ((|List|
                                   (|LinearOrdinaryDifferentialOperator1|
                                    (|Fraction| |#2|)))
                                  (|LinearOrdinaryDifferentialOperator1|
                                   (|Fraction| |#2|))
                                  (|Mapping| (|List| |#1|) |#2|)))
                                T)
                              '((|factor|
                                 ((|List|
                                   (|LinearOrdinaryDifferentialOperator1|
                                    (|Fraction| |#2|)))
                                  (|LinearOrdinaryDifferentialOperator1|
                                   (|Fraction| |#2|))))
                                (|has| 6 (|AlgebraicallyClosedField|)))
                              '((|factor1|
                                 ((|List|
                                   (|LinearOrdinaryDifferentialOperator1|
                                    (|Fraction| |#2|)))
                                  (|LinearOrdinaryDifferentialOperator1|
                                   (|Fraction| |#2|))))
                                (|has| 6 (|AlgebraicallyClosedField|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 69
                                            '(0 8 0 9 1 7 11 0 12 0 6 0 16 0 7
                                              0 17 0 18 0 19 2 22 21 8 18 23 2
                                              18 24 0 0 25 1 18 0 0 26 2 18 0 0
                                              0 27 3 30 28 8 14 29 31 2 28 0 0
                                              0 32 0 8 0 33 0 8 0 34 1 8 35 0
                                              36 2 8 18 0 35 37 2 8 0 18 0 38 2
                                              8 0 0 0 39 2 8 0 0 0 40 2 8 41 0
                                              0 42 0 6 0 43 1 8 18 0 44 0 18 0
                                              45 2 18 24 0 0 46 1 8 0 18 47 2 8
                                              0 0 0 48 2 13 0 49 0 50 0 7 0 51
                                              1 8 0 0 52 2 13 0 0 8 53 1 56 55
                                              0 57 1 59 0 58 60 2 63 61 62 7 64
                                              1 6 0 65 66 1 7 11 0 67 1 0 13 8
                                              68 1 0 13 8 69 1 1 13 8 69 1 1 13
                                              8 68 2 0 13 8 14 15)))))
           '|lookupComplete|)) 
