
(DECLAIM (NOTINLINE |OrderedSemiGroup;|)) 

(DEFPARAMETER |OrderedSemiGroup;AL| 'NIL) 

(DEFUN |OrderedSemiGroup| ()
  (COND (|OrderedSemiGroup;AL|)
        (T (SETQ |OrderedSemiGroup;AL| (|OrderedSemiGroup;|))))) 

(DEFUN |OrderedSemiGroup;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|OrderedSet|) (|SemiGroup|)))
           (SETELT #1# 0 '(|OrderedSemiGroup|))))) 

(MAKEPROP '|OrderedSemiGroup| 'NILADIC T) 
