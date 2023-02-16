
(SDEFUN |MAMA;element;M2IM;1|
        ((A (M)) (|r| (|Integer|)) (|c| (|Integer|)) ($ (M)))
        (SPADCALL A |r| |r| |c| |c| (QREFELT $ 11))) 

(SDEFUN |MAMA;rowMatrix;MIM;2| ((A (M)) (|r| (|Integer|)) ($ (M)))
        (SPADCALL A |r| |r| (SPADCALL A (QREFELT $ 13))
                  (SPADCALL A (QREFELT $ 14)) (QREFELT $ 11))) 

(SDEFUN |MAMA;rows;MLM;3| ((A (M)) (|lst| (|List| (|Integer|))) ($ (M)))
        (SPROG ((|ls| (|List| (|Integer|))) (|nc| (|NonNegativeInteger|)))
               (SEQ (LETT |nc| (SPADCALL A (QREFELT $ 17)))
                    (EXIT
                     (COND
                      ((EQL |nc| 0)
                       (SPADCALL (LENGTH |lst|) |nc| (QREFELT $ 18)))
                      ('T
                       (SEQ
                        (LETT |ls|
                              (SPADCALL
                               (SPADCALL (SPADCALL A (QREFELT $ 13))
                                         (SPADCALL A (QREFELT $ 14))
                                         (QREFELT $ 20))
                               (QREFELT $ 22)))
                        (EXIT (SPADCALL A |lst| |ls| (QREFELT $ 23)))))))))) 

(SDEFUN |MAMA;rows;MSM;4| ((A (M)) (|si| (|Segment| (|Integer|))) ($ (M)))
        (SPADCALL A (SPADCALL |si| (QREFELT $ 22)) (QREFELT $ 24))) 

(SDEFUN |MAMA;columnMatrix;MIM;5| ((A (M)) (|c| (|Integer|)) ($ (M)))
        (SPADCALL A (SPADCALL A (QREFELT $ 26)) (SPADCALL A (QREFELT $ 27)) |c|
                  |c| (QREFELT $ 11))) 

(SDEFUN |MAMA;columns;MLM;6| ((A (M)) (|lst| (|List| (|Integer|))) ($ (M)))
        (SPROG ((|ls| (|List| (|Integer|))) (|nr| (|NonNegativeInteger|)))
               (SEQ (LETT |nr| (SPADCALL A (QREFELT $ 29)))
                    (EXIT
                     (COND
                      ((EQL |nr| 0)
                       (SPADCALL |nr| (LENGTH |lst|) (QREFELT $ 18)))
                      ('T
                       (SEQ
                        (LETT |ls|
                              (SPADCALL
                               (SPADCALL (SPADCALL A (QREFELT $ 26))
                                         (SPADCALL A (QREFELT $ 27))
                                         (QREFELT $ 20))
                               (QREFELT $ 22)))
                        (EXIT (SPADCALL A |ls| |lst| (QREFELT $ 23)))))))))) 

(SDEFUN |MAMA;columns;MSM;7| ((A (M)) (|si| (|Segment| (|Integer|))) ($ (M)))
        (SPADCALL A (SPADCALL |si| (QREFELT $ 22)) (QREFELT $ 30))) 

(SDEFUN |MAMA;fill_diagonal|
        ((B (M)) (A (M)) (|nr| (|NonNegativeInteger|))
         (|nc| (|NonNegativeInteger|)) (|n| (|Integer|)) ($ (|Void|)))
        (SPROG
         ((#1=#:G720 NIL) (|i| NIL) (|sc| (|Integer|)) (|sr| (|Integer|))
          (|dl| (|Integer|)))
         (SEQ
          (COND
           ((> |n| (- |nc| 1)) (|error| "requested diagonal out of range"))
           (#2='T
            (SEQ
             (COND
              ((< |n| 0)
               (COND
                ((> (ABS |n|) (- |nr| 1))
                 (EXIT (|error| "requested diagonal out of range"))))))
             (COND
              ((>= |n| 0)
               (SEQ (LETT |dl| (MIN (- |nc| |n|) |nr|))
                    (LETT |sr| (SPADCALL A (QREFELT $ 26)))
                    (EXIT (LETT |sc| (+ (SPADCALL A (QREFELT $ 13)) |n|)))))
              (#2#
               (SEQ (LETT |dl| (MIN |nc| (- |nr| (ABS |n|))))
                    (LETT |sr| (+ (SPADCALL A (QREFELT $ 26)) (ABS |n|)))
                    (EXIT (LETT |sc| (SPADCALL A (QREFELT $ 13)))))))
             (EXIT
              (SEQ (LETT |i| 0) (LETT #1# (- |dl| 1)) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL B (+ |sr| |i|) (+ |sc| |i|)
                               (SPADCALL A (+ |sr| |i|) (+ |sc| |i|)
                                         (QREFELT $ 32))
                               (QREFELT $ 33))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))))))))) 

