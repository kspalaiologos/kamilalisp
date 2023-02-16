
(SDEFUN |FSRROOT;get_rational_roots;FKL;1|
        ((|eq1f| (F)) (|k1| (|Kernel| F))
         ($ (|List| (|Fraction| (|Integer|)))))
        (SPROG ((|eq2p| (|SparseUnivariatePolynomial| F)))
               (SEQ
                (LETT |eq2p|
                      (SPADCALL (SPADCALL |eq1f| |k1| (QREFELT $ 10))
                                (QREFELT $ 13)))
                (EXIT (SPADCALL |eq2p| (QREFELT $ 16)))))) 

(DECLAIM (NOTINLINE |FunctionSpaceRationalRoots;|)) 

(DEFUN |FunctionSpaceRationalRoots| (&REST #1=#:G700)
  (SPROG NIL
         (PROG (#2=#:G701)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FunctionSpaceRationalRoots|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FunctionSpaceRationalRoots;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|FunctionSpaceRationalRoots|)))))))))) 

(DEFUN |FunctionSpaceRationalRoots;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|FunctionSpaceRationalRoots| DV$1 DV$2))
          (LETT $ (GETREFV 19))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FunctionSpaceRationalRoots|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FunctionSpaceRationalRoots| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Fraction| (|SparseUnivariatePolynomial| $)) (|Kernel| $)
              (0 . |univariate|) (|SparseUnivariatePolynomial| 7)
              (|Fraction| 11) (6 . |numer|) (|List| (|Fraction| (|Integer|)))
              (|PolynomialRationalRoots| 7 11) (11 . |get_rational_roots|)
              (|Kernel| 7) |FSRROOT;get_rational_roots;FKL;1|)
           '#(|get_rational_roots| 16) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|get_rational_roots|
                                 ((|List| (|Fraction| (|Integer|))) |#2|
                                  (|Kernel| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 18
                                            '(2 7 8 0 9 10 1 12 11 0 13 1 15 14
                                              11 16 2 0 14 7 17 18)))))
           '|lookupComplete|)) 
