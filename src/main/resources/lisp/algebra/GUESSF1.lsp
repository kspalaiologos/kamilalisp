
(SDEFUN |GUESSF1;F2EXPRR;FE;1| ((|p| (F)) ($ (|Expression| (|Integer|))))
        (SPADCALL (SPADCALL |p| (QREFELT $ 8)) (QREFELT $ 10))) 

(SDEFUN |GUESSF1;EXPRR2F;EF;2| ((|p| (|Expression| (|Integer|))) ($ (F)))
        (SPADCALL (SPADCALL |p| (QREFELT $ 13)) (QREFELT $ 14))) 

(DECLAIM (NOTINLINE |GuessFiniteFunctions;|)) 

(DEFUN |GuessFiniteFunctions| (#1=#:G699)
  (SPROG NIL
         (PROG (#2=#:G700)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|GuessFiniteFunctions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|GuessFiniteFunctions;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|GuessFiniteFunctions|)))))))))) 

(DEFUN |GuessFiniteFunctions;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|GuessFiniteFunctions| DV$1))
          (LETT $ (GETREFV 16))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|GuessFiniteFunctions| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|GuessFiniteFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Integer|)
              (0 . |convert|) (|Expression| 7) (5 . |coerce|)
              |GUESSF1;F2EXPRR;FE;1| (|Fraction| 7) (10 . |retract|)
              (15 . |coerce|) |GUESSF1;EXPRR2F;EF;2|)
           '#(F2EXPRR 20 EXPRR2F 25) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((F2EXPRR ((|Expression| (|Integer|)) |#1|)) T)
                              '((EXPRR2F (|#1| (|Expression| (|Integer|)))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 15
                                            '(1 6 7 0 8 1 9 0 7 10 1 9 12 0 13
                                              1 6 0 12 14 1 0 9 6 11 1 0 6 9
                                              15)))))
           '|lookupComplete|)) 
