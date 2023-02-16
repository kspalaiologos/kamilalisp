
(SDEFUN |CSTTOOLS;cycleElt;STU;1| ((|x| (ST)) ($ (|Union| ST "failed")))
        (SPROG ((#1=#:G715 NIL) (#2=#:G716 NIL) (|y| (ST)) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ (LETT |y| |x|)
                      (EXIT
                       (SEQ (LETT |i| 0) G190 NIL
                            (SEQ
                             (EXIT
                              (COND
                               ((OR (SPADCALL |y| (QREFELT $ 9))
                                    (SPADCALL |y| (QREFELT $ 10)))
                                (PROGN
                                 (LETT #2# (CONS 1 "failed"))
                                 (GO #3=#:G714)))
                               ('T
                                (SEQ (LETT |y| (SPADCALL |y| (QREFELT $ 11)))
                                     (COND
                                      ((ODDP |i|)
                                       (LETT |x|
                                             (SPADCALL |x| (QREFELT $ 11)))))
                                     (EXIT
                                      (COND
                                       ((SPADCALL |x| |y| (QREFELT $ 12))
                                        (PROGN
                                         (LETT #1#
                                               (PROGN
                                                (LETT #2# (CONS 0 |y|))
                                                (GO #3#)))
                                         (GO #4=#:G708)))))))))
                             #4# (EXIT #1#))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL)))))
                #3# (EXIT #2#)))) 

(SDEFUN |CSTTOOLS;computeCycleLength;STNni;2|
        ((|cycElt| (ST)) ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G722 NIL) (#2=#:G723 NIL) (|y| (ST)) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ (LETT |y| |cycElt|)
                      (EXIT
                       (SEQ (LETT |i| 1) G190 NIL
                            (SEQ
                             (EXIT
                              (SEQ (LETT |y| (SPADCALL |y| (QREFELT $ 11)))
                                   (EXIT
                                    (COND
                                     ((SPADCALL |y| |cycElt| (QREFELT $ 12))
                                      (PROGN
                                       (LETT #1#
                                             (PROGN
                                              (LETT #2# |i|)
                                              (GO #3=#:G721)))
                                       (GO #4=#:G718)))))))
                             #4# (EXIT #1#))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT NIL)))))
                #3# (EXIT #2#)))) 

(SDEFUN |CSTTOOLS;computeCycleEntry;3ST;3|
        ((|x| (ST)) (|cycElt| (ST)) ($ (ST)))
        (SPROG ((|y| (ST)) (#1=#:G730 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (LETT |y|
                        (SPADCALL |x| (SPADCALL |cycElt| (QREFELT $ 16))
                                  (QREFELT $ 17)))
                  (EXIT
                   (SEQ G190 NIL
                        (SEQ
                         (EXIT
                          (COND
                           ((SPADCALL |x| |y| (QREFELT $ 12))
                            (PROGN (LETT #1# |x|) (GO #2=#:G729)))
                           ('T
                            (SEQ (LETT |x| (SPADCALL |x| (QREFELT $ 11)))
                                 (EXIT
                                  (LETT |y|
                                        (SPADCALL |y| (QREFELT $ 11)))))))))
                        NIL (GO G190) G191 (EXIT NIL)))))
                #2# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |CyclicStreamTools;|)) 

(DEFUN |CyclicStreamTools| (&REST #1=#:G731)
  (SPROG NIL
         (PROG (#2=#:G732)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|CyclicStreamTools|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |CyclicStreamTools;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|CyclicStreamTools|)))))))))) 

(DEFUN |CyclicStreamTools;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|CyclicStreamTools| DV$1 DV$2))
          (LETT $ (GETREFV 19))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|CyclicStreamTools| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|CyclicStreamTools| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Boolean|)
              (0 . |explicitlyEmpty?|) (5 . |lazy?|) (10 . |rst|) (15 . |eq?|)
              (|Union| 7 '#1="failed") |CSTTOOLS;cycleElt;STU;1|
              (|NonNegativeInteger|) |CSTTOOLS;computeCycleLength;STNni;2|
              (21 . |rest|) |CSTTOOLS;computeCycleEntry;3ST;3|)
           '#(|cycleElt| 27 |computeCycleLength| 32 |computeCycleEntry| 37)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|cycleElt| ((|Union| |#2| #1#) |#2|)) T)
                                   '((|computeCycleLength|
                                      ((|NonNegativeInteger|) |#2|))
                                     T)
                                   '((|computeCycleEntry| (|#2| |#2| |#2|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 18
                                            '(1 7 8 0 9 1 7 8 0 10 1 7 0 0 11 2
                                              7 8 0 0 12 2 7 0 0 15 17 1 0 13 7
                                              14 1 0 15 7 16 2 0 7 7 7 18)))))
           '|lookupComplete|)) 
