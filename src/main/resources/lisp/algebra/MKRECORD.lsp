
(PUT '|MKRECORD;makeRecord;ST$R;1| '|SPADreplace| 'CONS) 

(SDEFUN |MKRECORD;makeRecord;ST$R;1|
        ((|s| (S)) (|t| (T$)) ($ (|Record| (|:| |part1| S) (|:| |part2| T$))))
        (CONS |s| |t|)) 

(DECLAIM (NOTINLINE |MakeRecord;|)) 

(DEFUN |MakeRecord| (&REST #1=#:G692)
  (SPROG NIL
         (PROG (#2=#:G693)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|MakeRecord|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |MakeRecord;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|MakeRecord|)))))))))) 

(DEFUN |MakeRecord;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|MakeRecord| DV$1 DV$2))
          (LETT $ (GETREFV 10))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|MakeRecord| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|MakeRecord| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Record| (|:| |part1| 6) (|:| |part2| 7))
              |MKRECORD;makeRecord;ST$R;1|)
           '#(|makeRecord| 0) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|makeRecord|
                                 ((|Record| (|:| |part1| |#1|)
                                            (|:| |part2| |#2|))
                                  |#1| |#2|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 9 '(2 0 8 6 7 9)))))
           '|lookupComplete|)) 
