
(SDEFUN |CMPLXRT;complexZeros;UPParL;1|
        ((|p| (UP)) (|eps| (|Par|)) ($ (|List| (|Complex| |Par|))))
        (SPROG
         ((|ris| (|List| (|Complex| |Par|))) (#1=#:G740 NIL) (|z| NIL)
          (#2=#:G739 NIL) (|lz| (|List| (|List| |Par|)))
          (|p2| #3=(|Polynomial| (|Integer|))) (|p1| #3#)
          (|q| (|Polynomial| (|Complex| (|Integer|))))
          (|pp| #4=(|SparseUnivariatePolynomial| (|Complex| (|Integer|))))
          (#5=#:G738 NIL) (|pf| NIL)
          (|lpf|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| #4#)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|np| (|SparseUnivariatePolynomial| (|Complex| (|Integer|))))
          (|vv| #6=(|Symbol|)) (|x2| #6#) (|x1| #6#))
         (SEQ (LETT |x1| (SPADCALL (QREFELT $ 9)))
              (LETT |x2| (SPADCALL (QREFELT $ 9)))
              (LETT |vv| (SPADCALL (QREFELT $ 9)))
              (LETT |np| (SPADCALL |p| (QREFELT $ 11)))
              (LETT |lpf|
                    (SPADCALL (SPADCALL |np| (QREFELT $ 13)) (QREFELT $ 18)))
              (LETT |ris| NIL)
              (SEQ (LETT |pf| NIL) (LETT #5# |lpf|) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |pf| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |pp| (QVELT |pf| 1))
                        (LETT |q| (SPADCALL |pp| |vv| (QREFELT $ 20)))
                        (LETT |q|
                              (SPADCALL |q| |vv|
                                        (SPADCALL
                                         (SPADCALL |x1| (QREFELT $ 21))
                                         (SPADCALL
                                          (SPADCALL 0 1 (QREFELT $ 27))
                                          (SPADCALL |x2| (QREFELT $ 21))
                                          (QREFELT $ 28))
                                         (QREFELT $ 29))
                                        (QREFELT $ 30)))
                        (LETT |p1| (SPADCALL (ELT $ 31) |q| (QREFELT $ 35)))
                        (LETT |p2| (SPADCALL (ELT $ 36) |q| (QREFELT $ 35)))
                        (LETT |lz|
                              (SPADCALL (LIST |p1| |p2|) NIL (LIST |x1| |x2|)
                                        |eps| (QREFELT $ 41)))
                        (EXIT
                         (LETT |ris|
                               (SPADCALL
                                (PROGN
                                 (LETT #2# NIL)
                                 (SEQ (LETT |z| NIL) (LETT #1# |lz|) G190
                                      (COND
                                       ((OR (ATOM #1#)
                                            (PROGN (LETT |z| (CAR #1#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #2#
                                              (CONS
                                               (SPADCALL (|SPADfirst| |z|)
                                                         (SPADCALL |z|
                                                                   (QREFELT $
                                                                            43))
                                                         (QREFELT $ 45))
                                               #2#))))
                                      (LETT #1# (CDR #1#)) (GO G190) G191
                                      (EXIT (NREVERSE #2#))))
                                |ris| (QREFELT $ 47)))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
              (EXIT |ris|)))) 

(DECLAIM (NOTINLINE |ComplexRootPackage;|)) 

(DEFUN |ComplexRootPackage| (&REST #1=#:G741)
  (SPROG NIL
         (PROG (#2=#:G742)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ComplexRootPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ComplexRootPackage;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|ComplexRootPackage|)))))))))) 

(DEFUN |ComplexRootPackage;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|ComplexRootPackage| DV$1 DV$2))
          (LETT $ (GETREFV 49))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ComplexRootPackage|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ComplexRootPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Symbol|)
              (0 . |new|) (|SparseUnivariatePolynomial| 26) (4 . |makeSUP|)
              (|Factored| $) (9 . |factor|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 14) (|:| |factor| 10)
                        (|:| |exponent| (|NonNegativeInteger|)))
              (|List| 15) (|Factored| 10) (14 . |factorList|) (|Polynomial| 26)
              (19 . |multivariate|) (25 . |coerce|) (30 . |Zero|) (34 . |Zero|)
              (38 . |One|) (|Integer|) (|Complex| 25) (42 . |complex|) (48 . *)
              (54 . +) (60 . |eval|) (67 . |real|) (|Polynomial| 25)
              (|Mapping| 25 26) (|PolynomialFunctions2| 26 25) (72 . |map|)
              (78 . |imag|) (|List| 42) (|List| 32) (|List| 8)
              (|InnerNumericFloatSolvePackage| 25 7 7) (83 . |innerSolve|)
              (|List| 7) (91 . |second|) (|Complex| 7) (96 . |complex|)
              (|List| 44) (102 . |append|) |CMPLXRT;complexZeros;UPParL;1|)
           '#(|complexZeros| 108) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|complexZeros|
                                 ((|List| (|Complex| |#2|)) |#1| |#2|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 48
                                            '(0 8 0 9 1 6 10 0 11 1 10 12 0 13
                                              1 17 16 0 18 2 19 0 10 8 20 1 19
                                              0 8 21 0 6 0 22 0 7 0 23 0 6 0 24
                                              2 26 0 25 25 27 2 19 0 26 0 28 2
                                              19 0 0 0 29 3 19 0 0 8 0 30 1 26
                                              25 0 31 2 34 32 33 19 35 1 26 25
                                              0 36 4 40 37 38 38 39 7 41 1 42 7
                                              0 43 2 44 0 7 7 45 2 46 0 0 0 47
                                              2 0 46 6 7 48)))))
           '|lookupComplete|)) 
