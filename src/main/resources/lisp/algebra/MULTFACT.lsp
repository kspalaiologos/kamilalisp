
(SDEFUN |MULTFACT;factor;PF;1| ((|p| (P)) ($ (|Factored| P)))
        (SPADCALL |p| (QREFELT $ 12))) 

(SDEFUN |MULTFACT;factor;PF;2| ((|p| (P)) ($ (|Factored| P)))
        (SPADCALL |p| (QREFELT $ 15))) 

(SDEFUN |MULTFACT;factor;PF;3| ((|p| (P)) ($ (|Factored| P)))
        (SPADCALL |p| (QREFELT $ 17))) 

(SDEFUN |MULTFACT;factor;PF;4| ((|p| (P)) ($ (|Factored| P)))
        (SPADCALL |p| (ELT $ 20) (QREFELT $ 23))) 

(SDEFUN |MULTFACT;factor;PF;5| ((|p| (P)) ($ (|Factored| P)))
        (SPADCALL |p| (ELT $ 20) (QREFELT $ 23))) 

(SDEFUN |MULTFACT;factor;PF;6| ((|p| (P)) ($ (|Factored| P)))
        (SPADCALL |p| (QREFELT $ 25))) 

(SDEFUN |MULTFACT;factor;SupF;7|
        ((|up| (|SparseUnivariatePolynomial| P))
         ($ (|Factored| (|SparseUnivariatePolynomial| P))))
        (SPADCALL |up| (ELT $ 20) (QREFELT $ 28))) 

(DECLAIM (NOTINLINE |MultivariateFactorize;|)) 

(DEFUN |MultivariateFactorize| (&REST #1=#:G724)
  (SPROG NIL
         (PROG (#2=#:G725)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|MultivariateFactorize|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |MultivariateFactorize;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|MultivariateFactorize|)))))))))) 

(DEFUN |MultivariateFactorize;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|MultivariateFactorize| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 30))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|MultivariateFactorize|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|HasCategory| |#3| '(|EuclideanDomain|))
      (COND
       ((|domainEqual| |#3| (|Fraction| (|Integer|)))
        (QSETREFV $ 13 (CONS (|dispatchFunction| |MULTFACT;factor;PF;1|) $)))
       ((|domainEqual| |#3| (|Fraction| (|Complex| (|Integer|))))
        (QSETREFV $ 13 (CONS (|dispatchFunction| |MULTFACT;factor;PF;2|) $)))
       ((|domainEqual| |#3| (|Fraction| (|Polynomial| (|Integer|))))
        (COND
         ((|HasSignature| |#1| '(|convert| ((|Symbol|) $)))
          (QSETREFV $ 13 (CONS (|dispatchFunction| |MULTFACT;factor;PF;3|) $)))
         ('T
          (QSETREFV $ 13
                    (CONS (|dispatchFunction| |MULTFACT;factor;PF;4|) $)))))
       ('T
        (QSETREFV $ 13 (CONS (|dispatchFunction| |MULTFACT;factor;PF;5|) $)))))
     ('T (QSETREFV $ 13 (CONS (|dispatchFunction| |MULTFACT;factor;PF;6|) $))))
    $))) 

(MAKEPROP '|MultivariateFactorize| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|Factored| 9)
              (|MRationalFactorize| 7 6 (|Integer|) 9) (0 . |factor|)
              (5 . |factor|)
              (|MRationalFactorize| 7 6 (|Complex| (|Integer|)) 9)
              (10 . |factor|)
              (|MPolyCatRationalFunctionFactorizer| 7 6 (|Integer|) 9)
              (15 . |factor|) (|Factored| 19) (|SparseUnivariatePolynomial| $)
              (20 . |factorPolynomial|)
              (|Mapping| (|Factored| (|SparseUnivariatePolynomial| 8))
                         (|SparseUnivariatePolynomial| 8))
              (|InnerMultFact| 6 7 8 9) (25 . |factor|) (|Factored| $)
              (31 . |factor|) (|Factored| 27) (|SparseUnivariatePolynomial| 9)
              (36 . |factor|) |MULTFACT;factor;SupF;7|)
           '#(|factor| 42) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|factor| ((|Factored| |#4|) |#4|)) T)
                                   '((|factor|
                                      ((|Factored|
                                        (|SparseUnivariatePolynomial| |#4|))
                                       (|SparseUnivariatePolynomial| |#4|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 29
                                            '(1 11 10 9 12 1 0 10 9 13 1 14 10
                                              9 15 1 16 10 9 17 1 8 18 19 20 2
                                              22 10 9 21 23 1 9 24 0 25 2 22 26
                                              27 21 28 1 0 26 27 29 1 0 10 9
                                              13)))))
           '|lookupComplete|)) 
