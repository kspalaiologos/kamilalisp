
(SDEFUN |GENUPS2;taylor;MEA;1|
        ((|f| (|Mapping| FE (|Integer|))) (|eq| (|Equation| FE)) ($ (|Any|)))
        (SPROG
         ((|a| (FE)) (|x| (|Symbol|)) (|xx| (|Union| (|Symbol|) "failed")))
         (SEQ
          (LETT |xx| (SPADCALL (SPADCALL |eq| (QREFELT $ 8)) (QREFELT $ 10)))
          (EXIT
           (COND
            ((QEQCAR |xx| 1)
             (|error| "taylor: left hand side must be a variable"))
            ('T
             (SEQ (LETT |x| (QCDR |xx|))
                  (LETT |a| (SPADCALL |eq| (QREFELT $ 11)))
                  (EXIT (SPADCALL |f| |x| |a| (QREFELT $ 16)))))))))) 

(SDEFUN |GENUPS2;taylor;MEUsA;2|
        ((|f| (|Mapping| FE (|Integer|))) (|eq| (|Equation| FE))
         (|seg| (|UniversalSegment| (|NonNegativeInteger|))) ($ (|Any|)))
        (SPROG
         ((|a| (FE)) (|x| (|Symbol|)) (|xx| (|Union| (|Symbol|) "failed")))
         (SEQ
          (LETT |xx| (SPADCALL (SPADCALL |eq| (QREFELT $ 8)) (QREFELT $ 10)))
          (EXIT
           (COND
            ((QEQCAR |xx| 1)
             (|error| "taylor: left hand side must be a variable"))
            ('T
             (SEQ (LETT |x| (QCDR |xx|))
                  (LETT |a| (SPADCALL |eq| (QREFELT $ 11)))
                  (EXIT (SPADCALL |f| |x| |a| |seg| (QREFELT $ 19)))))))))) 

(SDEFUN |GENUPS2;laurent;MEUsA;3|
        ((|f| (|Mapping| FE (|Integer|))) (|eq| (|Equation| FE))
         (|seg| (|UniversalSegment| (|Integer|))) ($ (|Any|)))
        (SPROG
         ((|a| (FE)) (|x| (|Symbol|)) (|xx| (|Union| (|Symbol|) "failed")))
         (SEQ
          (LETT |xx| (SPADCALL (SPADCALL |eq| (QREFELT $ 8)) (QREFELT $ 10)))
          (EXIT
           (COND
            ((QEQCAR |xx| 1)
             (|error| "taylor: left hand side must be a variable"))
            ('T
             (SEQ (LETT |x| (QCDR |xx|))
                  (LETT |a| (SPADCALL |eq| (QREFELT $ 11)))
                  (EXIT (SPADCALL |f| |x| |a| |seg| (QREFELT $ 22)))))))))) 

(SDEFUN |GENUPS2;puiseux;MEUsFA;4|
        ((|f| (|Mapping| FE (|Fraction| (|Integer|)))) (|eq| (|Equation| FE))
         (|seg| (|UniversalSegment| (|Fraction| (|Integer|))))
         (|r| (|Fraction| (|Integer|))) ($ (|Any|)))
        (SPROG
         ((|a| (FE)) (|x| (|Symbol|)) (|xx| (|Union| (|Symbol|) "failed")))
         (SEQ
          (LETT |xx| (SPADCALL (SPADCALL |eq| (QREFELT $ 8)) (QREFELT $ 10)))
          (EXIT
           (COND
            ((QEQCAR |xx| 1)
             (|error| "puiseux: left hand side must be a variable"))
            ('T
             (SEQ (LETT |x| (QCDR |xx|))
                  (LETT |a| (SPADCALL |eq| (QREFELT $ 11)))
                  (EXIT (SPADCALL |f| |x| |a| |seg| |r| (QREFELT $ 27)))))))))) 

