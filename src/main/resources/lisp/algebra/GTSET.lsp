
(PUT '|GTSET;rep| '|SPADreplace| '(XLAM (|s|) |s|)) 

(SDEFUN |GTSET;rep| ((|s| ($)) ($ (|List| P))) |s|) 

(PUT '|GTSET;per| '|SPADreplace| '(XLAM (|l|) |l|)) 

(SDEFUN |GTSET;per| ((|l| (|List| P)) ($ ($))) |l|) 

(SDEFUN |GTSET;copy;2$;3| ((|ts| ($)) ($ ($)))
        (|GTSET;per| (SPADCALL (|GTSET;rep| |ts| $) (QREFELT $ 11)) $)) 

(SDEFUN |GTSET;empty;$;4| (($ ($))) (|GTSET;per| NIL $)) 

(SDEFUN |GTSET;empty?;$B;5| ((|ts| ($)) ($ (|Boolean|)))
        (NULL (|GTSET;rep| |ts| $))) 

(SDEFUN |GTSET;parts;$L;6| ((|ts| ($)) ($ (|List| P))) (|GTSET;rep| |ts| $)) 

(SDEFUN |GTSET;members;$L;7| ((|ts| ($)) ($ (|List| P))) (|GTSET;rep| |ts| $)) 

(SDEFUN |GTSET;map;M2$;8| ((|f| (|Mapping| P P)) (|ts| ($)) ($ ($)))
        (SPADCALL (SPADCALL |f| (|GTSET;rep| |ts| $) (QREFELT $ 19))
                  (QREFELT $ 20))) 

(SDEFUN |GTSET;map!;M2$;9| ((|f| (|Mapping| P P)) (|ts| ($)) ($ ($)))
        (SPADCALL (SPADCALL |f| (|GTSET;rep| |ts| $) (QREFELT $ 22))
                  (QREFELT $ 20))) 

(SDEFUN |GTSET;member?;P$B;10| ((|p| (P)) (|ts| ($)) ($ (|Boolean|)))
        (SPADCALL |p| (|GTSET;rep| |ts| $) (QREFELT $ 24))) 

(PUT '|GTSET;roughUnitIdeal?;$B;11| '|SPADreplace| '(XLAM (|ts|) NIL)) 

(SDEFUN |GTSET;roughUnitIdeal?;$B;11| ((|ts| ($)) ($ (|Boolean|))) NIL) 

(SDEFUN |GTSET;coerce;$Of;12| ((|ts| ($)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G725 NIL) (|p| NIL) (#2=#:G724 NIL) (|lp| (|List| P)))
               (SEQ (LETT |lp| (REVERSE (|GTSET;rep| |ts| $)))
                    (EXIT
                     (SPADCALL
                      (PROGN
                       (LETT #2# NIL)
                       (SEQ (LETT |p| NIL) (LETT #1# |lp|) G190
                            (COND
                             ((OR (ATOM #1#) (PROGN (LETT |p| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #2#
                                    (CONS (SPADCALL |p| (QREFELT $ 28)) #2#))))
                            (LETT #1# (CDR #1#)) (GO G190) G191
                            (EXIT (NREVERSE #2#))))
                      (QREFELT $ 30)))))) 

(SDEFUN |GTSET;mvar;$V;13| ((|ts| ($)) ($ (V)))
        (COND
         ((SPADCALL |ts| (QREFELT $ 15))
          (|error| "failed in mvar : % -> V from GTSET"))
         ('T (SPADCALL (|SPADfirst| (|GTSET;rep| |ts| $)) (QREFELT $ 32))))) 

(SDEFUN |GTSET;first;$U;14| ((|ts| ($)) ($ (|Union| P "failed")))
        (COND ((SPADCALL |ts| (QREFELT $ 15)) (CONS 1 "failed"))
              ('T (CONS 0 (|SPADfirst| (|GTSET;rep| |ts| $)))))) 

(SDEFUN |GTSET;last;$U;15| ((|ts| ($)) ($ (|Union| P "failed")))
        (COND ((SPADCALL |ts| (QREFELT $ 15)) (CONS 1 "failed"))
              ('T (CONS 0 (SPADCALL (|GTSET;rep| |ts| $) (QREFELT $ 36)))))) 

(SDEFUN |GTSET;rest;$U;16| ((|ts| ($)) ($ (|Union| $ "failed")))
        (COND ((SPADCALL |ts| (QREFELT $ 15)) (CONS 1 "failed"))
              ('T (CONS 0 (|GTSET;per| (CDR (|GTSET;rep| |ts| $)) $))))) 

(SDEFUN |GTSET;coerce;$L;17| ((|ts| ($)) ($ (|List| P))) (|GTSET;rep| |ts| $)) 

(SDEFUN |GTSET;collectUpper;$V$;18| ((|ts| ($)) (|v| (V)) ($ ($)))
        (SPROG ((|lp| (|List| P)) (|newlp| (|List| P)))
               (SEQ
                (COND ((SPADCALL |ts| (QREFELT $ 15)) |ts|)
                      ('T
                       (SEQ (LETT |lp| (|GTSET;rep| |ts| $)) (LETT |newlp| NIL)
                            (SEQ G190
                                 (COND
                                  ((NULL
                                    (COND ((NULL |lp|) NIL)
                                          ('T
                                           (SPADCALL
                                            (SPADCALL (|SPADfirst| |lp|)
                                                      (QREFELT $ 32))
                                            |v| (QREFELT $ 41)))))
                                   (GO G191)))
                                 (SEQ
                                  (LETT |newlp|
                                        (CONS (|SPADfirst| |lp|) |newlp|))
                                  (EXIT (LETT |lp| (CDR |lp|))))
                                 NIL (GO G190) G191 (EXIT NIL))
                            (EXIT (|GTSET;per| (REVERSE |newlp|) $)))))))) 

(SDEFUN |GTSET;collectUnder;$V$;19| ((|ts| ($)) (|v| (V)) ($ ($)))
        (SPROG ((|lp| (|List| P)))
               (SEQ
                (COND ((SPADCALL |ts| (QREFELT $ 15)) |ts|)
                      ('T
                       (SEQ (LETT |lp| (|GTSET;rep| |ts| $))
                            (SEQ G190
                                 (COND
                                  ((NULL
                                    (COND ((NULL |lp|) NIL)
                                          ('T
                                           (SPADCALL
                                            (SPADCALL (|SPADfirst| |lp|)
                                                      (QREFELT $ 32))
                                            |v| (QREFELT $ 43)))))
                                   (GO G191)))
                                 (SEQ (EXIT (LETT |lp| (CDR |lp|)))) NIL
                                 (GO G190) G191 (EXIT NIL))
                            (EXIT (|GTSET;per| |lp| $)))))))) 

(SDEFUN |GTSET;extendIfCan;$PU;20|
        ((|ts| ($)) (|p| (P)) ($ (|Union| $ "failed")))
        (COND ((SPADCALL |p| (QREFELT $ 45)) (CONS 1 "failed"))
              ((SPADCALL |ts| (QREFELT $ 15))
               (CONS 0 (|GTSET;per| (LIST (SPADCALL |p| (QREFELT $ 46))) $)))
              ((NULL
                (SPADCALL (SPADCALL |ts| (QREFELT $ 33))
                          (SPADCALL |p| (QREFELT $ 32)) (QREFELT $ 47)))
               (CONS 1 "failed"))
              ('T (CONS 0 (|GTSET;per| (CONS |p| (|GTSET;rep| |ts| $)) $))))) 

(DECLAIM (NOTINLINE |GeneralTriangularSet;|)) 

(DEFUN |GeneralTriangularSet| (&REST #1=#:G791)
  (SPROG NIL
         (PROG (#2=#:G792)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|GeneralTriangularSet|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |GeneralTriangularSet;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|GeneralTriangularSet|)))))))))) 

(DEFUN |GeneralTriangularSet;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((#1=#:G790 NIL) (|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL)
    (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|GeneralTriangularSet| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 69))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (AND
                                         (|HasCategory| |#4|
                                                        (LIST '|Evalable|
                                                              (|devaluate|
                                                               |#4|)))
                                         (|HasCategory| |#4| '(|SetCategory|)))
                                        (|HasCategory| |#4|
                                                       '(|ConvertibleTo|
                                                         (|InputForm|)))
                                        (|HasCategory| |#4| '(|BasicType|))
                                        (|HasCategory| |#4| '(|OrderedSet|))
                                        (|HasCategory| |#1|
                                                       '(|IntegralDomain|))
                                        (|HasCategory| |#3| '(|Finite|))))))
    (|haddProp| |$ConstructorCache| '|GeneralTriangularSet|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (AND (|HasCategory| $ '(|shallowlyMutable|)) (|augmentPredVector| $ 64))
    (AND (LETT #1# (|HasCategory| $ '(|finiteAggregate|)))
         (|augmentPredVector| $ 128))
    (AND (|HasCategory| |#4| '(|BasicType|)) #1# (|augmentPredVector| $ 256))
    (AND (|HasCategory| |#4| '(|OrderedSet|)) #1# (|augmentPredVector| $ 512))
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|GeneralTriangularSet| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|List| 9) (0 . |copy|)
              |GTSET;copy;2$;3| |GTSET;empty;$;4| (|Boolean|)
              |GTSET;empty?;$B;5| |GTSET;parts;$L;6| |GTSET;members;$L;7|
              (|Mapping| 9 9) (5 . |map|) (11 . |construct|) |GTSET;map;M2$;8|
              (16 . |map!|) |GTSET;map!;M2$;9| (22 . |member?|)
              |GTSET;member?;P$B;10| |GTSET;roughUnitIdeal?;$B;11|
              (|OutputForm|) (28 . |coerce|) (|List| $) (33 . |brace|)
              |GTSET;coerce;$Of;12| (38 . |mvar|) |GTSET;mvar;$V;13|
              (|Union| 9 '#1="failed") |GTSET;first;$U;14| (43 . |last|)
              |GTSET;last;$U;15| (|Union| $ '#1#) |GTSET;rest;$U;16|
              |GTSET;coerce;$L;17| (48 . >) |GTSET;collectUpper;$V$;18|
              (54 . >=) |GTSET;collectUnder;$V$;19| (60 . |ground?|)
              (65 . |unitCanonical|) (70 . <) |GTSET;extendIfCan;$PU;20|
              (|NonNegativeInteger|) (|Mapping| 9 9 9) (|List| 52)
              (|Equation| 9) (|Mapping| 14 9) (|Mapping| 14 9 9) (|InputForm|)
              (|Record| (|:| |rnum| 6) (|:| |polnum| 9) (|:| |den| 6))
              (|Record| (|:| |num| 9) (|:| |den| 6)) (|List| 8)
              (|Record| (|:| |close| $) (|:| |open| 10)) (|List| 59)
              (|Mapping| 14 9 10) (|Record| (|:| |close| 10) (|:| |open| 10))
              (|Record| (|:| |bas| $) (|:| |top| 10)) (|Union| 63 '#1#)
              (|Record| (|:| |under| $) (|:| |floor| $) (|:| |upper| $))
              (|HashState|) (|String|) (|SingleInteger|))
           '#(~= 76 |zeroSetSplitIntoTriangularSystems| 82 |zeroSetSplit| 87
              |variables| 92 |trivialIdeal?| 97 |triangular?| 102
              |stronglyReduced?| 107 |stronglyReduce| 118 |sort| 124 |size?|
              130 |select| 136 |sample| 148 |roughUnitIdeal?| 152
              |roughSubIdeal?| 157 |roughEqualIdeals?| 163 |roughBase?| 169
              |rewriteSetWithReduction| 174 |rewriteIdealWithRemainder| 182
              |rewriteIdealWithHeadRemainder| 188 |retractIfCan| 194 |retract|
              199 |rest| 204 |removeZero| 209 |removeDuplicates| 215 |remove|
              220 |remainder| 232 |reduced?| 238 |reduceByQuasiMonic| 245
              |reduce| 251 |quasiComponent| 280 |parts| 285 |normalized?| 290
              |mvar| 301 |more?| 306 |min| 312 |members| 317 |member?| 322
              |max| 328 |map!| 339 |map| 345 |mainVariables| 351
              |mainVariable?| 356 |less?| 362 |latex| 368 |last| 373 |initials|
              378 |initiallyReduced?| 383 |initiallyReduce| 394 |infRittWu?|
              400 |iexactQuo| 406 |headRemainder| 412 |headReduced?| 418
              |headReduce| 429 |hashUpdate!| 435 |hash| 441 |first| 446 |find|
              451 |extendIfCan| 457 |extend| 463 |every?| 469 |eval| 475 |eq?|
              501 |empty?| 507 |empty| 512 |degree| 516 |count| 521 |copy| 533
              |convert| 538 |construct| 543 |collectUpper| 548 |collectUnder|
              554 |collectQuasiMonic| 560 |collect| 565 |coerce| 571 |coHeight|
              581 |basicSet| 586 |autoReduced?| 599 |any?| 605
              |algebraicVariables| 611 |algebraic?| 616 = 622 |#| 628)
           'NIL
           (CONS (|makeByteWordVec2| 2 '(0 0 0 0 0 0 0 1 0 0 0 0 0 0 1 2))
                 (CONS
                  '#(|TriangularSetCategory&| |PolynomialSetCategory&|
                     |Collection&| |HomogeneousAggregate&| |SetCategory&|
                     |RetractableFrom&| |Aggregate&| |Evalable&| |BasicType&|
                     NIL NIL NIL NIL NIL |InnerEvalable&| NIL)
                  (CONS
                   '#((|TriangularSetCategory| 6 7 8 9)
                      (|PolynomialSetCategory| 6 7 8 9) (|Collection| 9)
                      (|HomogeneousAggregate| 9) (|SetCategory|)
                      (|RetractableFrom| (|List| 9)) (|Aggregate|)
                      (|Evalable| 9) (|BasicType|) (|shallowlyMutable|)
                      (|finiteAggregate|) (|CoercibleTo| (|List| 9)) (|Type|)
                      (|CoercibleTo| 27) (|InnerEvalable| 9 9)
                      (|ConvertibleTo| 55))
                   (|makeByteWordVec2| 68
                                       '(1 10 0 0 11 2 10 0 18 0 19 1 0 0 10 20
                                         2 10 0 18 0 22 2 10 14 9 0 24 1 9 27 0
                                         28 1 27 0 29 30 1 9 8 0 32 1 10 9 0 36
                                         2 8 14 0 0 41 2 8 14 0 0 43 1 9 14 0
                                         45 1 9 0 0 46 2 8 14 0 0 47 2 0 14 0 0
                                         1 1 0 60 10 1 1 0 29 10 1 1 0 58 0 1 1
                                         0 14 0 1 1 5 14 0 1 1 0 14 0 1 2 0 14
                                         9 0 1 2 0 9 9 0 1 2 0 65 0 8 1 2 0 14
                                         0 49 1 2 8 0 53 0 1 2 0 34 0 8 1 0 0 0
                                         1 1 5 14 0 26 2 5 14 0 0 1 2 5 14 0 0
                                         1 1 5 14 0 1 4 0 10 10 0 50 54 1 2 5
                                         10 10 0 1 2 5 10 10 0 1 1 0 38 10 1 1
                                         0 0 10 1 1 0 38 0 39 2 0 9 9 0 1 1 9 0
                                         0 1 2 9 0 9 0 1 2 8 0 53 0 1 2 5 56 9
                                         0 1 3 0 14 9 0 54 1 2 0 9 9 0 1 4 9 9
                                         50 0 9 9 1 2 8 9 50 0 1 3 8 9 50 0 9 1
                                         4 0 9 9 0 50 54 1 1 0 62 0 1 1 8 10 0
                                         16 1 0 14 0 1 2 0 14 9 0 1 1 0 8 0 33
                                         2 0 14 0 49 1 1 10 9 0 1 1 8 10 0 17 2
                                         9 14 9 0 25 1 10 9 0 1 2 8 9 54 0 1 2
                                         7 0 18 0 23 2 0 0 18 0 21 1 0 58 0 1 2
                                         0 14 8 0 1 2 0 14 0 49 1 1 0 67 0 1 1
                                         0 34 0 37 1 0 10 0 1 1 0 14 0 1 2 0 14
                                         9 0 1 2 0 9 9 0 1 2 0 14 0 0 1 2 5 6 6
                                         6 1 2 5 57 9 0 1 1 0 14 0 1 2 0 14 9 0
                                         1 2 0 9 9 0 1 2 0 66 66 0 1 1 0 68 0 1
                                         1 0 34 0 35 2 0 34 53 0 1 2 0 38 0 9
                                         48 2 0 0 0 9 1 2 8 14 53 0 1 2 1 0 0
                                         51 1 2 1 0 0 52 1 3 1 0 0 10 10 1 3 1
                                         0 0 9 9 1 2 0 14 0 0 1 1 0 14 0 15 0 0
                                         0 13 1 0 49 0 1 2 9 49 9 0 1 2 8 49 53
                                         0 1 1 0 0 0 12 1 2 55 0 1 1 0 0 10 20
                                         2 0 0 0 8 42 2 0 0 0 8 44 1 0 0 0 1 2
                                         0 0 0 8 1 1 0 10 0 40 1 0 27 0 31 1 6
                                         49 0 1 3 0 64 10 53 54 1 2 0 64 10 54
                                         1 2 0 14 0 61 1 2 8 14 53 0 1 1 0 58 0
                                         1 2 0 14 8 0 1 2 0 14 0 0 1 1 8 49 0
                                         1)))))
           '|lookupComplete|)) 
