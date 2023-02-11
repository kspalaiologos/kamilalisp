
(DECLAIM (NOTINLINE |FinitelyGenerated;|)) 

(DEFPARAMETER |FinitelyGenerated;AL| 'NIL) 

(DEFUN |FinitelyGenerated| ()
  (COND (|FinitelyGenerated;AL|)
        (T (SETQ |FinitelyGenerated;AL| (|FinitelyGenerated;|))))) 

(DEFUN |FinitelyGenerated;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join|
                    (|mkCategory| '(((|generators| ((|List| $))) T)) NIL NIL
                                  NIL)))
           (SETELT #1# 0 '(|FinitelyGenerated|))))) 

(MAKEPROP '|FinitelyGenerated| 'NILADIC T) 
