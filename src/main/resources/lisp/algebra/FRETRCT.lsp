
(DEFPARAMETER |FullyRetractableTo;CAT| 'NIL) 

(DECLAIM (NOTINLINE |FullyRetractableTo;|)) 

(DEFPARAMETER |FullyRetractableTo;AL| 'NIL) 

(DEFUN |FullyRetractableTo| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |FullyRetractableTo;AL|)) (CDR #1#))
          (T
           (SETQ |FullyRetractableTo;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|FullyRetractableTo;| #2#)))
                            |FullyRetractableTo;AL|))
           #1#)))) 

(DEFUN |FullyRetractableTo;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|FullyRetractableTo;CAT|)
                                         ('T
                                          (LETT |FullyRetractableTo;CAT|
                                                (|Join|
                                                 (|RetractableTo| '|t#1|)
                                                 (|mkCategory| NIL
                                                               '(((|RetractableTo|
                                                                   (|Integer|))
                                                                  (|has| |t#1|
                                                                         (|RetractableTo|
                                                                          (|Integer|))))
                                                                 ((|RetractableTo|
                                                                   (|Fraction|
                                                                    (|Integer|)))
                                                                  (|has| |t#1|
                                                                         (|RetractableTo|
                                                                          (|Fraction|
                                                                           (|Integer|))))))
                                                               NIL NIL)))))))
           (SETELT #1# 0 (LIST '|FullyRetractableTo| |t#1|))))) 
