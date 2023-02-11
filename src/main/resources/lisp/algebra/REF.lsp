
(PUT '|REF;=;2$B;1| '|SPADreplace| 'EQ) 

(SDEFUN |REF;=;2$B;1| ((|p| ($)) (|q| ($)) ($ (|Boolean|))) (EQ |p| |q|)) 

(PUT '|REF;ref;S$;2| '|SPADreplace| 'LIST) 

(SDEFUN |REF;ref;S$;2| ((|v| (S)) ($ ($))) (LIST |v|)) 

(PUT '|REF;elt;$S;3| '|SPADreplace| 'QCAR) 

(SDEFUN |REF;elt;$S;3| ((|p| ($)) ($ (S))) (QCAR |p|)) 

(SDEFUN |REF;setelt!;$2S;4| ((|p| ($)) (|v| (S)) ($ (S)))
        (PROGN (RPLACA |p| |v|) (QCAR |p|))) 

(PUT '|REF;deref;$S;5| '|SPADreplace| 'QCAR) 

(SDEFUN |REF;deref;$S;5| ((|p| ($)) ($ (S))) (QCAR |p|)) 

(SDEFUN |REF;setref;$2S;6| ((|p| ($)) (|v| (S)) ($ (S)))
        (PROGN (RPLACA |p| |v|) (QCAR |p|))) 

(SDEFUN |REF;coerce;$Of;7| ((|p| ($)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL "ref" (QREFELT $ 17))
                  (LIST (SPADCALL (QCAR |p|) (QREFELT $ 18))) (QREFELT $ 20))) 

(DECLAIM (NOTINLINE |Reference;|)) 

(DEFUN |Reference| (#1=#:G2592)
  (SPROG NIL
         (PROG (#2=#:G2593)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Reference|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Reference;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|Reference|)))))))))) 

(DEFUN |Reference;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|Reference| DV$1))
          (LETT $ (GETREFV 24))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|SetCategory|))))))
          (|haddProp| |$ConstructorCache| '|Reference| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 (|Record| (|:| |value| |#1|)))
          (COND
           ((|testBitVector| |pv$| 1)
            (QSETREFV $ 21 (CONS (|dispatchFunction| |REF;coerce;$Of;7|) $))))
          $))) 

(MAKEPROP '|Reference| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|Boolean|)
              |REF;=;2$B;1| |REF;ref;S$;2| |REF;elt;$S;3| |REF;setelt!;$2S;4|
              |REF;deref;$S;5| |REF;setref;$2S;6| (|String|) (|OutputForm|)
              (0 . |message|) (5 . |coerce|) (|List| $) (10 . |prefix|)
              (16 . |coerce|) (|HashState|) (|SingleInteger|))
           '#(~= 21 |setref| 27 |setelt!| 33 |ref| 39 |latex| 44 |hashUpdate!|
              49 |hash| 55 |elt| 60 |deref| 65 |coerce| 70 = 75)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(1 0 1 1))
                 (CONS '#(|SetCategory&| NIL |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|Type|) (|BasicType|)
                           (|CoercibleTo| 16))
                        (|makeByteWordVec2| 23
                                            '(1 16 0 15 17 1 6 16 0 18 2 16 0 0
                                              19 20 1 0 16 0 21 2 1 8 0 0 1 2 0
                                              6 0 6 14 2 0 6 0 6 12 1 0 0 6 10
                                              1 1 15 0 1 2 1 22 22 0 1 1 1 23 0
                                              1 1 0 6 0 11 1 0 6 0 13 1 1 16 0
                                              21 2 0 8 0 0 9)))))
           '|lookupComplete|)) 
