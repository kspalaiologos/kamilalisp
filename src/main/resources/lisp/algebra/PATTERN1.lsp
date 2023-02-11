
(SDEFUN |PATTERN1;st|
        ((|p| (|Pattern| R)) (|l| (|List| (|Any|))) ($ (|Pattern| R)))
        (SPADCALL |p|
                  (SPADCALL (SPADCALL |p| (QREFELT $ 10)) |l| (QREFELT $ 11))
                  (QREFELT $ 12))) 

(SDEFUN |PATTERN1;predicate;PM;2|
        ((|p| (|Pattern| R)) ($ (|Mapping| (|Boolean|) D)))
        (SPROG NIL (CONS #'|PATTERN1;predicate;PM;2!0| (VECTOR $ |p|)))) 

(SDEFUN |PATTERN1;predicate;PM;2!0| ((|d1| NIL) ($$ NIL))
        (PROG (|p| $)
          (LETT |p| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN (|PATTERN1;applyAll| (SPADCALL |p| (QREFELT $ 10)) |d1| $))))) 

(SDEFUN |PATTERN1;addBadValue;PDP;3|
        ((|p| (|Pattern| R)) (|v| (D)) ($ (|Pattern| R)))
        (SPADCALL |p| (SPADCALL |v| (QREFELT $ 17)) (QREFELT $ 18))) 

(SDEFUN |PATTERN1;badValues;PL;4| ((|p| (|Pattern| R)) ($ (|List| D)))
        (SPROG ((#1=#:G716 NIL) (|v| NIL) (#2=#:G715 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |v| NIL) (LETT #1# (SPADCALL |p| (QREFELT $ 20)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |v| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |v| (QREFELT $ 21)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |PATTERN1;suchThat;PLMP;5|
        ((|p| (|Pattern| R)) (|l| (|List| (|Symbol|)))
         (|f| (|Mapping| (|Boolean|) (|List| D))) ($ (|Pattern| R)))
        (SPADCALL (SPADCALL |p| (QREFELT $ 24)) |l|
                  (SPADCALL |f| (QREFELT $ 27)) (QREFELT $ 29))) 

(SDEFUN |PATTERN1;suchThat;PMP;6|
        ((|p| (|Pattern| R)) (|f| (|Mapping| (|Boolean|) D)) ($ (|Pattern| R)))
        (|PATTERN1;st| |p| (LIST (SPADCALL |f| (QREFELT $ 32))) $)) 

(SDEFUN |PATTERN1;satisfy?;DPB;7|
        ((|d| (D)) (|p| (|Pattern| R)) ($ (|Boolean|)))
        (|PATTERN1;applyAll| (SPADCALL |p| (QREFELT $ 10)) |d| $)) 

(SDEFUN |PATTERN1;satisfy?;LPB;8|
        ((|l| (|List| D)) (|p| (|Pattern| R)) ($ (|Boolean|)))
        (SPROG
         ((|rec|
           (|Record| (|:| |var| (|List| (|Symbol|))) (|:| |pred| (|Any|)))))
         (COND ((NULL (QCAR (LETT |rec| (SPADCALL |p| (QREFELT $ 37))))) 'T)
               ('T (SPADCALL |l| (SPADCALL (QCDR |rec|) (QREFELT $ 38))))))) 

(SDEFUN |PATTERN1;applyAll| ((|l| (|List| (|Any|))) (|d| (D)) ($ (|Boolean|)))
        (SPROG ((#1=#:G732 NIL) (#2=#:G733 NIL) (#3=#:G734 NIL) (|f| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |f| NIL) (LETT #3# |l|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |f| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((NULL
                              (SPADCALL |d| (SPADCALL |f| (QREFELT $ 40))))
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# NIL) (GO #4=#:G731)))
                              (GO #5=#:G729))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT 'T)))
                #4# (EXIT #2#)))) 

(SDEFUN |PATTERN1;suchThat;PLP;10|
        ((|p| (|Pattern| R)) (|l| (|List| (|Mapping| (|Boolean|) D)))
         ($ (|Pattern| R)))
        (SPROG ((#1=#:G741 NIL) (|f| NIL) (#2=#:G740 NIL))
               (SEQ
                (|PATTERN1;st| |p|
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |f| NIL) (LETT #1# |l|) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2# (CONS (SPADCALL |f| (QREFELT $ 32)) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 $)))) 

(DECLAIM (NOTINLINE |PatternFunctions1;|)) 

(DEFUN |PatternFunctions1| (&REST #1=#:G742)
  (SPROG NIL
         (PROG (#2=#:G743)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PatternFunctions1|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PatternFunctions1;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PatternFunctions1|)))))))))) 

(DEFUN |PatternFunctions1;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|PatternFunctions1| DV$1 DV$2))
          (LETT $ (GETREFV 43))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PatternFunctions1| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PatternFunctions1| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|List| 15)
              (|Pattern| 6) (0 . |predicates|) (5 . |concat|)
              (11 . |withPredicates|) (|Mapping| 34 7)
              |PATTERN1;predicate;PM;2| (|Any|) (|AnyFunctions1| 7)
              (17 . |coerce|) (22 . |addBadValue|) |PATTERN1;addBadValue;PDP;3|
              (28 . |getBadValues|) (33 . |retract|) (|List| 7)
              |PATTERN1;badValues;PL;4| (38 . |copy|) (|Mapping| 34 22)
              (|AnyFunctions1| 25) (43 . |coerce|) (|List| (|Symbol|))
              (48 . |setTopPredicate|) |PATTERN1;suchThat;PLMP;5|
              (|AnyFunctions1| 13) (55 . |coerce|) |PATTERN1;suchThat;PMP;6|
              (|Boolean|) |PATTERN1;satisfy?;DPB;7|
              (|Record| (|:| |var| 28) (|:| |pred| 15)) (60 . |topPredicate|)
              (65 . |retract|) |PATTERN1;satisfy?;LPB;8| (70 . |retract|)
              (|List| 13) |PATTERN1;suchThat;PLP;10|)
           '#(|suchThat| 75 |satisfy?| 94 |predicate| 106 |badValues| 111
              |addBadValue| 116)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|suchThat|
                                 ((|Pattern| |#1|) (|Pattern| |#1|)
                                  (|Mapping| (|Boolean|) |#2|)))
                                T)
                              '((|suchThat|
                                 ((|Pattern| |#1|) (|Pattern| |#1|)
                                  (|List| (|Mapping| (|Boolean|) |#2|))))
                                T)
                              '((|suchThat|
                                 ((|Pattern| |#1|) (|Pattern| |#1|)
                                  (|List| (|Symbol|))
                                  (|Mapping| (|Boolean|) (|List| |#2|))))
                                T)
                              '((|predicate|
                                 ((|Mapping| (|Boolean|) |#2|)
                                  (|Pattern| |#1|)))
                                T)
                              '((|satisfy?|
                                 ((|Boolean|) |#2| (|Pattern| |#1|)))
                                T)
                              '((|satisfy?|
                                 ((|Boolean|) (|List| |#2|) (|Pattern| |#1|)))
                                T)
                              '((|addBadValue|
                                 ((|Pattern| |#1|) (|Pattern| |#1|) |#2|))
                                T)
                              '((|badValues| ((|List| |#2|) (|Pattern| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 42
                                            '(1 9 8 0 10 2 8 0 0 0 11 2 9 0 0 8
                                              12 1 16 15 7 17 2 9 0 0 15 18 1 9
                                              8 0 20 1 16 7 15 21 1 9 0 0 24 1
                                              26 15 25 27 3 9 0 0 28 15 29 1 31
                                              15 13 32 1 9 36 0 37 1 26 25 15
                                              38 1 31 13 15 40 2 0 9 9 41 42 2
                                              0 9 9 13 33 3 0 9 9 28 25 30 2 0
                                              34 22 9 39 2 0 34 7 9 35 1 0 13 9
                                              14 1 0 22 9 23 2 0 9 9 7 19)))))
           '|lookupComplete|)) 
