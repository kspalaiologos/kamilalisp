
(SDEFUN |EXPR2;map;MEE;1|
        ((|f| (|Mapping| S R)) (|r| (|Expression| R)) ($ (|Expression| S)))
        (SPADCALL |f| |r| (QREFELT $ 12))) 

(DECLAIM (NOTINLINE |ExpressionFunctions2;|)) 

(DEFUN |ExpressionFunctions2| (&REST #1=#:G692)
  (SPROG NIL
         (PROG (#2=#:G693)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ExpressionFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ExpressionFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|ExpressionFunctions2|)))))))))) 

(DEFUN |ExpressionFunctions2;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|ExpressionFunctions2| DV$1 DV$2))
          (LETT $ (GETREFV 14))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ExpressionFunctions2|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ExpressionFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Expression| 7) (|Mapping| 7 6) (|Expression| 6)
              (|FunctionSpaceFunctions2| 6 10 7 8) (0 . |map|)
              |EXPR2;map;MEE;1|)
           '#(|map| 6) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|Expression| |#2|) (|Mapping| |#2| |#1|)
                                  (|Expression| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 13
                                            '(2 11 8 9 10 12 2 0 8 9 10 13)))))
           '|lookupComplete|)) 
