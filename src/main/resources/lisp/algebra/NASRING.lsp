
(DECLAIM (NOTINLINE |NonAssociativeSemiRing;|)) 

(DEFPARAMETER |NonAssociativeSemiRing;AL| 'NIL) 

(DEFUN |NonAssociativeSemiRing| ()
  (COND (|NonAssociativeSemiRing;AL|)
        (T (SETQ |NonAssociativeSemiRing;AL| (|NonAssociativeSemiRing;|))))) 

(DEFUN |NonAssociativeSemiRing;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|NonAssociativeSemiRng|) (|AbelianMonoid|)
                           (|MagmaWithUnit|)))
           (SETELT #1# 0 '(|NonAssociativeSemiRing|))))) 

(MAKEPROP '|NonAssociativeSemiRing| 'NILADIC T) 
