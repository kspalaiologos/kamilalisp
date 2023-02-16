
(SDEFUN |RCAGG-;elt;AvalueS;1| ((|x| (A)) (T1 ("value")) ($ (S)))
        (SPADCALL |x| (QREFELT $ 8))) 

(SDEFUN |RCAGG-;leaf?;AB;2| ((|x| (A)) ($ (|Boolean|)))
        (COND ((SPADCALL |x| (QREFELT $ 12)) NIL)
              ('T (NULL (SPADCALL |x| (QREFELT $ 14)))))) 

(SDEFUN |RCAGG-;nodes;AL;3| ((|x| (A)) ($ (|List| A)))
        (SPROG ((#1=#:G728 NIL) (|y| NIL) (#2=#:G727 NIL))
               (SEQ
                (COND ((SPADCALL |x| (QREFELT $ 12)) NIL)
                      ('T
                       (CONS |x|
                             (SPADCALL
                              (PROGN
                               (LETT #2# NIL)
                               (SEQ (LETT |y| NIL)
                                    (LETT #1# (SPADCALL |x| (QREFELT $ 14)))
                                    G190
                                    (COND
                                     ((OR (ATOM #1#)
                                          (PROGN (LETT |y| (CAR #1#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #2#
                                            (CONS (SPADCALL |y| (QREFELT $ 16))
                                                  #2#))))
                                    (LETT #1# (CDR #1#)) (GO G190) G191
                                    (EXIT (NREVERSE #2#))))
                              (QREFELT $ 18)))))))) 

(SDEFUN |RCAGG-;leaves;AL;4| ((|x| (A)) ($ (|List| S)))
        (SPROG ((#1=#:G735 NIL) (|y| NIL) (#2=#:G734 NIL))
               (SEQ
                (COND ((SPADCALL |x| (QREFELT $ 12)) NIL)
                      ((SPADCALL |x| (QREFELT $ 20))
                       (LIST (SPADCALL |x| (QREFELT $ 8))))
                      ('T
                       (SPADCALL
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |y| NIL)
                              (LETT #1# (SPADCALL |x| (QREFELT $ 14))) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |y| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2#
                                      (CONS (SPADCALL |y| (QREFELT $ 22))
                                            #2#))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#))))
                        (QREFELT $ 23))))))) 

(SDEFUN |RCAGG-;setelt!;Avalue2S;5|
        ((|x| (A)) (T3 ("value")) (|y| (S)) ($ (S)))
        (SPADCALL |x| |y| (QREFELT $ 25))) 

(SDEFUN |RCAGG-;child?;2AB;6| ((|x| (A)) (|l| (A)) ($ (|Boolean|)))
        (COND ((SPADCALL |l| (QREFELT $ 12)) NIL)
              ('T (SPADCALL |x| (SPADCALL |l| (QREFELT $ 14)) (QREFELT $ 27))))) 

(SDEFUN |RCAGG-;parts;AL;7| ((|x| (A)) ($ (|List| S)))
        (SPROG ((#1=#:G743 NIL) (|i| NIL) (#2=#:G742 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| NIL) (LETT #1# (SPADCALL |x| (QREFELT $ 16)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |i| (QREFELT $ 8)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(DECLAIM (NOTINLINE |RecursiveAggregate&;|)) 

(DEFUN |RecursiveAggregate&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|RecursiveAggregate&| DV$1 DV$2))
          (LETT $ (GETREFV 30))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|shallowlyMutable|))
                                              (|HasCategory| |#2|
                                                             '(|BasicType|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 1)
            (QSETREFV $ 26
                      (CONS (|dispatchFunction| |RCAGG-;setelt!;Avalue2S;5|)
                            $))))
          (COND
           ((|HasCategory| |#1| '(|BasicType|))
            (COND
             ((|testBitVector| |pv$| 2)
              (QSETREFV $ 28
                        (CONS (|dispatchFunction| |RCAGG-;child?;2AB;6|)
                              $))))))
          (COND
           ((|HasCategory| |#1| '(|finiteAggregate|))
            (QSETREFV $ 29 (CONS (|dispatchFunction| |RCAGG-;parts;AL;7|) $))))
          $))) 

(MAKEPROP '|RecursiveAggregate&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (0 . |value|) '#1="value" |RCAGG-;elt;AvalueS;1| (|Boolean|)
              (5 . |empty?|) (|List| $) (10 . |children|) |RCAGG-;leaf?;AB;2|
              (15 . |nodes|) (|List| 6) (20 . |concat|) |RCAGG-;nodes;AL;3|
              (25 . |leaf?|) (|List| 7) (30 . |leaves|) (35 . |concat|)
              |RCAGG-;leaves;AL;4| (40 . |setvalue!|) (46 . |setelt!|)
              (53 . |member?|) (59 . |child?|) (65 . |parts|))
           '#(|setelt!| 70 |parts| 77 |nodes| 82 |leaves| 87 |leaf?| 92 |elt|
              97 |child?| 103)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|setelt!| (|#2| |#1| "value" |#2|)) T)
                                   '((|child?| ((|Boolean|) |#1| |#1|)) T)
                                   '((|leaves| ((|List| |#2|) |#1|)) T)
                                   '((|elt| (|#2| |#1| #1#)) T)
                                   '((|leaf?| ((|Boolean|) |#1|)) T)
                                   '((|nodes| ((|List| |#1|) |#1|)) T)
                                   '((|parts| ((|List| |#2|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 29
                                            '(1 6 7 0 8 1 6 11 0 12 1 6 13 0 14
                                              1 6 13 0 16 1 17 0 13 18 1 6 11 0
                                              20 1 6 21 0 22 1 21 0 13 23 2 6 7
                                              0 7 25 3 0 7 0 9 7 26 2 17 11 6 0
                                              27 2 0 11 0 0 28 1 0 21 0 29 3 0
                                              7 0 9 7 26 1 0 21 0 29 1 0 13 0
                                              19 1 0 21 0 24 1 0 11 0 15 2 0 7
                                              0 9 10 2 0 11 0 0 28)))))
           '|lookupComplete|)) 
