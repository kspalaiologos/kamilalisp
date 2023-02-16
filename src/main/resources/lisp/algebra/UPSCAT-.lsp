
(SDEFUN |UPSCAT-;degree;SExpon;1| ((|f| (S)) ($ (|Expon|)))
        (SPADCALL |f| (QREFELT $ 9))) 

(SDEFUN |UPSCAT-;leadingCoefficient;SCoef;2| ((|f| (S)) ($ (|Coef|)))
        (SPADCALL |f| (SPADCALL |f| (QREFELT $ 9)) (QREFELT $ 11))) 

(SDEFUN |UPSCAT-;leadingMonomial;2S;3| ((|f| (S)) ($ (S)))
        (SPROG ((|ord| (|Expon|)))
               (SEQ (LETT |ord| (SPADCALL |f| (QREFELT $ 9)))
                    (EXIT
                     (SPADCALL (SPADCALL |f| |ord| (QREFELT $ 11)) |ord|
                               (QREFELT $ 13)))))) 

(SDEFUN |UPSCAT-;reductum;2S;4| ((|f| (S)) ($ (S)))
        (SPADCALL |f| (SPADCALL |f| (QREFELT $ 15)) (QREFELT $ 16))) 

(DECLAIM (NOTINLINE |UnivariatePowerSeriesCategory&;|)) 

(DEFUN |UnivariatePowerSeriesCategory&| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|UnivariatePowerSeriesCategory&| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 18))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|PartialDifferentialRing|
                                                               (|Symbol|)))
                                              (|HasSignature| |#2|
                                                              (LIST '*
                                                                    (LIST
                                                                     (|devaluate|
                                                                      |#2|)
                                                                     (|devaluate|
                                                                      |#3|)
                                                                     (|devaluate|
                                                                      |#2|))))
                                              (|HasCategory| |#3|
                                                             '(|SemiGroup|))
                                              (|HasSignature| |#2|
                                                              (LIST '^
                                                                    (LIST
                                                                     (|devaluate|
                                                                      |#2|)
                                                                     (|devaluate|
                                                                      |#2|)
                                                                     (|devaluate|
                                                                      |#3|))))
                                              (|HasSignature| |#2|
                                                              (LIST '|coerce|
                                                                    (LIST
                                                                     (|devaluate|
                                                                      |#2|)
                                                                     '(|Symbol|))))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|UnivariatePowerSeriesCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (0 . |order|) |UPSCAT-;degree;SExpon;1|
              (5 . |coefficient|) |UPSCAT-;leadingCoefficient;SCoef;2|
              (11 . |monomial|) |UPSCAT-;leadingMonomial;2S;3|
              (17 . |leadingMonomial|) (22 . -) |UPSCAT-;reductum;2S;4|)
           '#(|reductum| 28 |leadingMonomial| 33 |leadingCoefficient| 38
              |degree| 43)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|leadingCoefficient| (|#2| |#1|)) T)
                                   '((|leadingMonomial| (|#1| |#1|)) T)
                                   '((|degree| (|#3| |#1|)) T)
                                   '((|reductum| (|#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 17
                                            '(1 6 8 0 9 2 6 7 0 8 11 2 6 0 7 8
                                              13 1 6 0 0 15 2 6 0 0 0 16 1 0 0
                                              0 17 1 0 0 0 14 1 0 7 0 12 1 0 8
                                              0 10)))))
           '|lookupComplete|)) 
