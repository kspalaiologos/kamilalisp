
(DECLAIM (NOTINLINE |PartialTranscendentalFunctions;|)) 

(DEFPARAMETER |PartialTranscendentalFunctions;AL| 'NIL) 

(DEFUN |PartialTranscendentalFunctions| (|t#1|)
  (LET (#1=#:G690 (#2=#:G691 (|devaluate| |t#1|)))
    (COND
     ((SETQ #1# (|assoc| #2# |PartialTranscendentalFunctions;AL|)) (CDR #1#))
     (T
      (SETQ |PartialTranscendentalFunctions;AL|
              (|cons5|
               (CONS #2# (SETQ #1# (|PartialTranscendentalFunctions;| #2#)))
               |PartialTranscendentalFunctions;AL|))
      #1#)))) 

(DEFUN |PartialTranscendentalFunctions;| (|t#1|)
  (SPROG ((#1=#:G689 NIL))
         (PROG1
             (LETT #1#
                   (|subst_in_cat| '(|t#1|) (LIST |t#1|)
                                   (|Join|
                                    (|mkCategory|
                                     '(((|nthRootIfCan|
                                         ((|Union| |t#1| "failed") |t#1|
                                          (|NonNegativeInteger|)))
                                        T)
                                       ((|expIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|logIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|sinIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|cosIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|tanIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|cotIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|secIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|cscIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|asinIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|acosIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|atanIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|acotIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|asecIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|acscIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|sinhIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|coshIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|tanhIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|cothIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|sechIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|cschIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|asinhIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|acoshIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|atanhIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|acothIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|asechIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T)
                                       ((|acschIfCan|
                                         ((|Union| |t#1| "failed") |t#1|))
                                        T))
                                     NIL NIL NIL))))
           (SETELT #1# 0 (LIST '|PartialTranscendentalFunctions| |t#1|))))) 
