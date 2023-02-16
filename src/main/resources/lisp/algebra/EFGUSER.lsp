
(SDEFUN |EFGUSER;apply_taylor1|
        ((|ft| (|Mapping| (|Stream| |Coef|) (|Stream| |Coef|))) (|x| (PS))
         ($ (|Union| PS "failed")))
        (SPROG
         ((|fxu| (|Union| (|Stream| |Coef|) "failed")) (|s1| (|Stream| |Coef|))
          (|c0| (|Coef|)))
         (SEQ (LETT |x| (SPADCALL |x| (|spadConstant| $ 11) (QREFELT $ 12)))
              (EXIT
               (COND
                ((SPADCALL (SPADCALL |x| (QREFELT $ 13)) (|spadConstant| $ 11)
                           (QREFELT $ 15))
                 (CONS 1 "failed"))
                (#1='T
                 (SEQ
                  (LETT |c0|
                        (SPADCALL |x| (|spadConstant| $ 11) (QREFELT $ 16)))
                  (LETT |s1|
                        (SPADCALL (SPADCALL |c0| 0 (QREFELT $ 20))
                                  (SPADCALL (|spadConstant| $ 21) 1
                                            (QREFELT $ 20))
                                  (QREFELT $ 23)))
                  (LETT |fxu| (|trappedSpadEval| (SPADCALL |s1| |ft|)))
                  (EXIT
                   (COND ((QEQCAR |fxu| 1) (CONS 1 "failed"))
                         (#1#
                          (CONS 0
                                (SPADCALL (QCDR |fxu|)
                                          (SPADCALL |x|
                                                    (SPADCALL |c0|
                                                              (|spadConstant| $
                                                                              11)
                                                              (QREFELT $ 24))
                                                    (QREFELT $ 25))
                                          (QREFELT $ 26))))))))))))) 

(SDEFUN |EFGUSER;nthRootIfCan;PSNniU;2|
        ((|x| (PS)) (|n| (|NonNegativeInteger|)) ($ (|Union| PS "failed")))
        (SPROG
         ((|res1| (|Union| PS "failed")) (|x1| (PS)) (|c0| (|Coef|))
          (|ord| (|Expon|)) (|i| NIL))
         (SEQ
          (COND ((EQL |n| 0) (CONS 0 (|spadConstant| $ 22)))
                ((EQL |n| 1) (CONS 0 |x|))
                (#1='T
                 (SEQ
                  (LETT |x|
                        (SPADCALL |x| (|spadConstant| $ 11) (QREFELT $ 12)))
                  (LETT |ord| (SPADCALL |x| (QREFELT $ 13)))
                  (COND
                   ((SPADCALL |ord| (|spadConstant| $ 11) (QREFELT $ 27))
                    (SEQ (LETT |i| 0) G190
                         (COND
                          ((OR (|greater_SI| |i| 50)
                               (NULL
                                (SPADCALL (SPADCALL |x| |ord| (QREFELT $ 16))
                                          (|spadConstant| $ 10)
                                          (QREFELT $ 28))))
                           (GO G191)))
                         (SEQ
                          (LETT |x|
                                (SPADCALL |x|
                                          (SPADCALL |ord|
                                                    (SPADCALL 10
                                                              (|spadConstant| $
                                                                              29)
                                                              (QREFELT $ 31))
                                                    (QREFELT $ 32))
                                          (QREFELT $ 12)))
                          (EXIT (LETT |ord| (SPADCALL |x| (QREFELT $ 13)))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))))
                  (LETT |c0| (SPADCALL |x| |ord| (QREFELT $ 16)))
                  (EXIT
                   (COND
                    ((SPADCALL |c0| (|spadConstant| $ 10) (QREFELT $ 28))
                     (CONS 1 "failed"))
                    (#1#
                     (SEQ
                      (LETT |x1|
                            (SPADCALL
                             (SPADCALL (|spadConstant| $ 21)
                                       (SPADCALL
                                        (SPADCALL (|spadConstant| $ 29)
                                                  (QREFELT $ 37))
                                        |ord| (QREFELT $ 38))
                                       (QREFELT $ 24))
                             |x| (QREFELT $ 39)))
                      (LETT |res1|
                            (|EFGUSER;apply_taylor1|
                             (CONS #'|EFGUSER;nthRootIfCan;PSNniU;2!0|
                                   (VECTOR |n| $))
                             |x1| $))
                      (EXIT
                       (COND ((QEQCAR |res1| 1) (CONS 1 "failed"))
                             (#1#
                              (CONS 0
                                    (SPADCALL
                                     (SPADCALL (|spadConstant| $ 21)
                                               (SPADCALL
                                                (SPADCALL 1 |n| (QREFELT $ 41))
                                                |ord| (QREFELT $ 43))
                                               (QREFELT $ 24))
                                     (QCDR |res1|) (QREFELT $ 39)))))))))))))))) 

(SDEFUN |EFGUSER;nthRootIfCan;PSNniU;2!0| ((|s| NIL) ($$ NIL))
        (PROG ($ |n|)
          (LETT $ (QREFELT $$ 1))
          (LETT |n| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL (|spadConstant| $ 40) |n| (QREFELT $ 41)) |s|
                      (QREFELT $ 42)))))) 

