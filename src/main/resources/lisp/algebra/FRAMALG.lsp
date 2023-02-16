
(DEFPARAMETER |FramedAlgebra;CAT| 'NIL) 

(DECLAIM (NOTINLINE |FramedAlgebra;|)) 

(DEFPARAMETER |FramedAlgebra;AL| 'NIL) 

(DEFUN |FramedAlgebra| (|t#1| |t#2|)
  (LET (#1=#:G690 (#2=#:G691 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND ((SETQ #1# (|assoc| #2# |FramedAlgebra;AL|)) (CDR #1#))
          (T
           (SETQ |FramedAlgebra;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (APPLY #'|FramedAlgebra;| #2#)))
                    |FramedAlgebra;AL|))
           #1#)))) 

(DEFUN |FramedAlgebra;| (|t#1| |t#2|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (COND (|FramedAlgebra;CAT|)
                                         ('T
                                          (LETT |FramedAlgebra;CAT|
                                                (|Join|
                                                 (|FiniteRankAlgebra| '|t#1|
                                                                      '|t#2|)
                                                 (|FramedModule| '|t#1|)
                                                 (|mkCategory|
                                                  '(((|traceMatrix|
                                                      ((|Matrix| |t#1|)))
                                                     T)
                                                    ((|discriminant| (|t#1|))
                                                     T)
                                                    ((|regularRepresentation|
                                                      ((|Matrix| |t#1|) $))
                                                     T))
                                                  NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|FramedAlgebra| |t#1| |t#2|))))) 
