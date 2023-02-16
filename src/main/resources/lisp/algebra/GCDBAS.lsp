
(SDEFUN |GCDBAS;gcdBasis;2V;1| ((|v| (|Vector| R)) ($ (|Vector| R)))
        (QCAR (SPADCALL |v| (QREFELT $ 9)))) 

(SDEFUN |GCDBAS;splitNums|
        ((|a| (R)) (|b| (R))
         ($
          (|Union| (|Record| (|:| |fac1| R) (|:| |fac2| R) (|:| |commonfac| R))
                   "failed")))
        (SPROG ((|b1| (R)) (#1=#:G702 NIL) (|a1| (R)) (|cf| (R)))
               (SEQ (LETT |cf| (SPADCALL |a| |b| (QREFELT $ 11)))
                    (EXIT
                     (COND ((SPADCALL |cf| (QREFELT $ 13)) (CONS 1 "failed"))
                           ('T
                            (SEQ
                             (LETT |a1|
                                   (PROG2
                                       (LETT #1#
                                             (SPADCALL |a| |cf|
                                                       (QREFELT $ 15)))
                                       (QCDR #1#)
                                     (|check_union2| (QEQCAR #1# 0)
                                                     (QREFELT $ 6)
                                                     (|Union| (QREFELT $ 6)
                                                              #2="failed")
                                                     #1#)))
                             (LETT |b1|
                                   (PROG2
                                       (LETT #1#
                                             (SPADCALL |b| |cf|
                                                       (QREFELT $ 15)))
                                       (QCDR #1#)
                                     (|check_union2| (QEQCAR #1# 0)
                                                     (QREFELT $ 6)
                                                     (|Union| (QREFELT $ 6)
                                                              #2#)
                                                     #1#)))
                             (EXIT (CONS 0 (VECTOR |a1| |b1| |cf|)))))))))) 

(SDEFUN |GCDBAS;gcdDecomposition;VR;3|
        ((|v| (|Vector| (|Fraction| R)))
         ($
          (|Record| (|:| |basis| #1=(|Vector| R))
                    (|:| |transform| #2=(|Matrix| (|Integer|))))))
        (SPROG
         ((#3=#:G735 NIL) (|j| NIL) (#4=#:G734 NIL) (|i| NIL)
          (|ct| (|Matrix| (|Integer|))) (|m| (|NonNegativeInteger|))
          (|ct0| #2#) (|cb| #1#)
          (|pr|
           (|Record| (|:| |basis| (|Vector| R))
                     (|:| |transform| (|Matrix| (|Integer|)))))
          (#5=#:G733 NIL) (|nv| (|Vector| R)) (|n| (|NonNegativeInteger|)))
         (SEQ (LETT |n| (QVSIZE |v|))
              (LETT |nv| (MAKEARR1 (* 2 |n|) (|spadConstant| $ 16)))
              (SEQ (LETT |i| 1) (LETT #5# |n|) G190
                   (COND ((|greater_SI| |i| #5#) (GO G191)))
                   (SEQ
                    (SPADCALL |nv| |i|
                              (SPADCALL (SPADCALL |v| |i| (QREFELT $ 20))
                                        (QREFELT $ 21))
                              (QREFELT $ 22))
                    (EXIT
                     (SPADCALL |nv| (+ |i| |n|)
                               (SPADCALL (SPADCALL |v| |i| (QREFELT $ 20))
                                         (QREFELT $ 23))
                               (QREFELT $ 22))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (LETT |pr| (SPADCALL |nv| (QREFELT $ 9))) (LETT |cb| (QCAR |pr|))
              (LETT |ct0| (QCDR |pr|)) (LETT |m| (QVSIZE |cb|))
              (LETT |ct| (MAKE_MATRIX1 |m| |n| 0))
              (SEQ (LETT |i| 1) (LETT #4# |m|) G190
                   (COND ((|greater_SI| |i| #4#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #3# |n|) G190
                          (COND ((|greater_SI| |j| #3#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SPADCALL |ct| |i| |j|
                                      (-
                                       (SPADCALL |ct0| |i| |j| (QREFELT $ 26))
                                       (SPADCALL |ct0| |i| (+ |j| |n|)
                                                 (QREFELT $ 26)))
                                      (QREFELT $ 27))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT (CONS |cb| |ct|))))) 

(SDEFUN |GCDBAS;gcdDecomposition;VR;4|
        ((|v| (|Vector| R))
         ($
          (|Record| (|:| |basis| #1=(|Vector| R))
                    (|:| |transform| #2=(|Matrix| (|Integer|))))))
        (SPROG
         ((#3=#:G792 NIL) (|i| NIL) (#4=#:G791 NIL)
          (|nv| (|Vector| (|Integer|))) (|a| (R)) (#5=#:G790 NIL) (|l| NIL)
          (#6=#:G789 NIL) (|m| (|NonNegativeInteger|))
          (|firstAdded| (|Boolean|)) (|c| (|Integer|)) (#7=#:G788 NIL)
          (|k| NIL) (|ov| (|Vector| (|Integer|)))
          (|n1| #8=(|NonNegativeInteger|)) (|ct1| #2#) (|cb1| #1#)
          (|dr1|
           (|Record| (|:| |basis| (|Vector| R))
                     (|:| |transform| (|Matrix| (|Integer|)))))
          (#9=#:G787 NIL) (#10=#:G786 NIL) (#11=#:G785 NIL) (|cf| (R))
          (|b1| (R)) (|a1| (R))
          (|sr| (|Record| (|:| |fac1| R) (|:| |fac2| R) (|:| |commonfac| R)))
          (|sr1|
           (|Union|
            (|Record| (|:| |fac1| R) (|:| |fac2| R) (|:| |commonfac| R))
            "failed"))
          (#12=#:G782 NIL) (|pquo| (|Union| R "failed")) (|b| (R))
          (#13=#:G784 NIL) (|j| NIL) (|i0| (|NonNegativeInteger|))
          (#14=#:G783 NIL) (|ct| (|FlexibleArray| (|Vector| (|Integer|))))
          (|n| #8#) (|cb| (|FlexibleArray| R)))
         (SEQ (LETT |cb| (SPADCALL (QREFELT $ 30))) (LETT |n| (QVSIZE |v|))
              (LETT |ct| (SPADCALL (QREFELT $ 32)))
              (SEQ (LETT |i| 1) (LETT #14# |n|) G190
                   (COND ((|greater_SI| |i| #14#) (GO G191)))
                   (SEQ (LETT |a| (SPADCALL |v| |i| (QREFELT $ 33)))
                        (LETT |i0| (SPADCALL |cb| (QREFELT $ 35)))
                        (SEQ
                         (EXIT
                          (SEQ (LETT |j| 1) (LETT #13# |i0|) G190
                               (COND
                                ((OR (|greater_SI| |j| #13#)
                                     (NULL
                                      (NULL (SPADCALL |a| (QREFELT $ 13)))))
                                 (GO G191)))
                               (SEQ
                                (LETT |b| (SPADCALL |cb| |j| (QREFELT $ 36)))
                                (EXIT
                                 (COND
                                  ((SPADCALL |b| (QREFELT $ 13)) "iterate")
                                  ('T
                                   (SEQ
                                    (LETT |pquo|
                                          (SPADCALL |a| |b| (QREFELT $ 15)))
                                    (COND
                                     ((QEQCAR |pquo| 0)
                                      (SEQ G190
                                           (COND
                                            ((NULL (QEQCAR |pquo| 0))
                                             (GO G191)))
                                           (SEQ
                                            (SPADCALL
                                             (SPADCALL |ct| |j| (QREFELT $ 38))
                                             |i|
                                             (+
                                              (SPADCALL
                                               (SPADCALL |ct| |j|
                                                         (QREFELT $ 38))
                                               |i| (QREFELT $ 39))
                                              1)
                                             (QREFELT $ 40))
                                            (LETT |a| (QCDR |pquo|))
                                            (EXIT
                                             (LETT |pquo|
                                                   (SPADCALL |a| |b|
                                                             (QREFELT $ 15)))))
                                           NIL (GO G190) G191 (EXIT NIL))))
                                    (EXIT
                                     (COND
                                      ((SPADCALL |a| (QREFELT $ 13))
                                       (PROGN (LETT #12# 1) (GO #15=#:G774)))
                                      ('T
                                       (SEQ
                                        (LETT |sr1|
                                              (|GCDBAS;splitNums| |a| |b| $))
                                        (EXIT
                                         (COND
                                          ((QEQCAR |sr1| 0)
                                           (SEQ (LETT |sr| (QCDR |sr1|))
                                                (LETT |a1| (QVELT |sr| 0))
                                                (LETT |b1| (QVELT |sr| 1))
                                                (LETT |cf| (QVELT |sr| 2))
                                                (EXIT
                                                 (COND
                                                  ((SPADCALL
                                                    (SPADCALL |a1| |cf|
                                                              (QREFELT $ 11))
                                                    (QREFELT $ 13))
                                                   (COND
                                                    ((SPADCALL
                                                      (SPADCALL |b1| |cf|
                                                                (QREFELT $ 11))
                                                      (QREFELT $ 13))
                                                     (SEQ
                                                      (SPADCALL |cb| |b1|
                                                                (QREFELT $ 41))
                                                      (SPADCALL |ct|
                                                                (SPADCALL
                                                                 (SPADCALL |ct|
                                                                           |j|
                                                                           (QREFELT
                                                                            $
                                                                            38))
                                                                 (QREFELT $
                                                                          42))
                                                                (QREFELT $ 43))
                                                      (SPADCALL |cb| |j| |cf|
                                                                (QREFELT $ 44))
                                                      (SPADCALL
                                                       (SPADCALL |ct| |j|
                                                                 (QREFELT $
                                                                          38))
                                                       |i|
                                                       (+
                                                        (SPADCALL
                                                         (SPADCALL |ct| |j|
                                                                   (QREFELT $
                                                                            38))
                                                         |i| (QREFELT $ 39))
                                                        1)
                                                       (QREFELT $ 40))
                                                      (EXIT (LETT |a| |a1|))))
                                                    ('T
                                                     (SEQ
                                                      (LETT |dr1|
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (LIST |a1| |b1|
                                                                    |cf|)
                                                              (QREFELT $ 46))
                                                             (QREFELT $ 9)))
                                                      (LETT |cb1| (QCAR |dr1|))
                                                      (LETT |ct1| (QCDR |dr1|))
                                                      (LETT |firstAdded| 'T)
                                                      (LETT |a|
                                                            (|spadConstant| $
                                                                            47))
                                                      (LETT |n1|
                                                            (QVSIZE |cb1|))
                                                      (LETT |ov|
                                                            (SPADCALL |ct| |j|
                                                                      (QREFELT
                                                                       $ 38)))
                                                      (EXIT
                                                       (SEQ (LETT |k| 1)
                                                            (LETT #11# |n1|)
                                                            G190
                                                            (COND
                                                             ((|greater_SI| |k|
                                                                            #11#)
                                                              (GO G191)))
                                                            (SEQ
                                                             (LETT |c|
                                                                   (+
                                                                    (SPADCALL
                                                                     |ct1| |k|
                                                                     2
                                                                     (QREFELT $
                                                                              26))
                                                                    (SPADCALL
                                                                     |ct1| |k|
                                                                     3
                                                                     (QREFELT $
                                                                              26))))
                                                             (EXIT
                                                              (COND
                                                               ((> |c| 0)
                                                                (SEQ
                                                                 (COND
                                                                  (|firstAdded|
                                                                   (SEQ
                                                                    (LETT
                                                                     |firstAdded|
                                                                     NIL)
                                                                    (SPADCALL
                                                                     |cb| |j|
                                                                     (SPADCALL
                                                                      |cb1| |k|
                                                                      (QREFELT
                                                                       $ 33))
                                                                     (QREFELT $
                                                                              44))
                                                                    (EXIT
                                                                     (LETT |m|
                                                                           |j|))))
                                                                  ('T
                                                                   (SEQ
                                                                    (SPADCALL
                                                                     |cb|
                                                                     (SPADCALL
                                                                      |cb1| |k|
                                                                      (QREFELT
                                                                       $ 33))
                                                                     (QREFELT $
                                                                              41))
                                                                    (SPADCALL
                                                                     |ct|
                                                                     (MAKE-ARRAY
                                                                      0)
                                                                     (QREFELT $
                                                                              43))
                                                                    (EXIT
                                                                     (LETT |m|
                                                                           (SPADCALL
                                                                            |cb|
                                                                            (QREFELT
                                                                             $
                                                                             35)))))))
                                                                 (LETT |nv|
                                                                       (MAKEARR1
                                                                        |n| 0))
                                                                 (SEQ
                                                                  (LETT |l| 1)
                                                                  (LETT #10#
                                                                        |n|)
                                                                  G190
                                                                  (COND
                                                                   ((|greater_SI|
                                                                     |l| #10#)
                                                                    (GO G191)))
                                                                  (SEQ
                                                                   (EXIT
                                                                    (SPADCALL
                                                                     |nv| |l|
                                                                     (* |c|
                                                                        (SPADCALL
                                                                         |ov|
                                                                         |l|
                                                                         (QREFELT
                                                                          $
                                                                          39)))
                                                                     (QREFELT $
                                                                              40))))
                                                                  (LETT |l|
                                                                        (|inc_SI|
                                                                         |l|))
                                                                  (GO G190)
                                                                  G191
                                                                  (EXIT NIL))
                                                                 (SPADCALL |nv|
                                                                           |i|
                                                                           (+
                                                                            (+
                                                                             (SPADCALL
                                                                              |nv|
                                                                              |i|
                                                                              (QREFELT
                                                                               $
                                                                               39))
                                                                             (SPADCALL
                                                                              |ct1|
                                                                              |k|
                                                                              1
                                                                              (QREFELT
                                                                               $
                                                                               26)))
                                                                            (SPADCALL
                                                                             |ct1|
                                                                             |k|
                                                                             3
                                                                             (QREFELT
                                                                              $
                                                                              26)))
                                                                           (QREFELT
                                                                            $
                                                                            40))
                                                                 (EXIT
                                                                  (SPADCALL
                                                                   |ct| |m|
                                                                   |nv|
                                                                   (QREFELT $
                                                                            48)))))
                                                               ('T
                                                                (SEQ
                                                                 (LETT |l| 1)
                                                                 (LETT #9#
                                                                       (SPADCALL
                                                                        |ct1|
                                                                        |k| 1
                                                                        (QREFELT
                                                                         $
                                                                         26)))
                                                                 G190
                                                                 (COND
                                                                  ((|greater_SI|
                                                                    |l| #9#)
                                                                   (GO G191)))
                                                                 (SEQ
                                                                  (EXIT
                                                                   (LETT |a|
                                                                         (SPADCALL
                                                                          |a|
                                                                          (SPADCALL
                                                                           |cb1|
                                                                           |k|
                                                                           (QREFELT
                                                                            $
                                                                            33))
                                                                          (QREFELT
                                                                           $
                                                                           49)))))
                                                                 (LETT |l|
                                                                       (|inc_SI|
                                                                        |l|))
                                                                 (GO G190) G191
                                                                 (EXIT
                                                                  NIL))))))
                                                            (LETT |k|
                                                                  (|inc_SI|
                                                                   |k|))
                                                            (GO G190) G191
                                                            (EXIT NIL)))))))
                                                  ('T
                                                   (SEQ
                                                    (LETT |dr1|
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (LIST |a1| |b1|
                                                                  |cf|)
                                                            (QREFELT $ 46))
                                                           (QREFELT $ 9)))
                                                    (LETT |cb1| (QCAR |dr1|))
                                                    (LETT |ct1| (QCDR |dr1|))
                                                    (LETT |firstAdded| 'T)
                                                    (LETT |a|
                                                          (|spadConstant| $
                                                                          47))
                                                    (LETT |n1| (QVSIZE |cb1|))
                                                    (LETT |ov|
                                                          (SPADCALL |ct| |j|
                                                                    (QREFELT $
                                                                             38)))
                                                    (EXIT
                                                     (SEQ (LETT |k| 1)
                                                          (LETT #7# |n1|) G190
                                                          (COND
                                                           ((|greater_SI| |k|
                                                                          #7#)
                                                            (GO G191)))
                                                          (SEQ
                                                           (LETT |c|
                                                                 (+
                                                                  (SPADCALL
                                                                   |ct1| |k| 2
                                                                   (QREFELT $
                                                                            26))
                                                                  (SPADCALL
                                                                   |ct1| |k| 3
                                                                   (QREFELT $
                                                                            26))))
                                                           (EXIT
                                                            (COND
                                                             ((> |c| 0)
                                                              (SEQ
                                                               (COND
                                                                (|firstAdded|
                                                                 (SEQ
                                                                  (LETT
                                                                   |firstAdded|
                                                                   NIL)
                                                                  (SPADCALL
                                                                   |cb| |j|
                                                                   (SPADCALL
                                                                    |cb1| |k|
                                                                    (QREFELT $
                                                                             33))
                                                                   (QREFELT $
                                                                            44))
                                                                  (EXIT
                                                                   (LETT |m|
                                                                         |j|))))
                                                                ('T
                                                                 (SEQ
                                                                  (SPADCALL
                                                                   |cb|
                                                                   (SPADCALL
                                                                    |cb1| |k|
                                                                    (QREFELT $
                                                                             33))
                                                                   (QREFELT $
                                                                            41))
                                                                  (SPADCALL
                                                                   |ct|
                                                                   (MAKE-ARRAY
                                                                    0)
                                                                   (QREFELT $
                                                                            43))
                                                                  (EXIT
                                                                   (LETT |m|
                                                                         (SPADCALL
                                                                          |cb|
                                                                          (QREFELT
                                                                           $
                                                                           35)))))))
                                                               (LETT |nv|
                                                                     (MAKEARR1
                                                                      |n| 0))
                                                               (SEQ
                                                                (LETT |l| 1)
                                                                (LETT #6# |n|)
                                                                G190
                                                                (COND
                                                                 ((|greater_SI|
                                                                   |l| #6#)
                                                                  (GO G191)))
                                                                (SEQ
                                                                 (EXIT
                                                                  (SPADCALL
                                                                   |nv| |l|
                                                                   (* |c|
                                                                      (SPADCALL
                                                                       |ov| |l|
                                                                       (QREFELT
                                                                        $ 39)))
                                                                   (QREFELT $
                                                                            40))))
                                                                (LETT |l|
                                                                      (|inc_SI|
                                                                       |l|))
                                                                (GO G190) G191
                                                                (EXIT NIL))
                                                               (SPADCALL |nv|
                                                                         |i|
                                                                         (+
                                                                          (+
                                                                           (SPADCALL
                                                                            |nv|
                                                                            |i|
                                                                            (QREFELT
                                                                             $
                                                                             39))
                                                                           (SPADCALL
                                                                            |ct1|
                                                                            |k|
                                                                            1
                                                                            (QREFELT
                                                                             $
                                                                             26)))
                                                                          (SPADCALL
                                                                           |ct1|
                                                                           |k|
                                                                           3
                                                                           (QREFELT
                                                                            $
                                                                            26)))
                                                                         (QREFELT
                                                                          $
                                                                          40))
                                                               (EXIT
                                                                (SPADCALL |ct|
                                                                          |m|
                                                                          |nv|
                                                                          (QREFELT
                                                                           $
                                                                           48)))))
                                                             ('T
                                                              (SEQ (LETT |l| 1)
                                                                   (LETT #5#
                                                                         (SPADCALL
                                                                          |ct1|
                                                                          |k| 1
                                                                          (QREFELT
                                                                           $
                                                                           26)))
                                                                   G190
                                                                   (COND
                                                                    ((|greater_SI|
                                                                      |l| #5#)
                                                                     (GO
                                                                      G191)))
                                                                   (SEQ
                                                                    (EXIT
                                                                     (LETT |a|
                                                                           (SPADCALL
                                                                            |a|
                                                                            (SPADCALL
                                                                             |cb1|
                                                                             |k|
                                                                             (QREFELT
                                                                              $
                                                                              33))
                                                                            (QREFELT
                                                                             $
                                                                             49)))))
                                                                   (LETT |l|
                                                                         (|inc_SI|
                                                                          |l|))
                                                                   (GO G190)
                                                                   G191
                                                                   (EXIT
                                                                    NIL))))))
                                                          (LETT |k|
                                                                (|inc_SI| |k|))
                                                          (GO G190) G191
                                                          (EXIT
                                                           NIL))))))))))))))))))))
                               (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                               (EXIT NIL)))
                         #15# (EXIT #12#))
                        (EXIT
                         (COND
                          ((NULL
                            (SPADCALL |a| (|spadConstant| $ 47)
                                      (QREFELT $ 50)))
                           (SEQ (SPADCALL |cb| |a| (QREFELT $ 41))
                                (LETT |nv| (MAKEARR1 |n| 0))
                                (SPADCALL |nv| |i| 1 (QREFELT $ 40))
                                (EXIT (SPADCALL |ct| |nv| (QREFELT $ 43))))))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (CONS (SPADCALL (SPADCALL |cb| (QREFELT $ 51)) (QREFELT $ 46))
                     (SPADCALL
                      (PROGN
                       (LETT #4# NIL)
                       (SEQ (LETT |i| 1)
                            (LETT #3# (SPADCALL |ct| (QREFELT $ 52))) G190
                            (COND ((|greater_SI| |i| #3#) (GO G191)))
                            (SEQ
                             (EXIT
                              (LETT #4#
                                    (CONS
                                     (SPADCALL
                                      (SPADCALL |ct| |i| (QREFELT $ 38))
                                      (QREFELT $ 54))
                                     #4#))))
                            (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                            (EXIT (NREVERSE #4#))))
                      (QREFELT $ 56))))))) 

(DECLAIM (NOTINLINE |GcdBasis;|)) 

(DEFUN |GcdBasis| (#1=#:G793)
  (SPROG NIL
         (PROG (#2=#:G794)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (LIST (|devaluate| #1#))
                                               (HGET |$ConstructorCache|
                                                     '|GcdBasis|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT (PROG1 (|GcdBasis;| #1#) (LETT #2# T))
                (COND ((NOT #2#) (HREM |$ConstructorCache| '|GcdBasis|)))))))))) 

(DEFUN |GcdBasis;| (|#1|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT |dv$| (LIST '|GcdBasis| DV$1))
          (LETT $ (GETREFV 57))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|GcdBasis| (LIST DV$1) (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|GcdBasis| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|)
              (|Record| (|:| |basis| 8) (|:| |transform| 25)) (|Vector| 6)
              |GCDBAS;gcdDecomposition;VR;4| |GCDBAS;gcdBasis;2V;1| (0 . |gcd|)
              (|Boolean|) (6 . |unit?|) (|Union| $ '"failed") (11 . |exquo|)
              (17 . |Zero|) (|Fraction| 6) (|Integer|) (|Vector| 17)
              (21 . |elt|) (27 . |numer|) (32 . |setelt!|) (39 . |denom|)
              (44 . |Zero|) (|Matrix| 18) (48 . |elt|) (55 . |setelt!|)
              |GCDBAS;gcdDecomposition;VR;3| (|FlexibleArray| 6) (63 . |empty|)
              (|FlexibleArray| 37) (67 . |empty|) (71 . |elt|)
              (|NonNegativeInteger|) (77 . |#|) (82 . |elt|) (|Vector| 18)
              (88 . |elt|) (94 . |elt|) (100 . |setelt!|) (107 . |concat!|)
              (113 . |copy|) (118 . |concat!|) (124 . |setelt!|) (|List| 6)
              (131 . |vector|) (136 . |One|) (140 . |setelt!|) (147 . *)
              (153 . =) (159 . |parts|) (164 . |#|) (|List| 18) (169 . |parts|)
              (|List| 53) (174 . |matrix|))
           '#(|gcdDecomposition| 179 |gcdBasis| 189) 'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|gcdBasis| ((|Vector| |#1|) (|Vector| |#1|)))
                                T)
                              '((|gcdDecomposition|
                                 ((|Record| (|:| |basis| (|Vector| |#1|))
                                            (|:| |transform|
                                                 (|Matrix| (|Integer|))))
                                  (|Vector| |#1|)))
                                T)
                              '((|gcdDecomposition|
                                 ((|Record| (|:| |basis| (|Vector| |#1|))
                                            (|:| |transform|
                                                 (|Matrix| (|Integer|))))
                                  (|Vector| (|Fraction| |#1|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 56
                                            '(2 6 0 0 0 11 1 6 12 0 13 2 6 14 0
                                              0 15 0 6 0 16 2 19 17 0 18 20 1
                                              17 6 0 21 3 8 6 0 18 6 22 1 17 6
                                              0 23 0 17 0 24 3 25 18 0 18 18 26
                                              4 25 18 0 18 18 18 27 0 29 0 30 0
                                              31 0 32 2 8 6 0 18 33 1 29 34 0
                                              35 2 29 6 0 18 36 2 31 37 0 18 38
                                              2 37 18 0 18 39 3 37 18 0 18 18
                                              40 2 29 0 0 6 41 1 37 0 0 42 2 31
                                              0 0 37 43 3 29 6 0 18 6 44 1 8 0
                                              45 46 0 6 0 47 3 31 37 0 18 37 48
                                              2 6 0 0 0 49 2 6 12 0 0 50 1 29
                                              45 0 51 1 31 34 0 52 1 37 53 0 54
                                              1 25 0 55 56 1 0 7 19 28 1 0 7 8
                                              9 1 0 8 8 10)))))
           '|lookupComplete|)) 
