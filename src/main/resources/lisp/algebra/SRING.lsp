
(DECLAIM (NOTINLINE |SemiRing;|)) 

(DEFPARAMETER |SemiRing;AL| 'NIL) 

(DEFUN |SemiRing| ()
  (COND (|SemiRing;AL|) (T (SETQ |SemiRing;AL| (|SemiRing;|))))) 

(DEFUN |SemiRing;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|NonAssociativeSemiRing|) (|SemiRng|) (|Monoid|)))
           (SETELT #1# 0 '(|SemiRing|))))) 

(MAKEPROP '|SemiRing| 'NILADIC T) 
