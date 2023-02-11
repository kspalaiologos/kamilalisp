
(SDEFUN |SMATCAT-;positivePower| ((|x| (S)) (|n| (|Integer|)) ($ (S)))
        (SPROG ((|y| (S)))
               (SEQ
                (COND ((EQL |n| 1) |x|)
                      ((ODDP |n|)
                       (SPADCALL |x| (|SMATCAT-;positivePower| |x| (- |n| 1) $)
                                 (QREFELT $ 11)))
                      ('T
                       (SEQ
                        (LETT |y|
                              (|SMATCAT-;positivePower| |x| (QUOTIENT2 |n| 2)
                               $))
                        (EXIT (SPADCALL |y| |y| (QREFELT $ 11))))))))) 

(SDEFUN |SMATCAT-;^;SNniS;2| ((|x| (S)) (|n| (|NonNegativeInteger|)) ($ (S)))
        (COND ((ZEROP |n|) (SPADCALL (|spadConstant| $ 12) (QREFELT $ 13)))
              ('T (|SMATCAT-;positivePower| |x| |n| $)))) 

(SDEFUN |SMATCAT-;coerce;RS;3| ((|r| (R)) ($ (S)))
        (SPADCALL |r| (QREFELT $ 13))) 

(SDEFUN |SMATCAT-;differentiate;SMS;4|
        ((|x| (S)) (|d| (|Mapping| R R)) ($ (S)))
        (SPADCALL |d| |x| (QREFELT $ 18))) 

(SDEFUN |SMATCAT-;diagonal;SRow;5| ((|x| (S)) ($ (|Row|)))
        (SPROG
         ((#1=#:G727 NIL) (|i| NIL) (#2=#:G728 NIL) (|j| NIL) (#3=#:G729 NIL)
          (|k| NIL) (|v| (|Vector| R)))
         (SEQ (LETT |v| (MAKEARR1 (QREFELT $ 7) (|spadConstant| $ 20)))
              (SEQ (LETT |k| (SPADCALL |v| (QREFELT $ 27)))
                   (LETT #3# (QVSIZE |v|))
                   (LETT |j| (SPADCALL |x| (QREFELT $ 24)))
                   (LETT #2# (SPADCALL |x| (QREFELT $ 25)))
                   (LETT |i| (SPADCALL |x| (QREFELT $ 22)))
                   (LETT #1# (SPADCALL |x| (QREFELT $ 23))) G190
                   (COND ((OR (> |i| #1#) (> |j| #2#) (> |k| #3#)) (GO G191)))
                   (SEQ
                    (EXIT
                     (QSETAREF1O |v| |k| (SPADCALL |x| |i| |j| (QREFELT $ 28))
                                 1)))
                   (LETT |i|
                         (PROG1 (+ |i| 1)
                           (LETT |j| (PROG1 (+ |j| 1) (LETT |k| (+ |k| 1))))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |v| (QREFELT $ 29)))))) 

(SDEFUN |SMATCAT-;retract;SR;6| ((|x| (S)) ($ (R)))
        (COND
         ((SPADCALL |x| (QREFELT $ 32))
          (SPADCALL (SPADCALL |x| (QREFELT $ 33)) (QREFELT $ 34)))
         ('T (|error| "Not retractable")))) 

(SDEFUN |SMATCAT-;retractIfCan;SU;7| ((|x| (S)) ($ (|Union| R "failed")))
        (COND
         ((SPADCALL |x| (QREFELT $ 32))
          (SPADCALL (SPADCALL |x| (QREFELT $ 33)) (QREFELT $ 37)))
         ('T (CONS 1 "failed")))) 

(SDEFUN |SMATCAT-;equation2R| ((|v| (|Vector| S)) ($ (|Matrix| R)))
        (SPROG
         ((#1=#:G745 NIL) (|j| NIL) (#2=#:G744 NIL) (|i| NIL)
          (|ans| (|Matrix| |Col|)))
         (SEQ
          (LETT |ans|
                (MAKE_MATRIX1 (QREFELT $ 7) (QVSIZE |v|)
                              (|spadConstant| $ 39)))
          (SEQ (LETT |i| (PROGN |ans| 1))
               (LETT #2# (SPADCALL |ans| (QREFELT $ 41))) G190
               (COND ((> |i| #2#) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |j| (PROGN |ans| 1))
                      (LETT #1# (SPADCALL |ans| (QREFELT $ 42))) G190
                      (COND ((> |j| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (QSETAREF2O |ans| |i| |j|
                                    (SPADCALL (QAREF1O |v| |j| 1) |i|
                                              (QREFELT $ 43))
                                    1 1)))
                      (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
               (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
          (EXIT (SPADCALL |ans| (QREFELT $ 46)))))) 

(SDEFUN |SMATCAT-;reducedSystem;MM;9| ((|x| (|Matrix| S)) ($ (|Matrix| R)))
        (SPROG ((#1=#:G757 NIL) (|i| NIL) (#2=#:G756 NIL))
               (SEQ
                (COND
                 ((SPADCALL |x| (QREFELT $ 48))
                  (MAKE_MATRIX1
                   (* (* (QREFELT $ 7) (QREFELT $ 7)) (ANROWS |x|))
                   (ANCOLS |x|) (|spadConstant| $ 20)))
                 ('T
                  (SPADCALL (ELT $ 49)
                            (PROGN
                             (LETT #2# NIL)
                             (SEQ (LETT |i| (PROGN |x| 1))
                                  (LETT #1# (SPADCALL |x| (QREFELT $ 50))) G190
                                  (COND ((> |i| #1#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #2#
                                          (CONS
                                           (|SMATCAT-;equation2R|
                                            (SPADCALL |x| |i| (QREFELT $ 52))
                                            $)
                                           #2#))))
                                  (LETT |i| (+ |i| 1)) (GO G190) G191
                                  (EXIT (NREVERSE #2#))))
                            (QREFELT $ 55))))))) 

(SDEFUN |SMATCAT-;reducedSystem;MVR;10|
        ((|m| (|Matrix| S)) (|v| (|Vector| S))
         ($ (|Record| (|:| |mat| (|Matrix| R)) (|:| |vec| (|Vector| R)))))
        (SPROG ((|vh| (|Vector| R)) (|rh| (|Matrix| R)))
               (SEQ
                (LETT |vh|
                      (COND
                       ((SPADCALL |v| (QREFELT $ 57))
                        (MAKEARR1 0 (|spadConstant| $ 20)))
                       ('T
                        (SEQ
                         (LETT |rh|
                               (SPADCALL (SPADCALL |v| (QREFELT $ 58))
                                         (QREFELT $ 59)))
                         (EXIT
                          (SPADCALL |rh| (PROGN |rh| 1) (QREFELT $ 60)))))))
                (EXIT (CONS (SPADCALL |m| (QREFELT $ 59)) |vh|))))) 

(SDEFUN |SMATCAT-;trace;SR;11| ((|x| (S)) ($ (R)))
        (SPROG ((|tr| (R)) (#1=#:G768 NIL) (|i| NIL) (#2=#:G769 NIL) (|j| NIL))
               (SEQ (LETT |tr| (|spadConstant| $ 20))
                    (SEQ (LETT |j| (SPADCALL |x| (QREFELT $ 24)))
                         (LETT #2# (SPADCALL |x| (QREFELT $ 25)))
                         (LETT |i| (SPADCALL |x| (QREFELT $ 22)))
                         (LETT #1# (SPADCALL |x| (QREFELT $ 23))) G190
                         (COND ((OR (> |i| #1#) (> |j| #2#)) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |tr|
                                 (SPADCALL |tr|
                                           (SPADCALL |x| |i| |j|
                                                     (QREFELT $ 64))
                                           (QREFELT $ 65)))))
                         (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1))))
                         (GO G190) G191 (EXIT NIL))
                    (EXIT |tr|)))) 

(SDEFUN |SMATCAT-;diagonalProduct;SR;12| ((|x| (S)) ($ (R)))
        (SPROG ((|pr| (R)) (#1=#:G774 NIL) (|i| NIL) (#2=#:G775 NIL) (|j| NIL))
               (SEQ
                (LETT |pr|
                      (SPADCALL |x| (SPADCALL |x| (QREFELT $ 22))
                                (SPADCALL |x| (QREFELT $ 24)) (QREFELT $ 64)))
                (SEQ (LETT |j| (+ (SPADCALL |x| (QREFELT $ 24)) 1))
                     (LETT #2# (SPADCALL |x| (QREFELT $ 25)))
                     (LETT |i| (+ (SPADCALL |x| (QREFELT $ 22)) 1))
                     (LETT #1# (SPADCALL |x| (QREFELT $ 23))) G190
                     (COND ((OR (> |i| #1#) (> |j| #2#)) (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |pr|
                             (SPADCALL |pr|
                                       (SPADCALL |x| |i| |j| (QREFELT $ 64))
                                       (QREFELT $ 67)))))
                     (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1))))
                     (GO G190) G191 (EXIT NIL))
                (EXIT |pr|)))) 

(SDEFUN |SMATCAT-;^;SIS;13| ((|x| (S)) (|n| (|Integer|)) ($ (S)))
        (SPROG ((|xInv| (|Union| S "failed")))
               (SEQ
                (COND
                 ((ZEROP |n|) (SPADCALL (|spadConstant| $ 12) (QREFELT $ 13)))
                 ((PLUSP |n|) (|SMATCAT-;positivePower| |x| |n| $))
                 (#1='T
                  (SEQ (LETT |xInv| (SPADCALL |x| (QREFELT $ 70)))
                       (EXIT
                        (COND
                         ((QEQCAR |xInv| 1)
                          (|error| "^: matrix must be invertible"))
                         (#1#
                          (|SMATCAT-;positivePower| (QCDR |xInv|) (- |n|)
                           $)))))))))) 

(DECLAIM (NOTINLINE |SquareMatrixCategory&;|)) 

(DEFUN |SquareMatrixCategory&| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 |#2|)
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT |dv$| (LIST '|SquareMatrixCategory&| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 82))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST (|HasCategory| |#3| '(|Field|))
                                             (|HasCategory| |#3|
                                                            '(|CommutativeRing|))
                                             (|HasCategory| |#3| '(|Ring|))
                                             (|HasCategory| |#3|
                                                            '(|SemiRing|))))))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|HasCategory| |#3| '(|Monoid|))
      (QSETREFV $ 15 (CONS (|dispatchFunction| |SMATCAT-;^;SNniS;2|) $))))
    (COND
     ((|testBitVector| |pv$| 3)
      (PROGN
       (QSETREFV $ 56
                 (CONS (|dispatchFunction| |SMATCAT-;reducedSystem;MM;9|) $))
       (QSETREFV $ 63
                 (CONS (|dispatchFunction| |SMATCAT-;reducedSystem;MVR;10|)
                       $)))))
    (COND
     ((|testBitVector| |pv$| 1)
      (QSETREFV $ 71 (CONS (|dispatchFunction| |SMATCAT-;^;SIS;13|) $))))
    $))) 

(MAKEPROP '|SquareMatrixCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (0 . *) (6 . |One|)
              (10 . |scalarMatrix|) (|NonNegativeInteger|) (15 . ^)
              |SMATCAT-;coerce;RS;3| (|Mapping| 8 8) (21 . |map|)
              |SMATCAT-;differentiate;SMS;4| (27 . |Zero|) (|Integer|)
              (31 . |minRowIndex|) (36 . |maxRowIndex|) (41 . |minColIndex|)
              (46 . |maxColIndex|) (|Vector| 8) (51 . |minIndex|) (56 . |qelt|)
              (63 . |directProduct|) |SMATCAT-;diagonal;SRow;5| (|Boolean|)
              (68 . |diagonal?|) (73 . |diagonal|) (78 . |retract|)
              |SMATCAT-;retract;SR;6| (|Union| 8 '#1="failed")
              (83 . |retractIfCan|) |SMATCAT-;retractIfCan;SU;7| (88 . |Zero|)
              (|Matrix| 10) (92 . |maxRowIndex|) (97 . |maxColIndex|)
              (102 . |column|) (|Matrix| 8) (|Matrix| $)
              (108 . |reducedSystem|) (|Matrix| 6) (113 . |empty?|)
              (118 . |vertConcat|) (124 . |maxRowIndex|) (|Vector| 6)
              (129 . |row|) (|Mapping| 44 44 44) (|List| 44) (135 . |reduce|)
              (141 . |reducedSystem|) (146 . |empty?|) (151 . |coerce|)
              (156 . |reducedSystem|) (161 . |column|)
              (|Record| (|:| |mat| 44) (|:| |vec| 26)) (|Vector| $)
              (167 . |reducedSystem|) (173 . |elt|) (180 . +)
              |SMATCAT-;trace;SR;11| (186 . *) |SMATCAT-;diagonalProduct;SR;12|
              (|Union| $ '"failed") (192 . |inverse|) (197 . ^) (|List| 74)
              (|List| 14) (|Symbol|) (|Matrix| 21)
              (|Record| (|:| |mat| 75) (|:| |vec| (|Vector| 21)))
              (|Fraction| 21) (|Union| 77 '#1#) (|Union| 21 '#1#)
              (|OutputForm|) (|PositiveInteger|))
           '#(|trace| 203 |retractIfCan| 208 |retract| 213 |reducedSystem| 218
              |differentiate| 229 |diagonalProduct| 235 |diagonal| 240 |coerce|
              245 ^ 250)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((^ (|#1| |#1| (|NonNegativeInteger|))) T)
                                   '((|coerce| (|#1| (|Integer|))) T)
                                   '((|differentiate|
                                      (|#1| |#1| (|Mapping| |#3| |#3|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|Mapping| |#3| |#3|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|List| (|Symbol|))
                                       (|List| (|NonNegativeInteger|))))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|Symbol|)
                                       (|NonNegativeInteger|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|List| (|Symbol|))))
                                     T)
                                   '((|differentiate| (|#1| |#1| (|Symbol|)))
                                     T)
                                   '((|differentiate|
                                      (|#1| |#1| (|NonNegativeInteger|)))
                                     T)
                                   '((|differentiate| (|#1| |#1|)) T)
                                   '((|reducedSystem|
                                      ((|Matrix| |#3|) (|Matrix| |#1|)))
                                     T)
                                   '((|reducedSystem|
                                      ((|Record| (|:| |mat| (|Matrix| |#3|))
                                                 (|:| |vec| (|Vector| |#3|)))
                                       (|Matrix| |#1|) (|Vector| |#1|)))
                                     T)
                                   '((|reducedSystem|
                                      ((|Record|
                                        (|:| |mat| (|Matrix| (|Integer|)))
                                        (|:| |vec| (|Vector| (|Integer|))))
                                       (|Matrix| |#1|) (|Vector| |#1|)))
                                     T)
                                   '((|reducedSystem|
                                      ((|Matrix| (|Integer|)) (|Matrix| |#1|)))
                                     T)
                                   '((^ (|#1| |#1| (|Integer|))) T)
                                   '((|diagonalProduct| (|#3| |#1|)) T)
                                   '((|trace| (|#3| |#1|)) T)
                                   '((|diagonal| (|#4| |#1|)) T)
                                   '((|coerce| (|#1| |#3|)) T)
                                   '((|retractIfCan| ((|Union| |#3| #1#) |#1|))
                                     T)
                                   '((|retract| (|#3| |#1|)) T)
                                   '((|retract|
                                      ((|Fraction| (|Integer|)) |#1|))
                                     T)
                                   '((|retractIfCan|
                                      ((|Union| (|Fraction| (|Integer|)) #1#)
                                       |#1|))
                                     T)
                                   '((|coerce| (|#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((|retract| ((|Integer|) |#1|)) T)
                                   '((|retractIfCan|
                                      ((|Union| (|Integer|) #1#) |#1|))
                                     T)
                                   '((^ (|#1| |#1| (|PositiveInteger|))) T)
                                   '((|coerce| ((|OutputForm|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 71
                                            '(2 6 0 0 0 11 0 8 0 12 1 6 0 8 13
                                              2 0 0 0 14 15 2 6 0 17 0 18 0 8 0
                                              20 1 6 21 0 22 1 6 21 0 23 1 6 21
                                              0 24 1 6 21 0 25 1 26 21 0 27 3 6
                                              8 0 21 21 28 1 9 0 26 29 1 6 31 0
                                              32 1 6 9 0 33 1 9 8 0 34 1 9 36 0
                                              37 0 10 0 39 1 40 21 0 41 1 40 21
                                              0 42 2 6 10 0 21 43 1 10 44 45 46
                                              1 47 31 0 48 2 44 0 0 0 49 1 47
                                              21 0 50 2 47 51 0 21 52 2 54 44
                                              53 0 55 1 0 44 45 56 1 51 31 0 57
                                              1 47 0 51 58 1 6 44 45 59 2 44 26
                                              0 21 60 2 0 61 45 62 63 3 6 8 0
                                              21 21 64 2 8 0 0 0 65 2 8 0 0 0
                                              67 1 6 69 0 70 2 0 0 0 21 71 1 0
                                              8 0 66 1 0 36 0 38 1 0 8 0 35 2 0
                                              61 45 62 63 1 0 44 45 56 2 0 0 0
                                              17 19 1 0 8 0 68 1 0 9 0 30 1 0 0
                                              8 16 2 0 0 0 14 15 2 0 0 0 21
                                              71)))))
           '|lookupComplete|)) 
