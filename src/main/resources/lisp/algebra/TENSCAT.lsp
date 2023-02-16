
(DEFPARAMETER |TensorProductCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |TensorProductCategory;|)) 

(DEFPARAMETER |TensorProductCategory;AL| 'NIL) 

(DEFUN |TensorProductCategory| (|t#1| |t#2| |t#3|)
  (LET (#1=#:G690
        (#2=#:G691
         (LIST (|devaluate| |t#1|) (|devaluate| |t#2|) (|devaluate| |t#3|))))
    (COND ((SETQ #1# (|assoc| #2# |TensorProductCategory;AL|)) (CDR #1#))
          (T
           (SETQ |TensorProductCategory;AL|
                   (|cons5|
                    (CONS #2#
                          (SETQ #1# (APPLY #'|TensorProductCategory;| #2#)))
                    |TensorProductCategory;AL|))
           #1#)))) 

(DEFUN |TensorProductCategory;| (|t#1| |t#2| |t#3|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2| |t#3|)
                                   (LIST |t#1| |t#2| |t#3|)
                                   (COND (|TensorProductCategory;CAT|)
                                         ('T
                                          (LETT |TensorProductCategory;CAT|
                                                (|Join| (|Module| '|t#1|)
                                                        (|mkCategory|
                                                         '(((|tensor|
                                                             ($ |t#2| |t#3|))
                                                            T))
                                                         NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|TensorProductCategory| |t#1| |t#2| |t#3|))))) 
