
(DEFPARAMETER |BinaryRecursiveAggregate;CAT| 'NIL) 

(DECLAIM (NOTINLINE |BinaryRecursiveAggregate;|)) 

(DEFPARAMETER |BinaryRecursiveAggregate;AL| 'NIL) 

(DEFUN |BinaryRecursiveAggregate| (|t#1|)
  (LET (#1=#:G721 (#2=#:G722 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |BinaryRecursiveAggregate;AL|)) (CDR #1#))
          (T
           (SETQ |BinaryRecursiveAggregate;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (|BinaryRecursiveAggregate;| #2#)))
                    |BinaryRecursiveAggregate;AL|))
           #1#)))) 

(DEFUN |BinaryRecursiveAggregate;| (|t#1|)
  (SPROG ((#1=#:G720 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|BinaryRecursiveAggregate;CAT|)
                                         ('T
                                          (LETT |BinaryRecursiveAggregate;CAT|
                                                (|Join|
                                                 (|RecursiveAggregate| '|t#1|)
                                                 (|mkCategory|
                                                  '(((|left| ($ $)) T)
                                                    ((|elt| ($ $ "left")) T)
                                                    ((|right| ($ $)) T)
                                                    ((|elt| ($ $ "right")) T)
                                                    ((|setelt!| ($ $ "left" $))
                                                     (|has| $
                                                            (|shallowlyMutable|)))
                                                    ((|setleft!| ($ $ $))
                                                     (|has| $
                                                            (|shallowlyMutable|)))
                                                    ((|setelt!|
                                                      ($ $ "right" $))
                                                     (|has| $
                                                            (|shallowlyMutable|)))
                                                    ((|setright!| ($ $ $))
                                                     (|has| $
                                                            (|shallowlyMutable|))))
                                                  NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|BinaryRecursiveAggregate| |t#1|))))) 
