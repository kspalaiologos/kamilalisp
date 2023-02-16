
(SDEFUN |PATMATCH;ist|
        ((|s| (|Subject|)) (|p| (|Pat|))
         ($ (|PatternMatchResult| |Base| |Subject|)))
        (SPADCALL |s| (SPADCALL |p| (QREFELT $ 10)) (SPADCALL (QREFELT $ 12))
                  (QREFELT $ 14))) 

(SDEFUN |PATMATCH;is?;SubjectPatB;2|
        ((|s| (|Subject|)) (|p| (|Pat|)) ($ (|Boolean|)))
        (NULL (SPADCALL (|PATMATCH;ist| |s| |p| $) (QREFELT $ 16)))) 

(SDEFUN |PATMATCH;is?;LPatB;3|
        ((|s| (|List| |Subject|)) (|p| (|Pat|)) ($ (|Boolean|)))
        (NULL (SPADCALL (SPADCALL |s| |p| (QREFELT $ 20)) (QREFELT $ 21)))) 

(SDEFUN |PATMATCH;Is;LPatPmlr;4|
        ((|s| (|List| |Subject|)) (|p| (|Pat|))
         ($ (|PatternMatchListResult| |Base| |Subject| (|List| |Subject|))))
        (SPADCALL |s| (SPADCALL |p| (QREFELT $ 10)) (SPADCALL (QREFELT $ 23))
                  (QREFELT $ 25))) 

