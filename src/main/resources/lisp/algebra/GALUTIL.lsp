
(SDEFUN |GALUTIL;safeFloor;RI;1| ((|x| (R)) ($ (|Integer|)))
        (SPROG ((|shift| (|Integer|)))
               (SEQ
                (SEQ
                 (LETT |shift|
                       (+
                        (- (SPADCALL |x| (QREFELT $ 9))
                           (SPADCALL (QREFELT $ 11)))
                        (QREFELT $ 7)))
                 (EXIT
                  (COND
                   ((>= |shift| 0)
                    (LETT |x|
                          (SPADCALL |x| (SPADCALL 1 |shift| (QREFELT $ 14))
                                    (QREFELT $ 15)))))))
                (EXIT
                 (SPADCALL (SPADCALL |x| (QREFELT $ 16)) (QREFELT $ 17)))))) 

(SDEFUN |GALUTIL;safeCeiling;RI;2| ((|x| (R)) ($ (|Integer|)))
        (SPROG ((|shift| (|Integer|)))
               (SEQ
                (SEQ
                 (LETT |shift|
                       (+
                        (- (SPADCALL |x| (QREFELT $ 9))
                           (SPADCALL (QREFELT $ 11)))
                        (QREFELT $ 7)))
                 (EXIT
                  (COND
                   ((>= |shift| 0)
                    (LETT |x|
                          (SPADCALL |x| (SPADCALL 1 |shift| (QREFELT $ 14))
                                    (QREFELT $ 15)))))))
                (EXIT
                 (SPADCALL (SPADCALL |x| (QREFELT $ 19)) (QREFELT $ 17)))))) 

