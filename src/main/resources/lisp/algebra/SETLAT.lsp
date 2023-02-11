
(PUT '|SETLAT;subsetLattice;L$;1| '|SPADreplace| '(XLAM (|obj|) |obj|)) 

(SDEFUN |SETLAT;subsetLattice;L$;1| ((|obj| (|List| S)) ($ ($))) |obj|) 

(SDEFUN |SETLAT;/\\;3$;2| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL |a| |b| (QREFELT $ 11))) 

(SDEFUN |SETLAT;\\/;3$;3| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL |a| |b| (QREFELT $ 13))) 

(SDEFUN |SETLAT;complement;2$;4| ((|a| ($)) ($ ($)))
        (SPROG
         ((|r| (|List| S)) (|contains| (|Boolean|)) (#1=#:G715 NIL) (|c| NIL)
          (#2=#:G714 NIL) (|b| NIL))
         (SEQ (LETT |r| NIL)
              (SEQ (LETT |b| NIL) (LETT #2# (QREFELT $ 7)) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |b| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |contains| NIL)
                        (SEQ (LETT |c| NIL) (LETT #1# |a|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((SPADCALL |b| |c| (QREFELT $ 16))
                                 (LETT |contains| 'T)))))
                             (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (COND
                          ((NULL |contains|)
                           (LETT |r| (SPADCALL |r| |b| (QREFELT $ 17)))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |r|)))) 

(SDEFUN |SETLAT;complement;$L$;5| ((|a| ($)) (|pseudoTop| (|List| S)) ($ ($)))
        (SPROG
         ((|r| (|List| S)) (|contains| (|Boolean|)) (#1=#:G724 NIL) (|c| NIL)
          (#2=#:G723 NIL) (|b| NIL))
         (SEQ (LETT |r| NIL)
              (SEQ (LETT |b| NIL) (LETT #2# |pseudoTop|) G190
                   (COND
                    ((OR (ATOM #2#) (PROGN (LETT |b| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |contains| NIL)
                        (SEQ (LETT |c| NIL) (LETT #1# |a|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((SPADCALL |b| |c| (QREFELT $ 16))
                                 (LETT |contains| 'T)))))
                             (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                        (EXIT
                         (COND
                          ((NULL |contains|)
                           (LETT |r| (SPADCALL |r| |b| (QREFELT $ 17)))))))
                   (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT NIL))
              (EXIT |r|)))) 

(PUT '|SETLAT;hash;$Si;6| '|SPADreplace| '(XLAM (|s|) 0)) 

(SDEFUN |SETLAT;hash;$Si;6| ((|s| ($)) ($ (|SingleInteger|))) 0) 

(PUT '|SETLAT;=;2$B;7| '|SPADreplace| 'EQL) 

(SDEFUN |SETLAT;=;2$B;7| ((|x| ($)) (|y| ($)) ($ (|Boolean|))) (EQL |x| |y|)) 

(SDEFUN |SETLAT;~=;2$B;8| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (NULL (SPADCALL |x| |y| (QREFELT $ 22)))) 

(SDEFUN |SETLAT;coerce;$Of;9| ((|s| ($)) ($ (|OutputForm|)))
        (SPROG
         ((|oup| (|List| (|OutputForm|))) (#1=#:G735 NIL) (|x| NIL)
          (|inp| ($)))
         (SEQ (LETT |inp| |s|) (LETT |oup| NIL)
              (SEQ (LETT |x| NIL) (LETT #1# |inp|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |oup|
                           (SPADCALL |oup| (SPADCALL |x| (QREFELT $ 25))
                                     (QREFELT $ 27)))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |oup| (QREFELT $ 29)))))) 

(DECLAIM (NOTINLINE |SubsetLattice;|)) 

(DEFUN |SubsetLattice| (&REST #1=#:G736)
  (SPROG NIL
         (PROG (#2=#:G737)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(T NIL))
                                               (HGET |$ConstructorCache|
                                                     '|SubsetLattice|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |SubsetLattice;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|SubsetLattice|)))))))))) 

(DEFUN |SubsetLattice;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 |#2|)
          (LETT |dv$| (LIST '|SubsetLattice| DV$1 DV$2))
          (LETT $ (GETREFV 33))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|SubsetLattice| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 (|List| |#1|))
          $))) 

(MAKEPROP '|SubsetLattice| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|Rep|
              (|List| 6) |SETLAT;subsetLattice;L$;1| (0 . |setUnion|)
              |SETLAT;/\\;3$;2| (6 . |setIntersection|) |SETLAT;\\/;3$;3|
              (|Boolean|) (12 . =) (18 . |concat|) |SETLAT;complement;2$;4|
              |SETLAT;complement;$L$;5| (|SingleInteger|) |SETLAT;hash;$Si;6|
              |SETLAT;=;2$B;7| |SETLAT;~=;2$B;8| (|OutputForm|) (24 . |coerce|)
              (|List| 24) (29 . |concat|) (|List| $) (35 . |bracket|)
              |SETLAT;coerce;$Of;9| (|String|) (|HashState|))
           '#(~= 40 |subsetLattice| 46 |latex| 51 |hashUpdate!| 56 |hash| 62
              |complement| 67 |coerce| 78 |\\/| 83 = 89 |/\\| 95)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0))
                 (CONS '#(NIL NIL NIL |SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|Lattice|) (|MeetSemilattice|) (|JoinSemilattice|)
                           (|SetCategory|) (|BasicType|) (|CoercibleTo| 24))
                        (|makeByteWordVec2| 32
                                            '(2 9 0 0 0 11 2 9 0 0 0 13 2 6 15
                                              0 0 16 2 9 0 0 6 17 1 6 24 0 25 2
                                              26 0 0 24 27 1 24 0 28 29 2 0 15
                                              0 0 23 1 0 0 9 10 1 0 31 0 1 2 0
                                              32 32 0 1 1 0 20 0 21 1 0 0 0 18
                                              2 0 0 0 9 19 1 0 24 0 30 2 0 0 0
                                              0 14 2 0 15 0 0 22 2 0 0 0 0
                                              12)))))
           '|lookupComplete|)) 
