
(DEFPARAMETER |DequeueAggregate;CAT| 'NIL) 

(DECLAIM (NOTINLINE |DequeueAggregate;|)) 

(DEFPARAMETER |DequeueAggregate;AL| 'NIL) 

(DEFUN |DequeueAggregate| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |DequeueAggregate;AL|)) (CDR #1#))
          (T
           (SETQ |DequeueAggregate;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|DequeueAggregate;| #2#)))
                            |DequeueAggregate;AL|))
           #1#)))) 

(DEFUN |DequeueAggregate;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|DequeueAggregate;CAT|)
                                         ('T
                                          (LETT |DequeueAggregate;CAT|
                                                (|Join|
                                                 (|StackAggregate| '|t#1|)
                                                 (|QueueAggregate| '|t#1|)
                                                 (|mkCategory|
                                                  '(((|bottom| (|t#1| $)) T)
                                                    ((|insertTop!|
                                                      (|t#1| |t#1| $))
                                                     T)
                                                    ((|insertBottom!|
                                                      (|t#1| |t#1| $))
                                                     T)
                                                    ((|extractTop!| (|t#1| $))
                                                     T)
                                                    ((|extractBottom!|
                                                      (|t#1| $))
                                                     T)
                                                    ((|reverse!| ($ $)) T))
                                                  NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|DequeueAggregate| |t#1|))))) 
