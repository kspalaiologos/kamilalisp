
(DECLAIM (NOTINLINE |BoundedDistributiveLattice;|)) 

(DEFPARAMETER |BoundedDistributiveLattice;AL| 'NIL) 

(DEFUN |BoundedDistributiveLattice| ()
  (COND (|BoundedDistributiveLattice;AL|)
        (T
         (SETQ |BoundedDistributiveLattice;AL|
                 (|BoundedDistributiveLattice;|))))) 

(DEFUN |BoundedDistributiveLattice;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|BoundedLattice|) (|DistributiveLattice|)))
           (SETELT #1# 0 '(|BoundedDistributiveLattice|))))) 

(MAKEPROP '|BoundedDistributiveLattice| 'NILADIC T) 
