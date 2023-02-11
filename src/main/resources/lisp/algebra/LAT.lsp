
(DECLAIM (NOTINLINE |Lattice;|)) 

(DEFPARAMETER |Lattice;AL| 'NIL) 

(DEFUN |Lattice| () (COND (|Lattice;AL|) (T (SETQ |Lattice;AL| (|Lattice;|))))) 

(DEFUN |Lattice;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|MeetSemilattice|) (|JoinSemilattice|)))
           (SETELT #1# 0 '(|Lattice|))))) 

(MAKEPROP '|Lattice| 'NILADIC T) 
