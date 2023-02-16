
(DEFPARAMETER |SegmentCategory;CAT| 'NIL) 

(DECLAIM (NOTINLINE |SegmentCategory;|)) 

(DEFPARAMETER |SegmentCategory;AL| 'NIL) 

(DEFUN |SegmentCategory| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |SegmentCategory;AL|)) (CDR #1#))
          (T
           (SETQ |SegmentCategory;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|SegmentCategory;| #2#)))
                            |SegmentCategory;AL|))
           #1#)))) 

(DEFUN |SegmentCategory;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|SegmentCategory;CAT|)
                                         ('T
                                          (LETT |SegmentCategory;CAT|
                                                (|Join| (|Type|)
                                                        (|mkCategory|
                                                         '(((SEGMENT
                                                             ($ |t#1| |t#1|))
                                                            T)
                                                           ((BY
                                                             ($ $ (|Integer|)))
                                                            T)
                                                           ((|low| (|t#1| $))
                                                            T)
                                                           ((|high| (|t#1| $))
                                                            T)
                                                           ((|incr|
                                                             ((|Integer|) $))
                                                            T)
                                                           ((|segment|
                                                             ($ |t#1| |t#1|))
                                                            T)
                                                           ((|convert|
                                                             ($ |t#1|))
                                                            T)
                                                           ((+ ($ |t#1| $))
                                                            (|has| |t#1|
                                                                   (|AbelianSemiGroup|)))
                                                           ((+ ($ $ |t#1|))
                                                            (|has| |t#1|
                                                                   (|AbelianSemiGroup|)))
                                                           ((- ($ $ |t#1|))
                                                            (|has| |t#1|
                                                                   (|AbelianGroup|)))
                                                           ((|reverse| ($ $))
                                                            (|has| |t#1|
                                                                   (|OrderedRing|))))
                                                         '(((|SetCategory|)
                                                            (|has| |t#1|
                                                                   (|SetCategory|)))
                                                           ((|ConvertibleTo|
                                                             (|InputForm|))
                                                            (|has| |t#1|
                                                                   (|ConvertibleTo|
                                                                    (|InputForm|)))))
                                                         NIL NIL)))))))
           (SETELT #1# 0 (LIST '|SegmentCategory| |t#1|))))) 
