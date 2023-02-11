
(SDEFUN |DIRPCAT-;coerce;IS;1| ((|n| (|Integer|)) ($ (S)))
        (SPADCALL (SPADCALL |n| (QREFELT $ 10)) (QREFELT $ 11))) 

(SDEFUN |DIRPCAT-;characteristic;Nni;2| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 14))) 

(SDEFUN |DIRPCAT-;differentiate;SMS;3|
        ((|z| (S)) (|d| (|Mapping| R R)) ($ (S)))
        (SPADCALL |d| |z| (QREFELT $ 17))) 

(SDEFUN |DIRPCAT-;equation2R| ((|v| (|Vector| S)) ($ (|Matrix| R)))
        (SPROG
         ((#1=#:G722 NIL) (|j| NIL) (#2=#:G721 NIL) (|i| NIL)
          (|ans| (|Matrix| R)))
         (SEQ
          (LETT |ans|
                (MAKE_MATRIX1 (QREFELT $ 7) (QVSIZE |v|)
                              (|spadConstant| $ 19)))
          (SEQ (LETT |i| (PROGN |ans| 1))
               (LETT #2# (SPADCALL |ans| (QREFELT $ 21))) G190
               (COND ((> |i| #2#) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |j| (PROGN |ans| 1))
                      (LETT #1# (SPADCALL |ans| (QREFELT $ 22))) G190
                      (COND ((> |j| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (QSETAREF2O |ans| |i| |j|
                                    (SPADCALL (QAREF1O |v| |j| 1) |i|
                                              (QREFELT $ 23))
                                    1 1)))
                      (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
               (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
          (EXIT |ans|)))) 

(SDEFUN |DIRPCAT-;reducedSystem;MM;5| ((|m| (|Matrix| S)) ($ (|Matrix| R)))
        (SPROG ((#1=#:G734 NIL) (|i| NIL) (#2=#:G733 NIL))
               (SEQ
                (COND
                 ((SPADCALL |m| (QREFELT $ 26))
                  (MAKE_MATRIX1 (* (QREFELT $ 7) (ANROWS |m|)) (ANCOLS |m|)
                                (|spadConstant| $ 19)))
                 ('T
                  (SPADCALL (ELT $ 27)
                            (PROGN
                             (LETT #2# NIL)
                             (SEQ (LETT |i| (PROGN |m| 1))
                                  (LETT #1# (SPADCALL |m| (QREFELT $ 28))) G190
                                  (COND ((> |i| #1#) (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #2#
                                          (CONS
                                           (|DIRPCAT-;equation2R|
                                            (SPADCALL |m| |i| (QREFELT $ 30))
                                            $)
                                           #2#))))
                                  (LETT |i| (+ |i| 1)) (GO G190) G191
                                  (EXIT (NREVERSE #2#))))
                            (QREFELT $ 33))))))) 

(SDEFUN |DIRPCAT-;reducedSystem;MVR;6|
        ((|m| (|Matrix| S)) (|v| (|Vector| S))
         ($ (|Record| (|:| |mat| (|Matrix| R)) (|:| |vec| (|Vector| R)))))
        (SPROG ((|vh| (|Vector| R)) (|rh| (|Matrix| R)))
               (SEQ
                (LETT |vh|
                      (COND ((SPADCALL |v| (QREFELT $ 36)) (MAKE-ARRAY 0))
                            ('T
                             (SEQ
                              (LETT |rh|
                                    (SPADCALL (SPADCALL |v| (QREFELT $ 37))
                                              (QREFELT $ 38)))
                              (EXIT
                               (SPADCALL |rh| (PROGN |rh| 1)
                                         (QREFELT $ 40)))))))
                (EXIT (CONS (SPADCALL |m| (QREFELT $ 38)) |vh|))))) 

(SDEFUN |DIRPCAT-;size;Nni;7| (($ (|NonNegativeInteger|)))
        (EXPT (SPADCALL (QREFELT $ 44)) (QREFELT $ 7))) 

(SDEFUN |DIRPCAT-;index;PiS;8| ((|n| (|PositiveInteger|)) ($ (S)))
        (SPROG
         ((|n0| (|Integer|)) (#1=#:G745 NIL)
          (|d|
           (|Record| (|:| |quotient| (|Integer|))
                     (|:| |remainder| (|Integer|))))
          (#2=#:G750 NIL) (|i| NIL) (|r| (|Vector| R))
          (|s| (|NonNegativeInteger|)))
         (SEQ (LETT |s| (SPADCALL (QREFELT $ 44)))
              (LETT |r| (MAKEARR1 (QREFELT $ 7) (SPADCALL 1 (QREFELT $ 47))))
              (LETT |n0| (- |n| 1))
              (SEQ (LETT |i| 1) (LETT #2# (QREFELT $ 7)) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ (LETT |d| (DIVIDE2 |n0| |s|))
                        (SPADCALL |r| |i|
                                  (SPADCALL
                                   (PROG1 (LETT #1# (+ 1 (QCDR |d|)))
                                     (|check_subtype2| (> #1# 0)
                                                       '(|PositiveInteger|)
                                                       '(|Integer|) #1#))
                                   (QREFELT $ 47))
                                  (QREFELT $ 48))
                        (EXIT (LETT |n0| (QCAR |d|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |r| (QREFELT $ 49)))))) 

(SDEFUN |DIRPCAT-;lookup;SPi;9| ((|v| (S)) ($ (|PositiveInteger|)))
        (SPROG
         ((#1=#:G754 NIL) (|pow| (|NonNegativeInteger|)) (|res| (|Integer|))
          (#2=#:G757 NIL) (|i| NIL) (|s| (|NonNegativeInteger|)))
         (SEQ (LETT |s| (SPADCALL (QREFELT $ 44))) (LETT |pow| 1)
              (LETT |res| 1)
              (SEQ (LETT |i| 1) (LETT #2# (QREFELT $ 7)) G190
                   (COND ((|greater_SI| |i| #2#) (GO G191)))
                   (SEQ
                    (LETT |res|
                          (+ |res|
                             (*
                              (-
                               (SPADCALL (SPADCALL |v| |i| (QREFELT $ 51))
                                         (QREFELT $ 52))
                               1)
                              |pow|)))
                    (EXIT (LETT |pow| (* |pow| |s|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (PROG1 (LETT #1# |res|)
                 (|check_subtype2| (> #1# 0) '(|PositiveInteger|) '(|Integer|)
                                   #1#)))))) 

(DECLAIM (NOTINLINE |DirectProductCategory&;|)) 

(DEFUN |DirectProductCategory&| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 |#2|)
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|DirectProductCategory&| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 61))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#3|
                                                             '(|OrderedAbelianMonoidSup|))
                                              (|HasCategory| |#3|
                                                             '(|OrderedAbelianMonoid|))
                                              (|HasCategory| |#3|
                                                             '(|OrderedSet|))
                                              (|HasCategory| |#3|
                                                             '(|unitsKnown|))
                                              (|HasCategory| |#3|
                                                             '(|CommutativeRing|))
                                              (|HasCategory| |#3| '(|Finite|))
                                              (|HasCategory| |#3|
                                                             '(|SemiGroup|))
                                              (|HasCategory| |#3| '(|SemiRng|))
                                              (|HasCategory| |#3| '(|Monoid|))
                                              (|HasCategory| |#3|
                                                             '(|AbelianMonoid|))
                                              (|HasCategory| |#3| '(|Ring|))
                                              (|HasCategory| |#3|
                                                             '(|SetCategory|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 11)
            (PROGN
             (QSETREFV $ 12
                       (CONS (|dispatchFunction| |DIRPCAT-;coerce;IS;1|) $))
             (QSETREFV $ 15
                       (CONS
                        (|dispatchFunction| |DIRPCAT-;characteristic;Nni;2|)
                        $))
             (QSETREFV $ 18
                       (CONS
                        (|dispatchFunction| |DIRPCAT-;differentiate;SMS;3|) $))
             (QSETREFV $ 35
                       (CONS (|dispatchFunction| |DIRPCAT-;reducedSystem;MM;5|)
                             $))
             (QSETREFV $ 43
                       (CONS
                        (|dispatchFunction| |DIRPCAT-;reducedSystem;MVR;6|)
                        $)))))
          (COND
           ((|testBitVector| |pv$| 6)
            (PROGN
             (QSETREFV $ 45
                       (CONS (|dispatchFunction| |DIRPCAT-;size;Nni;7|) $))
             (QSETREFV $ 50
                       (CONS (|dispatchFunction| |DIRPCAT-;index;PiS;8|) $))
             (QSETREFV $ 53
                       (CONS (|dispatchFunction| |DIRPCAT-;lookup;SPi;9|)
                             $)))))
          $))) 

(MAKEPROP '|DirectProductCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Integer|) (0 . |coerce|) (5 . |coerce|)
              (10 . |coerce|) (|NonNegativeInteger|) (15 . |characteristic|)
              (19 . |characteristic|) (|Mapping| 8 8) (23 . |map|)
              (29 . |differentiate|) (35 . |Zero|) (|Matrix| 8)
              (39 . |maxRowIndex|) (44 . |maxColIndex|) (49 . |qelt|)
              (|Boolean|) (|Matrix| 6) (55 . |empty?|) (60 . |vertConcat|)
              (66 . |maxRowIndex|) (|Vector| 6) (71 . |row|)
              (|Mapping| 20 20 20) (|List| 20) (77 . |reduce|) (|Matrix| $)
              (83 . |reducedSystem|) (88 . |empty?|) (93 . |coerce|)
              (98 . |reducedSystem|) (|Vector| 8) (103 . |column|)
              (|Record| (|:| |mat| 20) (|:| |vec| 39)) (|Vector| $)
              (109 . |reducedSystem|) (115 . |size|) (119 . |size|)
              (|PositiveInteger|) (123 . |index|) (128 . |setelt!|)
              (135 . |directProduct|) (140 . |index|) (145 . |elt|)
              (151 . |lookup|) (156 . |lookup|) (|Fraction| 9) (|OutputForm|)
              (|Symbol|) (|List| 56) (|List| 13)
              (|Record| (|:| |mat| 60) (|:| |vec| (|Vector| 9))) (|Matrix| 9))
           '#(|size| 161 |reducedSystem| 165 |lookup| 176 |index| 181
              |differentiate| 186 |coerce| 192 |characteristic| 197)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|coerce| (|#1| |#3|)) T)
                                   '((|coerce| (|#1| (|Fraction| (|Integer|))))
                                     T)
                                   '((|coerce| (|#1| (|Integer|))) T)
                                   '((|coerce| ((|OutputForm|) |#1|)) T)
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
                                   '((|characteristic|
                                      ((|NonNegativeInteger|)))
                                     T)
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
                                   '((|size| ((|NonNegativeInteger|))) T)
                                   '((|index| (|#1| (|PositiveInteger|))) T)
                                   '((|lookup| ((|PositiveInteger|) |#1|)) T)
                                   '((|coerce| (|#1| |#1|)) T)
                                   '((|coerce| ((|Vector| |#3|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 53
                                            '(1 8 0 9 10 1 6 0 8 11 1 0 0 9 12
                                              0 8 13 14 0 0 13 15 2 6 0 16 0 17
                                              2 0 0 0 16 18 0 8 0 19 1 20 9 0
                                              21 1 20 9 0 22 2 6 8 0 9 23 1 25
                                              24 0 26 2 20 0 0 0 27 1 25 9 0 28
                                              2 25 29 0 9 30 2 32 20 31 0 33 1
                                              0 20 34 35 1 29 24 0 36 1 25 0 29
                                              37 1 6 20 34 38 2 20 39 0 9 40 2
                                              0 41 34 42 43 0 8 13 44 0 0 13 45
                                              1 8 0 46 47 3 39 8 0 9 8 48 1 6 0
                                              39 49 1 0 0 46 50 2 6 8 0 9 51 1
                                              8 46 0 52 1 0 46 0 53 0 0 13 45 1
                                              0 20 34 35 2 0 41 34 42 43 1 0 46
                                              0 53 1 0 0 46 50 2 0 0 0 16 18 1
                                              0 0 9 12 0 0 13 15)))))
           '|lookupComplete|)) 
