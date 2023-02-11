
(SDEFUN |ANY1;retractable?;AB;1| ((|a| (|Any|)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |a| (QREFELT $ 10)) (QREFELT $ 7) (QREFELT $ 12))) 

(SDEFUN |ANY1;coerce;SA;2| ((|s| (S)) ($ (|Any|)))
        (SPADCALL (QREFELT $ 7) (SPADCALL |s| (QREFELT $ 16)) (QREFELT $ 17))) 

(SDEFUN |ANY1;retractIfCan;AU;3| ((|a| (|Any|)) ($ (|Union| S "failed")))
        (COND
         ((SPADCALL |a| (QREFELT $ 13)) (CONS 0 (SPADCALL |a| (QREFELT $ 19))))
         ('T (CONS 1 "failed")))) 

(SDEFUN |ANY1;retract;AS;4| ((|a| (|Any|)) ($ (S)))
        (COND ((SPADCALL |a| (QREFELT $ 13)) (SPADCALL |a| (QREFELT $ 19)))
              ('T (|error| "Cannot retract value.")))) 

(DECLAIM (NOTINLINE |AnyFunctions1;|)) 

(DEFUN |AnyFunctions1| (#1=#:G703)
  (SPROG NIL
         (PROG (#2=#:G704)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|AnyFunctions1|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|AnyFunctions1;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|AnyFunctions1|)))))))))) 

(DEFUN |AnyFunctions1;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|AnyFunctions1| DV$1))
          (LETT $ (GETREFV 23))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|AnyFunctions1| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 (|devaluate| |#1|))
          $))) 

(MAKEPROP '|AnyFunctions1| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Sexpr| (|SExpression|)
              (|Any|) (0 . |dom|) (|Boolean|) (5 . =) |ANY1;retractable?;AB;1|
              (|None|) (|NoneFunctions1| 6) (11 . |coerce|) (16 . |any|)
              |ANY1;coerce;SA;2| (22 . |obj|) (|Union| 6 '#1="failed")
              |ANY1;retractIfCan;AU;3| |ANY1;retract;AS;4|)
           '#(|retractable?| 27 |retractIfCan| 32 |retract| 37 |coerce| 42)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|coerce| ((|Any|) |#1|)) T)
                                   '((|retractIfCan|
                                      ((|Union| |#1| #1#) (|Any|)))
                                     T)
                                   '((|retractable?| ((|Boolean|) (|Any|))) T)
                                   '((|retract| (|#1| (|Any|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 22
                                            '(1 9 8 0 10 2 8 11 0 0 12 1 15 14
                                              6 16 2 9 0 8 14 17 1 9 14 0 19 1
                                              0 11 9 13 1 0 20 9 21 1 0 6 9 22
                                              1 0 9 6 18)))))
           '|lookupComplete|)) 
