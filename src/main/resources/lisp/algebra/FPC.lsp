
(DECLAIM (NOTINLINE |FieldOfPrimeCharacteristic;|)) 

(DEFPARAMETER |FieldOfPrimeCharacteristic;AL| 'NIL) 

(DEFUN |FieldOfPrimeCharacteristic| ()
  (COND (|FieldOfPrimeCharacteristic;AL|)
        (T
         (SETQ |FieldOfPrimeCharacteristic;AL|
                 (|FieldOfPrimeCharacteristic;|))))) 

(DEFUN |FieldOfPrimeCharacteristic;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|Field|) (|CharacteristicNonZero|)
                           (|mkCategory|
                            '(((|order|
                                ((|OnePointCompletion| (|PositiveInteger|)) $))
                               T)
                              ((|discreteLog|
                                ((|Union| (|NonNegativeInteger|) "failed") $
                                 $))
                               T)
                              ((|primeFrobenius| ($ $)) T)
                              ((|primeFrobenius| ($ $ (|NonNegativeInteger|)))
                               T))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|FieldOfPrimeCharacteristic|))))) 

(MAKEPROP '|FieldOfPrimeCharacteristic| 'NILADIC T) 
