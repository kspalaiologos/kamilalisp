
(DEFPARAMETER |ListAggregate;CAT| 'NIL) 

(DECLAIM (NOTINLINE |ListAggregate;|)) 

(DEFPARAMETER |ListAggregate;AL| 'NIL) 

(DEFUN |ListAggregate| (|t#1|)
  (LET (#1=#:G746 (#2=#:G747 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |ListAggregate;AL|)) (CDR #1#))
          (T
           (SETQ |ListAggregate;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|ListAggregate;| #2#)))
                            |ListAggregate;AL|))
           #1#)))) 

(DEFUN |ListAggregate;| (|t#1|)
  (SPROG ((#1=#:G745 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|ListAggregate;CAT|)
                                         ('T
                                          (LETT |ListAggregate;CAT|
                                                (|Join|
                                                 (|StreamAggregate| '|t#1|)
                                                 (|FiniteLinearAggregate|
                                                  '|t#1|)
                                                 (|ExtensibleLinearAggregate|
                                                  '|t#1|)
                                                 (|mkCategory|
                                                  '(((|list| ($ |t#1|)) T)) NIL
                                                  NIL NIL)))))))
           (SETELT #1# 0 (LIST '|ListAggregate| |t#1|))))) 
