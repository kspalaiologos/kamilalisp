
(DECLAIM (NOTINLINE |DistributiveLattice;|)) 

(DEFPARAMETER |DistributiveLattice;AL| 'NIL) 

(DEFUN |DistributiveLattice| ()
  (COND (|DistributiveLattice;AL|)
        (T (SETQ |DistributiveLattice;AL| (|DistributiveLattice;|))))) 

(DEFUN |DistributiveLattice;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|Lattice|)))
           (SETELT #1# 0 '(|DistributiveLattice|))))) 

(MAKEPROP '|DistributiveLattice| 'NILADIC T) 
