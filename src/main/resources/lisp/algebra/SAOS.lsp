
(PUT '|SAOS;create;$;1| '|SPADreplace| '(XLAM NIL "?")) 

(SDEFUN |SAOS;create;$;1| (($ ($))) "?") 

(PUT '|SAOS;<;2$B;2| '|SPADreplace| '(XLAM (|a| |b|) NIL)) 

(SDEFUN |SAOS;<;2$B;2| ((|a| ($)) (|b| ($)) ($ (|Boolean|))) NIL) 

(SDEFUN |SAOS;coerce;$Of;3| ((|a| ($)) ($ (|OutputForm|)))
        (SPADCALL "?" (QREFELT $ 11))) 

(PUT '|SAOS;=;2$B;4| '|SPADreplace| '(XLAM (|a| |b|) 'T)) 

(SDEFUN |SAOS;=;2$B;4| ((|a| ($)) (|b| ($)) ($ (|Boolean|))) 'T) 

(PUT '|SAOS;min;3$;5| '|SPADreplace| '(XLAM (|a| |b|) |a|)) 

(SDEFUN |SAOS;min;3$;5| ((|a| ($)) (|b| ($)) ($ ($))) |a|) 

(PUT '|SAOS;max;3$;6| '|SPADreplace| '(XLAM (|a| |b|) |a|)) 

(SDEFUN |SAOS;max;3$;6| ((|a| ($)) (|b| ($)) ($ ($))) |a|) 

(SDEFUN |SAOS;convert;$S;7| ((|a| ($)) ($ (|Symbol|)))
        (SPADCALL "?" (QREFELT $ 17))) 

(DECLAIM (NOTINLINE |SingletonAsOrderedSet;|)) 

(DEFUN |SingletonAsOrderedSet| ()
  (SPROG NIL
         (PROG (#1=#:G711)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|SingletonAsOrderedSet|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|SingletonAsOrderedSet|
                             (LIST
                              (CONS NIL (CONS 1 (|SingletonAsOrderedSet;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|SingletonAsOrderedSet|)))))))))) 

(DEFUN |SingletonAsOrderedSet;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|SingletonAsOrderedSet|))
          (LETT $ (GETREFV 21))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|SingletonAsOrderedSet| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|SingletonAsOrderedSet| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL |SAOS;create;$;1| (|Boolean|)
              |SAOS;<;2$B;2| (|String|) (|OutputForm|) (0 . |outputForm|)
              |SAOS;coerce;$Of;3| |SAOS;=;2$B;4| |SAOS;min;3$;5|
              |SAOS;max;3$;6| (|Symbol|) (5 . |coerce|) |SAOS;convert;$S;7|
              (|HashState|) (|SingleInteger|))
           '#(~= 10 |smaller?| 16 |min| 22 |max| 28 |latex| 34 |hashUpdate!| 39
              |hash| 45 |create| 50 |convert| 54 |coerce| 59 >= 64 > 70 = 76 <=
              82 < 88)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0))
                 (CONS
                  '#(|OrderedSet&| NIL |SetCategory&| |BasicType&|
                     |PartialOrder&| NIL)
                  (CONS
                   '#((|OrderedSet|) (|Comparable|) (|SetCategory|)
                      (|BasicType|) (|PartialOrder|) (|CoercibleTo| 10))
                   (|makeByteWordVec2| 20
                                       '(1 10 0 9 11 1 16 0 9 17 2 0 7 0 0 1 2
                                         0 7 0 0 1 2 0 0 0 0 14 2 0 0 0 0 15 1
                                         0 9 0 1 2 0 19 19 0 1 1 0 20 0 1 0 0 0
                                         6 1 0 16 0 18 1 0 10 0 12 2 0 7 0 0 1
                                         2 0 7 0 0 1 2 0 7 0 0 13 2 0 7 0 0 1 2
                                         0 7 0 0 8)))))
           '|lookupComplete|)) 

(MAKEPROP '|SingletonAsOrderedSet| 'NILADIC T) 
