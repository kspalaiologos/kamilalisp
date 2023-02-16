
(SDEFUN |FS2EXPXP;ratIfCan|
        ((|fcn| (FE)) ($ (|Union| (|Fraction| (|Integer|)) "failed")))
        (SPADCALL |fcn| (QREFELT $ 16))) 

(SDEFUN |FS2EXPXP;stateSeriesProblem|
        ((|function| (|String|)) (|problem| (|String|))
         ($
          (|Union| (|:| |%series| (|UnivariatePuiseuxSeries| FE |x| |cen|))
                   (|:| |%problem|
                        (|Record| (|:| |func| (|String|))
                                  (|:| |prob| (|String|)))))))
        (CONS 1 (CONS |function| |problem|))) 

(SDEFUN |FS2EXPXP;stateProblem|
        ((|function| (|String|)) (|problem| (|String|))
         ($
          (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                   (|:| |%problem|
                        (|Record| (|:| |func| (|String|))
                                  (|:| |prob| (|String|)))))))
        (CONS 1 (CONS |function| |problem|))) 

(SDEFUN |FS2EXPXP;newElem| ((|f| (FE)) ($ (FE)))
        (SPADCALL (|FS2EXPXP;smpElem| (SPADCALL |f| (QREFELT $ 18)) $)
                  (|FS2EXPXP;smpElem| (SPADCALL |f| (QREFELT $ 19)) $)
                  (QREFELT $ 20))) 

(SDEFUN |FS2EXPXP;smpElem|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| FE))) ($ (FE)))
        (SPADCALL (CONS (|function| |FS2EXPXP;k2Elem|) $) (ELT $ 21) |p|
                  (QREFELT $ 26))) 

