
(SDEFUN |CLAGG-;find;MAU;1|
        ((|f| (|Mapping| (|Boolean|) S)) (|c| (A)) ($ (|Union| S "failed")))
        (SPADCALL |f| (SPADCALL |c| (QREFELT $ 9)) (QREFELT $ 12))) 

(SDEFUN |CLAGG-;reduce;MAS;2| ((|f| (|Mapping| S S S)) (|x| (A)) ($ (S)))
        (SPADCALL |f| (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 15))) 

(SDEFUN |CLAGG-;reduce;MA2S;3|
        ((|f| (|Mapping| S S S)) (|x| (A)) (|s| (S)) ($ (S)))
        (SPADCALL |f| (SPADCALL |x| (QREFELT $ 9)) |s| (QREFELT $ 17))) 

(SDEFUN |CLAGG-;remove;M2A;4|
        ((|f| (|Mapping| (|Boolean|) S)) (|x| (A)) ($ (A)))
        (SPADCALL (SPADCALL |f| (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 19))
                  (QREFELT $ 20))) 

(SDEFUN |CLAGG-;select;M2A;5|
        ((|f| (|Mapping| (|Boolean|) S)) (|x| (A)) ($ (A)))
        (SPADCALL (SPADCALL |f| (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 22))
                  (QREFELT $ 20))) 

(SDEFUN |CLAGG-;remove;S2A;6| ((|s| (S)) (|x| (A)) ($ (A)))
        (SPROG NIL
               (SPADCALL (CONS #'|CLAGG-;remove;S2A;6!0| (VECTOR $ |s|)) |x|
                         (QREFELT $ 26)))) 

(SDEFUN |CLAGG-;remove;S2A;6!0| ((|y| NIL) ($$ NIL))
        (PROG (|s| $)
          (LETT |s| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |y| |s| (QREFELT $ 25)))))) 

(SDEFUN |CLAGG-;reduce;MA3S;7|
        ((|f| (|Mapping| S S S)) (|x| (A)) (|s1| (S)) (|s2| (S)) ($ (S)))
        (SPADCALL |f| (SPADCALL |x| (QREFELT $ 9)) |s1| |s2| (QREFELT $ 28))) 

(SDEFUN |CLAGG-;removeDuplicates;2A;8| ((|x| (A)) ($ (A)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 9)) (QREFELT $ 30))
                  (QREFELT $ 20))) 

