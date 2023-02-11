
(DECLAIM (NOTINLINE |arbitraryExponent;|)) 

(DEFPARAMETER |arbitraryExponent;AL| 'NIL) 

(DEFUN |arbitraryExponent| ()
  (COND (|arbitraryExponent;AL|)
        (T (SETQ |arbitraryExponent;AL| (|arbitraryExponent;|))))) 

(DEFUN |arbitraryExponent;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|mkCategory| NIL NIL NIL NIL)))
           (SETELT #1# 0 '(|arbitraryExponent|))))) 

(MAKEPROP '|arbitraryExponent| 'NILADIC T) 
