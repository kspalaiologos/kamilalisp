
(SDEFUN |CPMATCH;makeComplex| ((|p| (|Polynomial| S)) ($ (CS)))
        (SPROG
         ((|rcoef| (S)) (|icoef| (S)) (|up| (|SparseUnivariatePolynomial| S)))
         (SEQ (LETT |up| (SPADCALL |p| (QREFELT $ 14)))
              (EXIT
               (COND
                ((> (SPADCALL |up| (QREFELT $ 16)) 1)
                 (|error| "not linear in %i"))
                ('T
                 (SEQ (LETT |icoef| (SPADCALL |up| (QREFELT $ 18)))
                      (LETT |rcoef|
                            (SPADCALL (SPADCALL |p| (QREFELT $ 19))
                                      (QREFELT $ 20)))
                      (EXIT (SPADCALL |rcoef| |icoef| (QREFELT $ 21)))))))))) 

(SDEFUN |CPMATCH;makePoly| ((|cs| (CS)) ($ (|Polynomial| S)))
        (SPADCALL (SPADCALL (SPADCALL |cs| (QREFELT $ 22)) (QREFELT $ 23))
                  (SPADCALL (SPADCALL |cs| (QREFELT $ 24)) (QREFELT $ 12)
                            (QREFELT $ 25))
                  (QREFELT $ 26))) 

(SDEFUN |CPMATCH;patternMatch;CSP2Pmr;3|
        ((|cs| (CS)) (|pat| (|Pattern| R))
         (|result| (|PatternMatchResult| R CS))
         ($ (|PatternMatchResult| R CS)))
        (COND
         ((SPADCALL (SPADCALL |cs| (QREFELT $ 24)) (QREFELT $ 28))
          (SPADCALL (SPADCALL |cs| (QREFELT $ 22)) |pat| |result|
                    (QREFELT $ 32)))
         ('T
          (SPADCALL (CONS (|function| |CPMATCH;makeComplex|) $)
                    (SPADCALL (|CPMATCH;makePoly| |cs| $) |pat|
                              (SPADCALL
                               (CONS (|function| |CPMATCH;makePoly|) $)
                               |result| (QREFELT $ 36))
                              (QREFELT $ 38))
                    (QREFELT $ 41))))) 

(DECLAIM (NOTINLINE |ComplexPatternMatch;|)) 

(DEFUN |ComplexPatternMatch| (&REST #1=#:G712)
  (SPROG NIL
         (PROG (#2=#:G713)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ComplexPatternMatch|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ComplexPatternMatch;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|ComplexPatternMatch|)))))))))) 

(DEFUN |ComplexPatternMatch;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|ComplexPatternMatch| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 43))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory|
                                               (|Polynomial| |#2|)
                                               (LIST '|PatternMatchable|
                                                     (|devaluate| |#1|)))))))
          (|haddProp| |$ConstructorCache| '|ComplexPatternMatch|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 12 (SPADCALL '|%i| (QREFELT $ 11)))
          (COND
           ((|testBitVector| |pv$| 1)
            (QSETREFV $ 42
                      (CONS
                       (|dispatchFunction| |CPMATCH;patternMatch;CSP2Pmr;3|)
                       $))))
          $))) 

(MAKEPROP '|ComplexPatternMatch| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Symbol|) (|Polynomial| 7) (0 . |coerce|) '|ivar|
              (|SparseUnivariatePolynomial| 7) (5 . |univariate|)
              (|NonNegativeInteger|) (10 . |degree|) (15 . |One|)
              (19 . |leadingCoefficient|) (24 . |reductum|)
              (29 . |leadingCoefficient|) (34 . |complex|) (40 . |real|)
              (45 . |coerce|) (50 . |imag|) (55 . *) (61 . +) (|Boolean|)
              (67 . |zero?|) (|PatternMatchResult| 6 8) (|Pattern| 6)
              (|PatternMatchPushDown| 6 7 8) (72 . |patternMatch|)
              (|PatternMatchResult| 6 10) (|Mapping| 10 8)
              (|PatternMatchResultFunctions2| 6 8 10) (79 . |map|)
              (|PatternMatchResult| 6 $) (85 . |patternMatch|) (|Mapping| 8 10)
              (|PatternMatchResultFunctions2| 6 10 8) (92 . |map|)
              (98 . |patternMatch|))
           '#(|patternMatch| 105) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|patternMatch|
                                 ((|PatternMatchResult| |#1| |#3|) |#3|
                                  (|Pattern| |#1|)
                                  (|PatternMatchResult| |#1| |#3|)))
                                (|has| (|Polynomial| 7)
                                       (|PatternMatchable| 6))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 42
                                            '(1 10 0 9 11 1 10 13 0 14 1 13 15
                                              0 16 0 7 0 17 1 13 7 0 18 1 10 0
                                              0 19 1 10 7 0 20 2 8 0 7 7 21 1 8
                                              7 0 22 1 10 0 7 23 1 8 7 0 24 2
                                              10 0 7 0 25 2 10 0 0 0 26 1 7 27
                                              0 28 3 31 29 7 30 29 32 2 35 33
                                              34 29 36 3 10 37 0 30 37 38 2 40
                                              29 39 33 41 3 0 29 8 30 29 42 3 1
                                              29 8 30 29 42)))))
           '|lookupComplete|)) 
