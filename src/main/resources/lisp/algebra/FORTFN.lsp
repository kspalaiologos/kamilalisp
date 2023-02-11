
(DECLAIM (NOTINLINE |FortranFunctionCategory;|)) 

(DEFPARAMETER |FortranFunctionCategory;AL| 'NIL) 

(DEFUN |FortranFunctionCategory| ()
  (COND (|FortranFunctionCategory;AL|)
        (T (SETQ |FortranFunctionCategory;AL| (|FortranFunctionCategory;|))))) 

(DEFUN |FortranFunctionCategory;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|FortranProgramCategory|)
                           (|mkCategory|
                            '(((|coerce| ($ (|List| (|FortranCode|)))) T)
                              ((|coerce| ($ (|FortranCode|))) T)
                              ((|coerce|
                                ($
                                 (|Record| (|:| |localSymbols| (|SymbolTable|))
                                           (|:| |code|
                                                (|List| (|FortranCode|))))))
                               T)
                              ((|retract| ($ (|Expression| (|Float|)))) T)
                              ((|retractIfCan|
                                ((|Union| $ "failed")
                                 (|Expression| (|Float|))))
                               T)
                              ((|retract| ($ (|Expression| (|Integer|)))) T)
                              ((|retractIfCan|
                                ((|Union| $ "failed")
                                 (|Expression| (|Integer|))))
                               T)
                              ((|retract| ($ (|Polynomial| (|Float|)))) T)
                              ((|retractIfCan|
                                ((|Union| $ "failed")
                                 (|Polynomial| (|Float|))))
                               T)
                              ((|retract| ($ (|Polynomial| (|Integer|)))) T)
                              ((|retractIfCan|
                                ((|Union| $ "failed")
                                 (|Polynomial| (|Integer|))))
                               T)
                              ((|retract|
                                ($ (|Fraction| (|Polynomial| (|Float|)))))
                               T)
                              ((|retractIfCan|
                                ((|Union| $ "failed")
                                 (|Fraction| (|Polynomial| (|Float|)))))
                               T)
                              ((|retract|
                                ($ (|Fraction| (|Polynomial| (|Integer|)))))
                               T)
                              ((|retractIfCan|
                                ((|Union| $ "failed")
                                 (|Fraction| (|Polynomial| (|Integer|)))))
                               T))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|FortranFunctionCategory|))))) 

(MAKEPROP '|FortranFunctionCategory| 'NILADIC T) 
