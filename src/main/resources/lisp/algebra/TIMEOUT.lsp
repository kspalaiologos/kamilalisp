
(PUT '|TIMEOUT;eval_with_timeout;MIU;1| '|SPADreplace| '|eval_with_timeout|) 

(SDEFUN |TIMEOUT;eval_with_timeout;MIU;1|
        ((|f| (|Mapping| S)) (|i| (|Integer|)) ($ (|Union| S "failed")))
        (|eval_with_timeout| |f| |i|)) 

(DECLAIM (NOTINLINE |TimeoutPackage;|)) 

(DEFUN |TimeoutPackage| (#1=#:G700)
  (SPROG NIL
         (PROG (#2=#:G701)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|TimeoutPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|TimeoutPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|TimeoutPackage|)))))))))) 

(DEFUN |TimeoutPackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|TimeoutPackage| DV$1))
          (LETT $ (GETREFV 11))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|TimeoutPackage| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|TimeoutPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Union| 6 '#1="failed")
              (|Mapping| 6) (|Integer|) |TIMEOUT;eval_with_timeout;MIU;1|)
           '#(|eval_with_timeout| 0) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|eval_with_timeout|
                                 ((|Union| |#1| #1#) (|Mapping| |#1|)
                                  (|Integer|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 10 '(2 0 7 8 9 10)))))
           '|lookupComplete|)) 
