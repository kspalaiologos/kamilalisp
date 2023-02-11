
(DECLAIM (NOTINLINE |AlgebraicallyClosedField;|)) 

(DEFPARAMETER |AlgebraicallyClosedField;AL| 'NIL) 

(DEFUN |AlgebraicallyClosedField| ()
  (COND (|AlgebraicallyClosedField;AL|)
        (T (SETQ |AlgebraicallyClosedField;AL| (|AlgebraicallyClosedField;|))))) 

(DEFUN |AlgebraicallyClosedField;| ()
  (SPROG ((#1=#:G702 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|Field|) (|RadicalCategory|)
                           (|mkCategory|
                            '(((|rootOf| ($ (|Polynomial| $))) T)
                              ((|rootOf| ($ (|SparseUnivariatePolynomial| $)))
                               T)
                              ((|rootOf|
                                ($ (|SparseUnivariatePolynomial| $)
                                 (|Symbol|)))
                               T)
                              ((|rootsOf| ((|List| $) (|Polynomial| $))) T)
                              ((|rootsOf|
                                ((|List| $) (|SparseUnivariatePolynomial| $)))
                               T)
                              ((|rootsOf|
                                ((|List| $) (|SparseUnivariatePolynomial| $)
                                 (|Symbol|)))
                               T)
                              ((|zeroOf| ($ (|Polynomial| $))) T)
                              ((|zeroOf| ($ (|SparseUnivariatePolynomial| $)))
                               T)
                              ((|zeroOf|
                                ($ (|SparseUnivariatePolynomial| $)
                                 (|Symbol|)))
                               T)
                              ((|zerosOf| ((|List| $) (|Polynomial| $))) T)
                              ((|zerosOf|
                                ((|List| $) (|SparseUnivariatePolynomial| $)))
                               T)
                              ((|zerosOf|
                                ((|List| $) (|SparseUnivariatePolynomial| $)
                                 (|Symbol|)))
                               T))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|AlgebraicallyClosedField|))))) 

(MAKEPROP '|AlgebraicallyClosedField| 'NILADIC T) 
