
(SDEFUN |LNAGG-;indices;AL;1| ((|a| (A)) ($ (|List| (|Integer|))))
        (SPROG ((#1=#:G717 NIL) (|i| NIL) (#2=#:G716 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| (SPADCALL |a| (QREFELT $ 9)))
                      (LETT #1# (SPADCALL |a| (QREFELT $ 10))) G190
                      (COND ((> |i| #1#) (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS |i| #2#))))
                      (LETT |i| (+ |i| 1)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |LNAGG-;index?;IAB;2| ((|i| (|Integer|)) (|a| (A)) ($ (|Boolean|)))
        (COND
         ((>= |i| (SPADCALL |a| (QREFELT $ 9)))
          (<= |i| (SPADCALL |a| (QREFELT $ 10))))
         ('T NIL))) 

(SDEFUN |LNAGG-;concat;ASA;3| ((|a| (A)) (|x| (S)) ($ (A)))
        (SPADCALL |a| (SPADCALL 1 |x| (QREFELT $ 16)) (QREFELT $ 17))) 

(SDEFUN |LNAGG-;concat;S2A;4| ((|x| (S)) (|y| (A)) ($ (A)))
        (SPADCALL (SPADCALL 1 |x| (QREFELT $ 16)) |y| (QREFELT $ 17))) 

(SDEFUN |LNAGG-;insert;SAIA;5| ((|x| (S)) (|a| (A)) (|i| (|Integer|)) ($ (A)))
        (SPADCALL (SPADCALL 1 |x| (QREFELT $ 16)) |a| |i| (QREFELT $ 20))) 

(SDEFUN |LNAGG-;first;ANniA;6| ((|x| (A)) (|n| (|NonNegativeInteger|)) ($ (A)))
        (SPADCALL |x|
                  (SPADCALL (SPADCALL |x| (QREFELT $ 9))
                            (SPADCALL 0 (- |n| 1) (QREFELT $ 23))
                            (QREFELT $ 24))
                  (QREFELT $ 25))) 

(SDEFUN |LNAGG-;maxIndex;AI;7| ((|l| (A)) ($ (|Integer|)))
        (+ (- (SPADCALL |l| (QREFELT $ 27)) 1) (SPADCALL |l| (QREFELT $ 9)))) 

(SDEFUN |LNAGG-;position;SAI;8| ((|x| (S)) (|t| (A)) ($ (|Integer|)))
        (SPADCALL |x| |t| (SPADCALL |t| (QREFELT $ 9)) (QREFELT $ 29))) 

(SDEFUN |LNAGG-;leftTrim;ASA;9| ((|u| (A)) (|x| (S)) ($ (A)))
        (SPROG ((#1=#:G730 NIL) (|i| NIL) (|n| (|Integer|)))
               (SEQ (LETT |n| (SPADCALL |u| (QREFELT $ 10)))
                    (SEQ (LETT |i| (SPADCALL |u| (QREFELT $ 9))) (LETT #1# |n|)
                         G190
                         (COND
                          ((OR (> |i| #1#)
                               (NULL
                                (SPADCALL (SPADCALL |u| |i| (QREFELT $ 31)) |x|
                                          (QREFELT $ 32))))
                           (GO G191)))
                         (SEQ (EXIT 0)) (LETT |i| (+ |i| 1)) (GO G190) G191
                         (EXIT NIL))
                    (EXIT
                     (SPADCALL |u| (SPADCALL |i| |n| (QREFELT $ 23))
                               (QREFELT $ 25)))))) 

(SDEFUN |LNAGG-;rightTrim;ASA;10| ((|u| (A)) (|x| (S)) ($ (A)))
        (SPROG ((#1=#:G735 NIL) (|j| NIL) (|mn| (|Integer|)))
               (SEQ (LETT |mn| (SPADCALL |u| (QREFELT $ 9)))
                    (SEQ (LETT |j| (SPADCALL |u| (QREFELT $ 10)))
                         (LETT #1# |mn|) G190
                         (COND
                          ((OR (< |j| #1#)
                               (NULL
                                (SPADCALL (SPADCALL |u| |j| (QREFELT $ 31)) |x|
                                          (QREFELT $ 32))))
                           (GO G191)))
                         (SEQ (EXIT 0)) (LETT |j| (+ |j| -1)) (GO G190) G191
                         (EXIT NIL))
                    (EXIT
                     (SPADCALL |u| (SPADCALL |mn| |j| (QREFELT $ 23))
                               (QREFELT $ 25)))))) 

(SDEFUN |LNAGG-;trim;ASA;11| ((|u| (A)) (|x| (S)) ($ (A)))
        (SPROG
         ((#1=#:G743 NIL) (|j| NIL) (#2=#:G742 NIL) (|i| NIL)
          (|mn| (|Integer|)) (|n| (|Integer|)))
         (SEQ (LETT |n| (SPADCALL |u| (QREFELT $ 10)))
              (LETT |mn| (SPADCALL |u| (QREFELT $ 9)))
              (SEQ (LETT |i| |mn|) (LETT #2# |n|) G190
                   (COND
                    ((OR (> |i| #2#)
                         (NULL
                          (SPADCALL (SPADCALL |u| |i| (QREFELT $ 31)) |x|
                                    (QREFELT $ 32))))
                     (GO G191)))
                   (SEQ (EXIT 0)) (LETT |i| (+ |i| 1)) (GO G190) G191
                   (EXIT NIL))
              (SEQ (LETT |j| |n|) (LETT #1# |i|) G190
                   (COND
                    ((OR (< |j| #1#)
                         (NULL
                          (SPADCALL (SPADCALL |u| |j| (QREFELT $ 31)) |x|
                                    (QREFELT $ 32))))
                     (GO G191)))
                   (SEQ (EXIT 0)) (LETT |j| (+ |j| -1)) (GO G190) G191
                   (EXIT NIL))
              (EXIT
               (SPADCALL |u| (SPADCALL |i| |j| (QREFELT $ 23))
                         (QREFELT $ 25)))))) 

(SDEFUN |LNAGG-;hashUpdate!;HsAHs;12|
        ((|s| (|HashState|)) (|x| (A)) ($ (|HashState|)))
        (SPROG ((#1=#:G748 NIL) (|i| NIL))
               (SEQ
                (SEQ (LETT |i| (SPADCALL |x| (QREFELT $ 9)))
                     (LETT #1# (SPADCALL |x| (QREFELT $ 10))) G190
                     (COND ((> |i| #1#) (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |s|
                             (SPADCALL |s| (SPADCALL |x| |i| (QREFELT $ 36))
                                       (QREFELT $ 38)))))
                     (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                (EXIT |s|)))) 

(SDEFUN |LNAGG-;sorted?;AB;13| ((|l| (A)) ($ (|Boolean|)))
        (SPADCALL (ELT $ 40) |l| (QREFELT $ 42))) 

(SDEFUN |LNAGG-;merge;3A;14| ((|x| (A)) (|y| (A)) ($ (A)))
        (SPADCALL (ELT $ 44) |x| |y| (QREFELT $ 45))) 

(SDEFUN |LNAGG-;sort;2A;15| ((|l| (A)) ($ (A)))
        (SPADCALL (ELT $ 44) |l| (QREFELT $ 47))) 

(SDEFUN |LNAGG-;reverse;2A;16| ((|x| (A)) ($ (A)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 49)) (QREFELT $ 50))) 

(SDEFUN |LNAGG-;sort;M2A;17|
        ((|f| (|Mapping| (|Boolean|) S S)) (|l| (A)) ($ (A)))
        (SPADCALL |f| (SPADCALL |l| (QREFELT $ 49)) (QREFELT $ 52))) 

(SDEFUN |LNAGG-;sort!;2A;18| ((|l| (A)) ($ (A)))
        (SPADCALL (ELT $ 44) |l| (QREFELT $ 52))) 

(DECLAIM (NOTINLINE |LinearAggregate&;|)) 

(DEFUN |LinearAggregate&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|LinearAggregate&| DV$1 DV$2))
          (LETT $ (GETREFV 57))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|OrderedSet|))
                                              (|HasCategory| |#2|
                                                             '(|Comparable|))
                                              (|HasCategory| |#2|
                                                             '(|BasicType|))
                                              (|HasCategory| |#1|
                                                             '(|finiteAggregate|))
                                              (|HasCategory| |#1|
                                                             '(|shallowlyMutable|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 4)
            (PROGN
             (QSETREFV $ 28
                       (CONS (|dispatchFunction| |LNAGG-;maxIndex;AI;7|) $))
             (COND
              ((|testBitVector| |pv$| 3)
               (PROGN
                (QSETREFV $ 30
                          (CONS (|dispatchFunction| |LNAGG-;position;SAI;8|)
                                $))
                (QSETREFV $ 33
                          (CONS (|dispatchFunction| |LNAGG-;leftTrim;ASA;9|)
                                $))
                (QSETREFV $ 34
                          (CONS (|dispatchFunction| |LNAGG-;rightTrim;ASA;10|)
                                $))
                (QSETREFV $ 35
                          (CONS (|dispatchFunction| |LNAGG-;trim;ASA;11|)
                                $)))))
             (COND
              ((|HasCategory| |#2| '(|SetCategory|))
               (QSETREFV $ 39
                         (CONS
                          (|dispatchFunction| |LNAGG-;hashUpdate!;HsAHs;12|)
                          $))))
             (COND
              ((|testBitVector| |pv$| 1)
               (PROGN
                (QSETREFV $ 43
                          (CONS (|dispatchFunction| |LNAGG-;sorted?;AB;13|) $))
                (QSETREFV $ 46
                          (CONS (|dispatchFunction| |LNAGG-;merge;3A;14|) $))
                (QSETREFV $ 48
                          (CONS (|dispatchFunction| |LNAGG-;sort;2A;15|) $)))))
             (COND
              ((|testBitVector| |pv$| 5)
               (PROGN
                (QSETREFV $ 51
                          (CONS (|dispatchFunction| |LNAGG-;reverse;2A;16|) $))
                (QSETREFV $ 53
                          (CONS (|dispatchFunction| |LNAGG-;sort;M2A;17|) $))
                (COND
                 ((|testBitVector| |pv$| 1)
                  (QSETREFV $ 54
                            (CONS (|dispatchFunction| |LNAGG-;sort!;2A;18|)
                                  $))))))))))
          $))) 

(MAKEPROP '|LinearAggregate&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Integer|)
              (0 . |minIndex|) (5 . |maxIndex|) (|List| 8)
              |LNAGG-;indices;AL;1| (|Boolean|) |LNAGG-;index?;IAB;2|
              (|NonNegativeInteger|) (10 . |new|) (16 . |concat|)
              |LNAGG-;concat;ASA;3| |LNAGG-;concat;S2A;4| (22 . |insert|)
              |LNAGG-;insert;SAIA;5| (|UniversalSegment| 8) (29 . SEGMENT)
              (35 . +) (41 . |elt|) |LNAGG-;first;ANniA;6| (47 . |#|)
              (52 . |maxIndex|) (57 . |position|) (64 . |position|)
              (70 . |elt|) (76 . =) (82 . |leftTrim|) (88 . |rightTrim|)
              (94 . |trim|) (100 . |qelt|) (|HashState|) (106 . |hashUpdate!|)
              (112 . |hashUpdate!|) (118 . <=) (|Mapping| 13 7 7)
              (124 . |sorted?|) (130 . |sorted?|) (135 . <) (141 . |merge|)
              (148 . |merge|) (154 . |sort|) (160 . |sort|) (165 . |copy|)
              (170 . |reverse!|) (175 . |reverse|) (180 . |sort!|)
              (186 . |sort|) (192 . |sort!|) (|Mapping| 13 7) (|List| $))
           '#(|trim| 197 |sorted?| 203 |sort!| 208 |sort| 213 |rightTrim| 224
              |reverse| 230 |position| 235 |merge| 241 |maxIndex| 247
              |leftTrim| 252 |insert| 258 |indices| 265 |index?| 270
              |hashUpdate!| 276 |first| 282 |concat| 288)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|hashUpdate!|
                                 ((|HashState|) (|HashState|) |#1|))
                                T)
                              '((|sort!| (|#1| |#1|)) T)
                              '((|sort!|
                                 (|#1| (|Mapping| (|Boolean|) |#2| |#2|) |#1|))
                                T)
                              '((|sorted?| ((|Boolean|) |#1|)) T)
                              '((|sort| (|#1| |#1|)) T)
                              '((|merge| (|#1| |#1| |#1|)) T)
                              '((|trim| (|#1| |#1| |#2|)) T)
                              '((|rightTrim| (|#1| |#1| |#2|)) T)
                              '((|leftTrim| (|#1| |#1| |#2|)) T)
                              '((|position|
                                 ((|Integer|) |#2| |#1| (|Integer|)))
                                T)
                              '((|position| ((|Integer|) |#2| |#1|)) T)
                              '((|position|
                                 ((|Integer|) (|Mapping| (|Boolean|) |#2|)
                                  |#1|))
                                T)
                              '((|sorted?|
                                 ((|Boolean|) (|Mapping| (|Boolean|) |#2| |#2|)
                                  |#1|))
                                T)
                              '((|sort|
                                 (|#1| (|Mapping| (|Boolean|) |#2| |#2|) |#1|))
                                T)
                              '((|reverse| (|#1| |#1|)) T)
                              '((|merge|
                                 (|#1| (|Mapping| (|Boolean|) |#2| |#2|) |#1|
                                  |#1|))
                                T)
                              '((|insert| (|#1| |#1| |#1| (|Integer|))) T)
                              '((|insert| (|#1| |#2| |#1| (|Integer|))) T)
                              '((|first| (|#1| |#1| (|NonNegativeInteger|))) T)
                              '((|concat| (|#1| (|List| |#1|))) T)
                              '((|concat| (|#1| |#1| |#1|)) T)
                              '((|concat| (|#1| |#2| |#1|)) T)
                              '((|concat| (|#1| |#1| |#2|)) T)
                              '((|first| (|#2| |#1|)) T)
                              '((|maxIndex| ((|Integer|) |#1|)) T)
                              '((|indices| ((|List| (|Integer|)) |#1|)) T)
                              '((|index?| ((|Boolean|) (|Integer|) |#1|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 54
                                            '(1 6 8 0 9 1 6 8 0 10 2 6 0 15 7
                                              16 2 6 0 0 0 17 3 6 0 0 0 8 20 2
                                              22 0 8 8 23 2 22 0 8 0 24 2 6 0 0
                                              22 25 1 6 15 0 27 1 0 8 0 28 3 6
                                              8 7 0 8 29 2 0 8 7 0 30 2 6 7 0 8
                                              31 2 7 13 0 0 32 2 0 0 0 7 33 2 0
                                              0 0 7 34 2 0 0 0 7 35 2 6 7 0 8
                                              36 2 7 37 37 0 38 2 0 37 37 0 39
                                              2 7 13 0 0 40 2 6 13 41 0 42 1 0
                                              13 0 43 2 7 13 0 0 44 3 6 0 41 0
                                              0 45 2 0 0 0 0 46 2 6 0 41 0 47 1
                                              0 0 0 48 1 6 0 0 49 1 6 0 0 50 1
                                              0 0 0 51 2 6 0 41 0 52 2 0 0 41 0
                                              53 1 0 0 0 54 2 0 0 0 7 35 1 0 13
                                              0 43 1 0 0 0 54 1 0 0 0 48 2 0 0
                                              41 0 53 2 0 0 0 7 34 1 0 0 0 51 2
                                              0 8 7 0 30 2 0 0 0 0 46 1 0 8 0
                                              28 2 0 0 0 7 33 3 0 0 7 0 8 21 1
                                              0 11 0 12 2 0 13 8 0 14 2 0 37 37
                                              0 39 2 0 0 0 15 26 2 0 0 0 7 18 2
                                              0 0 7 0 19)))))
           '|lookupComplete|)) 
