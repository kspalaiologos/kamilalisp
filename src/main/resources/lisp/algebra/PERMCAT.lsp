
(DEFPARAMETER |PermutationCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |PermutationCategory;|)) 

(DEFPARAMETER |PermutationCategory;AL| 'NIL) 

(DEFUN |PermutationCategory| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |PermutationCategory;AL|)) (CDR #1#))
          (T
           (SETQ |PermutationCategory;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|PermutationCategory;| #2#)))
                            |PermutationCategory;AL|))
           #1#)))) 

(DEFUN |PermutationCategory;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|PermutationCategory;CAT|)
                                         ('T
                                          (LETT |PermutationCategory;CAT|
                                                (|Join| (|Group|)
                                                        (|mkCategory|
                                                         '(((|cycle|
                                                             ($
                                                              (|List| |t#1|)))
                                                            T)
                                                           ((|cycles|
                                                             ($
                                                              (|List|
                                                               (|List|
                                                                |t#1|))))
                                                            T)
                                                           ((|eval|
                                                             (|t#1| $ |t#1|))
                                                            T)
                                                           ((|elt|
                                                             (|t#1| $ |t#1|))
                                                            T)
                                                           ((|orbit|
                                                             ((|Set| |t#1|) $
                                                              |t#1|))
                                                            T)
                                                           ((<
                                                             ((|Boolean|) $ $))
                                                            T))
                                                         '(((|OrderedSet|)
                                                            (|has| |t#1|
                                                                   (|OrderedSet|)))
                                                           ((|OrderedSet|)
                                                            (|has| |t#1|
                                                                   (|Finite|))))
                                                         NIL NIL)))))))
           (SETELT #1# 0 (LIST '|PermutationCategory| |t#1|))))) 