(SDEFUN |GENUPS2;series;MEA;5|
        ((|f| (|Mapping| FE (|Integer|))) (|eq| (|Equation| FE)) ($ (|Any|)))
        (SPROG NIL
               (SPADCALL (CONS #'|GENUPS2;series;MEA;5!0| (VECTOR |f| $)) |eq|
                         (SPADCALL (|spadConstant| $ 33) (QREFELT $ 34))
                         (|spadConstant| $ 35) (QREFELT $ 28)))) 

(SDEFUN |GENUPS2;series;MEA;5!0| ((|r| NIL) ($$ NIL))
        (PROG ($ |f|)
          (LETT $ (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL (SPADCALL |r| (QREFELT $ 30)) |f|))))) 

(SDEFUN |GENUPS2;series;MEUsA;6|
        ((|f| (|Mapping| FE (|Integer|))) (|eq| (|Equation| FE))
         (|seg| (|UniversalSegment| (|Integer|))) ($ (|Any|)))
        (SPROG ((|ratSeg| (|UniversalSegment| (|Fraction| (|Integer|)))))
               (SEQ (LETT |ratSeg| (SPADCALL (ELT $ 37) |seg| (QREFELT $ 40)))
                    (EXIT
                     (SPADCALL
                      (CONS #'|GENUPS2;series;MEUsA;6!0| (VECTOR |f| $)) |eq|
                      |ratSeg| (|spadConstant| $ 35) (QREFELT $ 28)))))) 

(SDEFUN |GENUPS2;series;MEUsA;6!0| ((|r| NIL) ($$ NIL))
        (PROG ($ |f|)
          (LETT $ (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL (SPADCALL |r| (QREFELT $ 30)) |f|))))) 

(SDEFUN |GENUPS2;series;MEUsFA;7|
        ((|f| (|Mapping| FE (|Fraction| (|Integer|)))) (|eq| (|Equation| FE))
         (|seg| (|UniversalSegment| (|Fraction| (|Integer|))))
         (|r| (|Fraction| (|Integer|))) ($ (|Any|)))
        (SPADCALL |f| |eq| |seg| |r| (QREFELT $ 28))) 

(SDEFUN |GENUPS2;taylor;FESEA;8|
        ((|an| (FE)) (|n| (|Symbol|)) (|eq| (|Equation| FE)) ($ (|Any|)))
        (SPROG NIL
               (SPADCALL
                (CONS #'|GENUPS2;taylor;FESEA;8!0| (VECTOR $ |n| |an|)) |eq|
                (QREFELT $ 17)))) 

(SDEFUN |GENUPS2;taylor;FESEA;8!0| ((|i| NIL) ($$ NIL))
        (PROG (|an| |n| $)
          (LETT |an| (QREFELT $$ 2))
          (LETT |n| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |an|
                      (SPADCALL (SPADCALL |n| (QREFELT $ 43))
                                (SPADCALL |i| (QREFELT $ 44)) (QREFELT $ 47))
                      (QREFELT $ 48)))))) 

(SDEFUN |GENUPS2;taylor;FESEUsA;9|
        ((|an| (FE)) (|n| (|Symbol|)) (|eq| (|Equation| FE))
         (|seg| (|UniversalSegment| (|NonNegativeInteger|))) ($ (|Any|)))
        (SPROG NIL
               (SPADCALL
                (CONS #'|GENUPS2;taylor;FESEUsA;9!0| (VECTOR $ |n| |an|)) |eq|
                |seg| (QREFELT $ 20)))) 

(SDEFUN |GENUPS2;taylor;FESEUsA;9!0| ((|i| NIL) ($$ NIL))
        (PROG (|an| |n| $)
          (LETT |an| (QREFELT $$ 2))
          (LETT |n| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |an|
                      (SPADCALL (SPADCALL |n| (QREFELT $ 43))
                                (SPADCALL |i| (QREFELT $ 44)) (QREFELT $ 47))
                      (QREFELT $ 48)))))) 

(SDEFUN |GENUPS2;laurent;FESEUsA;10|
        ((|an| (FE)) (|n| (|Symbol|)) (|eq| (|Equation| FE))
         (|seg| (|UniversalSegment| (|Integer|))) ($ (|Any|)))
        (SPROG NIL
               (SPADCALL
                (CONS #'|GENUPS2;laurent;FESEUsA;10!0| (VECTOR $ |n| |an|))
                |eq| |seg| (QREFELT $ 23)))) 

(SDEFUN |GENUPS2;laurent;FESEUsA;10!0| ((|i| NIL) ($$ NIL))
        (PROG (|an| |n| $)
          (LETT |an| (QREFELT $$ 2))
          (LETT |n| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |an|
                      (SPADCALL (SPADCALL |n| (QREFELT $ 43))
                                (SPADCALL |i| (QREFELT $ 44)) (QREFELT $ 47))
                      (QREFELT $ 48)))))) 

