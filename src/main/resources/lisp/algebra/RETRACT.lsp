
(DEFPARAMETER |RetractableTo;CAT| 'NIL) 

(DECLAIM (NOTINLINE |RetractableTo;|)) 

(DEFPARAMETER |RetractableTo;AL| 'NIL) 

(DEFUN |RetractableTo| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |RetractableTo;AL|)) (CDR #1#))
          (T
           (SETQ |RetractableTo;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|RetractableTo;| #2#)))
                            |RetractableTo;AL|))
           #1#)))) 

(DEFUN |RetractableTo;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|RetractableTo;CAT|)
                                         ('T
                                          (LETT |RetractableTo;CAT|
                                                (|Join|
                                                 (|CoercibleFrom| '|t#1|)
                                                 (|mkCategory|
                                                  '(((|retractIfCan|
                                                      ((|Union| |t#1| "failed")
                                                       $))
                                                     T)
                                                    ((|retract| (|t#1| $)) T))
                                                  NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|RetractableTo| |t#1|))))) 
