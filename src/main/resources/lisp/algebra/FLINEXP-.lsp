
(SDEFUN |FLINEXP-;reducedSystem;MM;1|
        ((|m| (|Matrix| S)) ($ (|Matrix| (|Integer|))))
        (SPADCALL (SPADCALL |m| (QREFELT $ 10)) (QREFELT $ 12))) 

(SDEFUN |FLINEXP-;reducedSystem;MVR;2|
        ((|m| (|Matrix| S)) (|v| (|Vector| S))
         ($
          (|Record| (|:| |mat| (|Matrix| (|Integer|)))
                    (|:| |vec| (|Vector| (|Integer|))))))
        (SPROG
         ((|rec| (|Record| (|:| |mat| (|Matrix| R)) (|:| |vec| (|Vector| R)))))
         (SEQ (LETT |rec| (SPADCALL |m| |v| (QREFELT $ 16)))
              (EXIT (SPADCALL (QCAR |rec|) (QCDR |rec|) (QREFELT $ 18)))))) 

(DECLAIM (NOTINLINE |FullyLinearlyExplicitOver&;|)) 

(DEFUN |FullyLinearlyExplicitOver&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|FullyLinearlyExplicitOver&| DV$1 DV$2))
          (LETT $ (GETREFV 20))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|LinearlyExplicitOver|
                                                               (|Integer|)))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND ((|domainEqual| |#2| (|Integer|)))
                ((|testBitVector| |pv$| 1)
                 (PROGN
                  (QSETREFV $ 13
                            (CONS
                             (|dispatchFunction| |FLINEXP-;reducedSystem;MM;1|)
                             $))
                  (QSETREFV $ 19
                            (CONS
                             (|dispatchFunction|
                              |FLINEXP-;reducedSystem;MVR;2|)
                             $)))))
          $))) 

(MAKEPROP '|FullyLinearlyExplicitOver&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Matrix| 7) (|Matrix| $) (0 . |reducedSystem|)
              (|Matrix| (|Integer|)) (5 . |reducedSystem|)
              (10 . |reducedSystem|)
              (|Record| (|:| |mat| 8) (|:| |vec| (|Vector| 7))) (|Vector| $)
              (15 . |reducedSystem|)
              (|Record| (|:| |mat| 11) (|:| |vec| (|Vector| (|Integer|))))
              (21 . |reducedSystem|) (27 . |reducedSystem|))
           '#(|reducedSystem| 33) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|reducedSystem|
                                 ((|Matrix| (|Integer|)) (|Matrix| |#1|)))
                                T)
                              '((|reducedSystem|
                                 ((|Record| (|:| |mat| (|Matrix| (|Integer|)))
                                            (|:| |vec| (|Vector| (|Integer|))))
                                  (|Matrix| |#1|) (|Vector| |#1|)))
                                T)
                              '((|reducedSystem|
                                 ((|Record| (|:| |mat| (|Matrix| |#2|))
                                            (|:| |vec| (|Vector| |#2|)))
                                  (|Matrix| |#1|) (|Vector| |#1|)))
                                T)
                              '((|reducedSystem|
                                 ((|Matrix| |#2|) (|Matrix| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 19
                                            '(1 6 8 9 10 1 7 11 9 12 1 0 11 9
                                              13 2 6 14 9 15 16 2 7 17 9 15 18
                                              2 0 17 9 15 19 2 0 17 9 15 19 1 0
                                              11 9 13)))))
           '|lookupComplete|)) 
