
(SDEFUN |MHROWRED;nonzero?| ((|v| (|Vector| R)) ($ (|Boolean|)))
        (SPADCALL (CONS #'|MHROWRED;nonzero?!0| $) |v| (QREFELT $ 12))) 

(SDEFUN |MHROWRED;nonzero?!0| ((|s| NIL) ($ NIL))
        (SPADCALL |s| (|spadConstant| $ 7) (QREFELT $ 9))) 

(SDEFUN |MHROWRED;non0|
        ((|v| (|Vector| R)) (|rown| (|Integer|))
         ($
          (|Union|
           #1=(|Record| (|:| |val| R) (|:| |cl| (|Integer|))
                        (|:| |rw| (|Integer|)))
           "failed")))
        (SPROG
         ((#2=#:G729 NIL) (|ans| #1#) (|allZero| (|Boolean|)) (#3=#:G730 NIL)
          (|i| NIL))
         (SEQ
          (EXIT
           (SEQ (LETT |allZero| 'T)
                (SEQ (LETT |i| (SPADCALL |v| (QREFELT $ 14)))
                     (LETT #3# (QVSIZE |v|)) G190
                     (COND ((> |i| #3#) (GO G191)))
                     (SEQ
                      (EXIT
                       (COND
                        ((SPADCALL (QAREF1O |v| |i| 1) (|spadConstant| $ 7)
                                   (QREFELT $ 9))
                         (COND
                          (|allZero|
                           (SEQ (LETT |allZero| NIL)
                                (EXIT
                                 (LETT |ans|
                                       (VECTOR (QAREF1O |v| |i| 1) |i|
                                               |rown|)))))
                          ('T
                           (PROGN
                            (LETT #2# (CONS 1 "failed"))
                            (GO #4=#:G728))))))))
                     (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL))
                (EXIT
                 (COND (|allZero| (CONS 1 "failed")) ('T (CONS 0 |ans|))))))
          #4# (EXIT #2#)))) 

(SDEFUN |MHROWRED;mkMat|
        ((|x| (|Matrix| R)) (|l| (|List| (|Integer|))) ($ (|Matrix| R)))
        (SPROG
         ((|ll| (|List| (|List| R))) (#1=#:G760 NIL) (|i| NIL) (#2=#:G759 NIL))
         (SEQ
          (COND
           ((NULL
             (LETT |ll|
                   (PROGN
                    (LETT #2# NIL)
                    (SEQ (LETT |i| (PROGN |x| 1))
                         (LETT #1# (SPADCALL |x| (QREFELT $ 16))) G190
                         (COND ((> |i| #1#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((COND ((SPADCALL |i| |l| (QREFELT $ 18)) NIL)
                                   (#3='T
                                    (|MHROWRED;nonzero?|
                                     (SPADCALL |x| |i| (QREFELT $ 19)) $)))
                             (LETT #2#
                                   (CONS
                                    (SPADCALL (SPADCALL |x| |i| (QREFELT $ 19))
                                              (QREFELT $ 21))
                                    #2#))))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191
                         (EXIT (NREVERSE #2#))))))
            (SPADCALL 1 (ANCOLS |x|) (QREFELT $ 24)))
           (#3# (SPADCALL |ll| (QREFELT $ 26))))))) 

(SDEFUN |MHROWRED;diagSubMatrix|
        ((|x| (|Matrix| R))
         ($
          (|Union| (|Record| (|:| |val| R) (|:| |mat| (|Matrix| R)))
                   "failed")))
        (SPROG
         ((#1=#:G846 NIL) (#2=#:G847 NIL) (#3=#:G858 NIL) (|r| NIL)
          (#4=#:G857 NIL) (#5=#:G856 NIL) (|z| NIL) (#6=#:G855 NIL)
          (#7=#:G854 NIL) (#8=#:G853 NIL) (#9=#:G850 NIL) (#10=#:G852 NIL)
          (#11=#:G851 NIL) (|a| NIL)
          (|l|
           (|List|
            (|Record| (|:| |val| R) (|:| |cl| (|Integer|))
                      (|:| |rw| (|Integer|)))))
          (#12=#:G768 NIL)
          (|u|
           (|Union|
            (|Record| (|:| |val| R) (|:| |cl| (|Integer|))
                      (|:| |rw| (|Integer|)))
            #13="failed"))
          (#14=#:G849 NIL) (|i| NIL) (#15=#:G848 NIL))
         (SEQ
          (EXIT
           (SEQ
            (LETT |l|
                  (PROGN
                   (LETT #15# NIL)
                   (SEQ (LETT |i| (PROGN |x| 1))
                        (LETT #14# (SPADCALL |x| (QREFELT $ 16))) G190
                        (COND ((> |i| #14#) (GO G191)))
                        (SEQ
                         (EXIT
                          (COND
                           ((QEQCAR
                             (LETT |u|
                                   (|MHROWRED;non0|
                                    (SPADCALL |x| |i| (QREFELT $ 19)) |i| $))
                             0)
                            (LETT #15#
                                  (CONS
                                   (PROG2 (LETT #12# |u|)
                                       (QCDR #12#)
                                     (|check_union2| (QEQCAR #12# 0)
                                                     (|Record|
                                                      (|:| |val| (QREFELT $ 6))
                                                      (|:| |cl| (|Integer|))
                                                      (|:| |rw| (|Integer|)))
                                                     (|Union|
                                                      (|Record|
                                                       (|:| |val|
                                                            (QREFELT $ 6))
                                                       (|:| |cl| (|Integer|))
                                                       (|:| |rw| (|Integer|)))
                                                      #13#)
                                                     #12#))
                                   #15#))))))
                        (LETT |i| (+ |i| 1)) (GO G190) G191
                        (EXIT (NREVERSE #15#)))))
            (SEQ
             (EXIT
              (SEQ (LETT |a| NIL)
                   (LETT #9#
                         (SPADCALL
                          (PROGN
                           (LETT #11# NIL)
                           (SEQ (LETT |r| NIL) (LETT #10# |l|) G190
                                (COND
                                 ((OR (ATOM #10#)
                                      (PROGN (LETT |r| (CAR #10#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT (LETT #11# (CONS (QVELT |r| 0) #11#))))
                                (LETT #10# (CDR #10#)) (GO G190) G191
                                (EXIT (NREVERSE #11#))))
                          (QREFELT $ 27)))
                   G190
                   (COND
                    ((OR (ATOM #9#) (PROGN (LETT |a| (CAR #9#)) NIL))
                     (GO G191)))
                   (SEQ
                    (EXIT
                     (COND
                      ((SPADCALL
                        (SPADCALL
                         (PROGN
                          (LETT #8# NIL)
                          (SEQ (LETT |r| NIL) (LETT #7# |l|) G190
                               (COND
                                ((OR (ATOM #7#)
                                     (PROGN (LETT |r| (CAR #7#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((SPADCALL (QVELT |r| 0) |a| (QREFELT $ 28))
                                   (LETT #8# (CONS (QVELT |r| 1) #8#))))))
                               (LETT #7# (CDR #7#)) (GO G190) G191
                               (EXIT (NREVERSE #8#))))
                         (QREFELT $ 30))
                        (SPADCALL
                         (PROGN
                          (LETT #6# NIL)
                          (SEQ (LETT |z| (PROGN |x| 1))
                               (LETT #5# (SPADCALL |x| (QREFELT $ 31))) G190
                               (COND ((> |z| #5#) (GO G191)))
                               (SEQ (EXIT (LETT #6# (CONS |z| #6#))))
                               (LETT |z| (+ |z| 1)) (GO G190) G191
                               (EXIT (NREVERSE #6#))))
                         (QREFELT $ 30))
                        (QREFELT $ 32))
                       (PROGN
                        (LETT #1#
                              (PROGN
                               (LETT #2#
                                     (CONS 0
                                           (CONS |a|
                                                 (|MHROWRED;mkMat| |x|
                                                  (PROGN
                                                   (LETT #4# NIL)
                                                   (SEQ (LETT |r| NIL)
                                                        (LETT #3# |l|) G190
                                                        (COND
                                                         ((OR (ATOM #3#)
                                                              (PROGN
                                                               (LETT |r|
                                                                     (CAR #3#))
                                                               NIL))
                                                          (GO G191)))
                                                        (SEQ
                                                         (EXIT
                                                          (COND
                                                           ((SPADCALL |a|
                                                                      (QVELT
                                                                       |r| 0)
                                                                      (QREFELT
                                                                       $ 28))
                                                            (LETT #4#
                                                                  (CONS
                                                                   (QVELT |r|
                                                                          2)
                                                                   #4#))))))
                                                        (LETT #3# (CDR #3#))
                                                        (GO G190) G191
                                                        (EXIT (NREVERSE #4#))))
                                                  $))))
                               (GO #16=#:G845)))
                        (GO #17=#:G843))))))
                   (LETT #9# (CDR #9#)) (GO G190) G191 (EXIT NIL)))
             #17# (EXIT #1#))
            (EXIT (CONS 1 "failed"))))
          #16# (EXIT #2#)))) 

(SDEFUN |MHROWRED;determinantOfMinor| ((|x| (|Matrix| R)) ($ (R)))
        (SPROG
         ((#1=#:G870 NIL) (#2=#:G871 NIL) (|j| (|Integer|)) (|d| (R))
          (#3=#:G876 NIL) (|n| (|Integer|)) (|i| NIL)
          (|lr| (|List| (|Integer|))) (#4=#:G875 NIL) (#5=#:G874 NIL)
          (|lc| (|List| (|Integer|))) (#6=#:G873 NIL) (#7=#:G872 NIL)
          (|nc| (|NonNegativeInteger|)) (|nr| (|NonNegativeInteger|)))
         (SEQ
          (EXIT
           (SEQ (LETT |nr| (ANROWS |x|)) (LETT |nc| (ANCOLS |x|))
                (EXIT
                 (COND ((<= |nr| |nc|) (|spadConstant| $ 7))
                       ('T
                        (SEQ
                         (LETT |lc|
                               (PROGN
                                (LETT #7# NIL)
                                (SEQ (LETT |i| (PROGN |x| 1))
                                     (LETT #6# (SPADCALL |x| (QREFELT $ 31)))
                                     G190 (COND ((> |i| #6#) (GO G191)))
                                     (SEQ (EXIT (LETT #7# (CONS |i| #7#))))
                                     (LETT |i| (+ |i| 1)) (GO G190) G191
                                     (EXIT (NREVERSE #7#)))))
                         (LETT |lr|
                               (PROGN
                                (LETT #5# NIL)
                                (SEQ (LETT |i| (PROGN |x| 1))
                                     (LETT #4# (SPADCALL |x| (QREFELT $ 16)))
                                     G190 (COND ((> |i| #4#) (GO G191)))
                                     (SEQ (EXIT (LETT #5# (CONS |i| #5#))))
                                     (LETT |i| (+ |i| 1)) (GO G190) G191
                                     (EXIT (NREVERSE #5#)))))
                         (SEQ
                          (EXIT
                           (SEQ (LETT |i| 1)
                                (LETT #3#
                                      (LETT |n|
                                            (SPADCALL |nr| |nc|
                                                      (QREFELT $ 33))))
                                G190 (COND ((|greater_SI| |i| #3#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (COND
                                   ((SPADCALL
                                     (LETT |d|
                                           (SPADCALL
                                            (SPADCALL |x|
                                                      (|MHROWRED;enumerateBinomial|
                                                       |lr| |nc| |i| $)
                                                      |lc| (QREFELT $ 34))
                                            (QREFELT $ 35)))
                                     (|spadConstant| $ 7) (QREFELT $ 9))
                                    (PROGN
                                     (LETT #1#
                                           (SEQ
                                            (LETT |j|
                                                  (+ (+ |i| 1)
                                                     (RANDOM (- |n| |i|))))
                                            (EXIT
                                             (PROGN
                                              (LETT #2#
                                                    (SPADCALL |d|
                                                              (SPADCALL
                                                               (SPADCALL |x|
                                                                         (|MHROWRED;enumerateBinomial|
                                                                          |lr|
                                                                          |nc|
                                                                          |j|
                                                                          $)
                                                                         |lc|
                                                                         (QREFELT
                                                                          $
                                                                          34))
                                                               (QREFELT $ 35))
                                                              (QREFELT $ 36)))
                                              (GO #8=#:G869)))))
                                     (GO #9=#:G866))))))
                                (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                (EXIT NIL)))
                          #9# (EXIT #1#))
                         (EXIT (|spadConstant| $ 7))))))))
          #8# (EXIT #2#)))) 

(SDEFUN |MHROWRED;enumerateBinomial|
        ((|l| (|List| (|Integer|))) (|m| (|Integer|)) (|i| (|Integer|))
         ($ (|List| (|Integer|))))
        (SPROG
         ((#1=#:G891 NIL) (|b| (|Integer|)) (#2=#:G892 NIL) (|n| (|Integer|))
          (|j| NIL) (|m1| (|Integer|)))
         (SEQ
          (EXIT
           (SEQ (LETT |m1| (- (PROGN |l| 1) 1))
                (EXIT
                 (COND
                  ((ZEROP (LETT |m| (- |m| 1)))
                   (LIST (SPADCALL |l| (+ |m1| |i|) (QREFELT $ 37))))
                  ('T
                   (SEQ
                    (SEQ (LETT |j| 1) (LETT #2# (LETT |n| (LENGTH |l|))) G190
                         (COND ((|greater_SI| |j| #2#) (GO G191)))
                         (SEQ
                          (LETT |b| (SPADCALL (- |n| |j|) |m| (QREFELT $ 33)))
                          (EXIT
                           (COND
                            ((<= |i| |b|)
                             (PROGN
                              (LETT #1#
                                    (CONS
                                     (SPADCALL |l| (+ |m1| |j|) (QREFELT $ 37))
                                     (|MHROWRED;enumerateBinomial|
                                      (SPADCALL |l| |j| (QREFELT $ 38)) |m| |i|
                                      $)))
                              (GO #3=#:G890)))
                            ('T (LETT |i| (- |i| |b|))))))
                         (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                    (EXIT (|error| "Should not happen"))))))))
          #3# (EXIT #1#)))) 

(SDEFUN |MHROWRED;rowEch;2M;7| ((|x| (|Matrix| R)) ($ (|Matrix| R)))
        (SPROG
         ((|d| (R))
          (|u|
           (|Union| (|Record| (|:| |val| R) (|:| |mat| (|Matrix| R)))
                    "failed")))
         (SEQ (LETT |u| (|MHROWRED;diagSubMatrix| |x| $))
              (EXIT
               (COND
                ((QEQCAR |u| 1)
                 (COND
                  ((SPADCALL (LETT |d| (|MHROWRED;determinantOfMinor| |x| $))
                             (QREFELT $ 39))
                   (SPADCALL |x| (QREFELT $ 40)))
                  (#1='T (|MHROWRED;rowEchelon1| |x| |d| $))))
                (#1#
                 (SPADCALL (QCDR (QCDR |u|)) (QCAR (QCDR |u|))
                           (QREFELT $ 41)))))))) 

(SDEFUN |MHROWRED;vconc| ((|y| (|Matrix| R)) (|m| (R)) ($ (|Matrix| R)))
        (SPROG NIL
               (SPADCALL (SPADCALL (MAKEARR1 (ANCOLS |y|) |m|) (QREFELT $ 43))
                         (SPADCALL (CONS #'|MHROWRED;vconc!0| (VECTOR $ |m|))
                                   |y| (QREFELT $ 46))
                         (QREFELT $ 47)))) 

(SDEFUN |MHROWRED;vconc!0| ((|s| NIL) ($$ NIL))
        (PROG (|m| $)
          (LETT |m| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |s| |m| (QREFELT $ 44)))))) 

(SDEFUN |MHROWRED;order| ((|m| (R)) (|p| (R)) ($ (|Integer|)))
        (SPROG ((#1=#:G910 NIL) (|mm| (|Union| R "failed")) (|i| NIL))
               (SEQ
                (EXIT
                 (COND ((SPADCALL |m| (QREFELT $ 39)) -1)
                       ('T
                        (SEQ (LETT |i| 0) G190 NIL
                             (SEQ (LETT |mm| (SPADCALL |m| |p| (QREFELT $ 49)))
                                  (EXIT
                                   (COND
                                    ((QEQCAR |mm| 1)
                                     (PROGN (LETT #1# |i|) (GO #2=#:G909)))
                                    ('T (LETT |m| (QCDR |mm|))))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL)))))
                #2# (EXIT #1#)))) 

(SDEFUN |MHROWRED;normalizedDivide;2RR;10|
        ((|n| (R)) (|d| (R))
         ($ (|Record| (|:| |quotient| R) (|:| |remainder| R))))
        (SPROG ((|qr| (|Record| (|:| |quotient| R) (|:| |remainder| R))))
               (SEQ (LETT |qr| (SPADCALL |n| |d| (QREFELT $ 51)))
                    (EXIT
                     (COND
                      ((SPADCALL (QCDR |qr|) (|spadConstant| $ 7)
                                 (QREFELT $ 52))
                       |qr|)
                      ((SPADCALL |d| (|spadConstant| $ 7) (QREFELT $ 53))
                       (SEQ
                        (PROGN
                         (RPLACD |qr|
                                 (SPADCALL (QCDR |qr|) |d| (QREFELT $ 54)))
                         (QCDR |qr|))
                        (PROGN
                         (RPLACA |qr|
                                 (SPADCALL (QCAR |qr|) (|spadConstant| $ 22)
                                           (QREFELT $ 55)))
                         (QCAR |qr|))
                        (EXIT |qr|)))
                      ('T
                       (SEQ
                        (PROGN
                         (RPLACD |qr|
                                 (SPADCALL (QCDR |qr|) |d| (QREFELT $ 55)))
                         (QCDR |qr|))
                        (PROGN
                         (RPLACA |qr|
                                 (SPADCALL (QCAR |qr|) (|spadConstant| $ 22)
                                           (QREFELT $ 54)))
                         (QCAR |qr|))
                        (EXIT |qr|)))))))) 

(SDEFUN |MHROWRED;normalizedDivide;2RR;11|
        ((|n| (R)) (|d| (R))
         ($ (|Record| (|:| |quotient| R) (|:| |remainder| R))))
        (SPADCALL |n| |d| (QREFELT $ 51))) 

(SDEFUN |MHROWRED;rowEchLocal;MRM;12|
        ((|x| (|Matrix| R)) (|p| (R)) ($ (|Matrix| R)))
        (SPROG
         ((|d| (R))
          (|u|
           (|Union| (|Record| (|:| |val| R) (|:| |mat| (|Matrix| R)))
                    "failed")))
         (SEQ (LETT |u| (|MHROWRED;diagSubMatrix| |x| $))
              (EXIT
               (COND
                ((QEQCAR |u| 1)
                 (COND
                  ((SPADCALL (LETT |d| (|MHROWRED;determinantOfMinor| |x| $))
                             (QREFELT $ 39))
                   (SPADCALL |x| (QREFELT $ 40)))
                  (#1='T (SPADCALL |x| |d| |p| (QREFELT $ 58)))))
                (#1#
                 (SPADCALL (QCDR (QCDR |u|)) (QCAR (QCDR |u|)) |p|
                           (QREFELT $ 58)))))))) 

(SDEFUN |MHROWRED;rowEchelonLocal;M2RM;13|
        ((|y| (|Matrix| R)) (|m| (R)) (|p| (R)) ($ (|Matrix| R)))
        (SPROG
         ((|i| #1=(|Integer|)) (#2=#:G969 NIL) (|k1| NIL)
          (|qr| (|Record| (|:| |quotient| R) (|:| |remainder| R)))
          (#3=#:G968 NIL) (|k| NIL) (|v2| (R)) (#4=#:G967 NIL) (|q| (R))
          (#5=#:G941 NIL) (#6=#:G966 NIL) (#7=#:G965 NIL) (|pivot| (R))
          (|d| (R)) (|b| (R)) (|a| (R))
          (|#G79|
           (|Record| (|:| |coef1| R) (|:| |coef2| R) (|:| |generator| R)))
          (|x| (|Matrix| R)) (#8=#:G961 NIL) (|pivord| #9=(|Integer|))
          (|rown| (|Integer|)) (|npivord| #9#) (#10=#:G964 NIL)
          (#11=#:G962 NIL) (#12=#:G963 NIL) (|j| NIL) (|minr| #1#)
          (|ncols| (|Integer|)) (|nrows| (|Integer|)) (#13=#:G928 NIL))
         (SEQ
          (LETT |m|
                (SPADCALL |p|
                          (PROG1 (LETT #13# (|MHROWRED;order| |m| |p| $))
                            (|check_subtype2| (>= #13# 0)
                                              '(|NonNegativeInteger|)
                                              '(|Integer|) #13#))
                          (QREFELT $ 60)))
          (LETT |x| (|MHROWRED;vconc| |y| |m| $))
          (LETT |nrows| (SPADCALL |x| (QREFELT $ 16)))
          (LETT |ncols| (SPADCALL |x| (QREFELT $ 31)))
          (LETT |minr| (LETT |i| (PROGN |x| 1)))
          (SEQ
           (EXIT
            (SEQ (LETT |j| (PROGN |x| 1)) (LETT #12# |ncols|) G190
                 (COND ((> |j| #12#) (GO G191)))
                 (SEQ
                  (COND
                   ((> |i| |nrows|)
                    (PROGN (LETT #11# |$NoValue|) (GO #14=#:G958))))
                  (LETT |rown| (- |minr| 1))
                  (SEQ (LETT |k| |i|) (LETT #10# |nrows|) G190
                       (COND ((> |k| #10#) (GO G191)))
                       (SEQ
                        (EXIT
                         (COND
                          ((SPADCALL (QAREF2O |x| |k| |j| 1 1)
                                     (|spadConstant| $ 7) (QREFELT $ 28))
                           "next k")
                          ('T
                           (SEQ
                            (EXIT
                             (SEQ
                              (LETT |npivord|
                                    (|MHROWRED;order| (QAREF2O |x| |k| |j| 1 1)
                                     |p| $))
                              (EXIT
                               (COND
                                ((OR (EQL |rown| (- |minr| 1))
                                     (< |npivord| |pivord|))
                                 (PROGN
                                  (LETT #8#
                                        (SEQ (LETT |rown| |k|)
                                             (EXIT (LETT |pivord| |npivord|))))
                                  (GO #15=#:G933)))))))
                            #15# (EXIT #8#))))))
                       (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (COND ((EQL |rown| (- |minr| 1)) "enuf")
                         ('T
                          (SEQ
                           (LETT |x| (SPADCALL |x| |i| |rown| (QREFELT $ 61)))
                           (PROGN
                            (LETT |#G79|
                                  (SPADCALL (QAREF2O |x| |i| |j| 1 1) |m|
                                            (QREFELT $ 63)))
                            (LETT |a| (QVELT |#G79| 0))
                            (LETT |b| (QVELT |#G79| 1))
                            (LETT |d| (QVELT |#G79| 2))
                            |#G79|)
                           (QSETAREF2O |x| |i| |j| |d| 1 1) (LETT |pivot| |d|)
                           (SEQ (LETT |k| (+ |j| 1)) (LETT #7# |ncols|) G190
                                (COND ((> |k| #7#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (QSETAREF2O |x| |i| |k|
                                              (SPADCALL
                                               (SPADCALL |a|
                                                         (QAREF2O |x| |i| |k| 1
                                                                  1)
                                                         (QREFELT $ 64))
                                               |m| (QREFELT $ 44))
                                              1 1)))
                                (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
                           (SEQ (LETT |k| (+ |i| 1)) (LETT #6# |nrows|) G190
                                (COND ((> |k| #6#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (COND
                                   ((SPADCALL (QAREF2O |x| |k| |j| 1 1)
                                              (QREFELT $ 39))
                                    "next k")
                                   ('T
                                    (SEQ
                                     (LETT |q|
                                           (PROG2
                                               (LETT #5#
                                                     (SPADCALL
                                                      (QAREF2O |x| |k| |j| 1 1)
                                                      |pivot| (QREFELT $ 49)))
                                               (QCDR #5#)
                                             (|check_union2| (QEQCAR #5# 0)
                                                             (QREFELT $ 6)
                                                             (|Union|
                                                              (QREFELT $ 6)
                                                              "failed")
                                                             #5#)))
                                     (SEQ (LETT |k1| (+ |j| 1))
                                          (LETT #4# |ncols|) G190
                                          (COND ((> |k1| #4#) (GO G191)))
                                          (SEQ
                                           (LETT |v2|
                                                 (SPADCALL
                                                  (SPADCALL
                                                   (QAREF2O |x| |k| |k1| 1 1)
                                                   (SPADCALL |q|
                                                             (QAREF2O |x| |i|
                                                                      |k1| 1 1)
                                                             (QREFELT $ 64))
                                                   (QREFELT $ 55))
                                                  |m| (QREFELT $ 44)))
                                           (EXIT
                                            (QSETAREF2O |x| |k| |k1| |v2| 1
                                                        1)))
                                          (LETT |k1| (+ |k1| 1)) (GO G190) G191
                                          (EXIT NIL))
                                     (EXIT
                                      (QSETAREF2O |x| |k| |j|
                                                  (|spadConstant| $ 7) 1
                                                  1)))))))
                                (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
                           (SEQ (LETT |k| |minr|) (LETT #3# (- |i| 1)) G190
                                (COND ((> |k| #3#) (GO G191)))
                                (SEQ
                                 (EXIT
                                  (COND
                                   ((SPADCALL (QAREF2O |x| |k| |j| 1 1)
                                              (QREFELT $ 39))
                                    "enuf")
                                   ('T
                                    (SEQ
                                     (LETT |qr|
                                           (SPADCALL (QAREF2O |x| |k| |j| 1 1)
                                                     |pivot| (QREFELT $ 57)))
                                     (QSETAREF2O |x| |k| |j| (QCDR |qr|) 1 1)
                                     (EXIT
                                      (SEQ (LETT |k1| (+ |j| 1))
                                           (LETT #2# (ANCOLS |x|)) G190
                                           (COND ((> |k1| #2#) (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (QSETAREF2O |x| |k| |k1|
                                                         (SPADCALL
                                                          (SPADCALL
                                                           (QAREF2O |x| |k|
                                                                    |k1| 1 1)
                                                           (SPADCALL
                                                            (QCAR |qr|)
                                                            (QAREF2O |x| |i|
                                                                     |k1| 1 1)
                                                            (QREFELT $ 64))
                                                           (QREFELT $ 55))
                                                          |m| (QREFELT $ 44))
                                                         1 1)))
                                           (LETT |k1| (+ |k1| 1)) (GO G190)
                                           G191 (EXIT NIL))))))))
                                (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
                           (EXIT (LETT |i| (+ |i| 1))))))))
                 (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL)))
           #14# (EXIT #11#))
          (EXIT |x|)))) 

(SDEFUN |MHROWRED;rowEchelon;MRM;14|
        ((|y| (|Matrix| R)) (|m| (R)) ($ (|Matrix| R)))
        (|MHROWRED;rowEchelon1| |y| |m| $)) 

(SDEFUN |MHROWRED;rowEchelon1| ((|y| (|Matrix| R)) (|m| (R)) ($ (|Matrix| R)))
        (SPADCALL (|MHROWRED;vconc| |y| |m| $) (QREFELT $ 40))) 

(SDEFUN |MHROWRED;rowEchelon;MRM;16|
        ((|y| (|Matrix| R)) (|m| (R)) ($ (|Matrix| R)))
        (SPROG
         ((|m1| (R)) (|d| (R)) (|nc| (|NonNegativeInteger|))
          (|nr| (|NonNegativeInteger|)))
         (SEQ (LETT |nr| (ANROWS |y|)) (LETT |nc| (ANCOLS |y|))
              (EXIT
               (COND
                ((EQL |nr| |nc|)
                 (SEQ (LETT |d| (SPADCALL |y| (QREFELT $ 35)))
                      (LETT |m1| (SPADCALL |d| |m| (QREFELT $ 36)))
                      (EXIT (|MHROWRED;rowEchelon1| |y| |m1| $))))
                ('T (|MHROWRED;rowEchelon1| |y| |m| $))))))) 

(SDEFUN |MHROWRED;rowEchelon1| ((|y| (|Matrix| R)) (|m| (R)) ($ (|Matrix| R)))
        (SPROG
         ((|i| #1=(|Integer|)) (#2=#:G1015 NIL) (|k1| NIL)
          (|qr| (|Record| (|:| |quotient| R) (|:| |remainder| R)))
          (#3=#:G1014 NIL) (|k| NIL) (|xij| (R)) (#4=#:G1013 NIL) (|jj| NIL)
          (|un|
           (|Record| (|:| |unit| R) (|:| |canonical| R) (|:| |associate| R)))
          (|v2| (R)) (|v1| (R)) (#5=#:G1012 NIL) (|a1| (R)) (|b1| (R))
          (|#G98| (R)) (#6=#:G984 NIL) (|#G97| (R)) (|d| (R)) (|b| (R))
          (|a| (R))
          (|#G96|
           (|Record| (|:| |coef1| R) (|:| |coef2| R) (|:| |generator| R)))
          (#7=#:G1011 NIL) (|x| (|Matrix| R)) (|rown| (|Integer|))
          (#8=#:G1010 NIL) (#9=#:G1008 NIL) (#10=#:G1009 NIL) (|j| NIL)
          (|minr| #1#) (|ncols| (|Integer|)) (|nrows| (|Integer|)))
         (SEQ (LETT |x| (|MHROWRED;vconc| |y| |m| $))
              (LETT |nrows| (SPADCALL |x| (QREFELT $ 16)))
              (LETT |ncols| (SPADCALL |x| (QREFELT $ 31)))
              (LETT |minr| (LETT |i| (PROGN |x| 1)))
              (SEQ
               (EXIT
                (SEQ (LETT |j| (PROGN |x| 1)) (LETT #10# |ncols|) G190
                     (COND ((> |j| #10#) (GO G191)))
                     (SEQ
                      (COND
                       ((> |i| |nrows|)
                        (PROGN (LETT #9# |$NoValue|) (GO #11=#:G1005))))
                      (LETT |rown| (- |minr| 1))
                      (SEQ (LETT |k| |i|) (LETT #8# |nrows|) G190
                           (COND ((> |k| #8#) (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((SPADCALL (QAREF2O |x| |k| |j| 1 1)
                                         (|spadConstant| $ 7) (QREFELT $ 9))
                               (COND
                                ((OR (EQL |rown| (- |minr| 1))
                                     (SPADCALL (QAREF2O |x| |k| |j| 1 1)
                                               (QAREF2O |x| |rown| |j| 1 1)
                                               (QREFELT $ 65)))
                                 (LETT |rown| |k|)))))))
                           (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (COND ((EQL |rown| (- |minr| 1)) "next j")
                             ('T
                              (SEQ
                               (LETT |x|
                                     (SPADCALL |x| |i| |rown| (QREFELT $ 61)))
                               (SEQ (LETT |k| (+ |i| 1)) (LETT #7# |nrows|)
                                    G190 (COND ((> |k| #7#) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((SPADCALL (QAREF2O |x| |k| |j| 1 1)
                                                  (QREFELT $ 39))
                                        "next k")
                                       ('T
                                        (SEQ
                                         (PROGN
                                          (LETT |#G96|
                                                (SPADCALL
                                                 (QAREF2O |x| |i| |j| 1 1)
                                                 (QAREF2O |x| |k| |j| 1 1)
                                                 (QREFELT $ 63)))
                                          (LETT |a| (QVELT |#G96| 0))
                                          (LETT |b| (QVELT |#G96| 1))
                                          (LETT |d| (QVELT |#G96| 2))
                                          |#G96|)
                                         (PROGN
                                          (LETT |#G97|
                                                (PROG2
                                                    (LETT #6#
                                                          (SPADCALL
                                                           (QAREF2O |x| |i| |j|
                                                                    1 1)
                                                           |d| (QREFELT $ 49)))
                                                    (QCDR #6#)
                                                  (|check_union2|
                                                   (QEQCAR #6# 0) (QREFELT $ 6)
                                                   (|Union| (QREFELT $ 6)
                                                            #12="failed")
                                                   #6#)))
                                          (LETT |#G98|
                                                (PROG2
                                                    (LETT #6#
                                                          (SPADCALL
                                                           (QAREF2O |x| |k| |j|
                                                                    1 1)
                                                           |d| (QREFELT $ 49)))
                                                    (QCDR #6#)
                                                  (|check_union2|
                                                   (QEQCAR #6# 0) (QREFELT $ 6)
                                                   (|Union| (QREFELT $ 6) #12#)
                                                   #6#)))
                                          (LETT |b1| |#G97|)
                                          (LETT |a1| |#G98|))
                                         (SEQ (LETT |k1| (+ |j| 1))
                                              (LETT #5# |ncols|) G190
                                              (COND ((> |k1| #5#) (GO G191)))
                                              (SEQ
                                               (LETT |v1|
                                                     (SPADCALL
                                                      (SPADCALL
                                                       (SPADCALL |a|
                                                                 (QAREF2O |x|
                                                                          |i|
                                                                          |k1|
                                                                          1 1)
                                                                 (QREFELT $
                                                                          64))
                                                       (SPADCALL |b|
                                                                 (QAREF2O |x|
                                                                          |k|
                                                                          |k1|
                                                                          1 1)
                                                                 (QREFELT $
                                                                          64))
                                                       (QREFELT $ 54))
                                                      |m| (QREFELT $ 44)))
                                               (LETT |v2|
                                                     (SPADCALL
                                                      (SPADCALL
                                                       (SPADCALL |b1|
                                                                 (QAREF2O |x|
                                                                          |k|
                                                                          |k1|
                                                                          1 1)
                                                                 (QREFELT $
                                                                          64))
                                                       (SPADCALL |a1|
                                                                 (QAREF2O |x|
                                                                          |i|
                                                                          |k1|
                                                                          1 1)
                                                                 (QREFELT $
                                                                          64))
                                                       (QREFELT $ 55))
                                                      |m| (QREFELT $ 44)))
                                               (QSETAREF2O |x| |i| |k1| |v1| 1
                                                           1)
                                               (EXIT
                                                (QSETAREF2O |x| |k| |k1| |v2| 1
                                                            1)))
                                              (LETT |k1| (+ |k1| 1)) (GO G190)
                                              G191 (EXIT NIL))
                                         (QSETAREF2O |x| |i| |j| |d| 1 1)
                                         (EXIT
                                          (QSETAREF2O |x| |k| |j|
                                                      (|spadConstant| $ 7) 1
                                                      1)))))))
                                    (LETT |k| (+ |k| 1)) (GO G190) G191
                                    (EXIT NIL))
                               (LETT |un|
                                     (SPADCALL (QAREF2O |x| |i| |j| 1 1)
                                               (QREFELT $ 67)))
                               (QSETAREF2O |x| |i| |j| (QVELT |un| 1) 1 1)
                               (COND
                                ((SPADCALL (QVELT |un| 2) (|spadConstant| $ 22)
                                           (QREFELT $ 9))
                                 (SEQ (LETT |jj| (+ |j| 1)) (LETT #4# |ncols|)
                                      G190 (COND ((> |jj| #4#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (QSETAREF2O |x| |i| |jj|
                                                    (SPADCALL (QVELT |un| 2)
                                                              (QAREF2O |x| |i|
                                                                       |jj| 1
                                                                       1)
                                                              (QREFELT $ 64))
                                                    1 1)))
                                      (LETT |jj| (+ |jj| 1)) (GO G190) G191
                                      (EXIT NIL))))
                               (LETT |xij| (QAREF2O |x| |i| |j| 1 1))
                               (SEQ (LETT |k| |minr|) (LETT #3# (- |i| 1)) G190
                                    (COND ((> |k| #3#) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (COND
                                       ((SPADCALL (QAREF2O |x| |k| |j| 1 1)
                                                  (QREFELT $ 39))
                                        "next k")
                                       ('T
                                        (SEQ
                                         (LETT |qr|
                                               (SPADCALL
                                                (QAREF2O |x| |k| |j| 1 1) |xij|
                                                (QREFELT $ 57)))
                                         (QSETAREF2O |x| |k| |j| (QCDR |qr|) 1
                                                     1)
                                         (EXIT
                                          (SEQ (LETT |k1| (+ |j| 1))
                                               (LETT #2# (ANCOLS |x|)) G190
                                               (COND ((> |k1| #2#) (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (QSETAREF2O |x| |k| |k1|
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QAREF2O |x| |k|
                                                                        |k1| 1
                                                                        1)
                                                               (SPADCALL
                                                                (QCAR |qr|)
                                                                (QAREF2O |x|
                                                                         |i|
                                                                         |k1| 1
                                                                         1)
                                                                (QREFELT $ 64))
                                                               (QREFELT $ 55))
                                                              |m|
                                                              (QREFELT $ 44))
                                                             1 1)))
                                               (LETT |k1| (+ |k1| 1)) (GO G190)
                                               G191 (EXIT NIL))))))))
                                    (LETT |k| (+ |k| 1)) (GO G190) G191
                                    (EXIT NIL))
                               (EXIT (LETT |i| (+ |i| 1))))))))
                     (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL)))
               #11# (EXIT #9#))
              (EXIT |x|)))) 

(DECLAIM (NOTINLINE |ModularHermitianRowReduction;|)) 

(DEFUN |ModularHermitianRowReduction| (#1=#:G1016)
  (SPROG NIL
         (PROG (#2=#:G1017)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|ModularHermitianRowReduction|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1 (|ModularHermitianRowReduction;| #1#) (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|ModularHermitianRowReduction|)))))))))) 

(DEFUN |ModularHermitianRowReduction;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|ModularHermitianRowReduction| DV$1))
          (LETT $ (GETREFV 68))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|ModularHermitianRowReduction|
                      (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          (COND
           ((|HasCategory| |#1| '(|IntegerNumberSystem|))
            (QSETREFV $ 57
                      (CONS
                       (|dispatchFunction| |MHROWRED;normalizedDivide;2RR;10|)
                       $)))
           ('T
            (QSETREFV $ 57
                      (CONS
                       (|dispatchFunction| |MHROWRED;normalizedDivide;2RR;11|)
                       $))))
          (COND
           ((|HasCategory| |#1| '(|Field|))
            (PROGN
             (QSETREFV $ 41
                       (CONS (|dispatchFunction| |MHROWRED;rowEchelon;MRM;14|)
                             $))))
           ('T
            (PROGN
             (QSETREFV $ 41
                       (CONS (|dispatchFunction| |MHROWRED;rowEchelon;MRM;16|)
                             $)))))
          $))) 

(MAKEPROP '|ModularHermitianRowReduction| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (0 . |Zero|) (|Boolean|)
              (4 . ~=) (|Mapping| 8 6) (|Vector| 6) (10 . |any?|) (|Integer|)
              (16 . |minIndex|) (|Matrix| 6) (21 . |maxRowIndex|) (|List| 13)
              (26 . |member?|) (32 . |row|) (|List| 6) (38 . |parts|)
              (43 . |One|) (|NonNegativeInteger|) (47 . |zero|) (|List| 20)
              (53 . |matrix|) (58 . |removeDuplicates|) (63 . =) (|Set| 13)
              (69 . |set|) (74 . |maxColIndex|) (79 . =) (85 . |binomial|)
              (91 . |elt|) (98 . |determinant|) (103 . |gcd|) (109 . |elt|)
              (115 . |rest|) (121 . |zero?|) (126 . |rowEchelon|)
              (131 . |rowEchelon|) |MHROWRED;rowEch;2M;7|
              (137 . |diagonalMatrix|) (142 . |rem|) (|Mapping| 6 6)
              (148 . |map|) (154 . |vertConcat|) (|Union| $ '"failed")
              (160 . |exquo|) (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (166 . |divide|) (172 . >=) (178 . >) (184 . +) (190 . -)
              (|Record| (|:| |quotient| 6) (|:| |remainder| 6))
              (196 . |normalizedDivide|) |MHROWRED;rowEchelonLocal;M2RM;13|
              |MHROWRED;rowEchLocal;MRM;12| (202 . ^) (208 . |swapRows!|)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (215 . |extendedEuclidean|) (221 . *) (227 . |sizeLess?|)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (233 . |unitNormal|))
           '#(|rowEchelonLocal| 238 |rowEchelon| 245 |rowEchLocal| 251 |rowEch|
              257 |normalizedDivide| 262)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|rowEch| ((|Matrix| |#1|) (|Matrix| |#1|))) T)
                              '((|rowEchelon|
                                 ((|Matrix| |#1|) (|Matrix| |#1|) |#1|))
                                T)
                              '((|rowEchLocal|
                                 ((|Matrix| |#1|) (|Matrix| |#1|) |#1|))
                                T)
                              '((|rowEchelonLocal|
                                 ((|Matrix| |#1|) (|Matrix| |#1|) |#1| |#1|))
                                T)
                              '((|normalizedDivide|
                                 ((|Record| (|:| |quotient| |#1|)
                                            (|:| |remainder| |#1|))
                                  |#1| |#1|))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 67
                                            '(0 6 0 7 2 6 8 0 0 9 2 11 8 10 0
                                              12 1 11 13 0 14 1 15 13 0 16 2 17
                                              8 13 0 18 2 15 11 0 13 19 1 11 20
                                              0 21 0 6 0 22 2 15 0 23 23 24 1
                                              15 0 25 26 1 20 0 0 27 2 6 8 0 0
                                              28 1 29 0 17 30 1 15 13 0 31 2 29
                                              8 0 0 32 2 13 0 0 0 33 3 15 0 0
                                              17 17 34 1 15 6 0 35 2 6 0 0 0 36
                                              2 17 13 0 13 37 2 17 0 0 23 38 1
                                              6 8 0 39 1 15 0 0 40 2 0 15 15 6
                                              41 1 15 0 11 43 2 6 0 0 0 44 2 15
                                              0 45 0 46 2 15 0 0 0 47 2 6 48 0
                                              0 49 2 6 50 0 0 51 2 6 8 0 0 52 2
                                              6 8 0 0 53 2 6 0 0 0 54 2 6 0 0 0
                                              55 2 0 56 6 6 57 2 6 0 0 23 60 3
                                              15 0 0 13 13 61 2 6 62 0 0 63 2 6
                                              0 0 0 64 2 6 8 0 0 65 1 6 66 0 67
                                              3 0 15 15 6 6 58 2 0 15 15 6 41 2
                                              0 15 15 6 59 1 0 15 15 42 2 0 56
                                              6 6 57)))))
           '|lookupComplete|)) 
