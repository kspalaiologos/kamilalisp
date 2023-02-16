
(DECLAIM (NOTINLINE |FormatterCategory;|)) 

(DEFPARAMETER |FormatterCategory;AL| 'NIL) 

(DEFUN |FormatterCategory| ()
  (COND (|FormatterCategory;AL|)
        (T (SETQ |FormatterCategory;AL| (|FormatterCategory;|))))) 

(DEFUN |FormatterCategory;| ()
  (SPROG ((#1=#:G721 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(#2=#:G720) (LIST '(|OutputForm|))
                                   (|Join| (|CoercibleTo| '#2#)
                                           (|mkCategory|
                                            '(((|defaultPrologue|
                                                ((|OutputBox|) (|String|)))
                                               T)
                                              ((|defaultEpilogue|
                                                ((|OutputBox|) (|String|)))
                                               T)
                                              ((|minPrecedence| ((|Integer|)))
                                               T)
                                              ((|maxPrecedence| ((|Integer|)))
                                               T)
                                              ((|formatExpression|
                                                ((|OutputBox|) (|OutputForm|)
                                                 (|Integer|)))
                                               T)
                                              ((|formatExpression|
                                                ((|OutputBox|) (|OutputForm|)))
                                               T)
                                              ((|formatInteger|
                                                ((|OutputBox|) (|Integer|)))
                                               T)
                                              ((|formatFloat|
                                                ((|OutputBox|) (|String|)))
                                               T)
                                              ((|formatString|
                                                ((|OutputBox|) (|String|)))
                                               T)
                                              ((|formatSymbol|
                                                ((|OutputBox|) (|String|)))
                                               T)
                                              ((|formatFunctionSymbol|
                                                ((|OutputBox|) (|String|)))
                                               T)
                                              ((|operatorHandlers|
                                                ((|OperatorHandlers|
                                                  (|Mapping| (|OutputBox|)
                                                             (|Integer|)
                                                             (|List|
                                                              (|OutputForm|))))))
                                               T)
                                              ((|parenthesize|
                                                ((|OutputBox|) (|String|)
                                                 (|String|) (|OutputBox|)))
                                               T)
                                              ((|parenthesizeIf|
                                                ((|OutputBox|) (|Boolean|)
                                                 (|OutputBox|)))
                                               T)
                                              ((|nothing|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))))
                                               T)
                                              ((|formatConstant|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|String|)))
                                               T)
                                              ((|formatExpression|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Integer|)))
                                               T)
                                              ((|precedence|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Integer|)
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))))
                                               T)
                                              ((|bracket|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|String|) (|String|)
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))))
                                               T)
                                              ((|prefix|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|String|) (|Integer|)
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))))
                                               T)
                                              ((|binary|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))))
                                               T)
                                              ((|infix|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|String|) (|Integer|)
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))))
                                               T)
                                              ((|nary|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|String|) (|Integer|)
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))))
                                               T)
                                              ((|naryPlus|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|String|) (|String|)
                                                 (|Integer|)
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))))
                                               T)
                                              ((|integral|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Integer|)))
                                               T)
                                              ((|sum|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Integer|)))
                                               T)
                                              ((|product|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Integer|)))
                                               T)
                                              ((|theMap|
                                                ((|OutputBox|) (|Integer|)
                                                 (|List| (|OutputForm|))))
                                               T)
                                              ((|overbar|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Integer|)
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))))
                                               T)
                                              ((|box|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))))
                                               T)
                                              ((|nthRoot|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Integer|)
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))))
                                               T)
                                              ((|scripts|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Integer|)))
                                               T)
                                              ((|subscript|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Integer|)))
                                               T)
                                              ((|altsupersub|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Integer|)))
                                               T)
                                              ((|numberOfPrimes|
                                                ((|Integer|) (|OutputForm|)))
                                               T)
                                              ((|prime|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Integer|)))
                                               T)
                                              ((|power|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Integer|)
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))))
                                               T)
                                              ((|fraction|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Integer|)
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))))
                                               T)
                                              ((|slash|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Integer|)
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))))
                                               T)
                                              ((|binomial|
                                                ((|OutputBox|) (|Integer|)
                                                 (|List| (|OutputForm|))))
                                               T)
                                              ((|zag|
                                                ((|OutputBox|) (|Integer|)
                                                 (|List| (|OutputForm|))))
                                               T)
                                              ((|vconcat|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))))
                                               T)
                                              ((|pile|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))))
                                               T)
                                              ((|matrix|
                                                ((|Mapping| (|OutputBox|)
                                                            (|Integer|)
                                                            (|List|
                                                             (|OutputForm|)))
                                                 (|String|) (|String|)))
                                               T))
                                            NIL NIL NIL))))
           (SETELT #1# 0 '(|FormatterCategory|))))) 

(MAKEPROP '|FormatterCategory| 'NILADIC T) 
