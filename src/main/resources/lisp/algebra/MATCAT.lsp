
(DEFPARAMETER |MatrixCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |MatrixCategory;|)) 

(DEFPARAMETER |MatrixCategory;AL| 'NIL) 

(DEFUN |MatrixCategory| (|t#1| |t#2| |t#3|)
  (LET (#1=#:G720
        (#2=#:G721
         (LIST (|devaluate| |t#1|) (|devaluate| |t#2|) (|devaluate| |t#3|))))
    (COND ((SETQ #1# (|assoc| #2# |MatrixCategory;AL|)) (CDR #1#))
          (T
           (SETQ |MatrixCategory;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (APPLY #'|MatrixCategory;| #2#)))
                    |MatrixCategory;AL|))
           #1#)))) 

(DEFUN |MatrixCategory;| (|t#1| |t#2| |t#3|)
  (SPROG ((#1=#:G719 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2| |t#3|)
                                   (LIST |t#1| |t#2| |t#3|)
                                   (COND (|MatrixCategory;CAT|)
                                         ('T
                                          (LETT |MatrixCategory;CAT|
                                                (|Join|
                                                 (|TwoDimensionalArrayCategory|
                                                  '|t#1| '|t#2| '|t#3|)
                                                 (|shallowlyMutable|)
                                                 (|finiteAggregate|)
                                                 (|mkCategory|
                                                  '(((|square?|
                                                      ((|Boolean|) $))
                                                     T)
                                                    ((|diagonal?|
                                                      ((|Boolean|) $))
                                                     T)
                                                    ((|symmetric?|
                                                      ((|Boolean|) $))
                                                     T)
                                                    ((|antisymmetric?|
                                                      ((|Boolean|) $))
                                                     (|has| |t#1|
                                                            (|AbelianGroup|)))
                                                    ((|zero?| ((|Boolean|) $))
                                                     T)
                                                    ((|zero|
                                                      ($ (|NonNegativeInteger|)
                                                       (|NonNegativeInteger|)))
                                                     T)
                                                    ((|matrix|
                                                      ($
                                                       (|List|
                                                        (|List| |t#1|))))
                                                     T)
                                                    ((|matrix|
                                                      ($ (|NonNegativeInteger|)
                                                       (|NonNegativeInteger|)
                                                       (|Mapping| |t#1|
                                                                  (|Integer|)
                                                                  (|Integer|))))
                                                     T)
                                                    ((|scalarMatrix|
                                                      ($ (|NonNegativeInteger|)
                                                       |t#1|))
                                                     T)
                                                    ((|diagonalMatrix|
                                                      ($ (|List| |t#1|)))
                                                     T)
                                                    ((|diagonalMatrix|
                                                      ($ (|List| $)))
                                                     T)
                                                    ((|kroneckerProduct|
                                                      ($ $ $))
                                                     (|has| |t#1| (|SemiRng|)))
                                                    ((|kroneckerProduct|
                                                      ($ (|List| $)))
                                                     (|has| |t#1| (|SemiRng|)))
                                                    ((|kroneckerSum| ($ $ $))
                                                     T)
                                                    ((|kroneckerSum|
                                                      ($ (|List| $)))
                                                     T)
                                                    ((|coerce| ($ |t#3|)) T)
                                                    ((|transpose| ($ |t#2|)) T)
                                                    ((+ ($ $ $)) T)
                                                    ((- ($ $ $))
                                                     (|has| |t#1|
                                                            (|AbelianGroup|)))
                                                    ((- ($ $))
                                                     (|has| |t#1|
                                                            (|AbelianGroup|)))
                                                    ((* ($ (|Integer|) $))
                                                     (|has| |t#1|
                                                            (|AbelianGroup|)))
                                                    ((* ($ $ $))
                                                     (|has| |t#1| (|SemiRng|)))
                                                    ((* ($ |t#1| $))
                                                     (|has| |t#1| (|SemiRng|)))
                                                    ((* ($ $ |t#1|))
                                                     (|has| |t#1| (|SemiRng|)))
                                                    ((* (|t#3| $ |t#3|))
                                                     (|has| |t#1| (|SemiRng|)))
                                                    ((* (|t#2| |t#2| $))
                                                     (|has| |t#1| (|SemiRng|)))
                                                    ((|positivePower|
                                                      ($ $ (|Integer|)))
                                                     (|has| |t#1| (|SemiRng|)))
                                                    ((^
                                                      ($ $
                                                       (|NonNegativeInteger|)))
                                                     (AND
                                                      (|has| |t#1| (|Monoid|))
                                                      (|has| |t#1|
                                                             (|SemiRng|))))
                                                    ((|exquo|
                                                      ((|Union| $ "failed") $
                                                       |t#1|))
                                                     (|has| |t#1|
                                                            (|IntegralDomain|)))
                                                    ((/ ($ $ |t#1|))
                                                     (|has| |t#1| (|Field|)))
                                                    ((|rowEchelon| ($ $))
                                                     (|has| |t#1|
                                                            (|EuclideanDomain|)))
                                                    ((|columnSpace|
                                                      ((|List| |t#3|) $))
                                                     (|has| |t#1|
                                                            (|EuclideanDomain|)))
                                                    ((|rank|
                                                      ((|NonNegativeInteger|)
                                                       $))
                                                     (|has| |t#1|
                                                            (|IntegralDomain|)))
                                                    ((|nullity|
                                                      ((|NonNegativeInteger|)
                                                       $))
                                                     (|has| |t#1|
                                                            (|IntegralDomain|)))
                                                    ((|nullSpace|
                                                      ((|List| |t#3|) $))
                                                     (|has| |t#1|
                                                            (|IntegralDomain|)))
                                                    ((|determinant| (|t#1| $))
                                                     (|has| |t#1|
                                                            (|CommutativeRing|)))
                                                    ((|minordet| (|t#1| $))
                                                     (|has| |t#1|
                                                            (|CommutativeRing|)))
                                                    ((|Pfaffian| (|t#1| $))
                                                     (|has| |t#1|
                                                            (|CommutativeRing|)))
                                                    ((|inverse|
                                                      ((|Union| $ "failed") $))
                                                     (|has| |t#1| (|Field|)))
                                                    ((^ ($ $ (|Integer|)))
                                                     (|has| |t#1| (|Field|)))
                                                    ((|kronecker_prod1|
                                                      ((|Void|) $ (|Integer|)
                                                       (|List|
                                                        (|List|
                                                         (|NonNegativeInteger|)))
                                                       (|List| $)
                                                       (|NonNegativeInteger|)
                                                       (|NonNegativeInteger|)
                                                       (|Union| |t#1| "one")))
                                                     T))
                                                  NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|MatrixCategory| |t#1| |t#2| |t#3|))))) 
