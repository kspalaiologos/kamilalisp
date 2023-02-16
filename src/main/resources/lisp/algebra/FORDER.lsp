
(SDEFUN |FORDER;order;FdNni;1|
        ((|d| (|FiniteDivisor| F UP UPUP R)) ($ (|NonNegativeInteger|)))
        (SPROG ((|dd| (|FiniteDivisor| F UP UPUP R)) (#1=#:G702 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ (LETT |dd| (LETT |d| (SPADCALL |d| (QREFELT $ 11))))
                      (EXIT
                       (SEQ (LETT |i| 1) G190 NIL
                            (SEQ
                             (EXIT
                              (COND
                               ((SPADCALL |dd| (QREFELT $ 13))
                                (PROGN (LETT #1# |i|) (GO #2=#:G701)))
                               ('T
                                (LETT |dd|
                                      (SPADCALL
                                       (SPADCALL |d| |dd| (QREFELT $ 14))
                                       (QREFELT $ 11)))))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL)))))
                #2# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |FindOrderFinite;|)) 

(DEFUN |FindOrderFinite| (&REST #1=#:G703)
  (SPROG NIL
         (PROG (#2=#:G704)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FindOrderFinite|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FindOrderFinite;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FindOrderFinite|)))))))))) 

(DEFUN |FindOrderFinite;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|FindOrderFinite| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 17))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|FindOrderFinite|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|FindOrderFinite| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|FiniteDivisor| 6 7 8 9)
              (0 . |reduce|) (|Boolean|) (5 . |principal?|) (10 . +)
              (|NonNegativeInteger|) |FORDER;order;FdNni;1|)
           '#(|order| 16) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|order|
                                 ((|NonNegativeInteger|)
                                  (|FiniteDivisor| |#1| |#2| |#3| |#4|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 16
                                            '(1 10 0 0 11 1 10 12 0 13 2 10 0 0
                                              0 14 1 0 15 10 16)))))
           '|lookupComplete|)) 
