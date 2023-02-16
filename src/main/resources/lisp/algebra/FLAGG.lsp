
(DEFPARAMETER |FiniteLinearAggregate;CAT| 'NIL) 

(DECLAIM (NOTINLINE |FiniteLinearAggregate;|)) 

(DEFPARAMETER |FiniteLinearAggregate;AL| 'NIL) 

(DEFUN |FiniteLinearAggregate| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |FiniteLinearAggregate;AL|)) (CDR #1#))
          (T
           (SETQ |FiniteLinearAggregate;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (|FiniteLinearAggregate;| #2#)))
                    |FiniteLinearAggregate;AL|))
           #1#)))) 

(DEFUN |FiniteLinearAggregate;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|FiniteLinearAggregate;CAT|)
                                         ('T
                                          (LETT |FiniteLinearAggregate;CAT|
                                                (|Join|
                                                 (|LinearAggregate| '|t#1|)
                                                 (|finiteAggregate|)))))))
           (SETELT #1# 0 (LIST '|FiniteLinearAggregate| |t#1|))))) 
