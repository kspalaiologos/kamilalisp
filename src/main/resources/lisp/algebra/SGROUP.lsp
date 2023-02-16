
(DECLAIM (NOTINLINE |SemiGroup;|)) 

(DEFPARAMETER |SemiGroup;AL| 'NIL) 

(DEFUN |SemiGroup| ()
  (COND (|SemiGroup;AL|) (T (SETQ |SemiGroup;AL| (|SemiGroup;|))))) 

(DEFUN |SemiGroup;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|Magma|))) (SETELT #1# 0 '(|SemiGroup|))))) 

(MAKEPROP '|SemiGroup| 'NILADIC T) 
