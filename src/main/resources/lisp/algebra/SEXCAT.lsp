
(DEFPARAMETER |SExpressionCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |SExpressionCategory;|)) 

(DEFPARAMETER |SExpressionCategory;AL| 'NIL) 

(DEFUN |SExpressionCategory| (|t#1| |t#2| |t#3| |t#4|)
  (LET (#1=#:G690
        (#2=#:G691
         (LIST (|devaluate| |t#1|) (|devaluate| |t#2|) (|devaluate| |t#3|)
               (|devaluate| |t#4|))))
    (COND ((SETQ #1# (|assoc| #2# |SExpressionCategory;AL|)) (CDR #1#))
          (T
           (SETQ |SExpressionCategory;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (APPLY #'|SExpressionCategory;| #2#)))
                    |SExpressionCategory;AL|))
           #1#)))) 

(DEFUN |SExpressionCategory;| (|t#1| |t#2| |t#3| |t#4|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2| |t#3| |t#4|)
                                   (LIST |t#1| |t#2| |t#3| |t#4|)
                                   (COND (|SExpressionCategory;CAT|)
                                         ('T
                                          (LETT |SExpressionCategory;CAT|
                                                (|Join| (|SetCategory|)
                                                        (|mkCategory|
                                                         '(((|eq|
                                                             ((|Boolean|) $ $))
                                                            T)
                                                           ((|null?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|atom?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|pair?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|list?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|string?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|symbol?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|integer?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|float?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|destruct|
                                                             ((|List| $) $))
                                                            T)
                                                           ((|string|
                                                             (|t#1| $))
                                                            T)
                                                           ((|symbol|
                                                             (|t#2| $))
                                                            T)
                                                           ((|integer|
                                                             (|t#3| $))
                                                            T)
                                                           ((|float| (|t#4| $))
                                                            T)
                                                           ((|convert|
                                                             ($ (|List| $)))
                                                            T)
                                                           ((|convert|
                                                             ($ |t#1|))
                                                            T)
                                                           ((|convert|
                                                             ($ |t#2|))
                                                            T)
                                                           ((|convert|
                                                             ($ |t#3|))
                                                            T)
                                                           ((|convert|
                                                             ($ |t#4|))
                                                            T)
                                                           ((|car| ($ $)) T)
                                                           ((|cdr| ($ $)) T)
                                                           ((|#|
                                                             ((|Integer|) $))
                                                            T)
                                                           ((|elt|
                                                             ($ $ (|Integer|)))
                                                            T)
                                                           ((|elt|
                                                             ($ $
                                                              (|List|
                                                               (|Integer|))))
                                                            T))
                                                         NIL NIL NIL)))))))
           (SETELT #1# 0
                   (LIST '|SExpressionCategory| |t#1| |t#2| |t#3| |t#4|))))) 
