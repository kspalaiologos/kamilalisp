
(DEFPARAMETER |TwoDimensionalArrayCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |TwoDimensionalArrayCategory;|)) 

(DEFPARAMETER |TwoDimensionalArrayCategory;AL| 'NIL) 

(DEFUN |TwoDimensionalArrayCategory| (|t#1| |t#2| |t#3|)
  (LET (#1=#:G789
        (#2=#:G790
         (LIST (|devaluate| |t#1|) (|devaluate| |t#2|) (|devaluate| |t#3|))))
    (COND ((SETQ #1# (|assoc| #2# |TwoDimensionalArrayCategory;AL|)) (CDR #1#))
          (T
           (SETQ |TwoDimensionalArrayCategory;AL|
                   (|cons5|
                    (CONS #2#
                          (SETQ #1#
                                  (APPLY #'|TwoDimensionalArrayCategory;|
                                         #2#)))
                    |TwoDimensionalArrayCategory;AL|))
           #1#)))) 

(DEFUN |TwoDimensionalArrayCategory;| (|t#1| |t#2| |t#3|)
  (SPROG ((#1=#:G788 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2| |t#3|)
                                   (LIST |t#1| |t#2| |t#3|)
                                   (COND (|TwoDimensionalArrayCategory;CAT|)
                                         ('T
                                          (LETT
                                           |TwoDimensionalArrayCategory;CAT|
                                           (|Join|
                                            (|HomogeneousAggregate| '|t#1|)
                                            (|shallowlyMutable|)
                                            (|finiteAggregate|)
                                            (|mkCategory|
                                             '(((|new|
                                                 ($ (|NonNegativeInteger|)
                                                  (|NonNegativeInteger|)
                                                  |t#1|))
                                                T)
                                               ((|qnew|
                                                 ($ (|NonNegativeInteger|)
                                                  (|NonNegativeInteger|)))
                                                T)
                                               ((|fill!| ($ $ |t#1|)) T)
                                               ((|minRowIndex| ((|Integer|) $))
                                                T)
                                               ((|maxRowIndex| ((|Integer|) $))
                                                T)
                                               ((|minColIndex| ((|Integer|) $))
                                                T)
                                               ((|maxColIndex| ((|Integer|) $))
                                                T)
                                               ((|nrows|
                                                 ((|NonNegativeInteger|) $))
                                                T)
                                               ((|ncols|
                                                 ((|NonNegativeInteger|) $))
                                                T)
                                               ((|elt|
                                                 (|t#1| $ (|Integer|)
                                                  (|Integer|)))
                                                T)
                                               ((|qelt|
                                                 (|t#1| $ (|Integer|)
                                                  (|Integer|)))
                                                T)
                                               ((|elt|
                                                 (|t#1| $ (|Integer|)
                                                  (|Integer|) |t#1|))
                                                T)
                                               ((|row| (|t#2| $ (|Integer|)))
                                                T)
                                               ((|column|
                                                 (|t#3| $ (|Integer|)))
                                                T)
                                               ((|parts| ((|List| |t#1|) $)) T)
                                               ((|listOfLists|
                                                 ((|List| (|List| |t#1|)) $))
                                                T)
                                               ((|subMatrix|
                                                 ($ $ (|Integer|) (|Integer|)
                                                  (|Integer|) (|Integer|)))
                                                T)
                                               ((|elt|
                                                 ($ $ (|Integer|)
                                                  (|List| (|Integer|))))
                                                T)
                                               ((|elt|
                                                 ($ $ (|List| (|Integer|))
                                                  (|Integer|)))
                                                T)
                                               ((|elt|
                                                 ($ $ (|List| (|Integer|))
                                                  (|List| (|Integer|))))
                                                T)
                                               ((|elt|
                                                 ($ $ (|Segment| (|Integer|))
                                                  (|Segment| (|Integer|))))
                                                T)
                                               ((|elt|
                                                 ($ $ (|List| (|Integer|))
                                                  (|Segment| (|Integer|))))
                                                T)
                                               ((|elt|
                                                 ($ $ (|Segment| (|Integer|))
                                                  (|List| (|Integer|))))
                                                T)
                                               ((|elt|
                                                 ($ $ (|Integer|)
                                                  (|List|
                                                   (|Segment| (|Integer|)))))
                                                T)
                                               ((|elt|
                                                 ($ $
                                                  (|List|
                                                   (|Segment| (|Integer|)))
                                                  (|Integer|)))
                                                T)
                                               ((|setelt!|
                                                 ($ $ (|Integer|)
                                                  (|List|
                                                   (|Segment| (|Integer|)))
                                                  $))
                                                T)
                                               ((|setelt!|
                                                 ($ $
                                                  (|List|
                                                   (|Segment| (|Integer|)))
                                                  (|Integer|) $))
                                                T)
                                               ((|elt|
                                                 ($ $ (|Segment| (|Integer|))
                                                  (|List|
                                                   (|Segment| (|Integer|)))))
                                                T)
                                               ((|elt|
                                                 ($ $
                                                  (|List|
                                                   (|Segment| (|Integer|)))
                                                  (|Segment| (|Integer|))))
                                                T)
                                               ((|elt|
                                                 ($ $
                                                  (|List|
                                                   (|Segment| (|Integer|)))
                                                  (|List|
                                                   (|Segment| (|Integer|)))))
                                                T)
                                               ((|rowSlice|
                                                 ((|Segment| (|Integer|)) $))
                                                T)
                                               ((|colSlice|
                                                 ((|Segment| (|Integer|)) $))
                                                T)
                                               ((|setelt!|
                                                 (|t#1| $ (|Integer|)
                                                  (|Integer|) |t#1|))
                                                T)
                                               ((|qsetelt!|
                                                 (|t#1| $ (|Integer|)
                                                  (|Integer|) |t#1|))
                                                T)
                                               ((|setRow!|
                                                 ($ $ (|Integer|) |t#2|))
                                                T)
                                               ((|setColumn!|
                                                 ($ $ (|Integer|) |t#3|))
                                                T)
                                               ((|setelt!|
                                                 ($ $ (|Integer|)
                                                  (|List| (|Integer|)) $))
                                                T)
                                               ((|setelt!|
                                                 ($ $ (|List| (|Integer|))
                                                  (|Integer|) $))
                                                T)
                                               ((|setelt!|
                                                 ($ $ (|List| (|Integer|))
                                                  (|List| (|Integer|)) $))
                                                T)
                                               ((|setelt!|
                                                 ($ $ (|Segment| (|Integer|))
                                                  (|Segment| (|Integer|)) $))
                                                T)
                                               ((|setelt!|
                                                 ($ $ (|List| (|Integer|))
                                                  (|Segment| (|Integer|)) $))
                                                T)
                                               ((|setelt!|
                                                 ($ $ (|Segment| (|Integer|))
                                                  (|List| (|Integer|)) $))
                                                T)
                                               ((|setelt!|
                                                 ($ $ (|Segment| (|Integer|))
                                                  (|List|
                                                   (|Segment| (|Integer|)))
                                                  $))
                                                T)
                                               ((|setelt!|
                                                 ($ $
                                                  (|List|
                                                   (|Segment| (|Integer|)))
                                                  (|Segment| (|Integer|)) $))
                                                T)
                                               ((|setelt!|
                                                 ($ $
                                                  (|List|
                                                   (|Segment| (|Integer|)))
                                                  (|List|
                                                   (|Segment| (|Integer|)))
                                                  $))
                                                T)
                                               ((|setsubMatrix!|
                                                 ($ $ (|Integer|) (|Integer|)
                                                  $))
                                                T)
                                               ((|swapRows!|
                                                 ($ $ (|Integer|) (|Integer|)))
                                                T)
                                               ((|swapColumns!|
                                                 ($ $ (|Integer|) (|Integer|)))
                                                T)
                                               ((|transpose| ($ $)) T)
                                               ((|squareTop| ($ $)) T)
                                               ((|horizConcat| ($ $ $)) T)
                                               ((|horizConcat| ($ (|List| $)))
                                                T)
                                               ((|vertConcat| ($ $ $)) T)
                                               ((|vertConcat| ($ (|List| $)))
                                                T)
                                               ((|blockConcat|
                                                 ($ (|List| (|List| $))))
                                                T)
                                               ((|vertSplit|
                                                 ((|List| $) $
                                                  (|PositiveInteger|)))
                                                T)
                                               ((|vertSplit|
                                                 ((|List| $) $
                                                  (|List|
                                                   (|NonNegativeInteger|))))
                                                T)
                                               ((|horizSplit|
                                                 ((|List| $) $
                                                  (|PositiveInteger|)))
                                                T)
                                               ((|horizSplit|
                                                 ((|List| $) $
                                                  (|List|
                                                   (|NonNegativeInteger|))))
                                                T)
                                               ((|blockSplit|
                                                 ((|List| (|List| $)) $
                                                  (|PositiveInteger|)
                                                  (|PositiveInteger|)))
                                                T)
                                               ((|blockSplit|
                                                 ((|List| (|List| $)) $
                                                  (|List|
                                                   (|NonNegativeInteger|))
                                                  (|List|
                                                   (|NonNegativeInteger|))))
                                                T)
                                               ((|map|
                                                 ($ (|Mapping| |t#1| |t#1|) $))
                                                T)
                                               ((|map!|
                                                 ($ (|Mapping| |t#1| |t#1|) $))
                                                T)
                                               ((|map|
                                                 ($
                                                  (|Mapping| |t#1| |t#1| |t#1|)
                                                  $ $))
                                                T)
                                               ((|map|
                                                 ($
                                                  (|Mapping| |t#1| |t#1| |t#1|)
                                                  $ $ |t#1|))
                                                T))
                                             '(((|Comparable|)
                                                (|has| |t#1| (|Comparable|))))
                                             NIL NIL)))))))
           (SETELT #1# 0
                   (LIST '|TwoDimensionalArrayCategory| |t#1| |t#2| |t#3|))))) 
