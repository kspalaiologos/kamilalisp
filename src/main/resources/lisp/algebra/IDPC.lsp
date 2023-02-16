
(DEFPARAMETER |IndexedDirectProductCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |IndexedDirectProductCategory;|)) 

(DEFPARAMETER |IndexedDirectProductCategory;AL| 'NIL) 

(DEFUN |IndexedDirectProductCategory| (|t#1| |t#2|)
  (LET (#1=#:G690 (#2=#:G691 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND
     ((SETQ #1# (|assoc| #2# |IndexedDirectProductCategory;AL|)) (CDR #1#))
     (T
      (SETQ |IndexedDirectProductCategory;AL|
              (|cons5|
               (CONS #2#
                     (SETQ #1# (APPLY #'|IndexedDirectProductCategory;| #2#)))
               |IndexedDirectProductCategory;AL|))
      #1#)))) 

(DEFUN |IndexedDirectProductCategory;| (|t#1| |t#2|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (COND (|IndexedDirectProductCategory;CAT|)
                                         ('T
                                          (LETT
                                           |IndexedDirectProductCategory;CAT|
                                           (|Join|
                                            (|IndexedProductCategory| '|t#1|
                                                                      '|t#2|)
                                            (|mkCategory|
                                             '(((|listOfTerms|
                                                 ((|List|
                                                   (|Record| (|:| |k| |t#2|)
                                                             (|:| |c| |t#1|)))
                                                  $))
                                                T)
                                               ((|numberOfMonomials|
                                                 ((|NonNegativeInteger|) $))
                                                T))
                                             '(((|Comparable|)
                                                (AND
                                                 (|has| |t#2| (|Comparable|))
                                                 (|has| |t#1|
                                                        (|Comparable|)))))
                                             NIL NIL)))))))
           (SETELT #1# 0 (LIST '|IndexedDirectProductCategory| |t#1| |t#2|))))) 
