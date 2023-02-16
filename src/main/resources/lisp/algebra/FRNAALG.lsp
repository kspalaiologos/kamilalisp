
(DEFPARAMETER |FramedNonAssociativeAlgebra;CAT| 'NIL) 

(DECLAIM (NOTINLINE |FramedNonAssociativeAlgebra;|)) 

(DEFPARAMETER |FramedNonAssociativeAlgebra;AL| 'NIL) 

(DEFUN |FramedNonAssociativeAlgebra| (|t#1|)
  (LET (#1=#:G695 (#2=#:G696 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |FramedNonAssociativeAlgebra;AL|)) (CDR #1#))
          (T
           (SETQ |FramedNonAssociativeAlgebra;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (|FramedNonAssociativeAlgebra;| #2#)))
                    |FramedNonAssociativeAlgebra;AL|))
           #1#)))) 

(DEFUN |FramedNonAssociativeAlgebra;| (|t#1|)
  (SPROG ((#1=#:G694 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|FramedNonAssociativeAlgebra;CAT|)
                                         ('T
                                          (LETT
                                           |FramedNonAssociativeAlgebra;CAT|
                                           (|Join|
                                            (|FiniteRankNonAssociativeAlgebra|
                                             '|t#1|)
                                            (|FramedModule| '|t#1|)
                                            (|mkCategory|
                                             '(((|elt| (|t#1| $ (|Integer|)))
                                                T)
                                               ((|structuralConstants|
                                                 ((|Vector| (|Matrix| |t#1|))))
                                                T)
                                               ((|conditionsForIdempotents|
                                                 ((|List|
                                                   (|Polynomial| |t#1|))))
                                                T)
                                               ((|leftDiscriminant| (|t#1|)) T)
                                               ((|rightDiscriminant| (|t#1|))
                                                T)
                                               ((|leftTraceMatrix|
                                                 ((|Matrix| |t#1|)))
                                                T)
                                               ((|rightTraceMatrix|
                                                 ((|Matrix| |t#1|)))
                                                T)
                                               ((|leftRegularRepresentation|
                                                 ((|Matrix| |t#1|) $))
                                                T)
                                               ((|rightRegularRepresentation|
                                                 ((|Matrix| |t#1|) $))
                                                T)
                                               ((|leftRankPolynomial|
                                                 ((|SparseUnivariatePolynomial|
                                                   (|Polynomial| |t#1|))))
                                                (|has| |t#1| (|Field|)))
                                               ((|rightRankPolynomial|
                                                 ((|SparseUnivariatePolynomial|
                                                   (|Polynomial| |t#1|))))
                                                (|has| |t#1| (|Field|)))
                                               ((|apply|
                                                 ($ (|Matrix| |t#1|) $))
                                                T))
                                             NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|FramedNonAssociativeAlgebra| |t#1|))))) 
