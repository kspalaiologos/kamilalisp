
(DEFPARAMETER |SegmentExpansionCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |SegmentExpansionCategory;|)) 

(DEFPARAMETER |SegmentExpansionCategory;AL| 'NIL) 

(DEFUN |SegmentExpansionCategory| (|t#1| |t#2|)
  (LET (#1=#:G690 (#2=#:G691 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND ((SETQ #1# (|assoc| #2# |SegmentExpansionCategory;AL|)) (CDR #1#))
          (T
           (SETQ |SegmentExpansionCategory;AL|
                   (|cons5|
                    (CONS #2#
                          (SETQ #1# (APPLY #'|SegmentExpansionCategory;| #2#)))
                    |SegmentExpansionCategory;AL|))
           #1#)))) 

(DEFUN |SegmentExpansionCategory;| (|t#1| |t#2|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (COND (|SegmentExpansionCategory;CAT|)
                                         ('T
                                          (LETT |SegmentExpansionCategory;CAT|
                                                (|Join|
                                                 (|SegmentCategory| '|t#1|)
                                                 (|mkCategory|
                                                  '(((|expand|
                                                      (|t#2| (|List| $)))
                                                     T)
                                                    ((|expand| (|t#2| $)) T)
                                                    ((|map|
                                                      (|t#2|
                                                       (|Mapping| |t#1| |t#1|)
                                                       $))
                                                     T))
                                                  NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|SegmentExpansionCategory| |t#1| |t#2|))))) 
