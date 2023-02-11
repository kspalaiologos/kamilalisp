
(SDEFUN |ITFUN3;map;MItItIt;1|
        ((|f| (|Mapping| C A B)) (|s1| (|InfiniteTuple| A))
         (|s2| (|InfiniteTuple| B)) ($ (|InfiniteTuple| C)))
        (SPADCALL |f| |s1| |s2| (QREFELT $ 14))) 

(SDEFUN |ITFUN3;map;MSItS;2|
        ((|f| (|Mapping| C A B)) (|s1| (|Stream| A)) (|s2| (|InfiniteTuple| B))
         ($ (|Stream| C)))
        (SPADCALL |f| |s1| |s2| (QREFELT $ 14))) 

(SDEFUN |ITFUN3;map;MItSS;3|
        ((|f| (|Mapping| C A B)) (|s1| (|InfiniteTuple| A)) (|s2| (|Stream| B))
         ($ (|Stream| C)))
        (SPADCALL |f| |s1| |s2| (QREFELT $ 14))) 

(DECLAIM (NOTINLINE |InfiniteTupleFunctions3;|)) 

(DEFUN |InfiniteTupleFunctions3| (&REST #1=#:G698)
  (SPROG NIL
         (PROG (#2=#:G699)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|InfiniteTupleFunctions3|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |InfiniteTupleFunctions3;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|InfiniteTupleFunctions3|)))))))))) 

(DEFUN |InfiniteTupleFunctions3;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|InfiniteTupleFunctions3| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 21))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|InfiniteTupleFunctions3|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|InfiniteTupleFunctions3| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Stream| 8) (|Mapping| 8 6 7) (|Stream| 6)
              (|Stream| 7) (|StreamFunctions3| 6 7 8) (0 . |map|)
              (|InfiniteTuple| 8) (|InfiniteTuple| 6) (|InfiniteTuple| 7)
              |ITFUN3;map;MItItIt;1| |ITFUN3;map;MSItS;2| |ITFUN3;map;MItSS;3|)
           '#(|map| 7) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|InfiniteTuple| |#3|)
                                  (|Mapping| |#3| |#1| |#2|)
                                  (|InfiniteTuple| |#1|)
                                  (|InfiniteTuple| |#2|)))
                                T)
                              '((|map|
                                 ((|Stream| |#3|) (|Mapping| |#3| |#1| |#2|)
                                  (|Stream| |#1|) (|InfiniteTuple| |#2|)))
                                T)
                              '((|map|
                                 ((|Stream| |#3|) (|Mapping| |#3| |#1| |#2|)
                                  (|InfiniteTuple| |#1|) (|Stream| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 20
                                            '(3 13 9 10 11 12 14 3 0 15 10 16
                                              17 18 3 0 9 10 16 12 20 3 0 9 10
                                              11 17 19)))))
           '|lookupComplete|)) 
