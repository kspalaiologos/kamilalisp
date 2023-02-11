
(SDEFUN |ORDCOMP2;map;MOcOc;1|
        ((|f| (|Mapping| S R)) (|r| (|OrderedCompletion| R))
         ($ (|OrderedCompletion| S)))
        (SPADCALL |f| |r| (SPADCALL (QREFELT $ 9)) (SPADCALL (QREFELT $ 10))
                  (QREFELT $ 13))) 

(SDEFUN |ORDCOMP2;map;MOc3Oc;2|
        ((|f| (|Mapping| S R)) (|r| (|OrderedCompletion| R))
         (|p| (|OrderedCompletion| S)) (|m| (|OrderedCompletion| S))
         ($ (|OrderedCompletion| S)))
        (SPROG ((|n| (|SingleInteger|)))
               (COND
                ((|zero?_SI| (LETT |n| (SPADCALL |r| (QREFELT $ 16))))
                 (SPADCALL (SPADCALL (SPADCALL |r| (QREFELT $ 17)) |f|)
                           (QREFELT $ 18)))
                ((|eql_SI| |n| 1) |p|) ('T |m|)))) 

(DECLAIM (NOTINLINE |OrderedCompletionFunctions2;|)) 

(DEFUN |OrderedCompletionFunctions2| (&REST #1=#:G697)
  (SPROG NIL
         (PROG (#2=#:G698)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|OrderedCompletionFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |OrderedCompletionFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|OrderedCompletionFunctions2|)))))))))) 

(DEFUN |OrderedCompletionFunctions2;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|OrderedCompletionFunctions2| DV$1 DV$2))
          (LETT $ (GETREFV 19))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OrderedCompletionFunctions2|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|OrderedCompletionFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|OrderedCompletion| 7) (0 . |plusInfinity|)
              (4 . |minusInfinity|) (|Mapping| 7 6) (|OrderedCompletion| 6)
              |ORDCOMP2;map;MOc3Oc;2| |ORDCOMP2;map;MOcOc;1| (|SingleInteger|)
              (8 . |whatInfinity|) (13 . |retract|) (18 . |coerce|))
           '#(|map| 23) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|OrderedCompletion| |#2|)
                                  (|Mapping| |#2| |#1|)
                                  (|OrderedCompletion| |#1|)))
                                T)
                              '((|map|
                                 ((|OrderedCompletion| |#2|)
                                  (|Mapping| |#2| |#1|)
                                  (|OrderedCompletion| |#1|)
                                  (|OrderedCompletion| |#2|)
                                  (|OrderedCompletion| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 18
                                            '(0 8 0 9 0 8 0 10 1 12 15 0 16 1
                                              12 6 0 17 1 8 0 7 18 4 0 8 11 12
                                              8 8 13 2 0 8 11 12 14)))))
           '|lookupComplete|)) 
