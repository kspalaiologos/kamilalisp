
(SDEFUN |LAZM3PK;convert| ((|st| (ST)) ($ (TS)))
        (SPROG ((|ts| (TS)) (#1=#:G709 NIL) (|p| NIL) (|lp| (|List| P)))
               (SEQ (LETT |ts| (SPADCALL (QREFELT $ 12)))
                    (LETT |lp| (SPADCALL |st| (QREFELT $ 14)))
                    (LETT |lp| (SPADCALL (ELT $ 16) |lp| (QREFELT $ 18)))
                    (SEQ (LETT |p| NIL) (LETT #1# |lp|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |ts| (SPADCALL |p| |ts| (QREFELT $ 19)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |ts|)))) 

(SDEFUN |LAZM3PK;squareFree| ((|ts| (TS)) ($ (|List| ST)))
        (SPROG
         ((|toSee| (|List| ST)) (|toSave| (|List| ST)) (|newus| (ST))
          (#1=#:G727 NIL) (|pwt| NIL)
          (|lpwt| (|List| (|Record| (|:| |val| P) (|:| |tower| ST))))
          (|us| (ST)) (#2=#:G726 NIL) (|p| NIL) (|newts| (ST))
          (|lp| (|List| P)))
         (SEQ
          (COND
           ((SPADCALL |ts| (QREFELT $ 20)) (LIST (SPADCALL (QREFELT $ 21))))
           ('T
            (SEQ (LETT |lp| (SPADCALL |ts| (QREFELT $ 22)))
                 (LETT |lp| (SPADCALL (ELT $ 16) |lp| (QREFELT $ 18)))
                 (LETT |newts| (SPADCALL (QREFELT $ 21)))
                 (LETT |toSee| (LIST |newts|))
                 (SEQ (LETT |p| NIL) (LETT #2# |lp|) G190
                      (COND
                       ((OR (ATOM #2#) (PROGN (LETT |p| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ (LETT |toSave| NIL)
                           (SEQ G190
                                (COND ((NULL (NULL (NULL |toSee|))) (GO G191)))
                                (SEQ (LETT |us| (|SPADfirst| |toSee|))
                                     (LETT |toSee| (CDR |toSee|))
                                     (LETT |lpwt|
                                           (SPADCALL |p| |us| (QREFELT $ 26)))
                                     (EXIT
                                      (SEQ (LETT |pwt| NIL) (LETT #1# |lpwt|)
                                           G190
                                           (COND
                                            ((OR (ATOM #1#)
                                                 (PROGN
                                                  (LETT |pwt| (CAR #1#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (LETT |newus|
                                                  (SPADCALL (QCAR |pwt|)
                                                            (QCDR |pwt|)
                                                            (QREFELT $ 27)))
                                            (EXIT
                                             (LETT |toSave|
                                                   (CONS |newus| |toSave|))))
                                           (LETT #1# (CDR #1#)) (GO G190) G191
                                           (EXIT NIL))))
                                NIL (GO G190) G191 (EXIT NIL))
                           (EXIT (LETT |toSee| |toSave|)))
                      (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                 (EXIT |toSave|))))))) 

(SDEFUN |LAZM3PK;normalizeIfCan;2ST;3| ((|ts| (ST)) ($ (ST)))
        (SPROG
         ((|newts| (ST)) (|p| (P)) (|lp| (|List| P)) (#1=#:G742 NIL)
          (#2=#:G743 NIL) (#3=#:G744 NIL) (|v| NIL) (|lv| (|List| V)))
         (SEQ
          (EXIT
           (COND ((SPADCALL |ts| (QREFELT $ 28)) |ts|)
                 ('T
                  (SEQ (LETT |lp| (SPADCALL |ts| (QREFELT $ 14)))
                       (LETT |lp| (SPADCALL (ELT $ 16) |lp| (QREFELT $ 18)))
                       (LETT |p| (|SPADfirst| |lp|))
                       (COND
                        ((NULL (SPADCALL |p| (QREFELT $ 30))) (EXIT |ts|)))
                       (LETT |lp| (CDR |lp|))
                       (LETT |newts| (SPADCALL (QREFELT $ 21)))
                       (LETT |newts| (SPADCALL |p| |newts| (QREFELT $ 27)))
                       (SEQ G190 (COND ((NULL (NULL (NULL |lp|))) (GO G191)))
                            (SEQ (LETT |p| (|SPADfirst| |lp|))
                                 (LETT |lv| (SPADCALL |p| (QREFELT $ 32)))
                                 (SEQ (LETT |v| NIL) (LETT #3# |lv|) G190
                                      (COND
                                       ((OR (ATOM #3#)
                                            (PROGN (LETT |v| (CAR #3#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (COND
                                         ((SPADCALL |v|
                                                    (SPADCALL |p|
                                                              (QREFELT $ 33))
                                                    (QREFELT $ 34))
                                          "leave")
                                         ('T
                                          (SEQ
                                           (EXIT
                                            (COND
                                             ((NULL
                                               (SPADCALL |v| |newts|
                                                         (QREFELT $ 35)))
                                              (PROGN
                                               (LETT #1#
                                                     (PROGN
                                                      (LETT #2#
                                                            (SPADCALL |lp|
                                                                      |newts|
                                                                      (QREFELT
                                                                       $ 36)))
                                                      (GO #4=#:G741)))
                                               (GO #5=#:G734)))))
                                           #5# (EXIT #1#))))))
                                      (LETT #3# (CDR #3#)) (GO G190) G191
                                      (EXIT NIL))
                                 (LETT |lp| (CDR |lp|))
                                 (LETT |p|
                                       (SPADCALL |p| |newts| (QREFELT $ 38)))
                                 (EXIT
                                  (LETT |newts|
                                        (SPADCALL |p| |newts|
                                                  (QREFELT $ 27)))))
                            NIL (GO G190) G191 (EXIT NIL))
                       (EXIT |newts|)))))
          #4# (EXIT #2#)))) 

(SDEFUN |LAZM3PK;zeroSetSplit;LBL;4|
        ((|lp| (|List| P)) (|clos?| (|Boolean|)) ($ (|List| ST)))
        (SPROG
         ((#1=#:G761 NIL) (|ts| NIL) (#2=#:G760 NIL) (|toSave| (|List| ST))
          (#3=#:G759 NIL) (|toSee| (|List| TS)))
         (SEQ (LETT |toSee| (SPADCALL |lp| |clos?| (QREFELT $ 41)))
              (LETT |toSave| NIL)
              (SEQ (LETT |ts| NIL) (LETT #3# |toSee|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |ts| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |toSave|
                           (SPADCALL (|LAZM3PK;squareFree| |ts| $) |toSave|
                                     (QREFELT $ 43)))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (LETT |toSave| (SPADCALL |toSave| (QREFELT $ 45)))
              (EXIT
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |ts| NIL) (LETT #1# |toSave|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |ts| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #2# (CONS (SPADCALL |ts| (QREFELT $ 39)) #2#))))
                     (LETT #1# (CDR #1#)) (GO G190) G191
                     (EXIT (NREVERSE #2#)))))))) 

(DECLAIM (NOTINLINE |LazardSetSolvingPackage;|)) 

(DEFUN |LazardSetSolvingPackage| (&REST #1=#:G762)
  (SPROG NIL
         (PROG (#2=#:G763)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|LazardSetSolvingPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |LazardSetSolvingPackage;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|LazardSetSolvingPackage|)))))))))) 

(DEFUN |LazardSetSolvingPackage;| (|#1| |#2| |#3| |#4| |#5| |#6|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$6 NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL)
    (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT DV$6 (|devaluate| |#6|))
    (LETT |dv$|
          (LIST '|LazardSetSolvingPackage| DV$1 DV$2 DV$3 DV$4 DV$5 DV$6))
    (LETT $ (GETREFV 47))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|LazardSetSolvingPackage|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5 DV$6) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (QSETREFV $ 11 |#6|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|LazardSetSolvingPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (|local| |#6|)
              (0 . |empty|) (|List| 9) (4 . |members|) (|Boolean|)
              (9 . |infRittWu?|) (|Mapping| 15 9 9) (15 . |sort|)
              (21 . |internalAugment|) (27 . |empty?|) (32 . |empty|)
              (36 . |members|) (|Record| (|:| |val| 9) (|:| |tower| 11))
              (|List| 23)
              (|SquareFreeRegularTriangularSetGcdPackage| 6 7 8 9 11)
              (41 . |stoseSquareFreePart|) (47 . |internalAugment|)
              (53 . |empty?|) (|PolynomialSetUtilitiesPackage| 6 7 8 9)
              (58 . |univariate?|) (|List| 8) (63 . |variables|) (68 . |mvar|)
              (73 . =) (79 . |algebraic?|) (85 . |internalAugment|)
              (|NormalizationPackage| 6 7 8 9 11) (91 . |normalizedAssociate|)
              |LAZM3PK;normalizeIfCan;2ST;3| (|List| $) (97 . |zeroSetSplit|)
              (|List| 11) (103 . |concat|)
              (|SquareFreeQuasiComponentPackage| 6 7 8 9 11)
              (109 . |removeSuperfluousQuasiComponents|)
              |LAZM3PK;zeroSetSplit;LBL;4|)
           '#(|zeroSetSplit| 114 |normalizeIfCan| 120) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|normalizeIfCan| (|#6| |#6|)) T)
                                   '((|zeroSetSplit|
                                      ((|List| |#6|) (|List| |#4|)
                                       (|Boolean|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 46
                                            '(0 10 0 12 1 11 13 0 14 2 9 15 0 0
                                              16 2 13 0 17 0 18 2 10 0 9 0 19 1
                                              10 15 0 20 0 11 0 21 1 10 13 0 22
                                              2 25 24 9 11 26 2 11 0 9 0 27 1
                                              11 15 0 28 1 29 15 9 30 1 9 31 0
                                              32 1 9 8 0 33 2 8 15 0 0 34 2 11
                                              15 8 0 35 2 11 0 13 0 36 2 37 9 9
                                              11 38 2 10 40 13 15 41 2 42 0 0 0
                                              43 1 44 42 42 45 2 0 42 13 15 46
                                              1 0 11 11 39)))))
           '|lookupComplete|)) 
