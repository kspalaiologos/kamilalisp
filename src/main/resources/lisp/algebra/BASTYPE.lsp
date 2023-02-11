
(DECLAIM (NOTINLINE |BasicType;|)) 

(DEFPARAMETER |BasicType;AL| 'NIL) 

(DEFUN |BasicType| ()
  (COND (|BasicType;AL|) (T (SETQ |BasicType;AL| (|BasicType;|))))) 

(DEFUN |BasicType;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join|
                    (|mkCategory|
                     '(((= ((|Boolean|) $ $)) T) ((~= ((|Boolean|) $ $)) T))
                     NIL NIL NIL)))
           (SETELT #1# 0 '(|BasicType|))))) 

(MAKEPROP '|BasicType| 'NILADIC T) 