(SDEFUN |GENUPS2;puiseux;FESEUsFA;11|
        ((|an| (FE)) (|n| (|Symbol|)) (|eq| (|Equation| FE))
         (|r0| (|UniversalSegment| (|Fraction| (|Integer|))))
         (|m| (|Fraction| (|Integer|))) ($ (|Any|)))
        (SPROG NIL
               (SPADCALL
                (CONS #'|GENUPS2;puiseux;FESEUsFA;11!0| (VECTOR $ |n| |an|))
                |eq| |r0| |m| (QREFELT $ 28)))) 

(SDEFUN |GENUPS2;puiseux;FESEUsFA;11!0| ((|r| NIL) ($$ NIL))
        (PROG (|an| |n| $)
          (LETT |an| (QREFELT $$ 2))
          (LETT |n| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |an|
                      (SPADCALL (SPADCALL |n| (QREFELT $ 43))
                                (SPADCALL |r| (QREFELT $ 52)) (QREFELT $ 47))
                      (QREFELT $ 48)))))) 

(SDEFUN |GENUPS2;series;FESEA;12|
        ((|an| (FE)) (|n| (|Symbol|)) (|eq| (|Equation| FE)) ($ (|Any|)))
        (SPADCALL |an| |n| |eq| (SPADCALL (|spadConstant| $ 33) (QREFELT $ 34))
                  (|spadConstant| $ 35) (QREFELT $ 53))) 

(SDEFUN |GENUPS2;series;FESEUsA;13|
        ((|an| (FE)) (|n| (|Symbol|)) (|eq| (|Equation| FE))
         (|seg| (|UniversalSegment| (|Integer|))) ($ (|Any|)))
        (SPROG ((|ratSeg| (|UniversalSegment| (|Fraction| (|Integer|)))))
               (SEQ (LETT |ratSeg| (SPADCALL (ELT $ 37) |seg| (QREFELT $ 40)))
                    (EXIT
                     (SPADCALL |an| |n| |eq| |ratSeg| (|spadConstant| $ 35)
                               (QREFELT $ 53)))))) 

(SDEFUN |GENUPS2;series;FESEUsFA;14|
        ((|an| (FE)) (|n| (|Symbol|)) (|eq| (|Equation| FE))
         (|seg| (|UniversalSegment| (|Fraction| (|Integer|))))
         (|r| (|Fraction| (|Integer|))) ($ (|Any|)))
        (SPADCALL |an| |n| |eq| |seg| |r| (QREFELT $ 53))) 

(DECLAIM (NOTINLINE |GenerateUnivariatePowerSeries2;|)) 

