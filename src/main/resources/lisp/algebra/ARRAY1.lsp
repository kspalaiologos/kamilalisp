
(PUT '|ARRAY1;qelt;$IS;1| '|SPADreplace| '(XLAM (|x| |i|) (QAREF1O |x| |i| 1))) 

(SDEFUN |ARRAY1;qelt;$IS;1| ((|x| ($)) (|i| (|Integer|)) ($ (S)))
        (QAREF1O |x| |i| 1)) 

(PUT '|ARRAY1;qsetelt!;$I2S;2| '|SPADreplace|
     '(XLAM (|x| |i| |s|) (QSETAREF1O |x| |i| |s| 1))) 

(SDEFUN |ARRAY1;qsetelt!;$I2S;2|
        ((|x| ($)) (|i| (|Integer|)) (|s| (S)) ($ (S)))
        (QSETAREF1O |x| |i| |s| 1)) 

(SDEFUN |ARRAY1;oneDimensionalArray;L$;3| ((|u| (|List| S)) ($ ($)))
        (SPROG
         ((#1=#:G3026 NIL) (|i| NIL) (#2=#:G3027 NIL) (|x| NIL) (|a| ($))
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (LENGTH |u|))
              (EXIT
               (COND ((EQL |n| 0) (MAKE-ARRAY 0))
                     ('T
                      (SEQ (LETT |a| (MAKEARR1 |n| (|SPADfirst| |u|)))
                           (SEQ (LETT |x| NIL) (LETT #2# (CDR |u|))
                                (LETT |i| 2) (LETT #1# |n|) G190
                                (COND
                                 ((OR (|greater_SI| |i| #1#) (ATOM #2#)
                                      (PROGN (LETT |x| (CAR #2#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT (SPADCALL |a| |i| |x| (QREFELT $ 10))))
                                (LETT |i|
                                      (PROG1 (|inc_SI| |i|)
                                        (LETT #2# (CDR #2#))))
                                (GO G190) G191 (EXIT NIL))
                           (EXIT |a|)))))))) 

(PUT '|ARRAY1;oneDimensionalArray;NniS$;4| '|SPADreplace| 'MAKEARR1) 

(SDEFUN |ARRAY1;oneDimensionalArray;NniS$;4|
        ((|n| (|NonNegativeInteger|)) (|s| (S)) ($ ($))) (MAKEARR1 |n| |s|)) 

(DECLAIM (NOTINLINE |OneDimensionalArray;|)) 

(DEFUN |OneDimensionalArray| (#1=#:G3039)
  (SPROG NIL
         (PROG (#2=#:G3040)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|OneDimensionalArray|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|OneDimensionalArray;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|OneDimensionalArray|)))))))))) 

(DEFUN |OneDimensionalArray;| (|#1|)
  (SPROG
   ((|pv$| NIL) (#1=#:G3036 NIL) (#2=#:G3037 NIL) (#3=#:G3038 NIL) ($ NIL)
    (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|OneDimensionalArray| DV$1))
    (LETT $ (GETREFV 32))
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
                                            #2#)))))
    (|haddProp| |$ConstructorCache| '|OneDimensionalArray| (LIST DV$1)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (AND (|HasCategory| $ '(|shallowlyMutable|)) (|augmentPredVector| $ 4096))
    (AND (|HasCategory| $ '(|finiteAggregate|)) (|augmentPredVector| $ 8192))
    (AND (|HasCategory| |#1| '(|BasicType|))
         (|HasCategory| $ '(|finiteAggregate|)) (|augmentPredVector| $ 16384))
    (AND (|HasCategory| $ '(|finiteAggregate|))
         (|HasCategory| $ '(|shallowlyMutable|)) (|augmentPredVector| $ 32768))
    (AND (|HasCategory| |#1| '(|OrderedSet|))
         (|HasCategory| $ '(|finiteAggregate|))
         (|HasCategory| $ '(|shallowlyMutable|)) (|augmentPredVector| $ 65536))
    (AND (|HasCategory| |#1| '(|OrderedSet|))
         (|HasCategory| $ '(|finiteAggregate|)) (|augmentPredVector| $ 131072))
    (AND
     (OR (AND #3# (|HasCategory| $ '(|finiteAggregate|)))
         (AND (|HasCategory| |#1| '(|OrderedSet|))
              (|HasCategory| $ '(|finiteAggregate|))))
     (|augmentPredVector| $ 262144))
    (AND
     (OR (AND #3# (|HasCategory| $ '(|finiteAggregate|)))
         (AND (|HasCategory| |#1| '(|OrderedSet|))
              (|HasCategory| $ '(|finiteAggregate|)))
         #2#)
     (|augmentPredVector| $ 524288))
    (AND
     (OR #1# (AND #3# (|HasCategory| $ '(|finiteAggregate|)))
         (AND (|HasCategory| |#1| '(|OrderedSet|))
              (|HasCategory| $ '(|finiteAggregate|))))
     (|augmentPredVector| $ 1048576))
    (AND
     (OR
      (AND (|HasCategory| |#1| '(|BasicType|))
           (|HasCategory| $ '(|finiteAggregate|)))
      (AND #3# (|HasCategory| $ '(|finiteAggregate|)))
      (AND (|HasCategory| |#1| '(|OrderedSet|))
           (|HasCategory| $ '(|finiteAggregate|)))
      #2#)
     (|augmentPredVector| $ 2097152))
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|OneDimensionalArray| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|IndexedOneDimensionalArray| 6 (NRTEVAL 1))
              (|local| |#1|) (|Integer|) |ARRAY1;qelt;$IS;1|
              |ARRAY1;qsetelt!;$I2S;2| (0 . |setelt!|) (|List| 6)
              |ARRAY1;oneDimensionalArray;L$;3| (|NonNegativeInteger|)
              |ARRAY1;oneDimensionalArray;NniS$;4| (|Mapping| 17 6 6)
              (|Mapping| 6 6 6) (|Boolean|) (|List| 19) (|Equation| 6)
              (|OutputForm|) (|SingleInteger|) (|String|) (|HashState|)
              (|Mapping| 17 6) (|UniversalSegment| 7) (|Void|) (|Mapping| 6 6)
              (|InputForm|) (|List| $) (|Union| 6 '"failed") (|List| 7))
           '#(|setelt!| 7 |qsetelt!| 14 |qelt| 21 |oneDimensionalArray| 27)
           'NIL
           (CONS
            (|makeByteWordVec2| 12
                                '(0 0 0 0 0 1 0 6 0 0 8 10 0 0 0 0 0 8 9 12 1
                                  2))
            (CONS
             '#(|OneDimensionalArrayAggregate&| NIL |LinearAggregate&|
                |IndexedAggregate&| |Collection&| |OrderedSet&|
                |HomogeneousAggregate&| NIL |Aggregate&| |EltableAggregate&|
                |Evalable&| |SetCategory&| NIL NIL NIL NIL NIL |InnerEvalable&|
                |BasicType&| NIL |PartialOrder&| NIL)
             (CONS
              '#((|OneDimensionalArrayAggregate| 6) (|FiniteLinearAggregate| 6)
                 (|LinearAggregate| 6) (|IndexedAggregate| 7 6)
                 (|Collection| 6) (|OrderedSet|) (|HomogeneousAggregate| 6)
                 (|Comparable|) (|Aggregate|) (|EltableAggregate| 7 6)
                 (|Evalable| 6) (|SetCategory|) (|shallowlyMutable|)
                 (|finiteAggregate|) (|Eltable| 25 $$) (|Type|) (|Eltable| 7 6)
                 (|InnerEvalable| 6 6) (|BasicType|) (|CoercibleTo| 20)
                 (|PartialOrder|) (|ConvertibleTo| 28))
              (|makeByteWordVec2| 14
                                  '(3 0 6 0 7 6 10 3 13 6 0 7 6 10 3 13 6 0 7 6
                                    9 2 0 6 0 7 8 1 0 0 11 12 2 0 0 13 6
                                    14)))))
           '|lookupIncomplete|)) 
