
(SDEFUN |FFFGF;multiplyRows!|
        ((|v| (|Vector| D)) (M (|Matrix| (|SparseUnivariatePolynomial| D)))
         ($ (|Matrix| (|SparseUnivariatePolynomial| D))))
        (SPROG
         ((#1=#:G712 NIL) (|j| NIL) (#2=#:G711 NIL) (|i| NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVSIZE |v|))
              (SEQ (LETT |i| 1) (LETT #2# |n|) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #1# |n|) G190
                          (COND ((|greater_SI| |j| #1#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SPADCALL M |i| |j|
                                      (SPADCALL
                                       (SPADCALL |v| |i| (QREFELT $ 11))
                                       (SPADCALL M |i| |j| (QREFELT $ 14))
                                       (QREFELT $ 15))
                                      (QREFELT $ 16))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT M)))) 

(SDEFUN |FFFGF;generalInterpolation;LMVLM;2|
        ((C (|List| D))
         (|coeffAction|
          (|Mapping| D (|NonNegativeInteger|) (|NonNegativeInteger|) V))
         (|f| (|Vector| VF)) (|eta| (|List| (|NonNegativeInteger|)))
         ($ (|Matrix| (|SparseUnivariatePolynomial| D))))
        (SPROG
         ((M (|Matrix| (|SparseUnivariatePolynomial| D)))
          (|c| (|List| (|Fraction| D))) (#1=#:G723 NIL) (|i| NIL)
          (|den| (|Vector| D)) (|g| (|Vector| V)) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVSIZE |f|))
              (LETT |g| (MAKEARR1 |n| (|spadConstant| $ 18)))
              (LETT |den| (MAKEARR1 |n| (|spadConstant| $ 17)))
              (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (LETT |c|
                          (SPADCALL (SPADCALL |f| |i| (QREFELT $ 20))
                                    (QREFELT $ 22)))
                    (SPADCALL |den| |i| (SPADCALL |c| (QREFELT $ 24))
                              (QREFELT $ 25))
                    (EXIT
                     (SPADCALL |g| |i|
                               (SPADCALL
                                (CONS #'|FFFGF;generalInterpolation;LMVLM;2!0|
                                      (VECTOR $ |i| |den|))
                                (SPADCALL |f| |i| (QREFELT $ 20))
                                (QREFELT $ 31))
                               (QREFELT $ 33))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT M (SPADCALL C |coeffAction| |g| |eta| (QREFELT $ 38)))
              (EXIT (|FFFGF;multiplyRows!| |den| M $))))) 

(SDEFUN |FFFGF;generalInterpolation;LMVLM;2!0| ((|x| NIL) ($$ NIL))
        (PROG (|den| |i| $)
          (LETT |den| (QREFELT $$ 2))
          (LETT |i| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL |x| (SPADCALL |den| |i| (QREFELT $ 11)) (QREFELT $ 27))
             (QREFELT $ 28)))))) 

(DECLAIM (NOTINLINE |FractionFreeFastGaussianFractions;|)) 

(DEFUN |FractionFreeFastGaussianFractions| (&REST #1=#:G724)
  (SPROG NIL
         (PROG (#2=#:G725)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FractionFreeFastGaussianFractions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |FractionFreeFastGaussianFractions;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|FractionFreeFastGaussianFractions|)))))))))) 

(DEFUN |FractionFreeFastGaussianFractions;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$|
                (LIST '|FractionFreeFastGaussianFractions| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 40))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FractionFreeFastGaussianFractions|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FractionFreeFastGaussianFractions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Integer|) (|Vector| 6) (0 . |elt|)
              (|SparseUnivariatePolynomial| 6) (|Matrix| 12) (6 . |elt|)
              (13 . *) (19 . |setelt!|) (27 . |Zero|) (31 . |Zero|)
              (|Vector| 8) (35 . |elt|) (|List| 26) (41 . |coefficients|)
              (|CommonDenominator| 6 26 21) (46 . |commonDenominator|)
              (51 . |setelt!|) (|Fraction| 6) (58 . *) (64 . |retract|)
              (|Mapping| 6 26)
              (|FiniteAbelianMonoidRingFunctions2| (|NonNegativeInteger|) 26 8
                                                   6 7)
              (69 . |map|) (|Vector| 7) (75 . |setelt!|) (|List| 6)
              (|Mapping| 6 (|NonNegativeInteger|) (|NonNegativeInteger|) 7)
              (|List| (|NonNegativeInteger|)) (|FractionFreeFastGaussian| 6 7)
              (82 . |generalInterpolation|)
              |FFFGF;generalInterpolation;LMVLM;2|)
           '#(|generalInterpolation| 90) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|generalInterpolation|
                                 ((|Matrix|
                                   (|SparseUnivariatePolynomial| |#1|))
                                  (|List| |#1|)
                                  (|Mapping| |#1| (|NonNegativeInteger|)
                                             (|NonNegativeInteger|) |#2|)
                                  (|Vector| |#3|)
                                  (|List| (|NonNegativeInteger|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 39
                                            '(2 10 6 0 9 11 3 13 12 0 9 9 14 2
                                              12 0 6 0 15 4 13 12 0 9 9 12 16 0
                                              6 0 17 0 7 0 18 2 19 8 0 9 20 1 8
                                              21 0 22 1 23 6 21 24 3 10 6 0 9 6
                                              25 2 26 0 0 6 27 1 26 6 0 28 2 30
                                              7 29 8 31 3 32 7 0 9 7 33 4 37 13
                                              34 35 32 36 38 4 0 13 34 35 19 36
                                              39)))))
           '|lookupComplete|)) 
