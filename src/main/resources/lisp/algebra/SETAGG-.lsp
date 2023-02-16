
(SDEFUN |SETAGG-;symmetricDifference;3A;1| ((|x| (A)) (|y| (A)) ($ (A)))
        (SPADCALL (SPADCALL |x| |y| (QREFELT $ 8))
                  (SPADCALL |y| |x| (QREFELT $ 8)) (QREFELT $ 9))) 

(SDEFUN |SETAGG-;union;ASA;2| ((|s| (A)) (|x| (S)) ($ (A)))
        (SPADCALL |s| (SPADCALL (LIST |x|) (QREFELT $ 12)) (QREFELT $ 9))) 

(SDEFUN |SETAGG-;union;S2A;3| ((|x| (S)) (|s| (A)) ($ (A)))
        (SPADCALL |s| (SPADCALL (LIST |x|) (QREFELT $ 12)) (QREFELT $ 9))) 

(SDEFUN |SETAGG-;difference;ASA;4| ((|s| (A)) (|x| (S)) ($ (A)))
        (SPADCALL |s| (SPADCALL (LIST |x|) (QREFELT $ 12)) (QREFELT $ 8))) 

(DECLAIM (NOTINLINE |SetAggregate&;|)) 

(DEFUN |SetAggregate&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|SetAggregate&| DV$1 DV$2))
          (LETT $ (GETREFV 16))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|SetAggregate&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (0 . |difference|) (6 . |union|)
              |SETAGG-;symmetricDifference;3A;1| (|List| 7) (12 . |set|)
              |SETAGG-;union;ASA;2| |SETAGG-;union;S2A;3|
              |SETAGG-;difference;ASA;4|)
           '#(|union| 17 |symmetricDifference| 29 |difference| 35) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|union| (|#1| |#2| |#1|)) T)
                                   '((|union| (|#1| |#1| |#2|)) T)
                                   '((|union| (|#1| |#1| |#1|)) T)
                                   '((|symmetricDifference| (|#1| |#1| |#1|))
                                     T)
                                   '((|difference| (|#1| |#1| |#2|)) T)
                                   '((|difference| (|#1| |#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 15
                                            '(2 6 0 0 0 8 2 6 0 0 0 9 1 6 0 11
                                              12 2 0 0 7 0 14 2 0 0 0 7 13 2 0
                                              0 0 0 10 2 0 0 0 7 15)))))
           '|lookupComplete|)) 
