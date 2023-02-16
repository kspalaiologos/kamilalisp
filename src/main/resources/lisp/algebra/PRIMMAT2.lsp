
(PUT '|PRIMMAT2;minRowIndex;$I;1| '|SPADreplace| '(XLAM (|x|) 0)) 

(SDEFUN |PRIMMAT2;minRowIndex;$I;1| ((|x| ($)) ($ (|Integer|))) 0) 

(PUT '|PRIMMAT2;minColIndex;$I;2| '|SPADreplace| '(XLAM (|x|) 0)) 

(SDEFUN |PRIMMAT2;minColIndex;$I;2| ((|x| ($)) ($ (|Integer|))) 0) 

(PUT '|PRIMMAT2;nrows;$Nni;3| '|SPADreplace| 'ANROWS) 

(SDEFUN |PRIMMAT2;nrows;$Nni;3| ((|x| ($)) ($ (|NonNegativeInteger|)))
        (ANROWS |x|)) 

(PUT '|PRIMMAT2;ncols;$Nni;4| '|SPADreplace| 'ANCOLS) 

(SDEFUN |PRIMMAT2;ncols;$Nni;4| ((|x| ($)) ($ (|NonNegativeInteger|)))
        (ANCOLS |x|)) 

(SDEFUN |PRIMMAT2;maxRowIndex;$I;5| ((|x| ($)) ($ (|Integer|)))
        (- (ANROWS |x|) 1)) 

(SDEFUN |PRIMMAT2;maxColIndex;$I;6| ((|x| ($)) ($ (|Integer|)))
        (- (ANCOLS |x|) 1)) 

(PUT '|PRIMMAT2;qelt;$2IS;7| '|SPADreplace| 'QAREF2) 

(SDEFUN |PRIMMAT2;qelt;$2IS;7|
        ((|m| ($)) (|i| #1=(|Integer|)) (|j| #1#) ($ (S))) (QAREF2 |m| |i| |j|)) 

(PUT '|PRIMMAT2;elt;$2IS;8| '|SPADreplace| 'QAREF2) 

(SDEFUN |PRIMMAT2;elt;$2IS;8|
        ((|m| ($)) (|i| #1=(|Integer|)) (|j| #1#) ($ (S))) (QAREF2 |m| |i| |j|)) 

(PUT '|PRIMMAT2;qsetelt!;$2I2S;9| '|SPADreplace| 'QSETAREF2) 

(SDEFUN |PRIMMAT2;qsetelt!;$2I2S;9|
        ((|m| ($)) (|i| #1=(|Integer|)) (|j| #1#) (|r| (S)) ($ (S)))
        (QSETAREF2 |m| |i| |j| |r|)) 

(PUT '|PRIMMAT2;setelt!;$2I2S;10| '|SPADreplace| 'QSETAREF2) 

(SDEFUN |PRIMMAT2;setelt!;$2I2S;10|
        ((|m| ($)) (|i| #1=(|Integer|)) (|j| #1#) (|r| (S)) ($ (S)))
        (QSETAREF2 |m| |i| |j| |r|)) 

(PUT '|PRIMMAT2;empty;$;11| '|SPADreplace| '(XLAM NIL (MAKE_MATRIX 0 0))) 

(SDEFUN |PRIMMAT2;empty;$;11| (($ ($))) (MAKE_MATRIX 0 0)) 

(PUT '|PRIMMAT2;qnew;2Nni$;12| '|SPADreplace| 'MAKE_MATRIX) 

(SDEFUN |PRIMMAT2;qnew;2Nni$;12|
        ((|rows| #1=(|NonNegativeInteger|)) (|cols| #1#) ($ ($)))
        (MAKE_MATRIX |rows| |cols|)) 

(PUT '|PRIMMAT2;new;2NniS$;13| '|SPADreplace| 'MAKE_MATRIX1) 

(SDEFUN |PRIMMAT2;new;2NniS$;13|
        ((|rows| #1=(|NonNegativeInteger|)) (|cols| #1#) (|a| (S)) ($ ($)))
        (MAKE_MATRIX1 |rows| |cols| |a|)) 

(DECLAIM (NOTINLINE |PrimitiveTwoDimensionalArray;|)) 

(DEFUN |PrimitiveTwoDimensionalArray| (#1=#:G3466)
  (SPROG NIL
         (PROG (#2=#:G3467)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|PrimitiveTwoDimensionalArray|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|PrimitiveTwoDimensionalArray;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|PrimitiveTwoDimensionalArray|)))))))))) 

(DEFUN |PrimitiveTwoDimensionalArray;| (|#1|)
  (SPROG
   ((|pv$| NIL) (#1=#:G3463 NIL) (#2=#:G3464 NIL) ($ NIL) (|dv$| NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|PrimitiveTwoDimensionalArray| DV$1))
    (LETT $ (GETREFV 49))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1| '(|Comparable|))
                                        (|HasCategory| |#1| '(|AbelianMonoid|))
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
                                          (|HasCategory| |#1|
                                                         '(|AbelianMonoid|)))
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
                                             (|HasCategory| |#1|
                                                            '(|AbelianMonoid|)))
                                            (AND
                                             (|HasCategory| |#1|
                                                            (LIST '|Evalable|
                                                                  (|devaluate|
                                                                   |#1|)))
                                             #2#))
                                        (AND
                                         (|HasCategory| |#1| '(|AbelianGroup|))
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         (|HasCategory| |#1| '(|SemiRng|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         (|HasCategory| |#1| '(|Monoid|))
                                         (|HasCategory| |#1| '(|SemiRng|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         (|HasCategory| |#1|
                                                        '(|EuclideanDomain|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         (|HasCategory| |#1|
                                                        '(|IntegralDomain|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         (|HasCategory| |#1|
                                                        '(|CommutativeRing|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         (|HasCategory| |#1| '(|Field|)))))))
    (|haddProp| |$ConstructorCache| '|PrimitiveTwoDimensionalArray| (LIST DV$1)
                (CONS 1 $))
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
      #2#)
     (|augmentPredVector| $ 2097152))
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|PrimitiveTwoDimensionalArray| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Integer|)
              |PRIMMAT2;minRowIndex;$I;1| |PRIMMAT2;minColIndex;$I;2|
              (|NonNegativeInteger|) |PRIMMAT2;nrows;$Nni;3|
              |PRIMMAT2;ncols;$Nni;4| |PRIMMAT2;maxRowIndex;$I;5|
              |PRIMMAT2;maxColIndex;$I;6| |PRIMMAT2;qelt;$2IS;7|
              |PRIMMAT2;elt;$2IS;8| |PRIMMAT2;qsetelt!;$2I2S;9|
              |PRIMMAT2;setelt!;$2I2S;10| |PRIMMAT2;empty;$;11|
              |PRIMMAT2;qnew;2Nni$;12| |PRIMMAT2;new;2NniS$;13| (|Boolean|)
              (|List| 25) (|Union| $ '"failed") (|PrimitiveArray| 6) (|List| $)
              (|List| 6) (|List| 29) (|Equation| 6) (|Mapping| 22 6 6)
              (|Mapping| 22 6) (|Void|) (|List| 45) (|Union| 6 '"one")
              (|List| 27) (|Mapping| 6 7 7) (|OutputForm|) (|SingleInteger|)
              (|String|) (|HashState|) (|Mapping| 6 6 6) (|Mapping| 6 6)
              (|List| 26) (|PositiveInteger|) (|List| 10) (|List| 47)
              (|Segment| 7) (|List| 7))
           '#(~= 0 |zero?| 6 |zero| 11 |vertSplit| 17 |vertConcat| 29
              |transpose| 40 |symmetric?| 50 |swapRows!| 55 |swapColumns!| 62
              |subMatrix| 69 |squareTop| 78 |square?| 83 |smaller?| 88 |size?|
              94 |setsubMatrix!| 100 |setelt!| 108 |setRow!| 204 |setColumn!|
              211 |scalarMatrix| 218 |sample| 224 |rowSlice| 228 |rowEchelon|
              233 |row| 238 |rank| 244 |qsetelt!| 249 |qnew| 257 |qelt| 263
              |positivePower| 270 |parts| 276 |nullity| 281 |nullSpace| 286
              |nrows| 291 |new| 296 |ncols| 303 |more?| 308 |minordet| 314
              |minRowIndex| 319 |minColIndex| 324 |min| 329 |members| 334
              |member?| 339 |maxRowIndex| 345 |maxColIndex| 350 |max| 355
              |matrix| 366 |map!| 378 |map| 384 |listOfLists| 405 |less?| 410
              |latex| 416 |kronecker_prod1| 421 |kroneckerSum| 432
              |kroneckerProduct| 443 |inverse| 454 |horizSplit| 459
              |horizConcat| 471 |hashUpdate!| 482 |hash| 488 |fill!| 493
              |exquo| 499 |every?| 505 |eval| 511 |eq?| 537 |empty?| 543
              |empty| 548 |elt| 552 |diagonalMatrix| 644 |diagonal?| 654
              |determinant| 659 |count| 664 |copy| 676 |columnSpace| 681
              |column| 686 |colSlice| 692 |coerce| 697 |blockSplit| 707
              |blockConcat| 721 |any?| 726 |antisymmetric?| 732 ^ 737
              |Pfaffian| 749 = 754 / 760 - 766 + 777 * 783 |#| 819)
           'NIL
           (CONS (|makeByteWordVec2| 11 '(2 0 0 1 0 9 7 0 0 0 9 6 11))
                 (CONS
                  '#(|MatrixCategory&| |TwoDimensionalArrayCategory&|
                     |HomogeneousAggregate&| NIL |Aggregate&| |Evalable&|
                     |SetCategory&| NIL NIL NIL |InnerEvalable&| |BasicType&|
                     NIL)
                  (CONS
                   '#((|MatrixCategory| 6 (|PrimitiveArray| 6)
                                        (|PrimitiveArray| 6))
                      (|TwoDimensionalArrayCategory| 6 (|PrimitiveArray| 6)
                                                     (|PrimitiveArray| 6))
                      (|HomogeneousAggregate| 6) (|Comparable|) (|Aggregate|)
                      (|Evalable| 6) (|SetCategory|) (|Type|)
                      (|finiteAggregate|) (|shallowlyMutable|)
                      (|InnerEvalable| 6 6) (|BasicType|) (|CoercibleTo| 37))
                   (|makeByteWordVec2| 48
                                       '(2 22 22 0 0 1 1 2 22 0 1 2 2 0 10 10 1
                                         2 0 26 0 44 1 2 0 26 0 45 1 1 0 0 26 1
                                         2 0 0 0 0 1 1 2 0 25 1 1 0 0 0 1 1 2
                                         22 0 1 3 0 0 0 7 7 1 3 0 0 0 7 7 1 5 0
                                         0 0 7 7 7 7 1 1 0 0 0 1 1 2 22 0 1 2 1
                                         22 0 0 1 2 0 22 0 10 1 4 0 0 0 7 7 0 1
                                         4 0 0 0 46 46 0 1 4 0 0 0 47 46 0 1 4
                                         0 0 0 46 47 0 1 4 0 0 0 48 47 0 1 4 0
                                         0 0 47 48 0 1 4 0 0 0 48 48 0 1 4 0 0
                                         0 47 47 0 1 4 0 0 0 7 48 0 1 4 0 0 0
                                         48 7 0 1 4 0 6 0 7 7 6 18 4 0 0 0 7 46
                                         0 1 4 0 0 0 46 7 0 1 3 0 0 0 7 25 1 3
                                         0 0 0 7 25 1 2 2 0 10 6 1 0 0 0 1 1 0
                                         47 0 1 1 15 0 0 1 2 0 25 0 7 1 1 16 10
                                         0 1 4 0 6 0 7 7 6 17 2 0 0 10 10 20 3
                                         0 6 0 7 7 15 2 13 0 0 7 1 1 0 27 0 1 1
                                         16 10 0 1 1 16 23 0 1 1 0 10 0 11 3 0
                                         0 10 10 6 21 1 0 10 0 12 2 0 22 0 10 1
                                         1 17 6 0 1 1 0 7 0 8 1 0 7 0 9 1 20 6
                                         0 1 1 19 27 0 1 2 21 22 6 0 1 1 0 7 0
                                         13 1 0 7 0 14 1 20 6 0 1 2 19 6 30 0 1
                                         1 2 0 35 1 3 2 0 10 10 36 1 2 0 0 42 0
                                         1 3 0 0 41 0 0 1 4 0 0 41 0 0 6 1 2 0
                                         0 42 0 1 1 0 35 0 1 2 0 22 0 10 1 1 5
                                         39 0 1 7 2 32 0 7 33 26 10 10 34 1 2 2
                                         0 0 0 1 1 2 0 26 1 2 13 0 0 0 1 1 13 0
                                         26 1 1 18 24 0 1 2 0 26 0 44 1 2 0 26
                                         0 45 1 1 0 0 26 1 2 0 0 0 0 1 2 5 40
                                         40 0 1 1 5 38 0 1 2 0 0 0 6 1 2 16 24
                                         0 6 1 2 19 22 31 0 1 3 8 0 0 6 6 1 3 8
                                         0 0 27 27 1 2 8 0 0 28 1 2 8 0 0 29 1
                                         2 0 22 0 0 1 1 0 22 0 1 0 0 0 19 3 0 0
                                         0 46 47 1 3 0 0 0 46 46 1 3 0 0 0 47
                                         46 1 3 0 0 0 7 46 1 3 0 0 0 46 7 1 3 0
                                         0 0 48 47 1 3 0 0 0 47 48 1 3 0 0 0 48
                                         48 1 3 0 0 0 47 47 1 3 0 0 0 7 48 1 3
                                         0 0 0 48 7 1 4 0 6 0 7 7 6 1 3 0 6 0 7
                                         7 16 1 2 0 26 1 1 2 0 27 1 1 2 22 0 1
                                         1 17 6 0 1 2 21 10 6 0 1 2 19 10 31 0
                                         1 1 0 0 0 1 1 15 23 0 1 2 0 25 0 7 1 1
                                         0 47 0 1 1 2 0 25 1 1 10 37 0 1 3 0 43
                                         0 44 44 1 3 0 43 0 45 45 1 1 0 0 43 1
                                         2 19 22 31 0 1 1 12 22 0 1 2 18 0 0 7
                                         1 2 14 0 0 10 1 1 17 6 0 1 2 22 22 0 0
                                         1 2 18 0 0 6 1 1 12 0 0 1 2 12 0 0 0 1
                                         2 2 0 0 0 1 2 12 0 7 0 1 2 13 25 25 0
                                         1 2 13 0 0 6 1 2 13 25 0 25 1 2 13 0 0
                                         0 1 2 13 0 6 0 1 1 19 10 0 1)))))
           '|lookupComplete|)) 
