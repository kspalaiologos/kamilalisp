
(DEFPARAMETER |LinearOrdinaryDifferentialOperatorCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |LinearOrdinaryDifferentialOperatorCategory;|)) 

(DEFPARAMETER |LinearOrdinaryDifferentialOperatorCategory;AL| 'NIL) 

(DEFUN |LinearOrdinaryDifferentialOperatorCategory| (|t#1|)
  (LET (#1=#:G691 (#2=#:G692 (|devaluate| |t#1|)))
    (COND
     ((SETQ #1# (|assoc| #2# |LinearOrdinaryDifferentialOperatorCategory;AL|))
      (CDR #1#))
     (T
      (SETQ |LinearOrdinaryDifferentialOperatorCategory;AL|
              (|cons5|
               (CONS #2#
                     (SETQ #1#
                             (|LinearOrdinaryDifferentialOperatorCategory;|
                              #2#)))
               |LinearOrdinaryDifferentialOperatorCategory;AL|))
      #1#)))) 

(DEFUN |LinearOrdinaryDifferentialOperatorCategory;| (|t#1|)
  (SPROG ((#1=#:G690 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND
                                    (|LinearOrdinaryDifferentialOperatorCategory;CAT|)
                                    ('T
                                     (LETT
                                      |LinearOrdinaryDifferentialOperatorCategory;CAT|
                                      (|Join|
                                       (|UnivariateSkewPolynomialCategory|
                                        '|t#1|)
                                       (|Eltable| '|t#1| '|t#1|)
                                       (|mkCategory|
                                        '(((D ($)) T) ((|adjoint| ($ $)) T)
                                          ((|symmetricProduct| ($ $ $))
                                           (|has| |t#1| (|Field|)))
                                          ((|symmetricPower|
                                            ($ $ (|NonNegativeInteger|)))
                                           (|has| |t#1| (|Field|)))
                                          ((|symmetricSquare| ($ $))
                                           (|has| |t#1| (|Field|)))
                                          ((|directSum| ($ $ $))
                                           (|has| |t#1| (|Field|))))
                                        NIL NIL NIL)))))))
           (SETELT #1# 0
                   (LIST '|LinearOrdinaryDifferentialOperatorCategory|
                         |t#1|))))) 
