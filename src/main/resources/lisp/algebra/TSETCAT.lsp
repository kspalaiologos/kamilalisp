
(DEFPARAMETER |TriangularSetCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |TriangularSetCategory;|)) 

(DEFPARAMETER |TriangularSetCategory;AL| 'NIL) 

(DEFUN |TriangularSetCategory| (|t#1| |t#2| |t#3| |t#4|)
  (LET (#1=#:G754
        (#2=#:G755
         (LIST (|devaluate| |t#1|) (|devaluate| |t#2|) (|devaluate| |t#3|)
               (|devaluate| |t#4|))))
    (COND ((SETQ #1# (|assoc| #2# |TriangularSetCategory;AL|)) (CDR #1#))
          (T
           (SETQ |TriangularSetCategory;AL|
                   (|cons5|
                    (CONS #2#
                          (SETQ #1# (APPLY #'|TriangularSetCategory;| #2#)))
                    |TriangularSetCategory;AL|))
           #1#)))) 

(DEFUN |TriangularSetCategory;| (|t#1| |t#2| |t#3| |t#4|)
  (SPROG ((#1=#:G753 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2| |t#3| |t#4|)
                                   (LIST |t#1| |t#2| |t#3| |t#4|)
                                   (COND (|TriangularSetCategory;CAT|)
                                         ('T
                                          (LETT |TriangularSetCategory;CAT|
                                                (|Join|
                                                 (|PolynomialSetCategory|
                                                  '|t#1| '|t#2| '|t#3| '|t#4|)
                                                 (|finiteAggregate|)
                                                 (|shallowlyMutable|)
                                                 (|mkCategory|
                                                  '(((|infRittWu?|
                                                      ((|Boolean|) $ $))
                                                     T)
                                                    ((|basicSet|
                                                      ((|Union|
                                                        (|Record| (|:| |bas| $)
                                                                  (|:| |top|
                                                                       (|List|
                                                                        |t#4|)))
                                                        "failed")
                                                       (|List| |t#4|)
                                                       (|Mapping| (|Boolean|)
                                                                  |t#4|
                                                                  |t#4|)))
                                                     T)
                                                    ((|basicSet|
                                                      ((|Union|
                                                        (|Record| (|:| |bas| $)
                                                                  (|:| |top|
                                                                       (|List|
                                                                        |t#4|)))
                                                        "failed")
                                                       (|List| |t#4|)
                                                       (|Mapping| (|Boolean|)
                                                                  |t#4|)
                                                       (|Mapping| (|Boolean|)
                                                                  |t#4|
                                                                  |t#4|)))
                                                     T)
                                                    ((|initials|
                                                      ((|List| |t#4|) $))
                                                     T)
                                                    ((|degree|
                                                      ((|NonNegativeInteger|)
                                                       $))
                                                     T)
                                                    ((|quasiComponent|
                                                      ((|Record|
                                                        (|:| |close|
                                                             (|List| |t#4|))
                                                        (|:| |open|
                                                             (|List| |t#4|)))
                                                       $))
                                                     T)
                                                    ((|normalized?|
                                                      ((|Boolean|) |t#4| $))
                                                     T)
                                                    ((|normalized?|
                                                      ((|Boolean|) $))
                                                     T)
                                                    ((|reduced?|
                                                      ((|Boolean|) |t#4| $
                                                       (|Mapping| (|Boolean|)
                                                                  |t#4|
                                                                  |t#4|)))
                                                     T)
                                                    ((|stronglyReduced?|
                                                      ((|Boolean|) |t#4| $))
                                                     T)
                                                    ((|headReduced?|
                                                      ((|Boolean|) |t#4| $))
                                                     T)
                                                    ((|initiallyReduced?|
                                                      ((|Boolean|) |t#4| $))
                                                     T)
                                                    ((|autoReduced?|
                                                      ((|Boolean|) $
                                                       (|Mapping| (|Boolean|)
                                                                  |t#4|
                                                                  (|List|
                                                                   |t#4|))))
                                                     T)
                                                    ((|stronglyReduced?|
                                                      ((|Boolean|) $))
                                                     T)
                                                    ((|headReduced?|
                                                      ((|Boolean|) $))
                                                     T)
                                                    ((|initiallyReduced?|
                                                      ((|Boolean|) $))
                                                     T)
                                                    ((|reduce|
                                                      (|t#4| |t#4| $
                                                       (|Mapping| |t#4| |t#4|
                                                                  |t#4|)
                                                       (|Mapping| (|Boolean|)
                                                                  |t#4|
                                                                  |t#4|)))
                                                     T)
                                                    ((|rewriteSetWithReduction|
                                                      ((|List| |t#4|)
                                                       (|List| |t#4|) $
                                                       (|Mapping| |t#4| |t#4|
                                                                  |t#4|)
                                                       (|Mapping| (|Boolean|)
                                                                  |t#4|
                                                                  |t#4|)))
                                                     T)
                                                    ((|stronglyReduce|
                                                      (|t#4| |t#4| $))
                                                     T)
                                                    ((|headReduce|
                                                      (|t#4| |t#4| $))
                                                     T)
                                                    ((|initiallyReduce|
                                                      (|t#4| |t#4| $))
                                                     T)
                                                    ((|removeZero|
                                                      (|t#4| |t#4| $))
                                                     T)
                                                    ((|collectQuasiMonic|
                                                      ($ $))
                                                     T)
                                                    ((|reduceByQuasiMonic|
                                                      (|t#4| |t#4| $))
                                                     T)
                                                    ((|zeroSetSplit|
                                                      ((|List| $)
                                                       (|List| |t#4|)))
                                                     T)
                                                    ((|zeroSetSplitIntoTriangularSystems|
                                                      ((|List|
                                                        (|Record|
                                                         (|:| |close| $)
                                                         (|:| |open|
                                                              (|List| |t#4|))))
                                                       (|List| |t#4|)))
                                                     T)
                                                    ((|first|
                                                      ((|Union| |t#4| "failed")
                                                       $))
                                                     T)
                                                    ((|last|
                                                      ((|Union| |t#4| "failed")
                                                       $))
                                                     T)
                                                    ((|rest|
                                                      ((|Union| $ "failed") $))
                                                     T)
                                                    ((|algebraicVariables|
                                                      ((|List| |t#3|) $))
                                                     T)
                                                    ((|algebraic?|
                                                      ((|Boolean|) |t#3| $))
                                                     T)
                                                    ((|select|
                                                      ((|Union| |t#4| "failed")
                                                       $ |t#3|))
                                                     T)
                                                    ((|extendIfCan|
                                                      ((|Union| $ "failed") $
                                                       |t#4|))
                                                     T)
                                                    ((|extend| ($ $ |t#4|)) T)
                                                    ((|coHeight|
                                                      ((|NonNegativeInteger|)
                                                       $))
                                                     (|has| |t#3| (|Finite|))))
                                                  NIL NIL NIL)))))))
           (SETELT #1# 0
                   (LIST '|TriangularSetCategory| |t#1| |t#2| |t#3| |t#4|))))) 
