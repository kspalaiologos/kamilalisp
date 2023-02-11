
(SDEFUN |IBITS;minIndex;$I;1| ((|u| ($)) ($ (|Integer|))) (QREFELT $ 6)) 

(SDEFUN |IBITS;range| ((|v| ($)) (|i| (|Integer|)) ($ (|Integer|)))
        (SEQ
         (COND
          ((>= |i| 0)
           (COND ((< |i| (SPADCALL |v| (QREFELT $ 10))) (EXIT |i|)))))
         (EXIT (|error| "Index out of range")))) 

(SDEFUN |IBITS;coerce;$Of;3| ((|v| ($)) ($ (|OutputForm|)))
        (SPROG
         ((#1=#:G711 NIL) (|i| NIL) (|j| NIL) (|s| (|String|))
          (|f| #2=(|Character|)) (|t| #2#))
         (SEQ (LETT |t| (|STR_to_CHAR| "1")) (LETT |f| (|STR_to_CHAR| "0"))
              (LETT |s|
                    (|make_full_CVEC2| (SPADCALL |v| (QREFELT $ 10))
                                       (SPADCALL (QREFELT $ 12))))
              (SEQ (LETT |j| (QREFELT $ 6))
                   (LETT |i| (SPADCALL |s| (QREFELT $ 14)))
                   (LETT #1# (SPADCALL |s| (QREFELT $ 15))) G190
                   (COND ((> |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |s| |i|
                               (COND ((SPADCALL |v| |j| (QREFELT $ 17)) |t|)
                                     ('T |f|))
                               (QREFELT $ 18))))
                   (LETT |i| (PROG1 (+ |i| 1) (LETT |j| (+ |j| 1)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT (SPADCALL |s| (QREFELT $ 20)))))) 

(SDEFUN |IBITS;new;NniB$;4|
        ((|n| (|NonNegativeInteger|)) (|b| (|Boolean|)) ($ ($)))
        (|make_BVEC| |n| (|bool_to_bit| |b|))) 

(PUT '|IBITS;empty;$;5| '|SPADreplace| '(XLAM NIL (|make_BVEC| 0 0))) 

(SDEFUN |IBITS;empty;$;5| (($ ($))) (|make_BVEC| 0 0)) 

(PUT '|IBITS;copy;2$;6| '|SPADreplace| '|copy_BVEC|) 

(SDEFUN |IBITS;copy;2$;6| ((|v| ($)) ($ ($))) (|copy_BVEC| |v|)) 

(PUT '|IBITS;#;$Nni;7| '|SPADreplace| '|size_BVEC|) 

(SDEFUN |IBITS;#;$Nni;7| ((|v| ($)) ($ (|NonNegativeInteger|)))
        (|size_BVEC| |v|)) 

(PUT '|IBITS;=;2$B;8| '|SPADreplace| '|equal_BVEC|) 

(SDEFUN |IBITS;=;2$B;8| ((|v| ($)) (|u| ($)) ($ (|Boolean|)))
        (|equal_BVEC| |v| |u|)) 

(PUT '|IBITS;<;2$B;9| '|SPADreplace| '(XLAM (|v| |u|) (|greater_BVEC| |u| |v|))) 

(SDEFUN |IBITS;<;2$B;9| ((|v| ($)) (|u| ($)) ($ (|Boolean|)))
        (|greater_BVEC| |u| |v|)) 

(SDEFUN |IBITS;and;3$;10| ((|u| ($)) (|v| ($)) ($ ($)))
        (COND
         ((EQL (SPADCALL |v| (QREFELT $ 10)) (SPADCALL |u| (QREFELT $ 10)))
          (|and_BVEC| |v| |u|))
         ('T (SPADCALL (ELT $ 27) |v| |u| (QREFELT $ 29))))) 

(SDEFUN |IBITS;or;3$;11| ((|u| ($)) (|v| ($)) ($ ($)))
        (COND
         ((EQL (SPADCALL |v| (QREFELT $ 10)) (SPADCALL |u| (QREFELT $ 10)))
          (|or_BVEC| |v| |u|))
         ('T (SPADCALL (ELT $ 31) |v| |u| (QREFELT $ 29))))) 

(SDEFUN |IBITS;xor;3$;12| ((|v| ($)) (|u| ($)) ($ ($)))
        (COND
         ((EQL (SPADCALL |v| (QREFELT $ 10)) (SPADCALL |u| (QREFELT $ 10)))
          (|xor_BVEC| |v| |u|))
         ('T (SPADCALL (ELT $ 33) |v| |u| (QREFELT $ 29))))) 

(SDEFUN |IBITS;setelt!;$I2B;13|
        ((|v| ($)) (|i| (|Integer|)) (|f| #1=(|Boolean|)) ($ #1#))
        (SETELT_BVEC |v| (|IBITS;range| |v| (- |i| (QREFELT $ 6)) $)
                     (|bool_to_bit| |f|))) 

(SDEFUN |IBITS;elt;$IB;14| ((|v| ($)) (|i| (|Integer|)) ($ (|Boolean|)))
        (|bit_to_bool|
         (ELT_BVEC |v| (|IBITS;range| |v| (- |i| (QREFELT $ 6)) $)))) 

(PUT '|IBITS;Not;2$;15| '|SPADreplace| '|not_BVEC|) 

(SDEFUN |IBITS;Not;2$;15| ((|v| ($)) ($ ($))) (|not_BVEC| |v|)) 

(SDEFUN |IBITS;And;3$;16| ((|u| ($)) (|v| ($)) ($ ($)))
        (COND
         ((EQL (SPADCALL |v| (QREFELT $ 10)) (SPADCALL |u| (QREFELT $ 10)))
          (|and_BVEC| |v| |u|))
         ('T (SPADCALL (ELT $ 27) |v| |u| (QREFELT $ 29))))) 

(SDEFUN |IBITS;Or;3$;17| ((|u| ($)) (|v| ($)) ($ ($)))
        (COND
         ((EQL (SPADCALL |v| (QREFELT $ 10)) (SPADCALL |u| (QREFELT $ 10)))
          (|or_BVEC| |v| |u|))
         ('T (SPADCALL (ELT $ 31) |v| |u| (QREFELT $ 29))))) 

(DECLAIM (NOTINLINE |IndexedBits;|)) 

(DEFUN |IndexedBits| (#1=#:G750)
  (SPROG NIL
         (PROG (#2=#:G751)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST #1#)
                                               (HGET |$ConstructorCache|
                                                     '|IndexedBits|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|IndexedBits;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|IndexedBits|)))))))))) 

(DEFUN |IndexedBits;| (|#1|)
  (SPROG ((#1=#:G749 NIL) (|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT |dv$| (LIST '|IndexedBits| DV$1))
          (LETT $ (GETREFV 51))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (AND
                                               (|HasCategory| (|Boolean|)
                                                              '(|Evalable|
                                                                (|Boolean|)))
                                               (|HasCategory| (|Boolean|)
                                                              '(|SetCategory|)))
                                              (|HasCategory| (|Boolean|)
                                                             '(|ConvertibleTo|
                                                               (|InputForm|)))
                                              (|HasCategory| (|Boolean|)
                                                             '(|OrderedSet|))
                                              (|HasCategory| (|Integer|)
                                                             '(|OrderedSet|))
                                              (|HasCategory| (|Boolean|)
                                                             '(|BasicType|))))))
          (|haddProp| |$ConstructorCache| '|IndexedBits| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (AND (|HasCategory| $ '(|shallowlyMutable|))
               (|augmentPredVector| $ 32))
          (AND (LETT #1# (|HasCategory| $ '(|finiteAggregate|)))
               (|augmentPredVector| $ 64))
          (AND #1# (|HasCategory| $ '(|shallowlyMutable|))
               (|HasCategory| (|Boolean|) '(|OrderedSet|))
               (|augmentPredVector| $ 128))
          (AND #1# (|HasCategory| $ '(|shallowlyMutable|))
               (|augmentPredVector| $ 256))
          (AND #1# (|HasCategory| (|Boolean|) '(|BasicType|))
               (|augmentPredVector| $ 512))
          (AND #1# (|HasCategory| (|Boolean|) '(|OrderedSet|))
               (|augmentPredVector| $ 1024))
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|IndexedBits| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Integer|)
              |IBITS;minIndex;$I;1| (|NonNegativeInteger|) |IBITS;#;$Nni;7|
              (|Character|) (0 . |space|) (|String|) (4 . |minIndex|)
              (9 . |maxIndex|) (|Boolean|) |IBITS;elt;$IB;14| (14 . |setelt!|)
              (|OutputForm|) (21 . |coerce|) |IBITS;coerce;$Of;3|
              |IBITS;new;NniB$;4| |IBITS;empty;$;5| |IBITS;copy;2$;6|
              |IBITS;=;2$B;8| |IBITS;<;2$B;9| (26 . |and|) (|Mapping| 16 16 16)
              (32 . |map|) |IBITS;and;3$;10| (39 . |or|) |IBITS;or;3$;11|
              (45 . |xor|) |IBITS;xor;3$;12| |IBITS;setelt!;$I2B;13|
              |IBITS;Not;2$;15| |IBITS;And;3$;16| |IBITS;Or;3$;17| (|List| 40)
              (|Equation| 16) (|List| 16) (|InputForm|) (|Mapping| 16 16)
              (|Void|) (|UniversalSegment| 7) (|List| 7) (|Union| 16 '"failed")
              (|List| $) (|HashState|) (|SingleInteger|))
           '#(~= 51 ~ 57 |xor| 62 |true| 68 |trim| 72 |swap!| 78 |sorted?| 85
              |sort!| 96 |sort| 107 |smaller?| 118 |size?| 124 |setelt!| 130
              |select| 144 |sample| 150 |rightTrim| 154 |reverse!| 160
              |reverse| 165 |removeDuplicates| 170 |remove| 175 |reduce| 187
              |qsetelt!| 208 |qelt| 215 |position| 221 |parts| 240 |or| 245
              |not| 251 |nor| 256 |new| 262 |nand| 268 |more?| 274 |minIndex|
              280 |min| 285 |merge| 296 |members| 309 |member?| 314 |maxIndex|
              320 |max| 325 |map!| 342 |map| 348 |less?| 361 |leftTrim| 367
              |latex| 373 |insert| 378 |indices| 392 |index?| 397 |hashUpdate!|
              403 |hash| 409 |first| 414 |find| 425 |fill!| 431 |false| 437
              |every?| 441 |eval| 447 |eq?| 473 |entry?| 479 |entries| 485
              |empty?| 490 |empty| 495 |elt| 499 |delete| 518 |count| 530
              |copyInto!| 542 |copy| 549 |convert| 554 |construct| 559 |concat|
              564 |coerce| 587 |any?| 592 |and| 598 |_\|_| 604 |\\/| 608 T$ 614
              |Or| 618 |Not| 624 |And| 629 >= 635 > 641 = 647 <= 653 < 659
              |/\\| 665 |#| 671)
           'NIL
           (CONS
            (|makeByteWordVec2| 2
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0
                                  0 0 0 0 0 0 0 1 2))
            (CONS
             '#(|BitAggregate&| |OneDimensionalArrayAggregate&| |Logic&| NIL
                NIL |LinearAggregate&| NIL NIL |OrderedSet&| |Collection&|
                |IndexedAggregate&| NIL NIL NIL NIL |HomogeneousAggregate&| NIL
                NIL |EltableAggregate&| |Aggregate&| |SetCategory&| |Evalable&|
                NIL NIL NIL NIL NIL |BasicType&| |PartialOrder&| NIL
                |InnerEvalable&| NIL)
             (CONS
              '#((|BitAggregate|) (|OneDimensionalArrayAggregate| 16) (|Logic|)
                 (|FiniteLinearAggregate| 16) (|BoundedDistributiveLattice|)
                 (|LinearAggregate| 16) (|DistributiveLattice|)
                 (|BoundedLattice|) (|OrderedSet|) (|Collection| 16)
                 (|IndexedAggregate| 7 16) (|Lattice|)
                 (|BoundedJoinSemilattice|) (|BoundedMeetSemilattice|)
                 (|Comparable|) (|HomogeneousAggregate| 16) (|JoinSemilattice|)
                 (|MeetSemilattice|) (|EltableAggregate| 7 16) (|Aggregate|)
                 (|SetCategory|) (|Evalable| 16) (|shallowlyMutable|)
                 (|finiteAggregate|) (|Eltable| 45 $$) (|Eltable| 7 16)
                 (|Type|) (|BasicType|) (|PartialOrder|) (|CoercibleTo| 19)
                 (|InnerEvalable| 16 16) (|ConvertibleTo| 42))
              (|makeByteWordVec2| 50
                                  '(0 11 0 12 1 13 7 0 14 1 13 7 0 15 3 13 11 0
                                    7 11 18 1 13 19 0 20 2 16 0 0 0 27 3 0 0 28
                                    0 0 29 2 16 0 0 0 31 2 16 0 0 0 33 2 0 16 0
                                    0 1 1 0 0 0 1 2 0 0 0 0 34 0 0 0 1 2 10 0 0
                                    16 1 3 6 44 0 7 7 1 1 11 16 0 1 2 7 16 28 0
                                    1 1 8 0 0 1 2 9 0 28 0 1 1 11 0 0 1 2 7 0
                                    28 0 1 2 0 16 0 0 1 2 0 16 0 9 1 3 6 16 0 7
                                    16 35 3 6 16 0 45 16 1 2 7 0 43 0 1 0 0 0 1
                                    2 10 0 0 16 1 1 9 0 0 1 1 7 0 0 1 1 10 0 0
                                    1 2 10 0 16 0 1 2 7 0 43 0 1 4 10 16 28 0
                                    16 16 1 3 7 16 28 0 16 1 2 7 16 28 0 1 3 6
                                    16 0 7 16 1 2 0 16 0 7 1 2 10 7 16 0 1 3 10
                                    7 16 0 7 1 2 7 7 43 0 1 1 7 41 0 1 2 0 0 0
                                    0 32 1 0 0 0 1 2 0 0 0 0 1 2 0 0 9 16 22 2
                                    0 0 0 0 1 2 0 16 0 9 1 1 4 7 0 8 1 11 16 0
                                    1 2 0 0 0 0 1 2 11 0 0 0 1 3 7 0 28 0 0 1 1
                                    7 41 0 1 2 10 16 16 0 1 1 4 7 0 1 1 11 16 0
                                    1 2 7 16 28 0 1 2 0 0 0 0 1 2 6 0 43 0 1 2
                                    0 0 43 0 1 3 0 0 28 0 0 29 2 0 16 0 9 1 2
                                    10 0 0 16 1 1 0 13 0 1 3 0 0 0 0 7 1 3 0 0
                                    16 0 7 1 1 0 46 0 1 2 0 16 7 0 1 2 0 49 49
                                    0 1 1 0 50 0 1 1 4 16 0 1 2 0 0 0 9 1 2 0
                                    47 43 0 1 2 6 0 0 16 1 0 0 0 1 2 7 16 43 0
                                    1 2 1 0 0 39 1 3 1 0 0 16 16 1 2 1 0 0 40 1
                                    3 1 0 0 41 41 1 2 0 16 0 0 1 2 10 16 16 0 1
                                    1 0 41 0 1 1 0 16 0 1 0 0 0 23 3 0 16 0 7
                                    16 1 2 0 16 0 7 17 2 0 0 0 45 1 2 0 0 0 45
                                    1 2 0 0 0 7 1 2 10 9 16 0 1 2 7 9 43 0 1 3
                                    9 0 0 0 7 1 1 0 0 0 24 1 2 42 0 1 1 0 0 41
                                    1 2 0 0 0 16 1 2 0 0 0 0 1 2 0 0 16 0 1 1 0
                                    0 48 1 1 0 19 0 21 2 7 16 43 0 1 2 0 0 0 0
                                    30 0 0 0 1 2 0 0 0 0 1 0 0 0 1 2 0 0 0 0 38
                                    1 0 0 0 36 2 0 0 0 0 37 2 0 16 0 0 1 2 0 16
                                    0 0 1 2 0 16 0 0 25 2 0 16 0 0 1 2 0 16 0 0
                                    26 2 0 0 0 0 1 1 7 9 0 10)))))
           '|lookupComplete|)) 
