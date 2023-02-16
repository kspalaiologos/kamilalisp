
(DEFPARAMETER |SequenceCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |SequenceCategory;|)) 

(DEFPARAMETER |SequenceCategory;AL| 'NIL) 

(DEFUN |SequenceCategory| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |SequenceCategory;AL|)) (CDR #1#))
          (T
           (SETQ |SequenceCategory;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|SequenceCategory;| #2#)))
                            |SequenceCategory;AL|))
           #1#)))) 

(DEFUN |SequenceCategory;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|SequenceCategory;CAT|)
                                         ('T
                                          (LETT |SequenceCategory;CAT|
                                                (|Join|
                                                 (|LazyStreamAggregate| '|t#1|)
                                                 (|Module| '|t#1|)
                                                 (|mkCategory|
                                                  '(((|elt|
                                                      (|t#1| $ (|Integer|)))
                                                     T)
                                                    ((|apply|
                                                      (|t#1| $ (|Partition|)))
                                                     T)
                                                    ((|cons| ($ |t#1| $)) T)
                                                    ((|coerce|
                                                      ($ (|Stream| |t#1|)))
                                                     T)
                                                    ((|sequence|
                                                      ($ (|Stream| |t#1|)))
                                                     T)
                                                    ((|stream|
                                                      ((|Stream| |t#1|) $))
                                                     T)
                                                    ((|first|
                                                      ($ $
                                                       (|NonNegativeInteger|)))
                                                     T)
                                                    ((|firstn|
                                                      ((|List| |t#1|) $
                                                       (|NonNegativeInteger|)))
                                                     T)
                                                    ((|dilate| ($ |t#1| $)) T)
                                                    ((|sequence|
                                                      ($
                                                       (|Mapping| |t#1| |t#1|)
                                                       |t#1|))
                                                     T))
                                                  NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|SequenceCategory| |t#1|))))) 
