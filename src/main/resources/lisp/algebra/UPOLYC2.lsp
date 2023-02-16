
(SDEFUN |UPOLYC2;map;MPRPS;1| ((|f| (|Mapping| S R)) (|p| (PR)) ($ (PS)))
        (SPROG ((|ans| (|RepPS|)) (|nc| (S)))
               (SEQ (LETT |ans| NIL)
                    (SEQ G190
                         (COND
                          ((NULL
                            (NULL
                             (SPADCALL |p| (|spadConstant| $ 14)
                                       (QREFELT $ 16))))
                           (GO G191)))
                         (SEQ
                          (LETT |nc|
                                (SPADCALL (SPADCALL |p| (QREFELT $ 17)) |f|))
                          (COND
                           ((SPADCALL |nc| (|spadConstant| $ 18)
                                      (QREFELT $ 19))
                            (LETT |ans|
                                  (CONS
                                   (CONS (SPADCALL |p| (QREFELT $ 21)) |nc|)
                                   |ans|))))
                          (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 22)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (NREVERSE |ans|))))) 

(SDEFUN |UPOLYC2;map;MPRPS;2| ((|f| (|Mapping| S R)) (|p| (PR)) ($ (PS)))
        (SPROG ((|ans| (|RepPS|)) (|nc| (S)))
               (SEQ (LETT |ans| NIL)
                    (SEQ G190
                         (COND
                          ((NULL
                            (NULL
                             (SPADCALL |p| (|spadConstant| $ 14)
                                       (QREFELT $ 16))))
                           (GO G191)))
                         (SEQ
                          (LETT |nc|
                                (SPADCALL (SPADCALL |p| (QREFELT $ 17)) |f|))
                          (COND
                           ((SPADCALL |nc| (|spadConstant| $ 18)
                                      (QREFELT $ 19))
                            (LETT |ans|
                                  (CONS
                                   (CONS (SPADCALL |p| (QREFELT $ 21)) |nc|)
                                   |ans|))))
                          (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 22)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT (NREVERSE |ans|))))) 

(SDEFUN |UPOLYC2;map;MPRPS;3| ((|f| (|Mapping| S R)) (|p| (PR)) ($ (PS)))
        (SPROG ((|ans| (PS)))
               (SEQ (LETT |ans| (|spadConstant| $ 25))
                    (SEQ G190
                         (COND
                          ((NULL
                            (NULL
                             (SPADCALL |p| (|spadConstant| $ 14)
                                       (QREFELT $ 16))))
                           (GO G191)))
                         (SEQ
                          (LETT |ans|
                                (SPADCALL |ans|
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |p| (QREFELT $ 17)) |f|)
                                           (SPADCALL |p| (QREFELT $ 21))
                                           (QREFELT $ 26))
                                          (QREFELT $ 27)))
                          (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 22)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |ans|)))) 

(DECLAIM (NOTINLINE |UnivariatePolynomialCategoryFunctions2;|)) 

(DEFUN |UnivariatePolynomialCategoryFunctions2| (&REST #1=#:G729)
  (SPROG NIL
         (PROG (#2=#:G730)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|UnivariatePolynomialCategoryFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |UnivariatePolynomialCategoryFunctions2;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|UnivariatePolynomialCategoryFunctions2|)))))))))) 

(DEFUN |UnivariatePolynomialCategoryFunctions2;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$|
          (LIST '|UnivariatePolynomialCategoryFunctions2| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 28))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|UnivariatePolynomialCategoryFunctions2|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 10 (CAR (|devaluate| |#4|)))
    (QSETREFV $ 11 (EQUAL (QREFELT $ 10) '|UnivariatePolynomial|))
    (COND
     ((QREFELT $ 11)
      (PROGN
       (QSETREFV $ 12 (|List| (|Record| (|:| |k| (|Integer|)) (|:| |c| |#3|))))
       (QSETREFV $ 24 (CONS (|dispatchFunction| |UPOLYC2;map;MPRPS;1|) $))))
     ((|domainEqual| |#4| (|SparseUnivariatePolynomial| |#3|))
      (PROGN
       (SETELT $ 12 (|List| (|Record| (|:| |k| (|Integer|)) (|:| |c| |#3|))))
       (QSETREFV $ 24 (CONS (|dispatchFunction| |UPOLYC2;map;MPRPS;2|) $))))
     ('T (QSETREFV $ 24 (CONS (|dispatchFunction| |UPOLYC2;map;MPRPS;3|) $))))
    $))) 

(MAKEPROP '|UnivariatePolynomialCategoryFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) '|op_of_PS| '#:G689 '|RepPS|
              (0 . |Zero|) (4 . |Zero|) (|Boolean|) (8 . =)
              (14 . |leadingCoefficient|) (19 . |Zero|) (23 . ~=)
              (|NonNegativeInteger|) (29 . |degree|) (34 . |reductum|)
              (|Mapping| 8 6) (39 . |map|) (45 . |Zero|) (49 . |monomial|)
              (55 . +))
           '#(|map| 61) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map| (|#4| (|Mapping| |#3| |#1|) |#2|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 27
                                            '(0 6 0 13 0 7 0 14 2 7 15 0 0 16 1
                                              7 6 0 17 0 8 0 18 2 8 15 0 0 19 1
                                              7 20 0 21 1 7 0 0 22 2 0 9 23 7
                                              24 0 9 0 25 2 9 0 8 20 26 2 9 0 0
                                              0 27 2 0 9 23 7 24)))))
           '|lookupComplete|)) 
