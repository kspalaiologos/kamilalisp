
(SDEFUN |RDEPAR;get_denom|
        ((|f| (|Fraction| (|SparseUnivariatePolynomial| F)))
         (|lg| (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
         (|der|
          (|Mapping| (|SparseUnivariatePolynomial| F)
                     (|SparseUnivariatePolynomial| F)))
         ($ (|List| (|SparseUnivariatePolynomial| F))))
        (SPROG
         ((|h| (|SparseUnivariatePolynomial| F)) (#1=#:G750 NIL)
          (|gg| (|SparseUnivariatePolynomial| F))
          (|s| #2=(|SparseUnivariatePolynomial| F))
          (|e| #3=(|SparseUnivariatePolynomial| F))
          (|#G8| (|Record| (|:| |normal| #3#) (|:| |special| #2#)))
          (|e0| (|SparseUnivariatePolynomial| F)) (#4=#:G755 NIL) (|g| NIL)
          (#5=#:G754 NIL) (|d| (|SparseUnivariatePolynomial| F)))
         (SEQ (LETT |d| (SPADCALL |f| |der| (QREFELT $ 12)))
              (LETT |e0|
                    (SPADCALL
                     (PROGN
                      (LETT #5# NIL)
                      (SEQ (LETT |g| NIL) (LETT #4# |lg|) G190
                           (COND
                            ((OR (ATOM #4#) (PROGN (LETT |g| (CAR #4#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #5#
                                   (CONS (SPADCALL |g| (QREFELT $ 13)) #5#))))
                           (LETT #4# (CDR #4#)) (GO G190) G191
                           (EXIT (NREVERSE #5#))))
                     (QREFELT $ 15)))
              (PROGN
               (LETT |#G8| (SPADCALL |e0| |der| (QREFELT $ 17)))
               (LETT |e| (QCAR |#G8|))
               (LETT |s| (QCDR |#G8|))
               |#G8|)
              (LETT |gg| (SPADCALL |d| |e| (QREFELT $ 18)))
              (LETT |h|
                    (PROG2
                        (LETT #1#
                              (SPADCALL
                               (SPADCALL |e| (SPADCALL |e| (QREFELT $ 19))
                                         (QREFELT $ 18))
                               (SPADCALL |gg| (SPADCALL |gg| (QREFELT $ 19))
                                         (QREFELT $ 18))
                               (QREFELT $ 21)))
                        (QCDR #1#)
                      (|check_union2| (QEQCAR #1# 0)
                                      (|SparseUnivariatePolynomial|
                                       (QREFELT $ 7))
                                      (|Union|
                                       (|SparseUnivariatePolynomial|
                                        (QREFELT $ 7))
                                       "failed")
                                      #1#)))
              (EXIT (LIST |d| |h|))))) 

(SDEFUN |RDEPAR;normalize|
        ((|f| (|Fraction| (|SparseUnivariatePolynomial| F)))
         (|der|
          (|Mapping| #1=(|SparseUnivariatePolynomial| F)
                     (|SparseUnivariatePolynomial| F)))
         ($
          (|List|
           (|Record| (|:| |fctr| (|SparseUnivariatePolynomial| F))
                     (|:| |xpnt| (|Integer|))))))
        (SPROG
         ((|rl|
           (|List|
            (|Record| (|:| |fctr| (|SparseUnivariatePolynomial| F))
                      (|:| |xpnt| (|Integer|)))))
          (|pi| #2=(|SparseUnivariatePolynomial| F)) (|m| (|Integer|))
          (|mu| (|Union| (|Integer|) "failed")) (#3=#:G782 NIL) (|rq| NIL)
          (|rql| (|List| (|Fraction| (|Integer|)))) (|r| (F)) (|dd1| #1#)
          (|zk| (|Kernel| F)) (|b| #4=(|SparseUnivariatePolynomial| F))
          (|a| #5=(|SparseUnivariatePolynomial| F))
          (|#G11|
           (|Record| (|:| |coef1| (|SparseUnivariatePolynomial| F))
                     (|:| |coef2| (|SparseUnivariatePolynomial| F))))
          (#6=#:G763 NIL)
          (|eeu|
           (|Union| (|Record| (|:| |coef1| #5#) (|:| |coef2| #4#))
                    #7="failed"))
          (|d2| (|SparseUnivariatePolynomial| F)) (#8=#:G759 NIL)
          (|d1| (|SparseUnivariatePolynomial| F)) (|dd| #2#)
          (|d0| (|SparseUnivariatePolynomial| F)) (|g| #2#)
          (|d| (|SparseUnivariatePolynomial| F)))
         (SEQ (LETT |d| (SPADCALL |f| |der| (QREFELT $ 12)))
              (LETT |g|
                    (SPADCALL |d| (SPADCALL |d| (QREFELT $ 19))
                              (QREFELT $ 18)))
              (LETT |d0|
                    (PROG2 (LETT #8# (SPADCALL |d| |g| (QREFELT $ 21)))
                        (QCDR #8#)
                      (|check_union2| (QEQCAR #8# 0)
                                      (|SparseUnivariatePolynomial|
                                       (QREFELT $ 7))
                                      (|Union|
                                       (|SparseUnivariatePolynomial|
                                        (QREFELT $ 7))
                                       #9="failed")
                                      #8#)))
              (LETT |dd| (SPADCALL |d0| |g| (QREFELT $ 18)))
              (LETT |d1|
                    (PROG2 (LETT #8# (SPADCALL |d0| |dd| (QREFELT $ 21)))
                        (QCDR #8#)
                      (|check_union2| (QEQCAR #8# 0)
                                      (|SparseUnivariatePolynomial|
                                       (QREFELT $ 7))
                                      (|Union|
                                       (|SparseUnivariatePolynomial|
                                        (QREFELT $ 7))
                                       #9#)
                                      #8#)))
              (LETT |d2|
                    (PROG2
                        (LETT #8#
                              (SPADCALL (SPADCALL |f| (QREFELT $ 13)) |d1|
                                        (QREFELT $ 21)))
                        (QCDR #8#)
                      (|check_union2| (QEQCAR #8# 0)
                                      (|SparseUnivariatePolynomial|
                                       (QREFELT $ 7))
                                      (|Union|
                                       (|SparseUnivariatePolynomial|
                                        (QREFELT $ 7))
                                       #9#)
                                      #8#)))
              (LETT |eeu|
                    (SPADCALL |d2| |d1| (SPADCALL |f| (QREFELT $ 22))
                              (QREFELT $ 25)))
              (PROGN
               (LETT |#G11|
                     (PROG2 (LETT #6# |eeu|)
                         (QCDR #6#)
                       (|check_union2| (QEQCAR #6# 0)
                                       (|Record|
                                        (|:| |coef1|
                                             (|SparseUnivariatePolynomial|
                                              (QREFELT $ 7)))
                                        (|:| |coef2|
                                             (|SparseUnivariatePolynomial|
                                              (QREFELT $ 7))))
                                       (|Union|
                                        (|Record|
                                         (|:| |coef1|
                                              (|SparseUnivariatePolynomial|
                                               (QREFELT $ 7)))
                                         (|:| |coef2|
                                              (|SparseUnivariatePolynomial|
                                               (QREFELT $ 7))))
                                        #7#)
                                       #6#)))
               (LETT |a| (QCAR |#G11|))
               (LETT |b| (QCDR |#G11|))
               |#G11|)
              (LETT |zk| (SPADCALL (SPADCALL (QREFELT $ 27)) (QREFELT $ 29)))
              (LETT |dd1| (SPADCALL |d1| |der|))
              (LETT |r|
                    (SPADCALL
                     (SPADCALL |a|
                               (SPADCALL (SPADCALL |zk| (QREFELT $ 31)) |dd1|
                                         (QREFELT $ 32))
                               (QREFELT $ 33))
                     |d1| (QREFELT $ 34)))
              (LETT |rql| (SPADCALL |r| |zk| (QREFELT $ 37))) (LETT |rl| NIL)
              (SEQ (LETT |rq| NIL) (LETT #3# |rql|) G190
                   (COND
                    ((OR (ATOM #3#) (PROGN (LETT |rq| (CAR #3#)) NIL))
                     (GO G191)))
                   (SEQ (LETT |mu| (SPADCALL |rq| (QREFELT $ 40)))
                        (EXIT
                         (COND
                          ((QEQCAR |mu| 0)
                           (SEQ (LETT |m| (QCDR |mu|))
                                (EXIT
                                 (COND
                                  ((> |m| 0)
                                   (SEQ
                                    (LETT |pi|
                                          (SPADCALL
                                           (SPADCALL |a|
                                                     (SPADCALL
                                                      (SPADCALL |m|
                                                                (QREFELT $ 44))
                                                      |dd1| (QREFELT $ 32))
                                                     (QREFELT $ 33))
                                           |d1| (QREFELT $ 18)))
                                    (EXIT
                                     (LETT |rl|
                                           (CONS (CONS |pi| |m|)
                                                 |rl|))))))))))))
                   (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
              (EXIT |rl|)))) 

(SDEFUN |RDEPAR;RF_to_GP|
        ((|f| (|Fraction| (|SparseUnivariatePolynomial| F)))
         ($ (|LaurentPolynomial| F (|SparseUnivariatePolynomial| F))))
        (SPROG ((#1=#:G786 NIL))
               (PROG2
                   (LETT #1#
                         (SPADCALL
                          (SPADCALL (SPADCALL |f| (QREFELT $ 22))
                                    (QREFELT $ 46))
                          (SPADCALL (SPADCALL |f| (QREFELT $ 13))
                                    (QREFELT $ 46))
                          (QREFELT $ 47)))
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 0)
                                 (|LaurentPolynomial| (QREFELT $ 7)
                                                      (|SparseUnivariatePolynomial|
                                                       (QREFELT $ 7)))
                                 (|Union|
                                  (|LaurentPolynomial| (QREFELT $ 7)
                                                       (|SparseUnivariatePolynomial|
                                                        (QREFELT $ 7)))
                                  "failed")
                                 #1#)))) 

(SDEFUN |RDEPAR;do_spde1|
        ((|b| (|SparseUnivariatePolynomial| F))
         (|lc| (|List| (|SparseUnivariatePolynomial| F)))
         (|der|
          (|Mapping| (|SparseUnivariatePolynomial| F)
                     (|SparseUnivariatePolynomial| F)))
         (|get_rs| (|Mapping| #1=(|Matrix| F) (|Matrix| F)))
         ($
          (|List|
           (|Record| (|:| |ratpart| (|SparseUnivariatePolynomial| F))
                     (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#2=#:G810 NIL) (|kv| NIL) (#3=#:G809 NIL)
          (|lkv| (|List| (|Vector| F))) (|rs2| #1#) (|rs1| (|Matrix| F))
          (|lrem| (|List| #4=(|SparseUnivariatePolynomial| F))) (#5=#:G808 NIL)
          (|ar| NIL) (#6=#:G807 NIL)
          (|la| (|List| #7=(|SparseUnivariatePolynomial| F))) (#8=#:G806 NIL)
          (#9=#:G805 NIL)
          (|lar| (|List| (|Record| (|:| |ans| #7#) (|:| |remainder| #4#))))
          (#10=#:G804 NIL) (|c| NIL) (#11=#:G803 NIL))
         (SEQ
          (LETT |lar|
                (PROGN
                 (LETT #11# NIL)
                 (SEQ (LETT |c| NIL) (LETT #10# |lc|) G190
                      (COND
                       ((OR (ATOM #10#) (PROGN (LETT |c| (CAR #10#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #11#
                              (CONS (SPADCALL |b| |c| |der| (QREFELT $ 50))
                                    #11#))))
                      (LETT #10# (CDR #10#)) (GO G190) G191
                      (EXIT (NREVERSE #11#)))))
          (LETT |la|
                (PROGN
                 (LETT #9# NIL)
                 (SEQ (LETT |ar| NIL) (LETT #8# |lar|) G190
                      (COND
                       ((OR (ATOM #8#) (PROGN (LETT |ar| (CAR #8#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #9# (CONS (QCAR |ar|) #9#))))
                      (LETT #8# (CDR #8#)) (GO G190) G191
                      (EXIT (NREVERSE #9#)))))
          (LETT |lrem|
                (PROGN
                 (LETT #6# NIL)
                 (SEQ (LETT |ar| NIL) (LETT #5# |lar|) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |ar| (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #6# (CONS (QCDR |ar|) #6#))))
                      (LETT #5# (CDR #5#)) (GO G190) G191
                      (EXIT (NREVERSE #6#)))))
          (LETT |rs1|
                (SPADCALL (SPADCALL (LIST |lrem|) (QREFELT $ 53))
                          (QREFELT $ 56)))
          (LETT |rs2| (SPADCALL |rs1| |get_rs|))
          (LETT |lkv| (SPADCALL |rs2| (QREFELT $ 58)))
          (EXIT
           (PROGN
            (LETT #3# NIL)
            (SEQ (LETT |kv| NIL) (LETT #2# |lkv|) G190
                 (COND
                  ((OR (ATOM #2#) (PROGN (LETT |kv| (CAR #2#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #3#
                         (CONS (CONS (SPADCALL |kv| |la| (QREFELT $ 62)) |kv|)
                               #3#))))
                 (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT (NREVERSE #3#)))))))) 

(SDEFUN |RDEPAR;param_SPDE|
        ((|a| (|SparseUnivariatePolynomial| F))
         (|b| (|SparseUnivariatePolynomial| F))
         (|lc| (|List| (|SparseUnivariatePolynomial| F))) (|d| (|Integer|))
         (|der|
          (|Mapping| #1=(|SparseUnivariatePolynomial| F)
                     (|SparseUnivariatePolynomial| F)))
         (|get_rs| (|Mapping| #2=(|Matrix| F) (|Matrix| F)))
         (|do_degrad|
          (|Mapping|
           #3=(|List|
               (|Record|
                (|:| |ratpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
                (|:| |coeffs| (|Vector| F))))
           (|Fraction| (|SparseUnivariatePolynomial| F))
           (|List| (|Fraction| (|SparseUnivariatePolynomial| F)))))
         (|x| (|Symbol|))
         ($
          #4=(|List|
              (|Record| (|:| |ratpart| (|SparseUnivariatePolynomial| F))
                        (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((|nres|
           (|List|
            (|Record| (|:| |ratpart| (|SparseUnivariatePolynomial| F))
                      (|:| |coeffs| (|Vector| F)))))
          (|ans1| (|SparseUnivariatePolynomial| F)) (|bv| (|Vector| F))
          (#5=#:G881 NIL) (|be| NIL) (|s2| #4#)
          (|nlc| (|List| (|SparseUnivariatePolynomial| F))) (#6=#:G880 NIL)
          (|kv| NIL) (#7=#:G879 NIL) (|q| NIL) (#8=#:G878 NIL)
          (|lkv| (|List| (|Vector| F))) (|rs2| #2#) (|rs1| (|Matrix| F))
          (|lr| (|List| #9=(|SparseUnivariatePolynomial| F))) (#10=#:G877 NIL)
          (#11=#:G876 NIL)
          (|lq|
           (|List|
            (|Record| (|:| |quotient| (|SparseUnivariatePolynomial| F))
                      (|:| |remainder| #9#))))
          (#12=#:G875 NIL) (|c| NIL) (#13=#:G874 NIL)
          (|oans| #14=(|List| (|SparseUnivariatePolynomial| F)))
          (|aa| #15=(|SparseUnivariatePolynomial| F)) (#16=#:G839 NIL)
          (|g| #17=(|SparseUnivariatePolynomial| F))
          (|dres|
           (|Record| (|:| |ans| (|List| (|SparseUnivariatePolynomial| F)))
                     (|:| |acoeff| (|SparseUnivariatePolynomial| F))
                     (|:| |eegen| (|SparseUnivariatePolynomial| F))
                     (|:| |bpar| (|SparseUnivariatePolynomial| F))
                     (|:| |lcpar| (|List| (|SparseUnivariatePolynomial| F)))
                     (|:| |dpar| (|Integer|))))
          (#18=#:G873 NIL) (#19=#:G872 NIL)
          (|a1l| (|List| #20=(|SparseUnivariatePolynomial| F)))
          (#21=#:G871 NIL) (|rsol| NIL) (#22=#:G870 NIL)
          (|m1| (|Matrix| (|SparseUnivariatePolynomial| F))) (#23=#:G869 NIL)
          (#24=#:G868 NIL)
          (|lrs|
           (|List|
            (|Record| (|:| |ans| (|SparseUnivariatePolynomial| F))
                      (|:| |remainder| (|SparseUnivariatePolynomial| F)))))
          (|s1|
           (|Union|
            (|List|
             (|Record| (|:| |ans| #20#)
                       (|:| |remainder| (|SparseUnivariatePolynomial| F))))
            (|Record| (|:| |ans| #14#) (|:| |acoeff| #15#) (|:| |eegen| #17#)
                      (|:| |bpar| (|SparseUnivariatePolynomial| F))
                      (|:| |lcpar| (|List| (|SparseUnivariatePolynomial| F)))
                      (|:| |dpar| (|Integer|)))))
          (#25=#:G867 NIL) (|re| NIL) (#26=#:G866 NIL) (|res1| #3#)
          (|lcr| (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
          (#27=#:G865 NIL) (#28=#:G864 NIL) (|base_case| (|Boolean|))
          (|degt| (|Integer|)) (|dt| #1#))
         (SEQ
          (LETT |dt|
                (SPADCALL (SPADCALL (|spadConstant| $ 64) 1 (QREFELT $ 66))
                          |der|))
          (EXIT
           (COND
            ((EQL (SPADCALL |a| (QREFELT $ 67)) 0)
             (COND
              ((SPADCALL |a| (|spadConstant| $ 68) (QREFELT $ 70))
               (|error| "param_SPDE: degree(a) = 0 but a ~= 1"))
              (#29='T
               (SEQ (LETT |degt| (- (SPADCALL |dt| (QREFELT $ 67)) 1))
                    (LETT |base_case|
                          (SPADCALL |dt| (|spadConstant| $ 68) (QREFELT $ 71)))
                    (COND
                     ((SPADCALL |b| (|spadConstant| $ 72) (QREFELT $ 70))
                      (COND
                       ((OR |base_case|
                            (> (SPADCALL |b| (QREFELT $ 67)) (MAX 0 |degt|)))
                        (EXIT
                         (|RDEPAR;do_spde1| |b| |lc| |der| |get_rs| $))))))
                    (LETT |lcr|
                          (PROGN
                           (LETT #28# NIL)
                           (SEQ (LETT |c| NIL) (LETT #27# |lc|) G190
                                (COND
                                 ((OR (ATOM #27#)
                                      (PROGN (LETT |c| (CAR #27#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #28#
                                        (CONS (SPADCALL |c| (QREFELT $ 73))
                                              #28#))))
                                (LETT #27# (CDR #27#)) (GO G190) G191
                                (EXIT (NREVERSE #28#)))))
                    (LETT |res1|
                          (SPADCALL (SPADCALL |b| (QREFELT $ 73)) |lcr|
                                    |do_degrad|))
                    (EXIT
                     (PROGN
                      (LETT #26# NIL)
                      (SEQ (LETT |re| NIL) (LETT #25# |res1|) G190
                           (COND
                            ((OR (ATOM #25#)
                                 (PROGN (LETT |re| (CAR #25#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #26#
                                   (CONS
                                    (CONS (SPADCALL (QCAR |re|) (QREFELT $ 74))
                                          (QCDR |re|))
                                    #26#))))
                           (LETT #25# (CDR #25#)) (GO G190) G191
                           (EXIT (NREVERSE #26#)))))))))
            (#29#
             (SEQ (LETT |s1| (SPADCALL |a| |b| |lc| |d| |der| (QREFELT $ 77)))
                  (EXIT
                   (COND
                    ((QEQCAR |s1| 0)
                     (SEQ (LETT |lrs| (QCDR |s1|))
                          (LETT |m1|
                                (SPADCALL
                                 (LIST
                                  (PROGN
                                   (LETT #24# NIL)
                                   (SEQ (LETT |rsol| NIL) (LETT #23# |lrs|)
                                        G190
                                        (COND
                                         ((OR (ATOM #23#)
                                              (PROGN
                                               (LETT |rsol| (CAR #23#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #24#
                                                (CONS (QCDR |rsol|) #24#))))
                                        (LETT #23# (CDR #23#)) (GO G190) G191
                                        (EXIT (NREVERSE #24#)))))
                                 (QREFELT $ 53)))
                          (LETT |rs1| (SPADCALL |m1| (QREFELT $ 56)))
                          (LETT |rs2| (SPADCALL |rs1| |get_rs|))
                          (LETT |lkv| (SPADCALL |rs2| (QREFELT $ 58)))
                          (LETT |a1l|
                                (PROGN
                                 (LETT #22# NIL)
                                 (SEQ (LETT |rsol| NIL) (LETT #21# |lrs|) G190
                                      (COND
                                       ((OR (ATOM #21#)
                                            (PROGN
                                             (LETT |rsol| (CAR #21#))
                                             NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #22# (CONS (QCAR |rsol|) #22#))))
                                      (LETT #21# (CDR #21#)) (GO G190) G191
                                      (EXIT (NREVERSE #22#)))))
                          (EXIT
                           (PROGN
                            (LETT #19# NIL)
                            (SEQ (LETT |kv| NIL) (LETT #18# |lkv|) G190
                                 (COND
                                  ((OR (ATOM #18#)
                                       (PROGN (LETT |kv| (CAR #18#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #19#
                                         (CONS
                                          (CONS
                                           (SPADCALL |kv| |a1l| (QREFELT $ 62))
                                           |kv|)
                                          #19#))))
                                 (LETT #18# (CDR #18#)) (GO G190) G191
                                 (EXIT (NREVERSE #19#)))))))
                    (#29#
                     (SEQ (LETT |dres| (QCDR |s1|)) (LETT |g| (QVELT |dres| 2))
                          (LETT |a|
                                (PROG2
                                    (LETT #16#
                                          (SPADCALL |a| |g| (QREFELT $ 21)))
                                    (QCDR #16#)
                                  (|check_union2| (QEQCAR #16# 0)
                                                  (|SparseUnivariatePolynomial|
                                                   (QREFELT $ 7))
                                                  (|Union|
                                                   (|SparseUnivariatePolynomial|
                                                    (QREFELT $ 7))
                                                   #30="failed")
                                                  #16#)))
                          (LETT |b|
                                (PROG2
                                    (LETT #16#
                                          (SPADCALL (QVELT |dres| 3) |g|
                                                    (QREFELT $ 21)))
                                    (QCDR #16#)
                                  (|check_union2| (QEQCAR #16# 0)
                                                  (|SparseUnivariatePolynomial|
                                                   (QREFELT $ 7))
                                                  (|Union|
                                                   (|SparseUnivariatePolynomial|
                                                    (QREFELT $ 7))
                                                   #30#)
                                                  #16#)))
                          (LETT |aa| (QVELT |dres| 1))
                          (LETT |oans| (QVELT |dres| 0))
                          (LETT |lq|
                                (PROGN
                                 (LETT #13# NIL)
                                 (SEQ (LETT |c| NIL)
                                      (LETT #12# (QVELT |dres| 4)) G190
                                      (COND
                                       ((OR (ATOM #12#)
                                            (PROGN (LETT |c| (CAR #12#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #13#
                                              (CONS
                                               (SPADCALL |c| |g|
                                                         (QREFELT $ 79))
                                               #13#))))
                                      (LETT #12# (CDR #12#)) (GO G190) G191
                                      (EXIT (NREVERSE #13#)))))
                          (LETT |lr|
                                (PROGN
                                 (LETT #11# NIL)
                                 (SEQ (LETT |q| NIL) (LETT #10# |lq|) G190
                                      (COND
                                       ((OR (ATOM #10#)
                                            (PROGN (LETT |q| (CAR #10#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #11# (CONS (QCDR |q|) #11#))))
                                      (LETT #10# (CDR #10#)) (GO G190) G191
                                      (EXIT (NREVERSE #11#)))))
                          (LETT |rs1|
                                (SPADCALL (SPADCALL (LIST |lr|) (QREFELT $ 53))
                                          (QREFELT $ 56)))
                          (LETT |rs2| (SPADCALL |rs1| |get_rs|))
                          (LETT |lkv| (SPADCALL |rs2| (QREFELT $ 58)))
                          (EXIT
                           (COND ((NULL |lkv|) NIL)
                                 (#29#
                                  (SEQ
                                   (LETT |lc|
                                         (PROGN
                                          (LETT #8# NIL)
                                          (SEQ (LETT |q| NIL) (LETT #7# |lq|)
                                               G190
                                               (COND
                                                ((OR (ATOM #7#)
                                                     (PROGN
                                                      (LETT |q| (CAR #7#))
                                                      NIL))
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (LETT #8#
                                                       (CONS (QCAR |q|) #8#))))
                                               (LETT #7# (CDR #7#)) (GO G190)
                                               G191 (EXIT (NREVERSE #8#)))))
                                   (LETT |nlc| NIL)
                                   (SEQ (LETT |kv| NIL) (LETT #6# |lkv|) G190
                                        (COND
                                         ((OR (ATOM #6#)
                                              (PROGN
                                               (LETT |kv| (CAR #6#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT |nlc|
                                                (CONS
                                                 (SPADCALL |kv| |lc|
                                                           (QREFELT $ 62))
                                                 |nlc|))))
                                        (LETT #6# (CDR #6#)) (GO G190) G191
                                        (EXIT NIL))
                                   (LETT |nlc| (NREVERSE |nlc|))
                                   (LETT |s2|
                                         (|RDEPAR;param_SPDE| |a| |b| |nlc|
                                          (QVELT |dres| 5) |der| |get_rs|
                                          |do_degrad| |x| $))
                                   (LETT |nres| NIL)
                                   (SEQ (LETT |be| NIL) (LETT #5# |s2|) G190
                                        (COND
                                         ((OR (ATOM #5#)
                                              (PROGN
                                               (LETT |be| (CAR #5#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (LETT |bv|
                                               (SPADCALL (QCDR |be|) |lkv|
                                                         (QREFELT $ 80)))
                                         (LETT |ans1|
                                               (SPADCALL
                                                (SPADCALL |bv| |oans|
                                                          (QREFELT $ 62))
                                                (SPADCALL |aa| (QCAR |be|)
                                                          (QREFELT $ 81))
                                                (QREFELT $ 82)))
                                         (EXIT
                                          (LETT |nres|
                                                (CONS (CONS |ans1| |bv|)
                                                      |nres|))))
                                        (LETT #5# (CDR #5#)) (GO G190) G191
                                        (EXIT NIL))
                                   (EXIT (NREVERSE |nres|))))))))))))))))) 

(SDEFUN |RDEPAR;integer_vector|
        ((|v| (|Vector| (|Fraction| (|Integer|))))
         ($ (|Union| (|Vector| (|Integer|)) "failed")))
        (SPROG
         ((#1=#:G892 NIL) (|i| NIL) (#2=#:G891 NIL) (|d| #3=(|Integer|))
          (|nv| #4=(|Vector| (|Fraction| (|Integer|))))
          (|#G42| (|Record| (|:| |num| #4#) (|:| |den| #3#))))
         (SEQ
          (PROGN
           (LETT |#G42| (SPADCALL |v| (QREFELT $ 86)))
           (LETT |nv| (QCAR |#G42|))
           (LETT |d| (QCDR |#G42|))
           |#G42|)
          (EXIT
           (COND
            ((OR (SPADCALL |d| 1 (QREFELT $ 87))
                 (SPADCALL (SPADCALL |nv| 1 (QREFELT $ 88))
                           (|spadConstant| $ 89) (QREFELT $ 90)))
             (CONS 1 "failed"))
            ('T
             (CONS 0
                   (SPADCALL
                    (PROGN
                     (LETT #2# NIL)
                     (SEQ (LETT |i| 1) (LETT #1# (QVSIZE |nv|)) G190
                          (COND ((|greater_SI| |i| #1#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #2#
                                  (CONS
                                   (SPADCALL (SPADCALL |nv| |i| (QREFELT $ 88))
                                             (QREFELT $ 91))
                                   #2#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #2#))))
                    (QREFELT $ 94))))))))) 

(SDEFUN |RDEPAR;do_SPDE_prim0|
        ((|b| (F)) (|lc| (|List| (|SparseUnivariatePolynomial| F)))
         (|lk| (|List| (|Kernel| F)))
         (|ext|
          (|Mapping|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
           (|List| (|Kernel| F)) (|List| F)))
         (|logi|
          (|Mapping|
           (|Record| (|:| |logands| (|List| F))
                     (|:| |basis|
                          (|List| (|Vector| (|Fraction| (|Integer|))))))
           (|List| (|Kernel| F)) (|List| F)))
         (|der|
          (|Mapping| (|SparseUnivariatePolynomial| F)
                     (|SparseUnivariatePolynomial| F)))
         (|get_rs| (|Mapping| (|Matrix| F) (|Matrix| F))) (|x| (|Symbol|))
         ($
          (|List|
           (|Record|
            (|:| |ratpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G956 NIL) (|ba| NIL) (#2=#:G957 NIL) (|bv| NIL) (#3=#:G955 NIL)
          (|lba| (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
          (|cb| (|List| (|Vector| F)))
          (|nlba| (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
          (#4=#:G928 NIL) (#5=#:G954 NIL) (|be| NIL) (#6=#:G953 NIL)
          (|cba| (|List| F)) (#7=#:G952 NIL) (#8=#:G951 NIL)
          (|ncb| (|List| (|Vector| F))) (#9=#:G950 NIL) (#10=#:G949 NIL)
          (|s2f|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))))
          (|lgj1| (|List| F)) (|ff| (F)) (#11=#:G947 NIL) (#12=#:G948 NIL)
          (|aa| NIL) (|lgj| (|List| F)) (|gij| (F))
          (|gi| (|SparseUnivariatePolynomial| F)) (#13=#:G946 NIL) (|i| NIL)
          (|j| NIL) (#14=#:G945 NIL) (#15=#:G944 NIL) (#16=#:G943 NIL)
          (#17=#:G942 NIL) (|dk| (F)) (|d| (|Integer|)) (#18=#:G941 NIL)
          (|c| NIL) (#19=#:G940 NIL) (#20=#:G938 NIL) (#21=#:G939 NIL)
          (#22=#:G937 NIL) (#23=#:G936 NIL)
          (|vg2| (|Vector| (|SparseUnivariatePolynomial| F)))
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (LENGTH |lc|))
              (LETT |vg2| (SPADCALL |lc| (QREFELT $ 96)))
              (LETT |cb|
                    (PROGN
                     (LETT #23# NIL)
                     (SEQ (LETT |i| 1) (LETT #22# |n|) G190
                          (COND ((|greater_SI| |i| #22#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #23#
                                  (CONS (MAKEARR1 |n| (|spadConstant| $ 42))
                                        #23#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #23#)))))
              (SEQ (LETT |bv| NIL) (LETT #21# |cb|) (LETT |i| 1)
                   (LETT #20# |n|) G190
                   (COND
                    ((OR (|greater_SI| |i| #20#) (ATOM #21#)
                         (PROGN (LETT |bv| (CAR #21#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |bv| |i| (|spadConstant| $ 64) (QREFELT $ 97))))
                   (LETT |i| (PROG1 (|inc_SI| |i|) (LETT #21# (CDR #21#))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |d|
                    (SPADCALL (ELT $ 98)
                              (PROGN
                               (LETT #19# NIL)
                               (SEQ (LETT |c| NIL) (LETT #18# |lc|) G190
                                    (COND
                                     ((OR (ATOM #18#)
                                          (PROGN (LETT |c| (CAR #18#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #19#
                                            (CONS (SPADCALL |c| (QREFELT $ 67))
                                                  #19#))))
                                    (LETT #18# (CDR #18#)) (GO G190) G191
                                    (EXIT (NREVERSE #19#))))
                              0 (QREFELT $ 100)))
              (LETT |dk|
                    (SPADCALL
                     (SPADCALL
                      (SPADCALL (|spadConstant| $ 64) 1 (QREFELT $ 66)) |der|)
                     (QREFELT $ 101)))
              (LETT |lba|
                    (PROGN
                     (LETT #17# NIL)
                     (SEQ (LETT |bv| NIL) (LETT #16# |cb|) G190
                          (COND
                           ((OR (ATOM #16#) (PROGN (LETT |bv| (CAR #16#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #17# (CONS (|spadConstant| $ 102) #17#))))
                          (LETT #16# (CDR #16#)) (GO G190) G191
                          (EXIT (NREVERSE #17#)))))
              (LETT |cba|
                    (PROGN
                     (LETT #15# NIL)
                     (SEQ (LETT |bv| NIL) (LETT #14# |cb|) G190
                          (COND
                           ((OR (ATOM #14#) (PROGN (LETT |bv| (CAR #14#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #15# (CONS (|spadConstant| $ 42) #15#))))
                          (LETT #14# (CDR #14#)) (GO G190) G191
                          (EXIT (NREVERSE #15#)))))
              (SEQ (LETT |j| |d|) G190 (COND ((< |j| 0) (GO G191)))
                   (SEQ (LETT |lgj| NIL)
                        (SEQ (LETT |i| 1) (LETT #13# |n|) G190
                             (COND ((|greater_SI| |i| #13#) (GO G191)))
                             (SEQ
                              (LETT |gi| (SPADCALL |vg2| |i| (QREFELT $ 103)))
                              (LETT |gij| (|spadConstant| $ 42))
                              (COND
                               ((EQL (SPADCALL |gi| (QREFELT $ 67)) |j|)
                                (SEQ
                                 (LETT |gij| (SPADCALL |gi| (QREFELT $ 104)))
                                 (EXIT
                                  (SPADCALL |vg2| |i|
                                            (SPADCALL |gi| (QREFELT $ 105))
                                            (QREFELT $ 106))))))
                              (EXIT
                               (LETT |lgj|
                                     (CONS (SPADCALL |gij| (QREFELT $ 107))
                                           |lgj|))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))
                        (LETT |lgj| (NREVERSE |lgj|)) (LETT |lgj1| NIL)
                        (SEQ (LETT |aa| NIL) (LETT #12# |cba|) (LETT |bv| NIL)
                             (LETT #11# |cb|) G190
                             (COND
                              ((OR (ATOM #11#)
                                   (PROGN (LETT |bv| (CAR #11#)) NIL)
                                   (ATOM #12#)
                                   (PROGN (LETT |aa| (CAR #12#)) NIL))
                               (GO G191)))
                             (SEQ
                              (LETT |ff|
                                    (SPADCALL
                                     (SPADCALL |bv| |lgj| (QREFELT $ 109))
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL (+ |j| 1) (QREFELT $ 44)) |dk|
                                       (QREFELT $ 110))
                                      |aa| (QREFELT $ 110))
                                     (QREFELT $ 111)))
                              (EXIT (LETT |lgj1| (CONS |ff| |lgj1|))))
                             (LETT #11#
                                   (PROG1 (CDR #11#) (LETT #12# (CDR #12#))))
                             (GO G190) G191 (EXIT NIL))
                        (LETT |lgj1| (NREVERSE |lgj1|))
                        (LETT |s2f|
                              (SPADCALL |b| |lgj1| |x| |lk| |ext| |logi|
                                        (QREFELT $ 118)))
                        (LETT |ncb|
                              (PROGN
                               (LETT #10# NIL)
                               (SEQ (LETT |be| NIL) (LETT #9# |s2f|) G190
                                    (COND
                                     ((OR (ATOM #9#)
                                          (PROGN (LETT |be| (CAR #9#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #10#
                                            (CONS
                                             (SPADCALL (QCDR |be|) |cb|
                                                       (QREFELT $ 80))
                                             #10#))))
                                    (LETT #9# (CDR #9#)) (GO G190) G191
                                    (EXIT (NREVERSE #10#)))))
                        (LETT |cba|
                              (PROGN
                               (LETT #8# NIL)
                               (SEQ (LETT |be| NIL) (LETT #7# |s2f|) G190
                                    (COND
                                     ((OR (ATOM #7#)
                                          (PROGN (LETT |be| (CAR #7#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT (LETT #8# (CONS (QCAR |be|) #8#))))
                                    (LETT #7# (CDR #7#)) (GO G190) G191
                                    (EXIT (NREVERSE #8#)))))
                        (LETT |nlba|
                              (PROGN
                               (LETT #6# NIL)
                               (SEQ (LETT |be| NIL) (LETT #5# |s2f|) G190
                                    (COND
                                     ((OR (ATOM #5#)
                                          (PROGN (LETT |be| (CAR #5#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #6#
                                            (CONS
                                             (SPADCALL
                                              (SPADCALL (QCDR |be|) |lba|
                                                        (QREFELT $ 120))
                                              (SPADCALL
                                               (SPADCALL (QCAR |be|)
                                                         (PROG1 (LETT #4# |j|)
                                                           (|check_subtype2|
                                                            (>= #4# 0)
                                                            '(|NonNegativeInteger|)
                                                            '(|Integer|) #4#))
                                                         (QREFELT $ 66))
                                               (QREFELT $ 73))
                                              (QREFELT $ 121))
                                             #6#))))
                                    (LETT #5# (CDR #5#)) (GO G190) G191
                                    (EXIT (NREVERSE #6#)))))
                        (LETT |cb| |ncb|) (EXIT (LETT |lba| |nlba|)))
                   (LETT |j| (+ |j| -1)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (PROGN
                (LETT #3# NIL)
                (SEQ (LETT |bv| NIL) (LETT #2# |cb|) (LETT |ba| NIL)
                     (LETT #1# |lba|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |ba| (CAR #1#)) NIL)
                           (ATOM #2#) (PROGN (LETT |bv| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ (EXIT (LETT #3# (CONS (CONS |ba| |bv|) #3#))))
                     (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                     (GO G190) G191 (EXIT (NREVERSE #3#)))))))) 

(SDEFUN |RDEPAR;do_ext|
        ((|ext|
          (|Mapping|
           #1=(|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
           (|List| (|Kernel| F)) (|List| F)))
         (|lcr| (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
         (|k| (|Kernel| F)) (|lk| (|List| (|Kernel| F)))
         ($
          (|List|
           (|Record|
            (|:| |ratpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#2=#:G971 NIL) (|be| NIL) (#3=#:G970 NIL) (|res1| #1#)
          (|lc| (|List| F)) (#4=#:G969 NIL) (|cr| NIL) (#5=#:G968 NIL))
         (SEQ
          (LETT |lc|
                (PROGN
                 (LETT #5# NIL)
                 (SEQ (LETT |cr| NIL) (LETT #4# |lcr|) G190
                      (COND
                       ((OR (ATOM #4#) (PROGN (LETT |cr| (CAR #4#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #5#
                              (CONS (SPADCALL |cr| |k| (QREFELT $ 123)) #5#))))
                      (LETT #4# (CDR #4#)) (GO G190) G191
                      (EXIT (NREVERSE #5#)))))
          (LETT |res1| (SPADCALL |lk| |lc| |ext|))
          (EXIT
           (PROGN
            (LETT #3# NIL)
            (SEQ (LETT |be| NIL) (LETT #2# |res1|) G190
                 (COND
                  ((OR (ATOM #2#) (PROGN (LETT |be| (CAR #2#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #3#
                         (CONS
                          (CONS (SPADCALL (QCAR |be|) |k| (QREFELT $ 125))
                                (QCDR |be|))
                          #3#))))
                 (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT (NREVERSE #3#)))))))) 

(SDEFUN |RDEPAR;do_SPDE_prim|
        ((|a| (|SparseUnivariatePolynomial| F))
         (|bbr| (|Fraction| (|SparseUnivariatePolynomial| F)))
         (|is_der| (|Boolean|))
         (|lcr| (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
         (|k| (|Kernel| F)) (|lk| (|List| (|Kernel| F)))
         (|ext|
          (|Mapping|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
           (|List| (|Kernel| F)) (|List| F)))
         (|logi|
          (|Mapping|
           #1=(|Record| (|:| |logands| #2=(|List| F))
                        (|:| |basis|
                             #3=(|List| (|Vector| (|Fraction| (|Integer|))))))
           (|List| (|Kernel| F)) (|List| F)))
         (|der|
          (|Mapping| (|SparseUnivariatePolynomial| F)
                     (|SparseUnivariatePolynomial| F)))
         (|get_rs| (|Mapping| (|Matrix| F) (|Matrix| F))) (|x| (|Symbol|))
         ($
          (|List|
           (|Record|
            (|:| |ratpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#4=#:G1027 NIL) (|re| NIL) (#5=#:G1026 NIL)
          (|res1|
           (|List|
            (|Record| (|:| |ratpart| (|SparseUnivariatePolynomial| F))
                      (|:| |coeffs| (|Vector| F)))))
          (|do_degrad|
           (|Mapping|
            (|List|
             (|Record|
              (|:| |ratpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
              (|:| |coeffs| (|Vector| F))))
            (|Fraction| (|SparseUnivariatePolynomial| F))
            (|List| (|Fraction| (|SparseUnivariatePolynomial| F)))))
          (|n| (|Integer|)) (|mu| (|Union| (|Integer|) "failed")) (|mf| (F))
          (|r0|
           (|Union| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))
                    "failed"))
          (|f1| (F)) (|b1| (|SparseUnivariatePolynomial| F)) (|f0| (F))
          (|bvu| (|Union| (|Vector| (|Integer|)) "failed"))
          (|bv| (|Vector| (|Fraction| (|Integer|)))) (|bl| #3#) (|ll| #2#)
          (|#G86| #1#) (|dc| (|Integer|)) (#6=#:G1025 NIL) (|c| NIL)
          (#7=#:G1024 NIL) (|db| #8=(|NonNegativeInteger|)) (|da| #8#)
          (|lc| (|List| (|SparseUnivariatePolynomial| F))) (#9=#:G1023 NIL)
          (|cr| NIL) (#10=#:G1022 NIL) (|b| (|SparseUnivariatePolynomial| F))
          (|base_case| (|Boolean|)) (|fp| (F)))
         (SEQ
          (LETT |fp|
                (SPADCALL
                 (SPADCALL (SPADCALL (|spadConstant| $ 64) 1 (QREFELT $ 66))
                           |der|)
                 (QREFELT $ 101)))
          (LETT |base_case|
                (SPADCALL |fp| (|spadConstant| $ 64) (QREFELT $ 126)))
          (LETT |b| (SPADCALL |bbr| (QREFELT $ 74)))
          (LETT |lc|
                (PROGN
                 (LETT #10# NIL)
                 (SEQ (LETT |cr| NIL) (LETT #9# |lcr|) G190
                      (COND
                       ((OR (ATOM #9#) (PROGN (LETT |cr| (CAR #9#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #10#
                              (CONS (SPADCALL |cr| (QREFELT $ 74)) #10#))))
                      (LETT #9# (CDR #9#)) (GO G190) G191
                      (EXIT (NREVERSE #10#)))))
          (LETT |da| (SPADCALL |a| (QREFELT $ 67)))
          (LETT |db| (SPADCALL |b| (QREFELT $ 67)))
          (LETT |dc|
                (SPADCALL (ELT $ 98)
                          (PROGN
                           (LETT #7# NIL)
                           (SEQ (LETT |c| NIL) (LETT #6# |lc|) G190
                                (COND
                                 ((OR (ATOM #6#)
                                      (PROGN (LETT |c| (CAR #6#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #7#
                                        (CONS (SPADCALL |c| (QREFELT $ 67))
                                              #7#))))
                                (LETT #6# (CDR #6#)) (GO G190) G191
                                (EXIT (NREVERSE #7#))))
                          (QREFELT $ 127)))
          (COND
           ((NULL |base_case|)
            (COND
             ((EQL |da| 0)
              (COND
               ((EQL |db| 0)
                (EXIT
                 (SEQ
                  (LETT |b1|
                        (SPADCALL (SPADCALL |b| (QREFELT $ 101))
                                  (SPADCALL |a| (QREFELT $ 101))
                                  (QREFELT $ 128)))
                  (EXIT
                   (COND
                    ((SPADCALL |b1| (|spadConstant| $ 42) (QREFELT $ 126))
                     (|RDEPAR;do_ext| |ext| |lcr| |k| |lk| $))
                    (#11='T
                     (SEQ
                      (COND
                       ((NULL |is_der|)
                        (SEQ
                         (PROGN
                          (LETT |#G86| (SPADCALL |lk| (LIST |b1|) |logi|))
                          (LETT |ll| (QCAR |#G86|))
                          (LETT |bl| (QCDR |#G86|))
                          |#G86|)
                         (EXIT
                          (COND
                           ((NULL (NULL |bl|))
                            (SEQ (LETT |bv| (|SPADfirst| |bl|))
                                 (LETT |bvu| (|RDEPAR;integer_vector| |bv| $))
                                 (EXIT
                                  (COND
                                   ((QEQCAR |bvu| 0)
                                    (|error|
                                     "need transform and call ext")))))))))))
                      (EXIT
                       (|RDEPAR;do_SPDE_prim0| |b1| |lc| |lk| |ext| |logi|
                        |der| |get_rs| |x| $))))))))))))))
          (LETT |n|
                (COND ((> |db| |da|) (MAX 0 (- |dc| |db|)))
                      (#11# (MAX 0 (+ (- |dc| |da|) 1)))))
          (COND
           ((EQL |da| (+ |db| 1))
            (SEQ
             (LETT |f0|
                   (SPADCALL
                    (SPADCALL (SPADCALL |b| (QREFELT $ 104))
                              (SPADCALL |a| (QREFELT $ 104)) (QREFELT $ 128))
                    (QREFELT $ 107)))
             (EXIT
              (COND
               (|base_case|
                (SEQ (LETT |mu| (SPADCALL |f0| (QREFELT $ 129)))
                     (EXIT
                      (COND
                       ((QEQCAR |mu| 0) (LETT |n| (MAX |n| (QCDR |mu|))))))))
               (#11#
                (SEQ
                 (LETT |r0|
                       (QCAR
                        (SPADCALL
                         (SPADCALL |lk|
                                   (LIST (SPADCALL |f0| (QREFELT $ 107)) |fp|)
                                   |ext|)
                         (QREFELT $ 132))))
                 (EXIT
                  (COND
                   ((NULL (QEQCAR |r0| 1))
                    (SEQ
                     (LETT |mf|
                           (SPADCALL (QCDR (QCDR |r0|)) 1 (QREFELT $ 133)))
                     (LETT |mu| (SPADCALL |mf| (QREFELT $ 129)))
                     (EXIT
                      (COND
                       ((QEQCAR |mu| 0)
                        (LETT |n| (MAX |n| (QCDR |mu|)))))))))))))))))
          (COND
           ((NULL |base_case|)
            (COND
             ((EQL |da| |db|)
              (SEQ
               (LETT |f0|
                     (SPADCALL
                      (SPADCALL (SPADCALL |b| (QREFELT $ 104))
                                (SPADCALL |a| (QREFELT $ 104)) (QREFELT $ 128))
                      (QREFELT $ 107)))
               (LETT |b1|
                     (SPADCALL (SPADCALL |f0| |a| (QREFELT $ 32)) |b|
                               (QREFELT $ 82)))
               (EXIT
                (COND
                 ((EQL (+ (SPADCALL |b1| (QREFELT $ 67)) 1) |da|)
                  (SEQ
                   (LETT |f1|
                         (SPADCALL
                          (SPADCALL (SPADCALL |b1| (QREFELT $ 104))
                                    (SPADCALL |a| (QREFELT $ 104))
                                    (QREFELT $ 128))
                          (QREFELT $ 107)))
                   (LETT |r0|
                         (QCAR
                          (SPADCALL
                           (SPADCALL |lk|
                                     (LIST (SPADCALL |f1| (QREFELT $ 107))
                                           |fp|)
                                     |ext|)
                           (QREFELT $ 132))))
                   (EXIT
                    (COND
                     ((NULL (QEQCAR |r0| 1))
                      (SEQ
                       (LETT |mf|
                             (SPADCALL (QCDR (QCDR |r0|)) 1 (QREFELT $ 133)))
                       (LETT |mu| (SPADCALL |mf| (QREFELT $ 129)))
                       (EXIT
                        (COND
                         ((QEQCAR |mu| 0)
                          (LETT |n| (MAX |n| (QCDR |mu|)))))))))))))))))))
          (LETT |do_degrad|
                (CONS #'|RDEPAR;do_SPDE_prim!0|
                      (VECTOR |x| |get_rs| |der| |logi| |ext| |lk| |k| |is_der|
                              $)))
          (LETT |res1|
                (|RDEPAR;param_SPDE| |a| |b| |lc| |n| |der| |get_rs|
                 |do_degrad| |x| $))
          (EXIT
           (PROGN
            (LETT #5# NIL)
            (SEQ (LETT |re| NIL) (LETT #4# |res1|) G190
                 (COND
                  ((OR (ATOM #4#) (PROGN (LETT |re| (CAR #4#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #5#
                         (CONS
                          (CONS (SPADCALL (QCAR |re|) (QREFELT $ 73))
                                (QCDR |re|))
                          #5#))))
                 (LETT #4# (CDR #4#)) (GO G190) G191 (EXIT (NREVERSE #5#)))))))) 

(SDEFUN |RDEPAR;do_SPDE_prim!0| ((|bb| NIL) (|lc1| NIL) ($$ NIL))
        (PROG ($ |is_der| |k| |lk| |ext| |logi| |der| |get_rs| |x|)
          (LETT $ (QREFELT $$ 8))
          (LETT |is_der| (QREFELT $$ 7))
          (LETT |k| (QREFELT $$ 6))
          (LETT |lk| (QREFELT $$ 5))
          (LETT |ext| (QREFELT $$ 4))
          (LETT |logi| (QREFELT $$ 3))
          (LETT |der| (QREFELT $$ 2))
          (LETT |get_rs| (QREFELT $$ 1))
          (LETT |x| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|RDEPAR;do_SPDE_prim| (|spadConstant| $ 68) |bb| |is_der| |lc1|
             |k| |lk| |ext| |logi| |der| |get_rs| |x| $))))) 

(SDEFUN |RDEPAR;do_SPDE_exp0|
        ((|a| (F)) (|b| (F))
         (|lcr|
          (|List| (|LaurentPolynomial| F (|SparseUnivariatePolynomial| F))))
         (|lk| (|List| (|Kernel| F))) (|eta| (F))
         (|ext|
          (|Mapping|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
           (|List| (|Kernel| F)) (|List| F)))
         (|logi|
          (|Mapping|
           (|Record| (|:| |logands| (|List| F))
                     (|:| |basis|
                          (|List| (|Vector| (|Fraction| (|Integer|))))))
           (|List| (|Kernel| F)) (|List| F)))
         (|x| (|Symbol|))
         ($
          (|List|
           (|Record|
            (|:| |ratpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G1081 NIL) (|re| NIL) (#2=#:G1082 NIL) (|bv| NIL)
          (#3=#:G1080 NIL) (|j| #4=(|Integer|))
          (|lba|
           (|List| (|LaurentPolynomial| F (|SparseUnivariatePolynomial| F))))
          (|cb| (|List| (|Vector| F)))
          (|nlba|
           (|List| (|LaurentPolynomial| F (|SparseUnivariatePolynomial| F))))
          (#5=#:G1079 NIL) (|be| NIL) (#6=#:G1078 NIL)
          (|ncb| (|List| (|Vector| F))) (#7=#:G1077 NIL) (#8=#:G1076 NIL)
          (|s2f|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))))
          (|lgj1| (|List| F)) (|ff| (F)) (#9=#:G1075 NIL) (|lgj| (|List| F))
          (#10=#:G1065 NIL) (|gij| (F)) (|last_iter| (|Boolean|))
          (|gi| (|LaurentPolynomial| F (|SparseUnivariatePolynomial| F)))
          (#11=#:G1074 NIL) (|i| NIL) (|f0| (F)) (|d| #4#) (#12=#:G1073 NIL)
          (|cr| NIL) (#13=#:G1072 NIL) (#14=#:G1071 NIL) (#15=#:G1070 NIL)
          (#16=#:G1068 NIL) (#17=#:G1069 NIL) (#18=#:G1067 NIL)
          (#19=#:G1066 NIL)
          (|vg2|
           (|Vector| (|LaurentPolynomial| F (|SparseUnivariatePolynomial| F))))
          (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (LENGTH |lcr|))
              (LETT |vg2| (SPADCALL |lcr| (QREFELT $ 136)))
              (LETT |cb|
                    (PROGN
                     (LETT #19# NIL)
                     (SEQ (LETT |cr| NIL) (LETT #18# |lcr|) G190
                          (COND
                           ((OR (ATOM #18#) (PROGN (LETT |cr| (CAR #18#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #19#
                                  (CONS (MAKEARR1 |n| (|spadConstant| $ 42))
                                        #19#))))
                          (LETT #18# (CDR #18#)) (GO G190) G191
                          (EXIT (NREVERSE #19#)))))
              (SEQ (LETT |bv| NIL) (LETT #17# |cb|) (LETT |i| 1)
                   (LETT #16# |n|) G190
                   (COND
                    ((OR (|greater_SI| |i| #16#) (ATOM #17#)
                         (PROGN (LETT |bv| (CAR #17#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |bv| |i| (|spadConstant| $ 64) (QREFELT $ 97))))
                   (LETT |i| (PROG1 (|inc_SI| |i|) (LETT #17# (CDR #17#))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |lba|
                    (PROGN
                     (LETT #15# NIL)
                     (SEQ (LETT |cr| NIL) (LETT #14# |lcr|) G190
                          (COND
                           ((OR (ATOM #14#) (PROGN (LETT |cr| (CAR #14#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #15# (CONS (|spadConstant| $ 137) #15#))))
                          (LETT #14# (CDR #14#)) (GO G190) G191
                          (EXIT (NREVERSE #15#)))))
              (LETT |d|
                    (SPADCALL (ELT $ 98)
                              (PROGN
                               (LETT #13# NIL)
                               (SEQ (LETT |cr| NIL) (LETT #12# |lcr|) G190
                                    (COND
                                     ((OR (ATOM #12#)
                                          (PROGN (LETT |cr| (CAR #12#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #13#
                                            (CONS
                                             (SPADCALL |cr| (QREFELT $ 138))
                                             #13#))))
                                    (LETT #12# (CDR #12#)) (GO G190) G191
                                    (EXIT (NREVERSE #13#))))
                              (QREFELT $ 127)))
              (LETT |j| |d|) (LETT |f0| (SPADCALL |b| |a| (QREFELT $ 128)))
              (SEQ
               (EXIT
                (SEQ G190 NIL
                     (SEQ (LETT |last_iter| 'T) (LETT |lgj| NIL)
                          (SEQ (LETT |i| 1) (LETT #11# |n|) G190
                               (COND ((|greater_SI| |i| #11#) (GO G191)))
                               (SEQ
                                (LETT |gi|
                                      (SPADCALL |vg2| |i| (QREFELT $ 139)))
                                (LETT |gij| (|spadConstant| $ 42))
                                (COND
                                 ((SPADCALL |gi| (|spadConstant| $ 137)
                                            (QREFELT $ 140))
                                  (SEQ (LETT |last_iter| NIL)
                                       (EXIT
                                        (COND
                                         ((EQL (SPADCALL |gi| (QREFELT $ 138))
                                               |j|)
                                          (SEQ
                                           (LETT |gij|
                                                 (SPADCALL |gi|
                                                           (QREFELT $ 141)))
                                           (EXIT
                                            (SPADCALL |vg2| |i|
                                                      (SPADCALL |gi|
                                                                (QREFELT $
                                                                         142))
                                                      (QREFELT $ 143))))))))))
                                (EXIT (LETT |lgj| (CONS |gij| |lgj|))))
                               (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                               (EXIT NIL))
                          (EXIT
                           (COND
                            (|last_iter|
                             (PROGN (LETT #10# |$NoValue|) (GO #20=#:G1060)))
                            ('T
                             (SEQ (LETT |lgj| (NREVERSE |lgj|))
                                  (LETT |lgj1| NIL)
                                  (SEQ (LETT |bv| NIL) (LETT #9# |cb|) G190
                                       (COND
                                        ((OR (ATOM #9#)
                                             (PROGN (LETT |bv| (CAR #9#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (LETT |ff|
                                              (SPADCALL |bv| |lgj|
                                                        (QREFELT $ 109)))
                                        (EXIT
                                         (LETT |lgj1|
                                               (CONS
                                                (SPADCALL |ff| (QREFELT $ 107))
                                                |lgj1|))))
                                       (LETT #9# (CDR #9#)) (GO G190) G191
                                       (EXIT NIL))
                                  (LETT |lgj1| (NREVERSE |lgj1|))
                                  (LETT |s2f|
                                        (SPADCALL
                                         (SPADCALL |f0|
                                                   (SPADCALL
                                                    (SPADCALL |j|
                                                              (QREFELT $ 44))
                                                    |eta| (QREFELT $ 110))
                                                   (QREFELT $ 111))
                                         |lgj1| |x| |lk| |ext| |logi|
                                         (QREFELT $ 118)))
                                  (LETT |ncb|
                                        (PROGN
                                         (LETT #8# NIL)
                                         (SEQ (LETT |be| NIL) (LETT #7# |s2f|)
                                              G190
                                              (COND
                                               ((OR (ATOM #7#)
                                                    (PROGN
                                                     (LETT |be| (CAR #7#))
                                                     NIL))
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (LETT #8#
                                                      (CONS
                                                       (SPADCALL (QCDR |be|)
                                                                 |cb|
                                                                 (QREFELT $
                                                                          80))
                                                       #8#))))
                                              (LETT #7# (CDR #7#)) (GO G190)
                                              G191 (EXIT (NREVERSE #8#)))))
                                  (LETT |nlba|
                                        (PROGN
                                         (LETT #6# NIL)
                                         (SEQ (LETT |be| NIL) (LETT #5# |s2f|)
                                              G190
                                              (COND
                                               ((OR (ATOM #5#)
                                                    (PROGN
                                                     (LETT |be| (CAR #5#))
                                                     NIL))
                                                (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (LETT #6#
                                                      (CONS
                                                       (SPADCALL
                                                        (SPADCALL (QCDR |be|)
                                                                  |lba|
                                                                  (QREFELT $
                                                                           144))
                                                        (SPADCALL (QCAR |be|)
                                                                  |j|
                                                                  (QREFELT $
                                                                           145))
                                                        (QREFELT $ 146))
                                                       #6#))))
                                              (LETT #5# (CDR #5#)) (GO G190)
                                              G191 (EXIT (NREVERSE #6#)))))
                                  (LETT |cb| |ncb|) (LETT |lba| |nlba|)
                                  (EXIT (LETT |j| (- |j| 1))))))))
                     NIL (GO G190) G191 (EXIT NIL)))
               #20# (EXIT #10#))
              (EXIT
               (PROGN
                (LETT #3# NIL)
                (SEQ (LETT |bv| NIL) (LETT #2# |cb|) (LETT |re| NIL)
                     (LETT #1# |lba|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |re| (CAR #1#)) NIL)
                           (ATOM #2#) (PROGN (LETT |bv| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #3#
                             (CONS (CONS (SPADCALL |re| (QREFELT $ 147)) |bv|)
                                   #3#))))
                     (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                     (GO G190) G191 (EXIT (NREVERSE #3#)))))))) 

(SDEFUN |RDEPAR;exp_lower_bound;SupLp2ILFMI;11|
        ((|a| (|SparseUnivariatePolynomial| F))
         (|b| (|LaurentPolynomial| F (|SparseUnivariatePolynomial| F)))
         (|ob| (|Integer|)) (|nc0| (|Integer|)) (|lk| (|List| (|Kernel| F)))
         (|eta| (F))
         (|logi|
          (|Mapping|
           (|Record| (|:| |logands| (|List| F))
                     (|:| |basis|
                          (|List| (|Vector| (|Fraction| (|Integer|))))))
           (|List| (|Kernel| F)) (|List| F)))
         ($ (|Integer|)))
        (SPROG
         ((|nu| (|Union| (|Integer|) "failed"))
          (|bv| (|Vector| (|Fraction| (|Integer|))))
          (|bl| #1=(|List| (|Vector| (|Fraction| (|Integer|)))))
          (|ll| #2=(|List| F))
          (|#G116| (|Record| (|:| |logands| #2#) (|:| |basis| #1#))) (|c0| (F))
          (|n0| (|Integer|)))
         (SEQ
          (COND ((< |ob| 0) (MIN 0 (- |nc0| |ob|)))
                (#3='T
                 (SEQ (LETT |n0| (MIN 0 |nc0|))
                      (EXIT
                       (COND ((< 0 |ob|) |n0|)
                             (#3#
                              (SEQ
                               (LETT |c0|
                                     (SPADCALL (SPADCALL |b| 0 (QREFELT $ 148))
                                               (SPADCALL |a| 0 (QREFELT $ 149))
                                               (QREFELT $ 128)))
                               (PROGN
                                (LETT |#G116|
                                      (SPADCALL |lk| (LIST |c0| |eta|) |logi|))
                                (LETT |ll| (QCAR |#G116|))
                                (LETT |bl| (QCDR |#G116|))
                                |#G116|)
                               (EXIT
                                (COND ((NULL |bl|) |n0|)
                                      (#3#
                                       (SEQ (LETT |bv| (|SPADfirst| |bl|))
                                            (LETT |nu|
                                                  (SPADCALL
                                                   (SPADCALL
                                                    (SPADCALL |bv| 2
                                                              (QREFELT $ 88))
                                                    (SPADCALL |bv| 1
                                                              (QREFELT $ 88))
                                                    (QREFELT $ 150))
                                                   (QREFELT $ 40)))
                                            (EXIT
                                             (COND ((QEQCAR |nu| 1) |n0|)
                                                   (#3#
                                                    (MIN (QCDR |nu|)
                                                         |n0|)))))))))))))))))) 

(SDEFUN |RDEPAR;exp_upper_bound|
        ((|a| (|SparseUnivariatePolynomial| F))
         (|b| (|SparseUnivariatePolynomial| F)) (|nc1| (|Integer|))
         (|lk| (|List| (|Kernel| F))) (|eta| (F))
         (|logi|
          (|Mapping|
           #1=(|Record| (|:| |logands| #2=(|List| F))
                        (|:| |basis|
                             #3=(|List| (|Vector| (|Fraction| (|Integer|))))))
           (|List| (|Kernel| F)) (|List| F)))
         ($ (|Integer|)))
        (SPROG
         ((|nu| (|Union| (|Integer|) "failed"))
          (|bv| (|Vector| (|Fraction| (|Integer|)))) (|bl| #3#) (|ll| #2#)
          (|#G123| #1#) (|c1| (F)) (|n0| (|Integer|))
          (|db| #4=(|NonNegativeInteger|)) (|da| #4#))
         (SEQ (LETT |da| (SPADCALL |a| (QREFELT $ 67)))
              (LETT |db| (SPADCALL |b| (QREFELT $ 67)))
              (EXIT
               (COND ((< |da| |db|) (- |nc1| |db|))
                     (#5='T
                      (SEQ (LETT |n0| (MAX 0 (- |nc1| |da|)))
                           (EXIT
                            (COND ((< |db| |da|) |n0|)
                                  (#5#
                                   (SEQ
                                    (LETT |c1|
                                          (SPADCALL
                                           (SPADCALL |b| (QREFELT $ 104))
                                           (SPADCALL |a| (QREFELT $ 104))
                                           (QREFELT $ 128)))
                                    (PROGN
                                     (LETT |#G123|
                                           (SPADCALL |lk| (LIST |c1| |eta|)
                                                     |logi|))
                                     (LETT |ll| (QCAR |#G123|))
                                     (LETT |bl| (QCDR |#G123|))
                                     |#G123|)
                                    (EXIT
                                     (COND ((NULL |bl|) |n0|)
                                           (#5#
                                            (SEQ (LETT |bv| (|SPADfirst| |bl|))
                                                 (LETT |nu|
                                                       (SPADCALL
                                                        (SPADCALL
                                                         (SPADCALL |bv| 2
                                                                   (QREFELT $
                                                                            88))
                                                         (SPADCALL |bv| 1
                                                                   (QREFELT $
                                                                            88))
                                                         (QREFELT $ 150))
                                                        (QREFELT $ 40)))
                                                 (EXIT
                                                  (COND ((QEQCAR |nu| 1) |n0|)
                                                        (#5#
                                                         (MAX (QCDR |nu|)
                                                              |n0|))))))))))))))))))) 

(SDEFUN |RDEPAR;do_SPDE_exp|
        ((|a| (|SparseUnivariatePolynomial| F))
         (|bbr| (|Fraction| (|SparseUnivariatePolynomial| F)))
         (|lcr| (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
         (|lk| (|List| (|Kernel| F)))
         (|ext|
          (|Mapping|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
           (|List| (|Kernel| F)) (|List| F)))
         (|logi|
          (|Mapping|
           (|Record| (|:| |logands| (|List| F))
                     (|:| |basis|
                          (|List| (|Vector| (|Fraction| (|Integer|))))))
           (|List| (|Kernel| F)) (|List| F)))
         (|der|
          (|Mapping| (|SparseUnivariatePolynomial| F)
                     (|SparseUnivariatePolynomial| F)))
         (|get_rs| (|Mapping| (|Matrix| F) (|Matrix| F))) (|x| (|Symbol|))
         ($
          (|List|
           (|Record|
            (|:| |ratpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
            (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G1163 NIL) (|re| NIL) (#2=#:G1162 NIL)
          (|tt| (|Fraction| (|SparseUnivariatePolynomial| F))) (#3=#:G1147 NIL)
          (|res1|
           (|List|
            (|Record| (|:| |ratpart| (|SparseUnivariatePolynomial| F))
                      (|:| |coeffs| (|Vector| F)))))
          (|do_degrad|
           (|Mapping|
            (|List|
             (|Record|
              (|:| |ratpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
              (|:| |coeffs| (|Vector| F))))
            (|Fraction| (|SparseUnivariatePolynomial| F))
            (|List| (|Fraction| (|SparseUnivariatePolynomial| F)))))
          (|n1| (|Integer|)) (|nc1| #4=(|Integer|)) (#5=#:G1161 NIL) (|cu| NIL)
          (#6=#:G1160 NIL) (|lcu| (|List| #7=(|SparseUnivariatePolynomial| F)))
          (#8=#:G1159 NIL) (|c| NIL) (#9=#:G1158 NIL)
          (|lc|
           (|List|
            #10=(|LaurentPolynomial| F (|SparseUnivariatePolynomial| F))))
          (#11=#:G1157 NIL) (#12=#:G1156 NIL)
          (|t1| (|LaurentPolynomial| F (|SparseUnivariatePolynomial| F)))
          (#13=#:G1121 NIL) (|m0| (|Integer|)) (|bu| #7#) (|b| #10#)
          (#14=#:G1119 NIL) (|n0| (|Integer|)) (|eta| (F)) (#15=#:G1107 NIL)
          (|nc0| #4#) (#16=#:G1155 NIL) (#17=#:G1154 NIL) (|nb0| (|Integer|))
          (#18=#:G1153 NIL) (|cr| NIL) (#19=#:G1152 NIL))
         (SEQ (LETT |b| (|RDEPAR;RF_to_GP| |bbr| $))
              (LETT |lc|
                    (PROGN
                     (LETT #19# NIL)
                     (SEQ (LETT |cr| NIL) (LETT #18# |lcr|) G190
                          (COND
                           ((OR (ATOM #18#) (PROGN (LETT |cr| (CAR #18#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #19#
                                  (CONS (|RDEPAR;RF_to_GP| |cr| $) #19#))))
                          (LETT #18# (CDR #18#)) (GO G190) G191
                          (EXIT (NREVERSE #19#)))))
              (LETT |nb0| (SPADCALL |b| (QREFELT $ 152)))
              (LETT |nc0|
                    (SPADCALL (ELT $ 153)
                              (PROGN
                               (LETT #17# NIL)
                               (SEQ (LETT |c| NIL) (LETT #16# |lc|) G190
                                    (COND
                                     ((OR (ATOM #16#)
                                          (PROGN (LETT |c| (CAR #16#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #17#
                                            (CONS
                                             (SPADCALL |c| (QREFELT $ 152))
                                             #17#))))
                                    (LETT #16# (CDR #16#)) (GO G190) G191
                                    (EXIT (NREVERSE #17#))))
                              (QREFELT $ 127)))
              (LETT |eta|
                    (SPADCALL
                     (PROG2
                         (LETT #15#
                               (SPADCALL
                                (SPADCALL
                                 (SPADCALL (|spadConstant| $ 64) 1
                                           (QREFELT $ 66))
                                 |der|)
                                (SPADCALL (|spadConstant| $ 64) 1
                                          (QREFELT $ 66))
                                (QREFELT $ 21)))
                         (QCDR #15#)
                       (|check_union2| (QEQCAR #15# 0)
                                       (|SparseUnivariatePolynomial|
                                        (QREFELT $ 7))
                                       (|Union|
                                        (|SparseUnivariatePolynomial|
                                         (QREFELT $ 7))
                                        "failed")
                                       #15#))
                     (QREFELT $ 101)))
              (COND
               ((EQL (SPADCALL |a| (QREFELT $ 67)) 0)
                (COND
                 ((EQL (SPADCALL |b| (QREFELT $ 138)) 0)
                  (COND
                   ((EQL |nb0| 0)
                    (EXIT
                     (|RDEPAR;do_SPDE_exp0| (SPADCALL |a| (QREFELT $ 101))
                      (SPADCALL |b| (QREFELT $ 154)) |lc| |lk| |eta| |ext|
                      |logi| |x| $))))))))
              (LETT |n0|
                    (SPADCALL |a| |b| |nb0| |nc0| |lk| |eta| |logi|
                              (QREFELT $ 151)))
              (COND
               ((< |n0| 0)
                (LETT |b|
                      (SPADCALL |b|
                                (SPADCALL
                                 (SPADCALL
                                  (SPADCALL (SPADCALL |n0| (QREFELT $ 44))
                                            |eta| (QREFELT $ 110))
                                  (QREFELT $ 155))
                                 (SPADCALL |a| (QREFELT $ 46)) (QREFELT $ 156))
                                (QREFELT $ 146)))))
              (COND
               ((< |nb0| 0)
                (SEQ
                 (LETT |t1|
                       (SPADCALL (|spadConstant| $ 64)
                                 (PROG1 (LETT #14# (- |nb0|))
                                   (|check_subtype2| (>= #14# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #14#))
                                 (QREFELT $ 66)))
                 (LETT |b|
                       (SPADCALL (SPADCALL |t1| (QREFELT $ 46)) |b|
                                 (QREFELT $ 156)))
                 (EXIT (LETT |a| (SPADCALL |t1| |a| (QREFELT $ 81)))))))
              (LETT |bu| (SPADCALL |b| (QREFELT $ 157)))
              (LETT |m0| (+ (MIN 0 |n0|) (MIN 0 |nb0|)))
              (COND
               ((< |m0| 0)
                (SEQ
                 (LETT |t1|
                       (SPADCALL (|spadConstant| $ 64)
                                 (PROG1 (LETT #13# (- |m0|))
                                   (|check_subtype2| (>= #13# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #13#))
                                 (QREFELT $ 145)))
                 (EXIT
                  (LETT |lc|
                        (PROGN
                         (LETT #12# NIL)
                         (SEQ (LETT |c| NIL) (LETT #11# |lc|) G190
                              (COND
                               ((OR (ATOM #11#)
                                    (PROGN (LETT |c| (CAR #11#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (LETT #12#
                                      (CONS (SPADCALL |t1| |c| (QREFELT $ 156))
                                            #12#))))
                              (LETT #11# (CDR #11#)) (GO G190) G191
                              (EXIT (NREVERSE #12#)))))))))
              (LETT |lcu|
                    (PROGN
                     (LETT #9# NIL)
                     (SEQ (LETT |c| NIL) (LETT #8# |lc|) G190
                          (COND
                           ((OR (ATOM #8#) (PROGN (LETT |c| (CAR #8#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #9#
                                  (CONS (SPADCALL |c| (QREFELT $ 157)) #9#))))
                          (LETT #8# (CDR #8#)) (GO G190) G191
                          (EXIT (NREVERSE #9#)))))
              (LETT |nc1|
                    (SPADCALL (ELT $ 98)
                              (PROGN
                               (LETT #6# NIL)
                               (SEQ (LETT |cu| NIL) (LETT #5# |lcu|) G190
                                    (COND
                                     ((OR (ATOM #5#)
                                          (PROGN (LETT |cu| (CAR #5#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #6#
                                            (CONS
                                             (SPADCALL |cu| (QREFELT $ 67))
                                             #6#))))
                                    (LETT #5# (CDR #5#)) (GO G190) G191
                                    (EXIT (NREVERSE #6#))))
                              (QREFELT $ 127)))
              (LETT |n1|
                    (|RDEPAR;exp_upper_bound| |a| |bu| |nc1| |lk| |eta| |logi|
                     $))
              (LETT |do_degrad|
                    (CONS #'|RDEPAR;do_SPDE_exp!0|
                          (VECTOR |x| |logi| |ext| |eta| |lk| $)))
              (LETT |res1|
                    (|RDEPAR;param_SPDE| |a| |bu| |lcu| |n1| |der| |get_rs|
                     |do_degrad| |x| $))
              (LETT |tt|
                    (COND
                     ((< |n0| 0)
                      (SPADCALL
                       (SPADCALL (|spadConstant| $ 64)
                                 (PROG1 (LETT #3# (- |n0|))
                                   (|check_subtype2| (>= #3# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #3#))
                                 (QREFELT $ 66))
                       (QREFELT $ 73)))
                     ('T (|spadConstant| $ 158))))
              (EXIT
               (PROGN
                (LETT #2# NIL)
                (SEQ (LETT |re| NIL) (LETT #1# |res1|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |re| (CAR #1#)) NIL))
                       (GO G191)))
                     (SEQ
                      (EXIT
                       (LETT #2#
                             (CONS
                              (CONS
                               (SPADCALL (SPADCALL (QCAR |re|) (QREFELT $ 73))
                                         |tt| (QREFELT $ 159))
                               (QCDR |re|))
                              #2#))))
                     (LETT #1# (CDR #1#)) (GO G190) G191
                     (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |RDEPAR;do_SPDE_exp!0| ((|bb| NIL) (|lc1| NIL) ($$ NIL))
        (PROG ($ |lk| |eta| |ext| |logi| |x|)
          (LETT $ (QREFELT $$ 5))
          (LETT |lk| (QREFELT $$ 4))
          (LETT |eta| (QREFELT $$ 3))
          (LETT |ext| (QREFELT $$ 2))
          (LETT |logi| (QREFELT $$ 1))
          (LETT |x| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((#1=#:G1141 NIL) (|c1| NIL) (#2=#:G1140 NIL))
                   (SEQ
                    (|RDEPAR;do_SPDE_exp0| (|spadConstant| $ 64)
                     (SPADCALL (SPADCALL |bb| (QREFELT $ 22)) (QREFELT $ 101))
                     (PROGN
                      (LETT #2# NIL)
                      (SEQ (LETT |c1| NIL) (LETT #1# |lc1|) G190
                           (COND
                            ((OR (ATOM #1#) (PROGN (LETT |c1| (CAR #1#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #2# (CONS (|RDEPAR;RF_to_GP| |c1| $) #2#))))
                           (LETT #1# (CDR #1#)) (GO G190) G191
                           (EXIT (NREVERSE #2#))))
                     |lk| |eta| |ext| |logi| |x| $))))))) 

(SDEFUN |RDEPAR;param_rde;I2FLSLMMR;14|
        ((|m| (|Integer|)) (|f| (F)) (|g0| (F)) (|lg| (|List| F))
         (|x| (|Symbol|)) (|lk| (|List| (|Kernel| F)))
         (|ext|
          (|Mapping|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
           (|List| (|Kernel| F)) (|List| F)))
         (|logi|
          (|Mapping|
           (|Record| (|:| |logands| (|List| F))
                     (|:| |basis|
                          (|List| (|Vector| (|Fraction| (|Integer|))))))
           (|List| (|Kernel| F)) (|List| F)))
         ($
          (|Record|
           (|:| |particular|
                (|Union|
                 (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))
                 "failed"))
           (|:| |basis|
                (|List|
                 (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))))
        (SPROG
         ((|res1|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))))
          (|lg1| (|List| F)))
         (SEQ (LETT |lg1| (CONS (SPADCALL |g0| (QREFELT $ 107)) |lg|))
              (LETT |res1|
                    (SPADCALL |m| |f| |lg1| |x| |lk| |ext| |logi|
                              (QREFELT $ 160)))
              (EXIT (SPADCALL |res1| (QREFELT $ 132)))))) 

(SDEFUN |RDEPAR;param_rde2;FLSLMML;15|
        ((|fp| (F)) (|lg| (|List| F)) (|x| (|Symbol|))
         (|lk| (|List| (|Kernel| F)))
         (|ext|
          (|Mapping|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
           (|List| (|Kernel| F)) (|List| F)))
         (|logi|
          (|Mapping|
           (|Record| (|:| |logands| (|List| F))
                     (|:| |basis|
                          (|List| (|Vector| (|Fraction| (|Integer|))))))
           (|List| (|Kernel| F)) (|List| F)))
         ($ (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G1234 NIL) (|rs| NIL) (#2=#:G1233 NIL)
          (|res1|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))))
          (|lg1| (|List| F)) (#3=#:G1232 NIL) (|g| NIL) (#4=#:G1231 NIL)
          (|pf| (F)) (|p| (|SparseUnivariatePolynomial| F)) (#5=#:G1212 NIL)
          (|fpu| #6=(|Fraction| (|SparseUnivariatePolynomial| F)))
          (|ni| (|Integer|)) (|pii| (|SparseUnivariatePolynomial| F))
          (|#G156|
           #7=(|Record| (|:| |fctr| (|SparseUnivariatePolynomial| F))
                        (|:| |xpnt| (|Integer|))))
          (#8=#:G1230 NIL) (|re| NIL) (|rl| (|List| #7#))
          (|der1|
           (|Mapping| (|SparseUnivariatePolynomial| F)
                      (|SparseUnivariatePolynomial| F)))
          (|dk| (|SparseUnivariatePolynomial| F)) (|dku| #6#) (#9=#:G1229 NIL)
          (|k1| NIL) (#10=#:G1228 NIL) (|k| (|Kernel| F)))
         (SEQ (LETT |k| (SPADCALL |lk| (QREFELT $ 163)))
              (LETT |lk|
                    (PROGN
                     (LETT #10# NIL)
                     (SEQ (LETT |k1| NIL) (LETT #9# |lk|) G190
                          (COND
                           ((OR (ATOM #9#) (PROGN (LETT |k1| (CAR #9#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (COND
                             ((SPADCALL |k1| |k| (QREFELT $ 164))
                              (LETT #10# (CONS |k1| #10#))))))
                          (LETT #9# (CDR #9#)) (GO G190) G191
                          (EXIT (NREVERSE #10#)))))
              (EXIT
               (COND
                ((SPADCALL (SPADCALL |k| (QREFELT $ 166)) '|%alg|
                           (QREFELT $ 167))
                 (|RDEPAR;do_alg_rde| |fp| |lg| |x| |k| |lk| |ext| |logi| $))
                ((SPADCALL |k| '|%diff| (QREFELT $ 168))
                 (|RDEPAR;do_diff_rde| |fp| |lg| |x| |k| |lk| |ext| |logi| $))
                (#11='T
                 (SEQ
                  (LETT |dku|
                        (SPADCALL
                         (SPADCALL (SPADCALL |k| (QREFELT $ 31)) |x|
                                   (QREFELT $ 169))
                         |k| (QREFELT $ 125)))
                  (EXIT
                   (COND
                    ((SPADCALL (SPADCALL |dku| (QREFELT $ 13))
                               (|spadConstant| $ 68) (QREFELT $ 70))
                     NIL)
                    (#11#
                     (SEQ (LETT |dk| (SPADCALL |dku| (QREFELT $ 22)))
                          (LETT |fpu| (SPADCALL |fp| |k| (QREFELT $ 125)))
                          (LETT |der1|
                                (CONS #'|RDEPAR;param_rde2;FLSLMML;15!1|
                                      (VECTOR |dk| |x| $)))
                          (LETT |rl| (|RDEPAR;normalize| |fpu| |der1| $))
                          (LETT |p| (|spadConstant| $ 68))
                          (SEQ (LETT |re| NIL) (LETT #8# |rl|) G190
                               (COND
                                ((OR (ATOM #8#)
                                     (PROGN (LETT |re| (CAR #8#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (PROGN
                                 (LETT |#G156| |re|)
                                 (LETT |pii| (QCAR |#G156|))
                                 (LETT |ni| (QCDR |#G156|))
                                 |#G156|)
                                (LETT |fpu|
                                      (SPADCALL |fpu|
                                                (SPADCALL
                                                 (SPADCALL
                                                  (SPADCALL |ni|
                                                            (QREFELT $ 44))
                                                  (SPADCALL |pii| |der1|)
                                                  (QREFELT $ 32))
                                                 |pii| (QREFELT $ 172))
                                                (QREFELT $ 173)))
                                (EXIT
                                 (LETT |p|
                                       (SPADCALL
                                        (SPADCALL |pii|
                                                  (PROG1 (LETT #5# |ni|)
                                                    (|check_subtype2|
                                                     (>= #5# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #5#))
                                                  (QREFELT $ 174))
                                        |p| (QREFELT $ 81)))))
                               (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
                          (LETT |fp| (SPADCALL |fpu| |k| (QREFELT $ 123)))
                          (LETT |pf|
                                (SPADCALL (SPADCALL |p| (QREFELT $ 73)) |k|
                                          (QREFELT $ 123)))
                          (LETT |lg1|
                                (PROGN
                                 (LETT #4# NIL)
                                 (SEQ (LETT |g| NIL) (LETT #3# |lg|) G190
                                      (COND
                                       ((OR (ATOM #3#)
                                            (PROGN (LETT |g| (CAR #3#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (LETT #4#
                                              (CONS
                                               (SPADCALL |pf| |g|
                                                         (QREFELT $ 110))
                                               #4#))))
                                      (LETT #3# (CDR #3#)) (GO G190) G191
                                      (EXIT (NREVERSE #4#)))))
                          (LETT |res1|
                                (|RDEPAR;do_param_rde| |fp| NIL |lg1| |x| |k|
                                 |lk| |ext| |logi| $))
                          (EXIT
                           (PROGN
                            (LETT #2# NIL)
                            (SEQ (LETT |rs| NIL) (LETT #1# |res1|) G190
                                 (COND
                                  ((OR (ATOM #1#)
                                       (PROGN (LETT |rs| (CAR #1#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (LETT #2#
                                         (CONS
                                          (CONS
                                           (SPADCALL (QCAR |rs|) |pf|
                                                     (QREFELT $ 128))
                                           (QCDR |rs|))
                                          #2#))))
                                 (LETT #1# (CDR #1#)) (GO G190) G191
                                 (EXIT (NREVERSE #2#)))))))))))))))) 

(SDEFUN |RDEPAR;param_rde2;FLSLMML;15!1| ((|z1| NIL) ($$ NIL))
        (PROG ($ |x| |dk|)
          (LETT $ (QREFELT $$ 2))
          (LETT |x| (QREFELT $$ 1))
          (LETT |dk| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL |z1|
                             (CONS #'|RDEPAR;param_rde2;FLSLMML;15!0|
                                   (VECTOR $ |x|))
                             |dk| (QREFELT $ 171))))))) 

(SDEFUN |RDEPAR;param_rde2;FLSLMML;15!0| ((|z2| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z2| |x| (QREFELT $ 169)))))) 

(SDEFUN |RDEPAR;csolve1|
        ((|m| (|Matrix| F)) (|d1| (|Mapping| F F)) ($ (|List| (|Vector| F))))
        (SPADCALL |m| (LIST |d1|) (QREFELT $ 177))) 

(SDEFUN |RDEPAR;do_diff_rde1|
        ((|lg| (|List| (|SparseUnivariatePolynomial| F))) (|fp0| (F))
         (|fp1| (F)) (|x| (|Symbol|)) (|k| (|Kernel| F))
         (|lk| (|List| (|Kernel| F)))
         (|ext|
          (|Mapping|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
           (|List| (|Kernel| F)) (|List| F)))
         (|logi|
          (|Mapping|
           (|Record| (|:| |logands| (|List| F))
                     (|:| |basis|
                          (|List| (|Vector| (|Fraction| (|Integer|))))))
           (|List| (|Kernel| F)) (|List| F)))
         ($ (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G1345 NIL) (|ba| NIL) (#2=#:G1346 NIL) (|bv| NIL)
          (#3=#:G1344 NIL) (|nlca| (|List| F)) (#4=#:G1342 NIL)
          (#5=#:G1343 NIL) (|ca| NIL) (#6=#:G1341 NIL)
          (|ncb| (|List| (|Vector| F))) (#7=#:G1340 NIL) (#8=#:G1339 NIL)
          (|elca| (|List| F)) (#9=#:G1338 NIL) (|be| NIL) (#10=#:G1337 NIL)
          (|cb1| (|List| (|Vector| F))) (#11=#:G1336 NIL) (#12=#:G1335 NIL)
          (|res2|
           #13=(|List|
                (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))))
          (|kk3| #14=(|Kernel| F)) (#15=#:G1334 NIL) (#16=#:G1333 NIL)
          (|m3| (|Matrix| F)) (|nlg| (|List| F)) (|ng| (F)) (#17=#:G1311 NIL)
          (|nu| (|SparseUnivariatePolynomial| F))
          (|du| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (#18=#:G1330 NIL) (#19=#:G1331 NIL) (|g1| NIL) (#20=#:G1332 NIL)
          (|g0| NIL) (|lca| (|List| F)) (|nlg0| (|List| F)) (#21=#:G1329 NIL)
          (#22=#:G1328 NIL) (|lg3| (|List| F)) (#23=#:G1327 NIL)
          (#24=#:G1326 NIL) (|v3| (|Vector| F)) (|v2| (|Vector| F))
          (#25=#:G1325 NIL) (#26=#:G1324 NIL) (|cb| #27=(|List| (|Vector| F)))
          (|m2| #28=(|Matrix| F))
          (|#G175| (|Record| (|:| |transform| #28#) (|:| |basis| #27#)))
          (|d1| (|Mapping| F F)) (|cb0| (|List| (|Vector| F)))
          (#29=#:G1323 NIL) (#30=#:G1322 NIL) (|res1| #13#)
          (|lk2| (|List| #31=(|Kernel| F))) (#32=#:G1321 NIL) (|ki| NIL)
          (#33=#:G1320 NIL) (|kk1| #14#)
          (|logi1|
           (|Mapping|
            (|Record| (|:| |logands| (|List| F))
                      (|:| |basis|
                           (|List| (|Vector| (|Fraction| (|Integer|))))))
            (|List| (|Kernel| F)) (|List| F)))
          (|ext1|
           (|Mapping|
            (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
            (|List| (|Kernel| F)) (|List| F)))
          (|lk1| (|List| #31#)) (|lek| (|List| F)) (#34=#:G1319 NIL)
          (#35=#:G1318 NIL) (|fp2| (F)) (|lg2| (|List| F)) (#36=#:G1317 NIL)
          (|g| NIL) (#37=#:G1316 NIL) (|dvf| (F)) (|dv| (|Symbol|)) (|k1| (F))
          (|lg1| (|List| F)) (#38=#:G1315 NIL) (|up| NIL) (#39=#:G1314 NIL)
          (|lg0| (|List| F)) (#40=#:G1313 NIL) (#41=#:G1312 NIL) (|da3| (F))
          (|arg3| (F)) (|args| (|List| F)))
         (SEQ
          (EXIT
           (SEQ (LETT |args| (SPADCALL |k| (QREFELT $ 178)))
                (EXIT
                 (COND
                  ((SPADCALL (LENGTH |args|) 3 (QREFELT $ 87))
                   (|error| "internal error, k is not a diff"))
                  (#42='T
                   (SEQ (LETT |arg3| (SPADCALL |args| 3 (QREFELT $ 179)))
                        (LETT |da3| (SPADCALL |arg3| |x| (QREFELT $ 169)))
                        (EXIT
                         (COND
                          ((SPADCALL |da3| (|spadConstant| $ 42)
                                     (QREFELT $ 126))
                           NIL)
                          (#42#
                           (SEQ
                            (LETT |lg0|
                                  (PROGN
                                   (LETT #41# NIL)
                                   (SEQ (LETT |up| NIL) (LETT #40# |lg|) G190
                                        (COND
                                         ((OR (ATOM #40#)
                                              (PROGN
                                               (LETT |up| (CAR #40#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #41#
                                                (CONS
                                                 (SPADCALL |up| 0
                                                           (QREFELT $ 149))
                                                 #41#))))
                                        (LETT #40# (CDR #40#)) (GO G190) G191
                                        (EXIT (NREVERSE #41#)))))
                            (LETT |lg1|
                                  (PROGN
                                   (LETT #39# NIL)
                                   (SEQ (LETT |up| NIL) (LETT #38# |lg|) G190
                                        (COND
                                         ((OR (ATOM #38#)
                                              (PROGN
                                               (LETT |up| (CAR #38#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #39#
                                                (CONS
                                                 (SPADCALL |up| 1
                                                           (QREFELT $ 149))
                                                 #39#))))
                                        (LETT #38# (CDR #38#)) (GO G190) G191
                                        (EXIT (NREVERSE #39#)))))
                            (LETT |k1|
                                  (SPADCALL (SPADCALL |args| 1 (QREFELT $ 179))
                                            (SPADCALL
                                             (SPADCALL |args| 2
                                                       (QREFELT $ 179))
                                             (QREFELT $ 180))
                                            |arg3| (QREFELT $ 181)))
                            (LETT |dv| (SPADCALL (QREFELT $ 27)))
                            (LETT |dvf| (SPADCALL |dv| (QREFELT $ 182)))
                            (LETT |lg2|
                                  (PROGN
                                   (LETT #37# NIL)
                                   (SEQ (LETT |g| NIL) (LETT #36# |lg1|) G190
                                        (COND
                                         ((OR (ATOM #36#)
                                              (PROGN
                                               (LETT |g| (CAR #36#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #37#
                                                (CONS
                                                 (SPADCALL
                                                  (SPADCALL |g| |da3|
                                                            (QREFELT $ 128))
                                                  |k1| |dvf| (QREFELT $ 183))
                                                 #37#))))
                                        (LETT #36# (CDR #36#)) (GO G190) G191
                                        (EXIT (NREVERSE #37#)))))
                            (LETT |fp2|
                                  (SPADCALL
                                   (SPADCALL |fp1| |da3| (QREFELT $ 128)) |k1|
                                   |dvf| (QREFELT $ 183)))
                            (LETT |lek|
                                  (PROGN
                                   (LETT #35# NIL)
                                   (SEQ (LETT |ki| NIL) (LETT #34# |lk|) G190
                                        (COND
                                         ((OR (ATOM #34#)
                                              (PROGN
                                               (LETT |ki| (CAR #34#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (LETT #35#
                                                (CONS
                                                 (SPADCALL
                                                  (SPADCALL |ki|
                                                            (QREFELT $ 31))
                                                  |k1| |dvf| (QREFELT $ 183))
                                                 #35#))))
                                        (LETT #34# (CDR #34#)) (GO G190) G191
                                        (EXIT (NREVERSE #35#)))))
                            (LETT |lk1|
                                  (SPADCALL
                                   (SPADCALL
                                    (CONS |dvf|
                                          (SPADCALL |lg2| |lek|
                                                    (QREFELT $ 184)))
                                    (QREFELT $ 186))
                                   |dv| (QREFELT $ 187)))
                            (LETT |ext1|
                                  (CONS #'|RDEPAR;do_diff_rde1!0|
                                        (VECTOR $ |dv|)))
                            (LETT |logi1|
                                  (CONS #'|RDEPAR;do_diff_rde1!1|
                                        (VECTOR $ |dv|)))
                            (LETT |kk1| (SPADCALL |lk1| (QREFELT $ 163)))
                            (LETT |lk2|
                                  (PROGN
                                   (LETT #33# NIL)
                                   (SEQ (LETT |ki| NIL) (LETT #32# |lk1|) G190
                                        (COND
                                         ((OR (ATOM #32#)
                                              (PROGN
                                               (LETT |ki| (CAR #32#))
                                               NIL))
                                          (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (COND
                                           ((SPADCALL |ki| |kk1|
                                                      (QREFELT $ 164))
                                            (LETT #33# (CONS |ki| #33#))))))
                                        (LETT #32# (CDR #32#)) (GO G190) G191
                                        (EXIT (NREVERSE #33#)))))
                            (LETT |res1|
                                  (COND
                                   ((SPADCALL |fp2| (|spadConstant| $ 42)
                                              (QREFELT $ 126))
                                    (SPADCALL |lk1| |lg2| |ext1|))
                                   (#42#
                                    (|RDEPAR;do_param_rde| |fp2| 'T |lg2| |dv|
                                     |kk1| |lk2| |ext1| |logi1| $))))
                            (EXIT
                             (COND ((NULL |res1|) NIL)
                                   (#42#
                                    (SEQ
                                     (LETT |cb0|
                                           (PROGN
                                            (LETT #30# NIL)
                                            (SEQ (LETT |be| NIL)
                                                 (LETT #29# |res1|) G190
                                                 (COND
                                                  ((OR (ATOM #29#)
                                                       (PROGN
                                                        (LETT |be| (CAR #29#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT #30#
                                                         (CONS (QCDR |be|)
                                                               #30#))))
                                                 (LETT #29# (CDR #29#))
                                                 (GO G190) G191
                                                 (EXIT (NREVERSE #30#)))))
                                     (LETT |d1|
                                           (CONS #'|RDEPAR;do_diff_rde1!2|
                                                 (VECTOR $ |x|)))
                                     (PROGN
                                      (LETT |#G175|
                                            (SPADCALL |cb0| (LIST |d1|)
                                                      (QREFELT $ 192)))
                                      (LETT |m2| (QCAR |#G175|))
                                      (LETT |cb| (QCDR |#G175|))
                                      |#G175|)
                                     (EXIT
                                      (COND ((NULL |cb|) NIL)
                                            (#42#
                                             (SEQ
                                              (LETT |v2|
                                                    (SPADCALL
                                                     (PROGN
                                                      (LETT #26# NIL)
                                                      (SEQ (LETT |be| NIL)
                                                           (LETT #25# |res1|)
                                                           G190
                                                           (COND
                                                            ((OR (ATOM #25#)
                                                                 (PROGN
                                                                  (LETT |be|
                                                                        (CAR
                                                                         #25#))
                                                                  NIL))
                                                             (GO G191)))
                                                           (SEQ
                                                            (EXIT
                                                             (LETT #26#
                                                                   (CONS
                                                                    (QCAR |be|)
                                                                    #26#))))
                                                           (LETT #25#
                                                                 (CDR #25#))
                                                           (GO G190) G191
                                                           (EXIT
                                                            (NREVERSE #26#))))
                                                     (QREFELT $ 193)))
                                              (LETT |v3|
                                                    (SPADCALL |m2| |v2|
                                                              (QREFELT $ 194)))
                                              (LETT |lca|
                                                    (SPADCALL |v3|
                                                              (QREFELT $ 195)))
                                              (LETT |lg3|
                                                    (PROGN
                                                     (LETT #24# NIL)
                                                     (SEQ (LETT |bv| NIL)
                                                          (LETT #23# |cb|) G190
                                                          (COND
                                                           ((OR (ATOM #23#)
                                                                (PROGN
                                                                 (LETT |bv|
                                                                       (CAR
                                                                        #23#))
                                                                 NIL))
                                                            (GO G191)))
                                                          (SEQ
                                                           (EXIT
                                                            (LETT #24#
                                                                  (CONS
                                                                   (SPADCALL
                                                                    |bv| |lg1|
                                                                    (QREFELT $
                                                                             109))
                                                                   #24#))))
                                                          (LETT #23#
                                                                (CDR #23#))
                                                          (GO G190) G191
                                                          (EXIT
                                                           (NREVERSE #24#)))))
                                              (LETT |nlg0|
                                                    (PROGN
                                                     (LETT #22# NIL)
                                                     (SEQ (LETT |bv| NIL)
                                                          (LETT #21# |cb|) G190
                                                          (COND
                                                           ((OR (ATOM #21#)
                                                                (PROGN
                                                                 (LETT |bv|
                                                                       (CAR
                                                                        #21#))
                                                                 NIL))
                                                            (GO G191)))
                                                          (SEQ
                                                           (EXIT
                                                            (LETT #22#
                                                                  (CONS
                                                                   (SPADCALL
                                                                    |bv| |lg0|
                                                                    (QREFELT $
                                                                             109))
                                                                   #22#))))
                                                          (LETT #21#
                                                                (CDR #21#))
                                                          (GO G190) G191
                                                          (EXIT
                                                           (NREVERSE #22#)))))
                                              (LETT |lca|
                                                    (SPADCALL
                                                     (CONS
                                                      #'|RDEPAR;do_diff_rde1!3|
                                                      (VECTOR |k1| $ |dv|))
                                                     |lca| (QREFELT $ 196)))
                                              (LETT |nlg| NIL)
                                              (SEQ (LETT |g0| NIL)
                                                   (LETT #20# |nlg0|)
                                                   (LETT |g1| NIL)
                                                   (LETT #19# |lg3|)
                                                   (LETT |ca| NIL)
                                                   (LETT #18# |lca|) G190
                                                   (COND
                                                    ((OR (ATOM #18#)
                                                         (PROGN
                                                          (LETT |ca|
                                                                (CAR #18#))
                                                          NIL)
                                                         (ATOM #19#)
                                                         (PROGN
                                                          (LETT |g1|
                                                                (CAR #19#))
                                                          NIL)
                                                         (ATOM #20#)
                                                         (PROGN
                                                          (LETT |g0|
                                                                (CAR #20#))
                                                          NIL))
                                                     (GO G191)))
                                                   (SEQ
                                                    (LETT |du|
                                                          (SPADCALL
                                                           (SPADCALL |ca| |x|
                                                                     (QREFELT $
                                                                              169))
                                                           |k|
                                                           (QREFELT $ 125)))
                                                    (LETT |nu|
                                                          (SPADCALL |du|
                                                                    (QREFELT $
                                                                             22)))
                                                    (COND
                                                     ((OR
                                                       (SPADCALL
                                                        (SPADCALL |du|
                                                                  (QREFELT $
                                                                           13))
                                                        (|spadConstant| $ 68)
                                                        (QREFELT $ 70))
                                                       (>
                                                        (SPADCALL |nu|
                                                                  (QREFELT $
                                                                           67))
                                                        1))
                                                      (EXIT
                                                       (PROGN
                                                        (LETT #17# NIL)
                                                        (GO #43=#:G1310)))))
                                                    (EXIT
                                                     (COND
                                                      ((SPADCALL
                                                        (SPADCALL
                                                         (SPADCALL |g1|
                                                                   (SPADCALL
                                                                    |fp1| |ca|
                                                                    (QREFELT $
                                                                             110))
                                                                   (QREFELT $
                                                                            111))
                                                         (SPADCALL |nu| 1
                                                                   (QREFELT $
                                                                            149))
                                                         (QREFELT $ 111))
                                                        (|spadConstant| $ 42)
                                                        (QREFELT $ 197))
                                                       (PROGN
                                                        (LETT #17# NIL)
                                                        (GO #43#)))
                                                      ('T
                                                       (SEQ
                                                        (LETT |ng|
                                                              (SPADCALL
                                                               (SPADCALL |g0|
                                                                         (SPADCALL
                                                                          |fp0|
                                                                          |ca|
                                                                          (QREFELT
                                                                           $
                                                                           110))
                                                                         (QREFELT
                                                                          $
                                                                          111))
                                                               (SPADCALL |nu| 0
                                                                         (QREFELT
                                                                          $
                                                                          149))
                                                               (QREFELT $
                                                                        111)))
                                                        (EXIT
                                                         (LETT |nlg|
                                                               (CONS |ng|
                                                                     |nlg|))))))))
                                                   (LETT #18#
                                                         (PROG1 (CDR #18#)
                                                           (LETT #19#
                                                                 (PROG1
                                                                     (CDR #19#)
                                                                   (LETT #20#
                                                                         (CDR
                                                                          #20#))))))
                                                   (GO G190) G191 (EXIT NIL))
                                              (LETT |nlg| (NREVERSE |nlg|))
                                              (COND
                                               ((SPADCALL |fp1|
                                                          (|spadConstant| $ 42)
                                                          (QREFELT $ 197))
                                                (SEQ
                                                 (LETT |m3|
                                                       (SPADCALL (LIST |nlg|)
                                                                 (QREFELT $
                                                                          199)))
                                                 (LETT |cb1|
                                                       (|RDEPAR;csolve1| |m3|
                                                        |d1| $))
                                                 (EXIT
                                                  (LETT |elca|
                                                        (PROGN
                                                         (LETT #16# NIL)
                                                         (SEQ (LETT |bv| NIL)
                                                              (LETT #15# |cb1|)
                                                              G190
                                                              (COND
                                                               ((OR (ATOM #15#)
                                                                    (PROGN
                                                                     (LETT |bv|
                                                                           (CAR
                                                                            #15#))
                                                                     NIL))
                                                                (GO G191)))
                                                              (SEQ
                                                               (EXIT
                                                                (LETT #16#
                                                                      (CONS
                                                                       (|spadConstant|
                                                                        $ 42)
                                                                       #16#))))
                                                              (LETT #15#
                                                                    (CDR #15#))
                                                              (GO G190) G191
                                                              (EXIT
                                                               (NREVERSE
                                                                #16#))))))))
                                               (#42#
                                                (SEQ
                                                 (LETT |kk3|
                                                       (SPADCALL |lk|
                                                                 (QREFELT $
                                                                          163)))
                                                 (LETT |res2|
                                                       (|RDEPAR;do_param_rde|
                                                        |fp0| 'T |nlg| |x|
                                                        |kk3| |lk1| |ext|
                                                        |logi| $))
                                                 (LETT |cb1|
                                                       (PROGN
                                                        (LETT #12# NIL)
                                                        (SEQ (LETT |be| NIL)
                                                             (LETT #11# |res2|)
                                                             G190
                                                             (COND
                                                              ((OR (ATOM #11#)
                                                                   (PROGN
                                                                    (LETT |be|
                                                                          (CAR
                                                                           #11#))
                                                                    NIL))
                                                               (GO G191)))
                                                             (SEQ
                                                              (EXIT
                                                               (LETT #12#
                                                                     (CONS
                                                                      (QCDR
                                                                       |be|)
                                                                      #12#))))
                                                             (LETT #11#
                                                                   (CDR #11#))
                                                             (GO G190) G191
                                                             (EXIT
                                                              (NREVERSE
                                                               #12#)))))
                                                 (EXIT
                                                  (LETT |elca|
                                                        (PROGN
                                                         (LETT #10# NIL)
                                                         (SEQ (LETT |be| NIL)
                                                              (LETT #9# |res2|)
                                                              G190
                                                              (COND
                                                               ((OR (ATOM #9#)
                                                                    (PROGN
                                                                     (LETT |be|
                                                                           (CAR
                                                                            #9#))
                                                                     NIL))
                                                                (GO G191)))
                                                              (SEQ
                                                               (EXIT
                                                                (LETT #10#
                                                                      (CONS
                                                                       (QCAR
                                                                        |be|)
                                                                       #10#))))
                                                              (LETT #9#
                                                                    (CDR #9#))
                                                              (GO G190) G191
                                                              (EXIT
                                                               (NREVERSE
                                                                #10#)))))))))
                                              (LETT |ncb|
                                                    (PROGN
                                                     (LETT #8# NIL)
                                                     (SEQ (LETT |bv| NIL)
                                                          (LETT #7# |cb1|) G190
                                                          (COND
                                                           ((OR (ATOM #7#)
                                                                (PROGN
                                                                 (LETT |bv|
                                                                       (CAR
                                                                        #7#))
                                                                 NIL))
                                                            (GO G191)))
                                                          (SEQ
                                                           (EXIT
                                                            (LETT #8#
                                                                  (CONS
                                                                   (SPADCALL
                                                                    |bv| |cb|
                                                                    (QREFELT $
                                                                             80))
                                                                   #8#))))
                                                          (LETT #7# (CDR #7#))
                                                          (GO G190) G191
                                                          (EXIT
                                                           (NREVERSE #8#)))))
                                              (LETT |nlca|
                                                    (PROGN
                                                     (LETT #6# NIL)
                                                     (SEQ (LETT |ca| NIL)
                                                          (LETT #5# |elca|)
                                                          (LETT |bv| NIL)
                                                          (LETT #4# |cb1|) G190
                                                          (COND
                                                           ((OR (ATOM #4#)
                                                                (PROGN
                                                                 (LETT |bv|
                                                                       (CAR
                                                                        #4#))
                                                                 NIL)
                                                                (ATOM #5#)
                                                                (PROGN
                                                                 (LETT |ca|
                                                                       (CAR
                                                                        #5#))
                                                                 NIL))
                                                            (GO G191)))
                                                          (SEQ
                                                           (EXIT
                                                            (LETT #6#
                                                                  (CONS
                                                                   (SPADCALL
                                                                    |ca|
                                                                    (SPADCALL
                                                                     |bv| |lca|
                                                                     (QREFELT $
                                                                              109))
                                                                    (QREFELT $
                                                                             111))
                                                                   #6#))))
                                                          (LETT #4#
                                                                (PROG1
                                                                    (CDR #4#)
                                                                  (LETT #5#
                                                                        (CDR
                                                                         #5#))))
                                                          (GO G190) G191
                                                          (EXIT
                                                           (NREVERSE #6#)))))
                                              (EXIT
                                               (PROGN
                                                (LETT #3# NIL)
                                                (SEQ (LETT |bv| NIL)
                                                     (LETT #2# |ncb|)
                                                     (LETT |ba| NIL)
                                                     (LETT #1# |nlca|) G190
                                                     (COND
                                                      ((OR (ATOM #1#)
                                                           (PROGN
                                                            (LETT |ba|
                                                                  (CAR #1#))
                                                            NIL)
                                                           (ATOM #2#)
                                                           (PROGN
                                                            (LETT |bv|
                                                                  (CAR #2#))
                                                            NIL))
                                                       (GO G191)))
                                                     (SEQ
                                                      (EXIT
                                                       (LETT #3#
                                                             (CONS
                                                              (CONS |ba| |bv|)
                                                              #3#))))
                                                     (LETT #1#
                                                           (PROG1 (CDR #1#)
                                                             (LETT #2#
                                                                   (CDR #2#))))
                                                     (GO G190) G191
                                                     (EXIT
                                                      (NREVERSE
                                                       #3#)))))))))))))))))))))))
          #43# (EXIT #17#)))) 

(SDEFUN |RDEPAR;do_diff_rde1!3| ((|x1| NIL) ($$ NIL))
        (PROG (|dv| $ |k1|)
          (LETT |dv| (QREFELT $$ 2))
          (LETT $ (QREFELT $$ 1))
          (LETT |k1| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPADCALL |x1| (SPADCALL |dv| (QREFELT $ 29)) |k1|
                      (QREFELT $ 181)))))) 

(SDEFUN |RDEPAR;do_diff_rde1!2| ((|x1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |x| (QREFELT $ 169)))))) 

(SDEFUN |RDEPAR;do_diff_rde1!1| ((|x2| NIL) (|x3| NIL) ($$ NIL))
        (PROG (|dv| $)
          (LETT |dv| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |dv| |x2| |x3| (QREFELT $ 190)))))) 

(SDEFUN |RDEPAR;do_diff_rde1!0| ((|x4| NIL) (|x3| NIL) ($$ NIL))
        (PROG (|dv| $)
          (LETT |dv| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |dv| |x4| |x3| (QREFELT $ 189)))))) 

(SDEFUN |RDEPAR;do_diff_rde|
        ((|fp| (F)) (|lg| (|List| F)) (|x| (|Symbol|)) (|k| (|Kernel| F))
         (|lk| (|List| (|Kernel| F)))
         (|ext|
          (|Mapping|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
           (|List| (|Kernel| F)) (|List| F)))
         (|logi|
          (|Mapping|
           (|Record| (|:| |logands| (|List| F))
                     (|:| |basis|
                          (|List| (|Vector| (|Fraction| (|Integer|))))))
           (|List| (|Kernel| F)) (|List| F)))
         ($ (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G1365 NIL) (|u| NIL) (#2=#:G1364 NIL)
          (|diff_rde1|
           (|Mapping|
            (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
            (|List| (|SparseUnivariatePolynomial| F))))
          (|cs1| (|Mapping| (|List| (|Vector| F)) (|Matrix| F)))
          (|d1| (|Mapping| F F)) (|fp0| (F)) (|fp1| (F))
          (|nfpu| (|SparseUnivariatePolynomial| F))
          (|fpu| (|Fraction| (|SparseUnivariatePolynomial| F))))
         (SEQ (LETT |fpu| (SPADCALL |fp| |k| (QREFELT $ 125)))
              (COND
               ((OR
                 (SPADCALL (SPADCALL |fpu| (QREFELT $ 13))
                           (|spadConstant| $ 68) (QREFELT $ 70))
                 (>
                  (SPADCALL (LETT |nfpu| (SPADCALL |fpu| (QREFELT $ 22)))
                            (QREFELT $ 67))
                  1))
                (EXIT NIL)))
              (LETT |fp1| (SPADCALL |nfpu| 1 (QREFELT $ 149)))
              (LETT |fp0| (SPADCALL |nfpu| 0 (QREFELT $ 149)))
              (LETT |d1| (CONS #'|RDEPAR;do_diff_rde!0| (VECTOR $ |x|)))
              (LETT |cs1| (CONS #'|RDEPAR;do_diff_rde!1| (VECTOR $ |d1|)))
              (LETT |diff_rde1|
                    (CONS #'|RDEPAR;do_diff_rde!2|
                          (VECTOR $ |logi| |ext| |lk| |k| |x| |fp1| |fp0|)))
              (EXIT
               (SPADCALL |diff_rde1| |cs1|
                         (PROGN
                          (LETT #2# NIL)
                          (SEQ (LETT |u| NIL) (LETT #1# |lg|) G190
                               (COND
                                ((OR (ATOM #1#)
                                     (PROGN (LETT |u| (CAR #1#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #2#
                                       (CONS (SPADCALL |u| |k| (QREFELT $ 125))
                                             #2#))))
                               (LETT #1# (CDR #1#)) (GO G190) G191
                               (EXIT (NREVERSE #2#))))
                         (QREFELT $ 203)))))) 

(SDEFUN |RDEPAR;do_diff_rde!2| ((|x1| NIL) ($$ NIL))
        (PROG (|fp0| |fp1| |x| |k| |lk| |ext| |logi| $)
          (LETT |fp0| (QREFELT $$ 7))
          (LETT |fp1| (QREFELT $$ 6))
          (LETT |x| (QREFELT $$ 5))
          (LETT |k| (QREFELT $$ 4))
          (LETT |lk| (QREFELT $$ 3))
          (LETT |ext| (QREFELT $$ 2))
          (LETT |logi| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN
           (PROGN
            (|RDEPAR;do_diff_rde1| |x1| |fp0| |fp1| |x| |k| |lk| |ext| |logi|
             $))))) 

(SDEFUN |RDEPAR;do_diff_rde!1| ((|x4| NIL) ($$ NIL))
        (PROG (|d1| $)
          (LETT |d1| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|RDEPAR;csolve1| |x4| |d1| $))))) 

(SDEFUN |RDEPAR;do_diff_rde!0| ((|x1| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |x1| |x| (QREFELT $ 169)))))) 

(SDEFUN |RDEPAR;do_alg_rde0|
        ((|fp| (F)) (|lg| (|List| F)) (|x| (|Symbol|)) (|k| (|Kernel| F))
         (|lk| (|List| (|Kernel| F)))
         (|ext|
          (|Mapping|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
           (|List| (|Kernel| F)) (|List| F)))
         (|logi|
          (|Mapping|
           (|Record| (|:| |logands| (|List| F))
                     (|:| |basis|
                          (|List| (|Vector| (|Fraction| (|Integer|))))))
           (|List| (|Kernel| F)) (|List| F)))
         ($ (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G1412 NIL) (|ba| NIL) (#2=#:G1413 NIL) (|bv| NIL)
          (#3=#:G1411 NIL) (|kfi| (F)) (|lba| (|List| F))
          (|cb| (|List| (|Vector| F))) (|nlba| (|List| F)) (#4=#:G1410 NIL)
          (|be| NIL) (#5=#:G1409 NIL) (|ncb| (|List| (|Vector| F)))
          (#6=#:G1408 NIL) (#7=#:G1407 NIL)
          (|s1|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))))
          (|lgi1| (|List| F)) (#8=#:G1406 NIL) (#9=#:G1405 NIL)
          (|lgi| (|List| F)) (#10=#:G1404 NIL) (|j| NIL) (#11=#:G1403 NIL)
          (|i| NIL) (#12=#:G1402 NIL) (#13=#:G1401 NIL) (#14=#:G1399 NIL)
          (#15=#:G1400 NIL) (#16=#:G1398 NIL) (#17=#:G1397 NIL)
          (|m| (|NonNegativeInteger|)) (|llv| (|Vector| (|List| F)))
          (#18=#:G1396 NIL) (|g| NIL) (#19=#:G1395 NIL) (|kf| (F)) (|dlk| (F))
          (|ak1| (F)) (|n| (|Integer|)) (|ak2| (F)) (|ak| (|List| F)))
         (SEQ (LETT |ak| (SPADCALL |k| (QREFELT $ 178)))
              (LETT |ak2| (SPADCALL |ak| 2 (QREFELT $ 179)))
              (LETT |n| (SPADCALL |ak2| (QREFELT $ 204)))
              (LETT |ak1| (SPADCALL |ak| 1 (QREFELT $ 179)))
              (LETT |dlk|
                    (SPADCALL (SPADCALL |ak1| |x| (QREFELT $ 205))
                              (SPADCALL |ak2| |ak1| (QREFELT $ 110))
                              (QREFELT $ 128)))
              (LETT |kf| (SPADCALL |k| (QREFELT $ 31)))
              (LETT |kfi| (|spadConstant| $ 64))
              (LETT |llv|
                    (SPADCALL
                     (PROGN
                      (LETT #19# NIL)
                      (SEQ (LETT |g| NIL) (LETT #18# |lg|) G190
                           (COND
                            ((OR (ATOM #18#) (PROGN (LETT |g| (CAR #18#)) NIL))
                             (GO G191)))
                           (SEQ
                            (EXIT
                             (LETT #19#
                                   (CONS (SPADCALL |g| |k| |n| (QREFELT $ 207))
                                         #19#))))
                           (LETT #18# (CDR #18#)) (GO G190) G191
                           (EXIT (NREVERSE #19#))))
                     (QREFELT $ 209)))
              (LETT |m| (LENGTH |lg|))
              (LETT |cb|
                    (PROGN
                     (LETT #17# NIL)
                     (SEQ (LETT |i| 1) (LETT #16# |m|) G190
                          (COND ((|greater_SI| |i| #16#) (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #17#
                                  (CONS (MAKEARR1 |m| (|spadConstant| $ 42))
                                        #17#))))
                          (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                          (EXIT (NREVERSE #17#)))))
              (SEQ (LETT |bv| NIL) (LETT #15# |cb|) (LETT |i| 1)
                   (LETT #14# |m|) G190
                   (COND
                    ((OR (|greater_SI| |i| #14#) (ATOM #15#)
                         (PROGN (LETT |bv| (CAR #15#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |bv| |i| (|spadConstant| $ 64) (QREFELT $ 97))))
                   (LETT |i| (PROG1 (|inc_SI| |i|) (LETT #15# (CDR #15#))))
                   (GO G190) G191 (EXIT NIL))
              (LETT |lba|
                    (PROGN
                     (LETT #13# NIL)
                     (SEQ (LETT |bv| NIL) (LETT #12# |cb|) G190
                          (COND
                           ((OR (ATOM #12#) (PROGN (LETT |bv| (CAR #12#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #13# (CONS (|spadConstant| $ 42) #13#))))
                          (LETT #12# (CDR #12#)) (GO G190) G191
                          (EXIT (NREVERSE #13#)))))
              (SEQ (LETT |i| 0) (LETT #11# (- |n| 1)) G190
                   (COND ((|greater_SI| |i| #11#) (GO G191)))
                   (SEQ (LETT |lgi| NIL)
                        (SEQ (LETT |j| 1) (LETT #10# |m|) G190
                             (COND ((|greater_SI| |j| #10#) (GO G191)))
                             (SEQ
                              (LETT |lgi|
                                    (CONS
                                     (|SPADfirst|
                                      (SPADCALL |llv| |j| (QREFELT $ 210)))
                                     |lgi|))
                              (EXIT
                               (SPADCALL |llv| |j|
                                         (CDR
                                          (SPADCALL |llv| |j| (QREFELT $ 210)))
                                         (QREFELT $ 211))))
                             (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                             (EXIT NIL))
                        (LETT |lgi| (NREVERSE |lgi|))
                        (LETT |lgi1|
                              (PROGN
                               (LETT #9# NIL)
                               (SEQ (LETT |bv| NIL) (LETT #8# |cb|) G190
                                    (COND
                                     ((OR (ATOM #8#)
                                          (PROGN (LETT |bv| (CAR #8#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #9#
                                            (CONS
                                             (SPADCALL |bv| |lgi|
                                                       (QREFELT $ 109))
                                             #9#))))
                                    (LETT #8# (CDR #8#)) (GO G190) G191
                                    (EXIT (NREVERSE #9#)))))
                        (LETT |s1|
                              (SPADCALL
                               (SPADCALL |fp|
                                         (SPADCALL
                                          (SPADCALL |i| (QREFELT $ 44)) |dlk|
                                          (QREFELT $ 110))
                                         (QREFELT $ 111))
                               |lgi1| |x| |lk| |ext| |logi| (QREFELT $ 118)))
                        (LETT |ncb|
                              (PROGN
                               (LETT #7# NIL)
                               (SEQ (LETT |be| NIL) (LETT #6# |s1|) G190
                                    (COND
                                     ((OR (ATOM #6#)
                                          (PROGN (LETT |be| (CAR #6#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #7#
                                            (CONS
                                             (SPADCALL (QCDR |be|) |cb|
                                                       (QREFELT $ 80))
                                             #7#))))
                                    (LETT #6# (CDR #6#)) (GO G190) G191
                                    (EXIT (NREVERSE #7#)))))
                        (LETT |nlba|
                              (PROGN
                               (LETT #5# NIL)
                               (SEQ (LETT |be| NIL) (LETT #4# |s1|) G190
                                    (COND
                                     ((OR (ATOM #4#)
                                          (PROGN (LETT |be| (CAR #4#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #5#
                                            (CONS
                                             (SPADCALL
                                              (SPADCALL (QCDR |be|) |lba|
                                                        (QREFELT $ 109))
                                              (SPADCALL (QCAR |be|) |kfi|
                                                        (QREFELT $ 110))
                                              (QREFELT $ 111))
                                             #5#))))
                                    (LETT #4# (CDR #4#)) (GO G190) G191
                                    (EXIT (NREVERSE #5#)))))
                        (LETT |cb| |ncb|) (LETT |lba| |nlba|)
                        (EXIT
                         (LETT |kfi| (SPADCALL |kf| |kfi| (QREFELT $ 110)))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (PROGN
                (LETT #3# NIL)
                (SEQ (LETT |bv| NIL) (LETT #2# |cb|) (LETT |ba| NIL)
                     (LETT #1# |lba|) G190
                     (COND
                      ((OR (ATOM #1#) (PROGN (LETT |ba| (CAR #1#)) NIL)
                           (ATOM #2#) (PROGN (LETT |bv| (CAR #2#)) NIL))
                       (GO G191)))
                     (SEQ (EXIT (LETT #3# (CONS (CONS |ba| |bv|) #3#))))
                     (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                     (GO G190) G191 (EXIT (NREVERSE #3#)))))))) 

(SDEFUN |RDEPAR;do_alg_rde|
        ((|fp| (F)) (|lg| (|List| F)) (|x| (|Symbol|)) (|k| (|Kernel| F))
         (|lk| (|List| (|Kernel| F)))
         (|ext|
          (|Mapping|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
           (|List| (|Kernel| F)) (|List| F)))
         (|logi|
          (|Mapping|
           (|Record| (|:| |logands| (|List| F))
                     (|:| |basis|
                          (|List| (|Vector| (|Fraction| (|Integer|))))))
           (|List| (|Kernel| F)) (|List| F)))
         ($
          #1=(|List|
              (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#2=#:G1462 NIL) (|be| NIL) (#3=#:G1461 NIL) (|res1| #1#)
          (#4=#:G1460 NIL) (|kk| NIL) (#5=#:G1459 NIL) (|lg1| (|List| F))
          (#6=#:G1458 NIL) (|g| NIL) (#7=#:G1457 NIL) (|fp1| (F))
          (|ky| (|Kernel| F)) (|y| (F))
          (|rec|
           (|Record| (|:| |primelt| F)
                     (|:| |pol1| (|SparseUnivariatePolynomial| F))
                     (|:| |pol2| (|SparseUnivariatePolynomial| F))
                     (|:| |prim| (|SparseUnivariatePolynomial| F))))
          (|part2|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))))
          (#8=#:G1456 NIL) (|f| NIL) (#9=#:G1455 NIL)
          (|part1|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))))
          (#10=#:G1454 NIL) (#11=#:G1453 NIL) (|n| (|NonNegativeInteger|))
          (|k1| (|Kernel| F)) (#12=#:G1452 NIL) (|cc| (F)))
         (SEQ
          (EXIT
           (SEQ
            (COND
             ((EQL (LENGTH |lg|) 1)
              (SEQ
               (LETT |cc|
                     (SPADCALL (SPADCALL |lg| 1 (QREFELT $ 179)) |fp|
                               (QREFELT $ 128)))
               (EXIT
                (COND
                 ((SPADCALL (SPADCALL |cc| |x| (QREFELT $ 205))
                            (|spadConstant| $ 42) (QREFELT $ 126))
                  (PROGN
                   (LETT #12#
                         (LIST
                          (CONS (SPADCALL |cc| (QREFELT $ 107))
                                (VECTOR (|spadConstant| $ 64)))))
                   (GO #13=#:G1451))))))))
            (COND
             ((SPADCALL |k| '|nthRoot| (QREFELT $ 168))
              (COND
               ((NULL
                 (SPADCALL |k| (SPADCALL |fp| (QREFELT $ 212))
                           (QREFELT $ 213)))
                (EXIT
                 (|RDEPAR;do_alg_rde0| |fp| |lg| |x| |k| |lk| |ext| |logi|
                  $))))))
            (LETT |k1| (SPADCALL |lk| (QREFELT $ 163)))
            (EXIT
             (COND
              ((QEQCAR (SPADCALL |k1| (QREFELT $ 215)) 0)
               (SEQ (LETT |res1| (SPADCALL |fp| |lg| |k1| |k| (QREFELT $ 218)))
                    (LETT |n| (LENGTH |lg|))
                    (LETT |part1|
                          (PROGN
                           (LETT #11# NIL)
                           (SEQ (LETT |be| NIL) (LETT #10# (QCAR |res1|)) G190
                                (COND
                                 ((OR (ATOM #10#)
                                      (PROGN (LETT |be| (CAR #10#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #11#
                                        (CONS
                                         (CONS
                                          (SPADCALL (QCAR |be|)
                                                    (QREFELT $ 107))
                                          (QCDR |be|))
                                         #11#))))
                                (LETT #10# (CDR #10#)) (GO G190) G191
                                (EXIT (NREVERSE #11#)))))
                    (LETT |part2|
                          (PROGN
                           (LETT #9# NIL)
                           (SEQ (LETT |f| NIL) (LETT #8# (QCDR |res1|)) G190
                                (COND
                                 ((OR (ATOM #8#)
                                      (PROGN (LETT |f| (CAR #8#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #9#
                                        (CONS
                                         (CONS |f|
                                               (MAKEARR1 |n|
                                                         (|spadConstant| $
                                                                         42)))
                                         #9#))))
                                (LETT #8# (CDR #8#)) (GO G190) G191
                                (EXIT (NREVERSE #9#)))))
                    (EXIT (SPADCALL |part1| |part2| (QREFELT $ 219)))))
              ((SPADCALL (SPADCALL |k1| (QREFELT $ 166)) '|%alg|
                         (QREFELT $ 167))
               (SEQ
                (LETT |rec|
                      (SPADCALL (SPADCALL |k1| (QREFELT $ 31))
                                (SPADCALL |k| (QREFELT $ 31)) (QREFELT $ 222)))
                (LETT |y| (SPADCALL (QVELT |rec| 3) (QREFELT $ 224)))
                (LETT |ky| (SPADCALL |y| (QREFELT $ 180)))
                (LETT |fp1|
                      (SPADCALL |fp| (LIST |k1| |k|)
                                (LIST
                                 (SPADCALL (QVELT |rec| 1) |y| (QREFELT $ 225))
                                 (SPADCALL (QVELT |rec| 2) |y|
                                           (QREFELT $ 225)))
                                (QREFELT $ 226)))
                (LETT |lg1|
                      (PROGN
                       (LETT #7# NIL)
                       (SEQ (LETT |g| NIL) (LETT #6# |lg|) G190
                            (COND
                             ((OR (ATOM #6#) (PROGN (LETT |g| (CAR #6#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #7#
                                    (CONS
                                     (SPADCALL |g| (LIST |k1| |k|)
                                               (LIST
                                                (SPADCALL (QVELT |rec| 1) |y|
                                                          (QREFELT $ 225))
                                                (SPADCALL (QVELT |rec| 2) |y|
                                                          (QREFELT $ 225)))
                                               (QREFELT $ 226))
                                     #7#))))
                            (LETT #6# (CDR #6#)) (GO G190) G191
                            (EXIT (NREVERSE #7#)))))
                (LETT |res1|
                      (|RDEPAR;do_alg_rde| |fp1| |lg1| |x| |ky|
                       (PROGN
                        (LETT #5# NIL)
                        (SEQ (LETT |kk| NIL) (LETT #4# |lk|) G190
                             (COND
                              ((OR (ATOM #4#)
                                   (PROGN (LETT |kk| (CAR #4#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT
                               (COND
                                ((SPADCALL |kk| |k1| (QREFELT $ 164))
                                 (LETT #5# (CONS |kk| #5#))))))
                             (LETT #4# (CDR #4#)) (GO G190) G191
                             (EXIT (NREVERSE #5#))))
                       |ext| |logi| $))
                (EXIT
                 (PROGN
                  (LETT #3# NIL)
                  (SEQ (LETT |be| NIL) (LETT #2# |res1|) G190
                       (COND
                        ((OR (ATOM #2#) (PROGN (LETT |be| (CAR #2#)) NIL))
                         (GO G191)))
                       (SEQ
                        (EXIT
                         (LETT #3#
                               (CONS
                                (CONS
                                 (SPADCALL (QCAR |be|) |ky| (QVELT |rec| 0)
                                           (QREFELT $ 181))
                                 (QCDR |be|))
                                #3#))))
                       (LETT #2# (CDR #2#)) (GO G190) G191
                       (EXIT (NREVERSE #3#)))))))
              ('T (|error| "do_alg_rde: unimplemented kernel"))))))
          #13# (EXIT #12#)))) 

(SDEFUN |RDEPAR;param_rde;IFLSLMML;21|
        ((|m| (|Integer|)) (|f| (F)) (|lg| (|List| F)) (|x| (|Symbol|))
         (|lk| (|List| (|Kernel| F)))
         (|ext|
          (|Mapping|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
           (|List| (|Kernel| F)) (|List| F)))
         (|logi|
          (|Mapping|
           (|Record| (|:| |logands| (|List| F))
                     (|:| |basis|
                          (|List| (|Vector| (|Fraction| (|Integer|))))))
           (|List| (|Kernel| F)) (|List| F)))
         ($ (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G1474 NIL) (|k1| NIL) (#2=#:G1473 NIL) (|k| (|Kernel| F))
          (|fp| (F)))
         (SEQ
          (LETT |fp|
                (SPADCALL (SPADCALL |m| |f| (QREFELT $ 227)) |x|
                          (QREFELT $ 205)))
          (EXIT
           (COND
            ((SPADCALL |fp| (|spadConstant| $ 42) (QREFELT $ 126))
             (SPADCALL |lk| |lg| |ext|))
            ('T
             (SEQ (LETT |k| (SPADCALL |lk| (QREFELT $ 163)))
                  (LETT |lk|
                        (PROGN
                         (LETT #2# NIL)
                         (SEQ (LETT |k1| NIL) (LETT #1# |lk|) G190
                              (COND
                               ((OR (ATOM #1#)
                                    (PROGN (LETT |k1| (CAR #1#)) NIL))
                                (GO G191)))
                              (SEQ
                               (EXIT
                                (COND
                                 ((SPADCALL |k1| |k| (QREFELT $ 164))
                                  (LETT #2# (CONS |k1| #2#))))))
                              (LETT #1# (CDR #1#)) (GO G190) G191
                              (EXIT (NREVERSE #2#)))))
                  (EXIT
                   (|RDEPAR;do_param_rde| |fp| 'T |lg| |x| |k| |lk| |ext|
                    |logi| $))))))))) 

(SDEFUN |RDEPAR;do_param_rde|
        ((|fp| (F)) (|is_der| (|Boolean|)) (|lg| (|List| F)) (|x| (|Symbol|))
         (|k| (|Kernel| F)) (|lk| (|List| (|Kernel| F)))
         (|ext|
          (|Mapping|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
           (|List| (|Kernel| F)) (|List| F)))
         (|logi|
          (|Mapping|
           (|Record| (|:| |logands| (|List| F))
                     (|:| |basis|
                          (|List| (|Vector| (|Fraction| (|Integer|))))))
           (|List| (|Kernel| F)) (|List| F)))
         ($ (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((|res2|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))))
          (|anf| (F)) (|ans1| (|Fraction| (|SparseUnivariatePolynomial| F)))
          (|bv| (|Vector| F)) (#1=#:G1560 NIL) (|re| NIL)
          (|res1|
           (|List|
            (|Record|
             (|:| |ratpart| (|Fraction| (|SparseUnivariatePolynomial| F)))
             (|:| |coeffs| (|Vector| F)))))
          (#2=#:G1548 NIL)
          (|lgu1| (|List| (|Fraction| (|SparseUnivariatePolynomial| F))))
          (#3=#:G1559 NIL) (|kv| NIL)
          (|lgu| (|List| #4=(|Fraction| (|SparseUnivariatePolynomial| F))))
          (#5=#:G1558 NIL) (|dr| NIL) (#6=#:G1557 NIL)
          (|lker| (|List| (|Vector| F))) (|rs3| #7=(|Matrix| F))
          (|get_rs| (|Mapping| #7# (|Matrix| F))) (|rs2| (|Matrix| F))
          (|rs1| (|Matrix| (|SparseUnivariatePolynomial| F)))
          (|lnor1| (|List| #8=(|Fraction| (|SparseUnivariatePolynomial| F))))
          (#9=#:G1556 NIL) (#10=#:G1555 NIL)
          (|lgd|
           (|List|
            (|Record| (|:| |poly| (|SparseUnivariatePolynomial| F))
                      (|:| |normal| #8#)
                      (|:| |special|
                           (|Fraction| (|SparseUnivariatePolynomial| F))))))
          (#11=#:G1554 NIL) (|gu| NIL) (#12=#:G1553 NIL) (#13=#:G1552 NIL)
          (#14=#:G1551 NIL) (|aa1| #15=(|SparseUnivariatePolynomial| F))
          (|bbr| (|Fraction| (|SparseUnivariatePolynomial| F))) (|aa| #15#)
          (|h| NIL) (|#G250| #16=(|List| (|SparseUnivariatePolynomial| F)))
          (|d| NIL) (|#G249| #16#)
          (|der1|
           (|Mapping| (|SparseUnivariatePolynomial| F)
                      (|SparseUnivariatePolynomial| F)))
          (#17=#:G1550 NIL) (|g| NIL) (#18=#:G1549 NIL) (|fpu| #4#)
          (|dk| (|SparseUnivariatePolynomial| F)) (|dku| #4#))
         (SEQ
          (EXIT
           (COND
            ((SPADCALL (SPADCALL |k| (QREFELT $ 166)) '|%alg| (QREFELT $ 167))
             (|RDEPAR;do_alg_rde| |fp| |lg| |x| |k| |lk| |ext| |logi| $))
            ((SPADCALL |k| '|%diff| (QREFELT $ 168))
             (|RDEPAR;do_diff_rde| |fp| |lg| |x| |k| |lk| |ext| |logi| $))
            (#19='T
             (SEQ
              (LETT |dku|
                    (SPADCALL
                     (SPADCALL (SPADCALL |k| (QREFELT $ 31)) |x|
                               (QREFELT $ 169))
                     |k| (QREFELT $ 125)))
              (EXIT
               (COND
                ((SPADCALL (SPADCALL |dku| (QREFELT $ 13))
                           (|spadConstant| $ 68) (QREFELT $ 70))
                 NIL)
                (#19#
                 (SEQ (LETT |dk| (SPADCALL |dku| (QREFELT $ 22)))
                      (LETT |fpu| (SPADCALL |fp| |k| (QREFELT $ 125)))
                      (LETT |lgu|
                            (PROGN
                             (LETT #18# NIL)
                             (SEQ (LETT |g| NIL) (LETT #17# |lg|) G190
                                  (COND
                                   ((OR (ATOM #17#)
                                        (PROGN (LETT |g| (CAR #17#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #18#
                                          (CONS
                                           (SPADCALL |g| |k| (QREFELT $ 125))
                                           #18#))))
                                  (LETT #17# (CDR #17#)) (GO G190) G191
                                  (EXIT (NREVERSE #18#)))))
                      (LETT |der1|
                            (CONS #'|RDEPAR;do_param_rde!1|
                                  (VECTOR |dk| |x| $)))
                      (PROGN
                       (LETT |#G249| (|RDEPAR;get_denom| |fpu| |lgu| |der1| $))
                       (LETT |#G250| |#G249|)
                       (LETT |d| (|SPADfirst| |#G250|))
                       (LETT |#G250| (CDR |#G250|))
                       (LETT |h| (|SPADfirst| |#G250|))
                       |#G249|)
                      (LETT |aa| (SPADCALL |d| |h| (QREFELT $ 81)))
                      (LETT |bbr|
                            (SPADCALL (SPADCALL |aa| |fpu| (QREFELT $ 228))
                                      (SPADCALL
                                       (SPADCALL |d| (SPADCALL |h| |der1|)
                                                 (QREFELT $ 81))
                                       (QREFELT $ 73))
                                      (QREFELT $ 173)))
                      (LETT |aa1| (SPADCALL |aa| |h| (QREFELT $ 81)))
                      (LETT |lgu|
                            (PROGN
                             (LETT #14# NIL)
                             (SEQ (LETT |gu| NIL) (LETT #13# |lgu|) G190
                                  (COND
                                   ((OR (ATOM #13#)
                                        (PROGN (LETT |gu| (CAR #13#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #14#
                                          (CONS
                                           (SPADCALL |aa1| |gu|
                                                     (QREFELT $ 228))
                                           #14#))))
                                  (LETT #13# (CDR #13#)) (GO G190) G191
                                  (EXIT (NREVERSE #14#)))))
                      (LETT |lgd|
                            (PROGN
                             (LETT #12# NIL)
                             (SEQ (LETT |gu| NIL) (LETT #11# |lgu|) G190
                                  (COND
                                   ((OR (ATOM #11#)
                                        (PROGN (LETT |gu| (CAR #11#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #12#
                                          (CONS
                                           (SPADCALL |gu| |der1|
                                                     (QREFELT $ 230))
                                           #12#))))
                                  (LETT #11# (CDR #11#)) (GO G190) G191
                                  (EXIT (NREVERSE #12#)))))
                      (LETT |lnor1|
                            (PROGN
                             (LETT #10# NIL)
                             (SEQ (LETT |dr| NIL) (LETT #9# |lgd|) G190
                                  (COND
                                   ((OR (ATOM #9#)
                                        (PROGN (LETT |dr| (CAR #9#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #10# (CONS (QVELT |dr| 1) #10#))))
                                  (LETT #9# (CDR #9#)) (GO G190) G191
                                  (EXIT (NREVERSE #10#)))))
                      (LETT |rs1|
                            (SPADCALL (SPADCALL (LIST |lnor1|) (QREFELT $ 233))
                                      (QREFELT $ 234)))
                      (LETT |rs2| (SPADCALL |rs1| (QREFELT $ 56)))
                      (LETT |get_rs|
                            (CONS #'|RDEPAR;do_param_rde!3| (VECTOR |x| $)))
                      (LETT |rs3| (SPADCALL |rs2| |get_rs|))
                      (LETT |lker| (SPADCALL |rs3| (QREFELT $ 58)))
                      (EXIT
                       (COND ((NULL |lker|) NIL)
                             (#19#
                              (SEQ
                               (LETT |lgu|
                                     (PROGN
                                      (LETT #6# NIL)
                                      (SEQ (LETT |dr| NIL) (LETT #5# |lgd|)
                                           G190
                                           (COND
                                            ((OR (ATOM #5#)
                                                 (PROGN
                                                  (LETT |dr| (CAR #5#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (LETT #6#
                                                   (CONS
                                                    (SPADCALL
                                                     (SPADCALL (QVELT |dr| 0)
                                                               (QREFELT $ 73))
                                                     (QVELT |dr| 2)
                                                     (QREFELT $ 121))
                                                    #6#))))
                                           (LETT #5# (CDR #5#)) (GO G190) G191
                                           (EXIT (NREVERSE #6#)))))
                               (LETT |lgu1| NIL)
                               (SEQ (LETT |kv| NIL) (LETT #3# |lker|) G190
                                    (COND
                                     ((OR (ATOM #3#)
                                          (PROGN (LETT |kv| (CAR #3#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT |lgu1|
                                            (CONS
                                             (SPADCALL |kv| |lgu|
                                                       (QREFELT $ 120))
                                             |lgu1|))))
                                    (LETT #3# (CDR #3#)) (GO G190) G191
                                    (EXIT NIL))
                               (LETT |lgu1| (NREVERSE |lgu1|))
                               (LETT |res1|
                                     (COND
                                      ((OR
                                        (QEQCAR (SPADCALL |k| (QREFELT $ 215))
                                                0)
                                        (OR
                                         (SPADCALL |k| '|log| (QREFELT $ 168))
                                         (SPADCALL
                                          (SPADCALL |k| (QREFELT $ 166))
                                          '|prim| (QREFELT $ 167))))
                                       (|RDEPAR;do_SPDE_prim| |aa| |bbr|
                                        |is_der| |lgu1| |k| |lk| |ext| |logi|
                                        |der1| |get_rs| |x| $))
                                      ((SPADCALL |k| '|exp| (QREFELT $ 168))
                                       (|RDEPAR;do_SPDE_exp| |aa| |bbr| |lgu1|
                                        |lk| |ext| |logi| |der1| |get_rs| |x|
                                        $))
                                      (#19#
                                       (PROGN
                                        (LETT #2# NIL)
                                        (GO #20=#:G1547)))))
                               (LETT |res2| NIL)
                               (SEQ (LETT |re| NIL) (LETT #1# |res1|) G190
                                    (COND
                                     ((OR (ATOM #1#)
                                          (PROGN (LETT |re| (CAR #1#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (LETT |bv|
                                           (SPADCALL (QCDR |re|) |lker|
                                                     (QREFELT $ 80)))
                                     (LETT |ans1|
                                           (SPADCALL
                                            (SPADCALL (QCAR |re|)
                                                      (SPADCALL |h|
                                                                (QREFELT $ 73))
                                                      (QREFELT $ 159))
                                            (QREFELT $ 236)))
                                     (LETT |anf|
                                           (SPADCALL |ans1| |k|
                                                     (QREFELT $ 123)))
                                     (EXIT
                                      (LETT |res2|
                                            (CONS (CONS |anf| |bv|) |res2|))))
                                    (LETT #1# (CDR #1#)) (GO G190) G191
                                    (EXIT NIL))
                               (EXIT (NREVERSE |res2|))))))))))))))
          #20# (EXIT #2#)))) 

(SDEFUN |RDEPAR;do_param_rde!3| ((|m| NIL) ($$ NIL))
        (PROG ($ |x|)
          (LETT $ (QREFELT $$ 1))
          (LETT |x| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL |m|
                             (LIST
                              (CONS #'|RDEPAR;do_param_rde!2| (VECTOR $ |x|)))
                             (QREFELT $ 235))))))) 

(SDEFUN |RDEPAR;do_param_rde!2| ((|ff| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |ff| |x| (QREFELT $ 169)))))) 

(SDEFUN |RDEPAR;do_param_rde!1| ((|z1| NIL) ($$ NIL))
        (PROG ($ |x| |dk|)
          (LETT $ (QREFELT $$ 2))
          (LETT |x| (QREFELT $$ 1))
          (LETT |dk| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG NIL
                   (SPADCALL |z1|
                             (CONS #'|RDEPAR;do_param_rde!0| (VECTOR $ |x|))
                             |dk| (QREFELT $ 171))))))) 

(SDEFUN |RDEPAR;do_param_rde!0| ((|z2| NIL) ($$ NIL))
        (PROG (|x| $)
          (LETT |x| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |z2| |x| (QREFELT $ 169)))))) 

(DECLAIM (NOTINLINE |ParametricRischDE;|)) 

(DEFUN |ParametricRischDE| (&REST #1=#:G1561)
  (SPROG NIL
         (PROG (#2=#:G1562)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ParametricRischDE|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |ParametricRischDE;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|ParametricRischDE|)))))))))) 

(DEFUN |ParametricRischDE;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|ParametricRischDE| DV$1 DV$2))
          (LETT $ (GETREFV 237))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ParametricRischDE| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ParametricRischDE| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|SparseUnivariatePolynomial| 7) (|Fraction| 8) (|Mapping| 8 8)
              (|MonomialExtensionTools| 7 8) (0 . |normalDenom|) (6 . |denom|)
              (|List| $) (11 . |lcm|)
              (|Record| (|:| |normal| 8) (|:| |special| 8)) (16 . |split|)
              (22 . |gcd|) (28 . |differentiate|) (|Union| $ '"failed")
              (33 . |exquo|) (39 . |numer|)
              (|Record| (|:| |coef1| $) (|:| |coef2| $)) (|Union| 23 '"failed")
              (44 . |extendedEuclidean|) (|Symbol|) (51 . |new|) (|Kernel| 7)
              (55 . |kernel|) (|Kernel| $) (60 . |coerce|) (65 . *) (71 . -)
              (77 . |resultant|) (|List| 39) (|FunctionSpaceRationalRoots| 6 7)
              (83 . |get_rational_roots|) (|Union| 43 '"failed")
              (|Fraction| 43) (89 . |retractIfCan|) (94 . |Zero|) (98 . |Zero|)
              (|Integer|) (102 . |coerce|) (|LaurentPolynomial| 7 8)
              (107 . |coerce|) (112 . |exquo|)
              (|Record| (|:| |ans| 8) (|:| |remainder| 8)) (|RDEaux| 7)
              (118 . SPDE1) (|List| 60) (|Matrix| 8) (125 . |matrix|)
              (|Matrix| 7) (|Matrix| $) (130 . |reducedSystem|) (|List| 59)
              (135 . |nullSpace|) (|Vector| 7) (|List| 8)
              (|LinearCombinationUtilities| 7 8) (140 . |lin_comb|)
              (146 . |One|) (150 . |One|) (|NonNegativeInteger|)
              (154 . |monomial|) (160 . |degree|) (165 . |One|) (|Boolean|)
              (169 . ~=) (175 . =) (181 . |Zero|) (185 . |coerce|)
              (190 . |retract|)
              (|Record| (|:| |ans| 60) (|:| |acoeff| 8) (|:| |eegen| 8)
                        (|:| |bpar| 8) (|:| |lcpar| 60) (|:| |dpar| 43))
              (|Union| (|List| 48) 75) (195 . |multi_SPDE|)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (204 . |divide|) (210 . |lin_comb|) (216 . *) (222 . +)
              (|Record| (|:| |num| 84) (|:| |den| 43)) (|Vector| 39)
              (|CommonDenominator| 43 39 84) (228 . |splitDenominator|)
              (233 . ~=) (239 . |elt|) (245 . |One|) (249 . ~=)
              (255 . |retract|) (|List| 43) (|Vector| 43) (260 . |vector|)
              (|Vector| 8) (265 . |vector|) (270 . |setelt!|) (277 . |max|)
              (|Mapping| 43 43 43) (283 . |reduce|) (290 . |retract|)
              (295 . |Zero|) (299 . |elt|) (305 . |leadingCoefficient|)
              (310 . |reductum|) (315 . |setelt!|) (322 . -) (|List| 7)
              (327 . |lin_comb|) (333 . *) (339 . +)
              (|Record| (|:| |ratpart| 7) (|:| |coeffs| 59)) (|List| 112)
              (|List| 28) (|Mapping| 113 114 108)
              (|Record| (|:| |logands| 108) (|:| |basis| (|List| 84)))
              (|Mapping| 116 114 108) |RDEPAR;param_rde2;FLSLMML;15| (|List| 9)
              (345 . |lin_comb|) (351 . +)
              (|PolynomialCategoryQuotientFunctions| (|IndexedExponents| 28) 28
                                                     6
                                                     (|SparseMultivariatePolynomial|
                                                      6 28)
                                                     7)
              (357 . |multivariate|) (|Fraction| 223) (363 . |univariate|)
              (369 . =) (375 . |reduce|) (381 . /) (387 . |retractIfCan|)
              (|Union| 112 '"failed")
              (|Record| (|:| |particular| 130) (|:| |basis| 113))
              (392 . |dehomogenize|) (397 . |elt|) (|List| 45) (|Vector| 45)
              (403 . |vector|) (408 . |Zero|) (412 . |degree|) (417 . |elt|)
              (423 . ~=) (429 . |leadingCoefficient|) (434 . |reductum|)
              (439 . |setelt!|) (446 . |lin_comb|) (452 . |monomial|) (458 . +)
              (464 . |convert|) (469 . |coefficient|) (475 . |coefficient|)
              (481 . /) |RDEPAR;exp_lower_bound;SupLp2ILFMI;11| (487 . |order|)
              (492 . |min|) (498 . |retract|) (503 . |coerce|) (508 . *)
              (514 . |retract|) (519 . |One|) (523 . /)
              |RDEPAR;param_rde;IFLSLMML;21| |RDEPAR;param_rde;I2FLSLMMR;14|
              (|IntegrationTools| 6 7) (529 . |kmax|) (534 . ~=)
              (|BasicOperator|) (540 . |operator|) (545 . |has?|) (551 . |is?|)
              (557 . |differentiate|) (|Mapping| 7 7) (563 . |differentiate|)
              (570 . /) (576 . -) (582 . ^) (|List| 170)
              (|ConstantLinearDependence| 6 7) (588 . |nullSpaceOverConstants|)
              (594 . |argument|) (599 . |elt|) (605 . |retract|) (610 . |eval|)
              (617 . |coerce|) (622 . |eval|) (629 . |append|) (|List| 30)
              (635 . |tower|) (640 . |varselect|) (|ParametricIntegration| 6 7)
              (646 . |extendedint|) (653 . |logextint|)
              (|Record| (|:| |transform| 54) (|:| |basis| 57))
              (660 . |constant_subspace|) (666 . |vector|) (671 . *)
              (677 . |entries|) (682 . |map|) (688 . ~=) (|List| 108)
              (694 . |matrix|) (|Mapping| 113 60) (|Mapping| 57 54)
              (|ParametricTranscendentalIntegration| 7 8) (699 . |diffextint|)
              (706 . |retract|) (711 . D) (|RootFSSplit| 6 7)
              (717 . |alg_split_root0|) (|Vector| 108) (724 . |vector|)
              (729 . |elt|) (735 . |setelt!|) (742 . |kernels|)
              (747 . |member?|) (|Union| 26 '"failed") (753 . |symbolIfCan|)
              (|Record| (|:| |particular| 113) (|:| |basis| 108))
              (|PureAlgebraicIntegration| 6 7 7) (758 . |param_RDE|)
              (766 . |concat|)
              (|Record| (|:| |primelt| 7) (|:| |pol1| 8) (|:| |pol2| 8)
                        (|:| |prim| 8))
              (|FunctionSpacePrimitiveElement| 6 7) (772 . |primitiveElement|)
              (|SparseUnivariatePolynomial| $) (778 . |rootOf|) (783 . |elt|)
              (789 . |eval|) (796 . *) (802 . *)
              (|Record| (|:| |poly| 8) (|:| |normal| 9) (|:| |special| 9))
              (808 . |decompose|) (|List| 119) (|Matrix| 9) (814 . |matrix|)
              (819 . |reducedSystem|) (824 . |reducedSystem|) (830 . -))
           '#(|param_rde2| 835 |param_rde| 845 |exp_lower_bound| 868) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|param_rde|
                                 ((|List|
                                   (|Record| (|:| |ratpart| |#2|)
                                             (|:| |coeffs| (|Vector| |#2|))))
                                  (|Integer|) |#2| (|List| |#2|) (|Symbol|)
                                  (|List| (|Kernel| |#2|))
                                  (|Mapping|
                                   (|List|
                                    (|Record| (|:| |ratpart| |#2|)
                                              (|:| |coeffs| (|Vector| |#2|))))
                                   (|List| (|Kernel| |#2|)) (|List| |#2|))
                                  (|Mapping|
                                   (|Record| (|:| |logands| (|List| |#2|))
                                             (|:| |basis|
                                                  (|List|
                                                   (|Vector|
                                                    (|Fraction|
                                                     (|Integer|))))))
                                   (|List| (|Kernel| |#2|)) (|List| |#2|))))
                                T)
                              '((|param_rde|
                                 ((|Record|
                                   (|:| |particular|
                                        (|Union|
                                         (|Record| (|:| |ratpart| |#2|)
                                                   (|:| |coeffs|
                                                        (|Vector| |#2|)))
                                         "failed"))
                                   (|:| |basis|
                                        (|List|
                                         (|Record| (|:| |ratpart| |#2|)
                                                   (|:| |coeffs|
                                                        (|Vector| |#2|))))))
                                  (|Integer|) |#2| |#2| (|List| |#2|)
                                  (|Symbol|) (|List| (|Kernel| |#2|))
                                  (|Mapping|
                                   (|List|
                                    (|Record| (|:| |ratpart| |#2|)
                                              (|:| |coeffs| (|Vector| |#2|))))
                                   (|List| (|Kernel| |#2|)) (|List| |#2|))
                                  (|Mapping|
                                   (|Record| (|:| |logands| (|List| |#2|))
                                             (|:| |basis|
                                                  (|List|
                                                   (|Vector|
                                                    (|Fraction|
                                                     (|Integer|))))))
                                   (|List| (|Kernel| |#2|)) (|List| |#2|))))
                                T)
                              '((|param_rde2|
                                 ((|List|
                                   (|Record| (|:| |ratpart| |#2|)
                                             (|:| |coeffs| (|Vector| |#2|))))
                                  |#2| (|List| |#2|) (|Symbol|)
                                  (|List| (|Kernel| |#2|))
                                  (|Mapping|
                                   (|List|
                                    (|Record| (|:| |ratpart| |#2|)
                                              (|:| |coeffs| (|Vector| |#2|))))
                                   (|List| (|Kernel| |#2|)) (|List| |#2|))
                                  (|Mapping|
                                   (|Record| (|:| |logands| (|List| |#2|))
                                             (|:| |basis|
                                                  (|List|
                                                   (|Vector|
                                                    (|Fraction|
                                                     (|Integer|))))))
                                   (|List| (|Kernel| |#2|)) (|List| |#2|))))
                                T)
                              '((|exp_lower_bound|
                                 ((|Integer|)
                                  (|SparseUnivariatePolynomial| |#2|)
                                  (|LaurentPolynomial| |#2|
                                                       (|SparseUnivariatePolynomial|
                                                        |#2|))
                                  (|Integer|) (|Integer|)
                                  (|List| (|Kernel| |#2|)) |#2|
                                  (|Mapping|
                                   (|Record| (|:| |logands| (|List| |#2|))
                                             (|:| |basis|
                                                  (|List|
                                                   (|Vector|
                                                    (|Fraction|
                                                     (|Integer|))))))
                                   (|List| (|Kernel| |#2|)) (|List| |#2|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 236
                                            '(2 11 8 9 10 12 1 9 8 0 13 1 8 0
                                              14 15 2 11 16 8 10 17 2 8 0 0 0
                                              18 1 8 0 0 19 2 8 20 0 0 21 1 9 8
                                              0 22 3 8 24 0 0 0 25 0 26 0 27 1
                                              28 0 26 29 1 7 0 30 31 2 8 0 7 0
                                              32 2 8 0 0 0 33 2 8 7 0 0 34 2 36
                                              35 7 28 37 1 39 38 0 40 0 6 0 41
                                              0 7 0 42 1 7 0 43 44 1 45 0 8 46
                                              2 45 20 0 0 47 3 49 48 8 8 10 50
                                              1 52 0 51 53 1 8 54 55 56 1 54 57
                                              0 58 2 61 8 59 60 62 0 6 0 63 0 7
                                              0 64 2 8 0 7 65 66 1 8 65 0 67 0
                                              8 0 68 2 8 69 0 0 70 2 8 69 0 0
                                              71 0 8 0 72 1 9 0 8 73 1 9 8 0 74
                                              5 49 76 8 8 60 43 10 77 2 8 78 0
                                              0 79 2 61 59 59 57 80 2 8 0 0 0
                                              81 2 8 0 0 0 82 1 85 83 84 86 2
                                              43 69 0 0 87 2 84 39 0 43 88 0 39
                                              0 89 2 39 69 0 0 90 1 39 43 0 91
                                              1 93 0 92 94 1 95 0 60 96 3 59 7
                                              0 43 7 97 2 43 0 0 0 98 3 92 43
                                              99 0 43 100 1 8 7 0 101 0 9 0 102
                                              2 95 8 0 43 103 1 8 7 0 104 1 8 0
                                              0 105 3 95 8 0 43 8 106 1 7 0 0
                                              107 2 61 7 59 108 109 2 7 0 0 0
                                              110 2 7 0 0 0 111 2 61 9 59 119
                                              120 2 9 0 0 0 121 2 122 7 9 28
                                              123 2 7 124 0 30 125 2 7 69 0 0
                                              126 2 92 43 99 0 127 2 7 0 0 0
                                              128 1 7 38 0 129 1 61 131 113 132
                                              2 59 7 0 43 133 1 135 0 134 136 0
                                              45 0 137 1 45 43 0 138 2 135 45 0
                                              43 139 2 45 69 0 0 140 1 45 7 0
                                              141 1 45 0 0 142 3 135 45 0 43 45
                                              143 2 61 45 59 134 144 2 45 0 7
                                              43 145 2 45 0 0 0 146 1 45 9 0
                                              147 2 45 7 0 43 148 2 8 7 0 65
                                              149 2 39 0 0 0 150 1 45 43 0 152
                                              2 43 0 0 0 153 1 45 7 0 154 1 45
                                              0 7 155 2 45 0 0 0 156 1 45 8 0
                                              157 0 9 0 158 2 9 0 0 0 159 1 162
                                              28 114 163 2 28 69 0 0 164 1 28
                                              165 0 166 2 165 69 0 26 167 2 28
                                              69 0 26 168 2 7 0 0 26 169 3 8 0
                                              0 170 0 171 2 9 0 8 8 172 2 9 0 0
                                              0 173 2 8 0 0 65 174 2 176 57 54
                                              175 177 1 28 108 0 178 2 108 7 0
                                              43 179 1 7 30 0 180 3 7 0 0 30 0
                                              181 1 7 0 26 182 3 7 0 0 0 0 183
                                              2 108 0 0 0 184 1 7 185 14 186 2
                                              162 114 114 26 187 3 188 113 26
                                              114 108 189 3 188 116 26 114 108
                                              190 2 176 191 57 175 192 1 59 0
                                              108 193 2 54 59 0 59 194 1 59 108
                                              0 195 2 108 0 170 0 196 2 7 69 0
                                              0 197 1 54 0 198 199 3 202 113
                                              200 201 119 203 1 7 43 0 204 2 7
                                              0 0 26 205 3 206 108 7 28 43 207
                                              1 208 0 198 209 2 208 108 0 43
                                              210 3 208 108 0 43 108 211 1 7
                                              185 0 212 2 114 69 28 0 213 1 28
                                              214 0 215 4 217 216 7 108 28 28
                                              218 2 113 0 0 0 219 2 221 220 7 7
                                              222 1 7 0 223 224 2 8 7 0 7 225 3
                                              7 0 0 185 14 226 2 7 0 43 0 227 2
                                              9 0 8 0 228 2 11 229 9 10 230 1
                                              232 0 231 233 1 9 52 55 234 2 176
                                              54 54 175 235 1 9 0 0 236 6 0 113
                                              7 108 26 114 115 117 118 8 0 131
                                              43 7 7 108 26 114 115 117 161 7 0
                                              113 43 7 108 26 114 115 117 160 7
                                              0 43 8 45 43 43 114 7 117
                                              151)))))
           '|lookupComplete|)) 
