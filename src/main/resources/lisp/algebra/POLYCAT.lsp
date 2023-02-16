
(DEFPARAMETER |PolynomialCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |PolynomialCategory;|)) 

(DEFPARAMETER |PolynomialCategory;AL| 'NIL) 

(DEFUN |PolynomialCategory| (|t#1| |t#2| |t#3|)
  (LET (#1=#:G715
        (#2=#:G716
         (LIST (|devaluate| |t#1|) (|devaluate| |t#2|) (|devaluate| |t#3|))))
    (COND ((SETQ #1# (|assoc| #2# |PolynomialCategory;AL|)) (CDR #1#))
          (T
           (SETQ |PolynomialCategory;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (APPLY #'|PolynomialCategory;| #2#)))
                    |PolynomialCategory;AL|))
           #1#)))) 

(DEFUN |PolynomialCategory;| (|t#1| |t#2| |t#3|)
  (SPROG ((#1=#:G714 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2| |t#3|)
                                   (LIST |t#1| |t#2| |t#3|)
                                   (COND (|PolynomialCategory;CAT|)
                                         ('T
                                          (LETT |PolynomialCategory;CAT|
                                                (|Join|
                                                 (|MaybeSkewPolynomialCategory|
                                                  '|t#1| '|t#2| '|t#3|)
                                                 (|InnerEvalable| '|t#3|
                                                                  '|t#1|)
                                                 (|InnerEvalable| '|t#3| '$)
                                                 (|VariablesCommuteWithCoefficients|)
                                                 (|mkCategory|
                                                  '(((|univariate|
                                                      ((|SparseUnivariatePolynomial|
                                                        $)
                                                       $ |t#3|))
                                                     T)
                                                    ((|univariate|
                                                      ((|SparseUnivariatePolynomial|
                                                        |t#1|)
                                                       $))
                                                     T)
                                                    ((|minimumDegree|
                                                      ((|NonNegativeInteger|) $
                                                       |t#3|))
                                                     T)
                                                    ((|minimumDegree|
                                                      ((|List|
                                                        (|NonNegativeInteger|))
                                                       $ (|List| |t#3|)))
                                                     T)
                                                    ((|monicDivide|
                                                      ((|Record|
                                                        (|:| |quotient| $)
                                                        (|:| |remainder| $))
                                                       $ $ |t#3|))
                                                     (|has| |t#1| (|Ring|)))
                                                    ((|multivariate|
                                                      ($
                                                       (|SparseUnivariatePolynomial|
                                                        |t#1|)
                                                       |t#3|))
                                                     T)
                                                    ((|multivariate|
                                                      ($
                                                       (|SparseUnivariatePolynomial|
                                                        $)
                                                       |t#3|))
                                                     T)
                                                    ((|isPlus|
                                                      ((|Union| (|List| $)
                                                                "failed")
                                                       $))
                                                     T)
                                                    ((|isTimes|
                                                      ((|Union| (|List| $)
                                                                "failed")
                                                       $))
                                                     (|has| |t#1|
                                                            (|SemiRing|)))
                                                    ((|isExpt|
                                                      ((|Union|
                                                        (|Record|
                                                         (|:| |var| |t#3|)
                                                         (|:| |exponent|
                                                              (|NonNegativeInteger|)))
                                                        "failed")
                                                       $))
                                                     (|has| |t#1|
                                                            (|SemiRing|)))
                                                    ((|resultant|
                                                      ($ $ $ |t#3|))
                                                     (|has| |t#1|
                                                            (|CommutativeRing|)))
                                                    ((|discriminant|
                                                      ($ $ |t#3|))
                                                     (|has| |t#1|
                                                            (|CommutativeRing|)))
                                                    ((|content| ($ $ |t#3|))
                                                     (|has| |t#1|
                                                            (|GcdDomain|)))
                                                    ((|primitivePart| ($ $))
                                                     (|has| |t#1|
                                                            (|GcdDomain|)))
                                                    ((|primitivePart|
                                                      ($ $ |t#3|))
                                                     (|has| |t#1|
                                                            (|GcdDomain|)))
                                                    ((|squareFree|
                                                      ((|Factored| $) $))
                                                     (|has| |t#1|
                                                            (|GcdDomain|)))
                                                    ((|squareFreePart| ($ $))
                                                     (|has| |t#1|
                                                            (|GcdDomain|))))
                                                  '(((|RetractableTo| |t#3|)
                                                     (|has| |t#1|
                                                            (|SemiRing|)))
                                                    ((|Evalable| $)
                                                     (|has| |t#1|
                                                            (|SemiRing|)))
                                                    ((|PartialDifferentialRing|
                                                      |t#3|)
                                                     (|has| |t#1| (|Ring|)))
                                                    ((|ConvertibleTo|
                                                      (|InputForm|))
                                                     (AND
                                                      (|has| |t#3|
                                                             (|ConvertibleTo|
                                                              (|InputForm|)))
                                                      (|has| |t#1|
                                                             (|ConvertibleTo|
                                                              (|InputForm|)))))
                                                    ((|ConvertibleTo|
                                                      (|Pattern| (|Integer|)))
                                                     (AND
                                                      (|has| |t#3|
                                                             (|ConvertibleTo|
                                                              (|Pattern|
                                                               (|Integer|))))
                                                      (|has| |t#1|
                                                             (|ConvertibleTo|
                                                              (|Pattern|
                                                               (|Integer|))))
                                                      (|has| |t#1| (|Ring|))))
                                                    ((|ConvertibleTo|
                                                      (|Pattern| (|Float|)))
                                                     (AND
                                                      (|has| |t#3|
                                                             (|ConvertibleTo|
                                                              (|Pattern|
                                                               (|Float|))))
                                                      (|has| |t#1|
                                                             (|ConvertibleTo|
                                                              (|Pattern|
                                                               (|Float|))))
                                                      (|has| |t#1| (|Ring|))))
                                                    ((|PatternMatchable|
                                                      (|Integer|))
                                                     (AND
                                                      (|has| |t#3|
                                                             (|PatternMatchable|
                                                              (|Integer|)))
                                                      (|has| |t#1|
                                                             (|PatternMatchable|
                                                              (|Integer|)))
                                                      (|has| |t#1| (|Ring|))))
                                                    ((|PatternMatchable|
                                                      (|Float|))
                                                     (AND
                                                      (|has| |t#3|
                                                             (|PatternMatchable|
                                                              (|Float|)))
                                                      (|has| |t#1|
                                                             (|PatternMatchable|
                                                              (|Float|)))
                                                      (|has| |t#1| (|Ring|))))
                                                    ((|GcdDomain|)
                                                     (|has| |t#1|
                                                            (|GcdDomain|)))
                                                    ((|PolynomialFactorizationExplicit|)
                                                     (|has| |t#1|
                                                            (|PolynomialFactorizationExplicit|))))
                                                  NIL NIL)))))))
           (SETELT #1# 0 (LIST '|PolynomialCategory| |t#1| |t#2| |t#3|))))) 
