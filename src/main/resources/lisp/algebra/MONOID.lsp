
(DECLAIM (NOTINLINE |Monoid;|)) 

(DEFPARAMETER |Monoid;AL| 'NIL) 

(DEFUN |Monoid| () (COND (|Monoid;AL|) (T (SETQ |Monoid;AL| (|Monoid;|))))) 

(DEFUN |Monoid;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|SemiGroup|) (|MagmaWithUnit|)))
           (SETELT #1# 0 '(|Monoid|))))) 

(MAKEPROP '|Monoid| 'NILADIC T) 
