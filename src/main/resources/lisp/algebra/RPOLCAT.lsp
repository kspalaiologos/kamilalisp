
(DEFPARAMETER |RecursivePolynomialCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |RecursivePolynomialCategory;|)) 

(DEFPARAMETER |RecursivePolynomialCategory;AL| 'NIL) 

(DEFUN |RecursivePolynomialCategory| (|t#1| |t#2| |t#3|)
  (LET (#1=#:G825
        (#2=#:G826
         (LIST (|devaluate| |t#1|) (|devaluate| |t#2|) (|devaluate| |t#3|))))
    (COND ((SETQ #1# (|assoc| #2# |RecursivePolynomialCategory;AL|)) (CDR #1#))
          (T
           (SETQ |RecursivePolynomialCategory;AL|
                   (|cons5|
                    (CONS #2#
                          (SETQ #1#
                                  (APPLY #'|RecursivePolynomialCategory;|
                                         #2#)))
                    |RecursivePolynomialCategory;AL|))
           #1#)))) 

(DEFUN |RecursivePolynomialCategory;| (|t#1| |t#2| |t#3|)
  (SPROG ((#1=#:G824 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2| |t#3|)
                                   (LIST |t#1| |t#2| |t#3|)
                                   (COND (|RecursivePolynomialCategory;CAT|)
                                         ('T
                                          (LETT
                                           |RecursivePolynomialCategory;CAT|
                                           (|Join|
                                            (|PolynomialCategory| '|t#1| '|t#2|
                                                                  '|t#3|)
                                            (|mkCategory|
                                             '(((|mvar| (|t#3| $)) T)
                                               ((|mdeg|
                                                 ((|NonNegativeInteger|) $))
                                                T)
                                               ((|init| ($ $)) T)
                                               ((|head| ($ $)) T)
                                               ((|tail| ($ $)) T)
                                               ((|deepestTail| ($ $)) T)
                                               ((|iteratedInitials|
                                                 ((|List| $) $))
                                                T)
                                               ((|deepestInitial| ($ $)) T)
                                               ((|leadingCoefficient|
                                                 ($ $ |t#3|))
                                                T)
                                               ((|reductum| ($ $ |t#3|)) T)
                                               ((|monic?| ((|Boolean|) $)) T)
                                               ((|quasiMonic?| ((|Boolean|) $))
                                                T)
                                               ((|mainMonomial| ($ $)) T)
                                               ((|leastMonomial| ($ $)) T)
                                               ((|mainCoefficients|
                                                 ((|List| $) $))
                                                T)
                                               ((|mainMonomials|
                                                 ((|List| $) $))
                                                T)
                                               ((|RittWuCompare|
                                                 ((|Union| (|Boolean|)
                                                           "failed")
                                                  $ $))
                                                T)
                                               ((|infRittWu?|
                                                 ((|Boolean|) $ $))
                                                T)
                                               ((|supRittWu?|
                                                 ((|Boolean|) $ $))
                                                T)
                                               ((|reduced?| ((|Boolean|) $ $))
                                                T)
                                               ((|reduced?|
                                                 ((|Boolean|) $ (|List| $)))
                                                T)
                                               ((|headReduced?|
                                                 ((|Boolean|) $ $))
                                                T)
                                               ((|headReduced?|
                                                 ((|Boolean|) $ (|List| $)))
                                                T)
                                               ((|initiallyReduced?|
                                                 ((|Boolean|) $ $))
                                                T)
                                               ((|initiallyReduced?|
                                                 ((|Boolean|) $ (|List| $)))
                                                T)
                                               ((|normalized?|
                                                 ((|Boolean|) $ $))
                                                T)
                                               ((|normalized?|
                                                 ((|Boolean|) $ (|List| $)))
                                                T)
                                               ((|prem| ($ $ $)) T)
                                               ((|pquo| ($ $ $)) T)
                                               ((|prem| ($ $ $ |t#3|)) T)
                                               ((|pquo| ($ $ $ |t#3|)) T)
                                               ((|lazyPrem| ($ $ $)) T)
                                               ((|lazyPquo| ($ $ $)) T)
                                               ((|lazyPrem| ($ $ $ |t#3|)) T)
                                               ((|lazyPquo| ($ $ $ |t#3|)) T)
                                               ((|lazyPremWithDefault|
                                                 ((|Record| (|:| |coef| $)
                                                            (|:| |gap|
                                                                 (|NonNegativeInteger|))
                                                            (|:| |remainder|
                                                                 $))
                                                  $ $))
                                                T)
                                               ((|lazyPremWithDefault|
                                                 ((|Record| (|:| |coef| $)
                                                            (|:| |gap|
                                                                 (|NonNegativeInteger|))
                                                            (|:| |remainder|
                                                                 $))
                                                  $ $ |t#3|))
                                                T)
                                               ((|lazyPseudoDivide|
                                                 ((|Record| (|:| |coef| $)
                                                            (|:| |gap|
                                                                 (|NonNegativeInteger|))
                                                            (|:| |quotient| $)
                                                            (|:| |remainder|
                                                                 $))
                                                  $ $))
                                                T)
                                               ((|lazyPseudoDivide|
                                                 ((|Record| (|:| |coef| $)
                                                            (|:| |gap|
                                                                 (|NonNegativeInteger|))
                                                            (|:| |quotient| $)
                                                            (|:| |remainder|
                                                                 $))
                                                  $ $ |t#3|))
                                                T)
                                               ((|pseudoDivide|
                                                 ((|Record| (|:| |quotient| $)
                                                            (|:| |remainder|
                                                                 $))
                                                  $ $))
                                                T)
                                               ((|monicModulo| ($ $ $)) T)
                                               ((|lazyResidueClass|
                                                 ((|Record| (|:| |polnum| $)
                                                            (|:| |polden| $)
                                                            (|:| |power|
                                                                 (|NonNegativeInteger|)))
                                                  $ $))
                                                T)
                                               ((|headReduce| ($ $ $)) T)
                                               ((|initiallyReduce| ($ $ $)) T)
                                               ((|retractIfCan|
                                                 ((|Union| $ "failed")
                                                  (|Polynomial|
                                                   (|Fraction| (|Integer|)))))
                                                (AND
                                                 (|has| |t#1|
                                                        (|Algebra|
                                                         (|Fraction|
                                                          (|Integer|))))
                                                 (|has| |t#3|
                                                        (|ConvertibleTo|
                                                         (|Symbol|)))))
                                               ((|retract|
                                                 ($
                                                  (|Polynomial|
                                                   (|Fraction| (|Integer|)))))
                                                (AND
                                                 (|has| |t#1|
                                                        (|Algebra|
                                                         (|Fraction|
                                                          (|Integer|))))
                                                 (|has| |t#3|
                                                        (|ConvertibleTo|
                                                         (|Symbol|)))))
                                               ((|convert|
                                                 ($
                                                  (|Polynomial|
                                                   (|Fraction| (|Integer|)))))
                                                (AND
                                                 (|has| |t#1|
                                                        (|Algebra|
                                                         (|Fraction|
                                                          (|Integer|))))
                                                 (|has| |t#3|
                                                        (|ConvertibleTo|
                                                         (|Symbol|)))))
                                               ((|retractIfCan|
                                                 ((|Union| $ "failed")
                                                  (|Polynomial| (|Integer|))))
                                                (AND
                                                 (|has| |t#1|
                                                        (|Algebra|
                                                         (|Integer|)))
                                                 (|has| |t#3|
                                                        (|ConvertibleTo|
                                                         (|Symbol|)))))
                                               ((|retract|
                                                 ($
                                                  (|Polynomial| (|Integer|))))
                                                (AND
                                                 (|has| |t#1|
                                                        (|Algebra|
                                                         (|Integer|)))
                                                 (|has| |t#3|
                                                        (|ConvertibleTo|
                                                         (|Symbol|)))))
                                               ((|convert|
                                                 ($
                                                  (|Polynomial| (|Integer|))))
                                                (AND
                                                 (|has| |t#1|
                                                        (|Algebra|
                                                         (|Integer|)))
                                                 (|has| |t#3|
                                                        (|ConvertibleTo|
                                                         (|Symbol|)))))
                                               ((|retractIfCan|
                                                 ((|Union| $ "failed")
                                                  (|Polynomial| |t#1|)))
                                                (|has| |t#3|
                                                       (|ConvertibleTo|
                                                        (|Symbol|))))
                                               ((|retract|
                                                 ($ (|Polynomial| |t#1|)))
                                                (|has| |t#3|
                                                       (|ConvertibleTo|
                                                        (|Symbol|))))
                                               ((|convert|
                                                 ($ (|Polynomial| |t#1|)))
                                                (|has| |t#3|
                                                       (|ConvertibleTo|
                                                        (|Symbol|))))
                                               ((|primPartElseUnitCanonical|
                                                 ($ $))
                                                (|has| |t#1|
                                                       (|IntegralDomain|)))
                                               ((|primPartElseUnitCanonical!|
                                                 ($ $))
                                                (|has| |t#1|
                                                       (|IntegralDomain|)))
                                               ((|exactQuotient| ($ $ |t#1|))
                                                (|has| |t#1|
                                                       (|IntegralDomain|)))
                                               ((|exactQuotient!| ($ $ |t#1|))
                                                (|has| |t#1|
                                                       (|IntegralDomain|)))
                                               ((|exactQuotient| ($ $ $))
                                                (|has| |t#1|
                                                       (|IntegralDomain|)))
                                               ((|exactQuotient!| ($ $ $))
                                                (|has| |t#1|
                                                       (|IntegralDomain|)))
                                               ((|subResultantGcd| ($ $ $))
                                                (|has| |t#1|
                                                       (|IntegralDomain|)))
                                               ((|extendedSubResultantGcd|
                                                 ((|Record| (|:| |gcd| $)
                                                            (|:| |coef1| $)
                                                            (|:| |coef2| $))
                                                  $ $))
                                                (|has| |t#1|
                                                       (|IntegralDomain|)))
                                               ((|halfExtendedSubResultantGcd1|
                                                 ((|Record| (|:| |gcd| $)
                                                            (|:| |coef1| $))
                                                  $ $))
                                                (|has| |t#1|
                                                       (|IntegralDomain|)))
                                               ((|halfExtendedSubResultantGcd2|
                                                 ((|Record| (|:| |gcd| $)
                                                            (|:| |coef2| $))
                                                  $ $))
                                                (|has| |t#1|
                                                       (|IntegralDomain|)))
                                               ((|resultant| ($ $ $))
                                                (|has| |t#1|
                                                       (|IntegralDomain|)))
                                               ((|subResultantChain|
                                                 ((|List| $) $ $))
                                                (|has| |t#1|
                                                       (|IntegralDomain|)))
                                               ((|lastSubResultant| ($ $ $))
                                                (|has| |t#1|
                                                       (|IntegralDomain|)))
                                               ((|LazardQuotient|
                                                 ($ $ $
                                                  (|NonNegativeInteger|)))
                                                (|has| |t#1|
                                                       (|IntegralDomain|)))
                                               ((|LazardQuotient2|
                                                 ($ $ $ $
                                                  (|NonNegativeInteger|)))
                                                (|has| |t#1|
                                                       (|IntegralDomain|)))
                                               ((|next_subResultant2|
                                                 ($ $ $ $ $))
                                                (|has| |t#1|
                                                       (|IntegralDomain|)))
                                               ((|iexactQuo|
                                                 (|t#1| |t#1| |t#1|))
                                                (|has| |t#1|
                                                       (|IntegralDomain|)))
                                               ((|gcd| (|t#1| |t#1| $))
                                                (|has| |t#1| (|GcdDomain|)))
                                               ((|primitivePart!| ($ $))
                                                (|has| |t#1| (|GcdDomain|)))
                                               ((|mainContent| ($ $))
                                                (|has| |t#1| (|GcdDomain|)))
                                               ((|mainPrimitivePart| ($ $))
                                                (|has| |t#1| (|GcdDomain|)))
                                               ((|mainSquareFreePart| ($ $))
                                                (|has| |t#1| (|GcdDomain|))))
                                             '(((|CoercibleTo|
                                                 (|Polynomial| |t#1|))
                                                (|has| |t#3|
                                                       (|ConvertibleTo|
                                                        (|Symbol|))))
                                               ((|ConvertibleTo|
                                                 (|Polynomial| |t#1|))
                                                (|has| |t#3|
                                                       (|ConvertibleTo|
                                                        (|Symbol|))))
                                               ((|ConvertibleTo| (|String|))
                                                (AND
                                                 (|has| |t#1|
                                                        (|RetractableTo|
                                                         (|Integer|)))
                                                 (|has| |t#3|
                                                        (|ConvertibleTo|
                                                         (|Symbol|))))))
                                             NIL NIL)))))))
           (SETELT #1# 0
                   (LIST '|RecursivePolynomialCategory| |t#1| |t#2| |t#3|))))) 
