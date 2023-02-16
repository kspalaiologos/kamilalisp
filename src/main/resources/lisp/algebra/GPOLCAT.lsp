
(DEFPARAMETER |MaybeSkewPolynomialCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |MaybeSkewPolynomialCategory;|)) 

(DEFPARAMETER |MaybeSkewPolynomialCategory;AL| 'NIL) 

(DEFUN |MaybeSkewPolynomialCategory| (|t#1| |t#2| |t#3|)
  (LET (#1=#:G693
        (#2=#:G694
         (LIST (|devaluate| |t#1|) (|devaluate| |t#2|) (|devaluate| |t#3|))))
    (COND ((SETQ #1# (|assoc| #2# |MaybeSkewPolynomialCategory;AL|)) (CDR #1#))
          (T
           (SETQ |MaybeSkewPolynomialCategory;AL|
                   (|cons5|
                    (CONS #2#
                          (SETQ #1#
                                  (APPLY #'|MaybeSkewPolynomialCategory;|
                                         #2#)))
                    |MaybeSkewPolynomialCategory;AL|))
           #1#)))) 

(DEFUN |MaybeSkewPolynomialCategory;| (|t#1| |t#2| |t#3|)
  (SPROG ((#1=#:G692 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2| |t#3|)
                                   (LIST |t#1| |t#2| |t#3|)
                                   (COND (|MaybeSkewPolynomialCategory;CAT|)
                                         ('T
                                          (LETT
                                           |MaybeSkewPolynomialCategory;CAT|
                                           (|Join|
                                            (|FiniteAbelianMonoidRing| '|t#1|
                                                                       '|t#2|)
                                            (|mkCategory|
                                             '(((|degree|
                                                 ((|NonNegativeInteger|) $
                                                  |t#3|))
                                                T)
                                               ((|degree|
                                                 ((|List|
                                                   (|NonNegativeInteger|))
                                                  $ (|List| |t#3|)))
                                                T)
                                               ((|coefficient|
                                                 ($ $ |t#3|
                                                  (|NonNegativeInteger|)))
                                                T)
                                               ((|coefficient|
                                                 ($ $ (|List| |t#3|)
                                                  (|List|
                                                   (|NonNegativeInteger|))))
                                                T)
                                               ((|monomials| ((|List| $) $)) T)
                                               ((|mainVariable|
                                                 ((|Union| |t#3| "failed") $))
                                                T)
                                               ((|monomial|
                                                 ($ $ |t#3|
                                                  (|NonNegativeInteger|)))
                                                T)
                                               ((|monomial|
                                                 ($ $ (|List| |t#3|)
                                                  (|List|
                                                   (|NonNegativeInteger|))))
                                                T)
                                               ((|totalDegree|
                                                 ((|NonNegativeInteger|) $))
                                                T)
                                               ((|totalDegree|
                                                 ((|NonNegativeInteger|) $
                                                  (|List| |t#3|)))
                                                T)
                                               ((|totalDegreeSorted|
                                                 ((|NonNegativeInteger|) $
                                                  (|List| |t#3|)))
                                                T)
                                               ((|variables|
                                                 ((|List| |t#3|) $))
                                                T)
                                               ((|primitiveMonomials|
                                                 ((|List| $) $))
                                                (|has| |t#1| (|SemiRing|))))
                                             '(((|FullyLinearlyExplicitOver|
                                                 |t#1|)
                                                (|has| |t#1| (|Ring|)))
                                               ((|Comparable|)
                                                (|has| |t#1| (|Comparable|)))
                                               ((|canonicalUnitNormal|)
                                                (|has| |t#1|
                                                       (|canonicalUnitNormal|))))
                                             NIL NIL)))))))
           (SETELT #1# 0
                   (LIST '|MaybeSkewPolynomialCategory| |t#1| |t#2| |t#3|))))) 
