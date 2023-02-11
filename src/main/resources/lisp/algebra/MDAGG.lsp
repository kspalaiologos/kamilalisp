
(DEFPARAMETER |MultiDictionary;CAT| 'NIL) 

(DECLAIM (NOTINLINE |MultiDictionary;|)) 

(DEFPARAMETER |MultiDictionary;AL| 'NIL) 

(DEFUN |MultiDictionary| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND ((SETQ #1# (|assoc| #2# |MultiDictionary;AL|)) (CDR #1#))
          (T
           (SETQ |MultiDictionary;AL|
                   (|cons5| (CONS #2# (SETQ #1# (|MultiDictionary;| #2#)))
                            |MultiDictionary;AL|))
           #1#)))) 

(DEFUN |MultiDictionary;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (COND (|MultiDictionary;CAT|)
                                         ('T
                                          (LETT |MultiDictionary;CAT|
                                                (|Join|
                                                 (|DictionaryOperations|
                                                  '|t#1|)
                                                 (|mkCategory|
                                                  '(((|insert!|
                                                      ($ |t#1| $
                                                       (|NonNegativeInteger|)))
                                                     T)
                                                    ((|removeDuplicates!|
                                                      ($ $))
                                                     T)
                                                    ((|duplicates|
                                                      ((|List|
                                                        (|Record|
                                                         (|:| |entry| |t#1|)
                                                         (|:| |count|
                                                              (|NonNegativeInteger|))))
                                                       $))
                                                     T))
                                                  NIL NIL NIL)))))))
           (SETELT #1# 0 (LIST '|MultiDictionary| |t#1|))))) 
