
(DECLAIM (NOTINLINE |IntegralDomain;|)) 

(DEFPARAMETER |IntegralDomain;AL| 'NIL) 

(DEFUN |IntegralDomain| ()
  (COND (|IntegralDomain;AL|)
        (T (SETQ |IntegralDomain;AL| (|IntegralDomain;|))))) 

(DEFUN |IntegralDomain;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|CommutativeRing|) (|EntireRing|)))
           (SETELT #1# 0 '(|IntegralDomain|))))) 

(MAKEPROP '|IntegralDomain| 'NILADIC T) 
