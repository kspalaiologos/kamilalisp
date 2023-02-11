
(SDEFUN |LIST3;map;MLLL;1|
        ((|fn| (|Mapping| C A B)) (|la| (|List| A)) (|lb| (|List| B))
         ($ (|List| C)))
        (SPROG
         ((#1=#:G698 NIL) (|a| NIL) (#2=#:G699 NIL) (|b| NIL) (#3=#:G697 NIL))
         (SEQ
          (PROGN
           (LETT #3# NIL)
           (SEQ (LETT |b| NIL) (LETT #2# |lb|) (LETT |a| NIL) (LETT #1# |la|)
                G190
                (COND
                 ((OR (ATOM #1#) (PROGN (LETT |a| (CAR #1#)) NIL) (ATOM #2#)
                      (PROGN (LETT |b| (CAR #2#)) NIL))
                  (GO G191)))
                (SEQ (EXIT (LETT #3# (CONS (SPADCALL |a| |b| |fn|) #3#))))
                (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#)))) (GO G190)
                G191 (EXIT (NREVERSE #3#))))))) 

(DECLAIM (NOTINLINE |ListFunctions3;|)) 

(DEFUN |ListFunctions3| (&REST #1=#:G700)
  (SPROG NIL
         (PROG (#2=#:G701)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ListFunctions3|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ListFunctions3;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|ListFunctions3|)))))))))) 

(DEFUN |ListFunctions3;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|ListFunctions3| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 14))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ListFunctions3|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ListFunctions3| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|List| 8) (|Mapping| 8 6 7) (|List| 6) (|List| 7)
              |LIST3;map;MLLL;1|)
           '#(|map| 0) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|List| |#3|) (|Mapping| |#3| |#1| |#2|)
                                  (|List| |#1|) (|List| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 13 '(3 0 9 10 11 12 13)))))
           '|lookupComplete|)) 
