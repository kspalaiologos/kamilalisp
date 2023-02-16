
(SDEFUN |COMPLPAT;convert;CSP;1| ((|cs| (CS)) ($ (|Pattern| R)))
        (COND
         ((SPADCALL (SPADCALL |cs| (QREFELT $ 14)) (QREFELT $ 15))
          (SPADCALL (SPADCALL |cs| (QREFELT $ 16)) (QREFELT $ 17)))
         ('T
          (SPADCALL (SPADCALL (SPADCALL |cs| (QREFELT $ 16)) (QREFELT $ 17))
                    (SPADCALL (QREFELT $ 13)
                              (SPADCALL (SPADCALL |cs| (QREFELT $ 14))
                                        (QREFELT $ 17))
                              (QREFELT $ 18))
                    (QREFELT $ 19))))) 

(DECLAIM (NOTINLINE |ComplexPattern;|)) 

(DEFUN |ComplexPattern| (&REST #1=#:G693)
  (SPROG NIL
         (PROG (#2=#:G694)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ComplexPattern|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ComplexPattern;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|ComplexPattern|)))))))))) 

(DEFUN |ComplexPattern;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|ComplexPattern| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 21))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ComplexPattern|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 13 (SPADCALL '|%i| 'T NIL NIL (QREFELT $ 12)))
          $))) 

(MAKEPROP '|ComplexPattern| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Symbol|) (|Boolean|) (|Pattern| 6)
              (0 . |patternVariable|) '|ipat| (8 . |imag|) (13 . |zero?|)
              (18 . |real|) (23 . |convert|) (28 . *) (34 . +)
              |COMPLPAT;convert;CSP;1|)
           '#(|convert| 40) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|convert| ((|Pattern| |#1|) |#3|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 20
                                            '(4 11 0 9 10 10 10 12 1 8 7 0 14 1
                                              7 10 0 15 1 8 7 0 16 1 7 11 0 17
                                              2 11 0 0 0 18 2 11 0 0 0 19 1 0
                                              11 8 20)))))
           '|lookupComplete|)) 
