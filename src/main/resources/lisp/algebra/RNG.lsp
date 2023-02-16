
(DECLAIM (NOTINLINE |Rng;|)) 

(DEFPARAMETER |Rng;AL| 'NIL) 

(DEFUN |Rng| () (COND (|Rng;AL|) (T (SETQ |Rng;AL| (|Rng;|))))) 

(DEFUN |Rng;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|NonAssociativeRng|) (|SemiRng|)
                           (|mkCategory|
                            '(((|annihilate?| ((|Boolean|) $ $)) T)) NIL NIL
                            NIL)))
           (SETELT #1# 0 '(|Rng|))))) 

(MAKEPROP '|Rng| 'NILADIC T) 
