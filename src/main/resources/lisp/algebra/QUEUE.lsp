
(SDEFUN |QUEUE;enqueue!;S$S;1| ((|e| (S)) (|q| ($)) ($ (S)))
        (SEQ
         (COND
          ((NULL (SPADCALL |q| (QREFELT $ 9)))
           (SPADCALL |q| (SPADCALL |e| (QREFELT $ 10)) (QREFELT $ 11)))
          ('T
           (SPADCALL (LAST (SPADCALL |q| (QREFELT $ 9))) '|rest|
                     (SPADCALL |e| (QREFELT $ 10)) (QREFELT $ 13))))
         (EXIT |e|))) 

(SDEFUN |QUEUE;insert!;S2$;2| ((|e| (S)) (|q| ($)) ($ ($)))
        (SEQ (SPADCALL |e| |q| (QREFELT $ 14)) (EXIT |q|))) 

(SDEFUN |QUEUE;dequeue!;$S;3| ((|q| ($)) ($ (S)))
        (SPROG ((|e| (S)))
               (SEQ
                (COND ((SPADCALL |q| (QREFELT $ 17)) (|error| "empty queue"))
                      ('T
                       (SEQ
                        (LETT |e| (|SPADfirst| (SPADCALL |q| (QREFELT $ 9))))
                        (SPADCALL |q| (CDR (SPADCALL |q| (QREFELT $ 9)))
                                  (QREFELT $ 11))
                        (EXIT |e|))))))) 

(SDEFUN |QUEUE;extract!;$S;4| ((|q| ($)) ($ (S))) (SPADCALL |q| (QREFELT $ 18))) 

(SDEFUN |QUEUE;rotate!;2$;5| ((|q| ($)) ($ ($)))
        (SEQ
         (COND ((SPADCALL |q| (QREFELT $ 17)) |q|)
               ('T
                (SEQ
                 (SPADCALL (SPADCALL |q| (QREFELT $ 18)) |q| (QREFELT $ 14))
                 (EXIT |q|)))))) 

