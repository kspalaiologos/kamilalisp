
(SDEFUN |STACK;=;2$B;1| ((|s| ($)) (|t| ($)) ($ (|Boolean|)))
        (SPADCALL (SPADCALL |s| (QREFELT $ 9)) (SPADCALL |t| (QREFELT $ 9))
                  (QREFELT $ 11))) 

(SDEFUN |STACK;parts;$L;2| ((|s| ($)) ($ (|List| S)))
        (SPADCALL |s| (QREFELT $ 9))) 

(SDEFUN |STACK;map;M2$;3| ((|f| (|Mapping| S S)) (|s| ($)) ($ ($)))
        (SPADCALL (SPADCALL |f| (SPADCALL |s| (QREFELT $ 9)) (QREFELT $ 15))
                  (QREFELT $ 16))) 

(SDEFUN |STACK;map!;M2$;4| ((|f| (|Mapping| S S)) (|s| ($)) ($ ($)))
        (SEQ
         (SPADCALL |s|
                   (SPADCALL |f| (SPADCALL |s| (QREFELT $ 9)) (QREFELT $ 18))
                   (QREFELT $ 19))
         (EXIT |s|))) 

(SDEFUN |STACK;copy;2$;5| ((|s| ($)) ($ ($)))
        (SPADCALL (SPADCALL (SPADCALL |s| (QREFELT $ 9)) (QREFELT $ 21))
                  (QREFELT $ 16))) 

(SDEFUN |STACK;#;$Nni;6| ((|s| ($)) ($ (|NonNegativeInteger|)))
        (LENGTH (SPADCALL |s| (QREFELT $ 9)))) 

(SDEFUN |STACK;pop!;$S;7| ((|s| ($)) ($ (S)))
        (SPROG ((|e| (S)))
               (SEQ
                (COND ((SPADCALL |s| (QREFELT $ 25)) (|error| "empty stack"))
                      ('T
                       (SEQ
                        (LETT |e| (|SPADfirst| (SPADCALL |s| (QREFELT $ 9))))
                        (SPADCALL |s| (CDR (SPADCALL |s| (QREFELT $ 9)))
                                  (QREFELT $ 19))
                        (EXIT |e|))))))) 

(SDEFUN |STACK;extract!;$S;8| ((|s| ($)) ($ (S))) (SPADCALL |s| (QREFELT $ 26))) 

