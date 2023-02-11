
(DEFPARAMETER |UnivariatePuiseuxSeriesConstructorCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |UnivariatePuiseuxSeriesConstructorCategory;|)) 

(DEFPARAMETER |UnivariatePuiseuxSeriesConstructorCategory;AL| 'NIL) 

(DEFUN |UnivariatePuiseuxSeriesConstructorCategory| (|t#1| |t#2|)
  (LET (#1=#:G690 (#2=#:G691 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND
     ((SETQ #1# (|assoc| #2# |UnivariatePuiseuxSeriesConstructorCategory;AL|))
      (CDR #1#))
     (T
      (SETQ |UnivariatePuiseuxSeriesConstructorCategory;AL|
              (|cons5|
               (CONS #2#
                     (SETQ #1#
                             (APPLY
                              #'|UnivariatePuiseuxSeriesConstructorCategory;|
                              #2#)))
               |UnivariatePuiseuxSeriesConstructorCategory;AL|))
      #1#)))) 

(DEFUN |UnivariatePuiseuxSeriesConstructorCategory;| (|t#1| |t#2|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (COND
                                    (|UnivariatePuiseuxSeriesConstructorCategory;CAT|)
                                    ('T
                                     (LETT
                                      |UnivariatePuiseuxSeriesConstructorCategory;CAT|
                                      (|Join|
                                       (|UnivariatePuiseuxSeriesCategory|
                                        '|t#1|)
                                       (|RetractableTo| '|t#2|)
                                       (|mkCategory|
                                        '(((|puiseux|
                                            ($ (|Fraction| (|Integer|)) |t#2|))
                                           T)
                                          ((|rationalPower|
                                            ((|Fraction| (|Integer|)) $))
                                           T)
                                          ((|laurentRep| (|t#2| $)) T)
                                          ((|degree|
                                            ((|Fraction| (|Integer|)) $))
                                           T)
                                          ((|coerce| ($ |t#2|)) T)
                                          ((|laurent| (|t#2| $)) T)
                                          ((|laurentIfCan|
                                            ((|Union| |t#2| "failed") $))
                                           T))
                                        NIL NIL NIL)))))))
           (SETELT #1# 0
                   (LIST '|UnivariatePuiseuxSeriesConstructorCategory| |t#1|
                         |t#2|))))) 
