
(SDEFUN |APPLYORE;apply;PM2M;1|
        ((|p| (P)) (|f| (|Mapping| M M)) (|m| (M)) ($ (M)))
        (SPROG ((|mn| (M)) (|w| (M)) (#1=#:G702 NIL) (|i| NIL))
               (SEQ (LETT |w| (|spadConstant| $ 9)) (LETT |mn| |m|)
                    (SEQ (LETT |i| 0) (LETT #1# (SPADCALL |p| (QREFELT $ 11)))
                         G190 (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ
                          (LETT |w|
                                (SPADCALL |w|
                                          (SPADCALL
                                           (SPADCALL |p| |i| (QREFELT $ 12))
                                           |mn| (QREFELT $ 13))
                                          (QREFELT $ 14)))
                          (EXIT (LETT |mn| (SPADCALL |mn| |f|))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (EXIT |w|)))) 

(DECLAIM (NOTINLINE |ApplyUnivariateSkewPolynomial;|)) 

(DEFUN |ApplyUnivariateSkewPolynomial| (&REST #1=#:G703)
  (SPROG NIL
         (PROG (#2=#:G704)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ApplyUnivariateSkewPolynomial|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |ApplyUnivariateSkewPolynomial;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|ApplyUnivariateSkewPolynomial|)))))))))) 

(DEFUN |ApplyUnivariateSkewPolynomial;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|ApplyUnivariateSkewPolynomial| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 17))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ApplyUnivariateSkewPolynomial|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ApplyUnivariateSkewPolynomial| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (0 . |Zero|) (|NonNegativeInteger|) (4 . |degree|)
              (9 . |coefficient|) (15 . *) (21 . +) (|Mapping| 7 7)
              |APPLYORE;apply;PM2M;1|)
           '#(|apply| 27) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|apply|
                                 (|#2| |#3| (|Mapping| |#2| |#2|) |#2|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 16
                                            '(0 7 0 9 1 8 10 0 11 2 8 6 0 10 12
                                              2 7 0 6 0 13 2 7 0 0 0 14 3 0 7 8
                                              15 7 16)))))
           '|lookupComplete|)) 
