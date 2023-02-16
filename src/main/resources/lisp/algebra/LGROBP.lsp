
(SDEFUN |LGROBP;reduceRow|
        ((M (|Matrix| F)) (|v| (|Vector| F)) (|lastRow| (|Integer|))
         (|pivots| (|Vector| (|Integer|))) ($ (|Vector| F)))
        (SPROG
         ((|a1| (F)) (#1=#:G714 NIL) (#2=#:G725 NIL) (|kk| NIL) (#3=#:G724 NIL)
          (|vk| (F)) (|b| (F)) (|k| (|Integer|)) (|mj| (|Vector| F))
          (#4=#:G723 NIL) (|j| NIL) (|dim| (|NonNegativeInteger|)))
         (SEQ (LETT |a1| (|spadConstant| $ 13))
              (LETT |b| (|spadConstant| $ 14)) (LETT |dim| (QVSIZE |v|))
              (SEQ (LETT |j| 1) (LETT #4# |lastRow|) G190
                   (COND ((|greater_SI| |j| #4#) (GO G191)))
                   (SEQ (LETT |mj| (SPADCALL M |j| (QREFELT $ 18)))
                        (LETT |k| (SPADCALL |pivots| |j| (QREFELT $ 20)))
                        (LETT |b| (SPADCALL |mj| |k| (QREFELT $ 21)))
                        (LETT |vk| (SPADCALL |v| |k| (QREFELT $ 21)))
                        (SEQ (LETT |kk| 1) (LETT #3# (- |k| 1)) G190
                             (COND ((|greater_SI| |kk| #3#) (GO G191)))
                             (SEQ
                              (EXIT
                               (SPADCALL |v| |kk|
                                         (PROG2
                                             (LETT #1#
                                                   (SPADCALL
                                                    (SPADCALL
                                                     (SPADCALL |b|
                                                               (SPADCALL |v|
                                                                         |kk|
                                                                         (QREFELT
                                                                          $
                                                                          21))
                                                               (QREFELT $ 22))
                                                     (QREFELT $ 23))
                                                    |a1| (QREFELT $ 24)))
                                             (QCDR #1#)
                                           (|check_union2| (QEQCAR #1# 0)
                                                           (QREFELT $ 7)
                                                           (|Union|
                                                            (QREFELT $ 7)
                                                            #5="failed")
                                                           #1#))
                                         (QREFELT $ 25))))
                             (LETT |kk| (|inc_SI| |kk|)) (GO G190) G191
                             (EXIT NIL))
                        (SEQ (LETT |kk| |k|) (LETT #2# |dim|) G190
                             (COND ((> |kk| #2#) (GO G191)))
                             (SEQ
                              (EXIT
                               (SPADCALL |v| |kk|
                                         (PROG2
                                             (LETT #1#
                                                   (SPADCALL
                                                    (SPADCALL
                                                     (SPADCALL |vk|
                                                               (SPADCALL |mj|
                                                                         |kk|
                                                                         (QREFELT
                                                                          $
                                                                          21))
                                                               (QREFELT $ 22))
                                                     (SPADCALL |b|
                                                               (SPADCALL |v|
                                                                         |kk|
                                                                         (QREFELT
                                                                          $
                                                                          21))
                                                               (QREFELT $ 22))
                                                     (QREFELT $ 26))
                                                    |a1| (QREFELT $ 24)))
                                             (QCDR #1#)
                                           (|check_union2| (QEQCAR #1# 0)
                                                           (QREFELT $ 7)
                                                           (|Union|
                                                            (QREFELT $ 7) #5#)
                                                           #1#))
                                         (QREFELT $ 25))))
                             (LETT |kk| (+ |kk| 1)) (GO G190) G191 (EXIT NIL))
                        (EXIT (LETT |a1| |b|)))
                   (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
              (EXIT |v|)))) 

(SDEFUN |LGROBP;rRedPol|
        ((|f| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))
         (B (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
         ($
          #1=(|Record|
              (|:| |poly|
                   (|HomogeneousDistributedMultivariatePolynomial| |lv| F))
              (|:| |mult| F))))
        (SPROG
         ((|ggm| #1#)
          (|gg| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))
          (|gm|
           (|Record|
            (|:| |poly|
                 (|HomogeneousDistributedMultivariatePolynomial| |lv| F))
            (|:| |mult| F))))
         (SEQ (LETT |gm| (SPADCALL |f| B (QREFELT $ 31)))
              (EXIT
               (COND
                ((SPADCALL (QCAR |gm|) (|spadConstant| $ 32) (QREFELT $ 34))
                 |gm|)
                ('T
                 (SEQ (LETT |gg| (SPADCALL (QCAR |gm|) (QREFELT $ 35)))
                      (LETT |ggm| (|LGROBP;rRedPol| |gg| B $))
                      (EXIT
                       (CONS
                        (SPADCALL
                         (SPADCALL (QCDR |ggm|)
                                   (SPADCALL (QCAR |gm|) |gg| (QREFELT $ 36))
                                   (QREFELT $ 37))
                         (QCAR |ggm|) (QREFELT $ 38))
                        (SPADCALL (QCDR |ggm|) (QCDR |gm|)
                                  (QREFELT $ 22))))))))))) 

(SDEFUN |LGROBP;totolex;LL;3|
        ((B (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
         ($ (|List| (|DistributedMultivariatePolynomial| |lv| F))))
        (SPROG
         ((|nBasis| (|List| #1=(|DistributedMultivariatePolynomial| |lv| F)))
          (|i| (|NonNegativeInteger|))
          (|ltresult| (|List| (|DistributedMultivariatePolynomial| |lv| F)))
          (|result| (|List| (|DistributedMultivariatePolynomial| |lv| F)))
          (|antc| #2=(|DistributedMultivariatePolynomial| |lv| F))
          (#3=#:G760 NIL) (#4=#:G759 #2#) (#5=#:G761 #2#) (#6=#:G772 NIL)
          (|c| NIL) (#7=#:G773 NIL) (|b| NIL) (|cordlist| (|List| F))
          (#8=#:G771 NIL) (|k| NIL) (#9=#:G770 NIL)
          (|j| #10=(|NonNegativeInteger|)) (|lm| (|Vector| F)) (#11=#:G769 NIL)
          (|orecfmon|
           (|Record|
            (|:| |poly|
                 (|HomogeneousDistributedMultivariatePolynomial| |lv| F))
            (|:| |mult| F)))
          (|ofirstmon| #1#) (|veccoef| (|Vector| F)) (#12=#:G749 NIL)
          (#13=#:G746 NIL) (|cc| (F))
          (|recfmon|
           (|Record|
            (|:| |poly|
                 (|HomogeneousDistributedMultivariatePolynomial| |lv| F))
            (|:| |mult| F)))
          (|v| (|Union| (|DistributedMultivariatePolynomial| |lv| F) "failed"))
          (|firstmon| #1#) (|pivots| (|Vector| (|Integer|)))
          (|linmat| (|Matrix| F)) (|ndim1| #10#) (|ndim| (|PositiveInteger|))
          (#14=#:G738 NIL)
          (|vBasis|
           (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))))
         (SEQ (LETT |result| NIL) (LETT |ltresult| NIL)
              (LETT |vBasis| (SPADCALL B (QREFELT $ 39)))
              (LETT |nBasis| (LIST (|spadConstant| $ 41)))
              (LETT |ndim|
                    (PROG1 (LETT #14# (LENGTH |vBasis|))
                      (|check_subtype2| (> #14# 0) '(|PositiveInteger|)
                                        '(|NonNegativeInteger|) #14#)))
              (LETT |ndim1| (+ |ndim| 1))
              (LETT |linmat|
                    (SPADCALL |ndim| (+ (* 2 |ndim|) 1) (QREFELT $ 44)))
              (SPADCALL |linmat| 1 1 (|spadConstant| $ 13) (QREFELT $ 45))
              (SPADCALL |linmat| 1 |ndim1| (|spadConstant| $ 13)
                        (QREFELT $ 45))
              (LETT |pivots| (MAKEARR1 |ndim| 0))
              (SPADCALL |pivots| 1 1 (QREFELT $ 46))
              (LETT |firstmon| (|spadConstant| $ 41))
              (LETT |ofirstmon| (|spadConstant| $ 41))
              (LETT |orecfmon|
                    (CONS (|spadConstant| $ 42) (|spadConstant| $ 13)))
              (LETT |i| 2)
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL
                       (LETT |firstmon|
                             (SPADCALL |firstmon| |ltresult| (QREFELT $ 48)))
                       (|spadConstant| $ 41) (QREFELT $ 49)))
                     (GO G191)))
                   (SEQ
                    (SEQ
                     (LETT |v|
                           (SPADCALL |firstmon| |ofirstmon| (QREFELT $ 50)))
                     (EXIT
                      (COND
                       ((QEQCAR |v| 1)
                        (LETT |recfmon|
                              (|LGROBP;rRedPol|
                               (SPADCALL |firstmon| (QREFELT $ 51)) B $)))
                       ('T
                        (SEQ
                         (LETT |recfmon|
                               (|LGROBP;rRedPol|
                                (SPADCALL (SPADCALL (QCDR |v|) (QREFELT $ 51))
                                          (QCAR |orecfmon|) (QREFELT $ 52))
                                B $))
                         (EXIT
                          (PROGN
                           (RPLACD |recfmon|
                                   (SPADCALL (QCDR |recfmon|) (QCDR |orecfmon|)
                                             (QREFELT $ 22)))
                           (QCDR |recfmon|))))))))
                    (LETT |cc|
                          (SPADCALL (SPADCALL (QCAR |recfmon|) (QREFELT $ 53))
                                    (QCDR |recfmon|) (QREFELT $ 54)))
                    (PROGN
                     (RPLACA |recfmon|
                             (PROG2
                                 (LETT #13#
                                       (SPADCALL (QCAR |recfmon|) |cc|
                                                 (QREFELT $ 55)))
                                 (QCDR #13#)
                               (|check_union2| (QEQCAR #13# 0)
                                               (|HomogeneousDistributedMultivariatePolynomial|
                                                (QREFELT $ 6) (QREFELT $ 7))
                                               (|Union|
                                                (|HomogeneousDistributedMultivariatePolynomial|
                                                 (QREFELT $ 6) (QREFELT $ 7))
                                                "failed")
                                               #13#)))
                     (QCAR |recfmon|))
                    (PROGN
                     (RPLACD |recfmon|
                             (PROG2
                                 (LETT #12#
                                       (SPADCALL (QCDR |recfmon|) |cc|
                                                 (QREFELT $ 24)))
                                 (QCDR #12#)
                               (|check_union2| (QEQCAR #12# 0) (QREFELT $ 7)
                                               (|Union| (QREFELT $ 7) "failed")
                                               #12#)))
                     (QCDR |recfmon|))
                    (LETT |veccoef|
                          (SPADCALL (QCAR |recfmon|) |vBasis| (QREFELT $ 56)))
                    (LETT |ofirstmon| |firstmon|) (LETT |orecfmon| |recfmon|)
                    (LETT |lm| (SPADCALL (+ (* 2 |ndim|) 1) (QREFELT $ 57)))
                    (SEQ (LETT |j| 1) (LETT #11# |ndim|) G190
                         (COND ((|greater_SI| |j| #11#) (GO G191)))
                         (SEQ
                          (EXIT
                           (SPADCALL |lm| |j|
                                     (SPADCALL |veccoef| |j| (QREFELT $ 21))
                                     (QREFELT $ 25))))
                         (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                    (SPADCALL |lm| (+ |ndim| |i|) (QCDR |recfmon|)
                              (QREFELT $ 25))
                    (LETT |lm|
                          (|LGROBP;reduceRow| |linmat| |lm| (- |i| 1) |pivots|
                           $))
                    (COND ((EQL |i| |ndim1|) (LETT |j| |ndim1|))
                          ('T
                           (SEQ (LETT |j| 1)
                                (EXIT
                                 (SEQ G190
                                      (COND
                                       ((NULL
                                         (COND
                                          ((SPADCALL
                                            (SPADCALL |lm| |j| (QREFELT $ 21))
                                            (|spadConstant| $ 14)
                                            (QREFELT $ 58))
                                           (< |j| |ndim1|))
                                          ('T NIL)))
                                        (GO G191)))
                                      (SEQ (EXIT (LETT |j| (+ |j| 1)))) NIL
                                      (GO G190) G191 (EXIT NIL))))))
                    (EXIT
                     (COND
                      ((EQL |j| |ndim1|)
                       (SEQ
                        (LETT |cordlist|
                              (PROGN
                               (LETT #9# NIL)
                               (SEQ (LETT |k| |ndim1|)
                                    (LETT #8# (+ |ndim1| (LENGTH |nBasis|)))
                                    G190 (COND ((> |k| #8#) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #9#
                                            (CONS
                                             (SPADCALL |lm| |k| (QREFELT $ 21))
                                             #9#))))
                                    (LETT |k| (+ |k| 1)) (GO G190) G191
                                    (EXIT (NREVERSE #9#)))))
                        (LETT |antc|
                              (PROGN
                               (LETT #3# NIL)
                               (SEQ (LETT |b| NIL)
                                    (LETT #7# (CONS |firstmon| |nBasis|))
                                    (LETT |c| NIL)
                                    (LETT #6# (REVERSE |cordlist|)) G190
                                    (COND
                                     ((OR (ATOM #6#)
                                          (PROGN (LETT |c| (CAR #6#)) NIL)
                                          (ATOM #7#)
                                          (PROGN (LETT |b| (CAR #7#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (PROGN
                                       (LETT #5#
                                             (SPADCALL |c| |b| (QREFELT $ 59)))
                                       (COND
                                        (#3#
                                         (LETT #4#
                                               (SPADCALL #4# #5#
                                                         (QREFELT $ 60))))
                                        ('T
                                         (PROGN
                                          (LETT #4# #5#)
                                          (LETT #3# 'T)))))))
                                    (LETT #6#
                                          (PROG1 (CDR #6#)
                                            (LETT #7# (CDR #7#))))
                                    (GO G190) G191 (EXIT NIL))
                               (COND (#3# #4#) ('T (|spadConstant| $ 61)))))
                        (LETT |antc| (SPADCALL |antc| (QREFELT $ 62)))
                        (LETT |result| (CONS |antc| |result|))
                        (EXIT
                         (LETT |ltresult|
                               (CONS
                                (SPADCALL |antc|
                                          (SPADCALL |antc| (QREFELT $ 63))
                                          (QREFELT $ 64))
                                |ltresult|)))))
                      ('T
                       (SEQ (SPADCALL |pivots| |i| |j| (QREFELT $ 46))
                            (SPADCALL |linmat| |i| |lm| (QREFELT $ 65))
                            (LETT |i| (+ |i| 1))
                            (EXIT
                             (LETT |nBasis| (CONS |firstmon| |nBasis|))))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |result|)))) 

(SDEFUN |LGROBP;minPol;LOvlHdmp;4|
        ((|oldBasis|
          (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
         (|x| (|OrderedVariableList| |lv|))
         ($ (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
        (SPROG
         ((|algBasis|
           (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))))
         (SEQ (LETT |algBasis| (SPADCALL |oldBasis| (QREFELT $ 39)))
              (EXIT (SPADCALL |oldBasis| |algBasis| |x| (QREFELT $ 67)))))) 

(SDEFUN |LGROBP;minPol;2LOvlHdmp;5|
        ((|oldBasis|
          (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
         (|algBasis|
          (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
         (|x| (|OrderedVariableList| |lv|))
         ($ (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
        (SPROG
         ((#1=#:G797 NIL)
          (|g| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))
          (#2=#:G790 NIL) (#3=#:G800 NIL) (|k| NIL)
          (|j| (|NonNegativeInteger|)) (|lm| (|Vector| F)) (#4=#:G799 NIL)
          (|veccoef| (|Vector| F)) (|omult| (F)) (#5=#:G782 NIL)
          (|f| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))
          (#6=#:G779 NIL) (|cc| (F))
          (|recf|
           (|Record|
            (|:| |poly|
                 (|HomogeneousDistributedMultivariatePolynomial| |lv| F))
            (|:| |mult| F)))
          (#7=#:G798 NIL) (|i| NIL) (|pivots| (|Vector| (|Integer|)))
          (|linmat| (|Matrix| F)) (|ndim1| (|NonNegativeInteger|))
          (|ndim| (|PositiveInteger|)) (#8=#:G776 NIL)
          (|nvp| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
         (SEQ
          (EXIT
           (SEQ (LETT |nvp| (SPADCALL |x| (QREFELT $ 69)))
                (LETT |f| (|spadConstant| $ 42))
                (LETT |omult| (|spadConstant| $ 13))
                (LETT |ndim|
                      (PROG1 (LETT #8# (LENGTH |algBasis|))
                        (|check_subtype2| (> #8# 0) '(|PositiveInteger|)
                                          '(|NonNegativeInteger|) #8#)))
                (LETT |ndim1| (+ |ndim| 1))
                (LETT |linmat|
                      (SPADCALL |ndim| (+ (* 2 |ndim|) 1) (QREFELT $ 44)))
                (SPADCALL |linmat| 1 1 (|spadConstant| $ 13) (QREFELT $ 45))
                (SPADCALL |linmat| 1 |ndim1| (|spadConstant| $ 13)
                          (QREFELT $ 45))
                (LETT |pivots| (MAKEARR1 |ndim| 0))
                (SPADCALL |pivots| 1 1 (QREFELT $ 46))
                (EXIT
                 (SEQ (LETT |i| 2) (LETT #7# |ndim1|) G190
                      (COND ((|greater_SI| |i| #7#) (GO G191)))
                      (SEQ
                       (LETT |recf|
                             (|LGROBP;rRedPol|
                              (SPADCALL |f| |nvp| (QREFELT $ 52)) |oldBasis|
                              $))
                       (LETT |omult|
                             (SPADCALL (QCDR |recf|) |omult| (QREFELT $ 22)))
                       (LETT |f| (QCAR |recf|))
                       (LETT |cc|
                             (SPADCALL (SPADCALL |f| (QREFELT $ 53)) |omult|
                                       (QREFELT $ 54)))
                       (LETT |f|
                             (PROG2
                                 (LETT #6# (SPADCALL |f| |cc| (QREFELT $ 55)))
                                 (QCDR #6#)
                               (|check_union2| (QEQCAR #6# 0)
                                               (|HomogeneousDistributedMultivariatePolynomial|
                                                (QREFELT $ 6) (QREFELT $ 7))
                                               (|Union|
                                                (|HomogeneousDistributedMultivariatePolynomial|
                                                 (QREFELT $ 6) (QREFELT $ 7))
                                                "failed")
                                               #6#)))
                       (LETT |omult|
                             (PROG2
                                 (LETT #5#
                                       (SPADCALL |omult| |cc| (QREFELT $ 24)))
                                 (QCDR #5#)
                               (|check_union2| (QEQCAR #5# 0) (QREFELT $ 7)
                                               (|Union| (QREFELT $ 7) "failed")
                                               #5#)))
                       (LETT |veccoef|
                             (SPADCALL |f| |algBasis| (QREFELT $ 56)))
                       (LETT |lm| (SPADCALL (+ (* 2 |ndim|) 1) (QREFELT $ 57)))
                       (SEQ (LETT |j| 1) (LETT #4# |ndim|) G190
                            (COND ((|greater_SI| |j| #4#) (GO G191)))
                            (SEQ
                             (EXIT
                              (SPADCALL |lm| |j|
                                        (SPADCALL |veccoef| |j| (QREFELT $ 21))
                                        (QREFELT $ 25))))
                            (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                            (EXIT NIL))
                       (SPADCALL |lm| (+ |ndim| |i|) |omult| (QREFELT $ 25))
                       (LETT |lm|
                             (|LGROBP;reduceRow| |linmat| |lm| (- |i| 1)
                              |pivots| $))
                       (LETT |j| 1)
                       (SEQ G190
                            (COND
                             ((NULL
                               (COND
                                ((SPADCALL (SPADCALL |lm| |j| (QREFELT $ 21))
                                           (|spadConstant| $ 14)
                                           (QREFELT $ 58))
                                 (< |j| |ndim1|))
                                ('T NIL)))
                              (GO G191)))
                            (SEQ (EXIT (LETT |j| (+ |j| 1)))) NIL (GO G190)
                            G191 (EXIT NIL))
                       (COND
                        ((EQL |j| |ndim1|)
                         (PROGN
                          (LETT #1#
                                (SEQ (LETT |g| (|spadConstant| $ 32))
                                     (SEQ (LETT |k| |ndim1|)
                                          (LETT #3# (+ (* 2 |ndim|) 1)) G190
                                          (COND ((> |k| #3#) (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (LETT |g|
                                                  (SPADCALL |g|
                                                            (SPADCALL
                                                             (SPADCALL |lm| |k|
                                                                       (QREFELT
                                                                        $ 21))
                                                             (SPADCALL |nvp|
                                                                       (PROG1
                                                                           (LETT
                                                                            #2#
                                                                            (-
                                                                             |k|
                                                                             |ndim1|))
                                                                         (|check_subtype2|
                                                                          (>=
                                                                           #2#
                                                                           0)
                                                                          '(|NonNegativeInteger|)
                                                                          '(|Integer|)
                                                                          #2#))
                                                                       (QREFELT
                                                                        $ 70))
                                                             (QREFELT $ 37))
                                                            (QREFELT $ 38)))))
                                          (LETT |k| (+ |k| 1)) (GO G190) G191
                                          (EXIT NIL))
                                     (EXIT (SPADCALL |g| (QREFELT $ 71)))))
                          (GO #9=#:G796))))
                       (SPADCALL |pivots| |i| |j| (QREFELT $ 46))
                       (EXIT (SPADCALL |linmat| |i| |lm| (QREFELT $ 65))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL)))))
          #9# (EXIT #1#)))) 

(SDEFUN |LGROBP;transform;DmpHdmp;6|
        ((|dpol| (|DistributedMultivariatePolynomial| |lv| F))
         ($ (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
        (COND
         ((SPADCALL |dpol| (|spadConstant| $ 61) (QREFELT $ 72))
          (|spadConstant| $ 32))
         ('T
          (SPADCALL
           (SPADCALL (SPADCALL |dpol| (QREFELT $ 73))
                     (SPADCALL
                      (SPADCALL (SPADCALL |dpol| (QREFELT $ 75))
                                (QREFELT $ 77))
                      (QREFELT $ 79))
                     (QREFELT $ 80))
           (SPADCALL (SPADCALL |dpol| (QREFELT $ 63)) (QREFELT $ 51))
           (QREFELT $ 38))))) 

(SDEFUN |LGROBP;computeBasis;2L;7|
        ((B (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
         ($ (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))))
        (SPROG
         ((|result|
           (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
          (|part|
           (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
          (#1=#:G819 NIL) (|var| NIL)
          (|mB|
           (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
          (#2=#:G818 NIL) (|f| NIL) (#3=#:G817 NIL))
         (SEQ
          (LETT |mB|
                (PROGN
                 (LETT #3# NIL)
                 (SEQ (LETT |f| NIL) (LETT #2# B) G190
                      (COND
                       ((OR (ATOM #2#) (PROGN (LETT |f| (CAR #2#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #3#
                              (CONS
                               (SPADCALL (|spadConstant| $ 13)
                                         (SPADCALL |f| (QREFELT $ 81))
                                         (QREFELT $ 80))
                               #3#))))
                      (LETT #2# (CDR #2#)) (GO G190) G191
                      (EXIT (NREVERSE #3#)))))
          (LETT |result| (LIST (|spadConstant| $ 42)))
          (SEQ (LETT |var| NIL) (LETT #1# (QREFELT $ 12)) G190
               (COND
                ((OR (ATOM #1#) (PROGN (LETT |var| (CAR #1#)) NIL)) (GO G191)))
               (SEQ (LETT |part| (SPADCALL |var| |result| |mB| (QREFELT $ 82)))
                    (EXIT
                     (LETT |result|
                           (SPADCALL |result| |part| (QREFELT $ 83)))))
               (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
          (EXIT |result|)))) 

(SDEFUN |LGROBP;intcompBasis;Ovl3L;8|
        ((|x| (|OrderedVariableList| |lv|))
         (|lr|
          (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
         (|mB|
          (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
         ($ (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))))
        (SPROG
         ((|part|
           (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
          (|g| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))
          (#1=#:G825 NIL) (|f| NIL))
         (SEQ
          (COND ((SPADCALL |lr| NIL (QREFELT $ 84)) |lr|)
                ('T
                 (SEQ (LETT |part| NIL)
                      (SEQ (LETT |f| NIL) (LETT #1# |lr|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (LETT |g|
                                  (SPADCALL (SPADCALL |x| (QREFELT $ 69)) |f|
                                            (QREFELT $ 52)))
                            (EXIT
                             (COND
                              ((SPADCALL
                                (QCAR (SPADCALL |g| |mB| (QREFELT $ 31)))
                                (|spadConstant| $ 32) (QREFELT $ 85))
                               (LETT |part| (CONS |g| |part|))))))
                           (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (SPADCALL |part|
                                 (SPADCALL |x| |part| |mB| (QREFELT $ 82))
                                 (QREFELT $ 83))))))))) 

(SDEFUN |LGROBP;coord;HdmpLV;9|
        ((|f| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))
         (B (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
         ($ (|Vector| F)))
        (SPROG
         ((|i| (|Integer|)) (|lcf| (F))
          (|lf| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))
          (|rf| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))
          (|vv| (|Vector| F)) (|ndim| (|NonNegativeInteger|)))
         (SEQ (LETT |ndim| (LENGTH B))
              (LETT |vv| (MAKEARR1 |ndim| (|spadConstant| $ 14)))
              (SEQ G190
                   (COND
                    ((NULL (SPADCALL |f| (|spadConstant| $ 32) (QREFELT $ 85)))
                     (GO G191)))
                   (SEQ (LETT |rf| (SPADCALL |f| (QREFELT $ 35)))
                        (LETT |lf| (SPADCALL |f| |rf| (QREFELT $ 36)))
                        (LETT |lcf| (SPADCALL |f| (QREFELT $ 86)))
                        (LETT |i|
                              (SPADCALL
                               (SPADCALL (|spadConstant| $ 13)
                                         (SPADCALL |lf| (QREFELT $ 81))
                                         (QREFELT $ 80))
                               B (QREFELT $ 87)))
                        (SPADCALL |vv| |i| |lcf| (QREFELT $ 25))
                        (EXIT (LETT |f| |rf|)))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT |vv|)))) 

(SDEFUN |LGROBP;anticoord;LDmpLDmp;10|
        ((|vv| (|List| F)) (|mf| (|DistributedMultivariatePolynomial| |lv| F))
         (B (|List| (|DistributedMultivariatePolynomial| |lv| F)))
         ($ (|DistributedMultivariatePolynomial| |lv| F)))
        (SPROG ((#1=#:G839 NIL) (|f| NIL) (#2=#:G840 NIL) (|c| NIL))
               (SEQ
                (SEQ (LETT |c| NIL) (LETT #2# |vv|) (LETT |f| NIL) (LETT #1# B)
                     G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL)
                           (ATOM #2#) (PROGN (LETT |c| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT |mf|
                             (SPADCALL |mf| (SPADCALL |c| |f| (QREFELT $ 59))
                                       (QREFELT $ 64)))))
                     (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                     (GO G190) G191 (EXIT NIL))
                (EXIT |mf|)))) 

(SDEFUN |LGROBP;choosemon;DmpLDmp;11|
        ((|mf| (|DistributedMultivariatePolynomial| |lv| F))
         (|nB| (|List| (|DistributedMultivariatePolynomial| |lv| F)))
         ($ (|DistributedMultivariatePolynomial| |lv| F)))
        (SPROG
         ((#1=#:G847 NIL) (|dx| (|NonNegativeInteger|)) (#2=#:G853 NIL)
          (|xx| (|DistributedMultivariatePolynomial| |lv| F)) (#3=#:G854 NIL)
          (|x| NIL))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL |nB| NIL (QREFELT $ 90))
             (SPADCALL
              (SPADCALL (SPADCALL (QREFELT $ 12) '|last| (QREFELT $ 93))
                        (QREFELT $ 94))
              |mf| (QREFELT $ 95)))
            ('T
             (SEQ
              (SEQ (LETT |x| NIL) (LETT #3# (REVERSE (QREFELT $ 12))) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |x| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |xx| (SPADCALL |x| (QREFELT $ 94)))
                        (LETT |mf| (SPADCALL |xx| |mf| (QREFELT $ 95)))
                        (COND
                         ((SPADCALL (QCAR (SPADCALL |mf| |nB| (QREFELT $ 98)))
                                    (|spadConstant| $ 61) (QREFELT $ 49))
                          (PROGN (LETT #2# |mf|) (GO #4=#:G852))))
                        (LETT |dx| (SPADCALL |mf| |x| (QREFELT $ 99)))
                        (EXIT
                         (LETT |mf|
                               (PROG2
                                   (LETT #1#
                                         (SPADCALL |mf|
                                                   (SPADCALL |xx| |dx|
                                                             (QREFELT $ 100))
                                                   (QREFELT $ 50)))
                                   (QCDR #1#)
                                 (|check_union2| (QEQCAR #1# 0)
                                                 (|DistributedMultivariatePolynomial|
                                                  (QREFELT $ 6) (QREFELT $ 7))
                                                 (|Union|
                                                  (|DistributedMultivariatePolynomial|
                                                   (QREFELT $ 6) (QREFELT $ 7))
                                                  "failed")
                                                 #1#)))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (EXIT |mf|)))))
          #4# (EXIT #2#)))) 

(SDEFUN |LGROBP;linGenPos;LR;12|
        ((B (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F)))
         ($
          (|Record|
           (|:| |gblist| (|List| (|DistributedMultivariatePolynomial| |lv| F)))
           (|:| |gvlist| (|List| (|Integer|))))))
        (SPROG
         ((|nBasis| (|List| #1=(|DistributedMultivariatePolynomial| |lv| F)))
          (|i| (|NonNegativeInteger|))
          (|ltresult| (|List| (|DistributedMultivariatePolynomial| |lv| F)))
          (|result| (|List| (|DistributedMultivariatePolynomial| |lv| F)))
          (|antc| #2=(|DistributedMultivariatePolynomial| |lv| F))
          (#3=#:G885 NIL) (#4=#:G884 #2#) (#5=#:G886 #2#) (#6=#:G900 NIL)
          (#7=#:G901 NIL) (|b| NIL) (|cordlist| (|List| F)) (#8=#:G899 NIL)
          (|j| (|NonNegativeInteger|)) (#9=#:G898 NIL) (|lm| (|Vector| F))
          (#10=#:G897 NIL)
          (|orecfmon|
           (|Record|
            (|:| |poly|
                 (|HomogeneousDistributedMultivariatePolynomial| |lv| F))
            (|:| |mult| F)))
          (|ofirstmon| #1#) (|veccoef| (|Vector| F)) (#11=#:G875 NIL)
          (#12=#:G872 NIL) (|cc| (F))
          (|recfmon|
           (|Record|
            (|:| |poly|
                 (|HomogeneousDistributedMultivariatePolynomial| |lv| F))
            (|:| |mult| F)))
          (|v| (|Union| (|DistributedMultivariatePolynomial| |lv| F) "failed"))
          (|firstmon| #1#) (|lx| (|OrderedVariableList| |lv|))
          (|nval| (|DistributedMultivariatePolynomial| |lv| F))
          (#13=#:G863 NIL)
          (#14=#:G862 #15=(|DistributedMultivariatePolynomial| |lv| F))
          (#16=#:G864 #15#) (#17=#:G895 NIL) (|r| NIL) (#18=#:G896 NIL)
          (|vv| NIL) (|rval| (|List| (|Integer|))) (|c| (|Integer|))
          (#19=#:G894 NIL) (|ii| NIL) (|pivots| (|Vector| (|Integer|)))
          (|linmat| (|Matrix| F)) (|ndim1| (|NonNegativeInteger|))
          (|ndim| (|PositiveInteger|)) (#20=#:G856 NIL)
          (|vBasis|
           (|List| (|HomogeneousDistributedMultivariatePolynomial| |lv| F))))
         (SEQ (LETT |result| NIL) (LETT |ltresult| NIL)
              (LETT |vBasis| (SPADCALL B (QREFELT $ 39)))
              (LETT |nBasis| (LIST (|spadConstant| $ 41)))
              (LETT |ndim|
                    (PROG1 (LETT #20# (LENGTH |vBasis|))
                      (|check_subtype2| (> #20# 0) '(|PositiveInteger|)
                                        '(|NonNegativeInteger|) #20#)))
              (LETT |ndim1| (+ |ndim| 1))
              (LETT |linmat|
                    (SPADCALL |ndim| (+ (* 2 |ndim|) 1) (QREFELT $ 44)))
              (SPADCALL |linmat| 1 1 (|spadConstant| $ 13) (QREFELT $ 45))
              (SPADCALL |linmat| 1 |ndim1| (|spadConstant| $ 13)
                        (QREFELT $ 45))
              (LETT |pivots| (MAKEARR1 |ndim| 0))
              (SPADCALL |pivots| 1 1 (QREFELT $ 46)) (LETT |i| 2)
              (LETT |rval| NIL)
              (SEQ (LETT |ii| 1) (LETT #19# (- (LENGTH (QREFELT $ 12)) 1)) G190
                   (COND ((|greater_SI| |ii| #19#) (GO G191)))
                   (SEQ (LETT |c| 0)
                        (SEQ G190 (COND ((NULL (EQL |c| 0)) (GO G191)))
                             (SEQ (EXIT (LETT |c| (RANDOM 11)))) NIL (GO G190)
                             G191 (EXIT NIL))
                        (EXIT (LETT |rval| (CONS |c| |rval|))))
                   (LETT |ii| (|inc_SI| |ii|)) (GO G190) G191 (EXIT NIL))
              (LETT |nval|
                    (SPADCALL
                     (SPADCALL (SPADCALL (QREFELT $ 12) (QREFELT $ 101))
                               (QREFELT $ 94))
                     (PROGN
                      (LETT #13# NIL)
                      (SEQ (LETT |vv| NIL) (LETT #18# (QREFELT $ 12))
                           (LETT |r| NIL) (LETT #17# |rval|) G190
                           (COND
                            ((OR (ATOM #17#) (PROGN (LETT |r| (CAR #17#)) NIL)
                                 (ATOM #18#)
                                 (PROGN (LETT |vv| (CAR #18#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (PROGN
                              (LETT #16#
                                    (SPADCALL |r|
                                              (SPADCALL |vv| (QREFELT $ 94))
                                              (QREFELT $ 102)))
                              (COND
                               (#13#
                                (LETT #14#
                                      (SPADCALL #14# #16# (QREFELT $ 60))))
                               ('T (PROGN (LETT #14# #16#) (LETT #13# 'T)))))))
                           (LETT #17#
                                 (PROG1 (CDR #17#) (LETT #18# (CDR #18#))))
                           (GO G190) G191 (EXIT NIL))
                      (COND (#13# #14#) ('T (|spadConstant| $ 61))))
                     (QREFELT $ 64)))
              (LETT |firstmon| (|spadConstant| $ 41))
              (LETT |ofirstmon| (|spadConstant| $ 41))
              (LETT |orecfmon|
                    (CONS (|spadConstant| $ 42) (|spadConstant| $ 13)))
              (LETT |lx| (SPADCALL (QREFELT $ 12) '|last| (QREFELT $ 93)))
              (SEQ G190
                   (COND
                    ((NULL
                      (SPADCALL
                       (LETT |firstmon|
                             (SPADCALL |firstmon| |ltresult| (QREFELT $ 48)))
                       (|spadConstant| $ 41) (QREFELT $ 49)))
                     (GO G191)))
                   (SEQ
                    (SEQ
                     (LETT |v|
                           (SPADCALL |firstmon| |ofirstmon| (QREFELT $ 50)))
                     (EXIT
                      (COND
                       ((QEQCAR |v| 1)
                        (LETT |recfmon|
                              (|LGROBP;rRedPol|
                               (SPADCALL
                                (SPADCALL |firstmon| |lx| |nval|
                                          (QREFELT $ 103))
                                (QREFELT $ 51))
                               B $)))
                       ('T
                        (SEQ
                         (LETT |recfmon|
                               (|LGROBP;rRedPol|
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (QCDR |v|) |lx| |nval|
                                            (QREFELT $ 103))
                                  (QREFELT $ 51))
                                 (QCAR |orecfmon|) (QREFELT $ 52))
                                B $))
                         (EXIT
                          (PROGN
                           (RPLACD |recfmon|
                                   (SPADCALL (QCDR |recfmon|) (QCDR |orecfmon|)
                                             (QREFELT $ 22)))
                           (QCDR |recfmon|))))))))
                    (LETT |cc|
                          (SPADCALL (SPADCALL (QCAR |recfmon|) (QREFELT $ 53))
                                    (QCDR |recfmon|) (QREFELT $ 54)))
                    (PROGN
                     (RPLACA |recfmon|
                             (PROG2
                                 (LETT #12#
                                       (SPADCALL (QCAR |recfmon|) |cc|
                                                 (QREFELT $ 55)))
                                 (QCDR #12#)
                               (|check_union2| (QEQCAR #12# 0)
                                               (|HomogeneousDistributedMultivariatePolynomial|
                                                (QREFELT $ 6) (QREFELT $ 7))
                                               (|Union|
                                                (|HomogeneousDistributedMultivariatePolynomial|
                                                 (QREFELT $ 6) (QREFELT $ 7))
                                                "failed")
                                               #12#)))
                     (QCAR |recfmon|))
                    (PROGN
                     (RPLACD |recfmon|
                             (PROG2
                                 (LETT #11#
                                       (SPADCALL (QCDR |recfmon|) |cc|
                                                 (QREFELT $ 24)))
                                 (QCDR #11#)
                               (|check_union2| (QEQCAR #11# 0) (QREFELT $ 7)
                                               (|Union| (QREFELT $ 7) "failed")
                                               #11#)))
                     (QCDR |recfmon|))
                    (LETT |veccoef|
                          (SPADCALL (QCAR |recfmon|) |vBasis| (QREFELT $ 56)))
                    (LETT |ofirstmon| |firstmon|) (LETT |orecfmon| |recfmon|)
                    (LETT |lm| (SPADCALL (+ (* 2 |ndim|) 1) (QREFELT $ 57)))
                    (SEQ (LETT |j| 1) (LETT #10# |ndim|) G190
                         (COND ((|greater_SI| |j| #10#) (GO G191)))
                         (SEQ
                          (EXIT
                           (SPADCALL |lm| |j|
                                     (SPADCALL |veccoef| |j| (QREFELT $ 21))
                                     (QREFELT $ 25))))
                         (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                    (SPADCALL |lm| (+ |ndim| |i|) (QCDR |recfmon|)
                              (QREFELT $ 25))
                    (LETT |lm|
                          (|LGROBP;reduceRow| |linmat| |lm| (- |i| 1) |pivots|
                           $))
                    (LETT |j| 1)
                    (SEQ G190
                         (COND
                          ((NULL
                            (COND
                             ((SPADCALL (SPADCALL |lm| |j| (QREFELT $ 21))
                                        (|spadConstant| $ 14) (QREFELT $ 58))
                              (< |j| |ndim1|))
                             ('T NIL)))
                           (GO G191)))
                         (SEQ (EXIT (LETT |j| (+ |j| 1)))) NIL (GO G190) G191
                         (EXIT NIL))
                    (EXIT
                     (COND
                      ((EQL |j| |ndim1|)
                       (SEQ
                        (LETT |cordlist|
                              (PROGN
                               (LETT #9# NIL)
                               (SEQ (LETT |j| |ndim1|)
                                    (LETT #8# (+ |ndim1| (LENGTH |nBasis|)))
                                    G190 (COND ((> |j| #8#) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #9#
                                            (CONS
                                             (SPADCALL |lm| |j| (QREFELT $ 21))
                                             #9#))))
                                    (LETT |j| (+ |j| 1)) (GO G190) G191
                                    (EXIT (NREVERSE #9#)))))
                        (LETT |antc|
                              (PROGN
                               (LETT #3# NIL)
                               (SEQ (LETT |b| NIL)
                                    (LETT #7# (CONS |firstmon| |nBasis|))
                                    (LETT #6# (REVERSE |cordlist|)) G190
                                    (COND
                                     ((OR (ATOM #6#)
                                          (PROGN (LETT |c| (CAR #6#)) NIL)
                                          (ATOM #7#)
                                          (PROGN (LETT |b| (CAR #7#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (PROGN
                                       (LETT #5#
                                             (SPADCALL |c| |b| (QREFELT $ 59)))
                                       (COND
                                        (#3#
                                         (LETT #4#
                                               (SPADCALL #4# #5#
                                                         (QREFELT $ 60))))
                                        ('T
                                         (PROGN
                                          (LETT #4# #5#)
                                          (LETT #3# 'T)))))))
                                    (LETT #6#
                                          (PROG1 (CDR #6#)
                                            (LETT #7# (CDR #7#))))
                                    (GO G190) G191 (EXIT NIL))
                               (COND (#3# #4#) ('T (|spadConstant| $ 61)))))
                        (LETT |result|
                              (CONS (SPADCALL |antc| (QREFELT $ 62)) |result|))
                        (EXIT
                         (LETT |ltresult|
                               (CONS
                                (SPADCALL |antc|
                                          (SPADCALL |antc| (QREFELT $ 63))
                                          (QREFELT $ 64))
                                |ltresult|)))))
                      ('T
                       (SEQ (SPADCALL |pivots| |i| |j| (QREFELT $ 46))
                            (SPADCALL |linmat| |i| |lm| (QREFELT $ 65))
                            (LETT |i| (+ |i| 1))
                            (EXIT
                             (LETT |nBasis| (CONS |firstmon| |nBasis|))))))))
                   NIL (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |result| |rval|))))) 

(SDEFUN |LGROBP;groebgen;LR;13|
        ((L (|List| (|DistributedMultivariatePolynomial| |lv| F)))
         ($
          (|Record|
           (|:| |glbase| (|List| (|DistributedMultivariatePolynomial| |lv| F)))
           (|:| |glval| (|List| (|Integer|))))))
        (SPROG
         ((LL (|List| (|DistributedMultivariatePolynomial| |lv| F)))
          (#1=#:G919 NIL) (|f| NIL) (#2=#:G918 NIL)
          (|val| (|DistributedMultivariatePolynomial| |lv| F)) (#3=#:G907 NIL)
          (#4=#:G906 #5=(|DistributedMultivariatePolynomial| |lv| F))
          (#6=#:G908 #5#) (#7=#:G917 NIL) (|i| NIL) (|ll| (|List| (|Integer|)))
          (#8=#:G916 NIL) (#9=#:G915 NIL) (|nvar1| (|NonNegativeInteger|))
          (#10=#:G903 NIL) (|xn| (|OrderedVariableList| |lv|)))
         (SEQ (LETT |xn| (SPADCALL (QREFELT $ 12) '|last| (QREFELT $ 93)))
              (LETT |val| (SPADCALL |xn| (QREFELT $ 94)))
              (LETT |nvar1|
                    (PROG1 (LETT #10# (- (LENGTH (QREFELT $ 12)) 1))
                      (|check_subtype2| (>= #10# 0) '(|NonNegativeInteger|)
                                        '(|Integer|) #10#)))
              (LETT |ll|
                    (PROGN
                     (LETT #9# NIL)
                     (SEQ (LETT |i| 1) (LETT #8# |nvar1|) G190
                          (COND ((|greater_SI| |i| #8#) (GO G191)))
                          (SEQ (EXIT (LETT #9# (CONS (RANDOM 11) #9#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #9#)))))
              (LETT |val|
                    (SPADCALL |val|
                              (PROGN
                               (LETT #3# NIL)
                               (SEQ (LETT |i| 1) (LETT #7# |nvar1|) G190
                                    (COND ((|greater_SI| |i| #7#) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (PROGN
                                       (LETT #6#
                                             (SPADCALL
                                              (SPADCALL |ll| |i|
                                                        (QREFELT $ 107))
                                              (SPADCALL
                                               (SPADCALL (QREFELT $ 12) |i|
                                                         (QREFELT $ 108))
                                               (QREFELT $ 94))
                                              (QREFELT $ 102)))
                                       (COND
                                        (#3#
                                         (LETT #4#
                                               (SPADCALL #4# #6#
                                                         (QREFELT $ 60))))
                                        ('T
                                         (PROGN
                                          (LETT #4# #6#)
                                          (LETT #3# 'T)))))))
                                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                    (EXIT NIL))
                               (COND (#3# #4#) ('T (|spadConstant| $ 61))))
                              (QREFELT $ 60)))
              (LETT LL
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |f| NIL) (LETT #1# L) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS
                                   (SPADCALL
                                    (SPADCALL |f| |xn| (QREFELT $ 110)) |val|
                                    (QREFELT $ 112))
                                   #2#))))
                          (LETT #1# (CDR #1#)) (GO G190) G191
                          (EXIT (NREVERSE #2#)))))
              (LETT LL (SPADCALL LL (QREFELT $ 114))) (EXIT (CONS LL |ll|))))) 

(DECLAIM (NOTINLINE |LinGroebnerPackage;|)) 

(DEFUN |LinGroebnerPackage| (&REST #1=#:G922)
  (SPROG NIL
         (PROG (#2=#:G923)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluate_sig| #1# '(NIL T))
                                               (HGET |$ConstructorCache|
                                                     '|LinGroebnerPackage|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |LinGroebnerPackage;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|LinGroebnerPackage|)))))))))) 

(DEFUN |LinGroebnerPackage;| (|#1| |#2|)
  (SPROG
   ((#1=#:G701 NIL) (#2=#:G921 NIL) (|yx| NIL) (#3=#:G920 NIL) (|pv$| NIL)
    ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
   (SEQ
    (PROGN
     (LETT DV$1 |#1|)
     (LETT DV$2 (|devaluate| |#2|))
     (LETT |dv$| (LIST '|LinGroebnerPackage| DV$1 DV$2))
     (LETT $ (GETREFV 117))
     (QSETREFV $ 0 |dv$|)
     (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
     (|haddProp| |$ConstructorCache| '|LinGroebnerPackage| (LIST DV$1 DV$2)
                 (CONS 1 $))
     (|stuffDomainSlots| $)
     (QSETREFV $ 6 |#1|)
     (QSETREFV $ 7 |#2|)
     (SETF |pv$| (QREFELT $ 3))
     (QSETREFV $ 12
               (PROGN
                (LETT #3# NIL)
                (SEQ (LETT |yx| NIL) (LETT #2# |#1|) G190
                     (COND
                      ((OR (ATOM #2#) (PROGN (LETT |yx| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #3#
                             (CONS
                              (PROG2 (LETT #1# (SPADCALL |yx| (QREFELT $ 11)))
                                  (QCDR #1#)
                                (|check_union2| (QEQCAR #1# 0)
                                                (|OrderedVariableList|
                                                 (SPADCALL |yx|
                                                           (QREFELT $ 11)))
                                                (|Union|
                                                 (|OrderedVariableList|
                                                  (SPADCALL |yx|
                                                            (QREFELT $ 11)))
                                                 "failed")
                                                #1#))
                              #3#))))
                     (LETT #2# (CDR #2#)) (GO G190) G191
                     (EXIT (NREVERSE #3#)))))
     $)))) 

(MAKEPROP '|LinGroebnerPackage| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|Union| $ '"failed") (|Symbol|)
              (|OrderedVariableList| (NRTEVAL (QREFELT $ 6))) (0 . |variable|)
              '|lvar| (5 . |One|) (9 . |Zero|) (|Vector| 7) (|Integer|)
              (|Matrix| 7) (13 . |row|) (|Vector| 16) (19 . |elt|) (25 . |elt|)
              (31 . *) (37 . -) (42 . |exquo|) (48 . |setelt!|) (55 . -)
              (|Record| (|:| |poly| 28) (|:| |mult| 7))
              (|HomogeneousDistributedMultivariatePolynomial|
               (NRTEVAL (QREFELT $ 6)) 7)
              (|List| 28) (|GroebnerInternalPackage| 7 78 28) (61 . |redPo|)
              (67 . |Zero|) (|Boolean|) (71 . =) (77 . |reductum|) (82 . -)
              (88 . *) (94 . +) |LGROBP;computeBasis;2L;7|
              (|DistributedMultivariatePolynomial| (NRTEVAL (QREFELT $ 6)) 7)
              (100 . |One|) (104 . |One|) (|NonNegativeInteger|) (108 . |zero|)
              (114 . |setelt!|) (122 . |setelt!|) (|List| 40)
              |LGROBP;choosemon;DmpLDmp;11| (129 . ~=) (135 . |exquo|)
              |LGROBP;transform;DmpHdmp;6| (141 . *) (147 . |content|)
              (152 . |gcd|) (158 . |exquo|) |LGROBP;coord;HdmpLV;9|
              (164 . |zero|) (169 . =) (175 . *) (181 . +) (187 . |Zero|)
              (191 . |primitivePart|) (196 . |reductum|) (201 . -)
              (207 . |setRow!|) |LGROBP;totolex;LL;3|
              |LGROBP;minPol;2LOvlHdmp;5| |LGROBP;minPol;LOvlHdmp;4|
              (214 . |coerce|) (219 . ^) (225 . |primitivePart|) (230 . =)
              (236 . |leadingCoefficient|)
              (|DirectProduct| (NRTEVAL (LENGTH (QREFELT $ 6))) 43)
              (241 . |degree|) (|Vector| 43) (246 . |coerce|)
              (|HomogeneousDirectProduct| (NRTEVAL (LENGTH (QREFELT $ 6))) 43)
              (251 . |directProduct|) (256 . |monomial|) (262 . |degree|)
              |LGROBP;intcompBasis;Ovl3L;8| (267 . |concat|) (273 . =)
              (279 . ~=) (285 . |leadingCoefficient|) (290 . |position|)
              (|List| 7) |LGROBP;anticoord;LDmpLDmp;10| (296 . =) '"last"
              (|List| 10) (302 . |elt|) (308 . |coerce|) (313 . *)
              (|Record| (|:| |poly| 40) (|:| |mult| 7))
              (|GroebnerInternalPackage| 7 74 40) (319 . |redPo|)
              (325 . |degree|) (331 . ^) (337 . |last|) (342 . *)
              (348 . |eval|) (|Record| (|:| |gblist| 47) (|:| |gvlist| 106))
              |LGROBP;linGenPos;LR;12| (|List| 16) (355 . |elt|) (361 . |elt|)
              (|SparseUnivariatePolynomial| $) (367 . |univariate|)
              (|SparseUnivariatePolynomial| 40) (373 . |elt|)
              (|GroebnerPackage| 7 74 40) (379 . |groebner|)
              (|Record| (|:| |glbase| 47) (|:| |glval| 106))
              |LGROBP;groebgen;LR;13|)
           '#(|transform| 384 |totolex| 389 |minPol| 394 |linGenPos| 407
              |intcompBasis| 412 |groebgen| 419 |coord| 424 |computeBasis| 430
              |choosemon| 435 |anticoord| 441)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|linGenPos|
                                 ((|Record|
                                   (|:| |gblist|
                                        (|List|
                                         (|DistributedMultivariatePolynomial|
                                          |#1| |#2|)))
                                   (|:| |gvlist| (|List| (|Integer|))))
                                  (|List|
                                   (|HomogeneousDistributedMultivariatePolynomial|
                                    |#1| |#2|))))
                                T)
                              '((|groebgen|
                                 ((|Record|
                                   (|:| |glbase|
                                        (|List|
                                         (|DistributedMultivariatePolynomial|
                                          |#1| |#2|)))
                                   (|:| |glval| (|List| (|Integer|))))
                                  (|List|
                                   (|DistributedMultivariatePolynomial| |#1|
                                                                        |#2|))))
                                T)
                              '((|totolex|
                                 ((|List|
                                   (|DistributedMultivariatePolynomial| |#1|
                                                                        |#2|))
                                  (|List|
                                   (|HomogeneousDistributedMultivariatePolynomial|
                                    |#1| |#2|))))
                                T)
                              '((|minPol|
                                 ((|HomogeneousDistributedMultivariatePolynomial|
                                   |#1| |#2|)
                                  (|List|
                                   (|HomogeneousDistributedMultivariatePolynomial|
                                    |#1| |#2|))
                                  (|List|
                                   (|HomogeneousDistributedMultivariatePolynomial|
                                    |#1| |#2|))
                                  (|OrderedVariableList| |#1|)))
                                T)
                              '((|minPol|
                                 ((|HomogeneousDistributedMultivariatePolynomial|
                                   |#1| |#2|)
                                  (|List|
                                   (|HomogeneousDistributedMultivariatePolynomial|
                                    |#1| |#2|))
                                  (|OrderedVariableList| |#1|)))
                                T)
                              '((|computeBasis|
                                 ((|List|
                                   (|HomogeneousDistributedMultivariatePolynomial|
                                    |#1| |#2|))
                                  (|List|
                                   (|HomogeneousDistributedMultivariatePolynomial|
                                    |#1| |#2|))))
                                T)
                              '((|coord|
                                 ((|Vector| |#2|)
                                  (|HomogeneousDistributedMultivariatePolynomial|
                                   |#1| |#2|)
                                  (|List|
                                   (|HomogeneousDistributedMultivariatePolynomial|
                                    |#1| |#2|))))
                                T)
                              '((|anticoord|
                                 ((|DistributedMultivariatePolynomial| |#1|
                                                                       |#2|)
                                  (|List| |#2|)
                                  (|DistributedMultivariatePolynomial| |#1|
                                                                       |#2|)
                                  (|List|
                                   (|DistributedMultivariatePolynomial| |#1|
                                                                        |#2|))))
                                T)
                              '((|intcompBasis|
                                 ((|List|
                                   (|HomogeneousDistributedMultivariatePolynomial|
                                    |#1| |#2|))
                                  (|OrderedVariableList| |#1|)
                                  (|List|
                                   (|HomogeneousDistributedMultivariatePolynomial|
                                    |#1| |#2|))
                                  (|List|
                                   (|HomogeneousDistributedMultivariatePolynomial|
                                    |#1| |#2|))))
                                T)
                              '((|choosemon|
                                 ((|DistributedMultivariatePolynomial| |#1|
                                                                       |#2|)
                                  (|DistributedMultivariatePolynomial| |#1|
                                                                       |#2|)
                                  (|List|
                                   (|DistributedMultivariatePolynomial| |#1|
                                                                        |#2|))))
                                T)
                              '((|transform|
                                 ((|HomogeneousDistributedMultivariatePolynomial|
                                   |#1| |#2|)
                                  (|DistributedMultivariatePolynomial| |#1|
                                                                       |#2|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 116
                                            '(1 10 8 9 11 0 7 0 13 0 7 0 14 2
                                              17 15 0 16 18 2 19 16 0 16 20 2
                                              15 7 0 16 21 2 7 0 0 0 22 1 7 0 0
                                              23 2 7 8 0 0 24 3 15 7 0 16 7 25
                                              2 7 0 0 0 26 2 30 27 28 29 31 0
                                              28 0 32 2 28 33 0 0 34 1 28 0 0
                                              35 2 28 0 0 0 36 2 28 0 7 0 37 2
                                              28 0 0 0 38 0 40 0 41 0 28 0 42 2
                                              17 0 43 43 44 4 17 7 0 16 16 7 45
                                              3 19 16 0 16 16 46 2 40 33 0 0 49
                                              2 40 8 0 0 50 2 28 0 0 0 52 1 28
                                              7 0 53 2 7 0 0 0 54 2 28 8 0 7 55
                                              1 15 0 43 57 2 7 33 0 0 58 2 40 0
                                              7 0 59 2 40 0 0 0 60 0 40 0 61 1
                                              40 0 0 62 1 40 0 0 63 2 40 0 0 0
                                              64 3 17 0 0 16 15 65 1 28 0 10 69
                                              2 28 0 0 43 70 1 28 0 0 71 2 40
                                              33 0 0 72 1 40 7 0 73 1 40 74 0
                                              75 1 74 76 0 77 1 78 0 76 79 2 28
                                              0 7 78 80 1 28 78 0 81 2 29 0 0 0
                                              83 2 29 33 0 0 84 2 28 33 0 0 85
                                              1 28 7 0 86 2 29 16 28 0 87 2 47
                                              33 0 0 90 2 92 10 0 91 93 1 40 0
                                              10 94 2 40 0 0 0 95 2 97 96 40 47
                                              98 2 40 43 0 10 99 2 40 0 0 43
                                              100 1 92 10 0 101 2 40 0 16 0 102
                                              3 40 0 0 10 0 103 2 106 16 0 16
                                              107 2 92 10 0 16 108 2 40 109 0
                                              10 110 2 111 40 0 40 112 1 113 47
                                              47 114 1 0 28 40 51 1 0 47 29 66
                                              2 0 28 29 10 68 3 0 28 29 29 10
                                              67 1 0 104 29 105 3 0 29 10 29 29
                                              82 1 0 115 47 116 2 0 15 28 29 56
                                              1 0 29 29 39 2 0 40 40 47 48 3 0
                                              40 88 40 47 89)))))
           '|lookupComplete|)) 
