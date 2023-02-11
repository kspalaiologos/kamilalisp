
(SDEFUN |MPC2;supMap|
        ((|fn| (|Mapping| S R)) (|supr| (|SparseUnivariatePolynomial| PR))
         ($ (|SparseUnivariatePolynomial| PS)))
        (SPROG ((|c| (PS)))
               (SEQ
                (COND
                 ((SPADCALL |supr| (|spadConstant| $ 16) (QREFELT $ 18))
                  (SPADCALL
                   (SPADCALL (SPADCALL (|spadConstant| $ 19) |fn|)
                             (QREFELT $ 20))
                   0 (QREFELT $ 23)))
                 ('T
                  (SEQ
                   (LETT |c|
                         (SPADCALL |fn| (SPADCALL |supr| (QREFELT $ 24))
                                   (QREFELT $ 26)))
                   (EXIT
                    (SPADCALL
                     (SPADCALL |c| (SPADCALL |supr| (QREFELT $ 27))
                               (QREFELT $ 23))
                     (|MPC2;supMap| |fn| (SPADCALL |supr| (QREFELT $ 28)) $)
                     (QREFELT $ 29))))))))) 

(SDEFUN |MPC2;map;MPRPS;2| ((|fn| (|Mapping| S R)) (|pr| (PR)) ($ (PS)))
        (SPROG
         ((|supr| (|SparseUnivariatePolynomial| PR)) (|var| (|VarSet|))
          (|varu| (|Union| |VarSet| "failed")))
         (SEQ (LETT |varu| (SPADCALL |pr| (QREFELT $ 31)))
              (EXIT
               (COND
                ((QEQCAR |varu| 1)
                 (SPADCALL (SPADCALL (SPADCALL |pr| (QREFELT $ 32)) |fn|)
                           (QREFELT $ 20)))
                ('T
                 (SEQ (LETT |var| (QCDR |varu|))
                      (LETT |supr| (SPADCALL |pr| |var| (QREFELT $ 34)))
                      (EXIT
                       (SPADCALL (|MPC2;supMap| |fn| |supr| $) |var|
                                 (QREFELT $ 35)))))))))) 

(DECLAIM (NOTINLINE |MPolyCatFunctions2;|)) 

(DEFUN |MPolyCatFunctions2| (&REST #1=#:G708)
  (SPROG NIL
         (PROG (#2=#:G709)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|MPolyCatFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |MPolyCatFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|MPolyCatFunctions2|)))))))))) 

(DEFUN |MPolyCatFunctions2;| (|#1| |#2| |#3| |#4| |#5| |#6| |#7|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$7 NIL) (DV$6 NIL) (DV$5 NIL) (DV$4 NIL)
    (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT DV$6 (|devaluate| |#6|))
    (LETT DV$7 (|devaluate| |#7|))
    (LETT |dv$|
          (LIST '|MPolyCatFunctions2| DV$1 DV$2 DV$3 DV$4 DV$5 DV$6 DV$7))
    (LETT $ (GETREFV 36))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|MPolyCatFunctions2|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5 DV$6 DV$7) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (QSETREFV $ 11 |#6|)
    (QSETREFV $ 12 |#7|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|MPolyCatFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) (|local| |#6|)
              (|local| |#7|) (0 . |Zero|) (4 . |Zero|)
              (|SparseUnivariatePolynomial| 11) (8 . |Zero|) (|Boolean|)
              (12 . =) (18 . |Zero|) (22 . |coerce|) (|NonNegativeInteger|)
              (|SparseUnivariatePolynomial| 12) (27 . |monomial|)
              (33 . |leadingCoefficient|) (|Mapping| 10 9) |MPC2;map;MPRPS;2|
              (38 . |degree|) (43 . |reductum|) (48 . +) (|Union| 6 '"failed")
              (54 . |mainVariable|) (59 . |retract|)
              (|SparseUnivariatePolynomial| $) (64 . |univariate|)
              (70 . |multivariate|))
           '#(|map| 76) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map| (|#7| (|Mapping| |#5| |#4|) |#6|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 35
                                            '(0 7 0 13 0 8 0 14 0 15 0 16 2 15
                                              17 0 0 18 0 9 0 19 1 12 0 10 20 2
                                              22 0 12 21 23 1 15 11 0 24 1 15
                                              21 0 27 1 15 0 0 28 2 22 0 0 0 29
                                              1 11 30 0 31 1 11 9 0 32 2 11 33
                                              0 6 34 2 12 0 33 6 35 2 0 12 25
                                              11 26)))))
           '|lookupComplete|)) 
