
(SDEFUN |ODECONST;constDsolve;LFSR;1|
        ((|op| (L)) (|g| (F)) (|x| (|Symbol|))
         ($ (|Record| (|:| |particular| F) (|:| |basis| (|List| F)))))
        (SPROG ((#1=#:G702 NIL) (|b| (|List| F)))
               (SEQ
                (LETT |b|
                      (|ODECONST;homoBasis| |op| (SPADCALL |x| (QREFELT $ 10))
                       $))
                (EXIT
                 (CONS
                  (PROG2
                      (LETT #1#
                            (SPADCALL |op| |g| |b|
                                      (CONS #'|ODECONST;constDsolve;LFSR;1!0|
                                            (VECTOR $ |x|))
                                      (QREFELT $ 17)))
                      (QCDR #1#)
                    (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                    (|Union| (QREFELT $ 7) "failed") #1#))
                  |b|))))) 

(SDEFUN |ODECONST;constDsolve;LFSR;1!0| ((|f1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |f1| |x| (QREFELT $ 12)))))) 

(SDEFUN |ODECONST;homoBasis| ((|op| (L)) (|x| (F)) ($ (|List| F)))
        (SPROG
         ((|b| (|List| F)) (#1=#:G729 NIL) (|ff| NIL)
          (|fp| (|Factored| (|SparseUnivariatePolynomial| F)))
          (|p| (|SparseUnivariatePolynomial| F)))
         (SEQ (LETT |p| (|spadConstant| $ 21))
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL |op| (|spadConstant| $ 24) (QREFELT $ 26)))
                     (GO G191)))
                   (SEQ
                    (LETT |p|
                          (SPADCALL |p|
                                    (SPADCALL (SPADCALL |op| (QREFELT $ 27))
                                              (SPADCALL |op| (QREFELT $ 29))
                                              (QREFELT $ 30))
                                    (QREFELT $ 31)))
                    (EXIT (LETT |op| (SPADCALL |op| (QREFELT $ 32)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |b| NIL) (LETT |fp| (SPADCALL |p| (QREFELT $ 35)))
              (SEQ (LETT |ff| NIL) (LETT #1# (SPADCALL |fp| (QREFELT $ 39)))
                   G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |ff| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |b|
                           (SPADCALL |b|
                                     (|ODECONST;basisSol| (QVELT |ff| 1)
                                      (- (QVELT |ff| 2) 1) |x| $)
                                     (QREFELT $ 40)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |b|)))) 

(SDEFUN |ODECONST;basisSol|
        ((|p| (|SparseUnivariatePolynomial| F)) (|n| (|Integer|)) (|x| (F))
         ($ (|List| F)))
        (SPROG
         ((|xn| (F)) (|l| (|List| F)) (#1=#:G744 NIL) (|f| NIL) (#2=#:G743 NIL)
          (#3=#:G742 NIL) (|i| NIL) (|ll| (|List| F)))
         (SEQ (LETT |l| (|ODECONST;basisSqfr| |p| |x| $))
              (EXIT
               (COND ((ZEROP |n|) |l|)
                     ('T
                      (SEQ (LETT |ll| (SPADCALL |l| (QREFELT $ 41)))
                           (LETT |xn| |x|)
                           (SEQ (LETT |i| 1) (LETT #3# |n|) G190
                                (COND ((|greater_SI| |i| #3#) (GO G191)))
                                (SEQ
                                 (LETT |l|
                                       (SPADCALL |l|
                                                 (PROGN
                                                  (LETT #2# NIL)
                                                  (SEQ (LETT |f| NIL)
                                                       (LETT #1# |ll|) G190
                                                       (COND
                                                        ((OR (ATOM #1#)
                                                             (PROGN
                                                              (LETT |f|
                                                                    (CAR #1#))
                                                              NIL))
                                                         (GO G191)))
                                                       (SEQ
                                                        (EXIT
                                                         (LETT #2#
                                                               (CONS
                                                                (SPADCALL |xn|
                                                                          |f|
                                                                          (QREFELT
                                                                           $
                                                                           42))
                                                                #2#))))
                                                       (LETT #1# (CDR #1#))
                                                       (GO G190) G191
                                                       (EXIT (NREVERSE #2#))))
                                                 (QREFELT $ 40)))
                                 (EXIT
                                  (LETT |xn|
                                        (SPADCALL |x| |xn| (QREFELT $ 42)))))
                                (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                (EXIT NIL))
                           (EXIT |l|)))))))) 

(SDEFUN |ODECONST;basisSqfr|
        ((|p| (|SparseUnivariatePolynomial| F)) (|x| (F)) ($ (|List| F)))
        (SPROG
         ((#1=#:G751 NIL) (|a| NIL) (#2=#:G750 NIL)
          (|d| (|NonNegativeInteger|)))
         (SEQ (LETT |d| (SPADCALL |p| (QREFELT $ 43)))
              (EXIT
               (COND
                ((EQL |d| 1)
                 (LIST
                  (SPADCALL
                   (SPADCALL
                    (SPADCALL
                     (SPADCALL (SPADCALL |p| 0 (QREFELT $ 46)) |x|
                               (QREFELT $ 42))
                     (SPADCALL |p| (QREFELT $ 47)) (QREFELT $ 48))
                    (QREFELT $ 49))
                   (QREFELT $ 50))))
                ((EQL |d| 2) (|ODECONST;quadSol| |p| |x| $))
                ('T
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |a| NIL) (LETT #1# (SPADCALL |p| (QREFELT $ 53)))
                       G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |a| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS
                                (SPADCALL (SPADCALL |a| |x| (QREFELT $ 42))
                                          (QREFELT $ 50))
                                #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#)))))))))) 

(SDEFUN |ODECONST;quadSol|
        ((|p| (|SparseUnivariatePolynomial| F)) (|x| (F)) ($ (|List| F)))
        (SPROG
         ((#1=#:G764 NIL) (#2=#:G763 NIL) (#3=#:G762 NIL) (|i| (F)) (|r| (F))
          (|y| (F)) (|u| (|Union| (|Integer|) "failed")) (|delta| (F))
          (|c| (F)) (|a| (F)) (|b| (F)))
         (SEQ
          (EXIT
           (SEQ
            (SEQ
             (LETT |u|
                   (SPADCALL
                    (LETT |delta|
                          (SPADCALL
                           (SPADCALL (LETT |b| (SPADCALL |p| 1 (QREFELT $ 46)))
                                     2 (QREFELT $ 55))
                           (SPADCALL
                            (SPADCALL 4
                                      (LETT |a| (SPADCALL |p| (QREFELT $ 47)))
                                      (QREFELT $ 56))
                            (LETT |c| (SPADCALL |p| 0 (QREFELT $ 46)))
                            (QREFELT $ 42))
                           (QREFELT $ 57)))
                    (QREFELT $ 60)))
             (EXIT
              (COND
               ((QEQCAR |u| 0)
                (COND
                 ((MINUSP (QCDR |u|))
                  (PROGN
                   (LETT #3#
                         (SEQ
                          (LETT |y|
                                (SPADCALL |x| (SPADCALL 2 |a| (QREFELT $ 56))
                                          (QREFELT $ 48)))
                          (LETT |r|
                                (SPADCALL (SPADCALL |b| |y| (QREFELT $ 42))
                                          (QREFELT $ 49)))
                          (LETT |i|
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |delta| (QREFELT $ 49))
                                            (QREFELT $ 61))
                                  (QREFELT $ 63))
                                 |y| (QREFELT $ 42)))
                          (EXIT
                           (LIST
                            (SPADCALL (SPADCALL |r| (QREFELT $ 50))
                                      (SPADCALL |i| (QREFELT $ 64))
                                      (QREFELT $ 42))
                            (SPADCALL (SPADCALL |r| (QREFELT $ 50))
                                      (SPADCALL |i| (QREFELT $ 65))
                                      (QREFELT $ 42))))))
                   (GO #4=#:G760))))))))
            (EXIT
             (PROGN
              (LETT #2# NIL)
              (SEQ (LETT #1# (SPADCALL |p| (QREFELT $ 66))) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |a| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT #2#
                           (CONS
                            (SPADCALL (SPADCALL |a| |x| (QREFELT $ 42))
                                      (QREFELT $ 50))
                            #2#))))
                   (LETT #1# (CDR #1#)) (GO G190) G191
                   (EXIT (NREVERSE #2#)))))))
          #4# (EXIT #3#)))) 

(DECLAIM (NOTINLINE |ConstantLODE;|)) 

(DEFUN |ConstantLODE| (&REST #1=#:G765)
  (SPROG NIL
         (PROG (#2=#:G766)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ConstantLODE|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ConstantLODE;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|ConstantLODE|)))))))))) 

(DEFUN |ConstantLODE;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|ConstantLODE| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 67))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ConstantLODE| (LIST DV$1 DV$2 DV$3)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ConstantLODE| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Symbol|) (0 . |coerce|) (|ODEIntegration| 6 7)
              (5 . |int|) (|Union| 7 '"failed") (|List| 7) (|Mapping| 7 7)
              (|ODETools| 7 8) (11 . |particularSolution|)
              (|Record| (|:| |particular| 7) (|:| |basis| 14))
              |ODECONST;constDsolve;LFSR;1| (|SparseUnivariatePolynomial| 7)
              (19 . |Zero|) (23 . |Zero|) (27 . |Zero|) (31 . |Zero|)
              (|Boolean|) (35 . ~=) (41 . |leadingCoefficient|)
              (|NonNegativeInteger|) (46 . |degree|) (51 . |monomial|) (57 . +)
              (63 . |reductum|) (|Factored| 20)
              (|ExpressionFactorPolynomial| 6 7) (68 . |factorPolynomial|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 36) (|:| |factor| 20) (|:| |exponent| 28))
              (|List| 37) (73 . |factorList|) (78 . |concat!|) (84 . |copy|)
              (89 . *) (95 . |degree|) (100 . |One|) (104 . |One|)
              (108 . |coefficient|) (114 . |leadingCoefficient|) (119 . /)
              (125 . -) (130 . |exp|) (|List| $)
              (|SparseUnivariatePolynomial| $) (135 . |rootsOf|)
              (|PositiveInteger|) (140 . ^) (146 . *) (152 . -)
              (|Union| (|Integer|) '"failed") (|ElementaryFunctionSign| 6 7)
              (158 . |sign|) (163 . |sqrt|) (|AlgebraicManipulations| 6 7)
              (168 . |rootSimp|) (173 . |cos|) (178 . |sin|) (183 . |zerosOf|))
           '#(|constDsolve| 188) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|constDsolve|
                                 ((|Record| (|:| |particular| |#2|)
                                            (|:| |basis| (|List| |#2|)))
                                  |#3| |#2| (|Symbol|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 66
                                            '(1 7 0 9 10 2 11 7 7 9 12 4 16 13
                                              8 7 14 15 17 0 20 0 21 0 6 0 22 0
                                              7 0 23 0 8 0 24 2 8 25 0 0 26 1 8
                                              7 0 27 1 8 28 0 29 2 20 0 7 28 30
                                              2 20 0 0 0 31 1 8 0 0 32 1 34 33
                                              20 35 1 33 38 0 39 2 14 0 0 0 40
                                              1 14 0 0 41 2 7 0 0 0 42 1 20 28
                                              0 43 0 6 0 44 0 7 0 45 2 20 7 0
                                              28 46 1 20 7 0 47 2 7 0 0 0 48 1
                                              7 0 0 49 1 7 0 0 50 1 7 51 52 53
                                              2 7 0 0 54 55 2 7 0 54 0 56 2 7 0
                                              0 0 57 1 59 58 7 60 1 7 0 0 61 1
                                              62 7 7 63 1 7 0 0 64 1 7 0 0 65 1
                                              7 51 52 66 3 0 18 8 7 9 19)))))
           '|lookupComplete|)) 
