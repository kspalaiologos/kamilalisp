
(SDEFUN |PFOQ;torsion?;FdB;1|
        ((|d| (|FiniteDivisor| (|Fraction| (|Integer|)) UP UPUP R))
         ($ (|Boolean|)))
        (QEQCAR (SPADCALL |d| (QREFELT $ 11)) 0)) 

(SDEFUN |PFOQ;ratcurve|
        ((|d| (|FiniteDivisor| (|Fraction| (|Integer|)) UP UPUP R))
         (|modulus| (UPUP)) (|disc| (|Integer|)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|m| #1=(|NonNegativeInteger|)) (|n| #1#) (|p| (|PositiveInteger|))
          (|bad| (|Integer|)) (|r| (|Fraction| (|Integer|)))
          (|bd| (|Record| (|:| |den| (|Integer|)) (|:| |gcdnum| (|Integer|))))
          (|s| (UP)) (|b| (UP)) (|h| (UPUP)) (|hh| (R)) (|mn| (|Integer|))
          (|nm| (|Vector| R))
          (|i| (|FractionalIdeal| UP (|Fraction| UP) UPUP R)))
         (SEQ
          (LETT |mn|
                (SPADCALL
                 (LETT |nm|
                       (SPADCALL (LETT |i| (SPADCALL |d| (QREFELT $ 15)))
                                 (QREFELT $ 17)))
                 (QREFELT $ 19)))
          (LETT |h|
                (SPADCALL (LETT |hh| (SPADCALL |nm| (+ |mn| 1) (QREFELT $ 22)))
                          (QREFELT $ 23)))
          (LETT |s|
                (QCAR
                 (SPADCALL
                  (SPADCALL (SPADCALL |hh| (QREFELT $ 25)) (QREFELT $ 26))
                  (LETT |b|
                        (SPADCALL
                         (SPADCALL (SPADCALL |nm| |mn| (QREFELT $ 22))
                                   (QREFELT $ 27))
                         (QREFELT $ 26)))
                  (QREFELT $ 29))))
          (LETT |bd| (SPADCALL (SPADCALL |i| (QREFELT $ 30)) (QREFELT $ 33)))
          (LETT |r| (SPADCALL |s| |b| (QREFELT $ 35)))
          (LETT |bad|
                (SPADCALL
                 (LIST |disc| (SPADCALL |r| (QREFELT $ 36))
                       (SPADCALL |r| (QREFELT $ 37))
                       (* (QCAR |bd|) (QCDR |bd|))
                       (SPADCALL |h| (QREFELT $ 38)))
                 (QREFELT $ 40)))
          (LETT |n|
                (|PFOQ;rat| |modulus| |d|
                 (LETT |p| (SPADCALL |bad| (QREFELT $ 42))) $))
          (EXIT
           (COND ((EQL |n| 1) |n|)
                 (#2='T
                  (SEQ
                   (LETT |m|
                         (|PFOQ;rat| |modulus| |d|
                          (SPADCALL (* |p| |bad|) (QREFELT $ 42)) $))
                   (EXIT (COND ((EQL |n| |m|) |n|) (#2# 0)))))))))) 

(SDEFUN |PFOQ;rat|
        ((|pp| (UPUP))
         (|d| (|FiniteDivisor| (|Fraction| (|Integer|)) UP UPUP R))
         (|p| (|PositiveInteger|)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|gf|
           (|Join| (|FiniteFieldCategory|) (|FiniteAlgebraicExtensionField| $)
                   (|ConvertibleTo| (|Integer|))
                   (CATEGORY |domain| (SIGNATURE |sqrt| ($ $))
                    (SIGNATURE |quadraticNonResidue| ($))))))
         (SEQ (LETT |gf| (|InnerPrimeField| |p|))
              (EXIT
               (SPADCALL |d| |pp| (CONS #'|PFOQ;rat!0| (VECTOR |gf| $))
                         (|compiledLookupCheck| '|order|
                                                (LIST
                                                 (LIST '|NonNegativeInteger|)
                                                 (LIST '|FiniteDivisor|
                                                       (LIST '|Fraction|
                                                             (LIST '|Integer|))
                                                       (|devaluate| (ELT $ 6))
                                                       (|devaluate| (ELT $ 7))
                                                       (|devaluate| (ELT $ 8)))
                                                 (|devaluate| (ELT $ 7))
                                                 (LIST '|Mapping|
                                                       (|devaluate| |gf|)
                                                       (LIST '|Fraction|
                                                             (LIST
                                                              '|Integer|))))
                                                (|ReducedDivisor|
                                                 (|Fraction| (|Integer|))
                                                 (ELT $ 6) (ELT $ 7) (ELT $ 8)
                                                 |gf|))))))) 

(SDEFUN |PFOQ;rat!0| ((|z1| NIL) ($$ NIL))
        (PROG ($ |gf|)
          (LETT $ (QREFELT $$ 1))
          (LETT |gf| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL (SPADCALL |z1| (QREFELT $ 36))
                       (|compiledLookupCheck| '|coerce|
                                              (LIST '$ (LIST '|Integer|))
                                              |gf|))
             (SPADCALL (SPADCALL |z1| (QREFELT $ 37))
                       (|compiledLookupCheck| '|coerce|
                                              (LIST '$ (LIST '|Integer|))
                                              |gf|))
             (|compiledLookupCheck| '/ (LIST '$ '$ '$) |gf|)))))) 

(SDEFUN |PFOQ;possibleOrder|
        ((|d| (|FiniteDivisor| (|Fraction| (|Integer|)) UP UPUP R))
         ($ (|NonNegativeInteger|)))
        (SPROG ((|r| (UPUP)))
               (SEQ
                (COND
                 ((OR (ZEROP (SPADCALL (QREFELT $ 44)))
                      (EQL
                       (QVSIZE
                        (SPADCALL (SPADCALL |d| (QREFELT $ 15))
                                  (QREFELT $ 17)))
                       1))
                  1)
                 ('T
                  (SEQ
                   (LETT |r|
                         (SPADCALL (SPADCALL (QREFELT $ 45)) (QREFELT $ 46)))
                   (EXIT
                    (|PFOQ;ratcurve| |d| |r| (SPADCALL |r| (QREFELT $ 47))
                     $)))))))) 

(SDEFUN |PFOQ;order;FdU;5|
        ((|d| (|FiniteDivisor| (|Fraction| (|Integer|)) UP UPUP R))
         ($ (|Union| (|NonNegativeInteger|) "failed")))
        (SPROG ((|n| (|NonNegativeInteger|)))
               (COND
                ((OR
                  (ZEROP
                   (LETT |n|
                         (|PFOQ;possibleOrder|
                          (LETT |d| (SPADCALL |d| (QREFELT $ 48))) $)))
                  (NULL
                   (SPADCALL
                    (SPADCALL (SPADCALL |n| |d| (QREFELT $ 49)) (QREFELT $ 48))
                    (QREFELT $ 50))))
                 (CONS 1 "failed"))
                ('T (CONS 0 |n|))))) 

(SDEFUN |PFOQ;torsionIfCan;FdU;6|
        ((|d| (|FiniteDivisor| (|Fraction| (|Integer|)) UP UPUP R))
         ($
          (|Union|
           (|Record| (|:| |order| (|NonNegativeInteger|)) (|:| |function| R))
           "failed")))
        (SPROG ((|g| (|Union| R "failed")) (|n| (|NonNegativeInteger|)))
               (SEQ
                (COND
                 ((ZEROP
                   (LETT |n|
                         (|PFOQ;possibleOrder|
                          (LETT |d| (SPADCALL |d| (QREFELT $ 48))) $)))
                  (CONS 1 "failed"))
                 (#1='T
                  (SEQ
                   (LETT |g|
                         (SPADCALL
                          (SPADCALL (SPADCALL |n| |d| (QREFELT $ 49))
                                    (QREFELT $ 48))
                          (QREFELT $ 52)))
                   (EXIT
                    (COND ((QEQCAR |g| 1) (CONS 1 "failed"))
                          (#1# (CONS 0 (CONS |n| (QCDR |g|)))))))))))) 

(DECLAIM (NOTINLINE |PointsOfFiniteOrderRational;|)) 

(DEFUN |PointsOfFiniteOrderRational| (&REST #1=#:G745)
  (SPROG NIL
         (PROG (#2=#:G746)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PointsOfFiniteOrderRational|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |PointsOfFiniteOrderRational;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|PointsOfFiniteOrderRational|)))))))))) 

(DEFUN |PointsOfFiniteOrderRational;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|PointsOfFiniteOrderRational| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 56))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|PointsOfFiniteOrderRational|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|PointsOfFiniteOrderRational| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|Union| 43 '#1="failed")
              (|FiniteDivisor| 34 6 7 8) |PFOQ;order;FdU;5| (|Boolean|)
              |PFOQ;torsion?;FdB;1| (|FractionalIdeal| 6 24 7 8) (0 . |ideal|)
              (|Vector| 8) (5 . |numer|) (|Integer|) (10 . |minIndex|)
              (15 . |One|) (19 . |One|) (23 . |elt|) (29 . |lift|)
              (|Fraction| 6) (34 . |norm|) (39 . |retract|) (44 . |retract|)
              (|Record| (|:| |primePart| $) (|:| |commonPart| $))
              (49 . |separate|) (55 . |denom|)
              (|Record| (|:| |den| 18) (|:| |gcdnum| 18))
              (|PointsOfFiniteOrderTools| 6 7) (60 . |badNum|) (|Fraction| 18)
              (65 . |resultant|) (71 . |numer|) (76 . |denom|) (81 . |badNum|)
              (|List| $) (86 . |lcm|) (|PositiveInteger|) (91 . |getGoodPrime|)
              (|NonNegativeInteger|) (96 . |genus|)
              (100 . |definingPolynomial|) (104 . |polyred|)
              (109 . |doubleDisc|) (114 . |reduce|) (119 . *)
              (125 . |principal?|) (|Union| 8 '"failed") (130 . |generator|)
              (|Record| (|:| |order| 43) (|:| |function| 8))
              (|Union| 53 '#2="failed") |PFOQ;torsionIfCan;FdU;6|)
           '#(|torsionIfCan| 135 |torsion?| 140 |order| 145) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|order|
                                 ((|Union| (|NonNegativeInteger|) #1#)
                                  (|FiniteDivisor| (|Fraction| (|Integer|))
                                                   |#1| |#2| |#3|)))
                                T)
                              '((|torsion?|
                                 ((|Boolean|)
                                  (|FiniteDivisor| (|Fraction| (|Integer|))
                                                   |#1| |#2| |#3|)))
                                T)
                              '((|torsionIfCan|
                                 ((|Union|
                                   (|Record|
                                    (|:| |order| (|NonNegativeInteger|))
                                    (|:| |function| |#3|))
                                   #2#)
                                  (|FiniteDivisor| (|Fraction| (|Integer|))
                                                   |#1| |#2| |#3|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 55
                                            '(1 10 14 0 15 1 14 16 0 17 1 16 18
                                              0 19 0 6 0 20 0 7 0 21 2 16 8 0
                                              18 22 1 8 7 0 23 1 8 24 0 25 1 24
                                              6 0 26 1 8 24 0 27 2 6 28 0 0 29
                                              1 14 6 0 30 1 32 31 6 33 2 6 34 0
                                              0 35 1 34 18 0 36 1 34 18 0 37 1
                                              32 18 7 38 1 18 0 39 40 1 32 41
                                              18 42 0 8 43 44 0 8 7 45 1 32 7 7
                                              46 1 32 18 7 47 1 10 0 0 48 2 10
                                              0 18 0 49 1 10 12 0 50 1 10 51 0
                                              52 1 0 54 10 55 1 0 12 10 13 1 0
                                              9 10 11)))))
           '|lookupComplete|)) 
