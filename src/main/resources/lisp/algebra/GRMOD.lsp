
(DEFPARAMETER |GradedModule;CAT| 'NIL) 

(DECLAIM (NOTINLINE |GradedModule;|)) 

(DEFPARAMETER |GradedModule;AL| 'NIL) 

(DEFUN |GradedModule| (|t#1| |t#2|)
  (LET (#1=#:G690 (#2=#:G691 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND ((SETQ #1# (|assoc| #2# |GradedModule;AL|)) (CDR #1#))
          (T
           (SETQ |GradedModule;AL|
                   (|cons5| (CONS #2# (SETQ #1# (APPLY #'|GradedModule;| #2#)))
                            |GradedModule;AL|))
           #1#)))) 

(DEFUN |GradedModule;| (|t#1| |t#2|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (COND (|GradedModule;CAT|)
                                         ('T
                                          (LETT |GradedModule;CAT|
                                                (|Join| (|SetCategory|)
                                                        (|mkCategory|
                                                         '(((|degree|
                                                             (|t#2| $))
                                                            T)
                                                           ((|Zero| ($)
                                                                    |constant|)
                                                            T)
                                                           ((* ($ |t#1| $)) T)
                                                           ((* ($ $ |t#1|)) T)
                                                           ((- ($ $)) T)
                                                           ((+ ($ $ $)) T)
                                                           ((- ($ $ $)) T))
                                                         NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|GradedModule| |t#1| |t#2|))))) 
