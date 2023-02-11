
(SDEFUN |CPIMA;XtoY| ((Q (|PolR|)) ($ (|SparseUnivariatePolynomial| |PolR|)))
        (SPADCALL (CONS #'|CPIMA;XtoY!0| $) Q (QREFELT $ 17))) 

(SDEFUN |CPIMA;XtoY!0| ((|x| NIL) ($ NIL))
        (SPADCALL |x| (|spadConstant| $ 12) (QREFELT $ 13))) 

(SDEFUN |CPIMA;characteristicPolynomial;EPolR;2| ((|x| (E)) ($ (|PolR|)))
        (SPROG ((#1=#:G698 NIL) (|Qx| (|PolR|)))
               (SEQ
                (EXIT
                 (SEQ (LETT |Qx| (SPADCALL |x| (QREFELT $ 24)))
                      (EXIT
                       (PROGN
                        (LETT #1#
                              (SPADCALL (QREFELT $ 19)
                                        (SPADCALL (QREFELT $ 23)
                                                  (|CPIMA;XtoY| |Qx| $)
                                                  (QREFELT $ 25))
                                        (QREFELT $ 26)))
                        (GO #2=#:G697)))))
                #2# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |CharacteristicPolynomialInMonogenicalAlgebra;|)) 

(DEFUN |CharacteristicPolynomialInMonogenicalAlgebra| (&REST #1=#:G699)
  (SPROG NIL
         (PROG (#2=#:G700)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|CharacteristicPolynomialInMonogenicalAlgebra|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function|
                        |CharacteristicPolynomialInMonogenicalAlgebra;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|CharacteristicPolynomialInMonogenicalAlgebra|)))))))))) 

(DEFUN |CharacteristicPolynomialInMonogenicalAlgebra;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$|
                (LIST '|CharacteristicPolynomialInMonogenicalAlgebra| DV$1 DV$2
                      DV$3))
          (LETT $ (GETREFV 28))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|CharacteristicPolynomialInMonogenicalAlgebra|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 19 (|CPIMA;XtoY| (SPADCALL (QREFELT $ 18)) $))
          (QSETREFV $ 23
                    (SPADCALL (SPADCALL (|spadConstant| $ 20) 1 (QREFELT $ 13))
                              0 (QREFELT $ 22)))
          (COND
           ((|HasCategory| |#2| '(|CommutativeRing|))
            (QSETREFV $ 27
                      (CONS
                       (|dispatchFunction|
                        |CPIMA;characteristicPolynomial;EPolR;2|)
                       $))))
          $))) 

(MAKEPROP '|CharacteristicPolynomialInMonogenicalAlgebra| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (0 . |Zero|) (4 . |Zero|) (|NonNegativeInteger|)
              (8 . |Zero|) (12 . |monomial|) (|SparseUnivariatePolynomial| 7)
              (|Mapping| 7 6)
              (|UnivariatePolynomialCategoryFunctions2| 6 7 7 14) (18 . |map|)
              (24 . |definingPolynomial|) 'P (28 . |One|) (32 . |One|)
              (36 . |monomial|) 'X (42 . |lift|) (47 . -) (53 . |resultant|)
              (59 . |characteristicPolynomial|))
           '#(|characteristicPolynomial| 64) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|characteristicPolynomial| (|#2| |#3|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 27
                                            '(0 6 0 9 0 7 0 10 0 11 0 12 2 7 0
                                              6 11 13 2 16 14 15 7 17 0 8 7 18
                                              0 6 0 20 0 7 0 21 2 14 0 7 11 22
                                              1 8 7 0 24 2 14 0 0 0 25 2 14 7 0
                                              0 26 1 0 7 8 27 1 0 7 8 27)))))
           '|lookupComplete|)) 
