
(SDEFUN |DHMATRIX;identity;$;1| (($ ($)))
        (SPADCALL
         (LIST
          (LIST (|spadConstant| $ 7) (|spadConstant| $ 8) (|spadConstant| $ 8)
                (|spadConstant| $ 8))
          (LIST (|spadConstant| $ 8) (|spadConstant| $ 7) (|spadConstant| $ 8)
                (|spadConstant| $ 8))
          (LIST (|spadConstant| $ 8) (|spadConstant| $ 8) (|spadConstant| $ 7)
                (|spadConstant| $ 8))
          (LIST (|spadConstant| $ 8) (|spadConstant| $ 8) (|spadConstant| $ 8)
                (|spadConstant| $ 7)))
         (QREFELT $ 10))) 

(SDEFUN |DHMATRIX;*;$2P;2| ((|d| ($)) (|p| (|Point| R)) ($ (|Point| R)))
        (SPROG ((|v| (|Vector| R)))
               (SEQ (LETT |v| |p|)
                    (LETT |v|
                          (SPADCALL |v| (|spadConstant| $ 7) (QREFELT $ 13)))
                    (LETT |v| (SPADCALL |d| |v| (QREFELT $ 14)))
                    (EXIT
                     (SPADCALL
                      (LIST (SPADCALL |v| 1 (QREFELT $ 16))
                            (SPADCALL |v| 2 (QREFELT $ 16))
                            (SPADCALL |v| 3 (QREFELT $ 16)))
                      (QREFELT $ 19)))))) 

(SDEFUN |DHMATRIX;rotatex;R$;3| ((|degree| (R)) ($ ($)))
        (SPROG ((|sinAngle| (R)) (|cosAngle| (R)) (|angle| (R)))
               (SEQ
                (LETT |angle|
                      (SPADCALL
                       (SPADCALL |degree| (SPADCALL (QREFELT $ 21))
                                 (QREFELT $ 22))
                       (SPADCALL 180 (QREFELT $ 23)) (QREFELT $ 24)))
                (LETT |cosAngle| (SPADCALL |angle| (QREFELT $ 25)))
                (LETT |sinAngle| (SPADCALL |angle| (QREFELT $ 26)))
                (EXIT
                 (SPADCALL
                  (LIST
                   (LIST (|spadConstant| $ 7) (|spadConstant| $ 8)
                         (|spadConstant| $ 8) (|spadConstant| $ 8))
                   (LIST (|spadConstant| $ 8) |cosAngle|
                         (SPADCALL |sinAngle| (QREFELT $ 27))
                         (|spadConstant| $ 8))
                   (LIST (|spadConstant| $ 8) |sinAngle| |cosAngle|
                         (|spadConstant| $ 8))
                   (LIST (|spadConstant| $ 8) (|spadConstant| $ 8)
                         (|spadConstant| $ 8) (|spadConstant| $ 7)))
                  (QREFELT $ 10)))))) 

(SDEFUN |DHMATRIX;rotatey;R$;4| ((|degree| (R)) ($ ($)))
        (SPROG ((|sinAngle| (R)) (|cosAngle| (R)) (|angle| (R)))
               (SEQ
                (LETT |angle|
                      (SPADCALL
                       (SPADCALL |degree| (SPADCALL (QREFELT $ 21))
                                 (QREFELT $ 22))
                       (SPADCALL 180 (QREFELT $ 23)) (QREFELT $ 24)))
                (LETT |cosAngle| (SPADCALL |angle| (QREFELT $ 25)))
                (LETT |sinAngle| (SPADCALL |angle| (QREFELT $ 26)))
                (EXIT
                 (SPADCALL
                  (LIST
                   (LIST |cosAngle| (|spadConstant| $ 8) |sinAngle|
                         (|spadConstant| $ 8))
                   (LIST (|spadConstant| $ 8) (|spadConstant| $ 7)
                         (|spadConstant| $ 8) (|spadConstant| $ 8))
                   (LIST (SPADCALL |sinAngle| (QREFELT $ 27))
                         (|spadConstant| $ 8) |cosAngle| (|spadConstant| $ 8))
                   (LIST (|spadConstant| $ 8) (|spadConstant| $ 8)
                         (|spadConstant| $ 8) (|spadConstant| $ 7)))
                  (QREFELT $ 10)))))) 

