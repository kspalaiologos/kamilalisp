
(DEFPARAMETER |UnaryRecursiveAggregate;CAT| 'NIL) 

(DECLAIM (NOTINLINE |UnaryRecursiveAggregate;|)) 

(DEFPARAMETER |UnaryRecursiveAggregate;AL| 'NIL) 

(DEFUN |UnaryRecursiveAggregate| (|t#1|)
  (LET (#1=#:G745 (#2=#:G746 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |UnaryRecursiveAggregate;AL|)) (CDR #1#))
          (T
           (SETQ |UnaryRecursiveAggregate;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (|UnaryRecursiveAggregate;| #2#)))
                    |UnaryRecursiveAggregate;AL|))
           #1#)))) 

(DEFUN |UnaryRecursiveAggregate;| (|t#1|)
  (SPROG ((#1=#:G744 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|UnaryRecursiveAggregate;CAT|)
                                         ('T
                                          (LETT |UnaryRecursiveAggregate;CAT|
                                                (|Join|
                                                 (|RecursiveAggregate| '|t#1|)
                                                 (|mkCategory|
                                                  '(((|concat| ($ $ $)) T)
                                                    ((|concat| ($ |t#1| $)) T)
                                                    ((|first| (|t#1| $)) T)
                                                    ((|elt| (|t#1| $ "first"))
                                                     T)
                                                    ((|first|
                                                      ($ $
                                                       (|NonNegativeInteger|)))
                                                     T)
                                                    ((|rest| ($ $)) T)
                                                    ((|elt| ($ $ "rest")) T)
                                                    ((|rest|
                                                      ($ $
                                                       (|NonNegativeInteger|)))
                                                     T)
                                                    ((|last| (|t#1| $)) T)
                                                    ((|elt| (|t#1| $ "last"))
                                                     T)
                                                    ((|last|
                                                      ($ $
                                                       (|NonNegativeInteger|)))
                                                     T)
                                                    ((|tail| ($ $)) T)
                                                    ((|second| (|t#1| $)) T)
                                                    ((|third| (|t#1| $)) T)
                                                    ((|cycleEntry| ($ $)) T)
                                                    ((|cycleLength|
                                                      ((|NonNegativeInteger|)
                                                       $))
                                                     T)
                                                    ((|cycleTail| ($ $)) T)
                                                    ((|concat!| ($ $ $))
                                                     (|has| $
                                                            (|shallowlyMutable|)))
                                                    ((|concat!| ($ $ |t#1|))
                                                     (|has| $
                                                            (|shallowlyMutable|)))
                                                    ((|concat!| ($ (|List| $)))
                                                     (|has| $
                                                            (|shallowlyMutable|)))
                                                    ((|cycleSplit!| ($ $))
                                                     (|has| $
                                                            (|shallowlyMutable|)))
                                                    ((|setfirst!|
                                                      (|t#1| $ |t#1|))
                                                     (|has| $
                                                            (|shallowlyMutable|)))
                                                    ((|qsetfirst!|
                                                      (|t#1| $ |t#1|))
                                                     (|has| $
                                                            (|shallowlyMutable|)))
                                                    ((|setelt!|
                                                      (|t#1| $ "first" |t#1|))
                                                     (|has| $
                                                            (|shallowlyMutable|)))
                                                    ((|setrest!| ($ $ $))
                                                     (|has| $
                                                            (|shallowlyMutable|)))
                                                    ((|qsetrest!| ($ $ $))
                                                     (|has| $
                                                            (|shallowlyMutable|)))
                                                    ((|setelt!| ($ $ "rest" $))
                                                     (|has| $
                                                            (|shallowlyMutable|)))
                                                    ((|setlast!|
                                                      (|t#1| $ |t#1|))
                                                     (|has| $
                                                            (|shallowlyMutable|)))
                                                    ((|setelt!|
                                                      (|t#1| $ "last" |t#1|))
                                                     (|has| $
                                                            (|shallowlyMutable|)))
                                                    ((|split!|
                                                      ($ $
                                                       (|NonNegativeInteger|)))
                                                     (|has| $
                                                            (|shallowlyMutable|))))
                                                  NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|UnaryRecursiveAggregate| |t#1|))))) 
