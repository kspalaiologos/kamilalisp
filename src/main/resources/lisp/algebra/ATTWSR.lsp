
(DECLAIM (NOTINLINE |TwoSidedRecip;|)) 

(DEFPARAMETER |TwoSidedRecip;AL| 'NIL) 

(DEFUN |TwoSidedRecip| ()
  (COND (|TwoSidedRecip;AL|) (T (SETQ |TwoSidedRecip;AL| (|TwoSidedRecip;|))))) 

(DEFUN |TwoSidedRecip;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|mkCategory| NIL NIL NIL NIL)))
           (SETELT #1# 0 '(|TwoSidedRecip|))))) 

(MAKEPROP '|TwoSidedRecip| 'NILADIC T) 