(SDEFUN |EFGUSER;expIfCan;PSU;3| ((|x| (PS)) ($ (|Union| PS "failed")))
        (SPROG ((|c1| (|Coef|)) (|expx| (|Stream| |Coef|)))
               (SEQ
                (LETT |x| (SPADCALL |x| (|spadConstant| $ 11) (QREFELT $ 12)))
                (EXIT
                 (COND
                  ((SPADCALL (SPADCALL |x| (QREFELT $ 13))
                             (|spadConstant| $ 11) (QREFELT $ 15))
                   (CONS 1 "failed"))
                  (#1='T
                   (SEQ
                    (LETT |expx|
                          (SPADCALL
                           (SPADCALL (|spadConstant| $ 21) 1 (QREFELT $ 20))
                           (QREFELT $ 48)))
                    (LETT |c1|
                          (SPADCALL |x| (|spadConstant| $ 11) (QREFELT $ 16)))
                    (EXIT
                     (COND
                      ((SPADCALL |c1| (|spadConstant| $ 10) (QREFELT $ 28))
                       (CONS 0 (SPADCALL |expx| |x| (QREFELT $ 26))))
                      ((QREFELT $ 9)
                       (CONS 0
                             (SPADCALL (SPADCALL |c1| (QREFELT $ 49))
                                       (SPADCALL |expx|
                                                 (SPADCALL |x|
                                                           (SPADCALL |c1|
                                                                     (|spadConstant|
                                                                      $ 11)
                                                                     (QREFELT $
                                                                              24))
                                                           (QREFELT $ 25))
                                                 (QREFELT $ 26))
                                       (QREFELT $ 50))))
                      (#1# (CONS 1 "failed"))))))))))) 

(SDEFUN |EFGUSER;logIfCan;PSU;4| ((|x| (PS)) ($ (|Union| PS "failed")))
        (|EFGUSER;apply_taylor1| (ELT $ 52) |x| $)) 

(SDEFUN |EFGUSER;sincos|
        ((|x| (PS))
         ($ (|Union| (|Record| (|:| |sin| PS) (|:| |cos| PS)) "failed")))
        (SPROG
         ((|cc1| (|Coef|)) (|sc1| (|Coef|)) (|cx1| (PS)) (|sx1| (PS))
          (|x1| (PS)) (|c1| (|Coef|))
          (|scst|
           (|Record| (|:| |sin| (|Stream| |Coef|))
                     (|:| |cos| (|Stream| |Coef|)))))
         (SEQ (LETT |x| (SPADCALL |x| (|spadConstant| $ 11) (QREFELT $ 12)))
              (EXIT
               (COND
                ((SPADCALL (SPADCALL |x| (QREFELT $ 13)) (|spadConstant| $ 11)
                           (QREFELT $ 15))
                 (CONS 1 "failed"))
                (#1='T
                 (SEQ
                  (LETT |scst|
                        (SPADCALL
                         (SPADCALL (|spadConstant| $ 21) 1 (QREFELT $ 20))
                         (QREFELT $ 55)))
                  (LETT |c1|
                        (SPADCALL |x| (|spadConstant| $ 11) (QREFELT $ 16)))
                  (EXIT
                   (COND
                    ((SPADCALL |c1| (|spadConstant| $ 10) (QREFELT $ 28))
                     (CONS 0
                           (CONS (SPADCALL (QCAR |scst|) |x| (QREFELT $ 26))
                                 (SPADCALL (QCDR |scst|) |x| (QREFELT $ 26)))))
                    ((QREFELT $ 9)
                     (SEQ
                      (LETT |x1|
                            (SPADCALL |x|
                                      (SPADCALL |c1| (|spadConstant| $ 11)
                                                (QREFELT $ 24))
                                      (QREFELT $ 25)))
                      (LETT |sx1| (SPADCALL (QCAR |scst|) |x1| (QREFELT $ 26)))
                      (LETT |cx1| (SPADCALL (QCDR |scst|) |x1| (QREFELT $ 26)))
                      (LETT |sc1| (SPADCALL |c1| (QREFELT $ 56)))
                      (LETT |cc1| (SPADCALL |c1| (QREFELT $ 57)))
                      (EXIT
                       (CONS 0
                             (CONS
                              (SPADCALL (SPADCALL |sc1| |cx1| (QREFELT $ 50))
                                        (SPADCALL |cc1| |sx1| (QREFELT $ 50))
                                        (QREFELT $ 58))
                              (SPADCALL (SPADCALL |cc1| |cx1| (QREFELT $ 50))
                                        (SPADCALL |sc1| |sx1| (QREFELT $ 50))
                                        (QREFELT $ 25)))))))
                    (#1# (CONS 1 "failed"))))))))))) 

(SDEFUN |EFGUSER;sinIfCan;PSU;6| ((|x| (PS)) ($ (|Union| PS "failed")))
        (SPROG
         ((|usc| (|Union| (|Record| (|:| |sin| PS) (|:| |cos| PS)) "failed")))
         (SEQ (LETT |usc| (|EFGUSER;sincos| |x| $))
              (EXIT
               (COND ((QEQCAR |usc| 1) (CONS 1 "failed"))
                     ('T (CONS 0 (QCAR (QCDR |usc|))))))))) 

(SDEFUN |EFGUSER;cosIfCan;PSU;7| ((|x| (PS)) ($ (|Union| PS "failed")))
        (SPROG
         ((|usc| (|Union| (|Record| (|:| |sin| PS) (|:| |cos| PS)) "failed")))
         (SEQ (LETT |usc| (|EFGUSER;sincos| |x| $))
              (EXIT
               (COND ((QEQCAR |usc| 1) (CONS 1 "failed"))
                     ('T (CONS 0 (QCDR (QCDR |usc|))))))))) 

(SDEFUN |EFGUSER;tanIfCan;PSU;8| ((|x| (PS)) ($ (|Union| PS "failed")))
        (SPROG
         ((|usc| (|Union| (|Record| (|:| |sin| PS) (|:| |cos| PS)) "failed")))
         (SEQ (LETT |usc| (|EFGUSER;sincos| |x| $))
              (EXIT
               (COND ((QEQCAR |usc| 1) (CONS 1 "failed"))
                     ('T
                      (SPADCALL (QCAR (QCDR |usc|)) (QCDR (QCDR |usc|))
                                (QREFELT $ 61)))))))) 

(SDEFUN |EFGUSER;cotIfCan;PSU;9| ((|x| (PS)) ($ (|Union| PS "failed")))
        (SPROG
         ((|usc| (|Union| (|Record| (|:| |sin| PS) (|:| |cos| PS)) "failed")))
         (SEQ (LETT |usc| (|EFGUSER;sincos| |x| $))
              (EXIT
               (COND ((QEQCAR |usc| 1) (CONS 1 "failed"))
                     ('T
                      (SPADCALL (QCDR (QCDR |usc|)) (QCAR (QCDR |usc|))
                                (QREFELT $ 61)))))))) 

(SDEFUN |EFGUSER;secIfCan;PSU;10| ((|x| (PS)) ($ (|Union| PS "failed")))
        (SPROG
         ((|usc| (|Union| (|Record| (|:| |sin| PS) (|:| |cos| PS)) "failed")))
         (SEQ (LETT |usc| (|EFGUSER;sincos| |x| $))
              (EXIT
               (COND ((QEQCAR |usc| 1) (CONS 1 "failed"))
                     ('T
                      (SPADCALL (|spadConstant| $ 22) (QCDR (QCDR |usc|))
                                (QREFELT $ 61)))))))) 

(SDEFUN |EFGUSER;cscIfCan;PSU;11| ((|x| (PS)) ($ (|Union| PS "failed")))
        (SPROG
         ((|usc| (|Union| (|Record| (|:| |sin| PS) (|:| |cos| PS)) "failed")))
         (SEQ (LETT |usc| (|EFGUSER;sincos| |x| $))
              (EXIT
               (COND ((QEQCAR |usc| 1) (CONS 1 "failed"))
                     ('T
                      (SPADCALL (|spadConstant| $ 22) (QCAR (QCDR |usc|))
                                (QREFELT $ 61)))))))) 

(SDEFUN |EFGUSER;asinIfCan;PSU;12| ((|x| (PS)) ($ (|Union| PS "failed")))
        (|EFGUSER;apply_taylor1| (ELT $ 66) |x| $)) 

(SDEFUN |EFGUSER;acosIfCan;PSU;13| ((|x| (PS)) ($ (|Union| PS "failed")))
        (|EFGUSER;apply_taylor1| (ELT $ 68) |x| $)) 

(SDEFUN |EFGUSER;atanIfCan;PSU;14| ((|x| (PS)) ($ (|Union| PS "failed")))
        (|EFGUSER;apply_taylor1| (ELT $ 70) |x| $)) 

(SDEFUN |EFGUSER;acotIfCan;PSU;15| ((|x| (PS)) ($ (|Union| PS "failed")))
        (|EFGUSER;apply_taylor1| (ELT $ 72) |x| $)) 

(SDEFUN |EFGUSER;asecIfCan;PSU;16| ((|x| (PS)) ($ (|Union| PS "failed")))
        (|EFGUSER;apply_taylor1| (ELT $ 74) |x| $)) 

(SDEFUN |EFGUSER;acscIfCan;PSU;17| ((|x| (PS)) ($ (|Union| PS "failed")))
        (|EFGUSER;apply_taylor1| (ELT $ 76) |x| $)) 

(SDEFUN |EFGUSER;sinhcosh|
        ((|x| (PS))
         ($ (|Union| (|Record| (|:| |sinh| PS) (|:| |cosh| PS)) "failed")))
        (SPROG
         ((|cc1| (|Coef|)) (|sc1| (|Coef|)) (|cx1| (PS)) (|sx1| (PS))
          (|x1| (PS)) (|c1| (|Coef|))
          (|scst|
           (|Record| (|:| |sinh| (|Stream| |Coef|))
                     (|:| |cosh| (|Stream| |Coef|)))))
         (SEQ (LETT |x| (SPADCALL |x| (|spadConstant| $ 11) (QREFELT $ 12)))
              (EXIT
               (COND
                ((SPADCALL (SPADCALL |x| (QREFELT $ 13)) (|spadConstant| $ 11)
                           (QREFELT $ 15))
                 (CONS 1 "failed"))
                (#1='T
                 (SEQ
                  (LETT |scst|
                        (SPADCALL
                         (SPADCALL (|spadConstant| $ 21) 1 (QREFELT $ 20))
                         (QREFELT $ 79)))
                  (LETT |c1|
                        (SPADCALL |x| (|spadConstant| $ 11) (QREFELT $ 16)))
                  (EXIT
                   (COND
                    ((SPADCALL |c1| (|spadConstant| $ 10) (QREFELT $ 28))
                     (CONS 0
                           (CONS (SPADCALL (QCAR |scst|) |x| (QREFELT $ 26))
                                 (SPADCALL (QCDR |scst|) |x| (QREFELT $ 26)))))
                    ((QREFELT $ 9)
                     (SEQ
                      (LETT |x1|
                            (SPADCALL |x|
                                      (SPADCALL |c1| (|spadConstant| $ 11)
                                                (QREFELT $ 24))
                                      (QREFELT $ 25)))
                      (LETT |sx1| (SPADCALL (QCAR |scst|) |x1| (QREFELT $ 26)))
                      (LETT |cx1| (SPADCALL (QCDR |scst|) |x1| (QREFELT $ 26)))
                      (LETT |sc1| (SPADCALL |c1| (QREFELT $ 80)))
                      (LETT |cc1| (SPADCALL |c1| (QREFELT $ 81)))
                      (EXIT
                       (CONS 0
                             (CONS
                              (SPADCALL (SPADCALL |sc1| |cx1| (QREFELT $ 50))
                                        (SPADCALL |cc1| |sx1| (QREFELT $ 50))
                                        (QREFELT $ 58))
                              (SPADCALL (SPADCALL |cc1| |cx1| (QREFELT $ 50))
                                        (SPADCALL |sc1| |sx1| (QREFELT $ 50))
                                        (QREFELT $ 58)))))))
                    (#1# (CONS 1 "failed"))))))))))) 

(SDEFUN |EFGUSER;sinhIfCan;PSU;19| ((|x| (PS)) ($ (|Union| PS "failed")))
        (SPROG
         ((|usc|
           (|Union| (|Record| (|:| |sinh| PS) (|:| |cosh| PS)) "failed")))
         (SEQ (LETT |usc| (|EFGUSER;sinhcosh| |x| $))
              (EXIT
               (COND ((QEQCAR |usc| 1) (CONS 1 "failed"))
                     ('T (CONS 0 (QCAR (QCDR |usc|))))))))) 

(SDEFUN |EFGUSER;coshIfCan;PSU;20| ((|x| (PS)) ($ (|Union| PS "failed")))
        (SPROG
         ((|usc|
           (|Union| (|Record| (|:| |sinh| PS) (|:| |cosh| PS)) "failed")))
         (SEQ (LETT |usc| (|EFGUSER;sinhcosh| |x| $))
              (EXIT
               (COND ((QEQCAR |usc| 1) (CONS 1 "failed"))
                     ('T (CONS 0 (QCDR (QCDR |usc|))))))))) 

(SDEFUN |EFGUSER;tanhIfCan;PSU;21| ((|x| (PS)) ($ (|Union| PS "failed")))
        (SPROG
         ((|usc|
           (|Union| (|Record| (|:| |sinh| PS) (|:| |cosh| PS)) "failed")))
         (SEQ (LETT |usc| (|EFGUSER;sinhcosh| |x| $))
              (EXIT
               (COND ((QEQCAR |usc| 1) (CONS 1 "failed"))
                     ('T
                      (SPADCALL (QCAR (QCDR |usc|)) (QCDR (QCDR |usc|))
                                (QREFELT $ 61)))))))) 

(SDEFUN |EFGUSER;cothIfCan;PSU;22| ((|x| (PS)) ($ (|Union| PS "failed")))
        (SPROG
         ((|usc|
           (|Union| (|Record| (|:| |sinh| PS) (|:| |cosh| PS)) "failed")))
         (SEQ (LETT |usc| (|EFGUSER;sinhcosh| |x| $))
              (EXIT
               (COND ((QEQCAR |usc| 1) (CONS 1 "failed"))
                     ('T
                      (SPADCALL (QCDR (QCDR |usc|)) (QCAR (QCDR |usc|))
                                (QREFELT $ 61)))))))) 

(SDEFUN |EFGUSER;sechIfCan;PSU;23| ((|x| (PS)) ($ (|Union| PS "failed")))
        (SPROG
         ((|usc|
           (|Union| (|Record| (|:| |sinh| PS) (|:| |cosh| PS)) "failed")))
         (SEQ (LETT |usc| (|EFGUSER;sinhcosh| |x| $))
              (EXIT
               (COND ((QEQCAR |usc| 1) (CONS 1 "failed"))
                     ('T
                      (SPADCALL (|spadConstant| $ 22) (QCDR (QCDR |usc|))
                                (QREFELT $ 61)))))))) 

(SDEFUN |EFGUSER;cschIfCan;PSU;24| ((|x| (PS)) ($ (|Union| PS "failed")))
        (SPROG
         ((|usc|
           (|Union| (|Record| (|:| |sinh| PS) (|:| |cosh| PS)) "failed")))
         (SEQ (LETT |usc| (|EFGUSER;sinhcosh| |x| $))
              (EXIT
               (COND ((QEQCAR |usc| 1) (CONS 1 "failed"))
                     ('T
                      (SPADCALL (|spadConstant| $ 22) (QCAR (QCDR |usc|))
                                (QREFELT $ 61)))))))) 

(SDEFUN |EFGUSER;asinhIfCan;PSU;25| ((|x| (PS)) ($ (|Union| PS "failed")))
        (|EFGUSER;apply_taylor1| (ELT $ 88) |x| $)) 

(SDEFUN |EFGUSER;acoshIfCan;PSU;26| ((|x| (PS)) ($ (|Union| PS "failed")))
        (|EFGUSER;apply_taylor1| (ELT $ 90) |x| $)) 

(SDEFUN |EFGUSER;atanhIfCan;PSU;27| ((|x| (PS)) ($ (|Union| PS "failed")))
        (|EFGUSER;apply_taylor1| (ELT $ 92) |x| $)) 

(SDEFUN |EFGUSER;acothIfCan;PSU;28| ((|x| (PS)) ($ (|Union| PS "failed")))
        (|EFGUSER;apply_taylor1| (ELT $ 94) |x| $)) 

(SDEFUN |EFGUSER;asechIfCan;PSU;29| ((|x| (PS)) ($ (|Union| PS "failed")))
        (|EFGUSER;apply_taylor1| (ELT $ 96) |x| $)) 

(SDEFUN |EFGUSER;acschIfCan;PSU;30| ((|x| (PS)) ($ (|Union| PS "failed")))
        (|EFGUSER;apply_taylor1| (ELT $ 98) |x| $)) 

(SDEFUN |EFGUSER;do_quo;2PSU;31|
        ((|x| (PS)) (|y| (PS)) ($ (|Union| PS "failed")))
        (SPADCALL |x| |y| (QREFELT $ 101))) 

(SDEFUN |EFGUSER;do_quo;2PSU;32|
        ((|x| (PS)) (|y| (PS)) ($ (|Union| PS "failed")))
        (SPROG ((|yinv| (|Union| PS "failed")))
               (SEQ (LETT |yinv| (SPADCALL |y| (QREFELT $ 102)))
                    (EXIT
                     (COND ((QEQCAR |yinv| 1) (CONS 1 "failed"))
                           ('T
                            (CONS 0
                                  (SPADCALL |x| (QCDR |yinv|)
                                            (QREFELT $ 39))))))))) 

(DECLAIM (NOTINLINE |ElementaryFunctionsGeneralizedUnivariatePowerSeries;|)) 

(DEFUN |ElementaryFunctionsGeneralizedUnivariatePowerSeries| (&REST #1=#:G797)
  (SPROG NIL
         (PROG (#2=#:G798)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ElementaryFunctionsGeneralizedUnivariatePowerSeries|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function|
                        |ElementaryFunctionsGeneralizedUnivariatePowerSeries;|)
                       #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|ElementaryFunctionsGeneralizedUnivariatePowerSeries|)))))))))) 

(DEFUN |ElementaryFunctionsGeneralizedUnivariatePowerSeries;| (|#1| |#2| |#3|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$3 NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT DV$3 (|devaluate| |#3|))
          (LETT |dv$|
                (LIST '|ElementaryFunctionsGeneralizedUnivariatePowerSeries|
                      DV$1 DV$2 DV$3))
          (LETT $ (GETREFV 103))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|ElementaryFunctionsGeneralizedUnivariatePowerSeries|
                      (LIST DV$1 DV$2 DV$3) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (QSETREFV $ 8 |#3|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 9
                    (COND
                     ((|HasCategory| |#1| '(|TranscendentalFunctionCategory|))
                      (|HasCategory| |#1| '(|CommutativeRing|)))
                     ('T NIL)))
          (COND
           ((|HasCategory| |#2| '(|Algebra| (|Fraction| (|Integer|))))
            (QSETREFV $ 46
                      (CONS
                       (|dispatchFunction| |EFGUSER;nthRootIfCan;PSNniU;2|)
                       $))))
          (COND
           ((|HasCategory| |#1| '(|IntegralDomain|))
            (QSETREFV $ 61
                      (CONS (|dispatchFunction| |EFGUSER;do_quo;2PSU;31|) $)))
           ('T
            (QSETREFV $ 61
                      (CONS (|dispatchFunction| |EFGUSER;do_quo;2PSU;32|) $))))
          $))) 

(MAKEPROP '|ElementaryFunctionsGeneralizedUnivariatePowerSeries| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) 'TRANSFCN (0 . |Zero|) (4 . |Zero|)
              (8 . |removeZeros|) (14 . |degree|) (|Boolean|) (19 . <)
              (25 . |coefficient|) (|Stream| 6) (|Integer|)
              (|StreamTaylorSeriesOperations| 6) (31 . |monom|) (37 . |One|)
              (41 . |One|) (45 . +) (51 . |monomial|) (57 . -)
              (63 . |apply_taylor|) (69 . >=) (75 . =) (81 . |One|)
              (|PositiveInteger|) (85 . *) (91 . +) (97 . -) (|Fraction| 18)
              (102 . |One|) (106 . -) (111 . -) (116 . *) (122 . *)
              (128 . |One|) (132 . /) (138 . |powern|) (144 . *)
              (|Union| 8 '"failed") (|NonNegativeInteger|)
              (150 . |nthRootIfCan|) (|StreamTranscendentalFunctions| 6)
              (156 . |exp|) (161 . |exp|) (166 . *) |EFGUSER;expIfCan;PSU;3|
              (172 . |log|) |EFGUSER;logIfCan;PSU;4|
              (|Record| (|:| |sin| 17) (|:| |cos| 17)) (177 . |sincos|)
              (182 . |sin|) (187 . |cos|) (192 . +) |EFGUSER;sinIfCan;PSU;6|
              |EFGUSER;cosIfCan;PSU;7| (198 . |do_quo|)
              |EFGUSER;tanIfCan;PSU;8| |EFGUSER;cotIfCan;PSU;9|
              |EFGUSER;secIfCan;PSU;10| |EFGUSER;cscIfCan;PSU;11|
              (204 . |asin|) |EFGUSER;asinIfCan;PSU;12| (209 . |acos|)
              |EFGUSER;acosIfCan;PSU;13| (214 . |atan|)
              |EFGUSER;atanIfCan;PSU;14| (219 . |acot|)
              |EFGUSER;acotIfCan;PSU;15| (224 . |asec|)
              |EFGUSER;asecIfCan;PSU;16| (229 . |acsc|)
              |EFGUSER;acscIfCan;PSU;17|
              (|Record| (|:| |sinh| 17) (|:| |cosh| 17)) (234 . |sinhcosh|)
              (239 . |sinh|) (244 . |cosh|) |EFGUSER;sinhIfCan;PSU;19|
              |EFGUSER;coshIfCan;PSU;20| |EFGUSER;tanhIfCan;PSU;21|
              |EFGUSER;cothIfCan;PSU;22| |EFGUSER;sechIfCan;PSU;23|
              |EFGUSER;cschIfCan;PSU;24| (249 . |asinh|)
              |EFGUSER;asinhIfCan;PSU;25| (254 . |acosh|)
              |EFGUSER;acoshIfCan;PSU;26| (259 . |atanh|)
              |EFGUSER;atanhIfCan;PSU;27| (264 . |acoth|)
              |EFGUSER;acothIfCan;PSU;28| (269 . |asech|)
              |EFGUSER;asechIfCan;PSU;29| (274 . |acsch|)
              |EFGUSER;acschIfCan;PSU;30| (|Union| $ '"failed") (279 . |exquo|)
              (285 . |recip|))
           '#(|tanhIfCan| 290 |tanIfCan| 295 |sinhIfCan| 300 |sinIfCan| 305
              |sechIfCan| 310 |secIfCan| 315 |nthRootIfCan| 320 |logIfCan| 326
              |expIfCan| 331 |do_quo| 336 |cschIfCan| 342 |cscIfCan| 347
              |cothIfCan| 352 |cotIfCan| 357 |coshIfCan| 362 |cosIfCan| 367
              |atanhIfCan| 372 |atanIfCan| 377 |asinhIfCan| 382 |asinIfCan| 387
              |asechIfCan| 392 |asecIfCan| 397 |acschIfCan| 402 |acscIfCan| 407
              |acothIfCan| 412 |acotIfCan| 417 |acoshIfCan| 422 |acosIfCan|
              427)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS '#((|PartialTranscendentalFunctions| 8))
                             (|makeByteWordVec2| 102
                                                 '(0 6 0 10 0 7 0 11 2 8 0 0 7
                                                   12 1 8 7 0 13 2 7 14 0 0 15
                                                   2 8 6 0 7 16 2 19 17 6 18 20
                                                   0 6 0 21 0 8 0 22 2 19 17 17
                                                   17 23 2 8 0 6 7 24 2 8 0 0 0
                                                   25 2 8 0 17 0 26 2 7 14 0 0
                                                   27 2 6 14 0 0 28 0 7 0 29 2
                                                   7 0 30 0 31 2 7 0 0 0 32 1 6
                                                   0 0 33 0 34 0 35 1 34 0 0 36
                                                   1 7 0 0 37 2 7 0 0 0 38 2 8
                                                   0 0 0 39 0 30 0 40 2 34 0 18
                                                   18 41 2 19 17 34 17 42 2 7 0
                                                   34 0 43 2 0 44 8 45 46 1 47
                                                   17 17 48 1 6 0 0 49 2 8 0 6
                                                   0 50 1 47 17 17 52 1 47 54
                                                   17 55 1 6 0 0 56 1 6 0 0 57
                                                   2 8 0 0 0 58 2 0 44 8 8 61 1
                                                   47 17 17 66 1 47 17 17 68 1
                                                   47 17 17 70 1 47 17 17 72 1
                                                   47 17 17 74 1 47 17 17 76 1
                                                   47 78 17 79 1 6 0 0 80 1 6 0
                                                   0 81 1 47 17 17 88 1 47 17
                                                   17 90 1 47 17 17 92 1 47 17
                                                   17 94 1 47 17 17 96 1 47 17
                                                   17 98 2 8 100 0 0 101 1 8
                                                   100 0 102 1 0 44 8 84 1 0 44
                                                   8 62 1 0 44 8 82 1 0 44 8 59
                                                   1 0 44 8 86 1 0 44 8 64 2 0
                                                   44 8 45 46 1 0 44 8 53 1 0
                                                   44 8 51 2 0 44 8 8 61 1 0 44
                                                   8 87 1 0 44 8 65 1 0 44 8 85
                                                   1 0 44 8 63 1 0 44 8 83 1 0
                                                   44 8 60 1 0 44 8 93 1 0 44 8
                                                   71 1 0 44 8 89 1 0 44 8 67 1
                                                   0 44 8 97 1 0 44 8 75 1 0 44
                                                   8 99 1 0 44 8 77 1 0 44 8 95
                                                   1 0 44 8 73 1 0 44 8 91 1 0
                                                   44 8 69)))))
           '|lookupComplete|)) 
