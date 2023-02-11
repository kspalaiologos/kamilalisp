
(DEFPARAMETER |DifferentialPolynomialCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |DifferentialPolynomialCategory;|)) 

(DEFPARAMETER |DifferentialPolynomialCategory;AL| 'NIL) 

(DEFUN |DifferentialPolynomialCategory| (|t#1| |t#2| |t#3| |t#4|)
  (LET (#1=#:G708
        (#2=#:G709
         (LIST (|devaluate| |t#1|) (|devaluate| |t#2|) (|devaluate| |t#3|)
               (|devaluate| |t#4|))))
    (COND
     ((SETQ #1# (|assoc| #2# |DifferentialPolynomialCategory;AL|)) (CDR #1#))
     (T
      (SETQ |DifferentialPolynomialCategory;AL|
              (|cons5|
               (CONS #2#
                     (SETQ #1#
                             (APPLY #'|DifferentialPolynomialCategory;| #2#)))
               |DifferentialPolynomialCategory;AL|))
      #1#)))) 

(DEFUN |DifferentialPolynomialCategory;| (|t#1| |t#2| |t#3| |t#4|)
  (SPROG ((#1=#:G707 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2| |t#3| |t#4|)
                                   (LIST |t#1| |t#2| |t#3| |t#4|)
                                   (COND (|DifferentialPolynomialCategory;CAT|)
                                         ('T
                                          (LETT
                                           |DifferentialPolynomialCategory;CAT|
                                           (|Join|
                                            (|PolynomialCategory| '|t#1| '|t#4|
                                                                  '|t#3|)
                                            (|DifferentialExtension| '|t#1|)
                                            (|RetractableTo| '|t#2|)
                                            (|mkCategory|
                                             '(((|makeVariable|
                                                 ((|Mapping| $
                                                             (|NonNegativeInteger|))
                                                  |t#2|))
                                                T)
                                               ((|differentialVariables|
                                                 ((|List| |t#2|) $))
                                                T)
                                               ((|order|
                                                 ((|NonNegativeInteger|) $
                                                  |t#2|))
                                                T)
                                               ((|order|
                                                 ((|NonNegativeInteger|) $))
                                                T)
                                               ((|degree|
                                                 ((|NonNegativeInteger|) $
                                                  |t#2|))
                                                T)
                                               ((|weights|
                                                 ((|List|
                                                   (|NonNegativeInteger|))
                                                  $))
                                                T)
                                               ((|weight|
                                                 ((|NonNegativeInteger|) $))
                                                T)
                                               ((|weights|
                                                 ((|List|
                                                   (|NonNegativeInteger|))
                                                  $ |t#2|))
                                                T)
                                               ((|weight|
                                                 ((|NonNegativeInteger|) $
                                                  |t#2|))
                                                T)
                                               ((|isobaric?| ((|Boolean|) $))
                                                T)
                                               ((|leader| (|t#3| $)) T)
                                               ((|initial| ($ $)) T)
                                               ((|separant| ($ $)) T)
                                               ((|makeVariable|
                                                 ((|Mapping| $
                                                             (|NonNegativeInteger|))
                                                  $))
                                                (|has| |t#1|
                                                       (|DifferentialRing|))))
                                             '(((|InnerEvalable| |t#2| |t#1|)
                                                (|has| |t#1|
                                                       (|DifferentialRing|)))
                                               ((|InnerEvalable| |t#2| $)
                                                (|has| |t#1|
                                                       (|DifferentialRing|)))
                                               ((|Evalable| $)
                                                (|has| |t#1|
                                                       (|DifferentialRing|))))
                                             NIL NIL)))))))
           (SETELT #1# 0
                   (LIST '|DifferentialPolynomialCategory| |t#1| |t#2| |t#3|
                         |t#4|))))) 
