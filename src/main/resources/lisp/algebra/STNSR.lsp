
(SDEFUN |STNSR;tensorMap;SMS;1|
        ((|s| (|Stream| R)) (|f| (|Mapping| (|List| R) R)) ($ (|Stream| R)))
        (SPROG NIL
               (COND ((SPADCALL |s| (QREFELT $ 9)) (SPADCALL (QREFELT $ 10)))
                     ('T
                      (SPADCALL
                       (SPADCALL (SPADCALL (SPADCALL |s| (QREFELT $ 11)) |f|)
                                 (QREFELT $ 13))
                       (SPADCALL
                        (CONS #'|STNSR;tensorMap;SMS;1!0| (VECTOR |f| $ |s|))
                        (QREFELT $ 18))
                       (QREFELT $ 19)))))) 

(SDEFUN |STNSR;tensorMap;SMS;1!0| (($$ NIL))
        (PROG (|s| $ |f|)
          (LETT |s| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |s| (QREFELT $ 14)) |f| (QREFELT $ 16)))))) 

(DECLAIM (NOTINLINE |StreamTensor;|)) 

(DEFUN |StreamTensor| (#1=#:G702)
  (SPROG NIL
         (PROG (#2=#:G703)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|StreamTensor|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|StreamTensor;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|StreamTensor|)))))))))) 

(DEFUN |StreamTensor;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|StreamTensor| DV$1))
          (LETT $ (GETREFV 20))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|StreamTensor| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|StreamTensor| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Boolean|) (|Stream| 6)
              (0 . |empty?|) (5 . |empty|) (9 . |first|) (|List| 6)
              (14 . |construct|) (19 . |rest|) (|Mapping| 12 6)
              |STNSR;tensorMap;SMS;1| (|Mapping| $) (24 . |delay|)
              (29 . |concat|))
           '#(|tensorMap| 35) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|tensorMap|
                                 ((|Stream| |#1|) (|Stream| |#1|)
                                  (|Mapping| (|List| |#1|) |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 19
                                            '(1 8 7 0 9 0 8 0 10 1 8 6 0 11 1 8
                                              0 12 13 1 8 0 0 14 1 8 0 17 18 2
                                              8 0 0 0 19 2 0 8 8 15 16)))))
           '|lookupComplete|)) 
