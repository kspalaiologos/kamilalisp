
(DEFPARAMETER |UnivariateSkewPolynomialCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |UnivariateSkewPolynomialCategory;|)) 

(DEFPARAMETER |UnivariateSkewPolynomialCategory;AL| 'NIL) 

(DEFUN |UnivariateSkewPolynomialCategory| (|t#1|)
  (LET (#1=#:G705 (#2=#:G706 (|devaluate| |t#1|)))
    (COND
     ((SETQ #1# (|assoc| #2# |UnivariateSkewPolynomialCategory;AL|)) (CDR #1#))
     (T
      (SETQ |UnivariateSkewPolynomialCategory;AL|
              (|cons5|
               (CONS #2# (SETQ #1# (|UnivariateSkewPolynomialCategory;| #2#)))
               |UnivariateSkewPolynomialCategory;AL|))
      #1#)))) 

(DEFUN |UnivariateSkewPolynomialCategory;| (|t#1|)
  (SPROG ((#1=#:G704 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (|subst_in_cat| '(#2=#:G702 #3=#:G703)
                                                   (LIST
                                                    '(|NonNegativeInteger|)
                                                    '(|SingletonAsOrderedSet|))
                                                   (COND
                                                    (|UnivariateSkewPolynomialCategory;CAT|)
                                                    ('T
                                                     (LETT
                                                      |UnivariateSkewPolynomialCategory;CAT|
                                                      (|Join|
                                                       (|MaybeSkewPolynomialCategory|
                                                        '|t#1| '#2# '#3#)
                                                       (|mkCategory|
                                                        '(((|apply|
                                                            (|t#1| $ |t#1|
                                                             |t#1|))
                                                           T)
                                                          ((|exquo|
                                                            ((|Union| $
                                                                      "failed")
                                                             $ |t#1|))
                                                           (|has| |t#1|
                                                                  (|IntegralDomain|)))
                                                          ((|monicLeftDivide|
                                                            ((|Record|
                                                              (|:| |quotient|
                                                                   $)
                                                              (|:| |remainder|
                                                                   $))
                                                             $ $))
                                                           (|has| |t#1|
                                                                  (|IntegralDomain|)))
                                                          ((|monicRightDivide|
                                                            ((|Record|
                                                              (|:| |quotient|
                                                                   $)
                                                              (|:| |remainder|
                                                                   $))
                                                             $ $))
                                                           (|has| |t#1|
                                                                  (|IntegralDomain|)))
                                                          ((|leftDivide|
                                                            ((|Record|
                                                              (|:| |quotient|
                                                                   $)
                                                              (|:| |remainder|
                                                                   $))
                                                             $ $))
                                                           (|has| |t#1|
                                                                  (|Field|)))
                                                          ((|leftQuotient|
                                                            ($ $ $))
                                                           (|has| |t#1|
                                                                  (|Field|)))
                                                          ((|leftRemainder|
                                                            ($ $ $))
                                                           (|has| |t#1|
                                                                  (|Field|)))
                                                          ((|leftExactQuotient|
                                                            ((|Union| $
                                                                      "failed")
                                                             $ $))
                                                           (|has| |t#1|
                                                                  (|Field|)))
                                                          ((|leftGcd| ($ $ $))
                                                           (|has| |t#1|
                                                                  (|Field|)))
                                                          ((|leftExtendedGcd|
                                                            ((|Record|
                                                              (|:| |coef1| $)
                                                              (|:| |coef2| $)
                                                              (|:| |generator|
                                                                   $))
                                                             $ $))
                                                           (|has| |t#1|
                                                                  (|Field|)))
                                                          ((|rightLcm| ($ $ $))
                                                           (|has| |t#1|
                                                                  (|Field|)))
                                                          ((|rightDivide|
                                                            ((|Record|
                                                              (|:| |quotient|
                                                                   $)
                                                              (|:| |remainder|
                                                                   $))
                                                             $ $))
                                                           (|has| |t#1|
                                                                  (|Field|)))
                                                          ((|rightQuotient|
                                                            ($ $ $))
                                                           (|has| |t#1|
                                                                  (|Field|)))
                                                          ((|rightRemainder|
                                                            ($ $ $))
                                                           (|has| |t#1|
                                                                  (|Field|)))
                                                          ((|rightExactQuotient|
                                                            ((|Union| $
                                                                      "failed")
                                                             $ $))
                                                           (|has| |t#1|
                                                                  (|Field|)))
                                                          ((|rightGcd| ($ $ $))
                                                           (|has| |t#1|
                                                                  (|Field|)))
                                                          ((|rightExtendedGcd|
                                                            ((|Record|
                                                              (|:| |coef1| $)
                                                              (|:| |coef2| $)
                                                              (|:| |generator|
                                                                   $))
                                                             $ $))
                                                           (|has| |t#1|
                                                                  (|Field|)))
                                                          ((|right_ext_ext_GCD|
                                                            ((|Record|
                                                              (|:| |generator|
                                                                   $)
                                                              (|:| |coef1| $)
                                                              (|:| |coef2| $)
                                                              (|:| |coefu| $)
                                                              (|:| |coefv| $))
                                                             $ $))
                                                           (|has| |t#1|
                                                                  (|Field|)))
                                                          ((|leftLcm| ($ $ $))
                                                           (|has| |t#1|
                                                                  (|Field|))))
                                                        '(((|Algebra| |t#1|)
                                                           (|has| |t#1|
                                                                  (|CommutativeRing|))))
                                                        NIL NIL))))))))
           (SETELT #1# 0 (LIST '|UnivariateSkewPolynomialCategory| |t#1|))))) 
