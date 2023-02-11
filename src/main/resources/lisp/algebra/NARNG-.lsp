
(SDEFUN |NARNG-;associator;4S;1| ((|x| (S)) (|y| (S)) (|z| (S)) ($ (S)))
        (SPADCALL (SPADCALL (SPADCALL |x| |y| (QREFELT $ 7)) |z| (QREFELT $ 7))
                  (SPADCALL |x| (SPADCALL |y| |z| (QREFELT $ 7)) (QREFELT $ 7))
                  (QREFELT $ 8))) 

(SDEFUN |NARNG-;commutator;3S;2| ((|x| (S)) (|y| (S)) ($ (S)))
        (SPADCALL (SPADCALL |x| |y| (QREFELT $ 7))
                  (SPADCALL |y| |x| (QREFELT $ 7)) (QREFELT $ 8))) 

(DECLAIM (NOTINLINE |NonAssociativeRng&;|)) 

(DEFUN |NonAssociativeRng&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|NonAssociativeRng&| DV$1))
          (LETT $ (GETREFV 11))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|NonAssociativeRng&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . *) (6 . -)
              |NARNG-;associator;4S;1| |NARNG-;commutator;3S;2|)
           '#(|commutator| 12 |associator| 18) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|commutator| (|#1| |#1| |#1|)) T)
                                   '((|associator| (|#1| |#1| |#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 10
                                            '(2 6 0 0 0 7 2 6 0 0 0 8 2 0 0 0 0
                                              10 3 0 0 0 0 0 9)))))
           '|lookupComplete|)) 
