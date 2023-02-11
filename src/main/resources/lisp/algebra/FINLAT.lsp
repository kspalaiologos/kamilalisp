
(PUT '|FINLAT;finiteLattice;Nni$;1| '|SPADreplace| '(XLAM (|index|) |index|)) 

(SDEFUN |FINLAT;finiteLattice;Nni$;1|
        ((|index| (|NonNegativeInteger|)) ($ ($))) |index|) 

(SDEFUN |FINLAT;index;Pi$;2| ((|n| (|PositiveInteger|)) ($ ($)))
        (SPADCALL (- |n| 1) (QREFELT $ 10))) 

(PUT '|FINLAT;lookup;$Pi;3| '|SPADreplace| '(XLAM (|el|) (+ |el| 1))) 

(SDEFUN |FINLAT;lookup;$Pi;3| ((|el| ($)) ($ (|PositiveInteger|))) (+ |el| 1)) 

(SDEFUN |FINLAT;size;Nni;4| (($ (|NonNegativeInteger|)))
        (LENGTH (SPADCALL (QREFELT $ 7) (QREFELT $ 16)))) 

(SDEFUN |FINLAT;finiteLattice;S$;5| ((|obj| (S)) ($ ($)))
        (SPADCALL (QREFELT $ 7) |obj| (QREFELT $ 18))) 

(SDEFUN |FINLAT;/\\;3$;6| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (QREFELT $ 7) |a| |b| (QREFELT $ 20))) 

(SDEFUN |FINLAT;\\/;3$;7| ((|a| ($)) (|b| ($)) ($ ($)))
        (SPADCALL (QREFELT $ 7) |a| |b| (QREFELT $ 22))) 

(PUT '|FINLAT;hash;$Si;8| '|SPADreplace| '(XLAM (|s|) 0)) 

(SDEFUN |FINLAT;hash;$Si;8| ((|s| ($)) ($ (|SingleInteger|))) 0) 

(SDEFUN |FINLAT;=;2$B;9| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPADCALL |x| |y| (QREFELT $ 27))) 

(SDEFUN |FINLAT;~=;2$B;10| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (NULL (SPADCALL |x| |y| (QREFELT $ 27)))) 

(SDEFUN |FINLAT;coerce;$Of;11| ((|s| ($)) ($ (|OutputForm|)))
        (SPROG ((|obj| (S)) (|index| (|NonNegativeInteger|)))
               (SEQ (LETT |index| |s|)
                    (LETT |obj|
                          (SPADCALL (QREFELT $ 7) |index| (QREFELT $ 29)))
                    (EXIT (SPADCALL |obj| (QREFELT $ 31)))))) 

(DECLAIM (NOTINLINE |FiniteLattice;|)) 

(DEFUN |FiniteLattice| (&REST #1=#:G712)
  (SPROG NIL
         (PROG (#2=#:G713)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(T NIL))
                                               (HGET |$ConstructorCache|
                                                     '|FiniteLattice|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |FiniteLattice;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|FiniteLattice|)))))))))) 

(DEFUN |FiniteLattice;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 |#2|)
          (LETT |dv$| (LIST '|FiniteLattice| DV$1 DV$2))
          (LETT $ (GETREFV 37))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FiniteLattice| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 (|NonNegativeInteger|))
          $))) 

(MAKEPROP '|FiniteLattice| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) '|Rep|
              (|NonNegativeInteger|) |FINLAT;finiteLattice;Nni$;1|
              (|PositiveInteger|) |FINLAT;index;Pi$;2| |FINLAT;lookup;$Pi;3|
              (|List| 6) (|FiniteBiCPO| 6) (0 . |getVert|) |FINLAT;size;Nni;4|
              (5 . |objectToIndex|) |FINLAT;finiteLattice;S$;5| (11 . |meet|)
              |FINLAT;/\\;3$;6| (18 . |join|) |FINLAT;\\/;3$;7|
              (|SingleInteger|) |FINLAT;hash;$Si;8| (|Boolean|)
              |FINLAT;=;2$B;9| |FINLAT;~=;2$B;10| (25 . |indexToObject|)
              (|OutputForm|) (31 . |coerce|) |FINLAT;coerce;$Of;11|
              (|InputForm|) (|List| $) (|String|) (|HashState|))
           '#(~= 36 |smaller?| 42 |size| 48 |random| 52 |lookup| 56 |latex| 61
              |index| 66 |hashUpdate!| 71 |hash| 77 |finiteLattice| 82
              |enumerate| 92 |convert| 96 |coerce| 101 |\\/| 106 = 112 |/\\|
              118)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0 0 0 0 0))
                 (CONS
                  '#(NIL |Finite&| NIL NIL NIL |SetCategory&| NIL |BasicType&|
                     NIL)
                  (CONS
                   '#((|Lattice|) (|Finite|) (|MeetSemilattice|) (|Comparable|)
                      (|JoinSemilattice|) (|SetCategory|) (|ConvertibleTo| 33)
                      (|BasicType|) (|CoercibleTo| 30))
                   (|makeByteWordVec2| 36
                                       '(1 15 14 0 16 2 15 9 0 6 18 3 15 9 0 9
                                         9 20 3 15 9 0 9 9 22 2 15 6 0 9 29 1 6
                                         30 0 31 2 0 26 0 0 28 2 0 26 0 0 1 0 0
                                         9 17 0 0 0 1 1 0 11 0 13 1 0 35 0 1 1
                                         0 0 11 12 2 0 36 36 0 1 1 0 24 0 25 1
                                         0 0 9 10 1 0 0 6 19 0 0 34 1 1 0 33 0
                                         1 1 0 30 0 32 2 0 0 0 0 23 2 0 26 0 0
                                         27 2 0 0 0 0 21)))))
           '|lookupComplete|)) 
