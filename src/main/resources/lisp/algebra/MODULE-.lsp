
(SDEFUN |MODULE-;*;SRS;1| ((|x| (S)) (|r| (R)) ($ (S)))
        (SPADCALL |r| |x| (QREFELT $ 8))) 

(DECLAIM (NOTINLINE |Module&;|)) 

(DEFUN |Module&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|Module&| DV$1 DV$2))
          (LETT $ (GETREFV 13))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND ((|domainEqual| |#2| |#1|))
                ('T
                 (QSETREFV $ 9
                           (CONS (|dispatchFunction| |MODULE-;*;SRS;1|) $))))
          $))) 

(MAKEPROP '|Module&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (0 . *)
              (6 . *) (|Integer|) (|NonNegativeInteger|) (|PositiveInteger|))
           '#(* 12) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((* (|#1| |#1| |#2|)) T)
                                   '((* (|#1| (|Integer|) |#1|)) T)
                                   '((* (|#1| (|NonNegativeInteger|) |#1|)) T)
                                   '((* (|#1| |#2| |#1|)) T)
                                   '((* (|#1| (|PositiveInteger|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 9
                                            '(2 6 0 7 0 8 2 0 0 0 7 9 2 0 0 0 7
                                              9)))))
           '|lookupComplete|)) 
