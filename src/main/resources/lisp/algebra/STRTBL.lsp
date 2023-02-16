
(DECLAIM (NOTINLINE |StringTable;|)) 

(DEFUN |StringTable| (#1=#:G757)
  (SPROG NIL
         (PROG (#2=#:G758)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|StringTable|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|StringTable;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|StringTable|)))))))))) 

(DEFUN |StringTable;| (|#1|)
  (SPROG
   ((#1=#:G756 NIL) (#2=#:G755 NIL) (|pv$| NIL) (#3=#:G753 NIL) (#4=#:G754 NIL)
    ($ NIL) (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|StringTable| DV$1))
    (LETT $ (GETREFV 33))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory|
                                         (|Record| (|:| |key| (|String|))
                                                   (|:| |entry| |#1|))
                                         '(|ConvertibleTo| (|InputForm|)))
                                        (|HasCategory|
                                         (|Record| (|:| |key| (|String|))
                                                   (|:| |entry| |#1|))
                                         '(|OrderedSet|))
                                        (|HasCategory|
                                         (|Record| (|:| |key| (|String|))
                                                   (|:| |entry| |#1|))
                                         '(|BasicType|))
                                        (|HasCategory| (|String|)
                                                       '(|OrderedSet|))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|CoercibleTo|
                                                          (|OutputForm|)))
                                         (|HasCategory|
                                          (|Record| (|:| |key| (|String|))
                                                    (|:| |entry| |#1|))
                                          '(|CoercibleTo| (|OutputForm|))))
                                        (|HasCategory| |#1| '(|BasicType|))
                                        (LETT #4#
                                              (|HasCategory| |#1|
                                                             '(|SetCategory|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#1|)))
                                         #4#)
                                        (LETT #3#
                                              (|HasCategory|
                                               (|Record| (|:| |key| (|String|))
                                                         (|:| |entry| |#1|))
                                               '(|SetCategory|)))
                                        (AND
                                         (|HasCategory|
                                          (|Record| (|:| |key| (|String|))
                                                    (|:| |entry| |#1|))
                                          (LIST '|Evalable|
                                                (LIST '|Record|
                                                      '(|:| |key| (|String|))
                                                      (LIST '|:| '|entry|
                                                            (|devaluate|
                                                             |#1|)))))
                                         #3#)
                                        (OR (|HasCategory| |#1| '(|BasicType|))
                                            #4#
                                            (|HasCategory|
                                             (|Record| (|:| |key| (|String|))
                                                       (|:| |entry| |#1|))
                                             '(|BasicType|))
                                            #3#)
                                        (OR #4# #3#)
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|CoercibleTo|
                                                          (|OutputForm|)))
                                         #4#
                                         (|HasCategory|
                                          (|Record| (|:| |key| (|String|))
                                                    (|:| |entry| |#1|))
                                          '(|CoercibleTo| (|OutputForm|)))
                                         #3#)
                                        (|HasCategory| |#1|
                                                       '(|OrderedSet|))))))
    (|haddProp| |$ConstructorCache| '|StringTable| (LIST DV$1) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (AND (LETT #2# (|HasCategory| $ '(|finiteAggregate|)))
         (|augmentPredVector| $ 16384))
    (AND #2#
         (|HasCategory| (|Record| (|:| |key| (|String|)) (|:| |entry| |#1|))
                        '(|OrderedSet|))
         (|augmentPredVector| $ 32768))
    (AND #2#
         (|HasCategory| (|Record| (|:| |key| (|String|)) (|:| |entry| |#1|))
                        '(|BasicType|))
         (|augmentPredVector| $ 65536))
    (AND
     (LETT #1#
           (AND (|HasCategory| |#1| '(|BasicType|))
                (|HasCategory| $ '(|finiteAggregate|))))
     (|augmentPredVector| $ 131072))
    (AND
     (OR #1# #4#
         (AND #2#
              (|HasCategory|
               (|Record| (|:| |key| (|String|)) (|:| |entry| |#1|))
               '(|BasicType|)))
         #3#)
     (|augmentPredVector| $ 262144))
    (AND (|HasCategory| |#1| '(|OrderedSet|)) #2#
         (|augmentPredVector| $ 524288))
    (AND (|HasCategory| $ '(|shallowlyMutable|))
         (|augmentPredVector| $ 1048576))
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|StringTable| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|HashTable| 18 6 '"CVEC") (|local| |#1|)
              (|Record| (|:| |key| 18) (|:| |entry| 6)) (|List| 7)
              (|Equation| 7) (|List| 9) (|Mapping| 7 7 7) (|Boolean|)
              (|NonNegativeInteger|) (|Equation| 6) (|List| 14) (|List| 6)
              (|OutputForm|) (|String|) (|SingleInteger|) (|HashState|)
              (|InputForm|) (|Mapping| 12 6) (|Mapping| 12 6 6)
              (|Mapping| 12 7) (|Mapping| 12 7 7) (|Mapping| 6 6) (|Void|)
              (|Mapping| 7 7) (|Mapping| 6 6 6) (|List| 18)
              (|Union| 6 '"failed") (|Union| 7 '"failed"))
           '#() 'NIL
           (CONS
            (|makeByteWordVec2| 13
                                '(0 0 0 0 0 0 0 0 0 0 0 10 8 12 0 0 0 0 10 1 8
                                  11 13))
            (CONS
             '#(|TableAggregate&| |KeyedDictionary&| |Dictionary&|
                |DictionaryOperations&| |BagAggregate&| |Collection&|
                |IndexedAggregate&| |HomogeneousAggregate&|
                |HomogeneousAggregate&| |EltableAggregate&| |Aggregate&|
                |Evalable&| |Evalable&| |SetCategory&| NIL NIL NIL NIL
                |InnerEvalable&| NIL |InnerEvalable&| |BasicType&| NIL)
             (CONS
              '#((|TableAggregate| 18 6) (|KeyedDictionary| 18 6)
                 (|Dictionary| (|Record| (|:| |key| 18) (|:| |entry| 6)))
                 (|DictionaryOperations|
                  (|Record| (|:| |key| 18) (|:| |entry| 6)))
                 (|BagAggregate| (|Record| (|:| |key| 18) (|:| |entry| 6)))
                 (|Collection| (|Record| (|:| |key| 18) (|:| |entry| 6)))
                 (|IndexedAggregate| 18 6)
                 (|HomogeneousAggregate|
                  (|Record| (|:| |key| 18) (|:| |entry| 6)))
                 (|HomogeneousAggregate| 6) (|EltableAggregate| 18 6)
                 (|Aggregate|)
                 (|Evalable| (|Record| (|:| |key| 18) (|:| |entry| 6)))
                 (|Evalable| 6) (|SetCategory|) (|finiteAggregate|)
                 (|Eltable| 18 6) (|Type|) (|shallowlyMutable|)
                 (|InnerEvalable| (|Record| (|:| |key| 18) (|:| |entry| 6))
                                  (|Record| (|:| |key| 18) (|:| |entry| 6)))
                 (|ConvertibleTo| 21) (|InnerEvalable| 6 6) (|BasicType|)
                 (|CoercibleTo| 17))
              (|makeByteWordVec2| -999999 'NIL))))
           '|lookupIncomplete|)) 
