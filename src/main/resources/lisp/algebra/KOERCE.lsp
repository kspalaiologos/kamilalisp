
(DECLAIM (NOTINLINE |CoercibleTo;|)) 

(DEFPARAMETER |CoercibleTo;AL| 'NIL) 

(DEFUN |CoercibleTo| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |CoercibleTo;AL|)) (CDR #1#))
          (T
           (SETQ |CoercibleTo;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|CoercibleTo;| #2#)))
                            |CoercibleTo;AL|))
           #1#)))) 

(DEFUN |CoercibleTo;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (|Join|
                                    (|mkCategory| '(((|coerce| (|t#1| $)) T))
                                                  NIL NIL NIL))))
           (SETELT #1# 0 (LIST '|CoercibleTo| |t#1|))))) 
