
(DEFPARAMETER |FileCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |FileCategory;|)) 

(DEFPARAMETER |FileCategory;AL| 'NIL) 

(DEFUN |FileCategory| (|t#1| |t#2|)
  (LET (#1=#:G690 (#2=#:G691 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND ((SETQ #1# (|assoc| #2# |FileCategory;AL|)) (CDR #1#))
          (T
           (SETQ |FileCategory;AL|
                   (|cons5| (CONS #2# (SETQ #1# (APPLY #'|FileCategory;| #2#)))
                            |FileCategory;AL|))
           #1#)))) 

(DEFUN |FileCategory;| (|t#1| |t#2|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (COND (|FileCategory;CAT|)
                                         ('T
                                          (LETT |FileCategory;CAT|
                                                (|Join| (|SetCategory|)
                                                        (|mkCategory|
                                                         '(((|open| ($ |t#1|))
                                                            T)
                                                           ((|open|
                                                             ($ |t#1|
                                                              (|String|)))
                                                            T)
                                                           ((|reopen!|
                                                             ($ $ (|String|)))
                                                            T)
                                                           ((|close!| ($ $)) T)
                                                           ((|name| (|t#1| $))
                                                            T)
                                                           ((|iomode|
                                                             ((|String|) $))
                                                            T)
                                                           ((|read!| (|t#2| $))
                                                            T)
                                                           ((|write!|
                                                             (|t#2| $ |t#2|))
                                                            T)
                                                           ((|flush|
                                                             ((|Void|) $))
                                                            T))
                                                         NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|FileCategory| |t#1| |t#2|))))) 
