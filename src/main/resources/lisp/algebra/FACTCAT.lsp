
(DECLAIM (NOTINLINE |FacetCategory;|)) 

(DEFPARAMETER |FacetCategory;AL| 'NIL) 

(DEFUN |FacetCategory| ()
  (COND (|FacetCategory;AL|) (T (SETQ |FacetCategory;AL| (|FacetCategory;|))))) 

(DEFUN |FacetCategory;| ()
  (SPROG ((#1=#:G690 NIL))
         (PROG1
             (LETT #1#
                   (|Join| (|SetCategory|) (|OrderedSet|)
                           (|mkCategory|
                            '(((|getMult| ((|Integer|) $)) T)
                              ((|order| ((|NonNegativeInteger|) $)) T)
                              ((|empty?| ((|Boolean|) $)) T))
                            NIL NIL NIL)))
           (SETELT #1# 0 '(|FacetCategory|))))) 

(MAKEPROP '|FacetCategory| 'NILADIC T) 
