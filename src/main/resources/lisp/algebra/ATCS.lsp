
(DECLAIM (NOTINLINE |CommutativeStar;|)) 

(DEFPARAMETER |CommutativeStar;AL| 'NIL) 

(DEFUN |CommutativeStar| ()
  (COND (|CommutativeStar;AL|)
        (T (SETQ |CommutativeStar;AL| (|CommutativeStar;|))))) 

(DEFUN |CommutativeStar;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|TwoSidedRecip|)))
           (SETELT #1# 0 '(|CommutativeStar|))))) 

(MAKEPROP '|CommutativeStar| 'NILADIC T) 