(SDEFUN |DHMATRIX;rotatez;R$;5| ((|degree| (R)) ($ ($)))
        (SPROG ((|sinAngle| (R)) (|cosAngle| (R)) (|angle| (R)))
               (SEQ
                (LETT |angle|
                      (SPADCALL
                       (SPADCALL |degree| (SPADCALL (QREFELT $ 21))
                                 (QREFELT $ 22))
                       (SPADCALL 180 (QREFELT $ 23)) (QREFELT $ 24)))
                (LETT |cosAngle| (SPADCALL |angle| (QREFELT $ 25)))
                (LETT |sinAngle| (SPADCALL |angle| (QREFELT $ 26)))
                (EXIT
                 (SPADCALL
                  (LIST
                   (LIST |cosAngle| (SPADCALL |sinAngle| (QREFELT $ 27))
                         (|spadConstant| $ 8) (|spadConstant| $ 8))
                   (LIST |sinAngle| |cosAngle| (|spadConstant| $ 8)
                         (|spadConstant| $ 8))
                   (LIST (|spadConstant| $ 8) (|spadConstant| $ 8)
                         (|spadConstant| $ 7) (|spadConstant| $ 8))
                   (LIST (|spadConstant| $ 8) (|spadConstant| $ 8)
                         (|spadConstant| $ 8) (|spadConstant| $ 7)))
                  (QREFELT $ 10)))))) 

(SDEFUN |DHMATRIX;scale;3R$;6|
        ((|scalex| (R)) (|scaley| (R)) (|scalez| (R)) ($ ($)))
        (SPADCALL
         (LIST
          (LIST |scalex| (|spadConstant| $ 8) (|spadConstant| $ 8)
                (|spadConstant| $ 8))
          (LIST (|spadConstant| $ 8) |scaley| (|spadConstant| $ 8)
                (|spadConstant| $ 8))
          (LIST (|spadConstant| $ 8) (|spadConstant| $ 8) |scalez|
                (|spadConstant| $ 8))
          (LIST (|spadConstant| $ 8) (|spadConstant| $ 8) (|spadConstant| $ 8)
                (|spadConstant| $ 7)))
         (QREFELT $ 10))) 

(SDEFUN |DHMATRIX;translate;3R$;7| ((|x| (R)) (|y| (R)) (|z| (R)) ($ ($)))
        (SPADCALL
         (LIST
          (LIST (|spadConstant| $ 7) (|spadConstant| $ 8) (|spadConstant| $ 8)
                |x|)
          (LIST (|spadConstant| $ 8) (|spadConstant| $ 7) (|spadConstant| $ 8)
                |y|)
          (LIST (|spadConstant| $ 8) (|spadConstant| $ 8) (|spadConstant| $ 7)
                |z|)
          (LIST (|spadConstant| $ 8) (|spadConstant| $ 8) (|spadConstant| $ 8)
                (|spadConstant| $ 7)))
         (QREFELT $ 10))) 

(DECLAIM (NOTINLINE |DenavitHartenbergMatrix;|)) 

