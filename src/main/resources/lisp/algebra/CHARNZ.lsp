
(DECLAIM (NOTINLINE |CharacteristicNonZero;|)) 

(DEFPARAMETER |CharacteristicNonZero;AL| 'NIL) 

(DEFUN |CharacteristicNonZero| ()
  (COND (|CharacteristicNonZero;AL|)
        (T (SETQ |CharacteristicNonZero;AL| (|CharacteristicNonZero;|))))) 

(DEFUN |CharacteristicNonZero;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|Ring|)
                           (|mkCategory|
                            '(((|charthRoot| ((|Union| $ "failed") $)) T)) NIL
                            NIL NIL)))
           (SETELT #1# 0 '(|CharacteristicNonZero|))))) 

(MAKEPROP '|CharacteristicNonZero| 'NILADIC T) 
