
(DECLAIM (NOTINLINE |OrderedCancellationAbelianMonoid;|)) 

(DEFPARAMETER |OrderedCancellationAbelianMonoid;AL| 'NIL) 

(DEFUN |OrderedCancellationAbelianMonoid| ()
  (COND (|OrderedCancellationAbelianMonoid;AL|)
        (T
         (SETQ |OrderedCancellationAbelianMonoid;AL|
                 (|OrderedCancellationAbelianMonoid;|))))) 

(DEFUN |OrderedCancellationAbelianMonoid;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|OrderedAbelianMonoid|)
                           (|CancellationAbelianMonoid|)))
           (SETELT #1# 0 '(|OrderedCancellationAbelianMonoid|))))) 

(MAKEPROP '|OrderedCancellationAbelianMonoid| 'NILADIC T) 
