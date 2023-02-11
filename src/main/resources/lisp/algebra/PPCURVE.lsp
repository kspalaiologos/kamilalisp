
(DECLAIM (NOTINLINE |PlottablePlaneCurveCategory;|)) 

(DEFPARAMETER |PlottablePlaneCurveCategory;AL| 'NIL) 

(DEFUN |PlottablePlaneCurveCategory| ()
  (COND (|PlottablePlaneCurveCategory;AL|)
        (T
         (SETQ |PlottablePlaneCurveCategory;AL|
                 (|PlottablePlaneCurveCategory;|))))) 

(DEFUN |PlottablePlaneCurveCategory;| ()
  (SPROG ((#1=#:G690 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(#2=#:G689) (LIST '(|OutputForm|))
                                   (|Join| (|CoercibleTo| '#2#)
                                           (|mkCategory|
                                            '(((|listBranches|
                                                ((|List|
                                                  (|List|
                                                   (|Point| (|DoubleFloat|))))
                                                 $))
                                               T)
                                              ((|xRange|
                                                ((|Segment| (|DoubleFloat|))
                                                 $))
                                               T)
                                              ((|yRange|
                                                ((|Segment| (|DoubleFloat|))
                                                 $))
                                               T))
                                            NIL NIL NIL))))
           (SETELT #1# 0 '(|PlottablePlaneCurveCategory|))))) 

(MAKEPROP '|PlottablePlaneCurveCategory| 'NILADIC T) 