(SDEFUN |QUEUE;front;$S;6| ((|q| ($)) ($ (S)))
        (COND ((SPADCALL |q| (QREFELT $ 17)) (|error| "empty queue"))
              ('T (|SPADfirst| (SPADCALL |q| (QREFELT $ 9)))))) 

(SDEFUN |QUEUE;inspect;$S;7| ((|q| ($)) ($ (S))) (SPADCALL |q| (QREFELT $ 21))) 

(SDEFUN |QUEUE;back;$S;8| ((|q| ($)) ($ (S)))
        (COND ((SPADCALL |q| (QREFELT $ 17)) (|error| "empty queue"))
              ('T (SPADCALL (SPADCALL |q| (QREFELT $ 9)) (QREFELT $ 23))))) 

(SDEFUN |QUEUE;queue;L$;9| ((|q| (|List| S)) ($ ($)))
        (SPADCALL |q| (QREFELT $ 25))) 

(DECLAIM (NOTINLINE |Queue;|)) 

(DEFUN |Queue| (#1=#:G736)
  (SPROG NIL
         (PROG (#2=#:G737)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Queue|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Queue;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Queue|)))))))))) 

(DEFUN |Queue;| (|#1|)
  (SPROG
   ((#1=#:G734 NIL) (#2=#:G735 NIL) (|pv$| NIL) (#3=#:G731 NIL) (#4=#:G732 NIL)
    (#5=#:G733 NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|Queue| DV$1))
    (LETT $ (GETREFV 40))
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
    (|haddProp| |$ConstructorCache| '|Queue| (LIST DV$1) (CONS 1 $))
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

(MAKEPROP '|Queue| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|Stack| 6) (|local| |#1|) '|Rep| (|List| 6)
              (0 . |deref|) (5 . |list|) (10 . |setref|) '"rest"
              (16 . |setelt!|) |QUEUE;enqueue!;S$S;1| |QUEUE;insert!;S2$;2|
              (|Boolean|) (23 . |empty?|) |QUEUE;dequeue!;$S;3|
              |QUEUE;extract!;$S;4| |QUEUE;rotate!;2$;5| |QUEUE;front;$S;6|
              |QUEUE;inspect;$S;7| (28 . |last|) |QUEUE;back;$S;8|
              (33 . |construct|) |QUEUE;queue;L$;9| (|Mapping| 6 6 6)
              (|NonNegativeInteger|) (|Equation| 6) (|List| 29)
              (|Mapping| 16 6) (|Mapping| 16 6 6) (|Mapping| 6 6)
              (|OutputForm|) (|InputForm|) (|SingleInteger|) (|String|)
              (|HashState|) (|Union| 6 '"failed"))
           '#(~= 38 |size?| 44 |select| 50 |sample| 56 |rotate!| 60
              |removeDuplicates| 65 |remove| 70 |reduce| 82 |queue| 103 |parts|
              108 |more?| 113 |min| 119 |members| 124 |member?| 129 |max| 135
              |map!| 146 |map| 152 |less?| 158 |latex| 164 |inspect| 169
              |insert!| 174 |hashUpdate!| 180 |hash| 186 |front| 191 |find| 196
              |extract!| 202 |every?| 207 |eval| 213 |eq?| 239 |enqueue!| 245
              |empty?| 251 |empty| 256 |dequeue!| 260 |count| 265 |copy| 277
              |convert| 282 |construct| 287 |coerce| 292 |back| 297 |any?| 302
              = 308 |#| 314)
           'NIL
           (CONS (|makeByteWordVec2| 8 '(0 0 0 0 0 2 1 0 0 0 2 6 8 3))
                 (CONS
                  '#(NIL |BagAggregate&| |Collection&| |HomogeneousAggregate&|
                     |Aggregate&| |Evalable&| |SetCategory&| NIL NIL NIL
                     |InnerEvalable&| |BasicType&| NIL NIL)
                  (CONS
                   '#((|QueueAggregate| 6) (|BagAggregate| 6) (|Collection| 6)
                      (|HomogeneousAggregate| 6) (|Aggregate|) (|Evalable| 6)
                      (|SetCategory|) (|Type|) (|finiteAggregate|)
                      (|shallowlyMutable|) (|InnerEvalable| 6 6) (|BasicType|)
                      (|CoercibleTo| 34) (|ConvertibleTo| 35))
                   (|makeByteWordVec2| 39
                                       '(1 7 8 0 9 1 8 0 6 10 2 7 8 0 8 11 3 8
                                         0 0 12 0 13 1 0 16 0 17 1 8 6 0 23 1 0
                                         0 8 25 2 13 16 0 0 1 2 0 16 0 28 1 2
                                         10 0 31 0 1 0 0 0 1 1 0 0 0 20 1 12 0
                                         0 1 2 12 0 6 0 1 2 10 0 31 0 1 4 12 6
                                         27 0 6 6 1 3 10 6 27 0 6 1 2 10 6 27 0
                                         1 1 0 0 8 26 1 10 8 0 1 2 0 16 0 28 1
                                         1 11 6 0 1 1 10 8 0 1 2 12 16 6 0 1 1
                                         11 6 0 1 2 10 6 32 0 1 2 9 0 33 0 1 2
                                         0 0 33 0 1 2 0 16 0 28 1 1 1 37 0 1 1
                                         0 6 0 22 2 0 0 6 0 15 2 1 38 38 0 1 1
                                         1 36 0 1 1 0 6 0 21 2 0 39 31 0 1 1 0
                                         6 0 19 2 10 16 31 0 1 3 2 0 0 8 8 1 2
                                         2 0 0 29 1 3 2 0 0 6 6 1 2 2 0 0 30 1
                                         2 0 16 0 0 1 2 0 6 6 0 14 1 0 16 0 17
                                         0 0 0 1 1 0 6 0 18 2 12 28 6 0 1 2 10
                                         28 31 0 1 1 0 0 0 1 1 3 35 0 1 1 0 0 8
                                         25 1 7 34 0 1 1 0 6 0 24 2 10 16 31 0
                                         1 2 13 16 0 0 1 1 10 28 0 1)))))
           '|lookupComplete|)) 
