
(SDEFUN |UPMP;noKaratsuba;3U;1| ((|a| (U)) (|b| (U)) ($ (U)))
        (SPROG ((|res| (U)) (#1=#:G721 NIL) (|u| NIL) (|lu| (|List| U)))
               (SEQ
                (COND ((SPADCALL |a| (QREFELT $ 9)) |a|)
                      ((SPADCALL |b| (QREFELT $ 9)) |b|)
                      ((ZEROP (SPADCALL |a| (QREFELT $ 11)))
                       (SPADCALL (SPADCALL |a| (QREFELT $ 12)) |b|
                                 (QREFELT $ 13)))
                      ((ZEROP (SPADCALL |b| (QREFELT $ 11)))
                       (SPADCALL |a| (SPADCALL |b| (QREFELT $ 12))
                                 (QREFELT $ 14)))
                      ('T
                       (SEQ (LETT |lu| (REVERSE (SPADCALL |a| (QREFELT $ 16))))
                            (LETT |res| (|spadConstant| $ 17))
                            (SEQ (LETT |u| NIL) (LETT #1# |lu|) G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |u| (CAR #1#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT |res|
                                         (SPADCALL |res|
                                                   (SPADCALL |u|
                                                             (QREFELT $ 12))
                                                   (SPADCALL |u|
                                                             (QREFELT $ 11))
                                                   |b| (QREFELT $ 18)))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT NIL))
                            (EXIT |res|))))))) 

(SDEFUN |UPMP;karatsubaOnce;3U;2| ((|a| (U)) (|b| (U)) ($ (U)))
        (SPROG
         ((|w| (U)) (|v| (U)) (|u| (U)) (|lb| (U)) (|hb| (U))
          (|rec| (|Record| (|:| |quotient| U) (|:| |remainder| U))) (|la| (U))
          (|ha| (U)) (|n| (|NonNegativeInteger|)) (|d| (|NonNegativeInteger|))
          (|db| #1=(|NonNegativeInteger|)) (|da| #1#))
         (SEQ (LETT |da| (SPADCALL |a| (QREFELT $ 20)))
              (LETT |db| (SPADCALL |b| (QREFELT $ 20)))
              (COND
               ((NULL (ZEROP |da|))
                (LETT |a| (SPADCALL |a| |da| (QREFELT $ 21)))))
              (COND
               ((NULL (ZEROP |db|))
                (LETT |b| (SPADCALL |b| |db| (QREFELT $ 21)))))
              (LETT |d| (+ |da| |db|))
              (LETT |n|
                    (QUOTIENT2
                     (MIN (SPADCALL |a| (QREFELT $ 11))
                          (SPADCALL |b| (QREFELT $ 11)))
                     2))
              (LETT |rec| (SPADCALL |a| |n| (QREFELT $ 23)))
              (LETT |ha| (QCAR |rec|)) (LETT |la| (QCDR |rec|))
              (LETT |rec| (SPADCALL |b| |n| (QREFELT $ 23)))
              (LETT |hb| (QCAR |rec|)) (LETT |lb| (QCDR |rec|))
              (LETT |w|
                    (SPADCALL (SPADCALL |ha| |la| (QREFELT $ 24))
                              (SPADCALL |lb| |hb| (QREFELT $ 24))
                              (QREFELT $ 25)))
              (LETT |u| (SPADCALL |la| |lb| (QREFELT $ 25)))
              (LETT |v| (SPADCALL |ha| |hb| (QREFELT $ 25)))
              (LETT |w|
                    (SPADCALL |w| (SPADCALL |u| |v| (QREFELT $ 26))
                              (QREFELT $ 26)))
              (LETT |w|
                    (SPADCALL (SPADCALL |w| |n| (QREFELT $ 27)) |u|
                              (QREFELT $ 26)))
              (EXIT
               (COND
                ((ZEROP |d|)
                 (SPADCALL (SPADCALL |v| (* 2 |n|) (QREFELT $ 27)) |w|
                           (QREFELT $ 26)))
                ('T
                 (SPADCALL (SPADCALL |v| (+ (* 2 |n|) |d|) (QREFELT $ 27))
                           (SPADCALL |w| |d| (QREFELT $ 27))
                           (QREFELT $ 26)))))))) 

(SDEFUN |UPMP;karatsuba;2U2NniU;3|
        ((|a| (U)) (|b| (U)) (|l| (|NonNegativeInteger|))
         (|k| (|NonNegativeInteger|)) ($ (U)))
        (SPROG
         ((|w| (U)) (|v| (U)) (|u| (U)) (|lb| (U)) (|hb| (U))
          (|rec| (|Record| (|:| |quotient| U) (|:| |remainder| U))) (|la| (U))
          (|ha| (U)) (#1=#:G730 NIL) (|n| (|NonNegativeInteger|))
          (|d| (|NonNegativeInteger|)) (|db| #2=(|NonNegativeInteger|))
          (|da| #2#))
         (SEQ
          (COND
           ((OR (ZEROP |k|)
                (OR (< (SPADCALL |a| (QREFELT $ 11)) |l|)
                    (OR (< (SPADCALL |b| (QREFELT $ 11)) |l|)
                        (OR (< (SPADCALL |a| (QREFELT $ 29)) |l|)
                            (< (SPADCALL |b| (QREFELT $ 29)) |l|)))))
            (SPADCALL |a| |b| (QREFELT $ 19)))
           ('T
            (SEQ (LETT |da| (SPADCALL |a| (QREFELT $ 20)))
                 (LETT |db| (SPADCALL |b| (QREFELT $ 20)))
                 (COND
                  ((NULL (ZEROP |da|))
                   (LETT |a| (SPADCALL |a| |da| (QREFELT $ 21)))))
                 (COND
                  ((NULL (ZEROP |db|))
                   (LETT |b| (SPADCALL |b| |db| (QREFELT $ 21)))))
                 (LETT |d| (+ |da| |db|))
                 (LETT |n|
                       (QUOTIENT2
                        (MIN (SPADCALL |a| (QREFELT $ 11))
                             (SPADCALL |b| (QREFELT $ 11)))
                        2))
                 (LETT |k|
                       (PROG2 (LETT #1# (SPADCALL |k| 1 (QREFELT $ 33)))
                           (QCDR #1#)
                         (|check_union2| (QEQCAR #1# 0) (|NonNegativeInteger|)
                                         (|Union| (|NonNegativeInteger|)
                                                  "failed")
                                         #1#)))
                 (LETT |rec| (SPADCALL |a| |n| (QREFELT $ 23)))
                 (LETT |ha| (QCAR |rec|)) (LETT |la| (QCDR |rec|))
                 (LETT |rec| (SPADCALL |b| |n| (QREFELT $ 23)))
                 (LETT |hb| (QCAR |rec|)) (LETT |lb| (QCDR |rec|))
                 (LETT |w|
                       (SPADCALL (SPADCALL |ha| |la| (QREFELT $ 24))
                                 (SPADCALL |lb| |hb| (QREFELT $ 24)) |l| |k|
                                 (QREFELT $ 34)))
                 (LETT |u| (SPADCALL |la| |lb| |l| |k| (QREFELT $ 34)))
                 (LETT |v| (SPADCALL |ha| |hb| |l| |k| (QREFELT $ 34)))
                 (LETT |w|
                       (SPADCALL |w| (SPADCALL |u| |v| (QREFELT $ 26))
                                 (QREFELT $ 26)))
                 (LETT |w|
                       (SPADCALL (SPADCALL |w| |n| (QREFELT $ 27)) |u|
                                 (QREFELT $ 26)))
                 (EXIT
                  (COND
                   ((ZEROP |d|)
                    (SPADCALL (SPADCALL |v| (* 2 |n|) (QREFELT $ 27)) |w|
                              (QREFELT $ 26)))
                   ('T
                    (SPADCALL (SPADCALL |v| (+ (* 2 |n|) |d|) (QREFELT $ 27))
                              (SPADCALL |w| |d| (QREFELT $ 27))
                              (QREFELT $ 26))))))))))) 

(DECLAIM (NOTINLINE |UnivariatePolynomialMultiplicationPackage;|)) 

(DEFUN |UnivariatePolynomialMultiplicationPackage| (&REST #1=#:G740)
  (SPROG NIL
         (PROG (#2=#:G741)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|UnivariatePolynomialMultiplicationPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function|
                        |UnivariatePolynomialMultiplicationPackage;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|UnivariatePolynomialMultiplicationPackage|)))))))))) 

(DEFUN |UnivariatePolynomialMultiplicationPackage;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$|
                (LIST '|UnivariatePolynomialMultiplicationPackage| DV$1 DV$2))
          (LETT $ (GETREFV 35))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|UnivariatePolynomialMultiplicationPackage|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|UnivariatePolynomialMultiplicationPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Boolean|)
              (0 . |zero?|) (|NonNegativeInteger|) (5 . |degree|)
              (10 . |leadingCoefficient|) (15 . *) (21 . *) (|List| $)
              (27 . |monomials|) (32 . |Zero|) (36 . |pomopo!|)
              |UPMP;noKaratsuba;3U;1| (44 . |minimumDegree|)
              (49 . |shiftRight|)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (55 . |karatsubaDivide|) (61 . -) (67 . *) (73 . +)
              (79 . |shiftLeft|) |UPMP;karatsubaOnce;3U;2|
              (85 . |numberOfMonomials|) (90 . |One|) (94 . |One|)
              (|Union| $ '"failed") (98 . |subtractIfCan|)
              |UPMP;karatsuba;2U2NniU;3|)
           '#(|noKaratsuba| 104 |karatsubaOnce| 110 |karatsuba| 116) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|noKaratsuba| (|#2| |#2| |#2|)) T)
                                   '((|karatsubaOnce| (|#2| |#2| |#2|)) T)
                                   '((|karatsuba|
                                      (|#2| |#2| |#2| (|NonNegativeInteger|)
                                       (|NonNegativeInteger|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 34
                                            '(1 7 8 0 9 1 7 10 0 11 1 7 6 0 12
                                              2 7 0 6 0 13 2 7 0 0 6 14 1 7 15
                                              0 16 0 7 0 17 4 7 0 0 6 10 0 18 1
                                              7 10 0 20 2 7 0 0 10 21 2 7 22 0
                                              10 23 2 7 0 0 0 24 2 7 0 0 0 25 2
                                              7 0 0 0 26 2 7 0 0 10 27 1 7 10 0
                                              29 0 6 0 30 0 7 0 31 2 10 32 0 0
                                              33 2 0 7 7 7 19 2 0 7 7 7 28 4 0
                                              7 7 7 10 10 34)))))
           '|lookupComplete|)) 
