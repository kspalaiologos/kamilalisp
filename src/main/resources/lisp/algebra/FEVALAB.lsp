
(DECLAIM (NOTINLINE |FullyEvalableOver;|)) 

(DEFPARAMETER |FullyEvalableOver;AL| 'NIL) 

(DEFUN |FullyEvalableOver| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |FullyEvalableOver;AL|)) (CDR #1#))
          (T
           (SETQ |FullyEvalableOver;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|FullyEvalableOver;| #2#)))
                            |FullyEvalableOver;AL|))
           #1#)))) 

(DEFUN |FullyEvalableOver;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (|Join|
                                    (|mkCategory|
                                     '(((|map| ($ (|Mapping| |t#1| |t#1|) $))
                                        T))
                                     '(((|Eltable| |t#1| $)
                                        (|has| |t#1| (|Eltable| |t#1| |t#1|)))
                                       ((|Evalable| |t#1|)
                                        (|has| |t#1| (|Evalable| |t#1|)))
                                       ((|InnerEvalable| (|Symbol|) |t#1|)
                                        (|has| |t#1|
                                               (|InnerEvalable| (|Symbol|)
                                                                |t#1|))))
                                     NIL NIL))))
           (SETELT #1# 0 (LIST '|FullyEvalableOver| |t#1|))))) 
