
(SDEFUN |ALGEBRA-;coerce;RS;1| ((|x| (R)) ($ (S)))
        (SPADCALL |x| (|spadConstant| $ 8) (QREFELT $ 9))) 

(DECLAIM (NOTINLINE |Algebra&;|)) 

(DEFUN |Algebra&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|Algebra&| DV$1 DV$2))
          (LETT $ (GETREFV 13))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|Algebra&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (0 . |One|)
              (4 . *) |ALGEBRA-;coerce;RS;1| (|OutputForm|) (|Integer|))
           '#(|coerce| 10) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|coerce| (|#1| |#2|)) T)
                                   '((|coerce| (|#1| (|Integer|))) T)
                                   '((|coerce| ((|OutputForm|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 10
                                            '(0 6 0 8 2 6 0 7 0 9 1 0 0 7
                                              10)))))
           '|lookupComplete|)) 
