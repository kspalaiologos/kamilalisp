
(SDEFUN |RULECOLD;name;$S;1| ((|r| ($)) ($ (|Symbol|))) (QREFELT $ 6)) 

(SDEFUN |RULECOLD;coerce;$Of;2| ((|r| ($)) ($ (|OutputForm|)))
        (SPADCALL (QREFELT $ 6) (QREFELT $ 10))) 

(PUT '|RULECOLD;=;2$B;3| '|SPADreplace| '(XLAM (|x| |y|) 'T)) 

(SDEFUN |RULECOLD;=;2$B;3| ((|x| ($)) (|y| ($)) ($ (|Boolean|))) 'T) 

(SDEFUN |RULECOLD;latex;$S;4| ((|x| ($)) ($ (|String|)))
        (SPADCALL (QREFELT $ 6) (QREFELT $ 15))) 

(DECLAIM (NOTINLINE |RuleCalled;|)) 

(DEFUN |RuleCalled| (#1=#:G707)
  (SPROG NIL
         (PROG (#2=#:G708)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST #1#)
                                               (HGET |$ConstructorCache|
                                                     '|RuleCalled|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|RuleCalled;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|RuleCalled|)))))))))) 

(DEFUN |RuleCalled;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT |dv$| (LIST '|RuleCalled| DV$1))
          (LETT $ (GETREFV 19))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RuleCalled| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|RuleCalled| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Symbol|)
              |RULECOLD;name;$S;1| (|OutputForm|) (0 . |coerce|)
              |RULECOLD;coerce;$Of;2| (|Boolean|) |RULECOLD;=;2$B;3| (|String|)
              (5 . |latex|) |RULECOLD;latex;$S;4| (|HashState|)
              (|SingleInteger|))
           '#(~= 10 |name| 16 |latex| 21 |hashUpdate!| 26 |hash| 32 |coerce| 37
              = 42)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 9))
                        (|makeByteWordVec2| 18
                                            '(1 7 9 0 10 1 7 14 0 15 2 0 12 0 0
                                              1 1 0 7 0 8 1 0 14 0 16 2 0 17 17
                                              0 1 1 0 18 0 1 1 0 9 0 11 2 0 12
                                              0 0 13)))))
           '|lookupComplete|)) 
