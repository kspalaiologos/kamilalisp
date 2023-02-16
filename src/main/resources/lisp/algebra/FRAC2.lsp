
(SDEFUN |FRAC2;map;MFF;1|
        ((|f| (|Mapping| B A)) (|r| (|Fraction| A)) ($ (|Fraction| B)))
        (SPADCALL |f| |r| (QREFELT $ 12))) 

(DECLAIM (NOTINLINE |FractionFunctions2;|)) 

(DEFUN |FractionFunctions2| (&REST #1=#:G695)
  (SPROG NIL
         (PROG (#2=#:G696)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FractionFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FractionFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FractionFunctions2|)))))))))) 

(DEFUN |FractionFunctions2;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|FractionFunctions2| DV$1 DV$2))
          (LETT $ (GETREFV 14))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FractionFunctions2|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FractionFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Fraction| 7) (|Mapping| 7 6) (|Fraction| 6)
              (|QuotientFieldCategoryFunctions2| 6 7 10 8) (0 . |map|)
              |FRAC2;map;MFF;1|)
           '#(|map| 6) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|Fraction| |#2|) (|Mapping| |#2| |#1|)
                                  (|Fraction| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 13
                                            '(2 11 8 9 10 12 2 0 8 9 10 13)))))
           '|lookupComplete|)) 
