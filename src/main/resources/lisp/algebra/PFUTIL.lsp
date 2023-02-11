
(SDEFUN |PFUTIL;decompose;UP2L;1|
        ((|nn| (UP)) (|dens| (|List| UP)) ($ (|List| UP)))
        (SPROG
         ((#1=#:G725 NIL) (|res| (|List| UP)) (#2=#:G729 NIL) (|c| NIL)
          (#3=#:G728 NIL) (|fden| NIL) (|pfr| (|PartialFraction| UP))
          (|nd| (|Factored| UP)) (|fdens| (|List| (|Factored| UP)))
          (#4=#:G727 NIL) (|nden| NIL) (#5=#:G726 NIL))
         (SEQ
          (LETT |fdens|
                (PROGN
                 (LETT #5# NIL)
                 (SEQ (LETT |nden| NIL) (LETT #4# |dens|) G190
                      (COND
                       ((OR (ATOM #4#) (PROGN (LETT |nden| (CAR #4#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #5#
                              (CONS (SPADCALL |nden| 1 (QREFELT $ 12)) #5#))))
                      (LETT #4# (CDR #4#)) (GO G190) G191
                      (EXIT (NREVERSE #5#)))))
          (LETT |nd|
                (SPADCALL (ELT $ 14) |fdens| (|spadConstant| $ 15)
                          (QREFELT $ 18)))
          (LETT |pfr| (SPADCALL |nn| |nd| (QREFELT $ 20)))
          (EXIT
           (COND
            ((SPADCALL (SPADCALL |pfr| (QREFELT $ 21)) (|spadConstant| $ 22)
                       (QREFELT $ 24))
             (|error| "decompose: wholePart(pfr) ~= 0"))
            ('T
             (SEQ (LETT |res| NIL)
                  (SEQ (LETT |fden| NIL) (LETT #3# |fdens|) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |fden| (CAR #3#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (SEQ (LETT |c| NIL)
                              (LETT #2# (SPADCALL |pfr| (QREFELT $ 27))) G190
                              (COND
                               ((OR (ATOM #2#)
                                    (PROGN (LETT |c| (CAR #2#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL (QCDR |c|) |fden| (QREFELT $ 28))
                                  (SEQ (LETT |res| (CONS (QCAR |c|) |res|))
                                       (EXIT
                                        (PROGN
                                         (LETT #1# 1)
                                         (GO #6=#:G720))))))))
                              (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL)))
                        #6# (EXIT #1#))
                       (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                  (EXIT (NREVERSE |res|))))))))) 

(DECLAIM (NOTINLINE |PartialFractionUtilities;|)) 

(DEFUN |PartialFractionUtilities| (&REST #1=#:G730)
  (SPROG NIL
         (PROG (#2=#:G731)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PartialFractionUtilities|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PartialFractionUtilities;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|PartialFractionUtilities|)))))))))) 

(DEFUN |PartialFractionUtilities;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|PartialFractionUtilities| DV$1 DV$2))
          (LETT $ (GETREFV 31))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PartialFractionUtilities|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PartialFractionUtilities| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (0 . |One|)
              (4 . |One|) (|NonNegativeInteger|) (|Factored| 7)
              (8 . |nilFactor|) (14 . *) (20 . *) (26 . |One|)
              (|Mapping| 11 11 11) (|List| 11) (30 . |reduce|)
              (|PartialFraction| 7) (37 . |partialFraction|) (43 . |wholePart|)
              (48 . |Zero|) (|Boolean|) (52 . ~=)
              (|Record| (|:| |num| 7) (|:| |den| 11)) (|List| 25)
              (58 . |fractionalTerms|) (63 . =) (|List| 7)
              |PFUTIL;decompose;UP2L;1|)
           '#(|decompose| 69) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|decompose|
                                 ((|List| |#2|) |#2| (|List| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 30
                                            '(0 6 0 8 0 7 0 9 2 11 0 7 10 12 2
                                              7 0 0 0 13 2 11 0 0 0 14 0 11 0
                                              15 3 17 11 16 0 11 18 2 19 0 7 11
                                              20 1 19 7 0 21 0 7 0 22 2 7 23 0
                                              0 24 1 19 26 0 27 2 11 23 0 0 28
                                              2 0 29 7 29 30)))))
           '|lookupComplete|)) 
