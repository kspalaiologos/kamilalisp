
(DEFPARAMETER |JetBundleBaseFunctionCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |JetBundleBaseFunctionCategory;|)) 

(DEFPARAMETER |JetBundleBaseFunctionCategory;AL| 'NIL) 

(DEFUN |JetBundleBaseFunctionCategory| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND
     ((SETQ #1# (|assoc| #2# |JetBundleBaseFunctionCategory;AL|)) (CDR #1#))
     (T
      (SETQ |JetBundleBaseFunctionCategory;AL|
              (|cons5|
               (CONS #2# (SETQ #1# (|JetBundleBaseFunctionCategory;| #2#)))
               |JetBundleBaseFunctionCategory;AL|))
      #1#)))) 

(DEFUN |JetBundleBaseFunctionCategory;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|JetBundleBaseFunctionCategory;CAT|)
                                         ('T
                                          (LETT
                                           |JetBundleBaseFunctionCategory;CAT|
                                           (|Join|
                                            (|JetBundleFunctionCategory|
                                             '|t#1|)))))))
           (SETELT #1# 0 (LIST '|JetBundleBaseFunctionCategory| |t#1|))))) 
