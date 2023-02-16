
(SDEFUN |EXPRSOL;replaceDiffs;FBoSF;1|
        ((|expr| (F)) (|op| (|BasicOperator|)) (|sy| (|Symbol|)) ($ (F)))
        (SPROG
         ((|differentiand| (F)) (|args| (|List| F)) (|arg| (F)) (#1=#:G716 NIL)
          (|k| NIL) (|lk| (|List| (|Kernel| F))))
         (SEQ (LETT |lk| (SPADCALL |expr| (QREFELT $ 17)))
              (SEQ (LETT |k| NIL) (LETT #1# |lk|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (COND
                     ((SPADCALL |k| |op| (QREFELT $ 20))
                      (SEQ
                       (LETT |arg| (|SPADfirst| (SPADCALL |k| (QREFELT $ 22))))
                       (EXIT
                        (COND
                         ((SPADCALL |arg| (SPADCALL |sy| (QREFELT $ 23))
                                    (QREFELT $ 24))
                          (LETT |expr|
                                (SPADCALL |expr| (LIST |k|)
                                          (LIST
                                           (SPADCALL
                                            (SPADCALL |op| (QREFELT $ 25))
                                            (QREFELT $ 23)))
                                          (QREFELT $ 27))))
                         ('T
                          (LETT |expr|
                                (SPADCALL |expr| (LIST |k|)
                                          (LIST
                                           (SPADCALL (QREFELT $ 13)
                                                     (LIST
                                                      (SPADCALL
                                                       (SPADCALL |op|
                                                                 (QREFELT $
                                                                          25))
                                                       (QREFELT $ 23))
                                                      (SPADCALL |arg| |op| |sy|
                                                                (QREFELT $
                                                                         28)))
                                                     (QREFELT $ 29)))
                                          (QREFELT $ 27)))))))))
                    (EXIT
                     (COND
                      ((SPADCALL |k| '|%diff| (QREFELT $ 30))
                       (SEQ (LETT |args| (SPADCALL |k| (QREFELT $ 22)))
                            (LETT |differentiand|
                                  (SPADCALL
                                   (SPADCALL (SPADCALL |args| 1 (QREFELT $ 34))
                                             (SPADCALL
                                              (SPADCALL |args| 2
                                                        (QREFELT $ 34))
                                              (SPADCALL |args| 3
                                                        (QREFELT $ 34))
                                              (QREFELT $ 36))
                                             (QREFELT $ 38))
                                   |op| |sy| (QREFELT $ 28)))
                            (EXIT
                             (LETT |expr|
                                   (SPADCALL |expr| (LIST |k|)
                                             (LIST
                                              (SPADCALL (QREFELT $ 14)
                                                        |differentiand|
                                                        (QREFELT $ 39)))
                                             (QREFELT $ 27)))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |expr|)))) 

(SDEFUN |EXPRSOL;seriesSolve;FBoSLUTSF;2|
        ((|expr| (F)) (|op| (|BasicOperator|)) (|sy| (|Symbol|))
         (|l| (|List| F)) ($ (UTSF)))
        (SPROG ((|f| (|Mapping| UTSSMPF UTSSMPF UTSSMPF)) (|ex| (F)))
               (SEQ (LETT |ex| (SPADCALL |expr| |op| |sy| (QREFELT $ 28)))
                    (LETT |f|
                          (SPADCALL |ex| (SPADCALL |op| (QREFELT $ 25)) |sy|
                                    (QREFELT $ 42)))
                    (EXIT
                     (SPADCALL
                      (CONS #'|EXPRSOL;seriesSolve;FBoSLUTSF;2!0|
                            (VECTOR |f| $))
                      |l| (QREFELT $ 50)))))) 

(SDEFUN |EXPRSOL;seriesSolve;FBoSLUTSF;2!0| ((|x| NIL) ($$ NIL))
        (PROG ($ |f|)
          (LETT $ (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |x|
                      (SPADCALL (|spadConstant| $ 44) (|spadConstant| $ 46)
                                (QREFELT $ 47))
                      |f|))))) 

(DECLAIM (NOTINLINE |ExpressionSolve;|)) 

(DEFUN |ExpressionSolve| (&REST #1=#:G724)
  (SPROG NIL
         (PROG (#2=#:G725)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ExpressionSolve|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ExpressionSolve;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|ExpressionSolve|)))))))))) 

(DEFUN |ExpressionSolve;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|ExpressionSolve| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 52))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|ExpressionSolve|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 13 (SPADCALL '|elt| (QREFELT $ 12)))
    (QSETREFV $ 14 (SPADCALL 'D (QREFELT $ 12)))
    (QSETREFV $ 15 (SPADCALL '|coerce| (QREFELT $ 12)))
    $))) 

(MAKEPROP '|ExpressionSolve| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|Symbol|) (|BasicOperator|)
              (0 . |operator|) '|opelt| '|opdiff| '|opcoerce|
              (|List| (|Kernel| $)) (5 . |kernels|) (|Boolean|) (|Kernel| 7)
              (10 . |is?|) (|List| 7) (16 . |argument|) (21 . |coerce|)
              (26 . =) (32 . |name|) (|List| $) (37 . |subst|)
              |EXPRSOL;replaceDiffs;FBoSF;1| (44 . |elt|) (50 . |is?|)
              (56 . |One|) (60 . |One|) (|Integer|) (64 . |elt|) (|Equation| 7)
              (70 . =) (|Equation| $) (76 . |subst|) (82 . |elt|)
              (|Mapping| 9 9 9) (|MakeBinaryCompiledFunction| 7 9 9 9)
              (88 . |compiledFunction|)
              (|SparseMultivariatePolynomialExpressions| 7) (95 . |One|)
              (|NonNegativeInteger|) (99 . |One|) (103 . |monomial|)
              (|Mapping| 9 9) (|TaylorSolve| 7 8 9) (109 . |seriesSolve|)
              |EXPRSOL;seriesSolve;FBoSLUTSF;2|)
           '#(|seriesSolve| 115 |replaceDiffs| 123) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|seriesSolve|
                                 (|#3| |#2| (|BasicOperator|) (|Symbol|)
                                  (|List| |#2|)))
                                T)
                              '((|replaceDiffs|
                                 (|#2| |#2| (|BasicOperator|) (|Symbol|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 51
                                            '(1 11 0 10 12 1 7 16 0 17 2 19 18
                                              0 11 20 1 19 21 0 22 1 7 0 10 23
                                              2 7 18 0 0 24 1 11 10 0 25 3 7 0
                                              0 16 26 27 2 7 0 11 26 29 2 19 18
                                              0 10 30 0 6 0 31 0 7 0 32 2 21 7
                                              0 33 34 2 35 0 7 7 36 2 7 0 0 37
                                              38 2 7 0 11 0 39 3 41 40 7 10 10
                                              42 0 43 0 44 0 45 0 46 2 9 0 43
                                              45 47 2 49 8 48 21 50 4 0 8 7 11
                                              10 21 51 3 0 7 7 11 10 28)))))
           '|lookupComplete|)) 
