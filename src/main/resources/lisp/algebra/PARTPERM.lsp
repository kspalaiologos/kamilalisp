
(SDEFUN |PARTPERM;partitions;3IS;1|
        ((M (|Integer|)) (N (|Integer|)) (|n| (|Integer|))
         ($ (|Stream| (|List| (|Integer|)))))
        (SPROG ((|c| (|Stream| (|List| (|Integer|)))))
               (SEQ
                (COND
                 ((ZEROP |n|)
                  (SPADCALL NIL (SPADCALL (QREFELT $ 7)) (QREFELT $ 9)))
                 ((OR (ZEROP M) (OR (ZEROP N) (< |n| 0)))
                  (SPADCALL (QREFELT $ 7)))
                 ('T
                  (SEQ
                   (LETT |c|
                         (SPADCALL
                          (CONS #'|PARTPERM;partitions;3IS;1!0| (VECTOR $ N))
                          (SPADCALL (- M 1) N (- |n| N) (QREFELT $ 12))
                          (QREFELT $ 14)))
                   (EXIT
                    (SPADCALL |c| (SPADCALL M (- N 1) |n| (QREFELT $ 12))
                              (QREFELT $ 15))))))))) 

(SDEFUN |PARTPERM;partitions;3IS;1!0| ((|l1| NIL) ($$ NIL))
        (PROG (N $)
          (LETT N (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL N |l1| (QREFELT $ 11)))))) 

(SDEFUN |PARTPERM;partitions;IS;2|
        ((|n| (|Integer|)) ($ (|Stream| (|List| (|Integer|)))))
        (SPADCALL |n| |n| |n| (QREFELT $ 12))) 

