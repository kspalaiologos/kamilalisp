
(SDEFUN |UP;coerce;$Of;1| ((|p| ($)) ($ (|OutputForm|)))
        (SPADCALL |p| (SPADCALL (QREFELT $ 6) (QREFELT $ 11)) (QREFELT $ 12))) 

(SDEFUN |UP;coerce;V$;2| ((|v| (|Variable| |x|)) ($ ($)))
        (SPADCALL (|spadConstant| $ 15) 1 (QREFELT $ 17))) 

(DECLAIM (NOTINLINE |UnivariatePolynomial;|)) 

(DEFUN |UnivariatePolynomial| (&REST #1=#:G776)
  (SPROG NIL
         (PROG (#2=#:G777)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(NIL T))
                                               (HGET |$ConstructorCache|
                                                     '|UnivariatePolynomial|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |UnivariatePolynomial;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|UnivariatePolynomial|)))))))))) 

(DEFUN |UnivariatePolynomial;| (|#1| |#2|)
  (SPROG
   ((#1=#:G775 NIL) (|pv$| NIL) (#2=#:G768 NIL) (#3=#:G769 NIL) (#4=#:G770 NIL)
    (#5=#:G771 NIL) (#6=#:G772 NIL) (#7=#:G773 NIL) (#8=#:G774 NIL) ($ NIL)
    (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 |#1|)
    (LETT DV$2 (|devaluate| |#2|))
    (LETT |dv$| (LIST '|UnivariatePolynomial| DV$1 DV$2))
    (LETT $ (GETREFV 77))
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
                                        (AND
                                         (|HasCategory| |#2|
                                                        '(|ConvertibleTo|
                                                          (|InputForm|)))
                                         (|HasCategory|
                                          (|SingletonAsOrderedSet|)
                                          '(|ConvertibleTo| (|InputForm|))))
                                        (|HasCategory| |#2| '(|SemiRing|))
                                        (|HasCategory| |#2| '(|Field|))
                                        (|HasCategory| |#2| '(|AbelianGroup|))
                                        (|HasCategory| |#2| '(|EntireRing|))
                                        (LETT #8#
                                              (|HasCategory| |#2|
                                                             '(|GcdDomain|)))
                                        (OR (|HasCategory| |#2| '(|Field|)) #8#
                                            (|HasCategory| |#2|
                                                           '(|PolynomialFactorizationExplicit|)))
                                        (OR
                                         (|HasCategory| |#2| '(|EntireRing|))
                                         #8#)
                                        (LETT #7#
                                              (|HasCategory| |#2|
                                                             '(|IntegralDomain|)))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|CommutativeRing|))
                                         (|HasCategory| |#2| '(|Field|)) #8#
                                         #7#
                                         (|HasCategory| |#2|
                                                        '(|PolynomialFactorizationExplicit|)))
                                        (OR (|HasCategory| |#2| '(|Field|)) #8#
                                            #7#
                                            (|HasCategory| |#2|
                                                           '(|PolynomialFactorizationExplicit|)))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|CommutativeRing|))
                                         #8# #7#)
                                        (|HasCategory| |#2| '(|StepThrough|))
                                        (|HasCategory| |#2|
                                                       '(|PartialDifferentialRing|
                                                         (|Symbol|)))
                                        (OR
                                         (|HasCategory| |#2|
                                                        '(|Algebra|
                                                          (|Fraction|
                                                           (|Integer|))))
                                         (|HasCategory| |#2|
                                                        '(|LinearlyExplicitOver|
                                                          (|Integer|)))
                                         (|HasCategory| |#2|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasCategory| |#2|
                                                        '(|CharacteristicNonZero|))
                                         (|HasCategory| |#2|
                                                        '(|CharacteristicZero|))
                                         (|HasCategory| |#2|
                                                        '(|CommutativeRing|))
                                         (|HasCategory| |#2| '(|EntireRing|))
                                         (|HasCategory| |#2| '(|Field|)) #8#
                                         #7#
                                         (|HasCategory| |#2|
                                                        '(|PolynomialFactorizationExplicit|))
                                         (|HasCategory| |#2| '(|Ring|)))
                                        (|HasCategory| (|NonNegativeInteger|)
                                                       '(|Comparable|))
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
                                        (LETT #6#
                                              (AND
                                               (|HasCategory| |#2|
                                                              '(|PatternMatchable|
                                                                (|Float|)))
                                               (|HasCategory| |#2| '(|Ring|))
                                               (|HasCategory|
                                                (|SingletonAsOrderedSet|)
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
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#2|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#2|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#2|
                                                         '(|CommutativeRing|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#2| '(|Field|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          #8#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          #7#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#2|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Float|))))
                                         #6#)
                                        (LETT #5#
                                              (AND
                                               (|HasCategory| |#2|
                                                              '(|PatternMatchable|
                                                                (|Integer|)))
                                               (|HasCategory| |#2| '(|Ring|))
                                               (|HasCategory|
                                                (|SingletonAsOrderedSet|)
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
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|CommutativeRing|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#2| '(|Field|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          #8#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          #7#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|PatternMatchable| (|Integer|))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#2|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
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
                                                (|SingletonAsOrderedSet|)
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
                                           (|SingletonAsOrderedSet|)
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
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#2|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
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
                                           (|SingletonAsOrderedSet|)
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
                                           (|SingletonAsOrderedSet|)
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
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#2| '(|Field|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          #8#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Float|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          #7#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
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
                                           (|SingletonAsOrderedSet|)
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
                                                (|SingletonAsOrderedSet|)
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
                                           (|SingletonAsOrderedSet|)
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
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#2|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
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
                                           (|SingletonAsOrderedSet|)
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
                                           (|SingletonAsOrderedSet|)
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
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#2| '(|Field|))
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          #8#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#2|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          #7#
                                          (|HasCategory|
                                           (|SingletonAsOrderedSet|)
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
                                           (|SingletonAsOrderedSet|)
                                           '(|ConvertibleTo|
                                             (|Pattern| (|Integer|)))))
                                         #3#)
                                        (AND
                                         (|HasCategory| |#2|
                                                        '(|PartialDifferentialRing|
                                                          (|Symbol|)))
                                         (|HasCategory| |#2| '(|Ring|)))
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
    (|haddProp| |$ConstructorCache| '|UnivariatePolynomial| (LIST DV$1 DV$2)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (AND (|HasCategory| $ '(|CommutativeRing|))
         (|augmentPredVector| $ 4398046511104))
    (AND
     (LETT #1#
           (AND (|HasCategory| |#2| '(|PolynomialFactorizationExplicit|))
                (|HasCategory| $ '(|CharacteristicNonZero|))))
     (|augmentPredVector| $ 8796093022208))
    (AND (OR (|HasCategory| |#2| '(|CharacteristicNonZero|)) #1#)
         (|augmentPredVector| $ 17592186044416))
    (AND
     (OR (|HasCategory| |#2| '(|EntireRing|))
         (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 35184372088832))
    (AND
     (OR
      (AND (|HasCategory| |#2| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      #8# (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 70368744177664))
    (AND
     (OR (|HasCategory| |#2| '(|RetractableTo| (|Integer|)))
         (AND (|HasCategory| |#2| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| |#2| '(|Ring|)))
     (|augmentPredVector| $ 140737488355328))
    (AND
     (OR
      (AND (|HasCategory| |#2| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| |#2| '(|SemiRing|)))
     (|augmentPredVector| $ 281474976710656))
    (AND
     (OR
      (AND (|HasCategory| |#2| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| |#2| '(|Ring|)))
     (|augmentPredVector| $ 562949953421312))
    (AND
     (OR (|HasCategory| |#2| '(|AbelianMonoid|))
         (AND (|HasCategory| |#2| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianMonoid|)))
     (|augmentPredVector| $ 1125899906842624))
    (AND
     (OR
      (AND (|HasCategory| |#2| '(|AbelianGroup|))
           (|HasCategory| |#2| '(|CommutativeRing|)))
      #2#
      (AND (|HasCategory| |#2| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      (|HasCategory| $ '(|AbelianGroup|)))
     (|augmentPredVector| $ 2251799813685248))
    (AND
     (OR (|HasCategory| |#2| '(|AbelianGroup|))
         (AND (|HasCategory| |#2| '(|CommutativeRing|))
              (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (AND #7# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
         (|HasCategory| $ '(|AbelianGroup|)))
     (|augmentPredVector| $ 4503599627370496))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 8 (|SparseUnivariatePolynomial| |#2|))
    $))) 

(MAKEPROP '|UnivariatePolynomial| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|SparseUnivariatePolynomial| 7)
              (|local| |#1|) (|local| |#2|) '|Rep| (|Symbol|) (|OutputForm|)
              (0 . |outputForm|) (5 . |outputForm|) |UP;coerce;$Of;1|
              (11 . |One|) (15 . |One|) (|NonNegativeInteger|)
              (19 . |monomial|) (|Variable| (NRTEVAL (QREFELT $ 6)))
              |UP;coerce;V$;2| (|Union| 26 '#1="failed") (|Matrix| $)
              (|InputForm|) (|Pattern| (|Float|)) (|Pattern| 33)
              (|Record| (|:| |mat| 27) (|:| |vec| (|Vector| 33))) (|Vector| $)
              (|Matrix| 33) (|List| 9) (|List| 16)
              (|PatternMatchResult| (|Float|) $) (|PatternMatchResult| 33 $)
              (|Union| $ '#1#) (|Integer|) (|Boolean|)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Fraction| 33) (|Record| (|:| |k| 16) (|:| |c| 7)) (|List| 37)
              (|SingletonAsOrderedSet|) (|Mapping| 7 16)
              (|Record| (|:| |coef| 42) (|:| |generator| $)) (|List| $)
              (|Union| 42 '"failed")
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef1| $) (|:| |coef2| $)) (|Union| 45 '"failed")
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Fraction| $)
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|SparseUnivariatePolynomial| $)
              (|Record| (|:| |primePart| $) (|:| |commonPart| $))
              (|Factored| $)
              (|Record| (|:| |coef| 7) (|:| |quotient| $) (|:| |remainder| $))
              (|Union| 48 '"failed") (|Factored| 50) (|Union| 57 '#1#)
              (|List| 50) (|Union| 36 '#2="failed") (|Union| 33 '#2#)
              (|Mapping| 7 7) (|List| 39) (|Matrix| 7)
              (|Record| (|:| |mat| 62) (|:| |vec| 69)) (|Union| 39 '#2#)
              (|List| 66) (|Equation| $)
              (|Record| (|:| |var| 39) (|:| |exponent| 16))
              (|Union| 67 '"failed") (|Vector| 7) (|List| 7) (|Mapping| 16 16)
              (|Union| 7 '#2#) (|PositiveInteger|) (|HashState|) (|String|)
              (|SingleInteger|))
           '#(~= 25 |zero?| 31 |vectorise| 36 |variables| 42 |unvectorise| 47
              |unmakeSUP| 52 |univariate| 57 |unitNormal| 68 |unitCanonical| 73
              |unit?| 78 |totalDegreeSorted| 83 |totalDegree| 89 |support| 100
              |subtractIfCan| 105 |subResultantGcd| 111 |squareFreePolynomial|
              117 |squareFreePart| 122 |squareFree| 127
              |solveLinearPolynomialEquation| 132 |smaller?| 138 |sizeLess?|
              144 |shiftRight| 150 |shiftLeft| 156 |separate| 162 |sample| 168
              |rightRecip| 172 |rightPower| 177 |retractIfCan| 189 |retract|
              209 |resultant| 229 |rem| 242 |reductum| 248 |reducedSystem| 253
              |recip| 275 |quo| 280 |pseudoRemainder| 286 |pseudoQuotient| 292
              |pseudoDivide| 298 |principalIdeal| 304 |primitivePart| 309
              |primitiveMonomials| 320 |prime?| 325 |pomopo!| 330
              |patternMatch| 338 |order| 352 |opposite?| 358 |one?| 364
              |numberOfMonomials| 369 |nextItem| 374 |multivariate| 379
              |multiplyExponents| 391 |multiEuclidean| 397 |monomials| 403
              |monomial?| 408 |monomial| 413 |monicDivide| 433 |minimumDegree|
              446 |mapExponents| 463 |map| 469 |makeSUP| 475 |mainVariable| 480
              |listOfTerms| 485 |linearExtend| 490 |leftRecip| 496 |leftPower|
              501 |leadingTerm| 513 |leadingSupport| 518 |leadingMonomial| 523
              |leadingCoefficient| 528 |lcmCoef| 533 |lcm| 539 |latex| 550
              |karatsubaDivide| 555 |isTimes| 561 |isPlus| 566 |isExpt| 571
              |integrate| 576 |init| 581 |hashUpdate!| 585 |hash| 591 |ground?|
              596 |ground| 601 |gcdPolynomial| 606 |gcd| 612 |fmecg| 623
              |factorSquareFreePolynomial| 631 |factorPolynomial| 636 |factor|
              641 |extendedEuclidean| 646 |exquo| 659 |expressIdealMember| 671
              |eval| 677 |euclideanSize| 731 |elt| 736 |divideExponents| 766
              |divide| 772 |discriminant| 778 |differentiate| 789 |degree| 872
              |convert| 889 |content| 904 |constructOrdered| 915 |construct|
              920 |conditionP| 925 |composite| 930 |commutator| 942 |coerce|
              948 |coefficients| 983 |coefficient| 988 |charthRoot| 1008
              |characteristic| 1013 |binomThmExpt| 1017 |associator| 1024
              |associates?| 1031 |antiCommutator| 1037 |annihilate?| 1043 ^
              1049 |Zero| 1061 |One| 1065 D 1069 = 1145 / 1151 - 1157 + 1168 *
              1174)
           'NIL
           (CONS
            (|makeByteWordVec2| 42
                                '(0 0 0 11 14 0 11 14 0 18 22 4 21 17 4 1 2 3
                                  21 4 10 4 23 19 25 4 26 0 13 26 0 0 1 5 23 0
                                  0 0 1 4 0 0 0 0 0 1 1 26 15 42 13 13 0 0 41
                                  13 0 0 0 9 31 33 24 0 0 6 7 13 13 23 0 0 0 0
                                  0 0 0 0 4 6 7 8 35 37 12 13 13 14 23 16 20))
            (CONS
             '#(|UnivariatePolynomialCategory&| |PolynomialCategory&|
                |MaybeSkewPolynomialCategory&|
                |PolynomialFactorizationExplicit&| |EuclideanDomain&|
                |FiniteAbelianMonoidRing&| |UniqueFactorizationDomain&| NIL
                |AbelianMonoidRing&| |GcdDomain&| NIL
                |FullyLinearlyExplicitOver&| NIL NIL |DifferentialExtension&|
                |Algebra&| NIL NIL |Algebra&| NIL NIL
                |PartialDifferentialRing&| |Algebra&| |EntireRing&|
                |PartialDifferentialRing&| |DifferentialRing&| NIL
                |FreeModuleCategory&| NIL |Rng&| NIL NIL |Module&| |Module&|
                |Module&| NIL NIL NIL NIL |NonAssociativeRing&| NIL NIL NIL NIL
                NIL NIL NIL |NonAssociativeRng&| |AbelianGroup&| NIL NIL NIL
                |NonAssociativeSemiRng&| NIL |AbelianMonoid&| |MagmaWithUnit&|
                |FullyRetractableTo&| |Magma&| |AbelianSemiGroup&| NIL NIL NIL
                NIL |RetractableTo&| |SetCategory&| |RetractableTo&|
                |RetractableTo&| |Evalable&| |RetractableTo&| NIL NIL NIL NIL
                |InnerEvalable&| |InnerEvalable&| NIL |BasicType&| NIL NIL NIL
                NIL NIL NIL NIL NIL |InnerEvalable&| NIL NIL NIL NIL NIL)
             (CONS
              '#((|UnivariatePolynomialCategory| 7)
                 (|PolynomialCategory| 7 16 39)
                 (|MaybeSkewPolynomialCategory| 7 16 39)
                 (|PolynomialFactorizationExplicit|) (|EuclideanDomain|)
                 (|FiniteAbelianMonoidRing| 7 16) (|UniqueFactorizationDomain|)
                 (|PrincipalIdealDomain|) (|AbelianMonoidRing| 7 16)
                 (|GcdDomain|) (|IntegralDomain|)
                 (|FullyLinearlyExplicitOver| 7) (|CommutativeRing|)
                 (|LeftOreRing|) (|DifferentialExtension| 7) (|Algebra| 36)
                 (|CharacteristicNonZero|) (|CharacteristicZero|) (|Algebra| 7)
                 (|LinearlyExplicitOver| 7) (|LinearlyExplicitOver| 33)
                 (|PartialDifferentialRing| 39) (|Algebra| $$) (|EntireRing|)
                 (|PartialDifferentialRing| 9) (|DifferentialRing|) (|Ring|)
                 (|FreeModuleCategory| 7 16) (|SemiRing|) (|Rng|) (|SemiRng|)
                 (|IndexedDirectProductCategory| 7 16) (|Module| 36)
                 (|Module| 7) (|Module| $$) (|IndexedProductCategory| 7 16)
                 (|BiModule| 7 7) (|BiModule| $$ $$) (|BiModule| 36 36)
                 (|NonAssociativeRing|) (|AbelianProductCategory| 7)
                 (|LeftModule| 7) (|RightModule| 7) (|RightModule| $$)
                 (|LeftModule| $$) (|LeftModule| 36) (|RightModule| 36)
                 (|NonAssociativeRng|) (|AbelianGroup|)
                 (|CancellationAbelianMonoid|) (|NonAssociativeSemiRing|)
                 (|Monoid|) (|NonAssociativeSemiRng|) (|SemiGroup|)
                 (|AbelianMonoid|) (|MagmaWithUnit|) (|FullyRetractableTo| 7)
                 (|Magma|) (|AbelianSemiGroup|) (|Comparable|)
                 (|PatternMatchable| (|Float|)) (|PatternMatchable| 33)
                 (|StepThrough|) (|RetractableTo| 7) (|SetCategory|)
                 (|RetractableTo| 36) (|RetractableTo| 33) (|Evalable| $$)
                 (|RetractableTo| 39) (|CommutativeStar|) (|Eltable| $$ $$)
                 (|Eltable| 7 7) (|VariablesCommuteWithCoefficients|)
                 (|InnerEvalable| 39 $$) (|InnerEvalable| 39 7)
                 (|CoercibleFrom| 7) (|BasicType|) (|CoercibleTo| 10)
                 (|unitsKnown|) (|CoercibleFrom| 36) (|CoercibleFrom| 33)
                 (|canonicalUnitNormal|) (|ConvertibleTo| 23)
                 (|ConvertibleTo| 24) (|ConvertibleTo| 22)
                 (|InnerEvalable| $$ $$) (|CoercibleFrom| 39)
                 (|additiveValuation|) (|TwoSidedRecip|) (|noZeroDivisors|)
                 (|Eltable| (|Fraction| $$) (|Fraction| $$)))
              (|makeByteWordVec2| 76
                                  '(1 10 0 9 11 2 8 10 0 10 12 0 0 0 14 0 7 0
                                    15 2 0 0 7 16 17 2 0 34 0 0 1 1 51 34 0 1 2
                                    0 69 0 16 1 1 0 61 0 1 1 0 0 69 1 1 0 0 5 1
                                    1 0 5 0 1 2 0 50 0 39 1 1 46 35 0 1 1 46 0
                                    0 1 1 46 34 0 1 2 0 16 0 61 1 2 0 16 0 61 1
                                    1 0 16 0 1 1 0 29 0 1 2 52 32 0 0 1 2 20 0
                                    0 0 1 1 11 55 50 1 1 17 0 0 1 1 17 52 0 1 2
                                    11 56 57 50 1 2 9 34 0 0 1 2 14 34 0 0 1 2
                                    4 0 0 16 1 2 0 0 0 16 1 2 17 51 0 0 1 0 51
                                    0 1 1 49 32 0 1 2 49 0 0 16 1 2 0 0 0 73 1
                                    1 6 58 0 1 1 7 59 0 1 1 13 64 0 1 1 0 72 0
                                    1 1 6 36 0 1 1 7 33 0 1 1 13 39 0 1 1 0 7 0
                                    1 2 5 7 0 0 1 3 5 0 0 0 39 1 2 14 0 0 0 1 1
                                    27 0 0 1 2 29 25 21 26 1 1 29 27 21 1 1 4
                                    62 21 1 2 4 63 21 26 1 1 49 32 0 1 2 14 0 0
                                    0 1 2 4 0 0 0 1 2 20 0 0 0 1 2 20 53 0 0 1
                                    1 14 41 42 1 2 17 0 0 39 1 1 17 0 0 1 1 13
                                    42 0 1 1 11 34 0 1 4 0 0 0 7 16 0 1 3 30 30
                                    0 23 30 1 3 32 31 0 24 31 1 2 20 16 0 0 1 2
                                    51 34 0 0 1 1 49 34 0 1 1 0 16 0 1 1 24 32
                                    0 1 2 0 0 50 39 1 2 0 0 5 39 1 2 0 0 0 16 1
                                    2 14 43 42 0 1 1 0 42 0 1 1 0 34 0 1 3 0 0
                                    0 61 29 1 3 0 0 0 39 16 1 2 0 0 7 16 17 2 4
                                    44 0 0 1 3 4 44 0 0 39 1 2 0 29 0 61 1 2 0
                                    16 0 39 1 1 0 16 0 1 2 0 0 71 0 1 2 0 0 60
                                    0 1 1 0 5 0 1 1 0 64 0 1 1 0 38 0 1 2 5 7
                                    40 0 1 1 49 32 0 1 2 49 0 0 16 1 2 0 0 0 73
                                    1 1 27 37 0 1 1 27 16 0 1 1 27 0 0 1 1 27 7
                                    0 1 2 17 49 0 0 1 2 17 0 0 0 1 1 17 0 42 1
                                    1 0 75 0 1 2 4 44 0 16 1 1 13 43 0 1 1 0 43
                                    0 1 1 13 68 0 1 1 1 0 0 1 0 24 0 1 2 0 74
                                    74 0 1 1 0 76 0 1 1 0 34 0 1 1 0 7 0 1 2 17
                                    50 50 50 1 2 17 0 0 0 1 1 17 0 42 1 4 4 0 0
                                    16 7 0 1 1 11 55 50 1 1 11 55 50 1 1 11 52
                                    0 1 3 14 46 0 0 0 1 2 14 47 0 0 1 2 46 32 0
                                    0 1 2 16 32 0 7 1 2 14 43 42 0 1 3 13 0 0
                                    42 42 1 3 13 0 0 0 0 1 2 13 0 0 65 1 2 13 0
                                    0 66 1 3 0 0 0 39 0 1 3 0 0 0 61 42 1 3 0 0
                                    0 61 70 1 3 0 0 0 39 7 1 1 14 16 0 1 2 14 7
                                    48 7 1 2 20 48 0 48 1 2 20 48 48 48 1 2 0 0
                                    0 0 1 2 0 7 0 7 1 2 0 32 0 16 1 2 14 44 0 0
                                    1 1 5 7 0 1 2 5 0 0 39 1 3 38 0 0 9 16 1 3
                                    38 0 0 28 29 1 2 38 0 0 9 1 2 38 0 0 28 1 1
                                    4 0 0 1 2 4 0 0 16 1 3 4 0 0 60 16 1 2 4 0
                                    0 60 1 3 4 0 0 60 0 1 2 4 0 0 39 1 3 4 0 0
                                    39 16 1 2 4 0 0 61 1 3 4 0 0 61 29 1 2 0 29
                                    0 61 1 2 0 16 0 39 1 1 0 16 0 1 1 12 22 0 1
                                    1 34 23 0 1 1 36 24 0 1 2 17 0 0 39 1 1 17
                                    7 0 1 1 27 0 38 1 1 0 0 38 1 1 44 20 21 1 2
                                    20 32 0 0 1 2 20 54 48 0 1 2 50 0 0 0 1 1
                                    47 0 0 1 1 48 0 33 1 1 28 0 36 1 1 13 0 39
                                    1 1 0 0 18 19 1 0 0 7 1 1 0 10 0 13 1 0 70
                                    0 1 3 0 0 0 61 29 1 3 0 0 0 39 16 1 2 0 7 0
                                    16 1 1 45 32 0 1 0 50 16 1 3 43 0 0 0 16 1
                                    3 50 0 0 0 0 1 2 46 34 0 0 1 2 0 0 0 0 1 2
                                    50 34 0 0 1 2 49 0 0 16 1 2 0 0 0 73 1 0 51
                                    0 1 0 49 0 14 3 38 0 0 28 29 1 3 38 0 0 9
                                    16 1 2 38 0 0 9 1 2 38 0 0 28 1 1 4 0 0 1 2
                                    4 0 0 16 1 2 4 0 0 60 1 3 4 0 0 60 16 1 2 4
                                    0 0 39 1 3 4 0 0 39 16 1 2 4 0 0 61 1 3 4 0
                                    0 61 29 1 2 0 34 0 0 1 2 14 0 0 7 1 2 53 0
                                    0 0 1 1 53 0 0 1 2 0 0 0 0 1 2 53 0 33 0 1
                                    2 51 0 16 0 1 2 1 0 0 36 1 2 1 0 36 0 1 2 0
                                    0 7 0 1 2 0 0 0 7 1 2 0 0 0 0 1 2 0 0 73 0
                                    1)))))
           '|lookupComplete|)) 
