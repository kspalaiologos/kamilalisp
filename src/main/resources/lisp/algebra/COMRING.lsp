
(DECLAIM (NOTINLINE |CommutativeRing;|)) 

(DEFPARAMETER |CommutativeRing;AL| 'NIL) 

(DEFUN |CommutativeRing| ()
  (COND (|CommutativeRing;AL|)
        (T (SETQ |CommutativeRing;AL| (|CommutativeRing;|))))) 

(DEFUN |CommutativeRing;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|Ring|) (|Algebra| '$) (|CommutativeStar|)))
           (SETELT #1# 0 '(|CommutativeRing|))))) 

(MAKEPROP '|CommutativeRing| 'NILADIC T) 
