
(SDEFUN |MRF2;map;MMrMr;1|
        ((|fn| (|Mapping| S R)) (|u| (|MonoidRing| R M))
         ($ (|MonoidRing| S M)))
        (SPROG ((|res| (|MonoidRing| S M)) (#1=#:G700 NIL) (|te| NIL))
               (SEQ (LETT |res| (|spadConstant| $ 10))
                    (SEQ (LETT |te| NIL)
                         (LETT #1# (SPADCALL |u| (QREFELT $ 14))) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |te| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |res|
                                 (SPADCALL |res|
                                           (SPADCALL
                                            (SPADCALL (QCDR |te|) |fn|)
                                            (QCAR |te|) (QREFELT $ 15))
                                           (QREFELT $ 16)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |res|)))) 

(DECLAIM (NOTINLINE |MonoidRingFunctions2;|)) 

(DEFUN |MonoidRingFunctions2| (&REST #1=#:G701)
  (SPROG NIL
         (PROG (#2=#:G702)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|MonoidRingFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |MonoidRingFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|MonoidRingFunctions2|)))))))))) 

(DEFUN |MonoidRingFunctions2;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|MonoidRingFunctions2| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 19))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|MonoidRingFunctions2|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|MonoidRingFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|MonoidRing| 7 8) (0 . |Zero|)
              (|Record| (|:| |k| 8) (|:| |c| 6)) (|List| 11) (|MonoidRing| 6 8)
              (4 . |terms|) (9 . |monomial|) (15 . +) (|Mapping| 7 6)
              |MRF2;map;MMrMr;1|)
           '#(|map| 21) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|MonoidRing| |#2| |#3|)
                                  (|Mapping| |#2| |#1|)
                                  (|MonoidRing| |#1| |#3|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 18
                                            '(0 9 0 10 1 13 12 0 14 2 9 0 7 8
                                              15 2 9 0 0 0 16 2 0 9 17 13
                                              18)))))
           '|lookupComplete|)) 
