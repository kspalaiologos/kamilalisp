
(SDEFUN |RMCAT2;map;MM1M2;1| ((|f| (|Mapping| R2 R1)) (|mat| (M1)) ($ (M2)))
        (SPROG
         ((#1=#:G705 NIL) (|j| NIL) (#2=#:G706 NIL) (|l| NIL) (#3=#:G703 NIL)
          (|i| NIL) (#4=#:G704 NIL) (|k| NIL) (|ans| (M2)))
         (SEQ
          (LETT |ans|
                (MAKE_MATRIX1 (QREFELT $ 6) (QREFELT $ 7)
                              (|spadConstant| $ 16)))
          (SEQ (LETT |k| (SPADCALL |ans| (QREFELT $ 20)))
               (LETT #4# (SPADCALL |ans| (QREFELT $ 21)))
               (LETT |i| (SPADCALL |mat| (QREFELT $ 18)))
               (LETT #3# (SPADCALL |mat| (QREFELT $ 19))) G190
               (COND ((OR (> |i| #3#) (> |k| #4#)) (GO G191)))
               (SEQ
                (EXIT
                 (SEQ (LETT |l| (SPADCALL |ans| (QREFELT $ 24)))
                      (LETT #2# (SPADCALL |ans| (QREFELT $ 25)))
                      (LETT |j| (SPADCALL |mat| (QREFELT $ 22)))
                      (LETT #1# (SPADCALL |mat| (QREFELT $ 23))) G190
                      (COND ((OR (> |j| #1#) (> |l| #2#)) (GO G191)))
                      (SEQ
                       (EXIT
                        (QSETAREF2O |ans| |k| |l|
                                    (SPADCALL
                                     (SPADCALL |mat| |i| |j| (QREFELT $ 26))
                                     |f|)
                                    1 1)))
                      (LETT |j| (PROG1 (+ |j| 1) (LETT |l| (+ |l| 1))))
                      (GO G190) G191 (EXIT NIL))))
               (LETT |i| (PROG1 (+ |i| 1) (LETT |k| (+ |k| 1)))) (GO G190) G191
               (EXIT NIL))
          (EXIT |ans|)))) 

(SDEFUN |RMCAT2;reduce;MM12R2;2|
        ((|f| (|Mapping| R2 R1 R2)) (|mat| (M1)) (|ident| (R2)) ($ (R2)))
        (SPROG ((|s| (R2)) (#1=#:G715 NIL) (|j| NIL) (#2=#:G714 NIL) (|i| NIL))
               (SEQ (LETT |s| |ident|)
                    (SEQ (LETT |i| (SPADCALL |mat| (QREFELT $ 18)))
                         (LETT #2# (SPADCALL |mat| (QREFELT $ 19))) G190
                         (COND ((> |i| #2#) (GO G191)))
                         (SEQ
                          (EXIT
                           (SEQ (LETT |j| (SPADCALL |mat| (QREFELT $ 22)))
                                (LETT #1# (SPADCALL |mat| (QREFELT $ 23))) G190
                                (COND ((> |j| #1#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT |s|
                                        (SPADCALL
                                         (SPADCALL |mat| |i| |j|
                                                   (QREFELT $ 26))
                                         |s| |f|))))
                                (LETT |j| (+ |j| 1)) (GO G190) G191
                                (EXIT NIL))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                    (EXIT |s|)))) 

(DECLAIM (NOTINLINE |RectangularMatrixCategoryFunctions2;|)) 

(DEFUN |RectangularMatrixCategoryFunctions2| (&REST #1=#:G716)
  (SPROG NIL
         (PROG (#2=#:G717)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(NIL NIL T T T T T T T T))
                     (HGET |$ConstructorCache|
                           '|RectangularMatrixCategoryFunctions2|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |RectangularMatrixCategoryFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|RectangularMatrixCategoryFunctions2|)))))))))) 

(DEFUN |RectangularMatrixCategoryFunctions2;|
       (|#1| |#2| |#3| |#4| |#5| |#6| |#7| |#8| |#9| |#10|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$10 NIL) (DV$9 NIL) (DV$8 NIL)
    (DV$7 NIL) (DV$6 NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 |#1|)
    (LETT DV$2 |#2|)
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT DV$6 (|devaluate| |#6|))
    (LETT DV$7 (|devaluate| |#7|))
    (LETT DV$8 (|devaluate| |#8|))
    (LETT DV$9 (|devaluate| |#9|))
    (LETT DV$10 (|devaluate| |#10|))
    (LETT |dv$|
          (LIST '|RectangularMatrixCategoryFunctions2| DV$1 DV$2 DV$3 DV$4 DV$5
                DV$6 DV$7 DV$8 DV$9 DV$10))
    (LETT $ (GETREFV 31))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|RectangularMatrixCategoryFunctions2|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5 DV$6 DV$7 DV$8 DV$9 DV$10)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (QSETREFV $ 11 |#6|)
    (QSETREFV $ 12 |#7|)
    (QSETREFV $ 13 |#8|)
    (QSETREFV $ 14 |#9|)
    (QSETREFV $ 15 |#10|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|RectangularMatrixCategoryFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (|local| |#6|)
              (|local| |#7|) (|local| |#8|) (|local| |#9|) (|local| |#10|)
              (0 . |Zero|) (|Integer|) (4 . |minRowIndex|) (9 . |maxRowIndex|)
              (14 . |minRowIndex|) (19 . |maxRowIndex|) (24 . |minColIndex|)
              (29 . |maxColIndex|) (34 . |minColIndex|) (39 . |maxColIndex|)
              (44 . |qelt|) (|Mapping| 12 8) |RMCAT2;map;MM1M2;1|
              (|Mapping| 12 8 12) |RMCAT2;reduce;MM12R2;2|)
           '#(|reduce| 51 |map| 58) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map| (|#10| (|Mapping| |#7| |#3|) |#6|)) T)
                              '((|reduce|
                                 (|#7| (|Mapping| |#7| |#3| |#7|) |#6| |#7|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 30
                                            '(0 12 0 16 1 11 17 0 18 1 11 17 0
                                              19 1 15 17 0 20 1 15 17 0 21 1 11
                                              17 0 22 1 11 17 0 23 1 15 17 0 24
                                              1 15 17 0 25 3 11 8 0 17 17 26 3
                                              0 12 29 11 12 30 2 0 15 27 11
                                              28)))))
           '|lookupComplete|)) 
