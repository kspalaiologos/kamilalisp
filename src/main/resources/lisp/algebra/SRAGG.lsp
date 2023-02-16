
(DECLAIM (NOTINLINE |StringAggregate;|)) 

(DEFPARAMETER |StringAggregate;AL| 'NIL) 

(DEFUN |StringAggregate| ()
  (COND (|StringAggregate;AL|)
        (T (SETQ |StringAggregate;AL| (|StringAggregate;|))))) 

(DEFUN |StringAggregate;| ()
  (SPROG ((#1=#:G690 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(#2=#:G689) (LIST '(|Character|))
                                   (|Join|
                                    (|OneDimensionalArrayAggregate| '#2#)
                                    (|mkCategory|
                                     '(((|lowerCase| ($ $)) T)
                                       ((|lowerCase!| ($ $)) T)
                                       ((|upperCase| ($ $)) T)
                                       ((|upperCase!| ($ $)) T)
                                       ((|prefix?| ((|Boolean|) $ $)) T)
                                       ((|suffix?| ((|Boolean|) $ $)) T)
                                       ((|substring?|
                                         ((|Boolean|) $ $ (|Integer|)))
                                        T)
                                       ((|match?|
                                         ((|Boolean|) $ $ (|Character|)))
                                        T)
                                       ((|replace|
                                         ($ $ (|UniversalSegment| (|Integer|))
                                          $))
                                        T)
                                       ((|position|
                                         ((|Integer|) $ $ (|Integer|)))
                                        T)
                                       ((|position|
                                         ((|Integer|) (|CharacterClass|) $
                                          (|Integer|)))
                                        T)
                                       ((|coerce| ($ (|Character|))) T)
                                       ((|split| ((|List| $) $ (|Character|)))
                                        T)
                                       ((|split|
                                         ((|List| $) $ (|CharacterClass|)))
                                        T)
                                       ((|trim| ($ $ (|CharacterClass|))) T)
                                       ((|leftTrim| ($ $ (|CharacterClass|)))
                                        T)
                                       ((|rightTrim| ($ $ (|CharacterClass|)))
                                        T)
                                       ((|elt| ($ $ $)) T))
                                     NIL NIL NIL))))
           (SETELT #1# 0 '(|StringAggregate|))))) 

(MAKEPROP '|StringAggregate| 'NILADIC T) 
