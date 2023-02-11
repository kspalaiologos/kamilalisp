
(SDEFUN |MKFUNC;function;S2S;1| ((|s| (S)) (|name| (|Symbol|)) ($ (|Symbol|)))
        (SPADCALL |s| |name| NIL (QREFELT $ 9))) 

(SDEFUN |MKFUNC;function;S3S;2|
        ((|s| (S)) (|name| (|Symbol|)) (|x| (|Symbol|)) ($ (|Symbol|)))
        (SPADCALL |s| |name| (LIST |x|) (QREFELT $ 9))) 

(SDEFUN |MKFUNC;function;S4S;3|
        ((|s| (S)) (|name| (|Symbol|)) (|x| (|Symbol|)) (|y| (|Symbol|))
         ($ (|Symbol|)))
        (SPADCALL |s| |name| (LIST |x| |y|) (QREFELT $ 9))) 

(SDEFUN |MKFUNC;function;SSLS;4|
        ((|s| (S)) (|name| (|Symbol|)) (|args| (|List| (|Symbol|)))
         ($ (|Symbol|)))
        (SEQ
         (SPADCALL
          (SPADCALL (SPADCALL |s| (QREFELT $ 14)) |args| |name| (QREFELT $ 15))
          (QREFELT $ 17))
         (EXIT |name|))) 

(DECLAIM (NOTINLINE |MakeFunction;|)) 

(DEFUN |MakeFunction| (#1=#:G698)
  (SPROG NIL
         (PROG (#2=#:G699)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|MakeFunction|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|MakeFunction;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|MakeFunction|)))))))))) 

(DEFUN |MakeFunction;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|MakeFunction| DV$1))
          (LETT $ (GETREFV 18))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|MakeFunction| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|MakeFunction| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Symbol|) (|List| 7)
              |MKFUNC;function;SSLS;4| |MKFUNC;function;S2S;1|
              |MKFUNC;function;S3S;2| |MKFUNC;function;S4S;3| (|InputForm|)
              (0 . |convert|) (5 . |function|) (|Any|) (12 . |interpret|))
           '#(|function| 17) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|function| ((|Symbol|) |#1| (|Symbol|))) T)
                              '((|function|
                                 ((|Symbol|) |#1| (|Symbol|) (|Symbol|)))
                                T)
                              '((|function|
                                 ((|Symbol|) |#1| (|Symbol|) (|Symbol|)
                                  (|Symbol|)))
                                T)
                              '((|function|
                                 ((|Symbol|) |#1| (|Symbol|)
                                  (|List| (|Symbol|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 17
                                            '(1 6 13 0 14 3 13 0 0 8 7 15 1 13
                                              16 0 17 3 0 7 6 7 7 11 2 0 7 6 7
                                              10 3 0 7 6 7 8 9 4 0 7 6 7 7 7
                                              12)))))
           '|lookupComplete|)) 
