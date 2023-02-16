
(DEFPARAMETER |SquareMatrixCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |SquareMatrixCategory;|)) 

(DEFPARAMETER |SquareMatrixCategory;AL| 'NIL) 

(DEFUN |SquareMatrixCategory| (|t#1| |t#2| |t#3| |t#4|)
  (LET (#1=#:G702
        (#2=#:G703
         (LIST |t#1| (|devaluate| |t#2|) (|devaluate| |t#3|)
               (|devaluate| |t#4|))))
    (COND ((SETQ #1# (|assoc| #2# |SquareMatrixCategory;AL|)) (CDR #1#))
          (T
           (SETQ |SquareMatrixCategory;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (APPLY #'|SquareMatrixCategory;| #2#)))
                    |SquareMatrixCategory;AL|))
           #1#)))) 

(DEFUN |SquareMatrixCategory;| (|t#1| |t#2| |t#3| |t#4|)
  (SPROG ((#1=#:G701 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2| |t#3| |t#4|)
                                   (LIST |t#1| |t#2| |t#3| |t#4|)
                                   (COND (|SquareMatrixCategory;CAT|)
                                         ('T
                                          (LETT |SquareMatrixCategory;CAT|
                                                (|Join| (|SemiRng|)
                                                        (|AbelianMonoid|)
                                                        (|BiModule| '|t#2|
                                                                    '|t#2|)
                                                        (|TwoSidedRecip|)
                                                        (|RectangularMatrixCategory|
                                                         |t#1| |t#1| '|t#2|
                                                         '|t#3| '|t#4|)
                                                        (|FullyRetractableTo|
                                                         '|t#2|)
                                                        (|mkCategory|
                                                         '(((|scalarMatrix|
                                                             ($ |t#2|))
                                                            T)
                                                           ((|diagonalMatrix|
                                                             ($
                                                              (|List| |t#2|)))
                                                            T)
                                                           ((|diagonal|
                                                             (|t#3| $))
                                                            T)
                                                           ((|trace| (|t#2| $))
                                                            T)
                                                           ((|diagonalProduct|
                                                             (|t#2| $))
                                                            T)
                                                           ((* (|t#4| $ |t#4|))
                                                            T)
                                                           ((* (|t#3| |t#3| $))
                                                            T)
                                                           ((|determinant|
                                                             (|t#2| $))
                                                            (|has| |t#2|
                                                                   (|CommutativeRing|)))
                                                           ((|minordet|
                                                             (|t#2| $))
                                                            (|has| |t#2|
                                                                   (|CommutativeRing|)))
                                                           ((|Pfaffian|
                                                             (|t#2| $))
                                                            (|has| |t#2|
                                                                   (|CommutativeRing|)))
                                                           ((|inverse|
                                                             ((|Union| $
                                                                       "failed")
                                                              $))
                                                            (|has| |t#2|
                                                                   (|Field|)))
                                                           ((^
                                                             ($ $ (|Integer|)))
                                                            (|has| |t#2|
                                                                   (|Field|))))
                                                         '(((|SemiRing|)
                                                            (|has| |t#2|
                                                                   (|SemiRing|)))
                                                           ((|DifferentialExtension|
                                                             |t#2|)
                                                            (|has| |t#2|
                                                                   (|Ring|)))
                                                           ((|FullyLinearlyExplicitOver|
                                                             |t#2|)
                                                            (|has| |t#2|
                                                                   (|Ring|)))
                                                           ((|Algebra| |t#2|)
                                                            (|has| |t#2|
                                                                   (|CommutativeRing|))))
                                                         NIL NIL)))))))
           (SETELT #1# 0
                   (LIST '|SquareMatrixCategory| |t#1| |t#2| |t#3| |t#4|))))) 
