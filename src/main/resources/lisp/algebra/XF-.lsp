
(SDEFUN |XF-;algebraic?;SB;1| ((|a| (S)) ($ (|Boolean|)))
        (NULL (SPADCALL (SPADCALL |a| (QREFELT $ 9)) (QREFELT $ 11)))) 

(SDEFUN |XF-;transcendent?;SB;2| ((|a| (S)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |a| (QREFELT $ 9)) (QREFELT $ 11))) 

(SDEFUN |XF-;Frobenius;2S;3| ((|a| (S)) ($ (S)))
        (SPADCALL |a| (SPADCALL (QREFELT $ 15)) (QREFELT $ 16))) 

(SDEFUN |XF-;Frobenius;SNniS;4|
        ((|a| (S)) (|s| (|NonNegativeInteger|)) ($ (S)))
        (SPADCALL |a| (EXPT (SPADCALL (QREFELT $ 15)) |s|) (QREFELT $ 16))) 

(DECLAIM (NOTINLINE |ExtensionField&;|)) 

(DEFUN |ExtensionField&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|ExtensionField&| DV$1 DV$2))
          (LETT $ (GETREFV 19))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2| '(|Finite|))
                                              (|HasCategory| |#2|
                                                             '(|CharacteristicNonZero|))
                                              (|HasCategory| |#2|
                                                             '(|CharacteristicZero|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 17 (CONS (|dispatchFunction| |XF-;Frobenius;2S;3|) $))
             (QSETREFV $ 18
                       (CONS (|dispatchFunction| |XF-;Frobenius;SNniS;4|)
                             $)))))
          $))) 

(MAKEPROP '|ExtensionField&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|OnePointCompletion| (|PositiveInteger|)) (0 . |degree|)
              (|Boolean|) (5 . |infinite?|) |XF-;algebraic?;SB;1|
              |XF-;transcendent?;SB;2| (|NonNegativeInteger|) (10 . |size|)
              (14 . ^) (20 . |Frobenius|) (25 . |Frobenius|))
           '#(|transcendent?| 31 |algebraic?| 36 |Frobenius| 41) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|Frobenius|
                                 (|#1| |#1| (|NonNegativeInteger|)))
                                T)
                              '((|Frobenius| (|#1| |#1|)) T)
                              '((|transcendent?| ((|Boolean|) |#1|)) T)
                              '((|algebraic?| ((|Boolean|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 18
                                            '(1 6 8 0 9 1 8 10 0 11 0 7 14 15 2
                                              6 0 0 14 16 1 0 0 0 17 2 0 0 0 14
                                              18 1 0 10 0 13 1 0 10 0 12 1 0 0
                                              0 17 2 0 0 0 14 18)))))
           '|lookupComplete|)) 
