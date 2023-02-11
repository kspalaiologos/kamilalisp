
(DEFPARAMETER |AssociationListAggregate;CAT| 'NIL) 

(DECLAIM (NOTINLINE |AssociationListAggregate;|)) 

(DEFPARAMETER |AssociationListAggregate;AL| 'NIL) 

(DEFUN |AssociationListAggregate| (|t#1| |t#2|)
  (LET (#1=#:G693 (#2=#:G694 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND ((SETQ #1# (|assoc| #2# |AssociationListAggregate;AL|)) (CDR #1#))
          (T
           (SETQ |AssociationListAggregate;AL|
                   (|cons5|
                    (CONS #2#
                          (SETQ #1# (APPLY #'|AssociationListAggregate;| #2#)))
                    |AssociationListAggregate;AL|))
           #1#)))) 

(DEFUN |AssociationListAggregate;| (|t#1| |t#2|)
  (SPROG ((#1=#:G692 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (|subst_in_cat| '(#2=#:G691)
                                                   (LIST
                                                    '(|Record|
                                                      (|:| |key| |t#1|)
                                                      (|:| |entry| |t#2|)))
                                                   (COND
                                                    (|AssociationListAggregate;CAT|)
                                                    ('T
                                                     (LETT
                                                      |AssociationListAggregate;CAT|
                                                      (|Join|
                                                       (|TableAggregate| '|t#1|
                                                                         '|t#2|)
                                                       (|ListAggregate| '#2#)
                                                       (|mkCategory|
                                                        '(((|assoc|
                                                            ((|Union|
                                                              (|Record|
                                                               (|:| |key|
                                                                    |t#1|)
                                                               (|:| |entry|
                                                                    |t#2|))
                                                              "failed")
                                                             |t#1| $))
                                                           T))
                                                        NIL NIL NIL))))))))
           (SETELT #1# 0 (LIST '|AssociationListAggregate| |t#1| |t#2|))))) 
