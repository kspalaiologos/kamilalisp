
(SDEFUN |FUNCTION;name;$S;1| ((|r| ($)) ($ (|Symbol|))) (QREFELT $ 6)) 

(SDEFUN |FUNCTION;coerce;$Of;2| ((|r| ($)) ($ (|OutputForm|)))
        (|outputMapTran| (QREFELT $ 6) |r|)) 

(PUT '|FUNCTION;=;2$B;3| '|SPADreplace| '(XLAM (|x| |y|) 'T)) 

(SDEFUN |FUNCTION;=;2$B;3| ((|x| ($)) (|y| ($)) ($ (|Boolean|))) 'T) 

(SDEFUN |FUNCTION;latex;$S;4| ((|x| ($)) ($ (|String|)))
        (SPADCALL (QREFELT $ 6) (QREFELT $ 14))) 

(DECLAIM (NOTINLINE |FunctionCalled;|)) 

(DEFUN |FunctionCalled| (#1=#:G707)
  (SPROG NIL
         (PROG (#2=#:G708)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FunctionCalled|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|FunctionCalled;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FunctionCalled|)))))))))) 

(DEFUN |FunctionCalled;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT |dv$| (LIST '|FunctionCalled| DV$1))
          (LETT $ (GETREFV 18))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FunctionCalled| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FunctionCalled| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Symbol|)
              |FUNCTION;name;$S;1| (|OutputForm|) |FUNCTION;coerce;$Of;2|
              (|Boolean|) |FUNCTION;=;2$B;3| (|String|) (0 . |latex|)
              |FUNCTION;latex;$S;4| (|HashState|) (|SingleInteger|))
           '#(~= 5 |name| 11 |latex| 16 |hashUpdate!| 21 |hash| 27 |coerce| 32
              = 37)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 9))
                        (|makeByteWordVec2| 17
                                            '(1 7 13 0 14 2 0 11 0 0 1 1 0 7 0
                                              8 1 0 13 0 15 2 0 16 16 0 1 1 0
                                              17 0 1 1 0 9 0 10 2 0 11 0 0
                                              12)))))
           '|lookupComplete|)) 
