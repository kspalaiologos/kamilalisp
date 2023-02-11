
(DECLAIM (NOTINLINE |SetCategory;|)) 

(DEFPARAMETER |SetCategory;AL| 'NIL) 

(DEFUN |SetCategory| ()
  (COND (|SetCategory;AL|) (T (SETQ |SetCategory;AL| (|SetCategory;|))))) 

(DEFUN |SetCategory;| ()
  (SPROG ((#1=#:G690 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(#2=#:G689) (LIST '(|OutputForm|))
                                   (|Join| (|BasicType|) (|CoercibleTo| '#2#)
                                           (|mkCategory|
                                            '(((|hash| ((|SingleInteger|) $))
                                               T)
                                              ((|hashUpdate!|
                                                ((|HashState|) (|HashState|)
                                                 $))
                                               T)
                                              ((|latex| ((|String|) $)) T))
                                            NIL NIL NIL))))
           (SETELT #1# 0 '(|SetCategory|))))) 

(MAKEPROP '|SetCategory| 'NILADIC T) 
