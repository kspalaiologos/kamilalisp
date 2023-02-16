
(DECLAIM (NOTINLINE |TaylorSeriesExpansion;|)) 

(DEFPARAMETER |TaylorSeriesExpansion;AL| 'NIL) 

(DEFUN |TaylorSeriesExpansion| (|t#1| |t#2| |t#3| |t#4| |t#5|)
  (LET (#1=#:G690
        (#2=#:G691
         (LIST (|devaluate| |t#1|) (|devaluate| |t#2|) (|devaluate| |t#3|)
               (|devaluate| |t#4|) (|devaluate| |t#5|))))
    (COND ((SETQ #1# (|assoc| #2# |TaylorSeriesExpansion;AL|)) (CDR #1#))
          (T
           (SETQ |TaylorSeriesExpansion;AL|
                   (|cons5|
                    (CONS #2#
                          (SETQ #1# (APPLY #'|TaylorSeriesExpansion;| #2#)))
                    |TaylorSeriesExpansion;AL|))
           #1#)))) 

(DEFUN |TaylorSeriesExpansion;| (|t#1| |t#2| |t#3| |t#4| |t#5|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2| |t#3| |t#4| |t#5|)
                                   (LIST |t#1| |t#2| |t#3| |t#4| |t#5|)
                                   (|Join|
                                    (|mkCategory|
                                     '(((|taylor_via_deriv|
                                         (|t#4| |t#1| (|List| |t#4|)
                                          (|List| (|Mapping| |t#1| |t#1|))))
                                        T)
                                       ((|taylor_via_deriv|
                                         (|t#4| |t#4| (|List| |t#4|)
                                          (|List| (|Mapping| |t#1| |t#1|))))
                                        T)
                                       ((|taylor_via_lode|
                                         (|t#4| (|List| |t#5|) |t#4|
                                          (|List| |t#1|)))
                                        T)
                                       ((|applyTaylor|
                                         (|t#4| (|Mapping| |t#5| |t#5|) |t#4|))
                                        T)
                                       ((|apply_taylor| (|t#4| |t#5| |t#4|))
                                        T))
                                     NIL NIL NIL))))
           (SETELT #1# 0
                   (LIST '|TaylorSeriesExpansion| |t#1| |t#2| |t#3| |t#4|
                         |t#5|))))) 
