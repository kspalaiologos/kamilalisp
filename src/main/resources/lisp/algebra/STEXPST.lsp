
(SDEFUN |STEXPST;expre|
        ((|r| (|Coef|)) (|e| (|Stream| |Coef|)) (|dx| (|Stream| |Coef|))
         ($ (|Stream| |Coef|)))
        (SPROG NIL
               (SPADCALL |r| (CONS #'|STEXPST;expre!0| (VECTOR $ |dx| |e|))
                         (QREFELT $ 11)))) 

(SDEFUN |STEXPST;expre!0| (($$ NIL))
        (PROG (|e| |dx| $)
          (LETT |e| (QREFELT $$ 2))
          (LETT |dx| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |e| |dx| (QREFELT $ 9)))))) 

(SDEFUN |STEXPST;exp;2S;2| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|coef| (|Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 13))
                  (SPADCALL (|spadConstant| $ 14) (SPADCALL (QREFELT $ 15))
                            (QREFELT $ 16)))
                 (#1='T
                  (SEQ (LETT |coef| (SPADCALL |z| (QREFELT $ 17)))
                       (EXIT
                        (COND
                         ((SPADCALL |coef| (|spadConstant| $ 18)
                                    (QREFELT $ 19))
                          (SPADCALL
                           (CONS #'|STEXPST;exp;2S;2!0| (VECTOR |z| $))
                           (QREFELT $ 23)))
                         (#1#
                          (SPADCALL
                           (CONS #'|STEXPST;exp;2S;2!1| (VECTOR |z| $ |coef|))
                           (QREFELT $ 23))))))))))) 

(SDEFUN |STEXPST;exp;2S;2!1| ((|y| NIL) ($$ NIL))
        (PROG (|coef| $ |z|)
          (LETT |coef| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |z| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|STEXPST;expre| (SPADCALL |coef| (QREFELT $ 24)) |y|
             (SPADCALL |z| (QREFELT $ 20)) $))))) 

(SDEFUN |STEXPST;exp;2S;2!0| ((|y| NIL) ($$ NIL))
        (PROG ($ |z|)
          (LETT $ (QREFELT $$ 1))
          (LETT |z| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|STEXPST;expre| (|spadConstant| $ 14) |y|
             (SPADCALL |z| (QREFELT $ 20)) $))))) 

(SDEFUN |STEXPST;log;2S;3| ((|z| (|Stream| |Coef|)) ($ (|Stream| |Coef|)))
        (SPROG ((|c| (|Coef|)))
               (SEQ
                (COND
                 ((SPADCALL |z| (QREFELT $ 13))
                  (|error| "log: constant coefficient should not be 0"))
                 (#1='T
                  (SEQ (LETT |c| (SPADCALL |z| (QREFELT $ 17)))
                       (EXIT
                        (COND
                         ((SPADCALL |c| (|spadConstant| $ 18) (QREFELT $ 19))
                          (|error|
                           "log: constant coefficient should not be 0"))
                         (#1#
                          (SPADCALL
                           (CONS #'|STEXPST;log;2S;3!1| (VECTOR |z| $ |c|))
                           (QREFELT $ 23))))))))))) 

(SDEFUN |STEXPST;log;2S;3!1| ((|y| NIL) ($$ NIL))
        (PROG (|c| $ |z|)
          (LETT |c| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |z| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL (SPADCALL |c| (QREFELT $ 26))
                             (CONS #'|STEXPST;log;2S;3!0| (VECTOR |z| $ |y|))
                             (QREFELT $ 11))))))) 

(SDEFUN |STEXPST;log;2S;3!0| (($$ NIL))
        (PROG (|y| $ |z|)
          (LETT |y| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |z| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL (SPADCALL |y| (QREFELT $ 28)) (QREFELT $ 25))
                      (SPADCALL |z| (QREFELT $ 20)) (QREFELT $ 9)))))) 

(DECLAIM (NOTINLINE |StreamExponentialSeriesTranscendentalFunctions;|)) 

(DEFUN |StreamExponentialSeriesTranscendentalFunctions| (#1=#:G712)
  (SPROG NIL
         (PROG (#2=#:G713)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|StreamExponentialSeriesTranscendentalFunctions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (|StreamExponentialSeriesTranscendentalFunctions;| #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|StreamExponentialSeriesTranscendentalFunctions|)))))))))) 

(DEFUN |StreamExponentialSeriesTranscendentalFunctions;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$|
                (LIST '|StreamExponentialSeriesTranscendentalFunctions| DV$1))
          (LETT $ (GETREFV 30))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|StreamExponentialSeriesTranscendentalFunctions|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|StreamExponentialSeriesTranscendentalFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Stream| 6)
              (|StreamExponentialSeriesOperations| 6) (0 . *) (|Mapping| 7)
              (6 . |lazyIntegrate|) (|Boolean|) (12 . |empty?|) (17 . |One|)
              (21 . |empty|) (25 . |cons|) (31 . |frst|) (36 . |Zero|) (40 . =)
              (46 . |deriv|) (|Mapping| 7 7)
              (|ParadoxicalCombinatorsForStreams| 6) (51 . Y) (56 . |exp|)
              |STEXPST;exp;2S;2| (61 . |log|)
              (|StreamTaylorSeriesOperations| 6) (66 . -) |STEXPST;log;2S;3|)
           '#(|log| 71 |exp| 76) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|exp| ((|Stream| |#1|) (|Stream| |#1|))) T)
                              '((|log| ((|Stream| |#1|) (|Stream| |#1|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 29
                                            '(2 8 7 7 7 9 2 8 7 6 10 11 1 7 12
                                              0 13 0 6 0 14 0 7 0 15 2 7 0 6 0
                                              16 1 7 6 0 17 0 6 0 18 2 6 12 0 0
                                              19 1 8 7 7 20 1 22 7 21 23 1 6 0
                                              0 24 1 6 0 0 26 1 27 7 7 28 1 0 7
                                              7 29 1 0 7 7 25)))))
           '|lookupComplete|)) 
