
(DEFPARAMETER |TensorPowerCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |TensorPowerCategory;|)) 

(DEFPARAMETER |TensorPowerCategory;AL| 'NIL) 

(DEFUN |TensorPowerCategory| (|t#1| |t#2| |t#3|)
  (LET (#1=#:G694
        (#2=#:G695 (LIST |t#1| (|devaluate| |t#2|) (|devaluate| |t#3|))))
    (COND ((SETQ #1# (|assoc| #2# |TensorPowerCategory;AL|)) (CDR #1#))
          (T
           (SETQ |TensorPowerCategory;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (APPLY #'|TensorPowerCategory;| #2#)))
                    |TensorPowerCategory;AL|))
           #1#)))) 

(DEFUN |TensorPowerCategory;| (|t#1| |t#2| |t#3|)
  (SPROG ((#1=#:G693 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2| |t#3|)
                                   (LIST |t#1| |t#2| |t#3|)
                                   (COND (|TensorPowerCategory;CAT|)
                                         ('T
                                          (LETT |TensorPowerCategory;CAT|
                                                (|Join| (|Module| '|t#2|)
                                                        (|mkCategory|
                                                         '(((|tensor|
                                                             ($
                                                              (|List| |t#3|)))
                                                            T))
                                                         '(((|Algebra| |t#2|)
                                                            (|has| |t#3|
                                                                   (|Algebra|
                                                                    |t#2|)))
                                                           ((|TensorProductCategory|
                                                             |t#2| |t#3| |t#3|)
                                                            T))
                                                         NIL NIL)))))))
           (SETELT #1# 0 (LIST '|TensorPowerCategory| |t#1| |t#2| |t#3|))))) 
