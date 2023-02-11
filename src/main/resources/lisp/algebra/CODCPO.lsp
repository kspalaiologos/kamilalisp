
(DEFPARAMETER |CoDcpo;CAT| 'NIL) 

(DECLAIM (NOTINLINE |CoDcpo;|)) 

(DEFPARAMETER |CoDcpo;AL| 'NIL) 

(DEFUN |CoDcpo| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |CoDcpo;AL|)) (CDR #1#))
          (T
           (SETQ |CoDcpo;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|CoDcpo;| #2#))) |CoDcpo;AL|))
           #1#)))) 

(DEFUN |CoDcpo;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|CoDcpo;CAT|)
                                         ('T
                                          (LETT |CoDcpo;CAT|
                                                (|Join| (|Poset| '|t#1|)
                                                        (|mkCategory|
                                                         '(((|meet|
                                                             ((|NonNegativeInteger|)
                                                              $
                                                              (|NonNegativeInteger|)
                                                              (|NonNegativeInteger|)))
                                                            T))
                                                         NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|CoDcpo| |t#1|))))) 
