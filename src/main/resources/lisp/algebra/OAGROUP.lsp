
(DECLAIM (NOTINLINE |OrderedAbelianGroup;|)) 

(DEFPARAMETER |OrderedAbelianGroup;AL| 'NIL) 

(DEFUN |OrderedAbelianGroup| ()
  (COND (|OrderedAbelianGroup;AL|)
        (T (SETQ |OrderedAbelianGroup;AL| (|OrderedAbelianGroup;|))))) 

(DEFUN |OrderedAbelianGroup;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|OrderedCancellationAbelianMonoid|)
                           (|AbelianGroup|)))
           (SETELT #1# 0 '(|OrderedAbelianGroup|))))) 

(MAKEPROP '|OrderedAbelianGroup| 'NILADIC T) 
