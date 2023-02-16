
(DEFPARAMETER |UnivariateLaurentSeriesCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |UnivariateLaurentSeriesCategory;|)) 

(DEFPARAMETER |UnivariateLaurentSeriesCategory;AL| 'NIL) 

(DEFUN |UnivariateLaurentSeriesCategory| (|t#1|)
  (LET (#1=#:G696 (#2=#:G697 (|devaluate| |t#1|)))
    (COND
     ((SETQ #1# (|assoc| #2# |UnivariateLaurentSeriesCategory;AL|)) (CDR #1#))
     (T
      (SETQ |UnivariateLaurentSeriesCategory;AL|
              (|cons5|
               (CONS #2# (SETQ #1# (|UnivariateLaurentSeriesCategory;| #2#)))
               |UnivariateLaurentSeriesCategory;AL|))
      #1#)))) 

(DEFUN |UnivariateLaurentSeriesCategory;| (|t#1|)
  (SPROG ((#1=#:G695 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (|subst_in_cat| '(#2=#:G694)
                                                   (LIST '(|Integer|))
                                                   (COND
                                                    (|UnivariateLaurentSeriesCategory;CAT|)
                                                    ('T
                                                     (LETT
                                                      |UnivariateLaurentSeriesCategory;CAT|
                                                      (|Join|
                                                       (|UnivariateSeriesWithRationalExponents|
                                                        '|t#1| '#2#)
                                                       (|mkCategory|
                                                        '(((|series|
                                                            ($
                                                             (|Stream|
                                                              (|Record|
                                                               (|:| |k|
                                                                    (|Integer|))
                                                               (|:| |c|
                                                                    |t#1|)))))
                                                           T)
                                                          ((|laurent|
                                                            ($ (|Integer|)
                                                             (|Stream| |t#1|)))
                                                           T)
                                                          ((|multiplyCoefficients|
                                                            ($
                                                             (|Mapping| |t#1|
                                                                        (|Integer|))
                                                             $))
                                                           T)
                                                          ((|rationalFunction|
                                                            ((|Fraction|
                                                              (|Polynomial|
                                                               |t#1|))
                                                             $ (|Integer|)))
                                                           (|has| |t#1|
                                                                  (|IntegralDomain|)))
                                                          ((|rationalFunction|
                                                            ((|Fraction|
                                                              (|Polynomial|
                                                               |t#1|))
                                                             $ (|Integer|)
                                                             (|Integer|)))
                                                           (|has| |t#1|
                                                                  (|IntegralDomain|))))
                                                        '(((|Field|)
                                                           (|has| |t#1|
                                                                  (|Field|))))
                                                        NIL NIL))))))))
           (SETELT #1# 0 (LIST '|UnivariateLaurentSeriesCategory| |t#1|))))) 
