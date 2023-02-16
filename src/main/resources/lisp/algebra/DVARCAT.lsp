
(DEFPARAMETER |DifferentialVariableCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |DifferentialVariableCategory;|)) 

(DEFPARAMETER |DifferentialVariableCategory;AL| 'NIL) 

(DEFUN |DifferentialVariableCategory| (|t#1|)
  (LET (#1=#:G695 (#2=#:G696 (|devaluate| |t#1|)))
    (COND
     ((SETQ #1# (|assoc| #2# |DifferentialVariableCategory;AL|)) (CDR #1#))
     (T
      (SETQ |DifferentialVariableCategory;AL|
              (|cons5|
               (CONS #2# (SETQ #1# (|DifferentialVariableCategory;| #2#)))
               |DifferentialVariableCategory;AL|))
      #1#)))) 

(DEFUN |DifferentialVariableCategory;| (|t#1|)
  (SPROG ((#1=#:G694 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|DifferentialVariableCategory;CAT|)
                                         ('T
                                          (LETT
                                           |DifferentialVariableCategory;CAT|
                                           (|Join| (|OrderedSet|)
                                                   (|RetractableTo| '|t#1|)
                                                   (|mkCategory|
                                                    '(((|makeVariable|
                                                        ($ |t#1|
                                                         (|NonNegativeInteger|)))
                                                       T)
                                                      ((|order|
                                                        ((|NonNegativeInteger|)
                                                         $))
                                                       T)
                                                      ((|variable| (|t#1| $))
                                                       T)
                                                      ((|weight|
                                                        ((|NonNegativeInteger|)
                                                         $))
                                                       T)
                                                      ((|differentiate| ($ $))
                                                       T)
                                                      ((|differentiate|
                                                        ($ $
                                                         (|NonNegativeInteger|)))
                                                       T)
                                                      ((|coerce| ($ |t#1|)) T))
                                                    NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|DifferentialVariableCategory| |t#1|))))) 
