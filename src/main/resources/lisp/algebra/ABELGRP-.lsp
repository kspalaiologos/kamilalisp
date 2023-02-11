
(SDEFUN |ABELGRP-;-;3S;1| ((|x| (S)) (|y| (S)) ($ (S)))
        (SPADCALL |x| (SPADCALL |y| (QREFELT $ 7)) (QREFELT $ 8))) 

(SDEFUN |ABELGRP-;subtractIfCan;2SU;2|
        ((|x| (S)) (|y| (S)) ($ (|Union| S "failed")))
        (CONS 0 (SPADCALL |x| |y| (QREFELT $ 10)))) 

(SDEFUN |ABELGRP-;*;Nni2S;3| ((|n| (|NonNegativeInteger|)) (|x| (S)) ($ (S)))
        (SPADCALL |n| |x| (QREFELT $ 14))) 

(SDEFUN |ABELGRP-;*;I2S;4| ((|n| (|Integer|)) (|x| (S)) ($ (S)))
        (COND ((ZEROP |n|) (|spadConstant| $ 17))
              ((> |n| 0) (SPADCALL |n| |x| (QREFELT $ 20)))
              ('T
               (SPADCALL (- |n|) (SPADCALL |x| (QREFELT $ 7)) (QREFELT $ 20))))) 

(SDEFUN |ABELGRP-;opposite?;2SB;5| ((|x| (S)) (|y| (S)) ($ (|Boolean|)))
        (SPADCALL |x| (SPADCALL |y| (QREFELT $ 7)) (QREFELT $ 23))) 

(DECLAIM (NOTINLINE |AbelianGroup&;|)) 

(DEFUN |AbelianGroup&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|AbelianGroup&| DV$1))
          (LETT $ (GETREFV 25))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND ((|HasCategory| |#1| '(|Ring|)))
                ('T
                 (QSETREFV $ 21
                           (CONS (|dispatchFunction| |ABELGRP-;*;I2S;4|) $))))
          $))) 

(MAKEPROP '|AbelianGroup&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . -) (5 . +)
              |ABELGRP-;-;3S;1| (11 . -) (|Union| $ '"failed")
              |ABELGRP-;subtractIfCan;2SU;2| (|Integer|) (17 . *)
              (|NonNegativeInteger|) |ABELGRP-;*;Nni2S;3| (23 . |Zero|)
              (|PositiveInteger|) (|RepeatedDoubling| 6) (27 . |double|)
              (33 . *) (|Boolean|) (39 . =) |ABELGRP-;opposite?;2SB;5|)
           '#(|subtractIfCan| 45 |opposite?| 51 - 57 * 63) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((* (|#1| (|Integer|) |#1|)) T)
                                   '((- (|#1| |#1| |#1|)) T)
                                   '((- (|#1| |#1|)) T)
                                   '((|subtractIfCan|
                                      ((|Union| |#1| "failed") |#1| |#1|))
                                     T)
                                   '((|opposite?| ((|Boolean|) |#1| |#1|)) T)
                                   '((* (|#1| (|NonNegativeInteger|) |#1|)) T)
                                   '((* (|#1| (|PositiveInteger|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 24
                                            '(1 6 0 0 7 2 6 0 0 0 8 2 6 0 0 0
                                              10 2 6 0 13 0 14 0 6 0 17 2 19 6
                                              18 6 20 2 0 0 13 0 21 2 6 22 0 0
                                              23 2 0 11 0 0 12 2 0 22 0 0 24 2
                                              0 0 0 0 9 2 0 0 13 0 21 2 0 0 15
                                              0 16)))))
           '|lookupComplete|)) 
