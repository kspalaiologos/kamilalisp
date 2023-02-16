
(SDEFUN |PMLSAGG;patternMatch;LP2Pmlr;1|
        ((|l| (L)) (|p| (|Pattern| S)) (|r| (|PatternMatchListResult| S R L))
         ($ (|PatternMatchListResult| S R L)))
        (SPROG ((|u| (|Union| (|List| (|Pattern| S)) "failed")))
               (SEQ (LETT |u| (SPADCALL |p| (QREFELT $ 11)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (SPADCALL (QREFELT $ 13)))
                           ('T (|PMLSAGG;match| |l| (QCDR |u|) |r| 'T $))))))) 

(SDEFUN |PMLSAGG;match|
        ((|l| (L)) (|lp| (|List| (|Pattern| S)))
         (|r| (|PatternMatchListResult| S R L)) (|new?| (|Boolean|))
         ($ (|PatternMatchListResult| S R L)))
        (SPROG ((|p0| (|Pattern| S)))
               (SEQ
                (COND
                 ((NULL |lp|)
                  (COND ((SPADCALL |l| (QREFELT $ 16)) |r|)
                        (#1='T (SPADCALL (QREFELT $ 13)))))
                 ((SPADCALL (LETT |p0| (|SPADfirst| |lp|)) (QREFELT $ 17))
                  (COND
                   ((NULL (CDR |lp|))
                    (SEQ
                     (COND
                      ((NULL |new?|) (LETT |l| (SPADCALL |l| (QREFELT $ 18)))))
                     (EXIT
                      (SPADCALL (SPADCALL |r| (QREFELT $ 20))
                                (SPADCALL |p0| |l|
                                          (SPADCALL |r| (QREFELT $ 22))
                                          (SPADCALL (QREFELT $ 23))
                                          (QREFELT $ 24))
                                (QREFELT $ 25)))))
                   (|new?|
                    (|PMLSAGG;match| (SPADCALL |l| (QREFELT $ 26))
                     (REVERSE |lp|) |r| NIL $))
                   (#1#
                    (|error| "Only one multiple pattern allowed in list"))))
                 ((OR (SPADCALL |l| (QREFELT $ 16))
                      (SPADCALL
                       (LETT |r|
                             (SPADCALL
                              (SPADCALL (SPADCALL |l| (QREFELT $ 27)) |p0|
                                        (SPADCALL |r| (QREFELT $ 20))
                                        (QREFELT $ 29))
                              (SPADCALL |r| (QREFELT $ 22)) (QREFELT $ 25)))
                       (QREFELT $ 30)))
                  (SPADCALL (QREFELT $ 13)))
                 ('T
                  (|PMLSAGG;match| (SPADCALL |l| (QREFELT $ 31)) (CDR |lp|) |r|
                   |new?| $)))))) 

(DECLAIM (NOTINLINE |PatternMatchListAggregate;|)) 

(DEFUN |PatternMatchListAggregate| (&REST #1=#:G716)
  (SPROG NIL
         (PROG (#2=#:G717)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PatternMatchListAggregate|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PatternMatchListAggregate;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|PatternMatchListAggregate|)))))))))) 

(DEFUN |PatternMatchListAggregate;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|PatternMatchListAggregate| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 32))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PatternMatchListAggregate|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PatternMatchListAggregate| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Union| (|List| $) '"failed") (|Pattern| 6)
              (0 . |isList|) (|PatternMatchListResult| 6 7 8) (5 . |failed|)
              |PMLSAGG;patternMatch;LP2Pmlr;1| (|Boolean|) (9 . |empty?|)
              (14 . |multiple?|) (19 . |reverse!|) (|PatternMatchResult| 6 7)
              (24 . |atoms|) (|PatternMatchResult| 6 8) (29 . |lists|)
              (34 . |empty|) (38 . |addMatchRestricted|) (46 . |makeResult|)
              (52 . |reverse|) (57 . |first|) (|PatternMatchResult| 6 $)
              (62 . |patternMatch|) (69 . |failed?|) (74 . |rest|))
           '#(|patternMatch| 79) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|patternMatch|
                                 ((|PatternMatchListResult| |#1| |#2| |#3|)
                                  |#3| (|Pattern| |#1|)
                                  (|PatternMatchListResult| |#1| |#2| |#3|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 31
                                            '(1 10 9 0 11 0 12 0 13 1 8 15 0 16
                                              1 10 15 0 17 1 8 0 0 18 1 12 19 0
                                              20 1 12 21 0 22 0 8 0 23 4 21 0
                                              10 8 0 8 24 2 12 0 19 21 25 1 8 0
                                              0 26 1 8 7 0 27 3 7 28 0 10 28 29
                                              1 12 15 0 30 1 8 0 0 31 3 0 12 8
                                              10 12 14)))))
           '|lookupComplete|)) 
