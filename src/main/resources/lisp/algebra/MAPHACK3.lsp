
(SDEFUN |MAPHACK3;comp;MMAC;1|
        ((|g| (|Mapping| C B)) (|h| (|Mapping| B A)) (|x| (A)) ($ (C)))
        (SPADCALL (SPADCALL |x| |h|) |g|)) 

(DECLAIM (NOTINLINE |MappingPackageInternalHacks3;|)) 

(DEFUN |MappingPackageInternalHacks3| (&REST #1=#:G692)
  (SPROG NIL
         (PROG (#2=#:G693)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|MappingPackageInternalHacks3|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |MappingPackageInternalHacks3;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|MappingPackageInternalHacks3|)))))))))) 

(DEFUN |MappingPackageInternalHacks3;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|MappingPackageInternalHacks3| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 12))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|MappingPackageInternalHacks3|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|MappingPackageInternalHacks3| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Mapping| 8 7) (|Mapping| 7 6)
              |MAPHACK3;comp;MMAC;1|)
           '#(|comp| 0) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|comp|
                                 (|#3| (|Mapping| |#3| |#2|)
                                  (|Mapping| |#2| |#1|) |#1|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 11 '(3 0 8 9 10 6 11)))))
           '|lookupComplete|)) 