(SDEFUN |PARTPERM;partitions;2IS;3|
        ((M (|Integer|)) (N (|Integer|)) ($ (|Stream| (|List| (|Integer|)))))
        (SPROG
         ((|aaa| (|List| (|Stream| (|List| (|Integer|))))) (#1=#:G724 NIL)
          (|i| NIL) (#2=#:G723 NIL))
         (SEQ
          (LETT |aaa|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| 0) (LETT #1# (* M N)) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL M N |i| (QREFELT $ 12)) #2#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT (SPADCALL (SPADCALL |aaa| (QREFELT $ 19)) (QREFELT $ 21)))))) 

(SDEFUN |PARTPERM;odd_partitions;3IS;4|
        ((M (|Integer|)) (N (|Integer|)) (|n| (|Integer|))
         ($ (|Stream| (|List| (|Integer|)))))
        (SPROG ((|c| (|Stream| (|List| (|Integer|)))))
               (SEQ
                (COND
                 ((ZEROP |n|)
                  (SPADCALL NIL (SPADCALL (QREFELT $ 7)) (QREFELT $ 9)))
                 ((OR (OR (ZEROP M) (<= N 0)) (< |n| 0))
                  (SPADCALL (QREFELT $ 7)))
                 ('T
                  (SEQ (COND ((EVENP N) (LETT N (- N 1))))
                       (LETT |c|
                             (SPADCALL
                              (CONS #'|PARTPERM;odd_partitions;3IS;4!0|
                                    (VECTOR $ N))
                              (SPADCALL (- M 1) N (- |n| N) (QREFELT $ 23))
                              (QREFELT $ 14)))
                       (EXIT
                        (SPADCALL |c| (SPADCALL M (- N 2) |n| (QREFELT $ 23))
                                  (QREFELT $ 15))))))))) 

(SDEFUN |PARTPERM;odd_partitions;3IS;4!0| ((|l1| NIL) ($$ NIL))
        (PROG (N $)
          (LETT N (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL N |l1| (QREFELT $ 11)))))) 

(SDEFUN |PARTPERM;odd_partitions;IS;5|
        ((|n| (|Integer|)) ($ (|Stream| (|List| (|Integer|)))))
        (SPADCALL |n| |n| |n| (QREFELT $ 23))) 

(SDEFUN |PARTPERM;distinct_partitions;3IS;6|
        ((M (|Integer|)) (N (|Integer|)) (|n| (|Integer|))
         ($ (|Stream| (|List| (|Integer|)))))
        (SPROG ((|c| (|Stream| (|List| (|Integer|)))))
               (SEQ
                (COND
                 ((ZEROP |n|)
                  (SPADCALL NIL (SPADCALL (QREFELT $ 7)) (QREFELT $ 9)))
                 ((OR (ZEROP M) (OR (ZEROP N) (< |n| 0)))
                  (SPADCALL (QREFELT $ 7)))
                 ('T
                  (SEQ
                   (LETT |c|
                         (SPADCALL
                          (CONS #'|PARTPERM;distinct_partitions;3IS;6!0|
                                (VECTOR $ N))
                          (SPADCALL (- M 1) (- N 1) (- |n| N) (QREFELT $ 25))
                          (QREFELT $ 14)))
                   (EXIT
                    (SPADCALL |c| (SPADCALL M (- N 1) |n| (QREFELT $ 25))
                              (QREFELT $ 15))))))))) 

(SDEFUN |PARTPERM;distinct_partitions;3IS;6!0| ((|l1| NIL) ($$ NIL))
        (PROG (N $)
          (LETT N (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL N |l1| (QREFELT $ 11)))))) 

(SDEFUN |PARTPERM;distinct_partitions;IS;7|
        ((|n| (|Integer|)) ($ (|Stream| (|List| (|Integer|)))))
        (SPADCALL |n| |n| |n| (QREFELT $ 25))) 

(SDEFUN |PARTPERM;nogreq|
        ((|n| (|Integer|)) (|x| (|List| (|Integer|))) ($ (|Integer|)))
        (SPROG
         ((#1=#:G740 NIL) (#2=#:G739 #3=(|Integer|)) (#4=#:G741 #3#)
          (#5=#:G743 NIL) (|i| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |i| NIL) (LETT #5# |x|) G190
                (COND
                 ((OR (ATOM #5#) (PROGN (LETT |i| (CAR #5#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (COND
                   ((>= |i| |n|)
                    (PROGN
                     (LETT #4# 1)
                     (COND (#1# (LETT #2# (+ #2# #4#)))
                           ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))))
                (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T 0)))))) 

(SDEFUN |PARTPERM;conjugate;2L;9|
        ((|x| (|List| (|Integer|))) ($ (|List| (|Integer|))))
        (SPROG ((#1=#:G749 NIL) (|i| NIL) (#2=#:G748 NIL))
               (SEQ
                (COND ((NULL |x|) NIL)
                      ('T
                       (PROGN
                        (LETT #2# NIL)
                        (SEQ (LETT |i| 1) (LETT #1# (|SPADfirst| |x|)) G190
                             (COND ((|greater_SI| |i| #1#) (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #2#
                                     (CONS (|PARTPERM;nogreq| |i| |x| $)
                                           #2#))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT (NREVERSE #2#))))))))) 

(SDEFUN |PARTPERM;conjugates;2S;10|
        ((|z| (|Stream| (|List| (|Integer|))))
         ($ (|Stream| (|List| (|Integer|)))))
        (SPADCALL (ELT $ 27) |z| (QREFELT $ 14))) 

(SDEFUN |PARTPERM;shuffle;2LS;11|
        ((|x| (|List| (|Integer|))) (|y| (|List| (|Integer|)))
         ($ (|Stream| (|List| (|Integer|)))))
        (SPROG NIL
               (COND
                ((NULL |x|)
                 (SPADCALL |y| (SPADCALL (QREFELT $ 7)) (QREFELT $ 9)))
                ((NULL |y|)
                 (SPADCALL |x| (SPADCALL (QREFELT $ 7)) (QREFELT $ 9)))
                ('T
                 (SPADCALL
                  (SPADCALL (CONS #'|PARTPERM;shuffle;2LS;11!0| (VECTOR $ |x|))
                            (SPADCALL (CDR |x|) |y| (QREFELT $ 30))
                            (QREFELT $ 14))
                  (SPADCALL (CONS #'|PARTPERM;shuffle;2LS;11!1| (VECTOR $ |y|))
                            (SPADCALL |x| (CDR |y|) (QREFELT $ 30))
                            (QREFELT $ 14))
                  (QREFELT $ 15)))))) 

(SDEFUN |PARTPERM;shuffle;2LS;11!1| ((|l1| NIL) ($$ NIL))
        (PROG (|y| $)
          (LETT |y| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |y| (QREFELT $ 29)) |l1| (QREFELT $ 11)))))) 

(SDEFUN |PARTPERM;shuffle;2LS;11!0| ((|l1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| (QREFELT $ 29)) |l1| (QREFELT $ 11)))))) 

(SDEFUN |PARTPERM;shufflein;L2S;12|
        ((|x| (|List| (|Integer|))) (|yy| (|Stream| (|List| (|Integer|))))
         ($ (|Stream| (|List| (|Integer|)))))
        (SPROG NIL
               (SPADCALL
                (SPADCALL (CONS #'|PARTPERM;shufflein;L2S;12!0| (VECTOR $ |x|))
                          |yy| (QREFELT $ 33))
                (QREFELT $ 21)))) 

(SDEFUN |PARTPERM;shufflein;L2S;12!0| ((|l1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x| |l1| (QREFELT $ 30)))))) 

(SDEFUN |PARTPERM;rpt|
        ((|n| (|Integer|)) (|m| (|Integer|)) ($ (|List| (|Integer|))))
        (SPROG ((#1=#:G774 NIL) (|i| NIL) (#2=#:G773 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                      (COND ((|greater_SI| |i| #1#) (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS |m| #2#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |PARTPERM;zrpt|
        ((|x| (|List| (|Integer|))) (|y| (|List| (|Integer|)))
         ($ (|Stream| (|List| (|Integer|)))))
        (SPADCALL (CONS (|function| |PARTPERM;rpt|) $)
                  (SPADCALL |x| (QREFELT $ 36)) (SPADCALL |y| (QREFELT $ 36))
                  (QREFELT $ 39))) 

(SDEFUN |PARTPERM;sequences;2LS;15|
        ((|x| (|List| (|Integer|))) (|y| (|List| (|Integer|)))
         ($ (|Stream| (|List| (|Integer|)))))
        (SPADCALL (SPADCALL NIL (SPADCALL (QREFELT $ 7)) (QREFELT $ 9))
                  (ELT $ 34) (|PARTPERM;zrpt| |x| |y| $) (QREFELT $ 41))) 

(SDEFUN |PARTPERM;sequences;LS;16|
        ((|x| (|List| (|Integer|))) ($ (|Stream| (|List| (|Integer|)))))
        (SPROG ((#1=#:G785 NIL) (|i| NIL) (#2=#:G784 NIL))
               (SEQ
                (SPADCALL |x|
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |i| 0) (LETT #1# (- (LENGTH |x|) 1)) G190
                                (COND ((|greater_SI| |i| #1#) (GO G191)))
                                (SEQ (EXIT (LETT #2# (CONS |i| #2#))))
                                (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (QREFELT $ 42))))) 

(SDEFUN |PARTPERM;permutations;IS;17|
        ((|n| (|Integer|)) ($ (|Stream| (|List| (|Integer|)))))
        (SPROG ((#1=#:G790 NIL) (|i| NIL) (#2=#:G789 NIL))
               (SEQ
                (SPADCALL (|PARTPERM;rpt| |n| 1 $)
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                                (COND ((|greater_SI| |i| #1#) (GO G191)))
                                (SEQ (EXIT (LETT #2# (CONS |i| #2#))))
                                (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (QREFELT $ 42))))) 

(DECLAIM (NOTINLINE |PartitionsAndPermutations;|)) 

(DEFUN |PartitionsAndPermutations| ()
  (SPROG NIL
         (PROG (#1=#:G792)
           (RETURN
            (COND
             ((LETT #1#
                    (HGET |$ConstructorCache| '|PartitionsAndPermutations|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|PartitionsAndPermutations|
                             (LIST
                              (CONS NIL
                                    (CONS 1 (|PartitionsAndPermutations;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#)
                  (HREM |$ConstructorCache|
                        '|PartitionsAndPermutations|)))))))))) 

(DEFUN |PartitionsAndPermutations;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|PartitionsAndPermutations|))
          (LETT $ (GETREFV 45))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PartitionsAndPermutations| NIL
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PartitionsAndPermutations| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|Stream| 8) (0 . |empty|) (|List| 10)
              (4 . |concat|) (|Integer|) (10 . |concat|)
              |PARTPERM;partitions;3IS;1| (|Mapping| 8 8) (16 . |map|)
              (22 . |concat|) |PARTPERM;partitions;IS;2| (|List| 6)
              (|Stream| 6) (28 . |coerce|) (|StreamFunctions1| 8)
              (33 . |concat|) |PARTPERM;partitions;2IS;3|
              |PARTPERM;odd_partitions;3IS;4| |PARTPERM;odd_partitions;IS;5|
              |PARTPERM;distinct_partitions;3IS;6|
              |PARTPERM;distinct_partitions;IS;7| |PARTPERM;conjugate;2L;9|
              |PARTPERM;conjugates;2S;10| (38 . |first|)
              |PARTPERM;shuffle;2LS;11| (|Mapping| 6 8)
              (|StreamFunctions2| 8 6) (43 . |map|) |PARTPERM;shufflein;L2S;12|
              (|Stream| 10) (49 . |coerce|) (|Mapping| 8 10 10)
              (|StreamFunctions3| 10 10 8) (54 . |map|) (|Mapping| 6 8 6)
              (61 . |reduce|) |PARTPERM;sequences;2LS;15|
              |PARTPERM;sequences;LS;16| |PARTPERM;permutations;IS;17|)
           '#(|shufflein| 68 |shuffle| 74 |sequences| 80 |permutations| 91
              |partitions| 96 |odd_partitions| 114 |distinct_partitions| 126
              |conjugates| 138 |conjugate| 143)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|partitions|
                                 ((|Stream| (|List| (|Integer|))) (|Integer|)
                                  (|Integer|) (|Integer|)))
                                T)
                              '((|partitions|
                                 ((|Stream| (|List| (|Integer|))) (|Integer|)))
                                T)
                              '((|partitions|
                                 ((|Stream| (|List| (|Integer|))) (|Integer|)
                                  (|Integer|)))
                                T)
                              '((|odd_partitions|
                                 ((|Stream| (|List| (|Integer|))) (|Integer|)
                                  (|Integer|) (|Integer|)))
                                T)
                              '((|odd_partitions|
                                 ((|Stream| (|List| (|Integer|))) (|Integer|)))
                                T)
                              '((|distinct_partitions|
                                 ((|Stream| (|List| (|Integer|))) (|Integer|)
                                  (|Integer|) (|Integer|)))
                                T)
                              '((|distinct_partitions|
                                 ((|Stream| (|List| (|Integer|))) (|Integer|)))
                                T)
                              '((|conjugate|
                                 ((|List| (|Integer|)) (|List| (|Integer|))))
                                T)
                              '((|conjugates|
                                 ((|Stream| (|List| (|Integer|)))
                                  (|Stream| (|List| (|Integer|)))))
                                T)
                              '((|shuffle|
                                 ((|Stream| (|List| (|Integer|)))
                                  (|List| (|Integer|)) (|List| (|Integer|))))
                                T)
                              '((|shufflein|
                                 ((|Stream| (|List| (|Integer|)))
                                  (|List| (|Integer|))
                                  (|Stream| (|List| (|Integer|)))))
                                T)
                              '((|sequences|
                                 ((|Stream| (|List| (|Integer|)))
                                  (|List| (|Integer|)) (|List| (|Integer|))))
                                T)
                              '((|sequences|
                                 ((|Stream| (|List| (|Integer|)))
                                  (|List| (|Integer|))))
                                T)
                              '((|permutations|
                                 ((|Stream| (|List| (|Integer|))) (|Integer|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 44
                                            '(0 6 0 7 2 6 0 8 0 9 2 8 0 10 0 11
                                              2 6 0 13 0 14 2 6 0 0 0 15 1 18 0
                                              17 19 1 20 6 18 21 1 8 10 0 29 2
                                              32 18 31 6 33 1 35 0 8 36 3 38 6
                                              37 35 35 39 3 32 6 6 40 6 41 2 0
                                              6 8 6 34 2 0 6 8 8 30 2 0 6 8 8
                                              42 1 0 6 8 43 1 0 6 10 44 3 0 6
                                              10 10 10 12 2 0 6 10 10 22 1 0 6
                                              10 16 1 0 6 10 24 3 0 6 10 10 10
                                              23 1 0 6 10 26 3 0 6 10 10 10 25
                                              1 0 6 6 28 1 0 8 8 27)))))
           '|lookupComplete|)) 

(MAKEPROP '|PartitionsAndPermutations| 'NILADIC T) 
