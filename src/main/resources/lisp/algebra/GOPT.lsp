
(SDEFUN |GOPT;maxLevel;U$;1|
        ((|d| (|Union| (|NonNegativeInteger|) "arbitrary")) ($ ($)))
        (CONS '|maxLevel| (SPADCALL |d| (QREFELT $ 10)))) 

(SDEFUN |GOPT;maxDerivative;U$;2|
        ((|d| (|Union| (|NonNegativeInteger|) "arbitrary")) ($ ($)))
        (CONS '|maxDerivative| (SPADCALL |d| (QREFELT $ 10)))) 

(SDEFUN |GOPT;maxShift;U$;3|
        ((|d| (|Union| (|NonNegativeInteger|) "arbitrary")) ($ ($)))
        (SPADCALL |d| (QREFELT $ 12))) 

(SDEFUN |GOPT;maxSubst;U$;4|
        ((|d| (|Union| (|PositiveInteger|) "arbitrary")) ($ ($)))
        (SPROG ((#1=#:G719 NIL))
               (COND
                ((QEQCAR |d| 0)
                 (SPADCALL
                  (CONS 0
                        (PROG1 (LETT #1# (- (QCDR |d|) 1))
                          (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #1#)))
                  (QREFELT $ 12)))
                ('T (SPADCALL (CONS 1 (QCDR |d|)) (QREFELT $ 12)))))) 

(SDEFUN |GOPT;maxDegree;U$;5|
        ((|d| (|Union| (|NonNegativeInteger|) "arbitrary")) ($ ($)))
        (CONS '|maxDegree| (SPADCALL |d| (QREFELT $ 10)))) 

(SDEFUN |GOPT;maxMixedDegree;Nni$;6| ((|d| (|NonNegativeInteger|)) ($ ($)))
        (CONS '|maxMixedDegree| (SPADCALL |d| (QREFELT $ 19)))) 

(SDEFUN |GOPT;allDegrees;B$;7| ((|d| (|Boolean|)) ($ ($)))
        (CONS '|allDegrees| (SPADCALL |d| (QREFELT $ 23)))) 

(SDEFUN |GOPT;maxPower;U$;8|
        ((|d| (|Union| (|PositiveInteger|) "arbitrary")) ($ ($)))
        (CONS '|maxPower| (SPADCALL |d| (QREFELT $ 26)))) 

(SDEFUN |GOPT;safety;Nni$;9| ((|d| (|NonNegativeInteger|)) ($ ($)))
        (CONS '|safety| (SPADCALL |d| (QREFELT $ 19)))) 

(SDEFUN |GOPT;homogeneous;U$;10|
        ((|d| (|Union| (|PositiveInteger|) (|Boolean|))) ($ ($)))
        (CONS '|homogeneous| (SPADCALL |d| (QREFELT $ 31)))) 

(SDEFUN |GOPT;Somos;U$;11|
        ((|d| (|Union| (|PositiveInteger|) (|Boolean|))) ($ ($)))
        (CONS '|Somos| (SPADCALL |d| (QREFELT $ 31)))) 

(SDEFUN |GOPT;debug;B$;12| ((|d| (|Boolean|)) ($ ($)))
        (CONS '|debug| (SPADCALL |d| (QREFELT $ 23)))) 

(SDEFUN |GOPT;check;U$;13|
        ((|d| (|Union| "skip" "MonteCarlo" "deterministic")) ($ ($)))
        (CONS '|check| (SPADCALL |d| (QREFELT $ 37)))) 

(SDEFUN |GOPT;checkExtraValues;B$;14| ((|d| (|Boolean|)) ($ ($)))
        (CONS '|checkExtraValues| (SPADCALL |d| (QREFELT $ 23)))) 

(SDEFUN |GOPT;one;B$;15| ((|d| (|Boolean|)) ($ ($)))
        (CONS '|one| (SPADCALL |d| (QREFELT $ 23)))) 

(SDEFUN |GOPT;functionName;S$;16| ((|d| (|Symbol|)) ($ ($)))
        (CONS '|functionName| (SPADCALL |d| (QREFELT $ 43)))) 

(SDEFUN |GOPT;functionNames;L$;17| ((|d| (|List| (|Symbol|))) ($ ($)))
        (CONS '|functionNames| (SPADCALL |d| (QREFELT $ 47)))) 

(SDEFUN |GOPT;variableName;S$;18| ((|d| (|Symbol|)) ($ ($)))
        (CONS '|variableName| (SPADCALL |d| (QREFELT $ 43)))) 

(SDEFUN |GOPT;indexName;S$;19| ((|d| (|Symbol|)) ($ ($)))
        (CONS '|indexName| (SPADCALL |d| (QREFELT $ 43)))) 

(SDEFUN |GOPT;displayKind;S$;20| ((|d| (|Symbol|)) ($ ($)))
        (CONS '|displayKind| (SPADCALL |d| (QREFELT $ 43)))) 

(SDEFUN |GOPT;coerce;$Of;21| ((|x| ($)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL (QCAR |x|) (QREFELT $ 53))
                  (SPADCALL (QCDR |x|) (QREFELT $ 54)) (QREFELT $ 55))) 

(SDEFUN |GOPT;=;2$B;22| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND
         ((EQUAL (QCAR |x|) (QCAR |y|))
          (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 57)))
         ('T NIL))) 

(SDEFUN |GOPT;option;LSU;23|
        ((|l| (|List| $)) (|s| (|Symbol|)) ($ (|Union| (|Any|) "failed")))
        (SPROG ((#1=#:G793 NIL) (#2=#:G794 NIL) (#3=#:G795 NIL) (|x| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |x| NIL) (LETT #3# |l|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((EQUAL (QCAR |x|) |s|)
                             (PROGN
                              (LETT #1#
                                    (PROGN
                                     (LETT #2# (CONS 0 (QCDR |x|)))
                                     (GO #4=#:G792)))
                              (GO #5=#:G787))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT (CONS 1 "failed"))))
                #4# (EXIT #2#)))) 

(DECLAIM (NOTINLINE |GuessOption;|)) 

(DEFUN |GuessOption| ()
  (SPROG NIL
         (PROG (#1=#:G797)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|GuessOption|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|GuessOption|
                             (LIST (CONS NIL (CONS 1 (|GuessOption;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|GuessOption|)))))))))) 

(DEFUN |GuessOption;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|GuessOption|))
          (LETT $ (GETREFV 65))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|GuessOption| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6
                    (|Record| (|:| |keyword| (|Symbol|))
                              (|:| |value| (|Any|))))
          $))) 

(MAKEPROP '|GuessOption| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|Rep| (|Any|) (|Union| 17 '"arbitrary")
              (|AnyFunctions1| 8) (0 . |coerce|) |GOPT;maxLevel;U$;1|
              |GOPT;maxDerivative;U$;2| |GOPT;maxShift;U$;3|
              (|Union| (|PositiveInteger|) '"arbitrary") |GOPT;maxSubst;U$;4|
              |GOPT;maxDegree;U$;5| (|NonNegativeInteger|) (|AnyFunctions1| 17)
              (5 . |coerce|) |GOPT;maxMixedDegree;Nni$;6| (|Boolean|)
              (|AnyFunctions1| 21) (10 . |coerce|) |GOPT;allDegrees;B$;7|
              (|AnyFunctions1| 14) (15 . |coerce|) |GOPT;maxPower;U$;8|
              |GOPT;safety;Nni$;9| (|Union| (|PositiveInteger|) 21)
              (|AnyFunctions1| 29) (20 . |coerce|) |GOPT;homogeneous;U$;10|
              |GOPT;Somos;U$;11| |GOPT;debug;B$;12|
              (|Union| '"skip" '"MonteCarlo" '"deterministic")
              (|AnyFunctions1| 35) (25 . |coerce|) |GOPT;check;U$;13|
              |GOPT;checkExtraValues;B$;14| |GOPT;one;B$;15| (|Symbol|)
              (|AnyFunctions1| 41) (30 . |coerce|) |GOPT;functionName;S$;16|
              (|List| 41) (|AnyFunctions1| 45) (35 . |coerce|)
              |GOPT;functionNames;L$;17| |GOPT;variableName;S$;18|
              |GOPT;indexName;S$;19| |GOPT;displayKind;S$;20| (|OutputForm|)
              (40 . |coerce|) (45 . |coerce|) (50 . =) |GOPT;coerce;$Of;21|
              (56 . =) |GOPT;=;2$B;22| (|Union| 7 '"failed") (|List| $)
              |GOPT;option;LSU;23| (|HashState|) (|String|) (|SingleInteger|))
           '#(~= 62 |variableName| 68 |safety| 73 |option| 78 |one| 84
              |maxSubst| 89 |maxShift| 94 |maxPower| 99 |maxMixedDegree| 104
              |maxLevel| 109 |maxDerivative| 114 |maxDegree| 119 |latex| 124
              |indexName| 129 |homogeneous| 134 |hashUpdate!| 139 |hash| 145
              |functionNames| 150 |functionName| 155 |displayKind| 160 |debug|
              165 |coerce| 170 |checkExtraValues| 175 |check| 180 |allDegrees|
              185 |Somos| 190 = 195)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(|SetCategory&| |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|BasicType|) (|CoercibleTo| 52))
                        (|makeByteWordVec2| 64
                                            '(1 9 7 8 10 1 18 7 17 19 1 22 7 21
                                              23 1 25 7 14 26 1 30 7 29 31 1 36
                                              7 35 37 1 42 7 41 43 1 46 7 45 47
                                              1 41 52 0 53 1 7 52 0 54 2 52 0 0
                                              0 55 2 7 21 0 0 57 2 0 21 0 0 1 1
                                              0 0 41 49 1 0 0 17 28 2 0 59 60
                                              41 61 1 0 0 21 40 1 0 0 14 15 1 0
                                              0 8 13 1 0 0 14 27 1 0 0 17 20 1
                                              0 0 8 11 1 0 0 8 12 1 0 0 8 16 1
                                              0 63 0 1 1 0 0 41 50 1 0 0 29 32
                                              2 0 62 62 0 1 1 0 64 0 1 1 0 0 45
                                              48 1 0 0 41 44 1 0 0 41 51 1 0 0
                                              21 34 1 0 52 0 56 1 0 0 21 39 1 0
                                              0 35 38 1 0 0 21 24 1 0 0 29 33 2
                                              0 21 0 0 58)))))
           '|lookupComplete|)) 

(MAKEPROP '|GuessOption| 'NILADIC T) 
