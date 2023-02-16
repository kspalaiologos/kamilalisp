
(DEFPARAMETER |VectorCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |VectorCategory;|)) 

(DEFPARAMETER |VectorCategory;AL| 'NIL) 

(DEFUN |VectorCategory| (|t#1|)
  (LET (#1=#:G695 (#2=#:G696 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |VectorCategory;AL|)) (CDR #1#))
          (T
           (SETQ |VectorCategory;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|VectorCategory;| #2#)))
                            |VectorCategory;AL|))
           #1#)))) 

(DEFUN |VectorCategory;| (|t#1|)
  (SPROG ((#1=#:G694 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|VectorCategory;CAT|)
                                         ('T
                                          (LETT |VectorCategory;CAT|
                                                (|Join|
                                                 (|OneDimensionalArrayAggregate|
                                                  '|t#1|)
                                                 (|mkCategory|
                                                  '(((+ ($ $ $))
                                                     (|has| |t#1|
                                                            (|AbelianSemiGroup|)))
                                                    ((|zero|
                                                      ($
                                                       (|NonNegativeInteger|)))
                                                     (|has| |t#1|
                                                            (|AbelianMonoid|)))
                                                    ((|zero?| ((|Boolean|) $))
                                                     (|has| |t#1|
                                                            (|AbelianMonoid|)))
                                                    ((- ($ $))
                                                     (|has| |t#1|
                                                            (|AbelianGroup|)))
                                                    ((- ($ $ $))
                                                     (|has| |t#1|
                                                            (|AbelianGroup|)))
                                                    ((* ($ (|Integer|) $))
                                                     (|has| |t#1|
                                                            (|AbelianGroup|)))
                                                    ((* ($ |t#1| $))
                                                     (|has| |t#1|
                                                            (|SemiGroup|)))
                                                    ((* ($ $ |t#1|))
                                                     (|has| |t#1|
                                                            (|SemiGroup|)))
                                                    ((|dot| (|t#1| $ $))
                                                     (AND
                                                      (|has| |t#1| (|SemiRng|))
                                                      (|has| |t#1|
                                                             (|AbelianMonoid|))))
                                                    ((|outerProduct|
                                                      ((|Matrix| |t#1|) $ $))
                                                     (|has| |t#1| (|Ring|)))
                                                    ((|cross| ($ $ $))
                                                     (|has| |t#1| (|Ring|)))
                                                    ((|length| (|t#1| $))
                                                     (AND
                                                      (|has| |t#1| (|Ring|))
                                                      (|has| |t#1|
                                                             (|RadicalCategory|)))))
                                                  NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|VectorCategory| |t#1|))))) 
