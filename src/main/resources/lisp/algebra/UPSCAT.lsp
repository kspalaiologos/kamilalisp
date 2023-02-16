
(DEFPARAMETER |UnivariatePowerSeriesCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |UnivariatePowerSeriesCategory;|)) 

(DEFPARAMETER |UnivariatePowerSeriesCategory;AL| 'NIL) 

(DEFUN |UnivariatePowerSeriesCategory| (|t#1| |t#2|)
  (LET (#1=#:G691 (#2=#:G692 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND
     ((SETQ #1# (|assoc| #2# |UnivariatePowerSeriesCategory;AL|)) (CDR #1#))
     (T
      (SETQ |UnivariatePowerSeriesCategory;AL|
              (|cons5|
               (CONS #2#
                     (SETQ #1# (APPLY #'|UnivariatePowerSeriesCategory;| #2#)))
               |UnivariatePowerSeriesCategory;AL|))
      #1#)))) 

(DEFUN |UnivariatePowerSeriesCategory;| (|t#1| |t#2|)
  (SPROG ((#1=#:G690 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (|subst_in_cat| '(#2=#:G689)
                                                   (LIST
                                                    '(|SingletonAsOrderedSet|))
                                                   (COND
                                                    (|UnivariatePowerSeriesCategory;CAT|)
                                                    ('T
                                                     (LETT
                                                      |UnivariatePowerSeriesCategory;CAT|
                                                      (|Join|
                                                       (|PowerSeriesCategory|
                                                        '|t#1| '|t#2| '#2#)
                                                       (|mkCategory|
                                                        '(((|terms|
                                                            ((|Stream|
                                                              (|Record|
                                                               (|:| |k| |t#2|)
                                                               (|:| |c|
                                                                    |t#1|)))
                                                             $))
                                                           T)
                                                          ((|elt|
                                                            (|t#1| $ |t#2|))
                                                           T)
                                                          ((|variable|
                                                            ((|Symbol|) $))
                                                           T)
                                                          ((|center| (|t#1| $))
                                                           T)
                                                          ((|multiplyExponents|
                                                            ($ $
                                                             (|PositiveInteger|)))
                                                           T)
                                                          ((|order| (|t#2| $))
                                                           T)
                                                          ((|order|
                                                            (|t#2| $ |t#2|))
                                                           T)
                                                          ((|truncate|
                                                            ($ $ |t#2|))
                                                           T)
                                                          ((|truncate|
                                                            ($ $ |t#2| |t#2|))
                                                           T)
                                                          ((|approximate|
                                                            (|t#1| $ |t#2|))
                                                           (AND
                                                            (|has| |t#1|
                                                                   (SIGNATURE ^
                                                                    (|t#1|
                                                                     |t#1|
                                                                     |t#2|)))
                                                            (|has| |t#1|
                                                                   (SIGNATURE
                                                                    |coerce|
                                                                    (|t#1|
                                                                     (|Symbol|))))))
                                                          ((|extend|
                                                            ($ $ |t#2|))
                                                           T)
                                                          ((|eval|
                                                            ((|Stream| |t#1|) $
                                                             |t#1|))
                                                           (|has| |t#1|
                                                                  (SIGNATURE ^
                                                                   (|t#1| |t#1|
                                                                    |t#2|)))))
                                                        '(((|Eltable| $ $)
                                                           (|has| |t#2|
                                                                  (|SemiGroup|)))
                                                          ((|DifferentialRing|)
                                                           (|has| |t#1|
                                                                  (SIGNATURE *
                                                                   (|t#1| |t#2|
                                                                    |t#1|))))
                                                          ((|PartialDifferentialRing|
                                                            (|Symbol|))
                                                           (AND
                                                            (|has| |t#1|
                                                                   (|PartialDifferentialRing|
                                                                    (|Symbol|)))
                                                            (|has| |t#1|
                                                                   (SIGNATURE *
                                                                    (|t#1|
                                                                     |t#2|
                                                                     |t#1|))))))
                                                        NIL NIL))))))))
           (SETELT #1# 0 (LIST '|UnivariatePowerSeriesCategory| |t#1| |t#2|))))) 
