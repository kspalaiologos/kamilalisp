
(SDEFUN |STAGG-;explicitlyFinite?;AB;1| ((|x| (A)) ($ (|Boolean|)))
        (NULL (SPADCALL |x| (QREFELT $ 9)))) 

(SDEFUN |STAGG-;possiblyInfinite?;AB;2| ((|x| (A)) ($ (|Boolean|)))
        (SPADCALL |x| (QREFELT $ 9))) 

(SDEFUN |STAGG-;elt;AIS;3| ((|x| (A)) (|i| (|Integer|)) ($ (S)))
        (SPROG ((#1=#:G716 NIL))
               (SEQ (LETT |i| (- |i| (SPADCALL |x| (QREFELT $ 13))))
                    (COND
                     ((OR (< |i| 0)
                          (SPADCALL
                           (LETT |x|
                                 (SPADCALL |x|
                                           (PROG1 (LETT #1# |i|)
                                             (|check_subtype2| (>= #1# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #1#))
                                           (QREFELT $ 15)))
                           (QREFELT $ 16)))
                      (EXIT (|error| "index out of range"))))
                    (EXIT (SPADCALL |x| (QREFELT $ 17)))))) 

(SDEFUN |STAGG-;concat;3A;4| ((|x| (A)) (|y| (A)) ($ (A)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 19)) |y| (QREFELT $ 20))) 

(SDEFUN |STAGG-;concat;LA;5| ((|l| (|List| A)) ($ (A)))
        (SPROG ((|res| (A)) (#1=#:G730 NIL) (|x| NIL) (|l1| (|List| A)))
               (SEQ
                (COND ((NULL |l|) (SPADCALL (QREFELT $ 22)))
                      ('T
                       (SEQ (LETT |l1| (REVERSE |l|))
                            (LETT |res| (SPADCALL (QREFELT $ 22)))
                            (SEQ (LETT |x| NIL) (LETT #1# |l1|) G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |x| (CAR #1#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |res|
                                         (SPADCALL
                                          (SPADCALL |x| (QREFELT $ 19)) |res|
                                          (QREFELT $ 20)))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT |res|))))))) 

(SDEFUN |STAGG-;fill!;ASA;6| ((|x| (A)) (|s| (S)) ($ (A)))
        (SPROG ((|y| (A)))
               (SEQ (LETT |y| |x|)
                    (SEQ G190
                         (COND
                          ((NULL (NULL (SPADCALL |y| (QREFELT $ 16))))
                           (GO G191)))
                         (SEQ (SPADCALL |y| |s| (QREFELT $ 25))
                              (EXIT (LETT |y| (SPADCALL |y| (QREFELT $ 26)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |x|)))) 

(SDEFUN |STAGG-;setelt!;AI2S;7| ((|x| (A)) (|i| (|Integer|)) (|s| (S)) ($ (S)))
        (SPROG ((#1=#:G738 NIL))
               (SEQ (LETT |i| (- |i| (SPADCALL |x| (QREFELT $ 13))))
                    (COND
                     ((OR (< |i| 0)
                          (SPADCALL
                           (LETT |x|
                                 (SPADCALL |x|
                                           (PROG1 (LETT #1# |i|)
                                             (|check_subtype2| (>= #1# 0)
                                                               '(|NonNegativeInteger|)
                                                               '(|Integer|)
                                                               #1#))
                                           (QREFELT $ 15)))
                           (QREFELT $ 16)))
                      (EXIT (|error| "index out of range"))))
                    (EXIT (SPADCALL |x| |s| (QREFELT $ 25)))))) 

(SDEFUN |STAGG-;setelt!;AUs2S;8|
        ((|x| (A)) (|i| (|UniversalSegment| (|Integer|))) (|s| (S)) ($ (S)))
        (SPROG
         ((|y| (A)) (|z| (A)) (#1=#:G745 NIL) (#2=#:G744 NIL) (|h| (|Integer|))
          (|l| (|Integer|)))
         (SEQ
          (LETT |l|
                (- (SPADCALL |i| (QREFELT $ 30))
                   (SPADCALL |x| (QREFELT $ 13))))
          (EXIT
           (COND ((< |l| 0) (|error| "index out of range"))
                 (#3='T
                  (SEQ
                   (LETT |h|
                         (COND
                          ((SPADCALL |i| (QREFELT $ 31))
                           (- (SPADCALL |i| (QREFELT $ 32))
                              (SPADCALL |x| (QREFELT $ 13))))
                          (#3# (SPADCALL |x| (QREFELT $ 33)))))
                   (EXIT
                    (COND ((< |h| |l|) |s|)
                          (#3#
                           (SEQ
                            (LETT |y|
                                  (SPADCALL |x|
                                            (PROG1 (LETT #2# |l|)
                                              (|check_subtype2| (>= #2# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #2#))
                                            (QREFELT $ 15)))
                            (LETT |z|
                                  (SPADCALL |y|
                                            (PROG1 (LETT #1# (+ (- |h| |l|) 1))
                                              (|check_subtype2| (>= #1# 0)
                                                                '(|NonNegativeInteger|)
                                                                '(|Integer|)
                                                                #1#))
                                            (QREFELT $ 15)))
                            (SEQ G190
                                 (COND
                                  ((NULL
                                    (NULL (SPADCALL |y| |z| (QREFELT $ 34))))
                                   (GO G191)))
                                 (SEQ (SPADCALL |y| |s| (QREFELT $ 25))
                                      (EXIT
                                       (LETT |y|
                                             (SPADCALL |y| (QREFELT $ 26)))))
                                 NIL (GO G190) G191 (EXIT NIL))
                            (EXIT |s|)))))))))))) 

(SDEFUN |STAGG-;concat!;3A;9| ((|x| (A)) (|y| (A)) ($ (A)))
        (SEQ
         (COND ((SPADCALL |x| (QREFELT $ 16)) |y|)
               ('T
                (SEQ
                 (SPADCALL (SPADCALL |x| (QREFELT $ 36)) |y| (QREFELT $ 37))
                 (EXIT |x|)))))) 

(DECLAIM (NOTINLINE |StreamAggregate&;|)) 

(DEFUN |StreamAggregate&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|StreamAggregate&| DV$1 DV$2))
          (LETT $ (GETREFV 43))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#1| '(|shallowlyMutable|))
            (PROGN
             (QSETREFV $ 21 (CONS (|dispatchFunction| |STAGG-;concat;3A;4|) $))
             (QSETREFV $ 24 (CONS (|dispatchFunction| |STAGG-;concat;LA;5|) $))
             (QSETREFV $ 27 (CONS (|dispatchFunction| |STAGG-;fill!;ASA;6|) $))
             (QSETREFV $ 28
                       (CONS (|dispatchFunction| |STAGG-;setelt!;AI2S;7|) $))
             (QSETREFV $ 35
                       (CONS (|dispatchFunction| |STAGG-;setelt!;AUs2S;8|) $))
             (QSETREFV $ 38
                       (CONS (|dispatchFunction| |STAGG-;concat!;3A;9|) $)))))
          $))) 

(MAKEPROP '|StreamAggregate&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Boolean|)
              (0 . |cyclic?|) |STAGG-;explicitlyFinite?;AB;1|
              |STAGG-;possiblyInfinite?;AB;2| (|Integer|) (5 . |minIndex|)
              (|NonNegativeInteger|) (10 . |rest|) (16 . |empty?|)
              (21 . |first|) |STAGG-;elt;AIS;3| (26 . |copy|) (31 . |concat!|)
              (37 . |concat|) (43 . |empty|) (|List| $) (47 . |concat|)
              (52 . |setfirst!|) (58 . |rest|) (63 . |fill!|) (69 . |setelt!|)
              (|UniversalSegment| 12) (76 . |low|) (81 . |hasHi|) (86 . |high|)
              (91 . |maxIndex|) (96 . |eq?|) (102 . |setelt!|) (109 . |tail|)
              (114 . |setrest!|) (120 . |concat!|) '#1="last" '#2="rest"
              '#3="first" '#4="value")
           '#(|setelt!| 126 |possiblyInfinite?| 140 |fill!| 145
              |explicitlyFinite?| 151 |elt| 156 |concat!| 162 |concat| 168)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|possiblyInfinite?| ((|Boolean|) |#1|)) T)
                              '((|explicitlyFinite?| ((|Boolean|) |#1|)) T)
                              '((|setelt!| (|#2| |#1| (|Integer|) |#2|)) T)
                              '((|elt| (|#2| |#1| (|Integer|) |#2|)) T)
                              '((|elt| (|#2| |#1| (|Integer|))) T)
                              '((|fill!| (|#1| |#1| |#2|)) T)
                              '((|elt|
                                 (|#1| |#1| (|UniversalSegment| (|Integer|))))
                                T)
                              '((|concat| (|#1| |#1| |#2|)) T)
                              '((|concat| (|#1| (|List| |#1|))) T)
                              '((|setelt!|
                                 (|#2| |#1| (|UniversalSegment| (|Integer|))
                                  |#2|))
                                T)
                              '((|setelt!| (|#2| |#1| #1# |#2|)) T)
                              '((|setelt!| (|#1| |#1| #2# |#1|)) T)
                              '((|setelt!| (|#2| |#1| #3# |#2|)) T)
                              '((|concat!| (|#1| (|List| |#1|))) T)
                              '((|concat!| (|#1| |#1| |#2|)) T)
                              '((|concat!| (|#1| |#1| |#1|)) T)
                              '((|elt| (|#2| |#1| #1#)) T)
                              '((|elt| (|#1| |#1| #2#)) T)
                              '((|elt| (|#2| |#1| #3#)) T)
                              '((|concat| (|#1| |#2| |#1|)) T)
                              '((|concat| (|#1| |#1| |#1|)) T)
                              '((|setelt!| (|#2| |#1| #4# |#2|)) T)
                              '((|elt| (|#2| |#1| #4#)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 38
                                            '(1 6 8 0 9 1 6 12 0 13 2 6 0 0 14
                                              15 1 6 8 0 16 1 6 7 0 17 1 6 0 0
                                              19 2 6 0 0 0 20 2 0 0 0 0 21 0 6
                                              0 22 1 0 0 23 24 2 6 7 0 7 25 1 6
                                              0 0 26 2 0 0 0 7 27 3 0 7 0 12 7
                                              28 1 29 12 0 30 1 29 8 0 31 1 29
                                              12 0 32 1 6 12 0 33 2 6 8 0 0 34
                                              3 0 7 0 29 7 35 1 6 0 0 36 2 6 0
                                              0 0 37 2 0 0 0 0 38 3 0 7 0 12 7
                                              28 3 0 7 0 29 7 35 1 0 8 0 11 2 0
                                              0 0 7 27 1 0 8 0 10 2 0 7 0 12 18
                                              2 0 0 0 0 38 1 0 0 23 24 2 0 0 0
                                              0 21)))))
           '|lookupComplete|)) 
