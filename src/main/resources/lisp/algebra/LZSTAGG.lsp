
(DEFPARAMETER |LazyStreamAggregate;CAT| 'NIL) 

(DECLAIM (NOTINLINE |LazyStreamAggregate;|)) 

(DEFPARAMETER |LazyStreamAggregate;AL| 'NIL) 

(DEFUN |LazyStreamAggregate| (|t#1|)
  (LET (#1=#:G783 (#2=#:G784 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |LazyStreamAggregate;AL|)) (CDR #1#))
          (T
           (SETQ |LazyStreamAggregate;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|LazyStreamAggregate;| #2#)))
                            |LazyStreamAggregate;AL|))
           #1#)))) 

(DEFUN |LazyStreamAggregate;| (|t#1|)
  (SPROG ((#1=#:G782 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|LazyStreamAggregate;CAT|)
                                         ('T
                                          (LETT |LazyStreamAggregate;CAT|
                                                (|Join|
                                                 (|StreamAggregate| '|t#1|)
                                                 (|mkCategory|
                                                  '(((|remove|
                                                      ($
                                                       (|Mapping| (|Boolean|)
                                                                  |t#1|)
                                                       $))
                                                     T)
                                                    ((|select|
                                                      ($
                                                       (|Mapping| (|Boolean|)
                                                                  |t#1|)
                                                       $))
                                                     T)
                                                    ((|explicitEntries?|
                                                      ((|Boolean|) $))
                                                     T)
                                                    ((|explicitlyEmpty?|
                                                      ((|Boolean|) $))
                                                     T)
                                                    ((|lazy?| ((|Boolean|) $))
                                                     T)
                                                    ((|lazyEvaluate| ($ $)) T)
                                                    ((|frst| (|t#1| $)) T)
                                                    ((|rst| ($ $)) T)
                                                    ((|numberOfComputedEntries|
                                                      ((|NonNegativeInteger|)
                                                       $))
                                                     T)
                                                    ((|extend|
                                                      ($ $ (|Integer|)))
                                                     T)
                                                    ((|complete| ($ $)) T))
                                                  NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|LazyStreamAggregate| |t#1|))))) 
