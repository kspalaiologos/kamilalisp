
(SDEFUN |DIOPS-;construct;LA;1| ((|l| (|List| S)) ($ (A)))
        (SPADCALL |l| (QREFELT $ 9))) 

(SDEFUN |DIOPS-;dictionary;A;2| (($ (A))) (SPADCALL (QREFELT $ 11))) 

(SDEFUN |DIOPS-;copy;2A;3| ((|d| (A)) ($ (A)))
        (SPADCALL (SPADCALL |d| (QREFELT $ 13)) (QREFELT $ 9))) 

(SDEFUN |DIOPS-;coerce;AOf;4| ((|s| (A)) ($ (|OutputForm|)))
        (SPROG ((#1=#:G716 NIL) (|x| NIL) (#2=#:G715 NIL))
               (SEQ
                (SPADCALL (SPADCALL "dictionary" (QREFELT $ 17))
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |x| NIL)
                                (LETT #1# (SPADCALL |s| (QREFELT $ 13))) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |x| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS (SPADCALL |x| (QREFELT $ 18))
                                              #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (QREFELT $ 20))))) 

(DECLAIM (NOTINLINE |DictionaryOperations&;|)) 

(DEFUN |DictionaryOperations&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|DictionaryOperations&| DV$1 DV$2))
          (LETT $ (GETREFV 22))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|BasicType|))
                                              (|HasCategory| |#1|
                                                             '(|finiteAggregate|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 2)
            (PROGN
             (QSETREFV $ 14 (CONS (|dispatchFunction| |DIOPS-;copy;2A;3|) $))
             (COND
              ((|HasCategory| |#2| '(|CoercibleTo| (|OutputForm|)))
               (QSETREFV $ 21
                         (CONS (|dispatchFunction| |DIOPS-;coerce;AOf;4|)
                               $)))))))
          $))) 

(MAKEPROP '|DictionaryOperations&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|List| 7)
              (0 . |dictionary|) |DIOPS-;construct;LA;1| (5 . |empty|)
              |DIOPS-;dictionary;A;2| (9 . |parts|) (14 . |copy|)
              (|OutputForm|) (|String|) (19 . |coerce|) (24 . |coerce|)
              (|List| $) (29 . |prefix|) (35 . |coerce|))
           '#(|dictionary| 40 |copy| 44 |construct| 49 |coerce| 54) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|dictionary| (|#1| (|List| |#2|))) T)
                                   '((|dictionary| (|#1|)) T)
                                   '((|construct| (|#1| (|List| |#2|))) T)
                                   '((|coerce| ((|OutputForm|) |#1|)) T)
                                   '((|copy| (|#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 21
                                            '(1 6 0 8 9 0 6 0 11 1 6 8 0 13 1 0
                                              0 0 14 1 16 15 0 17 1 7 15 0 18 2
                                              15 0 0 19 20 1 0 15 0 21 0 0 0 12
                                              1 0 0 0 14 1 0 0 8 10 1 0 15 0
                                              21)))))
           '|lookupComplete|)) 
