
(DECLAIM (NOTINLINE |VarCat;|)) 

(DEFPARAMETER |VarCat;AL| 'NIL) 

(DEFUN |VarCat| () (COND (|VarCat;AL|) (T (SETQ |VarCat;AL| (|VarCat;|))))) 

(DEFUN |VarCat;| ()
  (SPROG ((#1=#:G690 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(#2=#:G689) (LIST '(|OutputForm|))
                                   (|Join| (|Type|) (|CoercibleTo| '#2#)
                                           (|mkCategory|
                                            '(((|var| ($ (|String|))) T)
                                              ((|var|
                                                ($ (|String|) (|ILogic|)))
                                               T)
                                              ((|getName| ((|String|) $)) T)
                                              ((|getType| ((|ILogic|) $)) T)
                                              ((|toString| ((|String|) $)) T)
                                              ((|parseVar| ($ (|String|))) T)
                                              ((|parseVarTerm|
                                                ((|Record| (|:| |rft| $)
                                                           (|:| |pout|
                                                                (|NonNegativeInteger|)))
                                                 (|String|)
                                                 (|NonNegativeInteger|)))
                                               T)
                                              ((= ((|Boolean|) $ $)) T))
                                            NIL NIL NIL))))
           (SETELT #1# 0 '(|VarCat|))))) 

(MAKEPROP '|VarCat| 'NILADIC T) 
