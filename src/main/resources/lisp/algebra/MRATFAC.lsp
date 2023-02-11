
(SDEFUN |MRATFAC;numer1|
        ((|c| (|Fraction| R)) ($ (|SparseMultivariatePolynomial| R OV)))
        (SPADCALL (SPADCALL |c| (QREFELT $ 11)) (QREFELT $ 13))) 

(SDEFUN |MRATFAC;numer2|
        ((|pol| (P)) ($ (|SparseMultivariatePolynomial| R OV)))
        (SPADCALL (ELT $ 14) (CONS (|function| |MRATFAC;numer1|) $) |pol|
                  (QREFELT $ 18))) 

(SDEFUN |MRATFAC;coerce1| ((|d| (R)) ($ (P)))
        (SPADCALL (SPADCALL |d| (QREFELT $ 19)) (QREFELT $ 20))) 

(SDEFUN |MRATFAC;coerce2|
        ((|pp| (|SparseMultivariatePolynomial| R OV)) ($ (P)))
        (SPADCALL (ELT $ 21) (CONS (|function| |MRATFAC;coerce1|) $) |pp|
                  (QREFELT $ 25))) 

(SDEFUN |MRATFAC;factor;PF;5| ((|p| (P)) ($ (|Factored| P)))
        (SPROG
         ((#1=#:G732 NIL) (#2=#:G731 #3=(|Factored| P)) (#4=#:G733 #3#)
          (#5=#:G740 NIL) (|u| NIL)
          (|ffact| (|Factored| (|SparseMultivariatePolynomial| R OV)))
          (|ipol| (|SparseMultivariatePolynomial| R OV)) (|pol| (P))
          (|pden| (R)) (#6=#:G739 NIL) (|c| NIL) (#7=#:G738 NIL))
         (SEQ
          (LETT |pden|
                (SPADCALL
                 (PROGN
                  (LETT #7# NIL)
                  (SEQ (LETT |c| NIL) (LETT #6# (SPADCALL |p| (QREFELT $ 27)))
                       G190
                       (COND
                        ((OR (ATOM #6#) (PROGN (LETT |c| (CAR #6#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #7# (CONS (SPADCALL |c| (QREFELT $ 28)) #7#))))
                       (LETT #6# (CDR #6#)) (GO G190) G191
                       (EXIT (NREVERSE #7#))))
                 (QREFELT $ 30)))
          (LETT |pol|
                (SPADCALL (SPADCALL |pden| (QREFELT $ 19)) |p| (QREFELT $ 31)))
          (LETT |ipol|
                (SPADCALL (ELT $ 14) (CONS (|function| |MRATFAC;numer1|) $)
                          |pol| (QREFELT $ 18)))
          (LETT |ffact| (SPADCALL |ipol| (QREFELT $ 34)))
          (EXIT
           (SPADCALL
            (SPADCALL (SPADCALL (|spadConstant| $ 35) |pden| (QREFELT $ 38))
                      (SPADCALL (ELT $ 21)
                                (CONS (|function| |MRATFAC;coerce1|) $)
                                (SPADCALL |ffact| (QREFELT $ 39))
                                (QREFELT $ 25))
                      (QREFELT $ 31))
            (PROGN
             (LETT #1# NIL)
             (SEQ (LETT |u| NIL) (LETT #5# (SPADCALL |ffact| (QREFELT $ 43)))
                  G190
                  (COND
                   ((OR (ATOM #5#) (PROGN (LETT |u| (CAR #5#)) NIL))
                    (GO G191)))
                  (SEQ
                   (EXIT
                    (PROGN
                     (LETT #4#
                           (SPADCALL
                            (SPADCALL (ELT $ 21)
                                      (CONS (|function| |MRATFAC;coerce1|) $)
                                      (QVELT |u| 1) (QREFELT $ 25))
                            (QVELT |u| 2) (QREFELT $ 46)))
                     (COND (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 47))))
                           ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                  (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
             (COND (#1# #2#) ('T (|spadConstant| $ 48))))
            (QREFELT $ 49)))))) 

(DECLAIM (NOTINLINE |MRationalFactorize;|)) 

(DEFUN |MRationalFactorize| (&REST #1=#:G741)
  (SPROG NIL
         (PROG (#2=#:G742)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|MRationalFactorize|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |MRationalFactorize;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|MRationalFactorize|)))))))))) 

(DEFUN |MRationalFactorize;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|MRationalFactorize| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 51))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|MRationalFactorize|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|MRationalFactorize| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|Fraction| 8) (0 . |numer|)
              (|SparseMultivariatePolynomial| 8 7) (5 . |coerce|)
              (10 . |coerce|) (|Mapping| 12 7) (|Mapping| 12 10)
              (|PolynomialCategoryLifting| 6 7 10 9 12) (15 . |map|)
              (22 . |coerce|) (27 . |coerce|) (32 . |coerce|) (|Mapping| 9 7)
              (|Mapping| 9 8)
              (|PolynomialCategoryLifting| (|IndexedExponents| 7) 7 8 12 9)
              (37 . |map|) (|List| 10) (44 . |coefficients|) (49 . |denom|)
              (|List| $) (54 . |lcm|) (59 . *) (|Factored| 12)
              (|MultivariateFactorize| 7 (|IndexedExponents| 7) 8 12)
              (65 . |factor|) (70 . |One|) (74 . |One|) (78 . |One|) (82 . /)
              (88 . |unit|) (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 40) (|:| |factor| 12) (|:| |exponent| 44))
              (|List| 41) (93 . |factorList|) (|NonNegativeInteger|)
              (|Factored| 9) (98 . |primeFactor|) (104 . *) (110 . |One|)
              (114 . *) |MRATFAC;factor;PF;5|)
           '#(|factor| 120) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|factor| ((|Factored| |#4|) |#4|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 50
                                            '(1 10 8 0 11 1 12 0 8 13 1 12 0 7
                                              14 3 17 12 15 16 9 18 1 10 0 8 19
                                              1 9 0 10 20 1 9 0 7 21 3 24 9 22
                                              23 12 25 1 9 26 0 27 1 10 8 0 28
                                              1 8 0 29 30 2 9 0 10 0 31 1 33 32
                                              12 34 0 8 0 35 0 9 0 36 0 12 0 37
                                              2 10 0 8 8 38 1 32 12 0 39 1 32
                                              42 0 43 2 45 0 9 44 46 2 45 0 0 0
                                              47 0 45 0 48 2 45 0 9 0 49 1 0 45
                                              9 50)))))
           '|lookupComplete|)) 
