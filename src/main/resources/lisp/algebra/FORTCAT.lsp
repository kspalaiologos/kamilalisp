
(DECLAIM (NOTINLINE |FortranProgramCategory;|)) 

(DEFPARAMETER |FortranProgramCategory;AL| 'NIL) 

(DEFUN |FortranProgramCategory| ()
  (COND (|FortranProgramCategory;AL|)
        (T (SETQ |FortranProgramCategory;AL| (|FortranProgramCategory;|))))) 

(DEFUN |FortranProgramCategory;| ()
  (SPROG ((#1=#:G690 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(#2=#:G689) (LIST '(|OutputForm|))
                                   (|Join| (|Type|) (|CoercibleTo| '#2#)
                                           (|mkCategory|
                                            '(((|outputAsFortran| ((|Void|) $))
                                               T))
                                            NIL NIL NIL))))
           (SETELT #1# 0 '(|FortranProgramCategory|))))) 

(MAKEPROP '|FortranProgramCategory| 'NILADIC T) 
