
(DEFPARAMETER |UnivariatePolynomialCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |UnivariatePolynomialCategory;|)) 

(DEFPARAMETER |UnivariatePolynomialCategory;AL| 'NIL) 

(DEFUN |UnivariatePolynomialCategory| (|t#1|)
  (LET (#1=#:G737 (#2=#:G738 (|devaluate| |t#1|)))
    (COND
     ((SETQ #1# (|assoc| #2# |UnivariatePolynomialCategory;AL|)) (CDR #1#))
     (T
      (SETQ |UnivariatePolynomialCategory;AL|
              (|cons5|
               (CONS #2# (SETQ #1# (|UnivariatePolynomialCategory;| #2#)))
               |UnivariatePolynomialCategory;AL|))
      #1#)))) 

(DEFUN |UnivariatePolynomialCategory;| (|t#1|)
  (SPROG ((#1=#:G736 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (|subst_in_cat| '(#2=#:G734 #3=#:G735)
                                                   (LIST
                                                    '(|NonNegativeInteger|)
                                                    '(|SingletonAsOrderedSet|))
                                                   (COND
                                                    (|UnivariatePolynomialCategory;CAT|)
                                                    ('T
                                                     (LETT
                                                      |UnivariatePolynomialCategory;CAT|
                                                      (|Join|
                                                       (|PolynomialCategory|
                                                        '|t#1| '#2# '#3#)
                                                       (|Eltable| '|t#1|
                                                                  '|t#1|)
                                                       (|Eltable| '$ '$)
                                                       (|mkCategory|
                                                        '(((|vectorise|
                                                            ((|Vector| |t#1|) $
                                                             (|NonNegativeInteger|)))
                                                           T)
                                                          ((|unvectorise|
                                                            ($
                                                             (|Vector| |t#1|)))
                                                           T)
                                                          ((|makeSUP|
                                                            ((|SparseUnivariatePolynomial|
                                                              |t#1|)
                                                             $))
                                                           T)
                                                          ((|unmakeSUP|
                                                            ($
                                                             (|SparseUnivariatePolynomial|
                                                              |t#1|)))
                                                           T)
                                                          ((|multiplyExponents|
                                                            ($ $
                                                             (|NonNegativeInteger|)))
                                                           T)
                                                          ((|divideExponents|
                                                            ((|Union| $
                                                                      "failed")
                                                             $
                                                             (|NonNegativeInteger|)))
                                                           T)
                                                          ((|shiftLeft|
                                                            ($ $
                                                             (|NonNegativeInteger|)))
                                                           T)
                                                          ((|monicDivide|
                                                            ((|Record|
                                                              (|:| |quotient|
                                                                   $)
                                                              (|:| |remainder|
                                                                   $))
                                                             $ $))
                                                           (|has| |t#1|
                                                                  (|Ring|)))
                                                          ((|karatsubaDivide|
                                                            ((|Record|
                                                              (|:| |quotient|
                                                                   $)
                                                              (|:| |remainder|
                                                                   $))
                                                             $
                                                             (|NonNegativeInteger|)))
                                                           (|has| |t#1|
                                                                  (|Ring|)))
                                                          ((|shiftRight|
                                                            ($ $
                                                             (|NonNegativeInteger|)))
                                                           (|has| |t#1|
                                                                  (|Ring|)))
                                                          ((|pseudoRemainder|
                                                            ($ $ $))
                                                           (|has| |t#1|
                                                                  (|Ring|)))
                                                          ((|differentiate|
                                                            ($ $
                                                             (|Mapping| |t#1|
                                                                        |t#1|)
                                                             $))
                                                           (|has| |t#1|
                                                                  (|Ring|)))
                                                          ((|discriminant|
                                                            (|t#1| $))
                                                           (|has| |t#1|
                                                                  (|CommutativeRing|)))
                                                          ((|resultant|
                                                            (|t#1| $ $))
                                                           (|has| |t#1|
                                                                  (|CommutativeRing|)))
                                                          ((|elt|
                                                            ((|Fraction| $)
                                                             (|Fraction| $)
                                                             (|Fraction| $)))
                                                           (|has| |t#1|
                                                                  (|IntegralDomain|)))
                                                          ((|order|
                                                            ((|NonNegativeInteger|)
                                                             $ $))
                                                           (|has| |t#1|
                                                                  (|IntegralDomain|)))
                                                          ((|subResultantGcd|
                                                            ($ $ $))
                                                           (|has| |t#1|
                                                                  (|IntegralDomain|)))
                                                          ((|composite|
                                                            ((|Union| $
                                                                      "failed")
                                                             $ $))
                                                           (|has| |t#1|
                                                                  (|IntegralDomain|)))
                                                          ((|composite|
                                                            ((|Union|
                                                              (|Fraction| $)
                                                              "failed")
                                                             (|Fraction| $) $))
                                                           (|has| |t#1|
                                                                  (|IntegralDomain|)))
                                                          ((|pseudoQuotient|
                                                            ($ $ $))
                                                           (|has| |t#1|
                                                                  (|IntegralDomain|)))
                                                          ((|pseudoDivide|
                                                            ((|Record|
                                                              (|:| |coef|
                                                                   |t#1|)
                                                              (|:| |quotient|
                                                                   $)
                                                              (|:| |remainder|
                                                                   $))
                                                             $ $))
                                                           (|has| |t#1|
                                                                  (|IntegralDomain|)))
                                                          ((|separate|
                                                            ((|Record|
                                                              (|:| |primePart|
                                                                   $)
                                                              (|:| |commonPart|
                                                                   $))
                                                             $ $))
                                                           (|has| |t#1|
                                                                  (|GcdDomain|)))
                                                          ((|elt|
                                                            (|t#1|
                                                             (|Fraction| $)
                                                             |t#1|))
                                                           (|has| |t#1|
                                                                  (|Field|)))
                                                          ((|integrate| ($ $))
                                                           (|has| |t#1|
                                                                  (|Algebra|
                                                                   (|Fraction|
                                                                    (|Integer|))))))
                                                        '(((|DifferentialRing|)
                                                           (|has| |t#1|
                                                                  (|Ring|)))
                                                          ((|DifferentialExtension|
                                                            |t#1|)
                                                           (|has| |t#1|
                                                                  (|Ring|)))
                                                          ((|StepThrough|)
                                                           (|has| |t#1|
                                                                  (|StepThrough|)))
                                                          ((|Eltable|
                                                            (|Fraction| $)
                                                            (|Fraction| $))
                                                           (|has| |t#1|
                                                                  (|IntegralDomain|)))
                                                          ((|EuclideanDomain|)
                                                           (|has| |t#1|
                                                                  (|Field|)))
                                                          ((|additiveValuation|)
                                                           (|has| |t#1|
                                                                  (|Field|))))
                                                        NIL NIL))))))))
           (SETELT #1# 0 (LIST '|UnivariatePolynomialCategory| |t#1|))))) 
