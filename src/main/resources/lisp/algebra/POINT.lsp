
(SDEFUN |POINT;point;L$;1| ((|l| (|List| R)) ($ ($)))
        (SPROG ((#1=#:G705 NIL) (|x| NIL) (|i| NIL) (|pt| ($)))
               (SEQ (LETT |pt| (SPADCALL (LENGTH |l|) 'R (QREFELT $ 8)))
                    (SEQ (LETT |i| (SPADCALL |pt| (QREFELT $ 10)))
                         (LETT |x| NIL) (LETT #1# |l|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ (EXIT (SPADCALL |pt| |i| |x| (QREFELT $ 11))))
                         (LETT #1# (PROG1 (CDR #1#) (LETT |i| (+ |i| 1))))
                         (GO G190) G191 (EXIT NIL))
                    (EXIT |pt|)))) 

(SDEFUN |POINT;dimension;$Pi;2| ((|p| ($)) ($ (|PositiveInteger|)))
        (SPROG ((#1=#:G707 NIL))
               (PROG1 (LETT #1# (SPADCALL |p| (QREFELT $ 14)))
                 (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                   '(|NonNegativeInteger|) #1#)))) 

(SDEFUN |POINT;convert;L$;3| ((|l| (|List| R)) ($ ($)))
        (SPADCALL |l| (QREFELT $ 13))) 

(SDEFUN |POINT;cross;3$;4| ((|p0| ($)) (|p1| ($)) ($ ($)))
        (COND
         ((OR (SPADCALL (SPADCALL |p0| (QREFELT $ 14)) 3 (QREFELT $ 19))
              (SPADCALL (SPADCALL |p1| (QREFELT $ 14)) 3 (QREFELT $ 19)))
          (|error| "Arguments to cross must be three dimensional"))
         ('T
          (SPADCALL
           (LIST
            (SPADCALL
             (SPADCALL (SPADCALL |p0| 2 (QREFELT $ 20))
                       (SPADCALL |p1| 3 (QREFELT $ 20)) (QREFELT $ 21))
             (SPADCALL (SPADCALL |p1| 2 (QREFELT $ 20))
                       (SPADCALL |p0| 3 (QREFELT $ 20)) (QREFELT $ 21))
             (QREFELT $ 22))
            (SPADCALL
             (SPADCALL (SPADCALL |p1| 1 (QREFELT $ 20))
                       (SPADCALL |p0| 3 (QREFELT $ 20)) (QREFELT $ 21))
             (SPADCALL (SPADCALL |p0| 1 (QREFELT $ 20))
                       (SPADCALL |p1| 3 (QREFELT $ 20)) (QREFELT $ 21))
             (QREFELT $ 22))
            (SPADCALL
             (SPADCALL (SPADCALL |p0| 1 (QREFELT $ 20))
                       (SPADCALL |p1| 2 (QREFELT $ 20)) (QREFELT $ 21))
             (SPADCALL (SPADCALL |p1| 1 (QREFELT $ 20))
                       (SPADCALL |p0| 2 (QREFELT $ 20)) (QREFELT $ 21))
             (QREFELT $ 22)))
           (QREFELT $ 13))))) 

(SDEFUN |POINT;extend;$L$;5| ((|p| ($)) (|l| (|List| R)) ($ ($)))
        (SPADCALL |p| (SPADCALL |l| (QREFELT $ 13)) (QREFELT $ 25))) 

(DECLAIM (NOTINLINE |Point;|)) 

(DEFUN |Point| (#1=#:G726)
  (SPROG NIL
         (PROG (#2=#:G727)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Point|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Point;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Point|)))))))))) 

(DEFUN |Point;| (|#1|)
  (SPROG
   ((|pv$| NIL) (#1=#:G723 NIL) (#2=#:G724 NIL) (#3=#:G725 NIL) ($ NIL)
    (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|Point| DV$1))
    (LETT $ (GETREFV 44))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1| '(|OrderedSet|))
                                        (|HasCategory| |#1|
                                                       '(|ConvertibleTo|
                                                         (|InputForm|)))
                                        (|HasCategory| (|Integer|)
                                                       '(|OrderedSet|))
                                        (|HasCategory| |#1| '(|BasicType|))
                                        (LETT #3#
                                              (|HasCategory| |#1|
                                                             '(|Comparable|)))
                                        (OR #3#
                                            (|HasCategory| |#1|
                                                           '(|OrderedSet|)))
                                        (LETT #2#
                                              (|HasCategory| |#1|
                                                             '(|SetCategory|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#1|)))
                                         #2#)
                                        (OR (|HasCategory| |#1| '(|BasicType|))
                                            #3#
                                            (|HasCategory| |#1|
                                                           '(|OrderedSet|))
                                            #2#)
                                        (OR #3#
                                            (|HasCategory| |#1|
                                                           '(|OrderedSet|))
                                            #2#)
                                        (LETT #1#
                                              (|HasCategory| |#1|
                                                             '(|CoercibleTo|
                                                               (|OutputForm|))))
                                        (OR #1# #3#
                                            (|HasCategory| |#1|
                                                           '(|OrderedSet|))
                                            #2#)
                                        (|HasCategory| |#1|
                                                       '(|AbelianSemiGroup|))
                                        (|HasCategory| |#1| '(|AbelianMonoid|))
                                        (|HasCategory| |#1| '(|AbelianGroup|))
                                        (|HasCategory| |#1| '(|SemiGroup|))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         (|HasCategory| |#1| '(|SemiRng|)))
                                        (|HasCategory| |#1| '(|Ring|))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|RadicalCategory|))
                                         (|HasCategory| |#1| '(|Ring|)))))))
    (|haddProp| |$ConstructorCache| '|Point| (LIST DV$1) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (AND (|HasCategory| $ '(|shallowlyMutable|))
         (|augmentPredVector| $ 524288))
    (AND (|HasCategory| $ '(|finiteAggregate|))
         (|augmentPredVector| $ 1048576))
    (AND (|HasCategory| |#1| '(|BasicType|))
         (|HasCategory| $ '(|finiteAggregate|))
         (|augmentPredVector| $ 2097152))
    (AND (|HasCategory| $ '(|finiteAggregate|))
         (|HasCategory| $ '(|shallowlyMutable|))
         (|augmentPredVector| $ 4194304))
    (AND (|HasCategory| |#1| '(|OrderedSet|))
         (|HasCategory| $ '(|finiteAggregate|))
         (|HasCategory| $ '(|shallowlyMutable|))
         (|augmentPredVector| $ 8388608))
    (AND (|HasCategory| |#1| '(|OrderedSet|))
         (|HasCategory| $ '(|finiteAggregate|))
         (|augmentPredVector| $ 16777216))
    (AND
     (OR (AND #3# (|HasCategory| $ '(|finiteAggregate|)))
         (AND (|HasCategory| |#1| '(|OrderedSet|))
              (|HasCategory| $ '(|finiteAggregate|))))
     (|augmentPredVector| $ 33554432))
    (AND
     (OR (AND #3# (|HasCategory| $ '(|finiteAggregate|)))
         (AND (|HasCategory| |#1| '(|OrderedSet|))
              (|HasCategory| $ '(|finiteAggregate|)))
         #2#)
     (|augmentPredVector| $ 67108864))
    (AND
     (OR #1# (AND #3# (|HasCategory| $ '(|finiteAggregate|)))
         (AND (|HasCategory| |#1| '(|OrderedSet|))
              (|HasCategory| $ '(|finiteAggregate|))))
     (|augmentPredVector| $ 134217728))
    (AND
     (OR
      (AND (|HasCategory| |#1| '(|BasicType|))
           (|HasCategory| $ '(|finiteAggregate|)))
      (AND #3# (|HasCategory| $ '(|finiteAggregate|)))
      (AND (|HasCategory| |#1| '(|OrderedSet|))
           (|HasCategory| $ '(|finiteAggregate|)))
      #2#)
     (|augmentPredVector| $ 268435456))
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|Point| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|Vector| 6) (|local| |#1|)
              (|NonNegativeInteger|) (0 . |new|) (|Integer|) (6 . |minIndex|)
              (11 . |setelt!|) (|List| 6) |POINT;point;L$;1| (18 . |#|)
              (|PositiveInteger|) |POINT;dimension;$Pi;2| |POINT;convert;L$;3|
              (|Boolean|) (23 . ~=) (29 . |elt|) (35 . *) (41 . -) (47 . |One|)
              |POINT;cross;3$;4| (51 . |concat|) |POINT;extend;$L$;5|
              (|Mapping| 18 6 6) (|Mapping| 6 6 6) (|List| 30) (|Equation| 6)
              (|OutputForm|) (|SingleInteger|) (|HashState|) (|String|)
              (|Mapping| 18 6) (|UniversalSegment| 9) (|Void|) (|Mapping| 6 6)
              (|InputForm|) (|Matrix| 6) (|List| $) (|Union| 6 '"failed")
              (|List| 9))
           '#(~= 57 |zero?| 63 |zero| 68 |trim| 73 |swap!| 79 |sorted?| 86
              |sort!| 97 |sort| 108 |smaller?| 119 |size?| 125 |setelt!| 131
              |select| 145 |sample| 151 |rightTrim| 155 |reverse!| 161
              |reverse| 166 |removeDuplicates| 171 |remove| 176 |reduce| 188
              |qsetelt!| 209 |qelt| 216 |position| 222 |point| 241 |parts| 246
              |outerProduct| 251 |new| 257 |more?| 263 |minIndex| 269 |min| 274
              |merge| 285 |members| 298 |member?| 303 |maxIndex| 309 |max| 314
              |map!| 331 |map| 337 |less?| 350 |length| 356 |leftTrim| 361
              |latex| 367 |insert| 372 |indices| 386 |index?| 391 |hashUpdate!|
              397 |hash| 403 |first| 408 |find| 419 |fill!| 425 |extend| 431
              |every?| 437 |eval| 443 |eq?| 469 |entry?| 475 |entries| 481
              |empty?| 486 |empty| 491 |elt| 495 |dot| 514 |dimension| 520
              |delete| 525 |cross| 537 |count| 543 |copyInto!| 555 |copy| 562
              |convert| 567 |construct| 577 |concat| 582 |coerce| 605 |any?|
              610 >= 616 > 622 = 628 <= 634 < 640 - 646 + 657 * 663 |#| 681)
           'NIL
           (CONS
            (|makeByteWordVec2| 12
                                '(0 0 0 0 0 0 0 1 0 6 0 0 8 10 0 0 0 0 0 8 9 12
                                  1 2))
            (CONS
             '#(NIL |VectorCategory&| |OneDimensionalArrayAggregate&| NIL
                |LinearAggregate&| |IndexedAggregate&| |Collection&|
                |OrderedSet&| |HomogeneousAggregate&| NIL |Aggregate&|
                |EltableAggregate&| |Evalable&| |SetCategory&| NIL NIL NIL NIL
                NIL |InnerEvalable&| |BasicType&| NIL |PartialOrder&| NIL)
             (CONS
              '#((|PointCategory| 6) (|VectorCategory| 6)
                 (|OneDimensionalArrayAggregate| 6) (|FiniteLinearAggregate| 6)
                 (|LinearAggregate| 6) (|IndexedAggregate| 9 6)
                 (|Collection| 6) (|OrderedSet|) (|HomogeneousAggregate| 6)
                 (|Comparable|) (|Aggregate|) (|EltableAggregate| 9 6)
                 (|Evalable| 6) (|SetCategory|) (|shallowlyMutable|)
                 (|finiteAggregate|) (|Eltable| 36 $$) (|Type|) (|Eltable| 9 6)
                 (|InnerEvalable| 6 6) (|BasicType|) (|CoercibleTo| 31)
                 (|PartialOrder|) (|ConvertibleTo| 39))
              (|makeByteWordVec2| 43
                                  '(2 0 0 7 6 8 1 0 9 0 10 3 0 6 0 9 6 11 1 0 7
                                    0 14 2 7 18 0 0 19 2 0 6 0 9 20 2 6 0 0 0
                                    21 2 6 0 0 0 22 0 6 0 23 2 0 0 0 0 25 2 29
                                    18 0 0 1 1 14 18 0 1 1 14 0 7 1 2 22 0 0 6
                                    1 3 20 37 0 9 9 1 1 25 18 0 1 2 21 18 27 0
                                    1 1 24 0 0 1 2 23 0 27 0 1 1 25 0 0 1 2 21
                                    0 27 0 1 2 26 18 0 0 1 2 0 18 0 7 1 3 20 6
                                    0 36 6 1 3 20 6 0 9 6 11 2 21 0 35 0 1 0 0
                                    0 1 2 22 0 0 6 1 1 23 0 0 1 1 21 0 0 1 1 22
                                    0 0 1 2 22 0 6 0 1 2 21 0 35 0 1 4 22 6 28
                                    0 6 6 1 3 21 6 28 0 6 1 2 21 6 28 0 1 3 20
                                    6 0 9 6 1 2 0 6 0 9 1 3 22 9 6 0 9 1 2 22 9
                                    6 0 1 2 21 9 35 0 1 1 0 0 12 13 1 21 12 0 1
                                    2 18 40 0 0 1 2 0 0 7 6 8 2 0 18 0 7 1 1 3
                                    9 0 10 2 25 0 0 0 1 1 25 6 0 1 2 25 0 0 0 1
                                    3 21 0 27 0 0 1 1 21 12 0 1 2 22 18 6 0 1 1
                                    3 9 0 1 2 25 0 0 0 1 1 25 6 0 1 2 21 6 27 0
                                    1 2 20 0 38 0 1 3 0 0 28 0 0 1 2 0 0 38 0 1
                                    2 0 18 0 7 1 1 19 6 0 1 2 22 0 0 6 1 1 27
                                    34 0 1 3 0 0 0 0 9 1 3 0 0 6 0 9 1 1 0 43 0
                                    1 2 0 18 9 0 1 2 27 33 33 0 1 1 27 32 0 1 1
                                    3 6 0 1 2 0 0 0 7 1 2 0 42 35 0 1 2 20 0 0
                                    6 1 2 0 0 0 12 26 2 21 18 35 0 1 3 8 0 0 12
                                    12 1 3 8 0 0 6 6 1 2 8 0 0 29 1 2 8 0 0 30
                                    1 2 0 18 0 0 1 2 22 18 6 0 1 1 0 12 0 1 1 0
                                    18 0 1 0 0 0 1 2 0 0 0 36 1 2 0 6 0 9 20 3
                                    0 6 0 9 6 1 2 17 6 0 0 1 1 0 15 0 16 2 0 0
                                    0 9 1 2 0 0 0 36 1 2 0 0 0 0 24 2 22 7 6 0
                                    1 2 21 7 35 0 1 3 23 0 0 0 9 1 1 0 0 0 1 1
                                    2 39 0 1 1 0 0 12 17 1 0 0 12 1 1 0 0 41 1
                                    2 0 0 0 0 25 2 0 0 0 6 1 2 0 0 6 0 1 1 28
                                    31 0 1 2 21 18 35 0 1 2 25 18 0 0 1 2 25 18
                                    0 0 1 2 29 18 0 0 1 2 25 18 0 0 1 2 25 18 0
                                    0 1 1 15 0 0 1 2 15 0 0 0 1 2 13 0 0 0 1 2
                                    15 0 9 0 1 2 16 0 0 6 1 2 16 0 6 0 1 1 21 7
                                    0 14)))))
           '|lookupComplete|)) 
