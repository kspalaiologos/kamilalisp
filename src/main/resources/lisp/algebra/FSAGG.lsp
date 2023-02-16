
(DEFPARAMETER |FiniteSetAggregate;CAT| 'NIL) 

(DECLAIM (NOTINLINE |FiniteSetAggregate;|)) 

(DEFPARAMETER |FiniteSetAggregate;AL| 'NIL) 

(DEFUN |FiniteSetAggregate| (|t#1|)
  (LET (#1=#:G697 (#2=#:G698 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |FiniteSetAggregate;AL|)) (CDR #1#))
          (T
           (SETQ |FiniteSetAggregate;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|FiniteSetAggregate;| #2#)))
                            |FiniteSetAggregate;AL|))
           #1#)))) 

(DEFUN |FiniteSetAggregate;| (|t#1|)
  (SPROG ((#1=#:G696 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|FiniteSetAggregate;CAT|)
                                         ('T
                                          (LETT |FiniteSetAggregate;CAT|
                                                (|Join| (|Dictionary| '|t#1|)
                                                        (|SetAggregate| '|t#1|)
                                                        (|finiteAggregate|)
                                                        (|mkCategory|
                                                         '(((|cardinality|
                                                             ((|NonNegativeInteger|)
                                                              $))
                                                            T)
                                                           ((|complement|
                                                             ($ $))
                                                            (|has| |t#1|
                                                                   (|Finite|)))
                                                           ((|universe| ($))
                                                            (|has| |t#1|
                                                                   (|Finite|))))
                                                         '(((|Finite|)
                                                            (|has| |t#1|
                                                                   (|Finite|)))
                                                           ((|Comparable|)
                                                            (|has| |t#1|
                                                                   (|Comparable|))))
                                                         NIL NIL)))))))
           (SETELT #1# 0 (LIST '|FiniteSetAggregate| |t#1|))))) 
