
(DEFPARAMETER |BinaryTreeCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |BinaryTreeCategory;|)) 

(DEFPARAMETER |BinaryTreeCategory;AL| 'NIL) 

(DEFUN |BinaryTreeCategory| (|t#1|)
  (LET (#1=#:G698 (#2=#:G699 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |BinaryTreeCategory;AL|)) (CDR #1#))
          (T
           (SETQ |BinaryTreeCategory;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|BinaryTreeCategory;| #2#)))
                            |BinaryTreeCategory;AL|))
           #1#)))) 

(DEFUN |BinaryTreeCategory;| (|t#1|)
  (SPROG ((#1=#:G697 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|BinaryTreeCategory;CAT|)
                                         ('T
                                          (LETT |BinaryTreeCategory;CAT|
                                                (|Join|
                                                 (|BinaryRecursiveAggregate|
                                                  '|t#1|)
                                                 (|shallowlyMutable|)
                                                 (|finiteAggregate|)
                                                 (|mkCategory|
                                                  '(((|node| ($ $ |t#1| $)) T))
                                                  NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|BinaryTreeCategory| |t#1|))))) 
