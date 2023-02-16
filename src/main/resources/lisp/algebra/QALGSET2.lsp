
(SDEFUN |QALGSET2;f|
        ((|v| (|OrderedVariableList| |vl|))
         ($
          (|DistributedMultivariatePolynomial| |newvl|
                                               (|Fraction| (|Integer|)))))
        (SPROG ((#1=#:G708 NIL))
               (SPADCALL
                (PROG2
                    (LETT #1#
                          (SPADCALL (SPADCALL |v| (QREFELT $ 16))
                                    (QREFELT $ 13)))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0)
                                  (|OrderedVariableList| (QREFELT $ 10))
                                  (|Union|
                                   (|OrderedVariableList| (QREFELT $ 10))
                                   "failed")
                                  #1#))
                (QREFELT $ 18)))) 

(SDEFUN |QALGSET2;g|
        ((|v| (|OrderedVariableList| |newvl|))
         ($
          (|DistributedMultivariatePolynomial| |vl| (|Fraction| (|Integer|)))))
        (SPROG ((#1=#:G719 NIL))
               (COND
                ((SPADCALL |v| (QREFELT $ 14) (QREFELT $ 20))
                 (|spadConstant| $ 22))
                ('T
                 (SPADCALL
                  (PROG2
                      (LETT #1#
                            (SPADCALL (SPADCALL |v| (QREFELT $ 23))
                                      (QREFELT $ 24)))
                      (QCDR #1#)
                    (|check_union2| (QEQCAR #1# 0)
                                    (|OrderedVariableList| (QREFELT $ 6))
                                    (|Union|
                                     (|OrderedVariableList| (QREFELT $ 6))
                                     "failed")
                                    #1#))
                  (QREFELT $ 25)))))) 

(SDEFUN |QALGSET2;npoly|
        ((|p|
          (|DistributedMultivariatePolynomial| |vl| (|Fraction| (|Integer|))))
         ($
          (|DistributedMultivariatePolynomial| |newvl|
                                               (|Fraction| (|Integer|)))))
        (SPADCALL (CONS #'|QALGSET2;npoly!0| $) (ELT $ 27) |p| (QREFELT $ 31))) 

(SDEFUN |QALGSET2;npoly!0| ((|z1| NIL) ($ NIL)) (|QALGSET2;f| |z1| $)) 

(SDEFUN |QALGSET2;oldpoly|
        ((|q|
          (|DistributedMultivariatePolynomial| |newvl|
                                               (|Fraction| (|Integer|))))
         ($
          (|Union|
           (|DistributedMultivariatePolynomial| |vl| (|Fraction| (|Integer|)))
           "failed")))
        (SPROG ((|x| (|Union| (|OrderedVariableList| |newvl|) "failed")))
               (SEQ (LETT |x| (SPADCALL |q| (QREFELT $ 33)))
                    (EXIT
                     (COND
                      ((QEQCAR |x| 1)
                       (CONS 0
                             (SPADCALL (SPADCALL |q| (QREFELT $ 34))
                                       (QREFELT $ 35))))
                      ((SPADCALL (QCDR |x|) (QREFELT $ 14) (QREFELT $ 20))
                       (CONS 1 "failed"))
                      ('T
                       (CONS 0
                             (SPADCALL (CONS #'|QALGSET2;oldpoly!0| $)
                                       (ELT $ 35) |q| (QREFELT $ 39))))))))) 

(SDEFUN |QALGSET2;oldpoly!0| ((|z1| NIL) ($ NIL)) (|QALGSET2;g| |z1| $)) 

(SDEFUN |QALGSET2;radicalSimplify;2Qas;5|
        ((|x|
          (|QuasiAlgebraicSet| (|Fraction| (|Integer|))
                               (|OrderedVariableList| |vl|)
                               (|DirectProduct| (|#| |vl|)
                                                (|NonNegativeInteger|))
                               (|DistributedMultivariatePolynomial| |vl|
                                                                    (|Fraction|
                                                                     (|Integer|)))))
         ($
          (|QuasiAlgebraicSet| (|Fraction| (|Integer|))
                               (|OrderedVariableList| |vl|)
                               (|DirectProduct| (|#| |vl|)
                                                (|NonNegativeInteger|))
                               (|DistributedMultivariatePolynomial| |vl|
                                                                    (|Fraction|
                                                                     (|Integer|))))))
        (SPROG
         ((|y|
           (|QuasiAlgebraicSet| (|Fraction| (|Integer|))
                                (|OrderedVariableList| |vl|)
                                (|DirectProduct| (|#| |vl|)
                                                 (|NonNegativeInteger|))
                                (|DistributedMultivariatePolynomial| |vl|
                                                                     (|Fraction|
                                                                      (|Integer|)))))
          (|ngb|
           (|List|
            (|DistributedMultivariatePolynomial| |newvl|
                                                 (|Fraction| (|Integer|)))))
          (|gb|
           (|List|
            (|DistributedMultivariatePolynomial| |vl|
                                                 (|Fraction| (|Integer|)))))
          (|k|
           (|Union|
            (|DistributedMultivariatePolynomial| |vl| (|Fraction| (|Integer|)))
            "failed"))
          (|id|
           (|PolynomialIdeal| (|Fraction| (|Integer|))
                              (|DirectProduct| (|#| |newvl|)
                                               (|NonNegativeInteger|))
                              (|OrderedVariableList| |newvl|)
                              (|DistributedMultivariatePolynomial| |newvl|
                                                                   (|Fraction|
                                                                    (|Integer|)))))
          (|gen|
           (|List|
            (|DistributedMultivariatePolynomial| |newvl|
                                                 (|Fraction| (|Integer|)))))
          (#1=#:G748 NIL) (|g| NIL) (#2=#:G747 NIL)
          (|tp|
           (|DistributedMultivariatePolynomial| |newvl|
                                                (|Fraction| (|Integer|))))
          (|t|
           (|DistributedMultivariatePolynomial| |newvl|
                                                (|Fraction| (|Integer|))))
          (|n0|
           (|DistributedMultivariatePolynomial| |vl| (|Fraction| (|Integer|))))
          (|z0|
           (|List|
            (|DistributedMultivariatePolynomial| |vl|
                                                 (|Fraction| (|Integer|))))))
         (SEQ
          (COND
           ((SPADCALL (SPADCALL |x| (QREFELT $ 42)) (CONS 0 'T) (QREFELT $ 43))
            |x|)
           (#3='T
            (SEQ (LETT |z0| (SPADCALL |x| (QREFELT $ 45)))
                 (LETT |n0| (SPADCALL |x| (QREFELT $ 46)))
                 (LETT |t| (SPADCALL (QREFELT $ 14) (QREFELT $ 18)))
                 (LETT |tp|
                       (SPADCALL
                        (SPADCALL |t| (|QALGSET2;npoly| |n0| $) (QREFELT $ 47))
                        (|spadConstant| $ 48) (QREFELT $ 49)))
                 (LETT |gen|
                       (CONS |tp|
                             (PROGN
                              (LETT #2# NIL)
                              (SEQ (LETT |g| NIL) (LETT #1# |z0|) G190
                                   (COND
                                    ((OR (ATOM #1#)
                                         (PROGN (LETT |g| (CAR #1#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT #2#
                                           (CONS (|QALGSET2;npoly| |g| $)
                                                 #2#))))
                                   (LETT #1# (CDR #1#)) (GO G190) G191
                                   (EXIT (NREVERSE #2#))))))
                 (LETT |id| (SPADCALL |gen| (QREFELT $ 52)))
                 (LETT |ngb|
                       (SPADCALL (SPADCALL |id| (QREFELT $ 54))
                                 (QREFELT $ 55)))
                 (EXIT
                  (COND
                   ((SPADCALL (|spadConstant| $ 48) |ngb| (QREFELT $ 56))
                    (SPADCALL (QREFELT $ 57)))
                   (#3#
                    (SEQ (LETT |gb| NIL)
                         (SEQ G190
                              (COND ((NULL (NULL (NULL |ngb|))) (GO G191)))
                              (SEQ
                               (SEQ
                                (LETT |k|
                                      (|QALGSET2;oldpoly| (|SPADfirst| |ngb|)
                                       $))
                                (EXIT
                                 (COND
                                  ((QEQCAR |k| 0)
                                   (LETT |gb| (CONS (QCDR |k|) |gb|))))))
                               (EXIT (LETT |ngb| (CDR |ngb|))))
                              NIL (GO G190) G191 (EXIT NIL))
                         (LETT |y|
                               (SPADCALL |gb|
                                         (SPADCALL
                                          (SPADCALL |n0| |gb| (QREFELT $ 59))
                                          (QREFELT $ 60))
                                         (QREFELT $ 61)))
                         (EXIT
                          (SPADCALL |y| (CONS 0 NIL) (QREFELT $ 62))))))))))))) 

(DECLAIM (NOTINLINE |QuasiAlgebraicSet2;|)) 

(DEFUN |QuasiAlgebraicSet2| (#1=#:G749)
  (SPROG NIL
         (PROG (#2=#:G750)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST #1#)
                                               (HGET |$ConstructorCache|
                                                     '|QuasiAlgebraicSet2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|QuasiAlgebraicSet2;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|QuasiAlgebraicSet2|)))))))))) 

(DEFUN |QuasiAlgebraicSet2;| (|#1|)
  (SPROG ((#1=#:G708 NIL) (|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 |#1|)
          (LETT |dv$| (LIST '|QuasiAlgebraicSet2| DV$1))
          (LETT $ (GETREFV 64))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|QuasiAlgebraicSet2| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9 (SPADCALL (QREFELT $ 8)))
          (QSETREFV $ 10 (CONS (QREFELT $ 9) |#1|))
          (QSETREFV $ 14
                    (PROG2 (LETT #1# (SPADCALL (QREFELT $ 9) (QREFELT $ 13)))
                        (QCDR #1#)
                      (|check_union2| (QEQCAR #1# 0)
                                      (|OrderedVariableList| (QREFELT $ 10))
                                      (|Union|
                                       (|OrderedVariableList| (QREFELT $ 10))
                                       "failed")
                                      #1#)))
          $))) 

(MAKEPROP '|QuasiAlgebraicSet2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Symbol|) (0 . |new|)
              '|ts| '|newvl| (|Union| $ '"failed")
              (|OrderedVariableList| (NRTEVAL (QREFELT $ 10))) (4 . |variable|)
              '|tv| (|OrderedVariableList| (NRTEVAL (QREFELT $ 6)))
              (9 . |convert|)
              (|DistributedMultivariatePolynomial| (NRTEVAL (QREFELT $ 10)) 26)
              (14 . |coerce|) (|Boolean|) (19 . =)
              (|DistributedMultivariatePolynomial| (NRTEVAL (QREFELT $ 6)) 26)
              (25 . |Zero|) (29 . |convert|) (34 . |variable|) (39 . |coerce|)
              (|Fraction| (|Integer|)) (44 . |coerce|) (|Mapping| 17 15)
              (|Mapping| 17 26)
              (|PolynomialCategoryLifting|
               (|DirectProduct| (NRTEVAL (LENGTH (QREFELT $ 6)))
                                (|NonNegativeInteger|))
               15 26 21 17)
              (49 . |map|) (|Union| 12 '"failed") (56 . |mainVariable|)
              (61 . |leadingCoefficient|) (66 . |coerce|) (|Mapping| 21 12)
              (|Mapping| 21 26)
              (|PolynomialCategoryLifting|
               (|DirectProduct| (NRTEVAL (LENGTH (QREFELT $ 10)))
                                (|NonNegativeInteger|))
               12 26 17 21)
              (71 . |map|) (|Union| 19 '"failed")
              (|QuasiAlgebraicSet| 26 15
                                   (|DirectProduct|
                                    (NRTEVAL (LENGTH (QREFELT $ 6)))
                                    (|NonNegativeInteger|))
                                   21)
              (78 . |status|) (83 . =) (|List| 21) (89 . |definingEquations|)
              (94 . |definingInequation|) (99 . *) (105 . |One|) (109 . -)
              (|List| 17)
              (|PolynomialIdeal| 26
                                 (|DirectProduct|
                                  (NRTEVAL (LENGTH (QREFELT $ 10)))
                                  (|NonNegativeInteger|))
                                 12 17)
              (115 . |ideal|)
              (|IdealDecompositionPackage| (NRTEVAL (QREFELT $ 10)))
              (120 . |radical|) (125 . |generators|) (130 . |member?|)
              (136 . |empty|)
              (|GroebnerPackage| 26
                                 (|DirectProduct|
                                  (NRTEVAL (LENGTH (QREFELT $ 6)))
                                  (|NonNegativeInteger|))
                                 21)
              (140 . |normalForm|) (146 . |primitivePart|)
              (151 . |quasiAlgebraicSet|) (157 . |setStatus|)
              |QALGSET2;radicalSimplify;2Qas;5|)
           '#(|radicalSimplify| 163) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|radicalSimplify|
                                 ((|QuasiAlgebraicSet| (|Fraction| (|Integer|))
                                                       (|OrderedVariableList|
                                                        |#1|)
                                                       (|DirectProduct|
                                                        (|#| |#1|)
                                                        (|NonNegativeInteger|))
                                                       (|DistributedMultivariatePolynomial|
                                                        |#1|
                                                        (|Fraction|
                                                         (|Integer|))))
                                  (|QuasiAlgebraicSet| (|Fraction| (|Integer|))
                                                       (|OrderedVariableList|
                                                        |#1|)
                                                       (|DirectProduct|
                                                        (|#| |#1|)
                                                        (|NonNegativeInteger|))
                                                       (|DistributedMultivariatePolynomial|
                                                        |#1|
                                                        (|Fraction|
                                                         (|Integer|))))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 63
                                            '(0 7 0 8 1 12 11 7 13 1 15 7 0 16
                                              1 17 0 12 18 2 12 19 0 0 20 0 21
                                              0 22 1 12 7 0 23 1 15 11 7 24 1
                                              21 0 15 25 1 17 0 26 27 3 30 17
                                              28 29 21 31 1 17 32 0 33 1 17 26
                                              0 34 1 21 0 26 35 3 38 21 36 37
                                              17 39 1 41 40 0 42 2 40 19 0 0 43
                                              1 41 44 0 45 1 41 21 0 46 2 17 0
                                              0 0 47 0 17 0 48 2 17 0 0 0 49 1
                                              51 0 50 52 1 53 51 51 54 1 51 50
                                              0 55 2 50 19 17 0 56 0 41 0 57 2
                                              58 21 21 44 59 1 21 0 0 60 2 41 0
                                              44 21 61 2 41 0 0 40 62 1 0 41 41
                                              63)))))
           '|lookupComplete|)) 
