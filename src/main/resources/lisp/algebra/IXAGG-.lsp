
(SDEFUN |IXAGG-;elt;SIndex2Entry;1|
        ((|a| (S)) (|i| (|Index|)) (|x| (|Entry|)) ($ (|Entry|)))
        (COND
         ((SPADCALL |i| |a| (QREFELT $ 10)) (SPADCALL |a| |i| (QREFELT $ 11)))
         ('T |x|))) 

(SDEFUN |IXAGG-;entries;SL;2| ((|x| (S)) ($ (|List| |Entry|)))
        (SPADCALL |x| (QREFELT $ 14))) 

(SDEFUN |IXAGG-;entry?;EntrySB;3| ((|x| (|Entry|)) (|a| (S)) ($ (|Boolean|)))
        (SPADCALL |x| |a| (QREFELT $ 16))) 

(SDEFUN |IXAGG-;maxIndex;SIndex;4| ((|a| (S)) ($ (|Index|)))
        (SPROG
         ((#1=#:G712 NIL) (#2=#:G711 (|Index|)) (#3=#:G713 (|Index|))
          (#4=#:G715 NIL) (#5=#:G689 NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT #5# NIL) (LETT #4# (SPADCALL |a| (QREFELT $ 19))) G190
                (COND
                 ((OR (ATOM #4#) (PROGN (LETT #5# (CAR #4#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #3# #5#)
                   (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 20))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|IdentityError| '|max|))))))) 

(SDEFUN |IXAGG-;minIndex;SIndex;5| ((|a| (S)) ($ (|Index|)))
        (SPROG
         ((#1=#:G717 NIL) (#2=#:G716 (|Index|)) (#3=#:G718 (|Index|))
          (#4=#:G720 NIL) (#5=#:G690 NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT #5# NIL) (LETT #4# (SPADCALL |a| (QREFELT $ 19))) G190
                (COND
                 ((OR (ATOM #4#) (PROGN (LETT #5# (CAR #4#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #3# #5#)
                   (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 22))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|IdentityError| '|min|))))))) 

(SDEFUN |IXAGG-;first;SEntry;6| ((|a| (S)) ($ (|Entry|)))
        (SPADCALL |a| (SPADCALL |a| (QREFELT $ 24)) (QREFELT $ 25))) 

(SDEFUN |IXAGG-;map;M2S;7|
        ((|f| (|Mapping| |Entry| |Entry|)) (|a| (S)) ($ (S)))
        (SPADCALL |f| (SPADCALL |a| (QREFELT $ 27)) (QREFELT $ 29))) 

(SDEFUN |IXAGG-;map!;M2S;8|
        ((|f| (|Mapping| |Entry| |Entry|)) (|a| (S)) ($ (S)))
        (SPROG ((#1=#:G728 NIL) (|i| NIL))
               (SEQ
                (SEQ (LETT |i| NIL) (LETT #1# (SPADCALL |a| (QREFELT $ 19)))
                     G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (SPADCALL |a| |i|
                                 (SPADCALL (SPADCALL |a| |i| (QREFELT $ 11))
                                           |f|)
                                 (QREFELT $ 31))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT |a|)))) 

(SDEFUN |IXAGG-;fill!;SEntryS;9| ((|a| (S)) (|x| (|Entry|)) ($ (S)))
        (SPROG ((#1=#:G733 NIL) (|i| NIL))
               (SEQ
                (SEQ (LETT |i| NIL) (LETT #1# (SPADCALL |a| (QREFELT $ 19)))
                     G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ (EXIT (SPADCALL |a| |i| |x| (QREFELT $ 31))))
                     (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                (EXIT |a|)))) 

(SDEFUN |IXAGG-;swap!;S2IndexV;10|
        ((|a| (S)) (|i| (|Index|)) (|j| (|Index|)) ($ (|Void|)))
        (SPROG ((|t| (|Entry|)))
               (SEQ (LETT |t| (SPADCALL |a| |i| (QREFELT $ 25)))
                    (SPADCALL |a| |i| (SPADCALL |a| |j| (QREFELT $ 25))
                              (QREFELT $ 31))
                    (EXIT (SPADCALL |a| |j| |t| (QREFELT $ 31)))))) 

(DECLAIM (NOTINLINE |IndexedAggregate&;|)) 

(DEFUN |IndexedAggregate&| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|IndexedAggregate&| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 36))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|shallowlyMutable|))
                                              (|HasCategory| |#2|
                                                             '(|OrderedSet|))
                                              (|HasCategory| |#1|
                                                             '(|finiteAggregate|))
                                              (|HasCategory| |#3|
                                                             '(|BasicType|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 3)
            (PROGN
             (QSETREFV $ 15
                       (CONS (|dispatchFunction| |IXAGG-;entries;SL;2|) $))
             (COND
              ((|testBitVector| |pv$| 4)
               (QSETREFV $ 17
                         (CONS (|dispatchFunction| |IXAGG-;entry?;EntrySB;3|)
                               $)))))))
          (COND
           ((|testBitVector| |pv$| 2)
            (PROGN
             (QSETREFV $ 21
                       (CONS (|dispatchFunction| |IXAGG-;maxIndex;SIndex;4|)
                             $))
             (QSETREFV $ 23
                       (CONS (|dispatchFunction| |IXAGG-;minIndex;SIndex;5|)
                             $))
             (QSETREFV $ 26
                       (CONS (|dispatchFunction| |IXAGG-;first;SEntry;6|)
                             $)))))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 30 (CONS (|dispatchFunction| |IXAGG-;map;M2S;7|) $))
             (QSETREFV $ 32 (CONS (|dispatchFunction| |IXAGG-;map!;M2S;8|) $))
             (QSETREFV $ 33
                       (CONS (|dispatchFunction| |IXAGG-;fill!;SEntryS;9|) $))
             (QSETREFV $ 35
                       (CONS (|dispatchFunction| |IXAGG-;swap!;S2IndexV;10|)
                             $)))))
          $))) 

(MAKEPROP '|IndexedAggregate&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Boolean|) (0 . |index?|) (6 . |qelt|)
              |IXAGG-;elt;SIndex2Entry;1| (|List| 8) (12 . |parts|)
              (17 . |entries|) (22 . |member?|) (28 . |entry?|) (|List| 7)
              (34 . |indices|) (39 . |max|) (45 . |maxIndex|) (50 . |min|)
              (56 . |minIndex|) (61 . |minIndex|) (66 . |elt|) (72 . |first|)
              (77 . |copy|) (|Mapping| 8 8) (82 . |map!|) (88 . |map|)
              (94 . |qsetelt!|) (101 . |map!|) (107 . |fill!|) (|Void|)
              (113 . |swap!|))
           '#(|swap!| 120 |minIndex| 127 |maxIndex| 132 |map!| 137 |map| 143
              |first| 149 |fill!| 154 |entry?| 160 |entries| 166 |elt| 171)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|swap!| ((|Void|) |#1| |#2| |#2|)) T)
                                   '((|fill!| (|#1| |#1| |#3|)) T)
                                   '((|first| (|#3| |#1|)) T)
                                   '((|minIndex| (|#2| |#1|)) T)
                                   '((|maxIndex| (|#2| |#1|)) T)
                                   '((|entry?| ((|Boolean|) |#3| |#1|)) T)
                                   '((|entries| ((|List| |#3|) |#1|)) T)
                                   '((|elt| (|#3| |#1| |#2|)) T)
                                   '((|elt| (|#3| |#1| |#2| |#3|)) T)
                                   '((|map!| (|#1| (|Mapping| |#3| |#3|) |#1|))
                                     T)
                                   '((|map| (|#1| (|Mapping| |#3| |#3|) |#1|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 35
                                            '(2 6 9 7 0 10 2 6 8 0 7 11 1 6 13
                                              0 14 1 0 13 0 15 2 6 9 8 0 16 2 0
                                              9 8 0 17 1 6 18 0 19 2 7 0 0 0 20
                                              1 0 7 0 21 2 7 0 0 0 22 1 0 7 0
                                              23 1 6 7 0 24 2 6 8 0 7 25 1 0 8
                                              0 26 1 6 0 0 27 2 6 0 28 0 29 2 0
                                              0 28 0 30 3 6 8 0 7 8 31 2 0 0 28
                                              0 32 2 0 0 0 8 33 3 0 34 0 7 7 35
                                              3 0 34 0 7 7 35 1 0 7 0 23 1 0 7
                                              0 21 2 0 0 28 0 32 2 0 0 28 0 30
                                              1 0 8 0 26 2 0 0 0 8 33 2 0 9 8 0
                                              17 1 0 13 0 15 3 0 8 0 7 8
                                              12)))))
           '|lookupComplete|)) 
