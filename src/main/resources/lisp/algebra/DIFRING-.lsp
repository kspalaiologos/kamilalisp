
(SDEFUN |DIFRING-;D;2S;1| ((|r| (S)) ($ (S))) (SPADCALL |r| (QREFELT $ 7))) 

(SDEFUN |DIFRING-;differentiate;SNniS;2|
        ((|r| (S)) (|n| (|NonNegativeInteger|)) ($ (S)))
        (SPROG ((#1=#:G707 NIL) (|i| NIL))
               (SEQ
                (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                     (COND ((|greater_SI| |i| #1#) (GO G191)))
                     (SEQ (EXIT (LETT |r| (SPADCALL |r| (QREFELT $ 7)))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT |r|)))) 

(SDEFUN |DIFRING-;D;SNniS;3| ((|r| (S)) (|n| (|NonNegativeInteger|)) ($ (S)))
        (SPADCALL |r| |n| (QREFELT $ 11))) 

(DECLAIM (NOTINLINE |DifferentialRing&;|)) 

(DEFUN |DifferentialRing&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|DifferentialRing&| DV$1))
          (LETT $ (GETREFV 13))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|DifferentialRing&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |differentiate|)
              |DIFRING-;D;2S;1| (|NonNegativeInteger|)
              |DIFRING-;differentiate;SNniS;2| (5 . |differentiate|)
              |DIFRING-;D;SNniS;3|)
           '#(|differentiate| 11 D 17) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((D (|#1| |#1| (|NonNegativeInteger|))) T)
                                   '((|differentiate|
                                      (|#1| |#1| (|NonNegativeInteger|)))
                                     T)
                                   '((D (|#1| |#1|)) T)
                                   '((|differentiate| (|#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 12
                                            '(1 6 0 0 7 2 6 0 0 9 11 2 0 0 0 9
                                              10 2 0 0 0 9 12 1 0 0 0 8)))))
           '|lookupComplete|)) 
