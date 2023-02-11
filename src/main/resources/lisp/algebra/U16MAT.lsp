
(PUT '|U16MAT;minRowIndex;$I;1| '|SPADreplace| '(XLAM (|x|) 0)) 

(SDEFUN |U16MAT;minRowIndex;$I;1| ((|x| ($)) ($ (|Integer|))) 0) 

(PUT '|U16MAT;minColIndex;$I;2| '|SPADreplace| '(XLAM (|x|) 0)) 

(SDEFUN |U16MAT;minColIndex;$I;2| ((|x| ($)) ($ (|Integer|))) 0) 

(PUT '|U16MAT;nrows;$Nni;3| '|SPADreplace| 'ANROWS_U16) 

(SDEFUN |U16MAT;nrows;$Nni;3| ((|x| ($)) ($ (|NonNegativeInteger|)))
        (ANROWS_U16 |x|)) 

(PUT '|U16MAT;ncols;$Nni;4| '|SPADreplace| 'ANCOLS_U16) 

(SDEFUN |U16MAT;ncols;$Nni;4| ((|x| ($)) ($ (|NonNegativeInteger|)))
        (ANCOLS_U16 |x|)) 

(SDEFUN |U16MAT;maxRowIndex;$I;5| ((|x| ($)) ($ (|Integer|)))
        (- (ANROWS_U16 |x|) 1)) 

(SDEFUN |U16MAT;maxColIndex;$I;6| ((|x| ($)) ($ (|Integer|)))
        (- (ANCOLS_U16 |x|) 1)) 

(PUT '|U16MAT;qelt;$3I;7| '|SPADreplace| 'AREF2_U16) 

(SDEFUN |U16MAT;qelt;$3I;7|
        ((|m| ($)) (|i| #1=(|Integer|)) (|j| #1#) ($ (|Integer|)))
        (AREF2_U16 |m| |i| |j|)) 

(PUT '|U16MAT;elt;$3I;8| '|SPADreplace| 'AREF2_U16) 

(SDEFUN |U16MAT;elt;$3I;8|
        ((|m| ($)) (|i| #1=(|Integer|)) (|j| #1#) ($ (|Integer|)))
        (AREF2_U16 |m| |i| |j|)) 

(PUT '|U16MAT;qsetelt!;$4I;9| '|SPADreplace| 'SETAREF2_U16) 

(SDEFUN |U16MAT;qsetelt!;$4I;9|
        ((|m| ($)) (|i| #1=(|Integer|)) (|j| #1#) (|r| #2=(|Integer|)) ($ #2#))
        (SETAREF2_U16 |m| |i| |j| |r|)) 

(PUT '|U16MAT;setelt!;$4I;10| '|SPADreplace| 'SETAREF2_U16) 

(SDEFUN |U16MAT;setelt!;$4I;10|
        ((|m| ($)) (|i| #1=(|Integer|)) (|j| #1#) (|r| #2=(|Integer|)) ($ #2#))
        (SETAREF2_U16 |m| |i| |j| |r|)) 

(PUT '|U16MAT;empty;$;11| '|SPADreplace| '(XLAM NIL (MAKE_MATRIX_U16 0 0))) 

(SDEFUN |U16MAT;empty;$;11| (($ ($))) (MAKE_MATRIX_U16 0 0)) 

(PUT '|U16MAT;qnew;2Nni$;12| '|SPADreplace| 'MAKE_MATRIX_U16) 

(SDEFUN |U16MAT;qnew;2Nni$;12|
        ((|rows| #1=(|NonNegativeInteger|)) (|cols| #1#) ($ ($)))
        (MAKE_MATRIX_U16 |rows| |cols|)) 

(PUT '|U16MAT;new;2NniI$;13| '|SPADreplace| 'MAKE_MATRIX1_U16) 

(SDEFUN |U16MAT;new;2NniI$;13|
        ((|rows| #1=(|NonNegativeInteger|)) (|cols| #1#) (|a| (|Integer|))
         ($ ($)))
        (MAKE_MATRIX1_U16 |rows| |cols| |a|)) 

(DECLAIM (NOTINLINE |U16Matrix;|)) 

(DEFUN |U16Matrix| ()
  (SPROG NIL
         (PROG (#1=#:G3221)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|U16Matrix|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|U16Matrix|
                             (LIST (CONS NIL (CONS 1 (|U16Matrix;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|U16Matrix|)))))))))) 

(DEFUN |U16Matrix;| ()
  (SPROG
   ((|dv$| NIL) ($ NIL) (#1=#:G3218 NIL) (#2=#:G3219 NIL) (#3=#:G3217 NIL)
    (|pv$| NIL))
   (PROGN
    (LETT |dv$| '(|U16Matrix|))
    (LETT $ (GETREFV 46))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| (|Integer|)
                                                       '(|Comparable|))
                                        (|HasCategory| (|Integer|)
                                                       '(|OrderedSet|))
                                        (|HasCategory| (|Integer|)
                                                       '(|BasicType|))
                                        (LETT #1#
                                              (|HasCategory| (|Integer|)
                                                             '(|SetCategory|)))
                                        (OR
                                         (|HasCategory| (|Integer|)
                                                        '(|BasicType|))
                                         (|HasCategory| (|Integer|)
                                                        '(|Comparable|))
                                         #1#)
                                        (OR
                                         (|HasCategory| (|Integer|)
                                                        '(|Comparable|))
                                         #1#)
                                        (LETT #2#
                                              (AND
                                               (|HasCategory| (|Integer|)
                                                              '(|Evalable|
                                                                (|Integer|)))
                                               (|HasCategory| (|Integer|)
                                                              '(|SetCategory|))))
                                        (OR
                                         (AND
                                          (|HasCategory| (|Integer|)
                                                         '(|Evalable|
                                                           (|Integer|)))
                                          (|HasCategory| (|Integer|)
                                                         '(|Comparable|)))
                                         #2#)
                                        (LETT #3#
                                              (|HasCategory| (|Integer|)
                                                             '(|CoercibleTo|
                                                               (|OutputForm|))))
                                        (OR #3# #2#)
                                        (|HasCategory| (|Integer|)
                                                       '(|AbelianGroup|))
                                        (|HasCategory| (|Integer|)
                                                       '(|SemiRng|))
                                        (AND
                                         (|HasCategory| (|Integer|)
                                                        '(|Monoid|))
                                         (|HasCategory| (|Integer|)
                                                        '(|SemiRng|)))
                                        (|HasCategory| (|Integer|)
                                                       '(|EuclideanDomain|))
                                        (|HasCategory| (|Integer|)
                                                       '(|IntegralDomain|))
                                        (|HasCategory| (|Integer|)
                                                       '(|CommutativeRing|))
                                        (|HasCategory| (|Integer|)
                                                       '(|Field|))))))
    (|haddProp| |$ConstructorCache| '|U16Matrix| NIL (CONS 1 $))
    (|stuffDomainSlots| $)
    (AND (|HasCategory| $ '(|finiteAggregate|)) (|augmentPredVector| $ 131072))
    (AND (|HasCategory| $ '(|finiteAggregate|))
         (|HasCategory| (|Integer|) '(|OrderedSet|))
         (|augmentPredVector| $ 262144))
    (AND (|HasCategory| $ '(|finiteAggregate|))
         (|HasCategory| (|Integer|) '(|BasicType|))
         (|augmentPredVector| $ 524288))
    (AND
     (OR
      (AND (|HasCategory| $ '(|finiteAggregate|))
           (|HasCategory| (|Integer|) '(|BasicType|)))
      #1#)
     (|augmentPredVector| $ 1048576))
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|U16Matrix| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Integer|) |U16MAT;minRowIndex;$I;1|
              |U16MAT;minColIndex;$I;2| (|NonNegativeInteger|)
              |U16MAT;nrows;$Nni;3| |U16MAT;ncols;$Nni;4|
              |U16MAT;maxRowIndex;$I;5| |U16MAT;maxColIndex;$I;6|
              |U16MAT;qelt;$3I;7| |U16MAT;elt;$3I;8| |U16MAT;qsetelt!;$4I;9|
              |U16MAT;setelt!;$4I;10| |U16MAT;empty;$;11|
              |U16MAT;qnew;2Nni$;12| |U16MAT;new;2NniI$;13| (|List| 6)
              (|Equation| 6) (|List| 22) (|Boolean|) (|OutputForm|) (|List| 28)
              (|Union| $ '"failed") (|U16Vector|) (|List| $) (|SingleInteger|)
              (|String|) (|HashState|) (|Mapping| 24 6 6) (|Mapping| 24 6)
              (|Void|) (|List| 41) (|Union| 6 '"one") (|List| 21)
              (|Mapping| 6 6 6) (|List| 29) (|List| 9) (|Mapping| 6 6)
              (|PositiveInteger|) (|List| 45) (|Segment| 6))
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
           (CONS (|makeByteWordVec2| 10 '(0 0 0 1 0 8 6 0 0 0 8 5 10))
                 (CONS
                  '#(|MatrixCategory&| |TwoDimensionalArrayCategory&|
                     |HomogeneousAggregate&| NIL |Aggregate&| |Evalable&|
                     |SetCategory&| NIL NIL NIL |InnerEvalable&| |BasicType&|
                     NIL)
                  (CONS
                   '#((|MatrixCategory| 6 28 28)
                      (|TwoDimensionalArrayCategory| 6 28 28)
                      (|HomogeneousAggregate| 6) (|Comparable|) (|Aggregate|)
                      (|Evalable| 6) (|SetCategory|) (|Type|)
                      (|finiteAggregate|) (|shallowlyMutable|)
                      (|InnerEvalable| 6 6) (|BasicType|) (|CoercibleTo| 25))
                   (|makeByteWordVec2| 45
                                       '(2 21 24 0 0 1 1 0 24 0 1 2 0 0 9 9 1 2
                                         0 29 0 41 1 2 0 29 0 43 1 2 0 0 0 0 1
                                         1 0 0 29 1 1 0 0 28 1 1 0 0 0 1 1 0 24
                                         0 1 3 0 0 0 6 6 1 3 0 0 0 6 6 1 5 0 0
                                         0 6 6 6 6 1 1 0 0 0 1 1 0 24 0 1 2 1
                                         24 0 0 1 2 0 24 0 9 1 4 0 0 0 6 6 0 1
                                         4 0 0 0 44 45 0 1 4 0 0 0 44 44 0 1 4
                                         0 0 0 45 21 0 1 4 0 0 0 45 44 0 1 4 0
                                         0 0 45 45 0 1 4 0 0 0 21 45 0 1 4 0 0
                                         0 21 6 0 1 4 0 0 0 21 21 0 1 4 0 0 0 6
                                         21 0 1 4 0 6 0 6 6 6 17 4 0 0 0 44 6 0
                                         1 4 0 0 0 6 44 0 1 3 0 0 0 6 28 1 3 0
                                         0 0 6 28 1 2 0 0 9 6 1 0 0 0 1 1 0 45
                                         0 1 1 14 0 0 1 2 0 28 0 6 1 1 15 9 0 1
                                         4 0 6 0 6 6 6 16 2 0 0 9 9 19 3 0 6 0
                                         6 6 14 2 12 0 0 6 1 1 0 21 0 1 1 15 9
                                         0 1 1 15 26 0 1 1 0 9 0 10 3 0 0 9 9 6
                                         20 1 0 9 0 11 2 0 24 0 9 1 1 16 6 0 1
                                         1 0 6 0 7 1 0 6 0 8 1 19 6 0 1 1 18 21
                                         0 1 2 20 24 6 0 1 1 0 6 0 12 1 0 6 0
                                         13 1 19 6 0 1 2 18 6 33 0 1 1 0 0 38 1
                                         3 0 0 9 9 39 1 2 0 0 42 0 1 3 0 0 39 0
                                         0 1 4 0 0 39 0 0 6 1 2 0 0 42 0 1 1 0
                                         38 0 1 2 0 24 0 9 1 1 4 31 0 1 7 0 35
                                         0 6 36 29 9 9 37 1 2 0 0 0 0 1 1 0 0
                                         29 1 2 12 0 0 0 1 1 12 0 29 1 1 17 27
                                         0 1 2 0 29 0 41 1 2 0 29 0 43 1 2 0 0
                                         0 0 1 1 0 0 29 1 2 4 32 32 0 1 1 4 30
                                         0 1 2 0 0 0 6 1 2 15 27 0 6 1 2 18 24
                                         34 0 1 3 7 0 0 21 21 1 2 7 0 0 22 1 3
                                         7 0 0 6 6 1 2 7 0 0 23 1 2 0 24 0 0 1
                                         1 0 24 0 1 0 0 0 18 3 0 0 0 44 45 1 3
                                         0 0 0 44 44 1 3 0 0 0 45 44 1 3 0 0 0
                                         44 6 1 3 0 0 0 45 21 1 3 0 0 0 6 44 1
                                         3 0 0 0 45 45 1 3 0 0 0 21 45 1 3 0 0
                                         0 21 6 1 3 0 0 0 21 21 1 3 0 0 0 6 21
                                         1 4 0 6 0 6 6 6 1 3 0 6 0 6 6 15 1 0 0
                                         29 1 1 0 0 21 1 1 0 24 0 1 1 16 6 0 1
                                         2 20 9 6 0 1 2 18 9 34 0 1 1 0 0 0 1 1
                                         14 26 0 1 2 0 28 0 6 1 1 0 45 0 1 1 9
                                         25 0 1 1 0 0 28 1 3 0 40 0 41 41 1 3 0
                                         40 0 43 43 1 1 0 0 40 1 2 18 24 34 0 1
                                         1 11 24 0 1 2 13 0 0 9 1 2 17 0 0 6 1
                                         1 16 6 0 1 2 21 24 0 0 1 2 17 0 0 6 1
                                         1 11 0 0 1 2 11 0 0 0 1 2 0 0 0 0 1 2
                                         11 0 6 0 1 2 12 28 28 0 1 2 12 0 0 6 1
                                         2 12 28 0 28 1 2 12 0 0 0 1 2 12 0 6 0
                                         1 1 18 9 0 1)))))
           '|lookupComplete|)) 

(MAKEPROP '|U16Matrix| 'NILADIC T) 
