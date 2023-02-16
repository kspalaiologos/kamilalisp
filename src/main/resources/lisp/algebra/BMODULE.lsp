
(DEFPARAMETER |BiModule;CAT| 'NIL) 

(DECLAIM (NOTINLINE |BiModule;|)) 

(DEFPARAMETER |BiModule;AL| 'NIL) 

(DEFUN |BiModule| (|t#1| |t#2|)
  (LET (#1=#:G690 (#2=#:G691 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND ((SETQ #1# (|assoc| #2# |BiModule;AL|)) (CDR #1#))
          (T
           (SETQ |BiModule;AL|
                   (|cons5| (CONS #2# (SETQ #1# (APPLY #'|BiModule;| #2#)))
                            |BiModule;AL|))
           #1#)))) 

(DEFUN |BiModule;| (|t#1| |t#2|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (COND (|BiModule;CAT|)
                                         ('T
                                          (LETT |BiModule;CAT|
                                                (|Join| (|LeftModule| '|t#1|)
                                                        (|RightModule|
                                                         '|t#2|)))))))
           (SETELT #1# 0 (LIST '|BiModule| |t#1| |t#2|))))) 
