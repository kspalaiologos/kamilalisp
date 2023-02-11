
(SDEFUN |PATTERN2;map;MPP;1|
        ((|f| (|Mapping| S R)) (|p| (|Pattern| R)) ($ (|Pattern| S)))
        (SPROG
         ((|sy| (|Symbol|))
          (|wr|
           (|Record| (|:| |val| (|Pattern| R))
                     (|:| |exponent| (|NonNegativeInteger|))))
          (|w|
           (|Union|
            (|Record| (|:| |val| (|Pattern| R))
                      (|:| |exponent| (|NonNegativeInteger|)))
            "failed"))
          (|xr|
           (|Record| (|:| |val| (|Pattern| R)) (|:| |exponent| (|Pattern| R))))
          (|x|
           (|Union|
            (|Record| (|:| |val| (|Pattern| R)) (|:| |exponent| (|Pattern| R)))
            "failed"))
          (#1=#:G757 NIL) (#2=#:G756 NIL)
          (|l| (|Union| (|List| (|Pattern| R)) "failed")) (#3=#:G755 NIL)
          (#4=#:G754 NIL)
          (|vr| (|Record| (|:| |num| (|Pattern| R)) (|:| |den| (|Pattern| R))))
          (|v|
           (|Union|
            (|Record| (|:| |num| (|Pattern| R)) (|:| |den| (|Pattern| R)))
            "failed"))
          (#5=#:G753 NIL) (#6=#:G752 NIL)
          (|ur|
           (|Record| (|:| |op| (|BasicOperator|))
                     (|:| |arg| (|List| (|Pattern| R)))))
          (|u|
           (|Union|
            (|Record| (|:| |op| (|BasicOperator|))
                      (|:| |arg| (|List| (|Pattern| R))))
            "failed"))
          (|r| (|Union| R "failed")))
         (SEQ (LETT |r| (SPADCALL |p| (QREFELT $ 10)))
              (EXIT
               (COND
                ((QEQCAR |r| 0)
                 (SPADCALL (SPADCALL (QCDR |r|) |f|) (QREFELT $ 12)))
                (#7='T
                 (SEQ (LETT |u| (SPADCALL |p| (QREFELT $ 15)))
                      (EXIT
                       (COND
                        ((QEQCAR |u| 0)
                         (SEQ (LETT |ur| (QCDR |u|))
                              (EXIT
                               (SPADCALL (QCAR |ur|)
                                         (PROGN
                                          (LETT #6# NIL)
                                          (SEQ (LETT #5# (QCDR |ur|)) G190
                                               (COND
                                                ((OR (ATOM #5#)
                                                     (PROGN
                                                      (LETT |x| (CAR #5#))
                                                      NIL))
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (LETT #6#
                                                       (CONS
                                                        (SPADCALL |f| |x|
                                                                  (QREFELT $
                                                                           17))
                                                        #6#))))
                                               (LETT #5# (CDR #5#)) (GO G190)
                                               G191 (EXIT (NREVERSE #6#))))
                                         (QREFELT $ 20)))))
                        (#7#
                         (SEQ (LETT |v| (SPADCALL |p| (QREFELT $ 23)))
                              (EXIT
                               (COND
                                ((QEQCAR |v| 0)
                                 (SEQ (LETT |vr| (QCDR |v|))
                                      (EXIT
                                       (SPADCALL
                                        (SPADCALL |f| (QCAR |vr|)
                                                  (QREFELT $ 17))
                                        (SPADCALL |f| (QCDR |vr|)
                                                  (QREFELT $ 17))
                                        (QREFELT $ 24)))))
                                (#7#
                                 (SEQ (LETT |l| (SPADCALL |p| (QREFELT $ 26)))
                                      (EXIT
                                       (COND
                                        ((QEQCAR |l| 0)
                                         (SPADCALL (ELT $ 27)
                                                   (PROGN
                                                    (LETT #4# NIL)
                                                    (SEQ (LETT #3# (QCDR |l|))
                                                         G190
                                                         (COND
                                                          ((OR (ATOM #3#)
                                                               (PROGN
                                                                (LETT |x|
                                                                      (CAR
                                                                       #3#))
                                                                NIL))
                                                           (GO G191)))
                                                         (SEQ
                                                          (EXIT
                                                           (LETT #4#
                                                                 (CONS
                                                                  (SPADCALL |f|
                                                                            |x|
                                                                            (QREFELT
                                                                             $
                                                                             17))
                                                                  #4#))))
                                                         (LETT #3# (CDR #3#))
                                                         (GO G190) G191
                                                         (EXIT
                                                          (NREVERSE #4#))))
                                                   (QREFELT $ 30)))
                                        (#7#
                                         (SEQ
                                          (LETT |l|
                                                (SPADCALL |p| (QREFELT $ 31)))
                                          (EXIT
                                           (COND
                                            ((QEQCAR |l| 0)
                                             (SPADCALL (ELT $ 32)
                                                       (PROGN
                                                        (LETT #2# NIL)
                                                        (SEQ
                                                         (LETT #1# (QCDR |l|))
                                                         G190
                                                         (COND
                                                          ((OR (ATOM #1#)
                                                               (PROGN
                                                                (LETT |x|
                                                                      (CAR
                                                                       #1#))
                                                                NIL))
                                                           (GO G191)))
                                                         (SEQ
                                                          (EXIT
                                                           (LETT #2#
                                                                 (CONS
                                                                  (SPADCALL |f|
                                                                            |x|
                                                                            (QREFELT
                                                                             $
                                                                             17))
                                                                  #2#))))
                                                         (LETT #1# (CDR #1#))
                                                         (GO G190) G191
                                                         (EXIT
                                                          (NREVERSE #2#))))
                                                       (QREFELT $ 30)))
                                            (#7#
                                             (SEQ
                                              (LETT |x|
                                                    (SPADCALL |p|
                                                              (QREFELT $ 35)))
                                              (EXIT
                                               (COND
                                                ((QEQCAR |x| 0)
                                                 (SEQ (LETT |xr| (QCDR |x|))
                                                      (EXIT
                                                       (SPADCALL
                                                        (SPADCALL |f|
                                                                  (QCAR |xr|)
                                                                  (QREFELT $
                                                                           17))
                                                        (SPADCALL |f|
                                                                  (QCDR |xr|)
                                                                  (QREFELT $
                                                                           17))
                                                        (QREFELT $ 36)))))
                                                (#7#
                                                 (SEQ
                                                  (LETT |w|
                                                        (SPADCALL |p|
                                                                  (QREFELT $
                                                                           39)))
                                                  (EXIT
                                                   (COND
                                                    ((QEQCAR |w| 0)
                                                     (SEQ
                                                      (LETT |wr| (QCDR |w|))
                                                      (EXIT
                                                       (SPADCALL
                                                        (SPADCALL |f|
                                                                  (QCAR |wr|)
                                                                  (QREFELT $
                                                                           17))
                                                        (QCDR |wr|)
                                                        (QREFELT $ 41)))))
                                                    (#7#
                                                     (SEQ
                                                      (LETT |sy|
                                                            (SPADCALL |p|
                                                                      (QREFELT
                                                                       $ 43)))
                                                      (EXIT
                                                       (SPADCALL
                                                        (SPADCALL |sy|
                                                                  (QREFELT $
                                                                           44))
                                                        (SPADCALL
                                                         (SPADCALL |p|
                                                                   (QREFELT $
                                                                            46))
                                                         (QREFELT $ 47))
                                                        (QREFELT $
                                                                 48)))))))))))))))))))))))))))))))))) 

(DECLAIM (NOTINLINE |PatternFunctions2;|)) 

(DEFUN |PatternFunctions2| (&REST #1=#:G758)
  (SPROG NIL
         (PROG (#2=#:G759)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PatternFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PatternFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PatternFunctions2|)))))))))) 

(DEFUN |PatternFunctions2;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|PatternFunctions2| DV$1 DV$2))
          (LETT $ (GETREFV 49))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PatternFunctions2| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PatternFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Union| 6 '"failed") (|Pattern| 6) (0 . |retractIfCan|)
              (|Pattern| 7) (5 . |coerce|)
              (|Record| (|:| |op| 18) (|:| |arg| 19)) (|Union| 13 '"failed")
              (10 . |isOp|) (|Mapping| 7 6) |PATTERN2;map;MPP;1|
              (|BasicOperator|) (|List| $) (15 . |elt|)
              (|Record| (|:| |num| $) (|:| |den| $)) (|Union| 21 '"failed")
              (21 . |isQuotient|) (26 . /) (|Union| 19 '"failed")
              (32 . |isPlus|) (37 . +) (|Mapping| 11 11 11) (|List| 11)
              (43 . |reduce|) (49 . |isTimes|) (54 . *)
              (|Record| (|:| |val| $) (|:| |exponent| $))
              (|Union| 33 '"failed") (60 . |isPower|) (65 . ^)
              (|Record| (|:| |val| $) (|:| |exponent| 40))
              (|Union| 37 '"failed") (71 . |isExpt|) (|NonNegativeInteger|)
              (76 . ^) (|Symbol|) (82 . |retract|) (87 . |coerce|)
              (|List| (|Any|)) (92 . |predicates|) (97 . |copy|)
              (102 . |setPredicates|))
           '#(|map| 108) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|Pattern| |#2|) (|Mapping| |#2| |#1|)
                                  (|Pattern| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 48
                                            '(1 9 8 0 10 1 11 0 7 12 1 9 14 0
                                              15 2 11 0 18 19 20 1 9 22 0 23 2
                                              11 0 0 0 24 1 9 25 0 26 2 11 0 0
                                              0 27 2 29 11 28 0 30 1 9 25 0 31
                                              2 11 0 0 0 32 1 9 34 0 35 2 11 0
                                              0 0 36 1 9 38 0 39 2 11 0 0 40 41
                                              1 9 42 0 43 1 11 0 42 44 1 9 45 0
                                              46 1 45 0 0 47 2 11 0 0 45 48 2 0
                                              11 16 9 17)))))
           '|lookupComplete|)) 
