
(DEFPARAMETER |ExtensibleLinearAggregate;CAT| 'NIL) 

(DECLAIM (NOTINLINE |ExtensibleLinearAggregate;|)) 

(DEFPARAMETER |ExtensibleLinearAggregate;AL| 'NIL) 

(DEFUN |ExtensibleLinearAggregate| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |ExtensibleLinearAggregate;AL|)) (CDR #1#))
          (T
           (SETQ |ExtensibleLinearAggregate;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (|ExtensibleLinearAggregate;| #2#)))
                    |ExtensibleLinearAggregate;AL|))
           #1#)))) 

(DEFUN |ExtensibleLinearAggregate;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|ExtensibleLinearAggregate;CAT|)
                                         ('T
                                          (LETT |ExtensibleLinearAggregate;CAT|
                                                (|Join|
                                                 (|LinearAggregate| '|t#1|)
                                                 (|shallowlyMutable|)
                                                 (|mkCategory|
                                                  '(((|concat!| ($ $ |t#1|)) T)
                                                    ((|concat!| ($ $ $)) T)
                                                    ((|delete!|
                                                      ($ $ (|Integer|)))
                                                     T)
                                                    ((|delete!|
                                                      ($ $
                                                       (|UniversalSegment|
                                                        (|Integer|))))
                                                     T)
                                                    ((|remove!|
                                                      ($
                                                       (|Mapping| (|Boolean|)
                                                                  |t#1|)
                                                       $))
                                                     T)
                                                    ((|insert!|
                                                      ($ |t#1| $ (|Integer|)))
                                                     T)
                                                    ((|insert!|
                                                      ($ $ $ (|Integer|)))
                                                     T)
                                                    ((|merge!|
                                                      ($
                                                       (|Mapping| (|Boolean|)
                                                                  |t#1| |t#1|)
                                                       $ $))
                                                     T)
                                                    ((|select!|
                                                      ($
                                                       (|Mapping| (|Boolean|)
                                                                  |t#1|)
                                                       $))
                                                     T)
                                                    ((|remove!| ($ |t#1| $))
                                                     (|has| |t#1|
                                                            (|BasicType|)))
                                                    ((|removeDuplicates!|
                                                      ($ $))
                                                     (|has| |t#1|
                                                            (|BasicType|)))
                                                    ((|merge!| ($ $ $))
                                                     (|has| |t#1|
                                                            (|OrderedSet|))))
                                                  NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|ExtensibleLinearAggregate| |t#1|))))) 
