
(DECLAIM (NOTINLINE |PrimitiveFunctionCategory;|)) 

(DEFPARAMETER |PrimitiveFunctionCategory;AL| 'NIL) 

(DEFUN |PrimitiveFunctionCategory| ()
  (COND (|PrimitiveFunctionCategory;AL|)
        (T
         (SETQ |PrimitiveFunctionCategory;AL| (|PrimitiveFunctionCategory;|))))) 

(DEFUN |PrimitiveFunctionCategory;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join|
                    (|mkCategory|
                     '(((|integral| ($ $ (|Symbol|))) T)
                       ((|integral| ($ $ (|SegmentBinding| $))) T))
                     NIL NIL NIL)))
           (SETELT #1# 0 '(|PrimitiveFunctionCategory|))))) 

(MAKEPROP '|PrimitiveFunctionCategory| 'NILADIC T) 
