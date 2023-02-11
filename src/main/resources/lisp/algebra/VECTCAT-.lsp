
(SDEFUN |VECTCAT-;+;3S;1| ((|u| (S)) (|v| (S)) ($ (S)))
        (COND
         ((SPADCALL (SPADCALL |u| (QREFELT $ 9)) (SPADCALL |v| (QREFELT $ 9))
                    (QREFELT $ 12))
          (|error| "Vectors must be of the same length"))
         ('T (SPADCALL (ELT $ 13) |u| |v| (QREFELT $ 15))))) 

(SDEFUN |VECTCAT-;zero;NniS;2| ((|n| (|NonNegativeInteger|)) ($ (S)))
        (SPADCALL |n| (|spadConstant| $ 17) (QREFELT $ 18))) 

(SDEFUN |VECTCAT-;zero?;SB;3| ((|y| (S)) ($ (|Boolean|)))
        (SPROG ((#1=#:G721 NIL) (#2=#:G722 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ (LETT |i| (SPADCALL |y| (QREFELT $ 20)))
                       (LETT #2# (SPADCALL |y| (QREFELT $ 21))) G190
                       (COND ((> |i| #2#) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL (SPADCALL |y| |i| (QREFELT $ 22))
                                     (|spadConstant| $ 17) (QREFELT $ 23))
                           (PROGN (LETT #1# NIL) (GO #3=#:G720))))))
                       (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                  (EXIT 'T)))
                #3# (EXIT #1#)))) 

(SDEFUN |VECTCAT-;-;2S;4| ((|u| (S)) ($ (S)))
        (SPADCALL (ELT $ 25) |u| (QREFELT $ 27))) 

(SDEFUN |VECTCAT-;*;I2S;5| ((|n| (|Integer|)) (|u| (S)) ($ (S)))
        (SPROG NIL
               (SPADCALL (CONS #'|VECTCAT-;*;I2S;5!0| (VECTOR $ |n|)) |u|
                         (QREFELT $ 27)))) 

(SDEFUN |VECTCAT-;*;I2S;5!0| ((|x| NIL) ($$ NIL))
        (PROG (|n| $)
          (LETT |n| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |n| |x| (QREFELT $ 29)))))) 

(SDEFUN |VECTCAT-;-;3S;6| ((|u| (S)) (|v| (S)) ($ (S)))
        (SPADCALL |u| (SPADCALL |v| (QREFELT $ 31)) (QREFELT $ 32))) 

(SDEFUN |VECTCAT-;*;SRS;7| ((|u| (S)) (|r| (R)) ($ (S)))
        (SPROG NIL
               (SPADCALL (CONS #'|VECTCAT-;*;SRS;7!0| (VECTOR $ |r|)) |u|
                         (QREFELT $ 27)))) 

(SDEFUN |VECTCAT-;*;SRS;7!0| ((|x| NIL) ($$ NIL))
        (PROG (|r| $)
          (LETT |r| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |r| (QREFELT $ 34)))))) 

(SDEFUN |VECTCAT-;*;R2S;8| ((|r| (R)) (|u| (S)) ($ (S)))
        (SPROG NIL
               (SPADCALL (CONS #'|VECTCAT-;*;R2S;8!0| (VECTOR $ |r|)) |u|
                         (QREFELT $ 27)))) 

(SDEFUN |VECTCAT-;*;R2S;8!0| ((|x| NIL) ($$ NIL))
        (PROG (|r| $)
          (LETT |r| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |r| |x| (QREFELT $ 34)))))) 

(SDEFUN |VECTCAT-;dot;2SR;9| ((|u| (S)) (|v| (S)) ($ (R)))
        (SPROG
         ((#1=#:G732 NIL) (#2=#:G731 (R)) (#3=#:G733 (R)) (#4=#:G736 NIL)
          (|i| NIL))
         (SEQ
          (COND
           ((SPADCALL (SPADCALL |u| (QREFELT $ 9)) (SPADCALL |v| (QREFELT $ 9))
                      (QREFELT $ 12))
            (|error| "Vectors must be of the same length"))
           (#5='T
            (PROGN
             (LETT #1# NIL)
             (SEQ (LETT |i| (SPADCALL |u| (QREFELT $ 20)))
                  (LETT #4# (SPADCALL |u| (QREFELT $ 21))) G190
                  (COND ((> |i| #4#) (GO G191)))
                  (SEQ
                   (EXIT
                    (PROGN
                     (LETT #3#
                           (SPADCALL (SPADCALL |u| |i| (QREFELT $ 22))
                                     (SPADCALL |v| |i| (QREFELT $ 22))
                                     (QREFELT $ 34)))
                     (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 13))))
                           ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                  (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
             (COND (#1# #2#) (#5# (|spadConstant| $ 17))))))))) 

(SDEFUN |VECTCAT-;outerProduct;2SM;10| ((|u| (S)) (|v| (S)) ($ (|Matrix| R)))
        (SPROG
         ((#1=#:G751 NIL) (|i| NIL) (#2=#:G750 NIL) (#3=#:G749 NIL) (|j| NIL)
          (#4=#:G748 NIL))
         (SEQ
          (SPADCALL
           (PROGN
            (LETT #4# NIL)
            (SEQ (LETT |j| (SPADCALL |v| (QREFELT $ 20)))
                 (LETT #3# (SPADCALL |v| (QREFELT $ 21))) G190
                 (COND ((> |j| #3#) (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #4#
                         (CONS
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |i| (SPADCALL |u| (QREFELT $ 20)))
                                (LETT #1# (SPADCALL |u| (QREFELT $ 21))) G190
                                (COND ((> |i| #1#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS
                                         (SPADCALL
                                          (SPADCALL |u| |i| (QREFELT $ 22))
                                          (SPADCALL |v| |j| (QREFELT $ 22))
                                          (QREFELT $ 34))
                                         #2#))))
                                (LETT |i| (+ |i| 1)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          #4#))))
                 (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT (NREVERSE #4#))))
           (QREFELT $ 40))))) 

(SDEFUN |VECTCAT-;cross;3S;11| ((|u| (S)) (|v| (S)) ($ (S)))
        (COND
         ((OR (SPADCALL (SPADCALL |u| (QREFELT $ 9)) 3 (QREFELT $ 12))
              (SPADCALL (SPADCALL |v| (QREFELT $ 9)) 3 (QREFELT $ 12)))
          (|error| "Vectors must be of length 3"))
         ('T
          (SPADCALL
           (LIST
            (SPADCALL
             (SPADCALL (SPADCALL |u| 2 (QREFELT $ 22))
                       (SPADCALL |v| 3 (QREFELT $ 22)) (QREFELT $ 34))
             (SPADCALL (SPADCALL |u| 3 (QREFELT $ 22))
                       (SPADCALL |v| 2 (QREFELT $ 22)) (QREFELT $ 34))
             (QREFELT $ 42))
            (SPADCALL
             (SPADCALL (SPADCALL |u| 3 (QREFELT $ 22))
                       (SPADCALL |v| 1 (QREFELT $ 22)) (QREFELT $ 34))
             (SPADCALL (SPADCALL |u| 1 (QREFELT $ 22))
                       (SPADCALL |v| 3 (QREFELT $ 22)) (QREFELT $ 34))
             (QREFELT $ 42))
            (SPADCALL
             (SPADCALL (SPADCALL |u| 1 (QREFELT $ 22))
                       (SPADCALL |v| 2 (QREFELT $ 22)) (QREFELT $ 34))
             (SPADCALL (SPADCALL |u| 2 (QREFELT $ 22))
                       (SPADCALL |v| 1 (QREFELT $ 22)) (QREFELT $ 34))
             (QREFELT $ 42)))
           (QREFELT $ 44))))) 

(SDEFUN |VECTCAT-;length;SR;12| ((|p| (S)) ($ (R)))
        (SPADCALL (SPADCALL |p| |p| (QREFELT $ 46)) (QREFELT $ 47))) 

(DECLAIM (NOTINLINE |VectorCategory&;|)) 

(DEFUN |VectorCategory&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|VectorCategory&| DV$1 DV$2))
          (LETT $ (GETREFV 49))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|RadicalCategory|))
                                              (|HasCategory| |#2| '(|Ring|))
                                              (|HasCategory| |#2| '(|SemiRng|))
                                              (|HasCategory| |#2|
                                                             '(|SemiGroup|))
                                              (|HasCategory| |#2|
                                                             '(|AbelianGroup|))
                                              (|HasCategory| |#2|
                                                             '(|AbelianMonoid|))
                                              (|HasCategory| |#2|
                                                             '(|AbelianSemiGroup|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 7)
            (QSETREFV $ 16 (CONS (|dispatchFunction| |VECTCAT-;+;3S;1|) $))))
          (COND
           ((|testBitVector| |pv$| 6)
            (PROGN
             (QSETREFV $ 19
                       (CONS (|dispatchFunction| |VECTCAT-;zero;NniS;2|) $))
             (QSETREFV $ 24
                       (CONS (|dispatchFunction| |VECTCAT-;zero?;SB;3|) $)))))
          (COND
           ((|testBitVector| |pv$| 5)
            (PROGN
             (QSETREFV $ 28 (CONS (|dispatchFunction| |VECTCAT-;-;2S;4|) $))
             (QSETREFV $ 30 (CONS (|dispatchFunction| |VECTCAT-;*;I2S;5|) $))
             (QSETREFV $ 33 (CONS (|dispatchFunction| |VECTCAT-;-;3S;6|) $)))))
          (COND
           ((|testBitVector| |pv$| 4)
            (PROGN
             (QSETREFV $ 35 (CONS (|dispatchFunction| |VECTCAT-;*;SRS;7|) $))
             (QSETREFV $ 36
                       (CONS (|dispatchFunction| |VECTCAT-;*;R2S;8|) $)))))
          (COND
           ((|testBitVector| |pv$| 6)
            (COND
             ((|testBitVector| |pv$| 3)
              (QSETREFV $ 37
                        (CONS (|dispatchFunction| |VECTCAT-;dot;2SR;9|) $))))))
          (COND
           ((|testBitVector| |pv$| 2)
            (PROGN
             (QSETREFV $ 41
                       (CONS
                        (|dispatchFunction| |VECTCAT-;outerProduct;2SM;10|) $))
             (QSETREFV $ 45
                       (CONS (|dispatchFunction| |VECTCAT-;cross;3S;11|) $)))))
          (COND
           ((|testBitVector| |pv$| 1)
            (COND
             ((|testBitVector| |pv$| 2)
              (QSETREFV $ 48
                        (CONS (|dispatchFunction| |VECTCAT-;length;SR;12|)
                              $))))))
          $))) 

(MAKEPROP '|VectorCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|NonNegativeInteger|) (0 . |#|) (|Boolean|) (|Integer|) (5 . ~=)
              (11 . +) (|Mapping| 7 7 7) (17 . |map|) (24 . +) (30 . |Zero|)
              (34 . |new|) (40 . |zero|) (45 . |minIndex|) (50 . |maxIndex|)
              (55 . |qelt|) (61 . ~=) (67 . |zero?|) (72 . -) (|Mapping| 7 7)
              (77 . |map|) (83 . -) (88 . *) (94 . *) (100 . -) (105 . +)
              (111 . -) (117 . *) (123 . *) (129 . *) (135 . |dot|) (|List| 43)
              (|Matrix| 7) (141 . |matrix|) (146 . |outerProduct|) (152 . -)
              (|List| 7) (158 . |construct|) (163 . |cross|) (169 . |dot|)
              (175 . |sqrt|) (180 . |length|))
           '#(|zero?| 185 |zero| 190 |outerProduct| 195 |length| 201 |dot| 206
              |cross| 212 - 218 + 229 * 235)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|length| (|#2| |#1|)) T)
                                   '((|cross| (|#1| |#1| |#1|)) T)
                                   '((|outerProduct|
                                      ((|Matrix| |#2|) |#1| |#1|))
                                     T)
                                   '((|dot| (|#2| |#1| |#1|)) T)
                                   '((* (|#1| |#1| |#2|)) T)
                                   '((* (|#1| |#2| |#1|)) T)
                                   '((* (|#1| (|Integer|) |#1|)) T)
                                   '((- (|#1| |#1| |#1|)) T)
                                   '((- (|#1| |#1|)) T)
                                   '((|zero?| ((|Boolean|) |#1|)) T)
                                   '((|zero| (|#1| (|NonNegativeInteger|))) T)
                                   '((+ (|#1| |#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 48
                                            '(1 6 8 0 9 2 11 10 0 0 12 2 7 0 0
                                              0 13 3 6 0 14 0 0 15 2 0 0 0 0 16
                                              0 7 0 17 2 6 0 8 7 18 1 0 0 8 19
                                              1 6 11 0 20 1 6 11 0 21 2 6 7 0
                                              11 22 2 7 10 0 0 23 1 0 10 0 24 1
                                              7 0 0 25 2 6 0 26 0 27 1 0 0 0 28
                                              2 7 0 11 0 29 2 0 0 11 0 30 1 6 0
                                              0 31 2 6 0 0 0 32 2 0 0 0 0 33 2
                                              7 0 0 0 34 2 0 0 0 7 35 2 0 0 7 0
                                              36 2 0 7 0 0 37 1 39 0 38 40 2 0
                                              39 0 0 41 2 7 0 0 0 42 1 6 0 43
                                              44 2 0 0 0 0 45 2 6 7 0 0 46 1 7
                                              0 0 47 1 0 7 0 48 1 0 10 0 24 1 0
                                              0 8 19 2 0 39 0 0 41 1 0 7 0 48 2
                                              0 7 0 0 37 2 0 0 0 0 45 1 0 0 0
                                              28 2 0 0 0 0 33 2 0 0 0 0 16 2 0
                                              0 7 0 36 2 0 0 0 7 35 2 0 0 11 0
                                              30)))))
           '|lookupComplete|)) 