(DEFUN |GenerateUnivariatePowerSeries2| (#1=#:G745)
  (SPROG NIL
         (PROG (#2=#:G746)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|GenerateUnivariatePowerSeries2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|GenerateUnivariatePowerSeries2;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|GenerateUnivariatePowerSeries2|)))))))))) 

(DEFUN |GenerateUnivariatePowerSeries2;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|GenerateUnivariatePowerSeries2| DV$1))
          (LETT $ (GETREFV 59))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (AND
                                               (|HasCategory| |#1|
                                                              (LIST '|Evalable|
                                                                    (|devaluate|
                                                                     |#1|)))
                                               (|HasCategory| |#1|
                                                              '(|RetractableTo|
                                                                (|Fraction|
                                                                 (|Integer|)))))
                                              (AND
                                               (|HasCategory| |#1|
                                                              (LIST '|Evalable|
                                                                    (|devaluate|
                                                                     |#1|)))
                                               (|HasCategory| |#1|
                                                              '(|RetractableTo|
                                                                (|Integer|))))))))
          (|haddProp| |$ConstructorCache| '|GenerateUnivariatePowerSeries2|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#1| '(|RetractableTo| (|Integer|)))
            (COND
             ((|HasCategory| |#1| (LIST '|Evalable| (|devaluate| |#1|)))
              (PROGN
               (QSETREFV $ 49
                         (CONS (|dispatchFunction| |GENUPS2;taylor;FESEA;8|)
                               $))
               (QSETREFV $ 50
                         (CONS (|dispatchFunction| |GENUPS2;taylor;FESEUsA;9|)
                               $))
               (QSETREFV $ 51
                         (CONS
                          (|dispatchFunction| |GENUPS2;laurent;FESEUsA;10|)
                          $)))))))
          (COND
           ((|HasCategory| |#1| '(|RetractableTo| (|Fraction| (|Integer|))))
            (COND
             ((|HasCategory| |#1| (LIST '|Evalable| (|devaluate| |#1|)))
              (PROGN
               (QSETREFV $ 53
                         (CONS
                          (|dispatchFunction| |GENUPS2;puiseux;FESEUsFA;11|)
                          $))
               (QSETREFV $ 54
                         (CONS (|dispatchFunction| |GENUPS2;series;FESEA;12|)
                               $))
               (QSETREFV $ 57
                         (CONS (|dispatchFunction| |GENUPS2;series;FESEUsA;13|)
                               $))
               (QSETREFV $ 58
                         (CONS
                          (|dispatchFunction| |GENUPS2;series;FESEUsFA;14|)
                          $)))))))
          $))) 

(MAKEPROP '|GenerateUnivariatePowerSeries2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Equation| 6) (0 . |lhs|)
              (|Union| 14 '"failed") (5 . |retractIfCan|) (10 . |rhs|) (|Any|)
              (|Mapping| 6 29) (|Symbol|) (|GenerateUnivariatePowerSeries1| 6)
              (15 . |taylor|) |GENUPS2;taylor;MEA;1|
              (|UniversalSegment| (|NonNegativeInteger|)) (22 . |taylor|)
              |GENUPS2;taylor;MEUsA;2| (|UniversalSegment| 29) (30 . |laurent|)
              |GENUPS2;laurent;MEUsA;3| (|Mapping| 6 26)
              (|UniversalSegment| 26) (|Fraction| 29) (38 . |puiseux|)
              |GENUPS2;puiseux;MEUsFA;4| (|Integer|) (47 . |numer|)
              (52 . |Zero|) (56 . |Zero|) (60 . |Zero|) (64 . |segment|)
              (69 . |One|) |GENUPS2;series;MEA;5| (73 . |coerce|)
              (|Mapping| 26 29) (|UniversalSegmentFunctions2| 29 26)
              (78 . |map|) |GENUPS2;series;MEUsA;6| |GENUPS2;series;MEUsFA;7|
              (84 . |coerce|) (89 . |coerce|) (|Boolean|) (94 . =) (100 . =)
              (106 . |eval|) (112 . |taylor|) (119 . |taylor|)
              (127 . |laurent|) (135 . |coerce|) (140 . |puiseux|)
              (149 . |series|) (156 . |One|) (160 . |One|) (164 . |series|)
              (172 . |series|))
           '#(|taylor| 181 |series| 209 |puiseux| 254 |laurent| 271) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|taylor|
                                 ((|Any|) (|Mapping| |#1| (|Integer|))
                                  (|Equation| |#1|)))
                                T)
                              '((|taylor|
                                 ((|Any|) (|Mapping| |#1| (|Integer|))
                                  (|Equation| |#1|)
                                  (|UniversalSegment| (|NonNegativeInteger|))))
                                T)
                              '((|laurent|
                                 ((|Any|) (|Mapping| |#1| (|Integer|))
                                  (|Equation| |#1|)
                                  (|UniversalSegment| (|Integer|))))
                                T)
                              '((|puiseux|
                                 ((|Any|)
                                  (|Mapping| |#1| (|Fraction| (|Integer|)))
                                  (|Equation| |#1|)
                                  (|UniversalSegment| (|Fraction| (|Integer|)))
                                  (|Fraction| (|Integer|))))
                                T)
                              '((|series|
                                 ((|Any|) (|Mapping| |#1| (|Integer|))
                                  (|Equation| |#1|)))
                                T)
                              '((|series|
                                 ((|Any|) (|Mapping| |#1| (|Integer|))
                                  (|Equation| |#1|)
                                  (|UniversalSegment| (|Integer|))))
                                T)
                              '((|series|
                                 ((|Any|)
                                  (|Mapping| |#1| (|Fraction| (|Integer|)))
                                  (|Equation| |#1|)
                                  (|UniversalSegment| (|Fraction| (|Integer|)))
                                  (|Fraction| (|Integer|))))
                                T)
                              '((|taylor|
                                 ((|Any|) |#1| (|Symbol|) (|Equation| |#1|)))
                                (AND (|has| 6 (|Evalable| 6))
                                     (|has| 6 (|RetractableTo| 29))))
                              '((|taylor|
                                 ((|Any|) |#1| (|Symbol|) (|Equation| |#1|)
                                  (|UniversalSegment| (|NonNegativeInteger|))))
                                (AND (|has| 6 (|Evalable| 6))
                                     (|has| 6 (|RetractableTo| 29))))
                              '((|laurent|
                                 ((|Any|) |#1| (|Symbol|) (|Equation| |#1|)
                                  (|UniversalSegment| (|Integer|))))
                                (AND (|has| 6 (|Evalable| 6))
                                     (|has| 6 (|RetractableTo| 29))))
                              '((|puiseux|
                                 ((|Any|) |#1| (|Symbol|) (|Equation| |#1|)
                                  (|UniversalSegment| (|Fraction| (|Integer|)))
                                  (|Fraction| (|Integer|))))
                                (AND (|has| 6 (|Evalable| 6))
                                     (|has| 6 (|RetractableTo| 26))))
                              '((|series|
                                 ((|Any|) |#1| (|Symbol|) (|Equation| |#1|)))
                                (AND (|has| 6 (|Evalable| 6))
                                     (|has| 6 (|RetractableTo| 26))))
                              '((|series|
                                 ((|Any|) |#1| (|Symbol|) (|Equation| |#1|)
                                  (|UniversalSegment| (|Integer|))))
                                (AND (|has| 6 (|Evalable| 6))
                                     (|has| 6 (|RetractableTo| 26))))
                              '((|series|
                                 ((|Any|) |#1| (|Symbol|) (|Equation| |#1|)
                                  (|UniversalSegment| (|Fraction| (|Integer|)))
                                  (|Fraction| (|Integer|))))
                                (AND (|has| 6 (|Evalable| 6))
                                     (|has| 6 (|RetractableTo| 26)))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 58
                                            '(1 7 6 0 8 1 6 9 0 10 1 7 6 0 11 3
                                              15 12 13 14 6 16 4 15 12 13 14 6
                                              18 19 4 15 12 13 14 6 21 22 5 15
                                              12 24 14 6 25 26 27 1 26 29 0 30
                                              0 6 0 31 0 7 0 32 0 26 0 33 1 25
                                              0 26 34 0 26 0 35 1 26 0 29 37 2
                                              39 25 38 21 40 1 6 0 14 43 1 6 0
                                              29 44 2 6 45 0 0 46 2 7 0 6 6 47
                                              2 6 0 0 7 48 3 0 12 6 14 7 49 4 0
                                              12 6 14 7 18 50 4 0 12 6 14 7 21
                                              51 1 6 0 26 52 5 0 12 6 14 7 25
                                              26 53 3 0 12 6 14 7 54 0 6 0 55 0
                                              7 0 56 4 0 12 6 14 7 21 57 5 0 12
                                              6 14 7 25 26 58 3 2 12 6 14 7 49
                                              4 2 12 6 14 7 18 50 2 0 12 13 7
                                              17 3 0 12 13 7 18 20 3 1 12 6 14
                                              7 54 5 1 12 6 14 7 25 26 58 4 1
                                              12 6 14 7 21 57 2 0 12 13 7 36 4
                                              0 12 24 7 25 26 42 3 0 12 13 7 21
                                              41 5 1 12 6 14 7 25 26 53 4 0 12
                                              24 7 25 26 28 4 2 12 6 14 7 21 51
                                              3 0 12 13 7 21 23)))))
           '|lookupComplete|)) 
