
(DECLAIM (NOTINLINE |UniqueFactorizationDomain;|)) 

(DEFPARAMETER |UniqueFactorizationDomain;AL| 'NIL) 

(DEFUN |UniqueFactorizationDomain| ()
  (COND (|UniqueFactorizationDomain;AL|)
        (T
         (SETQ |UniqueFactorizationDomain;AL| (|UniqueFactorizationDomain;|))))) 

(DEFUN |UniqueFactorizationDomain;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|GcdDomain|)
                           (|mkCategory|
                            '(((|prime?| ((|Boolean|) $)) T)
                              ((|squareFree| ((|Factored| $) $)) T)
                              ((|squareFreePart| ($ $)) T)
                              ((|factor| ((|Factored| $) $)) T))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|UniqueFactorizationDomain|))))) 

(MAKEPROP '|UniqueFactorizationDomain| 'NILADIC T) 
