
(PUT '|MKCHSET;position;$Nni;1| '|SPADreplace| 'QCDR) 

(SDEFUN |MKCHSET;position;$Nni;1| ((|x| ($)) ($ (|NonNegativeInteger|)))
        (QCDR |x|)) 

(SDEFUN |MKCHSET;setPosition;$NniV;2|
        ((|x| ($)) (|n| (|NonNegativeInteger|)) ($ (|Void|)))
        (SEQ (PROGN (RPLACD |x| |n|) (QCDR |x|))
             (EXIT (SPADCALL (QREFELT $ 13))))) 

(PUT '|MKCHSET;coerce;$S;3| '|SPADreplace| 'QCAR) 

(SDEFUN |MKCHSET;coerce;$S;3| ((|x| ($)) ($ (S))) (QCAR |x|)) 

(SDEFUN |MKCHSET;coerce;$Of;4| ((|x| ($)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 15)) (QREFELT $ 17))) 

(SDEFUN |MKCHSET;coerce;S$;5| ((|s| (S)) ($ ($)))
        (SPROG NIL
               (SPADCALL (CONS |s| 0)
                         (CONS #'|MKCHSET;coerce;S$;5!0| (VECTOR $ |s|))
                         (QREFELT $ 22)))) 

(SDEFUN |MKCHSET;coerce;S$;5!0| ((|x1| NIL) ($$ NIL))
        (PROG (|s| $)
          (LETT |s| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |s| (SPADCALL |x1| (QREFELT $ 15)) (QREFELT $ 20)))))) 

(SDEFUN |MKCHSET;=;2$B;6| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (SPROG NIL
               (SEQ
                (COND
                 ((EQL (SPADCALL |x| (QREFELT $ 12)) 0)
                  (LETT |x|
                        (SPADCALL |x|
                                  (CONS #'|MKCHSET;=;2$B;6!0| (VECTOR $ |x|))
                                  (QREFELT $ 22)))))
                (COND
                 ((EQL (SPADCALL |y| (QREFELT $ 12)) 0)
                  (LETT |y|
                        (SPADCALL |y|
                                  (CONS #'|MKCHSET;=;2$B;6!1| (VECTOR $ |y|))
                                  (QREFELT $ 22)))))
                (EXIT
                 (EQL (SPADCALL |x| (QREFELT $ 12))
                      (SPADCALL |y| (QREFELT $ 12))))))) 

(SDEFUN |MKCHSET;=;2$B;6!1| ((|x1| NIL) ($$ NIL))
        (PROG (|y| $)
          (LETT |y| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |y| (QREFELT $ 15))
                      (SPADCALL |x1| (QREFELT $ 15)) (QREFELT $ 20)))))) 

(SDEFUN |MKCHSET;=;2$B;6!0| ((|x1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| (QREFELT $ 15))
                      (SPADCALL |x1| (QREFELT $ 15)) (QREFELT $ 20)))))) 

(DECLAIM (NOTINLINE |MakeCachableSet;|)) 

(DEFUN |MakeCachableSet| (#1=#:G716)
  (SPROG NIL
         (PROG (#2=#:G717)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|MakeCachableSet|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|MakeCachableSet;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|MakeCachableSet|)))))))))) 

(DEFUN |MakeCachableSet;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|MakeCachableSet| DV$1))
          (LETT $ (GETREFV 28))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|MakeCachableSet| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record| (|:| |setpart| |#1|)
                              (|:| |pos| (|NonNegativeInteger|))))
          (SPADCALL (QREFELT $ 10))
          $))) 

(MAKEPROP '|MakeCachableSet| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|Void|)
              (|SortedCache| $$) (0 . |clearCache|) (|NonNegativeInteger|)
              |MKCHSET;position;$Nni;1| (4 . |void|)
              |MKCHSET;setPosition;$NniV;2| |MKCHSET;coerce;$S;3|
              (|OutputForm|) (8 . |coerce|) |MKCHSET;coerce;$Of;4| (|Boolean|)
              (13 . =) (|Mapping| 19 $$) (19 . |enterInCache|)
              |MKCHSET;coerce;S$;5| |MKCHSET;=;2$B;6| (|String|)
              (|SingleInteger|) (|HashState|))
           '#(~= 25 |setPosition| 31 |position| 37 |latex| 42 |hashUpdate!| 47
              |hash| 53 |coerce| 58 = 73)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0 0 0 0 0))
                 (CONS '#(NIL |SetCategory&| |BasicType&| NIL NIL)
                       (CONS
                        '#((|CachableSet|) (|SetCategory|) (|BasicType|)
                           (|CoercibleTo| 6) (|CoercibleTo| 16))
                        (|makeByteWordVec2| 27
                                            '(0 9 8 10 0 8 0 13 1 6 16 0 17 2 6
                                              19 0 0 20 2 9 2 2 21 22 2 0 19 0
                                              0 1 2 0 8 0 11 14 1 0 11 0 12 1 0
                                              25 0 1 2 0 27 27 0 1 1 0 26 0 1 1
                                              0 6 0 15 1 0 0 6 23 1 0 16 0 18 2
                                              0 19 0 0 24)))))
           '|lookupComplete|)) 
