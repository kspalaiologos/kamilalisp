
(DECLAIM (NOTINLINE |OpenMath;|)) 

(DEFPARAMETER |OpenMath;AL| 'NIL) 

(DEFUN |OpenMath| ()
  (COND (|OpenMath;AL|) (T (SETQ |OpenMath;AL| (|OpenMath;|))))) 

(DEFUN |OpenMath;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join|
                    (|mkCategory|
                     '(((|OMwrite| ((|String|) $)) T)
                       ((|OMwrite| ((|String|) $ (|Boolean|))) T)
                       ((|OMwrite| ((|Void|) (|OpenMathDevice|) $)) T)
                       ((|OMwrite| ((|Void|) (|OpenMathDevice|) $ (|Boolean|)))
                        T))
                     NIL NIL NIL)))
           (SETELT #1# 0 '(|OpenMath|))))) 

(MAKEPROP '|OpenMath| 'NILADIC T) 
