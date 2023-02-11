
(DEFPARAMETER |GradedAlgebra;CAT| 'NIL) 

(DECLAIM (NOTINLINE |GradedAlgebra;|)) 

(DEFPARAMETER |GradedAlgebra;AL| 'NIL) 

(DEFUN |GradedAlgebra| (|t#1| |t#2|)
  (LET (#1=#:G690 (#2=#:G691 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND ((SETQ #1# (|assoc| #2# |GradedAlgebra;AL|)) (CDR #1#))
          (T
           (SETQ |GradedAlgebra;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (APPLY #'|GradedAlgebra;| #2#)))
                    |GradedAlgebra;AL|))
           #1#)))) 

(DEFUN |GradedAlgebra;| (|t#1| |t#2|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (COND (|GradedAlgebra;CAT|)
                                         ('T
                                          (LETT |GradedAlgebra;CAT|
                                                (|Join|
                                                 (|GradedModule| '|t#1| '|t#2|)
                                                 (|RetractableTo| '|t#1|)
                                                 (|mkCategory|
                                                  '(((|One| ($) |constant|) T)
                                                    ((|product| ($ $ $)) T))
                                                  NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|GradedAlgebra| |t#1| |t#2|))))) 
