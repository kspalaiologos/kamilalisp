
(SDEFUN |ALGMFACT;factor;PLF;1|
        ((|p| (P)) (|lalg| (|List| (|AlgebraicNumber|))) ($ (|Factored| P)))
        (SPROG NIL
               (SPADCALL |p|
                         (CONS #'|ALGMFACT;factor;PLF;1!0| (VECTOR $ |lalg|))
                         (QREFELT $ 17)))) 

(SDEFUN |ALGMFACT;factor;PLF;1!0| ((|z1| NIL) ($$ NIL))
        (PROG (|lalg| $)
          (LETT |lalg| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z1| |lalg| (QREFELT $ 13)))))) 

(SDEFUN |ALGMFACT;factor;SupLF;2|
        ((|up| (|SparseUnivariatePolynomial| P))
         (|lalg| (|List| (|AlgebraicNumber|)))
         ($ (|Factored| (|SparseUnivariatePolynomial| P))))
        (SPROG NIL
               (SPADCALL |up|
                         (CONS #'|ALGMFACT;factor;SupLF;2!0| (VECTOR $ |lalg|))
                         (QREFELT $ 21)))) 

(SDEFUN |ALGMFACT;factor;SupLF;2!0| ((|z1| NIL) ($$ NIL))
        (PROG (|lalg| $)
          (LETT |lalg| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z1| |lalg| (QREFELT $ 13)))))) 

(DECLAIM (NOTINLINE |AlgebraicMultFact;|)) 

(DEFUN |AlgebraicMultFact| (&REST #1=#:G708)
  (SPROG NIL
         (PROG (#2=#:G709)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|AlgebraicMultFact|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |AlgebraicMultFact;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|AlgebraicMultFact|)))))))))) 

(DEFUN |AlgebraicMultFact;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|AlgebraicMultFact| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 23))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|AlgebraicMultFact|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9
                    (|AlgFactor|
                     (|SparseUnivariatePolynomial| (|AlgebraicNumber|))))
          $))) 

(MAKEPROP '|AlgebraicMultFact| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) 'AF (|Factored| 11)
              (|SparseUnivariatePolynomial| (|AlgebraicNumber|))
              (|List| (|AlgebraicNumber|)) (0 . |factor|) (|Factored| 8)
              (|Mapping| 10 11) (|InnerMultFact| 6 7 (|AlgebraicNumber|) 8)
              (6 . |factor|) |ALGMFACT;factor;PLF;1| (|Factored| 20)
              (|SparseUnivariatePolynomial| 8) (12 . |factor|)
              |ALGMFACT;factor;SupLF;2|)
           '#(|factor| 18) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|factor|
                                 ((|Factored| |#3|) |#3|
                                  (|List| (|AlgebraicNumber|))))
                                T)
                              '((|factor|
                                 ((|Factored|
                                   (|SparseUnivariatePolynomial| |#3|))
                                  (|SparseUnivariatePolynomial| |#3|)
                                  (|List| (|AlgebraicNumber|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 22
                                            '(2 9 10 11 12 13 2 16 14 8 15 17 2
                                              16 19 20 15 21 2 0 19 20 12 22 2
                                              0 14 8 12 18)))))
           '|lookupComplete|)) 
