
(SDEFUN |MTHING;mergeDifference;3L;1|
        ((|x| (|List| S)) (|y| (|List| S)) ($ (|List| S)))
        (SEQ
         (COND ((OR (NULL |x|) (NULL |y|)) |x|)
               ('T
                (SEQ
                 (|MTHING;mergeDifference1| |x| (|SPADfirst| |y|) (CDR |y|) $)
                 (EXIT
                  (COND
                   ((SPADCALL (|SPADfirst| |x|) (|SPADfirst| |y|)
                              (QREFELT $ 8))
                    (CDR |x|))
                   ('T |x|)))))))) 

(SDEFUN |MTHING;mergeDifference1|
        ((|x| #1=(|List| S)) (|fy| (S)) (|ry| (|List| S)) ($ (|List| S)))
        (SPROG ((#2=#:G718 NIL) (|frx| (S)) (|rx| #1#))
               (SEQ
                (EXIT
                 (SEQ (LETT |rx| |x|)
                      (EXIT
                       (SEQ G190 (COND ((NULL (NULL (NULL |rx|))) (GO G191)))
                            (SEQ (LETT |rx| (CDR |rx|))
                                 (LETT |frx| (|SPADfirst| |rx|))
                                 (SEQ G190
                                      (COND
                                       ((NULL
                                         (SPADCALL |fy| |frx| (QREFELT $ 11)))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (COND
                                         ((NULL |ry|)
                                          (PROGN
                                           (LETT #2# |x|)
                                           (GO #3=#:G717)))
                                         ('T
                                          (SEQ (LETT |fy| (|SPADfirst| |ry|))
                                               (EXIT
                                                (LETT |ry| (CDR |ry|))))))))
                                      NIL (GO G190) G191 (EXIT NIL))
                                 (EXIT
                                  (COND
                                   ((SPADCALL |frx| |fy| (QREFELT $ 8))
                                    (SEQ
                                     (SPADCALL |x| '|rest| (CDR |rx|)
                                               (QREFELT $ 13))
                                     (EXIT
                                      (COND
                                       ((NULL |ry|)
                                        (PROGN (LETT #2# |x|) (GO #3#)))
                                       ('T
                                        (SEQ (LETT |fy| (|SPADfirst| |ry|))
                                             (EXIT
                                              (LETT |ry| (CDR |ry|)))))))))
                                   ('T (LETT |x| |rx|)))))
                            NIL (GO G190) G191 (EXIT NIL)))))
                #3# (EXIT #2#)))) 

(DECLAIM (NOTINLINE |MergeThing;|)) 

(DEFUN |MergeThing| (#1=#:G719)
  (SPROG NIL
         (PROG (#2=#:G720)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|MergeThing|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|MergeThing;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|MergeThing|)))))))))) 

(DEFUN |MergeThing;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|MergeThing| DV$1))
          (LETT $ (GETREFV 14))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|MergeThing| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|MergeThing| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Boolean|) (0 . =)
              (|List| 6) |MTHING;mergeDifference;3L;1| (6 . <) '"rest"
              (12 . |setelt!|))
           '#(|mergeDifference| 19) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|mergeDifference|
                                 ((|List| |#1|) (|List| |#1|) (|List| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 13
                                            '(2 6 7 0 0 8 2 6 7 0 0 11 3 9 0 0
                                              12 0 13 2 0 9 9 9 10)))))
           '|lookupComplete|)) 
