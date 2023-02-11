
(SDEFUN |MTSCAT-;coefficient;SVarNniS;1|
        ((|s| (S)) (|v| (|Var|)) (|n| (|NonNegativeInteger|)) ($ (S)))
        (SPADCALL |s| (LIST |v|) (LIST |n|) (QREFELT $ 11))) 

(DECLAIM (NOTINLINE |MultivariateTaylorSeriesCategory&;|)) 

(DEFUN |MultivariateTaylorSeriesCategory&| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$|
                (LIST '|MultivariateTaylorSeriesCategory&| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 15))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|Algebra|
                                                               (|Fraction|
                                                                (|Integer|))))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|MultivariateTaylorSeriesCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|List| 8) (|List| 12) (0 . |coefficient|)
              (|NonNegativeInteger|) |MTSCAT-;coefficient;SVarNniS;1|
              (|IndexedExponents| 8))
           '#(|coefficient| 7) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|coefficient|
                                 (|#1| |#1| (|List| |#3|)
                                  (|List| (|NonNegativeInteger|))))
                                T)
                              '((|coefficient|
                                 (|#1| |#1| |#3| (|NonNegativeInteger|)))
                                T)
                              '((|coefficient|
                                 (|#2| |#1| (|IndexedExponents| |#3|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 13
                                            '(3 6 0 0 9 10 11 3 0 0 0 8 12
                                              13)))))
           '|lookupComplete|)) 
