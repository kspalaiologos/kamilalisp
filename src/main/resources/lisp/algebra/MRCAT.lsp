
(DEFPARAMETER |MonoidRingCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |MonoidRingCategory;|)) 

(DEFPARAMETER |MonoidRingCategory;AL| 'NIL) 

(DEFUN |MonoidRingCategory| (|t#1| |t#2|)
  (LET (#1=#:G690 (#2=#:G691 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND ((SETQ #1# (|assoc| #2# |MonoidRingCategory;AL|)) (CDR #1#))
          (T
           (SETQ |MonoidRingCategory;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (APPLY #'|MonoidRingCategory;| #2#)))
                    |MonoidRingCategory;AL|))
           #1#)))) 

(DEFUN |MonoidRingCategory;| (|t#1| |t#2|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (COND (|MonoidRingCategory;CAT|)
                                         ('T
                                          (LETT |MonoidRingCategory;CAT|
                                                (|Join| (|Ring|)
                                                        (|FreeModuleCategory|
                                                         '|t#1| '|t#2|)
                                                        (|RetractableTo|
                                                         '|t#2|)
                                                        (|RetractableTo|
                                                         '|t#1|)
                                                        (|mkCategory|
                                                         '(((|coerce|
                                                             ($
                                                              (|List|
                                                               (|Record|
                                                                (|:| |k| |t#2|)
                                                                (|:| |c|
                                                                     |t#1|)))))
                                                            T)
                                                           ((|terms|
                                                             ((|List|
                                                               (|Record|
                                                                (|:| |k| |t#2|)
                                                                (|:| |c|
                                                                     |t#1|)))
                                                              $))
                                                            T))
                                                         '(((|CharacteristicZero|)
                                                            (|has| |t#1|
                                                                   (|CharacteristicZero|)))
                                                           ((|CharacteristicNonZero|)
                                                            (|has| |t#1|
                                                                   (|CharacteristicNonZero|)))
                                                           ((|Algebra| |t#1|)
                                                            (|has| |t#1|
                                                                   (|CommutativeRing|)))
                                                           ((|CommutativeRing|)
                                                            (AND
                                                             (|has| |t#2|
                                                                    (|CommutativeStar|))
                                                             (|has| |t#1|
                                                                    (|CommutativeRing|))))
                                                           ((|Finite|)
                                                            (AND
                                                             (|has| |t#2|
                                                                    (|Finite|))
                                                             (|has| |t#1|
                                                                    (|Finite|)))))
                                                         NIL NIL)))))))
           (SETELT #1# 0 (LIST '|MonoidRingCategory| |t#1| |t#2|))))) 
