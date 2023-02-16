
(SDEFUN |PDOHLP;id_map;VarA;1| ((|v| (|Var|)) ($ (|Automorphism| R)))
        (|spadConstant| $ 9)) 

(SDEFUN |PDOHLP;diff_map;VarM;2| ((|v| (|Var|)) ($ (|Mapping| R R)))
        (SPROG NIL (CONS #'|PDOHLP;diff_map;VarM;2!0| (VECTOR $ |v|)))) 

(SDEFUN |PDOHLP;diff_map;VarM;2!0| ((|x| NIL) ($$ NIL))
        (PROG (|v| $)
          (LETT |v| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |v| (QREFELT $ 11)))))) 

(DECLAIM (NOTINLINE |PartialDifferentialOperatorHelper;|)) 

(DEFUN |PartialDifferentialOperatorHelper| (&REST #1=#:G693)
  (SPROG NIL
         (PROG (#2=#:G694)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PartialDifferentialOperatorHelper|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |PartialDifferentialOperatorHelper;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|PartialDifferentialOperatorHelper|)))))))))) 

(DEFUN |PartialDifferentialOperatorHelper;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|PartialDifferentialOperatorHelper| DV$1 DV$2))
          (LETT $ (GETREFV 14))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PartialDifferentialOperatorHelper|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PartialDifferentialOperatorHelper| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Automorphism| 6) (0 . |One|) |PDOHLP;id_map;VarA;1|
              (4 . |differentiate|) (|Mapping| 6 6) |PDOHLP;diff_map;VarM;2|)
           '#(|id_map| 10 |diff_map| 15) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|id_map| ((|Automorphism| |#1|) |#2|)) T)
                                   '((|diff_map| ((|Mapping| |#1| |#1|) |#2|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 13
                                            '(0 8 0 9 2 6 0 0 7 11 1 0 8 7 10 1
                                              0 12 7 13)))))
           '|lookupComplete|)) 
