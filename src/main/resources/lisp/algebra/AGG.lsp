
(DECLAIM (NOTINLINE |Aggregate;|)) 

(DEFPARAMETER |Aggregate;AL| 'NIL) 

(DEFUN |Aggregate| ()
  (COND (|Aggregate;AL|) (T (SETQ |Aggregate;AL| (|Aggregate;|))))) 

(DEFUN |Aggregate;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|Type|)
                           (|mkCategory|
                            '(((|eq?| ((|Boolean|) $ $)) T) ((|copy| ($ $)) T)
                              ((|empty| ($)) T) ((|empty?| ((|Boolean|) $)) T)
                              ((|less?| ((|Boolean|) $ (|NonNegativeInteger|)))
                               T)
                              ((|more?| ((|Boolean|) $ (|NonNegativeInteger|)))
                               T)
                              ((|size?| ((|Boolean|) $ (|NonNegativeInteger|)))
                               T)
                              ((|sample| ($) |constant|) T)
                              ((|#| ((|NonNegativeInteger|) $))
                               (|has| $ (|finiteAggregate|))))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|Aggregate|))))) 

(MAKEPROP '|Aggregate| 'NILADIC T) 
