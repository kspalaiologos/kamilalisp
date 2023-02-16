
(SDEFUN |ABELSG-;*;Pi2S;1| ((|n| (|PositiveInteger|)) (|x| (S)) ($ (S)))
        (SPADCALL |n| |x| (QREFELT $ 9))) 

(DECLAIM (NOTINLINE |AbelianSemiGroup&;|)) 

(DEFUN |AbelianSemiGroup&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|AbelianSemiGroup&| DV$1))
          (LETT $ (GETREFV 11))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND ((|HasCategory| |#1| '(|Ring|)))
                ('T
                 (QSETREFV $ 10
                           (CONS (|dispatchFunction| |ABELSG-;*;Pi2S;1|) $))))
          $))) 

(MAKEPROP '|AbelianSemiGroup&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|PositiveInteger|)
              (|RepeatedDoubling| 6) (0 . |double|) (6 . *))
           '#(* 12) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((* (|#1| (|PositiveInteger|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 10
                                            '(2 8 6 7 6 9 2 0 0 7 0 10 2 0 0 7
                                              0 10)))))
           '|lookupComplete|)) 
