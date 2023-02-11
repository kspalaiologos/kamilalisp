
(DECLAIM (NOTINLINE |PartialOrder;|)) 

(DEFPARAMETER |PartialOrder;AL| 'NIL) 

(DEFUN |PartialOrder| ()
  (COND (|PartialOrder;AL|) (T (SETQ |PartialOrder;AL| (|PartialOrder;|))))) 

(DEFUN |PartialOrder;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join|
                    (|mkCategory|
                     '(((< ((|Boolean|) $ $)) T) ((> ((|Boolean|) $ $)) T)
                       ((>= ((|Boolean|) $ $)) T) ((<= ((|Boolean|) $ $)) T))
                     NIL NIL NIL)))
           (SETELT #1# 0 '(|PartialOrder|))))) 

(MAKEPROP '|PartialOrder| 'NILADIC T) 
