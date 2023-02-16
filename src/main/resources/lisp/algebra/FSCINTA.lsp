
(SDEFUN |FSCINTA;internalIntegrate;FGSIr;1|
        ((|f| (FG)) (|x| (|Symbol|)) ($ (|IntegrationResult| FG)))
        (SPROG
         ((|h| (FG)) (#1=#:G711 NIL) (|k| NIL) (#2=#:G710 NIL)
          (|lt| (|List| #3=(|Kernel| FG))) (#4=#:G709 NIL) (#5=#:G708 NIL)
          (|tg| (|List| #3#)) (|g| (FG)))
         (SEQ
          (LETT |f|
                (SPADCALL |f| (SPADCALL |x| (QREFELT $ 10)) (QREFELT $ 11)))
          (LETT |g| (SPADCALL |f| |x| (QREFELT $ 13)))
          (LETT |tg| (SPADCALL |g| (QREFELT $ 15)))
          (LETT |lt|
                (PROGN
                 (LETT #5# NIL)
                 (SEQ (LETT |k| NIL) (LETT #4# |tg|) G190
                      (COND
                       ((OR (ATOM #4#) (PROGN (LETT |k| (CAR #4#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL |x|
                                    (SPADCALL (SPADCALL |k| (QREFELT $ 17))
                                              (QREFELT $ 19))
                                    (QREFELT $ 21))
                          (LETT #5# (CONS |k| #5#))))))
                      (LETT #4# (CDR #4#)) (GO G190) G191
                      (EXIT (NREVERSE #5#)))))
          (LETT |h|
                (COND
                 ((SPADCALL
                   (CONS #'|FSCINTA;internalIntegrate;FGSIr;1!0|
                         (VECTOR (QREFELT $ 8) $))
                   |lt| (QREFELT $ 28))
                  (SPADCALL |g|
                            (PROGN
                             (LETT #2# NIL)
                             (SEQ (LETT |k| NIL)
                                  (LETT #1# (SPADCALL |f| (QREFELT $ 15))) G190
                                  (COND
                                   ((OR (ATOM #1#)
                                        (PROGN (LETT |k| (CAR #1#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((COND
                                       ((SPADCALL |k| '|tan| (QREFELT $ 29))
                                        'T)
                                       (#6='T
                                        (SPADCALL |k| '|cot| (QREFELT $ 29))))
                                      (LETT #2# (CONS |k| #2#))))))
                                  (LETT #1# (CDR #1#)) (GO G190) G191
                                  (EXIT (NREVERSE #2#))))
                            (QREFELT $ 31)))
                 (#6# |g|)))
          (EXIT
           (SPADCALL (QVELT (SPADCALL |h| |x| (QREFELT $ 33)) 0) |x|
                     (QREFELT $ 36)))))) 

(SDEFUN |FSCINTA;internalIntegrate;FGSIr;1!0| ((|x1| NIL) ($$ NIL))
        (PROG ($ RTRIG)
          (LETT $ (QREFELT $$ 1))
          (LETT RTRIG (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x1| (QREFELT $ 24)) RTRIG (QREFELT $ 25)))))) 

(DECLAIM (NOTINLINE |FunctionSpaceComplexIntegrationAux;|)) 

(DEFUN |FunctionSpaceComplexIntegrationAux| (&REST #1=#:G712)
  (SPROG NIL
         (PROG (#2=#:G713)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FunctionSpaceComplexIntegrationAux|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |FunctionSpaceComplexIntegrationAux;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|FunctionSpaceComplexIntegrationAux|)))))))))) 

(DEFUN |FunctionSpaceComplexIntegrationAux;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|FunctionSpaceComplexIntegrationAux| DV$1 DV$2))
          (LETT $ (GETREFV 38))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FunctionSpaceComplexIntegrationAux|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 '|rtrig|)
          $))) 

(MAKEPROP '|FunctionSpaceComplexIntegrationAux| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) 'RTRIG
              (|Symbol|) (0 . |coerce|) (5 . |distribute|)
              (|ElementaryFunctionStructurePackage| 6 7)
              (11 . |realElementary|) (|List| 16) (17 . |tower|) (|Kernel| $)
              (22 . |coerce|) (|List| 9) (27 . |variables|) (|Boolean|)
              (32 . |member?|) (|BasicOperator|) (|Kernel| 7) (38 . |operator|)
              (43 . |has?|) (|Mapping| 20 23) (|List| 23) (49 . |any?|)
              (55 . |is?|) (|TrigonometricManipulationsAux| 6 7)
              (61 . |trigs2explogs|)
              (|Record| (|:| |func| 7) (|:| |kers| 27) (|:| |vals| (|List| 7)))
              (67 . |rischNormalize|) (|IntegrationResult| 7)
              (|ElementaryIntegration| 6 7) (73 . |lfintegrate|)
              |FSCINTA;internalIntegrate;FGSIr;1|)
           '#(|internalIntegrate| 79) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|internalIntegrate|
                                 ((|IntegrationResult| |#2|) |#2| (|Symbol|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 37
                                            '(1 7 0 9 10 2 7 0 0 0 11 2 12 7 7
                                              9 13 1 7 14 0 15 1 7 0 16 17 1 7
                                              18 0 19 2 18 20 9 0 21 1 23 22 0
                                              24 2 22 20 0 9 25 2 27 20 26 0 28
                                              2 23 20 0 9 29 2 30 7 7 27 31 2
                                              12 32 7 9 33 2 35 34 7 9 36 2 0
                                              34 7 9 37)))))
           '|lookupComplete|)) 
