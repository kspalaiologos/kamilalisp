
(SDEFUN |REPDB;double;Pi2S;1| ((|n| (|PositiveInteger|)) (|x| (S)) ($ (S)))
        (COND ((EQL |n| 1) |x|)
              ((ODDP |n|)
               (SPADCALL |x|
                         (SPADCALL (ASH |n| -1)
                                   (SPADCALL |x| |x| (QREFELT $ 7))
                                   (QREFELT $ 9))
                         (QREFELT $ 7)))
              ('T
               (SPADCALL (ASH |n| -1) (SPADCALL |x| |x| (QREFELT $ 7))
                         (QREFELT $ 9))))) 

(DECLAIM (NOTINLINE |RepeatedDoubling;|)) 

(DEFUN |RepeatedDoubling| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|RepeatedDoubling| DV$1))
          (LETT $ (GETREFV 10))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RepeatedDoubling| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . +)
              (|PositiveInteger|) |REPDB;double;Pi2S;1|)
           '#(|double| 6) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|double| (|#1| (|PositiveInteger|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 9 '(2 6 0 0 0 7 2 0 6 8 6 9)))))
           '|lookupComplete|)) 
