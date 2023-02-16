
(SDEFUN |INTRF;infieldIntegrate;FSU;1|
        ((|f| (|Fraction| (|Polynomial| F))) (|x| (|Symbol|))
         ($ (|Union| (|Fraction| (|Polynomial| F)) "failed")))
        (SPROG NIL
               (SPADCALL
                (CONS #'|INTRF;infieldIntegrate;FSU;1!0| (VECTOR $ |x|))
                (SPADCALL (SPADCALL |f| |x| (QREFELT $ 12)) (QREFELT $ 15))
                (QREFELT $ 19)))) 

(SDEFUN |INTRF;infieldIntegrate;FSU;1!0| ((|x1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |x| (QREFELT $ 11)))))) 

(SDEFUN |INTRF;internalIntegrate;FSIr;2|
        ((|f| (|Fraction| (|Polynomial| F))) (|x| (|Symbol|))
         ($ (|IntegrationResult| (|Fraction| (|Polynomial| F)))))
        (SPROG NIL
               (SPADCALL
                (CONS #'|INTRF;internalIntegrate;FSIr;2!0| (VECTOR $ |x|))
                (SPADCALL (SPADCALL |f| |x| (QREFELT $ 12)) (QREFELT $ 22))
                (QREFELT $ 24)))) 

(SDEFUN |INTRF;internalIntegrate;FSIr;2!0| ((|x1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |x| (QREFELT $ 11)))))) 

(DECLAIM (NOTINLINE |RationalFunctionIntegration;|)) 

(DEFUN |RationalFunctionIntegration| (#1=#:G707)
  (SPROG NIL
         (PROG (#2=#:G708)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|RationalFunctionIntegration|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|RationalFunctionIntegration;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|RationalFunctionIntegration|)))))))))) 

(DEFUN |RationalFunctionIntegration;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|RationalFunctionIntegration| DV$1))
          (LETT $ (GETREFV 26))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RationalFunctionIntegration|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RationalFunctionIntegration| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|)
              (|Fraction| (|Polynomial| 6))
              (|Fraction| (|SparseUnivariatePolynomial| 7)) (|Symbol|)
              (|PolynomialCategoryQuotientFunctions| (|IndexedExponents| 9) 9 6
                                                     (|Polynomial| 6) 7)
              (0 . |multivariate|) (6 . |univariate|) (|Union| 8 '"failed")
              (|RationalIntegration| 7 (|SparseUnivariatePolynomial| 7))
              (12 . |infieldint|) (|Union| 7 '"failed") (|Mapping| 7 8)
              (|IntegrationResultFunctions2| 8 7) (17 . |map|)
              |INTRF;infieldIntegrate;FSU;1| (|IntegrationResult| 8)
              (23 . |integrate|) (|IntegrationResult| 7) (28 . |map|)
              |INTRF;internalIntegrate;FSIr;2|)
           '#(|internalIntegrate| 34 |infieldIntegrate| 40) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|internalIntegrate|
                                 ((|IntegrationResult|
                                   (|Fraction| (|Polynomial| |#1|)))
                                  (|Fraction| (|Polynomial| |#1|)) (|Symbol|)))
                                T)
                              '((|infieldIntegrate|
                                 ((|Union| (|Fraction| (|Polynomial| |#1|))
                                           "failed")
                                  (|Fraction| (|Polynomial| |#1|)) (|Symbol|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 25
                                            '(2 10 7 8 9 11 2 10 8 7 9 12 1 14
                                              13 8 15 2 18 16 17 13 19 1 14 21
                                              8 22 2 18 23 17 21 24 2 0 23 7 9
                                              25 2 0 16 7 9 20)))))
           '|lookupComplete|)) 
