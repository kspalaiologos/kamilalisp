
(DEFPARAMETER |JetBundleFunctionCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |JetBundleFunctionCategory;|)) 

(DEFPARAMETER |JetBundleFunctionCategory;AL| 'NIL) 

(DEFUN |JetBundleFunctionCategory| (|t#1|)
  (LET (#1=#:G745 (#2=#:G746 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |JetBundleFunctionCategory;AL|)) (CDR #1#))
          (T
           (SETQ |JetBundleFunctionCategory;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (|JetBundleFunctionCategory;| #2#)))
                    |JetBundleFunctionCategory;AL|))
           #1#)))) 

(DEFUN |JetBundleFunctionCategory;| (|t#1|)
  (SPROG ((#1=#:G744 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (|subst_in_cat| '(#2=#:G743)
                                                   (LIST '(|Symbol|))
                                                   (COND
                                                    (|JetBundleFunctionCategory;CAT|)
                                                    ('T
                                                     (LETT
                                                      |JetBundleFunctionCategory;CAT|
                                                      (|Join|
                                                       (|PartialDifferentialRing|
                                                        '#2#)
                                                       (|GcdDomain|)
                                                       (|RetractableTo| '|t#1|)
                                                       (|mkCategory|
                                                        '(((X
                                                            ($
                                                             (|PositiveInteger|)))
                                                           T)
                                                          ((U
                                                            ($
                                                             (|PositiveInteger|)))
                                                           T)
                                                          ((P
                                                            ($
                                                             (|PositiveInteger|)
                                                             (|List|
                                                              (|NonNegativeInteger|))))
                                                           T)
                                                          ((X ($)) T)
                                                          ((U ($)) T)
                                                          ((P
                                                            ($
                                                             (|List|
                                                              (|NonNegativeInteger|))))
                                                           T)
                                                          ((P
                                                            ($
                                                             (|PositiveInteger|)
                                                             (|NonNegativeInteger|)))
                                                           T)
                                                          ((P
                                                            ($
                                                             (|NonNegativeInteger|)))
                                                           T)
                                                          ((|setNotation|
                                                            ((|Void|)
                                                             (|Symbol|)))
                                                           T)
                                                          ((|getNotation|
                                                            ((|Symbol|)))
                                                           T)
                                                          ((|numIndVar|
                                                            ((|PositiveInteger|)))
                                                           T)
                                                          ((|numDepVar|
                                                            ((|PositiveInteger|)))
                                                           T)
                                                          ((|coerce| ($ |t#1|))
                                                           T)
                                                          ((|jetVariables|
                                                            ((|List| |t#1|) $))
                                                           T)
                                                          ((|const?|
                                                            ((|Boolean|) $))
                                                           T)
                                                          ((|order|
                                                            ((|NonNegativeInteger|)
                                                             $))
                                                           T)
                                                          ((|class|
                                                            ((|NonNegativeInteger|)
                                                             $))
                                                           T)
                                                          ((|numerator| ($ $))
                                                           T)
                                                          ((|denominator|
                                                            ($ $))
                                                           T)
                                                          ((|jacobiMatrix|
                                                            ((|SparseEchelonMatrix|
                                                              |t#1| $)
                                                             (|List| $)))
                                                           T)
                                                          ((|jacobiMatrix|
                                                            ((|SparseEchelonMatrix|
                                                              |t#1| $)
                                                             (|List| $)
                                                             (|List|
                                                              (|List| |t#1|))))
                                                           T)
                                                          ((|extractSymbol|
                                                            ((|SparseEchelonMatrix|
                                                              |t#1| $)
                                                             (|SparseEchelonMatrix|
                                                              |t#1| $)))
                                                           T)
                                                          ((|symbol|
                                                            ((|SparseEchelonMatrix|
                                                              |t#1| $)
                                                             (|List| $)))
                                                           T)
                                                          ((|differentiate|
                                                            ($ $ |t#1|))
                                                           T)
                                                          ((|formalDiff|
                                                            ($ $
                                                             (|PositiveInteger|)))
                                                           T)
                                                          ((|formalDiff|
                                                            ($ $
                                                             (|List|
                                                              (|NonNegativeInteger|))))
                                                           T)
                                                          ((|formalDiff|
                                                            ((|List| $)
                                                             (|List| $)
                                                             (|PositiveInteger|)))
                                                           T)
                                                          ((|formalDiff2|
                                                            ((|Record|
                                                              (|:| |DPhi| $)
                                                              (|:| |JVars|
                                                                   (|List|
                                                                    |t#1|)))
                                                             $
                                                             (|PositiveInteger|)
                                                             (|SparseEchelonMatrix|
                                                              |t#1| $)))
                                                           T)
                                                          ((|formalDiff2|
                                                            ((|Record|
                                                              (|:| |DSys|
                                                                   (|List| $))
                                                              (|:| |JVars|
                                                                   (|List|
                                                                    (|List|
                                                                     |t#1|))))
                                                             (|List| $)
                                                             (|PositiveInteger|)
                                                             (|SparseEchelonMatrix|
                                                              |t#1| $)))
                                                           T)
                                                          ((|dimension|
                                                            ((|NonNegativeInteger|)
                                                             (|List| $)
                                                             (|SparseEchelonMatrix|
                                                              |t#1| $)
                                                             (|NonNegativeInteger|)))
                                                           T)
                                                          ((|orderDim|
                                                            ((|NonNegativeInteger|)
                                                             (|List| $)
                                                             (|SparseEchelonMatrix|
                                                              |t#1| $)
                                                             (|NonNegativeInteger|)))
                                                           T)
                                                          ((|freeOf?|
                                                            ((|Boolean|) $
                                                             |t#1|))
                                                           T)
                                                          ((|subst|
                                                            ($ $ |t#1| $))
                                                           T)
                                                          ((|leadingDer|
                                                            (|t#1| $))
                                                           T)
                                                          ((|sortLD|
                                                            ((|List| $)
                                                             (|List| $)))
                                                           T)
                                                          ((|solveFor|
                                                            ((|Union| $
                                                                      "failed")
                                                             $ |t#1|))
                                                           T)
                                                          ((|dSubst|
                                                            ($ $ |t#1| $))
                                                           T)
                                                          ((|simplify|
                                                            ((|Record|
                                                              (|:| |Sys|
                                                                   (|List| $))
                                                              (|:| JM
                                                                   (|SparseEchelonMatrix|
                                                                    |t#1| $))
                                                              (|:| |Depend|
                                                                   (|Union|
                                                                    #3="failed"
                                                                    (|List|
                                                                     (|List|
                                                                      (|NonNegativeInteger|))))))
                                                             (|List| $)
                                                             (|SparseEchelonMatrix|
                                                              |t#1| $)))
                                                           T)
                                                          ((|simpOne| ($ $)) T)
                                                          ((|simpMod|
                                                            ((|List| $)
                                                             (|List| $)
                                                             (|List| $)))
                                                           T)
                                                          ((|simpMod|
                                                            ((|Record|
                                                              (|:| |Sys|
                                                                   (|List| $))
                                                              (|:| JM
                                                                   (|SparseEchelonMatrix|
                                                                    |t#1| $))
                                                              (|:| |Depend|
                                                                   (|Union| #3#
                                                                            (|List|
                                                                             (|List|
                                                                              (|NonNegativeInteger|))))))
                                                             (|List| $)
                                                             (|SparseEchelonMatrix|
                                                              |t#1| $)
                                                             (|List| $)))
                                                           T)
                                                          ((|reduceMod|
                                                            ((|List| $)
                                                             (|List| $)
                                                             (|List| $)))
                                                           T)
                                                          ((|autoReduce|
                                                            ((|List| $)
                                                             (|List| $)))
                                                           T))
                                                        NIL NIL NIL))))))))
           (SETELT #1# 0 (LIST '|JetBundleFunctionCategory| |t#1|))))) 
