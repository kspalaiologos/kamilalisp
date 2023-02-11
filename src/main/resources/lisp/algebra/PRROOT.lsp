
(SDEFUN |PRROOT;get_rational_roots;UPL;1|
        ((|p| (UP)) ($ (|List| (|Fraction| (|Integer|)))))
        (SPROG
         ((|res| (|List| (|Fraction| (|Integer|))))
          (|val1r| (|Fraction| (|Integer|)))
          (|fac| #1=(|SparseUnivariatePolynomial| (|Integer|))) (#2=#:G726 NIL)
          (|facr| NIL)
          (|facl|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| #1#)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (|ff| (|Factored| (|SparseUnivariatePolynomial| (|Integer|))))
          (|eq2z| (|SparseUnivariatePolynomial| (|Integer|)))
          (|pl2| (|List| (|SparseUnivariatePolynomial| (|Integer|))))
          (#3=#:G725 NIL) (|i| NIL) (#4=#:G724 NIL)
          (|vvr| (|Matrix| (|Integer|))) (|vm| (|Matrix| F))
          (|vv| (|Vector| F)) (|nn| (|NonNegativeInteger|)))
         (SEQ (LETT |nn| (+ (SPADCALL |p| (QREFELT $ 9)) 1))
              (LETT |vv| (SPADCALL |p| |nn| (QREFELT $ 11)))
              (LETT |vm|
                    (SPADCALL (LIST (SPADCALL |vv| (QREFELT $ 13)))
                              (QREFELT $ 16)))
              (LETT |vvr| (SPADCALL |vm| (QREFELT $ 19)))
              (LETT |pl2|
                    (PROGN
                     (LETT #4# NIL)
                     (SEQ (LETT |i| 1) (LETT #3# (ANROWS |vvr|)) G190
                          (COND ((|greater_SI| |i| #3#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #4#
                                  (CONS
                                   (SPADCALL
                                    (SPADCALL |vvr| |i| (QREFELT $ 22))
                                    (QREFELT $ 24))
                                   #4#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #4#)))))
              (LETT |eq2z| (SPADCALL |pl2| (QREFELT $ 26)))
              (LETT |ff| (SPADCALL |eq2z| (QREFELT $ 29)))
              (LETT |facl| (SPADCALL |ff| (QREFELT $ 34))) (LETT |res| NIL)
              (SEQ (LETT |facr| NIL) (LETT #2# |facl|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |facr| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |fac| (QVELT |facr| 1))
                        (EXIT
                         (COND
                          ((SPADCALL (SPADCALL |fac| (QREFELT $ 35)) 1
                                     (QREFELT $ 37))
                           "iterate")
                          ('T
                           (SEQ
                            (LETT |val1r|
                                  (SPADCALL
                                   (SPADCALL (SPADCALL |fac| 0 (QREFELT $ 40))
                                             (SPADCALL |fac| (QREFELT $ 41))
                                             (QREFELT $ 43))
                                   (QREFELT $ 44)))
                            (EXIT (LETT |res| (CONS |val1r| |res|))))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |PRROOT;integerBound;UPI;2| ((|p| (UP)) ($ (|Integer|)))
        (SPROG
         ((|res| (|Integer|)) (|q| (|Integer|))
          (|qu| (|Union| (|Integer|) "failed")) (#1=#:G736 NIL) (|r| NIL)
          (|lr| (|List| (|Fraction| (|Integer|)))))
         (SEQ (LETT |lr| (SPADCALL |p| (QREFELT $ 46))) (LETT |res| 0)
              (SEQ (LETT |r| NIL) (LETT #1# |lr|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |r| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |qu| (SPADCALL |r| (QREFELT $ 48)))
                        (EXIT
                         (COND ((QEQCAR |qu| 1) "iterate")
                               ('T
                                (SEQ (LETT |q| (QCDR |qu|))
                                     (EXIT
                                      (COND
                                       ((< |q| |res|) (LETT |res| |q|)))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(DECLAIM (NOTINLINE |PolynomialRationalRoots;|)) 

(DEFUN |PolynomialRationalRoots| (&REST #1=#:G737)
  (SPROG NIL
         (PROG (#2=#:G738)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PolynomialRationalRoots|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PolynomialRationalRoots;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PolynomialRationalRoots|)))))))))) 

(DEFUN |PolynomialRationalRoots;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|PolynomialRationalRoots| DV$1 DV$2))
          (LETT $ (GETREFV 50))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PolynomialRationalRoots|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PolynomialRationalRoots| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|NonNegativeInteger|) (0 . |degree|) (|Vector| 6)
              (5 . |vectorise|) (|List| 6) (11 . |parts|) (|List| 12)
              (|Matrix| 6) (16 . |matrix|) (|Matrix| 21) (|Matrix| $)
              (21 . |reducedSystem|) (|Vector| 21) (|Integer|) (26 . |row|)
              (|SparseUnivariatePolynomial| 21) (32 . |unvectorise|) (|List| $)
              (37 . |gcd|) (|Factored| 28) (|SparseUnivariatePolynomial| $)
              (42 . |factorPolynomial|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 30) (|:| |factor| 23) (|:| |exponent| 8))
              (|List| 31) (|Factored| 23) (47 . |factorList|) (52 . |degree|)
              (|Boolean|) (57 . ~=) (63 . |Zero|) (67 . |Zero|)
              (71 . |coefficient|) (77 . |leadingCoefficient|) (|Fraction| 21)
              (82 . /) (88 . -) (|List| 42) |PRROOT;get_rational_roots;UPL;1|
              (|Union| 21 '"failed") (93 . |retractIfCan|)
              |PRROOT;integerBound;UPI;2|)
           '#(|integerBound| 98 |get_rational_roots| 103) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|get_rational_roots|
                                 ((|List| (|Fraction| (|Integer|))) |#2|))
                                T)
                              '((|integerBound| ((|Integer|) |#2|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 49
                                            '(1 7 8 0 9 2 7 10 0 8 11 1 10 12 0
                                              13 1 15 0 14 16 1 6 17 18 19 2 17
                                              20 0 21 22 1 23 0 20 24 1 23 0 25
                                              26 1 21 27 28 29 1 33 32 0 34 1
                                              23 8 0 35 2 8 36 0 0 37 0 6 0 38
                                              0 7 0 39 2 23 21 0 8 40 1 23 21 0
                                              41 2 42 0 21 21 43 1 42 0 0 44 1
                                              42 47 0 48 1 0 21 7 49 1 0 45 7
                                              46)))))
           '|lookupComplete|)) 
