
(SDEFUN |MAPPKG2;const;CM;1| ((|c| (C)) ($ (|Mapping| C A)))
        (SPROG NIL (CONS #'|MAPPKG2;const;CM;1!0| (VECTOR $ |c|)))) 

(SDEFUN |MAPPKG2;const;CM;1!0| ((|a1| NIL) ($$ NIL))
        (PROG (|c| $)
          (LETT |c| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |a1| |c| (QREFELT $ 9)))))) 

(SDEFUN |MAPPKG2;curry;MAM;2|
        ((|fac| (|Mapping| C A)) (|a| (A)) ($ (|Mapping| C)))
        (SPROG NIL (CONS #'|MAPPKG2;curry;MAM;2!0| (VECTOR |fac| |a|)))) 

(SDEFUN |MAPPKG2;curry;MAM;2!0| (($$ NIL))
        (PROG (|a| |fac|)
          (LETT |a| (QREFELT $$ 1))
          (LETT |fac| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |a| |fac|))))) 

(SDEFUN |MAPPKG2;constant;MM;3| ((|f0c| (|Mapping| C)) ($ (|Mapping| C A)))
        (SPROG NIL (CONS #'|MAPPKG2;constant;MM;3!0| (VECTOR $ |f0c|)))) 

(SDEFUN |MAPPKG2;constant;MM;3!0| ((|a1| NIL) ($$ NIL))
        (PROG (|f0c| $)
          (LETT |f0c| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |a1| (SPADCALL |f0c|) (QREFELT $ 9)))))) 

(SDEFUN |MAPPKG2;diag;MM;4| ((|faac| (|Mapping| C A A)) ($ (|Mapping| C A)))
        (CONS #'|MAPPKG2;diag;MM;4!0| |faac|)) 

(SDEFUN |MAPPKG2;diag;MM;4!0| ((|a1| NIL) (|faac| NIL))
        (SPADCALL |a1| |a1| |faac|)) 

(DECLAIM (NOTINLINE |MappingPackage2;|)) 

(DEFUN |MappingPackage2| (&REST #1=#:G700)
  (SPROG NIL
         (PROG (#2=#:G701)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|MappingPackage2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |MappingPackage2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|MappingPackage2|)))))))))) 

(DEFUN |MappingPackage2;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|MappingPackage2| DV$1 DV$2))
          (LETT $ (GETREFV 17))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|MappingPackage2| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|MappingPackage2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|MappingPackageInternalHacks2| 6 7) (0 . |arg2|) (|Mapping| 7 6)
              |MAPPKG2;const;CM;1| (|Mapping| 7) |MAPPKG2;curry;MAM;2|
              |MAPPKG2;constant;MM;3| (|Mapping| 7 6 6) |MAPPKG2;diag;MM;4|)
           '#(|diag| 6 |curry| 11 |constant| 17 |const| 22) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|const| ((|Mapping| |#2| |#1|) |#2|)) T)
                                   '((|curry|
                                      ((|Mapping| |#2|) (|Mapping| |#2| |#1|)
                                       |#1|))
                                     T)
                                   '((|constant|
                                      ((|Mapping| |#2| |#1|) (|Mapping| |#2|)))
                                     T)
                                   '((|diag|
                                      ((|Mapping| |#2| |#1|)
                                       (|Mapping| |#2| |#1| |#1|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 16
                                            '(2 8 7 6 7 9 1 0 10 15 16 2 0 12
                                              10 6 13 1 0 10 12 14 1 0 10 7
                                              11)))))
           '|lookupComplete|)) 
