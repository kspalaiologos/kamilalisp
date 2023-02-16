
(SDEFUN |SQMATRIX;Zero;$;1| (($ ($))) (QREFELT $ 10)) 

(SDEFUN |SQMATRIX;One;$;2| (($ ($))) (QREFELT $ 13)) 

(SDEFUN |SQMATRIX;characteristic;Nni;3| (($ (|NonNegativeInteger|)))
        (SPADCALL (QREFELT $ 16))) 

(SDEFUN |SQMATRIX;matrix;L$;4| ((|l| (|List| (|List| R))) ($ ($)))
        (SPROG
         ((#1=#:G723 NIL) (|j| NIL) (#2=#:G724 NIL) (|r| NIL) (#3=#:G721 NIL)
          (|i| NIL) (#4=#:G722 NIL) (|ll| NIL) (|ans| (|Matrix| R))
          (#5=#:G719 NIL) (#6=#:G720 NIL))
         (SEQ
          (COND
           ((SPADCALL (LENGTH |l|) (QREFELT $ 6) (QREFELT $ 19))
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
                       ((SPADCALL (LENGTH |ll|) (QREFELT $ 6) (QREFELT $ 19))
                        (PROGN
                         (LETT #5# (|error| "matrix: wrong number of columns"))
                         (GO #7=#:G709))))))
                    (LETT #6# (CDR #6#)) (GO G190) G191 (EXIT NIL)))
              #7# (EXIT #5#))
             (LETT |ans|
                   (MAKE_MATRIX1 (QREFELT $ 6) (QREFELT $ 6)
                                 (|spadConstant| $ 8)))
             (SEQ (LETT |ll| NIL) (LETT #4# |l|) (LETT |i| (PROGN |ans| 1))
                  (LETT #3# (SPADCALL |ans| (QREFELT $ 21))) G190
                  (COND
                   ((OR (> |i| #3#) (ATOM #4#)
                        (PROGN (LETT |ll| (CAR #4#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (SEQ (LETT |r| NIL) (LETT #2# |ll|)
                         (LETT |j| (PROGN |ans| 1))
                         (LETT #1# (SPADCALL |ans| (QREFELT $ 22))) G190
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

(SDEFUN |SQMATRIX;row;$IDp;5|
        ((|x| ($)) (|i| (|Integer|)) ($ (|DirectProduct| |ndim| R)))
        (SPADCALL (SPADCALL |x| |i| (QREFELT $ 26)) (QREFELT $ 28))) 

(SDEFUN |SQMATRIX;column;$IDp;6|
        ((|x| ($)) (|j| (|Integer|)) ($ (|DirectProduct| |ndim| R)))
        (SPADCALL (SPADCALL |x| |j| (QREFELT $ 30)) (QREFELT $ 28))) 

(SDEFUN |SQMATRIX;coerce;$Of;7| ((|x| ($)) ($ (|OutputForm|)))
        (SPADCALL |x| (QREFELT $ 33))) 

(SDEFUN |SQMATRIX;scalarMatrix;R$;8| ((|r| (R)) ($ ($)))
        (SPADCALL (QREFELT $ 6) |r| (QREFELT $ 35))) 

(SDEFUN |SQMATRIX;diagonalMatrix;L$;9| ((|l| (|List| R)) ($ ($)))
        (COND
         ((SPADCALL (LENGTH |l|) (QREFELT $ 6) (QREFELT $ 19))
          (|error| "diagonalMatrix: wrong number of entries in list"))
         ('T (SPADCALL |l| (QREFELT $ 37))))) 

(SDEFUN |SQMATRIX;coerce;$M;10| ((|x| ($)) ($ (|Matrix| R)))
        (SPADCALL |x| (QREFELT $ 39))) 

(SDEFUN |SQMATRIX;squareMatrix;M$;11| ((|x| (|Matrix| R)) ($ ($)))
        (COND
         ((OR (SPADCALL (ANROWS |x|) (QREFELT $ 6) (QREFELT $ 19))
              (SPADCALL (ANCOLS |x|) (QREFELT $ 6) (QREFELT $ 19)))
          (|error| "squareMatrix: matrix of bad dimensions"))
         ('T (SPADCALL |x| (QREFELT $ 39))))) 

(SDEFUN |SQMATRIX;*;$2Dp;12|
        ((|x| ($)) (|v| #1=(|DirectProduct| |ndim| R)) ($ #1#))
        (SPADCALL (SPADCALL |x| (SPADCALL |v| (QREFELT $ 42)) (QREFELT $ 43))
                  (QREFELT $ 28))) 

(SDEFUN |SQMATRIX;*;Dp$Dp;13|
        ((|v| #1=(|DirectProduct| |ndim| R)) (|x| ($)) ($ #1#))
        (SPADCALL (SPADCALL (SPADCALL |v| (QREFELT $ 42)) |x| (QREFELT $ 45))
                  (QREFELT $ 28))) 

(SDEFUN |SQMATRIX;determinant;$R;14| ((|x| ($)) ($ (R)))
        (SPADCALL |x| (QREFELT $ 47))) 

(SDEFUN |SQMATRIX;minordet;$R;15| ((|x| ($)) ($ (R)))
        (SPADCALL |x| (QREFELT $ 49))) 

(SDEFUN |SQMATRIX;Pfaffian;$R;16| ((|x| ($)) ($ (R)))
        (SPADCALL |x| (QREFELT $ 51))) 

(SDEFUN |SQMATRIX;rowEchelon;2$;17| ((|x| ($)) ($ ($)))
        (SPADCALL |x| (QREFELT $ 53))) 

(SDEFUN |SQMATRIX;columnSpace;$L;18|
        ((|x| ($)) ($ (|List| (|DirectProduct| |ndim| R))))
        (SPROG ((#1=#:G746 NIL) (|c| NIL) (#2=#:G745 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |c| NIL) (LETT #1# (SPADCALL |x| (QREFELT $ 56)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |c| (QREFELT $ 28)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |SQMATRIX;rank;$Nni;19| ((|x| ($)) ($ (|NonNegativeInteger|)))
        (SPADCALL |x| (QREFELT $ 59))) 

(SDEFUN |SQMATRIX;nullity;$Nni;20| ((|x| ($)) ($ (|NonNegativeInteger|)))
        (SPADCALL |x| (QREFELT $ 61))) 

(SDEFUN |SQMATRIX;nullSpace;$L;21|
        ((|x| ($)) ($ (|List| (|DirectProduct| |ndim| R))))
        (SPROG ((#1=#:G753 NIL) (|c| NIL) (#2=#:G752 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |c| NIL) (LETT #1# (SPADCALL |x| (QREFELT $ 63)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |c| (QREFELT $ 28)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |SQMATRIX;recip;$U;22| ((|x| ($)) ($ (|Union| $ "failed")))
        (SPROG ((|u| (|Union| (|Matrix| R) "failed")))
               (SEQ (LETT |u| (SPADCALL |x| (QREFELT $ 66)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                           ('T (CONS 0 (QCDR |u|)))))))) 

(SDEFUN |SQMATRIX;inverse;$U;23| ((|x| ($)) ($ (|Union| $ "failed")))
        (SPROG ((|u| (|Union| (|Matrix| R) "failed")))
               (SEQ (LETT |u| (SPADCALL |x| (QREFELT $ 68)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                           ('T (CONS 0 (QCDR |u|)))))))) 

(SDEFUN |SQMATRIX;^;$I$;24| ((|x| ($)) (|n| (|Integer|)) ($ ($)))
        (SPADCALL |x| |n| (QREFELT $ 70))) 

(SDEFUN |SQMATRIX;recip;$U;25| ((|x| ($)) ($ (|Union| $ "failed")))
        (SPADCALL |x| (QREFELT $ 69))) 

(SDEFUN |SQMATRIX;convert;$If;26| ((|x| ($)) ($ (|InputForm|)))
        (SPADCALL
         (LIST (SPADCALL '|squareMatrix| (QREFELT $ 74))
               (SPADCALL (SPADCALL |x| (QREFELT $ 40)) (QREFELT $ 75)))
         (QREFELT $ 77))) 

(DECLAIM (NOTINLINE |SquareMatrix;|)) 

(DEFUN |SquareMatrix| (&REST #1=#:G802)
  (SPROG NIL
         (PROG (#2=#:G803)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(NIL T))
                                               (HGET |$ConstructorCache|
                                                     '|SquareMatrix|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |SquareMatrix;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|SquareMatrix|)))))))))) 

(DEFUN |SquareMatrix;| (|#1| |#2|)
  (SPROG
   ((|pv$| NIL) (#1=#:G799 NIL) (#2=#:G801 NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 |#1|)
    (LETT DV$2 (|devaluate| |#2|))
    (LETT |dv$| (LIST '|SquareMatrix| DV$1 DV$2))
    (LETT $ (GETREFV 100))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#2|
                                                       '(|CommutativeRing|))
                                        (|HasCategory| |#2| '(|AbelianGroup|))
                                        (|HasCategory| |#2| '(|SemiRing|))
                                        (|HasCategory| |#2| '(|Ring|))
                                        (|HasCategory| |#2|
                                                       '(|LinearlyExplicitOver|
                                                         (|Integer|)))
                                        (|HasCategory| |#2|
                                                       '(|PartialDifferentialRing|
                                                         (|Symbol|)))
                                        (LETT #2#
                                              (|HasCategory| |#2|
                                                             '(|DifferentialRing|)))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#2|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasCategory| |#2|
                                                        '(|CommutativeRing|))
                                         #2# (|HasCategory| |#2| '(|Ring|)))
                                        (|HasCategory| |#2| '(|Finite|))
                                        (|HasCategory| |#2|
                                                       '(|RetractableTo|
                                                         (|Fraction|
                                                          (|Integer|))))
                                        (|HasCategory| |#2|
                                                       '(|RetractableTo|
                                                         (|Integer|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|CommutativeStar|))
                                          (|HasCategory| |#2| '(|unitsKnown|)))
                                         (|HasCategory| |#2| '(|Ring|)))
                                        (|HasCategory| |#2|
                                                       '(|EuclideanDomain|))
                                        (|HasCategory| |#2|
                                                       '(|IntegralDomain|))
                                        (|HasCategory| |#2| '(|OrderedSet|))
                                        (|HasCategory| |#2| '(|BasicType|))
                                        (AND
                                         (|HasCategory| |#2|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#2|)))
                                         (|HasCategory| |#2| '(|SetCategory|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          (|HasCategory| |#2|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          (|HasCategory| |#2|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          (|HasCategory| |#2|
                                                         '(|CommutativeRing|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          #2#)
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          (|HasCategory| |#2| '(|Finite|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          (|HasCategory| |#2| '(|Ring|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          (|HasCategory| |#2| '(|SemiRing|)))
                                         (AND
                                          (|HasCategory| |#2|
                                                         (LIST '|Evalable|
                                                               (|devaluate|
                                                                |#2|)))
                                          (|HasCategory| |#2|
                                                         '(|SetCategory|))))
                                        (|HasCategory| |#2| '(|Field|))
                                        (AND
                                         (|HasCategory| |#2|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#2| '(|Ring|)))
                                        (AND #2#
                                             (|HasCategory| |#2| '(|Ring|)))
                                        (AND
                                         (|HasCategory| |#2|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasCategory| |#2| '(|Ring|)))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|RetractableTo|
                                                          (|Integer|)))
                                         (|HasCategory| |#2| '(|Ring|)))
                                        (LETT #1#
                                              (|HasCategory| |#2|
                                                             '(|ConvertibleTo|
                                                               (|InputForm|))))
                                        (OR #1#
                                            (AND
                                             (|HasCategory| |#2|
                                                            (LIST '|Evalable|
                                                                  (|devaluate|
                                                                   |#2|)))
                                             (|HasCategory| |#2| '(|Finite|)))
                                            (AND
                                             (|HasCategory| |#2|
                                                            '(|LinearlyExplicitOver|
                                                              (|Integer|)))
                                             (|HasCategory| |#2| '(|Finite|)))
                                            (AND
                                             (|HasCategory| |#2|
                                                            '(|PartialDifferentialRing|
                                                              (|Symbol|)))
                                             (|HasCategory| |#2| '(|Finite|)))
                                            (AND
                                             (|HasCategory| |#2|
                                                            '(|RetractableTo|
                                                              (|Fraction|
                                                               (|Integer|))))
                                             (|HasCategory| |#2| '(|Finite|)))
                                            (AND
                                             (|HasCategory| |#2|
                                                            '(|RetractableTo|
                                                              (|Integer|)))
                                             (|HasCategory| |#2| '(|Finite|)))
                                            (AND
                                             (|HasCategory| |#2|
                                                            '(|AbelianGroup|))
                                             (|HasCategory| |#2| '(|Finite|)))
                                            (AND
                                             (|HasCategory| |#2|
                                                            '(|CommutativeRing|))
                                             (|HasCategory| |#2| '(|Finite|)))
                                            (AND
                                             (|HasCategory| |#2|
                                                            '(|CommutativeStar|))
                                             (|HasCategory| |#2| '(|Finite|)))
                                            (AND #2#
                                                 (|HasCategory| |#2|
                                                                '(|Finite|)))
                                            (AND
                                             (|HasCategory| |#2| '(|Finite|))
                                             (|HasCategory| |#2| '(|Ring|)))
                                            (AND
                                             (|HasCategory| |#2| '(|Finite|))
                                             (|HasCategory| |#2|
                                                            '(|SemiRing|))))))))
    (|haddProp| |$ConstructorCache| '|SquareMatrix| (LIST DV$1 DV$2)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (AND (|HasCategory| $ '(|shallowlyMutable|))
         (|augmentPredVector| $ 33554432))
    (AND (|HasCategory| $ '(|finiteAggregate|))
         (|augmentPredVector| $ 67108864))
    (AND (|HasCategory| |#2| '(|OrderedSet|))
         (|HasCategory| $ '(|finiteAggregate|))
         (|augmentPredVector| $ 134217728))
    (AND (|HasCategory| |#2| '(|BasicType|))
         (|HasCategory| $ '(|finiteAggregate|))
         (|augmentPredVector| $ 268435456))
    (AND
     (OR (|HasCategory| |#2| '(|AbelianGroup|))
         (|HasCategory| $ '(|AbelianGroup|)))
     (|augmentPredVector| $ 536870912))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 10 (SPADCALL (|spadConstant| $ 8) (QREFELT $ 9)))
    (COND
     ((|HasCategory| |#2| '(|Monoid|))
      (PROGN
       (QSETREFV $ 13 (SPADCALL (|spadConstant| $ 12) (QREFELT $ 9)))
       (QSETREFV $ 14
                 (CONS #'|makeSpadConstant|
                       (LIST (|dispatchFunction| |SQMATRIX;One;$;2|) $ 14))))))
    (COND
     ((|testBitVector| |pv$| 4)
      (QSETREFV $ 17
                (CONS (|dispatchFunction| |SQMATRIX;characteristic;Nni;3|)
                      $))))
    (COND
     ((|testBitVector| |pv$| 1)
      (PROGN
       (QSETREFV $ 48
                 (CONS (|dispatchFunction| |SQMATRIX;determinant;$R;14|) $))
       (QSETREFV $ 50 (CONS (|dispatchFunction| |SQMATRIX;minordet;$R;15|) $))
       (QSETREFV $ 52
                 (CONS (|dispatchFunction| |SQMATRIX;Pfaffian;$R;16|) $)))))
    (COND
     ((|testBitVector| |pv$| 13)
      (PROGN
       (QSETREFV $ 54
                 (CONS (|dispatchFunction| |SQMATRIX;rowEchelon;2$;17|) $))
       (QSETREFV $ 58
                 (CONS (|dispatchFunction| |SQMATRIX;columnSpace;$L;18|) $)))))
    (COND
     ((|testBitVector| |pv$| 14)
      (PROGN
       (QSETREFV $ 60 (CONS (|dispatchFunction| |SQMATRIX;rank;$Nni;19|) $))
       (QSETREFV $ 62 (CONS (|dispatchFunction| |SQMATRIX;nullity;$Nni;20|) $))
       (QSETREFV $ 64 (CONS (|dispatchFunction| |SQMATRIX;nullSpace;$L;21|) $))
       (QSETREFV $ 67 (CONS (|dispatchFunction| |SQMATRIX;recip;$U;22|) $)))))
    (COND
     ((|testBitVector| |pv$| 19)
      (PROGN
       (QSETREFV $ 69 (CONS (|dispatchFunction| |SQMATRIX;inverse;$U;23|) $))
       (QSETREFV $ 71 (CONS (|dispatchFunction| |SQMATRIX;^;$I$;24|) $))
       (QSETREFV $ 67 (CONS (|dispatchFunction| |SQMATRIX;recip;$U;25|) $)))))
    (COND
     ((|testBitVector| |pv$| 24)
      (QSETREFV $ 78 (CONS (|dispatchFunction| |SQMATRIX;convert;$If;26|) $))))
    $))) 

(MAKEPROP '|SquareMatrix| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|Matrix| 7) (|local| |#1|) (|local| |#2|)
              (0 . |Zero|) |SQMATRIX;scalarMatrix;R$;8| 'ZERO
              (CONS IDENTITY
                    (FUNCALL (|dispatchFunction| |SQMATRIX;Zero;$;1|) $))
              (4 . |One|) 'ONE (8 . |One|) (|NonNegativeInteger|)
              (12 . |characteristic|) (16 . |characteristic|) (|Boolean|)
              (20 . ~=) (|Integer|) (26 . |maxRowIndex|) (31 . |maxColIndex|)
              (|List| 36) |SQMATRIX;matrix;L$;4| (|Vector| 7) (36 . |row|)
              (|DirectProduct| (NRTEVAL (QREFELT $ 6)) 7)
              (42 . |directProduct|) |SQMATRIX;row;$IDp;5| (47 . |column|)
              |SQMATRIX;column;$IDp;6| (|OutputForm|) (53 . |coerce|)
              |SQMATRIX;coerce;$Of;7| (58 . |scalarMatrix|) (|List| 7)
              (64 . |diagonalMatrix|) |SQMATRIX;diagonalMatrix;L$;9|
              (69 . |copy|) |SQMATRIX;coerce;$M;10|
              |SQMATRIX;squareMatrix;M$;11| (74 . |coerce|) (79 . *)
              |SQMATRIX;*;$2Dp;12| (85 . *) |SQMATRIX;*;Dp$Dp;13|
              (91 . |determinant|) (96 . |determinant|) (101 . |minordet|)
              (106 . |minordet|) (111 . |Pfaffian|) (116 . |Pfaffian|)
              (121 . |rowEchelon|) (126 . |rowEchelon|) (|List| 25)
              (131 . |columnSpace|) (|List| 27) (136 . |columnSpace|)
              (141 . |rank|) (146 . |rank|) (151 . |nullity|) (156 . |nullity|)
              (161 . |nullSpace|) (166 . |nullSpace|) (|Union| $ '"failed")
              (171 . |invertIfCan|) (176 . |recip|) (181 . |inverse|)
              (186 . |inverse|) (191 . ^) (197 . ^) (|Symbol|) (|InputForm|)
              (203 . |convert|) (208 . |convert|) (|List| $) (213 . |convert|)
              (218 . |convert|) (|List| 80) (|Equation| 7)
              (|Record| (|:| |mat| 84) (|:| |vec| (|Vector| 20))) (|Matrix| $)
              (|Vector| $) (|Matrix| 20) (|List| 72) (|List| 15)
              (|Mapping| 18 7 7) (|Mapping| 18 7) (|Mapping| 7 7)
              (|PositiveInteger|) (|Fraction| 20) (|Union| 91 '#1="failed")
              (|Union| 20 '#1#) (|Record| (|:| |mat| 5) (|:| |vec| 25))
              (|Union| 7 '#1#) (|Mapping| 7 7 7) (|String|) (|SingleInteger|)
              (|HashState|))
           '#(~= 223 |zero?| 229 |transpose| 234 |trace| 239 |symmetric?| 244
              |subtractIfCan| 249 |squareMatrix| 255 |square?| 260 |smaller?|
              265 |size?| 271 |size| 277 |scalarMatrix| 281 |sample| 286
              |rowEchelon| 290 |row| 295 |rightRecip| 301 |rightPower| 306
              |retractIfCan| 318 |retract| 333 |reducedSystem| 348 |recip| 370
              |rank| 375 |random| 380 |qelt| 384 |parts| 391 |opposite?| 396
              |one?| 402 |nullity| 407 |nullSpace| 412 |nrows| 417 |ncols| 422
              |more?| 427 |minordet| 433 |minRowIndex| 438 |minColIndex| 443
              |min| 448 |members| 453 |member?| 458 |maxRowIndex| 464
              |maxColIndex| 469 |max| 474 |matrix| 485 |map!| 490 |map| 496
              |lookup| 509 |listOfLists| 514 |less?| 519 |leftRecip| 525
              |leftPower| 530 |latex| 542 |inverse| 547 |index| 552
              |hashUpdate!| 557 |hash| 563 |exquo| 568 |every?| 574 |eval| 580
              |eq?| 606 |enumerate| 612 |empty?| 616 |empty| 621 |elt| 625
              |differentiate| 640 |diagonalProduct| 690 |diagonalMatrix| 695
              |diagonal?| 700 |diagonal| 705 |determinant| 710 |count| 715
              |copy| 727 |convert| 732 |commutator| 737 |columnSpace| 743
              |column| 748 |coerce| 754 |characteristic| 779 |associator| 783
              |any?| 790 |antisymmetric?| 796 |antiCommutator| 801
              |annihilate?| 807 ^ 813 |Zero| 831 |Pfaffian| 835 |One| 840 D 844
              = 894 / 900 - 906 + 917 * 923 |#| 971)
           'NIL
           (CONS
            (|makeByteWordVec2| 25
                                '(0 4 4 1 4 5 6 7 8 0 3 8 0 1 0 0 4 0 0 0 0 8 2
                                  2 3 3 0 0 0 3 9 0 0 0 0 9 0 0 0 18 10 11 0 0
                                  0 0 0 0 0 18 10 11 25 12))
            (CONS
             '#(|SquareMatrixCategory&| |FullyLinearlyExplicitOver&|
                |DifferentialExtension&| |Algebra&| NIL NIL
                |PartialDifferentialRing&| |DifferentialRing&| NIL
                |RectangularMatrixCategory&| NIL |Rng&| NIL |Module&| NIL NIL
                |NonAssociativeRing&| NIL NIL NIL NIL |NonAssociativeRng&|
                |AbelianGroup&| NIL NIL NIL |NonAssociativeSemiRng&|
                |AbelianMonoid&| NIL |MagmaWithUnit&| |Finite&|
                |FullyRetractableTo&| |HomogeneousAggregate&| |Magma&|
                |AbelianSemiGroup&| NIL |RetractableTo&| |Aggregate&|
                |SetCategory&| |Evalable&| |RetractableTo&| |RetractableTo&|
                NIL NIL NIL NIL NIL |BasicType&| NIL |InnerEvalable&| NIL NIL
                NIL NIL)
             (CONS
              '#((|SquareMatrixCategory| 6 7 (|DirectProduct| 6 7)
                                         (|DirectProduct| 6 7))
                 (|FullyLinearlyExplicitOver| 7) (|DifferentialExtension| 7)
                 (|Algebra| 7) (|LinearlyExplicitOver| 7)
                 (|LinearlyExplicitOver| 20) (|PartialDifferentialRing| 72)
                 (|DifferentialRing|) (|Ring|)
                 (|RectangularMatrixCategory| 6 6 7 (|DirectProduct| 6 7)
                                              (|DirectProduct| 6 7))
                 (|SemiRing|) (|Rng|) (|SemiRng|) (|Module| 7) (|BiModule| 7 7)
                 (|BiModule| $$ $$) (|NonAssociativeRing|) (|LeftModule| 7)
                 (|RightModule| 7) (|RightModule| $$) (|LeftModule| $$)
                 (|NonAssociativeRng|) (|AbelianGroup|)
                 (|CancellationAbelianMonoid|) (|NonAssociativeSemiRing|)
                 (|Monoid|) (|NonAssociativeSemiRng|) (|AbelianMonoid|)
                 (|SemiGroup|) (|MagmaWithUnit|) (|Finite|)
                 (|FullyRetractableTo| 7) (|HomogeneousAggregate| 7) (|Magma|)
                 (|AbelianSemiGroup|) (|Comparable|) (|RetractableTo| 7)
                 (|Aggregate|) (|SetCategory|) (|Evalable| 7)
                 (|RetractableTo| 91) (|RetractableTo| 20)
                 (|CoercibleTo| (|Matrix| 7)) (|CoercibleFrom| 7)
                 (|finiteAggregate|) (|Type|) (|TwoSidedRecip|) (|BasicType|)
                 (|CoercibleTo| 32) (|InnerEvalable| 7 7) (|CoercibleFrom| 91)
                 (|CoercibleFrom| 20) (|ConvertibleTo| 73) (|unitsKnown|))
              (|makeByteWordVec2| 99
                                  '(0 7 0 8 0 7 0 12 0 0 0 14 0 7 15 16 0 0 15
                                    17 2 15 18 0 0 19 1 5 20 0 21 1 5 20 0 22 2
                                    5 25 0 20 26 1 27 0 25 28 2 5 25 0 20 30 1
                                    5 32 0 33 2 5 0 15 7 35 1 5 0 36 37 1 5 0 0
                                    39 1 27 25 0 42 2 5 25 0 25 43 2 5 25 25 0
                                    45 1 5 7 0 47 1 0 7 0 48 1 5 7 0 49 1 0 7 0
                                    50 1 5 7 0 51 1 0 7 0 52 1 5 0 0 53 1 0 0 0
                                    54 1 5 55 0 56 1 0 57 0 58 1 5 15 0 59 1 0
                                    15 0 60 1 5 15 0 61 1 0 15 0 62 1 5 55 0 63
                                    1 0 57 0 64 1 5 65 0 66 1 0 65 0 67 1 5 65
                                    0 68 1 0 65 0 69 2 5 0 0 20 70 2 0 0 0 20
                                    71 1 73 0 72 74 1 5 73 0 75 1 73 0 76 77 1
                                    0 73 0 78 2 0 18 0 0 1 1 0 18 0 1 1 0 0 0 1
                                    1 0 7 0 1 1 0 18 0 1 2 30 65 0 0 1 1 0 0 5
                                    41 1 0 18 0 1 2 9 18 0 0 1 2 0 18 0 15 1 0
                                    9 15 1 1 0 0 7 9 0 0 0 1 1 13 0 0 54 2 0 27
                                    0 20 29 1 3 65 0 1 2 3 0 0 15 1 2 0 0 0 90
                                    1 1 10 92 0 1 1 11 93 0 1 1 0 95 0 1 1 10
                                    91 0 1 1 11 20 0 1 1 0 7 0 1 2 20 81 82 83
                                    1 1 20 84 82 1 1 4 5 82 1 2 4 94 82 83 1 1
                                    3 65 0 67 1 14 15 0 60 0 9 0 1 3 0 7 0 20
                                    20 1 1 27 36 0 1 2 0 18 0 0 1 1 3 18 0 1 1
                                    14 15 0 62 1 14 57 0 64 1 0 15 0 1 1 0 15 0
                                    1 2 0 18 0 15 1 1 1 7 0 50 1 0 20 0 1 1 0
                                    20 0 1 1 28 7 0 1 1 27 36 0 1 2 29 18 7 0 1
                                    1 0 20 0 1 1 0 20 0 1 1 28 7 0 1 2 27 7 87
                                    0 1 1 0 0 23 24 2 26 0 89 0 1 2 0 0 89 0 1
                                    3 0 0 96 0 0 1 1 9 90 0 1 1 0 23 0 1 2 0 18
                                    0 15 1 1 3 65 0 1 2 3 0 0 15 1 2 0 0 0 90 1
                                    1 0 97 0 1 1 19 65 0 69 1 9 0 90 1 2 0 99
                                    99 0 1 1 0 98 0 1 2 14 65 0 7 1 2 27 18 88
                                    0 1 3 17 0 0 7 7 1 3 17 0 0 36 36 1 2 17 0
                                    0 79 1 2 17 0 0 80 1 2 0 18 0 0 1 0 9 76 1
                                    1 0 18 0 1 0 0 0 1 3 0 7 0 20 20 1 4 0 7 0
                                    20 20 7 1 2 21 0 0 15 1 1 21 0 0 1 3 22 0 0
                                    72 15 1 3 22 0 0 85 86 1 2 22 0 0 72 1 2 22
                                    0 0 85 1 3 4 0 0 89 15 1 2 4 0 0 89 1 1 0 7
                                    0 1 1 0 0 36 38 1 0 18 0 1 1 0 27 0 1 1 1 7
                                    0 48 2 29 15 7 0 1 2 27 15 88 0 1 1 0 0 0 1
                                    1 24 73 0 78 2 4 0 0 0 1 1 13 57 0 58 2 0
                                    27 0 20 31 1 23 0 20 1 1 10 0 91 1 1 0 5 0
                                    40 1 0 0 7 1 1 0 32 0 34 0 4 15 17 3 4 0 0
                                    0 0 1 2 27 18 88 0 1 1 0 18 0 1 2 0 0 0 0 1
                                    2 4 18 0 0 1 2 19 0 0 20 71 2 3 0 0 15 1 2
                                    0 0 0 90 1 0 0 0 11 1 1 7 0 52 0 3 0 14 2
                                    21 0 0 15 1 1 21 0 0 1 3 22 0 0 72 15 1 3
                                    22 0 0 85 86 1 2 22 0 0 72 1 2 22 0 0 85 1
                                    3 4 0 0 89 15 1 2 4 0 0 89 1 2 0 18 0 0 1 2
                                    19 0 0 7 1 1 30 0 0 1 2 30 0 0 0 1 2 0 0 0
                                    0 1 2 30 0 20 0 1 2 0 27 0 27 44 2 0 27 27
                                    0 46 2 0 0 7 0 1 2 0 0 0 7 1 2 0 0 15 0 1 2
                                    0 0 0 0 1 2 0 0 90 0 1 1 27 15 0 1)))))
           '|lookupComplete|)) 
