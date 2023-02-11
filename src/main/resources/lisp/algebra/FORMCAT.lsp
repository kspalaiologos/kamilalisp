
(DECLAIM (NOTINLINE |OutputFormatterCategory;|)) 

(DEFPARAMETER |OutputFormatterCategory;AL| 'NIL) 

(DEFUN |OutputFormatterCategory| ()
  (COND (|OutputFormatterCategory;AL|)
        (T (SETQ |OutputFormatterCategory;AL| (|OutputFormatterCategory;|))))) 

(DEFUN |OutputFormatterCategory;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join|
                    (|mkCategory|
                     '(((|convert| ($ (|OutputForm|) (|Integer|))) T)
                       ((|display| ((|Void|) $)) T))
                     NIL NIL NIL)))
           (SETELT #1# 0 '(|OutputFormatterCategory|))))) 

(MAKEPROP '|OutputFormatterCategory| 'NILADIC T) 
