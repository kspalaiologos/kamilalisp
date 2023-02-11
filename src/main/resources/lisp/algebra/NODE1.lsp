
(SDEFUN |NODE1;solve;2FBoSU;1|
        ((|m| (F)) (|n| (F)) (|y| (|BasicOperator|)) (|x| (|Symbol|))
         ($ (|Union| F #1="failed")))
        (SPROG
         ((|v| (|Union| (|List| F) "failed"))
          (|w|
           (|Union|
            (|Record| (|:| |coef1| F) (|:| |coefn| F)
                      (|:| |exponent| (|NonNegativeInteger|)))
            "failed"))
          (|k1| (|Kernel| F)) (|nn| (F)) (|mm| (F)) (|mu| (F))
          (|u| (|Union| F #1#)) (|d| (F)) (|lv| (|List| F))
          (|lk| (|List| (|Kernel| F))) (|yx| (F)))
         (SEQ
          (LETT |lk|
                (LIST
                 (SPADCALL
                  (LETT |yx|
                        (SPADCALL |y| (SPADCALL |x| (QREFELT $ 14))
                                  (QREFELT $ 16)))
                  (QREFELT $ 18))))
          (LETT |lv| (LIST (SPADCALL (QREFELT $ 13) (QREFELT $ 19))))
          (LETT |mm| (SPADCALL |m| |lk| |lv| (QREFELT $ 22)))
          (LETT |nn| (SPADCALL |n| |lk| |lv| (QREFELT $ 22)))
          (LETT |d|
                (SPADCALL
                 (SPADCALL (SPADCALL |mm| (QREFELT $ 24))
                           (SPADCALL |nn| (QREFELT $ 24)) (QREFELT $ 26))
                 (QREFELT $ 27)))
          (LETT |mm| (SPADCALL |d| |mm| (QREFELT $ 28)))
          (LETT |nn| (SPADCALL |d| |nn| (QREFELT $ 28)))
          (LETT |u|
                (|NODE1;integratingFactor| |mm| |nn| |d| (QREFELT $ 10) |x| $))
          (EXIT
           (COND
            ((QEQCAR |u| 0)
             (SEQ (LETT |mu| (QCDR |u|))
                  (LETT |mm| (SPADCALL |mm| |mu| (QREFELT $ 28)))
                  (LETT |nn| (SPADCALL |nn| |mu| (QREFELT $ 28)))
                  (EXIT
                   (CONS 0
                         (SPADCALL
                          (SPADCALL (SPADCALL |mm| |x| (QREFELT $ 30))
                                    (SPADCALL
                                     (SPADCALL |nn|
                                               (SPADCALL
                                                (SPADCALL |mm| (QREFELT $ 10)
                                                          (QREFELT $ 31))
                                                |x| (QREFELT $ 30))
                                               (QREFELT $ 32))
                                     (QREFELT $ 10) (QREFELT $ 30))
                                    (QREFELT $ 33))
                          (LIST (QREFELT $ 13)) (LIST |yx|) (QREFELT $ 22))))))
            (#2='T
             (SEQ
              (LETT |w|
                    (|NODE1;checkBernoulli| |m| |n|
                     (LETT |k1| (|SPADfirst| |lk|)) $))
              (EXIT
               (COND
                ((QEQCAR |w| 0)
                 (|NODE1;solveBernoulli| (QCDR |w|) |y| |x| |yx| $))
                (#2#
                 (SEQ (LETT |v| (|NODE1;checkRiccati| |m| |n| |k1| $))
                      (EXIT
                       (COND
                        ((QEQCAR |v| 0)
                         (|NODE1;solveRiccati| (QCDR |v|) |y| |x| |yx| $))
                        (#2# (CONS 1 "failed"))))))))))))))) 

(SDEFUN |NODE1;integratingFactor|
        ((|m| (F)) (|n| (F)) (|den| (F)) (|y| (|Symbol|)) (|x| (|Symbol|))
         ($ (|Union| F "failed")))
        (SPROG ((|f| (F)) (|d| (F)))
               (COND
                ((SPADCALL
                  (LETT |d|
                        (SPADCALL (SPADCALL |m| |y| (QREFELT $ 31))
                                  (SPADCALL |n| |x| (QREFELT $ 31))
                                  (QREFELT $ 32)))
                  (QREFELT $ 37))
                 (CONS 0 (|spadConstant| $ 38)))
                ((SPADCALL
                  (SPADCALL
                   (SPADCALL (SPADCALL |m| |den| (QREFELT $ 39)) |y|
                             (QREFELT $ 31))
                   (SPADCALL (SPADCALL |n| |den| (QREFELT $ 39)) |x|
                             (QREFELT $ 31))
                   (QREFELT $ 32))
                  (QREFELT $ 37))
                 (CONS 0
                       (SPADCALL (|spadConstant| $ 38) |den| (QREFELT $ 39))))
                ((NULL
                  (SPADCALL |y|
                            (SPADCALL
                             (LETT |f| (SPADCALL |d| |n| (QREFELT $ 39)))
                             (QREFELT $ 42))
                            (QREFELT $ 43)))
                 (CONS 0 (SPADCALL |f| |x| (QREFELT $ 44))))
                ((NULL
                  (SPADCALL |x|
                            (SPADCALL
                             (LETT |f|
                                   (SPADCALL (SPADCALL |d| |m| (QREFELT $ 39))
                                             (QREFELT $ 45)))
                             (QREFELT $ 42))
                            (QREFELT $ 43)))
                 (CONS 0 (SPADCALL |f| |y| (QREFELT $ 44))))
                ('T (CONS 1 "failed"))))) 

(SDEFUN |NODE1;checkBernoulli|
        ((|m| (F)) (|n| (F)) (|ky| (|Kernel| F))
         ($
          (|Union|
           (|Record| (|:| |coef1| F) (|:| |coefn| F)
                     (|:| |exponent| (|NonNegativeInteger|)))
           "failed")))
        (SPROG
         ((#1=#:G767 NIL) (|b| (F)) (|a| (F))
          (|pp|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| R (|Kernel| F))))
          (|d| (|NonNegativeInteger|))
          (|p|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| R (|Kernel| F))))
          (|y| (F)) (|r| (F)) (|f| (F)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |r|
                  (SPADCALL
                   (SPADCALL (LETT |f| (SPADCALL |m| |n| (QREFELT $ 39)))
                             (QREFELT $ 24))
                   (QREFELT $ 27)))
            (COND
             ((SPADCALL |r| (LETT |y| (SPADCALL |ky| (QREFELT $ 19)))
                        (QREFELT $ 46))
              (SEQ
               (LETT |d|
                     (SPADCALL
                      (LETT |p|
                            (SPADCALL (SPADCALL |f| (QREFELT $ 47)) |ky|
                                      (QREFELT $ 49)))
                      (QREFELT $ 52)))
               (EXIT
                (COND
                 ((OR (< |d| 2)
                      (OR
                       (SPADCALL
                        (SPADCALL (LETT |pp| (SPADCALL |p| (QREFELT $ 53)))
                                  (QREFELT $ 52))
                        1 (QREFELT $ 54))
                       (OR
                        (OR
                         (SPADCALL (SPADCALL |pp| (QREFELT $ 53))
                                   (|spadConstant| $ 55) (QREFELT $ 56))
                         (NULL
                          (SPADCALL
                           (LETT |a|
                                 (SPADCALL (SPADCALL |pp| (QREFELT $ 57))
                                           (QREFELT $ 27)))
                           |y| (QREFELT $ 46))))
                        (NULL
                         (SPADCALL
                          (LETT |b|
                                (SPADCALL (SPADCALL |p| (QREFELT $ 57))
                                          (QREFELT $ 27)))
                          |y| (QREFELT $ 46))))))
                  (PROGN (LETT #1# (CONS 1 #2="failed")) (GO #3=#:G765)))))))
             ('T (EXIT (CONS 1 #2#))))
            (EXIT
             (CONS 0
                   (VECTOR (SPADCALL |a| |r| (QREFELT $ 39))
                           (SPADCALL |b| |r| (QREFELT $ 39)) |d|)))))
          #3# (EXIT #1#)))) 

(SDEFUN |NODE1;solveBernoulli|
        ((|rec|
          (|Record| (|:| |coef1| F) (|:| |coefn| F)
                    (|:| |exponent| (|NonNegativeInteger|))))
         (|y| (|BasicOperator|)) (|x| (|Symbol|)) (|yx| (F))
         ($ (|Union| F "failed")))
        (SPROG
         ((|sol| (|Record| (|:| |particular| F) (|:| |basis| (|List| F))))
          (#1=#:G774 NIL) (|deq| (F)) (|n1| (|Integer|)))
         (SEQ (LETT |n1| (- 1 (QVELT |rec| 2)))
              (LETT |deq|
                    (SPADCALL
                     (SPADCALL (SPADCALL |yx| |x| (QREFELT $ 31))
                               (SPADCALL
                                (SPADCALL |n1| (QVELT |rec| 0) (QREFELT $ 59))
                                |yx| (QREFELT $ 28))
                               (QREFELT $ 33))
                     (SPADCALL |n1| (QVELT |rec| 1) (QREFELT $ 59))
                     (QREFELT $ 33)))
              (LETT |sol|
                    (PROG2 (LETT #1# (SPADCALL |deq| |y| |x| (QREFELT $ 63)))
                        (QCDR #1#)
                      (|check_union2| (QEQCAR #1# 0)
                                      (|Record|
                                       (|:| |particular| (QREFELT $ 7))
                                       (|:| |basis| (|List| (QREFELT $ 7))))
                                      (|Union|
                                       (|Record|
                                        (|:| |particular| (QREFELT $ 7))
                                        (|:| |basis| (|List| (QREFELT $ 7))))
                                       (QREFELT $ 7) "failed")
                                      #1#)))
              (EXIT
               (CONS 0
                     (SPADCALL
                      (SPADCALL (SPADCALL |yx| |n1| (QREFELT $ 64))
                                (QCAR |sol|) (QREFELT $ 32))
                      (|SPADfirst| (QCDR |sol|)) (QREFELT $ 39))))))) 

(SDEFUN |NODE1;checkRiccati|
        ((|m| (F)) (|n| (F)) (|ky| (|Kernel| F))
         ($ (|Union| (|List| F) "failed")))
        (SPROG
         ((|a2| (F)) (|a1| (F)) (|a0| (F))
          (|p|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| R (|Kernel| F))))
          (|y| (F)) (|q| (F)) (|f| (F)))
         (SEQ
          (LETT |q|
                (SPADCALL
                 (SPADCALL (LETT |f| (SPADCALL |m| |n| (QREFELT $ 39)))
                           (QREFELT $ 24))
                 (QREFELT $ 27)))
          (COND
           ((SPADCALL |q| (LETT |y| (SPADCALL |ky| (QREFELT $ 19)))
                      (QREFELT $ 46))
            (COND
             ((OR
               (OR
                (OR
                 (>
                  (SPADCALL
                   (LETT |p|
                         (SPADCALL (SPADCALL |f| (QREFELT $ 47)) |ky|
                                   (QREFELT $ 49)))
                   (QREFELT $ 52))
                  2)
                 (NULL
                  (SPADCALL
                   (LETT |a0|
                         (SPADCALL (SPADCALL |p| 0 (QREFELT $ 67))
                                   (QREFELT $ 27)))
                   |y| (QREFELT $ 46))))
                (NULL
                 (SPADCALL
                  (LETT |a1|
                        (SPADCALL (SPADCALL |p| 1 (QREFELT $ 67))
                                  (QREFELT $ 27)))
                  |y| (QREFELT $ 46))))
               (NULL
                (SPADCALL
                 (LETT |a2|
                       (SPADCALL (SPADCALL |p| 2 (QREFELT $ 67))
                                 (QREFELT $ 27)))
                 |y| (QREFELT $ 46))))
              (EXIT (CONS 1 #1="failed")))))
           ('T (EXIT (CONS 1 #1#))))
          (EXIT
           (CONS 0
                 (LIST (SPADCALL |a0| |q| (QREFELT $ 39))
                       (SPADCALL |a1| |q| (QREFELT $ 39))
                       (SPADCALL |a2| |q| (QREFELT $ 39)))))))) 

(SDEFUN |NODE1;solveRiccati|
        ((|l| (|List| F)) (|y| (|BasicOperator|)) (|x| (|Symbol|)) (|yx| (F))
         ($ (|Union| F "failed")))
        (SPROG
         ((|gsol| (|Record| (|:| |particular| F) (|:| |basis| (|List| F))))
          (#1=#:G802 NIL) (|deq| (F)) (|u| (|Union| F "failed")))
         (SEQ (LETT |u| (|NODE1;partSolRiccati| |l| |y| |x| |yx| $))
              (EXIT
               (COND ((QEQCAR |u| 1) (CONS 1 "failed"))
                     ('T
                      (SEQ
                       (LETT |deq|
                             (SPADCALL
                              (SPADCALL (SPADCALL |yx| |x| (QREFELT $ 31))
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL |l| 2 (QREFELT $ 69))
                                          (SPADCALL
                                           (SPADCALL 2
                                                     (SPADCALL |l| 3
                                                               (QREFELT $ 69))
                                                     (QREFELT $ 71))
                                           (QCDR |u|) (QREFELT $ 28))
                                          (QREFELT $ 33))
                                         |yx| (QREFELT $ 28))
                                        (QREFELT $ 32))
                              (SPADCALL |l| 3 (QREFELT $ 69)) (QREFELT $ 32)))
                       (LETT |gsol|
                             (PROG2
                                 (LETT #1#
                                       (SPADCALL |deq| |y| |x| (QREFELT $ 63)))
                                 (QCDR #1#)
                               (|check_union2| (QEQCAR #1# 0)
                                               (|Record|
                                                (|:| |particular|
                                                     (QREFELT $ 7))
                                                (|:| |basis|
                                                     (|List| (QREFELT $ 7))))
                                               (|Union|
                                                (|Record|
                                                 (|:| |particular|
                                                      (QREFELT $ 7))
                                                 (|:| |basis|
                                                      (|List| (QREFELT $ 7))))
                                                (QREFELT $ 7) "failed")
                                               #1#)))
                       (EXIT
                        (CONS 0
                              (SPADCALL
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL |yx| (QCDR |u|) (QREFELT $ 32))
                                 (QREFELT $ 72))
                                (QCAR |gsol|) (QREFELT $ 32))
                               (|SPADfirst| (QCDR |gsol|))
                               (QREFELT $ 39))))))))))) 

(SDEFUN |NODE1;partSolRiccati|
        ((|l| (|List| F)) (|y| (|BasicOperator|)) (|x| (|Symbol|)) (|yx| (F))
         ($ (|Union| F "failed")))
        (SPROG
         ((#1=#:G820 NIL) (|bas| #2=(|List| F))
          (|gsol|
           (|Union| (|Record| (|:| |particular| F) (|:| |basis| #2#)) F
                    "failed"))
          (|lineq| (F)) (|q1| (F)) (|q0| (F)) (|l3| (F)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |q0|
                  (SPADCALL (SPADCALL |l| 1 (QREFELT $ 69))
                            (LETT |l3| (SPADCALL |l| 3 (QREFELT $ 69)))
                            (QREFELT $ 28)))
            (LETT |q1|
                  (SPADCALL (SPADCALL |l| 2 (QREFELT $ 69))
                            (SPADCALL (SPADCALL |l3| |x| (QREFELT $ 31)) |l3|
                                      (QREFELT $ 39))
                            (QREFELT $ 32)))
            (LETT |lineq|
                  (SPADCALL
                   (SPADCALL (SPADCALL |yx| |x| 2 (QREFELT $ 73))
                             (SPADCALL |q1| (SPADCALL |yx| |x| (QREFELT $ 31))
                                       (QREFELT $ 28))
                             (QREFELT $ 33))
                   (SPADCALL |q0| |yx| (QREFELT $ 28)) (QREFELT $ 33)))
            (SEQ (LETT |gsol| (SPADCALL |lineq| |y| |x| (QREFELT $ 63)))
                 (EXIT
                  (COND
                   ((QEQCAR |gsol| 0)
                    (COND
                     ((NULL (LETT |bas| (QCDR (QCDR |gsol|))))
                      (PROGN (LETT #1# (CONS 1 #3="failed")) (GO #4=#:G818)))))
                   ('T (PROGN (LETT #1# (CONS 1 #3#)) (GO #4#))))))
            (EXIT
             (CONS 0
                   (SPADCALL (SPADCALL (|SPADfirst| |bas|) |x| (QREFELT $ 31))
                             (SPADCALL |l3| (|SPADfirst| |bas|) (QREFELT $ 28))
                             (QREFELT $ 39))))))
          #4# (EXIT #1#)))) 

(DECLAIM (NOTINLINE |NonLinearFirstOrderODESolver;|)) 

(DEFUN |NonLinearFirstOrderODESolver| (&REST #1=#:G821)
  (SPROG NIL
         (PROG (#2=#:G822)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|NonLinearFirstOrderODESolver|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |NonLinearFirstOrderODESolver;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|NonLinearFirstOrderODESolver|)))))))))) 

(DEFUN |NonLinearFirstOrderODESolver;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|NonLinearFirstOrderODESolver| DV$1 DV$2))
          (LETT $ (GETREFV 74))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|NonLinearFirstOrderODESolver|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 10 (SPADCALL (QREFELT $ 9)))
          (QSETREFV $ 13 (SPADCALL (QREFELT $ 10) (QREFELT $ 12)))
          $))) 

(MAKEPROP '|NonLinearFirstOrderODESolver| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Symbol|)
              (0 . |new|) '|unk| (|Kernel| 7) (4 . |kernel|) '|kunk|
              (9 . |coerce|) (|BasicOperator|) (14 . |elt|) (|Kernel| $)
              (20 . |retract|) (25 . |coerce|) (|List| 17) (|List| $)
              (30 . |eval|) (|SparseMultivariatePolynomial| 6 17)
              (37 . |denom|) (|SparseMultivariatePolynomial| 6 11) (42 . |lcm|)
              (48 . |coerce|) (53 . *) (|ODEIntegration| 6 7) (59 . |int|)
              (65 . |differentiate|) (71 . -) (77 . +) (|Union| 7 '#1="failed")
              |NODE1;solve;2FBoSU;1| (|Boolean|) (83 . |zero?|) (88 . |One|)
              (92 . /) (98 . |One|) (|List| 8) (102 . |variables|)
              (107 . |member?|) (113 . |expint|) (119 . -) (124 . |freeOf?|)
              (130 . |numer|) (|SparseUnivariatePolynomial| $)
              (135 . |univariate|) (|NonNegativeInteger|)
              (|SparseUnivariatePolynomial| 25) (141 . |degree|)
              (146 . |reductum|) (151 . ~=) (157 . |Zero|) (161 . ~=)
              (167 . |leadingCoefficient|) (|Integer|) (172 . *)
              (|Record| (|:| |particular| 7) (|:| |basis| 68))
              (|Union| 60 7 '"failed") (|ElementaryFunctionODESolver| 6 7)
              (178 . |solve|) (185 . ^) (191 . |Zero|) (195 . |Zero|)
              (199 . |coefficient|) (|List| 7) (205 . |elt|)
              (|PositiveInteger|) (211 . *) (217 . |inv|)
              (222 . |differentiate|))
           '#(|solve| 229) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|solve|
                                 ((|Union| |#2| #1#) |#2| |#2|
                                  (|BasicOperator|) (|Symbol|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 73
                                            '(0 8 0 9 1 11 0 8 12 1 7 0 8 14 2
                                              7 0 15 0 16 1 7 17 0 18 1 7 0 17
                                              19 3 7 0 0 20 21 22 1 7 23 0 24 2
                                              25 0 0 0 26 1 7 0 23 27 2 7 0 0 0
                                              28 2 29 7 7 8 30 2 7 0 0 8 31 2 7
                                              0 0 0 32 2 7 0 0 0 33 1 7 36 0 37
                                              0 7 0 38 2 7 0 0 0 39 0 6 0 40 1
                                              7 41 0 42 2 41 36 8 0 43 2 29 7 7
                                              8 44 1 7 0 0 45 2 7 36 0 0 46 1 7
                                              23 0 47 2 25 48 0 11 49 1 51 50 0
                                              52 1 51 0 0 53 2 50 36 0 0 54 0
                                              51 0 55 2 51 36 0 0 56 1 51 25 0
                                              57 2 7 0 58 0 59 3 62 61 7 15 8
                                              63 2 7 0 0 58 64 0 6 0 65 0 7 0
                                              66 2 51 25 0 50 67 2 68 7 0 58 69
                                              2 7 0 70 0 71 1 7 0 0 72 3 7 0 0
                                              8 50 73 4 0 34 7 7 15 8 35)))))
           '|lookupComplete|)) 
