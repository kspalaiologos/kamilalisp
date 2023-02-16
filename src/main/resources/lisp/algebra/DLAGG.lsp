
(DEFPARAMETER |DoublyLinkedAggregate;CAT| 'NIL) 

(DECLAIM (NOTINLINE |DoublyLinkedAggregate;|)) 

(DEFPARAMETER |DoublyLinkedAggregate;AL| 'NIL) 

(DEFUN |DoublyLinkedAggregate| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |DoublyLinkedAggregate;AL|)) (CDR #1#))
          (T
           (SETQ |DoublyLinkedAggregate;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (|DoublyLinkedAggregate;| #2#)))
                    |DoublyLinkedAggregate;AL|))
           #1#)))) 

(DEFUN |DoublyLinkedAggregate;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|DoublyLinkedAggregate;CAT|)
                                         ('T
                                          (LETT |DoublyLinkedAggregate;CAT|
                                                (|Join|
                                                 (|RecursiveAggregate| '|t#1|)
                                                 (|mkCategory|
                                                  '(((|last| (|t#1| $)) T)
                                                    ((|head| ($ $)) T)
                                                    ((|tail| ($ $)) T)
                                                    ((|previous| ($ $)) T)
                                                    ((|next| ($ $)) T)
                                                    ((|concat!| ($ $ $))
                                                     (|has| $
                                                            (|shallowlyMutable|)))
                                                    ((|setprevious!| ($ $ $))
                                                     (|has| $
                                                            (|shallowlyMutable|)))
                                                    ((|setnext!| ($ $ $))
                                                     (|has| $
                                                            (|shallowlyMutable|))))
                                                  NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|DoublyLinkedAggregate| |t#1|))))) 
