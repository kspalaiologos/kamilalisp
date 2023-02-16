
(DEFPARAMETER |LinearAggregate;CAT| 'NIL) 

(DECLAIM (NOTINLINE |LinearAggregate;|)) 

(DEFPARAMETER |LinearAggregate;AL| 'NIL) 

(DEFUN |LinearAggregate| (|t#1|)
  (LET (#1=#:G696 (#2=#:G697 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |LinearAggregate;AL|)) (CDR #1#))
          (T
           (SETQ |LinearAggregate;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|LinearAggregate;| #2#)))
                            |LinearAggregate;AL|))
           #1#)))) 

(DEFUN |LinearAggregate;| (|t#1|)
  (SPROG ((#1=#:G695 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (|subst_in_cat| '(#2=#:G693 #3=#:G694)
                                                   (LIST '(|Integer|)
                                                         '(|UniversalSegment|
                                                           (|Integer|)))
                                                   (COND
                                                    (|LinearAggregate;CAT|)
                                                    ('T
                                                     (LETT
                                                      |LinearAggregate;CAT|
                                                      (|Join|
                                                       (|IndexedAggregate| '#2#
                                                                           '|t#1|)
                                                       (|Collection| '|t#1|)
                                                       (|Eltable| '#3# '$)
                                                       (|mkCategory|
                                                        '(((|new|
                                                            ($
                                                             (|NonNegativeInteger|)
                                                             |t#1|))
                                                           T)
                                                          ((|concat|
                                                            ($ $ |t#1|))
                                                           T)
                                                          ((|concat|
                                                            ($ |t#1| $))
                                                           T)
                                                          ((|concat| ($ $ $))
                                                           T)
                                                          ((|concat|
                                                            ($ (|List| $)))
                                                           T)
                                                          ((|map|
                                                            ($
                                                             (|Mapping| |t#1|
                                                                        |t#1|
                                                                        |t#1|)
                                                             $ $))
                                                           T)
                                                          ((|delete|
                                                            ($ $ (|Integer|)))
                                                           T)
                                                          ((|delete|
                                                            ($ $
                                                             (|UniversalSegment|
                                                              (|Integer|))))
                                                           T)
                                                          ((|first|
                                                            ($ $
                                                             (|NonNegativeInteger|)))
                                                           T)
                                                          ((|insert|
                                                            ($ |t#1| $
                                                             (|Integer|)))
                                                           T)
                                                          ((|insert|
                                                            ($ $ $
                                                             (|Integer|)))
                                                           T)
                                                          ((|setelt!|
                                                            (|t#1| $
                                                             (|UniversalSegment|
                                                              (|Integer|))
                                                             |t#1|))
                                                           (|has| $
                                                                  (|shallowlyMutable|)))
                                                          ((|merge|
                                                            ($
                                                             (|Mapping|
                                                              (|Boolean|) |t#1|
                                                              |t#1|)
                                                             $ $))
                                                           (|has| $
                                                                  (|finiteAggregate|)))
                                                          ((|reverse| ($ $))
                                                           (|has| $
                                                                  (|finiteAggregate|)))
                                                          ((|sort|
                                                            ($
                                                             (|Mapping|
                                                              (|Boolean|) |t#1|
                                                              |t#1|)
                                                             $))
                                                           (|has| $
                                                                  (|finiteAggregate|)))
                                                          ((|sorted?|
                                                            ((|Boolean|)
                                                             (|Mapping|
                                                              (|Boolean|) |t#1|
                                                              |t#1|)
                                                             $))
                                                           (|has| $
                                                                  (|finiteAggregate|)))
                                                          ((|position|
                                                            ((|Integer|)
                                                             (|Mapping|
                                                              (|Boolean|)
                                                              |t#1|)
                                                             $))
                                                           (|has| $
                                                                  (|finiteAggregate|)))
                                                          ((|position|
                                                            ((|Integer|) |t#1|
                                                             $))
                                                           (AND
                                                            (|has| |t#1|
                                                                   (|BasicType|))
                                                            (|has| $
                                                                   (|finiteAggregate|))))
                                                          ((|position|
                                                            ((|Integer|) |t#1|
                                                             $ (|Integer|)))
                                                           (AND
                                                            (|has| |t#1|
                                                                   (|BasicType|))
                                                            (|has| $
                                                                   (|finiteAggregate|))))
                                                          ((|leftTrim|
                                                            ($ $ |t#1|))
                                                           (AND
                                                            (|has| |t#1|
                                                                   (|BasicType|))
                                                            (|has| $
                                                                   (|finiteAggregate|))))
                                                          ((|rightTrim|
                                                            ($ $ |t#1|))
                                                           (AND
                                                            (|has| |t#1|
                                                                   (|BasicType|))
                                                            (|has| $
                                                                   (|finiteAggregate|))))
                                                          ((|trim| ($ $ |t#1|))
                                                           (AND
                                                            (|has| |t#1|
                                                                   (|BasicType|))
                                                            (|has| $
                                                                   (|finiteAggregate|))))
                                                          ((|merge| ($ $ $))
                                                           (AND
                                                            (|has| |t#1|
                                                                   (|OrderedSet|))
                                                            (|has| $
                                                                   (|finiteAggregate|))))
                                                          ((|sort| ($ $))
                                                           (AND
                                                            (|has| |t#1|
                                                                   (|OrderedSet|))
                                                            (|has| $
                                                                   (|finiteAggregate|))))
                                                          ((|sorted?|
                                                            ((|Boolean|) $))
                                                           (AND
                                                            (|has| |t#1|
                                                                   (|OrderedSet|))
                                                            (|has| $
                                                                   (|finiteAggregate|))))
                                                          ((|copyInto!|
                                                            ($ $ $
                                                             (|Integer|)))
                                                           (AND
                                                            (|has| $
                                                                   (|shallowlyMutable|))
                                                            (|has| $
                                                                   (|finiteAggregate|))))
                                                          ((|reverse!| ($ $))
                                                           (AND
                                                            (|has| $
                                                                   (|shallowlyMutable|))
                                                            (|has| $
                                                                   (|finiteAggregate|))))
                                                          ((|sort!|
                                                            ($
                                                             (|Mapping|
                                                              (|Boolean|) |t#1|
                                                              |t#1|)
                                                             $))
                                                           (AND
                                                            (|has| $
                                                                   (|shallowlyMutable|))
                                                            (|has| $
                                                                   (|finiteAggregate|))))
                                                          ((|sort!| ($ $))
                                                           (AND
                                                            (|has| |t#1|
                                                                   (|OrderedSet|))
                                                            (|has| $
                                                                   (|shallowlyMutable|))
                                                            (|has| $
                                                                   (|finiteAggregate|)))))
                                                        '(((|Comparable|)
                                                           (AND
                                                            (|has| |t#1|
                                                                   (|Comparable|))
                                                            (|has| $
                                                                   (|finiteAggregate|))))
                                                          ((|OrderedSet|)
                                                           (AND
                                                            (|has| |t#1|
                                                                   (|OrderedSet|))
                                                            (|has| $
                                                                   (|finiteAggregate|)))))
                                                        NIL NIL))))))))
           (SETELT #1# 0 (LIST '|LinearAggregate| |t#1|))))) 
