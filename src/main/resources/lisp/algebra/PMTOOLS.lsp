
(SDEFUN |PMTOOLS;negConstant| ((|l| (|List| P)) ($ (|Union| P "failed")))
        (SPROG
         ((#1=#:G740 NIL) (#2=#:G741 NIL) (|r| (|Union| R "failed"))
          (#3=#:G742 NIL) (|x| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ
             (EXIT
              (SEQ (LETT |x| NIL) (LETT #3# |l|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 15)))
                        (EXIT
                         (COND
                          ((QEQCAR |r| 0)
                           (COND
                            ((SPADCALL (QCDR |r|) (|spadConstant| $ 16)
                                       (QREFELT $ 18))
                             (PROGN
                              (LETT #1#
                                    (PROGN
                                     (LETT #2# (CONS 0 |x|))
                                     (GO #4=#:G739)))
                              (GO #5=#:G737))))))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
             #5# (EXIT #1#))
            (EXIT (CONS 1 "failed"))))
          #4# (EXIT #2#)))) 

(SDEFUN |PMTOOLS;tryToMatch|
        ((|lp| (|List| (|Pattern| S)))
         (|rc|
          (|Record| (|:| |res| (|PatternMatchResult| S P))
                    (|:| |s| (|List| P))))
         (|ident| (P))
         (|pmatch|
          (|Mapping| (|PatternMatchResult| S P) P (|Pattern| S)
                     (|PatternMatchResult| S P)))
         ($
          (|Union|
           #1=(|Record| (|:| |res| #2=(|PatternMatchResult| S P))
                        (|:| |s| #3=(|List| P)))
           "failed")))
        (SPROG
         ((|ls| #3#) (#4=#:G755 NIL) (|l| #2#) (|rec| #1#) (#5=#:G756 NIL)
          (|p| NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |rec| (CONS (LETT |l| (QCAR |rc|)) (LETT |ls| (QCDR |rc|))))
            (SEQ (LETT |p| NIL) (LETT #5# |lp|) G190
                 (COND
                  ((OR (ATOM #5#) (PROGN (LETT |p| (CAR #5#)) NIL)) (GO G191)))
                 (SEQ
                  (LETT |rec|
                        (|PMTOOLS;findMatch| |p| |ls| |l| |ident| |pmatch| $))
                  (EXIT
                   (COND
                    ((SPADCALL (LETT |l| (QCAR |rec|)) (QREFELT $ 20))
                     (PROGN (LETT #4# (CONS 1 "failed")) (GO #6=#:G754)))
                    ('T (LETT |ls| (QCDR |rec|))))))
                 (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
            (EXIT (CONS 0 |rec|))))
          #6# (EXIT #4#)))) 

(SDEFUN |PMTOOLS;patternMatchTimes;LLPmrMPmr;3|
        ((|ls| (|List| P)) (|lp| (|List| (|Pattern| S)))
         (|l| (|PatternMatchResult| S P))
         (|pmatch|
          (|Mapping| (|PatternMatchResult| S P) P (|Pattern| S)
                     (|PatternMatchResult| S P)))
         ($ (|PatternMatchResult| S P)))
        (SPROG ((|u| (|Union| P "failed")))
               (SEQ
                (COND
                 ((SPADCALL (QREFELT $ 13) |lp| (QREFELT $ 22))
                  (SEQ (LETT |u| (|PMTOOLS;negConstant| |ls| $))
                       (EXIT
                        (COND ((QEQCAR |u| 1) (SPADCALL (QREFELT $ 23)))
                              (#1='T
                               (SEQ
                                (COND
                                 ((SPADCALL (QCDR |u|)
                                            (SPADCALL (|spadConstant| $ 9)
                                                      (QREFELT $ 10))
                                            (QREFELT $ 24))
                                  (LETT |ls|
                                        (CONS
                                         (SPADCALL (QCDR |u|) (QREFELT $ 10))
                                         |ls|))))
                                (EXIT
                                 (SPADCALL
                                  (SPADCALL (QCDR |u|) |ls| (QREFELT $ 26))
                                  (SPADCALL (QREFELT $ 13) |lp| (QREFELT $ 27))
                                  (CONS
                                   #'|PMTOOLS;patternMatchTimes;LLPmrMPmr;3!0|
                                   $)
                                  |l| |pmatch| (QREFELT $ 31)))))))))
                 (#1#
                  (SPADCALL |ls| |lp|
                            (CONS #'|PMTOOLS;patternMatchTimes;LLPmrMPmr;3!1|
                                  $)
                            |l| |pmatch| (QREFELT $ 31))))))) 

(SDEFUN |PMTOOLS;patternMatchTimes;LLPmrMPmr;3!1| ((|l1| NIL) ($ NIL))
        (SPROG
         ((#1=#:G775 NIL) (#2=#:G774 NIL) (#3=#:G776 NIL) (#4=#:G778 NIL)
          (#5=#:G690 NIL))
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
                   (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 28))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 9))))))) 

(SDEFUN |PMTOOLS;patternMatchTimes;LLPmrMPmr;3!0| ((|l1| NIL) ($ NIL))
        (SPROG
         ((#1=#:G765 NIL) (#2=#:G764 NIL) (#3=#:G766 NIL) (#4=#:G768 NIL)
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
                   (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 28))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 9))))))) 

(SDEFUN |PMTOOLS;findMatch|
        ((|p| (|Pattern| S)) (|ls| (|List| P)) (|l| (|PatternMatchResult| S P))
         (|ident| (P))
         (|pmatch|
          (|Mapping| (|PatternMatchResult| S P) P (|Pattern| S)
                     (|PatternMatchResult| S P)))
         ($
          (|Record| (|:| |res| (|PatternMatchResult| S P))
                    (|:| |s| (|List| P)))))
        (SPROG
         ((|l1| (|PatternMatchResult| S P)) (|t| (P)) (#1=#:G796 NIL) (|x| NIL)
          (#2=#:G795 NIL) (|bad| (|List| P)))
         (SEQ
          (LETT |bad|
                (COND
                 ((SPADCALL |p| (QREFELT $ 33))
                  (SPADCALL (SPADCALL |p| (QREFELT $ 35)) |ls| (QREFELT $ 36)))
                 (#3='T NIL)))
          (LETT |l1| (SPADCALL (QREFELT $ 23)))
          (SEQ (LETT |x| NIL) (LETT #2# (SPADCALL |ls| |bad| (QREFELT $ 37)))
               G190
               (COND
                ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL)
                     (NULL
                      (SEQ (LETT |t| |x|)
                           (EXIT
                            (SPADCALL
                             (LETT |l1| (SPADCALL |x| |p| |l| |pmatch|))
                             (QREFELT $ 20))))))
                 (GO G191)))
               (SEQ (EXIT (|spadConstant| $ 16))) (LETT #2# (CDR #2#))
               (GO G190) G191 (EXIT NIL))
          (EXIT
           (COND
            ((SPADCALL |l1| (QREFELT $ 20))
             (SEQ
              (SEQ (LETT |x| NIL) (LETT #1# |bad|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL)
                         (NULL
                          (SEQ (LETT |t| |x|)
                               (EXIT
                                (SPADCALL
                                 (LETT |l1| (SPADCALL |x| |p| |l| |pmatch|))
                                 (QREFELT $ 20))))))
                     (GO G191)))
                   (SEQ (EXIT (|spadConstant| $ 16))) (LETT #1# (CDR #1#))
                   (GO G190) G191 (EXIT NIL))
              (EXIT
               (COND
                ((SPADCALL |l1| (QREFELT $ 20))
                 (CONS (SPADCALL |p| |ident| |l| |ident| (QREFELT $ 38)) |ls|))
                (#3# (CONS |l1| (SPADCALL |t| |ls| (QREFELT $ 26))))))))
            (#3# (CONS |l1| (SPADCALL |t| |ls| (QREFELT $ 26))))))))) 

(SDEFUN |PMTOOLS;preprocessList|
        ((|pattern| (|Pattern| S)) (|ls| (|List| P))
         (|l| (|PatternMatchResult| S P)) ($ (|Union| (|List| P) "failed")))
        (SPROG ((|u| (|Union| P "failed")))
               (SEQ
                (COND
                 ((SPADCALL |pattern| (QREFELT $ 33))
                  (SEQ (LETT |u| (SPADCALL |pattern| |l| (QREFELT $ 40)))
                       (EXIT
                        (COND
                         ((QEQCAR |u| 0)
                          (COND
                           ((SPADCALL (QCDR |u|) |ls| (QREFELT $ 41))
                            (CONS 0 (LIST (QCDR |u|))))
                           (#1='T (CONS 1 "failed"))))
                         (#1# (CONS 0 NIL))))))
                 (#1# (CONS 0 NIL)))))) 

(SDEFUN |PMTOOLS;filterMatchedPatterns|
        ((|lp| (|List| (|Pattern| S))) (|ls| (|List| P))
         (|l| (|PatternMatchResult| S P))
         ($
          (|Union|
           (|Record| (|:| |pat| (|List| (|Pattern| S))) (|:| |s| (|List| P)))
           "failed")))
        (SPROG
         ((#1=#:G821 NIL) (|rc| (|Union| (|List| P) "failed")) (#2=#:G822 NIL)
          (|p| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |p| NIL) (LETT #2# |lp|) G190
                 (COND
                  ((OR (ATOM #2#) (PROGN (LETT |p| (CAR #2#)) NIL)) (GO G191)))
                 (SEQ (LETT |rc| (|PMTOOLS;preprocessList| |p| |ls| |l| $))
                      (EXIT
                       (COND
                        ((QEQCAR |rc| 1)
                         (PROGN (LETT #1# (CONS 1 "failed")) (GO #3=#:G820)))
                        ((NULL (NULL (QCDR |rc|)))
                         (SEQ (LETT |lp| (SPADCALL |p| |lp| (QREFELT $ 27)))
                              (EXIT
                               (LETT |ls|
                                     (SPADCALL (|SPADfirst| (QCDR |rc|)) |ls|
                                               (QREFELT $ 26)))))))))
                 (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
            (EXIT (CONS 0 (CONS |lp| |ls|)))))
          #3# (EXIT #1#)))) 

(SDEFUN |PMTOOLS;selBestGen|
        ((|l| (|List| (|Pattern| S))) ($ (|List| (|Pattern| S))))
        (SPROG
         ((#1=#:G828 NIL) (#2=#:G829 NIL) (|ans| (|List| (|Pattern| S)))
          (#3=#:G830 NIL) (|p| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |ans| NIL)
                (SEQ (LETT |p| NIL) (LETT #3# |l|) G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |p| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL |p| (QREFELT $ 33))
                         (SEQ
                          (EXIT
                           (SEQ (LETT |ans| (LIST |p|))
                                (EXIT
                                 (COND
                                  ((NULL (SPADCALL |p| (QREFELT $ 42)))
                                   (PROGN
                                    (LETT #1#
                                          (PROGN
                                           (LETT #2# |ans|)
                                           (GO #4=#:G827)))
                                    (GO #5=#:G824)))))))
                          #5# (EXIT #1#))))))
                     (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                (EXIT |ans|)))
          #4# (EXIT #2#)))) 

(SDEFUN |PMTOOLS;patternMatch;LLMPmrMPmr;8|
        ((|ls| (|List| P)) (|lp| (|List| (|Pattern| S)))
         (|op| (|Mapping| P (|List| P))) (|l| (|PatternMatchResult| S P))
         (|pmatch|
          (|Mapping| (|PatternMatchResult| S P) P (|Pattern| S)
                     (|PatternMatchResult| S P)))
         ($ (|PatternMatchResult| S P)))
        (SPROG
         ((|rec|
           (|Record| (|:| |res| (|PatternMatchResult| S P))
                     (|:| |s| (|List| P))))
          (|u|
           (|Union|
            (|Record| (|:| |res| (|PatternMatchResult| S P))
                      (|:| |s| (|List| P)))
            "failed"))
          (|rc|
           (|Union|
            (|Record| (|:| |pat| (|List| (|Pattern| S))) (|:| |s| (|List| P)))
            "failed"))
          (|l4| #1=(|List| (|Pattern| S))) (|l3| (|List| (|Pattern| S)))
          (|l2| #1#) (|l1| #1#) (|lpm| #1#) (#2=#:G922 NIL) (|ident| (P)))
         (SEQ
          (EXIT
           (SEQ (LETT |ident| (SPADCALL NIL |op|))
                (LETT |rc| (|PMTOOLS;filterMatchedPatterns| |lp| |ls| |l| $))
                (EXIT
                 (COND
                  ((QEQCAR |rc| 1)
                   (PROGN (LETT #2# (SPADCALL (QREFELT $ 23))) (GO #3=#:G921)))
                  (#4='T
                   (SEQ (LETT |lp| (QCAR (QCDR |rc|)))
                        (LETT |ls| (QCDR (QCDR |rc|)))
                        (EXIT
                         (COND ((NULL |lp|) |l|)
                               ((>
                                 (LENGTH
                                  (LETT |lpm|
                                        (SPADCALL (ELT $ 43) |lp|
                                                  (QREFELT $ 45))))
                                 1)
                                (|error|
                                 "More than one optional pattern in sum/product"))
                               ((< (+ (LENGTH |ls|) (LENGTH |lpm|))
                                   (LENGTH |lp|))
                                (SPADCALL (QREFELT $ 23)))
                               (#4#
                                (SEQ
                                 (COND
                                  ((NULL (NULL |lpm|))
                                   (COND
                                    ((EQL (+ (LENGTH |ls|) 1) (LENGTH |lp|))
                                     (SEQ
                                      (LETT |lp|
                                            (SPADCALL (|SPADfirst| |lpm|) |lp|
                                                      (QREFELT $ 27)))
                                      (EXIT
                                       (COND
                                        ((SPADCALL
                                          (LETT |l|
                                                (SPADCALL (|SPADfirst| |lpm|)
                                                          |ident| |l|
                                                          (QREFELT $ 47)))
                                          (QREFELT $ 20))
                                         (PROGN
                                          (LETT #2# |l|)
                                          (GO #3#))))))))))
                                 (EXIT
                                  (COND
                                   ((>
                                     (LENGTH
                                      (LETT |lpm|
                                            (SPADCALL (ELT $ 48) |lp|
                                                      (QREFELT $ 45))))
                                     1)
                                    (|error|
                                     "More than one expandable pattern in sum/product"))
                                   (#4#
                                    (SEQ
                                     (COND
                                      ((> (LENGTH |ls|) (LENGTH |lp|))
                                       (COND
                                        ((NULL |lpm|)
                                         (COND
                                          ((NULL
                                            (LETT |lpm|
                                                  (|PMTOOLS;selBestGen| |lp|
                                                   $)))
                                           (EXIT
                                            (SPADCALL (QREFELT $ 23)))))))))
                                     (COND
                                      ((NULL (NULL |lpm|))
                                       (LETT |lp|
                                             (SPADCALL (|SPADfirst| |lpm|) |lp|
                                                       (QREFELT $ 27)))))
                                     (LETT |l1|
                                           (SPADCALL (ELT $ 49) |lp|
                                                     (QREFELT $ 45)))
                                     (LETT |l2|
                                           (SPADCALL
                                            (CONS
                                             #'|PMTOOLS;patternMatch;LLMPmrMPmr;8!0|
                                             $)
                                            |lp| (QREFELT $ 45)))
                                     (LETT |l3|
                                           (SPADCALL
                                            (CONS
                                             #'|PMTOOLS;patternMatch;LLMPmrMPmr;8!1|
                                             $)
                                            (SPADCALL
                                             (CONS
                                              #'|PMTOOLS;patternMatch;LLMPmrMPmr;8!2|
                                              $)
                                             |lp| (QREFELT $ 45))
                                            (QREFELT $ 54)))
                                     (LETT |l4|
                                           (SPADCALL
                                            (CONS
                                             #'|PMTOOLS;patternMatch;LLMPmrMPmr;8!3|
                                             $)
                                            |lp| (QREFELT $ 45)))
                                     (LETT |rec| (CONS |l| |ls|))
                                     (LETT |u|
                                           (|PMTOOLS;tryToMatch| |l1| |rec|
                                            |ident| |pmatch| $))
                                     (EXIT
                                      (COND
                                       ((QEQCAR |u| 1)
                                        (SPADCALL (QREFELT $ 23)))
                                       (#4#
                                        (SEQ
                                         (LETT |u|
                                               (|PMTOOLS;tryToMatch| |l2|
                                                (QCDR |u|) |ident| |pmatch| $))
                                         (EXIT
                                          (COND
                                           ((QEQCAR |u| 1)
                                            (SPADCALL (QREFELT $ 23)))
                                           (#4#
                                            (SEQ
                                             (LETT |u|
                                                   (|PMTOOLS;tryToMatch| |l3|
                                                    (QCDR |u|) |ident| |pmatch|
                                                    $))
                                             (EXIT
                                              (COND
                                               ((QEQCAR |u| 1)
                                                (SPADCALL (QREFELT $ 23)))
                                               (#4#
                                                (SEQ (LETT |rec| (QCDR |u|))
                                                     (LETT |rc|
                                                           (|PMTOOLS;filterMatchedPatterns|
                                                            |l4| (QCDR |rec|)
                                                            (QCAR |rec|) $))
                                                     (EXIT
                                                      (COND
                                                       ((QEQCAR |rc| 1)
                                                        (SPADCALL
                                                         (QREFELT $ 23)))
                                                       (#4#
                                                        (SEQ
                                                         (LETT |rec|
                                                               (CONS
                                                                (QCAR |rec|)
                                                                (QCDR
                                                                 (QCDR |rc|))))
                                                         (LETT |u|
                                                               (|PMTOOLS;tryToMatch|
                                                                (QCAR
                                                                 (QCDR |rc|))
                                                                |rec| |ident|
                                                                |pmatch| $))
                                                         (EXIT
                                                          (COND
                                                           ((QEQCAR |u| 1)
                                                            (SPADCALL
                                                             (QREFELT $ 23)))
                                                           (#4#
                                                            (SEQ
                                                             (LETT |rec|
                                                                   (QCDR |u|))
                                                             (LETT |l|
                                                                   (QCAR
                                                                    |rec|))
                                                             (LETT |ls|
                                                                   (QCDR
                                                                    |rec|))
                                                             (EXIT
                                                              (COND
                                                               ((NULL |lpm|)
                                                                (COND
                                                                 ((NULL |ls|)
                                                                  |l|)
                                                                 (#4#
                                                                  (SPADCALL
                                                                   (QREFELT $
                                                                            23)))))
                                                               (#4#
                                                                (SPADCALL
                                                                 (|SPADfirst|
                                                                  |lpm|)
                                                                 (SPADCALL |ls|
                                                                           |op|)
                                                                 |l|
                                                                 (QREFELT $
                                                                          47)))))))))))))))))))))))))))))))))))))))
          #3# (EXIT #2#)))) 

(SDEFUN |PMTOOLS;patternMatch;LLMPmrMPmr;8!3| ((|p1| NIL) ($ NIL))
        (COND
         ((SPADCALL |p1| (QREFELT $ 33))
          (COND ((SPADCALL |p1| (QREFELT $ 42)) NIL)
                ('T (NULL (SPADCALL |p1| (QREFELT $ 49))))))
         ('T NIL))) 

(SDEFUN |PMTOOLS;patternMatch;LLMPmrMPmr;8!2| ((|p1| NIL) ($ NIL))
        (COND
         ((OR (SPADCALL |p1| (QREFELT $ 42)) (SPADCALL |p1| (QREFELT $ 33)))
          NIL)
         ('T (NULL (SPADCALL |p1| (QREFELT $ 49)))))) 

(SDEFUN |PMTOOLS;patternMatch;LLMPmrMPmr;8!1| ((|z1| NIL) (|z2| NIL) ($ NIL))
        (SPADCALL (SPADCALL |z1| (QREFELT $ 51)) (SPADCALL |z2| (QREFELT $ 51))
                  (QREFELT $ 52))) 

(SDEFUN |PMTOOLS;patternMatch;LLMPmrMPmr;8!0| ((|p1| NIL) ($ NIL))
        (COND
         ((SPADCALL |p1| (QREFELT $ 42)) (NULL (SPADCALL |p1| (QREFELT $ 49))))
         ('T NIL))) 

(DECLAIM (NOTINLINE |PatternMatchTools;|)) 

(DEFUN |PatternMatchTools| (&REST #1=#:G923)
  (SPROG NIL
         (PROG (#2=#:G924)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PatternMatchTools|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PatternMatchTools;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PatternMatchTools|)))))))))) 

(DEFUN |PatternMatchTools;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|PatternMatchTools| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 55))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PatternMatchTools|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 13
                    (SPADCALL (SPADCALL (|spadConstant| $ 9) (QREFELT $ 10))
                              (QREFELT $ 12)))
          $))) 

(MAKEPROP '|PatternMatchTools| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (0 . |One|) (4 . -) (|Pattern| 6) (9 . |convert|)
              '|mn1| (|Union| 7 '"failed") (14 . |retractIfCan|) (19 . |Zero|)
              (|Boolean|) (23 . |smaller?|) (|PatternMatchResult| 6 8)
              (29 . |failed?|) (|List| 11) (34 . |member?|) (40 . |failed|)
              (44 . ~=) (|List| 8) (50 . |remove|) (56 . |remove|) (62 . *)
              (|Mapping| 8 25) (|Mapping| 19 8 11 19)
              |PMTOOLS;patternMatch;LLMPmrMPmr;8|
              |PMTOOLS;patternMatchTimes;LLPmrMPmr;3| (68 . |generic?|)
              (|PatternFunctions1| 6 8) (73 . |badValues|)
              (78 . |setIntersection|) (84 . |setDifference|)
              (90 . |addMatchRestricted|) (|Union| 8 '"failed")
              (98 . |getMatch|) (104 . |member?|) (110 . |hasPredicate?|)
              (115 . |optional?|) (|Mapping| 17 11) (120 . |select|)
              (126 . |One|) (130 . |addMatch|) (137 . |multiple?|)
              (142 . |constant?|) (|NonNegativeInteger|) (147 . |depth|)
              (152 . >) (|Mapping| 17 11 11) (158 . |sort!|))
           '#(|patternMatchTimes| 164 |patternMatch| 172) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|patternMatch|
                                 ((|PatternMatchResult| |#1| |#3|)
                                  (|List| |#3|) (|List| (|Pattern| |#1|))
                                  (|Mapping| |#3| (|List| |#3|))
                                  (|PatternMatchResult| |#1| |#3|)
                                  (|Mapping| (|PatternMatchResult| |#1| |#3|)
                                             |#3| (|Pattern| |#1|)
                                             (|PatternMatchResult| |#1|
                                                                   |#3|))))
                                T)
                              '((|patternMatchTimes|
                                 ((|PatternMatchResult| |#1| |#3|)
                                  (|List| |#3|) (|List| (|Pattern| |#1|))
                                  (|PatternMatchResult| |#1| |#3|)
                                  (|Mapping| (|PatternMatchResult| |#1| |#3|)
                                             |#3| (|Pattern| |#1|)
                                             (|PatternMatchResult| |#1|
                                                                   |#3|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 54
                                            '(0 8 0 9 1 8 0 0 10 1 8 11 0 12 1
                                              8 14 0 15 0 7 0 16 2 7 17 0 0 18
                                              1 19 17 0 20 2 21 17 11 0 22 0 19
                                              0 23 2 8 17 0 0 24 2 25 0 8 0 26
                                              2 21 0 11 0 27 2 8 0 0 0 28 1 11
                                              17 0 33 1 34 25 11 35 2 25 0 0 0
                                              36 2 25 0 0 0 37 4 19 0 11 8 0 8
                                              38 2 19 39 11 0 40 2 25 17 8 0 41
                                              1 11 17 0 42 1 11 17 0 43 2 21 0
                                              44 0 45 0 7 0 46 3 19 0 11 8 0 47
                                              1 11 17 0 48 1 11 17 0 49 1 11 50
                                              0 51 2 50 17 0 0 52 2 21 0 53 0
                                              54 4 0 19 25 21 19 30 32 5 0 19
                                              25 21 29 19 30 31)))))
           '|lookupComplete|)) 
