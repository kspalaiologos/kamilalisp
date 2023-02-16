
(DECLAIM (NOTINLINE |RadicalCategory;|)) 

(DEFPARAMETER |RadicalCategory;AL| 'NIL) 

(DEFUN |RadicalCategory| ()
  (COND (|RadicalCategory;AL|)
        (T (SETQ |RadicalCategory;AL| (|RadicalCategory;|))))) 

(DEFUN |RadicalCategory;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join|
                    (|mkCategory|
                     '(((|sqrt| ($ $)) T) ((|nthRoot| ($ $ (|Integer|))) T)
                       ((^ ($ $ (|Fraction| (|Integer|)))) T))
                     NIL NIL NIL)))
           (SETELT #1# 0 '(|RadicalCategory|))))) 

(MAKEPROP '|RadicalCategory| 'NILADIC T) 
