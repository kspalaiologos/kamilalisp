
(SDEFUN |FRIDEAL2;fmap| ((|f| (|Mapping| F2 F1)) (|a| (A1)) ($ (A2)))
        (SPROG
         ((#1=#:G699 NIL) (#2=#:G701 NIL) (|i| NIL) (#3=#:G700 NIL)
          (|v| (|Vector| F1)))
         (SEQ (LETT |v| (SPADCALL |a| (QREFELT $ 15)))
              (EXIT
               (SPADCALL
                (PROGN
                 (LETT #3#
                       (GETREFV
                        (|inc_SI|
                         (- #4=(QVSIZE |v|)
                            #5=(SPADCALL |v| (QREFELT $ 17))))))
                 (SEQ (LETT |i| #5#) (LETT #2# #4#) (LETT #1# 0) G190
                      (COND ((> |i| #2#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SETELT #3# #1# (SPADCALL (QAREF1O |v| |i| 1) |f|))))
                      (LETT #1# (PROG1 (|inc_SI| #1#) (LETT |i| (+ |i| 1))))
                      (GO G190) G191 (EXIT NIL))
                 #3#)
                (QREFELT $ 19)))))) 

(SDEFUN |FRIDEAL2;map;MFiFi;2|
        ((|f| (|Mapping| R2 R1)) (|i| (|FractionalIdeal| R1 F1 U1 A1))
         ($ (|FractionalIdeal| R2 F2 U2 A2)))
        (SPROG
         ((#1=#:G708 NIL) (#2=#:G710 NIL) (|j| NIL) (#3=#:G709 NIL)
          (|b| (|Vector| A1)))
         (SEQ (LETT |b| (SPADCALL |i| (QREFELT $ 22)))
              (EXIT
               (SPADCALL
                (PROGN
                 (LETT #3#
                       (GETREFV
                        (|inc_SI|
                         (- #4=(QVSIZE |b|)
                            #5=(SPADCALL |b| (QREFELT $ 23))))))
                 (SEQ (LETT |j| #5#) (LETT #2# #4#) (LETT #1# 0) G190
                      (COND ((> |j| #2#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SETELT #3# #1#
                                (|FRIDEAL2;fmap|
                                 (CONS #'|FRIDEAL2;map;MFiFi;2!0|
                                       (VECTOR |f| $))
                                 (QAREF1O |b| |j| 1) $))))
                      (LETT #1# (PROG1 (|inc_SI| #1#) (LETT |j| (+ |j| 1))))
                      (GO G190) G191 (EXIT NIL))
                 #3#)
                (QREFELT $ 29)))))) 

(SDEFUN |FRIDEAL2;map;MFiFi;2!0| ((|s| NIL) ($$ NIL))
        (PROG ($ |f|)
          (LETT $ (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL (SPADCALL |s| (QREFELT $ 24)) |f|)
                      (SPADCALL (SPADCALL |s| (QREFELT $ 25)) |f|)
                      (QREFELT $ 26)))))) 

(DECLAIM (NOTINLINE |FractionalIdealFunctions2;|)) 

(DEFUN |FractionalIdealFunctions2| (&REST #1=#:G711)
  (SPROG NIL
         (PROG (#2=#:G712)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FractionalIdealFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FractionalIdealFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|FractionalIdealFunctions2|)))))))))) 

(DEFUN |FractionalIdealFunctions2;| (|#1| |#2| |#3| |#4| |#5| |#6| |#7| |#8|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$8 NIL) (DV$7 NIL) (DV$6 NIL) (DV$5 NIL)
    (DV$4 NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT DV$6 (|devaluate| |#6|))
    (LETT DV$7 (|devaluate| |#7|))
    (LETT DV$8 (|devaluate| |#8|))
    (LETT |dv$|
          (LIST '|FractionalIdealFunctions2| DV$1 DV$2 DV$3 DV$4 DV$5 DV$6 DV$7
                DV$8))
    (LETT $ (GETREFV 32))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|FractionalIdealFunctions2|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5 DV$6 DV$7 DV$8) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (QSETREFV $ 11 |#6|)
    (QSETREFV $ 12 |#7|)
    (QSETREFV $ 13 |#8|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|FractionalIdealFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (|local| |#6|)
              (|local| |#7|) (|local| |#8|) (|Vector| 7) (0 . |coordinates|)
              (|Integer|) (5 . |minIndex|) (|Vector| 11) (10 . |represents|)
              (|Vector| 9) (|FractionalIdeal| 6 7 8 9) (15 . |basis|)
              (20 . |minIndex|) (25 . |numer|) (30 . |denom|) (35 . /)
              (|Vector| 13) (|FractionalIdeal| 10 11 12 13) (41 . |ideal|)
              (|Mapping| 10 6) |FRIDEAL2;map;MFiFi;2|)
           '#(|map| 46) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|FractionalIdeal| |#5| |#6| |#7| |#8|)
                                  (|Mapping| |#5| |#1|)
                                  (|FractionalIdeal| |#1| |#2| |#3| |#4|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 31
                                            '(1 9 14 0 15 1 14 16 0 17 1 13 0
                                              18 19 1 21 20 0 22 1 20 16 0 23 1
                                              7 6 0 24 1 7 6 0 25 2 11 0 10 10
                                              26 1 28 0 27 29 2 0 28 30 21
                                              31)))))
           '|lookupComplete|)) 
