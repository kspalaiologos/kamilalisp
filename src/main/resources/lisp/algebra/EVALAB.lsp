
(DEFPARAMETER |Evalable;CAT| 'NIL) 

(DECLAIM (NOTINLINE |Evalable;|)) 

(DEFPARAMETER |Evalable;AL| 'NIL) 

(DEFUN |Evalable| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |Evalable;AL|)) (CDR #1#))
          (T
           (SETQ |Evalable;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|Evalable;| #2#)))
                            |Evalable;AL|))
           #1#)))) 

(DEFUN |Evalable;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|Evalable;CAT|)
                                         ('T
                                          (LETT |Evalable;CAT|
                                                (|Join|
                                                 (|InnerEvalable| '|t#1|
                                                                  '|t#1|)
                                                 (|mkCategory|
                                                  '(((|eval|
                                                      ($ $ (|Equation| |t#1|)))
                                                     T)
                                                    ((|eval|
                                                      ($ $
                                                       (|List|
                                                        (|Equation| |t#1|))))
                                                     T))
                                                  NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|Evalable| |t#1|))))) 
