
(SDEFUN |TENSPC-;tensor;2MS;1| ((|a| (M)) (|b| (M)) ($ (S)))
        (COND ((EQL (QREFELT $ 7) 2) (SPADCALL (LIST |a| |b|) (QREFELT $ 11)))
              ('T (|error| "not of order 2!")))) 

(DECLAIM (NOTINLINE |TensorPowerCategory&;|)) 

(DEFUN |TensorPowerCategory&| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 |#2|)
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|TensorPowerCategory&| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 13))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#4|
                                                       (LIST '|Algebra|
                                                             (|devaluate|
                                                              |#3|)))))))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|TensorPowerCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|List| 9) (0 . |tensor|)
              |TENSPC-;tensor;2MS;1|)
           '#(|tensor| 5) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|tensor| (|#1| |#4| |#4|)) T)
                                   '((|tensor| (|#1| (|List| |#4|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 12 '(1 6 0 10 11 2 0 0 9 9 12)))))
           '|lookupComplete|)) 
