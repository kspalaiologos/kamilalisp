
(DEFPARAMETER |FiniteRankAlgebra;CAT| 'NIL) 

(DECLAIM (NOTINLINE |FiniteRankAlgebra;|)) 

(DEFPARAMETER |FiniteRankAlgebra;AL| 'NIL) 

(DEFUN |FiniteRankAlgebra| (|t#1| |t#2|)
  (LET (#1=#:G690 (#2=#:G691 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND ((SETQ #1# (|assoc| #2# |FiniteRankAlgebra;AL|)) (CDR #1#))
          (T
           (SETQ |FiniteRankAlgebra;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (APPLY #'|FiniteRankAlgebra;| #2#)))
                    |FiniteRankAlgebra;AL|))
           #1#)))) 

(DEFUN |FiniteRankAlgebra;| (|t#1| |t#2|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (COND (|FiniteRankAlgebra;CAT|)
                                         ('T
                                          (LETT |FiniteRankAlgebra;CAT|
                                                (|Join| (|Algebra| '|t#1|)
                                                        (|TwoSidedRecip|)
                                                        (|mkCategory|
                                                         '(((|rank|
                                                             ((|PositiveInteger|)))
                                                            T)
                                                           ((|regularRepresentation|
                                                             ((|Matrix| |t#1|)
                                                              $ (|Vector| $)))
                                                            T)
                                                           ((|trace| (|t#1| $))
                                                            T)
                                                           ((|norm| (|t#1| $))
                                                            T)
                                                           ((|coordinates|
                                                             ((|Vector| |t#1|)
                                                              $ (|Vector| $)))
                                                            T)
                                                           ((|coordinates|
                                                             ((|Matrix| |t#1|)
                                                              (|Vector| $)
                                                              (|Vector| $)))
                                                            T)
                                                           ((|represents|
                                                             ($
                                                              (|Vector| |t#1|)
                                                              (|Vector| $)))
                                                            T)
                                                           ((|discriminant|
                                                             (|t#1|
                                                              (|Vector| $)))
                                                            T)
                                                           ((|traceMatrix|
                                                             ((|Matrix| |t#1|)
                                                              (|Vector| $)))
                                                            T)
                                                           ((|characteristicPolynomial|
                                                             (|t#2| $))
                                                            T)
                                                           ((|minimalPolynomial|
                                                             (|t#2| $))
                                                            (|has| |t#1|
                                                                   (|Field|))))
                                                         '(((|CharacteristicZero|)
                                                            (|has| |t#1|
                                                                   (|CharacteristicZero|)))
                                                           ((|CharacteristicNonZero|)
                                                            (|has| |t#1|
                                                                   (|CharacteristicNonZero|))))
                                                         NIL NIL)))))))
           (SETELT #1# 0 (LIST '|FiniteRankAlgebra| |t#1| |t#2|))))) 
