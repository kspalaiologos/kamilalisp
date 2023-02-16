
(DEFPARAMETER |MonogenicAlgebra;CAT| 'NIL) 

(DECLAIM (NOTINLINE |MonogenicAlgebra;|)) 

(DEFPARAMETER |MonogenicAlgebra;AL| 'NIL) 

(DEFUN |MonogenicAlgebra| (|t#1| |t#2|)
  (LET (#1=#:G690 (#2=#:G691 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND ((SETQ #1# (|assoc| #2# |MonogenicAlgebra;AL|)) (CDR #1#))
          (T
           (SETQ |MonogenicAlgebra;AL|
                   (|cons5|
                    (CONS #2# (SETQ #1# (APPLY #'|MonogenicAlgebra;| #2#)))
                    |MonogenicAlgebra;AL|))
           #1#)))) 

(DEFUN |MonogenicAlgebra;| (|t#1| |t#2|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (COND (|MonogenicAlgebra;CAT|)
                                         ('T
                                          (LETT |MonogenicAlgebra;CAT|
                                                (|Join|
                                                 (|FramedAlgebra| '|t#1|
                                                                  '|t#2|)
                                                 (|CommutativeRing|)
                                                 (|ConvertibleTo| '|t#2|)
                                                 (|FullyRetractableTo| '|t#1|)
                                                 (|FullyLinearlyExplicitOver|
                                                  '|t#1|)
                                                 (|mkCategory|
                                                  '(((|generator| ($)) T)
                                                    ((|definingPolynomial|
                                                      (|t#2|))
                                                     T)
                                                    ((|reduce| ($ |t#2|)) T)
                                                    ((|convert| ($ |t#2|)) T)
                                                    ((|lift| (|t#2| $)) T)
                                                    ((|reduce|
                                                      ((|Union| $ "failed")
                                                       (|Fraction| |t#2|)))
                                                     (|has| |t#1| (|Field|)))
                                                    ((|derivationCoordinates|
                                                      ((|Matrix| |t#1|)
                                                       (|Vector| $)
                                                       (|Mapping| |t#1|
                                                                  |t#1|)))
                                                     (|has| |t#1| (|Field|))))
                                                  '(((|Field|)
                                                     (|has| |t#1| (|Field|)))
                                                    ((|DifferentialExtension|
                                                      |t#1|)
                                                     (|has| |t#1| (|Field|)))
                                                    ((|FiniteFieldCategory|)
                                                     (|has| |t#1|
                                                            (|FiniteFieldCategory|))))
                                                  NIL NIL)))))))
           (SETELT #1# 0 (LIST '|MonogenicAlgebra| |t#1| |t#2|))))) 
