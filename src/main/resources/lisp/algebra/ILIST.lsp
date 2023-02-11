
(SDEFUN |ILIST;minIndex;$I;1| ((|x| ($)) ($ (|Integer|))) (QREFELT $ 7)) 

(SDEFUN |ILIST;maxIndex;$I;2| ((|x| ($)) ($ (|Integer|)))
        (- (+ (QREFELT $ 7) (SPADCALL |x| (QREFELT $ 11))) 1)) 

(DECLAIM (NOTINLINE |IndexedList;|)) 

(DEFUN |IndexedList| (&REST #1=#:G1630)
  (SPROG NIL
         (PROG (#2=#:G1631)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(T NIL))
                                               (HGET |$ConstructorCache|
                                                     '|IndexedList|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |IndexedList;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|IndexedList|)))))))))) 

(DEFUN |IndexedList;| (|#1| |#2|)
  (SPROG
   ((#1=#:G1626 NIL) (#2=#:G1627 NIL) (#3=#:G1629 NIL) (#4=#:G1628 NIL)
    (|pv$| NIL) (#5=#:G1623 NIL) (#6=#:G1624 NIL) (#7=#:G1625 NIL) ($ NIL)
    (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 |#2|)
    (LETT |dv$| (LIST '|IndexedList| DV$1 DV$2))
    (LETT $ (GETREFV 34))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1| '(|OrderedSet|))
                                        (|HasCategory| |#1|
                                                       '(|ConvertibleTo|
                                                         (|InputForm|)))
                                        (|HasCategory| |#1| '(|BasicType|))
                                        (LETT #7#
                                              (|HasCategory| |#1|
                                                             '(|Comparable|)))
                                        (OR #7#
                                            (|HasCategory| |#1|
                                                           '(|OrderedSet|)))
                                        (LETT #6#
                                              (|HasCategory| |#1|
                                                             '(|SetCategory|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#1|)))
                                         #6#)
                                        (OR (|HasCategory| |#1| '(|BasicType|))
                                            #7#
                                            (|HasCategory| |#1|
                                                           '(|OrderedSet|))
                                            #6#)
                                        (OR #7#
                                            (|HasCategory| |#1|
                                                           '(|OrderedSet|))
                                            #6#)
                                        (LETT #5#
                                              (|HasCategory| |#1|
                                                             '(|CoercibleTo|
                                                               (|OutputForm|))))
                                        (OR #5# #7#
                                            (|HasCategory| |#1|
                                                           '(|OrderedSet|))
                                            #6#)
                                        (|HasCategory| (|Integer|)
                                                       '(|OrderedSet|))))))
    (|haddProp| |$ConstructorCache| '|IndexedList| (LIST DV$1 DV$2) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (AND (LETT #4# (|HasCategory| $ '(|finiteAggregate|)))
         (|augmentPredVector| $ 4096))
    (AND
     (LETT #3#
           (AND (|HasCategory| |#1| '(|OrderedSet|))
                (|HasCategory| $ '(|finiteAggregate|))))
     (|augmentPredVector| $ 8192))
    (AND (OR #5# (AND #7# #4#) #3#) (|augmentPredVector| $ 16384))
    (AND (OR (AND #7# #4#) #3# #6#) (|augmentPredVector| $ 32768))
    (AND (OR (AND #7# #4#) #3#) (|augmentPredVector| $ 65536))
    (AND
     (LETT #2#
           (AND (|HasCategory| |#1| '(|BasicType|))
                (|HasCategory| $ '(|finiteAggregate|))))
     (|augmentPredVector| $ 131072))
    (AND (OR #2# (AND #7# #4#) #3# #6#) (|augmentPredVector| $ 262144))
    (AND (LETT #1# (|HasCategory| $ '(|shallowlyMutable|)))
         (|augmentPredVector| $ 524288))
    (AND (|HasCategory| |#1| '(|OrderedSet|)) #4# #1#
         (|augmentPredVector| $ 1048576))
    (AND #4# #1# (|augmentPredVector| $ 2097152))
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|IndexedList| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|List| 6) (|local| |#1|) (|local| |#2|)
              (|Integer|) |ILIST;minIndex;$I;1| (|NonNegativeInteger|)
              (0 . |#|) |ILIST;maxIndex;$I;2| (|Mapping| 14 6 6) (|Boolean|)
              (|Mapping| 6 6 6) (|List| 17) (|Equation| 6) (|OutputForm|)
              (|HashState|) (|String|) (|SingleInteger|) (|Mapping| 14 6)
              (|Void|) (|UniversalSegment| 8) '"last" '"rest" '"first"
              (|List| $) '"value" (|Mapping| 6 6) (|InputForm|) (|List| 8)
              (|Union| 6 '"failed"))
           '#(~= 5 |value| 11 |trim| 16 |third| 22 |tail| 27 |swap!| 32
              |split!| 39 |sorted?| 45 |sort!| 56 |sort| 67 |smaller?| 78
              |size?| 84 |setvalue!| 90 |setrest!| 96 |setlast!| 102
              |setfirst!| 108 |setelt!| 114 |setchildren!| 156 |select!| 162
              |select| 168 |second| 174 |sample| 179 |rightTrim| 183 |reverse!|
              189 |reverse| 194 |rest| 199 |removeDuplicates!| 210
              |removeDuplicates| 215 |remove!| 220 |remove| 232 |reduce| 244
              |qsetrest!| 265 |qsetfirst!| 271 |qsetelt!| 277 |qelt| 284
              |possiblyInfinite?| 290 |position| 295 |parts| 314 |nodes| 319
              |node?| 324 |new| 330 |more?| 336 |minIndex| 342 |min| 347
              |merge!| 358 |merge| 371 |members| 384 |member?| 389 |maxIndex|
              395 |max| 400 |map!| 417 |map| 423 |list| 436 |less?| 441
              |leftTrim| 447 |leaves| 453 |leaf?| 458 |latex| 463 |last| 468
              |insert!| 479 |insert| 493 |indices| 507 |index?| 512
              |hashUpdate!| 518 |hash| 524 |first| 529 |find| 540 |fill!| 546
              |explicitlyFinite?| 552 |every?| 557 |eval| 563 |eq?| 589
              |entry?| 595 |entries| 601 |empty?| 606 |empty| 611 |elt| 615
              |distance| 658 |delete!| 664 |delete| 676 |cyclic?| 688
              |cycleTail| 693 |cycleSplit!| 698 |cycleLength| 703 |cycleEntry|
              708 |count| 713 |copyInto!| 725 |copy| 732 |convert| 737
              |construct| 742 |concat!| 747 |concat| 764 |coerce| 787
              |children| 792 |child?| 797 |any?| 803 >= 809 > 815 = 821 <= 827
              < 833 |#| 839)
           'NIL
           (CONS
            (|makeByteWordVec2| 11
                                '(0 0 0 0 0 0 0 0 0 1 0 5 0 0 7 9 0 0 0 0 0 7 8
                                  11 1 2))
            (CONS
             '#(|ListAggregate&| |StreamAggregate&|
                |ExtensibleLinearAggregate&| NIL |UnaryRecursiveAggregate&|
                |LinearAggregate&| |RecursiveAggregate&| |IndexedAggregate&|
                |Collection&| |OrderedSet&| |HomogeneousAggregate&| NIL
                |Aggregate&| |EltableAggregate&| |Evalable&| |SetCategory&| NIL
                NIL NIL NIL NIL |InnerEvalable&| |BasicType&| NIL
                |PartialOrder&| NIL)
             (CONS
              '#((|ListAggregate| 6) (|StreamAggregate| 6)
                 (|ExtensibleLinearAggregate| 6) (|FiniteLinearAggregate| 6)
                 (|UnaryRecursiveAggregate| 6) (|LinearAggregate| 6)
                 (|RecursiveAggregate| 6) (|IndexedAggregate| 8 6)
                 (|Collection| 6) (|OrderedSet|) (|HomogeneousAggregate| 6)
                 (|Comparable|) (|Aggregate|) (|EltableAggregate| 8 6)
                 (|Evalable| 6) (|SetCategory|) (|shallowlyMutable|)
                 (|finiteAggregate|) (|Eltable| 24 $$) (|Type|) (|Eltable| 8 6)
                 (|InnerEvalable| 6 6) (|BasicType|) (|CoercibleTo| 18)
                 (|PartialOrder|) (|ConvertibleTo| 31))
              (|makeByteWordVec2| 33
                                  '(1 0 10 0 11 2 19 14 0 0 1 1 0 6 0 1 2 18 0
                                    0 6 1 1 0 6 0 1 1 0 0 0 1 3 20 23 0 8 8 1 2
                                    20 0 0 10 1 1 14 14 0 1 2 13 14 13 0 1 1 21
                                    0 0 1 2 22 0 13 0 1 1 14 0 0 1 2 13 0 13 0
                                    1 2 17 14 0 0 1 2 0 14 0 10 1 2 20 6 0 6 1
                                    2 20 0 0 0 1 2 20 6 0 6 1 2 20 6 0 6 1 3 20
                                    6 0 8 6 1 3 20 6 0 24 6 1 3 20 6 0 25 6 1 3
                                    20 0 0 26 0 1 3 20 6 0 27 6 1 3 20 6 0 29 6
                                    1 2 20 0 0 28 1 2 0 0 22 0 1 2 13 0 22 0 1
                                    1 0 6 0 1 0 0 0 1 2 18 0 0 6 1 1 22 0 0 1 1
                                    13 0 0 1 2 0 0 0 10 1 1 0 0 0 1 1 3 0 0 1 1
                                    18 0 0 1 2 3 0 6 0 1 2 0 0 22 0 1 2 18 0 6
                                    0 1 2 13 0 22 0 1 4 18 6 15 0 6 6 1 2 13 6
                                    15 0 1 3 13 6 15 0 6 1 2 20 0 0 0 1 2 20 6
                                    0 6 1 3 20 6 0 8 6 1 2 0 6 0 8 1 1 0 14 0 1
                                    2 18 8 6 0 1 3 18 8 6 0 8 1 2 13 8 22 0 1 1
                                    13 5 0 1 1 0 28 0 1 2 3 14 0 0 1 2 0 0 10 6
                                    1 2 0 14 0 10 1 1 12 8 0 9 2 14 0 0 0 1 1
                                    14 6 0 1 2 1 0 0 0 1 3 0 0 13 0 0 1 2 14 0
                                    0 0 1 3 13 0 13 0 0 1 1 13 5 0 1 2 18 14 6
                                    0 1 1 12 8 0 12 2 14 0 0 0 1 1 14 6 0 1 2
                                    13 6 13 0 1 2 20 0 30 0 1 3 0 0 15 0 0 1 2
                                    0 0 30 0 1 1 0 0 6 1 2 0 14 0 10 1 2 18 0 0
                                    6 1 1 0 5 0 1 1 0 14 0 1 1 16 20 0 1 2 0 0
                                    0 10 1 1 0 6 0 1 3 0 0 6 0 8 1 3 0 0 0 0 8
                                    1 3 0 0 0 0 8 1 3 0 0 6 0 8 1 1 0 32 0 1 2
                                    0 14 8 0 1 2 16 19 19 0 1 1 16 21 0 1 2 0 0
                                    0 10 1 1 0 6 0 1 2 0 33 22 0 1 2 20 0 0 6 1
                                    1 0 14 0 1 2 13 14 22 0 1 3 7 0 0 6 6 1 3 7
                                    0 0 5 5 1 2 7 0 0 16 1 2 7 0 0 17 1 2 0 14
                                    0 0 1 2 18 14 6 0 1 1 0 5 0 1 1 0 14 0 1 0
                                    0 0 1 2 0 6 0 8 1 3 0 6 0 8 6 1 2 0 0 0 24
                                    1 2 0 6 0 25 1 2 0 0 0 26 1 2 0 6 0 27 1 2
                                    0 6 0 29 1 2 0 8 0 0 1 2 0 0 0 8 1 2 0 0 0
                                    24 1 2 0 0 0 24 1 2 0 0 0 8 1 1 0 14 0 1 1
                                    0 0 0 1 1 20 0 0 1 1 0 10 0 1 1 0 0 0 1 2
                                    18 10 6 0 1 2 13 10 22 0 1 3 22 0 0 0 8 1 1
                                    0 0 0 1 1 2 31 0 1 1 0 0 5 1 1 20 0 28 1 2
                                    0 0 0 6 1 2 0 0 0 0 1 1 0 0 28 1 2 0 0 0 6
                                    1 2 0 0 6 0 1 2 0 0 0 0 1 1 15 18 0 1 1 0
                                    28 0 1 2 3 14 0 0 1 2 13 14 22 0 1 2 14 14
                                    0 0 1 2 14 14 0 0 1 2 19 14 0 0 1 2 14 14 0
                                    0 1 2 14 14 0 0 1 1 13 10 0 11)))))
           '|lookupComplete|)) 
