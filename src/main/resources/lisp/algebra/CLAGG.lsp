
(DEFPARAMETER |Collection;CAT| 'NIL) 

(DECLAIM (NOTINLINE |Collection;|)) 

(DEFPARAMETER |Collection;AL| 'NIL) 

(DEFUN |Collection| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |Collection;AL|)) (CDR #1#))
          (T
           (SETQ |Collection;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|Collection;| #2#)))
                            |Collection;AL|))
           #1#)))) 

(DEFUN |Collection;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|Collection;CAT|)
                                         ('T
                                          (LETT |Collection;CAT|
                                                (|Join|
                                                 (|HomogeneousAggregate|
                                                  '|t#1|)
                                                 (|mkCategory|
                                                  '(((|construct|
                                                      ($ (|List| |t#1|)))
                                                     T)
                                                    ((|find|
                                                      ((|Union| |t#1| "failed")
                                                       (|Mapping| (|Boolean|)
                                                                  |t#1|)
                                                       $))
                                                     T)
                                                    ((|reduce|
                                                      (|t#1|
                                                       (|Mapping| |t#1| |t#1|
                                                                  |t#1|)
                                                       $))
                                                     (|has| $
                                                            (|finiteAggregate|)))
                                                    ((|reduce|
                                                      (|t#1|
                                                       (|Mapping| |t#1| |t#1|
                                                                  |t#1|)
                                                       $ |t#1|))
                                                     (|has| $
                                                            (|finiteAggregate|)))
                                                    ((|remove|
                                                      ($
                                                       (|Mapping| (|Boolean|)
                                                                  |t#1|)
                                                       $))
                                                     (|has| $
                                                            (|finiteAggregate|)))
                                                    ((|select|
                                                      ($
                                                       (|Mapping| (|Boolean|)
                                                                  |t#1|)
                                                       $))
                                                     (|has| $
                                                            (|finiteAggregate|)))
                                                    ((|reduce|
                                                      (|t#1|
                                                       (|Mapping| |t#1| |t#1|
                                                                  |t#1|)
                                                       $ |t#1| |t#1|))
                                                     (AND
                                                      (|has| |t#1|
                                                             (|BasicType|))
                                                      (|has| $
                                                             (|finiteAggregate|))))
                                                    ((|remove| ($ |t#1| $))
                                                     (AND
                                                      (|has| |t#1|
                                                             (|BasicType|))
                                                      (|has| $
                                                             (|finiteAggregate|))))
                                                    ((|removeDuplicates| ($ $))
                                                     (AND
                                                      (|has| |t#1|
                                                             (|BasicType|))
                                                      (|has| $
                                                             (|finiteAggregate|)))))
                                                  '(((|ConvertibleTo|
                                                      (|InputForm|))
                                                     (|has| |t#1|
                                                            (|ConvertibleTo|
                                                             (|InputForm|)))))
                                                  NIL NIL)))))))
           (SETELT #1# 0 (LIST '|Collection| |t#1|))))) 
