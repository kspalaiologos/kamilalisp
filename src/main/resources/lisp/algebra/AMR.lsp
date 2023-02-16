
(DEFPARAMETER |AbelianMonoidRing;CAT| 'NIL) 

(DECLAIM (NOTINLINE |AbelianMonoidRing;|)) 

(DEFPARAMETER |AbelianMonoidRing;AL| 'NIL) 

(DEFUN |AbelianMonoidRing| (|t#1| |t#2|)
  (LET (#1=#:G693 (#2=#:G694 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND ((SETQ #1# (|assoc| #2# |AbelianMonoidRing;AL|)) (CDR #1#))
          (T
           (SETQ |AbelianMonoidRing;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (APPLY #'|AbelianMonoidRing;| #2#)))
                    |AbelianMonoidRing;AL|))
           #1#)))) 

(DEFUN |AbelianMonoidRing;| (|t#1| |t#2|)
  (SPROG ((#1=#:G692 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (COND (|AbelianMonoidRing;CAT|)
                                         ('T
                                          (LETT |AbelianMonoidRing;CAT|
                                                (|Join| (|SemiRng|)
                                                        (|BiModule| '|t#1|
                                                                    '|t#1|)
                                                        (|IndexedProductCategory|
                                                         '|t#1| '|t#2|)
                                                        (|mkCategory|
                                                         '(((|degree|
                                                             (|t#2| $))
                                                            T)
                                                           ((|coefficient|
                                                             (|t#1| $ |t#2|))
                                                            T)
                                                           ((/ ($ $ |t#1|))
                                                            (|has| |t#1|
                                                                   (|Field|))))
                                                         '(((|SemiRing|)
                                                            (|has| |t#1|
                                                                   (|SemiRing|)))
                                                           ((|Ring|)
                                                            (|has| |t#1|
                                                                   (|Ring|)))
                                                           ((|CommutativeRing|)
                                                            (AND
                                                             (|has| |t#1|
                                                                    (|CommutativeRing|))
                                                             (|has| $
                                                                    (|VariablesCommuteWithCoefficients|))))
                                                           ((|Algebra| |t#1|)
                                                            (AND
                                                             (|has| |t#1|
                                                                    (|CommutativeRing|))
                                                             (|has| $
                                                                    (|VariablesCommuteWithCoefficients|))))
                                                           ((|CharacteristicZero|)
                                                            (|has| |t#1|
                                                                   (|CharacteristicZero|)))
                                                           ((|CharacteristicNonZero|)
                                                            (|has| |t#1|
                                                                   (|CharacteristicNonZero|)))
                                                           ((|IntegralDomain|)
                                                            (AND
                                                             (|has| |t#1|
                                                                    (|IntegralDomain|))
                                                             (|has| $
                                                                    (|VariablesCommuteWithCoefficients|))))
                                                           ((|Algebra|
                                                             (|Fraction|
                                                              (|Integer|)))
                                                            (|has| |t#1|
                                                                   (|Algebra|
                                                                    (|Fraction|
                                                                     (|Integer|))))))
                                                         NIL NIL)))))))
           (SETELT #1# 0 (LIST '|AbelianMonoidRing| |t#1| |t#2|))))) 
