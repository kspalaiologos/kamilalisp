
(PUT '|AGG-;eq?;2SB;1| '|SPADreplace| 'EQ) 

(SDEFUN |AGG-;eq?;2SB;1| ((|a| (S)) (|b| (S)) ($ (|Boolean|))) (EQ |a| |b|)) 

(SDEFUN |AGG-;sample;S;2| (($ (S))) (SPADCALL (QREFELT $ 9))) 

(SDEFUN |AGG-;empty?;SB;3| ((|a| (S)) ($ (|Boolean|)))
        (EQL (SPADCALL |a| (QREFELT $ 12)) 0)) 

(SDEFUN |AGG-;less?;SNniB;4|
        ((|a| (S)) (|n| (|NonNegativeInteger|)) ($ (|Boolean|)))
        (< (SPADCALL |a| (QREFELT $ 12)) |n|)) 

(SDEFUN |AGG-;more?;SNniB;5|
        ((|a| (S)) (|n| (|NonNegativeInteger|)) ($ (|Boolean|)))
        (> (SPADCALL |a| (QREFELT $ 12)) |n|)) 

(SDEFUN |AGG-;size?;SNniB;6|
        ((|a| (S)) (|n| (|NonNegativeInteger|)) ($ (|Boolean|)))
        (EQL (SPADCALL |a| (QREFELT $ 12)) |n|)) 

(DECLAIM (NOTINLINE |Aggregate&;|)) 

(DEFUN |Aggregate&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|Aggregate&| DV$1))
          (LETT $ (GETREFV 17))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|finiteAggregate|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 13 (CONS (|dispatchFunction| |AGG-;empty?;SB;3|) $))
             (QSETREFV $ 14 (CONS (|dispatchFunction| |AGG-;less?;SNniB;4|) $))
             (QSETREFV $ 15 (CONS (|dispatchFunction| |AGG-;more?;SNniB;5|) $))
             (QSETREFV $ 16
                       (CONS (|dispatchFunction| |AGG-;size?;SNniB;6|) $)))))
          $))) 

(MAKEPROP '|Aggregate&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Boolean|)
              |AGG-;eq?;2SB;1| (0 . |empty|) |AGG-;sample;S;2|
              (|NonNegativeInteger|) (4 . |#|) (9 . |empty?|) (14 . |less?|)
              (20 . |more?|) (26 . |size?|))
           '#(|size?| 32 |sample| 38 |more?| 42 |less?| 48 |eq?| 54 |empty?|
              60)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|sample| (|#1|)) T)
                                   '((|size?|
                                      ((|Boolean|) |#1|
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|more?|
                                      ((|Boolean|) |#1|
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|less?|
                                      ((|Boolean|) |#1|
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|empty?| ((|Boolean|) |#1|)) T)
                                   '((|eq?| ((|Boolean|) |#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 16
                                            '(0 6 0 9 1 6 11 0 12 1 0 7 0 13 2
                                              0 7 0 11 14 2 0 7 0 11 15 2 0 7 0
                                              11 16 2 0 7 0 11 16 0 0 0 10 2 0
                                              7 0 11 15 2 0 7 0 11 14 2 0 7 0 0
                                              8 1 0 7 0 13)))))
           '|lookupComplete|)) 
