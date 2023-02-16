
(SDEFUN |ODERAT;infOrder| ((|f| (|Fraction| UP)) ($ (|Integer|)))
        (- (SPADCALL (SPADCALL |f| (QREFELT $ 12)) (QREFELT $ 14))
           (SPADCALL (SPADCALL |f| (QREFELT $ 15)) (QREFELT $ 14)))) 

(SDEFUN |ODERAT;evenodd| ((|n| (|NonNegativeInteger|)) ($ (F)))
        (COND ((EVENP |n|) (|spadConstant| $ 16))
              ('T (SPADCALL (|spadConstant| $ 16) (QREFELT $ 18))))) 

(SDEFUN |ODERAT;ratDsolve1|
        ((|op| (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
         (|lg| (|List| (|Fraction| UP)))
         ($
          (|Record| (|:| |basis| (|List| (|Fraction| UP)))
                    (|:| |mat| (|Matrix| F)))))
        (SPROG
         ((|sys1| (|Matrix| UP)) (|l| (|List| (|Fraction| UP))) (#1=#:G767 NIL)
          (|q| NIL) (#2=#:G766 NIL) (#3=#:G765 NIL) (|i| NIL) (#4=#:G764 NIL)
          (|rec|
           (|Record| (|:| |basis| (|List| (|Fraction| UP)))
                     (|:| |particular| (|List| (|Fraction| UP)))))
          (|d| (UP)) (#5=#:G763 NIL) (|g| NIL) (#6=#:G762 NIL))
         (SEQ
          (COND
           ((ZEROP (SPADCALL |op| (QREFELT $ 20)))
            (CONS
             (PROGN
              (LETT #6# NIL)
              (SEQ (LETT |g| NIL) (LETT #5# |lg|) G190
                   (COND
                    ((OR (ATOM #5#) (PROGN (LETT |g| (CAR #5#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT #6#
                           (CONS
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL (SPADCALL |op| (QREFELT $ 21))
                                        (QREFELT $ 22))
                              (QREFELT $ 23))
                             |g| (QREFELT $ 24))
                            #6#))))
                   (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT (NREVERSE #6#))))
             (MAKE_MATRIX1 0 (LENGTH |lg|) (|spadConstant| $ 25))))
           ('T
            (SEQ (LETT |d| (SPADCALL |op| |lg| (QREFELT $ 29)))
                 (LETT |rec| (|ODERAT;candidates| |op| |lg| |d| $))
                 (LETT |l|
                       (SPADCALL
                        (PROGN
                         (LETT #4# NIL)
                         (SEQ (LETT |i| 1) (LETT #3# (LENGTH (QCDR |rec|)))
                              G190 (COND ((|greater_SI| |i| #3#) (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #4#
                                      (CONS
                                       (SPADCALL
                                        (SPADCALL |op|
                                                  (SPADCALL (QCDR |rec|) |i|
                                                            (QREFELT $ 31))
                                                  (QREFELT $ 32))
                                        (SPADCALL |lg| |i| (QREFELT $ 31))
                                        (QREFELT $ 33))
                                       #4#))))
                              (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                              (EXIT (NREVERSE #4#))))
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |q| NIL) (LETT #1# (QCAR |rec|)) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |q| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #2#
                                      (CONS (SPADCALL |op| |q| (QREFELT $ 32))
                                            #2#))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#))))
                        (QREFELT $ 34)))
                 (LETT |sys1|
                       (SPADCALL (SPADCALL (LIST |l|) (QREFELT $ 37))
                                 (QREFELT $ 40)))
                 (EXIT
                  (CONS (SPADCALL (QCDR |rec|) (QCAR |rec|) (QREFELT $ 34))
                        (SPADCALL |sys1| (QREFELT $ 42)))))))))) 

(SDEFUN |ODERAT;ratDsolve0|
        ((|op| (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
         (|g| (|Fraction| UP))
         ($
          (|Record| (|:| |particular| (|Union| (|Fraction| UP) #1="failed"))
                    (|:| |basis| (|List| (|Fraction| UP))))))
        (SPROG
         ((#2=#:G811 NIL) (#3=#:G810 NIL)
          (|part| (|Union| (|Fraction| UP) #1#)) (#4=#:G795 NIL)
          (|sol|
           (|Record| (|:| |particular| (|Union| (|Vector| F) #5="failed"))
                     (|:| |basis| (|List| (|Vector| F)))))
          (|v| (|Vector| F)) (|m| (|Matrix| F))
          (|sys2| (|Record| (|:| |mat| (|Matrix| F)) (|:| |vec| (|Vector| F))))
          (|sys1|
           (|Record| (|:| |mat| (|Matrix| UP)) (|:| |vec| (|Vector| UP))))
          (|h| (|Fraction| UP)) (|lb| #6=(|List| (|Fraction| UP))) (|l| #6#)
          (|lsol| #6#) (|opq| (|Fraction| UP)) (#7=#:G809 NIL) (|q| NIL)
          (|rec|
           (|Record| (|:| |basis| (|List| (|Fraction| UP)))
                     (|:| |particular| (|List| (|Fraction| UP)))))
          (|u| (|Union| UP "failed")) (#8=#:G770 NIL)
          (|b| (|List| (|Fraction| UP)))
          (|uu| (|Union| (|Fraction| UP) "failed")) (#9=#:G808 NIL) (|f| NIL))
         (SEQ
          (COND
           ((ZEROP (SPADCALL |op| (QREFELT $ 20)))
            (CONS
             (CONS 0
                   (SPADCALL
                    (SPADCALL
                     (SPADCALL (SPADCALL |op| (QREFELT $ 21)) (QREFELT $ 22))
                     (QREFELT $ 23))
                    |g| (QREFELT $ 24)))
             NIL))
           ((> (SPADCALL |op| (QREFELT $ 43)) 0)
            (SEQ
             (LETT |sol|
                   (|ODERAT;ratDsolve0|
                    (QCAR
                     (SPADCALL |op|
                               (SPADCALL (|spadConstant| $ 17) 1
                                         (QREFELT $ 44))
                               (QREFELT $ 46)))
                    |g| $))
             (LETT |b| (LIST (|spadConstant| $ 47)))
             (SEQ (LETT |f| NIL) (LETT #9# (QCDR |sol|)) G190
                  (COND
                   ((OR (ATOM #9#) (PROGN (LETT |f| (CAR #9#)) NIL))
                    (GO G191)))
                  (SEQ (LETT |uu| (SPADCALL |f| (QREFELT $ 50)))
                       (EXIT
                        (COND
                         ((QEQCAR |uu| 0) (LETT |b| (CONS (QCDR |uu|) |b|))))))
                  (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL))
             (EXIT
              (COND ((QEQCAR (QCAR |sol|) 1) (CONS (CONS 1 "failed") |b|))
                    (#10='T
                     (CONS
                      (SPADCALL
                       (PROG2 (LETT #8# (QCAR |sol|))
                           (QCDR #8#)
                         (|check_union2| (QEQCAR #8# 0)
                                         (|Fraction| (QREFELT $ 7))
                                         (|Union| (|Fraction| (QREFELT $ 7))
                                                  #1#)
                                         #8#))
                       (QREFELT $ 50))
                      |b|))))))
           (#10#
            (SEQ (LETT |u| (SPADCALL |op| |g| (QREFELT $ 52)))
                 (EXIT
                  (COND ((QEQCAR |u| 1) (CONS (CONS 1 "failed") NIL))
                        (#10#
                         (SEQ
                          (LETT |rec|
                                (|ODERAT;candidates| |op| (LIST |g|) (QCDR |u|)
                                 $))
                          (LETT |l| (LETT |lb| (LETT |lsol| NIL)))
                          (SEQ (LETT |q| NIL) (LETT #7# (QCAR |rec|)) G190
                               (COND
                                ((OR (ATOM #7#)
                                     (PROGN (LETT |q| (CAR #7#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((SPADCALL
                                    (LETT |opq|
                                          (SPADCALL |op| |q| (QREFELT $ 32)))
                                    (QREFELT $ 54))
                                   (LETT |lsol| (CONS |q| |lsol|)))
                                  ('T
                                   (SEQ (LETT |l| (CONS |opq| |l|))
                                        (EXIT (LETT |lb| (CONS |q| |lb|))))))))
                               (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
                          (LETT |h|
                                (COND
                                 ((SPADCALL |g| (QREFELT $ 54))
                                  (|spadConstant| $ 55))
                                 (#10# (|SPADfirst| (QCDR |rec|)))))
                          (EXIT
                           (COND
                            ((NULL |l|)
                             (COND
                              ((SPADCALL |g| (QREFELT $ 54))
                               (CONS (CONS 0 (|spadConstant| $ 55)) |lsol|))
                              (#10#
                               (CONS
                                (COND
                                 ((SPADCALL |g|
                                            (SPADCALL |op| |h| (QREFELT $ 32))
                                            (QREFELT $ 56))
                                  (CONS 0 |h|))
                                 (#10# (CONS 1 "failed")))
                                |lsol|))))
                            (#10#
                             (SEQ
                              (COND
                               ((SPADCALL |g| (QREFELT $ 54))
                                (SEQ
                                 (LETT |m|
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL (LIST |l|) (QREFELT $ 37))
                                         (QREFELT $ 40))
                                        (QREFELT $ 42)))
                                 (EXIT
                                  (LETT |v|
                                        (MAKEARR1 (ANCOLS |m|)
                                                  (|spadConstant| $ 25))))))
                               (#10#
                                (SEQ
                                 (LETT |sys1|
                                       (SPADCALL
                                        (SPADCALL (LIST |l|) (QREFELT $ 37))
                                        (SPADCALL
                                         (LIST
                                          (SPADCALL |g|
                                                    (SPADCALL |op| |h|
                                                              (QREFELT $ 32))
                                                    (QREFELT $ 33)))
                                         (QREFELT $ 58))
                                        (QREFELT $ 61)))
                                 (LETT |sys2|
                                       (SPADCALL (QCAR |sys1|) (QCDR |sys1|)
                                                 (QREFELT $ 63)))
                                 (LETT |m| (QCAR |sys2|))
                                 (EXIT (LETT |v| (QCDR |sys2|))))))
                              (LETT |sol| (SPADCALL |m| |v| (QREFELT $ 68)))
                              (LETT |part|
                                    (COND
                                     ((SPADCALL |g| (QREFELT $ 54))
                                      (CONS 0 (|spadConstant| $ 55)))
                                     ((QEQCAR (QCAR |sol|) 1)
                                      (CONS 1 "failed"))
                                     (#10#
                                      (CONS 0
                                            (SPADCALL
                                             (|ODERAT;makeDot|
                                              (PROG2 (LETT #4# (QCAR |sol|))
                                                  (QCDR #4#)
                                                (|check_union2| (QEQCAR #4# 0)
                                                                (|Vector|
                                                                 (QREFELT $ 6))
                                                                (|Union|
                                                                 (|Vector|
                                                                  (QREFELT $
                                                                           6))
                                                                 #5#)
                                                                #4#))
                                              |lb| $)
                                             (|SPADfirst| (QCDR |rec|))
                                             (QREFELT $ 69))))))
                              (EXIT
                               (CONS |part|
                                     (SPADCALL |lsol|
                                               (PROGN
                                                (LETT #3# NIL)
                                                (SEQ (LETT #2# (QCDR |sol|))
                                                     G190
                                                     (COND
                                                      ((OR (ATOM #2#)
                                                           (PROGN
                                                            (LETT |v|
                                                                  (CAR #2#))
                                                            NIL))
                                                       (GO G191)))
                                                     (SEQ
                                                      (EXIT
                                                       (COND
                                                        ((|ODERAT;nzero?| |v|
                                                          $)
                                                         (LETT #3#
                                                               (CONS
                                                                (|ODERAT;makeDot|
                                                                 |v| |lb| $)
                                                                #3#))))))
                                                     (LETT #2# (CDR #2#))
                                                     (GO G190) G191
                                                     (EXIT (NREVERSE #3#))))
                                               (QREFELT $ 70)))))))))))))))))) 

(SDEFUN |ODERAT;indicialEquationAtInfinity;LodoUP;5|
        ((|op| (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
         ($ (UP)))
        (SPROG
         ((|rec|
           (|Record| (|:| |mu| (|Integer|))
                     (|:| |lambda| (|List| (|NonNegativeInteger|)))
                     (|:| |func| (|List| UP)))))
         (SEQ (LETT |rec| (|ODERAT;infMuLambda| |op| $))
              (EXIT
               (|ODERAT;infIndicialEquation| (QVELT |rec| 1) (QVELT |rec| 2)
                $))))) 

(SDEFUN |ODERAT;indicialEquationAtInfinity;LodoUP;6|
        ((|op| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         ($ (UP)))
        (SPROG
         ((|rec|
           (|Record|
            (|:| |eq|
                 (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
            (|:| |rh| (|List| (|Fraction| UP))))))
         (SEQ (LETT |rec| (SPADCALL |op| NIL (QREFELT $ 74)))
              (EXIT (SPADCALL (QCAR |rec|) (QREFELT $ 71)))))) 

(SDEFUN |ODERAT;regularPoint|
        ((|l| (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
         (|lg| (|List| (|Fraction| UP))) ($ (|Integer|)))
        (SPROG ((#1=#:G825 NIL) (#2=#:G826 NIL) (|j| (F)) (|i| NIL) (|a| (UP)))
               (SEQ
                (EXIT
                 (SEQ
                  (LETT |a|
                        (SPADCALL (SPADCALL |l| (QREFELT $ 21))
                                  (SPADCALL |lg| (QREFELT $ 77))
                                  (QREFELT $ 78)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |a| 0 (QREFELT $ 79))
                               (|spadConstant| $ 25) (QREFELT $ 80))
                     0)
                    ('T
                     (SEQ (LETT |i| 1) G190 NIL
                          (SEQ
                           (EXIT
                            (COND
                             ((SPADCALL
                               (SPADCALL |a|
                                         (LETT |j|
                                               (SPADCALL |i| (QREFELT $ 81)))
                                         (QREFELT $ 82))
                               (|spadConstant| $ 25) (QREFELT $ 80))
                              (PROGN (LETT #2# |i|) (GO #3=#:G824)))
                             ('T
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL
                                   (SPADCALL |a| (SPADCALL |j| (QREFELT $ 18))
                                             (QREFELT $ 82))
                                   (|spadConstant| $ 25) (QREFELT $ 80))
                                  (PROGN
                                   (LETT #1#
                                         (PROGN (LETT #2# (- |i|)) (GO #3#)))
                                   (GO #4=#:G820)))))
                               #4# (EXIT #1#))))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT NIL)))))))
                #3# (EXIT #2#)))) 

(SDEFUN |ODERAT;unitlist|
        ((|i| (|NonNegativeInteger|)) (|q| (|NonNegativeInteger|))
         ($ (|List| F)))
        (SPROG ((|v| (|Vector| F)))
               (SEQ (LETT |v| (MAKEARR1 |q| (|spadConstant| $ 25)))
                    (SPADCALL |v| |i| (|spadConstant| $ 16) (QREFELT $ 83))
                    (EXIT (SPADCALL |v| (QREFELT $ 85)))))) 

(SDEFUN |ODERAT;candidates|
        ((|op| (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
         (|lg| (|List| (|Fraction| UP))) (|d| (UP))
         ($
          (|Record| (|:| |basis| (|List| (|Fraction| UP)))
                    (|:| |particular| (|List| (|Fraction| UP))))))
        (SPROG
         ((|part| (|List| (|Fraction| UP))) (#1=#:G845 NIL) (|g| NIL)
          (#2=#:G844 NIL) (|a1| (|Fraction| UP))
          (|hom| (|List| (|Fraction| UP))) (#3=#:G843 NIL) (|i| NIL)
          (#4=#:G842 NIL) (|e| (|List| F)) (|q| (|NonNegativeInteger|))
          (|f| (|Mapping| |uts| (|List| |uts|))) (|dd| (|uts|))
          (|solver|
           (CATEGORY |package|
            (SIGNATURE |stFunc1|
             ((|Mapping| (|Stream| F) (|Stream| F)) (|Mapping| |uts| |uts|)))
            (SIGNATURE |stFunc2|
             ((|Mapping| (|Stream| F) (|Stream| F) (|Stream| F))
              (|Mapping| |uts| |uts| |uts|)))
            (SIGNATURE |stFuncN|
             ((|Mapping| (|Stream| F) (|List| (|Stream| F)))
              (|Mapping| |uts| (|List| |uts|))))
            (SIGNATURE |fixedPointExquo| (|uts| |uts| |uts|))
            (SIGNATURE |ode1| (|uts| (|Mapping| |uts| |uts|) F))
            (SIGNATURE |ode2| (|uts| (|Mapping| |uts| |uts| |uts|) F F))
            (SIGNATURE |ode|
             (|uts| (|Mapping| |uts| (|List| |uts|)) (|List| F)))
            (SIGNATURE |mpsode|
             ((|List| |uts|) (|List| F)
              (|List| (|Mapping| |uts| (|List| |uts|)))))))
          (|tools|
           (CATEGORY |package| (SIGNATURE UP2UTS (|uts| UP))
            (SIGNATURE UTS2UP (UP |uts| (|NonNegativeInteger|)))
            (SIGNATURE LODO2FUN
             ((|Mapping| |uts| (|List| |uts|))
              (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP))))
            (IF (|has| F (|IntegralDomain|))
                (SIGNATURE RF2UTS (|uts| (|Fraction| UP)))
                |noBranch|)))
          (|uts|
           (|Join| (|UnivariateTaylorSeriesCategory| F)
                   (CATEGORY |domain|
                    (SIGNATURE |coerce| ($ (|UnivariatePolynomial| |dummy| F)))
                    (SIGNATURE |univariatePolynomial|
                     ((|UnivariatePolynomial| |dummy| F) $
                      (|NonNegativeInteger|)))
                    (SIGNATURE |coerce| ($ (|Variable| |dummy|)))
                    (SIGNATURE |differentiate| ($ $ (|Variable| |dummy|)))
                    (SIGNATURE |lagrange| ($ $)) (SIGNATURE |lambert| ($ $))
                    (SIGNATURE |oddlambert| ($ $))
                    (SIGNATURE |evenlambert| ($ $))
                    (SIGNATURE |generalLambert| ($ $ (|Integer|) (|Integer|)))
                    (SIGNATURE |revert| ($ $))
                    (SIGNATURE |multisect| ($ (|Integer|) (|Integer|) $))
                    (SIGNATURE |invmultisect| ($ (|Integer|) (|Integer|) $))
                    (IF (|has| F (|Algebra| (|Fraction| (|Integer|))))
                        (SIGNATURE |integrate| ($ $ (|Variable| |dummy|)))
                        |noBranch|))))
          (|m| (|Integer|)) (|n| (|NonNegativeInteger|)))
         (SEQ
          (LETT |n|
                (+ (SPADCALL |d| (QREFELT $ 14))
                   (|ODERAT;infBound| |op| |lg| $)))
          (LETT |m| (|ODERAT;regularPoint| |op| |lg| $))
          (LETT |uts|
                (|UnivariateTaylorSeries| (QREFELT $ 6) (QREFELT $ 10)
                                          (SPADCALL |m| (QREFELT $ 81))))
          (LETT |tools|
                (|UTSodetools| (QREFELT $ 6) (QREFELT $ 7)
                               (|LinearOrdinaryDifferentialOperator2|
                                (QREFELT $ 7) (|Fraction| (QREFELT $ 7)))
                               |uts|))
          (LETT |solver|
                (|UnivariateTaylorSeriesODESolver| (QREFELT $ 6) |uts|))
          (LETT |dd|
                (SPADCALL |d|
                          (|compiledLookupCheck| 'UP2UTS
                                                 (LIST (|devaluate| |uts|)
                                                       (|devaluate| (ELT $ 7)))
                                                 |tools|)))
          (LETT |f|
                (SPADCALL |op|
                          (|compiledLookupCheck| 'LODO2FUN
                                                 (LIST
                                                  (LIST '|Mapping|
                                                        (|devaluate| |uts|)
                                                        (LIST '|List|
                                                              (|devaluate|
                                                               |uts|)))
                                                  (LIST
                                                   '|LinearOrdinaryDifferentialOperator2|
                                                   (|devaluate| (ELT $ 7))
                                                   (LIST '|Fraction|
                                                         (|devaluate|
                                                          (ELT $ 7)))))
                                                 |tools|)))
          (LETT |q| (SPADCALL |op| (QREFELT $ 20)))
          (LETT |e| (|ODERAT;unitlist| 1 |q| $))
          (LETT |hom|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |i| 1) (LETT #3# |q|) G190
                      (COND ((|greater_SI| |i| #3#) (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #4#
                              (CONS
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL |dd|
                                           (SPADCALL |f|
                                                     (|ODERAT;unitlist| |i| |q|
                                                      $)
                                                     (|compiledLookupCheck|
                                                      '|ode|
                                                      (LIST (|devaluate| |uts|)
                                                            (LIST '|Mapping|
                                                                  (|devaluate|
                                                                   |uts|)
                                                                  (LIST '|List|
                                                                        (|devaluate|
                                                                         |uts|)))
                                                            (LIST '|List|
                                                                  (|devaluate|
                                                                   (ELT $ 6))))
                                                      |solver|))
                                           (|compiledLookupCheck| '*
                                                                  (LIST '$ '$
                                                                        '$)
                                                                  |uts|))
                                 |n|
                                 (|compiledLookupCheck| 'UTS2UP
                                                        (LIST
                                                         (|devaluate|
                                                          (ELT $ 7))
                                                         (|devaluate| |uts|)
                                                         (LIST
                                                          '|NonNegativeInteger|))
                                                        |tools|))
                                |d| (QREFELT $ 86))
                               #4#))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                      (EXIT (NREVERSE #4#)))))
          (LETT |a1|
                (SPADCALL
                 (SPADCALL (SPADCALL |op| (QREFELT $ 21)) (QREFELT $ 22))
                 (QREFELT $ 23)))
          (LETT |part|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |g| NIL) (LETT #1# |lg|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |g| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL |dd|
                                           (SPADCALL
                                            (CONS #'|ODERAT;candidates!0|
                                                  (VECTOR |f| |tools| |uts| $
                                                          |g| |a1|))
                                            |e|
                                            (|compiledLookupCheck| '|ode|
                                                                   (LIST
                                                                    (|devaluate|
                                                                     |uts|)
                                                                    (LIST
                                                                     '|Mapping|
                                                                     (|devaluate|
                                                                      |uts|)
                                                                     (LIST
                                                                      '|List|
                                                                      (|devaluate|
                                                                       |uts|)))
                                                                    (LIST
                                                                     '|List|
                                                                     (|devaluate|
                                                                      (ELT $
                                                                           6))))
                                                                   |solver|))
                                           (|compiledLookupCheck| '*
                                                                  (LIST '$ '$
                                                                        '$)
                                                                  |uts|))
                                 |n|
                                 (|compiledLookupCheck| 'UTS2UP
                                                        (LIST
                                                         (|devaluate|
                                                          (ELT $ 7))
                                                         (|devaluate| |uts|)
                                                         (LIST
                                                          '|NonNegativeInteger|))
                                                        |tools|))
                                |d| (QREFELT $ 86))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (EXIT (CONS |hom| |part|))))) 

(SDEFUN |ODERAT;candidates!0| ((|l1| NIL) ($$ NIL))
        (PROG (|a1| |g| $ |uts| |tools| |f|)
          (LETT |a1| (QREFELT $$ 5))
          (LETT |g| (QREFELT $$ 4))
          (LETT $ (QREFELT $$ 3))
          (LETT |uts| (QREFELT $$ 2))
          (LETT |tools| (QREFELT $$ 1))
          (LETT |f| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL (SPADCALL |a1| |g| (QREFELT $ 24))
                       (|compiledLookupCheck| 'RF2UTS
                                              (LIST (|devaluate| |uts|)
                                                    (LIST '|Fraction|
                                                          (|devaluate|
                                                           (ELT $ 7))))
                                              |tools|))
             (SPADCALL |l1| |f|)
             (|compiledLookupCheck| '+ (LIST '$ '$ '$) |uts|)))))) 

(SDEFUN |ODERAT;nzero?| ((|v| (|Vector| F)) ($ (|Boolean|)))
        (SPROG ((#1=#:G851 NIL) (#2=#:G852 NIL) (#3=#:G853 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 87)))
                         (LETT #3# (QVSIZE |v|)) G190
                         (COND ((> |i| #3#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((NULL
                              (SPADCALL (QAREF1O |v| |i| 1) (QREFELT $ 88)))
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# 'T) (GO #4=#:G850)))
                              (GO #5=#:G848))))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT NIL)))
                #4# (EXIT #2#)))) 

(SDEFUN |ODERAT;UPfact| ((|n| (|NonNegativeInteger|)) ($ (UP)))
        (SPROG
         ((#1=#:G857 NIL) (#2=#:G856 (UP)) (#3=#:G858 (UP)) (#4=#:G862 NIL)
          (#5=#:G855 NIL) (|i| NIL) (|z| (UP)))
         (SEQ
          (COND ((ZEROP |n|) (|spadConstant| $ 17))
                (#6='T
                 (SEQ
                  (LETT |z| (SPADCALL (|spadConstant| $ 16) 1 (QREFELT $ 89)))
                  (EXIT
                   (PROGN
                    (LETT #1# NIL)
                    (SEQ (LETT |i| 0)
                         (LETT #4#
                               (PROG1 (LETT #5# (- |n| 1))
                                 (|check_subtype2| (>= #5# 0)
                                                   '(|NonNegativeInteger|)
                                                   '(|Integer|) #5#)))
                         G190 (COND ((|greater_SI| |i| #4#) (GO G191)))
                         (SEQ
                          (EXIT
                           (PROGN
                            (LETT #3#
                                  (SPADCALL |z|
                                            (SPADCALL
                                             (SPADCALL |i| (QREFELT $ 81))
                                             (QREFELT $ 90))
                                            (QREFELT $ 91)))
                            (COND
                             (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 78))))
                             ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                    (COND (#1# #2#) (#6# (|spadConstant| $ 17))))))))))) 

(SDEFUN |ODERAT;infMuLambda|
        ((|l| (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
         ($
          (|Record| (|:| |mu| (|Integer|))
                    (|:| |lambda| (|List| (|NonNegativeInteger|)))
                    (|:| |func| (|List| UP)))))
        (SPROG
         ((|lf| (|List| UP)) (|lamb| (|List| #1=(|NonNegativeInteger|)))
          (|mup| #2=(|Integer|)) (|m| #2#) (|d| #1#) (|a| (UP)))
         (SEQ (LETT |lamb| (LIST (LETT |d| (SPADCALL |l| (QREFELT $ 20)))))
              (LETT |lf| (LIST (LETT |a| (SPADCALL |l| (QREFELT $ 21)))))
              (LETT |mup| (- (SPADCALL |a| (QREFELT $ 14)) |d|))
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL (LETT |l| (SPADCALL |l| (QREFELT $ 92)))
                                (|spadConstant| $ 93) (QREFELT $ 94)))
                     (GO G191)))
                   (SEQ (LETT |a| (SPADCALL |l| (QREFELT $ 21)))
                        (LETT |m|
                              (- (SPADCALL |a| (QREFELT $ 14))
                                 (LETT |d| (SPADCALL |l| (QREFELT $ 20)))))
                        (EXIT
                         (COND
                          ((> |m| |mup|)
                           (SEQ (LETT |mup| |m|) (LETT |lamb| (LIST |d|))
                                (EXIT (LETT |lf| (LIST |a|)))))
                          ((EQL |m| |mup|)
                           (SEQ (LETT |lamb| (CONS |d| |lamb|))
                                (EXIT (LETT |lf| (CONS |a| |lf|))))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT (VECTOR |mup| |lamb| |lf|))))) 

(SDEFUN |ODERAT;infIndicialEquation|
        ((|lambda| (|List| (|NonNegativeInteger|))) (|lf| (|List| UP))
         ($ (UP)))
        (SPROG
         ((|ans| (UP)) (#1=#:G875 NIL) (|i| NIL) (#2=#:G876 NIL) (|f| NIL))
         (SEQ (LETT |ans| (|spadConstant| $ 26))
              (SEQ (LETT |f| NIL) (LETT #2# |lf|) (LETT |i| NIL)
                   (LETT #1# |lambda|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |i| (CAR #1#)) NIL) (ATOM #2#)
                         (PROGN (LETT |f| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |ans|
                           (SPADCALL |ans|
                                     (SPADCALL
                                      (SPADCALL (|ODERAT;evenodd| |i| $)
                                                (SPADCALL |f| (QREFELT $ 95))
                                                (QREFELT $ 96))
                                      (|ODERAT;UPfact| |i| $) (QREFELT $ 97))
                                     (QREFELT $ 91)))))
                   (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#)))) (GO G190)
                   G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |ODERAT;infBound|
        ((|l| (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
         (|lg| (|List| (|Fraction| UP))) ($ (|NonNegativeInteger|)))
        (SPROG
         ((#1=#:G886 NIL) (|m| #2=(|Integer|)) (|mm| #2#) (#3=#:G890 NIL)
          (|g| NIL) (#4=#:G881 NIL) (|n| (|Integer|))
          (|rec|
           (|Record| (|:| |mu| (|Integer|))
                     (|:| |lambda| (|List| (|NonNegativeInteger|)))
                     (|:| |func| (|List| UP)))))
         (SEQ (LETT |rec| (|ODERAT;infMuLambda| |l| $))
              (LETT |n|
                    (MIN (- (- (SPADCALL |l| (QREFELT $ 20))) 1)
                         (SPADCALL
                          (|ODERAT;infIndicialEquation| (QVELT |rec| 1)
                           (QVELT |rec| 2) $)
                          (QREFELT $ 99))))
              (SEQ G190
                   (COND
                    ((NULL
                      (COND ((NULL |lg|) NIL)
                            ('T (SPADCALL (|SPADfirst| |lg|) (QREFELT $ 54)))))
                     (GO G191)))
                   (SEQ (EXIT (LETT |lg| (CDR |lg|)))) NIL (GO G190) G191
                   (EXIT NIL))
              (EXIT
               (COND
                ((NULL |lg|)
                 (PROG1 (LETT #4# (- |n|))
                   (|check_subtype2| (>= #4# 0) '(|NonNegativeInteger|)
                                     '(|Integer|) #4#)))
                ('T
                 (SEQ (LETT |m| (|ODERAT;infOrder| (|SPADfirst| |lg|) $))
                      (SEQ (LETT |g| NIL) (LETT #3# (CDR |lg|)) G190
                           (COND
                            ((OR (ATOM #3#) (PROGN (LETT |g| (CAR #3#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((NULL (SPADCALL |g| (QREFELT $ 54)))
                               (SEQ (LETT |mm| (|ODERAT;infOrder| |g| $))
                                    (EXIT
                                     (COND
                                      ((< |mm| |m|) (LETT |m| |mm|)))))))))
                           (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (PROG1
                           (LETT #1#
                                 (-
                                  (MIN |n|
                                       (+
                                        (- (QVELT |rec| 0)
                                           (SPADCALL
                                            (SPADCALL |l| (QREFELT $ 21))
                                            (QREFELT $ 14)))
                                        |m|))))
                         (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                           '(|Integer|) #1#)))))))))) 

(SDEFUN |ODERAT;makeDot|
        ((|v| (|Vector| F)) (|bas| (|List| (|Fraction| UP)))
         ($ (|Fraction| UP)))
        (SPROG ((|ans| (|Fraction| UP)) (|i| NIL) (#1=#:G895 NIL) (|b| NIL))
               (SEQ (LETT |ans| (|spadConstant| $ 55))
                    (SEQ (LETT |b| NIL) (LETT #1# |bas|) (LETT |i| 1) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |b| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |ans|
                                 (SPADCALL |ans|
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL |v| |i| (QREFELT $ 100))
                                             (QREFELT $ 90))
                                            |b| (QREFELT $ 101))
                                           (QREFELT $ 69)))))
                         (LETT |i| (PROG1 (|inc_SI| |i|) (LETT #1# (CDR #1#))))
                         (GO G190) G191 (EXIT NIL))
                    (EXIT |ans|)))) 

(SDEFUN |ODERAT;ratDsolve;LodoFR;16|
        ((|op| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         (|g| (|Fraction| UP))
         ($
          (|Record| (|:| |particular| (|Union| (|Fraction| UP) "failed"))
                    (|:| |basis| (|List| (|Fraction| UP))))))
        (SPROG
         ((|rec|
           (|Record|
            (|:| |eq|
                 (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
            (|:| |rh| (|List| (|Fraction| UP))))))
         (SEQ (LETT |rec| (SPADCALL |op| (LIST |g|) (QREFELT $ 74)))
              (EXIT
               (|ODERAT;ratDsolve0| (QCAR |rec|) (|SPADfirst| (QCDR |rec|))
                $))))) 

(SDEFUN |ODERAT;ratDsolve;LodoLR;17|
        ((|op| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         (|lg| (|List| (|Fraction| UP)))
         ($
          (|Record| (|:| |basis| (|List| (|Fraction| UP)))
                    (|:| |mat| (|Matrix| F)))))
        (SPROG
         ((|rec|
           (|Record|
            (|:| |eq|
                 (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
            (|:| |rh| (|List| (|Fraction| UP))))))
         (SEQ (LETT |rec| (SPADCALL |op| |lg| (QREFELT $ 74)))
              (EXIT (|ODERAT;ratDsolve1| (QCAR |rec|) (QCDR |rec|) $))))) 

(SDEFUN |ODERAT;ratDsolve;LodoFR;18|
        ((|op| (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
         (|g| (|Fraction| UP))
         ($
          (|Record| (|:| |particular| (|Union| (|Fraction| UP) "failed"))
                    (|:| |basis| (|List| (|Fraction| UP))))))
        (SPROG ((#1=#:G908 NIL) (|c| (UP)))
               (COND
                ((SPADCALL (LETT |c| (SPADCALL |op| (QREFELT $ 106)))
                           (QREFELT $ 107))
                 (|ODERAT;ratDsolve0| |op| |g| $))
                ('T
                 (|ODERAT;ratDsolve0|
                  (PROG2 (LETT #1# (SPADCALL |op| |c| (QREFELT $ 109)))
                      (QCDR #1#)
                    (|check_union2| (QEQCAR #1# 0)
                                    (|LinearOrdinaryDifferentialOperator2|
                                     (QREFELT $ 7) (|Fraction| (QREFELT $ 7)))
                                    (|Union|
                                     (|LinearOrdinaryDifferentialOperator2|
                                      (QREFELT $ 7) (|Fraction| (QREFELT $ 7)))
                                     "failed")
                                    #1#))
                  (SPADCALL
                   (SPADCALL (SPADCALL |c| (QREFELT $ 22)) (QREFELT $ 23)) |g|
                   (QREFELT $ 24))
                  $))))) 

(SDEFUN |ODERAT;ratDsolve;LodoLR;19|
        ((|op| (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
         (|lg| (|List| (|Fraction| UP)))
         ($
          (|Record| (|:| |basis| (|List| (|Fraction| UP)))
                    (|:| |mat| (|Matrix| F)))))
        (SPROG
         ((#1=#:G921 NIL) (|g| NIL) (#2=#:G920 NIL) (#3=#:G914 NIL) (|c| (UP)))
         (SEQ
          (COND
           ((SPADCALL (LETT |c| (SPADCALL |op| (QREFELT $ 106)))
                      (QREFELT $ 107))
            (|ODERAT;ratDsolve1| |op| |lg| $))
           ('T
            (|ODERAT;ratDsolve1|
             (PROG2 (LETT #3# (SPADCALL |op| |c| (QREFELT $ 109)))
                 (QCDR #3#)
               (|check_union2| (QEQCAR #3# 0)
                               (|LinearOrdinaryDifferentialOperator2|
                                (QREFELT $ 7) (|Fraction| (QREFELT $ 7)))
                               (|Union|
                                (|LinearOrdinaryDifferentialOperator2|
                                 (QREFELT $ 7) (|Fraction| (QREFELT $ 7)))
                                "failed")
                               #3#))
             (PROGN
              (LETT #2# NIL)
              (SEQ (LETT |g| NIL) (LETT #1# |lg|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |g| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT #2#
                           (CONS
                            (SPADCALL
                             (SPADCALL (SPADCALL |c| (QREFELT $ 22))
                                       (QREFELT $ 23))
                             |g| (QREFELT $ 24))
                            #2#))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#))))
             $)))))) 

(SDEFUN |ODERAT;integrate_sols;LodoR;20|
        ((|op| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         ($
          (|Record|
           (|:| |ltilde|
                (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
           (|:| |r|
                (|Union|
                 (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP))
                 "failed")))))
        (SPADCALL |op| (ELT $ 103) (QREFELT $ 116))) 

(DECLAIM (NOTINLINE |RationalLODE;|)) 

(DEFUN |RationalLODE| (&REST #1=#:G927)
  (SPROG NIL
         (PROG (#2=#:G928)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|RationalLODE|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |RationalLODE;|) #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|RationalLODE|)))))))))) 

(DEFUN |RationalLODE;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|RationalLODE| DV$1 DV$2))
          (LETT $ (GETREFV 118))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|RationalLODE| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 10 (SPADCALL (QREFELT $ 9)))
          $))) 

(MAKEPROP '|RationalLODE| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Symbol|)
              (0 . |new|) '|dummy| (|Fraction| 7) (4 . |denom|)
              (|NonNegativeInteger|) (9 . |degree|) (14 . |numer|) (19 . |One|)
              (23 . |One|) (27 . -)
              (|LinearOrdinaryDifferentialOperator2| 7 11) (32 . |degree|)
              (37 . |leadingCoefficient|) (42 . |coerce|) (47 . |inv|) (52 . *)
              (58 . |Zero|) (62 . |Zero|) (|List| 11)
              (|PrimitiveRatDE| 6 7 19 73) (66 . |denomLODE|) (|Integer|)
              (72 . |elt|) (78 . |elt|) (84 . -) (90 . |concat|) (|List| 27)
              (|Matrix| 11) (96 . |matrix|) (|Matrix| 7) (|Matrix| $)
              (101 . |reducedSystem|) (|Matrix| 6) (106 . |reducedSystem|)
              (111 . |minimumDegree|) (116 . |monomial|)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (122 . |monicRightDivide|) (128 . |One|) (|Union| 11 '"failed")
              (|RationalIntegration| 6 7) (132 . |infieldint|)
              (|Union| 7 '"failed") (137 . |denomLODE|) (|Boolean|)
              (143 . |zero?|) (148 . |Zero|) (152 . =) (|Vector| 11)
              (158 . |vector|)
              (|Record| (|:| |mat| 38) (|:| |vec| (|Vector| 7))) (|Vector| $)
              (163 . |reducedSystem|) (|Record| (|:| |mat| 41) (|:| |vec| 66))
              (169 . |reducedSystem|) (|Union| 66 '"failed")
              (|Record| (|:| |particular| 64) (|:| |basis| (|List| 66)))
              (|Vector| 6) (|LinearSystemMatrixPackage| 6 66 66 41)
              (175 . |solve|) (181 . +) (187 . |concat!|)
              |ODERAT;indicialEquationAtInfinity;LodoUP;5|
              (|Record| (|:| |eq| 19) (|:| |rh| 27))
              (|LinearOrdinaryDifferentialOperator1| 11)
              (193 . |splitDenominator|)
              |ODERAT;indicialEquationAtInfinity;LodoUP;6|
              (|InnerCommonDenominator| 7 11 (|List| 7) 27)
              (199 . |commonDenominator|) (204 . *) (210 . |coefficient|)
              (216 . ~=) (222 . |coerce|) (227 . |elt|) (233 . |setelt!|)
              (|List| 6) (240 . |parts|) (245 . /) (251 . |minIndex|)
              (256 . |zero?|) (261 . |monomial|) (267 . |coerce|) (272 . +)
              (278 . |reductum|) (283 . |Zero|) (287 . ~=)
              (293 . |leadingCoefficient|) (298 . *) (304 . *)
              (|BoundIntegerRoots| 6 7) (310 . |integerBound|) (315 . |elt|)
              (321 . *) (|Record| (|:| |particular| 48) (|:| |basis| 27))
              |ODERAT;ratDsolve;LodoFR;16|
              (|Record| (|:| |basis| 27) (|:| |mat| 41))
              |ODERAT;ratDsolve;LodoLR;17| (327 . |content|) (332 . |unit?|)
              (|Union| $ '"failed") (337 . |exquo|)
              |ODERAT;ratDsolve;LodoFR;18| |ODERAT;ratDsolve;LodoLR;19|
              (|Union| 73 '"failed") (|Record| (|:| |ltilde| 73) (|:| |r| 112))
              (|Mapping| 102 73 11) (|IntegrateSolutions| 11 73)
              (343 . |integrate_sols|) |ODERAT;integrate_sols;LodoR;20|)
           '#(|ratDsolve| 349 |integrate_sols| 373 |indicialEquationAtInfinity|
              378)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|ratDsolve|
                                 ((|Record|
                                   (|:| |particular|
                                        (|Union| (|Fraction| |#2|)
                                                 #1="failed"))
                                   (|:| |basis| (|List| (|Fraction| |#2|))))
                                  (|LinearOrdinaryDifferentialOperator1|
                                   (|Fraction| |#2|))
                                  (|Fraction| |#2|)))
                                T)
                              '((|ratDsolve|
                                 ((|Record|
                                   (|:| |basis| (|List| (|Fraction| |#2|)))
                                   (|:| |mat| (|Matrix| |#1|)))
                                  (|LinearOrdinaryDifferentialOperator1|
                                   (|Fraction| |#2|))
                                  (|List| (|Fraction| |#2|))))
                                T)
                              '((|ratDsolve|
                                 ((|Record|
                                   (|:| |particular|
                                        (|Union| (|Fraction| |#2|) #1#))
                                   (|:| |basis| (|List| (|Fraction| |#2|))))
                                  (|LinearOrdinaryDifferentialOperator2| |#2|
                                                                         (|Fraction|
                                                                          |#2|))
                                  (|Fraction| |#2|)))
                                T)
                              '((|ratDsolve|
                                 ((|Record|
                                   (|:| |basis| (|List| (|Fraction| |#2|)))
                                   (|:| |mat| (|Matrix| |#1|)))
                                  (|LinearOrdinaryDifferentialOperator2| |#2|
                                                                         (|Fraction|
                                                                          |#2|))
                                  (|List| (|Fraction| |#2|))))
                                T)
                              '((|indicialEquationAtInfinity|
                                 (|#2|
                                  (|LinearOrdinaryDifferentialOperator1|
                                   (|Fraction| |#2|))))
                                T)
                              '((|indicialEquationAtInfinity|
                                 (|#2|
                                  (|LinearOrdinaryDifferentialOperator2| |#2|
                                                                         (|Fraction|
                                                                          |#2|))))
                                T)
                              '((|integrate_sols|
                                 ((|Record|
                                   (|:| |ltilde|
                                        (|LinearOrdinaryDifferentialOperator1|
                                         (|Fraction| |#2|)))
                                   (|:| |r|
                                        (|Union|
                                         (|LinearOrdinaryDifferentialOperator1|
                                          (|Fraction| |#2|))
                                         "failed")))
                                  (|LinearOrdinaryDifferentialOperator1|
                                   (|Fraction| |#2|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 117
                                            '(0 8 0 9 1 11 7 0 12 1 7 13 0 14 1
                                              11 7 0 15 0 6 0 16 0 7 0 17 1 6 0
                                              0 18 1 19 13 0 20 1 19 7 0 21 1
                                              11 0 7 22 1 11 0 0 23 2 11 0 0 0
                                              24 0 6 0 25 0 7 0 26 2 28 7 19 27
                                              29 2 27 11 0 30 31 2 19 11 0 11
                                              32 2 11 0 0 0 33 2 27 0 0 0 34 1
                                              36 0 35 37 1 11 38 39 40 1 7 41
                                              39 42 1 19 13 0 43 2 19 0 7 13 44
                                              2 19 45 0 0 46 0 11 0 47 1 49 48
                                              11 50 2 28 51 19 11 52 1 11 53 0
                                              54 0 11 0 55 2 11 53 0 0 56 1 57
                                              0 27 58 2 11 59 39 60 61 2 7 62
                                              39 60 63 2 67 65 41 66 68 2 11 0
                                              0 0 69 2 27 0 0 0 70 2 28 72 73
                                              27 74 1 76 7 27 77 2 7 0 0 0 78 2
                                              7 6 0 13 79 2 6 53 0 0 80 1 6 0
                                              30 81 2 7 6 0 6 82 3 66 6 0 30 6
                                              83 1 66 84 0 85 2 11 0 7 7 86 1
                                              66 30 0 87 1 6 53 0 88 2 7 0 6 13
                                              89 1 7 0 6 90 2 7 0 0 0 91 1 19 0
                                              0 92 0 19 0 93 2 19 53 0 0 94 1 7
                                              6 0 95 2 6 0 0 0 96 2 7 0 6 0 97
                                              1 98 30 7 99 2 66 6 0 30 100 2 11
                                              0 7 0 101 1 19 7 0 106 1 7 53 0
                                              107 2 19 108 0 7 109 2 115 113 73
                                              114 116 2 0 102 73 11 103 2 0 102
                                              19 11 110 2 0 104 73 27 105 2 0
                                              104 19 27 111 1 0 113 73 117 1 0
                                              7 73 75 1 0 7 19 71)))))
           '|lookupComplete|)) 
