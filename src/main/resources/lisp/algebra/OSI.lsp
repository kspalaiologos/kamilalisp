
(PUT '|OSI;=;2$B;1| '|SPADreplace| 'EQL) 

(SDEFUN |OSI;=;2$B;1| ((|x| ($)) (|y| ($)) ($ (|Boolean|))) (EQL |x| |y|)) 

(PUT '|OSI;<;2$B;2| '|SPADreplace| '<) 

(SDEFUN |OSI;<;2$B;2| ((|x| ($)) (|y| ($)) ($ (|Boolean|))) (< |x| |y|)) 

(PUT '|OSI;coerce;I$;3| '|SPADreplace| '(XLAM (|i|) |i|)) 

(SDEFUN |OSI;coerce;I$;3| ((|i| (|Integer|)) ($ ($))) |i|) 

(PUT '|OSI;value;$I;4| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |OSI;value;$I;4| ((|x| ($)) ($ (|Integer|))) |x|) 

(SDEFUN |OSI;coerce;$Of;5| ((|x| ($)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL '|e| (QREFELT $ 15)) (SPADCALL |x| (QREFELT $ 16))
                  (QREFELT $ 17))) 

(DECLAIM (NOTINLINE |OrdSetInts;|)) 

(DEFUN |OrdSetInts| ()
  (SPROG NIL
         (PROG (#1=#:G709)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|OrdSetInts|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|OrdSetInts|
                             (LIST (CONS NIL (CONS 1 (|OrdSetInts;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|OrdSetInts|)))))))))) 

(DEFUN |OrdSetInts;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|OrdSetInts|))
          (LETT $ (GETREFV 22))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|OrdSetInts| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 (|Integer|))
          $))) 

(MAKEPROP '|OrdSetInts| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|Boolean|) |OSI;=;2$B;1|
              |OSI;<;2$B;2| (|Integer|) |OSI;coerce;I$;3| |OSI;value;$I;4|
              (|OutputForm|) (|Symbol|) (0 . |coerce|) (5 . |coerce|)
              (10 . |sub|) |OSI;coerce;$Of;5| (|HashState|) (|String|)
              (|SingleInteger|))
           '#(~= 16 |value| 22 |smaller?| 27 |min| 33 |max| 39 |latex| 45
              |hashUpdate!| 50 |hash| 56 |coerce| 61 >= 71 > 77 = 83 <= 89 <
              95)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0))
                 (CONS
                  '#(|OrderedSet&| NIL |SetCategory&| |BasicType&|
                     |PartialOrder&| NIL)
                  (CONS
                   '#((|OrderedSet|) (|Comparable|) (|SetCategory|)
                      (|BasicType|) (|PartialOrder|) (|CoercibleTo| 13))
                   (|makeByteWordVec2| 21
                                       '(1 14 13 0 15 1 6 13 0 16 2 13 0 0 0 17
                                         2 0 7 0 0 1 1 0 10 0 12 2 0 7 0 0 1 2
                                         0 0 0 0 1 2 0 0 0 0 1 1 0 20 0 1 2 0
                                         19 19 0 1 1 0 21 0 1 1 0 0 10 11 1 0
                                         13 0 18 2 0 7 0 0 1 2 0 7 0 0 1 2 0 7
                                         0 0 8 2 0 7 0 0 1 2 0 7 0 0 9)))))
           '|lookupComplete|)) 

(MAKEPROP '|OrdSetInts| 'NILADIC T) 
