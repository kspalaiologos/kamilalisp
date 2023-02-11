
(DEFPARAMETER |RightModule;CAT| 'NIL) 

(DECLAIM (NOTINLINE |RightModule;|)) 

(DEFPARAMETER |RightModule;AL| 'NIL) 

(DEFUN |RightModule| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |RightModule;AL|)) (CDR #1#))
          (T
           (SETQ |RightModule;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|RightModule;| #2#)))
                            |RightModule;AL|))
           #1#)))) 

(DEFUN |RightModule;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|RightModule;CAT|)
                                         ('T
                                          (LETT |RightModule;CAT|
                                                (|Join| (|AbelianSemiGroup|)
                                                        (|mkCategory|
                                                         '(((* ($ $ |t#1|)) T))
                                                         '(((|AbelianMonoid|)
                                                            (|has| |t#1|
                                                                   (|AbelianMonoid|)))
                                                           ((|AbelianGroup|)
                                                            (|has| |t#1|
                                                                   (|AbelianGroup|))))
                                                         NIL NIL)))))))
           (SETELT #1# 0 (LIST '|RightModule| |t#1|))))) 
