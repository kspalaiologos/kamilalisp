
(DEFPARAMETER |Bialgebra;CAT| 'NIL) 

(DECLAIM (NOTINLINE |Bialgebra;|)) 

(DEFPARAMETER |Bialgebra;AL| 'NIL) 

(DEFUN |Bialgebra| (|t#1| |t#2|)
  (LET (#1=#:G690 (#2=#:G691 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND ((SETQ #1# (|assoc| #2# |Bialgebra;AL|)) (CDR #1#))
          (T
           (SETQ |Bialgebra;AL|
                   (|cons5| (CONS #2# (SETQ #1# (APPLY #'|Bialgebra;| #2#)))
                            |Bialgebra;AL|))
           #1#)))) 

(DEFUN |Bialgebra;| (|t#1| |t#2|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (COND (|Bialgebra;CAT|)
                                         ('T
                                          (LETT |Bialgebra;CAT|
                                                (|Join| (|Algebra| '|t#1|)
                                                        (|Coalgebra| '|t#1|
                                                                     '|t#2|)))))))
           (SETELT #1# 0 (LIST '|Bialgebra| |t#1| |t#2|))))) 
