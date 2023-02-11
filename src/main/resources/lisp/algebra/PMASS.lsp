
(SDEFUN |PMASS;constant;SE;1| ((|x| (|Symbol|)) ($ (|Expression| (|Integer|))))
        (SPADCALL (SPADCALL |x| (QREFELT $ 8)) (QREFELT $ 10))) 

(SDEFUN |PMASS;multiple;SE;2| ((|x| (|Symbol|)) ($ (|Expression| (|Integer|))))
        (SPADCALL (SPADCALL |x| (QREFELT $ 8)) (QREFELT $ 12))) 

(SDEFUN |PMASS;optional;SE;3| ((|x| (|Symbol|)) ($ (|Expression| (|Integer|))))
        (SPADCALL (SPADCALL |x| (QREFELT $ 8)) (QREFELT $ 14))) 

(DECLAIM (NOTINLINE |PatternMatchAssertions;|)) 

(DEFUN |PatternMatchAssertions| ()
  (SPROG NIL
         (PROG (#1=#:G697)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|PatternMatchAssertions|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|PatternMatchAssertions|
                             (LIST
                              (CONS NIL
                                    (CONS 1 (|PatternMatchAssertions;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|PatternMatchAssertions|)))))))))) 

(DEFUN |PatternMatchAssertions;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|PatternMatchAssertions|))
          (LETT $ (GETREFV 16))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PatternMatchAssertions| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PatternMatchAssertions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Symbol|) (|Expression| (|Integer|))
              (0 . |coerce|) (|FunctionSpaceAssertions| (|Integer|) 7)
              (5 . |constant|) |PMASS;constant;SE;1| (10 . |multiple|)
              |PMASS;multiple;SE;2| (15 . |optional|) |PMASS;optional;SE;3|)
           '#(|optional| 20 |multiple| 25 |constant| 30) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|constant|
                                 ((|Expression| (|Integer|)) (|Symbol|)))
                                T)
                              '((|optional|
                                 ((|Expression| (|Integer|)) (|Symbol|)))
                                T)
                              '((|multiple|
                                 ((|Expression| (|Integer|)) (|Symbol|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 15
                                            '(1 7 0 6 8 1 9 7 7 10 1 9 7 7 12 1
                                              9 7 7 14 1 0 7 6 15 1 0 7 6 13 1
                                              0 7 6 11)))))
           '|lookupComplete|)) 

(MAKEPROP '|PatternMatchAssertions| 'NILADIC T) 
