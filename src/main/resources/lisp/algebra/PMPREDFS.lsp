
(SDEFUN |PMPREDFS;suchThat;FMF;1|
        ((|p| (F)) (|f| (|Mapping| (|Boolean|) D)) ($ (F)))
        (SPADCALL |p| (LIST |f|) (QREFELT $ 12))) 

(SDEFUN |PMPREDFS;mkk| ((|op| (|BasicOperator|)) ($ (F)))
        (SPADCALL |op| NIL (QREFELT $ 16))) 

(SDEFUN |PMPREDFS;preds| ((|k| (|Kernel| F)) ($ (|List| (|Any|))))
        (SPROG ((|u| (|Union| (|None|) "failed")))
               (SEQ
                (LETT |u|
                      (SPADCALL (SPADCALL |k| (QREFELT $ 18)) (QREFELT $ 9)
                                (QREFELT $ 21)))
                (EXIT (COND ((QEQCAR |u| 1) NIL) ('T (QCDR |u|))))))) 

(SDEFUN |PMPREDFS;st| ((|k| (|Kernel| F)) (|l| (|List| (|Any|))) ($ (F)))
        (SPROG ((|kk| (|BasicOperator|)))
               (SEQ
                (LETT |kk|
                      (SPADCALL (SPADCALL |k| (QREFELT $ 18)) (QREFELT $ 22)))
                (SPADCALL |kk| (QREFELT $ 9)
                          (SPADCALL (|PMPREDFS;preds| |k| $) |l|
                                    (QREFELT $ 24))
                          (QREFELT $ 26))
                (SPADCALL |kk| (SPADCALL (QREFELT $ 27)) (QREFELT $ 28))
                (EXIT (SPADCALL |kk| NIL (QREFELT $ 16)))))) 

(SDEFUN |PMPREDFS;suchThat;FLF;5|
        ((|p| (F)) (|l| (|List| (|Mapping| (|Boolean|) D))) ($ (F)))
        (SPROG ((#1=#:G731 NIL) (|f| NIL) (#2=#:G730 NIL))
               (SEQ
                (COND
                 ((QEQCAR (SPADCALL |p| (QREFELT $ 30)) 0)
                  (|PMPREDFS;st| (SPADCALL |p| (QREFELT $ 32))
                   (PROGN
                    (LETT #2# NIL)
                    (SEQ (LETT |f| NIL) (LETT #1# |l|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT #2#
                                 (CONS (SPADCALL |f| (QREFELT $ 35)) #2#))))
                         (LETT #1# (CDR #1#)) (GO G190) G191
                         (EXIT (NREVERSE #2#))))
                   $))
                 ('T (|error| "suchThat must be applied to symbols only")))))) 

(DECLAIM (NOTINLINE |FunctionSpaceAttachPredicates;|)) 

(DEFUN |FunctionSpaceAttachPredicates| (&REST #1=#:G732)
  (SPROG NIL
         (PROG (#2=#:G733)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FunctionSpaceAttachPredicates|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |FunctionSpaceAttachPredicates;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|FunctionSpaceAttachPredicates|)))))))))) 

(DEFUN |FunctionSpaceAttachPredicates;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|FunctionSpaceAttachPredicates| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 36))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FunctionSpaceAttachPredicates|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9 '|%pmpredicate|)
          $))) 

(MAKEPROP '|FunctionSpaceAttachPredicates| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) 'PMPRED (|Mapping| (|Boolean|) 8) (|List| 10)
              |PMPREDFS;suchThat;FLF;5| |PMPREDFS;suchThat;FMF;1|
              (|BasicOperator|) (|List| $) (0 . |kernel|) (|Kernel| 7)
              (6 . |operator|) (|Union| 25 '"failed") (|Symbol|)
              (11 . |property|) (17 . |copy|) (|List| 33) (22 . |concat|)
              (|None|) (28 . |setProperty|) (35 . |new|) (39 . |assert|)
              (|Union| 20 '"failed") (45 . |retractIfCan|) (|Kernel| $)
              (50 . |retract|) (|Any|) (|AnyFunctions1| 10) (55 . |coerce|))
           '#(|suchThat| 60) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|suchThat|
                                 (|#2| |#2| (|Mapping| (|Boolean|) |#3|)))
                                T)
                              '((|suchThat|
                                 (|#2| |#2|
                                  (|List| (|Mapping| (|Boolean|) |#3|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 35
                                            '(2 7 0 14 15 16 1 17 14 0 18 2 14
                                              19 0 20 21 1 14 0 0 22 2 23 0 0 0
                                              24 3 14 0 0 20 25 26 0 20 0 27 2
                                              14 0 0 20 28 1 7 29 0 30 1 7 31 0
                                              32 1 34 33 10 35 2 0 7 7 11 12 2
                                              0 7 7 10 13)))))
           '|lookupComplete|)) 
