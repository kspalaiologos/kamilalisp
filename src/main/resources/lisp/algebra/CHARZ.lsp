
(DECLAIM (NOTINLINE |CharacteristicZero;|)) 

(DEFPARAMETER |CharacteristicZero;AL| 'NIL) 

(DEFUN |CharacteristicZero| ()
  (COND (|CharacteristicZero;AL|)
        (T (SETQ |CharacteristicZero;AL| (|CharacteristicZero;|))))) 

(DEFUN |CharacteristicZero;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1 (LETT #1# (|Join| (|Ring|)))
           (SETELT #1# 0 '(|CharacteristicZero|))))) 

(MAKEPROP '|CharacteristicZero| 'NILADIC T) 
