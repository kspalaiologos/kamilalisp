
(SDEFUN |IMATQF;qfMat| ((|m| (M)) ($ (M2)))
        (SPADCALL (ELT $ 14) |m| (QREFELT $ 17))) 

(SDEFUN |IMATQF;rowEchelon;MM2;2| ((|m| (M)) ($ (M2)))
        (SPADCALL (|IMATQF;qfMat| |m| $) (QREFELT $ 19))) 

(SDEFUN |IMATQF;inverse;MU;3| ((|m| (M)) ($ (|Union| M2 "failed")))
        (SPROG ((|inv| (|Union| M2 "failed")))
               (SEQ
                (LETT |inv| (SPADCALL (|IMATQF;qfMat| |m| $) (QREFELT $ 22)))
                (EXIT
                 (COND ((QEQCAR |inv| 1) (CONS 1 "failed"))
                       ('T (CONS 0 (QCDR |inv|)))))))) 

(SDEFUN |IMATQF;nullSpace;ML;4| ((|m| (M)) ($ (|List| |Col|)))
        (SPROG ((#1=#:G704 NIL) (|v| NIL) (#2=#:G703 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |v| NIL)
                      (LETT #1#
                            (SPADCALL (|IMATQF;qfMat| |m| $) (QREFELT $ 25)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |v| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |v| (QREFELT $ 27)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(DECLAIM (NOTINLINE |InnerMatrixQuotientFieldFunctions;|)) 

(DEFUN |InnerMatrixQuotientFieldFunctions| (&REST #1=#:G705)
  (SPROG NIL
         (PROG (#2=#:G706)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|InnerMatrixQuotientFieldFunctions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |InnerMatrixQuotientFieldFunctions;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|InnerMatrixQuotientFieldFunctions|)))))))))) 

(DEFUN |InnerMatrixQuotientFieldFunctions;|
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
          (LIST '|InnerMatrixQuotientFieldFunctions| DV$1 DV$2 DV$3 DV$4 DV$5
                DV$6 DV$7 DV$8))
    (LETT $ (GETREFV 30))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#7|
                                                       '(|shallowlyMutable|))))))
    (|haddProp| |$ConstructorCache| '|InnerMatrixQuotientFieldFunctions|
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
    (COND
     ((|testBitVector| |pv$| 1)
      (QSETREFV $ 29 (CONS (|dispatchFunction| |IMATQF;nullSpace;ML;4|) $))))
    $))) 

(MAKEPROP '|InnerMatrixQuotientFieldFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (|local| |#6|)
              (|local| |#7|) (|local| |#8|) (0 . |coerce|) (|Mapping| 10 6)
              (|MatrixCategoryFunctions2| 6 7 8 9 10 11 12 13) (5 . |map|)
              (|InnerMatrixLinearAlgebraFunctions| 10 11 12 13)
              (11 . |rowEchelon|) |IMATQF;rowEchelon;MM2;2|
              (|Union| 13 '"failed") (16 . |inverse|) |IMATQF;inverse;MU;3|
              (|List| 12) (21 . |nullSpace|)
              (|InnerCommonDenominator| 6 10 8 12) (26 . |clearDenominator|)
              (|List| 8) (31 . |nullSpace|))
           '#(|rowEchelon| 36 |nullSpace| 41 |inverse| 46) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|rowEchelon| (|#8| |#4|)) T)
                                   '((|inverse| ((|Union| |#8| "failed") |#4|))
                                     T)
                                   '((|nullSpace| ((|List| |#3|) |#4|))
                                     (|has| 12 (|shallowlyMutable|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 29
                                            '(1 10 0 6 14 2 16 13 15 9 17 1 18
                                              13 13 19 1 18 21 13 22 1 18 24 13
                                              25 1 26 8 12 27 1 0 28 9 29 1 0
                                              13 9 20 1 1 28 9 29 1 0 21 9
                                              23)))))
           '|lookupComplete|)) 
