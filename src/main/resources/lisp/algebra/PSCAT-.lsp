
(SDEFUN |PSCAT-;*;I2S;1| ((|n| (|Integer|)) (|ps| (S)) ($ (S)))
        (SPROG NIL
               (COND ((ZEROP |n|) (|spadConstant| $ 10))
                     ('T
                      (SPADCALL (CONS #'|PSCAT-;*;I2S;1!0| (VECTOR $ |n|)) |ps|
                                (QREFELT $ 14)))))) 

(SDEFUN |PSCAT-;*;I2S;1!0| ((|r1| NIL) ($$ NIL))
        (PROG (|n| $)
          (LETT |n| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |n| |r1| (QREFELT $ 12)))))) 

(SDEFUN |PSCAT-;*;Coef2S;2| ((|r| (|Coef|)) (|ps| (S)) ($ (S)))
        (SPROG NIL
               (COND ((SPADCALL |r| (QREFELT $ 17)) (|spadConstant| $ 10))
                     ('T
                      (SPADCALL (CONS #'|PSCAT-;*;Coef2S;2!0| (VECTOR $ |r|))
                                |ps| (QREFELT $ 14)))))) 

(SDEFUN |PSCAT-;*;Coef2S;2!0| ((|r1| NIL) ($$ NIL))
        (PROG (|r| $)
          (LETT |r| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |r| |r1| (QREFELT $ 18)))))) 

(SDEFUN |PSCAT-;*;SCoefS;3| ((|ps| (S)) (|r| (|Coef|)) ($ (S)))
        (SPROG NIL
               (COND ((SPADCALL |r| (QREFELT $ 17)) (|spadConstant| $ 10))
                     ('T
                      (SPADCALL (CONS #'|PSCAT-;*;SCoefS;3!0| (VECTOR $ |r|))
                                |ps| (QREFELT $ 14)))))) 

(SDEFUN |PSCAT-;*;SCoefS;3!0| ((|r1| NIL) ($$ NIL))
        (PROG (|r| $)
          (LETT |r| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |r1| |r| (QREFELT $ 18)))))) 

(SDEFUN |PSCAT-;-;2S;4| ((|ps| (S)) ($ (S)))
        (SPADCALL (ELT $ 21) |ps| (QREFELT $ 14))) 

(SDEFUN |PSCAT-;*;F2S;5| ((|r| (|Fraction| (|Integer|))) (|ps| (S)) ($ (S)))
        (SPROG NIL
               (COND ((SPADCALL |r| (QREFELT $ 24)) (|spadConstant| $ 10))
                     ('T
                      (SPADCALL (CONS #'|PSCAT-;*;F2S;5!0| (VECTOR $ |r|)) |ps|
                                (QREFELT $ 14)))))) 

(SDEFUN |PSCAT-;*;F2S;5!0| ((|r1| NIL) ($$ NIL))
        (PROG (|r| $)
          (LETT |r| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |r| |r1| (QREFELT $ 25)))))) 

(SDEFUN |PSCAT-;*;SFS;6| ((|ps| (S)) (|r| (|Fraction| (|Integer|))) ($ (S)))
        (SPROG NIL
               (COND ((SPADCALL |r| (QREFELT $ 24)) (|spadConstant| $ 10))
                     ('T
                      (SPADCALL (CONS #'|PSCAT-;*;SFS;6!0| (VECTOR $ |r|)) |ps|
                                (QREFELT $ 14)))))) 

(SDEFUN |PSCAT-;*;SFS;6!0| ((|r1| NIL) ($$ NIL))
        (PROG (|r| $)
          (LETT |r| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |r1| |r| (QREFELT $ 27)))))) 

(SDEFUN |PSCAT-;/;SCoefS;7| ((|ps| (S)) (|r| (|Coef|)) ($ (S)))
        (SPROG NIL
               (SPADCALL (CONS #'|PSCAT-;/;SCoefS;7!0| (VECTOR $ |r|)) |ps|
                         (QREFELT $ 14)))) 

(SDEFUN |PSCAT-;/;SCoefS;7!0| ((|r1| NIL) ($$ NIL))
        (PROG (|r| $)
          (LETT |r| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |r1| |r| (QREFELT $ 29)))))) 

(DECLAIM (NOTINLINE |PowerSeriesCategory&;|)) 

(DEFUN |PowerSeriesCategory&| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|PowerSeriesCategory&| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 33))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|HasCategory| |#2| '(|Algebra| (|Fraction| (|Integer|))))
      (PROGN
       (QSETREFV $ 26 (CONS (|dispatchFunction| |PSCAT-;*;F2S;5|) $))
       (QSETREFV $ 28 (CONS (|dispatchFunction| |PSCAT-;*;SFS;6|) $)))))
    (COND
     ((|HasCategory| |#2| '(|Field|))
      (QSETREFV $ 30 (CONS (|dispatchFunction| |PSCAT-;/;SCoefS;7|) $))))
    $))) 

(MAKEPROP '|PowerSeriesCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (0 . |Zero|) (|Integer|) (4 . *)
              (|Mapping| 7 7) (10 . |map|) |PSCAT-;*;I2S;1| (|Boolean|)
              (16 . |zero?|) (21 . *) |PSCAT-;*;Coef2S;2| |PSCAT-;*;SCoefS;3|
              (27 . -) |PSCAT-;-;2S;4| (|Fraction| 11) (32 . |zero?|) (37 . *)
              (43 . *) (49 . *) (55 . *) (61 . /) (67 . /)
              (|NonNegativeInteger|) (|PositiveInteger|))
           '#(/ 73 - 79 * 84) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((* (|#1| (|NonNegativeInteger|) |#1|)) T)
                                   '((- (|#1| |#1|)) T)
                                   '((- (|#1| |#1| |#1|)) T)
                                   '((* (|#1| (|Integer|) |#1|)) T)
                                   '((* (|#1| |#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((* (|#1| (|Fraction| (|Integer|)) |#1|))
                                     T)
                                   '((/ (|#1| |#1| |#2|)) T)
                                   '((* (|#1| |#2| |#1|)) T)
                                   '((* (|#1| |#1| |#2|)) T)
                                   '((* (|#1| |#1| |#1|)) T)
                                   '((* (|#1| (|PositiveInteger|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 30
                                            '(0 6 0 10 2 7 0 11 0 12 2 6 0 13 0
                                              14 1 7 16 0 17 2 7 0 0 0 18 1 7 0
                                              0 21 1 23 16 0 24 2 7 0 23 0 25 2
                                              0 0 23 0 26 2 7 0 0 23 27 2 0 0 0
                                              23 28 2 7 0 0 0 29 2 0 0 0 7 30 2
                                              0 0 0 7 30 1 0 0 0 22 2 0 0 0 23
                                              28 2 0 0 11 0 15 2 0 0 23 0 26 2
                                              0 0 7 0 19 2 0 0 0 7 20)))))
           '|lookupComplete|)) 
