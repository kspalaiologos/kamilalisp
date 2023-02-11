
(SDEFUN |ELEMFUN-;^;3S;1| ((|x| (S)) (|y| (S)) ($ (S)))
        (SPADCALL (SPADCALL |y| (SPADCALL |x| (QREFELT $ 7)) (QREFELT $ 8))
                  (QREFELT $ 9))) 

(DECLAIM (NOTINLINE |ElementaryFunctionCategory&;|)) 

(DEFUN |ElementaryFunctionCategory&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|ElementaryFunctionCategory&| DV$1))
          (LETT $ (GETREFV 11))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#1| '(|Monoid|))
            (QSETREFV $ 10 (CONS (|dispatchFunction| |ELEMFUN-;^;3S;1|) $))))
          $))) 

(MAKEPROP '|ElementaryFunctionCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |log|) (5 . *)
              (11 . |exp|) (16 . ^))
           '#(^ 22) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory| (LIST '((^ (|#1| |#1| |#1|)) T))
                                          (LIST) NIL NIL)))
                        (|makeByteWordVec2| 10
                                            '(1 6 0 0 7 2 6 0 0 0 8 1 6 0 0 9 2
                                              0 0 0 0 10 2 0 0 0 0 10)))))
           '|lookupComplete|)) 
