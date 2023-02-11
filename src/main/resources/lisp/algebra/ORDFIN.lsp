
(DECLAIM (NOTINLINE |OrderedFinite;|)) 

(DEFPARAMETER |OrderedFinite;AL| 'NIL) 

(DEFUN |OrderedFinite| ()
  (COND (|OrderedFinite;AL|) (T (SETQ |OrderedFinite;AL| (|OrderedFinite;|))))) 

(DEFUN |OrderedFinite;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|OrderedSet|) (|Finite|)))
           (SETELT #1# 0 '(|OrderedFinite|))))) 

(MAKEPROP '|OrderedFinite| 'NILADIC T) 
