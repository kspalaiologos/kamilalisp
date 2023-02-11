
(SDEFUN |PFO;torsion?;FdB;1|
        ((|d| (|FiniteDivisor| F UP UPUP R)) ($ (|Boolean|)))
        (QEQCAR (SPADCALL |d| (QREFELT $ 15)) 0)) 

(SDEFUN |PFO;Q2F| ((|x| (|Fraction| (|Integer|))) ($ (F)))
        (SPADCALL (SPADCALL (SPADCALL |x| (QREFELT $ 20)) (QREFELT $ 21))
                  (SPADCALL (SPADCALL |x| (QREFELT $ 22)) (QREFELT $ 21))
                  (QREFELT $ 23))) 

(SDEFUN |PFO;Q2UPUP|
        ((|p|
          (|SparseUnivariatePolynomial|
           (|Fraction|
            (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
         ($ (UPUP)))
        (SPADCALL (CONS (|function| |PFO;Q2F|) $) |p| (QREFELT $ 27))) 

(SDEFUN |PFO;raise|
        ((|p| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
         (|k| (|Kernel| F)) ($ (F)))
        (SPADCALL (SPADCALL (CONS (|function| |PFO;Q2F|) $) |p| (QREFELT $ 31))
                  (SPADCALL |k| (QREFELT $ 33)) (QREFELT $ 34))) 

(SDEFUN |PFO;raise2|
        ((|p|
          (|SparseUnivariatePolynomial|
           (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
         (|k| (|Kernel| F)) ($ (UP)))
        (SPROG NIL
               (SPADCALL (CONS #'|PFO;raise2!0| (VECTOR $ |k|)) |p|
                         (QREFELT $ 38)))) 

(SDEFUN |PFO;raise2!0| ((|z1| NIL) ($$ NIL))
        (PROG (|k| $)
          (LETT |k| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|PFO;raise| |z1| |k| $))))) 

(SDEFUN |PFO;qmod| ((|x| (F)) ($ (|Fraction| (|Integer|))))
        (SPADCALL |x| (QREFELT $ 39))) 

(SDEFUN |PFO;fmod|
        ((|p| (|SparseUnivariatePolynomial| F))
         ($ (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
        (SPADCALL (CONS (|function| |PFO;qmod|) $) |p| (QREFELT $ 42))) 

(SDEFUN |PFO;pmod|
        ((|p| (UPUP))
         ($
          (|SparseUnivariatePolynomial|
           (|Fraction|
            (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))))
        (SPADCALL (CONS (|function| |PFO;qmod|) $) |p| (QREFELT $ 44))) 

(SDEFUN |PFO;rmod|
        ((|p| (UP))
         ($ (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
        (SPADCALL (CONS (|function| |PFO;qmod|) $) |p| (QREFELT $ 46))) 

(SDEFUN |PFO;kqmod|
        ((|x| (F)) (|k| (|Kernel| F))
         ($ (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
        (SPADCALL |x| |k| (QREFELT $ 48))) 

(SDEFUN |PFO;krmod|
        ((|p| (UP)) (|k| (|Kernel| F))
         ($
          (|SparseUnivariatePolynomial|
           (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
        (SPROG NIL
               (SPADCALL (CONS #'|PFO;krmod!0| (VECTOR $ |k|)) |p|
                         (QREFELT $ 51)))) 

(SDEFUN |PFO;krmod!0| ((|z1| NIL) ($$ NIL))
        (PROG (|k| $)
          (LETT |k| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|PFO;kqmod| |z1| |k| $))))) 

(SDEFUN |PFO;kpmod|
        ((|p| (UPUP)) (|k| (|Kernel| F))
         ($
          (|SparseUnivariatePolynomial|
           (|SparseUnivariatePolynomial|
            (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))))
        (SPROG NIL
               (SPADCALL (CONS #'|PFO;kpmod!0| (VECTOR |k| $)) |p|
                         (QREFELT $ 57)))) 

(SDEFUN |PFO;kpmod!0| ((|p1| NIL) ($$ NIL))
        (PROG ($ |k|)
          (LETT $ (QREFELT $$ 1))
          (LETT |k| (QREFELT $$ 0))
          (RETURN (PROGN (|PFO;krmod| (SPADCALL |p1| (QREFELT $ 53)) |k| $))))) 

(SDEFUN |PFO;klist| ((|d| (UP)) ($ (|List| (|Kernel| F))))
        (SPADCALL (SPADCALL |d| (QREFELT $ 59)) (QREFELT $ 62))) 

(SDEFUN |PFO;notIrr?|
        ((|d| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
         ($ (|Boolean|)))
        (> (LENGTH (SPADCALL (SPADCALL |d| (QREFELT $ 65)) (QREFELT $ 69))) 1)) 

(SDEFUN |PFO;kbadBadNum|
        ((|d|
          (|SparseUnivariatePolynomial|
           (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
         (|m| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
         ($ (|Integer|)))
        (SPROG ((#1=#:G773 NIL) (|c| NIL) (#2=#:G772 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |c| NIL) (LETT #1# (SPADCALL |d| (QREFELT $ 72)))
                       G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS
                                (SPADCALL (SPADCALL |c| |m| (QREFELT $ 73))
                                          (QREFELT $ 76))
                                #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 78))))) 

(SDEFUN |PFO;kbad3Num|
        ((|h|
          (|SparseUnivariatePolynomial|
           (|SparseUnivariatePolynomial|
            (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
         (|m| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
         ($ (|Integer|)))
        (SPROG ((#1=#:G778 NIL) (|c| NIL) (#2=#:G777 NIL))
               (SEQ
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |c| NIL) (LETT #1# (SPADCALL |h| (QREFELT $ 80)))
                       G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2# (CONS (|PFO;kbadBadNum| |c| |m| $) #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 81))))) 

(SDEFUN |PFO;torsionIfCan;FdU;17|
        ((|d| (|FiniteDivisor| F UP UPUP R))
         ($
          (|Union|
           (|Record| (|:| |order| (|NonNegativeInteger|)) (|:| |function| R))
           "failed")))
        (SPROG ((|g| (|Union| R "failed")) (|n| (|NonNegativeInteger|)))
               (SEQ
                (COND
                 ((ZEROP
                   (LETT |n|
                         (SPADCALL (LETT |d| (SPADCALL |d| (QREFELT $ 82)))
                                   (QREFELT $ 84))))
                  (CONS 1 "failed"))
                 (#1='T
                  (SEQ
                   (LETT |g|
                         (SPADCALL
                          (SPADCALL (SPADCALL |n| |d| (QREFELT $ 85))
                                    (QREFELT $ 82))
                          (QREFELT $ 87)))
                   (EXIT
                    (COND ((QEQCAR |g| 1) (CONS 1 "failed"))
                          (#1# (CONS 0 (CONS |n| (QCDR |g|)))))))))))) 

(SDEFUN |PFO;UPQ2F|
        ((|p| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
         (|k| (|Kernel| F)) ($ (F)))
        (SPADCALL (SPADCALL (CONS (|function| |PFO;Q2F|) $) |p| (QREFELT $ 92))
                  (SPADCALL |k| (QREFELT $ 33)) (QREFELT $ 93))) 

(SDEFUN |PFO;UP22UP|
        ((|p|
          (|SparseUnivariatePolynomial|
           (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
         (|k| (|Kernel| F)) ($ (UP)))
        (SPROG NIL
               (SPADCALL (CONS #'|PFO;UP22UP!0| (VECTOR $ |k|)) |p|
                         (QREFELT $ 38)))) 

(SDEFUN |PFO;UP22UP!0| ((|p1| NIL) ($$ NIL))
        (PROG (|k| $)
          (LETT |k| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|PFO;UPQ2F| |p1| |k| $))))) 

(SDEFUN |PFO;UP32UPUP|
        ((|p|
          (|SparseUnivariatePolynomial|
           (|SparseUnivariatePolynomial|
            (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
         (|k| (|Kernel| F)) ($ (UPUP)))
        (SPROG NIL
               (SPADCALL (CONS #'|PFO;UP32UPUP!0| (VECTOR $ |k|)) |p|
                         (QREFELT $ 97)))) 

(SDEFUN |PFO;UP32UPUP!0| ((|p1| NIL) ($$ NIL))
        (PROG (|k| $)
          (LETT |k| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL (|PFO;UP22UP| |p1| |k| $) (QREFELT $ 94)))))) 

(SDEFUN |PFO;cmult;LSmp;21|
        ((|l| (|List| (|SparseMultivariatePolynomial| R0 (|Kernel| F))))
         ($ (|SparseMultivariatePolynomial| R0 (|Kernel| F))))
        (SPADCALL |l| (QREFELT $ 99))) 

(SDEFUN |PFO;cmult;LSmp;22|
        ((|l| (|List| (|SparseMultivariatePolynomial| R0 (|Kernel| F))))
         ($ (|SparseMultivariatePolynomial| R0 (|Kernel| F))))
        (SPROG
         ((#1=#:G802 NIL)
          (#2=#:G801 #3=(|SparseMultivariatePolynomial| R0 (|Kernel| F)))
          (#4=#:G803 #3#) (#5=#:G805 NIL) (#6=#:G689 NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT #6# NIL) (LETT #5# |l|) G190
                (COND
                 ((OR (ATOM #5#) (PROGN (LETT #6# (CAR #5#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #4# #6#)
                   (COND (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 102))))
                         ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|spadConstant| $ 103))))))) 

(SDEFUN |PFO;doubleDisc|
        ((|f|
          (|SparseUnivariatePolynomial|
           (|SparseUnivariatePolynomial|
            (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
         ($ (|Integer|)))
        (SPROG
         ((#1=#:G814 NIL) (|c| NIL) (#2=#:G813 NIL)
          (|e| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
          (|d|
           (|SparseUnivariatePolynomial|
            (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
          (#3=#:G807 NIL)
          (|g|
           (|SparseUnivariatePolynomial|
            (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
         (SEQ (LETT |d| (SPADCALL |f| (QREFELT $ 104)))
              (LETT |g|
                    (SPADCALL |d| (SPADCALL |d| (QREFELT $ 105))
                              (QREFELT $ 106)))
              (LETT |d|
                    (PROG2 (LETT #3# (SPADCALL |d| |g| (QREFELT $ 108)))
                        (QCDR #3#)
                      (|check_union2| (QEQCAR #3# 0)
                                      (|SparseUnivariatePolynomial|
                                       (|SparseUnivariatePolynomial|
                                        (|Fraction| (|Integer|))))
                                      (|Union|
                                       (|SparseUnivariatePolynomial|
                                        (|SparseUnivariatePolynomial|
                                         (|Fraction| (|Integer|))))
                                       "failed")
                                      #3#)))
              (EXIT
               (COND
                ((SPADCALL (LETT |e| (SPADCALL |d| (QREFELT $ 110)))
                           (QREFELT $ 111))
                 0)
                ('T
                 (SPADCALL
                  (PROGN
                   (LETT #2# NIL)
                   (SEQ (LETT |c| NIL)
                        (LETT #1# (SPADCALL |e| (QREFELT $ 113))) G190
                        (COND
                         ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                          (GO G191)))
                        (SEQ
                         (EXIT
                          (LETT #2#
                                (CONS (SPADCALL |c| (QREFELT $ 114)) #2#))))
                        (LETT #1# (CDR #1#)) (GO G190) G191
                        (EXIT (NREVERSE #2#))))
                  (QREFELT $ 115)))))))) 

(SDEFUN |PFO;commonDen|
        ((|p| (UP)) ($ (|SparseMultivariatePolynomial| R0 (|Kernel| F))))
        (SPROG
         ((|l2| (|List| (|SparseMultivariatePolynomial| R0 (|Kernel| F))))
          (#1=#:G820 NIL) (|c| NIL) (#2=#:G819 NIL) (|l1| (|List| F)))
         (SEQ (LETT |l1| (SPADCALL |p| (QREFELT $ 59)))
              (LETT |l2|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |c| NIL) (LETT #1# |l1|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS (SPADCALL |c| (QREFELT $ 117)) #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (EXIT (SPADCALL |l2| (QREFELT $ 101)))))) 

(SDEFUN |PFO;polyred| ((|f| (UPUP)) ($ (UPUP)))
        (SPROG ((#1=#:G1040 NIL) (|c| NIL) (#2=#:G1039 NIL))
               (SEQ
                (SPADCALL
                 (SPADCALL
                  (SPADCALL
                   (SPADCALL
                    (SPADCALL
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |c| NIL)
                           (LETT #1# (SPADCALL |f| (QREFELT $ 119))) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |c| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #2#
                                   (CONS
                                    (|PFO;commonDen|
                                     (SPADCALL |c| (QREFELT $ 53)) $)
                                    #2#))))
                           (LETT #1# (CDR #1#)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))
                     (QREFELT $ 101))
                    (QREFELT $ 120))
                   (QREFELT $ 121))
                  (QREFELT $ 94))
                 |f| (QREFELT $ 122))))) 

(SDEFUN |PFO;aklist| ((|f| (R)) ($ (|List| (|Kernel| F))))
        (SPROG
         ((#1=#:G1045 NIL) (#2=#:G1044 #3=(|List| (|Kernel| F)))
          (#4=#:G1046 #3#) (#5=#:G1049 NIL) (|c| NIL)
          (|r| (|Union| (|Fraction| UP) "failed")))
         (SEQ (LETT |r| (SPADCALL |f| (QREFELT $ 124)))
              (EXIT
               (COND
                ((QEQCAR |r| 1)
                 (PROGN
                  (LETT #1# NIL)
                  (SEQ (LETT |c| NIL)
                       (LETT #5#
                             (SPADCALL (SPADCALL |f| (QREFELT $ 125))
                                       (QREFELT $ 119)))
                       G190
                       (COND
                        ((OR (ATOM #5#) (PROGN (LETT |c| (CAR #5#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (PROGN
                          (LETT #4#
                                (|PFO;klist| (SPADCALL |c| (QREFELT $ 53)) $))
                          (COND
                           (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 127))))
                           ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                       (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                  (COND (#1# #2#) (#6='T (|IdentityError| '|setUnion|)))))
                (#6# (|PFO;klist| (SPADCALL (QCDR |r|) (QREFELT $ 53)) $))))))) 

(SDEFUN |PFO;alglist0|
        ((|d| (|FiniteDivisor| F UP UPUP R)) ($ (|List| (|Kernel| F))))
        (SPROG
         ((#1=#:G1054 NIL) (#2=#:G1053 #3=(|List| (|Kernel| F)))
          (#4=#:G1055 #3#) (#5=#:G1058 NIL)
          (|i| (|FractionalIdeal| UP (|Fraction| UP) UPUP R))
          (|n| (|Vector| R)))
         (SEQ
          (LETT |n|
                (SPADCALL (LETT |i| (SPADCALL |d| (QREFELT $ 129)))
                          (QREFELT $ 131)))
          (EXIT
           (SPADCALL (CONS #'|PFO;alglist0!0| (VECTOR (QREFELT $ 11) $))
                     (SPADCALL (|PFO;klist| (SPADCALL |i| (QREFELT $ 136)) $)
                               (PROGN
                                (LETT #1# NIL)
                                (SEQ (LETT |i| (SPADCALL |n| (QREFELT $ 137)))
                                     (LETT #5# (QVSIZE |n|)) G190
                                     (COND ((> |i| #5#) (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (PROGN
                                        (LETT #4#
                                              (|PFO;aklist| (QAREF1O |n| |i| 1)
                                               $))
                                        (COND
                                         (#1#
                                          (LETT #2#
                                                (SPADCALL #2# #4#
                                                          (QREFELT $ 127))))
                                         ('T
                                          (PROGN
                                           (LETT #2# #4#)
                                           (LETT #1# 'T)))))))
                                     (LETT |i| (+ |i| 1)) (GO G190) G191
                                     (EXIT NIL))
                                (COND (#1# #2#)
                                      ('T (|IdentityError| '|setUnion|))))
                               (QREFELT $ 127))
                     (QREFELT $ 139)))))) 

(SDEFUN |PFO;alglist0!0| ((|k1| NIL) ($$ NIL))
        (PROG ($ ALGOP)
          (LETT $ (QREFELT $$ 1))
          (LETT ALGOP (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |k1| (QREFELT $ 133)) ALGOP (QREFELT $ 135)))))) 

(SDEFUN |PFO;alglist|
        ((|d| (|FiniteDivisor| F UP UPUP R)) ($ (|List| (|Kernel| F))))
        (SPROG
         ((|l1| #1=(|List| (|Kernel| F))) (#2=#:G1060 NIL) (#3=#:G1059 #1#)
          (#4=#:G1061 #1#) (#5=#:G1064 NIL) (|c| NIL) (|f| (UPUP)))
         (SEQ (LETT |f| (SPADCALL (QREFELT $ 140)))
              (LETT |l1|
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |c| NIL)
                          (LETT #5# (SPADCALL |f| (QREFELT $ 119))) G190
                          (COND
                           ((OR (ATOM #5#) (PROGN (LETT |c| (CAR #5#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (PROGN
                             (LETT #4#
                                   (|PFO;klist| (SPADCALL |c| (QREFELT $ 53))
                                    $))
                             (COND
                              (#2#
                               (LETT #3# (SPADCALL #3# #4# (QREFELT $ 127))))
                              ('T (PROGN (LETT #3# #4#) (LETT #2# 'T)))))))
                          (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                     (COND (#2# #3#) ('T (|IdentityError| '|setUnion|)))))
              (EXIT (SPADCALL |l1| (|PFO;alglist0| |d| $) (QREFELT $ 127)))))) 

(SDEFUN |PFO;alglist2| ((|f| (UPUP)) ($ (|List| (|Kernel| F))))
        (SPROG
         ((#1=#:G1066 NIL) (#2=#:G1065 #3=(|List| (|Kernel| F)))
          (#4=#:G1067 #3#) (#5=#:G1069 NIL) (|c| NIL))
         (SEQ
          (PROGN
           (LETT #1# NIL)
           (SEQ (LETT |c| NIL) (LETT #5# (SPADCALL |f| (QREFELT $ 119))) G190
                (COND
                 ((OR (ATOM #5#) (PROGN (LETT |c| (CAR #5#)) NIL)) (GO G191)))
                (SEQ
                 (EXIT
                  (PROGN
                   (LETT #4# (|PFO;klist| (SPADCALL |c| (QREFELT $ 53)) $))
                   (COND (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 127))))
                         ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
           (COND (#1# #2#) ('T (|IdentityError| '|setUnion|))))))) 

(SDEFUN |PFO;alglist1|
        ((|nc| (UPUP)) (|nva| (|Vector| UPUP)) (|nd| (UPUP))
         ($ (|List| (|Kernel| F))))
        (SPROG
         ((#1=#:G1071 NIL) (#2=#:G1070 #3=(|List| (|Kernel| F)))
          (#4=#:G1072 #3#) (#5=#:G1075 NIL) (|f| NIL) (|l2| (|List| UPUP))
          (|l1| (|List| UPUP)))
         (SEQ (LETT |l1| (SPADCALL |nva| (QREFELT $ 143)))
              (LETT |l2| (CONS |nc| (CONS |nd| |l1|)))
              (EXIT
               (PROGN
                (LETT #1# NIL)
                (SEQ (LETT |f| NIL) (LETT #5# |l2|) G190
                     (COND
                      ((OR (ATOM #5#) (PROGN (LETT |f| (CAR #5#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (PROGN
                        (LETT #4# (|PFO;alglist2| |f| $))
                        (COND
                         (#1# (LETT #2# (SPADCALL #2# #4# (QREFELT $ 127))))
                         ('T (PROGN (LETT #2# #4#) (LETT #1# 'T)))))))
                     (LETT #5# (CDR #5#)) (GO G190) G191 (EXIT NIL))
                (COND (#1# #2#) ('T (|IdentityError| '|setUnion|)))))))) 

(SDEFUN |PFO;subst_mp_ni|
        ((|p| (|SparseMultivariatePolynomial| R0 (|Kernel| F))) (|ni| (F))
         ($ (F)))
        (SPADCALL
         (SPADCALL
          (SPADCALL (CONS #'|PFO;subst_mp_ni!0| $) |p| (QREFELT $ 148))
          (QREFELT $ 120))
         (SPADCALL |ni|
                   (SPADCALL
                    (SPADCALL (CONS #'|PFO;subst_mp_ni!1| $) |p|
                              (QREFELT $ 148))
                    (QREFELT $ 120))
                   (QREFELT $ 150))
         (QREFELT $ 151))) 

(SDEFUN |PFO;subst_mp_ni!1| ((|c| NIL) ($ NIL))
        (SPADCALL (SPADCALL |c| (QREFELT $ 149)) (QREFELT $ 146))) 

(SDEFUN |PFO;subst_mp_ni!0| ((|c| NIL) ($ NIL))
        (SPADCALL (SPADCALL |c| (QREFELT $ 145)) (QREFELT $ 146))) 

(SDEFUN |PFO;subst_upup_ni| ((|upup| (UPUP)) (|ni| (F)) ($ (UPUP)))
        (SPROG NIL
               (SPADCALL (CONS #'|PFO;subst_upup_ni!2| (VECTOR |ni| $)) |upup|
                         (QREFELT $ 158)))) 

(SDEFUN |PFO;subst_upup_ni!2| ((|a| NIL) ($$ NIL))
        (PROG ($ |ni|)
          (LETT $ (QREFELT $$ 1))
          (LETT |ni| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL (CONS #'|PFO;subst_upup_ni!1| (VECTOR $ |ni|)) |a|
                             (QREFELT $ 156))))))) 

(SDEFUN |PFO;subst_upup_ni!1| ((|b| NIL) ($$ NIL))
        (PROG (|ni| $)
          (LETT |ni| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL (CONS #'|PFO;subst_upup_ni!0| (VECTOR |ni| $)) |b|
                             (QREFELT $ 154))))))) 

(SDEFUN |PFO;subst_upup_ni!0| ((|c| NIL) ($$ NIL))
        (PROG ($ |ni|)
          (LETT $ (QREFELT $$ 1))
          (LETT |ni| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (|PFO;subst_mp_ni| (SPADCALL |c| (QREFELT $ 152)) |ni| $)
                      (|PFO;subst_mp_ni| (SPADCALL |c| (QREFELT $ 117)) |ni| $)
                      (QREFELT $ 23)))))) 

(SDEFUN |PFO;handle_imaginary;FdR;33|
        ((|fd| (|FiniteDivisor| F UP UPUP R))
         ($
          (|Record| (|:| |ncurve| UPUP) (|:| |n_div_numer| (|Vector| UPUP))
                    (|:| |n_div_denom| UPUP) (|:| |need_change| (|Boolean|)))))
        (SPROG
         ((|nd| (UPUP)) (|nva| (|Vector| UPUP)) (#1=#:G1297 NIL) (|vi| NIL)
          (#2=#:G1296 NIL) (|n| (|Vector| R))
          (|id| (|FractionalIdeal| UP (|Fraction| UP) UPUP R)) (|nf| (UPUP))
          (|f| (UPUP)) (|ni| (|Expression| R0))
          (|p0| (|SparseUnivariatePolynomial| F)))
         (SEQ
          (LETT |p0|
                (SPADCALL (SPADCALL (|spadConstant| $ 159) 2 (QREFELT $ 160))
                          (|spadConstant| $ 161) (QREFELT $ 162)))
          (LETT |ni| (SPADCALL |p0| (QREFELT $ 165)))
          (LETT |f| (SPADCALL (QREFELT $ 140)))
          (LETT |nf| (|PFO;subst_upup_ni| |f| |ni| $))
          (LETT |id| (SPADCALL |fd| (QREFELT $ 129)))
          (LETT |n| (SPADCALL |id| (QREFELT $ 131)))
          (LETT |nva|
                (SPADCALL
                 (PROGN
                  (LETT #2# NIL)
                  (SEQ (LETT |vi| NIL)
                       (LETT #1# (SPADCALL |n| (QREFELT $ 167))) G190
                       (COND
                        ((OR (ATOM #1#) (PROGN (LETT |vi| (CAR #1#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #2#
                               (CONS
                                (|PFO;subst_upup_ni|
                                 (SPADCALL |vi| (QREFELT $ 125)) |ni| $)
                                #2#))))
                       (LETT #1# (CDR #1#)) (GO G190) G191
                       (EXIT (NREVERSE #2#))))
                 (QREFELT $ 168)))
          (LETT |nd|
                (|PFO;subst_upup_ni|
                 (SPADCALL
                  (SPADCALL (SPADCALL |id| (QREFELT $ 136)) (QREFELT $ 94))
                  (QREFELT $ 169))
                 |ni| $))
          (EXIT (VECTOR |nf| |nva| |nd| (SPADCALL |f| |nf| (QREFELT $ 170))))))) 

(SDEFUN |PFO;handle_imaginary;FdR;34|
        ((|fd| (|FiniteDivisor| F UP UPUP R))
         ($
          (|Record| (|:| |ncurve| UPUP) (|:| |n_div_numer| (|Vector| UPUP))
                    (|:| |n_div_denom| UPUP) (|:| |need_change| (|Boolean|)))))
        (SPROG
         ((|nva| (|Vector| UPUP)) (#1=#:G1304 NIL) (|vi| NIL) (#2=#:G1303 NIL)
          (|d| (UP)) (|n| (|Vector| R))
          (|id| (|FractionalIdeal| UP (|Fraction| UP) UPUP R)))
         (SEQ (LETT |id| (SPADCALL |fd| (QREFELT $ 129)))
              (LETT |n| (SPADCALL |id| (QREFELT $ 131)))
              (LETT |d| (SPADCALL |id| (QREFELT $ 136)))
              (LETT |nva|
                    (SPADCALL
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |vi| NIL)
                           (LETT #1# (SPADCALL |n| (QREFELT $ 167))) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |vi| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #2#
                                   (CONS (SPADCALL |vi| (QREFELT $ 125))
                                         #2#))))
                           (LETT #1# (CDR #1#)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))
                     (QREFELT $ 168)))
              (EXIT
               (VECTOR (SPADCALL (QREFELT $ 140)) |nva|
                       (SPADCALL (SPADCALL |d| (QREFELT $ 94)) (QREFELT $ 169))
                       NIL))))) 

(SDEFUN |PFO;handle_imaginary;FdR;35|
        ((|fd| (|FiniteDivisor| F UP UPUP R))
         ($
          (|Record| (|:| |ncurve| UPUP) (|:| |n_div_numer| (|Vector| UPUP))
                    (|:| |n_div_denom| UPUP) (|:| |need_change| (|Boolean|)))))
        (SPROG
         ((|nva| (|Vector| UPUP)) (#1=#:G1311 NIL) (|vi| NIL) (#2=#:G1310 NIL)
          (|d| (UP)) (|n| (|Vector| R))
          (|id| (|FractionalIdeal| UP (|Fraction| UP) UPUP R)))
         (SEQ (LETT |id| (SPADCALL |fd| (QREFELT $ 129)))
              (LETT |n| (SPADCALL |id| (QREFELT $ 131)))
              (LETT |d| (SPADCALL |id| (QREFELT $ 136)))
              (LETT |nva|
                    (SPADCALL
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |vi| NIL)
                           (LETT #1# (SPADCALL |n| (QREFELT $ 167))) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |vi| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #2#
                                   (CONS (SPADCALL |vi| (QREFELT $ 125))
                                         #2#))))
                           (LETT #1# (CDR #1#)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))
                     (QREFELT $ 168)))
              (EXIT
               (VECTOR (SPADCALL (QREFELT $ 140)) |nva|
                       (SPADCALL (SPADCALL |d| (QREFELT $ 94)) (QREFELT $ 169))
                       NIL))))) 

(SDEFUN |PFO;UPQ_to_UPF|
        ((|p| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
         ($ (|SparseUnivariatePolynomial| F)))
        (SPADCALL (CONS (|function| |PFO;Q2F|) $) |p| (QREFELT $ 31))) 

(SDEFUN |PFO;algcurve|
        ((|d| (|FiniteDivisor| F UP UPUP R))
         (|rc|
          (|Record|
           (|:| |ncurve|
                (|SparseUnivariatePolynomial|
                 (|SparseUnivariatePolynomial|
                  (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
           (|:| |disc| (|Integer|))
           (|:| |dfpoly|
                (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
         (|k| (|Kernel| F)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|sae|
           (|Join|
            (|MonogenicAlgebra| |gf| (|SparseUnivariatePolynomial| |gf|))
            (CATEGORY |package|
             (IF (|has| |gf| (|Field|))
                 (IF (|has| |gf| (|PolynomialFactorizationExplicit|))
                     (ATTRIBUTE (|PolynomialFactorizationExplicit|))
                     |noBranch|)
                 |noBranch|))))
          (|alpha| (|gf|)) (|m| (|SparseUnivariatePolynomial| |gf|))
          (|gf|
           (|Join| (|FiniteFieldCategory|) (|FiniteAlgebraicExtensionField| $)
                   (|ConvertibleTo| (|Integer|))
                   (CATEGORY |domain| (SIGNATURE |sqrt| ($ $))
                    (SIGNATURE |quadraticNonResidue| ($)))))
          (|mm| #1=(|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
          (|pp| (UPUP)) (|p| #2=(|PositiveInteger|))
          (|pr| (|Record| (|:| |prime| #2#) (|:| |poly| #1#)))
          (|dd|
           #3=(|SparseUnivariatePolynomial|
               (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
          (|s| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
          (|b2| (UP)) (|b| #3#)
          (|h|
           (|SparseUnivariatePolynomial|
            (|SparseUnivariatePolynomial|
             (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
          (|hh| (R)) (|mn| (|Integer|)) (|n| (|Vector| R))
          (|i| (|FractionalIdeal| UP (|Fraction| UP) UPUP R))
          (|k1| (|Kernel| F)) (|mp| (|SparseUnivariatePolynomial| F)))
         (SEQ
          (LETT |k1|
                (SEQ (LETT |mp| (SPADCALL |k| (QREFELT $ 173)))
                     (EXIT
                      (COND
                       ((SPADCALL (CONS #'|PFO;algcurve!0| $)
                                  (SPADCALL |mp| (QREFELT $ 176))
                                  (QREFELT $ 178))
                        |k|)
                       ((|HasCategory| (QREFELT $ 7)
                                       '(|AlgebraicallyClosedField|))
                        (|SPADfirst|
                         (SPADCALL
                          (SPADCALL (|PFO;UPQ_to_UPF| (QVELT |rc| 2) $)
                                    (QREFELT $ 179))
                          (QREFELT $ 180))))
                       (#4='T (|error| "cannot reduce root"))))))
          (LETT |mn|
                (SPADCALL
                 (LETT |n|
                       (SPADCALL
                        (LETT |i|
                              (SPADCALL (SPADCALL |d| (QREFELT $ 129))
                                        (QREFELT $ 181)))
                        (QREFELT $ 131)))
                 (QREFELT $ 137)))
          (LETT |h|
                (|PFO;kpmod|
                 (SPADCALL
                  (LETT |hh| (SPADCALL |n| (+ |mn| 1) (QREFELT $ 182)))
                  (QREFELT $ 125))
                 |k| $))
          (LETT |b2|
                (SPADCALL
                 (|PFO;raise2|
                  (LETT |b|
                        (|PFO;krmod|
                         (SPADCALL
                          (SPADCALL (SPADCALL |n| |mn| (QREFELT $ 182))
                                    (QREFELT $ 183))
                          (QREFELT $ 53))
                         |k| $))
                  |k1| $)
                 (QREFELT $ 184)))
          (LETT |s|
                (|PFO;kqmod|
                 (SPADCALL
                  (SPADCALL
                   (QCAR
                    (SPADCALL
                     (|PFO;raise2|
                      (|PFO;krmod|
                       (SPADCALL (SPADCALL |hh| (QREFELT $ 185))
                                 (QREFELT $ 53))
                       |k| $)
                      |k1| $)
                     |b2| (QREFELT $ 187)))
                   (QREFELT $ 184))
                  |b2| (QREFELT $ 188))
                 |k1| $))
          (LETT |pr|
                (|PFO;kgetGoodPrime| |rc| |s| |h| |b|
                 (LETT |dd| (|PFO;krmod| (SPADCALL |i| (QREFELT $ 136)) |k| $))
                 $))
          (LETT |p| (QCAR |pr|))
          (LETT |pp| (|PFO;UP32UPUP| (QVELT |rc| 0) |k| $))
          (LETT |mm| (QCDR |pr|)) (LETT |gf| (|InnerPrimeField| |p|))
          (LETT |m|
                (SPADCALL (CONS #'|PFO;algcurve!1| (VECTOR |gf| $)) |mm|
                          (|compiledLookupCheck| '|map|
                                                 (LIST
                                                  (LIST
                                                   '|SparseUnivariatePolynomial|
                                                   (|devaluate| |gf|))
                                                  (LIST '|Mapping|
                                                        (|devaluate| |gf|)
                                                        (LIST '|Fraction|
                                                              (LIST
                                                               '|Integer|)))
                                                  (LIST
                                                   '|SparseUnivariatePolynomial|
                                                   (LIST '|Fraction|
                                                         (LIST '|Integer|))))
                                                 (|SparseUnivariatePolynomialFunctions2|
                                                  (|Fraction| (|Integer|))
                                                  |gf|))))
          (EXIT
           (COND
            ((EQL
              (SPADCALL |m|
                        (|compiledLookupCheck| '|degree|
                                               (LIST
                                                (LIST '|NonNegativeInteger|)
                                                '$)
                                               (|SparseUnivariatePolynomial|
                                                |gf|)))
              1)
             (SEQ
              (LETT |alpha|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL |m| 0
                                (|compiledLookupCheck| '|coefficient|
                                                       (LIST (|devaluate| |gf|)
                                                             '$
                                                             (LIST
                                                              '|NonNegativeInteger|))
                                                       (|SparseUnivariatePolynomial|
                                                        |gf|)))
                      (SPADCALL |m|
                                (|compiledLookupCheck| '|leadingCoefficient|
                                                       (LIST (|devaluate| |gf|)
                                                             '$)
                                                       (|SparseUnivariatePolynomial|
                                                        |gf|)))
                      (|compiledLookupCheck| '/ (LIST '$ '$ '$) |gf|))
                     (|compiledLookupCheck| '- (LIST '$ '$) |gf|)))
              (EXIT
               (SPADCALL |d| |pp|
                         (CONS #'|PFO;algcurve!3| (VECTOR |alpha| |k| $ |gf|))
                         (|compiledLookupCheck| '|order|
                                                (LIST
                                                 (LIST '|NonNegativeInteger|)
                                                 (LIST '|FiniteDivisor|
                                                       (|devaluate| (ELT $ 7))
                                                       (|devaluate| (ELT $ 8))
                                                       (|devaluate| (ELT $ 9))
                                                       (|devaluate|
                                                        (ELT $ 10)))
                                                 (|devaluate| (ELT $ 9))
                                                 (LIST '|Mapping|
                                                       (|devaluate| |gf|)
                                                       (|devaluate|
                                                        (ELT $ 7))))
                                                (|ReducedDivisor| (ELT $ 7)
                                                                  (ELT $ 8)
                                                                  (ELT $ 9)
                                                                  (ELT $ 10)
                                                                  |gf|))))))
            (#4#
             (SEQ
              (LETT |sae|
                    (|SimpleAlgebraicExtension| |gf|
                                                (|SparseUnivariatePolynomial|
                                                 |gf|)
                                                |m|))
              (EXIT
               (SPADCALL |d| |pp|
                         (CONS #'|PFO;algcurve!5| (VECTOR |sae| |k| $ |gf|))
                         (|compiledLookupCheck| '|order|
                                                (LIST
                                                 (LIST '|NonNegativeInteger|)
                                                 (LIST '|FiniteDivisor|
                                                       (|devaluate| (ELT $ 7))
                                                       (|devaluate| (ELT $ 8))
                                                       (|devaluate| (ELT $ 9))
                                                       (|devaluate|
                                                        (ELT $ 10)))
                                                 (|devaluate| (ELT $ 9))
                                                 (LIST '|Mapping|
                                                       (|devaluate| |sae|)
                                                       (|devaluate|
                                                        (ELT $ 7))))
                                                (|ReducedDivisor| (ELT $ 7)
                                                                  (ELT $ 8)
                                                                  (ELT $ 9)
                                                                  (ELT $ 10)
                                                                  |sae|))))))))))) 

(SDEFUN |PFO;algcurve!5| ((|z1| NIL) ($$ NIL))
        (PROG (|gf| $ |k| |sae|)
          (LETT |gf| (QREFELT $$ 3))
          (LETT $ (QREFELT $$ 2))
          (LETT |k| (QREFELT $$ 1))
          (LETT |sae| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL
                    (SPADCALL (CONS #'|PFO;algcurve!4| (VECTOR |gf| $))
                              (|PFO;kqmod| |z1| |k| $)
                              (|compiledLookupCheck| '|map|
                                                     (LIST
                                                      (LIST
                                                       '|SparseUnivariatePolynomial|
                                                       (|devaluate| |gf|))
                                                      (LIST '|Mapping|
                                                            (|devaluate| |gf|)
                                                            (LIST '|Fraction|
                                                                  (LIST
                                                                   '|Integer|)))
                                                      (LIST
                                                       '|SparseUnivariatePolynomial|
                                                       (LIST '|Fraction|
                                                             (LIST
                                                              '|Integer|))))
                                                     (|SparseUnivariatePolynomialFunctions2|
                                                      (|Fraction| (|Integer|))
                                                      |gf|)))
                    (|compiledLookupCheck| '|reduce|
                                           (LIST '$
                                                 (LIST
                                                  '|SparseUnivariatePolynomial|
                                                  (|devaluate| |gf|)))
                                           |sae|))))))) 

(SDEFUN |PFO;algcurve!4| ((|q1| NIL) ($$ NIL))
        (PROG ($ |gf|)
          (LETT $ (QREFELT $$ 1))
          (LETT |gf| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL (SPADCALL |q1| (QREFELT $ 20))
                       (|compiledLookupCheck| '|coerce|
                                              (LIST '$ (LIST '|Integer|))
                                              |gf|))
             (SPADCALL (SPADCALL |q1| (QREFELT $ 22))
                       (|compiledLookupCheck| '|coerce|
                                              (LIST '$ (LIST '|Integer|))
                                              |gf|))
             (|compiledLookupCheck| '/ (LIST '$ '$ '$) |gf|)))))) 

(SDEFUN |PFO;algcurve!3| ((|z1| NIL) ($$ NIL))
        (PROG (|gf| $ |k| |alpha|)
          (LETT |gf| (QREFELT $$ 3))
          (LETT $ (QREFELT $$ 2))
          (LETT |k| (QREFELT $$ 1))
          (LETT |alpha| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL
                    (SPADCALL (CONS #'|PFO;algcurve!2| (VECTOR |gf| $))
                              (|PFO;kqmod| |z1| |k| $)
                              (|compiledLookupCheck| '|map|
                                                     (LIST
                                                      (LIST
                                                       '|SparseUnivariatePolynomial|
                                                       (|devaluate| |gf|))
                                                      (LIST '|Mapping|
                                                            (|devaluate| |gf|)
                                                            (LIST '|Fraction|
                                                                  (LIST
                                                                   '|Integer|)))
                                                      (LIST
                                                       '|SparseUnivariatePolynomial|
                                                       (LIST '|Fraction|
                                                             (LIST
                                                              '|Integer|))))
                                                     (|SparseUnivariatePolynomialFunctions2|
                                                      (|Fraction| (|Integer|))
                                                      |gf|)))
                    |alpha|
                    (|compiledLookupCheck| '|elt|
                                           (LIST (|devaluate| |gf|) '$
                                                 (|devaluate| |gf|))
                                           (|SparseUnivariatePolynomial|
                                            |gf|)))))))) 

(SDEFUN |PFO;algcurve!2| ((|q1| NIL) ($$ NIL))
        (PROG ($ |gf|)
          (LETT $ (QREFELT $$ 1))
          (LETT |gf| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL (SPADCALL |q1| (QREFELT $ 20))
                       (|compiledLookupCheck| '|coerce|
                                              (LIST '$ (LIST '|Integer|))
                                              |gf|))
             (SPADCALL (SPADCALL |q1| (QREFELT $ 22))
                       (|compiledLookupCheck| '|coerce|
                                              (LIST '$ (LIST '|Integer|))
                                              |gf|))
             (|compiledLookupCheck| '/ (LIST '$ '$ '$) |gf|)))))) 

(SDEFUN |PFO;algcurve!1| ((|z1| NIL) ($$ NIL))
        (PROG ($ |gf|)
          (LETT $ (QREFELT $$ 1))
          (LETT |gf| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |z1| (QREFELT $ 114))
                      (|compiledLookupCheck| '|coerce|
                                             (LIST '$ (LIST '|Integer|))
                                             |gf|)))))) 

(SDEFUN |PFO;algcurve!0| ((|x| NIL) ($ NIL))
        (QEQCAR (SPADCALL |x| (QREFELT $ 175)) 0)) 

(SDEFUN |PFO;ratcurve|
        ((|d| (|FiniteDivisor| F UP UPUP R))
         (|rc|
          (|Record|
           (|:| |ncurve|
                (|SparseUnivariatePolynomial|
                 (|Fraction|
                  (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
           (|:| |disc| (|Integer|))))
         ($ (|NonNegativeInteger|)))
        (SPROG
         ((|m| #1=(|NonNegativeInteger|)) (|n| #1#) (|p| (|PositiveInteger|))
          (|pp| (UPUP)) (|bad| (|Integer|)) (|r| (|Fraction| (|Integer|)))
          (|bd| (|Record| (|:| |den| (|Integer|)) (|:| |gcdnum| (|Integer|))))
          (|s| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
          (|b| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
          (|h|
           (|SparseUnivariatePolynomial|
            (|Fraction|
             (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
          (|hh| (R)) (|mn| (|Integer|)) (|nm| (|Vector| R))
          (|i| (|FractionalIdeal| UP (|Fraction| UP) UPUP R)))
         (SEQ
          (LETT |mn|
                (SPADCALL
                 (LETT |nm|
                       (SPADCALL
                        (LETT |i|
                              (SPADCALL (SPADCALL |d| (QREFELT $ 129))
                                        (QREFELT $ 181)))
                        (QREFELT $ 131)))
                 (QREFELT $ 137)))
          (LETT |h|
                (|PFO;pmod|
                 (SPADCALL
                  (LETT |hh| (SPADCALL |nm| (+ |mn| 1) (QREFELT $ 182)))
                  (QREFELT $ 125))
                 $))
          (LETT |b|
                (|PFO;rmod|
                 (SPADCALL
                  (SPADCALL (SPADCALL |nm| |mn| (QREFELT $ 182))
                            (QREFELT $ 183))
                  (QREFELT $ 53))
                 $))
          (LETT |s|
                (QCAR
                 (SPADCALL
                  (|PFO;rmod|
                   (SPADCALL (SPADCALL |hh| (QREFELT $ 185)) (QREFELT $ 53)) $)
                  |b| (QREFELT $ 191))))
          (LETT |bd|
                (SPADCALL (|PFO;rmod| (SPADCALL |i| (QREFELT $ 136)) $)
                          (QREFELT $ 76)))
          (LETT |r| (SPADCALL |s| |b| (QREFELT $ 192)))
          (LETT |bad|
                (SPADCALL
                 (LIST (SPADCALL (SPADCALL (QREFELT $ 194)) (QREFELT $ 195))
                       (QCDR |rc|) (SPADCALL |r| (QREFELT $ 20))
                       (SPADCALL |r| (QREFELT $ 22))
                       (* (QCAR |bd|) (QCDR |bd|))
                       (SPADCALL |h| (QREFELT $ 196)))
                 (QREFELT $ 81)))
          (LETT |pp| (|PFO;Q2UPUP| (QCAR |rc|) $))
          (LETT |n|
                (|PFO;rat| |pp| |d| (LETT |p| (SPADCALL |bad| (QREFELT $ 197)))
                 $))
          (EXIT
           (COND ((EQL |n| 1) |n|)
                 (#2='T
                  (SEQ
                   (LETT |m|
                         (|PFO;rat| |pp| |d|
                          (SPADCALL (* |p| |bad|) (QREFELT $ 197)) $))
                   (EXIT (COND ((EQL |n| |m|) |n|) (#2# 0)))))))))) 

(SDEFUN |PFO;rat|
        ((|pp| (UPUP)) (|d| (|FiniteDivisor| F UP UPUP R))
         (|p| (|PositiveInteger|)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|gf|
           (|Join| (|FiniteFieldCategory|) (|FiniteAlgebraicExtensionField| $)
                   (|ConvertibleTo| (|Integer|))
                   (CATEGORY |domain| (SIGNATURE |sqrt| ($ $))
                    (SIGNATURE |quadraticNonResidue| ($))))))
         (SEQ (LETT |gf| (|InnerPrimeField| |p|))
              (EXIT
               (SPADCALL |d| |pp| (CONS #'|PFO;rat!0| (VECTOR |gf| $))
                         (|compiledLookupCheck| '|order|
                                                (LIST
                                                 (LIST '|NonNegativeInteger|)
                                                 (LIST '|FiniteDivisor|
                                                       (|devaluate| (ELT $ 7))
                                                       (|devaluate| (ELT $ 8))
                                                       (|devaluate| (ELT $ 9))
                                                       (|devaluate|
                                                        (ELT $ 10)))
                                                 (|devaluate| (ELT $ 9))
                                                 (LIST '|Mapping|
                                                       (|devaluate| |gf|)
                                                       (|devaluate|
                                                        (ELT $ 7))))
                                                (|ReducedDivisor| (ELT $ 7)
                                                                  (ELT $ 8)
                                                                  (ELT $ 9)
                                                                  (ELT $ 10)
                                                                  |gf|))))))) 

(SDEFUN |PFO;rat!0| ((|q1| NIL) ($$ NIL))
        (PROG ($ |gf|)
          (LETT $ (QREFELT $$ 1))
          (LETT |gf| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|qq| NIL))
                   (SEQ (LETT |qq| (|PFO;qmod| |q1| $))
                        (EXIT
                         (SPADCALL
                          (SPADCALL (SPADCALL |qq| (QREFELT $ 20))
                                    (|compiledLookupCheck| '|coerce|
                                                           (LIST '$
                                                                 (LIST
                                                                  '|Integer|))
                                                           |gf|))
                          (SPADCALL (SPADCALL |qq| (QREFELT $ 22))
                                    (|compiledLookupCheck| '|coerce|
                                                           (LIST '$
                                                                 (LIST
                                                                  '|Integer|))
                                                           |gf|))
                          (|compiledLookupCheck| '/ (LIST '$ '$ '$)
                                                 |gf|))))))))) 

(SDEFUN |PFO;evalup|
        ((|upup| (UPUP)) (|la| (|List| (|Kernel| F))) (|lrhs| (|List| F))
         ($ (UPUP)))
        (SPROG NIL
               (SPADCALL (CONS #'|PFO;evalup!2| (VECTOR $ |lrhs| |la|)) |upup|
                         (QREFELT $ 158)))) 

(SDEFUN |PFO;evalup!2| ((|a| NIL) ($$ NIL))
        (PROG (|la| |lrhs| $)
          (LETT |la| (QREFELT $$ 2))
          (LETT |lrhs| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL (CONS #'|PFO;evalup!1| (VECTOR |la| |lrhs| $)) |a|
                             (QREFELT $ 156))))))) 

(SDEFUN |PFO;evalup!1| ((|b| NIL) ($$ NIL))
        (PROG ($ |lrhs| |la|)
          (LETT $ (QREFELT $$ 2))
          (LETT |lrhs| (QREFELT $$ 1))
          (LETT |la| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL (CONS #'|PFO;evalup!0| (VECTOR $ |lrhs| |la|)) |b|
                             (QREFELT $ 154))))))) 

(SDEFUN |PFO;evalup!0| ((|c| NIL) ($$ NIL))
        (PROG (|la| |lrhs| $)
          (LETT |la| (QREFELT $$ 2))
          (LETT |lrhs| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |c| |la| |lrhs| (QREFELT $ 198)))))) 

(SDEFUN |PFO;simplifyCoeffs;RLNni;41|
        ((|irec|
          (|Record| (|:| |ncurve| UPUP) (|:| |n_div_numer| (|Vector| UPUP))
                    (|:| |n_div_denom| UPUP)
                    . #1=((|:| |need_change| (|Boolean|)))))
         (|la| (|List| (|Kernel| F))) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|ndiv| (|nFD|)) (|va| (|Vector| |nR|)) (#2=#:G1374 NIL)
          (#3=#:G1376 NIL) (|ni| NIL) (#4=#:G1375 NIL) (|nd| (|nR|))
          (|nPFO|
           (CATEGORY |package|
            (SIGNATURE |order|
             ((|Union| (|NonNegativeInteger|) "failed")
              (|FiniteDivisor| F UP UPUP |nR|)))
            (SIGNATURE |torsion?|
             ((|Boolean|) (|FiniteDivisor| F UP UPUP |nR|)))
            (SIGNATURE |torsionIfCan|
             ((|Union|
               (|Record| (|:| |order| (|NonNegativeInteger|))
                         (|:| |function| |nR|))
               "failed")
              (|FiniteDivisor| F UP UPUP |nR|)))
            (SIGNATURE |cmult|
             ((|SparseMultivariatePolynomial| R0 (|Kernel| F))
              (|List| (|SparseMultivariatePolynomial| R0 (|Kernel| F)))))
            (SIGNATURE |possibleOrder|
             ((|NonNegativeInteger|) (|FiniteDivisor| F UP UPUP |nR|)))
            (SIGNATURE |handle_imaginary|
             ((|Record| (|:| |ncurve| UPUP) (|:| |n_div_numer| (|Vector| UPUP))
                        (|:| |n_div_denom| UPUP)
                        (|:| |need_change| (|Boolean|)))
              (|FiniteDivisor| F UP UPUP |nR|)))
            (IF (|has| R0 (|CharacteristicZero|))
                (IF (|has| F (|AlgebraicallyClosedField|))
                    (SIGNATURE |simplifyCoeffs|
                     ((|NonNegativeInteger|)
                      (|Record| (|:| |ncurve| UPUP)
                                (|:| |n_div_numer| (|Vector| UPUP))
                                (|:| |n_div_denom| UPUP) . #1#)
                      (|List| (|Kernel| F))))
                    |noBranch|)
                |noBranch|)))
          (|nFR|
           (|Join| (|Group|)
                   (CATEGORY |domain| (SIGNATURE |ideal| ($ (|Vector| |nR|)))
                    (SIGNATURE |basis| ((|Vector| |nR|) $))
                    (SIGNATURE |norm| ((|Fraction| UP) $))
                    (SIGNATURE |numer| ((|Vector| |nR|) $))
                    (SIGNATURE |denom| (UP $)) (SIGNATURE |minimize| ($ $))
                    (SIGNATURE |randomLC|
                     (|nR| (|NonNegativeInteger|) (|Vector| |nR|))))))
          (|nFD|
           (|Join| (|FiniteDivisorCategory| F UP UPUP |nR|)
                   (CATEGORY |domain|
                    (SIGNATURE |finiteBasis| ((|Vector| |nR|) $))
                    (SIGNATURE |lSpaceBasis| ((|Vector| |nR|) $)))))
          (|nR|
           (|Join| (|FunctionFieldCategory| F UP UPUP)
                   (CATEGORY |package|
                    (SIGNATURE |knownInfBasis|
                     ((|Void|) (|NonNegativeInteger|))))))
          (|nf| (UPUP)) (|lrhs| (|List| F)) (#5=#:G1373 NIL) (|pol| NIL)
          (#6=#:G1372 NIL) (|y| (F))
          (|rec|
           (|Record| (|:| |primelt| F)
                     (|:| |poly| (|List| (|SparseUnivariatePolynomial| F)))
                     (|:| |prim| (|SparseUnivariatePolynomial| F))))
          (#7=#:G1371 NIL) (|k| NIL) (#8=#:G1370 NIL))
         (SEQ
          (LETT |rec|
                (SPADCALL
                 (PROGN
                  (LETT #8# NIL)
                  (SEQ (LETT |k| NIL) (LETT #7# |la|) G190
                       (COND
                        ((OR (ATOM #7#) (PROGN (LETT |k| (CAR #7#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #8# (CONS (SPADCALL |k| (QREFELT $ 33)) #8#))))
                       (LETT #7# (CDR #7#)) (GO G190) G191
                       (EXIT (NREVERSE #8#))))
                 (QREFELT $ 201)))
          (LETT |y| (SPADCALL (QVELT |rec| 2) (QREFELT $ 179)))
          (LETT |lrhs|
                (PROGN
                 (LETT #6# NIL)
                 (SEQ (LETT |pol| NIL) (LETT #5# (QVELT |rec| 1)) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |pol| (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #6#
                              (CONS (SPADCALL |pol| |y| (QREFELT $ 34)) #6#))))
                      (LETT #5# (CDR #5#)) (GO G190) G191
                      (EXIT (NREVERSE #6#)))))
          (LETT |nf| (|PFO;evalup| (QVELT |irec| 0) |la| |lrhs| $))
          (LETT |nR|
                (|AlgebraicFunctionField| (QREFELT $ 7) (QREFELT $ 8)
                                          (QREFELT $ 9) |nf|))
          (LETT |nFD|
                (|FiniteDivisor| (QREFELT $ 7) (QREFELT $ 8) (QREFELT $ 9)
                                 |nR|))
          (LETT |nFR|
                (|FractionalIdeal| (QREFELT $ 8) (|Fraction| (QREFELT $ 8))
                                   (QREFELT $ 9) |nR|))
          (LETT |nPFO|
                (|PointsOfFiniteOrder| (QREFELT $ 6) (QREFELT $ 7)
                                       (QREFELT $ 8) (QREFELT $ 9) |nR|))
          (LETT |nd|
                (SPADCALL (|PFO;evalup| (QVELT |irec| 2) |la| |lrhs| $)
                          (|compiledLookupCheck| '|reduce|
                                                 (LIST '$
                                                       (|devaluate| (ELT $ 9)))
                                                 |nR|)))
          (LETT |va|
                (PROGN
                 (LETT #4#
                       (GETREFV
                        (SIZE #9=(SPADCALL (QVELT |irec| 1) (QREFELT $ 143)))))
                 (SEQ (LETT |ni| NIL) (LETT #3# #9#) (LETT #2# 0) G190
                      (COND
                       ((OR (ATOM #3#) (PROGN (LETT |ni| (CAR #3#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (SETELT #4# #2#
                                (SPADCALL
                                 (SPADCALL (|PFO;evalup| |ni| |la| |lrhs| $)
                                           (|compiledLookupCheck| '|reduce|
                                                                  (LIST '$
                                                                        (|devaluate|
                                                                         (ELT $
                                                                              9)))
                                                                  |nR|))
                                 |nd|
                                 (|compiledLookupCheck| '/ (LIST '$ '$ '$)
                                                        |nR|)))))
                      (LETT #2# (PROG1 (|inc_SI| #2#) (LETT #3# (CDR #3#))))
                      (GO G190) G191 (EXIT NIL))
                 #4#))
          (LETT |ndiv|
                (SPADCALL
                 (SPADCALL |va|
                           (|compiledLookupCheck| '|ideal|
                                                  (LIST '$
                                                        (LIST '|Vector|
                                                              (|devaluate|
                                                               |nR|)))
                                                  |nFR|))
                 (|compiledLookupCheck| '|divisor|
                                        (LIST '$
                                              (LIST '|FractionalIdeal|
                                                    (|devaluate| (ELT $ 8))
                                                    (LIST '|Fraction|
                                                          (|devaluate|
                                                           (ELT $ 8)))
                                                    (|devaluate| (ELT $ 9))
                                                    (|devaluate| |nR|)))
                                        |nFD|)))
          (EXIT
           (SPADCALL |ndiv|
                     (|compiledLookupCheck| '|possibleOrder|
                                            (LIST (LIST '|NonNegativeInteger|)
                                                  (LIST '|FiniteDivisor|
                                                        (|devaluate| (ELT $ 7))
                                                        (|devaluate| (ELT $ 8))
                                                        (|devaluate| (ELT $ 9))
                                                        (|devaluate| |nR|)))
                                            |nPFO|)))))) 

(SDEFUN |PFO;possibleOrder;FdNni;42|
        ((|d| (|FiniteDivisor| F UP UPUP R)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|va| (|Vector| R)) (#1=#:G1393 NIL) (#2=#:G1395 NIL) (|ni| NIL)
          (#3=#:G1394 NIL) (|nden| (R)) (#4=#:G1392 NIL)
          (|la| (|List| (|Kernel| F)))
          (|irec|
           (|Record| (|:| |ncurve| UPUP) (|:| |n_div_numer| (|Vector| UPUP))
                     (|:| |n_div_denom| UPUP)
                     (|:| |need_change| (|Boolean|)))))
         (SEQ
          (EXIT
           (COND
            ((OR (ZEROP (SPADCALL (QREFELT $ 203)))
                 (EQL
                  (QVSIZE
                   (SPADCALL (SPADCALL |d| (QREFELT $ 129)) (QREFELT $ 131)))
                  1))
             1)
            ('T
             (SEQ
              (LETT |d|
                    (SPADCALL (QCAR (SPADCALL |d| (QREFELT $ 205)))
                              (QREFELT $ 206)))
              (LETT |irec| (SPADCALL |d| (QREFELT $ 172)))
              (LETT |la|
                    (|PFO;alglist1| (QVELT |irec| 0) (QVELT |irec| 1)
                     (QVELT |irec| 2) $))
              (EXIT
               (COND ((NULL |la|) (|PFO;ratcurve| |d| (|PFO;selIntegers| $) $))
                     (#5='T
                      (SEQ
                       (COND
                        ((NULL (CDR |la|))
                         (COND
                          ((QVELT |irec| 3)
                           (EXIT
                            (SEQ
                             (COND
                              ((|HasCategory| (QREFELT $ 6)
                                              '(|CharacteristicZero|))
                               (COND
                                ((|HasCategory| (QREFELT $ 7)
                                                '(|AlgebraicallyClosedField|))
                                 (PROGN
                                  (LETT #4#
                                        (SPADCALL |irec| |la| (QREFELT $ 202)))
                                  (GO #6=#:G1391))))))
                             (EXIT
                              (|error|
                               #7="PFO::possibleOrder: more than 1 algebraic constant")))))))
                        (#5#
                         (EXIT
                          (SEQ
                           (COND
                            ((|HasCategory| (QREFELT $ 6)
                                            '(|CharacteristicZero|))
                             (COND
                              ((|HasCategory| (QREFELT $ 7)
                                              '(|AlgebraicallyClosedField|))
                               (PROGN
                                (LETT #4#
                                      (SPADCALL |irec| |la| (QREFELT $ 202)))
                                (GO #6#))))))
                           (EXIT (|error| #7#))))))
                       (LETT |nden|
                             (SPADCALL (QVELT |irec| 2) (QREFELT $ 207)))
                       (LETT |va|
                             (PROGN
                              (LETT #3#
                                    (GETREFV
                                     (SIZE
                                      #8=(SPADCALL (QVELT |irec| 1)
                                                   (QREFELT $ 143)))))
                              (SEQ (LETT |ni| NIL) (LETT #2# #8#) (LETT #1# 0)
                                   G190
                                   (COND
                                    ((OR (ATOM #2#)
                                         (PROGN (LETT |ni| (CAR #2#)) NIL))
                                     (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (SETELT #3# #1#
                                             (SPADCALL
                                              (SPADCALL |ni| (QREFELT $ 207))
                                              |nden| (QREFELT $ 208)))))
                                   (LETT #1#
                                         (PROG1 (|inc_SI| #1#)
                                           (LETT #2# (CDR #2#))))
                                   (GO G190) G191 (EXIT NIL))
                              #3#))
                       (LETT |d|
                             (SPADCALL (SPADCALL |va| (QREFELT $ 209))
                                       (QREFELT $ 206)))
                       (EXIT
                        (|PFO;algcurve| |d|
                         (|PFO;selectIntegers| (|SPADfirst| |la|) $)
                         (|SPADfirst| |la|) $))))))))))
          #6# (EXIT #4#)))) 

(SDEFUN |PFO;selIntegers|
        (($
          (|Record|
           (|:| |ncurve|
                (|SparseUnivariatePolynomial|
                 (|Fraction|
                  (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
           (|:| |disc| (|Integer|)))))
        (SPROG
         ((#1=#:G1402 NIL) (|d| (|Integer|))
          (|r|
           (|SparseUnivariatePolynomial|
            (|Fraction|
             (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
          (|n| (|Integer|)) (|f| (UPUP)))
         (SEQ
          (EXIT
           (SEQ (LETT |f| (SPADCALL (QREFELT $ 140))) (LETT |n| (EXPT 10 6))
                (EXIT
                 (SEQ G190 NIL
                      (SEQ (SPADCALL |n| (QREFELT $ 211))
                           (LETT |d|
                                 (SPADCALL
                                  (LETT |r|
                                        (SPADCALL (|PFO;pmod| |f| $)
                                                  (QREFELT $ 212)))
                                  (QREFELT $ 213)))
                           (EXIT
                            (COND
                             ((NULL (ZEROP |d|))
                              (PROGN
                               (LETT #1# (CONS |r| |d|))
                               (GO #2=#:G1401))))))
                      NIL (GO G190) G191 (EXIT NIL)))))
          #2# (EXIT #1#)))) 

(SDEFUN |PFO;selectIntegers|
        ((|k| (|Kernel| F))
         ($
          (|Record|
           (|:| |ncurve|
                (|SparseUnivariatePolynomial|
                 (|SparseUnivariatePolynomial|
                  (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
           (|:| |disc| (|Integer|))
           (|:| |dfpoly|
                (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))))
        (SPROG
         ((#1=#:G1412 NIL) (|d| (|Integer|))
          (|r|
           (|SparseUnivariatePolynomial|
            (|SparseUnivariatePolynomial|
             (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
          (|n| (|Integer|)) (|p| (|SparseUnivariatePolynomial| F)) (|g| (UPUP))
          (|f| (UPUP)))
         (SEQ
          (EXIT
           (SEQ
            (LETT |g| (|PFO;polyred| (LETT |f| (SPADCALL (QREFELT $ 140))) $))
            (LETT |p| (SPADCALL |k| (QREFELT $ 173))) (LETT |n| (EXPT 10 6))
            (EXIT
             (SEQ G190 NIL
                  (SEQ (SPADCALL |n| (QREFELT $ 211))
                       (LETT |d|
                             (|PFO;doubleDisc|
                              (LETT |r| (|PFO;kpmod| |g| |k| $)) $))
                       (COND
                        ((OR (ZEROP |d|) (|PFO;notIrr?| (|PFO;fmod| |p| $) $))
                         (EXIT "iterate")))
                       (EXIT
                        (PROGN
                         (LETT #1#
                               (VECTOR |r| |d|
                                       (QCAR
                                        (SPADCALL (|PFO;fmod| |p| $)
                                                  (QREFELT $ 216)))))
                         (GO #2=#:G1411))))
                  NIL (GO G190) G191 (EXIT NIL)))))
          #2# (EXIT #1#)))) 

(SDEFUN |PFO;order;FdU;45|
        ((|d| (|FiniteDivisor| F UP UPUP R))
         ($ (|Union| (|NonNegativeInteger|) "failed")))
        (SPROG ((|n| (|NonNegativeInteger|)))
               (COND
                ((OR
                  (ZEROP
                   (LETT |n|
                         (SPADCALL (LETT |d| (SPADCALL |d| (QREFELT $ 82)))
                                   (QREFELT $ 84))))
                  (NULL
                   (SPADCALL
                    (SPADCALL (SPADCALL |n| |d| (QREFELT $ 85)) (QREFELT $ 82))
                    (QREFELT $ 217))))
                 (CONS 1 "failed"))
                ('T (CONS 0 |n|))))) 

(SDEFUN |PFO;kgetGoodPrime|
        ((|rec|
          (|Record|
           (|:| |ncurve|
                (|SparseUnivariatePolynomial|
                 (|SparseUnivariatePolynomial|
                  (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
           (|:| |disc| (|Integer|))
           (|:| |dfpoly|
                (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
         (|res| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
         (|h|
          (|SparseUnivariatePolynomial|
           (|SparseUnivariatePolynomial|
            (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
         (|b|
          (|SparseUnivariatePolynomial|
           (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
         (|d|
          (|SparseUnivariatePolynomial|
           (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
         ($
          (|Record| (|:| |prime| (|PositiveInteger|))
                    (|:| |poly|
                         (|SparseUnivariatePolynomial|
                          (|Fraction| (|Integer|)))))))
        (SPROG
         ((#1=#:G1423 NIL) (|p| (|PositiveInteger|)) (#2=#:G1425 NIL)
          (|u|
           (|Union| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))
                    #3="failed"))
          (#4=#:G1420 NIL))
         (SEQ
          (LETT |p|
                (PROG1
                    (LETT #4#
                          (SPADCALL (SPADCALL (QREFELT $ 194))
                                    (QREFELT $ 219)))
                  (|check_subtype2| (> #4# 0) '(|PositiveInteger|) '(|Integer|)
                                    #4#)))
          (SEQ G190
               (COND
                ((NULL
                  (QEQCAR
                   (LETT |u| (|PFO;goodRed| |rec| |res| |h| |b| |d| |p| $)) 1))
                 (GO G191)))
               (SEQ
                (EXIT
                 (LETT |p|
                       (PROG1 (LETT #2# (SPADCALL |p| (QREFELT $ 219)))
                         (|check_subtype2| (> #2# 0) '(|PositiveInteger|)
                                           '(|Integer|) #2#)))))
               NIL (GO G190) G191 (EXIT NIL))
          (EXIT
           (CONS |p|
                 (PROG2 (LETT #1# |u|)
                     (QCDR #1#)
                   (|check_union2| (QEQCAR #1# 0)
                                   (|SparseUnivariatePolynomial|
                                    (|Fraction| (|Integer|)))
                                   (|Union|
                                    (|SparseUnivariatePolynomial|
                                     (|Fraction| (|Integer|)))
                                    #3#)
                                   #1#))))))) 

(SDEFUN |PFO;goodRed|
        ((|rec|
          (|Record|
           (|:| |ncurve|
                (|SparseUnivariatePolynomial|
                 (|SparseUnivariatePolynomial|
                  (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
           (|:| |disc| (|Integer|))
           (|:| |dfpoly|
                (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
         (|res| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
         (|h|
          (|SparseUnivariatePolynomial|
           (|SparseUnivariatePolynomial|
            (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
         (|b|
          (|SparseUnivariatePolynomial|
           (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
         (|d|
          (|SparseUnivariatePolynomial|
           (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
         (|p| (|PositiveInteger|))
         ($
          (|Union| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))
                   "failed")))
        (SPROG
         ((|md| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
          (|mdg| (|SparseUnivariatePolynomial| |gf|)) (#1=#:G1447 NIL)
          (|ff| NIL) (|l| (|List| (|SparseUnivariatePolynomial| |gf|)))
          (#2=#:G1446 NIL) (|f| NIL) (#3=#:G1445 NIL)
          (|gf|
           (|Join| (|FiniteFieldCategory|) (|FiniteAlgebraicExtensionField| $)
                   (|ConvertibleTo| (|Integer|))
                   (CATEGORY |domain| (SIGNATURE |sqrt| ($ $))
                    (SIGNATURE |quadraticNonResidue| ($))))))
         (SEQ
          (COND ((ZEROP (REM (QVELT |rec| 1) |p|)) (CONS 1 "failed"))
                (#4='T
                 (SEQ (LETT |gf| (|InnerPrimeField| |p|))
                      (LETT |l|
                            (PROGN
                             (LETT #3# NIL)
                             (SEQ (LETT |f| NIL)
                                  (LETT #2#
                                        (SPADCALL
                                         (SPADCALL
                                          (SPADCALL
                                           (CONS #'|PFO;goodRed!0|
                                                 (VECTOR |gf| $))
                                           (QVELT |rec| 2)
                                           (|compiledLookupCheck| '|map|
                                                                  (LIST
                                                                   (LIST
                                                                    '|SparseUnivariatePolynomial|
                                                                    (|devaluate|
                                                                     |gf|))
                                                                   (LIST
                                                                    '|Mapping|
                                                                    (|devaluate|
                                                                     |gf|)
                                                                    (LIST
                                                                     '|Fraction|
                                                                     (LIST
                                                                      '|Integer|)))
                                                                   (LIST
                                                                    '|SparseUnivariatePolynomial|
                                                                    (LIST
                                                                     '|Fraction|
                                                                     (LIST
                                                                      '|Integer|))))
                                                                  (|SparseUnivariatePolynomialFunctions2|
                                                                   (|Fraction|
                                                                    (|Integer|))
                                                                   |gf|)))
                                          (|compiledLookupCheck| '|factor|
                                                                 (LIST
                                                                  (LIST
                                                                   '|Factored|
                                                                   (LIST
                                                                    '|SparseUnivariatePolynomial|
                                                                    (|devaluate|
                                                                     |gf|)))
                                                                  (LIST
                                                                   '|SparseUnivariatePolynomial|
                                                                   (|devaluate|
                                                                    |gf|)))
                                                                 (|DistinctDegreeFactorize|
                                                                  |gf|
                                                                  (|SparseUnivariatePolynomial|
                                                                   |gf|))))
                                         (|compiledLookupCheck| '|factorList|
                                                                (LIST
                                                                 (LIST '|List|
                                                                       (LIST
                                                                        '|Record|
                                                                        (LIST
                                                                         '|:|
                                                                         '|flag|
                                                                         (LIST
                                                                          '|Union|
                                                                          '"nil"
                                                                          '"sqfr"
                                                                          '"irred"
                                                                          '"prime"))
                                                                        (LIST
                                                                         '|:|
                                                                         '|factor|
                                                                         (LIST
                                                                          '|SparseUnivariatePolynomial|
                                                                          (|devaluate|
                                                                           |gf|)))
                                                                        (LIST
                                                                         '|:|
                                                                         '|exponent|
                                                                         (LIST
                                                                          '|NonNegativeInteger|))))
                                                                 '$)
                                                                (|Factored|
                                                                 (|SparseUnivariatePolynomial|
                                                                  |gf|)))))
                                  G190
                                  (COND
                                   ((OR (ATOM #2#)
                                        (PROGN (LETT |f| (CAR #2#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((EQL (QVELT |f| 2) 1)
                                      (LETT #3# (CONS (QVELT |f| 1) #3#))))))
                                  (LETT #2# (CDR #2#)) (GO G190) G191
                                  (EXIT (NREVERSE #3#)))))
                      (EXIT
                       (COND ((NULL |l|) (CONS 1 "failed"))
                             (#4#
                              (SEQ (LETT |mdg| (|SPADfirst| |l|))
                                   (SEQ (LETT |ff| NIL) (LETT #1# (CDR |l|))
                                        G190
                                        (COND
                                         ((OR (ATOM #1#)
                                              (PROGN
                                               (LETT |ff| (CAR #1#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (COND
                                           ((<
                                             (SPADCALL |ff|
                                                       (|compiledLookupCheck|
                                                        '|degree|
                                                        (LIST
                                                         (LIST
                                                          '|NonNegativeInteger|)
                                                         '$)
                                                        (|SparseUnivariatePolynomial|
                                                         |gf|)))
                                             (SPADCALL |mdg|
                                                       (|compiledLookupCheck|
                                                        '|degree|
                                                        (LIST
                                                         (LIST
                                                          '|NonNegativeInteger|)
                                                         '$)
                                                        (|SparseUnivariatePolynomial|
                                                         |gf|))))
                                            (LETT |mdg| |ff|)))))
                                        (LETT #1# (CDR #1#)) (GO G190) G191
                                        (EXIT NIL))
                                   (LETT |md|
                                         (SPADCALL
                                          (CONS #'|PFO;goodRed!1|
                                                (VECTOR $ |gf|))
                                          |mdg|
                                          (|compiledLookupCheck| '|map|
                                                                 (LIST
                                                                  (LIST
                                                                   '|SparseUnivariatePolynomial|
                                                                   (LIST
                                                                    '|Fraction|
                                                                    (LIST
                                                                     '|Integer|)))
                                                                  (LIST
                                                                   '|Mapping|
                                                                   (LIST
                                                                    '|Fraction|
                                                                    (LIST
                                                                     '|Integer|))
                                                                   (|devaluate|
                                                                    |gf|))
                                                                  (LIST
                                                                   '|SparseUnivariatePolynomial|
                                                                   (|devaluate|
                                                                    |gf|)))
                                                                 (|SparseUnivariatePolynomialFunctions2|
                                                                  |gf|
                                                                  (|Fraction|
                                                                   (|Integer|))))))
                                   (EXIT
                                    (COND
                                     ((|PFO;good?| |res| |h| |b| |d| |p| |md|
                                       $)
                                      (CONS 0 |md|))
                                     (#4# (CONS 1 "failed")))))))))))))) 

(SDEFUN |PFO;goodRed!1| ((|z1| NIL) ($$ NIL))
        (PROG (|gf| $)
          (LETT |gf| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL
             (SPADCALL |z1|
                       (|compiledLookupCheck| '|convert|
                                              (LIST (LIST '|Integer|) '$)
                                              |gf|))
             (QREFELT $ 220)))))) 

(SDEFUN |PFO;goodRed!0| ((|z1| NIL) ($$ NIL))
        (PROG ($ |gf|)
          (LETT $ (QREFELT $$ 1))
          (LETT |gf| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL (SPADCALL |z1| (QREFELT $ 114))
                      (|compiledLookupCheck| '|coerce|
                                             (LIST '$ (LIST '|Integer|))
                                             |gf|)))))) 

(SDEFUN |PFO;good?|
        ((|res| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
         (|h|
          (|SparseUnivariatePolynomial|
           (|SparseUnivariatePolynomial|
            (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))))
         (|b|
          (|SparseUnivariatePolynomial|
           (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
         (|d|
          (|SparseUnivariatePolynomial|
           (|SparseUnivariatePolynomial| (|Fraction| (|Integer|)))))
         (|p| (|PositiveInteger|))
         (|m| (|SparseUnivariatePolynomial| (|Fraction| (|Integer|))))
         ($ (|Boolean|)))
        (SPROG
         ((|bd| (|Record| (|:| |den| (|Integer|)) (|:| |gcdnum| (|Integer|)))))
         (SEQ
          (LETT |bd|
                (SPADCALL (SPADCALL |res| |m| (QREFELT $ 73)) (QREFELT $ 76)))
          (EXIT
           (COND
            ((OR (ZEROP (REM (QCAR |bd|) |p|))
                 (OR (ZEROP (REM (QCDR |bd|) |p|))
                     (OR (ZEROP (REM (|PFO;kbadBadNum| |b| |m| $) |p|))
                         (ZEROP (REM (|PFO;kbadBadNum| |d| |m| $) |p|)))))
             NIL)
            ('T (NULL (ZEROP (REM (|PFO;kbad3Num| |h| |m| $) |p|))))))))) 

(DECLAIM (NOTINLINE |PointsOfFiniteOrder;|)) 

(DEFUN |PointsOfFiniteOrder| (&REST #1=#:G1455)
  (SPROG NIL
         (PROG (#2=#:G1456)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|PointsOfFiniteOrder|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |PointsOfFiniteOrder;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|PointsOfFiniteOrder|)))))))))) 

(DEFUN |PointsOfFiniteOrder;| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT |dv$| (LIST '|PointsOfFiniteOrder| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 221))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (AND
                                         (|HasCategory| |#1|
                                                        '(|CharacteristicZero|))
                                         (|HasCategory| |#2|
                                                        '(|AlgebraicallyClosedField|)))))))
    (|haddProp| |$ConstructorCache| '|PointsOfFiniteOrder|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 11 '|%alg|)
    (QSETREFV $ 12 (|FunctionSpaceReduce| |#1| |#2|))
    (COND
     ((|HasCategory| |#1| '(|GcdDomain|))
      (QSETREFV $ 101 (CONS (|dispatchFunction| |PFO;cmult;LSmp;21|) $)))
     ('T (QSETREFV $ 101 (CONS (|dispatchFunction| |PFO;cmult;LSmp;22|) $))))
    (COND
     ((|domainEqual| |#1| (|Complex| (|Integer|)))
      (COND
       ((|domainEqual| |#2| (|Expression| |#1|))
        (PROGN
         (QSETREFV $ 172
                   (CONS (|dispatchFunction| |PFO;handle_imaginary;FdR;33|)
                         $))))
       ('T
        (QSETREFV $ 172
                  (CONS (|dispatchFunction| |PFO;handle_imaginary;FdR;34|)
                        $)))))
     ('T
      (QSETREFV $ 172
                (CONS (|dispatchFunction| |PFO;handle_imaginary;FdR;35|) $))))
    (COND
     ((|HasCategory| |#1| '(|CharacteristicZero|))
      (COND
       ((|HasCategory| |#2| '(|AlgebraicallyClosedField|))
        (QSETREFV $ 202
                  (CONS (|dispatchFunction| |PFO;simplifyCoeffs;RLNni;41|)
                        $))))))
    $))) 

(MAKEPROP '|PointsOfFiniteOrder| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|) 'ALGOP '|q|
              (|Union| 83 '#1="failed") (|FiniteDivisor| 7 8 9 10)
              |PFO;order;FdU;45| (|Boolean|) |PFO;torsion?;FdB;1| (|Integer|)
              (|Fraction| 18) (0 . |numer|) (5 . |coerce|) (10 . |denom|)
              (15 . /) (|Mapping| 7 19)
              (|SparseUnivariatePolynomial| (|Fraction| 29))
              (|MultipleMap| 19 29 25 7 8 9) (21 . |map|)
              (|SparseUnivariatePolynomial| 7)
              (|SparseUnivariatePolynomial| 19)
              (|SparseUnivariatePolynomialFunctions2| 19 7) (27 . |map|)
              (|Kernel| $) (33 . |coerce|) (38 . |elt|) (|Mapping| 7 29)
              (|SparseUnivariatePolynomial| 29)
              (|UnivariatePolynomialCategoryFunctions2| 29 36 7 8) (44 . |map|)
              (50 . |bringDown|) (|Mapping| 19 7)
              (|UnivariatePolynomialCategoryFunctions2| 7 28 19 29)
              (55 . |map|) (|MultipleMap| 7 8 9 19 29 25) (61 . |map|)
              (|UnivariatePolynomialCategoryFunctions2| 7 8 19 29) (67 . |map|)
              (|Kernel| 7) (73 . |bringDown|) (|Mapping| 29 7)
              (|UnivariatePolynomialCategoryFunctions2| 7 8 29 36) (79 . |map|)
              (|Fraction| 8) (85 . |retract|) (|SparseUnivariatePolynomial| 36)
              (|Mapping| 36 52)
              (|UnivariatePolynomialCategoryFunctions2| 52 9 36 54)
              (90 . |map|) (|List| 7) (96 . |coefficients|) (|List| 32)
              (|List| $) (101 . |algtower|) (|Factored| 29)
              (|RationalFactorize| 29) (106 . |factor|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 66) (|:| |factor| 29) (|:| |exponent| 83))
              (|List| 67) (111 . |factorList|) (116 . |One|) (|List| 29)
              (120 . |coefficients|) (125 . |rem|)
              (|Record| (|:| |den| 18) (|:| |gcdnum| 18))
              (|PointsOfFiniteOrderTools| 29 25) (131 . |badNum|) (|List| 74)
              (136 . |mix|) (|List| 36) (141 . |coefficients|) (146 . |lcm|)
              (151 . |reduce|) (|NonNegativeInteger|)
              |PFO;possibleOrder;FdNni;42| (156 . *) (|Union| 10 '"failed")
              (162 . |generator|)
              (|Record| (|:| |order| 83) (|:| |function| 10))
              (|Union| 88 '#2="failed") |PFO;torsionIfCan;FdU;17|
              (|UnivariatePolynomialCategoryFunctions2| 19 29 7 8)
              (167 . |map|) (173 . |elt|) (179 . |coerce|) (|Mapping| 52 36)
              (|UnivariatePolynomialCategoryFunctions2| 36 54 52 9)
              (184 . |map|) (|SparseMultivariatePolynomial| 6 47) (190 . |lcm|)
              (|List| 98) (195 . |cmult|) (200 . *) (206 . |One|)
              (210 . |discriminant|) (215 . |differentiate|) (220 . |gcd|)
              (|Union| $ '"failed") (226 . |exquo|) (232 . |discriminant|)
              (236 . |discriminant|) (241 . |zero?|) (|List| 19)
              (246 . |coefficients|) (251 . |retract|) (256 . |gcd|)
              (|SparseMultivariatePolynomial| 6 32) (261 . |denom|) (|List| 52)
              (266 . |coefficients|) (271 . |coerce|) (276 . |coerce|)
              (281 . *) (|Union| 52 '#3="failed") (287 . |retractIfCan|)
              (292 . |lift|) (|List| 47) (297 . |setUnion|)
              (|FractionalIdeal| 8 52 9 10) (303 . |ideal|) (|Vector| 10)
              (308 . |numer|) (|BasicOperator|) (313 . |operator|) (|Symbol|)
              (318 . |has?|) (324 . |denom|) (329 . |minIndex|)
              (|Mapping| 16 47) (334 . |select!|) (340 . |definingPolynomial|)
              (|List| 9) (|Vector| 9) (344 . |entries|) (|Complex| 18)
              (349 . |real|) (354 . |coerce|) (|Mapping| 6 6) (359 . |map|)
              (365 . |imag|) (370 . *) (376 . +) (382 . |numer|)
              (|Mapping| 7 7) (387 . |map|) (|Mapping| 8 8) (393 . |map|)
              (|Mapping| 52 52) (399 . |map|) (405 . |One|) (409 . |monomial|)
              (415 . |One|) (419 . +) (|SparseUnivariatePolynomial| $)
              (|Expression| 6) (425 . |rootOf|) (|List| 10) (430 . |entries|)
              (435 . |vector|) (440 . |coerce|) (445 . ~=)
              (|Record| (|:| |ncurve| 9) (|:| |n_div_numer| 142)
                        (|:| |n_div_denom| 9) (|:| |need_change| 16))
              (451 . |handle_imaginary|) (456 . |minPoly|) (|Union| 19 '#3#)
              (461 . |retractIfCan|) (466 . |coefficients|) (|Mapping| 16 7)
              (471 . |every?|) (477 . |rootOf|) (482 . |kernels|)
              (487 . |minimize|) (492 . |elt|) (498 . |retract|)
              (503 . |primitivePart|) (508 . |norm|)
              (|Record| (|:| |primePart| $) (|:| |commonPart| $))
              (513 . |separate|) (519 . |resultant|) (525 . |Zero|)
              (529 . |Zero|) (533 . |separate|) (539 . |resultant|)
              (|PositiveInteger|) (545 . |rank|) (549 . |factorial|)
              (554 . |badNum|) (559 . |getGoodPrime|) (564 . |eval|)
              (|Record| (|:| |primelt| 7) (|:| |poly| (|List| 28))
                        (|:| |prim| 28))
              (|FunctionSpacePrimitiveElement| 6 7) (571 . |primitiveElement|)
              (576 . |simplifyCoeffs|) (582 . |genus|)
              (|Record| (|:| |id| 128) (|:| |principalPart| 10))
              (586 . |decompose|) (591 . |divisor|) (596 . |reduce|) (601 . /)
              (607 . |ideal|) (|Void|) (612 . |newReduc|) (617 . |polyred|)
              (622 . |doubleDisc|) (|Record| (|:| |num| 29) (|:| |den| 18))
              (|UnivariatePolynomialCommonDenominator| 18 19 29)
              (627 . |splitDenominator|) (632 . |principal?|)
              (|IntegerPrimesPackage| 18) (637 . |nextPrime|) (642 . |coerce|))
           '#(|torsionIfCan| 647 |torsion?| 652 |simplifyCoeffs| 657
              |possibleOrder| 663 |order| 668 |handle_imaginary| 673 |cmult|
              678)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|order|
                                 ((|Union| (|NonNegativeInteger|) #1#)
                                  (|FiniteDivisor| |#2| |#3| |#4| |#5|)))
                                T)
                              '((|torsion?|
                                 ((|Boolean|)
                                  (|FiniteDivisor| |#2| |#3| |#4| |#5|)))
                                T)
                              '((|torsionIfCan|
                                 ((|Union|
                                   (|Record|
                                    (|:| |order| (|NonNegativeInteger|))
                                    (|:| |function| |#5|))
                                   #2#)
                                  (|FiniteDivisor| |#2| |#3| |#4| |#5|)))
                                T)
                              '((|cmult|
                                 ((|SparseMultivariatePolynomial| |#1|
                                                                  (|Kernel|
                                                                   |#2|))
                                  (|List|
                                   (|SparseMultivariatePolynomial| |#1|
                                                                   (|Kernel|
                                                                    |#2|)))))
                                T)
                              '((|possibleOrder|
                                 ((|NonNegativeInteger|)
                                  (|FiniteDivisor| |#2| |#3| |#4| |#5|)))
                                T)
                              '((|handle_imaginary|
                                 ((|Record| (|:| |ncurve| |#4|)
                                            (|:| |n_div_numer| (|Vector| |#4|))
                                            (|:| |n_div_denom| |#4|)
                                            (|:| |need_change| (|Boolean|)))
                                  (|FiniteDivisor| |#2| |#3| |#4| |#5|)))
                                T)
                              '((|simplifyCoeffs|
                                 ((|NonNegativeInteger|)
                                  (|Record| (|:| |ncurve| |#4|)
                                            (|:| |n_div_numer| (|Vector| |#4|))
                                            (|:| |n_div_denom| |#4|)
                                            (|:| |need_change| (|Boolean|)))
                                  (|List| (|Kernel| |#2|))))
                                (AND (|has| 7 (|AlgebraicallyClosedField|))
                                     (|has| 6 (|CharacteristicZero|)))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 220
                                            '(1 19 18 0 20 1 7 0 18 21 1 19 18
                                              0 22 2 7 0 0 0 23 2 26 9 24 25 27
                                              2 30 28 24 29 31 1 7 0 32 33 2 28
                                              7 0 7 34 2 37 8 35 36 38 1 12 19
                                              7 39 2 41 29 40 28 42 2 43 25 40
                                              9 44 2 45 29 40 8 46 2 12 29 7 47
                                              48 2 50 36 49 8 51 1 52 8 0 53 2
                                              56 54 55 9 57 1 8 58 0 59 1 7 60
                                              61 62 1 64 63 29 65 1 63 68 0 69
                                              0 6 0 70 1 36 71 0 72 2 29 0 0 0
                                              73 1 75 74 29 76 1 75 18 77 78 1
                                              54 79 0 80 1 18 0 61 81 1 14 0 0
                                              82 2 14 0 18 0 85 1 14 86 0 87 2
                                              91 8 24 29 92 2 8 7 0 7 93 1 52 0
                                              8 94 2 96 9 95 54 97 1 98 0 61 99
                                              1 0 98 100 101 2 98 0 0 0 102 0
                                              98 0 103 1 54 36 0 104 1 36 0 0
                                              105 2 36 0 0 0 106 2 36 107 0 0
                                              108 0 10 52 109 1 36 29 0 110 1
                                              29 16 0 111 1 29 112 0 113 1 19
                                              18 0 114 1 18 0 61 115 1 7 116 0
                                              117 1 9 118 0 119 1 7 0 116 120 1
                                              8 0 7 121 2 9 0 52 0 122 1 10 123
                                              0 124 1 10 9 0 125 2 126 0 0 0
                                              127 1 14 128 0 129 1 128 130 0
                                              131 1 47 132 0 133 2 132 16 0 134
                                              135 1 128 8 0 136 1 130 18 0 137
                                              2 126 0 138 0 139 0 10 9 140 1
                                              142 141 0 143 1 144 18 0 145 1 6
                                              0 18 146 2 98 0 147 0 148 1 144
                                              18 0 149 2 7 0 0 0 150 2 7 0 0 0
                                              151 1 7 116 0 152 2 8 0 153 0 154
                                              2 52 0 155 0 156 2 9 0 157 0 158
                                              0 7 0 159 2 28 0 7 83 160 0 28 0
                                              161 2 28 0 0 0 162 1 164 0 163
                                              165 1 130 166 0 167 1 142 0 141
                                              168 1 9 0 52 169 2 9 16 0 0 170 1
                                              0 171 14 172 1 7 163 32 173 1 7
                                              174 0 175 1 28 58 0 176 2 58 16
                                              177 0 178 1 7 0 163 179 1 7 60 0
                                              180 1 128 0 0 181 2 130 10 0 18
                                              182 1 10 52 0 183 1 8 0 0 184 1
                                              10 52 0 185 2 8 186 0 0 187 2 8 7
                                              0 0 188 0 6 0 189 0 7 0 190 2 29
                                              186 0 0 191 2 29 19 0 0 192 0 10
                                              193 194 1 18 0 0 195 1 75 18 25
                                              196 1 75 193 18 197 3 7 0 0 60 61
                                              198 1 200 199 58 201 2 0 83 171
                                              126 202 0 10 83 203 1 14 204 0
                                              205 1 14 0 128 206 1 10 0 9 207 2
                                              10 0 0 0 208 1 128 0 130 209 1 12
                                              210 18 211 1 75 25 25 212 1 75 18
                                              25 213 1 215 214 29 216 1 14 16 0
                                              217 1 218 18 18 219 1 19 0 18 220
                                              1 0 89 14 90 1 0 16 14 17 2 1 83
                                              171 126 202 1 0 83 14 84 1 0 13
                                              14 15 1 0 171 14 172 1 0 98 100
                                              101)))))
           '|lookupComplete|)) 
