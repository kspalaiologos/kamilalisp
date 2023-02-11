
(SDEFUN |QEQUAT;coerce;$Of;1| ((|u| ($)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL (QCAR |u|) (QREFELT $ 9))
                  (SPADCALL (QCDR |u|) (QREFELT $ 11)) (QREFELT $ 12))) 

(PUT '|QEQUAT;equation;SS$;2| '|SPADreplace| 'CONS) 

(SDEFUN |QEQUAT;equation;SS$;2| ((|x| (|Symbol|)) (|s| (|String|)) ($ ($)))
        (CONS |x| |s|)) 

(PUT '|QEQUAT;variable;$S;3| '|SPADreplace| 'QCAR) 

(SDEFUN |QEQUAT;variable;$S;3| ((|q| ($)) ($ (|Symbol|))) (QCAR |q|)) 

(PUT '|QEQUAT;value;$S;4| '|SPADreplace| 'QCDR) 

(SDEFUN |QEQUAT;value;$S;4| ((|q| ($)) ($ (|String|))) (QCDR |q|)) 

(DECLAIM (NOTINLINE |QueryEquation;|)) 

(DEFUN |QueryEquation| ()
  (SPROG NIL
         (PROG (#1=#:G710)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|QueryEquation|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|QueryEquation|
                             (LIST (CONS NIL (CONS 1 (|QueryEquation;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|QueryEquation|)))))))))) 

(DEFUN |QueryEquation;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|QueryEquation|))
          (LETT $ (GETREFV 17))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|QueryEquation| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |var| (|Symbol|)) (|:| |val| (|String|))))
          $))) 

(MAKEPROP '|QueryEquation| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|OutputForm|) (|Symbol|)
              (0 . |coerce|) (|String|) (5 . |coerce|) (10 . =)
              |QEQUAT;coerce;$Of;1| |QEQUAT;equation;SS$;2|
              |QEQUAT;variable;$S;3| |QEQUAT;value;$S;4|)
           '#(|variable| 16 |value| 21 |equation| 26 |coerce| 32) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS '#((|CoercibleTo| 7))
                             (|makeByteWordVec2| 16
                                                 '(1 8 7 0 9 1 10 7 0 11 2 7 0
                                                   0 0 12 1 0 8 0 15 1 0 10 0
                                                   16 2 0 0 8 10 14 1 0 7 0
                                                   13)))))
           '|lookupComplete|)) 

(MAKEPROP '|QueryEquation| 'NILADIC T) 
