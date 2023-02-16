
(DECLAIM (NOTINLINE |FiniteGroup;|)) 

(DEFPARAMETER |FiniteGroup;AL| 'NIL) 

(DEFUN |FiniteGroup| ()
  (COND (|FiniteGroup;AL|) (T (SETQ |FiniteGroup;AL| (|FiniteGroup;|))))) 

(DEFUN |FiniteGroup;| ()
  (SPROG ((#1=#:G690 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|Group|) (|Finite|)
                           (|mkCategory| '(((|order| ((|Integer|) $)) T)) NIL
                                         NIL NIL)))
           (SETELT #1# 0 '(|FiniteGroup|))))) 

(MAKEPROP '|FiniteGroup| 'NILADIC T) 
