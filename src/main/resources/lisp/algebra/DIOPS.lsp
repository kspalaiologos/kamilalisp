
(DEFPARAMETER |DictionaryOperations;CAT| 'NIL) 

(DECLAIM (NOTINLINE |DictionaryOperations;|)) 

(DEFPARAMETER |DictionaryOperations;AL| 'NIL) 

(DEFUN |DictionaryOperations| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |DictionaryOperations;AL|)) (CDR #1#))
          (T
           (SETQ |DictionaryOperations;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|DictionaryOperations;| #2#)))
                            |DictionaryOperations;AL|))
           #1#)))) 

(DEFUN |DictionaryOperations;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|DictionaryOperations;CAT|)
                                         ('T
                                          (LETT |DictionaryOperations;CAT|
                                                (|Join| (|BagAggregate| '|t#1|)
                                                        (|mkCategory|
                                                         '(((|dictionary| ($))
                                                            T)
                                                           ((|dictionary|
                                                             ($
                                                              (|List| |t#1|)))
                                                            T)
                                                           ((|remove!|
                                                             ($ |t#1| $))
                                                            (AND
                                                             (|has| |t#1|
                                                                    (|BasicType|))
                                                             (|has| $
                                                                    (|finiteAggregate|))))
                                                           ((|remove!|
                                                             ($
                                                              (|Mapping|
                                                               (|Boolean|)
                                                               |t#1|)
                                                              $))
                                                            (|has| $
                                                                   (|finiteAggregate|)))
                                                           ((|select!|
                                                             ($
                                                              (|Mapping|
                                                               (|Boolean|)
                                                               |t#1|)
                                                              $))
                                                            (|has| $
                                                                   (|finiteAggregate|))))
                                                         NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|DictionaryOperations| |t#1|))))) 
