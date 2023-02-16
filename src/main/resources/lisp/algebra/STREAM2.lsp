
(SDEFUN |STREAM2;mapp|
        ((|f| (|Mapping| B A)) (|x| (|Stream| A)) ($ (|Stream| B)))
        (SPROG NIL
               (SPADCALL (CONS #'|STREAM2;mapp!0| (VECTOR |f| $ |x|))
                         (QREFELT $ 19)))) 

(SDEFUN |STREAM2;mapp!0| (($$ NIL))
        (PROG (|x| $ |f|)
          (LETT |x| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (COND ((SPADCALL |x| (QREFELT $ 10)) (SPADCALL (QREFELT $ 12)))
                  ('T
                   (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 13)) |f|)
                             (SPADCALL |f| (SPADCALL |x| (QREFELT $ 14))
                                       (QREFELT $ 16))
                             (QREFELT $ 17)))))))) 

(SDEFUN |STREAM2;map;MSS;2|
        ((|f| (|Mapping| B A)) (|x| (|Stream| A)) ($ (|Stream| B)))
        (COND ((SPADCALL |x| (QREFELT $ 20)) (SPADCALL (QREFELT $ 12)))
              ((SPADCALL |x| (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 21))
               (SPADCALL (LIST (SPADCALL (SPADCALL |x| (QREFELT $ 13)) |f|))
                         (QREFELT $ 23)))
              ('T (|STREAM2;mapp| |f| |x| $)))) 

(SDEFUN |STREAM2;scan;BMSS;3|
        ((|b| (B)) (|h| (|Mapping| B A B)) (|x| (|Stream| A)) ($ (|Stream| B)))
        (SPROG NIL
               (SEQ
                (SPADCALL
                 (CONS #'|STREAM2;scan;BMSS;3!0| (VECTOR |h| |b| $ |x|))
                 (QREFELT $ 19))))) 

(SDEFUN |STREAM2;scan;BMSS;3!0| (($$ NIL))
        (PROG (|x| $ |b| |h|)
          (LETT |x| (QREFELT $$ 3))
          (LETT $ (QREFELT $$ 2))
          (LETT |b| (QREFELT $$ 1))
          (LETT |h| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|c| NIL))
                   (SEQ
                    (COND
                     ((SPADCALL |x| (QREFELT $ 10)) (SPADCALL (QREFELT $ 12)))
                     ('T
                      (SEQ
                       (LETT |c|
                             (SPADCALL (SPADCALL |x| (QREFELT $ 13)) |b| |h|))
                       (EXIT
                        (SPADCALL |c|
                                  (SPADCALL |c| |h|
                                            (SPADCALL |x| (QREFELT $ 14))
                                            (QREFELT $ 25))
                                  (QREFELT $ 17)))))))))))) 

(SDEFUN |STREAM2;reduce;BMSB;4|
        ((|b| (B)) (|h| (|Mapping| B A B)) (|x| (|Stream| A)) ($ (B)))
        (COND ((SPADCALL |x| (QREFELT $ 10)) |b|)
              ('T
               (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 13)) |b| |h|) |h|
                         (SPADCALL |x| (QREFELT $ 14)) (QREFELT $ 26))))) 

(DECLAIM (NOTINLINE |StreamFunctions2;|)) 

(DEFUN |StreamFunctions2| (&REST #1=#:G728)
  (SPROG NIL
         (PROG (#2=#:G729)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|StreamFunctions2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |StreamFunctions2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|StreamFunctions2|)))))))))) 

(DEFUN |StreamFunctions2;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|StreamFunctions2| DV$1 DV$2))
          (LETT $ (GETREFV 27))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|StreamFunctions2| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|StreamFunctions2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Boolean|)
              (|Stream| 6) (0 . |empty?|) (|Stream| 7) (5 . |empty|)
              (9 . |frst|) (14 . |rst|) (|Mapping| 7 6) |STREAM2;map;MSS;2|
              (19 . |concat|) (|Mapping| $) (25 . |delay|)
              (30 . |explicitlyEmpty?|) (35 . |eq?|) (|List| 7)
              (41 . |repeating|) (|Mapping| 7 6 7) |STREAM2;scan;BMSS;3|
              |STREAM2;reduce;BMSB;4|)
           '#(|scan| 46 |reduce| 53 |map| 60) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|map|
                                 ((|Stream| |#2|) (|Mapping| |#2| |#1|)
                                  (|Stream| |#1|)))
                                T)
                              '((|scan|
                                 ((|Stream| |#2|) |#2|
                                  (|Mapping| |#2| |#1| |#2|) (|Stream| |#1|)))
                                T)
                              '((|reduce|
                                 (|#2| |#2| (|Mapping| |#2| |#1| |#2|)
                                  (|Stream| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 26
                                            '(1 9 8 0 10 0 11 0 12 1 9 6 0 13 1
                                              9 0 0 14 2 11 0 7 0 17 1 11 0 18
                                              19 1 9 8 0 20 2 9 8 0 0 21 1 11 0
                                              22 23 3 0 11 7 24 9 25 3 0 7 7 24
                                              9 26 2 0 11 15 9 16)))))
           '|lookupComplete|)) 
