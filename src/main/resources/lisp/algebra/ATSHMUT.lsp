
(DECLAIM (NOTINLINE |shallowlyMutable;|)) 

(DEFPARAMETER |shallowlyMutable;AL| 'NIL) 

(DEFUN |shallowlyMutable| ()
  (COND (|shallowlyMutable;AL|)
        (T (SETQ |shallowlyMutable;AL| (|shallowlyMutable;|))))) 

(DEFUN |shallowlyMutable;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|mkCategory| NIL NIL NIL NIL)))
           (SETELT #1# 0 '(|shallowlyMutable|))))) 

(MAKEPROP '|shallowlyMutable| 'NILADIC T) 
