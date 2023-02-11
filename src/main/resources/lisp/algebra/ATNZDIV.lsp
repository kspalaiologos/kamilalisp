
(DECLAIM (NOTINLINE |noZeroDivisors;|)) 

(DEFPARAMETER |noZeroDivisors;AL| 'NIL) 

(DEFUN |noZeroDivisors| ()
  (COND (|noZeroDivisors;AL|)
        (T (SETQ |noZeroDivisors;AL| (|noZeroDivisors;|))))) 

(DEFUN |noZeroDivisors;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|mkCategory| NIL NIL NIL NIL)))
           (SETELT #1# 0 '(|noZeroDivisors|))))) 

(MAKEPROP '|noZeroDivisors| 'NILADIC T) 