(SDEFUN |STACK;top;$S;9| ((|s| ($)) ($ (S)))
        (COND ((SPADCALL |s| (QREFELT $ 25)) (|error| "empty stack"))
              ('T (|SPADfirst| (SPADCALL |s| (QREFELT $ 9)))))) 

(SDEFUN |STACK;inspect;$S;10| ((|s| ($)) ($ (S))) (SPADCALL |s| (QREFELT $ 28))) 

(SDEFUN |STACK;push!;S$S;11| ((|e| (S)) (|s| ($)) ($ (S)))
        (SEQ
         (SPADCALL |s| (CONS |e| (SPADCALL |s| (QREFELT $ 9))) (QREFELT $ 19))
         (EXIT |e|))) 

(SDEFUN |STACK;insert!;S2$;12| ((|e| (S)) (|s| ($)) ($ ($)))
        (SEQ (SPADCALL |e| |s| (QREFELT $ 30)) (EXIT |s|))) 

(SDEFUN |STACK;empty;$;13| (($ ($))) (SPADCALL NIL (QREFELT $ 16))) 

(SDEFUN |STACK;empty?;$B;14| ((|s| ($)) ($ (|Boolean|)))
        (NULL (SPADCALL |s| (QREFELT $ 9)))) 

(SDEFUN |STACK;construct;L$;15| ((|s| (|List| S)) ($ ($)))
        (SPADCALL (SPADCALL |s| (QREFELT $ 21)) (QREFELT $ 16))) 

(SDEFUN |STACK;stack;L$;16| ((|s| (|List| S)) ($ ($)))
        (SPADCALL |s| (QREFELT $ 33))) 

(SDEFUN |STACK;hashUpdate!;Hs$Hs;17|
        ((|st| #1=(|HashState|)) (|s| ($)) ($ #1#))
        (SPADCALL |st| (SPADCALL |s| (QREFELT $ 9)) (QREFELT $ 36))) 

(DECLAIM (NOTINLINE |Stack;|)) 

(DEFUN |Stack| (#1=#:G737)
  (SPROG NIL
         (PROG (#2=#:G738)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Stack|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Stack;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Stack|)))))))))) 

(DEFUN |Stack;| (|#1|)
  (SPROG
   ((#1=#:G735 NIL) (#2=#:G736 NIL) (|pv$| NIL) (#3=#:G732 NIL) (#4=#:G733 NIL)
    (#5=#:G734 NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|Stack| DV$1))
    (LETT $ (GETREFV 48))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (LETT #5#
                                              (|HasCategory| |#1|
                                                             '(|SetCategory|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#1|)))
                                         #5#)
                                        (|HasCategory| |#1|
                                                       '(|ConvertibleTo|
                                                         (|InputForm|)))
                                        (|HasCategory| |#1| '(|OrderedSet|))
                                        (LETT #4#
                                              (|HasCategory| |#1|
                                                             '(|BasicType|)))
                                        (OR #4# #5#)
                                        (LETT #3#
                                              (|HasCategory| |#1|
                                                             '(|CoercibleTo|
                                                               (|OutputForm|))))
                                        (OR #3#
                                            (AND
                                             (|HasCategory| |#1|
                                                            (LIST '|Evalable|
                                                                  (|devaluate|
                                                                   |#1|)))
                                             #5#))))))
    (|haddProp| |$ConstructorCache| '|Stack| (LIST DV$1) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (AND (|HasCategory| $ '(|shallowlyMutable|)) (|augmentPredVector| $ 256))
    (AND (LETT #2# (|HasCategory| $ '(|finiteAggregate|)))
         (|augmentPredVector| $ 512))
    (AND (|HasCategory| |#1| '(|OrderedSet|)) #2# (|augmentPredVector| $ 1024))
    (AND
     (LETT #1#
           (AND (|HasCategory| |#1| '(|BasicType|))
                (|HasCategory| $ '(|finiteAggregate|))))
     (|augmentPredVector| $ 2048))
    (AND (OR #1# #5#) (|augmentPredVector| $ 4096))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 7 (|Reference| (|List| |#1|)))
    $))) 

(MAKEPROP '|Stack| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|List| 6)
              (0 . |deref|) (|Boolean|) (5 . =) |STACK;=;2$B;1|
              |STACK;parts;$L;2| (|Mapping| 6 6) (11 . |map|) (17 . |ref|)
              |STACK;map;M2$;3| (22 . |map!|) (28 . |setref|)
              |STACK;map!;M2$;4| (34 . |copy|) |STACK;copy;2$;5|
              (|NonNegativeInteger|) |STACK;#;$Nni;6| |STACK;empty?;$B;14|
              |STACK;pop!;$S;7| |STACK;extract!;$S;8| |STACK;top;$S;9|
              |STACK;inspect;$S;10| |STACK;push!;S$S;11| |STACK;insert!;S2$;12|
              |STACK;empty;$;13| |STACK;construct;L$;15| |STACK;stack;L$;16|
              (|HashState|) (39 . |hashUpdate!|) |STACK;hashUpdate!;Hs$Hs;17|
              (|Mapping| 6 6 6) (|List| 40) (|Equation| 6) (|Mapping| 10 6)
              (|Mapping| 10 6 6) (|OutputForm|) (|InputForm|) (|SingleInteger|)
              (|String|) (|Union| 6 '"failed"))
           '#(~= 45 |top| 51 |stack| 56 |size?| 61 |select| 67 |sample| 73
              |removeDuplicates| 77 |remove| 82 |reduce| 94 |push!| 115 |pop!|
              121 |parts| 126 |more?| 131 |min| 137 |members| 142 |member?| 147
              |max| 153 |map!| 164 |map| 170 |less?| 176 |latex| 182 |inspect|
              187 |insert!| 192 |hashUpdate!| 198 |hash| 204 |find| 209
              |extract!| 215 |every?| 220 |eval| 226 |eq?| 252 |empty?| 258
              |empty| 263 |count| 267 |copy| 279 |convert| 284 |construct| 289
              |coerce| 294 |any?| 299 = 305 |#| 311)
           'NIL
           (CONS (|makeByteWordVec2| 8 '(0 0 0 0 0 2 1 0 0 0 2 6 8 3))
                 (CONS
                  '#(NIL |BagAggregate&| |Collection&| |HomogeneousAggregate&|
                     |Aggregate&| |Evalable&| |SetCategory&| NIL NIL NIL
                     |InnerEvalable&| |BasicType&| NIL NIL)
                  (CONS
                   '#((|StackAggregate| 6) (|BagAggregate| 6) (|Collection| 6)
                      (|HomogeneousAggregate| 6) (|Aggregate|) (|Evalable| 6)
                      (|SetCategory|) (|Type|) (|finiteAggregate|)
                      (|shallowlyMutable|) (|InnerEvalable| 6 6) (|BasicType|)
                      (|CoercibleTo| 43) (|ConvertibleTo| 44))
                   (|makeByteWordVec2| 47
                                       '(1 7 8 0 9 2 8 10 0 0 11 2 8 0 14 0 15
                                         1 7 0 8 16 2 8 0 14 0 18 2 7 8 0 8 19
                                         1 8 0 0 21 2 8 35 35 0 36 2 13 10 0 0
                                         1 1 0 6 0 28 1 0 0 8 34 2 0 10 0 23 1
                                         2 10 0 41 0 1 0 0 0 1 1 12 0 0 1 2 12
                                         0 6 0 1 2 10 0 41 0 1 4 12 6 38 0 6 6
                                         1 2 10 6 38 0 1 3 10 6 38 0 6 1 2 0 6
                                         6 0 30 1 0 6 0 26 1 10 8 0 13 2 0 10 0
                                         23 1 1 11 6 0 1 1 10 8 0 1 2 12 10 6 0
                                         1 1 11 6 0 1 2 10 6 42 0 1 2 9 0 14 0
                                         20 2 0 0 14 0 17 2 0 10 0 23 1 1 1 46
                                         0 1 1 0 6 0 29 2 0 0 6 0 31 2 1 35 35
                                         0 37 1 1 45 0 1 2 0 47 41 0 1 1 0 6 0
                                         27 2 10 10 41 0 1 3 2 0 0 8 8 1 3 2 0
                                         0 6 6 1 2 2 0 0 39 1 2 2 0 0 40 1 2 0
                                         10 0 0 1 1 0 10 0 25 0 0 0 32 2 12 23
                                         6 0 1 2 10 23 41 0 1 1 0 0 0 22 1 3 44
                                         0 1 1 0 0 8 33 1 7 43 0 1 2 10 10 41 0
                                         1 2 13 10 0 0 12 1 10 23 0 24)))))
           '|lookupComplete|)) 
