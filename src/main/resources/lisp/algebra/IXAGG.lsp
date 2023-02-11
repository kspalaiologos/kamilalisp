
(DEFPARAMETER |IndexedAggregate;CAT| 'NIL) 

(DECLAIM (NOTINLINE |IndexedAggregate;|)) 

(DEFPARAMETER |IndexedAggregate;AL| 'NIL) 

(DEFUN |IndexedAggregate| (|t#1| |t#2|)
  (LET (#1=#:G693 (#2=#:G694 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND ((SETQ #1# (|assoc| #2# |IndexedAggregate;AL|)) (CDR #1#))
          (T
           (SETQ |IndexedAggregate;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (APPLY #'|IndexedAggregate;| #2#)))
                    |IndexedAggregate;AL|))
           #1#)))) 

(DEFUN |IndexedAggregate;| (|t#1| |t#2|)
  (SPROG ((#1=#:G692 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (COND (|IndexedAggregate;CAT|)
                                         ('T
                                          (LETT |IndexedAggregate;CAT|
                                                (|Join|
                                                 (|HomogeneousAggregate|
                                                  '|t#2|)
                                                 (|EltableAggregate| '|t#1|
                                                                     '|t#2|)
                                                 (|mkCategory|
                                                  '(((|entries|
                                                      ((|List| |t#2|) $))
                                                     T)
                                                    ((|index?|
                                                      ((|Boolean|) |t#1| $))
                                                     T)
                                                    ((|indices|
                                                      ((|List| |t#1|) $))
                                                     T)
                                                    ((|entry?|
                                                      ((|Boolean|) |t#2| $))
                                                     (AND
                                                      (|has| $
                                                             (|finiteAggregate|))
                                                      (|has| |t#2|
                                                             (|BasicType|))))
                                                    ((|maxIndex| (|t#1| $))
                                                     (|has| |t#1|
                                                            (|OrderedSet|)))
                                                    ((|minIndex| (|t#1| $))
                                                     (|has| |t#1|
                                                            (|OrderedSet|)))
                                                    ((|first| (|t#2| $))
                                                     (|has| |t#1|
                                                            (|OrderedSet|)))
                                                    ((|fill!| ($ $ |t#2|))
                                                     (|has| $
                                                            (|shallowlyMutable|)))
                                                    ((|swap!|
                                                      ((|Void|) $ |t#1| |t#1|))
                                                     (|has| $
                                                            (|shallowlyMutable|))))
                                                  NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|IndexedAggregate| |t#1| |t#2|))))) 
