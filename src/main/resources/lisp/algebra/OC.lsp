
(DEFPARAMETER |OctonionCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |OctonionCategory;|)) 

(DEFPARAMETER |OctonionCategory;AL| 'NIL) 

(DEFUN |OctonionCategory| (|t#1|)
  (LET (#1=#:G756 (#2=#:G757 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |OctonionCategory;AL|)) (CDR #1#))
          (T
           (SETQ |OctonionCategory;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|OctonionCategory;| #2#)))
                            |OctonionCategory;AL|))
           #1#)))) 

(DEFUN |OctonionCategory;| (|t#1|)
  (SPROG ((#1=#:G755 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|OctonionCategory;CAT|)
                                         ('T
                                          (LETT |OctonionCategory;CAT|
                                                (|Join|
                                                 (|FramedNonAssociativeAlgebra|
                                                  '|t#1|)
                                                 (|FullyRetractableTo| '|t#1|)
                                                 (|FullyEvalableOver| '|t#1|)
                                                 (|mkCategory|
                                                  '(((|conjugate| ($ $)) T)
                                                    ((|real| (|t#1| $)) T)
                                                    ((|imagi| (|t#1| $)) T)
                                                    ((|imagj| (|t#1| $)) T)
                                                    ((|imagk| (|t#1| $)) T)
                                                    ((|imagE| (|t#1| $)) T)
                                                    ((|imagI| (|t#1| $)) T)
                                                    ((|imagJ| (|t#1| $)) T)
                                                    ((|imagK| (|t#1| $)) T)
                                                    ((|norm| (|t#1| $)) T)
                                                    ((|octon|
                                                      ($ |t#1| |t#1| |t#1|
                                                       |t#1| |t#1| |t#1| |t#1|
                                                       |t#1|))
                                                     T)
                                                    ((|abs| (|t#1| $))
                                                     (|has| |t#1|
                                                            (|RealNumberSystem|)))
                                                    ((|rational?|
                                                      ((|Boolean|) $))
                                                     (|has| |t#1|
                                                            (|IntegerNumberSystem|)))
                                                    ((|rational|
                                                      ((|Fraction| (|Integer|))
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
                                                            (|IntegerNumberSystem|)))
                                                    ((|inv| ($ $))
                                                     (|has| |t#1| (|Field|))))
                                                  '(((|OrderedSet|)
                                                     (|has| |t#1|
                                                            (|OrderedSet|)))
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
           (SETELT #1# 0 (LIST '|OctonionCategory| |t#1|))))) 
