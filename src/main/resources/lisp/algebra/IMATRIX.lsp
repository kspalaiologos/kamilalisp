
(SDEFUN |IMATRIX;swapRows!;$2I$;1|
        ((|x| ($)) (|i1| #1=(|Integer|)) (|i2| #1#) ($ ($)))
        (SPROG
         ((|t2| (R)) (|t1| (R)) (#2=#:G709 NIL) (|j| NIL) (|co| (|Integer|))
          (|ro| (|Integer|)))
         (SEQ
          (COND
           ((OR (< |i1| (SPADCALL |x| (QREFELT $ 10)))
                (OR (> |i1| (SPADCALL |x| (QREFELT $ 11)))
                    (OR (< |i2| (SPADCALL |x| (QREFELT $ 10)))
                        (> |i2| (SPADCALL |x| (QREFELT $ 11))))))
            (|error| "swapRows!: index out of range"))
           ('T
            (COND ((EQL |i1| |i2|) |x|)
                  ('T
                   (SEQ (LETT |ro| (QREFELT $ 7)) (LETT |co| (QREFELT $ 8))
                        (SEQ (LETT |j| |co|)
                             (LETT #2# (SPADCALL |x| (QREFELT $ 12))) G190
                             (COND ((> |j| #2#) (GO G191)))
                             (SEQ (LETT |t1| (QAREF2O |x| |i1| |j| |ro| |co|))
                                  (LETT |t2| (QAREF2O |x| |i2| |j| |ro| |co|))
                                  (QSETAREF2O |x| |i1| |j| |t2| |ro| |co|)
                                  (EXIT
                                   (QSETAREF2O |x| |i2| |j| |t1| |ro| |co|)))
                             (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))
                        (EXIT |x|))))))))) 

(SDEFUN |IMATRIX;determinant;$R;2| ((|x| ($)) ($ (R)))
        (SPADCALL |x| (QREFELT $ 15))) 

(SDEFUN |IMATRIX;minordet;$R;3| ((|x| ($)) ($ (R)))
        (SPADCALL |x| (QREFELT $ 17))) 

(SDEFUN |IMATRIX;rowEchelon;2$;4| ((|x| ($)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 19))) 

(SDEFUN |IMATRIX;rank;$Nni;5| ((|x| ($)) ($ (|NonNegativeInteger|)))
        (SPADCALL |x| (QREFELT $ 22))) 

(SDEFUN |IMATRIX;nullity;$Nni;6| ((|x| ($)) ($ (|NonNegativeInteger|)))
        (SPADCALL |x| (QREFELT $ 24))) 

(SDEFUN |IMATRIX;nullSpace;$L;7|
        ((|x| ($)) ($ (|List| (|IndexedVector| R |mnRow|))))
        (SPADCALL |x| (QREFELT $ 27))) 

(SDEFUN |IMATRIX;inverse;$U;8| ((|x| ($)) ($ (|Union| $ "failed")))
        (SPADCALL |x| (QREFELT $ 30))) 

(DECLAIM (NOTINLINE |IndexedMatrix;|)) 

(DEFUN |IndexedMatrix| (&REST #1=#:G739)
  (SPROG NIL
         (PROG (#2=#:G740)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T NIL NIL))
                     (HGET |$ConstructorCache| '|IndexedMatrix|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |IndexedMatrix;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|IndexedMatrix|)))))))))) 

(DEFUN |IndexedMatrix;| (|#1| |#2| |#3|)
  (SPROG
   ((|pv$| NIL) (#1=#:G736 NIL) (#2=#:G737 NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL)
    (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 |#2|)
    (LETT DV$3 |#3|)
    (LETT |dv$| (LIST '|IndexedMatrix| DV$1 DV$2 DV$3))
    (LETT $ (GETREFV 59))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1| '(|Comparable|))
                                        (|HasCategory| |#1| '(|OrderedSet|))
                                        (|HasCategory| |#1| '(|BasicType|))
                                        (LETT #2#
                                              (|HasCategory| |#1|
                                                             '(|SetCategory|)))
                                        (OR (|HasCategory| |#1| '(|BasicType|))
                                            (|HasCategory| |#1|
                                                           '(|Comparable|))
                                            #2#)
                                        (OR
                                         (|HasCategory| |#1| '(|Comparable|))
                                         #2#)
                                        (AND
                                         (|HasCategory| |#1|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#1|)))
                                         #2#)
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#1|)))
                                          (|HasCategory| |#1| '(|Comparable|)))
                                         (AND
                                          (|HasCategory| |#1|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#1|)))
                                          #2#))
                                        (LETT #1#
                                              (|HasCategory| |#1|
                                                             '(|CoercibleTo|
                                                               (|OutputForm|))))
                                        (OR #1#
                                            (AND
                                             (|HasCategory| |#1|
                                                            (LIST '|Evalable|
                                                                  (|devaluate|
                                                                   |#1|)))
                                             #2#))
                                        (|HasCategory| |#1| '(|AbelianGroup|))
                                        (|HasCategory| |#1| '(|SemiRng|))
                                        (AND (|HasCategory| |#1| '(|Monoid|))
                                             (|HasCategory| |#1| '(|SemiRng|)))
                                        (|HasCategory| |#1|
                                                       '(|EuclideanDomain|))
                                        (|HasCategory| |#1|
                                                       '(|IntegralDomain|))
                                        (|HasCategory| |#1|
                                                       '(|CommutativeRing|))
                                        (|HasCategory| |#1| '(|Field|))))))
    (|haddProp| |$ConstructorCache| '|IndexedMatrix| (LIST DV$1 DV$2 DV$3)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (AND (|HasCategory| $ '(|finiteAggregate|)) (|augmentPredVector| $ 131072))
    (AND (|HasCategory| |#1| '(|OrderedSet|))
         (|HasCategory| $ '(|finiteAggregate|)) (|augmentPredVector| $ 262144))
    (AND (|HasCategory| |#1| '(|BasicType|))
         (|HasCategory| $ '(|finiteAggregate|)) (|augmentPredVector| $ 524288))
    (AND
     (OR
      (AND (|HasCategory| |#1| '(|BasicType|))
           (|HasCategory| $ '(|finiteAggregate|)))
      #2#)
     (|augmentPredVector| $ 1048576))
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|testBitVector| |pv$| 16)
      (PROGN
       (QSETREFV $ 16 (CONS (|dispatchFunction| |IMATRIX;determinant;$R;2|) $))
       (QSETREFV $ 18 (CONS (|dispatchFunction| |IMATRIX;minordet;$R;3|) $)))))
    (COND
     ((|testBitVector| |pv$| 14)
      (QSETREFV $ 20 (CONS (|dispatchFunction| |IMATRIX;rowEchelon;2$;4|) $))))
    (COND
     ((|testBitVector| |pv$| 15)
      (PROGN
       (QSETREFV $ 23 (CONS (|dispatchFunction| |IMATRIX;rank;$Nni;5|) $))
       (QSETREFV $ 25 (CONS (|dispatchFunction| |IMATRIX;nullity;$Nni;6|) $))
       (QSETREFV $ 28
                 (CONS (|dispatchFunction| |IMATRIX;nullSpace;$L;7|) $)))))
    (COND
     ((|testBitVector| |pv$| 17)
      (QSETREFV $ 32 (CONS (|dispatchFunction| |IMATRIX;inverse;$U;8|) $))))
    $))) 

(MAKEPROP '|IndexedMatrix| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL
              (|InnerIndexedTwoDimensionalArray| 6 (NRTEVAL (QREFELT $ 7))
                                                 (NRTEVAL (QREFELT $ 8)) 40 41)
              (|local| |#1|) (|local| |#2|) (|local| |#3|) (|Integer|)
              (0 . |minRowIndex|) (5 . |maxRowIndex|) (10 . |maxColIndex|)
              |IMATRIX;swapRows!;$2I$;1|
              (|MatrixLinearAlgebraFunctions| 6 40 41 $$) (15 . |determinant|)
              (20 . |determinant|) (25 . |minordet|) (30 . |minordet|)
              (35 . |rowEchelon|) (40 . |rowEchelon|) (|NonNegativeInteger|)
              (45 . |rank|) (50 . |rank|) (55 . |nullity|) (60 . |nullity|)
              (|List| 41) (65 . |nullSpace|) (70 . |nullSpace|)
              (|Union| $$ '"failed") (75 . |inverse|) (|Union| $ '"failed")
              (80 . |inverse|) (|Boolean|) (|List| 6) (|Equation| 6)
              (|List| 35) (|Mapping| 33 6 6) (|Mapping| 33 6) (|OutputForm|)
              (|IndexedVector| 6 (NRTEVAL (QREFELT $ 8)))
              (|IndexedVector| 6 (NRTEVAL (QREFELT $ 7))) (|List| $)
              (|SingleInteger|) (|String|) (|HashState|) (|Void|) (|List| 53)
              (|Union| 6 '"one") (|List| 34) (|Mapping| 6 9 9)
              (|Mapping| 6 6 6) (|List| 42) (|List| 21) (|Mapping| 6 6)
              (|PositiveInteger|) (|List| 57) (|Segment| 9) (|List| 9))
           '#(|swapRows!| 85 |rowEchelon| 92 |rank| 97 |nullity| 102
              |nullSpace| 107 |minordet| 112 |minRowIndex| 117 |maxRowIndex|
              122 |maxColIndex| 127 |inverse| 132 |determinant| 137)
           'NIL
           (CONS (|makeByteWordVec2| 10 '(0 0 0 1 0 8 6 0 0 0 8 5 10))
                 (CONS
                  '#(|MatrixCategory&| |TwoDimensionalArrayCategory&|
                     |HomogeneousAggregate&| NIL |Aggregate&| |Evalable&|
                     |SetCategory&| NIL NIL NIL |InnerEvalable&| |BasicType&|
                     NIL)
                  (CONS
                   '#((|MatrixCategory| 6 (|IndexedVector| 6 8)
                                        (|IndexedVector| 6 7))
                      (|TwoDimensionalArrayCategory| 6 (|IndexedVector| 6 8)
                                                     (|IndexedVector| 6 7))
                      (|HomogeneousAggregate| 6) (|Comparable|) (|Aggregate|)
                      (|Evalable| 6) (|SetCategory|) (|Type|)
                      (|finiteAggregate|) (|shallowlyMutable|)
                      (|InnerEvalable| 6 6) (|BasicType|) (|CoercibleTo| 39))
                   (|makeByteWordVec2| 32
                                       '(1 0 9 0 10 1 0 9 0 11 1 0 9 0 12 1 14
                                         6 2 15 1 0 6 0 16 1 14 6 2 17 1 0 6 0
                                         18 1 14 2 2 19 1 0 0 0 20 1 14 21 2 22
                                         1 0 21 0 23 1 14 21 2 24 1 0 21 0 25 1
                                         14 26 2 27 1 0 26 0 28 1 14 29 2 30 1
                                         0 31 0 32 3 0 0 0 9 9 13 1 14 0 0 20 1
                                         15 21 0 23 1 15 21 0 25 1 15 26 0 28 1
                                         16 6 0 18 1 0 9 0 10 1 0 9 0 11 1 0 9
                                         0 12 1 17 31 0 32 1 16 6 0 16)))))
           '|lookupIncomplete|)) 
