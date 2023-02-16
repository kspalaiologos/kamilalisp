
(DECLAIM (NOTINLINE |MagmaWithUnit;|)) 

(DEFPARAMETER |MagmaWithUnit;AL| 'NIL) 

(DEFUN |MagmaWithUnit| ()
  (COND (|MagmaWithUnit;AL|) (T (SETQ |MagmaWithUnit;AL| (|MagmaWithUnit;|))))) 

(DEFUN |MagmaWithUnit;| ()
  (SPROG ((#1=#:G692 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|Magma|)
                           (|mkCategory|
                            '(((|One| ($) |constant|) T)
                              ((|sample| ($) |constant|) T)
                              ((|one?| ((|Boolean|) $)) T)
                              ((|rightPower| ($ $ (|NonNegativeInteger|))) T)
                              ((|leftPower| ($ $ (|NonNegativeInteger|))) T)
                              ((^ ($ $ (|NonNegativeInteger|))) T)
                              ((|recip| ((|Union| $ "failed") $)) T)
                              ((|leftRecip| ((|Union| $ "failed") $)) T)
                              ((|rightRecip| ((|Union| $ "failed") $)) T))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|MagmaWithUnit|))))) 

(MAKEPROP '|MagmaWithUnit| 'NILADIC T) 
