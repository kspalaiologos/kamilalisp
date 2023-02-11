
(SDEFUN |ORDSET-;smaller?;2SB;1| ((|x| (S)) (|y| (S)) ($ (|Boolean|)))
        (SPADCALL |x| |y| (QREFELT $ 8))) 

(SDEFUN |ORDSET-;max;3S;2| ((|x| (S)) (|y| (S)) ($ (S)))
        (COND ((SPADCALL |x| |y| (QREFELT $ 10)) |x|) ('T |y|))) 

(SDEFUN |ORDSET-;min;3S;3| ((|x| (S)) (|y| (S)) ($ (S)))
        (COND ((SPADCALL |x| |y| (QREFELT $ 10)) |y|) ('T |x|))) 

(SDEFUN |ORDSET-;>;2SB;4| ((|x| (S)) (|y| (S)) ($ (|Boolean|)))
        (SPADCALL |y| |x| (QREFELT $ 8))) 

(SDEFUN |ORDSET-;>=;2SB;5| ((|x| (S)) (|y| (S)) ($ (|Boolean|)))
        (NULL (SPADCALL |x| |y| (QREFELT $ 8)))) 

(SDEFUN |ORDSET-;<=;2SB;6| ((|x| (S)) (|y| (S)) ($ (|Boolean|)))
        (NULL (SPADCALL |y| |x| (QREFELT $ 8)))) 

(DECLAIM (NOTINLINE |OrderedSet&;|)) 

(DEFUN |OrderedSet&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|OrderedSet&| DV$1))
          (LETT $ (GETREFV 16))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|OrderedSet&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Boolean|) (0 . <)
              |ORDSET-;smaller?;2SB;1| (6 . >) |ORDSET-;max;3S;2|
              |ORDSET-;min;3S;3| |ORDSET-;>;2SB;4| |ORDSET-;>=;2SB;5|
              |ORDSET-;<=;2SB;6|)
           '#(|smaller?| 12 |min| 18 |max| 24 >= 30 > 36 <= 42) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|min| (|#1| |#1| |#1|)) T)
                                   '((|max| (|#1| |#1| |#1|)) T)
                                   '((<= ((|Boolean|) |#1| |#1|)) T)
                                   '((>= ((|Boolean|) |#1| |#1|)) T)
                                   '((> ((|Boolean|) |#1| |#1|)) T)
                                   '((|smaller?| ((|Boolean|) |#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 15
                                            '(2 6 7 0 0 8 2 6 7 0 0 10 2 0 7 0
                                              0 9 2 0 0 0 0 12 2 0 0 0 0 11 2 0
                                              7 0 0 14 2 0 7 0 0 13 2 0 7 0 0
                                              15)))))
           '|lookupComplete|)) 
