
(SDEFUN |DROPT1;option;LSU;1|
        ((|l| (|List| (|DrawOption|))) (|s| (|Symbol|))
         ($ (|Union| S "failed")))
        (SPROG ((|u| (|Union| (|Any|) "failed")))
               (SEQ (LETT |u| (SPADCALL |l| |s| (QREFELT $ 11)))
                    (EXIT
                     (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                           ('T
                            (CONS 0 (SPADCALL (QCDR |u|) (QREFELT $ 14))))))))) 

(DECLAIM (NOTINLINE |DrawOptionFunctions1;|)) 

(DEFUN |DrawOptionFunctions1| (#1=#:G704)
  (SPROG NIL
         (PROG (#2=#:G705)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|DrawOptionFunctions1|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|DrawOptionFunctions1;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|DrawOptionFunctions1|)))))))))) 

(DEFUN |DrawOptionFunctions1;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|DrawOptionFunctions1| DV$1))
          (LETT $ (GETREFV 18))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|DrawOptionFunctions1| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|DrawOptionFunctions1| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Union| 12 '"failed")
              (|List| $) (|Symbol|) (|DrawOption|) (0 . |option|) (|Any|)
              (|AnyFunctions1| 6) (6 . |retract|) (|Union| 6 '#1="failed")
              (|List| 10) |DROPT1;option;LSU;1|)
           '#(|option| 11) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|option|
                                 ((|Union| |#1| #1#) (|List| (|DrawOption|))
                                  (|Symbol|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 17
                                            '(2 10 7 8 9 11 1 13 6 12 14 2 0 15
                                              16 9 17)))))
           '|lookupComplete|)) 
