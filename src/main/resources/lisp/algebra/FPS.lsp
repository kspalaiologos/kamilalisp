
(DECLAIM (NOTINLINE |FloatingPointSystem;|)) 

(DEFPARAMETER |FloatingPointSystem;AL| 'NIL) 

(DEFUN |FloatingPointSystem| ()
  (COND (|FloatingPointSystem;AL|)
        (T (SETQ |FloatingPointSystem;AL| (|FloatingPointSystem;|))))) 

(DEFUN |FloatingPointSystem;| ()
  (SPROG ((#1=#:G690 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(#2=#:G689) (LIST '(|String|))
                                   (|Join| (|RealNumberSystem|) (|Approximate|)
                                           (|ConvertibleTo| '#2#)
                                           (|mkCategory|
                                            '(((/ ($ $ (|Integer|))) T)
                                              ((|float|
                                                ($ (|Integer|) (|Integer|)))
                                               T)
                                              ((|float|
                                                ($ (|Integer|) (|Integer|)
                                                 (|PositiveInteger|)))
                                               T)
                                              ((|order| ((|Integer|) $)) T)
                                              ((|base| ((|PositiveInteger|)))
                                               T)
                                              ((|exponent| ((|Integer|) $)) T)
                                              ((|mantissa| ((|Integer|) $)) T)
                                              ((|toString| ((|String|) $)) T)
                                              ((|toString|
                                                ((|String|) $
                                                 (|NonNegativeInteger|)))
                                               T)
                                              ((|bits| ((|PositiveInteger|)))
                                               T)
                                              ((|digits| ((|PositiveInteger|)))
                                               T)
                                              ((|precision|
                                                ((|PositiveInteger|)))
                                               T)
                                              ((|bits|
                                                ((|PositiveInteger|)
                                                 (|PositiveInteger|)))
                                               (|has| $
                                                      (|arbitraryPrecision|)))
                                              ((|digits|
                                                ((|PositiveInteger|)
                                                 (|PositiveInteger|)))
                                               (|has| $
                                                      (|arbitraryPrecision|)))
                                              ((|precision|
                                                ((|PositiveInteger|)
                                                 (|PositiveInteger|)))
                                               (|has| $
                                                      (|arbitraryPrecision|)))
                                              ((|increasePrecision|
                                                ((|PositiveInteger|)
                                                 (|Integer|)))
                                               (|has| $
                                                      (|arbitraryPrecision|)))
                                              ((|decreasePrecision|
                                                ((|PositiveInteger|)
                                                 (|Integer|)))
                                               (|has| $
                                                      (|arbitraryPrecision|)))
                                              ((|min| ($))
                                               (AND
                                                (|not|
                                                 (|has| $
                                                        (|arbitraryPrecision|)))
                                                (|not|
                                                 (|has| $
                                                        (|arbitraryExponent|)))))
                                              ((|max| ($))
                                               (AND
                                                (|not|
                                                 (|has| $
                                                        (|arbitraryPrecision|)))
                                                (|not|
                                                 (|has| $
                                                        (|arbitraryExponent|))))))
                                            NIL NIL NIL))))
           (SETELT #1# 0 '(|FloatingPointSystem|))))) 

(MAKEPROP '|FloatingPointSystem| 'NILADIC T) 
