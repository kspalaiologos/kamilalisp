
(SDEFUN |FPC-;primeFrobenius;2S;1| ((|a| (S)) ($ (S)))
        (SPADCALL |a| (SPADCALL (QREFELT $ 8)) (QREFELT $ 9))) 

(SDEFUN |FPC-;primeFrobenius;SNniS;2|
        ((|a| (S)) (|s| (|NonNegativeInteger|)) ($ (S)))
        (SPADCALL |a| (EXPT (SPADCALL (QREFELT $ 8)) |s|) (QREFELT $ 9))) 

(DECLAIM (NOTINLINE |FieldOfPrimeCharacteristic&;|)) 

(DEFUN |FieldOfPrimeCharacteristic&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|FieldOfPrimeCharacteristic&| DV$1))
          (LETT $ (GETREFV 12))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FieldOfPrimeCharacteristic&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|NonNegativeInteger|)
              (0 . |characteristic|) (4 . ^) |FPC-;primeFrobenius;2S;1|
              |FPC-;primeFrobenius;SNniS;2|)
           '#(|primeFrobenius| 10) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|primeFrobenius|
                                 (|#1| |#1| (|NonNegativeInteger|)))
                                T)
                              '((|primeFrobenius| (|#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 11
                                            '(0 6 7 8 2 6 0 0 7 9 1 0 0 0 10 2
                                              0 0 0 7 11)))))
           '|lookupComplete|)) 
