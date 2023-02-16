
(DECLAIM (NOTINLINE |Ring;|)) 

(DEFPARAMETER |Ring;AL| 'NIL) 

(DEFUN |Ring| () (COND (|Ring;AL|) (T (SETQ |Ring;AL| (|Ring;|))))) 

(DEFUN |Ring;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|Rng|) (|SemiRing|) (|NonAssociativeRing|)
                           (|unitsKnown|)))
           (SETELT #1# 0 '(|Ring|))))) 

(MAKEPROP '|Ring| 'NILADIC T) 
