
(PUT '|MATRIX;minRowIndex;$I;1| '|SPADreplace| '(XLAM (|x|) 1)) 

(SDEFUN |MATRIX;minRowIndex;$I;1| ((|x| ($)) ($ (|Integer|))) 1) 

(PUT '|MATRIX;minColIndex;$I;2| '|SPADreplace| '(XLAM (|x|) 1)) 

(SDEFUN |MATRIX;minColIndex;$I;2| ((|x| ($)) ($ (|Integer|))) 1) 

(PUT '|MATRIX;qelt;$2IR;3| '|SPADreplace|
     '(XLAM (|m| |i| |j|) (QAREF2O |m| |i| |j| 1 1))) 

(SDEFUN |MATRIX;qelt;$2IR;3| ((|m| ($)) (|i| #1=(|Integer|)) (|j| #1#) ($ (R)))
        (QAREF2O |m| |i| |j| 1 1)) 

(PUT '|MATRIX;qsetelt!;$2I2R;4| '|SPADreplace|
     '(XLAM (|m| |i| |j| |r|) (QSETAREF2O |m| |i| |j| |r| 1 1))) 

(SDEFUN |MATRIX;qsetelt!;$2I2R;4|
        ((|m| ($)) (|i| #1=(|Integer|)) (|j| #1#) (|r| (R)) ($ (R)))
        (QSETAREF2O |m| |i| |j| |r| 1 1)) 

(SDEFUN |MATRIX;swapRows!;$2I$;5|
        ((|x| ($)) (|i1| #1=(|Integer|)) (|i2| #1#) ($ ($)))
        (SPROG ((|t2| (R)) (|t1| (R)) (#2=#:G2970 NIL) (|j| NIL))
               (SEQ
                (COND
                 ((OR (< |i1| (SPADCALL |x| (QREFELT $ 8)))
                      (OR (> |i1| (SPADCALL |x| (QREFELT $ 12)))
                          (OR (< |i2| (SPADCALL |x| (QREFELT $ 8)))
                              (> |i2| (SPADCALL |x| (QREFELT $ 12))))))
                  (|error| "swapRows!: index out of range"))
                 ('T
                  (COND ((EQL |i1| |i2|) |x|)
                        ('T
                         (SEQ
                          (SEQ (LETT |j| (SPADCALL |x| (QREFELT $ 9)))
                               (LETT #2# (SPADCALL |x| (QREFELT $ 13))) G190
                               (COND ((> |j| #2#) (GO G191)))
                               (SEQ (LETT |t1| (QAREF2O |x| |i1| |j| 1 1))
                                    (LETT |t2| (QAREF2O |x| |i2| |j| 1 1))
                                    (QSETAREF2O |x| |i1| |j| |t2| 1 1)
                                    (EXIT (QSETAREF2O |x| |i2| |j| |t1| 1 1)))
                               (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))
                          (EXIT |x|))))))))) 

(SDEFUN |MATRIX;copy;2$;6| ((|m| ($)) ($ ($)))
        (SPROG
         ((#1=#:G2978 NIL) (|j| NIL) (#2=#:G2977 NIL) (|i| NIL) (|ans| ($)))
         (SEQ (LETT |ans| (MAKE_MATRIX (ANROWS |m|) (ANCOLS |m|)))
              (SEQ (LETT |i| (SPADCALL |m| (QREFELT $ 8)))
                   (LETT #2# (SPADCALL |m| (QREFELT $ 12))) G190
                   (COND ((> |i| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| (SPADCALL |m| (QREFELT $ 9)))
                          (LETT #1# (SPADCALL |m| (QREFELT $ 13))) G190
                          (COND ((> |j| #1#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SPADCALL |ans| |i| |j|
                                      (SPADCALL |m| |i| |j| (QREFELT $ 10))
                                      (QREFELT $ 11))))
                          (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
                   (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |MATRIX;determinant;$R;7| ((|x| ($)) ($ (R)))
        (SPADCALL |x| (QREFELT $ 17))) 

(SDEFUN |MATRIX;minordet;$R;8| ((|x| ($)) ($ (R)))
        (SPADCALL |x| (QREFELT $ 19))) 

(SDEFUN |MATRIX;rowEchelon;2$;9| ((|x| ($)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 21))) 

(SDEFUN |MATRIX;rank;$Nni;10| ((|x| ($)) ($ (|NonNegativeInteger|)))
        (SPADCALL |x| (QREFELT $ 24))) 

(SDEFUN |MATRIX;nullity;$Nni;11| ((|x| ($)) ($ (|NonNegativeInteger|)))
        (SPADCALL |x| (QREFELT $ 26))) 

(SDEFUN |MATRIX;nullSpace;$L;12| ((|x| ($)) ($ (|List| (|Vector| R))))
        (SPADCALL |x| (QREFELT $ 29))) 

(SDEFUN |MATRIX;inverse;$U;13| ((|x| ($)) ($ (|Union| $ "failed")))
        (SPADCALL |x| (QREFELT $ 32))) 

(SDEFUN |MATRIX;invertIfCan;$U;14| ((|x| ($)) ($ (|Union| $ "failed")))
        (SPADCALL |x| (QREFELT $ 35))) 

(SDEFUN |MATRIX;diagonalMatrix;V$;15| ((|v| (|Vector| R)) ($ ($)))
        (SPROG
         ((#1=#:G3000 NIL) (|i| NIL) (#2=#:G3001 NIL) (|j| NIL)
          (#3=#:G3002 NIL) (|k| NIL) (|ans| ($)) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVSIZE |v|))
              (LETT |ans| (SPADCALL |n| |n| (QREFELT $ 37)))
              (SEQ (LETT |k| (SPADCALL |v| (QREFELT $ 39)))
                   (LETT #3# (QVSIZE |v|))
                   (LETT |j| (SPADCALL |ans| (QREFELT $ 9)))
                   (LETT #2# (SPADCALL |ans| (QREFELT $ 13)))
                   (LETT |i| (SPADCALL |ans| (QREFELT $ 8)))
                   (LETT #1# (SPADCALL |ans| (QREFELT $ 12))) G190
                   (COND ((OR (> |i| #1#) (> |j| #2#) (> |k| #3#)) (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |ans| |i| |j| (QAREF1O |v| |k| 1)
                               (QREFELT $ 11))))
                   (LETT |i|
                         (PROG1 (+ |i| 1)
                           (LETT |j| (PROG1 (+ |j| 1) (LETT |k| (+ |k| 1))))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |MATRIX;convert;$If;16| ((|x| ($)) ($ (|InputForm|)))
        (SPADCALL
         (LIST (SPADCALL '|matrix| (QREFELT $ 43))
               (SPADCALL (SPADCALL |x| (QREFELT $ 45)) (QREFELT $ 46)))
         (QREFELT $ 48))) 

(DECLAIM (NOTINLINE |Matrix;|)) 

(DEFUN |Matrix| (#1=#:G3015)
  (SPROG NIL
         (PROG (#2=#:G3016)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Matrix|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Matrix;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Matrix|)))))))))) 

(DEFUN |Matrix;| (|#1|)
  (SPROG
   ((|pv$| NIL) (#1=#:G3012 NIL) (#2=#:G3013 NIL) (#3=#:G3014 NIL) ($ NIL)
    (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|Matrix| DV$1))
    (LETT $ (GETREFV 72))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1| '(|Comparable|))
                                        (|HasCategory| |#1|
                                                       '(|ConvertibleTo|
                                                         (|InputForm|)))
                                        (|HasCategory| |#1| '(|OrderedSet|))
                                        (|HasCategory| |#1| '(|BasicType|))
                                        (LETT #3#
                                              (|HasCategory| |#1|
                                                             '(|SetCategory|)))
                                        (OR (|HasCategory| |#1| '(|BasicType|))
                                            (|HasCategory| |#1|
                                                           '(|Comparable|))
                                            #3#)
                                        (OR
                                         (|HasCategory| |#1| '(|Comparable|))
                                         #3#)
                                        (AND
                                         (|HasCategory| |#1|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#1|)))
                                         #3#)
                                        (LETT #2#
                                              (|HasCategory| |#1|
                                                             '(|CoercibleTo|
                                                               (|OutputForm|))))
                                        (OR #2#
                                            (AND
                                             (|HasCategory| |#1|
                                                            (LIST '|Evalable|
                                                                  (|devaluate|
                                                                   |#1|)))
                                             #3#))
                                        (|HasCategory| |#1| '(|AbelianGroup|))
                                        (|HasCategory| |#1| '(|SemiRng|))
                                        (AND (|HasCategory| |#1| '(|Monoid|))
                                             (|HasCategory| |#1| '(|SemiRng|)))
                                        (|HasCategory| |#1|
                                                       '(|EuclideanDomain|))
                                        (|HasCategory| |#1|
                                                       '(|CommutativeRing|))
                                        (|HasCategory| |#1| '(|Field|))
                                        (LETT #1#
                                              (|HasCategory| |#1|
                                                             '(|IntegralDomain|)))
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
                                          #1#)
                                         (AND
                                          (|HasCategory| |#1|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#1|)))
                                          #3#))))))
    (|haddProp| |$ConstructorCache| '|Matrix| (LIST DV$1) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (AND (|HasCategory| $ '(|finiteAggregate|)) (|augmentPredVector| $ 262144))
    (AND (|HasCategory| |#1| '(|OrderedSet|))
         (|HasCategory| $ '(|finiteAggregate|)) (|augmentPredVector| $ 524288))
    (AND (|HasCategory| |#1| '(|BasicType|))
         (|HasCategory| $ '(|finiteAggregate|))
         (|augmentPredVector| $ 1048576))
    (AND
     (OR
      (AND (|HasCategory| |#1| '(|BasicType|))
           (|HasCategory| $ '(|finiteAggregate|)))
      #3#)
     (|augmentPredVector| $ 2097152))
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|testBitVector| |pv$| 15)
      (PROGN
       (QSETREFV $ 18 (CONS (|dispatchFunction| |MATRIX;determinant;$R;7|) $))
       (QSETREFV $ 20 (CONS (|dispatchFunction| |MATRIX;minordet;$R;8|) $)))))
    (COND
     ((|testBitVector| |pv$| 14)
      (QSETREFV $ 22 (CONS (|dispatchFunction| |MATRIX;rowEchelon;2$;9|) $))))
    (COND
     ((|testBitVector| |pv$| 17)
      (PROGN
       (QSETREFV $ 25 (CONS (|dispatchFunction| |MATRIX;rank;$Nni;10|) $))
       (QSETREFV $ 27 (CONS (|dispatchFunction| |MATRIX;nullity;$Nni;11|) $))
       (QSETREFV $ 30
                 (CONS (|dispatchFunction| |MATRIX;nullSpace;$L;12|) $)))))
    (COND
     ((|testBitVector| |pv$| 16)
      (QSETREFV $ 34 (CONS (|dispatchFunction| |MATRIX;inverse;$U;13|) $))))
    (COND
     ((|testBitVector| |pv$| 17)
      (QSETREFV $ 36
                (CONS (|dispatchFunction| |MATRIX;invertIfCan;$U;14|) $))))
    (COND
     ((|testBitVector| |pv$| 2)
      (QSETREFV $ 49 (CONS (|dispatchFunction| |MATRIX;convert;$If;16|) $))))
    $))) 

(MAKEPROP '|Matrix| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL
              (|InnerIndexedTwoDimensionalArray| 6 (NRTEVAL 1) (NRTEVAL 1) 38
                                                 38)
              (|local| |#1|) (|Integer|) |MATRIX;minRowIndex;$I;1|
              |MATRIX;minColIndex;$I;2| |MATRIX;qelt;$2IR;3|
              |MATRIX;qsetelt!;$2I2R;4| (0 . |maxRowIndex|) (5 . |maxColIndex|)
              |MATRIX;swapRows!;$2I$;5| |MATRIX;copy;2$;6|
              (|MatrixLinearAlgebraFunctions| 6 38 38 $$) (10 . |determinant|)
              (15 . |determinant|) (20 . |minordet|) (25 . |minordet|)
              (30 . |rowEchelon|) (35 . |rowEchelon|) (|NonNegativeInteger|)
              (40 . |rank|) (45 . |rank|) (50 . |nullity|) (55 . |nullity|)
              (|List| 38) (60 . |nullSpace|) (65 . |nullSpace|)
              (|Union| $$ '"failed") (70 . |inverse|) (|Union| $ '"failed")
              (75 . |inverse|) (80 . |invertIfCan|) (85 . |invertIfCan|)
              (90 . |zero|) (|Vector| 6) (96 . |minIndex|)
              |MATRIX;diagonalMatrix;V$;15| (|Symbol|) (|InputForm|)
              (101 . |convert|) (|List| 51) (106 . |listOfLists|)
              (111 . |convert|) (|List| $) (116 . |convert|) (121 . |convert|)
              (|Boolean|) (|List| 6) (|Equation| 6) (|List| 52)
              (|Mapping| 50 6 6) (|Mapping| 50 6) (|OutputForm|)
              (|SingleInteger|) (|HashState|) (|String|) (|Void|) (|List| 66)
              (|Union| 6 '"one") (|Mapping| 6 7 7) (|Mapping| 6 6 6)
              (|List| 47) (|List| 23) (|Mapping| 6 6) (|PositiveInteger|)
              (|List| 70) (|Segment| 7) (|List| 7))
           '#(|zero| 126 |swapRows!| 132 |rowEchelon| 139 |rank| 144 |qsetelt!|
              149 |qelt| 157 |nullity| 164 |nullSpace| 169 |minordet| 174
              |minRowIndex| 179 |minColIndex| 184 |maxRowIndex| 189
              |maxColIndex| 194 |listOfLists| 199 |invertIfCan| 204 |inverse|
              209 |diagonalMatrix| 214 |determinant| 219 |copy| 224 |convert|
              229)
           'NIL
           (CONS (|makeByteWordVec2| 18 '(0 0 0 1 0 18 7 0 0 0 18 6 10 2))
                 (CONS
                  '#(|MatrixCategory&| |TwoDimensionalArrayCategory&|
                     |HomogeneousAggregate&| NIL |Aggregate&| |Evalable&|
                     |SetCategory&| NIL NIL NIL |InnerEvalable&| |BasicType&|
                     NIL NIL)
                  (CONS
                   '#((|MatrixCategory| 6 (|Vector| 6) (|Vector| 6))
                      (|TwoDimensionalArrayCategory| 6 (|Vector| 6)
                                                     (|Vector| 6))
                      (|HomogeneousAggregate| 6) (|Comparable|) (|Aggregate|)
                      (|Evalable| 6) (|SetCategory|) (|Type|)
                      (|finiteAggregate|) (|shallowlyMutable|)
                      (|InnerEvalable| 6 6) (|BasicType|) (|CoercibleTo| 56)
                      (|ConvertibleTo| 42))
                   (|makeByteWordVec2| 49
                                       '(1 0 7 0 12 1 0 7 0 13 1 16 6 2 17 1 0
                                         6 0 18 1 16 6 2 19 1 0 6 0 20 1 16 2 2
                                         21 1 0 0 0 22 1 16 23 2 24 1 0 23 0 25
                                         1 16 23 2 26 1 0 23 0 27 1 16 28 2 29
                                         1 0 28 0 30 1 16 31 2 32 1 0 33 0 34 1
                                         16 31 2 35 1 0 33 0 36 2 0 0 23 23 37
                                         1 38 7 0 39 1 42 0 41 43 1 0 44 0 45 1
                                         44 42 0 46 1 42 0 47 48 1 0 42 0 49 2
                                         0 0 23 23 37 3 0 0 0 7 7 14 1 14 0 0
                                         22 1 17 23 0 25 4 0 6 0 7 7 6 11 3 0 6
                                         0 7 7 10 1 17 23 0 27 1 17 28 0 30 1
                                         15 6 0 20 1 0 7 0 8 1 0 7 0 9 1 0 7 0
                                         12 1 0 7 0 13 1 0 44 0 45 1 17 33 0 36
                                         1 16 33 0 34 1 0 0 38 40 1 15 6 0 18 1
                                         0 0 0 15 1 2 42 0 49)))))
           '|lookupIncomplete|)) 
