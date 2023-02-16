
(SDEFUN |LINDEP;aNonZeroSolution|
        ((|m| (|Matrix| S)) ($ (|Union| (|Vector| S) "failed")))
        (SPROG ((|ns| (|List| (|Vector| S))))
               (COND
                ((NULL (LETT |ns| (SPADCALL |m| (QREFELT $ 10))))
                 (CONS 1 "failed"))
                ('T (CONS 0 (|SPADfirst| |ns|)))))) 

(SDEFUN |LINDEP;linearlyDependent?;VB;2| ((|v| (|Vector| R)) ($ (|Boolean|)))
        (SPROG ((|n| (|NonNegativeInteger|)))
               (COND ((ZEROP (LETT |n| (QVSIZE |v|))) 'T)
                     ((EQL |n| 1)
                      (SPADCALL
                       (SPADCALL |v| (SPADCALL |v| (QREFELT $ 15))
                                 (QREFELT $ 16))
                       (QREFELT $ 18)))
                     ('T
                      (PLUSP
                       (SPADCALL
                        (SPADCALL (SPADCALL |v| (QREFELT $ 20)) (QREFELT $ 22))
                        (QREFELT $ 24))))))) 

(SDEFUN |LINDEP;linearDependence;VU;3|
        ((|v| (|Vector| R)) ($ (|Union| (|Vector| S) "failed")))
        (SPROG ((|n| (|NonNegativeInteger|)))
               (COND ((ZEROP (LETT |n| (QVSIZE |v|))) (CONS 0 (MAKE-ARRAY 0)))
                     ((EQL |n| 1)
                      (COND
                       ((SPADCALL
                         (SPADCALL |v| (SPADCALL |v| (QREFELT $ 15))
                                   (QREFELT $ 16))
                         (QREFELT $ 18))
                        (CONS 0 (MAKEARR1 1 (|spadConstant| $ 11))))
                       (#1='T (CONS 1 "failed"))))
                     (#1#
                      (|LINDEP;aNonZeroSolution|
                       (SPADCALL (SPADCALL |v| (QREFELT $ 20)) (QREFELT $ 22))
                       $))))) 

(SDEFUN |LINDEP;solveLinear;VRR;4|
        ((|v| (|Vector| R)) (|c| (R))
         ($
          (|Record| (|:| |particular| (|Union| (|Vector| S) "failed"))
                    (|:| |basis| (|List| (|Vector| S))))))
        (SPADCALL (SPADCALL |v| (QREFELT $ 20)) (MAKEARR1 1 |c|)
                  (QREFELT $ 29))) 

(SDEFUN |LINDEP;solveLinear;MVR;5|
        ((|m| (|Matrix| R)) (|v| (|Vector| R))
         ($
          (|Record| (|:| |particular| (|Union| (|Vector| S) "failed"))
                    (|:| |basis| (|List| (|Vector| S))))))
        (SPROG
         ((|sys| (|Record| (|:| |mat| (|Matrix| S)) (|:| |vec| (|Vector| S)))))
         (SEQ (LETT |sys| (SPADCALL |m| |v| (QREFELT $ 33)))
              (EXIT (SPADCALL (QCAR |sys|) (QCDR |sys|) (QREFELT $ 36)))))) 

(SDEFUN |LINDEP;particularSolution;VRU;6|
        ((|v| (|Vector| R)) (|c| (R)) ($ (|Union| (|Vector| S) "failed")))
        (COND
         ((SPADCALL |c| (QREFELT $ 18))
          (CONS 0 (MAKEARR1 (QVSIZE |v|) (|spadConstant| $ 37))))
         ((SPADCALL |v| (QREFELT $ 38)) (CONS 1 "failed"))
         ('T (QCAR (SPADCALL |v| |c| (QREFELT $ 30)))))) 

(SDEFUN |LINDEP;particularSolution;MVU;7|
        ((|m| (|Matrix| R)) (|v| (|Vector| R))
         ($ (|Union| (|Vector| S) "failed")))
        (COND
         ((SPADCALL |v| (SPADCALL (QVSIZE |v|) (QREFELT $ 40)) (QREFELT $ 41))
          (CONS 0 (MAKEARR1 (ANCOLS |m|) (|spadConstant| $ 37))))
         ('T (QCAR (SPADCALL |m| |v| (QREFELT $ 29)))))) 

(SDEFUN |LINDEP;solveLinear;VRR;8|
        ((|v| (|Vector| R)) (|c| (R))
         ($
          (|Record|
           (|:| |particular| (|Union| (|Vector| (|Fraction| S)) "failed"))
           (|:| |basis| (|List| (|Vector| (|Fraction| S)))))))
        (SPADCALL (SPADCALL |v| (QREFELT $ 20)) (MAKEARR1 1 |c|)
                  (QREFELT $ 45))) 

(SDEFUN |LINDEP;solveLinear;MVR;9|
        ((|m| (|Matrix| R)) (|v| (|Vector| R))
         ($
          (|Record|
           (|:| |particular| (|Union| (|Vector| (|Fraction| S)) "failed"))
           (|:| |basis| (|List| (|Vector| (|Fraction| S)))))))
        (SPROG
         ((|sys| (|Record| (|:| |mat| (|Matrix| S)) (|:| |vec| (|Vector| S)))))
         (SEQ (LETT |sys| (SPADCALL |m| |v| (QREFELT $ 33)))
              (EXIT
               (SPADCALL (SPADCALL (ELT $ 48) (QCAR |sys|) (QREFELT $ 52))
                         (SPADCALL (ELT $ 48) (QCDR |sys|) (QREFELT $ 55))
                         (QREFELT $ 57)))))) 

(SDEFUN |LINDEP;particularSolution;VRU;10|
        ((|v| (|Vector| R)) (|c| (R))
         ($ (|Union| (|Vector| (|Fraction| S)) "failed")))
        (COND
         ((SPADCALL |c| (QREFELT $ 18))
          (CONS 0 (MAKEARR1 (QVSIZE |v|) (|spadConstant| $ 58))))
         ((SPADCALL |v| (QREFELT $ 38)) (CONS 1 "failed"))
         ('T (QCAR (SPADCALL |v| |c| (QREFELT $ 46)))))) 

(SDEFUN |LINDEP;particularSolution;MVU;11|
        ((|m| (|Matrix| R)) (|v| (|Vector| R))
         ($ (|Union| (|Vector| (|Fraction| S)) "failed")))
        (COND
         ((SPADCALL |v| (SPADCALL (QVSIZE |v|) (QREFELT $ 40)) (QREFELT $ 41))
          (CONS 0 (MAKEARR1 (ANCOLS |m|) (|spadConstant| $ 58))))
         ('T (QCAR (SPADCALL |m| |v| (QREFELT $ 45)))))) 

(DECLAIM (NOTINLINE |LinearDependence;|)) 

(DEFUN |LinearDependence| (&REST #1=#:G769)
  (SPROG NIL
         (PROG (#2=#:G770)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|LinearDependence|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |LinearDependence;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|LinearDependence|)))))))))) 

(DEFUN |LinearDependence;| (|#1| |#2|)
  (SPROG
   ((|pv$| NIL) (#1=#:G768 NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT |dv$| (LIST '|LinearDependence| DV$1 DV$2))
    (LETT $ (GETREFV 61))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (LETT #1#
                                              (|HasCategory| |#1| '(|Field|)))
                                        (|not| #1#)))))
    (|haddProp| |$ConstructorCache| '|LinearDependence| (LIST DV$1 DV$2)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|testBitVector| |pv$| 1)
      (PROGN
       (QSETREFV $ 30 (CONS (|dispatchFunction| |LINDEP;solveLinear;VRR;4|) $))
       (QSETREFV $ 29 (CONS (|dispatchFunction| |LINDEP;solveLinear;MVR;5|) $))
       (QSETREFV $ 39
                 (CONS (|dispatchFunction| |LINDEP;particularSolution;VRU;6|)
                       $))
       (QSETREFV $ 42
                 (CONS (|dispatchFunction| |LINDEP;particularSolution;MVU;7|)
                       $))))
     ('T
      (PROGN
       (QSETREFV $ 46 (CONS (|dispatchFunction| |LINDEP;solveLinear;VRR;8|) $))
       (QSETREFV $ 45 (CONS (|dispatchFunction| |LINDEP;solveLinear;MVR;9|) $))
       (QSETREFV $ 59
                 (CONS (|dispatchFunction| |LINDEP;particularSolution;VRU;10|)
                       $))
       (QSETREFV $ 60
                 (CONS (|dispatchFunction| |LINDEP;particularSolution;MVU;11|)
                       $)))))
    $))) 

(MAKEPROP '|LinearDependence| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|List| 34)
              (|Matrix| 6) (0 . |nullSpace|) (5 . |One|) (9 . |One|)
              (|Integer|) (|Vector| 7) (13 . |minIndex|) (18 . |elt|)
              (|Boolean|) (24 . |zero?|) (|Matrix| 7) (29 . |transpose|)
              (|Matrix| $) (34 . |reducedSystem|) (|NonNegativeInteger|)
              (39 . |nullity|) |LINDEP;linearlyDependent?;VB;2|
              (|Union| 34 '#1="failed") |LINDEP;linearDependence;VU;3|
              (|Record| (|:| |particular| 26) (|:| |basis| 8))
              (44 . |solveLinear|) (50 . |solveLinear|)
              (|Record| (|:| |mat| 9) (|:| |vec| 34)) (|Vector| $)
              (56 . |reducedSystem|) (|Vector| 6)
              (|LinearSystemMatrixPackage| 6 34 34 9) (62 . |solve|)
              (68 . |Zero|) (72 . |empty?|) (77 . |particularSolution|)
              (83 . |zero|) (88 . =) (94 . |particularSolution|)
              (|Union| 53 '#2="failed")
              (|Record| (|:| |particular| 43) (|:| |basis| (|List| 53)))
              (100 . |solveLinear|) (106 . |solveLinear|) (|Fraction| 6)
              (112 . |coerce|) (|Matrix| 47) (|Mapping| 47 6)
              (|MatrixCategoryFunctions2| 6 34 34 9 47 53 53 49) (117 . |map|)
              (|Vector| 47) (|VectorFunctions2| 6 47) (123 . |map|)
              (|LinearSystemMatrixPackage| 47 53 53 49) (129 . |solve|)
              (135 . |Zero|) (139 . |particularSolution|)
              (145 . |particularSolution|))
           '#(|solveLinear| 151 |particularSolution| 175 |linearlyDependent?|
              199 |linearDependence| 204)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|linearlyDependent?|
                                 ((|Boolean|) (|Vector| |#2|)))
                                T)
                              '((|linearDependence|
                                 ((|Union| (|Vector| |#1|) #1#)
                                  (|Vector| |#2|)))
                                T)
                              '((|particularSolution|
                                 ((|Union| (|Vector| |#1|) #1#) (|Vector| |#2|)
                                  |#2|))
                                (|has| 6 (|Field|)))
                              '((|particularSolution|
                                 ((|Union| (|Vector| |#1|) #1#) (|Matrix| |#2|)
                                  (|Vector| |#2|)))
                                (|has| 6 (|Field|)))
                              '((|solveLinear|
                                 ((|Record|
                                   (|:| |particular|
                                        (|Union| (|Vector| |#1|) #1#))
                                   (|:| |basis| (|List| (|Vector| |#1|))))
                                  (|Vector| |#2|) |#2|))
                                (|has| 6 (|Field|)))
                              '((|solveLinear|
                                 ((|Record|
                                   (|:| |particular|
                                        (|Union| (|Vector| |#1|) #1#))
                                   (|:| |basis| (|List| (|Vector| |#1|))))
                                  (|Matrix| |#2|) (|Vector| |#2|)))
                                (|has| 6 (|Field|)))
                              '((|particularSolution|
                                 ((|Union| (|Vector| (|Fraction| |#1|)) #2#)
                                  (|Vector| |#2|) |#2|))
                                (|not| (|has| 6 (|Field|))))
                              '((|particularSolution|
                                 ((|Union| (|Vector| (|Fraction| |#1|)) #2#)
                                  (|Matrix| |#2|) (|Vector| |#2|)))
                                (|not| (|has| 6 (|Field|))))
                              '((|solveLinear|
                                 ((|Record|
                                   (|:| |particular|
                                        (|Union| (|Vector| (|Fraction| |#1|))
                                                 #2#))
                                   (|:| |basis|
                                        (|List| (|Vector| (|Fraction| |#1|)))))
                                  (|Vector| |#2|) |#2|))
                                (|not| (|has| 6 (|Field|))))
                              '((|solveLinear|
                                 ((|Record|
                                   (|:| |particular|
                                        (|Union| (|Vector| (|Fraction| |#1|))
                                                 #2#))
                                   (|:| |basis|
                                        (|List| (|Vector| (|Fraction| |#1|)))))
                                  (|Matrix| |#2|) (|Vector| |#2|)))
                                (|not| (|has| 6 (|Field|)))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 60
                                            '(1 9 8 0 10 0 6 0 11 0 7 0 12 1 14
                                              13 0 15 2 14 7 0 13 16 1 7 17 0
                                              18 1 19 0 14 20 1 7 9 21 22 1 9
                                              23 0 24 2 0 28 19 14 29 2 0 28 14
                                              7 30 2 7 31 21 32 33 2 35 28 9 34
                                              36 0 6 0 37 1 14 17 0 38 2 0 26
                                              14 7 39 1 14 0 23 40 2 14 17 0 0
                                              41 2 0 26 19 14 42 2 0 44 19 14
                                              45 2 0 44 14 7 46 1 47 0 6 48 2
                                              51 49 50 9 52 2 54 53 50 34 55 2
                                              56 44 49 53 57 0 47 0 58 2 0 43
                                              14 7 59 2 0 43 19 14 60 2 1 28 14
                                              7 30 2 1 28 19 14 29 2 2 44 19 14
                                              45 2 2 44 14 7 46 2 1 26 14 7 39
                                              2 1 26 19 14 42 2 2 43 14 7 59 2
                                              2 43 19 14 60 1 0 17 14 25 1 0 26
                                              14 27)))))
           '|lookupComplete|)) 
