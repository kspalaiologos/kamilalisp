
(DEFPARAMETER |ThreeSpaceCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |ThreeSpaceCategory;|)) 

(DEFPARAMETER |ThreeSpaceCategory;AL| 'NIL) 

(DEFUN |ThreeSpaceCategory| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |ThreeSpaceCategory;AL|)) (CDR #1#))
          (T
           (SETQ |ThreeSpaceCategory;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|ThreeSpaceCategory;| #2#)))
                            |ThreeSpaceCategory;AL|))
           #1#)))) 

(DEFUN |ThreeSpaceCategory;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|ThreeSpaceCategory;CAT|)
                                         ('T
                                          (LETT |ThreeSpaceCategory;CAT|
                                                (|Join| (|SetCategory|)
                                                        (|mkCategory|
                                                         '(((|create3Space|
                                                             ($))
                                                            T)
                                                           ((|create3Space|
                                                             ($
                                                              (|SubSpace| 3
                                                                          |t#1|)))
                                                            T)
                                                           ((|numberOfComponents|
                                                             ((|NonNegativeInteger|)
                                                              $))
                                                            T)
                                                           ((|numberOfComposites|
                                                             ((|NonNegativeInteger|)
                                                              $))
                                                            T)
                                                           ((|merge|
                                                             ($ (|List| $)))
                                                            T)
                                                           ((|merge| ($ $ $))
                                                            T)
                                                           ((|composite|
                                                             ($ (|List| $)))
                                                            T)
                                                           ((|components|
                                                             ((|List| $) $))
                                                            T)
                                                           ((|composites|
                                                             ((|List| $) $))
                                                            T)
                                                           ((|copy| ($ $)) T)
                                                           ((|enterPointData|
                                                             ((|NonNegativeInteger|)
                                                              $
                                                              (|List|
                                                               (|Point|
                                                                |t#1|))))
                                                            T)
                                                           ((|modifyPointData|
                                                             ($ $
                                                              (|NonNegativeInteger|)
                                                              (|Point| |t#1|)))
                                                            T)
                                                           ((|point|
                                                             ($ $
                                                              (|Point| |t#1|)))
                                                            T)
                                                           ((|point|
                                                             ($ $
                                                              (|List| |t#1|)))
                                                            T)
                                                           ((|point|
                                                             ($ $
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|point|
                                                             ($
                                                              (|Point| |t#1|)))
                                                            T)
                                                           ((|point|
                                                             ((|Point| |t#1|)
                                                              $))
                                                            T)
                                                           ((|point?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|curve|
                                                             ($ $
                                                              (|List|
                                                               (|Point|
                                                                |t#1|))))
                                                            T)
                                                           ((|curve|
                                                             ($ $
                                                              (|List|
                                                               (|List|
                                                                |t#1|))))
                                                            T)
                                                           ((|curve|
                                                             ($
                                                              (|List|
                                                               (|Point|
                                                                |t#1|))))
                                                            T)
                                                           ((|curve|
                                                             ((|List|
                                                               (|Point| |t#1|))
                                                              $))
                                                            T)
                                                           ((|curve?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|closedCurve|
                                                             ($ $
                                                              (|List|
                                                               (|Point|
                                                                |t#1|))))
                                                            T)
                                                           ((|closedCurve|
                                                             ($ $
                                                              (|List|
                                                               (|List|
                                                                |t#1|))))
                                                            T)
                                                           ((|closedCurve|
                                                             ($
                                                              (|List|
                                                               (|Point|
                                                                |t#1|))))
                                                            T)
                                                           ((|closedCurve|
                                                             ((|List|
                                                               (|Point| |t#1|))
                                                              $))
                                                            T)
                                                           ((|closedCurve?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|polygon|
                                                             ($ $
                                                              (|List|
                                                               (|Point|
                                                                |t#1|))))
                                                            T)
                                                           ((|polygon|
                                                             ($ $
                                                              (|List|
                                                               (|List|
                                                                |t#1|))))
                                                            T)
                                                           ((|polygon|
                                                             ($
                                                              (|List|
                                                               (|Point|
                                                                |t#1|))))
                                                            T)
                                                           ((|polygon|
                                                             ((|List|
                                                               (|Point| |t#1|))
                                                              $))
                                                            T)
                                                           ((|polygon?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|mesh|
                                                             ($ $
                                                              (|List|
                                                               (|List|
                                                                (|Point|
                                                                 |t#1|)))
                                                              (|List|
                                                               (|SubSpaceComponentProperty|))
                                                              (|SubSpaceComponentProperty|)))
                                                            T)
                                                           ((|mesh|
                                                             ($ $
                                                              (|List|
                                                               (|List|
                                                                (|List|
                                                                 |t#1|)))
                                                              (|List|
                                                               (|SubSpaceComponentProperty|))
                                                              (|SubSpaceComponentProperty|)))
                                                            T)
                                                           ((|mesh|
                                                             ($ $
                                                              (|List|
                                                               (|List|
                                                                (|Point|
                                                                 |t#1|)))
                                                              (|Boolean|)
                                                              (|Boolean|)))
                                                            T)
                                                           ((|mesh|
                                                             ($ $
                                                              (|List|
                                                               (|List|
                                                                (|List|
                                                                 |t#1|)))
                                                              (|Boolean|)
                                                              (|Boolean|)))
                                                            T)
                                                           ((|mesh|
                                                             ($
                                                              (|List|
                                                               (|List|
                                                                (|Point|
                                                                 |t#1|)))))
                                                            T)
                                                           ((|mesh|
                                                             ($
                                                              (|List|
                                                               (|List|
                                                                (|Point|
                                                                 |t#1|)))
                                                              (|Boolean|)
                                                              (|Boolean|)))
                                                            T)
                                                           ((|mesh|
                                                             ((|List|
                                                               (|List|
                                                                (|Point|
                                                                 |t#1|)))
                                                              $))
                                                            T)
                                                           ((|mesh?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|lp|
                                                             ((|List|
                                                               (|Point| |t#1|))
                                                              $))
                                                            T)
                                                           ((|lllip|
                                                             ((|List|
                                                               (|List|
                                                                (|List|
                                                                 (|NonNegativeInteger|))))
                                                              $))
                                                            T)
                                                           ((|lllp|
                                                             ((|List|
                                                               (|List|
                                                                (|List|
                                                                 (|Point|
                                                                  |t#1|))))
                                                              $))
                                                            T)
                                                           ((|llprop|
                                                             ((|List|
                                                               (|List|
                                                                (|SubSpaceComponentProperty|)))
                                                              $))
                                                            T)
                                                           ((|lprop|
                                                             ((|List|
                                                               (|SubSpaceComponentProperty|))
                                                              $))
                                                            T)
                                                           ((|objects|
                                                             ((|Record|
                                                               (|:| |points|
                                                                    (|NonNegativeInteger|))
                                                               (|:| |curves|
                                                                    (|NonNegativeInteger|))
                                                               (|:| |polygons|
                                                                    (|NonNegativeInteger|))
                                                               (|:|
                                                                |constructs|
                                                                (|NonNegativeInteger|)))
                                                              $))
                                                            T)
                                                           ((|check| ($ $)) T)
                                                           ((|subspace|
                                                             ((|SubSpace| 3
                                                                          |t#1|)
                                                              $))
                                                            T)
                                                           ((|coerce|
                                                             ((|OutputForm|)
                                                              $))
                                                            T))
                                                         NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|ThreeSpaceCategory| |t#1|))))) 
