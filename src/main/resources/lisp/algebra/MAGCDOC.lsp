
(DECLAIM (NOTINLINE |ModularAlgebraicGcdOperations;|)) 

(DEFPARAMETER |ModularAlgebraicGcdOperations;AL| 'NIL) 

(DEFUN |ModularAlgebraicGcdOperations| (|t#1| |t#2| |t#3|)
  (LET (#1=#:G690
        (#2=#:G691
         (LIST (|devaluate| |t#1|) (|devaluate| |t#2|) (|devaluate| |t#3|))))
    (COND
     ((SETQ #1# (|assoc| #2# |ModularAlgebraicGcdOperations;AL|)) (CDR #1#))
     (T
      (SETQ |ModularAlgebraicGcdOperations;AL|
              (|cons5|
               (CONS #2#
                     (SETQ #1# (APPLY #'|ModularAlgebraicGcdOperations;| #2#)))
               |ModularAlgebraicGcdOperations;AL|))
      #1#)))) 

(DEFUN |ModularAlgebraicGcdOperations;| (|t#1| |t#2| |t#3|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1| |t#2| |t#3|)
                                   (LIST |t#1| |t#2| |t#3|)
                                   (|Join|
                                    (|mkCategory|
                                     '(((|pseudoRem| (|t#2| |t#2| |t#2| |t#3|))
                                        T)
                                       ((|canonicalIfCan|
                                         ((|Union| |t#2| "failed") |t#2|
                                          |t#3|))
                                        T)
                                       ((|pack_modulus|
                                         ((|Union| |t#3| "failed")
                                          (|List| |t#1|) (|List| (|Symbol|))
                                          (|Integer|)))
                                        T)
                                       ((|MPtoMPT|
                                         ((|Union| |t#2| "failed") |t#1|
                                          (|Symbol|) (|List| (|Symbol|))
                                          |t#3|))
                                        T)
                                       ((|zero?| ((|Boolean|) |t#2|)) T)
                                       ((|degree| ((|Integer|) |t#2|)) T)
                                       ((|pack_exps|
                                         ((|SortedExponentVector|) (|Integer|)
                                          (|Integer|) |t#3|))
                                        T)
                                       ((|repack1|
                                         ((|Void|) |t#2| (|U32Vector|)
                                          (|Integer|) |t#3|))
                                        T))
                                     NIL NIL NIL))))
           (SETELT #1# 0
                   (LIST '|ModularAlgebraicGcdOperations| |t#1| |t#2| |t#3|))))) 