(DEFUN |DenavitHartenbergMatrix| (#1=#:G726)
  (SPROG NIL
         (PROG (#2=#:G727)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|DenavitHartenbergMatrix|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|DenavitHartenbergMatrix;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|DenavitHartenbergMatrix|)))))))))) 

(DEFUN |DenavitHartenbergMatrix;| (|#1|)
  (SPROG
   ((|pv$| NIL) (#1=#:G723 NIL) (#2=#:G724 NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|DenavitHartenbergMatrix| DV$1))
    (LETT $ (GETREFV 58))
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
    (|haddProp| |$ConstructorCache| '|DenavitHartenbergMatrix| (LIST DV$1)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
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
    $))) 

(MAKEPROP '|DenavitHartenbergMatrix| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|Matrix| 6) (|local| |#1|) (0 . |One|)
              (4 . |Zero|) (|List| 17) (8 . |matrix|) |DHMATRIX;identity;$;1|
              (|Vector| 6) (13 . |concat|) (19 . *) (|Integer|) (25 . |elt|)
              (|List| 6) (|Point| 6) (31 . |point|) |DHMATRIX;*;$2P;2|
              (36 . |pi|) (40 . *) (46 . |coerce|) (51 . /) (57 . |cos|)
              (62 . |sin|) (67 . -) |DHMATRIX;rotatex;R$;3|
              |DHMATRIX;rotatey;R$;4| |DHMATRIX;rotatez;R$;5|
              |DHMATRIX;scale;3R$;6| |DHMATRIX;translate;3R$;7| (|Boolean|)
              (|NonNegativeInteger|) (|Equation| 6) (|List| 35)
              (|Mapping| 33 6 6) (|Mapping| 33 6) (|OutputForm|) (|List| 12)
              (|Union| $ '"failed") (|List| $) (|HashState|) (|SingleInteger|)
              (|String|) (|Void|) (|List| 52) (|Union| 6 '"one")
              (|Mapping| 6 15 15) (|Mapping| 6 6 6) (|List| 42) (|List| 34)
              (|Mapping| 6 6) (|PositiveInteger|) (|List| 56) (|Segment| 15)
              (|List| 15))
           '#(~= 72 |zero?| 78 |zero| 83 |vertSplit| 89 |vertConcat| 101
              |transpose| 112 |translate| 122 |symmetric?| 129 |swapRows!| 134
              |swapColumns!| 141 |subMatrix| 148 |squareTop| 157 |square?| 162
              |smaller?| 167 |size?| 173 |setsubMatrix!| 179 |setelt!| 187
              |setRow!| 283 |setColumn!| 290 |scale| 297 |scalarMatrix| 304
              |sample| 310 |rowSlice| 314 |rowEchelon| 319 |row| 324 |rotatez|
              330 |rotatey| 335 |rotatex| 340 |rank| 345 |qsetelt!| 350 |qnew|
              358 |qelt| 364 |positivePower| 371 |parts| 377 |nullity| 382
              |nullSpace| 387 |nrows| 392 |new| 397 |ncols| 404 |more?| 409
              |minordet| 415 |minRowIndex| 420 |minColIndex| 425 |min| 430
              |members| 435 |member?| 440 |maxRowIndex| 446 |maxColIndex| 451
              |max| 456 |matrix| 467 |map!| 479 |map| 485 |listOfLists| 506
              |less?| 511 |latex| 517 |kronecker_prod1| 522 |kroneckerSum| 533
              |kroneckerProduct| 544 |inverse| 555 |identity| 560 |horizSplit|
              564 |horizConcat| 576 |hashUpdate!| 587 |hash| 593 |fill!| 598
              |exquo| 604 |every?| 610 |eval| 616 |eq?| 642 |empty?| 648
              |empty| 653 |elt| 657 |diagonalMatrix| 749 |diagonal?| 759
              |determinant| 764 |count| 769 |copy| 781 |columnSpace| 786
              |column| 791 |colSlice| 797 |coerce| 802 |blockSplit| 812
              |blockConcat| 826 |any?| 831 |antisymmetric?| 837 ^ 842
              |Pfaffian| 854 = 859 / 865 - 871 + 882 * 888 |#| 930)
           'NIL
           (CONS (|makeByteWordVec2| 10 '(0 0 0 1 0 8 6 0 0 0 8 5 10))
                 (CONS
                  '#(|MatrixCategory&| |TwoDimensionalArrayCategory&|
                     |HomogeneousAggregate&| NIL |Aggregate&| |Evalable&|
                     |SetCategory&| NIL NIL NIL |InnerEvalable&| |BasicType&|
                     NIL)
                  (CONS
                   '#((|MatrixCategory| 6 (|Vector| 6) (|Vector| 6))
                      (|TwoDimensionalArrayCategory| 6 (|Vector| 6)
                                                     (|Vector| 6))
                      (|HomogeneousAggregate| 6) (|Comparable|) (|Aggregate|)
                      (|Evalable| 6) (|SetCategory|) (|Type|)
                      (|finiteAggregate|) (|shallowlyMutable|)
                      (|InnerEvalable| 6 6) (|BasicType|) (|CoercibleTo| 39))
                   (|makeByteWordVec2| 57
                                       '(0 6 0 7 0 6 0 8 1 0 0 9 10 2 12 0 0 6
                                         13 2 0 12 0 12 14 2 12 6 0 15 16 1 18
                                         0 17 19 0 6 0 21 2 6 0 0 0 22 1 6 0 15
                                         23 2 6 0 0 0 24 1 6 0 0 25 1 6 0 0 26
                                         1 6 0 0 27 2 21 33 0 0 1 1 0 33 0 1 2
                                         0 0 34 34 1 2 0 42 0 54 1 2 0 42 0 52
                                         1 1 0 0 42 1 2 0 0 0 0 1 1 0 0 12 1 1
                                         0 0 0 1 3 0 0 6 6 6 32 1 0 33 0 1 3 0
                                         0 0 15 15 1 3 0 0 0 15 15 1 5 0 0 0 15
                                         15 15 15 1 1 0 0 0 1 1 0 33 0 1 2 1 33
                                         0 0 1 2 0 33 0 34 1 4 0 0 0 15 15 0 1
                                         4 0 0 0 55 55 0 1 4 0 0 0 56 55 0 1 4
                                         0 0 0 55 56 0 1 4 0 0 0 57 56 0 1 4 0
                                         0 0 56 57 0 1 4 0 0 0 57 57 0 1 4 0 0
                                         0 56 56 0 1 4 0 0 0 15 57 0 1 4 0 0 0
                                         57 15 0 1 4 0 6 0 15 15 6 1 4 0 0 0 15
                                         55 0 1 4 0 0 0 55 15 0 1 3 0 0 0 15 12
                                         1 3 0 0 0 15 12 1 3 0 0 6 6 6 31 2 0 0
                                         34 6 1 0 0 0 1 1 0 56 0 1 1 14 0 0 1 2
                                         0 12 0 15 1 1 0 0 6 30 1 0 0 6 29 1 0
                                         0 6 28 1 15 34 0 1 4 0 6 0 15 15 6 1 2
                                         0 0 34 34 1 3 0 6 0 15 15 1 2 12 0 0
                                         15 1 1 0 17 0 1 1 15 34 0 1 1 15 40 0
                                         1 1 0 34 0 1 3 0 0 34 34 6 1 1 0 34 0
                                         1 2 0 33 0 34 1 1 16 6 0 1 1 0 15 0 1
                                         1 0 15 0 1 1 19 6 0 1 1 18 17 0 1 2 20
                                         33 6 0 1 1 0 15 0 1 1 0 15 0 1 1 19 6
                                         0 1 2 18 6 37 0 1 3 0 0 34 34 49 1 1 0
                                         0 9 10 2 0 0 53 0 1 3 0 0 50 0 0 1 4 0
                                         0 50 0 0 6 1 2 0 0 53 0 1 1 0 9 0 1 2
                                         0 33 0 34 1 1 4 45 0 1 7 0 46 0 15 47
                                         42 34 34 48 1 2 0 0 0 0 1 1 0 0 42 1 2
                                         12 0 0 0 1 1 12 0 42 1 1 17 41 0 1 0 0
                                         0 11 2 0 42 0 54 1 2 0 42 0 52 1 1 0 0
                                         42 1 2 0 0 0 0 1 2 4 43 43 0 1 1 4 44
                                         0 1 2 0 0 0 6 1 2 15 41 0 6 1 2 18 33
                                         38 0 1 3 7 0 0 6 6 1 3 7 0 0 17 17 1 2
                                         7 0 0 35 1 2 7 0 0 36 1 2 0 33 0 0 1 1
                                         0 33 0 1 0 0 0 1 3 0 0 0 55 55 1 3 0 0
                                         0 56 55 1 3 0 0 0 55 56 1 3 0 0 0 55
                                         15 1 3 0 0 0 56 57 1 3 0 0 0 15 55 1 3
                                         0 0 0 56 56 1 3 0 0 0 57 56 1 3 0 0 0
                                         57 15 1 3 0 0 0 57 57 1 3 0 0 0 15 57
                                         1 4 0 6 0 15 15 6 1 3 0 6 0 15 15 1 1
                                         0 0 17 1 1 0 0 42 1 1 0 33 0 1 1 16 6
                                         0 1 2 20 34 6 0 1 2 18 34 38 0 1 1 0 0
                                         0 1 1 14 40 0 1 2 0 12 0 15 1 1 0 56 0
                                         1 1 9 39 0 1 1 0 0 12 1 3 0 51 0 52 52
                                         1 3 0 51 0 54 54 1 1 0 0 51 1 2 18 33
                                         38 0 1 1 11 33 0 1 2 13 0 0 34 1 2 17
                                         0 0 15 1 1 16 6 0 1 2 21 33 0 0 1 2 17
                                         0 0 6 1 2 11 0 0 0 1 1 11 0 0 1 2 0 0
                                         0 0 1 2 11 0 15 0 1 2 12 12 12 0 1 2
                                         12 12 0 12 14 2 12 0 6 0 1 2 12 0 0 6
                                         1 2 12 0 0 0 1 2 0 18 0 18 20 1 18 34
                                         0 1)))))
           '|lookupComplete|)) 
