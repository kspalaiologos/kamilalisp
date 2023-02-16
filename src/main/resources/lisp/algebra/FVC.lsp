
(DECLAIM (NOTINLINE |FortranVectorCategory;|)) 

(DEFPARAMETER |FortranVectorCategory;AL| 'NIL) 

(DEFUN |FortranVectorCategory| ()
  (COND (|FortranVectorCategory;AL|)
        (T (SETQ |FortranVectorCategory;AL| (|FortranVectorCategory;|))))) 

(DEFUN |FortranVectorCategory;| ()
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|FortranProgramCategory|)
                           (|mkCategory|
                            '(((|coerce| ($ (|Vector| (|MachineFloat|)))) T)
                              ((|coerce| ($ (|List| (|FortranCode|)))) T)
                              ((|coerce| ($ (|FortranCode|))) T)
                              ((|coerce|
                                ($
                                 (|Record| (|:| |localSymbols| (|SymbolTable|))
                                           (|:| |code|
                                                (|List| (|FortranCode|))))))
                               T))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|FortranVectorCategory|))))) 

(MAKEPROP '|FortranVectorCategory| 'NILADIC T) 
