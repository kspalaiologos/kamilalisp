
(DECLAIM (NOTINLINE |unitsKnown;|)) 

(DEFPARAMETER |unitsKnown;AL| 'NIL) 

(DEFUN |unitsKnown| ()
  (COND (|unitsKnown;AL|) (T (SETQ |unitsKnown;AL| (|unitsKnown;|))))) 

(DEFUN |unitsKnown;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|mkCategory| NIL NIL NIL NIL)))
           (SETELT #1# 0 '(|unitsKnown|))))) 

(MAKEPROP '|unitsKnown| 'NILADIC T) 
