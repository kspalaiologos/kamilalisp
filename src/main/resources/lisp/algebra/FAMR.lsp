
(DEFPARAMETER |FiniteAbelianMonoidRing;CAT| 'NIL) 

(DECLAIM (NOTINLINE |FiniteAbelianMonoidRing;|)) 

(DEFPARAMETER |FiniteAbelianMonoidRing;AL| 'NIL) 

(DEFUN |FiniteAbelianMonoidRing| (|t#1| |t#2|)
  (LET (#1=#:G699 (#2=#:G700 (LIST (|devaluate| |t#1|) (|devaluate| |t#2|))))
    (COND ((SETQ #1# (|assoc| #2# |FiniteAbelianMonoidRing;AL|)) (CDR #1#))
          (T
           (SETQ |FiniteAbelianMonoidRing;AL|
                   (|cons5|
                    (CONS #2#
                          (SETQ #1# (APPLY #'|FiniteAbelianMonoidRing;| #2#)))
                    |FiniteAbelianMonoidRing;AL|))
           #1#)))) 

(DEFUN |FiniteAbelianMonoidRing;| (|t#1| |t#2|)
  (SPROG ((#1=#:G698 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2|) (LIST |t#1| |t#2|)
                                   (COND (|FiniteAbelianMonoidRing;CAT|)
                                         ('T
                                          (LETT |FiniteAbelianMonoidRing;CAT|
                                                (|Join|
                                                 (|AbelianMonoidRing| '|t#1|
                                                                      '|t#2|)
                                                 (|FreeModuleCategory| '|t#1|
                                                                       '|t#2|)
                                                 (|FullyRetractableTo| '|t#1|)
                                                 (|mkCategory|
                                                  '(((|ground?|
                                                      ((|Boolean|) $))
                                                     T)
                                                    ((|ground| (|t#1| $)) T)
                                                    ((|minimumDegree|
                                                      (|t#2| $))
                                                     T)
                                                    ((|mapExponents|
                                                      ($
                                                       (|Mapping| |t#2| |t#2|)
                                                       $))
                                                     T)
                                                    ((|pomopo!|
                                                      ($ $ |t#1| |t#2| $))
                                                     T)
                                                    ((|fmecg|
                                                      ($ $ |t#2| |t#1| $))
                                                     (|has| |t#1| (|Ring|)))
                                                    ((|binomThmExpt|
                                                      ($ $ $
                                                       (|NonNegativeInteger|)))
                                                     (|has| $
                                                            (|CommutativeRing|)))
                                                    ((|exquo|
                                                      ((|Union| $ "failed") $
                                                       |t#1|))
                                                     (|has| |t#1|
                                                            (|EntireRing|)))
                                                    ((|content| (|t#1| $))
                                                     (|has| |t#1|
                                                            (|GcdDomain|)))
                                                    ((|primitivePart| ($ $))
                                                     (|has| |t#1|
                                                            (|GcdDomain|))))
                                                  '(((|EntireRing|)
                                                     (|has| |t#1|
                                                            (|EntireRing|))))
                                                  NIL NIL)))))))
           (SETELT #1# 0 (LIST '|FiniteAbelianMonoidRing| |t#1| |t#2|))))) 
