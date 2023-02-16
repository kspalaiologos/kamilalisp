
(SDEFUN |DIAGG-;dictionary;LA;1| ((|l| (|List| S)) ($ (A)))
        (SPROG ((|d| (A)) (#1=#:G715 NIL) (|x| NIL))
               (SEQ (LETT |d| (SPADCALL (QREFELT $ 8)))
                    (SEQ (LETT |x| NIL) (LETT #1# |l|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |x| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT (LETT |d| (SPADCALL |x| |d| (QREFELT $ 9)))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |d|)))) 

(SDEFUN |DIAGG-;select!;M2A;2|
        ((|f| (|Mapping| (|Boolean|) S)) (|t| (A)) ($ (A)))
        (SPADCALL (CONS #'|DIAGG-;select!;M2A;2!0| |f|) |t| (QREFELT $ 13))) 

(SDEFUN |DIAGG-;select!;M2A;2!0| ((|x| NIL) (|f| NIL))
        (NULL (SPADCALL |x| |f|))) 

(SDEFUN |DIAGG-;=;2AB;3| ((|s| (A)) (|t| (A)) ($ (|Boolean|)))
        (SPROG NIL
               (COND ((SPADCALL |s| |t| (QREFELT $ 16)) 'T)
                     ((SPADCALL (SPADCALL |s| (QREFELT $ 18))
                                (SPADCALL |t| (QREFELT $ 18)) (QREFELT $ 20))
                      NIL)
                     ('T
                      (SPADCALL (CONS #'|DIAGG-;=;2AB;3!0| (VECTOR $ |t|))
                                (SPADCALL |s| (QREFELT $ 22))
                                (QREFELT $ 23)))))) 

(SDEFUN |DIAGG-;=;2AB;3!0| ((|x| NIL) ($$ NIL))
        (PROG (|t| $)
          (LETT |t| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |t| (QREFELT $ 21)))))) 

(SDEFUN |DIAGG-;remove!;M2A;4|
        ((|f| (|Mapping| (|Boolean|) S)) (|t| (A)) ($ (A)))
        (SPROG ((#1=#:G733 NIL) (|m| NIL))
               (SEQ
                (SEQ (LETT |m| NIL) (LETT #1# (SPADCALL |t| (QREFELT $ 22)))
                     G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |m| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL |m| |f|)
                         (LETT |t| (SPADCALL |m| |t| (QREFELT $ 25)))))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT |t|)))) 

(DECLAIM (NOTINLINE |Dictionary&;|)) 

(DEFUN |Dictionary&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|Dictionary&| DV$1 DV$2))
          (LETT $ (GETREFV 27))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#1| '(|finiteAggregate|))
            (PROGN
             (QSETREFV $ 14
                       (CONS (|dispatchFunction| |DIAGG-;select!;M2A;2|) $))
             (COND
              ((|HasCategory| |#2| '(|BasicType|))
               (PROGN
                (QSETREFV $ 24 (CONS (|dispatchFunction| |DIAGG-;=;2AB;3|) $))
                (QSETREFV $ 26
                          (CONS (|dispatchFunction| |DIAGG-;remove!;M2A;4|)
                                $))))))))
          $))) 

(MAKEPROP '|Dictionary&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (0 . |dictionary|) (4 . |insert!|) (|List| 7)
              |DIAGG-;dictionary;LA;1| (|Mapping| 15 7) (10 . |remove!|)
              (16 . |select!|) (|Boolean|) (22 . |eq?|) (|NonNegativeInteger|)
              (28 . |#|) (|Integer|) (33 . ~=) (39 . |member?|) (45 . |parts|)
              (50 . |every?|) (56 . =) (62 . |remove!|) (68 . |remove!|))
           '#(|select!| 74 |remove!| 80 |dictionary| 86 = 91) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|select!|
                                 (|#1| (|Mapping| (|Boolean|) |#2|) |#1|))
                                T)
                              '((|remove!|
                                 (|#1| (|Mapping| (|Boolean|) |#2|) |#1|))
                                T)
                              '((|remove!| (|#1| |#2| |#1|)) T)
                              '((|dictionary| (|#1| (|List| |#2|))) T)
                              '((|dictionary| (|#1|)) T)
                              '((= ((|Boolean|) |#1| |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 26
                                            '(0 6 0 8 2 6 0 7 0 9 2 6 0 12 0 13
                                              2 0 0 12 0 14 2 6 15 0 0 16 1 6
                                              17 0 18 2 19 15 0 0 20 2 6 15 7 0
                                              21 1 6 10 0 22 2 10 15 12 0 23 2
                                              0 15 0 0 24 2 6 0 7 0 25 2 0 0 12
                                              0 26 2 0 0 12 0 14 2 0 0 12 0 26
                                              1 0 0 10 11 2 0 15 0 0 24)))))
           '|lookupComplete|)) 
