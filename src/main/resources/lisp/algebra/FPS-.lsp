
(SDEFUN |FPS-;float;2IS;1| ((|ma| (|Integer|)) (|ex| (|Integer|)) ($ (S)))
        (SPADCALL |ma| |ex| (SPADCALL (QREFELT $ 8)) (QREFELT $ 10))) 

(SDEFUN |FPS-;digits;Pi;2| (($ (|PositiveInteger|)))
        (SPROG ((#1=#:G715 NIL))
               (PROG1
                   (LETT #1#
                         (MAX 1
                              (QUOTIENT2
                               (* 4004 (- (SPADCALL (QREFELT $ 13)) 1))
                               13301)))
                 (|check_subtype2| (> #1# 0) '(|PositiveInteger|) '(|Integer|)
                                   #1#)))) 

(SDEFUN |FPS-;toString;SS;3| ((|x| (S)) ($ (|String|)))
        (SPADCALL |x| (QREFELT $ 17))) 

(SDEFUN |FPS-;toString;SNniS;4|
        ((|x| (S)) (|n| (|NonNegativeInteger|)) ($ (|String|)))
        (SPROG
         ((|res| (|List| (|String|))) (|x2| (S)) (|tenn| (S)) (|x0| (S))
          (|x1| (S)))
         (SEQ (LETT |x1| (SPADCALL |x| (QREFELT $ 19)))
              (LETT |x0|
                    (SPADCALL (SPADCALL |x| |x1| (QREFELT $ 20))
                              (QREFELT $ 21)))
              (LETT |tenn| (SPADCALL 1 |n| 10 (QREFELT $ 10)))
              (LETT |x2|
                    (SPADCALL (SPADCALL |tenn| |x0| (QREFELT $ 22))
                              (QREFELT $ 19)))
              (LETT |res|
                    (LIST (STRINGIMAGE (SPADCALL |x1| (QREFELT $ 23))) "."
                          (STRINGIMAGE (SPADCALL |x2| (QREFELT $ 23)))))
              (EXIT (SPADCALL |res| (QREFELT $ 25)))))) 

(DECLAIM (NOTINLINE |FloatingPointSystem&;|)) 

(DEFUN |FloatingPointSystem&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|FloatingPointSystem&| DV$1))
          (LETT $ (GETREFV 28))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|arbitraryExponent|))
                                              (|HasCategory| |#1|
                                                             '(|arbitraryPrecision|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FloatingPointSystem&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|PositiveInteger|)
              (0 . |base|) (|Integer|) (4 . |float|) |FPS-;float;2IS;1|
              (11 . |One|) (15 . |bits|) (19 . |max|) |FPS-;digits;Pi;2|
              (|String|) (23 . |convert|) |FPS-;toString;SS;3| (28 . |round|)
              (33 . -) (39 . |abs|) (44 . *) (50 . |retract|) (|List| $)
              (55 . |concat|) (|NonNegativeInteger|) |FPS-;toString;SNniS;4|)
           '#(|toString| 60 |float| 71 |digits| 77) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|digits|
                                 ((|PositiveInteger|) (|PositiveInteger|)))
                                T)
                              '((|digits| ((|PositiveInteger|))) T)
                              '((|toString|
                                 ((|String|) |#1| (|NonNegativeInteger|)))
                                T)
                              '((|toString| ((|String|) |#1|)) T)
                              '((|float|
                                 (|#1| (|Integer|) (|Integer|)
                                  (|PositiveInteger|)))
                                T)
                              '((|float| (|#1| (|Integer|) (|Integer|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 27
                                            '(0 6 7 8 3 6 0 9 9 7 10 0 6 0 12 0
                                              6 7 13 0 6 0 14 1 6 16 0 17 1 6 0
                                              0 19 2 6 0 0 0 20 1 6 0 0 21 2 6
                                              0 0 0 22 1 6 9 0 23 1 16 0 24 25
                                              2 0 16 0 26 27 1 0 16 0 18 2 0 0
                                              9 9 11 0 0 7 15)))))
           '|lookupComplete|)) 
