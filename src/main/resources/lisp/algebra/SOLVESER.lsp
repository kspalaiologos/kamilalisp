
(SDEFUN |SOLVESER;unvectorise;VFIF;1|
        ((|vect| (|Vector| (|Expression| R)))
         (|var| (|Fraction| (|SparseUnivariatePolynomial| (|Expression| R))))
         (|n| (|Integer|))
         ($ (|Fraction| (|SparseUnivariatePolynomial| (|Expression| R)))))
        (SPROG
         ((|polyvar|
           (|Fraction| (|SparseUnivariatePolynomial| (|Expression| R))))
          (#1=#:G716 NIL)
          (|vecti|
           (|Fraction| (|SparseUnivariatePolynomial| (|Expression| R))))
          (#2=#:G721 NIL) (|i| NIL) (Z (|Symbol|)))
         (SEQ (LETT Z (SPADCALL (QREFELT $ 8)))
              (LETT |polyvar| (|spadConstant| $ 10))
              (SEQ (LETT |i| 1) (LETT #2# (+ |n| 1)) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ
                    (LETT |vecti|
                          (SPADCALL (SPADCALL |vect| |i| (QREFELT $ 17))
                                    (SPADCALL Z (QREFELT $ 19))
                                    (QREFELT $ 22)))
                    (EXIT
                     (LETT |polyvar|
                           (SPADCALL |polyvar|
                                     (SPADCALL |vecti|
                                               (SPADCALL |var|
                                                         (PROG1
                                                             (LETT #1#
                                                                   (+
                                                                    (- |n| |i|)
                                                                    1))
                                                           (|check_subtype2|
                                                            (>= #1# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|) #1#))
                                                         (QREFELT $ 23))
                                               (QREFELT $ 24))
                                     (QREFELT $ 25)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |polyvar|)))) 

(SDEFUN |SOLVESER;decomposeFunc;4F;2|
        ((|exprf| (|Fraction| (|SparseUnivariatePolynomial| (|Expression| R))))
         (|exprg| (|Fraction| (|SparseUnivariatePolynomial| (|Expression| R))))
         (|newH| (|Fraction| (|SparseUnivariatePolynomial| (|Expression| R))))
         ($ (|Fraction| (|SparseUnivariatePolynomial| (|Expression| R)))))
        (SPROG
         ((|newF| (|Fraction| (|SparseUnivariatePolynomial| (|Expression| R))))
          (#1=#:G731 NIL)
          (|newF2|
           (|Union| (|SparseUnivariatePolynomial| (|Expression| R)) "failed"))
          (|newF1|
           (|Union| (|SparseUnivariatePolynomial| (|Expression| R)) "failed"))
          (|m| (|Integer|)) (N (|Union| (|NonNegativeInteger|) "failed"))
          (|degG| #2=(|NonNegativeInteger|)) (|degF| #2#)
          (|g2| #3=(|SparseUnivariatePolynomial| (|Expression| R)))
          (|g1| #4=(|SparseUnivariatePolynomial| (|Expression| R))) (|f2| #3#)
          (|f1| #4#))
         (SEQ
          (EXIT
           (SEQ (LETT |f1| (SPADCALL |exprf| (QREFELT $ 28)))
                (LETT |f2| (SPADCALL |exprf| (QREFELT $ 29)))
                (LETT |g1| (SPADCALL |exprg| (QREFELT $ 28)))
                (LETT |g2| (SPADCALL |exprg| (QREFELT $ 29)))
                (LETT |degF|
                      (MAX
                       (SPADCALL (SPADCALL |exprf| (QREFELT $ 28))
                                 (QREFELT $ 31))
                       (SPADCALL (SPADCALL |exprf| (QREFELT $ 29))
                                 (QREFELT $ 31))))
                (LETT |degG|
                      (MAX (SPADCALL |g1| (QREFELT $ 31))
                           (SPADCALL |g2| (QREFELT $ 31))))
                (LETT N (SPADCALL |degF| |degG| (QREFELT $ 33)))
                (EXIT
                 (COND ((QEQCAR N 1) (PROGN (LETT #1# |exprf|) (GO #5=#:G730)))
                       (#6='T
                        (SEQ (LETT |m| (QCDR N))
                             (LETT |newF1|
                                   (|SOLVESER;subsSolve| |f1| |degF| |g1| |g2|
                                    |m| |newH| $))
                             (COND
                              ((SPADCALL |f2| (|spadConstant| $ 34)
                                         (QREFELT $ 36))
                               (LETT |newF2| (CONS 0 (|spadConstant| $ 34))))
                              (#6#
                               (LETT |newF2|
                                     (|SOLVESER;subsSolve| |f2| |degF| |g1|
                                      |g2| |m| |newH| $))))
                             (EXIT
                              (COND
                               ((OR (QEQCAR |newF1| 1) (QEQCAR |newF2| 1))
                                (PROGN (LETT #1# |exprf|) (GO #5#)))
                               ('T
                                (LETT |newF|
                                      (SPADCALL (QCDR |newF1|) (QCDR |newF2|)
                                                (QREFELT $ 37))))))))))))
          #5# (EXIT #1#)))) 

(SDEFUN |SOLVESER;subsSolve|
        ((F (|SparseUnivariatePolynomial| (|Expression| R)))
         (|DegF| (|NonNegativeInteger|))
         (G1 (|SparseUnivariatePolynomial| (|Expression| R)))
         (G2 (|SparseUnivariatePolynomial| (|Expression| R))) (M (|Integer|))
         (HH (|Fraction| (|SparseUnivariatePolynomial| (|Expression| R))))
         ($
          (|Union| (|SparseUnivariatePolynomial| (|Expression| R)) "failed")))
        (SPROG
         ((|resul| (|SparseUnivariatePolynomial| (|Expression| R)))
          (|solvevarlist| (|Vector| (|Expression| R))) (#1=#:G788 NIL)
          (#2=#:G793 NIL)
          (|solvar|
           (|Record|
            (|:| |particular|
                 (|Union| (|Vector| (|Expression| R)) #3="failed"))
            (|:| |basis| (|List| (|Vector| (|Expression| R))))))
          (|coeffma| (|Matrix| (|Expression| R)))
          (|vec| (|Vector| (|Expression| R)))
          (|coeffmat| (|Matrix| (|Expression| R))) (#4=#:G784 NIL)
          (#5=#:G794 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |coeffmat|
                  (MAKE_MATRIX1 (+ |DegF| 1) 1 (|spadConstant| $ 39)))
            (SEQ (LETT |i| 0) (LETT #5# M) G190
                 (COND ((|greater_SI| |i| #5#) (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT |coeffmat|
                         (SPADCALL |coeffmat|
                                   (SPADCALL
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL G1
                                                (PROG1 (LETT #4# (- M |i|))
                                                  (|check_subtype2| (>= #4# 0)
                                                                    '(|NonNegativeInteger|)
                                                                    '(|Integer|)
                                                                    #4#))
                                                (QREFELT $ 40))
                                      (SPADCALL G2 |i| (QREFELT $ 40))
                                      (QREFELT $ 41))
                                     (+ |DegF| 1) (QREFELT $ 42))
                                    (QREFELT $ 44))
                                   (QREFELT $ 45)))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
            (LETT |vec| (SPADCALL F (+ |DegF| 1) (QREFELT $ 42)))
            (LETT |coeffma|
                  (SPADCALL |coeffmat| 1 (+ |DegF| 1) 2 (+ M 2)
                            (QREFELT $ 46)))
            (LETT |solvar| (SPADCALL |coeffma| |vec| (QREFELT $ 50)))
            (EXIT
             (COND
              ((QEQCAR (QCAR |solvar|) 1)
               (PROGN (LETT #2# (CONS 1 "failed")) (GO #6=#:G792)))
              ('T
               (SEQ
                (LETT |solvevarlist|
                      (PROG2 (LETT #1# (QCAR |solvar|))
                          (QCDR #1#)
                        (|check_union2| (QEQCAR #1# 0)
                                        (|Vector| (|Expression| (QREFELT $ 6)))
                                        (|Union|
                                         (|Vector|
                                          (|Expression| (QREFELT $ 6)))
                                         #3#)
                                        #1#)))
                (LETT |resul|
                      (SPADCALL (SPADCALL |solvevarlist| HH M (QREFELT $ 26))
                                (QREFELT $ 28)))
                (EXIT (CONS 0 |resul|))))))))
          #6# (EXIT #2#)))) 

(DECLAIM (NOTINLINE |TransSolvePackageService;|)) 

(DEFUN |TransSolvePackageService| (#1=#:G795)
  (SPROG NIL
         (PROG (#2=#:G796)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|TransSolvePackageService|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|TransSolvePackageService;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|TransSolvePackageService|)))))))))) 

(DEFUN |TransSolvePackageService;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|TransSolvePackageService| DV$1))
          (LETT $ (GETREFV 51))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|TransSolvePackageService|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|TransSolvePackageService| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Symbol|) (0 . |new|)
              (|Fraction| 27) (4 . |Zero|) (8 . |One|)
              (|SparseUnivariatePolynomial| 6) (12 . |One|) (|Expression| 6)
              (|Integer|) (|Vector| 14) (16 . |elt|) (|Kernel| 14)
              (22 . |kernel|) (|Fraction| (|SparseUnivariatePolynomial| $))
              (|Kernel| $) (27 . |univariate|) (33 . ^) (39 . *) (45 . +)
              |SOLVESER;unvectorise;VFIF;1| (|SparseUnivariatePolynomial| 14)
              (51 . |numer|) (56 . |denom|) (|NonNegativeInteger|)
              (61 . |degree|) (|Union| $ '"failed") (66 . |exquo|) (72 . |One|)
              (|Boolean|) (76 . =) (82 . /) |SOLVESER;decomposeFunc;4F;2|
              (88 . |Zero|) (92 . ^) (98 . *) (104 . |vectorise|) (|Matrix| 14)
              (110 . |coerce|) (115 . |horizConcat|) (121 . |subMatrix|)
              (|Union| 16 '"failed")
              (|Record| (|:| |particular| 47) (|:| |basis| (|List| 16)))
              (|LinearSystemMatrixPackage| 14 16 16 43) (130 . |solve|))
           '#(|unvectorise| 136 |decomposeFunc| 143) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|decomposeFunc|
                                 ((|Fraction|
                                   (|SparseUnivariatePolynomial|
                                    (|Expression| |#1|)))
                                  (|Fraction|
                                   (|SparseUnivariatePolynomial|
                                    (|Expression| |#1|)))
                                  (|Fraction|
                                   (|SparseUnivariatePolynomial|
                                    (|Expression| |#1|)))
                                  (|Fraction|
                                   (|SparseUnivariatePolynomial|
                                    (|Expression| |#1|)))))
                                T)
                              '((|unvectorise|
                                 ((|Fraction|
                                   (|SparseUnivariatePolynomial|
                                    (|Expression| |#1|)))
                                  (|Vector| (|Expression| |#1|))
                                  (|Fraction|
                                   (|SparseUnivariatePolynomial|
                                    (|Expression| |#1|)))
                                  (|Integer|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 50
                                            '(0 7 0 8 0 9 0 10 0 6 0 11 0 12 0
                                              13 2 16 14 0 15 17 1 18 0 7 19 2
                                              14 20 0 21 22 2 9 0 0 15 23 2 9 0
                                              0 0 24 2 9 0 0 0 25 1 9 27 0 28 1
                                              9 27 0 29 1 27 30 0 31 2 30 32 0
                                              0 33 0 27 0 34 2 27 35 0 0 36 2 9
                                              0 27 27 37 0 14 0 39 2 27 0 0 30
                                              40 2 27 0 0 0 41 2 27 16 0 30 42
                                              1 43 0 16 44 2 43 0 0 0 45 5 43 0
                                              0 15 15 15 15 46 2 49 48 43 16 50
                                              3 0 9 16 9 15 26 3 0 9 9 9 9
                                              38)))))
           '|lookupComplete|)) 
