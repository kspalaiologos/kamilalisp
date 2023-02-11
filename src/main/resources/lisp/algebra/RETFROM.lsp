
(DEFPARAMETER |RetractableFrom;CAT| 'NIL) 

(DECLAIM (NOTINLINE |RetractableFrom;|)) 

(DEFPARAMETER |RetractableFrom;AL| 'NIL) 

(DEFUN |RetractableFrom| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |RetractableFrom;AL|)) (CDR #1#))
          (T
           (SETQ |RetractableFrom;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|RetractableFrom;| #2#)))
                            |RetractableFrom;AL|))
           #1#)))) 

(DEFUN |RetractableFrom;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|RetractableFrom;CAT|)
                                         ('T
                                          (LETT |RetractableFrom;CAT|
                                                (|Join| (|CoercibleTo| '|t#1|)
                                                        (|mkCategory|
                                                         '(((|retractIfCan|
                                                             ((|Union| $
                                                                       "failed")
                                                              |t#1|))
                                                            T)
                                                           ((|retract|
                                                             ($ |t#1|))
                                                            T))
                                                         NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|RetractableFrom| |t#1|))))) 
