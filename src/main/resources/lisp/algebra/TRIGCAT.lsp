
(DECLAIM (NOTINLINE |TrigonometricFunctionCategory;|)) 

(DEFPARAMETER |TrigonometricFunctionCategory;AL| 'NIL) 

(DEFUN |TrigonometricFunctionCategory| ()
  (COND (|TrigonometricFunctionCategory;AL|)
        (T
         (SETQ |TrigonometricFunctionCategory;AL|
                 (|TrigonometricFunctionCategory;|))))) 

(DEFUN |TrigonometricFunctionCategory;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join|
                    (|mkCategory|
                     '(((|cos| ($ $)) T) ((|cot| ($ $)) T) ((|csc| ($ $)) T)
                       ((|sec| ($ $)) T) ((|sin| ($ $)) T) ((|tan| ($ $)) T))
                     NIL NIL NIL)))
           (SETELT #1# 0 '(|TrigonometricFunctionCategory|))))) 

(MAKEPROP '|TrigonometricFunctionCategory| 'NILADIC T) 
