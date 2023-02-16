
(SDEFUN |EXPRODE;localInteger| ((|n| (F)) ($ (F)))
        (COND ((QREFELT $ 14) |n|)
              ('T (SPADCALL (QREFELT $ 13) |n| (QREFELT $ 15))))) 

(SDEFUN |EXPRODE;diffRhs| ((|f| (F)) (|g| (F)) ($ (F)))
        (|EXPRODE;diffRhsK| (SPADCALL |f| (QREFELT $ 17)) |g| $)) 

(SDEFUN |EXPRODE;k2exquo| ((|k| (|Kernel| F)) ($ (F)))
        (SPROG
         ((#1=#:G708 NIL) (|f| NIL) (#2=#:G707 NIL) (|op| (|BasicOperator|)))
         (SEQ
          (COND
           ((SPADCALL (LETT |op| (SPADCALL |k| (QREFELT $ 19))) '|%diff|
                      (QREFELT $ 21))
            (|error| "Improper differential equation"))
           ('T
            (SPADCALL |op|
                      (PROGN
                       (LETT #2# NIL)
                       (SEQ (LETT |f| NIL)
                            (LETT #1# (SPADCALL |k| (QREFELT $ 23))) G190
                            (COND
                             ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #2#
                                    (CONS (|EXPRODE;div2exquo| |f| $) #2#))))
                            (LETT #1# (CDR #1#)) (GO G190) G191
                            (EXIT (NREVERSE #2#))))
                      (QREFELT $ 25))))))) 

(SDEFUN |EXPRODE;smp2exquo|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| F))) ($ (F)))
        (SPADCALL (CONS (|function| |EXPRODE;k2exquo|) $) (ELT $ 26) |p|
                  (QREFELT $ 31))) 

(SDEFUN |EXPRODE;div2exquo| ((|f| (F)) ($ (F)))
        (SPROG ((|d| (|SparseMultivariatePolynomial| R (|Kernel| F))))
               (SEQ (LETT |d| (SPADCALL |f| (QREFELT $ 33)))
                    (EXIT
                     (COND
                      ((SPADCALL |d| (|spadConstant| $ 36) (QREFELT $ 37)) |f|)
                      ('T
                       (SPADCALL (QREFELT $ 12)
                                 (|EXPRODE;smp2exquo|
                                  (SPADCALL |f| (QREFELT $ 38)) $)
                                 (|EXPRODE;smp2exquo| |d| $)
                                 (QREFELT $ 39)))))))) 

(SDEFUN |EXPRODE;diffRhsK| ((|k| (|Kernel| F)) (|g| (F)) ($ (F)))
        (SPROG ((|h| (|Fraction| (|SparseUnivariatePolynomial| F))))
               (SEQ (LETT |h| (SPADCALL |g| |k| (QREFELT $ 41)))
                    (COND
                     ((<=
                       (SPADCALL (SPADCALL |h| (QREFELT $ 44)) (QREFELT $ 46))
                       1)
                      (COND
                       ((SPADCALL (SPADCALL |h| (QREFELT $ 47)) (QREFELT $ 48))
                        (EXIT
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL (SPADCALL |h| (QREFELT $ 44)) 0
                                     (QREFELT $ 50))
                           (SPADCALL (SPADCALL |h| (QREFELT $ 44)) 1
                                     (QREFELT $ 50))
                           (QREFELT $ 51))
                          (QREFELT $ 52)))))))
                    (EXIT (|error| "Improper differential equation"))))) 

(SDEFUN |EXPRODE;checkCompat|
        ((|y| (|BasicOperator|)) (|eqx| (|Equation| F)) (|eqy| (|Equation| F))
         ($ (F)))
        (COND
         ((SPADCALL (SPADCALL |eqy| (QREFELT $ 54))
                    (SPADCALL |y| (SPADCALL |eqx| (QREFELT $ 55))
                              (QREFELT $ 15))
                    (QREFELT $ 56))
          (SPADCALL |eqy| (QREFELT $ 55)))
         ('T (|error| "Improper initial value")))) 

(SDEFUN |EXPRODE;findCompat| ((|yx| (F)) (|l| (|List| (|Equation| F))) ($ (F)))
        (SPROG ((#1=#:G736 NIL) (#2=#:G737 NIL) (#3=#:G738 NIL) (|eq| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |eq| NIL) (LETT #3# |l|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |eq| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |yx| (SPADCALL |eq| (QREFELT $ 54))
                                       (QREFELT $ 56))
                             (PROGN
                              (LETT #1#
                                    (PROGN
                                     (LETT #2# (SPADCALL |eq| (QREFELT $ 55)))
                                     (GO #4=#:G735)))
                              (GO #5=#:G733))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT (|error| "Improper initial value"))))
                #4# (EXIT #2#)))) 

(SDEFUN |EXPRODE;findEq|
        ((|k| (|Kernel| F)) (|x| (|Symbol|)) (|sys| (|List| F)) ($ (F)))
        (SPROG ((#1=#:G744 NIL) (#2=#:G745 NIL) (#3=#:G746 NIL) (|eq| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (LETT |k|
                        (SPADCALL
                         (SPADCALL (SPADCALL |k| (QREFELT $ 57)) |x|
                                   (QREFELT $ 58))
                         (QREFELT $ 17)))
                  (SEQ
                   (EXIT
                    (SEQ (LETT |eq| NIL) (LETT #3# |sys|) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |eq| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |k| (SPADCALL |eq| (QREFELT $ 60))
                                       (QREFELT $ 62))
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# |eq|) (GO #4=#:G743)))
                              (GO #5=#:G741))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT (|error| "Improper differential equation"))))
                #4# (EXIT #2#)))) 

(SDEFUN |EXPRODE;checkOrder1|
        ((|diffeq| (F)) (|y| (|BasicOperator|)) (|yx| (|Kernel| F))
         (|x| (|Symbol|)) (|sy| (F)) ($ (F)))
        (|EXPRODE;div2exquo|
         (SPADCALL
          (|EXPRODE;diffRhs|
           (SPADCALL (SPADCALL |yx| (QREFELT $ 57)) |x| (QREFELT $ 58))
           |diffeq| $)
          (LIST |yx|) (LIST |sy|) (QREFELT $ 63))
         $)) 

(SDEFUN |EXPRODE;checkOrderN|
        ((|diffeq| (F)) (|y| (|BasicOperator|)) (|yx| (|Kernel| F))
         (|x| (|Symbol|)) (|sy| (F)) (|n| (|NonNegativeInteger|)) ($ (F)))
        (SPROG
         ((|lv| (|List| F)) (|m| (F)) (|l| (|List| (|Kernel| F))) (|f| (F))
          (#1=#:G756 NIL) (|i| NIL))
         (SEQ
          (COND ((ZEROP |n|) (|error| "No initial value(s) given"))
                ('T
                 (SEQ
                  (LETT |m|
                        (SPADCALL
                         (PROGN
                          (LETT |l|
                                (LIST
                                 (SPADCALL
                                  (LETT |f| (SPADCALL |yx| (QREFELT $ 57)))
                                  (QREFELT $ 17))))
                          1)
                         (QREFELT $ 65)))
                  (LETT |lv|
                        (LIST
                         (SPADCALL (QREFELT $ 11) |sy|
                                   (|EXPRODE;localInteger| |m| $)
                                   (QREFELT $ 39))))
                  (SEQ (LETT |i| 2) (LETT #1# |n|) G190
                       (COND ((|greater_SI| |i| #1#) (GO G191)))
                       (SEQ
                        (LETT |l|
                              (CONS
                               (SPADCALL
                                (LETT |f| (SPADCALL |f| |x| (QREFELT $ 58)))
                                (QREFELT $ 17))
                               |l|))
                        (EXIT
                         (LETT |lv|
                               (CONS
                                (SPADCALL (QREFELT $ 11) |sy|
                                          (|EXPRODE;localInteger|
                                           (LETT |m|
                                                 (SPADCALL |m|
                                                           (|spadConstant| $
                                                                           35)
                                                           (QREFELT $ 66)))
                                           $)
                                          (QREFELT $ 39))
                                |lv|))))
                       (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (|EXPRODE;div2exquo|
                    (SPADCALL
                     (|EXPRODE;diffRhs| (SPADCALL |f| |x| (QREFELT $ 58))
                      |diffeq| $)
                     |l| |lv| (QREFELT $ 63))
                    $)))))))) 

(SDEFUN |EXPRODE;checkSystem|
        ((|diffeq| (F)) (|yx| (|List| (|Kernel| F))) (|lv| (|List| F)) ($ (F)))
        (SPROG ((#1=#:G762 NIL) (#2=#:G763 NIL) (#3=#:G764 NIL) (|k| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |k| NIL)
                         (LETT #3# (SPADCALL |diffeq| (QREFELT $ 60))) G190
                         (COND
                          ((OR (ATOM #3#) (PROGN (LETT |k| (CAR #3#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL |k| '|%diff| (QREFELT $ 67))
                             (PROGN
                              (LETT #1#
                                    (PROGN
                                     (LETT #2#
                                           (|EXPRODE;div2exquo|
                                            (SPADCALL
                                             (|EXPRODE;diffRhsK| |k| |diffeq|
                                              $)
                                             |yx| |lv| (QREFELT $ 63))
                                            $))
                                     (GO #4=#:G761)))
                              (GO #5=#:G759))))))
                         (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT (|spadConstant| $ 68))))
                #4# (EXIT #2#)))) 

(SDEFUN |EXPRODE;seriesSolve;LLELA;13|
        ((|l| (|List| (|Equation| F))) (|y| (|List| (|BasicOperator|)))
         (|eqx| (|Equation| F)) (|eqy| (|List| (|Equation| F))) ($ (|Any|)))
        (SPROG ((#1=#:G769 NIL) (|deq| NIL) (#2=#:G768 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |deq| NIL) (LETT #1# |l|) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |deq| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS
                                (SPADCALL (SPADCALL |deq| (QREFELT $ 54))
                                          (SPADCALL |deq| (QREFELT $ 55))
                                          (QREFELT $ 69))
                                #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 |y| |eqx| |eqy| (QREFELT $ 73))))) 

(SDEFUN |EXPRODE;seriesSolve;LLELA;14|
        ((|l| (|List| (|Equation| F))) (|y| (|List| (|BasicOperator|)))
         (|eqx| (|Equation| F)) (|y0| (|List| F)) ($ (|Any|)))
        (SPROG ((#1=#:G776 NIL) (|deq| NIL) (#2=#:G775 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |deq| NIL) (LETT #1# |l|) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |deq| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS
                                (SPADCALL (SPADCALL |deq| (QREFELT $ 54))
                                          (SPADCALL |deq| (QREFELT $ 55))
                                          (QREFELT $ 69))
                                #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 |y| |eqx| |y0| (QREFELT $ 75))))) 

(SDEFUN |EXPRODE;seriesSolve;LLELA;15|
        ((|l| (|List| F)) (|ly| (|List| (|BasicOperator|)))
         (|eqx| (|Equation| F)) (|eqy| (|List| (|Equation| F))) ($ (|Any|)))
        (SPROG ((#1=#:G781 NIL) (|y| NIL) (#2=#:G780 NIL))
               (SEQ
                (SPADCALL |l| |ly| |eqx|
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |y| NIL) (LETT #1# |ly|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |y| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS
                                         (|EXPRODE;findCompat|
                                          (SPADCALL |y|
                                                    (SPADCALL |eqx|
                                                              (QREFELT $ 55))
                                                    (QREFELT $ 15))
                                          |eqy| $)
                                         #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#))))
                          (QREFELT $ 75))))) 

(SDEFUN |EXPRODE;seriesSolve;EBo2EA;16|
        ((|diffeq| (|Equation| F)) (|y| (|BasicOperator|))
         (|eqx| (|Equation| F)) (|eqy| (|Equation| F)) ($ (|Any|)))
        (SPADCALL
         (SPADCALL (SPADCALL |diffeq| (QREFELT $ 54))
                   (SPADCALL |diffeq| (QREFELT $ 55)) (QREFELT $ 69))
         |y| |eqx| |eqy| (QREFELT $ 77))) 

(SDEFUN |EXPRODE;seriesSolve;EBoEFA;17|
        ((|diffeq| (|Equation| F)) (|y| (|BasicOperator|))
         (|eqx| (|Equation| F)) (|y0| (F)) ($ (|Any|)))
        (SPADCALL
         (SPADCALL (SPADCALL |diffeq| (QREFELT $ 54))
                   (SPADCALL |diffeq| (QREFELT $ 55)) (QREFELT $ 69))
         |y| |eqx| |y0| (QREFELT $ 79))) 

(SDEFUN |EXPRODE;seriesSolve;EBoELA;18|
        ((|diffeq| (|Equation| F)) (|y| (|BasicOperator|))
         (|eqx| (|Equation| F)) (|y0| (|List| F)) ($ (|Any|)))
        (SPADCALL
         (SPADCALL (SPADCALL |diffeq| (QREFELT $ 54))
                   (SPADCALL |diffeq| (QREFELT $ 55)) (QREFELT $ 69))
         |y| |eqx| |y0| (QREFELT $ 81))) 

(SDEFUN |EXPRODE;seriesSolve;FBo2EA;19|
        ((|diffeq| (F)) (|y| (|BasicOperator|)) (|eqx| (|Equation| F))
         (|eqy| (|Equation| F)) ($ (|Any|)))
        (SPADCALL |diffeq| |y| |eqx| (|EXPRODE;checkCompat| |y| |eqx| |eqy| $)
                  (QREFELT $ 79))) 

(SDEFUN |EXPRODE;seriesSolve;FBoEFA;20|
        ((|diffeq| (F)) (|y| (|BasicOperator|)) (|eqx| (|Equation| F))
         (|y0| (F)) ($ (|Any|)))
        (SPROG
         ((|center| (F)) (|f| (F)) (|yx| (|Kernel| F)) (|sy| (|Symbol|))
          (|x| (|Symbol|)) (#1=#:G787 NIL))
         (SEQ
          (LETT |x|
                (PROG2
                    (LETT #1#
                          (SPADCALL
                           (SPADCALL (SPADCALL |eqx| (QREFELT $ 54))
                                     (QREFELT $ 17))
                           (QREFELT $ 84)))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0) (|Symbol|)
                                  (|Union| (|Symbol|) "failed") #1#)))
          (LETT |sy| (SPADCALL |y| (QREFELT $ 85)))
          (LETT |yx|
                (SPADCALL
                 (SPADCALL |y| (SPADCALL |eqx| (QREFELT $ 54)) (QREFELT $ 15))
                 (QREFELT $ 17)))
          (LETT |f|
                (|EXPRODE;checkOrder1| |diffeq| |y| |yx| |x|
                 (SPADCALL |sy| (QREFELT $ 86)) $))
          (LETT |center| (SPADCALL |eqx| (QREFELT $ 55)))
          (EXIT
           (SPADCALL
            (SPADCALL
             (SPADCALL |f| |sy|
                       (|compiledLookupCheck| '|compiledFunction|
                                              (LIST
                                               (LIST '|Mapping|
                                                     (LIST
                                                      '|UnivariateTaylorSeries|
                                                      (|devaluate| (ELT $ 7))
                                                      |x| |center|)
                                                     (LIST
                                                      '|UnivariateTaylorSeries|
                                                      (|devaluate| (ELT $ 7))
                                                      |x| |center|))
                                               (|devaluate| (ELT $ 7))
                                               (LIST '|Symbol|))
                                              (|MakeUnaryCompiledFunction|
                                               (ELT $ 7)
                                               (|UnivariateTaylorSeries|
                                                (ELT $ 7) |x| |center|)
                                               (|UnivariateTaylorSeries|
                                                (ELT $ 7) |x| |center|))))
             |y0|
             (|compiledLookupCheck| '|ode1|
                                    (LIST
                                     (LIST '|UnivariateTaylorSeries|
                                           (|devaluate| (ELT $ 7)) |x|
                                           |center|)
                                     (LIST '|Mapping|
                                           (LIST '|UnivariateTaylorSeries|
                                                 (|devaluate| (ELT $ 7)) |x|
                                                 |center|)
                                           (LIST '|UnivariateTaylorSeries|
                                                 (|devaluate| (ELT $ 7)) |x|
                                                 |center|))
                                     (|devaluate| (ELT $ 7)))
                                    (|UnivariateTaylorSeriesODESolver|
                                     (ELT $ 7)
                                     (|UnivariateTaylorSeries| (ELT $ 7) |x|
                                                               |center|))))
            (|compiledLookupCheck| '|coerce|
                                   (LIST (LIST '|Any|)
                                         (LIST '|UnivariateTaylorSeries|
                                               (|devaluate| (ELT $ 7)) |x|
                                               |center|))
                                   (|AnyFunctions1|
                                    (|UnivariateTaylorSeries| (ELT $ 7) |x|
                                                              |center|)))))))) 

(SDEFUN |EXPRODE;seriesSolve;FBoELA;21|
        ((|diffeq| (F)) (|y| (|BasicOperator|)) (|eqx| (|Equation| F))
         (|y0| (|List| F)) ($ (|Any|)))
        (SPROG
         ((|center| (F)) (|f| (F)) (|yx| (|Kernel| F)) (|sy| (|Symbol|))
          (|x| (|Symbol|)) (#1=#:G794 NIL))
         (SEQ
          (LETT |x|
                (PROG2
                    (LETT #1#
                          (SPADCALL
                           (SPADCALL (SPADCALL |eqx| (QREFELT $ 54))
                                     (QREFELT $ 17))
                           (QREFELT $ 84)))
                    (QCDR #1#)
                  (|check_union2| (QEQCAR #1# 0) (|Symbol|)
                                  (|Union| (|Symbol|) "failed") #1#)))
          (LETT |sy| (SPADCALL (QREFELT $ 87)))
          (LETT |yx|
                (SPADCALL
                 (SPADCALL |y| (SPADCALL |eqx| (QREFELT $ 54)) (QREFELT $ 15))
                 (QREFELT $ 17)))
          (LETT |f|
                (|EXPRODE;checkOrderN| |diffeq| |y| |yx| |x|
                 (SPADCALL |sy| (QREFELT $ 86)) (LENGTH |y0|) $))
          (LETT |center| (SPADCALL |eqx| (QREFELT $ 55)))
          (EXIT
           (SPADCALL
            (SPADCALL
             (SPADCALL |f| |sy|
                       (|compiledLookupCheck| '|compiledFunction|
                                              (LIST
                                               (LIST '|Mapping|
                                                     (LIST
                                                      '|UnivariateTaylorSeries|
                                                      (|devaluate| (ELT $ 7))
                                                      |x| |center|)
                                                     (LIST '|List|
                                                           (LIST
                                                            '|UnivariateTaylorSeries|
                                                            (|devaluate|
                                                             (ELT $ 7))
                                                            |x| |center|)))
                                               (|devaluate| (ELT $ 7))
                                               (LIST '|Symbol|))
                                              (|MakeUnaryCompiledFunction|
                                               (ELT $ 7)
                                               (|List|
                                                (|UnivariateTaylorSeries|
                                                 (ELT $ 7) |x| |center|))
                                               (|UnivariateTaylorSeries|
                                                (ELT $ 7) |x| |center|))))
             |y0|
             (|compiledLookupCheck| '|ode|
                                    (LIST
                                     (LIST '|UnivariateTaylorSeries|
                                           (|devaluate| (ELT $ 7)) |x|
                                           |center|)
                                     (LIST '|Mapping|
                                           (LIST '|UnivariateTaylorSeries|
                                                 (|devaluate| (ELT $ 7)) |x|
                                                 |center|)
                                           (LIST '|List|
                                                 (LIST
                                                  '|UnivariateTaylorSeries|
                                                  (|devaluate| (ELT $ 7)) |x|
                                                  |center|)))
                                     (LIST '|List| (|devaluate| (ELT $ 7))))
                                    (|UnivariateTaylorSeriesODESolver|
                                     (ELT $ 7)
                                     (|UnivariateTaylorSeries| (ELT $ 7) |x|
                                                               |center|))))
            (|compiledLookupCheck| '|coerce|
                                   (LIST (LIST '|Any|)
                                         (LIST '|UnivariateTaylorSeries|
                                               (|devaluate| (ELT $ 7)) |x|
                                               |center|))
                                   (|AnyFunctions1|
                                    (|UnivariateTaylorSeries| (ELT $ 7) |x|
                                                              |center|)))))))) 

(SDEFUN |EXPRODE;seriesSolve;LLELA;22|
        ((|sys| (|List| F)) (|ly| (|List| (|BasicOperator|)))
         (|eqx| (|Equation| F)) (|l0| (|List| F)) ($ (|Any|)))
        (SPROG
         ((#1=#:G831 NIL) (|f| NIL) (#2=#:G830 NIL) (|center| (F))
          (|l| (|List| F)) (#3=#:G829 NIL) (|eq| NIL) (#4=#:G828 NIL)
          (#5=#:G827 NIL) (|k| NIL) (#6=#:G826 NIL) (|lelt| (|List| F))
          (|m| (F)) (#7=#:G825 NIL) (#8=#:G824 NIL)
          (|yx| (|List| (|Kernel| F))) (#9=#:G823 NIL) (|y| NIL)
          (#10=#:G822 NIL) (|fsy| (F)) (|sy| (|Symbol|)) (|x| (|Symbol|))
          (#11=#:G805 NIL) (|kx| (|Kernel| F)))
         (SEQ
          (LETT |x|
                (PROG2
                    (LETT #11#
                          (SPADCALL
                           (LETT |kx|
                                 (SPADCALL (SPADCALL |eqx| (QREFELT $ 54))
                                           (QREFELT $ 17)))
                           (QREFELT $ 84)))
                    (QCDR #11#)
                  (|check_union2| (QEQCAR #11# 0) (|Symbol|)
                                  (|Union| (|Symbol|) "failed") #11#)))
          (LETT |fsy|
                (SPADCALL (LETT |sy| (SPADCALL (QREFELT $ 87)))
                          (QREFELT $ 86)))
          (LETT |m| (SPADCALL (- (PROGN |l0| 1) 1) (QREFELT $ 65)))
          (LETT |yx|
                (CONS |kx|
                      (PROGN
                       (LETT #10# NIL)
                       (SEQ (LETT |y| NIL) (LETT #9# |ly|) G190
                            (COND
                             ((OR (ATOM #9#) (PROGN (LETT |y| (CAR #9#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #10#
                                    (CONS
                                     (SPADCALL
                                      (SPADCALL |y|
                                                (SPADCALL |eqx| (QREFELT $ 54))
                                                (QREFELT $ 15))
                                      (QREFELT $ 17))
                                     #10#))))
                            (LETT #9# (CDR #9#)) (GO G190) G191
                            (EXIT (NREVERSE #10#))))))
          (LETT |lelt|
                (PROGN
                 (LETT #8# NIL)
                 (SEQ (LETT |k| NIL) (LETT #7# |yx|) G190
                      (COND
                       ((OR (ATOM #7#) (PROGN (LETT |k| (CAR #7#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #8#
                              (CONS
                               (SPADCALL (QREFELT $ 11) |fsy|
                                         (|EXPRODE;localInteger|
                                          (LETT |m|
                                                (SPADCALL |m|
                                                          (|spadConstant| $ 35)
                                                          (QREFELT $ 66)))
                                          $)
                                         (QREFELT $ 39))
                               #8#))))
                      (LETT #7# (CDR #7#)) (GO G190) G191
                      (EXIT (NREVERSE #8#)))))
          (LETT |sys|
                (PROGN
                 (LETT #6# NIL)
                 (SEQ (LETT |k| NIL) (LETT #5# (CDR |yx|)) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |k| (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #6#
                              (CONS (|EXPRODE;findEq| |k| |x| |sys| $) #6#))))
                      (LETT #5# (CDR #5#)) (GO G190) G191
                      (EXIT (NREVERSE #6#)))))
          (LETT |l|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |eq| NIL) (LETT #3# |sys|) G190
                      (COND
                       ((OR (ATOM #3#) (PROGN (LETT |eq| (CAR #3#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #4#
                              (CONS (|EXPRODE;checkSystem| |eq| |yx| |lelt| $)
                                    #4#))))
                      (LETT #3# (CDR #3#)) (GO G190) G191
                      (EXIT (NREVERSE #4#)))))
          (LETT |center| (SPADCALL |eqx| (QREFELT $ 55)))
          (EXIT
           (SPADCALL
            (SPADCALL |l0|
                      (PROGN
                       (LETT #2# NIL)
                       (SEQ (LETT |f| NIL) (LETT #1# |l|) G190
                            (COND
                             ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #2#
                                    (CONS
                                     (SPADCALL |f| |sy|
                                               (|compiledLookupCheck|
                                                '|compiledFunction|
                                                (LIST
                                                 (LIST '|Mapping|
                                                       (LIST
                                                        '|UnivariateTaylorSeries|
                                                        (|devaluate| (ELT $ 7))
                                                        |x| |center|)
                                                       (LIST '|List|
                                                             (LIST
                                                              '|UnivariateTaylorSeries|
                                                              (|devaluate|
                                                               (ELT $ 7))
                                                              |x| |center|)))
                                                 (|devaluate| (ELT $ 7))
                                                 (LIST '|Symbol|))
                                                (|MakeUnaryCompiledFunction|
                                                 (ELT $ 7)
                                                 (|List|
                                                  (|UnivariateTaylorSeries|
                                                   (ELT $ 7) |x| |center|))
                                                 (|UnivariateTaylorSeries|
                                                  (ELT $ 7) |x| |center|))))
                                     #2#))))
                            (LETT #1# (CDR #1#)) (GO G190) G191
                            (EXIT (NREVERSE #2#))))
                      (|compiledLookupCheck| '|mpsode|
                                             (LIST
                                              (LIST '|List|
                                                    (LIST
                                                     '|UnivariateTaylorSeries|
                                                     (|devaluate| (ELT $ 7))
                                                     |x| |center|))
                                              (LIST '|List|
                                                    (|devaluate| (ELT $ 7)))
                                              (LIST '|List|
                                                    (LIST '|Mapping|
                                                          (LIST
                                                           '|UnivariateTaylorSeries|
                                                           (|devaluate|
                                                            (ELT $ 7))
                                                           |x| |center|)
                                                          (LIST '|List|
                                                                (LIST
                                                                 '|UnivariateTaylorSeries|
                                                                 (|devaluate|
                                                                  (ELT $ 7))
                                                                 |x|
                                                                 |center|)))))
                                             (|UnivariateTaylorSeriesODESolver|
                                              (ELT $ 7)
                                              (|UnivariateTaylorSeries|
                                               (ELT $ 7) |x| |center|))))
            (|compiledLookupCheck| '|coerce|
                                   (LIST (LIST '|Any|)
                                         (LIST '|List|
                                               (LIST '|UnivariateTaylorSeries|
                                                     (|devaluate| (ELT $ 7))
                                                     |x| |center|)))
                                   (|AnyFunctions1|
                                    (|List|
                                     (|UnivariateTaylorSeries| (ELT $ 7) |x|
                                                               |center|))))))))) 

(DECLAIM (NOTINLINE |ExpressionSpaceODESolver;|)) 

(DEFUN |ExpressionSpaceODESolver| (&REST #1=#:G832)
  (SPROG NIL
         (PROG (#2=#:G833)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ExpressionSpaceODESolver|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ExpressionSpaceODESolver;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|ExpressionSpaceODESolver|)))))))))) 

(DEFUN |ExpressionSpaceODESolver;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|ExpressionSpaceODESolver| DV$1 DV$2))
          (LETT $ (GETREFV 88))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ExpressionSpaceODESolver|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 11 (SPADCALL '|elt| (QREFELT $ 10)))
          (QSETREFV $ 12 (SPADCALL '|exquo| (QREFELT $ 10)))
          (QSETREFV $ 13 (SPADCALL '|integer| (QREFELT $ 10)))
          (QSETREFV $ 14 (|HasCategory| |#1| '(|IntegerNumberSystem|)))
          $))) 

(MAKEPROP '|ExpressionSpaceODESolver| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Symbol|)
              (|BasicOperator|) (0 . |operator|) '|opelt| '|opex| '|opint|
              '|Rint?| (5 . |elt|) (|Kernel| $) (11 . |retract|) (|Kernel| 7)
              (16 . |operator|) (|Boolean|) (21 . |is?|) (|List| 7)
              (27 . |argument|) (|List| $) (32 . |kernel|) (38 . |coerce|)
              (|Mapping| 7 18) (|Mapping| 7 6)
              (|SparseMultivariatePolynomial| 6 18)
              (|PolynomialCategoryLifting| (|IndexedExponents| 18) 18 6 29 7)
              (43 . |map|) (|SparseMultivariatePolynomial| 6 16) (50 . |denom|)
              (55 . |One|) (59 . |One|) (63 . |One|) (67 . =) (73 . |numer|)
              (78 . |elt|) (|Fraction| (|SparseUnivariatePolynomial| $))
              (85 . |univariate|) (|SparseUnivariatePolynomial| 7)
              (|Fraction| 42) (91 . |numer|) (|NonNegativeInteger|)
              (96 . |degree|) (101 . |denom|) (106 . |ground?|) (111 . |Zero|)
              (115 . |coefficient|) (121 . /) (127 . -) (|Equation| 7)
              (132 . |lhs|) (137 . |rhs|) (142 . =) (148 . |coerce|)
              (153 . |differentiate|) (|List| 16) (159 . |kernels|) (|List| 18)
              (164 . |member?|) (170 . |subst|) (|Integer|) (177 . |coerce|)
              (182 . +) (188 . |is?|) (194 . |Zero|) (198 . -) (|Any|)
              (|List| 9) (|List| 53) |EXPRODE;seriesSolve;LLELA;15|
              |EXPRODE;seriesSolve;LLELA;13| |EXPRODE;seriesSolve;LLELA;22|
              |EXPRODE;seriesSolve;LLELA;14| |EXPRODE;seriesSolve;FBo2EA;19|
              |EXPRODE;seriesSolve;EBo2EA;16| |EXPRODE;seriesSolve;FBoEFA;20|
              |EXPRODE;seriesSolve;EBoEFA;17| |EXPRODE;seriesSolve;FBoELA;21|
              |EXPRODE;seriesSolve;EBoELA;18| (|Union| 8 '"failed")
              (204 . |symbolIfCan|) (209 . |name|) (214 . |coerce|)
              (219 . |new|))
           '#(|seriesSolve| 223) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|seriesSolve|
                                 ((|Any|) (|Equation| |#2|) (|BasicOperator|)
                                  (|Equation| |#2|) (|Equation| |#2|)))
                                T)
                              '((|seriesSolve|
                                 ((|Any|) (|Equation| |#2|) (|BasicOperator|)
                                  (|Equation| |#2|) (|List| |#2|)))
                                T)
                              '((|seriesSolve|
                                 ((|Any|) (|List| (|Equation| |#2|))
                                  (|List| (|BasicOperator|)) (|Equation| |#2|)
                                  (|List| (|Equation| |#2|))))
                                T)
                              '((|seriesSolve|
                                 ((|Any|) (|List| (|Equation| |#2|))
                                  (|List| (|BasicOperator|)) (|Equation| |#2|)
                                  (|List| |#2|)))
                                T)
                              '((|seriesSolve|
                                 ((|Any|) (|List| |#2|)
                                  (|List| (|BasicOperator|)) (|Equation| |#2|)
                                  (|List| |#2|)))
                                T)
                              '((|seriesSolve|
                                 ((|Any|) (|List| |#2|)
                                  (|List| (|BasicOperator|)) (|Equation| |#2|)
                                  (|List| (|Equation| |#2|))))
                                T)
                              '((|seriesSolve|
                                 ((|Any|) (|Equation| |#2|) (|BasicOperator|)
                                  (|Equation| |#2|) |#2|))
                                T)
                              '((|seriesSolve|
                                 ((|Any|) |#2| (|BasicOperator|)
                                  (|Equation| |#2|) |#2|))
                                T)
                              '((|seriesSolve|
                                 ((|Any|) |#2| (|BasicOperator|)
                                  (|Equation| |#2|) (|Equation| |#2|)))
                                T)
                              '((|seriesSolve|
                                 ((|Any|) |#2| (|BasicOperator|)
                                  (|Equation| |#2|) (|List| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 87
                                            '(1 9 0 8 10 2 7 0 9 0 15 1 7 16 0
                                              17 1 18 9 0 19 2 9 20 0 8 21 1 18
                                              22 0 23 2 7 0 9 24 25 1 7 0 6 26
                                              3 30 7 27 28 29 31 1 7 32 0 33 0
                                              6 0 34 0 7 0 35 0 29 0 36 2 29 20
                                              0 0 37 1 7 32 0 38 3 7 0 9 0 0 39
                                              2 7 40 0 16 41 1 43 42 0 44 1 42
                                              45 0 46 1 43 42 0 47 1 42 20 0 48
                                              0 6 0 49 2 42 7 0 45 50 2 7 0 0 0
                                              51 1 7 0 0 52 1 53 7 0 54 1 53 7
                                              0 55 2 7 20 0 0 56 1 7 0 16 57 2
                                              7 0 0 8 58 1 7 59 0 60 2 61 20 18
                                              0 62 3 7 0 0 59 24 63 1 7 0 64 65
                                              2 7 0 0 0 66 2 18 20 0 8 67 0 7 0
                                              68 2 7 0 0 0 69 1 18 83 0 84 1 9
                                              8 0 85 1 7 0 8 86 0 8 0 87 4 0 70
                                              53 9 53 22 82 4 0 70 53 9 53 53
                                              78 4 0 70 72 71 53 72 74 4 0 70
                                              22 71 53 22 75 4 0 70 72 71 53 22
                                              76 4 0 70 53 9 53 7 80 4 0 70 22
                                              71 53 72 73 4 0 70 7 9 53 7 79 4
                                              0 70 7 9 53 22 81 4 0 70 7 9 53
                                              53 77)))))
           '|lookupComplete|)) 
