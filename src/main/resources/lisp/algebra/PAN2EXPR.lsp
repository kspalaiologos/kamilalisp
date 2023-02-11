
(SDEFUN |PAN2EXPR;coerce;PE;1|
        ((|p| (|Polynomial| (|AlgebraicNumber|)))
         ($ (|Expression| (|Integer|))))
        (SPADCALL (ELT $ 8) (ELT $ 10) |p| (QREFELT $ 15))) 

(SDEFUN |PAN2EXPR;coerce;FE;2|
        ((|rf| (|Fraction| (|Polynomial| (|AlgebraicNumber|))))
         ($ (|Expression| (|Integer|))))
        (SPADCALL (SPADCALL (SPADCALL |rf| (QREFELT $ 18)) (QREFELT $ 16))
                  (SPADCALL (SPADCALL |rf| (QREFELT $ 19)) (QREFELT $ 16))
                  (QREFELT $ 20))) 

(DECLAIM (NOTINLINE |PolynomialAN2Expression;|)) 

(DEFUN |PolynomialAN2Expression| ()
  (SPROG NIL
         (PROG (#1=#:G707)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|PolynomialAN2Expression|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|PolynomialAN2Expression|
                             (LIST
                              (CONS NIL
                                    (CONS 1 (|PolynomialAN2Expression;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|PolynomialAN2Expression|)))))))))) 

(DEFUN |PolynomialAN2Expression;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|PolynomialAN2Expression|))
          (LETT $ (GETREFV 22))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PolynomialAN2Expression| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PolynomialAN2Expression| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Symbol|) (|Expression| (|Integer|))
              (0 . |coerce|) (|AlgebraicNumber|) (5 . |coerce|) (|Mapping| 7 6)
              (|Mapping| 7 9) (|Polynomial| 9)
              (|PolynomialCategoryLifting| (|IndexedExponents| 6) 6 9 13 7)
              (10 . |map|) |PAN2EXPR;coerce;PE;1| (|Fraction| 13)
              (17 . |numer|) (22 . |denom|) (27 . /) |PAN2EXPR;coerce;FE;2|)
           '#(|coerce| 33) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|coerce|
                                 ((|Expression| (|Integer|))
                                  (|Polynomial| (|AlgebraicNumber|))))
                                T)
                              '((|coerce|
                                 ((|Expression| (|Integer|))
                                  (|Fraction|
                                   (|Polynomial| (|AlgebraicNumber|)))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 21
                                            '(1 7 0 6 8 1 7 0 9 10 3 14 7 11 12
                                              13 15 1 17 13 0 18 1 17 13 0 19 2
                                              7 0 0 0 20 1 0 7 17 21 1 0 7 13
                                              16)))))
           '|lookupComplete|)) 

(MAKEPROP '|PolynomialAN2Expression| 'NILADIC T) 
