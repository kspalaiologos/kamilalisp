
(SDEFUN |FCOMP;sin;E$;1| ((|e| (E)) ($ ($))) (CONS 'T |e|)) 

(PUT '|FCOMP;cos;E$;2| '|SPADreplace| '(XLAM (|e|) (CONS NIL |e|))) 

(SDEFUN |FCOMP;cos;E$;2| ((|e| (E)) ($ ($))) (CONS NIL |e|)) 

(PUT '|FCOMP;sin?;$B;3| '|SPADreplace| 'QCAR) 

(SDEFUN |FCOMP;sin?;$B;3| ((|x| ($)) ($ (|Boolean|))) (QCAR |x|)) 

(PUT '|FCOMP;argument;$E;4| '|SPADreplace| 'QCDR) 

(SDEFUN |FCOMP;argument;$E;4| ((|x| ($)) ($ (E))) (QCDR |x|)) 

(SDEFUN |FCOMP;coerce;$Of;5| ((|x| ($)) ($ (|OutputForm|)))
        (SPADCALL
         (COND ((QCAR |x|) (SPADCALL "sin" (QREFELT $ 15)))
               ('T (SPADCALL "cos" (QREFELT $ 15))))
         (SPADCALL (SPADCALL (QCDR |x|) (QREFELT $ 16)) (QREFELT $ 17))
         (QREFELT $ 18))) 

(SDEFUN |FCOMP;<;2$B;6| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND ((SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 20)) 'T)
              ((OR (SPADCALL (QCDR |y|) (QCDR |x|) (QREFELT $ 20)) (QCAR |x|))
               NIL)
              ('T (QCAR |y|)))) 

(DECLAIM (NOTINLINE |FourierComponent;|)) 

(DEFUN |FourierComponent| (#1=#:G712)
  (SPROG NIL
         (PROG (#2=#:G713)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|FourierComponent|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|FourierComponent;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FourierComponent|)))))))))) 

(DEFUN |FourierComponent;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|FourierComponent| DV$1))
          (LETT $ (GETREFV 24))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FourierComponent| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record| (|:| |SinIfTrue| (|Boolean|)) (|:| |arg| |#1|)))
          $))) 

(MAKEPROP '|FourierComponent| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| |FCOMP;sin;E$;1|
              |FCOMP;cos;E$;2| (|Boolean|) |FCOMP;sin?;$B;3|
              |FCOMP;argument;$E;4| (|String|) (|OutputForm|) (0 . |message|)
              (5 . |coerce|) (10 . |bracket|) (15 . |hconcat|)
              |FCOMP;coerce;$Of;5| (21 . <) |FCOMP;<;2$B;6| (|SingleInteger|)
              (|HashState|))
           '#(~= 27 |smaller?| 33 |sin?| 39 |sin| 44 |min| 49 |max| 55 |latex|
              61 |hashUpdate!| 66 |hash| 72 |cos| 77 |coerce| 82 |argument| 87
              >= 92 > 98 = 104 <= 110 < 116)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0))
                 (CONS
                  '#(|OrderedSet&| NIL |SetCategory&| |BasicType&|
                     |PartialOrder&| NIL)
                  (CONS
                   '#((|OrderedSet|) (|Comparable|) (|SetCategory|)
                      (|BasicType|) (|PartialOrder|) (|CoercibleTo| 14))
                   (|makeByteWordVec2| 23
                                       '(1 14 0 13 15 1 6 14 0 16 1 14 0 0 17 2
                                         14 0 0 0 18 2 6 10 0 0 20 2 0 10 0 0 1
                                         2 0 10 0 0 1 1 0 10 0 11 1 0 0 6 8 2 0
                                         0 0 0 1 2 0 0 0 0 1 1 0 13 0 1 2 0 23
                                         23 0 1 1 0 22 0 1 1 0 0 6 9 1 0 14 0
                                         19 1 0 6 0 12 2 0 10 0 0 1 2 0 10 0 0
                                         1 2 0 10 0 0 1 2 0 10 0 0 1 2 0 10 0 0
                                         21)))))
           '|lookupComplete|)) 
