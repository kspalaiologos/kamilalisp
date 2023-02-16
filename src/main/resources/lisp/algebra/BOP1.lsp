
(SDEFUN |BOP1;evaluate;BoMBo;1|
        ((|op| (|BasicOperator|)) (|func| (|Mapping| A A))
         ($ (|BasicOperator|)))
        (SPROG NIL
               (SPADCALL |op|
                         (CONS #'|BOP1;evaluate;BoMBo;1!0| (VECTOR |func| $))
                         (QREFELT $ 14)))) 

(SDEFUN |BOP1;evaluate;BoMBo;1!0| ((|l1| NIL) ($$ NIL))
        (PROG ($ |func|)
          (LETT $ (QREFELT $$ 1))
          (LETT |func| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL (SPADCALL |l1| (QREFELT $ 11)) |func|))))) 

(SDEFUN |BOP1;evaluate;BoU;2|
        ((|op| (|BasicOperator|))
         ($ (|Union| (|Mapping| A (|List| A)) "failed")))
        (SPROG ((|func| (|Union| (|None|) "failed")))
               (SEQ (LETT |func| (SPADCALL |op| (QREFELT $ 7) (QREFELT $ 19)))
                    (EXIT
                     (COND ((QEQCAR |func| 1) (CONS 1 "failed"))
                           ('T (CONS 0 (QCDR |func|)))))))) 

(SDEFUN |BOP1;evaluate;BoLU;3|
        ((|op| (|BasicOperator|)) (|args| (|List| A)) ($ (|Union| A "failed")))
        (SPROG ((|func| (|Union| (|None|) "failed")))
               (SEQ (LETT |func| (SPADCALL |op| (QREFELT $ 7) (QREFELT $ 19)))
                    (EXIT
                     (COND ((QEQCAR |func| 1) (CONS 1 "failed"))
                           ('T (CONS 0 (SPADCALL |args| (QCDR |func|))))))))) 

(SDEFUN |BOP1;evaluate;BoMBo;4|
        ((|op| (|BasicOperator|)) (|func| (|Mapping| A (|List| A)))
         ($ (|BasicOperator|)))
        (SPADCALL |op| (QREFELT $ 7) |func| (QREFELT $ 25))) 

(SDEFUN |BOP1;derivative;BoU;5|
        ((|op| (|BasicOperator|))
         ($ (|Union| (|List| (|Mapping| A (|List| A))) "failed")))
        (SPROG ((|func| (|Union| (|None|) "failed")))
               (SEQ (LETT |func| (SPADCALL |op| (QREFELT $ 9) (QREFELT $ 19)))
                    (EXIT
                     (COND ((QEQCAR |func| 1) (CONS 1 "failed"))
                           ('T (CONS 0 (QCDR |func|)))))))) 

(SDEFUN |BOP1;derivative;BoLBo;6|
        ((|op| (|BasicOperator|)) (|grad| (|List| (|Mapping| A (|List| A))))
         ($ (|BasicOperator|)))
        (SPADCALL |op| (QREFELT $ 9) |grad| (QREFELT $ 25))) 

(SDEFUN |BOP1;derivative;BoMBo;7|
        ((|op| (|BasicOperator|)) (|f| (|Mapping| A A)) ($ (|BasicOperator|)))
        (SPROG NIL
               (COND
                ((OR (SPADCALL |op| (QREFELT $ 31))
                     (SPADCALL |op| (QREFELT $ 32)))
                 (SPADCALL |op|
                           (LIST
                            (CONS #'|BOP1;derivative;BoMBo;7!0|
                                  (VECTOR |f| $)))
                           (QREFELT $ 29)))
                ('T (|error| "Operator is not unary"))))) 

(SDEFUN |BOP1;derivative;BoMBo;7!0| ((|l1| NIL) ($$ NIL))
        (PROG ($ |f|)
          (LETT $ (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL (SPADCALL |l1| (QREFELT $ 11)) |f|))))) 

(PUT '|BOP1;cdisp| '|SPADreplace| '(XLAM (|a| |l|) |a|)) 

(SDEFUN |BOP1;cdisp|
        ((|a| (|OutputForm|)) (|l| (|List| (|OutputForm|))) ($ (|OutputForm|)))
        |a|) 

(PUT '|BOP1;csex| '|SPADreplace| '(XLAM (|a| |l|) |a|)) 

(SDEFUN |BOP1;csex|
        ((|a| (|InputForm|)) (|l| (|List| (|InputForm|))) ($ (|InputForm|)))
        |a|) 

(SDEFUN |BOP1;eqconst?|
        ((|a| (|BasicOperator|)) (|b| (|BasicOperator|)) ($ (|Boolean|)))
        (SPROG ((|vb| #1=(|Union| (|None|) "failed")) (|va| #1#))
               (SEQ (LETT |va| (SPADCALL |a| (QREFELT $ 8) (QREFELT $ 19)))
                    (EXIT
                     (COND
                      ((QEQCAR |va| 1)
                       (NULL (SPADCALL |b| (QREFELT $ 8) (QREFELT $ 34))))
                      (#2='T
                       (SEQ
                        (LETT |vb| (SPADCALL |b| (QREFELT $ 8) (QREFELT $ 19)))
                        (EXIT
                         (COND
                          ((QEQCAR |vb| 0)
                           (SPADCALL (QCDR |va|) (QCDR |vb|) (QREFELT $ 35)))
                          (#2# NIL)))))))))) 

(SDEFUN |BOP1;ltconst?|
        ((|a| (|BasicOperator|)) (|b| (|BasicOperator|)) ($ (|Boolean|)))
        (SPROG ((|vb| #1=(|Union| (|None|) "failed")) (|va| #1#))
               (SEQ (LETT |va| (SPADCALL |a| (QREFELT $ 8) (QREFELT $ 19)))
                    (EXIT
                     (COND
                      ((QEQCAR |va| 1)
                       (SPADCALL |b| (QREFELT $ 8) (QREFELT $ 34)))
                      (#2='T
                       (SEQ
                        (LETT |vb| (SPADCALL |b| (QREFELT $ 8) (QREFELT $ 19)))
                        (EXIT
                         (COND
                          ((QEQCAR |vb| 0)
                           (SPADCALL (QCDR |va|) (QCDR |vb|) (QREFELT $ 36)))
                          (#2# NIL)))))))))) 

(SDEFUN |BOP1;constOp| ((|a| (A)) ($ (|BasicOperator|)))
        (SPROG NIL
               (SPADCALL
                (SPADCALL (SPADCALL (QREFELT $ 42) (QREFELT $ 43))
                          (CONS #'|BOP1;constOp!0| (VECTOR $ |a|))
                          (QREFELT $ 47))
                (QREFELT $ 8) |a| (QREFELT $ 25)))) 

(SDEFUN |BOP1;constOp!0| ((|l1| NIL) ($$ NIL))
        (PROG (|a| $)
          (LETT |a| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|BOP1;cdisp| (SPADCALL |a| (QREFELT $ 45)) |l1| $))))) 

(SDEFUN |BOP1;constantOpIfCan;BoU;13|
        ((|op| (|BasicOperator|)) ($ (|Union| A "failed")))
        (SPROG ((#1=#:G926 NIL) (|u| (|Union| (|None|) "failed")))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |op| '|constant| (QREFELT $ 48))
                    (SEQ
                     (LETT |u| (SPADCALL |op| (QREFELT $ 8) (QREFELT $ 19)))
                     (EXIT
                      (COND
                       ((QEQCAR |u| 0)
                        (PROGN
                         (LETT #1# (CONS 0 (QCDR |u|)))
                         (GO #2=#:G924))))))))
                  (EXIT (CONS 1 "failed"))))
                #2# (EXIT #1#)))) 

(SDEFUN |BOP1;constantOperator;ABo;14| ((|a| (A)) ($ (|BasicOperator|)))
        (SPROG NIL
               (SPADCALL (|BOP1;constOp| |a| $)
                         (CONS #'|BOP1;constantOperator;ABo;14!0|
                               (VECTOR $ |a|))
                         (QREFELT $ 53)))) 

(SDEFUN |BOP1;constantOperator;ABo;14!0| ((|l1| NIL) ($$ NIL))
        (PROG (|a| $)
          (LETT |a| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|BOP1;csex| (SPADCALL |a| (QREFELT $ 51)) |l1| $))))) 

(SDEFUN |BOP1;constantOperator;ABo;15| ((|a| (A)) ($ (|BasicOperator|)))
        (|BOP1;constOp| |a| $)) 

(DECLAIM (NOTINLINE |BasicOperatorFunctions1;|)) 

(DEFUN |BasicOperatorFunctions1| (#1=#:G930)
  (SPROG NIL
         (PROG (#2=#:G931)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|BasicOperatorFunctions1|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|BasicOperatorFunctions1;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|BasicOperatorFunctions1|)))))))))) 

(DEFUN |BasicOperatorFunctions1;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|BasicOperatorFunctions1| DV$1))
          (LETT $ (GETREFV 55))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|BasicOperatorFunctions1|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 '|%eval|)
          (QSETREFV $ 8 '|%constant|)
          (QSETREFV $ 9 '|%diff|)
          (COND
           ((|HasCategory| |#1| '(|Comparable|))
            (PROGN
             (QSETREFV $ 42
                       (SPADCALL
                        (SPADCALL (SPADCALL '|constant| 0 (QREFELT $ 38))
                                  (CONS (|function| |BOP1;eqconst?|) $)
                                  (QREFELT $ 40))
                        (CONS (|function| |BOP1;ltconst?|) $)
                        (QREFELT $ 41)))))
           ('T
            (SETELT $ 42
                    (SPADCALL (SPADCALL '|constant| 0 (QREFELT $ 38))
                              (CONS (|function| |BOP1;eqconst?|) $)
                              (QREFELT $ 40)))))
          (COND
           ((|HasCategory| |#1| '(|ConvertibleTo| (|InputForm|)))
            (QSETREFV $ 54
                      (CONS (|dispatchFunction| |BOP1;constantOperator;ABo;14|)
                            $)))
           ('T
            (QSETREFV $ 54
                      (CONS (|dispatchFunction| |BOP1;constantOperator;ABo;15|)
                            $))))
          $))) 

(MAKEPROP '|BasicOperatorFunctions1| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) 'EVAL 'CONST 'DIFF
              (|List| 6) (0 . |first|) (|BasicOperator|) (|Mapping| 6 10)
              |BOP1;evaluate;BoMBo;4| (|Mapping| 6 6) |BOP1;evaluate;BoMBo;1|
              (|Union| 24 '"failed") (|Symbol|) (5 . |property|)
              (|Union| 13 '#1="failed") |BOP1;evaluate;BoU;2|
              (|Union| 6 '#2="failed") |BOP1;evaluate;BoLU;3| (|None|)
              (11 . |setProperty|) (|Union| 28 '#3="failed")
              |BOP1;derivative;BoU;5| (|List| 13) |BOP1;derivative;BoLBo;6|
              (|Boolean|) (18 . |unary?|) (23 . |nary?|)
              |BOP1;derivative;BoMBo;7| (28 . |has?|) (34 . =)
              (40 . |smaller?|) (|NonNegativeInteger|) (46 . |operator|)
              (|Mapping| 30 $ $) (52 . |equality|) (58 . |comparison|)
              '|opconst| (64 . |copy|) (|OutputForm|) (69 . |coerce|)
              (|Mapping| 44 (|List| 44)) (74 . |display|) (80 . |is?|)
              |BOP1;constantOpIfCan;BoU;13| (|InputForm|) (86 . |convert|)
              (|Mapping| 50 (|List| 50)) (91 . |input|)
              (97 . |constantOperator|))
           '#(|evaluate| 102 |derivative| 125 |constantOperator| 142
              |constantOpIfCan| 147)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|evaluate|
                                 ((|Union| |#1| #2#) (|BasicOperator|)
                                  (|List| |#1|)))
                                T)
                              '((|evaluate|
                                 ((|BasicOperator|) (|BasicOperator|)
                                  (|Mapping| |#1| (|List| |#1|))))
                                T)
                              '((|evaluate|
                                 ((|BasicOperator|) (|BasicOperator|)
                                  (|Mapping| |#1| |#1|)))
                                T)
                              '((|evaluate|
                                 ((|Union| (|Mapping| |#1| (|List| |#1|)) #1#)
                                  (|BasicOperator|)))
                                T)
                              '((|derivative|
                                 ((|BasicOperator|) (|BasicOperator|)
                                  (|List| (|Mapping| |#1| (|List| |#1|)))))
                                T)
                              '((|derivative|
                                 ((|BasicOperator|) (|BasicOperator|)
                                  (|Mapping| |#1| |#1|)))
                                T)
                              '((|derivative|
                                 ((|Union|
                                   (|List| (|Mapping| |#1| (|List| |#1|))) #3#)
                                  (|BasicOperator|)))
                                T)
                              '((|constantOperator| ((|BasicOperator|) |#1|))
                                T)
                              '((|constantOpIfCan|
                                 ((|Union| |#1| "failed") (|BasicOperator|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 54
                                            '(1 10 6 0 11 2 12 17 0 18 19 3 12
                                              0 0 18 24 25 1 12 30 0 31 1 12 30
                                              0 32 2 12 30 0 18 34 2 6 30 0 0
                                              35 2 6 30 0 0 36 2 12 0 18 37 38
                                              2 12 0 0 39 40 2 12 0 0 39 41 1
                                              12 0 0 43 1 6 44 0 45 2 12 0 0 46
                                              47 2 12 30 0 18 48 1 6 50 0 51 2
                                              12 0 0 52 53 1 0 12 6 54 2 0 12
                                              12 13 14 2 0 22 12 10 23 1 0 20
                                              12 21 2 0 12 12 15 16 2 0 12 12
                                              15 33 2 0 12 12 28 29 1 0 26 12
                                              27 1 0 12 6 54 1 0 22 12 49)))))
           '|lookupComplete|)) 
