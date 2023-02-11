
(DEFPARAMETER |QuaternionCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |QuaternionCategory;|)) 

(DEFPARAMETER |QuaternionCategory;AL| 'NIL) 

(DEFUN |QuaternionCategory| (|t#1|)
  (LET (#1=#:G723 (#2=#:G724 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |QuaternionCategory;AL|)) (CDR #1#))
          (T
           (SETQ |QuaternionCategory;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|QuaternionCategory;| #2#)))
                            |QuaternionCategory;AL|))
           #1#)))) 

(DEFUN |QuaternionCategory;| (|t#1|)
  (SPROG ((#1=#:G722 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|QuaternionCategory;CAT|)
                                         ('T
                                          (LETT |QuaternionCategory;CAT|
                                                (|Join| (|Algebra| '|t#1|)
                                                        (|FullyRetractableTo|
                                                         '|t#1|)
                                                        (|DifferentialExtension|
                                                         '|t#1|)
                                                        (|FullyEvalableOver|
                                                         '|t#1|)
                                                        (|FullyLinearlyExplicitOver|
                                                         '|t#1|)
                                                        (|mkCategory|
                                                         '(((|conjugate| ($ $))
                                                            T)
                                                           ((|imagI| (|t#1| $))
                                                            T)
                                                           ((|imagJ| (|t#1| $))
                                                            T)
                                                           ((|imagK| (|t#1| $))
                                                            T)
                                                           ((|norm| (|t#1| $))
                                                            T)
                                                           ((|quatern|
                                                             ($ |t#1| |t#1|
                                                              |t#1| |t#1|))
                                                            T)
                                                           ((|real| (|t#1| $))
                                                            T)
                                                           ((|abs| (|t#1| $))
                                                            (|has| |t#1|
                                                                   (|RealNumberSystem|)))
                                                           ((|rational?|
                                                             ((|Boolean|) $))
                                                            (|has| |t#1|
                                                                   (|IntegerNumberSystem|)))
                                                           ((|rational|
                                                             ((|Fraction|
                                                               (|Integer|))
                                                              $))
                                                            (|has| |t#1|
                                                                   (|IntegerNumberSystem|)))
                                                           ((|rationalIfCan|
                                                             ((|Union|
                                                               (|Fraction|
                                                                (|Integer|))
                                                               "failed")
                                                              $))
                                                            (|has| |t#1|
                                                                   (|IntegerNumberSystem|))))
                                                         '(((|EntireRing|)
                                                            (|has| |t#1|
                                                                   (|EntireRing|)))
                                                           ((|OrderedSet|)
                                                            (|has| |t#1|
                                                                   (|OrderedSet|)))
                                                           ((|DivisionRing|)
                                                            (|has| |t#1|
                                                                   (|Field|)))
                                                           ((|ConvertibleTo|
                                                             (|InputForm|))
                                                            (|has| |t#1|
                                                                   (|ConvertibleTo|
                                                                    (|InputForm|))))
                                                           ((|CharacteristicZero|)
                                                            (|has| |t#1|
                                                                   (|CharacteristicZero|)))
                                                           ((|CharacteristicNonZero|)
                                                            (|has| |t#1|
                                                                   (|CharacteristicNonZero|))))
                                                         NIL NIL)))))))
           (SETELT #1# 0 (LIST '|QuaternionCategory| |t#1|))))) 
