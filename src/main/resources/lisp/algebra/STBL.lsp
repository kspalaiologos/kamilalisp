
(DECLAIM (NOTINLINE |SparseTable;|)) 

(DEFUN |SparseTable| (&REST #1=#:G757)
  (SPROG NIL
         (PROG (#2=#:G758)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(T T NIL))
                                               (HGET |$ConstructorCache|
                                                     '|SparseTable|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |SparseTable;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|SparseTable|)))))))))) 

(DEFUN |SparseTable;| (|#1| |#2| |#3|)
  (SPROG
   ((#1=#:G756 NIL) (#2=#:G755 NIL) (|pv$| NIL) (#3=#:G753 NIL) (#4=#:G754 NIL)
    ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 |#3|)
    (LETT |dv$| (LIST '|SparseTable| DV$1 DV$2 DV$3))
    (LETT $ (GETREFV 35))
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
    (|haddProp| |$ConstructorCache| '|SparseTable| (LIST DV$1 DV$2 DV$3)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
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
    $))) 

(MAKEPROP '|SparseTable| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL
              (|GeneralSparseTable| 6 7 (|Table| 6 7) (NRTEVAL (QREFELT $ 8)))
              (|local| |#1|) (|local| |#2|) (|local| |#3|)
              (|Record| (|:| |key| 6) (|:| |entry| 7)) (|List| 9)
              (|Equation| 9) (|List| 11) (|Mapping| 9 9 9) (|Boolean|)
              (|NonNegativeInteger|) (|Equation| 7) (|List| 16) (|List| 7)
              (|OutputForm|) (|String|) (|SingleInteger|) (|HashState|)
              (|InputForm|) (|Mapping| 14 7) (|Mapping| 14 7 7)
              (|Mapping| 14 9) (|Mapping| 14 9 9) (|Mapping| 7 7) (|Void|)
              (|Mapping| 9 9) (|Mapping| 7 7 7) (|List| 6)
              (|Union| 7 '"failed") (|Union| 9 '"failed"))
           '#() 'NIL
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
                 (|ConvertibleTo| 23) (|InnerEvalable| 7 7) (|BasicType|)
                 (|CoercibleTo| 19))
              (|makeByteWordVec2| -999999 'NIL))))
           '|lookupIncomplete|)) 
