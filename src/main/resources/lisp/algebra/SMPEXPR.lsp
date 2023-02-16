
(SDEFUN |SMPEXPR;log;2$;1| ((|p| ($)) ($ ($)))
        (SEQ
         (COND
          ((SPADCALL |p| (QREFELT $ 8))
           (SPADCALL (SPADCALL (SPADCALL |p| (QREFELT $ 9)) (QREFELT $ 10))
                     (QREFELT $ 11)))
          ('T
           (SEQ
            (SPADCALL "log p for p=" (SPADCALL |p| (QREFELT $ 13))
                      (QREFELT $ 17))
            (EXIT
             (|error|
              "SUPTRAFUN: log only defined for elements of the coefficient ring"))))))) 

(SDEFUN |SMPEXPR;exp;2$;2| ((|p| ($)) ($ ($)))
        (SEQ
         (COND
          ((SPADCALL |p| (QREFELT $ 8))
           (SPADCALL (SPADCALL (SPADCALL |p| (QREFELT $ 9)) (QREFELT $ 19))
                     (QREFELT $ 11)))
          ('T
           (SEQ
            (SPADCALL "exp p for p=" (SPADCALL |p| (QREFELT $ 13))
                      (QREFELT $ 17))
            (EXIT
             (|error|
              "SUPTRAFUN: exp only defined for elements of the coefficient ring"))))))) 

(SDEFUN |SMPEXPR;sin;2$;3| ((|p| ($)) ($ ($)))
        (SEQ
         (COND
          ((SPADCALL |p| (QREFELT $ 8))
           (SPADCALL (SPADCALL (SPADCALL |p| (QREFELT $ 9)) (QREFELT $ 21))
                     (QREFELT $ 11)))
          ('T
           (SEQ
            (SPADCALL "sin p for p=" (SPADCALL |p| (QREFELT $ 13))
                      (QREFELT $ 17))
            (EXIT
             (|error|
              "SUPTRAFUN: sin only defined for elements of the coefficient ring"))))))) 

(SDEFUN |SMPEXPR;asin;2$;4| ((|p| ($)) ($ ($)))
        (SEQ
         (COND
          ((SPADCALL |p| (QREFELT $ 8))
           (SPADCALL (SPADCALL (SPADCALL |p| (QREFELT $ 9)) (QREFELT $ 23))
                     (QREFELT $ 11)))
          ('T
           (SEQ
            (SPADCALL "asin p for p=" (SPADCALL |p| (QREFELT $ 13))
                      (QREFELT $ 17))
            (EXIT
             (|error|
              "SUPTRAFUN: asin only defined for elements of the coefficient ring"))))))) 

(SDEFUN |SMPEXPR;cos;2$;5| ((|p| ($)) ($ ($)))
        (SEQ
         (COND
          ((SPADCALL |p| (QREFELT $ 8))
           (SPADCALL (SPADCALL (SPADCALL |p| (QREFELT $ 9)) (QREFELT $ 25))
                     (QREFELT $ 11)))
          ('T
           (SEQ
            (SPADCALL "cos p for p=" (SPADCALL |p| (QREFELT $ 13))
                      (QREFELT $ 17))
            (EXIT
             (|error|
              "SUPTRAFUN: cos only defined for elements of the coefficient ring"))))))) 

(SDEFUN |SMPEXPR;acos;2$;6| ((|p| ($)) ($ ($)))
        (SEQ
         (COND
          ((SPADCALL |p| (QREFELT $ 8))
           (SPADCALL (SPADCALL (SPADCALL |p| (QREFELT $ 9)) (QREFELT $ 27))
                     (QREFELT $ 11)))
          ('T
           (SEQ
            (SPADCALL "acos p for p=" (SPADCALL |p| (QREFELT $ 13))
                      (QREFELT $ 17))
            (EXIT
             (|error|
              "SUPTRAFUN: acos only defined for elements of the coefficient ring"))))))) 

(DECLAIM (NOTINLINE |SparseMultivariatePolynomialExpressions;|)) 

