
(DEFPARAMETER |ComplexCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |ComplexCategory;|)) 

(DEFPARAMETER |ComplexCategory;AL| 'NIL) 

(DEFUN |ComplexCategory| (|t#1|)
  (LET (#1=#:G733 (#2=#:G734 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |ComplexCategory;AL|)) (CDR #1#))
          (T
           (SETQ |ComplexCategory;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|ComplexCategory;| #2#)))
                            |ComplexCategory;AL|))
           #1#)))) 

(DEFUN |ComplexCategory;| (|t#1|)
  (SPROG ((#1=#:G732 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (|subst_in_cat| '(#2=#:G731)
                                                   (LIST
                                                    '(|SparseUnivariatePolynomial|
                                                      |t#1|))
                                                   (COND
                                                    (|ComplexCategory;CAT|)
                                                    ('T
                                                     (LETT
                                                      |ComplexCategory;CAT|
                                                      (|Join|
                                                       (|MonogenicAlgebra|
                                                        '|t#1| '#2#)
                                                       (|FullyRetractableTo|
                                                        '|t#1|)
                                                       (|DifferentialExtension|
                                                        '|t#1|)
                                                       (|FullyEvalableOver|
                                                        '|t#1|)
                                                       (|FullyPatternMatchable|
                                                        '|t#1|)
                                                       (|Patternable| '|t#1|)
                                                       (|FullyLinearlyExplicitOver|
                                                        '|t#1|)
                                                       (|CommutativeRing|)
                                                       (|mkCategory|
                                                        '(((|imaginary| ($)) T)
                                                          ((|conjugate| ($ $))
                                                           T)
                                                          ((|complex|
                                                            ($ |t#1| |t#1|))
                                                           T)
                                                          ((|imag| (|t#1| $))
                                                           T)
                                                          ((|real| (|t#1| $))
                                                           T)
                                                          ((|norm| (|t#1| $))
                                                           T)
                                                          ((|exquo|
                                                            ((|Union| $
                                                                      "failed")
                                                             $ |t#1|))
                                                           (|has| |t#1|
                                                                  (|IntegralDomain|)))
                                                          ((|abs| ($ $))
                                                           (|has| |t#1|
                                                                  (|RealNumberSystem|)))
                                                          ((|argument|
                                                            (|t#1| $))
                                                           (|has| |t#1|
                                                                  (|TranscendentalFunctionCategory|)))
                                                          ((|polarCoordinates|
                                                            ((|Record|
                                                              (|:| |r| |t#1|)
                                                              (|:| |phi|
                                                                   |t#1|))
                                                             $))
                                                           (AND
                                                            (|has| |t#1|
                                                                   (|RealNumberSystem|))
                                                            (|has| |t#1|
                                                                   (|TranscendentalFunctionCategory|))))
                                                          ((|rational?|
                                                            ((|Boolean|) $))
                                                           (|has| |t#1|
                                                                  (|IntegerNumberSystem|)))
                                                          ((|rational|
                                                            ((|Fraction|
                                                              (|Integer|))
                                                             $))
                                                           (|has| |t#1|
                                                                  (|IntegerNumberSystem|)))
                                                          ((|rationalIfCan|
                                                            ((|Union|
                                                              (|Fraction|
                                                               (|Integer|))
                                                              "failed")
                                                             $))
                                                           (|has| |t#1|
                                                                  (|IntegerNumberSystem|))))
                                                        '(((|Comparable|)
                                                           (|has| |t#1|
                                                                  (|Comparable|)))
                                                          ((|IntegralDomain|)
                                                           (|has| |t#1|
                                                                  (|IntegralDomain|)))
                                                          ((|EuclideanDomain|)
                                                           (|has| |t#1|
                                                                  (|IntegerNumberSystem|)))
                                                          ((|multiplicativeValuation|)
                                                           (|has| |t#1|
                                                                  (|IntegerNumberSystem|)))
                                                          ((|Field|)
                                                           (|has| |t#1|
                                                                  (|Field|)))
                                                          ((|ConvertibleTo|
                                                            (|InputForm|))
                                                           (|has| |t#1|
                                                                  (|ConvertibleTo|
                                                                   (|InputForm|))))
                                                          ((|CharacteristicZero|)
                                                           (|has| |t#1|
                                                                  (|CharacteristicZero|)))
                                                          ((|CharacteristicNonZero|)
                                                           (|has| |t#1|
                                                                  (|CharacteristicNonZero|)))
                                                          ((|ConvertibleTo|
                                                            (|Complex|
                                                             (|DoubleFloat|)))
                                                           (|has| |t#1|
                                                                  (|RealConstant|)))
                                                          ((|ConvertibleTo|
                                                            (|Complex|
                                                             (|Float|)))
                                                           (|has| |t#1|
                                                                  (|RealConstant|)))
                                                          ((|arbitraryPrecision|)
                                                           (|has| |t#1|
                                                                  (|arbitraryPrecision|)))
                                                          ((|TranscendentalFunctionCategory|)
                                                           (|has| |t#1|
                                                                  (|TranscendentalFunctionCategory|)))
                                                          ((|RadicalCategory|)
                                                           (AND
                                                            (|has| |t#1|
                                                                   (|RadicalCategory|))
                                                            (|has| |t#1|
                                                                   (|TranscendentalFunctionCategory|))))
                                                          ((|UniqueFactorizationDomain|)
                                                           (|has| |t#1|
                                                                  (|IntegerNumberSystem|)))
                                                          ((|PolynomialFactorizationExplicit|)
                                                           (AND
                                                            (|has| |t#1|
                                                                   (|EuclideanDomain|))
                                                            (|has| |t#1|
                                                                   (|PolynomialFactorizationExplicit|)))))
                                                        NIL NIL))))))))
           (SETELT #1# 0 (LIST '|ComplexCategory| |t#1|))))) 
