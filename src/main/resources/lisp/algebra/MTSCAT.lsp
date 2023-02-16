
(DEFPARAMETER |MultivariateTaylorSeriesCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |MultivariateTaylorSeriesCategory;|)) 

(DEFPARAMETER |MultivariateTaylorSeriesCategory;AL| 'NIL) 

(DEFUN |MultivariateTaylorSeriesCategory| (|t#1| |t#2|)
  (LET (#1=#:G691 (#2=#:G692 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND
     ((SETQ #1# (|assoc| #2# |MultivariateTaylorSeriesCategory;AL|)) (CDR #1#))
     (T
      (SETQ |MultivariateTaylorSeriesCategory;AL|
              (|cons5|
               (CONS #2#
                     (SETQ #1#
                             (APPLY #'|MultivariateTaylorSeriesCategory;|
                                    #2#)))
               |MultivariateTaylorSeriesCategory;AL|))
      #1#)))) 

(DEFUN |MultivariateTaylorSeriesCategory;| (|t#1| |t#2|)
  (SPROG ((#1=#:G690 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (|subst_in_cat| '(#2=#:G689)
                                                   (LIST
                                                    '(|IndexedExponents|
                                                      |t#2|))
                                                   (COND
                                                    (|MultivariateTaylorSeriesCategory;CAT|)
                                                    ('T
                                                     (LETT
                                                      |MultivariateTaylorSeriesCategory;CAT|
                                                      (|Join|
                                                       (|PartialDifferentialRing|
                                                        '|t#2|)
                                                       (|PowerSeriesCategory|
                                                        '|t#1| '#2# '|t#2|)
                                                       (|InnerEvalable| '|t#2|
                                                                        '$)
                                                       (|Evalable| '$)
                                                       (|mkCategory|
                                                        '(((|coefficient|
                                                            ($ $ |t#2|
                                                             (|NonNegativeInteger|)))
                                                           T)
                                                          ((|coefficient|
                                                            ($ $ (|List| |t#2|)
                                                             (|List|
                                                              (|NonNegativeInteger|))))
                                                           T)
                                                          ((|extend|
                                                            ($ $
                                                             (|NonNegativeInteger|)))
                                                           T)
                                                          ((|monomial|
                                                            ($ $ |t#2|
                                                             (|NonNegativeInteger|)))
                                                           T)
                                                          ((|monomial|
                                                            ($ $ (|List| |t#2|)
                                                             (|List|
                                                              (|NonNegativeInteger|))))
                                                           T)
                                                          ((|order|
                                                            ((|NonNegativeInteger|)
                                                             $ |t#2|))
                                                           T)
                                                          ((|order|
                                                            ((|NonNegativeInteger|)
                                                             $ |t#2|
                                                             (|NonNegativeInteger|)))
                                                           T)
                                                          ((|polynomial|
                                                            ((|Polynomial|
                                                              |t#1|)
                                                             $
                                                             (|NonNegativeInteger|)))
                                                           T)
                                                          ((|polynomial|
                                                            ((|Polynomial|
                                                              |t#1|)
                                                             $
                                                             (|NonNegativeInteger|)
                                                             (|NonNegativeInteger|)))
                                                           T)
                                                          ((|integrate|
                                                            ($ $ |t#2|))
                                                           (|has| |t#1|
                                                                  (|Algebra|
                                                                   (|Fraction|
                                                                    (|Integer|))))))
                                                        '(((|RadicalCategory|)
                                                           (|has| |t#1|
                                                                  (|Algebra|
                                                                   (|Fraction|
                                                                    (|Integer|)))))
                                                          ((|TranscendentalFunctionCategory|)
                                                           (|has| |t#1|
                                                                  (|Algebra|
                                                                   (|Fraction|
                                                                    (|Integer|))))))
                                                        NIL NIL))))))))
           (SETELT #1# 0
                   (LIST '|MultivariateTaylorSeriesCategory| |t#1| |t#2|))))) 
