
(SDEFUN |MOMPKG;cumulant2moment;2S;1|
        ((|cum| (|Sequence| R)) ($ (|Sequence| R)))
        (SPADCALL
         (SPADCALL (SPADCALL (SPADCALL |cum| (QREFELT $ 9)) (QREFELT $ 11))
                   (QREFELT $ 12))
         (QREFELT $ 13))) 

(SDEFUN |MOMPKG;moment2cumulant;2S;2|
        ((|mom| (|Sequence| R)) ($ (|Sequence| R)))
        (SPADCALL
         (SPADCALL (SPADCALL (SPADCALL |mom| (QREFELT $ 9)) (QREFELT $ 15))
                   (QREFELT $ 12))
         (QREFELT $ 13))) 

(SDEFUN |MOMPKG;freeCumulant2moment;2S;3|
        ((|cum| (|Sequence| R)) ($ (|Sequence| R)))
        (SPADCALL
         (SPADCALL
          (SPADCALL
           (SPADCALL
            (SPADCALL (|spadConstant| $ 17) (SPADCALL |cum| (QREFELT $ 9))
                      (QREFELT $ 18))
            (QREFELT $ 20))
           (QREFELT $ 12))
          (QREFELT $ 12))
         (QREFELT $ 21))) 

(SDEFUN |MOMPKG;moment2freeCumulant;2S;4|
        ((|mom| (|Sequence| R)) ($ (|Sequence| R)))
        (SPROG
         ((#1=#:G695 NIL) (|f1| #2=(|Union| (|Stream| R) "failed"))
          (|f| (|Stream| R)) (|g1| #2#) (|g| (|Stream| R)))
         (SEQ
          (LETT |g|
                (SPADCALL (|spadConstant| $ 17) (SPADCALL |mom| (QREFELT $ 9))
                          (QREFELT $ 23)))
          (LETT |g1| (SPADCALL |g| (QREFELT $ 25)))
          (LETT |f|
                (SPADCALL
                 (PROG2 (LETT #1# |g1|)
                     (QCDR #1#)
                   (|check_union2| (QEQCAR #1# 0) (|Stream| (QREFELT $ 6))
                                   (|Union| (|Stream| (QREFELT $ 6))
                                            #3="failed")
                                   #1#))
                 (QREFELT $ 20)))
          (LETT |f1| (SPADCALL (SPADCALL |f| (QREFELT $ 12)) (QREFELT $ 25)))
          (EXIT
           (SPADCALL
            (SPADCALL
             (PROG2 (LETT #1# |f1|)
                 (QCDR #1#)
               (|check_union2| (QEQCAR #1# 0) (|Stream| (QREFELT $ 6))
                               (|Union| (|Stream| (QREFELT $ 6)) #3#) #1#))
             (QREFELT $ 12))
            (QREFELT $ 21)))))) 

(SDEFUN |MOMPKG;booleanCumulant2moment;2S;5|
        ((|x| (|Sequence| R)) ($ (|Sequence| R)))
        (SPROG
         ((#1=#:G700 NIL) (|boo| (|Union| (|Stream| R) "failed"))
          (|rec| (|Stream| R)))
         (SEQ
          (LETT |rec|
                (SPADCALL (|spadConstant| $ 17)
                          (SPADCALL (SPADCALL |x| (QREFELT $ 27))
                                    (QREFELT $ 9))
                          (QREFELT $ 23)))
          (LETT |boo| (SPADCALL |rec| (QREFELT $ 25)))
          (EXIT
           (SPADCALL
            (SPADCALL
             (PROG2 (LETT #1# |boo|)
                 (QCDR #1#)
               (|check_union2| (QEQCAR #1# 0) (|Stream| (QREFELT $ 6))
                               (|Union| (|Stream| (QREFELT $ 6)) "failed")
                               #1#))
             (QREFELT $ 13))
            (QREFELT $ 28)))))) 

(SDEFUN |MOMPKG;moment2booleanCumulant;2S;6|
        ((|x| (|Sequence| R)) ($ (|Sequence| R)))
        (SPROG
         ((#1=#:G705 NIL) (|mom| (|Union| (|Stream| R) "failed"))
          (|boo| (|Stream| R)))
         (SEQ
          (LETT |boo|
                (SPADCALL (|spadConstant| $ 17) (SPADCALL |x| (QREFELT $ 9))
                          (QREFELT $ 23)))
          (LETT |mom| (SPADCALL |boo| (QREFELT $ 25)))
          (EXIT
           (SPADCALL
            (SPADCALL
             (SPADCALL
              (PROG2 (LETT #1# |mom|)
                  (QCDR #1#)
                (|check_union2| (QEQCAR #1# 0) (|Stream| (QREFELT $ 6))
                                (|Union| (|Stream| (QREFELT $ 6)) "failed")
                                #1#))
              (QREFELT $ 13))
             (QREFELT $ 27))
            (QREFELT $ 28)))))) 

(SDEFUN |MOMPKG;hankelDeterminant;SNniR;7|
        ((|x| (|Sequence| R)) (|n| (|NonNegativeInteger|)) ($ (R)))
        (SPADCALL
         (SPADCALL
          (CONS (|spadConstant| $ 17) (SPADCALL |x| (* 2 |n|) (QREFELT $ 33)))
          (QREFELT $ 36))
         (QREFELT $ 37))) 

(SDEFUN |MOMPKG;moment2nthJacobi;LR;8|
        ((|mom| (|List| R))
         ($ (|Record| (|:| |an| (|List| R)) (|:| |bn| (|List| R)))))
        (SPROG
         ((N (|Integer|)) (G (|List| R)) (#1=#:G755 NIL) (|h| NIL)
          (#2=#:G754 NIL) (H (|List| R)) (|Hk| (R)) (#3=#:G753 NIL) (|l| NIL)
          (#4=#:G752 NIL) (|k| NIL) (|bb| #5=(|List| R)) (|aa| #5#) (|bk| (R))
          (|ak| (R)))
         (SEQ (LETT N (LENGTH |mom|)) (LETT G |mom|) (LETT |aa| NIL)
              (LETT |bb| NIL)
              (SEQ G190 (COND ((NULL (> N 1)) (GO G191)))
                   (SEQ (LETT |ak| (|SPADfirst| G))
                        (LETT |bk|
                              (SPADCALL (SPADCALL G (QREFELT $ 39))
                                        (SPADCALL |ak| |ak| (QREFELT $ 40))
                                        (QREFELT $ 41)))
                        (LETT |aa| (SPADCALL |aa| |ak| (QREFELT $ 42)))
                        (LETT |bb| (SPADCALL |bb| |bk| (QREFELT $ 42)))
                        (LETT H
                              (LIST (SPADCALL |ak| (QREFELT $ 43))
                                    (SPADCALL |bk| (QREFELT $ 43))))
                        (SEQ (LETT |k| 3) (LETT #4# N) G190
                             (COND ((> |k| #4#) (GO G191)))
                             (SEQ
                              (LETT |Hk|
                                    (SPADCALL (SPADCALL G |k| (QREFELT $ 45))
                                              (QREFELT $ 43)))
                              (SEQ (LETT |l| 1) (LETT #3# (- |k| 1)) G190
                                   (COND ((|greater_SI| |l| #3#) (GO G191)))
                                   (SEQ
                                    (EXIT
                                     (LETT |Hk|
                                           (SPADCALL |Hk|
                                                     (SPADCALL
                                                      (SPADCALL G |l|
                                                                (QREFELT $ 45))
                                                      (SPADCALL H (- |k| |l|)
                                                                (QREFELT $ 45))
                                                      (QREFELT $ 40))
                                                     (QREFELT $ 41)))))
                                   (LETT |l| (|inc_SI| |l|)) (GO G190) G191
                                   (EXIT NIL))
                              (EXIT (LETT H (SPADCALL H |Hk| (QREFELT $ 42)))))
                             (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
                        (COND
                         ((|HasCategory| (QREFELT $ 6) '(|Field|))
                          (SEQ
                           (LETT G
                                 (PROGN
                                  (LETT #2# NIL)
                                  (SEQ (LETT |h| NIL) (LETT #1# H) G190
                                       (COND
                                        ((OR (ATOM #1#)
                                             (PROGN (LETT |h| (CAR #1#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #2#
                                               (CONS
                                                (SPADCALL
                                                 (SPADCALL |h| |bk|
                                                           (QREFELT $ 46))
                                                 (QREFELT $ 43))
                                                #2#))))
                                       (LETT #1# (CDR #1#)) (GO G190) G191
                                       (EXIT (NREVERSE #2#)))))
                           (EXIT (LETT G (CDR (CDR G)))))))
                        (EXIT (LETT N (- N 2))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |aa| |bb|))))) 

(SDEFUN |MOMPKG;moment2jacobi2;SS;9|
        ((|mom| (|Sequence| R))
         ($ (|Stream| (|Record| (|:| |an| R) (|:| |bn| R)))))
        (SPROG NIL
               (SEQ
                (SPADCALL
                 (CONS #'|MOMPKG;moment2jacobi2;SS;9!0|
                       (VECTOR (QREFELT $ 6) |mom| $))
                 (QREFELT $ 60))))) 

(SDEFUN |MOMPKG;moment2jacobi2;SS;9!0| (($$ NIL))
        (PROG ($ |mom| R)
          (LETT $ (QREFELT $$ 2))
          (LETT |mom| (QREFELT $$ 1))
          (LETT R (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG
             ((|gseries| NIL) (#1=#:G757 NIL) (|a| NIL) (|gseries1| NIL)
              (|b| NIL))
             (SEQ
              (LETT |gseries|
                    (SPADCALL (|spadConstant| $ 17)
                              (SPADCALL |mom| (QREFELT $ 9)) (QREFELT $ 23)))
              (LETT |gseries1|
                    (PROG2 (LETT #1# (SPADCALL |gseries| (QREFELT $ 25)))
                        (QCDR #1#)
                      (|check_union2| (QEQCAR #1# 0) (|Stream| R)
                                      (|Union| (|Stream| R) "failed") #1#)))
              (LETT |gseries1| (SPADCALL |gseries1| (QREFELT $ 12)))
              (LETT |a|
                    (SPADCALL (SPADCALL |gseries1| (QREFELT $ 49))
                              (QREFELT $ 43)))
              (LETT |gseries1| (SPADCALL |gseries1| (QREFELT $ 12)))
              (LETT |b|
                    (SPADCALL (SPADCALL |gseries1| (QREFELT $ 49))
                              (QREFELT $ 43)))
              (EXIT
               (SPADCALL (CONS |a| |b|)
                         (SPADCALL
                          (SPADCALL
                           (SPADCALL (SPADCALL |b| (QREFELT $ 50))
                                     (SPADCALL
                                      (SPADCALL |gseries1| (QREFELT $ 51))
                                      (QREFELT $ 13))
                                     (QREFELT $ 52))
                           (QREFELT $ 27))
                          (QREFELT $ 55))
                         (QREFELT $ 56))))))))) 

(SDEFUN |MOMPKG;moment2jacobi;SR;10|
        ((|mom| (|Sequence| R))
         ($ (|Record| (|:| |an| (|Stream| R)) (|:| |bn| (|Stream| R)))))
        (SPROG ((|res| (|Stream| (|Record| (|:| |an| R) (|:| |bn| R)))))
               (SEQ (LETT |res| (SPADCALL |mom| (QREFELT $ 55)))
                    (EXIT
                     (CONS
                      (SPADCALL (LIST #'|MOMPKG;moment2jacobi;SR;10!0|) |res|
                                (QREFELT $ 63))
                      (SPADCALL (LIST #'|MOMPKG;moment2jacobi;SR;10!1|) |res|
                                (QREFELT $ 63))))))) 

(SDEFUN |MOMPKG;moment2jacobi;SR;10!1| ((|y| NIL) ($$ NIL)) (QCDR |y|)) 

(SDEFUN |MOMPKG;moment2jacobi;SR;10!0| ((|y| NIL) ($$ NIL)) (QCAR |y|)) 

(SDEFUN |MOMPKG;jacobi2polypq|
        ((|aa| (|Stream| R)) (|bb| (|Stream| R))
         (|p| (|SparseUnivariatePolynomial| R))
         (|q| (|SparseUnivariatePolynomial| R))
         ($
          (|Stream|
           (|Record| (|:| |first| (|SparseUnivariatePolynomial| R))
                     (|:| |second| (|SparseUnivariatePolynomial| R))))))
        (SPROG NIL
               (SEQ
                (SPADCALL
                 (CONS #'|MOMPKG;jacobi2polypq!0|
                       (VECTOR |p| |bb| |q| $ |aa| (QREFELT $ 69)))
                 (QREFELT $ 76))))) 

(SDEFUN |MOMPKG;jacobi2polypq!0| (($$ NIL))
        (PROG (|xsup| |aa| $ |q| |bb| |p|)
          (LETT |xsup| (QREFELT $$ 5))
          (LETT |aa| (QREFELT $$ 4))
          (LETT $ (QREFELT $$ 3))
          (LETT |q| (QREFELT $$ 2))
          (LETT |bb| (QREFELT $$ 1))
          (LETT |p| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|q1| NIL) (|pq1| NIL))
                   (SEQ
                    (LETT |q1|
                          (SPADCALL
                           (SPADCALL
                            (SPADCALL |xsup|
                                      (SPADCALL (SPADCALL |aa| (QREFELT $ 49))
                                                (|spadConstant| $ 67)
                                                (QREFELT $ 70))
                                      (QREFELT $ 71))
                            |q| (QREFELT $ 72))
                           (SPADCALL (SPADCALL |bb| (QREFELT $ 49)) |p|
                                     (QREFELT $ 70))
                           (QREFELT $ 71)))
                    (LETT |pq1| (CONS |q| |q1|))
                    (EXIT
                     (SPADCALL |pq1|
                               (|MOMPKG;jacobi2polypq|
                                (SPADCALL |aa| (QREFELT $ 12))
                                (SPADCALL |bb| (QREFELT $ 12)) |q| |q1| $)
                               (QREFELT $ 75))))))))) 

(SDEFUN |MOMPKG;jacobi2poly;2SS;12|
        ((|aa| (|Stream| R)) (|bb| (|Stream| R))
         ($ (|Stream| (|SparseUnivariatePolynomial| R))))
        (SPROG
         ((|res|
           (|Stream|
            (|Record| (|:| |first| (|SparseUnivariatePolynomial| R))
                      (|:| |second| (|SparseUnivariatePolynomial| R)))))
          (|p1| (|SparseUnivariatePolynomial| R))
          (|p0| (|SparseUnivariatePolynomial| R)))
         (SEQ (LETT |p0| (|spadConstant| $ 67))
              (LETT |p1|
                    (SPADCALL (QREFELT $ 69)
                              (SPADCALL (SPADCALL |aa| (QREFELT $ 49)) |p0|
                                        (QREFELT $ 70))
                              (QREFELT $ 71)))
              (LETT |res|
                    (|MOMPKG;jacobi2polypq| (SPADCALL |aa| (QREFELT $ 12)) |bb|
                     |p0| |p1| $))
              (EXIT
               (SPADCALL (LIST #'|MOMPKG;jacobi2poly;2SS;12!0|) |res|
                         (QREFELT $ 80)))))) 

(SDEFUN |MOMPKG;jacobi2poly;2SS;12!0| ((|pp| NIL) ($$ NIL)) (QCAR |pp|)) 

(SDEFUN |MOMPKG;moment2Stransform;SR;13|
        ((|x| (|Sequence| R))
         ($
          (|Record| (|:| |puiseux| (|Fraction| (|Integer|)))
                    (|:| |laurent| (|Fraction| (|Integer|)))
                    (|:| |coef| (|Sequence| R)))))
        (SPROG
         ((S #1=(|Sequence| R)) (|chi| #2=(|Stream| R)) (|mom| (|Stream| R))
          (S2 #1#) (|chi2s| (|Sequence| R)) (|chi2| #2#) (|mom2| (|Stream| R)))
         (SEQ (LETT |mom| (SPADCALL |x| (QREFELT $ 9)))
              (EXIT
               (COND
                ((SPADCALL (SPADCALL |mom| (QREFELT $ 49)) (QREFELT $ 83))
                 (SEQ
                  (LETT |mom2|
                        (SPADCALL (|spadConstant| $ 84)
                                  (SPADCALL (SPADCALL 1 2 (QREFELT $ 87))
                                            (SPADCALL |mom| (QREFELT $ 12))
                                            (QREFELT $ 88))
                                  (QREFELT $ 23)))
                  (LETT |chi2| (SPADCALL |mom2| (QREFELT $ 89)))
                  (LETT |chi2s| (SPADCALL |chi2| (QREFELT $ 13)))
                  (LETT S2
                        (SPADCALL
                         (SPADCALL (|spadConstant| $ 84) |chi2s|
                                   (QREFELT $ 90))
                         (SPADCALL |chi2s| (QREFELT $ 28)) (QREFELT $ 91)))
                  (EXIT
                   (VECTOR (SPADCALL 1 2 (QREFELT $ 87))
                           (SPADCALL (|spadConstant| $ 92) (QREFELT $ 93))
                           S2))))
                ('T
                 (SEQ
                  (LETT |mom|
                        (SPADCALL (|spadConstant| $ 84) |mom| (QREFELT $ 23)))
                  (LETT |chi| (SPADCALL |mom| (QREFELT $ 89)))
                  (LETT S
                        (SPADCALL (SPADCALL |chi| (QREFELT $ 13))
                                  (SPADCALL (SPADCALL |chi| (QREFELT $ 12))
                                            (QREFELT $ 13))
                                  (QREFELT $ 91)))
                  (EXIT
                   (VECTOR (|spadConstant| $ 92) (|spadConstant| $ 94)
                           S))))))))) 

(SDEFUN |MOMPKG;moment2monotoneCumulantGenerator|
        ((|srm|
          (|Record| (|:| |momt| (|List| (|SparseUnivariatePolynomial| R)))
                    (|:| |cum| (|List| R)) (|:| |mom| (|Stream| R))))
         ($
          (|Record| (|:| |momt| (|List| (|SparseUnivariatePolynomial| R)))
                    (|:| |cum| (|List| R)) (|:| |mom| (|Stream| R)))))
        (SPROG
         ((#1=#:G797 NIL) (|mtnew| (|List| (|SparseUnivariatePolynomial| R)))
          (|rrnew| (|List| R)) (|mnt| (|SparseUnivariatePolynomial| R))
          (|rn| (R)) (|tmp| (|SparseUnivariatePolynomial| R)) (#2=#:G798 NIL)
          (|k| NIL) (#3=#:G799 NIL) (|r| NIL) (#4=#:G800 NIL) (|m| NIL)
          (|n| (|Integer|)) (|mm| (|Stream| R)) (|rr| (|List| R))
          (|mt| (|List| (|SparseUnivariatePolynomial| R))))
         (SEQ
          (EXIT
           (SEQ (LETT |mt| (QVELT |srm| 0)) (LETT |rr| (QVELT |srm| 1))
                (LETT |mm| (QVELT |srm| 2)) (LETT |n| (+ (LENGTH |rr|) 1))
                (LETT |tmp| (|spadConstant| $ 85))
                (SEQ (LETT |m| NIL) (LETT #4# (REVERSE |mt|)) (LETT |r| NIL)
                     (LETT #3# |rr|) (LETT |k| 2) (LETT #2# |n|) G190
                     (COND
                      ((OR (|greater_SI| |k| #2#) (ATOM #3#)
                           (PROGN (LETT |r| (CAR #3#)) NIL) (ATOM #4#)
                           (PROGN (LETT |m| (CAR #4#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |tmp|
                             (SPADCALL |tmp|
                                       (SPADCALL
                                        (SPADCALL |k| |m| (QREFELT $ 98)) |r|
                                        (QREFELT $ 99))
                                       (QREFELT $ 100)))))
                     (LETT |k|
                           (PROG1 (|inc_SI| |k|)
                             (LETT #3#
                                   (PROG1 (CDR #3#) (LETT #4# (CDR #4#))))))
                     (GO G190) G191 (EXIT NIL))
                (LETT |mnt| (SPADCALL |tmp| (QREFELT $ 101)))
                (LETT |rn|
                      (SPADCALL (SPADCALL |mm| (QREFELT $ 49))
                                (SPADCALL |mnt| (|spadConstant| $ 17)
                                          (QREFELT $ 102))
                                (QREFELT $ 41)))
                (LETT |mnt|
                      (SPADCALL |mnt|
                                (SPADCALL (QREFELT $ 97) |rn| (QREFELT $ 99))
                                (QREFELT $ 100)))
                (LETT |rrnew| (CONS |rn| |rr|))
                (LETT |mtnew| (CONS |mnt| |mt|))
                (EXIT
                 (PROGN
                  (LETT #1#
                        (VECTOR |mtnew| |rrnew|
                                (SPADCALL |mm| (QREFELT $ 12))))
                  (GO #5=#:G796)))))
          #5# (EXIT #1#)))) 

(SDEFUN |MOMPKG;moment2monotoneCumulant;2S;15|
        ((|mm| (|Sequence| R)) ($ (|Sequence| R)))
        (SPROG
         ((|res1| (|Stream| R))
          (|res|
           (|Stream|
            (|Record| (|:| |momt| (|List| (|SparseUnivariatePolynomial| R)))
                      (|:| |cum| (|List| R)) (|:| |mom| (|Stream| R)))))
          (|mtr1|
           (|Record| (|:| |momt| (|List| (|SparseUnivariatePolynomial| R)))
                     (|:| |cum| (|List| R)) (|:| |mom| (|Stream| R))))
          (|r1| (R)) (|m1t| (|SparseUnivariatePolynomial| R)))
         (SEQ
          (LETT |m1t|
                (SPADCALL (SPADCALL |mm| (QREFELT $ 103)) 1 (QREFELT $ 68)))
          (LETT |r1| (SPADCALL |mm| (QREFELT $ 103)))
          (LETT |mtr1|
                (VECTOR (LIST |m1t|) (LIST |r1|)
                        (SPADCALL (SPADCALL |mm| (QREFELT $ 9))
                                  (QREFELT $ 12))))
          (LETT |res|
                (SPADCALL
                 (CONS (|function| |MOMPKG;moment2monotoneCumulantGenerator|)
                       $)
                 |mtr1| (QREFELT $ 107)))
          (LETT |res1|
                (SPADCALL (CONS #'|MOMPKG;moment2monotoneCumulant;2S;15!0| $)
                          |res| (QREFELT $ 111)))
          (EXIT (SPADCALL |res1| (QREFELT $ 13)))))) 

(SDEFUN |MOMPKG;moment2monotoneCumulant;2S;15!0| ((|s| NIL) ($ NIL))
        (SPADCALL (QVELT |s| 1) (QREFELT $ 108))) 

(SDEFUN |MOMPKG;monotoneCumulant2momentGenerator|
        ((|srm|
          (|Record| (|:| |cum| (|Stream| R))
                    (|:| |momt| (|List| (|SparseUnivariatePolynomial| R)))))
         ($
          (|Record| (|:| |cum| (|Stream| R))
                    (|:| |momt| (|List| (|SparseUnivariatePolynomial| R))))))
        (SPROG
         ((#1=#:G813 NIL) (|mtnew| (|List| (|SparseUnivariatePolynomial| R)))
          (|mnt| (|SparseUnivariatePolynomial| R)) (|rr| (|Stream| R))
          (|tmp| (|SparseUnivariatePolynomial| R)) (#2=#:G814 NIL) (|k| NIL)
          (#3=#:G815 NIL) (|m| NIL) (|n| (|Integer|))
          (|mt| (|List| (|SparseUnivariatePolynomial| R))))
         (SEQ
          (EXIT
           (SEQ (LETT |mt| (QCDR |srm|)) (LETT |rr| (QCAR |srm|))
                (LETT |n| (+ (LENGTH |mt|) 1))
                (LETT |tmp| (|spadConstant| $ 85))
                (SEQ (LETT |m| NIL) (LETT #3# |mt|) (LETT |k| 1)
                     (LETT #2# (- |n| 1)) G190
                     (COND
                      ((OR (|greater_SI| |k| #2#) (ATOM #3#)
                           (PROGN (LETT |m| (CAR #3#)) NIL))
                       (GO G191)))
                     (SEQ
                      (LETT |tmp|
                            (SPADCALL |tmp|
                                      (SPADCALL
                                       (SPADCALL (- (+ |n| 1) |k|) |m|
                                                 (QREFELT $ 113))
                                       (SPADCALL |rr| (QREFELT $ 49))
                                       (QREFELT $ 99))
                                      (QREFELT $ 100)))
                      (EXIT (LETT |rr| (SPADCALL |rr| (QREFELT $ 12)))))
                     (LETT |k| (PROG1 (|inc_SI| |k|) (LETT #3# (CDR #3#))))
                     (GO G190) G191 (EXIT NIL))
                (LETT |mnt|
                      (SPADCALL
                       (SPADCALL (QREFELT $ 97) (SPADCALL |rr| (QREFELT $ 49))
                                 (QREFELT $ 99))
                       (SPADCALL |tmp| (QREFELT $ 101)) (QREFELT $ 100)))
                (LETT |mtnew| (CONS |mnt| |mt|))
                (EXIT
                 (PROGN
                  (LETT #1# (CONS (QCAR |srm|) |mtnew|))
                  (GO #4=#:G812)))))
          #4# (EXIT #1#)))) 

(SDEFUN |MOMPKG;monotoneCumulant2moment;2S;17|
        ((|rr| (|Sequence| R)) ($ (|Sequence| R)))
        (SPROG
         ((|res1| (|Stream| R))
          (|res|
           (|Stream|
            (|Record| (|:| |cum| (|Stream| R))
                      (|:| |momt| (|List| (|SparseUnivariatePolynomial| R))))))
          (|mtr1|
           (|Record| (|:| |cum| (|Stream| R))
                     (|:| |momt| (|List| (|SparseUnivariatePolynomial| R)))))
          (|m1t| (|SparseUnivariatePolynomial| R)))
         (SEQ
          (LETT |m1t|
                (SPADCALL (SPADCALL |rr| (QREFELT $ 103)) 1 (QREFELT $ 68)))
          (LETT |mtr1| (CONS (SPADCALL |rr| (QREFELT $ 9)) (LIST |m1t|)))
          (LETT |res|
                (SPADCALL
                 (CONS (|function| |MOMPKG;monotoneCumulant2momentGenerator|)
                       $)
                 |mtr1| (QREFELT $ 117)))
          (LETT |res1|
                (SPADCALL (CONS #'|MOMPKG;monotoneCumulant2moment;2S;17!0| $)
                          |res| (QREFELT $ 122)))
          (EXIT (SPADCALL |res1| (QREFELT $ 13)))))) 

(SDEFUN |MOMPKG;monotoneCumulant2moment;2S;17!0| ((|s| NIL) ($ NIL))
        (SPADCALL (SPADCALL (QCDR |s|) (QREFELT $ 119)) (|spadConstant| $ 17)
                  (QREFELT $ 102))) 

(SDEFUN |MOMPKG;monotoneCumulant2momentPoly;SS;18|
        ((|rr| (|Sequence| R))
         ($ (|Sequence| (|SparseUnivariatePolynomial| R))))
        (SPROG
         ((|res1| (|Stream| (|SparseUnivariatePolynomial| R)))
          (|res|
           (|Stream|
            (|Record| (|:| |cum| (|Stream| R))
                      (|:| |momt| (|List| (|SparseUnivariatePolynomial| R))))))
          (|mtr1|
           (|Record| (|:| |cum| (|Stream| R))
                     (|:| |momt| (|List| (|SparseUnivariatePolynomial| R)))))
          (|m1t| (|SparseUnivariatePolynomial| R)))
         (SEQ
          (LETT |m1t|
                (SPADCALL (SPADCALL |rr| (QREFELT $ 103)) 1 (QREFELT $ 68)))
          (LETT |mtr1| (CONS (SPADCALL |rr| (QREFELT $ 9)) (LIST |m1t|)))
          (LETT |res|
                (SPADCALL
                 (CONS (|function| |MOMPKG;monotoneCumulant2momentGenerator|)
                       $)
                 |mtr1| (QREFELT $ 117)))
          (LETT |res1|
                (SPADCALL
                 (CONS #'|MOMPKG;monotoneCumulant2momentPoly;SS;18!0| $) |res|
                 (QREFELT $ 126)))
          (EXIT (SPADCALL |res1| (QREFELT $ 128)))))) 

(SDEFUN |MOMPKG;monotoneCumulant2momentPoly;SS;18!0| ((|s| NIL) ($ NIL))
        (SPADCALL (QCDR |s|) (QREFELT $ 119))) 

(DECLAIM (NOTINLINE |MomentPackage;|)) 

(DEFUN |MomentPackage| (#1=#:G827)
  (SPROG NIL
         (PROG (#2=#:G828)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|MomentPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|MomentPackage;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#) (HREM |$ConstructorCache| '|MomentPackage|)))))))))) 

(DEFUN |MomentPackage;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|MomentPackage| DV$1))
          (LETT $ (GETREFV 130))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3
                    (LETT |pv$|
                          (|buildPredVector| 0 0
                                             (LIST
                                              (|HasCategory| |#1|
                                                             '(|Algebra|
                                                               (|Fraction|
                                                                (|Integer|))))
                                              (|HasCategory| |#1|
                                                             '(|Field|))))))
          (|haddProp| |$ConstructorCache| '|MomentPackage| (LIST DV$1)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|testBitVector| |pv$| 2)
            (PROGN
             (QSETREFV $ 48
                       (CONS
                        (|dispatchFunction| |MOMPKG;moment2nthJacobi;LR;8|) $))
             (QSETREFV $ 55
                       (CONS (|dispatchFunction| |MOMPKG;moment2jacobi2;SS;9|)
                             $))
             (QSETREFV $ 65
                       (CONS (|dispatchFunction| |MOMPKG;moment2jacobi;SR;10|)
                             $)))))
          (QSETREFV $ 69 (SPADCALL (|spadConstant| $ 17) 1 (QREFELT $ 68)))
          (COND
           ((|testBitVector| |pv$| 1)
            (PROGN
             (QSETREFV $ 96
                       (CONS
                        (|dispatchFunction| |MOMPKG;moment2Stransform;SR;13|)
                        $))
             (QSETREFV $ 97 (SPADCALL (|spadConstant| $ 17) 1 (QREFELT $ 68)))
             (QSETREFV $ 112
                       (CONS
                        (|dispatchFunction|
                         |MOMPKG;moment2monotoneCumulant;2S;15|)
                        $))
             (SETELT $ 97 (SPADCALL (|spadConstant| $ 17) 1 (QREFELT $ 68)))
             (QSETREFV $ 123
                       (CONS
                        (|dispatchFunction|
                         |MOMPKG;monotoneCumulant2moment;2S;17|)
                        $))
             (QSETREFV $ 129
                       (CONS
                        (|dispatchFunction|
                         |MOMPKG;monotoneCumulant2momentPoly;SS;18|)
                        $)))))
          $))) 

(MAKEPROP '|MomentPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|Stream| 6)
              (|Sequence| 6) (0 . |stream|)
              (|StreamExponentialSeriesOperations| 6) (5 . |exp0|)
              (10 . |rest|) (15 . |sequence|) |MOMPKG;cumulant2moment;2S;1|
              (20 . |log1|) |MOMPKG;moment2cumulant;2S;2| (25 . |One|)
              (29 . |concat|) (|StreamTaylorSeriesOperations| 6)
              (35 . |lagrange|) (40 . |coerce|)
              |MOMPKG;freeCumulant2moment;2S;3| (45 . |cons|)
              (|Union| 7 '"failed") (51 . |recip|)
              |MOMPKG;moment2freeCumulant;2S;4| (56 . -) (61 . |rest|)
              |MOMPKG;booleanCumulant2moment;2S;5|
              |MOMPKG;moment2booleanCumulant;2S;6| (|List| 6)
              (|NonNegativeInteger|) (66 . |firstn|) (|Matrix| 6)
              (|HankelPackage| 6) (72 . |HankelMatrix|) (77 . |determinant|)
              |MOMPKG;hankelDeterminant;SNniR;7| (82 . |second|) (87 . *)
              (93 . -) (99 . |concat|) (105 . -) (|Integer|) (110 . |elt|)
              (116 . /) (|Record| (|:| |an| 31) (|:| |bn| 31))
              (122 . |moment2nthJacobi|) (127 . |first|) (132 . |inv|)
              (137 . |rst|) (142 . *) (|Record| (|:| |an| 6) (|:| |bn| 6))
              (|Stream| 53) (148 . |moment2jacobi2|) (153 . |cons|)
              (|PositiveInteger|) (159 . |One|) (|Mapping| $) (163 . |delay|)
              (|Mapping| 6 53) (|StreamFunctions2| 53 6) (168 . |map|)
              (|Record| (|:| |an| 7) (|:| |bn| 7)) (174 . |moment2jacobi|)
              (|SparseUnivariatePolynomial| 6) (179 . |One|) (183 . |monomial|)
              '|xsup| (189 . *) (195 . -) (201 . *)
              (|Record| (|:| |first| 66) (|:| |second| 66)) (|Stream| 73)
              (207 . |cons|) (213 . |delay|) (|Stream| 66) (|Mapping| 66 73)
              (|StreamFunctions2| 73 66) (218 . |map|)
              |MOMPKG;jacobi2poly;2SS;12| (|Boolean|) (224 . |zero?|)
              (229 . |Zero|) (233 . |Zero|) (|Fraction| 44) (237 . /)
              (243 . |powern|) (249 . |revert|) (254 . |cons|) (260 . +)
              (266 . |One|) (270 . -) (275 . |Zero|)
              (|Record| (|:| |puiseux| 86) (|:| |laurent| 86) (|:| |coef| 8))
              (279 . |moment2Stransform|) '|t| (284 . *) (290 . *) (296 . +)
              (302 . |integrate|) (307 . |elt|) (313 . |first|)
              (|Record| (|:| |momt| 118) (|:| |cum| 31) (|:| |mom| 7))
              (|Mapping| 104 104) (|Stream| 104) (318 . |stream|)
              (324 . |first|) (|Mapping| 6 104) (|StreamFunctions2| 104 6)
              (329 . |map|) (335 . |moment2monotoneCumulant|) (340 . *)
              (|Record| (|:| |cum| 7) (|:| |momt| 118)) (|Mapping| 114 114)
              (|Stream| 114) (346 . |stream|) (|List| 66) (352 . |first|)
              (|Mapping| 6 114) (|StreamFunctions2| 114 6) (357 . |map|)
              (363 . |monotoneCumulant2moment|) (|Mapping| 66 114)
              (|StreamFunctions2| 114 66) (368 . |map|) (|Sequence| 66)
              (374 . |sequence|) (379 . |monotoneCumulant2momentPoly|))
           '#(|monotoneCumulant2momentPoly| 384 |monotoneCumulant2moment| 389
              |moment2nthJacobi| 394 |moment2monotoneCumulant| 399
              |moment2jacobi2| 409 |moment2jacobi| 414 |moment2freeCumulant|
              419 |moment2cumulant| 424 |moment2booleanCumulant| 429
              |moment2Stransform| 434 |jacobi2poly| 439 |hankelDeterminant| 445
              |freeCumulant2moment| 451 |cumulant2moment| 456
              |booleanCumulant2moment| 461)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|cumulant2moment|
                                 ((|Sequence| |#1|) (|Sequence| |#1|)))
                                T)
                              '((|moment2cumulant|
                                 ((|Sequence| |#1|) (|Sequence| |#1|)))
                                T)
                              '((|moment2nthJacobi|
                                 ((|Record| (|:| |an| (|List| |#1|))
                                            (|:| |bn| (|List| |#1|)))
                                  (|List| |#1|)))
                                (|has| 6 (|Field|)))
                              '((|moment2jacobi|
                                 ((|Record| (|:| |an| (|Stream| |#1|))
                                            (|:| |bn| (|Stream| |#1|)))
                                  (|Sequence| |#1|)))
                                (|has| 6 (|Field|)))
                              '((|moment2jacobi2|
                                 ((|Stream|
                                   (|Record| (|:| |an| |#1|) (|:| |bn| |#1|)))
                                  (|Sequence| |#1|)))
                                (|has| 6 (|Field|)))
                              '((|freeCumulant2moment|
                                 ((|Sequence| |#1|) (|Sequence| |#1|)))
                                T)
                              '((|moment2freeCumulant|
                                 ((|Sequence| |#1|) (|Sequence| |#1|)))
                                T)
                              '((|booleanCumulant2moment|
                                 ((|Sequence| |#1|) (|Sequence| |#1|)))
                                T)
                              '((|moment2booleanCumulant|
                                 ((|Sequence| |#1|) (|Sequence| |#1|)))
                                T)
                              '((|monotoneCumulant2moment|
                                 ((|Sequence| |#1|) (|Sequence| |#1|)))
                                T)
                              '((|monotoneCumulant2momentPoly|
                                 ((|Sequence|
                                   (|SparseUnivariatePolynomial| |#1|))
                                  (|Sequence| |#1|)))
                                T)
                              '((|moment2monotoneCumulant|
                                 ((|Sequence| |#1|) (|Sequence| |#1|)))
                                T)
                              '((|hankelDeterminant|
                                 (|#1| (|Sequence| |#1|)
                                  (|NonNegativeInteger|)))
                                T)
                              '((|jacobi2poly|
                                 ((|Stream|
                                   (|SparseUnivariatePolynomial| |#1|))
                                  (|Stream| |#1|) (|Stream| |#1|)))
                                T)
                              '((|moment2Stransform|
                                 ((|Record|
                                   (|:| |puiseux| (|Fraction| (|Integer|)))
                                   (|:| |laurent| (|Fraction| (|Integer|)))
                                   (|:| |coef| (|Sequence| |#1|)))
                                  (|Sequence| |#1|)))
                                (|has| 6 (|Algebra| 86)))
                              '((|moment2monotoneCumulant|
                                 ((|Sequence| |#1|) (|Sequence| |#1|)))
                                (|has| 6 (|Algebra| 86))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 129
                                            '(1 8 7 0 9 1 10 7 7 11 1 7 0 0 12
                                              1 8 0 7 13 1 10 7 7 15 0 6 0 17 2
                                              7 0 6 0 18 1 19 7 7 20 1 8 0 7 21
                                              2 7 0 6 0 23 1 19 24 7 25 1 8 0 0
                                              27 1 8 0 0 28 2 8 31 0 32 33 1 35
                                              34 31 36 1 34 6 0 37 1 31 6 0 39
                                              2 6 0 0 0 40 2 6 0 0 0 41 2 31 0
                                              0 6 42 1 6 0 0 43 2 31 6 0 44 45
                                              2 6 0 0 0 46 1 0 47 31 48 1 7 6 0
                                              49 1 6 0 0 50 1 7 0 0 51 2 8 0 6
                                              0 52 1 0 54 8 55 2 54 0 53 0 56 0
                                              57 0 58 1 54 0 59 60 2 62 7 61 54
                                              63 1 0 64 8 65 0 66 0 67 2 66 0 6
                                              32 68 2 66 0 6 0 70 2 66 0 0 0 71
                                              2 66 0 0 0 72 2 74 0 73 0 75 1 74
                                              0 59 76 2 79 77 78 74 80 1 6 82 0
                                              83 0 6 0 84 0 66 0 85 2 86 0 44
                                              44 87 2 19 7 86 7 88 1 19 7 7 89
                                              2 8 0 6 0 90 2 8 0 0 0 91 0 86 0
                                              92 1 86 0 0 93 0 86 0 94 1 0 95 8
                                              96 2 66 0 32 0 98 2 66 0 0 6 99 2
                                              66 0 0 0 100 1 66 0 0 101 2 66 6
                                              0 6 102 1 8 6 0 103 2 106 0 105
                                              104 107 1 31 6 0 108 2 110 7 109
                                              106 111 1 0 8 8 112 2 66 0 44 0
                                              113 2 116 0 115 114 117 1 118 66
                                              0 119 2 121 7 120 116 122 1 0 8 8
                                              123 2 125 77 124 116 126 1 127 0
                                              77 128 1 0 127 8 129 1 0 127 8
                                              129 1 0 8 8 123 1 2 47 31 48 1 1
                                              8 8 112 1 0 8 8 112 1 2 54 8 55 1
                                              2 64 8 65 1 0 8 8 26 1 0 8 8 16 1
                                              0 8 8 30 1 1 95 8 96 2 0 77 7 7
                                              81 2 0 6 8 32 38 1 0 8 8 22 1 0 8
                                              8 14 1 0 8 8 29)))))
           '|lookupComplete|)) 
