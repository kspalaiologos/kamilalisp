
(DEFPARAMETER |SquareFreeNormalizedTriangularSetCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |SquareFreeNormalizedTriangularSetCategory;|)) 

(DEFPARAMETER |SquareFreeNormalizedTriangularSetCategory;AL| 'NIL) 

(DEFUN |SquareFreeNormalizedTriangularSetCategory| (|t#1| |t#2| |t#3| |t#4|)
  (LET (#1=#:G690
        (#2=#:G691
         (LIST (|devaluate| |t#1|) (|devaluate| |t#2|) (|devaluate| |t#3|)
               (|devaluate| |t#4|))))
    (COND
     ((SETQ #1# (|assoc| #2# |SquareFreeNormalizedTriangularSetCategory;AL|))
      (CDR #1#))
     (T
      (SETQ |SquareFreeNormalizedTriangularSetCategory;AL|
              (|cons5|
               (CONS #2#
                     (SETQ #1#
                             (APPLY
                              #'|SquareFreeNormalizedTriangularSetCategory;|
                              #2#)))
               |SquareFreeNormalizedTriangularSetCategory;AL|))
      #1#)))) 

(DEFUN |SquareFreeNormalizedTriangularSetCategory;| (|t#1| |t#2| |t#3| |t#4|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2| |t#3| |t#4|)
                                   (LIST |t#1| |t#2| |t#3| |t#4|)
                                   (COND
                                    (|SquareFreeNormalizedTriangularSetCategory;CAT|)
                                    ('T
                                     (LETT
                                      |SquareFreeNormalizedTriangularSetCategory;CAT|
                                      (|Join|
                                       (|SquareFreeRegularTriangularSetCategory|
                                        '|t#1| '|t#2| '|t#3| '|t#4|)
                                       (|NormalizedTriangularSetCategory|
                                        '|t#1| '|t#2| '|t#3| '|t#4|)))))))
           (SETELT #1# 0
                   (LIST '|SquareFreeNormalizedTriangularSetCategory| |t#1|
                         |t#2| |t#3| |t#4|))))) 
