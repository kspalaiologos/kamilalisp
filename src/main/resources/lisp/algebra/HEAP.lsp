
(SDEFUN |HEAP;empty;$;1| (($ ($))) (SPADCALL (QREFELT $ 8))) 

(SDEFUN |HEAP;heap;L$;2| ((|l| (|List| S)) ($ ($)))
        (SPADCALL |l| (QREFELT $ 11))) 

(SDEFUN |HEAP;siftUp|
        ((|r| ($)) (|i| (|Integer|)) (|n| (|Integer|)) ($ (|Void|)))
        (SPROG ((#1=#:G712 NIL) (|j| #2=(|Integer|)) (|k| #2#) (|t| (S)))
               (SEQ (LETT |t| (SPADCALL |r| |i| (QREFELT $ 14)))
                    (EXIT
                     (SEQ
                      (EXIT
                       (SEQ G190
                            (COND
                             ((NULL (< (LETT |j| (+ (* 2 |i|) 1)) |n|))
                              (GO G191)))
                            (SEQ
                             (SEQ (LETT |k| (+ |j| 1))
                                  (EXIT
                                   (COND
                                    ((< |k| |n|)
                                     (COND
                                      ((SPADCALL
                                        (SPADCALL |r| |j| (QREFELT $ 14))
                                        (SPADCALL |r| |k| (QREFELT $ 14))
                                        (QREFELT $ 16))
                                       (LETT |j| |k|)))))))
                             (EXIT
                              (COND
                               ((SPADCALL |t| (SPADCALL |r| |j| (QREFELT $ 14))
                                          (QREFELT $ 16))
                                (SEQ
                                 (SPADCALL |r| |i|
                                           (SPADCALL |r| |j| (QREFELT $ 14))
                                           (QREFELT $ 17))
                                 (SPADCALL |r| |j| |t| (QREFELT $ 17))
                                 (EXIT (LETT |i| |j|))))
                               ('T (PROGN (LETT #1# 1) (GO #3=#:G709))))))
                            NIL (GO G190) G191 (EXIT NIL)))
                      #3# (EXIT #1#)))))) 

(SDEFUN |HEAP;extract!;$S;4| ((|r| ($)) ($ (S)))
        (SPROG ((|t| (S)) (|n| (|Integer|)))
               (SEQ (LETT |n| (SPADCALL |r| (QREFELT $ 19)))
                    (EXIT
                     (COND ((EQL |n| 0) (|error| "empty heap"))
                           (#1='T
                            (SEQ (LETT |t| (SPADCALL |r| 0 (QREFELT $ 14)))
                                 (SPADCALL |r| 0
                                           (SPADCALL |r| (- |n| 1)
                                                     (QREFELT $ 14))
                                           (QREFELT $ 17))
                                 (SPADCALL |r| (- |n| 1) (QREFELT $ 20))
                                 (EXIT
                                  (COND ((EQL |n| 1) |t|)
                                        (#1#
                                         (SEQ (|HEAP;siftUp| |r| 0 (- |n| 1) $)
                                              (EXIT |t|)))))))))))) 

(SDEFUN |HEAP;insert!;S2$;5| ((|x| (S)) (|r| ($)) ($ ($)))
        (SPROG ((|j| (|Integer|)) (#1=#:G723 NIL) (|i| (|Integer|)))
               (SEQ (LETT |j| (SPADCALL |r| (QREFELT $ 19)))
                    (LETT |r| (SPADCALL |r| |x| (QREFELT $ 22)))
                    (SEQ
                     (EXIT
                      (SEQ G190 (COND ((NULL (> |j| 0)) (GO G191)))
                           (SEQ (LETT |i| (QUOTIENT2 (- |j| 1) 2))
                                (COND
                                 ((SPADCALL (SPADCALL |r| |i| (QREFELT $ 14))
                                            |x| (QREFELT $ 23))
                                  (PROGN (LETT #1# 1) (GO #2=#:G720))))
                                (SPADCALL |r| |j|
                                          (SPADCALL |r| |i| (QREFELT $ 14))
                                          (QREFELT $ 17))
                                (EXIT (LETT |j| |i|)))
                           NIL (GO G190) G191 (EXIT NIL)))
                     #2# (EXIT #1#))
                    (SPADCALL |r| |j| |x| (QREFELT $ 17)) (EXIT |r|)))) 

(SDEFUN |HEAP;max;$S;6| ((|r| ($)) ($ (S)))
        (COND ((EQL (SPADCALL |r| (QREFELT $ 19)) 0) (|error| "empty heap"))
              ('T (SPADCALL |r| 0 (QREFELT $ 14))))) 

(SDEFUN |HEAP;inspect;$S;7| ((|r| ($)) ($ (S))) (SPADCALL |r| (QREFELT $ 25))) 

(SDEFUN |HEAP;makeHeap| ((|r| ($)) ($ ($)))
        (SPROG ((|k| NIL) (|n| (|NonNegativeInteger|)))
               (SEQ (LETT |n| (SPADCALL |r| (QREFELT $ 19)))
                    (SEQ (LETT |k| (- (QUOTIENT2 |n| 2) 1)) G190
                         (COND ((< |k| 0) (GO G191)))
                         (SEQ (EXIT (|HEAP;siftUp| |r| |k| |n| $)))
                         (LETT |k| (+ |k| -1)) (GO G190) G191 (EXIT NIL))
                    (EXIT |r|)))) 

(SDEFUN |HEAP;construct;L$;9| ((|l| (|List| S)) ($ ($)))
        (|HEAP;makeHeap| (SPADCALL |l| (QREFELT $ 27)) $)) 

(SDEFUN |HEAP;merge;3$;10| ((|a| ($)) (|b| ($)) ($ ($)))
        (|HEAP;makeHeap| (SPADCALL |a| |b| (QREFELT $ 28)) $)) 

(SDEFUN |HEAP;merge!;3$;11| ((|a| ($)) (|b| ($)) ($ ($)))
        (|HEAP;makeHeap| (SPADCALL |a| |b| (QREFELT $ 30)) $)) 

(DECLAIM (NOTINLINE |Heap;|)) 

(DEFUN |Heap| (#1=#:G748)
  (SPROG NIL
         (PROG (#2=#:G749)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Heap|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Heap;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Heap|)))))))))) 

(DEFUN |Heap;| (|#1|)
  (SPROG
   ((#1=#:G746 NIL) (#2=#:G747 NIL) (|pv$| NIL) (#3=#:G743 NIL) (#4=#:G744 NIL)
    (#5=#:G745 NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|Heap| DV$1))
    (LETT $ (GETREFV 44))
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
    (|haddProp| |$ConstructorCache| '|Heap| (LIST DV$1) (CONS 1 $))
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
    (QSETREFV $ 7 (|IndexedFlexibleArray| |#1| 0))
    $))) 

(MAKEPROP '|Heap| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|IndexedFlexibleArray| 6 (NRTEVAL 0))
              (|local| |#1|) '|Rep| (0 . |empty|) |HEAP;empty;$;1| (|List| 6)
              |HEAP;construct;L$;9| |HEAP;heap;L$;2| (|Integer|) (4 . |elt|)
              (|Boolean|) (10 . <) (16 . |setelt!|) (|NonNegativeInteger|)
              (23 . |#|) (28 . |delete!|) |HEAP;extract!;$S;4| (34 . |concat!|)
              (40 . >=) |HEAP;insert!;S2$;5| |HEAP;max;$S;6|
              |HEAP;inspect;$S;7| (46 . |construct|) (51 . |concat|)
              |HEAP;merge;3$;10| (57 . |concat!|) |HEAP;merge!;3$;11|
              (|Mapping| 6 6 6) (|Equation| 6) (|List| 33) (|Mapping| 15 6)
              (|Mapping| 15 6 6) (|Mapping| 6 6) (|OutputForm|) (|InputForm|)
              (|SingleInteger|) (|String|) (|HashState|) (|Union| 6 '"failed"))
           '#(~= 63 |size?| 69 |select| 75 |sample| 81 |removeDuplicates| 85
              |remove| 90 |reduce| 102 |parts| 123 |more?| 128 |min| 134
              |merge!| 139 |merge| 145 |members| 151 |member?| 156 |max| 162
              |map!| 173 |map| 179 |less?| 185 |latex| 191 |inspect| 196
              |insert!| 201 |heap| 207 |hashUpdate!| 212 |hash| 218 |find| 223
              |extract!| 229 |every?| 234 |eval| 240 |eq?| 266 |empty?| 272
              |empty| 277 |count| 281 |copy| 293 |convert| 298 |construct| 303
              |coerce| 308 |any?| 313 = 319 |#| 325)
           'NIL
           (CONS (|makeByteWordVec2| 8 '(0 0 0 0 0 2 1 0 0 0 2 6 8 3))
                 (CONS
                  '#(NIL |BagAggregate&| |Collection&| |HomogeneousAggregate&|
                     |Aggregate&| |Evalable&| |SetCategory&| NIL NIL NIL
                     |InnerEvalable&| |BasicType&| NIL NIL)
                  (CONS
                   '#((|PriorityQueueAggregate| 6) (|BagAggregate| 6)
                      (|Collection| 6) (|HomogeneousAggregate| 6) (|Aggregate|)
                      (|Evalable| 6) (|SetCategory|) (|Type|)
                      (|finiteAggregate|) (|shallowlyMutable|)
                      (|InnerEvalable| 6 6) (|BasicType|) (|CoercibleTo| 38)
                      (|ConvertibleTo| 39))
                   (|makeByteWordVec2| 43
                                       '(0 7 0 8 2 7 6 0 13 14 2 6 15 0 0 16 3
                                         7 6 0 13 6 17 1 0 18 0 19 2 7 0 0 13
                                         20 2 7 0 0 6 22 2 6 15 0 0 23 1 7 0 10
                                         27 2 7 0 0 0 28 2 7 0 0 0 30 2 13 15 0
                                         0 1 2 0 15 0 18 1 2 10 0 35 0 1 0 0 0
                                         1 1 12 0 0 1 2 12 0 6 0 1 2 10 0 35 0
                                         1 4 12 6 32 0 6 6 1 3 10 6 32 0 6 1 2
                                         10 6 32 0 1 1 10 10 0 1 2 0 15 0 18 1
                                         1 11 6 0 1 2 0 0 0 0 31 2 0 0 0 0 29 1
                                         10 10 0 1 2 12 15 6 0 1 2 10 6 36 0 1
                                         1 0 6 0 25 2 9 0 37 0 1 2 0 0 37 0 1 2
                                         0 15 0 18 1 1 1 41 0 1 1 0 6 0 26 2 0
                                         0 6 0 24 1 0 0 10 12 2 1 42 42 0 1 1 1
                                         40 0 1 2 0 43 35 0 1 1 0 6 0 21 2 10
                                         15 35 0 1 3 2 0 0 10 10 1 2 2 0 0 33 1
                                         3 2 0 0 6 6 1 2 2 0 0 34 1 2 0 15 0 0
                                         1 1 0 15 0 1 0 0 0 9 2 12 18 6 0 1 2
                                         10 18 35 0 1 1 0 0 0 1 1 3 39 0 1 1 0
                                         0 10 11 1 7 38 0 1 2 10 15 35 0 1 2 13
                                         15 0 0 1 1 10 18 0 19)))))
           '|lookupComplete|)) 
