
(DECLAIM (NOTINLINE |JetBundleCategory;|)) 

(DEFPARAMETER |JetBundleCategory;AL| 'NIL) 

(DEFUN |JetBundleCategory| ()
  (COND (|JetBundleCategory;AL|)
        (T (SETQ |JetBundleCategory;AL| (|JetBundleCategory;|))))) 

(DEFUN |JetBundleCategory;| ()
  (SPROG ((#1=#:G716 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(#2=#:G715)
                                   (LIST '(|Expression| (|Integer|)))
                                   (|Join| (|OrderedSet|) (|CoercibleTo| '#2#)
                                           (|mkCategory|
                                            '(((|setNotation|
                                                ((|Symbol|) (|Symbol|)))
                                               T)
                                              ((|getNotation| ((|Symbol|))) T)
                                              ((|multiIndex|
                                                ((|List|
                                                  (|NonNegativeInteger|))
                                                 $))
                                               T)
                                              ((|repeatedIndex|
                                                ((|List| (|PositiveInteger|))
                                                 $))
                                               T)
                                              ((|r2m|
                                                ((|List|
                                                  (|NonNegativeInteger|))
                                                 (|List| (|PositiveInteger|))))
                                               T)
                                              ((|m2r|
                                                ((|List| (|PositiveInteger|))
                                                 (|List|
                                                  (|NonNegativeInteger|))))
                                               T)
                                              ((|allRepeated|
                                                ((|List|
                                                  (|List| (|PositiveInteger|)))
                                                 (|List|
                                                  (|NonNegativeInteger|))))
                                               T)
                                              ((|index|
                                                ((|PositiveInteger|) $))
                                               T)
                                              ((|type| ((|Symbol|) $)) T)
                                              ((|name| ((|Symbol|) $)) T)
                                              ((|class|
                                                ((|NonNegativeInteger|)
                                                 (|List|
                                                  (|NonNegativeInteger|))))
                                               T)
                                              ((|class|
                                                ((|NonNegativeInteger|) $))
                                               T)
                                              ((|order|
                                                ((|NonNegativeInteger|) $))
                                               T)
                                              ((|weight|
                                                ((|NonNegativeInteger|) $))
                                               T)
                                              ((> ((|Boolean|) $ $)) T)
                                              ((|differentiate|
                                                ((|Union| $ "0") $
                                                 (|PositiveInteger|)))
                                               T)
                                              ((|derivativeOf?|
                                                ((|List|
                                                  (|NonNegativeInteger|))
                                                 $ $))
                                               T)
                                              ((|integrateIfCan|
                                                ((|Union| $ "failed") $
                                                 (|PositiveInteger|)))
                                               T)
                                              ((|integrate|
                                                ($ $ (|PositiveInteger|)))
                                               T)
                                              ((X ($ (|PositiveInteger|))) T)
                                              ((U ($ (|PositiveInteger|))) T)
                                              ((P
                                                ($ (|PositiveInteger|)
                                                 (|List|
                                                  (|NonNegativeInteger|))))
                                               T)
                                              ((|Pm|
                                                ($ (|PositiveInteger|)
                                                 (|List|
                                                  (|NonNegativeInteger|))))
                                               T)
                                              ((|Pr|
                                                ($ (|PositiveInteger|)
                                                 (|List| (|PositiveInteger|))))
                                               T)
                                              ((|One| ($) |constant|) T)
                                              ((|one?| ((|Boolean|) $)) T)
                                              ((X ($)) T) ((U ($)) T)
                                              ((P
                                                ($
                                                 (|List|
                                                  (|NonNegativeInteger|))))
                                               T)
                                              ((P
                                                ($ (|PositiveInteger|)
                                                 (|NonNegativeInteger|)))
                                               T)
                                              ((P ($ (|NonNegativeInteger|)))
                                               T)
                                              ((|variables|
                                                ((|List| $)
                                                 (|NonNegativeInteger|)))
                                               T)
                                              ((|variables|
                                                ((|List| $)
                                                 (|NonNegativeInteger|)
                                                 (|PositiveInteger|)))
                                               T)
                                              ((|dimJ|
                                                ((|NonNegativeInteger|)
                                                 (|NonNegativeInteger|)))
                                               T)
                                              ((|dimS|
                                                ((|NonNegativeInteger|)
                                                 (|NonNegativeInteger|)))
                                               T)
                                              ((|numIndVar|
                                                ((|PositiveInteger|)))
                                               T)
                                              ((|numDepVar|
                                                ((|PositiveInteger|)))
                                               T))
                                            NIL NIL NIL))))
           (SETELT #1# 0 '(|JetBundleCategory|))))) 

(MAKEPROP '|JetBundleCategory| 'NILADIC T) 
