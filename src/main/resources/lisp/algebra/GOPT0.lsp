
(SDEFUN |GOPT0;maxLevel;LU;1|
        ((|l| (|List| (|GuessOption|)))
         ($ (|Union| (|NonNegativeInteger|) "arbitrary")))
        (SPROG ((|opt| (|Union| (|Any|) "failed")))
               (SEQ (LETT |opt| (SPADCALL |l| '|maxLevel| (QREFELT $ 10)))
                    (EXIT
                     (COND ((QEQCAR |opt| 1) (CONS 1 "arbitrary"))
                           ('T (SPADCALL (QCDR |opt|) (QREFELT $ 14)))))))) 

(SDEFUN |GOPT0;maxDerivative;LU;2|
        ((|l| (|List| (|GuessOption|)))
         ($ (|Union| (|NonNegativeInteger|) "arbitrary")))
        (SPROG ((|opt| (|Union| (|Any|) "failed")))
               (SEQ (LETT |opt| (SPADCALL |l| '|maxDerivative| (QREFELT $ 10)))
                    (EXIT
                     (COND ((QEQCAR |opt| 1) (CONS 1 "arbitrary"))
                           ('T (SPADCALL (QCDR |opt|) (QREFELT $ 14)))))))) 

(SDEFUN |GOPT0;maxShift;LU;3|
        ((|l| (|List| (|GuessOption|)))
         ($ (|Union| (|NonNegativeInteger|) "arbitrary")))
        (SPADCALL |l| (QREFELT $ 17))) 

(SDEFUN |GOPT0;maxSubst;LU;4|
        ((|l| (|List| (|GuessOption|)))
         ($ (|Union| (|PositiveInteger|) "arbitrary")))
        (SPROG
         ((#1=#:G735 NIL) (|d| (|Union| (|NonNegativeInteger|) "arbitrary")))
         (SEQ (LETT |d| (SPADCALL |l| (QREFELT $ 17)))
              (EXIT
               (COND
                ((QEQCAR |d| 0)
                 (CONS 0
                       (PROG1 (LETT #1# (+ (QCDR |d|) 1))
                         (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                           '(|NonNegativeInteger|) #1#))))
                ('T (CONS 1 (QCDR |d|)))))))) 

(SDEFUN |GOPT0;maxDegree;LU;5|
        ((|l| (|List| (|GuessOption|)))
         ($ (|Union| (|NonNegativeInteger|) "arbitrary")))
        (SPROG ((|opt| (|Union| (|Any|) "failed")))
               (SEQ (LETT |opt| (SPADCALL |l| '|maxDegree| (QREFELT $ 10)))
                    (EXIT
                     (COND ((QEQCAR |opt| 1) (CONS 1 "arbitrary"))
                           ('T (SPADCALL (QCDR |opt|) (QREFELT $ 14)))))))) 

(SDEFUN |GOPT0;maxMixedDegree;LNni;6|
        ((|l| (|List| (|GuessOption|))) ($ (|NonNegativeInteger|)))
        (SPROG ((|opt| (|Union| (|Any|) "failed")))
               (SEQ
                (LETT |opt| (SPADCALL |l| '|maxMixedDegree| (QREFELT $ 10)))
                (EXIT
                 (COND ((QEQCAR |opt| 1) 0)
                       ('T (SPADCALL (QCDR |opt|) (QREFELT $ 24)))))))) 

(SDEFUN |GOPT0;allDegrees;LB;7|
        ((|l| (|List| (|GuessOption|))) ($ (|Boolean|)))
        (SPROG ((|opt| (|Union| (|Any|) "failed")))
               (SEQ (LETT |opt| (SPADCALL |l| '|allDegrees| (QREFELT $ 10)))
                    (EXIT
                     (COND ((QEQCAR |opt| 1) NIL)
                           ('T (SPADCALL (QCDR |opt|) (QREFELT $ 28)))))))) 

(SDEFUN |GOPT0;maxPower;LU;8|
        ((|l| (|List| (|GuessOption|)))
         ($ (|Union| (|PositiveInteger|) "arbitrary")))
        (SPROG ((|opt| (|Union| (|Any|) "failed")))
               (SEQ (LETT |opt| (SPADCALL |l| '|maxPower| (QREFELT $ 10)))
                    (EXIT
                     (COND ((QEQCAR |opt| 1) (CONS 1 "arbitrary"))
                           ('T (SPADCALL (QCDR |opt|) (QREFELT $ 31)))))))) 

(SDEFUN |GOPT0;safety;LNni;9|
        ((|l| (|List| (|GuessOption|))) ($ (|NonNegativeInteger|)))
        (SPROG ((|opt| (|Union| (|Any|) "failed")))
               (SEQ (LETT |opt| (SPADCALL |l| '|safety| (QREFELT $ 10)))
                    (EXIT
                     (COND ((QEQCAR |opt| 1) 1)
                           ('T (SPADCALL (QCDR |opt|) (QREFELT $ 24)))))))) 

(SDEFUN |GOPT0;check;LU;10|
        ((|l| (|List| (|GuessOption|)))
         ($ (|Union| "skip" "MonteCarlo" "deterministic")))
        (SPROG ((|opt| (|Union| (|Any|) "failed")))
               (SEQ (LETT |opt| (SPADCALL |l| '|check| (QREFELT $ 10)))
                    (EXIT
                     (COND ((QEQCAR |opt| 1) (CONS 2 "deterministic"))
                           ('T (SPADCALL (QCDR |opt|) (QREFELT $ 36)))))))) 

(SDEFUN |GOPT0;checkExtraValues;LB;11|
        ((|l| (|List| (|GuessOption|))) ($ (|Boolean|)))
        (SPROG ((|opt| (|Union| (|Any|) "failed")))
               (SEQ
                (LETT |opt| (SPADCALL |l| '|checkExtraValues| (QREFELT $ 10)))
                (EXIT
                 (COND ((QEQCAR |opt| 1) 'T)
                       ('T (SPADCALL (QCDR |opt|) (QREFELT $ 28)))))))) 

(SDEFUN |GOPT0;one;LB;12| ((|l| (|List| (|GuessOption|))) ($ (|Boolean|)))
        (SPROG ((|opt| (|Union| (|Any|) "failed")))
               (SEQ (LETT |opt| (SPADCALL |l| '|one| (QREFELT $ 10)))
                    (EXIT
                     (COND ((QEQCAR |opt| 1) 'T)
                           ('T (SPADCALL (QCDR |opt|) (QREFELT $ 28)))))))) 

(SDEFUN |GOPT0;debug;LB;13| ((|l| (|List| (|GuessOption|))) ($ (|Boolean|)))
        (SPROG ((|opt| (|Union| (|Any|) "failed")))
               (SEQ (LETT |opt| (SPADCALL |l| '|debug| (QREFELT $ 10)))
                    (EXIT
                     (COND ((QEQCAR |opt| 1) NIL)
                           ('T (SPADCALL (QCDR |opt|) (QREFELT $ 28)))))))) 

(SDEFUN |GOPT0;homogeneous;LU;14|
        ((|l| (|List| (|GuessOption|)))
         ($ (|Union| (|PositiveInteger|) (|Boolean|))))
        (SPROG ((|opt| (|Union| (|Any|) "failed")))
               (SEQ (LETT |opt| (SPADCALL |l| '|homogeneous| (QREFELT $ 10)))
                    (EXIT
                     (COND ((QEQCAR |opt| 1) (CONS 1 NIL))
                           ('T (SPADCALL (QCDR |opt|) (QREFELT $ 43)))))))) 

(SDEFUN |GOPT0;Somos;LU;15|
        ((|l| (|List| (|GuessOption|)))
         ($ (|Union| (|PositiveInteger|) (|Boolean|))))
        (SPROG ((|opt| (|Union| (|Any|) "failed")))
               (SEQ (LETT |opt| (SPADCALL |l| '|Somos| (QREFELT $ 10)))
                    (EXIT
                     (COND ((QEQCAR |opt| 1) (CONS 1 NIL))
                           ('T (SPADCALL (QCDR |opt|) (QREFELT $ 43)))))))) 

(SDEFUN |GOPT0;variableName;LS;16|
        ((|l| (|List| (|GuessOption|))) ($ (|Symbol|)))
        (SPROG ((|opt| (|Union| (|Any|) "failed")))
               (SEQ (LETT |opt| (SPADCALL |l| '|variableName| (QREFELT $ 10)))
                    (EXIT
                     (COND ((QEQCAR |opt| 1) '|x|)
                           ('T (SPADCALL (QCDR |opt|) (QREFELT $ 47)))))))) 

(SDEFUN |GOPT0;functionName;LS;17|
        ((|l| (|List| (|GuessOption|))) ($ (|Symbol|)))
        (SPROG ((|opt| (|Union| (|Any|) "failed")))
               (SEQ (LETT |opt| (SPADCALL |l| '|functionName| (QREFELT $ 10)))
                    (EXIT
                     (COND ((QEQCAR |opt| 1) '|f|)
                           ('T (SPADCALL (QCDR |opt|) (QREFELT $ 47)))))))) 

(SDEFUN |GOPT0;functionNames;LL;18|
        ((|l| (|List| (|GuessOption|))) ($ (|List| (|Symbol|))))
        (SPROG ((|opt| (|Union| (|Any|) "failed")))
               (SEQ (LETT |opt| (SPADCALL |l| '|functionNames| (QREFELT $ 10)))
                    (EXIT
                     (COND ((QEQCAR |opt| 1) NIL)
                           ('T (SPADCALL (QCDR |opt|) (QREFELT $ 52)))))))) 

(SDEFUN |GOPT0;indexName;LS;19| ((|l| (|List| (|GuessOption|))) ($ (|Symbol|)))
        (SPROG ((|opt| (|Union| (|Any|) "failed")))
               (SEQ (LETT |opt| (SPADCALL |l| '|indexName| (QREFELT $ 10)))
                    (EXIT
                     (COND ((QEQCAR |opt| 1) '|n|)
                           ('T (SPADCALL (QCDR |opt|) (QREFELT $ 47)))))))) 

(SDEFUN |GOPT0;displayKind;LS;20|
        ((|l| (|List| (|GuessOption|))) ($ (|Symbol|)))
        (SPROG ((|opt| (|Union| (|Any|) "failed")))
               (SEQ (LETT |opt| (SPADCALL |l| '|displayKind| (QREFELT $ 10)))
                    (EXIT
                     (COND
                      ((QEQCAR |opt| 1)
                       (|error| "GuessOption: displayKind not set"))
                      ('T (SPADCALL (QCDR |opt|) (QREFELT $ 47)))))))) 

(SDEFUN |GOPT0;checkOptions;LV;21|
        ((|l| (|List| (|GuessOption|))) ($ (|Void|)))
        (SPROG
         ((|Somo| (|Union| (|PositiveInteger|) (|Boolean|)))
          (|homo| (|Union| (|PositiveInteger|) (|Boolean|)))
          (|maxP| (|Union| (|PositiveInteger|) "arbitrary"))
          (|maxD| (|Union| (|NonNegativeInteger|) "arbitrary")))
         (SEQ (LETT |maxD| (SPADCALL |l| (QREFELT $ 17)))
              (LETT |maxP| (SPADCALL |l| (QREFELT $ 32)))
              (LETT |homo| (SPADCALL |l| (QREFELT $ 44)))
              (LETT |Somo| (SPADCALL |l| (QREFELT $ 45)))
              (COND
               ((QEQCAR |Somo| 0)
                (SEQ
                 (COND
                  ((EQL (QCDR |Somo|) 1)
                   (|error| "Guess: Somos must be Boolean or at least two")))
                 (COND
                  ((QEQCAR |maxP| 0)
                   (COND
                    ((EQL (QCDR |maxP|) 1)
                     (|error|
                      "Guess: Somos requires that maxPower is at least two")))))
                 (EXIT
                  (COND
                   ((QEQCAR |maxD| 0)
                    (COND
                     ((> (QCDR |maxD|) (QCDR |Somo|))
                      (|error|
                       (SPADCALL
                        "Guess: if Somos is an integer, it should be larger"
                        " than maxDerivative/maxShift or at least as big as maxSubst"
                        (QREFELT $ 57))))))))))
               ((QCDR |Somo|)
                (SEQ
                 (COND
                  ((QEQCAR |maxP| 0)
                   (COND
                    ((EQL (QCDR |maxP|) 1)
                     (|error|
                      "Guess: Somos requires that maxPower is at least two")))))
                 (COND
                  ((QEQCAR |maxD| 0)
                   (COND
                    ((OR (ZEROP (QCDR |maxD|)) (EQL (QCDR |maxD|) 1))
                     (|error|
                      (SPADCALL
                       #1="Guess: Somos==true requires that maxDerivative/"
                       (SPADCALL
                        #2="maxShift is an integer, at least two, or maxSubst is"
                        #3=" an integer, at least three" (QREFELT $ 57))
                       (QREFELT $ 57))))))
                  ('T
                   (|error|
                    (SPADCALL #1# (SPADCALL #2# #3# (QREFELT $ 57))
                              (QREFELT $ 57)))))
                 (EXIT
                  (COND
                   ((NULL (QEQCAR |maxP| 0))
                    (COND
                     ((QEQCAR |homo| 1)
                      (COND
                       ((NULL (QCDR |homo|))
                        (|error|
                         (SPADCALL
                          "Guess: Somos requires that maxPower is set or"
                          " homogeneous is not false"
                          (QREFELT $ 57)))))))))))))
              (EXIT
               (COND
                ((QEQCAR |homo| 0)
                 (SEQ
                  (COND
                   ((QEQCAR |maxP| 0)
                    (COND
                     ((SPADCALL (QCDR |maxP|) (QCDR |homo|) (QREFELT $ 59))
                      (|error|
                       (SPADCALL
                        "Guess: only one of homogeneous and maxPower may be"
                        " an integer" (QREFELT $ 57)))))))
                  (EXIT
                   (COND
                    ((QEQCAR |maxD| 0)
                     (COND
                      ((ZEROP (QCDR |maxD|))
                       (|error|
                        (SPADCALL
                         "Guess: homogeneous requires that maxShift/maxDerivative"
                         " is at least one or maxSubst is at least two"
                         (QREFELT $ 57))))))))))
                ((QCDR |homo|)
                 (SEQ
                  (COND
                   ((NULL (QEQCAR |maxP| 0))
                    (|error|
                     (SPADCALL
                      "Guess: homogeneous==true requires that maxPower"
                      " is an integer" (QREFELT $ 57)))))
                  (EXIT
                   (COND
                    ((QEQCAR |maxD| 0)
                     (COND
                      ((ZEROP (QCDR |maxD|))
                       (|error|
                        (SPADCALL "Guess: homogeneous requires that maxShift/"
                                  (SPADCALL
                                   "maxDerivative is at least one or maxSubst is"
                                   " at least two" (QREFELT $ 57))
                                  (QREFELT $ 57))))))))))))))) 

(DECLAIM (NOTINLINE |GuessOptionFunctions0;|)) 

(DEFUN |GuessOptionFunctions0| ()
  (SPROG NIL
         (PROG (#1=#:G873)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|GuessOptionFunctions0|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|GuessOptionFunctions0|
                             (LIST
                              (CONS NIL (CONS 1 (|GuessOptionFunctions0;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache| '|GuessOptionFunctions0|)))))))))) 

(DEFUN |GuessOptionFunctions0;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|GuessOptionFunctions0|))
          (LETT $ (GETREFV 65))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|GuessOptionFunctions0| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|GuessOptionFunctions0| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Union| 12 '"failed") (|List| $)
              (|Symbol|) (|GuessOption|) (0 . |option|)
              (|Union| 22 '"arbitrary") (|Any|) (|AnyFunctions1| 11)
              (6 . |retract|) (|List| 9) |GOPT0;maxLevel;LU;1|
              |GOPT0;maxDerivative;LU;2| |GOPT0;maxShift;LU;3|
              (|Union| 58 '"arbitrary") |GOPT0;maxSubst;LU;4|
              |GOPT0;maxDegree;LU;5| (|NonNegativeInteger|)
              (|AnyFunctions1| 22) (11 . |retract|)
              |GOPT0;maxMixedDegree;LNni;6| (|Boolean|) (|AnyFunctions1| 26)
              (16 . |retract|) |GOPT0;allDegrees;LB;7| (|AnyFunctions1| 19)
              (21 . |retract|) |GOPT0;maxPower;LU;8| |GOPT0;safety;LNni;9|
              (|Union| '"skip" '"MonteCarlo" '"deterministic")
              (|AnyFunctions1| 34) (26 . |retract|) |GOPT0;check;LU;10|
              |GOPT0;checkExtraValues;LB;11| |GOPT0;one;LB;12|
              |GOPT0;debug;LB;13| (|Union| 58 26) (|AnyFunctions1| 41)
              (31 . |retract|) |GOPT0;homogeneous;LU;14| |GOPT0;Somos;LU;15|
              (|AnyFunctions1| 8) (36 . |retract|) |GOPT0;variableName;LS;16|
              |GOPT0;functionName;LS;17| (|List| 8) (|AnyFunctions1| 50)
              (41 . |retract|) |GOPT0;functionNames;LL;18|
              |GOPT0;indexName;LS;19| |GOPT0;displayKind;LS;20| (|String|)
              (46 . |elt|) (|PositiveInteger|) (52 . ~=) (|Void|)
              |GOPT0;checkOptions;LV;21| (|HashState|) (|OutputForm|)
              (|SingleInteger|))
           '#(~= 58 |variableName| 64 |safety| 69 |one| 74 |maxSubst| 79
              |maxShift| 84 |maxPower| 89 |maxMixedDegree| 94 |maxLevel| 99
              |maxDerivative| 104 |maxDegree| 109 |latex| 114 |indexName| 119
              |homogeneous| 124 |hashUpdate!| 129 |hash| 135 |functionNames|
              140 |functionName| 145 |displayKind| 150 |debug| 155 |coerce| 160
              |checkOptions| 165 |checkExtraValues| 170 |check| 175
              |allDegrees| 180 |Somos| 185 = 190)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 63))
                        (|makeByteWordVec2| 64
                                            '(2 9 6 7 8 10 1 13 11 12 14 1 23
                                              22 12 24 1 27 26 12 28 1 30 19 12
                                              31 1 35 34 12 36 1 42 41 12 43 1
                                              46 8 12 47 1 51 50 12 52 2 56 0 0
                                              0 57 2 58 26 0 0 59 2 0 26 0 0 1
                                              1 0 8 15 48 1 0 22 15 33 1 0 26
                                              15 39 1 0 19 15 20 1 0 11 15 18 1
                                              0 19 15 32 1 0 22 15 25 1 0 11 15
                                              16 1 0 11 15 17 1 0 11 15 21 1 0
                                              56 0 1 1 0 8 15 54 1 0 41 15 44 2
                                              0 62 62 0 1 1 0 64 0 1 1 0 50 15
                                              53 1 0 8 15 49 1 0 8 15 55 1 0 26
                                              15 40 1 0 63 0 1 1 0 60 15 61 1 0
                                              26 15 38 1 0 34 15 37 1 0 26 15
                                              29 1 0 41 15 45 2 0 26 0 0 1)))))
           '|lookupComplete|)) 

(MAKEPROP '|GuessOptionFunctions0| 'NILADIC T) 
