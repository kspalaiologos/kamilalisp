
(DECLAIM (NOTINLINE |LiouvillianFunctionCategory;|)) 

(DEFPARAMETER |LiouvillianFunctionCategory;AL| 'NIL) 

(DEFUN |LiouvillianFunctionCategory| ()
  (COND (|LiouvillianFunctionCategory;AL|)
        (T
         (SETQ |LiouvillianFunctionCategory;AL|
                 (|LiouvillianFunctionCategory;|))))) 

(DEFUN |LiouvillianFunctionCategory;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|PrimitiveFunctionCategory|)
                           (|TranscendentalFunctionCategory|)
                           (|mkCategory|
                            '(((|Ei| ($ $)) T) ((|Si| ($ $)) T)
                              ((|Ci| ($ $)) T) ((|Shi| ($ $)) T)
                              ((|Chi| ($ $)) T) ((|li| ($ $)) T)
                              ((|dilog| ($ $)) T) ((|erf| ($ $)) T)
                              ((|erfi| ($ $)) T) ((|fresnelS| ($ $)) T)
                              ((|fresnelC| ($ $)) T))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|LiouvillianFunctionCategory|))))) 

(MAKEPROP '|LiouvillianFunctionCategory| 'NILADIC T) 
