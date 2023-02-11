
(DEFPARAMETER |Coalgebra;CAT| 'NIL) 

(DECLAIM (NOTINLINE |Coalgebra;|)) 

(DEFPARAMETER |Coalgebra;AL| 'NIL) 

(DEFUN |Coalgebra| (|t#1| |t#2|)
  (LET (#1=#:G690 (#2=#:G691 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND ((SETQ #1# (|assoc| #2# |Coalgebra;AL|)) (CDR #1#))
          (T
           (SETQ |Coalgebra;AL|
                   (|cons5| (CONS #2# (SETQ #1# (APPLY #'|Coalgebra;| #2#)))
                            |Coalgebra;AL|))
           #1#)))) 

(DEFUN |Coalgebra;| (|t#1| |t#2|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (COND (|Coalgebra;CAT|)
                                         ('T
                                          (LETT |Coalgebra;CAT|
                                                (|Join| (|Module| '|t#1|)
                                                        (|mkCategory|
                                                         '(((|coproduct|
                                                             (|t#2| $))
                                                            T)
                                                           ((|counit|
                                                             (|t#1| $))
                                                            T))
                                                         NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|Coalgebra| |t#1| |t#2|))))) 
