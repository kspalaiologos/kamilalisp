
(SDEFUN |DSMP;retractIfCan;$U;1|
        ((|p| ($)) ($ (|Union| (|SparseMultivariatePolynomial| R S) "failed")))
        (COND
         ((ZEROP (SPADCALL |p| (QREFELT $ 10)))
          (CONS 0
                (SPADCALL (CONS #'|DSMP;retractIfCan;$U;1!0| $) (ELT $ 14) |p|
                          (QREFELT $ 18))))
         ('T (CONS 1 "failed")))) 

(SDEFUN |DSMP;retractIfCan;$U;1!0| ((|x| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x| (QREFELT $ 11)) (QREFELT $ 13))) 

(SDEFUN |DSMP;coerce;Smp$;2|
        ((|p| (|SparseMultivariatePolynomial| R S)) ($ ($)))
        (SPADCALL (CONS #'|DSMP;coerce;Smp$;2!0| $) (ELT $ 23) |p|
                  (QREFELT $ 27))) 

(SDEFUN |DSMP;coerce;Smp$;2!0| ((|x| NIL) ($ NIL))
        (SPADCALL (SPADCALL |x| (QREFELT $ 21)) (QREFELT $ 22))) 

(DECLAIM (NOTINLINE |DifferentialSparseMultivariatePolynomial;|)) 

(DEFUN |DifferentialSparseMultivariatePolynomial| (&REST #1=#:G783)
  (SPROG NIL
         (PROG (#2=#:G784)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|DifferentialSparseMultivariatePolynomial|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |DifferentialSparseMultivariatePolynomial;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|DifferentialSparseMultivariatePolynomial|)))))))))) 

(DEFUN |DifferentialSparseMultivariatePolynomial;| (|#1| |#2| |#3|)
  (SPROG
   ((#1=#:G782 NIL) (|pv$| NIL) (#2=#:G776 NIL) (#3=#:G777 NIL) (#4=#:G778 NIL)
    (#5=#:G779 NIL) (#6=#:G780 NIL) (#7=#:G781 NIL) ($ NIL) (|dv$| NIL)
    (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT |dv$|
          (LIST '|DifferentialSparseMultivariatePolynomial| DV$1 DV$2 DV$3))
    (LETT $ (GETREFV 84))
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
                                        (|HasCategory| |#1| '(|Ring|))
                                        (|HasCategory| |#1|
                                                       '(|LinearlyExplicitOver|
                                                         (|Integer|)))
                                        (|HasCategory| |#1|
                                                       '(|PolynomialFactorizationExplicit|))
                                        (|HasCategory| |#1| '(|EntireRing|))
                                        (LETT #7#
                                              (|HasCategory| |#1|
                                                             '(|GcdDomain|)))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|CommutativeRing|))
                                         #7#
                                         (|HasCategory| |#1|
                                                        '(|PolynomialFactorizationExplicit|)))
                                        (OR #7#
                                            (|HasCategory| |#1|
                                                           '(|PolynomialFactorizationExplicit|)))
                                        (OR
                                         (|HasCategory| |#1| '(|EntireRing|))
                                         #7#)
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|ConvertibleTo|
                                                          (|InputForm|)))
                                         (|HasCategory| |#3|
                                                        '(|ConvertibleTo|
                                                          (|InputForm|))))
                                        (|HasCategory| |#1| '(|SemiRing|))
                                        (|HasCategory| |#1|
                                                       '(|DifferentialRing|))
                                        (|HasCategory| |#1|
                                                       '(|PartialDifferentialRing|
                                                         (|Symbol|)))
                                        (|HasCategory|
                                         (|IndexedExponents| |#3|)
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
                                        (LETT #6#
                                              (|HasCategory| |#1|
                                                             '(|IntegralDomain|)))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|CommutativeRing|))
                                         #7# #6#
                                         (|HasCategory| |#1|
                                                        '(|PolynomialFactorizationExplicit|)))
                                        (OR #7# #6#
                                            (|HasCategory| |#1|
                                                           '(|PolynomialFactorizationExplicit|)))
                                        (OR
                                         (|HasCategory| |#1|
                                                        '(|CommutativeRing|))
                                         #7# #6#)
                                        (LETT #5#
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|PatternMatchable|
                                                                (|Float|)))
                                               (|HasCategory| |#1| '(|Ring|))
                                               (|HasCategory| |#3|
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
                                          (|HasCategory| |#3|
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#3|
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#3|
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory| |#3|
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory| |#3|
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|CommutativeRing|))
                                          (|HasCategory| |#3|
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|DifferentialRing|))
                                          (|HasCategory| |#3|
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          #7#
                                          (|HasCategory| |#3|
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Float|)))
                                          (|HasCategory| |#1|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory| |#3|
                                                         '(|PatternMatchable|
                                                           (|Float|))))
                                         #5#)
                                        (LETT #4#
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|PatternMatchable|
                                                                (|Integer|)))
                                               (|HasCategory| |#1| '(|Ring|))
                                               (|HasCategory| |#3|
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
                                          (|HasCategory| |#3|
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|LinearlyExplicitOver|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#3|
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#3|
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicNonZero|))
                                          (|HasCategory| |#3|
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|CharacteristicZero|))
                                          (|HasCategory| |#3|
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|CommutativeRing|))
                                          (|HasCategory| |#3|
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|DifferentialRing|))
                                          (|HasCategory| |#3|
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          #7#
                                          (|HasCategory| |#3|
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|PatternMatchable|
                                                           (|Integer|)))
                                          (|HasCategory| |#1|
                                                         '(|PolynomialFactorizationExplicit|))
                                          (|HasCategory| |#3|
                                                         '(|PatternMatchable|
                                                           (|Integer|))))
                                         #4#)
                                        (LETT #3#
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|ConvertibleTo|
                                                                (|Pattern|
                                                                 (|Float|))))
                                               (|HasCategory| |#1| '(|Ring|))
                                               (|HasCategory| |#3|
                                                              '(|ConvertibleTo|
                                                                (|Pattern|
                                                                 (|Float|))))))
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
                                          (|HasCategory| |#3|
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
                                          (|HasCategory| |#3|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasCategory| |#3|
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
                                          (|HasCategory| |#3|
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
                                          (|HasCategory| |#3|
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
                                          (|HasCategory| |#3|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          (|HasCategory| |#1|
                                                         '(|DifferentialRing|))
                                          (|HasCategory| |#3|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|))))
                                          #7#
                                          (|HasCategory| |#3|
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
                                          (|HasCategory| |#3|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Float|)))))
                                         #3#)
                                        (LETT #2#
                                              (AND
                                               (|HasCategory| |#1|
                                                              '(|ConvertibleTo|
                                                                (|Pattern|
                                                                 (|Integer|))))
                                               (|HasCategory| |#1| '(|Ring|))
                                               (|HasCategory| |#3|
                                                              '(|ConvertibleTo|
                                                                (|Pattern|
                                                                 (|Integer|))))))
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
                                          (|HasCategory| |#3|
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
                                          (|HasCategory| |#3|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|PartialDifferentialRing|
                                                           (|Symbol|)))
                                          (|HasCategory| |#3|
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
                                          (|HasCategory| |#3|
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
                                          (|HasCategory| |#3|
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
                                          (|HasCategory| |#3|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          (|HasCategory| |#1|
                                                         '(|DifferentialRing|))
                                          (|HasCategory| |#3|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|)))))
                                         (AND
                                          (|HasCategory| |#1|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|))))
                                          #7#
                                          (|HasCategory| |#3|
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
                                          (|HasCategory| |#3|
                                                         '(|ConvertibleTo|
                                                           (|Pattern|
                                                            (|Integer|)))))
                                         #2#)))))
    (|haddProp| |$ConstructorCache| '|DifferentialSparseMultivariatePolynomial|
                (LIST DV$1 DV$2 DV$3) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (AND (|HasCategory| $ '(|CommutativeRing|))
         (|augmentPredVector| $ 68719476736))
    (AND
     (LETT #1#
           (AND (|HasCategory| |#1| '(|PolynomialFactorizationExplicit|))
                (|HasCategory| $ '(|CharacteristicNonZero|))))
     (|augmentPredVector| $ 137438953472))
    (AND (OR (|HasCategory| |#1| '(|CharacteristicNonZero|)) #1#)
         (|augmentPredVector| $ 274877906944))
    (AND
     (OR (|HasCategory| |#1| '(|EntireRing|))
         (AND #6# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 549755813888))
    (AND
     (OR
      (AND (|HasCategory| |#1| '(|CommutativeRing|))
           (|HasCategory| $ '(|VariablesCommuteWithCoefficients|)))
      #7# (AND #6# (|HasCategory| $ '(|VariablesCommuteWithCoefficients|))))
     (|augmentPredVector| $ 1099511627776))
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|DifferentialSparseMultivariatePolynomial| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|SparseMultivariatePolynomial| 6 8)
              (|local| |#1|) (|local| |#2|) (|local| |#3|)
              (|NonNegativeInteger|) (0 . |order|) (5 . |retract|)
              (|SparseMultivariatePolynomial| 6 7) (10 . |coerce|)
              (15 . |coerce|) (|Mapping| 12 8) (|Mapping| 12 6)
              (|PolynomialCategoryLifting| 43 8 6 $$ 12) (20 . |map|)
              (|Union| 12 '"failed") |DSMP;retractIfCan;$U;1| (27 . |coerce|)
              (32 . |coerce|) (37 . |coerce|) (|Mapping| $$ 7) (|Mapping| $$ 6)
              (|PolynomialCategoryLifting| (|IndexedExponents| 7) 7 6 12 $$)
              (42 . |map|) |DSMP;coerce;Smp$;2| (|Union| 36 '#1="failed")
              (|Matrix| $) (|InputForm|) (|Pattern| (|Float|)) (|Pattern| 61)
              (|Matrix| 61) (|Record| (|:| |mat| 34) (|:| |vec| (|Vector| 61)))
              (|Vector| $) (|PatternMatchResult| (|Float|) $)
              (|PatternMatchResult| 61 $) (|Union| $ '#1#) (|Boolean|)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|Fraction| 61) (|IndexedExponents| 8)
              (|Record| (|:| |k| 43) (|:| |c| 6)) (|List| 44) (|Mapping| 6 43)
              (|List| 7) (|List| 6) (|List| $) (|Mapping| $ 9)
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|SparseUnivariatePolynomial| $) (|Factored| $) (|List| 56)
              (|List| 9) (|Symbol|) (|Factored| 52) (|Union| 59 '#1#)
              (|List| 52) (|Union| 42 '#2="failed") (|Integer|)
              (|Union| 61 '#2#) (|List| 8)
              (|Record| (|:| |quotient| $) (|:| |remainder| $)) (|Matrix| 6)
              (|Record| (|:| |mat| 65) (|:| |vec| (|Vector| 6))) (|Equation| $)
              (|List| 67) (|Union| 8 '#2#)
              (|Record| (|:| |var| 8) (|:| |exponent| 9))
              (|Union| 70 '#3="failed") (|Union| 49 '#3#) (|Union| 7 '#2#)
              (|Mapping| 6 6) (|SparseUnivariatePolynomial| 6)
              (|Mapping| 43 43) (|Union| 6 '#2#) (|List| 43)
              (|PositiveInteger|) (|HashState|) (|String|) (|OutputForm|)
              (|SingleInteger|))
           '#(|retractIfCan| 49 |order| 54 |coerce| 59) 'NIL
           (CONS
            (|makeByteWordVec2| 36
                                '(0 0 0 11 0 11 0 15 27 0 9 26 13 1 2 3 14 9 10
                                  28 16 9 20 19 0 0 0 0 0 0 1 4 28 0 0 0 0 1 0
                                  0 0 0 0 0 1 1 0 0 0 0 0 0 0 0 0 0 0 8 30 32 0
                                  0 0 0 5 6 28 18 18 0 0 0 0 0 0 0 0 0 5 6 7 28
                                  12 34 36 17 18 18 19 19))
            (CONS
             '#(|DifferentialPolynomialCategory&| |PolynomialCategory&|
                |MaybeSkewPolynomialCategory&|
                |PolynomialFactorizationExplicit&| |FiniteAbelianMonoidRing&|
                |UniqueFactorizationDomain&| |AbelianMonoidRing&| |GcdDomain&|
                NIL |DifferentialExtension&| |FullyLinearlyExplicitOver&| NIL
                NIL |Algebra&| NIL NIL |Algebra&| NIL NIL |Algebra&|
                |EntireRing&| |PartialDifferentialRing&|
                |PartialDifferentialRing&| |DifferentialRing&| NIL NIL |Rng&|
                |FreeModuleCategory&| NIL NIL |Module&| |Module&| |Module&|
                |NonAssociativeRing&| NIL NIL NIL NIL |NonAssociativeRng&| NIL
                NIL NIL NIL NIL NIL NIL |AbelianGroup&| NIL NIL NIL NIL
                |MagmaWithUnit&| |AbelianMonoid&| |NonAssociativeSemiRng&|
                |Magma&| |FullyRetractableTo&| |AbelianSemiGroup&| NIL NIL NIL
                |RetractableTo&| |RetractableTo&| |RetractableTo&|
                |SetCategory&| |RetractableTo&| |RetractableTo&| NIL
                |RetractableTo&| |Evalable&| NIL NIL NIL NIL |InnerEvalable&|
                |InnerEvalable&| NIL |BasicType&| NIL NIL NIL NIL NIL NIL NIL
                NIL NIL NIL |InnerEvalable&| |InnerEvalable&| |InnerEvalable&|)
             (CONS
              '#((|DifferentialPolynomialCategory| 6 7 8
                                                   (|IndexedExponents| 8))
                 (|PolynomialCategory| 6 (|IndexedExponents| 8) 8)
                 (|MaybeSkewPolynomialCategory| 6 (|IndexedExponents| 8) 8)
                 (|PolynomialFactorizationExplicit|)
                 (|FiniteAbelianMonoidRing| 6 (|IndexedExponents| 8))
                 (|UniqueFactorizationDomain|)
                 (|AbelianMonoidRing| 6 (|IndexedExponents| 8)) (|GcdDomain|)
                 (|IntegralDomain|) (|DifferentialExtension| 6)
                 (|FullyLinearlyExplicitOver| 6) (|CommutativeRing|)
                 (|LeftOreRing|) (|Algebra| 42) (|CharacteristicNonZero|)
                 (|CharacteristicZero|) (|Algebra| 6)
                 (|LinearlyExplicitOver| 6) (|LinearlyExplicitOver| 61)
                 (|Algebra| $$) (|EntireRing|) (|PartialDifferentialRing| 8)
                 (|PartialDifferentialRing| 56) (|DifferentialRing|) (|Ring|)
                 (|SemiRing|) (|Rng|)
                 (|FreeModuleCategory| 6 (|IndexedExponents| 8)) (|SemiRng|)
                 (|IndexedDirectProductCategory| 6 (|IndexedExponents| 8))
                 (|Module| 42) (|Module| 6) (|Module| $$)
                 (|NonAssociativeRing|)
                 (|IndexedProductCategory| 6 (|IndexedExponents| 8))
                 (|BiModule| 6 6) (|BiModule| $$ $$) (|BiModule| 42 42)
                 (|NonAssociativeRng|) (|AbelianProductCategory| 6)
                 (|LeftModule| 6) (|RightModule| 6) (|RightModule| $$)
                 (|LeftModule| $$) (|LeftModule| 42) (|RightModule| 42)
                 (|AbelianGroup|) (|Monoid|) (|NonAssociativeSemiRing|)
                 (|CancellationAbelianMonoid|) (|SemiGroup|) (|MagmaWithUnit|)
                 (|AbelianMonoid|) (|NonAssociativeSemiRng|) (|Magma|)
                 (|FullyRetractableTo| 6) (|AbelianSemiGroup|) (|Comparable|)
                 (|PatternMatchable| (|Float|)) (|PatternMatchable| 61)
                 (|RetractableTo| (|SparseMultivariatePolynomial| 6 7))
                 (|RetractableTo| 7) (|RetractableTo| 6) (|SetCategory|)
                 (|RetractableTo| 42) (|RetractableTo| 61) (|CommutativeStar|)
                 (|RetractableTo| 8) (|Evalable| $$)
                 (|CoercibleFrom| (|SparseMultivariatePolynomial| 6 7))
                 (|CoercibleFrom| 7) (|unitsKnown|)
                 (|VariablesCommuteWithCoefficients|) (|InnerEvalable| 8 $$)
                 (|InnerEvalable| 8 6) (|CoercibleFrom| 6) (|BasicType|)
                 (|CoercibleTo| 82) (|CoercibleFrom| 42) (|CoercibleFrom| 61)
                 (|canonicalUnitNormal|) (|TwoSidedRecip|) (|noZeroDivisors|)
                 (|ConvertibleTo| 32) (|ConvertibleTo| 33) (|ConvertibleTo| 31)
                 (|CoercibleFrom| 8) (|InnerEvalable| $$ $$)
                 (|InnerEvalable| 7 $$) (|InnerEvalable| 7 6))
              (|makeByteWordVec2| 28
                                  '(1 0 9 0 10 1 8 7 0 11 1 12 0 7 13 1 12 0 6
                                    14 3 17 12 15 16 2 18 1 8 0 7 21 1 0 0 8 22
                                    1 0 0 6 23 3 26 2 24 25 12 27 1 0 19 0 20 1
                                    0 9 0 10 1 18 0 8 22 1 0 0 12 28 1 0 0 6
                                    23)))))
           '|lookupIncomplete|)) 
