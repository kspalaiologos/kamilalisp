
(DECLAIM (NOTINLINE |BoundedMeetSemilattice;|)) 

(DEFPARAMETER |BoundedMeetSemilattice;AL| 'NIL) 

(DEFUN |BoundedMeetSemilattice| ()
  (COND (|BoundedMeetSemilattice;AL|)
        (T (SETQ |BoundedMeetSemilattice;AL| (|BoundedMeetSemilattice;|))))) 

(DEFUN |BoundedMeetSemilattice;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|MeetSemilattice|)
                           (|mkCategory| '(((T$ ($) |constant|) T)) NIL NIL
                                         NIL)))
           (SETELT #1# 0 '(|BoundedMeetSemilattice|))))) 

(MAKEPROP '|BoundedMeetSemilattice| 'NILADIC T) 
