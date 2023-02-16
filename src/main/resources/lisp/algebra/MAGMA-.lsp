
(SDEFUN |MAGMA-;^;SPiS;1| ((|x| (S)) (|n| (|PositiveInteger|)) ($ (S)))
        (SPADCALL |x| |n| (QREFELT $ 9))) 

(SDEFUN |MAGMA-;rightPower;SPiS;2|
        ((|a| (S)) (|n| (|PositiveInteger|)) ($ (S)))
        (SPROG ((|res| (S)) (#1=#:G727 NIL) (|i| NIL))
               (SEQ
                (COND ((EQL |n| 1) |a|)
                      ('T
                       (SEQ (LETT |res| |a|)
                            (SEQ (LETT |i| 1) (LETT #1# (- |n| 1)) G190
                                 (COND ((|greater_SI| |i| #1#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |res|
                                         (SPADCALL |res| |a| (QREFELT $ 11)))))
                                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT |res|))))))) 

(SDEFUN |MAGMA-;leftPower;SPiS;3| ((|a| (S)) (|n| (|PositiveInteger|)) ($ (S)))
        (SPROG ((|res| (S)) (#1=#:G732 NIL) (|i| NIL))
               (SEQ
                (COND ((EQL |n| 1) |a|)
                      ('T
                       (SEQ (LETT |res| |a|)
                            (SEQ (LETT |i| 1) (LETT #1# (- |n| 1)) G190
                                 (COND ((|greater_SI| |i| #1#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |res|
                                         (SPADCALL |a| |res| (QREFELT $ 11)))))
                                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT |res|))))))) 

(DECLAIM (NOTINLINE |Magma&;|)) 

(DEFUN |Magma&| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|Magma&| DV$1))
          (LETT $ (GETREFV 14))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|Magma&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|PositiveInteger|)
              (|RepeatedSquaring| 6) (0 . |expt|) |MAGMA-;^;SPiS;1| (6 . *)
              |MAGMA-;rightPower;SPiS;2| |MAGMA-;leftPower;SPiS;3|)
           '#(|rightPower| 12 |leftPower| 18 ^ 24) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((^ (|#1| |#1| (|PositiveInteger|))) T)
                                   '((|leftPower|
                                      (|#1| |#1| (|PositiveInteger|)))
                                     T)
                                   '((|rightPower|
                                      (|#1| |#1| (|PositiveInteger|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 13
                                            '(2 8 6 6 7 9 2 6 0 0 0 11 2 0 0 0
                                              7 12 2 0 0 0 7 13 2 0 0 0 7
                                              10)))))
           '|lookupComplete|)) 
