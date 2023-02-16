
(SDEFUN |FR2;map;MFF;1|
        ((|fn| (|Mapping| S R)) (|u| (|Factored| R)) ($ (|Factored| S)))
        (SPROG
         ((|l|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| S)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (#1=#:G721 NIL) (|f| NIL) (#2=#:G720 NIL))
         (SEQ
          (LETT |l|
                (CONS
                 (VECTOR (CONS 0 "nil")
                         (SPADCALL (SPADCALL |u| (QREFELT $ 9)) |fn|) 1)
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |f| NIL) (LETT #1# (SPADCALL |u| (QREFELT $ 13)))
                       G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS
                                (VECTOR (CONS 0 "nil")
                                        (SPADCALL (QVELT |f| 1) |fn|)
                                        (QVELT |f| 2))
                                #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))))
          (EXIT (SPADCALL (|spadConstant| $ 15) |l| (QREFELT $ 19)))))) 

(SDEFUN |FR2;map_preserving;MFF;2|
        ((|fn| (|Mapping| S R)) (|u| (|Factored| R)) ($ (|Factored| S)))
        (SPROG
         ((|nl|
           (|List|
            (|Record| (|:| |flag| (|Union| "nil" "sqfr" "irred" "prime"))
                      (|:| |factor| S)
                      (|:| |exponent| (|NonNegativeInteger|)))))
          (#1=#:G734 NIL) (|f| NIL) (#2=#:G733 NIL) (|nu| (S)))
         (SEQ (LETT |nu| (SPADCALL (SPADCALL |u| (QREFELT $ 9)) |fn|))
              (LETT |nl|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |f| NIL)
                          (LETT #1# (SPADCALL |u| (QREFELT $ 13))) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS
                                   (VECTOR (QVELT |f| 0)
                                           (SPADCALL (QVELT |f| 1) |fn|)
                                           (QVELT |f| 2))
                                   #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT (SPADCALL |nu| |nl| (QREFELT $ 19)))))) 

(DECLAIM (NOTINLINE |FactoredFunctions2;|)) 

(DEFUN |FactoredFunctions2| (&REST #1=#:G735)
  (SPROG NIL
         (PROG (#2=#:G736)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FactoredFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FactoredFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FactoredFunctions2|)))))))))) 

(DEFUN |FactoredFunctions2;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|FactoredFunctions2| DV$1 DV$2))
          (LETT $ (GETREFV 23))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FactoredFunctions2|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|FactoredFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Factored| 6) (0 . |unit|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 10) (|:| |factor| 6)
                        (|:| |exponent| (|NonNegativeInteger|)))
              (|List| 11) (5 . |factorList|) (10 . |One|) (14 . |One|)
              (|Record| (|:| |flag| 10) (|:| |factor| 7)
                        (|:| |exponent| (|NonNegativeInteger|)))
              (|List| 16) (|Factored| 7) (18 . |makeFR|) (|Mapping| 7 6)
              |FR2;map;MFF;1| |FR2;map_preserving;MFF;2|)
           '#(|map_preserving| 24 |map| 30) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|Factored| |#2|) (|Mapping| |#2| |#1|)
                                  (|Factored| |#1|)))
                                T)
                              '((|map_preserving|
                                 ((|Factored| |#2|) (|Mapping| |#2| |#1|)
                                  (|Factored| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 22
                                            '(1 8 6 0 9 1 8 12 0 13 0 6 0 14 0
                                              7 0 15 2 18 0 7 17 19 2 0 18 20 8
                                              22 2 0 18 20 8 21)))))
           '|lookupComplete|)) 
