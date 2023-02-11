
(PUT '|CELL;simpleCells;$L;1| '|SPADreplace| '(XLAM (|c|) |c|)) 

(SDEFUN |CELL;simpleCells;$L;1|
        ((|c| ($))
         ($
          (|List|
           (|SimpleCell| |TheField|
                         (|SparseUnivariatePolynomial| |TheField|)))))
        |c|) 

(SDEFUN |CELL;coerce;$Of;2| ((|c| ($)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G707 NIL) (|sc| NIL) (#2=#:G706 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |sc| NIL) (LETT #1# |c|) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |sc| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2# (CONS (SPADCALL |sc| (QREFELT $ 12)) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 14))))) 

(SDEFUN |CELL;projection;$U;3| ((|cell| ($)) ($ (|Union| $ "failed")))
        (SPROG ((|r| ($)))
               (SEQ
                (COND ((NULL |cell|) (|error| "projection: should not appear"))
                      (#1='T
                       (SEQ (LETT |r| (CDR |cell|))
                            (EXIT
                             (COND ((NULL |r|) (CONS 1 "failed"))
                                   (#1# (CONS 0 |r|)))))))))) 

(PUT '|CELL;makeCell;L$;4| '|SPADreplace| '(XLAM (|l|) |l|)) 

(SDEFUN |CELL;makeCell;L$;4|
        ((|l|
          (|List|
           (|SimpleCell| |TheField|
                         (|SparseUnivariatePolynomial| |TheField|))))
         ($ ($)))
        |l|) 

(PUT '|CELL;makeCell;Sc2$;5| '|SPADreplace| 'CONS) 

(SDEFUN |CELL;makeCell;Sc2$;5|
        ((|scell|
          (|SimpleCell| |TheField| (|SparseUnivariatePolynomial| |TheField|)))
         (|toAdd| ($)) ($ ($)))
        (CONS |scell| |toAdd|)) 

(SDEFUN |CELL;mainVariableOf;$S;6| ((|cell| ($)) ($ (|Symbol|)))
        (COND ((NULL |cell|) (|error| "Should not appear"))
              ('T (SPADCALL (|SPADfirst| |cell|) (QREFELT $ 21))))) 

(SDEFUN |CELL;variablesOf;$L;7| ((|cell| ($)) ($ (|List| (|Symbol|))))
        (COND ((NULL |cell|) NIL)
              ('T
               (CONS (SPADCALL |cell| (QREFELT $ 22))
                     (SPADCALL (CDR |cell|) (QREFELT $ 24)))))) 

(SDEFUN |CELL;dimension;$Nni;8| ((|cell| ($)) ($ (|NonNegativeInteger|)))
        (COND ((NULL |cell|) 0)
              ((SPADCALL (|SPADfirst| |cell|) (QREFELT $ 26))
               (+ 1 (SPADCALL (CDR |cell|) (QREFELT $ 29))))
              ('T (SPADCALL (CDR |cell|) (QREFELT $ 29))))) 

(SDEFUN |CELL;hasDimension?;$SB;9|
        ((|cell| ($)) (|var| (|Symbol|)) ($ (|Boolean|)))
        (SPROG
         ((|v| (|Symbol|))
          (|sc|
           (|SimpleCell| |TheField|
                         (|SparseUnivariatePolynomial| |TheField|))))
         (SEQ
          (COND ((NULL |cell|) (|error| "Should not appear"))
                (#1='T
                 (SEQ (LETT |sc| (|SPADfirst| |cell|))
                      (LETT |v| (SPADCALL |sc| (QREFELT $ 21)))
                      (EXIT
                       (COND ((EQUAL |v| |var|) (SPADCALL |sc| (QREFELT $ 26)))
                             ((GGREATERP |var| |v|) NIL)
                             ((SPADCALL |v| |var| (QREFELT $ 30)) 'T)
                             (#1# (|error| "impossible")))))))))) 

(SDEFUN |CELL;samplePoint;$L;10| ((|cell| ($)) ($ (|List| |TheField|)))
        (COND ((NULL |cell|) NIL)
              ('T
               (CONS (SPADCALL (|SPADfirst| |cell|) (QREFELT $ 32))
                     (SPADCALL (CDR |cell|) (QREFELT $ 34)))))) 

(DECLAIM (NOTINLINE |Cell;|)) 

(DEFUN |Cell| (#1=#:G742)
  (SPROG NIL
         (PROG (#2=#:G743)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Cell|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Cell;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|Cell|)))))))))) 

(DEFUN |Cell;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|Cell| DV$1))
          (LETT $ (GETREFV 35))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|Cell| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9
                    (|List|
                     (|SimpleCell| |#1| (|SparseUnivariatePolynomial| |#1|))))
          $))) 

(MAKEPROP '|Cell| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|List| 11)
              |CELL;simpleCells;$L;1| '|Rep| (|OutputForm|)
              (|SimpleCell| 6 (|SparseUnivariatePolynomial| 6)) (0 . |coerce|)
              (|List| $) (5 . |paren|) |CELL;coerce;$Of;2|
              (|Union| $ '"failed") |CELL;projection;$U;3| |CELL;makeCell;L$;4|
              |CELL;makeCell;Sc2$;5| (|Symbol|) (10 . |variableOf|)
              |CELL;mainVariableOf;$S;6| (|List| 20) |CELL;variablesOf;$L;7|
              (|Boolean|) (15 . |hasDimension?|) (20 . |One|)
              (|NonNegativeInteger|) |CELL;dimension;$Nni;8| (24 . >)
              |CELL;hasDimension?;$SB;9| (30 . |samplePoint|) (|List| 6)
              |CELL;samplePoint;$L;10|)
           '#(|variablesOf| 35 |simpleCells| 40 |samplePoint| 45 |projection|
              50 |makeCell| 55 |mainVariableOf| 66 |hasDimension?| 71
              |dimension| 77 |coerce| 82)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS '#((|CoercibleTo| 10))
                             (|makeByteWordVec2| 34
                                                 '(1 11 10 0 12 1 10 0 13 14 1
                                                   11 20 0 21 1 11 25 0 26 0 6
                                                   0 27 2 20 25 0 0 30 1 11 6 0
                                                   32 1 0 23 0 24 1 0 7 0 8 1 0
                                                   33 0 34 1 0 16 0 17 2 0 0 11
                                                   0 19 1 0 0 7 18 1 0 20 0 22
                                                   2 0 25 0 20 31 1 0 28 0 29 1
                                                   0 10 0 15)))))
           '|lookupComplete|)) 
