
(DEFPARAMETER |NonAssociativeAlgebra;CAT| 'NIL) 

(DECLAIM (NOTINLINE |NonAssociativeAlgebra;|)) 

(DEFPARAMETER |NonAssociativeAlgebra;AL| 'NIL) 

(DEFUN |NonAssociativeAlgebra| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |NonAssociativeAlgebra;AL|)) (CDR #1#))
          (T
           (SETQ |NonAssociativeAlgebra;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (|NonAssociativeAlgebra;| #2#)))
                    |NonAssociativeAlgebra;AL|))
           #1#)))) 

(DEFUN |NonAssociativeAlgebra;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|NonAssociativeAlgebra;CAT|)
                                         ('T
                                          (LETT |NonAssociativeAlgebra;CAT|
                                                (|Join| (|NonAssociativeRng|)
                                                        (|Module| '|t#1|)
                                                        (|mkCategory|
                                                         '(((|plenaryPower|
                                                             ($ $
                                                              (|PositiveInteger|)))
                                                            T))
                                                         NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|NonAssociativeAlgebra| |t#1|))))) 
