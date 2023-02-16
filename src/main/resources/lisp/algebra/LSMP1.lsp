
(SDEFUN |LSMP1;solve;MVR;1|
        ((|m| (|Matrix| F)) (|c| (|Vector| F))
         ($
          (|Record| (|:| |particular| (|Union| (|Vector| F) "failed"))
                    (|:| |basis| (|List| (|Vector| F))))))
        (SPADCALL |m| |c| (QREFELT $ 12))) 

(SDEFUN |LSMP1;solve;LVR;2|
        ((|ll| (|List| (|List| F))) (|c| (|Vector| F))
         ($
          (|Record| (|:| |particular| (|Union| (|Vector| F) "failed"))
                    (|:| |basis| (|List| (|Vector| F))))))
        (SPADCALL (SPADCALL |ll| (QREFELT $ 15)) |c| (QREFELT $ 12))) 

(SDEFUN |LSMP1;solve;MLL;3|
        ((|m| (|Matrix| F)) (|l| (|List| (|Vector| F)))
         ($
          (|List|
           (|Record| (|:| |particular| (|Union| (|Vector| F) "failed"))
                     (|:| |basis| (|List| (|Vector| F)))))))
        (SPADCALL |m| |l| (QREFELT $ 19))) 

(SDEFUN |LSMP1;solve;LLL;4|
        ((|ll| (|List| (|List| F))) (|l| (|List| (|Vector| F)))
         ($
          (|List|
           (|Record| (|:| |particular| (|Union| (|Vector| F) "failed"))
                     (|:| |basis| (|List| (|Vector| F)))))))
        (SPADCALL (SPADCALL |ll| (QREFELT $ 15)) |l| (QREFELT $ 19))) 

(SDEFUN |LSMP1;particularSolution;MVU;5|
        ((|m| (|Matrix| F)) (|c| (|Vector| F))
         ($ (|Union| (|Vector| F) "failed")))
        (SPADCALL |m| |c| (QREFELT $ 22))) 

(SDEFUN |LSMP1;hasSolution?;MVB;6|
        ((|m| (|Matrix| F)) (|c| (|Vector| F)) ($ (|Boolean|)))
        (SPADCALL |m| |c| (QREFELT $ 25))) 

(SDEFUN |LSMP1;rank;MVNni;7|
        ((|m| (|Matrix| F)) (|c| (|Vector| F)) ($ (|NonNegativeInteger|)))
        (SPADCALL |m| |c| (QREFELT $ 28))) 

(DECLAIM (NOTINLINE |LinearSystemMatrixPackage1;|)) 

(DEFUN |LinearSystemMatrixPackage1| (#1=#:G714)
  (SPROG NIL
         (PROG (#2=#:G715)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|LinearSystemMatrixPackage1|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|LinearSystemMatrixPackage1;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|LinearSystemMatrixPackage1|)))))))))) 

(DEFUN |LinearSystemMatrixPackage1;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|LinearSystemMatrixPackage1| DV$1))
          (LETT $ (GETREFV 30))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|LinearSystemMatrixPackage1|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|LinearSystemMatrixPackage1| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Union| 10 '"failed")
              (|Record| (|:| |particular| 7) (|:| |basis| 18)) (|Matrix| 6)
              (|Vector| 6) (|LinearSystemMatrixPackage| 6 10 10 9)
              (0 . |solve|) |LSMP1;solve;MVR;1| (|List| (|List| 6))
              (6 . |matrix|) |LSMP1;solve;LVR;2| (|List| 8) (|List| 10)
              (11 . |solve|) |LSMP1;solve;MLL;3| |LSMP1;solve;LLL;4|
              (17 . |particularSolution|) |LSMP1;particularSolution;MVU;5|
              (|Boolean|) (23 . |hasSolution?|) |LSMP1;hasSolution?;MVB;6|
              (|NonNegativeInteger|) (29 . |rank|) |LSMP1;rank;MVNni;7|)
           '#(|solve| 35 |rank| 59 |particularSolution| 65 |hasSolution?| 71)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|solve|
                                 ((|Record|
                                   (|:| |particular|
                                        (|Union| (|Vector| |#1|) #1="failed"))
                                   (|:| |basis| (|List| (|Vector| |#1|))))
                                  (|Matrix| |#1|) (|Vector| |#1|)))
                                T)
                              '((|solve|
                                 ((|Record|
                                   (|:| |particular|
                                        (|Union| (|Vector| |#1|) #1#))
                                   (|:| |basis| (|List| (|Vector| |#1|))))
                                  (|List| (|List| |#1|)) (|Vector| |#1|)))
                                T)
                              '((|solve|
                                 ((|List|
                                   (|Record|
                                    (|:| |particular|
                                         (|Union| (|Vector| |#1|) #1#))
                                    (|:| |basis| (|List| (|Vector| |#1|)))))
                                  (|Matrix| |#1|) (|List| (|Vector| |#1|))))
                                T)
                              '((|solve|
                                 ((|List|
                                   (|Record|
                                    (|:| |particular|
                                         (|Union| (|Vector| |#1|) #1#))
                                    (|:| |basis| (|List| (|Vector| |#1|)))))
                                  (|List| (|List| |#1|))
                                  (|List| (|Vector| |#1|))))
                                T)
                              '((|particularSolution|
                                 ((|Union| (|Vector| |#1|) #1#) (|Matrix| |#1|)
                                  (|Vector| |#1|)))
                                T)
                              '((|hasSolution?|
                                 ((|Boolean|) (|Matrix| |#1|) (|Vector| |#1|)))
                                T)
                              '((|rank|
                                 ((|NonNegativeInteger|) (|Matrix| |#1|)
                                  (|Vector| |#1|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 29
                                            '(2 11 8 9 10 12 1 9 0 14 15 2 11
                                              17 9 18 19 2 11 7 9 10 22 2 11 24
                                              9 10 25 2 11 27 9 10 28 2 0 8 9
                                              10 13 2 0 17 9 18 20 2 0 8 14 10
                                              16 2 0 17 14 18 21 2 0 27 9 10 29
                                              2 0 7 9 10 23 2 0 24 9 10 26)))))
           '|lookupComplete|)) 
