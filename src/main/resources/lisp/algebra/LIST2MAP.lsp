
(SDEFUN |LIST2MAP;match;LLM;1|
        ((|la| (|List| A)) (|lb| (|List| B)) ($ (|Mapping| B A)))
        (SPROG NIL (CONS #'|LIST2MAP;match;LLM;1!0| (VECTOR $ |lb| |la|)))) 

(SDEFUN |LIST2MAP;match;LLM;1!0| ((|z1| NIL) ($$ NIL))
        (PROG (|la| |lb| $)
          (LETT |la| (QREFELT $$ 2))
          (LETT |lb| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |la| |lb| |z1| (QREFELT $ 10)))))) 

(SDEFUN |LIST2MAP;match;LLAB;2|
        ((|la| (|List| A)) (|lb| (|List| B)) (|a| (A)) ($ (B)))
        (SPADCALL |lb| (SPADCALL |a| |la| (QREFELT $ 14)) (QREFELT $ 15))) 

(SDEFUN |LIST2MAP;match;LLBM;3|
        ((|la| (|List| A)) (|lb| (|List| B)) (|b| (B)) ($ (|Mapping| B A)))
        (SPROG NIL (CONS #'|LIST2MAP;match;LLBM;3!0| (VECTOR $ |b| |lb| |la|)))) 

(SDEFUN |LIST2MAP;match;LLBM;3!0| ((|z1| NIL) ($$ NIL))
        (PROG (|la| |lb| |b| $)
          (LETT |la| (QREFELT $$ 3))
          (LETT |lb| (QREFELT $$ 2))
          (LETT |b| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |la| |lb| |z1| |b| (QREFELT $ 16)))))) 

(SDEFUN |LIST2MAP;match;LL2M;4|
        ((|la| (|List| A)) (|lb| (|List| B)) (|f| (|Mapping| B A))
         ($ (|Mapping| B A)))
        (SPROG NIL (CONS #'|LIST2MAP;match;LL2M;4!0| (VECTOR $ |f| |lb| |la|)))) 

(SDEFUN |LIST2MAP;match;LL2M;4!0| ((|z1| NIL) ($$ NIL))
        (PROG (|la| |lb| |f| $)
          (LETT |la| (QREFELT $$ 3))
          (LETT |lb| (QREFELT $$ 2))
          (LETT |f| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |la| |lb| |z1| |f| (QREFELT $ 18)))))) 

(SDEFUN |LIST2MAP;match;LLA2B;5|
        ((|la| (|List| A)) (|lb| (|List| B)) (|a| (A)) (|b| (B)) ($ (B)))
        (SPROG ((|p| (|Integer|)))
               (COND
                ((< (LETT |p| (SPADCALL |a| |la| (QREFELT $ 14)))
                    (PROGN |la| 1))
                 |b|)
                ('T (SPADCALL |lb| |p| (QREFELT $ 15)))))) 

(SDEFUN |LIST2MAP;match;LLAMB;6|
        ((|la| (|List| A)) (|lb| (|List| B)) (|a| (A)) (|f| (|Mapping| B A))
         ($ (B)))
        (SPROG ((|p| (|Integer|)))
               (COND
                ((< (LETT |p| (SPADCALL |a| |la| (QREFELT $ 14)))
                    (PROGN |la| 1))
                 (SPADCALL |a| |f|))
                ('T (SPADCALL |lb| |p| (QREFELT $ 15)))))) 

(DECLAIM (NOTINLINE |ListToMap;|)) 

(DEFUN |ListToMap| (&REST #1=#:G719)
  (SPROG NIL
         (PROG (#2=#:G720)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ListToMap|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ListToMap;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|ListToMap|)))))))))) 

(DEFUN |ListToMap;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|ListToMap| DV$1 DV$2))
          (LETT $ (GETREFV 20))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ListToMap| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ListToMap| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|List| 6)
              (|List| 7) |LIST2MAP;match;LLAB;2| (|Mapping| 7 6)
              |LIST2MAP;match;LLM;1| (|Integer|) (0 . |position|) (6 . |elt|)
              |LIST2MAP;match;LLA2B;5| |LIST2MAP;match;LLBM;3|
              |LIST2MAP;match;LLAMB;6| |LIST2MAP;match;LL2M;4|)
           '#(|match| 12) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|match|
                                 ((|Mapping| |#2| |#1|) (|List| |#1|)
                                  (|List| |#2|)))
                                T)
                              '((|match|
                                 (|#2| (|List| |#1|) (|List| |#2|) |#1|))
                                T)
                              '((|match|
                                 ((|Mapping| |#2| |#1|) (|List| |#1|)
                                  (|List| |#2|) |#2|))
                                T)
                              '((|match|
                                 (|#2| (|List| |#1|) (|List| |#2|) |#1| |#2|))
                                T)
                              '((|match|
                                 ((|Mapping| |#2| |#1|) (|List| |#1|)
                                  (|List| |#2|) (|Mapping| |#2| |#1|)))
                                T)
                              '((|match|
                                 (|#2| (|List| |#1|) (|List| |#2|) |#1|
                                  (|Mapping| |#2| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 19
                                            '(2 8 13 6 0 14 2 9 7 0 13 15 2 0
                                              11 8 9 12 3 0 11 8 9 7 17 3 0 7 8
                                              9 6 10 4 0 7 8 9 6 7 16 4 0 7 8 9
                                              6 11 18 3 0 11 8 9 11 19)))))
           '|lookupComplete|)) 
