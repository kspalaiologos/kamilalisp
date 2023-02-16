
(DECLAIM (NOTINLINE |ConvertibleFrom;|)) 

(DEFPARAMETER |ConvertibleFrom;AL| 'NIL) 

(DEFUN |ConvertibleFrom| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |ConvertibleFrom;AL|)) (CDR #1#))
          (T
           (SETQ |ConvertibleFrom;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|ConvertibleFrom;| #2#)))
                            |ConvertibleFrom;AL|))
           #1#)))) 

(DEFUN |ConvertibleFrom;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (|Join|
                                    (|mkCategory| '(((|convert| ($ |t#1|)) T))
                                                  NIL NIL NIL))))
           (SETELT #1# 0 (LIST '|ConvertibleFrom| |t#1|))))) 
