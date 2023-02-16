
(DEFPARAMETER |ExtensionField;CAT| 'NIL) 

(DECLAIM (NOTINLINE |ExtensionField;|)) 

(DEFPARAMETER |ExtensionField;AL| 'NIL) 

(DEFUN |ExtensionField| (|t#1|)
  (LET (#1=#:G691 (#2=#:G692 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |ExtensionField;AL|)) (CDR #1#))
          (T
           (SETQ |ExtensionField;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|ExtensionField;| #2#)))
                            |ExtensionField;AL|))
           #1#)))) 

(DEFUN |ExtensionField;| (|t#1|)
  (SPROG ((#1=#:G690 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|ExtensionField;CAT|)
                                         ('T
                                          (LETT |ExtensionField;CAT|
                                                (|Join| (|Field|)
                                                        (|RetractableTo|
                                                         '|t#1|)
                                                        (|Module| '|t#1|)
                                                        (|mkCategory|
                                                         '(((|algebraic?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|transcendent?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|inGroundField?|
                                                             ((|Boolean|) $))
                                                            T)
                                                           ((|degree|
                                                             ((|OnePointCompletion|
                                                               (|PositiveInteger|))
                                                              $))
                                                            T)
                                                           ((|extensionDegree|
                                                             ((|OnePointCompletion|
                                                               (|PositiveInteger|))))
                                                            T)
                                                           ((|transcendenceDegree|
                                                             ((|NonNegativeInteger|)))
                                                            T)
                                                           ((/ ($ $ |t#1|)) T)
                                                           ((|Frobenius| ($ $))
                                                            (|has| |t#1|
                                                                   (|Finite|)))
                                                           ((|Frobenius|
                                                             ($ $
                                                              (|NonNegativeInteger|)))
                                                            (|has| |t#1|
                                                                   (|Finite|))))
                                                         '(((|CharacteristicZero|)
                                                            (|has| |t#1|
                                                                   (|CharacteristicZero|)))
                                                           ((|FieldOfPrimeCharacteristic|)
                                                            (|has| |t#1|
                                                                   (|CharacteristicNonZero|)))
                                                           ((|FieldOfPrimeCharacteristic|)
                                                            (|has| |t#1|
                                                                   (|Finite|))))
                                                         NIL NIL)))))))
           (SETELT #1# 0 (LIST '|ExtensionField| |t#1|))))) 
