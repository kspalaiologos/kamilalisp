
(SDEFUN |GSTBL;elt;$KeyEntry;1| ((|t| ($)) (|k| (|Key|)) ($ (|Entry|)))
        (SPROG ((|u| (|Union| |Entry| "failed")))
               (SEQ (LETT |u| (SPADCALL |k| |t| (QREFELT $ 12)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (QREFELT $ 9)) ('T (QCDR |u|))))))) 

(SDEFUN |GSTBL;setelt!;$Key2Entry;2|
        ((|t| ($)) (|k| (|Key|)) (|e| (|Entry|)) ($ (|Entry|)))
        (SEQ
         (COND
          ((SPADCALL |e| (QREFELT $ 9) (QREFELT $ 15))
           (SEQ (SPADCALL |k| |t| (QREFELT $ 16)) (EXIT |e|)))
          ('T (SPADCALL |t| |k| |e| (QREFELT $ 17)))))) 

(SDEFUN |GSTBL;search;Key$U;3|
        ((|k| (|Key|)) (|t| ($)) ($ (|Union| |Entry| #1="failed")))
        (SPROG ((|u| (|Union| |Entry| #1#)))
               (SEQ (LETT |u| (SPADCALL |k| |t| (QREFELT $ 12)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (CONS 0 (QREFELT $ 9))) ('T |u|)))))) 

(DECLAIM (NOTINLINE |GeneralSparseTable;|)) 

(DEFUN |GeneralSparseTable| (&REST #1=#:G766)
  (SPROG NIL
         (PROG (#2=#:G767)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T T T NIL))
                     (HGET |$ConstructorCache| '|GeneralSparseTable|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |GeneralSparseTable;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|GeneralSparseTable|)))))))))) 

(DEFUN |GeneralSparseTable;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((#1=#:G765 NIL) (#2=#:G764 NIL) (|pv$| NIL) (#3=#:G762 NIL) (#4=#:G763 NIL)
    ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 |#4|)
    (LETT |dv$| (LIST '|GeneralSparseTable| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 44))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory|
                                         (|Record| (|:| |key| |#1|)
                                                   (|:| |entry| |#2|))
                                         '(|ConvertibleTo| (|InputForm|)))
                                        (|HasCategory|
                                         (|Record| (|:| |key| |#1|)
                                                   (|:| |entry| |#2|))
                                         '(|OrderedSet|))
                                        (|HasCategory|
                                         (|Record| (|:| |key| |#1|)
                                                   (|:| |entry| |#2|))
                                         '(|BasicType|))
                                        (|HasCategory| |#1| '(|OrderedSet|))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|CoercibleTo|
                                                          (|OutputForm|)))
                                         (|HasCategory|
                                          (|Record| (|:| |key| |#1|)
                                                    (|:| |entry| |#2|))
                                          '(|CoercibleTo| (|OutputForm|))))
                                        (|HasCategory| |#2| '(|BasicType|))
                                        (LETT #4#
                                              (|HasCategory| |#2|
                                                             '(|SetCategory|)))
                                        (AND
                                         (|HasCategory| |#2|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#2|)))
                                         #4#)
                                        (LETT #3#
                                              (|HasCategory|
                                               (|Record| (|:| |key| |#1|)
                                                         (|:| |entry| |#2|))
                                               '(|SetCategory|)))
                                        (AND
                                         (|HasCategory|
                                          (|Record| (|:| |key| |#1|)
                                                    (|:| |entry| |#2|))
                                          (LIST '|Evalable|
                                                (LIST '|Record|
                                                      (LIST '|:| '|key|
                                                            (|devaluate| |#1|))
                                                      (LIST '|:| '|entry|
                                                            (|devaluate|
                                                             |#2|)))))
                                         #3#)
                                        (OR #4# #3#)
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|CoercibleTo|
                                                          (|OutputForm|)))
                                         #4#
                                         (|HasCategory|
                                          (|Record| (|:| |key| |#1|)
                                                    (|:| |entry| |#2|))
                                          '(|CoercibleTo| (|OutputForm|)))
                                         #3#)
                                        (|HasCategory| |#2|
                                                       '(|OrderedSet|))))))
    (|haddProp| |$ConstructorCache| '|GeneralSparseTable|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 5 |#3|)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (AND (LETT #2# (|HasCategory| $ '(|finiteAggregate|)))
         (|augmentPredVector| $ 8192))
    (AND #2#
         (|HasCategory| (|Record| (|:| |key| |#1|) (|:| |entry| |#2|))
                        '(|OrderedSet|))
         (|augmentPredVector| $ 16384))
    (AND #2#
         (|HasCategory| (|Record| (|:| |key| |#1|) (|:| |entry| |#2|))
                        '(|BasicType|))
         (|augmentPredVector| $ 32768))
    (AND
     (LETT #1#
           (AND (|HasCategory| |#2| '(|BasicType|))
                (|HasCategory| $ '(|finiteAggregate|))))
     (|augmentPredVector| $ 65536))
    (AND
     (OR #1# #4#
         (AND #2#
              (|HasCategory| (|Record| (|:| |key| |#1|) (|:| |entry| |#2|))
                             '(|BasicType|)))
         #3#)
     (|augmentPredVector| $ 131072))
    (AND (|HasCategory| |#2| '(|OrderedSet|)) #2#
         (|augmentPredVector| $ 262144))
    (AND (|HasCategory| $ '(|shallowlyMutable|))
         (|augmentPredVector| $ 524288))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 10 |#3|)
    $))) 

(MAKEPROP '|GeneralSparseTable| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|local| |#3|) (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) '|Rep| (|Union| 7 '"failed")
              (0 . |search|) |GSTBL;elt;$KeyEntry;1| (|Boolean|) (6 . =)
              (12 . |remove!|) (18 . |setelt!|) |GSTBL;setelt!;$Key2Entry;2|
              |GSTBL;search;Key$U;3| (|Record| (|:| |key| 6) (|:| |entry| 7))
              (|List| 20) (|Equation| 20) (|List| 22) (|Mapping| 20 20 20)
              (|NonNegativeInteger|) (|Equation| 7) (|List| 26) (|List| 7)
              (|OutputForm|) (|String|) (|SingleInteger|) (|HashState|)
              (|InputForm|) (|Mapping| 14 7) (|Mapping| 14 7 7)
              (|Mapping| 14 20) (|Mapping| 14 20 20) (|Mapping| 7 7) (|Void|)
              (|Mapping| 20 20) (|Mapping| 7 7 7) (|List| 6)
              (|Union| 20 '"failed"))
           '#(~= 25 |table| 31 |swap!| 40 |size?| 47 |setelt!| 53 |select!| 60
              |select| 66 |search| 72 |sample| 78 |removeDuplicates| 82
              |remove!| 87 |remove| 105 |reduce| 117 |qsetelt!| 138 |qelt| 145
              |parts| 151 |more?| 161 |minIndex| 167 |min| 172 |members| 182
              |member?| 192 |maxIndex| 204 |max| 209 |map!| 231 |map| 243
              |less?| 262 |latex| 268 |keys| 273 |key?| 278 |inspect| 284
              |insert!| 289 |indices| 295 |index?| 300 |hashUpdate!| 306 |hash|
              312 |first| 317 |find| 322 |fill!| 328 |extract!| 334 |every?|
              339 |eval| 351 |eq?| 403 |entry?| 409 |entries| 415 |empty?| 420
              |empty| 425 |elt| 429 |dictionary| 442 |count| 451 |copy| 475
              |convert| 480 |construct| 485 |coerce| 490 |any?| 495 = 507 |#|
              513)
           'NIL
           (CONS
            (|makeByteWordVec2| 12
                                '(0 0 0 0 0 0 0 0 0 0 0 10 8 11 0 0 0 10 1 8 11
                                  12))
            (CONS
             '#(|TableAggregate&| |KeyedDictionary&| |Dictionary&|
                |DictionaryOperations&| |BagAggregate&| |Collection&|
                |IndexedAggregate&| |HomogeneousAggregate&|
                |HomogeneousAggregate&| |EltableAggregate&| |Aggregate&|
                |Evalable&| |Evalable&| |SetCategory&| NIL NIL NIL
                |InnerEvalable&| NIL |InnerEvalable&| |BasicType&| NIL)
             (CONS
              '#((|TableAggregate| 6 7) (|KeyedDictionary| 6 7)
                 (|Dictionary| (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|DictionaryOperations|
                  (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|BagAggregate| (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|Collection| (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|IndexedAggregate| 6 7)
                 (|HomogeneousAggregate|
                  (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|HomogeneousAggregate| 7) (|EltableAggregate| 6 7)
                 (|Aggregate|)
                 (|Evalable| (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|Evalable| 7) (|SetCategory|) (|Eltable| 6 7) (|Type|)
                 (|shallowlyMutable|)
                 (|InnerEvalable| (|Record| (|:| |key| 6) (|:| |entry| 7))
                                  (|Record| (|:| |key| 6) (|:| |entry| 7)))
                 (|ConvertibleTo| 33) (|InnerEvalable| 7 7) (|BasicType|)
                 (|CoercibleTo| 29))
              (|makeByteWordVec2| 43
                                  '(2 10 11 6 0 12 2 7 14 0 0 15 2 0 11 6 0 16
                                    3 10 7 0 6 7 17 2 18 14 0 0 1 1 0 0 21 1 0
                                    0 0 1 3 20 39 0 6 6 1 2 0 14 0 25 1 3 0 7 0
                                    6 7 18 2 14 0 36 0 1 2 14 0 36 0 1 2 0 11 6
                                    0 19 0 0 0 1 1 16 0 0 1 2 16 0 20 0 1 2 14
                                    0 36 0 1 2 0 11 6 0 16 2 16 0 20 0 1 2 14 0
                                    36 0 1 4 16 20 24 0 20 20 1 3 14 20 24 0 20
                                    1 2 14 20 24 0 1 3 20 7 0 6 7 1 2 0 7 0 6 1
                                    1 14 28 0 1 1 14 21 0 1 2 0 14 0 25 1 1 4 6
                                    0 1 1 15 20 0 1 1 19 7 0 1 1 14 28 0 1 1 14
                                    21 0 1 2 16 14 20 0 1 2 17 14 7 0 1 1 4 6 0
                                    1 1 15 20 0 1 1 19 7 0 1 2 14 7 35 0 1 2 14
                                    20 37 0 1 2 20 0 38 0 1 2 20 0 40 0 1 3 0 0
                                    41 0 0 1 2 0 0 38 0 1 2 0 0 40 0 1 2 0 14 0
                                    25 1 1 11 30 0 1 1 0 42 0 1 2 0 14 6 0 1 1
                                    0 20 0 1 2 0 0 20 0 1 1 0 42 0 1 2 0 14 6 0
                                    1 2 11 32 32 0 1 1 11 31 0 1 1 4 7 0 1 2 0
                                    43 36 0 1 2 20 0 0 7 1 1 0 20 0 1 2 14 14
                                    34 0 1 2 14 14 36 0 1 3 10 0 0 21 21 1 2 10
                                    0 0 22 1 3 10 0 0 20 20 1 2 10 0 0 23 1 2 8
                                    0 0 26 1 2 8 0 0 27 1 3 8 0 0 7 7 1 3 8 0 0
                                    28 28 1 2 0 14 0 0 1 2 17 14 7 0 1 1 0 28 0
                                    1 1 0 14 0 1 0 0 0 1 3 0 7 0 6 7 1 2 0 7 0
                                    6 13 0 0 0 1 1 0 0 21 1 2 16 25 20 0 1 2 17
                                    25 7 0 1 2 14 25 34 0 1 2 14 25 36 0 1 1 0
                                    0 0 1 1 1 33 0 1 1 0 0 21 1 1 5 29 0 1 2 14
                                    14 34 0 1 2 14 14 36 0 1 2 18 14 0 0 1 1 14
                                    25 0 1)))))
           '|lookupComplete|)) 
