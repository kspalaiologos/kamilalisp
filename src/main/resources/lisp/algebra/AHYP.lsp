
(DECLAIM (NOTINLINE |ArcHyperbolicFunctionCategory;|)) 

(DEFPARAMETER |ArcHyperbolicFunctionCategory;AL| 'NIL) 

(DEFUN |ArcHyperbolicFunctionCategory| ()
  (COND (|ArcHyperbolicFunctionCategory;AL|)
        (T
         (SETQ |ArcHyperbolicFunctionCategory;AL|
                 (|ArcHyperbolicFunctionCategory;|))))) 

(DEFUN |ArcHyperbolicFunctionCategory;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join|
                    (|mkCategory|
                     '(((|acosh| ($ $)) T) ((|acoth| ($ $)) T)
                       ((|acsch| ($ $)) T) ((|asech| ($ $)) T)
                       ((|asinh| ($ $)) T) ((|atanh| ($ $)) T))
                     NIL NIL NIL)))
           (SETELT #1# 0 '(|ArcHyperbolicFunctionCategory|))))) 

(MAKEPROP '|ArcHyperbolicFunctionCategory| 'NILADIC T) 
