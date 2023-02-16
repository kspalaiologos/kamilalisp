
(DEFPARAMETER |PolynomialSetCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |PolynomialSetCategory;|)) 

(DEFPARAMETER |PolynomialSetCategory;AL| 'NIL) 

(DEFUN |PolynomialSetCategory| (|t#1| |t#2| |t#3| |t#4|)
  (LET (#1=#:G739
        (#2=#:G740
         (LIST (|devaluate| |t#1|) (|devaluate| |t#2|) (|devaluate| |t#3|)
               (|devaluate| |t#4|))))
    (COND ((SETQ #1# (|assoc| #2# |PolynomialSetCategory;AL|)) (CDR #1#))
          (T
           (SETQ |PolynomialSetCategory;AL|
                   (|cons5|
                    (CONS #2#
                          (SETQ #1# (APPLY #'|PolynomialSetCategory;| #2#)))
                    |PolynomialSetCategory;AL|))
           #1#)))) 

(DEFUN |PolynomialSetCategory;| (|t#1| |t#2| |t#3| |t#4|)
  (SPROG ((#1=#:G738 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2| |t#3| |t#4|)
                                   (LIST |t#1| |t#2| |t#3| |t#4|)
                                   (|subst_in_cat| '(#2=#:G736 #3=#:G737)
                                                   (LIST '(|List| |t#4|)
                                                         '(|List| |t#4|))
                                                   (COND
                                                    (|PolynomialSetCategory;CAT|)
                                                    ('T
                                                     (LETT
                                                      |PolynomialSetCategory;CAT|
                                                      (|Join| (|SetCategory|)
                                                              (|Collection|
                                                               '|t#4|)
                                                              (|CoercibleTo|
                                                               '#2#)
                                                              (|RetractableFrom|
                                                               '#3#)
                                                              (|finiteAggregate|)
                                                              (|mkCategory|
                                                               '(((|mvar|
                                                                   (|t#3| $))
                                                                  T)
                                                                 ((|variables|
                                                                   ((|List|
                                                                     |t#3|)
                                                                    $))
                                                                  T)
                                                                 ((|mainVariables|
                                                                   ((|List|
                                                                     |t#3|)
                                                                    $))
                                                                  T)
                                                                 ((|mainVariable?|
                                                                   ((|Boolean|)
                                                                    |t#3| $))
                                                                  T)
                                                                 ((|collectUnder|
                                                                   ($ $ |t#3|))
                                                                  T)
                                                                 ((|collect|
                                                                   ($ $ |t#3|))
                                                                  T)
                                                                 ((|collectUpper|
                                                                   ($ $ |t#3|))
                                                                  T)
                                                                 ((|sort|
                                                                   ((|Record|
                                                                     (|:|
                                                                      |under|
                                                                      $)
                                                                     (|:|
                                                                      |floor|
                                                                      $)
                                                                     (|:|
                                                                      |upper|
                                                                      $))
                                                                    $ |t#3|))
                                                                  T)
                                                                 ((|trivialIdeal?|
                                                                   ((|Boolean|)
                                                                    $))
                                                                  T)
                                                                 ((|roughBase?|
                                                                   ((|Boolean|)
                                                                    $))
                                                                  (|has| |t#1|
                                                                         (|IntegralDomain|)))
                                                                 ((|roughSubIdeal?|
                                                                   ((|Boolean|)
                                                                    $ $))
                                                                  (|has| |t#1|
                                                                         (|IntegralDomain|)))
                                                                 ((|roughEqualIdeals?|
                                                                   ((|Boolean|)
                                                                    $ $))
                                                                  (|has| |t#1|
                                                                         (|IntegralDomain|)))
                                                                 ((|roughUnitIdeal?|
                                                                   ((|Boolean|)
                                                                    $))
                                                                  (|has| |t#1|
                                                                         (|IntegralDomain|)))
                                                                 ((|headRemainder|
                                                                   ((|Record|
                                                                     (|:| |num|
                                                                          |t#4|)
                                                                     (|:| |den|
                                                                          |t#1|))
                                                                    |t#4| $))
                                                                  (|has| |t#1|
                                                                         (|IntegralDomain|)))
                                                                 ((|remainder|
                                                                   ((|Record|
                                                                     (|:|
                                                                      |rnum|
                                                                      |t#1|)
                                                                     (|:|
                                                                      |polnum|
                                                                      |t#4|)
                                                                     (|:| |den|
                                                                          |t#1|))
                                                                    |t#4| $))
                                                                  (|has| |t#1|
                                                                         (|IntegralDomain|)))
                                                                 ((|rewriteIdealWithHeadRemainder|
                                                                   ((|List|
                                                                     |t#4|)
                                                                    (|List|
                                                                     |t#4|)
                                                                    $))
                                                                  (|has| |t#1|
                                                                         (|IntegralDomain|)))
                                                                 ((|rewriteIdealWithRemainder|
                                                                   ((|List|
                                                                     |t#4|)
                                                                    (|List|
                                                                     |t#4|)
                                                                    $))
                                                                  (|has| |t#1|
                                                                         (|IntegralDomain|)))
                                                                 ((|triangular?|
                                                                   ((|Boolean|)
                                                                    $))
                                                                  (|has| |t#1|
                                                                         (|IntegralDomain|)))
                                                                 ((|iexactQuo|
                                                                   (|t#1| |t#1|
                                                                    |t#1|))
                                                                  (|has| |t#1|
                                                                         (|IntegralDomain|))))
                                                               NIL NIL
                                                               NIL))))))))
           (SETELT #1# 0
                   (LIST '|PolynomialSetCategory| |t#1| |t#2| |t#3| |t#4|))))) 