(SDEFUN |PATMATCH;Is;SubjectPatL;5|
        ((|s| (|Subject|)) (|p| (|Pat|)) ($ (|List| (|Equation| |Subject|))))
        (SPROG
         ((#1=#:G713 NIL) (|rec| NIL) (#2=#:G712 NIL)
          (|r| (|PatternMatchResult| |Base| |Subject|)))
         (SEQ
          (COND
           ((SPADCALL (LETT |r| (|PATMATCH;ist| |s| |p| $)) (QREFELT $ 16))
            NIL)
           ('T
            (PROGN
             (LETT #2# NIL)
             (SEQ (LETT |rec| NIL) (LETT #1# (SPADCALL |r| (QREFELT $ 28)))
                  G190
                  (COND
                   ((OR (ATOM #1#) (PROGN (LETT |rec| (CAR #1#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (LETT #2#
                          (CONS
                           (SPADCALL (SPADCALL (QCAR |rec|) (QREFELT $ 30))
                                     (QCDR |rec|) (QREFELT $ 32))
                           #2#))))
                  (LETT #1# (CDR #1#)) (GO G190) G191
                  (EXIT (NREVERSE #2#))))))))) 

(SDEFUN |PATMATCH;Is;SubjectPatL;6|
        ((|s| (|Subject|)) (|p| (|Pat|))
         ($ (|List| (|Equation| (|Polynomial| |Subject|)))))
        (SPROG
         ((#1=#:G723 NIL) (|rec| NIL) (#2=#:G722 NIL)
          (|r| (|PatternMatchResult| |Base| |Subject|)))
         (SEQ
          (COND
           ((SPADCALL (LETT |r| (|PATMATCH;ist| |s| |p| $)) (QREFELT $ 16))
            NIL)
           ('T
            (PROGN
             (LETT #2# NIL)
             (SEQ (LETT |rec| NIL) (LETT #1# (SPADCALL |r| (QREFELT $ 28)))
                  G190
                  (COND
                   ((OR (ATOM #1#) (PROGN (LETT |rec| (CAR #1#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (LETT #2#
                          (CONS
                           (SPADCALL (SPADCALL (QCAR |rec|) (QREFELT $ 36))
                                     (SPADCALL (QCDR |rec|) (QREFELT $ 37))
                                     (QREFELT $ 39))
                           #2#))))
                  (LETT #1# (CDR #1#)) (GO G190) G191
                  (EXIT (NREVERSE #2#))))))))) 

(SDEFUN |PATMATCH;Is;SubjectPatPmr;7|
        ((|s| (|Subject|)) (|p| (|Pat|))
         ($ (|PatternMatchResult| |Base| |Subject|)))
        (|PATMATCH;ist| |s| |p| $)) 

(DECLAIM (NOTINLINE |PatternMatch;|)) 

(DEFUN |PatternMatch| (&REST #1=#:G726)
  (SPROG NIL
         (PROG (#2=#:G727)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PatternMatch|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PatternMatch;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|PatternMatch|)))))))))) 

(DEFUN |PatternMatch;| (|#1| |#2| |#3|)
  (SPROG
   ((|pv$| NIL) (#1=#:G725 NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT |dv$| (LIST '|PatternMatch| DV$1 DV$2 DV$3))
    (LETT $ (GETREFV 43))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (LETT #1#
                                              (|HasCategory| |#2|
                                                             '(|RetractableTo|
                                                               (|Symbol|))))
                                        (AND (|not| #1#)
                                             (|not|
                                              (|HasCategory| |#2| '(|Ring|))))
                                        (AND (|HasCategory| |#2| '(|Ring|))
                                             (|not| #1#))))))
    (|haddProp| |$ConstructorCache| '|PatternMatch| (LIST DV$1 DV$2 DV$3)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|testBitVector| |pv$| 1)
      (QSETREFV $ 34
                (CONS (|dispatchFunction| |PATMATCH;Is;SubjectPatL;5|) $)))
     ((|HasCategory| |#2| '(|Ring|))
      (QSETREFV $ 41
                (CONS (|dispatchFunction| |PATMATCH;Is;SubjectPatL;6|) $)))
     ('T
      (QSETREFV $ 42
                (CONS (|dispatchFunction| |PATMATCH;Is;SubjectPatPmr;7|) $))))
    $))) 

(MAKEPROP '|PatternMatch| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Pattern| 6) (0 . |convert|)
              (|PatternMatchResult| 6 7) (5 . |new|) (|PatternMatchResult| 6 $)
              (9 . |patternMatch|) (|Boolean|) (16 . |failed?|)
              |PATMATCH;is?;SubjectPatB;2| (|PatternMatchListResult| 6 7 19)
              (|List| 7) |PATMATCH;Is;LPatPmlr;4| (21 . |failed?|)
              |PATMATCH;is?;LPatB;3| (26 . |new|)
              (|PatternMatchListAggregate| 6 7 19) (30 . |patternMatch|)
              (|Record| (|:| |key| 29) (|:| |entry| 7)) (|List| 26)
              (37 . |destruct|) (|Symbol|) (42 . |coerce|) (|Equation| 7)
              (47 . =) (|List| 31) (53 . |Is|) (|Polynomial| 7) (59 . |coerce|)
              (64 . |coerce|) (|Equation| 35) (69 . =) (|List| 38) (75 . |Is|)
              (81 . |Is|))
           '#(|is?| 87 |Is| 99) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|is?| ((|Boolean|) |#2| |#3|)) T)
                                   '((|is?| ((|Boolean|) (|List| |#2|) |#3|))
                                     T)
                                   '((|Is|
                                      ((|PatternMatchListResult| |#1| |#2|
                                                                 (|List| |#2|))
                                       (|List| |#2|) |#3|))
                                     T)
                                   '((|Is|
                                      ((|List| (|Equation| |#2|)) |#2| |#3|))
                                     (|has| 7 (|RetractableTo| 29)))
                                   '((|Is|
                                      ((|List|
                                        (|Equation| (|Polynomial| |#2|)))
                                       |#2| |#3|))
                                     (AND (|has| 7 (|Ring|))
                                          (|not|
                                           (|has| 7 (|RetractableTo| 29)))))
                                   '((|Is|
                                      ((|PatternMatchResult| |#1| |#2|) |#2|
                                       |#3|))
                                     (AND (|not| (|has| 7 (|Ring|)))
                                          (|not|
                                           (|has| 7 (|RetractableTo| 29))))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 42
                                            '(1 8 9 0 10 0 11 0 12 3 7 13 0 9
                                              13 14 1 11 15 0 16 1 18 15 0 21 0
                                              18 0 23 3 24 18 19 9 18 25 1 11
                                              27 0 28 1 7 0 29 30 2 31 0 7 7 32
                                              2 0 33 7 8 34 1 35 0 29 36 1 35 0
                                              7 37 2 38 0 35 35 39 2 0 40 7 8
                                              41 2 0 11 7 8 42 2 0 15 7 8 17 2
                                              0 15 19 8 22 2 3 40 7 8 41 2 2 11
                                              7 8 42 2 1 33 7 8 34 2 0 18 19 8
                                              20)))))
           '|lookupComplete|)) 
