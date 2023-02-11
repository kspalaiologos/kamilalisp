
(SDEFUN |INTALG2;exp_hermite1|
        ((|f| (R)) (|der| (|Mapping| UP UP))
         ($ (|Record| (|:| |answer| R) (|:| |logpart| R) (|:| |polypart| R))))
        (SPROG
         ((|h| (|Record| (|:| |answer| R) (|:| |logpart| R))) (|fp| (R))
          (|ff| (R)) (|w| (|Vector| R))
          (|r|
           (|Record| (|:| |polyPart| (|LaurentPolynomial| F UP))
                     (|:| |fracPart| (|Fraction| UP))))
          (#1=#:G720 NIL) (|i| NIL) (|vf| #2=(|Vector| (|Fraction| UP)))
          (|vp| #2#) (|n| (|NonNegativeInteger|)) (|v| #3=(|Vector| UP))
          (|d| (UP)) (|c| (|Record| (|:| |num| #3#) (|:| |den| UP))))
         (SEQ (LETT |d| (QCDR (LETT |c| (SPADCALL |f| (QREFELT $ 12)))))
              (LETT |v| (QCAR |c|))
              (LETT |vp|
                    (MAKEARR1 (LETT |n| (QVSIZE |v|)) (|spadConstant| $ 14)))
              (LETT |vf| (MAKEARR1 |n| (|spadConstant| $ 14)))
              (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 19)))
                   (LETT #1# (QVSIZE |v|)) G190 (COND ((> |i| #1#) (GO G191)))
                   (SEQ
                    (LETT |r|
                          (SPADCALL
                           (SPADCALL (QAREF1O |v| |i| 1) |d| (QREFELT $ 20))
                           (QREFELT $ 23)))
                    (QSETAREF1O |vf| |i| (QCDR |r|) 1)
                    (EXIT
                     (QSETAREF1O |vp| |i| (SPADCALL (QCAR |r|) (QREFELT $ 24))
                                 1)))
                   (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
              (LETT |ff|
                    (SPADCALL |vf| (LETT |w| (SPADCALL (QREFELT $ 26)))
                              (QREFELT $ 28)))
              (LETT |fp| (SPADCALL |vp| |w| (QREFELT $ 28)))
              (LETT |h| (SPADCALL |ff| |der| (QREFELT $ 32)))
              (EXIT (VECTOR (QCAR |h|) (QCDR |h|) |fp|))))) 

(SDEFUN |INTALG2;prim_hermite1|
        ((|f| (R)) (|der| (|Mapping| UP UP))
         ($ (|Record| (|:| |answer| R) (|:| |logpart| R) (|:| |polypart| R))))
        (SPROG
         ((|fp| (R)) (|ff| (R)) (|w| (|Vector| R))
          (|r| (|Record| (|:| |quotient| UP) (|:| |remainder| UP)))
          (#1=#:G731 NIL) (|i| NIL) (|vf| #2=(|Vector| (|Fraction| UP)))
          (|vp| #2#) (|n| (|NonNegativeInteger|)) (|v| #3=(|Vector| UP))
          (|d| (UP)) (|c| (|Record| (|:| |num| #3#) (|:| |den| UP))) (|hh| (R))
          (|h| (|Record| (|:| |answer| R) (|:| |logpart| R))))
         (SEQ (LETT |h| (SPADCALL |f| |der| (QREFELT $ 32)))
              (EXIT
               (COND
                ((SPADCALL (LETT |hh| (QCDR |h|)) (QREFELT $ 34))
                 (VECTOR (QCAR |h|) (|spadConstant| $ 35)
                         (|spadConstant| $ 35)))
                ('T
                 (SEQ
                  (LETT |d| (QCDR (LETT |c| (SPADCALL |hh| (QREFELT $ 12)))))
                  (LETT |v| (QCAR |c|))
                  (LETT |vp|
                        (MAKEARR1 (LETT |n| (QVSIZE |v|))
                                  (|spadConstant| $ 14)))
                  (LETT |vf| (MAKEARR1 |n| (|spadConstant| $ 14)))
                  (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 19)))
                       (LETT #1# (QVSIZE |v|)) G190
                       (COND ((> |i| #1#) (GO G191)))
                       (SEQ
                        (LETT |r|
                              (SPADCALL (QAREF1O |v| |i| 1) |d|
                                        (QREFELT $ 37)))
                        (QSETAREF1O |vf| |i|
                                    (SPADCALL (QCDR |r|) |d| (QREFELT $ 20)) 1)
                        (EXIT
                         (QSETAREF1O |vp| |i|
                                     (SPADCALL (QCAR |r|) (QREFELT $ 38)) 1)))
                       (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                  (LETT |ff|
                        (SPADCALL |vf| (LETT |w| (SPADCALL (QREFELT $ 26)))
                                  (QREFELT $ 28)))
                  (LETT |fp| (SPADCALL |vp| |w| (QREFELT $ 28)))
                  (EXIT (VECTOR (QCAR |h|) |ff| |fp|))))))))) 

(SDEFUN |INTALG2;list_hermite|
        ((|lf| (|List| R))
         (|hermite1|
          (|Mapping|
           (|Record| (|:| |answer| R) (|:| |logpart| R) (|:| |polypart| R)) R))
         ($
          (|List|
           (|Record| (|:| |answer| R) (|:| |logpart| R) (|:| |polypart| R)))))
        (SPROG ((#1=#:G740 NIL) (|f| NIL) (#2=#:G739 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |f| NIL) (LETT #1# |lf|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |f| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT (LETT #2# (CONS (SPADCALL |f| |hermite1|) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |INTALG2;lin_comb2| ((|v| (|Vector| F)) (|lr| (|List| R)) ($ (R)))
        (SPROG
         ((|res| (R)) (#1=#:G746 NIL) (|i| NIL) (#2=#:G747 NIL) (|r| NIL))
         (SEQ (LETT |res| (|spadConstant| $ 35))
              (SEQ (LETT |r| NIL) (LETT #2# |lr|) (LETT |i| 1)
                   (LETT #1# (QVSIZE |v|)) G190
                   (COND
                    ((OR (|greater_SI| |i| #1#) (ATOM #2#)
                         (PROGN (LETT |r| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (LETT |res|
                           (SPADCALL |res|
                                     (SPADCALL
                                      (SPADCALL
                                       (SPADCALL
                                        (SPADCALL |v| |i| (QREFELT $ 40))
                                        (QREFELT $ 41))
                                       (QREFELT $ 38))
                                      |r| (QREFELT $ 42))
                                     (QREFELT $ 43)))))
                   (LETT |i| (PROG1 (|inc_SI| |i|) (LETT #2# (CDR #2#))))
                   (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |INTALG2;split_logpart|
        ((|p| (|Fraction| UP)) (|lg| (|Fraction| UP)) (|dden| (UP))
         ($
          (|Record| (|:| |polypart| (|Fraction| UP))
                    (|:| |logpart| (|Fraction| UP)))))
        (SPROG
         ((|b| (UP)) (|a| (UP))
          (|#G23| (|Record| (|:| |coef1| UP) (|:| |coef2| UP))) (#1=#:G754 NIL)
          (|eeu|
           (|Union| (|Record| (|:| |coef1| UP) (|:| |coef2| UP)) #2="failed"))
          (|d1| (UP)) (#3=#:G750 NIL) (|g| (UP)) (|d0| (UP)))
         (SEQ (LETT |d0| (SPADCALL |lg| (QREFELT $ 44)))
              (LETT |g| (SPADCALL |dden| |d0| (QREFELT $ 45)))
              (EXIT
               (COND ((SPADCALL |g| (QREFELT $ 46)) (CONS |p| |lg|))
                     (#4='T
                      (SEQ
                       (LETT |d1|
                             (PROG2
                                 (LETT #3# (SPADCALL |d0| |g| (QREFELT $ 48)))
                                 (QCDR #3#)
                               (|check_union2| (QEQCAR #3# 0) (QREFELT $ 8)
                                               (|Union| (QREFELT $ 8) "failed")
                                               #3#)))
                       (EXIT
                        (COND
                         ((SPADCALL |d1| (QREFELT $ 46))
                          (CONS (SPADCALL |p| |lg| (QREFELT $ 49))
                                (|spadConstant| $ 14)))
                         (#4#
                          (SEQ
                           (LETT |eeu|
                                 (SPADCALL |g| |d1|
                                           (SPADCALL |lg| (QREFELT $ 50))
                                           (QREFELT $ 53)))
                           (PROGN
                            (LETT |#G23|
                                  (PROG2 (LETT #1# |eeu|)
                                      (QCDR #1#)
                                    (|check_union2| (QEQCAR #1# 0)
                                                    (|Record|
                                                     (|:| |coef1|
                                                          (QREFELT $ 8))
                                                     (|:| |coef2|
                                                          (QREFELT $ 8)))
                                                    (|Union|
                                                     (|Record|
                                                      (|:| |coef1|
                                                           (QREFELT $ 8))
                                                      (|:| |coef2|
                                                           (QREFELT $ 8)))
                                                     #2#)
                                                    #1#)))
                            (LETT |a| (QCAR |#G23|))
                            (LETT |b| (QCDR |#G23|))
                            |#G23|)
                           (EXIT
                            (CONS
                             (SPADCALL |p| (SPADCALL |a| |d1| (QREFELT $ 20))
                                       (QREFELT $ 49))
                             (SPADCALL |b| |g| (QREFELT $ 20))))))))))))))) 

(SDEFUN |INTALG2;split_logparts|
        ((|lup| (|List| (|Fraction| UP))) (|llog| (|List| (|Fraction| UP)))
         (|dden| (UP))
         ($
          (|Record| (|:| |polypart| (|List| (|Fraction| UP)))
                    (|:| |logpart| (|List| (|Fraction| UP))))))
        (SPROG
         ((|lres| (|List| (|Fraction| UP))) (|pres| (|List| (|Fraction| UP)))
          (|lg2| (|Fraction| UP)) (|p2| (|Fraction| UP))
          (|#G29|
           (|Record| (|:| |polypart| (|Fraction| UP))
                     (|:| |logpart| (|Fraction| UP))))
          (#1=#:G766 NIL) (|p1| NIL) (#2=#:G767 NIL) (|lg1| NIL))
         (SEQ (LETT |pres| NIL) (LETT |lres| NIL)
              (SEQ (LETT |lg1| NIL) (LETT #2# |llog|) (LETT |p1| NIL)
                   (LETT #1# |lup|) G190
                   (COND
                    ((OR (ATOM #1#) (PROGN (LETT |p1| (CAR #1#)) NIL)
                         (ATOM #2#) (PROGN (LETT |lg1| (CAR #2#)) NIL))
                     (GO G191)))
                   (SEQ
                    (PROGN
                     (LETT |#G29|
                           (|INTALG2;split_logpart| |p1| |lg1| |dden| $))
                     (LETT |p2| (QCAR |#G29|))
                     (LETT |lg2| (QCDR |#G29|))
                     |#G29|)
                    (LETT |lres| (CONS |lg2| |lres|))
                    (EXIT (LETT |pres| (CONS |p2| |pres|))))
                   (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#)))) (GO G190)
                   G191 (EXIT NIL))
              (LETT |pres| (NREVERSE |pres|)) (LETT |lres| (NREVERSE |lres|))
              (EXIT (CONS |pres| |lres|))))) 

(SDEFUN |INTALG2;diagextint|
        ((|dden| (UP)) (|dm| (|Matrix| UP)) (|w| (|Vector| R))
         (|lpv| (|List| (|Vector| (|Fraction| UP))))
         (|lgv| (|List| (|Vector| (|Fraction| UP)))) (|ca0| (|List| R))
         (|ext|
          (|Mapping|
           #1=(|List|
               (|Record| (|:| |ratpart| (|Fraction| UP))
                         (|:| |coeffs| #2=(|Vector| F))))
           (|List| (|Fraction| UP))))
         (|rde|
          (|Mapping|
           #3=(|List|
               (|Record| (|:| |ratpart| (|Fraction| UP))
                         (|:| |coeffs| (|Vector| F))))
           (|Fraction| UP) (|List| (|Fraction| UP))))
         (|csolve| (|Mapping| (|List| (|Vector| F)) (|Matrix| F)))
         ($ (|List| (|Record| (|:| |ratpart| R) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#4=#:G829 NIL) (|ai| NIL) (#5=#:G830 NIL) (|bv| NIL) (#6=#:G828 NIL)
          (|ca| (|List| R)) (|cb| (|List| #2#)) (|nca1| (|List| R))
          (#7=#:G827 NIL) (|be| NIL) (#8=#:G826 NIL) (|wi| (R))
          (|ncb1| (|List| #9=(|Vector| F))) (#10=#:G825 NIL) (#11=#:G824 NIL)
          (|res2| #3#) (|lup2| (|List| #12=(|Fraction| UP))) (#13=#:G823 NIL)
          (#14=#:G822 NIL) (|nca0| (|List| R)) (#15=#:G821 NIL)
          (#16=#:G820 NIL) (|ncb0| (|List| #9#)) (#17=#:G819 NIL)
          (#18=#:G818 NIL) (|res1| (|List| (|Vector| F)))
          (|llog2| (|List| #12#)) (#19=#:G817 NIL) (#20=#:G816 NIL)
          (|llog1| (|List| (|Fraction| UP))) (|lup1| (|List| (|Fraction| UP)))
          (|#G46|
           (|Record| (|:| |polypart| (|List| (|Fraction| UP)))
                     (|:| |logpart| (|List| (|Fraction| UP)))))
          (|llog0| (|List| #21=(|Fraction| UP))) (#22=#:G815 NIL) (|gv| NIL)
          (#23=#:G814 NIL) (|lup0| (|List| #21#)) (#24=#:G813 NIL) (|pv| NIL)
          (#25=#:G812 NIL) (|dmi| (|Fraction| UP)) (#26=#:G811 NIL) (|i| NIL)
          (#27=#:G810 NIL) (|be0| NIL) (#28=#:G809 NIL) (#29=#:G808 NIL)
          (#30=#:G807 NIL) (|res0| #1#) (|lrf| (|List| (|Fraction| UP)))
          (#31=#:G805 NIL) (#32=#:G806 NIL) (#33=#:G804 NIL))
         (SEQ
          (LETT |lrf|
                (PROGN
                 (LETT #33# NIL)
                 (SEQ (LETT |gv| NIL) (LETT #32# |lgv|) (LETT |pv| NIL)
                      (LETT #31# |lpv|) G190
                      (COND
                       ((OR (ATOM #31#) (PROGN (LETT |pv| (CAR #31#)) NIL)
                            (ATOM #32#) (PROGN (LETT |gv| (CAR #32#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #33#
                              (CONS
                               (SPADCALL (SPADCALL |pv| 1 (QREFELT $ 56))
                                         (SPADCALL |gv| 1 (QREFELT $ 56))
                                         (QREFELT $ 49))
                               #33#))))
                      (LETT #31# (PROG1 (CDR #31#) (LETT #32# (CDR #32#))))
                      (GO G190) G191 (EXIT (NREVERSE #33#)))))
          (LETT |res0| (SPADCALL |lrf| |ext|))
          (LETT |cb|
                (PROGN
                 (LETT #30# NIL)
                 (SEQ (LETT |be0| NIL) (LETT #29# |res0|) G190
                      (COND
                       ((OR (ATOM #29#) (PROGN (LETT |be0| (CAR #29#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #30# (CONS (QCDR |be0|) #30#))))
                      (LETT #29# (CDR #29#)) (GO G190) G191
                      (EXIT (NREVERSE #30#)))))
          (LETT |wi| (SPADCALL |w| 1 (QREFELT $ 58)))
          (LETT |ca|
                (PROGN
                 (LETT #28# NIL)
                 (SEQ (LETT |be0| NIL) (LETT #27# |res0|) G190
                      (COND
                       ((OR (ATOM #27#) (PROGN (LETT |be0| (CAR #27#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #28#
                              (CONS (SPADCALL (QCAR |be0|) |wi| (QREFELT $ 42))
                                    #28#))))
                      (LETT #27# (CDR #27#)) (GO G190) G191
                      (EXIT (NREVERSE #28#)))))
          (SEQ (LETT |i| 2) (LETT #26# (QVSIZE |w|)) G190
               (COND ((|greater_SI| |i| #26#) (GO G191)))
               (SEQ
                (LETT |dmi|
                      (SPADCALL (SPADCALL |dm| |i| |i| (QREFELT $ 60)) |dden|
                                (QREFELT $ 20)))
                (LETT |lup0|
                      (PROGN
                       (LETT #25# NIL)
                       (SEQ (LETT |pv| NIL) (LETT #24# |lpv|) G190
                            (COND
                             ((OR (ATOM #24#)
                                  (PROGN (LETT |pv| (CAR #24#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #25#
                                    (CONS (SPADCALL |pv| |i| (QREFELT $ 56))
                                          #25#))))
                            (LETT #24# (CDR #24#)) (GO G190) G191
                            (EXIT (NREVERSE #25#)))))
                (LETT |llog0|
                      (PROGN
                       (LETT #23# NIL)
                       (SEQ (LETT |gv| NIL) (LETT #22# |lgv|) G190
                            (COND
                             ((OR (ATOM #22#)
                                  (PROGN (LETT |gv| (CAR #22#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #23#
                                    (CONS (SPADCALL |gv| |i| (QREFELT $ 56))
                                          #23#))))
                            (LETT #22# (CDR #22#)) (GO G190) G191
                            (EXIT (NREVERSE #23#)))))
                (PROGN
                 (LETT |#G46|
                       (|INTALG2;split_logparts| |lup0| |llog0|
                        (SPADCALL |dmi| (QREFELT $ 44)) $))
                 (LETT |lup1| (QCAR |#G46|))
                 (LETT |llog1| (QCDR |#G46|))
                 |#G46|)
                (LETT |llog2|
                      (PROGN
                       (LETT #20# NIL)
                       (SEQ (LETT |bv| NIL) (LETT #19# |cb|) G190
                            (COND
                             ((OR (ATOM #19#)
                                  (PROGN (LETT |bv| (CAR #19#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #20#
                                    (CONS
                                     (SPADCALL |bv| |llog1| (QREFELT $ 63))
                                     #20#))))
                            (LETT #19# (CDR #19#)) (GO G190) G191
                            (EXIT (NREVERSE #20#)))))
                (LETT |res1| (SPADCALL |csolve| |llog2| (QREFELT $ 67)))
                (LETT |ncb0|
                      (PROGN
                       (LETT #18# NIL)
                       (SEQ (LETT |bv| NIL) (LETT #17# |res1|) G190
                            (COND
                             ((OR (ATOM #17#)
                                  (PROGN (LETT |bv| (CAR #17#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #18#
                                    (CONS (SPADCALL |bv| |cb| (QREFELT $ 68))
                                          #18#))))
                            (LETT #17# (CDR #17#)) (GO G190) G191
                            (EXIT (NREVERSE #18#)))))
                (LETT |nca0|
                      (PROGN
                       (LETT #16# NIL)
                       (SEQ (LETT |bv| NIL) (LETT #15# |res1|) G190
                            (COND
                             ((OR (ATOM #15#)
                                  (PROGN (LETT |bv| (CAR #15#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #16#
                                    (CONS (|INTALG2;lin_comb2| |bv| |ca| $)
                                          #16#))))
                            (LETT #15# (CDR #15#)) (GO G190) G191
                            (EXIT (NREVERSE #16#)))))
                (LETT |cb| |ncb0|) (LETT |ca| |nca0|)
                (LETT |lup2|
                      (PROGN
                       (LETT #14# NIL)
                       (SEQ (LETT |bv| NIL) (LETT #13# |cb|) G190
                            (COND
                             ((OR (ATOM #13#)
                                  (PROGN (LETT |bv| (CAR #13#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #14#
                                    (CONS (SPADCALL |bv| |lup1| (QREFELT $ 63))
                                          #14#))))
                            (LETT #13# (CDR #13#)) (GO G190) G191
                            (EXIT (NREVERSE #14#)))))
                (LETT |res2| (SPADCALL |dmi| |lup2| |rde|))
                (LETT |ncb1|
                      (PROGN
                       (LETT #11# NIL)
                       (SEQ (LETT |be| NIL) (LETT #10# |res2|) G190
                            (COND
                             ((OR (ATOM #10#)
                                  (PROGN (LETT |be| (CAR #10#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #11#
                                    (CONS
                                     (SPADCALL (QCDR |be|) |cb| (QREFELT $ 68))
                                     #11#))))
                            (LETT #10# (CDR #10#)) (GO G190) G191
                            (EXIT (NREVERSE #11#)))))
                (LETT |wi| (SPADCALL |w| |i| (QREFELT $ 58)))
                (LETT |nca1|
                      (PROGN
                       (LETT #8# NIL)
                       (SEQ (LETT |be| NIL) (LETT #7# |res2|) G190
                            (COND
                             ((OR (ATOM #7#) (PROGN (LETT |be| (CAR #7#)) NIL))
                              (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #8#
                                    (CONS
                                     (SPADCALL
                                      (SPADCALL (QCAR |be|) |wi|
                                                (QREFELT $ 42))
                                      (|INTALG2;lin_comb2| (QCDR |be|) |ca| $)
                                      (QREFELT $ 43))
                                     #8#))))
                            (LETT #7# (CDR #7#)) (GO G190) G191
                            (EXIT (NREVERSE #8#)))))
                (LETT |cb| |ncb1|) (EXIT (LETT |ca| |nca1|)))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (EXIT
           (PROGN
            (LETT #6# NIL)
            (SEQ (LETT |bv| NIL) (LETT #5# |cb|) (LETT |ai| NIL)
                 (LETT #4# |ca|) G190
                 (COND
                  ((OR (ATOM #4#) (PROGN (LETT |ai| (CAR #4#)) NIL) (ATOM #5#)
                       (PROGN (LETT |bv| (CAR #5#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #6#
                         (CONS
                          (CONS
                           (SPADCALL |ai| (|INTALG2;lin_comb2| |bv| |ca0| $)
                                     (QREFELT $ 69))
                           |bv|)
                          #6#))))
                 (LETT #4# (PROG1 (CDR #4#) (LETT #5# (CDR #5#)))) (GO G190)
                 G191 (EXIT (NREVERSE #6#)))))))) 

(SDEFUN |INTALG2;R_to_VQF| ((|p| (R)) ($ (|Vector| (|Fraction| UP))))
        (SPROG
         ((#1=#:G836 NIL) (|i| NIL) (|cden| (UP))
          (|res| (|Vector| (|Fraction| UP))) (|n| (|NonNegativeInteger|))
          (|numv| #2=(|Vector| UP))
          (|c| (|Record| (|:| |num| #2#) (|:| |den| UP))))
         (SEQ (LETT |c| (SPADCALL |p| (QREFELT $ 12))) (LETT |numv| (QCAR |c|))
              (LETT |n| (QVSIZE |numv|))
              (LETT |res| (MAKEARR1 |n| (|spadConstant| $ 14)))
              (LETT |cden| (QCDR |c|))
              (SEQ (LETT |i| 1) (LETT #1# |n|) G190
                   (COND ((|greater_SI| |i| #1#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SPADCALL |res| |i|
                               (SPADCALL (SPADCALL |numv| |i| (QREFELT $ 70))
                                         |cden| (QREFELT $ 20))
                               (QREFELT $ 71))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT |res|)))) 

(SDEFUN |INTALG2;algprimextint|
        ((|der| (|Mapping| UP UP))
         (|ext|
          (|Mapping|
           (|List|
            (|Record| (|:| |ratpart| (|Fraction| UP))
                      (|:| |coeffs| (|Vector| F))))
           (|List| (|Fraction| UP))))
         (|rde|
          (|Mapping|
           (|List|
            (|Record| (|:| |ratpart| (|Fraction| UP))
                      (|:| |coeffs| (|Vector| F))))
           (|Fraction| UP) (|List| (|Fraction| UP))))
         (|csolve| (|Mapping| (|List| (|Vector| F)) (|Matrix| F)))
         (|lg| (|List| R))
         ($ (|List| (|Record| (|:| |ratpart| R) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((|ca0| (|List| R)) (#1=#:G858 NIL) (|h| NIL) (#2=#:G857 NIL)
          (|dden| (UP))
          (|dm| (|Record| (|:| |num| (|Matrix| UP)) (|:| |den| UP)))
          (|w| (|Vector| R)) (|lgv| (|List| (|Vector| (|Fraction| UP))))
          (|lpv| (|List| (|Vector| (|Fraction| UP)))) (#3=#:G856 NIL)
          (|lh|
           (|List|
            (|Record| (|:| |answer| R) (|:| |logpart| R) (|:| |polypart| R))))
          (|hermite1|
           (|Mapping|
            (|Record| (|:| |answer| R) (|:| |logpart| R) (|:| |polypart| R))
            R)))
         (SEQ
          (LETT |hermite1| (CONS #'|INTALG2;algprimextint!0| (VECTOR $ |der|)))
          (LETT |lh| (|INTALG2;list_hermite| |lg| |hermite1| $))
          (LETT |lpv| NIL) (LETT |lgv| NIL)
          (SEQ (LETT |h| NIL) (LETT #3# |lh|) G190
               (COND
                ((OR (ATOM #3#) (PROGN (LETT |h| (CAR #3#)) NIL)) (GO G191)))
               (SEQ
                (LETT |lpv| (CONS (|INTALG2;R_to_VQF| (QVELT |h| 2) $) |lpv|))
                (EXIT
                 (LETT |lgv|
                       (CONS (|INTALG2;R_to_VQF| (QVELT |h| 1) $) |lgv|))))
               (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
          (LETT |lpv| (NREVERSE |lpv|)) (LETT |lgv| (NREVERSE |lgv|))
          (LETT |w| (SPADCALL (QREFELT $ 26)))
          (LETT |dm| (SPADCALL |der| (QREFELT $ 73))) (LETT |dden| (QCDR |dm|))
          (LETT |ca0|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |h| NIL) (LETT #1# |lh|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |h| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS (QVELT |h| 0) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (COND
           ((SPADCALL (SPADCALL |w| 1 (QREFELT $ 58)) (|spadConstant| $ 74)
                      (QREFELT $ 75))
            (COND
             ((SPADCALL (QCAR |dm|) (QREFELT $ 76))
              (EXIT
               (|INTALG2;diagextint| |dden| (QCAR |dm|) |w| |lpv| |lgv| |ca0|
                |ext| |rde| |csolve| $))))))
          (EXIT (|error| "algprimextint: non-root case unimplemented"))))) 

(SDEFUN |INTALG2;algprimextint!0| ((|g| NIL) ($$ NIL))
        (PROG (|der| $)
          (LETT |der| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|INTALG2;prim_hermite1| |g| |der| $))))) 

(SDEFUN |INTALG2;algexpextint|
        ((|der| (|Mapping| UP UP))
         (|ext|
          (|Mapping|
           (|List|
            (|Record| (|:| |ratpart| (|Fraction| UP))
                      (|:| |coeffs| (|Vector| F))))
           (|List| (|Fraction| UP))))
         (|rde|
          (|Mapping|
           (|List|
            (|Record| (|:| |ratpart| (|Fraction| UP))
                      (|:| |coeffs| (|Vector| F))))
           (|Fraction| UP) (|List| (|Fraction| UP))))
         (|csolve| (|Mapping| (|List| (|Vector| F)) (|Matrix| F)))
         (|lg| (|List| R))
         ($ (|List| (|Record| (|:| |ratpart| R) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((|ca0| (|List| R)) (#1=#:G880 NIL) (|h| NIL) (#2=#:G879 NIL)
          (|dden| (UP))
          (|dm| (|Record| (|:| |num| (|Matrix| UP)) (|:| |den| UP)))
          (|lgv| (|List| (|Vector| (|Fraction| UP))))
          (|lpv| (|List| (|Vector| (|Fraction| UP)))) (#3=#:G878 NIL)
          (|w| (|Vector| R))
          (|lh|
           (|List|
            (|Record| (|:| |answer| R) (|:| |logpart| R) (|:| |polypart| R))))
          (|hermite1|
           (|Mapping|
            (|Record| (|:| |answer| R) (|:| |logpart| R) (|:| |polypart| R))
            R)))
         (SEQ
          (LETT |hermite1| (CONS #'|INTALG2;algexpextint!0| (VECTOR $ |der|)))
          (LETT |lh| (|INTALG2;list_hermite| |lg| |hermite1| $))
          (LETT |lpv| NIL) (LETT |lgv| NIL)
          (LETT |w| (SPADCALL (QREFELT $ 26)))
          (SEQ (LETT |h| NIL) (LETT #3# |lh|) G190
               (COND
                ((OR (ATOM #3#) (PROGN (LETT |h| (CAR #3#)) NIL)) (GO G191)))
               (SEQ
                (LETT |lpv| (CONS (|INTALG2;R_to_VQF| (QVELT |h| 2) $) |lpv|))
                (EXIT
                 (LETT |lgv|
                       (CONS (|INTALG2;R_to_VQF| (QVELT |h| 1) $) |lgv|))))
               (LETT #3# (CDR #3#)) (GO G190) G191 (EXIT NIL))
          (LETT |lpv| (NREVERSE |lpv|)) (LETT |lgv| (NREVERSE |lgv|))
          (LETT |dm| (SPADCALL |der| (QREFELT $ 73))) (LETT |dden| (QCDR |dm|))
          (LETT |ca0|
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |h| NIL) (LETT #1# |lh|) G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |h| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #2# (CONS (QVELT |h| 0) #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#)))))
          (COND
           ((SPADCALL (SPADCALL |w| 1 (QREFELT $ 58)) (|spadConstant| $ 74)
                      (QREFELT $ 75))
            (COND
             ((SPADCALL (QCAR |dm|) (QREFELT $ 76))
              (EXIT
               (|INTALG2;diagextint| |dden| (QCAR |dm|) |w| |lpv| |lgv| |ca0|
                |ext| |rde| |csolve| $))))))
          (EXIT (|error| "algexpextint: non-root case unimplemented"))))) 

(SDEFUN |INTALG2;algexpextint!0| ((|g| NIL) ($$ NIL))
        (PROG (|der| $)
          (LETT |der| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|INTALG2;exp_hermite1| |g| |der| $))))) 

(SDEFUN |INTALG2;algextint_base;MMLL;11|
        ((|der| (|Mapping| UP UP))
         (|csolve| (|Mapping| (|List| (|Vector| F)) (|Matrix| F)))
         (|lg| (|List| R))
         ($ (|List| (|Record| (|:| |ratpart| R) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G900 NIL) (|bv| NIL) (#2=#:G899 NIL) (|ca0| (|List| R))
          (#3=#:G898 NIL) (|h| NIL) (#4=#:G897 NIL)
          (|res1| (|List| (|Vector| F))) (|rs1| (|Matrix| (|Fraction| UP)))
          (|lg1| (|List| R)) (#5=#:G896 NIL) (#6=#:G895 NIL)
          (|lh|
           (|List|
            (|Record| (|:| |answer| R) (|:| |logpart| R) (|:| |polypart| R))))
          (|hermite1|
           (|Mapping|
            (|Record| (|:| |answer| R) (|:| |logpart| R) (|:| |polypart| R))
            R)))
         (SEQ
          (LETT |hermite1|
                (CONS #'|INTALG2;algextint_base;MMLL;11!0| (VECTOR $ |der|)))
          (LETT |lh| (|INTALG2;list_hermite| |lg| |hermite1| $))
          (LETT |lg1|
                (PROGN
                 (LETT #6# NIL)
                 (SEQ (LETT |h| NIL) (LETT #5# |lh|) G190
                      (COND
                       ((OR (ATOM #5#) (PROGN (LETT |h| (CAR #5#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #6#
                              (CONS
                               (SPADCALL (QVELT |h| 1) (QVELT |h| 2)
                                         (QREFELT $ 43))
                               #6#))))
                      (LETT #5# (CDR #5#)) (GO G190) G191
                      (EXIT (NREVERSE #6#)))))
          (LETT |rs1|
                (SPADCALL (SPADCALL (LIST |lg1|) (QREFELT $ 79))
                          (QREFELT $ 82)))
          (LETT |res1| (SPADCALL |csolve| |rs1| (QREFELT $ 83)))
          (LETT |ca0|
                (PROGN
                 (LETT #4# NIL)
                 (SEQ (LETT |h| NIL) (LETT #3# |lh|) G190
                      (COND
                       ((OR (ATOM #3#) (PROGN (LETT |h| (CAR #3#)) NIL))
                        (GO G191)))
                      (SEQ (EXIT (LETT #4# (CONS (QVELT |h| 0) #4#))))
                      (LETT #3# (CDR #3#)) (GO G190) G191
                      (EXIT (NREVERSE #4#)))))
          (EXIT
           (PROGN
            (LETT #2# NIL)
            (SEQ (LETT |bv| NIL) (LETT #1# |res1|) G190
                 (COND
                  ((OR (ATOM #1#) (PROGN (LETT |bv| (CAR #1#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #2#
                         (CONS
                          (CONS
                           (SPADCALL (|INTALG2;lin_comb2| |bv| |ca0| $)
                                     (QREFELT $ 84))
                           |bv|)
                          #2#))))
                 (LETT #1# (CDR #1#)) (GO G190) G191 (EXIT (NREVERSE #2#)))))))) 

(SDEFUN |INTALG2;algextint_base;MMLL;11!0| ((|g| NIL) ($$ NIL))
        (PROG (|der| $)
          (LETT |der| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (|INTALG2;prim_hermite1| |g| |der| $))))) 

(SDEFUN |INTALG2;algextint;MMMMLL;12|
        ((|der| (|Mapping| UP UP))
         (|ext|
          (|Mapping|
           (|List|
            (|Record| (|:| |ratpart| (|Fraction| UP))
                      (|:| |coeffs| (|Vector| F))))
           (|List| (|Fraction| UP))))
         (|rde|
          (|Mapping|
           (|List|
            (|Record| (|:| |ratpart| (|Fraction| UP))
                      (|:| |coeffs| (|Vector| F))))
           (|Fraction| UP) (|List| (|Fraction| UP))))
         (|csolve| (|Mapping| (|List| (|Vector| F)) (|Matrix| F)))
         (|lg| (|List| R))
         ($ (|List| (|Record| (|:| |ratpart| R) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G926 NIL) (|xx| (|Union| UP "failed")) (|x'| (UP)) (|x| (UP)))
         (SEQ
          (LETT |x'|
                (SPADCALL
                 (LETT |x| (SPADCALL (|spadConstant| $ 55) 1 (QREFELT $ 90)))
                 |der|))
          (EXIT
           (COND
            ((ZEROP (SPADCALL |x'| (QREFELT $ 91)))
             (|INTALG2;algprimextint| |der| |ext| |rde| |csolve| |lg| $))
            ('T
             (SEQ
              (EXIT
               (SEQ
                (SEQ (LETT |xx| (SPADCALL |x'| |x| (QREFELT $ 48)))
                     (EXIT
                      (COND
                       ((QEQCAR |xx| 0)
                        (COND
                         ((QEQCAR (SPADCALL (QCDR |xx|) (QREFELT $ 93)) 0)
                          (PROGN
                           (LETT #1#
                                 (|INTALG2;algexpextint| |der| |ext| |rde|
                                  |csolve| |lg| $))
                           (GO #2=#:G920))))))))
                (EXIT (|error| "algextint: unhandled case"))))
              #2# (EXIT #1#)))))))) 

(DECLAIM (NOTINLINE |AlgebraicIntegrate2;|)) 

(DEFUN |AlgebraicIntegrate2| (&REST #1=#:G927)
  (SPROG NIL
         (PROG (#2=#:G928)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|AlgebraicIntegrate2|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (APPLY (|function| |AlgebraicIntegrate2;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache| '|AlgebraicIntegrate2|)))))))))) 

(DEFUN |AlgebraicIntegrate2;| (|#1| |#2| |#3| |#4| |#5|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$5 NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT DV$5 (|devaluate| |#5|))
    (LETT |dv$| (LIST '|AlgebraicIntegrate2| DV$1 DV$2 DV$3 DV$4 DV$5))
    (LETT $ (GETREFV 98))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
    (|haddProp| |$ConstructorCache| '|AlgebraicIntegrate2|
                (LIST DV$1 DV$2 DV$3 DV$4 DV$5) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (QSETREFV $ 10 |#5|)
    (SETF |pv$| (QREFELT $ 3))
    $))) 

(MAKEPROP '|AlgebraicIntegrate2| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|local| |#5|)
              (|Record| (|:| |num| 18) (|:| |den| 8))
              (0 . |integralCoordinates|) (|Fraction| 8) (5 . |Zero|)
              (9 . |Zero|) (13 . |Zero|) (|Integer|) (|Vector| 8)
              (17 . |minIndex|) (22 . /)
              (|Record| (|:| |polyPart| $) (|:| |fracPart| 13))
              (|LaurentPolynomial| 7 8) (28 . |separate|) (33 . |convert|)
              (|Vector| $) (38 . |integralBasis|) (|Vector| 13)
              (42 . |represents|)
              (|Record| (|:| |answer| 10) (|:| |logpart| 10)) (|Mapping| 8 8)
              (|AlgebraicHermiteIntegration| 7 8 9 10)
              (48 . |HermiteIntegrate|) (|Boolean|) (54 . |zero?|)
              (59 . |Zero|) (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (63 . |divide|) (69 . |coerce|) (|Vector| 7) (74 . |elt|)
              (80 . |coerce|) (85 . *) (91 . +) (97 . |denom|) (102 . |gcd|)
              (108 . |ground?|) (|Union| $ '"failed") (113 . |exquo|) (119 . +)
              (125 . |numer|) (|Record| (|:| |coef1| $) (|:| |coef2| $))
              (|Union| 51 '"failed") (130 . |extendedEuclidean|) (137 . |One|)
              (141 . |One|) (145 . |elt|) (|Vector| 10) (151 . |elt|)
              (|Matrix| 8) (157 . |elt|) (|List| 13)
              (|LinearCombinationUtilities| 7 8) (164 . |lin_comb|) (|List| 39)
              (|Mapping| 64 (|Matrix| 7)) (|LiftLinearDependence| 7 7 8)
              (170 . |csolve_rf|) (176 . |lin_comb|) (182 . -) (188 . |elt|)
              (194 . |setelt!|) (|Record| (|:| |num| 59) (|:| |den| 8))
              (201 . |integralDerivationMatrix|) (206 . |One|) (210 . =)
              (216 . |diagonal?|) (|List| 87) (|Matrix| 10) (221 . |matrix|)
              (|Matrix| 13) (|Matrix| $) (226 . |reducedSystem|)
              (231 . |csolve_rmat|) (237 . -)
              (|Record| (|:| |ratpart| 10) (|:| |coeffs| 39)) (|List| 85)
              (|List| 10) |INTALG2;algextint_base;MMLL;11|
              (|NonNegativeInteger|) (242 . |monomial|) (248 . |degree|)
              (|Union| 7 '"failed") (253 . |retractIfCan|)
              (|Record| (|:| |ratpart| 13) (|:| |coeffs| 39))
              (|Mapping| (|List| 94) 61) (|Mapping| (|List| 94) 13 61)
              |INTALG2;algextint;MMMMLL;12|)
           '#(|algextint_base| 258 |algextint| 265) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|algextint|
                                 ((|List|
                                   (|Record| (|:| |ratpart| |#5|)
                                             (|:| |coeffs| (|Vector| |#2|))))
                                  (|Mapping| |#3| |#3|)
                                  (|Mapping|
                                   (|List|
                                    (|Record| (|:| |ratpart| (|Fraction| |#3|))
                                              (|:| |coeffs| (|Vector| |#2|))))
                                   (|List| (|Fraction| |#3|)))
                                  (|Mapping|
                                   (|List|
                                    (|Record| (|:| |ratpart| (|Fraction| |#3|))
                                              (|:| |coeffs| (|Vector| |#2|))))
                                   (|Fraction| |#3|)
                                   (|List| (|Fraction| |#3|)))
                                  (|Mapping| (|List| (|Vector| |#2|))
                                             (|Matrix| |#2|))
                                  (|List| |#5|)))
                                T)
                              '((|algextint_base|
                                 ((|List|
                                   (|Record| (|:| |ratpart| |#5|)
                                             (|:| |coeffs| (|Vector| |#2|))))
                                  (|Mapping| |#3| |#3|)
                                  (|Mapping| (|List| (|Vector| |#2|))
                                             (|Matrix| |#2|))
                                  (|List| |#5|)))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 97
                                            '(1 10 11 0 12 0 13 0 14 0 6 0 15 0
                                              7 0 16 1 18 17 0 19 2 13 0 8 8 20
                                              1 22 21 13 23 1 22 13 0 24 0 10
                                              25 26 2 10 0 27 25 28 2 31 29 10
                                              30 32 1 10 33 0 34 0 10 0 35 2 8
                                              36 0 0 37 1 13 0 8 38 2 39 7 0 17
                                              40 1 8 0 7 41 2 10 0 13 0 42 2 10
                                              0 0 0 43 1 13 8 0 44 2 8 0 0 0 45
                                              1 8 33 0 46 2 8 47 0 0 48 2 13 0
                                              0 0 49 1 13 8 0 50 3 8 52 0 0 0
                                              53 0 6 0 54 0 7 0 55 2 27 13 0 17
                                              56 2 57 10 0 17 58 3 59 8 0 17 17
                                              60 2 62 13 39 61 63 2 66 64 65 61
                                              67 2 62 39 39 64 68 2 10 0 0 0 69
                                              2 18 8 0 17 70 3 27 13 0 17 13 71
                                              1 10 72 30 73 0 10 0 74 2 10 33 0
                                              0 75 1 59 33 0 76 1 78 0 77 79 1
                                              10 80 81 82 2 66 64 65 80 83 1 10
                                              0 0 84 2 8 0 7 89 90 1 8 89 0 91
                                              1 8 92 0 93 3 0 86 30 65 87 88 5
                                              0 86 30 95 96 65 87 97)))))
           '|lookupComplete|)) 
