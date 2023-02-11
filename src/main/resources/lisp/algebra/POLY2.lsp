
(SDEFUN |POLY2;map;MPP;1|
        ((|f| (|Mapping| S R)) (|p| (|Polynomial| R)) ($ (|Polynomial| S)))
        (SPROG NIL
               (SPADCALL (ELT $ 10) (CONS #'|POLY2;map;MPP;1!0| (VECTOR $ |f|))
                         |p| (QREFELT $ 16)))) 

(SDEFUN |POLY2;map;MPP;1!0| ((|x2| NIL) ($$ NIL))
        (PROG (|f| $)
          (LETT |f| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL (SPADCALL |x2| |f|) (QREFELT $ 11)))))) 

(DECLAIM (NOTINLINE |PolynomialFunctions2;|)) 

(DEFUN |PolynomialFunctions2| (&REST #1=#:G695)
  (SPROG NIL
         (PROG (#2=#:G696)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PolynomialFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PolynomialFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PolynomialFunctions2|)))))))))) 

(DEFUN |PolynomialFunctions2;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|PolynomialFunctions2| DV$1 DV$2))
          (LETT $ (GETREFV 19))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PolynomialFunctions2|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PolynomialFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Symbol|)
              (|Polynomial| 7) (0 . |coerce|) (5 . |coerce|) (|Mapping| 9 8)
              (|Mapping| 9 6) (|Polynomial| 6)
              (|PolynomialCategoryLifting| (|IndexedExponents| 8) 8 6 14 9)
              (10 . |map|) (|Mapping| 7 6) |POLY2;map;MPP;1|)
           '#(|map| 17) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|Polynomial| |#2|) (|Mapping| |#2| |#1|)
                                  (|Polynomial| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 18
                                            '(1 9 0 8 10 1 9 0 7 11 3 15 9 12
                                              13 14 16 2 0 9 17 14 18)))))
           '|lookupComplete|)) 
