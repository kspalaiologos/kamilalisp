
(DEFPARAMETER |OneDimensionalArrayAggregate;CAT| 'NIL) 

(DECLAIM (NOTINLINE |OneDimensionalArrayAggregate;|)) 

(DEFPARAMETER |OneDimensionalArrayAggregate;AL| 'NIL) 

(DEFUN |OneDimensionalArrayAggregate| (|t#1|)
  (LET (#1=#:G721 (#2=#:G722 (|devaluate| |t#1|)))
    (COND
     ((SETQ #1# (|assoc| #2# |OneDimensionalArrayAggregate;AL|)) (CDR #1#))
     (T
      (SETQ |OneDimensionalArrayAggregate;AL|
              (|cons5|
               (CONS #2# (SETQ #1# (|OneDimensionalArrayAggregate;| #2#)))
               |OneDimensionalArrayAggregate;AL|))
      #1#)))) 

(DEFUN |OneDimensionalArrayAggregate;| (|t#1|)
  (SPROG ((#1=#:G720 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|OneDimensionalArrayAggregate;CAT|)
                                         ('T
                                          (LETT
                                           |OneDimensionalArrayAggregate;CAT|
                                           (|Join|
                                            (|FiniteLinearAggregate| '|t#1|)
                                            (|shallowlyMutable|)))))))
           (SETELT #1# 0 (LIST '|OneDimensionalArrayAggregate| |t#1|))))) 
