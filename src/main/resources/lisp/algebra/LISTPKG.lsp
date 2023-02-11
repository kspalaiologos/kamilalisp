
(SDEFUN |LISTPKG;splitList;MLR;1|
        ((|f| (|Mapping| (|Boolean|) T$)) (|l| (|List| T$))
         ($ (|Record| (|:| |yes| (|List| T$)) (|:| |no| (|List| T$)))))
        (SPROG
         ((|resno| #1=(|List| T$)) (|resyes| #1#) (#2=#:G718 NIL) (|t| NIL))
         (SEQ
          (COND ((NULL |l|) (CONS NIL NIL))
                ('T
                 (SEQ (LETT |resyes| NIL) (LETT |resno| NIL)
                      (SEQ (LETT |t| NIL) (LETT #2# |l|) G190
                           (COND
                            ((OR (ATOM #2#) (PROGN (LETT |t| (CAR #2#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL |t| |f|)
                               (LETT |resyes| (CONS |t| |resyes|)))
                              ('T (LETT |resno| (CONS |t| |resno|))))))
                           (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                      (EXIT (CONS (NREVERSE |resyes|) (NREVERSE |resno|))))))))) 

(SDEFUN |LISTPKG;topologicalSort!;M2L;2|
        ((|f| (|Mapping| (|Boolean|) T$ T$)) (|xx| (|List| T$))
         ($ (|List| T$)))
        (SPROG
         ((|res| (|List| (|List| T$))) (|xx1| #1=(|List| T$)) (|bucket| #1#)
          (#2=#:G737 NIL) (|x| NIL) (|x0| (T$)))
         (SEQ (LETT |bucket| NIL) (LETT |res| NIL)
              (SEQ G190 (COND ((NULL (NULL (NULL |xx|))) (GO G191)))
                   (SEQ (LETT |x0| (|SPADfirst| |xx|)) (LETT |xx| (CDR |xx|))
                        (LETT |bucket| (LIST |x0|)) (LETT |xx1| NIL)
                        (SEQ (LETT |x| NIL) (LETT #2# |xx|) G190
                             (COND
                              ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((SPADCALL |x0| |x| |f|)
                                 (LETT |bucket| (CONS |x| |bucket|)))
                                ('T (LETT |xx1| (CONS |x| |xx1|))))))
                             (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                        (LETT |res| (CONS (REVERSE |bucket|) |res|))
                        (EXIT (LETT |xx| (REVERSE |xx1|))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |res| (QREFELT $ 12)))))) 

(SDEFUN |LISTPKG;topologicalSort;M2L;3|
        ((|f| (|Mapping| (|Boolean|) T$ T$)) (|xx| (|List| T$))
         ($ (|List| T$)))
        (SPROG ((|xx1| (|List| T$)))
               (SEQ (LETT |xx1| (SPADCALL |xx| (QREFELT $ 15)))
                    (EXIT (SPADCALL |f| |xx1| (QREFELT $ 14)))))) 

(SDEFUN |LISTPKG;topologicalSort;L2L;4|
        ((|adjacency| (|List| (|List| (|Boolean|)))) (|xx| (|List| T$))
         ($ (|List| T$)))
        (SPROG
         ((#1=#:G762 NIL) (|p| NIL) (#2=#:G761 NIL)
          (|r| (|List| (|NonNegativeInteger|)))
          (|xi| (|List| (|NonNegativeInteger|)))
          (|res| (|List| (|List| (|NonNegativeInteger|))))
          (|xx1| #3=(|List| (|NonNegativeInteger|))) (|bucket| #3#)
          (#4=#:G760 NIL) (|x| NIL) (|x0| (|NonNegativeInteger|))
          (#5=#:G759 NIL) (|n| NIL) (#6=#:G758 NIL))
         (SEQ
          (LETT |xi|
                (PROGN
                 (LETT #6# NIL)
                 (SEQ (LETT |n| 1) (LETT #5# (LENGTH |xx|)) G190
                      (COND ((|greater_SI| |n| #5#) (GO G191)))
                      (SEQ (EXIT (LETT #6# (CONS |n| #6#))))
                      (LETT |n| (|inc_SI| |n|)) (GO G190) G191
                      (EXIT (NREVERSE #6#)))))
          (LETT |bucket| NIL) (LETT |res| NIL)
          (SEQ G190 (COND ((NULL (NULL (NULL |xi|))) (GO G191)))
               (SEQ (LETT |x0| (|SPADfirst| |xi|)) (LETT |xi| (CDR |xi|))
                    (LETT |bucket| (LIST |x0|)) (LETT |xx1| NIL)
                    (SEQ (LETT |x| NIL) (LETT #4# |xi|) G190
                         (COND
                          ((OR (ATOM #4#) (PROGN (LETT |x| (CAR #4#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL
                              (SPADCALL |adjacency| |x0| (QREFELT $ 20)) |x|
                              (QREFELT $ 22))
                             (LETT |bucket| (CONS |x| |bucket|)))
                            ('T (LETT |xx1| (CONS |x| |xx1|))))))
                         (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                    (LETT |res| (CONS (REVERSE |bucket|) |res|))
                    (EXIT (LETT |xi| (REVERSE |xx1|))))
               NIL (GO G190) G191 (EXIT NIL))
          (LETT |r| (SPADCALL |res| (QREFELT $ 24)))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |p| NIL) (LETT #1# |r|) G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL)) (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #2# (CONS (SPADCALL |xx| |p| (QREFELT $ 25)) #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |LISTPKG;shiftLeft;2L;5| ((|xx| (|List| T$)) ($ (|List| T$)))
        (SPROG ((#1=#:G765 NIL))
               (SEQ
                (EXIT
                 (COND ((NULL |xx|) (PROGN (LETT #1# |xx|) (GO #2=#:G764)))
                       ('T
                        (SPADCALL (CDR |xx|) (|SPADfirst| |xx|)
                                  (QREFELT $ 27)))))
                #2# (EXIT #1#)))) 

(SDEFUN |LISTPKG;minShift;2L;6| ((|xx| #1=(|List| T$)) ($ (|List| T$)))
        (SPROG
         ((|res| #1#) (|xx1| #1#) (#2=#:G774 NIL) (|k| NIL) (#3=#:G773 NIL))
         (SEQ
          (EXIT
           (COND
            ((OR (NULL |xx|) (NULL (CDR |xx|)))
             (PROGN (LETT #3# |xx|) (GO #4=#:G772)))
            ('T
             (SEQ (LETT |res| |xx|) (LETT |xx1| |xx|)
                  (SEQ (LETT |k| 2) (LETT #2# (LENGTH |xx|)) G190
                       (COND ((|greater_SI| |k| #2#) (GO G191)))
                       (SEQ (LETT |xx1| (SPADCALL |xx1| (QREFELT $ 28)))
                            (EXIT
                             (COND
                              ((SPADCALL |xx1| |res| (QREFELT $ 29))
                               (LETT |res| |xx1|)))))
                       (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
                  (EXIT |res|)))))
          #4# (EXIT #3#)))) 

(SDEFUN |LISTPKG;cartesian;2L;7|
        ((SS (|List| (|List| T$))) ($ (|List| (|List| T$))))
        (SPROG
         ((|res| (|List| (|List| T$))) (#1=#:G788 NIL) (|s| NIL)
          (#2=#:G787 NIL) (|x| NIL) (#3=#:G784 NIL) (#4=#:G786 NIL)
          (#5=#:G785 NIL))
         (SEQ
          (EXIT
           (COND
            ((EQL (LENGTH SS) 1)
             (PROGN
              (LETT #3#
                    (PROGN
                     (LETT #5# NIL)
                     (SEQ (LETT |s| NIL) (LETT #4# (|SPADfirst| SS)) G190
                          (COND
                           ((OR (ATOM #4#) (PROGN (LETT |s| (CAR #4#)) NIL))
                            (GO G191)))
                          (SEQ (EXIT (LETT #5# (CONS (LIST |s|) #5#))))
                          (LETT #4# (CDR #4#)) (GO G190) G191
                          (EXIT (NREVERSE #5#)))))
              (GO #6=#:G783)))
            ('T
             (SEQ (LETT |res| NIL)
                  (SEQ (LETT |x| NIL)
                       (LETT #2# (SPADCALL (CDR SS) (QREFELT $ 32))) G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (SEQ (LETT |s| NIL) (LETT #1# (|SPADfirst| SS)) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |s| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT (LETT |res| (CONS (CONS |s| |x|) |res|))))
                              (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))))
                       (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                  (EXIT |res|)))))
          #6# (EXIT #3#)))) 

(SDEFUN |LISTPKG;cartesianPower;LNniL;8|
        ((S (|List| T$)) (|n| (|NonNegativeInteger|)) ($ (|List| (|List| T$))))
        (SPROG
         ((|res| (|List| (|List| T$))) (#1=#:G804 NIL) (|s| NIL)
          (#2=#:G803 NIL) (|x| NIL) (#3=#:G800 NIL) (#4=#:G802 NIL)
          (#5=#:G801 NIL))
         (SEQ
          (EXIT
           (COND
            ((OR (NULL S) (ZEROP |n|)) (PROGN (LETT #3# NIL) (GO #6=#:G799)))
            ('T
             (COND
              ((EQL |n| 1)
               (PROGN
                (LETT #3#
                      (PROGN
                       (LETT #5# NIL)
                       (SEQ (LETT |s| NIL) (LETT #4# S) G190
                            (COND
                             ((OR (ATOM #4#) (PROGN (LETT |s| (CAR #4#)) NIL))
                              (GO G191)))
                            (SEQ (EXIT (LETT #5# (CONS (LIST |s|) #5#))))
                            (LETT #4# (CDR #4#)) (GO G190) G191
                            (EXIT (NREVERSE #5#)))))
                (GO #6#)))
              ('T
               (SEQ (LETT |res| NIL)
                    (SEQ (LETT |x| NIL)
                         (LETT #2# (SPADCALL S (- |n| 1) (QREFELT $ 34))) G190
                         (COND
                          ((OR (ATOM #2#) (PROGN (LETT |x| (CAR #2#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (SEQ (LETT |s| NIL) (LETT #1# S) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |s| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT |res| (CONS (CONS |s| |x|) |res|))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT NIL))))
                         (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |res|)))))))
          #6# (EXIT #3#)))) 

(DECLAIM (NOTINLINE |ListPackage;|)) 

(DEFUN |ListPackage| (#1=#:G805)
  (SPROG NIL
         (PROG (#2=#:G806)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|ListPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|ListPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|ListPackage|)))))))))) 

(DEFUN |ListPackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|ListPackage| DV$1))
          (LETT $ (GETREFV 35))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|OrderedSet|))))))
          (|haddProp| |$ConstructorCache| '|ListPackage| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 1)
            (QSETREFV $ 30
                      (CONS (|dispatchFunction| |LISTPKG;minShift;2L;6|) $))))
          $))) 

(MAKEPROP '|ListPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|)
              (|Record| (|:| |yes| 9) (|:| |no| 9)) (|Mapping| 21 6) (|List| 6)
              |LISTPKG;splitList;MLR;1| (|List| $) (0 . |concat|)
              (|Mapping| 21 6 6) |LISTPKG;topologicalSort!;M2L;2| (5 . |copy|)
              |LISTPKG;topologicalSort;M2L;3| (|List| 21) (|Integer|)
              (|List| 17) (10 . |elt|) (|Boolean|) (16 . |elt|) (|List| 33)
              (22 . |concat|) (27 . |elt|) |LISTPKG;topologicalSort;L2L;4|
              (33 . |concat|) |LISTPKG;shiftLeft;2L;5| (39 . <)
              (45 . |minShift|) (|List| 9) |LISTPKG;cartesian;2L;7|
              (|NonNegativeInteger|) |LISTPKG;cartesianPower;LNniL;8|)
           '#(|topologicalSort!| 50 |topologicalSort| 56 |splitList| 68
              |shiftLeft| 74 |minShift| 79 |cartesianPower| 84 |cartesian| 90)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|splitList|
                                 ((|Record| (|:| |yes| (|List| |#1|))
                                            (|:| |no| (|List| |#1|)))
                                  (|Mapping| (|Boolean|) |#1|) (|List| |#1|)))
                                T)
                              '((|topologicalSort!|
                                 ((|List| |#1|)
                                  (|Mapping| (|Boolean|) |#1| |#1|)
                                  (|List| |#1|)))
                                T)
                              '((|topologicalSort|
                                 ((|List| |#1|)
                                  (|Mapping| (|Boolean|) |#1| |#1|)
                                  (|List| |#1|)))
                                T)
                              '((|topologicalSort|
                                 ((|List| |#1|) (|List| (|List| (|Boolean|)))
                                  (|List| |#1|)))
                                T)
                              '((|shiftLeft| ((|List| |#1|) (|List| |#1|))) T)
                              '((|cartesian|
                                 ((|List| (|List| |#1|))
                                  (|List| (|List| |#1|))))
                                T)
                              '((|cartesianPower|
                                 ((|List| (|List| |#1|)) (|List| |#1|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|minShift| ((|List| |#1|) (|List| |#1|)))
                                (|has| 6 (|OrderedSet|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 34
                                            '(1 9 0 11 12 1 9 0 0 15 2 19 17 0
                                              18 20 2 17 21 0 18 22 1 23 0 11
                                              24 2 9 6 0 18 25 2 9 0 0 6 27 2 9
                                              21 0 0 29 1 0 9 9 30 2 0 9 13 9
                                              14 2 0 9 19 9 26 2 0 9 13 9 16 2
                                              0 7 8 9 10 1 0 9 9 28 1 1 9 9 30
                                              2 0 31 9 33 34 1 0 31 31 32)))))
           '|lookupComplete|)) 
