
(DECLAIM (NOTINLINE |OrderedMonoid;|)) 

(DEFPARAMETER |OrderedMonoid;AL| 'NIL) 

(DEFUN |OrderedMonoid| ()
  (COND (|OrderedMonoid;AL|) (T (SETQ |OrderedMonoid;AL| (|OrderedMonoid;|))))) 

(DEFUN |OrderedMonoid;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|OrderedSemiGroup|) (|Monoid|)))
           (SETELT #1# 0 '(|OrderedMonoid|))))) 

(MAKEPROP '|OrderedMonoid| 'NILADIC T) 
