
(SDEFUN |PMFS;patternMatch;FP2Pmr;1|
        ((|x| (F)) (|p| (|Pattern| S)) (|l| (|PatternMatchResult| S F))
         ($ (|PatternMatchResult| S F)))
        (SPROG
         ((#1=#:G770 NIL)
          (|ex|
           (|Union|
            (|Record| (|:| |var| (|Kernel| F)) (|:| |exponent| (|Integer|)))
            #2="failed"))
          (|ep|
           (|Union|
            (|Record| (|:| |val| (|Pattern| S))
                      (|:| |exponent| (|NonNegativeInteger|)))
            "failed"))
          (|uur|
           (|Record| (|:| |val| (|Pattern| S)) (|:| |exponent| (|Pattern| S))))
          (|uu|
           (|Union|
            (|Record| (|:| |val| (|Pattern| S)) (|:| |exponent| (|Pattern| S)))
            "failed"))
          (|u| (|Union| (|List| (|Pattern| S)) "failed"))
          (|lx| (|Union| (|List| F) #2#))
          (|uq| (|Record| (|:| |num| (|Pattern| S)) (|:| |den| (|Pattern| S))))
          (|q|
           (|Union|
            (|Record| (|:| |num| (|Pattern| S)) (|:| |den| (|Pattern| S)))
            "failed"))
          (|v| (|Union| (|Kernel| F) #3="failed")) (|r| (|Union| R #3#)))
         (SEQ
          (COND
           ((SPADCALL |p| (QREFELT $ 11))
            (SPADCALL |p| |x| |l| (QREFELT $ 13)))
           (#4='T
            (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 15)))
                 (EXIT
                  (COND
                   ((QEQCAR |r| 0)
                    (SPADCALL (QCDR |r|) |p| |l| (QREFELT $ 17)))
                   (#4#
                    (SEQ (LETT |v| (SPADCALL |x| (QREFELT $ 19)))
                         (EXIT
                          (COND
                           ((QEQCAR |v| 0)
                            (SPADCALL (QCDR |v|) |p| |l| (QREFELT $ 22)))
                           (#4#
                            (SEQ (LETT |q| (SPADCALL |p| (QREFELT $ 25)))
                                 (EXIT
                                  (COND
                                   ((QEQCAR |q| 0)
                                    (SEQ (LETT |uq| (QCDR |q|))
                                         (EXIT
                                          (COND
                                           ((SPADCALL
                                             (LETT |l|
                                                   (SPADCALL
                                                    (SPADCALL |x|
                                                              (QREFELT $ 26))
                                                    (QCAR |uq|) |l|
                                                    (QREFELT $ 27)))
                                             (QREFELT $ 28))
                                            |l|)
                                           (#4#
                                            (SPADCALL
                                             (SPADCALL |x| (QREFELT $ 29))
                                             (QCDR |uq|) |l|
                                             (QREFELT $ 27)))))))
                                   (#4#
                                    (SEQ
                                     (LETT |u| (SPADCALL |p| (QREFELT $ 31)))
                                     (EXIT
                                      (COND
                                       ((QEQCAR |u| 0)
                                        (SEQ
                                         (LETT |lx|
                                               (SPADCALL |x| (QREFELT $ 32)))
                                         (EXIT
                                          (COND
                                           ((QEQCAR |lx| 0)
                                            (SPADCALL (QCDR |lx|) (QCDR |u|)
                                                      (CONS
                                                       #'|PMFS;patternMatch;FP2Pmr;1!0|
                                                       $)
                                                      |l| (ELT $ 27)
                                                      (QREFELT $ 40)))
                                           (#4#
                                            (SEQ
                                             (LETT |u|
                                                   (SPADCALL (QCDR |u|)
                                                             (QREFELT $ 42)))
                                             (EXIT
                                              (COND
                                               ((QEQCAR |u| 0)
                                                (COND
                                                 ((SPADCALL
                                                   (LETT |l|
                                                         (SPADCALL
                                                          (|SPADfirst|
                                                           (QCDR |u|))
                                                          (|spadConstant| $ 34)
                                                          |l| (QREFELT $ 13)))
                                                   (QREFELT $ 28))
                                                  (SPADCALL (QREFELT $ 43)))
                                                 (#4#
                                                  (SPADCALL |x|
                                                            (SPADCALL
                                                             (QCDR |u|)
                                                             (QREFELT $ 44))
                                                            |l|
                                                            (QREFELT $ 27)))))
                                               (#4#
                                                (SPADCALL
                                                 (QREFELT $ 43)))))))))))
                                       (#4#
                                        (SEQ
                                         (LETT |u|
                                               (SPADCALL |p| (QREFELT $ 45)))
                                         (EXIT
                                          (COND
                                           ((QEQCAR |u| 0)
                                            (SEQ
                                             (LETT |lx|
                                                   (SPADCALL |x|
                                                             (QREFELT $ 46)))
                                             (EXIT
                                              (COND
                                               ((QEQCAR |lx| 0)
                                                (SPADCALL (QCDR |lx|)
                                                          (QCDR |u|) |l|
                                                          (ELT $ 27)
                                                          (QREFELT $ 47)))
                                               (#4#
                                                (SEQ
                                                 (LETT |u|
                                                       (SPADCALL (QCDR |u|)
                                                                 (QREFELT $
                                                                          42)))
                                                 (EXIT
                                                  (COND
                                                   ((QEQCAR |u| 0)
                                                    (COND
                                                     ((SPADCALL
                                                       (LETT |l|
                                                             (SPADCALL
                                                              (|SPADfirst|
                                                               (QCDR |u|))
                                                              (|spadConstant| $
                                                                              48)
                                                              |l|
                                                              (QREFELT $ 13)))
                                                       (QREFELT $ 28))
                                                      (SPADCALL
                                                       (QREFELT $ 43)))
                                                     (#4#
                                                      (SPADCALL |x|
                                                                (SPADCALL
                                                                 (QCDR |u|)
                                                                 (QREFELT $
                                                                          44))
                                                                |l|
                                                                (QREFELT $
                                                                         27)))))
                                                   (#4#
                                                    (SPADCALL
                                                     (QREFELT $ 43)))))))))))
                                           (#4#
                                            (SEQ
                                             (LETT |uu|
                                                   (SPADCALL |p|
                                                             (QREFELT $ 51)))
                                             (EXIT
                                              (COND
                                               ((QEQCAR |uu| 0)
                                                (SEQ (LETT |uur| (QCDR |uu|))
                                                     (LETT |ex|
                                                           (SPADCALL |x|
                                                                     (QREFELT $
                                                                              54)))
                                                     (EXIT
                                                      (COND
                                                       ((QEQCAR |ex| 0)
                                                        (COND
                                                         ((SPADCALL
                                                           (LETT |l|
                                                                 (SPADCALL
                                                                  (SPADCALL
                                                                   (QCDR
                                                                    (QCDR
                                                                     |ex|))
                                                                   (QREFELT $
                                                                            56))
                                                                  (QCDR |uur|)
                                                                  |l|
                                                                  (QREFELT $
                                                                           27)))
                                                           (QREFELT $ 28))
                                                          (SPADCALL
                                                           (QREFELT $ 43)))
                                                         (#4#
                                                          (SPADCALL
                                                           (QCAR (QCDR |ex|))
                                                           (QCAR |uur|) |l|
                                                           (QREFELT $ 22)))))
                                                       ((SPADCALL (QCDR |uur|)
                                                                  (QREFELT $
                                                                           57))
                                                        (COND
                                                         ((SPADCALL
                                                           (LETT |l|
                                                                 (SPADCALL
                                                                  (QCDR |uur|)
                                                                  (|spadConstant|
                                                                   $ 48)
                                                                  |l|
                                                                  (QREFELT $
                                                                           13)))
                                                           (QREFELT $ 28))
                                                          (SPADCALL
                                                           (QREFELT $ 43)))
                                                         (#4#
                                                          (SPADCALL |x|
                                                                    (QCAR
                                                                     |uur|)
                                                                    |l|
                                                                    (QREFELT $
                                                                             27)))))
                                                       (#4#
                                                        (SPADCALL
                                                         (QREFELT $ 43)))))))
                                               (#4#
                                                (SEQ
                                                 (EXIT
                                                  (SEQ
                                                   (SEQ
                                                    (LETT |ep|
                                                          (SPADCALL |p|
                                                                    (QREFELT $
                                                                             60)))
                                                    (EXIT
                                                     (COND
                                                      ((QEQCAR |ep| 0)
                                                       (SEQ
                                                        (LETT |ex|
                                                              (SPADCALL |x|
                                                                        (QREFELT
                                                                         $
                                                                         54)))
                                                        (EXIT
                                                         (COND
                                                          ((QEQCAR |ex| 0)
                                                           (COND
                                                            ((EQL
                                                              (QCDR
                                                               (QCDR |ex|))
                                                              (QCDR
                                                               (QCDR |ep|)))
                                                             (PROGN
                                                              (LETT #1#
                                                                    (SPADCALL
                                                                     (QCAR
                                                                      (QCDR
                                                                       |ex|))
                                                                     (QCAR
                                                                      (QCDR
                                                                       |ep|))
                                                                     |l|
                                                                     (QREFELT $
                                                                              22)))
                                                              (GO
                                                               #5=#:G761))))))))))))
                                                   (EXIT
                                                    (SPADCALL
                                                     (QREFELT $ 43)))))
                                                 #5#
                                                 (EXIT
                                                  #1#))))))))))))))))))))))))))))))) 

(SDEFUN |PMFS;patternMatch;FP2Pmr;1!0| ((|l1| NIL) ($ NIL))
        (SPROG
         ((#1=#:G721 NIL) (#2=#:G720 NIL) (#3=#:G722 NIL) (#4=#:G724 NIL)
          (#5=#:G689 NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT #5# NIL) (LETT #4# |l1|) G190
                (COND
                 ((OR (ATOM #4#) (PROGN (LETT #5# (CAR #4#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #3# #5#)
                   (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 33))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 34))))))) 

(DECLAIM (NOTINLINE |PatternMatchFunctionSpace;|)) 

(DEFUN |PatternMatchFunctionSpace| (&REST #1=#:G771)
  (SPROG NIL
         (PROG (#2=#:G772)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PatternMatchFunctionSpace|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PatternMatchFunctionSpace;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|PatternMatchFunctionSpace|)))))))))) 

(DEFUN |PatternMatchFunctionSpace;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|PatternMatchFunctionSpace| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 61))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PatternMatchFunctionSpace|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PatternMatchFunctionSpace| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Boolean|) (|Pattern| 6) (0 . |generic?|)
              (|PatternMatchResult| 6 8) (5 . |addMatch|)
              (|Union| 7 '#1="failed") (12 . |retractIfCan|)
              (|PatternMatchPushDown| 6 7 8) (17 . |patternMatch|)
              (|Union| (|Kernel| $) '#1#) (24 . |retractIfCan|) (|Kernel| 8)
              (|PatternMatchKernel| 6 8) (29 . |patternMatch|)
              (|Record| (|:| |num| $) (|:| |den| $)) (|Union| 23 '"failed")
              (36 . |isQuotient|) (41 . |numerator|)
              |PMFS;patternMatch;FP2Pmr;1| (46 . |failed?|)
              (51 . |denominator|) (|Union| 41 '"failed") (56 . |isPlus|)
              (61 . |isPlus|) (66 . +) (72 . |Zero|) (|List| 8) (|List| 10)
              (|Mapping| 8 35) (|Mapping| 12 8 10 12)
              (|PatternMatchTools| 6 7 8) (76 . |patternMatch|) (|List| $)
              (85 . |optpair|) (90 . |failed|) (94 . |second|) (99 . |isTimes|)
              (104 . |isTimes|) (109 . |patternMatchTimes|) (117 . |One|)
              (|Record| (|:| |val| $) (|:| |exponent| $))
              (|Union| 49 '"failed") (121 . |isPower|)
              (|Record| (|:| |var| (|Kernel| $)) (|:| |exponent| 55))
              (|Union| 52 '"failed") (126 . |isExpt|) (|Integer|)
              (131 . |coerce|) (136 . |optional?|)
              (|Record| (|:| |val| $) (|:| |exponent| (|NonNegativeInteger|)))
              (|Union| 58 '"failed") (141 . |isExpt|))
           '#(|patternMatch| 146) 'NIL
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
                        (|makeByteWordVec2| 60
                                            '(1 10 9 0 11 3 12 0 10 8 0 13 1 8
                                              14 0 15 3 16 12 7 10 12 17 1 8 18
                                              0 19 3 21 12 20 10 12 22 1 10 24
                                              0 25 1 8 0 0 26 1 12 9 0 28 1 8 0
                                              0 29 1 10 30 0 31 1 8 30 0 32 2 8
                                              0 0 0 33 0 8 0 34 5 39 12 35 36
                                              37 12 38 40 1 10 30 41 42 0 12 0
                                              43 1 36 10 0 44 1 10 30 0 45 1 8
                                              30 0 46 4 39 12 35 36 12 38 47 0
                                              8 0 48 1 10 50 0 51 1 8 53 0 54 1
                                              8 0 55 56 1 10 9 0 57 1 10 59 0
                                              60 3 0 12 8 10 12 27)))))
           '|lookupComplete|)) 
