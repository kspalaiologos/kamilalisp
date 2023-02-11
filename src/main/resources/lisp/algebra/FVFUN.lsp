
(DECLAIM (NOTINLINE |FortranVectorFunctionCategory;|)) 

(DEFPARAMETER |FortranVectorFunctionCategory;AL| 'NIL) 

(DEFUN |FortranVectorFunctionCategory| ()
  (COND (|FortranVectorFunctionCategory;AL|)
        (T
         (SETQ |FortranVectorFunctionCategory;AL|
                 (|FortranVectorFunctionCategory;|))))) 

(DEFUN |FortranVectorFunctionCategory;| ()
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
                              ((|retract|
                                ($ (|Vector| (|Expression| (|Float|)))))
                               T)
                              ((|retractIfCan|
                                ((|Union| $ "failed")
                                 (|Vector| (|Expression| (|Float|)))))
                               T)
                              ((|retract|
                                ($ (|Vector| (|Expression| (|Integer|)))))
                               T)
                              ((|retractIfCan|
                                ((|Union| $ "failed")
                                 (|Vector| (|Expression| (|Integer|)))))
                               T)
                              ((|retract|
                                ($ (|Vector| (|Polynomial| (|Float|)))))
                               T)
                              ((|retractIfCan|
                                ((|Union| $ "failed")
                                 (|Vector| (|Polynomial| (|Float|)))))
                               T)
                              ((|retract|
                                ($ (|Vector| (|Polynomial| (|Integer|)))))
                               T)
                              ((|retractIfCan|
                                ((|Union| $ "failed")
                                 (|Vector| (|Polynomial| (|Integer|)))))
                               T)
                              ((|retract|
                                ($
                                 (|Vector|
                                  (|Fraction| (|Polynomial| (|Float|))))))
                               T)
                              ((|retractIfCan|
                                ((|Union| $ "failed")
                                 (|Vector|
                                  (|Fraction| (|Polynomial| (|Float|))))))
                               T)
                              ((|retract|
                                ($
                                 (|Vector|
                                  (|Fraction| (|Polynomial| (|Integer|))))))
                               T)
                              ((|retractIfCan|
                                ((|Union| $ "failed")
                                 (|Vector|
                                  (|Fraction| (|Polynomial| (|Integer|))))))
                               T))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|FortranVectorFunctionCategory|))))) 

(MAKEPROP '|FortranVectorFunctionCategory| 'NILADIC T) 
