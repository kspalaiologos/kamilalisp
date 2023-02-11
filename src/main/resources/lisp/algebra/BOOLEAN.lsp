
(PUT '|BOOLEAN;test;2$;1| '|SPADreplace| '(XLAM (|a|) |a|)) 

(SDEFUN |BOOLEAN;test;2$;1| ((|a| ($)) ($ (|Boolean|))) |a|) 

(SDEFUN |BOOLEAN;nt| ((|b| ($)) ($ ($))) (COND (|b| 'NIL) ('T 'T))) 

(PUT '|BOOLEAN;true;$;3| '|SPADreplace| '(XLAM NIL 'T)) 

(SDEFUN |BOOLEAN;true;$;3| (($ ($))) 'T) 

(PUT '|BOOLEAN;false;$;4| '|SPADreplace| '(XLAM NIL NIL)) 

(SDEFUN |BOOLEAN;false;$;4| (($ ($))) NIL) 

(PUT '|BOOLEAN;not;2$;5| '|SPADreplace| 'NOT) 

(SDEFUN |BOOLEAN;not;2$;5| ((|b| ($)) ($ ($))) (NOT |b|)) 

(PUT '|BOOLEAN;~;2$;6| '|SPADreplace| 'NOT) 

(SDEFUN |BOOLEAN;~;2$;6| ((|b| ($)) ($ ($))) (NOT |b|)) 

(PUT '|BOOLEAN;and;3$;7| '|SPADreplace| 'AND) 

(SDEFUN |BOOLEAN;and;3$;7| ((|a| ($)) (|b| ($)) ($ ($))) (AND |a| |b|)) 

(PUT '|BOOLEAN;/\\;3$;8| '|SPADreplace| 'AND) 

(SDEFUN |BOOLEAN;/\\;3$;8| ((|a| ($)) (|b| ($)) ($ ($))) (AND |a| |b|)) 

(PUT '|BOOLEAN;or;3$;9| '|SPADreplace| 'OR) 

(SDEFUN |BOOLEAN;or;3$;9| ((|a| ($)) (|b| ($)) ($ ($))) (OR |a| |b|)) 

(PUT '|BOOLEAN;\\/;3$;10| '|SPADreplace| 'OR) 

(SDEFUN |BOOLEAN;\\/;3$;10| ((|a| ($)) (|b| ($)) ($ ($))) (OR |a| |b|)) 

(SDEFUN |BOOLEAN;xor;3$;11| ((|a| ($)) (|b| ($)) ($ ($)))
        (COND (|a| (|BOOLEAN;nt| |b| $)) ('T |b|))) 

(SDEFUN |BOOLEAN;nor;3$;12| ((|a| ($)) (|b| ($)) ($ ($)))
        (COND (|a| 'NIL) ('T (|BOOLEAN;nt| |b| $)))) 

(SDEFUN |BOOLEAN;nand;3$;13| ((|a| ($)) (|b| ($)) ($ ($)))
        (COND (|a| (|BOOLEAN;nt| |b| $)) ('T 'T))) 

(PUT '|BOOLEAN;=;3$;14| '|SPADreplace| '|BooleanEquality|) 

(SDEFUN |BOOLEAN;=;3$;14| ((|a| ($)) (|b| ($)) ($ (|Boolean|)))
        (|BooleanEquality| |a| |b|)) 

(SDEFUN |BOOLEAN;implies;3$;15| ((|a| ($)) (|b| ($)) ($ ($)))
        (COND (|a| |b|) ('T 'T))) 

(SDEFUN |BOOLEAN;<;3$;16| ((|a| ($)) (|b| ($)) ($ (|Boolean|)))
        (COND (|b| (NULL |a|)) ('T NIL))) 

(PUT '|BOOLEAN;size;Nni;17| '|SPADreplace| '(XLAM NIL 2)) 

(SDEFUN |BOOLEAN;size;Nni;17| (($ (|NonNegativeInteger|))) 2) 

(SDEFUN |BOOLEAN;index;Pi$;18| ((|i| (|PositiveInteger|)) ($ ($)))
        (COND ((EVENP |i|) 'NIL) ('T 'T))) 

(SDEFUN |BOOLEAN;lookup;$Pi;19| ((|a| ($)) ($ (|PositiveInteger|)))
        (COND (|a| 1) ('T 2))) 

(SDEFUN |BOOLEAN;random;$;20| (($ ($)))
        (COND ((EVENP (RANDOM 2)) 'NIL) ('T 'T))) 

(SDEFUN |BOOLEAN;convert;$If;21| ((|x| ($)) ($ (|InputForm|)))
        (COND (|x| (SPADCALL '|true| (QREFELT $ 30)))
              ('T (SPADCALL '|false| (QREFELT $ 30))))) 

(SDEFUN |BOOLEAN;coerce;$Of;22| ((|x| ($)) ($ (|OutputForm|)))
        (COND (|x| (SPADCALL "true" (QREFELT $ 34)))
              ('T (SPADCALL "false" (QREFELT $ 34))))) 

(DECLAIM (NOTINLINE |Boolean;|)) 

(DEFUN |Boolean| ()
  (SPROG NIL
         (PROG (#1=#:G980)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|Boolean|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|Boolean|
                             (LIST (CONS NIL (CONS 1 (|Boolean;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|Boolean|)))))))))) 

(DEFUN |Boolean;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|Boolean|))
          (LETT $ (GETREFV 39))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Boolean| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|Boolean| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Boolean|) |BOOLEAN;test;2$;1|
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |BOOLEAN;true;$;3|) $))
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |BOOLEAN;false;$;4|) $))
              |BOOLEAN;not;2$;5| |BOOLEAN;~;2$;6| |BOOLEAN;and;3$;7|
              |BOOLEAN;/\\;3$;8| |BOOLEAN;or;3$;9| |BOOLEAN;\\/;3$;10|
              |BOOLEAN;xor;3$;11| |BOOLEAN;nor;3$;12| |BOOLEAN;nand;3$;13|
              |BOOLEAN;=;3$;14| |BOOLEAN;implies;3$;15| |BOOLEAN;<;3$;16|
              (|NonNegativeInteger|) |BOOLEAN;size;Nni;17| (|PositiveInteger|)
              |BOOLEAN;index;Pi$;18| |BOOLEAN;lookup;$Pi;19|
              |BOOLEAN;random;$;20| (|Symbol|) (|InputForm|) (0 . |convert|)
              |BOOLEAN;convert;$If;21| (|String|) (|OutputForm|)
              (5 . |message|) |BOOLEAN;coerce;$Of;22| (|List| $)
              (|SingleInteger|) (|HashState|))
           '#(~= 10 ~ 16 |xor| 21 |true| 27 |test| 31 |smaller?| 36 |size| 42
              |random| 46 |or| 50 |not| 56 |nor| 61 |nand| 67 |min| 73 |max| 79
              |lookup| 85 |latex| 90 |index| 95 |implies| 100 |hashUpdate!| 106
              |hash| 112 |false| 117 |enumerate| 121 |convert| 125 |coerce| 130
              |and| 135 |_\|_| 141 |\\/| 145 T$ 151 >= 155 > 161 = 167 <= 173 <
              179 |/\\| 185)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
                 (CONS
                  '#(|Logic&| NIL NIL NIL |OrderedSet&| NIL NIL NIL |Finite&|
                     NIL NIL NIL |SetCategory&| NIL |BasicType&|
                     |PartialOrder&| NIL)
                  (CONS
                   '#((|Logic|) (|BoundedDistributiveLattice|)
                      (|DistributiveLattice|) (|BoundedLattice|) (|OrderedSet|)
                      (|Lattice|) (|BoundedJoinSemilattice|)
                      (|BoundedMeetSemilattice|) (|Finite|) (|Comparable|)
                      (|JoinSemilattice|) (|MeetSemilattice|) (|SetCategory|)
                      (|ConvertibleTo| 29) (|BasicType|) (|PartialOrder|)
                      (|CoercibleTo| 33))
                   (|makeByteWordVec2| 38
                                       '(1 29 0 28 30 1 33 0 32 34 2 0 6 0 0 1
                                         1 0 0 0 11 2 0 0 0 0 16 0 0 0 8 1 0 6
                                         0 7 2 0 6 0 0 1 0 0 22 23 0 0 0 27 2 0
                                         0 0 0 14 1 0 0 0 10 2 0 0 0 0 17 2 0 0
                                         0 0 18 2 0 0 0 0 1 2 0 0 0 0 1 1 0 24
                                         0 26 1 0 32 0 1 1 0 0 24 25 2 0 0 0 0
                                         20 2 0 38 38 0 1 1 0 37 0 1 0 0 0 9 0
                                         0 36 1 1 0 29 0 31 1 0 33 0 35 2 0 0 0
                                         0 12 0 0 0 1 2 0 0 0 0 15 0 0 0 1 2 0
                                         6 0 0 1 2 0 6 0 0 1 2 0 6 0 0 19 2 0 6
                                         0 0 1 2 0 6 0 0 21 2 0 0 0 0 13)))))
           '|lookupComplete|)) 

(MAKEPROP '|Boolean| 'NILADIC T) 
