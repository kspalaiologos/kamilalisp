
(SDEFUN |ISUMP;pmul|
        ((|c| (P))
         (|p| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
         ($
          (|Record| (|:| |num| (|SparseUnivariatePolynomial| P))
                    (|:| |den| (|Integer|)))))
        (SPROG
         ((|pn| #1=(|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
          (|rec| (|Record| (|:| |num| #1#) (|:| |den| (|Integer|)))))
         (SEQ (LETT |pn| (QCAR (LETT |rec| (SPADCALL |p| (QREFELT $ 13)))))
              (EXIT
               (CONS
                (SPADCALL (CONS #'|ISUMP;pmul!0| (VECTOR |c| $)) |pn|
                          (QREFELT $ 21))
                (QCDR |rec|)))))) 

(SDEFUN |ISUMP;pmul!0| ((|x| NIL) ($$ NIL))
        (PROG ($ |c|)
          (LETT $ (QREFELT $$ 1))
          (LETT |c| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |x| (QREFELT $ 16)) |c| (QREFELT $ 17)))))) 

(SDEFUN |ISUMP;sum;PVSR;2|
        ((|p| (P)) (|v| (V)) (|s| (|Segment| P))
         ($ (|Record| (|:| |num| P) (|:| |den| (|Integer|)))))
        (SPROG ((|indef| (|Record| (|:| |num| P) (|:| |den| (|Integer|)))))
               (SEQ (LETT |indef| (SPADCALL |p| |v| (QREFELT $ 23)))
                    (EXIT
                     (CONS
                      (SPADCALL
                       (SPADCALL (QCAR |indef|) |v|
                                 (SPADCALL (|spadConstant| $ 25)
                                           (SPADCALL |s| (QREFELT $ 27))
                                           (QREFELT $ 28))
                                 (QREFELT $ 29))
                       (SPADCALL (QCAR |indef|) |v|
                                 (SPADCALL |s| (QREFELT $ 30)) (QREFELT $ 29))
                       (QREFELT $ 31))
                      (QCDR |indef|)))))) 

(SDEFUN |ISUMP;sum;PVR;3|
        ((|p| (P)) (|v| (V))
         ($ (|Record| (|:| |num| P) (|:| |den| (|Integer|)))))
        (SPROG
         ((|vp| #1=(|SparseUnivariatePolynomial| P)) (#2=#:G717 NIL)
          (#3=#:G716 #1#) (#4=#:G718 #1#) (#5=#:G720 NIL) (#6=#:G724 NIL)
          (|di| NIL) (#7=#:G725 NIL) (|pi| NIL) (|d| (|Integer|))
          (|ld| (|List| (|Integer|)))
          (|lp| (|List| (|SparseUnivariatePolynomial| P)))
          (|rec|
           (|Record| (|:| |num| (|SparseUnivariatePolynomial| P))
                     (|:| |den| (|Integer|))))
          (|up| (|SparseUnivariatePolynomial| P)) (|uc| (P))
          (|ud| (|NonNegativeInteger|)))
         (SEQ (LETT |up| (SPADCALL |p| |v| (QREFELT $ 34))) (LETT |lp| NIL)
              (LETT |ld| NIL)
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL |up| (|spadConstant| $ 37) (QREFELT $ 39)))
                     (GO G191)))
                   (SEQ (LETT |ud| (SPADCALL |up| (QREFELT $ 41)))
                        (LETT |uc| (SPADCALL |up| (QREFELT $ 42)))
                        (LETT |up| (SPADCALL |up| (QREFELT $ 43)))
                        (LETT |rec|
                              (|ISUMP;pmul| |uc|
                               (SPADCALL (SPADCALL 1 (+ |ud| 1) (QREFELT $ 44))
                                         (SPADCALL (+ |ud| 1) (QREFELT $ 46))
                                         (QREFELT $ 47))
                               $))
                        (LETT |lp| (CONS (QCAR |rec|) |lp|))
                        (EXIT (LETT |ld| (CONS (QCDR |rec|) |ld|))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |d| (SPADCALL |ld| (QREFELT $ 49)))
              (LETT |vp|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |pi| NIL) (LETT #7# |lp|) (LETT |di| NIL)
                          (LETT #6# |ld|) G190
                          (COND
                           ((OR (ATOM #6#) (PROGN (LETT |di| (CAR #6#)) NIL)
                                (ATOM #7#) (PROGN (LETT |pi| (CAR #7#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (PROGN
                             (LETT #4#
                                   (SPADCALL
                                    (PROG2
                                        (LETT #5#
                                              (SPADCALL |d| |di|
                                                        (QREFELT $ 51)))
                                        (QCDR #5#)
                                      (|check_union2| (QEQCAR #5# 0)
                                                      (|Integer|)
                                                      (|Union| (|Integer|)
                                                               "failed")
                                                      #5#))
                                    |pi| (QREFELT $ 52)))
                             (COND
                              (#2#
                               (LETT #3# (SPADCALL #3# #4# (QREFELT $ 53))))
                              ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                          (LETT #6# (PROG1 (CDR #6#) (LETT #7# (CDR #7#))))
                          (GO G190) G191 (EXIT NIL))
                     (COND (#2# #3#) ('T (|spadConstant| $ 37)))))
              (EXIT (CONS (SPADCALL |vp| |v| (QREFELT $ 54)) |d|))))) 

(DECLAIM (NOTINLINE |InnerPolySum;|)) 

(DEFUN |InnerPolySum| (&REST #1=#:G726)
  (SPROG NIL
         (PROG (#2=#:G727)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|InnerPolySum|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |InnerPolySum;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|InnerPolySum|)))))))))) 

(DEFUN |InnerPolySum;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|InnerPolySum| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 55))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|InnerPolySum| (LIST DV$1 DV$2 DV$3 DV$4)
                (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|InnerPolySum| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|)
              (|Record| (|:| |num| 11) (|:| |den| 14))
              (|SparseUnivariatePolynomial| 15)
              (|UnivariatePolynomialCommonDenominator| 14 15 11)
              (0 . |splitDenominator|) (|Integer|) (|Fraction| 14)
              (5 . |numer|) (10 . *) (|SparseUnivariatePolynomial| 9)
              (|Mapping| 9 15) (|SparseUnivariatePolynomialFunctions2| 15 9)
              (16 . |map|) (|Record| (|:| |num| 9) (|:| |den| 14))
              |ISUMP;sum;PVR;3| (22 . |One|) (26 . |One|) (|Segment| 9)
              (30 . |high|) (35 . +) (41 . |eval|) (48 . |low|) (53 . -)
              |ISUMP;sum;PVSR;2| (|SparseUnivariatePolynomial| $)
              (59 . |univariate|) (65 . |Zero|) (69 . |Zero|) (73 . |Zero|)
              (|Boolean|) (77 . ~=) (|NonNegativeInteger|) (83 . |degree|)
              (88 . |leadingCoefficient|) (93 . |reductum|) (98 . /)
              (|PolynomialNumberTheoryFunctions|) (104 . |bernoulli|) (109 . *)
              (|List| $) (115 . |lcm|) (|Union| $ '"failed") (120 . |exquo|)
              (126 . *) (132 . +) (138 . |multivariate|))
           '#(|sum| 144) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|sum|
                                 ((|Record| (|:| |num| |#4|)
                                            (|:| |den| (|Integer|)))
                                  |#4| |#2| (|Segment| |#4|)))
                                T)
                              '((|sum|
                                 ((|Record| (|:| |num| |#4|)
                                            (|:| |den| (|Integer|)))
                                  |#4| |#2|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 54
                                            '(1 12 10 11 13 1 15 14 0 16 2 9 0
                                              14 0 17 2 20 18 19 11 21 0 8 0 24
                                              0 9 0 25 1 26 9 0 27 2 9 0 0 0 28
                                              3 9 0 0 7 0 29 1 26 9 0 30 2 9 0
                                              0 0 31 2 9 33 0 7 34 0 6 0 35 0 8
                                              0 36 0 18 0 37 2 18 38 0 0 39 1
                                              18 40 0 41 1 18 9 0 42 1 18 0 0
                                              43 2 15 0 14 14 44 1 45 11 14 46
                                              2 11 0 15 0 47 1 14 0 48 49 2 14
                                              50 0 0 51 2 18 0 14 0 52 2 18 0 0
                                              0 53 2 9 0 33 7 54 2 0 22 9 7 23
                                              3 0 22 9 7 26 32)))))
           '|lookupComplete|)) 
