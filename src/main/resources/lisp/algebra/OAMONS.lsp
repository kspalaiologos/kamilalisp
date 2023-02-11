
(DECLAIM (NOTINLINE |OrderedAbelianMonoidSup;|)) 

(DEFPARAMETER |OrderedAbelianMonoidSup;AL| 'NIL) 

(DEFUN |OrderedAbelianMonoidSup| ()
  (COND (|OrderedAbelianMonoidSup;AL|)
        (T (SETQ |OrderedAbelianMonoidSup;AL| (|OrderedAbelianMonoidSup;|))))) 

(DEFUN |OrderedAbelianMonoidSup;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|OrderedCancellationAbelianMonoid|)
                           (|mkCategory|
                            '(((|sup| ($ $ $)) T) ((|inf| ($ $ $)) T)) NIL NIL
                            NIL)))
           (SETELT #1# 0 '(|OrderedAbelianMonoidSup|))))) 

(MAKEPROP '|OrderedAbelianMonoidSup| 'NILADIC T) 
