
(DEFPARAMETER |IndexedProductCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |IndexedProductCategory;|)) 

(DEFPARAMETER |IndexedProductCategory;AL| 'NIL) 

(DEFUN |IndexedProductCategory| (|t#1| |t#2|)
  (LET (#1=#:G690 (#2=#:G691 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND ((SETQ #1# (|assoc| #2# |IndexedProductCategory;AL|)) (CDR #1#))
          (T
           (SETQ |IndexedProductCategory;AL|
                   (|cons5|
                    (CONS #2#
                          (SETQ #1# (APPLY #'|IndexedProductCategory;| #2#)))
                    |IndexedProductCategory;AL|))
           #1#)))) 

(DEFUN |IndexedProductCategory;| (|t#1| |t#2|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (COND (|IndexedProductCategory;CAT|)
                                         ('T
                                          (LETT |IndexedProductCategory;CAT|
                                                (|Join|
                                                 (|AbelianProductCategory|
                                                  '|t#1|)
                                                 (|mkCategory|
                                                  '(((|map|
                                                      ($
                                                       (|Mapping| |t#1| |t#1|)
                                                       $))
                                                     T)
                                                    ((|monomial|
                                                      ($ |t#1| |t#2|))
                                                     T)
                                                    ((|monomial?|
                                                      ((|Boolean|) $))
                                                     T)
                                                    ((|construct|
                                                      ($
                                                       (|List|
                                                        (|Record|
                                                         (|:| |k| |t#2|)
                                                         (|:| |c| |t#1|)))))
                                                     T)
                                                    ((|leadingMonomial| ($ $))
                                                     (|has| |t#2|
                                                            (|Comparable|)))
                                                    ((|leadingCoefficient|
                                                      (|t#1| $))
                                                     (|has| |t#2|
                                                            (|Comparable|)))
                                                    ((|leadingSupport|
                                                      (|t#2| $))
                                                     (|has| |t#2|
                                                            (|Comparable|)))
                                                    ((|reductum| ($ $))
                                                     (|has| |t#2|
                                                            (|Comparable|)))
                                                    ((|constructOrdered|
                                                      ($
                                                       (|List|
                                                        (|Record|
                                                         (|:| |k| |t#2|)
                                                         (|:| |c| |t#1|)))))
                                                     (|has| |t#2|
                                                            (|Comparable|)))
                                                    ((|leadingTerm|
                                                      ((|Record|
                                                        (|:| |k| |t#2|)
                                                        (|:| |c| |t#1|))
                                                       $))
                                                     (|has| |t#2|
                                                            (|Comparable|))))
                                                  NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|IndexedProductCategory| |t#1| |t#2|))))) 
