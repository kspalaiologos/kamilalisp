
(SDEFUN |DRAWHACK;coerce;SbSb;1|
        ((|s| (|SegmentBinding| (|Expression| R)))
         ($ (|SegmentBinding| (|Float|))))
        (SPADCALL (ELT $ 10) |s| (QREFELT $ 15))) 

(DECLAIM (NOTINLINE |DrawNumericHack;|)) 

(DEFUN |DrawNumericHack| (#1=#:G693)
  (SPROG NIL
         (PROG (#2=#:G694)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|DrawNumericHack|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|DrawNumericHack;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|DrawNumericHack|)))))))))) 

(DEFUN |DrawNumericHack;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|DrawNumericHack| DV$1))
          (LETT $ (GETREFV 17))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|DrawNumericHack| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|DrawNumericHack| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Float|) (|Expression| 6)
              (|Numeric| 6) (0 . |numeric|) (|SegmentBinding| 7)
              (|Mapping| 7 8) (|SegmentBinding| 8)
              (|SegmentBindingFunctions2| 8 7) (5 . |map|)
              |DRAWHACK;coerce;SbSb;1|)
           '#(|coerce| 11) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|coerce|
                                 ((|SegmentBinding| (|Float|))
                                  (|SegmentBinding| (|Expression| |#1|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 16
                                            '(1 9 7 8 10 2 14 11 12 13 15 1 0
                                              11 13 16)))))
           '|lookupComplete|)) 
