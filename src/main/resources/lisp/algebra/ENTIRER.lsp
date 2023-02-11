
(DECLAIM (NOTINLINE |EntireRing;|)) 

(DEFPARAMETER |EntireRing;AL| 'NIL) 

(DEFUN |EntireRing| ()
  (COND (|EntireRing;AL|) (T (SETQ |EntireRing;AL| (|EntireRing;|))))) 

(DEFUN |EntireRing;| ()
  (SPROG ((#1=#:G696 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|Ring|) (|noZeroDivisors|)
                           (|mkCategory|
                            '(((|exquo| ((|Union| $ "failed") $ $)) T)
                              ((|unitNormal|
                                ((|Record| (|:| |unit| $) (|:| |canonical| $)
                                           (|:| |associate| $))
                                 $))
                               T)
                              ((|unitCanonical| ($ $)) T)
                              ((|associates?| ((|Boolean|) $ $)) T)
                              ((|unit?| ((|Boolean|) $)) T))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|EntireRing|))))) 

(MAKEPROP '|EntireRing| 'NILADIC T) 
