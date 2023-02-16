
(SDEFUN |FLAGG2;reduce;MA2R;1|
        ((|fn| (|Mapping| R S R)) (|l| (A)) (|ident| (R)) ($ (R)))
        (COND ((SPADCALL |l| (QREFELT $ 11)) |ident|)
              ('T
               (SPADCALL |fn| (SPADCALL |l| (QREFELT $ 12))
                         (SPADCALL (SPADCALL |l| (QREFELT $ 13)) |ident| |fn|)
                         (QREFELT $ 15))))) 

(SDEFUN |FLAGG2;map;MAB;2| ((|f| (|Mapping| R S)) (|l| (A)) ($ (B)))
        (SPROG ((#1=#:G706 NIL) (|s| NIL) (#2=#:G705 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |s| NIL) (LETT #1# (SPADCALL |l| (QREFELT $ 17)))
                       G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ (EXIT (LETT #2# (CONS (SPADCALL |s| |f|) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 19))))) 

(SDEFUN |FLAGG2;scan;MARB;3|
        ((|fn| (|Mapping| R S R)) (|l| (A)) (|ident| (R)) ($ (B)))
        (SPROG ((|val| (R)))
               (SEQ
                (COND ((SPADCALL |l| (QREFELT $ 11)) (SPADCALL (QREFELT $ 22)))
                      ('T
                       (SEQ
                        (LETT |val|
                              (SPADCALL (SPADCALL |l| (QREFELT $ 13)) |ident|
                                        |fn|))
                        (EXIT
                         (SPADCALL |val|
                                   (SPADCALL |fn| (SPADCALL |l| (QREFELT $ 12))
                                             |val| (QREFELT $ 23))
                                   (QREFELT $ 24))))))))) 

(SDEFUN |FLAGG2;map;MAB;4| ((|f| (|Mapping| R S)) (|l| (A)) ($ (B)))
        (SPROG
         ((|i| (|Integer|)) (#1=#:G722 NIL) (|a| NIL) (|w| (B))
          (|l1| (|List| S)))
         (SEQ
          (COND ((SPADCALL |l| (QREFELT $ 11)) (SPADCALL (QREFELT $ 22)))
                ('T
                 (SEQ (LETT |l1| (SPADCALL |l| (QREFELT $ 17)))
                      (LETT |i|
                            (+
                             (SPADCALL
                              (LETT |w|
                                    (SPADCALL (LENGTH |l1|)
                                              (SPADCALL (|SPADfirst| |l1|) |f|)
                                              (QREFELT $ 26)))
                              (QREFELT $ 28))
                             1))
                      (SEQ (LETT |a| NIL)
                           (LETT #1# (CDR (SPADCALL |l| (QREFELT $ 17)))) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |a| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (SPADCALL |w| |i| (SPADCALL |a| |f|)
                                      (QREFELT $ 29))
                            (EXIT (LETT |i| (+ |i| 1))))
                           (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                      (EXIT |w|))))))) 

(SDEFUN |FLAGG2;scan;MARB;5|
        ((|fn| (|Mapping| R S R)) (|l| (A)) (|ident| (R)) ($ (B)))
        (SPROG
         ((|i| (|Integer|)) (|vl| (R)) (#1=#:G729 NIL) (|a| NIL) (|w| (B))
          (|l1| (|List| S)))
         (SEQ
          (COND ((SPADCALL |l| (QREFELT $ 11)) (SPADCALL (QREFELT $ 22)))
                ('T
                 (SEQ (LETT |l1| (SPADCALL |l| (QREFELT $ 17)))
                      (LETT |vl| (SPADCALL (|SPADfirst| |l1|) |ident| |fn|))
                      (LETT |i|
                            (+
                             (SPADCALL
                              (LETT |w|
                                    (SPADCALL (LENGTH |l1|) |vl|
                                              (QREFELT $ 26)))
                              (QREFELT $ 28))
                             1))
                      (SEQ (LETT |a| NIL)
                           (LETT #1# (CDR (SPADCALL |l| (QREFELT $ 17)))) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |a| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (LETT |vl|
                                  (SPADCALL |w| |i| (SPADCALL |a| |vl| |fn|)
                                            (QREFELT $ 29)))
                            (EXIT (LETT |i| (+ |i| 1))))
                           (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                      (EXIT |w|))))))) 

(SDEFUN |FLAGG2;map;MAB;6| ((|f| (|Mapping| R S)) (|l| (A)) ($ (B)))
        (SPROG ((#1=#:G734 NIL) (|s| NIL) (#2=#:G733 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |s| NIL) (LETT #1# (SPADCALL |l| (QREFELT $ 17)))
                       G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ (EXIT (LETT #2# (CONS (SPADCALL |s| |f|) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 19))))) 

(SDEFUN |FLAGG2;scan;MARB;7|
        ((|fn| (|Mapping| R S R)) (|l| (A)) (|ident| (R)) ($ (B)))
        (SPROG ((|val| (R)))
               (SEQ
                (COND ((SPADCALL |l| (QREFELT $ 11)) (SPADCALL (QREFELT $ 22)))
                      ('T
                       (SEQ
                        (LETT |val|
                              (SPADCALL (SPADCALL |l| (QREFELT $ 13)) |ident|
                                        |fn|))
                        (EXIT
                         (SPADCALL |val|
                                   (SPADCALL |fn| (SPADCALL |l| (QREFELT $ 12))
                                             |val| (QREFELT $ 23))
                                   (QREFELT $ 24))))))))) 

(SDEFUN |FLAGG2;reduce;MA2R;8|
        ((|fn| (|Mapping| R S R)) (|v| (A)) (|ident| (R)) ($ (R)))
        (SPROG ((|val| (R)) (#1=#:G746 NIL) (|i| NIL))
               (SEQ (LETT |val| |ident|)
                    (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 30)))
                         (LETT #1# (SPADCALL |v| (QREFELT $ 31))) G190
                         (COND ((> |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |val|
                                 (SPADCALL (SPADCALL |v| |i| (QREFELT $ 32))
                                           |val| |fn|))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                    (EXIT |val|)))) 

(SDEFUN |FLAGG2;map;MAB;9| ((|f| (|Mapping| R S)) (|v| (A)) ($ (B)))
        (SPROG ((#1=#:G751 NIL) (|i| NIL) (#2=#:G750 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 30)))
                       (LETT #1# (SPADCALL |v| (QREFELT $ 31))) G190
                       (COND ((> |i| #1#) (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS
                                (SPADCALL (SPADCALL |v| |i| (QREFELT $ 32))
                                          |f|)
                                #2#))))
                       (LETT |i| (+ |i| 1)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 19))))) 

(SDEFUN |FLAGG2;scan;MARB;10|
        ((|fn| (|Mapping| R S R)) (|v| (A)) (|ident| (R)) ($ (B)))
        (SPROG ((|w| (B)) (#1=#:G757 NIL) (|i| NIL))
               (SEQ (LETT |w| (SPADCALL (QREFELT $ 22)))
                    (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 30)))
                         (LETT #1# (SPADCALL |v| (QREFELT $ 31))) G190
                         (COND ((> |i| #1#) (GO G191)))
                         (SEQ
                          (LETT |ident|
                                (SPADCALL (SPADCALL |v| |i| (QREFELT $ 32))
                                          |ident| |fn|))
                          (EXIT
                           (LETT |w| (SPADCALL |ident| |w| (QREFELT $ 24)))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                    (EXIT (SPADCALL |w| (QREFELT $ 33)))))) 

(SDEFUN |FLAGG2;map;MAB;11| ((|f| (|Mapping| R S)) (|v| (A)) ($ (B)))
        (SPROG
         ((#1=#:G763 NIL) (|i| NIL) (|w| (B)) (|i0| (|Integer|))
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (SPADCALL |v| (QREFELT $ 34)))
              (EXIT
               (COND ((EQL |n| 0) (SPADCALL (QREFELT $ 22)))
                     ('T
                      (SEQ (LETT |i0| (SPADCALL |v| (QREFELT $ 30)))
                           (LETT |w|
                                 (SPADCALL (SPADCALL |v| (QREFELT $ 34))
                                           (SPADCALL
                                            (SPADCALL |v| |i0| (QREFELT $ 32))
                                            |f|)
                                           (QREFELT $ 26)))
                           (SEQ (LETT |i| (+ |i0| 1))
                                (LETT #1# (SPADCALL |w| (QREFELT $ 35))) G190
                                (COND ((> |i| #1#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (SPADCALL |w| |i|
                                            (SPADCALL
                                             (SPADCALL |v| |i| (QREFELT $ 32))
                                             |f|)
                                            (QREFELT $ 29))))
                                (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                           (EXIT |w|)))))))) 

(SDEFUN |FLAGG2;scan;MARB;12|
        ((|fn| (|Mapping| R S R)) (|v| (A)) (|ident| (R)) ($ (B)))
        (SPROG
         ((|vl| (R)) (#1=#:G769 NIL) (|i| NIL) (|w| (B)) (|i0| (|Integer|))
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (SPADCALL |v| (QREFELT $ 34)))
              (EXIT
               (COND ((EQL |n| 0) (SPADCALL (QREFELT $ 22)))
                     ('T
                      (SEQ (LETT |i0| (SPADCALL |v| (QREFELT $ 30)))
                           (LETT |vl|
                                 (SPADCALL (SPADCALL |v| |i0| (QREFELT $ 32))
                                           |ident| |fn|))
                           (LETT |w|
                                 (SPADCALL (SPADCALL |v| (QREFELT $ 34)) |vl|
                                           (QREFELT $ 26)))
                           (SEQ (LETT |i| (+ |i0| 1))
                                (LETT #1# (SPADCALL |v| (QREFELT $ 31))) G190
                                (COND ((> |i| #1#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT |vl|
                                        (SPADCALL |w| |i|
                                                  (SPADCALL
                                                   (SPADCALL |v| |i|
                                                             (QREFELT $ 32))
                                                   |vl| |fn|)
                                                  (QREFELT $ 29)))))
                                (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                           (EXIT |w|)))))))) 

(SDEFUN |FLAGG2;map;MAB;13| ((|f| (|Mapping| R S)) (|v| (A)) ($ (B)))
        (SPROG ((#1=#:G774 NIL) (|i| NIL) (#2=#:G773 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 30)))
                       (LETT #1# (SPADCALL |v| (QREFELT $ 31))) G190
                       (COND ((> |i| #1#) (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS
                                (SPADCALL (SPADCALL |v| |i| (QREFELT $ 32))
                                          |f|)
                                #2#))))
                       (LETT |i| (+ |i| 1)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 19))))) 

(SDEFUN |FLAGG2;scan;MARB;14|
        ((|fn| (|Mapping| R S R)) (|v| (A)) (|ident| (R)) ($ (B)))
        (SPROG ((|w| (B)) (#1=#:G780 NIL) (|i| NIL))
               (SEQ (LETT |w| (SPADCALL (QREFELT $ 22)))
                    (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 30)))
                         (LETT #1# (SPADCALL |v| (QREFELT $ 31))) G190
                         (COND ((> |i| #1#) (GO G191)))
                         (SEQ
                          (LETT |ident|
                                (SPADCALL (SPADCALL |v| |i| (QREFELT $ 32))
                                          |ident| |fn|))
                          (EXIT
                           (LETT |w| (SPADCALL |w| |ident| (QREFELT $ 36)))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                    (EXIT |w|)))) 

(DECLAIM (NOTINLINE |FiniteLinearAggregateFunctions2;|)) 

(DEFUN |FiniteLinearAggregateFunctions2| (&REST #1=#:G781)
  (SPROG NIL
         (PROG (#2=#:G782)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FiniteLinearAggregateFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |FiniteLinearAggregateFunctions2;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|FiniteLinearAggregateFunctions2|)))))))))) 

(DEFUN |FiniteLinearAggregateFunctions2;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|FiniteLinearAggregateFunctions2| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 37))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|FiniteLinearAggregateFunctions2|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|HasCategory| |#2| (LIST '|ListAggregate| (|devaluate| |#1|)))
      (PROGN
       (QSETREFV $ 15 (CONS (|dispatchFunction| |FLAGG2;reduce;MA2R;1|) $))
       (COND
        ((|HasCategory| |#4| (LIST '|ListAggregate| (|devaluate| |#3|)))
         (PROGN
          (QSETREFV $ 21 (CONS (|dispatchFunction| |FLAGG2;map;MAB;2|) $))
          (QSETREFV $ 23 (CONS (|dispatchFunction| |FLAGG2;scan;MARB;3|) $))))
        ((|HasCategory| |#4| '(|shallowlyMutable|))
         (PROGN
          (QSETREFV $ 21 (CONS (|dispatchFunction| |FLAGG2;map;MAB;4|) $))
          (QSETREFV $ 23 (CONS (|dispatchFunction| |FLAGG2;scan;MARB;5|) $))))
        ('T
         (PROGN
          (QSETREFV $ 21 (CONS (|dispatchFunction| |FLAGG2;map;MAB;6|) $))
          (QSETREFV $ 23
                    (CONS (|dispatchFunction| |FLAGG2;scan;MARB;7|) $)))))))
     ('T
      (PROGN
       (QSETREFV $ 15 (CONS (|dispatchFunction| |FLAGG2;reduce;MA2R;8|) $))
       (COND
        ((|HasCategory| |#4| (LIST '|ListAggregate| (|devaluate| |#3|)))
         (PROGN
          (QSETREFV $ 21 (CONS (|dispatchFunction| |FLAGG2;map;MAB;9|) $))
          (QSETREFV $ 23 (CONS (|dispatchFunction| |FLAGG2;scan;MARB;10|) $))))
        ((|HasCategory| |#4| '(|shallowlyMutable|))
         (PROGN
          (QSETREFV $ 21 (CONS (|dispatchFunction| |FLAGG2;map;MAB;11|) $))
          (QSETREFV $ 23 (CONS (|dispatchFunction| |FLAGG2;scan;MARB;12|) $))))
        ('T
         (PROGN
          (QSETREFV $ 21 (CONS (|dispatchFunction| |FLAGG2;map;MAB;13|) $))
          (QSETREFV $ 23
                    (CONS (|dispatchFunction| |FLAGG2;scan;MARB;14|) $))))))))
    $))) 

(MAKEPROP '|FiniteLinearAggregateFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|Boolean|) (0 . |empty?|)
              (5 . |rest|) (10 . |first|) (|Mapping| 8 6 8) (15 . |reduce|)
              (|List| 6) (22 . |entries|) (|List| 8) (27 . |construct|)
              (|Mapping| 8 6) (32 . |map|) (38 . |empty|) (42 . |scan|)
              (49 . |concat|) (|NonNegativeInteger|) (55 . |new|) (|Integer|)
              (61 . |minIndex|) (66 . |qsetelt!|) (73 . |minIndex|)
              (78 . |maxIndex|) (83 . |qelt|) (89 . |reverse!|) (94 . |#|)
              (99 . |maxIndex|) (104 . |concat|))
           '#(|scan| 110 |reduce| 117 |map| 124) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map| (|#4| (|Mapping| |#3| |#1|) |#2|)) T)
                              '((|reduce|
                                 (|#3| (|Mapping| |#3| |#1| |#3|) |#2| |#3|))
                                T)
                              '((|scan|
                                 (|#4| (|Mapping| |#3| |#1| |#3|) |#2| |#3|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 36
                                            '(1 7 10 0 11 1 7 0 0 12 1 7 6 0 13
                                              3 0 8 14 7 8 15 1 7 16 0 17 1 9 0
                                              18 19 2 0 9 20 7 21 0 9 0 22 3 0
                                              9 14 7 8 23 2 9 0 8 0 24 2 9 0 25
                                              8 26 1 9 27 0 28 3 9 8 0 27 8 29
                                              1 7 27 0 30 1 7 27 0 31 2 7 6 0
                                              27 32 1 9 0 0 33 1 7 25 0 34 1 9
                                              27 0 35 2 9 0 0 8 36 3 0 9 14 7 8
                                              23 3 0 8 14 7 8 15 2 0 9 20 7
                                              21)))))
           '|lookupComplete|)) 
