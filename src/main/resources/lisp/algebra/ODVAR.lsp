
(PUT '|ODVAR;makeVariable;SNni$;1| '|SPADreplace| 'CONS) 

(SDEFUN |ODVAR;makeVariable;SNni$;1|
        ((|s| (S)) (|n| (|NonNegativeInteger|)) ($ ($))) (CONS |s| |n|)) 

(PUT '|ODVAR;variable;$S;2| '|SPADreplace| 'QCAR) 

(SDEFUN |ODVAR;variable;$S;2| ((|v| ($)) ($ (S))) (QCAR |v|)) 

(PUT '|ODVAR;order;$Nni;3| '|SPADreplace| 'QCDR) 

(SDEFUN |ODVAR;order;$Nni;3| ((|v| ($)) ($ (|NonNegativeInteger|))) (QCDR |v|)) 

(DECLAIM (NOTINLINE |OrderlyDifferentialVariable;|)) 

(DEFUN |OrderlyDifferentialVariable| (#1=#:G703)
  (SPROG NIL
         (PROG (#2=#:G704)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|OrderlyDifferentialVariable|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|OrderlyDifferentialVariable;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|OrderlyDifferentialVariable|)))))))))) 

(DEFUN |OrderlyDifferentialVariable;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|OrderlyDifferentialVariable| DV$1))
          (LETT $ (GETREFV 18))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OrderlyDifferentialVariable|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record| (|:| |var| |#1|)
                              (|:| |ord| (|NonNegativeInteger|))))
          $))) 

(MAKEPROP '|OrderlyDifferentialVariable| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep|
              (|NonNegativeInteger|) |ODVAR;makeVariable;SNni$;1|
              |ODVAR;variable;$S;2| |ODVAR;order;$Nni;3| (|Union| 6 '"failed")
              (|Boolean|) (|String|) (|SingleInteger|) (|HashState|)
              (|OutputForm|))
           '#(~= 0 |weight| 6 |variable| 11 |smaller?| 16 |retractIfCan| 22
              |retract| 27 |order| 32 |min| 37 |max| 43 |makeVariable| 49
              |latex| 55 |hashUpdate!| 60 |hash| 66 |differentiate| 71 |coerce|
              82 >= 92 > 98 = 104 <= 110 < 116)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0 0))
                 (CONS
                  '#(|DifferentialVariableCategory&| |OrderedSet&| NIL
                     |SetCategory&| |RetractableTo&| |BasicType&| NIL
                     |PartialOrder&| NIL)
                  (CONS
                   '#((|DifferentialVariableCategory| 6) (|OrderedSet|)
                      (|Comparable|) (|SetCategory|) (|RetractableTo| 6)
                      (|BasicType|) (|CoercibleFrom| 6) (|PartialOrder|)
                      (|CoercibleTo| 17))
                   (|makeByteWordVec2| 17
                                       '(2 0 13 0 0 1 1 0 8 0 1 1 0 6 0 10 2 0
                                         13 0 0 1 1 0 12 0 1 1 0 6 0 1 1 0 8 0
                                         11 2 0 0 0 0 1 2 0 0 0 0 1 2 0 0 6 8 9
                                         1 0 14 0 1 2 0 16 16 0 1 1 0 15 0 1 1
                                         0 0 0 1 2 0 0 0 8 1 1 0 0 6 1 1 0 17 0
                                         1 2 0 13 0 0 1 2 0 13 0 0 1 2 0 13 0 0
                                         1 2 0 13 0 0 1 2 0 13 0 0 1)))))
           '|lookupComplete|)) 
