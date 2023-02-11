
(DECLAIM (NOTINLINE |Logic;|)) 

(DEFPARAMETER |Logic;AL| 'NIL) 

(DEFUN |Logic| () (COND (|Logic;AL|) (T (SETQ |Logic;AL| (|Logic;|))))) 

(DEFUN |Logic;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|BoundedDistributiveLattice|)
                           (|mkCategory|
                            '(((~ ($ $)) T) ((|true| ($) |constant|) T)
                              ((|false| ($) |constant|) T))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|Logic|))))) 

(MAKEPROP '|Logic| 'NILADIC T) 