(SDEFUN |FS2EXPXP;k2Elem| ((|k| (|Kernel| FE)) ($ (FE)))
        (SPROG
         ((|cosz| (FE)) (|sinz| (FE)) (|iez| (FE)) (|ez| (FE)) (|z| (FE))
          (|args| (|List| FE)) (#1=#:G817 NIL) (|a| NIL) (#2=#:G816 NIL))
         (SEQ
          (COND
           ((NULL
             (LETT |args|
                   (PROGN
                    (LETT #2# NIL)
                    (SEQ (LETT |a| NIL)
                         (LETT #1# (SPADCALL |k| (QREFELT $ 29))) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |a| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT #2# (CONS (|FS2EXPXP;newElem| |a| $) #2#))))
                         (LETT #1# (CDR #1#)) (GO G190) G191
                         (EXIT (NREVERSE #2#))))))
            (SPADCALL |k| (QREFELT $ 31)))
           (#3='T
            (SEQ
             (LETT |iez|
                   (SPADCALL
                    (LETT |ez|
                          (SPADCALL (LETT |z| (|SPADfirst| |args|))
                                    (QREFELT $ 32)))
                    (QREFELT $ 33)))
             (LETT |sinz| (SPADCALL |z| (QREFELT $ 34)))
             (LETT |cosz| (SPADCALL |z| (QREFELT $ 35)))
             (EXIT
              (COND
               ((SPADCALL |k| '|tan| (QREFELT $ 38))
                (SPADCALL |sinz| |cosz| (QREFELT $ 20)))
               ((SPADCALL |k| '|cot| (QREFELT $ 38))
                (SPADCALL |cosz| |sinz| (QREFELT $ 20)))
               ((SPADCALL |k| '|sec| (QREFELT $ 38))
                (SPADCALL |cosz| (QREFELT $ 33)))
               ((SPADCALL |k| '|csc| (QREFELT $ 38))
                (SPADCALL |sinz| (QREFELT $ 33)))
               ((SPADCALL |k| '|sinh| (QREFELT $ 38))
                (SPADCALL (SPADCALL |ez| |iez| (QREFELT $ 39))
                          (SPADCALL 2 (QREFELT $ 40)) (QREFELT $ 20)))
               ((SPADCALL |k| '|cosh| (QREFELT $ 38))
                (SPADCALL (SPADCALL |ez| |iez| (QREFELT $ 41))
                          (SPADCALL 2 (QREFELT $ 40)) (QREFELT $ 20)))
               ((SPADCALL |k| '|tanh| (QREFELT $ 38))
                (SPADCALL (SPADCALL |ez| |iez| (QREFELT $ 39))
                          (SPADCALL |ez| |iez| (QREFELT $ 41)) (QREFELT $ 20)))
               ((SPADCALL |k| '|coth| (QREFELT $ 38))
                (SPADCALL (SPADCALL |ez| |iez| (QREFELT $ 41))
                          (SPADCALL |ez| |iez| (QREFELT $ 39)) (QREFELT $ 20)))
               ((SPADCALL |k| '|sech| (QREFELT $ 38))
                (SPADCALL 2
                          (SPADCALL (SPADCALL |ez| |iez| (QREFELT $ 41))
                                    (QREFELT $ 33))
                          (QREFELT $ 43)))
               ((SPADCALL |k| '|csch| (QREFELT $ 38))
                (SPADCALL 2
                          (SPADCALL (SPADCALL |ez| |iez| (QREFELT $ 39))
                                    (QREFELT $ 33))
                          (QREFELT $ 43)))
               ((SPADCALL |k| '|acosh| (QREFELT $ 38))
                (SPADCALL
                 (SPADCALL
                  (SPADCALL
                   (SPADCALL (SPADCALL |z| 2 (QREFELT $ 44))
                             (|spadConstant| $ 10) (QREFELT $ 39))
                   (QREFELT $ 45))
                  |z| (QREFELT $ 41))
                 (QREFELT $ 46)))
               ((SPADCALL |k| '|atanh| (QREFELT $ 38))
                (SPADCALL
                 (SPADCALL
                  (SPADCALL (SPADCALL |z| (|spadConstant| $ 10) (QREFELT $ 41))
                            (SPADCALL (|spadConstant| $ 10) |z| (QREFELT $ 39))
                            (QREFELT $ 20))
                  (QREFELT $ 46))
                 (SPADCALL 2 (QREFELT $ 40)) (QREFELT $ 20)))
               ((SPADCALL |k| '|acoth| (QREFELT $ 38))
                (SPADCALL
                 (SPADCALL
                  (SPADCALL (SPADCALL |z| (|spadConstant| $ 10) (QREFELT $ 41))
                            (SPADCALL |z| (|spadConstant| $ 10) (QREFELT $ 39))
                            (QREFELT $ 20))
                  (QREFELT $ 46))
                 (SPADCALL 2 (QREFELT $ 40)) (QREFELT $ 20)))
               ((SPADCALL |k| '|asech| (QREFELT $ 38))
                (SPADCALL
                 (SPADCALL (SPADCALL |z| (QREFELT $ 33))
                           (SPADCALL
                            (SPADCALL
                             (SPADCALL (SPADCALL |z| 2 (QREFELT $ 44))
                                       (QREFELT $ 33))
                             (|spadConstant| $ 10) (QREFELT $ 39))
                            (QREFELT $ 45))
                           (QREFELT $ 41))
                 (QREFELT $ 46)))
               ((SPADCALL |k| '|acsch| (QREFELT $ 38))
                (SPADCALL
                 (SPADCALL (SPADCALL |z| (QREFELT $ 33))
                           (SPADCALL
                            (SPADCALL (|spadConstant| $ 10)
                                      (SPADCALL (SPADCALL |z| 2 (QREFELT $ 44))
                                                (QREFELT $ 33))
                                      (QREFELT $ 41))
                            (QREFELT $ 45))
                           (QREFELT $ 41))
                 (QREFELT $ 46)))
               (#3#
                (SPADCALL (SPADCALL |k| (QREFELT $ 48)) |args|
                          (QREFELT $ 50))))))))))) 

(SDEFUN |FS2EXPXP;exprToXXP;FEBU;7|
        ((|fcn| (FE)) (|posCheck?| (|Boolean|))
         ($
          (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                   (|:| |%problem|
                        (|Record| (|:| |func| (|String|))
                                  (|:| |prob| (|String|)))))))
        (|FS2EXPXP;iExprToXXP| (|FS2EXPXP;newElem| |fcn| $) |posCheck?| $)) 

(SDEFUN |FS2EXPXP;iExprToXXP|
        ((|fcn| (FE)) (|posCheck?| (|Boolean|))
         ($
          (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                   (|:| |%problem|
                        (|Record| (|:| |func| (|String|))
                                  (|:| |prob| (|String|)))))))
        (SPROG
         ((|ker| (|Union| (|Kernel| FE) #1="failed"))
          (|power| (|Record| (|:| |val| FE) (|:| |exponent| (|Integer|))))
          (|expt|
           (|Union| (|Record| (|:| |val| FE) (|:| |exponent| (|Integer|)))
                    "failed"))
          (|prod| (|Union| (|List| FE) #2="failed"))
          (|sum| (|Union| (|List| FE) #2#)) (#3=#:G845 NIL)
          (|poly| (|Union| (|Polynomial| R) #1#)))
         (SEQ (LETT |poly| (SPADCALL |fcn| (QREFELT $ 55)))
              (EXIT
               (COND
                ((QEQCAR |poly| 0)
                 (CONS 0
                       (SPADCALL
                        (PROG2
                            (LETT #3#
                                  (SPADCALL |fcn| NIL
                                            (CONS 1 "real: two sides")
                                            (QREFELT $ 59)))
                            (QCDR #3#)
                          (|check_union2| (QEQCAR #3# 0)
                                          (|UnivariatePuiseuxSeries|
                                           (QREFELT $ 7) (QREFELT $ 8)
                                           (QREFELT $ 9))
                                          (|Union|
                                           (|:| |%series|
                                                (|UnivariatePuiseuxSeries|
                                                 (QREFELT $ 7) (QREFELT $ 8)
                                                 (QREFELT $ 9)))
                                           (|:| |%problem|
                                                (|Record|
                                                 (|:| |func| (|String|))
                                                 (|:| |prob| (|String|)))))
                                          #3#))
                        (QREFELT $ 62))))
                (#4='T
                 (SEQ (LETT |sum| (SPADCALL |fcn| (QREFELT $ 64)))
                      (EXIT
                       (COND
                        ((QEQCAR |sum| 0)
                         (|FS2EXPXP;listToXXP| (QCDR |sum|) |posCheck?|
                          (|spadConstant| $ 65) (ELT $ 66) $))
                        (#4#
                         (SEQ (LETT |prod| (SPADCALL |fcn| (QREFELT $ 67)))
                              (EXIT
                               (COND
                                ((QEQCAR |prod| 0)
                                 (|FS2EXPXP;listToXXP| (QCDR |prod|)
                                  |posCheck?| (|spadConstant| $ 68) (ELT $ 69)
                                  $))
                                (#4#
                                 (SEQ
                                  (LETT |expt|
                                        (|FS2EXPXP;isNonTrivPower| |fcn| $))
                                  (EXIT
                                   (COND
                                    ((QEQCAR |expt| 0)
                                     (SEQ (LETT |power| (QCDR |expt|))
                                          (EXIT
                                           (|FS2EXPXP;powerToXXP|
                                            (QCAR |power|) (QCDR |power|)
                                            |posCheck?| $))))
                                    (#4#
                                     (SEQ
                                      (LETT |ker|
                                            (SPADCALL |fcn| (QREFELT $ 71)))
                                      (EXIT
                                       (COND
                                        ((QEQCAR |ker| 0)
                                         (|FS2EXPXP;kernelToXXP| (QCDR |ker|)
                                          |posCheck?| $))
                                        (#4#
                                         (|error|
                                          "exprToXXP: neither a sum, product, power, nor kernel"))))))))))))))))))))))) 

(SDEFUN |FS2EXPXP;listToXXP|
        ((|list| (|List| FE)) (|posCheck?| (|Boolean|))
         (|ans| (|ExponentialExpansion| R FE |x| |cen|))
         (|op|
          (|Mapping| (|ExponentialExpansion| R FE |x| |cen|)
                     (|ExponentialExpansion| R FE |x| |cen|)
                     (|ExponentialExpansion| R FE |x| |cen|)))
         ($
          (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                   (|:| |%problem|
                        (|Record| (|:| |func| (|String|))
                                  (|:| |prob| (|String|)))))))
        (SPROG
         ((#1=#:G874 NIL)
          (|term|
           (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                    (|:| |%problem|
                         (|Record| (|:| |func| (|String|))
                                   (|:| |prob| (|String|)))))))
         (SEQ
          (EXIT
           (SEQ
            (SEQ G190 (COND ((NULL (NULL (NULL |list|))) (GO G191)))
                 (SEQ
                  (LETT |term|
                        (|FS2EXPXP;iExprToXXP| (|SPADfirst| |list|) |posCheck?|
                         $))
                  (EXIT
                   (COND
                    ((QEQCAR |term| 1)
                     (PROGN (LETT #1# |term|) (GO #2=#:G873)))
                    ('T
                     (SEQ (LETT |ans| (SPADCALL |ans| (CDR |term|) |op|))
                          (EXIT (LETT |list| (CDR |list|))))))))
                 NIL (GO G190) G191 (EXIT NIL))
            (EXIT (CONS 0 |ans|))))
          #2# (EXIT #1#)))) 

(SDEFUN |FS2EXPXP;isNonTrivPower|
        ((|fcn| (FE))
         ($
          (|Union| (|Record| (|:| |val| FE) (|:| |exponent| (|Integer|)))
                   "failed")))
        (SPROG
         ((|power| (|Record| (|:| |val| FE) (|:| |exponent| (|Integer|))))
          (|expt|
           (|Union| (|Record| (|:| |val| FE) (|:| |exponent| (|Integer|)))
                    "failed")))
         (SEQ (LETT |expt| (SPADCALL |fcn| (QREFELT $ 74)))
              (EXIT
               (COND ((QEQCAR |expt| 1) (CONS 1 "failed"))
                     (#1='T
                      (SEQ (LETT |power| (QCDR |expt|))
                           (EXIT
                            (COND ((EQL (QCDR |power|) 1) (CONS 1 "failed"))
                                  (#1# (CONS 0 |power|))))))))))) 

(SDEFUN |FS2EXPXP;negativePowerOK?|
        ((|upxs| (|UnivariatePuiseuxSeries| FE |x| |cen|)) ($ (|Boolean|)))
        (SPROG
         ((|xOpList| (|List| (|BasicOperator|))) (|coef| (FE))
          (|deg| (|Fraction| (|Integer|))))
         (SEQ (LETT |deg| (SPADCALL |upxs| (QREFELT $ 75)))
              (SEQ (LETT |coef| (SPADCALL |upxs| |deg| (QREFELT $ 76)))
                   (EXIT
                    (COND
                     ((SPADCALL |coef| (|spadConstant| $ 77) (QREFELT $ 78))
                      (SEQ
                       (LETT |deg|
                             (SPADCALL |upxs|
                                       (SPADCALL |deg| (QREFELT $ 14)
                                                 (QREFELT $ 79))
                                       (QREFELT $ 80)))
                       (LETT |coef| (SPADCALL |upxs| |deg| (QREFELT $ 76)))
                       (EXIT
                        (COND
                         ((SPADCALL |coef| (|spadConstant| $ 77)
                                    (QREFELT $ 78))
                          (|error|
                           "inverse of series with many leading zero coefficients")))))))))
              (LETT |xOpList| (|FS2EXPXP;opsInvolvingX| |coef| $))
              (EXIT
               (COND ((NULL |xOpList|) 'T)
                     (#1='T
                      (SEQ
                       (COND
                        ((NULL (CDR |xOpList|))
                         (COND
                          ((SPADCALL (|SPADfirst| |xOpList|) '|log|
                                     (QREFELT $ 81))
                           (EXIT 'T)))))
                       (EXIT
                        (COND ((|FS2EXPXP;productOfNonZeroes?| |coef| $) 'T)
                              (#1# NIL)))))))))) 

(SDEFUN |FS2EXPXP;powerToXXP|
        ((|fcn| (FE)) (|n| (|Integer|)) (|posCheck?| (|Boolean|))
         ($
          (|Union|
           (|:| |%expansion| #1=(|ExponentialExpansion| R FE |x| |cen|))
           (|:| |%problem|
                (|Record| (|:| |func| (|String|)) (|:| |prob| (|String|)))))))
        (SPROG
         ((|nn| (|NonNegativeInteger|)) (#2=#:G897 NIL)
          (|rec|
           (|Union|
            (|UnivariatePuiseuxSeriesWithExponentialSingularity| R FE |x|
                                                                 |cen|)
            "failed"))
          (|num|
           (|UnivariatePuiseuxSeriesWithExponentialSingularity| R FE |x|
                                                                |cen|))
          (|xxp| #1#) (#3=#:G890 NIL)
          (|b|
           (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                    (|:| |%problem|
                         (|Record| (|:| |func| (|String|))
                                   (|:| |prob| (|String|)))))))
         (SEQ (LETT |b| (|FS2EXPXP;iExprToXXP| |fcn| |posCheck?| $))
              (EXIT
               (COND ((QEQCAR |b| 1) |b|)
                     (#4='T
                      (SEQ
                       (LETT |xxp|
                             (PROG2 (LETT #3# |b|)
                                 (QCDR #3#)
                               (|check_union2| (QEQCAR #3# 0)
                                               (|ExponentialExpansion|
                                                (QREFELT $ 6) (QREFELT $ 7)
                                                (QREFELT $ 8) (QREFELT $ 9))
                                               (|Union|
                                                (|:| |%expansion|
                                                     (|ExponentialExpansion|
                                                      (QREFELT $ 6)
                                                      (QREFELT $ 7)
                                                      (QREFELT $ 8)
                                                      (QREFELT $ 9)))
                                                (|:| |%problem|
                                                     (|Record|
                                                      (|:| |func| (|String|))
                                                      (|:| |prob|
                                                           (|String|)))))
                                               #3#)))
                       (EXIT
                        (COND
                         ((OR (> |n| 0)
                              (>
                               (SPADCALL
                                (LETT |num| (SPADCALL |xxp| (QREFELT $ 84)))
                                (QREFELT $ 86))
                               1))
                          (CONS 0 (SPADCALL |xxp| |n| (QREFELT $ 82))))
                         ((|FS2EXPXP;negativePowerOK?|
                           (SPADCALL |num| (QREFELT $ 87)) $)
                          (SEQ (LETT |rec| (SPADCALL |num| (QREFELT $ 89)))
                               (EXIT
                                (COND
                                 ((QEQCAR |rec| 1)
                                  (|error| "FS2EXPXP: can't happen"))
                                 (#4#
                                  (SEQ
                                   (LETT |nn|
                                         (PROG1 (LETT #2# (- |n|))
                                           (|check_subtype2| (>= #2# 0)
                                                             '(|NonNegativeInteger|)
                                                             '(|Integer|)
                                                             #2#)))
                                   (EXIT
                                    (CONS 0
                                          (SPADCALL
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL |xxp| (QREFELT $ 90))
                                             |nn| (QREFELT $ 91))
                                            (SPADCALL (QCDR |rec|) |nn|
                                                      (QREFELT $ 91))
                                            (QREFELT $ 92))
                                           (QREFELT $ 93))))))))))
                         (#4#
                          (|FS2EXPXP;stateProblem| "inv"
                           "lowest order coefficient involves x" $))))))))))) 

(SDEFUN |FS2EXPXP;carefulNthRootIfCan|
        ((|ups| (|UnivariatePuiseuxSeries| FE |x| |cen|))
         (|n| (|NonNegativeInteger|)) (|posCheck?| (|Boolean|))
         ($
          (|Union| (|:| |%series| (|UnivariatePuiseuxSeries| FE |x| |cen|))
                   (|:| |%problem|
                        (|Record| (|:| |func| (|String|))
                                  (|:| |prob| (|String|)))))))
        (SPROG
         ((|ans| (|Union| (|UnivariatePuiseuxSeries| FE |x| |cen|) "failed"))
          (#1=#:G923 NIL) (#2=#:G924 NIL)
          (|signum| (|Union| (|Integer|) "failed")) (|coef| (FE))
          (|deg| (|Fraction| (|Integer|))))
         (SEQ
          (EXIT
           (COND ((< |n| 1) (|error| "nthRoot: n must be positive"))
                 (#3='T
                  (SEQ
                   (EXIT
                    (SEQ (LETT |deg| (SPADCALL |ups| (QREFELT $ 75)))
                         (SEQ
                          (LETT |coef| (SPADCALL |ups| |deg| (QREFELT $ 76)))
                          (EXIT
                           (COND
                            ((SPADCALL |coef| (|spadConstant| $ 77)
                                       (QREFELT $ 78))
                             (SEQ
                              (LETT |deg|
                                    (SPADCALL |ups|
                                              (SPADCALL |deg| (QREFELT $ 14)
                                                        (QREFELT $ 79))
                                              (QREFELT $ 80)))
                              (LETT |coef|
                                    (SPADCALL |ups| |deg| (QREFELT $ 76)))
                              (EXIT
                               (COND
                                ((SPADCALL |coef| (|spadConstant| $ 77)
                                           (QREFELT $ 78))
                                 (|error|
                                  "log of series with many leading zero coefficients")))))))))
                         (COND
                          ((EVENP |n|)
                           (COND
                            (|posCheck?|
                             (SEQ
                              (LETT |signum| (SPADCALL |coef| (QREFELT $ 96)))
                              (EXIT
                               (COND
                                ((QEQCAR |signum| 0)
                                 (COND
                                  ((EQL (QCDR |signum|) -1)
                                   (PROGN
                                    (LETT #1#
                                          (PROGN
                                           (LETT #2#
                                                 (|FS2EXPXP;stateSeriesProblem|
                                                  "nth root"
                                                  "root of negative number" $))
                                           (GO #4=#:G922)))
                                    (GO #5=#:G921))))))))))))
                         (LETT |ans| (SPADCALL |ups| |n| (QREFELT $ 99)))
                         (EXIT
                          (COND
                           ((QEQCAR |ans| 1)
                            (|FS2EXPXP;stateSeriesProblem| "nth root"
                             "no nth root" $))
                           (#3# (CONS 0 (QCDR |ans|)))))))
                   #5# (EXIT #1#)))))
          #4# (EXIT #2#)))) 

(SDEFUN |FS2EXPXP;nthRootXXPIfCan|
        ((|xxp| (|ExponentialExpansion| R FE |x| |cen|))
         (|n| (|NonNegativeInteger|)) (|posCheck?| (|Boolean|))
         ($
          (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                   (|:| |%problem|
                        (|Record| (|:| |func| (|String|))
                                  (|:| |prob| (|String|)))))))
        (SPROG
         ((|newDen|
           #1=(|UnivariatePuiseuxSeriesWithExponentialSingularity| R FE |x|
                                                                   |cen|))
          (|deg| (|ExponentialOfUnivariatePuiseuxSeries| FE |x| |cen|))
          (|coef| (|UnivariatePuiseuxSeries| FE |x| |cen|)) (#2=#:G930 NIL)
          (#3=#:G938 NIL) (#4=#:G931 NIL)
          (|root|
           (|Union| (|:| |%series| (|UnivariatePuiseuxSeries| FE |x| |cen|))
                    (|:| |%problem|
                         (|Record| (|:| |func| (|String|))
                                   (|:| |prob| (|String|))))))
          (|newNum| #1#) (|nInv| (|Fraction| (|Integer|)))
          (|den|
           (|UnivariatePuiseuxSeriesWithExponentialSingularity| R FE |x|
                                                                |cen|))
          (|num|
           (|UnivariatePuiseuxSeriesWithExponentialSingularity| R FE |x|
                                                                |cen|)))
         (SEQ
          (EXIT
           (SEQ (LETT |num| (SPADCALL |xxp| (QREFELT $ 84)))
                (LETT |den| (SPADCALL |xxp| (QREFELT $ 90)))
                (COND
                 ((SPADCALL (SPADCALL |num| (QREFELT $ 100)) (QREFELT $ 101))
                  (COND
                   ((NULL
                     (SPADCALL (SPADCALL |den| (QREFELT $ 100))
                               (QREFELT $ 101)))
                    (EXIT
                     (|FS2EXPXP;stateProblem| #5="nth root"
                      #6="several monomials in numerator or denominator" $)))))
                 (#7='T (EXIT (|FS2EXPXP;stateProblem| #5# #6# $))))
                (LETT |nInv| (SPADCALL 1 |n| (QREFELT $ 13)))
                (LETT |newNum|
                      (SEQ
                       (LETT |coef|
                             (SEQ
                              (LETT |root|
                                    (|FS2EXPXP;carefulNthRootIfCan|
                                     (SPADCALL |num| (QREFELT $ 87)) |n|
                                     |posCheck?| $))
                              (EXIT
                               (COND
                                ((QEQCAR |root| 1)
                                 (PROGN
                                  (LETT #3# (CONS 1 (CDR |root|)))
                                  (GO #8=#:G937)))
                                (#7# (CDR |root|))))))
                       (LETT |deg|
                             (SPADCALL (SPADCALL |nInv| (QREFELT $ 102))
                                       (SPADCALL |num| (QREFELT $ 104))
                                       (QREFELT $ 105)))
                       (EXIT (SPADCALL |coef| |deg| (QREFELT $ 106)))))
                (LETT |newDen|
                      (SEQ
                       (LETT |coef|
                             (SEQ
                              (LETT |root|
                                    (|FS2EXPXP;carefulNthRootIfCan|
                                     (SPADCALL |den| (QREFELT $ 87)) |n|
                                     |posCheck?| $))
                              (EXIT
                               (COND
                                ((QEQCAR |root| 1)
                                 (PROGN
                                  (LETT #3#
                                        (CONS 1
                                              (PROG2 (LETT #4# |root|)
                                                  (QCDR #4#)
                                                (|check_union2| (QEQCAR #4# 1)
                                                                (|Record|
                                                                 (|:| |func|
                                                                      (|String|))
                                                                 (|:| |prob|
                                                                      (|String|)))
                                                                (|Union|
                                                                 (|:| |%series|
                                                                      (|UnivariatePuiseuxSeries|
                                                                       (QREFELT
                                                                        $ 7)
                                                                       (QREFELT
                                                                        $ 8)
                                                                       (QREFELT
                                                                        $ 9)))
                                                                 (|:|
                                                                  |%problem|
                                                                  (|Record|
                                                                   (|:| |func|
                                                                        (|String|))
                                                                   (|:| |prob|
                                                                        (|String|)))))
                                                                #4#))))
                                  (GO #8#)))
                                (#7#
                                 (PROG2 (LETT #2# |root|)
                                     (QCDR #2#)
                                   (|check_union2| (QEQCAR #2# 0)
                                                   (|UnivariatePuiseuxSeries|
                                                    (QREFELT $ 7) (QREFELT $ 8)
                                                    (QREFELT $ 9))
                                                   (|Union|
                                                    (|:| |%series|
                                                         (|UnivariatePuiseuxSeries|
                                                          (QREFELT $ 7)
                                                          (QREFELT $ 8)
                                                          (QREFELT $ 9)))
                                                    (|:| |%problem|
                                                         (|Record|
                                                          (|:| |func|
                                                               (|String|))
                                                          (|:| |prob|
                                                               (|String|)))))
                                                   #2#)))))))
                       (LETT |deg|
                             (SPADCALL (SPADCALL |nInv| (QREFELT $ 102))
                                       (SPADCALL |den| (QREFELT $ 104))
                                       (QREFELT $ 105)))
                       (EXIT (SPADCALL |coef| |deg| (QREFELT $ 106)))))
                (EXIT (CONS 0 (SPADCALL |newNum| |newDen| (QREFELT $ 107))))))
          #8# (EXIT #3#)))) 

(SDEFUN |FS2EXPXP;nthRootToXXP|
        ((|arg| (FE)) (|n| (|NonNegativeInteger|)) (|posCheck?| (|Boolean|))
         ($
          (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                   (|:| |%problem|
                        (|Record| (|:| |func| (|String|))
                                  (|:| |prob| (|String|)))))))
        (SPROG
         ((|ans|
           (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                    (|:| |%problem|
                         (|Record| (|:| |func| (|String|))
                                   (|:| |prob| (|String|))))))
          (|result|
           (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                    (|:| |%problem|
                         (|Record| (|:| |func| (|String|))
                                   (|:| |prob| (|String|)))))))
         (SEQ (LETT |result| (|FS2EXPXP;iExprToXXP| |arg| |posCheck?| $))
              (EXIT
               (COND ((QEQCAR |result| 1) (CONS 1 (CDR |result|)))
                     (#1='T
                      (SEQ
                       (LETT |ans|
                             (|FS2EXPXP;nthRootXXPIfCan| (CDR |result|) |n|
                              |posCheck?| $))
                       (EXIT
                        (COND ((QEQCAR |ans| 1) (CONS 1 (CDR |ans|)))
                              (#1# (CONS 0 (CDR |ans|)))))))))))) 

(SDEFUN |FS2EXPXP;genPowerToXXP|
        ((|args| (|List| FE)) (|posCheck?| (|Boolean|))
         ($
          (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                   (|:| |%problem|
                        (|Record| (|:| |func| (|String|))
                                  (|:| |prob| (|String|)))))))
        (SPROG
         ((|f| (|Union| (|UnivariatePuiseuxSeries| FE |x| |cen|) "failed"))
          (|xxp| (|ExponentialExpansion| R FE |x| |cen|))
          (|expon|
           (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                    (|:| |%problem|
                         (|Record| (|:| |func| (|String|))
                                   (|:| |prob| (|String|))))))
          (|logBase|
           (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                    (|:| |%problem|
                         (|Record| (|:| |func| (|String|))
                                   (|:| |prob| (|String|)))))))
         (SEQ
          (LETT |logBase|
                (|FS2EXPXP;logToXXP| (|SPADfirst| |args|) |posCheck?| $))
          (EXIT
           (COND ((QEQCAR |logBase| 1) |logBase|)
                 (#1='T
                  (SEQ
                   (LETT |expon|
                         (|FS2EXPXP;iExprToXXP|
                          (SPADCALL |args| (QREFELT $ 108)) |posCheck?| $))
                   (EXIT
                    (COND ((QEQCAR |expon| 1) |expon|)
                          (#1#
                           (SEQ
                            (LETT |xxp|
                                  (SPADCALL (CDR |expon|) (CDR |logBase|)
                                            (QREFELT $ 69)))
                            (LETT |f| (SPADCALL |xxp| (QREFELT $ 109)))
                            (EXIT
                             (COND
                              ((QEQCAR |f| 1)
                               (|FS2EXPXP;stateProblem| "exp"
                                "multiply nested exponential" $))
                              (#1#
                               (|FS2EXPXP;exponential| (QCDR |f|) |posCheck?|
                                $))))))))))))))) 

(SDEFUN |FS2EXPXP;kernelToXXP|
        ((|ker| (|Kernel| FE)) (|posCheck?| (|Boolean|))
         ($
          (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                   (|:| |%problem|
                        (|Record| (|:| |func| (|String|))
                                  (|:| |prob| (|String|)))))))
        (SPROG
         ((#1=#:G973 NIL) (|n| (|Integer|)) (|arg| (FE)) (|args| (|List| FE))
          (|sym| (|Union| (|Symbol|) "failed")))
         (SEQ (LETT |sym| (SPADCALL |ker| (QREFELT $ 111)))
              (EXIT
               (COND
                ((QEQCAR |sym| 0)
                 (COND
                  ((EQUAL (QCDR |sym|) (QREFELT $ 8))
                   (CONS 0
                         (SPADCALL
                          (SPADCALL (|spadConstant| $ 10)
                                    (|spadConstant| $ 112) (QREFELT $ 113))
                          (QREFELT $ 62))))
                  (#2='T
                   (CONS 0
                         (SPADCALL
                          (SPADCALL (SPADCALL |ker| (QREFELT $ 31))
                                    (|spadConstant| $ 114) (QREFELT $ 113))
                          (QREFELT $ 62))))))
                ((NULL (LETT |args| (SPADCALL |ker| (QREFELT $ 29))))
                 (CONS 0
                       (SPADCALL
                        (SPADCALL (SPADCALL |ker| (QREFELT $ 31))
                                  (|spadConstant| $ 114) (QREFELT $ 113))
                        (QREFELT $ 62))))
                ((NULL (CDR |args|))
                 (SEQ (LETT |arg| (|SPADfirst| |args|))
                      (EXIT
                       (COND
                        ((SPADCALL |ker| '|%paren| (QREFELT $ 38))
                         (|FS2EXPXP;iExprToXXP| |arg| |posCheck?| $))
                        ((SPADCALL |ker| '|log| (QREFELT $ 38))
                         (|FS2EXPXP;logToXXP| |arg| |posCheck?| $))
                        ((SPADCALL |ker| '|exp| (QREFELT $ 38))
                         (|FS2EXPXP;expToXXP| |arg| |posCheck?| $))
                        (#2#
                         (|FS2EXPXP;tranToXXP| |ker| |arg| |posCheck?| $))))))
                ((SPADCALL |ker| '|%power| (QREFELT $ 38))
                 (|FS2EXPXP;genPowerToXXP| |args| |posCheck?| $))
                ((SPADCALL |ker| '|nthRoot| (QREFELT $ 38))
                 (SEQ
                  (LETT |n|
                        (SPADCALL (SPADCALL |args| (QREFELT $ 108))
                                  (QREFELT $ 115)))
                  (EXIT
                   (|FS2EXPXP;nthRootToXXP| (|SPADfirst| |args|)
                    (PROG1 (LETT #1# |n|)
                      (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #1#))
                    |posCheck?| $))))
                (#2#
                 (|FS2EXPXP;stateProblem|
                  (SPADCALL (SPADCALL |ker| (QREFELT $ 116)) (QREFELT $ 118))
                  "unknown kernel" $))))))) 

(SDEFUN |FS2EXPXP;genExp|
        ((|ups| (|UnivariatePuiseuxSeries| FE |x| |cen|))
         (|posCheck?| (|Boolean|))
         ($
          (|Union| (|:| |%series| (|UnivariatePuiseuxSeries| FE |x| |cen|))
                   (|:| |%problem|
                        (|Record| (|:| |func| (|String|))
                                  (|:| |prob| (|String|)))))))
        (SPROG
         ((|result|
           (|Union| (|:| |%series| (|UnivariatePuiseuxSeries| FE |x| |cen|))
                    (|:| |%problem|
                         (|Record| (|:| |func| (|String|))
                                   (|:| |prob| (|String|))))))
          (|expCoef| (FE)) (|varOpList| (|List| (|BasicOperator|))) (|lc| (FE))
          (|deg| (|Fraction| (|Integer|))))
         (SEQ
          (LETT |deg| (SPADCALL |ups| (|spadConstant| $ 112) (QREFELT $ 80)))
          (EXIT
           (COND
            ((SPADCALL |deg| (|spadConstant| $ 114) (QREFELT $ 119))
             (|error| "exp of function with sigularity"))
            ((SPADCALL |deg| (|spadConstant| $ 114) (QREFELT $ 120))
             (CONS 0 (SPADCALL |ups| (QREFELT $ 121))))
            (#1='T
             (SEQ
              (LETT |lc|
                    (SPADCALL |ups| (|spadConstant| $ 114) (QREFELT $ 76)))
              (LETT |varOpList| (|FS2EXPXP;opsInvolvingX| |lc| $))
              (COND
               ((NULL (|FS2EXPXP;opInOpList?| '|log| |varOpList| $))
                (EXIT (CONS 0 (SPADCALL |ups| (QREFELT $ 121))))))
              (LETT |expCoef|
                    (SPADCALL (SPADCALL |lc| (QREFELT $ 32)) (QREFELT $ 8)
                              (QREFELT $ 123)))
              (LETT |result|
                    (SPADCALL |expCoef| |posCheck?| (CONS 3 "real: right side")
                              (QREFELT $ 124)))
              (EXIT
               (COND ((QEQCAR |result| 1) |result|)
                     (#1#
                      (CONS 0
                            (SPADCALL (CDR |result|)
                                      (SPADCALL
                                       (SPADCALL |ups|
                                                 (SPADCALL |lc|
                                                           (|spadConstant| $
                                                                           114)
                                                           (QREFELT $ 113))
                                                 (QREFELT $ 125))
                                       (QREFELT $ 121))
                                      (QREFELT $ 126))))))))))))) 

(SDEFUN |FS2EXPXP;exponential|
        ((|f| (|UnivariatePuiseuxSeries| FE |x| |cen|))
         (|posCheck?| (|Boolean|))
         ($
          (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                   (|:| |%problem|
                        (|Record| (|:| |func| (|String|))
                                  (|:| |prob| (|String|)))))))
        (SPROG
         ((|coef|
           (|Union| (|:| |%series| (|UnivariatePuiseuxSeries| FE |x| |cen|))
                    (|:| |%problem|
                         (|Record| (|:| |func| (|String|))
                                   (|:| |prob| (|String|))))))
          (|expon| (|ExponentialOfUnivariatePuiseuxSeries| FE |x| |cen|))
          (|taylorPart| #1=(|UnivariatePuiseuxSeries| FE |x| |cen|))
          (|singPart| #1#))
         (SEQ
          (LETT |singPart|
                (SPADCALL (SPADCALL |f| (|spadConstant| $ 114) (QREFELT $ 127))
                          (SPADCALL
                           (SPADCALL |f| (|spadConstant| $ 114) (QREFELT $ 76))
                           (QREFELT $ 128))
                          (QREFELT $ 125)))
          (LETT |taylorPart| (SPADCALL |f| |singPart| (QREFELT $ 125)))
          (LETT |expon| (SPADCALL |singPart| (QREFELT $ 129)))
          (LETT |coef| (|FS2EXPXP;genExp| |taylorPart| |posCheck?| $))
          (EXIT
           (COND ((QEQCAR |coef| 1) (CONS 1 (CDR |coef|)))
                 ('T
                  (CONS 0
                        (SPADCALL
                         (SPADCALL (CDR |coef|) |expon| (QREFELT $ 106))
                         (QREFELT $ 93))))))))) 

(SDEFUN |FS2EXPXP;expToXXP|
        ((|arg| (FE)) (|posCheck?| (|Boolean|))
         ($
          (|Union|
           (|:| |%expansion| #1=(|ExponentialExpansion| R FE |x| |cen|))
           (|:| |%problem|
                (|Record| (|:| |func| (|String|)) (|:| |prob| (|String|)))))))
        (SPROG
         ((|f| (|Union| (|UnivariatePuiseuxSeries| FE |x| |cen|) "failed"))
          (|xxp| #1#) (#2=#:G1002 NIL)
          (|result|
           (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                    (|:| |%problem|
                         (|Record| (|:| |func| (|String|))
                                   (|:| |prob| (|String|)))))))
         (SEQ (LETT |result| (|FS2EXPXP;iExprToXXP| |arg| |posCheck?| $))
              (EXIT
               (COND ((QEQCAR |result| 1) |result|)
                     (#3='T
                      (SEQ
                       (LETT |xxp|
                             (PROG2 (LETT #2# |result|)
                                 (QCDR #2#)
                               (|check_union2| (QEQCAR #2# 0)
                                               (|ExponentialExpansion|
                                                (QREFELT $ 6) (QREFELT $ 7)
                                                (QREFELT $ 8) (QREFELT $ 9))
                                               (|Union|
                                                (|:| |%expansion|
                                                     (|ExponentialExpansion|
                                                      (QREFELT $ 6)
                                                      (QREFELT $ 7)
                                                      (QREFELT $ 8)
                                                      (QREFELT $ 9)))
                                                (|:| |%problem|
                                                     (|Record|
                                                      (|:| |func| (|String|))
                                                      (|:| |prob|
                                                           (|String|)))))
                                               #2#)))
                       (LETT |f| (SPADCALL |xxp| (QREFELT $ 109)))
                       (EXIT
                        (COND
                         ((QEQCAR |f| 1)
                          (|FS2EXPXP;stateProblem| "exp"
                           "multiply nested exponential" $))
                         (#3#
                          (|FS2EXPXP;exponential| (QCDR |f|) |posCheck?|
                           $))))))))))) 

(SDEFUN |FS2EXPXP;genLog|
        ((|ups| (|UnivariatePuiseuxSeries| FE |x| |cen|))
         (|posCheck?| (|Boolean|))
         ($
          (|Union| (|:| |%series| (|UnivariatePuiseuxSeries| FE |x| |cen|))
                   (|:| |%problem|
                        (|Record| (|:| |func| (|String|))
                                  (|:| |prob| (|String|)))))))
        (SPROG
         ((|logTerm| (FE)) (|term1| (FE)) (|pow| (FE)) (|mon| (FE))
          (|negRat?| (|Boolean|))
          (|rat| (|Union| (|Fraction| (|Integer|)) "failed"))
          (|lt| (|UnivariatePuiseuxSeries| FE |x| |cen|)) (#1=#:G1029 NIL)
          (#2=#:G1030 NIL) (|signum| (|Union| (|Integer|) "failed"))
          (|coef| (FE)) (|deg| (|Fraction| (|Integer|))))
         (SEQ
          (EXIT
           (SEQ
            (EXIT
             (SEQ (LETT |deg| (SPADCALL |ups| (QREFELT $ 75)))
                  (SEQ (LETT |coef| (SPADCALL |ups| |deg| (QREFELT $ 76)))
                       (EXIT
                        (COND
                         ((SPADCALL |coef| (|spadConstant| $ 77)
                                    (QREFELT $ 78))
                          (SEQ
                           (LETT |deg|
                                 (SPADCALL |ups|
                                           (SPADCALL |deg| (QREFELT $ 14)
                                                     (QREFELT $ 79))
                                           (QREFELT $ 80)))
                           (LETT |coef| (SPADCALL |ups| |deg| (QREFELT $ 76)))
                           (EXIT
                            (COND
                             ((SPADCALL |coef| (|spadConstant| $ 77)
                                        (QREFELT $ 78))
                              (|error|
                               "log of series with many leading zero coefficients")))))))))
                  (COND
                   (|posCheck?|
                    (SEQ (LETT |signum| (SPADCALL |coef| (QREFELT $ 96)))
                         (EXIT
                          (COND
                           ((QEQCAR |signum| 0)
                            (COND
                             ((EQL (QCDR |signum|) -1)
                              (PROGN
                               (LETT #1#
                                     (PROGN
                                      (LETT #2#
                                            (|FS2EXPXP;stateSeriesProblem|
                                             "log"
                                             "negative leading coefficient" $))
                                      (GO #3=#:G1028)))
                               (GO #4=#:G1027))))))))))
                  (LETT |lt| (SPADCALL |coef| |deg| (QREFELT $ 113)))
                  (LETT |negRat?|
                        (SEQ (LETT |rat| (|FS2EXPXP;ratIfCan| |coef| $))
                             (EXIT
                              (COND
                               ((QEQCAR |rat| 0)
                                (COND
                                 ((SPADCALL (QCDR |rat|) (|spadConstant| $ 114)
                                            (QREFELT $ 119))
                                  'T)
                                 (#5='T NIL)))
                               (#5# NIL)))))
                  (LETT |logTerm|
                        (SEQ
                         (LETT |mon|
                               (SPADCALL
                                (SPADCALL (QREFELT $ 8) (QREFELT $ 130))
                                (QREFELT $ 9) (QREFELT $ 39)))
                         (LETT |pow|
                               (SPADCALL |mon| (SPADCALL |deg| (QREFELT $ 102))
                                         (QREFELT $ 131)))
                         (EXIT
                          (COND
                           (|negRat?|
                            (SPADCALL (SPADCALL |coef| |pow| (QREFELT $ 132))
                                      (QREFELT $ 46)))
                           (#5#
                            (SEQ
                             (LETT |term1|
                                   (SPADCALL (SPADCALL |deg| (QREFELT $ 102))
                                             (SPADCALL |mon| (QREFELT $ 46))
                                             (QREFELT $ 132)))
                             (EXIT
                              (SPADCALL (SPADCALL |coef| (QREFELT $ 46))
                                        |term1| (QREFELT $ 41)))))))))
                  (EXIT
                   (CONS 0
                         (SPADCALL
                          (SPADCALL |logTerm| (|spadConstant| $ 114)
                                    (QREFELT $ 113))
                          (SPADCALL (SPADCALL |ups| |lt| (QREFELT $ 133))
                                    (QREFELT $ 134))
                          (QREFELT $ 135))))))
            #4# (EXIT #1#)))
          #3# (EXIT #2#)))) 

(SDEFUN |FS2EXPXP;logToXXP|
        ((|arg| (FE)) (|posCheck?| (|Boolean|))
         ($
          (|Union|
           (|:| |%expansion| #1=(|ExponentialExpansion| R FE |x| |cen|))
           (|:| |%problem|
                (|Record| (|:| |func| (|String|)) (|:| |prob| (|String|)))))))
        (SPROG
         ((|denLog| #2=(|UnivariatePuiseuxSeries| FE |x| |cen|)) (|numLog| #2#)
          (|denCoefLog| (|UnivariatePuiseuxSeries| FE |x| |cen|))
          (#3=#:G1036 NIL) (#4=#:G1043 NIL) (#5=#:G1037 NIL)
          (|res|
           (|Union| (|:| |%series| (|UnivariatePuiseuxSeries| FE |x| |cen|))
                    (|:| |%problem|
                         (|Record| (|:| |func| (|String|))
                                   (|:| |prob| (|String|))))))
          (|numCoefLog| (|UnivariatePuiseuxSeries| FE |x| |cen|))
          (|den|
           (|UnivariatePuiseuxSeriesWithExponentialSingularity| R FE |x|
                                                                |cen|))
          (|num|
           (|UnivariatePuiseuxSeriesWithExponentialSingularity| R FE |x|
                                                                |cen|))
          (|xxp| #1#) (#6=#:G1032 NIL)
          (|result|
           (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                    (|:| |%problem|
                         (|Record| (|:| |func| (|String|))
                                   (|:| |prob| (|String|)))))))
         (SEQ
          (EXIT
           (SEQ (LETT |result| (|FS2EXPXP;iExprToXXP| |arg| |posCheck?| $))
                (EXIT
                 (COND ((QEQCAR |result| 1) |result|)
                       (#7='T
                        (SEQ
                         (LETT |xxp|
                               (PROG2 (LETT #6# |result|)
                                   (QCDR #6#)
                                 (|check_union2| (QEQCAR #6# 0)
                                                 (|ExponentialExpansion|
                                                  (QREFELT $ 6) (QREFELT $ 7)
                                                  (QREFELT $ 8) (QREFELT $ 9))
                                                 (|Union|
                                                  (|:| |%expansion|
                                                       (|ExponentialExpansion|
                                                        (QREFELT $ 6)
                                                        (QREFELT $ 7)
                                                        (QREFELT $ 8)
                                                        (QREFELT $ 9)))
                                                  (|:| |%problem|
                                                       (|Record|
                                                        (|:| |func| (|String|))
                                                        (|:| |prob|
                                                             (|String|)))))
                                                 #6#)))
                         (LETT |num| (SPADCALL |xxp| (QREFELT $ 84)))
                         (LETT |den| (SPADCALL |xxp| (QREFELT $ 90)))
                         (COND
                          ((SPADCALL (SPADCALL |num| (QREFELT $ 100))
                                     (QREFELT $ 101))
                           (COND
                            ((NULL
                              (SPADCALL (SPADCALL |den| (QREFELT $ 100))
                                        (QREFELT $ 101)))
                             (EXIT
                              (|FS2EXPXP;stateProblem| #8="log"
                               #9="several monomials in numerator or denominator"
                               $)))))
                          (#7# (EXIT (|FS2EXPXP;stateProblem| #8# #9# $))))
                         (LETT |numCoefLog|
                               (SEQ
                                (LETT |res|
                                      (|FS2EXPXP;genLog|
                                       (SPADCALL |num| (QREFELT $ 87))
                                       |posCheck?| $))
                                (EXIT
                                 (COND
                                  ((QEQCAR |res| 1)
                                   (PROGN
                                    (LETT #4# (CONS 1 (CDR |res|)))
                                    (GO #10=#:G1042)))
                                  (#7# (CDR |res|))))))
                         (LETT |denCoefLog|
                               (SEQ
                                (LETT |res|
                                      (|FS2EXPXP;genLog|
                                       (SPADCALL |den| (QREFELT $ 87))
                                       |posCheck?| $))
                                (EXIT
                                 (COND
                                  ((QEQCAR |res| 1)
                                   (PROGN
                                    (LETT #4#
                                          (CONS 1
                                                (PROG2 (LETT #5# |res|)
                                                    (QCDR #5#)
                                                  (|check_union2|
                                                   (QEQCAR #5# 1)
                                                   (|Record|
                                                    (|:| |func| (|String|))
                                                    (|:| |prob| (|String|)))
                                                   (|Union|
                                                    (|:| |%series|
                                                         (|UnivariatePuiseuxSeries|
                                                          (QREFELT $ 7)
                                                          (QREFELT $ 8)
                                                          (QREFELT $ 9)))
                                                    (|:| |%problem|
                                                         (|Record|
                                                          (|:| |func|
                                                               (|String|))
                                                          (|:| |prob|
                                                               (|String|)))))
                                                   #5#))))
                                    (GO #10#)))
                                  (#7#
                                   (PROG2 (LETT #3# |res|)
                                       (QCDR #3#)
                                     (|check_union2| (QEQCAR #3# 0)
                                                     (|UnivariatePuiseuxSeries|
                                                      (QREFELT $ 7)
                                                      (QREFELT $ 8)
                                                      (QREFELT $ 9))
                                                     (|Union|
                                                      (|:| |%series|
                                                           (|UnivariatePuiseuxSeries|
                                                            (QREFELT $ 7)
                                                            (QREFELT $ 8)
                                                            (QREFELT $ 9)))
                                                      (|:| |%problem|
                                                           (|Record|
                                                            (|:| |func|
                                                                 (|String|))
                                                            (|:| |prob|
                                                                 (|String|)))))
                                                     #3#)))))))
                         (LETT |numLog|
                               (SPADCALL
                                (SPADCALL (SPADCALL |num| (QREFELT $ 104))
                                          (QREFELT $ 136))
                                |numCoefLog| (QREFELT $ 135)))
                         (LETT |denLog|
                               (SPADCALL
                                (SPADCALL (SPADCALL |den| (QREFELT $ 104))
                                          (QREFELT $ 136))
                                |denCoefLog| (QREFELT $ 135)))
                         (EXIT
                          (CONS 0
                                (SPADCALL
                                 (SPADCALL |numLog| |denLog| (QREFELT $ 125))
                                 (QREFELT $ 62))))))))))
          #10# (EXIT #4#)))) 

(SDEFUN |FS2EXPXP;applyIfCan|
        ((|fcn|
          (|Mapping|
           (|Union| (|UnivariatePuiseuxSeries| FE |x| |cen|) "failed")
           (|UnivariatePuiseuxSeries| FE |x| |cen|)))
         (|arg| (FE)) (|fcnName| (|String|)) (|posCheck?| (|Boolean|))
         ($
          (|Union|
           (|:| |%expansion| #1=(|ExponentialExpansion| R FE |x| |cen|))
           (|:| |%problem|
                (|Record| (|:| |func| (|String|)) (|:| |prob| (|String|)))))))
        (SPROG
         ((#2=#:G1048 NIL) (|xOpList| (|List| (|BasicOperator|))) (|lc| (FE))
          (|deg| (|Fraction| (|Integer|)))
          (|upxs| (|UnivariatePuiseuxSeries| FE |x| |cen|))
          (|f| (|Union| (|UnivariatePuiseuxSeries| FE |x| |cen|) "failed"))
          (|xxp| #1#) (#3=#:G1045 NIL)
          (|xxpArg|
           (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                    (|:| |%problem|
                         (|Record| (|:| |func| (|String|))
                                   (|:| |prob| (|String|)))))))
         (SEQ (LETT |xxpArg| (|FS2EXPXP;iExprToXXP| |arg| |posCheck?| $))
              (EXIT
               (COND ((QEQCAR |xxpArg| 1) |xxpArg|)
                     (#4='T
                      (SEQ
                       (LETT |xxp|
                             (PROG2 (LETT #3# |xxpArg|)
                                 (QCDR #3#)
                               (|check_union2| (QEQCAR #3# 0)
                                               (|ExponentialExpansion|
                                                (QREFELT $ 6) (QREFELT $ 7)
                                                (QREFELT $ 8) (QREFELT $ 9))
                                               (|Union|
                                                (|:| |%expansion|
                                                     (|ExponentialExpansion|
                                                      (QREFELT $ 6)
                                                      (QREFELT $ 7)
                                                      (QREFELT $ 8)
                                                      (QREFELT $ 9)))
                                                (|:| |%problem|
                                                     (|Record|
                                                      (|:| |func| (|String|))
                                                      (|:| |prob|
                                                           (|String|)))))
                                               #3#)))
                       (LETT |f| (SPADCALL |xxp| (QREFELT $ 109)))
                       (EXIT
                        (COND
                         ((QEQCAR |f| 1)
                          (|FS2EXPXP;stateProblem| |fcnName|
                           "multiply nested exponential" $))
                         (#4#
                          (SEQ (LETT |upxs| (QCDR |f|))
                               (LETT |deg|
                                     (SPADCALL |upxs| (|spadConstant| $ 112)
                                               (QREFELT $ 80)))
                               (EXIT
                                (COND
                                 ((SPADCALL |deg| (|spadConstant| $ 114)
                                            (QREFELT $ 119))
                                  (|FS2EXPXP;stateProblem| |fcnName|
                                   "essential singularity" $))
                                 ((SPADCALL |deg| (|spadConstant| $ 114)
                                            (QREFELT $ 120))
                                  (CONS 0
                                        (SPADCALL
                                         (PROG2
                                             (LETT #2# (SPADCALL |upxs| |fcn|))
                                             (QCDR #2#)
                                           (|check_union2| (QEQCAR #2# 0)
                                                           (|UnivariatePuiseuxSeries|
                                                            (QREFELT $ 7)
                                                            (QREFELT $ 8)
                                                            (QREFELT $ 9))
                                                           (|Union|
                                                            (|UnivariatePuiseuxSeries|
                                                             (QREFELT $ 7)
                                                             (QREFELT $ 8)
                                                             (QREFELT $ 9))
                                                            #5="failed")
                                                           #2#))
                                         (QREFELT $ 62))))
                                 (#4#
                                  (SEQ
                                   (LETT |lc|
                                         (SPADCALL |upxs|
                                                   (|spadConstant| $ 114)
                                                   (QREFELT $ 76)))
                                   (LETT |xOpList|
                                         (|FS2EXPXP;opsInvolvingX| |lc| $))
                                   (EXIT
                                    (COND
                                     ((NULL |xOpList|)
                                      (CONS 0
                                            (SPADCALL
                                             (PROG2
                                                 (LETT #2#
                                                       (SPADCALL |upxs| |fcn|))
                                                 (QCDR #2#)
                                               (|check_union2| (QEQCAR #2# 0)
                                                               (|UnivariatePuiseuxSeries|
                                                                (QREFELT $ 7)
                                                                (QREFELT $ 8)
                                                                (QREFELT $ 9))
                                                               (|Union|
                                                                (|UnivariatePuiseuxSeries|
                                                                 (QREFELT $ 7)
                                                                 (QREFELT $ 8)
                                                                 (QREFELT $ 9))
                                                                #5#)
                                                               #2#))
                                             (QREFELT $ 62))))
                                     ((|FS2EXPXP;opInOpList?| '|log| |xOpList|
                                       $)
                                      (|FS2EXPXP;stateProblem| |fcnName|
                                       "logs in constant coefficient" $))
                                     ((|FS2EXPXP;contOnReals?| |fcnName| $)
                                      (CONS 0
                                            (SPADCALL
                                             (PROG2
                                                 (LETT #2#
                                                       (SPADCALL |upxs| |fcn|))
                                                 (QCDR #2#)
                                               (|check_union2| (QEQCAR #2# 0)
                                                               (|UnivariatePuiseuxSeries|
                                                                (QREFELT $ 7)
                                                                (QREFELT $ 8)
                                                                (QREFELT $ 9))
                                                               (|Union|
                                                                (|UnivariatePuiseuxSeries|
                                                                 (QREFELT $ 7)
                                                                 (QREFELT $ 8)
                                                                 (QREFELT $ 9))
                                                                #5#)
                                                               #2#))
                                             (QREFELT $ 62))))
                                     (#4#
                                      (|FS2EXPXP;stateProblem| |fcnName|
                                       "x in constant coefficient"
                                       $))))))))))))))))))) 

(SDEFUN |FS2EXPXP;applyBddIfCan|
        ((|fe| (FE))
         (|fcn|
          (|Mapping|
           #1=(|Union| (|UnivariatePuiseuxSeries| FE |x| |cen|) "failed")
           (|UnivariatePuiseuxSeries| FE |x| |cen|)))
         (|arg| (FE)) (|fcnName| (|String|)) (|posCheck?| (|Boolean|))
         ($
          (|Union|
           (|:| |%expansion| #2=(|ExponentialExpansion| R FE |x| |cen|))
           (|:| |%problem|
                #3=(|Record| (|:| |func| (|String|))
                             (|:| |prob| (|String|)))))))
        (SPROG
         ((|ans| #1#)
          (|f| (|Union| (|UnivariatePuiseuxSeries| FE |x| |cen|) "failed"))
          (|xxp| #2#) (#4=#:G1058 NIL) (|trouble| #3#)
          (|xxpArg|
           (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                    (|:| |%problem|
                         (|Record| (|:| |func| (|String|))
                                   (|:| |prob| (|String|)))))))
         (SEQ (LETT |xxpArg| (|FS2EXPXP;iExprToXXP| |arg| |posCheck?| $))
              (EXIT
               (COND
                ((QEQCAR |xxpArg| 1)
                 (SEQ (LETT |trouble| (CDR |xxpArg|))
                      (EXIT
                       (COND
                        ((EQUAL (QCDR |trouble|) "essential singularity")
                         (CONS 0
                               (SPADCALL
                                (SPADCALL |fe| (|spadConstant| $ 114)
                                          (QREFELT $ 113))
                                (QREFELT $ 62))))
                        (#5='T |xxpArg|)))))
                (#5#
                 (SEQ
                  (LETT |xxp|
                        (PROG2 (LETT #4# |xxpArg|)
                            (QCDR #4#)
                          (|check_union2| (QEQCAR #4# 0)
                                          (|ExponentialExpansion| (QREFELT $ 6)
                                                                  (QREFELT $ 7)
                                                                  (QREFELT $ 8)
                                                                  (QREFELT $
                                                                           9))
                                          (|Union|
                                           (|:| |%expansion|
                                                (|ExponentialExpansion|
                                                 (QREFELT $ 6) (QREFELT $ 7)
                                                 (QREFELT $ 8) (QREFELT $ 9)))
                                           (|:| |%problem|
                                                (|Record|
                                                 (|:| |func| (|String|))
                                                 (|:| |prob| (|String|)))))
                                          #4#)))
                  (LETT |f| (SPADCALL |xxp| (QREFELT $ 109)))
                  (EXIT
                   (COND
                    ((QEQCAR |f| 1)
                     (|FS2EXPXP;stateProblem| "exp"
                      "multiply nested exponential" $))
                    (#5#
                     (SEQ (LETT |ans| (SPADCALL (QCDR |f|) |fcn|))
                          (EXIT
                           (COND
                            ((QEQCAR |ans| 1)
                             (CONS 0
                                   (SPADCALL
                                    (SPADCALL |fe| (|spadConstant| $ 114)
                                              (QREFELT $ 113))
                                    (QREFELT $ 62))))
                            (#5#
                             (CONS 0
                                   (SPADCALL (QCDR |ans|)
                                             (QREFELT $ 62))))))))))))))))) 

(SDEFUN |FS2EXPXP;contOnReals?| ((|fcn| (|String|)) ($ (|Boolean|)))
        (SPADCALL |fcn| (QREFELT $ 137) (QREFELT $ 140))) 

(SDEFUN |FS2EXPXP;bddOnReals?| ((|fcn| (|String|)) ($ (|Boolean|)))
        (SPADCALL |fcn| (QREFELT $ 138) (QREFELT $ 140))) 

(SDEFUN |FS2EXPXP;opsInvolvingX| ((|fcn| (FE)) ($ (|List| (|BasicOperator|))))
        (SPROG
         ((|opList| (|List| #1=(|BasicOperator|))) (|op| #1#) (#2=#:G1076 NIL)
          (|k| NIL) (#3=#:G1075 NIL))
         (SEQ
          (LETT |opList|
                (PROGN
                 (LETT #3# NIL)
                 (SEQ (LETT |k| NIL)
                      (LETT #2# (SPADCALL |fcn| (QREFELT $ 142))) G190
                      (COND
                       ((OR (ATOM #2#) (PROGN (LETT |k| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((COND
                           ((SPADCALL (LETT |op| (SPADCALL |k| (QREFELT $ 48)))
                                      (QREFELT $ 143))
                            (SPADCALL (QREFELT $ 8)
                                      (SPADCALL
                                       (|SPADfirst|
                                        (SPADCALL |k| (QREFELT $ 29)))
                                       (QREFELT $ 145))
                                      (QREFELT $ 146)))
                           ('T NIL))
                          (LETT #3# (CONS |op| #3#))))))
                      (LETT #2# (CDR #2#)) (GO G190) G191
                      (EXIT (NREVERSE #3#)))))
          (EXIT (SPADCALL |opList| (QREFELT $ 148)))))) 

(SDEFUN |FS2EXPXP;opInOpList?|
        ((|name| (|Symbol|)) (|opList| (|List| (|BasicOperator|)))
         ($ (|Boolean|)))
        (SPROG ((#1=#:G1082 NIL) (#2=#:G1083 NIL) (#3=#:G1084 NIL) (|op| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |op| NIL) (LETT #3# |opList|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |op| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |op| |name| (QREFELT $ 81))
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# 'T) (GO #4=#:G1081)))
                              (GO #5=#:G1079))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT NIL)))
                #4# (EXIT #2#)))) 

(SDEFUN |FS2EXPXP;exponential?| ((|fcn| (FE)) ($ (|Boolean|)))
        (SPROG ((|ker| (|Union| (|Kernel| FE) "failed")))
               (SEQ (LETT |ker| (SPADCALL |fcn| (QREFELT $ 71)))
                    (EXIT
                     (COND
                      ((QEQCAR |ker| 0)
                       (SPADCALL (QCDR |ker|) '|exp| (QREFELT $ 38)))
                      ('T NIL)))))) 

(SDEFUN |FS2EXPXP;productOfNonZeroes?| ((|fcn| (FE)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G1101 NIL) (#2=#:G1102 NIL) (#3=#:G1103 NIL) (|term| NIL)
          (|prod| (|Union| (|List| FE) "failed")))
         (SEQ
          (EXIT
           (COND ((|FS2EXPXP;exponential?| |fcn| $) 'T)
                 (#4='T
                  (SEQ (LETT |prod| (SPADCALL |fcn| (QREFELT $ 67)))
                       (EXIT
                        (COND ((QEQCAR |prod| 1) NIL)
                              (#4#
                               (SEQ
                                (SEQ
                                 (EXIT
                                  (SEQ (LETT |term| NIL)
                                       (LETT #3# (QCDR |prod|)) G190
                                       (COND
                                        ((OR (ATOM #3#)
                                             (PROGN
                                              (LETT |term| (CAR #3#))
                                              NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (COND
                                          ((NULL
                                            (|FS2EXPXP;exponential?| |term| $))
                                           (COND
                                            ((SPADCALL (QREFELT $ 8)
                                                       (SPADCALL |term|
                                                                 (QREFELT $
                                                                          145))
                                                       (QREFELT $ 146))
                                             (PROGN
                                              (LETT #1#
                                                    (PROGN
                                                     (LETT #2# NIL)
                                                     (GO #5=#:G1100)))
                                              (GO #6=#:G1096))))))))
                                       (LETT #3# (CDR #3#)) (GO G190) G191
                                       (EXIT NIL)))
                                 #6# (EXIT #1#))
                                (EXIT 'T)))))))))
          #5# (EXIT #2#)))) 

(SDEFUN |FS2EXPXP;tranToXXP|
        ((|ker| (|Kernel| FE)) (|arg| (FE)) (|posCheck?| (|Boolean|))
         ($
          (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                   (|:| |%problem|
                        (|Record| (|:| |func| (|String|))
                                  (|:| |prob| (|String|)))))))
        (COND
         ((SPADCALL |ker| '|sin| (QREFELT $ 38))
          (|FS2EXPXP;applyBddIfCan| (SPADCALL |ker| (QREFELT $ 31)) (ELT $ 149)
           |arg| "sin" |posCheck?| $))
         ((SPADCALL |ker| '|cos| (QREFELT $ 38))
          (|FS2EXPXP;applyBddIfCan| (SPADCALL |ker| (QREFELT $ 31)) (ELT $ 150)
           |arg| "cos" |posCheck?| $))
         ((SPADCALL |ker| '|asin| (QREFELT $ 38))
          (|FS2EXPXP;applyIfCan| (ELT $ 151) |arg| "asin" |posCheck?| $))
         ((SPADCALL |ker| '|acos| (QREFELT $ 38))
          (|FS2EXPXP;applyIfCan| (ELT $ 152) |arg| "acos" |posCheck?| $))
         ((SPADCALL |ker| '|atan| (QREFELT $ 38))
          (|FS2EXPXP;atancotToXXP| (SPADCALL |ker| (QREFELT $ 31)) |arg|
           |posCheck?| 1 $))
         ((SPADCALL |ker| '|acot| (QREFELT $ 38))
          (|FS2EXPXP;atancotToXXP| (SPADCALL |ker| (QREFELT $ 31)) |arg|
           |posCheck?| -1 $))
         ((SPADCALL |ker| '|asec| (QREFELT $ 38))
          (|FS2EXPXP;applyIfCan| (ELT $ 153) |arg| "asec" |posCheck?| $))
         ((SPADCALL |ker| '|acsc| (QREFELT $ 38))
          (|FS2EXPXP;applyIfCan| (ELT $ 154) |arg| "acsc" |posCheck?| $))
         ((SPADCALL |ker| '|asinh| (QREFELT $ 38))
          (|FS2EXPXP;applyIfCan| (ELT $ 155) |arg| "asinh" |posCheck?| $))
         ('T
          (|FS2EXPXP;stateProblem|
           (SPADCALL (SPADCALL |ker| (QREFELT $ 116)) (QREFELT $ 118))
           "unknown kernel" $)))) 

(SDEFUN |FS2EXPXP;localAbs;2FE;32| ((|fcn| (FE)) ($ (FE)))
        (SPADCALL |fcn| (QREFELT $ 156))) 

(SDEFUN |FS2EXPXP;localAbs;2FE;33| ((|fcn| (FE)) ($ (FE)))
        (SPADCALL (SPADCALL |fcn| |fcn| (QREFELT $ 132)) (QREFELT $ 45))) 

(SDEFUN |FS2EXPXP;signOfExpression| ((|arg| (FE)) ($ (FE)))
        (SPADCALL (SPADCALL |arg| (QREFELT $ 157)) |arg| (QREFELT $ 20))) 

(SDEFUN |FS2EXPXP;atancotToXXP|
        ((|fe| (FE)) (|arg| (FE)) (|posCheck?| (|Boolean|))
         (|plusMinus| (|Integer|))
         ($
          (|Union| (|:| |%expansion| (|ExponentialExpansion| R FE |x| |cen|))
                   (|:| |%problem|
                        (|Record| (|:| |func| (|String|))
                                  (|:| |prob| (|String|)))))))
        (SPROG
         ((|cc| (FE)) (|n| (|Integer|)) (|posNegPi2| (FE))
          (|signum| (|Union| (|Integer|) "failed")) (|lc| (FE))
          (#1=#:G1159 NIL) (|rn| (|Union| (|Fraction| (|Integer|)) "failed"))
          (#2=#:G1158 NIL) (|yCoef| (FE))
          (|y| (|UnivariatePuiseuxSeries| FE |x| |cen|))
          (|ord| (|Fraction| (|Integer|))) (|coef| (FE))
          (|ups| #3=(|UnivariatePuiseuxSeries| FE |x| |cen|)) (#4=#:G1139 NIL)
          (|trouble|
           #5=(|Record| (|:| |func| (|String|)) (|:| |prob| (|String|))))
          (|result| (|Union| (|:| |%series| #3#) (|:| |%problem| #5#))))
         (SEQ
          (EXIT
           (SEQ (LETT |posCheck?| 'T)
                (LETT |result|
                      (SPADCALL |arg| |posCheck?| (CONS 3 "real: right side")
                                (QREFELT $ 124)))
                (EXIT
                 (COND
                  ((QEQCAR |result| 1)
                   (SEQ (LETT |trouble| (CDR |result|))
                        (EXIT
                         (COND
                          ((EQUAL (QCDR |trouble|) "essential singularity")
                           (CONS 0
                                 (SPADCALL
                                  (SPADCALL |fe| (|spadConstant| $ 114)
                                            (QREFELT $ 113))
                                  (QREFELT $ 62))))
                          (#6='T (CONS 1 (CDR |result|)))))))
                  (#6#
                   (SEQ
                    (EXIT
                     (SEQ
                      (LETT |ups|
                            (PROG2 (LETT #4# |result|)
                                (QCDR #4#)
                              (|check_union2| (QEQCAR #4# 0)
                                              (|UnivariatePuiseuxSeries|
                                               (QREFELT $ 7) (QREFELT $ 8)
                                               (QREFELT $ 9))
                                              (|Union|
                                               (|:| |%series|
                                                    (|UnivariatePuiseuxSeries|
                                                     (QREFELT $ 7)
                                                     (QREFELT $ 8)
                                                     (QREFELT $ 9)))
                                               (|:| |%problem|
                                                    (|Record|
                                                     (|:| |func| (|String|))
                                                     (|:| |prob| (|String|)))))
                                              #4#)))
                      (LETT |coef|
                            (SPADCALL |ups| (|spadConstant| $ 114)
                                      (QREFELT $ 76)))
                      (SEQ
                       (LETT |ord|
                             (SPADCALL |ups| (|spadConstant| $ 114)
                                       (QREFELT $ 80)))
                       (EXIT
                        (COND
                         ((SPADCALL |ord| (|spadConstant| $ 114)
                                    (QREFELT $ 158))
                          (COND
                           ((SPADCALL (SPADCALL |coef| |coef| (QREFELT $ 132))
                                      (SPADCALL (|spadConstant| $ 10)
                                                (QREFELT $ 159))
                                      (QREFELT $ 78))
                            (PROGN
                             (LETT #2#
                                   (SEQ
                                    (LETT |y|
                                          (SPADCALL
                                           (SPADCALL |ups| (QREFELT $ 160))
                                           (SPADCALL (|spadConstant| $ 161)
                                                     (SPADCALL |ups| |ups|
                                                               (QREFELT $ 126))
                                                     (QREFELT $ 135))
                                           (QREFELT $ 133)))
                                    (LETT |yCoef|
                                          (SPADCALL |y|
                                                    (SPADCALL
                                                     (|spadConstant| $ 112)
                                                     (QREFELT $ 162))
                                                    (QREFELT $ 76)))
                                    (EXIT
                                     (CONS 0
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL |yCoef| (QREFELT $ 46))
                                              (|spadConstant| $ 114)
                                              (QREFELT $ 113))
                                             (SPADCALL
                                              (SPADCALL |y|
                                                        (SPADCALL |yCoef|
                                                                  (SPADCALL
                                                                   (|spadConstant|
                                                                    $ 112)
                                                                   (QREFELT $
                                                                            162))
                                                                  (QREFELT $
                                                                           113))
                                                        (QREFELT $ 125))
                                              (QREFELT $ 163))
                                             (QREFELT $ 135))
                                            (QREFELT $ 62))))))
                             (GO #7=#:G1155))))))))
                      (LETT |cc|
                            (COND
                             ((SPADCALL |ord| (|spadConstant| $ 114)
                                        (QREFELT $ 119))
                              (SEQ
                               (LETT |rn|
                                     (|FS2EXPXP;ratIfCan|
                                      (SPADCALL |ord| (QREFELT $ 102)) $))
                               (EXIT
                                (COND
                                 ((QEQCAR |rn| 1)
                                  (PROGN
                                   (LETT #1#
                                         (|FS2EXPXP;stateProblem| "atan"
                                          "branch problem" $))
                                   (GO #8=#:G1157)))
                                 (#6#
                                  (SEQ
                                   (LETT |lc|
                                         (SPADCALL |ups| |ord| (QREFELT $ 76)))
                                   (LETT |signum|
                                         (SPADCALL |lc| (QREFELT $ 96)))
                                   (EXIT
                                    (COND
                                     ((QEQCAR |signum| 1)
                                      (SEQ
                                       (LETT |posNegPi2|
                                             (SPADCALL
                                              (SPADCALL
                                               (|FS2EXPXP;signOfExpression|
                                                |lc| $)
                                               (SPADCALL (QREFELT $ 164))
                                               (QREFELT $ 132))
                                              (SPADCALL 2 (QREFELT $ 40))
                                              (QREFELT $ 20)))
                                       (EXIT
                                        (COND ((EQL |plusMinus| 1) |posNegPi2|)
                                              (#6#
                                               (SPADCALL
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 164))
                                                 (SPADCALL 2 (QREFELT $ 40))
                                                 (QREFELT $ 20))
                                                |posNegPi2|
                                                (QREFELT $ 39)))))))
                                     ((EQL (LETT |n| (QCDR |signum|)) -1)
                                      (COND
                                       ((EQL |plusMinus| 1)
                                        (SPADCALL
                                         (SPADCALL (SPADCALL (QREFELT $ 164))
                                                   (SPADCALL 2 (QREFELT $ 40))
                                                   (QREFELT $ 20))
                                         (QREFELT $ 159)))
                                       (#6# (SPADCALL (QREFELT $ 164)))))
                                     ((EQL |plusMinus| 1)
                                      (SPADCALL (SPADCALL (QREFELT $ 164))
                                                (SPADCALL 2 (QREFELT $ 40))
                                                (QREFELT $ 20)))
                                     (#6# (|spadConstant| $ 77))))))))))
                             (#6# (SPADCALL |coef| (QREFELT $ 165)))))
                      (EXIT
                       (CONS 0
                             (SPADCALL
                              (SPADCALL (SPADCALL |cc| (QREFELT $ 128))
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |ups| (QREFELT $ 160))
                                          (SPADCALL (|spadConstant| $ 161)
                                                    (SPADCALL |ups| |ups|
                                                              (QREFELT $ 126))
                                                    (QREFELT $ 135))
                                          (QREFELT $ 133))
                                         (QREFELT $ 163))
                                        (QREFELT $ 135))
                              (QREFELT $ 62))))))
                    #7# (EXIT #2#)))))))
          #8# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |FunctionSpaceToExponentialExpansion;|)) 

(DEFUN |FunctionSpaceToExponentialExpansion| (&REST #1=#:G1160)
  (SPROG NIL
         (PROG (#2=#:G1161)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T T NIL NIL))
                     (HGET |$ConstructorCache|
                           '|FunctionSpaceToExponentialExpansion|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |FunctionSpaceToExponentialExpansion;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|FunctionSpaceToExponentialExpansion|)))))))))) 

(DEFUN |FunctionSpaceToExponentialExpansion;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 |#3|)
    (LETT DV$4 |#4|)
    (LETT |dv$|
          (LIST '|FunctionSpaceToExponentialExpansion| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 166))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|FunctionSpaceToExponentialExpansion|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 14 (SPADCALL 1000 1 (QREFELT $ 13)))
    (QSETREFV $ 137 (LIST #1="sin" #2="cos" #3="atan" #4="acot" "exp" "asinh"))
    (QSETREFV $ 138 (LIST #1# #2# #3# #4#))
    (COND
     ((|HasSignature| |#2|
                      (LIST '|abs|
                            (LIST (|devaluate| |#2|) (|devaluate| |#2|))))
      (QSETREFV $ 157
                (CONS (|dispatchFunction| |FS2EXPXP;localAbs;2FE;32|) $)))
     ('T
      (QSETREFV $ 157
                (CONS (|dispatchFunction| |FS2EXPXP;localAbs;2FE;33|) $))))
    $))) 

(MAKEPROP '|FunctionSpaceToExponentialExpansion| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (0 . |One|) (|Integer|)
              (|Fraction| 11) (4 . /) 'ZEROCOUNT (|Union| 12 '#1="failed")
              (10 . |retractIfCan|) (|SparseMultivariatePolynomial| 6 30)
              (15 . |numer|) (20 . |denom|) (25 . /) (31 . |coerce|)
              (|Mapping| 7 28) (|Mapping| 7 6)
              (|SparseMultivariatePolynomial| 6 28)
              (|PolynomialCategoryLifting| (|IndexedExponents| 28) 28 6 24 7)
              (36 . |map|) (|List| 7) (|Kernel| 7) (43 . |argument|)
              (|Kernel| $) (48 . |coerce|) (53 . |exp|) (58 . |inv|)
              (63 . |sin|) (68 . |cos|) (|Boolean|) (|Symbol|) (73 . |is?|)
              (79 . -) (85 . |coerce|) (90 . +) (|PositiveInteger|) (96 . *)
              (102 . ^) (108 . |sqrt|) (113 . |log|) (|BasicOperator|)
              (118 . |operator|) (|List| $) (123 . |elt|)
              (|Record| (|:| |func| 117) (|:| |prob| 117))
              (|Union| (|:| |%expansion| 61) (|:| |%problem| 51))
              |FS2EXPXP;exprToXXP;FEBU;7| (|Union| (|Polynomial| 6) '#1#)
              (129 . |retractIfCan|)
              (|Union| (|:| |%series| 60) (|:| |%problem| 51))
              (|Union| '"complex" '"real: two sides" '"real: left side"
                       '"real: right side" '"just do it")
              (|FunctionSpaceToUnivariatePowerSeries| 6 7 12 60 98
                                                      (|UnivariateTaylorSeries|
                                                       7
                                                       (NRTEVAL (QREFELT $ 8))
                                                       (NRTEVAL (QREFELT $ 9)))
                                                      (|TaylorSeriesExpansionPuiseux|
                                                       7
                                                       (|UnivariateTaylorSeries|
                                                        7
                                                        (NRTEVAL (QREFELT $ 8))
                                                        (NRTEVAL
                                                         (QREFELT $ 9)))
                                                       (|UnivariateLaurentSeries|
                                                        7
                                                        (NRTEVAL (QREFELT $ 8))
                                                        (NRTEVAL
                                                         (QREFELT $ 9)))
                                                       60)
                                                      (NRTEVAL (QREFELT $ 8)))
              (134 . |exprToUPS|)
              (|UnivariatePuiseuxSeries| 7 (NRTEVAL (QREFELT $ 8))
                                         (NRTEVAL (QREFELT $ 9)))
              (|ExponentialExpansion| 6 7 (NRTEVAL (QREFELT $ 8))
                                      (NRTEVAL (QREFELT $ 9)))
              (141 . |coerce|) (|Union| 49 '#2="failed") (146 . |isPlus|)
              (151 . |Zero|) (155 . +) (161 . |isTimes|) (166 . |One|)
              (170 . *) (|Union| 30 '#1#) (176 . |retractIfCan|)
              (|Record| (|:| |val| $) (|:| |exponent| 11)) (|Union| 72 '#2#)
              (181 . |isPower|) (186 . |degree|) (191 . |coefficient|)
              (197 . |Zero|) (201 . =) (207 . +) (213 . |order|) (219 . |is?|)
              (225 . ^)
              (|UnivariatePuiseuxSeriesWithExponentialSingularity| 6 7
                                                                   (NRTEVAL
                                                                    (QREFELT $
                                                                             8))
                                                                   (NRTEVAL
                                                                    (QREFELT $
                                                                             9)))
              (231 . |numer|) (|NonNegativeInteger|)
              (236 . |numberOfMonomials|) (241 . |leadingCoefficient|)
              (|Union| $ '"failed") (246 . |recip|) (251 . |denom|) (256 . ^)
              (262 . *) (268 . |coerce|) (|Union| 11 '"failed")
              (|ElementaryFunctionSign| 6 7) (273 . |sign|)
              (|Union| 60 '"failed")
              (|ElementaryFunctionsUnivariatePuiseuxSeries| 7
                                                            (|UnivariateLaurentSeries|
                                                             7
                                                             (NRTEVAL
                                                              (QREFELT $ 8))
                                                             (NRTEVAL
                                                              (QREFELT $ 9)))
                                                            60
                                                            (|ElementaryFunctionsUnivariateLaurentSeries|
                                                             7
                                                             (|UnivariateTaylorSeries|
                                                              7
                                                              (NRTEVAL
                                                               (QREFELT $ 8))
                                                              (NRTEVAL
                                                               (QREFELT $ 9)))
                                                             (|UnivariateLaurentSeries|
                                                              7
                                                              (NRTEVAL
                                                               (QREFELT $ 8))
                                                              (NRTEVAL
                                                               (QREFELT $
                                                                        9)))))
              (278 . |nthRootIfCan|) (284 . |reductum|) (289 . |zero?|)
              (294 . |coerce|)
              (|ExponentialOfUnivariatePuiseuxSeries| 7 (NRTEVAL (QREFELT $ 8))
                                                      (NRTEVAL (QREFELT $ 9)))
              (299 . |degree|) (304 . *) (310 . |monomial|) (316 . /)
              (322 . |second|) (327 . |retractIfCan|) (|Union| 37 '"failed")
              (332 . |symbolIfCan|) (337 . |One|) (341 . |monomial|)
              (347 . |Zero|) (351 . |retract|) (356 . |name|) (|String|)
              (361 . |string|) (366 . <) (372 . >) (378 . |exp|)
              (|ElementaryFunctionStructurePackage| 6 7) (383 . |normalize|)
              (389 . |exprToGenUPS|) (396 . -) (402 . *) (408 . |truncate|)
              (414 . |coerce|) (419 . |exponential|) (424 . |coerce|) (429 . ^)
              (435 . *) (441 . /) (447 . |log|) (452 . +) (458 . |exponent|)
              'CONTFCNS 'BDDFCNS (|List| 117) (463 . |member?|) (|List| 30)
              (469 . |tower|) (474 . |unary?|) (|List| 37) (479 . |variables|)
              (484 . |member?|) (|List| 47) (490 . |removeDuplicates|)
              (495 . |sinIfCan|) (500 . |cosIfCan|) (505 . |asinIfCan|)
              (510 . |acosIfCan|) (515 . |asecIfCan|) (520 . |acscIfCan|)
              (525 . |asinhIfCan|) (530 . |abs|) (535 . |localAbs|) (540 . =)
              (546 . -) (551 . |differentiate|) (556 . |One|) (560 . -)
              (565 . |integrate|) (570 . |pi|) (574 . |atan|))
           '#(|localAbs| 579 |exprToXXP| 584) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|exprToXXP|
                                 ((|Union|
                                   (|:| |%expansion|
                                        (|ExponentialExpansion| |#1| |#2| |#3|
                                                                |#4|))
                                   (|:| |%problem|
                                        (|Record| (|:| |func| (|String|))
                                                  (|:| |prob| (|String|)))))
                                  |#2| (|Boolean|)))
                                T)
                              '((|localAbs| (|#2| |#2|)) T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 165
                                            '(0 7 0 10 2 12 0 11 11 13 1 7 15 0
                                              16 1 7 17 0 18 1 7 17 0 19 2 7 0
                                              0 0 20 1 7 0 6 21 3 25 7 22 23 24
                                              26 1 28 27 0 29 1 7 0 30 31 1 7 0
                                              0 32 1 7 0 0 33 1 7 0 0 34 1 7 0
                                              0 35 2 28 36 0 37 38 2 7 0 0 0 39
                                              1 7 0 11 40 2 7 0 0 0 41 2 7 0 42
                                              0 43 2 7 0 0 42 44 1 7 0 0 45 1 7
                                              0 0 46 1 28 47 0 48 2 7 0 47 49
                                              50 1 7 54 0 55 3 58 56 7 36 57 59
                                              1 61 0 60 62 1 7 63 0 64 0 61 0
                                              65 2 61 0 0 0 66 1 7 63 0 67 0 61
                                              0 68 2 61 0 0 0 69 1 7 70 0 71 1
                                              7 73 0 74 1 60 12 0 75 2 60 7 0
                                              12 76 0 7 0 77 2 7 36 0 0 78 2 12
                                              0 0 0 79 2 60 12 0 12 80 2 47 36
                                              0 37 81 2 61 0 0 11 82 1 61 83 0
                                              84 1 83 85 0 86 1 83 60 0 87 1 83
                                              88 0 89 1 61 83 0 90 2 83 0 0 85
                                              91 2 83 0 0 0 92 1 61 0 83 93 1
                                              95 94 7 96 2 98 97 60 85 99 1 83
                                              0 0 100 1 83 36 0 101 1 7 0 12
                                              102 1 83 103 0 104 2 103 0 7 0
                                              105 2 83 0 60 103 106 2 61 0 83
                                              83 107 1 27 7 0 108 1 61 97 0 109
                                              1 28 110 0 111 0 12 0 112 2 60 0
                                              7 12 113 0 12 0 114 1 7 11 0 115
                                              1 28 37 0 116 1 37 117 0 118 2 12
                                              36 0 0 119 2 12 36 0 0 120 1 98
                                              60 60 121 2 122 7 7 37 123 3 58
                                              56 7 36 57 124 2 60 0 0 0 125 2
                                              60 0 0 0 126 2 60 0 0 12 127 1 60
                                              0 7 128 1 103 0 60 129 1 7 0 37
                                              130 2 7 0 0 0 131 2 7 0 0 0 132 2
                                              60 0 0 0 133 1 98 60 60 134 2 60
                                              0 0 0 135 1 103 60 0 136 2 139 36
                                              117 0 140 1 7 141 0 142 1 47 36 0
                                              143 1 7 144 0 145 2 144 36 37 0
                                              146 1 147 0 0 148 1 98 97 60 149
                                              1 98 97 60 150 1 98 97 60 151 1
                                              98 97 60 152 1 98 97 60 153 1 98
                                              97 60 154 1 98 97 60 155 1 7 0 0
                                              156 1 0 7 7 157 2 12 36 0 0 158 1
                                              7 0 0 159 1 60 0 0 160 0 60 0 161
                                              1 12 0 0 162 1 60 0 0 163 0 7 0
                                              164 1 7 0 0 165 1 0 7 7 157 2 0
                                              52 7 36 53)))))
           '|lookupComplete|)) 
