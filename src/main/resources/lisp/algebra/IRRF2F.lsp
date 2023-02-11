
(SDEFUN |IRRF2F;toEF|
        ((|i| (|IntegrationResult| (|Fraction| (|Polynomial| R))))
         ($ (|IntegrationResult| (|Expression| R))))
        (SPADCALL (ELT $ 9) |i| (QREFELT $ 14))) 

(SDEFUN |IRRF2F;expand;IrSL;2|
        ((|i| (|IntegrationResult| (|Fraction| (|Polynomial| R))))
         (|x| (|Symbol|)) ($ (|List| (|Expression| R))))
        (SPADCALL (|IRRF2F;toEF| |i| $) |x| (QREFELT $ 18))) 

(SDEFUN |IRRF2F;complexExpand;IrE;3|
        ((|i| (|IntegrationResult| (|Fraction| (|Polynomial| R))))
         ($ (|Expression| R)))
        (SPADCALL (|IRRF2F;toEF| |i| $) (QREFELT $ 20))) 

(SDEFUN |IRRF2F;split;2Ir;4|
        ((|i| (|IntegrationResult| (|Fraction| (|Polynomial| R))))
         ($ (|IntegrationResult| (|Fraction| (|Polynomial| R)))))
        (SPADCALL (ELT $ 22) (SPADCALL (|IRRF2F;toEF| |i| $) (QREFELT $ 23))
                  (QREFELT $ 26))) 

(SDEFUN |IRRF2F;complexIntegrate;FSE;5|
        ((|f| (|Fraction| (|Polynomial| R))) (|x| (|Symbol|))
         ($ (|Expression| R)))
        (SPADCALL (SPADCALL |f| |x| (QREFELT $ 29)) (QREFELT $ 21))) 

(SDEFUN |IRRF2F;integrate;FSU;6|
        ((|f| (|Fraction| (|Polynomial| R))) (|x| (|Symbol|))
         ($ (|Union| (|Expression| R) (|List| (|Expression| R)))))
        (CONS 0 (SPADCALL |f| |x| (QREFELT $ 30)))) 

(SDEFUN |IRRF2F;integrate;FSU;7|
        ((|f| (|Fraction| (|Polynomial| R))) (|x| (|Symbol|))
         ($ (|Union| (|Expression| R) (|List| (|Expression| R)))))
        (SPROG
         ((|l| (|List| (|Expression| R))) (#1=#:G726 NIL) (|g| NIL)
          (#2=#:G725 NIL))
         (SEQ
          (LETT |l|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |g| NIL)
                      (LETT #1#
                            (SPADCALL (SPADCALL |f| |x| (QREFELT $ 29)) |x|
                                      (QREFELT $ 19)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |g| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL (SPADCALL |g| (QREFELT $ 34)) |x|
                                         (QREFELT $ 36))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT
           (COND ((NULL (CDR |l|)) (CONS 0 (|SPADfirst| |l|)))
                 ('T (CONS 1 |l|))))))) 

(DECLAIM (NOTINLINE |IntegrationResultRFToFunction;|)) 

(DEFUN |IntegrationResultRFToFunction| (#1=#:G727)
  (SPROG NIL
         (PROG (#2=#:G728)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|IntegrationResultRFToFunction|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|IntegrationResultRFToFunction;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|IntegrationResultRFToFunction|)))))))))) 

(DEFUN |IntegrationResultRFToFunction;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|IntegrationResultRFToFunction| DV$1))
          (LETT $ (GETREFV 37))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|CharacteristicZero|))))))
          (|haddProp| |$ConstructorCache| '|IntegrationResultRFToFunction|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 30
                       (CONS
                        (|dispatchFunction| |IRRF2F;complexIntegrate;FSE;5|)
                        $))
             (COND
              ((|HasSignature| |#1|
                               (LIST '|imaginary| (LIST (|devaluate| |#1|))))
               (QSETREFV $ 32
                         (CONS (|dispatchFunction| |IRRF2F;integrate;FSU;6|)
                               $)))
              ('T
               (QSETREFV $ 32
                         (CONS (|dispatchFunction| |IRRF2F;integrate;FSU;7|)
                               $)))))))
          $))) 

(MAKEPROP '|IntegrationResultRFToFunction| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|)
              (|Fraction| (|Polynomial| 6)) (|Expression| 6) (0 . |coerce|)
              (|IntegrationResult| 8) (|Mapping| 8 7) (|IntegrationResult| 7)
              (|IntegrationResultFunctions2| 7 8) (5 . |map|) (|List| 8)
              (|Symbol|) (|IntegrationResultToFunction| 6 8) (11 . |expand|)
              |IRRF2F;expand;IrSL;2| (17 . |complexExpand|)
              |IRRF2F;complexExpand;IrE;3| (22 . |retract|) (27 . |split|)
              (|Mapping| 7 8) (|IntegrationResultFunctions2| 8 7) (32 . |map|)
              |IRRF2F;split;2Ir;4| (|RationalFunctionIntegration| 6)
              (38 . |internalIntegrate|) (44 . |complexIntegrate|)
              (|Union| 8 15) (50 . |integrate|)
              (|TrigonometricManipulations| 6 8) (56 . |real|)
              (|IntegrationTools| 6 8) (61 . |mkPrim|))
           '#(|split| 67 |integrate| 72 |expand| 78 |complexIntegrate| 84
              |complexExpand| 90)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|split|
                                 ((|IntegrationResult|
                                   (|Fraction| (|Polynomial| |#1|)))
                                  (|IntegrationResult|
                                   (|Fraction| (|Polynomial| |#1|)))))
                                T)
                              '((|expand|
                                 ((|List| (|Expression| |#1|))
                                  (|IntegrationResult|
                                   (|Fraction| (|Polynomial| |#1|)))
                                  (|Symbol|)))
                                T)
                              '((|complexExpand|
                                 ((|Expression| |#1|)
                                  (|IntegrationResult|
                                   (|Fraction| (|Polynomial| |#1|)))))
                                T)
                              '((|integrate|
                                 ((|Union| (|Expression| |#1|)
                                           (|List| (|Expression| |#1|)))
                                  (|Fraction| (|Polynomial| |#1|)) (|Symbol|)))
                                (|has| 6 (|CharacteristicZero|)))
                              '((|complexIntegrate|
                                 ((|Expression| |#1|)
                                  (|Fraction| (|Polynomial| |#1|)) (|Symbol|)))
                                (|has| 6 (|CharacteristicZero|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 36
                                            '(1 8 0 7 9 2 13 10 11 12 14 2 17
                                              15 10 16 18 1 17 8 10 20 1 8 7 0
                                              22 1 17 10 10 23 2 25 12 24 10 26
                                              2 28 12 7 16 29 2 0 8 7 16 30 2 0
                                              31 7 16 32 1 33 8 8 34 2 35 8 8
                                              16 36 1 0 12 12 27 2 1 31 7 16 32
                                              2 0 15 12 16 19 2 1 8 7 16 30 1 0
                                              8 12 21)))))
           '|lookupComplete|)) 
