
(SDEFUN |COMPLEX2;map;MCC;1|
        ((|fn| (|Mapping| S R)) (|gr| (|Complex| R)) ($ (|Complex| S)))
        (SPADCALL (SPADCALL (SPADCALL |gr| (QREFELT $ 9)) |fn|)
                  (SPADCALL (SPADCALL |gr| (QREFELT $ 10)) |fn|)
                  (QREFELT $ 12))) 

(DECLAIM (NOTINLINE |ComplexFunctions2;|)) 

(DEFUN |ComplexFunctions2| (&REST #1=#:G696)
  (SPROG NIL
         (PROG (#2=#:G697)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ComplexFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ComplexFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|ComplexFunctions2|)))))))))) 

(DEFUN |ComplexFunctions2;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|ComplexFunctions2| DV$1 DV$2))
          (LETT $ (GETREFV 15))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ComplexFunctions2| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ComplexFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Complex| 6) (0 . |real|) (5 . |imag|) (|Complex| 7)
              (10 . |complex|) (|Mapping| 7 6) |COMPLEX2;map;MCC;1|)
           '#(|map| 16) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|Complex| |#2|) (|Mapping| |#2| |#1|)
                                  (|Complex| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 14
                                            '(1 8 6 0 9 1 8 6 0 10 2 11 0 7 7
                                              12 2 0 11 13 8 14)))))
           '|lookupComplete|)) 
