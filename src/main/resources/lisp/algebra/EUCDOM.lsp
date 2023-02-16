
(DECLAIM (NOTINLINE |EuclideanDomain;|)) 

(DEFPARAMETER |EuclideanDomain;AL| 'NIL) 

(DEFUN |EuclideanDomain| ()
  (COND (|EuclideanDomain;AL|)
        (T (SETQ |EuclideanDomain;AL| (|EuclideanDomain;|))))) 

(DEFUN |EuclideanDomain;| ()
  (SPROG ((#1=#:G706 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|PrincipalIdealDomain|)
                           (|mkCategory|
                            '(((|sizeLess?| ((|Boolean|) $ $)) T)
                              ((|euclideanSize| ((|NonNegativeInteger|) $)) T)
                              ((|divide|
                                ((|Record| (|:| |quotient| $)
                                           (|:| |remainder| $))
                                 $ $))
                               T)
                              ((|quo| ($ $ $)) T) ((|rem| ($ $ $)) T)
                              ((|extendedEuclidean|
                                ((|Record| (|:| |coef1| $) (|:| |coef2| $)
                                           (|:| |generator| $))
                                 $ $))
                               T)
                              ((|extendedEuclidean|
                                ((|Union|
                                  (|Record| (|:| |coef1| $) (|:| |coef2| $))
                                  "failed")
                                 $ $ $))
                               T)
                              ((|multiEuclidean|
                                ((|Union| (|List| $) "failed") (|List| $) $))
                               T))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|EuclideanDomain|))))) 

(MAKEPROP '|EuclideanDomain| 'NILADIC T) 