(SDEFUN |CLAGG-;convert;AIf;9| ((|x| (A)) ($ (|InputForm|)))
        (SPROG
         ((|a_form| (|InputForm|)) (|l_form| (|List| (|InputForm|)))
          (|p_form| (|List| (|InputForm|))) (#1=#:G743 NIL) (|el| NIL)
          (#2=#:G742 NIL))
         (SEQ
          (LETT |p_form|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |el| NIL) (LETT #1# (SPADCALL |x| (QREFELT $ 9)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |el| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2# (CONS (SPADCALL |el| (QREFELT $ 33)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (LETT |l_form|
                (CONS (SPADCALL '|construct| (QREFELT $ 35)) |p_form|))
          (LETT |a_form| (SPADCALL |l_form| (QREFELT $ 37)))
          (EXIT (SPADCALL '|construct| (LIST |a_form|) (QREFELT $ 40)))))) 

(DECLAIM (NOTINLINE |Collection&;|)) 

(DEFUN |Collection&| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|Collection&| DV$1 DV$2))
          (LETT $ (GETREFV 42))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#2|
                                                             '(|ConvertibleTo|
                                                               (|InputForm|)))
                                              (|HasCategory| |#2|
                                                             '(|BasicType|))
                                              (|HasCategory| |#1|
                                                             '(|finiteAggregate|))))))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 3)
            (PROGN
             (QSETREFV $ 13 (CONS (|dispatchFunction| |CLAGG-;find;MAU;1|) $))
             (QSETREFV $ 16
                       (CONS (|dispatchFunction| |CLAGG-;reduce;MAS;2|) $))
             (QSETREFV $ 18
                       (CONS (|dispatchFunction| |CLAGG-;reduce;MA2S;3|) $))
             (QSETREFV $ 21
                       (CONS (|dispatchFunction| |CLAGG-;remove;M2A;4|) $))
             (QSETREFV $ 23
                       (CONS (|dispatchFunction| |CLAGG-;select;M2A;5|) $))
             (COND
              ((|testBitVector| |pv$| 2)
               (PROGN
                (QSETREFV $ 27
                          (CONS (|dispatchFunction| |CLAGG-;remove;S2A;6|) $))
                (QSETREFV $ 29
                          (CONS (|dispatchFunction| |CLAGG-;reduce;MA3S;7|) $))
                (QSETREFV $ 31
                          (CONS
                           (|dispatchFunction| |CLAGG-;removeDuplicates;2A;8|)
                           $)))))
             (COND
              ((|testBitVector| |pv$| 1)
               (QSETREFV $ 41
                         (CONS (|dispatchFunction| |CLAGG-;convert;AIf;9|)
                               $)))))))
          $))) 

(MAKEPROP '|Collection&| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|List| 7)
              (0 . |parts|) (|Union| 7 '"failed") (|Mapping| 24 7) (5 . |find|)
              (11 . |find|) (|Mapping| 7 7 7) (17 . |reduce|) (23 . |reduce|)
              (29 . |reduce|) (36 . |reduce|) (43 . |remove|)
              (49 . |construct|) (54 . |remove|) (60 . |select|)
              (66 . |select|) (|Boolean|) (72 . =) (78 . |remove|)
              (84 . |remove|) (90 . |reduce|) (98 . |reduce|)
              (106 . |removeDuplicates|) (111 . |removeDuplicates|)
              (|InputForm|) (116 . |convert|) (|Symbol|) (121 . |convert|)
              (|List| $) (126 . |convert|) (|List| 32)
              (|InputFormFunctions1| 6) (131 . |packageCall|)
              (137 . |convert|))
           '#(|select| 142 |removeDuplicates| 148 |remove| 153 |reduce| 165
              |find| 186 |convert| 192)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|convert| ((|InputForm|) |#1|)) T)
                                   '((|removeDuplicates| (|#1| |#1|)) T)
                                   '((|remove| (|#1| |#2| |#1|)) T)
                                   '((|reduce|
                                      (|#2| (|Mapping| |#2| |#2| |#2|) |#1|
                                       |#2| |#2|))
                                     T)
                                   '((|select|
                                      (|#1| (|Mapping| (|Boolean|) |#2|) |#1|))
                                     T)
                                   '((|remove|
                                      (|#1| (|Mapping| (|Boolean|) |#2|) |#1|))
                                     T)
                                   '((|reduce|
                                      (|#2| (|Mapping| |#2| |#2| |#2|) |#1|
                                       |#2|))
                                     T)
                                   '((|reduce|
                                      (|#2| (|Mapping| |#2| |#2| |#2|) |#1|))
                                     T)
                                   '((|find|
                                      ((|Union| |#2| "failed")
                                       (|Mapping| (|Boolean|) |#2|) |#1|))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 41
                                            '(1 6 8 0 9 2 8 10 11 0 12 2 0 10
                                              11 0 13 2 8 7 14 0 15 2 0 7 14 0
                                              16 3 8 7 14 0 7 17 3 0 7 14 0 7
                                              18 2 8 0 11 0 19 1 6 0 8 20 2 0 0
                                              11 0 21 2 8 0 11 0 22 2 0 0 11 0
                                              23 2 7 24 0 0 25 2 6 0 11 0 26 2
                                              0 0 7 0 27 4 8 7 14 0 7 7 28 4 0
                                              7 14 0 7 7 29 1 8 0 0 30 1 0 0 0
                                              31 1 7 32 0 33 1 32 0 34 35 1 32
                                              0 36 37 2 39 32 34 38 40 1 0 32 0
                                              41 2 0 0 11 0 23 1 0 0 0 31 2 0 0
                                              7 0 27 2 0 0 11 0 21 4 0 7 14 0 7
                                              7 29 3 0 7 14 0 7 18 2 0 7 14 0
                                              16 2 0 10 11 0 13 1 0 32 0
                                              41)))))
           '|lookupComplete|)) 
