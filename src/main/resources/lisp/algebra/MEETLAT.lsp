
(DECLAIM (NOTINLINE |MeetSemilattice;|)) 

(DEFPARAMETER |MeetSemilattice;AL| 'NIL) 

(DEFUN |MeetSemilattice| ()
  (COND (|MeetSemilattice;AL|)
        (T (SETQ |MeetSemilattice;AL| (|MeetSemilattice;|))))) 

(DEFUN |MeetSemilattice;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|SetCategory|)
                           (|mkCategory| '(((|/\\| ($ $ $)) T)) NIL NIL NIL)))
           (SETELT #1# 0 '(|MeetSemilattice|))))) 

(MAKEPROP '|MeetSemilattice| 'NILADIC T) 
