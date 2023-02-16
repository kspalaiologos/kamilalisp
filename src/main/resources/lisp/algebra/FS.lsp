
(DEFPARAMETER |FunctionSpace;CAT| 'NIL) 

(DECLAIM (NOTINLINE |FunctionSpace;|)) 

(DEFPARAMETER |FunctionSpace;AL| 'NIL) 

(DEFUN |FunctionSpace| (|t#1|)
  (LET (#1=#:G735 (#2=#:G736 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |FunctionSpace;AL|)) (CDR #1#))
          (T
           (SETQ |FunctionSpace;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|FunctionSpace;| #2#)))
                            |FunctionSpace;AL|))
           #1#)))) 

(DEFUN |FunctionSpace;| (|t#1|)
  (SPROG ((#1=#:G734 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (|subst_in_cat| '(#2=#:G733)
                                                   (LIST '(|Symbol|))
                                                   (COND (|FunctionSpace;CAT|)
                                                         ('T
                                                          (LETT
                                                           |FunctionSpace;CAT|
                                                           (|Join|
                                                            (|ExpressionSpace|)
                                                            (|RetractableTo|
                                                             '#2#)
                                                            (|Patternable|
                                                             '|t#1|)
                                                            (|FullyPatternMatchable|
                                                             '|t#1|)
                                                            (|FullyRetractableTo|
                                                             '|t#1|)
                                                            (|mkCategory|
                                                             '(((|ground?|
                                                                 ((|Boolean|)
                                                                  $))
                                                                T)
                                                               ((|ground|
                                                                 (|t#1| $))
                                                                T)
                                                               ((|variables|
                                                                 ((|List|
                                                                   (|Symbol|))
                                                                  $))
                                                                T)
                                                               ((|variables|
                                                                 ((|List|
                                                                   (|Symbol|))
                                                                  (|List| $)))
                                                                T)
                                                               ((|applyQuote|
                                                                 ($ (|Symbol|)
                                                                  $))
                                                                T)
                                                               ((|applyQuote|
                                                                 ($ (|Symbol|)
                                                                  $ $))
                                                                T)
                                                               ((|applyQuote|
                                                                 ($ (|Symbol|)
                                                                  $ $ $))
                                                                T)
                                                               ((|applyQuote|
                                                                 ($ (|Symbol|)
                                                                  $ $ $ $))
                                                                T)
                                                               ((|applyQuote|
                                                                 ($ (|Symbol|)
                                                                  (|List| $)))
                                                                T)
                                                               ((|eval|
                                                                 ($ $
                                                                  (|BasicOperator|)
                                                                  $
                                                                  (|Symbol|)))
                                                                (|has| |t#1|
                                                                       (|ConvertibleTo|
                                                                        (|InputForm|))))
                                                               ((|eval|
                                                                 ($ $
                                                                  (|List|
                                                                   (|BasicOperator|))
                                                                  (|List| $)
                                                                  (|Symbol|)))
                                                                (|has| |t#1|
                                                                       (|ConvertibleTo|
                                                                        (|InputForm|))))
                                                               ((|isTimes|
                                                                 ((|Union|
                                                                   (|List| $)
                                                                   "failed")
                                                                  $))
                                                                (|has| |t#1|
                                                                       (|SemiGroup|)))
                                                               ((|isExpt|
                                                                 ((|Union|
                                                                   (|Record|
                                                                    (|:| |var|
                                                                         (|Kernel|
                                                                          $))
                                                                    (|:|
                                                                     |exponent|
                                                                     (|Integer|)))
                                                                   "failed")
                                                                  $))
                                                                (|has| |t#1|
                                                                       (|SemiGroup|)))
                                                               ((|isPlus|
                                                                 ((|Union|
                                                                   (|List| $)
                                                                   "failed")
                                                                  $))
                                                                (|has| |t#1|
                                                                       (|AbelianSemiGroup|)))
                                                               ((|isMult|
                                                                 ((|Union|
                                                                   (|Record|
                                                                    (|:| |coef|
                                                                         (|Integer|))
                                                                    (|:| |var|
                                                                         (|Kernel|
                                                                          $)))
                                                                   "failed")
                                                                  $))
                                                                (|has| |t#1|
                                                                       (|AbelianSemiGroup|)))
                                                               ((|coerce|
                                                                 ($
                                                                  (|SparseMultivariatePolynomial|
                                                                   |t#1|
                                                                   (|Kernel|
                                                                    $))))
                                                                (|has| |t#1|
                                                                       (|Ring|)))
                                                               ((|numer|
                                                                 ((|SparseMultivariatePolynomial|
                                                                   |t#1|
                                                                   (|Kernel|
                                                                    $))
                                                                  $))
                                                                (|has| |t#1|
                                                                       (|Ring|)))
                                                               ((|numerator|
                                                                 ($ $))
                                                                (|has| |t#1|
                                                                       (|Ring|)))
                                                               ((|isExpt|
                                                                 ((|Union|
                                                                   (|Record|
                                                                    (|:| |var|
                                                                         (|Kernel|
                                                                          $))
                                                                    (|:|
                                                                     |exponent|
                                                                     (|Integer|)))
                                                                   "failed")
                                                                  $
                                                                  (|BasicOperator|)))
                                                                (|has| |t#1|
                                                                       (|Ring|)))
                                                               ((|isExpt|
                                                                 ((|Union|
                                                                   (|Record|
                                                                    (|:| |var|
                                                                         (|Kernel|
                                                                          $))
                                                                    (|:|
                                                                     |exponent|
                                                                     (|Integer|)))
                                                                   "failed")
                                                                  $
                                                                  (|Symbol|)))
                                                                (|has| |t#1|
                                                                       (|Ring|)))
                                                               ((|isPower|
                                                                 ((|Union|
                                                                   (|Record|
                                                                    (|:| |val|
                                                                         $)
                                                                    (|:|
                                                                     |exponent|
                                                                     (|Integer|)))
                                                                   "failed")
                                                                  $))
                                                                (|has| |t#1|
                                                                       (|Ring|)))
                                                               ((|eval|
                                                                 ($ $
                                                                  (|List|
                                                                   (|Symbol|))
                                                                  (|List|
                                                                   (|NonNegativeInteger|))
                                                                  (|List|
                                                                   (|Mapping| $
                                                                              $))))
                                                                (|has| |t#1|
                                                                       (|Ring|)))
                                                               ((|eval|
                                                                 ($ $
                                                                  (|List|
                                                                   (|Symbol|))
                                                                  (|List|
                                                                   (|NonNegativeInteger|))
                                                                  (|List|
                                                                   (|Mapping| $
                                                                              (|List|
                                                                               $)))))
                                                                (|has| |t#1|
                                                                       (|Ring|)))
                                                               ((|eval|
                                                                 ($ $
                                                                  (|Symbol|)
                                                                  (|NonNegativeInteger|)
                                                                  (|Mapping| $
                                                                             (|List|
                                                                              $))))
                                                                (|has| |t#1|
                                                                       (|Ring|)))
                                                               ((|eval|
                                                                 ($ $
                                                                  (|Symbol|)
                                                                  (|NonNegativeInteger|)
                                                                  (|Mapping| $
                                                                             $)))
                                                                (|has| |t#1|
                                                                       (|Ring|)))
                                                               ((|algtower|
                                                                 ((|List|
                                                                   (|Kernel|
                                                                    $))
                                                                  $))
                                                                (|has| |t#1|
                                                                       (|IntegralDomain|)))
                                                               ((|algtower|
                                                                 ((|List|
                                                                   (|Kernel|
                                                                    $))
                                                                  (|List| $)))
                                                                (|has| |t#1|
                                                                       (|IntegralDomain|)))
                                                               ((|convert|
                                                                 ($
                                                                  (|Factored|
                                                                   $)))
                                                                (|has| |t#1|
                                                                       (|IntegralDomain|)))
                                                               ((|denom|
                                                                 ((|SparseMultivariatePolynomial|
                                                                   |t#1|
                                                                   (|Kernel|
                                                                    $))
                                                                  $))
                                                                (|has| |t#1|
                                                                       (|IntegralDomain|)))
                                                               ((|denominator|
                                                                 ($ $))
                                                                (|has| |t#1|
                                                                       (|IntegralDomain|)))
                                                               ((/
                                                                 ($
                                                                  (|SparseMultivariatePolynomial|
                                                                   |t#1|
                                                                   (|Kernel|
                                                                    $))
                                                                  (|SparseMultivariatePolynomial|
                                                                   |t#1|
                                                                   (|Kernel|
                                                                    $))))
                                                                (|has| |t#1|
                                                                       (|IntegralDomain|)))
                                                               ((|coerce|
                                                                 ($
                                                                  (|Fraction|
                                                                   |t#1|)))
                                                                (|has| |t#1|
                                                                       (|IntegralDomain|)))
                                                               ((|coerce|
                                                                 ($
                                                                  (|Polynomial|
                                                                   (|Fraction|
                                                                    |t#1|))))
                                                                (|has| |t#1|
                                                                       (|IntegralDomain|)))
                                                               ((|coerce|
                                                                 ($
                                                                  (|Fraction|
                                                                   (|Polynomial|
                                                                    (|Fraction|
                                                                     |t#1|)))))
                                                                (|has| |t#1|
                                                                       (|IntegralDomain|)))
                                                               ((|univariate|
                                                                 ((|Fraction|
                                                                   (|SparseUnivariatePolynomial|
                                                                    $))
                                                                  $
                                                                  (|Kernel|
                                                                   $)))
                                                                (|has| |t#1|
                                                                       (|IntegralDomain|))))
                                                             '(((|ConvertibleTo|
                                                                 (|InputForm|))
                                                                (|has| |t#1|
                                                                       (|ConvertibleTo|
                                                                        (|InputForm|))))
                                                               ((|Monoid|)
                                                                (|has| |t#1|
                                                                       (|SemiGroup|)))
                                                               ((|Group|)
                                                                (|has| |t#1|
                                                                       (|Group|)))
                                                               ((|AbelianMonoid|)
                                                                (|has| |t#1|
                                                                       (|AbelianSemiGroup|)))
                                                               ((|AbelianGroup|)
                                                                (|has| |t#1|
                                                                       (|AbelianGroup|)))
                                                               ((|Ring|)
                                                                (|has| |t#1|
                                                                       (|Ring|)))
                                                               ((|RetractableTo|
                                                                 (|Polynomial|
                                                                  |t#1|))
                                                                (|has| |t#1|
                                                                       (|Ring|)))
                                                               ((|PartialDifferentialRing|
                                                                 (|Symbol|))
                                                                (|has| |t#1|
                                                                       (|Ring|)))
                                                               ((|FullyLinearlyExplicitOver|
                                                                 |t#1|)
                                                                (|has| |t#1|
                                                                       (|Ring|)))
                                                               ((|CharacteristicZero|)
                                                                (|has| |t#1|
                                                                       (|CharacteristicZero|)))
                                                               ((|CharacteristicNonZero|)
                                                                (|has| |t#1|
                                                                       (|CharacteristicNonZero|)))
                                                               ((|Algebra|
                                                                 |t#1|)
                                                                (|has| |t#1|
                                                                       (|CommutativeRing|)))
                                                               ((|Field|)
                                                                (|has| |t#1|
                                                                       (|IntegralDomain|)))
                                                               ((|RetractableTo|
                                                                 (|Fraction|
                                                                  (|Polynomial|
                                                                   |t#1|)))
                                                                (|has| |t#1|
                                                                       (|IntegralDomain|)))
                                                               ((|RetractableTo|
                                                                 (|Fraction|
                                                                  (|Integer|)))
                                                                (AND
                                                                 (|has| |t#1|
                                                                        (|RetractableTo|
                                                                         (|Integer|)))
                                                                 (|has| |t#1|
                                                                        (|IntegralDomain|)))))
                                                             NIL NIL))))))))
           (SETELT #1# 0 (LIST '|FunctionSpace| |t#1|))))) 
