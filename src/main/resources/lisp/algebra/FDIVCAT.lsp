
(DEFPARAMETER |FiniteDivisorCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |FiniteDivisorCategory;|)) 

(DEFPARAMETER |FiniteDivisorCategory;AL| 'NIL) 

(DEFUN |FiniteDivisorCategory| (|t#1| |t#2| |t#3| |t#4|)
  (LET (#1=#:G690
        (#2=#:G691
         (LIST (|devaluate| |t#1|) (|devaluate| |t#2|) (|devaluate| |t#3|)
               (|devaluate| |t#4|))))
    (COND ((SETQ #1# (|assoc| #2# |FiniteDivisorCategory;AL|)) (CDR #1#))
          (T
           (SETQ |FiniteDivisorCategory;AL|
                   (|cons5|
                    (CONS #2#
                          (SETQ #1# (APPLY #'|FiniteDivisorCategory;| #2#)))
                    |FiniteDivisorCategory;AL|))
           #1#)))) 

(DEFUN |FiniteDivisorCategory;| (|t#1| |t#2| |t#3| |t#4|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2| |t#3| |t#4|)
                                   (LIST |t#1| |t#2| |t#3| |t#4|)
                                   (COND (|FiniteDivisorCategory;CAT|)
                                         ('T
                                          (LETT |FiniteDivisorCategory;CAT|
                                                (|Join| (|AbelianGroup|)
                                                        (|mkCategory|
                                                         '(((|ideal|
                                                             ((|FractionalIdeal|
                                                               |t#2|
                                                               (|Fraction|
                                                                |t#2|)
                                                               |t#3| |t#4|)
                                                              $))
                                                            T)
                                                           ((|divisor|
                                                             ($
                                                              (|FractionalIdeal|
                                                               |t#2|
                                                               (|Fraction|
                                                                |t#2|)
                                                               |t#3| |t#4|)))
                                                            T)
                                                           ((|divisor|
                                                             ($ |t#4|))
                                                            T)
                                                           ((|divisor|
                                                             ($ |t#1| |t#1|))
                                                            T)
                                                           ((|divisor|
                                                             ($ |t#1| |t#1|
                                                              (|Integer|)))
                                                            T)
                                                           ((|decompose|
                                                             ((|Record|
                                                               (|:| |id|
                                                                    (|FractionalIdeal|
                                                                     |t#2|
                                                                     (|Fraction|
                                                                      |t#2|)
                                                                     |t#3|
                                                                     |t#4|))
                                                               (|:|
                                                                |principalPart|
                                                                |t#4|))
                                                              $))
                                                            T)
                                                           ((|reduce| ($ $)) T)
                                                           ((|principal?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|generator|
                                                             ((|Union| |t#4|
                                                                       "failed")
                                                              $))
                                                            T)
                                                           ((|generator|
                                                             ((|Union| |t#4|
                                                                       "failed")
                                                              $ (|Integer|)
                                                              (|List| |t#2|)))
                                                            T)
                                                           ((|divisor|
                                                             ($ |t#4| |t#2|
                                                              |t#2|))
                                                            T)
                                                           ((|divisor|
                                                             ($ |t#4| |t#2|
                                                              |t#2| |t#2|
                                                              |t#1|))
                                                            T))
                                                         NIL NIL NIL)))))))
           (SETELT #1# 0
                   (LIST '|FiniteDivisorCategory| |t#1| |t#2| |t#3| |t#4|))))) 
