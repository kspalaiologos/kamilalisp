
(SDEFUN |SUP2;map;MSupSup;1|
        ((|f| (|Mapping| S R)) (|p| (|SparseUnivariatePolynomial| R))
         ($ (|SparseUnivariatePolynomial| S)))
        (SPADCALL |f| |p| (QREFELT $ 12))) 

(DECLAIM (NOTINLINE |SparseUnivariatePolynomialFunctions2;|)) 

(DEFUN |SparseUnivariatePolynomialFunctions2| (&REST #1=#:G692)
  (SPROG NIL
         (PROG (#2=#:G693)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|SparseUnivariatePolynomialFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |SparseUnivariatePolynomialFunctions2;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|SparseUnivariatePolynomialFunctions2|)))))))))) 

(DEFUN |SparseUnivariatePolynomialFunctions2;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|SparseUnivariatePolynomialFunctions2| DV$1 DV$2))
          (LETT $ (GETREFV 14))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|SparseUnivariatePolynomialFunctions2| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|SparseUnivariatePolynomialFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|SparseUnivariatePolynomial| 7) (|Mapping| 7 6)
              (|SparseUnivariatePolynomial| 6)
              (|UnivariatePolynomialCategoryFunctions2| 6 10 7 8) (0 . |map|)
              |SUP2;map;MSupSup;1|)
           '#(|map| 6) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|SparseUnivariatePolynomial| |#2|)
                                  (|Mapping| |#2| |#1|)
                                  (|SparseUnivariatePolynomial| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 13
                                            '(2 11 8 9 10 12 2 0 8 9 10 13)))))
           '|lookupComplete|)) 
