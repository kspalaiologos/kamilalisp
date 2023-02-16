
(PUT '|MKUCFUNC;func| '|SPADreplace|
     '(XLAM (|name| |x|) (FUNCALL |name| |x| NIL))) 

(SDEFUN |MKUCFUNC;func| ((|name| (|Symbol|)) (|x| (D)) ($ (I)))
        (FUNCALL |name| |x| NIL)) 

(SDEFUN |MKUCFUNC;unaryFunction;SM;2| ((|name| (|Symbol|)) ($ (|Mapping| I D)))
        (SPROG NIL (CONS #'|MKUCFUNC;unaryFunction;SM;2!0| (VECTOR $ |name|)))) 

(SDEFUN |MKUCFUNC;unaryFunction;SM;2!0| ((|d1| NIL) ($$ NIL))
        (PROG (|name| $)
          (LETT |name| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|MKUCFUNC;func| |name| |d1| $))))) 

(SDEFUN |MKUCFUNC;compiledFunction;SSM;3|
        ((|e| (S)) (|x| (|Symbol|)) ($ (|Mapping| I D)))
        (SPROG ((|t| (|List| (|InputForm|))))
               (SEQ
                (LETT |t|
                      (LIST
                       (SPADCALL
                        (SPADCALL (|devaluate| (QREFELT $ 7)) (QREFELT $ 13))
                        (QREFELT $ 16))))
                (EXIT
                 (SPADCALL
                  (SPADCALL
                   (SPADCALL |e|
                             (SPADCALL
                              (|devaluate|
                               (|Mapping| (QREFELT $ 8) (QREFELT $ 7)))
                              (QREFELT $ 17))
                             |x| (QREFELT $ 19))
                   |t| (QREFELT $ 20))
                  (QREFELT $ 11)))))) 

(DECLAIM (NOTINLINE |MakeUnaryCompiledFunction;|)) 

(DEFUN |MakeUnaryCompiledFunction| (&REST #1=#:G707)
  (SPROG NIL
         (PROG (#2=#:G708)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|MakeUnaryCompiledFunction|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |MakeUnaryCompiledFunction;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|MakeUnaryCompiledFunction|)))))))))) 

(DEFUN |MakeUnaryCompiledFunction;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|MakeUnaryCompiledFunction| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 22))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|MakeUnaryCompiledFunction|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|MakeUnaryCompiledFunction| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Mapping| 8 7) (|Symbol|)
              |MKUCFUNC;unaryFunction;SM;2| (|List| 15) (0 . |construct|)
              (|List| $) (|InputForm|) (5 . |convert|) (10 . |declare|)
              (|MakeFunction| 6) (15 . |function|) (22 . |compile|)
              |MKUCFUNC;compiledFunction;SSM;3|)
           '#(|unaryFunction| 28 |compiledFunction| 33) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|unaryFunction|
                                 ((|Mapping| |#3| |#2|) (|Symbol|)))
                                T)
                              '((|compiledFunction|
                                 ((|Mapping| |#3| |#2|) |#1| (|Symbol|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 21
                                            '(1 12 0 12 13 1 15 0 14 16 1 15 10
                                              14 17 3 18 10 6 10 10 19 2 15 10
                                              10 14 20 1 0 9 10 11 2 0 9 6 10
                                              21)))))
           '|lookupComplete|)) 
