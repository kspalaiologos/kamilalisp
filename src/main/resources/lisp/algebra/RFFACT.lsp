
(SDEFUN |RFFACT;likuniv|
        ((|p| (|Polynomial| (|Integer|))) (|x| (|Symbol|))
         (|d| (|Polynomial| (|Integer|))) ($ (UP)))
        (SPROG NIL
               (SPADCALL (CONS #'|RFFACT;likuniv!0| (VECTOR $ |d|))
                         (SPADCALL |p| |x| (QREFELT $ 14)) (QREFELT $ 18)))) 

(SDEFUN |RFFACT;likuniv!0| ((|y| NIL) ($$ NIL))
        (PROG (|d| $)
          (LETT |d| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |y| |d| (QREFELT $ 12)))))) 

(SDEFUN |RFFACT;factor;UPF;2| ((|p| (UP)) ($ (|Factored| UP)))
        (SPROG
         ((|d| (|Polynomial| (|Integer|)))
          (|q| (|Fraction| (|Polynomial| (|Integer|)))))
         (SEQ
          (LETT |d|
                (SPADCALL
                 (LETT |q|
                       (SPADCALL |p|
                                 (SPADCALL
                                  (SPADCALL (QREFELT $ 9) (QREFELT $ 19))
                                  (QREFELT $ 20))
                                 (QREFELT $ 21)))
                 (QREFELT $ 22)))
          (EXIT
           (SPADCALL
            (CONS #'|RFFACT;factor;UPF;2!0| (VECTOR $ |d| (QREFELT $ 9)))
            (SPADCALL (SPADCALL |q| (QREFELT $ 23)) (QREFELT $ 26))
            (QREFELT $ 30)))))) 

(SDEFUN |RFFACT;factor;UPF;2!0| ((|x| NIL) ($$ NIL))
        (PROG (|dummy| |d| $)
          (LETT |dummy| (QREFELT $$ 2))
          (LETT |d| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|RFFACT;likuniv| |x| |dummy| |d| $))))) 

(DECLAIM (NOTINLINE |RationalFunctionFactor;|)) 

(DEFUN |RationalFunctionFactor| (#1=#:G725)
  (SPROG NIL
         (PROG (#2=#:G726)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|RationalFunctionFactor|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|RationalFunctionFactor;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|RationalFunctionFactor|)))))))))) 

(DEFUN |RationalFunctionFactor;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|RationalFunctionFactor| DV$1))
          (LETT $ (GETREFV 32))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RationalFunctionFactor| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9 (SPADCALL (QREFELT $ 8)))
          $))) 

(MAKEPROP '|RationalFunctionFactor| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Symbol|) (0 . |new|)
              '|dummy| (|Polynomial| (|Integer|)) (|Fraction| 10) (4 . /)
              (|SparseUnivariatePolynomial| $) (10 . |univariate|)
              (|Mapping| 11 10) (|SparseUnivariatePolynomial| 10)
              (|UnivariatePolynomialCategoryFunctions2| 10 16 11 6)
              (16 . |map|) (22 . |coerce|) (27 . |coerce|) (32 . |elt|)
              (38 . |denom|) (43 . |numer|) (|Factored| 10)
              (|MultivariateFactorize| 7 (|IndexedExponents| 7) (|Integer|) 10)
              (48 . |factor|) (|Factored| 6) (|Mapping| 6 10)
              (|FactoredFunctions2| 10 6) (53 . |map|) |RFFACT;factor;UPF;2|)
           '#(|factor| 59) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|factor| ((|Factored| |#1|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 31
                                            '(0 7 0 8 2 11 0 10 10 12 2 10 13 0
                                              7 14 2 17 6 15 16 18 1 10 0 7 19
                                              1 11 0 10 20 2 6 11 0 11 21 1 11
                                              10 0 22 1 11 10 0 23 1 25 24 10
                                              26 2 29 27 28 24 30 1 0 27 6
                                              31)))))
           '|lookupComplete|)) 
