
(SDEFUN |BGAGG-;construct;LA;1| ((|l| (|List| S)) ($ (A)))
        (SPROG ((|x| (A)) (#1=#:G708 NIL) (|s| NIL))
               (SEQ (LETT |x| (SPADCALL (QREFELT $ 8)))
                    (SEQ (LETT |s| NIL) (LETT #1# |l|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT (LETT |x| (SPADCALL |s| |x| (QREFELT $ 9)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |x|)))) 

(DECLAIM (NOTINLINE |BagAggregate&;|)) 

(DEFUN |BagAggregate&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|BagAggregate&| DV$1 DV$2))
          (LETT $ (GETREFV 12))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|BagAggregate&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (0 . |empty|) (4 . |insert!|) (|List| 7) |BGAGG-;construct;LA;1|)
           '#(|construct| 10) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|construct| (|#1| (|List| |#2|))) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 11
                                            '(0 6 0 8 2 6 0 7 0 9 1 0 0 10
                                              11)))))
           '|lookupComplete|)) 
