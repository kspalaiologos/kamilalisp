
(SDEFUN |SRAGG-;trim;SCcS;1| ((|s| (S)) (|cc| (|CharacterClass|)) ($ (S)))
        (SPADCALL (SPADCALL |s| |cc| (QREFELT $ 8)) |cc| (QREFELT $ 9))) 

(SDEFUN |SRAGG-;lowerCase;2S;2| ((|s| (S)) ($ (S)))
        (SPADCALL (SPADCALL |s| (QREFELT $ 11)) (QREFELT $ 12))) 

(SDEFUN |SRAGG-;upperCase;2S;3| ((|s| (S)) ($ (S)))
        (SPADCALL (SPADCALL |s| (QREFELT $ 11)) (QREFELT $ 14))) 

(SDEFUN |SRAGG-;prefix?;2SB;4| ((|s| (S)) (|t| (S)) ($ (|Boolean|)))
        (SPADCALL |s| |t| (SPADCALL |t| (QREFELT $ 17)) (QREFELT $ 19))) 

(SDEFUN |SRAGG-;coerce;CS;5| ((|c| (|Character|)) ($ (S)))
        (SPADCALL 1 |c| (QREFELT $ 23))) 

(SDEFUN |SRAGG-;elt;3S;6| ((|s| (S)) (|t| (S)) ($ (S)))
        (SPADCALL |s| |t| (QREFELT $ 25))) 

(DECLAIM (NOTINLINE |StringAggregate&;|)) 

(DEFUN |StringAggregate&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|StringAggregate&| DV$1))
          (LETT $ (GETREFV 29))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|StringAggregate&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|CharacterClass|)
              (0 . |rightTrim|) (6 . |leftTrim|) |SRAGG-;trim;SCcS;1|
              (12 . |copy|) (17 . |lowerCase!|) |SRAGG-;lowerCase;2S;2|
              (22 . |upperCase!|) |SRAGG-;upperCase;2S;3| (|Integer|)
              (27 . |minIndex|) (|Boolean|) (32 . |substring?|)
              |SRAGG-;prefix?;2SB;4| (|NonNegativeInteger|) (|Character|)
              (39 . |new|) |SRAGG-;coerce;CS;5| (45 . |concat|)
              |SRAGG-;elt;3S;6| (|OutputForm|) (|UniversalSegment| 16))
           '#(|upperCase| 51 |trim| 56 |prefix?| 62 |lowerCase| 68 |elt| 73
              |coerce| 79)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|elt| (|#1| |#1| |#1|)) T)
                                   '((|trim| (|#1| |#1| (|CharacterClass|))) T)
                                   '((|coerce| (|#1| (|Character|))) T)
                                   '((|prefix?| ((|Boolean|) |#1| |#1|)) T)
                                   '((|upperCase| (|#1| |#1|)) T)
                                   '((|lowerCase| (|#1| |#1|)) T)
                                   '((|coerce| ((|OutputForm|) |#1|)) T)
                                   '((|trim| (|#1| |#1| (|Character|))) T)
                                   '((|elt|
                                      (|#1| |#1|
                                       (|UniversalSegment| (|Integer|))))
                                     T)
                                   '((|elt| ((|Character|) |#1| (|Integer|)))
                                     T)
                                   '((|elt|
                                      ((|Character|) |#1| (|Integer|)
                                       (|Character|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 26
                                            '(2 6 0 0 7 8 2 6 0 0 7 9 1 6 0 0
                                              11 1 6 0 0 12 1 6 0 0 14 1 6 16 0
                                              17 3 6 18 0 0 16 19 2 6 0 21 22
                                              23 2 6 0 0 0 25 1 0 0 0 15 2 0 0
                                              0 7 10 2 0 18 0 0 20 1 0 0 0 13 2
                                              0 0 0 0 26 1 0 0 22 24)))))
           '|lookupComplete|)) 
