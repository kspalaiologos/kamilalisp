
(DECLAIM (NOTINLINE |multiplicativeValuation;|)) 

(DEFPARAMETER |multiplicativeValuation;AL| 'NIL) 

(DEFUN |multiplicativeValuation| ()
  (COND (|multiplicativeValuation;AL|)
        (T (SETQ |multiplicativeValuation;AL| (|multiplicativeValuation;|))))) 

(DEFUN |multiplicativeValuation;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|mkCategory| NIL NIL NIL NIL)))
           (SETELT #1# 0 '(|multiplicativeValuation|))))) 

(MAKEPROP '|multiplicativeValuation| 'NILADIC T) 
