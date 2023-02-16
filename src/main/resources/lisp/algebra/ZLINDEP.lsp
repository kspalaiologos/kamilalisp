
(SDEFUN |ZLINDEP;linearlyDependentOverZ?;VB;1|
        ((|v| (|Vector| R)) ($ (|Boolean|))) (SPADCALL |v| (QREFELT $ 10))) 

(SDEFUN |ZLINDEP;linearDependenceOverZ;VU;2|
        ((|v| (|Vector| R)) ($ (|Union| (|Vector| (|Integer|)) "failed")))
        (SPADCALL |v| (QREFELT $ 13))) 

(SDEFUN |ZLINDEP;particularSolutionOverQ;VRU;3|
        ((|v| (|Vector| R)) (|c| (R))
         ($ (|Union| (|Vector| (|Fraction| (|Integer|))) "failed")))
        (SPADCALL |v| |c| (QREFELT $ 16))) 

(SDEFUN |ZLINDEP;particularSolutionOverQ;MVU;4|
        ((|m| (|Matrix| R)) (|v| (|Vector| R))
         ($ (|Union| (|Vector| (|Fraction| (|Integer|))) "failed")))
        (SPADCALL |m| |v| (QREFELT $ 19))) 

(SDEFUN |ZLINDEP;solveLinearlyOverQ;VRR;5|
        ((|v| (|Vector| R)) (|c| (R))
         ($
          (|Record|
           (|:| |particular|
                (|Union| (|Vector| (|Fraction| (|Integer|))) "failed"))
           (|:| |basis| (|List| (|Vector| (|Fraction| (|Integer|))))))))
        (SPADCALL |v| |c| (QREFELT $ 22))) 

(SDEFUN |ZLINDEP;solveLinearlyOverQ;MVR;6|
        ((|m| (|Matrix| R)) (|v| (|Vector| R))
         ($
          (|Record|
           (|:| |particular|
                (|Union| (|Vector| (|Fraction| (|Integer|))) "failed"))
           (|:| |basis| (|List| (|Vector| (|Fraction| (|Integer|))))))))
        (SPADCALL |m| |v| (QREFELT $ 24))) 

(DECLAIM (NOTINLINE |IntegerLinearDependence;|)) 

(DEFUN |IntegerLinearDependence| (#1=#:G718)
  (SPROG NIL
         (PROG (#2=#:G719)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|IntegerLinearDependence|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|IntegerLinearDependence;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|IntegerLinearDependence|)))))))))) 

(DEFUN |IntegerLinearDependence;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|IntegerLinearDependence| DV$1))
          (LETT $ (GETREFV 26))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|IntegerLinearDependence|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|IntegerLinearDependence| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Boolean|) (|Vector| 6)
              (|LinearDependence| (|Integer|) 6) (0 . |linearlyDependent?|)
              |ZLINDEP;linearlyDependentOverZ?;VB;1|
              (|Union| (|Vector| (|Integer|)) '"failed")
              (5 . |linearDependence|) |ZLINDEP;linearDependenceOverZ;VU;2|
              (|Union| (|Vector| (|Fraction| (|Integer|))) '"failed")
              (10 . |particularSolution|)
              |ZLINDEP;particularSolutionOverQ;VRU;3| (|Matrix| 6)
              (16 . |particularSolution|)
              |ZLINDEP;particularSolutionOverQ;MVU;4|
              (|Record| (|:| |particular| 15)
                        (|:| |basis|
                             (|List| (|Vector| (|Fraction| (|Integer|))))))
              (22 . |solveLinear|) |ZLINDEP;solveLinearlyOverQ;VRR;5|
              (28 . |solveLinear|) |ZLINDEP;solveLinearlyOverQ;MVR;6|)
           '#(|solveLinearlyOverQ| 34 |particularSolutionOverQ| 46
              |linearlyDependentOverZ?| 58 |linearDependenceOverZ| 63)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|linearlyDependentOverZ?|
                                 ((|Boolean|) (|Vector| |#1|)))
                                T)
                              '((|linearDependenceOverZ|
                                 ((|Union| (|Vector| (|Integer|)) "failed")
                                  (|Vector| |#1|)))
                                T)
                              '((|particularSolutionOverQ|
                                 ((|Union| (|Vector| (|Fraction| (|Integer|)))
                                           #1="failed")
                                  (|Vector| |#1|) |#1|))
                                T)
                              '((|particularSolutionOverQ|
                                 ((|Union| (|Vector| (|Fraction| (|Integer|)))
                                           #1#)
                                  (|Matrix| |#1|) (|Vector| |#1|)))
                                T)
                              '((|solveLinearlyOverQ|
                                 ((|Record|
                                   (|:| |particular|
                                        (|Union|
                                         (|Vector| (|Fraction| (|Integer|)))
                                         #1#))
                                   (|:| |basis|
                                        (|List|
                                         (|Vector| (|Fraction| (|Integer|))))))
                                  (|Vector| |#1|) |#1|))
                                T)
                              '((|solveLinearlyOverQ|
                                 ((|Record|
                                   (|:| |particular|
                                        (|Union|
                                         (|Vector| (|Fraction| (|Integer|)))
                                         #1#))
                                   (|:| |basis|
                                        (|List|
                                         (|Vector| (|Fraction| (|Integer|))))))
                                  (|Matrix| |#1|) (|Vector| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 25
                                            '(1 9 7 8 10 1 9 12 8 13 2 9 15 8 6
                                              16 2 9 15 18 8 19 2 9 21 8 6 22 2
                                              9 21 18 8 24 2 0 21 18 8 25 2 0
                                              21 8 6 23 2 0 15 8 6 17 2 0 15 18
                                              8 20 1 0 7 8 11 1 0 12 8 14)))))
           '|lookupComplete|)) 
