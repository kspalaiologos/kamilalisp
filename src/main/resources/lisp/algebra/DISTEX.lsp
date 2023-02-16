
(SDEFUN |DISTEX;gaussianDistribution;RD;1| ((|a| (R)) ($ (|Distribution| R)))
        (SPROG ((|cumu| (|Stream| R)))
               (SEQ
                (LETT |cumu|
                      (SPADCALL
                       (SPADCALL (LIST (|spadConstant| $ 7) |a|)
                                 (QREFELT $ 10))
                       (SPADCALL (LIST (|spadConstant| $ 7)) (QREFELT $ 13))
                       (QREFELT $ 14)))
                (EXIT
                 (SPADCALL (SPADCALL |cumu| (QREFELT $ 16)) (QREFELT $ 17)))))) 

(SDEFUN |DISTEX;poissonDistribution;RD;2| ((|a| (R)) ($ (|Distribution| R)))
        (SPROG ((|cumu| (|Stream| R)))
               (SEQ (LETT |cumu| (SPADCALL (LIST |a|) (QREFELT $ 13)))
                    (EXIT
                     (SPADCALL (SPADCALL |cumu| (QREFELT $ 16))
                               (QREFELT $ 17)))))) 

(SDEFUN |DISTEX;wignerDistribution;RD;3| ((|a| (R)) ($ (|Distribution| R)))
        (SPROG ((|cumu| (|Stream| R)))
               (SEQ
                (LETT |cumu|
                      (SPADCALL
                       (SPADCALL (LIST (|spadConstant| $ 7) |a|)
                                 (QREFELT $ 10))
                       (SPADCALL (LIST (|spadConstant| $ 7)) (QREFELT $ 13))
                       (QREFELT $ 14)))
                (EXIT
                 (SPADCALL (SPADCALL |cumu| (QREFELT $ 16)) (QREFELT $ 20)))))) 

(SDEFUN |DISTEX;freePoissonDistribution;RD;4|
        ((|a| (R)) ($ (|Distribution| R)))
        (SPROG ((|cumu| (|Stream| R)))
               (SEQ (LETT |cumu| (SPADCALL (LIST |a|) (QREFELT $ 13)))
                    (EXIT
                     (SPADCALL (SPADCALL |cumu| (QREFELT $ 16))
                               (QREFELT $ 20)))))) 

(SDEFUN |DISTEX;bernoulliDistribution01;RD;5|
        ((|a| (R)) ($ (|Distribution| R)))
        (SPROG ((|mom| (|Stream| R)))
               (SEQ (LETT |mom| (SPADCALL (LIST |a|) (QREFELT $ 13)))
                    (EXIT
                     (SPADCALL (SPADCALL |mom| (QREFELT $ 16))
                               (QREFELT $ 23)))))) 

(SDEFUN |DISTEX;arcsineDistribution;RD;6| ((|a| (R)) ($ (|Distribution| R)))
        (SPROG
         ((|mgf| (|Stream| R)) (#1=#:G713 NIL)
          (|half| (|Fraction| (|Integer|))))
         (SEQ
          (LETT |mgf|
                (SPADCALL
                 (SPADCALL
                  (SPADCALL (SPADCALL 2 (QREFELT $ 26)) |a| (QREFELT $ 27))
                  (QREFELT $ 28))
                 (SPADCALL (LIST (|spadConstant| $ 7)) (QREFELT $ 13))
                 (QREFELT $ 29)))
          (LETT |mgf| (SPADCALL (|spadConstant| $ 7) |mgf| (QREFELT $ 29)))
          (LETT |half| (SPADCALL 1 2 (QREFELT $ 32)))
          (LETT |mgf|
                (SPADCALL |half|
                          (SPADCALL (|spadConstant| $ 30) |mgf| (QREFELT $ 29))
                          (QREFELT $ 34)))
          (LETT |mgf|
                (PROG2 (LETT #1# (SPADCALL |mgf| (QREFELT $ 36)))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0) (|Stream| (QREFELT $ 6))
                                  (|Union| (|Stream| (QREFELT $ 6)) "failed")
                                  #1#)))
          (EXIT
           (SPADCALL (SPADCALL (SPADCALL |mgf| (QREFELT $ 37)) (QREFELT $ 16))
                     (QREFELT $ 23)))))) 

(DECLAIM (NOTINLINE |DistributionPackage;|)) 

(DEFUN |DistributionPackage| (#1=#:G717)
  (SPROG NIL
         (PROG (#2=#:G718)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|DistributionPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|DistributionPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|DistributionPackage|)))))))))) 

(DEFUN |DistributionPackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|DistributionPackage| DV$1))
          (LETT $ (GETREFV 39))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|Algebra|
                                                               (|Fraction|
                                                                (|Integer|))))))))
          (|haddProp| |$ConstructorCache| '|DistributionPackage| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 38
                       (CONS
                        (|dispatchFunction| |DISTEX;arcsineDistribution;RD;6|)
                        $)))))
          $))) 

(MAKEPROP '|DistributionPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |Zero|) (|List| 6)
              (|Stream| 6) (4 . |construct|) (|Distribution| 6) (9 . |Zero|)
              (13 . |repeating|) (18 . |concat|) (|Sequence| 6)
              (24 . |sequence|) (29 . |distributionByClassicalCumulants|)
              |DISTEX;gaussianDistribution;RD;1|
              |DISTEX;poissonDistribution;RD;2|
              (34 . |distributionByFreeCumulants|)
              |DISTEX;wignerDistribution;RD;3|
              |DISTEX;freePoissonDistribution;RD;4|
              (39 . |distributionByMoments|)
              |DISTEX;bernoulliDistribution01;RD;5| (|Integer|) (44 . |coerce|)
              (49 . *) (55 . -) (60 . |cons|) (66 . |One|) (|Fraction| 25)
              (70 . /) (|StreamTaylorSeriesOperations| 6) (76 . |powern|)
              (|Union| 9 '"failed") (82 . |recip|) (87 . |rest|)
              (92 . |arcsineDistribution|))
           '#(|wignerDistribution| 97 |poissonDistribution| 102
              |gaussianDistribution| 107 |freePoissonDistribution| 112
              |bernoulliDistribution01| 117 |arcsineDistribution| 122)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|gaussianDistribution|
                                 ((|Distribution| |#1|) |#1|))
                                T)
                              '((|poissonDistribution|
                                 ((|Distribution| |#1|) |#1|))
                                T)
                              '((|wignerDistribution|
                                 ((|Distribution| |#1|) |#1|))
                                T)
                              '((|freePoissonDistribution|
                                 ((|Distribution| |#1|) |#1|))
                                T)
                              '((|bernoulliDistribution01|
                                 ((|Distribution| |#1|) |#1|))
                                T)
                              '((|arcsineDistribution|
                                 ((|Distribution| |#1|) |#1|))
                                (|has| 6 (|Algebra| 31))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 38
                                            '(0 6 0 7 1 9 0 8 10 0 11 0 12 1 9
                                              0 8 13 2 9 0 0 0 14 1 15 0 9 16 1
                                              11 0 15 17 1 11 0 15 20 1 11 0 15
                                              23 1 6 0 25 26 2 6 0 0 0 27 1 6 0
                                              0 28 2 9 0 6 0 29 0 6 0 30 2 31 0
                                              25 25 32 2 33 9 31 9 34 1 33 35 9
                                              36 1 9 0 0 37 1 0 11 6 38 1 0 11
                                              6 21 1 0 11 6 19 1 0 11 6 18 1 0
                                              11 6 22 1 0 11 6 24 1 1 11 6
                                              38)))))
           '|lookupComplete|)) 
