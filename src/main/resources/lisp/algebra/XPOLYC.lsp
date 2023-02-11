
(DEFPARAMETER |XPolynomialsCat;CAT| 'NIL) 

(DECLAIM (NOTINLINE |XPolynomialsCat;|)) 

(DEFPARAMETER |XPolynomialsCat;AL| 'NIL) 

(DEFUN |XPolynomialsCat| (|t#1| |t#2|)
  (LET (#1=#:G690 (#2=#:G691 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND ((SETQ #1# (|assoc| #2# |XPolynomialsCat;AL|)) (CDR #1#))
          (T
           (SETQ |XPolynomialsCat;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (APPLY #'|XPolynomialsCat;| #2#)))
                    |XPolynomialsCat;AL|))
           #1#)))) 

(DEFUN |XPolynomialsCat;| (|t#1| |t#2|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (COND (|XPolynomialsCat;CAT|)
                                         ('T
                                          (LETT |XPolynomialsCat;CAT|
                                                (|Join|
                                                 (|XFreeAlgebra| '|t#1| '|t#2|)
                                                 (|mkCategory|
                                                  '(((|maxdeg|
                                                      ((|FreeMonoid| |t#1|) $))
                                                     T)
                                                    ((|degree|
                                                      ((|NonNegativeInteger|)
                                                       $))
                                                     T)
                                                    ((|trunc|
                                                      ($ $
                                                       (|NonNegativeInteger|)))
                                                     T))
                                                  NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|XPolynomialsCat| |t#1| |t#2|))))) 
