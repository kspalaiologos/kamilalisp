
(PUT '|FORMAT;sayExpr| '|SPADreplace| '|sayFormatted|) 

(SDEFUN |FORMAT;sayExpr| ((|s| (|String|)) ($ (|Void|))) (|sayFormatted| |s|)) 

(SDEFUN |FORMAT;coerce;Of$;2| ((|e| (|OutputForm|)) ($ ($)))
        (SPADCALL |e| (QREFELT $ 8))) 

(SDEFUN |FORMAT;convert;OfI$;3|
        ((|e| (|OutputForm|)) (|n| (|Integer|)) ($ ($)))
        (SPADCALL |e| |n| (QREFELT $ 11))) 

(SDEFUN |FORMAT;display;$V;4| ((|f| ($)) ($ (|Void|)))
        (SPROG ((#1=#:G710 NIL) (|s| NIL) (#2=#:G709 NIL) (#3=#:G708 NIL))
               (SEQ
                (SEQ (LETT |s| NIL)
                     (LETT #3#
                           (SPADCALL (SPADCALL |f| (QREFELT $ 14))
                                     (QREFELT $ 16)))
                     G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |s| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ (EXIT (|FORMAT;sayExpr| |s| $))) (LETT #3# (CDR #3#))
                     (GO G190) G191 (EXIT NIL))
                (SEQ (LETT |s| NIL)
                     (LETT #2#
                           (SPADCALL (SPADCALL |f| (QREFELT $ 17))
                                     (QREFELT $ 16)))
                     G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |s| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ (EXIT (|FORMAT;sayExpr| |s| $))) (LETT #2# (CDR #2#))
                     (GO G190) G191 (EXIT NIL))
                (EXIT
                 (SEQ (LETT |s| NIL)
                      (LETT #1#
                            (SPADCALL (SPADCALL |f| (QREFELT $ 18))
                                      (QREFELT $ 16)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (|FORMAT;sayExpr| |s| $)))
                      (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL)))))) 

(SDEFUN |FORMAT;coerce;$Of;5| ((|x| ($)) ($ (|OutputForm|)))
        (|coerceRe2E| |x|
                      (ELT
                       (|Record| (|:| |prolog| (|OutputBox|))
                                 (|:| |fmt| (|OutputBox|))
                                 (|:| |epilog| (|OutputBox|)))
                       0))) 

(SDEFUN |FORMAT;setDefault!;2MR;6|
        ((|p| (|Mapping| (|OutputBox|) (|String|)))
         (|e| (|Mapping| (|OutputBox|) (|String|)))
         ($
          (|Record| (|:| |prolog| (|Mapping| (|OutputBox|) (|String|)))
                    (|:| |epilog| (|Mapping| (|OutputBox|) (|String|))))))
        (SPROG
         ((|currentProEpi|
           (|Record| (|:| |prolog| (|Mapping| (|OutputBox|) (|String|)))
                     (|:| |epilog| (|Mapping| (|OutputBox|) (|String|))))))
         (SEQ
          (LETT |currentProEpi|
                (CONS (QCAR (QREFELT $ 25)) (QCDR (QREFELT $ 25))))
          (PROGN (RPLACA (QREFELT $ 25) |p|) (QCAR (QREFELT $ 25)))
          (PROGN (RPLACD (QREFELT $ 25) |e|) (QCDR (QREFELT $ 25)))
          (EXIT |currentProEpi|)))) 

(SDEFUN |FORMAT;setPrologue!;$2Ob;7|
        ((|x| ($)) (|b| (|OutputBox|)) ($ (|OutputBox|)))
        (SPROG ((|current| (|OutputBox|)))
               (SEQ (LETT |current| (QVELT |x| 0)) (QSETVELT |x| 0 |b|)
                    (EXIT |current|)))) 

(SDEFUN |FORMAT;setEpilogue!;$2Ob;8|
        ((|x| ($)) (|b| (|OutputBox|)) ($ (|OutputBox|)))
        (SPROG ((|current| (|OutputBox|)))
               (SEQ (LETT |current| (QVELT |x| 2)) (QSETVELT |x| 2 |b|)
                    (EXIT |current|)))) 

(SDEFUN |FORMAT;setFormat!;$2Ob;9|
        ((|x| ($)) (|b| (|OutputBox|)) ($ (|OutputBox|)))
        (SPROG ((|current| (|OutputBox|)))
               (SEQ (LETT |current| (QVELT |x| 1)) (QSETVELT |x| 1 |b|)
                    (EXIT |current|)))) 

(SDEFUN |FORMAT;newStructure| ((|label| (|String|)) ($ ($)))
        (SPROG ((|epi| (|OutputBox|)) (|pro| (|OutputBox|)))
               (SEQ (LETT |pro| (SPADCALL |label| (QCAR (QREFELT $ 25))))
                    (LETT |epi| (SPADCALL |label| (QCDR (QREFELT $ 25))))
                    (EXIT (VECTOR |pro| (SPADCALL (QREFELT $ 32)) |epi|))))) 

(SDEFUN |FORMAT;new;$;11| (($ ($))) (|FORMAT;newStructure| "" $)) 

(PUT '|FORMAT;prologue;$Ob;12| '|SPADreplace| '(XLAM (|f|) (QVELT |f| 0))) 

(SDEFUN |FORMAT;prologue;$Ob;12| ((|f| ($)) ($ (|OutputBox|))) (QVELT |f| 0)) 

(PUT '|FORMAT;format;$Ob;13| '|SPADreplace| '(XLAM (|f|) (QVELT |f| 1))) 

(SDEFUN |FORMAT;format;$Ob;13| ((|f| ($)) ($ (|OutputBox|))) (QVELT |f| 1)) 

(PUT '|FORMAT;epilogue;$Ob;14| '|SPADreplace| '(XLAM (|f|) (QVELT |f| 2))) 

(SDEFUN |FORMAT;epilogue;$Ob;14| ((|f| ($)) ($ (|OutputBox|))) (QVELT |f| 2)) 

(SDEFUN |FORMAT;format;Of$;15| ((|expr| (|OutputForm|)) ($ ($)))
        (SPROG ((|e| (|OutputForm|)) (|f| ($)))
               (SEQ (LETT |f| (SPADCALL (QREFELT $ 33)))
                    (LETT |e| (SPADCALL |expr| (QREFELT $ 35)))
                    (SPADCALL |f| (SPADCALL |e| (QREFELT $ 36)) (QREFELT $ 31))
                    (EXIT |f|)))) 

(SDEFUN |FORMAT;formatStep;OfI$;16|
        ((|expr| (|OutputForm|)) (|stepNum| (|Integer|)) ($ ($)))
        (SPROG ((|e| (|OutputForm|)) (|f| ($)))
               (SEQ
                (LETT |f| (|FORMAT;newStructure| (STRINGIMAGE |stepNum|) $))
                (LETT |e| (SPADCALL |expr| (QREFELT $ 35)))
                (SPADCALL |f| (SPADCALL |e| (QREFELT $ 36)) (QREFELT $ 31))
                (EXIT |f|)))) 

(SDEFUN |FORMAT;operatorHandlers;Oh;17|
        (($
          (|OperatorHandlers|
           (|Mapping| (|OutputBox|) (|Integer|) (|List| (|OutputForm|))))))
        (SPADCALL (QREFELT $ 39))) 

(DECLAIM (NOTINLINE |Formatter;|)) 

(DEFUN |Formatter| (#1=#:G740)
  (SPROG NIL
         (PROG (#2=#:G741)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Formatter|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Formatter;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|Formatter|)))))))))) 

(DEFUN |Formatter;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|Formatter| DV$1))
          (LETT $ (GETREFV 41))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Formatter| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 25 (CONS (ELT $ 23) (ELT $ 24)))
          $))) 

(MAKEPROP '|Formatter| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|OutputForm|)
              |FORMAT;format;Of$;15| |FORMAT;coerce;Of$;2| (|Integer|)
              |FORMAT;formatStep;OfI$;16| |FORMAT;convert;OfI$;3| (|OutputBox|)
              |FORMAT;prologue;$Ob;12| (|List| 22) (0 . |lines|)
              |FORMAT;format;$Ob;13| |FORMAT;epilogue;$Ob;14| (|Void|)
              |FORMAT;display;$V;4| |FORMAT;coerce;$Of;5| (|String|)
              (5 . |defaultPrologue|) (10 . |defaultEpilogue|) '|defaultProEpi|
              (|Mapping| 13 22) (|Record| (|:| |prolog| 26) (|:| |epilog| 26))
              |FORMAT;setDefault!;2MR;6| |FORMAT;setPrologue!;$2Ob;7|
              |FORMAT;setEpilogue!;$2Ob;8| |FORMAT;setFormat!;$2Ob;9|
              (15 . |empty|) |FORMAT;new;$;11| (|OutputFormTools|)
              (19 . |precondition|) (24 . |formatExpression|)
              (|Mapping| 13 10 (|List| 7)) (|OperatorHandlers| 37)
              (29 . |operatorHandlers|) |FORMAT;operatorHandlers;Oh;17|)
           '#(|setPrologue!| 33 |setFormat!| 39 |setEpilogue!| 45 |setDefault!|
              51 |prologue| 57 |operatorHandlers| 62 |new| 66 |formatStep| 70
              |format| 76 |epilogue| 86 |display| 91 |convert| 96 |coerce| 102)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0))
                 (CONS '#(NIL NIL NIL)
                       (CONS
                        '#((|OutputFormatterCategory|) (|CoercibleTo| 7)
                           (|CoercibleFrom| 7))
                        (|makeByteWordVec2| 40
                                            '(1 13 15 0 16 1 6 13 22 23 1 6 13
                                              22 24 0 13 0 32 1 34 7 7 35 1 6
                                              13 7 36 0 6 38 39 2 0 13 0 13 29
                                              2 0 13 0 13 31 2 0 13 0 13 30 2 0
                                              27 26 26 28 1 0 13 0 14 0 0 38 40
                                              0 0 0 33 2 0 0 7 10 11 1 0 0 7 8
                                              1 0 13 0 17 1 0 13 0 18 1 0 19 0
                                              20 2 0 0 7 10 12 1 0 0 7 9 1 0 7
                                              0 21)))))
           '|lookupComplete|)) 
