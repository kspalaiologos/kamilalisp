
(SDEFUN |RATRET;rational;SF;1| ((|s| (S)) ($ (|Fraction| (|Integer|))))
        (SPADCALL |s| (QREFELT $ 8))) 

(SDEFUN |RATRET;rational?;SB;2| ((|s| (S)) ($ (|Boolean|)))
        (QEQCAR (SPADCALL |s| (QREFELT $ 11)) 0)) 

(SDEFUN |RATRET;rationalIfCan;SU;3|
        ((|s| (S)) ($ (|Union| (|Fraction| (|Integer|)) "failed")))
        (SPADCALL |s| (QREFELT $ 11))) 

(DECLAIM (NOTINLINE |RationalRetractions;|)) 

(DEFUN |RationalRetractions| (#1=#:G702)
  (SPROG NIL
         (PROG (#2=#:G703)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|RationalRetractions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|RationalRetractions;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|RationalRetractions|)))))))))) 

(DEFUN |RationalRetractions;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|RationalRetractions| DV$1))
          (LETT $ (GETREFV 15))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RationalRetractions| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RationalRetractions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Fraction| (|Integer|))
              (0 . |retract|) |RATRET;rational;SF;1| (|Union| 7 '"failed")
              (5 . |retractIfCan|) (|Boolean|) |RATRET;rational?;SB;2|
              |RATRET;rationalIfCan;SU;3|)
           '#(|rationalIfCan| 10 |rational?| 15 |rational| 20) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|rational| ((|Fraction| (|Integer|)) |#1|)) T)
                              '((|rational?| ((|Boolean|) |#1|)) T)
                              '((|rationalIfCan|
                                 ((|Union| (|Fraction| (|Integer|)) "failed")
                                  |#1|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 14
                                            '(1 6 7 0 8 1 6 10 0 11 1 0 10 6 14
                                              1 0 12 6 13 1 0 7 6 9)))))
           '|lookupComplete|)) 
