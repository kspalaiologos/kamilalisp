
(DECLAIM (NOTINLINE |CancellationAbelianMonoid;|)) 

(DEFPARAMETER |CancellationAbelianMonoid;AL| 'NIL) 

(DEFUN |CancellationAbelianMonoid| ()
  (COND (|CancellationAbelianMonoid;AL|)
        (T
         (SETQ |CancellationAbelianMonoid;AL| (|CancellationAbelianMonoid;|))))) 

(DEFUN |CancellationAbelianMonoid;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|AbelianMonoid|)
                           (|mkCategory|
                            '(((|subtractIfCan| ((|Union| $ "failed") $ $)) T))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|CancellationAbelianMonoid|))))) 

(MAKEPROP '|CancellationAbelianMonoid| 'NILADIC T) 
