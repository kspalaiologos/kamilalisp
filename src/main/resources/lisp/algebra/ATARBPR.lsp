
(DECLAIM (NOTINLINE |arbitraryPrecision;|)) 

(DEFPARAMETER |arbitraryPrecision;AL| 'NIL) 

(DEFUN |arbitraryPrecision| ()
  (COND (|arbitraryPrecision;AL|)
        (T (SETQ |arbitraryPrecision;AL| (|arbitraryPrecision;|))))) 

(DEFUN |arbitraryPrecision;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|mkCategory| NIL NIL NIL NIL)))
           (SETELT #1# 0 '(|arbitraryPrecision|))))) 

(MAKEPROP '|arbitraryPrecision| 'NILADIC T) 
