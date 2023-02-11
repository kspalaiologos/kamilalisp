
(SDEFUN |DIVRING-;^;SIS;1| ((|x| (S)) (|n| (|Integer|)) ($ (S)))
        (COND ((ZEROP |n|) (|spadConstant| $ 7))
              ((SPADCALL |x| (QREFELT $ 9))
               (COND ((< |n| 0) (|error| "division by zero")) (#1='T |x|)))
              ((< |n| 0)
               (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (- |n|) (QREFELT $ 14)))
              (#1# (SPADCALL |x| |n| (QREFELT $ 14))))) 

(SDEFUN |DIVRING-;*;F2S;2| ((|q| (|Fraction| (|Integer|))) (|x| (S)) ($ (S)))
        (SPADCALL
         (SPADCALL (SPADCALL |q| (QREFELT $ 18))
                   (SPADCALL
                    (SPADCALL (SPADCALL |q| (QREFELT $ 19)) (QREFELT $ 20))
                    (QREFELT $ 11))
                   (QREFELT $ 21))
         |x| (QREFELT $ 22))) 

(DECLAIM (NOTINLINE |DivisionRing&;|)) 

(DEFUN |DivisionRing&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|DivisionRing&| DV$1))
          (LETT $ (GETREFV 25))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|DivisionRing&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |One|) (|Boolean|)
              (4 . |zero?|) (9 . |Zero|) (13 . |inv|) (|PositiveInteger|)
              (|RepeatedSquaring| 6) (18 . |expt|) (|Integer|)
              |DIVRING-;^;SIS;1| (|Fraction| 15) (24 . |numer|) (29 . |denom|)
              (34 . |coerce|) (39 . *) (45 . *) |DIVRING-;*;F2S;2|
              (|NonNegativeInteger|))
           '#(^ 51 * 57) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((^ (|#1| |#1| (|Integer|))) T)
                                   '((* (|#1| |#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((* (|#1| (|Fraction| (|Integer|)) |#1|))
                                     T)
                                   '((^ (|#1| |#1| (|NonNegativeInteger|))) T)
                                   '((* (|#1| (|NonNegativeInteger|) |#1|)) T)
                                   '((* (|#1| (|Integer|) |#1|)) T)
                                   '((* (|#1| |#1| |#1|)) T)
                                   '((^ (|#1| |#1| (|PositiveInteger|))) T)
                                   '((* (|#1| (|PositiveInteger|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 23
                                            '(0 6 0 7 1 6 8 0 9 0 6 0 10 1 6 0
                                              0 11 2 13 6 6 12 14 1 17 15 0 18
                                              1 17 15 0 19 1 6 0 15 20 2 6 0 15
                                              0 21 2 6 0 0 0 22 2 0 0 0 15 16 2
                                              0 0 17 0 23)))))
           '|lookupComplete|)) 
