
(PUT '|SEGBIND;equation;SS$;1| '|SPADreplace| 'CONS) 

(SDEFUN |SEGBIND;equation;SS$;1| ((|x| (|Symbol|)) (|s| (|Segment| S)) ($ ($)))
        (CONS |x| |s|)) 

(PUT '|SEGBIND;variable;$S;2| '|SPADreplace| 'QCAR) 

(SDEFUN |SEGBIND;variable;$S;2| ((|b| ($)) ($ (|Symbol|))) (QCAR |b|)) 

(PUT '|SEGBIND;segment;$S;3| '|SPADreplace| 'QCDR) 

(SDEFUN |SEGBIND;segment;$S;3| ((|b| ($)) ($ (|Segment| S))) (QCDR |b|)) 

(SDEFUN |SEGBIND;=;2$B;4| ((|b1| ($)) (|b2| ($)) ($ (|Boolean|)))
        (COND
         ((EQUAL (SPADCALL |b1| (QREFELT $ 11)) (SPADCALL |b2| (QREFELT $ 11)))
          (SPADCALL (SPADCALL |b1| (QREFELT $ 12))
                    (SPADCALL |b2| (QREFELT $ 12)) (QREFELT $ 14)))
         ('T NIL))) 

(SDEFUN |SEGBIND;coerce;$Of;5| ((|b| ($)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL (SPADCALL |b| (QREFELT $ 11)) (QREFELT $ 17))
                  (SPADCALL (SPADCALL |b| (QREFELT $ 12)) (QREFELT $ 18))
                  (QREFELT $ 19))) 

(SDEFUN |SEGBIND;convert;$If;6| ((|b| ($)) ($ (|InputForm|)))
        (SPADCALL '|equation|
                  (LIST (SPADCALL (SPADCALL |b| (QREFELT $ 11)) (QREFELT $ 22))
                        (SPADCALL (SPADCALL |b| (QREFELT $ 12))
                                  (QREFELT $ 23)))
                  (QREFELT $ 26))) 

(DECLAIM (NOTINLINE |SegmentBinding;|)) 

(DEFUN |SegmentBinding| (#1=#:G718)
  (SPROG NIL
         (PROG (#2=#:G719)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|SegmentBinding|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|SegmentBinding;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|SegmentBinding|)))))))))) 

(DEFUN |SegmentBinding;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|SegmentBinding| DV$1))
          (LETT $ (GETREFV 31))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|ConvertibleTo|
                                                               (|InputForm|)))
                                              (|HasCategory| |#1|
                                                             '(|SetCategory|))))))
          (|haddProp| |$ConstructorCache| '|SegmentBinding| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7
                    (|Record| (|:| |var| (|Symbol|))
                              (|:| |seg| (|Segment| |#1|))))
          (COND
           ((|testBitVector| |pv$| 2)
            (PROGN
             (QSETREFV $ 15 (CONS (|dispatchFunction| |SEGBIND;=;2$B;4|) $))
             (QSETREFV $ 20
                       (CONS (|dispatchFunction| |SEGBIND;coerce;$Of;5|) $)))))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 27
                       (CONS (|dispatchFunction| |SEGBIND;convert;$If;6|)
                             $)))))
          $))) 

(MAKEPROP '|SegmentBinding| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|Symbol|)
              (|Segment| 6) |SEGBIND;equation;SS$;1| |SEGBIND;variable;$S;2|
              |SEGBIND;segment;$S;3| (|Boolean|) (0 . =) (6 . =) (|OutputForm|)
              (12 . |coerce|) (17 . |coerce|) (22 . =) (28 . |coerce|)
              (|InputForm|) (33 . |convert|) (38 . |convert|) (|List| 21)
              (|InputFormFunctions1| $$) (43 . |packageCall|) (49 . |convert|)
              (|String|) (|SingleInteger|) (|HashState|))
           '#(~= 54 |variable| 60 |segment| 65 |latex| 70 |hashUpdate!| 75
              |hash| 81 |equation| 86 |convert| 92 |coerce| 97 = 102)
           'NIL
           (CONS (|makeByteWordVec2| 2 '(2 0 1 2 2))
                 (CONS '#(|SetCategory&| NIL NIL |BasicType&| NIL)
                       (CONS
                        '#((|SetCategory|) (|Type|) (|ConvertibleTo| 21)
                           (|BasicType|) (|CoercibleTo| 16))
                        (|makeByteWordVec2| 30
                                            '(2 9 13 0 0 14 2 0 13 0 0 15 1 8
                                              16 0 17 1 9 16 0 18 2 16 0 0 0 19
                                              1 0 16 0 20 1 21 0 8 22 1 9 21 0
                                              23 2 25 21 8 24 26 1 0 21 0 27 2
                                              2 13 0 0 1 1 0 8 0 11 1 0 9 0 12
                                              1 2 28 0 1 2 2 30 30 0 1 1 2 29 0
                                              1 2 0 0 8 9 10 1 1 21 0 27 1 2 16
                                              0 20 2 2 13 0 0 15)))))
           '|lookupComplete|)) 
