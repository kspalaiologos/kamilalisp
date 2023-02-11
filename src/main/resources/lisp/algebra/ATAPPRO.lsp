
(DECLAIM (NOTINLINE |Approximate;|)) 

(DEFPARAMETER |Approximate;AL| 'NIL) 

(DEFUN |Approximate| ()
  (COND (|Approximate;AL|) (T (SETQ |Approximate;AL| (|Approximate;|))))) 

(DEFUN |Approximate;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|mkCategory| NIL NIL NIL NIL)))
           (SETELT #1# 0 '(|Approximate|))))) 

(MAKEPROP '|Approximate| 'NILADIC T) 
