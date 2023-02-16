
(PUT '|FMOEBF;rep| '|SPADreplace| '(XLAM (|x|) |x|)) 

(SDEFUN |FMOEBF;rep| ((|x| ($)) ($ (|Rep|))) |x|) 

(PUT '|FMOEBF;per| '|SPADreplace| '(XLAM (|r|) |r|)) 

(SDEFUN |FMOEBF;per| ((|r| (|Rep|)) ($ ($))) |r|) 

(SDEFUN |FMOEBF;members;$L;3| ((|mf| ($)) ($ (|List| P)))
        (QCDR (|FMOEBF;rep| |mf| $))) 

(SDEFUN |FMOEBF;moebiusFunction;L$;4| ((|xx| (|List| P)) ($ ($)))
        (SPROG
         ((|mf| (|Matrix| (|Integer|))) (|zf| (|Matrix| (|Integer|)))
          (#1=#:G718 NIL) (|y| NIL) (#2=#:G717 NIL) (#3=#:G716 NIL) (|x| NIL)
          (#4=#:G715 NIL) (|xxo| (|List| P)))
         (SEQ
          (LETT |xxo|
                (SPADCALL (SPADCALL (ELT $ 11) |xx| (QREFELT $ 14))
                          (QREFELT $ 15)))
          (LETT |zf|
                (SPADCALL
                 (PROGN
                  (LETT #4# NIL)
                  (SEQ (LETT |x| NIL) (LETT #3# |xxo|) G190
                       (COND
                        ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #4#
                               (CONS
                                (PROGN
                                 (LETT #2# NIL)
                                 (SEQ (LETT |y| NIL) (LETT #1# |xxo|) G190
                                      (COND
                                       ((OR (ATOM #1#)
                                            (PROGN (LETT |y| (CAR #1#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #2#
                                              (CONS
                                               (COND
                                                ((SPADCALL |x| |y|
                                                           (QREFELT $ 11))
                                                 1)
                                                ('T 0))
                                               #2#))))
                                      (LETT #1# (CDR #1#)) (GO G190) G191
                                      (EXIT (NREVERSE #2#))))
                                #4#))))
                       (LETT #3# (CDR #3#)) (GO G190) G191
                       (EXIT (NREVERSE #4#))))
                 (QREFELT $ 18)))
          (LETT |mf| (SPADCALL |zf| 1 (QREFELT $ 21)))
          (EXIT (|FMOEBF;per| (CONS |mf| |xxo|) $))))) 

(SDEFUN |FMOEBF;canonicalZeta| ((|pi| (P)) (|si| (P)) ($ (|Integer|)))
        (SPROG ((#1=#:G721 NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (COND
                   ((SPADCALL |pi| |si| (QREFELT $ 11))
                    (PROGN (LETT #1# 1) (GO #2=#:G720))))
                  (EXIT 0)))
                #2# (EXIT #1#)))) 

(SDEFUN |FMOEBF;moebiusMu;$2PI;6|
        ((|mf| ($)) (|x| (P)) (|y| (P)) ($ (|Integer|)))
        (SPROG
         ((#1=#:G727 NIL) (|ky| #2=(|Integer|)) (|kx| #2#)
          (|mfn| (|Matrix| (|Integer|))))
         (SEQ
          (EXIT
           (SEQ (LETT |mfn| (QCAR (|FMOEBF;rep| |mf| $)))
                (LETT |kx|
                      (SPADCALL |x| (SPADCALL |mf| (QREFELT $ 9))
                                (QREFELT $ 23)))
                (LETT |ky|
                      (SPADCALL |y| (SPADCALL |mf| (QREFELT $ 9))
                                (QREFELT $ 23)))
                (COND
                 ((OR (ZEROP |kx|) (ZEROP |ky|))
                  (EXIT (|error| "not members"))))
                (EXIT
                 (PROGN
                  (LETT #1# (SPADCALL |mfn| |kx| |ky| (QREFELT $ 24)))
                  (GO #3=#:G726)))))
          #3# (EXIT #1#)))) 

(SDEFUN |FMOEBF;apply;$2PI;7| ((|mf| ($)) (|x| (P)) (|y| (P)) ($ (|Integer|)))
        (SPROG
         ((#1=#:G733 NIL) (|ky| #2=(|Integer|)) (|kx| #2#)
          (|mfn| (|Matrix| (|Integer|))))
         (SEQ
          (EXIT
           (SEQ (LETT |mfn| (QCAR (|FMOEBF;rep| |mf| $)))
                (LETT |kx|
                      (SPADCALL |x| (SPADCALL |mf| (QREFELT $ 9))
                                (QREFELT $ 23)))
                (LETT |ky|
                      (SPADCALL |y| (SPADCALL |mf| (QREFELT $ 9))
                                (QREFELT $ 23)))
                (COND
                 ((OR (ZEROP |kx|) (ZEROP |ky|))
                  (EXIT (|error| "not members"))))
                (EXIT
                 (PROGN
                  (LETT #1# (SPADCALL |mfn| |kx| |ky| (QREFELT $ 24)))
                  (GO #3=#:G732)))))
          #3# (EXIT #1#)))) 

(SDEFUN |FMOEBF;moebiusMatrix;$M;8| ((|mf| ($)) ($ (|Matrix| (|Integer|))))
        (QCAR (|FMOEBF;rep| |mf| $))) 

(SDEFUN |FMOEBF;coerce;$Of;9| ((|mf| ($)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL "Moebius Function" (QREFELT $ 30))
                  (SPADCALL (SPADCALL |mf| (QREFELT $ 9)) (QREFELT $ 31))
                  (QREFELT $ 32))) 

(DECLAIM (NOTINLINE |FiniteMoebiusFunction;|)) 

(DEFUN |FiniteMoebiusFunction| (#1=#:G740)
  (SPROG NIL
         (PROG (#2=#:G741)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|FiniteMoebiusFunction|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|FiniteMoebiusFunction;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|FiniteMoebiusFunction|)))))))))) 

(DEFUN |FiniteMoebiusFunction;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|FiniteMoebiusFunction| DV$1))
          (LETT $ (GETREFV 36))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FiniteMoebiusFunction| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record| (|:| |matrix| (|Matrix| (|Integer|)))
                              (|:| |indices| (|List| |#1|))))
          $))) 

(MAKEPROP '|FiniteMoebiusFunction| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|List| 6)
              |FMOEBF;members;$L;3| (|Boolean|) (0 . <=) (|Mapping| 10 6 6)
              (|ListPackage| 6) (6 . |topologicalSort|)
              (12 . |removeDuplicates|) (|List| (|List| 19)) (|Matrix| 19)
              (17 . |matrix|) (|Integer|)
              (|TriangularMatrixOperations| 19 (|Vector| 19) (|Vector| 19) 17)
              (22 . |UpTriBddDenomInv|) |FMOEBF;moebiusFunction;L$;4|
              (28 . |position|) (34 . |elt|) |FMOEBF;moebiusMu;$2PI;6|
              |FMOEBF;apply;$2PI;7| |FMOEBF;moebiusMatrix;$M;8| (|String|)
              (|OutputForm|) (41 . |message|) (46 . |coerce|) (51 . |hconcat|)
              |FMOEBF;coerce;$Of;9| (|SingleInteger|) (|HashState|))
           '#(~= 57 |moebiusMu| 63 |moebiusMatrix| 70 |moebiusFunction| 75
              |members| 80 |latex| 85 |hashUpdate!| 90 |hash| 96 |coerce| 101
              |apply| 106 = 113)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 29))
                        (|makeByteWordVec2| 35
                                            '(2 6 10 0 0 11 2 13 8 12 8 14 1 8
                                              0 0 15 1 17 0 16 18 2 20 17 17 19
                                              21 2 8 19 6 0 23 3 17 19 0 19 19
                                              24 1 29 0 28 30 1 8 29 0 31 2 29
                                              0 0 0 32 2 0 10 0 0 1 3 0 19 0 6
                                              6 25 1 0 17 0 27 1 0 0 8 22 1 0 8
                                              0 9 1 0 28 0 1 2 0 35 35 0 1 1 0
                                              34 0 1 1 0 29 0 33 3 0 19 0 6 6
                                              26 2 0 10 0 0 1)))))
           '|lookupComplete|)) 
