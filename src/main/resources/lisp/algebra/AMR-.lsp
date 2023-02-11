
(SDEFUN |AMR-;monomial?;SB;1| ((|x| (S)) ($ (|Boolean|)))
        (COND ((SPADCALL |x| (QREFELT $ 10)) NIL)
              ('T (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 10))))) 

(SDEFUN |AMR-;map;M2S;2| ((|fn| (|Mapping| R R)) (|x| (S)) ($ (S)))
        (SPROG ((|r| (R)))
               (SEQ
                (COND ((SPADCALL |x| (QREFELT $ 10)) (|spadConstant| $ 13))
                      (#1='T
                       (SEQ
                        (LETT |r|
                              (SPADCALL (SPADCALL |x| (QREFELT $ 14)) |fn|))
                        (EXIT
                         (COND
                          ((SPADCALL |r| (QREFELT $ 15))
                           (SPADCALL |fn| (SPADCALL |x| (QREFELT $ 11))
                                     (QREFELT $ 17)))
                          (#1#
                           (SPADCALL
                            (SPADCALL |r| (SPADCALL |x| (QREFELT $ 18))
                                      (QREFELT $ 19))
                            (SPADCALL |fn| (SPADCALL |x| (QREFELT $ 11))
                                      (QREFELT $ 17))
                            (QREFELT $ 20))))))))))) 

(SDEFUN |AMR-;*;F2S;3| ((|q| (|Fraction| (|Integer|))) (|p| (S)) ($ (S)))
        (SPROG NIL
               (SPADCALL (CONS #'|AMR-;*;F2S;3!0| (VECTOR $ |q|)) |p|
                         (QREFELT $ 17)))) 

(SDEFUN |AMR-;*;F2S;3!0| ((|x1| NIL) ($$ NIL))
        (PROG (|q| $)
          (LETT |q| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |q| |x1| (QREFELT $ 23)))))) 

(DECLAIM (NOTINLINE |AbelianMonoidRing&;|)) 

(DEFUN |AbelianMonoidRing&| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|AbelianMonoidRing&| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 28))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|Algebra|
                                                               (|Fraction|
                                                                (|Integer|))))
                                              (|HasCategory| |#2|
                                                             '(|IntegralDomain|))
                                              (|HasCategory| |#2|
                                                             '(|CharacteristicNonZero|))
                                              (|HasCategory| |#2|
                                                             '(|CharacteristicZero|))
                                              (|HasCategory| |#2|
                                                             '(|CommutativeRing|))
                                              (|HasCategory| |#1|
                                                             '(|VariablesCommuteWithCoefficients|))
                                              (|HasCategory| |#2| '(|Field|))
                                              (|HasCategory| |#2| '(|Ring|))
                                              (|HasCategory| |#2|
                                                             '(|SemiRing|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 1)
            (QSETREFV $ 24 (CONS (|dispatchFunction| |AMR-;*;F2S;3|) $))))
          $))) 

(MAKEPROP '|AbelianMonoidRing&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Boolean|) (0 . |zero?|) (5 . |reductum|)
              |AMR-;monomial?;SB;1| (10 . |Zero|) (14 . |leadingCoefficient|)
              (19 . |zero?|) (|Mapping| 7 7) (24 . |map|) (30 . |degree|)
              (35 . |monomial|) (41 . +) |AMR-;map;M2S;2| (|Fraction| 25)
              (47 . *) (53 . *) (|Integer|) (|NonNegativeInteger|)
              (|PositiveInteger|))
           '#(|monomial?| 59 |map| 64 * 70) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((* (|#1| (|NonNegativeInteger|) |#1|)) T)
                                   '((* (|#1| (|Integer|) |#1|)) T)
                                   '((* (|#1| |#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((* (|#1| (|Fraction| (|Integer|)) |#1|))
                                     T)
                                   '((|map| (|#1| (|Mapping| |#2| |#2|) |#1|))
                                     T)
                                   '((|monomial?| ((|Boolean|) |#1|)) T)
                                   '((* (|#1| |#2| |#1|)) T)
                                   '((* (|#1| |#1| |#2|)) T)
                                   '((* (|#1| |#1| |#1|)) T)
                                   '((* (|#1| (|PositiveInteger|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 24
                                            '(1 6 9 0 10 1 6 0 0 11 0 6 0 13 1
                                              6 7 0 14 1 7 9 0 15 2 6 0 16 0 17
                                              1 6 8 0 18 2 6 0 7 8 19 2 6 0 0 0
                                              20 2 7 0 22 0 23 2 0 0 22 0 24 1
                                              0 9 0 12 2 0 0 16 0 21 2 0 0 22 0
                                              24)))))
           '|lookupComplete|)) 
