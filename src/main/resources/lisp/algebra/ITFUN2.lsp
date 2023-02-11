
(SDEFUN |ITFUN2;map;MItIt;1|
        ((|f| (|Mapping| B A)) (|x| (|InfiniteTuple| A))
         ($ (|InfiniteTuple| B)))
        (SPADCALL |f| |x| (QREFELT $ 12))) 

(DECLAIM (NOTINLINE |InfiniteTupleFunctions2;|)) 

(DEFUN |InfiniteTupleFunctions2| (&REST #1=#:G691)
  (SPROG NIL
         (PROG (#2=#:G692)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|InfiniteTupleFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |InfiniteTupleFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|InfiniteTupleFunctions2|)))))))))) 

(DEFUN |InfiniteTupleFunctions2;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|InfiniteTupleFunctions2| DV$1 DV$2))
          (LETT $ (GETREFV 16))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|InfiniteTupleFunctions2|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|InfiniteTupleFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Stream| 7) (|Mapping| 7 6) (|Stream| 6)
              (|StreamFunctions2| 6 7) (0 . |map|) (|InfiniteTuple| 7)
              (|InfiniteTuple| 6) |ITFUN2;map;MItIt;1|)
           '#(|map| 6) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|InfiniteTuple| |#2|) (|Mapping| |#2| |#1|)
                                  (|InfiniteTuple| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 15
                                            '(2 11 8 9 10 12 2 0 13 9 14
                                              15)))))
           '|lookupComplete|)) 
