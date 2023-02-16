
(SDEFUN |STREAM3;mapp|
        ((|g| (|Mapping| C A B)) (|x| (|Stream| A)) (|y| (|Stream| B))
         ($ (|Stream| C)))
        (SPROG NIL
               (SPADCALL (CONS #'|STREAM3;mapp!0| (VECTOR |g| |y| $ |x|))
                         (QREFELT $ 24)))) 

(SDEFUN |STREAM3;mapp!0| (($$ NIL))
        (PROG (|x| $ |y| |g|)
          (LETT |x| (QREFELT $$ 3))
          (LETT $ (QREFELT $$ 2))
          (LETT |y| (QREFELT $$ 1))
          (LETT |g| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND
             ((OR (SPADCALL |x| (QREFELT $ 11)) (SPADCALL |y| (QREFELT $ 15)))
              (SPADCALL (QREFELT $ 13)))
             ('T
              (SPADCALL
               (SPADCALL (SPADCALL |x| (QREFELT $ 16))
                         (SPADCALL |y| (QREFELT $ 17)) |g|)
               (SPADCALL |g| (SPADCALL |x| (QREFELT $ 18))
                         (SPADCALL |y| (QREFELT $ 19)) (QREFELT $ 21))
               (QREFELT $ 22)))))))) 

(SDEFUN |STREAM3;map;MSSS;2|
        ((|g| (|Mapping| C A B)) (|x| (|Stream| A)) (|y| (|Stream| B))
         ($ (|Stream| C)))
        (SPROG NIL
               (COND ((SPADCALL |x| (QREFELT $ 25)) (SPADCALL (QREFELT $ 13)))
                     ((SPADCALL |x| (SPADCALL |x| (QREFELT $ 18))
                                (QREFELT $ 26))
                      (SPADCALL
                       (CONS #'|STREAM3;map;MSSS;2!0| (VECTOR |g| $ |x|)) |y|
                       (QREFELT $ 29)))
                     ((SPADCALL |y| (QREFELT $ 30)) (SPADCALL (QREFELT $ 13)))
                     ((SPADCALL |y| (SPADCALL |y| (QREFELT $ 19))
                                (QREFELT $ 31))
                      (SPADCALL
                       (CONS #'|STREAM3;map;MSSS;2!1| (VECTOR |g| $ |y|)) |x|
                       (QREFELT $ 34)))
                     ('T (|STREAM3;mapp| |g| |x| |y| $))))) 

(SDEFUN |STREAM3;map;MSSS;2!1| ((|z| NIL) ($$ NIL))
        (PROG (|y| $ |g|)
          (LETT |y| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |g| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z| (SPADCALL |y| (QREFELT $ 17)) |g|))))) 

(SDEFUN |STREAM3;map;MSSS;2!0| ((|z| NIL) ($$ NIL))
        (PROG (|x| $ |g|)
          (LETT |x| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |g| (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL (SPADCALL |x| (QREFELT $ 16)) |z| |g|))))) 

(DECLAIM (NOTINLINE |StreamFunctions3;|)) 

(DEFUN |StreamFunctions3| (&REST #1=#:G721)
  (SPROG NIL
         (PROG (#2=#:G722)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|StreamFunctions3|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |StreamFunctions3;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|StreamFunctions3|)))))))))) 

(DEFUN |StreamFunctions3;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|StreamFunctions3| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 35))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|StreamFunctions3|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|StreamFunctions3| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Boolean|) (|Stream| 6) (0 . |empty?|)
              (|Stream| 8) (5 . |empty|) (|Stream| 7) (9 . |empty?|)
              (14 . |frst|) (19 . |frst|) (24 . |rst|) (29 . |rst|)
              (|Mapping| 8 6 7) |STREAM3;map;MSSS;2| (34 . |concat|)
              (|Mapping| $) (40 . |delay|) (45 . |explicitlyEmpty?|)
              (50 . |eq?|) (|Mapping| 8 7) (|StreamFunctions2| 7 8)
              (56 . |map|) (62 . |explicitlyEmpty?|) (67 . |eq?|)
              (|Mapping| 8 6) (|StreamFunctions2| 6 8) (73 . |map|))
           '#(|map| 79) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|Stream| |#3|) (|Mapping| |#3| |#1| |#2|)
                                  (|Stream| |#1|) (|Stream| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 34
                                            '(1 10 9 0 11 0 12 0 13 1 14 9 0 15
                                              1 10 6 0 16 1 14 7 0 17 1 10 0 0
                                              18 1 14 0 0 19 2 12 0 8 0 22 1 12
                                              0 23 24 1 10 9 0 25 2 10 9 0 0 26
                                              2 28 12 27 14 29 1 14 9 0 30 2 14
                                              9 0 0 31 2 33 12 32 10 34 3 0 12
                                              20 10 14 21)))))
           '|lookupComplete|)) 
