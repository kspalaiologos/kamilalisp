
(SDEFUN |AF;belong?;BoB;1| ((|op| (|BasicOperator|)) ($ (|Boolean|)))
        (COND ((SPADCALL |op| (QREFELT $ 8) (QREFELT $ 17)) 'T)
              ('T (SPADCALL |op| '|%root_sum| (QREFELT $ 18))))) 

(SDEFUN |AF;dalg| ((|l| (|List| F)) ($ (|OutputForm|)))
        (SPADCALL (SPADCALL |l| (QREFELT $ 21)) (QREFELT $ 23))) 

(SDEFUN |AF;rootOf;SupSF;3|
        ((|p| (|SparseUnivariatePolynomial| F)) (|x| (|Symbol|)) ($ (F)))
        (SPROG
         ((|n| (|SparseUnivariatePolynomial| F))
          (|f| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (|r| (|Union| F "failed")) (|k| (|Kernel| F)))
         (SEQ (LETT |k| (SPADCALL |x| (QREFELT $ 25)))
              (LETT |r| (SPADCALL |p| (QREFELT $ 28)))
              (EXIT
               (COND
                ((QEQCAR |r| 1)
                 (SPADCALL |p| (SPADCALL |k| (QREFELT $ 30)) (QREFELT $ 31)))
                (#1='T
                 (SEQ
                  (LETT |n|
                        (SPADCALL
                         (LETT |f| (SPADCALL (QCDR |r|) |k| (QREFELT $ 33)))
                         (QREFELT $ 35)))
                  (EXIT
                   (COND
                    ((> (SPADCALL (SPADCALL |f| (QREFELT $ 36)) (QREFELT $ 38))
                        0)
                     (|error| "roofOf: variable appears in denom"))
                    (#1#
                     (SPADCALL |n| (SPADCALL |k| (QREFELT $ 30))
                               (QREFELT $ 31)))))))))))) 

(SDEFUN |AF;dvalg| ((|l| (|List| F)) (|x| (|Symbol|)) ($ (F)))
        (SPROG ((|alpha| (F)) (|p| (|SparseUnivariatePolynomial| F)))
               (SEQ
                (LETT |p|
                      (SPADCALL
                       (SPADCALL (|SPADfirst| |l|)
                                 (SPADCALL (SPADCALL |l| (QREFELT $ 21))
                                           (QREFELT $ 41))
                                 (QREFELT $ 33))
                       (QREFELT $ 35)))
                (LETT |alpha| (SPADCALL (QREFELT $ 13) |l| (QREFELT $ 43)))
                (EXIT
                 (SPADCALL
                  (SPADCALL
                   (SPADCALL
                    (SPADCALL (CONS #'|AF;dvalg!0| (VECTOR $ |x|)) |p|
                              (QREFELT $ 46))
                    |alpha| (QREFELT $ 47))
                   (SPADCALL (SPADCALL |p| (QREFELT $ 48)) |alpha|
                             (QREFELT $ 47))
                   (QREFELT $ 49))
                  (QREFELT $ 50)))))) 

(SDEFUN |AF;dvalg!0| ((|s| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |s| |x| (QREFELT $ 44)))))) 

(SDEFUN |AF;ialg| ((|l| (|List| F)) ($ (F)))
        (SPROG
         ((|f| (|Fraction| (|SparseUnivariatePolynomial| F))) (|x| (F))
          (|p| (F)))
         (SEQ
          (LETT |f|
                (SPADCALL (LETT |p| (|SPADfirst| |l|))
                          (SPADCALL (LETT |x| (SPADCALL |l| (QREFELT $ 21)))
                                    (QREFELT $ 41))
                          (QREFELT $ 33)))
          (EXIT
           (COND
            ((> (SPADCALL (SPADCALL |f| (QREFELT $ 36)) (QREFELT $ 38)) 0)
             (|error| "roofOf: variable appears in denom"))
            ('T
             (SPADCALL (SPADCALL |f| (QREFELT $ 35)) |x| (QREFELT $ 31)))))))) 

