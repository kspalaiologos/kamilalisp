
(DECLAIM (NOTINLINE |VariablesCommuteWithCoefficients;|)) 

(DEFPARAMETER |VariablesCommuteWithCoefficients;AL| 'NIL) 

(DEFUN |VariablesCommuteWithCoefficients| ()
  (COND (|VariablesCommuteWithCoefficients;AL|)
        (T
         (SETQ |VariablesCommuteWithCoefficients;AL|
                 (|VariablesCommuteWithCoefficients;|))))) 

(DEFUN |VariablesCommuteWithCoefficients;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|mkCategory| NIL NIL NIL NIL)))
           (SETELT #1# 0 '(|VariablesCommuteWithCoefficients|))))) 

(MAKEPROP '|VariablesCommuteWithCoefficients| 'NILADIC T) 
