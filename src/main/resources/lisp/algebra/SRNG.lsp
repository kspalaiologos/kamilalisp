
(DECLAIM (NOTINLINE |SemiRng;|)) 

(DEFPARAMETER |SemiRng;AL| 'NIL) 

(DEFUN |SemiRng| () (COND (|SemiRng;AL|) (T (SETQ |SemiRng;AL| (|SemiRng;|))))) 

(DEFUN |SemiRng;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|NonAssociativeSemiRng|) (|BiModule| '$ '$)
                           (|SemiGroup|)))
           (SETELT #1# 0 '(|SemiRng|))))) 

(MAKEPROP '|SemiRng| 'NILADIC T) 
