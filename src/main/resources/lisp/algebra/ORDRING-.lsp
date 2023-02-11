
(SDEFUN |ORDRING-;positive?;SB;1| ((|x| (S)) ($ (|Boolean|)))
        (SPADCALL |x| (|spadConstant| $ 7) (QREFELT $ 9))) 

(SDEFUN |ORDRING-;negative?;SB;2| ((|x| (S)) ($ (|Boolean|)))
        (SPADCALL |x| (|spadConstant| $ 7) (QREFELT $ 11))) 

(SDEFUN |ORDRING-;sign;SI;3| ((|x| (S)) ($ (|Integer|)))
        (COND ((SPADCALL |x| (QREFELT $ 13)) 1)
              ((SPADCALL |x| (QREFELT $ 14)) -1)
              ((SPADCALL |x| (QREFELT $ 16)) 0)
              ('T
               (|error| "x satisfies neither positive?, negative? or zero?")))) 

(SDEFUN |ORDRING-;abs;2S;4| ((|x| (S)) ($ (S)))
        (COND ((SPADCALL |x| (QREFELT $ 13)) |x|)
              ((SPADCALL |x| (QREFELT $ 14)) (SPADCALL |x| (QREFELT $ 19)))
              ((SPADCALL |x| (QREFELT $ 16)) (|spadConstant| $ 7))
              ('T
               (|error| "x satisfies neither positive?, negative? or zero?")))) 

(DECLAIM (NOTINLINE |OrderedRing&;|)) 

(DEFUN |OrderedRing&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|OrderedRing&| DV$1))
          (LETT $ (GETREFV 21))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|OrderedRing&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |Zero|) (|Boolean|)
              (4 . >) |ORDRING-;positive?;SB;1| (10 . <)
              |ORDRING-;negative?;SB;2| (16 . |positive?|) (21 . |negative?|)
              (26 . |One|) (30 . |zero?|) (|Integer|) |ORDRING-;sign;SI;3|
              (35 . -) |ORDRING-;abs;2S;4|)
           '#(|sign| 40 |positive?| 45 |negative?| 50 |abs| 55) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|abs| (|#1| |#1|)) T)
                                   '((|sign| ((|Integer|) |#1|)) T)
                                   '((|negative?| ((|Boolean|) |#1|)) T)
                                   '((|positive?| ((|Boolean|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 20
                                            '(0 6 0 7 2 6 8 0 0 9 2 6 8 0 0 11
                                              1 6 8 0 13 1 6 8 0 14 0 6 0 15 1
                                              6 8 0 16 1 6 0 0 19 1 0 17 0 18 1
                                              0 8 0 10 1 0 8 0 12 1 0 0 0
                                              20)))))
           '|lookupComplete|)) 
