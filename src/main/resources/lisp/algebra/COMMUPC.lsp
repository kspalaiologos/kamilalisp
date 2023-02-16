
(SDEFUN |COMMUPC;swap;2UPUP;1| ((|poly| (UPUP)) ($ (UPUP)))
        (SPROG ((|ans| (UPUP)))
               (SEQ (LETT |ans| (|spadConstant| $ 9))
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL |poly| (|spadConstant| $ 9)
                                      (QREFELT $ 13)))
                           (GO G191)))
                         (SEQ
                          (LETT |ans|
                                (SPADCALL |ans|
                                          (|COMMUPC;makePoly|
                                           (SPADCALL |poly| (QREFELT $ 14))
                                           (SPADCALL |poly| (QREFELT $ 16)) $)
                                          (QREFELT $ 17)))
                          (EXIT
                           (LETT |poly| (SPADCALL |poly| (QREFELT $ 18)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |ans|)))) 

(SDEFUN |COMMUPC;makePoly|
        ((|poly| (UP)) (|d| (|NonNegativeInteger|)) ($ (UPUP)))
        (SPROG ((|ans| (UPUP)))
               (SEQ (LETT |ans| (|spadConstant| $ 9))
                    (SEQ G190
                         (COND
                          ((NULL
                            (SPADCALL |poly| (|spadConstant| $ 11)
                                      (QREFELT $ 20)))
                           (GO G191)))
                         (SEQ
                          (LETT |ans|
                                (SPADCALL |ans|
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL |poly| (QREFELT $ 21))
                                            |d| (QREFELT $ 22))
                                           (SPADCALL |poly| (QREFELT $ 23))
                                           (QREFELT $ 24))
                                          (QREFELT $ 17)))
                          (EXIT
                           (LETT |poly| (SPADCALL |poly| (QREFELT $ 25)))))
                         NIL (GO G190) G191 (EXIT NIL))
                    (EXIT |ans|)))) 

(DECLAIM (NOTINLINE |CommuteUnivariatePolynomialCategory;|)) 

(DEFUN |CommuteUnivariatePolynomialCategory| (&REST #1=#:G703)
  (SPROG NIL
         (PROG (#2=#:G704)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|CommuteUnivariatePolynomialCategory|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |CommuteUnivariatePolynomialCategory;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|CommuteUnivariatePolynomialCategory|)))))))))) 

(DEFUN |CommuteUnivariatePolynomialCategory;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$|
                (LIST '|CommuteUnivariatePolynomialCategory| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 26))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|CommuteUnivariatePolynomialCategory|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|CommuteUnivariatePolynomialCategory| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (0 . |Zero|) (4 . |Zero|) (8 . |Zero|) (|Boolean|)
              (12 . ~=) (18 . |leadingCoefficient|) (|NonNegativeInteger|)
              (23 . |degree|) (28 . +) (34 . |reductum|) |COMMUPC;swap;2UPUP;1|
              (39 . ~=) (45 . |leadingCoefficient|) (50 . |monomial|)
              (56 . |degree|) (61 . |monomial|) (67 . |reductum|))
           '#(|swap| 72) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory| (LIST '((|swap| (|#3| |#3|)) T))
                                          (LIST) NIL NIL)))
                        (|makeByteWordVec2| 25
                                            '(0 8 0 9 0 6 0 10 0 7 0 11 2 8 12
                                              0 0 13 1 8 7 0 14 1 8 15 0 16 2 8
                                              0 0 0 17 1 8 0 0 18 2 7 12 0 0 20
                                              1 7 6 0 21 2 7 0 6 15 22 1 7 15 0
                                              23 2 8 0 7 15 24 1 7 0 0 25 1 0 8
                                              8 19)))))
           '|lookupComplete|)) 
