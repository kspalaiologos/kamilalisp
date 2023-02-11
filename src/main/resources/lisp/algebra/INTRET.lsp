
(SDEFUN |INTRET;integer;SI;1| ((|s| (S)) ($ (|Integer|)))
        (SPADCALL |s| (QREFELT $ 8))) 

(SDEFUN |INTRET;integer?;SB;2| ((|s| (S)) ($ (|Boolean|)))
        (QEQCAR (SPADCALL |s| (QREFELT $ 11)) 0)) 

(SDEFUN |INTRET;integerIfCan;SU;3|
        ((|s| (S)) ($ (|Union| (|Integer|) "failed")))
        (SPADCALL |s| (QREFELT $ 11))) 

(DECLAIM (NOTINLINE |IntegerRetractions;|)) 

(DEFUN |IntegerRetractions| (#1=#:G701)
  (SPROG NIL
         (PROG (#2=#:G702)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|IntegerRetractions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|IntegerRetractions;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|IntegerRetractions|)))))))))) 

(DEFUN |IntegerRetractions;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|IntegerRetractions| DV$1))
          (LETT $ (GETREFV 15))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|IntegerRetractions| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|IntegerRetractions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Integer|)
              (0 . |retract|) |INTRET;integer;SI;1| (|Union| 7 '"failed")
              (5 . |retractIfCan|) (|Boolean|) |INTRET;integer?;SB;2|
              |INTRET;integerIfCan;SU;3|)
           '#(|integerIfCan| 10 |integer?| 15 |integer| 20) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|integer| ((|Integer|) |#1|)) T)
                                   '((|integer?| ((|Boolean|) |#1|)) T)
                                   '((|integerIfCan|
                                      ((|Union| (|Integer|) "failed") |#1|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 14
                                            '(1 6 7 0 8 1 6 10 0 11 1 0 10 6 14
                                              1 0 12 6 13 1 0 7 6 9)))))
           '|lookupComplete|)) 
