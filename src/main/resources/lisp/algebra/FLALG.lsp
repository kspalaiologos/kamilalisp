
(DEFPARAMETER |FreeLieAlgebra;CAT| 'NIL) 

(DECLAIM (NOTINLINE |FreeLieAlgebra;|)) 

(DEFPARAMETER |FreeLieAlgebra;AL| 'NIL) 

(DEFUN |FreeLieAlgebra| (|t#1| |t#2|)
  (LET (#1=#:G690 (#2=#:G691 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND ((SETQ #1# (|assoc| #2# |FreeLieAlgebra;AL|)) (CDR #1#))
          (T
           (SETQ |FreeLieAlgebra;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (APPLY #'|FreeLieAlgebra;| #2#)))
                    |FreeLieAlgebra;AL|))
           #1#)))) 

(DEFUN |FreeLieAlgebra;| (|t#1| |t#2|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (COND (|FreeLieAlgebra;CAT|)
                                         ('T
                                          (LETT |FreeLieAlgebra;CAT|
                                                (|Join| (|LieAlgebra| '|t#2|)
                                                        (|mkCategory|
                                                         '(((|coef|
                                                             (|t#2|
                                                              (|XRecursivePolynomial|
                                                               |t#1| |t#2|)
                                                              $))
                                                            T)
                                                           ((|coerce|
                                                             ($ |t#1|))
                                                            T)
                                                           ((|coerce|
                                                             ((|XDistributedPolynomial|
                                                               |t#1| |t#2|)
                                                              $))
                                                            T)
                                                           ((|coerce|
                                                             ((|XRecursivePolynomial|
                                                               |t#1| |t#2|)
                                                              $))
                                                            T)
                                                           ((|degree|
                                                             ((|NonNegativeInteger|)
                                                              $))
                                                            T)
                                                           ((|lquo|
                                                             ((|XRecursivePolynomial|
                                                               |t#1| |t#2|)
                                                              (|XRecursivePolynomial|
                                                               |t#1| |t#2|)
                                                              $))
                                                            T)
                                                           ((|rquo|
                                                             ((|XRecursivePolynomial|
                                                               |t#1| |t#2|)
                                                              (|XRecursivePolynomial|
                                                               |t#1| |t#2|)
                                                              $))
                                                            T)
                                                           ((|LiePoly|
                                                             ($
                                                              (|LyndonWord|
                                                               |t#1|)))
                                                            T)
                                                           ((|mirror| ($ $)) T)
                                                           ((|trunc|
                                                             ($ $
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|varList|
                                                             ((|List| |t#1|)
                                                              $))
                                                            T)
                                                           ((|eval|
                                                             ($ $ |t#1| $))
                                                            T)
                                                           ((|eval|
                                                             ($ $
                                                              (|List| |t#1|)
                                                              (|List| $)))
                                                            T))
                                                         NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|FreeLieAlgebra| |t#1| |t#2|))))) 
