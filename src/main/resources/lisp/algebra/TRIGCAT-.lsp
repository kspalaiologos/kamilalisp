
(SDEFUN |TRIGCAT-;csc;2S;1| ((|x| (S)) ($ (S)))
        (SPROG ((|a| (|Union| S "failed")))
               (SEQ
                (LETT |a|
                      (SPADCALL (SPADCALL |x| (QREFELT $ 7)) (QREFELT $ 9)))
                (EXIT
                 (COND ((QEQCAR |a| 1) (|error| "csc: no reciprocal"))
                       ('T (QCDR |a|))))))) 

(SDEFUN |TRIGCAT-;sec;2S;2| ((|x| (S)) ($ (S)))
        (SPROG ((|a| (|Union| S "failed")))
               (SEQ
                (LETT |a|
                      (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 9)))
                (EXIT
                 (COND ((QEQCAR |a| 1) (|error| "sec: no reciprocal"))
                       ('T (QCDR |a|))))))) 

(SDEFUN |TRIGCAT-;tan;2S;3| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 7)) (SPADCALL |x| (QREFELT $ 13))
                  (QREFELT $ 14))) 

(SDEFUN |TRIGCAT-;cot;2S;4| ((|x| (S)) ($ (S)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (SPADCALL |x| (QREFELT $ 16))
                  (QREFELT $ 14))) 

(DECLAIM (NOTINLINE |TrigonometricFunctionCategory&;|)) 

(DEFUN |TrigonometricFunctionCategory&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|TrigonometricFunctionCategory&| DV$1))
          (LETT $ (GETREFV 18))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#1| '(|Ring|))
            (PROGN
             (QSETREFV $ 10 (CONS (|dispatchFunction| |TRIGCAT-;csc;2S;1|) $))
             (QSETREFV $ 12 (CONS (|dispatchFunction| |TRIGCAT-;sec;2S;2|) $))
             (QSETREFV $ 15 (CONS (|dispatchFunction| |TRIGCAT-;tan;2S;3|) $))
             (QSETREFV $ 17
                       (CONS (|dispatchFunction| |TRIGCAT-;cot;2S;4|) $)))))
          $))) 

(MAKEPROP '|TrigonometricFunctionCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |sin|)
              (|Union| $ '"failed") (5 . |recip|) (10 . |csc|) (15 . |cos|)
              (20 . |sec|) (25 . |sec|) (30 . *) (36 . |tan|) (41 . |csc|)
              (46 . |cot|))
           '#(|tan| 51 |sec| 56 |csc| 61 |cot| 66) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|cot| (|#1| |#1|)) T)
                                   '((|csc| (|#1| |#1|)) T)
                                   '((|sec| (|#1| |#1|)) T)
                                   '((|tan| (|#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 17
                                            '(1 6 0 0 7 1 6 8 0 9 1 0 0 0 10 1
                                              6 0 0 11 1 0 0 0 12 1 6 0 0 13 2
                                              6 0 0 0 14 1 0 0 0 15 1 6 0 0 16
                                              1 0 0 0 17 1 0 0 0 15 1 0 0 0 12
                                              1 0 0 0 10 1 0 0 0 17)))))
           '|lookupComplete|)) 
