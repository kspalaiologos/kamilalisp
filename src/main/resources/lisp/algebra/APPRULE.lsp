
(SDEFUN |APPRULE;applist|
        ((|lrule| (|List| (|RewriteRule| |Base| R F))) (|arglist| (|List| F))
         ($ (|List| F)))
        (SPROG ((#1=#:G705 NIL) (|arg| NIL) (#2=#:G704 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |arg| NIL) (LETT #1# |arglist|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |arg| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (|APPRULE;app| |lrule| |arg| $) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |APPRULE;splitRules|
        ((|l| (|List| (|RewriteRule| |Base| R F)))
         ($
          (|Record| (|:| |lker| (|List| (|Kernel| F))) (|:| |lval| (|List| F))
                    (|:| |rl| (|List| (|RewriteRule| |Base| R F))))))
        (SPROG
         ((|lv| (|List| F)) (|lk| (|List| (|Kernel| F)))
          (|ncr| (|List| (|RewriteRule| |Base| R F)))
          (|u| (|Union| (|Equation| F) "failed")) (#1=#:G719 NIL) (|r| NIL))
         (SEQ (LETT |ncr| NIL) (LETT |lk| NIL) (LETT |lv| NIL)
              (SEQ (LETT |r| NIL) (LETT #1# |l|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |r| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |u| (SPADCALL |r| (QREFELT $ 11)))
                        (EXIT
                         (COND ((QEQCAR |u| 1) (LETT |ncr| (CONS |r| |ncr|)))
                               ('T
                                (SEQ
                                 (LETT |lk|
                                       (CONS
                                        (SPADCALL
                                         (SPADCALL (QCDR |u|) (QREFELT $ 13))
                                         (QREFELT $ 15))
                                        |lk|))
                                 (EXIT
                                  (LETT |lv|
                                        (CONS
                                         (SPADCALL (QCDR |u|) (QREFELT $ 16))
                                         |lv|))))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (VECTOR |lk| |lv| |ncr|))))) 

(SDEFUN |APPRULE;applyRules;L2F;3|
        ((|l| (|List| (|RewriteRule| |Base| R F))) (|s| (F)) ($ (F)))
        (SPROG
         ((#1=#:G728 NIL) (|new| (F))
          (|rec|
           (|Record| (|:| |lker| (|List| (|Kernel| F))) (|:| |lval| (|List| F))
                     (|:| |rl| (|List| (|RewriteRule| |Base| R F))))))
         (SEQ
          (EXIT
           (SEQ (LETT |rec| (|APPRULE;splitRules| |l| $))
                (EXIT
                 (SEQ G190 NIL
                      (SEQ
                       (LETT |new|
                             (|APPRULE;localApply| (QVELT |rec| 0)
                              (QVELT |rec| 1) (QVELT |rec| 2) |s| 1 $))
                       (EXIT
                        (COND
                         ((SPADCALL |new| |s| (QREFELT $ 18))
                          (PROGN (LETT #1# |s|) (GO #2=#:G727)))
                         ('T (LETT |s| |new|)))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #2# (EXIT #1#)))) 

(SDEFUN |APPRULE;applyRules;LFPiF;4|
        ((|l| (|List| (|RewriteRule| |Base| R F))) (|s| (F))
         (|n| (|PositiveInteger|)) ($ (F)))
        (SPROG
         ((|rec|
           (|Record| (|:| |lker| (|List| (|Kernel| F))) (|:| |lval| (|List| F))
                     (|:| |rl| (|List| (|RewriteRule| |Base| R F))))))
         (SEQ (LETT |rec| (|APPRULE;splitRules| |l| $))
              (EXIT
               (|APPRULE;localApply| (QVELT |rec| 0) (QVELT |rec| 1)
                (QVELT |rec| 2) |s| |n| $))))) 

(SDEFUN |APPRULE;localApply|
        ((|lk| (|List| (|Kernel| F))) (|lv| (|List| F))
         (|lrule| (|List| (|RewriteRule| |Base| R F))) (|subject| (F))
         (|n| (|PositiveInteger|)) ($ (F)))
        (SPROG
         ((#1=#:G742 NIL) (|k| NIL) (#2=#:G743 NIL) (|v| NIL) (#3=#:G741 NIL)
          (|i| NIL))
         (SEQ
          (SEQ (LETT |i| 1) (LETT #3# |n|) G190
               (COND ((|greater_SI| |i| #3#) (GO G191)))
               (SEQ
                (SEQ (LETT |v| NIL) (LETT #2# |lv|) (LETT |k| NIL)
                     (LETT #1# |lk|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL)
                           (ATOM #2#) (PROGN (LETT |v| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |subject|
                             (SPADCALL |subject| |k| |v| (QREFELT $ 23)))))
                     (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                     (GO G190) G191 (EXIT NIL))
                (EXIT (LETT |subject| (|APPRULE;app| |lrule| |subject| $))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT |subject|)))) 

(SDEFUN |APPRULE;rewrite|
        ((|f| (F)) (|res| (|PatternMatchResult| |Base| F))
         (|l| (|List| (|Symbol|))) ($ (F)))
        (SPROG
         ((|lv| (|List| F)) (|lk| (|List| (|Kernel| F))) (#1=#:G750 NIL)
          (|rec| NIL))
         (SEQ (LETT |lk| NIL) (LETT |lv| NIL)
              (SEQ (LETT |rec| NIL) (LETT #1# (SPADCALL |res| (QREFELT $ 27)))
                   G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |rec| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (LETT |lk|
                          (CONS (SPADCALL (QCAR |rec|) (QREFELT $ 30)) |lk|))
                    (EXIT (LETT |lv| (CONS (QCDR |rec|) |lv|))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |f| |lk| |lv| (QREFELT $ 33)))))) 

(SDEFUN |APPRULE;isitwithpred|
        ((|subject| (F)) (|pat| (|Pattern| |Base|))
         (|vars| (|List| (|Pattern| |Base|)))
         (|bad| (|List| (|PatternMatchResult| |Base| F)))
         ($ (|PatternMatchResult| |Base| F)))
        (SPROG
         ((#1=#:G757 NIL) (#2=#:G765 NIL) (|v| NIL) (#3=#:G753 NIL)
          (|u| (|PatternMatchResult| |Base| F)))
         (SEQ
          (COND
           ((OR
             (SPADCALL
              (LETT |u|
                    (SPADCALL |subject| |pat| (SPADCALL (QREFELT $ 34))
                              (QREFELT $ 37)))
              (QREFELT $ 38))
             (PROG2 (LETT #3# (SPADCALL |u| |pat| (QREFELT $ 40)))
                 (QCDR #3#)
               (|check_union2| (QEQCAR #3# 0) (|Boolean|)
                               (|Union| (|Boolean|) "failed") #3#)))
            |u|)
           ((SPADCALL |u| |bad| (QREFELT $ 42)) (SPADCALL (QREFELT $ 43)))
           ('T
            (SEQ
             (SEQ (LETT |v| NIL) (LETT #2# |vars|) G190
                  (COND
                   ((OR (ATOM #2#) (PROGN (LETT |v| (CAR #2#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (SPADCALL |v|
                              (PROG2
                                  (LETT #1# (SPADCALL |v| |u| (QREFELT $ 45)))
                                  (QCDR #1#)
                                (|check_union2| (QEQCAR #1# 0) (QREFELT $ 8)
                                                (|Union| (QREFELT $ 8)
                                                         "failed")
                                                #1#))
                              (QREFELT $ 47))))
                  (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
             (EXIT
              (|APPRULE;isitwithpred| |subject| |pat| |vars| (CONS |u| |bad|)
               $)))))))) 

(SDEFUN |APPRULE;isit|
        ((|subject| (F)) (|pat| (|Pattern| |Base|))
         ($ (|PatternMatchResult| |Base| F)))
        (SPROG ((#1=#:G771 NIL) (|l| (|List| (|Pattern| |Base|))) (|v| NIL))
               (SEQ
                (COND
                 ((SPADCALL |pat| (QREFELT $ 48))
                  (SEQ
                   (SEQ (LETT |v| NIL)
                        (LETT #1# (LETT |l| (SPADCALL |pat| (QREFELT $ 49))))
                        G190
                        (COND
                         ((OR (ATOM #1#) (PROGN (LETT |v| (CAR #1#)) NIL))
                          (GO G191)))
                        (SEQ (EXIT (SPADCALL |v| (QREFELT $ 50))))
                        (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                   (EXIT (|APPRULE;isitwithpred| |subject| |pat| |l| NIL $))))
                 ('T
                  (SPADCALL |subject| |pat| (SPADCALL (QREFELT $ 34))
                            (QREFELT $ 37))))))) 

(SDEFUN |APPRULE;app|
        ((|lrule| (|List| (|RewriteRule| |Base| R F))) (|subject| (F)) ($ (F)))
        (SPROG
         ((#1=#:G797 NIL) (#2=#:G794 NIL) (#3=#:G792 NIL) (|f| (F))
          (|ee| (|Record| (|:| |val| F) (|:| |exponent| (|Integer|))))
          (|e|
           (|Union| (|Record| (|:| |val| F) (|:| |exponent| (|Integer|)))
                    #4="failed"))
          (#5=#:G785 NIL) (#6=#:G784 (F)) (#7=#:G786 (F)) (#8=#:G808 NIL)
          (#9=#:G690 NIL) (|l| (|Union| (|List| F) #4#)) (#10=#:G782 NIL)
          (#11=#:G781 (F)) (#12=#:G783 (F)) (#13=#:G807 NIL) (#14=#:G689 NIL)
          (|k| (|Union| (|Kernel| F) "failed")) (#15=#:G804 NIL)
          (#16=#:G805 NIL) (|u| (|PatternMatchResult| |Base| F))
          (#17=#:G806 NIL) (|r| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ
             (EXIT
              (SEQ (LETT |r| NIL) (LETT #17# |lrule|) G190
                   (COND
                    ((OR (ATOM #17#) (PROGN (LETT |r| (CAR #17#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((NULL
                        (SPADCALL
                         (LETT |u|
                               (|APPRULE;isit| |subject|
                                (SPADCALL |r| (QREFELT $ 51)) $))
                         (QREFELT $ 38)))
                       (PROGN
                        (LETT #15#
                              (PROGN
                               (LETT #16#
                                     (|APPRULE;rewrite|
                                      (SPADCALL |r| (QREFELT $ 52)) |u|
                                      (SPADCALL |r| (QREFELT $ 54)) $))
                               (GO #18=#:G803)))
                        (GO #19=#:G774))))))
                   (LETT #17# (CDR #17#)) (GO G190) G191 (EXIT NIL)))
             #19# (EXIT #15#))
            (LETT |k| (SPADCALL |subject| (QREFELT $ 56)))
            (EXIT
             (COND
              ((QEQCAR |k| 0)
               (SPADCALL (SPADCALL (QCDR |k|) (QREFELT $ 58))
                         (|APPRULE;applist| |lrule|
                          (SPADCALL (QCDR |k|) (QREFELT $ 60)) $)
                         (QREFELT $ 61)))
              (#20='T
               (SEQ (LETT |l| (SPADCALL |subject| (QREFELT $ 63)))
                    (EXIT
                     (COND
                      ((QEQCAR |l| 0)
                       (PROGN
                        (LETT #10# NIL)
                        (SEQ (LETT #14# NIL)
                             (LETT #13#
                                   (|APPRULE;applist| |lrule| (QCDR |l|) $))
                             G190
                             (COND
                              ((OR (ATOM #13#)
                                   (PROGN (LETT #14# (CAR #13#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (PROGN
                                (LETT #12# #14#)
                                (COND
                                 (#10#
                                  (LETT #11#
                                        (SPADCALL #11# #12# (QREFELT $ 64))))
                                 ('T
                                  (PROGN (LETT #11# #12#) (LETT #10# 'T)))))))
                             (LETT #13# (CDR #13#)) (GO G190) G191 (EXIT NIL))
                        (COND (#10# #11#) (#20# (|spadConstant| $ 65)))))
                      (#20#
                       (SEQ (LETT |l| (SPADCALL |subject| (QREFELT $ 66)))
                            (EXIT
                             (COND
                              ((QEQCAR |l| 0)
                               (PROGN
                                (LETT #5# NIL)
                                (SEQ (LETT #9# NIL)
                                     (LETT #8#
                                           (|APPRULE;applist| |lrule|
                                            (QCDR |l|) $))
                                     G190
                                     (COND
                                      ((OR (ATOM #8#)
                                           (PROGN (LETT #9# (CAR #8#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (PROGN
                                        (LETT #7# #9#)
                                        (COND
                                         (#5#
                                          (LETT #6#
                                                (SPADCALL #6# #7#
                                                          (QREFELT $ 67))))
                                         ('T
                                          (PROGN
                                           (LETT #6# #7#)
                                           (LETT #5# 'T)))))))
                                     (LETT #8# (CDR #8#)) (GO G190) G191
                                     (EXIT NIL))
                                (COND (#5# #6#) (#20# (|spadConstant| $ 68)))))
                              (#20#
                               (SEQ
                                (LETT |e| (SPADCALL |subject| (QREFELT $ 71)))
                                (EXIT
                                 (COND
                                  ((QEQCAR |e| 0)
                                   (SEQ (LETT |ee| (QCDR |e|))
                                        (LETT |f|
                                              (|APPRULE;app| |lrule|
                                               (QCAR |ee|) $))
                                        (EXIT
                                         (COND
                                          ((PLUSP (QCDR |ee|))
                                           (SPADCALL |f|
                                                     (PROG1
                                                         (LETT #3# (QCDR |ee|))
                                                       (|check_subtype2|
                                                        (>= #3# 0)
                                                        '(|NonNegativeInteger|)
                                                        '(|Integer|) #3#))
                                                     (QREFELT $ 73)))
                                          (#20#
                                           (SPADCALL
                                            (PROG2
                                                (LETT #2#
                                                      (SPADCALL |f|
                                                                (QREFELT $
                                                                         75)))
                                                (QCDR #2#)
                                              (|check_union2| (QEQCAR #2# 0)
                                                              (QREFELT $ 8)
                                                              (|Union|
                                                               (QREFELT $ 8)
                                                               "failed")
                                                              #2#))
                                            (PROG1 (LETT #1# (- (QCDR |ee|)))
                                              (|check_subtype2| (>= #1# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #1#))
                                            (QREFELT $ 73)))))))
                                  (#20# |subject|)))))))))))))))))
          #18# (EXIT #16#)))) 

(DECLAIM (NOTINLINE |ApplyRules;|)) 

(DEFUN |ApplyRules| (&REST #1=#:G809)
  (SPROG NIL
         (PROG (#2=#:G810)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ApplyRules|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ApplyRules;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|ApplyRules|)))))))))) 

(DEFUN |ApplyRules;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|ApplyRules| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 76))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ApplyRules| (LIST DV$1 DV$2 DV$3)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ApplyRules| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Union| 12 '"failed") (|RewriteRule| 6 7 8)
              (0 . |retractIfCan|) (|Equation| 8) (5 . |lhs|) (|Kernel| $)
              (10 . |retract|) (15 . |rhs|) (|Boolean|) (20 . =) (|List| 10)
              |APPRULE;applyRules;L2F;3| (|PositiveInteger|)
              |APPRULE;applyRules;LFPiF;4| (26 . |eval|)
              (|Record| (|:| |key| 28) (|:| |entry| 8)) (|List| 24)
              (|PatternMatchResult| 6 8) (33 . |destruct|) (|Symbol|)
              (|Kernel| 8) (38 . |kernel|) (|List| 14) (|List| $) (43 . |eval|)
              (50 . |new|) (|PatternMatchResult| 6 $) (|Pattern| 6)
              (54 . |patternMatch|) (61 . |failed?|) (|Union| 17 '"failed")
              (66 . |satisfy?|) (|List| 26) (72 . |member?|) (78 . |failed|)
              (|Union| 8 '"failed") (82 . |getMatch|) (|PatternFunctions1| 6 8)
              (88 . |addBadValue|) (94 . |hasTopPredicate?|) (99 . |variables|)
              (104 . |resetBadValues|) (109 . |pattern|) (114 . |rhs|)
              (|List| 28) (119 . |quotedOperators|) (|Union| 14 '"failed")
              (124 . |retractIfCan|) (|BasicOperator|) (129 . |operator|)
              (|List| 8) (134 . |argument|) (139 . |elt|)
              (|Union| 32 '#1="failed") (145 . |isPlus|) (150 . +)
              (156 . |Zero|) (160 . |isTimes|) (165 . *) (171 . |One|)
              (|Record| (|:| |val| $) (|:| |exponent| (|Integer|)))
              (|Union| 69 '#1#) (175 . |isPower|) (|NonNegativeInteger|)
              (180 . ^) (|Union| $ '"failed") (186 . |recip|))
           '#(|applyRules| 191) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|applyRules|
                                 (|#3| (|List| (|RewriteRule| |#1| |#2| |#3|))
                                  |#3|))
                                T)
                              '((|applyRules|
                                 (|#3| (|List| (|RewriteRule| |#1| |#2| |#3|))
                                  |#3| (|PositiveInteger|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 75
                                            '(1 10 9 0 11 1 12 8 0 13 1 8 14 0
                                              15 1 12 8 0 16 2 8 17 0 0 18 3 8
                                              0 0 14 0 23 1 26 25 0 27 1 29 0
                                              28 30 3 8 0 0 31 32 33 0 26 0 34
                                              3 8 35 0 36 35 37 1 26 17 0 38 2
                                              26 39 0 36 40 2 41 17 26 0 42 0
                                              26 0 43 2 26 44 36 0 45 2 46 36
                                              36 8 47 1 36 17 0 48 1 36 32 0 49
                                              1 36 0 0 50 1 10 36 0 51 1 10 8 0
                                              52 1 10 53 0 54 1 8 55 0 56 1 29
                                              57 0 58 1 29 59 0 60 2 8 0 57 32
                                              61 1 8 62 0 63 2 8 0 0 0 64 0 8 0
                                              65 1 8 62 0 66 2 8 0 0 0 67 0 8 0
                                              68 1 8 70 0 71 2 8 0 0 72 73 1 8
                                              74 0 75 3 0 8 19 8 21 22 2 0 8 19
                                              8 20)))))
           '|lookupComplete|)) 
