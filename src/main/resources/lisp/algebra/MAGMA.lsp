
(DECLAIM (NOTINLINE |Magma;|)) 

(DEFPARAMETER |Magma;AL| 'NIL) 

(DEFUN |Magma| () (COND (|Magma;AL|) (T (SETQ |Magma;AL| (|Magma;|))))) 

(DEFUN |Magma;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|SetCategory|)
                           (|mkCategory|
                            '(((* ($ $ $)) T)
                              ((|rightPower| ($ $ (|PositiveInteger|))) T)
                              ((|leftPower| ($ $ (|PositiveInteger|))) T)
                              ((^ ($ $ (|PositiveInteger|))) T))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|Magma|))))) 

(MAKEPROP '|Magma| 'NILADIC T) 
