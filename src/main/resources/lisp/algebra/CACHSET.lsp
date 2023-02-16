
(DECLAIM (NOTINLINE |CachableSet;|)) 

(DEFPARAMETER |CachableSet;AL| 'NIL) 

(DEFUN |CachableSet| ()
  (COND (|CachableSet;AL|) (T (SETQ |CachableSet;AL| (|CachableSet;|))))) 

(DEFUN |CachableSet;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|SetCategory|)
                           (|mkCategory|
                            '(((|position| ((|NonNegativeInteger|) $)) T)
                              ((|setPosition|
                                ((|Void|) $ (|NonNegativeInteger|)))
                               T))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|CachableSet|))))) 

(MAKEPROP '|CachableSet| 'NILADIC T) 
