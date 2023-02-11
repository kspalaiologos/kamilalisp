
(DEFPARAMETER |UnivariateSeriesWithRationalExponents;CAT| 'NIL) 

(DECLAIM (NOTINLINE |UnivariateSeriesWithRationalExponents;|)) 

(DEFPARAMETER |UnivariateSeriesWithRationalExponents;AL| 'NIL) 

(DEFUN |UnivariateSeriesWithRationalExponents| (|t#1| |t#2|)
  (LET (#1=#:G690 (#2=#:G691 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND
     ((SETQ #1# (|assoc| #2# |UnivariateSeriesWithRationalExponents;AL|))
      (CDR #1#))
     (T
      (SETQ |UnivariateSeriesWithRationalExponents;AL|
              (|cons5|
               (CONS #2#
                     (SETQ #1#
                             (APPLY #'|UnivariateSeriesWithRationalExponents;|
                                    #2#)))
               |UnivariateSeriesWithRationalExponents;AL|))
      #1#)))) 

(DEFUN |UnivariateSeriesWithRationalExponents;| (|t#1| |t#2|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (COND
                                    (|UnivariateSeriesWithRationalExponents;CAT|)
                                    ('T
                                     (LETT
                                      |UnivariateSeriesWithRationalExponents;CAT|
                                      (|Join|
                                       (|UnivariatePowerSeriesCategory| '|t#1|
                                                                        '|t#2|)
                                       (|mkCategory|
                                        '(((|integrate| ($ $))
                                           (|has| |t#1|
                                                  (|Algebra|
                                                   (|Fraction| (|Integer|)))))
                                          ((|integrate| ($ $ (|Symbol|)))
                                           (AND
                                            (|has| |t#1|
                                                   (SIGNATURE |variables|
                                                    ((|List| (|Symbol|))
                                                     |t#1|)))
                                            (|has| |t#1|
                                                   (SIGNATURE |integrate|
                                                    (|t#1| |t#1| (|Symbol|))))
                                            (|has| |t#1|
                                                   (|Algebra|
                                                    (|Fraction|
                                                     (|Integer|)))))))
                                        '(((|RadicalCategory|)
                                           (|has| |t#1|
                                                  (|Algebra|
                                                   (|Fraction| (|Integer|)))))
                                          ((|TranscendentalFunctionCategory|)
                                           (|has| |t#1|
                                                  (|Algebra|
                                                   (|Fraction| (|Integer|))))))
                                        NIL NIL)))))))
           (SETELT #1# 0
                   (LIST '|UnivariateSeriesWithRationalExponents| |t#1|
                         |t#2|))))) 
