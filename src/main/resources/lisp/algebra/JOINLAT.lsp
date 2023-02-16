
(DECLAIM (NOTINLINE |JoinSemilattice;|)) 

(DEFPARAMETER |JoinSemilattice;AL| 'NIL) 

(DEFUN |JoinSemilattice| ()
  (COND (|JoinSemilattice;AL|)
        (T (SETQ |JoinSemilattice;AL| (|JoinSemilattice;|))))) 

(DEFUN |JoinSemilattice;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|SetCategory|)
                           (|mkCategory| '(((|\\/| ($ $ $)) T)) NIL NIL NIL)))
           (SETELT #1# 0 '(|JoinSemilattice|))))) 

(MAKEPROP '|JoinSemilattice| 'NILADIC T) 
