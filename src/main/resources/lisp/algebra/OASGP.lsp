
(DECLAIM (NOTINLINE |OrderedAbelianSemiGroup;|)) 

(DEFPARAMETER |OrderedAbelianSemiGroup;AL| 'NIL) 

(DEFUN |OrderedAbelianSemiGroup| ()
  (COND (|OrderedAbelianSemiGroup;AL|)
        (T (SETQ |OrderedAbelianSemiGroup;AL| (|OrderedAbelianSemiGroup;|))))) 

(DEFUN |OrderedAbelianSemiGroup;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|OrderedSet|) (|AbelianSemiGroup|)))
           (SETELT #1# 0 '(|OrderedAbelianSemiGroup|))))) 

(MAKEPROP '|OrderedAbelianSemiGroup| 'NILADIC T) 
