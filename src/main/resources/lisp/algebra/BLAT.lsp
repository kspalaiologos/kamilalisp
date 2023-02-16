
(DECLAIM (NOTINLINE |BoundedLattice;|)) 

(DEFPARAMETER |BoundedLattice;AL| 'NIL) 

(DEFUN |BoundedLattice| ()
  (COND (|BoundedLattice;AL|)
        (T (SETQ |BoundedLattice;AL| (|BoundedLattice;|))))) 

(DEFUN |BoundedLattice;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|BoundedMeetSemilattice|)
                           (|BoundedJoinSemilattice|)))
           (SETELT #1# 0 '(|BoundedLattice|))))) 

(MAKEPROP '|BoundedLattice| 'NILADIC T) 