(SDEFUN |MAMA;diagonalMatrix;MIM;9| ((A (M)) (|n| (|Integer|)) ($ (M)))
        (SPROG
         ((B (M)) (|nc| (|NonNegativeInteger|)) (|nr| (|NonNegativeInteger|)))
         (SEQ (LETT |nr| (SPADCALL A (QREFELT $ 29)))
              (LETT |nc| (SPADCALL A (QREFELT $ 17)))
              (LETT B
                    (SPADCALL |nr| |nc| (|spadConstant| $ 34) (QREFELT $ 35)))
              (|MAMA;fill_diagonal| B A |nr| |nc| |n| $) (EXIT B)))) 

(SDEFUN |MAMA;diagonalMatrix;2M;10| ((A (M)) ($ (M)))
        (SPADCALL A 0 (QREFELT $ 36))) 

(SDEFUN |MAMA;bandMatrix;MLM;11| ((A (M)) (|ln| (|List| (|Integer|))) ($ (M)))
        (SPROG
         ((#1=#:G728 NIL) (|n| NIL) (B (M)) (|nc| (|NonNegativeInteger|))
          (|nr| (|NonNegativeInteger|)))
         (SEQ (LETT |nr| (SPADCALL A (QREFELT $ 29)))
              (LETT |nc| (SPADCALL A (QREFELT $ 17)))
              (LETT B
                    (SPADCALL |nr| |nc| (|spadConstant| $ 34) (QREFELT $ 35)))
              (SEQ (LETT |n| NIL) (LETT #1# |ln|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |n| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (EXIT (|MAMA;fill_diagonal| B A |nr| |nc| |n| $)))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT B)))) 

(SDEFUN |MAMA;bandMatrix;MSM;12|
        ((A (M)) (|si| (|Segment| (|Integer|))) ($ (M)))
        (SPADCALL A (SPADCALL |si| (QREFELT $ 22)) (QREFELT $ 38))) 

(SDEFUN |MAMA;subMatrix;M2LM;13|
        ((A (M)) (|lr| (|List| (|Integer|))) (|lc| (|List| (|Integer|)))
         ($ (M)))
        (SPROG
         ((#1=#:G738 NIL) (|j| NIL) (#2=#:G739 NIL) (|jj| NIL) (#3=#:G736 NIL)
          (|i| NIL) (#4=#:G737 NIL) (|ii| NIL) (|res| (M)) (|minC| (|Integer|))
          (|minR| (|Integer|)) (|m| #5=(|NonNegativeInteger|)) (|n| #5#))
         (SEQ (LETT |n| (LENGTH |lr|)) (LETT |m| (LENGTH |lc|))
              (LETT |minR| (SPADCALL A (QREFELT $ 26)))
              (LETT |minC| (SPADCALL A (QREFELT $ 13)))
              (LETT |res| (SPADCALL |n| |m| (QREFELT $ 18)))
              (SEQ (LETT |ii| NIL) (LETT #4# |lr|) (LETT |i| 1) (LETT #3# |n|)
                   G190
                   (COND
                    ((OR (|greater_SI| |i| #3#) (ATOM #4#)
                         (PROGN (LETT |ii| (CAR #4#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |jj| NIL) (LETT #2# |lc|) (LETT |j| 1)
                          (LETT #1# |m|) G190
                          (COND
                           ((OR (|greater_SI| |j| #1#) (ATOM #2#)
                                (PROGN (LETT |jj| (CAR #2#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (SPADCALL |res| (+ (- |minR| 1) |i|)
                                      (+ (- |minC| 1) |j|)
                                      (SPADCALL A |ii| |jj| (QREFELT $ 40))
                                      (QREFELT $ 33))))
                          (LETT |j|
                                (PROG1 (|inc_SI| |j|) (LETT #2# (CDR #2#))))
                          (GO G190) G191 (EXIT NIL))))
                   (LETT |i| (PROG1 (|inc_SI| |i|) (LETT #4# (CDR #4#))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |MAMA;subMatrix;M2SM;14|
        ((A (M)) (|sr| (|Segment| (|Integer|))) (|sc| (|Segment| (|Integer|)))
         ($ (M)))
        (SPADCALL A (SPADCALL |sr| (QREFELT $ 41))
                  (SPADCALL |sr| (QREFELT $ 42)) (SPADCALL |sc| (QREFELT $ 41))
                  (SPADCALL |sc| (QREFELT $ 42)) (QREFELT $ 11))) 

(SDEFUN |MAMA;blockSplit;MLPiL;15|
        ((A (M)) (|lr| (|List| (|NonNegativeInteger|)))
         (|nc| (|PositiveInteger|)) ($ (|List| (|List| M))))
        (SPROG ((#1=#:G746 NIL) (X NIL) (#2=#:G745 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT X NIL) (LETT #1# (SPADCALL A |lr| (QREFELT $ 46)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT X (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL X |nc| (QREFELT $ 48)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |MAMA;blockSplit;MPiLL;16|
        ((A (M)) (|nr| (|PositiveInteger|))
         (|lc| (|List| (|NonNegativeInteger|))) ($ (|List| (|List| M))))
        (SPROG ((#1=#:G751 NIL) (X NIL) (#2=#:G750 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT X NIL) (LETT #1# (SPADCALL A |nr| (QREFELT $ 51)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT X (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL X |lc| (QREFELT $ 52)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(DECLAIM (NOTINLINE |MatrixManipulation;|)) 

(DEFUN |MatrixManipulation| (&REST #1=#:G752)
  (SPROG NIL
         (PROG (#2=#:G753)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|MatrixManipulation|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |MatrixManipulation;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|MatrixManipulation|)))))))))) 

(DEFUN |MatrixManipulation;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|MatrixManipulation| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 54))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1|
                                                       '(|AbelianMonoid|))))))
    (|haddProp| |$ConstructorCache| '|MatrixManipulation|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|testBitVector| |pv$| 1)
      (PROGN
       (QSETREFV $ 36
                 (CONS (|dispatchFunction| |MAMA;diagonalMatrix;MIM;9|) $))
       (QSETREFV $ 37
                 (CONS (|dispatchFunction| |MAMA;diagonalMatrix;2M;10|) $))
       (QSETREFV $ 38 (CONS (|dispatchFunction| |MAMA;bandMatrix;MLM;11|) $))
       (QSETREFV $ 39
                 (CONS (|dispatchFunction| |MAMA;bandMatrix;MSM;12|) $)))))
    $))) 

(MAKEPROP '|MatrixManipulation| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|Integer|) (0 . |subMatrix|)
              |MAMA;element;M2IM;1| (9 . |minColIndex|) (14 . |maxColIndex|)
              |MAMA;rowMatrix;MIM;2| (|NonNegativeInteger|) (19 . |ncols|)
              (24 . |qnew|) (|Segment| 10) (30 . SEGMENT) (|List| 10)
              (36 . |expand|) |MAMA;subMatrix;M2LM;13| |MAMA;rows;MLM;3|
              |MAMA;rows;MSM;4| (41 . |minRowIndex|) (46 . |maxRowIndex|)
              |MAMA;columnMatrix;MIM;5| (51 . |nrows|) |MAMA;columns;MLM;6|
              |MAMA;columns;MSM;7| (56 . |elt|) (63 . |qsetelt!|) (71 . |Zero|)
              (75 . |new|) (82 . |diagonalMatrix|) (88 . |diagonalMatrix|)
              (93 . |bandMatrix|) (99 . |bandMatrix|) (105 . |qelt|)
              (112 . |low|) (117 . |high|) |MAMA;subMatrix;M2SM;14| (|List| $)
              (|List| 16) (122 . |vertSplit|) (|PositiveInteger|)
              (128 . |horizSplit|) (|List| (|List| 9))
              |MAMA;blockSplit;MLPiL;15| (134 . |vertSplit|)
              (140 . |horizSplit|) |MAMA;blockSplit;MPiLL;16|)
           '#(|subMatrix| 146 |rows| 160 |rowMatrix| 172 |element| 178
              |diagonalMatrix| 185 |columns| 196 |columnMatrix| 208
              |blockSplit| 214 |bandMatrix| 228)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|element| (|#4| |#4| (|Integer|) (|Integer|)))
                                T)
                              '((|rowMatrix| (|#4| |#4| (|Integer|))) T)
                              '((|rows| (|#4| |#4| (|List| (|Integer|)))) T)
                              '((|rows| (|#4| |#4| (|Segment| (|Integer|)))) T)
                              '((|columnMatrix| (|#4| |#4| (|Integer|))) T)
                              '((|columns| (|#4| |#4| (|List| (|Integer|)))) T)
                              '((|columns| (|#4| |#4| (|Segment| (|Integer|))))
                                T)
                              '((|subMatrix|
                                 (|#4| |#4| (|List| (|Integer|))
                                  (|List| (|Integer|))))
                                T)
                              '((|subMatrix|
                                 (|#4| |#4| (|Segment| (|Integer|))
                                  (|Segment| (|Integer|))))
                                T)
                              '((|diagonalMatrix| (|#4| |#4| (|Integer|)))
                                (|has| 6 (|AbelianMonoid|)))
                              '((|diagonalMatrix| (|#4| |#4|))
                                (|has| 6 (|AbelianMonoid|)))
                              '((|bandMatrix| (|#4| |#4| (|List| (|Integer|))))
                                (|has| 6 (|AbelianMonoid|)))
                              '((|bandMatrix|
                                 (|#4| |#4| (|Segment| (|Integer|))))
                                (|has| 6 (|AbelianMonoid|)))
                              '((|blockSplit|
                                 ((|List| (|List| |#4|)) |#4|
                                  (|List| (|NonNegativeInteger|))
                                  (|PositiveInteger|)))
                                T)
                              '((|blockSplit|
                                 ((|List| (|List| |#4|)) |#4|
                                  (|PositiveInteger|)
                                  (|List| (|NonNegativeInteger|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 53
                                            '(5 9 0 0 10 10 10 10 11 1 9 10 0
                                              13 1 9 10 0 14 1 9 16 0 17 2 9 0
                                              16 16 18 2 19 0 10 10 20 1 19 21
                                              0 22 1 9 10 0 26 1 9 10 0 27 1 9
                                              16 0 29 3 9 6 0 10 10 32 4 9 6 0
                                              10 10 6 33 0 6 0 34 3 9 0 16 16 6
                                              35 2 0 9 9 10 36 1 0 9 9 37 2 0 9
                                              9 21 38 2 0 9 9 19 39 3 9 6 0 10
                                              10 40 1 19 10 0 41 1 19 10 0 42 2
                                              9 44 0 45 46 2 9 44 0 47 48 2 9
                                              44 0 47 51 2 9 44 0 45 52 3 0 9 9
                                              19 19 43 3 0 9 9 21 21 23 2 0 9 9
                                              21 24 2 0 9 9 19 25 2 0 9 9 10 15
                                              3 0 9 9 10 10 12 1 1 9 9 37 2 1 9
                                              9 10 36 2 0 9 9 19 31 2 0 9 9 21
                                              30 2 0 9 9 10 28 3 0 49 9 47 45
                                              53 3 0 49 9 45 47 50 2 1 9 9 19
                                              39 2 1 9 9 21 38)))))
           '|lookupComplete|)) 
