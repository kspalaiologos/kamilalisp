
(SDEFUN |LIB;library;Fn$;1| ((|f| (|FileName|)) ($ ($)))
        (SPADCALL |f| (QREFELT $ 8))) 

(SDEFUN |LIB;elt;$SA;2| ((|f| ($)) (|v| (|Symbol|)) ($ (|Any|)))
        (SPADCALL |f| (SPADCALL |v| (QREFELT $ 12)) (QREFELT $ 14))) 

(SDEFUN |LIB;setelt!;$S2A;3|
        ((|f| ($)) (|v| (|Symbol|)) (|val| (|Any|)) ($ (|Any|)))
        (SPADCALL |f| (SPADCALL |v| (QREFELT $ 12)) |val| (QREFELT $ 16))) 

(DECLAIM (NOTINLINE |Library;|)) 

(DEFUN |Library| ()
  (SPROG NIL
         (PROG (#1=#:G765)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|Library|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|Library|
                             (LIST (CONS NIL (CONS 1 (|Library;|))))))
                    (LETT #1# T))
                (COND ((NOT #1#) (HREM |$ConstructorCache| '|Library|)))))))))) 

(DEFUN |Library;| ()
  (SPROG
   ((|dv$| NIL) ($ NIL) (#1=#:G761 NIL) (#2=#:G760 NIL) (|pv$| NIL)
    (#3=#:G762 NIL) (#4=#:G763 NIL))
   (PROGN
    (LETT |dv$| '(|Library|))
    (LETT $ (GETREFV 43))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory|
                                         (|Record| (|:| |key| (|String|))
                                                   (|:| |entry| (|Any|)))
                                         '(|ConvertibleTo| (|InputForm|)))
                                        (|HasCategory|
                                         (|Record| (|:| |key| (|String|))
                                                   (|:| |entry| (|Any|)))
                                         '(|OrderedSet|))
                                        (|HasCategory|
                                         (|Record| (|:| |key| (|String|))
                                                   (|:| |entry| (|Any|)))
                                         '(|BasicType|))
                                        (|HasCategory| (|String|)
                                                       '(|OrderedSet|))
                                        (OR
                                         (|HasCategory| (|Any|)
                                                        '(|CoercibleTo|
                                                          (|OutputForm|)))
                                         (|HasCategory|
                                          (|Record| (|:| |key| (|String|))
                                                    (|:| |entry| (|Any|)))
                                          '(|CoercibleTo| (|OutputForm|))))
                                        (|HasCategory| (|Any|) '(|BasicType|))
                                        (LETT #1#
                                              (|HasCategory| (|Any|)
                                                             '(|SetCategory|)))
                                        (AND
                                         (|HasCategory| (|Any|)
                                                        '(|Evalable| (|Any|)))
                                         #1#)
                                        (LETT #2#
                                              (|HasCategory|
                                               (|Record| (|:| |key| (|String|))
                                                         (|:| |entry| (|Any|)))
                                               '(|SetCategory|)))
                                        (AND
                                         (|HasCategory|
                                          (|Record| (|:| |key| (|String|))
                                                    (|:| |entry| (|Any|)))
                                          '(|Evalable|
                                            (|Record| (|:| |key| (|String|))
                                                      (|:| |entry| (|Any|)))))
                                         #2#)
                                        (OR #1# #2#)
                                        (OR
                                         (|HasCategory| (|Any|)
                                                        '(|CoercibleTo|
                                                          (|OutputForm|)))
                                         #1#
                                         (|HasCategory|
                                          (|Record| (|:| |key| (|String|))
                                                    (|:| |entry| (|Any|)))
                                          '(|CoercibleTo| (|OutputForm|)))
                                         #2#)
                                        (|HasCategory| (|Any|)
                                                       '(|OrderedSet|))))))
    (|haddProp| |$ConstructorCache| '|Library| NIL (CONS 1 $))
    (|stuffDomainSlots| $)
    (AND (LETT #3# (|HasCategory| $ '(|finiteAggregate|)))
         (|augmentPredVector| $ 8192))
    (AND #3#
         (|HasCategory| (|Record| (|:| |key| (|String|)) (|:| |entry| (|Any|)))
                        '(|OrderedSet|))
         (|augmentPredVector| $ 16384))
    (AND #3#
         (|HasCategory| (|Record| (|:| |key| (|String|)) (|:| |entry| (|Any|)))
                        '(|BasicType|))
         (|augmentPredVector| $ 32768))
    (AND
     (LETT #4#
           (AND (|HasCategory| $ '(|finiteAggregate|))
                (|HasCategory| (|Any|) '(|BasicType|))))
     (|augmentPredVector| $ 65536))
    (AND
     (OR #4#
         (AND #3#
              (|HasCategory|
               (|Record| (|:| |key| (|String|)) (|:| |entry| (|Any|)))
               '(|BasicType|)))
         #1# #2#)
     (|augmentPredVector| $ 131072))
    (AND #3# (|HasCategory| (|Any|) '(|OrderedSet|))
         (|augmentPredVector| $ 262144))
    (AND (|HasCategory| $ '(|shallowlyMutable|))
         (|augmentPredVector| $ 524288))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 6 (|KeyedAccessFile| (|Any|)))
    $))) 

(MAKEPROP '|Library| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|KeyedAccessFile| 13) '|Rep| (|FileName|)
              (0 . |open|) |LIB;library;Fn$;1| (|String|) (|Symbol|)
              (5 . |string|) (|Any|) (10 . |elt|) |LIB;elt;$SA;2|
              (16 . |setelt!|) |LIB;setelt!;$S2A;3| (|List| 19) (|Equation| 13)
              (|List| 13) (|Record| (|:| |key| 10) (|:| |entry| 13))
              (|List| 21) (|List| 24) (|Equation| 21) (|NonNegativeInteger|)
              (|Boolean|) (|Mapping| 21 21 21) (|OutputForm|) (|HashState|)
              (|SingleInteger|) (|InputForm|) (|Mapping| 26 13)
              (|Mapping| 26 13 13) (|Mapping| 26 21) (|Mapping| 26 21 21)
              (|Mapping| 13 13) (|Void|) (|Mapping| 21 21) (|Mapping| 13 13 13)
              (|List| 10) (|Union| 13 '"failed") (|Union| 21 '"failed"))
           '#(~= 23 |table| 29 |swap!| 38 |size?| 45 |setelt!| 51 |select!| 65
              |select| 71 |search| 77 |sample| 83 |removeDuplicates| 87
              |remove!| 92 |remove| 110 |reduce| 122 |qsetelt!| 143 |qelt| 150
              |parts| 156 |pack!| 166 |more?| 171 |minIndex| 177 |min| 182
              |members| 192 |member?| 202 |maxIndex| 214 |max| 219 |map!| 241
              |map| 253 |library| 272 |less?| 277 |latex| 283 |keys| 288 |key?|
              293 |inspect| 299 |insert!| 304 |indices| 310 |index?| 315
              |hashUpdate!| 321 |hash| 327 |first| 332 |find| 337 |fill!| 343
              |extract!| 349 |every?| 354 |eval| 366 |eq?| 418 |entry?| 424
              |entries| 430 |empty?| 435 |empty| 440 |elt| 444 |dictionary| 463
              |count| 472 |copy| 496 |convert| 501 |construct| 506 |coerce| 511
              |close!| 516 |any?| 521 = 533 |#| 539)
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
              '#((|TableAggregate| 10 13) (|KeyedDictionary| 10 13)
                 (|Dictionary| 21) (|DictionaryOperations| 21)
                 (|BagAggregate| 21) (|Collection| 21)
                 (|IndexedAggregate| 10 13) (|HomogeneousAggregate| 21)
                 (|HomogeneousAggregate| 13) (|EltableAggregate| 10 13)
                 (|Aggregate|) (|Evalable| 21) (|Evalable| 13) (|SetCategory|)
                 (|Eltable| 10 13) (|Type|) (|shallowlyMutable|)
                 (|InnerEvalable| 21 21) (|ConvertibleTo| 31)
                 (|InnerEvalable| 13 13) (|BasicType|) (|CoercibleTo| 28))
              (|makeByteWordVec2| 42
                                  '(1 6 0 7 8 1 11 10 0 12 2 0 13 0 10 14 3 0
                                    13 0 10 13 16 2 18 26 0 0 1 0 0 0 1 1 0 0
                                    22 1 3 20 37 0 10 10 1 2 0 26 0 25 1 3 0 13
                                    0 11 13 17 3 0 13 0 10 13 16 2 14 0 34 0 1
                                    2 14 0 34 0 1 2 0 41 10 0 1 0 0 0 1 1 16 0
                                    0 1 2 16 0 21 0 1 2 14 0 34 0 1 2 0 41 10 0
                                    1 2 16 0 21 0 1 2 14 0 34 0 1 4 16 21 27 0
                                    21 21 1 3 14 21 27 0 21 1 2 14 21 27 0 1 3
                                    20 13 0 10 13 1 2 0 13 0 10 1 1 14 20 0 1 1
                                    14 22 0 1 1 0 0 0 1 2 0 26 0 25 1 1 4 10 0
                                    1 1 19 13 0 1 1 15 21 0 1 1 14 20 0 1 1 14
                                    22 0 1 2 17 26 13 0 1 2 16 26 21 0 1 1 4 10
                                    0 1 1 19 13 0 1 1 15 21 0 1 2 14 13 33 0 1
                                    2 14 21 35 0 1 2 20 0 36 0 1 2 20 0 38 0 1
                                    3 0 0 39 0 0 1 2 0 0 36 0 1 2 0 0 38 0 1 1
                                    0 0 7 9 2 0 26 0 25 1 1 11 10 0 1 1 0 40 0
                                    1 2 0 26 10 0 1 1 0 21 0 1 2 0 0 21 0 1 1 0
                                    40 0 1 2 0 26 10 0 1 2 11 29 29 0 1 1 11 30
                                    0 1 1 4 13 0 1 2 0 42 34 0 1 2 20 0 0 13 1
                                    1 0 21 0 1 2 14 26 32 0 1 2 14 26 34 0 1 2
                                    8 0 0 18 1 3 8 0 0 13 13 1 2 8 0 0 19 1 3 8
                                    0 0 20 20 1 3 10 0 0 21 21 1 3 10 0 0 22 22
                                    1 2 10 0 0 23 1 2 10 0 0 24 1 2 0 26 0 0 1
                                    2 17 26 13 0 1 1 0 20 0 1 1 0 26 0 1 0 0 0
                                    1 2 0 13 0 11 15 3 0 13 0 10 13 1 2 0 13 0
                                    10 14 0 0 0 1 1 0 0 22 1 2 17 25 13 0 1 2
                                    16 25 21 0 1 2 14 25 32 0 1 2 14 25 34 0 1
                                    1 0 0 0 1 1 1 31 0 1 1 0 0 22 1 1 5 28 0 1
                                    1 0 0 0 1 2 14 26 32 0 1 2 14 26 34 0 1 2
                                    18 26 0 0 1 1 14 25 0 1)))))
           '|lookupComplete|)) 

(MAKEPROP '|Library| 'NILADIC T) 
