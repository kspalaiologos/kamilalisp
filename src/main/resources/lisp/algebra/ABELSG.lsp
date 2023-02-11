
(DECLAIM (NOTINLINE |AbelianSemiGroup;|)) 

(DEFPARAMETER |AbelianSemiGroup;AL| 'NIL) 

(DEFUN |AbelianSemiGroup| ()
  (COND (|AbelianSemiGroup;AL|)
        (T (SETQ |AbelianSemiGroup;AL| (|AbelianSemiGroup;|))))) 

(DEFUN |AbelianSemiGroup;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|SetCategory|)
                           (|mkCategory|
                            '(((+ ($ $ $)) T)
                              ((* ($ (|PositiveInteger|) $)) T))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|AbelianSemiGroup|))))) 

(MAKEPROP '|AbelianSemiGroup| 'NILADIC T) 
