
(DECLAIM (NOTINLINE |Group;|)) 

(DEFPARAMETER |Group;AL| 'NIL) 

(DEFUN |Group| () (COND (|Group;AL|) (T (SETQ |Group;AL| (|Group;|))))) 

(DEFUN |Group;| ()
  (SPROG ((#1=#:G690 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|Monoid|) (|TwoSidedRecip|) (|unitsKnown|)
                           (|mkCategory|
                            '(((|inv| ($ $)) T) ((/ ($ $ $)) T)
                              ((^ ($ $ (|Integer|))) T)
                              ((|conjugate| ($ $ $)) T)
                              ((|commutator| ($ $ $)) T))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|Group|))))) 

(MAKEPROP '|Group| 'NILADIC T) 
