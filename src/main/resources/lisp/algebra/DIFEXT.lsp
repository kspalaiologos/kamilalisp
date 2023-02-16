
(DEFPARAMETER |DifferentialExtension;CAT| 'NIL) 

(DECLAIM (NOTINLINE |DifferentialExtension;|)) 

(DEFPARAMETER |DifferentialExtension;AL| 'NIL) 

(DEFUN |DifferentialExtension| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |DifferentialExtension;AL|)) (CDR #1#))
          (T
           (SETQ |DifferentialExtension;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (|DifferentialExtension;| #2#)))
                    |DifferentialExtension;AL|))
           #1#)))) 

(DEFUN |DifferentialExtension;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|DifferentialExtension;CAT|)
                                         ('T
                                          (LETT |DifferentialExtension;CAT|
                                                (|Join| (|Ring|)
                                                        (|mkCategory|
                                                         '(((|differentiate|
                                                             ($ $
                                                              (|Mapping| |t#1|
                                                                         |t#1|)))
                                                            T)
                                                           ((|differentiate|
                                                             ($ $
                                                              (|Mapping| |t#1|
                                                                         |t#1|)
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((D
                                                             ($ $
                                                              (|Mapping| |t#1|
                                                                         |t#1|)))
                                                            T)
                                                           ((D
                                                             ($ $
                                                              (|Mapping| |t#1|
                                                                         |t#1|)
                                                              (|NonNegativeInteger|)))
                                                            T))
                                                         '(((|DifferentialRing|)
                                                            (|has| |t#1|
                                                                   (|DifferentialRing|)))
                                                           ((|PartialDifferentialRing|
                                                             (|Symbol|))
                                                            (|has| |t#1|
                                                                   (|PartialDifferentialRing|
                                                                    (|Symbol|)))))
                                                         NIL NIL)))))))
           (SETELT #1# 0 (LIST '|DifferentialExtension| |t#1|))))) 
