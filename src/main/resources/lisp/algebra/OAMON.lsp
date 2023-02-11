
(DECLAIM (NOTINLINE |OrderedAbelianMonoid;|)) 

(DEFPARAMETER |OrderedAbelianMonoid;AL| 'NIL) 

(DEFUN |OrderedAbelianMonoid| ()
  (COND (|OrderedAbelianMonoid;AL|)
        (T (SETQ |OrderedAbelianMonoid;AL| (|OrderedAbelianMonoid;|))))) 

(DEFUN |OrderedAbelianMonoid;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1# (|Join| (|OrderedAbelianSemiGroup|) (|AbelianMonoid|)))
           (SETELT #1# 0 '(|OrderedAbelianMonoid|))))) 

(MAKEPROP '|OrderedAbelianMonoid| 'NILADIC T) 
