
(SDEFUN |DSTCFPG;JContinuedFraction;DUpCf;1|
        ((|x| (|Distribution| R)) (|zz| (|UnivariatePolynomial| |z| R))
         ($ (|ContinuedFraction| (|UnivariatePolynomial| |z| R))))
        (SPROG
         ((|bn1| #1=(|Stream| (|UnivariatePolynomial| |z| R))) (|an1| #1#)
          (|jac| (|Record| (|:| |an| (|Stream| R)) (|:| |bn| (|Stream| R)))))
         (SEQ (LETT |jac| (SPADCALL |x| (QREFELT $ 10)))
              (LETT |an1|
                    (SPADCALL
                     (CONS #'|DSTCFPG;JContinuedFraction;DUpCf;1!0|
                           (VECTOR $ |zz|))
                     (QCAR |jac|) (QREFELT $ 22)))
              (LETT |bn1|
                    (SPADCALL (CONS #'|DSTCFPG;JContinuedFraction;DUpCf;1!1| $)
                              (QCDR |jac|) (QREFELT $ 22)))
              (EXIT
               (SPADCALL (|spadConstant| $ 24)
                         (SPADCALL (|spadConstant| $ 26) |bn1| (QREFELT $ 27))
                         (SPADCALL |zz| |an1| (QREFELT $ 27))
                         (QREFELT $ 29)))))) 

(SDEFUN |DSTCFPG;JContinuedFraction;DUpCf;1!1| ((|b| NIL) ($ NIL))
        (SPADCALL (SPADCALL |b| (QREFELT $ 23)) (|spadConstant| $ 14)
                  (QREFELT $ 16))) 

(SDEFUN |DSTCFPG;JContinuedFraction;DUpCf;1!0| ((|a| NIL) ($$ NIL))
        (PROG (|zz| $)
          (LETT |zz| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |zz| (SPADCALL |a| (|spadConstant| $ 14) (QREFELT $ 16))
                      (QREFELT $ 17)))))) 

