
(SDEFUN |PMSYM;patternMatch;SP2Pmr;1|
        ((|s| (|Symbol|)) (|p| (|Pattern| S))
         (|l| (|PatternMatchResult| S (|Symbol|)))
         ($ (|PatternMatchResult| S (|Symbol|))))
        (SPROG ((#1=#:G716 NIL) (|u| (|Union| (|Symbol|) "failed")))
               (SEQ
                (COND
                 ((SPADCALL |p| (QREFELT $ 9))
                  (SPADCALL |p| |s| |l| (QREFELT $ 12)))
                 ((SPADCALL |p| (QREFELT $ 13))
                  (SEQ
                   (EXIT
                    (SEQ
                     (SEQ (LETT |u| (SPADCALL |p| (QREFELT $ 15)))
                          (EXIT
                           (COND
                            ((QEQCAR |u| 0)
                             (COND
                              ((EQUAL (QCDR |u|) |s|)
                               (PROGN (LETT #1# |l|) (GO #2=#:G712))))))))
                     (EXIT (SPADCALL (QREFELT $ 16)))))
                   #2# (EXIT #1#)))
                 ('T (SPADCALL (QREFELT $ 16))))))) 

(DECLAIM (NOTINLINE |PatternMatchSymbol;|)) 

(DEFUN |PatternMatchSymbol| (#1=#:G717)
  (SPROG NIL
         (PROG (#2=#:G718)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|PatternMatchSymbol|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|PatternMatchSymbol;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PatternMatchSymbol|)))))))))) 

(DEFUN |PatternMatchSymbol;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|PatternMatchSymbol| DV$1))
          (LETT $ (GETREFV 18))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PatternMatchSymbol| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PatternMatchSymbol| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Boolean|) (|Pattern| 6)
              (0 . |generic?|) (|Symbol|) (|PatternMatchResult| 6 10)
              (5 . |addMatch|) (12 . |constant?|) (|Union| 10 '"failed")
              (17 . |retractIfCan|) (22 . |failed|)
              |PMSYM;patternMatch;SP2Pmr;1|)
           '#(|patternMatch| 26) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|patternMatch|
                                 ((|PatternMatchResult| |#1| (|Symbol|))
                                  (|Symbol|) (|Pattern| |#1|)
                                  (|PatternMatchResult| |#1| (|Symbol|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 17
                                            '(1 8 7 0 9 3 11 0 8 10 0 12 1 8 7
                                              0 13 1 8 14 0 15 0 11 0 16 3 0 11
                                              10 8 11 17)))))
           '|lookupComplete|)) 