(DEFUN |SparseMultivariatePolynomialExpressions| (#1=#:G792)
  (SPROG NIL
         (PROG (#2=#:G793)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|SparseMultivariatePolynomialExpressions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|SparseMultivariatePolynomialExpressions;| #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|SparseMultivariatePolynomialExpressions|)))))))))) 

(DEFUN |SparseMultivariatePolynomialExpressions;| (|#1|)
  (SPROG
   ((#1=#:G791 NIL) (|pv$| NIL) (#2=#:G784 NIL) (#3=#:G785 NIL) (#4=#:G786 NIL)
    (#5=#:G787 NIL) (#6=#:G788 NIL) (#7=#:G789 NIL) (#8=#:G790 NIL) ($ NIL)
    (|dv$| NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT |dv$| (LIST '|SparseMultivariatePolynomialExpressions| DV$1))
    (LETT $ (GETREFV 76))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1|
                                                       '(|Algebra|
                                                         (|Fraction|
                                                          (|Integer|))))
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicNonZero|))
                                        (|HasCategory| |#1|
                                                       '(|CharacteristicZero|))
                                        (|HasCategory| |#1| '(|Ring|))
                                        (|HasCategory| |#1|
                                                       '(|CommutativeRing|))
                                        (|HasCategory| |#1|
                                                       '(|RetractableTo|
                                                         (|Fraction|
                                                          (|Integer|))))
                                        (|HasCategory| |#1|
                                                       '(|RetractableTo|
                                                         (|Integer|)))
                                        (|HasCategory| |#1|
                                                       '(|canonicalUnitNormal|))
                                        (|HasCategory| |#1| '(|Comparable|))
                                        (|HasCategory| |#1|
                                                       '(|LinearlyExplicitOver|
                                                         (|Integer|)))
                                        (|HasCategory| |#1|
                                                       '(|PolynomialFactorizationExplicit|))
                                        (|HasCategory| |#1| '(|AbelianGroup|))
                                        (|HasCategory| |#1| '(|SemiRing|))
                                        (|HasCategory| |#1| '(|EntireRing|))
                                        (LETT #8#
                                              (|HasCategory| |#1|
                                                             '(|GcdDomain|)))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|CommutativeRing|))
                                         #8#
                                         (|HasCategory| |#1|
                                                        '(|PolynomialFactorizationExplicit|)))
                                        (OR #8#
                                            (|HasCategory| |#1|
                                                           '(|PolynomialFactorizationExplicit|)))
                                        (OR
                                         (|HasCategory| |#1| '(|EntireRing|))
                                         #8#)
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|ConvertibleTo|
                                                          (|InputForm|)))
                                         (|HasCategory| (|NonNegativeInteger|)
                                                        '(|ConvertibleTo|
                                                          (|InputForm|))))
                                        (|HasCategory| |#1|
                                                       '(|TranscendentalFunctionCategory|))
                                        (|HasCategory|
                                         (|IndexedExponents|
                                          (|NonNegativeInteger|))
                                         '(|Comparable|))
                                        (|HasCategory| |#1| '(|Field|))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasCategory| |#1|
                                                        '(|RetractableTo|
                                                          (|Fraction|
                                                           (|Integer|)))))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#1| '(|Ring|)))
                                        (LETT #7#
                                              (|HasCategory| |#1|
                                                             '(|IntegralDomain|)))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|CommutativeRing|))
                                         #8# #7#
                                         (|HasCategory| |#1|
                                                        '(|PolynomialFactorizationExplicit|)))
                                        (OR #8# #7#
                                            (|HasCategory| |#1|
                                                           '(|PolynomialFactorizationExplicit|)))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|CommutativeRing|))
                                         #8# #7#)
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasCategory| |#1|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicNonZero|))
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicZero|))
                                         (|HasCategory| |#1|
                                                        '(|CommutativeRing|))
                                         (|HasCategory| |#1| '(|EntireRing|))
                                         #8# #7#
                                         (|HasCategory| |#1|
                                                        '(|PolynomialFactorizationExplicit|))
                                         (|HasCategory| |#1| '(|Ring|)))
                                        (LETT #6#
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|PatternMatchable|
                                                                (|Float|)))
                                               (|HasCategory| |#1| '(|Ring|))
                                               (|HasCategory|
                                                (|NonNegativeInteger|)
                                                '(|PatternMatchable|
                                                  (|Float|)))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|CommutativeRing|))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          #8#
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         #6#)
                                        (LETT #5#
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|PatternMatchable|
                                                                (|Integer|)))
                                               (|HasCategory| |#1| '(|Ring|))
                                               (|HasCategory|
                                                (|NonNegativeInteger|)
                                                '(|PatternMatchable|
                                                  (|Integer|)))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|CommutativeRing|))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          #8#
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         #5#)
                                        (LETT #4#
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|ConvertibleTo|
                                                                (|Pattern|
                                                                 (|Float|))))
                                               (|HasCategory| |#1| '(|Ring|))
                                               (|HasCategory|
                                                (|NonNegativeInteger|)
                                                '(|ConvertibleTo|
                                                  (|Pattern| (|Float|))))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|CommutativeRing|))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          #8#
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|)))))
                                         #4#)
                                        (LETT #3#
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|ConvertibleTo|
                                                                (|Pattern|
                                                                 (|Integer|))))
                                               (|HasCategory| |#1| '(|Ring|))
                                               (|HasCategory|
                                                (|NonNegativeInteger|)
                                                '(|ConvertibleTo|
                                                  (|Pattern| (|Integer|))))))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|CommutativeRing|))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          #8#
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory| (|NonNegativeInteger|)
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|)))))
                                         #3#)
                                        (|HasCategory| |#1| '(|AbelianMonoid|))
                                        (LETT #2#
                                              (|HasCategory| |#1|
                                                             '(|CancellationAbelianMonoid|)))
                                        (OR
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|Algebra|
                                                           (|Fraction|
                                                            (|Integer|))))
                                          (|HasCategory|
                                           (|Fraction| (|Integer|))
                                           '(|AbelianMonoid|)))
                                         (|HasCategory| |#1| '(|AbelianGroup|))
                                         (|HasCategory| |#1|
                                                        '(|AbelianMonoid|))
                                         #2#)
                                        (OR
                                         (|HasCategory| |#1| '(|AbelianGroup|))
                                         #2#)))))
    (|haddProp| |$ConstructorCache| '|SparseMultivariatePolynomialExpressions|
                (LIST DV$1) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (AND (|HasCategory| $ '(|CommutativeRing|))
         (|augmentPredVector| $ 2199023255552))
    (AND
     (LETT #1#
           (AND (|HasCategory| |#1| '(|PolynomialFactorizationExplicit|))
                (|HasCategory| $ '(|CharacteristicNonZero|))))
     (|augmentPredVector| $ 4398046511104))
    (AND (OR (|HasCategory| |#1| '(|CharacteristicNonZero|)) #1#)
         (|augmentPredVector| $ 8796093022208))
    (AND
     (OR (|HasCategory| |#1| '(|EntireRing|))
         (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 17592186044416))
    (AND
     (OR
      (AND (|HasCategory| |#1| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      #8# (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 35184372088832))
    (AND
     (OR (|HasCategory| |#1| '(|RetractableTo| (|Integer|)))
         (AND (|HasCategory| |#1| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| |#1| '(|Ring|)))
     (|augmentPredVector| $ 70368744177664))
    (AND
     (OR
      (AND (|HasCategory| |#1| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| |#1| '(|SemiRing|)))
     (|augmentPredVector| $ 140737488355328))
    (AND
     (OR
      (AND (|HasCategory| |#1| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| |#1| '(|Ring|)))
     (|augmentPredVector| $ 281474976710656))
    (AND
     (OR (|HasCategory| |#1| '(|AbelianMonoid|))
         (AND (|HasCategory| |#1| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianMonoid|)))
     (|augmentPredVector| $ 562949953421312))
    (AND
     (OR
      (AND (|HasCategory| |#1| '(|AbelianGroup|))
           (|HasCategory| |#1| '(|CommutativeRing|)))
      #2#
      (AND (|HasCategory| |#1| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| $ '(|AbelianGroup|)))
     (|augmentPredVector| $ 1125899906842624))
    (AND
     (OR (|HasCategory| |#1| '(|AbelianGroup|))
         (AND (|HasCategory| |#1| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianGroup|)))
     (|augmentPredVector| $ 2251799813685248))
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|testBitVector| |pv$| 20)
      (PROGN
       (QSETREFV $ 18 (CONS (|dispatchFunction| |SMPEXPR;log;2$;1|) $))
       (QSETREFV $ 20 (CONS (|dispatchFunction| |SMPEXPR;exp;2$;2|) $))
       (QSETREFV $ 22 (CONS (|dispatchFunction| |SMPEXPR;sin;2$;3|) $))
       (QSETREFV $ 24 (CONS (|dispatchFunction| |SMPEXPR;asin;2$;4|) $))
       (QSETREFV $ 26 (CONS (|dispatchFunction| |SMPEXPR;cos;2$;5|) $))
       (QSETREFV $ 28 (CONS (|dispatchFunction| |SMPEXPR;acos;2$;6|) $)))))
    $))) 

(MAKEPROP '|SparseMultivariatePolynomialExpressions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|SparseMultivariatePolynomial| 6 41)
              (|local| |#1|) (|Boolean|) (0 . |ground?|) (5 . |ground|)
              (10 . |log|) (15 . |coerce|) (|OutputForm|) (20 . |coerce|)
              (|Void|) (|String|) (|OutputPackage|) (25 . |output|)
              (31 . |log|) (36 . |exp|) (41 . |exp|) (46 . |sin|) (51 . |sin|)
              (56 . |asin|) (61 . |asin|) (66 . |cos|) (71 . |cos|)
              (76 . |acos|) (81 . |acos|) (|Union| 36 '#1="failed")
              (|Matrix| $) (|InputForm|) (|Pattern| (|Float|)) (|Pattern| 40)
              (|Matrix| 40) (|Record| (|:| |mat| 34) (|:| |vec| (|Vector| 40)))
              (|Vector| $) (|PatternMatchResult| (|Float|) $)
              (|PatternMatchResult| 40 $) (|Union| $ '#1#) (|Integer|)
              (|NonNegativeInteger|)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Fraction| 40) (|IndexedExponents| 41)
              (|Record| (|:| |k| 44) (|:| |c| 6)) (|List| 45) (|Mapping| 6 44)
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|List| $) (|SparseUnivariatePolynomial| $) (|Factored| $)
              (|Factored| 50) (|Union| 54 '#1#) (|List| 50)
              (|Union| 43 '#2="failed") (|Union| 40 '#2#) (|List| 41)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |mat| 60) (|:| |vec| (|Vector| 6))) (|Matrix| 6)
              (|Union| 41 '#2#) (|Equation| $) (|List| 62)
              (|Union| 49 '#3="failed")
              (|Record| (|:| |var| 41) (|:| |exponent| 41)) (|Union| 65 '#3#)
              (|SparseUnivariatePolynomial| 6) (|List| 6) (|Mapping| 44 44)
              (|Union| 6 '#2#) (|List| 44) (|Mapping| 6 6) (|PositiveInteger|)
              (|SingleInteger|) (|HashState|))
           '#(|sin| 86 |log| 91 |ground?| 96 |ground| 101 |exp| 106 |cos| 111
              |coerce| 116 |asin| 126 |acos| 131)
           'NIL
           (CONS
            (|makeByteWordVec2| 41
                                '(0 0 11 0 11 0 17 27 4 26 15 1 2 3 16 4 10 28
                                  18 4 29 0 13 29 0 0 1 5 28 0 0 0 1 4 0 0 0 0
                                  0 1 1 29 12 41 13 13 0 0 40 13 0 0 0 9 31 33
                                  0 0 6 7 28 13 13 20 0 0 0 0 0 0 4 6 7 8 28 14
                                  35 37 19 13 13 20 20 20 20 20))
            (CONS
             '#(|PolynomialCategory&| |MaybeSkewPolynomialCategory&|
                |PolynomialFactorizationExplicit&| |FiniteAbelianMonoidRing&|
                |UniqueFactorizationDomain&| |AbelianMonoidRing&| |GcdDomain&|
                NIL |FullyLinearlyExplicitOver&| NIL NIL |Algebra&| NIL NIL
                |Algebra&| NIL NIL |Algebra&| |EntireRing&|
                |PartialDifferentialRing&| NIL |FreeModuleCategory&| NIL |Rng&|
                NIL NIL |Module&| |Module&| |Module&| NIL NIL NIL NIL
                |NonAssociativeRing&| NIL NIL NIL NIL NIL NIL NIL
                |NonAssociativeRng&| |AbelianGroup&| NIL NIL NIL
                |NonAssociativeSemiRng&| NIL |AbelianMonoid&| |MagmaWithUnit&|
                |FullyRetractableTo&| |Magma&| |AbelianSemiGroup&| NIL NIL NIL
                |RetractableTo&| |SetCategory&| |RetractableTo&|
                |RetractableTo&| NIL |Evalable&| |RetractableTo&|
                |TranscendentalFunctionCategory&| NIL |InnerEvalable&|
                |InnerEvalable&| NIL |BasicType&| NIL NIL NIL NIL NIL NIL NIL
                NIL NIL NIL |InnerEvalable&| NIL
                |TrigonometricFunctionCategory&|
                |ArcTrigonometricFunctionCategory&|
                |HyperbolicFunctionCategory&| NIL
                |ElementaryFunctionCategory&|)
             (CONS
              '#((|PolynomialCategory| 6 44 41)
                 (|MaybeSkewPolynomialCategory| 6 44 41)
                 (|PolynomialFactorizationExplicit|)
                 (|FiniteAbelianMonoidRing| 6 44) (|UniqueFactorizationDomain|)
                 (|AbelianMonoidRing| 6 44) (|GcdDomain|) (|IntegralDomain|)
                 (|FullyLinearlyExplicitOver| 6) (|CommutativeRing|)
                 (|LeftOreRing|) (|Algebra| 43) (|CharacteristicNonZero|)
                 (|CharacteristicZero|) (|Algebra| 6)
                 (|LinearlyExplicitOver| 6) (|LinearlyExplicitOver| 40)
                 (|Algebra| $$) (|EntireRing|) (|PartialDifferentialRing| 41)
                 (|Ring|) (|FreeModuleCategory| 6 44) (|SemiRing|) (|Rng|)
                 (|SemiRng|) (|IndexedDirectProductCategory| 6 44)
                 (|Module| 43) (|Module| 6) (|Module| $$)
                 (|IndexedProductCategory| 6 44) (|BiModule| 6 6)
                 (|BiModule| $$ $$) (|BiModule| 43 43) (|NonAssociativeRing|)
                 (|AbelianProductCategory| 6) (|LeftModule| 6)
                 (|RightModule| 6) (|RightModule| $$) (|LeftModule| $$)
                 (|LeftModule| 43) (|RightModule| 43) (|NonAssociativeRng|)
                 (|AbelianGroup|) (|CancellationAbelianMonoid|)
                 (|NonAssociativeSemiRing|) (|Monoid|)
                 (|NonAssociativeSemiRng|) (|SemiGroup|) (|AbelianMonoid|)
                 (|MagmaWithUnit|) (|FullyRetractableTo| 6) (|Magma|)
                 (|AbelianSemiGroup|) (|Comparable|)
                 (|PatternMatchable| (|Float|)) (|PatternMatchable| 40)
                 (|RetractableTo| 6) (|SetCategory|) (|RetractableTo| 43)
                 (|RetractableTo| 40) (|CommutativeStar|) (|Evalable| $$)
                 (|RetractableTo| 41) (|TranscendentalFunctionCategory|)
                 (|VariablesCommuteWithCoefficients|) (|InnerEvalable| 41 $$)
                 (|InnerEvalable| 41 6) (|CoercibleFrom| 6) (|BasicType|)
                 (|CoercibleTo| 12) (|unitsKnown|) (|CoercibleFrom| 43)
                 (|CoercibleFrom| 40) (|canonicalUnitNormal|) (|TwoSidedRecip|)
                 (|noZeroDivisors|) (|ConvertibleTo| 32) (|ConvertibleTo| 33)
                 (|ConvertibleTo| 31) (|InnerEvalable| $$ $$)
                 (|CoercibleFrom| 41) (|TrigonometricFunctionCategory|)
                 (|ArcTrigonometricFunctionCategory|)
                 (|HyperbolicFunctionCategory|)
                 (|ArcHyperbolicFunctionCategory|)
                 (|ElementaryFunctionCategory|))
              (|makeByteWordVec2| 28
                                  '(1 0 7 0 8 1 0 6 0 9 1 6 0 0 10 1 0 0 6 11 1
                                    0 12 0 13 2 16 14 15 12 17 1 0 0 0 18 1 6 0
                                    0 19 1 0 0 0 20 1 6 0 0 21 1 0 0 0 22 1 6 0
                                    0 23 1 0 0 0 24 1 6 0 0 25 1 0 0 0 26 1 6 0
                                    0 27 1 0 0 0 28 1 20 0 0 22 1 20 0 0 18 1 0
                                    7 0 8 1 0 6 0 9 1 20 0 0 20 1 20 0 0 26 1 0
                                    0 6 11 1 0 12 0 13 1 20 0 0 24 1 20 0 0
                                    28)))))
           '|lookupIncomplete|)) 
