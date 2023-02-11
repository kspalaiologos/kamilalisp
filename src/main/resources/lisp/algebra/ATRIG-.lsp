
(SDEFUN |ATRIG-;asec;2S;1| ((|x| (S)) ($ (S)))
        (SPROG ((|a| (|Union| S "failed")))
               (SEQ (LETT |a| (SPADCALL |x| (QREFELT $ 8)))
                    (EXIT
                     (COND ((QEQCAR |a| 1) (|error| "asec: no reciprocal"))
                           ('T (SPADCALL (QCDR |a|) (QREFELT $ 9)))))))) 

(SDEFUN |ATRIG-;acsc;2S;2| ((|x| (S)) ($ (S)))
        (SPROG ((|a| (|Union| S "failed")))
               (SEQ (LETT |a| (SPADCALL |x| (QREFELT $ 8)))
                    (EXIT
                     (COND ((QEQCAR |a| 1) (|error| "acsc: no reciprocal"))
                           ('T (SPADCALL (QCDR |a|) (QREFELT $ 11)))))))) 

(DECLAIM (NOTINLINE |ArcTrigonometricFunctionCategory&;|)) 

(DEFUN |ArcTrigonometricFunctionCategory&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|ArcTrigonometricFunctionCategory&| DV$1))
          (LETT $ (GETREFV 13))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#1| '(|Ring|))
            (PROGN
             (QSETREFV $ 10 (CONS (|dispatchFunction| |ATRIG-;asec;2S;1|) $))
             (QSETREFV $ 12
                       (CONS (|dispatchFunction| |ATRIG-;acsc;2S;2|) $)))))
          $))) 

(MAKEPROP '|ArcTrigonometricFunctionCategory&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Union| $ '"failed")
              (0 . |recip|) (5 . |acos|) (10 . |asec|) (15 . |asin|)
              (20 . |acsc|))
           '#(|asec| 25 |acsc| 30) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|acsc| (|#1| |#1|)) T)
                                   '((|asec| (|#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 12
                                            '(1 6 7 0 8 1 6 0 0 9 1 0 0 0 10 1
                                              6 0 0 11 1 0 0 0 12 1 0 0 0 10 1
                                              0 0 0 12)))))
           '|lookupComplete|)) 
