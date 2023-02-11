
(PUT '|RULE;pattern;$P;1| '|SPADreplace| '(XLAM (|x|) (QVELT |x| 0))) 

(SDEFUN |RULE;pattern;$P;1| ((|x| ($)) ($ (|Pattern| |Base|))) (QVELT |x| 0)) 

(PUT '|RULE;lhs;$F;2| '|SPADreplace| '(XLAM (|x|) (QVELT |x| 1))) 

(SDEFUN |RULE;lhs;$F;2| ((|x| ($)) ($ (F))) (QVELT |x| 1)) 

(PUT '|RULE;rhs;$F;3| '|SPADreplace| '(XLAM (|x|) (QVELT |x| 2))) 

(SDEFUN |RULE;rhs;$F;3| ((|x| ($)) ($ (F))) (QVELT |x| 2)) 

(PUT '|RULE;quotedOperators;$L;4| '|SPADreplace| '(XLAM (|x|) (QVELT |x| 3))) 

(SDEFUN |RULE;quotedOperators;$L;4| ((|x| ($)) ($ (|List| (|Symbol|))))
        (QVELT |x| 3)) 

(PUT '|RULE;mkRule| '|SPADreplace| 'VECTOR) 

(SDEFUN |RULE;mkRule|
        ((|pt| (|Pattern| |Base|)) (|p| (F)) (|s| (F))
         (|l| (|List| (|Symbol|))) ($ ($)))
        (VECTOR |pt| |p| |s| |l|)) 

(SDEFUN |RULE;coerce;E$;6| ((|eq| (|Equation| F)) ($ ($)))
        (SPADCALL (SPADCALL |eq| (QREFELT $ 17)) (SPADCALL |eq| (QREFELT $ 18))
                  NIL (QREFELT $ 19))) 

(SDEFUN |RULE;rule;2F$;7| ((|l| (F)) (|r| (F)) ($ ($)))
        (SPADCALL |l| |r| NIL (QREFELT $ 19))) 

(SDEFUN |RULE;elt;$2F;8| ((|r| ($)) (|s| (F)) ($ (F)))
        (SPADCALL (LIST |r|) |s| (QREFELT $ 24))) 

(SDEFUN |RULE;suchThat;$LM$;9|
        ((|x| ($)) (|l| (|List| (|Symbol|)))
         (|f| (|Mapping| (|Boolean|) (|List| F))) ($ ($)))
        (|RULE;mkRule|
         (SPADCALL (SPADCALL |x| (QREFELT $ 11)) |l| |f| (QREFELT $ 28))
         (SPADCALL |x| (QREFELT $ 12)) (SPADCALL |x| (QREFELT $ 13))
         (SPADCALL |x| (QREFELT $ 15)) $)) 

(SDEFUN |RULE;=;2$B;10| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND
         ((SPADCALL (SPADCALL |x| (QREFELT $ 12)) (SPADCALL |y| (QREFELT $ 12))
                    (QREFELT $ 31))
          (COND
           ((SPADCALL (SPADCALL |x| (QREFELT $ 13))
                      (SPADCALL |y| (QREFELT $ 13)) (QREFELT $ 31))
            (SPADCALL (SPADCALL |x| (QREFELT $ 15))
                      (SPADCALL |y| (QREFELT $ 15)) (QREFELT $ 32)))
           (#1='T NIL)))
         (#1# NIL))) 

(SDEFUN |RULE;elt;$FPiF;11|
        ((|r| ($)) (|s| (F)) (|n| (|PositiveInteger|)) ($ (F)))
        (SPADCALL (LIST |r|) |s| |n| (QREFELT $ 35))) 

(SDEFUN |RULE;F2Symbol| ((|f| (F)) ($ (F)))
        (SPROG
         ((#1=#:G726 NIL) (#2=#:G734 NIL) (|k| NIL) (#3=#:G733 NIL)
          (|l| (|List| (|Kernel| F))))
         (SEQ
          (LETT |l|
                (SPADCALL (CONS #'|RULE;F2Symbol!0| $)
                          (SPADCALL |f| (QREFELT $ 41)) (QREFELT $ 44)))
          (EXIT
           (SPADCALL |f| |l|
                     (PROGN
                      (LETT #3# NIL)
                      (SEQ (LETT |k| NIL) (LETT #2# |l|) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |k| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #3#
                                   (CONS
                                    (SPADCALL
                                     (PROG2
                                         (LETT #1#
                                               (SPADCALL |k| (QREFELT $ 39)))
                                         (QCDR #1#)
                                       (|check_union2| (QEQCAR #1# 0)
                                                       (|Symbol|)
                                                       (|Union| (|Symbol|)
                                                                "failed")
                                                       #1#))
                                     (QREFELT $ 46))
                                    #3#))))
                           (LETT #2# (CDR #2#)) (GO G190) G191
                           (EXIT (NREVERSE #3#))))
                     (QREFELT $ 48)))))) 

(SDEFUN |RULE;F2Symbol!0| ((|z| NIL) ($ NIL))
        (QEQCAR (SPADCALL |z| (QREFELT $ 39)) 0)) 

(SDEFUN |RULE;retractIfCan;$U;13|
        ((|r| ($)) ($ (|Union| (|Equation| F) #1="failed")))
        (SPROG ((|u| (|Union| (|Kernel| F) #1#)))
               (SEQ
                (COND
                 ((SPADCALL (SPADCALL |r| (QREFELT $ 11)) (QREFELT $ 49))
                  (SEQ
                   (LETT |u|
                         (SPADCALL (SPADCALL |r| (QREFELT $ 12))
                                   (QREFELT $ 51)))
                   (EXIT
                    (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                          (#2='T
                           (CONS 0
                                 (SPADCALL
                                  (|RULE;F2Symbol|
                                   (SPADCALL (QCDR |u|) (QREFELT $ 53)) $)
                                  (SPADCALL |r| (QREFELT $ 13))
                                  (QREFELT $ 54))))))))
                 (#2# (CONS 1 "failed")))))) 

(SDEFUN |RULE;rule;2FL$;14|
        ((|p| (F)) (|s| (F)) (|l| (|List| (|Symbol|))) ($ ($)))
        (SPROG
         ((|lh| (|Record| (|:| |plus| F) (|:| |times| F)))
          (|pt| (|Pattern| |Base|)))
         (SEQ
          (LETT |lh|
                (|RULE;transformLhs| (LETT |pt| (SPADCALL |p| (QREFELT $ 57)))
                 $))
          (EXIT
           (|RULE;mkRule|
            (SPADCALL (|RULE;opt| (QCDR |lh|) $)
                      (SPADCALL (|RULE;opt| (QCAR |lh|) $) |pt| (QREFELT $ 58))
                      (QREFELT $ 59))
            (SPADCALL (QCDR |lh|) (SPADCALL (QCAR |lh|) |p| (QREFELT $ 60))
                      (QREFELT $ 61))
            (SPADCALL (QCDR |lh|) (SPADCALL (QCAR |lh|) |s| (QREFELT $ 60))
                      (QREFELT $ 61))
            |l| $))))) 

(SDEFUN |RULE;opt| ((|f| (F)) ($ (|Pattern| |Base|)))
        (COND
         ((QEQCAR (SPADCALL |f| (QREFELT $ 63)) 0)
          (SPADCALL |f| (QREFELT $ 57)))
         ('T (SPADCALL (SPADCALL |f| (QREFELT $ 65)) (QREFELT $ 57))))) 

(SDEFUN |RULE;appear?|
        ((|x| (|Pattern| |Base|)) (|l| (|List| (|Pattern| |Base|)))
         ($ (|Boolean|)))
        (SPROG ((#1=#:G764 NIL) (#2=#:G765 NIL) (#3=#:G766 NIL) (|p| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |p| NIL) (LETT #3# |l|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |p| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |p| |x| (QREFELT $ 66))
                             (COND
                              ((SPADCALL |x| (SPADCALL |p| (QREFELT $ 67))
                                         (QREFELT $ 69))
                               (PROGN
                                (LETT #1# (PROGN (LETT #2# 'T) (GO #4=#:G763)))
                                (GO #5=#:G761))))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT NIL)))
                #4# (EXIT #2#)))) 

(SDEFUN |RULE;bad?|
        ((|u| (|Union| (|List| (|Pattern| |Base|)) "failed")) ($ (|Boolean|)))
        (SPROG ((#1=#:G776 NIL) (#2=#:G777 NIL) (#3=#:G778 NIL) (|x| NIL))
               (SEQ
                (EXIT
                 (COND
                  ((QEQCAR |u| 0)
                   (SEQ
                    (SEQ
                     (EXIT
                      (SEQ (LETT |x| NIL) (LETT #3# (QCDR |u|)) G190
                           (COND
                            ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL |x| (QREFELT $ 70))
                               (COND
                                ((NULL (|RULE;appear?| |x| (QCDR |u|) $))
                                 (PROGN
                                  (LETT #1#
                                        (PROGN (LETT #2# NIL) (GO #4=#:G775)))
                                  (GO #5=#:G773))))))))
                           (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                     #5# (EXIT #1#))
                    (EXIT 'T)))
                  ('T NIL)))
                #4# (EXIT #2#)))) 

(SDEFUN |RULE;transformLhs|
        ((|p| (|Pattern| |Base|))
         ($ (|Record| (|:| |plus| F) (|:| |times| F))))
        (COND
         ((|RULE;bad?| (SPADCALL |p| (QREFELT $ 72)) $)
          (CONS (SPADCALL (SPADCALL (QREFELT $ 73)) (QREFELT $ 46))
                (|spadConstant| $ 74)))
         ((|RULE;bad?| (SPADCALL |p| (QREFELT $ 75)) $)
          (CONS (|spadConstant| $ 77)
                (SPADCALL (SPADCALL (QREFELT $ 73)) (QREFELT $ 46))))
         ('T (CONS (|spadConstant| $ 77) (|spadConstant| $ 74))))) 

(SDEFUN |RULE;coerce;$Of;19| ((|x| ($)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL '== (QREFELT $ 79))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 12)) (QREFELT $ 80))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 13)) (QREFELT $ 80))
                  (QREFELT $ 81))) 

(DECLAIM (NOTINLINE |RewriteRule;|)) 

(DEFUN |RewriteRule| (&REST #1=#:G794)
  (SPROG NIL
         (PROG (#2=#:G795)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|RewriteRule|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |RewriteRule;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|RewriteRule|)))))))))) 

(DEFUN |RewriteRule;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|RewriteRule| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 86))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RewriteRule| (LIST DV$1 DV$2 DV$3)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9
                    (|Record| (|:| |pat| (|Pattern| |#1|)) (|:| |lft| |#3|)
                              (|:| |rgt| |#3|)
                              (|:| |qot| (|List| (|Symbol|)))))
          $))) 

(MAKEPROP '|RewriteRule| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) '|Rep| (|Pattern| 6) |RULE;pattern;$P;1|
              |RULE;lhs;$F;2| |RULE;rhs;$F;3| (|List| 45)
              |RULE;quotedOperators;$L;4| (|Equation| 8) (0 . |lhs|)
              (5 . |rhs|) |RULE;rule;2FL$;14| |RULE;coerce;E$;6|
              |RULE;rule;2F$;7| (|List| (|RewriteRule| 6 7 8))
              (|ApplyRules| 6 7 8) (10 . |applyRules|) |RULE;elt;$2F;8|
              (|Mapping| 30 (|List| 8)) (|PatternFunctions1| 6 8)
              (16 . |suchThat|) |RULE;suchThat;$LM$;9| (|Boolean|) (23 . =)
              (29 . =) |RULE;=;2$B;10| (|PositiveInteger|) (35 . |applyRules|)
              |RULE;elt;$FPiF;11| (|Union| 45 '"failed") (|Kernel| 8)
              (42 . |symbolIfCan|) (|List| 52) (47 . |tower|) (|Mapping| 30 38)
              (|List| 38) (52 . |select!|) (|Symbol|) (58 . |coerce|)
              (|List| $) (63 . |eval|) (70 . |constant?|)
              (|Union| 52 '#1="failed") (75 . |retractIfCan|) (|Kernel| $)
              (80 . |coerce|) (85 . =) (|Union| 16 '#1#)
              |RULE;retractIfCan;$U;13| (91 . |convert|) (96 . +) (102 . *)
              (108 . +) (114 . *) (|Union| 7 '#1#) (120 . |retractIfCan|)
              (|FunctionSpaceAssertions| 7 8) (125 . |optional|) (130 . ~=)
              (136 . |variables|) (|List| 10) (141 . |member?|)
              (147 . |generic?|) (|Union| 47 '"failed") (152 . |isPlus|)
              (157 . |new|) (161 . |One|) (165 . |isTimes|) (170 . |Zero|)
              (174 . |Zero|) (|OutputForm|) (178 . |coerce|) (183 . |coerce|)
              (188 . |infix|) |RULE;coerce;$Of;19| (|String|) (|SingleInteger|)
              (|HashState|))
           '#(~= 195 |suchThat| 201 |rule| 208 |rhs| 221 |retractIfCan| 226
              |retract| 231 |quotedOperators| 236 |pattern| 241 |lhs| 246
              |latex| 251 |hashUpdate!| 256 |hash| 262 |elt| 267 |coerce| 280 =
              290)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0))
                 (CONS
                  '#(|SetCategory&| |RetractableTo&| |BasicType&| NIL NIL NIL)
                  (CONS
                   '#((|SetCategory|) (|RetractableTo| (|Equation| 8))
                      (|BasicType|) (|CoercibleFrom| (|Equation| 8))
                      (|Eltable| 8 8) (|CoercibleTo| 78))
                   (|makeByteWordVec2| 85
                                       '(1 16 8 0 17 1 16 8 0 18 2 23 8 22 8 24
                                         3 27 10 10 14 26 28 2 8 30 0 0 31 2 14
                                         30 0 0 32 3 23 8 22 8 34 35 1 38 37 0
                                         39 1 8 40 0 41 2 43 0 42 0 44 1 8 0 45
                                         46 3 8 0 0 40 47 48 1 10 30 0 49 1 8
                                         50 0 51 1 8 0 52 53 2 16 0 8 8 54 1 8
                                         10 0 57 2 10 0 0 0 58 2 10 0 0 0 59 2
                                         8 0 0 0 60 2 8 0 0 0 61 1 8 62 0 63 1
                                         64 8 8 65 2 10 30 0 0 66 1 10 47 0 67
                                         2 68 30 10 0 69 1 10 30 0 70 1 10 71 0
                                         72 0 45 0 73 0 8 0 74 1 10 71 0 75 0 7
                                         0 76 0 8 0 77 1 45 78 0 79 1 8 78 0 80
                                         3 78 0 0 0 0 81 2 0 30 0 0 1 3 0 0 0
                                         14 26 29 3 0 0 8 8 14 19 2 0 0 8 8 21
                                         1 0 8 0 13 1 0 55 0 56 1 0 16 0 1 1 0
                                         14 0 15 1 0 10 0 11 1 0 8 0 12 1 0 83
                                         0 1 2 0 85 85 0 1 1 0 84 0 1 3 0 8 0 8
                                         34 36 2 0 8 0 8 25 1 0 0 16 20 1 0 78
                                         0 82 2 0 30 0 0 33)))))
           '|lookupComplete|)) 
