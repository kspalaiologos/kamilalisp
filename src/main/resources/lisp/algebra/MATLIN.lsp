
(SDEFUN |MATLIN;rowAllZeroes?| ((|x| (M)) (|i| (|Integer|)) ($ (|Boolean|)))
        (SPROG ((#1=#:G721 NIL) (#2=#:G722 NIL) (#3=#:G723 NIL) (|j| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |j| (SPADCALL |x| (QREFELT $ 11)))
                         (LETT #3# (SPADCALL |x| (QREFELT $ 12))) G190
                         (COND ((> |j| #3#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL (SPADCALL |x| |i| |j| (QREFELT $ 13))
                                       (|spadConstant| $ 14) (QREFELT $ 16))
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# NIL) (GO #4=#:G720)))
                              (GO #5=#:G718))))))
                         (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT 'T)))
                #4# (EXIT #2#)))) 

(SDEFUN |MATLIN;colAllZeroes?| ((|x| (M)) (|j| (|Integer|)) ($ (|Boolean|)))
        (SPROG ((#1=#:G729 NIL) (#2=#:G730 NIL) (#3=#:G731 NIL) (|i| NIL))
               (SEQ
                (EXIT
                 (SEQ
                  (SEQ
                   (EXIT
                    (SEQ (LETT |i| (SPADCALL |x| (QREFELT $ 17)))
                         (LETT #3# (SPADCALL |x| (QREFELT $ 18))) G190
                         (COND ((> |i| #3#) (GO G191)))
                         (SEQ
                          (EXIT
                           (COND
                            ((SPADCALL (SPADCALL |x| |i| |j| (QREFELT $ 13))
                                       (|spadConstant| $ 14) (QREFELT $ 16))
                             (PROGN
                              (LETT #1# (PROGN (LETT #2# NIL) (GO #4=#:G728)))
                              (GO #5=#:G726))))))
                         (LETT |i| (+ |i| 1)) (GO G190) G191 (EXIT NIL)))
                   #5# (EXIT #1#))
                  (EXIT 'T)))
                #4# (EXIT #2#)))) 

(SDEFUN |MATLIN;minorDet|
        ((|x| (M)) (|m| (|Integer|)) (|l| (|List| (|Integer|)))
         (|i| (|Integer|)) (|v| (|PrimitiveArray| (|Union| R #1="uncomputed")))
         ($ (R)))
        (SPROG
         ((|j| (|Integer|)) (|rl| (|List| (|Integer|))) (|pos| (|Boolean|))
          (#2=#:G763 NIL) (|ans| (R)) (|md| (R)) (#3=#:G750 NIL)
          (|minC| (|Integer|)) (|minR| (|Integer|)) (|z| (|Union| R #1#)))
         (SEQ
          (EXIT
           (SEQ (LETT |z| (QAREF1 |v| |m|))
                (EXIT
                 (COND ((QEQCAR |z| 0) (QCDR |z|))
                       ('T
                        (SEQ (LETT |ans| (|spadConstant| $ 14)) (LETT |rl| NIL)
                             (LETT |j| (|SPADfirst| |l|)) (LETT |l| (CDR |l|))
                             (LETT |pos| 'T)
                             (LETT |minR| (SPADCALL |x| (QREFELT $ 17)))
                             (LETT |minC| (SPADCALL |x| (QREFELT $ 11)))
                             (EXIT
                              (SEQ G190 NIL
                                   (SEQ
                                    (COND
                                     ((SPADCALL
                                       (SPADCALL |x| (+ |j| |minR|)
                                                 (+ |i| |minC|) (QREFELT $ 13))
                                       (|spadConstant| $ 14) (QREFELT $ 16))
                                      (LETT |ans|
                                            (SEQ
                                             (LETT |md|
                                                   (SPADCALL
                                                    (|MATLIN;minorDet| |x|
                                                     (- |m|
                                                        (EXPT 2
                                                              (PROG1
                                                                  (LETT #3#
                                                                        |j|)
                                                                (|check_subtype2|
                                                                 (>= #3# 0)
                                                                 '(|NonNegativeInteger|)
                                                                 '(|Integer|)
                                                                 #3#))))
                                                     (SPADCALL (REVERSE |rl|)
                                                               |l|
                                                               (QREFELT $ 20))
                                                     (+ |i| 1) |v| $)
                                                    (SPADCALL |x|
                                                              (+ |j| |minR|)
                                                              (+ |i| |minC|)
                                                              (QREFELT $ 13))
                                                    (QREFELT $ 22)))
                                             (EXIT
                                              (COND
                                               (|pos|
                                                (SPADCALL |ans| |md|
                                                          (QREFELT $ 23)))
                                               ('T
                                                (SPADCALL |ans| |md|
                                                          (QREFELT $
                                                                   24)))))))))
                                    (EXIT
                                     (COND
                                      ((NULL |l|)
                                       (SEQ (QSETAREF1 |v| |m| (CONS 0 |ans|))
                                            (EXIT
                                             (PROGN
                                              (LETT #2# |ans|)
                                              (GO #4=#:G762)))))
                                      ('T
                                       (SEQ (LETT |pos| (NULL |pos|))
                                            (LETT |rl| (CONS |j| |rl|))
                                            (LETT |j| (|SPADfirst| |l|))
                                            (EXIT (LETT |l| (CDR |l|))))))))
                                   NIL (GO G190) G191 (EXIT NIL)))))))))
          #4# (EXIT #2#)))) 

(SDEFUN |MATLIN;minordet;MR;4| ((|x| (M)) ($ (R)))
        (SPROG
         ((#1=#:G780 NIL) (|i| NIL) (#2=#:G779 NIL) (#3=#:G778 NIL)
          (|maxC| (|Integer|)) (|minR| (|Integer|))
          (|v| (|PrimitiveArray| (|Union| R "uncomputed"))) (#4=#:G767 NIL)
          (|n1| (|Integer|)) (|ndim| (|NonNegativeInteger|)))
         (SEQ
          (COND
           ((SPADCALL (LETT |ndim| (SPADCALL |x| (QREFELT $ 26)))
                      (SPADCALL |x| (QREFELT $ 27)) (QREFELT $ 28))
            (|error| "determinant: matrix must be square"))
           ((EQL |ndim| 0) (|spadConstant| $ 21))
           ('T
            (SEQ (LETT |n1| (- |ndim| 1))
                 (LETT |v|
                       (MAKEARR1
                        (PROG1 (LETT #4# (- (EXPT 2 |ndim|) 1))
                          (|check_subtype2| (>= #4# 0) '(|NonNegativeInteger|)
                                            '(|Integer|) #4#))
                        (CONS 1 "uncomputed")))
                 (LETT |minR| (SPADCALL |x| (QREFELT $ 17)))
                 (LETT |maxC| (SPADCALL |x| (QREFELT $ 12)))
                 (SEQ (LETT |i| 0) (LETT #3# |n1|) G190
                      (COND ((|greater_SI| |i| #3#) (GO G191)))
                      (SEQ
                       (EXIT
                        (QSETAREF1 |v|
                                   (|sub_SI| (SPADCALL 2 |i| (QREFELT $ 30)) 1)
                                   (CONS 0
                                         (SPADCALL |x| (+ |i| |minR|) |maxC|
                                                   (QREFELT $ 13))))))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                 (EXIT
                  (|MATLIN;minorDet| |x|
                   (|sub_SI| (SPADCALL 2 |ndim| (QREFELT $ 30)) 2)
                   (PROGN
                    (LETT #2# NIL)
                    (SEQ (LETT |i| 0) (LETT #1# |n1|) G190
                         (COND ((|greater_SI| |i| #1#) (GO G191)))
                         (SEQ (EXIT (LETT #2# (CONS |i| #2#))))
                         (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                         (EXIT (NREVERSE #2#))))
                   0 |v| $)))))))) 

(SDEFUN |MATLIN;elRow1!;M2IM;5|
        ((|m| (M)) (|i| (|Integer|)) (|j| (|Integer|)) ($ (M)))
        (SPROG ((|vec| (|Row|)))
               (SEQ (LETT |vec| (SPADCALL |m| |i| (QREFELT $ 32)))
                    (SPADCALL |m| |i| (SPADCALL |m| |j| (QREFELT $ 32))
                              (QREFELT $ 33))
                    (SPADCALL |m| |j| |vec| (QREFELT $ 33)) (EXIT |m|)))) 

(SDEFUN |MATLIN;elRow2!;MR2IM;6|
        ((|m| (M)) (|a| (R)) (|i| (|Integer|)) (|j| (|Integer|)) ($ (M)))
        (SPROG ((|vec| (|Row|)))
               (SEQ
                (LETT |vec|
                      (SPADCALL
                       (CONS #'|MATLIN;elRow2!;MR2IM;6!0| (VECTOR $ |a|))
                       (SPADCALL |m| |j| (QREFELT $ 32)) (QREFELT $ 36)))
                (LETT |vec|
                      (SPADCALL (ELT $ 23) (SPADCALL |m| |i| (QREFELT $ 32))
                                |vec| (QREFELT $ 38)))
                (SPADCALL |m| |i| |vec| (QREFELT $ 33)) (EXIT |m|)))) 

(SDEFUN |MATLIN;elRow2!;MR2IM;6!0| ((|r1| NIL) ($$ NIL))
        (PROG (|a| $)
          (LETT |a| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |a| |r1| (QREFELT $ 22)))))) 

(SDEFUN |MATLIN;elColumn2!;MR2IM;7|
        ((|m| (M)) (|a| (R)) (|i| (|Integer|)) (|j| (|Integer|)) ($ (M)))
        (SPROG ((|vec| (|Col|)))
               (SEQ
                (LETT |vec|
                      (SPADCALL
                       (CONS #'|MATLIN;elColumn2!;MR2IM;7!0| (VECTOR $ |a|))
                       (SPADCALL |m| |j| (QREFELT $ 40)) (QREFELT $ 41)))
                (LETT |vec|
                      (SPADCALL (ELT $ 23) (SPADCALL |m| |i| (QREFELT $ 40))
                                |vec| (QREFELT $ 42)))
                (SPADCALL |m| |i| |vec| (QREFELT $ 43)) (EXIT |m|)))) 

(SDEFUN |MATLIN;elColumn2!;MR2IM;7!0| ((|r1| NIL) ($$ NIL))
        (PROG (|a| $)
          (LETT |a| (QREFELT $$ 1))
          (LETT $ (QREFELT $$ 0))
          (RETURN (PROGN (SPADCALL |a| |r1| (QREFELT $ 22)))))) 

(SDEFUN |MATLIN;fractionFreeGauss!;2M;8| ((|x| (M)) ($ (M)))
        (SPROG
         ((#1=#:G832 NIL) (|j| NIL) (|lasti| #2=(|Integer|)) (#3=#:G824 NIL)
          (#4=#:G826 NIL) (|i| #5=(|Integer|)) (|b| (R)) (#6=#:G805 NIL)
          (|val| (R)) (#7=#:G831 NIL) (|l| NIL) (|pv| (R)) (#8=#:G830 NIL)
          (#9=#:G829 NIL) (|k| NIL) (|c| (R)) (|ans| (R)) (#10=#:G825 NIL)
          (|rown| #2#) (#11=#:G828 NIL) (#12=#:G827 NIL) (|maxC| (|Integer|))
          (|minC| (|Integer|)) (|maxR| (|Integer|)) (|minR| #5#)
          (|ndim| (|NonNegativeInteger|)))
         (SEQ (LETT |ndim| (SPADCALL |x| (QREFELT $ 26)))
              (EXIT
               (COND ((EQL |ndim| 1) |x|)
                     ('T
                      (SEQ (LETT |ans| (LETT |b| (|spadConstant| $ 21)))
                           (LETT |minR| (SPADCALL |x| (QREFELT $ 17)))
                           (LETT |maxR| (SPADCALL |x| (QREFELT $ 18)))
                           (LETT |minC| (SPADCALL |x| (QREFELT $ 11)))
                           (LETT |maxC| (SPADCALL |x| (QREFELT $ 12)))
                           (LETT |i| |minR|)
                           (SEQ
                            (EXIT
                             (SEQ (LETT |j| |minC|) (LETT #12# |maxC|) G190
                                  (COND ((> |j| #12#) (GO G191)))
                                  (SEQ
                                   (COND
                                    ((SPADCALL
                                      (SPADCALL |x| |i| |j| (QREFELT $ 13))
                                      (|spadConstant| $ 14) (QREFELT $ 45))
                                     (SEQ (LETT |rown| (- |minR| 1))
                                          (SEQ
                                           (EXIT
                                            (SEQ (LETT |k| (+ |i| 1))
                                                 (LETT #11# |maxR|) G190
                                                 (COND
                                                  ((> |k| #11#) (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (COND
                                                    ((SPADCALL
                                                      (SPADCALL |x| |k| |j|
                                                                (QREFELT $ 13))
                                                      (|spadConstant| $ 14)
                                                      (QREFELT $ 16))
                                                     (SEQ (LETT |rown| |k|)
                                                          (EXIT
                                                           (PROGN
                                                            (LETT #10# 1)
                                                            (GO
                                                             #13=#:G798))))))))
                                                 (LETT |k| (+ |k| 1)) (GO G190)
                                                 G191 (EXIT NIL)))
                                           #13# (EXIT #10#))
                                          (EXIT
                                           (COND
                                            ((> |rown| (- |minR| 1))
                                             (SEQ
                                              (SPADCALL |x| |i| |rown|
                                                        (QREFELT $ 46))
                                              (EXIT
                                               (LETT |ans|
                                                     (SPADCALL |ans|
                                                               (QREFELT $
                                                                        47)))))))))))
                                   (LETT |c|
                                         (SPADCALL |x| |i| |j| (QREFELT $ 13)))
                                   (EXIT
                                    (COND
                                     ((SPADCALL |c| (|spadConstant| $ 14)
                                                (QREFELT $ 45))
                                      "next j")
                                     ('T
                                      (SEQ
                                       (EXIT
                                        (SEQ
                                         (SEQ (LETT |k| (+ |i| 1))
                                              (LETT #9# |maxR|) G190
                                              (COND ((> |k| #9#) (GO G191)))
                                              (SEQ
                                               (EXIT
                                                (COND
                                                 ((SPADCALL
                                                   (SPADCALL |x| |k| |j|
                                                             (QREFELT $ 13))
                                                   (|spadConstant| $ 14)
                                                   (QREFELT $ 45))
                                                  (SEQ (LETT |l| (+ |j| 1))
                                                       (LETT #8# |maxC|) G190
                                                       (COND
                                                        ((> |l| #8#)
                                                         (GO G191)))
                                                       (SEQ
                                                        (EXIT
                                                         (SPADCALL |x| |k| |l|
                                                                   (PROG2
                                                                       (LETT
                                                                        #6#
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          |c|
                                                                          (SPADCALL
                                                                           |x|
                                                                           |k|
                                                                           |l|
                                                                           (QREFELT
                                                                            $
                                                                            13))
                                                                          (QREFELT
                                                                           $
                                                                           22))
                                                                         |b|
                                                                         (QREFELT
                                                                          $
                                                                          49)))
                                                                       (QCDR
                                                                        #6#)
                                                                     (|check_union2|
                                                                      (QEQCAR
                                                                       #6# 0)
                                                                      (QREFELT
                                                                       $ 6)
                                                                      (|Union|
                                                                       (QREFELT
                                                                        $ 6)
                                                                       #14="failed")
                                                                      #6#))
                                                                   (QREFELT $
                                                                            50))))
                                                       (LETT |l| (+ |l| 1))
                                                       (GO G190) G191
                                                       (EXIT NIL)))
                                                 ('T
                                                  (SEQ
                                                   (LETT |pv|
                                                         (SPADCALL |x| |k| |j|
                                                                   (QREFELT $
                                                                            13)))
                                                   (SPADCALL |x| |k| |j|
                                                             (|spadConstant| $
                                                                             14)
                                                             (QREFELT $ 50))
                                                   (EXIT
                                                    (SEQ (LETT |l| (+ |j| 1))
                                                         (LETT #7# |maxC|) G190
                                                         (COND
                                                          ((> |l| #7#)
                                                           (GO G191)))
                                                         (SEQ
                                                          (LETT |val|
                                                                (SPADCALL
                                                                 (SPADCALL |c|
                                                                           (SPADCALL
                                                                            |x|
                                                                            |k|
                                                                            |l|
                                                                            (QREFELT
                                                                             $
                                                                             13))
                                                                           (QREFELT
                                                                            $
                                                                            22))
                                                                 (SPADCALL |pv|
                                                                           (SPADCALL
                                                                            |x|
                                                                            |i|
                                                                            |l|
                                                                            (QREFELT
                                                                             $
                                                                             13))
                                                                           (QREFELT
                                                                            $
                                                                            22))
                                                                 (QREFELT $
                                                                          24)))
                                                          (EXIT
                                                           (SPADCALL |x| |k|
                                                                     |l|
                                                                     (PROG2
                                                                         (LETT
                                                                          #6#
                                                                          (SPADCALL
                                                                           |val|
                                                                           |b|
                                                                           (QREFELT
                                                                            $
                                                                            49)))
                                                                         (QCDR
                                                                          #6#)
                                                                       (|check_union2|
                                                                        (QEQCAR
                                                                         #6# 0)
                                                                        (QREFELT
                                                                         $ 6)
                                                                        (|Union|
                                                                         (QREFELT
                                                                          $ 6)
                                                                         #14#)
                                                                        #6#))
                                                                     (QREFELT $
                                                                              50))))
                                                         (LETT |l| (+ |l| 1))
                                                         (GO G190) G191
                                                         (EXIT NIL))))))))
                                              (LETT |k| (+ |k| 1)) (GO G190)
                                              G191 (EXIT NIL))
                                         (LETT |b| |c|) (LETT |i| (+ |i| 1))
                                         (EXIT
                                          (COND
                                           ((> |i| |maxR|)
                                            (PROGN
                                             (LETT #3#
                                                   (PROGN
                                                    (LETT #4# 1)
                                                    (GO #15=#:G816)))
                                             (GO #16=#:G814)))))))
                                       #16# (EXIT #3#))))))
                                  (LETT |j| (+ |j| 1)) (GO G190) G191
                                  (EXIT NIL)))
                            #15# (EXIT #4#))
                           (COND
                            ((SPADCALL |ans| (|spadConstant| $ 21)
                                       (QREFELT $ 16))
                             (SEQ (LETT |lasti| (- |i| 1))
                                  (EXIT
                                   (SEQ (LETT |j| 1) (LETT #1# |maxC|) G190
                                        (COND
                                         ((|greater_SI| |j| #1#) (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (SPADCALL |x| |lasti| |j|
                                                    (SPADCALL
                                                     (SPADCALL |x| |lasti| |j|
                                                               (QREFELT $ 51))
                                                     (QREFELT $ 47))
                                                    (QREFELT $ 52))))
                                        (LETT |j| (|inc_SI| |j|)) (GO G190)
                                        G191 (EXIT NIL))))))
                           (EXIT |x|)))))))) 

(SDEFUN |MATLIN;lastStep| ((|x| (M)) ($ (M)))
        (SPROG
         ((|iCol| #1=(|Integer|)) (#2=#:G839 NIL) (|ss| (R)) (#3=#:G836 NIL)
          (#4=#:G835 (R)) (#5=#:G837 (R)) (#6=#:G848 NIL) (|k| NIL)
          (#7=#:G847 NIL) (|j| NIL) (|i| NIL) (|maxC1| (|Integer|))
          (|maxR1| #1#) (|det| (R)) (|exCol| (|Integer|)) (|maxC| #1#)
          (|minC| (|Integer|)) (|maxR| (|Integer|)) (|minR| (|Integer|))
          (|ndim| (|NonNegativeInteger|)))
         (SEQ (LETT |ndim| (SPADCALL |x| (QREFELT $ 26)))
              (LETT |minR| (SPADCALL |x| (QREFELT $ 17)))
              (LETT |maxR| (SPADCALL |x| (QREFELT $ 18)))
              (LETT |minC| (SPADCALL |x| (QREFELT $ 11)))
              (LETT |maxC| (- (+ |minC| |ndim|) 1))
              (LETT |exCol| (SPADCALL |x| (QREFELT $ 12)))
              (LETT |det| (SPADCALL |x| |maxR| |maxC| (QREFELT $ 51)))
              (LETT |maxR1| (- |maxR| 1)) (LETT |maxC1| (+ |maxC| 1))
              (LETT |iCol| (- |maxC| 1))
              (SEQ (LETT |i| |maxR1|) G190 (COND ((< |i| 1) (GO G191)))
                   (SEQ
                    (SEQ (LETT |j| |maxC1|) (LETT #7# |exCol|) G190
                         (COND ((> |j| #7#) (GO G191)))
                         (SEQ
                          (LETT |ss|
                                (PROGN
                                 (LETT #3# NIL)
                                 (SEQ (LETT |k| 1) (LETT #6# (- |maxR| |i|))
                                      G190
                                      (COND ((|greater_SI| |k| #6#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (PROGN
                                         (LETT #5#
                                               (SPADCALL
                                                (SPADCALL |x| |i|
                                                          (+ |iCol| |k|)
                                                          (QREFELT $ 51))
                                                (SPADCALL |x| (+ |i| |k|) |j|
                                                          (QREFELT $ 51))
                                                (QREFELT $ 22)))
                                         (COND
                                          (#3#
                                           (LETT #4#
                                                 (SPADCALL #4# #5#
                                                           (QREFELT $ 23))))
                                          ('T
                                           (PROGN
                                            (LETT #4# #5#)
                                            (LETT #3# 'T)))))))
                                      (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                      (EXIT NIL))
                                 (COND (#3# #4#) ('T (|spadConstant| $ 14)))))
                          (EXIT
                           (SPADCALL |x| |i| |j|
                                     (PROG2
                                         (LETT #2#
                                               (SPADCALL
                                                (SPADCALL
                                                 (SPADCALL |det|
                                                           (SPADCALL |x| |i|
                                                                     |j|
                                                                     (QREFELT $
                                                                              51))
                                                           (QREFELT $ 22))
                                                 |ss| (QREFELT $ 24))
                                                (SPADCALL |x| |i| |iCol|
                                                          (QREFELT $ 51))
                                                (QREFELT $ 49)))
                                         (QCDR #2#)
                                       (|check_union2| (QEQCAR #2# 0)
                                                       (QREFELT $ 6)
                                                       (|Union| (QREFELT $ 6)
                                                                "failed")
                                                       #2#))
                                     (QREFELT $ 52))))
                         (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))
                    (EXIT (LETT |iCol| (- |iCol| 1))))
                   (LETT |i| (+ |i| -1)) (GO G190) G191 (EXIT NIL))
              (EXIT
               (SPADCALL |x| |minR| |maxR| |maxC1| |exCol| (QREFELT $ 54)))))) 

(SDEFUN |MATLIN;invertIfCan;MU;10| ((|y| (M)) ($ (|Union| M "failed")))
        (SPROG
         ((|den| (|Union| R "failed"))
          (|adjRec| (|Record| (|:| |adjMat| M) (|:| |detMat| R)))
          (|nr| (|NonNegativeInteger|)))
         (SEQ
          (COND
           ((SPADCALL (LETT |nr| (SPADCALL |y| (QREFELT $ 26)))
                      (SPADCALL |y| (QREFELT $ 27)) (QREFELT $ 28))
            (|error| "invertIfCan: matrix must be square"))
           ((EQL |nr| 0) (CONS 0 |y|))
           (#1='T
            (SEQ (LETT |adjRec| (SPADCALL |y| (QREFELT $ 56)))
                 (LETT |den| (SPADCALL (QCDR |adjRec|) (QREFELT $ 57)))
                 (EXIT
                  (COND ((QEQCAR |den| 1) (CONS 1 "failed"))
                        (#1#
                         (CONS 0
                               (SPADCALL (QCDR |den|) (QCAR |adjRec|)
                                         (QREFELT $ 58)))))))))))) 

(SDEFUN |MATLIN;adjoint;MR;11|
        ((|y| (M)) ($ (|Record| (|:| |adjMat| M) (|:| |detMat| R))))
        (SPROG
         ((|det| (R)) (|ffr| (M)) (|x| (M)) (|maxC| (|Integer|))
          (|maxR| (|Integer|)) (|nr| (|NonNegativeInteger|)))
         (SEQ
          (COND
           ((SPADCALL (LETT |nr| (SPADCALL |y| (QREFELT $ 26)))
                      (SPADCALL |y| (QREFELT $ 27)) (QREFELT $ 28))
            (|error| "adjoint: matrix must be square"))
           ((EQL |nr| 0) (CONS |y| (|spadConstant| $ 21)))
           ('T
            (SEQ (LETT |maxR| (SPADCALL |y| (QREFELT $ 18)))
                 (LETT |maxC| (SPADCALL |y| (QREFELT $ 12)))
                 (LETT |x|
                       (SPADCALL (SPADCALL |y| (QREFELT $ 61))
                                 (SPADCALL |nr| (|spadConstant| $ 21)
                                           (QREFELT $ 62))
                                 (QREFELT $ 63)))
                 (LETT |ffr| (SPADCALL |x| (QREFELT $ 53)))
                 (LETT |det| (SPADCALL |ffr| |maxR| |maxC| (QREFELT $ 51)))
                 (EXIT (CONS (|MATLIN;lastStep| |ffr| $) |det|)))))))) 

(SDEFUN |MATLIN;rowEchelon;2M;12| ((|y| (M)) ($ (M)))
        (SPADCALL |y| (QREFELT $ 65))) 

(SDEFUN |MATLIN;rank;MNni;13| ((|y| (M)) ($ (|NonNegativeInteger|)))
        (SPADCALL |y| (QREFELT $ 67))) 

(SDEFUN |MATLIN;nullity;MNni;14| ((|y| (M)) ($ (|NonNegativeInteger|)))
        (SPADCALL |y| (QREFELT $ 69))) 

(SDEFUN |MATLIN;determinant;MR;15| ((|y| (M)) ($ (R)))
        (SPADCALL |y| (QREFELT $ 71))) 

(SDEFUN |MATLIN;inverse;MU;16| ((|y| (M)) ($ (|Union| M "failed")))
        (SPADCALL |y| (QREFELT $ 73))) 

(SDEFUN |MATLIN;nullSpace;ML;17| ((|y| (M)) ($ (|List| |Col|)))
        (SPADCALL |y| (QREFELT $ 76))) 

(SDEFUN |MATLIN;nullSpace;ML;18| ((|y| (M)) ($ (|List| |Col|)))
        (SPROG ((#1=#:G882 NIL) (|v| NIL) (#2=#:G881 NIL))
               (SEQ
                (PROGN
                 (LETT #2# NIL)
                 (SEQ (LETT |v| NIL)
                      (LETT #1#
                            (SPADCALL
                             (SPADCALL (LIST #'|MATLIN;nullSpace;ML;18!0|) |y|
                                       (QREFELT $ 80))
                             (QREFELT $ 83)))
                      G190
                      (COND
                       ((OR (ATOM #1#) (PROGN (LETT |v| (CAR #1#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #2#
                              (CONS
                               (SPADCALL (LIST #'|MATLIN;nullSpace;ML;18!1|)
                                         |v| (QREFELT $ 86))
                               #2#))))
                      (LETT #1# (CDR #1#)) (GO G190) G191
                      (EXIT (NREVERSE #2#))))))) 

(SDEFUN |MATLIN;nullSpace;ML;18!1| ((|r1| NIL) ($$ NIL)) |r1|) 

(SDEFUN |MATLIN;nullSpace;ML;18!0| ((|r1| NIL) ($$ NIL)) |r1|) 

(SDEFUN |MATLIN;nullSpace;ML;19| ((|m| (M)) ($ (|List| |Col|)))
        (SPADCALL |m| (QREFELT $ 88))) 

(SDEFUN |MATLIN;determinant;MR;20| ((|y| (M)) ($ (R)))
        (SPROG ((|fm| (M)) (|ndim| (|NonNegativeInteger|)))
               (SEQ
                (COND
                 ((SPADCALL (LETT |ndim| (SPADCALL |y| (QREFELT $ 26)))
                            (SPADCALL |y| (QREFELT $ 27)) (QREFELT $ 28))
                  (|error| "determinant: matrix must be square"))
                 ((EQL |ndim| 0) (|spadConstant| $ 21))
                 ('T
                  (SEQ
                   (LETT |fm|
                         (SPADCALL (SPADCALL |y| (QREFELT $ 61))
                                   (QREFELT $ 53)))
                   (EXIT
                    (SPADCALL |fm| (SPADCALL |fm| (QREFELT $ 18))
                              (SPADCALL |fm| (QREFELT $ 12))
                              (QREFELT $ 51))))))))) 

(SDEFUN |MATLIN;rank;MNni;21| ((|x| (M)) ($ (|NonNegativeInteger|)))
        (SPROG
         ((|rk| (|NonNegativeInteger|)) (#1=#:G894 NIL) (|i| (|Integer|))
          (|y| (M)) (|rh| (|NonNegativeInteger|)))
         (SEQ
          (LETT |y|
                (SEQ (LETT |rk| (SPADCALL |x| (QREFELT $ 26)))
                     (LETT |rh| (SPADCALL |x| (QREFELT $ 27)))
                     (EXIT
                      (COND
                       ((> |rk| |rh|)
                        (SEQ (LETT |rk| |rh|)
                             (EXIT (SPADCALL |x| (QREFELT $ 89)))))
                       ('T (SPADCALL |x| (QREFELT $ 61)))))))
          (LETT |y| (SPADCALL |y| (QREFELT $ 53)))
          (LETT |i| (SPADCALL |y| (QREFELT $ 18)))
          (SEQ G190
               (COND
                ((NULL
                  (COND ((> |rk| 0) (|MATLIN;rowAllZeroes?| |y| |i| $))
                        ('T NIL)))
                 (GO G191)))
               (SEQ (LETT |i| (- |i| 1))
                    (EXIT
                     (LETT |rk|
                           (PROG1 (LETT #1# (- |rk| 1))
                             (|check_subtype2| (>= #1# 0)
                                               '(|NonNegativeInteger|)
                                               '(|Integer|) #1#)))))
               NIL (GO G190) G191 (EXIT NIL))
          (EXIT |rk|)))) 

(SDEFUN |MATLIN;nullity;MNni;22| ((|x| (M)) ($ (|NonNegativeInteger|)))
        (SPROG ((#1=#:G899 NIL))
               (PROG1
                   (LETT #1#
                         (- (SPADCALL |x| (QREFELT $ 27))
                            (SPADCALL |x| (QREFELT $ 68))))
                 (|check_subtype2| (>= #1# 0) '(|NonNegativeInteger|)
                                   '(|Integer|) #1#)))) 

(SDEFUN |MATLIN;normalizedDivide;2RR;23|
        ((|n| (R)) (|d| (R))
         ($ (|Record| (|:| |quotient| R) (|:| |remainder| R))))
        (SPROG ((|qr| (|Record| (|:| |quotient| R) (|:| |remainder| R))))
               (SEQ (LETT |qr| (SPADCALL |n| |d| (QREFELT $ 91)))
                    (EXIT
                     (COND
                      ((SPADCALL (QCDR |qr|) (|spadConstant| $ 14)
                                 (QREFELT $ 92))
                       |qr|)
                      ((SPADCALL |d| (|spadConstant| $ 14) (QREFELT $ 93))
                       (SEQ
                        (PROGN
                         (RPLACD |qr|
                                 (SPADCALL (QCDR |qr|) |d| (QREFELT $ 23)))
                         (QCDR |qr|))
                        (PROGN
                         (RPLACA |qr|
                                 (SPADCALL (QCAR |qr|) (|spadConstant| $ 21)
                                           (QREFELT $ 24)))
                         (QCAR |qr|))
                        (EXIT |qr|)))
                      ('T
                       (SEQ
                        (PROGN
                         (RPLACD |qr|
                                 (SPADCALL (QCDR |qr|) |d| (QREFELT $ 24)))
                         (QCDR |qr|))
                        (PROGN
                         (RPLACA |qr|
                                 (SPADCALL (QCAR |qr|) (|spadConstant| $ 21)
                                           (QREFELT $ 23)))
                         (QCAR |qr|))
                        (EXIT |qr|)))))))) 

(SDEFUN |MATLIN;normalizedDivide;2RR;24|
        ((|n| (R)) (|d| (R))
         ($ (|Record| (|:| |quotient| R) (|:| |remainder| R))))
        (SPADCALL |n| |d| (QREFELT $ 91))) 

(SDEFUN |MATLIN;rowEchelon;2M;25| ((|y| (M)) ($ (M)))
        (SPROG
         ((|i| #1=(|Integer|)) (#2=#:G951 NIL) (|k1| NIL)
          (|qr| (|Record| (|:| |quotient| R) (|:| |remainder| R)))
          (#3=#:G950 NIL) (|k| NIL) (|xij| (R)) (#4=#:G949 NIL) (|jj| NIL)
          (|un|
           (|Record| (|:| |unit| R) (|:| |canonical| R) (|:| |associate| R)))
          (|val2| (R)) (|val1| (R)) (#5=#:G948 NIL) (|a1| (R)) (#6=#:G920 NIL)
          (|b1| (R)) (|d| (R)) (|b| (R)) (|a| (R)) (|#G67| (R)) (|#G66| (R))
          (|#G65| (R))
          (|aa| (|Record| (|:| |coef1| R) (|:| |coef2| R) (|:| |generator| R)))
          (#7=#:G947 NIL) (|xnj| (R)) (|n| (|Integer|)) (|xkj| (R))
          (#8=#:G946 NIL) (#9=#:G944 NIL) (#10=#:G945 NIL) (|j| NIL)
          (|maxC| (|Integer|)) (|minC| (|Integer|)) (|maxR| (|Integer|))
          (|minR| #1#) (|x| (M)))
         (SEQ (LETT |x| (SPADCALL |y| (QREFELT $ 61)))
              (LETT |minR| (SPADCALL |x| (QREFELT $ 17)))
              (LETT |maxR| (SPADCALL |x| (QREFELT $ 18)))
              (LETT |minC| (SPADCALL |x| (QREFELT $ 11)))
              (LETT |maxC| (SPADCALL |x| (QREFELT $ 12)))
              (LETT |n| (- |minR| 1)) (LETT |i| |minR|)
              (SEQ
               (EXIT
                (SEQ (LETT |j| |minC|) (LETT #10# |maxC|) G190
                     (COND ((> |j| #10#) (GO G191)))
                     (SEQ
                      (COND
                       ((> |i| |maxR|)
                        (PROGN (LETT #9# |$NoValue|) (GO #11=#:G941))))
                      (LETT |n| (- |minR| 1))
                      (SEQ (LETT |k| |i|) (LETT #8# |maxR|) G190
                           (COND ((> |k| #8#) (GO G191)))
                           (SEQ
                            (EXIT
                             (COND
                              ((NULL
                                (SPADCALL
                                 (LETT |xkj|
                                       (SPADCALL |x| |k| |j| (QREFELT $ 13)))
                                 (QREFELT $ 96)))
                               (COND
                                ((OR (EQL |n| (- |minR| 1))
                                     (SPADCALL |xkj| |xnj| (QREFELT $ 97)))
                                 (SEQ (LETT |n| |k|)
                                      (EXIT (LETT |xnj| |xkj|)))))))))
                           (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))
                      (EXIT
                       (COND ((EQL |n| (- |minR| 1)) "next j")
                             ('T
                              (SEQ (SPADCALL |x| |i| |n| (QREFELT $ 46))
                                   (SEQ (LETT |k| (+ |i| 1)) (LETT #7# |maxR|)
                                        G190 (COND ((> |k| #7#) (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (COND
                                           ((SPADCALL
                                             (SPADCALL |x| |k| |j|
                                                       (QREFELT $ 13))
                                             (|spadConstant| $ 14)
                                             (QREFELT $ 45))
                                            "next k")
                                           ('T
                                            (SEQ
                                             (LETT |aa|
                                                   (SPADCALL
                                                    (SPADCALL |x| |i| |j|
                                                              (QREFELT $ 13))
                                                    (SPADCALL |x| |k| |j|
                                                              (QREFELT $ 13))
                                                    (QREFELT $ 99)))
                                             (PROGN
                                              (LETT |#G65| (QVELT |aa| 0))
                                              (LETT |#G66| (QVELT |aa| 1))
                                              (LETT |#G67| (QVELT |aa| 2))
                                              (LETT |a| |#G65|)
                                              (LETT |b| |#G66|)
                                              (LETT |d| |#G67|))
                                             (LETT |b1|
                                                   (PROG2
                                                       (LETT #6#
                                                             (SPADCALL
                                                              (SPADCALL |x| |i|
                                                                        |j|
                                                                        (QREFELT
                                                                         $ 13))
                                                              |d|
                                                              (QREFELT $ 49)))
                                                       (QCDR #6#)
                                                     (|check_union2|
                                                      (QEQCAR #6# 0)
                                                      (QREFELT $ 6)
                                                      (|Union| (QREFELT $ 6)
                                                               #12="failed")
                                                      #6#)))
                                             (LETT |a1|
                                                   (PROG2
                                                       (LETT #6#
                                                             (SPADCALL
                                                              (SPADCALL |x| |k|
                                                                        |j|
                                                                        (QREFELT
                                                                         $ 13))
                                                              |d|
                                                              (QREFELT $ 49)))
                                                       (QCDR #6#)
                                                     (|check_union2|
                                                      (QEQCAR #6# 0)
                                                      (QREFELT $ 6)
                                                      (|Union| (QREFELT $ 6)
                                                               #12#)
                                                      #6#)))
                                             (SEQ (LETT |k1| (+ |j| 1))
                                                  (LETT #5# |maxC|) G190
                                                  (COND
                                                   ((> |k1| #5#) (GO G191)))
                                                  (SEQ
                                                   (LETT |val1|
                                                         (SPADCALL
                                                          (SPADCALL |a|
                                                                    (SPADCALL
                                                                     |x| |i|
                                                                     |k1|
                                                                     (QREFELT $
                                                                              13))
                                                                    (QREFELT $
                                                                             22))
                                                          (SPADCALL |b|
                                                                    (SPADCALL
                                                                     |x| |k|
                                                                     |k1|
                                                                     (QREFELT $
                                                                              13))
                                                                    (QREFELT $
                                                                             22))
                                                          (QREFELT $ 23)))
                                                   (LETT |val2|
                                                         (SPADCALL
                                                          (SPADCALL
                                                           (SPADCALL |a1|
                                                                     (SPADCALL
                                                                      |x| |i|
                                                                      |k1|
                                                                      (QREFELT
                                                                       $ 13))
                                                                     (QREFELT $
                                                                              22))
                                                           (QREFELT $ 47))
                                                          (SPADCALL |b1|
                                                                    (SPADCALL
                                                                     |x| |k|
                                                                     |k1|
                                                                     (QREFELT $
                                                                              13))
                                                                    (QREFELT $
                                                                             22))
                                                          (QREFELT $ 23)))
                                                   (SPADCALL |x| |i| |k1|
                                                             |val1|
                                                             (QREFELT $ 50))
                                                   (EXIT
                                                    (SPADCALL |x| |k| |k1|
                                                              |val2|
                                                              (QREFELT $ 50))))
                                                  (LETT |k1| (+ |k1| 1))
                                                  (GO G190) G191 (EXIT NIL))
                                             (SPADCALL |x| |i| |j| |d|
                                                       (QREFELT $ 50))
                                             (EXIT
                                              (SPADCALL |x| |k| |j|
                                                        (|spadConstant| $ 14)
                                                        (QREFELT $ 50))))))))
                                        (LETT |k| (+ |k| 1)) (GO G190) G191
                                        (EXIT NIL))
                                   (LETT |un|
                                         (SPADCALL
                                          (SPADCALL |x| |i| |j| (QREFELT $ 13))
                                          (QREFELT $ 101)))
                                   (SPADCALL |x| |i| |j| (QVELT |un| 1)
                                             (QREFELT $ 50))
                                   (COND
                                    ((SPADCALL (QVELT |un| 2)
                                               (|spadConstant| $ 21)
                                               (QREFELT $ 16))
                                     (SEQ (LETT |jj| (+ |j| 1))
                                          (LETT #4# |maxC|) G190
                                          (COND ((> |jj| #4#) (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (SPADCALL |x| |i| |jj|
                                                      (SPADCALL (QVELT |un| 2)
                                                                (SPADCALL |x|
                                                                          |i|
                                                                          |jj|
                                                                          (QREFELT
                                                                           $
                                                                           13))
                                                                (QREFELT $ 22))
                                                      (QREFELT $ 50))))
                                          (LETT |jj| (+ |jj| 1)) (GO G190) G191
                                          (EXIT NIL))))
                                   (LETT |xij|
                                         (SPADCALL |x| |i| |j| (QREFELT $ 13)))
                                   (SEQ (LETT |k| |minR|) (LETT #3# (- |i| 1))
                                        G190 (COND ((> |k| #3#) (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (COND
                                           ((SPADCALL
                                             (SPADCALL |x| |k| |j|
                                                       (QREFELT $ 13))
                                             (|spadConstant| $ 14)
                                             (QREFELT $ 45))
                                            "next k")
                                           ('T
                                            (SEQ
                                             (LETT |qr|
                                                   (SPADCALL
                                                    (SPADCALL |x| |k| |j|
                                                              (QREFELT $ 13))
                                                    |xij| (QREFELT $ 95)))
                                             (SPADCALL |x| |k| |j| (QCDR |qr|)
                                                       (QREFELT $ 50))
                                             (EXIT
                                              (SEQ (LETT |k1| (+ |j| 1))
                                                   (LETT #2# |maxC|) G190
                                                   (COND
                                                    ((> |k1| #2#) (GO G191)))
                                                   (SEQ
                                                    (EXIT
                                                     (SPADCALL |x| |k| |k1|
                                                               (SPADCALL
                                                                (SPADCALL |x|
                                                                          |k|
                                                                          |k1|
                                                                          (QREFELT
                                                                           $
                                                                           13))
                                                                (SPADCALL
                                                                 (QCAR |qr|)
                                                                 (SPADCALL |x|
                                                                           |i|
                                                                           |k1|
                                                                           (QREFELT
                                                                            $
                                                                            13))
                                                                 (QREFELT $
                                                                          22))
                                                                (QREFELT $ 24))
                                                               (QREFELT $
                                                                        50))))
                                                   (LETT |k1| (+ |k1| 1))
                                                   (GO G190) G191
                                                   (EXIT NIL))))))))
                                        (LETT |k| (+ |k| 1)) (GO G190) G191
                                        (EXIT NIL))
                                   (EXIT (LETT |i| (+ |i| 1))))))))
                     (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL)))
               #11# (EXIT #9#))
              (EXIT |x|)))) 

(SDEFUN |MATLIN;determinant;MR;26| ((|x| (M)) ($ (R)))
        (SPADCALL |x| (QREFELT $ 31))) 

(DECLAIM (NOTINLINE |MatrixLinearAlgebraFunctions;|)) 

(DEFUN |MatrixLinearAlgebraFunctions| (&REST #1=#:G953)
  (SPROG NIL
         (PROG (#2=#:G954)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|MatrixLinearAlgebraFunctions|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |MatrixLinearAlgebraFunctions;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|MatrixLinearAlgebraFunctions|)))))))))) 

(DEFUN |MatrixLinearAlgebraFunctions;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 (|devaluate| |#2|))
    (LETT DV$3 (|devaluate| |#3|))
    (LETT DV$4 (|devaluate| |#4|))
    (LETT |dv$| (LIST '|MatrixLinearAlgebraFunctions| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 102))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST (|HasCategory| |#1| '(|Field|))
                                             (|HasCategory| |#1|
                                                            '(|EuclideanDomain|))
                                             (|HasCategory| |#1|
                                                            '(|IntegralDomain|))))))
    (|haddProp| |$ConstructorCache| '|MatrixLinearAlgebraFunctions|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (COND
     ((|testBitVector| |pv$| 3)
      (PROGN
       (QSETREFV $ 53
                 (CONS (|dispatchFunction| |MATLIN;fractionFreeGauss!;2M;8|)
                       $))
       (QSETREFV $ 60 (CONS (|dispatchFunction| |MATLIN;invertIfCan;MU;10|) $))
       (QSETREFV $ 56 (CONS (|dispatchFunction| |MATLIN;adjoint;MR;11|) $)))))
    (COND
     ((|testBitVector| |pv$| 1)
      (PROGN
       (QSETREFV $ 66 (CONS (|dispatchFunction| |MATLIN;rowEchelon;2M;12|) $))
       (QSETREFV $ 68 (CONS (|dispatchFunction| |MATLIN;rank;MNni;13|) $))
       (QSETREFV $ 70 (CONS (|dispatchFunction| |MATLIN;nullity;MNni;14|) $))
       (QSETREFV $ 72 (CONS (|dispatchFunction| |MATLIN;determinant;MR;15|) $))
       (QSETREFV $ 74 (CONS (|dispatchFunction| |MATLIN;inverse;MU;16|) $))
       (COND
        ((|HasCategory| |#3| '(|shallowlyMutable|))
         (QSETREFV $ 77
                   (CONS (|dispatchFunction| |MATLIN;nullSpace;ML;17|) $)))
        ('T
         (QSETREFV $ 77
                   (CONS (|dispatchFunction| |MATLIN;nullSpace;ML;18|) $))))))
     ((|testBitVector| |pv$| 3)
      (PROGN
       (QSETREFV $ 77 (CONS (|dispatchFunction| |MATLIN;nullSpace;ML;19|) $))
       (QSETREFV $ 72 (CONS (|dispatchFunction| |MATLIN;determinant;MR;20|) $))
       (QSETREFV $ 68 (CONS (|dispatchFunction| |MATLIN;rank;MNni;21|) $))
       (QSETREFV $ 70 (CONS (|dispatchFunction| |MATLIN;nullity;MNni;22|) $))
       (COND
        ((|testBitVector| |pv$| 2)
         (PROGN
          (COND
           ((|HasCategory| |#1| '(|IntegerNumberSystem|))
            (QSETREFV $ 95
                      (CONS
                       (|dispatchFunction| |MATLIN;normalizedDivide;2RR;23|)
                       $)))
           ('T
            (QSETREFV $ 95
                      (CONS
                       (|dispatchFunction| |MATLIN;normalizedDivide;2RR;24|)
                       $))))
          (QSETREFV $ 66
                    (CONS (|dispatchFunction| |MATLIN;rowEchelon;2M;25|)
                          $)))))))
     ('T
      (QSETREFV $ 72
                (CONS (|dispatchFunction| |MATLIN;determinant;MR;26|) $))))
    $))) 

(MAKEPROP '|MatrixLinearAlgebraFunctions| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (|local| |#3|) (|local| |#4|) (|Integer|) (0 . |minColIndex|)
              (5 . |maxColIndex|) (10 . |qelt|) (17 . |Zero|) (|Boolean|)
              (21 . ~=) (27 . |minRowIndex|) (32 . |maxRowIndex|) (|List| 10)
              (37 . |concat!|) (43 . |One|) (47 . *) (53 . +) (59 . -)
              (|NonNegativeInteger|) (65 . |nrows|) (70 . |ncols|) (75 . ~=)
              (|SingleInteger|) (81 . ^) |MATLIN;minordet;MR;4| (87 . |row|)
              (93 . |setRow!|) |MATLIN;elRow1!;M2IM;5| (|Mapping| 6 6)
              (100 . |map|) (|Mapping| 6 6 6) (106 . |map|)
              |MATLIN;elRow2!;MR2IM;6| (113 . |column|) (119 . |map|)
              (125 . |map|) (132 . |setColumn!|) |MATLIN;elColumn2!;MR2IM;7|
              (139 . =) (145 . |swapRows!|) (152 . -) (|Union| $ '"failed")
              (157 . |exquo|) (163 . |qsetelt!|) (171 . |elt|)
              (178 . |setelt!|) (186 . |fractionFreeGauss!|)
              (191 . |subMatrix|) (|Record| (|:| |adjMat| 9) (|:| |detMat| 6))
              (200 . |adjoint|) (205 . |recip|) (210 . *)
              (|Union| 9 '#1="failed") (216 . |invertIfCan|) (221 . |copy|)
              (226 . |scalarMatrix|) (232 . |horizConcat|)
              (|InnerMatrixLinearAlgebraFunctions| 6 7 8 9)
              (238 . |rowEchelon|) (243 . |rowEchelon|) (248 . |rank|)
              (253 . |rank|) (258 . |nullity|) (263 . |nullity|)
              (268 . |determinant|) (273 . |determinant|) (278 . |inverse|)
              (283 . |inverse|) (|List| 8) (288 . |nullSpace|)
              (293 . |nullSpace|) (|Matrix| 6)
              (|MatrixCategoryFunctions2| 6 7 8 9 6 84 84 78) (298 . |map|)
              (|List| 84) (|InnerMatrixLinearAlgebraFunctions| 6 84 84 78)
              (304 . |nullSpace|) (|Vector| 6)
              (|FiniteLinearAggregateFunctions2| 6 84 6 8) (309 . |map|)
              (|InnerMatrixQuotientFieldFunctions| 6 7 8 9 (|Fraction| 6)
                                                   (|Vector| (|Fraction| 6))
                                                   (|Vector| (|Fraction| 6))
                                                   (|Matrix| (|Fraction| 6)))
              (315 . |nullSpace|) (320 . |transpose|)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (325 . |divide|) (331 . >=) (337 . >)
              (|Record| (|:| |quotient| 6) (|:| |remainder| 6))
              (343 . |normalizedDivide|) (349 . |zero?|) (354 . |sizeLess?|)
              (|Record| (|:| |coef1| $) (|:| |coef2| $) (|:| |generator| $))
              (360 . |extendedEuclidean|)
              (|Record| (|:| |unit| $) (|:| |canonical| $) (|:| |associate| $))
              (366 . |unitNormal|))
           '#(|rowEchelon| 371 |rank| 376 |nullity| 381 |nullSpace| 386
              |normalizedDivide| 391 |minordet| 397 |invertIfCan| 402 |inverse|
              407 |fractionFreeGauss!| 412 |elRow2!| 417 |elRow1!| 425
              |elColumn2!| 432 |determinant| 440 |adjoint| 445)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|determinant| (|#1| |#4|)) T)
                                   '((|minordet| (|#1| |#4|)) T)
                                   '((|elRow1!|
                                      (|#4| |#4| (|Integer|) (|Integer|)))
                                     T)
                                   '((|elRow2!|
                                      (|#4| |#4| |#1| (|Integer|) (|Integer|)))
                                     T)
                                   '((|elColumn2!|
                                      (|#4| |#4| |#1| (|Integer|) (|Integer|)))
                                     T)
                                   '((|rank| ((|NonNegativeInteger|) |#4|))
                                     (|has| 6 (|IntegralDomain|)))
                                   '((|nullity| ((|NonNegativeInteger|) |#4|))
                                     (|has| 6 (|IntegralDomain|)))
                                   '((|nullSpace| ((|List| |#3|) |#4|))
                                     (|has| 6 (|IntegralDomain|)))
                                   '((|fractionFreeGauss!| (|#4| |#4|))
                                     (|has| 6 (|IntegralDomain|)))
                                   '((|invertIfCan| ((|Union| |#4| #1#) |#4|))
                                     (|has| 6 (|IntegralDomain|)))
                                   '((|adjoint|
                                      ((|Record| (|:| |adjMat| |#4|)
                                                 (|:| |detMat| |#1|))
                                       |#4|))
                                     (|has| 6 (|IntegralDomain|)))
                                   '((|rowEchelon| (|#4| |#4|))
                                     (|has| 6 (|EuclideanDomain|)))
                                   '((|normalizedDivide|
                                      ((|Record| (|:| |quotient| |#1|)
                                                 (|:| |remainder| |#1|))
                                       |#1| |#1|))
                                     (|has| 6 (|EuclideanDomain|)))
                                   '((|inverse| ((|Union| |#4| "failed") |#4|))
                                     (|has| 6 (|Field|))))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 101
                                            '(1 9 10 0 11 1 9 10 0 12 3 9 6 0
                                              10 10 13 0 6 0 14 2 6 15 0 0 16 1
                                              9 10 0 17 1 9 10 0 18 2 19 0 0 0
                                              20 0 6 0 21 2 6 0 0 0 22 2 6 0 0
                                              0 23 2 6 0 0 0 24 1 9 25 0 26 1 9
                                              25 0 27 2 25 15 0 0 28 2 29 0 0
                                              25 30 2 9 7 0 10 32 3 9 0 0 10 7
                                              33 2 7 0 35 0 36 3 7 0 37 0 0 38
                                              2 9 8 0 10 40 2 8 0 35 0 41 3 8 0
                                              37 0 0 42 3 9 0 0 10 8 43 2 6 15
                                              0 0 45 3 9 0 0 10 10 46 1 6 0 0
                                              47 2 6 48 0 0 49 4 9 6 0 10 10 6
                                              50 3 9 6 0 10 10 51 4 9 6 0 10 10
                                              6 52 1 0 9 9 53 5 9 0 0 10 10 10
                                              10 54 1 0 55 9 56 1 6 48 0 57 2 9
                                              0 6 0 58 1 0 59 9 60 1 9 0 0 61 2
                                              9 0 25 6 62 2 9 0 0 0 63 1 64 9 9
                                              65 1 0 9 9 66 1 64 25 9 67 1 0 25
                                              9 68 1 64 25 9 69 1 0 25 9 70 1
                                              64 6 9 71 1 0 6 9 72 1 64 59 9 73
                                              1 0 59 9 74 1 64 75 9 76 1 0 75 9
                                              77 2 79 78 35 9 80 1 82 81 78 83
                                              2 85 8 35 84 86 1 87 75 9 88 1 9
                                              0 0 89 2 6 90 0 0 91 2 6 15 0 0
                                              92 2 6 15 0 0 93 2 0 94 6 6 95 1
                                              6 15 0 96 2 6 15 0 0 97 2 6 98 0
                                              0 99 1 6 100 0 101 1 2 9 9 66 1 3
                                              25 9 68 1 3 25 9 70 1 3 75 9 77 2
                                              2 94 6 6 95 1 0 6 9 31 1 3 59 9
                                              60 1 1 59 9 74 1 3 9 9 53 4 0 9 9
                                              6 10 10 39 3 0 9 9 10 10 34 4 0 9
                                              9 6 10 10 44 1 0 6 9 72 1 3 55 9
                                              56)))))
           '|lookupComplete|)) 
