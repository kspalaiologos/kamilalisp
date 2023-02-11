
(SDEFUN |NARING-;coerce;IS;1| ((|n| (|Integer|)) ($ (S)))
        (SPADCALL |n| (|spadConstant| $ 7) (QREFELT $ 9))) 

(DECLAIM (NOTINLINE |NonAssociativeRing&;|)) 

(DEFUN |NonAssociativeRing&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|NonAssociativeRing&| DV$1))
          (LETT $ (GETREFV 12))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|NonAssociativeRing&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |One|) (|Integer|)
              (4 . *) |NARING-;coerce;IS;1| (|OutputForm|))
           '#(|coerce| 10) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|coerce| (|#1| (|Integer|))) T)
                                   '((|coerce| ((|OutputForm|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 10
                                            '(0 6 0 7 2 6 0 8 0 9 1 0 0 8
                                              10)))))
           '|lookupComplete|)) 
