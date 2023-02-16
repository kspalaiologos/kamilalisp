
(DECLAIM (NOTINLINE |NonAssociativeRing;|)) 

(DEFPARAMETER |NonAssociativeRing;AL| 'NIL) 

(DEFUN |NonAssociativeRing| ()
  (COND (|NonAssociativeRing;AL|)
        (T (SETQ |NonAssociativeRing;AL| (|NonAssociativeRing;|))))) 

(DEFUN |NonAssociativeRing;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|NonAssociativeRng|) (|NonAssociativeSemiRing|)
                           (|mkCategory|
                            '(((|characteristic| ((|NonNegativeInteger|))) T)
                              ((|coerce| ($ (|Integer|))) T))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|NonAssociativeRing|))))) 

(MAKEPROP '|NonAssociativeRing| 'NILADIC T) 
