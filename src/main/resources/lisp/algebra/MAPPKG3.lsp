
(SDEFUN |MAPPKG3;curryRight;MBM;1|
        ((|fabc| (|Mapping| C A B)) (|b| (B)) ($ (|Mapping| C A)))
        (SPROG NIL (CONS #'|MAPPKG3;curryRight;MBM;1!0| (VECTOR |fabc| |b|)))) 

(SDEFUN |MAPPKG3;curryRight;MBM;1!0| ((|a| NIL) ($$ NIL))
        (PROG (|b| |fabc|)
          (LETT |b| (QREFELT $$ 1))
          (LETT |fabc| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |a| |b| |fabc|))))) 

(SDEFUN |MAPPKG3;curryLeft;MAM;2|
        ((|fabc| (|Mapping| C A B)) (|a| (A)) ($ (|Mapping| C B)))
        (SPROG NIL (CONS #'|MAPPKG3;curryLeft;MAM;2!0| (VECTOR |fabc| |a|)))) 

(SDEFUN |MAPPKG3;curryLeft;MAM;2!0| ((|b| NIL) ($$ NIL))
        (PROG (|a| |fabc|)
          (LETT |a| (QREFELT $$ 1))
          (LETT |fabc| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |a| |b| |fabc|))))) 

(SDEFUN |MAPPKG3;constantRight;MM;3|
        ((|fac| (|Mapping| C A)) ($ (|Mapping| C A B)))
        (CONS #'|MAPPKG3;constantRight;MM;3!0| |fac|)) 

(SDEFUN |MAPPKG3;constantRight;MM;3!0| ((|a| NIL) (|b| NIL) (|fac| NIL))
        (SPADCALL |a| |fac|)) 

(SDEFUN |MAPPKG3;constantLeft;MM;4|
        ((|fbc| (|Mapping| C B)) ($ (|Mapping| C A B)))
        (CONS #'|MAPPKG3;constantLeft;MM;4!0| |fbc|)) 

(SDEFUN |MAPPKG3;constantLeft;MM;4!0| ((|a| NIL) (|b| NIL) (|fbc| NIL))
        (SPADCALL |b| |fbc|)) 

(SDEFUN |MAPPKG3;twist;MM;5| ((|fabc| (|Mapping| C A B)) ($ (|Mapping| C B A)))
        (CONS #'|MAPPKG3;twist;MM;5!0| |fabc|)) 

(SDEFUN |MAPPKG3;twist;MM;5!0| ((|b| NIL) (|a| NIL) (|fabc| NIL))
        (SPADCALL |a| |b| |fabc|)) 

(SDEFUN |MAPPKG3;*;MMM;6|
        ((|fbc| (|Mapping| C B)) (|fab| (|Mapping| B A)) ($ (|Mapping| C A)))
        (SPROG NIL (CONS #'|MAPPKG3;*;MMM;6!0| (VECTOR $ |fab| |fbc|)))) 

(SDEFUN |MAPPKG3;*;MMM;6!0| ((|a| NIL) ($$ NIL))
        (PROG (|fbc| |fab| $)
          (LETT |fbc| (QREFELT $$ 2))
          (LETT |fab| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |fbc| |fab| |a| (QREFELT $ 20)))))) 

(DECLAIM (NOTINLINE |MappingPackage3;|)) 

(DEFUN |MappingPackage3| (&REST #1=#:G707)
  (SPROG NIL
         (PROG (#2=#:G708)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|MappingPackage3|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |MappingPackage3;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|MappingPackage3|)))))))))) 

(DEFUN |MappingPackage3;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|MappingPackage3| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 22))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|MappingPackage3|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|MappingPackage3| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Mapping| 8 6) (|Mapping| 8 6 7)
              |MAPPKG3;curryRight;MBM;1| (|Mapping| 8 7)
              |MAPPKG3;curryLeft;MAM;2| |MAPPKG3;constantRight;MM;3|
              |MAPPKG3;constantLeft;MM;4| (|Mapping| 8 7 6)
              |MAPPKG3;twist;MM;5| (|Mapping| 7 6)
              (|MappingPackageInternalHacks3| 6 7 8) (0 . |comp|)
              |MAPPKG3;*;MMM;6|)
           '#(|twist| 7 |curryRight| 12 |curryLeft| 18 |constantRight| 24
              |constantLeft| 29 * 34)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|curryRight|
                                 ((|Mapping| |#3| |#1|)
                                  (|Mapping| |#3| |#1| |#2|) |#2|))
                                T)
                              '((|curryLeft|
                                 ((|Mapping| |#3| |#2|)
                                  (|Mapping| |#3| |#1| |#2|) |#1|))
                                T)
                              '((|constantRight|
                                 ((|Mapping| |#3| |#1| |#2|)
                                  (|Mapping| |#3| |#1|)))
                                T)
                              '((|constantLeft|
                                 ((|Mapping| |#3| |#1| |#2|)
                                  (|Mapping| |#3| |#2|)))
                                T)
                              '((|twist|
                                 ((|Mapping| |#3| |#2| |#1|)
                                  (|Mapping| |#3| |#1| |#2|)))
                                T)
                              '((*
                                 ((|Mapping| |#3| |#1|) (|Mapping| |#3| |#2|)
                                  (|Mapping| |#2| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 21
                                            '(3 19 8 12 18 6 20 1 0 16 10 17 2
                                              0 9 10 7 11 2 0 12 10 6 13 1 0 10
                                              9 14 1 0 10 12 15 2 0 9 12 18
                                              21)))))
           '|lookupComplete|)) 
