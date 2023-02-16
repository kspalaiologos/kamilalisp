
(DEFPARAMETER |PAdicIntegerCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |PAdicIntegerCategory;|)) 

(DEFPARAMETER |PAdicIntegerCategory;AL| 'NIL) 

(DEFUN |PAdicIntegerCategory| (|t#1|)
  (LET (#1=#:G693 (#2=#:G694 |t#1|))
    (COND ((SETQ #1# (|assoc| #2# |PAdicIntegerCategory;AL|)) (CDR #1#))
          (T
           (SETQ |PAdicIntegerCategory;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|PAdicIntegerCategory;| #2#)))
                            |PAdicIntegerCategory;AL|))
           #1#)))) 

(DEFUN |PAdicIntegerCategory;| (|t#1|)
  (SPROG ((#1=#:G692 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|PAdicIntegerCategory;CAT|)
                                         ('T
                                          (LETT |PAdicIntegerCategory;CAT|
                                                (|Join| (|EuclideanDomain|)
                                                        (|CharacteristicZero|)
                                                        (|mkCategory|
                                                         '(((|digits|
                                                             ((|Stream|
                                                               (|Integer|))
                                                              $))
                                                            T)
                                                           ((|order|
                                                             ((|NonNegativeInteger|)
                                                              $))
                                                            T)
                                                           ((|extend|
                                                             ($ $ (|Integer|)))
                                                            T)
                                                           ((|complete| ($ $))
                                                            T)
                                                           ((|modulus|
                                                             ((|Integer|)))
                                                            T)
                                                           ((|moduloP|
                                                             ((|Integer|) $))
                                                            T)
                                                           ((|quotientByP|
                                                             ($ $))
                                                            T)
                                                           ((|approximate|
                                                             ((|Integer|) $
                                                              (|Integer|)))
                                                            T)
                                                           ((|sqrt|
                                                             ($ $ (|Integer|)))
                                                            T)
                                                           ((|root|
                                                             ($
                                                              (|SparseUnivariatePolynomial|
                                                               (|Integer|))
                                                              (|Integer|)))
                                                            T))
                                                         NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|PAdicIntegerCategory| |t#1|))))) 