(SDEFUN |AF;operator;2Bo;6| ((|op| (|BasicOperator|)) ($ (|BasicOperator|)))
        (COND ((SPADCALL |op| '|rootOf| (QREFELT $ 18)) (QREFELT $ 13))
              ((SPADCALL |op| '|nthRoot| (QREFELT $ 18)) (QREFELT $ 14))
              ((SPADCALL |op| '|%root_sum| (QREFELT $ 18)) (QREFELT $ 15))
              ('T (|error| "Unknown operator")))) 

(SDEFUN |AF;inrootof;Sup2F;7|
        ((|q| (|SparseUnivariatePolynomial| F)) (|x| (F)) ($ (F)))
        (SPROG
         ((#1=#:G805 NIL)
          (|r| (|Union| (|SparseUnivariatePolynomial| R) "failed"))
          (|rx| (|Union| (|Symbol|) "failed")) (|d| (|NonNegativeInteger|)))
         (SEQ
          (COND ((SPADCALL |q| (QREFELT $ 52)) (|spadConstant| $ 53))
                (#2='T
                 (SEQ (LETT |d| (SPADCALL |q| (QREFELT $ 38)))
                      (EXIT
                       (COND
                        ((<= |d| 0) (|error| "rootOf: constant polynomial"))
                        ((EQL |d| 1)
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL (SPADCALL |q| (QREFELT $ 56))
                                     (QREFELT $ 57))
                           (SPADCALL |q| (QREFELT $ 57)) (QREFELT $ 49))
                          (QREFELT $ 50)))
                        (#2#
                         (SEQ
                          (EXIT
                           (SEQ
                            (SEQ (LETT |rx| (SPADCALL |x| (QREFELT $ 59)))
                                 (EXIT
                                  (COND
                                   ((QEQCAR |rx| 0)
                                    (SEQ (LETT |r| (|AF;UP2R| |q| $))
                                         (EXIT
                                          (COND
                                           ((QEQCAR |r| 0)
                                            (PROGN
                                             (LETT #1#
                                                   (SPADCALL
                                                    (SPADCALL (QCDR |r|)
                                                              (QCDR |rx|)
                                                              (QREFELT $ 61))
                                                    (QREFELT $ 62)))
                                             (GO #3=#:G801))))))))))
                            (EXIT
                             (SPADCALL (QREFELT $ 13)
                                       (LIST (SPADCALL |q| |x| (QREFELT $ 47))
                                             |x|)
                                       (QREFELT $ 43)))))
                          #3# (EXIT #1#))))))))))) 

(SDEFUN |AF;UP2R|
        ((|p| (|SparseUnivariatePolynomial| F))
         ($ (|Union| (|SparseUnivariatePolynomial| R) "failed")))
        (SPROG
         ((|ans| (|SparseUnivariatePolynomial| R)) (#1=#:G818 NIL)
          (|r| (|Union| R "failed")))
         (SEQ
          (EXIT
           (SEQ (LETT |ans| (|spadConstant| $ 64))
                (SEQ G190
                     (COND
                      ((NULL
                        (SPADCALL |p| (|spadConstant| $ 65) (QREFELT $ 66)))
                       (GO G191)))
                     (SEQ
                      (LETT |r|
                            (SPADCALL (SPADCALL |p| (QREFELT $ 57))
                                      (QREFELT $ 68)))
                      (EXIT
                       (COND
                        ((QEQCAR |r| 1)
                         (PROGN (LETT #1# (CONS 1 "failed")) (GO #2=#:G817)))
                        ('T
                         (SEQ
                          (LETT |ans|
                                (SPADCALL |ans|
                                          (SPADCALL (QCDR |r|)
                                                    (SPADCALL |p|
                                                              (QREFELT $ 38))
                                                    (QREFELT $ 69))
                                          (QREFELT $ 70)))
                          (EXIT (LETT |p| (SPADCALL |p| (QREFELT $ 56)))))))))
                     NIL (GO G190) G191 (EXIT NIL))
                (EXIT (CONS 0 |ans|))))
          #2# (EXIT #1#)))) 

(SDEFUN |AF;inrootof;Sup2F;9|
        ((|q| (|SparseUnivariatePolynomial| F)) (|x| (F)) ($ (F)))
        (SPROG ((|d| (|NonNegativeInteger|)))
               (SEQ
                (COND ((SPADCALL |q| (QREFELT $ 52)) (|spadConstant| $ 53))
                      (#1='T
                       (SEQ (LETT |d| (SPADCALL |q| (QREFELT $ 38)))
                            (EXIT
                             (COND
                              ((<= |d| 0)
                               (|error| "rootOf: constant polynomial"))
                              ((EQL |d| 1)
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (SPADCALL |q| (QREFELT $ 56))
                                           (QREFELT $ 57))
                                 (SPADCALL |q| (QREFELT $ 57)) (QREFELT $ 49))
                                (QREFELT $ 50)))
                              (#1#
                               (SPADCALL (QREFELT $ 13)
                                         (LIST
                                          (SPADCALL |q| |x| (QREFELT $ 47))
                                          |x|)
                                         (QREFELT $ 43))))))))))) 

(SDEFUN |AF;eqopalg| ((|k1| (|Kernel| F)) (|k2| (|Kernel| F)) ($ (|Boolean|)))
        (SPROG
         ((|lc2| #1=(|SparseMultivariatePolynomial| R (|Kernel| F)))
          (|lc1| #1#)
          (|p2|
           #2=(|SparseUnivariatePolynomial|
               (|SparseMultivariatePolynomial| R (|Kernel| F))))
          (|p1| #2#) (|pe2| (F)) (|pe1| (F)) (|dv2| #3=(|Kernel| F))
          (|dv1| #3#) (|al2| #4=(|List| F)) (|al1| #4#))
         (SEQ (LETT |al1| (SPADCALL |k1| (QREFELT $ 71)))
              (LETT |al2| (SPADCALL |k2| (QREFELT $ 71)))
              (LETT |dv1|
                    (SPADCALL (SPADCALL |al1| 2 (QREFELT $ 73))
                              (QREFELT $ 41)))
              (LETT |dv2|
                    (SPADCALL (SPADCALL |al2| 2 (QREFELT $ 73))
                              (QREFELT $ 41)))
              (LETT |pe1| (SPADCALL |al1| 1 (QREFELT $ 73)))
              (LETT |pe2| (SPADCALL |al2| 1 (QREFELT $ 73)))
              (EXIT
               (COND
                ((SPADCALL |dv1| |dv2| (QREFELT $ 74))
                 (SPADCALL |pe1| |pe2| (QREFELT $ 75)))
                (#5='T
                 (SEQ
                  (LETT |p1|
                        (SPADCALL (SPADCALL |pe1| (QREFELT $ 77)) |dv1|
                                  (QREFELT $ 79)))
                  (LETT |p2|
                        (SPADCALL (SPADCALL |pe2| (QREFELT $ 77)) |dv2|
                                  (QREFELT $ 79)))
                  (LETT |lc1| (SPADCALL |p1| (QREFELT $ 81)))
                  (LETT |lc2| (SPADCALL |p2| (QREFELT $ 81)))
                  (EXIT
                   (COND
                    ((SPADCALL |lc1| |lc2| (QREFELT $ 82))
                     (SPADCALL |p1| |p2| (QREFELT $ 83)))
                    (#5#
                     (SPADCALL (SPADCALL |lc2| |p1| (QREFELT $ 84))
                               (SPADCALL |lc1| |p2| (QREFELT $ 84))
                               (QREFELT $ 83)))))))))))) 

(SDEFUN |AF;root_sum1|
        ((|expr| (F)) (|p| (|SparseUnivariatePolynomial| F)) (|x| (F)) ($ (F)))
        (SPROG
         ((|nexpr| (|SparseUnivariatePolynomial| F)) (|res| (F))
          (#1=#:G857 NIL) (|i| NIL) (|xs| (|Symbol|)) (|a| (F))
          (|k| (|Kernel| F)))
         (SEQ
          (COND
           ((SPADCALL |expr| (|spadConstant| $ 53) (QREFELT $ 75))
            (|spadConstant| $ 53))
           (#2='T
            (SEQ (LETT |k| (SPADCALL |x| (QREFELT $ 41)))
                 (EXIT
                  (COND
                   ((EQL (SPADCALL |p| (QREFELT $ 38)) 1)
                    (SEQ
                     (LETT |a|
                           (SPADCALL
                            (SPADCALL (SPADCALL |p| 0 (QREFELT $ 90))
                                      (SPADCALL |p| 1 (QREFELT $ 90))
                                      (QREFELT $ 49))
                            (QREFELT $ 50)))
                     (EXIT (SPADCALL |expr| |k| |a| (QREFELT $ 91)))))
                   (#2#
                    (SEQ
                     (LETT |nexpr| (SPADCALL |expr| |k| |p| (QREFELT $ 93)))
                     (LETT |xs| (SPADCALL |x| (QREFELT $ 94)))
                     (EXIT
                      (COND
                       ((SPADCALL (CONS #'|AF;root_sum1!0| (VECTOR $ |xs|))
                                  (SPADCALL |nexpr| (QREFELT $ 96))
                                  (QREFELT $ 98))
                        (SEQ (LETT |res| (|spadConstant| $ 53))
                             (SEQ (LETT |i| 0)
                                  (LETT #1#
                                        (- (SPADCALL |p| (QREFELT $ 38)) 1))
                                  G190
                                  (COND ((|greater_SI| |i| #1#) (GO G191)))
                                  (SEQ
                                   (LETT |nexpr|
                                         (SPADCALL |nexpr| |p| (QREFELT $ 99)))
                                   (LETT |res|
                                         (SPADCALL |res|
                                                   (SPADCALL |nexpr| |i|
                                                             (QREFELT $ 90))
                                                   (QREFELT $ 100)))
                                   (EXIT
                                    (LETT |nexpr|
                                          (SPADCALL
                                           (SPADCALL (|spadConstant| $ 55) 1
                                                     (QREFELT $ 101))
                                           |nexpr| (QREFELT $ 102)))))
                                  (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                  (EXIT NIL))
                             (EXIT |res|)))
                       (#2#
                        (SPADCALL (QREFELT $ 15)
                                  (LIST (SPADCALL |nexpr| |x| (QREFELT $ 47))
                                        |x| (SPADCALL |p| |x| (QREFELT $ 47)))
                                  (QREFELT $ 43))))))))))))))) 

(SDEFUN |AF;root_sum1!0| ((|c| NIL) ($$ NIL))
        (PROG (|xs| $)
          (LETT |xs| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |c| |xs| (QREFELT $ 95)) (|spadConstant| $ 53)
                      (QREFELT $ 75)))))) 

(SDEFUN |AF;rootSum;FSupSF;12|
        ((|expr| (F)) (|p| (|SparseUnivariatePolynomial| F)) (|s| (|Symbol|))
         ($ (F)))
        (SPROG ((|k| (|Kernel| F)))
               (SEQ (LETT |k| (SPADCALL |s| (QREFELT $ 25)))
                    (EXIT
                     (|AF;root_sum1| |expr| |p| (SPADCALL |k| (QREFELT $ 30))
                      $))))) 

(SDEFUN |AF;irootsum| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|p| (|Fraction| (|SparseUnivariatePolynomial| F))) (|x| (F)))
               (SEQ
                (LETT |p|
                      (SPADCALL (LETT |p| (SPADCALL |l| 3 (QREFELT $ 73)))
                                (SPADCALL
                                 (LETT |x| (SPADCALL |l| 2 (QREFELT $ 73)))
                                 (QREFELT $ 41))
                                (QREFELT $ 33)))
                (EXIT
                 (COND
                  ((> (SPADCALL (SPADCALL |p| (QREFELT $ 36)) (QREFELT $ 38))
                      0)
                   (|error| "roofSum: variable appears in denom of p"))
                  ('T
                   (|AF;root_sum1| (SPADCALL |l| 1 (QREFELT $ 73))
                    (SPADCALL |p| (QREFELT $ 35)) |x| $))))))) 

(SDEFUN |AF;drootsum| ((|l| (|List| F)) ($ (|OutputForm|)))
        (SPROG
         ((|p|
           (|SparseUnivariatePolynomial|
            (|SparseMultivariatePolynomial| R (|Kernel| F))))
          (|dv| (|Kernel| F)))
         (SEQ
          (LETT |dv| (SPADCALL (SPADCALL |l| 2 (QREFELT $ 73)) (QREFELT $ 41)))
          (LETT |p|
                (SPADCALL
                 (SPADCALL (SPADCALL |l| 3 (QREFELT $ 73)) (QREFELT $ 77)) |dv|
                 (QREFELT $ 79)))
          (EXIT
           (SPADCALL (SPADCALL (SPADCALL |l| 1 (QREFELT $ 73)) (QREFELT $ 23))
                     (SPADCALL
                      (SPADCALL |p| (SPADCALL |dv| (QREFELT $ 104))
                                (QREFELT $ 105))
                      (SPADCALL 0 (QREFELT $ 106)) (QREFELT $ 107))
                     (QREFELT $ 108)))))) 

(SDEFUN |AF;dvrootsum| ((|l| (|List| F)) (|x| (|Symbol|)) ($ (F)))
        (SPROG
         ((|nexpr| (F)) (|expr| (F)) (|dalpha| (F))
          (|p| (|SparseUnivariatePolynomial| F)) (|dvs| (|Symbol|))
          (|dv| (|Kernel| F)) (|alpha| (F)))
         (SEQ
          (LETT |dv|
                (SPADCALL (LETT |alpha| (SPADCALL |l| 2 (QREFELT $ 73)))
                          (QREFELT $ 41)))
          (LETT |dvs| (SPADCALL |alpha| (QREFELT $ 94)))
          (LETT |p|
                (SPADCALL
                 (SPADCALL (SPADCALL |l| 3 (QREFELT $ 73)) |dv| (QREFELT $ 33))
                 (QREFELT $ 35)))
          (LETT |dalpha|
                (SPADCALL
                 (SPADCALL
                  (SPADCALL
                   (SPADCALL (CONS #'|AF;dvrootsum!0| (VECTOR $ |x|)) |p|
                             (QREFELT $ 46))
                   |alpha| (QREFELT $ 47))
                  (SPADCALL (SPADCALL |p| (QREFELT $ 48)) |alpha|
                            (QREFELT $ 47))
                  (QREFELT $ 49))
                 (QREFELT $ 50)))
          (LETT |expr| (SPADCALL |l| 1 (QREFELT $ 73)))
          (LETT |nexpr|
                (SPADCALL
                 (SPADCALL |dalpha| (SPADCALL |expr| |dvs| (QREFELT $ 44))
                           (QREFELT $ 109))
                 (SPADCALL |expr| |x| (QREFELT $ 44)) (QREFELT $ 100)))
          (EXIT
           (COND
            ((SPADCALL |nexpr| (|spadConstant| $ 53) (QREFELT $ 75))
             (|spadConstant| $ 53))
            ('T (|AF;root_sum1| |nexpr| |p| |alpha| $))))))) 

(SDEFUN |AF;dvrootsum!0| ((|s| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |s| |x| (QREFELT $ 44)))))) 

(SDEFUN |AF;lzero| ((|l| (|List| F)) ($ (F))) (|spadConstant| $ 53)) 

(SDEFUN |AF;droot;LOf;17| ((|l| (|List| F)) ($ (|OutputForm|)))
        (SPROG ((|n| (|Integer|)) (|x| (|OutputForm|)))
               (SEQ (LETT |x| (SPADCALL (|SPADfirst| |l|) (QREFELT $ 23)))
                    (LETT |n|
                          (SPADCALL (SPADCALL |l| (QREFELT $ 21))
                                    (QREFELT $ 112)))
                    (EXIT
                     (COND ((EQL |n| 2) (SPADCALL |x| (QREFELT $ 113)))
                           ('T
                            (SPADCALL |x| (SPADCALL |n| (QREFELT $ 106))
                                      (QREFELT $ 114)))))))) 

(SDEFUN |AF;dvroot| ((|l| (|List| F)) ($ (F)))
        (SPROG ((|kf| (F)) (|n| (|Integer|)))
               (SEQ
                (LETT |n|
                      (SPADCALL (SPADCALL |l| (QREFELT $ 21)) (QREFELT $ 112)))
                (LETT |kf| (SPADCALL (QREFELT $ 14) |l| (QREFELT $ 43)))
                (EXIT
                 (SPADCALL (SPADCALL |kf| (- 1 |n|) (QREFELT $ 118))
                           (SPADCALL |n| (QREFELT $ 119)) (QREFELT $ 49)))))) 

(SDEFUN |AF;^;FFF;19| ((|x| (F)) (|q| (|Fraction| (|Integer|))) ($ (F)))
        (SPROG
         ((|qr|
           (|Record| (|:| |quotient| (|Integer|))
                     (|:| |remainder| (|Integer|)))))
         (SEQ
          (LETT |qr|
                (DIVIDE2 (SPADCALL |q| (QREFELT $ 120))
                         (SPADCALL |q| (QREFELT $ 121))))
          (EXIT
           (SPADCALL (SPADCALL |x| (QCAR |qr|) (QREFELT $ 118))
                     (SPADCALL
                      (|AF;inroot|
                       (LIST |x|
                             (SPADCALL (SPADCALL |q| (QREFELT $ 121))
                                       (QREFELT $ 119)))
                       $)
                      (QCDR |qr|) (QREFELT $ 118))
                     (QREFELT $ 109)))))) 

(SDEFUN |AF;hackroot| ((|x| (F)) (|n| (|Integer|)) ($ (F)))
        (SPROG
         ((#1=#:G1001 NIL) (|rx| (|Union| (|Integer|) "failed"))
          (|dx| (|SparseMultivariatePolynomial| R (|Kernel| F))))
         (SEQ
          (EXIT
           (COND
            ((OR (EQL |n| 1)
                 (SPADCALL |x| (|spadConstant| $ 55) (QREFELT $ 75)))
             |x|)
            ('T
             (SEQ
              (COND
               ((SPADCALL (LETT |dx| (SPADCALL |x| (QREFELT $ 123)))
                          (|spadConstant| $ 124) (QREFELT $ 125))
                (SEQ (LETT |rx| (SPADCALL |dx| (QREFELT $ 127)))
                     (EXIT
                      (COND
                       ((QEQCAR |rx| 0)
                        (COND
                         ((PLUSP (QCDR |rx|))
                          (PROGN
                           (LETT #1#
                                 (SPADCALL
                                  (|AF;hackroot|
                                   (SPADCALL (SPADCALL |x| (QREFELT $ 77))
                                             (QREFELT $ 128))
                                   |n| $)
                                  (|AF;hackroot|
                                   (SPADCALL (QCDR |rx|) (QREFELT $ 119)) |n|
                                   $)
                                  (QREFELT $ 49)))
                           (GO #2=#:G999))))))))))
              (COND
               ((SPADCALL |x| (SPADCALL (|spadConstant| $ 55) (QREFELT $ 50))
                          (QREFELT $ 75))
                (COND
                 ((EQL |n| 4)
                  (EXIT
                   (SPADCALL
                    (SPADCALL
                     (SPADCALL (SPADCALL (|spadConstant| $ 55) (QREFELT $ 50))
                               (SPADCALL (|spadConstant| $ 117)
                                         (SPADCALL 2 (QREFELT $ 129))
                                         (QREFELT $ 130))
                               (QREFELT $ 122))
                     (|spadConstant| $ 55) (QREFELT $ 100))
                    (SPADCALL (SPADCALL 2 (QREFELT $ 119))
                              (SPADCALL (|spadConstant| $ 117)
                                        (SPADCALL 2 (QREFELT $ 129))
                                        (QREFELT $ 130))
                              (QREFELT $ 122))
                    (QREFELT $ 49)))))))
              (EXIT
               (SPADCALL (QREFELT $ 14)
                         (LIST |x| (SPADCALL |n| (QREFELT $ 119)))
                         (QREFELT $ 43)))))))
          #2# (EXIT #1#)))) 

(SDEFUN |AF;inroot| ((|l| (|List| F)) ($ (F)))
        (SPROG
         ((|r| (|Union| R "failed")) (#1=#:G1009 NIL) (|x| (F))
          (|n| (|Integer|)))
         (SEQ
          (COND
           ((ZEROP
             (LETT |n|
                   (SPADCALL (SPADCALL |l| (QREFELT $ 21)) (QREFELT $ 112))))
            (|error| "root: exponent = 0"))
           (#2='T
            (SEQ
             (EXIT
              (SEQ
               (SEQ (LETT |x| (|SPADfirst| |l|))
                    (EXIT
                     (COND
                      ((OR (SPADCALL |x| (|spadConstant| $ 55) (QREFELT $ 75))
                           (EQL |n| 1))
                       (PROGN (LETT #1# |x|) (GO #3=#:G1006))))))
               (LETT |r| (SPADCALL |x| (QREFELT $ 68)))
               (EXIT
                (COND
                 ((QEQCAR |r| 0) (SPADCALL (QCDR |r|) |n| (QREFELT $ 131)))
                 (#2# (|AF;inroot0| |x| |n| NIL NIL $))))))
             #3# (EXIT #1#))))))) 

(SDEFUN |AF;inroot0|
        ((|x| (F)) (|n| (|Integer|)) (|num?| (|Boolean|)) (|den?| (|Boolean|))
         ($ (F)))
        (SPROG
         ((#1=#:G1011 NIL)
          (|rec|
           (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| F)
                     (|:| |radicand| F)))
          (#2=#:G1018 NIL) (#3=#:G1016 NIL) (#4=#:G1013 NIL)
          (|rd| #5=(|Union| (|Integer|) "failed")) (|rn| #5#))
         (SEQ
          (LETT |rn|
                (COND (|num?| (CONS 1 "failed"))
                      (#6='T
                       (SPADCALL (SPADCALL |x| (QREFELT $ 77))
                                 (QREFELT $ 127)))))
          (LETT |rd|
                (COND (|den?| (CONS 1 "failed"))
                      (#6#
                       (SPADCALL (SPADCALL |x| (QREFELT $ 123))
                                 (QREFELT $ 127)))))
          (COND
           ((QEQCAR |rn| 0)
            (COND
             ((QEQCAR |rd| 0)
              (EXIT
               (SEQ
                (LETT |rec|
                      (SPADCALL
                       (SPADCALL (QCDR |rn|) (QCDR |rd|) (QREFELT $ 132))
                       (PROG1 (LETT #4# |n|)
                         (|check_subtype2| (>= #4# 0) '(|NonNegativeInteger|)
                                           '(|Integer|) #4#))
                       (QREFELT $ 135)))
                (EXIT
                 (SPADCALL (QVELT |rec| 1)
                           (|AF;hackroot| (QVELT |rec| 2) (QVELT |rec| 0) $)
                           (QREFELT $ 109)))))))))
          (EXIT
           (COND
            ((QEQCAR |rn| 0)
             (SEQ
              (LETT |rec|
                    (SPADCALL (SPADCALL (QCDR |rn|) (QREFELT $ 129))
                              (PROG1 (LETT #3# |n|)
                                (|check_subtype2| (>= #3# 0)
                                                  '(|NonNegativeInteger|)
                                                  '(|Integer|) #3#))
                              (QREFELT $ 135)))
              (EXIT
               (SPADCALL (QVELT |rec| 1)
                         (|AF;inroot0|
                          (SPADCALL
                           (SPADCALL (QVELT |rec| 2)
                                     (PROG2
                                         (LETT #1#
                                               (SPADCALL |n| (QVELT |rec| 0)
                                                         (QREFELT $ 137)))
                                         (QCDR #1#)
                                       (|check_union2| (QEQCAR #1# 0)
                                                       (|Integer|)
                                                       (|Union| (|Integer|)
                                                                #7="failed")
                                                       #1#))
                                     (QREFELT $ 118))
                           (SPADCALL (SPADCALL |x| (QREFELT $ 123))
                                     (QREFELT $ 128))
                           (QREFELT $ 49))
                          |n| 'T |den?| $)
                         (QREFELT $ 109)))))
            ((QEQCAR |rd| 0)
             (SEQ
              (LETT |rec|
                    (SPADCALL (SPADCALL (QCDR |rd|) (QREFELT $ 129))
                              (PROG1 (LETT #2# |n|)
                                (|check_subtype2| (>= #2# 0)
                                                  '(|NonNegativeInteger|)
                                                  '(|Integer|) #2#))
                              (QREFELT $ 135)))
              (EXIT
               (SPADCALL
                (|AF;inroot0|
                 (SPADCALL
                  (SPADCALL (SPADCALL |x| (QREFELT $ 77)) (QREFELT $ 128))
                  (SPADCALL (QVELT |rec| 2)
                            (PROG2
                                (LETT #1#
                                      (SPADCALL |n| (QVELT |rec| 0)
                                                (QREFELT $ 137)))
                                (QCDR #1#)
                              (|check_union2| (QEQCAR #1# 0) (|Integer|)
                                              (|Union| (|Integer|) #7#) #1#))
                            (QREFELT $ 118))
                  (QREFELT $ 49))
                 |n| |num?| 'T $)
                (QVELT |rec| 1) (QREFELT $ 49)))))
            (#6# (|AF;hackroot| |x| |n| $))))))) 

(SDEFUN |AF;iroot;RIF;23| ((|r| (R)) (|n| (|Integer|)) ($ (F)))
        (SPADCALL (SPADCALL |r| |n| (QREFELT $ 138)) (QREFELT $ 62))) 

(SDEFUN |AF;iroot;RIF;24| ((|r| (R)) (|n| (|Integer|)) ($ (F)))
        (SPADCALL (SPADCALL |r| |n| (QREFELT $ 138)) (QREFELT $ 62))) 

(SDEFUN |AF;iroot;RIF;25| ((|r| (R)) (|n| (|Integer|)) ($ (F)))
        (COND
         ((OR (ODDP |n|)
              (NULL (SPADCALL |r| (|spadConstant| $ 39) (QREFELT $ 139))))
          (SPADCALL (SPADCALL |r| |n| (QREFELT $ 138)) (QREFELT $ 62)))
         ('T (|AF;hackroot| (SPADCALL |r| (QREFELT $ 62)) |n| $)))) 

(SDEFUN |AF;iroot;RIF;26| ((|r| (R)) (|n| (|Integer|)) ($ (F)))
        (COND
         ((OR (ODDP |n|)
              (NULL (SPADCALL |r| (|spadConstant| $ 39) (QREFELT $ 139))))
          (SPADCALL (SPADCALL |r| |n| (QREFELT $ 138)) (QREFELT $ 62)))
         ('T (|AF;iroot0| |r| |n| $)))) 

(SDEFUN |AF;iroot;RIF;27| ((|r| (R)) (|n| (|Integer|)) ($ (F)))
        (|AF;iroot0| |r| |n| $)) 

(SDEFUN |AF;iroot0| ((|r| (R)) (|n| (|Integer|)) ($ (F)))
        (SPROG
         ((|rec|
           (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| F)
                     (|:| |radicand| F)))
          (#1=#:G1034 NIL))
         (SEQ
          (LETT |rec|
                (SPADCALL |r|
                          (PROG1 (LETT #1# |n|)
                            (|check_subtype2| (>= #1# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #1#))
                          (QREFELT $ 140)))
          (EXIT
           (SPADCALL (QVELT |rec| 1)
                     (|AF;hackroot| (QVELT |rec| 2) (QVELT |rec| 0) $)
                     (QREFELT $ 109)))))) 

(SDEFUN |AF;definingPolynomial;2F;29| ((|x| (F)) ($ (F)))
        (SPROG ((|k| (|Kernel| F)) (|r| (|Union| (|Kernel| F) "failed")))
               (SEQ (LETT |r| (SPADCALL |x| (QREFELT $ 142)))
                    (EXIT
                     (COND
                      ((QEQCAR |r| 0)
                       (COND
                        ((SPADCALL (LETT |k| (QCDR |r|)) (QREFELT $ 13)
                                   (QREFELT $ 143))
                         (|SPADfirst| (SPADCALL |k| (QREFELT $ 71))))
                        ((SPADCALL |k| (QREFELT $ 14) (QREFELT $ 143))
                         (SPADCALL
                          (SPADCALL (QREFELT $ 111)
                                    (SPADCALL
                                     (SPADCALL (SPADCALL |k| (QREFELT $ 71))
                                               (QREFELT $ 21))
                                     (QREFELT $ 112))
                                    (QREFELT $ 118))
                          (|SPADfirst| (SPADCALL |k| (QREFELT $ 71)))
                          (QREFELT $ 144)))
                        (#1='T
                         (SPADCALL (QREFELT $ 111) |x| (QREFELT $ 144)))))
                      (#1# (SPADCALL (QREFELT $ 111) |x| (QREFELT $ 144)))))))) 

(SDEFUN |AF;minPoly;KSup;30|
        ((|k| (|Kernel| F)) ($ (|SparseUnivariatePolynomial| F)))
        (SPROG ((#1=#:G1045 NIL))
               (COND
                ((SPADCALL |k| (QREFELT $ 13) (QREFELT $ 143))
                 (SPADCALL
                  (SPADCALL (|SPADfirst| (SPADCALL |k| (QREFELT $ 71)))
                            (SPADCALL
                             (SPADCALL (SPADCALL |k| (QREFELT $ 71))
                                       (QREFELT $ 21))
                             (QREFELT $ 41))
                            (QREFELT $ 33))
                  (QREFELT $ 35)))
                ((SPADCALL |k| (QREFELT $ 14) (QREFELT $ 143))
                 (SPADCALL
                  (SPADCALL (|spadConstant| $ 55)
                            (PROG1
                                (LETT #1#
                                      (SPADCALL
                                       (SPADCALL (SPADCALL |k| (QREFELT $ 71))
                                                 (QREFELT $ 21))
                                       (QREFELT $ 112)))
                              (|check_subtype2| (>= #1# 0)
                                                '(|NonNegativeInteger|)
                                                '(|Integer|) #1#))
                            (QREFELT $ 101))
                  (SPADCALL (|SPADfirst| (SPADCALL |k| (QREFELT $ 71)))
                            (QREFELT $ 146))
                  (QREFELT $ 147)))
                ('T
                 (SPADCALL (SPADCALL (|spadConstant| $ 55) 1 (QREFELT $ 101))
                           (SPADCALL (SPADCALL |k| (QREFELT $ 30))
                                     (QREFELT $ 146))
                           (QREFELT $ 147)))))) 

(SDEFUN |AF;droot;LOf;31| ((|l| (|List| F)) ($ (|OutputForm|)))
        (SPROG ((|n| (F)) (|x| (|OutputForm|)))
               (SEQ (LETT |x| (SPADCALL (|SPADfirst| |l|) (QREFELT $ 23)))
                    (LETT |n| (SPADCALL |l| (QREFELT $ 21)))
                    (EXIT
                     (COND
                      ((SPADCALL |n| (SPADCALL 2 (QREFELT $ 119))
                                 (QREFELT $ 75))
                       (SPADCALL |x| (QREFELT $ 113)))
                      ('T
                       (SPADCALL |x| (SPADCALL |n| (QREFELT $ 23))
                                 (QREFELT $ 114)))))))) 

(SDEFUN |AF;minPoly;KSup;32|
        ((|k| (|Kernel| F)) ($ (|SparseUnivariatePolynomial| F)))
        (COND
         ((SPADCALL |k| (QREFELT $ 13) (QREFELT $ 143))
          (SPADCALL
           (SPADCALL (|SPADfirst| (SPADCALL |k| (QREFELT $ 71)))
                     (SPADCALL
                      (SPADCALL (SPADCALL |k| (QREFELT $ 71)) (QREFELT $ 21))
                      (QREFELT $ 41))
                     (QREFELT $ 33))
           (QREFELT $ 35)))
         ('T
          (SPADCALL (SPADCALL (|spadConstant| $ 55) 1 (QREFELT $ 101))
                    (SPADCALL (SPADCALL |k| (QREFELT $ 30)) (QREFELT $ 146))
                    (QREFELT $ 147))))) 

(DECLAIM (NOTINLINE |AlgebraicFunction;|)) 

(DEFUN |AlgebraicFunction| (&REST #1=#:G1058)
  (SPROG NIL
         (PROG (#2=#:G1059)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|AlgebraicFunction|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |AlgebraicFunction;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|AlgebraicFunction|)))))))))) 

(DEFUN |AlgebraicFunction;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|AlgebraicFunction| DV$1 DV$2))
          (LETT $ (GETREFV 151))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|RetractableTo|
                                                               (|Integer|)))))))
          (|haddProp| |$ConstructorCache| '|AlgebraicFunction| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 8 '|%alg|)
          (QSETREFV $ 13 (SPADCALL '|rootOf| (QREFELT $ 12)))
          (QSETREFV $ 14 (SPADCALL '|nthRoot| (QREFELT $ 12)))
          (QSETREFV $ 15 (SPADCALL '|%root_sum| (QREFELT $ 12)))
          (COND
           ((|HasCategory| |#1| '(|AlgebraicallyClosedField|))
            (PROGN
             (QSETREFV $ 31
                       (CONS (|dispatchFunction| |AF;inrootof;Sup2F;7|) $))))
           ('T
            (QSETREFV $ 31
                      (CONS (|dispatchFunction| |AF;inrootof;Sup2F;9|) $))))
          (SPADCALL (QREFELT $ 13) (CONS (|function| |AF;ialg|) $)
                    (QREFELT $ 87))
          (SPADCALL (QREFELT $ 13) '|%specialDiff|
                    (CONS (|function| |AF;dvalg|) $) (QREFELT $ 89))
          (SPADCALL (QREFELT $ 13) '|%specialDisp|
                    (CONS (|function| |AF;dalg|) $) (QREFELT $ 89))
          (SPADCALL (QREFELT $ 13) '|%specialEqual|
                    (CONS (|function| |AF;eqopalg|) $) (QREFELT $ 89))
          (SPADCALL (QREFELT $ 15) (CONS (|function| |AF;irootsum|) $)
                    (QREFELT $ 87))
          (SPADCALL (QREFELT $ 15) '|%specialDiff|
                    (CONS (|function| |AF;dvrootsum|) $) (QREFELT $ 89))
          (SPADCALL (QREFELT $ 15) '|%specialDisp|
                    (CONS (|function| |AF;drootsum|) $) (QREFELT $ 89))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 111 (SPADCALL '|%%var| (QREFELT $ 110)))
             NIL
             NIL
             NIL
             NIL
             NIL
             (QSETREFV $ 115 (CONS (|dispatchFunction| |AF;droot;LOf;17|) $))
             (QSETREFV $ 122 (CONS (|dispatchFunction| |AF;^;FFF;19|) $))
             (COND
              ((|HasCategory| |#1| '(|AlgebraicallyClosedField|))
               (QSETREFV $ 131
                         (CONS (|dispatchFunction| |AF;iroot;RIF;23|) $)))
              ('T
               (PROGN
                (COND
                 ((|HasCategory| |#1| '(|RadicalCategory|))
                  (COND
                   ((|HasSignature| |#1|
                                    (LIST '|imaginary|
                                          (LIST (|devaluate| |#1|))))
                    (QSETREFV $ 131
                              (CONS (|dispatchFunction| |AF;iroot;RIF;24|) $)))
                   ((|HasCategory| |#1| '(|FloatingPointSystem|))
                    (QSETREFV $ 131
                              (CONS (|dispatchFunction| |AF;iroot;RIF;25|) $)))
                   ('T
                    (QSETREFV $ 131
                              (CONS (|dispatchFunction| |AF;iroot;RIF;26|)
                                    $)))))
                 ('T
                  (QSETREFV $ 131
                            (CONS (|dispatchFunction| |AF;iroot;RIF;27|)
                                  $)))))))
             (QSETREFV $ 145
                       (CONS (|dispatchFunction| |AF;definingPolynomial;2F;29|)
                             $))
             (QSETREFV $ 148
                       (CONS (|dispatchFunction| |AF;minPoly;KSup;30|) $))
             (SPADCALL (QREFELT $ 14) (CONS (|function| |AF;inroot|) $)
                       (QREFELT $ 87))
             (SPADCALL (QREFELT $ 14)
                       (LIST (CONS (|function| |AF;dvroot|) $)
                             (CONS (|function| |AF;lzero|) $))
                       (QREFELT $ 150))))
           ('T
            (PROGN
             (QSETREFV $ 115 (CONS (|dispatchFunction| |AF;droot;LOf;31|) $))
             (QSETREFV $ 148
                       (CONS (|dispatchFunction| |AF;minPoly;KSup;32|) $)))))
          (SPADCALL (QREFELT $ 14) '|%specialDisp| (ELT $ 115) (QREFELT $ 89))
          $))) 

(MAKEPROP '|AlgebraicFunction| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|) 'ALGOP
              (|BasicOperator|) (|Symbol|) (|CommonOperators|) (0 . |operator|)
              '|opalg| '|oproot| '|oprootsum| (|Boolean|) (5 . |has?|)
              (11 . |is?|) |AF;belong?;BoB;1| (|List| 7) (17 . |second|)
              (|OutputForm|) (22 . |coerce|) (|Kernel| 7) (27 . |kernel|)
              (|Union| 7 '"failed") (|SparseUnivariatePolynomial| 7)
              (32 . |retractIfCan|) (|Kernel| $) (37 . |coerce|)
              (42 . |inrootof|) (|Fraction| 60) (48 . |univariate|)
              (|Fraction| 27) (54 . |numer|) (59 . |denom|)
              (|NonNegativeInteger|) (64 . |degree|) (69 . |Zero|)
              |AF;rootOf;SupSF;3| (73 . |retract|) (|List| $) (78 . |kernel|)
              (84 . |differentiate|) (|Mapping| 7 7) (90 . |map|) (96 . |elt|)
              (102 . |differentiate|) (107 . /) (113 . -) |AF;operator;2Bo;6|
              (118 . |monomial?|) (123 . |Zero|) (127 . |One|) (131 . |One|)
              (135 . |reductum|) (140 . |leadingCoefficient|)
              (|Union| 10 '#1="failed") (145 . |retractIfCan|)
              (|SparseUnivariatePolynomial| $) (150 . |rootOf|)
              (156 . |coerce|) (|SparseUnivariatePolynomial| 6) (161 . |Zero|)
              (165 . |Zero|) (169 . ~=) (|Union| 6 '#1#) (175 . |retractIfCan|)
              (180 . |monomial|) (186 . +) (192 . |argument|) (|Integer|)
              (197 . |elt|) (203 . =) (209 . =)
              (|SparseMultivariatePolynomial| 6 29) (215 . |numer|)
              (|SparseMultivariatePolynomial| 6 24) (220 . |univariate|)
              (|SparseUnivariatePolynomial| 78) (226 . |leadingCoefficient|)
              (231 . =) (237 . =) (243 . *) (|Mapping| 7 20)
              (|BasicOperatorFunctions1| 7) (249 . |evaluate|) (|None|)
              (255 . |setProperty|) (262 . |coefficient|) (268 . |eval|)
              (|PolynomialCategoryQuotientFunctions| (|IndexedExponents| 24) 24
                                                     6 78 7)
              (275 . |univariate|) (282 . |retract|) (287 . D)
              (293 . |coefficients|) (|Mapping| 16 7) (298 . |every?|)
              (304 . |rem|) (310 . +) (316 . |monomial|) (322 . *)
              |AF;rootSum;FSupSF;12| (328 . |coerce|) (333 . |outputForm|)
              (339 . |coerce|) (344 . =) (350 . |sum|) (356 . *)
              (362 . |coerce|) '|dumvar| (367 . |retract|) (372 . |root|)
              (377 . |root|) (383 . |droot|) (|Fraction| 72) (388 . |One|)
              (392 . ^) (398 . |coerce|) (403 . |numer|) (408 . |denom|)
              (413 . ^) (419 . |denom|) (424 . |One|) (428 . ~=)
              (|Union| 72 '"failed") (434 . |retractIfCan|) (439 . |coerce|)
              (444 . |coerce|) (449 . /) (455 . |iroot|) (461 . /)
              (|Record| (|:| |exponent| 37) (|:| |coef| 7) (|:| |radicand| 7))
              (|PolynomialRoots| (|IndexedExponents| 24) 24 6 78 7)
              (467 . |qroot|) (|Union| $ '"failed") (473 . |exquo|)
              (479 . |nthRoot|) (485 . |smaller?|) (491 . |rroot|)
              (|Union| 29 '#1#) (497 . |retractIfCan|) (502 . |is?|) (508 . -)
              (514 . |definingPolynomial|) (519 . |coerce|) (524 . -)
              (530 . |minPoly|) (|List| 85) (535 . |derivative|))
           '#(|rootSum| 541 |rootOf| 548 |operator| 554 |minPoly| 559 |iroot|
              564 |inrootof| 570 |droot| 576 |definingPolynomial| 581 |belong?|
              586 ^ 591)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|rootOf|
                                 (|#2| (|SparseUnivariatePolynomial| |#2|)
                                  (|Symbol|)))
                                T)
                              '((|rootSum|
                                 (|#2| |#2| (|SparseUnivariatePolynomial| |#2|)
                                  (|Symbol|)))
                                T)
                              '((|operator|
                                 ((|BasicOperator|) (|BasicOperator|)))
                                T)
                              '((|belong?| ((|Boolean|) (|BasicOperator|))) T)
                              '((|inrootof|
                                 (|#2| (|SparseUnivariatePolynomial| |#2|)
                                  |#2|))
                                T)
                              '((|droot| ((|OutputForm|) (|List| |#2|))) T)
                              '((^ (|#2| |#2| (|Fraction| (|Integer|))))
                                (|has| 6 (|RetractableTo| 72)))
                              '((|minPoly|
                                 ((|SparseUnivariatePolynomial| |#2|)
                                  (|Kernel| |#2|)))
                                (|has| 6 (|RetractableTo| 72)))
                              '((|definingPolynomial| (|#2| |#2|))
                                (|has| 6 (|RetractableTo| 72)))
                              '((|iroot| (|#2| |#1| (|Integer|)))
                                (|has| 6 (|RetractableTo| 72))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 150
                                            '(1 11 9 10 12 2 9 16 0 10 17 2 9
                                              16 0 10 18 1 20 7 0 21 1 7 22 0
                                              23 1 24 0 10 25 1 27 26 0 28 1 7
                                              0 29 30 2 0 7 27 7 31 2 7 32 0 29
                                              33 1 34 27 0 35 1 34 27 0 36 1 27
                                              37 0 38 0 6 0 39 1 7 29 0 41 2 7
                                              0 9 42 43 2 7 0 0 10 44 2 27 0 45
                                              0 46 2 27 7 0 7 47 1 27 0 0 48 2
                                              7 0 0 0 49 1 7 0 0 50 1 27 16 0
                                              52 0 7 0 53 0 6 0 54 0 7 0 55 1
                                              27 0 0 56 1 27 7 0 57 1 7 58 0 59
                                              2 6 0 60 10 61 1 7 0 6 62 0 63 0
                                              64 0 27 0 65 2 27 16 0 0 66 1 7
                                              67 0 68 2 63 0 6 37 69 2 63 0 0 0
                                              70 1 24 20 0 71 2 20 7 0 72 73 2
                                              24 16 0 0 74 2 7 16 0 0 75 1 7 76
                                              0 77 2 78 60 0 24 79 1 80 78 0 81
                                              2 78 16 0 0 82 2 80 16 0 0 83 2
                                              80 0 78 0 84 2 86 9 9 85 87 3 9 0
                                              0 10 88 89 2 27 7 0 37 90 3 7 0 0
                                              29 0 91 3 92 27 7 24 27 93 1 7 10
                                              0 94 2 7 0 0 10 95 1 27 20 0 96 2
                                              20 16 97 0 98 2 27 0 0 0 99 2 7 0
                                              0 0 100 2 27 0 7 37 101 2 27 0 0
                                              0 102 1 24 22 0 104 2 80 22 0 22
                                              105 1 72 22 0 106 2 22 0 0 0 107
                                              2 22 0 0 0 108 2 7 0 0 0 109 1 7
                                              0 10 110 1 7 72 0 112 1 22 0 0
                                              113 2 22 0 0 0 114 1 0 22 20 115
                                              0 116 0 117 2 7 0 0 72 118 1 7 0
                                              72 119 1 116 72 0 120 1 116 72 0
                                              121 2 0 7 7 116 122 1 7 76 0 123
                                              0 78 0 124 2 78 16 0 0 125 1 78
                                              126 0 127 1 7 0 76 128 1 116 0 72
                                              129 2 116 0 0 0 130 2 0 7 6 72
                                              131 2 116 0 72 72 132 2 134 133
                                              116 37 135 2 72 136 0 0 137 2 6 0
                                              0 72 138 2 6 16 0 0 139 2 134 133
                                              6 37 140 1 7 141 0 142 2 24 16 0
                                              9 143 2 7 0 0 0 144 1 0 7 7 145 1
                                              27 0 7 146 2 27 0 0 0 147 1 0 27
                                              24 148 2 86 9 9 149 150 3 0 7 7
                                              27 10 103 2 0 7 27 10 40 1 0 9 9
                                              51 1 1 27 24 148 2 1 7 6 72 131 2
                                              0 7 27 7 31 1 0 22 20 115 1 1 7 7
                                              145 1 0 16 9 19 2 1 7 7 116
                                              122)))))
           '|lookupComplete|)) 
