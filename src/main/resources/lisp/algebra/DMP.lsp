
(DECLAIM (NOTINLINE |DistributedMultivariatePolynomial;|)) 

(DEFUN |DistributedMultivariatePolynomial| (&REST #1=#:G765)
  (SPROG NIL
         (PROG (#2=#:G766)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(NIL T))
                                               (HGET |$ConstructorCache|
                                                     '|DistributedMultivariatePolynomial|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |DistributedMultivariatePolynomial;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|DistributedMultivariatePolynomial|)))))))))) 

(DEFUN |DistributedMultivariatePolynomial;| (|#1| |#2|)
  (SPROG
   ((#1=#:G764 NIL) (|pv$| NIL) (#2=#:G757 NIL) (#3=#:G758 NIL) (#4=#:G759 NIL)
    (#5=#:G760 NIL) (#6=#:G761 NIL) (#7=#:G762 NIL) (#8=#:G763 NIL) ($ NIL)
    (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 |#1|)
    (LETT DV$2 (|devaluate| |#2|))
    (LETT |dv$| (LIST '|DistributedMultivariatePolynomial| DV$1 DV$2))
    (LETT $ (GETREFV 61))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#2|
                                                       '(|Algebra|
                                                         (|Fraction|
                                                          (|Integer|))))
                                        (|HasCategory| |#2|
                                                       '(|CharacteristicNonZero|))
                                        (|HasCategory| |#2|
                                                       '(|CharacteristicZero|))
                                        (|HasCategory| |#2| '(|Ring|))
                                        (|HasCategory| |#2|
                                                       '(|CommutativeRing|))
                                        (|HasCategory| |#2|
                                                       '(|RetractableTo|
                                                         (|Fraction|
                                                          (|Integer|))))
                                        (|HasCategory| |#2|
                                                       '(|RetractableTo|
                                                         (|Integer|)))
                                        (|HasCategory| |#2|
                                                       '(|canonicalUnitNormal|))
                                        (|HasCategory| |#2| '(|Comparable|))
                                        (|HasCategory| |#2|
                                                       '(|LinearlyExplicitOver|
                                                         (|Integer|)))
                                        (|HasCategory| |#2|
                                                       '(|PolynomialFactorizationExplicit|))
                                        (|HasCategory| |#2| '(|AbelianGroup|))
                                        (|HasCategory| |#2| '(|SemiRing|))
                                        (|HasCategory| |#2| '(|EntireRing|))
                                        (LETT #8#
                                              (|HasCategory| |#2|
                                                             '(|GcdDomain|)))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|CommutativeRing|))
                                         #8#
                                         (|HasCategory| |#2|
                                                        '(|PolynomialFactorizationExplicit|)))
                                        (OR #8#
                                            (|HasCategory| |#2|
                                                           '(|PolynomialFactorizationExplicit|)))
                                        (OR
                                         (|HasCategory| |#2| '(|EntireRing|))
                                         #8#)
                                        (AND
                                         (|HasCategory| |#2|
                                                        '(|ConvertibleTo|
                                                          (|InputForm|)))
                                         (|HasCategory|
                                          (|OrderedVariableList| |#1|)
                                          '(|ConvertibleTo| (|InputForm|))))
                                        (|HasCategory|
                                         (|DirectProduct| (LENGTH |#1|)
                                                          (|NonNegativeInteger|))
                                         '(|Comparable|))
                                        (|HasCategory| |#2| '(|Field|))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasCategory| |#2|
                                                        '(|RetractableTo|
                                                          (|Fraction|
                                                           (|Integer|)))))
                                        (AND
                                         (|HasCategory| |#2|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#2| '(|Ring|)))
                                        (LETT #7#
                                              (|HasCategory| |#2|
                                                             '(|IntegralDomain|)))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|CommutativeRing|))
                                         #8# #7#
                                         (|HasCategory| |#2|
                                                        '(|PolynomialFactorizationExplicit|)))
                                        (OR #8# #7#
                                            (|HasCategory| |#2|
                                                           '(|PolynomialFactorizationExplicit|)))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|CommutativeRing|))
                                         #8# #7#)
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasCategory| |#2|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#2|
                                                        '(|CharacteristicNonZero|))
                                         (|HasCategory| |#2|
                                                        '(|CharacteristicZero|))
                                         (|HasCategory| |#2|
                                                        '(|CommutativeRing|))
                                         (|HasCategory| |#2| '(|EntireRing|))
                                         #8# #7#
                                         (|HasCategory| |#2|
                                                        '(|PolynomialFactorizationExplicit|))
                                         (|HasCategory| |#2| '(|Ring|)))
                                        (LETT #6#
                                              (AND
                                               (|HasCategory| |#2|
                                                              '(|PatternMatchable|
                                                                (|Float|)))
                                               (|HasCategory| |#2| '(|Ring|))
                                               (|HasCategory|
                                                (|OrderedVariableList| |#1|)
                                                '(|PatternMatchable|
                                                  (|Float|)))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#2|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#2|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#2|
                                                         '(|CommutativeRing|))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          #8#
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#2|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|PatternMatchable| (|Float|))))
                                         #6#)
                                        (LETT #5#
                                              (AND
                                               (|HasCategory| |#2|
                                                              '(|PatternMatchable|
                                                                (|Integer|)))
                                               (|HasCategory| |#2| '(|Ring|))
                                               (|HasCategory|
                                                (|OrderedVariableList| |#1|)
                                                '(|PatternMatchable|
                                                  (|Integer|)))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|CommutativeRing|))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          #8#
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|PatternMatchable| (|Integer|))))
                                         #5#)
                                        (LETT #4#
                                              (AND
                                               (|HasCategory| |#2|
                                                              '(|ConvertibleTo|
                                                                (|Pattern|
                                                                 (|Float|))))
                                               (|HasCategory| |#2| '(|Ring|))
                                               (|HasCategory|
                                                (|OrderedVariableList| |#1|)
                                                '(|ConvertibleTo|
                                                  (|Pattern| (|Float|))))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#2|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#2|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#2|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#2|
                                                         '(|CommutativeRing|))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          #8#
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#2|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         #4#)
                                        (LETT #3#
                                              (AND
                                               (|HasCategory| |#2|
                                                              '(|ConvertibleTo|
                                                                (|Pattern|
                                                                 (|Integer|))))
                                               (|HasCategory| |#2| '(|Ring|))
                                               (|HasCategory|
                                                (|OrderedVariableList| |#1|)
                                                '(|ConvertibleTo|
                                                  (|Pattern| (|Integer|))))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#2|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#2|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#2|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#2|
                                                         '(|CommutativeRing|))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          #8#
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#2|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory|
                                           (|OrderedVariableList| |#1|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         #3#)
                                        (|HasCategory| |#2| '(|AbelianMonoid|))
                                        (LETT #2#
                                              (|HasCategory| |#2|
                                                             '(|CancellationAbelianMonoid|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory|
                                           (|Fraction| (|Integer|))
                                           '(|AbelianMonoid|)))
                                         (|HasCategory| |#2| '(|AbelianGroup|))
                                         (|HasCategory| |#2|
                                                        '(|AbelianMonoid|))
                                         #2#)
                                        (OR
                                         (|HasCategory| |#2| '(|AbelianGroup|))
                                         #2#)))))
    (|haddProp| |$ConstructorCache| '|DistributedMultivariatePolynomial|
                (LIST DV$1 DV$2) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (AND (|HasCategory| $ '(|CommutativeRing|))
         (|augmentPredVector| $ 1099511627776))
    (AND
     (LETT #1#
           (AND (|HasCategory| |#2| '(|PolynomialFactorizationExplicit|))
                (|HasCategory| $ '(|CharacteristicNonZero|))))
     (|augmentPredVector| $ 2199023255552))
    (AND (OR (|HasCategory| |#2| '(|CharacteristicNonZero|)) #1#)
         (|augmentPredVector| $ 4398046511104))
    (AND
     (OR (|HasCategory| |#2| '(|EntireRing|))
         (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 8796093022208))
    (AND
     (OR
      (AND (|HasCategory| |#2| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      #8# (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 17592186044416))
    (AND
     (OR (|HasCategory| |#2| '(|RetractableTo| (|Integer|)))
         (AND (|HasCategory| |#2| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| |#2| '(|Ring|)))
     (|augmentPredVector| $ 35184372088832))
    (AND
     (OR
      (AND (|HasCategory| |#2| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| |#2| '(|SemiRing|)))
     (|augmentPredVector| $ 70368744177664))
    (AND
     (OR
      (AND (|HasCategory| |#2| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| |#2| '(|Ring|)))
     (|augmentPredVector| $ 140737488355328))
    (AND
     (OR (|HasCategory| |#2| '(|AbelianMonoid|))
         (AND (|HasCategory| |#2| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianMonoid|)))
     (|augmentPredVector| $ 281474976710656))
    (AND
     (OR
      (AND (|HasCategory| |#2| '(|AbelianGroup|))
           (|HasCategory| |#2| '(|CommutativeRing|)))
      #2#
      (AND (|HasCategory| |#2| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| $ '(|AbelianGroup|)))
     (|augmentPredVector| $ 562949953421312))
    (AND
     (OR (|HasCategory| |#2| '(|AbelianGroup|))
         (AND (|HasCategory| |#2| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianGroup|)))
     (|augmentPredVector| $ 1125899906842624))
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|DistributedMultivariatePolynomial| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL
              (|GeneralDistributedMultivariatePolynomial|
               (NRTEVAL (QREFELT $ 6)) 7 24)
              (|local| |#1|) (|local| |#2|) (|Union| 14 '#1="failed")
              (|Matrix| $) (|InputForm|) (|Pattern| (|Float|)) (|Pattern| 19)
              (|Record| (|:| |mat| 15) (|:| |vec| (|Vector| 19))) (|Vector| $)
              (|Matrix| 19) (|PatternMatchResult| (|Float|) $)
              (|PatternMatchResult| 19 $) (|Union| $ '#1#) (|Integer|)
              (|Boolean|) (|NonNegativeInteger|)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Fraction| 19)
              (|DirectProduct| (NRTEVAL (LENGTH (QREFELT $ 6))) 21)
              (|Record| (|:| |k| 24) (|:| |c| 7)) (|List| 25)
              (|OrderedVariableList| (NRTEVAL (QREFELT $ 6))) (|Mapping| 7 24)
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|List| $) (|SparseUnivariatePolynomial| $) (|Factored| $)
              (|Factored| 31) (|Union| 35 '#1#) (|List| 31)
              (|Union| 23 '#2="failed") (|Union| 19 '#2#) (|List| 27)
              (|List| 21) (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Matrix| 7) (|Record| (|:| |mat| 41) (|:| |vec| (|Vector| 7)))
              (|Union| 27 '#2#) (|Equation| $) (|List| 44)
              (|Record| (|:| |var| 27) (|:| |exponent| 21))
              (|Union| 46 '#3="failed") (|Union| 30 '#3#) (|List| 19)
              (|SparseUnivariatePolynomial| 7) (|List| 7) (|Mapping| 24 24)
              (|Union| 7 '#2#) (|List| 24) (|Mapping| 7 7) (|PositiveInteger|)
              (|String|) (|SingleInteger|) (|HashState|) (|OutputForm|))
           '#() 'NIL
           (CONS
            (|makeByteWordVec2| 40
                                '(0 0 11 0 11 0 17 26 4 25 15 1 2 3 16 4 10 27
                                  18 4 28 13 28 0 1 5 27 0 1 4 5 0 0 0 1 1 5 28
                                  12 40 13 13 0 0 39 13 0 0 0 9 30 32 0 0 6 7
                                  27 13 13 0 0 0 0 0 0 4 6 7 8 27 14 34 36 19
                                  13 13))
            (CONS
             '#(|PolynomialCategory&| |MaybeSkewPolynomialCategory&|
                |PolynomialFactorizationExplicit&| |FiniteAbelianMonoidRing&|
                |UniqueFactorizationDomain&| |AbelianMonoidRing&| |GcdDomain&|
                NIL |FullyLinearlyExplicitOver&| NIL NIL |Algebra&| NIL NIL
                |Algebra&| NIL NIL |Algebra&| |EntireRing&|
                |PartialDifferentialRing&| NIL NIL |Rng&| NIL |Module&|
                |Module&| |Module&| NIL NIL |NonAssociativeRing&| NIL NIL NIL
                NIL NIL NIL NIL |NonAssociativeRng&| |AbelianGroup&| NIL NIL
                NIL |NonAssociativeSemiRng&| NIL |AbelianMonoid&|
                |MagmaWithUnit&| |FullyRetractableTo&| |Magma&|
                |AbelianSemiGroup&| NIL NIL NIL |RetractableTo&| |SetCategory&|
                |RetractableTo&| |RetractableTo&| NIL |Evalable&|
                |RetractableTo&| NIL |InnerEvalable&| |InnerEvalable&| NIL
                |BasicType&| NIL NIL NIL NIL NIL NIL NIL NIL NIL NIL
                |InnerEvalable&| NIL)
             (CONS
              '#((|PolynomialCategory| 7 (|DirectProduct| (LENGTH 6) 21)
                                       (|OrderedVariableList| 6))
                 (|MaybeSkewPolynomialCategory| 7
                                                (|DirectProduct| (LENGTH 6) 21)
                                                (|OrderedVariableList| 6))
                 (|PolynomialFactorizationExplicit|)
                 (|FiniteAbelianMonoidRing| 7 (|DirectProduct| (LENGTH 6) 21))
                 (|UniqueFactorizationDomain|)
                 (|AbelianMonoidRing| 7 (|DirectProduct| (LENGTH 6) 21))
                 (|GcdDomain|) (|IntegralDomain|)
                 (|FullyLinearlyExplicitOver| 7) (|CommutativeRing|)
                 (|LeftOreRing|) (|Algebra| 23) (|CharacteristicNonZero|)
                 (|CharacteristicZero|) (|Algebra| 7)
                 (|LinearlyExplicitOver| 7) (|LinearlyExplicitOver| 19)
                 (|Algebra| $$) (|EntireRing|)
                 (|PartialDifferentialRing| (|OrderedVariableList| 6)) (|Ring|)
                 (|SemiRing|) (|Rng|) (|SemiRng|) (|Module| 23) (|Module| 7)
                 (|Module| $$) (|BiModule| $$ $$) (|BiModule| 23 23)
                 (|NonAssociativeRing|) (|BiModule| 7 7) (|RightModule| 7)
                 (|RightModule| $$) (|LeftModule| $$) (|LeftModule| 23)
                 (|RightModule| 23) (|LeftModule| 7) (|NonAssociativeRng|)
                 (|AbelianGroup|) (|CancellationAbelianMonoid|)
                 (|NonAssociativeSemiRing|) (|Monoid|)
                 (|NonAssociativeSemiRng|) (|SemiGroup|) (|AbelianMonoid|)
                 (|MagmaWithUnit|) (|FullyRetractableTo| 7) (|Magma|)
                 (|AbelianSemiGroup|) (|Comparable|)
                 (|PatternMatchable| (|Float|)) (|PatternMatchable| 19)
                 (|RetractableTo| 7) (|SetCategory|) (|RetractableTo| 23)
                 (|RetractableTo| 19) (|CommutativeStar|) (|Evalable| $$)
                 (|RetractableTo| (|OrderedVariableList| 6))
                 (|VariablesCommuteWithCoefficients|)
                 (|InnerEvalable| (|OrderedVariableList| 6) $$)
                 (|InnerEvalable| (|OrderedVariableList| 6) 7)
                 (|CoercibleFrom| 7) (|BasicType|) (|CoercibleTo| 60)
                 (|unitsKnown|) (|CoercibleFrom| 23) (|CoercibleFrom| 19)
                 (|canonicalUnitNormal|) (|TwoSidedRecip|) (|noZeroDivisors|)
                 (|ConvertibleTo| 11) (|ConvertibleTo| 12) (|ConvertibleTo| 10)
                 (|InnerEvalable| $$ $$)
                 (|CoercibleFrom| (|OrderedVariableList| 6)))
              (|makeByteWordVec2| -999999 'NIL))))
           '|lookupIncomplete|)) 
