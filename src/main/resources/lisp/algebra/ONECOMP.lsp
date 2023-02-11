
(SDEFUN |ONECOMP;convert;$If;1| ((|x| ($)) ($ (|InputForm|)))
        (COND ((QEQCAR |x| 0) (SPADCALL (QCDR |x|) (QREFELT $ 9)))
              ('T
               (SPADCALL (LIST (SPADCALL '|infinity| (QREFELT $ 11)))
                         (QREFELT $ 13))))) 

(PUT '|ONECOMP;coerce;R$;2| '|SPADreplace| '(XLAM (|r|) (CONS 0 |r|))) 

(SDEFUN |ONECOMP;coerce;R$;2| ((|r| (R)) ($ ($))) (CONS 0 |r|)) 

(SDEFUN |ONECOMP;retract;$R;3| ((|x| ($)) ($ (R)))
        (COND ((QEQCAR |x| 0) (QCDR |x|)) ('T (|error| "Not finite")))) 

(PUT '|ONECOMP;finite?;$B;4| '|SPADreplace| '(XLAM (|x|) (QEQCAR |x| 0))) 

(SDEFUN |ONECOMP;finite?;$B;4| ((|x| ($)) ($ (|Boolean|))) (QEQCAR |x| 0)) 

(PUT '|ONECOMP;infinite?;$B;5| '|SPADreplace| '(XLAM (|x|) (QEQCAR |x| 1))) 

(SDEFUN |ONECOMP;infinite?;$B;5| ((|x| ($)) ($ (|Boolean|))) (QEQCAR |x| 1)) 

(PUT '|ONECOMP;infinity;$;6| '|SPADreplace| '(XLAM NIL (CONS 1 "infinity"))) 

(SDEFUN |ONECOMP;infinity;$;6| (($ ($))) (CONS 1 "infinity")) 

(SDEFUN |ONECOMP;retractIfCan;$U;7| ((|x| ($)) ($ (|Union| R "failed")))
        (COND ((QEQCAR |x| 0) (CONS 0 (QCDR |x|))) ('T (CONS 1 "failed")))) 

(SDEFUN |ONECOMP;coerce;$Of;8| ((|x| ($)) ($ (|OutputForm|)))
        (COND ((QEQCAR |x| 1) (SPADCALL '|infinity| (QREFELT $ 24)))
              ('T (SPADCALL (QCDR |x|) (QREFELT $ 25))))) 

(SDEFUN |ONECOMP;=;2$B;9| ((|x| ($)) (|y| ($)) ($ (|Boolean|)))
        (COND ((QEQCAR |x| 1) (QEQCAR |y| 1)) ((QEQCAR |y| 1) NIL)
              ('T (SPADCALL (QCDR |x|) (QCDR |y|) (QREFELT $ 27))))) 

(SDEFUN |ONECOMP;rational?;$B;10| ((|x| ($)) ($ (|Boolean|)))
        (SPADCALL |x| (QREFELT $ 18))) 

(SDEFUN |ONECOMP;rational;$F;11| ((|x| ($)) ($ (|Fraction| (|Integer|))))
        (SPADCALL (CONS 0 (SPADCALL |x| (QREFELT $ 16))) (QREFELT $ 31))) 

(SDEFUN |ONECOMP;rationalIfCan;$U;12|
        ((|x| ($)) ($ (|Union| (|Fraction| (|Integer|)) "failed")))
        (SPROG ((|r| (|Union| R "failed")))
               (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 22)))
                    (EXIT
                     (COND ((QEQCAR |r| 1) (CONS 1 "failed"))
                           ('T
                            (CONS 0 (SPADCALL (QCDR |r|) (QREFELT $ 32))))))))) 

(DECLAIM (NOTINLINE |OnePointCompletion;|)) 

(DEFUN |OnePointCompletion| (#1=#:G747)
  (SPROG NIL
         (PROG (#2=#:G748)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|OnePointCompletion|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|OnePointCompletion;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|OnePointCompletion|)))))))))) 

(DEFUN |OnePointCompletion;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|OnePointCompletion| DV$1))
          (LETT $ (GETREFV 40))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|RetractableTo|
                                                               (|Fraction|
                                                                (|Integer|))))
                                              (|HasCategory| |#1|
                                                             '(|RetractableTo|
                                                               (|Integer|)))
                                              (|HasCategory| |#1|
                                                             '(|ConvertibleTo|
                                                               (|InputForm|)))
                                              (|HasCategory| |#1|
                                                             '(|IntegerNumberSystem|))))))
          (|haddProp| |$ConstructorCache| '|OnePointCompletion| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 7 (|Union| |#1| "infinity"))
          (COND
           ((|testBitVector| |pv$| 3)
            (QSETREFV $ 14
                      (CONS (|dispatchFunction| |ONECOMP;convert;$If;1|) $))))
          (COND
           ((|testBitVector| |pv$| 4)
            (PROGN
             (QSETREFV $ 29
                       (CONS (|dispatchFunction| |ONECOMP;rational?;$B;10|) $))
             (QSETREFV $ 31
                       (CONS (|dispatchFunction| |ONECOMP;rational;$F;11|) $))
             (QSETREFV $ 34
                       (CONS (|dispatchFunction| |ONECOMP;rationalIfCan;$U;12|)
                             $)))))
          $))) 

(MAKEPROP '|OnePointCompletion| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) '|Rep| (|InputForm|)
              (0 . |convert|) (|Symbol|) (5 . |convert|) (|List| $)
              (10 . |convert|) (15 . |convert|) |ONECOMP;coerce;R$;2|
              |ONECOMP;retract;$R;3| (|Boolean|) |ONECOMP;finite?;$B;4|
              |ONECOMP;infinite?;$B;5| |ONECOMP;infinity;$;6|
              (|Union| 6 '"failed") |ONECOMP;retractIfCan;$U;7| (|OutputForm|)
              (20 . |coerce|) (25 . |coerce|) |ONECOMP;coerce;$Of;8| (30 . =)
              |ONECOMP;=;2$B;9| (36 . |rational?|) (|Fraction| 35)
              (41 . |rational|) (46 . |rational|) (|Union| 30 '"failed")
              (51 . |rationalIfCan|) (|Integer|) (|Union| 35 '"failed")
              (|String|) (|SingleInteger|) (|HashState|))
           '#(~= 56 |retractIfCan| 62 |retract| 77 |rationalIfCan| 92
              |rational?| 97 |rational| 102 |latex| 107 |infinity| 112
              |infinite?| 116 |hashUpdate!| 121 |hash| 127 |finite?| 132
              |convert| 137 |coerce| 142 = 162)
           'NIL
           (CONS (|makeByteWordVec2| 3 '(0 0 0 1 2 0 0 0 1 2 3))
                 (CONS
                  '#(|FullyRetractableTo&| |SetCategory&| |RetractableTo&|
                     |RetractableTo&| |RetractableTo&| |BasicType&| NIL NIL NIL
                     NIL NIL)
                  (CONS
                   '#((|FullyRetractableTo| 6) (|SetCategory|)
                      (|RetractableTo| 6) (|RetractableTo| 30)
                      (|RetractableTo| 35) (|BasicType|) (|CoercibleFrom| 6)
                      (|CoercibleTo| 23) (|CoercibleFrom| 30)
                      (|CoercibleFrom| 35) (|ConvertibleTo| 8))
                   (|makeByteWordVec2| 39
                                       '(1 6 8 0 9 1 8 0 10 11 1 8 0 12 13 1 0
                                         8 0 14 1 10 23 0 24 1 6 23 0 25 2 6 17
                                         0 0 27 1 0 17 0 29 1 0 30 0 31 1 6 30
                                         0 32 1 0 33 0 34 2 0 17 0 0 1 1 1 33 0
                                         1 1 2 36 0 1 1 0 21 0 22 1 1 30 0 1 1
                                         2 35 0 1 1 0 6 0 16 1 4 33 0 34 1 4 17
                                         0 29 1 4 30 0 31 1 0 37 0 1 0 0 0 20 1
                                         0 17 0 19 2 0 39 39 0 1 1 0 38 0 1 1 0
                                         17 0 18 1 3 8 0 14 1 1 0 30 1 1 2 0 35
                                         1 1 0 0 6 15 1 0 23 0 26 2 0 17 0 0
                                         28)))))
           '|lookupComplete|)) 
