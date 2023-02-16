
(SDEFUN |LSPP;poly2vect|
        ((|p| (P)) (|vs| (|List| OV))
         ($
          (|Record| (|:| |coefvec| (|Vector| (|Fraction| P)))
                    (|:| |reductum| (|Fraction| P)))))
        (SPROG
         ((|c| (P)) (|u| (|SparseUnivariatePolynomial| P)) (#1=#:G713 NIL)
          (|v| NIL) (|i| NIL) (|coefs| (|Vector| (|Fraction| P))))
         (SEQ (LETT |coefs| (MAKEARR1 (LENGTH |vs|) (|spadConstant| $ 11)))
              (SEQ (LETT |i| 1) (LETT |v| NIL) (LETT #1# |vs|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |v| (CAR #1#)) NIL)
                         (NULL
                          (SPADCALL |p| (|spadConstant| $ 14) (QREFELT $ 16))))
                     (GO G191)))
                   (SEQ (LETT |u| (SPADCALL |p| |v| (QREFELT $ 18)))
                        (EXIT
                         (COND ((EQL (SPADCALL |u| (QREFELT $ 21)) 0) "next v")
                               ('T
                                (SEQ
                                 (SPADCALL |coefs| |i|
                                           (SPADCALL
                                            (LETT |c|
                                                  (SPADCALL |u|
                                                            (QREFELT $ 22)))
                                            (QREFELT $ 23))
                                           (QREFELT $ 26))
                                 (EXIT
                                  (LETT |p|
                                        (SPADCALL |p|
                                                  (SPADCALL |c| |v| 1
                                                            (QREFELT $ 29))
                                                  (QREFELT $ 30)))))))))
                   (LETT #1# (PROG1 (CDR #1#) (LETT |i| (|inc_SI| |i|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |coefs| (SPADCALL |p| (QREFELT $ 23))))))) 

(SDEFUN |LSPP;intoMatrix;LLR;2|
        ((|ps| (|List| P)) (|vs| (|List| OV))
         ($
          (|Record| (|:| |mat| (|Matrix| (|Fraction| P)))
                    (|:| |vec| (|Vector| (|Fraction| P))))))
        (SPROG
         ((|m| (|Matrix| (|Fraction| P)))
          (|r|
           (|Record| (|:| |coefvec| (|Vector| (|Fraction| P)))
                     (|:| |reductum| (|Fraction| P))))
          (#1=#:G723 NIL) (|p| NIL) (|i| NIL) (|v| (|Vector| (|Fraction| P))))
         (SEQ (LETT |m| (SPADCALL (LENGTH |ps|) (LENGTH |vs|) (QREFELT $ 32)))
              (LETT |v| (MAKEARR1 (LENGTH |ps|) (|spadConstant| $ 11)))
              (SEQ (LETT |i| 1) (LETT |p| NIL) (LETT #1# |ps|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((> (SPADCALL |p| |vs| (QREFELT $ 34)) 1)
                       (|error| "The system is not linear"))
                      ('T
                       (SEQ (LETT |r| (|LSPP;poly2vect| |p| |vs| $))
                            (LETT |m|
                                  (SPADCALL |m| |i| (QCAR |r|) (QREFELT $ 35)))
                            (EXIT
                             (SPADCALL |v| |i|
                                       (SPADCALL (QCDR |r|) (QREFELT $ 36))
                                       (QREFELT $ 26))))))))
                   (LETT #1# (PROG1 (CDR #1#) (LETT |i| (|inc_SI| |i|))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |m| |v|))))) 

(SDEFUN |LSPP;linSolve;LLR;3|
        ((|ps| (|List| P)) (|vs| (|List| OV))
         ($
          (|Record|
           (|:| |particular| (|Union| (|Vector| (|Fraction| P)) "failed"))
           (|:| |basis| (|List| (|Vector| (|Fraction| P)))))))
        (SPROG
         ((|r|
           (|Record| (|:| |mat| (|Matrix| (|Fraction| P)))
                     (|:| |vec| (|Vector| (|Fraction| P))))))
         (SEQ (LETT |r| (SPADCALL |ps| |vs| (QREFELT $ 39)))
              (EXIT (SPADCALL (QCAR |r|) (QCDR |r|) (QREFELT $ 43)))))) 

(DECLAIM (NOTINLINE |LinearSystemPolynomialPackage;|)) 

(DEFUN |LinearSystemPolynomialPackage| (&REST #1=#:G730)
  (SPROG NIL
         (PROG (#2=#:G731)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|LinearSystemPolynomialPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |LinearSystemPolynomialPackage;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|LinearSystemPolynomialPackage|)))))))))) 

(DEFUN |LinearSystemPolynomialPackage;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|LinearSystemPolynomialPackage| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 45))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|LinearSystemPolynomialPackage|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|LinearSystemPolynomialPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|Fraction| 9) (0 . |Zero|)
              (4 . |Zero|) (8 . |Zero|) (12 . |Zero|) (|Boolean|) (16 . ~=)
              (|SparseUnivariatePolynomial| $) (22 . |univariate|)
              (|NonNegativeInteger|) (|SparseUnivariatePolynomial| 9)
              (28 . |degree|) (33 . |leadingCoefficient|) (38 . |coerce|)
              (|Integer|) (|Vector| 10) (43 . |setelt!|) (50 . |One|)
              (54 . |One|) (58 . |monomial|) (65 . -) (|Matrix| 10)
              (71 . |zero|) (|List| 8) (77 . |totalDegree|) (83 . |setRow!|)
              (90 . -) (|Record| (|:| |mat| 31) (|:| |vec| 25)) (|List| 9)
              |LSPP;intoMatrix;LLR;2| (|Union| 25 '"failed")
              (|Record| (|:| |particular| 40) (|:| |basis| (|List| 25)))
              (|LinearSystemMatrixPackage| 10 25 25 31) (95 . |solve|)
              |LSPP;linSolve;LLR;3|)
           '#(|linSolve| 101 |intoMatrix| 107) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|linSolve|
                                 ((|Record|
                                   (|:| |particular|
                                        (|Union| (|Vector| (|Fraction| |#4|))
                                                 "failed"))
                                   (|:| |basis|
                                        (|List| (|Vector| (|Fraction| |#4|)))))
                                  (|List| |#4|) (|List| |#3|)))
                                T)
                              '((|intoMatrix|
                                 ((|Record|
                                   (|:| |mat| (|Matrix| (|Fraction| |#4|)))
                                   (|:| |vec| (|Vector| (|Fraction| |#4|))))
                                  (|List| |#4|) (|List| |#3|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 44
                                            '(0 10 0 11 0 6 0 12 0 7 0 13 0 9 0
                                              14 2 9 15 0 0 16 2 9 17 0 8 18 1
                                              20 19 0 21 1 20 9 0 22 1 10 0 9
                                              23 3 25 10 0 24 10 26 0 6 0 27 0
                                              9 0 28 3 9 0 0 8 19 29 2 9 0 0 0
                                              30 2 31 0 19 19 32 2 9 19 0 33 34
                                              3 31 0 0 24 25 35 1 10 0 0 36 2
                                              42 41 31 25 43 2 0 41 38 33 44 2
                                              0 37 38 33 39)))))
           '|lookupComplete|)) 
