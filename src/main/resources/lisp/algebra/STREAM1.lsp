
(SDEFUN |STREAM1;concat;SS;1| ((|z| (|Stream| (|Stream| S))) ($ (|Stream| S)))
        (SPROG NIL
               (SPADCALL (CONS #'|STREAM1;concat;SS;1!0| (VECTOR $ |z|))
                         (QREFELT $ 21)))) 

(SDEFUN |STREAM1;concat;SS;1!0| (($$ NIL))
        (PROG (|z| $)
          (LETT |z| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|x| NIL))
                   (COND
                    ((SPADCALL |z| (QREFELT $ 9)) (SPADCALL (QREFELT $ 11)))
                    ((SPADCALL (LETT |x| (SPADCALL |z| (QREFELT $ 12)))
                               (QREFELT $ 13))
                     (SPADCALL (SPADCALL |z| (QREFELT $ 14)) (QREFELT $ 15)))
                    ('T
                     (SPADCALL (SPADCALL |x| (QREFELT $ 16))
                               (SPADCALL (SPADCALL |x| (QREFELT $ 17))
                                         (SPADCALL
                                          (SPADCALL |z| (QREFELT $ 14))
                                          (QREFELT $ 15))
                                         (QREFELT $ 18))
                               (QREFELT $ 19))))))))) 

(DECLAIM (NOTINLINE |StreamFunctions1;|)) 

(DEFUN |StreamFunctions1| (#1=#:G699)
  (SPROG NIL
         (PROG (#2=#:G700)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|StreamFunctions1|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|StreamFunctions1;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|StreamFunctions1|)))))))))) 

(DEFUN |StreamFunctions1;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|StreamFunctions1| DV$1))
          (LETT $ (GETREFV 22))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|StreamFunctions1| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|StreamFunctions1| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Boolean|) (|Stream| 10)
              (0 . |empty?|) (|Stream| 6) (5 . |empty|) (9 . |frst|)
              (14 . |empty?|) (19 . |rst|) |STREAM1;concat;SS;1| (24 . |frst|)
              (29 . |rst|) (34 . |concat|) (40 . |concat|) (|Mapping| $)
              (46 . |delay|))
           '#(|concat| 51) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|concat|
                                 ((|Stream| |#1|) (|Stream| (|Stream| |#1|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 21
                                            '(1 8 7 0 9 0 10 0 11 1 8 10 0 12 1
                                              10 7 0 13 1 8 0 0 14 1 10 6 0 16
                                              1 10 0 0 17 2 10 0 0 0 18 2 10 0
                                              6 0 19 1 10 0 20 21 1 0 10 8
                                              15)))))
           '|lookupComplete|)) 
