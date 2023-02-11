
(SDEFUN |INVLAPLA;inverseLaplace;F2SU;1|
        ((|expr| (F)) (|ivar| (|Symbol|)) (|ovar| (|Symbol|))
         ($ (|Union| F "failed")))
        (|INVLAPLA;ilt| |expr| |ivar| |ovar| $)) 

(SDEFUN |INVLAPLA;freeOf?|
        ((|p| (|SparseUnivariatePolynomial| F)) (|v| (|Symbol|))
         ($ (|Boolean|)))
        (SPROG
         ((#1=#:G709 NIL) (#2=#:G708 #3=(|Boolean|)) (#4=#:G710 #3#)
          (#5=#:G712 NIL) (|c| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |c| NIL) (LETT #5# (SPADCALL |p| (QREFELT $ 13))) G190
                (COND
                 ((OR (ATOM #5#) (PROGN (LETT |c| (CAR #5#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #4# (SPADCALL |c| |v| (QREFELT $ 15)))
                   (COND (#1# (LETT #2# (COND (#2# #4#) ('T NIL))))
                         ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T 'T)))))) 

(SDEFUN |INVLAPLA;ilt|
        ((|expr| (F)) (|var| (|Symbol|)) (|t| (|Symbol|))
         ($ (|Union| F "failed")))
        (SPROG ((|r| (|Fraction| (|SparseUnivariatePolynomial| F))))
               (SEQ
                (COND
                 ((SPADCALL |expr| (|spadConstant| $ 17) (QREFELT $ 18))
                  (CONS 0 (|spadConstant| $ 17)))
                 (#1='T
                  (SEQ
                   (LETT |r|
                         (SPADCALL |expr| (SPADCALL |var| (QREFELT $ 20))
                                   (QREFELT $ 23)))
                   (COND
                    ((NULL
                      (SPADCALL
                       (SPADCALL (SPADCALL |r| (QREFELT $ 25))
                                 (SPADCALL |r| (QREFELT $ 26)) (QREFELT $ 27))
                       (|spadConstant| $ 28) (QREFELT $ 29)))
                     (EXIT (CONS 1 "failed"))))
                   (COND
                    ((|INVLAPLA;freeOf?| (SPADCALL |r| (QREFELT $ 25)) |var| $)
                     (COND
                      ((NULL
                        (|INVLAPLA;freeOf?| (SPADCALL |r| (QREFELT $ 26)) |var|
                         $))
                       (EXIT (CONS 1 #2="failed")))))
                    (#1# (EXIT (CONS 1 #2#))))
                   (EXIT
                    (CONS 0
                          (|INVLAPLA;ilt1| |r| (SPADCALL |t| (QREFELT $ 30))
                           $))))))))) 

(SDEFUN |INVLAPLA;ilt1|
        ((|r| (|Fraction| (|SparseUnivariatePolynomial| F))) (|t| (F)) ($ (F)))
        (SPROG
         ((|rsplit|
           (|Record|
            (|:| |answer| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |logpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |specpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |polypart| (|SparseUnivariatePolynomial| F)))))
         (SEQ
          (COND
           ((SPADCALL |r| (|spadConstant| $ 32) (QREFELT $ 33))
            (|spadConstant| $ 17))
           ('T
            (SEQ (LETT |rsplit| (SPADCALL |r| (ELT $ 34) (QREFELT $ 37)))
                 (EXIT
                  (SPADCALL
                   (SPADCALL
                    (SPADCALL |t| (|INVLAPLA;ilt1| (QVELT |rsplit| 0) |t| $)
                              (QREFELT $ 38))
                    (QREFELT $ 39))
                   (|INVLAPLA;iltsqfr| (QVELT |rsplit| 1) |t| $)
                   (QREFELT $ 40))))))))) 

(SDEFUN |INVLAPLA;iltsqfr|
        ((|r| (|Fraction| (|SparseUnivariatePolynomial| F))) (|t| (F)) ($ (F)))
        (SPROG
         ((#1=#:G749 NIL) (#2=#:G748 (F)) (#3=#:G750 (F)) (#4=#:G756 NIL)
          (|a| NIL) (#5=#:G757 NIL) (|b| NIL)
          (|nl| (|List| (|SparseUnivariatePolynomial| F))) (#6=#:G746 NIL)
          (|ql| (|List| (|SparseUnivariatePolynomial| F))) (#7=#:G755 NIL)
          (|qq| NIL) (#8=#:G754 NIL) (|q| (|SparseUnivariatePolynomial| F))
          (|p| (|SparseUnivariatePolynomial| F)))
         (SEQ
          (COND
           ((SPADCALL |r| (|spadConstant| $ 32) (QREFELT $ 33))
            (|spadConstant| $ 17))
           (#9='T
            (SEQ (LETT |p| (SPADCALL |r| (QREFELT $ 25)))
                 (LETT |q| (SPADCALL |r| (QREFELT $ 26)))
                 (LETT |ql|
                       (PROGN
                        (LETT #8# NIL)
                        (SEQ (LETT |qq| NIL)
                             (LETT #7#
                                   (SPADCALL (SPADCALL |q| (QREFELT $ 42))
                                             (QREFELT $ 47)))
                             G190
                             (COND
                              ((OR (ATOM #7#)
                                   (PROGN (LETT |qq| (CAR #7#)) NIL))
                               (GO G191)))
                             (SEQ (EXIT (LETT #8# (CONS (QVELT |qq| 1) #8#))))
                             (LETT #7# (CDR #7#)) (GO G190) G191
                             (EXIT (NREVERSE #8#)))))
                 (EXIT
                  (COND
                   ((EQL (LENGTH |ql|) 1) (|INVLAPLA;iltirred| |p| |q| |t| $))
                   (#9#
                    (SEQ
                     (LETT |nl|
                           (PROG2 (LETT #6# (SPADCALL |ql| |p| (QREFELT $ 51)))
                               (QCDR #6#)
                             (|check_union2| (QEQCAR #6# 0)
                                             (|List|
                                              (|SparseUnivariatePolynomial|
                                               (QREFELT $ 7)))
                                             (|Union|
                                              (|List|
                                               (|SparseUnivariatePolynomial|
                                                (QREFELT $ 7)))
                                              "failed")
                                             #6#)))
                     (EXIT
                      (PROGN
                       (LETT #1# NIL)
                       (SEQ (LETT |b| NIL) (LETT #5# |ql|) (LETT |a| NIL)
                            (LETT #4# |nl|) G190
                            (COND
                             ((OR (ATOM #4#) (PROGN (LETT |a| (CAR #4#)) NIL)
                                  (ATOM #5#) (PROGN (LETT |b| (CAR #5#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (PROGN
                               (LETT #3# (|INVLAPLA;iltirred| |a| |b| |t| $))
                               (COND
                                (#1#
                                 (LETT #2# (SPADCALL #2# #3# (QREFELT $ 40))))
                                ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                            (LETT #4# (PROG1 (CDR #4#) (LETT #5# (CDR #5#))))
                            (GO G190) G191 (EXIT NIL))
                       (COND (#1# #2#) (#9# (|spadConstant| $ 17))))))))))))))) 

(SDEFUN |INVLAPLA;iltirred|
        ((|p| (|SparseUnivariatePolynomial| F))
         (|q| (|SparseUnivariatePolynomial| F)) (|t| (F)) ($ (F)))
        (SPROG
         ((#1=#:G767 NIL) (#2=#:G766 (F)) (#3=#:G768 (F)) (#4=#:G773 NIL)
          (|root| NIL) (|q1| (|SparseUnivariatePolynomial| F))
          (|roots| (|List| F)) (|alpha| (F)) (|d| (F)) (|b| (F)) (|e| (F))
          (|c| (F)) (|a| (F)) (|cp| (F)))
         (SEQ
          (COND
           ((EQL (SPADCALL |q| (QREFELT $ 53)) 1)
            (SEQ (LETT |cp| (SPADCALL |p| 0 (QREFELT $ 54)))
                 (LETT |c| (SPADCALL |q| 0 (QREFELT $ 54)))
                 (EXIT
                  (COND
                   ((SPADCALL |c| (|spadConstant| $ 17) (QREFELT $ 18)) |cp|)
                   (#5='T
                    (SPADCALL |cp|
                              (SPADCALL
                               (SPADCALL (SPADCALL |c| |t| (QREFELT $ 38))
                                         (QREFELT $ 39))
                               (QREFELT $ 55))
                              (QREFELT $ 38)))))))
           ((EQL (SPADCALL |q| (QREFELT $ 53)) 2)
            (SEQ (LETT |a| (SPADCALL |p| 1 (QREFELT $ 54)))
                 (LETT |b| (SPADCALL |p| 0 (QREFELT $ 54)))
                 (LETT |c|
                       (SPADCALL
                        (SPADCALL (SPADCALL 1 2 (QREFELT $ 62)) (QREFELT $ 63))
                        (SPADCALL |q| 1 (QREFELT $ 54)) (QREFELT $ 64)))
                 (LETT |d| (SPADCALL |q| 0 (QREFELT $ 54)))
                 (LETT |e|
                       (SPADCALL (SPADCALL |c| |t| (QREFELT $ 38))
                                 (QREFELT $ 55)))
                 (LETT |b|
                       (SPADCALL |b| (SPADCALL |a| |c| (QREFELT $ 38))
                                 (QREFELT $ 40)))
                 (LETT |d|
                       (SPADCALL |d| (SPADCALL |c| 2 (QREFELT $ 66))
                                 (QREFELT $ 67)))
                 (EXIT
                  (COND
                   ((SPADCALL (|spadConstant| $ 17) |d| (QREFELT $ 68))
                    (SEQ (LETT |alpha| (SPADCALL |d| (QREFELT $ 69)))
                         (EXIT
                          (SPADCALL |e|
                                    (SPADCALL
                                     (SPADCALL |a|
                                               (SPADCALL
                                                (SPADCALL |t| |alpha|
                                                          (QREFELT $ 38))
                                                (QREFELT $ 70))
                                               (QREFELT $ 38))
                                     (SPADCALL
                                      (SPADCALL |b|
                                                (SPADCALL
                                                 (SPADCALL |t| |alpha|
                                                           (QREFELT $ 38))
                                                 (QREFELT $ 71))
                                                (QREFELT $ 38))
                                      |alpha| (QREFELT $ 72))
                                     (QREFELT $ 40))
                                    (QREFELT $ 38)))))
                   (#5#
                    (SEQ
                     (LETT |alpha|
                           (SPADCALL (SPADCALL |d| (QREFELT $ 39))
                                     (QREFELT $ 69)))
                     (EXIT
                      (SPADCALL |e|
                                (SPADCALL
                                 (SPADCALL |a|
                                           (SPADCALL
                                            (SPADCALL |t| |alpha|
                                                      (QREFELT $ 38))
                                            (QREFELT $ 73))
                                           (QREFELT $ 38))
                                 (SPADCALL
                                  (SPADCALL |b|
                                            (SPADCALL
                                             (SPADCALL |t| |alpha|
                                                       (QREFELT $ 38))
                                             (QREFELT $ 74))
                                            (QREFELT $ 38))
                                  |alpha| (QREFELT $ 72))
                                 (QREFELT $ 40))
                                (QREFELT $ 38)))))))))
           (#5#
            (SEQ (LETT |roots| (SPADCALL |q| (QREFELT $ 76)))
                 (LETT |q1| (SPADCALL |q| (QREFELT $ 34)))
                 (EXIT
                  (PROGN
                   (LETT #1# NIL)
                   (SEQ (LETT |root| NIL) (LETT #4# |roots|) G190
                        (COND
                         ((OR (ATOM #4#) (PROGN (LETT |root| (CAR #4#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (PROGN
                           (LETT #3#
                                 (SPADCALL
                                  (SPADCALL
                                   (SPADCALL |p| |root| (QREFELT $ 77))
                                   (SPADCALL |q1| |root| (QREFELT $ 77))
                                   (QREFELT $ 72))
                                  (SPADCALL
                                   (SPADCALL |root| |t| (QREFELT $ 38))
                                   (QREFELT $ 55))
                                  (QREFELT $ 38)))
                           (COND
                            (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 40))))
                            ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                        (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                   (COND (#1# #2#) (#5# (|spadConstant| $ 17))))))))))) 

(DECLAIM (NOTINLINE |InverseLaplaceTransform;|)) 

(DEFUN |InverseLaplaceTransform| (&REST #1=#:G774)
  (SPROG NIL
         (PROG (#2=#:G775)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|InverseLaplaceTransform|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |InverseLaplaceTransform;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|InverseLaplaceTransform|)))))))))) 

(DEFUN |InverseLaplaceTransform;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|InverseLaplaceTransform| DV$1 DV$2))
          (LETT $ (GETREFV 78))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|InverseLaplaceTransform|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 31
                    (|TranscendentalHermiteIntegration| |#2|
                                                        (|SparseUnivariatePolynomial|
                                                         |#2|)))
          $))) 

(MAKEPROP '|InverseLaplaceTransform| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Union| 7 '#1="failed") (|Symbol|)
              |INVLAPLA;inverseLaplace;F2SU;1| (|List| 7)
              (|SparseUnivariatePolynomial| 7) (0 . |coefficients|) (|Boolean|)
              (5 . |freeOf?|) (11 . |Zero|) (15 . |Zero|) (19 . =) (|Kernel| 7)
              (25 . |kernel|) (|Fraction| 75) (|Kernel| $) (30 . |univariate|)
              (|Fraction| 12) (36 . |numer|) (41 . |denom|) (46 . |quo|)
              (52 . |Zero|) (56 . =) (62 . |coerce|) '|hintpac| (67 . |Zero|)
              (71 . =) (77 . |differentiate|)
              (|Record| (|:| |answer| 24) (|:| |logpart| 24)
                        (|:| |specpart| 24) (|:| |polypart| 12))
              (|Mapping| 12 12) (82 . |HermiteIntegrate|) (88 . *) (94 . -)
              (99 . +) (|Factored| $) (105 . |squareFree|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 43) (|:| |factor| 12) (|:| |exponent| 52))
              (|List| 44) (|Factored| 12) (110 . |factorList|) (115 . |One|)
              (|Union| 50 '"failed") (|List| $) (119 . |multiEuclidean|)
              (|NonNegativeInteger|) (125 . |degree|) (130 . |coefficient|)
              (136 . |exp|) (141 . |One|) (|SparseMultivariatePolynomial| 6 19)
              (145 . |One|) (149 . |One|) (|Integer|) (|Fraction| 60) (153 . /)
              (159 . -) (164 . *) (|PositiveInteger|) (170 . ^) (176 . -)
              (182 . |smaller?|) (188 . |sqrt|) (193 . |cos|) (198 . |sin|)
              (203 . /) (209 . |cosh|) (214 . |sinh|)
              (|SparseUnivariatePolynomial| $) (219 . |zerosOf|) (224 . |elt|))
           '#(|inverseLaplace| 230) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|inverseLaplace|
                                 ((|Union| |#2| #1#) |#2| (|Symbol|)
                                  (|Symbol|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 77
                                            '(1 12 11 0 13 2 7 14 0 9 15 0 6 0
                                              16 0 7 0 17 2 7 14 0 0 18 1 19 0
                                              9 20 2 7 21 0 22 23 1 24 12 0 25
                                              1 24 12 0 26 2 12 0 0 0 27 0 12 0
                                              28 2 12 14 0 0 29 1 7 0 9 30 0 24
                                              0 32 2 24 14 0 0 33 1 12 0 0 34 2
                                              31 35 24 36 37 2 7 0 0 0 38 1 7 0
                                              0 39 2 7 0 0 0 40 1 12 41 0 42 1
                                              46 45 0 47 0 6 0 48 2 12 49 50 0
                                              51 1 12 52 0 53 2 12 7 0 52 54 1
                                              7 0 0 55 0 7 0 56 0 57 0 58 0 12
                                              0 59 2 61 0 60 60 62 1 61 0 0 63
                                              2 7 0 61 0 64 2 7 0 0 65 66 2 7 0
                                              0 0 67 2 7 14 0 0 68 1 7 0 0 69 1
                                              7 0 0 70 1 7 0 0 71 2 7 0 0 0 72
                                              1 7 0 0 73 1 7 0 0 74 1 7 50 75
                                              76 2 12 7 0 7 77 3 0 8 7 9 9
                                              10)))))
           '|lookupComplete|)) 
