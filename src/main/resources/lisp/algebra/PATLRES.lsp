
(SDEFUN |PATLRES;new;$;1| (($ ($)))
        (CONS (SPADCALL (QREFELT $ 11)) (SPADCALL (QREFELT $ 13)))) 

(PUT '|PATLRES;atoms;$Pmr;2| '|SPADreplace| 'QCAR) 

(SDEFUN |PATLRES;atoms;$Pmr;2| ((|r| ($)) ($ (|PatternMatchResult| R S)))
        (QCAR |r|)) 

(PUT '|PATLRES;lists;$Pmr;3| '|SPADreplace| 'QCDR) 

(SDEFUN |PATLRES;lists;$Pmr;3| ((|r| ($)) ($ (|PatternMatchResult| R L)))
        (QCDR |r|)) 

(SDEFUN |PATLRES;failed;$;4| (($ ($)))
        (CONS (SPADCALL (QREFELT $ 17)) (SPADCALL (QREFELT $ 18)))) 

(SDEFUN |PATLRES;failed?;$B;5| ((|r| ($)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |r| (QREFELT $ 15)) (QREFELT $ 21))) 

(SDEFUN |PATLRES;=;2$B;6| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 15)) (SPADCALL |y| (QREFELT $ 15))
                    (QREFELT $ 23))
          (SPADCALL (SPADCALL |x| (QREFELT $ 16)) (SPADCALL |y| (QREFELT $ 16))
                    (QREFELT $ 24)))
         ('T NIL))) 

(SDEFUN |PATLRES;makeResult;PmrPmr$;7|
        ((|r1| (|PatternMatchResult| R S)) (|r2| (|PatternMatchResult| R L))
         ($ ($)))
        (COND
         ((OR (SPADCALL |r1| (QREFELT $ 21)) (SPADCALL |r2| (QREFELT $ 26)))
          (SPADCALL (QREFELT $ 19)))
         ('T (CONS |r1| |r2|)))) 

(SDEFUN |PATLRES;coerce;$Of;8| ((|r| ($)) ($ (|OutputForm|)))
        (COND
         ((SPADCALL |r| (QREFELT $ 22))
          (SPADCALL (SPADCALL |r| (QREFELT $ 15)) (QREFELT $ 29)))
         ('T (|RecordPrint| |r| (QREFELT $ 9))))) 

(DECLAIM (NOTINLINE |PatternMatchListResult;|)) 

(DEFUN |PatternMatchListResult| (&REST #1=#:G712)
  (SPROG NIL
         (PROG (#2=#:G713)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PatternMatchListResult|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PatternMatchListResult;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PatternMatchListResult|)))))))))) 

(DEFUN |PatternMatchListResult;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|PatternMatchListResult| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 34))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PatternMatchListResult|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9
                    (|Record| (|:| |a| (|PatternMatchResult| |#1| |#2|))
                              (|:| |l| (|PatternMatchResult| |#1| |#3|))))
          $))) 

(MAKEPROP '|PatternMatchListResult| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) '|Rep| (|PatternMatchResult| 6 7) (0 . |new|)
              (|PatternMatchResult| 6 8) (4 . |new|) |PATLRES;new;$;1|
              |PATLRES;atoms;$Pmr;2| |PATLRES;lists;$Pmr;3| (8 . |failed|)
              (12 . |failed|) |PATLRES;failed;$;4| (|Boolean|) (16 . |failed?|)
              |PATLRES;failed?;$B;5| (21 . =) (27 . =) |PATLRES;=;2$B;6|
              (33 . |failed?|) |PATLRES;makeResult;PmrPmr$;7| (|OutputForm|)
              (38 . |coerce|) |PATLRES;coerce;$Of;8| (|String|)
              (|SingleInteger|) (|HashState|))
           '#(~= 43 |new| 49 |makeResult| 53 |lists| 59 |latex| 64
              |hashUpdate!| 69 |hash| 75 |failed?| 80 |failed| 85 |coerce| 89
              |atoms| 94 = 99)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 28))
                        (|makeByteWordVec2| 33
                                            '(0 10 0 11 0 12 0 13 0 10 0 17 0
                                              12 0 18 1 10 20 0 21 2 10 20 0 0
                                              23 2 12 20 0 0 24 1 12 20 0 26 1
                                              10 28 0 29 2 0 20 0 0 1 0 0 0 14
                                              2 0 0 10 12 27 1 0 12 0 16 1 0 31
                                              0 1 2 0 33 33 0 1 1 0 32 0 1 1 0
                                              20 0 22 0 0 0 19 1 0 28 0 30 1 0
                                              10 0 15 2 0 20 0 0 25)))))
           '|lookupComplete|)) 
