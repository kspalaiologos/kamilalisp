
(DECLAIM (NOTINLINE |RealClosedField;|)) 

(DEFPARAMETER |RealClosedField;AL| 'NIL) 

(DEFUN |RealClosedField| ()
  (COND (|RealClosedField;AL|)
        (T (SETQ |RealClosedField;AL| (|RealClosedField;|))))) 

(DEFUN |RealClosedField;| ()
  (SPROG ((#1=#:G705 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(#2=#:G702 #3=#:G703 #4=#:G704)
                                   (LIST '(|Fraction| (|Integer|)) '(|Integer|)
                                         '(|Fraction| (|Integer|)))
                                   (|Join| (|CharacteristicZero|)
                                           (|OrderedRing|) (|CommutativeRing|)
                                           (|Field|)
                                           (|FullyRetractableTo| '#2#)
                                           (|Algebra| '#3#) (|Algebra| '#4#)
                                           (|RadicalCategory|)
                                           (|mkCategory|
                                            '(((|mainForm|
                                                ((|Union| (|OutputForm|)
                                                          "failed")
                                                 $))
                                               T)
                                              ((|mainDefiningPolynomial|
                                                ((|Union|
                                                  (|SparseUnivariatePolynomial|
                                                   $)
                                                  "failed")
                                                 $))
                                               T)
                                              ((|mainValue|
                                                ((|Union|
                                                  (|SparseUnivariatePolynomial|
                                                   $)
                                                  "failed")
                                                 $))
                                               T)
                                              ((|rootOf|
                                                ((|Union| $ "failed")
                                                 (|SparseUnivariatePolynomial|
                                                  $)
                                                 (|PositiveInteger|)
                                                 (|OutputForm|)))
                                               T)
                                              ((|rootOf|
                                                ((|Union| $ "failed")
                                                 (|SparseUnivariatePolynomial|
                                                  $)
                                                 (|PositiveInteger|)))
                                               T)
                                              ((|allRootsOf|
                                                ((|List| $)
                                                 (|SparseUnivariatePolynomial|
                                                  $)))
                                               T)
                                              ((|allRootsOf|
                                                ((|List| $)
                                                 (|SparseUnivariatePolynomial|
                                                  (|Fraction| (|Integer|)))))
                                               T)
                                              ((|allRootsOf|
                                                ((|List| $)
                                                 (|SparseUnivariatePolynomial|
                                                  (|Integer|))))
                                               T)
                                              ((|allRootsOf|
                                                ((|List| $) (|Polynomial| $)))
                                               T)
                                              ((|allRootsOf|
                                                ((|List| $)
                                                 (|Polynomial|
                                                  (|Fraction| (|Integer|)))))
                                               T)
                                              ((|allRootsOf|
                                                ((|List| $)
                                                 (|Polynomial| (|Integer|))))
                                               T)
                                              ((|sqrt|
                                                ($ $ (|PositiveInteger|)))
                                               T)
                                              ((|sqrt| ($ $)) T)
                                              ((|sqrt|
                                                ($ (|Fraction| (|Integer|))))
                                               T)
                                              ((|sqrt| ($ (|Integer|))) T)
                                              ((|rename!| ($ $ (|OutputForm|)))
                                               T)
                                              ((|rename| ($ $ (|OutputForm|)))
                                               T)
                                              ((|approximate|
                                                ((|Fraction| (|Integer|)) $ $))
                                               T))
                                            NIL NIL NIL))))
           (SETELT #1# 0 '(|RealClosedField|))))) 

(MAKEPROP '|RealClosedField| 'NILADIC T) 
