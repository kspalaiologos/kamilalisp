
(SDEFUN |INCRMAPS;increment;M;1| (($ (|Mapping| R R)))
        (CONS #'|INCRMAPS;increment;M;1!0| $)) 

(SDEFUN |INCRMAPS;increment;M;1!0| ((|x| NIL) ($ NIL))
        (SPADCALL (|spadConstant| $ 7) |x| (QREFELT $ 8))) 

(SDEFUN |INCRMAPS;incrementBy;RM;2| ((|n| (R)) ($ (|Mapping| R R)))
        (SPROG NIL (CONS #'|INCRMAPS;incrementBy;RM;2!0| (VECTOR $ |n|)))) 

(SDEFUN |INCRMAPS;incrementBy;RM;2!0| ((|x| NIL) ($$ NIL))
        (PROG (|n| $)
          (LETT |n| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |n| |x| (QREFELT $ 8)))))) 

(DECLAIM (NOTINLINE |IncrementingMaps;|)) 

(DEFUN |IncrementingMaps| (#1=#:G694)
  (SPROG NIL
         (PROG (#2=#:G695)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|IncrementingMaps|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|IncrementingMaps;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|IncrementingMaps|)))))))))) 

(DEFUN |IncrementingMaps;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|IncrementingMaps| DV$1))
          (LETT $ (GETREFV 12))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|IncrementingMaps| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|IncrementingMaps| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |One|) (4 . +)
              (|Mapping| 6 6) |INCRMAPS;increment;M;1|
              |INCRMAPS;incrementBy;RM;2|)
           '#(|incrementBy| 10 |increment| 15) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|increment| ((|Mapping| |#1| |#1|))) T)
                                   '((|incrementBy|
                                      ((|Mapping| |#1| |#1|) |#1|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 11
                                            '(0 6 0 7 2 6 0 0 0 8 1 0 9 6 11 0
                                              0 9 10)))))
           '|lookupComplete|)) 
