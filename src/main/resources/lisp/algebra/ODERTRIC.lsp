
(SDEFUN |ODERTRIC;UP2SUP|
        ((|p| (UP)) ($ (|SparseUnivariatePolynomial| (|Polynomial| F))))
        (SPADCALL (ELT $ 12) |p| (QREFELT $ 16))) 

(SDEFUN |ODERTRIC;logDerOnly|
        ((|l| (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
         ($ (|List| (|Fraction| UP))))
        (SPROG ((#1=#:G730 NIL) (|s| NIL) (#2=#:G729 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |s| NIL)
                      (LETT #1#
                            (QCDR
                             (SPADCALL |l| (|spadConstant| $ 20)
                                       (QREFELT $ 25))))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL (SPADCALL |s| (QREFELT $ 26)) |s|
                                         (QREFELT $ 27))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |ODERTRIC;ricDsolve;LodoML;3|
        ((|l| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         (|zeros| (|Mapping| (|List| F) UP)) ($ (|List| (|Fraction| UP))))
        (SPADCALL |l| |zeros| (ELT $ 29) (QREFELT $ 34))) 

(SDEFUN |ODERTRIC;ricDsolve;LodoML;4|
        ((|l| (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
         (|zeros| (|Mapping| (|List| F) UP)) ($ (|List| (|Fraction| UP))))
        (SPADCALL |l| |zeros| (ELT $ 29) (QREFELT $ 36))) 

(SDEFUN |ODERTRIC;singRicDE;LodoML;5|
        ((|l| (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
         (|ezfactor| (|Mapping| (|Factored| UP) UP))
         ($
          (|List|
           (|Record| (|:| |frac| (|Fraction| UP))
                     (|:| |eq|
                          (|LinearOrdinaryDifferentialOperator2| UP
                                                                 (|Fraction|
                                                                  UP)))))))
        (SPADCALL |l| (CONS (|function| |ODERTRIC;solveModulo|) $) |ezfactor|
                  (QREFELT $ 42))) 

(SDEFUN |ODERTRIC;ricDsolve;LodoMML;6|
        ((|l| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         (|zeros| (|Mapping| (|List| F) UP))
         (|ezfactor| (|Mapping| (|Factored| UP) UP))
         ($ (|List| (|Fraction| UP))))
        (SPADCALL (QCAR (SPADCALL |l| NIL (QREFELT $ 46))) |zeros| |ezfactor|
                  (QREFELT $ 36))) 

(SDEFUN |ODERTRIC;mapeval|
        ((|p| (|SparseUnivariatePolynomial| (|Polynomial| F)))
         (|ls| (|List| (|Symbol|))) (|lv| (|List| F)) ($ (UP)))
        (SPROG NIL
               (SPADCALL (CONS #'|ODERTRIC;mapeval!0| (VECTOR $ |lv| |ls|)) |p|
                         (QREFELT $ 53)))) 

(SDEFUN |ODERTRIC;mapeval!0| ((|z| NIL) ($$ NIL))
        (PROG (|ls| |lv| $)
          (LETT |ls| (QREFELT $$ 2))
          (LETT |lv| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |z| |ls| |lv| (QREFELT $ 49))
                      (QREFELT $ 50)))))) 

(SDEFUN |ODERTRIC;FifCan|
        ((|f| (|Fraction| (|Polynomial| F))) ($ (|Union| F #1="failed")))
        (SPROG ((#2=#:G759 NIL) (|d| #3=(|Union| F "failed")) (|n| #3#))
               (SEQ
                (COND
                 ((QEQCAR
                   (LETT |n|
                         (SPADCALL (SPADCALL |f| (QREFELT $ 55))
                                   (QREFELT $ 57)))
                   0)
                  (COND
                   ((QEQCAR
                     (LETT |d|
                           (SPADCALL (SPADCALL |f| (QREFELT $ 58))
                                     (QREFELT $ 57)))
                     0)
                    (EXIT
                     (CONS 0
                           (SPADCALL
                            (PROG2 (LETT #2# |n|)
                                (QCDR #2#)
                              (|check_union2| (QEQCAR #2# 0) (QREFELT $ 6)
                                              (|Union| (QREFELT $ 6) #1#) #2#))
                            (PROG2 (LETT #2# |d|)
                                (QCDR #2#)
                              (|check_union2| (QEQCAR #2# 0) (QREFELT $ 6)
                                              (|Union| (QREFELT $ 6) #1#) #2#))
                            (QREFELT $ 59))))))))
                (EXIT (CONS 1 "failed"))))) 

(SDEFUN |ODERTRIC;genericPolynomial|
        ((|s| (|Symbol|)) (|n| (|Integer|))
         ($
          (|Record|
           (|:| |poly| (|SparseUnivariatePolynomial| (|Polynomial| F)))
           (|:| |vars| (|List| (|Symbol|))))))
        (SPROG
         ((|l| (|List| (|Symbol|)))
          (|ans| (|SparseUnivariatePolynomial| (|Polynomial| F)))
          (|sy| (|Symbol|)) (#1=#:G772 NIL) (|i| NIL))
         (SEQ (LETT |ans| (|spadConstant| $ 60)) (LETT |l| NIL)
              (SEQ (LETT |i| 0) (LETT #1# |n|) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (LETT |ans|
                          (SPADCALL |ans|
                                    (SPADCALL
                                     (SPADCALL
                                      (LETT |sy| (SPADCALL |s| (QREFELT $ 61)))
                                      (QREFELT $ 62))
                                     |i| (QREFELT $ 64))
                                    (QREFELT $ 65)))
                    (EXIT (LETT |l| (CONS |sy| |l|))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |ans| (NREVERSE |l|)))))) 

(SDEFUN |ODERTRIC;ratsln|
        ((|l| (|List| (|Equation| (|Fraction| (|Polynomial| F)))))
         ($
          (|Union|
           (|Record| (|:| |var| (|List| (|Symbol|))) (|:| |val| (|List| F)))
           "failed")))
        (SPROG
         ((|ls| (|List| (|Symbol|))) (|lv| (|List| F)) (#1=#:G790 NIL)
          (#2=#:G791 NIL) (|v| (|Union| (|Symbol|) "failed"))
          (|u| (|Union| F "failed")) (#3=#:G792 NIL) (|eq| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |ls| NIL) (LETT |lv| NIL)
                (SEQ (LETT |eq| NIL) (LETT #3# |l|) G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |eq| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ
                        (SEQ
                         (LETT |u|
                               (|ODERTRIC;FifCan|
                                (SPADCALL |eq| (QREFELT $ 67)) $))
                         (EXIT
                          (COND
                           ((QEQCAR |u| 1)
                            (PROGN
                             (LETT #1#
                                   (PROGN
                                    (LETT #2# (CONS 1 #4="failed"))
                                    (GO #5=#:G789)))
                             (GO #6=#:G786)))
                           ('T
                            (SEQ
                             (LETT |v|
                                   (SPADCALL (SPADCALL |eq| (QREFELT $ 68))
                                             (QREFELT $ 70)))
                             (EXIT
                              (COND
                               ((QEQCAR |v| 1)
                                (PROGN
                                 (LETT #1#
                                       (PROGN
                                        (LETT #2# (CONS 1 #4#))
                                        (GO #5#)))
                                 (GO #6#))))))))))
                        (LETT |lv| (CONS (QCDR |u|) |lv|))
                        (EXIT (LETT |ls| (CONS (QCDR |v|) |ls|)))))
                      #6# (EXIT #1#))
                     (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 (CONS |ls| |lv|)))))
          #5# (EXIT #2#)))) 

(SDEFUN |ODERTRIC;ratsol|
        ((|l| (|List| (|List| (|Equation| (|Fraction| (|Polynomial| F))))))
         ($
          (|List|
           (|Record| (|:| |var| (|List| (|Symbol|))) (|:| |val| (|List| F))))))
        (SPROG
         ((|ans|
           (|List|
            (|Record| (|:| |var| (|List| (|Symbol|))) (|:| |val| (|List| F)))))
          (|u|
           (|Union|
            (|Record| (|:| |var| (|List| (|Symbol|))) (|:| |val| (|List| F)))
            "failed"))
          (#1=#:G802 NIL) (|sol| NIL))
         (SEQ (LETT |ans| NIL)
              (SEQ (LETT |sol| NIL) (LETT #1# |l|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |sol| (CAR #1#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |u| (|ODERTRIC;ratsln| |sol| $))
                        (EXIT
                         (COND
                          ((QEQCAR |u| 0)
                           (LETT |ans| (CONS (QCDR |u|) |ans|))))))
                   (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |ODERTRIC;polyRicDE;LodoML;12|
        ((|l| (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
         (|zeros| (|Mapping| (|List| F) UP))
         ($
          (|List|
           #1=(|Record| (|:| |poly| UP)
                        (|:| |eq|
                             (|LinearOrdinaryDifferentialOperator2| UP
                                                                    (|Fraction|
                                                                     UP)))))))
        (SPROG
         ((|ans| (|List| #1#)) (|p| (UP)) (#2=#:G829 NIL) (|a| NIL)
          (#3=#:G828 NIL) (|rec| NIL)
          (|lc|
           (|List|
            (|Record| (|:| |deg| (|NonNegativeInteger|)) (|:| |eq| UP)))))
         (SEQ (LETT |ans| (LIST (CONS (|spadConstant| $ 18) |l|)))
              (EXIT
               (COND ((NULL (LETT |lc| (SPADCALL |l| (QREFELT $ 73)))) |ans|)
                     ('T
                      (SEQ
                       (SEQ (LETT |rec| NIL) (LETT #3# (REVERSE |lc|)) G190
                            (COND
                             ((OR (ATOM #3#)
                                  (PROGN (LETT |rec| (CAR #3#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (SEQ (LETT |a| NIL)
                                   (LETT #2# (SPADCALL (QCDR |rec|) |zeros|))
                                   G190
                                   (COND
                                    ((OR (ATOM #2#)
                                         (PROGN (LETT |a| (CAR #2#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (COND
                                      ((SPADCALL |a| (|spadConstant| $ 17)
                                                 (QREFELT $ 75))
                                       (COND
                                        ((SPADCALL
                                          (LETT |p|
                                                (|ODERTRIC;newtonSolution| |l|
                                                 |a| (QCAR |rec|) |zeros| $))
                                          (|spadConstant| $ 18) (QREFELT $ 76))
                                         (LETT |ans|
                                               (CONS
                                                (CONS |p|
                                                      (SPADCALL |l| |p|
                                                                (QREFELT $
                                                                         77)))
                                                |ans|))))))))
                                   (LETT #2# (CDR #2#)) (GO G190) G191
                                   (EXIT NIL))))
                            (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                       (EXIT |ans|)))))))) 

(SDEFUN |ODERTRIC;reverseUP|
        ((|p| (UP)) ($ (|UnivariateTaylorSeries| F |dummy| (|Zero|))))
        (SPROG
         ((|ans| (|UnivariateTaylorSeries| F |dummy| (|Zero|))) (#1=#:G832 NIL)
          (|n| (|Integer|)))
         (SEQ (LETT |ans| (|spadConstant| $ 82))
              (LETT |n| (SPADCALL |p| (QREFELT $ 83)))
              (SEQ G190
                   (COND
                    ((NULL (SPADCALL |p| (|spadConstant| $ 18) (QREFELT $ 76)))
                     (GO G191)))
                   (SEQ
                    (LETT |ans|
                          (SPADCALL |ans|
                                    (SPADCALL (SPADCALL |p| (QREFELT $ 84))
                                              (PROG1
                                                  (LETT #1#
                                                        (- |n|
                                                           (SPADCALL |p|
                                                                     (QREFELT $
                                                                              83))))
                                                (|check_subtype2| (>= #1# 0)
                                                                  '(|NonNegativeInteger|)
                                                                  '(|Integer|)
                                                                  #1#))
                                              (QREFELT $ 85))
                                    (QREFELT $ 86)))
                    (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 87)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |ans|)))) 

(SDEFUN |ODERTRIC;reverseUTS|
        ((|s| (|UnivariateTaylorSeries| F |dummy| (|Zero|)))
         (|n| (|NonNegativeInteger|)) ($ (UP)))
        (SPROG
         ((#1=#:G838 NIL) (#2=#:G837 (UP)) (#3=#:G839 (UP)) (#4=#:G840 NIL)
          (#5=#:G842 NIL) (|i| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |i| 0) (LETT #5# |n|) G190
                (COND ((|greater_SI| |i| #5#) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #3#
                         (SPADCALL (SPADCALL |s| |i| (QREFELT $ 88))
                                   (PROG1 (LETT #4# (- |n| |i|))
                                     (|check_subtype2| (>= #4# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #4#))
                                   (QREFELT $ 89)))
                   (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 90))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 18))))))) 

(SDEFUN |ODERTRIC;newtonSolution|
        ((|l| #1=(|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
         (|a| (F)) (|n| (|NonNegativeInteger|))
         (|zeros| (|Mapping| (|List| F) UP)) ($ (UP)))
        (SPROG
         ((|sols| (|List| UP)) (#2=#:G869 NIL) (|sol| NIL) (#3=#:G868 NIL)
          (|neq| (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
          (|atn| (UP))
          (|u|
           (|Union| (|UnivariateTaylorSeries| F |dummy| (|Zero|)) "failed"))
          (|aeq|
           (|SparseUnivariatePolynomial|
            (|UnivariateTaylorSeries| F |dummy| (|Zero|))))
          (|s| (|UnivariateTaylorSeries| F |dummy| (|Zero|))) (#4=#:G855 NIL)
          (|d| (|NonNegativeInteger|)) (|c| (UP)) (|m| (|Integer|)) (|op| #1#)
          (|mu| (|NonNegativeInteger|)))
         (SEQ (LETT |m| 0) (LETT |aeq| (|spadConstant| $ 92)) (LETT |op| |l|)
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL |op| (|spadConstant| $ 93) (QREFELT $ 94)))
                     (GO G191)))
                   (SEQ
                    (LETT |mu|
                          (+ (* (SPADCALL |op| (QREFELT $ 95)) |n|)
                             (SPADCALL (SPADCALL |op| (QREFELT $ 96))
                                       (QREFELT $ 83))))
                    (LETT |op| (SPADCALL |op| (QREFELT $ 97)))
                    (EXIT (COND ((> |mu| |m|) (LETT |m| |mu|)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (SEQ G190
                   (COND
                    ((NULL (SPADCALL |l| (|spadConstant| $ 93) (QREFELT $ 94)))
                     (GO G191)))
                   (SEQ (LETT |c| (SPADCALL |l| (QREFELT $ 96)))
                        (LETT |d| (SPADCALL |l| (QREFELT $ 95)))
                        (LETT |s|
                              (SPADCALL
                               (SPADCALL (|spadConstant| $ 98)
                                         (PROG1
                                             (LETT #4#
                                                   (- (- |m| (* |d| |n|))
                                                      (SPADCALL |c|
                                                                (QREFELT $
                                                                         83))))
                                           (|check_subtype2| (>= #4# 0)
                                                             '(|NonNegativeInteger|)
                                                             '(|Integer|) #4#))
                                         (QREFELT $ 85))
                               (|ODERTRIC;reverseUP| |c| $) (QREFELT $ 100)))
                        (LETT |aeq|
                              (SPADCALL |aeq|
                                        (SPADCALL |s| |d| (QREFELT $ 101))
                                        (QREFELT $ 102)))
                        (EXIT (LETT |l| (SPADCALL |l| (QREFELT $ 97)))))
                   NIL (GO G190) G191 (EXIT NIL))
              (LETT |u| (|ODERTRIC;newtonSolve| |aeq| |a| |n| $))
              (EXIT
               (COND ((QEQCAR |u| 0) (|ODERTRIC;reverseUTS| (QCDR |u|) |n| $))
                     (#5='T
                      (SEQ (LETT |atn| (SPADCALL |a| |n| (QREFELT $ 89)))
                           (LETT |neq| (SPADCALL |l| |atn| (QREFELT $ 77)))
                           (LETT |sols|
                                 (PROGN
                                  (LETT #3# NIL)
                                  (SEQ (LETT |sol| NIL)
                                       (LETT #2#
                                             (SPADCALL |neq| |zeros|
                                                       (QREFELT $ 80)))
                                       G190
                                       (COND
                                        ((OR (ATOM #2#)
                                             (PROGN
                                              (LETT |sol| (CAR #2#))
                                              NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (COND
                                          ((<
                                            (SPADCALL (QCAR |sol|)
                                                      (QREFELT $ 83))
                                            |n|)
                                           (LETT #3#
                                                 (CONS (QCAR |sol|) #3#))))))
                                       (LETT #2# (CDR #2#)) (GO G190) G191
                                       (EXIT (NREVERSE #3#)))))
                           (EXIT
                            (COND ((NULL |sols|) |atn|)
                                  (#5#
                                   (SPADCALL |atn| (|SPADfirst| |sols|)
                                             (QREFELT $ 90)))))))))))) 

(SDEFUN |ODERTRIC;newtonSolve|
        ((|eq|
          (|SparseUnivariatePolynomial|
           (|UnivariateTaylorSeries| F |dummy| (|Zero|))))
         (|a| (F)) (|n| (|NonNegativeInteger|))
         ($ (|Union| (|UnivariateTaylorSeries| F |dummy| (|Zero|)) "failed")))
        (SPROG
         ((|sol| (|UnivariateTaylorSeries| F |dummy| (|Zero|))) (#1=#:G878 NIL)
          (|xquo|
           (|Union| (|UnivariateTaylorSeries| F |dummy| (|Zero|)) "failed"))
          (#2=#:G879 NIL) (|i| NIL)
          (|deq|
           (|SparseUnivariatePolynomial|
            (|UnivariateTaylorSeries| F |dummy| (|Zero|)))))
         (SEQ
          (EXIT
           (SEQ (LETT |deq| (SPADCALL |eq| (QREFELT $ 103)))
                (LETT |sol| (SPADCALL |a| (QREFELT $ 104)))
                (SEQ (LETT |i| 1) (LETT #2# |n|) G190
                     (COND ((|greater_SI| |i| #2#) (GO G191)))
                     (SEQ
                      (LETT |xquo|
                            (SPADCALL (SPADCALL |eq| |sol| (QREFELT $ 105))
                                      (SPADCALL |deq| |sol| (QREFELT $ 105))
                                      (QREFELT $ 107)))
                      (EXIT
                       (COND
                        ((QEQCAR |xquo| 1)
                         (PROGN (LETT #1# (CONS 1 "failed")) (GO #3=#:G877)))
                        ('T
                         (LETT |sol|
                               (SPADCALL
                                (SPADCALL |sol| (QCDR |xquo|) (QREFELT $ 108))
                                |i| (QREFELT $ 109)))))))
                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 |sol|))))
          #3# (EXIT #1#)))) 

(SDEFUN |ODERTRIC;ricDsolve;LodoMML;17|
        ((|l| (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
         (|zeros| (|Mapping| (|List| F) UP))
         (|ezfactor| (|Mapping| (|Factored| UP) UP))
         ($ (|List| (|Fraction| UP))))
        (SPROG
         ((#1=#:G892 NIL) (#2=#:G893 NIL) (|ans| (|List| (|Fraction| UP)))
          (#3=#:G896 NIL) (|f| NIL) (#4=#:G895 NIL) (#5=#:G894 NIL) (|rec| NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |n| (SPADCALL |l| (QREFELT $ 95))) (LETT |ans| NIL)
                (SEQ (LETT |rec| NIL)
                     (LETT #5# (SPADCALL |l| |ezfactor| (QREFELT $ 43))) G190
                     (COND
                      ((OR (ATOM #5#) (PROGN (LETT |rec| (CAR #5#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ
                        (LETT |ans|
                              (SPADCALL
                               (SPADCALL |ans|
                                         (PROGN
                                          (LETT #4# NIL)
                                          (SEQ (LETT |f| NIL)
                                               (LETT #3#
                                                     (|ODERTRIC;nonSingSolve|
                                                      |n| (QCDR |rec|) |zeros|
                                                      $))
                                               G190
                                               (COND
                                                ((OR (ATOM #3#)
                                                     (PROGN
                                                      (LETT |f| (CAR #3#))
                                                      NIL))
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (LETT #4#
                                                       (CONS
                                                        (SPADCALL (QCAR |rec|)
                                                                  |f|
                                                                  (QREFELT $
                                                                           110))
                                                        #4#))))
                                               (LETT #3# (CDR #3#)) (GO G190)
                                               G191 (EXIT (NREVERSE #4#))))
                                         (QREFELT $ 111))
                               (QREFELT $ 112)))
                        (EXIT
                         (COND
                          ((EQL (LENGTH |ans|) |n|)
                           (PROGN
                            (LETT #1# (PROGN (LETT #2# |ans|) (GO #6=#:G891)))
                            (GO #7=#:G888)))))))
                      #7# (EXIT #1#))
                     (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                (EXIT |ans|)))
          #6# (EXIT #2#)))) 

(SDEFUN |ODERTRIC;nonSingSolve|
        ((|n| (|NonNegativeInteger|))
         (|l| (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
         (|zeros| (|Mapping| (|List| F) UP)) ($ (|List| (|Fraction| UP))))
        (SPROG
         ((#1=#:G908 NIL) (#2=#:G909 NIL) (|ans| (|List| (|Fraction| UP)))
          (#3=#:G910 NIL) (|rec| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |ans| NIL)
                (SEQ (LETT |rec| NIL)
                     (LETT #3# (SPADCALL |l| |zeros| (QREFELT $ 80))) G190
                     (COND
                      ((OR (ATOM #3#) (PROGN (LETT |rec| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ
                        (LETT |ans|
                              (SPADCALL
                               (SPADCALL |ans|
                                         (|ODERTRIC;nopoly| |n| (QCAR |rec|)
                                          (QCDR |rec|) |zeros| $)
                                         (QREFELT $ 111))
                               (QREFELT $ 112)))
                        (EXIT
                         (COND
                          ((EQL (LENGTH |ans|) |n|)
                           (PROGN
                            (LETT #1# (PROGN (LETT #2# |ans|) (GO #4=#:G907)))
                            (GO #5=#:G904)))))))
                      #5# (EXIT #1#))
                     (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                (EXIT |ans|)))
          #4# (EXIT #2#)))) 

(SDEFUN |ODERTRIC;constantRic|
        ((|p| (UP)) (|zeros| (|Mapping| (|List| F) UP)) ($ (|List| F)))
        (COND ((ZEROP (SPADCALL |p| (QREFELT $ 83))) NIL)
              ('T (SPADCALL (SPADCALL |p| (QREFELT $ 113)) |zeros|)))) 

(SDEFUN |ODERTRIC;nopoly|
        ((|n| (|NonNegativeInteger|)) (|p| (UP))
         (|l| (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
         (|zeros| (|Mapping| (|List| F) UP)) ($ (|List| (|Fraction| UP))))
        (SPROG
         ((#1=#:G924 NIL) (#2=#:G925 NIL) (|ans| (|List| (|Fraction| UP)))
          (#3=#:G928 NIL) (|f| NIL) (#4=#:G927 NIL) (#5=#:G926 NIL)
          (|rec| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |ans| NIL)
                (SEQ (LETT |rec| NIL)
                     (LETT #5#
                           (SPADCALL |l|
                                     (CONS #'|ODERTRIC;nopoly!0|
                                           (VECTOR $ |zeros|))
                                     (QREFELT $ 116)))
                     G190
                     (COND
                      ((OR (ATOM #5#) (PROGN (LETT |rec| (CAR #5#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (SEQ
                        (LETT |ans|
                              (SPADCALL
                               (SPADCALL |ans|
                                         (PROGN
                                          (LETT #4# NIL)
                                          (SEQ (LETT |f| NIL)
                                               (LETT #3#
                                                     (|ODERTRIC;logDerOnly|
                                                      (QCDR |rec|) $))
                                               G190
                                               (COND
                                                ((OR (ATOM #3#)
                                                     (PROGN
                                                      (LETT |f| (CAR #3#))
                                                      NIL))
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (LETT #4#
                                                       (CONS
                                                        (SPADCALL
                                                         (SPADCALL
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (QCAR |rec|)
                                                            (QREFELT $ 117))
                                                           |p| (QREFELT $ 90))
                                                          (QREFELT $ 118))
                                                         |f| (QREFELT $ 110))
                                                        #4#))))
                                               (LETT #3# (CDR #3#)) (GO G190)
                                               G191 (EXIT (NREVERSE #4#))))
                                         (QREFELT $ 111))
                               (QREFELT $ 112)))
                        (EXIT
                         (COND
                          ((EQL (LENGTH |ans|) |n|)
                           (PROGN
                            (LETT #1# (PROGN (LETT #2# |ans|) (GO #6=#:G923)))
                            (GO #7=#:G920)))))))
                      #7# (EXIT #1#))
                     (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                (EXIT |ans|)))
          #6# (EXIT #2#)))) 

(SDEFUN |ODERTRIC;nopoly!0| ((|z| NIL) ($$ NIL))
        (PROG (|zeros| $)
          (LETT |zeros| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|ODERTRIC;constantRic| |z| |zeros| $))))) 

(SDEFUN |ODERTRIC;solveModulo|
        ((|c| (UP)) (|h| (|SparseUnivariatePolynomial| UP)) ($ (|List| UP)))
        (SPROG
         ((#1=#:G941 NIL) (|s| NIL) (#2=#:G940 NIL)
          (|sol|
           (|List|
            (|Record| (|:| |var| (|List| (|Symbol|))) (|:| |val| (|List| F)))))
          (|unk| (|SparseUnivariatePolynomial| (|Polynomial| F)))
          (|rec|
           (|Record|
            (|:| |poly| (|SparseUnivariatePolynomial| (|Polynomial| F)))
            (|:| |vars| (|List| (|Symbol|))))))
         (SEQ
          (LETT |rec|
                (|ODERTRIC;genericPolynomial| (QREFELT $ 10)
                 (- (SPADCALL |c| (QREFELT $ 83)) 1) $))
          (LETT |unk| (|spadConstant| $ 60))
          (SEQ G190
               (COND ((NULL (NULL (SPADCALL |h| (QREFELT $ 120)))) (GO G191)))
               (SEQ
                (LETT |unk|
                      (SPADCALL |unk|
                                (SPADCALL
                                 (|ODERTRIC;UP2SUP|
                                  (SPADCALL |h| (QREFELT $ 121)) $)
                                 (SPADCALL (QCAR |rec|)
                                           (SPADCALL |h| (QREFELT $ 122))
                                           (QREFELT $ 123))
                                 (QREFELT $ 124))
                                (QREFELT $ 65)))
                (EXIT (LETT |h| (SPADCALL |h| (QREFELT $ 125)))))
               NIL (GO G190) G191 (EXIT NIL))
          (LETT |sol|
                (|ODERTRIC;ratsol|
                 (SPADCALL
                  (SPADCALL
                   (QCDR
                    (SPADCALL |unk| (|ODERTRIC;UP2SUP| |c| $) (QREFELT $ 127)))
                   (QREFELT $ 129))
                  (QCDR |rec|) (QREFELT $ 132))
                 $))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |s| NIL) (LETT #1# |sol|) G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |s| (CAR #1#)) NIL)) (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #2#
                         (CONS
                          (|ODERTRIC;mapeval| (QCAR |rec|) (QCAR |s|)
                           (QCDR |s|) $)
                          #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |ODERTRIC;ricDsolve;LodoL;22|
        ((|l| (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
         ($ (|List| (|Fraction| UP))))
        (SPADCALL |l| (ELT $ 29) (QREFELT $ 133))) 

(SDEFUN |ODERTRIC;ricDsolve;LodoL;23|
        ((|l| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         ($ (|List| (|Fraction| UP))))
        (SPADCALL |l| (ELT $ 29) (QREFELT $ 135))) 

(SDEFUN |ODERTRIC;ricDsolve;LodoML;24|
        ((|l| (|LinearOrdinaryDifferentialOperator2| UP (|Fraction| UP)))
         (|ezfactor| (|Mapping| (|Factored| UP) UP))
         ($ (|List| (|Fraction| UP))))
        (SPROG NIL
               (SPADCALL |l|
                         (CONS #'|ODERTRIC;ricDsolve;LodoML;24!0|
                               (VECTOR $ |ezfactor|))
                         |ezfactor| (QREFELT $ 36)))) 

(SDEFUN |ODERTRIC;ricDsolve;LodoML;24!0| ((|z| NIL) ($$ NIL))
        (PROG (|ezfactor| $)
          (LETT |ezfactor| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|ODERTRIC;zro| |z| |ezfactor| $))))) 

(SDEFUN |ODERTRIC;ricDsolve;LodoML;25|
        ((|l| (|LinearOrdinaryDifferentialOperator1| (|Fraction| UP)))
         (|ezfactor| (|Mapping| (|Factored| UP) UP))
         ($ (|List| (|Fraction| UP))))
        (SPROG NIL
               (SPADCALL |l|
                         (CONS #'|ODERTRIC;ricDsolve;LodoML;25!0|
                               (VECTOR $ |ezfactor|))
                         |ezfactor| (QREFELT $ 34)))) 

(SDEFUN |ODERTRIC;ricDsolve;LodoML;25!0| ((|z| NIL) ($$ NIL))
        (PROG (|ezfactor| $)
          (LETT |ezfactor| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|ODERTRIC;zro| |z| |ezfactor| $))))) 

(SDEFUN |ODERTRIC;zro|
        ((|p| (UP)) (|ezfactor| (|Mapping| (|Factored| UP) UP)) ($ (|List| F)))
        (SPROG ((#1=#:G967 NIL) (|r| NIL) (#2=#:G966 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |r| NIL)
                       (LETT #1#
                             (SPADCALL (SPADCALL |p| |ezfactor|)
                                       (QREFELT $ 141)))
                       G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |r| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS (|ODERTRIC;zro1| (QVELT |r| 1) $) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 143))))) 

(SDEFUN |ODERTRIC;zro1| ((|p| (UP)) ($ (|List| F)))
        (LIST
         (SPADCALL (SPADCALL (LIST #'|ODERTRIC;zro1!0|) |p| (QREFELT $ 147))
                   (QREFELT $ 149)))) 

(SDEFUN |ODERTRIC;zro1!0| ((|z| NIL) ($$ NIL)) |z|) 

(DECLAIM (NOTINLINE |RationalRicDE;|)) 

(DEFUN |RationalRicDE| (&REST #1=#:G971)
  (SPROG NIL
         (PROG (#2=#:G972)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|RationalRicDE|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |RationalRicDE;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|RationalRicDE|)))))))))) 

(DEFUN |RationalRicDE;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|RationalRicDE| DV$1 DV$2))
          (LETT $ (GETREFV 150))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|AlgebraicallyClosedField|))))))
          (|haddProp| |$ConstructorCache| '|RationalRicDE| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 10 (SPADCALL (QREFELT $ 9)))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 134
                       (CONS (|dispatchFunction| |ODERTRIC;ricDsolve;LodoL;22|)
                             $))
             (QSETREFV $ 136
                       (CONS (|dispatchFunction| |ODERTRIC;ricDsolve;LodoL;23|)
                             $))
             (QSETREFV $ 133
                       (CONS
                        (|dispatchFunction| |ODERTRIC;ricDsolve;LodoML;24|) $))
             (QSETREFV $ 135
                       (CONS
                        (|dispatchFunction| |ODERTRIC;ricDsolve;LodoML;25|)
                        $)))))
          $))) 

(MAKEPROP '|RationalRicDE| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) (|Symbol|)
              (0 . |new|) '|dummy| (|Polynomial| 6) (4 . |coerce|)
              (|SparseUnivariatePolynomial| 11) (|Mapping| 11 6)
              (|UnivariatePolynomialCategoryFunctions2| 6 7 11 13) (9 . |map|)
              (15 . |Zero|) (19 . |Zero|) (|Fraction| 7) (23 . |Zero|)
              (|Union| 19 '"failed")
              (|Record| (|:| |particular| 21) (|:| |basis| 30))
              (|LinearOrdinaryDifferentialOperator2| 7 19) (|RationalLODE| 6 7)
              (27 . |ratDsolve|) (33 . |differentiate|) (38 . /) (|Factored| $)
              (44 . |squareFree|) (|List| 19)
              (|LinearOrdinaryDifferentialOperator1| 19) (|Mapping| 48 7)
              (|Mapping| 140 7) |ODERTRIC;ricDsolve;LodoMML;6|
              |ODERTRIC;ricDsolve;LodoML;3| |ODERTRIC;ricDsolve;LodoMML;17|
              |ODERTRIC;ricDsolve;LodoML;4|
              (|Record| (|:| |frac| 19) (|:| |eq| 23)) (|List| 38)
              (|Mapping| (|List| 7) 7 119) (|PrimitiveRatRicDE| 6 7 23 31)
              (49 . |singRicDE|) |ODERTRIC;singRicDE;LodoML;5|
              (|Record| (|:| |eq| 23) (|:| |rh| 30))
              (|PrimitiveRatDE| 6 7 23 31) (56 . |splitDenominator|) (|List| 8)
              (|List| 6) (62 . |eval|) (69 . |ground|) (|Mapping| 6 11)
              (|UnivariatePolynomialCategoryFunctions2| 11 13 6 7) (74 . |map|)
              (|Fraction| 11) (80 . |numer|) (|Union| 6 '"failed")
              (85 . |retractIfCan|) (90 . |denom|) (95 . /) (101 . |Zero|)
              (105 . |new|) (110 . |coerce|) (|NonNegativeInteger|)
              (115 . |monomial|) (121 . +) (|Equation| 54) (127 . |rhs|)
              (132 . |lhs|) (|Union| 8 '"failed") (137 . |retractIfCan|)
              (|Record| (|:| |deg| 63) (|:| |eq| 7)) (|List| 71)
              (142 . |leadingCoefficientRicDE|) (|Boolean|) (147 . ~=)
              (153 . ~=) (159 . |changeVar|)
              (|Record| (|:| |poly| 7) (|:| |eq| 23)) (|List| 78)
              |ODERTRIC;polyRicDE;LodoML;12|
              (|UnivariateTaylorSeries| 6 (NRTEVAL (QREFELT $ 10))
                                        (NRTEVAL (|spadConstant| $ 17)))
              (165 . |Zero|) (169 . |degree|) (174 . |leadingCoefficient|)
              (179 . |monomial|) (185 . +) (191 . |reductum|)
              (196 . |coefficient|) (202 . |monomial|) (208 . +)
              (|SparseUnivariatePolynomial| 81) (214 . |Zero|) (218 . |Zero|)
              (222 . ~=) (228 . |degree|) (233 . |leadingCoefficient|)
              (238 . |reductum|) (243 . |One|) (247 . |One|) (251 . *)
              (257 . |monomial|) (263 . +) (269 . |differentiate|)
              (274 . |coerce|) (279 . |elt|) (|Union| $ '"failed")
              (285 . |exquo|) (291 . -) (297 . |truncate|) (303 . +)
              (309 . |concat!|) (315 . |removeDuplicates!|)
              (320 . |squareFreePart|)
              (|Record| (|:| |constant| 6) (|:| |eq| 23)) (|List| 114)
              (325 . |constantCoefficientRicDE|) (331 . |coerce|)
              (336 . |coerce|) (|SparseUnivariatePolynomial| 7) (341 . |zero?|)
              (346 . |leadingCoefficient|) (351 . |degree|) (356 . ^) (362 . *)
              (368 . |reductum|)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (373 . |monicDivide|) (|List| 11) (379 . |coefficients|)
              (|List| (|List| 66)) (|NonLinearSolvePackage| 6) (384 . |solve|)
              (390 . |ricDsolve|) (396 . |ricDsolve|) (401 . |ricDsolve|)
              (407 . |ricDsolve|) (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 137) (|:| |factor| 7) (|:| |exponent| 63))
              (|List| 138) (|Factored| 7) (412 . |factorList|) (|List| $)
              (417 . |concat|) (|SparseUnivariatePolynomial| 6) (|Mapping| 6 6)
              (|UnivariatePolynomialCategoryFunctions2| 6 7 6 144)
              (422 . |map|) (|SparseUnivariatePolynomial| $) (428 . |zeroOf|))
           '#(|singRicDE| 433 |ricDsolve| 439 |polyRicDE| 487) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|ricDsolve|
                                 ((|List| (|Fraction| |#2|))
                                  (|LinearOrdinaryDifferentialOperator1|
                                   (|Fraction| |#2|))
                                  (|Mapping| (|List| |#1|) |#2|)))
                                T)
                              '((|ricDsolve|
                                 ((|List| (|Fraction| |#2|))
                                  (|LinearOrdinaryDifferentialOperator1|
                                   (|Fraction| |#2|))
                                  (|Mapping| (|List| |#1|) |#2|)
                                  (|Mapping| (|Factored| |#2|) |#2|)))
                                T)
                              '((|ricDsolve|
                                 ((|List| (|Fraction| |#2|))
                                  (|LinearOrdinaryDifferentialOperator2| |#2|
                                                                         (|Fraction|
                                                                          |#2|))
                                  (|Mapping| (|List| |#1|) |#2|)))
                                T)
                              '((|ricDsolve|
                                 ((|List| (|Fraction| |#2|))
                                  (|LinearOrdinaryDifferentialOperator2| |#2|
                                                                         (|Fraction|
                                                                          |#2|))
                                  (|Mapping| (|List| |#1|) |#2|)
                                  (|Mapping| (|Factored| |#2|) |#2|)))
                                T)
                              '((|singRicDE|
                                 ((|List|
                                   (|Record| (|:| |frac| (|Fraction| |#2|))
                                             (|:| |eq|
                                                  (|LinearOrdinaryDifferentialOperator2|
                                                   |#2| (|Fraction| |#2|)))))
                                  (|LinearOrdinaryDifferentialOperator2| |#2|
                                                                         (|Fraction|
                                                                          |#2|))
                                  (|Mapping| (|Factored| |#2|) |#2|)))
                                T)
                              '((|polyRicDE|
                                 ((|List|
                                   (|Record| (|:| |poly| |#2|)
                                             (|:| |eq|
                                                  (|LinearOrdinaryDifferentialOperator2|
                                                   |#2| (|Fraction| |#2|)))))
                                  (|LinearOrdinaryDifferentialOperator2| |#2|
                                                                         (|Fraction|
                                                                          |#2|))
                                  (|Mapping| (|List| |#1|) |#2|)))
                                T)
                              '((|ricDsolve|
                                 ((|List| (|Fraction| |#2|))
                                  (|LinearOrdinaryDifferentialOperator1|
                                   (|Fraction| |#2|))))
                                (|has| 6 (|AlgebraicallyClosedField|)))
                              '((|ricDsolve|
                                 ((|List| (|Fraction| |#2|))
                                  (|LinearOrdinaryDifferentialOperator1|
                                   (|Fraction| |#2|))
                                  (|Mapping| (|Factored| |#2|) |#2|)))
                                (|has| 6 (|AlgebraicallyClosedField|)))
                              '((|ricDsolve|
                                 ((|List| (|Fraction| |#2|))
                                  (|LinearOrdinaryDifferentialOperator2| |#2|
                                                                         (|Fraction|
                                                                          |#2|))))
                                (|has| 6 (|AlgebraicallyClosedField|)))
                              '((|ricDsolve|
                                 ((|List| (|Fraction| |#2|))
                                  (|LinearOrdinaryDifferentialOperator2| |#2|
                                                                         (|Fraction|
                                                                          |#2|))
                                  (|Mapping| (|Factored| |#2|) |#2|)))
                                (|has| 6 (|AlgebraicallyClosedField|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 149
                                            '(0 8 0 9 1 11 0 6 12 2 15 13 14 7
                                              16 0 6 0 17 0 7 0 18 0 19 0 20 2
                                              24 22 23 19 25 1 19 0 0 26 2 19 0
                                              0 0 27 1 7 28 0 29 3 41 39 23 40
                                              33 42 2 45 44 31 30 46 3 11 0 0
                                              47 48 49 1 11 6 0 50 2 52 7 51 13
                                              53 1 54 11 0 55 1 11 56 0 57 1 54
                                              11 0 58 2 6 0 0 0 59 0 13 0 60 1
                                              8 0 0 61 1 11 0 8 62 2 13 0 11 63
                                              64 2 13 0 0 0 65 1 66 54 0 67 1
                                              66 54 0 68 1 54 69 0 70 1 41 72
                                              23 73 2 6 74 0 0 75 2 7 74 0 0 76
                                              2 41 23 23 7 77 0 81 0 82 1 7 63
                                              0 83 1 7 6 0 84 2 81 0 6 63 85 2
                                              81 0 0 0 86 1 7 0 0 87 2 81 6 0
                                              63 88 2 7 0 6 63 89 2 7 0 0 0 90
                                              0 91 0 92 0 23 0 93 2 23 74 0 0
                                              94 1 23 63 0 95 1 23 7 0 96 1 23
                                              0 0 97 0 6 0 98 0 7 0 99 2 81 0 0
                                              0 100 2 91 0 81 63 101 2 91 0 0 0
                                              102 1 91 0 0 103 1 81 0 6 104 2
                                              91 81 0 81 105 2 81 106 0 0 107 2
                                              81 0 0 0 108 2 81 0 0 63 109 2 19
                                              0 0 0 110 2 30 0 0 0 111 1 30 0 0
                                              112 1 7 0 0 113 2 41 115 23 32
                                              116 1 7 0 6 117 1 19 0 7 118 1
                                              119 74 0 120 1 119 7 0 121 1 119
                                              63 0 122 2 13 0 0 63 123 2 13 0 0
                                              0 124 1 119 0 0 125 2 13 126 0 0
                                              127 1 13 128 0 129 2 131 130 128
                                              47 132 2 0 30 23 33 133 1 0 30 23
                                              134 2 0 30 31 33 135 1 0 30 31
                                              136 1 140 139 0 141 1 48 0 142
                                              143 2 146 144 145 7 147 1 6 0 148
                                              149 2 0 39 23 33 43 1 1 30 31 136
                                              2 1 30 31 33 135 2 1 30 23 33 133
                                              1 1 30 23 134 3 0 30 31 32 33 34
                                              2 0 30 31 32 35 2 0 30 23 32 37 3
                                              0 30 23 32 33 36 2 0 79 23 32
                                              80)))))
           '|lookupComplete|)) 
