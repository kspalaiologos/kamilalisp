
(SDEFUN |BASTYPE-;~=;2SB;1| ((|x| (S)) (|y| (S)) ($ (|Boolean|)))
        (NULL (SPADCALL |x| |y| (QREFELT $ 8)))) 

(DECLAIM (NOTINLINE |BasicType&;|)) 

(DEFUN |BasicType&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|BasicType&| DV$1))
          (LETT $ (GETREFV 10))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|BasicType&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Boolean|) (0 . =)
              |BASTYPE-;~=;2SB;1|)
           '#(~= 6) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((~= ((|Boolean|) |#1| |#1|)) T)) (LIST)
                             NIL NIL)))
                        (|makeByteWordVec2| 9 '(2 6 7 0 0 8 2 0 7 0 0 9)))))
           '|lookupComplete|)) 
