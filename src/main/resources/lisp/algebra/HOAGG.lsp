
(DEFPARAMETER |HomogeneousAggregate;CAT| 'NIL) 

(DECLAIM (NOTINLINE |HomogeneousAggregate;|)) 

(DEFPARAMETER |HomogeneousAggregate;AL| 'NIL) 

(DEFUN |HomogeneousAggregate| (|t#1|)
  (LET (#1=#:G694 (#2=#:G695 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |HomogeneousAggregate;AL|)) (CDR #1#))
          (T
           (SETQ |HomogeneousAggregate;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|HomogeneousAggregate;| #2#)))
                            |HomogeneousAggregate;AL|))
           #1#)))) 

(DEFUN |HomogeneousAggregate;| (|t#1|)
  (SPROG ((#1=#:G693 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|HomogeneousAggregate;CAT|)
                                         ('T
                                          (LETT |HomogeneousAggregate;CAT|
                                                (|Join| (|Aggregate|)
                                                        (|mkCategory|
                                                         '(((|map|
                                                             ($
                                                              (|Mapping| |t#1|
                                                                         |t#1|)
                                                              $))
                                                            T)
                                                           ((|map!|
                                                             ($
                                                              (|Mapping| |t#1|
                                                                         |t#1|)
                                                              $))
                                                            (|has| $
                                                                   (|shallowlyMutable|)))
                                                           ((|any?|
                                                             ((|Boolean|)
                                                              (|Mapping|
                                                               (|Boolean|)
                                                               |t#1|)
                                                              $))
                                                            (|has| $
                                                                   (|finiteAggregate|)))
                                                           ((|every?|
                                                             ((|Boolean|)
                                                              (|Mapping|
                                                               (|Boolean|)
                                                               |t#1|)
                                                              $))
                                                            (|has| $
                                                                   (|finiteAggregate|)))
                                                           ((|count|
                                                             ((|NonNegativeInteger|)
                                                              (|Mapping|
                                                               (|Boolean|)
                                                               |t#1|)
                                                              $))
                                                            (|has| $
                                                                   (|finiteAggregate|)))
                                                           ((|parts|
                                                             ((|List| |t#1|)
                                                              $))
                                                            (|has| $
                                                                   (|finiteAggregate|)))
                                                           ((|members|
                                                             ((|List| |t#1|)
                                                              $))
                                                            (|has| $
                                                                   (|finiteAggregate|)))
                                                           ((|max|
                                                             (|t#1|
                                                              (|Mapping|
                                                               (|Boolean|)
                                                               |t#1| |t#1|)
                                                              $))
                                                            (|has| $
                                                                   (|finiteAggregate|)))
                                                           ((|min| (|t#1| $))
                                                            (AND
                                                             (|has| |t#1|
                                                                    (|OrderedSet|))
                                                             (|has| $
                                                                    (|finiteAggregate|))))
                                                           ((|max| (|t#1| $))
                                                            (AND
                                                             (|has| |t#1|
                                                                    (|OrderedSet|))
                                                             (|has| $
                                                                    (|finiteAggregate|))))
                                                           ((|count|
                                                             ((|NonNegativeInteger|)
                                                              |t#1| $))
                                                            (AND
                                                             (|has| |t#1|
                                                                    (|BasicType|))
                                                             (|has| $
                                                                    (|finiteAggregate|))))
                                                           ((|member?|
                                                             ((|Boolean|) |t#1|
                                                              $))
                                                            (AND
                                                             (|has| |t#1|
                                                                    (|BasicType|))
                                                             (|has| $
                                                                    (|finiteAggregate|)))))
                                                         '(((|CoercibleTo|
                                                             (|OutputForm|))
                                                            (|has| |t#1|
                                                                   (|CoercibleTo|
                                                                    (|OutputForm|))))
                                                           ((|SetCategory|)
                                                            (|has| |t#1|
                                                                   (|SetCategory|)))
                                                           ((|Evalable| |t#1|)
                                                            (AND
                                                             (|has| |t#1|
                                                                    (|Evalable|
                                                                     |t#1|))
                                                             (|has| |t#1|
                                                                    (|SetCategory|))))
                                                           ((|BasicType|)
                                                            (AND
                                                             (|has| |t#1|
                                                                    (|BasicType|))
                                                             (|has| $
                                                                    (|finiteAggregate|)))))
                                                         NIL NIL)))))))
           (SETELT #1# 0 (LIST '|HomogeneousAggregate| |t#1|))))) 
