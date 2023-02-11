
(SDEFUN |CHARPOL;characteristicPolynomial;M2R;1|
        ((A (|Matrix| R)) (|v| (R)) ($ (R)))
        (SPROG
         ((#1=#:G710 NIL) (|j| NIL) (#2=#:G709 NIL) (|i| NIL) (B (|Matrix| R))
          (|dimA| (|NonNegativeInteger|)))
         (SEQ (LETT |dimA| (ANROWS A))
              (EXIT
               (COND
                ((SPADCALL |dimA| (ANCOLS A) (QREFELT $ 9))
                 (|error| " The matrix is not square"))
                ((EQL |dimA| 0) (|spadConstant| $ 11))
                ('T
                 (SEQ (LETT B (SPADCALL |dimA| |dimA| (QREFELT $ 13)))
                      (SEQ (LETT |i| 1) (LETT #2# |dimA|) G190
                           (COND ((|greater_SI| |i| #2#) (GO G191)))
                           (SEQ
                            (SEQ (LETT |j| 1) (LETT #1# |dimA|) G190
                                 (COND ((|greater_SI| |j| #1#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (SPADCALL B |i| |j|
                                             (SPADCALL A |i| |j|
                                                       (QREFELT $ 15))
                                             (QREFELT $ 16))))
                                 (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT
                             (SPADCALL B |i| |i|
                                       (SPADCALL
                                        (SPADCALL B |i| |i| (QREFELT $ 15)) |v|
                                        (QREFELT $ 17))
                                       (QREFELT $ 16))))
                           (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                      (EXIT (SPADCALL B (QREFELT $ 18)))))))))) 

(DECLAIM (NOTINLINE |CharacteristicPolynomialPackage;|)) 

(DEFUN |CharacteristicPolynomialPackage| (#1=#:G711)
  (SPROG NIL
         (PROG (#2=#:G712)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|CharacteristicPolynomialPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|CharacteristicPolynomialPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|CharacteristicPolynomialPackage|)))))))))) 

(DEFUN |CharacteristicPolynomialPackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|CharacteristicPolynomialPackage| DV$1))
          (LETT $ (GETREFV 20))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|CharacteristicPolynomialPackage|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|CharacteristicPolynomialPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Boolean|)
              (|NonNegativeInteger|) (0 . ~=) (6 . |Zero|) (10 . |One|)
              (|Matrix| 6) (14 . |zero|) (|Integer|) (20 . |elt|)
              (27 . |setelt!|) (35 . -) (41 . |determinant|)
              |CHARPOL;characteristicPolynomial;M2R;1|)
           '#(|characteristicPolynomial| 46) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|characteristicPolynomial|
                                 (|#1| (|Matrix| |#1|) |#1|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 19
                                            '(2 8 7 0 0 9 0 6 0 10 0 6 0 11 2
                                              12 0 8 8 13 3 12 6 0 14 14 15 4
                                              12 6 0 14 14 6 16 2 6 0 0 0 17 1
                                              12 6 0 18 2 0 6 12 6 19)))))
           '|lookupComplete|)) 