(SDEFUN |DSTCFPG;JContinuedFraction;DUpCf;2|
        ((|x| (|Distribution| R))
         (|zz| (|UnivariatePolynomial| |z| (|Fraction| R)))
         ($ (|ContinuedFraction| (|UnivariatePolynomial| |z| (|Fraction| R)))))
        (SPROG
         ((|bn1| #1=(|Stream| (|UnivariatePolynomial| |z| (|Fraction| R))))
          (|an1| #1#)
          (|jac|
           (|Record| (|:| |an| (|Stream| (|Fraction| R)))
                     (|:| |bn| (|Stream| (|Fraction| R))))))
         (SEQ (LETT |jac| (SPADCALL |x| (QREFELT $ 32)))
              (LETT |an1|
                    (SPADCALL
                     (CONS #'|DSTCFPG;JContinuedFraction;DUpCf;2!0|
                           (VECTOR $ |zz|))
                     (QCAR |jac|) (QREFELT $ 41)))
              (LETT |bn1|
                    (SPADCALL (CONS #'|DSTCFPG;JContinuedFraction;DUpCf;2!1| $)
                              (QCDR |jac|) (QREFELT $ 41)))
              (EXIT
               (SPADCALL (|spadConstant| $ 43)
                         (SPADCALL (|spadConstant| $ 44) |bn1| (QREFELT $ 45))
                         (SPADCALL |zz| |an1| (QREFELT $ 45))
                         (QREFELT $ 47)))))) 

(SDEFUN |DSTCFPG;JContinuedFraction;DUpCf;2!1| ((|b| NIL) ($ NIL))
        (SPADCALL (SPADCALL |b| (QREFELT $ 42)) (|spadConstant| $ 14)
                  (QREFELT $ 35))) 

(SDEFUN |DSTCFPG;JContinuedFraction;DUpCf;2!0| ((|a| NIL) ($$ NIL))
        (PROG (|zz| $)
          (LETT |zz| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |zz| (SPADCALL |a| (|spadConstant| $ 14) (QREFELT $ 35))
                      (QREFELT $ 36)))))) 

(DECLAIM (NOTINLINE |DistributionContinuedFractionPackage;|)) 

(DEFUN |DistributionContinuedFractionPackage| (&REST #1=#:G714)
  (SPROG NIL
         (PROG (#2=#:G715)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(T NIL))
                                               (HGET |$ConstructorCache|
                                                     '|DistributionContinuedFractionPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |DistributionContinuedFractionPackage;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|DistributionContinuedFractionPackage|)))))))))) 

(DEFUN |DistributionContinuedFractionPackage;| (|#1| |#2|)
  (SPROG
   ((|pv$| NIL) (#1=#:G713 NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 |#2|)
    (LETT |dv$| (LIST '|DistributionContinuedFractionPackage| DV$1 DV$2))
    (LETT $ (GETREFV 49))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (LETT #1#
                                              (|HasCategory| |#1| '(|Field|)))
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|IntegralDomain|))
                                         (|not| #1#))))))
    (|haddProp| |$ConstructorCache| '|DistributionContinuedFractionPackage|
                (LIST DV$1 DV$2) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|testBitVector| |pv$| 1)
      (QSETREFV $ 30
                (CONS (|dispatchFunction| |DSTCFPG;JContinuedFraction;DUpCf;1|)
                      $)))
     ((|HasCategory| |#1| '(|IntegralDomain|))
      (QSETREFV $ 48
                (CONS (|dispatchFunction| |DSTCFPG;JContinuedFraction;DUpCf;2|)
                      $))))
    $))) 

(MAKEPROP '|DistributionContinuedFractionPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Record| (|:| |an| 20) (|:| |bn| 20)) (|Distribution| 6)
              (0 . |jacobiParameters|) (5 . |Zero|) (9 . |Zero|)
              (|NonNegativeInteger|) (13 . |Zero|)
              (|UnivariatePolynomial| (NRTEVAL (QREFELT $ 7)) 6)
              (17 . |monomial|) (23 . -) (|Stream| 15) (|Mapping| 15 6)
              (|Stream| 6) (|StreamFunctions2| 6 15) (29 . |map|) (35 . -)
              (40 . |Zero|) (44 . |One|) (48 . |One|) (52 . |cons|)
              (|ContinuedFraction| 15) (58 . |continuedFraction|)
              (65 . |JContinuedFraction|)
              (|Record| (|:| |an| 39) (|:| |bn| 39)) (71 . |jacobiParameters|)
              (|Fraction| 6)
              (|UnivariatePolynomial| (NRTEVAL (QREFELT $ 7)) 33)
              (76 . |monomial|) (82 . -) (|Stream| 34) (|Mapping| 34 33)
              (|Stream| 33) (|StreamFunctions2| 33 34) (88 . |map|) (94 . -)
              (99 . |Zero|) (103 . |One|) (107 . |cons|)
              (|ContinuedFraction| 34) (113 . |continuedFraction|)
              (120 . |JContinuedFraction|))
           '#(|JContinuedFraction| 126) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|JContinuedFraction|
                                 ((|ContinuedFraction|
                                   (|UnivariatePolynomial| |#2| |#1|))
                                  (|Distribution| |#1|)
                                  (|UnivariatePolynomial| |#2| |#1|)))
                                (|has| 6 (|Field|)))
                              '((|JContinuedFraction|
                                 ((|ContinuedFraction|
                                   (|UnivariatePolynomial| |#2|
                                                           (|Fraction| |#1|)))
                                  (|Distribution| |#1|)
                                  (|UnivariatePolynomial| |#2|
                                                          (|Fraction| |#1|))))
                                (AND (|has| 6 (|IntegralDomain|))
                                     (|not| (|has| 6 (|Field|))))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 48
                                            '(1 9 8 0 10 0 6 0 11 0 9 0 12 0 13
                                              0 14 2 15 0 6 13 16 2 15 0 0 0 17
                                              2 21 18 19 20 22 1 6 0 0 23 0 15
                                              0 24 0 6 0 25 0 15 0 26 2 18 0 15
                                              0 27 3 28 0 15 18 18 29 2 0 28 9
                                              15 30 1 9 31 0 32 2 34 0 33 13 35
                                              2 34 0 0 0 36 2 40 37 38 39 41 1
                                              33 0 0 42 0 34 0 43 0 34 0 44 2
                                              37 0 34 0 45 3 46 0 34 37 37 47 2
                                              0 46 9 34 48 2 2 46 9 34 48 2 1
                                              28 9 15 30)))))
           '|lookupComplete|)) 
