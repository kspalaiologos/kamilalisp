
(DECLAIM (NOTINLINE |BoundedJoinSemilattice;|)) 

(DEFPARAMETER |BoundedJoinSemilattice;AL| 'NIL) 

(DEFUN |BoundedJoinSemilattice| ()
  (COND (|BoundedJoinSemilattice;AL|)
        (T (SETQ |BoundedJoinSemilattice;AL| (|BoundedJoinSemilattice;|))))) 

(DEFUN |BoundedJoinSemilattice;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|JoinSemilattice|)
                           (|mkCategory| '(((|_\|_| ($) |constant|) T)) NIL NIL
                                         NIL)))
           (SETELT #1# 0 '(|BoundedJoinSemilattice|))))) 

(MAKEPROP '|BoundedJoinSemilattice| 'NILADIC T) 