(SDEFUN |GALUTIL;safetyMargin;2Nni;3|
        ((|n| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|)))
        (SPROG ((|#G7| (|NonNegativeInteger|)) (|#G6| (|NonNegativeInteger|)))
               (SEQ
                (PROGN
                 (LETT |#G6| |n|)
                 (LETT |#G7| (QREFELT $ 7))
                 (SETELT $ 7 |#G6|)
                 (LETT |n| |#G7|))
                (EXIT |n|)))) 

(SDEFUN |GALUTIL;safetyMargin;Nni;4| (($ (|NonNegativeInteger|))) (QREFELT $ 7)) 

(SDEFUN |GALUTIL;pascalTriangle;NniIR;5|
        ((|n| (|NonNegativeInteger|)) (|r| (|Integer|)) ($ (R)))
        (SPROG
         ((#1=#:G712 NIL) (#2=#:G711 NIL) (#3=#:G722 NIL) (|j| NIL)
          (#4=#:G721 NIL) (|i| NIL) (|mq| #5=(|Integer|))
          (|m| (|Record| (|:| |quotient| #5#) (|:| |remainder| (|Integer|))))
          (|d| (|Integer|)))
         (SEQ
          (COND ((MINUSP |r|) (|spadConstant| $ 12))
                (#6='T
                 (SEQ (LETT |d| (- |n| |r|))
                      (EXIT
                       (COND ((< |d| |r|) (SPADCALL |n| |d| (QREFELT $ 29)))
                             ((ZEROP |r|) (|spadConstant| $ 13))
                             ((EQL |r| 1) (SPADCALL |n| (QREFELT $ 30)))
                             ((> |n| (QREFELT $ 28))
                              (SPADCALL (SPADCALL |n| |r| (QREFELT $ 32))
                                        (QREFELT $ 30)))
                             ((<= |n| (QREFELT $ 27))
                              (SEQ (LETT |m| (DIVIDE2 (- |n| 4) 2))
                                   (LETT |mq| (QCAR |m|))
                                   (EXIT
                                    (SPADCALL (QREFELT $ 26)
                                              (-
                                               (+
                                                (* (+ |mq| 1)
                                                   (+ |mq| (QCDR |m|)))
                                                |r|)
                                               1)
                                              (QREFELT $ 33)))))
                             (#6#
                              (SEQ
                               (SEQ (LETT |i| (+ (QREFELT $ 27) 1))
                                    (LETT #4# |n|) G190
                                    (COND ((> |i| #4#) (GO G191)))
                                    (SEQ
                                     (SEQ (LETT |j| 2)
                                          (LETT #3# (QUOTIENT2 |i| 2)) G190
                                          (COND
                                           ((|greater_SI| |j| #3#) (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (SETELT $ 26
                                                    (SPADCALL (QREFELT $ 26)
                                                              (SPADCALL
                                                               (SPADCALL
                                                                (PROG1
                                                                    (LETT #2#
                                                                          (-
                                                                           |i|
                                                                           1))
                                                                  (|check_subtype2|
                                                                   (>= #2# 0)
                                                                   '(|NonNegativeInteger|)
                                                                   '(|Integer|)
                                                                   #2#))
                                                                (- |j| 1)
                                                                (QREFELT $ 29))
                                                               (SPADCALL
                                                                (PROG1
                                                                    (LETT #1#
                                                                          (-
                                                                           |i|
                                                                           1))
                                                                  (|check_subtype2|
                                                                   (>= #1# 0)
                                                                   '(|NonNegativeInteger|)
                                                                   '(|Integer|)
                                                                   #1#))
                                                                |j|
                                                                (QREFELT $ 29))
                                                               (QREFELT $ 15))
                                                              (QREFELT $
                                                                       34)))))
                                          (LETT |j| (|inc_SI| |j|)) (GO G190)
                                          G191 (EXIT NIL))
                                     (EXIT (SETELT $ 27 |i|)))
                                    (LETT |i| (+ |i| 1)) (GO G190) G191
                                    (EXIT NIL))
                               (EXIT
                                (SPADCALL |n| |r| (QREFELT $ 29))))))))))))) 

(SDEFUN |GALUTIL;rangePascalTriangle;2Nni;6|
        ((|n| (|NonNegativeInteger|)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|#G18| (|NonNegativeInteger|)) (|#G17| (|NonNegativeInteger|))
          (|dq| #1=(|Integer|))
          (|d| (|Record| (|:| |quotient| #1#) (|:| |remainder| (|Integer|)))))
         (SEQ
          (COND
           ((< |n| (QREFELT $ 27))
            (COND
             ((< |n| 3)
              (SEQ
               (SETELT $ 26
                       (SPADCALL (QREFELT $ 26)
                                 (SPADCALL 1
                                           (SPADCALL (QREFELT $ 26)
                                                     (QREFELT $ 35))
                                           (QREFELT $ 37))
                                 (QREFELT $ 38)))
               (EXIT (SETELT $ 27 3))))
             ('T
              (SEQ (LETT |d| (DIVIDE2 (- |n| 3) 2)) (LETT |dq| (QCAR |d|))
                   (SETELT $ 26
                           (SPADCALL (QREFELT $ 26)
                                     (SPADCALL
                                      (+ (* (+ |dq| 1) (+ |dq| (QCDR |d|))) 1)
                                      (SPADCALL (QREFELT $ 26) (QREFELT $ 35))
                                      (QREFELT $ 37))
                                     (QREFELT $ 38)))
                   (EXIT (SETELT $ 27 |n|)))))))
          (PROGN
           (LETT |#G17| |n|)
           (LETT |#G18| (QREFELT $ 28))
           (SETELT $ 28 |#G17|)
           (LETT |n| |#G18|))
          (EXIT |n|)))) 

(SDEFUN |GALUTIL;rangePascalTriangle;Nni;7| (($ (|NonNegativeInteger|)))
        (QREFELT $ 28)) 

(SDEFUN |GALUTIL;sizePascalTriangle;Nni;8| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 26) (QREFELT $ 35))) 

(SDEFUN |GALUTIL;fillPascalTriangle;V;9| (($ (|Void|)))
        (SPADCALL (QREFELT $ 28) 2 (QREFELT $ 29))) 

(DECLAIM (NOTINLINE |GaloisGroupUtilities;|)) 

(DEFUN |GaloisGroupUtilities| (#1=#:G731)
  (SPROG NIL
         (PROG (#2=#:G732)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|GaloisGroupUtilities|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|GaloisGroupUtilities;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|GaloisGroupUtilities|)))))))))) 

(DEFUN |GaloisGroupUtilities;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|GaloisGroupUtilities| DV$1))
          (LETT $ (GETREFV 44))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|FloatingPointSystem|))))))
          (|haddProp| |$ConstructorCache| '|GaloisGroupUtilities| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 7 6)
             (QSETREFV $ 18
                       (CONS (|dispatchFunction| |GALUTIL;safeFloor;RI;1|) $))
             (QSETREFV $ 20
                       (CONS (|dispatchFunction| |GALUTIL;safeCeiling;RI;2|)
                             $))
             (QSETREFV $ 22
                       (CONS (|dispatchFunction| |GALUTIL;safetyMargin;2Nni;3|)
                             $))
             (QSETREFV $ 23
                       (CONS (|dispatchFunction| |GALUTIL;safetyMargin;Nni;4|)
                             $)))))
          (QSETREFV $ 26 (SPADCALL (QREFELT $ 25)))
          (QSETREFV $ 27 3)
          (QSETREFV $ 28 216)
          $))) 

(MAKEPROP '|GaloisGroupUtilities| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|safetymargin|
              (|Integer|) (0 . |order|) (|PositiveInteger|) (5 . |precision|)
              (9 . |Zero|) (13 . |One|) (17 . |float|) (23 . +) (29 . |floor|)
              (34 . |retract|) (39 . |safeFloor|) (44 . |ceiling|)
              (49 . |safeCeiling|) (|NonNegativeInteger|) (54 . |safetyMargin|)
              (59 . |safetyMargin|) (|FlexibleArray| 6) (63 . |empty|)
              '|pascaltriangle| '|ncomputed| '|rangepascaltriangle|
              |GALUTIL;pascalTriangle;NniIR;5| (67 . |coerce|)
              (|IntegerCombinatoricFunctions| 8) (72 . |binomial|) (78 . |elt|)
              (84 . |concat!|) (90 . |#|) (|UniversalSegment| 8) (95 . SEGMENT)
              (101 . |delete!|) |GALUTIL;rangePascalTriangle;2Nni;6|
              |GALUTIL;rangePascalTriangle;Nni;7|
              |GALUTIL;sizePascalTriangle;Nni;8| (|Void|)
              |GALUTIL;fillPascalTriangle;V;9|)
           '#(|sizePascalTriangle| 107 |safetyMargin| 111 |safeFloor| 120
              |safeCeiling| 125 |rangePascalTriangle| 130 |pascalTriangle| 139
              |fillPascalTriangle| 145)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|pascalTriangle|
                                 (|#1| (|NonNegativeInteger|) (|Integer|)))
                                T)
                              '((|rangePascalTriangle|
                                 ((|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|rangePascalTriangle|
                                 ((|NonNegativeInteger|)))
                                T)
                              '((|sizePascalTriangle| ((|NonNegativeInteger|)))
                                T)
                              '((|fillPascalTriangle| ((|Void|))) T)
                              '((|safeCeiling| ((|Integer|) |#1|))
                                (|has| 6 (|FloatingPointSystem|)))
                              '((|safeFloor| ((|Integer|) |#1|))
                                (|has| 6 (|FloatingPointSystem|)))
                              '((|safetyMargin|
                                 ((|NonNegativeInteger|)
                                  (|NonNegativeInteger|)))
                                (|has| 6 (|FloatingPointSystem|)))
                              '((|safetyMargin| ((|NonNegativeInteger|)))
                                (|has| 6 (|FloatingPointSystem|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 43
                                            '(1 6 8 0 9 0 6 10 11 0 6 0 12 0 6
                                              0 13 2 6 0 8 8 14 2 6 0 0 0 15 1
                                              6 0 0 16 1 6 8 0 17 1 0 8 6 18 1
                                              6 0 0 19 1 0 8 6 20 1 0 21 21 22
                                              0 0 21 23 0 24 0 25 1 6 0 8 30 2
                                              31 8 8 8 32 2 24 6 0 8 33 2 24 0
                                              0 6 34 1 24 21 0 35 2 36 0 8 8 37
                                              2 24 0 0 36 38 0 0 21 41 0 1 21
                                              23 1 1 21 21 22 1 1 8 6 18 1 1 8
                                              6 20 1 0 21 21 39 0 0 21 40 2 0 6
                                              21 8 29 0 0 42 43)))))
           '|lookupComplete|)) 
