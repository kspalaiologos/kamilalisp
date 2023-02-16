
(DECLAIM (NOTINLINE |DifferentialRing;|)) 

(DEFPARAMETER |DifferentialRing;AL| 'NIL) 

(DEFUN |DifferentialRing| ()
  (COND (|DifferentialRing;AL|)
        (T (SETQ |DifferentialRing;AL| (|DifferentialRing;|))))) 

(DEFUN |DifferentialRing;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|Ring|)
                           (|mkCategory|
                            '(((|differentiate| ($ $)) T) ((D ($ $)) T)
                              ((|differentiate| ($ $ (|NonNegativeInteger|)))
                               T)
                              ((D ($ $ (|NonNegativeInteger|))) T))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|DifferentialRing|))))) 

(MAKEPROP '|DifferentialRing| 'NILADIC T) 
