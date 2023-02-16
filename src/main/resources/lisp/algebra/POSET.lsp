
(DEFPARAMETER |Poset;CAT| 'NIL) 

(DECLAIM (NOTINLINE |Poset;|)) 

(DEFPARAMETER |Poset;AL| 'NIL) 

(DEFUN |Poset| (|t#1|)
  (LET (#1=#:G722 (#2=#:G723 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |Poset;AL|)) (CDR #1#))
          (T
           (SETQ |Poset;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|Poset;| #2#))) |Poset;AL|))
           #1#)))) 

(DEFUN |Poset;| (|t#1|)
  (SPROG ((#1=#:G721 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|Poset;CAT|)
                                         ('T
                                          (LETT |Poset;CAT|
                                                (|Join| (|Preorder| '|t#1|)
                                                        (|mkCategory|
                                                         '(((|finitePoset|
                                                             ($ (|List| |t#1|)
                                                              (|List|
                                                               (|List|
                                                                (|Boolean|)))))
                                                            T)
                                                           ((|finitePoset|
                                                             ($ (|List| |t#1|)
                                                              (|Mapping|
                                                               (|Boolean|)
                                                               |t#1| |t#1|)))
                                                            T)
                                                           ((|getVert|
                                                             ((|List| |t#1|)
                                                              $))
                                                            T)
                                                           ((|getArr|
                                                             ((|List|
                                                               (|List|
                                                                (|Boolean|)))
                                                              $))
                                                            T)
                                                           ((|setVert|
                                                             ((|Void|) $
                                                              (|List| |t#1|)))
                                                            T)
                                                           ((|setArr|
                                                             ((|Void|) $
                                                              (|List|
                                                               (|List|
                                                                (|Boolean|)))))
                                                            T)
                                                           ((|addObject!|
                                                             ($ $ |t#1|))
                                                            T)
                                                           ((|addArrow!|
                                                             ($ $
                                                              (|NonNegativeInteger|)
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|opposite| ($ $))
                                                            T)
                                                           ((|powerSetStructure|
                                                             ($ |t#1|))
                                                            T)
                                                           ((|implies|
                                                             ((|Boolean|) $
                                                              (|NonNegativeInteger|)
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|meetIfCan|
                                                             ((|Union|
                                                               (|NonNegativeInteger|)
                                                               "failed")
                                                              $
                                                              (|NonNegativeInteger|)
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|joinIfCan|
                                                             ((|Union|
                                                               (|NonNegativeInteger|)
                                                               "failed")
                                                              $
                                                              (|NonNegativeInteger|)
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|meetIfCan|
                                                             ((|Union|
                                                               (|NonNegativeInteger|)
                                                               "failed")
                                                              $
                                                              (|List|
                                                               (|NonNegativeInteger|))))
                                                            T)
                                                           ((|joinIfCan|
                                                             ((|Union|
                                                               (|NonNegativeInteger|)
                                                               "failed")
                                                              $
                                                              (|List|
                                                               (|NonNegativeInteger|))))
                                                            T)
                                                           ((|glb|
                                                             ((|Union|
                                                               (|NonNegativeInteger|)
                                                               "failed")
                                                              $
                                                              (|List|
                                                               (|NonNegativeInteger|))))
                                                            T)
                                                           ((|lub|
                                                             ((|Union|
                                                               (|NonNegativeInteger|)
                                                               "failed")
                                                              $
                                                              (|List|
                                                               (|NonNegativeInteger|))))
                                                            T)
                                                           ((|upperSet| ($ $))
                                                            T)
                                                           ((|lowerSet| ($ $))
                                                            T)
                                                           ((|indexToObject|
                                                             (|t#1| $
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|objectToIndex|
                                                             ((|NonNegativeInteger|)
                                                              $ |t#1|))
                                                            T)
                                                           ((|completeReflexivity|
                                                             ($ $))
                                                            T)
                                                           ((|completeTransitivity|
                                                             ($ $))
                                                            T)
                                                           ((|isAntisymmetric?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|isChain?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|isAntiChain?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|moebius|
                                                             ((|IncidenceAlgebra|
                                                               (|Integer|)
                                                               |t#1|)
                                                              $))
                                                            T)
                                                           ((|zetaMatrix|
                                                             ((|IncidenceAlgebra|
                                                               (|Integer|)
                                                               |t#1|)
                                                              $))
                                                            T)
                                                           ((|coverMatrix|
                                                             ((|IncidenceAlgebra|
                                                               (|Integer|)
                                                               |t#1|)
                                                              $))
                                                            T))
                                                         NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|Poset| |t#1|))))) 
