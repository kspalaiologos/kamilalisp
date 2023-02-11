
(SDEFUN |LOGIC-;T$;S;1| (($ (S))) (|spadConstant| $ 7)) 

(SDEFUN |LOGIC-;_\|_;S;2| (($ (S))) (|spadConstant| $ 9)) 

(DECLAIM (NOTINLINE |Logic&;|)) 

(DEFUN |Logic&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|Logic&| DV$1))
          (LETT $ (GETREFV 11))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|Logic&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |true|)
              |LOGIC-;T$;S;1| (4 . |false|) |LOGIC-;_\|_;S;2|)
           '#(|_\|_| 8 T$ 12) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|_\|_| (|#1|)) T) '((T$ (|#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 10
                                            '(0 6 0 7 0 6 0 9 0 0 0 10 0 0 0
                                              8)))))
           '|lookupComplete|)) 
