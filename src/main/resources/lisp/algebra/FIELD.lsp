
(DECLAIM (NOTINLINE |Field;|)) 

(DEFPARAMETER |Field;AL| 'NIL) 

(DEFUN |Field| () (COND (|Field;AL|) (T (SETQ |Field;AL| (|Field;|))))) 

(DEFUN |Field;| ()
  (SPROG ((#1=#:G694 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|EuclideanDomain|) (|UniqueFactorizationDomain|)
                           (|DivisionRing|) (|canonicalUnitNormal|)
                           (|canonicalsClosed|)
                           (|mkCategory| '(((/ ($ $ $)) T)) NIL NIL NIL)))
           (SETELT #1# 0 '(|Field|))))) 

(MAKEPROP '|Field| 'NILADIC T) 
