
(SDEFUN |IR2F;cmplex|
        ((|alpha| (F)) (|p| (|SparseUnivariatePolynomial| F)) ($ (F)))
        (SPADCALL |alpha|
                  (SPADCALL (SPADCALL |p| |alpha| (QREFELT $ 9))
                            (QREFELT $ 10))
                  (QREFELT $ 11))) 

(SDEFUN |IR2F;IR2F| ((|i| (|IntegrationResult| F)) ($ (F)))
        (SPADCALL
         (SPADCALL (SPADCALL |i| (QREFELT $ 13)) NIL
                   (SPADCALL |i| (QREFELT $ 16)) (QREFELT $ 19))
         (QREFELT $ 20))) 

(SDEFUN |IR2F;pairprod| ((|x| (F)) (|l| (|List| F)) ($ (|List| F)))
        (SPROG ((#1=#:G735 NIL) (|y| NIL) (#2=#:G734 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |y| NIL) (LETT #1# |l|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |y| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS (SPADCALL |x| |y| (QREFELT $ 11)) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |IR2F;evenRoots| ((|x| (F)) ($ (|List| F)))
        (SPROG ((#1=#:G745 NIL) (|k| NIL) (#2=#:G744 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |k| NIL) (LETT #1# (SPADCALL |x| (QREFELT $ 22)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((COND
                           ((SPADCALL |k| '|nthRoot| (QREFELT $ 26))
                            (COND
                             ((EVENP
                               (SPADCALL
                                (SPADCALL (SPADCALL |k| (QREFELT $ 28))
                                          (QREFELT $ 29))
                                (QREFELT $ 31)))
                              (NULL
                               (NULL
                                (SPADCALL
                                 (|SPADfirst| (SPADCALL |k| (QREFELT $ 28)))
                                 (QREFELT $ 33)))))
                             (#3='T NIL)))
                           (#3# NIL))
                          (LETT #2#
                                (CONS
                                 (|SPADfirst| (SPADCALL |k| (QREFELT $ 28)))
                                 #2#))))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |IR2F;expand;IrSL;5|
        ((|i| (|IntegrationResult| F)) (|x| (|Symbol|)) ($ (|List| F)))
        (SPROG ((|j| (|IntegrationResult| F)))
               (SEQ (LETT |j| (SPADCALL |i| (QREFELT $ 34)))
                    (EXIT
                     (|IR2F;pairsum| (LIST (|IR2F;IR2F| |j| $))
                      (|IR2F;mkRealFunc| (SPADCALL |j| (QREFELT $ 35)) |x| $)
                      $))))) 

(SDEFUN |IR2F;split;2Ir;6|
        ((|i| (|IntegrationResult| F)) ($ (|IntegrationResult| F)))
        (SPROG ((#1=#:G763 NIL) (|l| NIL) (#2=#:G762 NIL))
               (SEQ
                (SPADCALL (SPADCALL |i| (QREFELT $ 13))
                          (SPADCALL
                           (PROGN
                            (LETT #2# NIL)
                            (SEQ (LETT |l| NIL)
                                 (LETT #1# (SPADCALL |i| (QREFELT $ 35))) G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |l| (CAR #1#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #2# (CONS (|IR2F;nlogs| |l| $) #2#))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT (NREVERSE #2#))))
                           (QREFELT $ 38))
                          (SPADCALL |i| (QREFELT $ 16)) (QREFELT $ 19))))) 

(SDEFUN |IR2F;complexExpand;IrF;7| ((|i| (|IntegrationResult| F)) ($ (F)))
        (SPROG
         ((#1=#:G766 NIL) (#2=#:G765 (F)) (#3=#:G767 (F)) (#4=#:G776 NIL)
          (|lg| NIL) (|j| (|IntegrationResult| F)))
         (SEQ (LETT |j| (SPADCALL |i| (QREFELT $ 34)))
              (EXIT
               (SPADCALL (|IR2F;IR2F| |j| $)
                         (PROGN
                          (LETT #1# NIL)
                          (SEQ (LETT |lg| NIL)
                               (LETT #4# (SPADCALL |j| (QREFELT $ 35))) G190
                               (COND
                                ((OR (ATOM #4#)
                                     (PROGN (LETT |lg| (CAR #4#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (PROGN
                                  (LETT #3#
                                        (SPADCALL
                                         (SPADCALL (QVELT |lg| 0)
                                                   (QREFELT $ 40))
                                         (|IR2F;lg2cfunc| |lg| $)
                                         (QREFELT $ 11)))
                                  (COND
                                   (#1#
                                    (LETT #2#
                                          (SPADCALL #2# #3# (QREFELT $ 41))))
                                   ('T
                                    (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                               (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                          (COND (#1# #2#) ('T (|spadConstant| $ 42))))
                         (QREFELT $ 41)))))) 

(SDEFUN |IR2F;quadratic|
        ((|p| (|SparseUnivariatePolynomial| F))
         (|lg| (|SparseUnivariatePolynomial| F)) (|x| (|Symbol|))
         ($ (|List| F)))
        (SPROG
         ((|nn| (F)) (|sqrn| (F)) (|pp| (F)) (|sqrp| (F))
          (|s| #1=(|Record| (|:| |ans1| F) (|:| |ans2| F)))
          (|sqr| (|Record| (|:| |sqrt| #1#) (|:| |sgn| (|Integer|))))
          (|lgp| (F)) (|nrm| (F)) (|f| (F)) (|e| (F))
          (|q| (|Record| (|:| |ans1| F) (|:| |ans2| F))) (|c| (F)) (|d| (F))
          (|delta| (F)) (|p0| (F)) (|a| (F)) (|b| (F)))
         (SEQ
          (COND
           ((SPADCALL
             (LETT |delta|
                   (SPADCALL
                    (SPADCALL (LETT |b| (SPADCALL |p| 1 (QREFELT $ 47))) 2
                              (QREFELT $ 49))
                    (SPADCALL
                     (SPADCALL 4 (LETT |a| (SPADCALL |p| 2 (QREFELT $ 47)))
                               (QREFELT $ 50))
                     (LETT |p0| (SPADCALL |p| 0 (QREFELT $ 47)))
                     (QREFELT $ 11))
                    (QREFELT $ 52)))
             (QREFELT $ 53))
            (LIST
             (|IR2F;linear|
              (SPADCALL (SPADCALL (|spadConstant| $ 45) 1 (QREFELT $ 54))
                        (SPADCALL (SPADCALL |b| |a| (QREFELT $ 55))
                                  (QREFELT $ 56))
                        (QREFELT $ 57))
              |lg| $)))
           (#2='T
            (SEQ
             (LETT |e|
                   (QCAR
                    (LETT |q|
                          (|IR2F;quadeval| |lg|
                           (LETT |c|
                                 (SPADCALL
                                  (SPADCALL |b|
                                            (LETT |d|
                                                  (SPADCALL
                                                   (SPADCALL 2 |a|
                                                             (QREFELT $ 50))
                                                   (QREFELT $ 58)))
                                            (QREFELT $ 11))
                                  (QREFELT $ 59)))
                           |d| |delta| $))))
             (LETT |lgp|
                   (SPADCALL |c|
                             (SPADCALL
                              (LETT |nrm|
                                    (SPADCALL (SPADCALL |e| 2 (QREFELT $ 49))
                                              (SPADCALL |delta|
                                                        (SPADCALL
                                                         (LETT |f| (QCDR |q|))
                                                         2 (QREFELT $ 49))
                                                        (QREFELT $ 11))
                                              (QREFELT $ 52)))
                              (QREFELT $ 10))
                             (QREFELT $ 11)))
             (LETT |s| (QCAR (LETT |sqr| (|IR2F;insqrt| |delta| $))))
             (LETT |pp| (LETT |nn| (|spadConstant| $ 42)))
             (COND
              ((>= (QCDR |sqr|) 0)
               (SEQ
                (LETT |sqrp|
                      (SPADCALL (QCAR |s|)
                                (SPADCALL (SPADCALL (QCDR |s|) (QREFELT $ 60))
                                          (QREFELT $ 62))
                                (QREFELT $ 11)))
                (EXIT
                 (LETT |pp|
                       (SPADCALL |lgp|
                                 (SPADCALL (SPADCALL |d| |sqrp| (QREFELT $ 11))
                                           (SPADCALL
                                            (SPADCALL
                                             (SPADCALL
                                              (SPADCALL
                                               (SPADCALL
                                                (SPADCALL 2 |e| (QREFELT $ 50))
                                                |f| (QREFELT $ 11))
                                               |nrm| (QREFELT $ 55))
                                              |sqrp| (QREFELT $ 11))
                                             (SPADCALL
                                              (SPADCALL
                                               (SPADCALL |e| 2 (QREFELT $ 49))
                                               (SPADCALL |delta|
                                                         (SPADCALL |f| 2
                                                                   (QREFELT $
                                                                            49))
                                                         (QREFELT $ 11))
                                               (QREFELT $ 41))
                                              |nrm| (QREFELT $ 55))
                                             (QREFELT $ 41))
                                            (QREFELT $ 10))
                                           (QREFELT $ 11))
                                 (QREFELT $ 41)))))))
             (COND
              ((<= (QCDR |sqr|) 0)
               (SEQ
                (LETT |sqrn|
                      (SPADCALL (QCAR |s|)
                                (SPADCALL
                                 (SPADCALL (SPADCALL (QCDR |s|) (QREFELT $ 59))
                                           (QREFELT $ 60))
                                 (QREFELT $ 62))
                                (QREFELT $ 11)))
                (EXIT
                 (LETT |nn|
                       (SPADCALL |lgp|
                                 (SPADCALL (SPADCALL |d| |sqrn| (QREFELT $ 11))
                                           (|IR2F;ilog| |e|
                                            (SPADCALL |f| |sqrn|
                                                      (QREFELT $ 11))
                                            |x| $)
                                           (QREFELT $ 11))
                                 (QREFELT $ 41)))))))
             (EXIT
              (COND ((> (QCDR |sqr|) 0) (LIST |pp|))
                    ((< (QCDR |sqr|) 0) (LIST |nn|))
                    (#2# (LIST |pp| |nn|)))))))))) 

(SDEFUN |IR2F;tantrick| ((|a| (F)) (|b| (F)) ($ (F)))
        (SPROG
         ((#1=#:G796 NIL) (|sa| #2=(|Union| (|Integer|) "failed")) (|sb| #2#))
         (SEQ
          (EXIT
           (COND
            ((QEQCAR (SPADCALL |a| (QREFELT $ 64)) 0)
             (SPADCALL 2
                       (SPADCALL
                        (SPADCALL (SPADCALL |b| |a| (QREFELT $ 55))
                                  (QREFELT $ 59))
                        (QREFELT $ 65))
                       (QREFELT $ 50)))
            ('T
             (SEQ (LETT |sb| (SPADCALL |b| (QREFELT $ 68)))
                  (COND
                   ((QEQCAR |sb| 0)
                    (PROGN
                     (LETT #1#
                           (SPADCALL 2
                                     (SPADCALL
                                      (SPADCALL |a| |b| (QREFELT $ 55))
                                      (QREFELT $ 65))
                                     (QREFELT $ 50)))
                     (GO #3=#:G795))))
                  (LETT |sa| (SPADCALL |a| (QREFELT $ 68)))
                  (COND
                   ((QEQCAR |sa| 0)
                    (PROGN
                     (LETT #1#
                           (SPADCALL 2
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL |b| |a| (QREFELT $ 55))
                                       (QREFELT $ 59))
                                      (QREFELT $ 65))
                                     (QREFELT $ 50)))
                     (GO #3#))))
                  (EXIT
                   (SPADCALL 2
                             (SPADCALL (SPADCALL |a| |b| (QREFELT $ 55))
                                       (QREFELT $ 65))
                             (QREFELT $ 50)))))))
          #3# (EXIT #1#)))) 

(SDEFUN |IR2F;var_kers|
        ((|p| (|SparseMultivariatePolynomial| R (|Kernel| F))) (|x| (|Symbol|))
         ($ (|List| (|Kernel| F))))
        (SPROG ((#1=#:G804 NIL) (|k| NIL) (#2=#:G803 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |k| NIL) (LETT #1# (SPADCALL |p| (QREFELT $ 71)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |k| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (COND
                         ((SPADCALL
                           (SPADCALL (SPADCALL |k| (QREFELT $ 73)) |x|
                                     (QREFELT $ 74))
                           (|spadConstant| $ 42) (QREFELT $ 75))
                          (LETT #2# (CONS |k| #2#))))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |IR2F;ilog| ((|a| (F)) (|b| (F)) (|x| (|Symbol|)) ($ (F)))
        (SPROG
         ((|opk| (|BasicOperator|)) (|k| (|Kernel| F))
          (|l| (|List| (|Kernel| F))))
         (SEQ
          (COND
           ((SPADCALL |b| (|spadConstant| $ 42) (QREFELT $ 76))
            (|spadConstant| $ 42))
           (#1='T
            (SEQ
             (COND
              ((NULL (|IR2F;var_kers| (SPADCALL |a| (QREFELT $ 78)) |x| $))
               (COND
                ((NULL
                  (NULL (|IR2F;var_kers| (SPADCALL |b| (QREFELT $ 78)) |x| $)))
                 (EXIT (|IR2F;tantrick| |a| |b| $)))))
              (#1# (EXIT (|IR2F;tantrick| |a| |b| $))))
             (LETT |l|
                   (SPADCALL
                    (|IR2F;var_kers| (SPADCALL |a| (QREFELT $ 79)) |x| $)
                    (|IR2F;var_kers| (SPADCALL |b| (QREFELT $ 79)) |x| $)
                    (QREFELT $ 80)))
             (EXIT
              (COND
               ((SPADCALL (LENGTH |l|) 1 (QREFELT $ 81))
                (|IR2F;tantrick| |a| |b| $))
               (#1#
                (SEQ (LETT |k| (|SPADfirst| |l|))
                     (LETT |opk| (SPADCALL |k| (QREFELT $ 83)))
                     (COND
                      ((OR (SPADCALL |opk| '|tan| (QREFELT $ 84))
                           (SPADCALL |opk| '|%alg| (QREFELT $ 85)))
                       (EXIT (|IR2F;tantrick| |a| |b| $))))
                     (EXIT
                      (|IR2F;ilog0| |a| |b|
                       (SPADCALL (SPADCALL |a| |k| (QREFELT $ 87))
                                 (QREFELT $ 89))
                       (SPADCALL (SPADCALL |b| |k| (QREFELT $ 87))
                                 (QREFELT $ 89))
                       (SPADCALL |k| (QREFELT $ 73)) $)))))))))))) 

(SDEFUN |IR2F;ilog0|
        ((|a| (F)) (|b| (F)) (|upa| #1=(|SparseUnivariatePolynomial| F))
         (|upb| (|SparseUnivariatePolynomial| F)) (|k| (F)) ($ (F)))
        (SPROG
         ((|bb| (F)) (|aa| (F))
          (|qr|
           (|Record| (|:| |quotient| (|SparseUnivariatePolynomial| F))
                     (|:| |remainder| (|SparseUnivariatePolynomial| F))))
          (|g| (|Union| F "failed"))
          (|r|
           (|Record| (|:| |coef1| (|SparseUnivariatePolynomial| F))
                     (|:| |coef2| (|SparseUnivariatePolynomial| F))
                     (|:| |generator| (|SparseUnivariatePolynomial| F))))
          (|#G37| (F)) (|#G36| (F)) (|#G35| #1#)
          (|#G34| (|SparseUnivariatePolynomial| F)))
         (SEQ
          (COND
           ((< (SPADCALL |upa| (QREFELT $ 90)) (SPADCALL |upb| (QREFELT $ 90)))
            (SEQ
             (PROGN
              (LETT |#G34| (SPADCALL |upb| (QREFELT $ 91)))
              (LETT |#G35| |upa|)
              (LETT |upa| |#G34|)
              (LETT |upb| |#G35|))
             (EXIT
              (PROGN
               (LETT |#G36| (SPADCALL |b| (QREFELT $ 59)))
               (LETT |#G37| |a|)
               (LETT |a| |#G36|)
               (LETT |b| |#G37|))))))
          (EXIT
           (COND
            ((ZEROP (SPADCALL |upb| (QREFELT $ 90)))
             (|IR2F;tantrick| |a| |b| $))
            (#2='T
             (SEQ (LETT |r| (SPADCALL |upa| |upb| (QREFELT $ 93)))
                  (LETT |g| (SPADCALL (QVELT |r| 2) (QREFELT $ 95)))
                  (EXIT
                   (COND ((QEQCAR |g| 1) (|IR2F;tantrick| |a| |b| $))
                         (#2#
                          (SEQ
                           (COND
                            ((>= (SPADCALL (QVELT |r| 0) (QREFELT $ 90))
                                 (SPADCALL |upb| (QREFELT $ 90)))
                             (SEQ
                              (LETT |qr|
                                    (SPADCALL (QVELT |r| 0) |upb|
                                              (QREFELT $ 97)))
                              (QSETVELT |r| 0 (QCDR |qr|))
                              (EXIT
                               (QSETVELT |r| 1
                                         (SPADCALL (QVELT |r| 1)
                                                   (SPADCALL (QCAR |qr|) |upa|
                                                             (QREFELT $ 98))
                                                   (QREFELT $ 57)))))))
                           (LETT |aa|
                                 (SPADCALL (QVELT |r| 1) |k| (QREFELT $ 9)))
                           (LETT |bb|
                                 (SPADCALL
                                  (SPADCALL (QVELT |r| 0) |k| (QREFELT $ 9))
                                  (QREFELT $ 59)))
                           (EXIT
                            (SPADCALL
                             (|IR2F;tantrick|
                              (SPADCALL (SPADCALL |aa| |a| (QREFELT $ 11))
                                        (SPADCALL |bb| |b| (QREFELT $ 11))
                                        (QREFELT $ 41))
                              (QCDR |g|) $)
                             (|IR2F;ilog0| |aa| |bb| (QVELT |r| 1)
                              (SPADCALL (QVELT |r| 0) (QREFELT $ 91)) |k| $)
                             (QREFELT $ 41)))))))))))))) 

(SDEFUN |IR2F;lg2func|
        ((|lg|
          (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                    (|:| |coeff| #1=(|SparseUnivariatePolynomial| F))
                    (|:| |logand| (|SparseUnivariatePolynomial| F))))
         (|x| (|Symbol|)) ($ (|List| F)))
        (SPROG
         ((#2=#:G837 NIL) (#3=#:G830 NIL) (|alpha| (F))
          (|r| (|Union| F "failed")) (|d| (|NonNegativeInteger|)) (|p| #1#))
         (SEQ
          (COND
           ((ZEROP
             (LETT |d| (SPADCALL (LETT |p| (QVELT |lg| 1)) (QREFELT $ 90))))
            (|error| "poly has degree 0"))
           ((EQL |d| 1) (LIST (|IR2F;linear| |p| (QVELT |lg| 2) $)))
           ((EQL |d| 2) (|IR2F;quadratic| |p| (QVELT |lg| 2) |x| $))
           ('T
            (SEQ
             (EXIT
              (SEQ
               (COND
                ((ODDP |d|)
                 (SEQ
                  (LETT |r|
                        (SPADCALL (SPADCALL |p| (QREFELT $ 99))
                                  (QREFELT $ 95)))
                  (EXIT
                   (COND
                    ((QEQCAR |r| 0)
                     (PROGN
                      (LETT #2#
                            (|IR2F;pairsum|
                             (LIST
                              (|IR2F;cmplex|
                               (LETT |alpha|
                                     (SPADCALL (SPADCALL |p| (QREFELT $ 101))
                                               (QREFELT $ 62)))
                               (QVELT |lg| 2) $))
                             (|IR2F;lg2func|
                              (VECTOR (QVELT |lg| 0)
                                      (PROG2
                                          (LETT #3#
                                                (SPADCALL |p|
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (|spadConstant| $
                                                                            45)
                                                            1 (QREFELT $ 54))
                                                           (SPADCALL |alpha|
                                                                     (QREFELT $
                                                                              56))
                                                           (QREFELT $ 102))
                                                          (QREFELT $ 104)))
                                          (QCDR #3#)
                                        (|check_union2| (QEQCAR #3# 0)
                                                        (|SparseUnivariatePolynomial|
                                                         (QREFELT $ 7))
                                                        (|Union|
                                                         (|SparseUnivariatePolynomial|
                                                          (QREFELT $ 7))
                                                         "failed")
                                                        #3#))
                                      (QVELT |lg| 2))
                              |x| $)
                             $))
                      (GO #4=#:G834))))))))
               (EXIT (LIST (|IR2F;lg2cfunc| |lg| $)))))
             #4# (EXIT #2#))))))) 

(SDEFUN |IR2F;lg2cfunc|
        ((|lg|
          (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                    (|:| |coeff| (|SparseUnivariatePolynomial| F))
                    (|:| |logand| (|SparseUnivariatePolynomial| F))))
         ($ (F)))
        (SPROG
         ((#1=#:G843 NIL) (#2=#:G842 (F)) (#3=#:G844 (F)) (#4=#:G846 NIL)
          (|alpha| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |alpha| NIL)
                (LETT #4# (SPADCALL (QVELT |lg| 1) (QREFELT $ 105))) G190
                (COND
                 ((OR (ATOM #4#) (PROGN (LETT |alpha| (CAR #4#)) NIL))
                  (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #3# (|IR2F;cmplex| |alpha| (QVELT |lg| 2) $))
                   (COND (#1# (LETT #2# (SPADCALL #2# #3# (QREFELT $ 41))))
                         ('T (PROGN (LETT #2# #3#) (LETT #1# 'T)))))))
                (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 42))))))) 

(SDEFUN |IR2F;mkRealFunc|
        ((|l|
          (|List|
           (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                     (|:| |coeff| (|SparseUnivariatePolynomial| F))
                     (|:| |logand| (|SparseUnivariatePolynomial| F)))))
         (|x| (|Symbol|)) ($ (|List| F)))
        (SPROG ((|ans| (|List| F)) (#1=#:G852 NIL) (|lg| NIL))
               (SEQ (LETT |ans| NIL)
                    (SEQ (LETT |lg| NIL) (LETT #1# |l|) G190
                         (COND
                          ((OR (ATOM #1#) (PROGN (LETT |lg| (CAR #1#)) NIL))
                           (GO G191)))
                         (SEQ
                          (EXIT
                           (LETT |ans|
                                 (|IR2F;pairsum| |ans|
                                  (|IR2F;pairprod|
                                   (SPADCALL (QVELT |lg| 0) (QREFELT $ 40))
                                   (|IR2F;lg2func| |lg| |x| $) $)
                                  $))))
                         (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                    (EXIT |ans|)))) 

(SDEFUN |IR2F;linear|
        ((|p| (|SparseUnivariatePolynomial| F))
         (|lg| (|SparseUnivariatePolynomial| F)) ($ (F)))
        (SPROG ((|alpha| (F)))
               (SEQ
                (LETT |alpha|
                      (SPADCALL
                       (SPADCALL (SPADCALL |p| 0 (QREFELT $ 47))
                                 (SPADCALL |p| 1 (QREFELT $ 47))
                                 (QREFELT $ 55))
                       (QREFELT $ 59)))
                (EXIT
                 (SPADCALL |alpha|
                           (SPADCALL (SPADCALL |lg| |alpha| (QREFELT $ 9))
                                     (QREFELT $ 10))
                           (QREFELT $ 11)))))) 

(SDEFUN |IR2F;quadeval|
        ((|p| (|SparseUnivariatePolynomial| F)) (|a| (F)) (|b| (F))
         (|delta| (F)) ($ (|Record| (|:| |ans1| F) (|:| |ans2| F))))
        (SPROG
         ((|ai| (F)) (|bi| (F)) (|temp| (F)) (|d| (F)) (|c| (F))
          (#1=#:G864 NIL) (|i| NIL) (|v| (|Vector| F)))
         (SEQ
          (COND
           ((SPADCALL |p| (QREFELT $ 106))
            (CONS (|spadConstant| $ 42) (|spadConstant| $ 42)))
           ('T
            (SEQ (LETT |bi| (LETT |c| (LETT |d| (|spadConstant| $ 42))))
                 (LETT |ai| (|spadConstant| $ 45))
                 (LETT |v|
                       (SPADCALL |p| (+ 1 (SPADCALL |p| (QREFELT $ 90)))
                                 (QREFELT $ 108)))
                 (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 109)))
                      (LETT #1# (QVSIZE |v|)) G190
                      (COND ((> |i| #1#) (GO G191)))
                      (SEQ
                       (LETT |c|
                             (SPADCALL |c|
                                       (SPADCALL (QAREF1O |v| |i| 1) |ai|
                                                 (QREFELT $ 11))
                                       (QREFELT $ 41)))
                       (LETT |d|
                             (SPADCALL |d|
                                       (SPADCALL (QAREF1O |v| |i| 1) |bi|
                                                 (QREFELT $ 11))
                                       (QREFELT $ 41)))
                       (LETT |temp|
                             (SPADCALL (SPADCALL |a| |ai| (QREFELT $ 11))
                                       (SPADCALL
                                        (SPADCALL |b| |bi| (QREFELT $ 11))
                                        |delta| (QREFELT $ 11))
                                       (QREFELT $ 41)))
                       (LETT |bi|
                             (SPADCALL (SPADCALL |a| |bi| (QREFELT $ 11))
                                       (SPADCALL |b| |ai| (QREFELT $ 11))
                                       (QREFELT $ 41)))
                       (EXIT (LETT |ai| |temp|)))
                      (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                 (EXIT (CONS |c| |d|)))))))) 

(SDEFUN |IR2F;compatible?|
        ((|lx| (|List| F)) (|ly| (|List| F)) ($ (|Boolean|)))
        (SPROG
         ((#1=#:G877 NIL) (#2=#:G878 NIL) (|s| (|Union| (|Integer|) "failed"))
          (#3=#:G880 NIL) (|y| NIL) (#4=#:G879 NIL) (|x| NIL))
         (SEQ
          (EXIT
           (COND ((NULL |ly|) 'T)
                 ('T
                  (SEQ
                   (SEQ (LETT |x| NIL) (LETT #4# |lx|) G190
                        (COND
                         ((OR (ATOM #4#) (PROGN (LETT |x| (CAR #4#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (SEQ (LETT |y| NIL) (LETT #3# |ly|) G190
                               (COND
                                ((OR (ATOM #3#)
                                     (PROGN (LETT |y| (CAR #3#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (LETT |s|
                                      (SPADCALL
                                       (SPADCALL |x| |y| (QREFELT $ 11))
                                       (QREFELT $ 68)))
                                (EXIT
                                 (COND
                                  ((QEQCAR |s| 0)
                                   (COND
                                    ((< (QCDR |s|) 0)
                                     (PROGN
                                      (LETT #1#
                                            (PROGN
                                             (LETT #2# NIL)
                                             (GO #5=#:G876)))
                                      (GO #6=#:G872))))))))
                               (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL)))
                         #6# (EXIT #1#))
                        (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT NIL))
                   (EXIT 'T)))))
          #5# (EXIT #2#)))) 

(SDEFUN |IR2F;pairsum| ((|lx| (|List| F)) (|ly| (|List| F)) ($ (|List| F)))
        (SPROG
         ((|l| (|List| F)) (|ln| (|List| F)) (#1=#:G892 NIL) (|y| NIL)
          (#2=#:G891 NIL) (|ls| (|List| F)) (#3=#:G890 NIL) (|x| NIL))
         (SEQ
          (COND ((NULL |lx|) |ly|) ((NULL |ly|) |lx|)
                (#4='T
                 (SEQ (LETT |l| NIL)
                      (SEQ (LETT |x| NIL) (LETT #3# |lx|) G190
                           (COND
                            ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                             (GO G191)))
                           (SEQ (LETT |ls| (|IR2F;evenRoots| |x| $))
                                (EXIT
                                 (COND
                                  ((NULL
                                    (NULL
                                     (LETT |ln|
                                           (PROGN
                                            (LETT #2# NIL)
                                            (SEQ (LETT |y| NIL) (LETT #1# |ly|)
                                                 G190
                                                 (COND
                                                  ((OR (ATOM #1#)
                                                       (PROGN
                                                        (LETT |y| (CAR #1#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (COND
                                                    ((|IR2F;compatible?| |ls|
                                                      (|IR2F;evenRoots| |y| $)
                                                      $)
                                                     (LETT #2#
                                                           (CONS
                                                            (SPADCALL |x| |y|
                                                                      (QREFELT
                                                                       $ 41))
                                                            #2#))))))
                                                 (LETT #1# (CDR #1#)) (GO G190)
                                                 G191
                                                 (EXIT (NREVERSE #2#)))))))
                                   (LETT |l|
                                         (SPADCALL
                                          (SPADCALL |l| |ln| (QREFELT $ 110))
                                          (QREFELT $ 111)))))))
                           (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (COND
                        ((NULL |l|)
                         (LIST
                          (SPADCALL (|SPADfirst| |lx|) (|SPADfirst| |ly|)
                                    (QREFELT $ 41))))
                        (#4# |l|))))))))) 

(SDEFUN |IR2F;insqrt|
        ((|y| (F))
         ($
          (|Record| (|:| |sqrt| (|Record| (|:| |ans1| F) (|:| |ans2| F)))
                    (|:| |sgn| (|Integer|)))))
        (SPROG
         ((|s| (|Union| (|Integer|) "failed"))
          (|rec|
           (|Record| (|:| |exponent| (|NonNegativeInteger|)) (|:| |coef| F)
                     (|:| |radicand| F))))
         (SEQ (LETT |rec| (SPADCALL |y| 2 (QREFELT $ 114)))
              (EXIT
               (COND
                ((EQL (QVELT |rec| 0) 1)
                 (CONS
                  (CONS
                   (SPADCALL (QVELT |rec| 1) (QVELT |rec| 2) (QREFELT $ 11))
                   (|spadConstant| $ 45))
                  1))
                ((SPADCALL (QVELT |rec| 0) 2 (QREFELT $ 81))
                 (|error| "Should not happen"))
                (#1='T
                 (CONS (CONS (QVELT |rec| 1) (QVELT |rec| 2))
                       (SEQ
                        (LETT |s| (SPADCALL (QVELT |rec| 2) (QREFELT $ 68)))
                        (EXIT
                         (COND ((QEQCAR |s| 1) 0) (#1# (QCDR |s|)))))))))))) 

(SDEFUN |IR2F;nlogs|
        ((|lg|
          (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                    (|:| |coeff| (|SparseUnivariatePolynomial| F))
                    (|:| |logand| (|SparseUnivariatePolynomial| F))))
         ($
          (|List|
           (|Record| (|:| |scalar| (|Fraction| (|Integer|)))
                     (|:| |coeff| (|SparseUnivariatePolynomial| F))
                     (|:| |logand| (|SparseUnivariatePolynomial| F))))))
        (SPROG ((#1=#:G918 NIL) (|f| NIL) (#2=#:G917 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |f| NIL)
                      (LETT #1#
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL (QVELT |lg| 1) (QREFELT $ 115))
                              (QREFELT $ 118))
                             (QREFELT $ 122)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (VECTOR
                                (SPADCALL (QVELT |f| 2) (QVELT |lg| 0)
                                          (QREFELT $ 123))
                                (QVELT |f| 1) (QVELT |lg| 2))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(DECLAIM (NOTINLINE |IntegrationResultToFunction;|)) 

(DEFUN |IntegrationResultToFunction| (&REST #1=#:G919)
  (SPROG NIL
         (PROG (#2=#:G920)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|IntegrationResultToFunction|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |IntegrationResultToFunction;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|IntegrationResultToFunction|)))))))))) 

(DEFUN |IntegrationResultToFunction;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|IntegrationResultToFunction| DV$1 DV$2))
          (LETT $ (GETREFV 124))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|IntegrationResultToFunction|
                      (LIST DV$1 DV$2) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|IntegrationResultToFunction| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|SparseUnivariatePolynomial| 7) (0 . |elt|) (6 . |log|) (11 . *)
              (|IntegrationResult| 7) (17 . |ratpart|)
              (|Record| (|:| |integrand| 7) (|:| |intvar| 7)) (|List| 14)
              (22 . |notelem|)
              (|Record| (|:| |scalar| 39) (|:| |coeff| 8) (|:| |logand| 8))
              (|List| 17) (27 . |mkAnswer|) (34 . |retract|) (|List| 72)
              (39 . |tower|) (|Boolean|) (|Symbol|) (|Kernel| 7) (44 . |is?|)
              (|List| 7) (50 . |argument|) (55 . |second|) (|Integer|)
              (60 . |retract|) (|List| 24) (65 . |variables|)
              |IR2F;split;2Ir;6| (70 . |logpart|) |IR2F;expand;IrSL;5|
              (|List| $) (75 . |concat|) (|Fraction| 30) (80 . |coerce|)
              (85 . +) (91 . |Zero|) |IR2F;complexExpand;IrF;7| (95 . |One|)
              (99 . |One|) (|NonNegativeInteger|) (103 . |coefficient|)
              (|PositiveInteger|) (109 . ^) (115 . *) (121 . |Zero|) (125 . -)
              (131 . |zero?|) (136 . |monomial|) (142 . /) (148 . |coerce|)
              (153 . +) (159 . |inv|) (164 . -) (169 . |sqrt|)
              (|AlgebraicManipulations| 6 7) (174 . |rootSimp|)
              (|Union| 39 '"failed") (179 . |retractIfCan|) (184 . |atan|)
              (|Union| 30 '"failed") (|ElementaryFunctionSign| 6 7)
              (189 . |sign|) (|List| 25) (|SparseMultivariatePolynomial| 6 25)
              (194 . |variables|) (|Kernel| $) (199 . |coerce|) (204 . D)
              (210 . ~=) (216 . =) (|SparseMultivariatePolynomial| 6 72)
              (222 . |denom|) (227 . |numer|) (232 . |setUnion|) (238 . ~=)
              (|BasicOperator|) (244 . |operator|) (249 . |is?|) (255 . |has?|)
              (|Fraction| 100) (261 . |univariate|) (|Fraction| 8)
              (267 . |numer|) (272 . |degree|) (277 . -)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (282 . |extendedEuclidean|) (|Union| 7 '"failed")
              (288 . |retractIfCan|)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (293 . |divide|) (299 . *) (305 . |reductum|)
              (|SparseUnivariatePolynomial| $) (310 . |zeroOf|) (315 . -)
              (|Union| $ '"failed") (321 . |exquo|) (327 . |zerosOf|)
              (332 . |zero?|) (|Vector| 7) (337 . |vectorise|)
              (343 . |minIndex|) (348 . |concat|) (354 . |removeDuplicates|)
              (|Record| (|:| |exponent| 46) (|:| |coef| 7) (|:| |radicand| 7))
              (|PolynomialRoots| (|IndexedExponents| 25) 25 6 70 7)
              (359 . |froot|) (365 . |primitivePart|) (|Factored| 8)
              (|ExpressionFactorPolynomial| 6 7) (370 . |factorPolynomial|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 119) (|:| |factor| 8) (|:| |exponent| 46))
              (|List| 120) (375 . |factorList|) (380 . *))
           '#(|split| 386 |expand| 391 |complexExpand| 397) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|split|
                                 ((|IntegrationResult| |#2|)
                                  (|IntegrationResult| |#2|)))
                                T)
                              '((|expand|
                                 ((|List| |#2|) (|IntegrationResult| |#2|)
                                  (|Symbol|)))
                                T)
                              '((|complexExpand|
                                 (|#2| (|IntegrationResult| |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 123
                                            '(2 8 7 0 7 9 1 7 0 0 10 2 7 0 0 0
                                              11 1 12 7 0 13 1 12 15 0 16 3 12
                                              0 7 18 15 19 1 12 7 0 20 1 7 21 0
                                              22 2 25 23 0 24 26 1 25 27 0 28 1
                                              27 7 0 29 1 7 30 0 31 1 7 32 0 33
                                              1 12 18 0 35 1 18 0 37 38 1 7 0
                                              39 40 2 7 0 0 0 41 0 7 0 42 0 6 0
                                              44 0 7 0 45 2 8 7 0 46 47 2 7 0 0
                                              48 49 2 7 0 48 0 50 0 6 0 51 2 7
                                              0 0 0 52 1 7 23 0 53 2 8 0 7 46
                                              54 2 7 0 0 0 55 1 8 0 7 56 2 8 0
                                              0 0 57 1 7 0 0 58 1 7 0 0 59 1 7
                                              0 0 60 1 61 7 7 62 1 7 63 0 64 1
                                              7 0 0 65 1 67 66 7 68 1 70 69 0
                                              71 1 7 0 72 73 2 7 0 0 24 74 2 7
                                              23 0 0 75 2 7 23 0 0 76 1 7 77 0
                                              78 1 7 77 0 79 2 69 0 0 0 80 2 46
                                              23 0 0 81 1 25 82 0 83 2 82 23 0
                                              24 84 2 82 23 0 24 85 2 7 86 0 72
                                              87 1 88 8 0 89 1 8 46 0 90 1 8 0
                                              0 91 2 8 92 0 0 93 1 8 94 0 95 2
                                              8 96 0 0 97 2 8 0 0 0 98 1 8 0 0
                                              99 1 7 0 100 101 2 8 0 0 0 102 2
                                              8 103 0 0 104 1 7 37 100 105 1 8
                                              23 0 106 2 8 107 0 46 108 1 107
                                              30 0 109 2 27 0 0 0 110 1 27 0 0
                                              111 2 113 112 7 46 114 1 8 0 0
                                              115 1 117 116 8 118 1 116 121 0
                                              122 2 39 0 46 0 123 1 0 12 12 34
                                              2 0 27 12 24 36 1 0 7 12 43)))))
           '|lookupComplete|)) 
