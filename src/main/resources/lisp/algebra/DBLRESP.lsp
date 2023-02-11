
(SDEFUN |DBLRESP;remove0| ((|p| (UP)) ($ (UP)))
        (SPROG ((#1=#:G694 NIL))
               (SPADCALL
                (PROG2
                    (LETT #1#
                          (SPADCALL |p|
                                    (SPADCALL (|spadConstant| $ 10)
                                              (SPADCALL |p| (QREFELT $ 13))
                                              (QREFELT $ 14))
                                    (QREFELT $ 16)))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                  (|Union| (QREFELT $ 7) "failed") #1#))
                (QREFELT $ 17)))) 

(SDEFUN |DBLRESP;UP22| ((|p| (UP)) ($ (|SparseUnivariatePolynomial| UP)))
        (SPADCALL (ELT $ 18) |p| (QREFELT $ 22))) 

(SDEFUN |DBLRESP;UP23|
        ((|p| (UPUP))
         ($ (|SparseUnivariatePolynomial| (|SparseUnivariatePolynomial| UP))))
        (SPADCALL (CONS #'|DBLRESP;UP23!0| $) |p| (QREFELT $ 28))) 

(SDEFUN |DBLRESP;UP23!0| ((|x1| NIL) ($ NIL))
        (|DBLRESP;UP22| (SPADCALL |x1| (QREFELT $ 24)) $)) 

(SDEFUN |DBLRESP;doubleResultant;RMUP;4|
        ((|h| (R)) (|derivation| (|Mapping| UP UP)) ($ (UP)))
        (SPROG
         ((|r| (|SparseUnivariatePolynomial| UP)) (|d| (UP)) (#1=#:G707 NIL)
          (|g| (UP)) (|cd| (|Record| (|:| |num| UPUP) (|:| |den| UP))))
         (SEQ
          (LETT |cd| (SPADCALL (SPADCALL |h| (QREFELT $ 29)) (QREFELT $ 32)))
          (LETT |d|
                (PROG2
                    (LETT #1#
                          (SPADCALL (QCDR |cd|)
                                    (LETT |g|
                                          (SPADCALL (QCDR |cd|)
                                                    (SPADCALL (QCDR |cd|)
                                                              |derivation|)
                                                    (QREFELT $ 33)))
                                    (QREFELT $ 16)))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0) (QREFELT $ 7)
                                  (|Union| (QREFELT $ 7) "failed") #1#)))
          (LETT |r|
                (SPADCALL
                 (SPADCALL
                  (SPADCALL
                   (SPADCALL
                    (SPADCALL (|DBLRESP;UP23| (QCAR |cd|) $)
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 10) 1
                                           (QREFELT $ 14))
                                 (QREFELT $ 34))
                                (|DBLRESP;UP22|
                                 (SPADCALL |g| (SPADCALL |d| |derivation|)
                                           (QREFELT $ 35))
                                 $)
                                (QREFELT $ 36))
                               (QREFELT $ 37))
                              (QREFELT $ 38))
                    (|DBLRESP;UP23| (SPADCALL (QREFELT $ 39)) $)
                    (QREFELT $ 40))
                   (QREFELT $ 42))
                  (QREFELT $ 43))
                 (QREFELT $ 42)))
          (EXIT
           (|DBLRESP;remove0|
            (SPADCALL |r| (|DBLRESP;UP22| |d| $) (QREFELT $ 44)) $))))) 

(DECLAIM (NOTINLINE |DoubleResultantPackage;|)) 

(DEFUN |DoubleResultantPackage| (&REST #1=#:G713)
  (SPROG NIL
         (PROG (#2=#:G714)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|DoubleResultantPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |DoubleResultantPackage;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|DoubleResultantPackage|)))))))))) 

(DEFUN |DoubleResultantPackage;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|DoubleResultantPackage| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 47))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|DoubleResultantPackage|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|DoubleResultantPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (0 . |One|) (4 . |One|)
              (|NonNegativeInteger|) (8 . |minimumDegree|) (13 . |monomial|)
              (|Union| $ '"failed") (19 . |exquo|) (25 . |primitivePart|)
              (30 . |coerce|) (|SparseUnivariatePolynomial| 7) (|Mapping| 7 6)
              (|UnivariatePolynomialCategoryFunctions2| 6 7 7 19) (35 . |map|)
              (|Fraction| 7) (41 . |retract|) (|SparseUnivariatePolynomial| 19)
              (|Mapping| 19 23)
              (|UnivariatePolynomialCategoryFunctions2| 23 8 19 25)
              (46 . |map|) (52 . |lift|) (|Record| (|:| |num| 8) (|:| |den| 7))
              (|UnivariatePolynomialCommonDenominator| 7 23 8)
              (57 . |splitDenominator|) (62 . |gcd|) (68 . |coerce|) (73 . *)
              (79 . *) (85 . |coerce|) (90 . -) (96 . |definingPolynomial|)
              (100 . |resultant|)
              (|CommuteUnivariatePolynomialCategory| 6 7 19) (106 . |swap|)
              (111 . |primitivePart|) (116 . |resultant|) (|Mapping| 7 7)
              |DBLRESP;doubleResultant;RMUP;4|)
           '#(|doubleResultant| 122) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|doubleResultant|
                                 (|#2| |#4| (|Mapping| |#2| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 46
                                            '(0 6 0 10 0 7 0 11 1 7 12 0 13 2 7
                                              0 6 12 14 2 7 15 0 0 16 1 7 0 0
                                              17 1 7 0 6 18 2 21 19 20 7 22 1
                                              23 7 0 24 2 27 25 26 8 28 1 9 8 0
                                              29 1 31 30 8 32 2 7 0 0 0 33 1 19
                                              0 7 34 2 7 0 0 0 35 2 19 0 0 0 36
                                              1 25 0 19 37 2 25 0 0 0 38 0 9 8
                                              39 2 25 19 0 0 40 1 41 19 19 42 1
                                              19 0 0 43 2 19 7 0 0 44 2 0 7 9
                                              45 46)))))
           '|lookupComplete|)) 
