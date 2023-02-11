
(SDEFUN |RMATRIX;Zero;$;1| (($ ($))) (QREFELT $ 10)) 

(SDEFUN |RMATRIX;coerce;$Of;2| ((|x| ($)) ($ (|OutputForm|)))
        (SPADCALL |x| (QREFELT $ 13))) 

(SDEFUN |RMATRIX;matrix;L$;3| ((|l| (|List| (|List| R))) ($ ($)))
        (SPROG
         ((#1=#:G721 NIL) (|j| NIL) (#2=#:G722 NIL) (|r| NIL) (#3=#:G719 NIL)
          (|i| NIL) (#4=#:G720 NIL) (|ll| NIL) (|ans| (|Matrix| R))
          (#5=#:G717 NIL) (#6=#:G718 NIL))
         (SEQ
          (COND
           ((SPADCALL (LENGTH |l|) (QREFELT $ 6) (QREFELT $ 17))
            (|error| "matrix: wrong number of rows"))
           ('T
            (SEQ
             (SEQ
              (EXIT
               (SEQ (LETT |ll| NIL) (LETT #6# |l|) G190
                    (COND
                     ((OR (ATOM #6#) (PROGN (LETT |ll| (CAR #6#)) NIL))
                      (GO G191)))
                    (SEQ
                     (EXIT
                      (COND
                       ((SPADCALL (LENGTH |ll|) (QREFELT $ 7) (QREFELT $ 17))
                        (PROGN
                         (LETT #5# (|error| "matrix: wrong number of columns"))
                         (GO #7=#:G707))))))
                    (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL)))
              #7# (EXIT #5#))
             (LETT |ans|
                   (MAKE_MATRIX1 (QREFELT $ 6) (QREFELT $ 7)
                                 (|spadConstant| $ 9)))
             (SEQ (LETT |ll| NIL) (LETT #4# |l|) (LETT |i| (PROGN |ans| 1))
                  (LETT #3# (SPADCALL |ans| (QREFELT $ 19))) G190
                  (COND
                   ((OR (> |i| #3#) (ATOM #4#)
                        (PROGN (LETT |ll| (CAR #4#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (SEQ (LETT |r| NIL) (LETT #2# |ll|)
                         (LETT |j| (PROGN |ans| 1))
                         (LETT #1# (SPADCALL |ans| (QREFELT $ 20))) G190
                         (COND
                          ((OR (> |j| #1#) (ATOM #2#)
                               (PROGN (LETT |r| (CAR #2#)) NIL))
                           (GO G191)))
                         (SEQ (EXIT (QSETAREF2O |ans| |i| |j| |r| 1 1)))
                         (LETT |j| (PROG1 (+ |j| 1) (LETT #2# (CDR #2#))))
                         (GO G190) G191 (EXIT NIL))))
                  (LETT |i| (PROG1 (+ |i| 1) (LETT #4# (CDR #4#)))) (GO G190)
                  G191 (EXIT NIL))
             (EXIT |ans|))))))) 

(SDEFUN |RMATRIX;row;$IDp;4|
        ((|x| ($)) (|i| (|Integer|)) ($ (|DirectProduct| |n| R)))
        (SPADCALL (SPADCALL |x| |i| (QREFELT $ 24)) (QREFELT $ 26))) 

(SDEFUN |RMATRIX;column;$IDp;5|
        ((|x| ($)) (|j| (|Integer|)) ($ (|DirectProduct| |m| R)))
        (SPADCALL (SPADCALL |x| |j| (QREFELT $ 28)) (QREFELT $ 30))) 

(SDEFUN |RMATRIX;coerce;$M;6| ((|x| ($)) ($ (|Matrix| R)))
        (SPADCALL |x| (QREFELT $ 32))) 

(SDEFUN |RMATRIX;rectangularMatrix;M$;7| ((|x| (|Matrix| R)) ($ ($)))
        (COND
         ((OR (SPADCALL (ANROWS |x|) (QREFELT $ 6) (QREFELT $ 17))
              (SPADCALL (ANCOLS |x|) (QREFELT $ 7) (QREFELT $ 17)))
          (|error| "rectangularMatrix: matrix of bad dimensions"))
         ('T (SPADCALL |x| (QREFELT $ 32))))) 

(SDEFUN |RMATRIX;rowEchelon;2$;8| ((|x| ($)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 35))) 

(SDEFUN |RMATRIX;columnSpace;$L;9|
        ((|x| ($)) ($ (|List| (|DirectProduct| |m| R))))
        (SPROG ((#1=#:G735 NIL) (|c| NIL) (#2=#:G734 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |c| NIL) (LETT #1# (SPADCALL |x| (QREFELT $ 38)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |c| (QREFELT $ 30)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |RMATRIX;rank;$Nni;10| ((|x| ($)) ($ (|NonNegativeInteger|)))
        (SPADCALL |x| (QREFELT $ 41))) 

(SDEFUN |RMATRIX;nullity;$Nni;11| ((|x| ($)) ($ (|NonNegativeInteger|)))
        (SPADCALL |x| (QREFELT $ 43))) 

(SDEFUN |RMATRIX;nullSpace;$L;12|
        ((|x| ($)) ($ (|List| (|DirectProduct| |m| R))))
        (SPROG ((#1=#:G742 NIL) (|c| NIL) (#2=#:G741 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |c| NIL) (LETT #1# (SPADCALL |x| (QREFELT $ 45)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |c| (QREFELT $ 30)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |RMATRIX;convert;$If;13| ((|x| ($)) ($ (|InputForm|)))
        (SPADCALL
         (LIST (SPADCALL '|rectangularMatrix| (QREFELT $ 49))
               (SPADCALL (SPADCALL |x| (QREFELT $ 33)) (QREFELT $ 50)))
         (QREFELT $ 52))) 

(DECLAIM (NOTINLINE |RectangularMatrix;|)) 

(DEFUN |RectangularMatrix| (&REST #1=#:G759)
  (SPROG NIL
         (PROG (#2=#:G760)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(NIL NIL T))
                     (HGET |$ConstructorCache| '|RectangularMatrix|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |RectangularMatrix;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|RectangularMatrix|)))))))))) 

(DEFUN |RectangularMatrix;| (|#1| |#2| |#3|)
  (SPROG
   ((#1=#:G758 NIL) (|pv$| NIL) (#2=#:G755 NIL) (#3=#:G756 NIL) ($ NIL)
    (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 |#1|)
    (LETT DV$2 |#2|)
    (LETT DV$3 (|devaluate| |#3|))
    (LETT |dv$| (LIST '|RectangularMatrix| DV$1 DV$2 DV$3))
    (LETT $ (GETREFV 66))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#3| '(|AbelianGroup|))
                                        (|HasCategory| |#3|
                                                       '(|CommutativeRing|))
                                        (|HasCategory| |#3| '(|Finite|))
                                        (AND
                                         (|HasCategory| |#3|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#3|)))
                                         (|HasCategory| |#3| '(|SetCategory|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#3|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#3|)))
                                          (|HasCategory| |#3|
                                                         '(|CommutativeRing|)))
                                         (AND
                                          (|HasCategory| |#3|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#3|)))
                                          (|HasCategory| |#3| '(|Finite|)))
                                         (AND
                                          (|HasCategory| |#3|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#3|)))
                                          (|HasCategory| |#3|
                                                         '(|SetCategory|))))
                                        (|HasCategory| |#3| '(|BasicType|))
                                        (|HasCategory| |#3| '(|OrderedSet|))
                                        (|HasCategory| |#3| '(|Field|))
                                        (|HasCategory| |#3|
                                                       '(|EuclideanDomain|))
                                        (|HasCategory| |#3|
                                                       '(|IntegralDomain|))
                                        (LETT #3#
                                              (|HasCategory| |#3|
                                                             '(|AbelianMonoid|)))
                                        (OR
                                         (|HasCategory| |#3| '(|AbelianGroup|))
                                         #3#)
                                        (LETT #2#
                                              (|HasCategory| |#3|
                                                             '(|ConvertibleTo|
                                                               (|InputForm|))))
                                        (OR #2#
                                            (AND
                                             (|HasCategory| |#3|
                                                            (LIST '|Evalable|
                                                                  (|devaluate|
                                                                   |#3|)))
                                             (|HasCategory| |#3| '(|Finite|)))
                                            (AND
                                             (|HasCategory| |#3|
                                                            '(|AbelianGroup|))
                                             (|HasCategory| |#3| '(|Finite|)))
                                            (AND #3#
                                                 (|HasCategory| |#3|
                                                                '(|Finite|)))
                                            (AND
                                             (|HasCategory| |#3|
                                                            '(|CommutativeRing|))
                                             (|HasCategory| |#3|
                                                            '(|Finite|))))))))
    (|haddProp| |$ConstructorCache| '|RectangularMatrix| (LIST DV$1 DV$2 DV$3)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (AND (|HasCategory| $ '(|shallowlyMutable|)) (|augmentPredVector| $ 16384))
    (AND (LETT #1# (|HasCategory| $ '(|finiteAggregate|)))
         (|augmentPredVector| $ 32768))
    (AND (|HasCategory| |#3| '(|BasicType|)) #1# (|augmentPredVector| $ 65536))
    (AND (|HasCategory| |#3| '(|OrderedSet|)) #1#
         (|augmentPredVector| $ 131072))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 10 (MAKE_MATRIX1 |#1| |#2| (|spadConstant| $ 9)))
    (COND
     ((|testBitVector| |pv$| 9)
      (PROGN
       (QSETREFV $ 36 (CONS (|dispatchFunction| |RMATRIX;rowEchelon;2$;8|) $))
       (QSETREFV $ 40
                 (CONS (|dispatchFunction| |RMATRIX;columnSpace;$L;9|) $)))))
    (COND
     ((|testBitVector| |pv$| 10)
      (PROGN
       (QSETREFV $ 42 (CONS (|dispatchFunction| |RMATRIX;rank;$Nni;10|) $))
       (QSETREFV $ 44 (CONS (|dispatchFunction| |RMATRIX;nullity;$Nni;11|) $))
       (QSETREFV $ 46
                 (CONS (|dispatchFunction| |RMATRIX;nullSpace;$L;12|) $)))))
    (COND
     ((|testBitVector| |pv$| 13)
      (QSETREFV $ 53 (CONS (|dispatchFunction| |RMATRIX;convert;$If;13|) $))))
    $))) 

(MAKEPROP '|RectangularMatrix| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|Matrix| 8) (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (0 . |Zero|) 'ZERO
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |RMATRIX;Zero;$;1|) $))
              (|OutputForm|) (4 . |coerce|) |RMATRIX;coerce;$Of;2| (|Boolean|)
              (|NonNegativeInteger|) (9 . ~=) (|Integer|) (15 . |maxRowIndex|)
              (20 . |maxColIndex|) (|List| 56) |RMATRIX;matrix;L$;3|
              (|Vector| 8) (25 . |row|)
              (|DirectProduct| (NRTEVAL (QREFELT $ 7)) 8)
              (31 . |directProduct|) |RMATRIX;row;$IDp;4| (36 . |column|)
              (|DirectProduct| (NRTEVAL (QREFELT $ 6)) 8)
              (42 . |directProduct|) |RMATRIX;column;$IDp;5| (47 . |copy|)
              |RMATRIX;coerce;$M;6| |RMATRIX;rectangularMatrix;M$;7|
              (52 . |rowEchelon|) (57 . |rowEchelon|) (|List| 23)
              (62 . |columnSpace|) (|List| 29) (67 . |columnSpace|)
              (72 . |rank|) (77 . |rank|) (82 . |nullity|) (87 . |nullity|)
              (92 . |nullSpace|) (97 . |nullSpace|) (|Symbol|) (|InputForm|)
              (102 . |convert|) (107 . |convert|) (|List| $) (112 . |convert|)
              (117 . |convert|) (|List| 55) (|Equation| 8) (|List| 8)
              (|Mapping| 15 8) (|Mapping| 15 8 8) (|Mapping| 8 8)
              (|Union| $ '"failed") (|PositiveInteger|) (|Mapping| 8 8 8)
              (|String|) (|SingleInteger|) (|HashState|))
           '#(~= 122 |zero?| 128 |symmetric?| 133 |subtractIfCan| 138 |square?|
              144 |smaller?| 149 |size?| 155 |size| 161 |sample| 165
              |rowEchelon| 169 |row| 174 |rectangularMatrix| 180 |rank| 185
              |random| 190 |qelt| 194 |parts| 201 |opposite?| 206 |nullity| 212
              |nullSpace| 217 |nrows| 222 |ncols| 227 |more?| 232 |minRowIndex|
              238 |minColIndex| 243 |min| 248 |members| 253 |member?| 258
              |maxRowIndex| 264 |maxColIndex| 269 |max| 274 |matrix| 285 |map!|
              290 |map| 296 |lookup| 309 |listOfLists| 314 |less?| 319 |latex|
              325 |index| 330 |hashUpdate!| 335 |hash| 341 |exquo| 346 |every?|
              352 |eval| 358 |eq?| 384 |enumerate| 390 |empty?| 394 |empty| 399
              |elt| 403 |diagonal?| 418 |count| 423 |copy| 435 |convert| 440
              |columnSpace| 445 |column| 450 |coerce| 456 |any?| 466
              |antisymmetric?| 472 |Zero| 477 = 481 / 487 - 493 + 504 * 510 |#|
              540)
           'NIL
           (CONS
            (|makeByteWordVec2| 14
                                '(0 2 0 0 0 1 1 12 3 0 0 3 0 0 5 0 0 0 0 0 5
                                  14))
            (CONS
             '#(|RectangularMatrixCategory&| |Module&| NIL NIL NIL
                |AbelianGroup&| NIL |AbelianMonoid&| |Finite&|
                |HomogeneousAggregate&| |AbelianSemiGroup&| NIL |Aggregate&|
                |SetCategory&| |Evalable&| NIL NIL NIL |BasicType&| NIL
                |InnerEvalable&| NIL)
             (CONS
              '#((|RectangularMatrixCategory| 6 7 8 (|DirectProduct| 7 8)
                                              (|DirectProduct| 6 8))
                 (|Module| 8) (|BiModule| 8 8) (|LeftModule| 8)
                 (|RightModule| 8) (|AbelianGroup|)
                 (|CancellationAbelianMonoid|) (|AbelianMonoid|) (|Finite|)
                 (|HomogeneousAggregate| 8) (|AbelianSemiGroup|) (|Comparable|)
                 (|Aggregate|) (|SetCategory|) (|Evalable| 8)
                 (|CoercibleTo| (|Matrix| 8)) (|finiteAggregate|) (|Type|)
                 (|BasicType|) (|CoercibleTo| 12) (|InnerEvalable| 8 8)
                 (|ConvertibleTo| 48))
              (|makeByteWordVec2| 65
                                  '(0 8 0 9 1 5 12 0 13 2 16 15 0 0 17 1 5 18 0
                                    19 1 5 18 0 20 2 5 23 0 18 24 1 25 0 23 26
                                    2 5 23 0 18 28 1 29 0 23 30 1 5 0 0 32 1 5
                                    0 0 35 1 0 0 0 36 1 5 37 0 38 1 0 39 0 40 1
                                    5 16 0 41 1 0 16 0 42 1 5 16 0 43 1 0 16 0
                                    44 1 5 37 0 45 1 0 39 0 46 1 48 0 47 49 1 5
                                    48 0 50 1 48 0 51 52 1 0 48 0 53 2 0 15 0 0
                                    1 1 11 15 0 1 1 0 15 0 1 2 1 60 0 0 1 1 0
                                    15 0 1 2 3 15 0 0 1 2 0 15 0 16 1 0 3 16 1
                                    0 0 0 1 1 9 0 0 36 2 0 25 0 18 27 1 0 0 5
                                    34 1 10 16 0 42 0 3 0 1 3 0 8 0 18 18 1 1
                                    16 56 0 1 2 11 15 0 0 1 1 10 16 0 44 1 10
                                    39 0 46 1 0 16 0 1 1 0 16 0 1 2 0 15 0 16 1
                                    1 0 18 0 1 1 0 18 0 1 1 18 8 0 1 1 16 56 0
                                    1 2 17 15 8 0 1 1 0 18 0 1 1 0 18 0 1 1 18
                                    8 0 1 2 16 8 58 0 1 1 0 0 21 22 2 15 0 59 0
                                    1 3 0 0 62 0 0 1 2 0 0 59 0 1 1 3 61 0 1 1
                                    0 21 0 1 2 0 15 0 16 1 1 0 63 0 1 1 3 0 61
                                    1 2 0 65 65 0 1 1 0 64 0 1 2 10 60 0 8 1 2
                                    16 15 57 0 1 2 4 0 0 54 1 2 4 0 0 55 1 3 4
                                    0 0 56 56 1 3 4 0 0 8 8 1 2 0 15 0 0 1 0 3
                                    51 1 1 0 15 0 1 0 0 0 1 4 0 8 0 18 18 8 1 3
                                    0 8 0 18 18 1 1 0 15 0 1 2 17 16 8 0 1 2 16
                                    16 57 0 1 1 0 0 0 1 1 13 48 0 53 1 9 39 0
                                    40 2 0 29 0 18 31 1 0 5 0 33 1 0 12 0 14 2
                                    16 15 57 0 1 1 0 15 0 1 0 11 0 11 2 0 15 0
                                    0 1 2 8 0 0 8 1 2 1 0 0 0 1 1 1 0 0 1 2 0 0
                                    0 0 1 2 1 0 18 0 1 2 11 0 16 0 1 2 0 0 8 0
                                    1 2 0 0 0 8 1 2 0 0 61 0 1 1 16 16 0 1)))))
           '|lookupComplete|)) 
