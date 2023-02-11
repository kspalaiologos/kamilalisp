
(SDEFUN |ALGSC;recip;$U;1| ((|x| ($)) ($ (|Union| $ "failed")))
        (SPADCALL |x| (QREFELT $ 13))) 

(SDEFUN |ALGSC;*;Sm2$;2| ((|m| (|SquareMatrix| |n| R)) (|x| ($)) ($ ($)))
        (SPADCALL (SPADCALL |m| (QREFELT $ 17)) |x| (QREFELT $ 18))) 

(SDEFUN |ALGSC;coerce;V$;3| ((|v| (|Vector| R)) ($ ($)))
        (SPADCALL |v| (QREFELT $ 21))) 

(SDEFUN |ALGSC;structuralConstants;V;4| (($ (|Vector| (|Matrix| R))))
        (QREFELT $ 9)) 

(SDEFUN |ALGSC;coordinates;$V;5| ((|x| ($)) ($ (|Vector| R)))
        (SPADCALL (SPADCALL |x| (QREFELT $ 26)) (QREFELT $ 27))) 

(SDEFUN |ALGSC;coordinates;$VV;6|
        ((|x| ($)) (|b| (|Vector| $)) ($ (|Vector| R)))
        (SPROG
         ((#1=#:G740 NIL)
          (|res|
           (|Record| (|:| |particular| (|Union| (|Vector| R) "failed"))
                     (|:| |basis| (|List| (|Vector| R)))))
          (#2=#:G744 NIL) (|i| NIL) (|transitionMatrix| (|Matrix| R))
          (|m| (|NonNegativeInteger|)) (#3=#:G730 NIL))
         (SEQ
          (LETT |m|
                (PROG1 (LETT #3# (SPADCALL |b| (QREFELT $ 31)))
                  (|check_subtype2| (>= #3# 0) '(|NonNegativeInteger|)
                                    '(|Integer|) #3#)))
          (LETT |transitionMatrix|
                (MAKE_MATRIX1 (QREFELT $ 7) |m| (|spadConstant| $ 32)))
          (SEQ (LETT |i| 1) (LETT #2# |m|) G190
               (COND ((|greater_SI| |i| #2#) (GO G191)))
               (SEQ
                (EXIT
                 (SPADCALL |transitionMatrix| |i|
                           (SPADCALL (SPADCALL |b| |i| (QREFELT $ 33))
                                     (QREFELT $ 28))
                           (QREFELT $ 34))))
               (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
          (LETT |res|
                (SPADCALL |transitionMatrix| (SPADCALL |x| (QREFELT $ 28))
                          (QREFELT $ 38)))
          (COND
           ((NULL (NULL (QCDR |res|)))
            (|error|
             "coordinates: warning your 'basis' is linearly dependent")))
          (EXIT
           (COND
            ((QEQCAR (QCAR |res|) 1)
             (|error|
              "coordinates: first argument is not in linear span of second argument"))
            ('T
             (PROG2 (LETT #1# (QCAR |res|))
                 (QCDR #1#)
               (|check_union2| (QEQCAR #1# 0) (|Vector| (QREFELT $ 6))
                               (|Union| (|Vector| (QREFELT $ 6)) "failed")
                               #1#)))))))) 

(SDEFUN |ALGSC;basis;V;7| (($ (|Vector| $)))
        (SPROG
         ((#1=#:G747 NIL) (#2=#:G750 NIL) (#3=#:G752 NIL) (|i| NIL)
          (#4=#:G751 NIL))
         (SEQ
          (PROGN
           (LETT #4# (GETREFV #5=(QREFELT $ 7)))
           (SEQ (LETT |i| 1) (LETT #3# #5#) (LETT #2# 0) G190
                (COND ((|greater_SI| |i| #3#) (GO G191)))
                (SEQ
                 (EXIT
                  (SETELT #4# #2#
                          (SPADCALL
                           (PROG1 (LETT #1# |i|)
                             (|check_subtype2| (> #1# 0) '(|PositiveInteger|)
                                               '(|NonNegativeInteger|) #1#))
                           (QREFELT $ 43)))))
                (LETT #2# (PROG1 (|inc_SI| #2#) (LETT |i| (|inc_SI| |i|))))
                (GO G190) G191 (EXIT NIL))
           #4#)))) 

(SDEFUN |ALGSC;someBasis;V;8| (($ (|Vector| $))) (SPADCALL (QREFELT $ 40))) 

(SDEFUN |ALGSC;rank;Pi;9| (($ (|PositiveInteger|))) (QREFELT $ 7)) 

(SDEFUN |ALGSC;elt;$IR;10| ((|x| ($)) (|i| (|Integer|)) ($ (R)))
        (SPADCALL |x| |i| (QREFELT $ 46))) 

(SDEFUN |ALGSC;coerce;$Of;11| ((|x| ($)) ($ (|OutputForm|)))
        (SPROG
         ((#1=#:G777 NIL) (|le| (|List| (|OutputForm|))) (|coef| (R))
          (#2=#:G778 NIL) (|i| NIL))
         (SEQ
          (COND
           ((SPADCALL |x| (QREFELT $ 49))
            (SPADCALL (|spadConstant| $ 32) (QREFELT $ 51)))
           ('T
            (SEQ (LETT |le| NIL)
                 (SEQ (LETT |i| 1) (LETT #2# (QREFELT $ 7)) G190
                      (COND ((|greater_SI| |i| #2#) (GO G191)))
                      (SEQ
                       (EXIT
                        (SEQ (LETT |coef| (SPADCALL |x| |i| (QREFELT $ 47)))
                             (EXIT
                              (COND
                               ((NULL (SPADCALL |coef| (QREFELT $ 52)))
                                (PROGN
                                 (LETT #1#
                                       (COND
                                        ((SPADCALL |coef| (|spadConstant| $ 53)
                                                   (QREFELT $ 54))
                                         (LETT |le|
                                               (CONS
                                                (SPADCALL
                                                 (SPADCALL (QREFELT $ 8) |i|
                                                           (QREFELT $ 57))
                                                 (QREFELT $ 58))
                                                |le|)))
                                        ('T
                                         (LETT |le|
                                               (CONS
                                                (SPADCALL
                                                 (SPADCALL |coef|
                                                           (QREFELT $ 51))
                                                 (SPADCALL
                                                  (SPADCALL (QREFELT $ 8) |i|
                                                            (QREFELT $ 57))
                                                  (QREFELT $ 58))
                                                 (QREFELT $ 59))
                                                |le|)))))
                                 (GO #3=#:G770)))))))
                       #3# (EXIT #1#))
                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
                 (EXIT (SPADCALL (ELT $ 60) |le| (QREFELT $ 63))))))))) 

(SDEFUN |ALGSC;*;3$;12| ((|x| ($)) (|y| ($)) ($ ($)))
        (SPROG
         ((|h| (R)) (#1=#:G790 NIL) (|j| NIL) (#2=#:G789 NIL) (|i| NIL)
          (#3=#:G788 NIL) (|k| NIL) (|v| (|Vector| R)))
         (SEQ (LETT |v| (MAKEARR1 (QREFELT $ 7) (|spadConstant| $ 32)))
              (SEQ (LETT |k| 1) (LETT #3# (QREFELT $ 7)) G190
                   (COND ((|greater_SI| |k| #3#) (GO G191)))
                   (SEQ (LETT |h| (|spadConstant| $ 32))
                        (SEQ (LETT |i| 1) (LETT #2# (QREFELT $ 7)) G190
                             (COND ((|greater_SI| |i| #2#) (GO G191)))
                             (SEQ
                              (EXIT
                               (SEQ (LETT |j| 1) (LETT #1# (QREFELT $ 7)) G190
                                    (COND ((|greater_SI| |j| #1#) (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT |h|
                                            (SPADCALL |h|
                                                      (SPADCALL
                                                       (SPADCALL
                                                        (SPADCALL |x| |i|
                                                                  (QREFELT $
                                                                           47))
                                                        (SPADCALL |y| |j|
                                                                  (QREFELT $
                                                                           47))
                                                        (QREFELT $ 65))
                                                       (SPADCALL
                                                        (SPADCALL (QREFELT $ 9)
                                                                  |k|
                                                                  (QREFELT $
                                                                           66))
                                                        |i| |j| (QREFELT $ 67))
                                                       (QREFELT $ 65))
                                                      (QREFELT $ 68)))))
                                    (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                                    (EXIT NIL))))
                             (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                             (EXIT NIL))
                        (EXIT (SPADCALL |v| |k| |h| (QREFELT $ 69))))
                   (LETT |k| (|inc_SI| |k|)) (GO G190) G191 (EXIT NIL))
              (EXIT (SPADCALL |v| (QREFELT $ 21)))))) 

(SDEFUN |ALGSC;alternative?;B;13| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G832 NIL) (#2=#:G836 NIL) (|res| (R)) (#3=#:G850 NIL) (|l| NIL)
          (#4=#:G849 NIL) (|r| NIL) (#5=#:G833 NIL) (#6=#:G848 NIL)
          (#7=#:G847 NIL) (#8=#:G846 NIL) (|k| NIL) (#9=#:G834 NIL)
          (#10=#:G845 NIL) (#11=#:G844 NIL) (#12=#:G843 NIL) (#13=#:G842 NIL)
          (|j| NIL) (#14=#:G835 NIL) (#15=#:G841 NIL) (#16=#:G840 NIL)
          (#17=#:G839 NIL) (#18=#:G838 NIL) (#19=#:G837 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |i| 1) (LETT #19# (QREFELT $ 7)) G190
                 (COND ((|greater_SI| |i| #19#) (GO G191)))
                 (SEQ
                  (SEQ (LETT |j| 1) (LETT #18# (SPADCALL |i| 1 (QREFELT $ 72)))
                       G190 (COND ((|greater_SI| |j| #18#) (GO G191)))
                       (SEQ
                        (EXIT
                         (SEQ (LETT |k| |j|) (LETT #17# (QREFELT $ 7)) G190
                              (COND ((> |k| #17#) (GO G191)))
                              (SEQ
                               (EXIT
                                (SEQ (LETT |r| 1) (LETT #16# (QREFELT $ 7))
                                     G190
                                     (COND ((|greater_SI| |r| #16#) (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (SEQ (LETT |res| (|spadConstant| $ 32))
                                            (SEQ (LETT |l| 1)
                                                 (LETT #15# (QREFELT $ 7)) G190
                                                 (COND
                                                  ((|greater_SI| |l| #15#)
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT |res|
                                                         (SPADCALL
                                                          (SPADCALL |res|
                                                                    (SPADCALL
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (QREFELT
                                                                         $ 9)
                                                                        |l|
                                                                        (QREFELT
                                                                         $ 66))
                                                                       |j| |k|
                                                                       (QREFELT
                                                                        $ 67))
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (QREFELT
                                                                         $ 9)
                                                                        |l|
                                                                        (QREFELT
                                                                         $ 66))
                                                                       |k| |j|
                                                                       (QREFELT
                                                                        $ 67))
                                                                      (QREFELT
                                                                       $ 68))
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       (QREFELT
                                                                        $ 9)
                                                                       |r|
                                                                       (QREFELT
                                                                        $ 66))
                                                                      |i| |l|
                                                                      (QREFELT
                                                                       $ 67))
                                                                     (QREFELT $
                                                                              65))
                                                                    (QREFELT $
                                                                             73))
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 9) |l|
                                                              (QREFELT $ 66))
                                                             |i| |j|
                                                             (QREFELT $ 67))
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 9) |r|
                                                              (QREFELT $ 66))
                                                             |l| |k|
                                                             (QREFELT $ 67))
                                                            (QREFELT $ 65))
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 9) |l|
                                                              (QREFELT $ 66))
                                                             |i| |k|
                                                             (QREFELT $ 67))
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 9) |r|
                                                              (QREFELT $ 66))
                                                             |l| |j|
                                                             (QREFELT $ 67))
                                                            (QREFELT $ 65))
                                                           (QREFELT $ 68))
                                                          (QREFELT $ 68)))))
                                                 (LETT |l| (|inc_SI| |l|))
                                                 (GO G190) G191 (EXIT NIL))
                                            (EXIT
                                             (COND
                                              ((NULL
                                                (SPADCALL |res|
                                                          (QREFELT $ 52)))
                                               (PROGN
                                                (LETT #14#
                                                      (SEQ
                                                       (SPADCALL
                                                        "algebra is not right alternative"
                                                        (QREFELT $ 76))
                                                       (EXIT
                                                        (PROGN
                                                         (LETT #2# NIL)
                                                         (GO #20=#:G831)))))
                                                (GO #21=#:G798)))))))
                                      #21# (EXIT #14#))
                                     (LETT |r| (|inc_SI| |r|)) (GO G190) G191
                                     (EXIT NIL))))
                              (LETT |k| (+ |k| 1)) (GO G190) G191 (EXIT NIL))))
                       (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))
                  (EXIT
                   (SEQ (LETT |j| |i|) (LETT #13# (QREFELT $ 7)) G190
                        (COND ((> |j| #13#) (GO G191)))
                        (SEQ
                         (SEQ (LETT |k| 1)
                              (LETT #12# (SPADCALL |j| 1 (QREFELT $ 72))) G190
                              (COND ((|greater_SI| |k| #12#) (GO G191)))
                              (SEQ
                               (EXIT
                                (SEQ (LETT |r| 1) (LETT #11# (QREFELT $ 7))
                                     G190
                                     (COND ((|greater_SI| |r| #11#) (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (SEQ (LETT |res| (|spadConstant| $ 32))
                                            (SEQ (LETT |l| 1)
                                                 (LETT #10# (QREFELT $ 7)) G190
                                                 (COND
                                                  ((|greater_SI| |l| #10#)
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT |res|
                                                         (SPADCALL
                                                          (SPADCALL |res|
                                                                    (SPADCALL
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (QREFELT
                                                                         $ 9)
                                                                        |l|
                                                                        (QREFELT
                                                                         $ 66))
                                                                       |i| |j|
                                                                       (QREFELT
                                                                        $ 67))
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (QREFELT
                                                                         $ 9)
                                                                        |l|
                                                                        (QREFELT
                                                                         $ 66))
                                                                       |j| |i|
                                                                       (QREFELT
                                                                        $ 67))
                                                                      (QREFELT
                                                                       $ 68))
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       (QREFELT
                                                                        $ 9)
                                                                       |r|
                                                                       (QREFELT
                                                                        $ 66))
                                                                      |l| |k|
                                                                      (QREFELT
                                                                       $ 67))
                                                                     (QREFELT $
                                                                              65))
                                                                    (QREFELT $
                                                                             68))
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 9) |l|
                                                              (QREFELT $ 66))
                                                             |j| |k|
                                                             (QREFELT $ 67))
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 9) |r|
                                                              (QREFELT $ 66))
                                                             |i| |l|
                                                             (QREFELT $ 67))
                                                            (QREFELT $ 65))
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 9) |l|
                                                              (QREFELT $ 66))
                                                             |i| |k|
                                                             (QREFELT $ 67))
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 9) |r|
                                                              (QREFELT $ 66))
                                                             |j| |l|
                                                             (QREFELT $ 67))
                                                            (QREFELT $ 65))
                                                           (QREFELT $ 68))
                                                          (QREFELT $ 73)))))
                                                 (LETT |l| (|inc_SI| |l|))
                                                 (GO G190) G191 (EXIT NIL))
                                            (EXIT
                                             (COND
                                              ((NULL
                                                (SPADCALL |res|
                                                          (QREFELT $ 52)))
                                               (PROGN
                                                (LETT #9#
                                                      (SEQ
                                                       (SPADCALL
                                                        "algebra is not left alternative"
                                                        (QREFELT $ 76))
                                                       (EXIT
                                                        (PROGN
                                                         (LETT #2# NIL)
                                                         (GO #20#)))))
                                                (GO #22=#:G808)))))))
                                      #22# (EXIT #9#))
                                     (LETT |r| (|inc_SI| |r|)) (GO G190) G191
                                     (EXIT NIL))))
                              (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                              (EXIT NIL))
                         (EXIT
                          (SEQ (LETT |k| |j|) (LETT #8# (QREFELT $ 7)) G190
                               (COND ((> |k| #8#) (GO G191)))
                               (SEQ
                                (SEQ (LETT |r| 1) (LETT #7# (QREFELT $ 7)) G190
                                     (COND ((|greater_SI| |r| #7#) (GO G191)))
                                     (SEQ
                                      (EXIT
                                       (SEQ (LETT |res| (|spadConstant| $ 32))
                                            (SEQ (LETT |l| 1)
                                                 (LETT #6# (QREFELT $ 7)) G190
                                                 (COND
                                                  ((|greater_SI| |l| #6#)
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT |res|
                                                         (SPADCALL
                                                          (SPADCALL |res|
                                                                    (SPADCALL
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (QREFELT
                                                                         $ 9)
                                                                        |l|
                                                                        (QREFELT
                                                                         $ 66))
                                                                       |i| |j|
                                                                       (QREFELT
                                                                        $ 67))
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (QREFELT
                                                                         $ 9)
                                                                        |l|
                                                                        (QREFELT
                                                                         $ 66))
                                                                       |j| |i|
                                                                       (QREFELT
                                                                        $ 67))
                                                                      (QREFELT
                                                                       $ 68))
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       (QREFELT
                                                                        $ 9)
                                                                       |r|
                                                                       (QREFELT
                                                                        $ 66))
                                                                      |l| |k|
                                                                      (QREFELT
                                                                       $ 67))
                                                                     (QREFELT $
                                                                              65))
                                                                    (QREFELT $
                                                                             68))
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 9) |l|
                                                              (QREFELT $ 66))
                                                             |j| |k|
                                                             (QREFELT $ 67))
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 9) |r|
                                                              (QREFELT $ 66))
                                                             |i| |l|
                                                             (QREFELT $ 67))
                                                            (QREFELT $ 65))
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 9) |l|
                                                              (QREFELT $ 66))
                                                             |i| |k|
                                                             (QREFELT $ 67))
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 9) |r|
                                                              (QREFELT $ 66))
                                                             |j| |l|
                                                             (QREFELT $ 67))
                                                            (QREFELT $ 65))
                                                           (QREFELT $ 68))
                                                          (QREFELT $ 73)))))
                                                 (LETT |l| (|inc_SI| |l|))
                                                 (GO G190) G191 (EXIT NIL))
                                            (EXIT
                                             (COND
                                              ((NULL
                                                (SPADCALL |res|
                                                          (QREFELT $ 52)))
                                               (PROGN
                                                (LETT #5#
                                                      (SEQ
                                                       (SPADCALL
                                                        "algebra is not left alternative"
                                                        (QREFELT $ 76))
                                                       (EXIT
                                                        (PROGN
                                                         (LETT #2# NIL)
                                                         (GO #20#)))))
                                                (GO #23=#:G816)))))))
                                      #23# (EXIT #5#))
                                     (LETT |r| (|inc_SI| |r|)) (GO G190) G191
                                     (EXIT NIL))
                                (EXIT
                                 (SEQ (LETT |r| 1) (LETT #4# (QREFELT $ 7))
                                      G190
                                      (COND ((|greater_SI| |r| #4#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (SEQ (LETT |res| (|spadConstant| $ 32))
                                             (SEQ (LETT |l| 1)
                                                  (LETT #3# (QREFELT $ 7)) G190
                                                  (COND
                                                   ((|greater_SI| |l| #3#)
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (LETT |res|
                                                          (SPADCALL
                                                           (SPADCALL |res|
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         (QREFELT
                                                                          $ 9)
                                                                         |l|
                                                                         (QREFELT
                                                                          $
                                                                          66))
                                                                        |j| |k|
                                                                        (QREFELT
                                                                         $ 67))
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         (QREFELT
                                                                          $ 9)
                                                                         |l|
                                                                         (QREFELT
                                                                          $
                                                                          66))
                                                                        |k| |j|
                                                                        (QREFELT
                                                                         $ 67))
                                                                       (QREFELT
                                                                        $ 68))
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (QREFELT
                                                                         $ 9)
                                                                        |r|
                                                                        (QREFELT
                                                                         $ 66))
                                                                       |i| |l|
                                                                       (QREFELT
                                                                        $ 67))
                                                                      (QREFELT
                                                                       $ 65))
                                                                     (QREFELT $
                                                                              73))
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QREFELT $ 9)
                                                               |l|
                                                               (QREFELT $ 66))
                                                              |i| |j|
                                                              (QREFELT $ 67))
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QREFELT $ 9)
                                                               |r|
                                                               (QREFELT $ 66))
                                                              |l| |k|
                                                              (QREFELT $ 67))
                                                             (QREFELT $ 65))
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QREFELT $ 9)
                                                               |l|
                                                               (QREFELT $ 66))
                                                              |i| |k|
                                                              (QREFELT $ 67))
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QREFELT $ 9)
                                                               |r|
                                                               (QREFELT $ 66))
                                                              |l| |j|
                                                              (QREFELT $ 67))
                                                             (QREFELT $ 65))
                                                            (QREFELT $ 68))
                                                           (QREFELT $ 68)))))
                                                  (LETT |l| (|inc_SI| |l|))
                                                  (GO G190) G191 (EXIT NIL))
                                             (EXIT
                                              (COND
                                               ((NULL
                                                 (SPADCALL |res|
                                                           (QREFELT $ 52)))
                                                (PROGN
                                                 (LETT #1#
                                                       (SEQ
                                                        (SPADCALL
                                                         "algebra is not right alternative"
                                                         (QREFELT $ 76))
                                                        (EXIT
                                                         (PROGN
                                                          (LETT #2# NIL)
                                                          (GO #20#)))))
                                                 (GO #24=#:G822)))))))
                                       #24# (EXIT #1#))
                                      (LETT |r| (|inc_SI| |r|)) (GO G190) G191
                                      (EXIT NIL))))
                               (LETT |k| (+ |k| 1)) (GO G190) G191
                               (EXIT NIL))))
                        (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
            (SPADCALL
             "algebra satisfies 2*associator(a,b,b) = 0 = 2*associator(a,a,b) = 0"
             (QREFELT $ 76))
            (EXIT 'T)))
          #20# (EXIT #2#)))) 

(SDEFUN |ALGSC;associative?;B;14| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G865 NIL) (#2=#:G866 NIL) (|res| (R)) (#3=#:G871 NIL) (|l| NIL)
          (#4=#:G870 NIL) (|r| NIL) (#5=#:G869 NIL) (|k| NIL) (#6=#:G868 NIL)
          (|j| NIL) (#7=#:G867 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |i| 1) (LETT #7# (QREFELT $ 7)) G190
                 (COND ((|greater_SI| |i| #7#) (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |j| 1) (LETT #6# (QREFELT $ 7)) G190
                        (COND ((|greater_SI| |j| #6#) (GO G191)))
                        (SEQ
                         (EXIT
                          (SEQ (LETT |k| 1) (LETT #5# (QREFELT $ 7)) G190
                               (COND ((|greater_SI| |k| #5#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (SEQ (LETT |r| 1) (LETT #4# (QREFELT $ 7))
                                      G190
                                      (COND ((|greater_SI| |r| #4#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (SEQ (LETT |res| (|spadConstant| $ 32))
                                             (SEQ (LETT |l| 1)
                                                  (LETT #3# (QREFELT $ 7)) G190
                                                  (COND
                                                   ((|greater_SI| |l| #3#)
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (LETT |res|
                                                          (SPADCALL
                                                           (SPADCALL |res|
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (QREFELT
                                                                         $ 9)
                                                                        |l|
                                                                        (QREFELT
                                                                         $ 66))
                                                                       |i| |j|
                                                                       (QREFELT
                                                                        $ 67))
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (QREFELT
                                                                         $ 9)
                                                                        |r|
                                                                        (QREFELT
                                                                         $ 66))
                                                                       |l| |k|
                                                                       (QREFELT
                                                                        $ 67))
                                                                      (QREFELT
                                                                       $ 65))
                                                                     (QREFELT $
                                                                              68))
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 9) |l|
                                                              (QREFELT $ 66))
                                                             |j| |k|
                                                             (QREFELT $ 67))
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 9) |r|
                                                              (QREFELT $ 66))
                                                             |i| |l|
                                                             (QREFELT $ 67))
                                                            (QREFELT $ 65))
                                                           (QREFELT $ 73)))))
                                                  (LETT |l| (|inc_SI| |l|))
                                                  (GO G190) G191 (EXIT NIL))
                                             (EXIT
                                              (COND
                                               ((NULL
                                                 (SPADCALL |res|
                                                           (QREFELT $ 52)))
                                                (PROGN
                                                 (LETT #1#
                                                       (SEQ
                                                        (SPADCALL
                                                         "algebra is not associative"
                                                         (QREFELT $ 76))
                                                        (EXIT
                                                         (PROGN
                                                          (LETT #2# NIL)
                                                          (GO #8=#:G864)))))
                                                 (GO #9=#:G858)))))))
                                       #9# (EXIT #1#))
                                      (LETT |r| (|inc_SI| |r|)) (GO G190) G191
                                      (EXIT NIL))))
                               (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                               (EXIT NIL))))
                        (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
            (SPADCALL "algebra is associative" (QREFELT $ 76)) (EXIT 'T)))
          #8# (EXIT #2#)))) 

(SDEFUN |ALGSC;antiAssociative?;B;15| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G886 NIL) (#2=#:G887 NIL) (|res| (R)) (#3=#:G892 NIL) (|l| NIL)
          (#4=#:G891 NIL) (|r| NIL) (#5=#:G890 NIL) (|k| NIL) (#6=#:G889 NIL)
          (|j| NIL) (#7=#:G888 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |i| 1) (LETT #7# (QREFELT $ 7)) G190
                 (COND ((|greater_SI| |i| #7#) (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |j| 1) (LETT #6# (QREFELT $ 7)) G190
                        (COND ((|greater_SI| |j| #6#) (GO G191)))
                        (SEQ
                         (EXIT
                          (SEQ (LETT |k| 1) (LETT #5# (QREFELT $ 7)) G190
                               (COND ((|greater_SI| |k| #5#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (SEQ (LETT |r| 1) (LETT #4# (QREFELT $ 7))
                                      G190
                                      (COND ((|greater_SI| |r| #4#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (SEQ (LETT |res| (|spadConstant| $ 32))
                                             (SEQ (LETT |l| 1)
                                                  (LETT #3# (QREFELT $ 7)) G190
                                                  (COND
                                                   ((|greater_SI| |l| #3#)
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (LETT |res|
                                                          (SPADCALL
                                                           (SPADCALL |res|
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (QREFELT
                                                                         $ 9)
                                                                        |l|
                                                                        (QREFELT
                                                                         $ 66))
                                                                       |i| |j|
                                                                       (QREFELT
                                                                        $ 67))
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (QREFELT
                                                                         $ 9)
                                                                        |r|
                                                                        (QREFELT
                                                                         $ 66))
                                                                       |l| |k|
                                                                       (QREFELT
                                                                        $ 67))
                                                                      (QREFELT
                                                                       $ 65))
                                                                     (QREFELT $
                                                                              68))
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 9) |l|
                                                              (QREFELT $ 66))
                                                             |j| |k|
                                                             (QREFELT $ 67))
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 9) |r|
                                                              (QREFELT $ 66))
                                                             |i| |l|
                                                             (QREFELT $ 67))
                                                            (QREFELT $ 65))
                                                           (QREFELT $ 68)))))
                                                  (LETT |l| (|inc_SI| |l|))
                                                  (GO G190) G191 (EXIT NIL))
                                             (EXIT
                                              (COND
                                               ((NULL
                                                 (SPADCALL |res|
                                                           (QREFELT $ 52)))
                                                (PROGN
                                                 (LETT #1#
                                                       (SEQ
                                                        (SPADCALL
                                                         "algebra is not anti-associative"
                                                         (QREFELT $ 76))
                                                        (EXIT
                                                         (PROGN
                                                          (LETT #2# NIL)
                                                          (GO #8=#:G885)))))
                                                 (GO #9=#:G879)))))))
                                       #9# (EXIT #1#))
                                      (LETT |r| (|inc_SI| |r|)) (GO G190) G191
                                      (EXIT NIL))))
                               (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                               (EXIT NIL))))
                        (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
            (SPADCALL "algebra is anti-associative" (QREFELT $ 76)) (EXIT 'T)))
          #8# (EXIT #2#)))) 

(SDEFUN |ALGSC;commutative?;B;16| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G903 NIL) (#2=#:G904 NIL) (#3=#:G907 NIL) (|k| NIL)
          (#4=#:G906 NIL) (|j| NIL) (#5=#:G905 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |i| 1) (LETT #5# (QREFELT $ 7)) G190
                 (COND ((|greater_SI| |i| #5#) (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |j| (+ |i| 1)) (LETT #4# (QREFELT $ 7)) G190
                        (COND ((> |j| #4#) (GO G191)))
                        (SEQ
                         (EXIT
                          (SEQ (LETT |k| 1) (LETT #3# (QREFELT $ 7)) G190
                               (COND ((|greater_SI| |k| #3#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((NULL
                                    (SPADCALL
                                     (SPADCALL
                                      (SPADCALL (QREFELT $ 9) |k|
                                                (QREFELT $ 66))
                                      |i| |j| (QREFELT $ 67))
                                     (SPADCALL
                                      (SPADCALL (QREFELT $ 9) |k|
                                                (QREFELT $ 66))
                                      |j| |i| (QREFELT $ 67))
                                     (QREFELT $ 54)))
                                   (PROGN
                                    (LETT #1#
                                          (SEQ
                                           (SPADCALL
                                            "algebra is not commutative"
                                            (QREFELT $ 76))
                                           (EXIT
                                            (PROGN
                                             (LETT #2# NIL)
                                             (GO #6=#:G902)))))
                                    (GO #7=#:G898))))))
                               (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                               (EXIT NIL)))
                         #7# (EXIT #1#))
                        (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
            (SPADCALL "algebra is commutative" (QREFELT $ 76)) (EXIT 'T)))
          #6# (EXIT #2#)))) 

(SDEFUN |ALGSC;antiCommutative?;B;17| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G918 NIL) (#2=#:G919 NIL) (#3=#:G922 NIL) (|k| NIL)
          (#4=#:G921 NIL) (|j| NIL) (#5=#:G920 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |i| 1) (LETT #5# (QREFELT $ 7)) G190
                 (COND ((|greater_SI| |i| #5#) (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |j| |i|) (LETT #4# (QREFELT $ 7)) G190
                        (COND ((> |j| #4#) (GO G191)))
                        (SEQ
                         (EXIT
                          (SEQ (LETT |k| 1) (LETT #3# (QREFELT $ 7)) G190
                               (COND ((|greater_SI| |k| #3#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (COND
                                  ((NULL
                                    (SPADCALL
                                     (COND
                                      ((EQL |i| |j|)
                                       (SPADCALL
                                        (SPADCALL (QREFELT $ 9) |k|
                                                  (QREFELT $ 66))
                                        |i| |i| (QREFELT $ 67)))
                                      ('T
                                       (SPADCALL
                                        (SPADCALL
                                         (SPADCALL (QREFELT $ 9) |k|
                                                   (QREFELT $ 66))
                                         |i| |j| (QREFELT $ 67))
                                        (SPADCALL
                                         (SPADCALL (QREFELT $ 9) |k|
                                                   (QREFELT $ 66))
                                         |j| |i| (QREFELT $ 67))
                                        (QREFELT $ 68))))
                                     (QREFELT $ 52)))
                                   (PROGN
                                    (LETT #1#
                                          (SEQ
                                           (SPADCALL
                                            "algebra is not anti-commutative"
                                            (QREFELT $ 76))
                                           (EXIT
                                            (PROGN
                                             (LETT #2# NIL)
                                             (GO #6=#:G917)))))
                                    (GO #7=#:G913))))))
                               (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                               (EXIT NIL)))
                         #7# (EXIT #1#))
                        (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
            (SPADCALL "algebra is anti-commutative" (QREFELT $ 76)) (EXIT 'T)))
          #6# (EXIT #2#)))) 

(SDEFUN |ALGSC;leftAlternative?;B;18| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G937 NIL) (#2=#:G938 NIL) (|res| (R)) (#3=#:G943 NIL) (|l| NIL)
          (#4=#:G942 NIL) (|r| NIL) (#5=#:G941 NIL) (|k| NIL) (#6=#:G940 NIL)
          (|j| NIL) (#7=#:G939 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |i| 1) (LETT #7# (QREFELT $ 7)) G190
                 (COND ((|greater_SI| |i| #7#) (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |j| |i|) (LETT #6# (QREFELT $ 7)) G190
                        (COND ((> |j| #6#) (GO G191)))
                        (SEQ
                         (EXIT
                          (SEQ (LETT |k| 1) (LETT #5# (QREFELT $ 7)) G190
                               (COND ((|greater_SI| |k| #5#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (SEQ (LETT |r| 1) (LETT #4# (QREFELT $ 7))
                                      G190
                                      (COND ((|greater_SI| |r| #4#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (SEQ (LETT |res| (|spadConstant| $ 32))
                                             (SEQ (LETT |l| 1)
                                                  (LETT #3# (QREFELT $ 7)) G190
                                                  (COND
                                                   ((|greater_SI| |l| #3#)
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (LETT |res|
                                                          (SPADCALL
                                                           (SPADCALL |res|
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         (QREFELT
                                                                          $ 9)
                                                                         |l|
                                                                         (QREFELT
                                                                          $
                                                                          66))
                                                                        |i| |j|
                                                                        (QREFELT
                                                                         $ 67))
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         (QREFELT
                                                                          $ 9)
                                                                         |l|
                                                                         (QREFELT
                                                                          $
                                                                          66))
                                                                        |j| |i|
                                                                        (QREFELT
                                                                         $ 67))
                                                                       (QREFELT
                                                                        $ 68))
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (QREFELT
                                                                         $ 9)
                                                                        |r|
                                                                        (QREFELT
                                                                         $ 66))
                                                                       |l| |k|
                                                                       (QREFELT
                                                                        $ 67))
                                                                      (QREFELT
                                                                       $ 65))
                                                                     (QREFELT $
                                                                              68))
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QREFELT $ 9)
                                                               |l|
                                                               (QREFELT $ 66))
                                                              |j| |k|
                                                              (QREFELT $ 67))
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QREFELT $ 9)
                                                               |r|
                                                               (QREFELT $ 66))
                                                              |i| |l|
                                                              (QREFELT $ 67))
                                                             (QREFELT $ 65))
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QREFELT $ 9)
                                                               |l|
                                                               (QREFELT $ 66))
                                                              |i| |k|
                                                              (QREFELT $ 67))
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QREFELT $ 9)
                                                               |r|
                                                               (QREFELT $ 66))
                                                              |j| |l|
                                                              (QREFELT $ 67))
                                                             (QREFELT $ 65))
                                                            (QREFELT $ 68))
                                                           (QREFELT $ 73)))))
                                                  (LETT |l| (|inc_SI| |l|))
                                                  (GO G190) G191 (EXIT NIL))
                                             (EXIT
                                              (COND
                                               ((NULL
                                                 (SPADCALL |res|
                                                           (QREFELT $ 52)))
                                                (PROGN
                                                 (LETT #1#
                                                       (SEQ
                                                        (SPADCALL
                                                         "algebra is not left alternative"
                                                         (QREFELT $ 76))
                                                        (EXIT
                                                         (PROGN
                                                          (LETT #2# NIL)
                                                          (GO #8=#:G936)))))
                                                 (GO #9=#:G930)))))))
                                       #9# (EXIT #1#))
                                      (LETT |r| (|inc_SI| |r|)) (GO G190) G191
                                      (EXIT NIL))))
                               (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                               (EXIT NIL))))
                        (LETT |j| (+ |j| 1)) (GO G190) G191 (EXIT NIL))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
            (SPADCALL "algebra is left alternative" (QREFELT $ 76)) (EXIT 'T)))
          #8# (EXIT #2#)))) 

(SDEFUN |ALGSC;rightAlternative?;B;19| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G958 NIL) (#2=#:G959 NIL) (|res| (R)) (#3=#:G964 NIL) (|l| NIL)
          (#4=#:G963 NIL) (|r| NIL) (#5=#:G962 NIL) (|k| NIL) (#6=#:G961 NIL)
          (|j| NIL) (#7=#:G960 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |i| 1) (LETT #7# (QREFELT $ 7)) G190
                 (COND ((|greater_SI| |i| #7#) (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |j| 1) (LETT #6# (QREFELT $ 7)) G190
                        (COND ((|greater_SI| |j| #6#) (GO G191)))
                        (SEQ
                         (EXIT
                          (SEQ (LETT |k| |j|) (LETT #5# (QREFELT $ 7)) G190
                               (COND ((> |k| #5#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (SEQ (LETT |r| 1) (LETT #4# (QREFELT $ 7))
                                      G190
                                      (COND ((|greater_SI| |r| #4#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (SEQ (LETT |res| (|spadConstant| $ 32))
                                             (SEQ (LETT |l| 1)
                                                  (LETT #3# (QREFELT $ 7)) G190
                                                  (COND
                                                   ((|greater_SI| |l| #3#)
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (LETT |res|
                                                          (SPADCALL
                                                           (SPADCALL |res|
                                                                     (SPADCALL
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         (QREFELT
                                                                          $ 9)
                                                                         |l|
                                                                         (QREFELT
                                                                          $
                                                                          66))
                                                                        |j| |k|
                                                                        (QREFELT
                                                                         $ 67))
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         (QREFELT
                                                                          $ 9)
                                                                         |l|
                                                                         (QREFELT
                                                                          $
                                                                          66))
                                                                        |k| |j|
                                                                        (QREFELT
                                                                         $ 67))
                                                                       (QREFELT
                                                                        $ 68))
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (QREFELT
                                                                         $ 9)
                                                                        |r|
                                                                        (QREFELT
                                                                         $ 66))
                                                                       |i| |l|
                                                                       (QREFELT
                                                                        $ 67))
                                                                      (QREFELT
                                                                       $ 65))
                                                                     (QREFELT $
                                                                              73))
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QREFELT $ 9)
                                                               |l|
                                                               (QREFELT $ 66))
                                                              |i| |j|
                                                              (QREFELT $ 67))
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QREFELT $ 9)
                                                               |r|
                                                               (QREFELT $ 66))
                                                              |l| |k|
                                                              (QREFELT $ 67))
                                                             (QREFELT $ 65))
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QREFELT $ 9)
                                                               |l|
                                                               (QREFELT $ 66))
                                                              |i| |k|
                                                              (QREFELT $ 67))
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QREFELT $ 9)
                                                               |r|
                                                               (QREFELT $ 66))
                                                              |l| |j|
                                                              (QREFELT $ 67))
                                                             (QREFELT $ 65))
                                                            (QREFELT $ 68))
                                                           (QREFELT $ 68)))))
                                                  (LETT |l| (|inc_SI| |l|))
                                                  (GO G190) G191 (EXIT NIL))
                                             (EXIT
                                              (COND
                                               ((NULL
                                                 (SPADCALL |res|
                                                           (QREFELT $ 52)))
                                                (PROGN
                                                 (LETT #1#
                                                       (SEQ
                                                        (SPADCALL
                                                         "algebra is not right alternative"
                                                         (QREFELT $ 76))
                                                        (EXIT
                                                         (PROGN
                                                          (LETT #2# NIL)
                                                          (GO #8=#:G957)))))
                                                 (GO #9=#:G951)))))))
                                       #9# (EXIT #1#))
                                      (LETT |r| (|inc_SI| |r|)) (GO G190) G191
                                      (EXIT NIL))))
                               (LETT |k| (+ |k| 1)) (GO G190) G191
                               (EXIT NIL))))
                        (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
            (SPADCALL "algebra is right alternative" (QREFELT $ 76))
            (EXIT 'T)))
          #8# (EXIT #2#)))) 

(SDEFUN |ALGSC;flexible?;B;20| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G979 NIL) (#2=#:G980 NIL) (|res| (R)) (#3=#:G985 NIL) (|l| NIL)
          (#4=#:G984 NIL) (|r| NIL) (#5=#:G983 NIL) (|k| NIL) (#6=#:G982 NIL)
          (|j| NIL) (#7=#:G981 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |i| 1) (LETT #7# (QREFELT $ 7)) G190
                 (COND ((|greater_SI| |i| #7#) (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |j| 1) (LETT #6# (QREFELT $ 7)) G190
                        (COND ((|greater_SI| |j| #6#) (GO G191)))
                        (SEQ
                         (EXIT
                          (SEQ (LETT |k| |i|) (LETT #5# (QREFELT $ 7)) G190
                               (COND ((> |k| #5#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (SEQ (LETT |r| 1) (LETT #4# (QREFELT $ 7))
                                      G190
                                      (COND ((|greater_SI| |r| #4#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (SEQ (LETT |res| (|spadConstant| $ 32))
                                             (SEQ (LETT |l| 1)
                                                  (LETT #3# (QREFELT $ 7)) G190
                                                  (COND
                                                   ((|greater_SI| |l| #3#)
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (LETT |res|
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL |res|
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          (QREFELT
                                                                           $ 9)
                                                                          |l|
                                                                          (QREFELT
                                                                           $
                                                                           66))
                                                                         |i|
                                                                         |j|
                                                                         (QREFELT
                                                                          $
                                                                          67))
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          (QREFELT
                                                                           $ 9)
                                                                          |r|
                                                                          (QREFELT
                                                                           $
                                                                           66))
                                                                         |l|
                                                                         |k|
                                                                         (QREFELT
                                                                          $
                                                                          67))
                                                                        (QREFELT
                                                                         $ 65))
                                                                       (QREFELT
                                                                        $ 68))
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (SPADCALL
                                                                (QREFELT $ 9)
                                                                |l|
                                                                (QREFELT $ 66))
                                                               |j| |k|
                                                               (QREFELT $ 67))
                                                              (SPADCALL
                                                               (SPADCALL
                                                                (QREFELT $ 9)
                                                                |r|
                                                                (QREFELT $ 66))
                                                               |i| |l|
                                                               (QREFELT $ 67))
                                                              (QREFELT $ 65))
                                                             (QREFELT $ 73))
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QREFELT $ 9)
                                                               |l|
                                                               (QREFELT $ 66))
                                                              |k| |j|
                                                              (QREFELT $ 67))
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QREFELT $ 9)
                                                               |r|
                                                               (QREFELT $ 66))
                                                              |l| |i|
                                                              (QREFELT $ 67))
                                                             (QREFELT $ 65))
                                                            (QREFELT $ 68))
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 9) |l|
                                                              (QREFELT $ 66))
                                                             |j| |i|
                                                             (QREFELT $ 67))
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 9) |r|
                                                              (QREFELT $ 66))
                                                             |k| |l|
                                                             (QREFELT $ 67))
                                                            (QREFELT $ 65))
                                                           (QREFELT $ 73)))))
                                                  (LETT |l| (|inc_SI| |l|))
                                                  (GO G190) G191 (EXIT NIL))
                                             (EXIT
                                              (COND
                                               ((NULL
                                                 (SPADCALL |res|
                                                           (QREFELT $ 52)))
                                                (PROGN
                                                 (LETT #1#
                                                       (SEQ
                                                        (SPADCALL
                                                         "algebra is not flexible"
                                                         (QREFELT $ 76))
                                                        (EXIT
                                                         (PROGN
                                                          (LETT #2# NIL)
                                                          (GO #8=#:G978)))))
                                                 (GO #9=#:G972)))))))
                                       #9# (EXIT #1#))
                                      (LETT |r| (|inc_SI| |r|)) (GO G190) G191
                                      (EXIT NIL))))
                               (LETT |k| (+ |k| 1)) (GO G190) G191
                               (EXIT NIL))))
                        (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
            (SPADCALL "algebra is flexible" (QREFELT $ 76)) (EXIT 'T)))
          #8# (EXIT #2#)))) 

(SDEFUN |ALGSC;lieAdmissible?;B;21| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G1000 NIL) (#2=#:G1001 NIL) (|res| (R)) (#3=#:G1006 NIL)
          (|l| NIL) (#4=#:G1005 NIL) (|r| NIL) (#5=#:G1004 NIL) (|k| NIL)
          (#6=#:G1003 NIL) (|j| NIL) (#7=#:G1002 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |i| 1) (LETT #7# (QREFELT $ 7)) G190
                 (COND ((|greater_SI| |i| #7#) (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |j| 1) (LETT #6# (QREFELT $ 7)) G190
                        (COND ((|greater_SI| |j| #6#) (GO G191)))
                        (SEQ
                         (EXIT
                          (SEQ (LETT |k| 1) (LETT #5# (QREFELT $ 7)) G190
                               (COND ((|greater_SI| |k| #5#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (SEQ (LETT |r| 1) (LETT #4# (QREFELT $ 7))
                                      G190
                                      (COND ((|greater_SI| |r| #4#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (SEQ (LETT |res| (|spadConstant| $ 32))
                                             (SEQ (LETT |l| 1)
                                                  (LETT #3# (QREFELT $ 7)) G190
                                                  (COND
                                                   ((|greater_SI| |l| #3#)
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (LETT |res|
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (SPADCALL |res|
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          (QREFELT
                                                                           $ 9)
                                                                          |l|
                                                                          (QREFELT
                                                                           $
                                                                           66))
                                                                         |i|
                                                                         |j|
                                                                         (QREFELT
                                                                          $
                                                                          67))
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          (QREFELT
                                                                           $ 9)
                                                                          |l|
                                                                          (QREFELT
                                                                           $
                                                                           66))
                                                                         |j|
                                                                         |i|
                                                                         (QREFELT
                                                                          $
                                                                          67))
                                                                        (QREFELT
                                                                         $ 73))
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          (QREFELT
                                                                           $ 9)
                                                                          |r|
                                                                          (QREFELT
                                                                           $
                                                                           66))
                                                                         |l|
                                                                         |k|
                                                                         (QREFELT
                                                                          $
                                                                          67))
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          (QREFELT
                                                                           $ 9)
                                                                          |r|
                                                                          (QREFELT
                                                                           $
                                                                           66))
                                                                         |k|
                                                                         |l|
                                                                         (QREFELT
                                                                          $
                                                                          67))
                                                                        (QREFELT
                                                                         $ 73))
                                                                       (QREFELT
                                                                        $ 65))
                                                                      (QREFELT
                                                                       $ 68))
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (SPADCALL
                                                                (QREFELT $ 9)
                                                                |l|
                                                                (QREFELT $ 66))
                                                               |j| |k|
                                                               (QREFELT $ 67))
                                                              (SPADCALL
                                                               (SPADCALL
                                                                (QREFELT $ 9)
                                                                |l|
                                                                (QREFELT $ 66))
                                                               |k| |j|
                                                               (QREFELT $ 67))
                                                              (QREFELT $ 73))
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (SPADCALL
                                                                (QREFELT $ 9)
                                                                |r|
                                                                (QREFELT $ 66))
                                                               |l| |i|
                                                               (QREFELT $ 67))
                                                              (SPADCALL
                                                               (SPADCALL
                                                                (QREFELT $ 9)
                                                                |r|
                                                                (QREFELT $ 66))
                                                               |i| |l|
                                                               (QREFELT $ 67))
                                                              (QREFELT $ 73))
                                                             (QREFELT $ 65))
                                                            (QREFELT $ 68))
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QREFELT $ 9)
                                                               |l|
                                                               (QREFELT $ 66))
                                                              |k| |i|
                                                              (QREFELT $ 67))
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QREFELT $ 9)
                                                               |l|
                                                               (QREFELT $ 66))
                                                              |i| |k|
                                                              (QREFELT $ 67))
                                                             (QREFELT $ 73))
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QREFELT $ 9)
                                                               |r|
                                                               (QREFELT $ 66))
                                                              |l| |j|
                                                              (QREFELT $ 67))
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QREFELT $ 9)
                                                               |r|
                                                               (QREFELT $ 66))
                                                              |j| |l|
                                                              (QREFELT $ 67))
                                                             (QREFELT $ 73))
                                                            (QREFELT $ 65))
                                                           (QREFELT $ 68)))))
                                                  (LETT |l| (|inc_SI| |l|))
                                                  (GO G190) G191 (EXIT NIL))
                                             (EXIT
                                              (COND
                                               ((NULL
                                                 (SPADCALL |res|
                                                           (QREFELT $ 52)))
                                                (PROGN
                                                 (LETT #1#
                                                       (SEQ
                                                        (SPADCALL
                                                         "algebra is not Lie admissible"
                                                         (QREFELT $ 76))
                                                        (EXIT
                                                         (PROGN
                                                          (LETT #2# NIL)
                                                          (GO #8=#:G999)))))
                                                 (GO #9=#:G993)))))))
                                       #9# (EXIT #1#))
                                      (LETT |r| (|inc_SI| |r|)) (GO G190) G191
                                      (EXIT NIL))))
                               (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                               (EXIT NIL))))
                        (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
            (SPADCALL "algebra is Lie admissible" (QREFELT $ 76)) (EXIT 'T)))
          #8# (EXIT #2#)))) 

(SDEFUN |ALGSC;jordanAdmissible?;B;22| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G1030 NIL) (#2=#:G1031 NIL) (|res| (R)) (#3=#:G1038 NIL)
          (|r| NIL) (#4=#:G1037 NIL) (|l| NIL) (#5=#:G1036 NIL) (|t| NIL)
          (#6=#:G1035 NIL) (|w| NIL) (#7=#:G1034 NIL) (|k| NIL)
          (#8=#:G1033 NIL) (|j| NIL) (#9=#:G1032 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (COND
            ((QEQCAR
              (SPADCALL (SPADCALL 2 (|spadConstant| $ 53) (QREFELT $ 86))
                        (QREFELT $ 87))
              1)
             (SEQ
              (SPADCALL
               "this algebra is not Jordan admissible, as 2 is not invertible in the ground ring"
               (QREFELT $ 76))
              (EXIT NIL)))
            ('T
             (SEQ
              (SEQ (LETT |i| 1) (LETT #9# (QREFELT $ 7)) G190
                   (COND ((|greater_SI| |i| #9#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #8# (QREFELT $ 7)) G190
                          (COND ((|greater_SI| |j| #8#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SEQ (LETT |k| 1) (LETT #7# (QREFELT $ 7)) G190
                                 (COND ((|greater_SI| |k| #7#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (SEQ (LETT |w| 1) (LETT #6# (QREFELT $ 7))
                                        G190
                                        (COND
                                         ((|greater_SI| |w| #6#) (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (SEQ (LETT |t| 1)
                                               (LETT #5# (QREFELT $ 7)) G190
                                               (COND
                                                ((|greater_SI| |t| #5#)
                                                 (GO G191)))
                                               (SEQ
                                                (EXIT
                                                 (SEQ
                                                  (LETT |res|
                                                        (|spadConstant| $ 32))
                                                  (SEQ (LETT |l| 1)
                                                       (LETT #4# (QREFELT $ 7))
                                                       G190
                                                       (COND
                                                        ((|greater_SI| |l| #4#)
                                                         (GO G191)))
                                                       (SEQ
                                                        (EXIT
                                                         (SEQ (LETT |r| 1)
                                                              (LETT #3#
                                                                    (QREFELT $
                                                                             7))
                                                              G190
                                                              (COND
                                                               ((|greater_SI|
                                                                 |r| #3#)
                                                                (GO G191)))
                                                              (SEQ
                                                               (EXIT
                                                                (LETT |res|
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            |res|
                                                                            (SPADCALL
                                                                             (SPADCALL
                                                                              (SPADCALL
                                                                               (SPADCALL
                                                                                (SPADCALL
                                                                                 (QREFELT
                                                                                  $
                                                                                  9)
                                                                                 |l|
                                                                                 (QREFELT
                                                                                  $
                                                                                  66))
                                                                                |i|
                                                                                |j|
                                                                                (QREFELT
                                                                                 $
                                                                                 67))
                                                                               (SPADCALL
                                                                                (SPADCALL
                                                                                 (QREFELT
                                                                                  $
                                                                                  9)
                                                                                 |l|
                                                                                 (QREFELT
                                                                                  $
                                                                                  66))
                                                                                |j|
                                                                                |i|
                                                                                (QREFELT
                                                                                 $
                                                                                 67))
                                                                               (QREFELT
                                                                                $
                                                                                68))
                                                                              (SPADCALL
                                                                               (SPADCALL
                                                                                (SPADCALL
                                                                                 (QREFELT
                                                                                  $
                                                                                  9)
                                                                                 |r|
                                                                                 (QREFELT
                                                                                  $
                                                                                  66))
                                                                                |w|
                                                                                |k|
                                                                                (QREFELT
                                                                                 $
                                                                                 67))
                                                                               (SPADCALL
                                                                                (SPADCALL
                                                                                 (QREFELT
                                                                                  $
                                                                                  9)
                                                                                 |r|
                                                                                 (QREFELT
                                                                                  $
                                                                                  66))
                                                                                |k|
                                                                                |w|
                                                                                (QREFELT
                                                                                 $
                                                                                 67))
                                                                               (QREFELT
                                                                                $
                                                                                68))
                                                                              (QREFELT
                                                                               $
                                                                               65))
                                                                             (SPADCALL
                                                                              (SPADCALL
                                                                               (SPADCALL
                                                                                (QREFELT
                                                                                 $
                                                                                 9)
                                                                                |t|
                                                                                (QREFELT
                                                                                 $
                                                                                 66))
                                                                               |l|
                                                                               |r|
                                                                               (QREFELT
                                                                                $
                                                                                67))
                                                                              (SPADCALL
                                                                               (SPADCALL
                                                                                (QREFELT
                                                                                 $
                                                                                 9)
                                                                                |t|
                                                                                (QREFELT
                                                                                 $
                                                                                 66))
                                                                               |r|
                                                                               |l|
                                                                               (QREFELT
                                                                                $
                                                                                67))
                                                                              (QREFELT
                                                                               $
                                                                               68))
                                                                             (QREFELT
                                                                              $
                                                                              65))
                                                                            (QREFELT
                                                                             $
                                                                             68))
                                                                           (SPADCALL
                                                                            (SPADCALL
                                                                             (SPADCALL
                                                                              (SPADCALL
                                                                               (SPADCALL
                                                                                (QREFELT
                                                                                 $
                                                                                 9)
                                                                                |r|
                                                                                (QREFELT
                                                                                 $
                                                                                 66))
                                                                               |w|
                                                                               |k|
                                                                               (QREFELT
                                                                                $
                                                                                67))
                                                                              (SPADCALL
                                                                               (SPADCALL
                                                                                (QREFELT
                                                                                 $
                                                                                 9)
                                                                                |r|
                                                                                (QREFELT
                                                                                 $
                                                                                 66))
                                                                               |k|
                                                                               |w|
                                                                               (QREFELT
                                                                                $
                                                                                67))
                                                                              (QREFELT
                                                                               $
                                                                               68))
                                                                             (SPADCALL
                                                                              (SPADCALL
                                                                               (SPADCALL
                                                                                (QREFELT
                                                                                 $
                                                                                 9)
                                                                                |l|
                                                                                (QREFELT
                                                                                 $
                                                                                 66))
                                                                               |j|
                                                                               |r|
                                                                               (QREFELT
                                                                                $
                                                                                67))
                                                                              (SPADCALL
                                                                               (SPADCALL
                                                                                (QREFELT
                                                                                 $
                                                                                 9)
                                                                                |l|
                                                                                (QREFELT
                                                                                 $
                                                                                 66))
                                                                               |r|
                                                                               |j|
                                                                               (QREFELT
                                                                                $
                                                                                67))
                                                                              (QREFELT
                                                                               $
                                                                               68))
                                                                             (QREFELT
                                                                              $
                                                                              65))
                                                                            (SPADCALL
                                                                             (SPADCALL
                                                                              (SPADCALL
                                                                               (QREFELT
                                                                                $
                                                                                9)
                                                                               |t|
                                                                               (QREFELT
                                                                                $
                                                                                66))
                                                                              |i|
                                                                              |l|
                                                                              (QREFELT
                                                                               $
                                                                               67))
                                                                             (SPADCALL
                                                                              (SPADCALL
                                                                               (QREFELT
                                                                                $
                                                                                9)
                                                                               |t|
                                                                               (QREFELT
                                                                                $
                                                                                66))
                                                                              |l|
                                                                              |i|
                                                                              (QREFELT
                                                                               $
                                                                               67))
                                                                             (QREFELT
                                                                              $
                                                                              68))
                                                                            (QREFELT
                                                                             $
                                                                             65))
                                                                           (QREFELT
                                                                            $
                                                                            73))
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            (SPADCALL
                                                                             (SPADCALL
                                                                              (SPADCALL
                                                                               (QREFELT
                                                                                $
                                                                                9)
                                                                               |l|
                                                                               (QREFELT
                                                                                $
                                                                                66))
                                                                              |w|
                                                                              |j|
                                                                              (QREFELT
                                                                               $
                                                                               67))
                                                                             (SPADCALL
                                                                              (SPADCALL
                                                                               (QREFELT
                                                                                $
                                                                                9)
                                                                               |l|
                                                                               (QREFELT
                                                                                $
                                                                                66))
                                                                              |j|
                                                                              |w|
                                                                              (QREFELT
                                                                               $
                                                                               67))
                                                                             (QREFELT
                                                                              $
                                                                              68))
                                                                            (SPADCALL
                                                                             (SPADCALL
                                                                              (SPADCALL
                                                                               (QREFELT
                                                                                $
                                                                                9)
                                                                               |r|
                                                                               (QREFELT
                                                                                $
                                                                                66))
                                                                              |k|
                                                                              |i|
                                                                              (QREFELT
                                                                               $
                                                                               67))
                                                                             (SPADCALL
                                                                              (SPADCALL
                                                                               (QREFELT
                                                                                $
                                                                                9)
                                                                               |r|
                                                                               (QREFELT
                                                                                $
                                                                                66))
                                                                              |i|
                                                                              |k|
                                                                              (QREFELT
                                                                               $
                                                                               67))
                                                                             (QREFELT
                                                                              $
                                                                              68))
                                                                            (QREFELT
                                                                             $
                                                                             65))
                                                                           (SPADCALL
                                                                            (SPADCALL
                                                                             (SPADCALL
                                                                              (QREFELT
                                                                               $
                                                                               9)
                                                                              |t|
                                                                              (QREFELT
                                                                               $
                                                                               66))
                                                                             |l|
                                                                             |r|
                                                                             (QREFELT
                                                                              $
                                                                              67))
                                                                            (SPADCALL
                                                                             (SPADCALL
                                                                              (QREFELT
                                                                               $
                                                                               9)
                                                                              |t|
                                                                              (QREFELT
                                                                               $
                                                                               66))
                                                                             |r|
                                                                             |l|
                                                                             (QREFELT
                                                                              $
                                                                              67))
                                                                            (QREFELT
                                                                             $
                                                                             68))
                                                                           (QREFELT
                                                                            $
                                                                            65))
                                                                          (QREFELT
                                                                           $
                                                                           68))
                                                                         (SPADCALL
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            (SPADCALL
                                                                             (SPADCALL
                                                                              (QREFELT
                                                                               $
                                                                               9)
                                                                              |r|
                                                                              (QREFELT
                                                                               $
                                                                               66))
                                                                             |k|
                                                                             |i|
                                                                             (QREFELT
                                                                              $
                                                                              67))
                                                                            (SPADCALL
                                                                             (SPADCALL
                                                                              (QREFELT
                                                                               $
                                                                               9)
                                                                              |r|
                                                                              (QREFELT
                                                                               $
                                                                               66))
                                                                             |k|
                                                                             |i|
                                                                             (QREFELT
                                                                              $
                                                                              67))
                                                                            (QREFELT
                                                                             $
                                                                             68))
                                                                           (SPADCALL
                                                                            (SPADCALL
                                                                             (SPADCALL
                                                                              (QREFELT
                                                                               $
                                                                               9)
                                                                              |l|
                                                                              (QREFELT
                                                                               $
                                                                               66))
                                                                             |j|
                                                                             |r|
                                                                             (QREFELT
                                                                              $
                                                                              67))
                                                                            (SPADCALL
                                                                             (SPADCALL
                                                                              (QREFELT
                                                                               $
                                                                               9)
                                                                              |l|
                                                                              (QREFELT
                                                                               $
                                                                               66))
                                                                             |r|
                                                                             |j|
                                                                             (QREFELT
                                                                              $
                                                                              67))
                                                                            (QREFELT
                                                                             $
                                                                             68))
                                                                           (QREFELT
                                                                            $
                                                                            65))
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            (SPADCALL
                                                                             (QREFELT
                                                                              $
                                                                              9)
                                                                             |t|
                                                                             (QREFELT
                                                                              $
                                                                              66))
                                                                            |w|
                                                                            |l|
                                                                            (QREFELT
                                                                             $
                                                                             67))
                                                                           (SPADCALL
                                                                            (SPADCALL
                                                                             (QREFELT
                                                                              $
                                                                              9)
                                                                             |t|
                                                                             (QREFELT
                                                                              $
                                                                              66))
                                                                            |l|
                                                                            |w|
                                                                            (QREFELT
                                                                             $
                                                                             67))
                                                                           (QREFELT
                                                                            $
                                                                            68))
                                                                          (QREFELT
                                                                           $
                                                                           65))
                                                                         (QREFELT
                                                                          $
                                                                          73))
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            (SPADCALL
                                                                             (QREFELT
                                                                              $
                                                                              9)
                                                                             |l|
                                                                             (QREFELT
                                                                              $
                                                                              66))
                                                                            |k|
                                                                            |j|
                                                                            (QREFELT
                                                                             $
                                                                             67))
                                                                           (SPADCALL
                                                                            (SPADCALL
                                                                             (QREFELT
                                                                              $
                                                                              9)
                                                                             |l|
                                                                             (QREFELT
                                                                              $
                                                                              66))
                                                                            |j|
                                                                            |k|
                                                                            (QREFELT
                                                                             $
                                                                             67))
                                                                           (QREFELT
                                                                            $
                                                                            68))
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            (SPADCALL
                                                                             (QREFELT
                                                                              $
                                                                              9)
                                                                             |r|
                                                                             (QREFELT
                                                                              $
                                                                              66))
                                                                            |i|
                                                                            |w|
                                                                            (QREFELT
                                                                             $
                                                                             67))
                                                                           (SPADCALL
                                                                            (SPADCALL
                                                                             (QREFELT
                                                                              $
                                                                              9)
                                                                             |r|
                                                                             (QREFELT
                                                                              $
                                                                              66))
                                                                            |w|
                                                                            |i|
                                                                            (QREFELT
                                                                             $
                                                                             67))
                                                                           (QREFELT
                                                                            $
                                                                            68))
                                                                          (QREFELT
                                                                           $
                                                                           65))
                                                                         (SPADCALL
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            (QREFELT
                                                                             $
                                                                             9)
                                                                            |t|
                                                                            (QREFELT
                                                                             $
                                                                             66))
                                                                           |l|
                                                                           |r|
                                                                           (QREFELT
                                                                            $
                                                                            67))
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            (QREFELT
                                                                             $
                                                                             9)
                                                                            |t|
                                                                            (QREFELT
                                                                             $
                                                                             66))
                                                                           |r|
                                                                           |l|
                                                                           (QREFELT
                                                                            $
                                                                            67))
                                                                          (QREFELT
                                                                           $
                                                                           68))
                                                                         (QREFELT
                                                                          $
                                                                          65))
                                                                        (QREFELT
                                                                         $ 68))
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            (QREFELT
                                                                             $
                                                                             9)
                                                                            |r|
                                                                            (QREFELT
                                                                             $
                                                                             66))
                                                                           |i|
                                                                           |w|
                                                                           (QREFELT
                                                                            $
                                                                            67))
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            (QREFELT
                                                                             $
                                                                             9)
                                                                            |r|
                                                                            (QREFELT
                                                                             $
                                                                             66))
                                                                           |w|
                                                                           |i|
                                                                           (QREFELT
                                                                            $
                                                                            67))
                                                                          (QREFELT
                                                                           $
                                                                           68))
                                                                         (SPADCALL
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            (QREFELT
                                                                             $
                                                                             9)
                                                                            |l|
                                                                            (QREFELT
                                                                             $
                                                                             66))
                                                                           |j|
                                                                           |r|
                                                                           (QREFELT
                                                                            $
                                                                            67))
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            (QREFELT
                                                                             $
                                                                             9)
                                                                            |l|
                                                                            (QREFELT
                                                                             $
                                                                             66))
                                                                           |r|
                                                                           |j|
                                                                           (QREFELT
                                                                            $
                                                                            67))
                                                                          (QREFELT
                                                                           $
                                                                           68))
                                                                         (QREFELT
                                                                          $
                                                                          65))
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          (SPADCALL
                                                                           (QREFELT
                                                                            $
                                                                            9)
                                                                           |t|
                                                                           (QREFELT
                                                                            $
                                                                            66))
                                                                          |k|
                                                                          |l|
                                                                          (QREFELT
                                                                           $
                                                                           67))
                                                                         (SPADCALL
                                                                          (SPADCALL
                                                                           (QREFELT
                                                                            $
                                                                            9)
                                                                           |t|
                                                                           (QREFELT
                                                                            $
                                                                            66))
                                                                          |l|
                                                                          |k|
                                                                          (QREFELT
                                                                           $
                                                                           67))
                                                                         (QREFELT
                                                                          $
                                                                          68))
                                                                        (QREFELT
                                                                         $ 65))
                                                                       (QREFELT
                                                                        $
                                                                        73)))))
                                                              (LETT |r|
                                                                    (|inc_SI|
                                                                     |r|))
                                                              (GO G190) G191
                                                              (EXIT NIL))))
                                                       (LETT |l|
                                                             (|inc_SI| |l|))
                                                       (GO G190) G191
                                                       (EXIT NIL))
                                                  (EXIT
                                                   (COND
                                                    ((NULL
                                                      (SPADCALL |res|
                                                                (QREFELT $
                                                                         52)))
                                                     (PROGN
                                                      (LETT #1#
                                                            (SEQ
                                                             (SPADCALL
                                                              "algebra is not Jordan admissible"
                                                              (QREFELT $ 76))
                                                             (EXIT
                                                              (PROGN
                                                               (LETT #2# NIL)
                                                               (GO
                                                                #10=#:G1029)))))
                                                      (GO #11=#:G1021)))))))
                                                #11# (EXIT #1#))
                                               (LETT |t| (|inc_SI| |t|))
                                               (GO G190) G191 (EXIT NIL))))
                                        (LETT |w| (|inc_SI| |w|)) (GO G190)
                                        G191 (EXIT NIL))))
                                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (SPADCALL "algebra is Jordan admissible" (QREFELT $ 76))
              (EXIT 'T)))))
          #10# (EXIT #2#)))) 

(SDEFUN |ALGSC;jordanAlgebra?;B;23| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G1064 NIL) (#2=#:G1065 NIL) (|res| (R)) (#3=#:G1072 NIL)
          (|s| NIL) (#4=#:G1071 NIL) (|r| NIL) (#5=#:G1070 NIL) (|t| NIL)
          (#6=#:G1069 NIL) (|l| NIL) (#7=#:G1068 NIL) (|k| NIL)
          (#8=#:G1067 NIL) (|j| NIL) (#9=#:G1066 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (COND
            ((QEQCAR
              (SPADCALL (SPADCALL 2 (|spadConstant| $ 53) (QREFELT $ 86))
                        (QREFELT $ 87))
              1)
             (SEQ
              (SPADCALL
               "this is not a Jordan algebra, as 2 is not invertible in the ground ring"
               (QREFELT $ 76))
              (EXIT NIL)))
            ((SPADCALL (QREFELT $ 80))
             (SEQ
              (SEQ (LETT |i| 1) (LETT #9# (QREFELT $ 7)) G190
                   (COND ((|greater_SI| |i| #9#) (GO G191)))
                   (SEQ
                    (EXIT
                     (SEQ (LETT |j| 1) (LETT #8# (QREFELT $ 7)) G190
                          (COND ((|greater_SI| |j| #8#) (GO G191)))
                          (SEQ
                           (EXIT
                            (SEQ (LETT |k| 1) (LETT #7# (QREFELT $ 7)) G190
                                 (COND ((|greater_SI| |k| #7#) (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (SEQ (LETT |l| 1) (LETT #6# (QREFELT $ 7))
                                        G190
                                        (COND
                                         ((|greater_SI| |l| #6#) (GO G191)))
                                        (SEQ
                                         (EXIT
                                          (SEQ (LETT |t| 1)
                                               (LETT #5# (QREFELT $ 7)) G190
                                               (COND
                                                ((|greater_SI| |t| #5#)
                                                 (GO G191)))
                                               (SEQ
                                                (LETT |res|
                                                      (|spadConstant| $ 32))
                                                (EXIT
                                                 (SEQ (LETT |r| 1)
                                                      (LETT #4# (QREFELT $ 7))
                                                      G190
                                                      (COND
                                                       ((|greater_SI| |r| #4#)
                                                        (GO G191)))
                                                      (SEQ
                                                       (EXIT
                                                        (SEQ (LETT |s| 1)
                                                             (LETT #3#
                                                                   (QREFELT $
                                                                            7))
                                                             G190
                                                             (COND
                                                              ((|greater_SI|
                                                                |s| #3#)
                                                               (GO G191)))
                                                             (SEQ
                                                              (EXIT
                                                               (SEQ
                                                                (LETT |res|
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            |res|
                                                                            (SPADCALL
                                                                             (SPADCALL
                                                                              (SPADCALL
                                                                               (SPADCALL
                                                                                (QREFELT
                                                                                 $
                                                                                 9)
                                                                                |r|
                                                                                (QREFELT
                                                                                 $
                                                                                 66))
                                                                               |i|
                                                                               |j|
                                                                               (QREFELT
                                                                                $
                                                                                67))
                                                                              (SPADCALL
                                                                               (SPADCALL
                                                                                (QREFELT
                                                                                 $
                                                                                 9)
                                                                                |s|
                                                                                (QREFELT
                                                                                 $
                                                                                 66))
                                                                               |l|
                                                                               |k|
                                                                               (QREFELT
                                                                                $
                                                                                67))
                                                                              (QREFELT
                                                                               $
                                                                               65))
                                                                             (SPADCALL
                                                                              (SPADCALL
                                                                               (QREFELT
                                                                                $
                                                                                9)
                                                                               |t|
                                                                               (QREFELT
                                                                                $
                                                                                66))
                                                                              |r|
                                                                              |s|
                                                                              (QREFELT
                                                                               $
                                                                               67))
                                                                             (QREFELT
                                                                              $
                                                                              65))
                                                                            (QREFELT
                                                                             $
                                                                             68))
                                                                           (SPADCALL
                                                                            (SPADCALL
                                                                             (SPADCALL
                                                                              (SPADCALL
                                                                               (QREFELT
                                                                                $
                                                                                9)
                                                                               |r|
                                                                               (QREFELT
                                                                                $
                                                                                66))
                                                                              |l|
                                                                              |k|
                                                                              (QREFELT
                                                                               $
                                                                               67))
                                                                             (SPADCALL
                                                                              (SPADCALL
                                                                               (QREFELT
                                                                                $
                                                                                9)
                                                                               |s|
                                                                               (QREFELT
                                                                                $
                                                                                66))
                                                                              |j|
                                                                              |r|
                                                                              (QREFELT
                                                                               $
                                                                               67))
                                                                             (QREFELT
                                                                              $
                                                                              65))
                                                                            (SPADCALL
                                                                             (SPADCALL
                                                                              (QREFELT
                                                                               $
                                                                               9)
                                                                              |t|
                                                                              (QREFELT
                                                                               $
                                                                               66))
                                                                             |i|
                                                                             |s|
                                                                             (QREFELT
                                                                              $
                                                                              67))
                                                                            (QREFELT
                                                                             $
                                                                             65))
                                                                           (QREFELT
                                                                            $
                                                                            73))
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            (SPADCALL
                                                                             (SPADCALL
                                                                              (QREFELT
                                                                               $
                                                                               9)
                                                                              |r|
                                                                              (QREFELT
                                                                               $
                                                                               66))
                                                                             |l|
                                                                             |j|
                                                                             (QREFELT
                                                                              $
                                                                              67))
                                                                            (SPADCALL
                                                                             (SPADCALL
                                                                              (QREFELT
                                                                               $
                                                                               9)
                                                                              |s|
                                                                              (QREFELT
                                                                               $
                                                                               66))
                                                                             |k|
                                                                             |k|
                                                                             (QREFELT
                                                                              $
                                                                              67))
                                                                            (QREFELT
                                                                             $
                                                                             65))
                                                                           (SPADCALL
                                                                            (SPADCALL
                                                                             (QREFELT
                                                                              $
                                                                              9)
                                                                             |t|
                                                                             (QREFELT
                                                                              $
                                                                              66))
                                                                            |r|
                                                                            |s|
                                                                            (QREFELT
                                                                             $
                                                                             67))
                                                                           (QREFELT
                                                                            $
                                                                            65))
                                                                          (QREFELT
                                                                           $
                                                                           68))
                                                                         (SPADCALL
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            (SPADCALL
                                                                             (QREFELT
                                                                              $
                                                                              9)
                                                                             |r|
                                                                             (QREFELT
                                                                              $
                                                                              66))
                                                                            |k|
                                                                            |i|
                                                                            (QREFELT
                                                                             $
                                                                             67))
                                                                           (SPADCALL
                                                                            (SPADCALL
                                                                             (QREFELT
                                                                              $
                                                                              9)
                                                                             |s|
                                                                             (QREFELT
                                                                              $
                                                                              66))
                                                                            |j|
                                                                            |r|
                                                                            (QREFELT
                                                                             $
                                                                             67))
                                                                           (QREFELT
                                                                            $
                                                                            65))
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            (QREFELT
                                                                             $
                                                                             9)
                                                                            |t|
                                                                            (QREFELT
                                                                             $
                                                                             66))
                                                                           |l|
                                                                           |s|
                                                                           (QREFELT
                                                                            $
                                                                            67))
                                                                          (QREFELT
                                                                           $
                                                                           65))
                                                                         (QREFELT
                                                                          $
                                                                          73))
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            (QREFELT
                                                                             $
                                                                             9)
                                                                            |r|
                                                                            (QREFELT
                                                                             $
                                                                             66))
                                                                           |k|
                                                                           |j|
                                                                           (QREFELT
                                                                            $
                                                                            67))
                                                                          (SPADCALL
                                                                           (SPADCALL
                                                                            (QREFELT
                                                                             $
                                                                             9)
                                                                            |s|
                                                                            (QREFELT
                                                                             $
                                                                             66))
                                                                           |i|
                                                                           |k|
                                                                           (QREFELT
                                                                            $
                                                                            67))
                                                                          (QREFELT
                                                                           $
                                                                           65))
                                                                         (SPADCALL
                                                                          (SPADCALL
                                                                           (QREFELT
                                                                            $
                                                                            9)
                                                                           |t|
                                                                           (QREFELT
                                                                            $
                                                                            66))
                                                                          |r|
                                                                          |s|
                                                                          (QREFELT
                                                                           $
                                                                           67))
                                                                         (QREFELT
                                                                          $
                                                                          65))
                                                                        (QREFELT
                                                                         $ 68))
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          (SPADCALL
                                                                           (QREFELT
                                                                            $
                                                                            9)
                                                                           |r|
                                                                           (QREFELT
                                                                            $
                                                                            66))
                                                                          |i|
                                                                          |l|
                                                                          (QREFELT
                                                                           $
                                                                           67))
                                                                         (SPADCALL
                                                                          (SPADCALL
                                                                           (QREFELT
                                                                            $
                                                                            9)
                                                                           |s|
                                                                           (QREFELT
                                                                            $
                                                                            66))
                                                                          |j|
                                                                          |r|
                                                                          (QREFELT
                                                                           $
                                                                           67))
                                                                         (QREFELT
                                                                          $
                                                                          65))
                                                                        (SPADCALL
                                                                         (SPADCALL
                                                                          (QREFELT
                                                                           $ 9)
                                                                          |t|
                                                                          (QREFELT
                                                                           $
                                                                           66))
                                                                         |k|
                                                                         |s|
                                                                         (QREFELT
                                                                          $
                                                                          67))
                                                                        (QREFELT
                                                                         $ 65))
                                                                       (QREFELT
                                                                        $ 73)))
                                                                (EXIT
                                                                 (COND
                                                                  ((NULL
                                                                    (SPADCALL
                                                                     |res|
                                                                     (QREFELT $
                                                                              52)))
                                                                   (PROGN
                                                                    (LETT #1#
                                                                          (SEQ
                                                                           (SPADCALL
                                                                            "this is not a Jordan algebra"
                                                                            (QREFELT
                                                                             $
                                                                             76))
                                                                           (EXIT
                                                                            (PROGN
                                                                             (LETT
                                                                              #2#
                                                                              NIL)
                                                                             (GO
                                                                              #10=#:G1063)))))
                                                                    (GO
                                                                     #11=#:G1051)))))))
                                                              #11# (EXIT #1#))
                                                             (LETT |s|
                                                                   (|inc_SI|
                                                                    |s|))
                                                             (GO G190) G191
                                                             (EXIT NIL))))
                                                      (LETT |r| (|inc_SI| |r|))
                                                      (GO G190) G191
                                                      (EXIT NIL))))
                                               (LETT |t| (|inc_SI| |t|))
                                               (GO G190) G191 (EXIT NIL))))
                                        (LETT |l| (|inc_SI| |l|)) (GO G190)
                                        G191 (EXIT NIL))))
                                 (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                                 (EXIT NIL))))
                          (LETT |j| (|inc_SI| |j|)) (GO G190) G191
                          (EXIT NIL))))
                   (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
              (SPADCALL "this is a Jordan algebra" (QREFELT $ 76)) (EXIT 'T)))
            ('T
             (SEQ (SPADCALL "this is not a Jordan algebra" (QREFELT $ 76))
                  (EXIT NIL)))))
          #10# (EXIT #2#)))) 

(SDEFUN |ALGSC;jacobiIdentity?;B;24| (($ (|Boolean|)))
        (SPROG
         ((#1=#:G1087 NIL) (#2=#:G1088 NIL) (|res| (R)) (#3=#:G1093 NIL)
          (|s| NIL) (#4=#:G1092 NIL) (|r| NIL) (#5=#:G1091 NIL) (|k| NIL)
          (#6=#:G1090 NIL) (|j| NIL) (#7=#:G1089 NIL) (|i| NIL))
         (SEQ
          (EXIT
           (SEQ
            (SEQ (LETT |i| 1) (LETT #7# (QREFELT $ 7)) G190
                 (COND ((|greater_SI| |i| #7#) (GO G191)))
                 (SEQ
                  (EXIT
                   (SEQ (LETT |j| 1) (LETT #6# (QREFELT $ 7)) G190
                        (COND ((|greater_SI| |j| #6#) (GO G191)))
                        (SEQ
                         (EXIT
                          (SEQ (LETT |k| 1) (LETT #5# (QREFELT $ 7)) G190
                               (COND ((|greater_SI| |k| #5#) (GO G191)))
                               (SEQ
                                (EXIT
                                 (SEQ (LETT |r| 1) (LETT #4# (QREFELT $ 7))
                                      G190
                                      (COND ((|greater_SI| |r| #4#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (SEQ (LETT |res| (|spadConstant| $ 32))
                                             (SEQ (LETT |s| 1)
                                                  (LETT #3# (QREFELT $ 7)) G190
                                                  (COND
                                                   ((|greater_SI| |s| #3#)
                                                    (GO G191)))
                                                  (SEQ
                                                   (EXIT
                                                    (LETT |res|
                                                          (SPADCALL
                                                           (SPADCALL
                                                            (SPADCALL |res|
                                                                      (SPADCALL
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         (QREFELT
                                                                          $ 9)
                                                                         |r|
                                                                         (QREFELT
                                                                          $
                                                                          66))
                                                                        |i| |j|
                                                                        (QREFELT
                                                                         $ 67))
                                                                       (SPADCALL
                                                                        (SPADCALL
                                                                         (QREFELT
                                                                          $ 9)
                                                                         |s|
                                                                         (QREFELT
                                                                          $
                                                                          66))
                                                                        |j| |k|
                                                                        (QREFELT
                                                                         $ 67))
                                                                       (QREFELT
                                                                        $ 65))
                                                                      (QREFELT
                                                                       $ 68))
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QREFELT $ 9)
                                                               |r|
                                                               (QREFELT $ 66))
                                                              |j| |k|
                                                              (QREFELT $ 67))
                                                             (SPADCALL
                                                              (SPADCALL
                                                               (QREFELT $ 9)
                                                               |s|
                                                               (QREFELT $ 66))
                                                              |k| |i|
                                                              (QREFELT $ 67))
                                                             (QREFELT $ 65))
                                                            (QREFELT $ 68))
                                                           (SPADCALL
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 9) |r|
                                                              (QREFELT $ 66))
                                                             |k| |i|
                                                             (QREFELT $ 67))
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (QREFELT $ 9) |s|
                                                              (QREFELT $ 66))
                                                             |i| |j|
                                                             (QREFELT $ 67))
                                                            (QREFELT $ 65))
                                                           (QREFELT $ 68)))))
                                                  (LETT |s| (|inc_SI| |s|))
                                                  (GO G190) G191 (EXIT NIL))
                                             (EXIT
                                              (COND
                                               ((NULL
                                                 (SPADCALL |res|
                                                           (QREFELT $ 52)))
                                                (PROGN
                                                 (LETT #1#
                                                       (SEQ
                                                        (SPADCALL
                                                         "Jacobi identity does not hold"
                                                         (QREFELT $ 76))
                                                        (EXIT
                                                         (PROGN
                                                          (LETT #2# NIL)
                                                          (GO #8=#:G1086)))))
                                                 (GO #9=#:G1080)))))))
                                       #9# (EXIT #1#))
                                      (LETT |r| (|inc_SI| |r|)) (GO G190) G191
                                      (EXIT NIL))))
                               (LETT |k| (|inc_SI| |k|)) (GO G190) G191
                               (EXIT NIL))))
                        (LETT |j| (|inc_SI| |j|)) (GO G190) G191 (EXIT NIL))))
                 (LETT |i| (|inc_SI| |i|)) (GO G190) G191 (EXIT NIL))
            (SPADCALL "Jacobi identity holds" (QREFELT $ 76)) (EXIT 'T)))
          #8# (EXIT #2#)))) 

(DECLAIM (NOTINLINE |AlgebraGivenByStructuralConstants;|)) 

(DEFUN |AlgebraGivenByStructuralConstants| (&REST #1=#:G1102)
  (SPROG NIL
         (PROG (#2=#:G1103)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction|
                     (|devaluate_sig| #1# '(T NIL NIL NIL))
                     (HGET |$ConstructorCache|
                           '|AlgebraGivenByStructuralConstants|)
                     '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY (|function| |AlgebraGivenByStructuralConstants;|)
                             #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|AlgebraGivenByStructuralConstants|)))))))))) 

(DEFUN |AlgebraGivenByStructuralConstants;| (|#1| |#2| |#3| |#4|)
  (SPROG
   ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$4 NIL) (DV$3 NIL) (DV$2 NIL)
    (DV$1 NIL))
   (PROGN
    (LETT DV$1 (|devaluate| |#1|))
    (LETT DV$2 |#2|)
    (LETT DV$3 |#3|)
    (LETT DV$4 |#4|)
    (LETT |dv$|
          (LIST '|AlgebraGivenByStructuralConstants| DV$1 DV$2 DV$3 DV$4))
    (LETT $ (GETREFV 101))
    (QSETREFV $ 0 |dv$|)
    (QSETREFV $ 3
              (LETT |pv$|
                    (|buildPredVector| 0 0
                                       (LIST
                                        (|HasCategory| |#1|
                                                       '(|IntegralDomain|))
                                        (|HasCategory| |#1| '(|Finite|))
                                        (|HasCategory| |#1| '(|Field|))))))
    (|haddProp| |$ConstructorCache| '|AlgebraGivenByStructuralConstants|
                (LIST DV$1 DV$2 DV$3 DV$4) (CONS 1 $))
    (|stuffDomainSlots| $)
    (QSETREFV $ 6 |#1|)
    (QSETREFV $ 7 |#2|)
    (QSETREFV $ 8 |#3|)
    (QSETREFV $ 9 |#4|)
    (SETF |pv$| (QREFELT $ 3))
    (QSETREFV $ 10 (|DirectProduct| |#2| |#1|))
    $))) 

(MAKEPROP '|AlgebraGivenByStructuralConstants| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL (|DirectProduct| (NRTEVAL (QREFELT $ 7)) 6)
              (|local| |#1|) (|local| |#2|) (|local| |#3|) (|local| |#4|)
              '|Rep| (|Union| $ '"failed")
              (|FiniteRankNonAssociativeAlgebra&| $$ 6) (0 . |recip|)
              |ALGSC;recip;$U;1| (|Matrix| 6)
              (|SquareMatrix| (NRTEVAL (QREFELT $ 7)) 6) (5 . |coerce|)
              (10 . |apply|) |ALGSC;*;Sm2$;2| (|Vector| 6)
              (16 . |directProduct|) |ALGSC;coerce;V$;3| (|Vector| 15)
              |ALGSC;structuralConstants;V;4| (|List| 6) (21 . |entries|)
              (26 . |vector|) |ALGSC;coordinates;$V;5| (|Integer|)
              (|Vector| $$) (31 . |maxIndex|) (36 . |Zero|) (40 . |elt|)
              (46 . |setColumn!|) (|Union| 20 '"failed")
              (|Record| (|:| |particular| 35) (|:| |basis| 97))
              (|LinearSystemMatrixPackage| 6 20 20 15) (53 . |solve|)
              (|Vector| $) |ALGSC;basis;V;7| |ALGSC;coordinates;$VV;6|
              (|PositiveInteger|) (59 . |unitVector|) |ALGSC;someBasis;V;8|
              |ALGSC;rank;Pi;9| (64 . |elt|) |ALGSC;elt;$IR;10| (|Boolean|)
              (70 . |zero?|) (|OutputForm|) (75 . |coerce|) (80 . |zero?|)
              (85 . |One|) (89 . =) (|Symbol|) (|List| 55) (95 . |elt|)
              (101 . |coerce|) (106 . *) (112 . +) (|Mapping| 50 50 50)
              (|List| 50) (118 . |reduce|) |ALGSC;coerce;$Of;11| (124 . *)
              (130 . |elt|) (136 . |elt|) (143 . +) (149 . |setelt!|)
              |ALGSC;*;3$;12| (|NonNegativeInteger|) (156 . -) (162 . -)
              (|Void|) (|String|) (168 . |messagePrint|)
              |ALGSC;alternative?;B;13| |ALGSC;associative?;B;14|
              |ALGSC;antiAssociative?;B;15| |ALGSC;commutative?;B;16|
              |ALGSC;antiCommutative?;B;17| |ALGSC;leftAlternative?;B;18|
              |ALGSC;rightAlternative?;B;19| |ALGSC;flexible?;B;20|
              |ALGSC;lieAdmissible?;B;21| (173 . *) (179 . |recip|)
              |ALGSC;jordanAdmissible?;B;22| |ALGSC;jordanAlgebra?;B;23|
              |ALGSC;jacobiIdentity?;B;24|
              (|SparseUnivariatePolynomial| (|Polynomial| 6)) (|List| $)
              (|InputForm|) (|Record| (|:| |particular| $) (|:| |basis| 92))
              (|Union| 94 '"failed") (|SparseUnivariatePolynomial| 6)
              (|List| 20) (|List| (|Polynomial| 6)) (|HashState|)
              (|SingleInteger|))
           '#(~= 184 |zero?| 190 |unit| 195 |subtractIfCan| 199
              |structuralConstants| 205 |someBasis| 214 |smaller?| 218 |size|
              224 |sample| 228 |rightUnits| 232 |rightUnit| 236
              |rightTraceMatrix| 240 |rightTrace| 249
              |rightRegularRepresentation| 254 |rightRecip| 265
              |rightRankPolynomial| 270 |rightPower| 274 |rightNorm| 280
              |rightMinimalPolynomial| 285 |rightDiscriminant| 290
              |rightCharacteristicPolynomial| 299 |rightAlternative?| 304
              |represents| 308 |recip| 319 |rank| 324 |random| 328
              |powerAssociative?| 332 |plenaryPower| 336 |opposite?| 342
              |noncommutativeJordanAlgebra?| 348 |lookup| 352 |lieAlgebra?| 357
              |lieAdmissible?| 361 |leftUnits| 365 |leftUnit| 369
              |leftTraceMatrix| 373 |leftTrace| 382 |leftRegularRepresentation|
              387 |leftRecip| 398 |leftRankPolynomial| 403 |leftPower| 407
              |leftNorm| 413 |leftMinimalPolynomial| 418 |leftDiscriminant| 423
              |leftCharacteristicPolynomial| 432 |leftAlternative?| 437 |latex|
              441 |jordanAlgebra?| 446 |jordanAdmissible?| 450
              |jacobiIdentity?| 454 |index| 458 |hashUpdate!| 463 |hash| 469
              |flexible?| 474 |enumerate| 478 |elt| 482 |coordinates| 488
              |convert| 510 |conditionsForIdempotents| 525 |commutator| 534
              |commutative?| 540 |coerce| 544 |basis| 554
              |associatorDependence| 558 |associator| 562 |associative?| 569
              |apply| 573 |antiCommutator| 579 |antiCommutative?| 585
              |antiAssociative?| 589 |alternative?| 593 ^ 597 |Zero| 603 = 607
              - 613 + 624 * 630)
           'NIL
           (CONS
            (|makeByteWordVec2| 2
                                '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 2 0 0 2 0 0 0 1
                                  2))
            (CONS
             '#(|FramedNonAssociativeAlgebra&|
                |FiniteRankNonAssociativeAlgebra&| |NonAssociativeAlgebra&|
                |Module&| |FramedModule&| NIL |NonAssociativeRng&| NIL NIL NIL
                |AbelianGroup&| NIL |NonAssociativeSemiRng&| |AbelianMonoid&|
                |Finite&| |AbelianSemiGroup&| |Magma&| NIL |SetCategory&|
                |BasicType&| NIL NIL NIL)
             (CONS
              '#((|FramedNonAssociativeAlgebra| 6)
                 (|FiniteRankNonAssociativeAlgebra| 6)
                 (|NonAssociativeAlgebra| 6) (|Module| 6) (|FramedModule| 6)
                 (|BiModule| 6 6) (|NonAssociativeRng|)
                 (|LeftModule| (|SquareMatrix| 7 6)) (|RightModule| 6)
                 (|LeftModule| 6) (|AbelianGroup|)
                 (|CancellationAbelianMonoid|) (|NonAssociativeSemiRng|)
                 (|AbelianMonoid|) (|Finite|) (|AbelianSemiGroup|) (|Magma|)
                 (|Comparable|) (|SetCategory|) (|BasicType|)
                 (|CoercibleTo| 50) (|unitsKnown|) (|ConvertibleTo| 93))
              (|makeByteWordVec2| 100
                                  '(1 12 11 0 13 1 16 15 0 17 2 0 0 15 0 18 1
                                    10 0 20 21 1 10 25 0 26 1 20 0 25 27 1 30
                                    29 0 31 0 6 0 32 2 30 2 0 29 33 3 15 0 0 29
                                    20 34 2 37 36 15 20 38 1 10 0 42 43 2 10 6
                                    0 29 46 1 10 48 0 49 1 6 50 0 51 1 6 48 0
                                    52 0 6 0 53 2 6 48 0 0 54 2 56 55 0 29 57 1
                                    55 50 0 58 2 50 0 0 0 59 2 50 0 0 0 60 2 62
                                    50 61 0 63 2 6 0 0 0 65 2 23 15 0 29 66 3
                                    15 6 0 29 29 67 2 6 0 0 0 68 3 20 6 0 29 6
                                    69 2 71 0 0 0 72 2 6 0 0 0 73 1 50 74 75 76
                                    2 6 0 42 0 86 1 6 11 0 87 2 0 48 0 0 1 1 0
                                    48 0 1 0 1 11 1 2 0 11 0 0 1 0 0 23 24 1 0
                                    23 39 1 0 0 39 44 2 2 48 0 0 1 0 2 71 1 0 0
                                    0 1 0 1 95 1 0 1 11 1 0 0 15 1 1 0 15 39 1
                                    1 0 6 0 1 1 0 15 0 1 2 0 15 0 39 1 1 1 11 0
                                    1 0 3 91 1 2 0 0 0 42 1 1 0 6 0 1 1 1 96 0
                                    1 0 0 6 1 1 0 6 39 1 1 0 96 0 1 0 0 48 83 1
                                    0 0 20 1 2 0 0 20 39 1 1 1 11 0 14 0 0 42
                                    45 0 2 0 1 0 0 48 1 2 0 0 0 42 1 2 0 48 0 0
                                    1 0 0 48 1 1 2 42 0 1 0 0 48 1 0 0 48 85 0
                                    1 95 1 0 1 11 1 0 0 15 1 1 0 15 39 1 1 0 6
                                    0 1 1 0 15 0 1 2 0 15 0 39 1 1 1 11 0 1 0 3
                                    91 1 2 0 0 0 42 1 1 0 6 0 1 1 1 96 0 1 0 0
                                    6 1 1 0 6 39 1 1 0 96 0 1 0 0 48 82 1 0 75
                                    0 1 0 0 48 89 0 0 48 88 0 0 48 90 1 2 0 42
                                    1 2 0 99 99 0 1 1 0 100 0 1 0 0 48 84 0 2
                                    92 1 2 0 6 0 29 47 1 0 20 0 28 1 0 15 39 1
                                    2 0 15 39 39 1 2 0 20 0 39 41 1 2 93 0 1 1
                                    0 20 0 1 1 0 0 20 1 0 0 98 1 1 0 98 39 1 2
                                    0 0 0 0 1 0 0 48 80 1 0 0 20 22 1 0 50 0 64
                                    0 0 39 40 0 1 97 1 3 0 0 0 0 0 1 0 0 48 78
                                    2 0 0 15 0 18 2 0 0 0 0 1 0 0 48 81 0 0 48
                                    79 0 0 48 77 2 0 0 0 42 1 0 0 0 1 2 0 48 0
                                    0 1 1 0 0 0 1 2 0 0 0 0 1 2 0 0 0 0 1 2 0 0
                                    16 0 19 2 0 0 6 0 1 2 0 0 0 6 1 2 0 0 71 0
                                    1 2 0 0 29 0 1 2 0 0 0 0 70 2 0 0 42 0
                                    1)))))
           '|lookupComplete|)) 
