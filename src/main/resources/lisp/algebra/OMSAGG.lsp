
(DEFPARAMETER |OrderedMultisetAggregate;CAT| 'NIL) 

(DECLAIM (NOTINLINE |OrderedMultisetAggregate;|)) 

(DEFPARAMETER |OrderedMultisetAggregate;AL| 'NIL) 

(DEFUN |OrderedMultisetAggregate| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |OrderedMultisetAggregate;AL|)) (CDR #1#))
          (T
           (SETQ |OrderedMultisetAggregate;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (|OrderedMultisetAggregate;| #2#)))
                    |OrderedMultisetAggregate;AL|))
           #1#)))) 

(DEFUN |OrderedMultisetAggregate;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|OrderedMultisetAggregate;CAT|)
                                         ('T
                                          (LETT |OrderedMultisetAggregate;CAT|
                                                (|Join|
                                                 (|MultisetAggregate| '|t#1|)
                                                 (|PriorityQueueAggregate|
                                                  '|t#1|)
                                                 (|mkCategory|
                                                  '(((|min| (|t#1| $)) T)) NIL
                                                  NIL NIL)))))))
           (SETELT #1# 0 (LIST '|OrderedMultisetAggregate| |t#1|))))) 
