
(SDEFUN |ONECOMP2;map;MOpcOpc;1|
        ((|f| (|Mapping| S R)) (|r| (|OnePointCompletion| R))
         ($ (|OnePointCompletion| S)))
        (SPADCALL |f| |r| (SPADCALL (QREFELT $ 9)) (QREFELT $ 12))) 

(SDEFUN |ONECOMP2;map;MOpc2Opc;2|
        ((|f| (|Mapping| S R)) (|r| (|OnePointCompletion| R))
         (|i| (|OnePointCompletion| S)) ($ (|OnePointCompletion| S)))
        (SPROG ((|u| (|Union| R "failed")))
               (SEQ (LETT |u| (SPADCALL |r| (QREFELT $ 15)))
                    (EXIT
                     (COND
                      ((QEQCAR |u| 0)
                       (SPADCALL (SPADCALL (QCDR |u|) |f|) (QREFELT $ 16)))
                      ('T |i|)))))) 

(DECLAIM (NOTINLINE |OnePointCompletionFunctions2;|)) 

(DEFUN |OnePointCompletionFunctions2| (&REST #1=#:G697)
  (SPROG NIL
         (PROG (#2=#:G698)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|OnePointCompletionFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |OnePointCompletionFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|OnePointCompletionFunctions2|)))))))))) 

(DEFUN |OnePointCompletionFunctions2;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|OnePointCompletionFunctions2| DV$1 DV$2))
          (LETT $ (GETREFV 17))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OnePointCompletionFunctions2|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|OnePointCompletionFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|OnePointCompletion| 7) (0 . |infinity|) (|Mapping| 7 6)
              (|OnePointCompletion| 6) |ONECOMP2;map;MOpc2Opc;2|
              |ONECOMP2;map;MOpcOpc;1| (|Union| 6 '"failed")
              (4 . |retractIfCan|) (9 . |coerce|))
           '#(|map| 14) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|OnePointCompletion| |#2|)
                                  (|Mapping| |#2| |#1|)
                                  (|OnePointCompletion| |#1|)))
                                T)
                              '((|map|
                                 ((|OnePointCompletion| |#2|)
                                  (|Mapping| |#2| |#1|)
                                  (|OnePointCompletion| |#1|)
                                  (|OnePointCompletion| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 16
                                            '(0 8 0 9 1 11 14 0 15 1 8 0 7 16 3
                                              0 8 10 11 8 12 2 0 8 10 11
                                              13)))))
           '|lookupComplete|)) 
