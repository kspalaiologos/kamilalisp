
(DECLAIM (NOTINLINE |OrderedIntegralDomain;|)) 

(DEFPARAMETER |OrderedIntegralDomain;AL| 'NIL) 

(DEFUN |OrderedIntegralDomain| ()
  (COND (|OrderedIntegralDomain;AL|)
        (T (SETQ |OrderedIntegralDomain;AL| (|OrderedIntegralDomain;|))))) 

(DEFUN |OrderedIntegralDomain;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|IntegralDomain|) (|OrderedRing|)))
           (SETELT #1# 0 '(|OrderedIntegralDomain|))))) 

(MAKEPROP '|OrderedIntegralDomain| 'NILADIC T) 
