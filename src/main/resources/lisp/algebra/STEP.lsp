
(DECLAIM (NOTINLINE |StepThrough;|)) 

(DEFPARAMETER |StepThrough;AL| 'NIL) 

(DEFUN |StepThrough| ()
  (COND (|StepThrough;AL|) (T (SETQ |StepThrough;AL| (|StepThrough;|))))) 

(DEFUN |StepThrough;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|SetCategory|)
                           (|mkCategory|
                            '(((|init| ($) |constant|) T)
                              ((|nextItem| ((|Union| $ "failed") $)) T))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|StepThrough|))))) 

(MAKEPROP '|StepThrough| 'NILADIC T) 
