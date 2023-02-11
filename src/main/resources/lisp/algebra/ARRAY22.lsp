
(SDEFUN |ARRAY22;map;MMAMB;1| ((|f| (|Mapping| B A)) (|m| (MA)) ($ (MB)))
        (SPROG
         ((#1=#:G703 NIL) (|k| NIL) (#2=#:G702 NIL) (|i| NIL) (|res| (MB))
          (|nc| (|NonNegativeInteger|)) (|nr| (|NonNegativeInteger|)))
         (SEQ (LETT |nr| (SPADCALL |m| (QREFELT $ 15)))
              (LETT |nc| (SPADCALL |m| (QREFELT $ 16)))
              (LETT |res| (SPADCALL |nr| |nc| (QREFELT $ 17)))
              (SEQ (LETT |i| (SPADCALL |m| (QREFELT $ 19)))
                   (LETT #2# (SPADCALL |m| (QREFELT $ 20))) G190
                   (COND ((> |i| #2#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |k| (SPADCALL |m| (QREFELT $ 21)))
                          (LETT #1# (SPADCALL |m| (QREFELT $ 22))) G190
                          (COND ((> |k| #1#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SPADCALL |res| |i| |k|
                                      (SPADCALL
                                       (SPADCALL |m| |i| |k| (QREFELT $ 23))
                                       |f|)
                                      (QREFELT $ 24))))
                          (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))))
                   (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(DECLAIM (NOTINLINE |TwoDimensionalArrayFunctions;|)) 

(DEFUN |TwoDimensionalArrayFunctions| (&REST #1=#:G704)
  (SPROG NIL
         (PROG (#2=#:G705)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|TwoDimensionalArrayFunctions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |TwoDimensionalArrayFunctions;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|TwoDimensionalArrayFunctions|)))))))))) 

(DEFUN |TwoDimensionalArrayFunctions;|
       (|#1| |#2| |#3| |#4| |#5| |#6| |#7| |#8|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$8 NIL) (DV$7 NIL) (DV$6 NIL) (DV$5 NIL)
    (DV$4 NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT DV$6 (|devaluate| |#6|))
    (LETT DV$7 (|devaluate| |#7|))
    (LETT DV$8 (|devaluate| |#8|))
    (LETT |dv$|
          (LIST '|TwoDimensionalArrayFunctions| DV$1 DV$2 DV$3 DV$4 DV$5 DV$6
                DV$7 DV$8))
    (LETT $ (GETREFV 27))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|TwoDimensionalArrayFunctions|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5 DV$6 DV$7 DV$8) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (QSETREFV $ 11 |#6|)
    (QSETREFV $ 12 |#7|)
    (QSETREFV $ 13 |#8|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|TwoDimensionalArrayFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (|local| |#6|)
              (|local| |#7|) (|local| |#8|) (|NonNegativeInteger|)
              (0 . |nrows|) (5 . |ncols|) (10 . |qnew|) (|Integer|)
              (16 . |minRowIndex|) (21 . |maxRowIndex|) (26 . |minColIndex|)
              (31 . |maxColIndex|) (36 . |qelt|) (43 . |qsetelt!|)
              (|Mapping| 10 6) |ARRAY22;map;MMAMB;1|)
           '#(|map| 51) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map| (|#8| (|Mapping| |#5| |#1|) |#4|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 26
                                            '(1 9 14 0 15 1 9 14 0 16 2 13 0 14
                                              14 17 1 9 18 0 19 1 9 18 0 20 1 9
                                              18 0 21 1 9 18 0 22 3 9 6 0 18 18
                                              23 4 13 10 0 18 18 10 24 2 0 13
                                              25 9 26)))))
           '|lookupComplete|)) 
