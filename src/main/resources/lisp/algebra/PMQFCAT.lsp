
(SDEFUN |PMQFCAT;patternMatch;QP2Pmr;1|
        ((|x| (Q)) (|p| (|Pattern| S)) (|l| (|PatternMatchResult| S Q))
         ($ (|PatternMatchResult| S Q)))
        (SPROG
         ((|ur| (|Record| (|:| |num| (|Pattern| S)) (|:| |den| (|Pattern| S))))
          (|u|
           (|Union|
            (|Record| (|:| |num| (|Pattern| S)) (|:| |den| (|Pattern| S)))
            "failed"))
          (#1=#:G694 NIL) (|r| (|Union| R "failed")))
         (SEQ
          (COND
           ((SPADCALL |p| (QREFELT $ 11))
            (SPADCALL |p| |x| |l| (QREFELT $ 13)))
           ((QEQCAR (LETT |r| (SPADCALL |x| (QREFELT $ 15))) 0)
            (SPADCALL
             (PROG2 (LETT #1# |r|)
                 (QCDR #1#)
               (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                               (|Union| (QREFELT $ 7) "failed") #1#))
             |p| |l| (QREFELT $ 17)))
           (#2='T
            (SEQ (LETT |u| (SPADCALL |p| (QREFELT $ 20)))
                 (EXIT
                  (COND
                   ((QEQCAR |u| 0)
                    (SEQ (LETT |ur| (QCDR |u|))
                         (EXIT
                          (COND
                           ((SPADCALL
                             (LETT |l|
                                   (SPADCALL (SPADCALL |x| (QREFELT $ 21))
                                             (QCAR |ur|) |l| (QREFELT $ 17)))
                             (QREFELT $ 22))
                            |l|)
                           (#2#
                            (SPADCALL (SPADCALL |x| (QREFELT $ 23)) (QCDR |ur|)
                                      |l| (QREFELT $ 17)))))))
                   (#2# (SPADCALL (QREFELT $ 24))))))))))) 

(DECLAIM (NOTINLINE |PatternMatchQuotientFieldCategory;|)) 

(DEFUN |PatternMatchQuotientFieldCategory| (&REST #1=#:G705)
  (SPROG NIL
         (PROG (#2=#:G706)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PatternMatchQuotientFieldCategory|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |PatternMatchQuotientFieldCategory;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|PatternMatchQuotientFieldCategory|)))))))))) 

(DEFUN |PatternMatchQuotientFieldCategory;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$|
                (LIST '|PatternMatchQuotientFieldCategory| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 26))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PatternMatchQuotientFieldCategory|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PatternMatchQuotientFieldCategory| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Boolean|) (|Pattern| 6) (0 . |generic?|)
              (|PatternMatchResult| 6 8) (5 . |addMatch|) (|Union| 7 '"failed")
              (12 . |retractIfCan|) (|PatternMatchPushDown| 6 7 8)
              (17 . |patternMatch|) (|Record| (|:| |num| $) (|:| |den| $))
              (|Union| 18 '"failed") (24 . |isQuotient|) (29 . |numer|)
              (34 . |failed?|) (39 . |denom|) (44 . |failed|)
              |PMQFCAT;patternMatch;QP2Pmr;1|)
           '#(|patternMatch| 48) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|patternMatch|
                                 ((|PatternMatchResult| |#1| |#3|) |#3|
                                  (|Pattern| |#1|)
                                  (|PatternMatchResult| |#1| |#3|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 25
                                            '(1 10 9 0 11 3 12 0 10 8 0 13 1 8
                                              14 0 15 3 16 12 7 10 12 17 1 10
                                              19 0 20 1 8 7 0 21 1 12 9 0 22 1
                                              8 7 0 23 0 12 0 24 3 0 12 8 10 12
                                              25)))))
           '|lookupComplete|)) 
