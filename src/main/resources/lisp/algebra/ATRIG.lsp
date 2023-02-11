
(DECLAIM (NOTINLINE |ArcTrigonometricFunctionCategory;|)) 

(DEFPARAMETER |ArcTrigonometricFunctionCategory;AL| 'NIL) 

(DEFUN |ArcTrigonometricFunctionCategory| ()
  (COND (|ArcTrigonometricFunctionCategory;AL|)
        (T
         (SETQ |ArcTrigonometricFunctionCategory;AL|
                 (|ArcTrigonometricFunctionCategory;|))))) 

(DEFUN |ArcTrigonometricFunctionCategory;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join|
                    (|mkCategory|
                     '(((|acos| ($ $)) T) ((|acot| ($ $)) T) ((|acsc| ($ $)) T)
                       ((|asec| ($ $)) T) ((|asin| ($ $)) T)
                       ((|atan| ($ $)) T))
                     NIL NIL NIL)))
           (SETELT #1# 0 '(|ArcTrigonometricFunctionCategory|))))) 

(MAKEPROP '|ArcTrigonometricFunctionCategory| 'NILADIC T) 
