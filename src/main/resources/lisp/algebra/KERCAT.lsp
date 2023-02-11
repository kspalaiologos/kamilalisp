
(DEFPARAMETER |KernelCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |KernelCategory;|)) 

(DEFPARAMETER |KernelCategory;AL| 'NIL) 

(DEFUN |KernelCategory| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |KernelCategory;AL|)) (CDR #1#))
          (T
           (SETQ |KernelCategory;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|KernelCategory;| #2#)))
                            |KernelCategory;AL|))
           #1#)))) 

(DEFUN |KernelCategory;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|KernelCategory;CAT|)
                                         ('T
                                          (LETT |KernelCategory;CAT|
                                                (|Join| (|OrderedSet|)
                                                        (|Patternable| '|t#1|)
                                                        (|mkCategory|
                                                         '(((|name|
                                                             ((|Symbol|) $))
                                                            T)
                                                           ((|operator|
                                                             ((|BasicOperator|)
                                                              $))
                                                            T)
                                                           ((|argument|
                                                             ((|List| |t#1|)
                                                              $))
                                                            T)
                                                           ((|height|
                                                             ((|NonNegativeInteger|)
                                                              $))
                                                            T)
                                                           ((|kernel|
                                                             ($
                                                              (|BasicOperator|)
                                                              (|List| |t#1|)
                                                              (|NonNegativeInteger|)))
                                                            T)
                                                           ((|kernel|
                                                             ($ (|Symbol|)))
                                                            T)
                                                           ((|symbolIfCan|
                                                             ((|Union|
                                                               (|Symbol|)
                                                               "failed")
                                                              $))
                                                            T)
                                                           ((|is?|
                                                             ((|Boolean|) $
                                                              (|BasicOperator|)))
                                                            T)
                                                           ((|is?|
                                                             ((|Boolean|) $
                                                              (|Symbol|)))
                                                            T))
                                                         '(((|ConvertibleTo|
                                                             (|InputForm|))
                                                            (|has| |t#1|
                                                                   (|ConvertibleTo|
                                                                    (|InputForm|)))))
                                                         NIL NIL)))))))
           (SETELT #1# 0 (LIST '|KernelCategory| |t#1|))))) 
