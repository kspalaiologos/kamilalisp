
(PUT '|EXTRED;polynomial| '|SPADreplace| '(XLAM (|x|) (QVELT |x| 0))) 

(SDEFUN |EXTRED;polynomial|
        ((|x|
          (|Record| (|:| |poly| R) (|:| |repr| (|Vector| R)) (|:| |mult| C)))
         ($ (R)))
        (QVELT |x| 0)) 

(PUT '|EXTRED;representation| '|SPADreplace| '(XLAM (|x|) (QVELT |x| 1))) 

(SDEFUN |EXTRED;representation|
        ((|x|
          (|Record| (|:| |poly| R) (|:| |repr| (|Vector| R)) (|:| |mult| C)))
         ($ (|Vector| R)))
        (QVELT |x| 1)) 

(PUT '|EXTRED;multiplier| '|SPADreplace| '(XLAM (|x|) (QVELT |x| 2))) 

(SDEFUN |EXTRED;multiplier|
        ((|x|
          (|Record| (|:| |poly| R) (|:| |repr| (|Vector| R)) (|:| |mult| C)))
         ($ (C)))
        (QVELT |x| 2)) 

(SDEFUN |EXTRED;cancelGcd|
        ((|c1| (C)) (|c2| (C)) ($ (|Record| (|:| |co1| C) (|:| |co2| C))))
        (SPROG ((#1=#:G702 NIL) (|g| (C)))
               (SEQ (LETT |g| (SPADCALL |c1| |c2| (QREFELT $ 9)))
                    (EXIT
                     (CONS
                      (PROG2 (LETT #1# (SPADCALL |c1| |g| (QREFELT $ 11)))
                          (QCDR #1#)
                        (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                        (|Union| (QREFELT $ 6) #2="failed")
                                        #1#))
                      (PROG2 (LETT #1# (SPADCALL |c2| |g| (QREFELT $ 11)))
                          (QCDR #1#)
                        (|check_union2| (QEQCAR #1# 0) (QREFELT $ 6)
                                        (|Union| (QREFELT $ 6) #2#) #1#))))))) 

(SDEFUN |EXTRED;embedBasisElement|
        ((|r| (R)) (|i| (|NonNegativeInteger|)) (|n| (|NonNegativeInteger|))
         ($
          (|Record| (|:| |poly| R) (|:| |repr| (|Vector| R)) (|:| |mult| C))))
        (SPROG ((|v| (|Vector| R)))
               (SEQ (LETT |v| (MAKEARR1 |n| (|spadConstant| $ 14)))
                    (SPADCALL |v| |i|
                              (SPADCALL (|spadConstant| $ 16) (QREFELT $ 17))
                              (QREFELT $ 20))
                    (EXIT (VECTOR |r| |v| (|spadConstant| $ 15)))))) 

(SDEFUN |EXTRED;denominatorFreeTopReduce|
        ((|x|
          (|Record| (|:| |poly| R) (|:| |repr| (|Vector| R)) (|:| |mult| C)))
         (|basis|
          #1=(|List|
              (|Record| (|:| |poly| R) (|:| |repr| (|Vector| R))
                        (|:| |mult| C))))
         ($
          (|Record| (|:| |poly| R) (|:| |repr| (|Vector| R)) (|:| |mult| C))))
        (SPROG
         ((#2=#:G730 NIL) (|bas| #1#) (|f2| (R)) (|f1| (C)) (|a| (C))
          (|l| (|Record| (|:| |llcm_res| C) (|:| |coeff1| C) (|:| |coeff2| C)))
          (|ee| (|Union| E "failed")) (|pb| (R))
          (|b|
           (|Record| (|:| |poly| R) (|:| |repr| (|Vector| R)) (|:| |mult| C)))
          (|pz| (R))
          (|z|
           (|Record| (|:| |poly| R) (|:| |repr| (|Vector| R)) (|:| |mult| C))))
         (SEQ
          (EXIT
           (SEQ
            (LETT |z|
                  (VECTOR (|EXTRED;polynomial| |x| $)
                          (|EXTRED;representation| |x| $)
                          (|EXTRED;multiplier| |x| $)))
            (LETT |bas| |basis|)
            (SEQ G190
                 (COND
                  ((NULL
                    (COND
                     ((SPADCALL (LETT |pz| (|EXTRED;polynomial| |z| $))
                                (QREFELT $ 22))
                      NIL)
                     ('T (NULL (NULL |bas|)))))
                   (GO G191)))
                 (SEQ (LETT |b| (|SPADfirst| |bas|))
                      (LETT |pb| (|EXTRED;polynomial| |b| $))
                      (LETT |ee|
                            (SPADCALL (SPADCALL |pz| (QREFELT $ 23))
                                      (SPADCALL |pb| (QREFELT $ 23))
                                      (QREFELT $ 24)))
                      (EXIT
                       (COND
                        ((QEQCAR |ee| 0)
                         (SEQ
                          (LETT |l|
                                (SPADCALL (SPADCALL |pz| (QREFELT $ 25))
                                          (SPADCALL |pb| (QREFELT $ 25))
                                          (QREFELT $ 27)))
                          (LETT |f1| (QVELT |l| 1))
                          (LETT |f2|
                                (SPADCALL (QVELT |l| 2) (QCDR |ee|)
                                          (QREFELT $ 28)))
                          (QSETVELT |z| 0
                                    (SPADCALL
                                     (SPADCALL |f1|
                                               (SPADCALL |pz| (QREFELT $ 29))
                                               (QREFELT $ 30))
                                     (SPADCALL |f2|
                                               (SPADCALL |pb| (QREFELT $ 29))
                                               (QREFELT $ 31))
                                     (QREFELT $ 32)))
                          (LETT |a|
                                (QVELT
                                 (SPADCALL
                                  (SPADCALL (QVELT |z| 0) (QREFELT $ 25))
                                  (QREFELT $ 34))
                                 2))
                          (QSETVELT |z| 0
                                    (SPADCALL |a| (QVELT |z| 0)
                                              (QREFELT $ 30)))
                          (LETT |f1| (SPADCALL |a| |f1| (QREFELT $ 35)))
                          (LETT |f2| (SPADCALL |a| |f2| (QREFELT $ 30)))
                          (QSETVELT |z| 1
                                    (SPADCALL
                                     (SPADCALL (SPADCALL |f1| (QREFELT $ 36))
                                               (|EXTRED;representation| |z| $)
                                               (QREFELT $ 37))
                                     (SPADCALL |f2|
                                               (|EXTRED;representation| |b| $)
                                               (QREFELT $ 37))
                                     (QREFELT $ 38)))
                          (QSETVELT |z| 2
                                    (SPADCALL |f1| (|EXTRED;multiplier| |z| $)
                                              (QREFELT $ 35)))
                          (EXIT (LETT |bas| |basis|))))
                        ('T (LETT |bas| (CDR |bas|))))))
                 NIL (GO G190) G191 (EXIT NIL))
            (EXIT (PROGN (LETT #2# |z|) (GO #3=#:G729)))))
          #3# (EXIT #2#)))) 

(SDEFUN |EXTRED;tailReduce|
        ((|x|
          (|Record| (|:| |poly| R) (|:| |repr| (|Vector| R)) (|:| |mult| C)))
         (|basis|
          (|List|
           (|Record| (|:| |poly| R) (|:| |repr| (|Vector| R)) (|:| |mult| C))))
         ($
          (|Record| (|:| |poly| R) (|:| |repr| (|Vector| R)) (|:| |mult| C))))
        (SPROG ((|r| (R)) (|m| (C)) (|p| (R)) (|v| (|Vector| R)))
               (SEQ
                (COND ((NULL |basis|) |x|)
                      ('T
                       (SEQ (LETT |p| (|EXTRED;polynomial| |x| $))
                            (LETT |r| (|spadConstant| $ 14))
                            (LETT |v| (|EXTRED;representation| |x| $))
                            (LETT |m| (|EXTRED;multiplier| |x| $))
                            (SEQ G190
                                 (COND
                                  ((NULL (NULL (SPADCALL |p| (QREFELT $ 22))))
                                   (GO G191)))
                                 (SEQ
                                  (LETT |r|
                                        (SPADCALL |r|
                                                  (SPADCALL |p| (QREFELT $ 39))
                                                  (QREFELT $ 40)))
                                  (LETT |p| (SPADCALL |p| (QREFELT $ 29)))
                                  (LETT |x|
                                        (|EXTRED;denominatorFreeTopReduce|
                                         (VECTOR |p| |v| (|spadConstant| $ 15))
                                         |basis| $))
                                  (LETT |v| (|EXTRED;representation| |x| $))
                                  (LETT |p| (|EXTRED;polynomial| |x| $))
                                  (LETT |m|
                                        (SPADCALL (|EXTRED;multiplier| |x| $)
                                                  |m| (QREFELT $ 35)))
                                  (EXIT
                                   (LETT |r|
                                         (SPADCALL (|EXTRED;multiplier| |x| $)
                                                   |r| (QREFELT $ 30)))))
                                 NIL (GO G190) G191 (EXIT NIL))
                            (EXIT (VECTOR |r| |v| |m|)))))))) 

(SDEFUN |EXTRED;reduce;RLR;8|
        ((|r| (R)) (|basis| (|List| R))
         ($
          (|Record| (|:| |poly| R) (|:| |repr| (|Vector| R)) (|:| |mult| C))))
        (SPROG
         ((|x|
           (|Record| (|:| |poly| R) (|:| |repr| (|Vector| R)) (|:| |mult| C)))
          (|bas|
           (|List|
            (|Record| (|:| |poly| R) (|:| |repr| (|Vector| R))
                      (|:| |mult| C))))
          (#1=#:G748 NIL) (|b| NIL) (#2=#:G749 NIL) (|i| NIL) (#3=#:G747 NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (COND
           ((NULL |basis|) (VECTOR |r| (MAKE-ARRAY 0) (|spadConstant| $ 15)))
           ('T
            (SEQ (LETT |n| (LENGTH |basis|))
                 (LETT |x|
                       (VECTOR |r| (MAKEARR1 |n| (|spadConstant| $ 14))
                               (|spadConstant| $ 15)))
                 (LETT |bas|
                       (PROGN
                        (LETT #3# NIL)
                        (SEQ (LETT |i| 1) (LETT #2# |n|) (LETT |b| NIL)
                             (LETT #1# |basis|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |b| (CAR #1#)) NIL)
                                   (|greater_SI| |i| #2#))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (LETT #3#
                                     (CONS
                                      (|EXTRED;embedBasisElement| |b| |i| |n|
                                       $)
                                      #3#))))
                             (LETT #1#
                                   (PROG1 (CDR #1#) (LETT |i| (|inc_SI| |i|))))
                             (GO G190) G191 (EXIT (NREVERSE #3#)))))
                 (LETT |x| (|EXTRED;denominatorFreeTopReduce| |x| |bas| $))
                 (EXIT (|EXTRED;tailReduce| |x| |bas| $)))))))) 

(DECLAIM (NOTINLINE |ExtendedPolynomialReduction;|)) 

(DEFUN |ExtendedPolynomialReduction| (&REST #1=#:G750)
  (SPROG NIL
         (PROG (#2=#:G751)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ExtendedPolynomialReduction|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |ExtendedPolynomialReduction;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|ExtendedPolynomialReduction|)))))))))) 

(DEFUN |ExtendedPolynomialReduction;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$| (LIST '|ExtendedPolynomialReduction| DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 44))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ExtendedPolynomialReduction|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ExtendedPolynomialReduction| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (0 . |gcd|) (|Union| $ '"failed") (6 . |exquo|)
              (12 . |Zero|) (16 . |Zero|) (20 . |Zero|) (24 . |One|)
              (28 . |One|) (32 . -) (|Integer|) (|Vector| 8) (37 . |setelt!|)
              (|Boolean|) (44 . |zero?|) (49 . |degree|) (54 . |subtractIfCan|)
              (60 . |leadingCoefficient|)
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (65 . |lcmCoef|) (71 . |monomial|) (77 . |reductum|) (82 . *)
              (88 . *) (94 . -)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (100 . |unitNormal|) (105 . *) (111 . |coerce|) (116 . *)
              (122 . -) (128 . |leadingMonomial|) (133 . +)
              (|Record| (|:| |poly| 8) (|:| |repr| 19) (|:| |mult| 6))
              (|List| 8) |EXTRED;reduce;RLR;8|)
           '#(|reduce| 139) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|reduce|
                                 ((|Record| (|:| |poly| |#3|)
                                            (|:| |repr| (|Vector| |#3|))
                                            (|:| |mult| |#1|))
                                  |#3| (|List| |#3|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 43
                                            '(2 6 0 0 0 9 2 6 10 0 0 11 0 6 0
                                              12 0 7 0 13 0 8 0 14 0 6 0 15 0 8
                                              0 16 1 8 0 0 17 3 19 8 0 18 8 20
                                              1 8 21 0 22 1 8 7 0 23 2 7 10 0 0
                                              24 1 8 6 0 25 2 6 26 0 0 27 2 8 0
                                              6 7 28 1 8 0 0 29 2 8 0 6 0 30 2
                                              8 0 0 0 31 2 8 0 0 0 32 1 6 33 0
                                              34 2 6 0 0 0 35 1 8 0 6 36 2 19 0
                                              8 0 37 2 19 0 0 0 38 1 8 0 0 39 2
                                              8 0 0 0 40 2 0 41 8 42 43)))))
           '|lookupComplete|)) 
