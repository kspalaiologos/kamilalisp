
(PUT '|EXPEXPAN;coeff| '|SPADreplace| '(XLAM (|term|) (QVELT |term| 0))) 

(SDEFUN |EXPEXPAN;coeff|
        ((|term|
          (|Record| (|:| |%coef| (|UnivariatePuiseuxSeries| FE |var| |cen|))
                    (|:| |%expon|
                         (|ExponentialOfUnivariatePuiseuxSeries| FE |var|
                                                                 |cen|))
                    (|:| |%expTerms|
                         (|List|
                          (|Record| (|:| |k| (|Fraction| (|Integer|)))
                                    (|:| |c| FE))))))
         ($ (|UnivariatePuiseuxSeries| FE |var| |cen|)))
        (QVELT |term| 0)) 

(PUT '|EXPEXPAN;exponent| '|SPADreplace| '(XLAM (|term|) (QVELT |term| 1))) 

(SDEFUN |EXPEXPAN;exponent|
        ((|term|
          (|Record| (|:| |%coef| (|UnivariatePuiseuxSeries| FE |var| |cen|))
                    (|:| |%expon|
                         (|ExponentialOfUnivariatePuiseuxSeries| FE |var|
                                                                 |cen|))
                    (|:| |%expTerms|
                         (|List|
                          (|Record| (|:| |k| (|Fraction| (|Integer|)))
                                    (|:| |c| FE))))))
         ($ (|ExponentialOfUnivariatePuiseuxSeries| FE |var| |cen|)))
        (QVELT |term| 1)) 

(SDEFUN |EXPEXPAN;upxssingIfCan|
        ((|f| ($))
         ($
          (|Union|
           (|UnivariatePuiseuxSeriesWithExponentialSingularity| R FE |var|
                                                                |cen|)
           "failed")))
        (COND
         ((SPADCALL (SPADCALL |f| (QREFELT $ 17)) (|spadConstant| $ 18)
                    (QREFELT $ 20))
          (CONS 0 (SPADCALL |f| (QREFELT $ 21))))
         ('T (CONS 1 "failed")))) 

(SDEFUN |EXPEXPAN;retractIfCan;$U;4|
        ((|f| ($))
         ($ (|Union| (|UnivariatePuiseuxSeries| FE |var| |cen|) "failed")))
        (SPROG
         ((|fff| (|Union| (|UnivariatePuiseuxSeries| FE |var| |cen|) "failed"))
          (|ff|
           (|Union|
            (|UnivariatePuiseuxSeriesWithExponentialSingularity| R FE |var|
                                                                 |cen|)
            "failed")))
         (SEQ (LETT |ff| (|EXPEXPAN;upxssingIfCan| |f| $))
              (EXIT
               (COND ((QEQCAR |ff| 1) (CONS 1 "failed"))
                     (#1='T
                      (SEQ (LETT |fff| (SPADCALL (QCDR |ff|) (QREFELT $ 23)))
                           (EXIT
                            (COND ((QEQCAR |fff| 1) (CONS 1 "failed"))
                                  (#1# (CONS 0 (QCDR |fff|)))))))))))) 

(SDEFUN |EXPEXPAN;/;2Upswes$;5|
        ((|f|
          #1=(|UnivariatePuiseuxSeriesWithExponentialSingularity| R FE |var|
                                                                  |cen|))
         (|g| #1#) ($ ($)))
        (SPROG
         ((|rec|
           (|Union|
            (|UnivariatePuiseuxSeriesWithExponentialSingularity| R FE |var|
                                                                 |cen|)
            "failed")))
         (SEQ (LETT |rec| (SPADCALL |g| (QREFELT $ 26)))
              (EXIT
               (COND ((QEQCAR |rec| 1) (SPADCALL |f| |g| (QREFELT $ 27)))
                     ('T
                      (SPADCALL |f| (SPADCALL (QCDR |rec|) (QREFELT $ 28))
                                (QREFELT $ 29)))))))) 

(SDEFUN |EXPEXPAN;/;3$;6| ((|f| ($)) (|g| ($)) ($ ($)))
        (SPROG
         ((|rec|
           (|Union|
            (|UnivariatePuiseuxSeriesWithExponentialSingularity| R FE |var|
                                                                 |cen|)
            "failed")))
         (SEQ
          (LETT |rec| (SPADCALL (SPADCALL |g| (QREFELT $ 21)) (QREFELT $ 26)))
          (EXIT
           (COND ((QEQCAR |rec| 1) (SPADCALL |f| |g| (QREFELT $ 31)))
                 ('T
                  (SPADCALL
                   (SPADCALL (QCDR |rec|) (SPADCALL |g| (QREFELT $ 17))
                             (QREFELT $ 32))
                   |f| (QREFELT $ 29)))))))) 

(SDEFUN |EXPEXPAN;coerce;Ups$;7|
        ((|f| (|UnivariatePuiseuxSeries| FE |var| |cen|)) ($ ($)))
        (SPADCALL (SPADCALL |f| (QREFELT $ 35)) (QREFELT $ 28))) 

(SDEFUN |EXPEXPAN;seriesQuotientLimit|
        ((|num| (|UnivariatePuiseuxSeries| FE |var| |cen|))
         (|den| (|UnivariatePuiseuxSeries| FE |var| |cen|))
         ($ (|Union| (|OrderedCompletion| FE) "failed")))
        (SPROG
         ((#1=#:G758 NIL) (|sig| (|Union| (|Integer|) "failed")) (|coef| (FE))
          (|ord| (|Fraction| (|Integer|)))
          (|series| (|UnivariatePuiseuxSeries| FE |var| |cen|)))
         (SEQ
          (EXIT
           (SEQ (LETT |series| (SPADCALL |num| |den| (QREFELT $ 37)))
                (LETT |ord|
                      (SPADCALL |series| (|spadConstant| $ 38) (QREFELT $ 39)))
                (EXIT
                 (COND
                  ((SPADCALL |ord| (|spadConstant| $ 41) (QREFELT $ 42))
                   (CONS 0 (SPADCALL (|spadConstant| $ 40) (QREFELT $ 44))))
                  (#2='T
                   (SEQ (LETT |coef| (SPADCALL |series| |ord| (QREFELT $ 45)))
                        (EXIT
                         (COND
                          ((SPADCALL (QREFELT $ 8)
                                     (SPADCALL |coef| (QREFELT $ 47))
                                     (QREFELT $ 49))
                           (CONS 1 "failed"))
                          ((SPADCALL |ord| (|spadConstant| $ 41)
                                     (QREFELT $ 50))
                           (CONS 0 (SPADCALL |coef| (QREFELT $ 44))))
                          (#2#
                           (SEQ (LETT |sig| (SPADCALL |coef| (QREFELT $ 53)))
                                (EXIT
                                 (COND
                                  ((QEQCAR |sig| 1)
                                   (PROGN
                                    (LETT #1# (CONS 1 "failed"))
                                    (GO #3=#:G757)))
                                  ((EQL (QCDR |sig|) 1)
                                   (CONS 0 (SPADCALL (QREFELT $ 54))))
                                  (#2#
                                   (CONS 0
                                         (SPADCALL
                                          (QREFELT $ 55))))))))))))))))
          #3# (EXIT #1#)))) 

(SDEFUN |EXPEXPAN;seriesQuotientInfinity|
        ((|num| (|UnivariatePuiseuxSeries| FE |var| |cen|))
         (|den| (|UnivariatePuiseuxSeries| FE |var| |cen|))
         ($ (|Union| (|OrderedCompletion| FE) "failed")))
        (SPROG
         ((#1=#:G771 NIL) (|sig| (|Union| (|Integer|) "failed")) (|cc| (FE))
          (|denOrd| #2=(|Fraction| (|Integer|))) (|numOrd| #2#))
         (SEQ
          (EXIT
           (SEQ (LETT |numOrd| (SPADCALL |num| (QREFELT $ 15) (QREFELT $ 39)))
                (EXIT
                 (COND
                  ((SPADCALL |numOrd| (QREFELT $ 15) (QREFELT $ 50))
                   (CONS 1 "failed"))
                  (#3='T
                   (SEQ
                    (LETT |denOrd|
                          (SPADCALL |den| (QREFELT $ 15) (QREFELT $ 39)))
                    (EXIT
                     (COND
                      ((SPADCALL |denOrd| (QREFELT $ 15) (QREFELT $ 50))
                       (CONS 1 "failed"))
                      (#3#
                       (SEQ
                        (LETT |cc|
                              (SPADCALL
                               (SPADCALL |num| |numOrd| (QREFELT $ 45))
                               (SPADCALL |den| |denOrd| (QREFELT $ 45))
                               (QREFELT $ 56)))
                        (EXIT
                         (COND
                          ((SPADCALL (QREFELT $ 8)
                                     (SPADCALL |cc| (QREFELT $ 47))
                                     (QREFELT $ 49))
                           (CONS 1 "failed"))
                          (#3#
                           (SEQ (LETT |sig| (SPADCALL |cc| (QREFELT $ 53)))
                                (EXIT
                                 (COND
                                  ((QEQCAR |sig| 1)
                                   (PROGN
                                    (LETT #1# (CONS 1 "failed"))
                                    (GO #4=#:G770)))
                                  ((EQL (QCDR |sig|) 1)
                                   (CONS 0 (SPADCALL (QREFELT $ 54))))
                                  (#3#
                                   (CONS 0
                                         (SPADCALL
                                          (QREFELT $ 55))))))))))))))))))))
          #4# (EXIT #1#)))) 

(SDEFUN |EXPEXPAN;limitPlus;$U;10|
        ((|f| ($)) ($ (|Union| (|OrderedCompletion| FE) "failed")))
        (SPROG
         ((#1=#:G797 NIL) (|sig| (|Union| (|Integer|) "failed"))
          (|expCoef| (FE))
          (|exponDiff| (|ExponentialOfUnivariatePuiseuxSeries| FE |var| |cen|))
          (|denCoef| #2=(|UnivariatePuiseuxSeries| FE |var| |cen|))
          (|numCoef| #2#)
          (|denExpon|
           #3=(|ExponentialOfUnivariatePuiseuxSeries| FE |var| |cen|))
          (|numExpon| #3#) (|denType| #4=(|String|))
          (|denTerm|
           (|Record|
            (|:| |%term|
                 (|Record|
                  (|:| |%coef| (|UnivariatePuiseuxSeries| FE |var| |cen|))
                  (|:| |%expon|
                       (|ExponentialOfUnivariatePuiseuxSeries| FE |var| |cen|))
                  (|:| |%expTerms|
                       (|List|
                        (|Record| (|:| |k| (|Fraction| (|Integer|)))
                                  (|:| |c| FE))))))
            (|:| |%type| (|String|))))
          (|denomTerm|
           #5=(|Union|
               (|Record|
                (|:| |%term|
                     (|Record|
                      (|:| |%coef| (|UnivariatePuiseuxSeries| FE |var| |cen|))
                      (|:| |%expon|
                           (|ExponentialOfUnivariatePuiseuxSeries| FE |var|
                                                                   |cen|))
                      (|:| |%expTerms|
                           (|List|
                            (|Record| (|:| |k| (|Fraction| (|Integer|)))
                                      (|:| |c| FE))))))
                (|:| |%type| #4#))
               "failed"))
          (|numType| #4#)
          (|numTerm|
           (|Record|
            (|:| |%term|
                 (|Record|
                  (|:| |%coef| (|UnivariatePuiseuxSeries| FE |var| |cen|))
                  (|:| |%expon|
                       (|ExponentialOfUnivariatePuiseuxSeries| FE |var| |cen|))
                  (|:| |%expTerms|
                       (|List|
                        (|Record| (|:| |k| (|Fraction| (|Integer|)))
                                  (|:| |c| FE))))))
            (|:| |%type| (|String|))))
          (|numerTerm| #5#)
          (|num|
           (|UnivariatePuiseuxSeriesWithExponentialSingularity| R FE |var|
                                                                |cen|))
          (|den|
           (|UnivariatePuiseuxSeriesWithExponentialSingularity| R FE |var|
                                                                |cen|)))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |f| (QREFELT $ 57))
             (CONS 0 (SPADCALL (|spadConstant| $ 40) (QREFELT $ 44))))
            (#6='T
             (SEQ (LETT |den| (SPADCALL |f| (QREFELT $ 17)))
                  (EXIT
                   (COND
                    ((SPADCALL |den| (|spadConstant| $ 18) (QREFELT $ 20))
                     (SPADCALL (SPADCALL |f| (QREFELT $ 21)) (QREFELT $ 59)))
                    (#6#
                     (SEQ
                      (LETT |numerTerm|
                            (SPADCALL
                             (LETT |num| (SPADCALL |f| (QREFELT $ 21)))
                             (QREFELT $ 64)))
                      (EXIT
                       (COND ((QEQCAR |numerTerm| 1) (CONS 1 "failed"))
                             (#6#
                              (SEQ
                               (LETT |numType|
                                     (QCDR
                                      (LETT |numTerm| (QCDR |numerTerm|))))
                               (LETT |denomTerm|
                                     (SPADCALL |den| (QREFELT $ 64)))
                               (EXIT
                                (COND
                                 ((QEQCAR |denomTerm| 1) (CONS 1 "failed"))
                                 (#6#
                                  (SEQ
                                   (LETT |denType|
                                         (QCDR
                                          (LETT |denTerm| (QCDR |denomTerm|))))
                                   (LETT |numExpon|
                                         (|EXPEXPAN;exponent| (QCAR |numTerm|)
                                          $))
                                   (LETT |denExpon|
                                         (|EXPEXPAN;exponent| (QCAR |denTerm|)
                                          $))
                                   (LETT |numCoef|
                                         (|EXPEXPAN;coeff| (QCAR |numTerm|) $))
                                   (LETT |denCoef|
                                         (|EXPEXPAN;coeff| (QCAR |denTerm|) $))
                                   (EXIT
                                    (COND
                                     ((EQUAL |numType| "zero")
                                      (COND
                                       ((EQUAL |denType| "zero")
                                        (SEQ
                                         (LETT |exponDiff|
                                               (SPADCALL |numExpon| |denExpon|
                                                         (QREFELT $ 66)))
                                         (EXIT
                                          (COND
                                           ((SPADCALL |exponDiff|
                                                      (|spadConstant| $ 67)
                                                      (QREFELT $ 68))
                                            (|EXPEXPAN;seriesQuotientLimit|
                                             |numCoef| |denCoef| $))
                                           (#6#
                                            (SEQ
                                             (LETT |expCoef|
                                                   (SPADCALL |exponDiff|
                                                             (SPADCALL
                                                              |exponDiff|
                                                              (QREFELT $ 69))
                                                             (QREFELT $ 70)))
                                             (LETT |sig|
                                                   (SPADCALL |expCoef|
                                                             (QREFELT $ 53)))
                                             (EXIT
                                              (COND
                                               ((QEQCAR |sig| 1)
                                                (PROGN
                                                 (LETT #1# (CONS 1 "failed"))
                                                 (GO #7=#:G796)))
                                               ((EQL (QCDR |sig|) -1)
                                                (CONS 0
                                                      (SPADCALL
                                                       (|spadConstant| $ 40)
                                                       (QREFELT $ 44))))
                                               (#6#
                                                (|EXPEXPAN;seriesQuotientInfinity|
                                                 |numCoef| |denCoef|
                                                 $))))))))))
                                       (#6#
                                        (CONS 0
                                              (SPADCALL (|spadConstant| $ 40)
                                                        (QREFELT $ 44))))))
                                     ((EQUAL |numType| "series")
                                      (COND
                                       ((EQUAL |denType| "zero")
                                        (|EXPEXPAN;seriesQuotientInfinity|
                                         |numCoef| |denCoef| $))
                                       ((EQUAL |denType| "series")
                                        (|EXPEXPAN;seriesQuotientLimit|
                                         |numCoef| |denCoef| $))
                                       (#6#
                                        (CONS 0
                                              (SPADCALL (|spadConstant| $ 40)
                                                        (QREFELT $ 44))))))
                                     ((EQUAL |denType| "infinity")
                                      (SEQ
                                       (LETT |exponDiff|
                                             (SPADCALL |numExpon| |denExpon|
                                                       (QREFELT $ 66)))
                                       (EXIT
                                        (COND
                                         ((SPADCALL |exponDiff|
                                                    (|spadConstant| $ 67)
                                                    (QREFELT $ 68))
                                          (|EXPEXPAN;seriesQuotientLimit|
                                           |numCoef| |denCoef| $))
                                         (#6#
                                          (SEQ
                                           (LETT |expCoef|
                                                 (SPADCALL |exponDiff|
                                                           (SPADCALL
                                                            |exponDiff|
                                                            (QREFELT $ 69))
                                                           (QREFELT $ 70)))
                                           (LETT |sig|
                                                 (SPADCALL |expCoef|
                                                           (QREFELT $ 53)))
                                           (EXIT
                                            (COND
                                             ((QEQCAR |sig| 1)
                                              (PROGN
                                               (LETT #1# (CONS 1 "failed"))
                                               (GO #7#)))
                                             ((EQL (QCDR |sig|) -1)
                                              (CONS 0
                                                    (SPADCALL
                                                     (|spadConstant| $ 40)
                                                     (QREFELT $ 44))))
                                             (#6#
                                              (|EXPEXPAN;seriesQuotientInfinity|
                                               |numCoef| |denCoef| $))))))))))
                                     (#6#
                                      (|EXPEXPAN;seriesQuotientInfinity|
                                       |numCoef| |denCoef|
                                       $))))))))))))))))))))
          #7# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |ExponentialExpansion;|)) 

(DEFUN |ExponentialExpansion| (&REST #1=#:G845)
  (SPROG NIL
         (PROG (#2=#:G846)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T T NIL NIL))
                     (HGET |$ConstructorCache| '|ExponentialExpansion|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ExponentialExpansion;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|ExponentialExpansion|)))))))))) 

(DEFUN |ExponentialExpansion;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) (#1=#:G844 NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL)
    (DV$2 NIL) (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 |#3|)
    (LETT DV$4 |#4|)
    (LETT |dv$| (LIST '|ExponentialExpansion| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 114))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         '(|PolynomialFactorizationExplicit|))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         '(|RetractableTo| (|Symbol|)))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         '(|CharacteristicNonZero|))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         '(|CharacteristicZero|))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         '(|ConvertibleTo| (|InputForm|)))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         '(|RealConstant|))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         '(|OrderedIntegralDomain|))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         '(|OrderedSet|))
                                        (OR
                                         (|HasCategory|
                                          (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                           |#1| |#2| |#3| |#4|)
                                          '(|OrderedIntegralDomain|))
                                         (|HasCategory|
                                          (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                           |#1| |#2| |#3| |#4|)
                                          '(|OrderedSet|)))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         '(|RetractableTo| (|Integer|)))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         '(|StepThrough|))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         (LIST '|InnerEvalable| '(|Symbol|)
                                               (LIST
                                                '|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                                (|devaluate| |#1|)
                                                (|devaluate| |#2|)
                                                (|devaluate| |#3|)
                                                (|devaluate| |#4|))))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         (LIST '|Evalable|
                                               (LIST
                                                '|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                                (|devaluate| |#1|)
                                                (|devaluate| |#2|)
                                                (|devaluate| |#3|)
                                                (|devaluate| |#4|))))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         (LIST '|Eltable|
                                               (LIST
                                                '|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                                (|devaluate| |#1|)
                                                (|devaluate| |#2|)
                                                (|devaluate| |#3|)
                                                (|devaluate| |#4|))
                                               (LIST
                                                '|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                                (|devaluate| |#1|)
                                                (|devaluate| |#2|)
                                                (|devaluate| |#3|)
                                                (|devaluate| |#4|))))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         '(|PartialDifferentialRing|
                                           (|Symbol|)))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         '(|DifferentialRing|))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         '(|LinearlyExplicitOver| (|Integer|)))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         '(|ConvertibleTo|
                                           (|Pattern| (|Float|))))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         '(|ConvertibleTo|
                                           (|Pattern| (|Integer|))))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         '(|PatternMatchable| (|Float|)))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         '(|PatternMatchable| (|Integer|)))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         '(|EuclideanDomain|))
                                        (|HasCategory|
                                         (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                          |#1| |#2| |#3| |#4|)
                                         '(|IntegerNumberSystem|))
                                        (LETT #1#
                                              (|HasCategory|
                                               (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                                |#1| |#2| |#3| |#4|)
                                               '(|Comparable|)))
                                        (OR #1#
                                            (|HasCategory|
                                             (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                              |#1| |#2| |#3| |#4|)
                                             '(|OrderedIntegralDomain|))
                                            (|HasCategory|
                                             (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                              |#1| |#2| |#3| |#4|)
                                             '(|OrderedSet|)))))))
    (|haddProp| |$ConstructorCache| '|ExponentialExpansion|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (AND (|HasCategory| $ '(|CharacteristicNonZero|))
         (|HasCategory|
          (|UnivariatePuiseuxSeriesWithExponentialSingularity| |#1| |#2| |#3|
                                                               |#4|)
          '(|PolynomialFactorizationExplicit|))
         (|augmentPredVector| $ 33554432))
    (AND
     (OR
      (AND (|HasCategory| $ '(|CharacteristicNonZero|))
           (|HasCategory|
            (|UnivariatePuiseuxSeriesWithExponentialSingularity| |#1| |#2| |#3|
                                                                 |#4|)
            '(|PolynomialFactorizationExplicit|)))
      (|HasCategory|
       (|UnivariatePuiseuxSeriesWithExponentialSingularity| |#1| |#2| |#3|
                                                            |#4|)
       '(|CharacteristicNonZero|)))
     (|augmentPredVector| $ 67108864))
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 10
              (|Fraction|
               (|UnivariatePuiseuxSeriesWithExponentialSingularity| |#1| |#2|
                                                                    |#3|
                                                                    |#4|)))
    (QSETREFV $ 15 (SPADCALL 1000 1 (QREFELT $ 14)))
    $))) 

(MAKEPROP '|ExponentialExpansion| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|Fraction| 16) (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) '|Rep| (0 . |One|) (|Integer|)
              (|Fraction| 12) (4 . /) 'ZEROCOUNT
              (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7
                                                                   (NRTEVAL
                                                                    (QREFELT $
                                                                             8))
                                                                   (NRTEVAL
                                                                    (QREFELT $
                                                                             9)))
              (10 . |denom|) (15 . |One|) (|Boolean|) (19 . =) (25 . |numer|)
              (|Union| 34 '"failed") (30 . |retractIfCan|)
              |EXPEXPAN;retractIfCan;$U;4| (|Union| $ '"failed") (35 . |recip|)
              (40 . /) (46 . |coerce|) (51 . *) |EXPEXPAN;/;2Upswes$;5|
              (57 . /) (63 . *) |EXPEXPAN;/;3$;6|
              (|UnivariatePuiseuxSeries| 7 (NRTEVAL (QREFELT $ 8))
                                         (NRTEVAL (QREFELT $ 9)))
              (69 . |coerce|) |EXPEXPAN;coerce;Ups$;7| (74 . /) (80 . |One|)
              (84 . |order|) (90 . |Zero|) (94 . |Zero|) (98 . >)
              (|OrderedCompletion| 7) (104 . |coerce|) (109 . |coefficient|)
              (|List| 48) (115 . |variables|) (|Symbol|) (120 . |member?|)
              (126 . =) (|Union| 12 '"failed") (|ElementaryFunctionSign| 6 7)
              (132 . |sign|) (137 . |plusInfinity|) (141 . |minusInfinity|)
              (145 . /) (151 . |zero?|) (|Union| 43 '"failed")
              (156 . |limitPlus|) (|Record| (|:| |k| 13) (|:| |c| 7))
              (|Record| (|:| |%coef| 34) (|:| |%expon| 65)
                        (|:| |%expTerms| (|List| 60)))
              (|Record| (|:| |%term| 61) (|:| |%type| 110))
              (|Union| 62 '"failed") (161 . |dominantTerm|)
              (|ExponentialOfUnivariatePuiseuxSeries| 7 (NRTEVAL (QREFELT $ 8))
                                                      (NRTEVAL (QREFELT $ 9)))
              (166 . -) (172 . |Zero|) (176 . =) (182 . |order|)
              (187 . |coefficient|) |EXPEXPAN;limitPlus;$U;10|
              (|Union| 82 '#1="failed") (|Matrix| $) (|InputForm|)
              (|Pattern| 92) (|Pattern| 12) (|NonNegativeInteger|) (|List| 79)
              (|Equation| 16) (|List| 16)
              (|Record| (|:| |mat| 83) (|:| |vec| (|Vector| 12))) (|Vector| $)
              (|Matrix| 12) (|List| 77) (|PatternMatchResult| 92 $)
              (|PatternMatchResult| 12 $) (|Factored| 88)
              (|SparseUnivariatePolynomial| $) (|Union| 90 '#1#) (|List| 88)
              (|DoubleFloat|) (|Float|) (|Union| 13 '#2="failed")
              (|Union| 48 '#2#) (|Matrix| 16)
              (|Record| (|:| |mat| 95) (|:| |vec| (|Vector| 16)))
              (|Mapping| 16 16) (|Union| 16 '#2#) (|Factored| $)
              (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 100 '#3="failed") (|Union| 103 '#3#) (|List| $)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (|Record| (|:| |coef| 103) (|:| |generator| $))
              (|Record| (|:| |llcm_res| $) (|:| |coeff1| $) (|:| |coeff2| $))
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (|PositiveInteger|) (|String|) (|SingleInteger|) (|HashState|)
              (|OutputForm|))
           '#(~= 193 |zero?| 199 |wholePart| 204 |unitNormal| 209
              |unitCanonical| 214 |unit?| 219 |subtractIfCan| 224
              |squareFreePolynomial| 230 |squareFreePart| 235 |squareFree| 240
              |solveLinearPolynomialEquation| 245 |smaller?| 251 |sizeLess?|
              257 |sign| 263 |sample| 268 |rightRecip| 272 |rightPower| 277
              |retractIfCan| 289 |retract| 314 |rem| 339 |reducedSystem| 345
              |recip| 367 |quo| 372 |principalIdeal| 378 |prime?| 383
              |positive?| 388 |patternMatch| 393 |opposite?| 407 |one?| 413
              |numerator| 418 |numer| 423 |nextItem| 428 |negative?| 433
              |multiEuclidean| 438 |min| 444 |max| 450 |map| 456 |limitPlus|
              462 |leftRecip| 467 |leftPower| 472 |lcmCoef| 484 |lcm| 490
              |latex| 501 |inv| 506 |init| 511 |hashUpdate!| 515 |hash| 521
              |gcdPolynomial| 526 |gcd| 532 |fractionPart| 543 |floor| 548
              |factorSquareFreePolynomial| 553 |factorPolynomial| 558 |factor|
              563 |extendedEuclidean| 568 |exquo| 581 |expressIdealMember| 587
              |eval| 593 |euclideanSize| 633 |elt| 638 |divide| 644
              |differentiate| 650 |denominator| 700 |denom| 705 |convert| 710
              |conditionP| 735 |commutator| 740 |coerce| 746 |charthRoot| 781
              |characteristic| 786 |ceiling| 790 |associator| 795 |associates?|
              802 |antiCommutator| 808 |annihilate?| 814 |abs| 820 ^ 825 |Zero|
              843 |One| 847 D 851 >= 901 > 907 = 913 <= 919 < 925 / 931 - 943 +
              954 * 960)
           'NIL
           (CONS
            (|makeByteWordVec2| 25
                                '(0 0 0 1 0 0 0 7 0 0 0 0 0 0 7 0 0 0 0 0 3 4
                                  15 16 17 0 0 0 0 0 0 0 0 0 0 0 7 0 0 0 0 0 0
                                  0 7 0 7 0 0 0 7 0 0 0 0 0 9 0 0 0 25 11 20 21
                                  0 0 0 0 0 2 6 10 10 13 0 0 0 0 0 0 0 0 0 0 2
                                  5 6 6 8 10 10 12 13 14 18 19))
            (CONS
             '#(|QuotientFieldCategory&| |Field&| |EuclideanDomain&|
                |PolynomialFactorizationExplicit&| NIL
                |UniqueFactorizationDomain&| |GcdDomain&| NIL NIL
                |FullyLinearlyExplicitOver&| |DifferentialExtension&|
                |DivisionRing&| NIL NIL |OrderedRing&| NIL |Algebra&|
                |Algebra&| |EntireRing&| |Algebra&| NIL NIL
                |PartialDifferentialRing&| |DifferentialRing&| NIL NIL |Rng&|
                NIL |Module&| |Module&| |Module&| NIL NIL NIL NIL
                |NonAssociativeRing&| NIL NIL NIL NIL NIL NIL
                |NonAssociativeRng&| NIL NIL |AbelianGroup&| NIL NIL NIL NIL
                NIL NIL NIL |MagmaWithUnit&| |NonAssociativeSemiRng&|
                |AbelianMonoid&| |OrderedSet&| |FullyEvalableOver&| |Magma&|
                |AbelianSemiGroup&| NIL NIL NIL NIL |RetractableTo&| NIL
                |RetractableTo&| NIL |SetCategory&| |RetractableTo&| NIL
                |RetractableTo&| |RetractableTo&| |Evalable&| NIL NIL NIL NIL
                NIL NIL NIL NIL |BasicType&| NIL NIL NIL NIL NIL
                |PartialOrder&| NIL NIL |InnerEvalable&| |InnerEvalable&| NIL
                NIL NIL)
             (CONS
              '#((|QuotientFieldCategory|
                  (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7 8
                                                                       9))
                 (|Field|) (|EuclideanDomain|)
                 (|PolynomialFactorizationExplicit|) (|PrincipalIdealDomain|)
                 (|UniqueFactorizationDomain|) (|GcdDomain|)
                 (|OrderedIntegralDomain|) (|IntegralDomain|)
                 (|FullyLinearlyExplicitOver|
                  (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7 8
                                                                       9))
                 (|DifferentialExtension|
                  (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7 8
                                                                       9))
                 (|DivisionRing|) (|CommutativeRing|) (|LeftOreRing|)
                 (|OrderedRing|)
                 (|LinearlyExplicitOver|
                  (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7 8
                                                                       9))
                 (|Algebra|
                  (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7 8
                                                                       9))
                 (|Algebra| 13) (|EntireRing|) (|Algebra| $$)
                 (|CharacteristicNonZero|) (|CharacteristicZero|)
                 (|PartialDifferentialRing| 48) (|DifferentialRing|)
                 (|LinearlyExplicitOver| 12) (|Ring|) (|Rng|) (|SemiRing|)
                 (|Module|
                  (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7 8
                                                                       9))
                 (|Module| 13) (|Module| $$) (|SemiRng|)
                 (|BiModule|
                  (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7 8 9)
                  (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7 8
                                                                       9))
                 (|BiModule| 13 13) (|BiModule| $$ $$) (|NonAssociativeRing|)
                 (|OrderedAbelianGroup|)
                 (|RightModule|
                  (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7 8
                                                                       9))
                 (|LeftModule|
                  (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7 8
                                                                       9))
                 (|RightModule| 13) (|LeftModule| 13) (|LeftModule| $$)
                 (|NonAssociativeRng|) (|RightModule| $$)
                 (|OrderedCancellationAbelianMonoid|) (|AbelianGroup|)
                 (|OrderedAbelianMonoid|) (|Monoid|) (|NonAssociativeSemiRing|)
                 (|CancellationAbelianMonoid|) (|OrderedAbelianSemiGroup|)
                 (|FullyPatternMatchable|
                  (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7 8
                                                                       9))
                 (|SemiGroup|) (|MagmaWithUnit|) (|NonAssociativeSemiRng|)
                 (|AbelianMonoid|) (|OrderedSet|)
                 (|FullyEvalableOver|
                  (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7 8
                                                                       9))
                 (|Magma|) (|AbelianSemiGroup|) (|Comparable|) (|StepThrough|)
                 (|PatternMatchable| 92) (|PatternMatchable| 12)
                 (|RetractableTo| (|UnivariatePuiseuxSeries| 7 8 9))
                 (|Patternable|
                  (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7 8
                                                                       9))
                 (|RetractableTo|
                  (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7 8
                                                                       9))
                 (|CommutativeStar|) (|SetCategory|) (|RetractableTo| 48)
                 (|RealConstant|) (|RetractableTo| 13) (|RetractableTo| 12)
                 (|Evalable|
                  (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7 8
                                                                       9))
                 (|CoercibleFrom| (|UnivariatePuiseuxSeries| 7 8 9)) (|Type|)
                 (|CoercibleFrom|
                  (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7 8
                                                                       9))
                 (|canonicalsClosed|) (|canonicalUnitNormal|)
                 (|noZeroDivisors|) (|TwoSidedRecip|) (|unitsKnown|)
                 (|BasicType|) (|CoercibleTo| 113) (|CoercibleFrom| 48)
                 (|ConvertibleTo| 74) (|ConvertibleTo| 91) (|ConvertibleTo| 92)
                 (|PartialOrder|) (|CoercibleFrom| 13) (|CoercibleFrom| 12)
                 (|InnerEvalable| 48
                                  (|UnivariatePuiseuxSeriesWithExponentialSingularity|
                                   6 7 8 9))
                 (|InnerEvalable|
                  (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7 8 9)
                  (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7 8
                                                                       9))
                 (|Eltable|
                  (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7 8 9)
                  $$)
                 (|ConvertibleTo| 75) (|ConvertibleTo| 76))
              (|makeByteWordVec2| 113
                                  '(0 7 0 11 2 13 0 12 12 14 1 0 16 0 17 0 16 0
                                    18 2 16 19 0 0 20 1 0 16 0 21 1 16 22 0 23
                                    1 16 25 0 26 2 10 0 16 16 27 1 0 0 16 28 2
                                    0 0 16 0 29 2 10 0 0 0 31 2 16 0 0 0 32 1
                                    16 0 34 35 2 34 0 0 0 37 0 13 0 38 2 34 13
                                    0 13 39 0 7 0 40 0 13 0 41 2 13 19 0 0 42 1
                                    43 0 7 44 2 34 7 0 13 45 1 7 46 0 47 2 46
                                    19 48 0 49 2 13 19 0 0 50 1 52 51 7 53 0 43
                                    0 54 0 43 0 55 2 7 0 0 0 56 1 0 19 0 57 1
                                    16 58 0 59 1 16 63 0 64 2 65 0 0 0 66 0 65
                                    0 67 2 65 19 0 0 68 1 65 13 0 69 2 65 7 0
                                    13 70 2 0 19 0 0 1 1 0 19 0 57 1 22 16 0 1
                                    1 0 108 0 1 1 0 0 0 1 1 0 19 0 1 2 0 25 0 0
                                    1 1 1 87 88 1 1 0 0 0 1 1 0 99 0 1 2 1 89
                                    90 88 1 2 24 19 0 0 1 2 0 19 0 0 1 1 7 12 0
                                    1 0 0 0 1 1 0 25 0 1 2 0 0 0 77 1 2 0 0 0
                                    109 1 1 10 51 0 1 1 10 93 0 1 1 2 94 0 1 1
                                    0 22 0 24 1 0 98 0 1 1 10 12 0 1 1 10 13 0
                                    1 1 2 48 0 1 1 0 34 0 1 1 0 16 0 1 2 0 0 0
                                    0 1 2 17 81 73 82 1 1 17 83 73 1 1 0 95 73
                                    1 2 0 96 73 82 1 1 0 25 0 1 2 0 0 0 0 1 1 0
                                    106 103 1 1 0 19 0 1 1 7 19 0 1 3 20 85 0
                                    75 85 1 3 21 86 0 76 86 1 2 0 19 0 0 1 1 0
                                    19 0 1 1 0 0 0 1 1 0 16 0 21 1 11 25 0 1 1
                                    7 19 0 1 2 0 102 103 0 1 2 8 0 0 0 1 2 8 0
                                    0 0 1 2 0 0 97 0 1 1 0 58 0 71 1 0 25 0 1 2
                                    0 0 0 77 1 2 0 0 0 109 1 2 0 107 0 0 1 2 0
                                    0 0 0 1 1 0 0 103 1 1 0 110 0 1 1 0 0 0 1 0
                                    11 0 1 2 0 112 112 0 1 1 0 111 0 1 2 0 88
                                    88 88 1 2 0 0 0 0 1 1 0 0 103 1 1 22 0 0 1
                                    1 23 16 0 1 1 1 87 88 1 1 1 87 88 1 1 0 99
                                    0 1 3 0 101 0 0 0 1 2 0 104 0 0 1 2 0 25 0
                                    0 1 2 0 102 103 0 1 2 13 0 0 78 1 2 13 0 0
                                    79 1 3 13 0 0 80 80 1 3 13 0 0 16 16 1 3 12
                                    0 0 48 16 1 3 12 0 0 46 80 1 1 0 77 0 1 2
                                    14 0 0 16 1 2 0 105 0 0 1 2 16 0 0 77 1 1
                                    16 0 0 1 3 15 0 0 48 77 1 3 15 0 0 46 84 1
                                    2 15 0 0 46 1 2 15 0 0 48 1 2 0 0 0 97 1 3
                                    0 0 0 97 77 1 1 0 0 0 1 1 0 16 0 17 1 5 74
                                    0 1 1 18 75 0 1 1 19 76 0 1 1 6 91 0 1 1 6
                                    92 0 1 1 26 72 73 1 2 0 0 0 0 1 1 2 0 48 1
                                    1 0 0 34 36 1 0 0 16 28 1 0 0 13 1 1 0 0 0
                                    1 1 0 0 12 1 1 0 113 0 1 1 27 25 0 1 0 0 77
                                    1 1 23 16 0 1 3 0 0 0 0 0 1 2 0 19 0 0 1 2
                                    0 0 0 0 1 2 0 19 0 0 1 1 7 0 0 1 2 0 0 0 12
                                    1 2 0 0 0 77 1 2 0 0 0 109 1 0 0 0 1 0 0 0
                                    1 2 16 0 0 77 1 1 16 0 0 1 3 15 0 0 48 77 1
                                    3 15 0 0 46 84 1 2 15 0 0 48 1 2 15 0 0 46
                                    1 3 0 0 0 97 77 1 2 0 0 0 97 1 2 8 19 0 0 1
                                    2 8 19 0 0 1 2 0 19 0 0 1 2 8 19 0 0 1 2 8
                                    19 0 0 1 2 0 0 16 16 30 2 0 0 0 0 33 1 0 0
                                    0 1 2 0 0 0 0 1 2 0 0 0 0 1 2 0 0 0 16 1 2
                                    0 0 16 0 29 2 0 0 13 0 1 2 0 0 0 13 1 2 0 0
                                    77 0 1 2 0 0 12 0 1 2 0 0 0 0 1 2 0 0 109 0
                                    1)))))
           '|lookupComplete|)) 
