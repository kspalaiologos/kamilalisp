
(DECLAIM (NOTINLINE |CombinatorialFunctionCategory;|)) 

(DEFPARAMETER |CombinatorialFunctionCategory;AL| 'NIL) 

(DEFUN |CombinatorialFunctionCategory| ()
  (COND (|CombinatorialFunctionCategory;AL|)
        (T
         (SETQ |CombinatorialFunctionCategory;AL|
                 (|CombinatorialFunctionCategory;|))))) 

(DEFUN |CombinatorialFunctionCategory;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join|
                    (|mkCategory|
                     '(((|binomial| ($ $ $)) T) ((|factorial| ($ $)) T)
                       ((|permutation| ($ $ $)) T))
                     NIL NIL NIL)))
           (SETELT #1# 0 '(|CombinatorialFunctionCategory|))))) 

(MAKEPROP '|CombinatorialFunctionCategory| 'NILADIC T) 
