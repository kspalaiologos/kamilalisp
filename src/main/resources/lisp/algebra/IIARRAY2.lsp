
(PUT '|IIARRAY2;empty;$;1| '|SPADreplace| '(XLAM NIL (MAKE_MATRIX 0 0))) 

(SDEFUN |IIARRAY2;empty;$;1| (($ ($))) (MAKE_MATRIX 0 0)) 

(PUT '|IIARRAY2;qnew;2Nni$;2| '|SPADreplace| 'MAKE_MATRIX) 

(SDEFUN |IIARRAY2;qnew;2Nni$;2|
        ((|rows| #1=(|NonNegativeInteger|)) (|cols| #1#) ($ ($)))
        (MAKE_MATRIX |rows| |cols|)) 

(PUT '|IIARRAY2;new;2NniR$;3| '|SPADreplace| 'MAKE_MATRIX1) 

(SDEFUN |IIARRAY2;new;2NniR$;3|
        ((|rows| #1=(|NonNegativeInteger|)) (|cols| #1#) (|a| (R)) ($ ($)))
        (MAKE_MATRIX1 |rows| |cols| |a|)) 

(SDEFUN |IIARRAY2;minRowIndex;$I;4| ((|m| ($)) ($ (|Integer|))) (QREFELT $ 7)) 

(SDEFUN |IIARRAY2;minColIndex;$I;5| ((|m| ($)) ($ (|Integer|))) (QREFELT $ 8)) 

(SDEFUN |IIARRAY2;maxRowIndex;$I;6| ((|m| ($)) ($ (|Integer|)))
        (- (+ (SPADCALL |m| (QREFELT $ 18)) (QREFELT $ 7)) 1)) 

(SDEFUN |IIARRAY2;maxColIndex;$I;7| ((|m| ($)) ($ (|Integer|)))
        (- (+ (SPADCALL |m| (QREFELT $ 20)) (QREFELT $ 8)) 1)) 

(PUT '|IIARRAY2;nrows;$Nni;8| '|SPADreplace| 'ANROWS) 

(SDEFUN |IIARRAY2;nrows;$Nni;8| ((|m| ($)) ($ (|NonNegativeInteger|)))
        (ANROWS |m|)) 

(PUT '|IIARRAY2;ncols;$Nni;9| '|SPADreplace| 'ANCOLS) 

(SDEFUN |IIARRAY2;ncols;$Nni;9| ((|m| ($)) ($ (|NonNegativeInteger|)))
        (ANCOLS |m|)) 

(SDEFUN |IIARRAY2;qelt;$2IR;10|
        ((|m| ($)) (|i| #1=(|Integer|)) (|j| #1#) ($ (R)))
        (QAREF2O |m| |i| |j| (QREFELT $ 7) (QREFELT $ 8))) 

(SDEFUN |IIARRAY2;elt;$2IR;11|
        ((|m| ($)) (|i| #1=(|Integer|)) (|j| #1#) ($ (R)))
        (COND
         ((OR (< |i| (SPADCALL |m| (QREFELT $ 16)))
              (> |i| (SPADCALL |m| (QREFELT $ 19))))
          (|error| "elt: index out of range"))
         ((OR (< |j| (SPADCALL |m| (QREFELT $ 17)))
              (> |j| (SPADCALL |m| (QREFELT $ 21))))
          (|error| "elt: index out of range"))
         ('T (SPADCALL |m| |i| |j| (QREFELT $ 22))))) 

(SDEFUN |IIARRAY2;qsetelt!;$2I2R;12|
        ((|m| ($)) (|i| #1=(|Integer|)) (|j| #1#) (|r| (R)) ($ (R)))
        (QSETAREF2O |m| |i| |j| |r| (QREFELT $ 7) (QREFELT $ 8))) 

(SDEFUN |IIARRAY2;setelt!;$2I2R;13|
        ((|m| ($)) (|i| #1=(|Integer|)) (|j| #1#) (|r| (R)) ($ (R)))
        (COND
         ((OR (< |i| (SPADCALL |m| (QREFELT $ 16)))
              (> |i| (SPADCALL |m| (QREFELT $ 19))))
          (|error| "setelt!: index out of range"))
         ((OR (< |j| (SPADCALL |m| (QREFELT $ 17)))
              (> |j| (SPADCALL |m| (QREFELT $ 21))))
          (|error| "setelt!: index out of range"))
         ('T (SPADCALL |m| |i| |j| |r| (QREFELT $ 24))))) 

(SDEFUN |IIARRAY2;latex;$S;14| ((|m| ($)) ($ (|String|)))
        (SPROG
         ((|s| (|String|)) (#1=#:G3086 NIL) (|j| NIL) (#2=#:G3085 NIL)
          (|i| NIL) (#3=#:G3084 NIL))
         (SEQ (LETT |s| "\\left[ \\begin{array}{")
              (SEQ (LETT |j| (SPADCALL |m| (QREFELT $ 17)))
                   (LETT #3# (SPADCALL |m| (QREFELT $ 21))) G190
                   (COND ((> |j| #3#) (GO G191)))
                   (SEQ (EXIT (LETT |s| (STRCONC |s| "c"))))
                   (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))
              (LETT |s| (STRCONC |s| "} "))
              (SEQ (LETT |i| (SPADCALL |m| (QREFELT $ 16)))
                   (LETT #2# (SPADCALL |m| (QREFELT $ 19))) G190
                   (COND ((> |i| #2#) (GO G191)))
                   (SEQ
                    (SEQ (LETT |j| (SPADCALL |m| (QREFELT $ 17)))
                         (LETT #1# (SPADCALL |m| (QREFELT $ 21))) G190
                         (COND ((> |j| #1#) (GO G191)))
                         (SEQ
                          (LETT |s|
                                (STRCONC |s|
                                         (SPADCALL
                                          (SPADCALL |m| |i| |j| (QREFELT $ 22))
                                          (QREFELT $ 27))))
                          (EXIT
                           (COND
                            ((< |j| (SPADCALL |m| (QREFELT $ 21)))
                             (LETT |s| (STRCONC |s| " & "))))))
                         (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))
                    (EXIT
                     (COND
                      ((< |i| (SPADCALL |m| (QREFELT $ 19)))
                       (LETT |s| (STRCONC |s| " \\\\ "))))))
                   (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
              (EXIT (STRCONC |s| "\\end{array} \\right]"))))) 

(SDEFUN |IIARRAY2;hashUpdate!;Hs$Hs;15|
        ((|s| (|HashState|)) (|m| ($)) ($ (|HashState|)))
        (SPROG ((#1=#:G3094 NIL) (|j| NIL) (#2=#:G3093 NIL) (|i| NIL))
               (SEQ
                (SEQ (LETT |i| (SPADCALL |m| (QREFELT $ 16)))
                     (LETT #2# (SPADCALL |m| (QREFELT $ 19))) G190
                     (COND ((> |i| #2#) (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ (LETT |j| (SPADCALL |m| (QREFELT $ 17)))
                            (LETT #1# (SPADCALL |m| (QREFELT $ 21))) G190
                            (COND ((> |j| #1#) (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT |s|
                                    (SPADCALL |s|
                                              (SPADCALL |m| |i| |j|
                                                        (QREFELT $ 22))
                                              (QREFELT $ 30)))))
                            (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
                     (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                (EXIT |s|)))) 

(DECLAIM (NOTINLINE |InnerIndexedTwoDimensionalArray;|)) 

(DEFUN |InnerIndexedTwoDimensionalArray| (&REST #1=#:G3102)
  (SPROG NIL
         (PROG (#2=#:G3103)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T NIL NIL T T))
                     (HGET |$ConstructorCache|
                           '|InnerIndexedTwoDimensionalArray|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |InnerIndexedTwoDimensionalArray;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|InnerIndexedTwoDimensionalArray|)))))))))) 

(DEFUN |InnerIndexedTwoDimensionalArray;| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) (#1=#:G3099 NIL) (#2=#:G3100 NIL) ($ NIL) (|dv$| NIL)
    (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 |#2|)
    (LETT DV$3 |#3|)
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT |dv$|
          (LIST '|InnerIndexedTwoDimensionalArray| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 50))
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
                                             #2#))))))
    (|haddProp| |$ConstructorCache| '|InnerIndexedTwoDimensionalArray|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (AND (|HasCategory| $ '(|finiteAggregate|)) (|augmentPredVector| $ 1024))
    (AND (|HasCategory| |#1| '(|OrderedSet|))
         (|HasCategory| $ '(|finiteAggregate|)) (|augmentPredVector| $ 2048))
    (AND (|HasCategory| |#1| '(|BasicType|))
         (|HasCategory| $ '(|finiteAggregate|)) (|augmentPredVector| $ 4096))
    (AND
     (OR
      (AND (|HasCategory| |#1| '(|BasicType|))
           (|HasCategory| $ '(|finiteAggregate|)))
      #2#)
     (|augmentPredVector| $ 8192))
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|testBitVector| |pv$| 4)
      (PROGN
       (QSETREFV $ 28 (CONS (|dispatchFunction| |IIARRAY2;latex;$S;14|) $))
       (QSETREFV $ 31
                 (CONS (|dispatchFunction| |IIARRAY2;hashUpdate!;Hs$Hs;15|)
                       $)))))
    $))) 

(MAKEPROP '|InnerIndexedTwoDimensionalArray| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) |IIARRAY2;empty;$;1|
              (|NonNegativeInteger|) |IIARRAY2;qnew;2Nni$;2|
              |IIARRAY2;new;2NniR$;3| (|Integer|) |IIARRAY2;minRowIndex;$I;4|
              |IIARRAY2;minColIndex;$I;5| |IIARRAY2;nrows;$Nni;8|
              |IIARRAY2;maxRowIndex;$I;6| |IIARRAY2;ncols;$Nni;9|
              |IIARRAY2;maxColIndex;$I;7| |IIARRAY2;qelt;$2IR;10|
              |IIARRAY2;elt;$2IR;11| |IIARRAY2;qsetelt!;$2I2R;12|
              |IIARRAY2;setelt!;$2I2R;13| (|String|) (0 . |latex|)
              (5 . |latex|) (|HashState|) (10 . |hashUpdate!|)
              (16 . |hashUpdate!|) (|Boolean|) (|List| 6) (|Equation| 6)
              (|List| 34) (|Mapping| 32 6 6) (|Mapping| 32 6) (|OutputForm|)
              (|SingleInteger|) (|Mapping| 6 6 6) (|List| 45) (|List| 12)
              (|Mapping| 6 6) (|PositiveInteger|) (|List| $) (|List| 47)
              (|Segment| 15) (|List| 15) (|List| 33))
           '#(~= 22 |vertSplit| 28 |vertConcat| 40 |transpose| 51 |swapRows!|
              56 |swapColumns!| 63 |subMatrix| 70 |squareTop| 79 |smaller?| 84
              |size?| 90 |setsubMatrix!| 96 |setelt!| 104 |setRow!| 200
              |setColumn!| 207 |sample| 214 |rowSlice| 218 |row| 223 |qsetelt!|
              229 |qnew| 237 |qelt| 243 |parts| 250 |nrows| 255 |new| 260
              |ncols| 267 |more?| 272 |minRowIndex| 278 |minColIndex| 283 |min|
              288 |members| 293 |member?| 298 |maxRowIndex| 304 |maxColIndex|
              309 |max| 314 |map!| 325 |map| 331 |listOfLists| 352 |less?| 357
              |latex| 363 |horizSplit| 368 |horizConcat| 380 |hashUpdate!| 391
              |hash| 397 |fill!| 402 |every?| 408 |eval| 414 |eq?| 440 |empty?|
              446 |empty| 451 |elt| 455 |count| 547 |copy| 559 |column| 564
              |colSlice| 570 |coerce| 575 |blockSplit| 580 |blockConcat| 594
              |any?| 599 = 605 |#| 611)
           'NIL
           (CONS (|makeByteWordVec2| 10 '(0 0 1 0 8 6 0 0 0 8 5 10))
                 (CONS
                  '#(|TwoDimensionalArrayCategory&| |HomogeneousAggregate&| NIL
                     |Aggregate&| |Evalable&| |SetCategory&| NIL NIL NIL
                     |InnerEvalable&| |BasicType&| NIL)
                  (CONS
                   '#((|TwoDimensionalArrayCategory| 6 9 10)
                      (|HomogeneousAggregate| 6) (|Comparable|) (|Aggregate|)
                      (|Evalable| 6) (|SetCategory|) (|Type|)
                      (|finiteAggregate|) (|shallowlyMutable|)
                      (|InnerEvalable| 6 6) (|BasicType|) (|CoercibleTo| 38))
                   (|makeByteWordVec2| 49
                                       '(1 6 26 0 27 1 0 26 0 28 2 6 29 29 0 30
                                         2 0 29 29 0 31 2 14 32 0 0 1 2 0 45 0
                                         42 1 2 0 45 0 44 1 1 0 0 45 1 2 0 0 0
                                         0 1 1 0 0 0 1 3 0 0 0 15 15 1 3 0 0 0
                                         15 15 1 5 0 0 0 15 15 15 15 1 1 0 0 0
                                         1 2 1 32 0 0 1 2 0 32 0 12 1 4 0 0 0
                                         15 15 0 1 4 0 0 0 46 46 0 1 4 0 0 0 47
                                         46 0 1 4 0 0 0 46 47 0 1 4 0 0 0 47 48
                                         0 1 4 0 0 0 47 47 0 1 4 0 0 0 48 47 0
                                         1 4 0 0 0 48 48 0 1 4 0 0 0 15 48 0 1
                                         4 0 0 0 48 15 0 1 4 0 6 0 15 15 6 25 4
                                         0 0 0 46 15 0 1 4 0 0 0 15 46 0 1 3 0
                                         0 0 15 9 1 3 0 0 0 15 10 1 0 0 0 1 1 0
                                         47 0 1 2 0 9 0 15 1 4 0 6 0 15 15 6 24
                                         2 0 0 12 12 13 3 0 6 0 15 15 22 1 0 33
                                         0 1 1 0 12 0 18 3 0 0 12 12 6 14 1 0
                                         12 0 20 2 0 32 0 12 1 1 0 15 0 16 1 0
                                         15 0 17 1 12 6 0 1 1 11 33 0 1 2 13 32
                                         6 0 1 1 0 15 0 19 1 0 15 0 21 1 12 6 0
                                         1 2 11 6 36 0 1 2 0 0 43 0 1 4 0 0 40
                                         0 0 6 1 3 0 0 40 0 0 1 2 0 0 43 0 1 1
                                         0 49 0 1 2 0 32 0 12 1 1 4 26 0 28 2 0
                                         45 0 44 1 2 0 45 0 42 1 1 0 0 45 1 2 0
                                         0 0 0 1 2 4 29 29 0 31 1 4 39 0 1 2 0
                                         0 0 6 1 2 11 32 37 0 1 3 7 0 0 6 6 1 3
                                         7 0 0 33 33 1 2 7 0 0 34 1 2 7 0 0 35
                                         1 2 0 32 0 0 1 1 0 32 0 1 0 0 0 11 3 0
                                         0 0 46 46 1 3 0 0 0 47 46 1 3 0 0 0 46
                                         47 1 3 0 0 0 46 15 1 3 0 0 0 47 48 1 3
                                         0 0 0 15 46 1 3 0 0 0 48 47 1 3 0 0 0
                                         48 48 1 3 0 0 0 47 47 1 3 0 0 0 48 15
                                         1 3 0 0 0 15 48 1 4 0 6 0 15 15 6 1 3
                                         0 6 0 15 15 23 2 13 12 6 0 1 2 11 12
                                         37 0 1 1 0 0 0 1 2 0 10 0 15 1 1 0 47
                                         0 1 1 9 38 0 1 3 0 41 0 42 42 1 3 0 41
                                         0 44 44 1 1 0 0 41 1 2 11 32 37 0 1 2
                                         14 32 0 0 1 1 11 12 0 1)))))
           '|lookupComplete|)) 
