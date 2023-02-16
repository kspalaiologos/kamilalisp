
(SDEFUN |FSCINT;K2KG|
        ((|k| (|Kernel| F)) ($ (|Kernel| (|Expression| (|Complex| R)))))
        (SPADCALL
         (SPADCALL
          (SPADCALL (|SPADfirst| (SPADCALL |k| (QREFELT $ 11))) (QREFELT $ 14))
          (QREFELT $ 15))
         (QREFELT $ 17))) 

(SDEFUN |FSCINT;complexIntegrate;FSF;2| ((|f| (F)) (|x| (|Symbol|)) ($ (F)))
        (SPADCALL (SPADCALL (SPADCALL |f| |x| (QREFELT $ 20)) (QREFELT $ 22))
                  |x| (QREFELT $ 24))) 

(SDEFUN |FSCINT;internalIntegrate0;FSIr;3|
        ((|f| (F)) (|x| (|Symbol|)) ($ (|IntegrationResult| F)))
        (SPADCALL |f| |x| (QREFELT $ 27))) 

(SDEFUN |FSCINT;internalIntegrate;FSIr;4|
        ((|f| (F)) (|x| (|Symbol|)) ($ (|IntegrationResult| F)))
        (SPROG
         ((|g| (F)) (|h| (|Expression| (|Complex| R))) (#1=#:G725 NIL)
          (|k| NIL) (#2=#:G724 NIL) (#3=#:G723 NIL) (#4=#:G722 NIL))
         (SEQ
          (LETT |f|
                (SPADCALL |f| (SPADCALL |x| (QREFELT $ 29)) (QREFELT $ 30)))
          (EXIT
           (COND
            ((SPADCALL
              (CONS #'|FSCINT;internalIntegrate;FSIr;4!0|
                    (VECTOR (QREFELT $ 8) $))
              (PROGN
               (LETT #4# NIL)
               (SEQ (LETT |k| NIL)
                    (LETT #3#
                          (SPADCALL
                           (LETT |g| (SPADCALL |f| |x| (QREFELT $ 36)))
                           (QREFELT $ 38)))
                    G190
                    (COND
                     ((OR (ATOM #3#) (PROGN (LETT |k| (CAR #3#)) NIL))
                      (GO G191)))
                    (SEQ
                     (EXIT
                      (COND
                       ((SPADCALL |x|
                                  (SPADCALL (SPADCALL |k| (QREFELT $ 39))
                                            (QREFELT $ 41))
                                  (QREFELT $ 42))
                        (LETT #4# (CONS |k| #4#))))))
                    (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT (NREVERSE #4#))))
              (QREFELT $ 45))
             (SEQ
              (LETT |h|
                    (SPADCALL (SPADCALL |g| (QREFELT $ 14))
                              (PROGN
                               (LETT #2# NIL)
                               (SEQ (LETT |k| NIL)
                                    (LETT #1# (SPADCALL |f| (QREFELT $ 38)))
                                    G190
                                    (COND
                                     ((OR (ATOM #1#)
                                          (PROGN (LETT |k| (CAR #1#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((COND
                                         ((SPADCALL |k| '|tan| (QREFELT $ 46))
                                          'T)
                                         (#5='T
                                          (SPADCALL |k| '|cot|
                                                    (QREFELT $ 46))))
                                        (LETT #2#
                                              (CONS (|FSCINT;K2KG| |k| $)
                                                    #2#))))))
                                    (LETT #1# (CDR #1#)) (GO G190) G191
                                    (EXIT (NREVERSE #2#))))
                              (QREFELT $ 48)))
              (EXIT
               (COND
                ((SPADCALL (LETT |g| (SPADCALL |h| (QREFELT $ 49)))
                           (QREFELT $ 51))
                 (SPADCALL (QVELT (SPADCALL |g| |x| (QREFELT $ 53)) 0) |x|
                           (QREFELT $ 28)))
                ((SPADCALL
                  (LETT |g|
                        (SPADCALL
                         (LETT |h| (QVELT (SPADCALL |h| |x| (QREFELT $ 56)) 0))
                         (QREFELT $ 49)))
                  (QREFELT $ 51))
                 (SPADCALL |g| |x| (QREFELT $ 28)))
                (#5#
                 (SPADCALL (ELT $ 49) (SPADCALL |h| |x| (QREFELT $ 59))
                           (QREFELT $ 62)))))))
            (#5#
             (SPADCALL (QVELT (SPADCALL |g| |x| (QREFELT $ 53)) 0) |x|
                       (QREFELT $ 28)))))))) 

(SDEFUN |FSCINT;internalIntegrate;FSIr;4!0| ((|x1| NIL) ($$ NIL))
        (PROG ($ RTRIG)
          (LETT $ (QREFELT $$ 1))
          (LETT RTRIG (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x1| (QREFELT $ 32)) RTRIG (QREFELT $ 34)))))) 

(DECLAIM (NOTINLINE |FunctionSpaceComplexIntegration;|)) 

(DEFUN |FunctionSpaceComplexIntegration| (&REST #1=#:G726)
  (SPROG NIL
         (PROG (#2=#:G727)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|FunctionSpaceComplexIntegration|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |FunctionSpaceComplexIntegration;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|FunctionSpaceComplexIntegration|)))))))))) 

(DEFUN |FunctionSpaceComplexIntegration;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|FunctionSpaceComplexIntegration| DV$1 DV$2))
          (LETT $ (GETREFV 63))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|FunctionSpaceComplexIntegration|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 '|rtrig|)
          $))) 

(MAKEPROP '|FunctionSpaceComplexIntegration| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) 'RTRIG
              (|List| 7) (|Kernel| 7) (0 . |argument|)
              (|Expression| (|Complex| 6))
              (|InnerTrigonometricManipulations| 6 7 12) (5 . F2FG)
              (10 . |tan|) (|Kernel| $) (15 . |retract|)
              (|IntegrationResult| 7) (|Symbol|)
              |FSCINT;internalIntegrate;FSIr;4|
              (|IntegrationResultToFunction| 6 7) (20 . |complexExpand|)
              (|IntegrationTools| 6 7) (25 . |removeConstantTerm|)
              |FSCINT;complexIntegrate;FSF;2| (|ElementaryIntegration| 6 7)
              (31 . |lfintegrate|) |FSCINT;internalIntegrate0;FSIr;3|
              (37 . |coerce|) (42 . |distribute|) (|BasicOperator|)
              (48 . |operator|) (|Boolean|) (53 . |has?|)
              (|ElementaryFunctionStructurePackage| 6 7)
              (59 . |realElementary|) (|List| 16) (65 . |tower|)
              (70 . |coerce|) (|List| 19) (75 . |variables|) (80 . |member?|)
              (|Mapping| 33 10) (|List| 10) (86 . |any?|) (92 . |is?|)
              (|List| (|Kernel| 12)) (98 . |trigs2explogs|) (104 . FG2F)
              (|TrigonometricManipulations| 6 7) (109 . |real?|)
              (|Record| (|:| |func| 7) (|:| |kers| 44) (|:| |vals| 9))
              (114 . |rischNormalize|)
              (|Record| (|:| |func| 12) (|:| |kers| 47)
                        (|:| |vals| (|List| 12)))
              (|ElementaryFunctionStructurePackage| (|Complex| 6) 12)
              (120 . |rischNormalize|) (|IntegrationResult| 12)
              (|ElementaryIntegration| (|Complex| 6) 12) (126 . |lfintegrate|)
              (|Mapping| 7 12) (|IntegrationResultFunctions2| 12 7)
              (132 . |map|))
           '#(|internalIntegrate0| 138 |internalIntegrate| 144
              |complexIntegrate| 150)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|internalIntegrate|
                                 ((|IntegrationResult| |#2|) |#2| (|Symbol|)))
                                T)
                              '((|internalIntegrate0|
                                 ((|IntegrationResult| |#2|) |#2| (|Symbol|)))
                                T)
                              '((|complexIntegrate| (|#2| |#2| (|Symbol|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 62
                                            '(1 10 9 0 11 1 13 12 7 14 1 12 0 0
                                              15 1 12 16 0 17 1 21 7 18 22 2 23
                                              7 7 19 24 2 26 18 7 19 27 1 7 0
                                              19 29 2 7 0 0 0 30 1 10 31 0 32 2
                                              31 33 0 19 34 2 35 7 7 19 36 1 7
                                              37 0 38 1 7 0 16 39 1 7 40 0 41 2
                                              40 33 19 0 42 2 44 33 43 0 45 2
                                              10 33 0 19 46 2 13 12 12 47 48 1
                                              13 7 12 49 1 50 33 7 51 2 35 52 7
                                              19 53 2 55 54 12 19 56 2 58 57 12
                                              19 59 2 61 18 60 57 62 2 0 18 7
                                              19 28 2 0 18 7 19 20 2 0 7 7 19
                                              25)))))
           '|lookupComplete|)) 
