
(DECLAIM (NOTINLINE |PolynomialFactorizationExplicit;|)) 

(DEFPARAMETER |PolynomialFactorizationExplicit;AL| 'NIL) 

(DEFUN |PolynomialFactorizationExplicit| ()
  (COND (|PolynomialFactorizationExplicit;AL|)
        (T
         (SETQ |PolynomialFactorizationExplicit;AL|
                 (|PolynomialFactorizationExplicit;|))))) 

(DEFUN |PolynomialFactorizationExplicit;| ()
  (SPROG ((#1=#:G690 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|UniqueFactorizationDomain|)
                           (|mkCategory|
                            '(((|squareFreePolynomial|
                                ((|Factored| (|SparseUnivariatePolynomial| $))
                                 (|SparseUnivariatePolynomial| $)))
                               T)
                              ((|factorPolynomial|
                                ((|Factored| (|SparseUnivariatePolynomial| $))
                                 (|SparseUnivariatePolynomial| $)))
                               T)
                              ((|factorSquareFreePolynomial|
                                ((|Factored| (|SparseUnivariatePolynomial| $))
                                 (|SparseUnivariatePolynomial| $)))
                               T)
                              ((|gcdPolynomial|
                                ((|SparseUnivariatePolynomial| $)
                                 (|SparseUnivariatePolynomial| $)
                                 (|SparseUnivariatePolynomial| $)))
                               T)
                              ((|solveLinearPolynomialEquation|
                                ((|Union|
                                  (|List| (|SparseUnivariatePolynomial| $))
                                  "failed")
                                 (|List| (|SparseUnivariatePolynomial| $))
                                 (|SparseUnivariatePolynomial| $)))
                               T)
                              ((|conditionP|
                                ((|Union| (|Vector| $) "failed") (|Matrix| $)))
                               (|has| $ (|CharacteristicNonZero|)))
                              ((|charthRoot| ((|Union| $ "failed") $))
                               (|has| $ (|CharacteristicNonZero|))))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|PolynomialFactorizationExplicit|))))) 

(MAKEPROP '|PolynomialFactorizationExplicit| 'NILADIC T) 
