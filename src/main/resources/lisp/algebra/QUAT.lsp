
(DECLAIM (NOTINLINE |Quaternion;|)) 

(DEFUN |Quaternion| (#1=#:G723)
  (SPROG NIL
         (PROG (#2=#:G724)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|Quaternion|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|Quaternion;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|Quaternion|)))))))))) 

(DEFUN |Quaternion;| (|#1|)
  (SPROG ((|pv$| NIL) (#1=#:G722 NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|Quaternion| DV$1))
          (LETT $ (GETREFV 38))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|CharacteristicNonZero|))
                                              (|HasCategory| |#1|
                                                             '(|CharacteristicZero|))
                                              (|HasCategory| |#1|
                                                             '(|ConvertibleTo|
                                                               (|InputForm|)))
                                              (|HasCategory| |#1| '(|Field|))
                                              (LETT #1#
                                                    (|HasCategory| |#1|
                                                                   '(|EntireRing|)))
                                              (OR #1#
                                                  (|HasCategory| |#1|
                                                                 '(|Field|)))
                                              (|HasCategory| |#1|
                                                             '(|OrderedSet|))
                                              (|HasCategory| |#1|
                                                             '(|RetractableTo|
                                                               (|Fraction|
                                                                (|Integer|))))
                                              (|HasCategory| |#1|
                                                             '(|RetractableTo|
                                                               (|Integer|)))
                                              (|HasCategory| |#1|
                                                             '(|PartialDifferentialRing|
                                                               (|Symbol|)))
                                              (|HasCategory| |#1|
                                                             '(|DifferentialRing|))
                                              (|HasCategory| |#1|
                                                             (LIST
                                                              '|InnerEvalable|
                                                              '(|Symbol|)
                                                              (|devaluate|
                                                               |#1|)))
                                              (|HasCategory| |#1|
                                                             (LIST '|Evalable|
                                                                   (|devaluate|
                                                                    |#1|)))
                                              (|HasCategory| |#1|
                                                             (LIST '|Eltable|
                                                                   (|devaluate|
                                                                    |#1|)
                                                                   (|devaluate|
                                                                    |#1|)))
                                              (|HasCategory| |#1|
                                                             '(|LinearlyExplicitOver|
                                                               (|Integer|)))
                                              (|HasCategory| |#1|
                                                             '(|RealNumberSystem|))
                                              (|HasCategory| |#1|
                                                             '(|IntegerNumberSystem|))
                                              (OR
                                               (|HasCategory| |#1|
                                                              '(|RetractableTo|
                                                                (|Fraction|
                                                                 (|Integer|))))
                                               (|HasCategory| |#1|
                                                              '(|Field|)))))))
          (|haddProp| |$ConstructorCache| '|Quaternion| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|Quaternion| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL
              (|GeneralQuaternion| 6
                                   (NRTEVAL
                                    (SPADCALL (|spadConstant| $ 8)
                                              (QREFELT $ 9)))
                                   (NRTEVAL
                                    (SPADCALL (|spadConstant| $ 8)
                                              (QREFELT $ 9))))
              (|local| |#1|) (0 . |One|) (4 . |One|) (8 . -) (|Fraction| 19)
              (|Union| $ '"failed") (|InputForm|) (|NonNegativeInteger|)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Boolean|) (|List| 17) (|Equation| 6) (|List| 6) (|Integer|)
              (|Symbol|) (|List| 20) (|Union| 10 '"failed") (|Matrix| 19)
              (|Matrix| $) (|Record| (|:| |mat| 23) (|:| |vec| (|Vector| 19)))
              (|Vector| $) (|List| 13) (|Union| 19 '#1="failed") (|Matrix| 6)
              (|Record| (|:| |mat| 29) (|:| |vec| (|Vector| 6)))
              (|Mapping| 6 6) (|Union| 6 '#1#) (|PositiveInteger|)
              (|HashState|) (|String|) (|OutputForm|) (|SingleInteger|))
           '#(|One| 13) 'NIL
           (CONS
            (|makeByteWordVec2| 15
                                '(0 0 0 4 0 0 1 2 6 4 10 11 15 0 0 0 0 0 4 0 0
                                  0 4 0 0 0 0 0 4 4 0 0 0 0 0 0 0 0 7 0 0 0 0 7
                                  0 0 8 9 13 0 0 0 0 3 5 4 7 8 9 12 13 14))
            (CONS
             '#(|QuaternionCategory&| |FullyLinearlyExplicitOver&|
                |DifferentialExtension&| |DivisionRing&| |Algebra&| NIL NIL NIL
                |EntireRing&| |Algebra&| |PartialDifferentialRing&|
                |DifferentialRing&| NIL NIL |Rng&| NIL |Module&| NIL |Module&|
                NIL |NonAssociativeRing&| NIL NIL NIL NIL |NonAssociativeRng&|
                NIL NIL NIL NIL |AbelianGroup&| NIL NIL NIL NIL
                |MagmaWithUnit&| |NonAssociativeSemiRng&| |AbelianMonoid&|
                |OrderedSet&| |FullyEvalableOver&| |FullyRetractableTo&|
                |Magma&| |AbelianSemiGroup&| NIL |RetractableTo&|
                |SetCategory&| |RetractableTo&| |RetractableTo&| |Evalable&|
                NIL NIL |BasicType&| NIL NIL NIL NIL |PartialOrder&| NIL NIL
                |InnerEvalable&| |InnerEvalable&| NIL)
             (CONS
              '#((|QuaternionCategory| 6) (|FullyLinearlyExplicitOver| 6)
                 (|DifferentialExtension| 6) (|DivisionRing|) (|Algebra| 6)
                 (|LinearlyExplicitOver| 6) (|CharacteristicNonZero|)
                 (|CharacteristicZero|) (|EntireRing|) (|Algebra| 10)
                 (|PartialDifferentialRing| 20) (|DifferentialRing|)
                 (|LinearlyExplicitOver| 19) (|Ring|) (|Rng|) (|SemiRing|)
                 (|Module| 6) (|SemiRng|) (|Module| 10) (|BiModule| 6 6)
                 (|NonAssociativeRing|) (|BiModule| $$ $$) (|BiModule| 10 10)
                 (|RightModule| 6) (|LeftModule| 6) (|NonAssociativeRng|)
                 (|RightModule| $$) (|LeftModule| $$) (|LeftModule| 10)
                 (|RightModule| 10) (|AbelianGroup|) (|Monoid|)
                 (|NonAssociativeSemiRing|) (|CancellationAbelianMonoid|)
                 (|SemiGroup|) (|MagmaWithUnit|) (|NonAssociativeSemiRng|)
                 (|AbelianMonoid|) (|OrderedSet|) (|FullyEvalableOver| 6)
                 (|FullyRetractableTo| 6) (|Magma|) (|AbelianSemiGroup|)
                 (|Comparable|) (|RetractableTo| 6) (|SetCategory|)
                 (|RetractableTo| 10) (|RetractableTo| 19) (|Evalable| 6)
                 (|CoercibleFrom| 6) (|unitsKnown|) (|BasicType|)
                 (|CoercibleTo| 36) (|ConvertibleTo| 12) (|noZeroDivisors|)
                 (|TwoSidedRecip|) (|PartialOrder|) (|CoercibleFrom| 10)
                 (|CoercibleFrom| 19) (|InnerEvalable| 20 6)
                 (|InnerEvalable| 6 6) (|Eltable| 6 $$))
              (|makeByteWordVec2| 9 '(0 0 0 7 0 6 0 8 1 6 0 0 9 0 0 0 7)))))
           '|lookupIncomplete|)) 
